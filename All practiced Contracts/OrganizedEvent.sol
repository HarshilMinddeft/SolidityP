// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.8.2 <0.9.0;

contract EventsContract{
    struct Eve{
        address Organizer;
        string name;
        uint date;
        uint price;
        uint TicketCount;
        uint TicketRemaning;
    }
    mapping(uint=>Eve) public events;
    mapping (address=>mapping(uint=>uint)) public tickets;
    uint public nextID;

    function createEvent(string memory name,uint date,uint price, uint TicketCount)external {
        //condition for checking user dosent create event for past date or time 
            require(date>block.timestamp, "Create event for correct date for future ");
        //condition for checking user dosent creat event for 0 tickets
            require(TicketCount>0,"Please enter ticket above 0 it should atleast 1");
        //For giving Id to event if we create multiple events (mapping is used)
            events[nextID]= Eve(msg.sender,name,date,price,TicketCount,TicketCount);
        // Id will automatic increase 0 to 1 and so on when multiple events created
            nextID++;
    }
    function buyTicket(uint id, uint quantity) external payable{
        // While buying ticket event is there or not
        require(events[id].date!=0,"Event dosent exist");
        // Event is already finished
        require(events[id].date>block.timestamp,"Event has already occured");
        Eve storage _event = events[id];
        // To check user is paying price as per ticket price
        require(msg.value==(_event.price*quantity),"Ether is not enought");
        // To check for buying tickets are left or not
        require(_event.TicketRemaning>=quantity,"Not enought Tickets");
        // sending tickets to buyer
        _event.TicketRemaning-=quantity;
        // user account tickets will be credited 
        tickets[msg.sender][id]+=quantity;

    }
    function transferTicket(uint id, uint quantity, address to) external {
        require(events[id].date!=0,"Event dosent exist");
        require(events[id].date>block.timestamp,"Event has already occured");
        // User is sending tickets as per awailable quantity user have
        require(tickets[msg.sender][id]>=quantity,"You dont have enought tickets");
        tickets[msg.sender][id]-=quantity;
        tickets[to][id]+=quantity;
    }
}
