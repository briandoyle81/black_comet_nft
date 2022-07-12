// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

import "hardhat/console.sol";
import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Counters.sol";

// Stores information for events that happen in a specific room

contract BCRoomEvents is Ownable {

    uint256 public mintCost = 1 * 10**18;
    bool public publicMintIsActive = false;

    enum BCEventType {NONE, BUG, MYSTERY, SCAVENGER, SHIP_SECURITY}

    struct BCEvent {
        string name;
        string text;
    }

    BCEvent[] public bcEvents;

    // constructor() {

    // }

    // function _createEvent(
    //     string memory _name,
    //     string memory _text
    // ) internal {

    // }

    function _initializeDefaultEvents() public onlyOwner {
        // Create first event
        bcEvents.push(BCEvent("Test", "Description"));
    }
}
