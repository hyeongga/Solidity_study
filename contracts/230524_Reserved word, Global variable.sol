// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.2 <0.9.0;

contract time{
    function currentTime() public view returns(uint){
        return block.timestamp;
    }

    function getTime()public view returns(uint){
        return block.timestamp +100;
    }

    //예약어 : hours, minutes, seconds ... ( 1 years는 버전 업그레이드 하면서 이제 사라짐 )
    function getTime2() public view returns(uint){
        return block.timestamp + 1 hours + 10 minutes + 10 seconds + 1 days + 1 weeks ;
    }

}


contract ADDRESS{
    function getBalance(address _a) public view returns(uint){
        return _a.balance;
    }
    //bytescode출력
    function getCode(address _a) public view returns(bytes memory){
        return _a.code;
    }

    function getCodeHash(address _a) public view returns(bytes32){
        return _a.codehash;
    }

}