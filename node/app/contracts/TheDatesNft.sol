// SPDX-License-Identifier: MIT
pragma solidity 0.8.4;

import "./lib/Token.sol";
import "./lib/TokenTrait.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";

contract TheDatesNft is ERC721Enumerable, Ownable {
    using TokenTrait for Token.Token;

    uint private _currentTokenId;

    bool private _isClaimable;

    mapping(string => uint) private _dateTokenIdMap;

    mapping(uint => Token.Token) private _tokenIdTokenMap;

    constructor() ERC721("TheDatesNft", "TDN") {
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

        _currentTokenId = _currentTokenId + 1;

        _tokenIdTokenMap[_currentTokenId] = token;

        _safeMint(_msgSender(), _currentTokenId);
    }

    function tokenURI(uint tokenId) public view override returns (string memory) {
        require(_exists(tokenId), "ERC721Metadata: URI query for nonexistent token");

        Token.Token memory token = _tokenIdTokenMap[tokenId];

        bool isPresent = (token.messageWriter != address(0)) && (token.messageWriter != ownerOf(tokenId));

        return token.generateTokenURI(tokenId, isPresent);
    }

    function getCurrentTokenId() external view returns (uint) {
        return _currentTokenId;
    }

    function setIsClaimable(bool __isClaimable) external {
        require(_msgSender() == owner(), "This function should be called by contract owner.");

        _isClaimable = __isClaimable;
    }

    function getDate(uint tokenId) external view returns (string memory) {
        Token.Token memory token = _tokenIdTokenMap[tokenId];

        return token.date;
    }

    function setDate(uint tokenId, string calldata date) external {
        require(_msgSender() == ownerOf(tokenId), "The token is not owned by the address.");
        require(_dateTokenIdMap[date] == 0, "The date has already been taken.");

        Token.Token storage token = _tokenIdTokenMap[tokenId];

        token.setDate(date);

        _dateTokenIdMap[date] = tokenId;
    }

    function getMessage(uint tokenId) external view returns (string memory) {
        Token.Token memory token = _tokenIdTokenMap[tokenId];

        return token.getMessage();
    }

    function setMessage(uint tokenId, string calldata message) external {
        Token.Token storage token = _tokenIdTokenMap[tokenId];

        token.setMessage(message);

        token.setMessageWriter(_msgSender());
    }

    function setColors(uint tokenId, string[3] memory colors) external {
        Token.Token storage token = _tokenIdTokenMap[tokenId];

        token.setBackgroundColor(colors[0]);
        token.setDateTextColor(colors[1]);
        token.setMessageTextColor(colors[2]);
    }

    function getColors(uint tokenId) external view returns (string[3] memory) {
        Token.Token memory token = _tokenIdTokenMap[tokenId];

        string[3] memory colors;

        colors[0] = token.backgroundColor;
        colors[1] = token.dateTextColor;
        colors[2] = token.messageTextColor;

        return colors;
    }
}

