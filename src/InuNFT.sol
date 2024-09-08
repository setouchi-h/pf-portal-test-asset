// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {ERC721} from "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import {Base64} from "@openzeppelin/contracts/utils/Base64.sol";
import {Strings} from "@openzeppelin/contracts/utils/Strings.sol";

contract InuNFT is ERC721 {
    using Strings for uint256;

    uint256 private s_nextTokenId;

    constructor() ERC721("Inu NFT", "INU") {}

    function safeMint(address to) public {
        uint256 tokenId = ++s_nextTokenId;
        _safeMint(to, tokenId);
    }

    function _baseURI() internal pure override returns (string memory) {
        return "https://gateway.pinata.cloud/ipfs/QmRFSriVNbyuiXzH1ieTaWrgAUJcRaTNGvf9VaJYMCpoig/";
    }

    function tokenURI(uint256 tokenId) public view override returns (string memory) {
        _requireOwned(tokenId);
        return string(abi.encodePacked(_baseURI(), tokenId.toString(), ".json"));
    }
}
