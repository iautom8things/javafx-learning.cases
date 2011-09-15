package boggle;

/**
 * @author mazubieta
 */
import java.util.LinkedList;

public class BoggleGame {
    public var modularCode: ModularCode = OriginalCode{game: this}
    public var score = 0;
    public-read def SIZE = 4;
    public var playedWords: String[];
    public var word = "";
    public var playPath = new LinkedList();
    public var tray = [Cube { sides: ["A", "A", "E", "E", "G", "N"] }, Cube { sides: ["H", "I", "M", "N", "Qu", "U"] }, Cube { sides: ["A", "C", "H", "P", "O", "S"] }, Cube { sides: ["A", "F", "F", "K", "P", "S"] }, Cube { sides: ["H", "L", "N", "N", "R", "Z"] }, Cube { sides: ["D", "E", "L", "V", "R", "Y"] }, Cube { sides: ["E", "E", "I", "N", "S", "U"] }, Cube { sides: ["D", "E", "I", "L", "R", "X"] }, Cube { sides: ["E", "I", "O", "S", "S", "T"] }, Cube { sides: ["A", "O", "O", "T", "T", "W"] }, Cube { sides: ["E", "E", "G", "H", "N", "W"] }, Cube { sides: ["E", "L", "R", "T", "T", "Y"] }, Cube { sides: ["C", "I", "M", "O", "T", "U"] }, Cube { sides: ["E", "H", "R", "T", "V", "W"] }, Cube { sides: ["D", "I", "S", "T", "T", "Y"] }, Cube { sides: ["A", "B", "B", "J", "O", "O"] },];

    public function newGame(): Void {modularCode.newGame()}
    public function clearPath(): Void{modularCode.clearPath()}
    public function shake(): Void{modularCode.shake()}
    public function submit(): Void{modularCode.submit()}
    public function playCube(cube: Integer): Boolean {return modularCode.playCube(cube)}
    public function adjacentsOf(cell: Integer): Integer[] {return modularCode.adjacentsOf(cell)}
    public function onBoard(x: Integer, y:Integer): Boolean{return modularCode.onBoard(x, y)}
}
