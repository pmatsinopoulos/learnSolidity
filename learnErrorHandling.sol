// SPDX-License-Identifier: MIT
pragma solidity 0.8.22;

contract LearnErrorHandling {
    bool public sunny = true;

    uint finalCalc = 0;

    function solarCalc() public {
        require(sunny, "It's not sunny so, we ca't do solarCalc");

        finalCalc += 3;
    }

    function weatherChange(bool nowWeather) public {
        sunny = !nowWeather;
    }
}