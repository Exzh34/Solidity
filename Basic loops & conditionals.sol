pragma solidity ^0.8.1;
contract myContract {
    //conditionals
    //loops
    uint[] public numbers = [1,2,3,4,5,6,7,8,9,10]; 
    address public owner;
    
    constructor() public {
        owner = msg.sender;
    }
    
    function countEven() public view returns (uint){
        uint count = 0;
        
        for(uint i = 0; i < numbers.length; i++){ // counts through each number in the array
            if (isEvenNumber(numbers[i])){
                count ++ ;
            }
            
        }
        return count;
    }
    
    function isEvenNumber(uint _number) public view returns(bool) { // checks if number is even or not 
        if(_number % 2 == 0){
            return true;
        }
        else {
            return false;
        }
    }
    function isOwner() public view returns (bool){
        // simpler way return(msg.sender == owner);
        if(msg.sender == owner){
            return true;
        }
        else {
            return false;
        }
    }
}
