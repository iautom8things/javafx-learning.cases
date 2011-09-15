/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package tictactoe;

/**
 * @author mazubieta
 */

public class BrokenTurn extends ModularCode{
public override function takeTurn(square:Integer): Boolean{
        if ((not game.gameOver) and (game.board[square] == " ")){
            var x = square / 3;
            var y = square mod 3;
            var row = y;
            var col = x;
            var n = (row*3)+col;
            game.board[n]=game.players[game.turnsTaken mod 2];
        }
        game.turnsTaken++;
        return evaluateBoard(square);
    }
}
