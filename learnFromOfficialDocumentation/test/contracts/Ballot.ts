import hre, { ethers } from "hardhat";
import { expect } from "chai";
import { loadFixture } from "@nomicfoundation/hardhat-network-helpers";

describe("Ballot", function () {
  const proposalNames: string[] = ["Proposal1", "Proposal2", "Proposal3"];
  const proposalNamesAsBytes32 = proposalNames.map((proposalName) =>
    ethers.encodeBytes32String(proposalName)
  );

  async function deployBallotFixture() {
    const [deployer] = await ethers.getSigners();
    const Ballot = await hre.ethers.getContractFactory("Ballot");
    const ballot = await Ballot.deploy(proposalNamesAsBytes32);
    await ballot.waitForDeployment();

    return { ballot, deployer };
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
  });
});
