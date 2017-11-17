# SolidityBank
A simple bank implementation in Solidity.

## How it works
This contract is dead simple, and even includes a "tip jar".  The fallback function is `payable`, so anyone can send money.  It would cost too much gas to simply credit them their Ether in the fallback function, so we can assume that whatever they send is a tip.  

When a user calls `deposit()`, they add their address to the list, and the amount of Ether they sent, which is added to their balance AND the running total.  The running total keeps track of, simply put, how much money the bank actually owes.  Anything over that amount can be taken by the owner, when they run `ownerWithdraw()`.  

Any user can withdraw their balance at any time, by using `withdraw(uint256 amount)`.  

**NOTE: Amounts are in wei, NOT Ether.  This includes the `initAmount` argument, AND the `amount` argument in `withdraw`.  
-----PLAN ACCORDINGLY!-----**
