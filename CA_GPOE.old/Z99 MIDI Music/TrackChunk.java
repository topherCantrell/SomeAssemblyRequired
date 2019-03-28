
import java.util.*;
import java.io.*;

public class TrackChunk
{
    
    long length;
    List events = new ArrayList(); 
    
    Event lastChannelEvent;
    
    public boolean isText(byte [] data)
    {
        if(data.length==0) return false;
        for(int x=0;x<data.length;++x) {
            if(data[x]<' ') return false;
            if(data[x]>127) return false;            
        }
        return true;
    }
    
    public long decodeChannelEvent(long tv, byte [] buf, int offs) throws Exception
    {
        Event e = new Event();  
        e.time = tv;
        
        long ret = 0;               
        
        int i = MIDIFile.byteToInt(buf[offs]);          
        
        e.channel = i%16;
        e.type = i/16;        
        
        int rd = 2;        
        
        if(e.type<8 ) {
            e.shortForm = true;
            e.channel = lastChannelEvent.channel;
            e.type = lastChannelEvent.type;
            rd = lastChannelEvent.data.length;            
        } else {                        
            if(e.type==0x0C || e.type==0x0D) {
                rd = 1;                
            }
            ++offs;
            ++ret;
            lastChannelEvent = e;                       
        }
        
        e.data = new byte[rd];
        for(int x=0;x<rd;++x) {
            e.data[x] = buf[offs+x];
        }        
        
        events.add(e);
                
        //e.toXML(System.out);
        
        return ret+rd;
        
    }
    
    public long decodeSystemExclusiveEvent(long tv, byte [] buf, int offs) throws Exception
    {
        throw new RuntimeException("NOT IMPLMEMENTED");
    }
    
    public long decodeMetaEvent(long tv, byte [] buf, int offs) throws Exception
    {
        
        Event e = new Event();  
        e.time = tv;
        
        e.eventType = 0xFF;
        e.type = MIDIFile.byteToInt(buf[offs+1]);            
        
        int nb = MIDIFile.numberBytesInVariable(buf,offs+2);
        int length = (int)MIDIFile.readVariableBytes(buf,offs+2);
        e.data = new byte[length];
        for(int x=0;x<length;++x) {
            e.data[x] = buf[offs+2+nb+x];
        }
        e.dataIsText = isText(e.data);
        
        events.add(e);
        
        //System.out.println(e);        
        
        return 2 + nb + length;
    }
    
    public int decode(byte [] buf, int offs) throws Exception
    {
        
        if(buf[offs]!='M' || buf[offs+1]!='T' || 
           buf[offs+2]!='r' || buf[offs+3]!='k') {
               throw new Exception("No MTrk tag");
        }
        
        length = MIDIFile.read4ByteValue(buf,offs+4);
        offs = offs + 8;    
        
        long lastStop = offs+length;
        while(offs!=lastStop) {
            
            //System.out.println(Integer.toString(offs,16));
            
            // Get the variable time
            long tv = MIDIFile.readVariableBytes(buf,offs);
            offs += MIDIFile.numberBytesInVariable(buf,offs);
            
            int ev = MIDIFile.byteToInt(buf[offs]);    
            
            long i = 0;
            if(ev<0xF0) {
                i = decodeChannelEvent(tv,buf,offs);
            } else if(ev==0xF0) {
                i = decodeSystemExclusiveEvent(tv,buf,offs);
            } else if(ev==0xFF) {
                i = decodeMetaEvent(tv,buf,offs);
            } else {
                throw new RuntimeException("Unknown type of event: "+Integer.toString(ev,16));
            }
            offs+=i;
            
            if(offs>lastStop) {
                throw new RuntimeException("Track data didn't end on track boundary");
            }
           
        }        
        
        return offs;
        
    }
    
    public void toXML(OutputStream os) throws IOException
    {
        PrintStream ps = new PrintStream(os);
        ps.print("  <Track>\r\n");        
        for(int x=0;x<events.size();++x) {
            Event e = (Event)events.get(x);
            e.toXML(os);
        }
        ps.print("  </Track>\r\n"); 
    }
}
