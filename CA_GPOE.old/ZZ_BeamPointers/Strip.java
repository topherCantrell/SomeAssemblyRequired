import java.io.*;
import java.util.*;


public class Strip {
    
    public static void main(String [] args) throws Exception {
        
        Reader r = new FileReader(args[0]);
        BufferedReader br= new BufferedReader(r);
        
        while(true) {
            String g = br.readLine();
            if(g==null) break;
            if(g.length()<18) {
                System.out.println();
            } else {
                System.out.println(g.substring(18));
            }
        }
        
        
        
    }
    
    
}