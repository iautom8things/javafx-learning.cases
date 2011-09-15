/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package tictactoe;

/**
 * @author mazubieta
 */

public class TicTacToeGame {
    public var modularCode:ModularCode = OriginalCode{game:this};
    public var SIZE = 3;
    public var turnsTaken = 0;
    public var winner = -1;
    public var gameOver = false;
    var TOTAL = SIZE*SIZE;
    public var board: String[];
    public var players = ["X","O"];

    init{
        for (i in [0..<TOTAL]){insert " " into board}
    }

    public function newGame():Void{
        modularCode.newGame();
    }

    public function takeTurn(square:Integer): Boolean{
        return modularCode.takeTurn(square);
    }

    public function evaluateBoard(square:Integer): Boolean{
        return modularCode.evaluateBoard(square);
    }
}
