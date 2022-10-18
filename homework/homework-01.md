# Homework 1
Discuss in your teams what a decentralised version of a game like monopoly would be like,
if there was no software on a central server.


Consider
- What are the essential pieces of functionality ?
- How would people cheat ?
- How could you prevent them from cheating ?

---

Essential functionality would include some sort of random roll of the dice to dictate movement around the board, data structures for cash and property holdings, and transactions to adjust each player's holdings.

With no contolling software, a mechanism for truly random dice rolling is needed. A roll of the dice must be 1) tamper-proof, and 2) unpredictable, to prevent simulating future player moves in advance.

To simulate a random dice roll on each player's turn, I envision using a predetermined mathematical function that takes numbers chosen by all players as input and returns the number of tiles in the next move (a number between 2 and 12). At the conclusion of each turn, each player gets a snapshot of the current game state.