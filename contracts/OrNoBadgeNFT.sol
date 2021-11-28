// SPDX-License-Identifier: MIT

pragma solidity ^0.8.9;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "../interfaces/ISVGLib.sol";

contract OrNoBadgeNFT is ERC721Enumerable, Ownable {

    address svgLibAddress;

    // Holds the next NFT id
    uint256 public tokenCounter;

    // Stores actual statement for every token
    mapping(uint256 => string) public tokenTexts;

    mapping(uint256 => bool) public tokenStates;
    
    constructor() ERC721("orNo Badge NFT", "ORNOBADGE") {

    }

    function mint(string memory _text, bool _status) public onlyOwner {
        _safeMint(msg.sender, tokenCounter);
        tokenTexts[tokenCounter] = _text;
        tokenStates[tokenCounter] = _status;
        tokenCounter++;
    }

    function setSVGLibAddress(address _svgLibAddress) public onlyOwner {
        svgLibAddress = _svgLibAddress;
    }

    function withdraw() external onlyOwner {
        require(payable(_msgSender()).send(address(this).balance));
    }

    function tokenURI(uint256 _tokenId) public view override(ERC721) returns (string memory) {
        return "ISVGLib(svgLibAddress).getSVG(tokenTexts[_tokenId], tokenStates[_tokenId], flips[_tokenId])";
    }
}