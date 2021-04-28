
import java.io.*;

public class EpromTool
{
    
    public static void pad(String [] args) throws Exception
    {    
        
        InputStream is = new FileInputStream(args[1]);
        byte [] data = new byte[is.available()];
        is.read(data);
        is.close();
        
        int padTo = Integer.parseInt(args[2]) - data.length;
        int padValue = Integer.parseInt(args[3]); 
        
        FileOutputStream fos = new FileOutputStream(args[4]);
        fos.write(data);
        
        for(int x=0;x<padTo;++x) {
            fos.write(padValue);
        }
        
        fos.flush();
        fos.close();
        
    }
    
    public static void split(String [] args) throws Exception
    {
               
        InputStream is = new FileInputStream(args[1]);
        byte [] data = new byte[is.available()];
        is.read(data);
        is.close();
        
        int numsplits = args.length-2;
        int splitSize = data.length/numsplits;
        
        for(int x=0;x<numsplits;++x) {
            FileOutputStream fos = new FileOutputStream(args[2+x]);
            fos.write(data,x*splitSize,splitSize);
            fos.flush();
            fos.close();
        }
        
    }
    
    public static void main(String [] args) throws Exception
    {
        
        if(args[0].equals("-split")) split(args);
        else if(args[0].equals("-pad")) pad(args);
        
        else {
            System.out.println("UNKNOWN REQUEST: "+args[0]);
        }
        
        
    }
    
}