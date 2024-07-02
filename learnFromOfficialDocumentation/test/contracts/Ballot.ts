import hre, { ethers } from "hardhat";
import { expect } from "chai";
import { loadFixture } from "@nomicfoundation/hardhat-network-helpers";

describe("Ballot", function () {
  const proposalNames: string[] = ["Proposal1", "Proposal2", "Proposal3"];
  const proposalNamesAsBytes32 = proposalNames.map((proposalName) =>
    ethers.encodeBytes32String(proposalName)
  );
  const random = ethers.Wallet.createRandom();
  const randomAddress = random.address;

  async function deployBallotFixture() {
    const [deployer, otherAccount, thirdAccount] = await ethers.getSigners();
    const Ballot = await hre.ethers.getContractFactory("Ballot");
    const ballot = await Ballot.deploy(proposalNamesAsBytes32);
    await ballot.waitForDeployment();

    return { ballot, deployer, otherAccount, thirdAccount };
  }

  describe("#constructor", function () {
    context("when proposals given is empty", function () {
      it("reverts and does not allow deployment", async function () {
        const Ballot = await hre.ethers.getContractFactory("Ballot");

        await expect(Ballot.deploy([])).to.be.revertedWith(
          "The ballot requires at least 1 proposal"
        );
      });
    });

    it("sets the chairperson to be the address who deploys the contract", async function () {
      const { ballot, deployer } = await loadFixture(deployBallotFixture);

      const chairperson = await ballot.chairperson();

      expect(chairperson).to.equal(deployer.address);
    });

    it("sets the weight for the chairperson to be 1", async function () {
      const { ballot, deployer } = await loadFixture(deployBallotFixture);

      const voter = await ballot.voters(deployer.address);
      expect(voter.weight).to.equal(1);
    });

    it("initializes the proposals", async function () {
      const { ballot } = await loadFixture(deployBallotFixture);

      for (let i = 0; i < proposalNames.length; i++) {
        const proposal = await ballot.proposals(i);
        const proposalNameFound = ethers.decodeBytes32String(proposal.name);
        expect(proposalNameFound).to.equal(proposalNames[i]);
        expect(proposal.voteCount).to.equal(0);
      }
    });
  });

  describe("#giveRightToMove", function () {
    context("when it is not called by the chairperson", function () {
      it("reverts", async function () {
        const { ballot, otherAccount } = await loadFixture(deployBallotFixture);

        await expect(
          ballot.connect(otherAccount).giveRightToVote(randomAddress)
        ).to.be.revertedWith("Only chairperson can give right to vote.");
      });
    });

    context("when voter has already voted", async function () {
      it("reverts", async function () {
        const { ballot, otherAccount } = await loadFixture(deployBallotFixture);
        // setup
        await ballot.giveRightToVote(otherAccount);
        await ballot.connect(otherAccount).vote(0);

        // fire
        await expect(ballot.giveRightToVote(otherAccount)).to.be.revertedWith(
          "Voter should not have already voted"
        );
      });
    });

    context("when voter does not have voting weight equal to 0", function () {
      it("reverts", async function () {
        const { ballot, otherAccount } = await loadFixture(deployBallotFixture);
        // setup
        await ballot.giveRightToVote(otherAccount);
        await ballot.delegate(otherAccount);

        // fire
        await expect(ballot.giveRightToVote(otherAccount)).to.be.revertedWith(
          "Voter should have voting weight equal to 0"
        );
      });
    });

    it("gives the address given the right to vote", async function () {
      const { ballot, otherAccount } = await loadFixture(deployBallotFixture);

      // fire
      await ballot.giveRightToVote(otherAccount);

      // test
      const voter = await ballot.voters(otherAccount);

      expect(voter.voted).to.equal(false);
      expect(voter.weight).to.equal(1);
    });
  });

  describe("#delegate", function () {
    context("when the delegator does not have the right to vote", function () {
      it("reverts", async function () {
        const { ballot, otherAccount, thirdAccount } = await loadFixture(
          deployBallotFixture
        );

        await expect(
          ballot.connect(thirdAccount).delegate(otherAccount)
        ).to.be.revertedWith("You have no right to vote");
      });
    });

    context("when the delegator has already voted", function () {
      it("reverts", async function () {
        const { ballot, otherAccount } = await loadFixture(deployBallotFixture);

        // setup
        await ballot.vote(0);

        // fire
        await expect(ballot.delegate(otherAccount)).to.be.revertedWith(
          "You have already voted"
        );
      });
    });

    context("when the delegator is delegating to themselves", function () {
      it("reverts", async function () {
        const { ballot, deployer } = await loadFixture(deployBallotFixture);

        await expect(ballot.delegate(deployer)).to.be.revertedWith(
          "Self-delegation is not allowed"
        );
      });
    });

    context("when there is a loop in delegation", function () {
      it("reverts", async function () {
        const { ballot, deployer, otherAccount, thirdAccount } =
          await loadFixture(deployBallotFixture);

        // setup

        await ballot.giveRightToVote(otherAccount);
        await ballot.giveRightToVote(thirdAccount);

        // otherAccount delegates to thirdAccount
        await ballot.connect(otherAccount).delegate(thirdAccount);
        // thirdAccount delegates to deployer
        await ballot.connect(thirdAccount).delegate(deployer);

        // fire

        // deployer delegates to otherAccount
        await expect(ballot.delegate(otherAccount)).to.be.revertedWith(
          "Found a loop in delegation."
        );
      });
    });

    context("when the delegatee does not have the right to vote", function () {
      it("reverts", async function () {
        const { ballot, otherAccount } = await loadFixture(deployBallotFixture);

        // fire
        await expect(ballot.delegate(otherAccount)).to.be.revertedWith(
          "Delegatee should be allowed to vote"
        );
      });
    });

    it("renders that caller as having voted", async function () {
      const { ballot, deployer, otherAccount } = await loadFixture(
        deployBallotFixture
      );

      // setup
      await ballot.giveRightToVote(otherAccount);

      // fire
      await ballot.delegate(otherAccount);

      // I get the voters
      const voter = await ballot.voters(deployer);

      expect(voter.voted).to.equal(true);
    });

    it("sets the delegate for the caller to be the given address", async function () {
      const { ballot, deployer, otherAccount } = await loadFixture(
        deployBallotFixture
      );

      // setup
      await ballot.giveRightToVote(otherAccount);

      // fire
      await ballot.delegate(otherAccount);

      // I get the voters
      const voter = await ballot.voters(deployer);

      expect(voter.delegate).to.equal(otherAccount);
    });

    context("when delegation has chained delegation", function () {
      it("sets the delegate to be the end of the chain and not the given address", async function () {
        const { ballot, deployer, otherAccount, thirdAccount } =
          await loadFixture(deployBallotFixture);

        // setup

        await ballot.giveRightToVote(otherAccount);
        await ballot.giveRightToVote(thirdAccount);

        // otherAccount delegates to thirdAccount
        await ballot.connect(otherAccount).delegate(thirdAccount);

        // fire

        await ballot.delegate(otherAccount);

        const voter = await ballot.voters(deployer);

        expect(voter.delegate).to.equal(thirdAccount);
      });
    });

    context("when the delegatee has already voted", function () {
      it("increments the vote of the delegatee by the weight of the caller", async function () {
        const { ballot, deployer, otherAccount } = await loadFixture(
          deployBallotFixture
        );

        // setup

        const proposalIndex = 0n;
        await ballot.giveRightToVote(otherAccount);
        await ballot.connect(otherAccount).vote(proposalIndex);
        const proposalCountBefore = (await ballot.proposals(proposalIndex))
          .voteCount;

        const senderWeight = (await ballot.voters(deployer)).weight;

        // fire

        await ballot.delegate(otherAccount);

        const proposalCountAfter = (await ballot.proposals(proposalIndex))
          .voteCount;

        expect(proposalCountAfter).to.equal(proposalCountBefore + senderWeight);
      });
    });

    context("when the delegatee has not already voted", function () {
      it("increases the delegatee weight by the sender weight", async function () {
        const { ballot, deployer, otherAccount } = await loadFixture(
          deployBallotFixture
        );

        // setup
        await ballot.giveRightToVote(otherAccount);
        const senderWeight = (await ballot.voters(deployer)).weight;
        const voterWeightBefore = (await ballot.voters(otherAccount)).weight;

        // fire

        await ballot.delegate(otherAccount);

        const voterWeightAfter = (await ballot.voters(otherAccount)).weight;

        expect(voterWeightAfter).to.equal(voterWeightBefore + senderWeight);
      });
    });
  });
});
