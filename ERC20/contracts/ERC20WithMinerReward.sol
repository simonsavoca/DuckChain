pragma solidity ^0.6.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract ERC20WithMinerReward is ERC20 {
    constructor() public ERC20("Miner Reward", "RWD") {
      _mint(msg.sender, 1000000000000000000000);
    }

    function mintMinerReward() public {
        _mint(block.coinbase, 1000000000000000000);
    }
}
