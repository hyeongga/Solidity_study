// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

contract AAA {
  uint public a = 100;

  function setA(uint _a) public {
    a = _a;
  }

  function add(uint _a, uint _b) public pure returns(uint) {
    return _a+_b;
  }
}