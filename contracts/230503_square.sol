// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.2 <0.9.0;


contract POWER {

    // 제곱
    function square(uint a) public pure returns(uint) {
        return a**2; //a*a
    }

    // 세제곱
    function cubic(uint a) public pure returns(uint) {
        return a**3; //a*a*a
    }

    // a의 b승
    function power(uint a, uint b) public pure returns(uint) {
        return a**b;
    }
}