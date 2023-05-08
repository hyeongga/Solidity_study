// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.2 <0.9.0;

contract Address{
    address a; //20bytes(16진수 40자리 정적)

    function getAdderess() public view returns (address){
        return address(this);
    }// 배포한 `Address`스마트 컨트렉트의 주소

    function getMyAddress() public view returns(address){
        return address(msg.sender);
    } // 내 account주소

    function getMyBalance() public view returns(uint){
        return address(msg.sender).balance;  // 실제 잔고와 조금 차이남
    }

    function getContractBalance() public view returns(uint){
        return address(this).balance;
    }

    function setA(address _a) public {
        a= _a;
    }

    //address가 20bytes이지만, 길이가 일치 할 뿐 두개가 호환되는 것은 아님 / 엄연히 다른 형임. 사용하려면 형을 바꿔줘야 함
    function setA2(bytes20 _a) public {
        a = address(_a);
    }
     /*
    // x
    function setA(bytes20 _a) public {
        a = _a;
    }

    // x
    function getA() public view returns(bytes20) {
        return a;
    }
    */

    function getA() public view returns(address) {
        return a;
    }
}

// view, pure 함수 가스비 소비 비교
contract GasAndFee {

    uint b; // 상태변수

    // 상태변수 변화 -> gas비 소비, 잔액 변화
    function changeB() public {
        b = b+5;
    }

    // pure 함수 -> 잔액 변화 x
    function add(uint _a, uint _b) public pure returns(uint) {
        return _a+_b;
    }

    // pure와 같은 역할이지만 일반 함수 -> gas비 소비, 잔액 변화
    function add2(uint _a, uint _b) public pure returns(uint) {
        return _a+_b;
    }
}

contract Mapping{
    //mapping(자료형 => 자료형) mapping 이름;
    mapping(uint => uint) a; //key값-숫자형 value값-숫자형
    mapping(uint => string) b; 
    mapping(string => address) c; // 뒤에오는 값이 value로 알고 싶어하는 값

    //이중매핑
    mapping(string=>mapping(string=>uint)) score;

    // 이름을 검색하면 그 아이의 키를 반환하는 contract 구현
    mapping(string=> uint) height;

    // 정보 넣기
    function setHeight(string memory _name, uint _h) public {
        height[_name] = _h; // mapping이름 [key값] = value값
    }

    //정보 받기
    function getHeight(string memory _name) public view returns(uint){
        return height[_name]; // mapping이름 [key값]
    }
    //정보 삭제
    function deleteHeight(string memory _name) public {
         delete height[_name];
    }

}