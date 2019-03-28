
import java.io.*;

public class Data
{

public static void main(String [] args) throws Exception
{


InputStream is = new FileInputStream("asteroid.bin");
OutputStream osa = new FileOutputStream("asteroid_a.bin");
OutputStream osb = new FileOutputStream("asteroid_b.bin");

byte [] bb = new byte[4096];
is.read(bb);
osa.write(bb);
osa.flush();
is.read(bb);
osb.write(bb);
osb.flush();
osa.close();
osb.close();


}



}