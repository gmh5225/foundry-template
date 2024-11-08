// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;

import { Address } from "@openzeppelin/contracts/utils/Address.sol";
import { Ownable } from "@openzeppelin/contracts/access/Ownable.sol";
import { ReentrancyGuardTransient } from "@openzeppelin/contracts/utils/ReentrancyGuardTransient.sol";
import { Pausable } from "@openzeppelin/contracts/utils/Pausable.sol";

contract Bank is Ownable, ReentrancyGuardTransient, Pausable {
    address public admin;
    mapping(address => uint256) public balances;
    address[3] public topDepositors;

    // Custom errors
    error DepositTooLow();
    error OnlyAdminCanWithdraw();
    error WithdrawalFailed();

    constructor() Ownable(msg.sender) {
        admin = msg.sender;
    }

    // Receive ETH
    receive() external payable {
        // Call deposit function
        deposit();
    }

    // Pause function
    function pause() external onlyOwner {
        _pause();
    }

    // Unpause function
    function unpause() external onlyOwner {
        _unpause();
    }

    // Deposit function
    function deposit() public payable whenNotPaused nonReentrant {
        // Revert if deposit amount is 0
        if (msg.value == 0) {
            revert DepositTooLow();
        }
        balances[msg.sender] += msg.value;
        updateTopDepositors(msg.sender);
    }

    // Update top 3 depositors
    function updateTopDepositors(address depositor) private {
        uint256 depositAmount = balances[depositor];
        uint256 index = 3;

        for (uint256 i = 0; i < 3; i++) {
            if (depositAmount > balances[topDepositors[i]]) {
                index = i;
                break;
            }
        }

        if (index < 3) {
            for (uint256 i = 2; i > index; i--) {
                topDepositors[i] = topDepositors[i - 1];
            }
            topDepositors[index] = depositor;
        }
    }

    // Withdrawal function (only callable by admin)
    function withdraw(uint256 amount) external whenNotPaused nonReentrant {
        // Revert if caller is not admin
        if (msg.sender != admin) {
            revert OnlyAdminCanWithdraw();
        }
        // If the requested amount is greater than the balance, set amount to the balance
        uint256 balance = address(this).balance;
        amount = amount > balance ? balance : amount;
        if (amount != 0) {
            // Transfer fixedly uses 2300 gas, which may not be enough in some cases
            // payable(admin).transfer(amount);
            Address.sendValue(payable(admin), amount);
        }
    }

    // Query contract balance
    function getBalance() public view returns (uint256) {
        return address(this).balance;
    }

    // Query top 3 depositors
    function getTopDepositors() public view returns (address[3] memory) {
        return topDepositors;
    }

    // Function to get deposit amount for a specific depositor
    function getDepositAmount(address depositor) public view returns (uint256) {
        return balances[depositor];
    }

    // Function to destroy the contract, only callable by owner
    // although "selfdestruct" has been deprecated, it's still used here for compatibility with older contracts
    function destroy(address payable recipient) public onlyOwner {
        selfdestruct(recipient);
    }
}
