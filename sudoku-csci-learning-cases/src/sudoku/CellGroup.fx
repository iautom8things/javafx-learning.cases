/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package sudoku;

/**
 * @author Manuel Zubieta
 */
public class CellGroup {

    public-read var numbersContained: Boolean[] = [false, false, false, false, false,
                false, false, false, false];
    public-read var cellsContained: Cell[];

    public function contains(number: Integer): Boolean {
        return numbersContained.get(number - 1);
    }

    public function registerCell(cell: Cell): Void {
        insert cell into cellsContained;
    }

    public function isComplete(): Boolean {
        var i = 1;
        while (i < numbersContained.size() and contains(i))
            i++;
        return contains(i);
    }

    public function truthTable(): Boolean[] {
        return numbersContained;
    }

    public function changeTruthValue(number: Integer): Void {
        numbersContained[number - 1] = not (numbersContained[number - 1]);
    }

}
