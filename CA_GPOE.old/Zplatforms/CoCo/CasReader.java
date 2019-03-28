
import java.io.*;

class Block 
{
    int blockType;
    int blockLength;
    byte [] data;
    int checksum;
}

public class CasReader 
{
    
    public static Block readBlock(byte [] data, int start) {
        
        Block ret = new Block();
        
        if(data[start++]!=0x55) {
            //throw new RuntimeException("Expected a 0x55 leader");
        }        
        if(data[start++]!=0x3C) {
            //throw new RuntimeException("Expected a 0x3C sync byte");
        }
        
        ret.blockType = data[start++];        
        if(ret.blockType<0) ret.blockType+=256;
        
        if(ret.blockType==255) return ret;
        
        ret.blockLength = data[start++];
        if(ret.blockLength<0) ret.blockLength+=256;
        
        ret.data = new byte[ret.blockLength];
        int sum = 0;
        for(int x=0;x<ret.blockLength;++x) {
            ret.data[x] = data[start++];
            int a = ret.data[x];
            if(a<0) a+=256;
            sum+=a;
        }
        
        ret.checksum = data[start++];
        if(ret.checksum<0) ret.checksum+=256;
        
        if(data[start]!=0x55) {
            throw new RuntimeException("Expected a 0x55 end byte");
        }
        
        sum=sum&0xFF;
        if(sum!=ret.checksum) {
            //System.out.println(":::"+ret.blockType+":"+ret.blockLength);
            //System.out.println("::"+ret.checksum+":"+sum);
            //throw new RuntimeException("Checksum doesn't match");
        }
        
        return ret;
    }
    
    
    
    public static void main(String [] args) throws Exception {
        
        InputStream is = new FileInputStream(args[0]);
        byte [] b = new byte[is.available()];
        is.read(b);
        is.close();
        
        int p = 0x115;
        
        OutputStream os = new FileOutputStream(args[1]);
              
        while(true) {
            Block bk = readBlock(b,p);
            p = p + bk.blockLength + 6;            
            System.out.println(":"+bk.blockType+":"+bk.blockLength+":");
            if(bk.blockType==255) break;
            os.write(bk.data);
        }
        
        os.flush();
        os.close();
        
        
        
        
        
    }
    
    
    
}
