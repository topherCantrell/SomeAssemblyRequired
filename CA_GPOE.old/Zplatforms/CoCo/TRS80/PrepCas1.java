import java.io.*;

public class PrepCas1 
{

public static String padTo(String s, int len)
{
while(s.length()<len) s=s+" ";
return s;
}

public static void main(String [] args) throws Exception
{


FileInputStream fis = new FileInputStream("pyrmd1.bin");
FileOutputStream fos = new FileOutputStream("PyramidMod.bin");

for(int x=0;x<0x2EC5;++x) {
fos.write(fis.read());
}

fis.close();
fis = new FileInputStream("pyrmd.cas");
fis.skip(0x3062);
while(fis.available()>0) {
fos.write(fis.read());
}

fos.flush();
fos.close();




/*
FileInputStream fis = new FileInputStream("pyrmd1.cas");
FileOutputStream fos = new FileOutputStream("pyrmd1.bin");

fis.skip(0x88);

while(fis.available()>0) {
 fos.write(fis.read());
}

fos.flush();

}
*/

/*

FileReader fr = new FileReader("t.txt");
BufferedReader br = new BufferedReader(fr);

while(true) {

  String g = br.readLine();
  if(g==null) break;

  if(g.length()==0 || g.charAt(0)<'4' || g.charAt(0)>'7') {
    System.out.println(g); 
    continue;
  }

  String a = g.substring(0,4).trim();
  String b = g.substring(4,15).trim();
  String c = g.substring(16).trim();

  int i = c.indexOf(";");
  if(i>=0) {
    c = c.substring(0,i).trim();
  }

  String bb = "";
  for(int x=0;x<b.length();x=x+2) {
    bb=bb+b.charAt(x)+b.charAt(x+1)+" ";
  }

System.out.println(a.toUpperCase()+": "+padTo(bb,12).toUpperCase()+padTo(c,24).toUpperCase());



 }
*/

}

}