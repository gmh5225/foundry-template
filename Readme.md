# Foundry Template
Foundry Template for arbitrum testnet

## Usage


### Create a ``.env`` file
```

API_KEY_INFURA=your infura api key [Used for sepolia testnet]
API_KEY_ARBISCAN=your arbiscan api key [Used for arbitrum sepolia testnet]
API_KEY_ETHERSCAN=your etherscan api key [Used for sepolia testnet]
SEPOLIA_WALLET_PRIVATE_KEY=your wallet private key [Used for Deploy.s.sol]
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
forge script script/Deploy.s.sol --fork-url localhost --broadcast -vvvv
```

#### Sepolia:

##### Deploy to ``Arbitrum-Sepolia``
```
forge script script/Deploy.s.sol:DeployScript --rpc-url arbitrum_sepolia --broadcast --verify -vvvv
```

##### Destroy the contract
```
forge script script/Destroy.s.sol:DestroyScript --rpc-url arbitrum_sepolia --broadcast -vvvv
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
