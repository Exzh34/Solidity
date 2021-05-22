pragma solidity >=0.7.0 <0.9.0;

contract SimpleAuction {
    // Parameters of the SimpleAuction
    address payable public beneficiary;
    uint public auctionEndTime;
    
    // Current state of the auction
    address public highestBider;
    uint public highestBid;
    // mapping to keep track of what address has bid and how much
    mapping(address=>uint) public pendingReturns;
    
    bool ended = false;
    
    // tracks who is the highest bidder
    event HighestBidIncrease(address bidder, uint amount);
    // logs who is the winner when the auction ends
    event AuctionEnded(address winner, uint amount);
    
    // when it starts keeps track of who is the beneficiary and the starting time 
    constructor(uint _biddingTime, address payable _beneficiary){
        beneficiary = _beneficiary;
        auctionEndTime = block.timestamp + _biddingTime;
    }
    
    // bid function to keep track of the bidder and bids
    function bid() public payable {
        if (block.timestamp > auctionEndTime){
            
            revert("The auction has already ended");
        }
        
        if (msg.value <= highestBid){
            revert("There is a higher or equal bid");
        }
        
        if(highestBid != 0){
            pendingReturns[highestBider] += highestBid;
        }
        
        highestBider = msg.sender;
        highestBid = msg.value;
        emit HighestBidIncrease(msg.sender, msg.value);
        
    }
    
    // withdraw function to check if the withdraw has been successful
    function withdraw() public returns (bool) {
        uint amount = pendingReturns[msg.sender];
        if(amount > 0) {
            pendingReturns[msg.sender] = 0;
            
            if(!payable(msg.sender).send(amount)){
                pendingReturns[msg.sender] = amount;
                return false;
            }
        }
        return true;
    }
    // function to check if the auction has ended 
    function auctionEnd() public {
        if (block.timestamp < auctionEndTime) {
            revert ("Auction has not ended");
        }
        if (ended) {
            revert("The function AuctionEnded has been called already");
        }
        ended = true;
        emit AuctionEnded(highestBider, highestBid);
        
        beneficiary.transfer(highestBid);
    }
    
}
