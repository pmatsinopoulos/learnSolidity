// SPDX-License-Identifier: MIT
pragma solidity 0.8.22;

contract Counter {
    uint public count;

    function increment() external {
        count += 1;
    }
}

// how do we interact with this contract without copy and pasting the code?
// 

interface ICounter {
    function increment() external;
    function count() external view returns(uint);
}

contract MyContract {
    function incrementCounter(address _counter) external {
        ICounter(_counter).increment();
    }

    function getCount(address _counter) external view returns(uint) {
        return ICounter(_counter).count();
    }
}
