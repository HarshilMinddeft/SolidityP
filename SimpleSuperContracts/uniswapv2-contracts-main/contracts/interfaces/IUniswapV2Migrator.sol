// SPDX-License-Identifier: GPL-3.0-only
pragma solidity >=0.7.0 <0.9.0;

interface IUniswapV2Migrator {
    function migrate(address token, uint amountTokenMin, uint amountETHMin, address to, uint deadline) external;
}
