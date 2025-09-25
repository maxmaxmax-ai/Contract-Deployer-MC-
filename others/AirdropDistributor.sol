// SPDX-License-Identifier: MIT
//
// █████╗ ██╗██████╗ ██████╗ ██████╗  ██████╗ ██████╗ ██████╗ ██╗███████╗████████╗██████╗ ██╗██████╗ ██╗   ██╗████████╗ ██████╗ ██████╗ 
//██╔══██╗██║██╔══██╗██╔══██╗██╔══██╗██╔═══██╗██╔══██╗██╔══██╗██║██╔════╝╚══██╔══╝██╔══██╗██║██╔══██╗██║   ██║╚══██╔══╝██╔═══██╗██╔══██╗
//███████║██║██████╔╝██║  ██║██████╔╝██║   ██║██████╔╝██║  ██║██║███████╗   ██║   ██████╔╝██║██████╔╝██║   ██║   ██║   ██║   ██║██████╔╝
//██╔══██║██║██╔══██╗██║  ██║██╔══██╗██║   ██║██╔═══╝ ██║  ██║██║╚════██║   ██║   ██╔══██╗██║██╔══██╗██║   ██║   ██║   ██║   ██║██╔══██╗
//██║  ██║██║██║  ██║██████╔╝██║  ██║╚██████╔╝██║     ██████╔╝██║███████║   ██║   ██║  ██║██║██████╔╝╚██████╔╝   ██║   ╚██████╔╝██║  ██║
//╚═╝  ╚═╝╚═╝╚═╝  ╚═╝╚═════╝ ╚═╝  ╚═╝ ╚═════╝ ╚═╝     ╚═════╝ ╚═╝╚══════╝   ╚═╝   ╚═╝  ╚═╝╚═╝╚═════╝  ╚═════╝    ╚═╝    ╚═════╝ ╚═╝  ╚═╝
//____________________________________________________________The Opossum King__________________________________________________________                                                                                                                                    
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/security/ReentrancyGuard.sol";

contract AirdropDistributor is Ownable, ReentrancyGuard {
    using SafeERC20 for IERC20;
    
    address constant SAFE_ADDRESS = 0x096c558a1918e782570Bfa1bAf821Ea5Ec73b89d;

    IERC20 public token;

    uint256 public constant REFERRAL_AMOUNT = 5 * 10**17;
    uint256 public constant CLAIM_AMOUNT = 1 * 10**18;
    uint256 public constant ETH_AMOUNT = 0.00003 ether;
    uint256 public constant MAX_TOKENS_FOR_REFERRALS = 25_000_000 * 10**18; // 25 million tokens for referrals
    uint256 public constant MAX_TOKENS_FOR_CLAIM = 50_000_000 * 10**18; // 50 million tokens for claims

    uint256 public claimedForReferrals;
    uint256 public claimedForUsers;

    mapping(address => address[]) public referrals;
    mapping(address => uint256) public rewards;
    mapping(address => mapping(address => bool)) public hasReferred;
    mapping(address => uint256) public totalClaimedByUser; 

    event Referred(address indexed referrer, address indexed referee);
    event RewardClaimed(address indexed user, uint256 amount);
    event EtherWithdrawn(address indexed to, uint256 amount);

    constructor(address tokenAddress) {
        token = IERC20(tokenAddress);
    }

    function claim(address referrer) external payable nonReentrant {
        require(referrer != address(0), "Invalid referrer");
        require(referrer != msg.sender, "Self-referral is not allowed");
        require(msg.value == ETH_AMOUNT, "Incorrect ETH amount");
        require(claimedForUsers + REFERRAL_AMOUNT <= MAX_TOKENS_FOR_CLAIM, "No more tokens for claim");

        if (!hasReferred[referrer][msg.sender]) {
            referrals[referrer].push(msg.sender);
            hasReferred[referrer][msg.sender] = true;
        }

        rewards[referrer] += REFERRAL_AMOUNT;
        claimedForUsers += CLAIM_AMOUNT;

        totalClaimedByUser[msg.sender] += CLAIM_AMOUNT;

        require(token.balanceOf(address(this)) >= CLAIM_AMOUNT, "Insufficient contract balance");
        token.safeTransfer(msg.sender, CLAIM_AMOUNT);

        emit Referred(referrer, msg.sender);
    }

    function claimRewards() external nonReentrant {
        uint256 reward = rewards[msg.sender];
        require(reward > 0, "No rewards to claim");
        require(claimedForReferrals + reward <= MAX_TOKENS_FOR_REFERRALS, "Not enough tokens left for rewards");

        totalClaimedByUser[msg.sender] += reward;

        rewards[msg.sender] = 0;
        claimedForReferrals += reward;

        require(token.balanceOf(address(this)) >= reward, "Insufficient contract balance");
        token.safeTransfer(msg.sender, reward);

        emit RewardClaimed(msg.sender, reward);
    }

    function getReferrals(address referrer) external view returns (address[] memory) {
        return referrals[referrer];
    }

    function withdrawEther() external onlyOwner nonReentrant {
        
        uint256 balance = address(this).balance;
        require(balance > 0, "No funds to withdraw");

        require(SAFE_ADDRESS != address(0), "Invalid safe address");

        (bool success, ) = SAFE_ADDRESS.call{value: balance}("");
        require(success, "Transfer failed");

        emit EtherWithdrawn(SAFE_ADDRESS, balance);
    }


    receive() external payable {
        revert("Use the claim function to send ETH");
    }
}
