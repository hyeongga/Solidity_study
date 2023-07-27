// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import "@openzeppelin/contracts/utils/Strings.sol";

//uri하나씩 입력하여 발행할 경우
contract MintNFT is ERC721Enumerable{

    string public baseURI;

    constructor() ERC721("LIKELION", "LL721"){}

    //uri를 전부 input값으로 넣어줌
    function mintNFT(string memory _uri, uint tokenId) public {
        baseURI = _uri; 
        _mint(msg.sender, tokenId);
    }

    function tokenURI() public view returns(string memory) {
        return baseURI;
    }
}

//ipfs에 폴더로 업로드한 경우
contract MintNFT2 is ERC721Enumerable{

    string public metaDataURI;

    constructor(string memory _uri) ERC721("LIKELION2", "LL2721"){
        metaDataURI = _uri;
    }

    function mintNFT(uint tokenId) public {
        _mint(msg.sender, tokenId);
    }

    //tokenId를 통해 여러개 NFT의 uri를 선정
    function tokenURI(uint _tokenId) public override view returns(string memory){
        return string(abi.encodePacked(metaDataURI, '/', Strings.toString(_tokenId), '.json'));
    }
}

/* ipfs json파일
예시 주소 : https://gateway.pinata.cloud/ipfs/QmfH2y9gMzwbig7LFhFMfPUfg4SwchuEM5dxP74avPYWuq
{
	"name" : "",
	"description" : "",
	"image" : "https://ipfs.io/ipfs/CID가지고오기"
}
*/