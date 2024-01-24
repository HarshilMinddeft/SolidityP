// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.8.2 <0.9.0;

contract arrin{
   uint[] public use;
   function addele(uint i) public virtual  {
     use.push(i);
    
   }
   function returnallEle() public view returns (uint[]memory){
      return use;
   }
}

contract arr2 is arrin{

    function addele(uint i) public virtual override  {
            use.push(i);
    }
}

contract arr3 is arr2{
    function removeele() public  virtual  {
        use.pop();
    }
}

contract finalarr is arr3{
    function addele(uint i ) public override {
        use.push(i);
    }
}
