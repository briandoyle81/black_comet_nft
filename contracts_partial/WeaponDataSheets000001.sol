// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

import "hardhat/console.sol";
// import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Counters.sol";

// Stores information for events that happen in a specific room

contract WeaponDataSheets000001 is Ownable {

    // Base numbers.  Can range +/- 10% when minted
    struct UnitDataSheet {
        string name;
        string metadataJSONLink;
        uint16 movement;
        AllowedWeapon[] allowedWeapons;
        AllowedEquipment[] allowedEquipment;
        // uint16[] allowedSpecials;
        uint8 maxUnitSize;
        uint8 pointsPer;
        uint8 accuracy;
        uint8 martial;
        uint8 initiative;
        uint8 defense;
        uint8 health;
        uint8 discipline;
    }

    struct ArmyFaction {
        string name;
        string metadataJSONLink;
        UnitDataSheet[] allowedUnits;
    }

    struct AllowedWeapon {
        uint8 max;
        uint8 per;
        bool onlySargeant;
        uint24 weaponId;
    }

    struct AllowedEquipment {
        uint8 max;
        uint8 per;
        bool onlySargeant;
        uint24 equipmentId;
    }

    constructor() {
        _initializeDefaultDataSheets();
    }

    function addDataSheet() external onlyOwner {

    }

    function _initializeDefaultDataSheets() internal {
        // Space Troopers


        // Space Elves


        // Space Robots
    }
}
