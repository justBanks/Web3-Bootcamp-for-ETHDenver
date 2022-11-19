require("@nomiclabs/hardhat-waffle");

/** @type import('hardhat/config').HardhatUserConfig */
module.exports = {
  solidity: "0.8.9",
  defaultNetwork: 'localhost',
  networks: {
    localhost: {
        forking: {
          url: "https://eth-mainnet.alchemyapi.io/v2/DUlP1Zz-vLfvSH6IdbS9TuBkI4-7bqTe",
        },
    },
    hardhat: {
      mining: {
        automine: false,
        mempool: {
          order: "priority"
        }
      }
    }
  },
};