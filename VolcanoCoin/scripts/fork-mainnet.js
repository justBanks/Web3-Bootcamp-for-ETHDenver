const { ethers } = require("hardhat");
const hre = require("hardhat");
/**
 * Step 1: Run npx hardhat node --fork https://eth-mainnet.alchemyapi.io/v2/DUlP1Zz-vLfvSH6IdbS9TuBkI4-7bqTe
 * Run npx hardhat run --network localhost scripts/fork-mainnet.js ('--network localhost' is crucial).
 * Or: node scripts/fork-mainnet.js
 * Or: npx hardhat test --network localhost
 * If you want to use Metamask, make sure to connect to RPC URL http://localhost:8545
*/
async function main() {
    const vitalik = "0xab5801a7d398351b8be11c439e05c5b3259aec9b"
    const me = "0x77770F1229E7aC4A967235A6b605Befdc7dE2380"
    const contractAddress = "0xc3761EB917CD790B30dAD99f6Cc5b4Ff93C4F9eA"
    //const contractAddress = "0x7E42c72DFbE07Cde83a6BaD535A1A97496Df1531"
    
    await hre.network.provider.request({
      method: "hardhat_impersonateAccount",
      params: [vitalik],
    });
    
    //const signer = await ethers.getSigner(vitalik)
    const provider = ethers.getDefaultProvider("http://localhost:8545"); 
    const signer =  provider.getSigner(vitalik);
    console.log("Vitalik-->", signer);
    const currentBlock = await ethers.provider.getBlock("latest"); 
    console.log("Block number: ", currentBlock["number"]);
    
    await signer.sendTransaction({
        to: me,
        value: ethers.utils.parseEther("4.0")
      });

    return;
    /*
      eth_sendTransaction
        Transaction:         0xed3861ae18800b95ebd0566f22ccdcfa3d0ec3039b68eab5c29aa55dc19580b3
        From:                0xab5801a7d398351b8be11c439e05c5b3259aec9b
        To:                  0x77770f1229e7ac4a967235a6b605befdc7de2380
        Value:               4 ETH
        Gas used:            21000 of 21001
        Block #15981136:     0xe9a48360a0c5dea9190d7bcd9a11c903675a8e973a9b580a7aac204a89e0a8de
    */
    
    //const ERC20Contract = new ethers.Contract(contractAddress, ERC20abi, signer);
    const ERC20Contract = await ethers.getContractAt("TokenERC20", contractAddress, signer); 
    
    console.log(ERC20Contract);
    
    const ERC20balance = await ERC20Contract.balanceOf(vitalik)
    console.log("whale ERC20 balance", ERC20balance / 1e18)
  
    console.log("transfering to justBanks.eth", me)
    
    await ERC20Contract.connect(signer).transfer(me, ERC20balance)
    const accountBalance = await ERC20Contract.balanceOf(me)
  
    console.log("transfer complete")
    console.log("funded account balance", accountBalance / 1e18)
  
    const whaleBalanceAfter = await ERC20Contract.balanceOf(vitalik)
    console.log("whale ERC20 balance after", whaleBalanceAfter / 1e18)
  }
  
  main()
    .then(() => process.exit(0))
    .catch((error) => {
      console.error(error);
      process.exit(1);
    });
