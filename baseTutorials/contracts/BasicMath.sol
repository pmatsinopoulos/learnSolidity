// SPDX-License-Identifier: MIT
pragma solidity 0.8.26;

contract BasicMath {
  function adder(uint _a, uint _b) external pure returns(uint sum, bool error) {
    uint result = 0;
    unchecked {
      result = _a + _b;
      if (result >= _a) {
        return (result, false);
      }
      return (0, true);
    }
  }

  function subtractor(uint _a, uint _b) external pure returns(uint difference, bool error) {
    uint result = 0;
    unchecked {
      result = _a - _b;
      if (result <= _a) {
        return (result, false);
      }
      return (0, true);
    }
  }
}
