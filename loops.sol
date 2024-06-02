// SPDX-License-Identifier: MIT
pragma solidity 0.8.22;

contract LoopContract {
    uint[] public numbersList = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10];

    function checkMultiples(uint _number) public view returns (uint) {
        uint result = 0;
        for (uint i = 0; i < numbersList.length; i++) {
            if (i >= _number && checkMultiples(i, _number)) {
                result++;
            }
        }
        return result;
    }

    // public, pure: it means it can be called and its result can be viewed in the IDE.
    function checkMultiples(uint _num, uint _nums) private pure returns (bool) {
        return (_num % _nums == 0);
    }
}