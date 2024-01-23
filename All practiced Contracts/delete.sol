// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.4.0 <0.9.0;


contract deletee{

    uint256 [4] public arr=[1,2,3,4];
    uint256 [] public newarr;
    function remove() public {
        delete arr;
    }

    function all() public view  returns (uint256[4]memory){
            return arr;
    }
    function rem1() public {
        newarr.pop();
    }
}