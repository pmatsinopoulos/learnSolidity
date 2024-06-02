// SPDX-License-Identifier: MIT
pragma solidity 0.8.22;

// +is+ this inherits from another contract

contract Owner {
    // function modifiers
    address owner;

    // when we deploy, we want to set +owner+ to the calling account address, i.e. to the +msg.sender+.
    constructor() {
        owner = msg.sender;
    }

    modifier onlyOwner {
        // customizable logic to modify our function
        require(msg.sender == owner);
        _;
    }

    modifier costs(uint _price) {
        require(msg.value >= _price); // the message value given by the sender is greater than or equal to price.
                                      // +msg.value+ is in wei.
        _;
    }
}

contract Register is Owner {
    mapping(address => bool) registeredAddresses;

    uint price = 0;

    constructor(uint initialPrice) {
        price = initialPrice;
    } 

    function register() public payable costs(price) {
        registeredAddresses[msg.sender] = true;
    }

    // onlyOwner is our function modifier. We have to create it.
    function changePrice(uint _price) public onlyOwner {
        price = _price;
    }

    function getPice() public view returns (uint) {
        return price;
    }
}

