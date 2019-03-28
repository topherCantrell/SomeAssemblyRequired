package preprocessor; 

import java.io.*;
import java.util.*;

public class Processor
{
    
    public static void main(List code) throws Exception 
    {       
        for(int x=0;x<code.size();++x) {      
            Line a = (Line)code.get(x);            
            if(a.assemOpcode!=null && a.assemOpcode.equals(".PROCESSOR")) {                  
                String proc = a.assemOperand;
                boolean b = BlendConfig.reInit(proc);
                if(!b) {
                    throw new RuntimeException("Unknown processor: "+proc);
                }                
                return;
            }
        }
    }
    
}
