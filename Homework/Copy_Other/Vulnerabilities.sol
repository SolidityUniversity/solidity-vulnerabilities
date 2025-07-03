// SPDX-License-Identifier: MIT
pragma solidity ^0.8.30;

contract Vulnerabilities {

    // 1. LACK OF INPUT VALIDATION

    mapping(address => uint256) public balances;

    function setBalance(address user, uint256 amount) public {
        // ❌ Любой пользователь может установить баланс для любого адреса
        balances[user] = amount;
    }

    // 2. Access Control Vulnerabilities

    // 3. FRONRUNNING
            // Приходит юзер1, вызывает транзакцию
            // Атакер мониторит мемпул
            // Атакер вызывает транзакцию с высшим приоритетом по газу
            // Транзакция атакера проходит быстрее
            // Проходит транзакция юзера1

    // 4. Price Oracle Manipulation
    // 5. Logical Errors

}

