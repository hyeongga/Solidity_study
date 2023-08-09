// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.2 <0.9.0;

contract FixedDynamic {
    uint[] public a;    //동적
    uint[4] public b;   //정적
    uint count;         //정적배열에서 차례대로 input값 넣기 위해 사용

    function getAB() public view returns(uint[] memory, uint[4] memory) {
        return (a,b);
    }

    //동적배열 추가
    function pushA(uint _n) public {
        a.push(_n);
    }

    //정적배열 추가 : 추가할 변수_b의 자리를 _a값을 통해 지정
    function pushB(uint _a, uint _b) public {
        b[_a-1] = _b;
    }
    //차례대로 정적배열 추가 : count(상태변수) 사용
    function pushB2(uint _a) public {
        b[count] = _a;
        count++;
    }

    //차례대로 정적배열 추가 : but, state variable 사용 (x)
    function pushB3(uint _a) public {
        require(_a !=0);
        if(getLengthOfB()==4) {
            delete b;
        }
        
        b[getLengthOfB()] = _a;
    }
    
    function getLengthOfB() public view returns(uint) {
        for(uint i=0; i<4; i++) {
            if(b[i]==0) {
                return i;
            }
        }
        return 4;
    }
}