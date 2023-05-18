// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.2 <0.9.0;

//receive
    contract Transfer {
        function deposit() public payable {}
        uint eth = 1 ether;
        function trasferTo(address payable _to, uint amount) public {
            _to.transfer(amount*eth);
        }
    }

    //transfeTo로 부터 보낸 돈을 받을 수 있음
    contract Receive{
        receive() external payable {}
    }//transfer 받기 가능, deposit 불가능

    //msg.value로부터 받는 기능 가능. 
    contract noReceive{
        function deposit() public payable {}
    }//deposit가능, transfer 받기 불가능
