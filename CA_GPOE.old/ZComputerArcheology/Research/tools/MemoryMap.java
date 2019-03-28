
import java.io.*;
import java.util.*;

public class MemoryMap {

    class Chip {
       String name;
       int startAddress; 
       int length;
       byte [] data;
    }

    Vector chips;
    int firstAddress = 0;
    int lastAddress = 0;

    public MemoryMap(String mapFile) {
        chips = new Vector();
        try {
            int nextStartAddress = 0;
            FileReader fr = new FileReader(mapFile);
            LineNumberReader lnr = new LineNumberReader(fr);
            while(true) {
                String g = lnr.readLine();
                if(g==null) break;
                if(g.length()<1) continue;
                if(g.charAt(0)!='+') continue;
                StringTokenizer st = new StringTokenizer(g.substring(1,g.length()));
                Chip c = new Chip();
                c.name = st.nextToken();
                if(st.hasMoreTokens()) {
                    c.startAddress = Integer.parseInt(st.nextToken());
                } else {
                    c.startAddress = nextStartAddress;
                }            
                try {
                    File fil = new File(c.name);
                    FileInputStream fis = new FileInputStream(fil);
                    DataInputStream dis = new DataInputStream(fis);
                    c.length = (int)(fil.length());
                    c.data = new byte[c.length];
                    int y = dis.read(c.data);
                    if(nextStartAddress<firstAddress) firstAddress=nextStartAddress;
                    nextStartAddress+=c.length;
                    if(nextStartAddress>lastAddress) lastAddress=nextStartAddress;
                    dis.close();
                    fis.close();
                } catch (IOException e) {
                    System.out.println("** Error with ROM file "+c.name+" "+e.getMessage()+" **");
                }
                chips.addElement(c);
            } 
        } catch (FileNotFoundException e) {
            System.out.println("** Could not find "+mapFile+" **");
        } catch (IOException e) {
            System.out.println("** IOException:"+e.getMessage());
        }
        
    }
    
    public int getFirstAddress() {
        return firstAddress;
    }
    
    public int getLastAddress() {
        return lastAddress-1;
    }
    
    public byte getByte(int address) {
        for(int x=0;x<chips.size();++x) {
            Chip c = (Chip)chips.elementAt(x);
            if(address>=c.startAddress && address<(c.startAddress+c.length)) {
                return c.data[address-c.startAddress];
            }
        }
        System.out.println("** Attempt to read address "+address+" not in MemoryMap");
        return -1;
    }
    
}