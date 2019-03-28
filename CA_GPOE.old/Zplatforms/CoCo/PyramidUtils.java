import java.io.*;
import java.util.*;

public class PyramidUtils
{    
    
    static Map actionCommands = new HashMap();
    
    static List functions = new ArrayList();
    static List functionParams = new ArrayList();
    static List functionSpecial = new ArrayList();
    
    static List objects = new ArrayList();
    
    static int [] data;
    static List lines;
    
    static void loadDataSections() throws Exception
    {
        
        FileReader fr = new FileReader("pyramid.asm");
        BufferedReader br= new BufferedReader(fr);
        lines = new ArrayList();
        while(true) {
            String g = br.readLine();
            if(g==null) break;
            lines.add(g);
        }
        fr.close();
        
        InputStream is = new FileInputStream("PyramidORG0600.bin");
        data = new int[is.available()+0x600];
        for(int x=0;x<data.length-0x600;++x) {
            data[x+0x600] = is.read();
        }        
        is.close(); 
        
        // Load function descriptions
        int x = 0;
        for(x=0;x<lines.size();++x) {
            String g = (String)lines.get(x);
            if(g.startsWith("L0A17:")) break;
        }
        ++x;
        while(true) {
            String g = (String)lines.get(x);
            g=g.trim();
            if(!g.startsWith(".DW")) break;
            int z = g.indexOf(";");
            z=z+3;
            g = g.substring(z+2);            
            functionParams.add(new Integer(g.charAt(0)-0x30));
            functionSpecial.add(new Integer(g.charAt(1)));
            
            g = g.substring(3).trim();
            functions.add(g);
            //System.out.println(":"+g+":");
            ++x;   
        }
        
        // Load action words        
        for(x=0;x<lines.size();++x) {
            String g = (String)lines.get(x);
            if(g.startsWith("; Action command words")) break;
        }
        x=x+2;
        while(true) {
            String g = (String)lines.get(x);
            g=g.trim();
            if(g.length()<15) break;
            g=g.substring(18);
            int z = g.indexOf("\"");
            String aa = g.substring(0,z);
            int cn=Integer.parseInt(g.substring(12),16);
            //System.out.println(aa+" "+Integer.toString(cn,16));
            
            String s = (String)actionCommands.get(new Integer(cn));
            if(s == null) s = aa;
            else s = s +","+aa;
            actionCommands.put(new Integer(cn),s);
            
            ++x;
        }
        
        // Load objects        
        for(x=0;x<lines.size();++x) {
            String g = (String)lines.get(x);
            if(g.startsWith("L18ED:")) break;
        }
        x=x+1;
        while(true) {
            String g = (String)lines.get(x);
            g=g.trim();
            if(g.length()<8) break;
            
            String o = g.substring(20);
            //System.out.println(":"+o+":");
            objects.add(o);
            
            
            ++x;
        }
    }
    
    public static void main2(String [] args) throws Exception
    {
        
        FileReader fr = new FileReader("pyramid.asm");
        BufferedReader br= new BufferedReader(fr);
        List a = new ArrayList();
        while(true) {
            String g = br.readLine();
            if(g==null) break;
            a.add(g);
        }
        
        loadDataSections();        
        
        /*
        for(int x=0;x<a.size();++x) {
            System.out.print(a.get(x));
            System.out.print("\r\n");
        }
         */
        
    }
    
    public static void processList(int offset, int length, int level)
    {
        int eb = offset+length;
        while(offset<eb) {
            int cn=data[offset++];
            String des = (String)functions.get(cn-1);
            int cs=((Integer)functionParams.get(cn-1)).intValue();
            String ls = "";
            String rs = "";
            for(int zz=0;zz<level;++zz) {
                ls = ls + " ";
                rs = rs + " ";
            }
            ls = ls + ".DB 0x"+Integer.toString(cn,16);
            for(int x=0;x<cs;++x) {
                ls=ls+", 0x"+Integer.toString(data[offset++],16);
            }
            rs = rs + des;
            if(cn==7) {
                ls = padTo(ls,25);
                System.out.println(ls+" ; "+rs);
                processList(offset,data[offset-1]-1,level+2);
                offset = offset+data[offset-1]-1;
            } else {
                int a = ((Integer)functionSpecial.get(cn-1)).intValue();
                if(cs==0) {
                }
                else if(cs==1) {                    
                    if(a=='d') {
                        rs = rs+"  Room "+data[offset-1];
                    } else if(a=='c') {
                        rs = rs+"  Object \""+objects.get(data[offset-1]-1)+"\"";
                    } else {
                        rs = rs+"  N=0x"+Integer.toString(data[offset-1],16);
                    }                     
                } else {                    
                    if(a=='f') {
                        rs = rs+"  Object \""+objects.get(data[offset-2]-1)+"\"";
                        rs = rs+" Room "+data[offset-1];
                    } else if(a=='e') {
                        rs = rs+"  Object \""+objects.get(data[offset-2]-1)+"\"";
                        rs = rs+" Object \""+objects.get(data[offset-1]-1)+"\"";
                    } else if(a=='b') {
                        String mh = "; GeneralMessage "+Integer.toString(data[offset-2]*256+data[offset-1],16);
                        String th="???Unknown Address??";
                        for(int z=0;z<lines.size();++z) {
                            String g = (String)lines.get(z);
                            if(!g.startsWith(mh)) continue;
                            g = (String)lines.get(z+2);
                            th=g.substring(5,g.length()-1);
                            break;
                        }                          
                        rs=rs+" \""+th+"\"";
                    } else {
                        rs = rs +"  NN=0x"+Integer.toString(data[offset-2]*256+data[offset-1],16);
                    }
                }
                ls = padTo(ls,25);
                System.out.println(ls+" ; "+rs);
            }
        }
    }
    
    static String padTo(String s, int p)
    {
        while(s.length()<p) s=s+" ";
        return s;
    }
    
    static int processSequence(int datastart)
    {
        while(true) {
                
                int rcb = data[datastart++];
                if(rcb==0) {
                    System.out.println("  .DB 0x0");
                    return datastart;
                }
                int s = data[datastart++];
                
                String cdes = (String)actionCommands.get(new Integer(rcb));
                if(cdes==null) cdes="?UNKNOWN COMMAND?";
                String ts = "  .DB 0x"+Integer.toString(rcb,16)+", 0x"+
                  Integer.toString(s,16);
                ts = padTo(ts,26);
                System.out.println(ts+"; "+cdes);               
                
                processList(datastart,s-1,4);
                datastart = datastart+s-1;                
            }
    }
    
    public static void main22(String [] args) throws Exception
    {
        loadDataSections();  
        processSequence(0x1945);
    }
        
    public static void main(String [] args) throws Exception
    {       
        
        loadDataSections();   
        
        int [] startingPoints = new int[81];
        for(int x=0;x<81;++x) {
            startingPoints[x] = data[0x112E+x*4+2]*256 + data[0x112E+x*4+3];
            //System.out.println(Integer.toString(startingPoints[x],16));
        }
        
        int datastart = 0x1272;
        while(datastart<0x17ea) {
            int rn = 0;
            for(int x=0;x<81;++x) {
                if(startingPoints[x] == datastart) {
                    rn = x+1;
                    break;
                }
            }
            System.out.println("L"+Integer.toString(datastart,16)+":");
            System.out.println("RoomCommands_"+rn);
            
            datastart = processSequence(datastart); 
            
        }
        
        
    }
}
