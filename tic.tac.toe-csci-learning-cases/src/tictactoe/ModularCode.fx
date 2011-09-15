/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package tictactoe;

/**
 * @author mazubieta
 */

public mixin class ModularCode {
    public-init var game: TicTacToeGame;
    var SIZE = 3;
    var TOTAL = SIZE*SIZE;



    public function newGame():Void{
        for (i in [0..<TOTAL]){game.board[i] = " "}
        game.gameOver = false;
        game.turnsTaken = 0;
        game.winner = -1;
    }

    public function takeTurn(square:Integer): Boolean{
        if ((not game.gameOver) and (game.board[square] == " ")){
            game.board[square]=game.players[game.turnsTaken mod 2];
        }
        game.turnsTaken++;
        return evaluateBoard(square);
    }

    public function evaluateBoard(square:Integer): Boolean{
        var result = false;

        if (game.turnsTaken>=((SIZE*2)-1)){ //least number of turns to a "win"
            var player = game.board[square];
            var row = square/SIZE;
            var i = row*(SIZE);//iterate over row
            var j = square mod SIZE;//iterate over
            result = true;

            while ((i/SIZE == row) and result){
                result = player.equals(game.board[i++]);
            }
            if (not result){    //If a winner isn't on the row, check the column
                result = true;

                while ((j<TOTAL) and result){
                    result = player.equals(game.board[j]);
                    j+=SIZE;
                }
            }
            var l =0;           //top-left to bottom-right diagnol
            if ((not result) and (square mod (SIZE+1) == 0)){
                result = true;
                while ((l<TOTAL) and result){
                    result = player.equals(game.board[l]);
                    l+=(SIZE+1);
                }
            }
            var k = (SIZE-1);   //top-right to bottom-left diagnol
            if ((not result) and (square mod k == 0)){
                result = true;
                while ((k<(TOTAL-2)) and result){
                    result = player.equals(game.board[k]);
                    k+=(SIZE-1);
                }
            }
        }
        if (result){
            game.winner = ++game.turnsTaken mod 2;
        }
        game.gameOver = result;
        return result;
    }
}
