// SPDX-License-Identifier: MIT

pragma solidity >=0.6.6 <0.9.0;

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
}
