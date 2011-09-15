package minefield;

import java.util.Random;

/**
 * @author mazubieta
 */
public class MineGame {
    public var modularCode:ModularCode = OriginalCode{game:this};
    public var SIZE = 9;
    public var TOTAL = (SIZE * SIZE);
    public var MINES = 10;
    public var random = new Random();
    public var gameOver = false;
    public var board: Cell[];

    postinit {
        for (i in [0..<TOTAL]) {
            board[i] = Cell {
                        id: i
                    }
        }
        modularCode.placeMines();
    }


/*******************************************************************************
************                      Public                         ***************
*******************************************************************************/

    public function playCell(index:Integer):Integer[]{
      modularCode.playCell(index);
    }
    public function newGame(): Void{
        modularCode.newGame();
    }
    public function revealAdjacents(cell:Integer): Integer[]{
        return modularCode.revealAdjacents(cell);
    }
    }