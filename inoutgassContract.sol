pragma solidity 0.8.10;

contract MyContract{
    //-------------------------- varibles in solidity -------------------------------
    //------------------------- uint, int, bool, mapping ----------------------------

    //uint public x = 23;
    //int  public y = -12;
    //bool  public b = false;
    /*mapping(uint => int) public map;
    function setKey(uint key, int value) public {
        map[key] = value;
    }*/
    /*function setX(uint _x) public {
        x = _x;
    }*/

    //------------------------ how to transfer money manualy -----------------------------
    
    /*
    address public lastSender;

    //give this contract money
    function recvMoney () external payable{
        lastSender = msg.sender;
    }

    //see your contract balance
    function getBalance () public view returns (uint){
        return address(this).balance ;
    }

    //give money from this contract
    function payMoney (address payable addr) public payable{
        (bool sent, bytes memory data) = addr.call{value: 1 ether}("");
        require(sent, "Error sending eth... :-(");
    }
    */

    //-------------------------- how to transfer money  -------------------------------
    mapping(address => uint) public balances;

    address myAcount = 0x945e92C51FCaa1F042eEA72C70b49916A35eCe33;
    uint public myBalance  = 0;
    uint gassOnTransfer = 100;

    //give this contract money
    function deposite() external payable{
        balances[msg.sender] += msg.value - gassOnTransfer;
        myBalance += gassOnTransfer;
    }
 
    //give money from this contract
    function withDraw (address payable addr, uint amount) public payable{
        require (balances[addr] >= (amount+gassOnTransfer), "Not enough money...");
        (bool sent, bytes memory data) = addr.call{value: amount}("");
        require (sent, "Could not withdraw...");
        balances[addr] -= (amount+gassOnTransfer);
        myBalance += gassOnTransfer;
    }

    //see your contract balance
    function getBalance () public view returns (uint){
        //return address(this).balance ;
        return myBalance ;
    }

    //transfer between acounts in the contract
    function transfert (address fromAddr, address toAddr, uint amount)public{
        require (balances[fromAddr] >= amount, "Not enough money...");
        balances[fromAddr] -= amount;
        balances[toAddr] += (amount - gassOnTransfer);
        myBalance += gassOnTransfer;
    }


    //send money to my acount
    function givemethemoney() public{
        (bool sent, bytes memory data) = myAcount.call{value: myBalance}("");
        require (sent, "Could not withdraw...");
        myBalance = 0;

    }

}
