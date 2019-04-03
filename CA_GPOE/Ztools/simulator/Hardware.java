package simulator;

import org.w3c.dom.*;

public interface Hardware 
{
    
    public void loadXML(CPU cpu, Node n);
    
    public String getFrameTitle();
    
    public void reset();
    
    public boolean isMemoryMapped();
    
    public boolean isMe(int address);
     
    public int getValue(int address, boolean internalAccess);
    
    public void setValue(int address, int value, boolean internalAccess);
    
   
    
}

