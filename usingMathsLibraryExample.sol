// SPDX-License-Identifier: MIT
pragma solidity 0.8.22;

import "./mathsLibraryExample.sol";

contract ExampleUsingMathsLibrary {
    using MathsLib for uint;

    function addNumbers(uint a, uint b) public pure returns(uint) {
        return a.add(b);
    }

    function subtractNumbers(uint a, uint b) public pure returns(uint) {
        return a.subtract(b);
    }
}
