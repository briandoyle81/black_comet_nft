// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

import "hardhat/console.sol";
import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Counters.sol";

contract UniversalInventoryFactory is ERC721, Ownable {
    using Counters for Counters.Counter;

    Counters.Counter private itemIds;

    event NewItem();

    struct UniversalInventoryItem {
        string name;
        address creator;
        // Qualitative References StandardQualities.  0 is NONE;
        // These are always random, unless 0 is requested
        uint16 opinion;
        uint16 size;
        uint16 quality;
        uint16 shape;
        uint16 age;
        uint16 color;
        uint16 origin;
        uint16 material;
        // 65535
        // Descend to get specificity
        // 65xxx first level
        // 10xxx metal
        // 104xx iron
        // 1049x steel
        uint16 typeOf;
        uint16 purpose;

        // Quantitative
        uint16 class; // Type - person, building, room, vehicle, animal, weapon
        uint16 level; // Maybe cap this and increase the cap annually
    }


}
