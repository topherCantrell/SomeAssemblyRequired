

import java.io.*;
import java.util.*;

class RoomDescription
{
    int startOfData;
    int lastUsedInData;
    int lastByte;
    String text;
    List roomNumbers = new ArrayList();
    
    public boolean equals(Object o)
    {
        RoomDescription dd = (RoomDescription)o;
        if(dd.startOfData != startOfData) return false;
        if(dd.lastUsedInData != lastUsedInData) return false;
        if(dd.lastByte != lastByte) return false;
        if(!dd.text.equals(text)) return false;
        return true;
    }
}

public class SixBitPack {    
        
    
    static int regA = 0;
    static int regB = 0;
    static int regX = 0;
    static int regY = 0;
    static int regU = 0;
    static int carryFlag = 0;
    
    
    public static void main(String [] args) throws Exception
    {
        InputStream is = new FileInputStream(args[0]);
        byte [] b = new byte[is.available()];
        is.read(b);
        is.close();
        
        int [] memory = new int[b.length + 0x600];
        for(int x=0;x<b.length;++x) {
            int a = b[x];
            if(a<0) a+=256;
            memory[x+0x600] = a;
        }
        
        int ls = 0x2b46;
               
        while(ls!=0x3c3f) {
            RoomDescription ra = unpackMessage(ls,memory,0);
            ls = ra.lastUsedInData + 1;
            
            System.out.println("; GeneralMessage "+Integer.toString(ra.startOfData,16));            
            System.out.println("; Packed data takes "+Integer.toString(ra.lastUsedInData-ra.startOfData+1)+" bytes.");
            System.out.println("pack("+ra.text+")");
            System.out.println("");
        }
        
    }
    
   /*
    public static void main(String [] args) throws Exception 
    {
        
        InputStream is = new FileInputStream(args[0]);
        byte [] b = new byte[is.available()];
        is.read(b);
        is.close();
        
        int [] memory = new int[b.length + 0x600];
        for(int x=0;x<b.length;++x) {
            int a = b[x];
            if(a<0) a+=256;
            memory[x+0x600] = a;
        }
        
        List rlist = new ArrayList();
        
        
        int rs = 0x112E;
        for(int x=0;x<81;++x) {
            int ro = rs+x*4;
            int a = memory[ro]*256 + memory[ro+1];
            int ab = memory[ro+2]*256 + memory[ro+3];
                        
            System.out.println("  .DW     RoomDescription_"+x);
            System.out.println("    .DW   0x"+Integer.toString(ab,16));
            RoomDescription rd = unpackMessage(a,memory,x+1);
            if(rd.startOfData==0) continue;
            int i = rlist.indexOf(rd);
            if(i>=0) {
                RoomDescription dd = (RoomDescription)rlist.get(i);
                dd.roomNumbers.add(rd.roomNumbers.get(0));
            } else {
                rlist.add(rd);
            }
        }
        
        boolean changed = true;
        while(changed) {
            changed = false;
            for(int x=0;x<rlist.size()-1;++x) {
                RoomDescription ra =  (RoomDescription)rlist.get(x);
                RoomDescription rb =  (RoomDescription)rlist.get(x+1);
                if(rb.startOfData<ra.startOfData) {
                    changed = true;
                    rlist.set(x,rb);
                    rlist.set(x+1,ra);
                }
            }
        }
        
        int ls = -1;
        for(int x=0;x<rlist.size();++x) {
            RoomDescription ra =  (RoomDescription)rlist.get(x);
            if(ls<0) {
                ls = ra.lastUsedInData+1;
            } else {                
                if(ls!=ra.startOfData) {
                    throw new RuntimeException("GAP");
                }
                ls = ra.lastUsedInData+1;
            }
            
            System.out.print("; Room");
            for(int y=0;y<ra.roomNumbers.size();++y) {
                System.out.print(" "+ra.roomNumbers.get(y));
            }
            System.out.println("");
            System.out.println("; Packed data takes "+Integer.toString(ra.lastUsedInData-ra.startOfData+1)+" bytes.");
            System.out.println("pack("+ra.text+")");
            System.out.println("");
            //System.out.println(Integer.toString(ra.startOfData,16)+":"+Integer.toString(ra.lastUsedInData,16)+":"+ra.text+":"+ra.lastByte);
        }
        
        System.out.println("-- "+Integer.toString(ls,16));
        
        
    }
*/
    
    public static RoomDescription unpackMessage(int start, int [] memory, int roomNumber)
    {
        RoomDescription rd = new RoomDescription();
        rd.roomNumbers.add(new Integer(roomNumber));
        rd.startOfData = start;
        rd.text = "";
        int len = memory[start++];
        regX = start;
        for(int y=0;y<len;++y) {
            int [] bb = threeDiv(memory);
            for(int x=0;x<bb.length;++x) {
                rd.text = rd.text +(char)bb[x];
            }
        }
        start = start+len*2;
        while(true) {
            if(memory[start]==0) {
                rd.lastUsedInData = start;
                rd.lastByte = 0;
                return rd;
            }
            if(memory[start]==1) {
                rd.lastUsedInData = start;
                rd.lastByte = 1;
                return rd;
            }
            if(memory[start]==0x0A) {
                throw new RuntimeException("Work Here");
            }
            rd.text = rd.text + (char)(memory[start++]);
        }        
        
    }
    
    public static int rol(int address, int carryIn, int [] memory)
    {
        int a = memory[address];
        a = a << 1;
        a = a | carryIn;
        memory[address] = a&0xFF;
        if(a>255) return 1;
        return 0;
    }
    
    public static int [] threeDiv(int [] memory) {
        regY = 0x204;                 //LDY #$0204
        regB = 0x03;                  //LDb #$03
        memory[0x1C2] = regB;         //STb $01C2
        regA = memory[regX++];        //LDa ,X+      ; Next in message
        memory[0x1FE] = regA;         //STa $01FE    ; Save it        
        regA = memory[regX++];        //LDa ,X+      ; Next in message
        memory[0x1FD] = regA;         //STa $01FD    ; Save it        
        regY = regY + 3;              //LEAY +$03,Y
        
        int [] three = new int[3];
        
        for(int x=0;x<3;++x) {
            div(memory);
            int v = memory[0x1FF]*256 + memory[0x200];
            v = v + 0x1106;
            v = memory[v];
            three[2-x] = v;
        }    
        
        return three;
        
    }
    
    public static void div(int [] memory) {
        
        regU = 0x28;                  //LDU #$0028   ; Number of characters in map
        memory[0x1C3] = regU/256;     //STU $01C3
        memory[0x1C4] = regU%256;     // ...
        regA = 0x11;                  //LDa #$11     ; 17 passes
        memory[0x203] = regA;         //STa $0203
        memory[0x1FF] = 0;            //CLR $01FF    ;
        memory[0x200] = 0;            //CLR $0200    ;
        
        while(true) {
            
            carryFlag = rol(0x1FE,carryFlag, memory);   //ROL $01FE
            carryFlag = rol(0x1FD,carryFlag, memory);   //ROL $01FD
            memory[0x203]-=1;                           //DEC $0203    ; All 17 shifts done? (Doesn't change C)
            if(memory[0x203]==0) {                
                return;                //BEQ $10D8    ; Yes ... print the extracted character
            }
            regA = 0;                                   //LDa #$00     ; Start with 0 (Doesn't change C)
            regA = regA + 0 + carryFlag;                //ADCa #$00    ; Add in carry from  ROL
            carryFlag = rol(0x200,0,memory);            //LSL $0200
            carryFlag = rol(0x1FF,carryFlag,memory);    //ROL $01FF
            regA = regA + memory[0x200];                //ADDa $0200
            if(regA>255) {                              // ...
                carryFlag = 1;                          // ...
            } else {                                    // ...
                carryFlag = 0;                          // ...
            }                                           // ...
            regA = regA & 0xFF;                         // ...
            regA = regA - memory[0x1C4];                //SUBa $01C4
            if(regA<0) {                                // ...
                carryFlag = 1;                          // ...
                regA = regA + 256;                      // ...
            } else {                                    // ...
                carryFlag = 0;                          // ...
            }                                           // ...            
            memory[0x202] = regA;                       //STa $0202
            regA = memory[0x01FF];                      //LDa $01FF
            regA = regA - memory[0x01C3] - carryFlag;   //SBCa $01C3
            if(regA<0) {                                // ...
                carryFlag = 1;                          // ...
                regA = regA + 256;                      // ...
            } else {                                    // ...
                carryFlag = 0;                          // ...
            }                                           // ...
            memory[0x201] = regA;                       //STa $0201
            
            //10BB: 24 0B           BCC $10C8
            //10BD: FC 02 01        LDD $0201
            //10C0: F3 01 C3        ADDD $01C3
            //10C3: FD 01 FF        STD $01FF
            //10C6: 20 06           BRA $10CE
            //10C8: FC 02 01        LDD $0201
            //10CB: FD 01 FF        STD $01FF
            //; Compliment C flag and continue
            //10CE: 25 04           BCS $10D4
            //10D0: 1A 01           ORCC #$01     ; Clear carry ...
            //10D2: 20 C0           BRA $1094     ; ... and continue
            //10D4: 1C FE           ANDCC #$FE    ; Set carry ...
            //10D6: 20 BC           BRA $1094     ; ... and continue
            
            if(carryFlag==1) {
                regA = memory[0x201];                         //LDD $0201
                regB = memory[0x202];                         // ...
                int d = regA * 256 + regB;                    // ...
                d = d + (memory[0x1c3]*256 + memory[0x1c4]);  //ADDD $01C3
                if(d>65535) {                                 // ...
                    carryFlag = 1;                            // ...
                } else {                                      // ...
                    carryFlag = 0;                            // ...
                }                                             // ...  
                regA = (d >> 8) & 0xFF;                       // ...
                regB = d & 0xFF;                              // ...
                memory[0x1FF] = regA;                         //STD $01FF
                memory[0x200] = regB;                         // ...
                
                if(carryFlag==1) {
                    carryFlag = 0;
                } else {
                    carryFlag = 1;
                }
                continue;
            }
            
            regA = memory[0x201];
            regB = memory[0x202];
            memory[0x1FF] = regA;
            memory[0x200] = regB;
            
            if(carryFlag==1) {
                carryFlag = 0;
            } else {
                carryFlag = 1;
            }           
            
        }
    }
    
    
    /*
    public static void main(String [] args) throws Exception
    {

        InputStream is = new FileInputStream(args[0]);
        byte [] b = new byte[is.available()];
        is.read(b);
        is.close();
        
        int s = Integer.parseInt(args[1],16);
        s = s-0x600;
        
        int [] dd = new int[200*8];
        
        for(int x=0;x<200;++x) {
            int a = b[s+x];
            if(a<0) a+=256;
            dd[x*8 + 0] = (a>>7)&1;
            dd[x*8 + 1] = (a>>6)&1;
            dd[x*8 + 2] = (a>>5)&1;
            dd[x*8 + 3] = (a>>4)&1;
            dd[x*8 + 4] = (a>>3)&1;
            dd[x*8 + 5] = (a>>2)&1;
            dd[x*8 + 6] = (a>>1)&1;
            dd[x*8 + 7] = (a>>0)&1;
        }
        
        for(int x=0;x<150;++x) {
            int a = dd[x*6+0]<<5 | 
                dd[x*6+1]<<4 |
                dd[x*6+2]<<3 |
                dd[x*6+3]<<2 |
                dd[x*6+4]<<1 |
                dd[x*6+5]<<0;     
            
            System.out.print(":"+a);
            //System.out.print((char)a);
        }
        System.out.println("");
        
    }
     */
     
     
    
}
