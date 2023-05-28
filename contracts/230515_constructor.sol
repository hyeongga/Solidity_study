// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.2 <0.9.0;

contract Constructor{
    /*
    constructor : a special method of a class or structure in object-oriented programming that initializes a newly created object of that type.
                : 변수 생성시 초기값을 정하여 생성하는 방법
    */

    /*인스턴스화: 큰 덩어리를 변수처럼 가지고와서 사용  
                : like 객체 공장에서 찍어낸 객체       */  

    uint a;
    uint b;

    constructor(){
        a = 7;
        b = 4;
    }

    function setA() public {
        a=5;
    }

    function getA() public view returns(uint){
        return a;
    }

    function getB() public view returns(uint){
        return b;
    }
}

contract Constructor2{
    uint a;
    constructor(uint _a){
        a = _a;
    }

    function getA() public view returns(uint){
        return a;
    }
}

contract Constructor3{
    struct Student{
        string name;
        uint number;
    }
    Student s;

    constructor(string memory _name, uint _number){
        s = Student(_name, _number);
    }

    function getStudent() public view returns(Student memory){
        return s;
    }
}

contract Constructor4 {
    uint a;

    constructor(uint _a) {
        if(_a>5) {
            a = _a;
        } else {
            a = _a*2;
        }
    }

    function getA() public view returns(uint) {
        return a;
    }
}

contract Constructor5{
    address payable owner;

    //처음에 지정하고 변경되지 않아야할 경우 constructor사용
    constructor()payable {
        payable(this).transfer(msg.value); // 배포할 때 msg.value 만큼 contract에게 바로 입금
        owner = payable(msg.sender);  // 배포하는 지갑주소가 바로 owner로 설정
    }

    function getOwner() public view returns(address){
        return owner;
    }

    //컨트랙트가 돈을 보내는 함수 ; contract가 _to에게 _amount만큼 보냄
    function transferTo(address payable _to, uint _amount)public {
        require(msg.sender == owner,"only owner can transfer asset");
        _to.transfer(_amount); 
    }

    receive() external payable {} 
    // 일반 거래(별도의 호출되는 함수 없을때)시 해당 contract가 돈을 받을 수 있게 해주는 함수

    // contract가 msg.value만큼 돈을 받는 함수; 컨트랙트에 특정 금액 넣기
    function deposite() public payable returns(uint){
        return msg.value;
    }

    // contract가 owner에게 전액 돈을 보내는 함수, owner 입장에서는 전액 인출
    function withdraw() public {
        require(msg.sender == owner, "only owner can transfer asset");
        owner.transfer(address(this).balance);
    }

    //contract가 owner에게 _amount만큼 보내는 함수
    function withdraw2(uint _amount) public{
        require(msg.sender == owner, "only owner can transfer asset");
        owner.transfer(_amount/* _amount * 10**18 */);
    }

    //contract가 owner에게 1ether만큼 보내는 함수(1ether 라고 명시 가능)
    function withdraw3() public{
        require(msg.sender == owner, "only owner can transfer asset");
        owner.transfer(1 ether);
    }    
}

