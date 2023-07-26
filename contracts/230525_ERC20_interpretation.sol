// SPDX-License-Identifier: MIT
// OpenZeppelin Contracts (last updated v4.9.0) (token/ERC20/ERC20.sol)

pragma solidity ^0.8.19;

import {IERC20} from "./IERC20.sol";
import {IERC20Metadata} from "./extensions/IERC20Metadata.sol";
import {Context} from "../../utils/Context.sol";
import {IERC20Errors} from "../../interfaces/draft-IERC6093.sol";

abstract contract ERC20 is Context, IERC20, IERC20Metadata, IERC20Errors {
    mapping(address => uint256) private _balances; // 누가 얼마나 가지고 있는지에 대한 정보(해당 주소의 잔고를 저장)

    mapping(address => mapping(address => uint256)) private _allowances;

    uint256 private _totalSupply; // 처음에 지정여부 선택가능

    string private _name;
    string private _symbol;

    error ERC20FailedDecreaseAllowance(address spender, uint256 currentAllowance, uint256 requestedDecrease);

    constructor(string memory name_, string memory symbol_) {
        _name = name_;
        _symbol = symbol_;
    }
    //IERC 상속 받았고 자신도 상속할 수 있도록 virtual, override사용
    function name() public view virtual returns (string memory) {
        return _name;
    }

    function symbol() public view virtual returns (string memory) {
        return _symbol;
    }

    function decimals() public view virtual returns (uint8) {
        return 18;
    }

    function totalSupply() public view virtual returns (uint256) {
        return _totalSupply;
    }

    function balanceOf(address account) public view virtual returns (uint256) {
        return _balances[account]; // mapping
    }

    function transfer(address to, uint256 value) public virtual returns (bool) {
        address owner = _msgSender(); //보내는 사람(버튼을 누르는 사람)을 owner로 설정함
        _transfer(owner, to, value);  //owner가 to에게 amount만큼의 돈을 보냄 
        return true;
    }

    // 실제 돈이 옮겨가는건(mapping의 숫자가 바뀜) transfer함수
    // 나머지는 지갑잔고는 안바뀌지만 권한을 허락한 상태 
	function _transfer(address from, address to, uint256 value) internal {
        // from, to모두 zero address가 아니어야 함
        if (from == address(0)) {
            revert ERC20InvalidSender(address(0));
        }
        if (to == address(0)) {
            revert ERC20InvalidReceiver(address(0));
        }
        _update(from, to, value);
    }

	function _update(address from, address to, uint256 value) internal virtual {
        if (from == address(0)) {
            _totalSupply += value;
        } else {
        	//mapping의 _balances에 key값으로 from을 넣고 value를 fromBalance로 받음
            uint256 fromBalance = _balances[from]; 
            if (fromBalance < value) {
                revert ERC20InsufficientBalance(from, fromBalance, value);
            }
            unchecked {
            	//from의 잔고가 value보다 크면, 거래가 발생하며 송신자의 잔고가 차감됨
                _balances[from] = fromBalance - value;
            }
        }
        if (to == address(0)) {
            unchecked {
                _totalSupply -= value;
            }
        } else {
        	//거래 발생시, 수신자의 잔고가 증가됨
            unchecked {
                _balances[to] += value;
            }
        }
        emit Transfer(from, to, value); //emit은 event 
    }

    // 허락해준 양 (인출 허용량) 더블매핑
    function allowance(address owner, address spender) public view virtual returns (uint256) {
        return _allowances[owner][spender];
    }

    //approve를 실행하면 내가 spender에게 amount만큼 허락해 줄게
    function approve(address spender, uint256 value) public virtual returns (bool) {
        address owner = _msgSender();
        _approve(owner, spender, value);
        return true; //아웃풋값이 없으면 트레킹이 힘드니까 편하게 확인하라고 true설정
    }

    //내가 허락해준 애가 내가 돈을 줘야하는 사람에게 (내)돈을 전달해줌
    function transferFrom(address from, address to, uint256 value) public virtual returns (bool) {
        address spender = _msgSender();
        _spendAllowance(from, spender, value);
        _transfer(from, to, value);
        return true;
    }

    //필요는한데 필수는아님 ; 그래서 erc20을 직접 작성하지 않고 openzeplin 상속받아서(import) 씀 
    //추가로 approve함. allowance양 증가
    function increaseAllowance(address spender, uint256 addedValue) public virtual returns (bool) {
        address owner = _msgSender();
        _approve(owner, spender, allowance(owner, spender) + addedValue);
        return true;
    }

    // allowance한 양을 0으로 만듦
    function decreaseAllowance(address spender, uint256 requestedDecrease) public virtual returns (bool) {
        address owner = _msgSender();
        uint256 currentAllowance = allowance(owner, spender);
        if (currentAllowance < requestedDecrease) {
            revert ERC20FailedDecreaseAllowance(spender, currentAllowance, requestedDecrease);
        }
        unchecked {
            _approve(owner, spender, currentAllowance - requestedDecrease);
        }

        return true;
    }

    //필수요소 아님
    function _mint(address account, uint256 value) internal {
        if (account == address(0)) {
            revert ERC20InvalidReceiver(address(0));
        }
        _update(address(0), account, value);
    }

     //필수요소 아님
    function _burn(address account, uint256 value) internal {
        if (account == address(0)) {
            revert ERC20InvalidSender(address(0));
        }
        _update(account, address(0), value);
    }

    function _approve(address owner, address spender, uint256 value) internal virtual {
        _approve(owner, spender, value, true);
    }

    function _approve(address owner, address spender, uint256 value, bool emitEvent) internal virtual {
        if (owner == address(0)) {
            revert ERC20InvalidApprover(address(0));
        }
        if (spender == address(0)) {
            revert ERC20InvalidSpender(address(0));
        }
        _allowances[owner][spender] = value;
        if (emitEvent) {
            emit Approval(owner, spender, value);
        }
    }

    function _spendAllowance(address owner, address spender, uint256 value) internal virtual {
        uint256 currentAllowance = allowance(owner, spender);
        if (currentAllowance != type(uint256).max) {
            if (currentAllowance < value) {
                revert ERC20InsufficientAllowance(spender, currentAllowance, value);
            }
            unchecked {
                _approve(owner, spender, currentAllowance - value, false);
            }
        }
    }
}