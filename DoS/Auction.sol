// SPDX-License-Identifier: MIT
pragma solidity ^0.8.30;

contract Auction {

    address private highestBidder;
    uint256 private highestBid;
    uint256 private auctionEnds;

    constructor() {
        auctionEnds = block.timestamp + 600;
    }

    function bid() external payable {
        require(msg.value > highestBid, "You should overbid current highest bid");
        require(block.timestamp <= auctionEnds, "Actuions is finished");

        // PUSH BASED REFUND
        (bool success, ) = highestBidder.call{value:highestBid}("");
        require(success, "Refaun failed");

        highestBid = msg.value;
        highestBidder = msg.sender;
    }

    function getHighestBid() external view returns(uint256) {
        return highestBid;
    }



}