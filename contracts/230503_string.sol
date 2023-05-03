// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.18;

contract UintandString {
    uint a; // 0 출력
    string b; // 빈 값 출력

    function setA(uint _a) public {
        a = _a;
    }

    function setAasFive() public {
        a = 5;
    }

    function getA() public view returns(uint) {
        return a;
    }
    //string을 어디에 어떻게 저장할 것인지 명시하기 위해 memory를 써줘야 함
    function setB(string memory _b) public {
        b = _b;
    }

    function getB() public view returns(string memory) {
        return b;
    }

    function setBasC() public {
        b = "c";
    }
    //대소문자 구별 - 아스키코드로 변환하여 저장하기 때문에 가능
    function setBasC2() public {
        b = "C";
    }
    
    function setBasABC() public {
        b = "abc";
    }
    // Q. a와 b에 내가 원하는 값을 넣을 수 있는 함수 그리고 a와 b의 값을 반환하는 함수를 각각 따로 만드세요.
    function setAB(uint _a, string memory _b) public {
        a = _a;
        b = _b;
    }
    function getAB() public view returns (uint,string memory){
        return(a,b);
    }
    
}