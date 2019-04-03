
import java.io.*;

public class HeaderChunk
{
    public int format;
    public int deltaTime;
    public int numberOfTracks;
    
    public int decode(byte [] buf, int offs) throws Exception
    {
        if(buf[offs]!='M' || buf[offs+1]!='T' || 
           buf[offs+2]!='h' || buf[offs+3]!='d') {
               throw new Exception("No MThd tag");
        }
        int len = (int)MIDIFile.read4ByteValue(buf,4);
        if(len!=6) {
            throw new Exception("Header chunk must be 6 bytes long");
        }
        format = MIDIFile.read2ByteValue(buf,8);
        numberOfTracks = MIDIFile.read2ByteValue(buf,10);
        deltaTime = MIDIFile.read2ByteValue(buf,12);
        return offs+14;
    }
    
    public void toXML(OutputStream os) throws IOException
    {
        PrintStream ps = new PrintStream(os);
        ps.print("  <Header format=\""+format+"\" deltaTime=\""+deltaTime+"\" numTracks=\""+numberOfTracks+"\"/>\r\n");
        
    }
    
}