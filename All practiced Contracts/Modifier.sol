// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.8.2 <0.9.0;

contract Base1

{
    address payable public owner;
// address will be not shown because of use of moifyer
    modifier onlyOwner() {
        owner = payable(msg.sender);
        require(msg.sender == owner, "Only the owner can call this function");
        _; // This underscore represents the location where the modified function's code will be inserted
    }
    modifier foo() virtual {_;}
}

contract Base2
{
    modifier foo() virtual {_;}
}

contract Inherited is Base1, Base2
{
    modifier foo() override(Base1, Base2) {_;}
}