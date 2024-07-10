import { loadFixture } from "@nomicfoundation/hardhat-network-helpers";
import { expect } from "chai";

import hre from "hardhat";

describe("#adder", function () {
  async function deployBasicMathFixture() {
    const BasicMath = await hre.ethers.getContractFactory("BasicMath");
    const basicMath = await BasicMath.deploy();
    return { basicMath };
  }

  it("adds the two numbers given and returns their sum and 'false' as error", async function () {
    const { basicMath } = await loadFixture(deployBasicMathFixture);

    const a = 1;
    const b = 2;

    const [result, error] = await basicMath.adder(a, b);

    expect(result).to.equal(3);
    expect(error).to.equal(false);
  });

  context("when addition overflows", async function () {
    it("returns 0 and error equal to 'true'", async function () {
      const { basicMath } = await loadFixture(deployBasicMathFixture);

      const a = hre.ethers.MaxUint256;
      const b = 1;

      const [result, error] = await basicMath.adder(a, b);

      expect(result).to.equal(0);
      expect(error).to.equal(true);
    });
  });
});
