// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;

import "forge-std/Script.sol";
import "forge-std/console2.sol";
import "../src/Bank.sol";

contract DestroyScript is Script {
    function setUp() public { }

    function run() public {
        // TODO: encrypt your private key
        uint256 deployerPrivateKey = vm.envUint("SEPOLIA_WALLET_PRIVATE_KEY");
        address payable bankAddress = payable(vm.envAddress("BANK_CONTRACT_ADDRESS"));
        address payable recipient = payable(vm.envAddress("RECIPIENT_ADDRESS"));

        Bank bank = Bank(bankAddress);
        vm.startBroadcast(deployerPrivateKey);

        try bank.destroy(recipient) {
            console2.log("Contract destroyed successfully");
            console2.log("Funds sent to:", recipient);
        } catch Error(string memory reason) {
            console2.log("Destroy failed:", reason);
        } catch {
            console2.log("Destroy failed with unknown error");
        }

        vm.stopBroadcast();
    }
}
