// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.4.0 <0.9.0;

library calc{
    function add(uint a ,uint b) public pure returns(uint){
        return a+b;
    }
    function sub(uint a,uint b)public pure returns(uint){
        return a-b;
    }
}

contract ss{
    using calc for uint;
    function calco(uint x, uint y) public pure returns(uint){
        return x.add(y);
    }
}

contract ee{
    using calc for uint;
    function ccc(uint x, uint y) public pure returns(uint){
    return x.sub(y);
    }
}

/////////////////////////////////////////////////////////////////////////////////////

library a{
    function c(uint) external {}
}

contract h {
    function e() public pure returns(bytes5){
    return a.c.selector;
}
}