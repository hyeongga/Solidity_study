// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.2 <0.9.0;

contract Require1{

    //require : 조건을 만족하면 함수 실행
    function Require(uint _n)public pure returns(uint){
        require(_n<10, "input should be lower than 10"); //require(조건문, "만족하지 않을 시 메세지")
        return _n*3;
    }

    function getName(string memory _name) public pure returns(bytes32){
        return keccak256(abi.encodePacked(_name));
    }

    //input값으로 alice 넣어서 비교
    //keccak256(abi.encodePacked(alice)) = 0x9c0257114eb9399a2985f8e75dad7600c5d89fe3824ffa99ec1c3eb8bf3b0501
    function onlyAlice(string memory _name) public pure returns(bool){
        require(getName(_name)==0x9c0257114eb9399a2985f8e75dad7600c5d89fe3824ffa99ec1c3eb8bf3b0501);
        return true;
    }

}

contract Require2{

    function getBool() public pure returns(bool){
        bool _a;
        return _a;
    }
    
    function require1() public pure returns(uint){
        uint _a = 1;
        bool b; //기본값 false
        require(b,"Error");  // 통과못함
        return _a;
    }
    
    function require2() public pure returns(uint) {
        uint _a = 1;
        bool b;
        return _a;
        require(b, "Error"); // Unrecheable code ;작동되지 않음
    } //return 실행됨, a = 1

    
    uint a=1;
    function getA() public view returns(uint){
        return a;
    }

    //return이 없고, require이 제일 마지막에 있을 경우
    function require3() public {
        bool c;
        a=5;
        require(c,"Error"); // return이 작동하지 않았기 떄문에 a를 5로 바꾼 것도 전부 다 다시 revert(원래 상태로 복구)시킴
    }

    // 타 함수 호출 코드가 포함되어 있을 경우
    function setAsFive() public {
        a=5;
    }

    function require4() public {
        bool c;
        setAsFive();  // a의 값을 5로 설정하는 외부 함수
        require(c, "error"); //setAsFive(외부함수)도 모두 revert
    }

    //require 조건 2개 (&&연산자)
    function require5(uint _n) public pure returns(bool){
        require(_n%5==0 && _n>10,"Nope");
        return true;
    }

    // if문 안의 require
    function require6(uint _a) public pure returns(uint) {
        if(_a%3==0) {
            require(_a%3!=0, "nope");
            return _a%3;
        } else if(_a%3==1) {
            return _a%3;
        } else {
            return _a%3;
        }
    }

}
