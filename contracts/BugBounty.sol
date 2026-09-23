// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract BugBounty {

    enum Status {
        Open,
        Submitted,
        Resolved
    }

    struct Bounty {
        uint256 id;
        string title;
        string description;
        uint256 reward;
        address payable organization;
        address researcher;
        string reportHash;
        Status status;
    }

    uint256 public bountyCount;

    mapping(uint256 => Bounty) public bounties;

    event BountyCreated(
        uint256 indexed bountyId,
        address indexed organization,
        uint256 reward
    );

    event ReportSubmitted(
        uint256 indexed bountyId,
        address indexed researcher,
        string reportHash
    );

    event BountyResolved(
        uint256 indexed bountyId,
        address indexed researcher,
        bool accepted
    );

    function createBounty(
        string memory _title,
        string memory _description
    ) public payable {

        require(msg.value > 0, "Reward must be greater than zero");

        bounties[bountyCount] = Bounty({
            id: bountyCount,
            title: _title,
            description: _description,
            reward: msg.value,
            organization: payable(msg.sender),
            researcher: address(0),
            reportHash: "",
            status: Status.Open
        });

        emit BountyCreated(
            bountyCount,
            msg.sender,
            msg.value
        );

        bountyCount++;
    }

    function submitReport(
        uint256 _bountyId,
        string memory _reportHash
    ) public {

        Bounty storage bounty = bounties[_bountyId];

        require(
            bounty.status == Status.Open,
            "Bounty is not open"
        );

        require(
            msg.sender != bounty.organization,
            "Organization cannot submit report"
        );

        bounty.researcher = msg.sender;
        bounty.reportHash = _reportHash;
        bounty.status = Status.Submitted;

        emit ReportSubmitted(
            _bountyId,
            msg.sender,
            _reportHash
        );
    }

    function resolveBounty(
        uint256 _bountyId,
        bool _accepted
    ) public {

        Bounty storage bounty = bounties[_bountyId];

        require(
            msg.sender == bounty.organization,
            "Only organization can resolve"
        );

        require(
            bounty.status == Status.Submitted,
            "No report submitted"
        );

        bounty.status = Status.Resolved;

        if (_accepted) {
            payable(bounty.researcher).transfer(bounty.reward);
        }

        emit BountyResolved(
            _bountyId,
            bounty.researcher,
            _accepted
        );
    }

    function getBounty(
        uint256 _bountyId
    ) public view returns (
        uint256,
        string memory,
        string memory,
        uint256,
        address,
        address,
        string memory,
        Status
    ) {
        Bounty memory bounty = bounties[_bountyId];

        return (
            bounty.id,
            bounty.title,
            bounty.description,
            bounty.reward,
            bounty.organization,
            bounty.researcher,
            bounty.reportHash,
            bounty.status
        );
    }
}
