import java.io.*;

public class Event
{
    int eventType; // 0 (Channel), FF (Meta), F0 (System Exclusive)
    
    long time;
    
    int channel;
    int type;    
    
    byte [] data;
    boolean dataIsText;
    
    boolean shortForm; // True if loaded from a short-form (running-mode) notation
    
    static String [] CHANNELEVENTNAMES = {
        "NoteOff","NoteOn","NoteAftertouch","Controller",
        "ProgramChange","ChannelAftertouch","PitchBlend"
    };
    
    public void toXML(OutputStream os) throws IOException
    {
        PrintStream ps = new PrintStream(os);        
        if(eventType==0) {
            String ttype = CHANNELEVENTNAMES[type-8];
            ps.print("    <ChannelEvent time=\""+time+"\" channel=\""+channel+"\" type=\""+ttype+"\"");
            if(shortForm)ps.print(" shortform=\"true\"");
            for(int x=0;x<data.length;++x) {
                ps.print(" p"+x+"=\""+data[x]+"\"");
            }
            ps.print("/>\r\n");
        } else if(eventType==0xFF) {
            ps.print("    <MetaEvent time=\""+time+"\" type=\""+type+ "\" length=\""+data.length+"\"");            
            if(data.length>0) {
                ps.print(">\r\n");
                if(dataIsText) {
                    ps.print("      <Text>"+new String(data)+"</Text>\r\n");
                } else {
                    ps.print("      <Data>");
                    for(int x=0;x<data.length;++x) {
                        if(x!=0) ps.print(" ");
                        ps.print(Integer.toString(MIDIFile.byteToInt(data[x]),16));
                    }
                    ps.print("</Data>\r\n");
                }
                ps.print("    </MetaEvent>\r\n"); 
            } else {
                ps.print("/>\r\n");
            }
                       
        } else if(eventType==0xF0) {
            throw new RuntimeException("NOT IMPLEMENTED"); 
        } else {
            throw new RuntimeException("UNKNOWN EVENT TYPE: "+eventType);
        }
    }
    
    public String toString()
    {
        String ret = "";
        
        if(eventType==0xFF) {
               ret += "META-EVENT";
        } else if(eventType==0xF0) {
               ret += "SYSX-EVENT";
        } else {
               ret += "CHAN-EVENT";
        }
        ret += " Channel="+channel+" type="+type+" length="+data.length;
        for(int x=0;x<data.length;++x) {
            ret += " "+Integer.toString(MIDIFile.byteToInt(data[x]),16);
        }
        return ret;
    }
}

