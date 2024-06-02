// SPDX-License-Identifier: MIT
pragma solidity 0.8.22;

contract FallBack {
    event Log(uint gas); // type definition?

    fallback() external payable {
        // not recommended much code here. Because the function will fail if it uses too much gas.
        
        // When we invoke +send+ and +transfer+ we get 2300 gas which is enough to emit a log.

        // When we invoke the +call+ method we get all the gas.

        emit Log(gasleft());
    }

    function getBalance() public view returns(uint) {
        // return the stored balance of the contract.
        return address(this).balance;
    }
}

interface IMyContract {
    function getBalance() external view returns (uint);
}

// new contract will send ether to Fallback contract which will trigger fallback functions

contract SendToFallback {
    function transferToFallback(address payable _to) public payable {
        // send ether with the +transfer+ method
        // automatically transfer will transfer 2300 gas amount
        _to.transfer(msg.value);
    }

    function callFallBack(address payable _to) public payable {
        // send ether with the +call+ method
        (bool sent, ) = _to.call{value: msg.value}('');

        require(sent, "Failed to send");
    }

    function callFunctionToOtherContract(address fallBackContractAddress) public view returns (uint) {
        return IMyContract(fallBackContractAddress).getBalance();
    }
}