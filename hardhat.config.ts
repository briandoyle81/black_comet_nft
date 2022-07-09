import { HardhatUserConfig } from "hardhat/config";
import "@nomicfoundation/hardhat-toolbox";
import "hardhat-deploy"

require("dotenv").config();

const config: HardhatUserConfig = {
  solidity: "0.8.9",
  typechain: {
    outDir: "typechain",
  },
  namedAccounts: {
    deployer: 0,
  },
  verify: {
    etherscan: {
      apiKey: process.env.ETHERSCAN_API_KEY || "",
    },
  },
  networks: {
    hardhat: {
      forking: {
        url: process.env.MAINNET_FORKING_URL || "",
      },
    },
    rinkeby: {
      url: process.env.RINKEBY_URL || "",
      accounts: [process.env.METAMASK_WALLET_1 || ""],
      // accounts: {
      //   mnemonic: process.env.WALLET_MNEMONIC || "",
      // },
    },
  },
  gasReporter: {
    currency: "USD",
    gasPrice: 58,
  },
};

export default config;
