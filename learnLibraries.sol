// SPDX-License-Identifier: MIT
pragma solidity 0.8.22;

library Search {
    function indexOf(uint[] storage self, uint value) public view returns(uint) {
        for(uint i = 0; i < self.length; i++) {
            if (self[i] == value) {
                return i;
            }
        }
        return 0;
    }
}

contract Test {
    uint[] data;

    constructor() {
        data = [5, 8, 10, 20, 30, 25, 18];
    }

    function isValuePresent(uint val) external view returns(uint) {
        return Search.indexOf(data, val);
    }
}

library Search2 {
    function indexOf(uint[] storage self, uint value) public view returns(uint) {
        for(uint i = 0; i < self.length; i++) {
            if (self[i] == value) {
                return i;
            }
        }
        return 0;
    }
}

contract Test2 {
    using Search2 for uint[];

    uint[] data;

    constructor() {
        data = [5, 8, 10, 20, 30, 25, 18];
    }

    function isValuePresent(uint val) external view returns(uint) {
        return data.indexOf(val);
    }
}

