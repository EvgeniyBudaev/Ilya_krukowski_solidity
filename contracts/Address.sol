// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

contract Address {
    // storage. Хранится в блокчейн
    address public myAddr = 0x5B38Da6a701c568545dCfcB03FcB875f56beddC4;

    // getBalance - функция получения баланса по адресу
    // view - функция будет вызываться не через транзакцию, а через вызов 
    function getBalance(address targetAddr) public view returns(uint) {
        return targetAddr.balance;
    }

    // receiveFunds - функция для приема денежных средств
    // payable - деньги автоматически перечисляться насчет текущего смарт-контракта
    function receiveFunds() public payable {}

    // transferTo - функция куда переводить деньги
    // вариант 1
    function transferTo(address payable targetAddr,uint amount) public {
        targetAddr.transfer(amount);
    }

    // вариант 2
    function transferTo2(address targetAddr, uint amount) public {
        address payable _to = payable(targetAddr);
        _to.transfer(amount);
    }
}
