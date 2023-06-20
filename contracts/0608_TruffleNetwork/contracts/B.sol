// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

contract B {
  uint public b;

  constructor(uint _b){
    b = _b;
  }//migration작성시 일력필요

  function setB(uint _b) public {
    b = _b;
  }
}