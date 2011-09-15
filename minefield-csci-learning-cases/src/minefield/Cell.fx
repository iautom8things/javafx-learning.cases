package minefield;

/**
 * @author mazubieta
 */

public class Cell {
    public var hasMine = false;
    public var revealed = false;
    public var flagged = false;
    public var content="";
    public-init var id: Integer;
    public var adjacentMines = 0;
    /**
    *   Reveals the content of the cell after a play has been made.
    */
    public function revealContent():Integer{
        revealed = true;
        if (hasMine){content = "X"}
        else if(adjacentMines == 0){content = " "}
        else{content = "{adjacentMines}"}
        return id;
    }
    /**
    *	Resets the cell to an initial state that contains no mines, is neither
    *	flagged nor revealed.
    */
    public function reset(): Void{
        hasMine = false;
        revealed = false;
        flagged = false;
        adjacentMines = 0;
        content="";
    }
}
