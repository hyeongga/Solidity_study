// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.2 <0.9.0;

contract StringAndBytes{
    string a;

    function setString(string memory _a) public {
        a=_a;
    }

    function getString() public view returns(string memory){
        return a;
    }

    function stringToBytes() public view returns(bytes memory){
        return bytes(a);
    }

    function stringToBytes2() public view returns( bytes1, bytes1, bytes1) {
        return (bytes(a)[0], bytes(a)[1], bytes(a)[2]);
    }

    function bytesToString(bytes memory _a) public pure returns(string memory) {
        return string(_a);
    }

    // Q. _a의 첫번째 글자를 추출해보시오. (특정 문자가 존재하는 데이터를 추출 할 때 사용)
    function bytesToString2(string memory _a) public pure returns(bytes1) {
        bytes memory _b; // bytes형 변수 _b 선언 
        _b = bytes(_a); // _b에 _a의 bytes 형변환 정보 대입
        return _b[0];
        //return bytes(_a)[0];
    }

    /*"bytes1" to "string memory" 변환불가 (정적 - 동적 연결불가)
    function bytesToString3(string memory _a) public pure returns(string memory) {
        bytes memory _b; 
        _b = bytes(_a); 
        return string(_b[0]);
    }*/

    function bytesToString3(string memory _a) public pure returns(string memory) {
        bytes memory _b = new bytes(1); //동적
        _b[0] = bytes(_a)[0];
        return string(_b);
    }

    function bytesToString4(string memory _a, uint _n) public pure returns(string memory) {
        bytes memory _b = new bytes(1);
        _b[0] = bytes(_a)[_n-1]; /*[나중에] 조건문 배운 후에 다시 돌아오기, 글자 수에 맞게*/
        return string(_b);
    }    

}

contract Array{
    // array = 같은 자료형들이 들어있는 집합
    uint [] numbers; // 자료형 [] array이름
    string[] letters;


    //넣을때는 왼쪽에서 부터 차례로 쌓이고, 뺄때는 뒤에서부터 제거
    //1.넣기
    function push(uint _a) public {
        numbers.push(_a);
    }

    //2. 빼기
    function pop() public {
        numbers.pop();
    }

    //3. 보기
    function getNum(uint _n) public view returns(uint) {
        return numbers[_n-1];
    }

    //4.길이
    function getLength() public view returns(uint){
        return numbers.length;
    } 

    //5. 바꾸기
    function changeNum(uint _k, uint _z) public {
        numbers[_k-1]=_z;
    }

    //6. 삭제 ; 값을 초기화 시킴 / 값 자체가 사라지는 것이 아니라 초기 값으로 돌아감
    function deleteNum(uint _n) public {
        delete numbers[_n-1];
    }

    //7. 전체 array 반환
    function returnArray() public view returns(uint[] memory){
        return (numbers);
    }
}
 
contract Struct {
    //구조체 선언
    struct Student{
        string name;
        string gender;
        uint number;
        uint birthdate;
    } 

    Student s; //Student형 변수 s
    Student[] students; // Student 형 변수들의 array students

    function setStudent(string memory _name, string memory _gender ,uint _number ,uint _birthdate) public {
       s = Student(_name, _gender, _number, _birthdate);

    } 
    function getStudent()public view returns (Student memory){
        return s;
    }

    function pushStudent(string memory _name, string memory _gender ,uint _number ,uint _birthdate) public {
        students.push(Student(_name, _gender, _number, _birthdate)); // 배열명.push(구조체명(구조체 정보들))
    }
    function popStudent() public {
        students.pop();
    }
    function getLength() public view returns(uint){
        return students.length;
    }

    function getStudent(uint _n) public view returns(Student memory) {
        return students[_n-1];
    }

    function getStudents() public view returns(Student[] memory) {
        return students;
    }

}

contract sameFucntionName{
    function add(uint _a, uint _b)public pure returns(uint){
        return _a+_b;
    }
    
    //input값의 개수가 다르면 함수명이 동일해도 작동함(나머지 경우는 조건이 달라도 에러발생)
    function add(uint _a, uint _b, uint _c)public pure returns(uint){
        return _a+_b+_c ;
    }

}