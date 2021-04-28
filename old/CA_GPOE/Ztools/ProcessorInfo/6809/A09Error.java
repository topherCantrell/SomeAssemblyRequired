
import java.io.*;
import java.util.*;

public class A09Error
{
    
    public static void main(String [] args) throws IOException
    {
        
        List e = new ArrayList();
        
        FileReader fr = new FileReader(args[0]);
        BufferedReader br=new BufferedReader(fr);
        
        while(true) {
            String g = br.readLine();
            if(g==null) break;
            if(g.indexOf("Long branch within short branch range could be optimized in")>0) continue;
            if(e.contains(g)) continue;
            e.add(g);
            System.out.println(g);
            
        }
        
        br.close();
        
    }
    
}
