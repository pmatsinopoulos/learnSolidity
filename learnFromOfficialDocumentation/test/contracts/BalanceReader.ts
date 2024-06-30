import { Signer } from "ethers";
import { BalanceReader, BalanceReader__factory } from "../../typechain-types";
import { ethers } from "hardhat";

describe("BalanceReader", function () {
  let instance: BalanceReader;
  let accounts: Signer[];

  // Configure the addresses we can to check balances for
  const USDC_MAINNET_ADDRESS = "0xa0b86991c6218b36c1d19d4a2e9eb0ce3606eb48"; // https://etherscan.io/token/0xa0b86991c6218b36c1d19d4a2e9eb0ce3606eb48
  const ARBITRUM_ONE_GATEWAY = "0xcEe284F754E854890e311e3280b767F80797180d";
  const USDC_DECIMALS = 6;

  it("get's arbitrum gateway balance on USDC", async function () {
    accounts = await ethers.getSigners();
    const factory = new BalanceReader__factory(accounts[0]); // +accounts[0]+ is going to be the default sender/connection to contract?

    // we deploy the contract to our local test environment
    instance = await factory.deploy();

    const balance = await instance.getTokenBalanceOf(
      ARBITRUM_ONE_GATEWAY,
      USDC_MAINNET_ADDRESS
    );

    const balanceAsString = ethers.formatUnits(balance, USDC_DECIMALS);
    console.log("Balance", balanceAsString);
  });
});
