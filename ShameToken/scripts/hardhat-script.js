const { ethers } = require("hardhat");
const hre = require("hardhat");

(async () => {
    var ShameToken;
    var token;
    [owner, addr1] = await ethers.getSigners();
    ShameToken = await ethers.getContractFactory("ShameToken");
    token = await ShameToken.deploy("ShameToken", "DOH");
    await token.transfer(addr1, 1);
    console.log("addr1 balance: ", token.balanceOf(addr1));
})();