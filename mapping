pragma solidity ^0.8.1;
//Mappings
contract myContract{
    mapping(uint => string) public names;
    mapping(uint=> Book) public books;
    mapping(address=> mapping(uint=>Book)) public myMapping;
    
    struct Book {
        string tittle;
        string author;
    }
    
    constructor() public{
        names[1] = "Adam";
        names[2] = "Bruce";
        names[3] = "Carl";
    }
    function addBook(uint _id, string memory _tittle, string memory _author) public {
        books[_id] = Book(_tittle, _author);
        
    }
    function addMyBook(uint _id, string memory _tittle, string memory _author) public {
        myMapping[msg.sender][_id] = Book(_tittle, _author);
    }
}
