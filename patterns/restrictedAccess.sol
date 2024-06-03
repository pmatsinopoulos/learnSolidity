// SPDX-License-Identifier: MIT
pragma solidity 0.8.22;

contract RestrictedAccess {

    address public owner = msg.sender;

    uint public creationTime = block.timestamp;

    // How can we restrict who can call this action?
    // We want only the current owner to be able to call this
    // function and pass the owner of the contract to another
    // address

    modifier onlyBy(address _allowedCaller) {
        require(msg.sender == _allowedCaller, "The caller is not allowed to call this action");
        _;
    }

    function changeOwnerAddress(address _newOwner) public onlyBy(owner) {
        owner = _newOwner;
    }
}