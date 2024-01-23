// SPDX-License-Identifier: GPL-3.0
// ExternalContract.sol
pragma solidity ^0.8.0;

contract ExternalContract {
    uint256 public  externalValue;

    function setExternalValue(uint256 _value) public {
        externalValue = _value;
    }

    function getExternalValue() public view returns (uint256) {
        return externalValue;
    }
}
