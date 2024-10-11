// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.28;

import "forge-std/Test.sol";
import "src/Bank.sol";

contract BankTest is Test {
    Bank public bank;
    address public admin;
    address public user1;
    address public user2;
    address public user3;

    function setUp() public {
        bank = new Bank();
        admin = bank.admin();
        user1 = address(0x1);
        user2 = address(0x2);
        user3 = address(0x3);
    }

    function testDeposit() public {
        vm.deal(user1, 1 ether);
        vm.prank(user1);
        bank.deposit{ value: 0.5 ether }();
        assertEq(bank.balances(user1), 0.5 ether);
    }

    function testTopDepositors() public {
        vm.deal(user1, 1 ether);
        vm.deal(user2, 2 ether);
        vm.deal(user3, 3 ether);

        vm.prank(user1);
        bank.deposit{ value: 0.5 ether }();
        vm.prank(user2);
        bank.deposit{ value: 1 ether }();
        vm.prank(user3);
        bank.deposit{ value: 1.5 ether }();

        address[3] memory topDepositors = bank.getTopDepositors();
        assertEq(topDepositors[0], user3);
        assertEq(topDepositors[1], user2);
        assertEq(topDepositors[2], user1);
    }

    // function testWithdraw() public {
    //     address bankAdmin = bank.admin();
    //     vm.deal(address(bank), 1 ether);
    //     uint256 initialBalance = bankAdmin.balance;

    //     vm.prank(bankAdmin);
    //     bank.withdraw(0.5 ether);

    //     assertEq(bankAdmin.balance, initialBalance + 0.5 ether);
    // }

    function testFailWithdrawNotAdmin() public {
        vm.deal(address(bank), 1 ether);
        vm.prank(user1);
        bank.withdraw(0.5 ether);
    }
}
