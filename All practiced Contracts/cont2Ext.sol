// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.0;

interface ExternalContract {
    function externalFunction() external;
}

contract MyContract {
    function callExternalFunction(address _externalContract) public {
        // External function call
        ExternalContract(_externalContract).externalFunction();
    }
}
