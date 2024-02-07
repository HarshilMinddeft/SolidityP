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
    uint256 public constant MAX_TRANSFERS = 5;

    // Mapping to track the number of transfers for each token ID
    mapping(uint256 => mapping(address => uint256)) private _transferCount;

    constructor(address initialOwner) ERC1155("ipfs://QmXT1U6Q11i1cPouzcKWbzAyZBb78nmxEtNQMx5ioh2wtf/{id}.json") Ownable(initialOwner) {
        _mint(msg.sender, SOVA, 10, "");
        _mint(msg.sender, BRIMSTON, 10, "");
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
 
    // Override safeTransferFrom to enforce limited transfers after minting
    function safeTransferFrom(address from, address to, uint256 id, uint256 value, bytes memory data) public override virtual {
        address sender = _msgSender();
         require(_transferCount[id][sender] < MAX_TRANSFERS, "max limit.");
        require(from == sender || to == sender, "This is a Soulbound token. It can only be transferred by or to the owner.");
        _safeTransferFrom(from, to, id, value, data);
        _transferCount[id][sender]++;
    }

    // Override safeBatchTransferFrom to enforce limited transfers after minting
    function safeBatchTransferFrom(address from, address to, uint256[] memory ids, uint256[] memory values, bytes memory data) public override virtual {
        address sender = _msgSender();
        for (uint256 i = 0; i < ids.length; i++) {
            require(_transferCount[ids[i]][sender] < MAX_TRANSFERS, "Max limit reached.");
        }
        require(from == sender || to == sender, "This is a Soulbound token. It can only be transferred by or to the owner.");
        _safeBatchTransferFrom(from, to, ids, values, data);
        for (uint256 i = 0; i < ids.length; i++) {
            _transferCount[ids[i]][sender]++;
        }
    }
      function _update(address from, address to, uint256[] memory ids, uint256[] memory values)
        internal
        override(ERC1155, ERC1155Supply)
    {
        super._update(from, to, ids, values);
    }
}
