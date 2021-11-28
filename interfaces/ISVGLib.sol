// SPDX-License-Identifier: MIT

pragma solidity ^0.8.9;

interface ISVGLib {
    function getSVG(string memory _text, bool _yesno, uint256 flips) external pure returns (string memory);
}