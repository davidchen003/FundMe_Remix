# Chainlink

- a modularized decentralized oracle network provides external data
- [Chainlink Data Feeds](https://data.chain.link/)

# Get ETH price

- [sample code](https://docs.chain.link/docs/get-the-latest-price/)
  - compile and deploy `PriceConsumerV3.sol`
  - make sure MetaMask is open, account on Kovan network has ETH
  - select Remix ENVIRONMENT from JavaScript VM to Injected Web3 (because there are no Chainlink nodes on simulated JavaScript VMs)
  - MetaMask pops up, authorize connection
  - select the right contract, click Deploy
  - MetalMask pops up, confirmation transaction
  - click getLatestPrice button, ETH price will show
  - but it is actually USD price x 10^8

**commit 2**

# Interface: AggregatorV3Interface.sol

- [AggregatorV3Interface.sol](https://github.com/smartcontractkit/chainlink/blob/develop/contracts/src/v0.6/interfaces/AggregatorV3Interface.sol)
- unlike keyword contract, interface doesn't have full function implemetations.
- interface compiles down to an ABI (application binary interface).
- ABI tells solidity (and other programming languages) how it can interact with another contract (what functions can be called on another contract)
- anytime you want to interact with an already deployed smart contract you will need an ABI.

# FundMe.so

## Get ETH price

- `import "@chainlink/contracts/src/v0.6/interfaces/AggregatorV3Interface.sol";` is equivalent to copy/paste here the [AggregatorV3Interface.sol code](https://github.com/smartcontractkit/chainlink/blob/develop/contracts/src/v0.6/interfaces/AggregatorV3Interface.sol)
- now we can call/use the functions in the AggregatorV3Interface
- in FundMe.sol, `AggregatorV3Interface priceFeed = AggregatorV3Interface(0x8A753747A1Fa494EC906cE90E9f37563A8AF630e)` means `priceFeed` is a contract defined by AggregatorV3Interface.sol located at the address 0x8A753747A1Fa494EC906cE90E9f37563A8AF630, which is Rinkeby ETH/USD price feed address from [Ethereum Data Feeds](https://docs.chain.link/docs/ethereum-addresses/)
- **don't see AggregatorV3Interface.sol has constructor of taking address parameter?**
- since the contract is on Rinkeby testnet, we need to select `Injected Web3` ENVIRONMENT to deploy it in Remix, and select MetaMask account on Rinkeby testnet

**commit 3**

## SafeMath library

- to avoid overflow error for Solidity < 0.8
- Libraries are similar to contracts, but their purpose is that they are deployed only once at a specific address and their code is reused
- **Using** keyword: the directive using A for B, can be used to attach libbrary functions (from the library A) to any type (B) in the context of a contract.

## Set fund minimum/threshold

- Require statement, if not met, revert the transation
- Pick a low VALUE (say 1 Gwei), we'll get an Gas Estimation Error: Gas estimation errored with the following message (see below). The transaction execution will likely fail. Do you want to force sending? We can force send. Then check Rinkeby esther scan, we'll see error message there "Fail with error 'You need to spend more ETH!"
- but if we send more (say 13000000 Gwei, which is 0.013 ETH), it will go through

**Commit 4**
