import java.io.*;
import java.util.*;

// TO DO:

// The binary->structure part appears to work, though there is no system-exclusive
// storage yet. 

// Add the XML->structure part.

// Build the editor for <ChannelEvents> to use in place of raw midi events.

public class MIDIFile
{
    
    public HeaderChunk header;
    public TrackChunk [] tracks;
        
    public void decode(byte [] buf, int offs) throws Exception
    {        
        header = new HeaderChunk();
        offs = header.decode(buf,offs);
        List a = new ArrayList();
        while(offs!=buf.length) {
            //System.out.println("-- NEW TRACK --");
            TrackChunk t = new TrackChunk();
            offs = t.decode(buf,offs);
            a.add(t);
        }
        if(a.size()!=header.numberOfTracks) {
            throw new RuntimeException("Header says "+header.numberOfTracks+
                " tracks but there are "+a.size());
        }
        tracks = new TrackChunk[a.size()];
        for(int x=0;x<tracks.length;++x) {
            tracks[x] = (TrackChunk)a.get(x);
        }     
        if(tracks.length!=header.numberOfTracks) {
            throw new RuntimeException("Actual number of tracks doesn' match the header");
        }
    }    
    
    public void toXML(OutputStream os) throws IOException
    {
        PrintStream ps = new PrintStream(os);
        ps.print("<MIDIFile>\r\n");
        header.toXML(os);
        for(int x=0;x<tracks.length;++x) {
            tracks[x].toXML(os);
        }
        ps.print("</MIDIFile>\r\n");
    }
   
    
    public static int numberBytesInVariable(byte [] buf, int offs)
    {
        int nb = 0;        
        while(byteToInt(buf[offs])>0x7F) {
            ++nb;
            ++offs;
        }        
        return nb+1;
    }
    
    public static long readVariableBytes(byte [] buf, int offs)
    {
        long val = 0;        
        while(byteToInt(buf[offs])>0x7F) {
            val = val | (byteToInt(buf[offs])&0x7F);
            val = val << 7;
            ++offs;
        }
        val = val | buf[offs];
        return val;
    }
    
    public static int byteToInt(byte b)
    {
        int ret = b;
        if(ret<0) ret=ret+256;
        return ret;
    }
    
    public static long read4ByteValue(byte [] buf, int offs)
    {
        long a = buf[offs];   if(a<0) a=a+256;
        long b = buf[offs+1]; if(b<0) b=b+256;
        long c = buf[offs+2]; if(c<0) c=c+256;
        long d = buf[offs+3]; if(d<0) d=d+256;
        return a<<(8*3) | b<<(8*2) | c<<(8) | d;
    }
    
    public static int read2ByteValue(byte [] buf, int offs)
    {
        int a = buf[offs];   if(a<0) a=a+256;
        int b = buf[offs+1]; if(b<0) b=b+256;        
        return a<<(8) | b;
    }
    
    public static void main(String [] args) throws Exception
    {
        InputStream is = new FileInputStream(args[0]);
        byte [] buf = new byte[is.available()];
        is.read(buf);
        is.close();        
        
        MIDIFile f = new MIDIFile();        
        f.decode(buf,0);
        
        f.toXML(System.out); 
        
    }
    
}