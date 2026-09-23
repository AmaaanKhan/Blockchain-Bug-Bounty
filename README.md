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

## Running/Screenshots

CREATE BOUNTY
<img width="1907" height="1012" alt="Screenshot 2026-09-23 060014" src="https://github.com/user-attachments/assets/dd7829e9-3fd1-4443-b0f1-5a8668b2f89b" />

SET REWARD
<img width="1917" height="1017" alt="Screenshot 2026-09-23 055947" src="https://github.com/user-attachments/assets/29d79193-dc98-4098-b2bf-017249e83510" />

SUBMIT SOLUTION
<img width="1917" height="1016" alt="Screenshot 2026-09-23 060535" src="https://github.com/user-attachments/assets/c1e8c472-6aea-460f-8cd4-247659be5252" />

ACCEPT SOLUTION (WILL RELEASE REWARD)
<img width="1916" height="1010" alt="Screenshot 2026-09-23 060906" src="https://github.com/user-attachments/assets/7d7e912f-50cc-47dd-9f3f-39503d117fd1" />

ACCOUNT BALANCE 94.99 (-5) AFTER RELEASING PAYMENT
<img width="1917" height="1017" alt="Screenshot 2026-09-23 060302" src="https://github.com/user-attachments/assets/2a71f7f2-92e3-418e-944a-bbd96d758492" />


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
