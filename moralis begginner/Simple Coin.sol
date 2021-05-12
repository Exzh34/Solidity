pragma solidity >=0.7.0 <0.9.0;

contract Coin {
    address public minter;
    mapping (address => uint) public balances;
    
    event Sent (address from, address to, uint amount); // logs the events to the blockchain 
    
    modifier onlyMinter {
        require(msg.sender == minter, "Only minter can call this function!"); // requires current person to be the same as minter
        _;
    }
    
    modifier amountGreaterThan(uint amount) {
        require(amount < 1e60); // requires the amount of transact to be less than 1e60
        _;
    }
    
    modifier balanceGreaterThanAmount(uint amount){
        require(amount <= balances[msg.sender], "Not enough balance"); // require to see if the person has enough 
        _;
    }
    constructor() {
        minter = msg.sender;
    }
    
    function mint(address receiver, uint amount) public onlyMinter amountGreaterThan(amount) {
        balances[receiver] += amount; // if the above are true adds the amount to receiver
        
    }
    function send(address receiver, uint amount) public balanceGreaterThanAmount(amount) {
        balances[msg.sender] -= amount; // subtracts the amount of the sender wallet
        balances[receiver] += amount; // adds the amount to the receiver
        emit Sent(msg.sender, receiver, amount); // calls event with the address from, to, and the amount
    }
}
