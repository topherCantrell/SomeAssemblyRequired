import java.io.*;

public class BinaryFind
{


public static void main(String [] args) throws Exception
{


byte [] toFnd = new byte[args.length-1];
for(int x=1;x<args.length;++x) {
toFnd[x-1] = (byte)Integer.parseInt(args[x],16);
}


InputStream is = new FileInputStream(args[0]);
byte [] data = new byte[is.available()];
is.read(data);

for(int x=0;x<data.length-toFnd.length;++x) {
  boolean b = false;
  for(int y=0;y<toFnd.length;++y) {
    if(data[x+y]!=toFnd[y]) {
      b = true;
      break;
    }
  }

  if(!b) {
    System.out.println(Integer.toString(x,16));
  }
}


}

}