// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

contract A {
    uint public aa;
    constructor(uint a) {
        aa = a;
    }
}

contract B is A(1111) {
    uint public b;
}

contract B2 is A {
    uint public b;
    /*A:1 초기값 넣고, b의 초기값 설정해줄때*/
    constructor() A(1) {
        b = 2;
    }
}

contract B3 is A {
    uint public b;
    constructor(uint _b) A(_b+10) {
        b = _b;
    }
}