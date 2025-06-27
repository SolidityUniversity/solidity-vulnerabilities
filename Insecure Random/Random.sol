// SPDX-License-Identifier: MIT
pragma solidity ^0.8.30;

contract Random {

    function getRandomNumber() public view returns (uint256) {
    
    return uint256(
        
        keccak256( // ==> BYTES 32 (256 ИНФОРМАЦИИ)

            abi.encodePacked( //СОЗДАЕТСЯ ДЛИННАЯ СТРОКА байтов (bytes) 
                block.timestamp, //текущая временная метка
                block.prevrandao, // раньше юзали difficulty, ещё менее секюрно
                msg.sender
            )
        )
    );}

}