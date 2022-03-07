// SPDX-License-Identifier: MIT
pragma solidity 0.8.4;

library Number {
    function uintToStringBytes(uint value) external pure returns (bytes memory) {
        if (value == 0) {
            return "0";
        }

        uint temp = value;
        uint digits;

        while (temp != 0) {
            digits++;

            temp /= 10;
        }

        bytes memory buffer = new bytes(digits);

        while (value != 0) {
            digits -= 1;

            buffer[digits] = bytes1(uint8(48 + uint(value % 10)));

            value /= 10;
        }

        return buffer;
    }
}

