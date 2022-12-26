With a secure cryptographic hash function you can create a unique, fixed-size representation of an input regardless of its size. For blockchains this feature is critically important for saving space. In many cases blockchains and smart contracts will not need to store an input, they can just store the hash output.  
---
#### The Mempool 

Users who want to make transactions will broadcast their transactions to the blockchain network. The mempool is a place for miners to keep those transactions before adding them to a block.  

Typically, the miner will take all the transactions with the highest transaction fees from the mempool. Then they'll add them to the block and attempt to find the proof of work.  
---

Events are inheritable members of contracts. When you emit an event, the arguments are stored on the blockchain. The indexed attribute can be added to a maximum of three parameters of an event to form a data structure known as a "topic." Topics allow users to search for events on the blockchain.  

When trading from a smart contract, the most important thing to keep in mind is that access to an external price source is required. Without this, trades can be frontrun for considerable loss.

`pragma abicoder v2;` allows arbitrary nested arrays and structs to be encoded and decoded in calldata, a feature used when executing a swap.