import java.io.*;

public class PakReader {


public static void main(String [] args) throws Exception 
{

FileInputStream fis=new FileInputStream(args[0]);
FileOutputStream fos = new FileOutputStream(args[1]);
fis.skip(0x304);
for(int x=0;x<0x3BB8;++x) {
fos.write(fis.read());
}

fos.flush();

}


}