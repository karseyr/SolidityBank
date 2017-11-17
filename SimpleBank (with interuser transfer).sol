pragma solidity ^0.4.15;
contract MyBankAccount {
    mapping(address => uint256) public balanceOf;
    uint256 bankBalance;
    address public owner;
    
    function MyBankAccount(uint256 initAmount) payable{ //Initial Function
        owner = msg.sender;//Set the owner to the contract creator.
        bankBalance = initAmount;//IMPORTANT: initAmount MUST be = to the initial funding amount.
    }
    
    function () payable{
        //In case someone sends in money, and does not specify a function.  Who doesn't want free money??
        //It's too expensive to credit them the Ether in here.  Oh well!
    }
    function withdraw(uint256 amount) hasMoney notAnOverdraw(amount){
        balanceOf[msg.sender] -= amount;//Remove their money first, as according to "withdrawal pattern"
        msg.sender.transfer(amount);//Send them their money.
    }
    function deposit() payable{
        bankBalance += msg.value;//Add the deposit to the money that the owner may NOT touch.
        balanceOf[msg.sender] += msg.value;//Add their deposit to their balance.
    }
    function ownerWithdrawal() isOwner{
        uint256 extrafunds = this.balance - bankBalance;//Find out if there is any "free money", by subtracting the actual contract's balance from the Ether allocated to user's addresses.
        if(extrafunds != 0 && (extrafunds-1) > 0){//Is there "free money"?
            msg.sender.transfer(extrafunds-1);//Send it to the owner!
        }
    }
    function transfer(address otherUser, uint256 amount) canTransfer(amount){
        balanceOf[msg.sender] -= amount;
        balanceOf[otherUser] += amount;
    }
    
    
    modifier hasMoney(){
        require(balanceOf[msg.sender] > 0);//If the sender has a balance greater than 0
        _;
    }
    modifier notAnOverdraw(uint256 val){
        require(balanceOf[msg.sender] >= val);//Require sender's withdrawal to be no more than their balance
        require(this.balance >= val);//Require the withdrawal to not kill the contract :)
        _;
    }
    modifier canTransfer(uint256 val){
        require(balanceOf[msg.sender] > 0);//If the sender has a balance greater than 0
        require(balanceOf[msg.sender] >= val);//Require sender's withdrawal to be no more than their balance
        _;
    }
    modifier isOwner(){
        require(msg.sender == owner);//Is the msg.sender the owner?
        _;
    }
   
}
