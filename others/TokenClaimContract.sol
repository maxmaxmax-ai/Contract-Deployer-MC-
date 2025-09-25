// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/security/ReentrancyGuard.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract TokenClaimContract is ReentrancyGuard, Ownable {
    IERC20 private _token; // Instance of the ERC20 token contract
    uint256 public claimFee = 0.00003 ether; // Fee required to claim tokens
    mapping(address => bool) public claimed; // To track claimed status
    
    event TokensClaimed(address indexed claimer, address indexed referrer);

    constructor(address tokenAddress) Ownable() {
        _token = IERC20(tokenAddress);
    }

    // Function to claim tokens
    function claim(address referrer) external payable nonReentrant {
        require(!claimed[msg.sender], "Already claimed");
        require(msg.value == claimFee, "Incorrect claim fee");

        // Transfer tokens to the claimer
        require(_token.balanceOf(address(this)) >= 1 ether, "Contract has insufficient tokens");
        require(_token.transfer(msg.sender, 1 ether), "Token transfer failed");

        // Transfer ETH to the referrer
        (bool success, ) = payable(referrer).call{value: claimFee}("");
        require(success, "Failed to send ETH to referrer");

        // Mark the claimer as claimed
        claimed[msg.sender] = true;

        emit TokensClaimed(msg.sender, referrer);
    }

    // Fallback function to receive ETH
    receive() external payable {}

    // Function to withdraw ETH from the contract (only owner)
    function withdrawEth() external onlyOwner {
        payable(owner()).transfer(address(this).balance);
    }

    // Function to withdraw tokens from the contract (only owner)
    function withdrawTokens() external onlyOwner {
        _token.transfer(owner(), _token.balanceOf(address(this)));
    }

    // Function to change the claim fee (only owner)
    function setClaimFee(uint256 _claimFee) external onlyOwner {
        claimFee = _claimFee;
    }

    // Function to change the token address (only owner)
    function setTokenAddress(address tokenAddress) external onlyOwner {
        _token = IERC20(tokenAddress);
    }

    // Function to get the contract balance of tokens
    function contractTokenBalance() external view returns (uint256) {
        return _token.balanceOf(address(this));
    }

    // Function to get the contract balance of ETH
    function contractEthBalance() external view returns (uint256) {
        return address(this).balance;
    }
}
