// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

import "hardhat/console.sol";
import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Counters.sol";

// Stores information for events that happen in a specific room

contract BCGames is Ownable {
    // TODO:  Allowed contract links?

    struct Game {
        address player;
    }
}
