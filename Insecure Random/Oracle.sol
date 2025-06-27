// SPDX-License-Identifier: MIT
pragma solidity ^0.8.30;

interface IWitnetRandomness {
    function randomize() external payable;
    function isRandomized(uint256 _block) external view returns (bool);
    function getRandomnessAfter(uint256 _block) external view returns (bytes32);
    function random(uint32 _range, uint256 _nonce, uint256 _block) external view returns (uint32);
}

// Получаем рандомное число от 1 до 100 используя witnet

contract Random {

    address constant WITNET_RANDOMNESS = 0xC0FFEE98AD1434aCbDB894BbB752e138c1006fAB;

    IWitnetRandomness public witnet = IWitnetRandomness(WITNET_RANDOMNESS);

    mapping(address=> uint256) public userRequstBook;

    function requestRandom() external payable {
        witnet.randomize{value: msg.value}();
        userRequstBook[msg.sender] = block.number;
    }

    function checkIsRandomReady() external view returns(bool) {
        return witnet.isRandomized(userRequstBook[msg.sender]);
    }

    function getRandomFrom1To100(uint256 nonce) external view returns(uint32) {
        require(witnet.isRandomized(userRequstBook[msg.sender]), "NOT READY");
        return witnet.random(100, nonce, userRequstBook[msg.sender]);
    }

}
