pragma solidity ^0.6.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract ERC20FixedSupply is ERC20 {
    constructor() public ERC20("Fixed", "FIX") {
        _mint(msg.sender, 1000000000000000000000);
    }
}
