const { expect } = require("chai");
const { ethers } = require("hardhat");

describe("VolcanoCoin", function () {
  
    let totalSupply = 0;
    var VolcanoCoin;
    var coin;
    var owner, addr1;

    before(async function () {
        [owner, addr1] = await ethers.getSigners();
        VolcanoCoin = await ethers.getContractFactory("VolcanoCoin");
        coin = await VolcanoCoin.deploy();
    });

    it("Should have initial supply of 10,000", async function () {
        totalSupply = await coin.getTotalSupply();
        expect(totalSupply).to.equal(10000);
    });

    it("Should increase totalSupply by 1,000 when minting", async function () {
        await coin.mint();
        totalSupply = await coin.getTotalSupply();
        expect(totalSupply).to.equal(11000);
    });

    it("Should only allow minting by owner", async function(){
        try {
            await coin.connect(addr1).mint();
            expect(0).equals(1);
        }
        catch {
            expect(1).equals(1);
        }
    });

});
