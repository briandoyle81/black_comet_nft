// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

import "hardhat/console.sol";
import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Counters.sol";

// Stores information for events that happen in a specific room

contract BCEvents is Ownable {

    struct BCEvent {
        string name;
        string text;
        // Effect?
    }

    BCEvent[] public bcRoomEvents;
    BCEvent[] public bcCardEvents;

    constructor() {
        _initializeDefaultRoomEvents();
    }

    // function _createEvent(
    //     string memory _name,
    //     string memory _text
    // ) internal {

    // }

    function _initializeDefaultRoomEvents() internal {
        // Create first events
        // 0
        bcRoomEvents.push(BCEvent("", ""));
        // 1
        bcRoomEvents.push(BCEvent("Breached Reactor", "As you enter the room, an auxiliary reactor explodes!"));
    }
}
