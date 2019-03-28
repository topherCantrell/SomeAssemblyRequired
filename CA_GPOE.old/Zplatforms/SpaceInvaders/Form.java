import java.io.*;
import java.util.*;

// Next step:
// Look for all $lables between $0 and $1fff. These need to be made into
// labels on the left. Then .equ the known RAM locations. Then change the
// $lables to useful names for known code.

public class Form {
    
    public static String getLabel(String s)
    {
        String so = s;        
        s=s.trim();
        String sso = s;
        if(s.startsWith(".") || s.startsWith(";")) return null;
        int i = s.indexOf("#");
        if(i<0) return null;
        
        s=s.substring(i+1);
        s = s.toUpperCase();
        int cnt = 0;
        int pos = 0;
        while(pos<s.length()) {
            char c = s.charAt(pos++);
            if(c>='0' && c<='9') continue;
            if(c>='A' && c<='F') continue;
            --pos;
            break;
        }
        if(pos!=4) return null;
        s = s.substring(0,pos);
        i = Integer.parseInt(s,16);
        if(i<0x2000) {
            //System.out.println(":>>:"+sso);
            if(sso.indexOf(" ld ")>=0) {
                return "-"+s;
            }
            return s;
        }
        
        return null;
        
        
    }
    
    public static void main(String [] args) throws Exception {
        
        ArrayList labels = new ArrayList();        
        
        FileReader fr = new FileReader("invaders.asm");
        BufferedReader br = new BufferedReader(fr);        
        while(true) {            
            String g = br.readLine();
            if(g==null) break;
            String a = getLabel(g);
            if(a!=null) {
                if(!a.startsWith("-")) {
                    labels.add(a);
                } else {
                    labels.add(a.substring(1));
                }
            }
        }
        br.close();
        
        
        fr = new FileReader("invaders.asm");
        br = new BufferedReader(fr);
        int lineCount = 0;
        while(true) {
            
            String g = br.readLine();
            if(g.startsWith("; Looks like data from here down")) break;
            String gg = g;
            g = g.trim();
            if(g.length()==0) {
                System.out.println(gg);
                continue;
            }
            if(g.startsWith(";")) {
                System.out.println(gg);
                continue;
            }
            
            if(!g.startsWith(".")) {
                g = g.substring(16);
            }
            
            String bb = getLabel("| "+g);
            if(bb!=null) {
                if(bb.startsWith("-")) {
                    g = g+" ; -- POSSIBLE LABEL --";
                } else {
                    int ii = g.toUpperCase().indexOf(bb);
                    if(ii<0) {
                        System.out.println(":"+bb+":"+g);
                    }
                    String cc = g.substring(0,ii)+"L"+bb+g.substring(ii+4);
                    g = cc;
                }
            }
            
            
            g = g.replace('#','$');
            
            ++lineCount;
            //if(lineCount==2277) System.out.println(":"+g);
            
            String preamb = "        ";
            for(int x=0;x<labels.size();++x) {
                String aa = (String)labels.get(x);
                if(gg.toUpperCase().startsWith(aa+" ")) {
                    preamb = "L"+aa+":  ";
                    break;
                } 
            }
            System.out.println(preamb+g);
            
        }
        
        
        while(true) {
            String g = br.readLine();
            if(g==null) break;
            
            String gg = g;
            g = g.trim();
            if(g.length()==0) {
                System.out.println(gg);
                continue;
            }
            if(g.startsWith(";") || g.startsWith(".")) {
                System.out.println(gg);
                continue;
            }
            
            int i = g.indexOf(" ");
            int j = g.indexOf(";");
            if(j<0) j = g.length();
            
            g = g.substring(i+1,j).trim();
            
            if(g.length()%2 !=0) {
                System.out.println(":::"+g);
            }
            
            String preamb = "        ";
            for(int x=0;x<labels.size();++x) {
                String aa = (String)labels.get(x);
                if(gg.toUpperCase().startsWith(aa+" ")) {
                    preamb = "L"+aa+":  ";
                    break;
                } 
            }
            
            //System.out.println(preamb+g);
            
            System.out.print(preamb+"  .db    ");
            for(int x=0;x<g.length();x=x+2) {
                System.out.print("$"+g.charAt(x)+g.charAt(x+1));
                if(x!=(g.length()-2)) System.out.print(",");
            }
            System.out.println();
            
            
            
        }
        
        
        
        
    }
    
}