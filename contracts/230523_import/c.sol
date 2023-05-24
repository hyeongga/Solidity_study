// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.2 <0.9.0;

//외부 라이브러리 사용하는 법(git) ; import하는 법
import "@openzeppelin/contracts/utils/Strings.sol";

contract C{
    function UtoS(uint _n) public pure returns(string memory){
        return  Strings.toString(_n);
    } 
}