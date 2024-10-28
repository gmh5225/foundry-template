// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "src/Bank.sol";

contract BankTest is Test {
    Bank public bank;

    function setUp() public {
        bank = new Bank();
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

    function testTopDepositors() public {
        address user1 = makeAddr("user1");
        address user2 = makeAddr("user2");
        address user3 = makeAddr("user3");

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

    // // test destroy function
    // function testDestroy() public {
    //     vm.prank(bank.owner());
    //     bank.destroy(payable(bank.owner()));
    // }
}
