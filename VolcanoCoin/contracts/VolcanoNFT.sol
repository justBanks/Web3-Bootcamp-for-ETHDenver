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
    string private baseURI;
    uint private _totalSupply = 17;
    mapping(address => uint[]) public _tokensOwned;

    constructor() payable Ownable() ERC721("Pompay", "POMP") {
        safeMint(msg.sender);
        safeMint(msg.sender);
        safeMint(msg.sender); // spare token, to transfer with team wallet
    }

    // tokenURI should resolve to a metadata JSON schema
    function safeMint(address to) private returns(uint) {
        _tokenIds.increment();
        require(_tokenIds.current() < _totalSupply, "Total supply of tokens has been claimed");
        _safeMint(to, _tokenIds.current());
        //_setTokenURI(newItemId, "{\"name\": \"POMP token\", \"tokenId\": }");
        _totalSupply--;
        _tokensOwned[to].push(_tokenIds.current());
        console.log("Total supply remaining: ", _totalSupply);
        return _tokenIds.current();
    }

    /** 
     * Why pass in a token URI here, when ERC721 provides a standardized tokenURI() function? 
     */
    function mintToken() external payable returns(uint) {
        require(_tokenIds.current() < _totalSupply, "Total supply of tokens has been claimed");
        require(msg.value == 10000000000000000, "First gimme .01 GoETH");
        return safeMint(msg.sender);
    }

    function whichTokensDoIOwn() public view returns (uint[] memory) {
        return _tokensOwned[msg.sender];
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

    /**
     * @dev Base URI for computing {tokenURI}. If set, the resulting URI for each
     * token will be the concatenation of the `baseURI` and the `tokenId`.
     * Just call tokenURI(tokenId).
     */
    function _baseURI() internal view override returns (string memory) {
        return baseURI;
    }

    function setBaseURI(string memory uri) public onlyOwner {
        baseURI = uri;
    }
    
}