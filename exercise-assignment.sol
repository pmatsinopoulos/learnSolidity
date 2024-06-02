// SPDX-License-Identifier: MIT
pragma solidity 0.8.26;

contract HelloWorld2 {
    constructor() {

    }

    function getResult() public pure returns (string memory) {
        bool f = true;
        if (f) {
            return "true";
        } else {
            return "false";
        }
    }
}

