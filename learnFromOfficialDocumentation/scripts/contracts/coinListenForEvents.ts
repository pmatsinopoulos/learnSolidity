import hre, { artifacts } from "hardhat";
import { vars } from "hardhat/config";

const ALCHEMY_API_KEY = vars.get("ALCHEMY_API_KEY");

async function main() {
  const network = "sepolia";
  const provider = new hre.ethers.AlchemyProvider(network, ALCHEMY_API_KEY);

  const coinAddress = "0xBe2a6071b31391f2e38394611127eb6eED4f50A7";

  const Coin = await hre.ethers.getContractFactory("Coin");
  const coin = Coin.attach(coinAddress);
  const coinConnected = coin.connect(provider);

  coinConnected.on("Sent", (sender, receiver, amount) => {
    console.log("Sent", sender, receiver, amount);
  });

  console.log("Listening for events");

  // Keep the script running
  await new Promise(() => {});
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
