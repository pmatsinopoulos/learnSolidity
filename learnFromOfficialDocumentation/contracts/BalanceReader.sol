// SPDX-License-Identifier: MIT
pragma solidity 0.8.26;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract BalanceReader {
  function getTokenBalanceOf(address _account, address _token) external view returns(uint256 _balance) {
    _balance = IERC20(_token).balanceOf(_account);
  }
}
