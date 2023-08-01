// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

contract B {
  uint public b;

//constructor 사용
//migration작성시 입력필요
  constructor(uint _b){
    b = _b;
  }

  function setB(uint _b) public {
    b = _b;
  }
}