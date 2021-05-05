//Arrays
pragma solidity ^0.8.1;

contract MyContract{
   // array
   uint[] public uintArray = [1,2,3];
   string[] public stringArray = ["apple","banana","carrot"];
   string[] public values;
   uint[][] public array2D = [[1,2,3], [4,5,6]]; // two dimensional array 
   function addValue(string memory _value) public { // "_" represents the value that has to be passed in
       values.push(_value);  // push takes one argument and adds it to end of the array in this case to the values array
   }
   function valueCount() public view returns (uint){
       return values.length;
   }

}
