 Dungeons of Daggorath Dissassembly
 Chris Cantrell 1991


C000 CE   C0D1    LDU    #$C0D1         ;
C003 20   03      BRA    ($C008)        ;

C005 CE   C124    LDU    #$C124         ;

C008 10CE 1000    LDS    #$1000         ;
C00C 8E   FF00    LDX    #$FF00         ;
C00F CC   34FA    LDD    #$34FA         ;
C012 A7   03      STA    3,X            ;
C014 A7   01      STA    1,X            ;
C016 8E   FF20    LDX    #$FF20         ;
C019 A7   01      STA    1,X            ;
C01B 6F   03      CLR    3,X            ;
C01D E7   02      STB    2,X            ;
C01F 86   3C      LDA    #$3C           ;
C021 A7   03      STA    3,X            ;
C023 CC   2046    LDD    #$2046         ; 0010 0000 0100 0110
C026 BD   C266    JSR    ($C266)        ; Set SAM registers
C029 86   F8      LDA    #$F8           ;
C02B A7   02      STA    2,X            ;
C02D 8E   0200    LDX    #$0200         ;
C030 6F   80      CLR    ,X+            ;
C032 8C   4000    CMPX   #$4000         ;
C035 25   F9      BCS    ($C030)        ;
C037 EF   E3      STU    ,--S           ;
C039 86   02      LDA    #$02           ;
C03B 1F   8B      TFR    #$8B           ;
C03D 108E D7E8    LDY    #$D7E8         ;
C041 A6   A0      LDA    ,Y+            ;
C043 27   41      BEQ    ($C086)        ;
C045 AE   A1      LDX    ,Y++           ;
C047 8D   02      BSR    ($C04B)        ;
C049 20   F6      BRA    ($C041)        ;
C04B E6   A0      LDB    ,Y+            ;
C04D E7   80      STB    ,X+            ;
C04F 4A           DECA                  ;
C050 26   F9      BNE    ($C04B)        ;
C052 39           RTS                   ;

C053 34   77      PSHS   #$77           ;
C055 1A   10      ORCC   #$10           ;
C057 8E   029F    LDX    #$029F         ;
C05A 6F   80      CLR    ,X+            ;
C05C 8C   02AD    CMPX   #$02AD         ;
C05F 25   F9      BCS    ($C05A)        ;
C061 8E   09FD    LDX    #$09FD         ;
C064 9F   B9      STX    >$B9           ;
C066 6F   80      CLR    ,X+            ;
C068 8C   0B07    CMPX   #$0B07         ;
C06B 25   F9      BCS    ($C066)        ;
C06D 108E D7DC    LDY    #$D7DC         ;
C071 0A   BB      DEC    >$BB           ;
C073 CC   000C    LDD    #$000C         ;
C076 AE   A1      LDX    ,Y++           ;
C078 27   0A      BEQ    ($C084)        ;
C07A BD   C25C    JSR    ($C25C)        ;
C07D AF   43      STX    3,U            ;
C07F BD   C21D    JSR    ($C21D)        ;
C082 20   F2      BRA    ($C076)        ;
C084 35   F7      PULS   #$F7           ;
C086 8D   CB      BSR    ($C053)        ;
C088 CE   DA91    LDU    #$DA91         ;
C08B 4F           CLRA                  ;
C08C E6   C4      LDB    ,U             ;
C08E C4   0F      ANDB   #$0F           ;
C090 D7   8C      STB    >$8C           ;
C092 E6   C0      LDB    ,U+            ;
C094 54           LSRB                  ;
C095 54           LSRB                  ;
C096 54           LSRB                  ;
C097 54           LSRB                  ;
C098 D7   8D      STB    >$8D           ;
C09A 3F   17      SWI    #$17           ;
C09C 6A   05      DEC    5,X            ;
C09E 5C           INCB                  ;
C09F C1   05      CMPB   #$05           ;
C0A1 2F   02      BLE    ($C0A5)        ;
C0A3 D6   8D      LDB    >$8D           ;
C0A5 0A   8C      DEC    >$8C           ;
C0A7 26   F1      BNE    ($C09A)        ;
C0A9 4C           INCA                  ;
C0AA 1183 DAA3    CMPU   #$DAA3         ;
C0AE 25   DC      BCS    ($C08C)        ;
C0B0 CE   0388    LDU    #$0388         ;
C0B3 0A   B7      DEC    >$B7           ;
C0B5 3F   0A      SWI    #$0A           ;
C0B7 3F   02      SWI    #$02           ;
C0B9 F8   DF0C    EORB   ($DF0C)        ;
C0BC C9   27      ADCB   #$27           ;
C0BE 45           ????   #$27           ;
C0BF 00   02      NEG    >$02           ;
C0C1 65           ????   >$02           ;
C0C2 C1   03      CMPB   #$03           ;
C0C4 52           ????   #$03           ;
C0C5 39           RTS                   ;
C0C6 3C   00      CWAI   #$00           ;
C0C8 68   DA      ASL    ?post byte?    ;
C0CA CC   6309    LDD    #$6309         ;
C0CD 48           ASLA                  ;
C0CE 0F   B7      CLR    >$B7           ;
C0D0 39           RTS                   ;
C0D1 0A   77      DEC    >$77           ;
C0D3 8D   3F      BSR    ($C114)        ;
C0D5 8E   DF10    LDX    #$DF10         ;
C0D8 0A   9E      DEC    >$9E           ;
C0DA 3F   14      SWI    #$14           ;
C0DC 3F   02      SWI    #$02           ;
C0DE 9F   D2      STX    >$D2           ;
C0E0 02           ????   >$D2           ;
C0E1 06   45      ROR    >$45           ;
C0E3 06   4A      ROR    >$4A           ;
C0E5 02           ????   >$4A           ;
C0E6 BA   8597    ORA    ($8597)        ;
C0E9 BD   EF80    JSR    ($EF80)        ;
C0EC 3F   02      SWI    #$02           ;
C0EE F7   BDEA    STB    ($BDEA)        ;
C0F1 20   A0      BRA    ($C093)        ;
C0F3 25   5C      BCS    ($C151)        ;
C0F5 72           ????   ($C151)        ;
C0F6 BD   D303    JSR    ($D303)        ;
C0F9 CC   0204    LDD    #$0204         ;
C0FC E7   7C      STB    -4,S           ;
C0FE 83   446F    SUBD   #$446F         ;
C101 7B           ????   #$446F         ;
C102 3F   10      SWI    #$10           ;
C104 3F   10      SWI    #$10           ;
C106 3F   15      SWI    #$15           ;
C108 3F   09      SWI    #$09           ;
C10A 0A   B4      DEC    >$B4           ;
C10C 13           SYNC                  ;
C10D 86   02      LDA    #$02           ;
C10F CE   D7D5    LDU    #$D7D5         ;
C112 20   1D      BRA    ($C131)        ;
C114 CC   343C    LDD    #$343C         ;
C117 B7   FF21    STA    ($FF21)        ;
C11A F7   FF23    STB    ($FF23)        ;
C11D 4C           INCA                  ;
C11E B7   FF03    STA    ($FF03)        ;
C121 3C   EF      CWAI   #$EF           ;
C123 39           RTS                   ;
C124 8D   EE      BSR    ($C114)        ;
C126 CC   100B    LDD    #$100B         ;
C129 DD   13      STD    >$13           ;
C12B 0F   17      CLR    >$17           ;
C12D 4F           CLRA                  ;
C12E CE   D7D9    LDU    #$D7D9         ;
C131 3F   16      SWI    #$16           ;
C133 3F   1A      SWI    #$1A           ;
C135 108E 0229    LDY    #$0229         ;
C139 A6   C0      LDA    ,U+            ;
C13B 2B   12      BMI    ($C14F)        ;
C13D 3F   17      SWI    #$17           ;
C13F 6C   05      INC    5,X            ;
C141 1E   13      EXG    #$13           ;
C143 3F   18      SWI    #$18           ;
C145 1E   13      EXG    #$13           ;
C147 6F   0B      CLR    11,X           ;
C149 AF   A4      STX    ,Y             ;
C14B 1F   12      TFR    #$12           ;
C14D 20   EA      BRA    ($C139)        ;
C14F 0D   77      TST    >$77           ;
C151 27   13      BEQ    ($C166)        ;
C153 0A   9B      DEC    >$9B           ;
C155 8E   CDB2    LDX    #$CDB2         ;
C158 9F   B2      STX    >$B2           ;
C15A 0A   94      DEC    >$94           ;
C15C 3F   0E      SWI    #$0E           ;
C15E 3F   10      SWI    #$10           ;
C160 3F   10      SWI    #$10           ;
C162 0F   9B      CLR    >$9B           ;
C164 13           SYNC                  ;
C165 13           SYNC                  ;
C166 3F   19      SWI    #$19           ;
C168 3F   0F      SWI    #$0F           ;
C16A 7E   C1F5    JMP    ($C1F5)        ;
C16D BF   007E    STX    ($007E)        ;
C170 103F         SWI2                  ;
C172 06   4D      ROR    >$4D           ;
C174 1026 DEAF    LBNE   ($C166)        ;
C178 F6   007C    LDB    ($007C)        ;
C17B 39           RTS                   ;
C17C CE   FF00    LDU    #$FF00         ;
C17F CC   343C    LDD    #$343C         ;
C182 A7   43      STA    3,U            ;
C184 B7   FF23    STA    ($FF23)        ;
C187 F7   FF21    STB    ($FF21)        ;
C18A 39           RTS                   ;
C18B 9E   00      LDX    >$00           ;
C18D 30   1F      LEAX   -1,X           ;
C18F 26   FC      BNE    ($C18D)        ;
C191 39           RTS                   ;
C192 8D   E8      BSR    ($C17C)        ;
C194 8D   F5      BSR    ($C18B)        ;
C196 8D   F3      BSR    ($C18B)        ;
C198 103F         SWI2                  ;
C19A 0C   10      INC    >$10           ;
C19C 3F   08      SWI    #$08           ;
C19E 8D   EB      BSR    ($C18B)        ;
C1A0 103F         SWI2                  ;
C1A2 0C   8E      INC    >$8E           ;
C1A4 02           ????   >$8E           ;
C1A5 00   CC      NEG    >$CC           ;
C1A7 01           ????   >$CC           ;
C1A8 80   FD      SUBA   #$FD           ;
C1AA 00   7C      NEG    >$7C           ;
C1AC BF   007E    STX    ($007E)        ;
C1AF 103F         SWI2                  ;
C1B1 08   8C      ASL    >$8C           ;
C1B3 0F   05      CLR    >$05           ;
C1B5 25   EF      BCS    ($C1A6)        ;
C1B7 FF           ????   ($C1A6)        ;
C1B8 00   7C      NEG    >$7C           ;
C1BA 103F         SWI2                  ;
C1BC 08   8D      ASL    >$8D           ;
C1BE CC   202B    LDD    #$202B         ;
C1C1 8D   B9      BSR    ($C17C)        ;
C1C3 103F         SWI2                  ;
C1C5 04   DE      LSR    >$DE           ;
C1C7 0B           ????   >$DE           ;
C1C8 AE   C4      LDX    ,U             ;
C1CA 8D   A1      BSR    ($C16D)        ;
C1CC 26   F8      BNE    ($C1C6)        ;
C1CE AE   C4      LDX    ,U             ;
C1D0 CE   0313    LDU    #$0313         ;
C1D3 C6   08      LDB    #$08           ;
C1D5 A6   80      LDA    ,X+            ;
C1D7 A1   C0      CMPA   ,U+            ;
C1D9 26   E6      BNE    ($C1C1)        ;
C1DB 5A           DECB                  ;
C1DC 26   F7      BNE    ($C1D5)        ;
C1DE 103F         SWI2                  ;
C1E0 04   8E      LSR    >$8E           ;
C1E2 02           ????   >$8E           ;
C1E3 00   8D      NEG    >$8D           ;
C1E5 87           ????   >$8D           ;
C1E6 2A   FC      BPL    ($C1E4)        ;
C1E8 10CE 1000    LDS    #$1000         ;
C1EC BD   C114    JSR    ($C114)        ;
C1EF 0F   B8      CLR    >$B8           ;
C1F1 3F   19      SWI    #$19           ;
C1F3 3F   0F      SWI    #$0F           ;
C1F5 CE   02AB    LDU    #$02AB         ;
C1F8 0F   BB      CLR    >$BB           ;
C1FA 1F   32      TFR    #$32           ;
C1FC 0D   B8      TST    >$B8           ;
C1FE 2E   92      BGT    ($C192)        ;
C200 2B   BF      BMI    ($C1C1)        ;
C202 EE   C4      LDU    ,U             ;
C204 27   EF      BEQ    ($C1F5)        ;
C206 34   60      PSHS   #$60           ;
C208 AD   D8 03   JSR    [$03,U]        ;
C20B 35   60      PULS   #$60           ;
C20D 0D   BB      TST    >$BB           ;
C20F 26   E4      BNE    ($C1F5)        ;
C211 C1   0C      CMPB   #$0C           ;
C213 27   E5      BEQ    ($C1FA)        ;
C215 8D   21      BSR    ($C238)        ;
C217 8D   04      BSR    ($C21D)        ;
C219 1F   23      TFR    #$23           ;
C21B 20   DF      BRA    ($C1FC)        ;
C21D 34   17      PSHS   #$17           ;
C21F 1A   10      ORCC   #$10           ;
C221 A7   42      STA    2,U            ;
C223 8E   029F    LDX    #$029F         ;
C226 3A           ABX                   ;
C227 4F           CLRA                  ;
C228 5F           CLRB                  ;
C229 ED   C4      STD    ,U             ;
C22B 10A3 84      CMPD   ,X             ;
C22E 27   04      BEQ    ($C234)        ;
C230 AE   84      LDX    ,X             ;
C232 20   F7      BRA    ($C22B)        ;
C234 EF   84      STU    ,X             ;
C236 35   97      PULS   #$97           ;
C238 34   11      PSHS   #$11           ;
C23A 1A   10      ORCC   #$10           ;
C23C AE   C4      LDX    ,U             ;
C23E AF   A4      STX    ,Y             ;
C240 35   91      PULS   #$91           ;
C242 34   74      PSHS   #$74           ;
C244 0D   9B      TST    >$9B           ;
C246 26   12      BNE    ($C25A)        ;
C248 1F   32      TFR    #$32           ;
C24A EE   C4      LDU    ,U             ;
C24C 27   0C      BEQ    ($C25A)        ;
C24E 6A   42      DEC    2,U            ;
C250 26   F6      BNE    ($C248)        ;
C252 8D   E4      BSR    ($C238)        ;
C254 C6   0C      LDB    #$0C           ;
C256 8D   C5      BSR    ($C21D)        ;
C258 20   EE      BRA    ($C248)        ;
C25A 35   F4      PULS   #$F4           ;
C25C 34   10      PSHS   #$10           ;
C25E DE   B9      LDU    >$B9           ;
C260 30   47      LEAX   7,U            ;
C262 9F   B9      STX    >$B9           ;
C264 35   90      PULS   #$90           ;

C266 34   16      PSHS   #$16           ; Save registers
C268 8E   FFC0    LDX    #$FFC0         ; Start of SAM
C26B 44           LSRA                  ; Roll ...
C26C 56           RORB                  ; ... value
C26D 25   03      BCS    ($C272)        ; If Bit is set jump to setter
C26F A7   84      STA    ,X             ; Clear
C271 8C   A701    CMPX   #$A701         ; Skip setter "STA 1,X"
C274 30   02      LEAX   2,X            ; Next bit
C276 8C   FFD4    CMPX   #$FFD4         ; All done?
C279 25   F0      BCS    ($C26B)        ; Nope ... go back
C27B 35   96      PULS   #$96           ; Restore registers and return

; Interrupts come here

C27D 8E   FF20    LDX    #$FF20         ;
C280 A6   88 E3   LDA    $E3,X          ;
C283 102A 0099    LBPL   ($C26B)        ;
C287 86   02      LDA    #$02           ;
C289 1F   8B      TFR    #$8B           ;
C28B 0D   B4      TST    >$B4           ; Swap screen request?
C28D 27   0E      BEQ    ($C29D)        ; No ... skip it
C28F DC   09      LDD    >$09           ; Swap descriptors ...
C291 DE   0B      LDU    >$0B           ; ... at 09 ...
C293 DD   0B      STD    >$0B           ; ... and ...
C295 DF   09      STU    >$09           ; ... 0B ...
C297 EC   44      LDD    4,U            ; Get current descriptor
C299 8D   CB      BSR    ($C266)        ; SAM registers
C29B 0F   B4      CLR    >$B4           ; Screen flipped
C29D 0D   9C      TST    >$9C           ;
C29F 27   08      BEQ    ($C2A9)        ;
C2A1 03   9D      COM    >$9D           ;
C2A3 96   9D      LDA    >$9D           ;
C2A5 48           ASLA                  ;
C2A6 48           ASLA                  ;
C2A7 A7   84      STA    ,X             ;
C2A9 0D   B1      TST    >$B1           ;
C2AB 27   2F      BEQ    ($C2DC)        ;
C2AD 0A   AE      DEC    >$AE           ;
C2AF 26   2B      BNE    ($C2DC)        ;
C2B1 96   AF      LDA    >$AF           ;
C2B3 97   AE      STA    >$AE           ;
C2B5 E6   02      LDB    2,X            ;
C2B7 C8   02      EORB   #$02           ;
C2B9 E7   02      STB    2,X            ;
C2BB 0D   AD      TST    >$AD           ;
C2BD 27   1D      BEQ    ($C2DC)        ;
C2BF CE   0388    LDU    #$0388         ;
C2C2 AE   44      LDX    4,U            ;
C2C4 CC   000F    LDD    #$000F         ;
C2C7 ED   44      STD    4,U            ;
C2C9 86   20      LDA    #$20           ;
C2CB 03   B0      COM    >$B0           ;
C2CD 27   02      BEQ    ($C2D1)        ;
C2CF 86   22      LDA    #$22           ;
C2D1 BD   CA17    JSR    ($CA17)        ;
C2D4 6C   45      INC    5,U            ;
C2D6 4C           INCA                  ;
C2D7 BD   CA17    JSR    ($CA17)        ;
C2DA AF   44      STX    4,U            ;
C2DC CE   02A1    LDU    #$02A1         ;
C2DF BD   C242    JSR    ($C242)        ;
C2E2 8E   0295    LDX    #$0295         ;
C2E5 108E C324    LDY    #$C324         ;
C2E9 6C   84      INC    ,X             ;
C2EB 8C   029A    CMPX   #$029A         ;
C2EE 27   0F      BEQ    ($C2FF)        ;
C2F0 A6   84      LDA    ,X             ;
C2F2 A1   A0      CMPA   ,Y+            ;
C2F4 2D   09      BLT    ($C2FF)        ;
C2F6 6F   80      CLR    ,X+            ;
C2F8 33   42      LEAU   2,U            ;
C2FA BD   C242    JSR    ($C242)        ;
C2FD 20   EA      BRA    ($C2E9)        ;
C2FF 0D   28      TST    >$28           ;
C301 26   1D      BNE    ($C320)        ;
C303 0D   77      TST    >$77           ;
C305 27   11      BEQ    ($C318)        ;
C307 7F   FF02    CLR    ($FF02)        ;
C30A B6   FF00    LDA    ($FF00)        ;
C30D 84   7F      ANDA   #$7F           ;
C30F 81   7F      CMPA   #$7F           ;
C311 27   0D      BEQ    ($C320)        ;
C313 8E   C005    LDX    #$C005         ;
C316 AF   6A      STX    10,S           ;
C318 103F         SWI2                  ;
C31A 00   4D      NEG    >$4D           ;
C31C 27   02      BEQ    ($C320)        ;
C31E 8D   20      BSR    ($C340)        ;
C320 B6   FF02    LDA    ($FF02)        ;
C323 3B           RTI                   ;
C324 06   0A      ROR    >$0A           ;
C326 3C   3C      CWAI   #$3C           ;
C328 18           ????   #$3C           ;
C329 34   15      PSHS   #$15           ;
C32B 1A   10      ORCC   #$10           ;
C32D 4F           CLRA                  ;
C32E 8E   02D1    LDX    #$02D1         ;
C331 D6   BC      LDB    >$BC           ;
C333 D1   BD      CMPB   >$BD           ;
C335 27   07      BEQ    ($C33E)        ;
C337 A6   85      LDA    B,X            ;
C339 5C           INCB                  ;
C33A C4   1F      ANDB   #$1F           ;
C33C D7   BC      STB    >$BC           ;
C33E 35   95      PULS   #$95           ;
C340 34   15      PSHS   #$15           ;
C342 1A   10      ORCC   #$10           ;
C344 8E   02D1    LDX    #$02D1         ;
C347 D6   BD      LDB    >$BD           ;
C349 A7   85      STA    B,X            ;
C34B 5C           INCB                  ;
C34C C4   1F      ANDB   #$1F           ;
C34E D7   BD      STB    >$BD           ;
C350 35   95      PULS   #$95           ;

; SWI comes here

C352 1C   EF      ANDCC  #$EF           ;
C354 AE   6A      LDX    10,S           ;
C356 A6   80      LDA    ,X+            ;
C358 AF   6A      STX    10,S           ;
C35A 8E   C384    LDX    #$C384         ;
C35D CE   C995    LDU    #$C995         ;
C360 E6   C0      LDB    ,U+            ;
C362 3A           ABX                   ;
C363 4A           DECA                  ;
C364 2A   FA      BPL    ($C360)        ;
C366 AF   E3      STX    ,--S           ;
C368 EC   63      LDD    3,S            ;
C36A AE   66      LDX    6,S            ;
C36C EE   6A      LDU    10,S           ;
C36E AD   F1      JSR    [,S++]         ;
C370 3B           RTI                   ;

; SWI2 comes here

C371 5F           CLRB                  ;
C372 1F   9B      TFR    #$9B           ;
C374 EE   6A      LDU    10,S           ;
C376 E6   C0      LDB    ,U+            ;
C378 EF   6A      STU    10,S           ;
C37A CE   A000    LDU    #$A000         ;
C37D AD   D5      JSR    [B,U]          ;
C37F A7   61      STA    1,S            ;
C381 AF   64      STX    4,S            ;
C383 3B           RTI                   ;

; SWI 0

C384 96   6E      LDA    >$6E           ;
C386 0D   75      TST    >$75           ;
C388 27   04      BEQ    ($C38E)        ;
C38A 96   6F      LDA    >$6F           ;
C38C 0F   75      CLR    >$75           ;
C38E 5F           CLRB                  ;
C38F 80   07      SUBA   #$07           ;
C391 90   8B      SUBA   >$8B           ;
C393 2C   0A      BGE    ($C39F)        ;
C395 5A           DECB                  ;
C396 81   F9      CMPA   #$F9           ;
C398 2F   05      BLE    ($C39F)        ;
C39A 8E   CB96    LDX    #$CB96         ;
C39D E6   86      LDB    A,X            ;
C39F D7   2D      STB    >$2D           ;
C3A1 39           RTS                   ;

; SWI 1 Draw picture X on screen

C3A2 0F   51      CLR    >$51           ; Starting new line segment
C3A4 96   2D      LDA    >$2D           ; Dot Frequency
C3A6 4C           INCA                  ; Anything to draw?
C3A7 27   4D      BEQ    ($C3F6)        ; No, out
C3A9 E6   84      LDB    ,X             ; Else get command
C3AB C0   FA      SUBB   #$FA           ; Is this a command?
C3AD 25   20      BCS    ($C3CF)        ; No, go to standard line
C3AF 30   01      LEAX   1,X            ; Next in list
C3B1 108E C3B9    LDY    #$C3B9         ; Graphics Commands
C3B5 E6   A5      LDB    B,Y            ; Get offset
C3B7 6E   A5      JMP    B,Y            ; Go to command
C3B9 10   0: Return from graphic sub.
C3BA 06   1: Jump to subroutine
C3BB 5E   2: Multiple short segmets
C3BC 0D   3: Jump to xxxx
C3BD 3D   4: Exit
C3BE 12   5: Start a new segment
; Command 01:
C3BF EC   81      LDD    ,X++           ; Get new address
C3C1 AF   E3      STX    ,--S           ; Save return
C3C3 1F   01      TFR    #$01           ; D->X
; Command 03:
C3C5 8C   AE84    CMPX   #$AE84         ; LDX ,X Jump to address
; Command 00:
C3C8 8C   AEE1    CMPX   #$AEE1         ; LDX ,S++ Return from subroutine
; Command 05: Start a new segment
C3CB 0F   51      CLR    >$51           ; New segment
C3CD 20   DA      BRA    ($C3A9)        ; Continue
C3CF 0D   51      TST    >$51           ; Already have start point?
C3D1 26   06      BNE    ($C3D9)        ; Yes, skip this
C3D3 8D   0D      BSR    ($C3E2)        ; Get coordinates
C3D5 0A   51      DEC    >$51           ; Flag now have a start
C3D7 20   D0      BRA    ($C3A9)        ; Continue
C3D9 8D   05      BSR    ($C3E0)        ; Set up new segment
C3DB BD   CAB7    JSR    ($CAB7)        ; Draw line
C3DE 20   C9      BRA    ($C3A9)        ; Back for more
C3E0 8D   15      BSR    ($C3F7)        ; Move old end to new start
C3E2 E6   80      LDB    ,X+            ; Y coordinate
C3E4 D7   54      STB    >$54           ; Hold on to it
C3E6 8D   18      BSR    ($C400)        ;
C3E8 D3   07      ADDD   >$07           ; Y center of screen
C3EA DD   33      STD    >$33           ; Store new end Y
C3EC E6   80      LDB    ,X+            ; X coordinate
C3EE D7   52      STB    >$52           ; Hold on to it
C3F0 8D   14      BSR    ($C406)        ; 
C3F2 D3   05      ADDD   >$05           ; X center of screen
C3F4 DD   35      STD    >$35           ; Store new end X
; Command 04: Exit
C3F6 39           RTS                   ;
C3F7 DC   33      LDD    >$33           ; Move old Y...
C3F9 DD   2F      STD    >$2F           ; ... to new Y
C3FB DC   35      LDD    >$35           ; Move old X
C3FD DD   31      STD    >$31           ; ... to new X
C3FF 39           RTS                   ;
C400 96   50      LDA    >$50           ; Y Scale factor
C402 D0   08      SUBB   >$08           ; Y byte center of screen
C404 20   04      BRA    ($C40A)        ; Handle signed multiply
C406 96   4F      LDA    >$4F           ; X scale factor
C408 D0   06      SUBB   >$06           ; X byte center of screen
C40A 25   03      BCS    ($C40F)        ; Handle signed multiply
C40C 3D           MUL                   ; Do multiplication
C40D 20   05      BRA    ($C414)        ; 
C40F 50           NEGB                  ; Make it positive
C410 3D           MUL                   ; Do multiply
C411 BD   CA99    JSR    ($CA99)        ; Negate D
C414 7E   D377    JMP    ($D377)        ; Divide D by 128 (fractional math)
; Command 02: Multiple short segments
C417 A6   80      LDA    ,X+            ; Next description
C419 27   B0      BEQ    ($C3CB)        ; 0 means done
C41B 8D   DA      BSR    ($C3F7)        ; Move old end to new beginning
C41D E6   1F      LDB    -1,X           ; Byte
C41F 57           ASRB                  ;
C420 57           ASRB                  ;
C421 57           ASRB                  ; Upper 4 bits * 2
C422 57           ASRB                  ;
C423 58           ASLB                  ;
C424 DB   54      ADDB   >$54           ; Add to old Y
C426 D7   54      STB    >$54           ; New Y
C428 8D   D6      BSR    ($C400)        ; Do multiply and prepare
C42A D3   07      ADDD   >$07           ; Offset center of screen
C42C DD   33      STD    >$33           ; Save new Y
C42E E6   1F      LDB    -1,X           ; Descriptor
C430 C4   0F      ANDB   #$0F           ; Lower four bits
C432 C5   08      BITB   #$08           ; Is this negative? 
C434 27   02      BEQ    ($C438)        ; No,
C436 CA   F0      ORB    #$F0           ; Else make it negative
C438 58           ASLB                  ; *2
C439 DB   52      ADDB   >$52           ; Offset X coordinate
C43B D7   52      STB    >$52           ; Store New
C43D 8D   C7      BSR    ($C406)        ; Scale it
C43F D3   05      ADDD   >$05           ; Add offset to center
C441 DD   35      STD    >$35           ; Absolute coordinate
C443 BD   CAB7    JSR    ($CAB7)        ; Draw line segment
C446 20   CF      BRA    ($C417)        ; Continue multiple segments

; SWI 2 Uncompress and display immediate message

C448 AE   6C      LDX    12,S           ;
C44A 3F   05      SWI    #$05           ;
C44C AF   6C      STX    12,S           ;
C44E 8E   0335    LDX    #$0335         ;
C451 8C   3F04    CMPX   #$3F04         ;

; SWI 3 Display uncompressed message pointed to by X

C454 A6   80      LDA    ,X+            ;
C456 2A   FA      BPL    ($C452)        ;
C458 39           RTS                   ;

; SWI 4 Display a single character

C459 0D   B7      TST    >$B7           ;
C45B 26   03      BNE    ($C460)        ;
C45D CE   0390    LDU    #$0390         ;
C460 AE   44      LDX    4,U            ;
C462 BD   C9B2    JSR    ($C9B2)        ;
C465 AC   42      CMPX   2,U            ;
C467 25   03      BCS    ($C46C)        ;
C469 BD   C9D4    JSR    ($C9D4)        ;
C46C AF   44      STX    4,U            ;
C46E 39           RTS                   ;

; SWI 5 Uncompress message to buffer

C46F CE   0335    LDU    #$0335         ;
C472 31   5F      LEAY   -1,U           ;
C474 6F   A4      CLR    ,Y             ;
C476 8D   14      BSR    ($C48C)        ;
C478 1F   98      TFR    #$98           ;
C47A 8D   10      BSR    ($C48C)        ;
C47C E7   C0      STB    ,U+            ;
C47E 4A           DECA                  ;
C47F 2A   F9      BPL    ($C47A)        ;
C481 A7   C4      STA    ,U             ;
C483 6D   A4      TST    ,Y             ;
C485 27   02      BEQ    ($C489)        ;
C487 30   01      LEAX   1,X            ;
C489 AF   66      STX    6,S            ;
C48B 39           RTS                   ;

; SWI 6 Uncompress routine

C48C 34   42      PSHS   #$42           ;
C48E A6   A4      LDA    ,Y             ;
C490 CE   C4A2    LDU    #$C4A2         ;
C493 A6   C6      LDA    A,U            ;
C495 AD   C6      JSR    A,U            ;
C497 A6   A4      LDA    ,Y             ;
C499 4C           INCA                  ;
C49A 84   07      ANDA   #$07           ;
C49C A7   A4      STA    ,Y             ;
C49E C4   1F      ANDB   #$1F           ;
C4A0 35   C2      PULS   #$C2           ;
C4A2 08   0E      ASL    >$0E           ;
C4A4 13           SYNC                  ;
C4A5 17   1C21    LBSR   ($C489)        ;
C4A8 25   2A      BCS    ($C4D4)        ;
C4AA E6   84      LDB    ,X             ;
C4AC 54           LSRB                  ;
C4AD 54           LSRB                  ;
C4AE 54           LSRB                  ;
C4AF 39           RTS                   ;
C4B0 EC   80      LDD    ,X+            ;
C4B2 7E   D379    JMP    ($D379)        ;
C4B5 E6   84      LDB    ,X             ;
C4B7 20   F5      BRA    ($C4AE)        ;
C4B9 EC   80      LDD    ,X+            ;
C4BB 7E   D37D    JMP    ($D37D)        ;
C4BE EC   80      LDD    ,X+            ;
C4C0 7E   D377    JMP    ($D377)        ;
C4C3 E6   84      LDB    ,X             ;
C4C5 20   E6      BRA    ($C4AD)        ;
C4C7 EC   80      LDD    ,X+            ;
C4C9 7E   D37B    JMP    ($D37B)        ;
C4CC E6   80      LDB    ,X+            ;
C4CE 39           RTS                   ;

; SWI 8 Return random number in A

C4CF 8E   0008    LDX    #$0008         ;
C4D2 5F           CLRB                  ;
C4D3 108E 0008    LDY    #$0008         ;
C4D7 96   6D      LDA    >$6D           ;
C4D9 84   E1      ANDA   #$E1           ;
C4DB 48           ASLA                  ;
C4DC 24   01      BCC    ($C4DF)        ;
C4DE 5C           INCB                  ;
C4DF 31   3F      LEAY   -1,Y           ;
C4E1 26   F8      BNE    ($C4DB)        ;
C4E3 54           LSRB                  ;
C4E4 09   6B      ROL    >$6B           ;
C4E6 09   6C      ROL    >$6C           ;
C4E8 09   6D      ROL    >$6D           ;
C4EA 30   1F      LEAX   -1,X           ;
C4EC 26   E4      BNE    ($C4D2)        ;
C4EE 96   6B      LDA    >$6B           ;
C4F0 A7   63      STA    3,S            ;
C4F2 39           RTS                   ;

; SWI 9

C4F3 DE   09      LDU    >$09           ;
C4F5 8C   DE0B    CMPX   #$DE0B         ;

; SWI A
                  LDU    >$0B           ;
C4F8 D6   2C      LDB    >$2C           ;
C4FA 8D   1B      BSR    ($C517)        ;
C4FC EF   6A      STU    10,S           ;
C4FE 39           RTS                   ;

; SWI B

C4FF 8E   0388    LDX    #$0388         ; Hand descriptor space
C502 CE   D87C    LDU    #$D87C         ; Clearing Data
C505 20   06      BRA    ($C50D)        ; Clear out hand descriptor

; SWI C

C507 8E   0390    LDX    #$0390         ; Playing field
C50A CE   D888    LDU    #$D888         ; Clearing Data
C50D 6F   04      CLR    4,X            ; Move cursor...
C50F 6F   05      CLR    5,X            ; ... to beginning
C511 E6   06      LDB    6,X            ; Color
C513 8D   02      BSR    ($C517)        ; Clear space
C515 33   46      LEAU   6,U            ; Now clear command lines
C517 34   76      PSHS   #$76           ;
C519 1D           SEX                   ; Expand color mask to word
C51A 1F   02      TFR    #$02           ; D->Y for a double word
C51C 30   C4      LEAX   ,U             ; First in space
C51E EE   42      LDU    2,U            ; Last in space
C520 36   26      PSHU   #$26           ; Wipe 2 word area
C522 11A3 84      CMPU   ,X             ; Done?
C525 26   F9      BNE    ($C520)        ; No, do all
C527 35   F6      PULS   #$F6           ; Out

; SWI D

C529 0F   C1      CLR    >$C1           ;
C52B DC   17      LDD    >$17           ; Strength
C52D DD   C2      STD    >$C2           ;
C52F 86   06      LDA    #$06           ;
C531 08   C3      ASL    >$C3           ;
C533 09   C2      ROL    >$C2           ;
C535 09   C1      ROL    >$C1           ;
C537 4A           DECA                  ;
C538 26   F7      BNE    ($C531)        ;
C53A 0F   C4      CLR    >$C4           ;
C53C DC   21      LDD    >$21           ;
C53E DD   C5      STD    >$C5           ;
C540 08   C6      ASL    >$C6           ;
C542 09   C5      ROL    >$C5           ;
C544 09   C4      ROL    >$C4           ;
C546 DC   17      LDD    >$17           ;
C548 D3   C5      ADDD   >$C5           ;
C54A DD   C5      STD    >$C5           ;
C54C D6   C4      LDB    >$C4           ;
C54E C9   00      ADCB   #$00           ;
C550 D7   C4      STB    >$C4           ;
C552 0F   C7      CLR    >$C7           ;
C554 DC   C2      LDD    >$C2           ;
C556 93   C5      SUBD   >$C5           ;
C558 DD   C2      STD    >$C2           ;
C55A 96   C1      LDA    >$C1           ;
C55C 92   C4      SBCA   >$C4           ;
C55E 97   C1      STA    >$C1           ;
C560 0C   C7      INC    >$C7           ;
C562 24   F0      BCC    ($C554)        ;
C564 96   C7      LDA    >$C7           ;
C566 80   13      SUBA   #$13           ;
C568 97   AF      STA    >$AF           ;
C56A 0D   28      TST    >$28           ;
C56C 26   27      BNE    ($C595)        ;
C56E 81   03      CMPA   #$03           ;
C570 2E   3C      BGT    ($C5AE)        ;
C572 3F   0B      SWI    #$0B           ;
C574 96   6E      LDA    >$6E           ;
C576 97   70      STA    >$70           ;
C578 0A   6F      DEC    >$6F           ;
C57A AD   9F 02B2 JSR    [$02B2]        ; Display playing screen
C57E 0A   B4      DEC    >$B4           ;
C580 13           SYNC                  ; Wait for display
C581 0A   6E      DEC    >$6E           ; Light level down
C583 96   6E      LDA    >$6E           ; Down 
C585 81   F8      CMPA   #$F8           ; All fainted out?
C587 2E   EF      BGT    ($C578)        ; No, keep going
C589 3F   09      SWI    #$09           ; Clear screen
C58B 0A   B4      DEC    >$B4           ;
C58D 0A   28      DEC    >$28           ;
C58F 0F   BC      CLR    >$BC           ;
C591 0F   BD      CLR    >$BD           ;
C593 20   19      BRA    ($C5AE)        ;
C595 81   04      CMPA   #$04           ;
C597 2F   15      BLE    ($C5AE)        ;
C599 AD   9F 02B2 JSR    [$02B2]        ; Display playing screen
C59D 0A   B4      DEC    >$B4           ;
C59F 13           SYNC                  ; Wait a display	
C5A0 0C   6F      INC    >$6F           ;
C5A2 0C   6E      INC    >$6E           ;
C5A4 96   6E      LDA    >$6E           ;
C5A6 91   70      CMPA   >$70           ;
C5A8 2F   EF      BLE    ($C599)        ;
C5AA 0F   28      CLR    >$28           ;
C5AC 3F   0F      SWI    #$0F           ; Display playing screen
C5AE 9E   17      LDX    >$17           ; Strength
C5B0 9C   21      CMPX   >$21           ; Heart level
C5B2 25   01      BCS    ($C5B5)        ; Can not support it, die
C5B4 39           RTS                   ;

 Player is dead!

C5B5 8E   DF10    LDX    #$DF10         ; Beam on Wizard
C5B8 0A   9E      DEC    >$9E           ;
C5BA 3F   13      SWI    #$13           ;
C5BC 3F   02      SWI    #$02           ; Print "Yet Another Does Not Return"
C5BE FF           ????   #$02           ;
C5BF C1   92      CMPB   #$92           ;
C5C1 D0   01      SUBB   >$01           ;
C5C3 73   E882    COM    ($E882)        ;
C5C6 C8   04      EORB   #$04           ;
C5C8 79   6607    ROL    ($6607)        ;
C5CB 3E           ????   ($6607)        ;
C5CC 80   91      SUBA   #$91           ;
C5CE 69   59      ROL    -7,U           ;
C5D0 3B           RTI                   ;
C5D1 DE   F0      LDU    >$F0           ;
C5D3 0F   28      CLR    >$28           ;
C5D5 0A   77      DEC    >$77           ;
C5D7 20   FE      BRA    ($C5D7)        ; ENDLESS LOOP

; SWI E   Print contenets of hands on ststus line

C5D9 CE   0388    LDU    #$0388         ; Hand line descriptor
C5DC 0A   B7      DEC    >$B7           ; Don't allow screen update
C5DE 96   2C      LDA    >$2C           ; Base color
C5E0 43           COMA                  ; Hands are reverse color
C5E1 A7   46      STA    6,U            ; New color
C5E3 4F           CLRA                  ; Coordinates...
C5E4 5F           CLRB                  ; ...far left
C5E5 8D   22      BSR    ($C609)        ; Blank left hand slot
C5E7 ED   44      STD    4,U            ; Reposition cursor
C5E9 9E   1D      LDX    >$1D           ; Left hand object
C5EB 8D   2A      BSR    ($C617)        ; Create string
C5ED 3F   03      SWI    #$03           ; And print
C5EF CC   0011    LDD    #$0011         ; Start of right hand space
C5F2 8D   15      BSR    ($C609)        ; Blank right hand area
C5F4 9E   1F      LDX    >$1F           ; Right hand object
C5F6 8D   1F      BSR    ($C617)        ; Decode it
C5F8 1F   12      TFR    #$12           ; Over to Y
C5FA CC   0021    LDD    #$0021         ; Far right coordinates
C5FD 5A           DECB                  ; Shift right hand from right
C5FE 6D   A0      TST    ,Y+            ; All accounted for?
C600 2A   FB      BPL    ($C5FD)        ; No, keep counting from right
C602 ED   44      STD    4,U            ; Coordinates for right hand
C604 3F   03      SWI    #$03           ; Print right hand contents
C606 0F   B7      CLR    >$B7           ; Clear to display now
C608 39           RTS                   ;
C609 34   06      PSHS   #$06           ;
C60B ED   44      STD    4,U            ; Coordinates
C60D CC   000F    LDD    #$000F         ; 15
C610 3F   04      SWI    #$04           ; Print a space
C612 5A           DECB                  ; All blanked?
C613 26   FB      BNE    ($C610)        ; No, blank all
C615 35   86      PULS   #$86           ;
C617 34   66      PSHS   #$66           ;
C619 31   84      LEAY   ,X             ; Get pointer to object
C61B 26   05      BNE    ($C622)        ; Yes, it is something
C61D 8E   C650    LDX    #$C650         ; EMPTY message
C620 20   1A      BRA    ($C63C)        ; Skip all decoding and use EMPTY
C622 CE   0313    LDU    #$0313         ; Buffer for hand printing
C625 6D   2B      TST    11,Y           ; Revealed?
C627 26   09      BNE    ($C632)        ; No, skip proper name
C629 A6   29      LDA    9,Y            ; Get proper name token
C62B 8E   D8F4    LDX    #$D8F4         ; Proper name table
C62E 8D   0E      BSR    ($C63E)        ; Find proper name
C630 6F   5F      CLR    -1,U           ; Stick space on end of proper name
C632 A6   2A      LDA    10,Y           ; Object class
C634 8E   D96B    LDX    #$D96B         ; Class name table
C637 8D   05      BSR    ($C63E)        ; Find class name
C639 8E   0313    LDX    #$0313         ; Return pointer to buffer
C63C 35   E6      PULS   #$E6           ;
C63E 34   12      PSHS   #$12           ;
C640 3F   05      SWI    #$05           ; Uncompress message
C642 4A           DECA                  ; Found proper one?
C643 2A   FB      BPL    ($C640)        ; No, keep going
C645 8E   0336    LDX    #$0336         ; Uncompress buffer
C648 A6   80      LDA    ,X+            ; Copy from uncompressed...
C64A A7   C0      STA    ,U+            ; ... to hand string
C64C 2A   FA      BPL    ($C648)        ; Copy all, including end marker
C64E 35   92      PULS   #$92           ;
C650 05           'E'
C651 0D           'M'
C652 10           'P'
C653 14           'T'
C654 19           'Y'
C655 FF           END

; SWI F Display playing screen

C656 0D   28      TST    >$28           ; Needs refreshing?
C658 26   05      BNE    ($C65F)        ; No, skip it
C65A 8D   04      BSR    ($C660)        ; Refresh display
C65C 0A   B4      DEC    >$B4           ;
C65E 13           SYNC                  ; Wait on display
C65F 39           RTS                   ; Out
C660 34   76      PSHS   #$76           ;
C662 DC   26      LDD    >$26           ; Abient light level
C664 DE   24      LDU    >$24           ; Torch pointer
C666 27   04      BEQ    ($C66C)        ; No torch lit, go with ambient level
C668 AB   47      ADDA   7,U            ; Add ambient...
C66A EB   48      ADDB   8,U            ; ... to torch's power
C66C DD   6E      STD    >$6E           ; Light level to display things with
C66E AD   9F 02B2 JSR    [$02B2]        ; Refresh screen
C672 35   F6      PULS   #$F6           ;

; SWI 10 Ready command prompt

C674 8E   C67A    LDX    #$C67A         ; Prompt CR and cursor
C677 3F   03      SWI    #$03           ; Print it	
C679 39           RTS                   ;
C67A 1F   1E      TFR    #$1E           ;
C67C 1C   24      ANDCC  #$24           ;
C67E FF           ????   #$24           ;
C67F C6   51      LDB    #$51           ;
C681 13           SYNC                  ;
C682 5A           DECB                  ;
C683 26   FC      BNE    ($C681)        ;
C685 39           RTS                   ;
C686 4F           CLRA                  ;
C687 8C   86FF    CMPX   #$86FF         ;
C68A A7   80      STA    ,X+            ;
C68C AC   6A      CMPX   10,S           ;
C68E 26   FA      BNE    ($C68A)        ;
C690 39           RTS                   ;
C691 5F           CLRB                  ;
C692 1F   9B      TFR    #$9B           ;
C694 EE   6C      LDU    12,S           ;
C696 E6   C0      LDB    ,U+            ;
C698 EF   6C      STU    12,S           ;
C69A CE   A000    LDU    #$A000         ;
C69D AD   D5      JSR    [B,U]          ;
C69F A7   63      STA    3,S            ;
C6A1 AF   66      STX    6,S            ;
C6A3 39           RTS                   ;
C6A4 0F   B1      CLR    >$B1           ;
C6A6 3F   0A      SWI    #$0A           ;
C6A8 3F   0B      SWI    #$0B           ;
C6AA CC   8080    LDD    #$8080         ;
C6AD DD   4F      STD    >$4F           ;
C6AF D6   9E      LDB    >$9E           ;
C6B1 27   04      BEQ    ($C6B7)        ;
C6B3 C6   20      LDB    #$20           ;
C6B5 0A   9C      DEC    >$9C           ;
C6B7 8D   1E      BSR    ($C6D7)        ;
C6B9 5A           DECB                  ;
C6BA 5A           DECB                  ;
C6BB 2A   FA      BPL    ($C6B7)        ;
C6BD 0F   9C      CLR    >$9C           ;
C6BF 0F   9E      CLR    >$9E           ;
C6C1 3F   1B      SWI    #$1B           ;
C6C3 16   136D    LBRA   ($C6B7)        ;
C6C6 0B           ????   ($C6B7)        ;
C6C7 8D   F8      BSR    ($C6C1)        ;
C6C9 5F           CLRB                  ;
C6CA 0A   9C      DEC    >$9C           ;
C6CC 8D   09      BSR    ($C6D7)        ;
C6CE 5C           INCB                  ;
C6CF 5C           INCB                  ;
C6D0 C1   20      CMPB   #$20           ;
C6D2 26   F8      BNE    ($C6CC)        ;
C6D4 0F   9C      CLR    >$9C           ;
C6D6 39           RTS                   ;
C6D7 34   50      PSHS   #$50           ;
C6D9 D7   2D      STB    >$2D           ;
C6DB D7   9D      STB    >$9D           ;
C6DD 3F   09      SWI    #$09           ;
C6DF 3F   01      SWI    #$01           ;
C6E1 0A   B4      DEC    >$B4           ;
C6E3 13           SYNC                  ;
C6E4 35   D0      PULS   #$D0           ;
C6E6 BD   D489    JSR    ($D489)        ;
C6E9 CC   012C    LDD    #$012C         ;
C6EC ED   44      STD    4,U            ;
C6EE 3F   02      SWI    #$02           ;
C6F0 3C   24      CWAI   #$24           ;
C6F2 58           ASLB                  ;
C6F3 06   45      ROR    >$45           ;
C6F5 D8   0F      EORB   >$0F           ;
C6F7 B7   0AB4    STA    ($0AB4)        ;
C6FA 39           RTS                   ;
C6FB DE   0F      LDU    >$0F           ;
C6FD EF   66      STU    6,S            ;
C6FF 30   4E      LEAX   14,U           ;
C701 9F   0F      STX    >$0F           ;
C703 A7   49      STA    9,U            ;
C705 E7   44      STB    4,U            ;
C707 3F   18      SWI    #$18           ;
C709 E6   4A      LDB    10,U           ;
C70B 8E   C719    LDX    #$C719         ;
C70E A6   85      LDA    B,X            ;
C710 2B   06      BMI    ($C718)        ;
C712 E6   4B      LDB    11,U           ;
C714 3F   18      SWI    #$18           ;
C716 E7   4B      STB    11,U           ;
C718 39           RTS                   ;
C719 FF           ????                  ;
C71A FF           ????                  ;
C71B FF           ????                  ;
C71C 1011         ????                  ;
C71E 0F   48      CLR    >$48           ;
C720 48           ASLA                  ;
C721 8E   DA00    LDX    #$DA00         ;
C724 31   86      LEAY   A,X            ;
C726 30   4A      LEAX   10,U           ;
C728 86   04      LDA    #$04           ;
C72A BD   C04B    JSR    ($C04B)        ;
C72D 8E   DA60    LDX    #$DA60         ;
C730 30   04      LEAX   4,X            ;
C732 A6   84      LDA    ,X             ;
C734 2B   0C      BMI    ($C742)        ;
C736 A1   63      CMPA   3,S            ;
C738 26   F6      BNE    ($C730)        ;
C73A EC   01      LDD    1,X            ;
C73C ED   46      STD    6,U            ;
C73E A6   03      LDA    3,X            ;
C740 A7   48      STA    8,U            ;
C742 39           RTS                   ;
C743 3F   0A      SWI    #$0A           ;
C745 3F   0B      SWI    #$0B           ;
C747 3F   0C      SWI    #$0C           ;
C749 0C   AE      INC    >$AE           ;
C74B 0A   AD      DEC    >$AD           ;
C74D 0A   B1      DEC    >$B1           ;
C74F 3F   0D      SWI    #$0D           ;
C751 8E   CE66    LDX    #$CE66         ;
C754 9F   B2      STX    >$B2           ;
C756 3F   0E      SWI    #$0E           ;
C758 39           RTS                   ;
C759 97   81      STA    >$81           ;
C75B C6   0C      LDB    #$0C           ;
C75D 3D           MUL                   ;
C75E C3   0398    ADDD   #$0398         ;
C761 DD   82      STD    >$82           ;
C763 D6   81      LDB    >$81           ;
C765 8E   CFFD    LDX    #$CFFD         ;
C768 9F   86      STX    >$86           ;
C76A A6   80      LDA    ,X+            ;
C76C 2A   FC      BPL    ($C76A)        ;
C76E 5A           DECB                  ;
C76F 2A   F7      BPL    ($C768)        ;
C771 8E   03D4    LDX    #$03D4         ;
C774 CE   05F4    LDU    #$05F4         ;
C777 3F   11      SWI    #$11           ;
C779 BD   C053    JSR    ($C053)        ;
C77C BD   CC9C    JSR    ($CC9C)        ;
C77F DE   82      LDU    >$82           ;
C781 86   0B      LDA    #$0B           ;
C783 E6   C6      LDB    A,U            ;
C785 27   06      BEQ    ($C78D)        ;
C787 BD   CFA5    JSR    ($CFA5)        ;
C78A 5A           DECB                  ;
C78B 26   FA      BNE    ($C787)        ;
C78D 4A           DECA                  ;
C78E 2A   F3      BPL    ($C783)        ;
C790 CE   03C3    LDU    #$03C3         ;
C793 0F   91      CLR    >$91           ;
C795 BD   CF63    JSR    ($CF63)        ;
C798 27   1C      BEQ    ($C7B6)        ;
C79A 6D   05      TST    5,X            ;
C79C 2A   F7      BPL    ($C795)        ;
C79E 33   C8 11   LEAU   $11,U          ;
C7A1 1183 05F4    CMPU   #$05F4         ;
C7A5 25   03      BCS    ($C7AA)        ;
C7A7 CE   03D4    LDU    #$03D4         ;
C7AA 6D   4C      TST    12,U           ;
C7AC 27   F0      BEQ    ($C79E)        ;
C7AE EC   48      LDD    8,U            ;
C7B0 AF   48      STX    8,U            ;
C7B2 ED   84      STD    ,X             ;
C7B4 20   DF      BRA    ($C795)        ;
C7B6 96   81      LDA    >$81           ;
C7B8 84   01      ANDA   #$01           ;
C7BA 40           NEGA                  ;
C7BB 97   2C      STA    >$2C           ;
C7BD B7   0396    STA    ($0396)        ;
C7C0 B7   0386    STA    ($0386)        ;
C7C3 43           COMA                  ;
C7C4 B7   038E    STA    ($038E)        ;
C7C7 39           RTS                   ;

; SWI 1B  Play sound at full volume

C7C8 AE   6C      LDX    12,S           ;
C7CA A6   80      LDA    ,X+            ;
C7CC AF   6C      STX    12,S           ;
C7CE C6   FF      LDB    #$FF           ;

; SWI 1C  Play sound A at volume B

C7D0 D7   61      STB    >$61           ;
C7D2 8E   C7DC    LDX    #$C7DC         ;
C7D5 48           ASLA                  ;
C7D6 AD   96      JSR    [A,X]          ;
C7D8 7F   FF20    CLR    ($FF20)        ;
C7DB 39           RTS                   ;

; Sound effects routine entry points

C7DC C8   2B       Spider
C7DE C8   50       Snake
C7E0 C9   51       Giant
C7E2 C8   3C       Blob
C7E4 C8   E2       Knight
C7E6 C9   55       Hatchet Giant
C7E8 C8   4A       Scorpion
C7EA C8   DE       Shielded Knight
C7EC C8   4D       Wraith
C7EE C9   59       Galdrog
C7F0 C8   77       Demon
C7F2 C8   77       Wizard
C7F4 C8   0A       Flask
C7F6 C8   11       Ring
C7F8 C8   27       Scroll
C7FA C8   DA       Shield
C7FC C8   A6       Sword
C7FE C8   B2       Torch
C800 C9   3F       Player Hit
C802 C8   E6       Wizard beam
C804 C8   72       Wall hit
C806 C8   6D       Creature dieing
C808 C8   8A       Wizard strike sound

C80A CE   C823    LDU    #$C823         ;
C80D 86   04      LDA    #$04           ;
C80F 20   05      BRA    ($C816)        ;
C811 CE   C81F    LDU    #$C81F         ;
C814 86   0A      LDA    #$0A           ;
C816 97   5F      STA    >$5F           ;
C818 AD   C4      JSR    ,U             ;
C81A 0A   5F      DEC    >$5F           ;
C81C 26   FA      BNE    ($C818)        ;
C81E 39           RTS                   ;
C81F 8E   0040    LDX    #$0040         ;
C822 108E 0080    LDY    #$0080         ;
C826 108E 0100    LDY    #$0100         ;
C82A 108E 0020    LDY    #$0020         ;
C82E 8D   05      BSR    ($C835)        ;
C830 30   1F      LEAX   -1,X           ;
C832 26   FA      BNE    ($C82E)        ;
C834 39           RTS                   ;
C835 86   FF      LDA    #$FF           ;
C837 8D   30      BSR    ($C869)        ;
C839 4F           CLRA                  ;
C83A 20   2D      BRA    ($C869)        ;
C83C 8E   0500    LDX    #$0500         ;
C83F 8D   F4      BSR    ($C835)        ;
C841 30   88 30   LEAX   $30,X          ;
C844 8C   0800    CMPX   #$0800         ;
C847 25   F6      BCS    ($C83F)        ;
C849 39           RTS                   ;
C84A 86   02      LDA    #$02           ;
C84C 8C   8601    CMPX   #$8601         ;
C84F 8C   860A    CMPX   #$860A         ;
C852 97   62      STA    >$62           ;
C854 108E 00C0    LDY    #$00C0         ;
C858 8D   74      BSR    ($C8CE)        ;
C85A 8D   69      BSR    ($C8C5)        ;
C85C 31   3F      LEAY   -1,Y           ;
C85E 26   F8      BNE    ($C858)        ;
C860 8D   58      BSR    ($C8BA)        ;
C862 0A   62      DEC    >$62           ;
C864 26   EE      BNE    ($C854)        ;
C866 39           RTS                   ;
C867 8D   65      BSR    ($C8CE)        ;
C869 8D   5A      BSR    ($C8C5)        ;
C86B 20   50      BRA    ($C8BD)        ;
C86D CE   DBDA    LDU    #$DBDA         ;
C870 20   21      BRA    ($C893)        ;
C872 CE   DBD2    LDU    #$DBD2         ;
C875 20   1C      BRA    ($C893)        ;
C877 86   08      LDA    #$08           ;
C879 97   5F      STA    >$5F           ;
C87B 8D   51      BSR    ($C8CE)        ;
C87D 4F           CLRA                  ;
C87E 54           LSRB                  ;
C87F 26   01      BNE    ($C882)        ;
C881 5C           INCB                  ;
C882 1F   01      TFR    #$01           ;
C884 8D   A8      BSR    ($C82E)        ;
C886 0A   5F      DEC    >$5F           ;
C888 26   F1      BNE    ($C87B)        ;
C88A CE   DBD2    LDU    #$DBD2         ;
C88D 8D   04      BSR    ($C893)        ;
C88F 8D   29      BSR    ($C8BA)        ;
C891 33   44      LEAU   4,U            ;
C893 AE   C4      LDX    ,U             ;
C895 10AE 42      LDY    2,U            ;
C898 8D   CD      BSR    ($C867)        ;
C89A 31   3F      LEAY   -1,Y           ;
C89C 26   FA      BNE    ($C898)        ;
C89E 30   02      LEAX   2,X            ;
C8A0 8C   0150    CMPX   #$0150         ;
C8A3 26   F0      BNE    ($C895)        ;
C8A5 39           RTS                   ;
C8A6 BD   C931    JSR    ($C931)        ;
C8A9 80   8D      SUBA   #$8D           ;
C8AB 76   2504    ROR    ($2504)        ;
C8AE 8D   15      BSR    ($C8C5)        ;
C8B0 20   F8      BRA    ($C8AA)        ;
C8B2 BD   C92E    JSR    ($C92E)        ;
C8B5 A0   8D 6E20 SUBA   $36D9,PCR      ;
C8B9 FC   8E10    LDD    ($8E10)        ;
C8BC 00   34      NEG    >$34           ;
C8BE 1030         ????   >$34           ;
C8C0 1F   26      TFR    #$26           ;
C8C2 FC   3590    LDD    ($3590)        ;
C8C5 D6   61      LDB    >$61           ;
C8C7 3D           MUL                   ;
C8C8 84   FC      ANDA   #$FC           ;
C8CA B7   FF20    STA    ($FF20)        ;
C8CD 39           RTS                   ;
C8CE DC   56      LDD    >$56           ;
C8D0 58           ASLB                  ;
C8D1 49           ROLA                  ;
C8D2 58           ASLB                  ;
C8D3 49           ROLA                  ;
C8D4 D3   56      ADDD   >$56           ;
C8D6 5C           INCB                  ;
C8D7 DD   56      STD    >$56           ;
C8D9 39           RTS                   ;
C8DA 8D   39      BSR    ($C915)        ;
C8DC 64   24      LSR    4,Y            ;
C8DE 8D   35      BSR    ($C915)        ;
C8E0 32   12      LEAS   -14,X          ;
C8E2 8D   31      BSR    ($C915)        ;
C8E4 AF   36      STX    -10,Y          ;
C8E6 8D   2D      BSR    ($C915)        ;
C8E8 19           DAA                   ;
C8E9 09   8D      ROL    >$8D           ;
C8EB 42           ????   >$8D           ;
C8EC 60   9E      NEG    ?post byte?    ;
C8EE 63   10      COM    -16,X          ;
C8F0 9E   65      LDX    >$65           ;
C8F2 4F           CLRA                  ;
C8F3 30   1F      LEAX   -1,X           ;
C8F5 26   06      BNE    ($C8FD)        ;
C8F7 9E   63      LDX    >$63           ;
C8F9 88   7F      EORA   #$7F           ;
C8FB 8D   0D      BSR    ($C90A)        ;
C8FD 31   3F      LEAY   -1,Y           ;
C8FF 26   F2      BNE    ($C8F3)        ;
C901 109E 65      LDY    >$65           ;
C904 88   80      EORA   #$80           ;
C906 8D   02      BSR    ($C90A)        ;
C908 20   E9      BRA    ($C8F3)        ;
C90A 97   59      STA    >$59           ;
C90C 8D   70      BSR    ($C97E)        ;
C90E 23   B3      BLS    ($C8C3)        ;
C910 8D   B3      BSR    ($C8C5)        ;
C912 96   59      LDA    >$59           ;
C914 39           RTS                   ;
C915 AE   E1      LDX    ,S++           ;
C917 E6   80      LDB    ,X+            ;
C919 4F           CLRA                  ;
C91A DD   63      STD    >$63           ;
C91C E6   80      LDB    ,X+            ;
C91E DD   65      STD    >$65           ;
C920 20   C8      BRA    ($C8EA)        ;
C922 8D   AA      BSR    ($C8CE)        ;
C924 20   67      BRA    ($C98D)        ;
C926 8D   A6      BSR    ($C8CE)        ;
C928 8D   54      BSR    ($C97E)        ;
C92A 23   97      BLS    ($C8C3)        ;
C92C 20   97      BRA    ($C8C5)        ;
C92E 9E   03      LDX    >$03           ;
C930 109E 00      LDY    >$00           ;
C933 9F   5B      STX    >$5B           ;
C935 AE   E4      LDX    ,S             ;
C937 E6   80      LDB    ,X+            ;
C939 4F           CLRA                  ;
C93A DD   5D      STD    >$5D           ;
C93C AF   E4      STX    ,S             ;
C93E 39           RTS                   ;
C93F 8D   ED      BSR    ($C92E)        ;
C941 60   BD C8CE NEG    [$9213,PCR]    ;
C945 44           LSRA                  ;
C946 8D   E0      BSR    ($C928)        ;
C948 BD   C8CE    JSR    ($C8CE)        ;
C94B 8A   80      ORA    #$80           ;
C94D 8D   D9      BSR    ($C928)        ;
C94F 20   F1      BRA    ($C942)        ;
C951 8E   0300    LDX    #$0300         ;
C954 108E 0200    LDY    #$0200         ;
C958 108E 0100    LDY    #$0100         ;
C95C 9F   5D      STX    >$5D           ;
C95E 4F           CLRA                  ;
C95F 5F           CLRB                  ;
C960 DD   5B      STD    >$5B           ;
C962 8D   BE      BSR    ($C922)        ;
C964 25   0B      BCS    ($C971)        ;
C966 BD   C8C5    JSR    ($C8C5)        ;
C969 8E   00F0    LDX    #$00F0         ;
C96C BD   C8BD    JSR    ($C8BD)        ;
C96F 20   F1      BRA    ($C962)        ;
C971 8D   BB      BSR    ($C92E)        ;
C973 40           NEGA                  ;
C974 8D   B0      BSR    ($C926)        ;
C976 8E   0060    LDX    #$0060         ;
C979 BD   C8BD    JSR    ($C8BD)        ;
C97C 20   F6      BRA    ($C974)        ;
C97E 34   02      PSHS   #$02           ;
C980 DC   5B      LDD    >$5B           ;
C982 93   5D      SUBD   >$5D           ;
C984 34   01      PSHS   #$01           ;
C986 DD   5B      STD    >$5B           ;
C988 E6   61      LDB    1,S            ;
C98A 3D           MUL                   ;
C98B 35   85      PULS   #$85           ;
C98D 34   02      PSHS   #$02           ;
C98F DC   5B      LDD    >$5B           ;
C991 D3   5D      ADDD   >$5D           ;
C993 20   EF      BRA    ($C984)        ;

; SWI Offset table

C995 00 1E A6 0C    
C999 05 16 03 5D   
C99D 24 03 09 08  
C9A1 22 B0 7D 1E   
C9A5 0B 07 02 1C   
C9A9 04 1D 21 15  
C9AD 24 24 16 6F
C9B1 08

C9B2 81   24      CMPA   #$24           ;
C9B4 27   09      BEQ    ($C9BF)        ;
C9B6 81   1F      CMPA   #$1F           ;
C9B8 27   10      BEQ    ($C9CA)        ;
C9BA 8D   5B      BSR    ($CA17)        ;
C9BC 30   01      LEAX   1,X            ;
C9BE 39           RTS                   ;
C9BF 30   1F      LEAX   -1,X           ;
C9C1 9C   03      CMPX   >$03           ;
C9C3 26   04      BNE    ($C9C9)        ;
C9C5 AE   42      LDX    2,U            ;
C9C7 30   1F      LEAX   -1,X           ;
C9C9 39           RTS                   ;
C9CA 30   88 20   LEAX   $20,X          ;
C9CD 1E   01      EXG    #$01           ;
C9CF C4   E0      ANDB   #$E0           ;
C9D1 1E   01      EXG    #$01           ;
C9D3 39           RTS                   ;
C9D4 34   36      PSHS   #$36           ;
C9D6 AE   C4      LDX    ,U             ;
C9D8 EC   42      LDD    2,U            ;
C9DA 83   0020    SUBD   #$0020         ;
C9DD ED   62      STD    2,S            ;
C9DF 8D   2F      BSR    ($CA10)        ;
C9E1 1F   02      TFR    #$02           ;
C9E3 EC   89 0100 LDD    $0100,X        ;
C9E7 6D   47      TST    7,U            ;
C9E9 26   04      BNE    ($C9EF)        ;
C9EB ED   89 1800 STD    $1800,X        ;
C9EF ED   81      STD    ,X++           ;
C9F1 31   3E      LEAY   -2,Y           ;
C9F3 26   EE      BNE    ($C9E3)        ;
C9F5 E6   46      LDB    6,U            ;
C9F7 1D           SEX                   ;
C9F8 108E 0100    LDY    #$0100         ;
C9FC 6D   47      TST    7,U            ;
C9FE 26   04      BNE    ($CA04)        ;
CA00 ED   89 1800 STD    $1800,X        ;
CA04 ED   81      STD    ,X++           ;
CA06 31   3E      LEAY   -2,Y           ;
CA08 26   F2      BNE    ($C9FC)        ;
CA0A 35   B6      PULS   #$B6           ;

CA0C 58           ASLB                  ; D<<5 ... D*32 ... here down ...
CA0D 49           ROLA                  ;
CA0E 58           ASLB                  ;
CA0F 49           ROLA                  ;
CA10 58           ASLB                  ;
CA11 49           ROLA                  ;
CA12 58           ASLB                  ;
CA13 49           ROLA                  ;
CA14 58           ASLB                  ;
CA15 49           ROLA                  ;
CA16 39           RTS                   ;

CA17 34   76      PSHS   #$76           ;
CA19 81   20      CMPA   #$20           ;
CA1B 25   0C      BCS    ($CA29)        ;
CA1D 80   20      SUBA   #$20           ;
CA1F C6   07      LDB    #$07           ;
CA21 3D           MUL                   ;
CA22 C3   DBB6    ADDD   #$DBB6         ;
CA25 1F   01      TFR    #$01           ;
CA27 20   1B      BRA    ($CA44)        ;
CA29 C6   05      LDB    #$05           ;
CA2B 3D           MUL                   ;
CA2C C3   DB1B    ADDD   #$DB1B         ;
CA2F 1F   01      TFR    #$01           ;
CA31 CE   0357    LDU    #$0357         ;
CA34 3F   06      SWI    #$06           ;
CA36 8E   035E    LDX    #$035E         ;
CA39 68   82      ASL    ,-X            ;
CA3B 68   84      ASL    ,X             ;
CA3D 8C   0357    CMPX   #$0357         ;
CA40 22   F7      BHI    ($CA39)        ;
CA42 EE   66      LDU    6,S            ;
CA44 EC   44      LDD    4,U            ;
CA46 8D   C8      BSR    ($CA10)        ;
CA48 54           LSRB                  ;
CA49 54           LSRB                  ;
CA4A 54           LSRB                  ;
CA4B E3   C4      ADDD   ,U             ;
CA4D 1F   02      TFR    #$02           ;
CA4F C6   07      LDB    #$07           ;
CA51 A6   80      LDA    ,X+            ;
CA53 A8   46      EORA   6,U            ;
CA55 A7   A4      STA    ,Y             ;
CA57 6D   47      TST    7,U            ;
CA59 26   04      BNE    ($CA5F)        ;
CA5B A7   A9 1800 STA    $1800,Y        ;
CA5F 31   A8 20   LEAY   $20,Y          ;
CA62 5A           DECB                  ;
CA63 26   EC      BNE    ($CA51)        ;
CA65 35   F6      PULS   #$F6           ;
CA67 34   16      PSHS   #$16           ;
CA69 6F   E4      CLR    ,S             ;
CA6B 6F   61      CLR    1,S            ;
CA6D 0F   C1      CLR    >$C1           ;
CA6F DD   C2      STD    >$C2           ;
CA71 27   24      BEQ    ($CA97)        ;
CA73 10A3 62      CMPD   2,S            ;
CA76 26   04      BNE    ($CA7C)        ;
CA78 6C   E4      INC    ,S             ;
CA7A 20   1B      BRA    ($CA97)        ;
CA7C 8E   0010    LDX    #$0010         ;
CA7F 08   C3      ASL    >$C3           ;
CA81 09   C2      ROL    >$C2           ;
CA83 09   C1      ROL    >$C1           ;
CA85 68   61      ASL    1,S            ;
CA87 69   E4      ROL    ,S             ;
CA89 DC   C1      LDD    >$C1           ;
CA8B A3   62      SUBD   2,S            ;
CA8D 25   04      BCS    ($CA93)        ;
CA8F DD   C1      STD    >$C1           ;
CA91 6C   61      INC    1,S            ;
CA93 30   1F      LEAX   -1,X           ;
CA95 26   E8      BNE    ($CA7F)        ;
CA97 35   96      PULS   #$96           ;
CA99 43           COMA                  ;
CA9A 53           COMB                  ;
CA9B C3   0001    ADDD   #$0001         ;
CA9E 39           RTS                   ;
CA9F 34   16      PSHS   #$16           ;
CAA1 9E   43      LDX    >$43           ;
CAA3 EC   E4      LDD    ,S             ;
CAA5 2A   07      BPL    ($CAAE)        ;
CAA7 8D   F0      BSR    ($CA99)        ;
CAA9 8D   BC      BSR    ($CA67)        ;
CAAB 8D   EC      BSR    ($CA99)        ;
CAAD 8C   8DB7    CMPX   #$8DB7         ;
CAB0 ED   E4      STD    ,S             ;
CAB2 35   96      PULS   #$96           ;
CAB4 7E   CB8A    JMP    ($CB8A)        ;

; Draw line

CAB7 34   76      PSHS   #$76           ;
CAB9 0C   2D      INC    >$2D           ;
CABB 27   F7      BEQ    ($CAB4)        ;
CABD 96   2D      LDA    >$2D           ;
CABF 97   2E      STA    >$2E           ;
CAC1 DC   35      LDD    >$35           ;
CAC3 93   31      SUBD   >$31           ;
CAC5 DD   3E      STD    >$3E           ;
CAC7 2A   02      BPL    ($CACB)        ;
CAC9 8D   CE      BSR    ($CA99)        ;
CACB DD   43      STD    >$43           ;
CACD DC   33      LDD    >$33           ;
CACF 93   2F      SUBD   >$2F           ;
CAD1 DD   41      STD    >$41           ;
CAD3 2A   02      BPL    ($CAD7)        ;
CAD5 8D   C2      BSR    ($CA99)        ;
CAD7 1093 43      CMPD   >$43           ;
CADA 2D   04      BLT    ($CAE0)        ;
CADC DD   43      STD    >$43           ;
CADE 27   D4      BEQ    ($CAB4)        ;
CAE0 DC   3E      LDD    >$3E           ;
CAE2 8D   BB      BSR    ($CA9F)        ;
CAE4 DD   3E      STD    >$3E           ;
CAE6 1F   89      TFR    #$89           ;
CAE8 1D           SEX                   ;
CAE9 C6   01      LDB    #$01           ;
CAEB 97   3D      STA    >$3D           ;
CAED 2A   01      BPL    ($CAF0)        ;
CAEF 50           NEGB                  ;
CAF0 D7   45      STB    >$45           ;
CAF2 DC   41      LDD    >$41           ;
CAF4 8D   A9      BSR    ($CA9F)        ;
CAF6 DD   41      STD    >$41           ;
CAF8 1F   89      TFR    #$89           ;
CAFA 1D           SEX                   ;
CAFB C6   20      LDB    #$20           ;
CAFD 97   40      STA    >$40           ;
CAFF 2A   01      BPL    ($CB02)        ;
CB01 50           NEGB                  ;
CB02 D7   46      STB    >$46           ;
CB04 DC   31      LDD    >$31           ;
CB06 DD   37      STD    >$37           ;
CB08 DC   2F      LDD    >$2F           ;
CB0A DD   3A      STD    >$3A           ;
CB0C 86   80      LDA    #$80           ;
CB0E 97   39      STA    >$39           ;
CB10 97   3C      STA    >$3C           ;
CB12 AE   42      LDX    2,U            ;
CB14 9F   49      STX    >$49           ;
CB16 AE   C4      LDX    ,U             ;
CB18 9F   47      STX    >$47           ;
CB1A DC   3A      LDD    >$3A           ;
CB1C BD   CA0C    JSR    ($CA0C)        ; D = D * 32
CB1F 30   8B      LEAX   D,X            ;
CB21 DC   37      LDD    >$37           ;
CB23 BD   D37F    JSR    ($D37F)        ;
CB26 30   8B      LEAX   D,X            ;
CB28 CE   CB8E    LDU    #$CB8E         ;
CB2B 109E 43      LDY    >$43           ;
CB2E 0A   2E      DEC    >$2E           ;
CB30 26   22      BNE    ($CB54)        ;
CB32 96   2D      LDA    >$2D           ;
CB34 97   2E      STA    >$2E           ;
CB36 0D   37      TST    >$37           ;
CB38 26   1A      BNE    ($CB54)        ;
CB3A 9C   47      CMPX   >$47           ;
CB3C 25   16      BCS    ($CB54)        ;
CB3E 9C   49      CMPX   >$49           ;
CB40 24   12      BCC    ($CB54)        ;
CB42 D6   38      LDB    >$38           ;
CB44 C4   07      ANDB   #$07           ;
CB46 A6   C5      LDA    B,U            ;
CB48 0D   2C      TST    >$2C           ;
CB4A 27   04      BEQ    ($CB50)        ;
CB4C 43           COMA                  ;
CB4D A4   84      ANDA   ,X             ;
CB4F 8C   AA84    CMPX   #$AA84         ;
CB52 A7   84      STA    ,X             ;
CB54 96   38      LDA    >$38           ;
CB56 84   F8      ANDA   #$F8           ;
CB58 97   C1      STA    >$C1           ;
CB5A DC   38      LDD    >$38           ;
CB5C D3   3E      ADDD   >$3E           ;
CB5E DD   38      STD    >$38           ;
CB60 D6   37      LDB    >$37           ;
CB62 D9   3D      ADCB   >$3D           ;
CB64 D7   37      STB    >$37           ;
CB66 84   F8      ANDA   #$F8           ;
CB68 91   C1      CMPA   >$C1           ;
CB6A 27   04      BEQ    ($CB70)        ;
CB6C D6   45      LDB    >$45           ;
CB6E 30   85      LEAX   B,X            ;
CB70 DC   3B      LDD    >$3B           ;
CB72 97   C1      STA    >$C1           ;
CB74 D3   41      ADDD   >$41           ;
CB76 DD   3B      STD    >$3B           ;
CB78 D6   3A      LDB    >$3A           ;
CB7A D9   40      ADCB   >$40           ;
CB7C D7   3A      STB    >$3A           ;
CB7E 91   C1      CMPA   >$C1           ;
CB80 27   04      BEQ    ($CB86)        ;
CB82 D6   46      LDB    >$46           ;
CB84 30   85      LEAX   B,X            ;
CB86 31   3F      LEAY   -1,Y           ;
CB88 26   A4      BNE    ($CB2E)        ;
CB8A 0A   2D      DEC    >$2D           ;
CB8C 35   F6      PULS   #$F6           ;
CB8E 80   40      SUBA   #$40           ;
CB90 20   10      BRA    ($CBA2)        ;
CB92 08   04      ASL    >$04           ;
CB94 02           ????   >$04           ;
CB95 01           ????   >$04           ;
CB96 34   52      PSHS   #$52           ;
CB98 9E   11      LDX    >$11           ;
CB9A CE   0313    LDU    #$0313         ;
CB9D A6   80      LDA    ,X+            ;
CB9F 27   FC      BEQ    ($CB9D)        ;
CBA1 20   02      BRA    ($CBA5)        ;
CBA3 A6   80      LDA    ,X+            ;
CBA5 2F   08      BLE    ($CBAF)        ;
CBA7 A7   C0      STA    ,U+            ;
CBA9 1183 0333    CMPU   #$0333         ;
CBAD 25   F4      BCS    ($CBA3)        ;
CBAF 86   FF      LDA    #$FF           ;
CBB1 A7   C0      STA    ,U+            ;
CBB3 9F   11      STX    >$11           ;
CBB5 7D   0313    TST    ($0313)        ;
CBB8 35   D2      PULS   #$D2           ;
CBBA 0F   90      CLR    >$90           ;
CBBC 8E   D96A    LDX    #$D96A         ;
CBBF 8D   2B      BSR    ($CBEC)        ;
CBC1 2B   05      BMI    ($CBC8)        ;
CBC3 27   1A      BEQ    ($CBDF)        ;
CBC5 DD   8E      STD    >$8E           ;
CBC7 39           RTS                   ;
CBC8 0A   90      DEC    >$90           ;
CBCA 8E   D8F3    LDX    #$D8F3         ;
CBCD 8D   18      BSR    ($CBE7)        ;
CBCF 2F   0E      BLE    ($CBDF)        ;
CBD1 DD   8E      STD    >$8E           ;
CBD3 8E   D96A    LDX    #$D96A         ;
CBD6 8D   14      BSR    ($CBEC)        ;
CBD8 2F   05      BLE    ($CBDF)        ;
CBDA D1   8F      CMPB   >$8F           ;
CBDC 26   01      BNE    ($CBDF)        ;
CBDE 39           RTS                   ;
CBDF 32   62      LEAS   2,S            ;
CBE1 3F   02      SWI    #$02           ;
CBE3 17   78D0    LBSR   ($CBDF)        ;
CBE6 39           RTS                   ;
CBE7 34   76      PSHS   #$76           ;
CBE9 4F           CLRA                  ;
CBEA 20   08      BRA    ($CBF4)        ;
CBEC 34   76      PSHS   #$76           ;
CBEE 4F           CLRA                  ;
CBEF 5F           CLRB                  ;
CBF0 8D   A4      BSR    ($CB96)        ;
CBF2 2B   39      BMI    ($CC2D)        ;
CBF4 0F   78      CLR    >$78           ;
CBF6 0F   7B      CLR    >$7B           ;
CBF8 E6   80      LDB    ,X+            ;
CBFA D7   79      STB    >$79           ;
CBFC CE   0313    LDU    #$0313         ;
CBFF 3F   05      SWI    #$05           ;
CC01 108E 0336    LDY    #$0336         ;
CC05 E6   C0      LDB    ,U+            ;
CC07 2B   0E      BMI    ($CC17)        ;
CC09 E1   A0      CMPB   ,Y+            ;
CC0B 26   15      BNE    ($CC22)        ;
CC0D 6D   A4      TST    ,Y             ;
CC0F 2A   F4      BPL    ($CC05)        ;
CC11 6D   C4      TST    ,U             ;
CC13 2A   0D      BPL    ($CC22)        ;
CC15 0A   7B      DEC    >$7B           ;
CC17 0D   78      TST    >$78           ;
CC19 26   10      BNE    ($CC2B)        ;
CC1B 0C   78      INC    >$78           ;
CC1D F6   0335    LDB    ($0335)        ;
CC20 ED   E4      STD    ,S             ;
CC22 4C           INCA                  ;
CC23 0A   79      DEC    >$79           ;
CC25 26   D5      BNE    ($CBFC)        ;
CC27 0D   78      TST    >$78           ;
CC29 26   04      BNE    ($CC2F)        ;
CC2B DC   03      LDD    >$03           ;
CC2D ED   E4      STD    ,S             ;
CC2F 35   F6      PULS   #$F6           ;

CC31 8E   D8D9    LDX    #$D8D9         ;
CC34 8D   B6      BSR    ($CBEC)        ;
CC36 2F   A7      BLE    ($CBDF)        ;
CC38 CE   021F    LDU    #$021F         ;
CC3B 81   01      CMPA   #$01           ;
CC3D 27   07      BEQ    ($CC46)        ;
CC3F CE   021D    LDU    #$021D         ;
CC42 81   00      CMPA   #$00           ;
CC44 26   99      BNE    ($CBDF)        ;
CC46 AE   C4      LDX    ,U             ;
CC48 39           RTS                   ;

CC49 34   56      PSHS   #$56           ;
CC4B 4A           DECA                  ;
CC4C 8D   08      BSR    ($CC56)        ;
CC4E 4C           INCA                  ;
CC4F 8D   05      BSR    ($CC56)        ;
CC51 4C           INCA                  ;
CC52 8D   02      BSR    ($CC56)        ;
CC54 35   D6      PULS   #$D6           ;
CC56 34   06      PSHS   #$06           ;
CC58 5A           DECB                  ;
CC59 8D   05      BSR    ($CC60)        ;
CC5B 5C           INCB                  ;
CC5C 8D   02      BSR    ($CC60)        ;
CC5E 5C           INCB                  ;
CC5F 8C   3406    CMPX   #$3406         ;
CC62 8D   2A      BSR    ($CC8E)        ;
CC64 26   05      BNE    ($CC6B)        ;
CC66 8D   13      BSR    ($CC7B)        ;
CC68 A6   84      LDA    ,X             ;
CC6A 8C   86FF    CMPX   #$86FF         ;
CC6D A7   C0      STA    ,U+            ;
CC6F 35   86      PULS   #$86           ;
CC71 3F   07      SWI    #$07           ;
CC73 84   1F      ANDA   #$1F           ;
CC75 1F   89      TFR    #$89           ;
CC77 3F   07      SWI    #$07           ;
CC79 84   1F      ANDA   #$1F           ;
CC7B 34   06      PSHS   #$06           ;
CC7D 84   1F      ANDA   #$1F           ;
CC7F C4   1F      ANDB   #$1F           ;
CC81 1F   01      TFR    #$01           ;
CC83 C6   20      LDB    #$20           ;
CC85 3D           MUL                   ;
CC86 C3   05F4    ADDD   #$05F4         ;
CC89 1E   01      EXG    #$01           ;
CC8B 3A           ABX                   ;
CC8C 35   86      PULS   #$86           ;
CC8E 34   06      PSHS   #$06           ;
CC90 84   1F      ANDA   #$1F           ;
CC92 A1   E4      CMPA   ,S             ;
CC94 26   04      BNE    ($CC9A)        ;
CC96 C4   1F      ANDB   #$1F           ;
CC98 E1   61      CMPB   1,S            ;
CC9A 35   86      PULS   #$86           ;
CC9C 8E   05F4    LDX    #$05F4         ;
CC9F CE   09F4    LDU    #$09F4         ;
CCA2 3F   12      SWI    #$12           ;
CCA4 8E   CD9F    LDX    #$CD9F         ;
CCA7 D6   81      LDB    >$81           ;
CCA9 3A           ABX                   ;
CCAA EC   81      LDD    ,X++           ;
CCAC DD   6B      STD    >$6B           ;
CCAE A6   84      LDA    ,X             ;
CCB0 97   6D      STA    >$6D           ;
CCB2 108E 01F4    LDY    #$01F4         ;
CCB6 BD   CC71    JSR    ($CC71)        ;
CCB9 DD   7C      STD    >$7C           ;
CCBB 3F   07      SWI    #$07           ;
CCBD 84   03      ANDA   #$03           ;
CCBF 97   8A      STA    >$8A           ;
CCC1 3F   07      SWI    #$07           ;
CCC3 84   07      ANDA   #$07           ;
CCC5 4C           INCA                  ;
CCC6 97   7E      STA    >$7E           ;
CCC8 20   08      BRA    ($CCD2)        ;
CCCA DC   88      LDD    >$88           ;
CCCC DD   7C      STD    >$7C           ;
CCCE 0A   7E      DEC    >$7E           ;
CCD0 27   E9      BEQ    ($CCBB)        ;
CCD2 DC   7C      LDD    >$7C           ;
CCD4 BD   D11B    JSR    ($D11B)        ;
CCD7 8D   B5      BSR    ($CC8E)        ;
CCD9 26   E0      BNE    ($CCBB)        ;
CCDB DD   88      STD    >$88           ;
CCDD 6D   84      TST    ,X             ;
CCDF 27   E9      BEQ    ($CCCA)        ;
CCE1 CE   09F4    LDU    #$09F4         ;
CCE4 BD   CC49    JSR    ($CC49)        ;
CCE7 A6   43      LDA    3,U            ;
CCE9 AB   C4      ADDA   ,U             ;
CCEB AB   41      ADDA   1,U            ;
CCED 27   CC      BEQ    ($CCBB)        ;
CCEF A6   41      LDA    1,U            ;
CCF1 AB   42      ADDA   2,U            ;
CCF3 AB   45      ADDA   5,U            ;
CCF5 27   C4      BEQ    ($CCBB)        ;
CCF7 A6   45      LDA    5,U            ;
CCF9 AB   48      ADDA   8,U            ;
CCFB AB   47      ADDA   7,U            ;
CCFD 27   BC      BEQ    ($CCBB)        ;
CCFF A6   47      LDA    7,U            ;
CD01 AB   46      ADDA   6,U            ;
CD03 AB   43      ADDA   3,U            ;
CD05 27   B4      BEQ    ($CCBB)        ;
CD07 6F   84      CLR    ,X             ;
CD09 31   3F      LEAY   -1,Y           ;
CD0B 26   BD      BNE    ($CCCA)        ;
CD0D 0F   7C      CLR    >$7C           ;
CD0F 0F   7D      CLR    >$7D           ;
CD11 DC   7C      LDD    >$7C           ;
CD13 BD   CC7B    JSR    ($CC7B)        ;
CD16 A6   84      LDA    ,X             ;
CD18 4C           INCA                  ;
CD19 27   26      BEQ    ($CD41)        ;
CD1B DC   7C      LDD    >$7C           ;
CD1D CE   09F4    LDU    #$09F4         ;
CD20 BD   CC49    JSR    ($CC49)        ;
CD23 A6   84      LDA    ,X             ;
CD25 C6   FF      LDB    #$FF           ;
CD27 E1   41      CMPB   1,U            ;
CD29 26   02      BNE    ($CD2D)        ;
CD2B 8A   03      ORA    #$03           ;
CD2D E1   43      CMPB   3,U            ;
CD2F 26   02      BNE    ($CD33)        ;
CD31 8A   C0      ORA    #$C0           ;
CD33 E1   45      CMPB   5,U            ;
CD35 26   02      BNE    ($CD39)        ;
CD37 8A   0C      ORA    #$0C           ;
CD39 E1   47      CMPB   7,U            ;
CD3B 26   02      BNE    ($CD3F)        ;
CD3D 8A   30      ORA    #$30           ;
CD3F A7   84      STA    ,X             ;
CD41 C6   20      LDB    #$20           ;
CD43 0C   7D      INC    >$7D           ;
CD45 D1   7D      CMPB   >$7D           ;
CD47 26   C8      BNE    ($CD11)        ;
CD49 0F   7D      CLR    >$7D           ;
CD4B 0C   7C      INC    >$7C           ;
CD4D D1   7C      CMPB   >$7C           ;
CD4F 26   C0      BNE    ($CD11)        ;
CD51 C6   46      LDB    #$46           ;
CD53 CE   CDAA    LDU    #$CDAA         ;
CD56 8D   15      BSR    ($CD6D)        ;
CD58 5A           DECB                  ;
CD59 26   FB      BNE    ($CD56)        ;
CD5B C6   2D      LDB    #$2D           ;
CD5D CE   CDAE    LDU    #$CDAE         ;
CD60 8D   0B      BSR    ($CD6D)        ;
CD62 5A           DECB                  ;
CD63 26   FB      BNE    ($CD60)        ;
CD65 D6   97      LDB    >$97           ;
CD67 3F   07      SWI    #$07           ;
CD69 5A           DECB                  ;
CD6A 26   FB      BNE    ($CD67)        ;
CD6C 39           RTS                   ;
CD6D 34   76      PSHS   #$76           ;
CD6F 108E CDA6    LDY    #$CDA6         ;
CD73 BD   CC71    JSR    ($CC71)        ;
CD76 DD   88      STD    >$88           ;
CD78 E6   84      LDB    ,X             ;
CD7A C1   FF      CMPB   #$FF           ;
CD7C 27   F5      BEQ    ($CD73)        ;
CD7E 3F   07      SWI    #$07           ;
CD80 84   03      ANDA   #$03           ;
CD82 97   8A      STA    >$8A           ;
CD84 E5   A6      BITB   A,Y            ;
CD86 26   EB      BNE    ($CD73)        ;
CD88 EA   C6      ORB    A,U            ;
CD8A E7   84      STB    ,X             ;
CD8C DC   88      LDD    >$88           ;
CD8E BD   D11B    JSR    ($D11B)        ;
CD91 D6   8A      LDB    >$8A           ;
CD93 CB   02      ADDB   #$02           ;
CD95 C4   03      ANDB   #$03           ;
CD97 A6   84      LDA    ,X             ;
CD99 AA   C5      ORA    B,U            ;
CD9B A7   84      STA    ,X             ;
CD9D 35   F6      PULS   #$F6           ;
CD9F 73   C75D    COM    ($C75D)        ;
CDA2 97   F3      STA    >$F3           ;
CDA4 13           SYNC                  ;
CDA5 87           ????                  ;
CDA6 03   0C      COM    >$0C           ;
CDA8 30   C0      LEAX   ,U+            ;
CDAA 01           ????   ,U+            ;
CDAB 04   10      LSR    >$10           ;
CDAD 40           NEGA                  ;
CDAE 02           ????                  ;
CDAF 08   20      ASL    >$20           ;
CDB1 80   

; Show Map

CDB2 DE   0B      LDU    >$0B           ;
CDB4 CC   1F1F    LDD    #$1F1F         ;
CDB7 DD   7C      STD    >$7C           ;
CDB9 DC   7C      LDD    >$7C           ;
CDBB 8D   54      BSR    ($CE11)        ;
CDBD BD   CC7B    JSR    ($CC7B)        ;
CDC0 5F           CLRB                  ;
CDC1 A6   84      LDA    ,X             ;
CDC3 4C           INCA                  ;
CDC4 26   01      BNE    ($CDC7)        ;
CDC6 5A           DECB                  ;
CDC7 86   06      LDA    #$06           ;
CDC9 E7   A4      STB    ,Y             ;
CDCB 31   A8 20   LEAY   $20,Y          ;
CDCE 4A           DECA                  ;
CDCF 26   F8      BNE    ($CDC9)        ;
CDD1 0A   7D      DEC    >$7D           ;
CDD3 2A   E4      BPL    ($CDB9)        ;
CDD5 86   1F      LDA    #$1F           ;
CDD7 97   7D      STA    >$7D           ;
CDD9 0A   7C      DEC    >$7C           ;
CDDB 2A   DC      BPL    ($CDB9)        ;
CDDD 0D   94      TST    >$94           ;
CDDF 27   4A      BEQ    ($CE2B)        ;
CDE1 0F   91      CLR    >$91           ;
CDE3 BD   CF63    JSR    ($CF63)        ;
CDE6 27   0F      BEQ    ($CDF7)        ;
CDE8 6D   05      TST    5,X            ;
CDEA 26   F7      BNE    ($CDE3)        ;
CDEC EC   02      LDD    2,X            ;
CDEE 8D   21      BSR    ($CE11)        ;
CDF0 CC   0008    LDD    #$0008         ;
CDF3 8D   28      BSR    ($CE1D)        ;
CDF5 20   EC      BRA    ($CDE3)        ;
CDF7 8E   03C3    LDX    #$03C3         ;
CDFA 30   88 11   LEAX   $11,X          ;
CDFD 8C   05F4    CMPX   #$05F4         ;
CE00 27   29      BEQ    ($CE2B)        ;
CE02 6D   0C      TST    12,X           ;
CE04 27   F4      BEQ    ($CDFA)        ;
CE06 EC   0F      LDD    15,X           ;
CE08 8D   07      BSR    ($CE11)        ;
CE0A CC   1054    LDD    #$1054         ;
CE0D 8D   0E      BSR    ($CE1D)        ;
CE0F 20   E9      BRA    ($CDFA)        ;
CE11 1F   02      TFR    #$02           ;
CE13 C6   C0      LDB    #$C0           ;
CE15 3D           MUL                   ;
CE16 E3   C4      ADDD   ,U             ;
CE18 1E   02      EXG    #$02           ;
CE1A 31   A5      LEAY   B,Y            ;
CE1C 39           RTS                   ;
CE1D A7   A8 20   STA    $20,Y          ;
CE20 E7   A8 40   STB    $40,Y          ;
CE23 E7   A8 60   STB    $60,Y          ;
CE26 A7   A9 0080 STA    $0080,Y        ;
CE2A 39           RTS                   ;
CE2B DC   13      LDD    >$13           ;
CE2D 8D   E2      BSR    ($CE11)        ;
CE2F CC   2418    LDD    #$2418         ;
CE32 8D   E9      BSR    ($CE1D)        ;
CE34 9E   86      LDX    >$86           ;
CE36 8D   00      BSR    ($CE38)        ;
CE38 A6   80      LDA    ,X+            ;
CE3A 2B   EE      BMI    ($CE2A)        ;
CE3C EC   81      LDD    ,X++           ;
CE3E 8D   D1      BSR    ($CE11)        ;
CE40 CC   3C24    LDD    #$3C24         ;
CE43 8D   D8      BSR    ($CE1D)        ;
CE45 20   F1      BRA    ($CE38)        ;

CE47 34   12      PSHS   #$12           ;
CE49 8E   CF48    LDX    #$CF48         ;
CE4C 0D   73      TST    >$73           ;
CE4E 26   0C      BNE    ($CE5C)        ;
CE50 30   89 0001 LEAX   $0001,X        ;
CE54 0D   74      TST    >$74           ;
CE56 26   04      BNE    ($CE5C)        ;
CE58 30   89 FFF5 LEAX   $FFF5,X        ;
CE5C 96   8B      LDA    >$8B           ;
CE5E A6   86      LDA    A,X            ;
CE60 97   4F      STA    >$4F           ;
CE62 97   50      STA    >$50           ;
CE64 35   92      PULS   #$92           ;
CE66 3F   09      SWI    #$09           ;
CE68 0F   8B      CLR    >$8B           ;
CE6A DC   13      LDD    >$13           ;
CE6C DD   7C      STD    >$7C           ;
CE6E 8D   D7      BSR    ($CE47)        ;
CE70 DC   7C      LDD    >$7C           ;
CE72 BD   CC7B    JSR    ($CC7B)        ;
CE75 A6   84      LDA    ,X             ;
CE77 CE   09F4    LDU    #$09F4         ;
CE7A 8E   0004    LDX    #$0004         ;
CE7D 1F   89      TFR    #$89           ;
CE7F C4   03      ANDB   #$03           ;
CE81 E7   44      STB    4,U            ;
CE83 E7   C0      STB    ,U+            ;
CE85 44           LSRA                  ;
CE86 44           LSRA                  ;
CE87 30   1F      LEAX   -1,X           ;
CE89 26   F2      BNE    ($CE7D)        ;
CE8B D6   23      LDB    >$23           ;
CE8D CE   09F4    LDU    #$09F4         ;
CE90 33   C5      LEAU   B,U            ;
CE92 108E DBDE    LDY    #$DBDE         ;
CE96 A6   A0      LDA    ,Y+            ;
CE98 2B   3E      BMI    ($CED8)        ;
CE9A E6   C6      LDB    A,U            ;
CE9C 58           ASLB                  ;
CE9D C1   04      CMPB   #$04           ;
CE9F 26   08      BNE    ($CEA9)        ;
CEA1 AE   A5      LDX    B,Y            ;
CEA3 0A   75      DEC    >$75           ;
CEA5 8D   27      BSR    ($CECE)        ;
CEA7 C6   06      LDB    #$06           ;
CEA9 AE   A5      LDX    B,Y            ;
CEAB 8D   21      BSR    ($CECE)        ;
CEAD 31   28      LEAY   8,Y            ;
CEAF 20   E5      BRA    ($CE96)        ;
CEB1 39           RTS                   ;
CEB2 1F   12      TFR    #$12           ;
CEB4 6D   C5      TST    B,U            ;
CEB6 26   F9      BNE    ($CEB1)        ;
CEB8 DB   23      ADDB   >$23           ;
CEBA D7   8A      STB    >$8A           ;
CEBC DC   7C      LDD    >$7C           ;
CEBE BD   D11B    JSR    ($D11B)        ;
CEC1 BD   CF82    JSR    ($CF82)        ;
CEC4 27   EB      BEQ    ($CEB1)        ;
CEC6 1E   12      EXG    #$12           ;
CEC8 6D   22      TST    2,Y            ;
CECA 27   02      BEQ    ($CECE)        ;
CECC 0A   75      DEC    >$75           ;
CECE 34   40      PSHS   #$40           ;
CED0 3F   00      SWI    #$00           ;
CED2 DE   0B      LDU    >$0B           ;
CED4 3F   01      SWI    #$01           ;
CED6 35   C0      PULS   #$C0           ;
CED8 DC   7C      LDD    >$7C           ;
CEDA BD   CF82    JSR    ($CF82)        ;
CEDD 27   0C      BEQ    ($CEEB)        ;
CEDF 1F   12      TFR    #$12           ;
CEE1 E6   2D      LDB    13,Y           ;
CEE3 58           ASLB                  ;
CEE4 8E   DAA3    LDX    #$DAA3         ;
CEE7 AE   85      LDX    B,X            ;
CEE9 8D   DD      BSR    ($CEC8)        ;
CEEB C6   03      LDB    #$03           ;
CEED 8E   DCB0    LDX    #$DCB0         ;
CEF0 8D   C0      BSR    ($CEB2)        ;
CEF2 C6   01      LDB    #$01           ;
CEF4 8E   DCB9    LDX    #$DCB9         ;
CEF7 8D   B9      BSR    ($CEB2)        ;
CEF9 8E   DD3C    LDX    #$DD3C         ;
CEFC DC   7C      LDD    >$7C           ;
CEFE BD   CFE1    JSR    ($CFE1)        ;
CF01 2B   06      BMI    ($CF09)        ;
CF03 8E   DCC2    LDX    #$DCC2         ;
CF06 48           ASLA                  ;
CF07 AE   86      LDX    A,X            ;
CF09 8D   C3      BSR    ($CECE)        ;
CF0B 0F   91      CLR    >$91           ;
CF0D DC   7C      LDD    >$7C           ;
CF0F BD   CF53    JSR    ($CF53)        ;
CF12 27   10      BEQ    ($CF24)        ;
CF14 A6   0A      LDA    10,X           ;
CF16 48           ASLA                  ;
CF17 8E   D9EE    LDX    #$D9EE         ;
CF1A AE   86      LDX    A,X            ;
CF1C 0A   75      DEC    >$75           ;
CF1E 8D   AE      BSR    ($CECE)        ;
CF20 8D   AC      BSR    ($CECE)        ;
CF22 20   E9      BRA    ($CF0D)        ;
CF24 6D   C4      TST    ,U             ;
CF26 26   15      BNE    ($CF3D)        ;
CF28 96   23      LDA    >$23           ;
CF2A 97   8A      STA    >$8A           ;
CF2C DC   7C      LDD    >$7C           ;
CF2E BD   D11B    JSR    ($D11B)        ;
CF31 DD   7C      STD    >$7C           ;
CF33 0C   8B      INC    >$8B           ;
CF35 96   8B      LDA    >$8B           ;
CF37 81   09      CMPA   #$09           ;
CF39 102F FF31    LBLE   ($CF3D)        ;
CF3D 39           RTS                   ;
CF3E C8   80      EORB   #$80           ;
CF40 50           NEGB                  ;
CF41 32   1F      LEAS   -1,X           ;
CF43 14           ????   -1,X           ;
CF44 0C   08      INC    >$08           ;
CF46 04   02      LSR    >$02           ;
CF48 FF           ????   >$02           ;
CF49 9C   64      CMPX   >$64           ;
CF4B 41           ????   >$64           ;
CF4C 28   1A      BVC    ($CF68)        ;
CF4E 100A         ????   ($CF68)        ;
CF50 06   03      ROR    >$03           ;
CF52 01           ????   >$03           ;
CF53 8D   0E      BSR    ($CF63)        ;
CF55 27   0B      BEQ    ($CF62)        ;
CF57 10A3 02      CMPD   2,X            ;
CF5A 26   F7      BNE    ($CF53)        ;
CF5C 6D   05      TST    5,X            ;
CF5E 26   F3      BNE    ($CF53)        ;
CF60 1C   FB      ANDCC  #$FB           ;
CF62 39           RTS                   ;

; Locate object

CF63 34   02      PSHS   #$02           ;
CF65 96   81      LDA    >$81           ;
CF67 9E   92      LDX    >$92           ;
CF69 0D   91      TST    >$91           ;
CF6B 26   05      BNE    ($CF72)        ;
CF6D 8E   0B07    LDX    #$0B07         ;
CF70 0A   91      DEC    >$91           ;
CF72 30   0E      LEAX   14,X           ;
CF74 9F   92      STX    >$92           ;
CF76 9C   0F      CMPX   >$0F           ;
CF78 27   06      BEQ    ($CF80)        ;
CF7A A1   04      CMPA   4,X            ;
CF7C 26   F4      BNE    ($CF72)        ;
CF7E 1C   FB      ANDCC  #$FB           ;
CF80 35   82      PULS   #$82           ;
CF82 8E   03C3    LDX    #$03C3         ;
CF85 30   88 11   LEAX   $11,X          ;
CF88 8C   05F4    CMPX   #$05F4         ;
CF8B 27   09      BEQ    ($CF96)        ;
CF8D 10A3 0F      CMPD   15,X           ;
CF90 26   F3      BNE    ($CF85)        ;
CF92 6D   0C      TST    12,X           ;
CF94 27   EF      BEQ    ($CF85)        ;
CF96 39           RTS                   ;
CF97 34   16      PSHS   #$16           ;
CF99 BD   CC71    JSR    ($CC71)        ;
CF9C ED   E4      STD    ,S             ;
CF9E A6   84      LDA    ,X             ;
CFA0 4C           INCA                  ;
CFA1 27   F6      BEQ    ($CF99)        ;
CFA3 35   96      PULS   #$96           ;
CFA5 34   76      PSHS   #$76           ;
CFA7 CE   03C3    LDU    #$03C3         ;
CFAA 33   C8 11   LEAU   $11,U          ;
CFAD 6D   4C      TST    12,U           ;
CFAF 26   F9      BNE    ($CFAA)        ;
CFB1 6A   4C      DEC    12,U           ;
CFB3 A7   4D      STA    13,U           ;
CFB5 C6   08      LDB    #$08           ;
CFB7 3D           MUL                   ;
CFB8 C3   DABB    ADDD   #$DABB         ;
CFBB 1F   02      TFR    #$02           ;
CFBD 1F   31      TFR    #$31           ;
CFBF 86   08      LDA    #$08           ;
CFC1 BD   C04B    JSR    ($C04B)        ;
CFC4 8D   D1      BSR    ($CF97)        ;
CFC6 8D   BA      BSR    ($CF82)        ;
CFC8 26   FA      BNE    ($CFC4)        ;
CFCA ED   4F      STD    15,U           ;
CFCC 1F   31      TFR    #$31           ;
CFCE BD   C25C    JSR    ($C25C)        ;
CFD1 AF   45      STX    5,U            ;
CFD3 CC   D041    LDD    #$D041         ;
CFD6 ED   43      STD    3,U            ;
CFD8 A6   06      LDA    6,X            ;
CFDA C6   04      LDB    #$04           ;
CFDC BD   C21D    JSR    ($C21D)        ;
CFDF 35   F6      PULS   #$F6           ;
CFE1 34   56      PSHS   #$56           ;
CFE3 DE   86      LDU    >$86           ;
CFE5 8D   0B      BSR    ($CFF2)        ;
CFE7 4D           TSTA                  ;
CFE8 2A   04      BPL    ($CFEE)        ;
CFEA 8D   06      BSR    ($CFF2)        ;
CFEC 8B   02      ADDA   #$02           ;
CFEE A7   E4      STA    ,S             ;
CFF0 35   D6      PULS   #$D6           ;
CFF2 A6   C0      LDA    ,U+            ;
CFF4 2B   06      BMI    ($CFFC)        ;
CFF6 AE   C1      LDX    ,U++           ;
CFF8 AC   62      CMPX   2,S            ;
CFFA 26   F6      BNE    ($CFF2)        ;
CFFC 39           RTS                   ;
CFFD 80   01      SUBA   #$01           ;
CFFF 00   17      NEG    >$17           ;
D001 00   0F      NEG    >$0F           ;
D003 04   00      LSR    >$00           ;
D005 14           ????   >$00           ;
D006 1101         ????   >$00           ;
D008 1C   1E      ANDCC  #$1E           ;
D00A 80   01      SUBA   #$01           ;
D00C 02           ????   #$01           ;
D00D 03   00      COM    >$00           ;
D00F 03   1F      COM    >$1F           ;
D011 00   13      NEG    >$13           ;
D013 14           ????   >$13           ;
D014 00   1F      NEG    >$1F           ;
D016 00   80      NEG    >$80           ;
D018 80   00      SUBA   #$00           ;
D01A 00   1F      NEG    >$1F           ;
D01C 00   05      NEG    >$05           ;
D01E 00   00      NEG    >$00           ;
D020 16   1C0D    LBRA   ($CFF2)        ;
D023 1F   10      TFR    #$10           ;
D025 80   80      SUBA   #$80           ;
D027 9E   82      LDX    >$82           ;
D029 C6   0B      LDB    #$0B           ;
D02B 4F           CLRA                  ;
D02C AB   85      ADDA   B,X            ;
D02E 5A           DECB                  ;
D02F 2A   FB      BPL    ($D02C)        ;
D031 81   20      CMPA   #$20           ;
D033 24   08      BCC    ($D03D)        ;
D035 3F   07      SWI    #$07           ;
D037 84   07      ANDA   #$07           ;
D039 8B   02      ADDA   #$02           ;
D03B 6C   86      INC    A,X            ;
D03D CC   0508    LDD    #$0508         ;
D040 39           RTS                   ;
D041 10AE 45      LDY    5,U            ;
D044 0D   2B      TST    >$2B           ;
D046 26   22      BNE    ($D06A)        ;
D048 E6   2C      LDB    12,Y           ;
D04A 26   01      BNE    ($D04D)        ;
D04C 39           RTS                   ;
D04D A6   2D      LDA    13,Y           ;
D04F 81   06      CMPA   #$06           ;
D051 27   1A      BEQ    ($D06D)        ;
D053 81   0A      CMPA   #$0A           ;
D055 2C   16      BGE    ($D06D)        ;
D057 EC   2F      LDD    15,Y           ;
D059 0F   91      CLR    >$91           ;
D05B BD   CF53    JSR    ($CF53)        ;
D05E 27   0D      BEQ    ($D06D)        ;
D060 EC   28      LDD    8,Y            ;
D062 AF   28      STX    8,Y            ;
D064 ED   84      STD    ,X             ;
D066 6A   05      DEC    5,X            ;
D068 3F   0E      SWI    #$0E           ;
D06A 7E   D103    JMP    ($D103)        ;
D06D EC   2F      LDD    15,Y           ;
D06F 1093 13      CMPD   >$13           ;
D072 26   3E      BNE    ($D0B2)        ;
D074 A6   2D      LDA    13,Y           ;
D076 C6   FF      LDB    #$FF           ;
D078 3F   1C      SWI    #$1C           ;
D07A CC   8080    LDD    #$8080         ;
D07D 9E   1D      LDX    >$1D           ;
D07F 8D   1D      BSR    ($D09E)        ;
D081 9E   1F      LDX    >$1F           ;
D083 8D   19      BSR    ($D09E)        ;
D085 97   1A      STA    >$1A           ;
D087 D7   1C      STB    >$1C           ;
D089 1F   21      TFR    #$21           ;
D08B CE   0217    LDU    #$0217         ;
D08E BD   D3D7    JSR    ($D3D7)        ;
D091 2B   06      BMI    ($D099)        ;
D093 3F   1B      SWI    #$1B           ;
D095 13           SYNC                  ;
D096 BD   D40C    JSR    ($D40C)        ;
D099 3F   0C      SWI    #$0C           ;
D09B 7E   D10F    JMP    ($D10F)        ;
D09E 34   16      PSHS   #$16           ;
D0A0 27   0E      BEQ    ($D0B0)        ;
D0A2 A6   0A      LDA    10,X           ;
D0A4 81   03      CMPA   #$03           ;
D0A6 26   08      BNE    ($D0B0)        ;
D0A8 AE   06      LDX    6,X            ;
D0AA AC   E4      CMPX   ,S             ;
D0AC 24   02      BCC    ($D0B0)        ;
D0AE AF   E4      STX    ,S             ;
D0B0 35   96      PULS   #$96           ;
D0B2 91   13      CMPA   >$13           ;
D0B4 26   0D      BNE    ($D0C3)        ;
D0B6 A6   A8 10   LDA    $10,Y          ;
D0B9 C6   01      LDB    #$01           ;
D0BB 90   14      SUBA   >$14           ;
D0BD 2B   11      BMI    ($D0D0)        ;
D0BF C6   03      LDB    #$03           ;
D0C1 20   0D      BRA    ($D0D0)        ;
D0C3 EC   2F      LDD    15,Y           ;
D0C5 D1   14      CMPB   >$14           ;
D0C7 26   1B      BNE    ($D0E4)        ;
D0C9 C6   02      LDB    #$02           ;
D0CB 90   13      SUBA   >$13           ;
D0CD 2B   01      BMI    ($D0D0)        ;
D0CF 5F           CLRB                  ;
D0D0 D7   8A      STB    >$8A           ;
D0D2 EC   2F      LDD    15,Y           ;
D0D4 8D   60      BSR    ($D136)        ;
D0D6 26   0C      BNE    ($D0E4)        ;
D0D8 1093 13      CMPD   >$13           ;
D0DB 26   F7      BNE    ($D0D4)        ;
D0DD D6   8A      LDB    >$8A           ;
D0DF E7   2E      STB    14,Y           ;
D0E1 5F           CLRB                  ;
D0E2 20   1D      BRA    ($D101)        ;
D0E4 8E   D114    LDX    #$D114         ;
D0E7 3F   07      SWI    #$07           ;
D0E9 4D           TSTA                  ;
D0EA 2B   02      BMI    ($D0EE)        ;
D0EC 30   03      LEAX   3,X            ;
D0EE 84   03      ANDA   #$03           ;
D0F0 26   02      BNE    ($D0F4)        ;
D0F2 30   01      LEAX   1,X            ;
D0F4 86   03      LDA    #$03           ;
D0F6 E6   80      LDB    ,X+            ;
D0F8 8D   55      BSR    ($D14F)        ;
D0FA 27   07      BEQ    ($D103)        ;
D0FC 4A           DECA                  ;
D0FD 26   F7      BNE    ($D0F6)        ;
D0FF C6   02      LDB    #$02           ;
D101 8D   4C      BSR    ($D14F)        ;
D103 A6   26      LDA    6,Y            ;
D105 AE   2F      LDX    15,Y           ;
D107 9C   13      CMPX   >$13           ;
D109 26   06      BNE    ($D111)        ;
D10B 3F   0E      SWI    #$0E           ;
D10D 0F   B5      CLR    >$B5           ;
D10F A6   27      LDA    7,Y            ;
D111 C6   04      LDB    #$04           ;
D113 39           RTS                   ;
D114 00   03      NEG    >$03           ;
D116 01           ????   >$03           ;
D117 00   01      NEG    >$01           ;
D119 03   00      COM    >$00           ;
D11B 34   06      PSHS   #$06           ;
D11D D6   8A      LDB    >$8A           ;
D11F C4   03      ANDB   #$03           ;
D121 58           ASLB                  ;
D122 8E   D12E    LDX    #$D12E         ;
D125 EC   85      LDD    B,X            ;
D127 AB   E0      ADDA   ,S+            ;
D129 EB   E0      ADDB   ,S+            ;
D12B 7E   CC7B    JMP    ($CC7B)        ;
D12E FF           ????   ($CC7B)        ;
D12F 00   00      NEG    >$00           ;
D131 01           ????   >$00           ;
D132 01           ????   >$00           ;
D133 00   00      NEG    >$00           ;
D135 FF           ????   >$00           ;
D136 34   76      PSHS   #$76           ;
D138 8D   E1      BSR    ($D11B)        ;
D13A BD   CC8E    JSR    ($CC8E)        ;
D13D 26   0E      BNE    ($D14D)        ;
D13F 1F   03      TFR    #$03           ;
D141 A6   84      LDA    ,X             ;
D143 4C           INCA                  ;
D144 27   06      BEQ    ($D14C)        ;
D146 EF   E4      STU    ,S             ;
D148 AF   62      STX    2,S            ;
D14A 86   01      LDA    #$01           ;
D14C 4A           DECA                  ;
D14D 35   F6      PULS   #$F6           ;
D14F 34   16      PSHS   #$16           ;
D151 EB   2E      ADDB   14,Y           ;
D153 C4   03      ANDB   #$03           ;
D155 D7   8A      STB    >$8A           ;
D157 EC   2F      LDD    15,Y           ;
D159 8D   DB      BSR    ($D136)        ;
D15B 26   3C      BNE    ($D199)        ;
D15D BD   CF82    JSR    ($CF82)        ;
D160 26   37      BNE    ($D199)        ;
D162 ED   2F      STD    15,Y           ;
D164 D6   8A      LDB    >$8A           ;
D166 E7   2E      STB    14,Y           ;
D168 EC   2F      LDD    15,Y           ;
D16A 90   13      SUBA   >$13           ;
D16C 2A   01      BPL    ($D16F)        ;
D16E 40           NEGA                  ;
D16F D0   14      SUBB   >$14           ;
D171 2A   01      BPL    ($D174)        ;
D173 50           NEGB                  ;
D174 D7   C1      STB    >$C1           ;
D176 91   C1      CMPA   >$C1           ;
D178 2C   02      BGE    ($D17C)        ;
D17A 1E   89      EXG    #$89           ;
D17C 97   C1      STA    >$C1           ;
D17E 81   08      CMPA   #$08           ;
D180 2E   16      BGT    ($D198)        ;
D182 C1   02      CMPB   #$02           ;
D184 2E   12      BGT    ($D198)        ;
D186 3F   07      SWI    #$07           ;
D188 85   01      BITA   #$01           ;
D18A 27   0A      BEQ    ($D196)        ;
D18C 96   C1      LDA    >$C1           ;
D18E C6   1F      LDB    #$1F           ;
D190 3D           MUL                   ;
D191 53           COMB                  ;
D192 A6   2D      LDA    13,Y           ;
D194 3F   1C      SWI    #$1C           ;
D196 0A   B5      DEC    >$B5           ;
D198 4F           CLRA                  ;
D199 35   96      PULS   #$96           ;
D19B DE   24      LDU    >$24           ;
D19D 27   1D      BEQ    ($D1BC)        ;
D19F A6   46      LDA    6,U            ;
D1A1 27   19      BEQ    ($D1BC)        ;
D1A3 4A           DECA                  ;
D1A4 A7   46      STA    6,U            ;
D1A6 81   05      CMPA   #$05           ;
D1A8 2E   06      BGT    ($D1B0)        ;
D1AA C6   18      LDB    #$18           ;
D1AC E7   49      STB    9,U            ;
D1AE 6F   4B      CLR    11,U           ;
D1B0 A1   47      CMPA   7,U            ;
D1B2 2C   02      BGE    ($D1B6)        ;
D1B4 A7   47      STA    7,U            ;
D1B6 A1   48      CMPA   8,U            ;
D1B8 2C   02      BGE    ($D1BC)        ;
D1BA A7   48      STA    8,U            ;
D1BC 0A   B5      DEC    >$B5           ;
D1BE CC   0108    LDD    #$0108         ;
D1C1 39           RTS                   ;
D1C2 0D   B5      TST    >$B5           ;
D1C4 26   07      BNE    ($D1CD)        ;
D1C6 8E   CDB2    LDX    #$CDB2         ;
D1C9 9C   B2      CMPX   >$B2           ;
D1CB 26   04      BNE    ($D1D1)        ;
D1CD 0F   B5      CLR    >$B5           ;
D1CF 3F   0E      SWI    #$0E           ;
D1D1 CC   0304    LDD    #$0304         ;
D1D4 39           RTS                   ;
D1D5 4F           CLRA                  ;
D1D6 5F           CLRB                  ;
D1D7 93   21      SUBD   >$21           ;
D1D9 BD   D379    JSR    ($D379)        ;
D1DC D3   21      ADDD   >$21           ;
D1DE 2E   02      BGT    ($D1E2)        ;
D1E0 4F           CLRA                  ;
D1E1 5F           CLRB                  ;
D1E2 DD   21      STD    >$21           ;
D1E4 3F   0C      SWI    #$0C           ;
D1E6 96   AF      LDA    >$AF           ;
D1E8 C6   02      LDB    #$02           ;
D1EA 39           RTS                   ;
D1EB 0D   77      TST    >$77           ;
D1ED 26   2C      BNE    ($D21B)        ;
D1EF BD   C329    JSR    ($C329)        ;
D1F2 4D           TSTA                  ;
D1F3 27   53      BEQ    ($D248)        ;
D1F5 0D   28      TST    >$28           ;
D1F7 26   F6      BNE    ($D1EF)        ;
D1F9 81   20      CMPA   #$20           ;
D1FB 27   18      BEQ    ($D215)        ;
D1FD C6   1F      LDB    #$1F           ;
D1FF 81   0D      CMPA   #$0D           ;
D201 27   0F      BEQ    ($D212)        ;
D203 C6   24      LDB    #$24           ;
D205 81   08      CMPA   #$08           ;
D207 27   09      BEQ    ($D212)        ;
D209 5F           CLRB                  ;
D20A 81   41      CMPA   #$41           ;
D20C 25   04      BCS    ($D212)        ;
D20E 81   5A      CMPA   #$5A           ;
D210 23   03      BLS    ($D215)        ;
D212 1F   98      TFR    #$98           ;
D214 8C   841F    CMPX   #$841F         ;
D217 8D   33      BSR    ($D24C)        ;
D219 20   D4      BRA    ($D1EF)        ;
D21B 109E 0D      LDY    >$0D           ;
D21E E6   A0      LDB    ,Y+            ;
D220 2A   07      BPL    ($D229)        ;
D222 3F   10      SWI    #$10           ;
D224 3F   10      SWI    #$10           ;
D226 7E   C000    JMP    ($C000)        ; Restart

D229 AE   A1      LDX    ,Y++           ;
D22B CE   0361    LDU    #$0361         ;
D22E 3F   06      SWI    #$06           ;
D230 33   41      LEAU   1,U            ;
D232 3F   10      SWI    #$10           ;
D234 8C   8D15    CMPX   #$8D15         ;
D237 A6   C0      LDA    ,U+            ;
D239 2A   FA      BPL    ($D235)        ;
D23B 4F           CLRA                  ;
D23C 8D   0E      BSR    ($D24C)        ;
D23E 5A           DECB                  ;
D23F 26   E8      BNE    ($D229)        ;
D241 86   1F      LDA    #$1F           ;
D243 8D   07      BSR    ($D24C)        ;
D245 109F 0D      STY    >$0D           ;
D248 CC   0102    LDD    #$0102         ;
D24B 39           RTS                   ;
D24C 34   76      PSHS   #$76           ;
D24E 0D   AD      TST    >$AD           ;
D250 26   04      BNE    ($D256)        ;
D252 3F   19      SWI    #$19           ;
D254 3F   0F      SWI    #$0F           ;
D256 DE   11      LDU    >$11           ;
D258 81   1F      CMPA   #$1F           ;
D25A 27   13      BEQ    ($D26F)        ;
D25C 81   24      CMPA   #$24           ;
D25E 27   1D      BEQ    ($D27D)        ;
D260 3F   04      SWI    #$04           ;
D262 A7   C0      STA    ,U+            ;
D264 8E   C67C    LDX    #$C67C         ; Cursor data
D267 3F   03      SWI    #$03           ; Print cursor
D269 1183 0311    CMPU   #$0311         ;
D26D 26   45      BNE    ($D2B4)        ;
D26F 4F           CLRA                  ;
D270 3F   04      SWI    #$04           ;
D272 DC   03      LDD    >$03           ;
D274 ED   C1      STD    ,U++           ;
D276 CE   02F1    LDU    #$02F1         ;
D279 DF   11      STU    >$11           ;
D27B 20   15      BRA    ($D292)        ;
D27D 1183 02F1    CMPU   #$02F1         ;
D281 27   31      BEQ    ($D2B4)        ;
D283 33   5F      LEAU   -1,U           ;
D285 8E   D28C    LDX    #$D28C         ;
D288 3F   03      SWI    #$03           ;
D28A 20   28      BRA    ($D2B4)        ;
D28C 00   24      NEG    >$24           ;
D28E 24   1C      BCC    ($D2AC)        ;
D290 24   FF      BCC    ($D291)        ;
D292 8E   D894    LDX    #$D894         ;
D295 BD   CBEC    JSR    ($CBEC)        ;
D298 27   0D      BEQ    ($D2A7)        ;
D29A 2A   05      BPL    ($D2A1)        ;
D29C BD   CBE1    JSR    ($CBE1)        ;
D29F 20   06      BRA    ($D2A7)        ;
D2A1 48           ASLA                  ;
D2A2 8E   D9D0    LDX    #$D9D0         ;
D2A5 AD   96      JSR    [A,X]          ;
D2A7 CE   02F1    LDU    #$02F1         ;
D2AA 0D   AD      TST    >$AD           ;
D2AC 27   06      BEQ    ($D2B4)        ;
D2AE 0D   28      TST    >$28           ;
D2B0 26   02      BNE    ($D2B4)        ;
D2B2 3F   0F      SWI    #$0F           ;
D2B4 DF   11      STU    >$11           ;
D2B6 35   F6      PULS   #$F6           ;

D2B8 BD   CC31    JSR    ($CC31)        ; 
D2BB EE   C4      LDU    ,U             ;
D2BD 26   03      BNE    ($D2C2)        ;
D2BF CE   0B07    LDU    #$0B07         ;
D2C2 1F   32      TFR    #$32           ;
D2C4 A6   4C      LDA    12,U           ;
D2C6 97   19      STA    >$19           ;
D2C8 A6   4D      LDA    13,U           ;
D2CA 97   1B      STA    >$1B           ;
D2CC 9B   19      ADDA   >$19           ;
D2CE 46           RORA                  ;
D2CF 44           LSRA                  ;
D2D0 44           LSRA                  ;
D2D1 9E   17      LDX    >$17           ; Strength
D2D3 BD   D436    JSR    ($D436)        ; 
D2D6 D3   21      ADDD   >$21           ;
D2D8 DD   21      STD    >$21           ;
D2DA A6   4A      LDA    10,U           ; Object class
D2DC 8B   0C      ADDA   #$0C           ; Sound table offset
D2DE C6   FF      LDB    #$FF           ; Full volume
D2E0 3F   1C      SWI    #$1C           ; Play sound of object

; A = U[9]                  ; Get object's proper name
; if(A>=0x13 && A<=0x15) {  ; Is this one of the 3 rings?
;    --U[6]                 ; Subtract one from ring counter
;    if(ZERO) {             ; Is the ring all used up?
;      A = 0x16             ; GOLD proper name
;      U[9] = A             ; Ring is now now a GOLD ring
;      JSR  ($D638)         ; Change object display in our hand
;    }
; }

D2E2 A6   49      LDA    9,U            ; Proper name
D2E4 81   13      CMPA   #$13           ; Ring range?
D2E6 2D   0F      BLT    ($D2F7)        ; Too low
D2E8 81   15      CMPA   #$15           ; Ring Range?
D2EA 2E   0B      BGT    ($D2F7)        ; Too high
D2EC 6A   46      DEC    6,U            ; Subtract one from ring counter
D2EE 26   07      BNE    ($D2F7)        ; Still good, go on
D2F0 86   16      LDA    #$16           ; GOLD token
D2F2 A7   49      STA    9,U            ; Now a gold ring
D2F4 BD   D638    JSR    ($D638)        ; Change object

D2F7 DC   13      LDD    >$13           ; Our coordinates
D2F9 BD   CF82    JSR    ($CF82)        ; Find creature
D2FC 27   77      BEQ    ($D375)        ; None found ignore attack
D2FE CE   0217    LDU    #$0217         ;
D301 1E   13      EXG    #$13           ;
D303 A6   2A      LDA    10,Y           ; Class
D305 81   01      CMPA   #$01           ; Is it a ring?
D307 27   16      BEQ    ($D31F)        ; Yes-- can't miss
D309 BD   D3D7    JSR    ($D3D7)        ; Otherwise get calculate hit chance
D30C 2B   67      BMI    ($D375)        ; Oops, missed
D30E 109E 24      LDY    >$24           ; Torch pointer
D311 27   06      BEQ    ($D319)        ; Oh, no, no torch...
D313 A6   29      LDA    9,Y            ; Proper name of torch
D315 81   18      CMPA   #$18           ; Well, it is dead!
D317 26   06      BNE    ($D31F)        ; No, go on
D319 3F   07      SWI    #$07           ; Random number
D31B 84   03      ANDA   #$03           ; Between 0 and 3
D31D 26   56      BNE    ($D375)        ; Only one in three will hit
D31F 3F   1B      SWI    #$1B           ; Sound a hit
D321 12           NOP                   ;
D322 3F   02      SWI    #$02           ; Print !!!
D324 16   0D34    LBRA   ($D375)        ;
D327 BD   D40C    JSR    ($D40C)        ;
D32A 22   49      BHI    ($D375)        ;
D32C 30   48      LEAX   8,U            ; First in object link for monster
D32E AE   84      LDX    ,X             ; Get pointer to next object in list
D330 27   08      BEQ    ($D33A)        ; That's all
D332 6F   05      CLR    5,X            ; Drop on floor
D334 EC   4F      LDD    15,U           ; Coordinate from monster
D336 ED   02      STD    2,X            ; Now to object
D338 20   F4      BRA    ($D32E)        ; Keep going for all
D33A 9E   82      LDX    >$82           ;
D33C E6   4D      LDB    13,U           ;
D33E 6A   85      DEC    B,X            ;
D340 6F   4C      CLR    12,U           ; Monster dead
D342 3F   0E      SWI    #$0E           ;
D344 3F   1B      SWI    #$1B           ; Sound monster dead
D346 15           ????   #$1B           ;
D347 EC   C4      LDD    ,U             ; Monster strength
D349 8D   34      BSR    ($D37F)        ;
D34B D3   17      ADDD   >$17           ; Add to our strength
D34D 2A   02      BPL    ($D351)        ; No overflow
D34F 86   7F      LDA    #$7F           ; Maximum high
D351 DD   17      STD    >$17           ; New strength
D353 A6   4D      LDA    13,U           ; What did we just kill?
D355 81   0A      CMPA   #$0A           ; Demon... 
D357 27   2D      BEQ    ($D386)        ; ...go to level 4
D359 81   0B      CMPA   #$0B           ; Wizard...
D35B 26   18      BNE    ($D375)        ; No, leave from here
D35D 0A   2B      DEC    >$2B           ;
D35F CC   0713    LDD    #$0713         ; Light level
D362 DD   26      STD    >$26           ; Temporary light
D364 8E   0B23    LDX    #$0B23         ;
D367 9F   0F      STX    >$0F           ;
D369 DC   00      LDD    >$00           ; Zero
D36B DD   29      STD    >$29           ;
D36D DD   24      STD    >$24           ; No torch
D36F DD   1F      STD    >$1F           ; Left hand empty
D371 DD   1D      STD    >$1D           ; Right hand empty
D373 3F   19      SWI    #$19           ;
D375 3F   0C      SWI    #$0C           ;
D377 47           ASRA                  ;
D378 56           RORB                  ;
D379 47           ASRA                  ;
D37A 56           RORB                  ;
D37B 47           ASRA                  ;
D37C 56           RORB                  ;
D37D 47           ASRA                  ;
D37E 56           RORB                  ;
D37F 47           ASRA                  ;
D380 56           RORB                  ;
D381 47           ASRA                  ;
D382 56           RORB                  ;
D383 47           ASRA                  ;
D384 56           RORB                  ;
D385 39           RTS                   ;

Demon killed

D386 8E   DF10    LDX    #$DF10         ; Wizard
D389 3F   13      SWI    #$13           ; Beam him on
D38B 3F   02      SWI    #$02           ;
D38D FF           ????   #$02           ;
D38E C0   57      SUBB   #$57           ;
D390 3E           ????   #$57           ;
D391 A7   46      STA    6,U            ;
D393 C0   90      SUBB   #$90           ;
D395 51           ????   #$90           ;
D396 32   28      LEAS   8,Y            ;
D398 1E   60      EXG    #$60           ;
D39A 51           ????   #$60           ;
D39B 09   98      ROL    >$98           ;
D39D 20   C0      BRA    ($D35F)        ;
D39F E7   DE      STB    ?post byte?    ;
D3A1 F0   3F02    SUBB   ($3F02)        ;
D3A4 E8   00      EORB   0,X            ;
D3A6 08   48      ASL    >$48           ;
D3A8 B0   0C8A    SUBA   ($0C8A)        ;
D3AB 0A   3C      DEC    >$3C           ;
D3AD 0D   29      TST    >$29           ;
D3AF 68   0A      ASL    10,X           ;
D3B1 23   20      BLS    ($D3D3)        ;
D3B3 23   DE      BLS    ($D393)        ;
D3B5 DD   EF      STD    >$EF           ;
D3B7 60   3F      NEG    -1,Y           ;
D3B9 10DE 24      LDS    >$24           ;
D3BC DF   29      STU    >$29           ;
D3BE 27   04      BEQ    ($D3C4)        ;
D3C0 4F           CLRA                  ;
D3C1 5F           CLRB                  ;
D3C2 ED   C4      STD    ,U             ;
D3C4 CC   00C8    LDD    #$00C8         ;
D3C7 DD   15      STD    >$15           ;
D3C9 86   03      LDA    #$03           ; Level 4
D3CB 3F   1A      SWI    #$1A           ; Prepare level
D3CD BD   CF97    JSR    ($CF97)        ; Get random coordinates
D3D0 DD   13      STD    >$13           ; New coordinates
D3D2 3F   15      SWI    #$15           ;
D3D4 3F   19      SWI    #$19           ;
D3D6 39           RTS                   ;

D3D7 34   56      PSHS   #$56           ;
D3D9 86   0F      LDA    #$0F           ;
D3DB 97   C1      STA    >$C1           ;
D3DD EC   C4      LDD    ,U             ;
D3DF A3   4A      SUBD   10,U           ;
D3E1 BD   CA12    JSR    ($CA12)        ;
D3E4 A3   84      SUBD   ,X             ;
D3E6 25   04      BCS    ($D3EC)        ;
D3E8 0A   C1      DEC    >$C1           ;
D3EA 26   F8      BNE    ($D3E4)        ;
D3EC D6   C1      LDB    >$C1           ;
D3EE C0   03      SUBB   #$03           ;
D3F0 2A   09      BPL    ($D3FB)        ;
D3F2 50           NEGB                  ;
D3F3 86   19      LDA    #$19           ;
D3F5 3D           MUL                   ;
D3F6 BD   CA99    JSR    ($CA99)        ;
D3F9 20   03      BRA    ($D3FE)        ;
D3FB 86   0A      LDA    #$0A           ;
D3FD 3D           MUL                   ;
D3FE ED   E3      STD    ,--S           ;
D400 3F   07      SWI    #$07           ;
D402 1F   89      TFR    #$89           ;
D404 4F           CLRA                  ;
D405 E3   E1      ADDD   ,S++           ;
D407 83   007F    SUBD   #$007F         ;
D40A 35   D6      PULS   #$D6           ;
D40C 34   76      PSHS   #$76           ;
D40E 1F   12      TFR    #$12           ;
D410 AE   A4      LDX    ,Y             ;
D412 A6   22      LDA    2,Y            ;
D414 8D   20      BSR    ($D436)        ;
D416 1F   01      TFR    #$01           ;
D418 A6   43      LDA    3,U            ;
D41A 8D   1A      BSR    ($D436)        ;
D41C E3   4A      ADDD   10,U           ;
D41E ED   4A      STD    10,U           ;
D420 AE   A4      LDX    ,Y             ;
D422 A6   24      LDA    4,Y            ;
D424 8D   10      BSR    ($D436)        ;
D426 1F   01      TFR    #$01           ;
D428 A6   45      LDA    5,U            ;
D42A 8D   0A      BSR    ($D436)        ;
D42C E3   4A      ADDD   10,U           ;
D42E ED   4A      STD    10,U           ;
D430 AE   C4      LDX    ,U             ;
D432 AC   4A      CMPX   10,U           ;
D434 35   F6      PULS   #$F6           ;
D436 34   16      PSHS   #$16           ;
D438 0F   C1      CLR    >$C1           ;
D43A E6   63      LDB    3,S            ;
D43C 3D           MUL                   ;
D43D DD   C2      STD    >$C2           ;
D43F A6   E4      LDA    ,S             ;
D441 E6   62      LDB    2,S            ;
D443 3D           MUL                   ;
D444 D3   C1      ADDD   >$C1           ;
D446 08   C3      ASL    >$C3           ;
D448 59           ROLB                  ;
D449 49           ROLA                  ;
D44A ED   E4      STD    ,S             ;
D44C 35   96      PULS   #$96           ;
D44E DC   13      LDD    >$13           ;
D450 BD   CFE1    JSR    ($CFE1)        ;
D453 2B   1A      BMI    ($D46F)        ;
D455 97   C1      STA    >$C1           ;
D457 8E   D8D9    LDX    #$D8D9         ;
D45A BD   CBEC    JSR    ($CBEC)        ;
D45D 2F   10      BLE    ($D46F)        ;
D45F D6   C1      LDB    >$C1           ;
D461 81   04      CMPA   #$04           ;
D463 27   0D      BEQ    ($D472)        ;
D465 81   05      CMPA   #$05           ;
D467 26   06      BNE    ($D46F)        ;
D469 86   01      LDA    #$01           ;
D46B C5   02      BITB   #$02           ;
D46D 26   09      BNE    ($D478)        ;
D46F 7E   CBE1    JMP    ($CBE1)        ;
D472 86   FF      LDA    #$FF           ;
D474 C1   01      CMPB   #$01           ;
D476 26   F7      BNE    ($D46F)        ;
D478 3F   16      SWI    #$16           ;
D47A 9B   81      ADDA   >$81           ;
D47C 3F   1A      SWI    #$1A           ;
D47E 3F   19      SWI    #$19           ;
D480 39           RTS                   ;
D481 8E   D495    LDX    #$D495         ;
D484 9F   B2      STX    >$B2           ;
D486 3F   0E      SWI    #$0E           ;
D488 39           RTS                   ;
D489 3F   09      SWI    #$09           ;
D48B AE   C4      LDX    ,U             ;
D48D CE   0380    LDU    #$0380         ;
D490 AF   C4      STX    ,U             ;
D492 0A   B7      DEC    >$B7           ;
D494 39           RTS                   ;
D495 8D   F2      BSR    ($D489)        ;
D497 0F   B6      CLR    >$B6           ;
D499 CC   000A    LDD    #$000A         ;
D49C ED   44      STD    4,U            ;
D49E 3F   02      SWI    #$02           ;
D4A0 62           ????   #$02           ;
D4A1 5C           INCB                  ;
D4A2 0A   21      DEC    >$21           ;
D4A4 33   04      LEAU   4,X            ;
D4A6 9E   F6      LDX    >$F6           ;
D4A8 FC   DC13    LDD    ($DC13)        ;
D4AB BD   CF82    JSR    ($CF82)        ;
D4AE 27   10      BEQ    ($D4C0)        ;
D4B0 AE   44      LDX    4,U            ;
D4B2 30   0B      LEAX   11,X           ;
D4B4 AF   44      STX    4,U            ;
D4B6 3F   02      SWI    #$02           ;
D4B8 56           RORB                  ;
D4B9 C7           ????                  ;
D4BA 22   86      BHI    ($D442)        ;
D4BC 95   91      BITA   >$91           ;
D4BE 77   F00F    ASR    ($F00F)        ;
D4C1 91   DC      CMPA   >$DC           ;
D4C3 13           SYNC                  ;
D4C4 BD   CF53    JSR    ($CF53)        ;
D4C7 27   04      BEQ    ($D4CD)        ;
D4C9 8D   3A      BSR    ($D505)        ;
D4CB 20   F5      BRA    ($D4C2)        ;
D4CD 0D   B6      TST    >$B6           ;
D4CF 27   02      BEQ    ($D4D3)        ;
D4D1 8D   2B      BSR    ($D4FE)        ;
D4D3 CC   1B20    LDD    #$1B20         ;
D4D6 3F   04      SWI    #$04           ;
D4D8 5A           DECB                  ;
D4D9 26   FB      BNE    ($D4D6)        ;
D4DB AE   44      LDX    4,U            ;
D4DD 30   0C      LEAX   12,X           ;
D4DF AF   44      STX    4,U            ;
D4E1 3F   02      SWI    #$02           ;
D4E3 40           NEGA                  ;
D4E4 82   35      SBCA   #$35           ;
D4E6 C0   23      SUBB   #$23           ;
D4E8 5F           CLRB                  ;
D4E9 C0   8E      SUBB   #$8E           ;
D4EB 02           ????   #$8E           ;
D4EC 29   AE      BVS    ($D49C)        ;
D4EE 84   27      ANDA   #$27           ;
D4F0 0A   9C      DEC    >$9C           ;
D4F2 24   26      BCC    ($D51A)        ;
D4F4 02           ????   ($D51A)        ;
D4F5 63   46      COM    6,U            ;
D4F7 8D   0C      BSR    ($D505)        ;
D4F9 20   F2      BRA    ($D4ED)        ;
D4FB 0F   B7      CLR    >$B7           ;
D4FD 39           RTS                   ;
D4FE 86   1F      LDA    #$1F           ;
D500 3F   04      SWI    #$04           ;
D502 0F   B6      CLR    >$B6           ;
D504 39           RTS                   ;
D505 34   16      PSHS   #$16           ;
D507 BD   C617    JSR    ($C617)        ;
D50A 3F   03      SWI    #$03           ;
D50C 96   2C      LDA    >$2C           ;
D50E A7   46      STA    6,U            ;
D510 03   B6      COM    >$B6           ;
D512 27   0A      BEQ    ($D51E)        ;
D514 EC   44      LDD    4,U            ;
D516 C3   0010    ADDD   #$0010         ;
D519 C4   F0      ANDB   #$F0           ;
D51B ED   44      STD    4,U            ;
D51D 8C   8DDE    CMPX   #$8DDE         ;
D520 35   96      PULS   #$96           ;
D522 8D   52      BSR    ($D576)        ;
D524 26   4D      BNE    ($D573)        ;
D526 BD   CBBA    JSR    ($CBBA)        ;
D529 0F   91      CLR    >$91           ;
D52B DC   13      LDD    >$13           ;
D52D BD   CF53    JSR    ($CF53)        ;
D530 27   41      BEQ    ($D573)        ;
D532 0D   90      TST    >$90           ;
D534 26   06      BNE    ($D53C)        ;
D536 A6   0A      LDA    10,X           ;
D538 91   8F      CMPA   >$8F           ;
D53A 20   04      BRA    ($D540)        ;
D53C A6   09      LDA    9,X            ;
D53E 91   8E      CMPA   >$8E           ;
D540 26   E9      BNE    ($D52B)        ;
D542 AF   C4      STX    ,U             ;
D544 6C   05      INC    5,X            ;
D546 E6   0A      LDB    10,X           ;
D548 8E   D9FA    LDX    #$D9FA         ;
D54B E6   85      LDB    B,X            ;
D54D 4F           CLRA                  ;
D54E 20   1B      BRA    ($D56B)        ;
D550 8D   24      BSR    ($D576)        ;
D552 27   1F      BEQ    ($D573)        ;
D554 4F           CLRA                  ;
D555 5F           CLRB                  ;
D556 ED   C4      STD    ,U             ;
D558 6F   05      CLR    5,X            ;
D55A DC   13      LDD    >$13           ;
D55C ED   02      STD    2,X            ;
D55E 96   81      LDA    >$81           ;
D560 A7   04      STA    4,X            ;
D562 E6   0A      LDB    10,X           ;
D564 8E   D9FA    LDX    #$D9FA         ;
D567 E6   85      LDB    B,X            ;
D569 50           NEGB                  ;
D56A 1D           SEX                   ;
D56B D3   15      ADDD   >$15           ;
D56D DD   15      STD    >$15           ;
D56F 3F   0C      SWI    #$0C           ;
D571 20   44      BRA    ($D5B7)        ;
D573 7E   CBE1    JMP    ($CBE1)        ;
D576 7E   CC31    JMP    ($CC31)        ;
D579 8D   FB      BSR    ($D576)        ;
D57B 27   F6      BEQ    ($D573)        ;
D57D DC   29      LDD    >$29           ;
D57F ED   84      STD    ,X             ;
D581 9F   29      STX    >$29           ;
D583 4F           CLRA                  ;
D584 5F           CLRB                  ;
D585 ED   C4      STD    ,U             ;
D587 20   2E      BRA    ($D5B7)        ;
D589 8D   EB      BSR    ($D576)        ;
D58B 26   E6      BNE    ($D573)        ;
D58D BD   CBBA    JSR    ($CBBA)        ;
D590 8E   0229    LDX    #$0229         ;
D593 1F   12      TFR    #$12           ;
D595 AE   84      LDX    ,X             ;
D597 27   DA      BEQ    ($D573)        ;
D599 0D   90      TST    >$90           ;
D59B 26   06      BNE    ($D5A3)        ;
D59D A6   0A      LDA    10,X           ;
D59F 91   8F      CMPA   >$8F           ;
D5A1 20   04      BRA    ($D5A7)        ;
D5A3 A6   09      LDA    9,X            ;
D5A5 91   8E      CMPA   >$8E           ;
D5A7 26   EA      BNE    ($D593)        ;
D5A9 EC   84      LDD    ,X             ;
D5AB ED   A4      STD    ,Y             ;
D5AD AF   C4      STX    ,U             ;
D5AF 4F           CLRA                  ;
D5B0 5F           CLRB                  ;
D5B1 9C   24      CMPX   >$24           ;
D5B3 26   02      BNE    ($D5B7)        ;
D5B5 DD   24      STD    >$24           ;
D5B7 3F   0D      SWI    #$0D           ;
D5B9 3F   0E      SWI    #$0E           ;
D5BB 39           RTS                   ;
D5BC 8E   D8F3    LDX    #$D8F3         ;
D5BF BD   CBEC    JSR    ($CBEC)        ;
D5C2 2F   2B      BLE    ($D5EF)        ;
D5C4 0D   7B      TST    >$7B           ;
D5C6 27   27      BEQ    ($D5EF)        ;
D5C8 DD   8E      STD    >$8E           ;
D5CA DE   1D      LDU    >$1D           ;
D5CC 8D   02      BSR    ($D5D0)        ;
D5CE DE   1F      LDU    >$1F           ;
D5D0 27   1D      BEQ    ($D5EF)        ;
D5D2 A6   4A      LDA    10,U           ;
D5D4 81   01      CMPA   #$01           ;
D5D6 26   17      BNE    ($D5EF)        ;
D5D8 A6   47      LDA    7,U            ;
D5DA 27   13      BEQ    ($D5EF)        ;
D5DC 91   8E      CMPA   >$8E           ;
D5DE 26   0F      BNE    ($D5EF)        ;
D5E0 A7   49      STA    9,U            ;
D5E2 3F   18      SWI    #$18           ;
D5E4 3F   1B      SWI    #$1B           ;
D5E6 0D   3F      TST    >$3F           ;
D5E8 0D   6F      TST    >$6F           ;
D5EA 47           ASRA                  ;
D5EB 81   12      CMPA   #$12           ;
D5ED 27   01      BEQ    ($D5F0)        ;
D5EF 39           RTS                   ;
D5F0 8E   DF39    LDX    #$DF39         ;
D5F3 0A   9E      DEC    >$9E           ;
D5F5 3F   13      SWI    #$13           ;
D5F7 3F   02      SWI    #$02           ;
D5F9 FF           ????   #$02           ;
D5FA C4   54      ANDB   #$54           ;
D5FC 3D           MUL                   ;
D5FD 84   D8      ANDA   #$D8           ;
D5FF 08   59      ASL    >$59           ;
D601 D1   2E      CMPB   >$2E           ;
D603 C8   03      EORB   #$03           ;
D605 70   A693    NEG    ($A693)        ;
D608 05           ????   ($A693)        ;
D609 1050         ????   ($A693)        ;
D60B 20   2E      BRA    ($D63B)        ;
D60D 20   3F      BRA    ($D64E)        ;
D60F 02           ????   ($D64E)        ;
D610 C8   00      EORB   #$00           ;
D612 00   00      NEG    >$00           ;
D614 00   03      NEG    >$03           ;
D616 CC   0081    LDD    #$0081         ;
D619 C5   B8      BITB   #$B8           ;
D61B 2E   9D      BGT    ($D5BA)        ;
D61D 06   44      ROR    >$44           ;
D61F F7   BC20    STB    ($BC20)        ;
D622 FE   BDCC    LDU    ($BDCC)        ;
D625 31   EE      LEAY   ?post byte?    ;
D627 C4   27      ANDB   #$27           ;
D629 14           ????   #$27           ;
D62A A6   4B      LDA    11,U           ; Already revealed?
D62C 27   10      BEQ    ($D63E)        ; Yes, skip it now
D62E C6   19      LDB    #$19           ; Base multiplier
D630 3D           MUL                   ; Multiply
D631 1093 17      CMPD   >$17           ; Are we strong enough?
D634 2E   08      BGT    ($D63E)        ; No, leave it
D636 A6   49      LDA    9,U            ; Get proper name
D638 3F   18      SWI    #$18           ; Change object types
D63A 6F   4B      CLR    11,U           ; Revealed
D63C 3F   0D      SWI    #$0D           ; 
D63E 39           RTS                   ;

D63F 8E   D8D9    LDX    #$D8D9         ;
D642 BD   CBEC    JSR    ($CBEC)        ;
D645 2F   4C      BLE    ($D693)        ;
D647 D6   23      LDB    >$23           ;
D649 81   00      CMPA   #$00           ;
D64B 26   07      BNE    ($D654)        ;
D64D 5A           DECB                  ;
D64E 8D   1D      BSR    ($D66D)        ;
D650 8D   22      BSR    ($D674)        ;
D652 20   15      BRA    ($D669)        ;
D654 81   01      CMPA   #$01           ;
D656 26   05      BNE    ($D65D)        ;
D658 5C           INCB                  ;
D659 8D   12      BSR    ($D66D)        ;
D65B 20   0A      BRA    ($D667)        ;
D65D 81   03      CMPA   #$03           ;
D65F 26   32      BNE    ($D693)        ;
D661 CB   02      ADDB   #$02           ;
D663 8D   08      BSR    ($D66D)        ;
D665 8D   1D      BSR    ($D684)        ;
D667 8D   1B      BSR    ($D684)        ;
D669 0A   B4      DEC    >$B4           ;
D66B 13           SYNC                  ;
D66C 39           RTS                   ;
D66D C4   03      ANDB   #$03           ;
D66F D7   23      STB    >$23           ;
D671 7E   C660    JMP    ($C660)        ;
D674 8D   20      BSR    ($D696)        ;
D676 26   0B      BNE    ($D683)        ;
D678 CC   0008    LDD    #$0008         ;
D67B 8D   3D      BSR    ($D6BA)        ;
D67D C3   0020    ADDD   #$0020         ;
D680 4D           TSTA                  ;
D681 27   F8      BEQ    ($D67B)        ;
D683 39           RTS                   ;
D684 8D   10      BSR    ($D696)        ;
D686 26   0A      BNE    ($D692)        ;
D688 CC   00F8    LDD    #$00F8         ;
D68B 8D   2D      BSR    ($D6BA)        ;
D68D 83   0020    SUBD   #$0020         ;
D690 2A   F9      BPL    ($D68B)        ;
D692 39           RTS                   ;
D693 7E   CBE1    JMP    ($CBE1)        ;
D696 DE   B2      LDU    >$B2           ;
D698 1183 CE66    CMPU   #$CE66         ;
D69C 26   1B      BNE    ($D6B9)        ;
D69E 8E   8080    LDX    #$8080         ;
D6A1 9F   4F      STX    >$4F           ;
D6A3 0F   8B      CLR    >$8B           ;
D6A5 3F   00      SWI    #$00           ;
D6A7 3F   08      SWI    #$08           ;
D6A9 8E   D6C6    LDX    #$D6C6         ;
D6AC 3F   01      SWI    #$01           ;
D6AE 8E   0011    LDX    #$0011         ;
D6B1 9F   2F      STX    >$2F           ;
D6B3 8E   0087    LDX    #$0087         ;
D6B6 9F   33      STX    >$33           ;
D6B8 4F           CLRA                  ;
D6B9 39           RTS                   ;
D6BA DD   31      STD    >$31           ;
D6BC DD   35      STD    >$35           ;
D6BE 8D   00      BSR    ($D6C0)        ;
D6C0 BD   CAB7    JSR    ($CAB7)        ;
D6C3 03   2C      COM    >$2C           ;
D6C5 39           RTS                   ;
D6C6 1000         ????                  ;
D6C8 10FF FF88    STS    ($FF88)        ;
D6CC 00   88      NEG    >$88           ;
D6CE FF           ????   >$88           ;
D6CF FE   8ED8    LDU    ($8ED8)        ;
D6D2 D9   BD      ADCB   >$BD           ;
D6D4 CB   EC      ADDB   #$EC           ;
D6D6 2D   BB      BLT    ($D693)        ;
D6D8 2E   09      BGT    ($D6E3)        ;
D6DA 0A   73      DEC    >$73           ;
D6DC 3F   0E      SWI    #$0E           ;
D6DE 5F           CLRB                  ;
D6DF 0F   73      CLR    >$73           ;
D6E1 20   0C      BRA    ($D6EF)        ;
D6E3 81   02      CMPA   #$02           ;
D6E5 26   0C      BNE    ($D6F3)        ;
D6E7 0A   74      DEC    >$74           ;
D6E9 3F   0E      SWI    #$0E           ;
D6EB C6   02      LDB    #$02           ;
D6ED 0F   74      CLR    >$74           ;
D6EF 8D   2F      BSR    ($D720)        ;
D6F1 20   1B      BRA    ($D70E)        ;
D6F3 81   01      CMPA   #$01           ;
D6F5 26   0A      BNE    ($D701)        ;
D6F7 C6   01      LDB    #$01           ;
D6F9 8D   25      BSR    ($D720)        ;
D6FB 26   11      BNE    ($D70E)        ;
D6FD 8D   85      BSR    ($D684)        ;
D6FF 20   0D      BRA    ($D70E)        ;
D701 81   00      CMPA   #$00           ;
D703 26   8E      BNE    ($D693)        ;
D705 C6   03      LDB    #$03           ;
D707 8D   17      BSR    ($D720)        ;
D709 26   03      BNE    ($D70E)        ;
D70B BD   D674    JSR    ($D674)        ;
D70E DC   15      LDD    >$15           ;
D710 BD   D37F    JSR    ($D37F)        ;
D713 C3   0003    ADDD   #$0003         ;
D716 D3   21      ADDD   >$21           ;
D718 DD   21      STD    >$21           ;
D71A 3F   0C      SWI    #$0C           ;
D71C 0A   B4      DEC    >$B4           ;
D71E 13           SYNC                  ;
D71F 39           RTS                   ;
D720 34   06      PSHS   #$06           ;
D722 6F   E2      CLR    ,-S            ;
D724 DB   23      ADDB   >$23           ;
D726 C4   03      ANDB   #$03           ;
D728 D7   8A      STB    >$8A           ;
D72A DC   13      LDD    >$13           ;
D72C BD   D136    JSR    ($D136)        ;
D72F 27   07      BEQ    ($D738)        ;
D731 3F   1B      SWI    #$1B           ;
D733 14           ????   #$1B           ;
D734 6A   E4      DEC    ,S             ;
D736 DC   13      LDD    >$13           ;
D738 DD   13      STD    >$13           ;
D73A BD   C660    JSR    ($C660)        ;
D73D 6D   E0      TST    ,S+            ;
D73F 35   86      PULS   #$86           ;
D741 BD   CC31    JSR    ($CC31)        ;
D744 27   21      BEQ    ($D767)        ;
D746 EC   09      LDD    9,X            ;
D748 C1   05      CMPB   #$05           ;
D74A 26   0B      BNE    ($D757)        ;
D74C 9F   24      STX    >$24           ;
D74E BD   D57D    JSR    ($D57D)        ;
D751 3F   1B      SWI    #$1B           ;
D753 113F         SWI3                  ;
D755 0E   39      JMP    >$39           ;
D757 1F   13      TFR    #$13           ;
D759 8E   D76B    LDX    #$D76B         ;
D75C A1   84      CMPA   ,X             ;
D75E 27   08      BEQ    ($D768)        ;
D760 30   03      LEAX   3,X            ;
D762 8C   D77A    CMPX   #$D77A         ;
D765 25   F5      BCS    ($D75C)        ;
D767 39           RTS                   ;
D768 6E   98 01   JMP    [$01,X]        ;
D76B 05           ????   [$01,X]        ;
D76C D7   7A      STB    >$7A           ;
D76E 09   D7      ROL    >$D7           ;
D770 83   08D7    SUBD   #$08D7         ;
D773 87           ????   #$08D7         ;
D774 04   D7      LSR    >$D7           ;
D776 A2   07      SBCA   7,X            ;
D778 D7   A0      STB    >$A0           ;
D77A CC   03E8    LDD    #$03E8         ;
D77D D3   17      ADDD   >$17           ;
D77F DD   17      STD    >$17           ;
D781 20   0F      BRA    ($D792)        ;
D783 4F           CLRA                  ;
D784 5F           CLRB                  ;
D785 20   09      BRA    ($D790)        ;
D787 9E   17      LDX    >$17           ;
D789 86   66      LDA    #$66           ;
D78B BD   D436    JSR    ($D436)        ;
D78E D3   21      ADDD   >$21           ;
D790 DD   21      STD    >$21           ;
D792 C6   17      LDB    #$17           ;
D794 E7   49      STB    9,U            ;
D796 6F   4B      CLR    11,U           ;
D798 3F   1B      SWI    #$1B           ;
D79A 0C   3F      INC    >$3F           ;
D79C 0D   3F      TST    >$3F           ;
D79E 0C   39      INC    >$39           ;
D7A0 4F           CLRA                  ;
D7A1 8C   86FF    CMPX   #$86FF         ;
D7A4 97   94      STA    >$94           ;
D7A6 6D   4B      TST    11,U           ;
D7A8 26   0C      BNE    ($D7B6)        ;
D7AA 3F   1B      SWI    #$1B           ;
D7AC 0E   0F      JMP    >$0F           ;
D7AE AD   8E      JSR    ?post byte?    ;
D7B0 CD           ????   ?post byte?    ;
D7B1 B2   9FB2    SBCA   ($9FB2)        ;
D7B4 3F   0E      SWI    #$0E           ;
D7B6 39           RTS                   ;
D7B7 8D   03      BSR    ($D7BC)        ;
D7B9 0A   B8      DEC    >$B8           ;
D7BB 39           RTS                   ;
D7BC 8E   0313    LDX    #$0313         ;
D7BF 33   88 20   LEAU   $20,X          ;
D7C2 3F   12      SWI    #$12           ;
D7C4 7E   CB96    JMP    ($CB96)        ;
D7C7 8D   F3      BSR    ($D7BC)        ;
D7C9 BF   007E    STX    ($007E)        ;
D7CC CC   000F    LDD    #$000F         ;
D7CF FD   007C    STD    ($007C)        ;
D7D2 0C   B8      INC    >$B8           ;
D7D4 39           RTS                   ;
;
;
; Data from here down
;
;
D7D5 0D   0F      TST    >$0F           ;
D7D7 10FF 110F    STS    ($110F)        ;
D7DB FF           ????   ($110F)        ;
D7DC D1   EB      CMPB   >$EB           ;
D7DE D1   C2      CMPB   >$C2           ;
D7E0 D1   D5      CMPB   >$D5           ;
D7E2 D1   9B      CMPB   >$9B           ;
D7E4 D0   27      SUBB   >$27           ;
D7E6 00   00      NEG    >$00           ;

D7E8 0C 01 03     ; Copy C bytes beginning at 103
D7EB 7E C371      ; SWI2 Vector
D7EE 7E C352      ; SWI  Vector
D7F1 7E C27D      ; @109
D7F4 7E C27D      ; @10A

D7F7 17 0202      LBSR   ($D7BC)        ;
D7FA 01           ????   ($D7BC)        ;
D7FB FF           ????   ($D7BC)        ;
D7FC FF           ????   ($D7BC)        ;
D7FD 00   80      NEG    >$80           ;
D7FF 00   4C      NEG    >$4C           ;
D801 D8   70      EORB   >$70           ;
D803 D8   76      EORB   >$76           ;
D805 D9   88      ADCB   >$88           ;
D807 0B           ????   >$88           ;
D808 15           ????   >$88           ;
D809 02           ????   >$88           ;
D80A F1   0C16    CMPB   ($0C16)        ;
D80D 00   23      NEG    >$23           ;
D80F 17   A054    LBSR   ($D7BC)        ;
D812 03   80      COM    >$80           ;
D814 1000         ????   >$80           ;
D816 02           ????   >$80           ;
D817 60   00      NEG    0,X            ;
D819 00   00      NEG    >$00           ;
D81B FF           ????   >$00           ;
D81C 23   00      BLS    ($D81E)        ;
D81E 00   40      NEG    >$40           ;
D820 00   00      NEG    >$00           ;
D822 FF           ????   >$00           ;
D823 00   24      NEG    >$24           ;
D825 00   00      NEG    >$00           ;
D827 80   00      SUBA   #$00           ;
D829 00   00      NEG    >$00           ;
D82B 00  

D82C 09090402
D830 00000000
D834 00000000
D838 02040006
D83C 06060000
D840 00000000
D844 00000004
D848 00060804
D84C 00000100	
D850 00000000
D854 00000806
D858 06040000	
D85C 02020202
D860 02020204
D864 04080001

D868 04   0B      LSR    >$0B           ;
D86A 1104         ????   >$0B           ;
D86C 00   00      NEG    >$00           ;
D86E 05           ????   >$00           ;
D86F 00   10      NEG    >$10           ;
D871 00   23      NEG    >$23           ;
D873 00   20      NEG    >$20           ;
D875 46           RORA                  ;
D876 28   00      BVC    ($D878)        ;
D878 3B           RTI                   ;
D879 00   20      NEG    >$20           ;
D87B A6   23      LDA    3,Y            ;
D87D 00   24      NEG    >$24           ;
D87F 00   00      NEG    >$00           ;
D881 00   3B      NEG    >$3B           ;
D883 00   3C      NEG    >$3C           ;
D885 00   00      NEG    >$00           ;
D887 00   24      NEG    >$24           ;
D889 00   28      NEG    >$28           ;
D88B 00   00      NEG    >$00           ;
D88D 00   3C      NEG    >$3C           ;
D88F 00   40      NEG    >$40           ;
D891 00   00      NEG    >$00           ;
D893 00   0F      NEG    >$0F           ;
D895 30   03      LEAX   3,X            ;
D897 4A           DECA                  ;
D898 04   6B      LSR    >$6B           ;
D89A 28   06      BVC    ($D8A2)        ;
D89C C4   B4      ANDB   #$B4           ;
D89E 40           NEGA                  ;
D89F 20   09      BRA    ($D8AA)        ;
D8A1 27   C0      BEQ    ($D863)        ;
D8A3 38           ????   ($D863)        ;
D8A4 0B           ????   ($D863)        ;
D8A5 80   B5      SUBA   #$B5           ;
D8A7 2E   28      BGT    ($D8D1)        ;
D8A9 18           ????   ($D8D1)        ;
D8AA 0E   5A      JMP    >$5A           ;
D8AC 00   30      NEG    >$30           ;
D8AE 12           NOP                   ;
D8AF E1   85      CMPB   B,X            ;
D8B1 D4   20      ANDB   >$20           ;
D8B3 18           ????   >$20           ;
D8B4 F7   AC20    STB    ($AC20)        ;
D8B7 1A   FB      ORCC   #$FB           ;
D8B9 14           ????   #$FB           ;
D8BA 20   21      BRA    ($D8DD)        ;
D8BC 56           RORB                  ;
D8BD 30   30      LEAX   -16,Y          ;
D8BF 24   5B      BCC    ($D91C)        ;
D8C1 14           ????   ($D91C)        ;
D8C2 2C   20      BGE    ($D8E4)        ;
D8C4 27   47      BEQ    ($D90D)        ;
D8C6 DC   20      LDD    >$20           ;
D8C8 29   59      BVS    ($D923)        ;
D8CA 38           ????   ($D923)        ;
D8CB 18           ????   ($D923)        ;
D8CC 2B   32      BMI    ($D900)        ;
D8CE 80   28      SUBA   #$28           ;
D8D0 34   C7      PSHS   #$C7           ;
D8D2 84   80      ANDA   #$80           ;
D8D4 28   35      BVC    ($D90B)        ;
D8D6 30   D8 A0   LEAX   [$A0,U]        ;
D8D9 06   20      ROR    >$20           ;
D8DB 18           ????   >$20           ;
D8DC 53           COMB                  ;
D8DD 50           NEGB                  ;
D8DE 28   24      BVC    ($D904)        ;
D8E0 93   A2      SUBD   >$A2           ;
D8E2 80   20      SUBA   #$20           ;
D8E4 04   11      LSR    >$11           ;
D8E6 AC   30      CMPX   -16,Y          ;
D8E8 03   27      COM    >$27           ;
D8EA D5   C4      BITB   >$C4           ;
D8EC 102B 0020    LBMI   ($D904)        ;
D8F0 08   FB      ASL    >$FB           ;
D8F2 B8   19                

;Proper names:
;00=Supreme, 01=Joule, 02=Elvish, 03=Mithril, 04=Rime, 05=Vision, 
;06=Abye, 07=Hale, 08=Thewes, 09=Bronze, 0A=Solar, 0B=Iron, 0C=Lunar,
;0D=Pine, 0E=Leather, 0F=Wooden, 10=Final, 11=Energy, 12=Ice, 13=Fire, 
;14=Gold, 15=Empty, 16=Dead

D8F4 38                    
D8F5 67   58              
D8F7 48                 
D8F8 AD   28             
D8FA 28   54            
D8FC FA   B0A0           
D8FF 31   0A              
D901 CB   26              
D903 68   38            
D905 DA   9A            
D907 22   49              
D909 60   20               
D90B A6   52             
D90D C8   28              
D90F 28   82            
D911 DE   60            
D913 20   64             
D915 96   94       
D917 30   AC 99     
D91A A5   EE       
D91C 20   02       
D91E 2C   94       
D920 20   10       ; 
D922 16   1429         
D925 66   F6           
D927 06   40            
D929 30   C5            
D92B 27   BB             
D92D 45                  
D92E 30   6D            
D930 56                  
D931 0C   2E            
D933 21   13               
D935 27   B8            
D937 29   59              
D939 57                    
D93A 06   40               
D93C 21   60              
D93E 97   14               
D940 38                     
D941 D8   50                 
D943 D1   05              
D945 90   31              
D947 2E   F7                  
D949 90   AE                
D94B 28   4C                
D94D 97   05               
D94F 80   30                
D951 4A                    
D952 E2   C8 F9             
D955 18                    
D956 52                    
D957 32   80              
D959 20   4C                
D95B 99   14              
D95D 20   4E              
D95F F6   1028              
D962 0A   D8                    
D964 53                          
D965 20   21                          
D967 48                              
D968 50                          
D969 90   06                       
  
;Class names: 00=Flask, 01=Ring, 02=Scroll, 03=Shield, 04=Sword, 05=Torch

D96B 28 0C C0 CD 
D96F 60 20 64 97 
D973 1C 30 A6 39 
D977 3D                          
D978 8C   30E6                        
D97B 84   95                   
D97D 84   29                      
D97F 27   77                       
D981 C8   80                         
D983 29   68                        
D985 F9   0D00                            

D988 01           ????   ($0D00)        ;
D989 D8   A3      EORB   >$A3           ;
D98B 03   D8      COM    >$D8           ;
D98D BA   D8DE    ORA    ($D8DE)        ;
D990 D9   83      ADCB   >$83           ;
D992 02           ????   >$83           ;
D993 D8   CB      EORB   >$CB           ;
D995 D8   DE      EORB   >$DE           ;
D997 01           ????   >$DE           ;
D998 D8   B2      EORB   >$B2           ;
D99A 01           ????   >$B2           ;
D99B D8   B6      EORB   >$B6           ;
D99D 03   D8      COM    >$D8           ;
D99F BA   D8DA    ORA    ($D8DA)        ;
D9A2 D9   79      ADCB   >$79           ;
D9A4 03   D8      COM    >$D8           ;
D9A6 BA   D8DE    ORA    ($D8DE)        ;
D9A9 D9   7E      ADCB   >$7E           ;
D9AB 01           ????   >$7E           ;
D9AC D8   B6      EORB   >$B6           ;
D9AE 01           ????   >$B6           ;
D9AF D8   B6      EORB   >$B6           ;
D9B1 02           ????   >$B6           ;
D9B2 D8   95      EORB   >$95           ;
D9B4 D8   DE      EORB   >$DE           ;
D9B6 02           ????   >$DE           ;
D9B7 D8   C7      EORB   >$C7           ;
D9B9 D8   DE      EORB   >$DE           ;
D9BB 01           ????   >$DE           ;
D9BC D8   B6      EORB   >$B6           ;
D9BE 01           ????   >$B6           ;
D9BF D8   B6      EORB   >$B6           ;
D9C1 01           ????   >$B6           ;
D9C2 D8   B6      EORB   >$B6           ;
D9C4 02           ????   >$B6           ;
D9C5 D8   C7      EORB   >$C7           ;
D9C7 D8   DE      EORB   >$DE           ;
D9C9 01           ????   >$DE           ;
D9CA D8   B6      EORB   >$B6           ;
D9CC 01           ????   >$B6           ;
D9CD D8   B6      EORB   >$B6           ;
D9CF FF           ????   >$B6           ;
D9D0 D2   B8      SBCB   >$B8           ;
D9D2 D4   4E      ANDB   >$4E           ;
D9D4 D5   50      BITB   >$50           ;
D9D6 D4   81      ANDB   >$81           ;
D9D8 D5   22      BITB   >$22           ;
D9DA D5   BC      BITB   >$BC           ;
D9DC C7           ????   >$BC           ;
D9DD 51           ????   >$BC           ;
; Pictures
D9DE D6   D0      LDB    >$D0           ;
D9E0 D5   89      BITB   >$89           ;
D9E2 D6   23      LDB    >$23           ;
D9E4 D5   79      BITB   >$79           ;
D9E6 D6   3F      LDB    >$3F           ;
D9E8 D7   41      STB    >$41           ;
D9EA D7   B7      STB    >$B7           ;
D9EC D7   C7      STB    >$C7           ;
D9EE DC   19      LDD    >$19           ;
D9F0 DC   21      LDD    >$21           ;
D9F2 DC   2A      LDD    >$2A           ;
D9F4 DB   FA      ADDB   >$FA           ;
D9F6 DC   0F      LDD    >$0F           ;
D9F8 DC   07      LDD    >$07           ;
D9FA 05           ????   >$07           ;
D9FB 01           ????   >$07           ;
D9FC 0A   19      DEC    >$19           ;
D9FE 19           DAA                   ;
D9FF 0A   01      DEC    >$01           ;
DA01 FF           ????   >$01           ;
DA02 00   05      NEG    >$05           ;
DA04 01           ????   >$05           ;
DA05 AA   00      ORA    0,X            ;
DA07 05           ????   0,X            ;
DA08 04   96      LSR    >$96           ;
DA0A 40           NEGA                  ;
DA0B 40           NEGA                  ;
DA0C 03   8C      COM    >$8C           ;
DA0E 0D   1A      TST    >$1A           ;
DA10 02           ????   >$1A           ;
DA11 82   00      SBCA   #$00           ;
DA13 05           ????   #$00           ;
DA14 00   46      NEG    >$46           ;
DA16 00   05      NEG    >$05           ;
DA18 01           ????   >$05           ;
DA19 34   00      PSHS   #$00           ;
DA1B 05           ????   #$00           ;
DA1C 02           ????   #$00           ;
DA1D 32   00      LEAS   0,X            ;
DA1F 05           ????   0,X            ;
DA20 00   30      NEG    >$30           ;
DA22 00   05      NEG    >$05           ;
DA24 00   28      NEG    >$28           ;
DA26 00   05      NEG    >$05           ;
DA28 05           ????   >$05           ;
DA29 46           RORA                  ;
DA2A 00   05      NEG    >$05           ;
DA2C 03   19      COM    >$19           ;
DA2E 00   1A      NEG    >$1A           ;
DA30 01           ????   >$1A           ;
DA31 0D   00      TST    >$00           ;
DA33 05           ????   >$00           ;
DA34 04   0D      LSR    >$0D           ;
DA36 00   28      NEG    >$28           ;
DA38 05           ????   >$28           ;
DA39 19           DAA                   ;
DA3A 00   05      NEG    >$05           ;
DA3C 05           ????   >$05           ;
DA3D 05           ????   >$05           ;
DA3E 00   05      NEG    >$05           ;
DA40 03   05      COM    >$05           ;
DA42 00   0A      NEG    >$0A           ;
DA44 04   05      LSR    >$05           ;
DA46 00   10      NEG    >$10           ;
DA48 01           ????   >$10           ;
DA49 00   00      NEG    >$00           ;
DA4B 00   01      NEG    >$01           ;
DA4D 00   FF      NEG    >$FF           ;
DA4F FF           ????   >$FF           ;
DA50 01           ????   >$FF           ;
DA51 00   FF      NEG    >$FF           ;
DA53 FF           ????   >$FF           ;
DA54 01           ????   >$FF           ;
DA55 00   FF      NEG    >$FF           ;
DA57 FF           ????   >$FF           ;
DA58 01           ????   >$FF           ;
DA59 00   00      NEG    >$00           ;
DA5B 05           ????   >$00           ;
DA5C 00   00      NEG    >$00           ;
DA5E 00   05      NEG    >$05           ;
DA60 05           ????   >$05           ;
DA61 05           ????   >$05           ;
DA62 00   05      NEG    >$05           ;
DA64 00   03      NEG    >$03           ;
DA66 12           NOP                   ;
DA67 00   01      NEG    >$01           ;
DA69 03   13      COM    >$13           ;
DA6B 00   03      NEG    >$03           ;
DA6D 40           NEGA                  ;
DA6E 40           NEGA                  ;
DA6F 00   06      NEG    >$06           ;
DA71 03   14      COM    >$14           ;
DA73 00   0A      NEG    >$0A           ;
DA75 3C   0D      CWAI   #$0D           ;
DA77 0B           ????   #$0D           ;
DA78 0B           ????   #$0D           ;
DA79 60   80      NEG    ,X+            ;
DA7B 00   0C      NEG    >$0C           ;
DA7D 03   15      COM    >$15           ;
DA7F 00   0E      NEG    >$0E           ;
DA81 1E   0A      EXG    #$0A           ;
DA83 04   0F      LSR    >$0F           ;
DA85 0F   07      CLR    >$07           ;
DA87 00   10      NEG    >$10           ;
DA89 6C   80      INC    ,X+            ;
DA8B 00   18      NEG    >$18           ;
DA8D 00   00      NEG    >$00           ;
DA8F 00   FF      NEG    >$FF           ;
DA91 41           ????   >$FF           ;
DA92 31   31      LEAY   -15,Y          ;
DA94 32   23      LEAS   3,Y            ;
DA96 23   11      BLS    ($DAA9)        ;
DA98 13           SYNC                  ;
DA99 16   1414    LBRA   ($DAA9)        ;
DA9C 16   0104    LBRA   ($DAA9)        ;
DA9F 08   08      ASL    >$08           ;
DAA1 03   04      COM    >$04           ;
; Creature Pictures
DAA3 DE   26      LDU    >$26           ;
DAA5 DF   CA      STU    >$CA           ;
DAA7 DD   41      STD    >$41           ;
DAA9 DE   59      LDU    >$59           ;
DAAB DE   82      LDU    >$82           ;
DAAD DD   51      STD    >$51           ;
DAAF DE   3F      LDU    >$3F           ;
DAB1 DE   9D      LDU    >$9D           ;
DAB3 DE   07      LDU    >$07           ;
DAB5 DD   A3      STD    >$A3           ;
DAB7 DF   65      STU    >$65           ;
DAB9 DF   10      STU    >$10           ;
DABB 00   20      NEG    >$20           ;
DABD 00   FF      NEG    >$FF           ;
DABF 80   FF      SUBA   #$FF           ;
DAC1 17   0B00    LBSR   ($DAA9)        ;
DAC4 38           ????   ($DAA9)        ;
DAC5 00   FF      NEG    >$FF           ;
DAC7 50           NEGB                  ;
DAC8 80   0F      SUBA   #$0F           ;
DACA 07   00      ASR    >$00           ;
DACC C8   00      EORB   #$00           ;
DACE FF           ????   #$00           ;
DACF 34   C0      PSHS   #$C0           ;
DAD1 1D           SEX                   ;
DAD2 17   0130    LBSR   ($DAA9)        ;
DAD5 00   FF      NEG    >$FF           ;
DAD7 60   A7      NEG    ?post byte?    ;
DAD9 1F   1F      TFR    #$1F           ;
DADB 01           ????   #$1F           ;
DADC F8   0080    EORB   ($0080)        ;
DADF 60   3C      NEG    -4,Y           ;
DAE1 0D   07      TST    >$07           ;
DAE3 02           ????   >$07           ;
DAE4 C0   00      SUBB   #$00           ;
DAE6 80   80      SUBA   #$80           ;
DAE8 30   11      LEAX   -15,X          ;
DAEA 0D   01      TST    >$01           ;
DAEC 90   FF      SUBA   >$FF           ;
DAEE 80   FF      SUBA   #$FF           ;
DAF0 80   05      SUBA   #$05           ;
DAF2 04   03      LSR    >$03           ;
DAF4 20   00      BRA    ($DAF6)        ;
DAF6 40           NEGA                  ;
DAF7 FF           ????                  ;
DAF8 08   0D      ASL    >$0D           ;
DAFA 07   03      ASR    >$03           ;
DAFC 20   C0      BRA    ($DABE)        ;
DAFE 10C0         ????   ($DABE)        ;
DB00 08   03      ASL    >$03           ;
DB02 03   03      COM    >$03           ;
DB04 E8   FF 05FF EORB   [$05FF]        ;
DB08 03   04      COM    >$04           ;
DB0A 03   03      COM    >$03           ;
DB0C E8   FF 06FF EORB   [$06FF]        ;
DB10 00   0D      NEG    >$0D           ;
DB12 07   1F      ASR    >$1F           ;
DB14 40           NEGA                  ;
DB15 FF           ????                  ;
DB16 06   FF      ROR    >$FF           ;
DB18 00   0D      NEG    >$0D           ;
DB1A 07   30      ASR    >$30           ;
DB1C 00   00      NEG    >$00           ;
DB1E 00   00      NEG    >$00           ;
DB20 31   15      LEAY   -11,X          ;
DB22 18           ????   -11,X          ;
DB23 FE   3137    LDU    ($3137)        ;
DB26 A3   1F      SUBD   -1,X           ;
DB28 46           RORA                  ;
DB29 3E           ????                  ;
DB2A 33   A3      LEAU   ,--Y           ;
DB2C 08   42      ASL    >$42           ;
DB2E 2E   37      BGT    ($DB67)        ;
DB30 A3   18      SUBD   -8,X           ;
DB32 C6   3E      LDB    #$3E           ;
DB34 37   E1      PULU   #$E1           ;
DB36 0F   42      CLR    >$42           ;
DB38 1F   37      TFR    #$37           ;
DB3A E1   0F      CMPB   15,X           ;
DB3C 42           ????   15,X           ;
DB3D 1033         ????   15,X           ;
DB3F E3   08      ADDD   8,X            ;
DB41 4E           ????   8,X            ;
DB42 2F   34      BLE    ($DB78)        ;
DB44 63   1F      COM    -1,X           ;
DB46 C6   31      LDB    #$31           ;
DB48 33   88 42   LEAU   $42,X          ;
DB4B 108E 3042    LDY    #$3042         ;
DB4F 1086         ????   #$3042         ;
DB51 2E   34      BGT    ($DB87)        ;
DB53 65           ????   ($DB87)        ;
DB54 4C           INCA                  ;
DB55 52           ????                  ;
DB56 51           ????                  ;
DB57 34   21      PSHS   #$21           ;
DB59 08   42      ASL    >$42           ;
DB5B 1F   34      TFR    #$34           ;
DB5D 77   5AD6    ASR    ($5AD6)        ;
DB60 31   34      LEAY   -12,Y          ;
DB62 63   9A      COM    ?post byte?    ;
DB64 CE   3133    LDU    #$3133         ;
DB67 A3   18      SUBD   -8,X           ;
DB69 C6   2E      LDB    #$2E           ;
DB6B 37   A3      PULU   #$A3           ;
DB6D 1F   42      TFR    #$42           ;
DB6F 1033         ????   #$42           ;
DB71 A3   18      SUBD   -8,X           ;
DB73 D6   4D      LDB    >$4D           ;
DB75 37   A3      PULU   #$A3           ;
DB77 1F   52      TFR    #$52           ;
DB79 51           ????   #$52           ;
DB7A 33   A3      LEAU   ,--Y           ;
DB7C 07   06      ASR    >$06           ;
DB7E 2E   37      BGT    ($DBB7)        ;
DB80 EA   42      ORB    2,U            ;
DB82 1084         ????   2,U            ;
DB84 34   63      PSHS   #$63           ;
DB86 18           ????   #$63           ;
DB87 C6   2E      LDB    #$2E           ;
DB89 34   63      PSHS   #$63           ;
DB8B 15           ????   #$63           ;
DB8C 28   84      BVC    ($DB12)        ;
DB8E 34   63      PSHS   #$63           ;
DB90 1A   D7      ORCC   #$D7           ;
DB92 71           ????   #$D7           ;
DB93 34   62      PSHS   #$62           ;
DB95 A2   2A      SBCA   10,Y           ;
DB97 31   34      LEAY   -12,Y          ;
DB99 62           ????   -12,Y          ;
DB9A A2   10      SBCA   -16,X          ;
DB9C 84   37      ANDA   #$37           ;
DB9E C2   22      SBCB   #$22           ;
DBA0 22   1F      BHI    ($DBC1)        ;
DBA2 31   08      LEAY   8,X            ;
DBA4 42           ????   8,X            ;
DBA5 1004         ????   8,X            ;
DBA7 30   00      LEAX   0,X            ;
DBA9 00   00      NEG    >$00           ;
DBAB 1F   33      TFR    #$33           ;
DBAD A2   13      SBCA   -13,X          ;
DBAF 1004         ????   -13,X          ;
DBB1 30   00      LEAX   0,X            ;
DBB3 00   00      NEG    >$00           ;
DBB5 04   00      LSR    >$00           ;
DBB7 00   01      NEG    >$01           ;
DBB9 01           ????   >$01           ;
DBBA 00   00      NEG    >$00           ;
DBBC 00   00      NEG    >$00           ;
DBBE A0   F0      SUBA   ?post byte?    ;
DBC0 F0   E040    SUBB   ($E040)        ;
DBC3 00   00      NEG    >$00           ;
DBC5 01           ????   >$00           ;
DBC6 03   03      COM    >$03           ;
DBC8 01           ????   >$03           ;
DBC9 00   00      NEG    >$00           ;
DBCB 00   B0      NEG    >$B0           ;
DBCD F8   F8F0    EORB   ($F8F0)        ;
DBD0 E0   40      SUBB   0,U            ;
DBD2 00   80      NEG    >$80           ;
DBD4 00   01      NEG    >$01           ;
DBD6 00   50      NEG    >$50           ;
DBD8 00   04      NEG    >$04           ;
DBDA 00   50      NEG    >$50           ;
DBDC 00   05      NEG    >$05           ;
DBDE 03   DC      COM    >$DC           ;
DBE0 4F           CLRA                  ;
DBE1 DC   6B      LDD    >$6B           ;
DBE3 DC   9B      LDD    >$9B           ;
DBE5 DC   33      LDD    >$33           ;
DBE7 00   DC      NEG    >$DC           ;
DBE9 6A   DC 8B   DEC    [$DB77,PCR]    ;
DBEC DC   A9      LDD    >$A9           ;
DBEE DC   45      LDD    >$45           ;
DBF0 01           ????   >$45           ;
DBF1 DC   5D      LDD    >$5D           ;
DBF3 DC   7B      LDD    >$7B           ;
DBF5 DC   A2      LDD    >$A2           ;
DBF7 DC   3C      LDD    >$3C           ;
DBF9 FF           ????   >$3C           ;
DBFA 86   AC      LDA    #$AC           ;
DBFC 80   C0      SUBA   #$C0           ;
DBFE 7A   BA80    DEC    ($BA80)        ;
DC01 A8   FC 3E   EORA   [$DC42,PCR]    ;
DC04 04   00      LSR    >$00           ;
DC06 FE   763C    LDU    ($763C)        ;
DC09 FC   F7FF    LDD    ($F7FF)        ;
DC0C 2A   00      BPL    ($DC0E)        ;
DC0E FE   7250    LDU    ($7250)        ;
DC11 7C   64FF    INC    ($64FF)        ;
DC14 76   5272    ROR    ($5272)        ;
DC17 56           RORB                  ;
DC18 FE   6EA2    LDU    ($6EA2)        ;
DC1B FC   510E    LDD    ($510E)        ;
DC1E B1   00FE    CMPA   ($00FE)        ;
DC21 7A   3CFC    DEC    ($3CFC)        ;
DC24 111F         ????   ($3CFC)        ;
DC26 FF           ????   ($3CFC)        ;
DC27 F1   00FE    CMPB   ($00FE)        ;
DC2A 76   C2FC    ROR    ($C2FC)        ;
DC2D 1F   34      TFR    #$34           ;
DC2F F1   DC00    CMPB   ($DC00)        ;
DC32 FE   101B    LDU    ($101B)        ;
DC35 26   40      BNE    ($DC77)        ;
DC37 72           ????   ($DC77)        ;
DC38 40           NEGA                  ;
DC39 88   1B      EORA   #$1B           ;
DC3B FE   10E5    LDU    ($10E5)        ;
DC3E 26   C0      BNE    ($DC00)        ;
DC40 72           ????   ($DC00)        ;
DC41 C0   88      SUBB   #$88           ;
DC43 E5   FE      BITB   ?post byte?    ;
DC45 26   40      BNE    ($DC87)        ;
DC47 26   C0      BNE    ($DC09)        ;
DC49 FF           ????   ($DC09)        ;
DC4A 72           ????   ($DC09)        ;
DC4B 40           NEGA                  ;
DC4C 72           ????                  ;
DC4D C0   FE      SUBB   #$FE           ;
DC4F 26   1D      BNE    ($DC6E)        ;
DC51 26   40      BNE    ($DC93)        ;
DC53 72           ????   ($DC93)        ;
DC54 40           NEGA                  ;
DC55 72           ????                  ;
DC56 1B           ????                  ;
DC57 FF           ????                  ;
DC58 101B         ????                  ;
DC5A 26   40      BNE    ($DC9C)        ;
DC5C FE   26E5    LDU    ($26E5)        ;
DC5F 26   C0      BNE    ($DC21)        ;
DC61 72           ????   ($DC21)        ;
DC62 C0   72      SUBB   #$72           ;
DC64 E5   FF 10E5 BITB   [$10E5]        ;
DC68 26   C0      BNE    ($DC2A)        ;
DC6A FE   8028    LDU    ($8028)        ;
DC6D 41           ????   ($8028)        ;
DC6E 28   44      BVC    ($DCB4)        ;
DC70 38           ????   ($DCB4)        ;
DC71 77   38FF    ASR    ($38FF)        ;
DC74 5C           INCB                  ;
DC75 30   5D      LEAX   -3,U           ;
DC77 34   FD      PSHS   #$FD           ;
DC79 DC   33      LDD    >$33           ;
DC7B 80   D8      SUBA   #$D8           ;
DC7D 41           ????   #$D8           ;
DC7E D8   44      EORB   >$44           ;
DC80 C8   77      EORB   #$77           ;
DC82 C8   FF      EORB   #$FF           ;
DC84 5C           INCB                  ;
DC85 D0   5D      SUBB   >$5D           ;
DC87 CC   FDDC    LDD    #$FDDC         ;
DC8A 3C   72      CWAI   #$72           ;
DC8C 6C   43      INC    3,U            ;
DC8E 6C   43      INC    3,U            ;
DC90 94   72      ANDA   >$72           ;
DC92 94   FF      ANDA   >$FF           ;
DC94 5E           ????   >$FF           ;
DC95 7E   5E82    JMP    ($5E82)        ;
DC98 FD   DC45    STD    ($DC45)        ;
DC9B 80   28      SUBA   #$28           ;
DC9D 42           ????   #$28           ;
DC9E 32   75      LEAS   -11,S          ;
DCA0 3A           ABX                   ;
DCA1 FE   80D8    LDU    ($80D8)        ;
DCA4 42           ????   ($80D8)        ;
DCA5 CE   75C6    LDU    #$75C6         ;
DCA8 FE   716C    LDU    ($716C)        ;
DCAB 43           COMA                  ;
DCAC 80   72      SUBA   #$72           ;
DCAE 94   FE      ANDA   >$FE           ;
DCB0 64   1C      LSR    -4,X           ;
DCB2 FC   442E    LDD    ($442E)        ;
DCB5 42           ????   ($442E)        ;
DCB6 4C           INCA                  ;
DCB7 00   FE      NEG    >$FE           ;
DCB9 64   E4      LSR    ,S             ;
DCBB FC   4C22    LDD    ($4C22)        ;
DCBE 4E           ????   ($4C22)        ;
DCBF 44           LSRA                  ;
DCC0 00   FE      NEG    >$FE           ;
DCC2 DD   0E      STD    >$0E           ;
DCC4 DC   CA      LDD    >$CA           ;
DCC6 DD   2A      STD    >$2A           ;
DCC8 DC   D0      LDD    >$D0           ;
DCCA FB   DCD6    ADDB   ($DCD6)        ;
DCCD FD   DD0E    STD    ($DD0E)        ;
DCD0 FB   DCD6    ADDB   ($DCD6)        ;
DCD3 FD   DD2A    STD    ($DD2A)        ;
DCD6 18           ????   ($DD2A)        ;
DCD7 74   8074    LSR    ($8074)        ;
DCDA FF           ????   ($8074)        ;
DCDB 18           ????   ($8074)        ;
DCDC 8C   808C    CMPX   #$808C         ;
DCDF FF           ????   #$808C         ;
DCE0 1C   74      ANDCC  #$74           ;
DCE2 1C   8C      ANDCC  #$8C           ;
DCE4 FF           ????   #$8C           ;
DCE5 28   74      BVC    ($DD5B)        ;
DCE7 28   8C      BVC    ($DC75)        ;
DCE9 FF           ????   ($DC75)        ;
DCEA 34   74      PSHS   #$74           ;
DCEC 34   8C      PSHS   #$8C           ;
DCEE FF           ????   #$8C           ;
DCEF 40           NEGA                  ;
DCF0 74   408C    LSR    ($408C)        ;
DCF3 FF           ????   ($408C)        ;
DCF4 4C           INCA                  ;
DCF5 74   4C8C    LSR    ($4C8C)        ;
DCF8 FF           ????   ($4C8C)        ;
DCF9 58           ASLB                  ;
DCFA 74   588C    LSR    ($588C)        ;
DCFD FF           ????   ($588C)        ;
DCFE 64   74      LSR    -12,S          ;
DD00 64   8C FF   LSR    $DD02,PCR      ;
DD03 70   7470    NEG    ($7470)        ;
DD06 8C   FF7B    CMPX   #$FF7B         ;
DD09 74   7B8C    LSR    ($7B8C)        ;
DD0C FF           ????   ($7B8C)        ;
DD0D FA   2264    ORB    ($2264)        ;
DD10 18           ????   ($2264)        ;
DD11 5C           INCB                  ;
DD12 18           ????                  ;
DD13 A4   22      ANDA   2,Y            ;
DD15 9C   22      CMPX   >$22           ;
DD17 64   18      LSR    -8,X           ;
DD19 64   FF 229C LSR    [$229C]        ;
DD1D 18           ????   [$229C]        ;
DD1E 9C   FF      CMPX   >$FF           ;
DD20 1C   2F      ANDCC  #$2F           ;
DD22 1C   60      ANDCC  #$60           ;
DD24 FF           ????   #$60           ;
DD25 1C   A1      ANDCC  #$A1           ;
DD27 1C   D2      ANDCC  #$D2           ;
DD29 FE   7664    LDU    ($7664)        ;
DD2C 80   5C      SUBA   #$5C           ;
DD2E 80   A4      SUBA   #$A4           ;
DD30 76   9C76    ROR    ($9C76)        ;
DD33 64   80      LSR    ,X+            ;
DD35 64   FF 769C LSR    [$769C]        ;
DD39 80   9C      SUBA   #$9C           ;
DD3B FF           ????   #$9C           ;
DD3C 1C   2F      ANDCC  #$2F           ;
DD3E 1C   D2      ANDCC  #$D2           ;
DD40 FE   6862    LDU    ($6862)        ;
DD43 FC   D7D4    LDD    ($D7D4)        ;
DD46 14           ????   ($D7D4)        ;
DD47 12           NOP                   ;
DD48 30   1D      LEAX   -3,X           ;
DD4A 0D   FD      TST    >$FD           ;
DD4C 29   00      BVS    ($DD4E)        ;
DD4E FD   DD62    STD    ($DD62)        ;
DD51 68   62      ASL    2,S            ;
DD53 5E           ????   2,S            ;
DD54 7C   607E    INC    ($607E)        ;
DD57 6A   64      DEC    4,S            ;
DD59 FF           ????   4,S            ;
DD5A 66   84      ROR    ,X             ;
DD5C 5C           INCB                  ;
DD5D 72           ????                  ;
DD5E 66   76      ROR    -10,S          ;
DD60 6E   72      JMP    -14,S          ;
DD62 66   84      ROR    ,X             ;
DD64 FC   0256    LDD    ($0256)        ;
DD67 56           RORB                  ;
DD68 17   EE02    LBSR   ($DD4E)        ;
DD6B EA   BB      ORB    [D,Y]          ;
DD6D BB   EAEA    ADDA   ($EAEA)        ;
DD70 00   4E      NEG    >$4E           ;
DD72 5C           INCB                  ;
DD73 FC   C251    LDD    ($C251)        ;
DD76 3E           ????   ($C251)        ;
DD77 CF           ????   ($C251)        ;
DD78 FC   4213    LDD    ($4213)        ;
DD7B 00   6A      NEG    >$6A           ;
DD7D 5A           DECB                  ;
DD7E FC   1E11    LDD    ($1E11)        ;
DD81 F3   6239    ADDD   ($6239)        ;
DD84 E2   0C      SBCB   12,X           ;
DD86 E4   8A      ANDB   ?post byte?    ;
DD88 E2   00      SBCB   0,X            ;
DD8A 56           RORB                  ;
DD8B 54           LSRB                  ;
DD8C FC   5465    LDD    ($5465)        ;
DD8F 2E   CA      BGT    ($DD5B)        ;
DD91 BA   A1D4    ORA    ($A1D4)        ;
DD94 EE   12      LDU    -14,X          ;
DD96 D2   13      SBCB   >$13           ;
DD98 E1   20      CMPB   0,Y            ;
DD9A F6   2472    LDB    ($2472)        ;
DD9D 58           ASLB                  ;
DD9E EE   C5      LDU    B,U            ;
DDA0 BE   00FE    LDX    ($00FE)        ;
DDA3 50           NEGB                  ;
DDA4 7C   5E72    INC    ($5E72)        ;
DDA7 6E   78      JMP    -8,S           ;
DDA9 84   70      ANDA   #$70           ;
DDAB 68   4E      ASL    14,U           ;
DDAD 84   30      ANDA   #$30           ;
DDAF 44           LSRA                  ;
DDB0 48           ASLA                  ;
DDB1 54           LSRB                  ;
DDB2 20   16      BRA    ($DDCA)        ;
DDB4 58           ASLB                  ;
DDB5 34   72      PSHS   #$72           ;
DDB7 5C           INCB                  ;
DDB8 80   34      SUBA   #$34           ;
DDBA 8E   16A8    LDX    #$16A8         ;
DDBD 58           ASLB                  ;
DDBE E0   44      SUBB   4,U            ;
DDC0 B8   84D0    EORA   ($84D0)        ;
DDC3 70   B284    NEG    ($B284)        ;
DDC6 90   6E      SUBA   >$6E           ;
DDC8 88   5E      EORA   #$5E           ;
DDCA 8E   5084    LDX    #$5084         ;
DDCD FF           ????   #$5084         ;
DDCE 84   70      ANDA   #$70           ;
DDD0 FC   C592    LDD    ($C592)        ;
DDD3 BE   C343    LDX    ($C343)        ;
DDD6 5E           ????   ($C343)        ;
DDD7 72           ????   ($C343)        ;
DDD8 45           ????   ($C343)        ;
DDD9 00   52      NEG    >$52           ;
DDDB 7A   FC78    DEC    ($FC78)        ;
DDDE E9   8D EC33 ADCB   $CA15,PCR      ;
DDE2 0C   24      INC    >$24           ;
DDE4 72           ????   >$24           ;
DDE5 47           ASRA                  ;
DDE6 E7   00      STB    0,X            ;
DDE8 16   A8FC    LBRA   ($CA15)        ;
DDEB 2D   C2      BLT    ($DDAF)        ;
DDED 3D           MUL                   ;
DDEE 30   4B      LEAX   11,U           ;
DDF0 4B           ????   11,U           ;
DDF1 ED   B2      STD    ?post byte?    ;
DDF3 9D   71      JSR    >$71           ;
DDF5 3D           MUL                   ;
DDF6 DD   91      STD    >$91           ;
DDF8 7D   5263    TST    ($5263)        ;
DDFB A3   2D      SUBD   13,Y           ;
DDFD ED   2D      STD    13,Y           ;
DDFF CB   CB      ADDB   #$CB           ;
DE01 D0   DD      SUBB   >$DD           ;
DE03 42           ????   >$DD           ;
DE04 ED   00      STD    0,X            ;
DE06 FE   3E44    LDU    ($3E44)        ;
DE09 44           LSRA                  ;
DE0A 58           ASLB                  ;
DE0B 38           ????                  ;
DE0C 64   FF 4A5A LSR    [$4A5A]        ;
DE10 46           RORA                  ;
DE11 4A           DECA                  ;
DE12 FC   33F5    LDD    ($33F5)        ;
DE15 F5   C15A    BITB   ($C15A)        ;
DE18 62           ????   ($C15A)        ;
DE19 0E   00      JMP    >$00           ;
DE1B 64   50      LSR    -16,U          ;
DE1D FC   B317    LDD    ($B317)        ;
DE20 34   EB      PSHS   #$EB           ;
DE22 0A   3D      DEC    >$3D           ;
DE24 00   FE      NEG    >$FE           ;
DE26 7C   A0FC    INC    ($A0FC)        ;
DE29 C2   22      SBCB   #$22           ;
DE2B E4   24      ANDB   4,Y            ;
DE2D 2C   EC      BGE    ($DE1B)        ;
DE2F 04   04      LSR    >$04           ;
DE31 E2   42      SBCB   2,U            ;
DE33 00   7C      NEG    >$7C           ;
DE35 A8   FC C1   EORA   [$DDF9,PCR]    ;
DE38 21   12      BRN    ($DE4C)        ;
DE3A F2   E141    SBCB   ($E141)        ;
DE3D 00   FE      NEG    >$FE           ;
DE3F 70   4AFC    NEG    ($4AFC)        ;
DE42 E0   EE      SUBB   ?post byte?    ;
DE44 2C   42      BGE    ($DE88)        ;
DE46 14           ????   ($DE88)        ;
DE47 14           ????   ($DE88)        ;
DE48 20   0C      BRA    ($DE56)        ;
DE4A CC   220C    LDD    #$220C         ;
DE4D 22   00      BHI    ($DE4F)        ;
DE4F 7C   5AFC    INC    ($5AFC)        ;
DE52 E0   0C      SUBB   12,X           ;
DE54 2C   20      BGE    ($DE76)        ;
DE56 04   00      LSR    >$00           ;
DE58 FE   5282    LDU    ($5282)        ;
DE5B FC   287D    LDD    ($287D)        ;
DE5E 5F           CLRB                  ;
DE5F 50           NEGB                  ;
DE60 5B           ????                  ;
DE61 F5   2FD5    BITB   ($2FD5)        ;
DE64 17   17F3    LBSR   ($DE76)        ;
DE67 22   E1      BHI    ($DE4A)        ;
DE69 14           ????   ($DE4A)        ;
DE6A DD   8F      STD    >$8F           ;
DE6C 8D   DB      BSR    ($DE49)        ;
DE6E EC   00      LDD    0,X            ;
DE70 56           RORB                  ;
DE71 82   FC      SBCA   #$FC           ;
DE73 33   31      LEAU   -15,Y          ;
DE75 1B           ????   -15,Y          ;
DE76 91   3B      CMPA   >$3B           ;
DE78 5F           CLRB                  ;
DE79 F5   006C    BITB   ($006C)        ;
DE7C 74   7276    LSR    ($7276)        ;
DE7F 78   90FE    ASL    ($90FE)        ;
DE82 22   7C      BHI    ($DF00)        ;
DE84 FC   041F    LDD    ($041F)        ;
DE87 0E   FF      JMP    >$FF           ;
DE89 00   50      NEG    >$50           ;
DE8B 8E   4088    LDX    #$4088         ;
DE8E 2E   92      BGT    ($DE22)        ;
DE90 40           NEGA                  ;
DE91 9C   52      CMPX   >$52           ;
DE93 8C   4C88    CMPX   #$4C88         ;
DE96 40           NEGA                  ;
DE97 92   3A      SBCA   >$3A           ;
DE99 8C   FDDE    CMPX   #$FDDE         ;
DE9C B3   1E7E    SUBD   ($1E7E)        ;
DE9F FC   500F    LDD    ($500F)        ;
DEA2 E0   00      SUBB   0,X            ;
DEA4 2C   96      BGE    ($DE3C)        ;
DEA6 34   A6      PSHS   #$A6           ;
DEA8 4C           INCA                  ;
DEA9 A4   5C      ANDA   -4,U           ;
DEAB 96   4C      LDA    >$4C           ;
DEAD 88   34      EORA   #$34           ;
DEAF 86   2C      LDA    #$2C           ;
DEB1 96   FF      LDA    >$FF           ;
DEB3 50           NEGB                  ;
DEB4 8C   8098    CMPX   #$8098         ;
DEB7 84   A0      ANDA   #$A0           ;
DEB9 84   90      ANDA   #$90           ;
DEBB 7E   9054    JMP    ($9054)        ;
DEBE 82   FF      SBCA   #$FF           ;
DEC0 54           LSRB                  ;
DEC1 7E   7E6E    JMP    ($7E6E)        ;
DEC4 84   6E      ANDA   #$6E           ;
DEC6 84   5C      ANDA   #$5C           ;
DEC8 80   66      SUBA   #$66           ;
DECA 50           NEGB                  ;
DECB 74   FF50    LSR    ($FF50)        ;
DECE 8C   FC3A    CMPX   #$FC3A         ;
DED1 D9   83      ADCB   >$83           ;
DED3 DE   AD      LDU    >$AD           ;
DED5 E6   A1      LDB    ,Y++           ;
DED7 E2   22      SBCB   2,Y            ;
DED9 61           ????   2,Y            ;
DEDA 26   EA      BNE    ($DEC6)        ;
DEDC 20   3D      BRA    ($DF1B)        ;
DEDE DD   E0      STD    >$E0           ;
DEE0 00   34      NEG    >$34           ;
DEE2 80   14      SUBA   #$14           ;
DEE4 80   FC      SUBA   #$FC           ;
DEE6 0E   21      JMP    >$21           ;
DEE8 02           ????   >$21           ;
DEE9 E1   0E      CMPB   14,X           ;
DEEB 00   4A      NEG    >$4A           ;
DEED 66   FC E0   ROR    [$DED0,PCR]    ;
DEF0 02           ????   [$DED0,PCR]    ;
DEF1 D0   08      SUBB   >$08           ;
DEF3 30   02      LEAX   2,X            ;
DEF5 20   01      BRA    ($DEF8)        ;
DEF7 30   02      LEAX   2,X            ;
DEF9 D0   01      SUBB   >$01           ;
DEFB 87           ????   >$01           ;
DEFC 00   2E      NEG    >$2E           ;
DEFE 6E   40      JMP    0,U            ;
DF00 66   40      ROR    0,U            ;
DF02 64   1E      LSR    -2,X           ;
DF04 66   14      ROR    -12,X          ;
DF06 62           ????   -12,X          ;
DF07 1E   5E      EXG    #$5E           ;
DF09 40           NEGA                  ;
DF0A 60   40      NEG    0,U            ;
DF0C 62           ????   0,U            ;
DF0D 14           ????   0,U            ;
DF0E 62           ????   0,U            ;
DF0F FE   2E62    LDU    ($2E62)        ;
DF12 FC   212F    LDD    ($212F)        ;
DF15 2D   FD      BLT    ($DF14)        ;
DF17 CE   C2F2    LDU    #$C2F2         ;
DF1A 12           NOP                   ;
DF1B 0F   1E      CLR    >$1E           ;
DF1D 3F   21      SWI    #$21           ;
DF1F 12           NOP                   ;
DF20 E3   E0      ADDD   ,S+            ;
DF22 00   68      NEG    >$68           ;
DF24 9A   FC      ORA    >$FC           ;
DF26 21   2F      BRN    ($DF57)        ;
DF28 2D   FD      BLT    ($DF27)        ;
DF2A CE   C2F2    LDU    #$C2F2         ;
DF2D 12           NOP                   ;
DF2E 0F   1E      CLR    >$1E           ;
DF30 3F   22      SWI    #$22           ;
DF32 12           NOP                   ;
DF33 E2   E0      SBCB   ,S+            ;
DF35 00   FD      NEG    >$FD           ;
DF37 DF   65      STU    >$65           ;
DF39 28   56      BVC    ($DF91)        ;
DF3B 40           NEGA                  ;
DF3C 5C           INCB                  ;
DF3D 2A   64      BPL    ($DFA3)        ;
DF3F 36   52      PSHU   #$52           ;
DF41 38           ????   #$52           ;
DF42 68   28      ASL    8,Y            ;
DF44 56           RORB                  ;
DF45 FF           ????                  ;
DF46 42           ????                  ;
DF47 8C   FC70    CMPX   #$FC70         ;
DF4A AD   35      JSR    -11,Y          ;
DF4C 1B           ????   -11,Y          ;
DF4D B3   0060    SUBD   ($0060)        ;
DF50 92   78      SBCA   >$78           ;
DF52 94   64      ANDA   >$64           ;
DF54 88   6A      EORA   #$6A           ;
DF56 9A   74      ORA    >$74           ;
DF58 8A   60      ORA    #$60           ;
DF5A 92   FF      SBCA   >$FF           ;
DF5C 50           NEGB                  ;
DF5D 74   FC53    LSR    ($FC53)        ;
DF60 EC   E4      LDD    ,S             ;
DF62 4D           TSTA                  ;
DF63 B0   0040    SUBA   ($0040)        ;
DF66 7C   FC4E    INC    ($FC4E)        ;
DF69 C0   7B      SUBB   #$7B           ;
DF6B 9C   D4      CMPX   >$D4           ;
DF6D E4   E1      ANDB   ,S++           ;
DF6F E1   DD 1C96 CMPB   [$FC09,PCR]    ;
DF73 03   00      COM    >$00           ;
DF75 1C   82      ANDCC  #$82           ;
DF77 FC   0345    LDD    ($0345)        ;
DF7A 71           ????   ($0345)        ;
DF7B DA   1E      ORB    >$1E           ;
DF7D 11E1         ????   >$1E           ;
DF7F 00   30      NEG    >$30           ;
DF81 86   36      LDA    #$36           ;
DF83 8E   74A4    LDX    #$74A4         ;
DF86 84   84      ANDA   #$84           ;
DF88 82   76      SBCA   #$76           ;
DF8A 78   5E5A    ASL    ($5E5A)        ;
DF8D 6E   84      JMP    ,X             ;
DF8F 84   48      ANDA   #$48           ;
DF91 6A   FF 4066 DEC    [$4066]        ;
DF95 FC   1FBD    LDD    ($1FBD)        ;
DF98 F1   5300    CMPB   ($5300)        ;
DF9B 42           ????   ($5300)        ;
DF9C 66   FC 1E   ROR    [$DFBD,PCR]    ;
DF9F 32   11      LEAS   -15,X          ;
DFA1 73   0058    COM    ($0058)        ;
DFA4 70   4878    NEG    ($4878)        ;
DFA7 FF           ????   ($4878)        ;
DFA8 3E           ????   ($4878)        ;
DFA9 84   14      ANDA   #$14           ;
DFAB 80   34      SUBA   #$34           ;
DFAD 7A   407A    DEC    ($407A)        ;
DFB0 3C   7C      CWAI   #$7C           ;
DFB2 72           ????   #$7C           ;
DFB3 80   50      SUBA   #$50           ;
DFB5 82   44      SBCA   #$44           ;
DFB7 82   3E      SBCA   #$3E           ;
DFB9 84   FF      ANDA   #$FF           ;
DFBB 28   82      BVC    ($DF3F)        ;
DFBD FC   FF1E    LDD    ($FF1E)        ;
DFC0 11F2         ????   ($FF1E)        ;
DFC2 3F   20      SWI    #$20           ;
DFC4 0F   C0      CLR    >$C0           ;
DFC6 FF           ????   >$C0           ;
DFC7 31   00      LEAY   0,X            ;
DFC9 FE   
; Snake Picture
DFCA 8482
DFCC 70   7A5C 
DFCF 7C   5E7E
DFD2 5E      
DFD3 82   5C
DFD5 84   70
DFD7 82   80
DFD9 8C   8488
DFDC 84   72 
DFDE 78   6C6A
DFE1 76   7870
DFE4 7C   747C
DFE7 7E   FF64
DFEA 78   FCE0
DFED E2   EE 
DFEF E0   F1
DFF1 22 EE 06 2E    
DFF5 E2 11 20 2E   
DFF9 22 20 00 FE    

DFFD 4B 53 4B      

