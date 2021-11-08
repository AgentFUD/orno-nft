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

    uint256 public flipPrice = 0.01 ether;

    uint256 public lockPrice = 0.01 ether;

    // string svg1 = '<svg xmlns="http://www.w3.org/2000/svg" width="600" height="400"><rect x="10" y="10" width="580" height="380" style="fill:blue;stroke:darkgrey;stroke-width:5;fill-opacity:0.1;stroke-opacity:0.9" /><text x="50%" y="30%" dominant-baseline="middle" text-anchor="middle" fill="indigo" font-size="3em" font-family="Arial, Helvetica, sans-serif">';
    // string svg2 = '</text><text x="50%" y="70%" dominant-baseline="middle" text-anchor="middle" fill="blue" font-size="3em" font-family="Arial, Helvetica, sans-serif">';
    // string svg3 = '</text><text x="20" y="380" fill="black" font-size="1em" font-family="Arial, Helvetica, sans-serif" font-weight="bold">flips: ';
    // string svg4 = '</text></svg>';

    event TFTNFTCreated(uint256 tokenId, string imageURI);

    constructor() ERC721("OrNo NFT", "ONNFT") {}

    function mint(string memory _text, bool _status) external {
        _safeMint(msg.sender, tokenCounter);
        string memory statusText = _status ? "TRUE" : "FALSE";
        string memory imageURI = SVGLib.svgToImageURI(_text, statusText, 0);
        _setTokenURI(tokenCounter, SVGLib.formatTokenURI(imageURI));
        tokenTexts[tokenCounter] = _text;
        tokenStates[tokenCounter] = _status;
        tokenCounter++;
        emit TFTNFTCreated(tokenCounter, imageURI);
    }

    // function svgToImageURI(string memory _text, string memory _statusText, uint256 flips) private view returns (string memory) {
    //     string memory baseURL = "data:image/svg+xml;base64,";
    //     string memory svg = string(abi.encodePacked(svg1, _text, svg2, _statusText, svg3, flips.toString(), svg4));
    //     string memory svgBase64Encoded = Base64.encode(bytes(abi.encodePacked(svg)));
    //     string memory imageURI = string(abi.encodePacked(baseURL, svgBase64Encoded));
    //     return imageURI;
    // }

    // function formatTokenURI(string memory _imageURI) private pure returns (string memory) {
    //     return string(
    //         abi.encodePacked(
    //             "data:application/json;base64,",
    //             Base64.encode(
    //                 bytes(
    //                     abi.encodePacked(
    //                         '{"name": "OrNo NFT",',
    //                         '"description": "Coolest thing on the Earth",',
    //                         '"attributes": "",',
    //                         '"image": "', _imageURI , '"}'
    //                     )
    //                 )
    //             )
    //         )
    //     );       
    // }

    function flip(uint256 _tokenId) payable public {
        require(
            msg.sender == ownerOf(_tokenId) || 
            lockedTokens[_tokenId] == false, 
            "OrNoNFT: Flip error, not owner or token is locked"
        );
        require(msg.value >= flipPrice, "OrNoNFT: Flip error, unsufficient funds");
        flips[_tokenId] += 1;
        tokenStates[_tokenId] = tokenStates[_tokenId] == true ? false : true;
        string memory statusText = tokenStates[_tokenId] ? "TRUE" : "FALSE";
        string memory imageURI = SVGLib.svgToImageURI(tokenTexts[_tokenId], statusText, flips[_tokenId]);
        _setTokenURI(_tokenId, SVGLib.formatTokenURI(imageURI));
    }

    function lock(uint256 _tokenId) payable public {
        require(
            ownerOf(_tokenId) == msg.sender &&
            msg.value >= lockPrice, 
            "OrNoNFT: Lock error, not owner or insufficient funds"
        );
        lockedTokens[_tokenId] = true;
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