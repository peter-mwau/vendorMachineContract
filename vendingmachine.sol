// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.20;

contract VendingMachine{
    address public  owner;
    mapping (address => uint) public donutBalances;

    constructor(){
        owner = msg.sender;
        donutBalances[address(this)] = 100;
    }

    function getVMBalance() public view returns(uint){
        return donutBalances[address(this)];
    }

    function restockVM(uint amount) public {
        require(msg.sender == owner, "Only the Owner can restock this machine");
        donutBalances[address(this)] += amount;
    }

    function Purchase(uint amount) public payable {
        require(msg.value >= (amount * 2 ether), "Not enough balance to make purchase, Please top up");
        require(donutBalances[address(this)] >= amount, "Not enough donuts in stock to pull your request");
        donutBalances[address(this)] -= amount;
        donutBalances[msg.sender] += amount;
    }
}