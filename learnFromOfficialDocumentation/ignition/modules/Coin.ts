import { buildModule } from "@nomicfoundation/hardhat-ignition/modules";

const CoinModule = buildModule("Coin", (m) => {
  const coin = m.contract("Coin");

  return { coin };
});

export default CoinModule;
