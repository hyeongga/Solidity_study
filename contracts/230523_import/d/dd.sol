// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.2 <0.9.0;

contract D_Contract {
    function multiply(uint _a, uint _b) public pure returns(uint) {
        return _a*_a*_b;
    }
}