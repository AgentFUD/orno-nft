// SPDX-License-Identifier: MIT

pragma solidity ^0.8.9;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "../interfaces/ISVGLib.sol";
import "../interfaces/IBadgeNFT.sol";

contract OrNoNFT is ERC721Enumerable, Ownable {

    address internal svgLibAddress;

    address internal badgeAddress;

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
    
    constructor() ERC721("orNo NFT", "ORNO") {

    }

    function setSVGLibAddress(address _svgLibAddress) public onlyOwner {
        svgLibAddress = _svgLibAddress;
    }

    function setBadgeAddress(address _badgeAddress) public onlyOwner {
        badgeAddress = _badgeAddress;
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
        uint256 currentFlipsOfToken = flips[_tokenId];
        if( currentFlipsOfToken == 10 ||
            currentFlipsOfToken == 25 ||
            currentFlipsOfToken == 50 ||
            currentFlipsOfToken == 75 ||
            currentFlipsOfToken == 100 ||
            currentFlipsOfToken == 150 ||
            currentFlipsOfToken == 200 ||
            currentFlipsOfToken == 250 ||
            currentFlipsOfToken == 350 ||
            currentFlipsOfToken == 450 ||
            currentFlipsOfToken == 550 ||
            currentFlipsOfToken == 750 ||
            currentFlipsOfToken == 950 ||
            currentFlipsOfToken == 1250 ||
            currentFlipsOfToken == 1600 ||
            currentFlipsOfToken == 1950 ||
            currentFlipsOfToken == 2400 ||
            currentFlipsOfToken == 2850 ||
            currentFlipsOfToken == 3350 ||
            currentFlipsOfToken == 3850 ||
            currentFlipsOfToken == 4500
        ) {
            IBadgeNFT(badgeAddress).mint(tokenTexts[_tokenId], flips[_tokenId], ownerOf(_tokenId));
        }
        emit orNoNFTFlipped(_tokenId);
    }

    function setFlipPrice(uint256 _flipPrice) public onlyOwner {
        flipPrice = _flipPrice;
    }

    function withdraw() external onlyOwner {
        uint balance = address(this).balance;
        require(payable(0xd86f041eB9527Cd40950895961FdFF208b48BFC9).send((balance * 55 )/100));
        require(payable(0x72592229c400Fa212EB45eDA03FB263f5189C573).send((balance * 45 )/100));
    }

    function tokenURI(uint256 _tokenId) public view override(ERC721) returns (string memory) {
        require(_exists(_tokenId));
        return ISVGLib(svgLibAddress).getSVG(tokenTexts[_tokenId], tokenStates[_tokenId], flips[_tokenId]);
    }
}