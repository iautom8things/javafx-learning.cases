/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package sudoku;

/**
 * @author Manuel Zubieta
 */
public class Cell extends java.lang.Comparable {

    public var number: Integer = 0;
    public var id: Integer;
    public-read var editable = false;
    public-init var groups: CellGroup[];
    public-read var possibles: Integer[];

    init {
        for (i in [0..2])
            groups[i].registerCell(this);
        possibles = possiblePlays();
    }

    public function setEditable(bool:Boolean): Void{
        editable = bool;
    }

    public function setNumber(newNumber: Integer): Void {
        var old = this.number;

        if (validNumber(newNumber)) {
            if (old != 0) { //Has a number already been played? If so...
                for (i in [0..2]) { //Check if this cell's group
                    if (groups[i].contains(old))
                        groups[i].changeTruthValue(old); //notify groups that old number is no longer played
                }
            }
            number = newNumber; //Set the new number

            for (i in [0..2]) {
                if (not groups[i].contains(number)) //if the group doesn't already contain this number
                    groups[i].changeTruthValue(number); //Change it so it does
            }
        }
    }

    function validNumber(number: Integer): Boolean {
        return not groups[0].contains(number) and not groups[1].contains(number)
                and not groups[2].contains(number);
    }

    public function clearCell(): Void {
        if (number != 0) {
            for (i in [0..2]) {
                if (groups[i].contains(number))
                    groups[i].changeTruthValue(number);
            }

        }
        number = 0;
    }

    public function possiblePlays(): Integer[] {
        var possiblePlays: Integer[];
        for (i in [1..9]) {
            if (validNumber(i))
                insert i into possiblePlays;
        }
        possibles=possiblePlays;
        return possibles;
    }

    public override function compareTo(cell: Object): Integer {
        return (possiblePlays().size() - (cell as Cell).possiblePlays().size());
    }

}
