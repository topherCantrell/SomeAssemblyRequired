/*
    I had quite a few requests for this, and some of my replies bounced,
so here it is.  Please note: Some of the copies I mailed were sent out
before I noticed that there had originally been a statement to the
effect that the program was not shareware.  That was from the dark ages,
and you may remove that notice.

    This compiles properly under MSC 6.0, under the common C compiler,
and under gnucc.  I have not tested the program on anything but the PC,
because I don't have any files to disassemble anymore.  Use it in good
health. 
*/ 
/*  DASM85.C    30-Nov-88  9:07:32 by Kevin D. Quitt

    Disassemble 8085 code from a binary file.

    Two passes - the first collects labels, the second performs
    the disassembly.  References to addresses with instructions are
    noted as sync errors.

    Written for Microsoft C to run on an IBM PC.
*/
#include    <stdio.h>
#include    <string.h>

#define MAX_LABELS  (2048)

unsigned int    Labels[ MAX_LABELS ];
unsigned char   In_File[ 132 ];
unsigned char   Out_File[ 132 ];
unsigned char   Temp[ 132 ];

char    *Op_Code[256]   =
   {
/*    1           2           3           4                                 */
    "nop",      "lxi\tb,",  "stax\tb",  "inx\tb",
    "inr\tb",   "dcr\tb",   "mvi\tb,",  "rlc",
    "???",      "dad\tb",   "ldax\tb",  "dcx\tb",
    "inr\tc",   "dcr\tc",   "mvi\tc,",  "rrc",
    "???",      "lxi\td,",  "stax\td",  "inx\td",
    "inr\td",   "dcr\td",   "mvi\td,",  "ral",
    "???",      "dad\td",   "ldax\td",  "dcx\td",
    "inr\te",   "dcr\te",   "mvi\te,",  "rar",
    "rim",      "lxi\th,",  "shld\t",   "inx\th",
    "inr\th",   "dcr\th",   "mvi\th,",  "daa",
    "???",      "dad\th",   "lhld\t",   "dcx\th",
    "inr\tl",   "dcr\tl",   "mvi\tl,",  "cma",
    "sim",      "lxi\tsp,", "sta\t",    "inx\tsp",
    "inr\tm",   "dcr\tm",   "mvi\tm,",  "stc",
    "???",      "dad\tsp",  "lda\t",    "dcx\tsp",
    "inr\ta",   "dcr\ta",   "mvi\ta,",  "cmc\ta,",
/*    0           1           2           3                             */
    "mov\tb,b", "mov\tb,c", "mov\tb,d", "mov\tb,e",
    "mov\tb,h", "mov\tb,l", "mov\tb,m", "mov\tb,a",
    "mov\tc,b", "mov\tc,c", "mov\tc,d", "mov\tc,e",
    "mov\tc,h", "mov\tc,l", "mov\tc,m", "mov\tc,a",
    "mov\td,b", "mov\td,c", "mov\td,d", "mov\td,e",
    "mov\td,h", "mov\td,l", "mov\td,m", "mov\td,a",
    "mov\te,b", "mov\te,c", "mov\te,d", "mov\te,e",
    "mov\te,h", "mov\te,l", "mov\te,m", "mov\te,a",
    "mov\th,b", "mov\th,c", "mov\th,d", "mov\th,e",
    "mov\th,h", "mov\th,l", "mov\th,m", "mov\th,a",
    "mov\tl,b", "mov\tl,c", "mov\tl,d", "mov\tl,e",
    "mov\tl,h", "mov\tl,l", "mov\tl,m", "mov\tl,a",
    "mov\tm,b", "mov\tm,c", "mov\tm,d", "mov\tm,e",
    "mov\tm,h", "mov\tm,l", "hlt\t",    "mov\tm,a",
    "mov\ta,b", "mov\ta,c", "mov\ta,d", "mov\ta,e",
    "mov\ta,h", "mov\ta,l", "mov\ta,m", "mov\ta,a",
/*    0           1           2           3                             */
    "add\tb",   "add\tc",   "add\td",   "add\te",
    "add\th",   "add\tl",   "add\tm",   "add\ta",
    "adc\tb",   "adc\tc",   "adc\td",   "adc\te",
    "adc\th",   "adc\tl",   "adc\tm",   "adc\ta",
    "sub\tb",   "sub\tc",   "sub\td",   "sub\te",
    "sub\th",   "sub\tl",   "sub\tm",   "sub\ta",
    "sbb\tb",   "sbb\tc",   "sbb\td",   "sbb\te",
    "sbb\th",   "sbb\tl",   "sbb\tm",   "sbb\ta",
    "ana\tb",   "ana\tc",   "ana\td",   "ana\te",
    "ana\th",   "ana\tl",   "ana\tm",   "ana\ta",
    "xra\tb",   "xra\tc",   "xra\td",   "xra\te",
    "xra\th",   "xra\tl",   "xra\tm",   "xra\ta",
    "ora\tb",   "ora\tc",   "ora\td",   "ora\te",
    "ora\th",   "ora\tl",   "ora\tm",   "ora\ta",
    "cmp\tb",   "cmp\tc",   "cmp\td",   "cmp\te",
    "cmp\th",   "cmp\tl",   "cmp\tm",   "cmp\ta",
/*    0           1           2           3                             */
    "rnz",      "pop\tb",   "jnz\t",    "jmp\t",
    "cnz",      "push\tb",  "adi\t",    "rst\t0",
    "rz",       "ret",      "jz\t",     "???",
    "cz",       "call\t",   "aci\t",    "rst\t1",
    "rnc",      "pop\td",   "jnc\t",    "out\t",
    "cnc",      "push\td",  "sui\t",    "rst\t2",
    "rc",       "???",      "jc\t",     "in\t", 
    "cc",       "???",      "sbi\t",    "rst\t3",
    "rpo",      "pop\th",   "jpo\t",    "xthl",
    "cpo",      "push\th",  "ani\t",    "rst\t4",
    "rpe",      "pchl",     "jpe\t",    "xchg",
    "cpe",      "???",      "xri\t",    "rst\t5",
    "rp",       "pop\tpsw", "jp\t",     "di",
    "cp",       "push\tpsw","ori\t",    "rst\t6",
    "rm",       "sphl",     "jm\t",     "ei",
    "cm",       "???",      "cpi\t",    "rst\t7"    
   };

char    Op_Code_Size[]  =
   {
/*  0   1   2   3   4   5   6   7   8   9   A   B   C   D   E   F           */
    1,  3,  1,  1,  1,  1,  2,  1,  1,  1,  1,  1,  1,  1,  2,  1,  /* 00   */
    1,  3,  1,  1,  1,  1,  2,  1,  1,  1,  1,  1,  1,  1,  2,  1,  /* 10   */
    1,  3,  3,  1,  1,  1,  2,  1,  1,  1,  3,  1,  1,  1,  2,  1,  /* 20   */
    1,  3,  3,  1,  1,  1,  2,  1,  1,  1,  3,  1,  1,  1,  2,  1,  /* 30   */

    1,  1,  1,  1,  1,  1,  1,  1,  1,  1,  1,  1,  1,  1,  1,  1,  /* 40   */
    1,  1,  1,  1,  1,  1,  1,  1,  1,  1,  1,  1,  1,  1,  1,  1,  /* 50   */
    1,  1,  1,  1,  1,  1,  1,  1,  1,  1,  1,  1,  1,  1,  1,  1,  /* 60   */
    1,  1,  1,  1,  1,  1,  1,  1,  1,  1,  1,  1,  1,  1,  1,  1,  /* 70   */

    1,  1,  1,  1,  1,  1,  1,  1,  1,  1,  1,  1,  1,  1,  1,  1,  /* 80   */
    1,  1,  1,  1,  1,  1,  1,  1,  1,  1,  1,  1,  1,  1,  1,  1,  /* 90   */
    1,  1,  1,  1,  1,  1,  1,  1,  1,  1,  1,  1,  1,  1,  1,  1,  /* A0   */
    1,  1,  1,  1,  1,  1,  1,  1,  1,  1,  1,  1,  1,  1,  1,  1,  /* B0   */

    1,  1,  3,  3,  1,  1,  2,  1,  1,  1,  3,  1,  3,  3,  2,  1,  /* C0   */
    1,  1,  3,  2,  3,  1,  2,  1,  1,  1,  3,  2,  3,  1,  2,  1,  /* D0   */
    1,  1,  3,  1,  3,  1,  2,  1,  1,  1,  3,  1,  3,  1,  2,  1,  /* E0   */
    1,  1,  3,  1,  3,  1,  2,  1,  1,  1,  3,  1,  3,  1,  2,  1   /* F0   */
   };


/*  File extension utilities.                                  114
*/
void    Extend( out, in, ext )

char    *out, *in, *ext;
   {
    strcpy( out, in );
    if ( strchr( out, '.' )  ==  NULL )
       {
        strcat( out, "." );
        strcat( out, ext );
       }
   }


void    Strip( out, in )

char    out[], in[];
   {
    char    *p;

    strcpy( out, in );
    if ( (p = strchr( out, '.' ))  !=  NULL )
        *p  = (char)0;
   }

int     main( argc, argv )

int     argc;
char    *argv[];
   {
    FILE    *In, *Out;
    int     c, op, pc,i,j,m,k,ptr;

    pc  = 0;

    if ( (argv[1][0]  ==  '?')  ||  ( argc  !=  2) )
       {
        printf( "\nSyntax is DASM85 binfilespec\n" );
        printf( "The extension is optional, BIN is assumed. Output is to\n" );
        printf( "the same file name, with a DSA extension.\n\n\n" );
        printf( "This program is freeware.\n\n");
        return  0;
       }

    Extend( In_File, argv[1], "BIN" );
    if ( (In = fopen( In_File, "rb"))  ==  NULL )
       {
        printf( "Can't open input file %s!\r\n", In_File );
        return  -1;
       }

    Strip( Temp, argv[1] );
    Extend( Out_File, Temp, "DSA" );
    if ( (Out = fopen( Out_File, "wt"))  ==  NULL )
       {
        printf( "Can't open disassembly list file %s!\r\n", Out_File );
        return -2;
       }

    for(i = 0; i<2048; i++)
        Labels[i] = 0xffff;
    
    k = 0;
    while ( (op = fgetc( In ))  !=  EOF )
       {
        if ( Op_Code_Size[ op ]  ==  2 )
            fgetc(In);
        if ( Op_Code_Size[ op ]  ==  3 )        
           {
            i = fgetc(In);
            j = fgetc(In);
            j <<= 8;
            i |= j;
            for( m = 0 ; m <= k ; m++)
               {
                if( i == Labels[m])
                    break;
                if( i < Labels[m])
                   {
                    for( j = k ; j > m ; j-- )
                        Labels[j] = Labels[j-1];
                    Labels[m] = i;
                    k++;
                    break;
                   }
               }
           }
       }

    rewind( In );
    ptr = 0;
    while ( (op = fgetc( In ))  !=  EOF )
       {

        while( pc > Labels[ptr] )
            fprintf( Out, ";\t\t\t\tSync error, L%04X\n", Labels[ptr++]);

        if( pc == Labels[ptr] )
           {
            fprintf( Out, "L%04X:\t%s", pc, Op_Code[ op ] );
            ptr++;
           }
        else fprintf(Out, "\t%s", Op_Code[ op ] );
        
/*  Two byte opcode are followed by a byte parameter.
*/
        
        if ( Op_Code_Size[ op ]  ==  2 )
           {
            i = fgetc(In);
            if( i < 0xA0 )
                fprintf( Out, "%02Xh", i );
            else    fprintf( Out, "0%02Xh", i );
           }

/*  Three byte opcodes are followed by two bytes in reverse order.
*/
        if ( Op_Code_Size[ op ]  ==  3 )
           {
            i = fgetc(In);
            j = fgetc(In);
            fprintf( Out, "L%02X%02X", j,i );
           }

        fprintf( Out, "\n" );
        pc  += Op_Code_Size[ op ];
       }

    fclose( In );
    fclose( Out );
   }
