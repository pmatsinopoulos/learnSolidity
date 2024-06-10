// SPDX-License-Identifier: MIT
pragma solidity 0.8.22;

contract FuckYouAlice {
    string public message;

    constructor() {
        message = "Fuck you Alice!";
    }

    function breakUpMessage() public view returns(string memory) {
        return message;
    }
}
