// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

// Продажа мопеда. Деньги поступают вкладчину от нескольких людей
contract MopedShop {
    mapping (address => bool) buyers; // список покупателей
    uint public price = 2 ether; // Цена мопеда
    // uint public price = 2; // wei по умолчанию
    address public owner; // Владелец
    address public shopAddress; // адрес смарт-контракта
    bool fullyPaid; // false // Полностью ли оплачен мопед?

    event ItemFullyPaid(uint _price, address _shopAddress);

    constructor() {
        // делаем чтобытолько владелецмог списывать денежные средства с контракта
        // sender - учетная запись того, кто запускает транзакцию
        owner = msg.sender;
        shopAddress = address(this);
    }

    // Узнать текущий баланс
    function getBalance() public view returns(uint) {
        return shopAddress.balance;
    }

    // receive - функция приема денег
    // external - функция будет вызываться только из вне смарт-контракта,
    // а не из самого контракта
    receive() external payable {
        // проверяем что человек есть в списке покупателей у  владельца
        // проверяем что та сумма, которая приходит в транзакции должна быть меньше или равна цене продаваемого мопеда 
        // проверяем, что если мопед оплачен, то денег больше не принимаем  
        require(buyers[msg.sender] && msg.value <= price && !fullyPaid, "Rejected!");
        // Проверяем полностью ли был оплачен мопед
        if (shopAddress.balance == price) {
            fullyPaid = true;
            emit ItemFullyPaid(price, shopAddress);
        }
    }

    function addBuyer(address _addr) public {
        // Делаем чтобы только владелец мог добавлять список покупателей
        require(owner == msg.sender, "You are not owner!"); 
        buyers[_addr] = true;
    }

    // является ли указанный адрес покупателем или нет
    function getBuyer(address _addr) public view returns(bool) {
        require(owner == msg.sender, "You are not owner!");
        return buyers[_addr];
    }

    // Вывод денег на свой счет
    function withDrawAll() public {
        // проверяем, чтобы только владелец мог снять деньги
        require(owner == msg.sender && fullyPaid && shopAddress.balance > 0, "Rejected!");
        // конвертируем отправителя в адрес, на которыйможно перечислять денежные средства
        address payable receiver = payable(msg.sender);
        receiver.transfer(shopAddress.balance);
    }
}