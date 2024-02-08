// SPDX-License-Identifier: MIT
pragma solidity >=0.8.2 <0.9.0;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract FinalNft is ERC721, ERC721Enumerable, ERC721URIStorage, Ownable {
    uint256 private _nextTokenId;

    // Mapping to track the number of transfers
    mapping(uint256 => uint256) private _transferCount;

    // Max number of transfers allowed is 5
    uint256 public constant MAX_TRANSFERS = 5;
    //user will transfer 0.01 eth to this owner address
    address payable user= payable(0x5B38Da6a701c568545dCfcB03FcB875f56beddC4);

    constructor(address initialOwner)
        ERC721("5TNFT", "5T")
        Ownable(initialOwner)
    {}

   function safeMint(address to, string memory uri) public onlyOwner {
        uint256 tokenId = _nextTokenId++;
        _safeMint(to, tokenId);
        _setTokenURI(tokenId, uri);
        //To Track transfer count after minting nft 
        _transferCount[tokenId] = 0;
    }
    // Override transfer functions to enforce transfer limit
   function safeTransferFromLimited(address from, address to, uint256 tokenId) public payable {
    // Condition where transfered nft is less then 5 times or user have to pay eth
       require(_transferCount[tokenId] < MAX_TRANSFERS || msg.value >= 0.01 ether, "This token can only be transferred 5 times.");
        // Condition to execute payment after max transfer
          if (_transferCount[tokenId]>= MAX_TRANSFERS) {
            require(msg.value >= 0.01 ether, "Insufficient payment.");
            // Send payment to owner
            user.transfer(0.01 ether);
        }
        _transferCount[tokenId]++;        
        super.safeTransferFrom(from, to, tokenId);
    }






    function _update(address to, uint256 tokenId, address auth)
        internal
        override(ERC721, ERC721Enumerable)
        returns (address)
    {
        return super._update(to, tokenId, auth);
    }

    function _increaseBalance(address account, uint128 value)
        internal
        override(ERC721, ERC721Enumerable)
    {
        super._increaseBalance(account, value);
    }

    function tokenURI(uint256 tokenId)
        public
        view
        override(ERC721, ERC721URIStorage)
        returns (string memory)
    {
        return super.tokenURI(tokenId);
    }

    function supportsInterface(bytes4 interfaceId)
        public
        view
        override(ERC721, ERC721Enumerable, ERC721URIStorage)
        returns (bool)
    {
        return super.supportsInterface(interfaceId);
    }
}

