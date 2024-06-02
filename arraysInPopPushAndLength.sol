// SPDX-License-Identifier: MIT
pragma solidity 0.8.22;

contract LearnArrays {
    uint[] myArray;
    uint[] myArray2;
    uint[200] myFixedSizedArray;

    function push(uint number) public {
        myArray.push(number);
    }

    function pop() public {
        myArray.pop();
    }

    function length() public view returns (uint) {
        return myArray.length;
    }

    function remove(uint index) public {
        myArray[index] = myArray[myArray.length - 1];
        myArray.pop();
    }

    function test() public {
        for(uint i = 1; i <= 4; i++) {
            myArray.push(i);
        }

        remove(1);
    }

    function getMyArra() public returns(uint[] me)
}
