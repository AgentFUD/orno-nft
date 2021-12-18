// SPDX-License-Identifier: MIT

pragma solidity ^0.8.9;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "../interfaces/IBadgeSVGLib.sol";

contract OrNoBadgeNFT is ERC721Enumerable, Ownable {

    address private svgLibAddress;

    address private minterAddress;

    // Holds the next NFT id
    uint256 public tokenCounter;

    mapping(uint256 => string) public tokenTexts;

    mapping(uint256 => uint256) public flips;

    constructor() ERC721("orNo Badge NFT", "ORNOBADGE") {
        minterAddress = msg.sender;
    }

    modifier onlyMinter() {
        require(msg.sender == minterAddress);
        _;
    }

    function mint(string memory _text, uint256 _flips, address _owner) external onlyMinter {
        _safeMint(_owner, tokenCounter);
        tokenTexts[tokenCounter] = _text;
        flips[tokenCounter] = _flips;
        tokenCounter++;
    }

    function setSVGLibAddress(address _svgLibAddress) public onlyOwner {
        svgLibAddress = _svgLibAddress;
    }

    function setMinter(address _minterAddress) public onlyOwner {
        minterAddress = _minterAddress;
    }

    function withdraw() external onlyOwner {
        require(payable(_msgSender()).send(address(this).balance));
    }

    function tokenURI(uint256 _tokenId) public view override(ERC721) returns (string memory) {
        return IBadgeSVGLib(svgLibAddress).getSVG(tokenTexts[_tokenId], flips[_tokenId]);
    }
}