# Chainlink

- a modularized decentralized oracle network provides external data
- [Chainlink Data Feed](https://data.chain.link/)

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

- [AggregatorV3Interface.sol](https://github.com/smartcontractkit/chainlink/blob/develop/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol)
- unlike keyword contract, interface doesn't have full function implemetations.
- interface compiles down to an ABI (application binary interface).
- ABI tells solidity (and other programming languages) how it can interact with another contract (what functions can be called on another contract)
- anytime you want to interact with an already deployed smart contract you will need an ABI.
