/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package boggle;



/**
 * @author Manuel Zubieta
 */
 
public mixin class ModularCode {
    public-init var game: BoggleGame;
    public var dictionary = HashDictionary{};
    public def SIZE = 4;

    public function newGame(): Void {
        shake();
        game.score = 0;
    }
    public function clearPath(): Void{
        game.playPath.clear();
        game.word = "";
    }
    public function shake(): Void{
        game.tray = javafx.util.Sequences.shuffle(game.tray) as Cube[];
        for (cube in game.tray){cube.roll()}
    }
    public function submit(): Void{
        var result = 0;
         if (dictionary.isReal(game.word) and (javafx.util.Sequences.indexOf(game.playedWords, game.word) == -1)){
            if(game.word.length()<5){result = 1}
            else if (game.word.length()==5){result = 2}
            else if (game.word.length()==6){result = 3}
            else if (game.word.length()==7){result = 5}
            else{result = 11}
            insert game.word into game.playedWords;
        }
        game.score += result;
    }
    public function playCube(cube: Integer): Boolean {
        var result = false;

        if (game.playPath.size() == 0){
            game.playPath.add(cube);
            game.word = "{game.word}{game.tray[cube].top}";
            result = true;
        }
        else if (not game.playPath.contains(cube)){
            var adjacents = adjacentsOf(game.playPath.getLast() as Integer);
            if (javafx.util.Sequences.indexOf(adjacents, cube) != -1){
                game.playPath.add(cube);
                game.word = "{game.word}{game.tray[cube].top}";
                result = true;
            }
        }
        return result;
    }
    public function adjacentsOf(cell: Integer): Integer[] {
        var x: Integer = cell / SIZE;
        var y: Integer = cell mod SIZE;
        var results: Integer[];

        //North
        if (onBoard(x - 1, y))
            insert (((x - 1) * SIZE) + y) into results;
        //Northeast
        if (onBoard(x - 1, y + 1))
            insert (((x - 1) * SIZE) + (y + 1)) into results;
        //East
        if (onBoard(x, y + 1))
            insert ((x * SIZE) + (y + 1)) into results;
        //Southeast
        if (onBoard(x + 1, y + 1))
            insert (((x + 1) * SIZE) + (y + 1)) into results;
        //South
        if (onBoard(x + 1, y))
            insert (((x + 1) * SIZE) + y) into results;
        //Southwest
        if (onBoard(x + 1, y - 1))
            insert (((x + 1) * SIZE) + (y - 1)) into results;
        //West
        if (onBoard(x, y - 1))
            insert ((x * SIZE) + (y - 1)) into results;
        //Northwest
        if (onBoard(x - 1, y - 1))
            insert (((x - 1) * SIZE) + (y - 1)) into results;

        return javafx.util.Sequences.sort(results) as Integer[];
    }
    public function onBoard(x: Integer, y: Integer): Boolean {
        return x >= 0 and x < SIZE and y >= 0 and y < SIZE;
    }
}