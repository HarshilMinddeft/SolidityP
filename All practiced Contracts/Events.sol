// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.8.2 <0.9.0;

contract events{

        event bal(address user, string messgae, uint value);

        function addbal(uint _value) public {
        emit bal(msg.sender,"has val",_value);

        }

}

contract chat{

                event who(address indexed to, address from , string message);
                function setaddressMsg(address _to , string memory _messgae) public{
                    emit who(msg.sender,_to,_messgae);
                }

}