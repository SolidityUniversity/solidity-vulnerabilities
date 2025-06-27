// SPDX-License-Identifier: MIT
pragma solidity ^0.8.30;

contract Rejecter {

    fallback() external payable {
        revert("");
    }

    //fallback() => 📦 Используется для перехвата неизвестных вызовов и проксирования
    // 🔹 Срабатывает, когда:
    // - Пришёл вызов с данными, но функция не найдена
    // - Пришёл вызов с value, но в контракте нет receive()
    // 🔸 Важно:
    // - При наличии receive(), и fallback() — вызов без данных и с ETH пойдёт в receive()
    // - fallback() может быть payable (если нет — вызов с ETH ревертится) 
}