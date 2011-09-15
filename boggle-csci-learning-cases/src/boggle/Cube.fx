package boggle;

/**
 * @author mazubieta
 */
import java.util.Random;

public class Cube {

    public-init var sides: String[];
    def random = new Random();
    public-read var top: String;

    postinit{roll();}
    public function roll(): String{top = sides[random.nextInt(sides.size())]}
    public override function toString(){return top}
}
