// SPDX-License-Identifier: MIT
pragma solidity 0.8.4;

library Validator {
    function validateDateString(string calldata dateString) external pure returns (bool) {
        bytes memory dateStringBytes = bytes(dateString);

        if (dateStringBytes.length != 8) {
          return false;
        }

        bytes1 y1 = dateStringBytes[0];
        bytes1 y2 = dateStringBytes[1];
        bytes1 y3 = dateStringBytes[2];
        bytes1 y4 = dateStringBytes[3];

        bytes2 M;
        M = M | dateStringBytes[4];
        M = M | (bytes2(dateStringBytes[5]) >> 8);

        bytes2 d;
        d = d | dateStringBytes[6];
        d = d | (bytes2(dateStringBytes[7]) >> 8);

        bool result = true;

        result = result && (y1 == 0x30 || y1 == 0x31 || y1 == 0x32);
        result = result && (y2 == 0x30 || y2 == 0x31 || y2 == 0x32 || y2 == 0x33 || y2 == 0x34 || y2 == 0x35 || y2 == 0x36 || y2 == 0x37 || y2 == 0x38 || y2 == 0x39);
        result = result && (y3 == 0x30 || y3 == 0x31 || y3 == 0x32 || y3 == 0x33 || y3 == 0x34 || y3 == 0x35 || y3 == 0x36 || y3 == 0x37 || y3 == 0x38 || y3 == 0x39);
        result = result && (y4 == 0x30 || y4 == 0x31 || y4 == 0x32 || y4 == 0x33 || y4 == 0x34 || y4 == 0x35 || y4 == 0x36 || y4 == 0x37 || y4 == 0x38 || y4 == 0x39);
        result = result && (M == 0x3031 || M == 0x3032 || M == 0x3033 || M == 0x3034 || M == 0x3035 || M == 0x3036 || M == 0x3037 || M == 0x3038 || M == 0x3039 || M == 0x3130 || M == 0x3131 || M == 0x3132);

        if (!result) {
        } else if (M == 0x3031 || M == 0x3033 || M == 0x3035 || M == 0x3037 || M == 0x3038 || M == 0x3130 || M == 0x3132) {
            result = result && (d == 0x3031 || d == 0x3032 || d == 0x3033 || d == 0x3034 || d == 0x3035 || d == 0x3036 || d == 0x3037 || d == 0x3038 || d == 0x3039 || d == 0x3130 || d == 0x3131 || d == 0x3132 || d == 0x3133 || d == 0x3134 || d == 0x3135 || d == 0x3136 || d == 0x3137 || d == 0x3138 || d == 0x3139 || d == 0x3230 || d == 0x3231 || d == 0x3232 || d == 0x3233 || d == 0x3234 || d == 0x3235 || d == 0x3236 || d == 0x3237 || d == 0x3238 || d == 0x3239 || d == 0x3330 || d == 0x3331);
        } else if (M == 0x3034 || M == 0x3036 || M == 0x3039 || M == 0x3131) {
            result = result && (d == 0x3031 || d == 0x3032 || d == 0x3033 || d == 0x3034 || d == 0x3035 || d == 0x3036 || d == 0x3037 || d == 0x3038 || d == 0x3039 || d == 0x3130 || d == 0x3131 || d == 0x3132 || d == 0x3133 || d == 0x3134 || d == 0x3135 || d == 0x3136 || d == 0x3137 || d == 0x3138 || d == 0x3139 || d == 0x3230 || d == 0x3231 || d == 0x3232 || d == 0x3233 || d == 0x3234 || d == 0x3235 || d == 0x3236 || d == 0x3237 || d == 0x3238 || d == 0x3239 || d == 0x3330);
        } else if (M == 0x3032) {
            uint year;

            for (uint index = 0; index < 4; index++) {
                uint n;

                if (dateStringBytes[index] == 0x31) {
                    n = 1;
                } else if (dateStringBytes[index] == 0x32) {
                    n = 2;
                } else if (dateStringBytes[index] == 0x33) {
                    n = 3;
                } else if (dateStringBytes[index] == 0x34) {
                    n = 4;
                } else if (dateStringBytes[index] == 0x35) {
                    n = 5;
                } else if (dateStringBytes[index] == 0x36) {
                    n = 6;
                } else if (dateStringBytes[index] == 0x37) {
                    n = 7;
                } else if (dateStringBytes[index] == 0x38) {
                    n = 8;
                } else if (dateStringBytes[index] == 0x39) {
                    n = 9;
                }

                year = (year * 10) + n;
            }

            if (year % 100 == 0 || year % 4 != 0) {
                result = result && (d == 0x3031 || d == 0x3032 || d == 0x3033 || d == 0x3034 || d == 0x3035 || d == 0x3036 || d == 0x3037 || d == 0x3038 || d == 0x3039 || d == 0x3130 || d == 0x3131 || d == 0x3132 || d == 0x3133 || d == 0x3134 || d == 0x3135 || d == 0x3136 || d == 0x3137 || d == 0x3138 || d == 0x3139 || d == 0x3230 || d == 0x3231 || d == 0x3232 || d == 0x3233 || d == 0x3234 || d == 0x3235 || d == 0x3236 || d == 0x3237 || d == 0x3238);
            } else {
                result = result && (d == 0x3031 || d == 0x3032 || d == 0x3033 || d == 0x3034 || d == 0x3035 || d == 0x3036 || d == 0x3037 || d == 0x3038 || d == 0x3039 || d == 0x3130 || d == 0x3131 || d == 0x3132 || d == 0x3133 || d == 0x3134 || d == 0x3135 || d == 0x3136 || d == 0x3137 || d == 0x3138 || d == 0x3139 || d == 0x3230 || d == 0x3231 || d == 0x3232 || d == 0x3233 || d == 0x3234 || d == 0x3235 || d == 0x3236 || d == 0x3237 || d == 0x3238 || d == 0x3239);
            }
        }

        return result;
    }

    function validateColorString(string memory colorString) external pure returns (bool) {
        bytes memory colorStringBytes = bytes(colorString);

        if (colorStringBytes.length != 7) {
            return false;
        }

        if (colorStringBytes[0] != 0x23) {
            return false;
        }

        for (uint index = 1; index < 7; index++) {
            bytes1 char = colorStringBytes[index];

            bool isValid = false;

            isValid = isValid || (char == 0x30 || char == 0x31 || char == 0x32 || char == 0x33 || char == 0x34 || char == 0x35 || char == 0x36 || char == 0x37 || char == 0x38 || char == 0x39);
            isValid = isValid || (char == 0x61 || char == 0x62 || char == 0x63 || char == 0x64 || char == 0x65 || char == 0x66);

            if (!isValid) {
                return false;
            }
        }

        return true;
    }
}

