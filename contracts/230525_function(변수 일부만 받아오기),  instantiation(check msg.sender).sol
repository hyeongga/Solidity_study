// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.2 <0.9.0;

//함수 받아와서 사용
    contract review {
        function numbers() public pure returns(uint, uint, uint) {
            return (1,2,3);
        }
        //numbers 들고와서 사용
        function numbers2() public pure returns(uint, uint, uint) {
            (uint a, uint b, uint c) = numbers();
            return (a,b,c); // 1,2,3
        }
        //numbers 일부만 들고오기
        function numbers3() public pure returns(uint, uint) {
            (uint a, , uint c) = numbers();
            return (a,c); //1,3
        }
    }

// constructor를 포함한 contract를 인스턴스화, 상속 받기 (msg.sender 확인)
    contract MSGSENDER{
        function A() public view returns (address){
            address a = msg.sender;
            return a;
        }

        function B() public view returns (address){
            address b = A();
            return b;
        }
    }

    contract MSGSENDER2 {
        MSGSENDER msgsender = new MSGSENDER();

        function C() public view returns(address) {
            address c = msgsender.A();
            return c; 
            //MSGSENDER2가 msgsender.A();를 실행시키기 때문에 A()의 msg.sender는 MSGSENDER2임.
        }

        function D() public view returns(address) {
            address d = msgsender.B();
            return d;
        /* MSGSENDER2가 msgsender.B();를 실행시키고 B()는 A()로 이어짐. 
            이때 B()를 실행시키는 MSGSENDER2가 msg.sender가 됨. 
            B()가 A()를 실행시키기 때문에 msg.sender가 MSGSENDER라고 생각할 수 있지만, 
            같은 컨트랙트 안에서는 영향을 안 주기 때문에 msg.sender는 MSGSENDER2이다.*/
        }
    }

    contract MSGSENDER3 {
        address[] list;
    
        function push() public {
            list.push(msg.sender);
        }

        function push2() public {
            push(); //내 계좌번호 나옴
        }
        //컨트랙트가 아니라 누른 사람의 주소가 뜸. 한 컨트랙트 안에서는 다 동일한 msg.sender를 가짐
        // 타 컨트랙트를 건드리면 그때는 이 컨트랙트를 건드린 주소를 반환 (그러나 동일 컨트랙트 안에서는 따로 영향을 안줌)

        function getList() public view returns(address[] memory) {
            return list;
        }

    }