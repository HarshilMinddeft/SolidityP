// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.0;

contract structure{

        struct Superhero{
            uint256 age;
            string name;
            string ability;
            string catagory;
        }
            Superhero public sh;

//for inserting values of superhero
 // By using constructor
 // when we use constructor we have to initialize values first at time of deployment
constructor (uint _age, string memory _name , string memory _ability , string memory _catagory) public  {
                sh.age=_age;
                sh.name=_name;
                sh.ability=_ability;
                sh.catagory=_catagory;
        }

//To change Values from struct
            function changeVal(uint _age, string memory _name , string memory _ability , string memory _catagory) public {
                    Superhero memory new_Superhero = Superhero({
                        age:_age,
                        name:_name,
                        ability:_ability,
                        catagory:_catagory

                    });
                    sh=new_Superhero;
            }
        // By using function
        /* In function after deployment of contract we have to put values in */
        function getSP(string memory _name,string memory _ability, string memory _catagory, uint256 _age) public{
            sh.ability=_ability;
            sh.name=_name;
            sh.catagory=_catagory;
            sh.age=_age;
        }
}
