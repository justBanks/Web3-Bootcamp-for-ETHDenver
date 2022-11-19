const { ethers } = require("hardhat");
const hre = require("hardhat");
/**
 * Step 1: Run npx hardhat node --fork https://eth-mainnet.alchemyapi.io/v2/DUlP1Zz-vLfvSH6IdbS9TuBkI4-7bqTe
 * Step 2: Run npx hardhat run --network localhost scripts/mempool.js 
 * Or: node scripts/mempool.js; timestamp will update
 * Step 3: In another terminal, run scripts/fork-mainnet.js (calls sendTransaction()) and watch the parentHash change
*/
const main = async () => {
    setInterval(async () => {
        const provider = ethers.getDefaultProvider("http://localhost:8545"); 
        const pendingBlock = await hre.network.provider.send("eth_getBlockByNumber", [
            "pending",
            true,
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
