// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.2 <0.9.0;

contract Q21_30{
// 21. 3의 배수만 들어갈 수 있는 array를 구현하세요.
    uint[] Q21Arr;
    function Q21(uint _a) public returns(uint[] memory){
        if(_a%3==0){
            Q21Arr.push(_a);
        }
        return Q21Arr;
    }
    
// 22. 뺄셈 함수를 구현하세요. 임의의 두 숫자를 넣으면 자동으로 둘 중 큰수로부터 작은 수를 빼는 함수를 구현하세요.
    // 예) 2,5 input → 5-2=3(output)
    function Q22(uint _a, uint _b) public pure returns(uint){
        if(_a>_b){
            return(_a-_b);
        }else{
            return (_b-_a);
        }
    }
    
// 23. 3의 배수라면 “A”를, 나머지가 1이 있다면 “B”를, 나머지가 2가 있다면 “C”를 반환하는 함수를 구현하세요.
    function Q23(uint _input) public pure returns(string memory){
        if (_input % 3 == 0){
            return "A";
        }else if(_input % 3 == 1){
            return "B";
        }else{
            return "C";
        }
    }
    
// 24. string을 input으로 받는 함수를 구현하세요. “Alice”가 들어왔을 때에만 true를 반환하세요.
    string[] names;
    function Q24(string memory _input) public returns(bool){
        names.push(_input);
        return (keccak256(bytes(_input)) == keccak256(bytes("Alice")));
    }
    
// 25. 배열 A를 선언하고 해당 배열에 n부터 0까지 자동으로 넣는 함수를 구현하세요. 
    uint[] A;
    function Q25(uint _n) public returns(uint[] memory){
        for (uint i=_n+1;i>0; i--){
            A.push(i-1);
        }
        return(A);
    }
    function Q25_2(uint n) public {
		while(n>0) {
			A.push(n);
			n--;
		}
		A.push(0);
	}
    
// 26. 홀수만 들어가는 array, 짝수만 들어가는 array를 구현하고 숫자를 넣었을 때 자동으로 홀,짝을 나누어 입력시키는 함수를 구현하세요.
    uint[] even;
    uint[] odd;
    function Q26(uint _a) public returns(uint[] memory, uint[] memory){
        if (_a%2==1){
            odd.push(_a);
        }else{
            even.push(_a);
        }
        return(even, odd);
    }
    
// 27. string 과 bytes32를 key-value 쌍으로 묶어주는 mapping을 구현하세요. 해당 mapping에 정보를 넣고, 지우고 불러오는 함수도 같이 구현하세요.
    mapping(string => bytes32) public  Q27mapping;

    function Q27(string memory _info) public returns(bytes32){
        Q27mapping[_info] = keccak256(abi.encodePacked(_info));
        
        return Q27mapping[_info];
    }

    function Q27delete(string memory _a) public returns(bytes32){
        delete Q27mapping[_a];
        
        return Q27mapping[_a];
    }


// 28. ID와 PW를 넣으면 해시함수(keccak256)에 둘을 같이 해시값을 반환해주는 함수를 구현하세요.
    function Q28(string memory _id, string memory _pw) public pure returns(bytes32){
        return keccak256(abi.encodePacked(_id, _pw))    ;
    }
}   
// 29. 숫자형 변수 a와 문자형 변수 b를 각각 10 그리고 “A”의 값으로 배포 직후 설정하는 contract를 구현하세요.
    contract Q29{
        uint a;
        string b;
        constructor(){
            a = 10;
            b = "A";
        }
    //     constructor(uint _a, string memory/*constructor에는 calldata 불가능*/ _b) {
	// 	a = _a;
	// 	b = _b;
	// }
        
    }
    
/* 30. 임의대로 숫자를 넣으면 알아서 내림차순으로 정렬해주는 함수를 구현하세요
    (sorting 코드 응용 → 약간 까다로움)
    예 : [2,6,7,4,5,1,9] → [9,7,6,5,4,2,1]*/

    contract Q30{
        function sorting(uint[] memory _input) public pure returns(uint[] memory){
            for(uint i;i<_input.length-1; i++){
                for(uint j=i+1;j<_input.length;j++){
                    if(_input[i]<_input[j]){
                        (_input[i], _input[j])= (_input[j], _input[i]);
                    }
                }
            }
            return _input;
        }
    }