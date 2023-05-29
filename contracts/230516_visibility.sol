// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.2 <0.9.0;

contract VISIBILITY{
    //visibility는 한번 설정하면 변경이 사실상 불가

    // 내부(컨트랙트)에서만 접근가능
    function privateF() private pure returns(string memory){
        return "private";
    }
    // 내부랑 상속한 곳에서 접근가능
    function internalF() internal pure returns(string memory){
        return "internal";
    }
    // 어디에서든 접근가능
    function publicF() public pure returns(string memory){
        return "public";
    }
    // 외부에서만 접근가능 (지금 우리가 있는 곳 : 외부)
    function externalF() external pure returns(string memory){
        return "external";
    }

    // private, internal 사용법 ----------------------------------------

    // 프라이빗 함수를 사용하기 위해서는 public함수로 불러와야 함
    function usePrivateF()public pure returns(string memory){
        return privateF();  //private함수의 return과 상관없이 값을 받아오려면 return 붙여주기!
    }
    //내부or상속에서 접근하면,  private함수에 접근하여 값 return
    function usePrivateF2() internal pure returns(string memory) {
        return privateF();
    }

    // public함수로 internalF 불러오기
    function useinternalF()public pure returns(string memory){
        return internalF();
    }

}

contract A is VISIBILITY {
    /* 
    상속해서 사용할 경우 
    : internal, public만 접근가능
    : 상속받은 상태는 외부로 취급 x 
    */

    function testPrivateF1() public pure returns(string memory) {
        return usePrivateF();
    }

    function testPrivateF2() public pure returns(string memory) {
        return usePrivateF2();
    }
    //바로 internalF 사용가능
    function testInternal2() public pure returns(string memory) {
        return internalF();
    }

    function testPublic() public pure returns(string memory) {
        return publicF();
    }

    /*
    : private 바로 사용 불가 ; internal이나 public으로 선언한 함수로 부터 가지고 와야함
    function testPrivate() public pure returns(string memory) {
        return privateF();
    }
    : external 사용 불가
    function testExternal() public pure returns(string memory) {
        return externalF();
    }
    */
}

contract Outsider {
    /* 
    인스턴스화해서 사용할 경우
    : external, public만 접근가능
    : 외부로 취급
    */

    VISIBILITY vs = new VISIBILITY(); // new 변수를 하나 더 만드는 함수

    function getExternalFromVS() public view returns(string memory) {
        return vs.externalF();
    }

    function getPublicFromVS() public view returns(string memory) {
        return vs.publicF();
    }

    // internal, private 사용 불가 ; public함수로 새로 불러와서 사용해야함(useinternalF)
    function getinternalFromVS() public view returns(string memory) {
        return vs.useinternalF();
    }
}