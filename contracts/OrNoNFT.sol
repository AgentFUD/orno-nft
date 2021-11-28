// SPDX-License-Identifier: MIT

pragma solidity ^0.8.9;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "../interfaces/ISVGLib.sol";

contract OrNoNFT is ERC721Enumerable, Ownable {

    address svgLibAddress;

    // Holds the next NFT id
    uint256 public tokenCounter;

    // Stores actual statement for every token
    mapping(uint256 => string) public tokenTexts;

    // Stores actual true/false for every token
    mapping(uint256 => bool) public tokenStates;
    
    // Stores how many times a token flipped
    mapping(uint256 => uint256) public flips;

    uint256 public totalFlips;

    uint256 public flipPrice = 0.01 ether;

    event orNoNFTFlipped(uint256 tokenId);
    
    constructor(address _svgLibAddress) ERC721("OrNo NFT", "ONNFT") {
        svgLibAddress = _svgLibAddress;
    }

    function mint(string memory _text, bool _status) public onlyOwner {
        _safeMint(msg.sender, tokenCounter);
        tokenTexts[tokenCounter] = _text;
        tokenStates[tokenCounter] = _status;
        tokenCounter++;
    }

    function flip(uint256 _tokenId) payable public {
        require(msg.value >= flipPrice, "OrNoNFT: Flip error, unsufficient funds");
        flips[_tokenId] += 1;
        totalFlips += 1;
        tokenStates[_tokenId] = tokenStates[_tokenId] == true ? false : true;
        emit orNoNFTFlipped(_tokenId);
    }

    function setFlipPrice(uint256 _flipPrice) public onlyOwner {
        flipPrice = _flipPrice;
    }

    function withdraw() external onlyOwner {
        require(payable(_msgSender()).send(address(this).balance));
    }

    function tokenURI(uint256 _tokenId) public view override(ERC721) returns (string memory) {
        return ISVGLib(svgLibAddress).getSVG(tokenTexts[_tokenId], tokenStates[_tokenId], flips[_tokenId]);
    }
}