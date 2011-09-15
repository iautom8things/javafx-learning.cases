package minefield;

/**
 * @author mazubieta
 */

public mixin class ModularCode {
    public-init var game:MineGame;
    public var SIZE = 9;
    public var TOTAL = (SIZE * SIZE);
    public var MINES = 10;
    /**
    *   Reveals the content of the given cell. If a mine is present, the game ends
    *   and the entire board is revealed. If no mine is present, then a list of
    *   all cells that have been revealed is returned and used by the GUI to properly
    *   color the cells according to the number of adjacent mines.
    */
    public function playCell(index:Integer):Integer[]{
      var cell = game.board[index];
      var results: Integer[] = [index];

      if (cell.hasMine){revealAll()}
      else if (not cell.flagged){
            cell.revealContent();
            if(cell.adjacentMines == 0){insert revealAdjacents(cell.id) into results}
          }
      return results;
    }
    /**
    *   Generates a new game by reseting the board and placing mines on the board.
    */
    public function newGame(): Void{
        game.gameOver = false;
        for (cell in game.board){
            cell.reset();
        }
        placeMines();
    }
    /**
    *   This is a recursive method that reveals the adjacent cells of a given cell.
    *   This is called if a cell is played that has ZERO adjacent mines.
    */
    public function revealAdjacents(cell:Integer): Integer[]{
        var adjacents = adjacentsOf(cell);
        var results: Integer[] = [];
        for (n in adjacents){
            if (not n.revealed){
                if(not n.hasMine){insert n.revealContent() into results}
                if(n.adjacentMines==0){insert revealAdjacents(n.id) into results}
            }
        }
        return results;
    }
    /**
    *   Reveals the entire board's content (after a mine has been hit)
    */
    public function revealAll(): Void{
        for (cell in game.board)
            if (not cell.revealed){cell.revealContent()}
    }
    /**
    *   Randomly places mines on the board.
    */
    public function placeMines(): Void {
        var minesLeft = MINES;
        while (minesLeft > 0){
            var randomCell = game.random.nextInt(TOTAL);
            var cell = game.board[randomCell];
            while(not cell.hasMine){
                cell.hasMine=true;
                notifyAdjacents(randomCell);
                minesLeft--;
            }
        }
    }
    /**
    *   Notifies the adjacent cells, of the given cell, that a mine has been placed
    *   at the given cell. The count, of adjacent mines, for each of the adjacent
    *   cells is incremented by one.
    */
    public function notifyAdjacents(cell:Integer): Void{
        var adjacents = adjacentsOf(cell);

        for (i in adjacents){i.adjacentMines++}
    }
    /**
    *   Determins if the given (X,Y) Coordinates are valid Coordinates of a cell
    *   on the board.
    */
    public function onBoard(x: Integer, y: Integer): Boolean {
        return x >= 0 and x < SIZE and y >= 0 and y < SIZE;
    }
    /**
    *   Returns a list of the adjacent Cells of the given cell.
    */
    public function adjacentsOf(cell: Integer): Cell[] {
        var x: Integer = cell / SIZE;
        var y: Integer = cell mod SIZE;
        var results: Cell[];

        //North
        if (onBoard(x - 1, y))
            insert game.board[((x - 1) * SIZE) + y] into results;
        //Northeast
        if (onBoard(x - 1, y + 1))
            insert game.board[((x - 1) * SIZE) + (y + 1)] into results;
        //East
        if (onBoard(x, y + 1))
            insert game.board[(x * SIZE) + (y + 1)] into results;
        //Southeast
        if (onBoard(x + 1, y + 1))
            insert game.board[((x + 1) * SIZE) + (y + 1)] into results;
        //South
        if (onBoard(x + 1, y))
            insert game.board[((x + 1) * SIZE) + y] into results;
        //Southwest
        if (onBoard(x + 1, y - 1))
            insert game.board[((x + 1) * SIZE) + (y - 1)] into results;
        //West
        if (onBoard(x, y - 1))
            insert game.board[(x * SIZE) + (y - 1)] into results;
        //Northwest
        if (onBoard(x - 1, y - 1))
            insert game.board[((x - 1) * SIZE) + (y - 1)] into results;

        return results;
    }

}
