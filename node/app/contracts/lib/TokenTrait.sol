// SPDX-License-Identifier: MIT
pragma solidity 0.8.4;

import "./Image.sol";
import "./Token.sol";
import "./Validator.sol";
import "@openzeppelin/contracts/utils/Base64.sol";
import "@openzeppelin/contracts/utils/Strings.sol";

library TokenTrait {
    using Strings for uint;

    function generateTokenURI(Token.Token memory token, uint tokenId, bool isPresent) external pure returns (string memory) {
        bytes memory result;

        bytes memory svg = Image.generateSVG(getYear(token), getMonth(token), getDayOfMonth(token), getMessage(token), token.backgroundColor, token.dateTextColor, token.messageTextColor, isPresent);

        result = bytes.concat(result, bytes("{"));
        result = bytes.concat(result, bytes("\"name\":\"TheDatesNft #"), bytes(tokenId.toString()), bytes("\","));
        result = bytes.concat(result, bytes("\"image\":\"data:image/svg+xml;base64,"), bytes(Base64.encode(svg)), bytes("\","));
        result = bytes.concat(result, bytes("\"attributes\":["));
        result = bytes.concat(result, bytes("{"));
        result = bytes.concat(result, bytes("\"trait_type\":\"year\","));
        result = bytes.concat(result, bytes("\"value\":\""), bytes(getYear(token)), bytes("\""));
        result = bytes.concat(result, bytes("},"));
        result = bytes.concat(result, bytes("{"));
        result = bytes.concat(result, bytes("\"trait_type\":\"month_and_day\","));
        result = bytes.concat(result, bytes("\"value\":\""), bytes.concat(bytes(getMonth(token)), bytes(getDayOfMonth(token))), bytes("\""));
        result = bytes.concat(result, bytes("}"));
        result = bytes.concat(result, bytes("]"));
        result = bytes.concat(result, bytes("}"));

        return string(result);
    }

    function getYear(Token.Token memory token) public pure returns (string memory) {
        bytes memory date = bytes(token.date);

        if (date.length < 8) {
            return "-";
        }

        bytes memory result = new bytes(4);

        for (uint index = 0; index < result.length; index++) {
            result[index] = date[index];
        }

        return string(result);
    }

    function getMonth(Token.Token memory token) public pure returns (string memory) {
        bytes memory date = bytes(token.date);

        if (date.length < 8) {
            return "-";
        }

        bytes memory result = new bytes(2);

        for (uint index = 0; index < result.length; index++) {
            result[index] = date[index + 4];
        }

        return string(result);
    }

    function getDayOfMonth(Token.Token memory token) public pure returns (string memory) {
        bytes memory date = bytes(token.date);

        if (date.length < 8) {
            return "-";
        }

        bytes memory result = new bytes(2);

        for (uint index = 0; index < result.length; index++) {
            result[index] = date[index + 6];
        }

        return string(result);
    }

    function getMessage(Token.Token memory token) public pure returns (string memory) {
        bytes memory messageBytes = bytes(token.message);

        bytes memory result = new bytes(50);

        for (uint index = 0; index < result.length; index++) {
            if (messageBytes.length > index) {
                result[index] = messageBytes[index];
            } else {
                result[index] = 0x20;
            }
        }

        return string(result);
    }

    function setDate(Token.Token storage token, string memory date) external {
        require(!Validator.validateDateString(token.date), "The date has been already set.");
        require(Validator.validateDateString(date), "Invalid date string format. It should be like yyyyMMdd");

        token.date = date;
    }

    function setMessage(Token.Token storage token, string memory message) external {
        bytes memory messageBytes = bytes(message);
        bytes memory resultBytes = new bytes(50);

        for (uint index = 0; index < resultBytes.length; index++) {
            if (messageBytes.length < index + 1) {
                resultBytes[index] = 0x20;
            } else {
                bytes1 char = messageBytes[index];

                bool isValid = false;

                isValid = isValid || (char == 0x20 || char == 0x21 || char == 0x27 || char == 0x2c || char == 0x2e || char == 0x3f);
                isValid = isValid || (char == 0x30 || char == 0x31 || char == 0x32 || char == 0x33 || char == 0x34 || char == 0x35 || char == 0x36 || char == 0x37 || char == 0x38 || char == 0x39);
                isValid = isValid || (char == 0x41 || char == 0x42 || char == 0x43 || char == 0x44 || char == 0x45 || char == 0x46 || char == 0x47 || char == 0x48 || char == 0x49 || char == 0x4a || char == 0x4b || char == 0x4c || char == 0x4d || char == 0x4e || char == 0x4f || char == 0x50 || char == 0x51 || char == 0x52 || char == 0x53 || char == 0x54 || char == 0x55 || char == 0x56 || char == 0x57 || char == 0x58 || char == 0x59 || char == 0x5a);
                isValid = isValid || (char == 0x61 || char == 0x62 || char == 0x63 || char == 0x64 || char == 0x65 || char == 0x66 || char == 0x67 || char == 0x68 || char == 0x69 || char == 0x6a || char == 0x6b || char == 0x6c || char == 0x6d || char == 0x6e || char == 0x6f || char == 0x70 || char == 0x71 || char == 0x72 || char == 0x73 || char == 0x74 || char == 0x75 || char == 0x76 || char == 0x77 || char == 0x78 || char == 0x79 || char == 0x7a);

                if (!isValid) {
                    char = 0x20;
                }

                resultBytes[index] = char;
            }
        }

        token.message = string(resultBytes);
    }

    function setMessageWriter(Token.Token storage token, address messageWriter) external {
        require(messageWriter != address(0), "Unable to set message writer to address 0.");

        token.messageWriter = messageWriter;
    }

    function setBackgroundColor(Token.Token storage token, string memory colorString) external {
        require(Validator.validateColorString(colorString), "Invalid color string format. It should be like #ff3366");

        token.backgroundColor = colorString;
    }

    function setDateTextColor(Token.Token storage token, string memory colorString) external {
        require(Validator.validateColorString(colorString), "Invalid color string format. It should be like #ff3366");

        token.dateTextColor = colorString;
    }

    function setMessageTextColor(Token.Token storage token, string memory colorString) external {
        require(Validator.validateColorString(colorString), "Invalid color string format. It should be like #ff3366");

        token.messageTextColor = colorString;
    }
}


