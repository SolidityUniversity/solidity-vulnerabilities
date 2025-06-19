// SPDX-License-Identifier: MIT
pragma solidity ^0.8.30;

// На версии Solidity 0.8^ встроена автоматическая защита от Underflow & Overflow
contract Counter {

    mapping(address => uint8) public score;

    function increment() public {

        // Проверка на overflow\undeflow отключена
        unchecked {
            score[msg.sender] += 1;
        }
    }

    function decrement() public {

        score[msg.sender] -= 1;

        // Для отключения защиты используйте unchecked{}
        // ❌ Отключаем проверку: 255 + 1 → 0 
        // unchecked {
        //     score[msg.sender] += 1;
        // }
    }

    function setScore(uint8 _value) public {
        score[msg.sender] += _value;
    }

}