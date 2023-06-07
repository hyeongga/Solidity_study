// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

//input without name

    /*input값 변수명을 다 적어주지 않아도 상속해서 받아올때 적어주면 사용가능*/
    contract A {
        function getAB(uint _a, uint) public virtual pure returns(uint) {
            /*
            중요한 식
            */
            return _a;
        }
    }

    contract B is A {
        function getAB(uint _a, uint _b) public override pure returns(uint) {
            // _a와 _b의 대소비교
            /*
            중요한 식
            */
            return _b;
        }
    }

//output with name

    /*output에 변수명을 넣어주면 별도로 return을 작성하지 않아도 출력됨*/
    contract C {
        function getAB() public pure returns(uint a, uint b) {
            a = 1;
            b = 2;
        }

        function getString(string memory _a) public pure returns(string memory) {
            string memory _b = "abc";
            string memory c = string.concat(_a, _b);
            return c;
        }

        function getString2(string memory _a) public pure returns(string memory c) {
            string memory _b = "abc";
            c = string.concat(_a, _b);
        }
    }
