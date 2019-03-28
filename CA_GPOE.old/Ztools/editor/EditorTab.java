package editor;

import javax.swing.JTextPane;
import javax.swing.JScrollPane;

public class EditorTab
{
    String name;
    JTextPane jep;
    JScrollPane jsp;
    
    boolean dirty;
    
    int originalTextStart;
    int originalTextEnd;
    
    public EditorTab(String name, JTextPane jep, int start, int end) {
        this.name = name;
        this.jep = jep;
        
        this.originalTextStart = start;
        this.originalTextEnd = end;
    }
}
