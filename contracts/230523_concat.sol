// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.2 <0.9.0;

contract Concat{
    // concatenate : 문자열 이어붙이기

    //abi.encodePacked를 사용한 문자열 붙이기
    function concat1(string memory a, string memory b) public pure returns(string memory){
        return string(abi.encodePacked(a,b));
    } //abi.encodePacked : 직렬화 과정이라 생각하면 됨

    //concat을 이용한 문자열 붙이기
    function concat2(string memory a, string memory b) public pure returns(string memory){
        return string.concat(a,b);
    }

    // a:aab:bb 와같이 string 여러개 연결 가능
    function concat3(string memory a, string memory b) public pure returns(string memory) {
        return string.concat(a,":", a, a, " ", b, ":", b, b); 
    }

    // uint a까지 같이 스트링으로 붙여서 출력하고 싶음 : but, a가 숫자로 나오지 않고 아스키코드에의해 변환된 값이 나옴
    function concat4(uint a, string memory b, string memory c) public pure returns(string memory) {
        return string(abi.encodePacked(a,b,c));
    }

    // concat4문제 해결하기 위헤 값 조회
    function returnEncodePacked(uint a, string memory b) public pure returns(bytes memory, bytes memory) {
        return (abi.encodePacked(a), abi.encodePacked(b));
    }
    //123입력시 123출력 / but, 한자리 수만 가능
    function concat4(uint a, uint b, uint c) public pure returns(string memory) {
        a = a+48;
        b = b+48;
        c = c+48;
        return string(abi.encodePacked(a,b,c));
    }

}