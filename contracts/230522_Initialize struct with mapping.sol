// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.2 <0.9.0;

contract structuWithMapping {

    struct user {
        string name;
        address addr;
        string[] suggested;
        mapping(string=>bool) voted;
    }

    user[] Users;

    function setUser() public {
        Users.push();
    }

	function getUsers() public view returns(uint) {
        return(Users.length);
    }

    function getUser(uint _n) public view returns(string memory, address, string[] memory) {
        return (Users[_n].name, Users[_n].addr, Users[_n].suggested);
    }

}

contract example{   
    struct Person{
        string name;
        uint number;
        address wallet;
        mapping(uint => string) numToName;
    }

    Person[] public people;
    uint i;

    function setPeople(string memory _name) public {
        people.push();
        people[i].name = _name;
        people[i].number = i;
        people[i].wallet = msg.sender;
        people[i].numToName[i] = _name;
        i++;
    }
}
