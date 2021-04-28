package editor;

import javax.swing.*;
import javax.swing.text.*;
import java.awt.*;
import java.awt.event.*;
import javax.swing.event.*;

import java.io.*;
import java.util.*;

// TO DO:
// Search/replace facility
// Line numbers, auto-indent, line coloring

public class Snap extends JPanel
{    
    
    Builder builder;
    EditorTab [] tabInfo;
    JTabbedPane jtabs;    
    
    JButton btBuild;
    JButton btSave;
    JButton btUpdate;
        
    JFrame jframe;
    
    TabChangeHandler tabChangeHandler;
    DirtyTextHandler dirtyTextHandler;
    SnapButtonHandler buttonHandler;
    boolean dirty;
    
    String fileName;
    String cleanTitle;
    String dirtyTitle;
    
    public static String toDOS(String text)
    {
        StringBuffer sb = new StringBuffer();
        for(int x=0;x<text.length();++x) {
            if(text.charAt(x)=='\n') {
                sb.append('\r');
            }
            sb.append(text.charAt(x));
        }
        return sb.toString();
    }    
    public static String fromDOS(String text)
    {
        StringBuffer sb = new StringBuffer();
        for(int x=0;x<text.length();++x) {
            if(text.charAt(x)!='\r') {
                sb.append(text.charAt(x));
            }
        }
        return sb.toString();
    }
    
    public static JTextPane makeJTextPane(String text)
    {
        
        JTextPane jep = new JTextPane();
        jep.setText(text);
        jep.setFont(SnapConfig.editorFont);
        return jep;
        
        //StyleContext sc = new StyleContext();
        //Style cs = sc.addStyle("CommentLine",null);        
        //cs.addAttribute(StyleConstants.Bold,null);        
        //StyledDocument sd = jep.getStyledDocument();        
        //sd.setLogicalStyle(500,cs);        
        //jep.setStyledDocument( aStyledDocument );
        // DefaultStyledDocument
        
    }
    
    /**
     */
    java.util.List findEditorPanes(String text)
    {
        java.util.List ret = new ArrayList();                        
        JTextPane jep = makeJTextPane(text);
        jep.setCaretPosition(0);
        jep.addKeyListener(dirtyTextHandler);
        EditorTab et = new EditorTab("All",jep,-1,-1);
        ret.add(et);
        
        int i=0;
        while(true) {
            int j = text.indexOf("<EditorTab ",i);
            if(j<0) break;
            
            int n = text.indexOf("\"",j);
            int nn = text.indexOf("\"",n+1);
            String name = text.substring(n+1,nn).trim();
            j = text.indexOf("\n",nn);
            
            int jj = text.indexOf("</EditorTab>",j);
            while(text.charAt(jj)!='\n') --jj;            
            if(jj==j) jj=j+1;
            String tt = text.substring(j+1,jj);           
            i = jj;
            
            jep = makeJTextPane(tt);    
            jep.setCaretPosition(0);
            jep.addKeyListener(dirtyTextHandler);
            
            et = new EditorTab(name,jep,j+1,jj);
            ret.add(et);
        }
        
        return ret;
    }  
    
    
     /**
     * This method rebuilds all the tabs from the text of the ALL tab. This
     * method assumes that there are no changes pending on any tab except
     * the ALL tab.
     * @param s the ALL tab text
     */
    void masterToTabs(String s) {
        
        // Otherwise we'll get calls back to this method as we
        // are cleaning out the tabs.
        tabChangeHandler.disabled = true;
        
        // Remember which tab we are on (by name)
        int si = jtabs.getSelectedIndex();
        String ot = "";
        if(si>=0) {
            ot = jtabs.getTitleAt(si);
        }
        
        // Clear out the tabs                
        for(int x=jtabs.getTabCount()-1;x>=0;--x) {
            jtabs.removeTabAt(x);
        }   
        
        // Parse the text
        java.util.List a = findEditorPanes(s);        
        
        // Create the new tabs
        tabInfo = new EditorTab[a.size()];
        for(int x=0;x<tabInfo.length;++x) {
            tabInfo[x] = (EditorTab)a.get(x);      
            tabInfo[x].jsp = new JScrollPane(tabInfo[x].jep);            
            jtabs.insertTab(tabInfo[x].name,null,tabInfo[x].jsp,null,x);
            if(tabInfo[x].name.equals(ot)) {
                jtabs.setSelectedIndex(x);
            }
        }   
        
        tabChangeHandler.disabled = false;
        
        // It is possible that we moved tabs here (if we deleted a tab)
        updateButtonEnable();
        
    }
    
    /**
     * This method pulls all the changes from the individual tabs and rebuilds
     * the ALL tab. This method assumes that there are no changes pending
     * on the ALL tab.
     */
    void tabsToMaster() {        
        int last = 0;
        StringBuffer b = new StringBuffer();       
        String a = tabInfo[0].jep.getText();
        for(int x=1;x<tabInfo.length;++x) {            
            b.append(a.substring(last,tabInfo[x].originalTextStart));
            b.append(tabInfo[x].jep.getText());
            last = tabInfo[x].originalTextEnd;
            tabInfo[x].dirty = false;
        }        
        b.append(a.substring(last));
        tabInfo[0].jep.setText(b.toString());                  
        tabInfo[0].dirty = false;
    }
    
    void updateButtonEnable()
    {        
        if(jtabs.getSelectedIndex()==0) {
            btUpdate.setEnabled(true);
        } else if(jtabs.getSelectedIndex()>0) {
            btUpdate.setEnabled(false);
        }
    }
    
    int [] recordTabCursors()
    {
        int [] ret = new int[tabInfo.length*2];
        for(int x=0;x<ret.length;x=x+2) {
            ret[x] = tabInfo[x/2].jep.getCaretPosition();    
            ret[x+1] = tabInfo[x/2].jsp.getViewport().getViewPosition().y;
        }        
        return ret;
    }
    
    void restoreTabCursors(int [] states)
    {        
        if((tabInfo.length*2)!=states.length) return;        
        for(int x=0;x<states.length;x=x+2) {
            String s = tabInfo[x/2].jep.getText();
            if(states[x]<=s.length()) {
                tabInfo[x/2].jep.setCaretPosition(states[x]);
                tabInfo[x/2].jsp.getViewport().setViewPosition(new Point(0,states[x+1]));
            }            
        }
    }
    
    
    public Snap(String fileName, JFrame jframe) throws Exception
    {
        
        super(new BorderLayout());
        
        this.fileName = fileName;
        this.jframe = jframe;
        cleanTitle = fileName;
        dirtyTitle = cleanTitle+" *";        
        
        jframe.setTitle(cleanTitle);
        
        InputStream is = new FileInputStream(fileName);
        byte [] b = new byte[is.available()];
        is.read(b);
        is.close();        
        String text = new String(b);
        text = fromDOS(text);         
        
        tabChangeHandler = new TabChangeHandler(this);
        dirtyTextHandler = new DirtyTextHandler(this);
        buttonHandler = new SnapButtonHandler(this);
        
        builder = new Builder(this);
        btBuild = new JButton("Build");
        btBuild.addActionListener(buttonHandler);
        
        btSave = new JButton("Save");
        btSave.setEnabled(false);
        btSave.addActionListener(buttonHandler);
        btUpdate = new JButton("Update Tabs");
        btUpdate.addActionListener(buttonHandler);        
        
        JPanel jpButtons = new JPanel();
        jpButtons.add(btUpdate);
        jpButtons.add(btSave);
        jpButtons.add(btBuild);
        
        jtabs = new JTabbedPane(JTabbedPane.LEFT);        
        
        JPanel jpA = new JPanel(new BorderLayout());
        jpA.add(BorderLayout.CENTER,jtabs);
        jpA.add(BorderLayout.SOUTH,jpButtons);
        
        JSplitPane msp = new JSplitPane(JSplitPane.VERTICAL_SPLIT,jpA,builder);
        msp.setDividerLocation(jframe.getHeight()-125);
                
        this.add(BorderLayout.CENTER,msp);
        
        masterToTabs(text);
        
        jtabs.addChangeListener(tabChangeHandler);
        
        updateButtonEnable();
    }
    
    public static void main(String [] args) throws Exception 
    {        
        JFrame jframe = new JFrame();        
        jframe.setBounds(100,100,800,600);
        Snap snap = new Snap(args[0],jframe);                
        jframe.getContentPane().add(BorderLayout.CENTER,snap);        
        jframe.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);        
        jframe.setVisible(true);
    }
    
}
