// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import '@openzeppelin/contracts/token/ERC20/ERC20.sol';

contract LionToken is ERC20("LIKE LION","LL"){

    constructor(uint _totalSupply){
        _mint(msg.sender, _totalSupply);
    }

    function getBalance() public view returns(uint){
        return balanceOf(msg.sender);
    }

}