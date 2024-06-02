// SPDX-License-Identifier: MIT
pragma solidity 0.8.22;

contract EnumsLearn {
    enum frenchFriesSize {
        LARGE,
        MEDIUM,
        SMALL
    }

    frenchFriesSize choice;

    frenchFriesSize constant defaultChoice = frenchFriesSize.MEDIUM;

    function setSmall() public {
        choice = frenchFriesSize.SMALL;
    }

    function getChoice() public view returns(frenchFriesSize) {
        return choice;
    }

    function getDefaultChoice() public pure returns(frenchFriesSize) {
        return defaultChoice;
    }
}

contract EnumsLearn2 {
    enum shirtsColor {
        RED,
        WHITE,
        GREEN,
        BLUE
    }

    shirtsColor constant defaultChoice = shirtsColor.BLUE;
    shirtsColor choice;

    function setWhite() public {
        choice = shirtsColor.WHITE;
    }

    function getChoice() public view returns(shirtsColor) {
        return choice;
    }

    function getDefaultChoice() public pure returns(shirtsColor) {
        return defaultChoice;
    }
}