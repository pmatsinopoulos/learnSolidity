// SPDX-License-Identifier: MIT
pragma solidity 0.8.26;

/* 

You just land your new blockchain job to build smart contracts for an awesome DAO catching fire!

Immediately, your boss throws at your a scrip of code tons of bugs in it. She says, 

'Hey you! Fix this code and get this smart contract running and help save our DApp from crashing!'

The clock is ticking and this is the perfect opportunity to prove your skills and show what you are made of.

Your assignment is to fix the code below full of syntax errors and get this contract successfully deployed on 
the Ethereum network. 

Good luck! 

*/

contract DebugAssignment {
    function remoteControlOpen(bool closedDoor, bool openDoor) public pure returns(bool) { 
        return closedDoor || openDoor;
    }

    function addValues() public pure returns(uint) {
        uint a = 4;
        uint bb = 3;
        uint result = a + bb;
        return result;
    }
   
    function addNewValues() public pure returns (uint) {
        uint a = 88;
        uint bb = 5;
        uint result = a + bb;
        return result;
    }
   
    uint b = 4;
   
    function multiplyCalculatorByFour(uint a) public view returns(uint) {
        uint result = a * b;
        return result;
    }

    function divideCalculatorByFour(uint a) public view returns (uint) {
        uint result = a / b;
        return result;
    }
}