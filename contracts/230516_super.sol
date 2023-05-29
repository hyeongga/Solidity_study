// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.2 <0.9.0;

    /* 
    super : 나에게 상속해준 부모로부터 특정 함수를 받아올때 ; 다중상속의 경우 상속순서에 따라 마지막 상속받은 값이 출력됨
    사용법 : super.함수명 (super뒤에 바로 변수가 오지는 못함)
    */

    contract DAD {
        function who() virtual public pure returns(string memory) {
            return "DAD";
        }

        function name() public pure returns(string memory) {
            return "David";
        }
    }

    contract MOM {
        function who() virtual public pure returns(string memory) {
            return "MOM";
        }
    }

    contract CHILD is DAD {
        //새로운 함수를 만들 때, 부모로 부터 특정함수를 불러와서 사용할 수 있음
        function fathersName() public pure returns(string memory) {
            return super.name();
        }
        function who() override public pure returns(string memory) {
            return string.concat(super.who(), "& i");
        }
    }

    contract CHILD2 is DAD, MOM {
        function who() virtual override(DAD, MOM) public pure returns(string memory) {
            return super.who();
            // 마지막으로 상속받은 "MOM" 반환
        }
    }

