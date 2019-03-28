package simulator;

import org.w3c.dom.*;

import java.io.*;

public class CPU_ROM implements Hardware
{

    byte [] data;
    int startAddress;
    int size;
    int blankValue = 0;
    String fileName = null;
    
    CPU cpu;

    public void loadXML(CPU cpu, Node n) {
        this.cpu = cpu;
        NamedNodeMap att = n.getAttributes();
        Node attr = att.getNamedItem("address");
        startAddress = CPU.parseInt(attr.getNodeValue());
        attr = att.getNamedItem("size");
        size = CPU.parseInt(attr.getNodeValue());
        attr = att.getNamedItem("blankValue");
        if(attr!=null) {
            blankValue = CPU.parseInt(attr.getNodeValue());
        }
        attr = att.getNamedItem("file");
        if(attr!=null) {
            fileName = attr.getNodeValue();
        }
        data = new byte[size];
        for(int x=0;x<data.length;++x) {
          data[x] = (byte)blankValue;
        }   
    }
    
    public int getValue(int address, boolean internalAccess) {
        return data[address-startAddress];
    }
    
        
    public void reset() {   
        if(fileName!=null) {
          try {
            InputStream is = new FileInputStream(fileName);
            is.read(data);
            is.close();
          } catch (IOException e) {
            e.printStackTrace();
          }
        }
    }
    
    public void setValue(int address, int value, boolean internalAccess) {
        if(cpu.afterInit) return;
        data[address-startAddress] = (byte)value;        
    }
    
    public boolean isMe(int address) {
        if(address<startAddress) return false;
        if(address>=(startAddress+size)) return false;
        return true;
    }
    
    public String getFrameTitle() {
        return "CPU_ROM";
    }
    
    public boolean isMemoryMapped() {
        return true;
    }
    
}

