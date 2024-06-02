// SPDX-License-Identifier: MIT
pragma solidity 0.8.22;

contract Operators {
    // "pure" because it does not change neither read the state
    // or the environment.
    // 
    function calculator() public pure returns (uint) {
        uint a = 7;
        uint b = 5;
        uint result = a % b;
        return result;
    }

    
}

contract FinalExerciseOnOperators {
    uint a = 300;
    uint b = 12;
    uint f = 47;

    // +view+ means it can read the state
    // 
    function finalize() public view returns (uint) {
        uint d = 23;

        uint result = (d *= d - b);

        return result;
    }
}

contract ModuloCalculator {
    uint public c = 10;

    function calculate(uint a, uint b) public returns (uint) {
        c = 15;
        return a % b;
    }
}

