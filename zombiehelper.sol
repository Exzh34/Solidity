pragma solidity >=0.5.0 <0.6.0;

import "./zombiefeeding.sol";

contract ZombieHelper is ZombieFeeding {

  modifier aboveLevel(uint _level, uint _zombieId) { // function modifier
    require(zombies[_zombieId].level >= _level); // requires zombie to be bigger or equal than a defined level
    _; // executes the rest of the function on modifier is called 
  }
  function withdraw() external onlyOwner { // function to withdraw the ether received 
    address payable _owner = address(uint160(owner())); //makes owner a type address payable by using uint160
    _owner.transfer(address(this).balance); // transfers the ether to owner and returns the total balance 
  }
  function setLevelUpFee(uint _fee) external onlyOwner{ // function for the level up fee
    levelUpFee = _fee;
  }

  function changeName(uint _zombieId, string calldata _newName) external aboveLevel(2, _zombieId) { // function for changing zombie name when zombie level = 2 using previous modifier
    require(msg.sender == zombieToOwner[_zombieId]); //  checks if the person is the owner of the zombie
    zombies[_zombieId].name = _newName; // attributes new name to the zombie 
  }

  function changeDna(uint _zombieId, uint _newDna) external aboveLevel(20, _zombieId) { // function for changing zombie dna when zombie level = 20 using previous modifier 
    require(msg.sender == zombieToOwner[_zombieId]); // checks if the person is the owner of the zombie
    zombies[_zombieId].dna = _newDna; // attributes new dna to the zombie
  }

  function getZombiesByOwner(address _owner) external view returns(uint[] memory) { // function to fetch the zombies from the owner 
    uint[] memory result = new uint[](ownerZombieCount[_owner]); // memory array to store the zombies fetched
    // Start here
    uint counter = 0; 
    for (uint i = 0; i < zombies.length; i++){ // loop checks the zombies array length 
      if (zombieToOwner[i] == _owner) { // checks the zombietoowner array for the "i" position
        result[counter] = i; stores the value of i on the result array
        counter++; // adds one to the counter
      }
    }
    return result;
  }

}
