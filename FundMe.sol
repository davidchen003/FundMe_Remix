// SPDX-License-Identifier: MIT

pragma solidity >=0.6.6 <0.9.0;

import "@chainlink/contracts/src/v0.6/interfaces/AggregatorV3Interface.sol";

//newer version v0.8 (as in PriceConsumerV3.sol)

contract FundMe {
    mapping(address => uint256) public addressToAmountFunded;
    address[] public funders;
    address public owner;

    constructor() public {
        owner = msg.sender;
    }

    function fund() public payable {
        // payable for it can receive VALUE (money in ETH)
        // the button for payable button will be in color red

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
}
