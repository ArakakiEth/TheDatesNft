// SPDX-License-Identifier: MIT
pragma solidity 0.8.4;

import "./utils/Color.sol";
import "./utils/Date.sol";
import "./utils/Image.sol";
import "./utils/Message.sol";
import "./utils/Number.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import "@openzeppelin/contracts/utils/Base64.sol";
import "@openzeppelin/contracts/utils/Strings.sol";

import "hardhat/console.sol";

contract TheDatesNft is ERC721Enumerable, Ownable {
    address private _contractOwner;

    bool private _isClaimable;

    uint private _currentTokenId;

    mapping(uint => string) private _tokenIdDateMap;
    mapping(string => uint) private _dateTokenIdMap;

    mapping(uint => string) private _tokenIdMessageMap;
    mapping(uint => address) private _tokenIdMessageWriterMap;

    mapping(uint => string[3]) private _tokenIdColorsMap;

    constructor() ERC721("The Dates", "DTS") {
        _contractOwner = _msgSender();

        _isClaimable = false;

        _currentTokenId = 0;
    }

    function tokenURI(uint tokenId) public view override returns (string memory) {
        require(_exists(tokenId), "ERC721Metadata: URI query for nonexistent token");

        bytes memory year = bytes("-");
        bytes memory month = bytes("-");
        bytes memory dayOfMonth = bytes("-");

        bytes memory _date = bytes(_tokenIdDateMap[tokenId]);

        if (_date.length == 8) {
            year = bytes.concat(bytes(""), _date[0]);
            year = bytes.concat(year, _date[1]);
            year = bytes.concat(year, _date[2]);
            year = bytes.concat(year, _date[3]);

            month = bytes.concat(bytes(""), _date[4]);
            month = bytes.concat(month, _date[5]);

            dayOfMonth = bytes.concat(bytes(""), _date[6]);
            dayOfMonth = bytes.concat(dayOfMonth, _date[7]);
        }

        bytes memory json;

        json = bytes.concat(json, bytes("{"));
        json = bytes.concat(json, bytes("\"name\":\"TheDatesNft #"), Number.uintToStringBytes(tokenId), bytes("\","));
        json = bytes.concat(json, bytes("\"image\":\"data:image/svg+xml;base64,"), bytes(Base64.encode(Image.generateSVG())), bytes("\","));
        json = bytes.concat(json, bytes("\"attributes\":["));
        json = bytes.concat(json, bytes("{"));
        json = bytes.concat(json, bytes("\"trait_type\":\"year\","));
        json = bytes.concat(json, bytes("\"value\":\""), year, bytes("\""));
        json = bytes.concat(json, bytes("},"));
        json = bytes.concat(json, bytes("{"));
        json = bytes.concat(json, bytes("\"trait_type\":\"month\","));
        json = bytes.concat(json, bytes("\"value\":\""), month, bytes("\""));
        json = bytes.concat(json, bytes("},"));
        json = bytes.concat(json, bytes("{"));
        json = bytes.concat(json, bytes("\"trait_type\":\"day_of_month\","));
        json = bytes.concat(json, bytes("\"value\":\""), dayOfMonth, bytes("\""));
        json = bytes.concat(json, bytes("}"));
        json = bytes.concat(json, bytes("]"));
        json = bytes.concat(json, bytes("}"));

        return string(json);
    }

    function currentTokenId() external view returns (uint) {
        return _currentTokenId;
    }

    function date(uint tokenId) external view returns (string memory) {
        return _tokenIdDateMap[tokenId];
    }

    function message(uint tokenId) external view returns (string memory) {
        return _tokenIdMessageMap[tokenId];
    }

    function messageWriter(uint tokenId) external view returns (address) {
        return _tokenIdMessageWriterMap[tokenId];
    }

    function colors(uint tokenId) public view returns (string[3] memory) {
        string[3] memory _colors = _tokenIdColorsMap[tokenId];

        if (_colors.length > 0) {
            return _colors;
        }

        return ["#edc271", "#e9435e", "#edc271"];
    }

    function claim() external {
        require(_msgSender() == owner() || _isClaimable, "The token is not claimable now.");

        _currentTokenId = _currentTokenId + 1;

        _safeMint(_msgSender(), _currentTokenId);
    }

    function isClaimable() external view returns (bool) {
        return _isClaimable;
    }

    function setIsClaimable(bool __isClaimable) external {
        require(_msgSender() == _contractOwner, "This function should be called by contract owner.");

        _isClaimable = __isClaimable;
    }

    function setDate(uint tokenId, string calldata dateString) external {
        require(ownerOf(tokenId) == _msgSender(), "The token is not owned by the address");
        require(keccak256(bytes(_tokenIdDateMap[tokenId])) == keccak256(bytes("")), "The date has been already set.");
        require(_dateTokenIdMap[dateString] == 0, "The date has already been taken.");
        require(Date.validateDateString(dateString), "Invalid date string format. It should be yyyyMMdd.");

        _tokenIdDateMap[tokenId] = dateString;

        _dateTokenIdMap[dateString] = tokenId;
    }

    function setMessage(uint tokenId, string calldata messageString) external {
        require(ownerOf(tokenId) == _msgSender(), "The token is not owned by the address");

        _tokenIdMessageMap[tokenId] = Message.normalizeMessageString(messageString);

        _tokenIdMessageWriterMap[tokenId] = _msgSender();
    }

    function setColors(uint tokenId, string[] calldata _colors) external {
        string[] memory __colors;

        if (_colors.length >= 1) {
            Color.validateColorString(_colors[0]);
        }
    }
}

