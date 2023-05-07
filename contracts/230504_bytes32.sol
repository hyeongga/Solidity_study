// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.2 <0.9.0;

contract BYTES{
    bytes a;//0x
    bytes1 b;//0x00 ; 1 = 8bytes =2자리 
    bytes2 c;//0x0000 ; 2 = 4자리
    bytes32 d; // 선언할 수 있는 정적인 값중엔 32가 최대(64자리) //그러나 bytrs32 != bytes memory; 32는 정적으로 정해져있음, memory는 동적으로 존재

    //bytes의 경우 자리수 딱 맞춰줘야함 ('0' 사용)
    function setABC(bytes memory _a, bytes1  _b, bytes2 _c, bytes32 _d)public {
        a=_a;
        b=_b;
        c=_c;
        d=_d;

    }

    function getABC() public view returns(bytes memory, bytes1, bytes2, bytes32) {
        return(a,b,c,d);
    }
    
    }