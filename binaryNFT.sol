// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract BinaryNFT {
    string public name = "BinaryNFT";
    string public symbol = "BNFT";

    uint256 public tokenCounter = 0;

    struct NFT {
        address owner;
        string tokenURI;
    }

    mapping(uint256 => NFT) public tokens;
    mapping(address => uint256[]) public ownerToTokens;

    event Minted(address indexed owner, uint256 indexed tokenId, string tokenURI);

    function mint(string memory _tokenURI) public returns (uint256) {
        uint256 newTokenId = tokenCounter;
        tokens[newTokenId] = NFT(msg.sender, _tokenURI);
        ownerToTokens[msg.sender].push(newTokenId);
        tokenCounter += 1;

        emit Minted(msg.sender, newTokenId, _tokenURI);
        return newTokenId;
    }

    function getMyTokens() public view returns (uint256[] memory) {
        return ownerToTokens[msg.sender];
    }

    function getTokenURI(uint256 _tokenId) public view returns (string memory) {
        require(tokens[_tokenId].owner != address(0), "Token does not exist");
        return tokens[_tokenId].tokenURI;
    }

    function getOwner(uint256 _tokenId) public view returns (address) {
        require(tokens[_tokenId].owner != address(0), "Token does not exist");
        return tokens[_tokenId].owner;
    }
}