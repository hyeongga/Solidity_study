// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.2 <0.9.0;

// Inheritance 상속
//baisc
    contract Dad {
        function add(uint a, uint b) public pure returns(uint) {
            return a+b;
        }
    }

    contract Mom {
        function sub(uint a, uint b) public pure returns(uint) {
            return a-b;
        }
    }
    
    //1) 기본 상속 : DAD 상속 받음 (상속받은 DAD의 a+b와 Child의 mul이 출력됨)
    contract Child is Dad {
        function mul(uint a, uint b) public pure returns(uint) {
            return a*b;
        }

        function mul2(uint a, uint b) virtual public pure returns(uint) {
            return a*b*2;
        }

        function addDoubleTime(uint a, uint b) public pure returns(uint) {
            return Dad.add(a,b)*2;
        }
    }

    //2) 다중 상속(한 번에 여러개) 
    contract Child2 is Dad, Mom {
        function mul(uint a, uint b) public pure returns(uint) {
            return a*b;
        }
    }

    //3) 상속-상속(손주 상속)
    contract GrandChild is Child {
        function div(uint a, uint b) public pure returns(uint) {
            return a/b;
        }
        //Dad, Mom, Child에 접근 가능
    }

    contract GrandChild2 is Child {
        function mul2(uint a, uint b) override public pure returns(uint) {
            return a*a*b;
        }
    }
