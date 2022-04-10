// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

contract ParentA {
    uint public value;

    constructor(uint _input) {
        value = _input;
    }

    // private - функция доступна только в данном контракте
    // internal - функция доступна в данном контракте Sи в наследниках
    // virtual - функцию можно переопределять в потомках
    function myFunc() public pure virtual returns(uint) {
        return 42;
    }
}

contract ChildA is ParentA {
    uint public childValue;
    constructor(uint _input) ParentA(_input) {
        childValue = _input;
    }
    function myFunc() public pure override returns(uint) {
        uint result = super.myFunc();
        return result * 2;
    }
} 

// contract ChildA is ParentA(42) {
//     function myFunc() public pure override returns(uint) {
//         uint result = super.myFunc();
//         return result * 2;
//     }
// } 

// Множественное наследование возможно contract ChildB is ParentA, ChildA, ... {}
contract ChildB is ParentA(42) {
    function demo() public pure returns(uint) {
        // return super.myFunc();
        return ParentA.myFunc();
    }
}
