package ramloader; 

import java.io.*;

public class RAMRun
{    
    
    public static void main(String [] args) throws Exception
    {
        int delay = 0;
        if(args.length>2) {
            delay = Integer.parseInt(args[2]);
        }
        
        InputStream is = new FileInputStream(args[0]);
        byte [] b = new byte[is.available()];
        is.read(b);
        is.close();
        
        int dest = Integer.parseInt(args[1],16);
        
        System.out.println("Downloading 0x"+Integer.toString(b.length,16)+" bytes to "+Integer.toString(dest,16));
        
        BS2ConnectionDriver cd = new BS2ConnectionDriverSerial();
        cd.setDelay(delay);
        cd.sendWord(dest);
        cd.sendWord(b.length);        
        
        for(int x=0;x<b.length;++x) {
            cd.sendByte(b[x]);
            System.out.print(".");
        }
        System.out.println();
        System.out.println("Code is now running");
        
    }
    
}

