// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

import "hardhat/console.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol"; // for per-token metadata

// contract 0x02b01d6fe26590e718497b0056d852c175b2cf79
contract VolcanoNFT is Ownable, ERC721URIStorage
{
    using Counters for Counters.Counter; // gives _tokenIds extension methods from Counters library
    Counters.Counter private _tokenIds;
    uint private _totalSupply = 17;
    mapping(address => uint) _owners;

    constructor() Ownable() ERC721("Pompay", "POMP") {
        safeMint(msg.sender);
        safeMint(msg.sender);
        safeMint(msg.sender); // spare token, to transfer with team wallet
    }

    // tokenURI should resolve to a metadata JSON schema
    function safeMint(address to) private {
        _tokenIds.increment();
        require(_tokenIds.current() < _totalSupply, "Total supply of tokens has been claimed");
        uint256 newItemId = _tokenIds.current();
        _safeMint(to, newItemId);
        //_setTokenURI(newItemId, "{\"name\": \"POMP token\", \"tokenId\": }");
        _totalSupply--;
        _owners[to] = newItemId;
        console.log("Total supply remaining: ", _totalSupply);
    }

    function mintToken() public {
        require(msg.sender == owner() || _owners[msg.sender] == 0, "You already own a token");
        safeMint(msg.sender);
    }

    function whichTokenDoIOwn() public view returns (uint) {
        return _owners[msg.sender];
    }

    function transfer(address to, uint tokenId) public {
        safeTransferFrom(msg.sender, to, tokenId);
    }

    function totalMinted() public view returns (uint) {
        return _tokenIds.current();
    }

    function totalSupplyRemaining() public view returns (uint) {
        return _totalSupply;
    }
    
}