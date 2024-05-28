// SPDX-License-Identifier: GPL-3.0-or-later
pragma solidity ^0.8.0;

import {MerkleProof} from "@openzeppelin/contracts/utils/cryptography/MerkleProof.sol"; 
import "@openzeppelin/contracts/token/ERC1155/IERC1155.sol";
import "@openzeppelin/contracts/token/ERC1155/utils/ERC1155Holder.sol";

contract NftMerkleDistributor is ERC1155Holder{
    
    address public token;
    bytes32 public merkleRoot;
    uint256 public tokenId;
    mapping(address => uint256) private addressesClaimed;
    uint256 public  AirdropAmount;
    event Claimed(address indexed _from, uint256 _dropAmount);

   constructor(address token_,uint256 tokenId_, bytes32 merkleRoot_, uint256 AirdropAmount_){
        token = token_;
        tokenId = tokenId_;
        merkleRoot = merkleRoot_;
        AirdropAmount = AirdropAmount_;
    }

    function claim( address account, uint256 amount,bytes32[] calldata merkleProof)
     external {
        require(addressesClaimed[account] == 0,"MerkleDistributor: Drop already claimed");
        bytes32 leafData = keccak256(abi.encodePacked(account, amount));
        require(MerkleProof.verify(merkleProof, merkleRoot, leafData),"Invalid proof");
        addressesClaimed[account] = 1;
        IERC1155(token).safeTransferFrom(address(this), account, tokenId, amount, "");
        emit Claimed(account, amount);
    }
}