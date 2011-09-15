/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package minefield;

/**
 * @author mazubieta
 */
public class BrokenMinePlacement extends ModularCode {

    public override function placeMines(): Void {
        while (MINES > 0) {
            var randomCell = game.random.nextInt(TOTAL);
            var cell = game.board[randomCell];
            while (not cell.hasMine) {
                cell.hasMine = true;
                notifyAdjacents(randomCell);
                MINES--;
            }

        }

    }

}
