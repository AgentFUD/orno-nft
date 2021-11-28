// SPDX-License-Identifier: MIT

pragma solidity ^0.8.9;

import "@openzeppelin/contracts/utils/Strings.sol";
import "@brechtpd/base64.sol";

library OrNoBadgeSVGLib {
    
    using Strings for uint256;

    function svgToImageURI(string memory _text) external pure returns (string memory) {
        
        string memory imageURI = string(abi.encodePacked("test"));
        return imageURI;
    }
    
    function formatTokenURI(string memory _imageURI) external pure returns (string memory) {
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