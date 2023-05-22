// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.2 <0.9.0;

contract INITIALIZATION {
    uint a;
    string b;
    address c;
    bytes1 d;
    bytes e;
    bool f;

    struct set1 {
        uint a;
        string b;
        address c;
        bytes32 d;
        bytes e;
        bool f;
    }

    set1 public S1;
    set1[] group1;

    uint[] g;
    string[] h;
    bytes1[4] i;
    uint[4] j;
    address[4] k;
    string[4] l;
    bytes[] aa;
    bytes[4] bb;

    struct set2{
        uint[] g;  //동적 => new uint[](0)로 초기값 설정
        string[] h;
        bytes1[4] i; //정적 =>  new bytes1[](0) 불가, bytes1[4] 불가, new bytes1[4] 불가
        uint[4] j;   
        address[4] k;
        string[4] l;
        bytes[] aa;
        bytes[4] bb;
    }
    
    /*
    set2 public S2;
    : public으로 변수를 지정할 경우, struct안에 전부 []로 되어있으면 무엇을 받아올지 몰라 실행이 안됨
    : 배열의 초기값은 뜨지 않음
    : uint aa; 를 추가로 작성해주어 하나라도 출력될 수 있는 값을 줘야 작동됨
    : 전부 배열로 되어 있더라도 public이 없으면(private이면) 실행됨
    */
    set2 S2;
    set2[] group2;

    /* 1. 변수 초기값 입력하는 법
    uint : 0  |  string : ""    |   address : address(0)
    bytes1 :  0X00  or bytes1(0)    |   bytes : new bytes(0)    |   bool : false */
    function pushG1() public {
        group1.push(set1(0,"",address(0),bytes32(0),new bytes(0),false));
    }

    /* 2.배열 초기값 입력하는 법 
    : 동적 배열의 경우 => new 데이터형[](0)
    : 정적 배열의 경우 => 지역변수로 정적 배열 다시 선언(자동으로 초기값 생김) 후 struct에 넣어주기 */
    function pushG2() public {
        bytes1[4] memory _i; //new 데이터형[](0)  x
        uint[4] memory _j;
        address[4] memory _k; 
        string[4] memory _l;
        bytes[4] memory _bb;
        
        group2.push(set2(new uint[](0), new string[](0), _i, _j, _k ,_l , new bytes[](0), _bb ));
    }

    function getS2() public view returns(set2 memory) {
        return S2;
    }

    function getG2() public view returns(set2[] memory) {
        return group2; // 0: tuple(uint256[],string[],bytes1[4])[]:
    }


    function getA() public view returns(uint,string memory, address, bytes1, bytes memory, bool) {
        return (a,b,c,d,e,f);
    } 

    function getG() public view returns(uint[] memory, string[] memory, bytes1[4] memory, uint[4] memory, address[4] memory, string[4] memory) {
        return (g,h,i,j,k,l );
    }
}