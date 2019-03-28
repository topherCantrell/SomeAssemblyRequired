import javax.comm.*;
import java.io.*;
import java.util.*;

public class C64
{

    static OutputStream outputStream;

	static int DELAY_SHIFT =   50; // Time between SHIFT code and key code
	static int DELAY_DOWN_UP = 50; // Time between key code and F0 key code
	static int DELAY_F0 =      50; // Time between F0 and key
	static int DELAY_KEYS =    50; // Time between keys

static String [] scanCodes = {

"`0e","~-0e","116","!-16","21e","@-1e","326","#-26","425","$-25","52e","%-2e","636","^-36","73d","&-3d","83e","*-3e",
"946","(-46","045",")-45","-4e","_-4e","+55","=-55","\\5d","|-5d",

"Q15","W1d","E24","R2d","T2c","Y35","U3c","I43","O44","P4d","[54","{-54","]5b","}-5b",

"A1c","S1b","D23","F2b","G34","H33","J3b","K42","L4b",";4c",":-4c","'52","\"-52",

"Z1a","X22","C21","V2a","B32","N31","M3a",",41","<-41",".49",">-49","/4A","?-4a",

" 29",

"\n5a", "\t0d"

};

public static void sendString(String message) throws Exception
{
  int s = message.length();
  String mu = message.toUpperCase();
  for(int x=0;x<s;++x) {
    sendKey(mu.charAt(x));
	Thread.sleep(DELAY_KEYS);
  }
}

public static void sendCode(String s) throws Exception
{
     outputStream.write(s.getBytes());
	 outputStream.write("\n".getBytes());
	 outputStream.flush();	 
}

public static void sendKey(char key) throws Exception
{

   if(key == '\r') return;

   String hv = "0E";
   boolean shift = true;

   for(int x=0;x<scanCodes.length;++x) {
     if(scanCodes[x].charAt(0)==key) {
	   if(scanCodes[x].charAt(1)=='-') {
	     hv = scanCodes[x].substring(2);
		 shift = true;
	   } else {
	     hv = scanCodes[x].substring(1);
		 shift = false;
	   }
	   break;
	 }
   }

   if(shift) {  
     sendCode("12");     
	 Thread.sleep(DELAY_SHIFT);
     sendCode(hv);	 
	 Thread.sleep(DELAY_DOWN_UP);
	 sendCode("F0");	 
	 Thread.sleep(DELAY_F0);
	 sendCode(hv);	 
	 Thread.sleep(DELAY_SHIFT);
	 sendCode("F0");	 
	 Thread.sleep(DELAY_F0);
	 sendCode("12");	      
   } else {
     sendCode(hv);	 
	 Thread.sleep(DELAY_DOWN_UP);
	 sendCode("F0");
	 Thread.sleep(DELAY_F0);
	 sendCode(hv);
   }


}


public static void main(String [] args) throws Exception
{

  CommPortIdentifier portId = CommPortIdentifier.getPortIdentifier("COM1");
  SerialPort serialPort = (SerialPort) portId.open("C64", 2000);
  outputStream = serialPort.getOutputStream();
  serialPort.setSerialPortParams(9600,SerialPort.DATABITS_8,SerialPort.STOPBITS_1,SerialPort.PARITY_NONE);
                  
  System.out.println("Grabbing C64 ...");

  for(int x=0;x<5;++x) {
    sendCode("42");
	Thread.sleep(1000);
  }
  sendKey('K');
  Thread.sleep(1000);

  System.out.println("Processing '"+args[0]+"'");
  InputStream is = new FileInputStream(args[0]);
  byte [] b = new byte[is.available()];
  is.read(b);
  is.close();
  String s = new String(b);
  sendString(s);
}

}