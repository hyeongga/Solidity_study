// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.2 <0.9.0;

contract Quiz{

    // 이름, 생일, 번호를 담은 구조체 Student를 선언하고 Student들이 들어갈 수 있는 array students를 선언하시오.
    struct Student {
        string name;
        uint birthday;
        uint number;
    }

    Student [] students;

    // students에 Student를 넣을 수 있는 함수, n번째 학생을 반환해주는 함수, n번째 학생의 이름을 반환해주는 함수를 구현하세요.
    function pushStudents(string memory _name, uint _birthday, uint _number) public {
        students.push(Student( _name, _birthday, _number));
    }
    function getStudent(uint _n) public view returns(Student memory){
        return students[_n-1];
    }
    function getName(uint _n) public view returns(string memory){
        return students[_n-1].name;
    }
    
}

contract Quiz2{
    //이름 a, 번호 b, bytes2 c를 담은 구조체 D
    struct D{
        string a;
        uint b;
        bytes2 c;
    }
    //D형 변수 ddd를 선언하시오. ddd에 값을 부여하는 함수를 구현하시오.
    D ddd;
    function setDdd(string memory _a, uint _b, bytes2 _c) public {
        ddd = D(_a, _b, _c);
    }
    // D가 들어가는 array D_list를 선언하시오.
    D[] D_list;

    function pushD()public {
        D_list.push(ddd);
    }

    //D_list 전체를 반환하는 함수, D_list 안에서 n번째 데이터를 반환하는 함수를 각각 구현하시오.
    function getDlist() public view returns(D[] memory){
        return( D_list );
    }
    function getD(uint _n) public view returns (D memory){
        return( D_list[_n-1] );
    }
}

contract Quiz3{
    // ABC라는 구조체 안에는 숫자형 a, 문자형 b, 문자형 array c가 들어있다.
    struct ABC{
        uint a;
        string b;
        string [] c; //["문자열","문자열"...]형태로 input작성
    }
    // ABC가 들어가는 array ABCs를 구현하고 ABCs에 ABC를 넣는 함수, 특정 ABC를 반환하는 함수, ABCs 전체를 반환하는 함수, 특정 ABC의 c array를 반환받는 함수를 각각 구현하시오.
    ABC[] ABCs;
    function pushABCs(uint _a, string memory _b, string[] memory  _c) public {
        ABCs.push(ABC(_a,_b,_c));
    }
    function getABC(uint _n) public view returns(ABC memory) {
        return ABCs[_n-1];
    }
    function getABCs() public view returns( ABC[] memory){
        return ABCs;
    }
    function getCArray(uint _n) public view returns(string[] memory){
        return ABCs[_n-1].c;
    }


}