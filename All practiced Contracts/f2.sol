// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.0;
import "./f1.sol";

contract ContractCaller {
    // Interface to interact with ExternalContract
    ExternalContract public externalContract;

    // Constructor to set the external contract address
    constructor(address _externalContractAddress) {
        externalContract = ExternalContract(_externalContractAddress);
    }

    // Function to call setExternalValue in ExternalContract
    function callSetExternalValue(uint256 _value) public {
        externalContract.setExternalValue(_value);
    }

    // Function to call getExternalValue in ExternalContract
    function callGetExternalValue() public view returns (uint256) {
        return externalContract.getExternalValue();
    }
}
