cd src
nano TransactionFeeSpikeTrap.sol
# Paste the Solidity code below into the nano editor, then save (Ctrl+X, Y, Enter).

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "./ITrap.sol";

interface IERC20 {
    function balanceOf(address account) external view returns (uint256);
}

contract TransactionFeeSpikeTrap is ITrap {
    address public constant TOKEN = 0xFba1bc0E3d54D71Ba55da7C03c7f63D4641921B1;
    address public constant FEE_POOL = 0x0000000000000000000000000000000000000000;

    struct CollectOutput {
        uint256 feeAmount;
    }

    constructor() {}

    function collect() external view override returns (bytes memory) {
        uint256 currentFee = IERC20(TOKEN).balanceOf(FEE_POOL); // Simulating fee fetch
        return abi.encode(CollectOutput({feeAmount: currentFee}));
    }

    function shouldRespond(bytes[] calldata data) external pure override returns (bool, bytes memory) {
        CollectOutput memory current = abi.decode(data[0], (CollectOutput));
        CollectOutput memory past = abi.decode(data[data.length - 1], (CollectOutput));
        if (past.feeAmount == 0) return (false, bytes(""));
        uint256 spike = ((current.feeAmount - past.feeAmount) * 1e18) / past.feeAmount;
        if (spike > 1e17) return (true, bytes(""));
        return (false, bytes(""));
    }
}
