// SPDX-License-Identifier: MIT
pragma solidity 0.8.22;

contract LearnAssembly {
    function addToEVM() external {
        uint x;
        uint y;
        uint z = x + y;

        assembly {


            let f := add(x, y)

           // load data for a specific slot

           let a := mload(0x40)

           // store something temporarily to memory
           mstore(a, 4)

           // persistance storage!
           let b := 0
           sstore(b, 100)



        }
    }

    function checkWhetherItIsContract(address addr) public view returns(bool) {
        uint size;

        assembly {
            // check whether an address contains any byte code or not
            size := extcodesize(addr)
        }

        if (size > 0) {
            return true;
        } else {
            return false;
        }
    }
}