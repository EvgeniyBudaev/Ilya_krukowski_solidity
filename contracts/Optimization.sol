// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

contract Optomization {
    uint demo; // самое оптимизированное объявление переменной
    uint128 a = 1;
    uint128 b = 1;
    uint256 c = 1;
    // mapping дешевле чем массивы.
    mapping(address => uint) payments;
    // Лучше не модифицировать переменную много раз
    uint public result = 1;

    // uint8[] demo дешевле, чем uint[] demo

    // Лучше не писать много вложенных функций
    function pay() external payable {
        require(msg.sender != address(0), "zero address");
        payments[msg.sender] = msg.value;
    }

    function doWork(uint[] memory data) public {
        uint temp = 1;
        for(uint i = 0; i < data.length; i++) {
            temp *= data[i];
        }
        result = temp;
    }
}

contract NoOptomization {
    uint128 a = 1;
    uint256 c = 1;
    uint128 b = 1;
    // Массивы с фиксированной длинной дешевле динамических
    uint[] payments;

    function pay() external payable {
        // Объявление промежуточных переменных дорогостоящая операция
        address _from = msg.sender;
        require(_from != address(0), "zero address");
        payments.push(msg.value);
    }
}
