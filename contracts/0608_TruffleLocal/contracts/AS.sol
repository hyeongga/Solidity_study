// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

contract ADD {
  uint a=10;
  function add(uint _a, uint _b) public pure returns(uint) {
    return _a+_b;
  }

  function setA(uint _a) public{
    a = _a;
  }
}

contract SUB {
  function sub(uint _a, uint _b) public pure returns(uint) {
    return _a-_b;
  }
}