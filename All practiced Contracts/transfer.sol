// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.8.2 <0.9.0;

contract transfer{

    address payable user= payable(0x17F6AD8Ef982297579C203069C1DbfFE4348c372);
    function payEther() public payable {
        
    }
    function getBalance() public view returns (uint) {
        return address(this).balance;
    }
    function sendEther() public {
        user.transfer(1 ether);
    }
}
