// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

import "hardhat/console.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Counters.sol";

import "./BCRoomEvents.sol";

contract RoomTiles is ERC721URIStorage, Ownable {
    uint256 public mintCost = 1 * 10**18;
    bool public mintIsActive = false;

    address public EventContract;

    struct RoomTile {
        string name;
        string artLink;
        BCRoomEvents.BCEventType eventType;
        uint8 numDoors;
        uint8 totalDoorStrength;
        uint8 numItems;
        uint8 numData;
        uint8 numWindows;
        bool hasVent;
        bool hasHazard;
        bool signatureDetected; // probably should be auto detected
        // bool publicUse; // can be a part of any game // stack limit
                            // just use owner contract instead
        uint256 eventNum; // 0 if no event in room
    }

    RoomTile[] public rooms;
    uint256[] public publicRoomTokens;

    constructor() ERC721("Black Comet Rooms", "BCRT") {

    }

    function _mintRoom(
        address owner,
        string memory _name,
        string memory _artLink,
        BCRoomEvents.BCEventType _eventType,
        uint8 _numDoors,
        uint8 _totalDoorStrength,
        uint8 _numItems,
        uint8 _numData,
        uint8 _numWindows,
        bool _hasVent,
        bool _hasHazard,
        bool _signatureDetected,
        // bool _publicUse,
        uint256 _eventNum
    ) internal {
        //TODO: NEEDS TO OBEY MINTING BEING ON
        rooms.push(RoomTile(
            _name,
            _artLink,
            _eventType,
            _numDoors,
            _totalDoorStrength,
            _numItems,
            _numData,
            _numWindows,
            _hasVent,
            _hasHazard,
            _signatureDetected,
            // _publicUse,  // Commented because of compile stack limit
            _eventNum
        ));
        uint id = rooms.length -1;
        _safeMint(owner, id);
        _setTokenURI(id,rooms[id].artLink);
    }

    function _initializeDefaultRooms() public onlyOwner {
        // Create the Reactor Control Room
        _mintRoom(
            msg.sender,
            "Reactor Control",
            "https://i.imgur.com/9v84X7m.png", //TODO: IPFS link
            BCRoomEvents.BCEventType.SCAVENGER,
            3,
            3,
            0,
            1,
            0,
            true,
            false,
            false,
            // true,
            0
        );
    }


    // Emergency Functions

    // TODO:

    // EMERGENCY: Fix links if IPFS dies
    // function UpdateArtLink(uint _tokenId, string _newLink)
}
