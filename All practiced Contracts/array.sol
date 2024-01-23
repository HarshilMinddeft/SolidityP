// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.0;
// Undefined array
 contract array{

    uint256[] public arr;

        function addelement(uint256 i) public {
            arr.push(i);
        }
        function displayall() public view returns(uint[]memory){
            return arr;
        }

 }
    
    contract arr1{

        uint256[4] public arr2=[1,2,3,4];
        //for adding index as per value
        function addelement(uint256 Index, uint value) public{
            arr2[Index]=value;
        }
        // For displaying all intigers in array
        function displayall() public view returns(uint[4]memory){
            return arr2;
        }

    }
    
    contract arrstring{

        string[] public str=["aa","bb","cc","dd"];

            function addElement(string memory i) public {
                str.push(i);
            }
            function displayall() public view returns(string[]memory){
            return str;
        }
    }
