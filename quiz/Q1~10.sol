// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.2 <0.9.0;

contract Q1_10{

    // 1. 더하기, 빼기, 곱하기, 나누기 그리고 제곱을 반환받는 계산기를 만드세요

        function Q1add(uint a, uint b) public pure returns(uint) {
            return a+b;
        }
        
        function Q1sub(uint a, uint b) public pure returns(uint) {
            return a-b;
        }
        
        function Q1mul(uint a, uint b) public pure returns(uint) {
            return a*b;
        }
        
        function Q1sqr(uint a) public pure returns(uint) {
            return a**2;
        }

        
    //2. 2개의 Input값을 가지고 1개의 output값을 가지는 4개의 함수를 만드시오. 각각의 함수는 더하기, 빼기, 곱하기, 나누기(몫)를 실행합니다.

        function Q2add(uint a, uint b) public pure returns(uint) {
            return a+b;
        }
        
        function Q2sub(uint a, uint b) public pure returns(uint) {
            return a-b;
        }
        
        function Q2mul(uint a, uint b) public pure returns(uint) {
            return a*b;
        }
        
        function Q2div(uint a, uint b) public pure returns(uint) {
            return a/b;
        }
        
    //3. 2개의 Input값을 가지고 1개의 output값을 가지는 2개의 함수를 만드시오. 각각의 함수는 제곱, 세제곱을 반환합니다.
    function Q3_1(uint _n) public pure returns(uint){
        return (_n**2);
    }

    function Q3_2(uint _n) public pure returns(uint){
        return (_n**3);
    }
        
    //4. 이름(string), 번호(uint), 듣는 수업 목록(string[])을 담은 student라는 구조체를 만들고 그 구조체들을 관리할 수 있는 array, students를 선언하세요.
    struct student{
        string name;
        uint number;
        string[] classes;
    }

    student [] students;
        

    //5. 아래의 함수를 만드세요
       
    /*  1. 1~3을 입력하면 입력한 수의 제곱을 반환받습니다.
        2. 4~6을 입력하면 입력한 수의 2배를 반환받습니다.
        3. 7~9를 입력하면 입력한 수를 3으로 나눈 나머지를 반환받습니다. */
    function Q5(uint _n) public pure returns(uint){
        if (1 <= _n && _n<= 3){
            return(_n**2);
        }else if (4 <= _n && _n<= 6){
            return (_n*2);
        }else if(7 <= _n && _n<= 9){
            return _n%3;
        }else{
            // "Out of range";
            return 0;
        }
    }

        
    //6. 숫자만 들어갈 수 있는 array numbers를 만들고 그 array안에 0부터 9까지 자동으로 채우는 함수를 구현하세요.(for 문)
  
    function Q6() public pure returns(uint[10] memory){
        uint[10] memory numbers;
        for (uint i;i<10;i++){
            numbers[i] = i;
        }
        return numbers;
    }

        
    //7. 숫자만 들어갈 수 있는 array numbers를 만들고 그 array안에 0부터 5까지 자동으로 채우는 함수와 array안의 모든 숫자를 더한 값을 반환하는 함수를 각각 구현하세요.(for 문)
    uint[] numbers2;
    function Q7() public returns(uint[] memory, uint){
        uint sum;
        for (uint i;i<6;i++){
            numbers2.push(i);
            sum += i;
        }
        
        return (numbers2, sum);
    }

        
    //8. 아래의 함수를 만드세요
    /* 1. 1~10을 입력하면 “A” 반환받습니다.
        2. 11~20을 입력하면 “B” 반환받습니다.
        3. 21~30을 입력하면 “C” 반환받습니다.*/

    function Q8(uint _n) public pure returns(string memory){
        if (1 <= _n && _n<= 10){
            return "A";
        }else if (11 <= _n && _n<= 20){
            return "B";
        }else if(21 <= _n && _n<= 30){
            return "C";
        }else{
            return "";
        }
    }


    //9. 문자형을 입력하면 bytes 형으로 변환하여 반환하는 함수를 구현하세요.
    function Q9(string memory _input) public pure returns (bytes memory){
        return bytes(_input);
    }

        
    //10. 숫자만 들어가는 array numbers를 선언하고 숫자를 넣고(push), 빼고(pop), 특정 n번째 요소의 값을 볼 수 있는(get)함수를 구현하세요.
    uint[] numbers3;
    
    function Q10push(uint _a) public returns(uint[] memory){
        numbers3.push(_a);
        return numbers3;
    }
    function Q10pop() public returns(uint[] memory){
        numbers3.pop();
        return numbers3;
    }
    function Q10getNum(uint _n) public view returns(uint){
        return numbers3[_n-1];
    }
        
    
}
