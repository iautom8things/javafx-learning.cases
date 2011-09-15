/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package sudoku;

/**
 * @author Manuel Zubieta
 */

 public class BrokenGameOver extends ModularCode{
     /**
     *
     * Broke Condition Statement. Removed "result and" from while condition statement.
     *
     */
     override function gameOver(){
        var result = true;
        var i = 0;

        while (i<9) {
            result = game.rows[i].isComplete() and game.columns[i].isComplete() and game.squares[i].isComplete();
            i++;
        }
        return result;
    }


}
