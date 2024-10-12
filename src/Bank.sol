pragma solidity ^0.8.28;

contract Bank {
    address public admin;
    mapping(address => uint256) public balances;
    address[3] public topDepositors;

    // Custom errors
    error DepositTooLow();
    error OnlyAdminCanWithdraw();
    error InsufficientBalance(uint256 requested, uint256 available);

    constructor() {
        admin = msg.sender;
    }

    // Receive ETH
    receive() external payable {
        // Call deposit function
        deposit();
    }

    // Deposit function
    function deposit() public payable {
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
    function withdraw(uint256 amount) external {
        // Revert if caller is not admin
        if (msg.sender != admin) {
            revert OnlyAdminCanWithdraw();
        }
        // Revert if requested amount exceeds balance
        if (amount > address(this).balance) {
            revert InsufficientBalance(amount, address(this).balance);
        }
        payable(admin).transfer(amount);
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
}
