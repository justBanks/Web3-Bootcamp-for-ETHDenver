const { ethers } = require("hardhat");
const hre = require("hardhat");
/**
 * Step 1: Run npx hardhat node --fork https://eth-mainnet.alchemyapi.io/v2/DUlP1Zz-vLfvSH6IdbS9TuBkI4-7bqTe
 * Run npx hardhat run --network localhost scripts/mempool.js ('--network localhost' is crucial).
 * Or: node scripts/fork-mainnet.js
 * Or: npx hardhat test --network localhost
 * If you want to use Metamask, make sure to connect to RPC URL http://localhost:8545
*/
const main = async () => {
    setInterval(async () => {
        const provider = ethers.getDefaultProvider("http://localhost:8545"); 
        //const pendingBlock = ethers.provider.eth_getBlockByNumber; 
        const pendingBlock = await hre.network.provider.send("eth_getBlockByNumber", [
            "pending",
            false,
        ]);
        
        //Filter for only Uniswap
        
        //How can MEV and front running be mitigated?
        
        console.log("Block number: ", pendingBlock);
    }, 8000)
}

main().catch((error) => {
    console.error(error)
    process.exitCode = 1
})
