/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package sudoku;

import java.util.Random;
import javafx.util.Sequences;

/**
 * @author Manuel Zubieta
 */
 
public mixin class ModularCode {

    public-init var game: SudokuGame;
    public var random: Random = new Random();

    /**
     * Determines if board is complete.
     */

    public function gameOver(): Boolean {
        var result = true;
        var i = 0;

        while (result and i < 9) {
            result = result and game.rows[i].isComplete() and game.columns[i].isComplete() and game.squares[i].isComplete();
            i++;
        }
        return result;
    }

    /**
     * Clears the entire board.
     */

    public function clearBoard(): Void {
        for (i in game.board) {
            i.clearCell();
            i.setEditable(false);
        }
    }

    /**
     * Determines which square grouping a cell belongs to.
     */

    public function whichSquare(cell: Integer): Integer {
        var row = cell / 9;
        var column = cell mod 9;
        var square;

        if (row == 0 or row == 1 or row == 2) {
            if (column == 0 or column == 1 or column == 2) { square = 0; } 
            else if (column == 3 or column == 4 or column == 5) { square = 1; }
            else { square = 2; }
        }
        else if (row == 3 or row == 4 or row == 5) {
            if (column == 0 or column == 1 or column == 2) { square = 3; } 
            else if (column == 3 or column == 4 or column == 5) { square = 4; }
            else { square = 5; }
        }
        else if (column == 0 or column == 1 or column == 2) { square = 6; }
        else if (column == 3 or column == 4 or column == 5) { square = 7; }
        else { square = 8; }

        return square;
    }

    /**
     * Generates a playable game given the number of cells to remove.
     */

    public function generateGame(numberToRemove: Integer): Void {
        clearBoard();
        game.findSolution();
        var removedCells: Integer[];

        for (i in [1..numberToRemove]) {
            var cellToClear = random.nextInt(80);
            while (contains(cellToClear, removedCells)) {
                cellToClear = random.nextInt(80);
            }
            game.board[cellToClear].clearCell();
            game.board[cellToClear].setEditable(true);
        }
    }

    /**
     * Determines if the given Integer is contained in the given Integer Sequence.
     */

    function contains(index: Integer, indexList: Integer[]): Boolean {
        var result = true;
        var size: Integer = indexList.size();

        if (size == 0) {
            result = false;
        } else {
            for (i in [0..size])
                result = result and index.equals(indexList[i]);
        }
        return result;//Come back
    }

    /**
     * Returns a sorted sequence of the remaining unplayed board.
     */

    public function sortedUnplayedList(): Cell[] {
        var unplayedCells: Cell[];

        for (i in [0..80]) {
            var currentCell: Cell = game.board[i];

            if (currentCell.number == 0)
                insert currentCell into unplayedCells;
        }
        Sequences.sort(unplayedCells);
        return unplayedCells;
    }

    /**
     * Returns the list of groups a given cell belongs to.
     */

    public function belongsToGroups(cell: Integer): CellGroup[] {
        var cellsGroup: CellGroup[];

        insert game.rows[cell / 9] into cellsGroup;
        insert game.columns[cell mod 9] into cellsGroup;
        insert game.squares[whichSquare(cell)] into cellsGroup;

        return cellsGroup;
    }

    /***************************************************************************
     ************************   Recursive    ************************************
     **********************   Back Tracking    **********************************
     ***********************   Board Solver    **********************************
     ***************************************************************************/

    public function findSolution(): Boolean {
        if (sortedUnplayedList().size() < 1)
            clearBoard();
        var firstPlay: Cell = sortedUnplayedList()[0];

        return findSolution(firstPlay);
    }

    public function findSolution(currentCell: Cell): Boolean {
        var result = false;
        if (gameOver()) { result = true; } else {
            var possiblePlays = currentCell.possiblePlays();
            var size = possiblePlays.size();
            if (size < 1) {
                result = false;
                currentCell.clearCell();
            } else { //Cell has at least 1 possible play
                for (i in [0..(size - 1)]) {
                }

                var playedIndexes: Integer[];
                for (i in [0..(size - 1)]) {
                    var index = random.nextInt(size);
                    while (contains(index, playedIndexes)) {
                        index = random.nextInt(size);
                    }
                    insert index into playedIndexes;
                    currentCell.setNumber(possiblePlays[index]);
                    if (sortedUnplayedList().size() > 0) {
                        var nextPlay: Cell = sortedUnplayedList()[0];
                        result = findSolution(nextPlay);
                    } else { result = true; }
                    if (result) { break; } else { currentCell.clearCell(); }
                }
            }
        }
        return result;
    }
}
