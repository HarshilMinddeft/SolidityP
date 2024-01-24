// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.8.2 <0.9.0;


contract first{
        // First address will be empty
        address payable public  owner;
        // this will show address
        function addo() external  {
        owner = payable(msg.sender); 
        }
    
}
        //Inhereted first contract to another
        //Once this function is called upper function will not work this function is not reversable
contract Second is first{

        function Destroy() public{
            selfdestruct(owner);
        }
}