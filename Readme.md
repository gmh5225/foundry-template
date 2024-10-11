# Foundry Template


## Usage


### Create a ``.env`` file
```

API_KEY_INFURA=Replace=your infura api key [Used for sepolia testnet]
API_KEY_ETHERSCAN=Replace=your etherscan api key [Used for sepolia testnet]
WALLET_PRIVATE_KEY=your wallet private key [Used for BankInteract.s.sol]
USER1_PRIVATE_KEY= private key of user1 [Used for BankInteract.s.sol]
USER2_PRIVATE_KEY= private key of user2 [Used for BankInteract.s.sol]
```


### Build

Build the contracts:

```sh
forge build
```

### Clean

Delete the build artifacts and cache directories:

```sh
forge clean
```

### Compile

Compile the contracts:

```sh
forge build
```

### Coverage

Get a test coverage report:

```sh
forge coverage
```

### Deploy

#### Anvil:
```sh
anvil
```

##### Deploy to Anvil:
```sh
forge script script/BankInteract.s.sol:BankInteractScript --fork-url http://localhost:8545 --broadcast
```

##### Deploy to Anvil with Interact.sol:
```sh
forge script script/BankInteract.s.sol:BankInteractScript --fork-url http://localhost:8545 --broadcast
```

For instructions on how to deploy to a testnet or mainnet, check out the
[Solidity Scripting](https://book.getfoundry.sh/tutorials/solidity-scripting.html) tutorial.

### Format

Format the contracts:

```sh
forge fmt
```

### Gas Usage

Get a gas report:

```sh
forge test --gas-report
```

### Lint

Lint the contracts:

```sh
bun run lint
```

### Test

Run the tests:

```sh
forge test
```

Generate test coverage and output result to the terminal:

```sh
bun run test:coverage
```

Generate test coverage with lcov report (you'll have to open the `./coverage/index.html` file in your browser, to do so
simply copy paste the path):

```sh
bun run test:coverage:report
```


## Credits
- https://github.com/PaulRBerg/foundry-template
- https://github.com/hrkrshnn/tstore-template
