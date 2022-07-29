// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

import "hardhat/console.sol";
// import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Counters.sol";

// Stores information for events that happen in a specific room

contract DataSheets000001 is Ownable {

    struct UnitDataSheet {
        string name;
        string metadataJSONLink;
        uint16 movement; // meters
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
        // uint8 class;
    }

    struct WeaponDataSheet {
        string name;
        string metadataJSONLink;
        uint16 range; // meters
        uint8 shots;
        uint8 damage;
        bool variableShots;
        bool variableDamage;
        bool selectiveFire; // 2x shots at half range
        int8 accuracy;
        // uint8 type
    }

    struct ArmyFaction {
        string name;
        string metadataJSONLink;
        UnitDataSheet[] allowedUnits;
        WeaponDataSheet[] allowedWeapons;
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

    ArmyFaction[] public armyFactions;

    constructor() {
        _initializeDefaultDataSheets();
    }

    function addDataSheet() external onlyOwner {

    }

    function _initializeDefaultDataSheets() internal {
        // 0 Space Marines
        ArmyFaction memory marines;
        marines.name = "Space Marines";
        marines.metadataJSONLink = "TODO";
        armyFactions.push(marines);

        // 0-0 Space Marine Squad
        UnitDataSheet memory spaceMarineSquad;
        spaceMarineSquad.name = "Space Marine Infantry Squad";
        spaceMarineSquad.metadataJSONLink = "TODO";
        spaceMarineSquad.movement = 15;
        spaceMarineSquad.accuracy = 6;
        spaceMarineSquad.martial = 6;
        spaceMarineSquad.initiative = 6;
        spaceMarineSquad.defense = 6;
        spaceMarineSquad.health = 6;
        spaceMarineSquad.discipline = 6;

        armyFactions[0].allowedUnits.push(spaceMarineSquad);

        // 1 Space Elves
        ArmyFaction memory elves;
        elves.name = "Space Elves";
        elves.metadataJSONLink = "TODO";
        armyFactions.push(elves);

        // 1-0 Space Elf Squad
        UnitDataSheet memory spaceElfSquad;
        spaceElfSquad.name = "Space Elf Infantry Squad";
        spaceElfSquad.metadataJSONLink = "TODO";
        spaceElfSquad.movement = 20;
        spaceElfSquad.accuracy = 7;
        spaceElfSquad.martial = 7;
        spaceElfSquad.initiative = 7;
        spaceElfSquad.defense = 7;
        spaceElfSquad.health = 4;
        spaceElfSquad.discipline = 6;

        // 2 Space Robots
        ArmyFaction memory robots;
        robots.name = "Space Robots";
        robots.metadataJSONLink = "TODO";
        armyFactions.push(robots);
    }

    function setWeaponDataSheetContract(address contractAddress) external onlyOwner {
        weaponDataSheetContract = contractAddress;
    }
}
