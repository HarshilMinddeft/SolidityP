// SPDX-License-Identifier: GPL-3.0-or-later
pragma solidity ^0.8.2;

import {IERC20, SafeERC20} from "@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol";
import {MerkleProof} from "@openzeppelin/contracts/utils/cryptography/MerkleProof.sol";
// import "./IERC20.sol";

contract MerkleDistributor {
    using SafeERC20 for IERC20;
    address public  token;
    bytes32 public  merkleRoot;
    mapping(address => uint256) private addressesClaimed;
    uint256 AirdropAmount;
    address public walletAddress;
    event Claimed(address indexed _from, uint256 _dropAmount);

constructor(address token_,address walletAddress_) public {
        token=token_;
        walletAddress =walletAddress_;
}

    function createAidrop(address token_, bytes32 merkleRoot_, uint256 AirdropAmount_) public{
        token = token_;
        merkleRoot = merkleRoot_;
        AirdropAmount = AirdropAmount_;

        require(
            IERC20(token_).balanceOf(msg.sender) >= AirdropAmount_,
            "MerkleDistributor: Insufficient balance"
        );
        IERC20(token_).transferFrom(msg.sender,address(this), AirdropAmount_);
    }

    function claim(
        address account,
        uint256 amount,
        bytes32[] calldata merkleProof
    ) external {
        require(
            addressesClaimed[account] == 0,
            "MerkleDistributor: Drop already claimed"
        );
        bytes32 leafData = keccak256(abi.encodePacked(account, amount));
        require(
            MerkleProof.verify(merkleProof, merkleRoot, leafData),
            "Invalid proof"
        );
        addressesClaimed[account] = 1;
        require(IERC20(token).transfer(account, amount), "Transfer failed");
        emit Claimed(account, amount);
    }
}
