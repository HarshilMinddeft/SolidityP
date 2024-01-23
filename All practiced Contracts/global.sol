// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.8.2 <0.9.0;


contract global{
    
    function allG() public  view returns(uint256 block_no, uint timestamp , address msgSender){
        return (block.number,block.timestamp,msg.sender);
        
    }
    function allg() public view returns(uint chainid, address coinbase, uint256 gaslimit, uint256 difficulty)
    {
        return (block.chainid,block.coinbase,block.gaslimit,block.difficulty);
    }
    function msgs() public view returns (bytes11 msgsig, uint256 gas, address txOrigin){
        return (msg.sig,tx.gasprice,tx.origin);
    }


    // Function to get the balance of an address in Wei
    function getBalance(address _address) public view returns (uint256) {
        return _address.balance;
    }

    // Function to get the code at an address (can be empty)
    function getCode(address _address) public view returns (bytes memory) {
        return _address.code;
    }

    // Function to get the codehash of an address
    function getCodeHash(address _address) public view returns (bytes32) {
        return _address.codehash;
    }

    // Function to transfer Ether to an address
    function transferEther(address payable _to, uint256 _amount) public {
        _to.transfer(_amount);
    }

    // Function to send Ether to an address and return success status
    function sendEther(address payable _to, uint256 _amount) public returns (bool) {
        return _to.send(_amount);
    }

    // Function to issue a low-level CALL with the given payload
    function callFunction(address _to, bytes memory _payload) public returns (bool, bytes memory) {
        (bool success, bytes memory data) = _to.call(_payload);
        return (success, data);
    }
        
}