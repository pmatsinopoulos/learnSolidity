// SPDX-License-Identifier: MIT
pragma solidity 0.8.22;

// Requirements:
//
// - We want only the creator to create coins.
// - Anyone can send coins to each other without a need for registering with a username and password.
//   All we need is an Ethereum keypair.
// 
contract Coin {
    address public minter; // it is the person who mints 
    mapping(address => uint) public balances; // these are wallets with coins

    event Sent(address from, address to, uint amount);

    error insufficientBalance(uint requested, uint available);

    // constructor only runs when we deploy the contact.
    constructor() {
        minter = msg.sender;
    }

    function mint(uint amount) public {
        require(msg.sender == minter);

        balances[minter] += amount;
    }

    // send any amount of coins to an existing address
    function send(address receiver, uint amount) public {
        if (amount > balances[msg.sender]) {
            revert insufficientBalance({
                requested: amount,
                available: balances[msg.sender]
            });
        }

        balances[msg.sender] -= amount;
        balances[receiver] += amount;
        emit Sent(msg.sender, receiver, amount); // this creates a log entry in the block.
    }
}