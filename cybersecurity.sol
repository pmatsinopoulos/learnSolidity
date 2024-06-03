// SPDX-License-Identifier: MIT
pragma solidity 0.8.22;


contract Victim {
    function isItAContract() public view returns (bool) {
        // if there bytes of code greater than zero then it is a contract!
        uint32 size;
        address a = msg.sender;

        assembly {
            size := extcodesize(a)
        }
        return(size > 0);
    }
}

contract Attacker {
    bool public trickedYou;
    Victim victim;

    constructor(address _v) {
        victim = Victim(_v);
        trickedYou = victim.isItAContract();
    }

    function callVictim() public {
        trickedYou = victim.isItAContract();
    }
}
