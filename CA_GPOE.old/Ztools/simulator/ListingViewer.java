package simulator;

import javax.swing.*;
import javax.swing.border.*;
import java.awt.*;
import java.util.*;

import java.io.*;

public class ListingViewer extends JPanel {
    
    CPU cpu;
    JTextArea taListing;
    HashMap addressToOffset;  // KEY=Integer(address), value = Integer(offset)
    String text;
    
    static String expandTabs(String target)
    {
        while(true) {
            int i = target.indexOf("\t");
            if(i<0) return target;
            String s = target.substring(0,i)+"    "+target.substring(i+1);
            target = s;
        }
    }
    
    public void setEnabled(boolean active)
    {
        super.setEnabled(active);
        taListing.setEnabled(active);
    }
    
    public boolean showAddress(int address)
    {
        if(addressToOffset==null) return true;
        Integer i = (Integer)addressToOffset.get(new Integer(address));
        if(i==null) {
            return false;
        } else {
            int ii = i.intValue();
            taListing.setCaretPosition(ii);
            int jj = text.indexOf("\n",ii);
            if(jj<0) jj=text.length();
            taListing.moveCaretPosition(jj);
            taListing.requestFocus();
            return true;
        }
    }
    
    public ListingViewer(CPU cpu) {
        super(new BorderLayout());
        this.cpu = cpu;
        setBorder(BorderFactory.createTitledBorder("Assembly Listing"));        
        
        taListing = new JTextArea();
        taListing.setEditable(false);
        //taListing.setSelectedTextColor(Color.white);
        taListing.setSelectionColor(Color.green);

        taListing.setFont(Font.decode("Courier"));

        JScrollPane jsp = new JScrollPane(taListing);
        jsp.setPreferredSize(new Dimension(200,200));
        
        add(BorderLayout.CENTER,jsp);
        
    }
    
    String stripSpaces(String s)
    {
        byte [] a = s.getBytes();
        byte [] b = new byte[a.length];
        int p=0;
        for(int x=0;x<a.length;++x) {
            if(a[x]!=' ') b[p++] = a[x];
        }
        return new String(b,0,p);
    }
    
    public void load(String fileName,FileReader fr) throws IOException
    {
        addressToOffset = new HashMap();
        BufferedReader br = new BufferedReader(fr);
        int currentOffset = 0;
        while(true) {
            String g = br.readLine();            
            if(g==null) break;
            if(g.startsWith("*****")) break;
            g = expandTabs(g);
            g = g+"\n";
            taListing.append(g);  
            if(g.length()>4 && !g.startsWith(" ")) {
                
                int address = Integer.parseInt(g.substring(0,4),16);
                Integer key = new Integer(address);                
                
                int y = g.indexOf("  ",7);
                if(y<0) continue;
                String vv = stripSpaces(g.substring(7,y));
                for(int x=0;x<vv.length();x=x+2) {
                    if(key!=null) {
                        addressToOffset.put(key,new Integer(currentOffset));
                        key = null;
                    }
                    int val = Integer.parseInt(vv.substring(x,x+2),16);
                    cpu.setMemoryValue(address,val,false);
                    ++address;
                }
            }
            
            currentOffset=currentOffset+g.length();  
        }
        text = taListing.getText();
    }
    
}
