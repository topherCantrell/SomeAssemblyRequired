/*************************************************************************
*
*       FILENAME: MAKEIDE.C
*
*       Copyright (c) 2005 by Better Software Co.
*
*       DESCRIPTION:  Init virtual IDE hard drive (maximum support 4gig)
*
*************************************************************************/

// C++ headers

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <alloc.h>
#include <conio.h>
#include <fcntl.h>
#include <sys\stat.h>
#include <dos.h>
#include <dir.h>
#include <time.h>
#include <io.h>
#include <errno.h>

// constants

#define FALSE               0
#define TRUE                -1

// structures

// externals

// prototypes

int ValidatePath(char *FilePath);               // validate filename & path
int GetFilename(int ls, char type, char *VC);   // input a PC filename

// global variables

char IDE_PATH[MAXPATH];                     // filename buffer
char IDE_DRIVE[MAXDRIVE];                   // default drive for filenames
char IDE_DIR[MAXDIR];                       // default dir for filenames
char IDE_FILE[9];                           // last entered filename
char IDE_INPUT[80];                         // text input
unsigned int IDE_CYL=0;                     // logical cylinders
unsigned char IDE_HD=0;                     // logical heads
unsigned char IDE_SEC=0;                    // logical sectors/track
unsigned int IDE_INFO[256];                 // IDE identify device info

char ExitMsg[256];                          // program exit error message

int Version=100;

/*************************************************************************
*
* main program
*
*************************************************************************/

int main()

{
    int DONE;
    int PCNTR, PCNT=5;                      // prompt cntr & # of prompts
    unsigned int A1;                        // scratch variable
    unsigned long A2;                       // scratch variable
    int IDEChannel=-1;                      // IDE file channel #
    char C1[256];                           // scratch string variable
    char drive[MAXDRIVE],dir[MAXDIR],file[MAXFILE],ext[MAXEXT];

    ExitMsg[0]=0;                           // clear error message
    randomize();                            // init random # generator

                                            // get default filenames & paths
    fnsplit(_argv[0],IDE_DRIVE,IDE_DIR,NULL,NULL);

    clrscr();
    printf("Virtual IDE file maker v%1d.%02d by David Keil"
    "\nCopyright 2005 David Keil\n"
    "\nThis program will initilize a virtual IDE hard drive file"
    "\nfor use with the Tandy Color Computer & Color Computer 3 emulators\n\n",Version/100,Version%100);

    DONE=PCNTR=0;                               // init prompt number
    do {
        gotoxy(1,7+PCNTR), clreol(), memset(IDE_INPUT,0,80);
        switch (PCNTR) {
        case 0: {
            strcpy(IDE_INPUT,IDE_FILE);
            cputs("Enter filename: "), A1=GetFilename(34,0,"");
            if (A1&0xFF==0xFF) DONE=-1;         // abort input
            if (A1&0xFF00) strcpy(IDE_FILE,IDE_INPUT), PCNTR++;
            break;
            }
        case 1: {
            if (IDE_CYL) ultoa(IDE_CYL,IDE_INPUT,10);
            cputs("Enter logical cylinders: "), A1=GetFilename(4,99,"0123456789");
            if (A1&0xFF==0xFF) DONE=-1;         // abort input
            if (A1&0xFF00) {
                A2=atol(IDE_INPUT);
                if (A2<16 || A2>4096) IDE_CYL=0; else IDE_CYL=A2, PCNTR++;
            }
            break;
            }
        case 2: {
            if (IDE_HD) itoa(IDE_HD,IDE_INPUT,10);
            cputs("Enter logical heads: "), A1=GetFilename(2,99,"0123456789");
            if (A1&0xFF==0xFF) DONE=-1;         // abort input
            if (A1&0xFF00) {
                IDE_HD=atoi(IDE_INPUT);
                if (IDE_HD<1 || IDE_HD>16) IDE_HD=0; else PCNTR++;
            }
            break;
            }
        case 3: {
            if (IDE_SEC) sprintf(IDE_INPUT,"%u",IDE_SEC);
            cputs("Enter logical sectors: "), A1=GetFilename(2,99,"0123456789");
            if (A1&0xFF==0xFF) DONE=-1;         // abort input
            if (A1&0xFF00) {
                IDE_SEC=atoi(IDE_INPUT);
                if (IDE_SEC<1 || IDE_SEC>64) IDE_SEC=0; else PCNTR++;
            }
            break;
            }
        default:
            A2=(unsigned long)IDE_CYL*IDE_HD*IDE_SEC;
            cputs("\nCreating drive: "), cputs(IDE_PATH);
            printf("\nWith a total capacity of %lu sectors OR %u megabytes\n",A2,A2/2048);
            cputs("\nInformation correct & ready to create IDE drive, [Y]es or [N]o? "), A1=GetFilename(1,99,"YNyn");
            if (A1&0xFF==0xFF) DONE=-1;         // abort input
            if (A1&0xFF00) {
                if (IDE_INPUT[0]=='N' || IDE_INPUT[0]=='n') {
                    PCNTR=0;
                    for (A1=11; A1<16; A1++) gotoxy(1,A1), clreol();
                } else PCNTR++;
            break;
            }
        } 
    } while (!DONE && PCNTR<PCNT);

    gotoxy(1,15), clreol();
    sprintf(ExitMsg,"\n\nProgram aborted, no virtual IDE file created.");

    if (!DONE) {
        sprintf(ExitMsg,"IDE file exists, file creation aborted by user.");
        if ((IDEChannel=open(IDE_PATH,O_RDONLY))!=-1) {
            close(IDEChannel), IDE_INPUT[0]=0, PCNTR=0;
            do {
                gotoxy(1,15);
                cputs("File exists do you want to overwrite [Y]es or [N]o? "), A1=GetFilename(1,99,"YNyn");
                if (A1&0xFF==0xFF) PCNTR=DONE=-1;   // abort input
                if (A1&0xFF00) {                    // abort file creation if NO
                    if (IDE_INPUT[0]=='N' || IDE_INPUT[0]=='n') DONE=-1;
                    PCNTR=-1;
                }
            } while (!PCNTR);
            gotoxy(1,15), clreol();
        }
        if (!DONE) {
            sprintf(ExitMsg,"Unable to create virtual IDE file, program aborted.");
            if ((IDEChannel=open(IDE_PATH,O_RDWR|O_BINARY|O_CREAT|O_TRUNC,S_IREAD|S_IWRITE))==-1) DONE=-1;
            else {
                memset(IDE_INFO,0,512);         // init IDE device info
                IDE_INFO[0]=0x40;
                IDE_INFO[1]=IDE_INFO[54]=IDE_CYL;
                IDE_INFO[3]=IDE_INFO[55]=IDE_HD;
                IDE_INFO[6]=IDE_INFO[56]=IDE_SEC;
                memset(C1,0,255), sprintf(C1,"%08lu_",rand()%100000000), strcat(C1,IDE_FILE);
                swab(C1,&(char)IDE_INFO[10],20);
                swab("001.000A",&(char)IDE_INFO[23],8);
                swab("DMK-IDE Virtual Hard Drive",&(char)IDE_INFO[27],26);
                IDE_INFO[47]=1, IDE_INFO[49]=0x300, IDE_INFO[53]=1;
                A2=(unsigned long)IDE_CYL*IDE_HD*IDE_SEC;
                IDE_INFO[57]=IDE_INFO[60]=A2%0x10000;
                IDE_INFO[58]=IDE_INFO[61]=A2/0x10000;
                IDE_INFO[80]=4;
                if ((IDEChannel=write(IDEChannel,IDE_INFO,512))!=-1);
                    sprintf(ExitMsg,"Virtual IDE HD: %s\nhas been created.",IDE_PATH);
                close(IDEChannel);
            }
    }   }

    gotoxy(1,15), puts(ExitMsg);
    return 0;

}

/*************************************************************************

* FUNCTION: validate path and filename

* DESCRIPTION: Self explanatory

* Entry: file path to validate

*************************************************************************/

int ValidatePath(char *FilePath)

{
    char flags=0;                           // filename & path flags
    int FilePathLen=strlen(FilePath);       // length of filename & path
    int A1;                                 // scratch variable
    int A2=8;                               // scratch variable
    char *ValidChar="1234567890_^$~!#%&-{}()@'ABCDEFGHIJKLMNOPQRSTUVWXYZ";

    for (A1=0; A1<FilePathLen; A1++) {
        if (FilePath[A1]==':') {
            if (A1!=1)
                return(FALSE);
            else
                if ((strchr(ValidChar,FilePath[0])-ValidChar)<25)
                    return(FALSE);
                else
                    flags=DRIVE, A2=8;
        }
        else if (FilePath[A1]=='\\') {
            if (flags & DIRECTORY)
                return(FALSE);
            else
                flags=(flags | DIRECTORY) & ~(EXTENSION+FILENAME), A2=8;
        }
        else if (FilePath[A1]=='.')
            flags=(flags | EXTENSION) & ~DIRECTORY, A2=3;
        else
            if (A2==0)
                return(FALSE);
            else
                if (!strchr(ValidChar,FilePath[A1]))
                    return(FALSE);
                else
                    flags=(flags | FILENAME) & ~DIRECTORY, A2=A2--;
    }
    if (flags & FILENAME)
        return(TRUE);
    else
        return(FALSE);
}

/*************************************************************************
*
* FUNCTION: GetFilename(void)
*
* DESCRIPTION: display old value & allow input
*
* Entry: input string
*
* Exit: none
*
*************************************************************************/

int GetFilename(int ls, char type, char *VC)

{
    int pos, x, y, key, DONE=FALSE, EXIT=0;
    char drive[MAXDRIVE],dir[MAXDIR],file[MAXFILE],ext[MAXEXT];
    char *ValidChar="\\.:1234567890_^$~!#%&-{}()@'ABCDEFGHIJKLMNOPQRSTUVWXYZ";

    _setcursortype(_NORMALCURSOR);
    x=wherex(), y=wherey(), pos=0; //strlen(IDE_INPUT);
    gotoxy(x,y), cputs(IDE_INPUT);
    do {
        gotoxy(x+pos,y), key=getch();
        if ((type!=99) && (key>0x60) && (key<0x7B)) key&=0xDF;
        if (!key) key=getch()+0x100;
        switch (key) {
            case 0x08 :                         // backspace
                if (pos!=0 && pos==strlen(IDE_INPUT)) {
                    pos--, IDE_INPUT[pos]=0, gotoxy(x+pos,y), cputs(" ");
                    break;
                }
            case 0x14B:                         // left arrow
                if (pos) pos--;
                ; break;
            case 0x14D:                         // right arrow
                if (pos<strlen(IDE_INPUT)) pos++;
                ; break;
            case 0x147:                         // home
                pos=0; break;
            case 0x14F:                         // end
                pos=strlen(IDE_INPUT);
                break;
            case 0x0D :                         // enter
                EXIT=0, DONE=TRUE; break;
            case 0x1B :                         // break
                EXIT=-1, DONE=TRUE; break;
            case 0x152 :                        // insert
                if (strlen(IDE_INPUT)>pos && strlen(IDE_INPUT)<ls) {
                    memmove(&IDE_INPUT[pos+1],&IDE_INPUT[pos],strlen(IDE_INPUT)-pos);
                    IDE_INPUT[pos]=' ', gotoxy(x,y), cputs(IDE_INPUT);
                }
                break;
            case 0x153:                         // delete
                if (strlen(IDE_INPUT)>pos) {
                    memmove(&IDE_INPUT[pos],&IDE_INPUT[pos+1],strlen(IDE_INPUT)-pos-1);
                    IDE_INPUT[strlen(IDE_INPUT)-1]=0;
                    gotoxy(x,y), cputs(IDE_INPUT), cputs(" ");
                }
                break;
        default :
                if (pos<ls && key<0x100 &&
                ((type!=99 && strchr(ValidChar,key)!=NULL)
                || (type==99 && (VC[0]==0 || strchr(VC,key)!=NULL)))) {
                    IDE_INPUT[pos]=key;
                    if (strlen(IDE_INPUT)==pos) IDE_INPUT[pos+1]=0;
                    gotoxy(x+pos,y), putch(key), pos++;
                }
        }
    } while (!DONE);
    DONE=FALSE;
    if (strlen(IDE_INPUT)) {
        if (type==99) DONE=TRUE;
        else {
            if (ValidatePath(IDE_INPUT)) {
                key=fnsplit(IDE_INPUT,drive,dir,file,ext);
                if ((key & (DRIVE+DIRECTORY))==0) strcpy(drive,IDE_DRIVE),strcpy(dir,IDE_DIR);
                if ((key & EXTENSION)==0) strcpy(ext,".IDE");
                fnmerge(IDE_PATH,drive,dir,file,ext);
                DONE=TRUE;
    }   }   }
    return((DONE&0xFF)<<8|EXIT&0xFF);
}

