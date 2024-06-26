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

    // We want this to be executed only afte specific period of time.
    // For example, 3 weeks or more.

    modifier onlyAfter(uint _time) {
        require(block.timestamp >= _time, "function is called too early!");
        _;
    }

    function disown() public onlyBy(owner) onlyAfter(creationTime + 10 seconds) {
        delete owner;
    }

    modifier costs(uint cost) {
        require(msg.value >= cost, "Not enough Ether provided.");
        _;
    }

    function forceOwnerChange(address _newOwner) public payable costs(10 wei) {
        owner = _newOwner;
    }

}