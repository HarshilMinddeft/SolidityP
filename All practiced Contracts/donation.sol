// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract Donation{

    struct Infos{
        string name;
        string message;
        uint timestamp;
        address from;
    }
    Infos[] arr;
    address payable public  owner;

    constructor(){
        owner=payable(msg.sender);
    }

    function donate(string memory name, string memory message)payable public {
        require(msg.value>0,"Amount should be greater that zero");
        owner.transfer(msg.value);
        arr.push(Infos(name,message,block.timestamp,msg.sender));
    }
    function getInfo() public view returns(Infos[]memory){
            return arr;
    }
    function getbal() public view returns(uint){
         return owner.balance;
    }
}
