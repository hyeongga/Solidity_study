// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.2 <0.9.0;

contract multipleMapping{
    
    struct user{
        uint number;
        string name;
    }

    uint[] A;
    user B;

    mapping(address => uint) balance;
    mapping(address => mapping (string=> uint)) bankAccounts;
    
    //Q. struct는 키나 밸류값이 될 수 있을까?  A. 레퍼런스 타입은 키값으로 사용불가, 밸류값으로는 사용 가능 함
    mapping(address => mapping (string=> user)) bankAccounts2; /*struct와 같은 refernce type 변수는 오직 value로만 사용가능*/
    mapping(string=>mapping(string=>mapping(uint=>user))) bankAccounts3;
    mapping(address=>uint[]) As;
    // mapping(uint[]=>address) As2; /*array역시 key로는 사용할 수 없음*/

    function setBalance()public {
        balance[msg.sender] = (msg.sender).balance;
    }

    //이중매핑 사용법
    function setBankAccounts(string calldata _name) public {
        bankAccounts[msg.sender][_name] = 100;
    }
    // 삼중매핑 사용법
    function setBankAccounts2(string calldata _city, string calldata _state, uint number) public {
        bankAccounts3[_city][_state][number] = B;
    }
    //이중매핑 값
    function getbankAccounts(address _addr, string calldata _name) public view returns(uint) {
        return bankAccounts[_addr][_name];
    }
}