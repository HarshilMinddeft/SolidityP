// SPDX-License-Identifier: GPL-3.0-or-later
pragma solidity ^0.8.0;

import "./uniMerkle.sol";

contract MerkleDistributorFactory {
    mapping(address => bool) public deployedContracts;
    address[] public deployedContractsList;
    event MerkleDistributorDeployed(
        address indexed distributor,
        address indexed creator
    );

    function createMerkleDistributor(
        address token,
        bytes32 merkleRoot,
        uint256 AirdropAmount
    ) external {
        require(
            IERC20(token).balanceOf(msg.sender) >= AirdropAmount,
            "MerkleDistributor: Insufficient balance"
        );
        require(
            !deployedContracts[token],
            "MerkleDistributor for this token already deployed"
        );
        IERC20(token).transferFrom(msg.sender, address(this), AirdropAmount);
        MerkleDistributor newDistributor = new MerkleDistributor(
            token,
            merkleRoot,
            AirdropAmount
        );
        deployedContracts[token] = true;
        deployedContractsList.push(address(newDistributor));
        emit MerkleDistributorDeployed(address(newDistributor), msg.sender);
    }
    function dispall() public view returns (address[] memory) {
        return deployedContractsList;
    }
}
