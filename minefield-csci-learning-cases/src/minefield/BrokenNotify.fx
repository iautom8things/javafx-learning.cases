/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package minefield;

/**
 * @author mazubieta
 */

public class BrokenNotify extends ModularCode{
    public override function placeMines(): Void {
        var minesLeft = MINES;
        while (minesLeft > 0){
            var randomCell = game.random.nextInt(TOTAL);
            var cell = game.board[randomCell];
            notifyAdjacents(randomCell);
            while(not cell.hasMine){
                cell.hasMine=true;
                minesLeft--;
            }

        }

    }

}
