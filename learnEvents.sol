// SPDX-License-Identifier: MIT
pragma solidity 0.8.22;

contract LearnEvents {
    // 1. declare the event 
    // 2. we want to emit the event
    event NewTrade(
        uint indexed date, // allows the consumer to find / filter events. This costs moe gas and you can use only 3 indexes per event.
        address from,
        address indexed to,
        uint indexed amount
    );

    function trade(address to, uint amount) public {
        // outside consumer can see the event through web3.js
        // 
        emit NewTrade(
            block.timestamp,
            msg.sender,
            to,
            amount
        );
    }
}