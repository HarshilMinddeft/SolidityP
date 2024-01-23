// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.0;

contract bytess{

bytes public b1="abc";

 function insertb() public {
     
     b1.push("d");
     
}

 function insertf() public{
    b1.push("f");

 }

    function indexaccess(uint i) public view returns (bytes1){
        return b1[i] ;
 }
 
    function getlength() public view returns(uint256){
        return b1.length;
    }
}

contract bytessArray{

    bytes2 public b2;
    bytes3 public b3;
    bytes4 public b4;
    bytes5 public b5;
    bytes7 public b7;
    bytes10 public b10;

    function setval() public {

 // The output numbers are coming as per ASCII Table alphabets valuea signed

        b2="ab";
        b3="Msd";
        b5="parth";
        b4="abcd";
        b7="Harshil";
        b10="BitcoinBTC";

    }
}
