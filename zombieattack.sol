pragma solidity >=0.5.0 <0.6.0;

import "./zombiehelper.sol";

contract ZombieAttack is ZombieHelper {
  // Start here
  uint randNonce = 0;
  function randMod(uint _modulus) internal returns(uint) { // function to generate a random number
    randNonce++; // increments randNonce 
    return uint(keccak256(abi.encodePacked(now, msg.sender, randNonce))) % _modulus; // calculates uint typecast of the keccak256 hash
  }
}
