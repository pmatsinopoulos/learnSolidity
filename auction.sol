// SPDX-License-Identifier: MIT
pragma solidity 0.8.22;

/* decentralized audion DApplication which can at the minimum have the following functionality.

Something like the decentralized Ebay

1. You must create a contract called Auction which contains state variables to keep track of the beneficiary
(auctioneer) and the highest bidder, auction and time and the highest bid.

2. There must be events set up which can emit whenever the highest bid changes both address and amount and an
event for the auction ending emitting the winner address and amount.

3. The contract must be deployed set to the beneficiary address and how long the auction will run for.

4. There should be a bid function which includes at the minimum the following:
- revert the call if the bidding period is over.
- if the bid is not higher than the highest bid, send the money back.
- emit the highest bid has increased

5. Bearing in mind the Withdrawal Pattern, there should be a withdrawal function to return bids based on the library of
keys and values.

6. There should be a function which ends the auction and sends the highest bid to the benefficiary

*/

contract Auction {
    address payable auctioneer;
    uint endTime;
    uint startTime;
    bool endOnDemand;

    mapping(address => uint) bidderBids;
    address[] public bidderAddresses; // this is necessary to iterate
    address public highestBidAddress;

    constructor(
        address payable _auctioneer,
        uint _durationInSeconds
    ) {
        auctioneer = _auctioneer;
        startTime = block.timestamp;
        endTime = block.timestamp + _durationInSeconds * 1 seconds;
        highestBidAddress = payable(0x0);
        endOnDemand = false;
    }

    modifier isStillRunning() {
        require(block.timestamp < endTime && !endOnDemand, "Auction should be still running.");
        _;
    }

    modifier isAuctioneer() {
        require(msg.sender == auctioneer, "Transaction initiator should be the auctioneer");
        _;
    }

    modifier isFinished() {
        require(isAuctionFinished(), "Auction should be finished");
        _;
    }

    modifier isAmountPositive() {
        require(msg.value > 0);
        _;
    }

    event HighestBidIncreased(
        uint highestBid,
        address highestBidAddress
    );

    event AuctionEnded(
        uint winningBidAmount,
        address winningBidderAddress
    );

    /*
    This transaction has an incoming msg.value. This is added to the Contract
    balance.
    Also, we add this to the bidder balance in +bidderBids+, so that we know how
    much money this (+msg.sender+) bidder has bid.
    */
    function bid() public payable isStillRunning isAmountPositive {
        // check whether new bid is higher than previous high
        if (msg.value > bidderBids[highestBidAddress]) {
            highestBidAddress = msg.sender;
            emit HighestBidIncreased(msg.value, msg.sender);
        } 

        findOrAddBidderAndSetTheirBid();
    }

    /*
    This will transfer to the auctioneer the highestBid from the
    Contract balance.
    And it will emit the correct events. 
    It is the responsibility of the
    bidders who didn't win the bid, to withdraw their money.
    */
    function payAuctioneer() public isAuctioneer isFinished {    
        if (highestBidAddress != address(0x0)) {
            auctioneer.transfer(bidderBids[highestBidAddress]);
            removeBidder(highestBidAddress);
            emit AuctionEnded(bidderBids[highestBidAddress], highestBidAddress);
        } else {
            emit AuctionEnded(0, address(0x0));
        }
    }

    // this will allow bidders who didn't win to withdraw their bids. Withdrawal pattern
    // This might change the highest bid.
    // 
    function withdraw() public {
        if (isAuctionFinished() && msg.sender == highestBidAddress) {
            revert("You can't withdraw, because auction is finished and you have been the highest bidder");
        }

        uint amountToWithdraw = bidderBids[msg.sender];

        removeTransactionsSenderFromBidding();

        // We transfer money from the balance of the contract.
        payable(msg.sender).transfer(amountToWithdraw);

        findNextHighestBidder();
    }

    function getHighestBidderAndAmount() public view returns (uint, address) {
        return (bidderBids[highestBidAddress], highestBidAddress);
    }

    function getBidderAddresses() public view returns(address[] memory) {
        uint numOfBidAddresses = numberOfBidderAddresses();
        address[] memory result = new address[](numOfBidAddresses);

        uint j = 0;
        for(uint i = 0; i < bidderAddresses.length; i++) {
            if (bidderAddresses[i] != address(0x0)) {
                result[j] = bidderAddresses[i];
                j++;
            }
        }

        return result;
    }

    function getBids() public view returns(uint[] memory) {
        uint numOfBidAddresses = numberOfBidderAddresses();
        uint[] memory result = new uint[](numOfBidAddresses);

        uint j = 0;
        for (uint i = 0; i < bidderAddresses.length; i++) {
            if (bidderAddresses[i] != address(0x0)) {
                result[j] = bidderBids[bidderAddresses[i]];
                j++;
            }
        }

        return result;
    }

    function getContractBalance() public view returns(uint) {
        return address(this).balance;
    }

    function getAuctioneerBalance() public view returns(uint) {
        return auctioneer.balance;
    }

    function endNow() public isAuctioneer {
        endOnDemand = true;
    }

    // -------
    // PRIVATE
    // -------

    function isAuctionFinished() private view returns (bool) {
        return block.timestamp > endTime || endOnDemand;
    }

    function numberOfBidderAddresses() public view returns(uint) {
        uint result = 0;
        for(uint i = 0; i < bidderAddresses.length; i++) {
            if (bidderAddresses[i] != address(0x0)) {
                result++;
            }
        }
        return result;
    }

    function findOrAddBidderAndSetTheirBid() private {
        // Find or Add Bidder. Set its bid
        // -------------------------------
        bool found = false;

        for (uint i = 0; i < bidderAddresses.length && !found; i++) {
            address bidderAddress = bidderAddresses[i];

            if (bidderAddress == msg.sender) {
                bidderBids[bidderAddress] += msg.value;
                found = true;
            }
        }

        if (!found) {
            bidderBids[msg.sender] = msg.value;

            if (bidderAddresses.length > 0) {
                // find the first 0x0 position to set it to the msg.address, or push to the end
                bool foundNonZero = false;
                uint nonZeroPosition = 0;
                for (uint i = bidderAddresses.length - 1; i > 0 && !foundNonZero; i--) {
                    if (bidderAddresses[i] != address(0x0)) {
                        foundNonZero = true;
                        nonZeroPosition = i;
                    }
                }
                if (nonZeroPosition == bidderAddresses.length - 1) {
                    bidderAddresses.push(msg.sender);
                } else {
                    bidderAddresses[nonZeroPosition + 1] = msg.sender;
                }
            } else {
                bidderAddresses.push(msg.sender);
            }
        }
    }

    function removeBidder(address _winner) private {
        delete bidderBids[_winner];

        bool found = false;
        uint position = 0;
        for (uint i = 0; i < bidderAddresses.length && !found; i++) {
            if (bidderAddresses[i] == _winner) {
                found = true;
                position = i;
            }
        }
        
        assert(found);

        bidderAddresses[position] = address(0x0);
    }

    function removeTransactionsSenderFromBidding() private {
        removeBidder(msg.sender);
    }

    function findNextHighestBidder() private {
        if (highestBidAddress == msg.sender) {
            // we need to find the next highestBidAddress
            highestBidAddress = bidderAddresses[0];

            for (uint i = 1; i < bidderAddresses.length; i++) {
               if (bidderBids[bidderAddresses[i]] > bidderBids[highestBidAddress]) {
                   highestBidAddress = bidderAddresses[i];
                }
            }
        }
    }
}