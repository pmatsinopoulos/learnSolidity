// SPDX-License-Identifier: MIT
pragma solidity 0.8.22;

contract PaymentLink {
    address owner;

    event PaymentReceived(
        uint256 amount,
        address sender
    );

    modifier onlyOwner() {
        require(msg.sender == owner, "This can only be called by the owner");
        _;
    }

    receive() external payable { 
        emit PaymentReceived(
            msg.value,
            msg.sender
        );
    }

    constructor(address _owner) {
        owner = _owner;
    }

    function withdraw() public onlyOwner {
        payable(owner).transfer(address(this).balance);
    }
}