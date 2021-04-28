package simulator;

import org.w3c.dom.*;

import java.util.*;

public class CPU_Random implements Hardware
{
    
    int startAddress;
    Random rand;
    
    public int getValue(int address, boolean internalAccess) {
        int val = rand.nextInt(256);
        return val;
    }
    
    public void loadXML(CPU cpu, Node n) {
        NamedNodeMap att = n.getAttributes();
        Node attr = att.getNamedItem("address");
        startAddress = CPU.parseInt(attr.getNodeValue());
        rand = new Random();
    }
    
    public void reset() {
        rand.setSeed(new Date().getTime());
    }
    
    public void setValue(int address, int value, boolean internalAccess) {}
    
    public boolean isMe(int address) {
        if(address==startAddress) return true;
        return false;
    }
    
    public String getFrameTitle() {
        return "RandomNumberGenerator";
    }
    
    public boolean isMemoryMapped() {
        return true;
    }
    
}

