// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.2 <0.9.0;


contract Q41_42{

//41. 숫자만 들어갈 수 있으며 길이가 4인 배열을 (상태변수로)선언하고 그 배열에 숫자를 넣는 함수를 구현하세요. 배열을 초기화하는 함수도 구현하세요. (길이가 4가 되면 자동으로 초기화하는 기능은 굳이 구현하지 않아도 됩니다.)

    uint[4] public Q41Array;
    function Q41 (uint[] memory _a ) public returns(uint[4] memory ){
        uint i ;
        while(i<4){
        Q41Array[i++] = _a[i];
        }
        return Q41Array;
    }

    function Q41Initialize() public {
        delete Q41Array;
    }
    
//42. 이름과 번호 그리고 지갑주소를 가진 '고객'이라는 구조체를 선언하세요. 새로운 고객 정보를 만들 수 있는 함수도 구현하되 이름의 글자가 최소 5글자가 되게 설정하세요.

    struct Client{
        string name;
        uint number;
        address wallet;
    }

    Client[] public clients;

    function Q42(string memory _name, uint _number,address _wallet) public {
        require(bytes(_name).length >=5);
        clients.push(Client(_name, _number, _wallet));
    }
}

//43. 은행의 역할을 하는 contract를 만드려고 합니다. 별도의 고객 등록 과정은 없습니다. 해당 contract에 ether를 예치할 수 있는 기능을 만드세요. 
// 또한, 자신이 현재 얼마를 예치했는지도 볼 수 있는 함수 그리고 자신이 예치한만큼의 ether를 인출할 수 있는 기능을 구현하세요.
    //힌트 : mapping을 꼭 이용하세요.
    
    contract Q43{
        mapping (address => uint) public account;

        function deposite() public payable {
            require( msg.value <= (msg.sender).balance, "earn money");
            account[msg.sender] += msg.value;
        }

        function withdrawAll() public {
            payable(msg.sender).transfer(account[msg.sender]);
            account[msg.sender] =0;
        }

        function withDraw(uint _amount) public {
            require(account[msg.sender] >= _amount);
            account[msg.sender] -= _amount;
            payable(msg.sender).transfer(_amount);
        }
    }

    

contract Q44_46{

//44. string만 들어가는 array를 만들되, 4글자 이상인 문자열만 들어갈 수 있게 구현하세요.
    string[] public Q44_array;
    modifier limit(string memory _string){
        require(bytes(_string).length>=4);
        _;
    }
    function Q44 (string memory _string) public limit(_string){
        Q44_array.push(_string);
    }
    
//45. 숫자만 들어가는 array를 만들되, 100이하의 숫자만 들어갈 수 있게 구현하세요.
    uint[] public Q45Array;
    function Q45 (uint _a) public{
        require(_a<=100);
        Q45Array.push(_a);
    }
    
//46. 3의 배수이거나 10의 배수이면서 50보다 작은 수만 들어갈 수 있는 array를 구현하세요.
//(예 : 15 -> 가능, 3의 배수 // 40 -> 가능, 10의 배수이면서 50보다 작음 // 66 -> 가능, 3의 배수 // 70 -> 불가능 10의 배수이지만 50보다 큼)

    uint[] public Q46Array;
    function Q46(uint _a) public{
        require( _a%3==0 || _a%10==0 && _a<50);
        Q46Array.push(_a);
    }    

}
//47. 배포와 함께 배포자가 owner로 설정되게 하세요. owner를 바꿀 수 있는 함수도 구현하되 그 함수는 owner만 실행할 수 있게 해주세요.

    contract Q47{
        address private owner;

        constructor(){
            owner = msg.sender;
        }

        function setOwner(address _a) public{
            require(owner == msg.sender);
            owner = _a;
        }
    }
    
//48. A라는 contract에는 2개의 숫자를 더해주는 함수를 구현하세요. B라고 하는 contract를 따로 만든 후에 A의 더하기 함수를 사용하는 코드를 구현하세요.
    contract Q48_A {
        uint public num;
        function add(uint _a, uint _b) public returns(uint){
            num = _a+_b;
            return(_a+_b);
        }
    }

    contract Q48_B is Q48_A{}

    contract Q48_B2 {
        Q48_A a= new Q48_A();
        uint public num;
        function addFromA(uint _c, uint _d) public returns(uint) {
            num = a.add(_c, _d);
            return a.add(_c, _d);
        }
    }


contract Q49_50{
//49. 긴 숫자를 넣었을 때, 마지막 3개의 숫자만 반환하는 함수를 구현하세요.
//예) 459273 → 273 // 492871 → 871 // 92218 → 218
    function Q49(uint _a)public pure returns(uint){
        return _a%1000;
    }
    
/*50. 숫자 3개가 부여되면 그 3개의 숫자를 이어붙여서 반환하는 함수를 구현하세요. 
    예) 3,1,6 → 316 // 1,9,3 → 193 // 0,1,5 → 15 
    응용 문제 : 3개 아닌 n개의 숫자 이어붙이기*/
    function Q50(uint[] memory _a) public pure returns(uint){
        uint num;
        for (uint i=_a.length; i>0 ; i--){
            num += _a[_a.length-i]*10**(i-1) ;
        }
       return(num);
    }
}