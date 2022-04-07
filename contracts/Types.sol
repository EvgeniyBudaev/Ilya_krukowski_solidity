// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

contract Types {
    // Boolean
    // state
    // Переменная хранится в блокчейне
    // Все переменные имеют значение по-умолчанию
    bool public myBool; // по-умолчанию false

    // Строки
    // Значение хранится в блокчейне
    string public myStr = "test"; // storage

    // Числа
    // unsigned integers (числа без знака, положительные числа)
    uint public myUint = 42;
    // 2 ** 256
    uint8 public mySmallUint = 2;
    // 2 ** 8 = 256;
    // signedintegers
    int public myInt = -42;
    int8 public mySmallInt = -1;
    // 2 ** 7 = 128, т.к. знак минус занимает один бит

    // Перечисления Enum
    enum Status { Paid, Delivered, Received }
    Status public currentStatus;

    // Массивы
    string [3] text;
    uint[10] public items = [1, 2, 3];
    uint[3][2] matrix;
    uint[] public dinamicArrays;

    // Массивы из последовательности Byte
    bytes1 public myVar; // размерность переменной 1байт или 8бит
    bytes public myDynVar = "text";
    bytes public myKirilica = unicode"привет!";

    // Struct
    struct Payment {
        uint amount;
        uint timestamp;
        address from;
        string message;
    }

    struct Balance {
        uint totalPayments;
        mapping(uint => Payment) payments;
    }

    mapping(address => Balance) public balances;

    function numberFunc(uint _inputUint) public {
        // local
        uint localUint = 42;
    }

    function stringFunc(string memory newValueStr) public {
        // Переменная существует пока работает функция
        // Т.е. временное хранение значения переменной
        string memory myTempStr = "temp";
        // Можем перезаписывать значения
        myStr = newValueStr;
     }

     function enumFunc() public {
         currentStatus = Status.Paid;
     }

    function arrayFunc() public {
         items[3] = 100;
         matrix = [
             [3, 4, 5],
             [6, 7, 8]
         ];
         dinamicArrays.push(4); // push доступен только для динамеческих массивов
     }

    // Создаем массив в памяти
    function sampleMemory() public view returns (uint[] memory) {
        uint[] memory tempArray = new uint[](10);
        tempArray[0] = 1;
        return tempArray;
    }

    function bytesFunc() public view returns(uint) {
        return myDynVar.length;
    }

    function structFunc(string memory message) public payable {
        uint paymentNum = balances[msg.sender].totalPayments;
        balances[msg.sender].totalPayments++;
        Payment memory newPayment = Payment(
            msg.value,
            block.timestamp,
            msg.sender,
            message
        );
        balances[msg.sender].payments[paymentNum] = newPayment;
    }

    function getPayment(address _addr, uint _index) public view returns(Payment memory) {
        return balances[_addr].payments[_index];
    }
}
