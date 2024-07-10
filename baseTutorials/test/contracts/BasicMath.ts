import { loadFixture } from "@nomicfoundation/hardhat-network-helpers";
import { expect } from "chai";

import hre from "hardhat";

describe("BasicMath", async function () {
  async function deployBasicMathFixture() {
    const BasicMath = await hre.ethers.getContractFactory("BasicMath");
    const basicMath = await BasicMath.deploy();
    return { basicMath };
  }

  describe("#adder", function () {
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

  describe("#subtractor", function () {
    it("subtracts the two numbers given and returns their difference and 'false' as error", async function () {
      const { basicMath } = await loadFixture(deployBasicMathFixture);

      const a = 2;
      const b = 1;

      const [result, error] = await basicMath.subtractor(a, b);

      expect(result).to.equal(1);
      expect(error).to.equal(false);
    });

    context("when subtraction underflows", function () {
      it("returns 0 and error 'true'", async function () {
        const { basicMath } = await loadFixture(deployBasicMathFixture);

        const a = 0;
        const b = 1;

        const [result, error] = await basicMath.subtractor(a, b);

        expect(result).to.equal(0);
        expect(error).to.equal(true);
      });
    });
  });
});
