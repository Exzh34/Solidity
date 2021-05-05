// Variables
// Data Types
// Custom Data Structures
pragma solidity ^0.8.1;

contract MyContract{
    // State Variables can be accessed outside of the function and its stored on the blockchain
    int public myInt = 1; 
    uint public myUint = 1; // unsigned cannot have a sign + or - 
    uint256 public myUint256 = 1; // allocates more space at cost of the perfomance
    uint8 public myUint8 = 1; // allocates less space saves memory
    string public myString = "Hello, World!";
    bytes32 public myBytes32 = "Hello, World!"; // more performance compared to string
    address public myaddress = 0xC02aaA39b223FE8D0A0e5C4F27eAD9083C756Cc2;
    
    struct MyStruct{ // defines a structure
        uint myInt;
        string myString;
    }
     MyStruct public myStruct = MyStruct(1, "Hello, World!"); // uint is 1 hello world is the string
    
    // Local Variables cannot be accessed outside of the function value is stored in the memory
    function getValue() public pure returns (uint){
        uint value = 1;
        return value;
    }
     
}
