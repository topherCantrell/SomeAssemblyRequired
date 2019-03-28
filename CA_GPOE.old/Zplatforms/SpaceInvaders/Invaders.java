import java.io.*;
import java.util.*;

import javax.swing.*;
import java.awt.*;

public class Invaders 
{
    
    static class IRQTimer implements Runnable 
    {
        
        InvadersMachine inv;
        
        public void run() {
            try {
                while(true) {
                    Thread.sleep(1000);
                    inv.irq();                    
                }
            } catch(Exception e) {
                e.printStackTrace();
            }            
        }        
    }
    
    public static void main(String [] args) throws Exception
    {
        
        InvadersScreen screen = new InvadersScreen();
        JFrame jf = new JFrame("Invaders");
        jf.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        jf.getContentPane().add(BorderLayout.CENTER,screen);
        jf.pack();
        jf.setVisible(true);
        
        InvadersMachine inv = new InvadersMachine(args[0],screen);  
        
        IRQTimer irq = new IRQTimer();
        irq.inv = inv;
        Thread t = new Thread(irq);        
        t.start();
        
        //for(int x=0;x<1000000;++x) {
        while(true) {
            
            inv.exec(10);
        }
        
        //int a = inv.getPC();
        //System.out.println(Integer.toString(a,16));
        
    }

}

class InvadersScreen extends JPanel
{
    int width = 224;
    int height = 256;
    int [][] pixels = new int[height][width];
    
    InvadersScreen()
    {
        setPreferredSize(new Dimension(width,height));
        /*
        for(int y=0;y<height;++y) {
            for(int x=0;x<width;++x) {
                pixels[y][x] = 1;
            }
        }
         */
         
    }
    
    public void paint(Graphics g)
    {
        super.paint(g);
        for(int y=0;y<height;++y) {
            for(int x=0;x<width;++x) {
                if(pixels[y][x]==1) {
                    g.fillRect(x,y,1,1);
                }
            }            
        }
    }
}

class InvadersMachine extends Z80 
{
    
    InvadersScreen screen;
    
    InvadersMachine(String binName, InvadersScreen screen) throws Exception
    {
        this.screen = screen;
        int add = 0;
        InputStream is = new FileInputStream(binName);
        while(is.available()>0) {
            int a = is.read();
            pokeb(add++,a);
        }
        //System.out.println(add);
    }
    
    public void outb(int port,int value,int status) 
    {
        System.out.println("OUT "+port+" "+value);
    }
    
    public int inb(int port,int hi) 
    {
        System.out.println("IN "+port);
        return 0xFF;
    }
    
    public int peekb(int add) {
        return super.peekb(add);       
    }
    
    public void pokeb(int add,int value) {        
        if(add>=0x2400 && add<0x4000) {
            int base = add-0x2400;
            int runsize = 256/8;  // Each row on the screen is 30 bytes
            int col = base/(runsize);
            int row = base%(runsize);            
            screen.pixels[(31-row)*8][col] =  (value >> 7)&0x1;
            screen.pixels[(31-row)*8+1][col] =  (value >> 6)&0x1;
            screen.pixels[(31-row)*8+2][col] =  (value >> 5)&0x1;
            screen.pixels[(31-row)*8+3][col] =  (value >> 4)&0x1;
            screen.pixels[(31-row)*8+4][col] =  (value >> 3)&0x1;
            screen.pixels[(31-row)*8+5][col] =  (value >> 2)&0x1;
            screen.pixels[(31-row)*8+6][col] =  (value >> 1)&0x1;
            screen.pixels[(31-row)*8+7][col] =  (value >> 0)&0x1;    
            screen.updateUI();
        }
        super.pokeb(add,value);        
    }
}
