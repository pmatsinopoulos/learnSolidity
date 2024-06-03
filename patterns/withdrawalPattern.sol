// SPDX-License-Identifier: MIT
pragma solidity 0.8.22;

// What do we do? The withdrawal pattern.

contract Investing {
    mapping (address => uint) public investments;

    function deposit() public payable {
        require(msg.value > 0, "Deposit a positive amount");

        investments[msg.sender] += msg.value;
    }

    function withdraw(uint amount) public {
        require(investments[msg.sender] >= amount, "Insufficient balance");

        investments[msg.sender] -= amount;

        (bool success, ) = msg.sender.call { value: amount }("");
        require(success, "Transfer failed");
    }

    function getBalance() public view returns(uint) {
        return msg.sender.balance;
    }

    function getBalanceOfContract() public view returns(uint) {
        return address(this).balance;
    }
}

