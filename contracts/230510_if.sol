// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.2 <0.9.0;

contract IF{
    //점수가 50점 이상이면 P, dkslaus F
    function setGrade(uint _score) public pure returns(string memory){
        if(_score >=50){
            return "P";
        }else{
            return"F";
        }
    }

    //점수가 70점,50점 기준으로  A,B,C 반 분류
    function setGrade2(uint _score) public pure returns(string memory){
        if(_score>=70){
            return "A";
        }else if(_score>=50){
            return "B";
        }else{
            return "C";
        }
    }

    //짝수면 even array에, 홀수면 odd array에 넣기
    uint[] even;
    uint[] odd;

    function evenOrOdd(uint _n) public {
        if(_n%2==0){
            even.push(_n);
        }else{
            odd.push(_n);
        }
    }

    function getEvenAndOdd()public view returns(uint[] memory, uint[]memory){
        return(odd,even);
    }

    //3으로 나누었을때, 나머지가 1이면 A, 2이면 B, 0이면 C
    uint[] A;
    uint[] B;
    uint[] C;

    function ternary(uint _n)public {
        if(_n%3==1){
            A.push(_n);
        }else if(_n%3==2){
            B.push(_n);
        }else{
            C.push(_n);
        }
    }
       
}

contract IfStruct{

    struct student{
        uint number;
        string name;
        uint score;
        string credit;
    }

    student Alice;
    student Bob;
    student Charlie;

    // 학생 정보 중 번호, 이름, 점수만 입력하면 학점은 자동 계산해 주는 함수
    // credeit : 점수가 90점 이상이면 A, 80점 이상이면 B, 70점 이상이면 C, 나머지는 F
       function setAlice(uint _number, string memory _name, uint _score) public {
      string memory _credit;
      if(_score>=90) {
         _credit = 'A';
      } else if(_score >=80) {
         _credit = 'B';
      } else if(_score >=70) {
         _credit = 'C';
      } else {
         _credit = 'F';
      }

      Alice = student(_number, _name, _score, _credit);
   }

   function setBob(uint _number, string memory _name, uint _score) public {
      string memory _credit;
      if(_score>=90) {
         _credit = 'A';
      } else if(_score >=80) {
         _credit = 'B';
      } else if(_score >=70) {
         _credit = 'C';
      } else {
         _credit = 'F';
      }

      Bob = student(_number, _name, _score, _credit);
   }

   function setCharlie(uint _number, string memory _name, uint _score) public {
      string memory _credit;
      if(_score>=90) {
         _credit = 'A';
      } else if(_score >=80) {
         _credit = 'B';
      } else if(_score >=70) {
         _credit = 'C';
      } else {
         _credit = 'F';
      }

      Charlie = student(_number, _name, _score, _credit);
   }

   function getStudents() public view returns(student memory, student memory, student memory) {
      return (Alice, Bob, Charlie);
   }
}

contract IfStruct2{

     struct student{
        uint number;
        string name;
        uint score;
        string credit;
    }

    student [] students;

    // 학생 정보 중 번호, 이름, 점수만 입력하면 학점은 자동 계산해 주는 함수
    // credeit : 점수가 90점 이상이면 A, 80점 이상이면 B, 70점 이상이면 C, 나머지는 F
    function pushStudent(uint _number, string memory _name, uint _score) public {
      string memory _credit;
      if(_score>=90) {
         _credit = 'A';
      } else if(_score >=80) {
         _credit = 'B';
      } else if(_score >=70) {
         _credit = 'C';
      } else {
         _credit = 'F';
      }

      students.push(student(_number, _name, _score, _credit));
    }

   function pushStudent2(uint _number, string memory _name, uint _score)public {
       students.push(student(_number, _name, _score, setGrade(_score)));
   } 

    function setGrade(uint _score) public pure returns(string memory) {
      if(_score>=90) {
         return 'A';
      } else if(_score >=80) {
         return 'B';
      } else if(_score >=70) {
         return 'C';
      } else {
         return 'F';
      }
   }

   function getStudents() public view returns(student[] memory) {
      return students;
   }
}

contract IfAndOr{
    function setNumber(uint _n) public pure returns(string memory){
        if(_n>=70 || _n<10){
            return "A";
        }else if(_n>=50 && _n%3==0){
            return "B";
        }else{
            return "C";
        }
    }

}

