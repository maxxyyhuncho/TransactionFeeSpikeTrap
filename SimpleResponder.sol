cd src
nano SimpleResponder.sol
# Paste the Solidity code below into the nano editor, then save (Ctrl+X, Y, Enter).

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract SimpleResponder {
    function respondCallback(uint256 amount) public {
        // PoC: The Trap triggered, the Responder was called.
    }
}

cd ..
