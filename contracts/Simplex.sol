// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract Simplex is ERC20 {
    constructor() ERC20("Simplex", "SPLX") {
        // 100000 tokens con 18 decimales
        _mint(msg.sender, 100000 * 10 ** decimals());
    }
}
