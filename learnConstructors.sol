// SPDX-License-Identifier: MIT
pragma solidity 0.8.22;

contract Member {
    string name;
    uint age;

    // initialize name and age upon deployment

    constructor(string memory _name, uint _age) {
        name = _name;
        age = _age;
    }
}

contract Teacher is Member {

    constructor(string memory _name, uint _age) Member(_name, _age) {}

    function getName() public view returns (string memory) {
        return name;
    }
}

contract Base {
    uint data;

    constructor(uint _data) {
        data = _data;
    }

    function getData() public view returns (uint) {
        return data;
    }
}

contract Derived is Base {
    constructor (uint _data) Base(_data) {}


}
