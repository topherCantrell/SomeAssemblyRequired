import javax.comm.*;
import java.io.*;
import java.util.*;

public class SoundBoard
{
    
    static OutputStream outputStream;
    
    public static int[] readDataFromString(String s)
    {
        StringTokenizer st=new StringTokenizer(s," ,");
        int [] ret = new int[st.countTokens()];
        for(int x=0;x<ret.length;++x) {
            ret[x] = Integer.parseInt(st.nextToken());
        }
        return ret;
    }
    
    public static void main(String [] args) throws Exception 
    {        
        CommPortIdentifier portId = CommPortIdentifier.getPortIdentifier("COM1");
        SerialPort serialPort = (SerialPort) portId.open("SoundBoard", 2000);
        outputStream = serialPort.getOutputStream();
        serialPort.setSerialPortParams(9600,SerialPort.DATABITS_8,SerialPort.STOPBITS_1,SerialPort.PARITY_NONE);
        
        int [] data = null;
        if(args[0].equals("-file")) {
            String s = "";
            FileReader fr = new FileReader(args[1]);
            BufferedReader br=new BufferedReader(fr);
            while(true) {
                String g = br.readLine();
                if(g==null) break;
                if(g.startsWith(";")) continue;
                s=s+g+" ";
            }
            data = readDataFromString(s);
        } else {
            data = new int[args.length];
            for(int x=0;x<args.length;++x)  {
                data[x] = Integer.parseInt(args[x]);
            }
        }
        
        for(int x=0;x<data.length;++x) {            
            outputStream.write(data[x]);
            outputStream.flush();
            Thread.sleep(10);
        }
        
        outputStream.close();
        
    }
    
}
