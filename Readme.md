# Foundry Template
Foundry Template for arbitrum testnet

## Usage


### Create a ``.env`` file
```

API_KEY_INFURA=your infura api key [Used for sepolia testnet]
API_KEY_ARBISCAN=your arbiscan api key [Used for arbitrum sepolia testnet]
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
