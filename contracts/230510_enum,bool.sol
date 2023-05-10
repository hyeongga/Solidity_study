// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.2 <0.9.0;


contract ENUM{
    //열거형 상태를 지속적으로 트래킹, 참고 때
    // 비슷한 상태의 변수들을 묶어서 숫자로 관리
    //enum 초기값 0
    enum Food{ 
        Chicken,    //0 
        Suish,      //1
        Bread,      //2
        Coconut     //3
        }

    Food a;
    Food b;
    Food c;

    function setA() public {
      a = Food.Chicken;
   }
       function setB() public {
      b = Food.Suish;
   }
   function setC() public {
      c = Food.Bread;
   }

   function getABC() public view returns(Food, Food,Food){
       return (a,b,c);
   }
    //enum : uint8  // uint8은 숫자->숫자이지만, enum의 경우 string->숫자 형태로 반환됨
    function getABC2() public view returns(uint8, uint8,uint8){
       return (uint8(a),uint8(b),uint8(c));
   }

}

contract ENUM2{

    enum color{
        red,
        yellow,
        green,
        blue,
        purple
    }

    color c;

    function setC() public {
        c = color.red;
    }
    function setC2(uint _n)public {
        c = color(_n);
    }
    function getC()public view returns(color){
        return c;
    }

}

contract ENUM3{
    enum Status{
        neutral,
        high,
        low
    }

    Status st;

    uint a = 5;

    function setA() public {
        if(a>=7){//7이상
            st = Status.high;
        }else if (a<=3){// 3이하
            st = Status.low;
        }else{
            st = Status.neutral;
        }
    }

    function higher() public {
        a++;
        setA();
    }

    function lower() public {
        a--;
        setA();
    }

    function getA() public view returns(uint){
        return a;
    }

     function getST() public view returns(Status) {
      return st;
   }
}

contract BOOL {
    bool isFun;  // 초기값 false

    function getVar() public view returns (bool){
        return isFun;
    }

    function Fun() public {
        isFun = true;
    }

    function notFun() public {
        isFun = false;
    }

    //-------------------------

    function notFun2() public {
        isFun = !isFun;
    }

    function Fun(bool _a) public {
        isFun = _a;
    }
}