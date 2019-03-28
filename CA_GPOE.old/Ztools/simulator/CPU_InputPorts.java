package simulator;

import org.w3c.dom.*;

import java.awt.*;
import java.awt.event.*;
import javax.swing.*;
import java.util.*;

class PortInfo
{
    String name;    
    ArrayList bits;
}

class BitInfo
{
    String name;
    int address;
    int position;
    boolean activeHigh;
    JCheckBox checkBox;
    boolean editable;
}

public class CPU_InputPorts extends JPanel implements Hardware
{
    
    ArrayList ports;
    ArrayList allBits;
    String frameTitle;
    CPU cpu;
    
    public CPU_InputPorts() 
    {
        super(new BorderLayout());
    }
    
    public void loadXML(CPU cpu, Node n) {
        this.cpu = cpu;
        ports = new ArrayList();
        allBits = new ArrayList();
        NamedNodeMap att = n.getAttributes();
        Node attr = att.getNamedItem("frameTitle");
        frameTitle = attr.getNodeValue();
        NodeList o = n.getChildNodes();
        for(int x=0;x<o.getLength();++x) {
            Node oo = o.item(x);
            if(oo.getNodeType()!=Node.ELEMENT_NODE) continue;
            String on = oo.getNodeName();
            if(on.equals("Port")) {
                PortInfo p = new PortInfo();
                p.bits = new ArrayList();
                ports.add(p);
                att = oo.getAttributes();
                attr = att.getNamedItem("name");
                p.name = attr.getNodeValue();                
                NodeList ool = oo.getChildNodes();
                for(int y=0;y<ool.getLength();++y) {
                    Node ooo = ool.item(y);
                    if(ooo.getNodeType()!=Node.ELEMENT_NODE) continue;
                    on = ooo.getNodeName();
                    if(on.equals("Bit")) {
                        BitInfo bi = new BitInfo();
                        allBits.add(bi);
                        p.bits.add(bi);  
                        att = ooo.getAttributes();
                        attr = att.getNamedItem("address");
                        bi.address = CPU.parseInt(attr.getNodeValue());                        
                        attr = att.getNamedItem("name");
                        bi.name = attr.getNodeValue();
                        attr = att.getNamedItem("number");
                        bi.position = CPU.parseInt(attr.getNodeValue());
                        bi.name=Integer.toString(bi.address,16)+":"+bi.position+": "+bi.name;
                        attr = att.getNamedItem("active");
                        bi.activeHigh = true;
                        if(attr!=null && attr.getNodeValue().equals("false")) {
                            bi.activeHigh = false;
                        }
                        attr = att.getNamedItem("editable");
                        bi.editable = true;
                        if(attr!=null && attr.getNodeValue().equals("false")) {
                            bi.editable = false;
                        }
                    } else {
                        throw new RuntimeException("Unexpected node: "+on);
                    }
                }
            } else {
                throw new RuntimeException("Unexpected node: "+on);
            }
        }
        
        JPanel ip = new JPanel(new GridLayout(ports.size(),1));
        for(int x=0;x<ports.size();++x) {
            PortInfo pi = (PortInfo)ports.get(x);
            JPanel por = new JPanel(new GridLayout(2,4));
            por.setBorder(BorderFactory.createTitledBorder(pi.name));
            ip.add(por);
            for(int y=0;y<pi.bits.size();++y) {
                BitInfo bi = (BitInfo)pi.bits.get(y);
                bi.checkBox = new JCheckBox(bi.name);
                bi.checkBox.setEnabled(bi.editable);
                por.add(bi.checkBox);
            }
        }
        
        add(BorderLayout.CENTER,ip);        
        
    }
    
    public boolean isMe(int address) {
        for(int x=0;x<allBits.size();++x) {
            BitInfo bi = (BitInfo)allBits.get(x);
            if(bi.address == address) return true;
        }
        return false;
    }   
    
    public void reset() {
        for(int x=0;x<allBits.size();++x) {
            BitInfo bi = (BitInfo)allBits.get(x);
            if(bi.editable) {
                bi.checkBox.setSelected(false);
            }
        }
    }
    
    public String getFrameTitle() 
    {
        return frameTitle;
    }
    
    public int getValue(int address, boolean internalAccess) {
        int ret = 0;
        for(int x=0;x<allBits.size();++x) {
            BitInfo bi = (BitInfo)allBits.get(x);
            if(bi.address != address) continue;            
            if(bi.checkBox.isSelected()) {
                ret = ret | (int)Math.pow(2,bi.position);
            } 
        }        
        return ret;
    }
    
    public void setValue(int address, int value, boolean internalAccess) {
        if(!internalAccess) return;
        //System.out.println(":"+Integer.toString(address,16)+":"+value);
        for(int x=0;x<allBits.size();++x) {
            BitInfo bi = (BitInfo)allBits.get(x);
            if(bi.address != address) continue;                        
            int v = value & (int)Math.pow(2,bi.position);
            if(v!=0) {
                bi.checkBox.setSelected(true);
            } else {
                bi.checkBox.setSelected(false);
            }
        }
    }
    
    public boolean isMemoryMapped() {
        return true;
    }
    
    
    
}

