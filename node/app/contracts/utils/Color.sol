// SPDX-License-Identifier: MIT
pragma solidity 0.8.4;

library Color {
    function validateColorString(string calldata colorString) external view returns (bool) {
        bytes memory colorStringBytes = bytes(colorString);

        bool result = true;

        result = result && (colorStringBytes.length == 7);
        result = result && (colorStringBytes[0] == 0x23);

        for (uint index = 1; index < 7; index++) {
            bytes1 char = colorStringBytes[1];

            result = result && (char == 0x30 || char == 0x31 || char == 0x32 || char == 0x33 || char == 0x34 || char == 0x35 || char == 0x36 || char == 0x37 || char == 0x38 || char == 0x39);
            result = result && (char == 0x61 || char == 0x62 || char == 0x63 || char == 0x64 || char == 0x65 || char == 0x66);
        }

        return result;
    }
}

