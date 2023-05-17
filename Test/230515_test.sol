// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.2 <0.9.0;

/*자동차를 운전하려고 합니다.
자동차의 상태에는 정지, 운전중, 시동 끔, 연료없음 총 4가지 상태가 있습니다.

정지는 속도가 0인 상태, 운전 중은 속도가 있는 상태이다. 

* 악셀 기능 - 속도를 1 올리는 기능, 악셀 기능을 이용할 때마다 연료가 2씩 줄어듬, 연료가 30이하면 더 이상 악셀을 이용할 수 없음, 70이상이면 악셀 기능은 더이상 못씀
* 브레이크 기능 - 속도를 1 줄이는 기능, 브레이크 기능을 이용할 때마다 연료가 1씩 줄어듬, 속도가 0이면 브레이크는 더이상 못씀
* 시동 끄기 기능 - 시동을 끄는 기능, 속도가 0이 아니면 시동은 꺼질 수 없음
* 시동 켜기 기능 - 시동을 켜는 기능, 시동을 키면 정지 상태로 설정됨
* 주유 기능 - 주유하는 기능, 주유를 하면 1eth를 지불해야하고 연료는 100이 됨

지불은 smart contract에게 함.
----------------------------------------------------------------------------------------
* 주유소 사장님은 2번 지갑의 소유자임, 주유소 사장님이 withdraw하는 기능
* 지불을 미리 하고 주유시 차감하는 기능 
*/


contract test{
    enum status{
        stop,
        driving,
        Off,
        noFuel
    }

    status car;
    uint speed;
    uint fuel;

    address customer;
    address gasStation; //스마트 컨트렉트?
    address boss;


    // * 악셀 기능 - 속도를 1 올리는 기능, 악셀 기능을 이용할 때마다 연료가 2씩 줄어듬, 연료가 30이하면 더 이상 악셀을 이용할 수 없음, 70이상이면 악셀 기능은 더이상 못씀
    function accel() public {
        speed++;
        fuel -=2;
        require(fuel >30 && speed<70, "Can't use accelerator");
    }

    // * 브레이크 기능 - 속도를 1 줄이는 기능, 속도가 0인 상태, 브레이크 기능을 이용할 때마다 연료가 1씩 줄어듬, 속도가 0이면 브레이크는 더이상 못씀
    function Break() public {
        require(speed>0, "Can't use break");
        speed--;
        fuel--;
    }

    // * 시동 끄기 기능 - 시동을 끄는 기능, 속도가 0이 아니면 시동은 꺼질 수 없음
    function Off() public {
        car = status.Off;
        require(speed==0, "Speed should be 0");
    }

    // * 시동 켜기 기능 - 시동을 켜는 기능, 시동을 키면 정지 상태로 설정됨
    function On() public {
        car = status.stop;
        speed = 0;
    }

    // * 주유 기능 - 주유하는 기능, 주유를 하면 1eth를 지불해야하고 연료는 100이 됨 (지불은 smart contract에게 함.)
    // address payable smartcontract;  //확인용
    // function fueling() public payable returns(address,uint, address) {
    //     smartcontract = payable (address (this)); //확인용
    //     // if (points>1){
    //     //     points-1;
    //     // }else{
    //         require(msg.value == 1 ether, "You should pay 1 ether.");
    //     // }
    //     fuel = 100;
    //     return (msg.sender,msg.value,smartcontract);  //확인용    
    // }
     // * 주유 기능 - 주유하는 기능, 주유를 하면 1eth를 지불해야하고 연료는 100이 됨 (지불은 smart contract에게 함.)
    function fueling() public payable {
        if (points >=1){
            fuel = 100;
            points --;
        }else{
        require(msg.value == 1 ether, "You should pay 1 ether.");
        fuel = 100;        
        }
    }

    // * 주유소 사장님은 2번 지갑의 소유자임, 주유소 사장님이 withdraw하는 기능
    function withdraw(address payable _boss, uint _amount) public{
        _boss.transfer(_amount);
        require(_boss == 0xAb8483F64d9C6d1EcF9b849Ae677dD3315835cb2 ,"only boss can use");
    }

    // * 지불을 미리 하고 주유시 차감하는 기능
    uint points;
    function prePay() public payable returns(uint){
        require(msg.value > 0 ether, "You should pay ether.");
        points += msg.value/1000000000000000000;
        return(points);
    }

    //속도, 연료 확인
    function getUint() public view returns(uint,uint){
        return(speed,  fuel);
    }

}
