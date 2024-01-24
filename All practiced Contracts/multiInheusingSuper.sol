// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.8.2 <0.9.0;


contract Owned {
    constructor() {
        owner = payable(msg.sender);
    }

    address payable public owner;
}

contract Destructible is Owned {
    function destroy() public virtual {
        selfdestruct(owner);
    }
}

contract Base1 is Destructible {
    function destroy() public virtual override {
        super.destroy();
    }
}

contract Base2 is Base1 {
    function destroy() public virtual override {
        super.destroy();
    }
}

contract Final is Base1, Base2 {
    function destroy() public override(Base1, Base2) {
        super.destroy();
        Base1.destroy();
        Base2.destroy();
        
    }
}