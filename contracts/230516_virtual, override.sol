// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.2 <0.9.0;

// virtual / override
    
    /*
    상속 중 함수명이 겹칠때 
    1. input값이 다른 경우 : input값의 개수나 타입이 부모 함수와 다를 경우, 다른 함수로 인식 (함수명이 겹쳐도 input값이 다르면 괜찮음 ; override사용 x)
    2. override 사용(덮어씌움;새로작성)) : 부모함수에는 virtual, 자식함수에는 override를 작성하고 함수 내용을 변경함
                                        : 함수는 오버라이드가 가능한데 변수는 불가능
    */
   
    contract DAD {
        //부모함수에 virtual 작성 해야 override 사용가능
        function dad() virtual public pure returns(string memory) {
            return "DAD";
        }
    }

    contract CHILD is DAD {
        // 1) input 값 개수 차이
        function dad(uint a) public pure returns( uint) {
                return a;
        }
        // 2) override 사용
        function dad() override public pure returns(string memory) {
            return "dad from CHILD";
        }
    } //DAD의 dad 함수는 나타나지 않고 덮어씌워 새로 작성한 CHILD의 dad함수만 2개 나타남


    //3) 부모들의 함수 이름이 동일할 경우 (override 필수) ----------------------------------------
    contract DAD2 {
        function who() virtual public pure returns(string memory) {
            return "DAD";
        }
    }
    contract MOM2 {
        function who() virtual public pure returns(string memory) {
            return "MOM";
        }
    }
    contract CHILD2 is DAD2, MOM2 {
        function who() virtual override(DAD2, MOM2) public pure returns(string memory) {
            return "CHILD";
        }
    }
    /* 4) virtual와 override 동시 사용 
    : CHILD2는 who라는 function을 DAD2, MOM2으로부터 받아오지만 동시에 GRANDCHILD2에게 상속도 해줌. 
    따라서 virtual 와 override 동시에 선언 */

    contract GRANDCHILD2 is CHILD2{
        function who() override public pure returns(string memory){
            return ("GRANDCHILD");
        }
    }
