// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

contract MUL {
  uint public b =15;
  function mul(uint _a, uint _b) public pure returns(uint) {
    return _a*_b;
  }

  function setB(uint _b) public{
    b = _b;
  }
}

contract DIV {
  function div(uint _a, uint _b) public pure returns(uint) {
    return _a/_b;
  }

}
