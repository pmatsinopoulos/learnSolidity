import { loadFixture } from "@nomicfoundation/hardhat-network-helpers";
import { expect } from "chai";
import hre, { ethers } from "hardhat";

describe("Coin", function () {
  async function deployCoinFixture() {
    const CoinFactory = await hre.ethers.getContractFactory("Coin");
    const coin = await CoinFactory.deploy();
    await coin.waitForDeployment();

    const [deployer, otherAccount] = await hre.ethers.getSigners();

    return { coin, deployer, otherAccount };
  }

  describe("#minter", function () {
    it("is a public address equal to the contract deployer", async function () {
      const { coin, deployer } = await loadFixture(deployCoinFixture);

      const minter = await coin.minter();

      expect(minter).to.equal(deployer.address);
    });
  });

  describe("#balances", function () {
    it("returns the balance of the given account", async function () {
      const { coin, deployer } = await loadFixture(deployCoinFixture);

      // setup
      const wallet = ethers.Wallet.createRandom();
      const receiver = wallet.address;
      await coin.mint(deployer, 20n);
      await coin.send(receiver, 18n);

      // fire
      const result = await coin.balances(receiver);

      expect(result).to.equal(18n);
    });

    context("when given account does not have balance", function () {
      it("returns 0", async function () {
        const { coin } = await loadFixture(deployCoinFixture);

        const wallet = ethers.Wallet.createRandom();
        const receiver = wallet.address;

        // fire
        const result = await coin.balances(receiver);

        expect(result).to.equal(0);
      });
    });
  });

  describe("#mint", function () {
    it("sends the given amount to the recipient and increases their balance", async function () {
      const { coin, deployer } = await loadFixture(deployCoinFixture);

      // setup
      const wallet = ethers.Wallet.createRandom();
      const receiver = wallet.address;

      // fire
      await coin.mint(receiver, 18n);

      const receiverBalance = await coin.balances(receiver);

      expect(receiverBalance).to.equal(18n);
    });

    context("when the caller is not the minter", function () {
      it("fails and doesn't increase the amount of the recipient", async function () {
        const { coin, otherAccount } = await loadFixture(deployCoinFixture);

        const wallet = ethers.Wallet.createRandom();
        const receiver = wallet.address;

        await expect(
          coin.connect(otherAccount).mint(receiver, 10n)
        ).to.be.revertedWith("Only contract owner can mint");
      });
    });
  });

  describe("#send", function () {
    it("sends the given amount from the caller to the recipient", async function () {
      const { coin, deployer, otherAccount } = await loadFixture(
        deployCoinFixture
      );

      // setup
      await coin.mint(deployer, 20n);

      // fire
      await coin.send(otherAccount, 18n);

      const deployerBalance = await coin.balances(deployer);
      expect(deployerBalance).to.equal(2n);

      const otherAccountBalance = await coin.balances(otherAccount);
      expect(otherAccountBalance).to.equal(18n);
    });

    it("emits a Sent event", async function () {
      const { coin, deployer, otherAccount } = await loadFixture(
        deployCoinFixture
      );

      // setup
      await coin.mint(deployer, 20n);

      // fire
      await expect(coin.send(otherAccount, 18n))
        .to.emit(coin, "Sent")
        .withArgs(deployer, otherAccount, 18n);
    });

    context("when sender balance is not enough", function () {
      it("doesn't send money to the recipient", async function () {
        const { coin, deployer, otherAccount } = await loadFixture(
          deployCoinFixture
        );

        // fire
        await expect(coin.send(otherAccount, 18n))
          .to.be.revertedWithCustomError(coin, "InsufficientBalance")
          .withArgs(18n, 0n);
      });
    });
  });
});
