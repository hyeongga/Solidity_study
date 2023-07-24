// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.2 <0.9.0;


contract Q31_36{

// 31. string을 input으로 받는 함수를 구현하세요. "Alice"나 "Bob"일 때에만 true를 반환하세요.

    function Q31(string memory _input) public pure returns(bool){
        if (keccak256(bytes(_input))==keccak256(bytes("Bob")) || keccak256(abi.encodePacked(_input)) == keccak256(abi.encodePacked("Alice")) ){
            return true;
        }
        return false;
    }

    
// 32. 3의 배수만 들어갈 수 있는 array를 구현하되, 3의 배수이자 동시에 10의 배수이면 들어갈 수 없는 추가 조건도 구현하세요.
    // 예) 3 → o , 9 → o , 15 → o , 30 → x
    uint[] Q32arr;
    function Q32(uint _a) public returns(uint[] memory){
        if(_a%10!=0 && _a%3==0){
            Q32arr.push(_a);
        }
        return Q32arr;
    }

    
// 33. 이름, 번호, 지갑주소 그리고 생일을 담은 고객 구조체를 구현하세요. 고객의 정보를 넣는 함수와 고객의 이름으로 검색하면 해당 고객의 전체 정보를 반환하는 함수를 구현하세요.
    struct Q33customer{
        string name;
        uint number;
        address wallet;
        uint bitrthday;
    }
    mapping(string => Q33customer) searchCus;
    function Q33(string memory _name, uint _number,address _wallet,uint _bitrthday) public returns( Q33customer memory){
        searchCus[_name] = Q33customer(_name, _number, _wallet, _bitrthday);
        return searchCus[_name];
    }
    
// 34. 이름, 번호, 점수가 들어간 학생 구조체를 선언하세요. 학생들을 관리하는 자료구조도 따로 선언하고 학생들의 전체 평균을 계산하는 함수도 구현하세요.
    struct Q34student{
        string name;
        uint number;
        uint score;
    }
    Q34student[] student;

    function Q34register(string memory _name, uint _number, uint _score) public {
        student.push(Q34student(_name, _number, _score));
    }

    function Q34() public view returns(uint){
        uint sum;

        for (uint i;i<student.length;i++){
            sum += student[i].score;
        }
        return sum/student.length;
    }
    
// 35. 숫자만 들어갈 수 있는 array를 선언하고 해당 array의 짝수번째 요소만 모아서 반환하는 함수를 구현하세요.
    // 예) [1,2,3,4,5,6] -> [2,4,6] // [3,5,7,9,11,13] -> [5,9,13]
    function Q35(uint[] memory _a) public pure returns(uint[] memory) {
        uint[] memory A;
        uint j; 
        for (uint i;i<_a.length;i++){
            if (i%2==1){
                A[j] = _a[i];
                j++;
            }
        }
        return A;
    }
        
        // uint[] numbers;

		// function pushNumbers(uint[] memory _numbers) public returns(uint[] memory) {
		// 	for(uint i=0; i< _numbers.length;i+=2) {
		// 		numbers.push(_numbers[i+1]);
		// 	}
		// 	return numbers;
		// }

    
// 36. high, neutral, low 상태를 구현하세요. a라는 변수의 값이 7이상이면 high, 4이상이면 neutral 그 이후면 low로 상태를 변경시켜주는 함수를 구현하세요.
    
    enum Q36status {
        neutral,
        high,
        low
    }

    Q36status public S;

    function Q36(uint _a)public returns(Q36status){
        if(_a>=7){
           S = Q36status.high;
        }else if(_a>=4){
            S = Q36status.neutral;
        }else{
            S = Q36status.low;
        }
        return S;

    }
}

// 37. 1 wei를 기부하는 기능, 1finney를 기부하는 기능 그리고 1 ether를 기부하는 기능을 구현하세요. 최초의 배포자만이 해당 smart contract에서 자금을 회수할 수 있고 다른 이들은 못하게 막는 함수도 구현하세요.
    //힌트 : 기부는 EOA가 해당 Smart Contract에게 돈을 보내는 행위, contract가 돈을 받는 상황)
    contract Q37{
        address owner ;
        constructor(){
            owner = msg.sender;
        }

        function donateWei() public payable {require(msg.value == 1 wei);}
        function donateFinney() public payable {require(msg.value == 0.001 ether);}
        function donateEther() public payable {require(msg.value == 1 ether);}

        function withDraw() public {
            require(msg.sender == owner);
            payable(owner).transfer(address(this).balance);
        }
        
    }

    
// 38. 상태변수 a를 "A"로 설정하여 선언하세요. 이 함수를 "B" 그리고 "C"로 변경시킬 수 있는 함수를 각각 구현하세요. 단 해당 함수들은 오직 owner만이 실행할 수 있습니다. owner는 해당 컨트랙트의 최초 배포자입니다.
    //(힌트 : 동일한 조건이 서로 다른 두 함수에 적용되니 더욱 효율성 있게 적용시킬 수 있는 방법을 생각해볼 수 있음)

    contract Q38{
        string a = "A";
        address owner;
        constructor(){
            owner = msg.sender;
        }

        modifier onlyOwner{
            require(owner == msg.sender);
            _;
        }

        function setB() public onlyOwner {
            a = "B";
        }

        function setC() public onlyOwner {
            a = "C";
        }
        
    }

    
// 39. 특정 숫자의 자릿수까지의 2의 배수, 3의 배수, 5의 배수 7의 배수의 개수를 반환해주는 함수를 구현하세요.
    //예) 15 : 7,5,3,2  (2의 배수 7개, 3의 배수 5개, 5의 배수 3개, 7의 배수 2개) // 100 : 50,33,20,14  (2의 배수 50개, 3의 배수 33개, 5의 배수 20개, 7의 배수 14개)
    contract Q39 {
        function getNumber(uint _n) public pure returns(uint, uint, uint, uint) {
            return( _n/2, _n/3, _n/5, _n/7);
            }
        }
    

    
// 40. 숫자를 임의로 넣었을 때 오름차순으로 정렬하고 가장 가운데 있는 숫자를 반환하는 함수를 구현하세요. 가장 가운데가 없다면 가운데 2개 숫자를 반환하세요.
    //예) [5,2,4,7,1] -> [1,2,4,5,7], 4 // [1,5,4,9,6,3,2,11] -> [1,2,3,4,5,6,9,11], 4,5 // [6,3,1,4,9,7,8] -> [1,3,4,6,7,8,9], 6
   
    contract Q40 {
        function sorting(uint[] memory _a) public pure returns(uint,uint){
            for(uint i;i<_a.length-1;i++){
                for(uint j=i+1;j<_a.length;j++){
                    if (_a[i]>_a[j]){
                        (_a[i],_a[j])=(_a[j],_a[i]);
                    }
                }
            }

        if (_a.length%2==0){
            return (_a[_a.length/2-1], _a[_a.length/2]);
        }else{
             return (_a[_a.length/2],0);
        }
        }
    }

    contract Q4_answer {

    function getMedian(uint[] memory _a) public pure returns(uint[] memory){
        if(_a.length%2==0) {
            return getMedian_Even(_a);
        } else {
            return getMedian_Odd(_a);
        }
    }

    function getMedian_Odd(uint[] memory _a) public pure returns(uint[] memory) {
        _a = sorting(_a);
        uint[] memory b = new uint[](1);
        b[0] = _a[_a.length/2];
        return b; 
    }

    function getMedian_Even(uint[] memory _a) public pure returns(uint[] memory) {
        _a = sorting(_a);
        uint[] memory b = new uint[](2);
        (b[0], b[1]) = (_a[_a.length/2], _a[_a.length/2-1]);
        return b; 
    }

    function sorting(uint[] memory _a) public pure returns(uint[] memory){
        for(uint j=1; j<_a.length;j++) {
            for(uint i=0; i<j; i++) {
                if(_a[i] < _a[j]) {
                    (_a[i], _a[j]) = (_a[j], _a[i]);
                }
            }
        }
        return _a;
    }
}

