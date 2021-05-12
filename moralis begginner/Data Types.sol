pragma solidity >=0.7.0 <0.9.0;

contract myGame { 
    uint public playerCount = 0; // uint to track the count of the players
    // Player[] public players;  an array of the datatype Player only holds value of the struct Player
    mapping(address => Player) public players; // records an address and links it to the player structure
    
    enum Level {Novice, Intermediate, Advanced} // enum 
    
    struct Player {
        address playerAddress;
        Level playerLevel; // level data type 
        string firstName;
        string lastName;
        
   }
    function addPlayer(string memory firstName, string memory lastName) public {
        //players.push(Player(firstName,lastName)); adds the value to the Player array 
        players[msg.sender] = Player(msg.sender,Level.Novice ,firstName, lastName);
        playerCount += 1; //increments playercount 
    }
    
    function getPlayerLevel(address playerAddress) public view returns(Level){
        return players[playerAddress].playerLevel; // returns the value of the player level access 
        
    }
}
