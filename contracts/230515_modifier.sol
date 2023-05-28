// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.2 <0.9.0;

contract Modifier{
    //한꺼번에 함수를 보조하거나 제한을 걸어줌

    uint a;

    modifier lessThanFive(){
        require(a<5, "should be less than five");
        _; // 함수가 실행되는 시점
    }
     
    function aPlus() public {
        a++;
    }

    function aMinus() public {
        a--;
    }
    
    function getA() public view returns(uint){
        return a;
    }
    function doubleA() public lessThanFive{
        a=a*2;
    }
    function plusTen() public lessThanFive{
        a+=10;
    }

}

contract Modifier2{
    uint a;
    string b;
    string[] b2;

    modifier plusOneBefore(){
        a++;
        _;
    }
    modifier plusOneAfter(){
        _;
        a++;
    }
    modifier plusMiddle() {
        _;
        a++;
        _;
    }

    function setAasTwo() public {
        a = 2;
    }

    // a++ 실행하고 if문 ; a=2에서 실행하면 "A"출력
    function set1() public plusOneBefore returns(string memory){
        if(a>=3){
            return "A";
        }else{
            return "B";
        }
    }

    // if 문을 실행하고 a++ ; a=2에서 실행하면 "B"출력
    function set2() public plusOneAfter returns(string memory){
        if(a>=3){
            return "A";
        }else{
            return "B";
        }
    }

    //if문 실행 > a++ > if문 재실행 ; a=2에서 실행하면 b2 = [B,A]
    function set3() public plusMiddle  {
        if(a>=3) {
            b = "A";
            b2.push(b);
        } else {
            b = "B";
            b2.push(b);
        }
    }

    function getA() public view returns(uint){
        return a;
    }
    function getB() public view returns(string memory) {
        return b;
    }
    function getB2() public view returns(string[] memory) {
        return b2;
    }

}

contract Modifier3{
    struct Person{
        uint age;
        string name;
    }

    Person P;

    modifier overTwenty(uint _age, string memory _criminal) {
        require(_age >20, "Too young");
        require(keccak256(abi.encodePacked(_criminal)) != keccak256(abi.encodePacked("Bob")), "Bob is criminal. She can't buy it");
        _;
    }

    function buyCigar(uint _a, string memory _name) public pure overTwenty(_a, _name) returns(string memory) {
        return "Passed";
    }

    function buyAlcho(uint _a, string memory _name) public pure overTwenty(_a, _name) returns(string memory) {
        return "Passed";
    }

    function buyGun(uint _a, string memory _name) public pure overTwenty(_a, _name) returns(string memory) {
        return "Passed";
    }

    /*modifier input 데이터 형이 안맞으면 오류발생
    function buyGun2(string memory _name)public overTwenty(_name) returns(string memory){
        return "Passed";  
    }
    */

    //structure data ---------------------------------------------------------------------
    function setP(uint _age, string memory _name) public {
        P = Person(_age, _name);
    }

    //structure값도 사용 가능(구조체.변수명)
    function buyCigar2() public overTwenty(P.age, P.name) view returns(string memory) {
        return "Passed";
    }

    // 선언된 값도 사용가능
    uint d =19 ;
    function buyAlcho2() public overTwenty(d, P.name) view returns(string memory) {
        return "Passed";
    }

    function buyGun2() public overTwenty(P.age, P.name) view returns(string memory) {
        return "Passed";
    }

}

contract Modifier4 {
    uint public mutex =0; //상호 배제(mutual exclusion)

    modifier m_check{
        mutex++;
        _;
        mutex--;
    }
    modifier shouldBeZeroA{
        require(mutex==0, "someone is using");
        _;
    } 
    modifier shouldBeZeroB {
        _;
        require(mutex==0, "someone is using2");
    }

    modifier shouldBeOneA {
        require(mutex==1, "someone is using");
        _;
    }
    modifier shouldBeOneB {
        _;
        require(mutex==1, "someone is using");
    }


    // mutex++ > "Done" > mutex--
    function inAndOut() public m_check returns(string memory){
        return "Done";
    }
    // mutex++ > require(mutex==0); 실행안됨
    function inAndOut1() public m_check shouldBeZeroA returns(string memory){
        return "Done";
    }
    // mutex++ > "Done" > require(mutex==0); 실행안됨(이전것도 되돌림?)
    function inAndOut1_2() public m_check shouldBeZeroB returns(string memory){
        return "Done";
    }
    // mutex++ >  mutex-- > "Done" > require(mutex==0); -1로 오류 ; 실행안됨
    function inAndOut1_3() public m_check shouldBeZeroB returns(string memory){
        mutex--;
        return "Done";
    }

    // mutex++ > "Done" > require(mutex==1) > mutex-- ;실행
    function inAndOut2_1() public m_check shouldBeOneA returns(string memory){
        return "Done";
    }
    // mutex++ > require(mutex==1) > mutex-- > "Done" > mutex-- ; -1로 오류 ; 실행안됨
    function inAndOut2_2() public m_check shouldBeOneA returns(string memory){
        mutex--;
        return "Done";
    }
    // mutex++ > mutex-- > "Done" > require(mutex==1) ; 실행안됨
    function inAndOut2_3() public m_check shouldBeOneB returns(string memory){
        mutex--;
        return "Done";
    }

    // require(mutex==0) > mutex++ > "Done" > mutex-- ; 실행
    function inAndOut3() public shouldBeZeroA m_check returns(string memory){
        return "Done";
    }


    function occupy()public {
        mutex++;
    }

    function vacancy() public{
        mutex--;
    }
}

