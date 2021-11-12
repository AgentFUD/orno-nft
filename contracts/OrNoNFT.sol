// SPDX-License-Identifier: MIT

pragma solidity 0.8.9;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@brechtpd/base64.sol";
import "./libraries/SVGLib.sol";

contract OrNoNFT is ERC721URIStorage, Ownable {

    // using Strings for uint256;

    // Holds the next NFT id
    uint256 public tokenCounter;

    // Stores actual statement for every token
    mapping(uint256 => string) public tokenTexts;

    // Stores actual true/false for every token
    mapping(uint256 => bool) public tokenStates;
    
    // Stores locked tokens true/false
    mapping(uint256 => bool) public lockedTokens;

    // Stores how many times a token flipped
    mapping(uint256 => uint256) public flips;

    uint256 public totalFlips;

    uint256 public flipPrice = 0.01 ether;

    uint256 public lockPrice = 0.01 ether;

    event orNoNFTCreated(uint256 tokenId, string imageURI);
    
    event orNoNFTFlipped(uint256 tokenId);
    
    event orNoNFTLocked(uint256 tokenId);

    constructor() ERC721("OrNo NFT", "ONNFT") {

    }

    function mint(string memory _text, bool _status) external {
        _safeMint(msg.sender, tokenCounter);
        string memory imageURI = SVGLib.svgToImageURI(_text, _status, 0);
        _setTokenURI(tokenCounter, SVGLib.formatTokenURI(imageURI));
        tokenTexts[tokenCounter] = _text;
        tokenStates[tokenCounter] = _status;
        tokenCounter++;
        emit orNoNFTCreated(tokenCounter, imageURI);
    }

    function flip(uint256 _tokenId) payable public {
        require(
            msg.sender == ownerOf(_tokenId) || 
            lockedTokens[_tokenId] == false, 
            "OrNoNFT: Flip error, not owner or token is locked"
        );
        require(msg.value >= flipPrice, "OrNoNFT: Flip error, unsufficient funds");
        flips[_tokenId] += 1;
        totalFlips += 1;
        tokenStates[_tokenId] = tokenStates[_tokenId] == true ? false : true;
        string memory imageURI = SVGLib.svgToImageURI(tokenTexts[_tokenId], tokenStates[_tokenId], flips[_tokenId]);
        _setTokenURI(_tokenId, SVGLib.formatTokenURI(imageURI));
        emit orNoNFTFlipped(_tokenId);
    }

    function lock(uint256 _tokenId) payable public {
        require(
            ownerOf(_tokenId) == msg.sender &&
            msg.value >= lockPrice, 
            "OrNoNFT: Lock error, not owner or insufficient funds"
        );
        lockedTokens[_tokenId] = true;
        emit orNoNFTLocked(_tokenId);
    }

    function setFlipPrice(uint256 _flipPrice) public onlyOwner {
        flipPrice = _flipPrice;
    }

    function setLockPrice(uint256 _lockPrice) public onlyOwner {
        lockPrice = _lockPrice;
    }

    function withdraw() external onlyOwner {
        uint balance = address(this).balance;
        payable(0xcb26c8c18B26Af312643634ad8Dd732358906347).transfer(balance);
    }
}