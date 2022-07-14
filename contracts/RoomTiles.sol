// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

import "hardhat/console.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
// import "@openzeppelin/contracts/utils/Counters.sol";

import "./BCEvents.sol";

contract RoomTiles is ERC721URIStorage, Ownable {
    uint256 public mintCost = 1 * 10**18;
    bool public mintIsActive = false;

    // address public EventContract; // TODO
    string[] public RoomBaseMetadataList;

    enum BCEventType {NONE, BUG, MYSTERY, SCAVENGER, SHIP_SECURITY}

    // Base properties for rooms for non-variable properties in generation
    struct RoomBase {
        // string name;  // This can actually live off chain
        // string artLink; // Don't need to know art, names, or desc in-contract
        BCEventType eventType;
        uint256 eventNum; // 0 if no event in room
        bool hasWindows; // TODO: DON'T Need??, only mystery and NONE rooms have windows
        bool hasVent;
        bool hasHazard;
        //TODO:  Decide if metadata is wanted here
    }

    RoomBase[] public roomBases;

    struct RoomTile {
        uint256 roomBase;  //TODO: Can this be smaller?  Won't have 65k bases
        uint8 numDoors;
        uint8 totalDoorStrength;
        uint8 numItems;
        uint8 numData;
        uint8 numWindows;
        uint16 roomLevel;
    }

    RoomTile[] public roomTiles;
    uint256[] public publicRoomTokens;

    constructor() ERC721("Black Comet Rooms Tiles", "BCRT") {
        _buildDefaultBases();
        _mintDefaultRoomTiles();
    }

    function addRoomBase(
        BCEventType _eventType,
        uint256 _eventNum,
        bool _hasWindows,
        bool _hasVent,
        bool _hasHazard
    ) public onlyOwner {
        roomBases.push(RoomBase(
            _eventType,
            _eventNum,
            _hasWindows,
            _hasVent,
            _hasHazard
        ));
    }

    function _buildDefaultBases() internal {
        // 0 Armory
        // TODO:  Update to handle internal room
        roomBases.push(RoomBase(
            BCEventType.SCAVENGER,
            0,
            false,
            true,
            false
        ));

        // 1 Auxiliary Reactor
        roomBases.push(RoomBase(
            BCEventType.SHIP_SECURITY,
            0,
            false,
            true,
            false
        ));

        // 2 Breached Reactor
        roomBases.push(RoomBase(
            BCEventType.SHIP_SECURITY,
            1,
            false,
            false,
            true
        ));
    }

    function _mintRoom(
        address _owner,
        uint256 _roomBase,  //TODO: Can this be smaller?  Won't have 65k bases
        uint8 _numDoors,
        uint8 _totalDoorStrength,
        uint8 _numItems,
        uint8 _numData,
        uint8 _numWindows,
        uint16 _roomLevel
    ) internal {
        // TODO: Room validation - windows, doors, total strength, event, base
        roomTiles.push(RoomTile(
            _roomBase,
            _numDoors,
            _totalDoorStrength,
            _numItems,
            _numData,
            _numWindows,
            _roomLevel
        ));
        uint id = roomTiles.length -1;
        _safeMint(_owner, id);
        // _setTokenURI(id, baseMetadataLink);
    }

    function _mintDefaultRoomTiles() internal {
        // 0 Armory
        _mintRoom(
            msg.sender,
            0,
            3,
            3,
            3, //TODO: Should be in inner room.  Put behind event?
            0,
            0,
            1
        );

        // 1 Auxiliary Reactor
        _mintRoom(
            msg.sender,
            1,
            3,
            2,
            0,
            1,
            0,
            1
        );

        // 2 Breached Reactor
        _mintRoom(
            msg.sender,
            2,
            2,
            2,
            0,
            0,
            0,
            1
        );
    }


    // Emergency Functions

    // TODO:

    // EMERGENCY: Fix links if IPFS dies
    // function EmergencyUpdateMetadataLink(uint _tokenId, string _newLink)
}
