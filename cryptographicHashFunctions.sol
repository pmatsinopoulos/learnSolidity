// SPDX-License-Identifier: MIT
pragma solidity 0.8.22;

contract GenerateRandomNumber {
    // modulo so by computing against the remainder we can produce a random number within a range
    //
    // cryptographic hashing
    //

    // build a random number generator which takes an input range and uses cryptographic functions

    function ranMod(uint range) external view returns(uint) {
        // grab information from the blockchain randomly to generate random numbers - we need something 
        // dynamically changing
        // +abi.encodePacked()+ concatenates arguments nicely
        return uint(keccak256(abi.encodePacked(block.timestamp, block.prevrandao, msg.sender))) % range;
    }
}