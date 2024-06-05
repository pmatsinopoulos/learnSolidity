// SPDX-License-Identifier: MIT
pragma solidity 0.8.22;

contract FirstContract {

}

contract SecondContract is FirstContract {

}

contract A {
    uint innerVal;

    constructor() {
        innerVal = 100;
    }

    function innerAddTen(uint a) public pure returns(uint) { return a + 10; }
}

contract B is A {
    function outerAddTen(uint a) public pure returns(uint) { return innerAddTen(a); }
    function getInnerVal() public view returns(uint) { return innerVal; }
}