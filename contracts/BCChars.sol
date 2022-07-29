// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

import "hardhat/console.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
// import "@openzeppelin/contracts/utils/Counters.sol";

import "./BCEvents.sol";

contract BCChars is ERC721URIStorage, Ownable {
    uint256 randSeed = 0;

    uint256 public mintCost = .00001 * 10**18;
    bool public mintIsActive = false;

    address public abilityContract;  //TODO: Add this and function to change

    // uint8 public actionsCap = 3;
    uint8 public healthCap = 4;
    uint8 public carryCap = 5;
    uint8 public defenseCap = 4;
    uint8 public hackCap = 4;
    uint8 public breachCap = 4;
    uint8 public shootCap = 4;
    uint8 public meleeCap = 4;

    uint8 public maxClonesCap = 100;  // TODO: evaluate

    uint8 abilityCap = 10;
    uint8 flawCap = 10; // TODO: These should probably pull from that contract

    uint8 public decantMin = 3;
    uint8 public decantMax = 10;

    struct Character {
        // string name;
        // uint8 actions;
        uint8 health;
        uint8 carry;
        uint8 defense;
        uint8 hack;
        uint8 breach;
        uint8 shoot;
        uint8 melee;
        uint8 cloneNumber;  // High but possibly reachable limit
        uint8 maxClones; // Eventually exit them from the economy??
        uint8 ability;
        uint8 flaw;
        bool dead;
    }

    Character[] public characters;
    mapping(uint256 => address) public characterToOwner;

    // 2 step character minting process to add sufficient randomness without
    // needing an oracle.  Note that players will be able to determine properties
    // without decanting and I should add some sort of recycling mechanism
    struct CloneTank {
        bytes32 hashBase;
        uint256 decantBlockNumber; // Which block will be used to decant this
        bool decanted;
    }

    CloneTank[] public cloneTanks;
    mapping(uint256 => address) public cloneTankToOwner;

    constructor() ERC721("Black Comet Characters", "BCC") {

    }

    function installCloneInTank() public payable {
        // TODO: Review implications of owner being able to do this
        require(msg.sender == owner() || msg.value == mintCost, "incorrect payment");
        require(msg.sender == owner() || mintIsActive == true, "minting is not active");

        // TODO: Combine with creating small random between range
        uint8 mod = decantMax - decantMin + 1;
        uint256 pRand = uint256(keccak256(abi.encodePacked(block.timestamp)));
        uint256 offset = (pRand % mod) + decantMin;

        randSeed++;
        cloneTanks.push(CloneTank(
            keccak256(abi.encodePacked(randSeed, block.timestamp, msg.sender)), // TODO: Just block.now?  Does it even add value to have more than the timestamp here?
            block.number + offset,
            false
        ));
        cloneTankToOwner[cloneTanks.length - 1] = msg.sender;
    }

    function decantNewClone(uint _id) public {
        require(cloneTankToOwner[_id] == msg.sender, "only owner can decant tank");
        require(cloneTanks[_id].decanted == false, "clone already decanted");
        require(cloneTanks[_id].decantBlockNumber <= block.number, "can't decant yet");

        cloneTanks[_id].decanted = true;

        randSeed++;
        bytes32 finalHash = keccak256(abi.encodePacked(randSeed, block.timestamp, cloneTanks[_id].hashBase));

        // Consume the hash to create pseudo-random character attributes
        // Use 3 bits for traits because we'll never need >6
        // 1 min for all normal characteristics, 2 for actions, health, carry
        // TODO: Evaluate min balance
        // TODO: Add perk for low clones allowed or mortals with 0 respawns???
        characters.push(Character(
            _smallIntBetweenVals(2, healthCap, _sliceHashToSmallInt(finalHash, 3, 3)),
            _smallIntBetweenVals(3, carryCap, _sliceHashToSmallInt(finalHash, 3, 6)),
            _smallIntBetweenVals(1, defenseCap, _sliceHashToSmallInt(finalHash, 3, 9)),
            _smallIntBetweenVals(1, hackCap, _sliceHashToSmallInt(finalHash, 3, 12)),
            _smallIntBetweenVals(1, breachCap, _sliceHashToSmallInt(finalHash, 3, 15)),
            _smallIntBetweenVals(1, shootCap, _sliceHashToSmallInt(finalHash, 3, 18)),
            _smallIntBetweenVals(1, meleeCap, _sliceHashToSmallInt(finalHash, 3, 21)),
            0,
            _smallIntBetweenVals(0, maxClonesCap, _sliceHashToSmallInt(finalHash, 8, 24)),
            _smallIntBetweenVals(0, abilityCap, _sliceHashToSmallInt(finalHash, 8, 32)),
            _smallIntBetweenVals(0, flawCap, _sliceHashToSmallInt(finalHash, 8, 40)),
            false
        ));

        _safeMint(msg.sender, characters.length - 1);
    }

    function _sliceHashToSmallInt(bytes32 _hash, uint256 _size, uint256 _offset) private pure returns(uint8) {
        bytes32 mask = bytes32((2**_size) - 1) << _offset;

        return uint8(uint256(bytes32((_hash & mask) >> _offset)));
    }

    function _smallIntBetweenVals(uint8 _min, uint8 _max, uint8 _rand) private pure returns(uint8) {
        uint8 mod = _max - _min + 1;
        return (_rand % mod) + _min;
    }


    // // BALANCE ADJUSTMENTS
    // function adjustActionsCap(uint8 _newActionsCap) public onlyOwner {
    //     require(_newActionsCap >= 1, "Can't set actions to 0");
    //     actionsCap = _newActionsCap;
    // }

    // TODO: Rest of balance functions

}
