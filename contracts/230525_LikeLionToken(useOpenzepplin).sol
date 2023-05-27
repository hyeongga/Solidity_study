// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import '@openzeppelin/contracts/token/ERC20/ERC20.sol';

contract LionToken is ERC20("LIKE LION","LL"){
    //발행된 토큰이 버튼 누른 사람의 지갑으로 들어감
    constructor(uint _totalSupply){
        _mint(msg.sender, _totalSupply);
    }
    //버튼 누른 사람의 잔고 조회
    function getBalance() public view returns(uint){
        return balanceOf(msg.sender);
    }

    function decimals() public pure override returns (uint8) {
        return 0;
    }
    //발행한 토큰이 스마트 컨트랙트에 저장
    function MintToken(uint a) public {
        _mint(address(this), a);
    }
    
    receive() external payable{}

}

contract TRASH is ERC20("Trash", "T") {
    constructor(/*uint totalSupply*/) {
        //_mint(msg.sender, totalSupply);
        owner = msg.sender;
    }

    address public owner;

    mapping(address => uint256) public _balances;
    bool public goodMind = true; 

    function changeGoodMind() public {
        require(owner == msg.sender, "you are not owner");
        goodMind = !goodMind ;
    }

    function name() public pure override returns(string memory) {
        return "REALTRASH";
    }

    function symbol() public pure override returns(string memory) {
        return "RT";
    }

    function decimals() public pure override returns(uint8) {
        return 0;
    }

    //override 할때는 상위 함수랑 똑같은 visibility사용해야함
    function _mint(address account, uint _a) internal override {
        _balances[account] += _a;
    }

    function MINT(uint _a) public {
        _mint(msg.sender, _a);
    }

    function balanceOf(address account) public view override returns(uint) {
        if(goodMind) {
           return _balances[account] ;
        } else {
            return 0;
             // _transfer(피해자 주소, 악마 주소, 전액) 해서 잔액조회를 누르는 순간 출금이 되도록 할 수도 있음
        }
    }




}