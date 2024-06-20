// SPDX-License-Identifier: UNKNOWN
pragma solidity 0.8.24;

contract SimpleStorage {
  uint256 storedData;

  function set(uint256 _value) public {
    storedData = _value;
  }

  function get() public view returns(uint256) {
    return storedData;
  }
}
