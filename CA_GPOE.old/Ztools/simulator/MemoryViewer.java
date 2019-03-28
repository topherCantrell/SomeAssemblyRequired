package simulator;

import javax.swing.*;
import javax.swing.border.*;
import java.awt.*;
import java.awt.event.*;

public class MemoryViewer extends JPanel {
    
    CPU cpu;
    
    JButton btPrevious;
    JButton btNext;
    JButton btGoto;
    JTextField tfAddress;
    JScrollPane jsp;
    
    int loadedAddress;
    JTextField [] tfAddresses;
    JTextField [] tfValues;
    
    public void setEnabled(boolean active)
    {
        super.setEnabled(active);
        for(int x=0;x<tfValues.length;++x) {
            tfValues[x].setEnabled(active);
            tfAddresses[x].setEnabled(active);
        }
        btPrevious.setEnabled(active);
        btNext.setEnabled(active);
        btGoto.setEnabled(active);
        tfAddress.setEnabled(active);
        jsp.setEnabled(active);
    }
    
    public MemoryViewer(CPU cpu) {
        super(new BorderLayout());
        this.cpu = cpu;
        setBorder(BorderFactory.createTitledBorder("Memory"));
        
        MemoryButtonHandler mbh = new MemoryButtonHandler();        
        
        btPrevious = new JButton("<");
        btPrevious.addActionListener(mbh);
        btNext = new JButton(">");
        btNext.addActionListener(mbh);
        btGoto = new JButton("Show:");
        btGoto.addActionListener(mbh);
        tfAddress = new JTextField("0",6);
        JPanel jpa = new JPanel();
        jpa.add(btPrevious);
        jpa.add(btGoto);
        jpa.add(tfAddress);
        jpa.add(btNext);
        
        tfAddresses = new JTextField[cpu.memoryViewerPageSize];
        tfValues = new JTextField[cpu.memoryViewerPageSize];
        
        JPanel mp = new JPanel(new GridLayout(cpu.memoryViewerPageSize,1));
        for(int x=0;x<cpu.memoryViewerPageSize;++x) {
            JPanel jpb = new JPanel(new BorderLayout());
            tfAddresses[x] = new JTextField(5);
            tfAddresses[x].setEditable(false);
            tfValues[x] = new JTextField(4);
            jpb.add(BorderLayout.WEST,tfAddresses[x]);
            jpb.add(BorderLayout.CENTER,tfValues[x]);
            mp.add(jpb);
        }               
        
        jsp = new JScrollPane(mp);
        jsp.setPreferredSize(new Dimension(100,100));
        
        add(BorderLayout.CENTER,jsp);        
        add(BorderLayout.SOUTH,jpa);
    }
    
    public void showAddress() {        
        String s = tfAddress.getText().trim();
        int sa = 0;
        try {
            sa = Integer.parseInt(s,CPU.getDisplayBase());
        } catch (Exception e) {}
        if(sa>(65536-cpu.memoryViewerPageSize)) sa = 65536-cpu.memoryViewerPageSize;
        tfAddress.setText(Integer.toString(sa,CPU.getDisplayBase()).toUpperCase());
        loadedAddress = sa;
        for(int x=0;x<tfAddresses.length;++x) {
            tfAddresses[x].setText(Integer.toString(sa+x,CPU.getDisplayBase()).toUpperCase());
            tfValues[x].setText(Integer.toString(cpu.getMemoryValue(sa+x,false),CPU.getDisplayBase()).toUpperCase());
            MemoryCellUpdate mcu = new MemoryCellUpdate();
            mcu.index = x;
            tfValues[x].addKeyListener(mcu);
        }
    }
    
    class MemoryButtonHandler implements ActionListener
    {
        
        public void actionPerformed(java.awt.event.ActionEvent actionEvent) 
        {
            Object o = actionEvent.getSource();
            if(o == btGoto) {
                showAddress();
            } else if(o==btPrevious) {
                loadedAddress = loadedAddress - cpu.memoryViewerPageSize;
                if(loadedAddress<0) loadedAddress = 0;
                tfAddress.setText(Integer.toString(loadedAddress,CPU.getDisplayBase()).toUpperCase());
                showAddress();
            } else if(o==btNext) {
                loadedAddress = loadedAddress + cpu.memoryViewerPageSize;
                if(loadedAddress>(65536-cpu.memoryViewerPageSize)) loadedAddress = 65536-cpu.memoryViewerPageSize;
                tfAddress.setText(Integer.toString(loadedAddress,CPU.getDisplayBase()).toUpperCase());
                showAddress();
            }
            
        }
        
    }
    
    class MemoryCellUpdate implements KeyListener
    {
        
        int index;        
        
        public void keyReleased(java.awt.event.KeyEvent keyEvent) 
        {
            int v = 0;
            try{
                v = Integer.parseInt(tfValues[index].getText().trim(),
                  CPU.getDisplayBase());
            } catch(Exception ee) {}
            v = v % 256;
                        
            int ad = loadedAddress + index;            
            
            cpu.setMemoryValue(ad,v,false);
            v = cpu.getMemoryValue(ad,false);
            
            tfValues[index].setText(Integer.toString(v,CPU.getDisplayBase()).toUpperCase());
        
        }
        
        public void keyPressed(java.awt.event.KeyEvent keyEvent) { }        
        public void keyTyped(java.awt.event.KeyEvent keyEvent) { }
        
    }
    
    
}
