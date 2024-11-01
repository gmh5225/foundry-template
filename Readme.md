# Foundry Template
Foundry Template for arbitrum testnet

## Usage


### Create a ``.env`` file
```

API_KEY_INFURA=your infura api key [Used for sepolia testnet]
API_KEY_ARBISCAN=your arbiscan api key [Used for arbitrum sepolia testnet]
API_KEY_ETHERSCAN=your etherscan api key [Used for sepolia testnet]
WALLET_PRIVATE_KEY=your wallet private key [Used for BankInteract.s.sol/Bank.s.sol]
USER1_PRIVATE_KEY=private key of user1 [Used for BankInteract.s.sol]
USER2_PRIVATE_KEY=private key of user2 [Used for BankInteract.s.sol]
SEPOLIA_WALLET_PRIVATE_KEY=your wallet private key [Used for BankSepolia.s.sol/Bank.s.sol]
BANK_CONTRACT_ADDRESS=your contract address [Used for BankSepoliaInteract.s.sol]
```

## Install deps
```
forge install
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
forge test -vv
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
forge script script/Bank.s.sol --fork-url localhost --broadcast -vvvv
```

If you want to use any private key to deploy, then use ``forge create``
```
forge create src/bank.sol:Bank --rpc-url localhost --private-key {Your private key}
```

##### Deploy to ``Anvil`` with ``BankInteract.s.sol``
```
forge script script/BankInteract.s.sol:BankInteractScript --fork-url localhost --broadcast -vvvv
```

#### Sepolia:

##### Deploy to ``Arbitrum-Sepolia``
```
forge script script/BankSepolia.s.sol:BankSepoliaScript --rpc-url arbitrum_sepolia --broadcast --verify -vvvv
```

##### Contract Address
```
0x87acF4b407765220476AB0b2A1c204C99DfD1BbE
```

If you want to use any private key to deploy, then use ``forge create``
```
forge create src/bank.sol:Bank --rpc-url arbitrum_sepolia --private-key {Your private key}
```

##### Interact with ``Arbitrum-Sepolia``
```
forge script script/BankSepoliaInteract.s.sol:BankSepoliaInteract --fork-url arbitrum_sepolia --broadcast -vvvv
```

If you want to generate actual transactions on the chain, then use ``--rpc-url``
```
forge script script/BankSepoliaInteract.s.sol:BankSepoliaInteract --rpc-url arbitrum_sepolia --broadcast -vvvv
```

##### Destroy the contract
```
forge script script/BankDestroy.s.sol:BankDestroyScript --rpc-url arbitrum_sepolia --broadcast -vvvv
```

#### result of "Destroy the contract"
```
https://sepolia.arbiscan.io/tx/0x4878408b3ea0fede3524bcec5ee6b1c048380e2fa5784f0ba20652b6840aba5c
```


For instructions on how to deploy to a testnet or mainnet, check out the
[Solidity Scripting](https://book.getfoundry.sh/tutorials/solidity-scripting.html) tutorial.

### Format

Format the contracts:

```
forge fmt
```


### GUI wrapper command-line tool
- https://github.com/gmh5225/forge-gui


## Credits
- https://github.com/PaulRBerg/foundry-template
- https://github.com/hrkrshnn/tstore-template
