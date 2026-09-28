# BugShield — Decentralized Bug Bounty Platform

BugShield is a Web3 bug bounty DApp built with Solidity and a browser frontend. Organizations can create on-chain bounties with ETH rewards, researchers can submit report hashes, and the organization can accept or reject a submitted report.

## Tech Stack

- Solidity `^0.8.20`
- Ethereum-compatible blockchain
- MetaMask
- Sepolia Test Network
- Remix IDE
- HTML / CSS / JavaScript
- ethers.js 5.7.2

## Project Structure

```text
Blockchain-Bug-Bounty-main/
├── contracts/
│   └── BugBounty.sol
├── Frontend/
│   ├── index.html
│   ├── how-it-works.html
│   ├── app.html
│   ├── run.bat
│   ├── set-contract.bat
│   ├── set_contract.py
│   ├── README.md
│   └── ...
├── .gitignore
└── README.md
```

## Smart Contract Workflow

```text
Organization
    │
    ▼
Create Bounty + ETH reward
    │
    ▼
Bounty: Open
    │
    ▼
Researcher submits report hash
    │
    ▼
Bounty: Submitted
    │
    ▼
Organization resolves report
    │
    ├── Accepted → reward transferred to researcher
    └── Rejected → reward refunded to the organization

An organization can also cancel its own `Open` bounty at any time; the locked reward is refunded.
```

## Smart Contract Functions

- `createBounty(string,string)` — creates a bounty and locks the ETH reward. Title, description, and a non-zero reward are required.
- `submitReport(uint256,string)` — submits a report hash for an open bounty. The organization cannot report on its own bounty, and the hash cannot be empty.
- `resolveBounty(uint256,bool)` — organization accepts or rejects a submitted report. Accepting pays the researcher; rejecting refunds the organization. Protected against reentrancy.
- `cancelBounty(uint256)` — organization cancels its own open bounty and gets the locked reward refunded.
- `getBounty(uint256)` — reads complete bounty information. Reverts for unknown bounty IDs.
- `bountyCount()` — returns the number of created bounties.
- `bounties(uint256)` — public mapping getter for a bounty.

## Network

The frontend is configured for **Sepolia Test Network**.

- Chain ID: `11155111`
- Hex Chain ID: `0xaa36a7`

The frontend detects network changes and asks MetaMask to switch back to Sepolia when required.

## Run the Frontend

### Windows — easiest method

Open the `Frontend` folder and double-click:

```text
run.bat
```

`run.bat` first shows the currently configured contract address then asks for a new one:

- Paste a new `0x...` contract address + Enter to replace, save, and start.
- Press Enter with empty input to keep the current address and just start.
- Invalid input is rejected and asked again (up to 10 tries).

The launcher automatically tries the available local server option in this order:

1. Python `py`
2. Python `python`
3. Node.js / `npx`

It starts the server on port `8000` and opens:

```text
http://localhost:8000/
```

A local HTTP server is recommended because browser wallets such as MetaMask may not work correctly with a `file://` page.

### Manual method

If Python is installed:

```powershell
cd Frontend
python -m http.server 8000
```

Then open `http://localhost:8000/`.

## MetaMask Setup

1. Install/unlock MetaMask.
2. Enable Sepolia test network.
3. Make sure the wallet has Sepolia test ETH for transaction fees and bounty rewards.
4. Open the BugShield frontend.
5. Click **Connect MetaMask**.
6. Keep MetaMask on Sepolia.

## Deploying the Contract

1. Open `contracts/BugBounty.sol` in Remix.
2. Compile with Solidity `0.8.20` or another compatible `0.8.x` compiler.
3. In Remix, select **Injected Provider - MetaMask**.
4. Make sure MetaMask is on Sepolia.
5. Deploy `BugBounty`.
6. Copy the deployed contract address.
7. Run `Frontend/run.bat`, paste the address when asked, and press Enter — it replaces `CONTRACT_ADDRESS` in `Frontend/app.html`, saves, and starts the server. (Manual alternative: edit `CONTRACT_ADDRESS` in `app.html` yourself.)

The contract address and a transaction hash are different values:

- **Contract address:** identifies the deployed smart contract.
- **Transaction hash:** identifies one blockchain transaction.

## Bounty Testing

A normal test flow is:

1. Connect MetaMask.
2. Create a bounty and send an ETH reward.
3. Read the created bounty from the live contract.
4. Switch MetaMask to a different account (researcher) to submit a report hash. The organization account cannot report on its own bounty.
5. Return to the organization wallet.
6. Resolve the submitted bounty.
7. If accepted, the contract transfers the locked reward to the researcher. If rejected, the reward is refunded to the organization.

## Security Notes

- Never put a MetaMask private key or seed phrase in this repository.
- Never commit `.env` files containing secrets.
- This project uses Sepolia test ETH; do not treat testnet funds as real funds.

## Frontend Pages

- `index.html` — BugShield landing page.
- `how-it-works.html` — explains the on-chain bounty workflow.
- `app.html` — live DApp interface for connecting MetaMask, creating bounties, submitting reports, and resolving bounties.
