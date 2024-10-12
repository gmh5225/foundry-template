// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.28;

import "forge-std/Script.sol";
import "forge-std/console2.sol";
import "src/Bank.sol";

contract BankInteractScript is Script {
    Bank public bank;
    address public user1;
    address public user2;

    function setUp() public {
        user1 = vm.addr(1); // Use vm.addr to generate the address
        user2 = vm.addr(2);
    }

    function run() public {
        uint256 deployerPrivateKey = vm.envUint("WALLET_PRIVATE_KEY");
        address deployer = vm.addr(deployerPrivateKey);

        // Query deployer wallet balance before operations
        uint256 deployerBalance = deployer.balance;
        console2.log(
            "Deployer wallet balance before operations: %s.%s ETH",
            deployerBalance / 1e18,
            (deployerBalance % 1e18) / 1e14
        );

        vm.startBroadcast(deployerPrivateKey);

        // Deploy Bank contract (new creation here)
        bank = new Bank();
        console2.log("Bank contract deployed at address:", address(bank));

        // Deposit
        bank.deposit{ value: 1 ether }();
        console2.log("Deployer deposited 1 ETH");

        vm.stopBroadcast();

        // Query deployer wallet balance after deposit
        deployerBalance = deployer.balance;
        console2.log(
            "Deployer wallet balance after deposit: %s.%s ETH", deployerBalance / 1e18, (deployerBalance % 1e18) / 1e14
        );

        // Deposit from user1
        vm.broadcast(vm.envUint("USER1_PRIVATE_KEY"));
        bank.deposit{ value: 2 ether }();
        console2.log("User1 deposited 2 ETH");

        // Deposit from user2
        vm.broadcast(vm.envUint("USER2_PRIVATE_KEY"));
        bank.deposit{ value: 3 ether }();
        console2.log("User2 deposited 3 ETH");

        // Query balance
        uint256 balance = bank.getBalance();
        console2.log("Contract balance: %s.%s ETH", balance / 1e18, (balance % 1e18) / 1e14);

        // Query top 3 depositors
        address[3] memory topDepositors = bank.getTopDepositors();
        console2.log("Top 3 depositors:");
        for (uint256 i = 0; i < 3; i++) {
            uint256 depositAmount = bank.getDepositAmount(topDepositors[i]);
            console2.log("%s: %s", i + 1, topDepositors[i]);
            console2.log("depositAmount: %s.%s ETH", depositAmount / 1e18, (depositAmount % 1e18) / 1e14);
        }

        // Withdraw (only admin can operate)
        vm.broadcast(deployerPrivateKey);
        try bank.withdraw(0.5 ether) {
            console2.log("Successfully withdrawn 0.5 ETH");
        } catch {
            console2.log("Withdrawal failed");
        }

        // Query deployer wallet balance after all operations
        deployerBalance = deployer.balance;
        console2.log(
            "Deployer wallet balance after all operations: %s.%s ETH",
            deployerBalance / 1e18,
            (deployerBalance % 1e18) / 1e14
        );

        // Query balance again
        balance = bank.getBalance();
        console2.log("Contract balance after withdrawal: %s.%s ETH", balance / 1e18, (balance % 1e18) / 1e14);

        // Query top 3 depositors again
        console2.log("Top 3 depositors after withdrawal:");
        for (uint256 i = 0; i < 3; i++) {
            uint256 depositAmount = bank.getDepositAmount(topDepositors[i]);
            console2.log("%s: %s", i + 1, topDepositors[i]);
            console2.log("depositAmount: %s.%s ETH", depositAmount / 1e18, (depositAmount % 1e18) / 1e14);
        }
    }
}

// == Logs ==
//   Deployer wallet balance before operations: 9995.9988 ETH
//   Bank contract deployed at address: 0x09635F643e140090A9A8Dcd712eD6285858ceBef
//   Deployer deposited 1 ETH
//   Deployer wallet balance after deposit: 9994.9988 ETH
//   User1 deposited 2 ETH
//   User2 deposited 3 ETH
//   Contract balance: 6.0 ETH
//   Top 3 depositors:
//   1: 0x3C44CdDdB6a900fa2b585dd299e03d12FA4293BC
//   depositAmount: 3.0 ETH
//   2: 0x70997970C51812dc3A010C7d01b50e0d17dc79C8
//   depositAmount: 2.0 ETH
//   3: 0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266
//   depositAmount: 1.0 ETH
//   Successfully withdrawn 0.5 ETH
//   Deployer wallet balance after all operations: 9995.4988 ETH
//   Contract balance after withdrawal: 5.5000 ETH
//   Top 3 depositors after withdrawal:
//   1: 0x3C44CdDdB6a900fa2b585dd299e03d12FA4293BC
//   depositAmount: 3.0 ETH
//   2: 0x70997970C51812dc3A010C7d01b50e0d17dc79C8
//   depositAmount: 2.0 ETH
//   3: 0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266
//   depositAmount: 1.0 ETH

// ## Setting up 1 EVM.

// ==========================

// Chain 31337

// Estimated gas price: 0.007745005 gwei

// Estimated total gas used for script: 899727

// Estimated amount required: 0.000006968390113635 ETH

// ==========================

// ##### anvil-hardhat
// ✅  [Success]Hash: 0x6748f431dad7610edda4a987e129f48d0e5173e127ba69a7b380257b2b03b74f
// Contract Address: 0x09635F643e140090A9A8Dcd712eD6285858ceBef
// Block: 44
// Paid: 0.000001361385699392 ETH (401656 gas * 0.003389432 gwei)

// ##### anvil-hardhat
// ✅  [Success]Hash: 0x5b075dd8a5aa2b3b460c72677bdcf6aeb9a4c2d0f288e4f7c22d941070d66e90
// Block: 45
// Paid: 0.000000219165097083 ETH (73617 gas * 0.002977099 gwei)

// ##### anvil-hardhat
// ✅  [Success]Hash: 0x4889d7f7d8660ffc96004ef6ca2b78c5278498687c3960ee0eeb771fae0ab27b
// Block: 46
// Paid: 0.000000199202995013 ETH (76417 gas * 0.002606789 gwei)

// ##### anvil-hardhat
// ✅  [Success]Hash: 0x1a8a8cb724a1e32c240acdf68b88ead1cfceaea3d53abb6effd00c3fb00a199d
// Block: 47
// Paid: 0.000000180820803417 ETH (79217 gas * 0.002282601 gwei)

// ##### anvil-hardhat
// ✅  [Success]Hash: 0xde4fd93a82f99d1e8913449134ec321ff6d852174d5a8ebf08937f43518114bc
// Block: 48
// Paid: 0.000000061394618628 ETH (30716 gas * 0.001998783 gwei)

// ✅ Sequence #1 on anvil-hardhat | Total Paid: 0.000002021969213533 ETH (661623 gas * avg 0.00265094 gwei)

// ==========================

// ONCHAIN EXECUTION COMPLETE & SUCCESSFUL.
