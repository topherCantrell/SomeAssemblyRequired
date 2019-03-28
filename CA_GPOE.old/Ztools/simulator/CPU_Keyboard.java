package simulator;

import org.w3c.dom.*;

import java.awt.*;
import java.awt.event.*;
import javax.swing.*;

public class CPU_Keyboard extends JPanel implements Hardware
{
    
    int startAddress;
    int maxSize;
    String title;
    int [] buffer;
    int bufferSize;
    JTextField tfBuffer;
    
    String interruptLevel;
    
    CPU cpu;
     
    public CPU_Keyboard()
    {
        super(new BorderLayout());
        setBorder(BorderFactory.createTitledBorder("Type Here"));
    }
    
    public int getValue(int address, boolean internalAccess) {
        if(bufferSize==0) return 0;
        int ret = buffer[0];
        for(int x=1;x<bufferSize;++x) {
            buffer[x-1] = buffer[x];
        }
        bufferSize = bufferSize-1;
        updateBufferDisplay();
        return ret;
    }
        
    public void loadXML(CPU cpu, Node n) {
        this.cpu = cpu;
        NamedNodeMap att = n.getAttributes();
        Node attr = att.getNamedItem("address");
        startAddress = CPU.parseInt(attr.getNodeValue());
        attr = att.getNamedItem("frameTitle");
        title = attr.getNodeValue();
        attr = att.getNamedItem("bufferSize");
        maxSize = CPU.parseInt(attr.getNodeValue());   
        attr = att.getNamedItem("interruptLevel");
        if(attr!=null) {
            interruptLevel = attr.getNodeValue();
        }
        
        buffer = new int[maxSize];
        tfBuffer = new JTextField(33);
        tfBuffer.setFont(Font.decode("Courier"));
        tfBuffer.setEditable(false);
        tfBuffer.addKeyListener(new TypeHandler());
        add(BorderLayout.CENTER,tfBuffer);
    }
        
    public void updateBufferDisplay()
    {
        StringBuffer r = new StringBuffer();
        for(int x=0;x<bufferSize;++x) {
            if(buffer[x]<32 || buffer[x]>127) {
                r.append('.');
            } else {
                r.append((char)buffer[x]);
            }
        }
        tfBuffer.setText(r.toString());
    }
    
    public void reset() {
        bufferSize = 0;
        updateBufferDisplay();
    }
    
    public void setValue(int address, int value, boolean internalAccess) {}
    
    public boolean isMe(int address) {
        if(address==startAddress) return true;
        return false;
    }
    
    public String getFrameTitle() {
        return title;
    }
    
    public boolean isMemoryMapped() {
        return true;
    }
       
    class TypeHandler implements KeyListener
    {
        
        public void keyReleased(java.awt.event.KeyEvent keyEvent) {
                    
        }        
        public void keyPressed(java.awt.event.KeyEvent keyEvent) {}        
        public void keyTyped(java.awt.event.KeyEvent keyEvent) {
             if(bufferSize==maxSize) return;
            char a = keyEvent.getKeyChar();
            buffer[bufferSize++] = a;
            updateBufferDisplay();               
            if(cpu.simulator!=null && interruptLevel!=null) {
                cpu.simulator.interrupt(interruptLevel,this);
            }
        }
        
    }
    
}
