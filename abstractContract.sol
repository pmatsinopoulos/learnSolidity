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