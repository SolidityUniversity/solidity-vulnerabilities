// SPDX-License-Identifier: MIT
pragma solidity ^0.7.4;

contract BrokenCounter {

    //uint8 = 8 бит = 2^8 = 0 -> 255
    //uin256

    mapping(address => uint8) public score;

    function increment() public {
        score[msg.sender] += 1;
    }

    function decrement() public {
        score[msg.sender] -= 1;
    }

    function setScore(uint8 _value) public {
        score[msg.sender] += _value;
    }

}