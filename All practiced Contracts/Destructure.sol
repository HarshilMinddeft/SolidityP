// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.8.2 <0.9.0;

contract des{

    function dec() public pure returns(uint256 ,uint256){
       uint8[2] memory value=[10,20];

       (uint a , uint b )= (value[0],value[1]);
       return (a,b);

    
    }
    function des2() public pure returns(uint, uint){   
       (uint e , uint f) = (50,60);
       return (e,f);
    }
    function returnMulti() public pure returns (uint, string memory){
        uint number= 12;
        string memory str="wkehfwh";
        return (number,str);

    }
       function f(uint a, uint b) pure public returns (uint) {
        // This subtraction will wrap on underflow.
        unchecked { return a - b; }
    }
    function g(uint a, uint b) pure public returns (uint) {
        // This subtraction will revert on underflow.
        return a - b;
    }
}