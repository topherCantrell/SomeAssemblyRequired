import java.io.*;
import java.util.*;

public class Zoo
{
    
    static void updatePointer(RandomAccessFile raf, boolean yesPointer, int dataOffset, int newPosition) throws IOException
    {   
        if(newPosition<0 || newPosition>65535) {
            throw new RuntimeException("Invalid pointer position:"+newPosition);
        }
        if(!yesPointer) dataOffset = dataOffset + 2;
        raf.seek(dataOffset);
        int msb = (newPosition>>8) & 0xFF;
        int lsb = (newPosition % 256);
        raf.write(msb);
        raf.write(lsb);        
    }
    
    static int readPointer(RandomAccessFile raf, boolean yesPointer, int dataOffset) throws IOException
    {
        if(!yesPointer) dataOffset = dataOffset + 2;
        raf.seek(dataOffset);
        int msb = raf.read();
        int lsb = raf.read();
        return msb<<8 | lsb;        
    }
    
    static String readText(RandomAccessFile raf, int dataOffset) throws IOException
    {     
        dataOffset = dataOffset + 4;
        raf.seek(dataOffset);      
        StringBuffer sb = new StringBuffer();
        while(true) {
            int a = raf.read();
            if(a==0) break;
            sb.append((char)a);
        }
        return sb.toString();
    }
    
    static void appendText(RandomAccessFile raf, String text, int yesInitial, int noInitial) throws IOException
    {
        if(yesInitial<0 || yesInitial>65535) {
            throw new RuntimeException("Invalid yes pointer position:"+yesInitial);
        }
        if(noInitial<0 || noInitial>65535) {
            throw new RuntimeException("Invalid no pointer position:"+noInitial);
        }
        raf.seek(raf.length());
        int msb = (yesInitial>>8) & 0xFF;
        int lsb = (yesInitial % 256);
        raf.write(msb);
        raf.write(lsb);
        msb = (noInitial>>8) & 0xFF;
        lsb = (noInitial % 256);
        raf.write(msb);
        raf.write(lsb);
        raf.write(text.getBytes());
        raf.write(0);        
    }
    
    static void initDataFile(RandomAccessFile raf) throws IOException
    {
        raf.setLength(0);
        appendText(raf,"Does it live on land",0,0);
        int a = (int)raf.length();
        appendText(raf,"Cow",0,0);
        int b = (int)raf.length();
        appendText(raf,"Shark",0,0);
        updatePointer(raf,true,0,a);
        updatePointer(raf,false,0,b);
    }   
    
    public static boolean getYesNo() throws IOException 
    {        
        String s = readLine();
        if(s.startsWith("Y") || s.startsWith("y")) return true;
        else if(s.startsWith("N") || s.startsWith("n")) return false;
        return false;        
    }
    
    
    public static int processNode(RandomAccessFile raf, int offset) throws IOException
    {
        int yes = readPointer(raf,true,offset);
        int no =  readPointer(raf,false,offset);
        String text = readText(raf,offset);
        if(yes==0) {
            System.out.println("Is it a "+text+"?");
            boolean yn = getYesNo();
            if(yn) return -1;
            return 0;
        } else {
            System.out.println(text+"?");
            boolean yn = getYesNo();
            int next = readPointer(raf,yn,offset);           
            return next;
        }
    }
    
    public static String readLine() throws IOException
    {
        InputStreamReader isr = new InputStreamReader(System.in);
        BufferedReader br = new BufferedReader(isr);
        return br.readLine();
    }
    
    public static void addNewAnimal(RandomAccessFile raf, int lastQuestion, int lastGuess) throws Exception
    {
        
        // Parse the last question node
        int yes = readPointer(raf,true,lastQuestion);
        int no =  readPointer(raf,false,lastQuestion);        
        
        // Get my last guessed animal
        String myGuess = readText(raf,lastGuess);        
        
        // Get information about the new node
        System.out.println("I give up! What was your animal?");
        String newAnimal = readLine();
        System.out.println("Please enter a question that would separate my guess '"+myGuess+"' from a '"+newAnimal+"':");
        String newQuestion = readLine().trim();
        System.out.println("And what would the answer to your question be for '"+newAnimal+"' ?");
        boolean yn = getYesNo();
        if(newQuestion.endsWith("?")) {
            newQuestion = newQuestion.substring(0,newQuestion.length()-1);
        }
        
        // Add the new question and animal
        int newQuestionSpot = (int)raf.length();
        appendText(raf,newQuestion,0,0);
        int newAnimalSpot = (int)raf.length();
        appendText(raf,newAnimal,0,0);
        
        // Link the last question to the new question
        if(yes==lastGuess) {
            updatePointer(raf,true,lastQuestion,newQuestionSpot);
        } else {
            updatePointer(raf,false,lastQuestion,newQuestionSpot);
        }
        
        // Link the new question to the two animals (new and old)
        if(yn) {
            updatePointer(raf,true,newQuestionSpot,newAnimalSpot);
            updatePointer(raf,false,newQuestionSpot,lastGuess);
        } else {
            updatePointer(raf,false,newQuestionSpot,newAnimalSpot);
            updatePointer(raf,true,newQuestionSpot,lastGuess);
        }        
        
    }
    
    public static void main(String [] args) throws Exception
    {
        String name="zoo.bin";
        if(args.length>0) name=args[0];
        
        RandomAccessFile raf = new RandomAccessFile(name,"rw");  
        if(raf.length()==0) {
            initDataFile(raf);
        }
        
        int lastQuestion = 0;
        int offset = 0;
        while(true) {
            int y = processNode(raf,offset);
            if(y==-1) {
                System.out.println();
                System.out.println("Great! Let's play again!");
                System.out.println();
                offset = 0;
                lastQuestion = 0;
                continue;
            }
            if(y==0) {                
                addNewAnimal(raf,lastQuestion,offset);
                System.out.println();
                System.out.println("Thanks! Let's play again!");
                System.out.println();
                offset = 0;
                lastQuestion = 0;
                continue;
            }
            lastQuestion = offset;
            offset = y;
        }
        
    }
    
}