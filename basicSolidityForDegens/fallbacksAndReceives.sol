// SPDX-License-Identifier: MIT
pragma solidity 0.8.22;

contract FallbacksAndReceives {
    event FallbackEvent(
        address sender
    );

    event ReceivedEvent(
        uint256 value,
        address sender
    );

    fallback() external { 
        emit FallbackEvent(
            msg.sender
        );    
    }

    receive() external payable {

        emit ReceivedEvent(
            msg.value,
            msg.sender
        );
     }
}
