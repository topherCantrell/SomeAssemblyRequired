package ramloader; 

import java.io.*;

public abstract class BS2ConnectionDriver
{
    
    public abstract boolean checkStatus() throws IOException;
    public abstract void setDelay(int value) throws IOException;
    public abstract void sendByte(int value) throws IOException;
    public abstract int readByte() throws IOException;
    
    public void sendWord(int value) throws IOException
    {
        int msb = (value>>8)&0xFF;
        int lsb = value&0xFF;
        sendByte(msb);
        sendByte(lsb);
    }
    
    public void sendBytes(byte [] data, int start, int length) throws IOException
    {
        for(int x=0;x<length;++x) {
            sendByte(data[start+x]);
        }
    }
    
    public void sendBytes(byte [] data) throws IOException
    {
        sendBytes(data,0,data.length);
    }
    
}
