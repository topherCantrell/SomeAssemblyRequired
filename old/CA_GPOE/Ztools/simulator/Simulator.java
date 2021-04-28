package simulator;

import org.w3c.dom.*;

public interface Simulator
{
    
    public void loadXML(CPU cpu,Node n);
    
    public String step();

    public void reset();
    
    public void interrupt(String level, Object source);
    
    public int getRegisterSize(String name);
    public int getRegisterValue(String name);
    public void setRegisterValue(String name, int value);
    
    public void hardwareBreakPointHit(int address, boolean write);    
    
}
