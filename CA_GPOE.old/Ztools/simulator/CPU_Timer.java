package simulator;

import org.w3c.dom.*;

import java.util.*;

public class CPU_Timer implements Hardware, TickNotice 
{
    
    CPU cpu;
    long reloadValue;
    long ticksToFire;
    String interruptLevel;       
    int address;
    int bit=-1;
    
    public void systemTick(int numberTicks, long totalTicks) {
        ticksToFire = ticksToFire - numberTicks;        
        if(ticksToFire<=0) {    
            //System.out.println("FIRING: "+interruptLevel);
            if(interruptLevel!=null) {
                cpu.simulator.interrupt(interruptLevel,this);
            } else {
                int val = cpu.getMemoryValue(address,true);
                val = val ^ bit;
                cpu.setMemoryValue(address,val,true);
                //System.out.println(":"+Integer.toString(address,16)+":"+val);
            }
            
            ticksToFire = reloadValue + ticksToFire;
        }
    }  
    
    public void loadXML(CPU cpu, Node n) {
        this.cpu = cpu;
        NamedNodeMap att = n.getAttributes();
        Node attr = att.getNamedItem("tickPeriod");
        reloadValue = CPU.parseInt(attr.getNodeValue());
        ticksToFire = reloadValue;        
        attr = att.getNamedItem("interruptLevel");
        if(attr!=null) {
            interruptLevel = attr.getNodeValue();
        }
        attr = att.getNamedItem("address");
        if(attr!=null) {
            address = CPU.parseInt(attr.getNodeValue());
        }
        attr = att.getNamedItem("bit");
        if(attr!=null) {
            bit = CPU.parseInt(attr.getNodeValue());
            bit = (int)Math.pow(2,bit);
        }
        
        cpu.addTickWatcher(this);
    }
    
    public void reset() {
        ticksToFire = reloadValue;
    }
    
    
    
    public String getFrameTitle() {return "CPU_Timer";}
    public int getValue(int address, boolean internalAccess) {return 0;}
    public void setValue(int address, int value, boolean internalAccess) {}    
    public boolean isMe(int address) {return false;}
    public boolean isMemoryMapped() {return false;}
    
}
