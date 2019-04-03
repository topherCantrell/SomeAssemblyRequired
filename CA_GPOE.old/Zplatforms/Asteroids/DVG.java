
class DVG {
    
    int maxStackSize = 4;
        
    int triggerAddress;
    int memoryStart;
    int memorySize;
    
    int [] stack;
      
    boolean portrait = false;      
    boolean vg_print = false;
    
    int vector_mem_offset;
    
    static final int DVCTR = 0x01;
    static final int DLABS = 0x0a;
    static final int DHALT = 0x0b;
    static final int DJSRL = 0x0c;
    static final int DRTSL = 0x0d;
    static final int DJMPL = 0x0e;
    static final int DSVEC = 0x0f;    
    
    int [] memory;
    
    DVG(int memoryStart, int memorySize)
    {
        this.memoryStart = memoryStart;
        this.memorySize = memorySize;
        memory = new int[memorySize/2];
        stack  = new int[maxStackSize];
    }
    
    public int getValue(int address)
    {
        return memory[address - memoryStart];
    }
    
    public void setValue(int address, int value)
    {
        memory[address-memoryStart] = (byte)value;
    }
    
    public void reset()
    {
        // Clear the screen?
    }
    
    public boolean isMe(int address)
    {
        if(address==triggerAddress) return true;
        if(address<memoryStart) return false;
        if(address>=(memoryStart+memorySize)) return false;
        return true;
    }
    
    int memrdwd(int pc)
    { 
        pc = pc * 2;
        int a = memory[pc];
        if(a<0) a = a + 256;
        int b = memory[pc+1];
        if(b<0) b = b + 256;
        return a + b * 256;        
    }
    
    void draw_line(int oldx, int oldy, int currentx, int currenty, int color, int z)
    {
        // Just add to the list of lines that will be drawn with paint()
    }
    
    void printf(String s) {
        System.out.print(s);
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
        
        boolean done = false;
        
        int firstwd, secondwd = 0;
        int opcode;
        
        int x, y;
        int z;
        int temp;
        int a;
        
        int oldx, oldy;
        int deltax, deltay;
        
        
        int pc = 0;
        int sp = 0;
        int scale = 0;
        
        int currentx,currenty;
        int statz = 0;
        
        if (portrait) {
            currentx = 1023 * 8192;
            currenty = 512 * 8192;
        } else {
            currentx = 512 * 8192;
            currenty = 1023 * 8192;
        }

        
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
            } else {
                if (vg_print) {
                    printf("      ");
                }
            }
            
            if (vg_print) {
                printf(dvg_mnem [opcode]+" ");
            }
            
            switch (opcode) {
                case 0:                    
                    printf("Unknown DVG opcode: 0");
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
                    if ((firstwd & 0x0400)!=0)
                        y = -y;
                    x = secondwd & 0x03ff;
                    if ((secondwd & 0x400)!=0)
                        x = -x;
                    z = secondwd >> 12;
                    
                    if (vg_print) {
                        //printf("(%d,%d) z: %d scal: %d", x, y, z, opcode);
                    }
                    
                    oldx = currentx; oldy = currenty;
                    temp = (scale + opcode) & 0x0f;
                    if (temp > 9)
                        temp = -1;
                    deltax = (x << 21) >> (30 - temp);
                    deltay = (y << 21) >> (30 - temp);
                    currentx += deltax;
                    currenty -= deltay;                    
                    draw_line(oldx, oldy, currentx, currenty, 7, z);
                    break;
                    
                case DLABS:
                    x = twos_comp_val(secondwd, 12);
                    y = twos_comp_val(firstwd, 12);
                    scale = secondwd >> 12;
                    currentx = x;
                    currenty = (896 - y);
                    
                    if (vg_print) {
                        //printf("(%d,%d) scal: %d", x, y, secondwd >> 12);
                    }
                    
                    break;
                    
                case DHALT:
                    
                    if (vg_print)
                        if ((firstwd & 0x0fff) != 0) {
                            //printf("(%d?)", firstwd & 0x0fff);
                        }
                    
                    done = true;
                    break;
                    
                case DJSRL:
                    a = firstwd & 0x0fff;
                    
                    if (vg_print) {
                        //printf("%4x", map_addr(a));
                    }
                    
                    stack [sp] = pc;
                    if (sp == (maxStackSize - 1)) {
                        //printf("\n*** Vector generator stack overflow! ***\n");
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
                           // printf("(%d?)", firstwd & 0x0fff);
                        }
                    
                    if (sp == 0) {
                        //printf("\n*** Vector generator stack underflow! ***\n");
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
                        //printf("%4x", map_addr(a));
                    }
                    
                    pc = a;
                    break;
                    
                case DSVEC:
                    y = firstwd & 0x0300;
                    if ( (firstwd & 0x0400)!=0)
                        y = -y;
                    x = (firstwd & 0x03) << 8;
                    if ( (firstwd & 0x04)!=0)
                        x = -x;
                    z = (firstwd >> 4) & 0x0f;
                    temp = 2 + ((firstwd >> 2) & 0x02) + ((firstwd >> 11) & 0x01);
                    
                    if (vg_print) {
                        //printf("(%d,%d) z: %d scal: %d", x, y, z, temp);
                    }
                    
                    oldx = currentx; oldy = currenty;
                    temp = (scale + temp) & 0x0f;
                    if (temp > 9)
                        temp = -1;
                    deltax = (x << 21) >> (30 - temp);
                    deltay = (y << 21) >> (30 - temp);
                    currentx += deltax;
                    currenty -= deltay;                    
                    draw_line(oldx, oldy, currentx, currenty, 7, z);
                    break;
                    
                default:
                    //fprintf(stderr, "internal error\n");
                    done = true;
            }
            
            if (vg_print) {
                //printf("\n");
            }
            
        }
        
    }
    
}