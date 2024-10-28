// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.28;

import "forge-std/Script.sol";
import "forge-std/console2.sol";
import "../src/Bank.sol";

contract BankSepoliaScript is Script {
    bytes32 constant SALT = bytes32(uint256(0x0000000000000000000000000000000000000000d3bf2663da51c10215000000));

    // contract bytecode
    bytes constant bytecode =
        hex"608060405234801561001057600080fd5b50600080546001600160a01b031916331790556102e7806100326000396000f3fe60806040526004361061003f5760003560e01c806312065fe0146100445780634d853ee51461006a578063a0712d681461009a578063a6f9dae1146100ad575b600080fd5b34801561005057600080fd5b506040516001600160a01b03909116815260200160405180910390f35b34801561007657600080fd5b5061008a6100853660046101f8565b6100cd565b60405190151581526020015b60405180910390f35b6100ab6100a8366004610213565b610179565b005b3480156100b957600080fd5b506100ab6100c83660046101f8565b6101a9565b60008054906001600160a01b031633146101325760405162461bcd60e51b815260206004820152601660248201527f4f6e6c79206f776e65722063616e207769746864726177000000000000000000604482015260640160405180910390fd5b6000826001600160a01b03168360405160006040518083038185875af1925050503d8060008114610179576040519150601f19603f3d011682016040523d82523d6000602084013e610179565b50600192915050565b6000546001600160a01b031633146101a75760405162461bcd60e51b815260040161019e90610228565b60405180910390fd5b50565b6000546001600160a01b031633146101d35760405162461bcd60e51b815260040161019e90610228565b600080546001600160a01b0319166001600160a01b0392909216919091179055565b6000602082840312156102095760006020830151905092915050565b600060208284031215610224576000602083015190509291505056fea2646970667358221220f2e0c0f2e0c0f2e0c0f2e0c0f2e0c0f2e0c0f2e0c0f2e0c0f2e0c0f2e0c0f264736f6c63430008130033";
    // https://sepolia.arbiscan.io/address/0x080ff2F829BA78DE536A472d2DF131561c7446B8

    function setUp() public { }

    function deploy(bytes memory _bytecode, bytes32 _salt) public returns (address addr) {
        assembly {
            addr :=
                create2(
                    0, // eth amount
                    add(_bytecode, 0x20), // bytecode start
                    mload(_bytecode), // bytecode length
                    _salt // salt value
                )
            if iszero(extcodesize(addr)) { revert(0, 0) }
        }
    }

    function run() public {
        uint256 deployerPrivateKey = vm.envUint("SEPOLIA_WALLET_PRIVATE_KEY");
        address deployerAddress = vm.addr(deployerPrivateKey);

        vm.startBroadcast(deployerPrivateKey);

        Bank bank = new Bank();
        console2.log("Bank deployed to:", address(bank));

        // address addr = deploy(bytecode, SALT);
        // console2.log("Bank deployed to:", addr);
        console2.log("Deployed by:", deployerAddress);

        vm.stopBroadcast();
    }
}
