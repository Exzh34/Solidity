pragma solidity >=0.5.0 <0.6.0;

contract ZombieFactory {

    event NewZombie(uint zombieId, string name, uint dna); // event to store zombie information

    uint dnaDigits = 16; // zombie dna 16 digits int
    uint dnaModulus = 10 ** dnaDigits; // 10 to the power of 16

    struct Zombie { // structure of the zombie
        string name;
        uint dna;
    }

    Zombie[] public zombies; // array using zombie struct 

    mapping (uint => address) public zombieToOwner; //maping a zombie to an owner
    mapping (address => uint) ownerZombieCount; // maping how many zombies the owner has 

    function _createZombie(string memory _name, uint _dna) private { // creates zombies
        uint id = zombies.push(Zombie(_name, _dna)) - 1; // counts the array
        zombieToOwner[id] = msg.sender; // attributes an id to a zombie
        ownerZombieCount[msg.sender]++; // adds one to the zombie count
        emit NewZombie(id, _name, _dna); // adds zombie information to the new zombie event 
    }

    function _generateRandomDna(string memory _str) private view returns (uint) { // function to generate random dna
        uint rand = uint(keccak256(abi.encodePacked(_str))); // sets random dna using eth based hash function
        return rand % dnaModulus; //  returns dna mod 16
    }

    function createRandomZombie(string memory _name) public { // creates new random zombie
        require(ownerZombieCount[msg.sender] == 0); // set a requirement owner must have 0 zombies to create a new one
        uint randDna = _generateRandomDna(_name); // generates random dna to the zombie stores it in randDna
        _createZombie(_name, randDna); // calls createzombie and attributes the values
    }

}

