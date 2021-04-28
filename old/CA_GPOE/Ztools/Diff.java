
import java.io.*;

public class Diff {
    
    public static void main(String [] args) throws Exception {
        
        InputStream ia = new FileInputStream(args[0]);
        InputStream ib = new FileInputStream(args[1]);
        
        byte [] ba = new byte[ia.available()];
        byte [] bb = new byte[ib.available()];
        ia.read(ba);
        ib.read(bb);
        
        if(ba.length != bb.length) {
            System.out.println("Not same size");
            return;
        }
        
        for(int x=0;x<ba.length;++x) {
            if(ba[x]!=bb[x]) {
                System.out.println("Not same at "+Integer.toString(x,16));
                return;
            }
        }
        
    }
    
}