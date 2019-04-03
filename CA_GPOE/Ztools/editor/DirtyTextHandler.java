package editor;

import java.awt.event.*;

public class DirtyTextHandler implements KeyListener {
    
    Snap snap;
    
    public DirtyTextHandler(Snap snap)
    {
        this.snap = snap;
    }
    
    public void keyPressed(java.awt.event.KeyEvent keyEvent) { }
    public void keyReleased(java.awt.event.KeyEvent keyEvent) { }
    
    public void keyTyped(java.awt.event.KeyEvent keyEvent) {
        
        snap.btSave.setEnabled(true);
        for(int x=0;x<snap.tabInfo.length;++x) {
            if(snap.tabInfo[x].jep == keyEvent.getSource()) {
                snap.tabInfo[x].dirty = true;
            } 
        }
        if(!snap.dirty) {
            snap.dirty = true;
            snap.jframe.setTitle(snap.dirtyTitle);
        }
    }
    
}
