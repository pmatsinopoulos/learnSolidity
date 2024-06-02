// SPDX-License-Identifier: MIT
pragma solidity 0.8.26;

contract DecisionMaking {

    // uint oranges = 4;

    // function validateOranges() public view returns(bool) {
    //     if (oranges == 5) {
    //         return true;
    //     } else {
    //         return false;
    //     }
    // }



    function airDrop() public pure returns (uint) {
        uint stakingWallet = 10;

        if (stakingWallet == 10) {
            stakingWallet = stakingWallet + 10;
        } else {
            stakingWallet = stakingWallet + 1;
        }
        return stakingWallet;
    }
}
