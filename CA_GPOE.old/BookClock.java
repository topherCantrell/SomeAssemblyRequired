import javax.swing.*;
import java.awt.*;
import java.awt.event.*;
import java.util.*;
import java.text.*;
import java.io.*;

public class BookClock
{
    
    static JTextField thisSession;
    static JTextField thisWeek;
    static JTextField totalTime;
    static JButton btStartStop;
    static String dataFileName;
    static Date startSessionDate;
    static ClockUpdate updateThread;
    static JTextArea logArea;
    static JButton btLogSave;
    static JButton btLogCancel;
    static JFrame fLog;
    
    static String toDOS(String text)
    {
        byte [] b = text.getBytes();
        byte [] bb = new byte[b.length*2];
        int y=0;
        for(int x=0;x<b.length;++x) {
            if(b[x]=='\n') {
                bb[y++]='\r';
            }
            bb[y++] = b[x];
        }
        return new String(bb,0,y);
    }
    
    static class ClockUpdate implements Runnable
    {
        boolean running = true;
        
        public void run()
        {
            while(running) {
                Date nd = new Date();
                long secs = nd.getTime() - startSessionDate.getTime();
                secs = secs/1000;
                String s = secondsToString((int)secs);
                thisSession.setText(s);
                try {
                    Thread.sleep(1000);
                } catch (Exception e) {}
            }
        }
    }      
    
    static class BookClockButtons implements ActionListener
    {
        
        public void actionPerformed(ActionEvent actionEvent) {
            try {
                JButton o = (JButton)actionEvent.getSource();
                if(o.getText().equals("Start")) {
                    o.setText("Stop");
                    startSessionDate = new Date();
                    updateThread = new ClockUpdate();
                    Thread t = new Thread(updateThread);
                    t.start();
                } else if(o.getText().equals("Stop")) {
                    // Stop the timer thread
                    updateThread.running = false;
                    o.setText("Start");
                    Date stopSessionDate = new Date();
                    long sessionSecs = stopSessionDate.getTime() - startSessionDate.getTime();                    
                    Writer w = new FileWriter(dataFileName,true);
                    PrintWriter pw = new PrintWriter(w);
                    pw.print("+++"+sessionSecs/1000+" "+startSessionDate+"\r\n");
                    pw.flush();
                    pw.close();
                    loadData();                    
                    fLog.setVisible(true);
                } else if(o==btLogSave) {
                    Writer w = new FileWriter(dataFileName,true);
                    PrintWriter pw = new PrintWriter(w);
                    pw.print(toDOS(logArea.getText())+"\r\n");
                    pw.flush();
                    pw.close();            
                    fLog.setVisible(false);
                    logArea.setText("");
                } else if(o==btLogCancel) {
                    // Nothing to do!
                    fLog.setVisible(false);
                    logArea.setText("");
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        
    }
    
    public static void main(String [] args) throws Exception
    {        
        thisSession = new JTextField(8);
        thisSession.setEditable(false);        
        thisWeek = new JTextField(8);
        thisWeek.setEditable(false);
        totalTime = new JTextField(8);
        totalTime.setEditable(false);
        btStartStop = new JButton("Start");        
        logArea = new JTextArea();
        btLogSave = new JButton("Save");
        btLogCancel = new JButton("Cancel");
        
        fLog = new JFrame("Book Clock Log");
        JPanel jpla = new JPanel(new FlowLayout());
        jpla.add(btLogSave);
        jpla.add(btLogCancel);
        fLog.getContentPane().add(BorderLayout.CENTER,logArea);
        fLog.getContentPane().add(BorderLayout.SOUTH,jpla);        
        fLog.setBounds(10,10,640,480); 
                
        dataFileName = args[0];
        loadData();
        
        BookClockButtons bh = new BookClockButtons();
        btStartStop.addActionListener(bh);    
        btLogSave.addActionListener(bh);
        btLogCancel.addActionListener(bh);
        
        JPanel ja = new JPanel(new FlowLayout());
        ja.add(new JLabel("Total: "));
        ja.add(totalTime);
        ja.add(new JLabel("    This week: "));
        ja.add(thisWeek);
        
        JPanel jb = new JPanel(new FlowLayout());
        jb.add(btStartStop);
        jb.add(thisSession);        
        
        JFrame jf = new JFrame("Book Clock");
        jf.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        jf.setResizable(false);
        jf.getContentPane().add(BorderLayout.NORTH,ja);
        jf.getContentPane().add(BorderLayout.SOUTH,jb);
        jf.pack();
        jf.setVisible(true);
    }
    
    static String secondsToString(int seconds) {
        int secs = seconds % 60;
        int minutes = (seconds/60)%60;
        int hours = (seconds/60/60);
        
        String secss = ""+secs;
        String minutess = ""+minutes;
        String hourss = ""+hours;        
        if(secss.length()<2) secss="0"+secss;
        if(minutess.length()<2) minutess="0"+minutess;
        if(hourss.length()<2) hourss="0"+hourss;        
        return hourss+":"+minutess+":"+secss;
    }
    
    static void loadData() throws IOException, ParseException
    {        
        // Week starts Sunday morning 12:00AM
        Calendar c = Calendar.getInstance();
        c.set(Calendar.DAY_OF_WEEK,Calendar.SUNDAY);
        c.set(Calendar.HOUR,0);
        c.set(Calendar.MINUTE,0);
        c.set(Calendar.SECOND,0);
        c.set(Calendar.MILLISECOND,0);
        Date weekstart = c.getTime();  
      
        Reader f = new FileReader(dataFileName);
        BufferedReader br = new BufferedReader(f);
        int total = 0;
        int week = 0;
        while(true) {
            String g = br.readLine();
            if(g==null) break;
            g = g.trim();
            if(!g.startsWith("+++")) continue;            
            int i = g.indexOf(" ");
            String secs = g.substring(3,i);
            int s = Integer.parseInt(secs);
            total = total + s;
            String da = g.substring(i).trim();     
            Date dd = new Date(da);
            if(!dd.before(weekstart)) {
                week=week+s;
            }
        }
        
        thisWeek.setText(secondsToString(week));
        totalTime.setText(secondsToString(total));         
        br.close();        
    }    
}
