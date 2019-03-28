package simulator;

import javax.swing.*;
import javax.swing.border.*;
import java.awt.*;

import org.w3c.dom.*;

public class CPU_TextDisplay extends JPanel implements Hardware {
    
    int displayWidth;
    int displayHeight;
    int startAddress;
    
    String title;
    
    JTextArea textArea;
    CPU cpu;
    
    byte [] data;
    
    public CPU_TextDisplay() {
        super(new BorderLayout());
        setBorder(BorderFactory.createTitledBorder("Text Display"));
        
        textArea = new JTextArea();
        textArea.setEditable(false);
        textArea.setFont(Font.decode("Courier"));
        JPanel jpa = new JPanel();
        jpa.add(textArea);
        add(BorderLayout.CENTER,jpa);
    }
    
    public String getFrameTitle()
    {
        return title;
    }
    
    public void loadXML(CPU cpu, Node n) {
        this.cpu = cpu;
        NamedNodeMap att = n.getAttributes();
        Node attr = att.getNamedItem("width");
        displayWidth = CPU.parseInt(attr.getNodeValue());
        attr = att.getNamedItem("height");
        displayHeight = CPU.parseInt(attr.getNodeValue());
        attr = att.getNamedItem("address");
        startAddress = CPU.parseInt(attr.getNodeValue());
        textArea.setColumns(displayWidth);
        textArea.setRows(displayHeight);
        data = new byte[displayHeight*displayWidth];
        attr = att.getNamedItem("frameTitle");
        title = attr.getNodeValue();        
        updateDisplayText();
    }
    
    public void updateDisplayText()
    {
        String ss = "";
        for(int y=0;y<displayHeight;++y) {
            for(int x=0;x<displayWidth;++x) {
                char value = (char)data[y*displayWidth+x];
                if(value<32 || value>127) value = '.';
                ss = ss + value;
            }
            ss = ss +"\n";
        }
        textArea.setText(ss);        
    }
    
    public int getValue(int address, boolean internalAccess) {
        address = address-startAddress;
        return data[address];
    }      
    
    public void reset() {
        for(int x=0;x<data.length;++x) {
            data[x] = ' ';            
        }        
        cpu.setMemoryBlock(startAddress,data,false);
        updateDisplayText();
    }
    
    public void setValue(int address, int value, boolean internalAccess) 
    {        
        address = address-startAddress;
        data[address] = (byte)value;
        updateDisplayText();
    }
    
    public boolean isMe(int address) {
        if(address<startAddress) return false;
        if(address>=(startAddress+displayWidth*displayHeight)) return false;
        return true;
    }
    
    public boolean isMemoryMapped() {
        return true;
    }
    
}
