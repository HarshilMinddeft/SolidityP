// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.8.2 <0.9.0;

contract Crowdfunding{

    mapping(address=>uint) public Donaters;
    address public manager;
    uint public minimumContributin;
    uint public deadline;
    uint public target;
    uint public raisedAmount;
    uint public DonatersNo;

 // manager will fill rarget and deadline at the time of deploying then only contract will deployed
    constructor(uint _target, uint _deadline){

        target=_target;
        // How much time the contract will be valid current timestamp+3600 for 1 hour validation
        deadline=block.timestamp+_deadline;
        // Minimum charge to participate
        minimumContributin=100 wei;
        // managers address
        manager=msg.sender;

    }

      function sendEthDonation() public payable {
        // to check the before sending wei contract is working as per time stamp
        require(block.timestamp<deadline,"Sorry Deadline has passed");
        // to check the user is paying min amount of wei for donation
        require(msg.value>=minimumContributin,"Min amount is 100wei donate above 100 wei");
        // if doner has donated first time if will exectue
        if(Donaters[msg.sender]==0){
            // it will increase doners no if doner is new 
            DonatersNo++;
        }
        // this is for doners who have donated before and to avoide donerNumber to increase if one user votes again and again
        Donaters[msg.sender]+=msg.value;
        // amount from user will decrease and it will get added in contract amount
        raisedAmount+=msg.value;
    }
    function getContractbalance() public view returns(uint) {
            return address(this).balance;
    }
    function refund() public{
        // User will not get refund if target and deadline time is remaining as per manager decided in contract
        require(block.timestamp>deadline && raisedAmount<target,"You are not eligible!! Taregt and deadline have some timeleft");
        // when doner hasend donated any wei and asking for refund 
        require(Donaters[msg.sender]>0);
        // payable and address payable for sending refund to owner address back
        address payable user = payable(msg.sender);
        user.transfer(Donaters[msg.sender]);
        // it will show doners account to zero 
        Donaters[msg.sender]=0;
    }
    
   
}