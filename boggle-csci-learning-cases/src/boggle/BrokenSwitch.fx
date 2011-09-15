/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package boggle;

/**
 * @author mazubieta
 */

public class BrokenSwitch extends ModularCode{
    public override function submit(): Void{
        var result = 0;
         if (dictionary.isReal(game.word) and (javafx.util.Sequences.indexOf(game.playedWords, game.word) == -1)){
            if(game.word.length()<5){result = 3}
            else if (game.word.length()==5){result = 2}
            else if (game.word.length()==6){result = 3}
            else if (game.word.length()==7){result = 5}
            else{result = 11}
            insert game.word into game.playedWords;
        }
        game.score += result;
    }

}
