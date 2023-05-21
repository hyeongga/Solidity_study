// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.2 <0.9.0;

contract Bytes_Legth{
    //bytes1 => length 1    bytes2 => length2 ... 
    function getLength(bytes1 a) public pure returns(uint){
        return a.length;
    }

    //정적인 bytes를 string(동적)으로 변환 ; abi.encodePacked
    function bytesToString(bytes1 a) public pure returns(string memory){
        string memory _a = string(abi.encodePacked(a));
        return _a;
    }
    // 한글자를 뽑으면 bytes1의 형태로 변환됨
    function onebytes(bytes memory _a)public pure returns(bytes1, bytes1){
        return(_a[0],_a[1]);
    }

    //0x616263 => 61,62,63    
    function bytestoBytesArray(bytes memory _a)public pure returns(bytes1[] memory){
        bytes1[] memory a = new bytes1[](_a.length);
        for (uint i=0;i<_a.length;i++){
            a[i] = _a[i];
        }
        return(a);
    }

    function stringToStiringArray(string memory _str) public pure returns(uint, string[] memory){
        //stringToBytes1Array : abc => 0x61, 0x62, 0x63
        bytes1[] memory bArray = new bytes1[](bytes(_str).length);
        bArray = bytestoBytesArray(bytes (_str));

        //Bytes1Array to string array
        string[] memory sArray = new string[](bArray.length);

        for(uint i=0;i<sArray.length;i++){
            sArray[i] = string(abi.encodePacked((bArray[i])));
        }
        return(sArray.length, sArray);
    }
}

