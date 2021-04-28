
import java.io.*;

public class Build
{
    
    public static boolean buildCommand(String command) throws Exception {
        boolean ret = true;
        //System.out.println(command);
        String bc = command.substring(14).trim();
        System.out.println("-- Executing '"+bc);
        
        Process p = Runtime.getRuntime().exec(bc);
        InputStream is = p.getInputStream();
        InputStreamReader isr = new InputStreamReader(is);
        BufferedReader br=new BufferedReader(isr);
        InputStream eis = p.getErrorStream();
        InputStreamReader eisr = new InputStreamReader(eis);
        BufferedReader ebr = new BufferedReader(eisr);
        StringBuffer sb=new StringBuffer();
        while(true) {
            String g = br.readLine();
            if(g==null) break;
            sb.append(g);
            sb.append("\n");
        }
        System.out.println(sb.toString());
        sb=new StringBuffer();
        boolean errorDetect = false;
        while(true) {
            String g = ebr.readLine();
            if(g==null) break;
            errorDetect=true;
            sb.append(g);
            sb.append("\n");
        }
        System.out.println(sb.toString());
        if(errorDetect) {
            System.out.println("# ERROR DETECTED. Aborting build.\n");
            ret = false;
        }
    
        System.out.println("-- Done with '"+bc);
        System.out.println();
    
        return ret;
    }
    
    public static void main(String [] args) throws Exception
    {
        
        Reader r = new FileReader(args[0]);
        BufferedReader br = new BufferedReader(r);
        while(true) {
            String g = br.readLine();
            if(g==null) break;
            g=g.trim();
            if(g.startsWith(";")) {
                g=g.substring(1).trim();
            }
            if(g.startsWith("build-command ")) {
                boolean b = buildCommand(g);
                if(!b) break;
            }
        }
        
    }
    
}