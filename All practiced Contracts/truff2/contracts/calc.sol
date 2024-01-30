// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.2 <0.9.0;

contract calc{
    uint256 public value;

    function sum(uint a) public{
        value+=a;
    }
    function minu(uint b) public {
        value-=b;
    }
    
}