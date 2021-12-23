// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

contract Person {

    address public owner ;
    mapping (address => uint) accounts;
    uint public romPrice = 4000 * 15/100;
    string myName = 'Rom';

    event Message(
        string msg
    );

    struct RomProperties {
        uint health;
        uint cash;
        uint time;
        uint happiness;
    }
    
    RomProperties public prop;

    modifier onlyOwner(){
        require(msg.sender == owner);
        _;
    }

    function playBasketball() public onlyOwner {
        prop.health += 15;
        prop.time -= 10;
        prop.happiness += 20;
    }

    function work() public onlyOwner {
        prop.time -= 30;
        prop.happiness -= 20;
        prop.cash +=50;
    }

    function orderPizza() public onlyOwner {
        prop.health -= 30;   
        prop.happiness += 70;
        prop.cash -=20;

    }

    constructor() {
        prop = RomProperties(100,100,100,100);
    }

    function pumpIt(uint _precentage) public onlyOwner {
        romPrice *= (100 + _precentage)/ 100;
    }

    function dumpIt(uint _precentage) public onlyOwner {
        romPrice *= (100 - _precentage)/ 100;
    }

    function deposit() public payable { 
        accounts[msg.sender] += msg.value / romPrice;
        emit Message("deposit!");
    }
    function withdraw(uint amount) public returns (bool){ 
        uint requestedAmount = amount / romPrice;
        if(accounts[msg.sender] >= requestedAmount) {
            accounts[msg.sender]-= requestedAmount;
            payable(msg.sender).transfer(amount); 
            emit Message("withdraw!");
            return true;
        }
        emit Message("no withdraw!");
        return false;
    }

    function getProps() public view returns (RomProperties memory) {
        return prop;
    }
    
    /**
     * @dev Returns the person's name
     */
    function name() public view returns (string memory) {
        return myName;
    }

    
}
