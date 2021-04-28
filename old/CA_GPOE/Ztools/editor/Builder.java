package editor;

import javax.swing.*;
import java.awt.*;
import java.awt.event.*;
import java.io.*;
import java.util.*;

public class Builder extends JPanel
{
    
    JTextPane output;
    Snap snap;
    
    public Builder(Snap snap)
    {
        super(new BorderLayout());
        this.snap = snap;
        output = new JTextPane();
        output.setEditable(false);        
        add(BorderLayout.CENTER,new JScrollPane(output));
    }
    
    void build()
    {
        output.setText("");
        String s = snap.tabInfo[0].jep.getText();
        int jj = 0;
        while(true) {
            int i = s.indexOf("build-command",jj);
            if(i<0) {
                break;                
            }
            jj = i+14;
            int j = s.indexOf("\n",i);
            String bc = s.substring(i+14,j).trim();
            output.setText(output.getText()+"-- Executing '"+bc+"'\n");
            try {
                Process p = Runtime.getRuntime().exec(bc);
                InputStream is = p.getInputStream();
                InputStreamReader isr = new InputStreamReader(is);
                BufferedReader br=new BufferedReader(isr);
                InputStream eis = p.getErrorStream();
                InputStreamReader eisr = new InputStreamReader(eis);
                BufferedReader ebr = new BufferedReader(eisr);
                StringBuffer sb=new StringBuffer();
                while(true) {
                    String g = br.readLine();
                    if(g==null) break;
                    sb.append(g);
                    sb.append("\n");
                }
                output.setText(output.getText()+sb.toString());
                sb=new StringBuffer();
                boolean errorDetect = false;
                while(true) {
                    String g = ebr.readLine();
                    if(g==null) break;
                    errorDetect=true;                    
                    sb.append(g);
                    sb.append("\n");
                }
                output.setText(output.getText()+sb.toString());
                if(errorDetect) {
                    output.setText(output.getText()+"# ERROR DETECTED. Aborting build.\n");
                    break;
                }
            } catch (IOException e) {
                e.printStackTrace();
            }
            output.setText(output.getText()+"-- Done with '"+bc+"'\n");
        }
    }
    
}
