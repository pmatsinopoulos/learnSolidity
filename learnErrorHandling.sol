// SPDX-License-Identifier: MIT
pragma solidity 0.8.22;

contract LearnErrorHandling {
    bool public sunny = true;
    bool public umbrella = false;
    uint finalCalc = 0;

    function solarCalc() public {
        require(sunny, "It's not sunny so, we ca't do solarCalc");

        finalCalc += 3;
    }

    function weatherChange() public {
        sunny = !sunny;
    }

    function getCalc() public view returns (uint) {
        return finalCalc;
    }

    function bringUmbrella() public {
        if (!sunny) {
            umbrella = true;    
        } else {
          revert("No need to bring umbrella today");
        }
    }
}

contract Vendor {
    address seller;

    modifier onlySeller {
        require(msg.sender == seller, "Only Seller can sell");

        _;
    }

    function becomeSeller() public {
        seller = msg.sender;
    }

    function sell(uint amount /* wei */) public payable onlySeller {
        require(amount <= msg.value, "You can't sell on this price unless you provide the value");


    }
}