import java.io.*;
import java.util.*;

class NES
{

public static void main(String [] args) throws Exception
{

InputStream is = new FileInputStream(args[0]);
OutputStream os = new FileOutputStream(args[1]);

byte [] b = new byte[is.available()];
is.read(b);

os.write(b,16,1024*128);
os.flush();

}


}