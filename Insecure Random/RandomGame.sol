// SPDX-License-Identifier: MIT
pragma solidity ^0.8.30;

contract RandomGame {

    address public owner;
    uint256 public lastResult;

    uint256 public owes;

    constructor() payable {
        owner = msg.sender;
    }

    // УГАДЫВАЕМ ЧИСЛО ОТ 1 ДО 3
    // ЕСЛИ УГАДАЛ ==> ПОУЛЧАЕШЬ 2 ЭФИРА

    // 1/3  2/3 
    // 0.33 * 2 eth + 0.66 * 0 =± 0.666666666666

    function guess(uint8 _guess) external payable returns (uint8 result, bool isWinner) {
        require(address(this).balance >= 2 ether, "should have 2 ether to start game");
        require(msg.value == 1 ether, "should be 1 ETH");
        require(_guess >= 1 && _guess <= 3, "Pick number from 1 to 3");

        result = getRandomNumber();
        lastResult = result;

        isWinner = (_guess == result);

        if (isWinner) {
            (bool success, ) = msg.sender.call{value: 3 ether}("");
            require(success, "cant send Ether");
        }

        return (result, isWinner);
    }


    function getRandomNumber() internal view returns (uint8) {
        return uint8(
            uint256(
                keccak256(
                    abi.encodePacked(
                        block.timestamp,
                        block.prevrandao, // block.prevando более сейвовый
                        msg.sender
                    )
                )
            ) % 3 + 1 // НА ВЫХОДЕ мы получаем число 1-3
        );
    }

    receive() external payable {}

    function withdraw() external {
        require(msg.sender == owner, "Not an owner");
        payable(owner).transfer(2 ether);
    }
}
