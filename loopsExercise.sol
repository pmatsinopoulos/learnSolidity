// SPDX-License-Identifier: MIT
pragma solidity 0.8.22;

contract LoopExercise {
    uint[] private longList = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20];

    uint[] private numbersList = [1, 4, 34, 56];

    function numberExists(uint userNumber) public view returns (bool) {
        for(uint i = 0; i < numbersList.length; i++) {
            if (userNumber == numbersList[i]) {
                return true;
            }
        }
        return false;
    }

    function countEvenNumbers() public view returns (uint) {
        uint result = 0;
        for(uint i = 0; i < longList.length; i++) {
            if (longList[i] % 2 == 0) {
                result++;
            }
        }
        return result;
    }

}