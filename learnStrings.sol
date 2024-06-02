// SPDX-License-Identifier: MIT
pragma solidity 0.8.22;

contract LearnStrings {
    string greetings = unicode"Καλημέρα!";

    function sayHelo() public view returns(string memory) {
        return greetings;
    }

    function changeGreeting(string memory _change) public {
        greetings = _change;
    }

    function getChar() public view returns(uint) {
        // return greetings.length;
        // we have to convert our string to bytes. Because this is cheaper to work with.
        bytes memory stringToBytes = bytes(greetings);
        return stringToBytes.length; // Note that this is not the actual length, in terms of characters, of the string. Because
                                     // it might be a Unicode character, each character possibly occupying more than one byte.
    }
}
