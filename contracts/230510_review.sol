// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.2 <0.9.0;

contract Review1{

    struct Student{
        string name;
        uint number;
        string [] classes;
    }

    mapping(string => Student[]) Teacher_Student;
    
    function setTeacher_Student(string memory _Teacher, string memory _name, uint _number, string[] memory _classes) public {
        Teacher_Student[_Teacher].push(Student(_name, _number, _classes));
    }

    function set2(string memory _Teacher, uint _n, uint _number) public{
        Teacher_Student[_Teacher][_n-1].number = _number;
    }

    function getTeacher_Student(string memory _Teacher) public view returns(Student[] memory){
        return Teacher_Student[_Teacher];
    }

}

