// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts@5.0.1/token/ERC1155/ERC1155.sol";
import "@openzeppelin/contracts@5.0.1/access/Ownable.sol";
import "@openzeppelin/contracts@5.0.1/token/ERC1155/extensions/ERC1155Burnable.sol";
import "@openzeppelin/contracts@5.0.1/token/ERC1155/extensions/ERC1155Supply.sol";
import "@openzeppelin/contracts/utils/Strings.sol";

//0x43eb8BCed3a9b10254070C75fFAf5a7479720EDE contract address
contract Valorant is ERC1155, Ownable, ERC1155Burnable, ERC1155Supply {
     uint256 public constant SOVA = 0;
    uint256 public constant BRIMSTON = 1;

    constructor(address initialOwner) ERC1155("ipfs://QmXT1U6Q11i1cPouzcKWbzAyZBb78nmxEtNQMx5ioh2wtf/{id}.json") Ownable(initialOwner) {
        _mint(msg.sender, SOVA, 1, "");
        _mint(msg.sender, BRIMSTON, 1, "");
      
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

    function mint(address account, uint256 id, uint256 amount, bytes memory data)
        public
        onlyOwner
    {
        
    }
    
    function mintBatch(address to, uint256[] memory ids, uint256[] memory amounts, bytes memory data)
        public
        onlyOwner
    {
        _mintBatch(to, ids, amounts, data);
    }

    // The following functions are overrides required by Solidity.

    function _update(address from, address to, uint256[] memory ids, uint256[] memory values)
        internal
        override(ERC1155, ERC1155Supply)
    {
        super._update(from, to, ids, values);
    }

   function safeTransferFrom(address from, address to, uint256 id, uint256 value, bytes memory data) public override  virtual {
        address sender = _msgSender();
        require(from == address(0) || to == address(0), "This a Soulbound token. It cannot be transferred. It can only be burned by the token owner.");
        if (from != sender && !isApprovedForAll(from, sender)) {
            revert ERC1155MissingApprovalForAll(sender, from);
        }
        _safeTransferFrom(from, to, id, value, data);
    }
     function safeBatchTransferFrom(
        address from,
        address to,
        uint256[] memory ids,
        uint256[] memory values,
        bytes memory data
    ) public virtual override {
        address sender = _msgSender();
         require(from == address(0) || to == address(0), "This a Soulbound token. It cannot be transferred. It can only be burned by the token owner.");
        if (from != sender && !isApprovedForAll(from, sender)) {
            revert ERC1155MissingApprovalForAll(sender, from);
        }
        _safeBatchTransferFrom(from, to, ids, values, data);
    }
}