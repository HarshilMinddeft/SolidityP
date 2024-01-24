// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.8.2 <0.9.0;


contract Avanger {}
contract Ironman is Avanger {}
// This will not compile
contract Thor is Avanger,Ironman {}

////////////////////////////////////////////////////////////////////////////////////////////////////

contract X {}
contract A is X {}
// This will not compile
// If we Change position of A,X to X,A it will compile and there will be no error
contract C is A, X {}

////////////////////////////////////////////////////////////////////////////////////////////////////

contract Base1 {
    constructor() {}
}
contract Base2 {
    constructor() {}
}
// Constructors are executed in the following order:
// 1  Base1
// 2  Base2
// 3  Derived1
contract Derived1 is Base1, Base2 {
    constructor() Base1() Base2() {}
}

contract Derived2 is Base2, Base1 {
    constructor() Base2() Base1() {}
}

contract Derived3 is Base2, Base1 {
    constructor() Base1() Base2() {}
}
