pragma solidity >=0.5.0 <0.6.0;

import "./ownable.sol";

contract ZombieFactory is Ownable {

    event NewZombie(uint zombieId, string name, uint dna); // event for the creation of new zombie

    uint dnaDigits = 16; // size of dna
    uint dnaModulus = 10 ** dnaDigits; // dna mod 16
    uint cooldownTime = 1 days; // cooldown time

    struct Zombie { // zombie structrure 
      string name;
      uint dna;
      uint32 level;
      uint32 readyTime;
      uint16 winCount;
      uint16 lossCount; 
    }

    Zombie[] public zombies; // zombie array

    mapping (uint => address) public zombieToOwner;
    mapping (address => uint) ownerZombieCount;

    function _createZombie(string memory _name, uint _dna) internal { // function to create a zombie
        uint id = zombies.push(Zombie(_name, _dna, 1, uint32(now + cooldownTime), 0, 0)) -1; // adds the attributes to the uint id
        zombieToOwner[id] = msg.sender; // attributes the zombie based on id to the owner
        ownerZombieCount[msg.sender]++; // adds one to the zombie count
        emit NewZombie(id, _name, _dna); // calls event to create a new zombie
    }

    function _generateRandomDna(string memory _str) private view returns (uint) { // generate random dna using keccak256 hash 
        uint rand = uint(keccak256(abi.encodePacked(_str)));
        return rand % dnaModulus;
    }

    function createRandomZombie(string memory _name) public { // creates random zombie
        require(ownerZombieCount[msg.sender] == 0); // see if the person is the owner of the zombie
        uint randDna = _generateRandomDna(_name); // generates random dna based on name 
        randDna = randDna - randDna % 100;
        _createZombie(_name, randDna); // calls function createzombie with the given attributes 
    }

}
