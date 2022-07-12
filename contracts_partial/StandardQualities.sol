// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

import "hardhat/console.sol";

// Standard qualities for the Universal Inventory System
abstract contract StandardQualities {

    mapping (uint16 => string) public size;

    constructor() {
        size[1] = "small";
        size[2] = "medium";
        size[3] = "large";
    }
}
