pragma solidity ^0.8.1;

contract HotelRoom {
    // Ether - pay smart contracts
    // Visibility
    // Enums
    enum Statuses { Vacant, Occupied } // keeps track of the options
    Statuses currentStatus;
     // Events
    event Occupy(address _occupant, uint _value);
    
    address payable public owner; // sets the owner aka person who receives the payments
    
    constructor() public { // constructor gets runned once when the contract is created
        owner = payable(msg.sender); // msg.sender eth address of the user calling the addres
        currentStatus =  Statuses.Vacant; // sets statuses to Vacant when contract is deployed
    }
    
    // Modifiers
    modifier onlyWhileVacant {
        require(currentStatus == Statuses.Vacant, "Currently Occupied."); // ensures conditions (price/status) is met before executing
        _;    // executes the function body
    }
    modifier costs(uint _amount){
        require(msg.value >= _amount, "Not enough ether provided");// ensures conditions (price/status) is met before executing
        _;
    }
    // Functions
    receive() external payable onlyWhileVacant costs(2 ether)  {
        currentStatus = Statuses.Occupied; // changes status to occupied when the room is booked
        owner.transfer(msg.value);
        emit Occupy (msg.sender, msg.value);
    }
    
}
