// SPDX-License-Identifier: UNKNOWN
pragma solidity 0.8.26;

/// @title Voting with delegation
contract Ballot {

  struct Voter {
    uint256 weight; // weight is accumulated by delegation. If this is 0, then Voter does not have the right to vote.
    bool voted; // if +true+ that person already voted
    address delegate; // person delegated to. The delegate person who can vote on behalf of the Voter
    uint256 vote; // index of the voted proposal
  }

  struct Proposal {
    bytes32 name; // short name (up to 32 bytes)
    uint256 voteCount; // the number of votes the proposal has acquired
  }

  address public chairperson;

  // the addresses of the Voters
  mapping(address => Voter) public voters;

  // a dynamically sized array of Proposals
  Proposal[] public proposals;

  /// Create a new ballot to choose one of +proposalNames+
  constructor(bytes32[] memory proposalNames) {
    require(proposalNames.length > 0, "The ballot requires at least 1 proposal");

    chairperson = msg.sender;

    voters[chairperson].weight = 1;

    for(uint256 i = 0; i < proposalNames.length; i++) {
      proposals.push(
        Proposal({
          name: proposalNames[i],
          voteCount: 0
        })
      );
    }
  }

  function giveRightToVote(address voter) external {
    require(msg.sender == chairperson, "Only chairperson can give right to vote.");

    require(!voters[voter].voted, "Voter should not have already voted");

    require(voters[voter].weight == 0);

    voters[voter].weight = 1;
  }

  // Sender wishes to delegate its vote to another person
  //
  function delegate(address to) external {
    Voter storage sender = voters[msg.sender]; // +sender+ now is a reference

    require(sender.weight != 0, "You have no right to vote");
    require(!sender.voted, "You have already voted");

    require(to != msg.sender, "Self-delegation is not allowed");

    // Forward the delegation as long as
    // `to` also delegated.
    // In general, such loops are very dangerous,
    // because if they run too long, they might
    // need more gas than is available in a block
    // In this case, the delegation will not be executed,
    // but in other situations, such loops might
    // cause a contract to get "stuck" completely.

    while (voters[to].delegate != address(0)) {
      to = voters[to].delegate;

      require(to != msg.sender, "Found a loop in delegation.");
    }

    Voter storage delegate_ = voters[to]; // +delegate_+ is a reference

    // Voters cannot delegate to accounts that cannot vote.
    require(delegate_.weight >= 1, "Delegatee should be allowed to vote");

    // Since `sender` is a reference, this
    // modifies `voters[msg.sender]`
    sender.voted = true;
    sender.delegate = to;

    if (delegate_.voted) {
      // if the delegate already voted,
      // directly add the number of votes
      proposals[delegate_.vote].voteCount += sender.weight; // the vote of the +sender+ is whateve the +weight+ is
    } else {
      // if the delegate didn't vote yet,
      // add to her weight
      delegate_.weight += sender.weight;
    }
  }

  function vote(uint256 proposal) external {
    Voter storage sender = voters[msg.sender];

    require(!sender.voted, "You should not have already voted");
    require(sender.weight >= 1, "You don't have the right to vote");
    require(proposal < proposals.length, "The proposal index given is out of bounds");

    // flag that I have voted
    sender.voted = true;
    sender.vote = proposal;

    proposals[proposal].voteCount += sender.weight;
  }

  function winningProposal() public view returns (uint256 winningProposal_) {
    uint256 voteCount = 0;

    for (uint256 i = 0; i < proposals.length; i++) {
      if (proposals[i].voteCount > voteCount) {
        winningProposal_ = i;
        voteCount = proposals[i].voteCount;
      }
    }
  }

  function winnerName() public view returns (bytes32 winningName_) {
    uint256 winningProposalIndex = winningProposal();

    winningName_ = proposals[winningProposalIndex].name;
  }
}
