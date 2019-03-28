package ramloader; 

import java.io.*;

public class ATA
{

    // Status bit
    
// 7 BSY (busy)                    make sure the device is not busy (==0)
// 6 DRDY (device ready)           make sure the device is ready (==1)
// 5 DF (Device Fault)
// 4 DSC (seek complete)
// 3 DRQ (Data Transfer Requested)
// 2 CORR (data corrected)
// 1 IDX (index mark)
// 0 ERR (error)
    
    // DRDY  .... SEEMS .... to be high when ready for a new command, but when
    // command starts loading it goes low until all the command is set and
    // finished.
    
  public static final int ATA_REG_DATA = 0;
  public static final int ATA_ERROR_FEATURE_REGISTER = 1;
  public static final int ATA_REG_SECTORCOUNT = 2;
  public static final int ATA_REG_SECTORNUM = 3;
  public static final int ATA_REG_CYLINDERLOW = 4;
  public static final int ATA_REG_CYLINDERHIGH = 5;
  public static final int ATA_REG_DRIVEHEAD = 6;
  public static final int ATA_REG_STATUS_COMMAND = 7;
  
  
    public static void manual(String [] args) throws Exception
    {
        int reg = Integer.parseInt(args[0]);
        int value = Integer.parseInt(args[1],16);
        if(reg>0) {
            write(reg,value);
        }
        for(int x=0;x<8;++x) {
            read(x);            
        }        
    }
    
    public static void write(int register,int value) throws IOException
    {
        System.out.println(":WRITE:"+register+":"+Integer.toString(value,16));
        ADBus.writeRegister(register,value);
    }
    
    public static int read(int register) throws IOException
    {
        int ret = ADBus.readRegister(register);
        System.out.println(":READ:"+register+":"+Integer.toString(ret,16));
        return ret;
    }
  
    
    public static void main(String [] args) throws Exception
    {
        ADBus.init();
        
        //int i = read(7);
        
        //ADBus.prepAccess(0,0);
        //write(7,0x20);
        //ADBus.pullBuffer(1024+32*4);
        
        read(7);
        
        ADBus.readSector(0,10,1024+32*4);
        
        //ADBus.writeSector(0,10,1024+32*4);
        
        //ADBus.driveInfo(0,1024+32*4);
        
        
        //for(int x=0;x<8;++x) {
        //    read(x);            
        //} 
        
        
        //manual(args);
        //System.exit(0);
        
        //int i = read(7);
        //System.out.println("STATUS:"+Integer.toString(i,16));
        
        //identifyDrive(0);
    }
    
    public static byte [] identifyDrive(int drive) throws IOException
    {        
        write(ATA_REG_DRIVEHEAD,      drive<<4  );
        write(ATA_REG_STATUS_COMMAND, 0xEC      );
        ADBus.pullBuffer(0x400+32*4);
        //for(int x=0;x<256;++x) {
        //    read(ATA_REG_DATA);
        //}        
        return null;
    }
          
    /*
    //                                                              RWmC -AAA
    public static final int IDECONTROL_ADDR_MASK =         0x00; // 0000 0000
    public static final int IDECONTROL_ADDR_CS_MASK =      0x10; // 0001 0000
    public static final int IDECONTROL_ADDR_CS_WR_MASK =   0x50; // 0101 0000
    public static final int IDECONTROL_ADDR_CS_RD_MASK =   0x90; // 1001 0000
    
    public static byte [] readSector(int drive, long sector) throws IOException
    {
        
        int a = (0x0E | (drive&1))<<4;
        ataRegisterWrite8(ATA_REG_SECTORCOUNT, 1);
        ataRegisterWrite8(ATA_REG_SECTORNUM,   (int)(sector&0xFF));
        ataRegisterWrite8(ATA_REG_CYLINDERLOW, (int)((sector>>8)&0xFF));
        ataRegisterWrite8(ATA_REG_CYLINDERHIGH,(int)((sector>>16)&0xFF));  
        ataRegisterWrite8(ATA_REG_DRIVEHEAD,   (int)(((sector>>24)&0x0F)|a));
        
        ataRegisterWrite8(ATA_REG_STATUS_COMMAND,0x20);
        
        for(int x=0;x<256;++x) {
            ataRegisterRead16(ATA_REG_DATA);
        }
        
        return null;
        
    }
    
    public static void ataRegisterWrite8(int register, int value) throws IOException 
    {
        // ; Set 16-bit data bus as output
        // ; Data bus LSB = B
        // ; CONTROL = IDECONTROL_ADDR_CS_MASK    | address (ADDR + CS0)
        // ; CONTROL = IDECONTROL_ADDR_CS_WR_MASK | address (ADDR + CS0 + WR)
        // ; CONTROL = IDECONTROL_ADDR_CS_MASK    | address (ADDR + CS0)
        // ; CONTROL = IDECONTROL_ADDR_MASK       | address (ADDR)
        // ; Set 16-bit data bus as input
        
        System.out.println("    :WRITE:"+register+":"+Integer.toString(value,16));
        
        System.out.print("S");
        setDatabusDirection(255);
        System.out.print("s");
                
        ADBus.poke(0xFF42,value);
        System.out.print(".");
                
        int control;        
        control = IDECONTROL_ADDR_CS_MASK    | register; ADBus.poke(0xFF46,control);
        System.out.print(".");
        control = IDECONTROL_ADDR_CS_WR_MASK | register; ADBus.poke(0xFF46,control);
        System.out.print(".");
        control = IDECONTROL_ADDR_CS_MASK    | register; ADBus.poke(0xFF46,control);
        System.out.print(".");
        control = IDECONTROL_ADDR_MASK       | register; ADBus.poke(0xFF46,control);        
        System.out.print(".");
        
        System.out.print("S");
        setDatabusDirection(0);
        System.out.println("s");
        
    }
    
    public static void ataRegisterWrite16(int register, int value) throws IOException 
    {
        // ; Set 16-bit data bus as output
        // ; Data bus LSB = B
        // ; Data bus MSB = A
        // ; CONTROL = IDECONTROL_ADDR_CS_MASK    | address (ADDR + CS0)
        // ; CONTROL = IDECONTROL_ADDR_CS_WR_MASK | address (ADDR + CS0 + WR)
        // ; CONTROL = IDECONTROL_ADDR_CS_MASK    | address (ADDR + CS0)
        // ; CONTROL = IDECONTROL_ADDR_MASK       | address (ADDR)
        // ; Set 16-bit data bus as input
        
        System.out.println("    :WRITE16:"+register+":"+Integer.toString(value,16));
        
        System.out.print("S");
        setDatabusDirection(255);
        System.out.print("s");
                
        ADBus.poke(0xFF40,(value>>8)&0xFF);
        ADBus.poke(0xFF42,value&0xFF);
        System.out.print(".");
                
        int control;        
        control = IDECONTROL_ADDR_CS_MASK    | register; ADBus.poke(0xFF46,control);
        System.out.print(".");
        control = IDECONTROL_ADDR_CS_WR_MASK | register; ADBus.poke(0xFF46,control);
        System.out.print(".");
        control = IDECONTROL_ADDR_CS_MASK    | register; ADBus.poke(0xFF46,control);
        System.out.print(".");
        control = IDECONTROL_ADDR_MASK       | register; ADBus.poke(0xFF46,control);        
        System.out.print(".");
        
        System.out.print("S");
        setDatabusDirection(0);
        System.out.println("s");
        
    }
    
    public static int ataRegisterRead8(int register) throws IOException
    {
        // ; CONTROL = IDECONTROL_ADDR_CS_MASK    | address (ADDR + CS0)
        // ; CONTROL = IDECONTROL_ADDR_CS_RD_MASK | address (ADDR + CS0 + RD)
        // ; B = Data bus LSB
        // ; CONTROL = IDECONTROL_ADDR_MASK       | address (ADDR)
        
        int control;        
        control = IDECONTROL_ADDR_CS_MASK    | register; ADBus.poke(0xFF46,control);
        control = IDECONTROL_ADDR_CS_RD_MASK | register; ADBus.poke(0xFF46,control);
        int ret = ADBus.peek(0xFF42);
        control = IDECONTROL_ADDR_MASK       | register; ADBus.poke(0xFF46,control); 
        
        System.out.println("     :READ8:"+register+":"+Integer.toString(ret,16));
        return ret;

    }
    
    public static int ataRegisterRead16(int register) throws IOException
    {
        // ; CONTROL = IDECONTROL_ADDR_CS_MASK    | address (ADDR + CS0)
        // ; CONTROL = IDECONTROL_ADDR_CS_RD_MASK | address (ADDR + CS0 + RD)
        // ; B = Data bus LSB
        // ; CONTROL = IDECONTROL_ADDR_MASK       | address (ADDR)
        
        int control;        
        control = IDECONTROL_ADDR_CS_MASK     | register; ADBus.poke(0xFF46,control);
        control = IDECONTROL_ADDR_CS_RD_MASK  | register; ADBus.poke(0xFF46,control);
        int ret = ADBus.peek(0xFF40)<<8 | ADBus.peek(0xFF42);
        control = IDECONTROL_ADDR_MASK        | register; ADBus.poke(0xFF46,control); 
        
        System.out.println("     :READ16:"+register+":"+Integer.toString(ret,16));
        return ret;

    }
    
    public static void setDatabusDirection(int value) throws IOException
    {
        int i = ADBus.peek(0xFF41);
        System.out.print(".");
        int j = i & 0xFF-4;
        ADBus.poke(0xFF41,j);
        System.out.print(".");
        ADBus.poke(0xFF40,value);
        System.out.print(".");
        ADBus.poke(0xFF41,i);
        System.out.print(".");
        
        i = ADBus.peek(0xFF43);
        System.out.print(".");
        j = i & 0xFF-4;
        ADBus.poke(0xFF43,j);
        System.out.print(".");
        ADBus.poke(0xFF42,value);
        System.out.print(".");
        ADBus.poke(0xFF43,i);
        System.out.print(".");
        
    }
     */
    
}
