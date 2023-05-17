// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.2 <0.9.0;

// 정지는 속도가 0인 상태, 운전 중은 속도가 있는 상태이다. 
contract testAnswer{
    //자동차의 상태에는 정지, 운전중, 시동 끔, 연료없음 총 4가지 상태가 있습니다. ✅
    enum Status{
        stop,
        driving,
        Off,
        noFuel
    }

    struct Car{
        Status status;
        uint speed;
        uint fuel;
    }

    Car public myCar;

    address payable public boss;

    
    constructor() {
        boss = payable(0xAb8483F64d9C6d1EcF9b849Ae677dD3315835cb2);
        // owner = payable(msg.sender) -> 2번지갑으로 배포해야함
    }


    // * 악셀 기능 - 속도를 1 올리는 기능, 악셀 기능을 이용할 때마다 연료가 2씩 줄어듬, 연료가 30이하면 더 이상 악셀을 이용할 수 없음, 70이상이면 악셀 기능은 더이상 못씀
    function accel() public {
        myCar.speed++;
        myCar.fuel -=2;
        require(myCar.fuel >30 && myCar.speed<70 && myCar.status != Status.Off, "Can't use accelerator");
        if(myCar.status != Status.driving){
            myCar.status = Status.driving;
        }
    }

    // * 브레이크 기능 - 속도를 1 줄이는 기능, 속도가 0인 상태, 브레이크 기능을 이용할 때마다 연료가 1씩 줄어듬, 속도가 0이면 브레이크는 더이상 못씀
    function Break() public {
        require(myCar.status != Status.Off && myCar.status != Status.stop, "Can't use break");
        myCar.speed--;
        myCar.fuel--;
        if (myCar.speed==0){
            myCar.status = Status.stop;
        }
        if(myCar.fuel == 0){
            myCar.status = Status.noFuel;
        }
    }

    // * 시동 끄기 기능 - 시동을 끄는 기능, 속도가 0이 아니면 시동은 꺼질 수 없음
    function Off() public {
        require(myCar.speed==0 && myCar.status != Status.Off || myCar.fuel ==0 , "Speed should be 0");
        myCar.status = Status.Off;
        if (myCar.speed !=0){
            myCar.speed=0;
        }
    }

    // * 시동 켜기 기능 - 시동을 켜는 기능, 시동을 키면 정지 상태로 설정됨
    function On() public {
        require(myCar.status == Status.Off && myCar.fuel >0 );
        myCar.status = Status.stop;
    }

    // * 주유 기능 - 주유하는 기능, 주유를 하면 1eth를 지불해야하고 연료는 100이 됨 (지불은 smart contract에게 함.)
    function reCharge() public payable {
        require(((point >10**18 && msg.value ==0) || msg.value == 10**18 )&& myCar.status == Status.Off);
        if(msg.value != 10**18){
            point -= 10**18;
        }
        myCar.fuel = 100;
    }

    // * 주유소 사장님은 2번 지갑의 소유자임, 주유소 사장님이 withdraw하는 기능
    function withdraw() public{
        boss.transfer(address(this).balance); //주유소에 있는 전체금액 다 출금
        require(boss == msg.sender,"only boss can use");
        // require(boss == 0xAb8483F64d9C6d1EcF9b849Ae677dD3315835cb2,"only boss can use");
    }

    // * 지불을 미리 하고 주유시 차감하는 기능
    uint public point;
    function prePay() public payable {
        require(msg.value > 0 ether, "You should pay ether.");
        point += msg.value;
        
    }
}



