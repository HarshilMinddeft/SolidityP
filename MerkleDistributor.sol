// SPDX-License-Identifier: GPL-3.0-or-later
pragma solidity ^0.8.2;

import {IERC20, SafeERC20} from "@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol";
import {MerkleProof} from "@openzeppelin/contracts/utils/cryptography/MerkleProof.sol";

contract MerkleDistributor {
    using SafeERC20 for IERC20;

    address public immutable token;
    bytes32 public immutable merkleRoot;

    mapping(address => uint256) private addressesClaimed;
    mapping(address => uint256) public dropAmounts;

    event Claimed(address indexed _from, uint256 _dropAmount);

    constructor(address token_, bytes32 merkleRoot_) {
        token = token_;
        merkleRoot = merkleRoot_;
    }

    function setDropAmount(address user, uint256 amount) external {
        dropAmounts[user] = amount;
    }

    function claim(bytes32[] calldata merkleProof) external {
        require(
            addressesClaimed[msg.sender] == 0,
            "MerkleDistributor: Drop already claimed"
        );
        bytes32 node = keccak256(abi.encodePacked(msg.sender));
        require(
            MerkleProof.verify(merkleProof, merkleRoot, node),
            "Invalid proof"
        );
        uint256 dropAmount = dropAmounts[msg.sender];
        require(dropAmount > 0, "Drop amount not set for user");
        addressesClaimed[msg.sender] = 1;
        require(
            IERC20(token).transfer(msg.sender, dropAmount),
            "Transfer failed"
        );
        emit Claimed(msg.sender, dropAmount);
    }
}
