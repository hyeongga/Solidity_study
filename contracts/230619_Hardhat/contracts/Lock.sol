// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

// Uncomment this line to use console.log
// import "hardhat/console.sol";

contract Lock {
    uint public a;
    function getA() public view returns(uint) {
        return a;
    }
    function setA(uint _a) public {
        a = _a;
    }
    function setA2(uint _a) public {
        a = _a*2;
    }
}