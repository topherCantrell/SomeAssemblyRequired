package simulator;

import javax.swing.*;
import javax.swing.border.*;
import java.awt.*;
import java.awt.event.*;
import java.util.*;

import org.w3c.dom.*;

public class RegisterViewer extends JPanel
{
        
    CPU cpu;
    ArrayList registerList = new ArrayList();  
    
    public RegisterViewer(Node n,CPU cpu) 
    {
        super(new BorderLayout());
        this.cpu = cpu;
        setBorder(BorderFactory.createTitledBorder("Registers"));
        
        loadXML(n);
        JPanel lp = new JPanel(new GridLayout(registerList.size(),1));
        JPanel rp = new JPanel(new GridLayout(registerList.size(),1));
        
        add(BorderLayout.WEST,lp);
        add(BorderLayout.EAST,rp);
        
        for(int x=0;x<registerList.size();++x) {
            if(registerList.get(x) == null) {
                lp.add(new JLabel());
                rp.add(new JLabel());
            } else if(registerList.get(x) instanceof RegisterInfo) {
                RegisterInfo ri = (RegisterInfo)registerList.get(x);                  
                lp.add(new JLabel("  "+ri.name+"  ",JLabel.RIGHT));
                ri.textField = new JTextField((cpu.simulator.getRegisterSize(ri.name)/8)*6);
                JPanel fp = new JPanel(new FlowLayout(FlowLayout.LEFT,0,0));                
                fp.add(ri.textField);
                rp.add(fp);
                MapFieldUpdate mfu = new MapFieldUpdate();                
                mfu.regName = ri.name;
                mfu.size = cpu.simulator.getRegisterSize(ri.name);                              
                ri.textField.addKeyListener(mfu);
            } else {
                ArrayList a = (ArrayList)registerList.get(x);                
                JPanel j = new JPanel(new FlowLayout(FlowLayout.LEFT,4,0));
                for(int y=0;y<a.size();++y) {
                    BitInfo bi = (BitInfo)a.get(y);
                    bi.checkBox = new JCheckBox(bi.name);
                    bi.checkBox.setFont(Font.decode("Courier"));
                    j.add(bi.checkBox);                                                        
                    CheckBoxUpdate cbu = new CheckBoxUpdate();   
                    cbu.regName = bi.regName;
                    cbu.mapBit = bi.mapBit;
                    bi.checkBox.addActionListener(cbu);                   
                }                
                lp.add(new JLabel());
                rp.add(j);
            }
        }        
    }
    
    public void setEnabled(boolean active)
    {
         super.setEnabled(active);        
         for(int x=0;x<registerList.size();++x) {
            if(registerList.get(x) == null) continue;
            if(registerList.get(x) instanceof RegisterInfo) {   
                RegisterInfo ri = (RegisterInfo)registerList.get(x);
                ri.textField.setEnabled(active);
            } else {
                ArrayList a = (ArrayList)registerList.get(x);                                
                for(int y=0;y<a.size();++y) {
                    BitInfo bi = (BitInfo)a.get(y);
                    bi.checkBox.setEnabled(active);
                }                
            }
        }         
    }
    
    void updateAllFields()
    {
        for(int x=0;x<registerList.size();++x) {
            if(registerList.get(x) == null) continue;
            if(registerList.get(x) instanceof RegisterInfo) {
                RegisterInfo ri = (RegisterInfo)registerList.get(x);
                int val = cpu.simulator.getRegisterValue(ri.name);
                ri.textField.setText(Integer.toString(val,CPU.getDisplayBase()).toUpperCase());
            } else {
                ArrayList a = (ArrayList)registerList.get(x);                                
                for(int y=0;y<a.size();++y) {
                    BitInfo bi = (BitInfo)a.get(y);
                    int val = cpu.simulator.getRegisterValue(bi.regName);
                    val = val & (1<<bi.mapBit);
                    if(val!=0) bi.checkBox.setSelected(true);
                    else bi.checkBox.setSelected(false);
                }                
            }
        }
    }
    
    void loadXML(Node n) {
        NodeList o = n.getChildNodes();
        for(int x=0;x<o.getLength();++x) {
            Node oo = o.item(x);
            short t = oo.getNodeType();
            if(t!=Node.ELEMENT_NODE) continue;
            if(oo.getNodeName().equals("Register")) {                
                NamedNodeMap att = oo.getAttributes();
                Node attr = att.getNamedItem("name");
                RegisterInfo ri = new RegisterInfo();
                ri.name = attr.getNodeValue().trim();                                                
                registerList.add(ri);                
            } else if(oo.getNodeName().equals("Separator")) {
                registerList.add(null);
            } else if(oo.getNodeName().equals("BitRow")) {
                ArrayList bits = new ArrayList();
                NodeList co = oo.getChildNodes();
                for(int y=0;y<co.getLength();++y) {
                    Node ooo = co.item(y);
                    short tt = ooo.getNodeType();
                    if(tt!=Node.ELEMENT_NODE) continue;
                    if(ooo.getNodeName().equals("Bit")) {
                        BitInfo bi = new BitInfo();
                        NamedNodeMap catt = ooo.getAttributes();
                        Node cattr = catt.getNamedItem("name");
                        bi.name = cattr.getNodeValue().trim();
                        cattr = catt.getNamedItem("map");
                        String map = cattr.getNodeValue().trim(); 
                        int i = map.indexOf(":");                     
                        bi.regName = map.substring(0,i);
                        bi.mapBit = CPU.parseInt(map.substring(i+1));  
                        bits.add(bi);
                    } else {
                        throw new RuntimeException("Unknown node: "+ooo);
                    }
                }       
                registerList.add(bits);
            } else {
                throw new RuntimeException("Unknown node: "+oo);
            }
        }
    }    
       
    static class BitInfo {        
        String name;      
        String regName;
        int mapBit;        
        JCheckBox checkBox;
    }    
    
    static class RegisterInfo {
        String name;        
        JTextField textField;
    }
    
    class MapFieldUpdate implements KeyListener {
        String regName;
        int size;         
        
        public void keyPressed(java.awt.event.KeyEvent keyEvent) {}
        public void keyTyped(java.awt.event.KeyEvent keyEvent) {}
        public void keyReleased(java.awt.event.KeyEvent keyEvent) {
            JTextField textField = (JTextField)keyEvent.getSource();
            int v = 0;
            try{
                v = Integer.parseInt(textField.getText().trim(),
                    CPU.getDisplayBase());
            } catch(Exception ee) {}
            v = v % (1<<size);
            textField.setText(Integer.toString(v,CPU.getDisplayBase()).toUpperCase());
            cpu.simulator.setRegisterValue(regName,v);
            updateAllFields();
        }
    }
    
    class CheckBoxUpdate implements ActionListener {
        String regName;        
        int mapBit;           
        
        public void actionPerformed(java.awt.event.ActionEvent actionEvent) {
            JCheckBox checkBox = (JCheckBox)actionEvent.getSource();
            int nb = 1<<mapBit;
            int value = cpu.simulator.getRegisterValue(regName);
            if(checkBox.isSelected()) {
                value = value | nb;
            } else {
                value = value & (~nb);
            }
            cpu.simulator.setRegisterValue(regName,value);
            updateAllFields();
        }
    }
    
}
