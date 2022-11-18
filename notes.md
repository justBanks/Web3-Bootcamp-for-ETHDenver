Events are inheritable members of contracts. When you emit an event, the arguments are stored on the blockchain. The indexed attribute can be added to a maximum of three parameters of an event to form a data structure known as a "topic." Topics allow users to search for events on the blockchain.  

When trading from a smart contract, the most important thing to keep in mind is that access to an external price source is required. Without this, trades can be frontrun for considerable loss.

`pragma abicoder v2;` allows arbitrary nested arrays and structs to be encoded and decoded in calldata, a feature used when executing a swap.