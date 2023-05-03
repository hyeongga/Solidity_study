// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.2 <0.9.0;

contract StoreandReturn {
    uint a; // 숫자형 변수 a
    uint b; // 숫자형 변수 b
    uint c=2; //숫자형 변수c, 값은 2

     // 함수이고, 이름은 valueA, input값은 없음, public 하고 view 함, output 값은 1개 있음, uint 형임
    function getA() public view returns(uint){
        return a;
    }
    function setA(uint _a) public {
        a= _a;
    }
    function setAasFive()public {
        a=5;
    }
    function getB() public view returns(uint){
        return b;
    }
    function setB(uint _b) public {
        b = _b;
    }
    function setBasSeven() public {
        b=7;
    }
    //output값 2개, 둘다 uint형
    function getAB() public view returns(uint,uint){
        return(a,b);
    }
    function getABC() public view returns (uint,uint,uint){
        return(a,b,c);
    }

  /*
    view와 pure 함수는 state variable(상태변수)의 값을 변화시키지는 않음 -> gas비 안씀
    */
    // 숫자 _aa와 _bb를 받아서 이 2개의 숫자를 더한 결과값을 반환하는 함수 Add를 구현하세요
    function Add(uint _aa, uint _bb) public pure/*상태변수는 하나도 필요없을 때 pure*/ returns(uint) {
        return _aa+_bb;
    }
    // 숫자 a와 b를 갖고와서 이 2개의 숫자를 더한 결과값을 반환하는 함수 Add2를 구현하세요
    function Add2() public view/*상태변수를 갖고오기 때문에 view로*/ returns(uint) {
        return a+b;
    }

}