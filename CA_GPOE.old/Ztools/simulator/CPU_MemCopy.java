package simulator;

import org.w3c.dom.*;

import javax.swing.*;
import java.awt.*;
import java.awt.event.*;
import java.io.*;

import java.util.*;

public class CPU_MemCopy extends JPanel implements Hardware 
{
    
    CPU cpu;    
    
    JTextField jtStart;
    JTextField jtSize;
    JTextField jtFilename;
    JButton btToFile;
    JButton btFromFile;
    
    public void loadXML(CPU cpu, Node n) 
    {
        this.cpu = cpu;
        setLayout(new BorderLayout());
        jtStart = new JTextField();
        jtSize = new JTextField();
        jtFilename = new JTextField();
        btToFile = new JButton("To File");
        btFromFile = new JButton("From File");
        
        BtHandle bth = new BtHandle();
        btToFile.addActionListener(bth);
        btFromFile.addActionListener(bth);
        
        JPanel jpa = new JPanel(new GridLayout(3,2));
        jpa.add(jtStart);
        jpa.add(new JLabel("Start Address"));
        jpa.add(jtSize);
        jpa.add(new JLabel("Size"));
        jpa.add(jtFilename);
        jpa.add(new JLabel("File Name"));
        
        JPanel btp = new JPanel(new FlowLayout());
        btp.add(btToFile);
        btp.add(btFromFile);
        
        add(BorderLayout.CENTER,jpa);
        add(BorderLayout.SOUTH,btp);
    }  
    
    public String getFrameTitle() {return "Memory Copy Instrument";}          
    public int getValue(int address, boolean internalAccess) {return -1;}    
    public boolean isMe(int address) {return false;}    
    public boolean isMemoryMapped() {return false;}
    public void reset() {}    
    public void setValue(int address, int value, boolean internalAccess) {}
    
    class BtHandle implements ActionListener {
        
        public void actionPerformed(java.awt.event.ActionEvent actionEvent) {
            try {
                if(actionEvent.getSource()==btToFile) {
                    OutputStream os = new FileOutputStream(jtFilename.getText().trim());
                    int sa = Integer.parseInt(jtStart.getText().trim(),16);
                    int si = Integer.parseInt(jtSize.getText().trim(),16);
                    for(int x=0;x<si;++x) {
                        int a = cpu.getMemoryValue(sa+x,false);
                        os.write(a);
                    }
                    os.flush();
                    os.close();
                } else {
                    InputStream is = new FileInputStream(jtFilename.getText().trim());
                    int sa = Integer.parseInt(jtStart.getText().trim(),16);
                    int si = Integer.parseInt(jtSize.getText().trim(),16);
                    for(int x=0;x<si;++x) {
                        int a = is.read();
                        cpu.setMemoryValue(sa+x,a,false);                        
                    }                    
                    is.close();
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        
    }
    
}
