// SPDX-License-Identifier: MIT
pragma solidity 0.8.22;

library MathsLib {
    function add(uint a, uint b) internal pure returns(uint) {
        return a + b;
    } 

    function subtract(uint a, uint b) internal pure returns(uint) {
        return a - b;
    }
}
