pragma solidity >=0.5.0 <0.6.0;

import "./zombiehelper.sol";

contract ZombieAttack is ZombieHelper {
  // Start here
  uint randNonce = 0;
  uint attackVictoryProbability = 70; // victory probability to 70%
  function randMod(uint _modulus) internal returns(uint) { // function to generate a random number
    randNonce++; // increments randNonce 
    return uint(keccak256(abi.encodePacked(now, msg.sender, randNonce))) % _modulus; // calculates uint typecast of the keccak256 hash
  }
  function attack(uint _zombieId, uint _targetId) external ownerOf(_zombieId){
    // 2. Start function definition here
    Zombie storage myZombie = zombies[_zombieId]; // storage pointer to friendly zombie
    Zombie storage enemyZombie = zombies[_targetId]; // storage pointer to enemy zombie 
    uint rand = randMod(100);
    if (rand <= attackVictoryProbability) { // if random number less or equal than 70 
      myZombie.winCount++; // incrments zombie victory count
      myZombie.level++; // increments level 
      enemyZombie.lossCount++; // increments to the enemy zombie loss
      feedAndMultiply(_zombieId,enemyZombie.dna,"zombie"); // calls feed and multiply function given zombieid, enemyzombiedna and zombie species
    }else {
      myZombie.lossCount++; // adds one to the loss count
      enemyZombie.winCount++; // adds one to the enmy zombie win count 
      _triggerCooldown(myZombie); // triggers cooldown
    }
  }
}
