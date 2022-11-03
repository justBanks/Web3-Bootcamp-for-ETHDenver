// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

import "hardhat/console.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol"; // for per-token metadata

contract VolcanoNFT is Ownable, ERC721URIStorage
{
    using Counters for Counters.Counter; // gives _tokenIds extension methods from Counters library
    Counters.Counter private _tokenIds;
    uint private _totalSupply = 17;

    constructor() Ownable() ERC721("Pompay", "POMP") {
        mint(msg.sender);
        mint(msg.sender);
        mint(msg.sender); // spare token, to transfer with team wallet
    }

    // tokenURI should resolve to a metadata JSON schema
    function mint(address to) public onlyOwner {
        _tokenIds.increment();
        require(_tokenIds.current() < _totalSupply, "Total supply of tokens has been claimed");
        uint256 newItemId = _tokenIds.current();
        _safeMint(to, newItemId);
        //_setTokenURI(newItemId, "{\"name\": \"POMP token\", \"tokenId\": }");
        _totalSupply--;
        console.log("Total supply remaining: ", _totalSupply);
    }

    function transfer(address to, uint tokenId) public {
        safeTransferFrom(msg.sender, to, tokenId);
    }

}