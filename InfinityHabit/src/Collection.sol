// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "openzeppelin-contracts/utils/Counters.sol";
import "openzeppelin-contracts/access/Ownable.sol";


contract InfinityHabitNFT is ERC721 ("InfinityHabit", "Hera"), Ownable {

    using Counters for Counters.Counter;
    Counters.Counter internal _tokenIds;

    //TODO set correct value for CoinCount from ERC720; implemented in the constructor function;
    enum Badges {None, Bronze, Silver, Gold}
    
    uint256 coinCount = 50;
    
    string public token_URI;

    uint256[] public badgePrice = [30,65,100];
    string[] public TOKEN_URI_ARRAY = [
        "",
        "https://ipfs.io/ipfs/QmWu3YEauufy8PFgqhdeoxLs75PhDF8woTwgXC9xyQJHAJ", 
        "https://ipfs.io/ipfs/QmUh78gwwdqg58Zv6EQdHFWTN4odidsEF5aTsAe2247ABY",
        "https://ipfs.io/ipfs/QmYZmiRcom5NxruUPeD5K5qKQ6He7biKUHuhraaN9ToCwu"
    ]; 

    Badges public badges;

    // constructor() ERC721("InfinityHabit", "Badge") {
    //     s_tokenCounter = 0;
        //get the Balance of the ERC720 contract? 
        //coinCount = balanceOf(msg.sender);

    // }
    
    function setBaseURI() public onlyOwner {
        //coinCount = balanceOf(msg.sender);

        if (coinCount >= 30 && coinCount < 65) {
            Badges bronze = Badges.Bronze;
            token_URI = TOKEN_URI_ARRAY[uint256(bronze)];
            
        } else if (coinCount >= 65 && coinCount < 100) {
            Badges silver = Badges.Silver;
            token_URI = TOKEN_URI_ARRAY[uint256(silver)];
        } else if (coinCount >= 100) {
            Badges gold = Badges.Gold;
            token_URI = TOKEN_URI_ARRAY[uint256(gold)];
        }

    }

    function mintNft() public payable {
        require(coinCount >= 30, "Sorry, you have insufficient Coins"); 
        _safeMint(msg.sender, _tokenIds.current());
        _tokenIds.increment();
        
        //TODO: tokenCount -30;
        if (coinCount >= 30 && coinCount < 65) {
            balanceOf(msg.sender) - 30;
            payable(msg.sender).transfer(30);
        } else if (coinCount >= 65 && coinCount < 100) {
            balanceOf(msg.sender) - 65;
            payable(msg.sender).transfer(65);
        } else if (coinCount >= 100) {
            balanceOf(msg.sender) - 100;
            payable(msg.sender).transfer(100);
        }
    }

    function tokenURI(uint256 tokenId) public view override returns (string memory) {
        // require(_exists(tokenId), "ERC721Metadata: URI query for nonexistent token");
        return token_URI;
    }
}