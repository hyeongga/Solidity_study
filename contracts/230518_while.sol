// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.2 <0.9.0;

contract WHILE {
    function while_1(uint _n) public pure returns(uint){
        uint _a;
        while(_n > _a) {
            _a++;
        }
        return _a;
    }

    uint[] public a;
    function while_2(uint _n) public returns(uint[] memory){
        while(a.length < _n) {
            a.push(a.length+1);
        }
        return a;
    }

    // 숫자의 자릿수 알 수 있음
    function while_3(uint _n) public pure returns(uint) {
        uint _a;
        while(_n >= 10**_a) {
            _a++;
        }
        return _a;
    }
}