// SPDX-License-Identifier: MIT
// OpenZeppelin Contracts (last updated v4.9.0) (token/ERC721/ERC721.sol)

pragma solidity ^0.8.19;

import {IERC721} from "./IERC721.sol";
import {IERC721Receiver} from "./IERC721Receiver.sol";
import {IERC721Metadata} from "./extensions/IERC721Metadata.sol";
import {Context} from "../../utils/Context.sol";
import {Strings} from "../../utils/Strings.sol";
import {IERC165, ERC165} from "../../utils/introspection/ERC165.sol";
import {IERC721Errors} from "../../interfaces/draft-IERC6093.sol";

abstract contract ERC721 is Context, ERC165, IERC721, IERC721Metadata, IERC721Errors {
    using Strings for uint256;

    // Token name
    string private _name;

    // Token symbol
    string private _symbol;

    // Mapping from token ID to owner address ;nft라서 식별 필요
    mapping(uint256 => address) private _owners;

    // Mapping owner address to token count
    mapping(address => uint256) private _balances;

    // Mapping from token ID to approved address  ; 누구에게 허가권이 있는지
    mapping(uint256 => address) private _tokenApprovals;

    // Mapping from owner to operator approvals
     //토큰마다 다르기 때문에 erc20에서 allowance값을 준게 여기서는 의미없음
    mapping(address => mapping(address => bool)) private _operatorApprovals;

    constructor(string memory name_, string memory symbol_) {
        _name = name_;
        _symbol = symbol_;
    }

    function supportsInterface(bytes4 interfaceId) public view virtual override(ERC165, IERC165) returns (bool) {
        return
            interfaceId == type(IERC721).interfaceId ||
            interfaceId == type(IERC721Metadata).interfaceId ||
            super.supportsInterface(interfaceId); //super ; 상속해준 부모로부터 옴
    }

    //해당 주소의 소유하고 있는 nft 갯수
    function balanceOf(address owner) public view virtual returns (uint256) {
        if (owner == address(0)) {
            revert ERC721InvalidOwner(address(0));
        }
        return _balances[owner];
    }

    //해당 tokenId의 소유자 주소 반환
    function ownerOf(uint256 tokenId) public view virtual returns (address) {
        address owner = _ownerOf(tokenId);
        if (owner == address(0)) {
            revert ERC721NonexistentToken(tokenId);
        }
        return owner;
    }

    function name() public view virtual returns (string memory) {
        return _name;
    }

    function symbol() public view virtual returns (string memory) {
        return _symbol;
    }

    // token에 대한 metadata를 포함한 UIR 반환
    function tokenURI(uint256 tokenId) public view virtual returns (string memory) {
        _requireMinted(tokenId);//이미 민팅이 되어있는지 물어봄

        string memory baseURI = _baseURI();
        return bytes(baseURI).length > 0 ? string.concat(baseURI, tokenId.toString()) : "";
        //baseURI가 존재하며 합쳐서 보내고 없으면 공백으로 출력
    }

    function _baseURI() internal view virtual returns (string memory) {
        return "";
    }

    //지갑 주인이 to에게 tokenid 권한을 준다.
    //내 자산을 특정 조건이되면 사용할 수 있도록 권한 부여 (approve함수는 본인이거나, 본인에게 모든 tokenId 권한을 넘겨받아야만 사용가능)
    function approve(address to, uint256 tokenId) public virtual {
        address owner = ownerOf(tokenId);
        //권한을 받을 자격이 있는지 확인
        if (to == owner) {
            revert ERC721InvalidOperator(owner);  //권한을 주는 사람과 받는 사람은 일치하면 안됨
        }
        //isApprovedForAll은 특정 nft보유한 사람에게 operator에게 사용권한을 전부 넘겼는지 안넘겼는지 반환
        //토큰 아이디에 대한 권한을 전부 넘겨 받지 않으면 사용 불가
        if (_msgSender() != owner && !isApprovedForAll(owner, _msgSender())) {
            revert ERC721InvalidApprover(_msgSender());
        }
        // isApprovedForAll : mapping값으로 bool형태 출력 ; 지갑 주인이 특정 컨트랙트에게 자신이 가지고 있는 모든 nft권한을 모두 허락함
        // isApprovedForAll이 true이면, NFT에 대한 권한을 가지게 됨
        _approve(to, tokenId);
    }

    function _approve(address to, uint256 tokenId) internal virtual {
        _tokenApprovals[tokenId] = to;
        emit Approval(ownerOf(tokenId), to, tokenId);
    }

    //토큰 아이디를 허락받은 주소 반환 ;  token id에 해당하는 지갑주소를 반환해줌
    function getApproved(uint256 tokenId) public view virtual returns (address) {
        _requireMinted(tokenId);

        return _tokenApprovals[tokenId];
    }

    //민팅된 tokenId인지 확인
    function _requireMinted(uint256 tokenId) internal view virtual {
        if (!_exists(tokenId)) {
            revert ERC721NonexistentToken(tokenId);
        }
    }
    
    //해당 토큰의 소유자가 존재하는지 확인
    function _exists(uint256 tokenId) internal view virtual returns (bool) {
        return _ownerOf(tokenId) != address(0);
    }
    
    function _ownerOf(uint256 tokenId) internal view virtual returns (address) {
        return _owners[tokenId];
    }
    
    //nft를 보유한 사람의 모든 권한을 넘겨주거나 회수하는 함수 (owner나, operator위임할CA, approved승락/거절)
    function setApprovalForAll(address operator, bool approved) public virtual {
        _setApprovalForAll(_msgSender(), operator, approved);
    }

    //토큰 오너가 누름 ; 권한을 주고 뺏는 기능
    function _setApprovalForAll(address owner, address operator, bool approved) internal virtual {
        if (owner == operator) {
            revert ERC721InvalidOperator(owner);
        }
        _operatorApprovals[owner][operator] = approved; //owner나, operator는 권한을 부여받는 CA
        emit ApprovalForAll(owner, operator, approved);
    }

    //허가를 해줬는지 여부확인
    function isApprovedForAll(address owner, address operator) public view virtual returns (bool) {
        return _operatorApprovals[owner][operator];
    }

    // from이 to에게 tokenId를 넘겨준다.    
    function transferFrom(address from, address to, uint256 tokenId) public virtual {
        if (!_isApprovedOrOwner(_msgSender(), tokenId)) {
            revert ERC721InsufficientApproval(_msgSender(), tokenId);
        }

        _transfer(from, to, tokenId);
    }

    function _isApprovedOrOwner(address spender, uint256 tokenId) internal view virtual returns (bool) {
        address owner = ownerOf(tokenId);
        return (spender == owner || isApprovedForAll(owner, spender) || getApproved(tokenId) == spender);
    }

    function _transfer(address from, address to, uint256 tokenId) internal virtual {
        address owner = ownerOf(tokenId);
        //주인이 보내는 사람과 일치하는지 확인
        if (owner != from) {
            revert ERC721IncorrectOwner(from, tokenId, owner);
        }
        //받는사람이 존재하는지 확인
        if (to == address(0)) {
            revert ERC721InvalidReceiver(address(0));
        }
        
        _beforeTokenTransfer(from, to, tokenId, 1);

        // Check that tokenId was not transferred by `_beforeTokenTransfer` hook
        owner = ownerOf(tokenId);
        if (owner != from) {
            revert ERC721IncorrectOwner(from, tokenId, owner);
        }

        // Clear approvals from the previous owner ; 다른 사람에게 허락했던 권한 모두 초기화
        delete _tokenApprovals[tokenId];  //tokenId의 기존 approve된 관계를 모두 삭제

        // Decrease balance with checked arithmetic, because an `ownerOf` override may
        // invalidate the assumption that `_balances[from] >= 1`.
        _balances[from] -= 1; // 기존 주인의 잔고에서 빼주기

        unchecked {
            // `_balances[to]` could overflow in the conditions described in `_mint`. That would require
            // all 2**256 token ids to be minted, which in practice is impossible.
            _balances[to] += 1; // 새로운 주인 잔고에 추가
        }

        _owners[tokenId] = to; // tokenId 소유권 to로 변경

        emit Transfer(from, to, tokenId);

        _afterTokenTransfer(from, to, tokenId, 1);
    }

    function safeTransferFrom(address from, address to, uint256 tokenId) public virtual {
        safeTransferFrom(from, to, tokenId, "");
    }

    function safeTransferFrom(address from, address to, uint256 tokenId, bytes memory data) public virtual {
        if (!_isApprovedOrOwner(_msgSender(), tokenId)) {
            revert ERC721InsufficientApproval(_msgSender(), tokenId);
        }
        _safeTransfer(from, to, tokenId, data);//safeTransferFrom과 차이는 data인자
    }

    function _safeTransfer(address from, address to, uint256 tokenId, bytes memory data) internal virtual {
        _transfer(from, to, tokenId);
        //safeTransferFrom이 transferFrom과 다른 부분!
        if (!_checkOnERC721Received(from, to, tokenId, data)) {
            revert ERC721InvalidReceiver(to);
        }
            /* _checkOnERC721Received ; IERC721receiver에 나와있음     
            IECR721.~.selector => methodid를 말함
            토큰을 받는 아이가 어떤 아이인지를 한번 확인하기 때문에 safeTransfer이 됨(Transfer과의 차이)
            컨트랙트주소가 없거나 있어도 사용할 수 없는 아이일경우의 사고를 방지하기 위함
            */
    }

    function _safeMint(address to, uint256 tokenId) internal virtual {
        _safeMint(to, tokenId, "");
    }

    function _safeMint(address to, uint256 tokenId, bytes memory data) internal virtual {
        _mint(to, tokenId);
        if (!_checkOnERC721Received(address(0), to, tokenId, data)) {
            revert ERC721InvalidReceiver(to);
        }
    }

    //토큰아이디 발행
    function _mint(address to, uint256 tokenId) internal virtual {
        if (to == address(0)) {
            revert ERC721InvalidReceiver(address(0));
        }
        if (_exists(tokenId)) {
            revert ERC721InvalidSender(address(0));
        }

        _beforeTokenTransfer(address(0), to, tokenId, 1);

        // Check that tokenId was not minted by `_beforeTokenTransfer` hook
        if (_exists(tokenId)) {
            revert ERC721InvalidSender(address(0));
        }

        unchecked {
            // Will not overflow unless all 2**256 token ids are minted to the same owner.
            // Given that tokens are minted one by one, it is impossible in practice that
            // this ever happens. Might change if we allow batch minting.
            // The ERC fails to describe this case.
            _balances[to] += 1;
        }

        _owners[tokenId] = to;

        emit Transfer(address(0), to, tokenId);

        _afterTokenTransfer(address(0), to, tokenId, 1);
    }

     //특정 토큰을 없앰
    function _burn(uint256 tokenId) internal virtual {
        address owner = ownerOf(tokenId);

        _beforeTokenTransfer(owner, address(0), tokenId, 1);

        // Update ownership in case tokenId was transferred by `_beforeTokenTransfer` hook
        owner = ownerOf(tokenId);

        // Clear approvals; 허가 받은 사람을 지움
        delete _tokenApprovals[tokenId];

        // Decrease balance with checked arithmetic, because an `ownerOf` override may
        // invalidate the assumption that `_balances[from] >= 1`.
        _balances[owner] -= 1;

        delete _owners[tokenId]; //해당 nft의 주인을 없애버림

        emit Transfer(owner, address(0), tokenId);

        _afterTokenTransfer(owner, address(0), tokenId, 1);
    }//주인이 0x000000000..00이 되어버림
    // 이렇게 삭제 되어버리면 nftlist로도 못 들고 오기 때문에 따로 DB를 만들어서 관리해줘야함

    function _checkOnERC721Received(
        address from,
        address to,
        uint256 tokenId,
        bytes memory data
    ) private returns (bool) {
        //받는 사람이 CA인지 EOA인지 판별
        if (to.code.length > 0) {//CA인 경우 함수가 잘 구현이 되어있는지 확인
            try IERC721Receiver(to).onERC721Received(_msgSender(), from, tokenId, data) returns (bytes4 retval) {
                return retval == IERC721Receiver.onERC721Received.selector;
            } catch (bytes memory reason) { // 함수가 잘 구현되어 있지 않은 이유를 각각 반환함
                if (reason.length == 0) {
                    revert ERC721InvalidReceiver(to);
                } else {
                    /// @solidity memory-safe-assembly
                    assembly {
                        revert(add(32, reason), mload(reason))
                    }
                }
            }
        } else {//EOA인 경우
            return true;
        }
    }

    function _beforeTokenTransfer(address from, address to, uint256 firstTokenId, uint256 batchSize) internal virtual {}

    function _afterTokenTransfer(address from, address to, uint256 firstTokenId, uint256 batchSize) internal virtual {}

    // solhint-disable-next-line func-name-mixedcase
    function __unsafe_increaseBalance(address account, uint256 value) internal {
        _balances[account] += value;
    }
}