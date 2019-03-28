
import java.io.*;

public class DataMine
{


public static void main(String [] args) throws Exception
{

InputStream is = new FileInputStream(args[0]);
byte [] b = new byte[is.available()];
is.read(b);

for(int x=0;x<16*7;++x) {
int a = b[x];
if(a<0) a=a+256;

System.out.print(a+",");

}


}

}