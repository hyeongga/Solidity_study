// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.2 <0.9.0;

/*
1000000000000000000 ;ether
0x5B38Da6a701c568545dCfcB03FcB875f56beddC4 ; 1번 지갑주소
0xAb8483F64d9C6d1EcF9b849Ae677dD3315835cb2 ; 2번 지갑주소
*/

contract Payable {

    address payable owner; //payable : 지갑잔고를 바꿈 ; 가스비 소모
    address a;
    
    // msg.sender가 컨트랙트에게 돈을 보냄
    // 컨트랙트가 돈을 가지고 있을 수 있음 / 함수를 실행해야 돈이 보내짐
    function deposite() public payable returns(uint){
        return msg.value;
    } 

    receive() external payable {}  
    //receive함수는 이더를 받을 때 실행되는 함수로, 받는 주소가 컨트랙트 주소일 때 실행된다.
    // 돈을 보내는 거래에 아무것도 안적혀있다? (받는 사람이 없는 경우? 받는지갑이 컨트랙트일 경우, 별도의 명령 없이 실행됨 (아무 이름이 안 붙어서 올 경우 실행됨))
    //상대방이 돈을 전송하는 거래를 일으켰을 때,(받는 사람이 스마트 컨트랙트라면?) 아무 이름(함수명 없는 상태)이 안붙어서 올 경우 반환.

    fallback() external payable {} 
    // 호출을 하려했는데 contract안에 함수가 없을 때 fallback 반환 ; 에외처리
    //fallback함수는 무기명 함수 즉, 이름이 없는 함수로 불리며 컨트랙트에서 하나의 default함수와 같다.
    // fallback함수는 직접 호출되지 않고, 호출된 함수가 정의되지 않은 함수일 때 실행된다.

    function setOwner() public {
        owner = payable(msg.sender); //거래를 일으키는 사람
    }

    function getOwner() public view returns(address payable ){
        return owner;
    }

    function setA() public {
        a = payable( msg.sender);
    }

    function getA() public view returns(address){
        return a;
    }

    //payable이 붙어 있어야 돈을 받을 수 있음
    function transferTo(address payable _to, uint _amount)public {
        _to.transfer(_amount); //지갑주소.transfer(규모)
    }

    function transferToOwner(uint _amount)public {
        owner.transfer(_amount);
    }

    /*function transferToA(uint _amount)public {
        a.transfer(_amount); // a는 payable이 없어서 오류 발생
    }*/

}

contract Sorting{
    uint[] numbers;

    function push(uint _n) public {
        numbers.push(_n);
    }
    //i기준 정렬
    function sorting() public {
        for(uint i;i<numbers.length-1;i++){
            for (uint j=i+1; j<numbers.length;j++){
                if (numbers[i]<numbers[j]){
                    (numbers[i], numbers[j]) = (numbers[j], numbers[i]);
                }
            }

        }
    }
    //j기준 정렬
    function sorting2() public {
        for(uint j=1; j<numbers.length;j++){
            for(uint i=0;i<j; i++){
                if(numbers[i]<numbers[j]){
                (numbers[i], numbers[j]) = (numbers[j], numbers[i]);
                }
            }
        }
    }

    function get() public view returns(uint[] memory){
        return numbers;
    }

}