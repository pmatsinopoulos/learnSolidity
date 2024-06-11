// SPDX-License-Identifier: MIT
pragma solidity 0.8.22;

import "@openzeppelin/contracts/utils/math/SafeMath.sol";

contract UseExternalLibrary {
    using SafeMath for uint256;

    address immutable public owner;

    constructor() {
        owner = msg.sender;
    }

    function addNumbers(uint256 a, uint256 b) public pure returns(uint256) {
        return a.add(b);
    }
}
