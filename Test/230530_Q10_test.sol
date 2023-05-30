// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.2 <0.9.0;

/*흔히들 비밀번호 만들 때 대소문자 숫자가 각각 1개씩은 포함되어 있어야 한다 등의 조건이 붙는 경우가 있습니다. 그러한 조건을 구현하세요.

입력값을 받으면 그 입력값 안에 대문자, 소문자 그리고 숫자가 최소한 1개씩은 포함되어 있는지 여부를 알려주는 함수를 구현하세요.
시간은 9시 35분까지 제출은 9시 30분부터입니다.*/

contract Q10{
    function password(string memory _input) public pure returns(string memory,bool,string memory,bool,string memory,bool){
        uint num;
        uint upper;
        uint lower;

        for (uint i; i< bytes(_input).length ;i++){
            if( 48 <= uint8(bytes(_input)[i]) &&  uint8(bytes(_input)[i]) <=57 ){
                num ++;
            }else if(65 <= uint8(bytes(_input)[i]) &&  uint8(bytes(_input)[i]) <=90 ){
                upper++;
            }else if(97 <= uint8(bytes(_input)[i]) &&  uint8(bytes(_input)[i]) <=122 ){
                lower++;
            }
        }
        
        return ( "num :", getresult(upper) ,"upper :", getresult(upper),"lower :", getresult(lower));
    }
    function getresult(uint _a) public pure returns(bool){
        if(_a>0){
            return true;
        }else{
            return false;
        }

    }
}






