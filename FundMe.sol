// SPDX-License-Identifier: MIT

pragma solidity >=0.6.6 <0.9.0;

import "@chainlink/contracts/src/v0.6/interfaces/AggregatorV3Interface.sol";
//newer version v0.8 (as in PriceConsumerV3.sol)

import "@chainlink/contracts/src/v0.6/vendor/SafeMathChainlink.sol";

// to avoid overflow error for Solidity < 0.8

contract FundMe {
    using SafeMathChainlink for uint256;
    //using A for B, can be used to attach libbrary functions (from the library A) to any type (B) in the context of a contract.

    mapping(address => uint256) public addressToAmountFunded;
    address[] public funders;
    address public owner;

    constructor() public {
        owner = msg.sender;
    }

    function fund() public payable {
        // payable for it can receive VALUE (money in ETH)
        // the button for payable button will be in color red

        uint256 minimumUSD = 50 * 10**18; //so it has 18 digits also

        require(
            getConversionRate(msg.value) >= minimumUSD,
            "You need to spend more ETH!"
        );

        addressToAmountFunded[msg.sender] += msg.value;
        // msg.sender and msg.value are keywords in every function call
        funders.push(msg.sender);
    }

    function getVersion() public view returns (uint256) {
        AggregatorV3Interface priceFeed = AggregatorV3Interface(
            0x8A753747A1Fa494EC906cE90E9f37563A8AF630e
        );
        // which means `priceFeed` is a contract defined by AggregatorV3Interface.sol located at the address 0x8A753747A1Fa494EC906cE90E9f37563A8AF630, which is Rinkeby ETH/USD price feed address from https://docs.chain.link/docs/ethereum-addresses/

        return priceFeed.version();
    }

    function getPrice() public view returns (uint256) {
        AggregatorV3Interface priceFeed = AggregatorV3Interface(
            0x8A753747A1Fa494EC906cE90E9f37563A8AF630e
        );
        (, int256 answer, , , ) = priceFeed.latestRoundData();
        // we only need the 2nd value in the returned tuple of latestRoundData()

        return uint256(answer * 10000000000); // so the value has 18 digits
    }

    function getConversionRate(uint256 ethAmount)
        public
        view
        returns (uint256)
    {
        uint256 ethPrice = getPrice();
        uint256 ethAmountInUsd = (ethPrice * ethAmount) / 1000000000000000000;
        // to convert the ethAmount into ETH uint256

        return ethAmountInUsd; // = USD with 18 "digit" (or USD * 10^18)
    }

    modifier onlyOwner() {
        require(msg.sender == owner);
        _;
    }

    function withdraw() public payable onlyOwner {
        // to send all (balance of) money of this contract to the caller
        msg.sender.transfer(address(this).balance);
        // keyword **this** in Solidity refers to the contract it is in

        // to reset funders' balance to zero after money is withdrawn
        for (
            uint256 funderIndex = 0;
            funderIndex < funders.length;
            funderIndex++
        ) {
            address funder = funders[funderIndex];
            addressToAmountFunded[funder] = 0;
        }
        funders = new address[](0);
    }
}
