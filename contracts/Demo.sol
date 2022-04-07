// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

contract MyShop {
    // Сохранение владельца контракта
    address public owner;
    // uint - числа только положительные
    // payments - информация о плательщеке
    mapping (address => uint) public payments;

    constructor() {
        // устанавливаем владельца того,
        // кто контракт разместил
        owner = msg.sender;
    }

    // Функция оплаты за некий товар
    // Эту функцию вызывают покупатели
    // payable - возможность принимать деньги
    function payForItem() public payable {
        // Сохраняем информацию кто деньги прислал
        payments[msg.sender] = msg.value;
    }

    // Функция для вывода денег на аккаунт
    function withDrawAll() public {
        address payable _to = payable(owner);
        address _thisContract = address(this);
        _to.transfer(_thisContract.balance);
    }
}
