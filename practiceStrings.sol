// SPDX-License-Identifier: MIT
pragma solidity 0.8.22;

contract PracticeStrings {
    string private favoriteColor = "Maroon";

    function getFavoriteColor() public view returns (string memory) {
        return favoriteColor;
    }

    function setFavoriteColor(string memory value) public {
        favoriteColor = value;
    }

    function getNumberOfCharacters() public view returns (uint) {
        bytes memory bytesForFavoriteColor = bytes(favoriteColor);
        return bytesForFavoriteColor.length;
    }
}