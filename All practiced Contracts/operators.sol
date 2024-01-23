// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.4.0 <0.9.0;

contract ShiftExample {
// Using << >>
    uint16 public resultLeftShift;
    int256 public resultRightShift;


    function performShiftOperations() public {
        uint16 valueToShift = 6;
        int256 valueToShiftRight = -8;

        // Left Shift
        resultLeftShift = valueToShift << 3; // The result will have type uint16 and result will be 20 Explanation
        // Explanation << means It will multiply the value with

        // Right Shift
        resultRightShift = valueToShiftRight >> 2; // The result will have type int256
    }


    //**Using

     uint8 public result;

    function calculateExponentiation() public {
        uint8 base = 2;
        uint256 exponent = 3;

        result = base ** exponent; // The result will have type uint8
    }    
}
