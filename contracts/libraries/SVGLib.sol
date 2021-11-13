// SPDX-License-Identifier: MIT

pragma solidity 0.8.9;

import "@openzeppelin/contracts/utils/Strings.sol";

library SVGLib {
    
    function svgToImageURI(string memory _text, bool _yesno, uint256 flips) external pure returns (string memory) {
        return string(abi.encodePacked("https://orno.io"));
    }

    function formatTokenURI(string memory _imageURI) external pure returns (string memory) {
        return string(abi.encodePacked("https://ornolabs.com"));       
    }
}