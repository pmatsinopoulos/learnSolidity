// SPDX-License-Identifier: MIT
pragma solidity 0.8.22;

contract MyContract {
    uint value;

    function setValue(uint _value) public {
        // eth transaction
        value = _value;
    }

    function getValue() public view returns (uint) {
        // eth call
        return value;
    }

    function duplicateOfThree() public pure returns (uint) {
        return 2 * 3;
    }

    function multiply() public pure returns (uint8) {
        return 3 * 7;
    }

    function valuePlusThree() public view returns (uint) {
        return value + 3;
    }
}
