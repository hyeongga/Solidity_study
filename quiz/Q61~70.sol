// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.2 <0.9.0;

contract Q61_Q66{
// 61. a의 b승을 반환하는 함수를 구현하세요.

    function Q61getAofB(uint a, uint b) public pure returns(uint){
        return a**b;
    }
    
// 62. 2개의 숫자를 더하는 함수, 곱하는 함수 a의 b승을 반환하는 함수를 구현하는데 3개의 함수 모두 2개의 input값이 10을 넘지 않아야 하는 조건을 최대한 효율적으로 구현하세요.
    modifier input(uint _a, uint _b) {
        require(_a<=10 && _b<=10);
        _;
    }
    function Q62addNum(uint _a, uint _b) public input(_a,_b) pure returns(uint){
        return _a+_b;
    }
    function Q62mulNum(uint _a, uint _b) public input(_a,_b) pure returns(uint){
        return _a*_b;
    }
    function Q62squNum(uint _a, uint _b) public input(_a,_b) pure returns(uint){
        return _a**_b;
    }
        
    // 63. 2개 숫자의 차를 나타내는 함수를 구현하세요.
    function Q63(uint _a, uint _b) public pure returns (uint){
        if (_a>_b){
        return(_a-_b);
        }else{
        return(_b-_a);
        }
    }

    
// 64. 지갑 주소를 넣으면 5개의 4bytes로 분할하여 반환해주는 함수를 구현하세요.
    function Q64(address _input) public pure returns(bytes4[5] memory){
        bytes4[5] memory a;
        for(uint i ; i<5; i++){
        bytes4 q = bytes4(abi.encodePacked(bytes20(_input)[i*4],bytes20(_input)[i*4+1],bytes20(_input)[i*4+2],bytes20(_input)[i*4+3]));
        a[i] = q;
        }
        return (a);
    }

    function Q64_2(address _a) public pure returns(bytes4[5] memory){
        bytes4[5] memory a;
        bytes memory b = new bytes(4);

        for(uint i ; i<5; i++){
            for(uint j;j<4;j++){
                b[j] =  bytes20(_a)[i*4+j];
            }
        a[i] = bytes4(b);

        }
        return (a);
    }
    

    // 65. 숫자 3개를 입력하면 그 제곱을 반환하는 함수를 구현하세요. 그 3개 중에서 가운데 출력값만 반환하는 함수를 구현하세요.
    // 예) func A : input → 1,2,3 // output → 1,4,9 | func B : output 4 (1,4,9중 가운데 숫자)

    function Q65_1 (uint _a, uint _b, uint _c) public pure returns(uint, uint, uint) {
        return (_a**2, _b**2, _c**2);
    }

    function Q65_2 (uint _a, uint _b, uint _c) public pure returns( uint) {
        uint[3] memory array = [_a,_b,_c];
        for(uint i;i<2;i++){
            for(uint j=1;j<3;j++){
                if(array[i]>array[j]){
                (array[i],array[j])=(array[j],array[i]);
                }
            }
        }
        return  (array[1]);
    }
    

// 66. 특정 숫자를 입력했을 때 자릿수를 알려주는 함수를 구현하세요. 추가로 그 숫자를 5진수로 표현했을 때는 몇자리 숫자가 될 지 알려주는 함수도 구현하세요.
    function Q66(uint _n) public pure returns(uint,uint){
        uint i=1;
        uint j=1;
        (uint n1, uint n2) = (_n, _n);
        while(n1>=10){
            n1 = n1/10;
            i++;
        }
        while(n2>=5){
            n2 = n2/5;
            j++;
        }
        return (i,j);
    }
}

// 67. 자신의 현재 잔고를 반환하는 함수를 보유한 Contract A와 다른 주소로 돈을 보낼 수 있는 Contract B를 구현하세요.
// B의 함수를 이용하여 A에게 전송하고 A의 잔고 변화를 확인하세요.

    contract Q67A{
        function A()public view returns(uint){
            return address(this).balance;
        }
        receive() external payable{}
    }

    contract Q67B{
        function deposit() payable public{}
        function B(address payable _A ,uint _amount) public {
        _A.transfer(_amount);
        }
    }
        

contract Q68_Q70{

/* 68. 계승(팩토리얼)을 구하는 함수를 구현하세요. 계승은 그 숫자와 같거나 작은 모든 수들을 곱한 값이다. 
    예) 5 → 1*2*3*4*5 = 120, 11 → 1*2*3*4*5*6*7*8*9*10*11 = 39916800 / while을 사용해보세요 */
    function Q68(uint _n) public pure returns(uint){
        uint result = 1;
        while(_n>0){
            result = result*_n;
            _n--;
        }
        return result;
    }
    
// 69. 숫자 1,2,3을 넣으면 1 and 2 or c 라고 반환해주는 함수를 구현하세요.
    // 힌트 : 7번 문제(시,분,초로 변환하기)

    function Q69(uint _a, uint _b, uint _c) public pure returns(string memory){
        _a +=48;
        _b +=48;
        _c +=0x60; //+96
        return (string(abi.encodePacked(_a," and ",_b," or ",_c)));
    }
    
// 70. 번호와 이름 그리고 bytes로 구성된 고객이라는 구조체를 만드세요. 
// bytes는 번호와 이름을 keccak 함수의 input 값으로 넣어 나온 output값입니다.  고객의 정보를 넣고 변화시키는 함수를 구현하세요.
    struct client{
        string name;
        uint number;
        bytes32 Id;
    }

    client Client;

    function Q70(uint _num, string memory _name) public returns(client memory) {
        Client = client(_name, _num, keccak256(abi.encodePacked(_num, _name)));
        return Client;
    }
}