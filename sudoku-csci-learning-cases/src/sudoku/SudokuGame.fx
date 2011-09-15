/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package sudoku;

/**
 * @author Manuel Zubieta
 */
public class SudokuGame {

    public-read var board: Cell[];
    public var rows: CellGroup[];
    public var columns: CellGroup[];
    public var squares: CellGroup[];
    public var modularCode: ModularCode = OriginalCode { game: this };

    init {
        for (i in [0..8]) {
            rows[i] = CellGroup {};
            columns[i] = CellGroup {};
            squares[i] = CellGroup {};}
        for (j in [0..80])
            board[j] = Cell {id: j; groups: belongsToGroups(j);}
    }

    public function whichSquare(cell: Integer): Integer {
        modularCode.whichSquare(cell)}

    function belongsToGroups(cell: Integer): CellGroup[] {
        return modularCode.belongsToGroups(cell)}

    public function gameOver(): Boolean {
        return modularCode.gameOver()}

    public function clearBoard(): Void {
        modularCode.clearBoard()}

    public function sortedUnplayedList(): Cell[] {
        return modularCode.sortedUnplayedList()}

    public function findSolution(): Boolean {
        return modularCode.findSolution()}

    public function generateGame(numberToRemove: Integer): Void {
        modularCode.generateGame(numberToRemove)}
}
