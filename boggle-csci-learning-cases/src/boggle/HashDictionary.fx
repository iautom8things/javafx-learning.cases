package boggle;

/**
 * @author mazubieta
 */
import java.net.URL;
import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.util.LinkedList;
import java.io.File;
import java.io.FileReader;

public class HashDictionary {

    def PRIME = 16691;
    var str = "";
    var buckets: LinkedList[];
    var pwd = java.lang.System.getProperty("user.dir");
    init {
        try {
            def in = new BufferedReader(new FileReader(new File("words.txt")));
            print(pwd);
            for (i in [0..<PRIME]) { insert new LinkedList() into buckets }
            while ((str = in.readLine()) != null) {
                if ((str.length() > 2) and (not isReal(str))) {
                    buckets.get(javafx.util.Math.abs(str.hashCode()) mod PRIME).add(str);
                }
            }
            in.close();
        } 
        catch (exception) { // Local file not found.
            try{
            def url = new URL("http://mazdev.com/tu.research/words.tt");
            def in = new BufferedReader(new InputStreamReader(url.openStream()));

            for (i in [0..<PRIME]) { insert new LinkedList() into buckets }
            while ((str = in.readLine()) != null) {
                if ((str.length() > 2) and (not isReal(str))) {
                    buckets.get(javafx.util.Math.abs(str.hashCode()) mod PRIME).add(str);
                }
            }
            in.close();
            }
            catch (e){
                for (i in [0..<PRIME]) { insert new LinkedList() into buckets }
                }
        }

    }

    public function isReal(input: String): Boolean {
        var result = false;
        var word = input.toLowerCase();
        var bucket = buckets.get(javafx.util.Math.abs(word.hashCode() mod PRIME));
        if (bucket.contains(word))
            result = true;
        return result;
    }

}
