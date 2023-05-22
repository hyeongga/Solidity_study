// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.2 <0.9.0;

contract REVERSEARRAY{

    //하나하나 순서를 정해서 바꾸는 방법
    function reverse(uint[] calldata numbers) public pure returns(uint[] memory){
        uint[] memory _reverse = new uint[](numbers.length);
        for(uint i=0; i<numbers.length;i++){
            _reverse[i] = numbers[numbers.length-i-1];
        }
        return _reverse;
     }

     //반을 쪼개서 대칭끼리 서로 자리교환
     function reverse2(uint[] memory numbers) public pure returns (uint[] memory){
         for(uint i=0; i<numbers.length/2;i++){
            (numbers[i],numbers[numbers.length-1])=(numbers[numbers.length-1],numbers[i]);
         }
         return numbers;
     }
}