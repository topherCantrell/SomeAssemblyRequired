package editor;

import java.awt.event.*;
import java.io.*;
 
public class SnapButtonHandler implements ActionListener {
     
     Snap snap;
     
     public SnapButtonHandler(Snap snap)
     {
         this.snap = snap;
     }
     
     public void actionPerformed(java.awt.event.ActionEvent actionEvent) {
         
         if(actionEvent.getSource()==snap.btUpdate) {                          
             snap.masterToTabs(snap.tabInfo[0].jep.getText());                                       
         } else if(actionEvent.getSource()==snap.btSave) {
             try {
                 // Push any changes to the ALL tab
                 int i = snap.jtabs.getSelectedIndex();
                 snap.jtabs.setSelectedIndex(0);
                 snap.jtabs.setSelectedIndex(i);                 
                 String s = snap.toDOS(snap.tabInfo[0].jep.getText());
                 FileOutputStream fos = new FileOutputStream(snap.fileName);
                 fos.write(s.getBytes());
                 fos.flush();
                 fos.close();                 
             } catch (Exception e) {
                 e.printStackTrace();
             }
             snap.jframe.setTitle(snap.cleanTitle);
             snap.dirty = false;
             snap.btSave.setEnabled(false);
         } else if(actionEvent.getSource()==snap.btBuild) {
             snap.builder.build();
         }
     }
     
 }
