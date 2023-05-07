// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.2 <0.9.0;

contract UINTBYTES{
    // 8bits = 1bytes = 16진수 2자리 
    uint a;
    uint8 b;
    uint16 c;
    uint256 d;

    function setABCD(uint _a, uint8 _b, uint16 _c, uint256 _d)public {
        a=_a;
        b=_b;
        c=_c;
        d=_d;
    }
    //input의 경우, uint256->uint8과 같이 더 작은용량으로는 변환할 수 있지만 반대는 불가
    function setABCD2(uint _a, uint8 _b, uint8 _c, uint16 _d)public {
        a=_a;
        b=_b;
        c=_c;
        d=_d;
    }

    function getABCD() public view returns(uint, uint8, uint16, uint256){
        return (a,b,c,d) ;
    }
    //output의 경우,  uint8->uint256과 같이 큰용량으로는 변환 할 수 있지만 반대는 불가
    function getABCD2() public view returns(uint, uint, uint, uint){
        return (a,b,c,d) ;
    }


}