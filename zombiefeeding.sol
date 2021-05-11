pragma solidity >=0.5.0 <0.6.0;

import "./zombiefactory.sol";

contract KittyInterface {
  function getKitty(uint256 _id) external view returns (
    bool isGestating,
    bool isReady,
    uint256 cooldownIndex,
    uint256 nextActionAt,
    uint256 siringWithId,
    uint256 birthTime,
    uint256 matronId,
    uint256 sireId,
    uint256 generation,
    uint256 genes
  );
}

contract ZombieFeeding is ZombieFactory {

  KittyInterface kittyContract; 
  
  modifer ownerOf(uint _zombieId){ // creates modifier to check the owner
    require(msg.sender == zombieToOwner[_zombieId]); // require see is the person is the owner of the zombie 
    _;
  }

  function setKittyContractAddress(address _address) external onlyOwner { // function takes the address, external modifier from onlyOwner
    kittyContract = KittyInterface(_address); // sets kittycontract to the address on kitty interface
  }

  function _triggerCooldown(Zombie storage _zombie) internal { // function to trigger a cooldown on level up
    _zombie.readyTime = uint32(now + cooldownTime); // calculates the cooldown time attributes it to _zombie.readyTime
  }

  function _isReady(Zombie storage _zombie) internal view returns (bool) { // check if cooldown has ended 
      return (_zombie.readyTime <= now); 
  }

    function feedAndMultiply(uint _zombieId, uint _targetDna, string memory _species) internal onlyOwner { // function for feeding the zombie on cryptokittie
    Zombie storage myZombie = zombies[_zombieId];
    require(_isReady(myZombie)); // check if zombie is ready to be fed 
    _targetDna = _targetDna % dnaModulus; // checks for 16 integer dna count 
    uint newDna = (myZombie.dna + _targetDna) / 2; // adds zombie dna + the target dna and divides by 2 to get 16 int
    if (keccak256(abi.encodePacked(_species)) == keccak256(abi.encodePacked("kitty"))) { // condition checks for species is kitty
      newDna = newDna - newDna % 100 + 99;
    }
    _createZombie("NoName", newDna); // creates new zombie with the new dna 
    _triggerCooldown(myZombie); // triggers the cooldown so it dont gets abused
  }

  function feedOnKitty(uint _zombieId, uint _kittyId) public { // function for kitty feeding 
    uint kittyDna; 
    (,,,,,,,,,kittyDna) = kittyContract.getKitty(_kittyId); // attributes the kitty dna to a kitty ID 
    feedAndMultiply(_zombieId, kittyDna, "kitty"); // passes the parameters to feed and multiply function
  }
}
