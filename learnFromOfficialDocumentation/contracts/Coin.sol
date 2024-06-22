// SPDX-License-Identifier: UNKNOWN
pragma solidity 0.8.26;

contract Coin {
  address public minter;
  mapping(address => uint256) public balances;

  event Sent(address from, address to, uint256 amount);

  error InsufficientBalance(uint256 requested, uint256 available);

  constructor() {
    minter = msg.sender;
  }

  function mint(address receiver, uint256 amount) public {
    require(msg.sender == minter, "Only contract owner can mint");

    balances[receiver] += amount;
  }

  function send(address receiver, uint256 amount) public {
    require(amount <= balances[msg.sender], InsufficientBalance(amount, balances[msg.sender]));

    balances[msg.sender] -= amount;
    balances[receiver] += amount;

    emit Sent(msg.sender, receiver, amount);
  }
}
