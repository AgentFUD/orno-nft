// SPDX-License-Identifier: MIT

pragma solidity ^0.8.9;

interface IBadgeSVGLib {
    function getSVG(string memory _text, uint256 _flips) external pure returns (string memory);
}