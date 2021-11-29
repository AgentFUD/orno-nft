// SPDX-License-Identifier: MIT

pragma solidity ^0.8.9;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "../interfaces/IBadgeSVGLib.sol";

contract OrNoBadgeNFT is ERC721URIStorage, Ownable {

    address svgLibAddress;

    // Holds the next NFT id
    uint256 public tokenCounter;

    constructor() ERC721("orNo Badge NFT", "ORNOBADGE") {

    }

    function mint(string memory _text, uint256 _flips, address _owner) external onlyOwner {
        _safeMint(_owner, tokenCounter);
        _setTokenURI(tokenCounter, IBadgeSVGLib(svgLibAddress).getSVG(_text, _flips, _owner));
        tokenCounter++;
    }

    function setSVGLibAddress(address _svgLibAddress) public onlyOwner {
        svgLibAddress = _svgLibAddress;
    }

    function withdraw() external onlyOwner {
        require(payable(_msgSender()).send(address(this).balance));
    }
}