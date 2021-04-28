
import java.io.*;
import java.util.*;

class Instruction
{
    String mnemonic;
    String opCodeAssem;
    int [] opCode;
    String cycles;
    String numBytes;
    String description;
    String flags;
    
    void toXML(PrintStream ps) {
        //<Instruction mnemonic="" opCode="" flags="" description=""/>        
        ps.println("  <Instruction mnemonic=\""+mnemonic+"\" opCode=\""+opCodeAssem+"\" flags=\""+flags+"\" description=\""+description+"\"/>");
    }
    
    Instruction(String [] data,int mode)
    {
        mnemonic = data[1];
        
        opCodeAssem = data[2+mode*3];
        StringTokenizer st=new StringTokenizer(opCodeAssem," ");
        opCode = new int[st.countTokens()];
        for(int x=0;x<opCode.length;++x) {
            opCode[x]=Integer.parseInt(st.nextToken(),16);
        }
        cycles = data[2+mode*3+1];
        numBytes = data[2+mode*3+2];
        
        description = data[17];
        for(int x=18;x<23;++x) {
            if(data[x].equals("")) data[x]=" ";
        }
        flags = data[18].charAt(0)+""+data[19].charAt(0)+""+data[20].charAt(0)+
          ""+data[21].charAt(0)+""+data[22].charAt(0);
    }
}

public class Strip
{
    
    static String [] exgTfrRegisters = {
        "D,X",    "01",
        "D,Y",    "02",
        "D,U",    "03",
        "D,S",    "04",
        "D,PC",   "05",
        "X,Y",    "12",
        "X,U",    "13",
        "X,S",    "14",
        "X,PC",   "15",
        "Y,U",    "23",
        "Y,S",    "24",
        "Y,PC",   "25",
        "U,S",    "34",
        "U,PC",   "35",
        "S,PC",   "45",
        "A,B",    "89",
        "A,CCR",  "8A",
        "A,DP",   "8B",
        "B,CCR",  "9A",
        "B,DP",   "9B",
        "CCR,DP", "AB",
        
        "X,D",    "10",
        "Y,D",    "20",
        "U,D",    "30",
        "S,D",    "40",
        "PC,D",   "50",
        "Y,X",    "21",
        "U,X",    "31",
        "S,X",    "41",
        "PC,X",   "51",
        "U,Y",    "32",
        "S,Y",    "42",
        "PC,Y",   "52",
        "S,U",    "43",
        "PC,U",   "53",
        "PC,S",   "54",
        "B,A",    "98",
        "CCR,A",  "A8",
        "DP,A",   "B8",
        "CCR,B",  "A9",
        "DP,B",   "B9",
        "DP,CCR", "BA"
    };
    
    static String [] postByteInfo = {
        "0,X", "0",
"1,X", "1",
"2,X", "2",
"3,X", "3",
"4,X", "4",
"5,X", "5",
"6,X", "6",
"7,X", "7",
"8,X", "8",
"9,X", "9",
"10,X", "a",
"11,X", "b",
"12,X", "c",
"13,X", "d",
"14,X", "e",
"15,X", "f",
"-16,X", "10",
"-15,X", "11",
"-14,X", "12",
"-13,X", "13",
"-12,X", "14",
"-11,X", "15",
"-10,X", "16",
"-9,X", "17",
"-8,X", "18",
"-7,X", "19",
"-6,X", "1a",
"-5,X", "1b",
"-4,X", "1c",
"-3,X", "1d",
"-2,X", "1e",
"-1,X", "1f",
"0,Y", "20",
"1,Y", "21",
"2,Y", "22",
"3,Y", "23",
"4,Y", "24",
"5,Y", "25",
"6,Y", "26",
"7,Y", "27",
"8,Y", "28",
"9,Y", "29",
"10,Y", "2a",
"11,Y", "2b",
"12,Y", "2c",
"13,Y", "2d",
"14,Y", "2e",
"15,Y", "2f",
"-16,Y", "30",
"-15,Y", "31",
"-14,Y", "32",
"-13,Y", "33",
"-12,Y", "34",
"-11,Y", "35",
"-10,Y", "36",
"-9,Y", "37",
"-8,Y", "38",
"-7,Y", "39",
"-6,Y", "3a",
"-5,Y", "3b",
"-4,Y", "3c",
"-3,Y", "3d",
"-2,Y", "3e",
"-1,Y", "3f",
"0,U", "40",
"1,U", "41",
"2,U", "42",
"3,U", "43",
"4,U", "44",
"5,U", "45",
"6,U", "46",
"7,U", "47",
"8,U", "48",
"9,U", "49",
"10,U", "4a",
"11,U", "4b",
"12,U", "4c",
"13,U", "4d",
"14,U", "4e",
"15,U", "4f",
"-16,U", "50",
"-15,U", "51",
"-14,U", "52",
"-13,U", "53",
"-12,U", "54",
"-11,U", "55",
"-10,U", "56",
"-9,U", "57",
"-8,U", "58",
"-7,U", "59",
"-6,U", "5a",
"-5,U", "5b",
"-4,U", "5c",
"-3,U", "5d",
"-2,U", "5e",
"-1,U", "5f",
"0,S", "60",
"1,S", "61",
"2,S", "62",
"3,S", "63",
"4,S", "64",
"5,S", "65",
"6,S", "66",
"7,S", "67",
"8,S", "68",
"9,S", "69",
"10,S", "6a",
"11,S", "6b",
"12,S", "6c",
"13,S", "6d",
"14,S", "6e",
"15,S", "6f",
"-16,S", "70",
"-15,S", "71",
"-14,S", "72",
"-13,S", "73",
"-12,S", "74",
"-11,S", "75",
"-10,S", "76",
"-9,S", "77",
"-8,S", "78",
"-7,S", "79",
"-6,S", "7a",
"-5,S", "7b",
"-4,S", "7c",
"-3,S", "7d",
"-2,S", "7e",
"-1,S", "7f",
",X+", "80",
"X++", "81",
"-X", "82",
"--X", "83",
",X", "84",
"B,X", "85",
"A,X", "86",
"bb,X", "88",
"bbbb,X", "89",
"D,X", "8b",
"bb,PC", "8c",
"bbbb,PC", "8d",
"[,X++]", "91",
"[,--X]", "93",
"[,X]", "94",
"[B,X]", "95",
"[A,X]", "96",
"[bb,X]", "98",
"[bbbb,X]", "99",
"[D,X]", "9b",
"[bb,PC]", "9c",
"[bbbb,PC]", "9d",
"[bbbb]", "9f",
",Y+", "a0",
"Y++", "a1",
"-Y", "a2",
"--Y", "a3",
",Y", "a4",
"B,Y", "a5",
"A,Y", "a6",
"bb,Y", "a8",
"bbbb,Y", "a9",
"D,Y", "ab",
"bb,PC", "ac",
"bbbb,PC", "ad",
"[,Y++]", "b1",
"[,--Y]", "b3",
"[,Y]", "b4",
"[B,Y]", "b5",
"[A,Y]", "b6",
"[bb,Y]", "b8",
"[bbbb,Y]", "b9",
"[D,Y]", "bb",
"[bb,PC]", "bc",
"[bbbb,PC]", "bd",
"[bbbb]", "bf",
",U+", "c0",
"U++", "c1",
"-U", "c2",
"--U", "c3",
",U", "c4",
"B,U", "c5",
"A,U", "c6",
"bb,U", "c8",
"bbbb,U", "c9",
"D,U", "cb",
"bb,PC", "cc",
"bbbb,PC", "cd",
"[,U++]", "d1",
"[,--U]", "d3",
"[,U]", "d4",
"[B,U]", "d5",
"[A,U]", "d6",
"[bb,U]", "d8",
"[bbbb,U]", "d9",
"[D,U]", "db",
"[bb,PC]", "dc",
"[bbbb,PC]", "dd",
"[bbbb]", "df",
",S+", "e0",
"S++", "e1",
"-S", "e2",
"--S", "e3",
",S", "e4",
"B,S", "e5",
"A,S", "e6",
"bb,S", "e8",
"bbbb,S", "e9",
"D,S", "eb",
"bb,PC", "ec",
"bbbb,PC", "ed",
"[,S++]", "f1",
"[,--S]", "f3",
"[,S]", "f4",
"[B,S]", "f5",
"[A,S]", "f6",
"[bb,S]", "f8",
"[bbbb,S]", "f9",
"[D,S]", "fb",
"[bb,PC]", "fc",
"[bbbb,PC]", "fd",
"[bbbb]", "ff"
    };
    
    public static String [] readRow(BufferedReader b) throws Exception
    {
        String [] ret = new String[23];
        int i = 0;
        while(true) {
            
            String g = b.readLine();
            if(g==null) return null;
            g=g.trim();
            //System.out.println("##"+g+"##");
            if(g.startsWith("<TR")) break;
            if(!g.startsWith("<TD")) continue;            
            
            int j = g.indexOf(">");
            int jj = g.indexOf("</TD",j);
            
            String ss = g.substring(j+1,jj);
            ss=ss.trim();
            if(ss.equals("&nbsp;")) ss="";
            ret[i++] = ss;
            
            int z = g.indexOf("colSpan");
            if(z>=0) {
                int h = g.indexOf("=",z);
                int hh = g.indexOf(">",h);
                String a = g.substring(h+1,hh);
                a=a.trim();
                int nr = Integer.parseInt(a);
                for(int x=0;x<nr-1;++x){
                    ret[i++] = ss;
                }
            }            
            
        }    
        
        String [] rett = new String[23];
        int ii = 0;
        int bb = 23-i;
        for(int x=0;x<bb;++x) {
            rett[ii++] = "";
        }
        for(int x=0;x<i;++x) {
            rett[ii++] = ret[x];
        }
        if(rett[1].equals("")) rett[1]=rett[0];
        return rett;
    }
    
    static String pushPullRegisters(int num, boolean push, boolean system)
    {
        char s = 'S';
        if(!system) s='U';
        String ret = "";
        if(push) {
            if((num&0x80) != 0) ret=ret+",PC";
            if((num&0x40) != 0) ret=ret+","+s;
            if((num&0x20) != 0) ret=ret+",Y";
            if((num&0x10) != 0) ret=ret+",X";
            if((num&0x08) != 0) ret=ret+",DP";
            if((num&0x04) != 0) ret=ret+",B";
            if((num&0x02) != 0) ret=ret+",A";
            if((num&0x01) != 0) ret=ret+",CC";
        } else {
            if((num&0x01) != 0) ret=ret+",CC";
            if((num&0x02) != 0) ret=ret+",A";
            if((num&0x04) != 0) ret=ret+",B";
            if((num&0x08) != 0) ret=ret+",DP";
            if((num&0x10) != 0) ret=ret+",X";
            if((num&0x20) != 0) ret=ret+",Y";
            if((num&0x40) != 0) ret=ret+","+s;            
            if((num&0x80) != 0) ret=ret+",PC";
        }
        return ret.substring(1);
    }
    
    public static void makeInstructions(String [] g, List master)
    {
        
        // TOPHER ... adjust the number of cycles
        
        Instruction i = new Instruction(g,0);
        
        if(i.mnemonic.equals("PSHS") || i.mnemonic.equals("PSHU") ||
           i.mnemonic.equals("PULS") || i.mnemonic.equals("PULU")) {
               boolean push = true;
               boolean system = true;
               if(i.mnemonic.charAt(1)=='U') push=false;
               if(i.mnemonic.charAt(3)=='U') system=false;
               for(int x=1;x<256;++x) {
                   Instruction j = new Instruction(g,0);
                   j.mnemonic = j.mnemonic+" "+pushPullRegisters(x,push,system);
                   j.opCode = new int[2];
                   j.opCode[0] = i.opCode[0];
                   j.opCode[1] = x;
                   String o = Integer.toString(x,16).toUpperCase();
                   if(o.length()<2) o="0"+o;
                   j.opCodeAssem = j.opCodeAssem+" "+o;
                   //System.out.println(":"+j.mnemonic+":"+j.opCodeAssem+":");
                   master.add(j); 
                   // TOPHER ... adjust the number of cycles
               }
        }
        
        if(i.mnemonic.equals("EXG") || i.mnemonic.equals("TFR")) {
            for(int x=0;x<exgTfrRegisters.length/2;++x) {
                Instruction j = new Instruction(g,0);
                j.mnemonic = j.mnemonic+" "+exgTfrRegisters[x*2];
                j.opCode = new int[2];
                j.opCode[0] = i.opCode[0];
                j.opCode[1] = Integer.parseInt(exgTfrRegisters[x*2+1],16);
                j.opCodeAssem = j.opCodeAssem + " "+exgTfrRegisters[x*2+1];
                master.add(j);
            }
            return;
        }
        
        if(i.opCode.length>0) { 
            int brem = Integer.parseInt(i.numBytes)-i.opCode.length;
            if(brem==1) {
                i.mnemonic = i.mnemonic+" #%BYTE%";
                i.opCodeAssem = i.opCodeAssem+" .1";
            } else if(brem==2) {
                i.mnemonic = i.mnemonic+" #%WORD%";
                i.opCodeAssem = i.opCodeAssem+" ...1";
            } else {
                throw new RuntimeException("OOPS");
            }                        
            master.add(i);
        }
        
        i = new Instruction(g,1);
        if(i.opCode.length>0) { 
            int brem = Integer.parseInt(i.numBytes)-i.opCode.length;
            if(brem==1) {
                i.mnemonic = i.mnemonic+" >%MEMORY%";
                i.opCodeAssem = i.opCodeAssem+" .1";
            } else {
                throw new RuntimeException("OOPS");
            } 
            master.add(i);
        }
        
        i = new Instruction(g,3);
        if(i.opCode.length>0) { 
            int brem = Integer.parseInt(i.numBytes)-i.opCode.length;
            if(brem==2) {
                i.mnemonic = i.mnemonic+" %WORD%";
                i.opCodeAssem = i.opCodeAssem+" ...1";
            } else {
                throw new RuntimeException("OOPS");
            }                        
            master.add(i);            
        }
        
        i = new Instruction(g,4);
        if(i.opCode.length>0) { 
            int brem = Integer.parseInt(i.numBytes)-i.opCode.length;
            if(brem!=0) {
                throw new RuntimeException("OOPS");
            }                             
            master.add(i);
        }
        
        
        // Now for the killer!
        
        i = new Instruction(g,2);
        if(i.opCode.length>0) { 
            for(int x=0;x<postByteInfo.length/2;++x) {
                Instruction j = new Instruction(g,2);
                String pi = postByteInfo[x*2];
                int oc = Integer.parseInt(postByteInfo[x*2+1],16);
                String ac = j.numBytes;
                if(ac.endsWith("+")) ac=ac.substring(0,ac.length()-1);
                int nnc = Integer.parseInt(ac);
                
                String aa = null;                
                if(pi.indexOf("bbbb")>=0) {
                    int zz = pi.indexOf("bbbb");
                    pi = pi.substring(0,zz)+"%WORD%"+pi.substring(zz+4);
                    nnc+=2;
                    aa = "...1";
                } else if(pi.indexOf("bb")>=0) {
                    int zz = pi.indexOf("bb");
                    pi = pi.substring(0,zz)+"%BYTE%"+pi.substring(zz+2);
                    nnc+=1;
                    aa = ".1";
                }
                j.numBytes = ""+nnc;
                j.mnemonic = j.mnemonic+" "+pi;
                j.opCode = new int[i.opCode.length+1];
                for(int y=0;y<i.opCode.length;++y) {
                    j.opCode[y] = i.opCode[y];
                }
                j.opCode[i.opCode.length] = oc;
                String gg = Integer.toString(oc,16);
                if(gg.length()<2) gg="0"+gg;                
                if(aa!=null) gg=gg+" "+aa;        
                j.opCodeAssem = j.opCodeAssem+" "+gg;                 
                master.add(j);
                
            }
            
        }
        
    }
    
    static String [] postBytes = {
        "0,X", "1,X", "2,X", "3,X", "4,X", "5,X", "6,X", "7,X", "8,X", "9,X", "10,X", "11,X", "12,X", "13,X", "14,X", "15,X", 
        "-16,X", "-15,X", "-14,X", "-13,X", "-12,X", "-11,X", "-10,X", "-9,X", "-8,X", "-7,X", "-6,X", "-5,X", "-4,X", "-3,X", "-2,X", "-1,X",
        
        "0,Y", "1,Y", "2,Y", "3,Y", "4,Y", "5,Y", "6,Y", "7,Y", "8,Y", "9,Y", "10,Y", "11,Y", "12,Y", "13,Y", "14,Y", "15,Y", 
        "-16,Y", "-15,Y", "-14,Y", "-13,Y", "-12,Y", "-11,Y", "-10,Y", "-9,Y", "-8,Y", "-7,Y", "-6,Y", "-5,Y", "-4,Y", "-3,Y", "-2,Y", "-1,Y",
        
        "0,U", "1,U", "2,U", "3,U", "4,U", "5,U", "6,U", "7,U", "8,U", "9,U", "10,U", "11,U", "12,U", "13,U", "14,U", "15,U", 
        "-16,U", "-15,U", "-14,U", "-13,U", "-12,U", "-11,U", "-10,U", "-9,U", "-8,U", "-7,U", "-6,U", "-5,U", "-4,U", "-3,U", "-2,U", "-1,U",
        
        "0,S", "1,S", "2,S", "3,S", "4,S", "5,S", "6,S", "7,S", "8,S", "9,S", "10,S", "11,S", "12,S", "13,S", "14,S", "15,S", 
        "-16,S", "-15,S", "-14,S", "-13,S", "-12,S", "-11,S", "-10,S", "-9,S", "-8,S", "-7,S", "-6,S", "-5,S", "-4,S", "-3,S", "-2,S", "-1,S",
        
        ",X+","X++","-X","--X",",X","B,X","A,X","bb,X","bbbb,X","D,X","bb,PC","bbbb,PC","[,X++]","[,--X]","[,X]","[B,X]","[A,X]","[bb,X]","[bbbb,X]","[D,X]","[bb,PC]","[bbbb,PC]","[bbbb]",
        
        ",Y+","Y++","-Y","--Y",",Y","B,Y","A,Y","bb,Y","bbbb,Y","D,Y","bb,PC","bbbb,PC","[,Y++]","[,--Y]","[,Y]","[B,Y]","[A,Y]","[bb,Y]","[bbbb,Y]","[D,Y]","[bb,PC]","[bbbb,PC]","[bbbb]",
        
        ",U+","U++","-U","--U",",U","B,U","A,U","bb,U","bbbb,U","D,U","bb,PC","bbbb,PC","[,U++]","[,--U]","[,U]","[B,U]","[A,U]","[bb,U]","[bbbb,U]","[D,U]","[bb,PC]","[bbbb,PC]","[bbbb]",
        
        ",S+","S++","-S","--S",",S","B,S","A,S","bb,S","bbbb,S","D,S","bb,PC","bbbb,PC","[,S++]","[,--S]","[,S]","[B,S]","[A,S]","[bb,S]","[bbbb,S]","[D,S]","[bb,PC]","[bbbb,PC]","[bbbb]"
    };
    
    static int [] postByteOpsMissing = {
        0x87,0x8A,0x8E,0x8F,0x90,0x92,0x97,0x9A,0x9E,
        0xA7,0xAA,0xAE,0xAF,0xB0,0xB2,0xB7,0xBA,0xBE,
        0xC7,0xCA,0xCE,0xCF,0xD0,0xD2,0xD7,0xDA,0xDE,        
        0xE7,0xEA,0xEE,0xEF,0xF0,0xF2,0xF7,0xFA,0xFE
    };
    
    public static void main(String [] args) throws Exception
    { 
       
        Reader r = new FileReader("6809.txt");
        BufferedReader br=new BufferedReader(r);
        
        List master = new ArrayList();
        
        while(true) {
            String [] g = readRow(br);
            if(g==null) break;                 
            makeInstructions(g,master);            
        } 
        
        for(int x=0;x<master.size();++x) {
            Instruction i = (Instruction)master.get(x);
            i.toXML(System.out);
            //System.out.println(i.mnemonic+":"+i.opCodeAssem+":"+i.numBytes);
            //System.out.println(":"+i.numBytes);
        }
        
    }
    
}