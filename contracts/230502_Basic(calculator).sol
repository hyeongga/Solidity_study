// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.2 <0.9.0;

/*계산기 만들기*/
contract Basic2 {
     function Add(uint _a, uint _b) public pure returns(uint) {
        return _a+_b;
    }
     function Mul(uint _a, uint _b) public pure returns(uint) {
        return _a*_b;
    }
     function Sub(uint _a, uint _b) public pure returns(uint) {
        return _a-_b;
    }
     function Div(uint _a, uint _b) public pure returns(uint,uint) {
        return (_a/_b, _a%_b);
    }
}