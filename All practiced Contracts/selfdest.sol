// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.0;

contract selfd{

        address payable public benef;

        constructor (address payable _bine){
        benef=_bine;
        }
        function destroy()public{
            selfdestruct(benef);
        }
}
