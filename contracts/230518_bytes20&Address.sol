// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.2 <0.9.0;

contract bytes20AndAddress{
    bytes20 a ;
    address b = 0x5B38Da6a701c568545dCfcB03FcB875f56beddC4;

    //bytes20 => address 가능
    function A() public view returns (address){
        return address(a);
    }
    //address => bytes20 가능
    function B() public view returns(bytes20, bytes1){
        return (bytes20(b),bytes20(b)[1]); 
    } // bytes20(b)[1] : 주소의 2번째 글자 추출
}

