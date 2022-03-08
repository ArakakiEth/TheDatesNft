// SPDX-License-Identifier: MIT
pragma solidity 0.8.4;

import "./lib/Token.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import "@openzeppelin/contracts/utils/Strings.sol";

import "hardhat/console.sol";

// library ColorLib {
//     function setBackgroundColor(Token memory token, string memory colorString) external {
//         require(_validateColorString(colorString), "Invalid color string format. It should be like #ff3366");
// 
//         token.backgroundColor = colorString;
//     }
// 
//     function setDateTextColor(Token memory token, string memory colorString) external {
//         require(_validateColorString(colorString), "Invalid color string format. It should be like #ff3366");
// 
//         token.dateTextColor = colorString;
//     }
// 
//     function setMessageTextColor(Token memory token, string memory colorString) external {
//         require(_validateColorString(colorString), "Invalid color string format. It should be like #ff3366");
// 
//         token.messageTextColor = colorString;
//     }
// 
//     function _validateColorString(string memory colorString) private pure returns (bool) {
//         bytes memory colorStringBytes = bytes(colorString);
// 
//         if (colorStringBytes.length != 7) {
//             return false;
//         }
// 
//         if (colorStringBytes[0] != 0x23) {
//             return false;
//         }
// 
//         for (uint index = 1; index < 7; index++) {
//             bytes1 char = colorStringBytes[index];
// 
//             bool isValid = false;
// 
//             isValid = isValid || (char == 0x30 || char == 0x31 || char == 0x32 || char == 0x33 || char == 0x34 || char == 0x35 || char == 0x36 || char == 0x37 || char == 0x38 || char == 0x39);
//             isValid = isValid || (char == 0x61 || char == 0x62 || char == 0x63 || char == 0x64 || char == 0x65 || char == 0x66);
// 
//             if (!isValid) {
//                 return false;
//             }
//         }
// 
//         return true;
//     }
// }

contract TheDatesNft is ERC721Enumerable, Ownable {
    address private _contractOwner;

    bool private _isClaimable;

    uint private _currentTokenId;

    mapping(string => uint) private _dateTokenIdMap;

    mapping(uint => Token.Token) private _tokenIdTokenMap;

    constructor() ERC721("The Dates", "DTS") {
        _contractOwner = _msgSender();

        _isClaimable = false;

        _currentTokenId = 0;
    }

    function claim() external {
        require(_msgSender() == owner() || _isClaimable, "The token is not claimable now.");

        Token.Token memory token = Token.Token({
            date: "",
            message: "",
            messageWriter: address(0),
            backgroundColor: "#edc271",
            dateTextColor: "#e9435e",
            messageTextColor: "#6868ac"
        });

        _tokenIdTokenMap[_currentTokenId] = token;

        _safeMint(_msgSender(), _currentTokenId);

        _currentTokenId = _currentTokenId + 1;
    }

    function getToken(uint tokenId) external view returns (Token.Token memory) {
       Token.Token memory token = _tokenIdTokenMap[tokenId];

       return token;
    }

    // function setColors(uint tokenId, string[3] memory _colors) external {
    //     Token memory token = _tokenIdTokenMap[tokenId];

    //     token.setBackgroundColor(_colors[0]);
    //     token.setDateTextColor(_colors[0]);
    //     token.setMessageTextColor(_colors[0]);

    //     console.logString(token.backgroundColor);
    //     console.logString(token.dateTextColor);
    //     console.logString(token.messageTextColor);

    //     _tokenIdTokenMap[tokenId] = token;
    // }
}

