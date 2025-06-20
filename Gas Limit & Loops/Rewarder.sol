// SPDX-License-Identifier: MIT
pragma solidity ^0.8.30;

// Gas Limit & Loops Vulnerability

// for (uint i = 0; i < userList.length; i++) {
//         // делаем что-либо
//         // user.doSmtih
// }

// 0. ИЗБЕГАЙТЕ ТЯЖЕЛЫХ ЦИКЛОВ, ВЫНОСИТЕ ИХ ОФФЧЕЙН
// 1. НЕ ПИШИТЕ ЦИКЛЫ ПО МАССИВАМ, ДЛИНА КОТОРЫХ БЕСКОНЕЧНО РАСТЕТ
// 2. ИСПОЛЬЗУЙТЕ БАТЧИНГ

// Пример использования батчинга
contract Rewarder {

    address[] public bestUsers; //Включает в себя 100000000 адресов

    // Используя батчинг мы можем сами указывать какое количество итераций
    // Мы хотим произвести. Таким образом обезопашиваем код.
    function processBatch(uint256 start, uint256 end) public {
        
        for(uint i = start; i < end; i++) {
            payable(bestUsers[i]).transfer(777 wei);
        }

    }
}
