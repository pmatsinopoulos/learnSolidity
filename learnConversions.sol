// SPDX-License-Identifier: MIT
pragma solidity 0.8.22;

// Importance to make smart contracts that are cost efficient

contract LearnConversions {
    bytes2 e = 0x1234;
    bytes1 f = bytes1(e); // 0x12
    bytes2 g = 0x1234;
    bytes4 h = bytes4(g); // 0x12 34 00 00

    function getE() public view returns (bytes2) {
        return e;
    }

    function getF() public view returns (bytes1) {
        return f;
    }

    function getH() public view returns (bytes4) {
        return h;
    }
}