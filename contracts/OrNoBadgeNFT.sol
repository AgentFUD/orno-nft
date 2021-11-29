// SPDX-License-Identifier: MIT

pragma solidity ^0.8.9;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "../interfaces/IBadgeSVGLib.sol";

contract OrNoBadgeNFT is ERC721Enumerable, Ownable {

    address svgLibAddress;

    // Holds the next NFT id
    uint256 public tokenCounter;

    mapping(uint256 => string) internal tokenTexts;

    mapping(uint256 => uint256) public flips;

    constructor() ERC721("orNo Badge NFT", "ORNOBADGE") {

    }

    function mint(string memory _text, uint256 _flips, address _owner) external onlyOwner {
        _safeMint(_owner, tokenCounter);
        tokenTexts[tokenCounter] = _text;
        flips[tokenCounter] = _flips;
        tokenCounter++;
    }

    function setSVGLibAddress(address _svgLibAddress) public onlyOwner {
        svgLibAddress = _svgLibAddress;
    }

    function withdraw() external onlyOwner {
        require(payable(_msgSender()).send(address(this).balance));
    }

    function tokenURI(uint256 _tokenId) public view override(ERC721) returns (string memory) {
        return IBadgeSVGLib(svgLibAddress).getSVG(tokenTexts[_tokenId], flips[_tokenId]);
    }
}