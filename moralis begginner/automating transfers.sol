pragma solidity >=0.7.0 <0.9.0;

contract myGame { 
    uint public playerCount = 0; // uint to track the count of the players
    uint public pot = 0;
    
    address public dealer;
    
    Player[] public playersInGame;
    
    
    mapping(address => Player) public players; // records an address and links it to the player structure
    
    enum Level {Novice, Intermediate, Advanced} // enum 
    
    struct Player {
        address playerAddress;
        Level playerLevel; // level data type 
        string firstName;
        string lastName;
        uint CreatedTime;
   }
   
    constructor(){
        dealer = msg.sender;
    }
  
    function addPlayer(string memory firstName, string memory lastName) private {
        Player memory newPlayer = Player(msg.sender,Level.Novice ,firstName, lastName, block.timestamp);
        players[msg.sender] = newPlayer;
        playersInGame.push(newPlayer);
    }
    function getPlayerLevel(address playerAddress) private view returns(Level){
        Player storage player = players[playerAddress];
        return player.playerLevel;
    }
    
    function changePlayerLevel(address playerAddress) private  {
        Player storage player = players[playerAddress];
        if (block.timestamp >= player.CreatedTime + 20) {
            player.playerLevel = Level.Intermediate;
        }
    }
    
    function joinGame(string memory firstName, string memory lastName) payable public {
        require(msg.value == 25 ether,"Joining fee is 25 ether");
        // sending ether to the dealer address
        if (payable(dealer).send(msg.value)) {
            addPlayer(firstName, lastName);
            playerCount++;
            pot += 25;
        }
    }
    
    function payOutWinner(address loserAddress) payable public {
        require(msg.sender == dealer,"Only the dealer can payout the winners");
        require(msg.value == pot * (1 ether));
        uint payoutPerWinner = msg.value / (playerCount - 1);
        for (uint i = 0; i < playersInGame.length; i++) {
            address currentPlayerAddress = playersInGame[i].playerAddress;
            if (currentPlayerAddress != loserAddress){
                payable(currentPlayerAddress).transfer(payoutPerWinner);
                
            }
        }
        
    }
}
