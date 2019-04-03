package ramloader; 

import java.io.*;
import javax.comm.*;

public class BS2ConnectionDriverSerial extends BS2ConnectionDriver
{
    
    InputStream is;
    OutputStream os;
    
    public BS2ConnectionDriverSerial() throws Exception
    {
        CommPortIdentifier cpi = CommPortIdentifier.getPortIdentifier("COM1");
        SerialPort p = (SerialPort)cpi.open("ADBus",2000);        
        p.setSerialPortParams(9600,8,1,SerialPort.PARITY_NONE);        
        is = p.getInputStream();
        os = p.getOutputStream();    
    }

    public boolean checkStatus() throws IOException
    {
        throw new RuntimeException("Not Implemented");
    }
    
    public void setDelay(int value) throws IOException
    {
        os.write('B');        
        int j = is.read();
        if(j!='B') {            
            throw new IOException("Echo mismatch");
        }
        int v = (value>>8)&0xFF;
        os.write(v);        
        j = is.read();
        if(j!=v) {            
            throw new IOException("Echo mismatch");
        }
        v = value&0xFF;
        os.write(v);        
        j = is.read();
        if(j!=v) {            
            throw new IOException("Echo mismatch");
        }
        j = is.read();
        if(j!=33) {
            throw new IOException("Expected OK !:"+j);
        }
    }
    
    public void sendByte(int value) throws IOException
    {   
        //System.out.println(":>:"+Integer.toString(value,16));
        if(value<0) value=value+256;
        os.write('C');        
        int j = is.read();
        if(j!='C') {            
            throw new IOException("Echo mismatch");
        }
        os.write(value);
        j = is.read();        
        if(j!=value) {          
            System.out.println("::"+value+"::"+j);
            throw new IOException("Echo mismatch");
        }        
        j = is.read();
        if(j!=33) {
            throw new IOException("Expected OK !:"+j);
        }
    }
    
    public int readByte() throws IOException
    {       
        os.write('D');        
        int j = is.read();
        if(j!='D') {            
            throw new IOException("Echo mismatch");
        }        
        int ret = is.read();              
        j = is.read();
        if(j!=33) {
            throw new IOException("Expected OK !:"+j);
        }
        return ret;
    }

}