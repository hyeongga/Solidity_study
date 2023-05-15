// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.2 <0.9.0;

contract Test{

    //학생의 정보는 이름, 번호, 점수, 학점 그리고 듣는 수업들 ✅
    struct Student{
        string name;
        uint num;
        uint score;
        string grade;
        string[] classes;
    }

    Student[] students; // ✅
    

    mapping(string => Student) Name_Student;  //✅

    //학점은 점수에 따라 자동으로 계산 (90점 이상 A, 80점 이상 B, 70점 이상 C, 60점 이상 D, 나머지는 F) ✅
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

    //* 학생 추가 기능 - 특정 학생의 정보를 추가 ✅
    uint count =1;  // 상태변수라서 가스비 필요함
    function pushStudent(string memory _name, uint _score, string[] memory _classes) public {
        // students.push(Student(_name, count++, _score, setGrade(_score), _classes));
        students.push(Student(_name, students.length+1, _score, setGrade(_score), _classes));  //상태변수 count사용하지 않고 구현
        Name_Student[_name] = Student(_name, students.length, _score, setGrade(_score), _classes);
    }

    //* 학생 조회 기능(1) - 특정 학생의 번호를 입력하면 그 학생 전체 정보를 반환 ✅
    function getStudent(uint _n) public view returns(Student memory){
        return(students[_n-1]);
    }

    //* 학생 조회 기능(2) - 특정 학생의 이름을 입력하면 그 학생 전체 정보를 반환✅
    // (스트링을 비교하는 방법 : for문돌려서 keccak256해시값 비교 ) or mapping 사용
    function getStudent2(string memory _name) public view returns(Student memory){
        return Name_Student[_name];
    }
    //* 학생 점수 조회 기능 - 특정 학생의 이름을 입력하면 그 학생의 점수를 반환 ✅
    function getStudentScore(string memory _name) public view returns(uint){
        return Name_Student[_name].score;
    }

    //* 학생 전체 숫자 조회 기능 - 현재 등록된 학생들의 숫자를 반환 ✅
    function getStudentsNum() public view returns(uint){
        return students.length;
    }

    //* 학생 전체 정보 조회 기능 - 현재 등록된 모든 학생들의 정보를 반환 ✅
    function getStudents() public view returns(Student[] memory){
        return students;
    }

    // * 학생들의 전체 평균 점수 계산 기능 - 학생들의 전체 평균 점수를 반환
    /*uint average;
    function setAverage() public  {
        uint sum;
        for (uint i;i<students.length;i++){
            sum += students[i].score;
        }
        average = sum/students.length;
    }
    function getAverage() public view returns(uint){
        return average;
    }*/

    function getAverage() public view returns(uint){
        uint sum;
        for (uint i;i<students.length;i++){
            sum += students[i].score;
        }
        return sum/students.length;
    }

    // * 선생 지도 자격 자가 평가 시스템 - 학생들의 평균 점수가 70점 이상이면 true, 아니면 false를 반환 ✅
    /*function getAssessment1() public view returns(bool){
        if (average >=70){
            return true;
        }else{
            return false;
        }
    }*/

    function getAssessment() public view returns(bool){
        if (getAverage() >=70){
            return true;
        }else{
            return false;
        }
    }

    // * 보충반 조회 기능 - F 학점을 받은 학생들의 숫자와 그 전체 정보를 반환

    Student[] F_students;
    function FClass1() public returns(Student[] memory){
        uint num;

        for (uint i; i<students.length; i++){
            if (keccak256(bytes(students[i].grade)) == keccak256(bytes("F"))){
                F_students.push(students[i]);
                num ++;
            }
        }
            return F_students;
    }


    // 가스비를 줄이기 위해서 지역변수로 FStudents 선언--------------------------------------------------------------------
    function FClass2() public view returns(Student[] memory) {

         //F반 학생수           
        uint num;
        for(uint i=0; i<students.length;i++) {
            if(keccak256(bytes(students[i].grade)) == keccak256(bytes("F"))) {
                num++;
            }
        }

        //F반 학생들
        // Student[] memory FStudents; struct사이즈 정해줘야함
        Student[] memory F_students2 = new Student[](num); // num 만큼의 array , 처음에 지정안해주기 때문에 new사용
        uint _num;
        for(uint i=0; i<students.length;i++) {
            if(keccak256(bytes(students[i].grade)) == keccak256(bytes("F"))) {
                F_students2[_num]=students[i]; //내부에 선언했을 경우 push불가능
            }
            _num++;
        }

        return F_students2;
    }


    //for문 2번 돌리지 않는 방법---------------------------------------------------------------------------------------
    /* 선언 시 f학생 배열의 길이를 알 수 없으므로 동적으로 지정
        내부에서 함수를 선언할 경우 push가 안되기 때문에 값을 넣고 빼지 못함
        (동적x, 길이를 알아낸 후 []=[]사용)

        1. 아무길이 설정하고 그 길이에 도달하면 길이를 다시 덮어씌어서 늘려주는거
        2. 새로운애가 생길 때마다 하나씩 하나씩 늘려주는거

        2번을 사용해서 길이를 늘리고자하면 직면하는 문제가 있다.
        => 길이 미정으로 인해 new선언시 기존에 있는 정보들이 날아감
        해결법 : 기존에 있던 값들을 잠시 따로 저장했다가 가지고오면 됨
        그런 다음에 길이를 늘리고, 저장해둔 값을 새롭게 길이를 늘린 값에 적용*/

    function FClass3() public view returns(/*Student[] memory*/ uint, uint, Student[] memory) {
        Student [] memory F_Students3 = students ; //memory는 push가 안됨
        Student [] memory F_Storage ; 
        uint _count;
        
        for (uint i; i<students.length; i++){
            if (keccak256(bytes(students[i].grade)) == keccak256(bytes("F"))){
                _count++;
                F_Students3[count-1] = students[i];
                F_Storage = new Student[](count);
                for(uint j=0; j<count; j++) {
                    F_Storage[j] = F_Students3[j];
                }
            }
        }
        return (F_Storage.length, count, F_Storage);
    }



    //* S반 조회 기능 - 가장 점수가 높은 학생 4명을 S반으로 설정하는데, 이 학생들의 전체 정보를 반환하는 기능 (S반은 4명으로 한정)
    function SClass() public view returns(Student[] memory){
        Student[] memory S_Students = students;
        Student[] memory S_Class = new Student[](4);

        for(uint i=0;i<S_Students.length-1;i++) {
            for(uint j=i+1; j<S_Students.length ;j++) {
                if(S_Students[i].score < S_Students[j].score) {
                    (S_Students[i], S_Students[j]) = (S_Students[j], S_Students[i]);
                }
            }
        }

        for(uint i=0; i<4; i++) {
            S_Class[i] = S_Students[i];
        }

        return S_Class;
    }

}
