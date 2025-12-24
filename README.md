# 💰 Decentralized CrowdFunding Smart Contract

A secure and transparent fundraising smart contract built on Ethereum. This project implements an "All-or-Nothing" funding model similar to Kickstarter, but fully decentralized. It ensures that funds are either released to the creator upon reaching the goal or refunded to donors if the campaign fails.

## 🌟 Key Features

- **All-or-Nothing Logic:** The campaign owner can only withdraw funds if the `Target Goal` is reached by the `Deadline`.
- **Trustless Refunds:** If the goal is not met, donors can claim a full refund of their contributions via the `refund()` function. No central authority is needed.
- **Backer Transparency:** Uses `structs` and `arrays` to keep a public record of all donors, their names, and contribution amounts.
- **Event Logging:** Emits a `YeniBagis` event for every donation, making it easy for frontend applications to display real-time updates.
- **Security:** Implements "Checks-Effects-Interactions" pattern to prevent reentrancy attacks during refunds.

## 🛠️ Technical Implementation

- **Language:** Solidity (v0.8.20)
- **Core Concepts:**
  - `mapping(address => uint256)` for accurate balance tracking.
  - `struct` for organizing rich donor data (Name, Amount, Address).
  - `payable` functions for handling ETH transactions.
  - `block.timestamp` for time-based logic restrictions.

## 🚀 How It Works

1. **Deploy:** The creator deploys the contract specifying the `Target Goal` (in Wei) and `Duration` (in seconds).
2. **Donate:** Supporters call the `deposit` function to send ETH.
   - *The contract records their address, name, and amount.*
3. **Campaign Ends:**
   - **Scenario A (Success):** If `Total Raised >= Goal` AND `Time is up` -> Owner calls `withdraw` to get the funds.
   - **Scenario B (Failure):** If `Total Raised < Goal` AND `Time is up` -> Donors call `refund` to get their money back.

## 💻 Usage Example

1. Deploy the contract with:
   - `_hedef`: `1000000000000000000` (1 ETH)
   - `_sureSaniye`: `3600` (1 Hour)
2. Send ETH using `deposit("Donor Name")`.
3. Check `bagisciListesi` to see the new entry.
4. Wait for the timer to expire and test either `withdraw` or `refund` based on the total raised.

## 📄 License

This project is licensed under the MIT License.
