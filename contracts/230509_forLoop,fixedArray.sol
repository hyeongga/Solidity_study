// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.2 <0.9.0;

contract ForLoop{
    function forLoop() public pure returns(uint){
        uint a;

        for(uint i=1; i<6; i++ /*시작점; 끝점; 변화방식*/) {
            a = a+i; // a+=i
        } // i는6으로 끝남

        return a;
    }

    function forLoop2() public pure returns(uint, uint){
        uint a;
        uint i;

        for(i=1; i<6; i++ /*시작점; 끝점; 변화방식*/) {
            a = a+i;
        }

        return (a,i);
    }
    //-------------------------------------------------------------------------------------------
    uint[4] c;
    uint count;
    
    function pushC(uint _n)public {
        c[count++] = _n;
    }

    function getC() public view returns (uint[4] memory){
        return c;
    }

    function forLoop3() public view returns(uint){
        uint a;
        for(uint i=0;i<4;i++){
            a=a+c[i];
        }
        return a;
    }

    function forLoop4() public view returns(uint){
        uint a;
        for(uint i=0; i<c.length;i++){
            a = a+c[i];
        }
        return a;
    }
    //--------------------------------------------------------------------------------
    uint[] d;
    
    function pushd(uint _n) public {
        d.push(_n);
    }

    function getD() public view returns(uint[] memory) {
        return d;
    }

    function forLoop6() public view returns(uint) {
        uint a;
        for(uint i=0;i<d.length;i++) {
            a=a+d[i];
        }
        return a;
    }

}

contract fixedArray{
    uint[] a;
    uint[4] b;  // fixed array ; 길이가 정해진 배열 ; 정적

    function getALength() public view returns(uint){
        return a.length;
    }

    function pushA(uint _n) public {
        a.push(_n);
    }

    function getA() public view returns(uint[] memory) {
        return a;
    }

    function getBLength() public view returns(uint){
        return b.length;
    }


    /* ----------------------------------------------------------
    fixed array는 길이가 정해져 있기 때문에 push, pop사용 불가
    function pushB(uint _n) public {
        a.push(_n);
    }
    ------------------------------------------------------------- */
    
    function pushB(uint n, uint _n) public{
        b[n] = _n;
    }

    uint count;
    function pushB2(uint _n) public {
        b[count++] = _n;  // 첫자리 0번부터 시작
        // b[++count] = _n; 첫자리가 1번부터 시작
    }

     function getB() public view returns(uint[4] memory) {
        return b;
    } // 정적 array도 memory 적어줘야함

    function getCount() public view returns(uint) {
        return count;
    }

}