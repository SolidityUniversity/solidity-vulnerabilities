// SPDX-License-Identifier: MIT
pragma solidity ^0.8.30;

// HOMEWORK:
// Добавить любой адрес в массив используя функцию addWinner
// * Нельзя менять смарт-контракт WinnerList

contract WinnerList {
    address[] public winners;
    bool lock;

    function addWinner(address winner) public {
        lock = false;

        msg.sender.call("");

        require(lock, "Not Lock!");
        winners.push(winner);
    }

    function lockWinnerList() public {
        lock = true;
    }
}
