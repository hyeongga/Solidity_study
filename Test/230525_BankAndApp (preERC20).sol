// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.2 <0.9.0;


//은행에 입금을 하면 진짜 돈이 빠져나가는 case
contract App{ 
    //통합 application
    //여러사람이 하나의 앱을 사용함

    mapping (address=>uint) balance;  //개인잔액
    // mapping (address=>mapping(address=>uint))bankAccounts;  //은행의 내 잔고
    receive() external payable{} //인출 시 타 은행에서 뽑은 돈을 여기로 보내면 받아야함

    modifier balanceCheck(address _a, uint _amount){
        require(balance[_a] >= _amount);
        _;
    }

    // 입금 - 해당 App에게 얼만큼의 돈을 입금하겠다.
    function depositToApp() public payable {
        balance [msg.sender] += msg.value;
    }
    //입금 : 특정 은행에게 얼마만큼의 돈을 입금하겠다.
    function depositToBank(address payable _bank, uint _amount) public {
        Bank targetBank = Bank(_bank);
        require(balance[msg.sender] >= _amount);
        payable(targetBank).transfer(_amount);
        balance[msg.sender] -= _amount;
        targetBank.Deposit(msg.sender, _amount);
    }

    //송금해준 돈을 받기 위해서 받는 사람이 있는 코드로 바꿔서 작성
    function _depositToBank(address payable _bank,address _to, uint _amount) public {
        Bank targetBank = Bank(_bank);
        require(balance[msg.sender] >= _amount);
        payable(targetBank).transfer(_amount);
        balance[msg.sender] -= _amount;
        targetBank.Deposit(_to, _amount);
    }

    // 인출 - 해당 App에게 얼만큼의 돈을 출금하겠다. //app->user
    function withdrawFromApp(uint _amount) public balanceCheck(msg.sender, _amount) {
        balance[msg.sender] -= _amount;
        payable(msg.sender).transfer(_amount);        
    }

    // 인출 - 특정 은행에서 얼만큼의 돈을 출금하겠다. // bank -> app
    function withdrawFromBank(address payable _bank, uint _amount) public {
        Bank targetBank = Bank(_bank);
        targetBank.Withdraw(msg.sender, _amount);
        balance[msg.sender] += _amount;
    }

    //송금 : A가 B에게 돈을 보내는 것 ;App을 통해서(스마트 컨트랙트를 이용해서 직접보내는 방법은 없음 : A -> App -> B이렇게 감 or web3.js를 사용해야함)
    function transferTo(address _bAccount, uint _amount) public balanceCheck (msg.sender, _amount){
        balance[msg.sender] -= _amount;
        balance[_bAccount] += _amount;
    }

    //은행송금 : A의 은행에서 B의 은행 계좌에게 돈을 보내는 것(은행끼리)
     function transferWire(address payable _aBank, address _bAccount, address payable _bBank, uint _amount) public {
        withdrawFromBank(_aBank, _amount);
        _depositToBank(_bBank, _bAccount, _amount);
    }

}


contract Bank{
    
    mapping(address=>uint) private balance;  //은행 고객의 잔고
    receive () external payable{} // 타 은행에서 보냈을때 받을 수 있도록 하기 위해서

    //잔고확인 (자신만 조회 가능하도록)
    function balanceOf(address _account) public view returns(uint){
        require(_account == msg.sender);
        return balance[_account];
    }
    /*function balanceOf() public view returns(uint){
        return balance[msg.sender];
    }*/


    //입금 : 이 은행의 나의 계좌에 msg.value만큼 돈을 입금하겠다. (public ver.)
    function deposit() public payable {
        balance[msg.sender]+= msg.value;
    }

    //입금 (interal ver.) ; internal은 payable이 안됨 
    function _deposit(address _account, uint _amount) internal {
        balance[_account] += _amount;
    }

    function Deposit(address _account, uint _amount) public {
        require(_amount != 0, "Amount should not be zero.");
        _deposit(_account, _amount);
    }


    //인출 : 특정 은행에서 amount만큼 돈을 출금하겠다.(public ver.)
    function withdraw(uint _amount) public {
        balance[msg.sender]-= _amount;
        payable(msg.sender).transfer(_amount);
    }

    //인출 : 특정 은행에서 amount만큼 돈을 출금하겠다.(internal ver.)
    function _withdraw(address _account, uint _amount) internal {
        balance[_account] -= _amount;
        payable(msg.sender).transfer(_amount); //App한테 넣는경우 (중간 다리를 거침)
    }

    function Withdraw(address _account, uint _amount) public {
        require(balance[_account] >= _amount);
        _withdraw(_account, _amount);
    }

    function _withdraw2(address _account, uint _amount) internal {
        balance[_account] -= _amount;
        payable(_account).transfer(_amount); // 개인지갑으로 바로 넣을 경우
    }

    // A : 보내는 사람 => B : 받는사람
    //송금 : A가 B에게 돈을 보내는 것(동행)
    function transferTo(address _bAccount, uint _amount) public {
        balance[msg.sender]-= _amount;
        balance[_bAccount]+= _amount;
    }

    //은행송금 : A가 B의 다른 은행에게 돈을 보내는 것(타행)
    function transterWire(address _bAccount, address payable _bBank, uint _amount) public {
        Bank B = Bank (_bBank);
        balance[msg.sender] -= _amount;
        payable (B).transfer( _amount);
        B.Deposit(_bAccount, _amount);
    }
    /*    Alice가 B1 뱅크에 있는 돈을 Bob의 B2 뱅크 계좌로 넣고 싶은 상황에서
        Alice 가 transferWire 실행 transferWire에서 B1 뱅크 deposit 실행    */

}

