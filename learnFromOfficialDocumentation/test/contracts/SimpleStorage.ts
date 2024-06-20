import { loadFixture } from "@nomicfoundation/hardhat-toolbox/network-helpers";
import { expect } from "chai";
import hre from "hardhat";

describe("SimpleStorage", function() {
  async function deploySimpleStorageFixture() {
    const SimpleStorageFactory = await hre.ethers.getContractFactory("SimpleStorage");
    const simpleStorage = await SimpleStorageFactory.deploy();
    await simpleStorage.waitForDeployment();

    return { simpleStorage };
  }

  it("Can set a value", async function() {
    const { simpleStorage } = await loadFixture(deploySimpleStorageFixture);

    const value = 32n;

    await simpleStorage.set(value);

    const result = await simpleStorage.get();

    expect(result).to.equal(value);
  });
});
