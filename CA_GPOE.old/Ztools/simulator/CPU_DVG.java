package simulator;

import org.w3c.dom.*;

import java.awt.*;
import java.awt.event.*;
import javax.swing.*;
import java.util.*;

class CPU_DVG extends JPanel implements Hardware {
    
    static class LineInfo
    {
        public long x0,y0,x1,y1;
        public int brightness;
        Color color;
        
        LineInfo(long x0, long y0, long x1, long y1, int brightness, Color color)
        {            
            this.x0 = x0;
            this.y0 = y0;
            this.x1 = x1;
            this.y1 = y1;
            this.brightness = brightness;
            this.color = color;
        }
    }
    
    CPU cpu;
    
    ArrayList displayLineList;
    
    String frameTitle = "CPU_DVG";
    int maxStackSize = 4;
    boolean vg_print = false;
    int triggerAddress;
    int mapTo;    
    int displayWidth;
    int displayHeight;
    int rotate;
    boolean flipX;
    boolean flipY;
    int xOffset;
    int yOffset;
    
    int [] stack;
        
    static final int DVCTR = 0x01; // 1-9
    static final int DLABS = 0x0a;
    static final int DHALT = 0x0b;
    static final int DJSRL = 0x0c;
    static final int DRTSL = 0x0d;
    static final int DJMPL = 0x0e;
    static final int DSVEC = 0x0f;
    
    int [] memory;
    
    CPU_DVG() {       
    }
    
    public String getFrameTitle() {
        return frameTitle;
    }
    
    public void loadXML(CPU cpu, Node n) {
        this.cpu = cpu;
        displayLineList = new ArrayList();
        
        NamedNodeMap att = n.getAttributes();
        Node attr = att.getNamedItem("maxStackSize");
        if(attr!=null) {
            maxStackSize = CPU.parseInt(attr.getNodeValue());
        }
        attr = att.getNamedItem("frameTitle");
        if(attr!=null) {
            frameTitle = attr.getNodeValue();
        }
        attr = att.getNamedItem("flipX");
        if(attr!=null) {
            if(attr.getNodeValue().equals("true")) {
                flipX = true;
            }
        }
        attr = att.getNamedItem("flipY");
        if(attr!=null) {
            if(attr.getNodeValue().equals("true")) {
                flipY = true;
            }
        }
        attr = att.getNamedItem("rotate");
        if(attr!=null) {
            rotate = CPU.parseInt(attr.getNodeValue());            
        }
        attr = att.getNamedItem("xOffset");
        if(attr!=null) {
            xOffset = CPU.parseInt(attr.getNodeValue());            
        }
        attr = att.getNamedItem("yOffset");
        if(attr!=null) {
            yOffset = CPU.parseInt(attr.getNodeValue());            
        }
        attr = att.getNamedItem("tracePrint");
        if(attr!=null) {
            if(attr.getNodeValue().equals("true")) {
                vg_print = true;
            }
        }
        
        attr = att.getNamedItem("triggerAddress");
        triggerAddress = CPU.parseInt(attr.getNodeValue());
        
        attr = att.getNamedItem("mapTo");
        mapTo = CPU.parseInt(attr.getNodeValue());
                
        attr = att.getNamedItem("width");
        displayWidth = CPU.parseInt(attr.getNodeValue());
        
        attr = att.getNamedItem("height");
        displayHeight = CPU.parseInt(attr.getNodeValue());
                
        stack  = new int[maxStackSize];
        
        if(rotate==1 || rotate==3) {
            setPreferredSize(new Dimension(displayHeight,displayWidth));
        } else {
            setPreferredSize(new Dimension(displayWidth,displayHeight));
        }
    }
    
    public int getValue(int address, boolean internalAccess) {
        return 0; // We read data from other places ...
    }
    
    public void setValue(int address, int value, boolean internalAccess) {
        if(address == triggerAddress) {
            //System.out.println("TRIGGER");
            dvg_draw_vector_list();
            updateUI(); // Force a redraw
        } 
    }
    
    public void reset() {
        // Clear the screen
        displayLineList.clear();
        updateUI();
    }
    
    public boolean isMe(int address) {
        if(address==triggerAddress) return true;
        return false;
    }
    
    int memrdwd(int pc) {
        pc = pc * 2;
        int a = cpu.getMemoryValue(pc + mapTo,false);
        if(a<0) a = a + 256;
        int b = cpu.getMemoryValue(pc + mapTo + 1,false);
        if(b<0) b = b + 256;
        return a + b * 256;
    }
    
    void draw_line(long oldx, long oldy, long currentx, long currenty, int color, int brightness) {
        // Just add to the displayLineList
        if(brightness==0) return; 
        
        oldx+=(xOffset<<16);
        currentx+=(xOffset<<16);
        oldy+=(yOffset<<16);
        currenty+=(yOffset<<16);
        
        if(flipY) {
            oldy = (displayHeight<<16)-oldy;
            currenty = (displayHeight<<16)-currenty;
        }
        if(flipX) {
            oldx = (displayWidth<<16)-oldx;
            currentx = (displayWidth<<16)-currentx;
        }
        
        long a=oldx;
        long b=oldy;
        long c=currentx;
        long d=currenty;
        
        if(rotate==1) {
            oldx = (displayHeight<<16)-b;
            oldy = a;
            currentx = (displayHeight<<16)-d;
            currenty = c;
        } else if(rotate==2) {
            oldx = (displayWidth<<16)-a;
            oldy = (displayHeight<<16)-b;
            currentx = (displayWidth<<16)-c;
            currenty = (displayHeight<<16)-d;            
        } else if(rotate==3) {            
            oldx=b;
            oldy=(displayWidth<<16)-a;
            currentx=d;
            currenty=(displayWidth<<16)-c;               
        }
                 
        //System.out.print(" Line: "+(oldx>>16)+","+(oldy>>16)+" - "+(currentx>>16)+","+(currenty>>16));
        LineInfo li = new LineInfo(oldx,oldy,currentx,currenty,brightness,Color.blue);
        displayLineList.add(li);
    }
    
    void printf(String s) {
        System.out.print(s);
    }
    
    public void paint(Graphics g) {
        // Run the list of lines
        super.paint(g);
        
        int si = displayLineList.size();
        for(int x=0;x<si;++x) {
            LineInfo li = (LineInfo)displayLineList.get(x);
            int x0 = (int)(li.x0>>16);
            int y0 = (int)(li.y0>>16);
            int x1 = (int)(li.x1>>16);
            int y1 = (int)(li.y1>>16);         
            g.drawLine(x0,y0,x1,y1);
        }
    }
        
    int twos_comp_val(int val, int bits) {
        if(bits!=12) throw new RuntimeException("Not 12");
        val = val & 0x0FFF; // 12 bits
        if(val>=0x0800) {
            val = val - 0x1000;
        }
        return val;
    }
    
    static final String dvg_mnem[] = {
        "????", "vct1", "vct2", "vct3",
        "vct4", "vct5", "vct6", "vct7",
        "vct8", "vct9", "labs", "halt",
        "jsrl", "rtsl", "jmpl", "svec"
    };
    
    public void dvg_draw_vector_list() {
        
        displayLineList.clear();
        
        boolean done = false;
        
        int firstwd, secondwd = 0;
        int opcode;
        
        long x, y;        
        int z;
        int temp;
        int a;
        
        long oldx, oldy, deltax, deltay;        
        
        int pc = 0;
        int sp = 0;
        int scale = 0;
        
        long currentx,currenty;
                
        // Rotates and flips
        currentx = (displayWidth-1) << 16;
        currenty = (displayHeight) << 16;        
        
        while (!done) {
            firstwd = memrdwd(pc);
            opcode = firstwd >> 12;
            if (vg_print) {
                printf(Integer.toString(pc,16)+" "+Integer.toString(firstwd,16)+" ");
            }
            pc++;
            if ((opcode >= 0 /* DVCTR */) && (opcode <= DLABS)) {
                secondwd = memrdwd(pc);
                pc++;
                if (vg_print) {
                    printf(Integer.toString(secondwd,16)+" ");
                }
            } 
            
            if (vg_print) {
                printf(dvg_mnem[opcode]+" ");
            }
            
            switch (opcode) {
                case 0:
                    printf("*** Unknown DVG opcode: 0\r\n");
                    done = true;
                    break;
                    
                case 1:
                case 2:
                case 3:
                case 4:
                case 5:
                case 6:
                case 7:
                case 8:
                case 9:
                    y = firstwd & 0x03ff;
                    if ((firstwd & 0x0400)!=0) {
                        y = -y;
                    }
                    x = secondwd & 0x03ff;
                    if ((secondwd & 0x400)!=0) {
                        x = -x;
                    }
                    z = secondwd >> 12;
                    
                    if (vg_print) {
                        printf("("+x+","+y+") brightness:"+z+" scale-offset: "+opcode);
                    }
                    
                    oldx = currentx; oldy = currenty;
                    temp = (scale + opcode) & 0x0f;
                    if (temp > 9) {
                        temp = -1;
                    }
                    deltax = (x << 16) >> (9 - temp);
                    deltay = (y << 16) >> (9 - temp);
                    currentx += deltax;
                    currenty += deltay;
                    draw_line(oldx, oldy, currentx, currenty, 7, z);
                    break;
                    
                case DLABS:
                    x = twos_comp_val(secondwd, 12);
                    y = twos_comp_val(firstwd, 12);
                    scale = secondwd >> 12;                    
                    
                    if (vg_print) {
                         printf("("+x+","+y+") scale:"+scale);                        
                    }

                    currentx = x<<16;
                    currenty = y<<16;
                    
                    break;
                    
                case DHALT:
                    
                    if (vg_print)
                        if ((firstwd & 0x0fff) != 0) {
                            printf(" DHALT param not 0!");
                        }
                    
                    done = true;
                    break;
                    
                case DJSRL:
                    a = firstwd & 0x0fff;
                    
                    if (vg_print) {
                        printf(" destination word address: " + Integer.toString(a,16));
                    }
                    
                    stack [sp] = pc;
                    if (sp == (maxStackSize - 1)) {
                        printf("*** Vector generator stack overflow! ***\r\n");
                        done = true;
                        sp = 0;
                    }
                    else
                        sp++;
                    pc = a;
                    break;
                    
                case DRTSL:
                    
                    if (vg_print)
                        if ((firstwd & 0x0fff) != 0) {
                            printf(" DRSTL param not 0!");
                        }
                    
                    if (sp == 0) {
                        printf("*** Vector generator stack underflow! ***\r\n");
                        done = true;
                        sp = maxStackSize - 1;
                    }
                    else
                        sp--;
                    pc = stack [sp];
                    break;
                    
                case DJMPL:
                    a = firstwd & 0x0fff;
                    
                    if (vg_print) {
                         printf(" destination word address: " + Integer.toString(a,16));
                    }
                    
                    pc = a;
                    break;
                    
                case DSVEC:
                    y = firstwd & 0x0300;
                    if ( (firstwd & 0x0400)!=0) {
                        y = -y;
                    }
                    x = (firstwd & 0x03) << 8;
                    if ( (firstwd & 0x04)!=0) {
                        x = -x;
                    }
                    z = (firstwd >> 4) & 0x0f;
                    temp = 2 + ((firstwd >> 2) & 0x02) + ((firstwd >> 11) & 0x01);
                    
                    if (vg_print) {
                        printf("("+x+","+y+") brightness:"+z+" vect: "+temp);                        
                    }
                    
                    oldx = currentx; oldy = currenty;
                    temp = (scale + temp) & 0x0f;
                    if (temp > 9)
                        temp = -1;
                    deltax = (x << 16) >> (9 - temp);
                    deltay = (y << 16) >> (9 - temp);
                    currentx += deltax;
                    currenty += deltay;
                    draw_line(oldx, oldy, currentx, currenty, 7, z);
                    break;
                    
                default:
                    printf("*** Internal error!\r\n");
                    done = true;
            }
            
            if (vg_print) {
                printf("\n");
            }
            
        }

        
    }
    
    public boolean isMemoryMapped() {
        return true;
    }
    
}
