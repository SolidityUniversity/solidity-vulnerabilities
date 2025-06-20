// SPDX-License-Identifier: MIT
pragma solidity ^0.8.30;

// Tx.origin Vulnerability
contract DepositWallet {

    address public owner;

    constructor() {
        owner = msg.sender;
    }

    function transferFunds(address payable _to, uint256 _amount) external {
        require(tx.origin == owner); // НЕ БЕЗОПАСНЫЙ ПОДХОД
        // require(msg.sender == owner); БЕЗОПАСНЫЙ ПОДХОД

        _to.transfer(_amount);
    }

    function deposit() external payable {}

    // КАК ПРОИСХОДИТ АТАКА:

    // ЖЕРТВА ИМЕЕТ ДЕПОЗИТ в DepositWallet
    // ХАКЕР разворачивает Attacker контракт
    // ПРОСИТ ЖЕРТВУ ПЕРЕВЕСТИ любую сумму на Attacker контракт
    // ЖЕРТВА ПЕРЕВОДИТ ДЕНЬГИ...
    // Отрабатывает функция receive

    // ВЫВОДЫ:
    // не используем tx.origin для авторизации
}