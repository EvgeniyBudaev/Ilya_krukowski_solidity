// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

// Merkle tree
contract Merkle {
    bytes32[] public hashes;
    string[4] transactions = [
        "TX1: Sherlock -> John",
        "TX2: Johnk -> Sherlock",
        "TX3: John -> Mary",
        "TX4: Mary -> Sherlock"
    ];

    constructor() {
        for(uint i = 0; i < transactions.length; i++) {
            hashes.push(makeHash(transactions[i]));
        }
        uint count = transactions.length;
        uint offset = 0;
        while (count > 0) {
            for (uint i = 0; i < count; i += 2) {
                hashes.push(keccak256(
                    abi.encodePacked(
                        hashes[offset + i],
                        hashes[offset + i + 1]
                    )
                ));
            }
            offset += count;
            count = count / 2;
        }
    }

    function encode(string memory input) public pure returns(bytes memory) {
        return abi.encodePacked(input);
    }

    function makeHash(string memory input) public pure returns(bytes32) {
        return keccak256(
            encode(input)
        );
    }

    function verify(string memory transactions, uint index, bytes32 root, bytes32[] memory proof) public pure returns(bool) {
        bytes32 hash = makeHash(transactions);
        for (uint i = 0; i <proof.length; i++) {
            bytes32 element = proof[i];
            if (index % 2 == 0) {
                hash = keccak256(abi.encodePacked(hash, element));
            } else {
                hash = keccak256(abi.encodePacked(element, hash));
            }
            index = index / 2;
        }
        return hash == root;
    }
}
