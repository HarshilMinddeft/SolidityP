// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC1155/ERC1155.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC1155/extensions/ERC1155Burnable.sol";
import "@openzeppelin/contracts/token/ERC1155/extensions/ERC1155Supply.sol";
import "@openzeppelin/contracts/utils/Strings.sol";

contract Valorant is ERC1155, Ownable, ERC1155Burnable, ERC1155Supply {
    uint256 public constant SOVA = 0;
    uint256 public constant BRIMSTON = 1;
    uint256 public constant VIPER = 2;
    uint256 public constant NEON = 3;
    uint256 public constant RAZE = 4;
    uint256 public constant SAGE = 5;
    uint256 public constant ValorantPoints = 6;

    mapping(uint256 => bool) public soulboundTokens;

    constructor(address initialOwner) ERC1155("ipfs://QmXT1U6Q11i1cPouzcKWbzAyZBb78nmxEtNQMx5ioh2wtf/{id}.json") Ownable(initialOwner) {
        _mint(msg.sender, SOVA, 100, "");
        _mint(msg.sender, BRIMSTON, 100, "");
        _mint(msg.sender, VIPER, 100, "");
        _mint(msg.sender, NEON, 88, "");
        _mint(msg.sender, RAZE, 80, "");
        _mint(msg.sender, SAGE, 100, "");
        // Mark certain tokens as soulbound
        soulboundTokens[SOVA] = true;
        soulboundTokens[VIPER] = true;
    }

    function setURI(string memory newuri) public onlyOwner {
        _setURI(newuri);
    }

    function uri(uint256 _tokenId) override public pure returns (string memory) {
        return string(
        abi.encodePacked(
            "ipfs://QmXT1U6Q11i1cPouzcKWbzAyZBb78nmxEtNQMx5ioh2wtf/",
            Strings.toString(_tokenId),
            ".json"
        )
        );
    }

    function mint(address account, uint256 id, uint256 amount, bytes memory data) public onlyOwner {
        _mint(account, id, amount, data);
    }

    function mintBatch(address to, uint256[] memory ids, uint256[] memory amounts, bytes memory data) public onlyOwner {
        _mintBatch(to, ids, amounts, data);
    }

    // Make a token soulbound (non-transferrable)
    function setSoulbound(uint256 id, bool isSoulbound) external onlyOwner {
        soulboundTokens[id] = isSoulbound;
    }

    // Override the transfer functions to enforce soulbound status
    function safeTransferFrom(
        address from,
        address to,
        uint256 id,
        uint256 amount,
        bytes memory data
    ) public override {
        require(!soulboundTokens[id], "Token is soulbound and cannot be transferred");
        super.safeTransferFrom(from, to, id, amount, data);
    }

    function safeBatchTransferFrom(
        address from,
        address to,
        uint256[] memory ids,
        uint256[] memory amounts,
        bytes memory data
    ) public override {
        for (uint256 i = 0; i < ids.length; i++) {
            require(!soulboundTokens[ids[i]], "Token is soulbound and cannot be transferred");
        }
        super.safeBatchTransferFrom(from, to, ids, amounts, data);
    }
     function _update(address from, address to, uint256[] memory ids, uint256[] memory values)
        internal
        override(ERC1155, ERC1155Supply)
    {
        super._update(from, to, ids, values);
    }
}
