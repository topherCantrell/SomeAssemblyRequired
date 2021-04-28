package assembler;

import java.io.*;
import javax.xml.parsers.*;
import org.w3c.dom.*;

import java.util.*;

/**
 * The "processor.xml" file for the 6502 is easy to parse. There is at most
 * one fill-in on a single line. So removing the spaces leaves three possible
 * parts ... pre, fill, post. If the white-space-removed assembly begins with
 * the pre and ends with the post, it must be a match (for all 6502 ops).
 */

class Nail6502Instruction
{
    String mnemonicPre;
    String mnemonicFill;
    String mnemonicPost;
    
    String mnemonicA;
    String mnemonicB;
    String mode;
    int opcode;
    int numBytes;
}

public class Nail6502 implements NailAssemblerInterface 
{
    
    Nail nail;
    int oc = 0;
    
    List<Nail6502Instruction> instructions;
    
    /**
     * This function removes white space unless it is part of a string
     * or character expression.
     * @param a the string to clean
     * @return the clean string
     */
    String removeWhiteSpace(String a) {
        byte [] b = a.getBytes();
        byte [] bb = new byte[b.length];
        int y = 0;
        char marker = 0;
        for(int x=0;x<b.length;++x) {
            if(marker!=0) {
                bb[y++] = b[x];
                if(b[x]==marker) {
                    marker = 0;
                }
                continue;
            }
            if(b[x]=='\'' || b[x]=='"') {
                marker = (char)b[x];
            }
            if(b[x]!=' ' && b[x]!='\t') {
                bb[y++] = b[x];
            }
        }
        String ret = new String(bb,0,y);
        return ret;        
    }

    public Status processAssembly(Line line, boolean finalPass) 
    {        
        
        // Build an uppercase temp of the line and strip out the white-space
        String rb = removeWhiteSpace(line.assem);        
        String ra = rb.toUpperCase();
        
        // Build a list of all instructions that could match base on pre and post strings
        //System.out.println(":::"+ra+":::");
        List<Nail6502Instruction> ins = new ArrayList<Nail6502Instruction>();
        int ms = 0;        
        for(int x=0;x<instructions.size();++x) {
            Nail6502Instruction a = instructions.get(x);
            if(ra.startsWith(a.mnemonicPre) && ra.endsWith(a.mnemonicPost)) {
                ins.add(a);
                int ts = a.mnemonicPre.length()+a.mnemonicPost.length();
                if(ts>ms) ms=ts;
                //System.out.println(ra+"::>>"+a.mnemonicPre+":"+a.mnemonicFill+":"+a.mnemonicPost);
            }
        }
        
        // Keep only the most specific matches
       
        for(int x=ins.size()-1;x>=0;--x) {
            Nail6502Instruction a = ins.get(x);
            if(a.mnemonicPost.length()+a.mnemonicPre.length()!=ms) {
                ins.remove(x);
            }
        }
        
        
        // Make sure we found 1 or 2 matching instructions
        if(ins.size()==0) {
             return new Status(Status.ERROR,"Unknown instruction.",line);
        }        
        if(ins.size()>2) {
            for(int x=0;x<ins.size();++x) {
                Nail6502Instruction a = ins.get(x);
                //System.out.println("::"+a.mnemonicPre+" "+a.mnemonicFill+" "+a.mnemonicPost+" "+a.mode);
            }
            throw new RuntimeException("Nail6502 internal parse error. More than 2 matches.");
        }
        
        // The fill (if any).
        ra = rb.substring(ins.get(0).mnemonicPre.length(),rb.length()-ins.get(0).mnemonicPost.length());
        Status ss = new Status();
        int tv = 0;
        if(ra.length()>0) {
            //System.out.println("::"+ra+"::");
            tv = nail.processExpression(ra,ss);
            if(finalPass && ss.status!=Status.OK) {
                return new Status(Status.ERROR,"Could not evaluate '"+ra+"'",line);
            }
        }
        
        // If there are two we have to select between ZeroPage and Absolute
        if(ins.size()==2) {
            if(!ins.get(0).mode.startsWith("ZeroPage")) {
                throw new RuntimeException("Nail6502 internal parse error. Expected ZeroPage mode");
            }
            if(!ins.get(1).mode.startsWith("Absolute")) {
                throw new RuntimeException("Nail6502 internal parse error. Expected Absolute mode");
            }            
            
            if(ss.status == Status.ERROR) {
                //System.out.println(":Could not resolve");
                ins.remove(0);                                
            } else {
                if(tv<256) {
                    // The resolved value is 1 byte ... use ZeroPage form
                    ins.remove(1);
                    //System.out.println(":It's <256");
                } else {
                    // The resolved value is 2 bytes ... use Absolute
                    ins.remove(0);
                    //System.out.println(":It's >256");
                }
            }
        }
        
        // Found the right instruction
        Nail6502Instruction a = ins.get(0);
        
        // Prepare the data area
        line.bytes = new int[a.numBytes];
        for(int x=0;x<a.numBytes;++x) line.bytes[x] = -1;
        
        if(a.opcode<256) {
            line.bytes[0] = a.opcode;
        } else {
            line.bytes[0] = a.opcode/256;
            line.bytes[1] = a.opcode%256;
        }
        
        if(!finalPass) return new Status();  
        
        if(a.mode.equals("Implied")) {
            // Nothing to do
            return new Status();
        }
        
        if(a.mode.equals("Immediate")) {
            // One byte data            
            line.bytes[line.bytes.length-1] = tv%256;
            return new Status();
        }
        
        if(a.mode.startsWith("ZeroPage")) {
            if(tv>255) {
                return new Status(Status.ERROR,"Address is not in ZeroPage.",line);
            }
            line.bytes[line.bytes.length-1] = tv;
            return new Status();
        }
        
        if(a.mode.startsWith("Absolute")) {
            // Absolute address are always two additional bytes
            line.bytes[line.bytes.length-2] = tv%256;
            line.bytes[line.bytes.length-1] = tv/256;
            return new Status();            
        }
        
        if(a.mode.equals("Relative")) {
            int pcAfter = line.address + line.bytes.length;            
            int dv = tv-pcAfter;
            if(dv<-128 || dv>127) {
                return new Status(Status.ERROR,"Target address is out of range.",line);
            }            
            if(dv<0) dv=dv+256;            
            line.bytes[line.bytes.length-1] = dv;            
            return new Status();
        }
        
        throw new RuntimeException("Unknown addressing mode:"+a.mnemonicPre+":"+ra+":"+a.mnemonicPost+":"+a.mode);                
            
    } 
    
    void processInstructionFile(String name) 
    {
         try {
            ClassLoader c = Nail6502.class.getClassLoader();
            InputStream is = c.getResourceAsStream(name);
            
            DocumentBuilderFactory dbf = DocumentBuilderFactory.newInstance();
            DocumentBuilder b = dbf.newDocumentBuilder();
            
            Document d = b.parse(is);
            
            Element e = d.getDocumentElement();
            
            instructions = new ArrayList<Nail6502Instruction>();
            
            NodeList o = e.getChildNodes();
            for(int x=0;x<o.getLength();++x) {
                Node oo = o.item(x);
                short t = oo.getNodeType();
                if(t!=Node.ELEMENT_NODE) continue;                
                if(!oo.getNodeName().equals("Instruction")) continue;
                
                Nail6502Instruction i = new Nail6502Instruction();
                NamedNodeMap pio = oo.getAttributes();
                String m = pio.getNamedItem("mnemonic").getNodeValue();
                i.mode = pio.getNamedItem("mode").getNodeValue();
                i.opcode = Integer.parseInt(pio.getNamedItem("opcode").getNodeValue(),16);
                i.numBytes = Integer.parseInt(pio.getNamedItem("bytes").getNodeValue());
                
                int aa = m.indexOf("@");
                if(aa<0) {
                    i.mnemonicPre = m;
                    i.mnemonicPost = "";
                    i.mnemonicFill = "";
                } else {
                    int bb = m.indexOf("@",aa+1);
                    i.mnemonicPre = m.substring(0,aa);
                    i.mnemonicFill = m.substring(aa+1,bb);
                    i.mnemonicPost = m.substring(bb+1);
                }
                
                //i.mnemonic = m;
                                
                int z = m.indexOf(" ");
                if(z<0) {
                    i.mnemonicA = m;
                } else {
                    i.mnemonicA = m.substring(0,z);
                    i.mnemonicB = m.substring(z+1);
                }
                
                instructions.add(i);
                
            }
            
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    
    public void setNail(Nail nail) {
        this.nail = nail;        
        processInstructionFile("ProcessorInfo/6502/processor.xml");              
    }
    
    public boolean isBigEndian() {
        return false;
    }
    
}
