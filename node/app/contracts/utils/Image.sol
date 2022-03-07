// SPDX-License-Identifier: MIT
pragma solidity 0.8.4;

import "./Number.sol";

library Image {
    function generateSVG() external pure returns (bytes memory) {
        bytes memory svgStringBytes;
        
        svgStringBytes = bytes.concat(svgStringBytes, bytes("<svg xmlns=\"http://www.w3.org/2000/svg\" xmlns:xlink=\"http://www.w3.org/1999/xlink\" viewBox=\"0 0 100 100\" width=\"400\" height=\"400\">"));

        svgStringBytes = bytes.concat(svgStringBytes, bytes("<rect x=\"0\" y=\"0\" width=\"100\" height=\"100\" fill=\"#edc271\" />"));

        svgStringBytes = bytes.concat(svgStringBytes, bytes("<g transform=\"translate(4, 8) scale(1.6)\" fill=\"#e9435e\">"));
        svgStringBytes = bytes.concat(svgStringBytes, bytes("<path d=\"M2,0L3,0L3,4L5,4L5,5L0,5L0,4L2,4L2,2L1,2L1,1L2,1Z\" transform=\"translate(0, 0)\" />"));
        svgStringBytes = bytes.concat(svgStringBytes, bytes("<path d=\"M1,0L4,0L4,1L5,1L5,4L4,4L4,5L1,5L1,4L4,4L4,3L1,3L1,2L0,2L0,1L1,1L1,2L4,2L4,1L1,1Z\" transform=\"translate(6, 0)\" />"));
        svgStringBytes = bytes.concat(svgStringBytes, bytes("<path d=\"M1,0L4,0L4,1L5,1L5,2L4,2L4,3L5,3L5,4L4,4L4,5L1,5L1,4L0,4L0,3L1,3L1,4L4,4L4,3L1,3L1,2L0,2L0,1L1,1L1,2L4,2L4,1L1,1Z\" transform=\"translate(12, 0)\" />"));
        svgStringBytes = bytes.concat(svgStringBytes, bytes("<path d=\"M1,0L4,0L4,1L5,1L5,2L4,2L4,3L5,3L5,4L4,4L4,5L1,5L1,4L0,4L0,3L1,3L1,4L4,4L4,3L1,3L1,2L0,2L0,1L1,1L1,2L4,2L4,1L1,1Z\" transform=\"translate(18, 0)\" />"));
        svgStringBytes = bytes.concat(svgStringBytes, bytes("<path d=\"M1,4L3,4L3,5L1,5\" transform=\"translate(24, 0)\" />"));
        svgStringBytes = bytes.concat(svgStringBytes, bytes("</g>"));

        svgStringBytes = bytes.concat(svgStringBytes, bytes("<g transform=\"translate(4, 24) scale(3)\" fill=\"#e9435e\">"));
        svgStringBytes = bytes.concat(svgStringBytes, bytes("<path d=\"M2,0L3,0L3,4L5,4L5,5L0,5L0,4L2,4L2,2L1,2L1,1L2,1Z\" transform=\"translate(0, 0)\" />"));
        svgStringBytes = bytes.concat(svgStringBytes, bytes("<path d=\"M2,0L3,0L3,4L5,4L5,5L0,5L0,4L2,4L2,2L1,2L1,1L2,1Z\" transform=\"translate(6, 0)\" />"));
        svgStringBytes = bytes.concat(svgStringBytes, bytes("<path d=\"M1,4L3,4L3,5L1,5\" transform=\"translate(12, 0)\" />"));
        svgStringBytes = bytes.concat(svgStringBytes, bytes("<path d=\"M2,0L3,0L3,4L5,4L5,5L0,5L0,4L2,4L2,2L1,2L1,1L2,1Z\" transform=\"translate(18, 0)\" />"));
        svgStringBytes = bytes.concat(svgStringBytes, bytes("<path d=\"M2,0L3,0L3,4L5,4L5,5L0,5L0,4L2,4L2,2L1,2L1,1L2,1Z\" transform=\"translate(24, 0)\" />"));
        svgStringBytes = bytes.concat(svgStringBytes, bytes("</g>"));

        svgStringBytes = bytes.concat(svgStringBytes, bytes("<g transform=\"translate(4, 48) scale(1.2)\" fill=\"#6868ac\">"));
        svgStringBytes = bytes.concat(svgStringBytes, bytes("<path d=\"M0,0L1,0L1,3L4,3L4,0L5,0L5,5L4,5L4,4L1,4L1,5L0,5Z\" transform=\"translate(0, 0)\" />"));
        svgStringBytes = bytes.concat(svgStringBytes, bytes("<path d=\"M1,0L5,0L5,5L4,5L4,4L1,4L1,5L0,5L0,1L1,1L1,3L4,3L4,1L1,1\" transform=\"translate(6, 0)\" />"));
        svgStringBytes = bytes.concat(svgStringBytes, bytes("<path d=\"M0,0L4,0L4,1L1,1L1,3L4,3L4,1L5,1L5,3L4,3L4,4L1,4L1,5L0,5Z\" transform=\"translate(12, 0)\" />"));
        svgStringBytes = bytes.concat(svgStringBytes, bytes("<path d=\"M0,0L4,0L4,1L1,1L1,3L4,3L4,1L5,1L5,3L4,3L4,4L1,4L1,5L0,5Z\" transform=\"translate(18, 0)\" />"));
        svgStringBytes = bytes.concat(svgStringBytes, bytes("<path d=\"M0,0L1,0L1,2L4,2L4,0L5,0L5,4L4,4L4,5L0,5L0,4L4,4L4,3L1,3L1,2L0,2Z\" transform=\"translate(24, 0)\" />"));
        svgStringBytes = bytes.concat(svgStringBytes, bytes("<path d=\"\" transform=\"translate(30, 0)\" />"));
        svgStringBytes = bytes.concat(svgStringBytes, bytes("<path d=\"M0,0L4,0L4,1L5,1L5,2L4,2L4,1L1,1L1,2L4,2L4,3L1,3L1,4L4,4L4,3L5,3L5,5L0,5Z\" transform=\"translate(36, 0)\" />"));
        svgStringBytes = bytes.concat(svgStringBytes, bytes("<path d=\"M0,0L3,0L3,1L4,1L4,2L5,2L5,4L4,4L4,2L3,2L3,1L1,1L1,4L4,4L4,5L0,5Z\" transform=\"translate(42, 0)\" />"));
        svgStringBytes = bytes.concat(svgStringBytes, bytes("<path d=\"M1,0L5,0L5,5L4,5L4,4L1,4L1,5L0,5L0,1L1,1L1,3L4,3L4,1L1,1\" transform=\"translate(48, 0)\" />"));
        svgStringBytes = bytes.concat(svgStringBytes, bytes("<path d=\"M0,0L1,0L1,2L4,2L4,0L5,0L5,4L4,4L4,5L0,5L0,4L4,4L4,3L1,3L1,2L0,2Z\" transform=\"translate(54, 0)\" />"));

        svgStringBytes = bytes.concat(svgStringBytes, bytes("<path d=\"M1,0L5,0L5,5L4,5L4,4L1,4L1,5L0,5L0,1L1,1L1,3L4,3L4,1L1,1\" transform=\"translate(0, 8)\" />"));
        svgStringBytes = bytes.concat(svgStringBytes, bytes("<path d=\"M0,0L4,0L4,1L1,1L1,3L4,3L4,1L5,1L5,3L4,3L4,4L5,4L5,5L4,5L4,4L1,4L1,5L0,5Z\" transform=\"translate(6, 8)\" />"));
        svgStringBytes = bytes.concat(svgStringBytes, bytes("<path d=\"M1,0L5,0L5,5L4,5L4,4L1,4L1,5L0,5L0,1L1,1L1,3L4,3L4,1L1,1\" transform=\"translate(12, 8)\" />"));
        svgStringBytes = bytes.concat(svgStringBytes, bytes("<path d=\"M0,0L1,0L1,2L3,2L3,1L4,1L4,0L5,0L5,1L4,1L4,2L3,2L3,3L4,3L4,4L5,4L5,5L4,5L4,4L3,4L3,3L1,3L1,5L0,5Z\" transform=\"translate(18, 8)\" />"));
        svgStringBytes = bytes.concat(svgStringBytes, bytes("<path d=\"M1,0L5,0L5,5L4,5L4,4L1,4L1,5L0,5L0,1L1,1L1,3L4,3L4,1L1,1\" transform=\"translate(24, 8)\" />"));
        svgStringBytes = bytes.concat(svgStringBytes, bytes("<path d=\"M0,0L1,0L1,2L3,2L3,1L4,1L4,0L5,0L5,1L4,1L4,2L3,2L3,3L4,3L4,4L5,4L5,5L4,5L4,4L3,4L3,3L1,3L1,5L0,5Z\" transform=\"translate(30, 8)\" />"));
        svgStringBytes = bytes.concat(svgStringBytes, bytes("<path d=\"M0,0L5,0L5,1L3,1L3,4L5,4L5,5L0,5L0,4L2,4L2,1L0,1Z\" transform=\"translate(36, 8)\" />"));
        svgStringBytes = bytes.concat(svgStringBytes, bytes("<path d=\"M1,4L3,4L3,5L1,5\" transform=\"translate(42, 8)\" />"));
        svgStringBytes = bytes.concat(svgStringBytes, bytes("<path d=\"\" transform=\"translate(48, 8)\" />"));
        svgStringBytes = bytes.concat(svgStringBytes, bytes("<path d=\"\" transform=\"translate(54, 8)\" />"));

        svgStringBytes = bytes.concat(svgStringBytes, bytes("<path d=\"M0,0L1,0L1,1L2,1L2,2L3,2L3,1L4,1L4,0L5,0L5,5L4,5L4,2L3,2L3,3L2,3L2,2L1,2L1,5L0,5Z\" transform=\"translate(0, 16)\" />"));
        svgStringBytes = bytes.concat(svgStringBytes, bytes("<path d=\"M1,0L5,0L5,5L4,5L4,4L1,4L1,5L0,5L0,1L1,1L1,3L4,3L4,1L1,1\" transform=\"translate(6, 16)\" />"));
        svgStringBytes = bytes.concat(svgStringBytes, bytes("<path d=\"M0,0L1,0L1,2L4,2L4,0L5,0L5,4L4,4L4,5L0,5L0,4L4,4L4,3L1,3L1,2L0,2Z\" transform=\"translate(12, 16)\" />"));
        svgStringBytes = bytes.concat(svgStringBytes, bytes("<path d=\"\" transform=\"translate(18, 16)\" />"));
        svgStringBytes = bytes.concat(svgStringBytes, bytes("<path d=\"M1,0L5,0L5,1L1,1L1,4L4,4L4,3L3,3L3,2L5,2L5,5L1,5L1,4L0,4L0,1L1,1Z\" transform=\"translate(24, 16)\" />"));
        svgStringBytes = bytes.concat(svgStringBytes, bytes("<path d=\"M1,0L4,0L4,1L5,1L5,4L4,4L4,5L1,5L1,4L0,4L0,1L1,1L1,4L4,4L4,1L1,1Z\" transform=\"translate(30, 16)\" />"));
        svgStringBytes = bytes.concat(svgStringBytes, bytes("<path d=\"M0,0L3,0L3,1L4,1L4,2L5,2L5,4L4,4L4,2L3,2L3,1L1,1L1,4L4,4L4,5L0,5Z\" transform=\"translate(36, 16)\" />"));
        svgStringBytes = bytes.concat(svgStringBytes, bytes("<path d=\"\" transform=\"translate(42, 16)\" />"));
        svgStringBytes = bytes.concat(svgStringBytes, bytes("<path d=\"\" transform=\"translate(48, 16)\" />"));
        svgStringBytes = bytes.concat(svgStringBytes, bytes("<path d=\"\" transform=\"translate(54, 16)\" />"));

        svgStringBytes = bytes.concat(svgStringBytes, bytes("<path d=\"M1,0L5,0L5,5L4,5L4,4L1,4L1,5L0,5L0,1L1,1L1,3L4,3L4,1L1,1\" transform=\"translate(0, 24)\" />"));
        svgStringBytes = bytes.concat(svgStringBytes, bytes("<path d=\"M0,0L1,0L1,4L5,4L5,5L0,5\" transform=\"translate(6, 24)\" />"));
        svgStringBytes = bytes.concat(svgStringBytes, bytes("<path d=\"M0,0L1,0L1,4L2,4L2,3L3,3L3,4L4,4L4,0L5,0L5,4L4,4L4,5L3,5L3,4L2,4L2,5L1,5L1,4L0,4Z\" transform=\"translate(12, 24)\" />"));
        svgStringBytes = bytes.concat(svgStringBytes, bytes("<path d=\"M1,0L5,0L5,5L4,5L4,4L1,4L1,5L0,5L0,1L1,1L1,3L4,3L4,1L1,1\" transform=\"translate(18, 24)\" />"));
        svgStringBytes = bytes.concat(svgStringBytes, bytes("<path d=\"M0,0L1,0L1,2L4,2L4,0L5,0L5,4L4,4L4,5L0,5L0,4L4,4L4,3L1,3L1,2L0,2Z\" transform=\"translate(24, 24)\" />"));
        svgStringBytes = bytes.concat(svgStringBytes, bytes("<path d=\"M1,0L5,0L5,1L1,1L1,2L4,2L4,3L5,3L5,4L4,4L4,5L0,5L0,4L4,4L4,3L1,3L1,2L0,2L0,1L1,1Z\" transform=\"translate(30, 24)\" />"));
        svgStringBytes = bytes.concat(svgStringBytes, bytes("<path d=\"\" transform=\"translate(36, 24)\" />"));
        svgStringBytes = bytes.concat(svgStringBytes, bytes("<path d=\"\" transform=\"translate(42, 24)\" />"));
        svgStringBytes = bytes.concat(svgStringBytes, bytes("<path d=\"\" transform=\"translate(48, 24)\" />"));
        svgStringBytes = bytes.concat(svgStringBytes, bytes("<path d=\"\" transform=\"translate(54, 24)\" />"));

        svgStringBytes = bytes.concat(svgStringBytes, bytes("<path d=\"M0,0L4,0L4,1L5,1L5,2L4,2L4,1L1,1L1,2L4,2L4,3L1,3L1,4L4,4L4,3L5,3L5,5L0,5Z\" transform=\"translate(0, 32)\" />"));
        svgStringBytes = bytes.concat(svgStringBytes, bytes("<path d=\"M0,0L1,0L1,4L5,4L5,5L0,5Z\" transform=\"translate(6, 32)\" />"));
        svgStringBytes = bytes.concat(svgStringBytes, bytes("<path d=\"M0,0L5,0L5,1L1,1L1,2L3,2L3,3L1,3L1,4L5,4L5,5L0,5Z\" transform=\"translate(12, 32)\" />"));
        svgStringBytes = bytes.concat(svgStringBytes, bytes("<path d=\"M1,0L5,0L5,1L1,1L1,2L4,2L4,3L5,3L5,4L4,4L4,5L0,5L0,4L4,4L4,3L1,3L1,2L0,2L0,1L1,1Z\" transform=\"translate(18, 32)\" />"));
        svgStringBytes = bytes.concat(svgStringBytes, bytes("<path d=\"M1,0L5,0L5,1L1,1L1,2L4,2L4,3L5,3L5,4L4,4L4,5L0,5L0,4L4,4L4,3L1,3L1,2L0,2L0,1L1,1Z\" transform=\"translate(24, 32)\" />"));
        svgStringBytes = bytes.concat(svgStringBytes, bytes("<path d=\"\" transform=\"translate(30, 32)\" />"));
        svgStringBytes = bytes.concat(svgStringBytes, bytes("<path d=\"M0,0L1,0L1,2L4,2L4,0L5,0L5,4L4,4L4,5L0,5L0,4L4,4L4,3L1,3L1,2L0,2Z\" transform=\"translate(36, 32)\" />"));
        svgStringBytes = bytes.concat(svgStringBytes, bytes("<path d=\"M1,0L4,0L4,1L5,1L5,4L4,4L4,5L1,5L1,4L0,4L0,1L1,1L1,4L4,4L4,1L1,1Z\" transform=\"translate(42, 32)\" />"));
        svgStringBytes = bytes.concat(svgStringBytes, bytes("<path d=\"M0,0L1,0L1,4L4,4L4,0L5,0L5,5L1,5L1,4L0,4Z\" transform=\"translate(48, 32)\" />"));
        svgStringBytes = bytes.concat(svgStringBytes, bytes("<path d=\"M1,4L3,4L3,5L1,5\" transform=\"translate(54, 32)\" />"));
        svgStringBytes = bytes.concat(svgStringBytes, bytes("</g>"));
        svgStringBytes = bytes.concat(svgStringBytes, bytes("</svg>"));

        return svgStringBytes;
    }

    function n1() private pure returns (bytes memory) {
        return bytes("M2,0L3,0L3,4L5,4L5,5L0,5L0,4L2,4L2,2L1,2L1,1L2,1Z");
    }
}

