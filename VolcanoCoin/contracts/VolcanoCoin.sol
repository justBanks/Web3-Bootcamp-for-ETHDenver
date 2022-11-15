// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.0;
import "@openzeppelin/contracts/access/Ownable.sol";

contract VolcanoCoin is Ownable {

    uint private totalSupply = 10000;
    mapping(address => uint) public balances;
    struct Payment {
        address recipient;
        uint amount;
    }
    mapping(address => Payment[]) private Payments;

    // event for EVM logging
    event MintCoins(uint indexed oldSupply, uint indexed newSupply);
    event Sent(address sender, address receiver, uint amount);
    
    constructor() Ownable() {
        balances[owner()] = totalSupply;
    }

    function getTotalSupply() public view returns (uint) {
        return totalSupply;
    }

    function mint() public onlyOwner {
        totalSupply += 1000;
        emit MintCoins(totalSupply - 1000, totalSupply);
    }

    // Errors allow you to provide information about
    // why an operation failed. They are returned
    // to the caller of the function.
    error InsufficientBalance(uint requested, uint available);

    function transfer(uint amount, address receiver) public {
        if (amount > balances[msg.sender])
            revert InsufficientBalance({
                requested: amount,
                available: balances[msg.sender]
            });

        balances[msg.sender] -= amount;
        balances[receiver] += amount;
        Payments[msg.sender].push(Payment(receiver, amount));
        emit Sent(msg.sender, receiver, amount);
    }
    
    function recordPayment(address sender, address receiver, uint amount) private {
        Payments[sender].push(Payment(receiver, amount));
    }

    function viewPayments (address sender) external view returns(Payment[] memory) {
        return Payments[sender];
    }
    
}