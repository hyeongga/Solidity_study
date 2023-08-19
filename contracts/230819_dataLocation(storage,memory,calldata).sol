// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.2 <0.9.0;

contract DataLocations {
    // Data locations of state variables are storage
    struct MyStruct {
        uint num;
        string text;
    }
    mapping(address => MyStruct) public myStructs;
  
    //myStruct값을 받아서 storage에 저장할 경우 상태변수의 값이 변경됨
    function setStorage(address _addr, string calldata _text) external {
        MyStruct storage myStruct = myStructs[_addr];
        myStruct.text = _text;
    }
	//memory에서 값을 변경할 경우, 상태변수로 저장된 myStructs에 영향을 주지 않음
    function setMemory(address _addr, string calldata _text) external view {
        MyStruct memory myStruct = myStructs[_addr];
        myStruct.text = _text;
    }

    string public a;
  	//_text값을 상태변수 a에 저장
    function storageA (string calldata _text) external {
            a = _text;
    }
	//_text값 memory값에 저장 ; 상태변수 a값은 변경되지 않음
    function memory1 (string calldata _text) external pure {
        string memory a = _text;
        // _text = "impossible";	//calldata로 받아와서 변경 불가
    }
	//_text값 변경 후, 상태변수 a에 저장
    function memory2 (string memory _text) external {
        _text = "possible";
        a = _text;
    }
}