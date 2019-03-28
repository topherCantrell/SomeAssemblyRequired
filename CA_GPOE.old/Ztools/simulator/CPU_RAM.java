package simulator;

import org.w3c.dom.*;

public class CPU_RAM implements Hardware
{

    byte [] data;
    int startAddress;
    int size;

    public void loadXML(CPU cpu, Node n) {
        NamedNodeMap att = n.getAttributes();
        Node attr = att.getNamedItem("address");
        startAddress = CPU.parseInt(attr.getNodeValue());
        attr = att.getNamedItem("size");
        size = CPU.parseInt(attr.getNodeValue());
        data = new byte[size];
        for(int x=0;x<data.length;++x) {
          data[x] = 0;
        }   
    }
    
    public int getValue(int address, boolean internalAccess) {
        return data[address-startAddress];
    }
    
        
    public void reset() {
        // Nothing to do
    }
    
    public void setValue(int address, int value, boolean internalAccess) {
        data[address-startAddress] = (byte)value;
    }
    
    public boolean isMe(int address) {
        if(address<startAddress) return false;
        if(address>=(startAddress+size)) return false;
        return true;
    }
    
    public String getFrameTitle() {
        return "CPU_RAM";
    }
    
    public boolean isMemoryMapped() {
        return true;
    }
    
}
