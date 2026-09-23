# Blockchain Bug Bounty Platform

A blockchain-based bug bounty platform implemented as a Solidity smart contract.

## Features

- Create bug bounties with ETH rewards
- Store bounty title and vulnerability description on-chain
- Submit vulnerability reports using a report hash
- Track bounty status
- Restrict bounty resolution to the organization that created it
- Automatically transfer rewards when reports are accepted
- Emit blockchain events for bounty creation, report submission, and resolution

## Bounty Lifecycle

Organization creates bounty
→ Researcher submits report
→ Organization accepts or rejects report
→ Bounty is resolved
→ Reward is transferred if accepted

## Smart Contract

```text
contracts/
└── BugBounty.sol
```

## Main Functions

- `createBounty()` — creates a bounty and locks the ETH reward
- `submitReport()` — submits a vulnerability report hash
- `resolveBounty()` — accepts or rejects a submitted report
- `getBounty()` — retrieves bounty information

## Bounty States

- Open
- Submitted
- Resolved

## Technology

- Solidity
- Ethereum-compatible blockchain
- Remix IDE
- Remix VM / local blockchain

## Testing

The complete bounty lifecycle has been tested using Remix VM:

1. An organization creates a bounty with an ETH reward.
2. A separate account submits a vulnerability report.
3. The organization accepts the report.
4. The bounty is marked as resolved.
5. The reward is transferred to the researcher.

## Running

1. Open Remix IDE.
2. Open `contracts/BugBounty.sol`.
3. Compile using a compatible Solidity `0.8.x` compiler.
4. Open **Deploy & Run Transactions**.
5. Select Remix VM or another local development blockchain.
6. Deploy the contract.
7. Test the bounty lifecycle using separate accounts.

## Project Structure

```text
Blockchain-Bug-Bounty/
├── contracts/
│   └── BugBounty.sol
├── .gitignore
└── README.md
```

## Scope

This project focuses on the blockchain smart-contract layer of a bug bounty platform, providing transparent bounty creation, vulnerability report submission, bounty resolution, and automated reward distribution.
