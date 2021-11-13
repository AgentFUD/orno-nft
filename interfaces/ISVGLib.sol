// SPDX-License-Identifier: MIT

pragma solidity 0.8.9;

interface ISVGLib {
    function svgToImageURI(string memory _text, bool _yesno, uint256 flips) external pure returns (string memory);
    function formatTokenURI(string memory _imageURI) external pure returns (string memory);
}