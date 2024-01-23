// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.0;

//Simple mapping
contract mappingg{

    mapping(uint256=>string[]) public roll_no;

    function insert(uint256 key, string[] memory value) public {
        roll_no[key]=value;
    }
}

//Inserting multiple values in mapping

contract multimap{

    struct Marval{
        string name;
        uint age;
        string ability;
    }

    mapping(uint256=>Marval) public data;

    function Superinsert(uint _key, string  memory _name, uint _age, string memory _ability) public {
            data[_key]=Marval(_name,_age,_ability);
    }

}

//mapping eg 2

contract mapping2{

  struct Emps{
        string name;
        string surname;
        uint age;
        address user;
     }
        mapping(uint256=>Emps) public Data;
        function insertinfo(uint _key, string memory _name, string memory _surname, uint _age, address _user) public {
            Data[_key]=Emps(_name,_surname,_age,_user);
    }
}
