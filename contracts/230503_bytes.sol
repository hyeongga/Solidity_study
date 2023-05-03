// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.18;

/*
실습 가이드
1. 0x16을 넣고 setA 실행하기
2. getA -> 0x16 결과 확인
3. setA2 
4. getA -> 0x3136 결과 확인 
5. abc를 넣고 setA3 실행하기
6. getA -> 0x616263 결과 확인
*/

contract BYTES {
    bytes a; // 0x 출력

    function setA(bytes memory _a) public {
        a = _a;
    }

    function setA2() public {
        a = "16";
    }

    function setA3(string memory _a) public {
        a = bytes(_a);
    }

    function getA() public view returns(bytes memory) {
        return a;
    }
}