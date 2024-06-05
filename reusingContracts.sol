// SPDX-License-Identifier: MIT
pragma solidity 0.8.22;

contract C {
    uint private data;
    uint public info;

    constructor() {
        info = 10;
    }

    function updateData(uint a) public {
        data = a;
    }

    function getData() public view returns(uint) {
        return data;
    }

    function increment(uint a) private pure returns(uint) {
        return a + 1;
    }

    function compute(uint a, uint b) internal pure returns(uint) {
        return a + b;
    }
}

contract D {
    C public c;

    constructor(address _c) {
        c = C(_c);
    }

    function readInfo() public view returns(uint) {
        return c.info();
    }
}

contract Dd {
    C public c = new C();

    function readInfo() public view returns(uint) {
        return c.info();
    }
}

contract E is C {
    uint private result;

    C private c;

    constructor(address _c) {
        c = C(_c);
    }

    function getComputedResult() public {
        result = compute(23, 5);
    }

    function getResult() public view returns(uint) {
        return result;
    }

    function foo() public view returns(uint) {
        return c.info();
    }
}