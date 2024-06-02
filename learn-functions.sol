// SPDX-License-Identifier: MIT
pragma solidity 0.8.26;

contract learnFunctions {

    function remoteControlOpen(bool closedDoor) public pure returns(bool) {
        return !closedDoor;
    }

    function addValues() public pure returns(uint) {
        uint a = 2;
        uint b = 3;
        uint result = a + b;
        return result;
    }

    function multiplyCalculator(uint a, uint b) public pure returns(uint) {
        uint result = a * b;
        return result;
    }
}