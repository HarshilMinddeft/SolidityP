// SPDX-License-Identifier: GPL-3.0-only
pragma solidity >=0.7.0 <0.9.0;

interface IWETH {
    function deposit() external payable;
    function transfer(address to, uint value) external returns (bool);
    function withdraw(uint) external;
}
