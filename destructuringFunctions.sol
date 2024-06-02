// SPDX-License-Identifier: MIT
pragma solidity 0.8.22;

contract DestructuringFunctions {
    uint public changeValue;
    string public tom = "Hello!";

    function f() public pure returns (uint, bool, string memory) {
        return (3, true, "Foo bar");
    }

    function g() public {
        (changeValue, , tom) = f();
    }

    function getChangeValue() public view returns (uint) {
        return changeValue;
    }



}