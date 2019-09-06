# TokenChase
Token Chase is a multi-round, completely autonomous game played by two players taking turns moving across a 7x7 game board in search of a randomly placed prize token.
 
### Game Mechanics & Requirements
1. At the start of each round, randomly place a prize token somewhere on the game board and start each player at opposite corners of the board.
2. Players should take turns on half-second intervals making legal game moves.
3. As each move is made the player will leave a trail of each space it has moved through during the round —
these trail spaces may not be passed through by the other player during the course of the round.
4. Each player may move either left, right, up, or down to an unoccupied and unvisited space. Diagonal moves
are not allowed.
5. If a player cannot move from its current position, it should hold its position until the end of the round.
6. The first player to reach the prize wins one point, the board then resets, and the next round starts. This
simulation should run continuously, keeping track of the total score for each robot during the game session.
