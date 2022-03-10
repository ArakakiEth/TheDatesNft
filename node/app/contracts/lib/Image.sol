// SPDX-License-Identifier: MIT
pragma solidity 0.8.4;

import "@openzeppelin/contracts/utils/Strings.sol";

library Image {
    using Strings for uint;

    function generateSVG(string memory year, string memory month, string memory dayOfMonth, string memory message, string memory backgroundColor, string memory dateTextColor, string memory messageTextColor, bool isPresent) external pure returns (bytes memory) {
        bytes memory result;
        
        result = bytes.concat(result, bytes("<svg xmlns=\"http://www.w3.org/2000/svg\" xmlns:xlink=\"http://www.w3.org/1999/xlink\" viewBox=\"0 0 100 100\" width=\"400\" height=\"400\">"));
        result = bytes.concat(result, _generateBackgroundRect(backgroundColor));
        result = bytes.concat(result, _generatePresentIcon(isPresent));
        result = bytes.concat(result, _generateYearText(year, dateTextColor));
        result = bytes.concat(result, _generateMonthAndDayOfMonthText(month, dayOfMonth, dateTextColor));
        result = bytes.concat(result, _generateMessageText(message, messageTextColor));
        result = bytes.concat(result, bytes("</svg>"));

        return result;
    }

    function _generateBackgroundRect(string memory color) private pure returns (bytes memory) {
        bytes memory result;

        result = bytes.concat(result, bytes("<rect x=\"0\" y=\"0\" width=\"100\" height=\"100\" fill=\""), bytes(color), bytes("\" />"));

        return result;
    }

    function _generatePresentIcon(bool isPresent) private pure returns (bytes memory) {
        bytes memory result;

        if (!isPresent) {
            return result;
        }

        result = bytes.concat(result, bytes("<g transform=\"translate(80, 16)\" font-size=\"12\">"));
        result = bytes.concat(result, bytes("<text>"), bytes(string(unicode"🎁")), bytes("</text>"));
        result = bytes.concat(result, bytes("</g>"));

        return result;
    }

    function _generateYearText(string memory year, string memory color) private pure returns (bytes memory) {
        bytes memory chars = bytes(year);

        bytes memory result;

        if (chars.length < 4) {
            return result;
        }

        result = bytes.concat(result, bytes("<g transform=\"translate(4, 8) scale(1.6)\" fill=\""), bytes(color), bytes("\">"));
        result = bytes.concat(result, bytes("<path d=\""), path(chars[0]), bytes("\" transform=\"translate(0, 0)\" />"));
        result = bytes.concat(result, bytes("<path d=\""), path(chars[1]), bytes("\" transform=\"translate(6, 0)\" />"));
        result = bytes.concat(result, bytes("<path d=\""), path(chars[2]), bytes("\" transform=\"translate(12, 0)\" />"));
        result = bytes.concat(result, bytes("<path d=\""), path(chars[3]), bytes("\" transform=\"translate(18, 0)\" />"));
        result = bytes.concat(result, bytes("<path d=\""), path(bytes(".")[0]), bytes("\" transform=\"translate(24, 0)\" />"));
        result = bytes.concat(result, bytes("</g>"));

        return result;
    }

    function _generateMonthAndDayOfMonthText(string memory month, string memory dayOfMonth, string memory color) private pure returns (bytes memory) {
        bytes memory chars = bytes.concat(bytes(month), bytes(dayOfMonth));

        bytes memory result;

        if (chars.length < 4) {
            return result;
        }

        result = bytes.concat(result, bytes("<g transform=\"translate(4, 24) scale(3)\" fill=\""), bytes(color), bytes("\">"));
        result = bytes.concat(result, bytes("<path d=\""), path(chars[0]), bytes("\" transform=\"translate(0, 0)\" />"));
        result = bytes.concat(result, bytes("<path d=\""), path(chars[1]), bytes("\" transform=\"translate(6, 0)\" />"));
        result = bytes.concat(result, bytes("<path d=\""), path(bytes(".")[0]), bytes("\" transform=\"translate(12, 0)\" />"));
        result = bytes.concat(result, bytes("<path d=\""), path(chars[2]), bytes("\" transform=\"translate(18, 0)\" />"));
        result = bytes.concat(result, bytes("<path d=\""), path(chars[3]), bytes("\" transform=\"translate(24, 0)\" />"));
        result = bytes.concat(result, bytes("</g>"));

        return result;
    }

    function _generateMessageText(string memory message, string memory color) private pure returns (bytes memory) {
        bytes memory messageBytes = bytes.concat(bytes(message));
        bytes memory chars = new bytes(50);

        for (uint index = 0; index < 50; index++) {
            if (messageBytes.length > index) {
                chars[index] = messageBytes[index];
            } else {
                chars[index] = 0x20;
            }
        }

        bytes memory result;

        result = bytes.concat(result, bytes("<g transform=\"translate(4, 48) scale(1.2)\" fill=\""), bytes(color), bytes("\">"));

        for (uint index = 0; index < 50; index++) {
            uint x = (index % 10) * 6;
            uint y = (index / 10) * 8;

            result = bytes.concat(result, bytes("<path d=\""), path(chars[index]), bytes("\" transform=\"translate("), bytes(x.toString()), bytes(", "), bytes(y.toString()), bytes(")\" />"));
        }

        result = bytes.concat(result, bytes("</g>"));

        return result;
    }

    function path(bytes1 char) private pure returns (bytes memory) {
        if (char == 0x20) {
            return bytes("");
        } else if (char == 0x21) {
            return bytes("M1,0L2,0L2,3L1,3L1,4L2,4L2,5L1,5Z");
        } else if (char == 0x27) {
            return bytes("M1,0L2,0L2,2L1,2Z");
        } else if (char == 0x2c) {
            return bytes("M2,3L3,3L3,5L1,5L1,4L2,4Z");
        } else if (char == 0x2e) {
            return bytes("M1,4L3,4L3,5L1,5");
        } else if (char == 0x3f) {
            return bytes("M1,0L3,0L3,1L4,1L4,2L3,2L3,3L1,3L1,4L2,4L2,5L1,5L1,2L3,2L3,1L1,1Z");
        } else if (char == 0x30) {
            return bytes("M1,0L4,0L4,1L5,1L5,4L4,4L4,2L3,2L3,3L2,3L2,4L4,4L4,5L1,5L1,4L0,4L0,1L1,1L1,3L2,3L2,2L3,2L3,1L1,1Z");
        } else if (char == 0x31) {
            return bytes("M2,0L3,0L3,4L5,4L5,5L0,5L0,4L2,4L2,2L1,2L1,1L2,1Z");
        } else if (char == 0x32) {
            return bytes("M0,0L4,0L4,1L5,1L5,2L4,2L4,3L1,3L1,4L5,4L5,5L0,5L0,3L1,3L1,2L4,2L4,1L0,1Z");
        } else if (char == 0x33) {
            return bytes("M1,0L4,0L4,1L5,1L5,2L4,2L4,3L5,3L5,4L4,4L4,5L1,5L1,4L0,4L0,3L1,3L1,4L4,4L4,3L2,3L2,2L4,2L4,1L1,1L1,2L0,2L0,1L1,1Z");
        } else if (char == 0x34) {
            return bytes("M2,0L4,0L4,3L5,3L5,4L4,4L4,5L3,5L3,4L0,4L0,2L1,2L1,1L2,1L2,2L1,2L1,3L3,3L3,1L2,1Z");
        } else if (char == 0x35) {
            return bytes("M0,0L5,0L5,1L1,1L1,2L4,2L4,3L5,3L5,4L4,4L4,5L0,5L0,4L4,4L4,3L0,3Z");
        } else if (char == 0x36) {
            return bytes("M1,0L5,0L5,1L1,1L1,2L4,2L4,3L5,3L5,4L4,4L4,5L1,5L1,4L4,4L4,3L1,3L1,4L0,4L0,1L1,1Z");
        } else if (char == 0x37) {
            return bytes("M0,0L5,0L5,2L4,2L4,3L3,3L3,5L2,5L2,3L3,3L3,2L4,2L4,1L0,1Z");
        } else if (char == 0x38) {
            return bytes("M1,0L4,0L4,1L5,1L5,2L4,2L4,3L5,3L5,4L4,4L4,5L1,5L1,4L0,4L0,3L1,3L1,4L4,4L4,3L1,3L1,2L0,2L0,1L1,1L1,2L4,2L4,1L1,1Z");
        } else if (char == 0x39) {
            return bytes("M1,0L4,0L4,1L5,1L5,4L4,4L4,5L1,5L1,4L4,4L4,3L1,3L1,2L0,2L0,1L1,1L1,2L4,2L4,1L1,1Z");
        } else if (char == 0x41 || char == 0x61) {
            return bytes("M1,0L5,0L5,5L4,5L4,4L1,4L1,5L0,5L0,1L1,1L1,3L4,3L4,1L1,1Z");
        } else if (char == 0x42 || char == 0x62) {
            return bytes("M0,0L4,0L4,1L5,1L5,2L4,2L4,1L1,1L1,2L4,2L4,3L1,3L1,4L4,4L4,3L5,3L5,5L0,5Z");
        } else if (char == 0x43 || char == 0x63) {
            return bytes("M1,0L5,0L5,1L1,1L1,4L5,4L5,5L1,5L1,4L0,4L0,1L1,1Z");
        } else if (char == 0x44 || char == 0x64) {
            return bytes("M0,0L3,0L3,1L4,1L4,2L5,2L5,4L4,4L4,2L3,2L3,1L1,1L1,4L4,4L4,5L0,5Z");
        } else if (char == 0x45 || char == 0x65) {
            return bytes("M0,0L5,0L5,1L1,1L1,2L3,2L3,3L1,3L1,4L5,4L5,5L0,5Z");
        } else if (char == 0x46 || char == 0x66) {
            return bytes("M0,0L5,0L5,1L1,1L1,2L3,2L3,3L1,3L1,5L0,5Z");
        } else if (char == 0x47 || char == 0x67) {
            return bytes("M1,0L5,0L5,1L1,1L1,4L4,4L4,3L3,3L3,2L5,2L5,5L1,5L1,4L0,4L0,1L1,1Z");
        } else if (char == 0x48 || char == 0x68) {
            return bytes("M0,0L1,0L1,3L4,3L4,0L5,0L5,5L4,5L4,4L1,4L1,5L0,5Z");
        } else if (char == 0x49 || char == 0x69) {
            return bytes("M0,0L5,0L5,1L3,1L3,4L5,4L5,5L0,5L0,4L2,4L2,1L0,1Z");
        } else if (char == 0x4a || char == 0x6a) {
            return bytes("M1,0L5,0L5,4L4,4L4,5L1,5L1,4L0,4L0,3L1,3L1,4L4,4L4,1L1,1Z");
        } else if (char == 0x4b || char == 0x6b) {
            return bytes("M0,0L1,0L1,2L3,2L3,1L4,1L4,0L5,0L5,1L4,1L4,2L3,2L3,3L4,3L4,4L5,4L5,5L4,5L4,4L3,4L3,3L1,3L1,5L0,5Z");
        } else if (char == 0x4c || char == 0x6c) {
            return bytes("M0,0L1,0L1,4L5,4L5,5L0,5Z");
        } else if (char == 0x4d || char == 0x6d) {
            return bytes("M0,0L1,0L1,1L2,1L2,2L3,2L3,1L4,1L4,0L5,0L5,5L4,5L4,2L3,2L3,3L2,3L2,2L1,2L1,5L0,5Z");
        } else if (char == 0x4e || char == 0x6e) {
            return bytes("M0,0L1,0L1,1L2,1L2,2L3,2L3,3L4,3L4,0L5,0L5,5L4,5L4,4L3,4L3,3L2,3L2,2L1,2L1,5L0,5Z");
        } else if (char == 0x4f || char == 0x6f) {
            return bytes("M1,0L4,0L4,1L5,1L5,4L4,4L4,5L1,5L1,4L0,4L0,1L1,1L1,4L4,4L4,1L1,1Z");
        } else if (char == 0x50 || char == 0x70) {
            return bytes("M0,0L4,0L4,1L1,1L1,3L4,3L4,1L5,1L5,3L4,3L4,4L1,4L1,5L0,5Z");
        } else if (char == 0x51 || char == 0x71) {
            return bytes("M1,0L4,0L4,1L5,1L5,3L4,3L4,4L5,4L5,5L4,5L4,4L3,4L3,5L1,5L1,4L0,4L0,1L1,1L1,4L3,4L3,3L4,3L4,1L1,1Z");
        } else if (char == 0x52 || char == 0x72) {
            return bytes("M0,0L4,0L4,1L1,1L1,3L4,3L4,1L5,1L5,3L4,3L4,4L5,4L5,5L4,5L4,4L1,4L1,5L0,5Z");
        } else if (char == 0x53 || char == 0x73) {
            return bytes("M1,0L5,0L5,1L1,1L1,2L4,2L4,3L5,3L5,4L4,4L4,5L0,5L0,4L4,4L4,3L1,3L1,2L0,2L0,1L1,1Z");
        } else if (char == 0x54 || char == 0x74) {
            return bytes("M0,0L5,0L5,1L3,1L3,5L2,5L2,1L0,1Z");
        } else if (char == 0x55 || char == 0x75) {
            return bytes("M0,0L1,0L1,4L4,4L4,0L5,0L5,5L1,5L1,4L0,4Z");
        } else if (char == 0x56 || char == 0x76) {
            return bytes("M0,0L1,0L1,2L2,2L2,4L3,4L3,2L4,2L4,0L5,0L5,2L4,2L4,4L3,4L3,5L2,5L2,4L1,4L1,2L0,2Z");
        } else if (char == 0x57 || char == 0x77) {
            return bytes("M0,0L1,0L1,4L2,4L2,3L3,3L3,4L4,4L4,0L5,0L5,4L4,4L4,5L3,5L3,4L2,4L2,5L1,5L1,4L0,4Z");
        } else if (char == 0x58 || char == 0x78) {
            return bytes("M0,0L1,0L1,1L2,1L2,2L3,2L3,1L4,1L4,0L5,0L5,1L4,1L4,2L3,2L3,3L4,3L4,4L5,4L5,5L4,5L4,4L3,4L3,3L2,3L2,4L1,4L1,5L0,5L0,4L1,4L1,3L2,3L2,2L1,2L1,1L0,1Z");
        } else if (char == 0x59 || char == 0x79) {
            return bytes("M0,0L1,0L1,2L4,2L4,0L5,0L5,4L4,4L4,5L0,5L0,4L4,4L4,3L1,3L1,2L0,2Z");
        } else if (char == 0x5a || char == 0x7a) {
            return bytes("M0,0L5,0L5,1L4,1L4,2L3,2L3,3L2,3L2,4L5,4L5,5L0,5L0,4L1,4L1,3L2,3L2,2L3,2L3,1L0,1Z");
        }

        return bytes("");
    }
}

