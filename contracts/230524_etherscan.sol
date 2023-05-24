// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.2 <0.9.0;

contract Number{
    uint public a;
    function setA(uint _a)public {
        a=_a;
    }
    function addNumber(uint num, uint num2, uint num3, uint num4) public pure returns(uint){
        return num+num2+num3+num4;
    }
}


//배포한 주소 값 변경
contract Change{
    Number public number;

    //주소 넣어주기 or new만들기 : 특정 주소 값 변경을 위해 주소 입력
    constructor(address numberAddress){
        number = Number(numberAddress);
    }

    function setNewNum(uint _a) public {
        number.setA (_a);
    }
}