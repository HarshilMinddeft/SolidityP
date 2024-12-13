// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract Erc20Super is ERC20 {
    mapping(address => int256) public netFlowRates;  // Flow rate for each account
    mapping(address => uint256) public lastUpdated;  // Last update time for each account
    address owner;

    constructor(string memory name, string memory symbol) ERC20(name, symbol) {
        owner = msg.sender;
    }

    // Override balanceOf to include the dynamic streaming balance
    function balanceOf(address account) public view override returns (uint256) {
        uint256 staticBalance = super.balanceOf(account);
        int256 dynamicBalance = _calculateDynamicBalance(account);
        require(int256(staticBalance) + dynamicBalance >= 0, "Balance underflow");
        return uint256(int256(staticBalance) + dynamicBalance);
    }

    // Internal function to calculate the dynamic balance based on the flow rate and elapsed time
    function _calculateDynamicBalance(address account) internal view returns (int256) {
        int256 flowRate = netFlowRates[account];
        uint256 elapsedTime = block.timestamp - lastUpdated[account];
        return flowRate * int256(elapsedTime);
    }

    // Update the flow rate for a user (called by StreamManager contract)
    function updateFlow(address account, int256 flowRate) external  {
        _updateBalance(account);
        netFlowRates[account] += flowRate;
        lastUpdated[account] = block.timestamp;
    }

    // Internal function to update the balance for a user
    function _updateBalance(address account) internal {
        int256 dynamicBalance = _calculateDynamicBalance(account);
        if (dynamicBalance > 0) {
            _mint(account, uint256(dynamicBalance));
        } else if (dynamicBalance < 0) {
            _burn(account, uint256(-dynamicBalance));
        }
    }

    // Mint tokens to an account (onlyOwner)
    function mint(address recipient, uint256 amount) external  {
        _mint(recipient, amount);
    }
}
