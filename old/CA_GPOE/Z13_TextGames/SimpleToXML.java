
import java.io.*;
import java.util.*;


public class SimpleToXML
{    
    
    public static List findIncludedTarget(String s,File f) throws Exception
    {        
        File ff = f.getParentFile();
        File [] ffc = ff.listFiles();
        for(int x=0;x<ffc.length;++x) {
            String ss = ffc[x].getPath();
            if(!ss.endsWith(".txt")) continue;            
            FileReader fr = new FileReader(ss);
            BufferedReader br = new BufferedReader(fr);
            while(true) {
                String g = br.readLine();
                if(g==null) break;
                if(!g.startsWith("Included:")) continue;
                if(!s.equals(g.substring(9).trim())) continue;
                List ret = new ArrayList();
                while(true) {
                    g = br.readLine();
                    if(g==null) {
                        br.close();
                        return ret;
                    }
                    g=g.trim();
                    if(g.startsWith("Included:") || g.startsWith("Room:")) {
                        br.close();
                        return ret;
                    }
                    if(!g.startsWith("-")) {                        
                        ret.add(g);
                    }
                }                                
            }
        }    
        return null;
    }
    
    public static void processTextFile(File f) throws Exception
    {
        String t = f.getPath();
        int i = t.lastIndexOf(".txt");
        String nt = t.substring(0,i)+".xml";
        OutputStream os = new FileOutputStream(nt);
        PrintStream ps = new PrintStream(os);
        FileReader fr = new FileReader(f.getPath());
        BufferedReader br = new BufferedReader(fr);
        
        List a = new ArrayList();
        while(true) {
            String g = br.readLine();
            if(g==null) break;
            g=g.trim();
            a.add(g);
        }
        
        // Expand includes
        for(int x=a.size()-1;x>=0;--x) {
            String s = (String)a.get(x);
            if(s.startsWith("*include*")) {
                s = s.substring(9).trim();
                List aa = findIncludedTarget(s,f);
                if(aa==null) {
                    throw new RuntimeException("Could not load include target: '"+s+"'");
                }
                a.remove(x);
                for(int y=0;y<aa.size();++y) {
                    a.add(x++,aa.get(y));
                }
            }
        }
        
        int roomLevel = 0;
        int ifLevel = 0;      
        
        ps.print("<TextAdventure>\r\n");
        
        for(int x=0;x<a.size();++x) {
            String g = (String)a.get(x);
            if(g.length()==0) {
                ps.print("\r\n");                
            } else if(g.startsWith("-")) {
                //ps.print("<!-- "+g.substring(1)+" -->\r\n");                
            } else  if(g.startsWith("Room:")) {
                if(roomLevel==1) {
                    ps.print("  </room>\r\n\r\n");
                }                
                roomLevel = 1;
                ps.print("  <room name=\""+(g.substring(5).trim())+"\">\r\n");                    
            } else if(g.startsWith("Included:")) {
                if(roomLevel==1) {
                    ps.print("  </room>\r\n\r\n");
                }                
                roomLevel = 1;
                ps.print("  <room name=\""+(g.substring(9).trim())+"\">\r\n");
            }
            else if(g.startsWith("Set:")) {  
                i = g.indexOf(" to ");
                if(i<0) throw new RuntimeException("Expected ' to ' :"+g);
                ps.print("    <set variable=\""+g.substring(4,i).trim()+"\" value=\""+g.substring(i+4).trim()+"\"/>\r\n");
                while(ifLevel>0) {
                    --ifLevel;
                    ps.print("    </if>\r\n");
                }
            } else if(g.startsWith("Description:")) {
                while(g.indexOf("\"")<0) {
                    ++x;
                    if(x>=a.size()) {                    
                        throw new RuntimeException("EOL finding first '\"'");
                    }
                    g = g+" "+((String)a.get(x)).trim();
                }
                i = g.indexOf("\"");
               //System.out.println("::"+g+"::");
                while(g.indexOf("\"",i+1)<0) {
                    ++x;
                    if(x>=a.size()) {                    
                        throw new RuntimeException("EOL finding second '\"'");
                    }
                    g = g+" "+((String)a.get(x)).trim();
                }
                String text = g.substring(i+1,g.indexOf("\"",i+1));
                ps.print("    <description>"+text+"</description>\r\n");  
                while(ifLevel>0) {
                    --ifLevel;
                    ps.print("    </if>\r\n");
                }
            } else if(g.startsWith("Decision:")) {
                g = g.substring(9).trim();
                i = g.indexOf(" ");
                if(i<0) {
                    throw new RuntimeException("Bad syntax:"+g);
                }
                ps.print("    <decision input=\""+g.substring(0,i)+"\" nextRoom=\""+g.substring(i+1).trim()+"\"/>\r\n");
                while(ifLevel>0) {
                    --ifLevel;
                    ps.print("    </if>\r\n");
                }
            } else if(g.startsWith("if ")) {
                g = g.substring(3).trim();
                while(true) {                    
                    int lt = g.indexOf(" AND ");
                    if(lt<0) lt=g.length(); 
                    i = g.indexOf(" is ");
                    if(i<0) {
                        throw new RuntimeException("Expected ' is ' :"+g);
                    }
                    ++ifLevel;                    
                    String v = g.substring(0,i).trim();
                    String vv = g.substring(i+4,lt).trim();
                    ps.print("    <if variable=\""+v+"\" equals=\""+vv+"\">\r\n");                    
                    if(g.length()==0 || lt==g.length()) break;
                    g = g.substring(lt+5);
                }
            }
            
            else {
                System.out.println(g);
            }
            
        }     
        
        if(roomLevel==1) {
            ps.print("  </room>\r\n\r\n");
        }
        
        ps.print("</TextAdventure>\r\n");
        
        ps.flush();
        ps.close();
        br.close();
    }
    
    public static void main(String [] args) throws Exception
    {
        File ff = new File(args[0]);
        File [] lst = ff.listFiles();
        for(int x=0;x<lst.length;++x) {
            if(lst[x].getName().endsWith(".txt")) {
                processTextFile(lst[x]);
            }
        }
    }
    
}
