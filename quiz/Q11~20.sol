// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.2 <0.9.0;

contract Q11_20{
    
    // 11. uint 형이 들어가는 array를 선언하고, 짝수만 들어갈 수 있게 걸러주는 함수를 구현하세요.
    uint[] Q11Num;
    function Q11(uint _a) public returns(uint[] memory){
        if(_a%2==0){
            Q11Num.push(_a);
        }
        return Q11Num;
    }
    
    // 12. 숫자 3개를 더해주는 함수, 곱해주는 함수 그리고 순서에 따라서 a*b+c를 반환해주는 함수 3개를 각각 구현하세요.
    function Q12add(uint _a, uint _b, uint _c) public pure returns(uint){
        return _a+_b+_c;
    }
    function Q12mul(uint _a, uint _b, uint _c) public pure returns(uint){
        return _a*_b*_c;
    }
    function Q12complex(uint _a, uint _b, uint _c) public pure returns(uint){
        return _a*_b+_c;
    }

    // 13. 3의 배수라면 “A”를, 나머지가 1이 있다면 “B”를, 나머지가 2가 있다면 “C”를 반환하는 함수를 구현하세요.
    function Q13(uint _a)public pure returns(string memory){
        if(_a%3==0){
            return "A";
        }else if(_a%3==1){
            return "B";
        }else{
            return "C";
        }

    }
    /*14. 학번, 이름, 듣는 수험 목록을 포함한 학생 구조체를 선언하고 학생들을 관리할 수 있는 array를 구현하세요. 
    array에 학생을 넣는 함수도 구현하는데 학생들의 학번은 1번부터 순서대로 2,3,4,5 자동 순차적으로 증가하는 기능도 같이 구현하세요.*/
    struct Student{
        uint studentNumber;
        string name;
        string[] classes;
    }
    Student[] students;

    function addStudent(string memory _name, string[] memory _classes) public returns(Student[] memory){
        students.push(Student(students.length+1,_name, _classes));
        return students;
    }


    // 15. 배열 A를 선언하고 해당 배열에 0부터 n까지 자동으로 넣는 함수를 구현하세요.

    function Q15(uint _n) public pure returns(uint[] memory){
        uint[] memory A = new uint[](_n+1);
        uint count;
        for(uint i; i<_n+1 ;i++){
            A[i] = count;
            count++;
        }
        return A;
    }
        
    // 16. 숫자들만 들어갈 수 있는 array를 선언하고 해당 array에 숫자를 넣는 함수도 구현하세요. 또 array안의 모든 숫자의 합을 더하는 함수를 구현하세요.
    uint[] Q16Arr;
    function Q16(uint _input) public returns (uint[] memory){
        Q16Arr.push(_input);
        return Q16Arr;
    }
    function Q16AddAll() public view returns(uint){
        uint sum ;
        for (uint i;i<Q16Arr.length;i++){
           sum += Q16Arr[i];
        }

        return sum;
    }


    // 17. string을 input으로 받는 함수를 구현하세요. 이 함수는 true 혹은 false를 반환하는데 Bob이라는 이름이 들어왔을 때에만 true를 반환합니다. 
    function Q17 (string memory _input) public pure returns(bool) {
        // if(keccak256(bytes(_input)) == keccak256(bytes("Bob"))){
        //     return true;
        // }else{
        //     return false;
        // }
    	return keccak256(bytes(_input)) == keccak256(bytes("Bob"));

    }
    // 18. 이름을 검색하면 생일이 나올 수 있는 자료구조를 구현하세요. (매핑) 해당 자료구조에 정보를 넣는 함수, 정보를 볼 수 있는 함수도 구현하세요.
    mapping(string => uint) public Q18NameToBirth;
    function Q18(string memory _name, uint _birth ) public {
        Q18NameToBirth[_name] = _birth;
    }

    // 19. 숫자를 넣으면 2배를 반환해주는 함수를 구현하세요. 단 숫자는 1000이상 넘으면 함수를 실행시키지 못하게 합니다.
    function Q19(uint _a)public pure returns(uint){
        require(_a<1000);
        return _a*2;
    }

        
    // 20. 숫자만 들어가는 배열을 선언하고 숫자를 넣는 함수를 구현하세요. 15개의 숫자가 들어가면 3의 배수 위치에 있는 숫자들을 초기화 시키는(3번째, 6번째, 9번째 등등) 함수를 구현하세요. (for 문 응용 → 약간 까다로움)
    uint[] numArr;
    function Q20(uint _n) public returns(uint[] memory){
            numArr.push(_n);
            if (numArr.length==15){
                for(uint i;i<numArr.length;i++){
                    if (i%3==2){
                        delete numArr[i];
                    }
                }
            }
            return numArr;
        }


	// uint[] numbers;
	// function pushNumbers(uint _n) public {
	// 	for(uint i=0; i<15; i++) {
	// 		numbers.push(_n);
	// 	}
		
	// 	for(uint i=3;i<15;i+=3) {
	// 		delete numbers[i-1];
	// 	}
    // }

}