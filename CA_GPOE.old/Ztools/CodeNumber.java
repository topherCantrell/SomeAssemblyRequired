
import java.io.*;
import java.util.*;

public class CodeNumber {

public static void main(String [] args) throws Exception {

List lines = new ArrayList();
FileReader fr = new FileReader(args[0]);
BufferedReader br = new BufferedReader(fr);

int longestLine = 0;

while(true) {
String g = br.readLine();
if(g==null) break;
lines.add(g);
}

int max = Integer.toString(lines.size()).length();

int ln = 1;

for(int x=0;x<lines.size();++x) {
String a = Integer.toString(ln++);
while(a.length()<max) a=" "+a;

String tp =a+": "+lines.get(x);

System.out.println(tp);

if(tp.length()>longestLine) longestLine = tp.length();

}

System.out.println("Longest Line: "+longestLine);


}

}