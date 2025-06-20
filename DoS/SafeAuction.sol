// SPDX-License-Identifier: MIT
pragma solidity ^0.8.30;

contract SafeAuction {

    address private highestBidder;
    uint256 private highestBid;
    uint256 private auctionEnds;

    mapping(address => uint256) private refunds;

    constructor() {
        auctionEnds = block.timestamp + 600;
    }

    function bid() external payable {
        require(msg.value > highestBid, "You should overbid current highest bid");
        require(block.timestamp <= auctionEnds, "Actuions is finished");

        // PULL 
        refunds[highestBidder] += highestBid; 

        highestBid = msg.value;
        highestBidder = msg.sender;
    }

    function refund() external {
        uint256 amountToRefund = refunds[msg.sender];
        require(amountToRefund > 0, "Nothing to refund");

        refunds[msg.sender] = 0;

        (bool success, ) = msg.sender.call{value: amountToRefund}("");
        require(success, "Refund failed");
    }

    function getHighestBid() external view returns(uint256) {
        return highestBid;
    }



}