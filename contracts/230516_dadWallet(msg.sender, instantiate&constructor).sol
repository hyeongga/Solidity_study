// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.18;

// msg.sender
    contract DAD {
        uint a;

        uint public wallet=100; // 공개한 지갑 잔액
        uint internal crypto=1000; // 메모장에 private key가 있는 크립토 잔액
        uint private emergency=10000; // 진짜 비상금

        function password() private pure returns(uint) {
            return 1234;
        }

        function getMsgSender() public view returns(address) {
            return msg.sender;
            //0x5B38Da6... 누른 내 지갑주소
        }

    }

    contract MOM {
        DAD husband = new DAD();

        function husGetMsgSender() public view returns(address) {
            return husband.getMsgSender();
            //MOM의 주소
        }
    }

    contract CHILD is DAD {

        function dadGetMsgSender() public view returns(address) {
            return super.getMsgSender();
            //0x5B38Da6... 누른 내 지갑주소
        }

        DAD daddy = new DAD();
        DAD daddy2 = new DAD();

        function daddyGetMsgSender() public view returns(address) {
            return daddy.getMsgSender();
            // CHILD의 주소
        }

        function daddyGetMsgSender2() public view returns(address) {
            return daddy2.getMsgSender();
            // CHILD의 주소
        }

    }


// 인스턴스화 & constructor -------------------------
    contract DAD2 {
        uint a;

        uint public wallet=100; // 공개한 지갑 잔액
        uint internal crypto=1000; // 메모장에 private key가 있는 크립토 잔액
        uint private emergency=10000; // 진짜 비상금

        function password() private pure returns(uint) {
            return 1234;
        }

        function changeWallet(uint _n) public {
            wallet = _n;
        }
    }

    contract MOM2 {

        DAD2 husband = new DAD2();
        DAD2 realHusband;
        /* 
        
        1. 인스턴스화(변수화를 새로시킴) ; 외부라고 인식 
        Dad husband = new DAD(); => DAD는 변수형 husband는 변수명
        : 상속을 받은 것과 다른 결과 도출
        : 컨트랙트를 변수화하기 때문에 형태만 같을 뿐 주소는 다름

        인스턴스 하는 건 복제해서 새로 만들어 쓰는거고, 변수로 바로 선언해서 쓰면 그 컨트랙트에 있는 정보를 다 받아옴
        - new는 새로운 컨트랙트를 만듦 ; 새리프노드를 만듦
        - 지갑주소를 인풋으로 넣으면 ; 리프노드를 찾아 들어감
        
        */
   

        constructor(address _a){
            realHusband = DAD2(_a);
        }

        function getWallet() public view returns(uint){
            return husband.wallet();
            // 새로 생성된 주소로 연결
        }

        function getRealWallet() public view returns(uint){
            return realHusband.wallet();
            //constructor값으로 기존 주소를 연결했기 때문에 기존계정의 값 출력
        }

        //input값으로 주소를 넣어 지갑을 조회 할 수 있는 기능
        function trackWallet(address _a) public view returns(uint) {
            DAD2 copyDad = DAD2(_a);
            return copyDad.wallet();
        }

        //연결된 husband값 변경
        function changeRealWallet(uint _a) public {
            realHusband.changeWallet(_a);
        }

    }   




