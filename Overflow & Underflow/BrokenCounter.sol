// SPDX-License-Identifier: MIT
pragma solidity ^0.7.4;

// Пример работы Underflow & Overflow на Solidity версии <0.8
contract BrokenCounter {

    // uint8 хранит числа от 0 до 255 (1 байт, 2^8)
    mapping(address => uint8) public score;

    function increment() public {
        // Сработает OVERFLOW если score будет 255 → 0
        score[msg.sender] += 1;
    }

    function decrement() public {
        // Сработает UNDEFLOW если score будет 0 → 1
        score[msg.sender] -= 1;
    }

    function setScore(uint8 _value) public {
        score[msg.sender] += _value;
    }

}