package ramloader; 

import java.io.*;

public class ADBus
{    
    
    static BS2ConnectionDriver cd;
    
    public static void main(String [] args) throws Exception
    {      
        
        cd = new BS2ConnectionDriverSerial();        
        cd.setDelay(0);
        
        
        poke(0x420,0);
        poke(0x420,255);
        
        
        for(int x=0;x<4;++x) {
            int i = peek(0x400+x);
            System.out.println(":"+i+":");            
        } 
        
    }
    
    public static void init() throws Exception
    {
        cd = new BS2ConnectionDriverSerial(); 
    }
    
    public static int peek(int address) throws IOException
    {
        cd.sendByte(2);
        cd.sendWord(address);
        return cd.readByte();
    }
    
    public static void poke(int address, int value) throws IOException
    {
        cd.sendByte(1);
        cd.sendWord(address);
        cd.sendByte(value);
    }
    
    public static void writeRegister(int register, int value) throws IOException
    {
        cd.sendByte(3);
        cd.sendByte(register);
        cd.sendWord(value);
    }
    
    public static int readRegister(int register) throws IOException
    {
        cd.sendByte(4);
        cd.sendByte(register);
        int i = cd.readByte()<<8 | cd.readByte();
        return i;
    }
    
    public static void pushBuffer(int location) throws IOException
    {
        cd.sendByte(6);
        cd.sendWord(location);
    }
    
    public static void pullBuffer(int location) throws IOException
    {
        cd.sendByte(5);
        cd.sendWord(location);
    }
    
    public static void waitForReady() throws IOException
    {
        cd.sendByte(7);
        cd.readByte();
    }
    
    public static void prepAccess(int drive, long sector) throws IOException
    {
        cd.sendByte(8);
        cd.sendByte(drive);
        cd.sendWord((int)((sector>>16)&0xFFFF));
        cd.sendWord((int)(sector&0xFFFF));
    }
    
    public static void readSector(int drive, long sector, int destination) throws IOException
    {
        cd.sendByte(9);
        cd.sendByte(drive);
        cd.sendWord((int)((sector>>16)&0xFFFF));
        cd.sendWord((int)(sector&0xFFFF));
        cd.sendWord(destination);
    }
    
    public static void writeSector(int drive, long sector, int destination) throws IOException
    {
        cd.sendByte(10);
        cd.sendByte(drive);
        cd.sendWord((int)((sector>>16)&0xFFFF));
        cd.sendWord((int)(sector&0xFFFF));
        cd.sendWord(destination);
    }
    
    public static void driveInfo(int drive, int destination) throws IOException
    {
        cd.sendByte(11);
        cd.sendByte(drive);        
        cd.sendWord(destination);
    }
    
}
