package assembler; 

import java.io.*;
import java.util.*;

public class Line
{
    
// F800  3A A5    Here:      LDA    #0xA5   ; This is an assembly line
    
    
    public String raw;             // The raw line as parsed  
    public String rawNoComment;    // Raw line with comment stripped off 
    public String firstWord;       // First word (all caps) of line
    
    public String label;           // Label (if given) or null
    public String assem;           // Assembly (if given) or null
    public String comment;         // Comment (if given) or null
       
    public String sourceFile;      // The name of the file this came from
    public int sourceFileLine;     // The line number this came from
    
    public int address = -1;       // The memory address of this line
    public int [] bytes;           // The bytes of this line
    
    // 1 = FLOW break statement
    // 2 = FLOW continue statement
    // 3 = FLOW jump statement (data = String:destination)
    // 4 = FLOW label (data = String:label)
    // 5 = FLOW branch statement (not a jump, data= String:destination)
    
    // Note the assumption ... a line can have only ONE special meaning.
    // For instance, it can't be a FLOW label with assembly that contains
    // a FLOW jump statement. The FLOW process ALWAYS puts FLOW labels on
    // a separate line, so this is not a problem.
    
    public int specialType;     // For special processing
    public Object specialData;  // For special processing
    
    public void commentOutWholeLine()
    {           
        parse("; "+raw);
        specialData = null;
        specialType = 0;
    }
    
    public void appendComment(String ac)
    {
        if(comment!=null) {
            ac = comment+" "+ac;
        }
        comment = ac;
    }
    
    public void prependComment(String pc)
    {
        if(comment!=null) {
            pc = pc+" "+comment;
        }
        comment = pc;
    }
    
    public void changeAssem(String newAssem)
    {
        if(newAssem==null) {
            assem = null;            
            return;
        }
        
        assem = newAssem;        
    }   
    
    public Line(String raw)
    {
        parse(raw);
    }
    
    public void parse(String ss)
    {      
                
        label = null;
        assem = null;
        comment = null;        
        
        // Convert tabs to spaces
        while(true) {
            int x= ss.indexOf('\t');
            if(x<0) break;
            String tt = ss.substring(0,x)+"    "+ss.substring(x+1);
            ss = tt;
        }
        raw = ss;
        
        // Parse off trailing comments
        int i = ss.indexOf(";");
        if(i>=0) {
            comment = ss.substring(i+1);
            ss = ss.substring(0,i);
        }                
        rawNoComment = ss;

        // Strip off any trailing and/or leading spaces
        ss = ss.trim();

        // Parse off any leading label
        StringTokenizer st = new StringTokenizer(ss," ");
        if(st.hasMoreTokens()) {
          String h = st.nextToken();
          if(h.endsWith(":")) {
            i = ss.indexOf(":");
            label = ss.substring(0,i);
            ss = ss.substring(i+1);
          }
        }

        // Anything left over must be assembly
        ss=ss.trim();
        if(ss.length()>0) {
            changeAssem(ss);            
        }      
        
        st = new StringTokenizer(ss," ");
        if(st.hasMoreTokens()) {
            firstWord = st.nextToken().toUpperCase();
        } else {
            firstWord = "";
        }
       
    }
    
    /**
     * This static method prints the list of Lines to the given stream.
     * @param code the list of lines
     * @param ps the print stream
     */
    public static void linesToStream(List<Line> code, PrintStream ps)
    {        
        for(int x=0;x<code.size();++x) {
            Line a = code.get(x);             
            String lab = "";   if(a.label!=null)        lab=a.label+":";            
            String com = "";   if(a.comment!=null)      com = a.comment;
            if(com.length()>0) com="; "+com;            
            
            while(lab.length()<16) lab=lab+" ";            
            
            ps.print(lab+" "+a.assem+" "+com);
            ps.print("\r\n");  
            
        }
    }
    
    /**
     * This static method loads a list of lines from the given file recursively
     * processing the includes.
     * @param filename the name of the root file
     * @return the List of Lines
     */
    public static List<Line> loadLines(String filename) throws Exception
    {
        
        // First load the file
        List<Line> ret = new ArrayList<Line>();
        FileReader fr = new FileReader(filename);
        BufferedReader br = new BufferedReader(fr);
        int li = 0;
        while(true) {
            String g = br.readLine();
            if(g==null) break;
            Line a = new Line(g);
            a.sourceFile = filename;
            a.sourceFileLine = li++;
            ret.add(a);
        }
        fr.close();
        
        // Now recursively expand the includes 
        for(int x=ret.size()-1;x>=0;--x) {
            Line a = (Line)ret.get(x);
            if(a.firstWord.equals(".INCLUDE")) {                
                String n = a.assem.substring(9).trim();
                List<Line> ins = loadLines(n);
                ret.remove(x);
                int y = x;
                for(int z=0;z<ins.size();++z) {
                    ret.add(y++,ins.get(z));
                }                  
            }            
        }        
        
        return ret;
    }
    
}
