// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

//События, модификаторы, require/revert и тесты
contract Events {
    // require
    // revert
    // assert
    address owner;

    // indexed можно делать к примеру поиск
    event Paid(address indexed _from,uint _amout, uint _timestamp);

    constructor() {
        // владелецем устанавливаем того, кто инициализирует смарт-контракт
        owner = msg.sender;
    }

    // Функция для оплаты
    function pay() external payable {
        emit Paid(msg.sender, msg.value, block.timestamp);
    }

    // Функция для снятия денег со смарт-контракта
    // require
    function withDraw(address payable _to) external {
        require(msg.sender == owner, "You are not anowner!");
        _to.transfer(address(this).balance);
    }

    // revert
     function withDraw2(address payable _to) external {    
        if (msg.sender == owner) {
            revert("You are not anowner!");
         } 
        _to.transfer(address(this).balance);
    }

    // assert
    function withDraw3(address payable _to) external {    
        assert(msg.sender == owner); // если false, То будет ошибка Panic
        _to.transfer(address(this).balance);
    }

    // Модификаторы кастомные
    modifier onlyOwner(address _to) {
        require(msg.sender == owner, "You are not anowner!");
        require(_to != address(0), "Invalid address!");
        _; // переход к следующей строке
        require(_to != address(0), "Invalid address!"); // После _; можно писать дальше код
    }

    function withDraw4(address payable _to) external onlyOwner(_to) {}
}
