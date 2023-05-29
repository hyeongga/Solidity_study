// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.18;

/*
new는 새로운 컨트랙트를 만듦.
new가 없을 경우 검색의 의미를 나타내므로 ()안에 contract의 주소가 들어가야함
*/

contract A{
    uint public a;
    uint public b;
    constructor(uint _a, uint _b) {
        a = _a;
        b = _b;
    }
}

// new로 새로운 컨트랙트 생성 ; 머클트리로보면 리프노드 새로 생성
contract B{
    A public new1 = new A(1,2);  //새로운 A형 new1 선언 (input으로 1,2를 넣음)
    A public new2 ;              //새로운 A형 new2 선언 (constructor의 input값으로 선언)

    constructor(uint _a, uint _b){
        new2 = new A(_a, _b);
    }
}

//기존에 있는거 추적한는것 ; 이미 배포된 컨트렉트를 조회하고 싶을때
contract B2{
    A public new3 ;

    constructor(address _a){
        new3 = A(_a);
        //기존의 컨트랙트와 연결된 값
    }
}

//constructor있는 값은 어떻게 상속받아올까?
contract C is A(3,4){
    //.../
}



