package simulator;

import javax.swing.*;
import java.awt.*;
import java.awt.event.*;
import java.util.*;
import java.io.*;
import javax.xml.parsers.*;
import org.w3c.dom.*;

// TOPHER TO DO
// Ability to put a symbol in the PC and let it resolve it

public class CPU extends JPanel
{
    
    String title;
    
    RegisterViewer registerViewer;
    Simulator simulator;
    MemoryViewer memoryViewer;
    ListingViewer listingViewer;
    
    String loadFile;
    
    static int base=10; 
    boolean runButtonVisible = true;
    String windowLayout="separate"; // or "single"
    boolean strictMemoryDecode;
    int memoryViewerPageSize = 16;
    
    Ghost [] ghost;    
    Hardware [] hardware;
    
    java.util.List tickWatchers;
    long totalTicks = 0;

    JButton btRun;
    JButton btStep;
    JButton btReset;
    
    CPURunner cpuRunner;
    
    boolean afterInit;
    
    int numBreakPoints;
    
    int [] softwareBreakPoints;
    int [] hardwareBreakPointsRead;
    int [] hardwareBreakPointsWrite;
    
    static JFrame rootWindow;    

    public static int getDisplayBase()
    {
      return base; 
    }
    
    public static int parseInt(String s)
    {
        int base = 10;
        if(s.startsWith("0x")) {
            base = 16;
            s = s.substring(2);
        } else if(s.startsWith("0b")) {
            base = 2;
            s = s.substring(2);
        } else if(s.startsWith("0o")) {
            base = 8;
            s = s.substring(2);
        }
        return Integer.parseInt(s,base);
    }
    
    public void makeHardwareGUIs() {
        if(windowLayout.equals("separate")) {
            int frameCornerOffset = rootWindow.getBounds().y;
            for(int x=0;x<hardware.length;++x) {
                if(hardware[x] instanceof JPanel) {
                    JFrame hf = new JFrame(hardware[x].getFrameTitle());                    
                    hf.setDefaultCloseOperation(JFrame.DISPOSE_ON_CLOSE);
                    hf.getContentPane().add(BorderLayout.CENTER,(JPanel)hardware[x]);
                    Rectangle r = rootWindow.getBounds();
                    hf.setLocation(r.x+r.width,frameCornerOffset);
                    hf.pack();
                    hf.setVisible(true);
                    frameCornerOffset=frameCornerOffset+hf.getHeight();
                }
            }
        } else {
            int mw = 0;
            JPanel hwp = new JPanel(new FlowLayout());
            for(int x=0;x<hardware.length;++x) {
                if(hardware[x] instanceof JPanel) {                    
                    JPanel hp = (JPanel)hardware[x];                    
                    hp.setBorder(BorderFactory.createTitledBorder(hardware[x].getFrameTitle()));
                    hwp.add(hp);     
                    int w = hp.getPreferredSize().width;
                    if(w>mw) mw=w;
                }
            }
            hwp.setPreferredSize(new Dimension(mw+8,10));
            add(BorderLayout.EAST,hwp);
        }
    }
    
    public int getMemoryValue(int address, boolean internalAccess)
    {
        // First look for ghosting
        for(int x=0;x<ghost.length;++x) {            
            if(address>=ghost[x].address && 
               address<(ghost[x].address+ghost[x].size)) {
              address = address - ghost[x].address + ghost[x].ghostTo;
              break;
            }
             
        }
        
        for(int x=0;x<hardwareBreakPointsRead.length;++x) {
            if(hardwareBreakPointsRead[x]==address) {
                simulator.hardwareBreakPointHit(address,false);
            }
        }
        
        // TOPHER ... check for address conflicts at startup         
        
        for(int x=0;x<hardware.length;++x) {
            if(hardware[x].isMe(address)) {
                //System.out.println(":"+hardware[x]);
              int ret= hardware[x].getValue(address,internalAccess);
              if(ret<0) ret=ret+256;
              return ret;
            }
        }
        
        if(strictMemoryDecode) {
            System.out.println("No hardware mapped to read address: "+Integer.toString(address,16));
        }
        return 0; // We won't complain
    }
    
    public void setMemoryBlock(int address, byte [] value, boolean internalAccess)
    {  
        
        for(int x=0;x<hardware.length;++x) {
            if(hardware[x].isMe(address)) {
              for(int y=0;y<value.length;++y) {
                  hardware[x].setValue(address+y,value[y],internalAccess);
              }  
              return;
            }
        }        
    }

    public void setMemoryValue(int address, int value,boolean internalAccess)
    {        
        // First look for ghosting
        for(int x=0;x<ghost.length;++x) {            
            if(address>=ghost[x].address && 
               address<(ghost[x].address+ghost[x].size)) {
              address = address - ghost[x].address + ghost[x].ghostTo;
              break;
            }             
        }
        
        for(int x=0;x<hardwareBreakPointsWrite.length;++x) {
            if(hardwareBreakPointsWrite[x]==address) {
                simulator.hardwareBreakPointHit(address,true);                
            }
        }
        
        //System.out.println(":"+address+":"+value);
        for(int x=0;x<hardware.length;++x) {
            if(hardware[x].isMe(address)) {
              hardware[x].setValue(address,value,internalAccess);
              return;
            }
        }  
        
        if(strictMemoryDecode) {
            System.out.println("No hardware mapped to wrtie address: "+Integer.toString(address,16));
        }
    }
    
    public CPU(Node n, String loadFile) throws IOException
    {
        super(new BorderLayout());     
        
        JPanel jpan = new JPanel(new BorderLayout());
        
        this.loadFile = loadFile;
        
        tickWatchers = new ArrayList();
        
        loadXML(n);
        
        hardwareBreakPointsRead = new int[numBreakPoints];
        hardwareBreakPointsWrite = new int[numBreakPoints];
        softwareBreakPoints = new int[numBreakPoints];
        for(int x=0;x<hardwareBreakPointsRead.length;++x) {
            hardwareBreakPointsRead[x] = -1;
            hardwareBreakPointsWrite[x] = -1;
            softwareBreakPoints[x] = -1;
        }
        
        JPanel ja = new JPanel(new BorderLayout());
        
        if(simulator==null) {
            registerViewer = null;
        }
        
        if(registerViewer!=null) {
            ja.add(BorderLayout.WEST,registerViewer);
        } 
        
        CPUButtonHandler cbh = new CPUButtonHandler();

        JPanel jb = new JPanel(new FlowLayout());
        btRun = new JButton("Run");
        btRun.setVisible(runButtonVisible);
        btRun.addActionListener(cbh);
        btStep = new JButton("Step");
        btStep.addActionListener(cbh);
        btReset = new JButton("Reset");
        btReset.addActionListener(cbh);
        
        if(simulator==null) {
            btStep.setVisible(false);
            btReset.setVisible(false);
            btStep.setVisible(false);
            btRun.setVisible(false);
        }       

        jb.add(btRun);
        jb.add(btStep);
        jb.add(btReset);        
        
        JPanel jpBreaks = new JPanel(new GridLayout(numBreakPoints,1));
        for(int x=0;x<numBreakPoints;++x) {
            JPanel bpPan = new JPanel(new BorderLayout());
            JCheckBox cb = new JCheckBox();
            bpPan.add(BorderLayout.WEST,cb);
            JTextField tf = new JTextField(8);
            bpPan.add(BorderLayout.CENTER,tf);
            JPanel bpPan2 = new JPanel(new GridLayout(1,3));
            bpPan2.add(new JCheckBox("X:"));
            bpPan2.add(new JCheckBox("R:"));
            bpPan2.add(new JCheckBox("W:"));
            bpPan.add(BorderLayout.EAST,bpPan2);
            jpBreaks.add(bpPan);
        }
        
        JPanel jpBreaksWrap = new BreakPointViewer(this);
        if(numBreakPoints==0) jpBreaksWrap.setVisible(false);
        
        JPanel jaa= new JPanel(new BorderLayout());
        jaa.add(BorderLayout.NORTH,ja);
        jaa.add(BorderLayout.SOUTH,jpBreaksWrap);

        ja.add(BorderLayout.SOUTH,jb);

        jpan.add(BorderLayout.NORTH,jaa);
        
        memoryViewer = new MemoryViewer(this);
        ja.add(BorderLayout.CENTER,memoryViewer);        

        listingViewer = new ListingViewer(this);
        jpan.add(BorderLayout.CENTER,listingViewer);

        listingViewer.setVisible(false);
        
        if(loadFile!=null) {
            FileReader fr = new FileReader(loadFile);
            if(loadFile.endsWith(".lst")) {
                //listingViewer.load(loadFile,fr);
                // loading will happen in RESET
                listingViewer.setVisible(true);
            } else {
                throw new RuntimeException("Unimplemented loadfile type: "+loadFile);
            }
        }
        
        afterInit = true;
        
        add(BorderLayout.CENTER,jpan);
        
    }
    
    void addTickWatcher(TickNotice watcher)
    {
        tickWatchers.add(watcher);
    }
    
    void removeTickWatcher(TickNotice watcher)
    {
        tickWatchers.remove(watcher);
    }
    
    void doSystemTick(int numberTicks)
    {
        totalTicks += numberTicks;
        for(int x=0;x<tickWatchers.size();++x) {
            TickNotice tn = (TickNotice)tickWatchers.get(x);
            tn.systemTick(numberTicks,totalTicks);
        }
    }
            
    void loadXML(Node n)
    {
            
        NamedNodeMap att = n.getAttributes();
        Node attr = att.getNamedItem("title");
        title = attr.getNodeValue();
        attr = att.getNamedItem("base");
        base = CPU.parseInt(attr.getNodeValue());
        
        ArrayList memList = new ArrayList();
        ArrayList hardList = new ArrayList();
        ArrayList ghostList = new ArrayList();
        
        ClassLoader loader = CPU.class.getClassLoader();
        
        try {
            NodeList o = n.getChildNodes();
            for(int x=0;x<o.getLength();++x) {
                Node oo = o.item(x);
                if(oo.getNodeType()!=Node.ELEMENT_NODE) continue;
                String on = oo.getNodeName();
                if(on.equals("RegisterViewer")) {
                    if(simulator!=null) {
                        registerViewer = new RegisterViewer(oo,this); 
                    }
                } else if(on.equals("Controls")) {
                    att = oo.getAttributes();
                    attr = att.getNamedItem("runButtonVisible");       
                    String aa = attr.getNodeValue().trim();
                    runButtonVisible = aa.equals("true");                            
                    attr = att.getNamedItem("memoryViewerPageSize");  
                    if(attr!=null) {
                        memoryViewerPageSize = CPU.parseInt(attr.getNodeValue());
                    }
                    attr = att.getNamedItem("strictMemoryDecode");  
                    strictMemoryDecode = false;
                    if(attr!=null) {
                        if(attr.getNodeValue().equals("true")) {
                            strictMemoryDecode = true;
                        }                   
                    }
                    attr = att.getNamedItem("breakPoints");  
                    numBreakPoints = 0;
                    if(attr!=null) {
                        numBreakPoints = CPU.parseInt(attr.getNodeValue());
                    }
                    attr = att.getNamedItem("windowLayout");       
                    aa = attr.getNodeValue();
                    if(aa==null) {
                        windowLayout = "separate";
                    } else {
                        windowLayout = aa.trim();
                    }                    
                } else if(on.equals("Simulator")) {
                    att = oo.getAttributes();
                    attr = att.getNamedItem("class");
                    String cna = attr.getNodeValue().trim();
                    Class a = (Class)loader.loadClass(cna);
                    simulator = (Simulator)a.newInstance();                    
                    simulator.loadXML(this,oo);                    
                } else if(on.equals("Hardware") || on.equals("Instrument")) {
                    att = oo.getAttributes();
                    attr = att.getNamedItem("class");
                    String cna = attr.getNodeValue().trim();
                    Class a = (Class)loader.loadClass(cna);
                    Hardware hard = (Hardware)a.newInstance();
                    hard.loadXML(this,oo);
                    hardList.add(hard);
                } else if(on.equals("AddressDecodeGhost")) {
                    Ghost gho = new Ghost();
                    att = oo.getAttributes();
                    attr = att.getNamedItem("address");
                    gho.address = CPU.parseInt(attr.getNodeValue());
                    attr = att.getNamedItem("size");
                    gho.size = CPU.parseInt(attr.getNodeValue());
                    attr = att.getNamedItem("ghostTo");
                    gho.ghostTo = CPU.parseInt(attr.getNodeValue());                   
                    ghostList.add(gho);
                }
                
                else {
                    throw new RuntimeException("Unknown node: "+oo);
                }
            }            
        } catch (Exception e) {
            e.printStackTrace();
            throw new RuntimeException(e);
        }        
        
        hardware = new Hardware[hardList.size()];
        ghost = new Ghost[ghostList.size()];        
        for(int x=0;x<hardList.size();++x) {
            hardware[x] = (Hardware)hardList.get(x);
        }
        for(int x=0;x<ghostList.size();++x) {
            ghost[x] = (Ghost)ghostList.get(x);
        }
    }
    
    public static void main(String [] args) throws Exception
    {
        
        String loadFile = null;        
        String cpuFile = "CPU.xml";
        
        for(int x=0;x<args.length;++x) {
            if(args[x].equals("-help")) {                     
                System.out.println("COMMAND LINE OPTIONS: [-help] [-config fname] [list-file-name]");
            } else if(args[x].equals("-config")) {
                x++;
                cpuFile = args[x];
            } else {
                loadFile = args[x];  
            }
        } 
        
        InputStream is = new FileInputStream(cpuFile);
        DocumentBuilderFactory dbf = DocumentBuilderFactory.newInstance();
        DocumentBuilder b = dbf.newDocumentBuilder(); 
        Document d = b.parse(is);
        Element e = d.getDocumentElement();
        
        CPU cpu = new CPU(e,loadFile);
        
        rootWindow = new JFrame(cpu.title);
        rootWindow.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        rootWindow.getContentPane().add(BorderLayout.CENTER,cpu);
        rootWindow.setLocation(100,100);     
        cpu.makeHardwareGUIs();
        rootWindow.pack();        
        rootWindow.setVisible(true);
        
        
        cpu.reset();
    }
    
    void reset() {
        
        try {
            if(loadFile!=null) {
                FileReader fr = new FileReader(loadFile);
                if(loadFile.endsWith(".lst")) {
                    afterInit = false;
                    listingViewer.load(loadFile,fr);
                    afterInit = true;
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
                
        for(int x=0;x<hardware.length;++x) {
            hardware[x].reset();
        }              
        boolean goodShow = true;
        if(simulator!=null) {
            simulator.reset();
            int address = simulator.getRegisterValue("PC");
            goodShow = listingViewer.showAddress(address);
        }
        if(registerViewer!=null) registerViewer.updateAllFields();
        memoryViewer.showAddress();
    }
    
    class CPURunner implements Runnable
    {
        
        boolean running = true;
        
        public void run() {
            while(running) {
                String b = simulator.step();
                if(b!=null) {
                    running = false; 
                    JOptionPane.showMessageDialog(null,b,"Run Error",
                        JOptionPane.ERROR_MESSAGE);                    
                }
            }
                                   
            btRun.setText("Run");
            btStep.setEnabled(true);
            btReset.setEnabled(true);
            listingViewer.setEnabled(true);
            memoryViewer.setEnabled(true);
            if(registerViewer!=null) {
                registerViewer.setEnabled(true);              
                registerViewer.updateAllFields();
            }
            memoryViewer.showAddress(); 
            boolean goodShow = true;
            if(simulator!=null) {
                int address = simulator.getRegisterValue("PC");
                goodShow = listingViewer.showAddress(address); 
            }
            if(!goodShow) {
                System.out.println("NOT FOUND");
                running = false;
            }
        }
        
    }
    
    class CPUButtonHandler implements ActionListener
    {
        
        public void actionPerformed(java.awt.event.ActionEvent actionEvent) {
            Object o = actionEvent.getSource();
            if(o.equals(btStep)) {                
                String b = simulator.step();
                if(b!=null) {                    
                    JOptionPane.showMessageDialog(null,b,"Run Error",
                        JOptionPane.ERROR_MESSAGE);                    
                }
                if(registerViewer!=null) registerViewer.updateAllFields();
                memoryViewer.showAddress(); 
                boolean goodShow = true;
                if(simulator!=null) {
                    int address = simulator.getRegisterValue("PC");
                    goodShow = listingViewer.showAddress(address); 
                }
            } else if(o.equals(btReset)) {                     
                reset();
            } else if(o.equals(btRun)) {
                if(btRun.getText().equals("Stop")) {
                    cpuRunner.running = false;
                } else {
                    cpuRunner = new CPURunner();
                    Thread t = new Thread(cpuRunner);
                    t.start();
                    btRun.setText("Stop");
                    btStep.setEnabled(false);
                    btReset.setEnabled(false);
                    listingViewer.setEnabled(false);
                    memoryViewer.setEnabled(false);
                    if(registerViewer!=null) registerViewer.setEnabled(false);
                }
            } 
        }
        
    }
    
    class Ghost
    {
        int address;
        int size;
        int ghostTo;
    }
    
}
