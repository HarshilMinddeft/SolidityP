// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.4.0 <0.9.0;

contract error{

    function rrequire(uint a, uint b) public pure returns(uint256){
            require(b!=0 ,"cannot divide");
            return a/b;

    }
    function assertt(uint x) public pure returns(uint){
        assert(x>0);
        return x;
    }

    function revvert(uint a, uint b) public pure{
        if(a>b){
            revert("a should be not greater the b");
        }
    }

}

contract F {
    // omitted name for parameter
    function func(uint k, uint) public pure returns(uint) {
        return k;
    }
}
contract EventExample {
    // Declare an event with indexed parameters
    event ValueChanged(address indexed sender, uint256 indexed newValue);

    uint256 public value;

    function setValue(uint256 _newValue) public {
        // Update the state variable
        value = _newValue;

        // Emit the event to log the state change
        emit ValueChanged(msg.sender, _newValue);
    }
}