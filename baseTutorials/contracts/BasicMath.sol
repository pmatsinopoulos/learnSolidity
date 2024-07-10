// SPDX-License-Identifier: MIT
pragma solidity 0.8.26;

contract BasicMath {
  function adder(uint _a, uint _b) external pure returns(uint sum, bool error) {
    uint result = 0;
    result = _a + _b;
    return (result, false);
  }
}
