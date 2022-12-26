const { ethers } = require("hardhat");
const hre = require("hardhat");
//Step 1: Run npx hardhat node --fork https://eth-mainnet.alchemyapi.io/v2/DUlP1Zz-vLfvSH6IdbS9TuBkI4-7bqTe
//Step 2: Run npx hardhat run --network localhost scripts/get-DAI.js
 (async () => {
    const daiAddress = "0xDA10009cBd5D07dd0CeCc66161FC93D7c9000da1";
    const usdtAddress = 0x00000000219ab540356cbb839cbe05303d7705fa;
    const me = "0x77770F1229E7aC4A967235A6b605Befdc7dE2380";
    // Human-Readable ABI
    const daiAbi = [
      // Some details about the token
      "function name() view returns (string)",
      "function symbol() view returns (string)",

      // Get the account balance
      "function balanceOf(address) view returns (uint)",

      // Send some of your tokens to someone else
      "function transfer(address to, uint amount)",

      // An event triggered whenever anyone transfers to someone else
      "event Transfer(address indexed from, address indexed to, uint amount)"
    ];

    // If you don't specify a //url//, Ethers connects to the default 
    // (i.e. ``http:/\/localhost:8545``)
    //const provider = ethers.getDefaultProvider("http://localhost:8545");
    const provider = new ethers.providers.JsonRpcProvider();

    // The provider also allows signing transactions to
    // send ether and pay to change state within the blockchain.
    // For this, we need the account signer...
    const signer = provider.getSigner()

    // The Contract object
    const daiContract = new ethers.Contract(daiAddress, daiAbi, provider);
    //const daiContract = await hre.ethers.getContractAt("Dai Stablecoin", daiAddress);

        await hre.network.provider.request({
          method: "hardhat_impersonateAccount",
          params: [daiAddress],
        });    

    // The DAI Contract is currently connected to the Provider,
    // which is read-only. You need to connect to a Signer, so
    // that you can pay to send state-changing transactions.
    const daiWithSigner = daiContract.connect(signer);

    // Each DAI has 18 decimal places
    const daiAmount = ethers.utils.parseUnits("1000000.0", 18);

    tx = daiWithSigner.transfer(me, daiAmount);

    let balance = await daiContract.balanceOf(me);
    console.log("My balance: ", balance);
    
    return;
/*
  Transaction:     0x6dd65d29d4cf8410cca7fd10932abd995613aa446bb749e81fb235e775dd8479
  From:            0xf39fd6e51aad88f6f4ce6ab8827279cfffb92266
  To:              0xda10009cbd5d07dd0cecc66161fc93d7c9000da1
  Value:           0 ETH
  Gas used:        21644 of 21645
  Block #16020219: 0xdea25c377eca4b3174b422ba77e2b4046e7a2eb590afe79251986ed8ef247729
*/
})();