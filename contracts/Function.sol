// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

contract Func {
    // Области видимости
    // public
    // external - к функции можно обращаться снаружи смарт-контракта
    // internal - к функции можно обращаться только изнутри самого смарт-контракта и контракты наследники
    // private - к функции можно обращаться только внутри смарт-контракта, но не его потомка

    // view - функция может только читать в блокчейне
    // pure - функция не может читать никакие внешние данные
    string message = "hello";
    uint public balance;

    function getBalance() public view returns(uint) {
        return address(this).balance;
    }

    function getBalance2() public view returns(uint balance) {
        balance = address(this).balance;
    }

    function getMessage() external view returns(string memory) {
        return message;
    }

    function rate(uint amount) public pure returns(uint) {
        return amount * 3;
    }

    // Функция которая вызывает через транзакции
    // Данные функции не могут возвращать напрямую через return
    function setMessage(string memory newMessage) external {
        message  = newMessage;
    }

    // payable - модификатор указывающий на то, что функция может принимать денежные средства
    function pay() external payable {
        balance += msg.value; // эту строку можно не писать. И так автоматические деньги зачислятся на счет смарт-контракта
    }

    // Чтобы просто принимать денежные средства без всякого вызова функции
    // receive - эта функция, которая вызывается если в смарт-контракт 
    // просто прилетели денежные средства в транзакции, но в этой транзакции нет
    // информации о том, какую функциюследует выполнить
    receive() external payable {}

    // fallback вызывается если относительно смарт-контракта была вызвана транзакция
    // с неизвестным именем функции
    fallback() external payable {}
}