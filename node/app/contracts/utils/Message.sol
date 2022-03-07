// SPDX-License-Identifier: MIT
pragma solidity 0.8.4;

import "hardhat/console.sol";

library Message {
    function normalizeMessageString(string calldata messageString) external pure returns (string memory) {
        bytes memory messageStringBytes = bytes(messageString);
        bytes memory resultBytes = new bytes(50);

        for (uint index = 0; index < resultBytes.length; index++) {
            if (messageStringBytes.length < index + 1) {
                resultBytes[index] = 0x20;
            } else {
                bytes1 char = messageStringBytes[index];

                bool isValid = false;

                isValid = isValid || (char == 0x20 || char == 0x2e);
                isValid = isValid || (char == 0x30 || char == 0x31 || char == 0x32 || char == 0x33 || char == 0x34 || char == 0x35 || char == 0x36 || char == 0x37 || char == 0x38 || char == 0x39);
                isValid = isValid || (char == 0x61 || char == 0x62 || char == 0x63 || char == 0x64 || char == 0x65 || char == 0x66 || char == 0x67 || char == 0x68 || char == 0x69 || char == 0x6a || char == 0x6b || char == 0x6c || char == 0x6d || char == 0x6e || char == 0x6f || char == 0x70 || char == 0x71 || char == 0x72 || char == 0x73 || char == 0x74 || char == 0x75 || char == 0x76 || char == 0x77 || char == 0x78 || char == 0x79 || char == 0x7a);

                if (!isValid) {
                    char = 0x20;
                }

                resultBytes[index] = char;
            }
        }

        return string(resultBytes);
    }
}

