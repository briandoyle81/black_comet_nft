// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

import "hardhat/console.sol";

import "@openzeppelin/contracts/access/Ownable.sol";

// Contract holds base data to use for creating rooms
// Non-variables

// Actually, I don't think I need this, only the front end needs this stuff

contract BCRoomBases is Ownable {
    struct RoomBase {
        // Copied from metadata
        string name;
        string artLink;
        string description;
        string metadataLink;
    }

    RoomBase[] public roomBases;

    event EmergencyRoomUpdate(
        RoomBase updatedRoom
    );

    function createRoomBase(
        string memory _name,
        string memory _artLink,
        string memory _description,
        string memory _metadataLink
    ) public onlyOwner {
        roomBases.push(RoomBase(
            _name,
            _artLink,
            _description,
            _metadataLink
        ));
    }

    // Emergency functions to update base properties
    function EmergencyUpdateRoomName(
        uint _id,
        string memory _name
    ) external {
        roomBases[_id].name = _name;

        emit EmergencyRoomUpdate(roomBases[_id]);
    }

    function EmergencyUpdateRoomArtLink(
        uint _id,
        string memory _artLink
    ) external {
        roomBases[_id].artLink = _artLink;

        emit EmergencyRoomUpdate(roomBases[_id]);
    }

    function EmergencyUpdateRoomDescription(
        uint _id,
        string memory _description
    ) external {
        roomBases[_id].description = _description;

        emit EmergencyRoomUpdate(roomBases[_id]);
    }

    function EmergencyUpdateRoomMetadataLink(
        uint _id,
        string memory _metadataLink
    ) external {
        roomBases[_id].metadataLink = _metadataLink;

        emit EmergencyRoomUpdate(roomBases[_id]);
    }

}
