// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.2 <0.9.0;

contract Q51_60{
    // 51. 숫자들이 들어가는 배열을 선언하고 그 중에서 3번째로 큰 수를 반환하세요.
    uint[] public Q51Array;
    function Q51push(uint[] memory _a) public {
        Q51Array = _a;
    }

    function Q51() public returns(uint){
        for (uint i;i<Q51Array.length;i++){
            for(uint j; j<Q51Array.length;j++){
                if (Q51Array[i]<Q51Array[j]){
                    (Q51Array[i],Q51Array[j])=(Q51Array[j],Q51Array[i]);
                }
            }
        }
        return Q51Array[2];
    }

    
// 52. 자동으로 아이디를 만들어주는 함수를 구현하세요. 이름, 생일, 지갑주소를 기반으로 만든 해시값의 첫 10바이트를 추출하여 아이디로 만드시오.
    bytes10 Q52ID;
    function Q52(string memory _name, uint _birth, address _wallet) public returns(bytes10){
        Q52ID = bytes10(keccak256(abi.encodePacked(_name, _birth, _wallet)));
        return Q52ID;
    }
    
// 53. 시중에는 A,B,C,D,E 5개의 은행이 있습니다. 각 은행에 고객들은 마음대로 입금하고 인출할 수 있습니다. 각 은행에 예치된 금액 확인, 입금과 인출할 수 있는 기능을 구현하세요.
// 힌트 : 이중 mapping을 꼭 이용하세요.
    mapping (string=>mapping(address=>uint)) Q53Mapping;
    function Q53Deposite (string memory _bank, uint _amount)public payable returns(uint) {
        Q53Mapping[_bank][msg.sender] += _amount;
        return Q53Mapping[_bank][msg.sender];
    }

    function Q53Withdraw (string memory _bank, uint _amount)public returns(uint) {
        Q53Mapping[_bank][msg.sender] -= _amount;
        payable(msg.sender).transfer(_amount);
        return Q53Mapping[_bank][msg.sender];
    }

    
// 54. 기부받는 플랫폼을 만드세요. 가장 많이 기부하는 사람을 나타내는 변수와 그 변수를 지속적으로 바꿔주는 함수를 만드세요.
// 힌트 : 굳이 mapping을 만들 필요는 없습니다.
    address KingDonator;
    uint amount;
    function Q54() public payable returns (address){
        
        if (msg.value > amount){
            KingDonator = msg.sender;
            amount = msg.value;
        }
        return KingDonator;
    }

} 
// 55. 배포와 함께 owner를 설정하고 owner를 다른 주소로 바꾸는 것은 오직 owner 스스로만 할 수 있게 하십시오.
contract Q55{
    address owner;
    constructor(){
        owner = msg.sender;
    }
    function Q55ChangeOwner(address _newOwner) public {
        require(owner == msg.sender);
        owner = _newOwner;
    }
}

// 56. 위 문제의 확장버전입니다. owner와 sub_owner를 설정하고 owner를 바꾸기 위해서는 둘의 동의가 모두 필요하게 구현하세요.
contract Q56{
    constructor(address _input){
        owner = msg.sender;
        sub_owner = _input;
    }
    address owner;
    address sub_owner;
    bool[2] public accept;  // gas비교시 uint8로 설정하는게 더 저렴함

    function Q56Accept() public {
        require(msg.sender == owner || msg.sender == sub_owner);
        if(msg.sender == owner){
        accept[0] = true;
        }else{
        accept[1] = true;
        }
    }

    function Q56NewOwner(address _new) public {
        require(accept[0] && accept[1] && msg.sender==owner);
        owner = _new;
        delete accept;
    }
}
    
// 57. 위 문제의 또다른 버전입니다. owner가 변경할 때는 바로 변경가능하게 sub-owner가 변경하려고 한다면 owner의 동의가 필요하게 구현하세요.
contract Q57{
    constructor(address _input){
        owner = msg.sender;
        sub_owner = _input;
    }
    address owner;
    address sub_owner;
    bool public accept;  // gas비교시 uint8로 설정하는게 더 저렴함

    function Q56Accept() public {
        require(msg.sender == owner);
        accept = true;
    }

    function Q56NewOwner(address _new) public {
        require(msg.sender==owner || msg.sender==sub_owner && accept== true );
        owner = _new;
        delete accept;
    }
}
    
// 58. A contract에 a,b,c라는 상태변수가 있습니다. a는 A 외부에서는 변화할 수 없게 하고 싶습니다. b는 상속받은 contract들만 변경시킬 수 있습니다. c는 제한이 없습니다. 각 변수들의 visibility를 설정하세요.
contract Q58{
    uint private a;
    uint internal b;
    uint public c;
}
    
// 59. 현재시간을 받고 2일 후의 시간을 설정하는 함수를 같이 구현하세요.
contract Q59{
    uint public currentTime;

    function setTime() public returns(uint){
        // return block.timestamp+60*60*24*2;
        currentTime = block.timestamp;
        return currentTime+2 days;
    }
}
    
/* 60. 방이 2개 밖에 없는 펜션을 여러분이 운영합니다. 각 방마다 한번에 3명 이상 투숙객이 있을 수는 없습니다. 
    특정 날짜에 특정 방에 누가 투숙했는지 알려주는 자료구조와 그 자료구조로부터 값을 얻어오는 함수를 구현하세요.  
    예약시스템은 운영하지 않아도 됩니다. 과거의 일만 기록한다고 생각하세요.
    힌트 : 날짜는 그냥 숫자로 기입하세요. 예) 2023년 5월 27일 → 230527 */
contract Q60{
    mapping(uint=>mapping(uint8=>string[])) public book;

    function Book(uint _date, uint8 _num, string[] memory _names) public {
        book[_date][_num] = _names;
    }

    function getGuest(uint _date, uint8 _num) public view returns(string[] memory){
        return book[_date][_num];
    }
}