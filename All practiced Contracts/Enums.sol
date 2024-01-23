// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.8.2 <0.9.0;

contract ExampleEnum {
    enum State {Pending, Approved, Rejected}

    State public currentState;

    constructor() {
        currentState = State.Pending;
    }
    function approve() public {
        currentState = State.Approved;
    }

    function reject() public {
        currentState = State.Rejected;
    }

}
/////////////////////////////////////////////////////////////////////////////////////////////////

    contract Super{

  enum Superheros{Ironman, Batman, Thor}

   Superheros public h1= Superheros.Thor;

    string public ability="Ancient";

  function owner() public view returns(string memory superheroAbility) {

    if(h1==Superheros.Thor){ 
        return ability;
    }
  }
}


contract emumss{

    enum emps{parth,vishal,harshil}

    emps public e1=emps.harshil;

     string value="harshil";

     function demo() view public returns(string memory employees){
        if(e1==emps.harshil){
            return value;
        }
     }
}

// contract calculator{

//     uint256 public value;

//     function add(uint sum) public{
//         value+=sum;
//     }
//     function sub(uint minus) public{
//         value-=minus;
//     }
//     function mul(uint multi) public {
//         value*=multi;
//     }
//     function div(uint divide) public{
//         value/=divide;
//     }
// }
