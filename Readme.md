# Foundry Template


## Usage


### Create a ``.env`` file
```

API_KEY_INFURA=your infura api key [Used for sepolia testnet]
API_KEY_ETHERSCAN=your etherscan api key [Used for sepolia testnet]
WALLET_PRIVATE_KEY=your wallet private key [Used for BankInteract.s.sol/Bank.s.sol]
USER1_PRIVATE_KEY=private key of user1 [Used for BankInteract.s.sol]
USER2_PRIVATE_KEY=private key of user2 [Used for BankInteract.s.sol]
SEPOLIA_WALLET_PRIVATE_KEY=your wallet private key [Used for BankSepolia.s.sol/Bank.s.sol]
BANK_CONTRACT_ADDRESS=your contract address [Used for BankSepoliaInteract.s.sol]
```


### Build

Build the contracts:

```
forge build
```

### Clean

Delete the build artifacts and cache directories:

```
forge clean
```

### Compile

Compile the contracts:

```
forge build
```

### Test

Run the tests:

```
forge test
```

Get a test coverage report:

```
forge coverage
```

Get a gas report:

```
forge test --gas-report
```


### Deploy

#### Anvil
```
anvil
```

##### Deploy to ``Anvil``
```
forge script script/Bank.s.sol --fork-url localhost --broadcast
```

##### Deploy to ``Anvil`` with ``BankInteract.s.sol``
```
forge script script/BankInteract.s.sol:BankInteractScript --fork-url localhost --broadcast
```

#### Sepolia:

##### Deploy to ``Sepolia``
```
forge script script/BankSepolia.s.sol:BankSepoliaScript --rpc-url sepolia --broadcast -verify -vvvv
```

##### Interact with ``Sepolia``
```
forge script script/BankSepoliaInteract.s.sol:BankSepoliaInteract --fork-url sepolia --broadcast
```


For instructions on how to deploy to a testnet or mainnet, check out the
[Solidity Scripting](https://book.getfoundry.sh/tutorials/solidity-scripting.html) tutorial.

### Format

Format the contracts:

```
forge fmt
```

## Credits
- https://github.com/PaulRBerg/foundry-template
- https://github.com/hrkrshnn/tstore-template
