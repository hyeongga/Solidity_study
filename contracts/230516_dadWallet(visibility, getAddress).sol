// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.18;

//목표 : 타 컨트랙트 변수값 수정
//1. visibility에 따른 접근
contract DAD {
    uint a;

    uint public wallet=100; // 공개한 지갑 잔액
    uint internal crypto=1000; // 메모장에 private key가 있는 크립토 잔액
    uint private emergency=10000; // 진짜 비상금

    function who() virtual public pure returns(string memory) {
        return "dad from DAD";
    }

    function name() internal pure returns(string memory) {
        return "David";
    }

    function password() private pure returns(uint) {
        return 1234;
    }

    function character() external pure returns(string memory) {
        return "not good";
    }

    function getAddress() public view returns(address) {
        return address(this);
        // DAD contract 주소
    }
}

contract MOM {
    DAD husband = new DAD();
    function who() virtual public pure returns(string memory) {
        return "mom from MOM";
    }

    function getHusbandChar() public view returns(string memory) {
        return husband.character();
    }

    function getWallet() public view returns(uint) {
        return husband.wallet();
    }

    // address 가지고 오기
    function husbandAddress() public view returns(address) {
        return address(husband);
        //husband = new DAD() 주소
    }

    function husbandAddress2() public view returns(address){
        return husband.getAddress();
        //husband = new DAD() 주소
    }

    /*
    Visibility에서 차단
    function getCrypto() public view returns(uint) {
        return husband.crypto();
    }

    function getEmergency() public view returns(uint) {
        return husband.emergency();
    }
    */
}

contract CHILD is DAD {

    function fathersName() public pure returns(string memory) {
        return super.name();
    }

    function fathersWallet() public view returns(uint) {
        return DAD.wallet;
    }

    function fathersCrypto() public view returns(uint) {
        return DAD.crypto;
    }

    /*
    Visibility - private 막힘
    function fathersEmergency() public view returns(uint) {
        return DAD.emergency;
    }
    function password_Dad() public pure returns(uint) {
        return super.password();
    }

    상속받은 아이는 external 접근 불가능 ; 오류 발생 
    function fathersChar() public pure returns(string memory) {
        return super.character();
    }
    */


    // address 가지고 오기---------------------------------------------------------
    function fathersAddress() public view returns(address) {
        return DAD.getAddress();  
        //CHILD contract 주소 
    }

    function fathersAddress2() public view returns(address) {
        return super.getAddress();
        //CHILD contract 주소
    }

    //특정 스마트컨트랙트의 어드레스를 가지고 오기
    DAD daddy = new DAD();  //배포가 된 것
    DAD daddy2 = new DAD();

    function getDaddyAddress() public view returns(address) {
        return address(daddy);
        //daddy = new DAD() 주소
    }

    function getDaddyAddress2() public view returns(address) {
        return daddy.getAddress();
        //daddy = new DAD() 주소
    }

    function getDaddy2Address() public view returns(address) {
        return address(daddy2);
        //daddy2 = new DAD() 주소
    }
    
    function getDaddy2Address2() public view returns(address) {
        return daddy2.getAddress();
        //daddy2 = new DAD() 주소
    }
    //-----------------------------------------------------------------------------

    function fathersWallet2() public view returns(uint) {
        return daddy.wallet();
    }

    /*
	새롭게 선언한 daddy의 함수를 이용하려고 하기 때문에 internal에 접근 불가능

    function fathersName2() public pure returns(string memory) {
        return daddy.name();
    }

	function fathersCrypto2() public view returns(uint) {
        return daddy.crypto();
    }
	*/

}

