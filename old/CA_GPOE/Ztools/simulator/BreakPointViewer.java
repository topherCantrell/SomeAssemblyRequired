package simulator;

import javax.swing.*;
import javax.swing.border.*;
import java.awt.*;
import java.awt.event.*;

public class BreakPointViewer extends JPanel {
    
    CPU cpu;
    
    JTextField [] tfBreakPoints;
    JCheckBox [] cbActive;
    JCheckBox [] cbExecute;
    JCheckBox [] cbRead;
    JCheckBox [] cbWrite;
    
    BreakPointViewer(CPU cpu)
    {
        super(new BorderLayout());
        
        this.cpu = cpu;
        
        tfBreakPoints = new JTextField[cpu.numBreakPoints];
        cbActive = new JCheckBox[cpu.numBreakPoints];
        cbExecute = new JCheckBox[cpu.numBreakPoints];
        cbRead = new JCheckBox[cpu.numBreakPoints];
        cbWrite = new JCheckBox[cpu.numBreakPoints];
        
        CheckBoxUpdate cbu = new CheckBoxUpdate();
        JPanel jpBreaks = new JPanel(new GridLayout(cpu.numBreakPoints,1));
        for(int x=0;x<cpu.numBreakPoints;++x) {
            BPCellUpdate bpcu = new BPCellUpdate();
            bpcu.index = x;            
            JPanel bpPan = new JPanel(new BorderLayout());
            cbExecute[x] = new JCheckBox("Execute");
            cbExecute[x].addActionListener(cbu);
            cbRead[x] = new JCheckBox("Read");
            cbRead[x].addActionListener(cbu);
            cbWrite[x] = new JCheckBox("Write");
            cbWrite[x].addActionListener(cbu);
            cbActive[x] = new JCheckBox("Active");            
            cbActive[x].addActionListener(cbu);
            bpPan.add(BorderLayout.WEST,cbActive[x]);
            tfBreakPoints[x] = new JTextField(8);
            tfBreakPoints[x].addKeyListener(bpcu);
            bpPan.add(BorderLayout.CENTER,tfBreakPoints[x]);
            JPanel bpPan2 = new JPanel(new GridLayout(1,3));
            bpPan2.add(cbExecute[x]);
            bpPan2.add(cbRead[x]);
            bpPan2.add(cbWrite[x]);
            bpPan.add(BorderLayout.EAST,bpPan2);
            jpBreaks.add(bpPan);
        }
                
        add(BorderLayout.CENTER,new JScrollPane(jpBreaks));
        setBorder(BorderFactory.createTitledBorder("Break Points"));        
        
    }
    
    void updatePoints()
    {        
        for(int x=0;x<cpu.numBreakPoints;++x) {
            String s = tfBreakPoints[x].getText();
            if(s.length()==0) s="0";
            int addr = Integer.parseInt(s,CPU.getDisplayBase());
            if(cbActive[x].isSelected()) {
                if(cbExecute[x].isSelected()) {
                    cpu.softwareBreakPoints[x] = addr;
                } else {
                    cpu.softwareBreakPoints[x] = -1;
                }
                if(cbRead[x].isSelected()) {
                    cpu.hardwareBreakPointsRead[x] = addr;
                } else {
                    cpu.hardwareBreakPointsRead[x] = -1;
                }
                if(cbWrite[x].isSelected()) {
                    cpu.hardwareBreakPointsWrite[x] = addr;
                } else {
                    cpu.hardwareBreakPointsWrite[x] = -1;
                }
            } else {
                cpu.softwareBreakPoints[x] = -1;
                cpu.hardwareBreakPointsRead[x] = -1;
                cpu.hardwareBreakPointsWrite[x] = -1;
            }
        }
    }
    
    class CheckBoxUpdate implements ActionListener
    {
        
        public void actionPerformed(java.awt.event.ActionEvent actionEvent) {
            updatePoints();
        }
        
    }
    
    class BPCellUpdate implements KeyListener
    {
        
        int index;        
        
        public void keyReleased(java.awt.event.KeyEvent keyEvent) 
        {
            int v = 0;
            try{
                v = Integer.parseInt(tfBreakPoints[index].getText().trim(),
                  CPU.getDisplayBase());
            } catch(Exception ee) {}
            v = v % 65536;
            tfBreakPoints[index].setText(Integer.toString(v,CPU.getDisplayBase()).toUpperCase());   
            updatePoints();
        }
        
        public void keyPressed(java.awt.event.KeyEvent keyEvent) { }        
        public void keyTyped(java.awt.event.KeyEvent keyEvent) { }
        
    }
    
}
