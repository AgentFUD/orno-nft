// SPDX-License-Identifier: MIT

pragma solidity 0.8.9;

import "@openzeppelin/contracts/utils/Strings.sol";
import "@brechtpd/base64.sol";

library SVGLib {
    
    using Strings for uint256;

    string constant svg1 = '<svg xmlns="http://www.w3.org/2000/svg" width="600" height="400"><rect x="10" y="10" width="580" height="380" style="fill:blue;stroke:darkgrey;stroke-width:5;fill-opacity:0.1;stroke-opacity:0.9" /><text x="50%" y="30%" dominant-baseline="middle" text-anchor="middle" fill="indigo" font-size="3em" font-family="Arial, Helvetica, sans-serif">';
    string constant svg2 = '</text><text x="50%" y="70%" dominant-baseline="middle" text-anchor="middle" fill="blue" font-size="3em" font-family="Arial, Helvetica, sans-serif">';
    string constant svg3 = '</text><text x="20" y="380" fill="black" font-size="1em" font-family="Arial, Helvetica, sans-serif" font-weight="bold">flips: ';
    string constant svg4 = '</text></svg>';

    function svgToImageURI(string memory _text, string memory _statusText, uint256 flips) public view returns (string memory) {
        string memory baseURL = "data:image/svg+xml;base64,";
        string memory svg = string(abi.encodePacked(svg1, _text, svg2, _statusText, svg3, flips.toString(), svg4));
        string memory svgBase64Encoded = Base64.encode(bytes(abi.encodePacked(svg)));
        string memory imageURI = string(abi.encodePacked(baseURL, svgBase64Encoded));
        return imageURI;
    }

    function formatTokenURI(string memory _imageURI) public pure returns (string memory) {
        return string(
            abi.encodePacked(
                "data:application/json;base64,",
                Base64.encode(
                    bytes(
                        abi.encodePacked(
                            '{"name": "OrNo NFT",',
                            '"description": "Coolest thing on the Earth",',
                            '"attributes": "",',
                            '"image": "', _imageURI , '"}'
                        )
                    )
                )
            )
        );       
    }
}