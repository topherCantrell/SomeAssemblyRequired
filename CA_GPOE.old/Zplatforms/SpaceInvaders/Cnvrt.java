import java.io.*;
import java.util.*;

public class Cnvrt {
    
    static List parse(String fname) throws IOException {
        
        List ret = new ArrayList();
        FileReader fr = new FileReader(fname);
        BufferedReader brr = new BufferedReader(fr);
        brr.readLine();
        
        while(true) {
            String g = brr.readLine();
            if(g==null) break;
            if(g!=null) g=g.trim();
            if(g.length()==0) continue;
            if(g.startsWith("/")) continue;
                        
            StringTokenizer st=new StringTokenizer(g," ");
            String [] ss = new String[7];
            for(int x=0;x<6;++x) {
                ss[x] = st.nextToken();
            }
            ss[6] = g;
            //if(st.hasMoreTokens()) {
            //    throw new RuntimeException("Invalid tab file. "+g);
            //}
            
            ret.add(ss);
        }
        
        return ret;
        
    }
    
    public static int isIn85(List t85, List t80, String [] z80command)
    {
        for(int x=0;x<t85.size();++x) {
            String [] gg = (String [])t85.get(x);
            for(int y=2;y<6;++y) {
                if(!gg[y].equals(z80command[y])) break;
                return x;
            }
        }
        return -1;
    }
    
    public static void main(String [] args) throws Exception
    {
        
        List t85 = parse("TASM85.TAB");
        List t80 = parse("TASM80.TAB");
        
        for(int x=0;x<t80.size();++x) {
            String [] gg = (String [])t80.get(x);
            int i = isIn85(t85,t80,gg);
            if(i>=0) {
                System.out.println(gg[6]);
                //String [] yy = (String [])t85.get(i);
                //System.out.println(yy[6]);
            }
        }
        
        
        
    }
    
    
    
    
}
