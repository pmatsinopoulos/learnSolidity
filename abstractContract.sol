// SPDX-License-Identifier: MIT
pragma solidity 0.8.22;

abstract contract X {
    function y() virtual public pure returns(string memory);
}

contract Y is X {
    function y() override public pure returns(string memory) {
        return "ehllo";
    }
}

abstract contract Member {
    string name;
    uint age = 38;

    function setName() virtual public pure returns(string memory);

    function returnAge() public view returns(uint) {
        return age;
    }
}

contract Teacher is Member {
    function setName() override public pure returns(string memory) {
        return "hello";
    }
}

abstract contract Calculator {
    function add(uint a, uint b) virtual public pure returns(uint);
}

contract Test is Calculator {
    function add(uint a, uint b) override public pure returns(uint) { return a + b; }
}

contract A {
    function a() virtual public pure returns(uint) {
        return 2;
    }
}

contract B is A {
    function a() override public pure returns(uint) {
        return 5;
    }
}