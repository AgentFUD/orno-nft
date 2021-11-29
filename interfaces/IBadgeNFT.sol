// SPDX-License-Identifier: MIT

pragma solidity ^0.8.9;

interface IBadgeNFT {
    function mint(string memory text, uint256 flips, address owner) external;
}