package simulator;

import org.w3c.dom.*;
import java.util.*;


// TOPHER TO DO

// There really is no B flag. I don't think you can set it or clear it. It
// gets set in the stacking operation of the BRK process. I'll have to play
// on the Atari2600 and see how it behaves to direct manipulation.

// Implement the interrupt sequence

// Test the stew out of everything

// Would be nice to have breakpoints

public class CPU_6502 implements Simulator {
    
    CPU cpu;
    
    // Flags: NO-BDIZC
    int regA, regX, regY, regSP, regPC, regFlags;    
    Map opcodeMap;
    
    boolean interruptNMI;
    boolean interruptIRQ;
    boolean interruptBRK;
    
    int lastPC;    
    
    boolean hardwareBreakPoint = false;
    int hardwareBreakPointAddress;
    boolean hardwareBreakPointWrite; 
    
    public CPU_6502() {
        
        opcodeMap = new HashMap();
        for(int x=0;x<rawProcessorOpcodeData.length;++x) {
            StringTokenizer st = new StringTokenizer(rawProcessorOpcodeData[x],":");
            OpcodeInfo oi = new OpcodeInfo();
            oi.opcode = Integer.parseInt(st.nextToken(),16);
            oi.extraBytes = Integer.parseInt(st.nextToken());
            oi.mnemonic = st.nextToken();
            oi.mode = st.nextToken();
            opcodeMap.put(new Integer(oi.opcode),oi);
        }         
        
    } 
    
    public void hardwareBreakPointHit(int address, boolean write) 
    {
        hardwareBreakPointWrite = write;
        hardwareBreakPointAddress = address;
        hardwareBreakPoint = true;
    } 
    
     public String step() {  
         
         int oc = cpu.getMemoryValue(regPC,false);
         OpcodeInfo oi = (OpcodeInfo)opcodeMap.get(new Integer(oc));
         if(oi==null) {
             System.out.println("Last Good PC: "+Integer.toString(lastPC,16));
             return "Unknown opcode: '"+Integer.toString(oc,16)+"' at '"+Integer.toString(regPC,16)+"'";
         }
         
         lastPC = regPC;
         //System.out.println("::"+Integer.toString(regPC,16));
         
         ++regPC;
         
         String ret = null;
         if(oi.extraBytes == 0) {
             ret = executeOpcode(oi,0,0);
         } else if(oi.extraBytes==1) {
             int a = cpu.getMemoryValue(regPC,false);
             ++regPC;
             ret = executeOpcode(oi,a,0);             
         } else if(oi.extraBytes==2) {
             int a = cpu.getMemoryValue(regPC,false);
             ++regPC;
             int b = cpu.getMemoryValue(regPC,false);
             ++regPC;
             ret = executeOpcode(oi,a,b);
         } else {             
             ret = "Internal error ... not expecting "+oi.extraBytes+" extra bytes.";
         }             
         
         int vector = -1;
         if(interruptNMI) {
             push(regFlags);
              regFlags |= 4;
             vector = 0xFFFA;     
             
         } else if(interruptIRQ && ((regFlags&4)==0)) {
             System.out.println("IRQ!");
             int nf = regFlags & ~16;
             push(nf);
             regFlags |= 4;
             vector = 0xFFFE;             
         } else if(interruptBRK) {
             int nf = regFlags | 16;
             push(nf);
              regFlags |= 4;
             vector = 0xFFFE;             
         }
         
         if(vector>0) {      
             push(regPC>>8);
             push(regPC&0xFF);            
             regPC = cpu.getMemoryValue(vector,false) + cpu.getMemoryValue(vector+1,false)*256;
             //System.out.println("regPC: "+Integer.toString(regPC,16));
         }
         interruptNMI = false;
         interruptIRQ = false;
         interruptBRK = false;
         
         if(regA>255 || regX>255 || regY>255 || regSP>255 || regPC>65535 ||
            regA<0 || regX<0 || regY<0 || regSP<0 || regPC<0) {
             throw new RuntimeException("REG RANGE:"+regA+":"+regX+":"+regY+":"+regSP+":"+regPC+":"+oi.mnemonic+":"+oi.mode);
         }
                           
         cpu.doSystemTick(1);
         
         if(ret!=null) return ret;
         
         if(hardwareBreakPoint) {
             hardwareBreakPoint = false;
             return "Hardware Break Point: "+Integer.toString(hardwareBreakPointAddress,16)+" write="+hardwareBreakPointWrite;
         }
         
         for(int x=0;x<cpu.softwareBreakPoints.length;++x) {
             if(regPC == cpu.softwareBreakPoints[x]) {
                 return "Software Break Point: "+Integer.toString(regPC,16);
             }
         }
         
         return null;
         
    }
    
    public void interrupt(String level, Object source)
    {        
        
        if(level.equals("IRQ")) interruptIRQ = true;
        else if(level.equals("NMI")) interruptNMI = true;
        else if(level.equals("BRK")) interruptBRK = true;
        else {
            System.out.println("Ignoring unknown interrupt request '"+level+"' from "+source);
        }
        
        return;
                
    }
    
    void setNegativeAndZero(int value)
    {
        if(value==0) {
            regFlags |= 2;
        } else {
            regFlags &= ~2;
        }
        if(value>=128) {            
            regFlags |= 128;
        } else {
            regFlags &= ~128;
        }
    }
    
    int fromBCD(int val) {
        int a = (val>>4) & 0x0F;
        int b = (val) & 0x0F;
        return a*10+b;
    }
    
    int toBCD(int val) {
        int a = val/10;
        int b = val%10;
        return a<<4 + b;
    }
    
    void push(int value)
    {
        cpu.setMemoryValue(0x0100+regSP,value,false);
        --regSP;
        if(regSP<0) regSP=255;        
    }
    
    int pull()
    {
        ++regSP;
        if(regSP>255) regSP=0;
        return cpu.getMemoryValue(0x0100+regSP,false);
    }
    
    public String executeOpcode(OpcodeInfo oi, int a, int b)
    {
                
        //System.out.println("::"+oi.mnemonic+":"+oi.mode);
        int decodedAddress = -1;
        if(oi.mode.equals("Zero Page")) {            
            decodedAddress = a;
        } else if(oi.mode.equals("Absolute")) {
            decodedAddress = a | (b<<8);
        } else if(oi.mode.startsWith("Zero Page, ")) {
            if(oi.mode.charAt(11) == 'X') decodedAddress = regX;
            else decodedAddress = regY;
            decodedAddress = (decodedAddress + a)&0xFF;
        } else if(oi.mode.startsWith("Absolute, ")) {
            if(oi.mode.charAt(10) == 'X') decodedAddress = regX;
            else decodedAddress = regY;
            decodedAddress = (decodedAddress + a + (b<<8))&0xFFFF;
        } else if(oi.mode.equals("Indirect, X")) {            
            // OPC ($BB,X)          
            a = (a + regX)&0xFF;
            b = (a+1)&0xFF;
            decodedAddress = cpu.getMemoryValue(a,false)+cpu.getMemoryValue(b,false)*256;            
        }  else if(oi.mode.equals("Indirect, Y")) { 
            // OPC ($LL),Y
            b = (a+1)&0xFF;
            decodedAddress = cpu.getMemoryValue(a,false)+cpu.getMemoryValue(b,false)*256;            
            decodedAddress = decodedAddress + regY;            
        }  else if(oi.mode.equals("Indirect")) {
            a = b*256 + a;
            // The 6502 acutally has a known bug here with page-crossings, but
            // we won't implement it here
            decodedAddress = cpu.getMemoryValue(decodedAddress,false) + cpu.getMemoryValue(decodedAddress+1,false);
        }  
        
        //System.out.println(":"+oi.mnemonic+":");
        
        // SE?
        if(oi.mnemonic.startsWith("SE")) {            
            if(oi.mnemonic.charAt(2)=='I') {
                regFlags |= 4;
            } else if(oi.mnemonic.charAt(2)=='D') {
                regFlags |= 8;
            } else if(oi.mnemonic.charAt(2)=='C') {
                regFlags |= 1;
            } else {
                return "Internal error: "+oi.mnemonic;
            }
            return null;
        }
        
        // ST flavors
        if(oi.mnemonic.startsWith("ST")) {
            char c = oi.mnemonic.charAt(2);
            // Which register to store ..
            int val = regA;
            if(c=='X') val = regX;
            else if(c=='Y') val = regY;
            
            if(decodedAddress<0) {
                return "Internal error: "+oi.mnemonic+":"+oi.mode;
            }
            cpu.setMemoryValue(decodedAddress,val,false);
            return null;            
        }
        
        // CL?
        if(oi.mnemonic.startsWith("CL")) {
            if(oi.mnemonic.charAt(2)=='I') {
                regFlags &= ~4;
            } else if(oi.mnemonic.charAt(2)=='D') {
                regFlags &= ~8;
            } else if(oi.mnemonic.charAt(2)=='C') {
                regFlags &= ~1;
            } else if(oi.mnemonic.charAt(2)=='V') {
                 regFlags &= ~64;
            } else {
                return "Internal error: "+oi.mnemonic;
            }
            return null;
        }
        
        // LD
        if(oi.mnemonic.startsWith("LD")) {
            char reg = oi.mnemonic.charAt(2);
            int val = -1;
            if(oi.mode.equals("Immediate")) {
                val = a;
            } else {
                if(decodedAddress<0) return "Internal error:"+oi.mnemonic+":"+oi.mode;
                val = cpu.getMemoryValue(decodedAddress,false);
            }
            
            if(reg=='A') regA = val;
            if(reg=='X') regX = val;
            if(reg=='Y') regY = val; 
            
            setNegativeAndZero(val);
            return null;
        }
        
        // Register-to-register transfer
        if(oi.mnemonic.equals("TAX") || oi.mnemonic.equals("TAY") ||
           oi.mnemonic.equals("TSX") || oi.mnemonic.equals("TXA") ||
           oi.mnemonic.equals("TXS") || oi.mnemonic.equals("TYA")) 
        {
            char src = oi.mnemonic.charAt(1);
            char dst = oi.mnemonic.charAt(2);
            int val = regA;
            if(src == 'S') val=regSP;
            else if(src == 'X') val=regX;
            else if(src == 'Y') val=regY;
            if(dst=='A') regA = val;
            else if(dst=='X') regX = val;
            else if(dst=='Y') regY = val;
            else if(dst=='S') regSP = val;    
            if(dst!='S') setNegativeAndZero(val);
            return null;
        }
        
        // JSR
        if(oi.mnemonic.equals("JSR")) {
            int dst = b*256 + a;            
            int in = regPC -1 ; // Weird, but this is how 6502 works
            int retLSB = in&255;
            int retMSB = in>>8;
            push(retMSB);            
            push(retLSB);
            regPC = dst;
            return null;
        }
        
        // RTS
        if(oi.mnemonic.equals("RTS")) {
            int retLSB = pull();
            int retMSB = pull();
            regPC = (retMSB*256 + retLSB)+1; // Again, weird but this is how 6502 works
            return null;
        }
        
        // IN?
        if(oi.mnemonic.startsWith("IN")) {
            char c = oi.mnemonic.charAt(2);
            int val = 0;
            if(c == 'X') {
                ++regX;
                if(regX>255) regX=0;
                val = regX;                
            } else if(c=='Y') {
                ++regY;
                if(regY>255) regY=0;
                val = regY;
            } else {
                val = cpu.getMemoryValue(decodedAddress,false);
                ++val;
                if(val>255) val = 0;
                cpu.setMemoryValue(decodedAddress,val,false);               
            }
            setNegativeAndZero(val);
            return null;
        }
        
        // DE?
        if(oi.mnemonic.startsWith("DE")) {
            char c = oi.mnemonic.charAt(2);
            int val = 0;
            if(c == 'X') {
                --regX;
                if(regX<0) regX=255;
                val = regX;                
            } else if(c=='Y') {
                --regY;
                if(regY<0) regY=255;
                val = regY;
            } else {
                val = cpu.getMemoryValue(decodedAddress,false);
                --val;
                if(val<0) val = 255;
                cpu.setMemoryValue(decodedAddress,val,false);               
            }
            setNegativeAndZero(val);
            return null;
        }
        
        // All branches
        if(oi.mode.equals("Relative")) {
            if(a>127) a=a-256;
            int destAddress = (regPC+a)&0xFFFF;
            
            boolean takeBranch = false;
            if(oi.mnemonic.equals("BCC")) {
                takeBranch = (regFlags&1)==0;
            } else if(oi.mnemonic.equals("BCS")) {
                takeBranch = (regFlags&1)!=0;
            } else if(oi.mnemonic.equals("BEQ")) {
                takeBranch = (regFlags&2)!=0;
            } else if(oi.mnemonic.equals("BNE")) {
                takeBranch = (regFlags&2)==0;
            } else if(oi.mnemonic.equals("BMI")) {
                takeBranch = (regFlags&128)!=0;
            } else if(oi.mnemonic.equals("BPL")) {
                takeBranch = (regFlags&128)==0;
            } else if(oi.mnemonic.equals("BVC")) {
                takeBranch = (regFlags&64)==0;
            } else if(oi.mnemonic.equals("BVS")) {
                takeBranch = (regFlags&64)!=0;
            } else {
                return "Unknown instruction: "+oi.mnemonic+":"+oi.mode;
            }
            
            if(takeBranch) {
                regPC = destAddress;
            }
            
            return null;
        }
        
        // EOR flavors
        if(oi.mnemonic.equals("EOR")) {
            int val = -1;
            if(oi.mode.equals("Immediate")) {
                val = a;
            } else {
                if(decodedAddress<0) return "Internal error:"+oi.mnemonic+":"+oi.mode;
                val = cpu.getMemoryValue(decodedAddress,false);
            }
            regA = regA ^ val;
            
            setNegativeAndZero(regA);
            return null;            
        }
        
        // AND flavors
        if(oi.mnemonic.equals("AND")) {
            int val = -1;
            if(oi.mode.equals("Immediate")) {
                val = a;
            } else {
                if(decodedAddress<0) return "Internal error:"+oi.mnemonic+":"+oi.mode;
                val = cpu.getMemoryValue(decodedAddress,false);
            }
            regA = regA & val;
            
            setNegativeAndZero(regA);
            return null;            
        }
        
        // ORA flavors
        if(oi.mnemonic.equals("ORA")) {            
            int val = -1;
            if(oi.mode.equals("Immediate")) {
                val = a;
            } else {                
                if(decodedAddress<0) return "Internal error:"+oi.mnemonic+":"+oi.mode;
                val = cpu.getMemoryValue(decodedAddress,false);
            }
            regA = regA | val;
            
            setNegativeAndZero(regA);
            return null;            
        }
        
        // ADC flavors
        if(oi.mnemonic.equals("ADC")) {
            int val = -1;
            if(oi.mode.equals("Immediate")) {
                val = a;
            } else {
                if(decodedAddress<0) return "Internal error:"+oi.mnemonic+":"+oi.mode;
                val = cpu.getMemoryValue(decodedAddress,false);
            }
            
            if( (regFlags & 0x08)==0 ) {
                // Plain old binary math
                regA = regA + val;
                if( (regFlags&1)>0 ) ++regA;                
                if(regA>255) {
                    regA = regA & 0xFF;
                    regFlags = regFlags | 1;
                } else {
                    regFlags = regFlags & ~1;
                }                
                setNegativeAndZero(regA);
            } else {
                // BCD math
                int aa = fromBCD(regA);
                int v = fromBCD(val);
                aa = aa + v;
                if( (regFlags&1)>0 ) ++aa;
                if(aa>99) {
                    aa = aa % 100;
                    regFlags = regFlags | 1;
                } else {
                    regFlags = regFlags & ~1;
                }
                regA = toBCD(aa);
                setNegativeAndZero(regA);
            }
            return null;            
        }
        
        // SBC flavors
        if(oi.mnemonic.equals("SBC")) {
            int val = -1;
            if(oi.mode.equals("Immediate")) {
                val = a;
            } else {
                if(decodedAddress<0) return "Internal error:"+oi.mnemonic+":"+oi.mode;
                val = cpu.getMemoryValue(decodedAddress,false);
            }
            
            if( (regFlags & 0x08)==0 ) {
                regA = regA - val;
                if( (regFlags&1)==0 ) --regA;                
                if(regA<0) {
                    regA = regA+256;
                    regFlags = regFlags & ~1;
                } else {
                    regFlags = regFlags | 1;
                }
                setNegativeAndZero(regA);
            } else {
                int aa = fromBCD(regA);
                int v = fromBCD(val);
                aa = aa - v;
                if( (regFlags&1)==0) --aa;
                if(aa<0) {
                    aa =aa+100;
                    regFlags = regFlags & ~1;
                } else {
                    regFlags = regFlags | 1;
                }
                regA = toBCD(aa);
                setNegativeAndZero(regA);     
            }                   
            return null;            
        }
        
        // BIT
        if(oi.mnemonic.equals("BIT")) {            
            if(decodedAddress<0) return "Internal error:"+oi.mnemonic+":"+oi.mode;
            int val = cpu.getMemoryValue(decodedAddress,false);
            int mv = val & 0xC0; // Upper two bits
            regFlags = (regFlags&0x3F) | mv; // Move upper two bits to flags
            if( (val&regA)==0 ) {
                regFlags = regFlags | 2;
            } else {
                regFlags = regFlags & ~2;
            }            
            return null;
        }

        // NOP
        if(oi.mnemonic.equals("NOP")) {
            return null;
        }
        
        // PHA
        if(oi.mnemonic.equals("PHA")) {
            push(regA);
            return null;
        }
        
        // PHP
        if(oi.mnemonic.equals("PHP")) {
            push(regFlags);
            return null;
        }
        
        // PLA
        if(oi.mnemonic.equals("PLA")) {
            regA = pull();
            return null;
        }
        
        // PLP
        if(oi.mnemonic.equals("PLP")) {
            regFlags = pull();
            return null;
        }
        
        // LSR
        if(oi.mnemonic.equals("LSR")) {
            int val = -1;
            boolean cf = false;
            if(oi.mode.equals("Accumulator")) {
                if( (regA&1)>0) cf=true;
                regA = regA >> 1;
                val = regA;
            } else {
                val = cpu.getMemoryValue(decodedAddress,false);
                if( (val&1)>0) cf = true;
                val = val >> 1;
                cpu.setMemoryValue(decodedAddress,val,false);
            }
            
            if( (val&regA)==0 ) {
                regFlags = regFlags | 2;
            } else {
                regFlags = regFlags & ~2;
            }    
            
            regFlags = regFlags & ~128;
            
            if(cf) {
                regFlags = regFlags | 1;
            } else {
                regFlags = regFlags & ~1;
            }
            
            return null;
        }
        
        // ASL
        if(oi.mnemonic.equals("ASL")) {
            int val = -1;
            boolean cf = false;
            if(oi.mode.equals("Accumulator")) {
                if( (regA&128)>0) cf=true;
                regA = (regA << 1)&0xFF;
                val = regA;
            } else {
                val = cpu.getMemoryValue(decodedAddress,false);
                if( (val&128)>0) cf = true;
                val = (val << 1)&0xFF;
                cpu.setMemoryValue(decodedAddress,val,false);
            }
                       
            setNegativeAndZero(val);
            
            if(cf) {
                regFlags = regFlags | 1;
            } else {
                regFlags = regFlags & ~1;
            }
            
            return null;
        }
        
        // ROL
        if(oi.mnemonic.equals("ROL")) {
            int val = -1;
            boolean cf = false;
            int b0 = 0;
            if( (regFlags&1)>1 ) b0 = 1;
            if(oi.mode.equals("Accumulator")) {
                if( (regA&128)>0) cf=true;
                regA = (regA << 1)&0xFF;
                regA = regA | b0;
                val = regA;
            } else {
                val = cpu.getMemoryValue(decodedAddress,false);
                if( (val&128)>0) cf = true;
                val = (val << 1)&0xFF;
                val = val | b0;
                cpu.setMemoryValue(decodedAddress,val,false);
            }
                       
            setNegativeAndZero(val);
            
            if(cf) {
                regFlags = regFlags | 1;
            } else {
                regFlags = regFlags & ~1;
            }
            
            return null;
        }
        
        // ROR
        if(oi.mnemonic.equals("ROR")) {
            int val = -1;
            boolean cf = false;
            int b0 = 0;
            if( (regFlags&1)>1 ) b0 = 128;
            if(oi.mode.equals("Accumulator")) {
                if( (regA&1)>0) cf=true;
                regA = (regA >> 1)&0xFF;
                regA = regA | b0;
                val = regA;
            } else {
                val = cpu.getMemoryValue(decodedAddress,false);
                if( (val&1)>0) cf = true;
                val = (val >> 1)&0xFF;
                val = val | b0;
                cpu.setMemoryValue(decodedAddress,val,false);
            }
                       
            setNegativeAndZero(val);
            
            if(cf) {
                regFlags = regFlags | 1;
            } else {
                regFlags = regFlags & ~1;
            }
            
            return null;
        }
        
        
        // CMP
        if(oi.mnemonic.equals("CMP")) {            
            int val = -1;
            if(oi.mode.equals("Immediate")) {
                val = a;
            } else {
                if(decodedAddress<0) return "Internal error:"+oi.mnemonic+":"+oi.mode;
                val = cpu.getMemoryValue(decodedAddress,false);
            }
            
            int cmpval = regA - val;                
            
            if(cmpval<0) {
                regFlags = regFlags & ~1;
            } else {                
                regFlags = regFlags | 1;
            }
            
            setNegativeAndZero(cmpval);
            return null;            
        }        
        
        
        if(oi.mnemonic.equals("CPX")) {
            int val = -1;
            if(oi.mode.equals("Immediate")) {
                val = a;
            } else {
                if(decodedAddress<0) return "Internal error:"+oi.mnemonic+":"+oi.mode;
                val = cpu.getMemoryValue(decodedAddress,false);
            }
            
            int cmpval = regX - val;            
            
            if(cmpval<0) {                
                regFlags = regFlags & ~1;
            } else {
                regFlags = regFlags | 1;
            }
            
            setNegativeAndZero(cmpval);
            return null;         
        }
        
         if(oi.mnemonic.equals("CPY")) {
            int val = -1;
            if(oi.mode.equals("Immediate")) {
                val = a;
            } else {
                if(decodedAddress<0) return "Internal error:"+oi.mnemonic+":"+oi.mode;
                val = cpu.getMemoryValue(decodedAddress,false);
            }
            
            int cmpval = regY - val;            
            
            if(cmpval<0) {                
                regFlags = regFlags & ~1;
            } else {
                regFlags = regFlags | 1;
            }
            
            setNegativeAndZero(cmpval);
            return null;         
        }
        
        if(oi.mnemonic.equals("JMP")) {
            regPC = b*256 + a;
            return null;
        }
        
        
        if(oi.mnemonic.equals("BRK")) {                       
            interrupt("BRK",null);            
            return null;
        }        
        
        if(oi.mnemonic.equals("RTI")) {            
            regPC = pull() + pull()*256;
            regFlags = pull();
            return null;
        }
        
        return "Unimplementd:"+oi.mnemonic+" "+oi.mode;
    }
    
    
    
    
    
        
    // Nothing 6502 specific to do
    public void loadXML(CPU cpu, Node n) { 
        this.cpu = cpu;        
    }
    
    public void reset() {
        interruptNMI = false;
        interruptIRQ = false;
        interruptBRK = false;
        int vector = cpu.getMemoryValue(0xFFFD,false)*256 + cpu.getMemoryValue(0xFFFC,false);
        regPC = vector;        
    }
    
    public int getRegisterSize(String name) {
        if(name.equals("A")) return 8;
        if(name.equals("X") || name.equals("Y")) return 8;
        if(name.equals("SP")) return 8;
        if(name.equals("Flags")) return 8;
        if(name.equals("PC")) return 16;
        throw new RuntimeException("Unknown register '"+name+"'");
    }    
    
    public int getRegisterValue(String name) {
        if(name.equals("A")) return regA;
        if(name.equals("X")) return regX;
        if(name.equals("Y")) return regY;
        if(name.equals("SP")) return regSP;
        if(name.equals("Flags")) return regFlags;
        if(name.equals("PC")) return regPC;
        throw new RuntimeException("Unknown register '"+name+"'");
    }
    
    public void setRegisterValue(String name, int value) {
        if(name.equals("A")) regA = value;
        else if(name.equals("X")) regX = value;
        else if(name.equals("Y")) regY = value;
        else if(name.equals("SP")) regSP = value;
        else if(name.equals("Flags")) regFlags = value;
        else if(name.equals("PC")) regPC = value;
        else throw new RuntimeException("Unknown register '"+name+"'");
    }
       
    class OpcodeInfo {
        int opcode;
        int extraBytes;
        String mnemonic;
        String mode;
    }
    
    static final String [] rawProcessorOpcodeData = {
        "69:1:ADC:Immediate",
        "65:1:ADC:Zero Page",
        "75:1:ADC:Zero Page, X",
        "6D:2:ADC:Absolute",
        "7D:2:ADC:Absolute, X",
        "79:2:ADC:Absolute, Y",
        "61:1:ADC:Indirect, X",
        "71:1:ADC:Indirect, Y",
        "29:1:AND:Immediate",
        "25:1:AND:Zero Page",
        "35:1:AND:Zero Page, X",
        "2D:2:AND:Absolute",
        "3D:2:AND:Absolute, X",
        "39:2:AND:Absolute, Y",
        "21:1:AND:Indirect, X",
        "31:1:AND:Indirect, Y",
        "0A:0:ASL:Accumulator",
        "06:1:ASL:Zero Page",
        "16:1:ASL:Zero Page, X",
        "0E:2:ASL:Absolute",
        "1E:2:ASL:Absolute, X",
        "24:1:BIT:Zero Page",
        "2C:2:BIT:Absolute",
        "00:0:BRK:Implied",
        "90:1:BCC:Relative",
        "B0:1:BCS:Relative",
        "F0:1:BEQ:Relative",
        "30:1:BMI:Relative",
        "D0:1:BNE:Relative",
        "10:1:BPL:Relative",
        "50:1:BVC:Relative",
        "70:1:BVS:Relative",
        "18:0:CLC:Implied",
        "D8:0:CLD:Implied",
        "58:0:CLI:Implied",
        "B8:0:CLV:Implied",
        "C9:1:CMP:Immediate",
        "C5:1:CMP:Zero Page",
        "D5:1:CMP:Zero Page, X",
        "CD:2:CMP:Absolute",
        "DD:2:CMP:Absolute, X",
        "D9:2:CMP:Absolute, Y",
        "C1:1:CMP:Indirect, X",
        "D1:1:CMP:Indirect, Y",
        "E0:1:CPX:Immediate",
        "E4:1:CPX:Zero Page",
        "EC:2:CPX:Absolute",
        "C0:1:CPY:Immediate",
        "C4:1:CPY:Zero Page",
        "CC:2:CPY:Absolute",
        "C6:1:DEC:Zero Page",
        "D6:1:DEC:Zero Page, X",
        "CE:2:DEC:Absolute",
        "DE:2:DEC:Absolute, X",
        "CA:0:DEX:Implied",
        "88:0:DEY:Implied",
        "49:1:EOR:Immediate",
        "45:1:EOR:Zero Page",
        "55:1:EOR:Zero Page, X",
        "4D:2:EOR:Absolute",
        "5D:2:EOR:Absolute, X",
        "59:2:EOR:Absolute, Y",
        "41:1:EOR:Indirect, X",
        "51:1:EOR:Indirect, Y",
        "E6:1:INC:Zero Page",
        "F6:1:INC:Zero Page, X",
        "EE:2:INC:Absolute",
        "FE:2:INC:Absolute, X",
        "E8:0:INX:Implied",
        "C8:0:INY:Implied",
        "4C:2:JMP:Absolute",
        "5C:2:JMP:Indirect",
        "20:2:JSR:Absolute",
        "A9:1:LDA:Immediate",
        "A5:1:LDA:Zero Page",
        "B5:1:LDA:Zero Page, X",
        "AD:2:LDA:Absolute",
        "BD:2:LDA:Absolute, X",
        "B9:2:LDA:Absolute, Y",
        "A1:1:LDA:Indirect, X",
        "B1:1:LDA:Indirect, Y",
        "A2:1:LDX:Immediate",
        "A6:1:LDX:Zero Page",
        "B6:1:LDX:Zero Page, Y",
        "AE:2:LDX:Absolute",
        "BE:2:LDX:Absolute, Y",
        "A0:1:LDY:Immediate",
        "A4:1:LDY:Zero Page",
        "B4:1:LDY:Zero Page, X",
        "AC:2:LDY:Absolute",
        "BC:2:LDY:Absolute, X",
        "4A:0:LSR:Accumulator",
        "46:1:LSR:Zero Page",
        "56:1:LSR:Zero Page, X",
        "4E:2:LSR:Absolute",
        "5E:2:LSR:Absolute, X",
        "EA:0:NOP:Implied",
        "09:1:ORA:Immediate",
        "05:1:ORA:Zero Page",
        "15:1:ORA:Zero Page, X",
        "0D:2:ORA:Absolute",
        "1D:2:ORA:Absolute, X",
        "19:2:ORA:Absolute, Y",
        "01:1:ORA:Indirect, X",
        "11:1:ORA:Indirect, Y",
        "48:0:PHA:Implied",
        "08:0:PHP:Implied",
        "68:0:PLA:Implied",
        "28:0:PLP:Implied",
        "2A:0:ROL:Accumulator",
        "26:1:ROL:Zero Page",
        "36:1:ROL:Zero Page, X",
        "2E:2:ROL:Absolute",
        "3E:2:ROL:Absolute, X",
        "6A:0:ROR:Accumulator",
        "66:1:ROR:Zero Page",
        "76:1:ROR:Zero Page, X",
        "6E:2:ROR:Absolute",
        "7E:2:ROR:Absolute, X",
        "40:0:RTI:Implied",
        "60:0:RTS:Implied",
        "E9:1:SBC:Immediate",
        "E5:1:SBC:Zero Page",
        "F5:1:SBC:Zero Page, X",
        "ED:2:SBC:Absolute",
        "FD:2:SBC:Absolute, X",
        "F9:2:SBC:Absolute, Y",
        "E1:1:SBC:Indirect, X",
        "F1:1:SBC:Indirect, Y",
        "38:0:SEC:Implied",
        "F8:0:SED:Implied",
        "78:0:SEI:Implied",
        "85:1:STA:Zero Page",
        "95:1:STA:Zero Page, X",
        "8D:2:STA:Absolute",
        "9D:2:STA:Absolute, X",
        "99:2:STA:Absolute, Y",
        "81:1:STA:Indirect, X",
        "91:1:STA:Indirect, Y",
        "86:1:STX:Zero Page",
        "96:1:STX:Zero Page, Y",
        "8E:2:STX:Absolute",
        "84:1:STY:Zero Page",
        "94:1:STY:Zero Page, X",
        "8C:2:STY:Absolute",
        "AA:0:TAX:Implied",
        "A8:0:TAY:Implied",
        "BA:0:TSX:Implied",
        "8A:0:TXA:Implied",
        "9A:0:TXS:Implied",
        "98:0:TYA:Implied"
    };
    
}