import java.io.*;
import java.util.*;

public class InvadersVerify
{
    
    static boolean isNumeric(String s)
    {
        if(s.equals("dec")) return false;
        if(s.equals("add")) return false;
        if(s.equals("daa")) return false;
        if(s.equals("adc")) return false;
        for(int x=0;x<s.length();++x) {            
            char c = s.charAt(x);
            if(c>='0' && c<='9') continue;
            if(c>='A' && c<='F') continue;
            if(c>='a' && c<='f') continue;            
            return false;
        }
        return true;
    }
    
    public static void main(String [] args) throws Exception
    {
        Reader r = new FileReader(args[0]);
        BufferedReader br = new BufferedReader(r);
        
        Map assembly = new HashMap();
        
        InputStream is = new FileInputStream(args[1]);
        byte [] orgromb = new byte[is.available()];
        is.read(orgromb);
        int [] orgrom = new int[0x2000];
        for(int x=0;x<0x2000;++x) {
            orgrom[x] = orgromb[x];
            if(orgrom[x]<0) {                
                orgrom[x]=orgrom[x]+256;
            }
        }
        
        int [] rom = new int[0x2000];
        for(int x=0;x<rom.length;++x) rom[x] = -1;
        
        char [] build = new char[2];
        List comms = new ArrayList();
        
        while(true) {
            String g = br.readLine();
            if(g==null) break;
            g=g.trim();
            if(g.length()==0) continue;
            if(g.startsWith(";")) continue;            
            StringTokenizer st = new StringTokenizer(g);
            String address = st.nextToken();
            if(!isNumeric(address)) {
                throw new RuntimeException("Address '"+address+"' is not numeric: "+g);
            }
            String lastWord = null;
            while(st.hasMoreTokens()) {
                String ss = st.nextToken();
                if(!isNumeric(ss)) {    
                    lastWord = ss;
                    break;
                }
                if(ss.length()%2 !=0) {
                    System.out.println(ss);
                    throw new RuntimeException("Data isn't multiple of 2 characters: "+g);
                    
                }
                int addr = Integer.parseInt(address,16);
                int p=0;                
                while(p<ss.length()) {
                    build[0] = ss.charAt(p);
                    build[1] = ss.charAt(p+1);
                    p=p+2;
                    int i = Integer.parseInt(new String(build),16);
                    if(rom[addr]!=-1) {
                        throw new RuntimeException("Already have a value for address: "+Integer.toString(addr,16));
                    }
                    if(orgrom[addr]!=i) {
                        System.out.println(""+orgrom[addr]+" "+i);
                        throw new RuntimeException("Value doesn't match original ROM: "+Integer.toString(addr,16));
                    }
                    rom[addr++] = i;
                }
                
            }         
            
            if(lastWord!=null && lastWord.startsWith(";")) lastWord = null;
            if(lastWord!=null) {
                //System.out.print(lastWord+" ");
                if(!comms.contains(lastWord)) comms.add(lastWord);
                // This must be assembler
                while(st.hasMoreTokens()) {
                    String a = st.nextToken();
                    if(a.startsWith(";")) break;
                    //System.out.print(a+" ");
                }                
                //System.out.println();
            }
        }
        
        for(int x=0;x<rom.length;++x) {
            if(rom[x]==-1) {
                //System.out.println(":"+Integer.toString(x,16));
                rom[x]=0;
                if(orgrom[x]!=0) {
                    throw new RuntimeException("Area is blank but not in original: "+Integer.toString(x,16));
                }
            }
        }
        
        for(int x=0;x<comms.size();++x) {
            System.out.println(comms.get(x));
        }
    }

}
