
import java.io.*;
import java.util.*;

// To Do ...

// Load a color palette too and a map between characters and the palette.

public class ImageToRTF
{
    
    static String [] preamble = {    
"{\\rtf1\\ansi\\ansicpg1252\\uc1 \\deff0\\deflang1033\\deflangfe1033{\\fonttbl{\\f0\\froman\\fcharset0\\fprq2{\\*\\panose 02020603050405020304}Times New Roman;}{\\f16\\froman\\fcharset238\\fprq2 Times New Roman CE;}{\\f17\\froman\\fcharset204\\fprq2 Times New Roman Cyr;}",
"{\\f19\\froman\\fcharset161\\fprq2 Times New Roman Greek;}{\\f20\\froman\\fcharset162\\fprq2 Times New Roman Tur;}{\\f21\\froman\\fcharset186\\fprq2 Times New Roman Baltic;}}{\\colortbl;\\red0\\green0\\blue0;\\red0\\green0\\blue255;\\red0\\green255\\blue255;",
"\\red0\\green255\\blue0;\\red255\\green0\\blue255;\\red255\\green0\\blue0;\\red255\\green255\\blue0;\\red255\\green255\\blue255;\\red0\\green0\\blue128;\\red0\\green128\\blue128;\\red0\\green128\\blue0;\\red128\\green0\\blue128;\\red128\\green0\\blue0;\\red128\\green128\\blue0;",
"\\red128\\green128\\blue128;\\red192\\green192\\blue192;}{\\stylesheet{\\widctlpar\\adjustright \\fs20\\cgrid \\snext0 Normal;}{\\*\\cs10 \\additive Default Paragraph Font;}}{\\info{\\author Me Me}{\\operator Me Me}{\\creatim\\yr2005\\mo6\\dy27\\hr11\\min48}",
"{\\revtim\\yr2005\\mo6\\dy27\\hr11\\min48}{\\version2}{\\edmins0}{\\nofpages1}{\\nofwords0}{\\nofchars0}{\\*\\company ME}{\\nofcharsws0}{\\vern89}}\\widowctrl\\ftnbj\\aenddoc\\formshade\\viewkind1\\viewscale100\\pgbrdrhead\\pgbrdrfoot \\fet0\\sectd ",
"\\linex0\\endnhere\\sectdefaultcl {\\*\\pnseclvl1\\pnucrm\\pnstart1\\pnindent720\\pnhang{\\pntxta .}}{\\*\\pnseclvl2\\pnucltr\\pnstart1\\pnindent720\\pnhang{\\pntxta .}}{\\*\\pnseclvl3\\pndec\\pnstart1\\pnindent720\\pnhang{\\pntxta .}}{\\*\\pnseclvl4",
"\\pnlcltr\\pnstart1\\pnindent720\\pnhang{\\pntxta )}}{\\*\\pnseclvl5\\pndec\\pnstart1\\pnindent720\\pnhang{\\pntxtb (}{\\pntxta )}}{\\*\\pnseclvl6\\pnlcltr\\pnstart1\\pnindent720\\pnhang{\\pntxtb (}{\\pntxta )}}{\\*\\pnseclvl7\\pnlcrm\\pnstart1\\pnindent720\\pnhang{\\pntxtb (}",
"{\\pntxta )}}{\\*\\pnseclvl8\\pnlcltr\\pnstart1\\pnindent720\\pnhang{\\pntxtb (}{\\pntxta )}}{\\*\\pnseclvl9\\pnlcrm\\pnstart1\\pnindent720\\pnhang{\\pntxtb (}{\\pntxta )}}\\pard\\plain \\widctlpar\\adjustright \\fs20\\cgrid {\\lang1024 ",
    };
    
    static String [] closing = {
"\\par }}"
    };
    
    static String [] emptyBox = {
"{\\shp{\\*\\shpinst\\shpleft*LEFT*\\shptop*TOP*\\shpright*RIGHT*\\shpbottom*BOTTOM*\\shpfhdr0\\shpbxcolumn\\shpbypara\\shpwr3\\shpwrk0\\shpfblwtxt0\\shpz2\\shplid1028",
"{\\sp{\\sn shapeType}{\\sv 1}}{\\sp{\\sn fFlipH}{\\sv 0}}{\\sp{\\sn fFlipV}{\\sv 0}}}{\\shprslt{\\*\\do\\dobxcolumn\\dobypara\\dodhgt*DODHGT*\\dprect\\dpx*LEFT*\\dpy*TOP*\\dpxsize*WIDTH*\\dpysize*HEIGHT*",
"\\dpfillfgcr255\\dpfillfgcg255\\dpfillfgcb255\\dpfillbgcr255\\dpfillbgcg255\\dpfillbgcb255\\dpfillpat1\\dplinew15\\dplinecor0\\dplinecog0\\dplinecob0}}}"
    };
    
    static String [] box = {
"{\\shp{\\*\\shpinst\\shpleft*LEFT*\\shptop*TOP*\\shpright*RIGHT*\\shpbottom*BOTTOM*\\shpfhdr0\\shpbxcolumn\\shpbypara\\shpwr3\\shpwrk0\\shpfblwtxt0\\shpz0\\shplid*ID*{\\sp{\\sn shapeType}{\\sv 1}}{\\sp{\\sn fFlipH}{\\sv 0}}{\\sp{\\sn fFlipV}{\\sv 0}}",
"{\\sp{\\sn fillColor}{\\sv *COLOR*}}{\\sp{\\sn fFilled}{\\sv 1}}}{\\shprslt{\\*\\do\\dobxcolumn\\dobypara\\dodhgt*DODHGT*\\dprect\\dpx*LEFT*\\dpy*TOP*\\dpxsize*WIDTH*\\dpysize*HEIGHT*",
"\\dpfillfgcr255\\dpfillfgcg255\\dpfillfgcb255\\dpfillbgcr*RED*\\dpfillbgcg*GREEN*\\dpfillbgcb*BLUE*\\dpfillpat1\\dplinew15\\dplinecor0\\dplinecog0\\dplinecob0}}}}{"
    };    
    
    public static List readImageFile(String name) throws Exception 
    {
        List a = new ArrayList();
        Reader r = new FileReader(name);
        BufferedReader br = new BufferedReader(r);
        while(true) {
            String g = br.readLine();
            if(g==null) break;
            if(!g.startsWith("\"")) continue;
            int yy = g.indexOf("\"",2);
            g = g.substring(1,yy);
            a.add(g);
        }
        br.close();
        return a;
    }
    
    public static String [] rep(String [] target, String f, String r)
    {
        String [] ret = new String [target.length];
        for(int x=0;x<target.length;++x) {
            ret[x] = target[x];
        }
        
        for(int x=0;x<target.length;++x) {
            while(true) {
                int i = ret[x].indexOf(f);
                if(i<0) break;
                String a = ret[x].substring(0,i) + r + ret[x].substring(i+f.length());
                ret[x] = a;
            }
        }
        return ret;
    }
    
    public static void printRTF(List a,PrintStream ps) throws Exception
    {
        int nr = a.size();
        int nc = ((String)a.get(0)).length();
        
        int stx = 360;
        int sty = 288;
        
        // Replace tags ...
        // LEFT, RIGHT, TOP, BOTTOM
        // ID, DODHGT
        // RED, GREEN, BLUE
        // WIDTH, HEIGHT
        
        int width = 144;
        int height = 144;
        int ids = 1026;
        int dogs = 8192;
        
        for(int x=0;x<preamble.length;++x) {
            ps.println(preamble[x]);
        }
        
        String [] j=null;
        for(int y=0;y<nr;++y) {
            String h = (String)a.get(y);
            for(int x=0;x<nc;++x) {
                if(h.charAt(x)!='.') {
                    j = box;
                } else {
                    j = emptyBox;
                }
                
                j = rep(j,"*LEFT*",""+(stx+width*x));
                j = rep(j,"*RIGHT*",""+(stx+width*x+width));
                j = rep(j,"*TOP*",""+(sty+y*height));
                j = rep(j,"*BOTTOM*",""+(sty+y*height+height));
                j = rep(j,"*ID*",""+(ids++));
                j = rep(j,"*DODHGT*",""+(dogs++));
                j = rep(j,"*WIDTH*",""+width);
                j = rep(j,"*HEIGHT*",""+height);
                j = rep(j,"*RED*",""+0);
                j = rep(j,"*GREEN*",""+0);
                j = rep(j,"*BLUE*",""+0);
                j = rep(j,"*COLOR*",""+16711680);                                
                
                for(int z=0;z<j.length;++z) {
                    ps.println(j[z]);
                }
            }
        }       
        
        for(int x=0;x<closing.length;++x) {
            ps.println(closing[x]);
        }
    }

    public static void main(String [] args) throws Exception
    {
        List a = readImageFile(args[0]);
        printRTF(a,System.out);        
        
    }
    
}
