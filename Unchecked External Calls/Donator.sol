// SPDX-License-Identifier: MIT
pragma solidity ^0.8.30;

//Unchecked External Calls Vulnarability

// address.send(value)                      //returns ==> (bool success)
// address.call{value: 1 eth}(data)         //returns ==> (bool success, bytes memory data)
// address.delegetacall(data)               //returns ==> (bool success, bytes memory data)
// address.staticcall(data)                 //returns ==> (bool success, bytes memory data)

// ^ ВСЕ ОНИ ^
// ВОЗВРАЩАЮТ bool, data
// НЕ ВЫЗЫВАЮТ revert

contract Donator {

    bool public isDontaiondone = false;

    function donate(address _to) external payable {
        payable(_to).send(msg.value); // ❌ => вызов фейлится, но функция продолжает выполнение
        // НЕ ДЕЛАЕМ ПРОВЕРКУ success
        isDontaiondone = true; 
    }

    // ВЫВОД: ВСЕГДА ПРОВЕРЯЙТЕ SUCCESS ВНЕШНИХ ВЫЗОВО

    function safeDonate(address _to) external payable {
        bool success = payable(_to).send(msg.value); // ❌
        require(success, "SEND FAILED"); //
        isDontaiondone = true; 
    }
}

