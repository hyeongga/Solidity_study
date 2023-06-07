// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC1155/ERC1155.sol";
import "@openzeppelin/contracts/utils/Strings.sol";

contract RAINBOW is ERC1155 {
    uint public constant Red = 1;
    uint public constant Yellow = 2;
    uint public constant Green = 3;
    uint public constant Blue = 4;
    uint public constant Purple = 5;
    string public baseUri;

// "https://gateway.pinata.cloud/ipfs/QmQLvf7mH86x22td2ZnuxGowiiepVNDS4VGHRWYaZ4ZHPP"
    constructor(string memory _baseUri) ERC1155(_baseUri) {
        baseUri = _baseUri;
        _mint(msg.sender, Red, 5, "");
        _mint(msg.sender, Yellow, 5, "");
        _mint(msg.sender, Green, 5, "");
        _mint(msg.sender, Blue, 5, "");
        _mint(msg.sender, Purple, 5, "");
    }

    function uri(uint tokenId) public override view returns(string memory) {
        return string(abi.encodePacked(baseUri,"/", Strings.toString(tokenId), ".json"));
    }

    function mintToken(uint _id, uint _amount) public {
        _mint(msg.sender,_id,_amount,"");
    }

    function getBatchAddresses(uint a) public view returns(address[] memory) {
        address[] memory _list = new address[](a);
        for(uint i=0; i<a; i++) {
            _list[i] = msg.sender;
        }
        return _list;
    }

    function getBalanceOfBatch(uint[] memory _tokenIds) public view returns(uint[] memory) {
        return balanceOfBatch(getBatchAddresses(_tokenIds.length), _tokenIds);
    } 
}