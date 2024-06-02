// SPDX-License-Identifier: MIT
pragma solidity 0.8.22;

contract C {
    uint internal data = 10; // state variable

    // Function that reads from state or environment needs to be "view"
    // 
    // "external" can only be called from the outside.
    //
    // "internal" is more like "protected" in Java or Ruby.
    // It is available inside the contract and inside contracts that inherit
    // from this contract.
    //
    //
    function x() external view returns(uint) {
        uint xx = data;
        xx = 25;
        return xx;
    }

    function y() public view returns(uint) {
        return data;
    }
}