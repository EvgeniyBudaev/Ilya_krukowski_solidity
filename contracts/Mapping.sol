// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

contract Mapping {
    // Ключ - address, значение - uint
    // storage. Хранится в блокчейн
    mapping (address => uint) public payments;

    function receiveFunds() public payable {
        // msg.value - кол-во присланных денежных средств
        // value доступно если функция помечена как payable
        payments[msg.sender] = msg.value;
    }
}
