// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.2 <0.9.0;

// 첫 4바이츠 구하기
contract getFunctionID {
    function firstFourBytes(bytes20 _a) public pure returns(bytes4) {
        return bytes4(_a);
    }
// method Id 구하기 // "함수이름(변수형,변수형)"을 keccak256한다음 앞 4바이트
    function getMethodID(string calldata _a) public pure returns(bytes4) {
        return bytes4(keccak256(bytes(_a))); 
    }
}