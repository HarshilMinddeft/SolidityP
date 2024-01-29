// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.8.2 <0.9.0;

abstract contract avangers{
    function thor() public virtual  returns(string memory);
}
contract Thor is avangers{
            function thor() public pure virtual override returns(string memory){
                return "SGuard";
            } 
} 
contract Ironman is Thor{
     function thor() public pure override returns(string memory){
        return "NewYork";
     }
}

// In interface we have to Specify what we have to override 
interface  Avanger {
        function Blackpanther() external  view returns(string memory);
}
interface marvel {
        function Blackpanther() external view returns(string memory);
}

interface SuperheroUn is Avanger,marvel {
        function Blackpanther() external override(Avanger,marvel) view returns(string memory);

}