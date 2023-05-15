// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.2 <0.9.0;

contract review{
    mapping(uint=>uint) a;
    mapping(string=>uint) b;
    
    struct wallet{
        string name;
        uint number;
        address account;
    }
    //이름을 넣어 지갑받기
    mapping(string=>wallet) strToWallet;
    wallet[] wallets;

    //wallets에 새로운 wallet추가하는함수
    function setWallets(string memory _name, uint _number, address _account) public{
        wallets.push(wallet(_name, _number, _account));
    }

    //특정 번호의 wallet을 받아오기
    function getWallet(uint _n) public view returns(wallet memory){
        return wallets[_n-1];
    }

    function getWallet2(uint _n) public view returns(address){
        return wallets[_n-1].account;
    }

    //모든 월렛 반환
    function getWallets() public view returns(wallet[] memory){
        return wallets;
    }

}

contract review2{
    uint [10] a;
    uint [] b;

    function setA(uint _n, uint _a) public {
        a[_n-1] = _a;
    }

    uint count ;
    function pushA(uint _a)public {
        a[count++] = _a;
    }

    function setB(uint _b) public {
        b.push(_b);
    }
    
    function setB(uint _n, uint _b) public {
        b[_n-1]=_b;
    }

    function sumA() public view returns(uint){
        uint sum;
        for(uint i;i<a.length;i++){
            sum += a[i];
        }
        return sum;
    }

}
