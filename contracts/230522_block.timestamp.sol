// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.2 <0.9.0;

contract Time {
    //스마트 컨트랙트가 생성될때의 timestamp
    uint public currentTime = block.timestamp;

    //함수를 작동시키는 순간의 timestamp
    function currentTime2() public view returns(uint){
        return block.timestamp;
    } 

    function currentBlockNumber() public view returns(uint){
        return block.number;
    } //전역변수도 view사용
    

}
