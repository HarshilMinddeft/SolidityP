// SPDX-License-Identifier: GPL-3.0-or-later
pragma solidity ^0.8.0;

import "./NftMerkleDistributor.sol";
import "@openzeppelin/contracts/token/ERC1155/IERC1155.sol";
import "@openzeppelin/contracts/token/ERC1155/utils/ERC1155Holder.sol";

contract MerkleDistributorFactory  is ERC1155Holder{
    mapping(address => bool) public deployedContracts;
    address[] public deployedContractsList;
    mapping(address => mapping(address => uint256)) public tokenBalances;
    event NftMerkleDistributorDeployed(address indexed distributor,address indexed creator,address indexed token,uint256 tokenId
    );

    function createMerkleDistributor(
        address token,
        uint256 tokenId,
        bytes32 merkleRoot,
        uint256 AirdropAmount
    ) external {
        require(
            IERC1155(token).balanceOf(msg.sender, tokenId) >= AirdropAmount,
            "NftMerkleDistributor: Insufficient balance"
        );
        require(!deployedContracts[token],"NftMerkleDistributor for this token is already deployed"
        );
        IERC1155(token).safeTransferFrom(msg.sender, address(this), tokenId, AirdropAmount, "");
        NftMerkleDistributor newDistributor = new NftMerkleDistributor(
            token,
            tokenId,
            merkleRoot,
            AirdropAmount
        );
       IERC1155(token).safeTransferFrom(address(this), address(newDistributor), tokenId, AirdropAmount, "");
        deployedContracts[token] = true;
        deployedContracts[address(newDistributor)] = true;
        deployedContractsList.push(address(newDistributor));
        tokenBalances[address(newDistributor)][token] = AirdropAmount;
        emit NftMerkleDistributorDeployed(
            address(newDistributor),
            msg.sender,
            token,
            tokenId
        );
    }

    function claim(
        address[] memory distributors,
        address account,
        uint256[] memory amounts,
        bytes32[][] calldata merkleProofs
    ) external {
        require(distributors.length == amounts.length&&distributors.length == merkleProofs.length,
            "Array length mismatch");

        for (uint256 i = 0; i < distributors.length; i++) {
            address distributor = distributors[i];
            uint256 amount = amounts[i];
            bytes32[] calldata merkleProof = merkleProofs[i];
            require(deployedContracts[distributor],"Invalid distributor contract");
            require(tokenBalances[distributor][NftMerkleDistributor(distributor).token()] >= amount,
            "Insufficient token balance for distributor");
            tokenBalances[distributor][NftMerkleDistributor(distributor).token()] -= amount;
            NftMerkleDistributor(distributor).claim(account, amount, merkleProof);}
    }

    function getAllDeployedContracts()  external view returns (address[] memory)
    {
        return deployedContractsList;
    }
}
