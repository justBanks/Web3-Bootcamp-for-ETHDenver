const { expect } = require("chai");

describe("VolcanoCoin", function () {
    it("Should have initial supply of 10,000", async function () {
      const VolcanoCoin = await ethers.getContractFactory("VolcanoCoin");
      const coin = await VolcanoCoin.deploy();
  
      expect(await coin.getTotalSupply()).to.equal(10000);
    
      // wait until the transaction is mined
      //await setGreetingTx.wait();
  
      //expect(await coin.greet()).to.equal("Hola, mundo!");
    });
  });
  