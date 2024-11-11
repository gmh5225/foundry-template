// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "forge-std/console2.sol";
import "src/Bank.sol";

contract BankTest is Test {
    Bank public bank;

    function setUp() public {
        bank = new Bank(address(this));

        // get code size
        uint256 codeSize;
        address bankAddr = address(bank);
        assembly {
            codeSize := extcodesize(bankAddr)
        }
        console2.log("[before]: codeSize", codeSize);
    }

    // receive function to receive ETH
    receive() external payable { }

    function testDeposit() public {
        address user = makeAddr("user");
        vm.deal(user, 1 ether);
        vm.prank(user);
        bank.deposit{ value: 0.5 ether }();
        assertEq(bank.balances(user), 0.5 ether);
    }

    function testWithdraw() public {
        address bankAdmin = bank.admin();
        vm.deal(address(bankAdmin), 1 ether);
        vm.deal(address(bank), 1 ether);
        uint256 initialBalance = bankAdmin.balance;

        vm.prank(bankAdmin);
        bank.withdraw(1 ether);

        assertEq(bankAdmin.balance, initialBalance + 1 ether);
    }

    function testFailWithdrawNotAdmin() public {
        vm.deal(address(bank), 1 ether);
        vm.prank(makeAddr("user"));
        bank.withdraw(0.5 ether);
    }

    function testDestroy() public {
        // ensure contract has some ETH for testing
        vm.deal(address(bank), 1 ether);

        // create a recipient address
        address payable recipient = payable(makeAddr("recipient"));
        uint256 initialBalance = recipient.balance;

        // record contract's initial balance
        uint256 bankBalance = address(bank).balance;

        // call destroy function
        bank.destroy(recipient);

        // verify:
        // 1. recipient should receive all ETH
        assertEq(recipient.balance, initialBalance + bankBalance);
    }
}
