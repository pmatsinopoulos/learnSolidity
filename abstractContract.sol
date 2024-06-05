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