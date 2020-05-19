pragma solidity ^0.6.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract ERC20WithAutoMinerReward is ERC20 {
    constructor() public ERC20("Auto Miner Reward", "ARWD") {
      _mint(msg.sender, 1000000000000000000000);
    }

    function _mintMinerReward() internal {
        _mint(block.coinbase, 1000000000000000000);
    }

    function _transfer(address from, address to, uint256 value) internal override {
        _mintMinerReward();
        super._transfer(from, to, value);
    }
}
