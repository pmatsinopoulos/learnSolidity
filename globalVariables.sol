// SPDX-License-Identifier: MIT
pragma solidity 0.8.22;

contract LedgerBalance {
    mapping(address => uint) balance;

    function updateBalance(uint newBalance) public {
        balance[msg.sender] = newBalance;
    }
}

contract Updated {
    function updateBalance() public {
        LedgerBalance ledgerBalance = new LedgerBalance();

        ledgerBalance.updateBalance(30);
    }
}

contract SimpleStorage {
    uint storedData;

    function set(uint x) public {
        // storedData = x;
        // storedData = block.difficulty;
        // storedData = block.timestamp;
        storedData = block.number;
    }

    function get() public view returns(uint) {
        return storedData;
    }
}