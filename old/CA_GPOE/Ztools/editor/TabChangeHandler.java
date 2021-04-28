package editor;

import javax.swing.event.*;

public class TabChangeHandler implements ChangeListener {
    
    Snap snap;
    int lastTabIndex;
    boolean disabled;
    
    public TabChangeHandler(Snap snap) {
        this.snap = snap;
    } 
    
    public void stateChanged(javax.swing.event.ChangeEvent changeEvent) {
        
        
        if(disabled) {
            lastTabIndex = snap.jtabs.getSelectedIndex();
            return;
        }
       
        int i = snap.jtabs.getSelectedIndex(); 
        
        // See if any of the tabs have changes on them
        boolean changes = false;
        for(int x=0;x<snap.tabInfo.length;++x) {            
            if(snap.tabInfo[x].dirty) {
                changes = true;
                break;
            }
        }
        
        // Here is the way it works:
        // - Any time we go TO the ALL tab, we'll rebuild the ALL tab
        // which makes all the others not-dirty.
        // - Any time we leave the ALL tab, we'll re-parse the tabs.           
        
        if(changes && i==0) {
            int [] states = snap.recordTabCursors();
            snap.tabsToMaster();            
            for(int x=0;x<snap.tabInfo.length;++x) {
                snap.tabInfo[x].dirty = false;
            }            
            // We have to do this in order to update the originalTextEnd
            snap.masterToTabs(snap.tabInfo[0].jep.getText());
            snap.restoreTabCursors(states);
        } else if(changes && lastTabIndex==0) {
            int [] states = snap.recordTabCursors();
            snap.tabInfo[0].dirty = false;  
            snap.masterToTabs(snap.tabInfo[0].jep.getText());
            snap.restoreTabCursors(states);
        }
        
        lastTabIndex = snap.jtabs.getSelectedIndex();        
        
        snap.updateButtonEnable();
         
    }
    
}
