// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "openzeppelin-contracts/access/Ownable.sol";

contract HeraToken is ERC20("HeraToken", "HERA"), Ownable {

    uint256 initialSupply = 100000000000000000;

    constructor() {
        address fromaddress = address(this);
        for (uint256 i = 0; i < 10; i++) {
            mint(fromaddress, initialSupply);
        }
    }

    function transfer(
        address _to,
        uint256 _amount
    )
        public  override
        returns (bool)
    {
        _transfer(address(this), _to, _amount);
        return true;
    }

    function mint(address account, uint256 amount) public onlyOwner {
        ERC20._mint(account, amount);
    }

    function burn(address account, uint256 amount) public onlyOwner {
        ERC20._burn(account, amount);
    }

}
