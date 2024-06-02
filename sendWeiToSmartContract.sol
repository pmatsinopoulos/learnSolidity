// SPDX-License-Identifier: MIT
pragma solidity 0.8.22;

contract MyWallet {
    event Log(uint gas);

    fallback() external payable { 
        emit Log(gasleft());
    }

    function getBalance() public view returns (uint) {
        return address(this).balance;
    }
}

contract AcceptMoney {
    function acceptMoney(address payable receiver) public payable {
        require(msg.value <= msg.sender.balance);

        receiver.transfer(msg.value);
    }
}