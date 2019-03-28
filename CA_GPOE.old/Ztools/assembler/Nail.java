package assembler;

import java.util.*;
import java.io.*; 

public class Nail implements VariableResolver 
{   
    
    // The code lines
    List<Line> code;    
    
    // Target processor
    NailAssemblerInterface nailProcessor;
    
    // Used to evaluate numeric expressions
    ExpressionEvaluator expEval;

    // The symbols with actual values
    Map<String,Integer> symbols;
    
    // These are simply labels not attached to code lines
    Map<String,Integer> equates; 
    
    /**
     * This constructs a new Nail object.
     * @param code the list of assembly Lines
     */
    public Nail(List<Line> code) throws IOException
    {
        this.code = code;
        equates = new HashMap<String,Integer>();
        symbols = new HashMap<String,Integer>();
        expEval = new LogicExpressionEvaluator(this);
    }
    
    /**
     * This method processes a possibly-complex numeric expression.
     * @param exp the expression
     * @param s the Status to fill out if something goes wrong
     * @return the expression's numeric value
     */
    public int processExpression(String exp, Status s)
    {
        String r = expEval.evaluateExpression(exp);
        if(r.startsWith("*")) {
            s.status=Status.ERROR;
            s.message = r;
            return -1;
        }
        return Integer.parseInt(r);        
    }
    
    /**
     * This method from VariableResolver is called by the ExpressionEvaluator
     * to get the numeric value of a single term (numeric or variable lookup).
     */
    public Integer resolve(String name) { 
        if(name.startsWith("'")) {            
            if(name.equals("'\\n'")) {
                return new Integer('\n');
            } else if(name.equals("'\\r'")) {
                return new Integer('\r');
            } else if(name.equals("'\\''")) {
                return new Integer('\'');
            } 
            else {
                if(name.charAt(2)!='\'') {                    
                    return null;
                }
                return new Integer(name.charAt(1));
            }
        }
        if(isNumeric(name)) {            
            return new Integer(decodeValue(name));
        }
        return symbols.get(name);
    }
        
    /**
     * This static method decodes a known integer constant in any base.
     * @param s the integer string
     * @return the parsed value
     */
    public static int decodeValue(String s) {
        int base=10;       
        if(s.toUpperCase().startsWith("0X")) {
            base=16;            
            s=s.substring(2);
        } else if(s.toUpperCase().startsWith("0B")) {
            base = 2;            
            s=s.substring(2);
        } else if(s.toUpperCase().startsWith("0D")) {
            s=s.substring(2);
        } else if(s.toUpperCase().startsWith("0O")) {
            base = 8;            
            s=s.substring(2);
        }        
        s = s.toUpperCase();
        return Integer.parseInt(s,base);
    }
    
    /**
     * This method checks to see if a string is an integer constant in any base.
     * @param s the string to test
     * @return true if the string is a numeric constant
     */
    public static boolean isNumeric(String s) {
        if(s==null) return false;
        s = s.toUpperCase();
        int base=10;
        String validDigits="0123456789";
        if(s.startsWith("0X")) {
            base=16;
            validDigits="0123456789ABCDEF";
            s=s.substring(2);
        } else if(s.startsWith("0B")) {
            base = 2;
            validDigits="01";
            s=s.substring(2);
        } else if(s.startsWith("0D")) {
            s=s.substring(2);
        } else if(s.startsWith("0O")) {
            base = 8;
            validDigits="01234567";
            s=s.substring(2);
        }        
        for(int x=0;x<s.length();++x) {
            if(validDigits.indexOf(s.charAt(x))<0) {
                return false;
            }
        }        
        return true;        
    }
        
    /**
     * This helper method parses a string of coma-separated integer terms and
     * returns the resulting numeric array. If this is the final pass, labels
     * are expanded to their final value. Currently, this method handles the
     * following types of terms:
     *
     * 'c'        -- a character constant ('\n' and '\r' are handled)
     * "this is"  -- a text string (converted to bytes)
     * 1234       -- a numeric constant
     * LocalA+1   -- a numeric expression
     *
     * @param s the string to parse
     * @param asBytes true if the string is to be treated as bytes, false
     *                for words (two bytes)
     * @param finalPass true if labels are assumed to be resolved
     * @param retStatus a Status to fill out in the event of errors
     * @return the data array or null if retStatus contains the error
     */
    int [] parseDataList(String s, boolean asBytes, boolean finalPass, Status retStatus)
    {
        
        // To Do: More robust here ... handle escaped characters in "
        // like "\r". 
        
        ArrayList<Integer> ret = new ArrayList<Integer>();
        int pos = 0;
        
        while(pos<s.length()) {
            // Skip leading whitespace
            if(s.charAt(pos)==' ') {
                ++pos;
                continue;
            }
            
            if(s.charAt(pos)=='"') {
                int x = s.indexOf("\"",pos+1);
                if(x<0) {
                    retStatus.status = Status.ERROR;
                    retStatus.message = "No closing \".";
                    return null;
                }
                for(int yy=pos+1;yy<x;++yy) {
                    ret.add(new Integer(s.charAt(yy)));
                }
                pos = x+1;
                if(pos<s.length()) ++pos; // Over the ','
            }
            else {
                int a = s.indexOf(",",pos);
                if(a<0) a=s.length();
                String h = s.substring(pos,a).trim();
                if(isNumeric(h)) {
                    int i = decodeValue(h);
                    ret.add(new Integer(i));
                } else {
                    if(!finalPass) {
                        if(!asBytes) {
                            ret.add(new Integer(-1));
                            ret.add(new Integer(-1));
                        } else {
                            ret.add(new Integer(-1));
                        }
                    } else {
                        int ttar = processExpression(h,retStatus);
                        if(retStatus.status!=Status.OK) return null;
                        ret.add(new Integer(ttar));                          
                    }
                }
                pos = a;
                if(pos<s.length()) ++pos; // Over the ','
            }
        }        
        
        int [] rr = new int[ret.size()];
        for(int x=0;x<rr.length;++x) {
            rr[x] = ret.get(x).intValue();
        }
        return rr;
    }
        
    /**
     * This method processes a single line of assembly filling out the bytes
     * of data or handling special "." assembler directives.
     * @param lineIndex the line currently being worked
     * @param line the current line
     * @param finalPass true if all labels should be fixed
     * @return a Status indicating any error or warning
     */
    Status processAssembly(Line line, boolean finalPass)
    {         
        // Nothing to do if null ...
        if(line.assem==null) return new Status();
        
        // Handle preprocessor directives
        if(line.firstWord.startsWith(".")) {
            if(line.firstWord.equals(".PROCESSOR")) {
                String c = "assembler.Nail"+line.assem.substring(11).trim();
                try {
                    Class cc = getClass().getClassLoader().loadClass(c);
                    nailProcessor = (NailAssemblerInterface)cc.newInstance();
                    nailProcessor.setNail(this);
                } catch (Exception e) {
                    return new Status(Status.ERROR,"Could not load processor:"+e.getMessage(),line);
                }   
                return new Status();
            } else if(line.firstWord.equals(".END")) {
                // Silently ignore the END directive
                return new Status();
            } else if(line.firstWord.equals(".EQU")) {    
                int j = line.assem.indexOf("=");
                if(j<0) {
                  return new Status(Status.ERROR,"Could not find '=' in .EQU:",line);
                }
                String lab = line.assem.substring(4,j).trim();
                String exp = line.assem.substring(j+1).trim();
                Status tat = new Status();
                int av = processExpression(exp,tat);
                if(tat.status == Status.ERROR) {
                    return new Status(Status.ERROR,tat.message,line);
                }
                equates.put(lab,new Integer(av));         
                boolean ee = addSymbol(lab,av);
                if(!ee) {
                    return new Status(Status.ERROR,"Multiply defined symbol: '"+lab+"'.",line);
                }                
                return new Status();
            } else if(line.firstWord.equals(".BYTE")) {
                Status rr = new Status();
                int [] v = parseDataList(line.assem.substring(6).trim(),true,finalPass,rr);
                if(rr.status==Status.ERROR) return new Status(Status.ERROR,rr.message,line);
                line.bytes = v;
                return rr;
            } else if(line.firstWord.equals(".WORD")) {  
                Status rr = new Status();
                int [] v = parseDataList(line.assem.substring(6).trim(),false,finalPass,rr);
                if(rr.status==Status.ERROR) return new Status(Status.ERROR,rr.message,line);                
                int [] vv = new int[v.length*2];
                boolean b = nailProcessor.isBigEndian();
                for(int z=0;z<v.length;++z) {
                    int msb = v[z]/256;
                    int lsb = v[z]%256;
                    if(b) {
                        vv[z*2] = msb;
                        vv[z*2+1] = lsb;
                    } else {
                        vv[z*2] = lsb;
                        vv[z*2+1] = msb;
                    }
                }
                line.bytes = vv;
                return rr;
            }
                    
        }
        
        // If it's not pre-processor, pass it to the target assembler
        
        if(nailProcessor==null) {
            return new Status(Status.ERROR,"No '.processor' directive given.",line);
        }        
        return nailProcessor.processAssembly(line,finalPass);        

    }
    
    /**
     * This method tracks defined symbols making sure there aren't multiply-
     * defined symbols and that symbols keep their values between passes.
     * @param label the symbol name
     * @param value the defined value
     */
    boolean addSymbol(String label, int value)
    {
        if(symbols.containsKey(label)) {         
            Integer ii = symbols.get(label);
            if(ii.intValue() == value) return true;
            return false;
        }
        symbols.put(label,new Integer(value));
        return true;
    }
    
    /**
     * This method makes a single pass through the assembly code filling out
     * the addresses and data byes.
     * @param finalPass true if the labels should be in final form
     * @return a Status indicating any errors
     */
    public Status assemble(boolean finalPass) {
        
        int currentAddress = 0;
        equates.clear();        
        
        for(int x=0;x<code.size();++x) {
            
            Line a = code.get(x);
            
            if(a.label!=null && a.label.length()>0) {
                
                // Handle any ORG overrides
                if(isNumeric(a.label)) {
                    currentAddress = decodeValue(a.label);
                }
                
                // If a line has a label, record the symbol (skip EQUs)
                if(!(a.firstWord.equals(".EQU"))) {
                    boolean ee = addSymbol(a.label,currentAddress);
                    if(!ee) {
                        return new Status(Status.ERROR,"Multiply defined symbol: '"+a.label+"'.",a);
                    }
                }
                
            }
            
            // We now know this line's address
            a.address = currentAddress;
            
            // Make the bytes that go with the line
            Status ret = processAssembly(a,finalPass);
            
            // Handle status from the assembly-generation
            if(ret.status == Status.RESTART_PASS) {
                return ret;
            }
            if(ret.status == Status.ERROR) {
                return ret;
            }
            if(ret.status == Status.WARNING) {
                System.out.println("WARNING "+ret.message);
            }
            
            // Update our address pointer based on the length of this one
            if(a.bytes!=null) {
                currentAddress+=a.bytes.length;
            }
            
        }
        return new Status();
    }
    
    /**
     * This method extracts a listing file from the assembly lines.
     * @param ps the PrintStream to create the listing on
     */
    public void printListing(PrintStream ps)
    {
        Map<String,Integer> labs = new HashMap<String,Integer>();
        for(int x=0;x<code.size();++x) {
            Line a = code.get(x);
            if(a.label!=null && a.label.length()>0) {
                labs.put(a.label,new Integer(a.address));
            }
            String bin = Integer.toString(a.address,16);
            bin = padString(bin,4,"0",true)+" : ";
            if(a.bytes!=null) {
                for(int y=0;y<a.bytes.length;++y) {
                    if(a.bytes[y]<0) {
                        bin = bin + "??";
                    } else {
                        String jj = Integer.toString(a.bytes[y],16);
                        jj = padString(jj,2,"0",true);
                        bin = bin + jj;                        
                    }
                    bin = bin + " ";
                }
            }            
            if(a.bytes==null) {
                bin = "";
            }
            bin = padString(bin,24," ",false);
            ps.println(bin+" "+a.raw);
        }
        
        String [] lls = new String[labs.size()];        
        labs.keySet().toArray(lls);
        
        sortArray(lls);
        ps.println();
        ps.println("***** Labels *****");
        ps.println();
        for(int x=0;x<lls.length;++x) {            
            if(isNumeric(lls[x])) continue; // ORG setting
            if(equates.containsKey(lls[x])) continue;
            int val = labs.get(lls[x]).intValue();
            String aa = Integer.toString(val,16).toUpperCase();;
            aa = padString(aa,4,"0",true);
            ps.println(aa+" "+lls[x]);
        }       
        
        lls = new String[equates.size()];        
        equates.keySet().toArray(lls);        
        sortArray(lls);
        
        ps.println();
        ps.println("***** Equates *****");
        ps.println();        
        for(int x=0;x<lls.length;++x) {                                
            int val = equates.get(lls[x]).intValue();
            String aa = Integer.toString(val,16).toUpperCase();;
            aa = padString(aa,4,"0",true);
            ps.println(aa+" "+lls[x]);
            
        }       
        
    }
    
    /**
     * This helper function sorts an array of strings in alphabetical order.
     * @param s the array to sort
     */
    public static void sortArray(String [] s)
    {
        boolean changed = true;
        while(changed) {
            changed = false;
            for(int x=0;x<s.length-1;++x) {
                String a = s[x];
                String b = s[x+1];
                if(a.compareTo(b)>0) {
                    s[x] = b;
                    s[x+1]=a;
                    changed = true;
                }
            }
        }
    }
    
    /**
     * This method finds the first address of generated instructions.
     * @return the first assembled address
     */
    public int findLastAddress()
    {
        int lastAddress = 0;
        for(int x=0;x<code.size();++x) {
            Line a = code.get(x);
            if(a.bytes!=null && a.bytes.length>0) {
                int la = a.address+a.bytes.length-1;
                if(la>lastAddress) lastAddress = la;
            }
        }
        return lastAddress;
    }
    
    /**
     * This method finds the last address of generated instructions.
     * @return the last assembled address
     */
    public int findFirstAddress()
    {
        int firstAddress = 1000000;
        for(int x=0;x<code.size();++x) {
            Line a = code.get(x);
            if(a.bytes!=null && a.bytes.length>0) {
                int la = a.address;
                if(la<firstAddress) firstAddress = la;
            }
        }
        return firstAddress;
    }
    
    /**
     * This method turns the assembly lines into a binary image.
     * @param status a Status to fill out with any errors
     * @return the binary data
     */
    public int [] makeBinaryImage(Status status)
    {        
        int offs = findFirstAddress();
        int las = findLastAddress();        
        int [] ret = new int[findLastAddress()-offs+1];
        for(int x=0;x<ret.length;++x) {
            ret[x] = -1;
        }
        for(int x=0;x<code.size();++x) {
            Line a = code.get(x);
            if(a.bytes!=null && a.bytes.length>0) {
                int p = a.address - offs;                
                for(int y=0;y<a.bytes.length;++y) {
                    if(a.bytes[y]<0 || a.bytes[y]>255) {
                        status.status = Status.ERROR;
                        Status u = new Status(Status.ERROR,"Invalid byte value from assembly '"+a.bytes[y]+"' "+y+".",a);
                        status.message = u.message;
                        return null;
                    }
                    if(ret[p]>=0) {
                        status.status = Status.ERROR;
                        Status u = new Status(Status.ERROR,"Multiple instructions assemble to same location.",a);
                        status.message = u.message;
                        return null;
                    }
                    ret[p++] = a.bytes[y];
                }
            }
        }
        // Fill in the BLANK value
        for(int x=0;x<ret.length;++x) {
            if(ret[x]<0) ret[x]=0;
        }
        return ret;
    }
    
    /**
     * This helper function pads a string in front or back with the given pad
     * character to the given length.
     * @param string the string to pad
     * @param size the minimum size of the final string
     * @param pad the padding character
     * @param front true if padding goes on front, false if on back
     * @return the padded string
     */
    public static String padString(String string, int size, String pad, boolean front)
    {
        while(string.length()<size) {
            if(front) {
                string = pad+string;
            } else {
                string = string+pad;
            }
        }
        return string;
    }
        
    /**
     * This application entry point assembles the given code and produces two
     * output files: a binary image and a listing file. 
     * @param args the command line arguments
     */
    public static void main(String [] args) throws Exception
    {
        
        String fn = args[0];
        int i = fn.lastIndexOf(".");
        fn = fn.substring(0,i);
        
        List<Line> codeOrg = Line.loadLines(fn+".asm"); 
        Nail nail = new Nail(codeOrg);
        
        Status s = nail.assemble(false);    
        if(s.status == Status.ERROR) {
            System.out.println("ERROR "+s.message);
            return;
        }        
        s = nail.assemble(true);
        if(s.status == Status.ERROR) {
            System.out.println("ERROR "+s.message);
            return;
        }    
        
        OutputStream ls = new FileOutputStream(fn+".lst");
        PrintStream ps = new PrintStream(ls);
        nail.printListing(ps);
        ps.flush();
        ps.close();
        
        OutputStream os = new FileOutputStream(fn+".bin");
        s = new Status();
        int [] b = nail.makeBinaryImage(s);
        if(s.status == Status.ERROR) {
            System.out.println("ERROR "+s.message);
            return;
        }
        for(int x=0;x<b.length;++x) {
            os.write(b[x]);
        }
        os.flush();
        os.close();
        
    }
    
}
