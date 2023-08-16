// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./LandDocumentNFT.sol";
import "./ECDSA.sol";

contract LandDocumentVerifier {
    using ECDSA for bytes32;

    LandDocumentNFT public landDocumentNFT;

    constructor(address _nftContract) {
        landDocumentNFT = LandDocumentNFT(_nftContract);
    }

    function verifyNFTOwnership(
        uint256 tokenId,
        bytes memory ownerSignature
    ) external view returns (bool) {
        // Get the owner address from the NFT contract
        address owner = landDocumentNFT.ownerOf(tokenId);

        // Generate the message hash and verify the owner's signature
        bytes32 messageHash = keccak256(abi.encodePacked(tokenId, owner));
        return messageHash.toEthSignedMessageHash().recover(ownerSignature) == owner;
    }
}
