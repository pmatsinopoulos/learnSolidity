// SPDX-License-Identifier: MIT
pragma solidity 0.8.22;

contract ConstantContract {
    uint256 public constant A_CONSTANT = 1;
}

contract ImmutableContract {
    uint256 public immutable anImmutableValue;

    constructor(uint256 _value) {
        anImmutableValue = _value;
    }
}
