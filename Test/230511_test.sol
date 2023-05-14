// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.2 <0.9.0;

/* [문제]
여러분은 선생님입니다. 학생들의 정보를 관리하려고 합니다. 
학생의 정보는 이름, 번호, 점수, 학점 그리고 듣는 수업들이 포함되어야 합니다.

번호는 1번부터 시작하여 정보를 기입하는 순으로 순차적으로 증가합니다.

학점은 점수에 따라 자동으로 계산되어 기입하게 합니다. 90점 이상 A, 80점 이상 B, 70점 이상 C, 60점 이상 D, 나머지는 F 입니다.

필요한 기능들은 아래와 같습니다.

* 학생 추가 기능 - 특정 학생의 정보를 추가
* 학생 조회 기능(1) - 특정 학생의 번호를 입력하면 그 학생 전체 정보를 반환
* 학생 조회 기능(2) - 특정 학생의 이름을 입력하면 그 학생 전체 정보를 반환
* 학생 점수 조회 기능 - 특정 학생의 이름을 입력하면 그 학생의 점수를 반환
* 학생 전체 숫자 조회 기능 - 현재 등록된 학생들의 숫자를 반환
* 학생 전체 정보 조회 기능 - 현재 등록된 모든 학생들의 정보를 반환
* 학생들의 전체 평균 점수 계산 기능 - 학생들의 전체 평균 점수를 반환
* 선생 지도 자격 자가 평가 시스템 - 학생들의 평균 점수가 70점 이상이면 true, 아니면 false를 반환
* 보충반 조회 기능 - F 학점을 받은 학생들의 숫자와 그 전체 정보를 반환
-------------------------------------------------------------------------------
* S반 조회 기능 - 가장 점수가 높은 학생 4명을 S반으로 설정하는데, 이 학생들의 전체 정보를 반환하는 기능 (S반은 4명으로 한정)

기입할 학생들의 정보는 아래와 같습니다.

Alice, 1, 85
Bob,2, 75
Charlie,3,60
Dwayne, 4, 90
Ellen,5,65
Fitz,6,50
Garret,7,80
Hubert,8,90
Isabel,9,100
Jane,10,70 
*/


contract Test{

//학생의 정보는 이름, 번호, 점수, 학점 그리고 듣는 수업들
    struct Student{
        string name;
        uint num;
        uint score;
        string grade;
        string[] classes;
    }

    Student[] students;
    Student[] FStudents;

    mapping(string => Student) Name_Student; 

//학점은 점수에 따라 자동으로 계산 (90점 이상 A, 80점 이상 B, 70점 이상 C, 60점 이상 D, 나머지는 F)
function setGrade(uint _score) public pure returns(string memory) {
    if (_score>=90){
        return "A";
    }else if(_score>=80){
        return "B";
    }else if(_score>=70){
        return "C";
    }else if(_score>=60){
        return "D";
    }else{
        return "F";
    }
}

//* 학생 추가 기능 - 특정 학생의 정보를 추가 
uint count =1; 
function pushStudent(string memory _name, uint _score, string[] memory _classes) public {
    students.push(Student(_name, count++, _score, setGrade(_score), _classes));
    Name_Student[_name] = Student(_name, count++, _score, setGrade(_score), _classes);
}

//* 학생 조회 기능(1) - 특정 학생의 번호를 입력하면 그 학생 전체 정보를 반환
function getStudent(uint _n) public view returns(Student memory){
    return(students[_n-1]);
}

//* 학생 조회 기능(2) - 특정 학생의 이름을 입력하면 그 학생 전체 정보를 반환
function getStudent2(string memory _name) public view returns(Student memory){
    return Name_Student[_name];
}
//* 학생 점수 조회 기능 - 특정 학생의 이름을 입력하면 그 학생의 점수를 반환
function getStudentScore(string memory _name) public view returns(uint){
    return Name_Student[_name].score;
}

//* 학생 전체 숫자 조회 기능 - 현재 등록된 학생들의 숫자를 반환 
function getStudentsNum() public view returns(uint){
    return students.length;
}

//* 학생 전체 정보 조회 기능 - 현재 등록된 모든 학생들의 정보를 반환
function getStudents() public view returns(Student[] memory){
    return students;
}

// * 학생들의 전체 평균 점수 계산 기능 - 학생들의 전체 평균 점수를 반환
uint average;
function setAverage() public  {
    uint sum;
    for (uint i;i<students.length;i++){
        sum += students[i].score;
    }
    average = sum/students.length;
}

function getAverage() public view returns(uint){
    return average;
}


// * 선생 지도 자격 자가 평가 시스템 - 학생들의 평균 점수가 70점 이상이면 true, 아니면 false를 반환
function getAssessment() public view returns(bool){
    if (average >=70){
        return true;
    }else{
        return false;
    }
}

// * 보충반 조회 기능 - F 학점을 받은 학생들의 숫자와 그 전체 정보를 반환
///에러발생
// function getFStudents() public returns(uint, Student[] memory){
//     uint num;
//     for (uint i;i<students.length;i++){
//         if (students[i].grade == "F"){
//             num +=1;
//             FStudents.push(students[i]);
//         }
//     }
// }

}
