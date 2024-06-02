// SPDX-License-Identifier: MIT
pragma solidity 0.8.22;

// Oracle dynamic feeds. Are database that are feeding real reliable information.
// We want to get information from Oracle more and less from the blockchain miners,
// in order to make our GenerateRandomNumber generator more fair and reliable, less
// susceptible to external interference, such as the blockchain miners.

contract Oracle {
    address admin;
    uint public rand;

    constructor() {
        admin = msg.sender;
    }

    modifier isOwner {
        require (msg.sender == admin);
        _;
    }
    
    function setRand(uint _value) public isOwner {
        rand = _value;
    }
}

contract GenerateRandomNumber {

    Oracle oracle;

    // modulo so by computing against the remainder we can produce a random number within a range
    //
    // cryptographic hashing
    //

    // build a random number generator which takes an input range and uses cryptographic functions

    constructor(address _oracle) {
        oracle = Oracle(_oracle);
    }

    function ranMod(uint range) external view returns(uint) {
        // grab information from the blockchain randomly to generate random numbers - we need something 
        // dynamically changing
        // +abi.encodePacked()+ concatenates arguments nicely
        return uint(keccak256(abi.encodePacked(block.timestamp, block.prevrandao, msg.sender, oracle.rand))) % range;
    }
}

