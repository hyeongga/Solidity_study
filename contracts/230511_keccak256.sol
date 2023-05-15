// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.2 <0.9.0;

contract STRING_Compare{
    /*string은 길이가 불분명(memory)해서 바로 비교 불가(불확실성을 싫어함)
    (string , string 비교 불가) & (string to bytes로 변환후 bytes memory값끼리도 비교 안됨)
    => keccak256을 통해서 변환 후 비교해야 함*/

    //keccak256은 bytes32 (bytes memory 사용x)
    // keccak256은  bytes 형태로의 input만 받음 (인풋으로 케칵안에 바로 스트링을 넣으면 에러 발생함)
    // abi.encodePacked, abi.encode, bytes를 통해 bytes형태로 변환 후 keccak256적용 해야 함
    function compare1(string memory s1) public pure returns(bytes32){
        return keccak256(abi.encodePacked(s1));
    }
        
    function keccak2(string memory s1) public pure returns(bytes32){
        return keccak256(bytes(s1));
    }

    /* bytes vs abi.encodePacked
    uint랑 bytes는 호환이 안됨 ; 정적 동적이라서 문제  => 이때 abi를 써줘야함
    input값이 2개 이상인 경우, abi 사용 - bytes는 안됨
    */

    // 문자열 비교
    function compare1(string memory s1, string memory s2) public pure returns(bool){
        return keccak256(bytes(s1)) == keccak256(bytes(s2));
    }

    function compare(string memory s1, string memory s2) public pure returns (bool) {
        return keccak256(abi.encodePacked(s1)) == keccak256(abi.encodePacked(s2));
    }
  
    function compare2(string memory s1, string memory s2) public pure returns (bool) {
        if (bytes(s1).length != bytes(s2).length) {
            return false;
        }
        return keccak256(abi.encodePacked(s1)) == keccak256(abi.encodePacked(s2));
    }

    // bytes, encodePacked는 0x로 출력 / encode는 0x000...0으로 출력
    function compare4(string memory s1) public pure returns(bytes memory, bytes memory, bytes memory) {
        return (bytes(s1), abi.encodePacked(s1), abi.encode(s1));
    }

}
