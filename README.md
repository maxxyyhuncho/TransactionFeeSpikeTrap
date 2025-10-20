# TransactionFeeSpikeTrap
# TransactionFeeSpikeTrap (Drosera Proof-of-Concept)

## Overview
// The AI MUST generate a 2-3 sentence, well-written description of what this specific trap monitors and why it's critical.
This trap monitors for spikes in transaction fees, which can indicate network congestion or manipulation. It triggers alerts when fees exceed a certain threshold, ensuring timely responses to market changes.

---

## What It Does
* Monitors the fee pool balance of a specified token.
* Triggers if the fee amount spikes by more than 10% from the last confirmed reading.
* It demonstrates the essential Drosera trap pattern using deterministic logic.

---

## Key Files
* `src/TransactionFeeSpikeTrap.sol` - The core trap contract containing the monitoring logic.
* `src/SimpleResponder.sol` - The required external response contract.
* `drosera.toml` - The deployment and configuration file.

---

## Detection Logic

The trap's core monitoring logic is contained in the deterministic `shouldRespond()` function.

solidity
// The AI MUST insert the full, syntax-highlighted Solidity code of the `shouldRespond()` logic here.
function shouldRespond(bytes[] calldata data) external pure override returns (bool, bytes memory) {
    CollectOutput memory current = abi.decode(data[0], (CollectOutput));
    CollectOutput memory past = abi.decode(data[data.length - 1], (CollectOutput));
    if (past.feeAmount == 0) return (false, bytes(""));
    uint256 spike = ((current.feeAmount - past.feeAmount) * 1e18) / past.feeAmount;
    if (spike > 1e17) return (true, bytes(""));
    return (false, bytes(""));
}
 

---

## 🧪 Implementation Details and Key Concepts
* **Monitoring Target:** Watching the fee pool balance of the specified token at address 0xFba1bc0E3d54D71Ba55da7C03c7f63D4641921B1.
* **Deterministic Logic:** The logic is executed off-chain by operators to achieve consensus before a transaction is proposed.
* **Calculation/Thresholds:** Uses a fixed 10% deviation threshold to determine if a spike has occurred.
* **Response Mechanism:** On trigger, the trap calls the external Responder contract, demonstrating the separation of monitoring and action.

---

## Test It
To verify the trap logic using Foundry, run the following command (assuming a test file has been created):

bash
forge test --match-contract TransactionFeeSpikeTrap
