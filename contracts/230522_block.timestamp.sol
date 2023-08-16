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

    //timestamp에 숫자 혹은 날짜 더하기 가능
    function getTime() public view returns(uint) {
        return block.timestamp + 100;
    }

    function getTime2() public view returns(uint) {
        return block.timestamp + 10 seconds;
    }

    function getTime3() public view returns(uint) {
        return block.timestamp + 10 minutes;
    }

    function getTime4() public view returns(uint) {
        return block.timestamp + 1 hours;
    }

    function getTime5() public view returns(uint) {
        return block.timestamp + 1 days;
    }

    function getTime6() public view returns(uint) {
        return block.timestamp + 1 weeks;
    }

    /*function getTime7() public view returns(uint) {
        return block.timestamp + 1 years; //0.5.0부터 없어짐
    }*/
    

}
