// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

library ECDSA {
    // Recover the address associated with a given hash and ECDSA signature
    function recover(bytes32 hash, bytes memory signature) internal pure returns (address) {
        require(signature.length == 65, "ECDSA: Invalid signature length");

        bytes32 r;
        bytes32 s;
        uint8 v;

        assembly {
            // Extract r, s, and v from the signature
            r := mload(add(signature, 32))
            s := mload(add(signature, 64))
            v := byte(0, mload(add(signature, 96)))
        }

        // Adjust v if needed
        if (v < 27) {
            v += 27;
        }

        // Check if v is valid (27 or 28)
        require(v == 27 || v == 28, "ECDSA: Invalid signature 'v' value");

        // Recover and return the signer's address
        return ecrecover(hash, v, r, s);
    }

    // Convert a hash to an Ethereum-signed message hash
    function toEthSignedMessageHash(bytes32 hash) internal pure returns (bytes32) {
        // Add Ethereum-specific prefix to the hash
        return keccak256(abi.encodePacked("\x19Ethereum Signed Message:\n32", hash));
    }
}
