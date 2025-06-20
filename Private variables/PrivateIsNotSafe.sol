// SPDX-License-Identifier: MIT
pragma solidity ^0.8.30;

contract PrivateIsNotSafe {

    // Ограничвает доступ из других смарт-контрактов§
    address private myAddresses;

    //^ Оно всё равно лежит в storage = не безопасно. 
}