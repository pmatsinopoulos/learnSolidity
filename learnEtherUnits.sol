// SPDX-License-Identifier: MIT
pragma solidity 0.8.22;

contract LearnEtherUnits {
    function testCurrencies() public pure {
        assert(1000000000000000000 wei == 1 ether); // 10^18 wei = 1 ether
        assert(1 wei == 1); 
        assert(1 ether == 1e18);
        assert(2 ether == 2 * (1000000000000000000 wei));
    }

    function testTime() public pure {
        assert(1 minutes == 60 seconds);
        assert(1 hours == 60 minutes);
        assert(1 days == 24 hours);
        assert(1 weeks == 7 days);
    }
}