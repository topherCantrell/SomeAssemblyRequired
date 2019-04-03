; GALAGA CPU #2 Game Loop Processor
;
;================================================================
; Startup comes here
0000 310091   LD     SP,$9100     ; Initialize stack
0003 C37C05   JP     $057C        ; Continue processing
0006 FF       RST    38H          ; Filler for RST
0007 FF       RST    38H          ; Filler for RST
;
;================================================================
; Add A*2 to HL. (If A is zero, add 0x100 to HL)
0008 87       ADD    A,A          ; A*2
0009 3005     JR     NC,$10       ; Overflow?
000B 24       INC    H            ; Yes ... bump HL
000C C31000   JP     $0010        ; Continue with add routine
000F FF       RST    38H          ; Filler
;
;================================================================
; Add A to HL
0010 85       ADD    A,L          ; Offset L by A
0011 6F       LD     L,A          ; Overflow?
0012 D0       RET    NC           ; No - HL is fine
0013 24       INC    H            ; Yes - Add carry to H
0014 C9       RET                 ; Done
0015 FF       RST    38H          ; Filler
0016 FF       RST    38H          ; Filler
0017 FF       RST    38H          ; Filler
;
;================================================================
; Fill buffer pointed to by HL (length in B)
; with byte value in A.
0018 77       LD     (HL),A       ; Store value to buffer
0019 23       INC    HL           ; Next in buffer
001A 10FC     DJNZ   $18          ; Do B times
001C C9       RET                 ; Done

; Looks like data from here to 34

001D 23       INC    HL           ; #
001E 0616     LD     B,#16        ; #
0020 23       INC    HL           ; #
0021 00       NOP                 ; #
0022 19       ADD    HL,DE        ; #
0023 F7       RST    30H          ; #
0024 4B       LD     C,E          ; #
0025 00       NOP                 ; #
0026 23       INC    HL           ; #
0027 F0       RET    P            ; #
0028 02       LD     (BC),A       ; #
0029 F0       RET    P            ; #
002A 5E       LD     E,(HL)       ; #
002B 00       NOP                 ; #
002C 23       INC    HL           ; #
002D F0       RET    P            ; #
002E 24       INC    H            ; #
002F FB       EI                  ; #
0030 23       INC    HL           ; #
0031 00       NOP                 ; #
0032 FF       RST    38H          ; #
0033 FF       RST    38H          ; #

0034 E9       JP     (HL)         ; Jump to routine pointed to by HL
;
0035 FF       RST    38H          ; (Routine RETs to caller)
0036 FF       RST    38H          ;
0037 FF       RST    38H          ;

0038 C31305   JP     $0513        ; IRQ Routine

; Jump table for commands
003B BE05 RET
003D BF05     Commenting this disables the drawing of the Blue bees and the Big Bees
003F D308     Commenting this disables all enemies. They don't appear on the screen and the levels progress automatically upwards.
0041 BE05 RET
0043 F506     Commenting this disables player fire. The bullet appears but stays in place at the bottom. Collisions with it do not explode.
0045 EE05     Commenting this disables player collision detection. Bullets and bees pass under the player undetected.
0047 BE05 RET
0049 CA0E TOPHER Expansion check? Commenting seemed to have no effect.

; Looks like data from here to 516

004B 23 ??				    ; #
004C F0       RET    P            ; #
004D 2623     LD     H,#23        ; #
004F 14       INC    D            ; #
0050 13       INC    DE           ; #
0051 FE0D     CP     #0D          ; #
0053 0B       DEC    BC           ; #
0054 0A       LD     A,(BC)       ; #
0055 08       EX     AF,A'F'      ; #
0056 0604     LD     B,#04        ; #
0058 03       INC    BC           ; #
0059 0123FF   LD     BC,$FF23     ; #
005C FF       RST    38H          ; #
005D FF       RST    38H          ; #
005E 44       LD     B,H          ; #
005F E418FB   CALL   P0,$FB18     ; #
0062 44       LD     B,H          ; #
0063 00       NOP                 ; #
0064 FF       RST    38H          ; #
0065 FF       RST    38H          ; #
0066 C9       RET                 ; # hardware interrupt
0067 23       INC    HL           ; #
0068 08       EX     AF,A'F'      ; #
0069 08       EX     AF,A'F'      ; #
006A 23       INC    HL           ; #
006B 03       INC    BC           ; #
006C 1B       DEC    DE           ; #
006D 23       INC    HL           ; #
006E 08       EX     AF,A'F'      ; #
006F 0F       RRCA                ; #
0070 23       INC    HL           ; #
0071 1615     LD     D,#15        ; #
0073 F7       RST    30H          ; #
0074 84       ADD    A,H          ; #
0075 00       NOP                 ; #
0076 23       INC    HL           ; #
0077 1603     LD     D,#03        ; #
0079 F0       RET    P            ; #
007A 97       SUB    A            ; #
007B 00       NOP                 ; #
007C 23       INC    HL           ; #
007D 1619     LD     D,#19        ; #
007F FB       EI                  ; #
0080 23       INC    HL           ; #
0081 00       NOP                 ; #
0082 FF       RST    38H          ; #
0083 FF       RST    38H          ; #
0084 23       INC    HL           ; #
0085 1601     LD     D,#01        ; #
0087 FE0D     CP     #0D          ; #
0089 0C       INC    C            ; #
008A 0A       LD     A,(BC)       ; #
008B 08       EX     AF,A'F'      ; #
008C 0604     LD     B,#04        ; #
008E 03       INC    BC           ; #
008F 0123FC   LD     BC,$FC23     ; #
0092 3023     JR     NZ,$B7       ; #
0094 00       NOP                 ; #
0095 FF       RST    38H          ; #
0096 FF       RST    38H          ; #
0097 44       LD     B,H          ; #
0098 27       DAA                 ; #
0099 0EFB     LD     C,#FB        ; #
009B 44       LD     B,H          ; #
009C 00       NOP                 ; #
009D FF       RST    38H          ; #
009E FF       RST    38H          ; #
009F 33       INC    SP           ; #
00A0 0618     LD     B,#18        ; #
00A2 23       INC    HL           ; #
00A3 00       NOP                 ; #
00A4 18F7     JR     $9D          ; #
00A6 B6       OR     (HL)         ; #
00A7 00       NOP                 ; #
00A8 23       INC    HL           ; #
00A9 F0       RET    P            ; #
00AA 08       EX     AF,A'F'      ; #
00AB F0       RET    P            ; #
00AC CC0023   CALL   Z,$2300      ; #
00AF F0       RET    P            ; #
00B0 20FB     JR     NZ,$AD       ; #
00B2 23       INC    HL           ; #
00B3 00       NOP                 ; #
00B4 FF       RST    38H          ; #
00B5 FF       RST    38H          ; #
00B6 23       INC    HL           ; #
00B7 F0       RET    P            ; #
00B8 2023     JR     NZ,$DD       ; #
00BA 100D     DJNZ   $C9          ; #
00BC FE1A     CP     #1A          ; #
00BE 1815     JR     $D5          ; #
00C0 100C     DJNZ   $CE          ; #
00C2 08       EX     AF,A'F'      ; #
00C3 05       DEC    B            ; #
00C4 03       INC    BC           ; #
00C5 23       INC    HL           ; #
00C6 FE30     CP     #30          ; #
00C8 23       INC    HL           ; #
00C9 00       NOP                 ; #
00CA FF       RST    38H          ; #
00CB FF       RST    38H          ; #
00CC 33       INC    SP           ; #
00CD E0       RET    P0           ; #
00CE 10FB     DJNZ   $CB          ; #
00D0 44       LD     B,H          ; #
00D1 00       NOP                 ; #
00D2 FF       RST    38H          ; #
00D3 FF       RST    38H          ; #
00D4 23       INC    HL           ; #
00D5 03       INC    BC           ; #
00D6 1833     JR     $10B         ; #
00D8 04       INC    B            ; #
00D9 1023     DJNZ   $FE          ; #
00DB 08       EX     AF,A'F'      ; #
00DC 0A       LD     A,(BC)       ; #
00DD 44       LD     B,H          ; #
00DE 1612     LD     D,#12        ; #
00E0 F7       RST    30H          ; #
00E1 60       LD     H,B          ; #
00E2 014416   LD     BC,$1644     ; #
00E5 03       INC    BC           ; #
00E6 F0       RET    P            ; #
00E7 73       LD     (HL),E       ; #
00E8 014416   LD     BC,$1644     ; #
00EB 1D       DEC    E            ; #
00EC FB       EI                  ; #
00ED 23       INC    HL           ; #
00EE 00       NOP                 ; #
00EF FF       RST    38H          ; #
00F0 FF       RST    38H          ; #
00F1 12       LD     (DE),A       ; #
00F2 1817     JR     $10B         ; #
00F4 12       LD     (DE),A       ; #
00F5 00       NOP                 ; #
00F6 80       ADD    A,B          ; #
00F7 FF       RST    38H          ; #
00F8 FF       RST    38H          ; #
00F9 FF       RST    38H          ; #
00FA FF       RST    38H          ; #
00FB FF       RST    38H          ; #
00FC FF       RST    38H          ; #
00FD FF       RST    38H          ; #
00FE FF       RST    38H          ; #
00FF FF       RST    38H          ; #

; Table used in Movement E
0100 14       INC    D            ; #
0101 0614     LD     B,#14        ; #
0103 0C       INC    C            ; #
0104 14       INC    D            ; #
0105 08       EX     AF,A'F'      ; #
0106 14       INC    D            ; #
0107 0A       LD     A,(BC)       ; #
0108 1C       INC    E            ; #
0109 00       NOP                 ; #
010A 1C       INC    E            ; #
010B 12       LD     (DE),A       ; #
010C 1E00     LD     E,#00        ; #
010E 1E12     LD     E,#12        ; #
0110 1C       INC    E            ; #
0111 02       LD     (BC),A       ; #
0112 1C       INC    E            ; #
0113 101E     DJNZ   $133         ; #
0115 02       LD     (BC),A       ; #
0116 1E10     LD     E,#10        ; #
0118 1C       INC    E            ; #
0119 04       INC    B            ; #
011A 1C       INC    E            ; #
011B 0E1E     LD     C,#1E        ; #
011D 04       INC    B            ; #
011E 1E0E     LD     E,#0E        ; #
0120 1C       INC    E            ; #
0121 061C     LD     B,#1C        ; #
0123 0C       INC    C            ; #
0124 1E06     LD     E,#06        ; #
0126 1E0C     LD     E,#0C        ; #
0128 1C       INC    E            ; #
0129 08       EX     AF,A'F'      ; #
012A 1C       INC    E            ; #
012B 0A       LD     A,(BC)       ; #
012C 1E08     LD     E,#08        ; #
012E 1E0A     LD     E,#0A        ; #
0130 1606     LD     D,#06        ; #
0132 160C     LD     D,#0C        ; #
0134 1608     LD     D,#08        ; #
0136 160A     LD     D,#0A        ; #
0138 1800     JR     $13A         ; #
013A 1812     JR     $14E         ; #
013C 1A       LD     A,(DE)       ; #
013D 00       NOP                 ; #
013E 1A       LD     A,(DE)       ; #
013F 12       LD     (DE),A       ; #
0140 1802     JR     $144         ; #
0142 1810     JR     $154         ; #
0144 1A       LD     A,(DE)       ; #
0145 02       LD     (BC),A       ; #
0146 1A       LD     A,(DE)       ; #
0147 1018     DJNZ   $161         ; #
0149 04       INC    B            ; #
014A 180E     JR     $15A         ; #
014C 1A       LD     A,(DE)       ; #
014D 04       INC    B            ; #
014E 1A       LD     A,(DE)       ; #
014F 0E18     LD     C,#18        ; #
0151 0618     LD     B,#18        ; #
0153 0C       INC    C            ; #
0154 1A       LD     A,(DE)       ; #
0155 061A     LD     B,#1A        ; #
0157 0C       INC    C            ; #
0158 1808     JR     $162         ; #
015A 180A     JR     $166         ; #
015C 1A       LD     A,(DE)       ; #
015D 08       EX     AF,A'F'      ; #
015E 1A       LD     A,(DE)       ; #
015F 0A       LD     A,(BC)       ; #
0160 44       LD     B,H          ; #
0161 1606     LD     D,#06        ; #
0163 FE0C     CP     #0C          ; #
0165 0B       DEC    BC           ; #
0166 0A       LD     A,(BC)       ; #
0167 08       EX     AF,A'F'      ; #
0168 0604     LD     B,#04        ; #
016A 02       LD     (BC),A       ; #
016B 0123FE   LD     BC,$FE23     ; #
016E 3023     JR     NZ,$193      ; #
0170 00       NOP                 ; #
0171 FF       RST    38H          ; #
0172 FF       RST    38H          ; #
0173 66       LD     H,(HL)       ; #
0174 2014     JR     NZ,$18A      ; #
0176 FB       EI                  ; #
0177 44       LD     B,H          ; #
0178 00       NOP                 ; #
0179 FF       RST    38H          ; #
017A FF       RST    38H          ; #
017B 23       INC    HL           ; #
017C 0618     LD     B,#18        ; #
017E 23       INC    HL           ; #
017F 00       NOP                 ; #
0180 18F7     JR     $179         ; #
0182 92       SUB    D            ; #
0183 0144F0   LD     BC,$F044     ; #
0186 08       EX     AF,A'F'      ; #
0187 F0       RET    P            ; #
0188 A8       XOR    B            ; #
0189 0144F0   LD     BC,$F044     ; #
018C 20FB     JR     NZ,$189      ; #
018E 23       INC    HL           ; #
018F 00       NOP                 ; #
0190 FF       RST    38H          ; #
0191 FF       RST    38H          ; #
0192 44       LD     B,H          ; #
0193 F0       RET    P            ; #
0194 2623     LD     H,#23        ; #
0196 100B     DJNZ   $1A3         ; #
0198 FE22     CP     #22          ; #
019A 201E     JR     NZ,$1BA      ; #
019C 1B       DEC    DE           ; #
019D 1815     JR     $1B4         ; #
019F 12       LD     (DE),A       ; #
01A0 1023     DJNZ   $1C5         ; #
01A2 FE30     CP     #30          ; #
01A4 23       INC    HL           ; #
01A5 00       NOP                 ; #
01A6 FF       RST    38H          ; #
01A7 FF       RST    38H          ; #
01A8 66       LD     H,(HL)       ; #
01A9 E0       RET    P0           ; #
01AA 10FB     DJNZ   $1A7         ; #
01AC 44       LD     B,H          ; #
01AD 00       NOP                 ; #
01AE FF       RST    38H          ; #
01AF FF       RST    38H          ; #
01B0 23       INC    HL           ; #
01B1 03       INC    BC           ; #
01B2 2023     JR     NZ,$1D7      ; #
01B4 08       EX     AF,A'F'      ; #
01B5 0F       RRCA                ; #
01B6 23       INC    HL           ; #
01B7 1612     LD     D,#12        ; #
01B9 F7       RST    30H          ; #
01BA CA0123   JP     Z,$2301      ; #
01BD 1603     LD     D,#03        ; #
01BF F0       RET    P            ; #
01C0 E0       RET    P0           ; #
01C1 012316   LD     BC,$1623     ; #
01C4 1D       DEC    E            ; #
01C5 FB       EI                  ; #
01C6 23       INC    HL           ; #
01C7 00       NOP                 ; #
01C8 FF       RST    38H          ; #
01C9 FF       RST    38H          ; #
01CA 23       INC    HL           ; #
01CB 1601     LD     D,#01        ; #
01CD FE0D     CP     #0D          ; #
01CF 0C       INC    C            ; #
01D0 0B       DEC    BC           ; #
01D1 09       ADD    HL,BC        ; #
01D2 07       RLCA                ; #
01D3 05       DEC    B            ; #
01D4 03       INC    BC           ; #
01D5 02       LD     (BC),A       ; #
01D6 23       INC    HL           ; #
01D7 02       LD     (BC),A       ; #
01D8 2023     JR     NZ,$1FD      ; #
01DA FC1223   CALL   M,$2312      ; #
01DD 00       NOP                 ; #
01DE FF       RST    38H          ; #
01DF FF       RST    38H          ; #
01E0 44       LD     B,H          ; #
01E1 2014     JR     NZ,$1F7      ; #
01E3 FB       EI                  ; #
01E4 44       LD     B,H          ; #
01E5 00       NOP                 ; #
01E6 FF       RST    38H          ; #
01E7 FF       RST    38H          ; #
01E8 23       INC    HL           ; #
01E9 00       NOP                 ; #
01EA 1023     DJNZ   $20F         ; #
01EC 014022   LD     BC,$2240     ; #
01EF 0C       INC    C            ; #
01F0 37       SCF                 ; #
01F1 23       INC    HL           ; #
01F2 00       NOP                 ; #
01F3 FF       RST    38H          ; #
01F4 FF       RST    38H          ; #
01F5 23       INC    HL           ; #
01F6 02       LD     (BC),A       ; #
01F7 3A2310   LD     A,($1023)    ; #
01FA 09       ADD    HL,BC        ; #
01FB 23       INC    HL           ; #
01FC 00       NOP                 ; #
01FD 1823     JR     $222         ; #
01FF 2010     JR     NZ,$211      ; #
0201 23       INC    HL           ; #
0202 00       NOP                 ; #
0203 1823     JR     $228         ; #
0205 200D     JR     NZ,$214      ; #
0207 23       INC    HL           ; #
0208 00       NOP                 ; #
0209 FF       RST    38H          ; #
020A FF       RST    38H          ; #
020B 23       INC    HL           ; #
020C 00       NOP                 ; #
020D 1023     DJNZ   $232         ; #
020F 013000   LD     BC,$0030     ; #
0212 40       LD     B,B          ; #
0213 08       EX     AF,A'F'      ; #
0214 23       INC    HL           ; #
0215 FF       RST    38H          ; #
0216 3023     JR     NZ,$23B      ; #
0218 00       NOP                 ; #
0219 FF       RST    38H          ; #
021A FF       RST    38H          ; #
021B 23       INC    HL           ; #
021C 00       NOP                 ; #
021D 3023     JR     NZ,$242      ; #
021F 05       DEC    B            ; #
0220 80       ADD    A,B          ; #
0221 23       INC    HL           ; #
0222 05       DEC    B            ; #
0223 4C       LD     C,H          ; #
0224 23       INC    HL           ; #
0225 04       INC    B            ; #
0226 012300   LD     BC,$0023     ; #
0229 50       LD     D,B          ; #
022A FF       RST    38H          ; #
022B 23       INC    HL           ; #
022C 00       NOP                 ; #
022D 2823     JR     Z,$252       ; #
022F 061D     LD     B,#1D        ; #
0231 23       INC    HL           ; #
0232 00       NOP                 ; #
0233 110040   LD     DE,$4000     ; #
0236 08       EX     AF,A'F'      ; #
0237 23       INC    HL           ; #
0238 00       NOP                 ; #
0239 1123FA   LD     DE,$FA23     ; #
023C 1D       DEC    E            ; #
023D 23       INC    HL           ; #
023E 00       NOP                 ; #
023F 50       LD     D,B          ; #
0240 FF       RST    38H          ; #
0241 23       INC    HL           ; #
0242 00       NOP                 ; #
0243 210020   LD     HL,$2000     ; #
0246 1023     DJNZ   $26B         ; #
0248 F8       RET    M            ; #
0249 2023     JR     NZ,$26E      ; #
024B FF       RST    38H          ; #
024C 2023     JR     NZ,$271      ; #
024E F8       RET    M            ; #
024F 1B       DEC    DE           ; #
0250 23       INC    HL           ; #
0251 E8       RET    PE           ; #
0252 0B       DEC    BC           ; #
0253 23       INC    HL           ; #
0254 00       NOP                 ; #
0255 210020   LD     HL,$2000     ; #
0258 08       EX     AF,A'F'      ; #
0259 23       INC    HL           ; #
025A 00       NOP                 ; #
025B 42       LD     B,D          ; #
025C FF       RST    38H          ; #
025D 23       INC    HL           ; #
025E 00       NOP                 ; #
025F 08       EX     AF,A'F'      ; #
0260 00       NOP                 ; #
0261 2008     JR     NZ,$26B      ; #
0263 23       INC    HL           ; #
0264 F0       RET    P            ; #
0265 2023     JR     NZ,$28A      ; #
0267 1020     DJNZ   $289         ; #
0269 23       INC    HL           ; #
026A F0       RET    P            ; #
026B 40       LD     B,B          ; #
026C 23       INC    HL           ; #
026D 1020     DJNZ   $28F         ; #
026F 23       INC    HL           ; #
0270 F0       RET    P            ; #
0271 2000     JR     NZ,$273      ; #
0273 2008     JR     NZ,$27D      ; #
0275 23       INC    HL           ; #
0276 00       NOP                 ; #
0277 30FF     JR     NZ,$278      ; #
0279 23       INC    HL           ; #
027A 100C     DJNZ   $288         ; #
027C 23       INC    HL           ; #
027D 00       NOP                 ; #
027E 2023     JR     NZ,$2A3      ; #
0280 E8       RET    PE           ; #
0281 1023     DJNZ   $2A6         ; #
0283 F41023   CALL   P,$2310      ; #
0286 E8       RET    PE           ; #
0287 1023     DJNZ   $2AC         ; #
0289 F43223   CALL   P,$2332      ; #
028C E8       RET    PE           ; #
028D 1023     DJNZ   $2B2         ; #
028F F43223   CALL   P,$2332      ; #
0292 E8       RET    PE           ; #
0293 1023     DJNZ   $2B8         ; #
0295 F41023   CALL   P,$2310      ; #
0298 E8       RET    PE           ; #
0299 0E23     LD     C,#23        ; #
029B 02       LD     (BC),A       ; #
029C 30FF     JR     NZ,$29D      ; #
029E 23       INC    HL           ; #
029F F1       POP    AF           ; #
02A0 08       EX     AF,A'F'      ; #
02A1 23       INC    HL           ; #
02A2 00       NOP                 ; #
02A3 1023     DJNZ   $2C8         ; #
02A5 05       DEC    B            ; #
02A6 3C       INC    A            ; #
02A7 23       INC    HL           ; #
02A8 07       RLCA                ; #
02A9 42       LD     B,D          ; #
02AA 23       INC    HL           ; #
02AB 0A       LD     A,(BC)       ; #
02AC 40       LD     B,B          ; #
02AD 23       INC    HL           ; #
02AE 102D     DJNZ   $2DD         ; #
02B0 23       INC    HL           ; #
02B1 2019     JR     NZ,$2CC      ; #
02B3 00       NOP                 ; #
02B4 FC1423   CALL   M,$2314      ; #
02B7 02       LD     (BC),A       ; #
02B8 4A       LD     C,D          ; #
02B9 FF       RST    38H          ; #
02BA 23       INC    HL           ; #
02BB 04       INC    B            ; #
02BC 2023     JR     NZ,$2E1      ; #
02BE 00       NOP                 ; #
02BF 1623     LD     D,#23        ; #
02C1 F0       RET    P            ; #
02C2 3023     JR     NZ,$2E7      ; #
02C4 00       NOP                 ; #
02C5 12       LD     (DE),A       ; #
02C6 23       INC    HL           ; #
02C7 1030     DJNZ   $2F9         ; #
02C9 23       INC    HL           ; #
02CA 00       NOP                 ; #
02CB 12       LD     (DE),A       ; #
02CC 23       INC    HL           ; #
02CD 1030     DJNZ   $2FF         ; #
02CF 23       INC    HL           ; #
02D0 00       NOP                 ; #
02D1 1623     LD     D,#23        ; #
02D3 04       INC    B            ; #
02D4 2023     JR     NZ,$2F9      ; #
02D6 00       NOP                 ; #
02D7 10FF     DJNZ   $2D8         ; #
02D9 23       INC    HL           ; #
02DA 00       NOP                 ; #
02DB 15       DEC    D            ; #
02DC 00       NOP                 ; #
02DD 2008     JR     NZ,$2E7      ; #
02DF 23       INC    HL           ; #
02E0 00       NOP                 ; #
02E1 1100E0   LD     DE,$E000     ; #
02E4 08       EX     AF,A'F'      ; #
02E5 23       INC    HL           ; #
02E6 00       NOP                 ; #
02E7 1800     JR     $2E9         ; #
02E9 2008     JR     NZ,$2F3      ; #
02EB 23       INC    HL           ; #
02EC 00       NOP                 ; #
02ED 13       INC    DE           ; #
02EE 00       NOP                 ; #
02EF E0       RET    P0           ; #
02F0 08       EX     AF,A'F'      ; #
02F1 23       INC    HL           ; #
02F2 00       NOP                 ; #
02F3 1F       RRA                 ; #
02F4 00       NOP                 ; #
02F5 2008     JR     NZ,$2FF      ; #
02F7 23       INC    HL           ; #
02F8 00       NOP                 ; #
02F9 30FF     JR     NZ,$2FA      ; #
02FB 23       INC    HL           ; #
02FC 02       LD     (BC),A       ; #
02FD 0E23     LD     C,#23        ; #
02FF 00       NOP                 ; #
0300 34       INC    (HL)         ; #
0301 23       INC    HL           ; #
0302 12       LD     (DE),A       ; #
0303 19       ADD    HL,DE        ; #
0304 23       INC    HL           ; #
0305 00       NOP                 ; #
0306 2023     JR     NZ,$32B      ; #
0308 E0       RET    P0           ; #
0309 0E23     LD     C,#23        ; #
030B 00       NOP                 ; #
030C 12       LD     (DE),A       ; #
030D 23       INC    HL           ; #
030E 200E     JR     NZ,$31E      ; #
0310 23       INC    HL           ; #
0311 00       NOP                 ; #
0312 0C       INC    C            ; #
0313 23       INC    HL           ; #
0314 E0       RET    P0           ; #
0315 0E23     LD     C,#23        ; #
0317 1B       DEC    DE           ; #
0318 08       EX     AF,A'F'      ; #
0319 23       INC    HL           ; #
031A 00       NOP                 ; #
031B 10FF     DJNZ   $31C         ; #
031D 23       INC    HL           ; #
031E 00       NOP                 ; #
031F 0D       DEC    C            ; #
0320 00       NOP                 ; #
0321 C0       RET    NZ           ; #
0322 04       INC    B            ; #
0323 23       INC    HL           ; #
0324 00       NOP                 ; #
0325 210040   LD     HL,$4000     ; #
0328 0623     LD     B,#23        ; #
032A 00       NOP                 ; #
032B 51       LD     D,C          ; #
032C 00       NOP                 ; #
032D C0       RET    NZ           ; #
032E 0623     LD     B,#23        ; #
0330 00       NOP                 ; #
0331 73       LD     (HL),E       ; #
0332 FF       RST    38H          ; #
0333 23       INC    HL           ; #
0334 08       EX     AF,A'F'      ; #
0335 2023     JR     NZ,$35A      ; #
0337 00       NOP                 ; #
0338 1623     LD     D,#23        ; #
033A E0       RET    P0           ; #
033B 0C       INC    C            ; #
033C 23       INC    HL           ; #
033D 02       LD     (BC),A       ; #
033E 0B       DEC    BC           ; #
033F 23       INC    HL           ; #
0340 110C23   LD     DE,$230C     ; #
0343 02       LD     (BC),A       ; #
0344 0B       DEC    BC           ; #
0345 23       INC    HL           ; #
0346 E0       RET    P0           ; #
0347 0C       INC    C            ; #
0348 23       INC    HL           ; #
0349 00       NOP                 ; #
034A 1623     LD     D,#23        ; #
034C 08       EX     AF,A'F'      ; #
034D 20FF     JR     NZ,$34E      ; #
034F 12       LD     (DE),A       ; #
0350 181E     JR     $370         ; #
0352 12       LD     (DE),A       ; #
0353 00       NOP                 ; #
0354 34       INC    (HL)         ; #
0355 12       LD     (DE),A       ; #
0356 FB       EI                  ; #
0357 2612     LD     H,#12        ; #
0359 00       NOP                 ; #
035A 02       LD     (BC),A       ; #
035B FC2E12   CALL   M,$122E      ; #
035E FA3CFA   JP     M,$FA3C      ; #
0361 9E       SBC    A,(HL)       ; #
0362 03       INC    BC           ; #
0363 12       LD     (DE),A       ; #
0364 F8       RET    M            ; #
0365 1012     DJNZ   $379         ; #
0367 FA5C12   JP     M,$125C      ; #
036A 00       NOP                 ; #
036B 23       INC    HL           ; #
036C F8       RET    M            ; #
036D F9       LD     SP,HL        ; #
036E EF       RST    28H          ; #
036F 7C       LD     A,H          ; #
0370 03       INC    BC           ; #
0371 F6AB     OR     #AB          ; #
0373 12       LD     (DE),A       ; #
0374 012812   LD     BC,$1228     ; #
0377 0A       LD     A,(BC)       ; #
0378 18FD     JR     $377         ; #
037A 52       LD     D,D          ; #
037B 03       INC    BC           ; #
037C F6B0     OR     #B0          ; #
037E 23       INC    HL           ; #
037F 08       EX     AF,A'F'      ; #
0380 1E23     LD     E,#23        ; #
0382 00       NOP                 ; #
0383 19       ADD    HL,DE        ; #
0384 23       INC    HL           ; #
0385 F8       RET    M            ; #
0386 1623     LD     D,#23        ; #
0388 00       NOP                 ; #
0389 02       LD     (BC),A       ; #
038A FC3023   CALL   M,$2330      ; #
038D F7       RST    30H          ; #
038E 26FA     LD     H,#FA        ; #
0390 9E       SBC    A,(HL)       ; #
0391 03       INC    BC           ; #
0392 23       INC    HL           ; #
0393 F0       RET    P            ; #
0394 0A       LD     A,(BC)       ; #
0395 23       INC    HL           ; #
0396 F5       PUSH   AF           ; #
0397 312300   LD     SP,$0023     ; #
039A 10FD     DJNZ   $399         ; #
039C 6C       LD     L,H          ; #
039D 03       INC    BC           ; #
039E 12       LD     (DE),A       ; #
039F F8       RET    M            ; #
03A0 1012     DJNZ   $3B4         ; #
03A2 00       NOP                 ; #
03A3 40       LD     B,B          ; #
03A4 FB       EI                  ; #
03A5 12       LD     (DE),A       ; #
03A6 00       NOP                 ; #
03A7 FF       RST    38H          ; #
03A8 FF       RST    38H          ; #
03A9 12       LD     (DE),A       ; #
03AA 181D     JR     $3C9         ; #
03AC 12       LD     (DE),A       ; #
03AD 00       NOP                 ; #
03AE 2812     JR     Z,$3C2       ; #
03B0 FA02F3   JP     M,$F302      ; #
03B3 3F       CCF                 ; #
03B4 3B       DEC    SP           ; #
03B5 3632     LD     (HL),#32     ; #
03B7 2826     JR     Z,$3DF       ; #
03B9 24       INC    H            ; #
03BA 221204   LD     ($0412),HL   ; #
03BD 3012     JR     NZ,$3D1      ; #
03BF FC3012   CALL   M,$1230      ; #
03C2 00       NOP                 ; #
03C3 18F8     JR     $3BD         ; #
03C5 F9       LD     SP,HL        ; #
03C6 FA0C04   JP     M,$040C      ; #
03C9 EF       RST    28H          ; #
03CA D7       RST    10H          ; #
03CB 03       INC    BC           ; #
03CC F6B0     OR     #B0          ; #
03CE 12       LD     (DE),A       ; #
03CF 012812   LD     BC,$1228     ; #
03D2 0A       LD     A,(BC)       ; #
03D3 15       DEC    D            ; #
03D4 FD       ???                 ; #
03D5 AC       XOR    H            ; #
03D6 03       INC    BC           ; #
03D7 F6C0     OR     #C0          ; #
03D9 23       INC    HL           ; #
03DA 08       EX     AF,A'F'      ; #
03DB 1023     DJNZ   $400         ; #
03DD 00       NOP                 ; #
03DE 23       INC    HL           ; #
03DF 23       INC    HL           ; #
03E0 F8       RET    M            ; #
03E1 0F       RRCA                ; #
03E2 23       INC    HL           ; #
03E3 00       NOP                 ; #
03E4 48       LD     C,B          ; #
03E5 F8       RET    M            ; #
03E6 F9       LD     SP,HL        ; #
03E7 FA0C04   JP     M,$040C      ; #
03EA F6B0     OR     #B0          ; #
03EC 23       INC    HL           ; #
03ED 08       EX     AF,A'F'      ; #
03EE 2023     JR     NZ,$413      ; #
03F0 00       NOP                 ; #
03F1 08       EX     AF,A'F'      ; #
03F2 23       INC    HL           ; #
03F3 F8       RET    M            ; #
03F4 02       LD     (BC),A       ; #
03F5 F3       DI                  ; #
03F6 34       INC    (HL)         ; #
03F7 312D29   LD     SP,$292D     ; #
03FA 22261F   LD     ($1F26),HL   ; #
03FD 1823     JR     $422         ; #
03FF 08       EX     AF,A'F'      ; #
0400 1823     JR     $425         ; #
0402 F8       RET    M            ; #
0403 1823     JR     $428         ; #
0405 00       NOP                 ; #
0406 10F8     DJNZ   $400         ; #
0408 F9       LD     SP,HL        ; #
0409 FD       ???                 ; #
040A CC03FB   CALL   Z,$FB03      ; #
040D 12       LD     (DE),A       ; #
040E 00       NOP                 ; #
040F FF       RST    38H          ; #
0410 FF       RST    38H          ; #
0411 12       LD     (DE),A       ; #
0412 1814     JR     $428         ; #
0414 12       LD     (DE),A       ; #
0415 03       INC    BC           ; #
0416 2A1210   LD     HL,($1012)   ; #
0419 40       LD     B,B          ; #
041A 12       LD     (DE),A       ; #
041B 012012   LD     BC,$1220     ; #
041E FE71     CP     #71          ; #
0420 F9       LD     SP,HL        ; #
0421 F1       POP    AF           ; #
0422 FA0C04   JP     M,$040C      ; #
0425 EF       RST    28H          ; #
0426 3004     JR     NZ,$42C      ; #
0428 F6AB     OR     #AB          ; #
042A 12       LD     (DE),A       ; #
042B 02       LD     (BC),A       ; #
042C 20FD     JR     NZ,$42B      ; #
042E 14       INC    D            ; #
042F 04       INC    B            ; #
0430 F6B0     OR     #B0          ; #
0432 23       INC    HL           ; #
0433 04       INC    B            ; #
0434 1A       LD     A,(DE)       ; #
0435 23       INC    HL           ; #
0436 03       INC    BC           ; #
0437 1D       DEC    E            ; #
0438 23       INC    HL           ; #
0439 1A       LD     A,(DE)       ; #
043A 25       DEC    H            ; #
043B 23       INC    HL           ; #
043C 03       INC    BC           ; #
043D 1023     DJNZ   $462         ; #
043F FD       ???                 ; #
0440 48       LD     C,B          ; #
0441 FD       ???                 ; #
0442 2004     JR     NZ,$448      ; #
0444 12       LD     (DE),A       ; #
0445 1814     JR     $45B         ; #
0447 12       LD     (DE),A       ; #
0448 03       INC    BC           ; #
0449 2A1210   LD     HL,($1012)   ; #
044C 40       LD     B,B          ; #
044D 12       LD     (DE),A       ; #
044E 012012   LD     BC,$1220     ; #
0451 FE78     CP     #78          ; #
0453 FF       RST    38H          ; #
0454 12       LD     (DE),A       ; #
0455 1814     JR     $46B         ; #
0457 F41200   CALL   P,$0012      ; #
045A 04       INC    B            ; #
045B FC4800   CALL   M,$0048      ; #
045E FCFF23   CALL   M,$23FF      ; #
0461 00       NOP                 ; #
0462 30F8     JR     NZ,$45C      ; #
0464 F9       LD     SP,HL        ; #
0465 FA0C04   JP     M,$040C      ; #
0468 FD       ???                 ; #
0469 25       DEC    H            ; #
046A 04       INC    B            ; #
046B 12       LD     (DE),A       ; #
046C 1814     JR     $482         ; #
046E FB       EI                  ; #
046F 12       LD     (DE),A       ; #
0470 00       NOP                 ; #
0471 FF       RST    38H          ; #
0472 FF       RST    38H          ; #
0473 12       LD     (DE),A       ; #
0474 181E     JR     $494         ; #
0476 12       LD     (DE),A       ; #
0477 00       NOP                 ; #
0478 08       EX     AF,A'F'      ; #
0479 F29904   JP     P,$0499      ; #
047C 00       NOP                 ; #
047D 00       NOP                 ; #
047E 0A       LD     A,(BC)       ; #
047F F29904   JP     P,$0499      ; #
0482 00       NOP                 ; #
0483 00       NOP                 ; #
0484 0A       LD     A,(BC)       ; #
0485 12       LD     (DE),A       ; #
0486 00       NOP                 ; #
0487 2C       INC    L            ; #
0488 12       LD     (DE),A       ; #
0489 FB       EI                  ; #
048A 2612     LD     H,#12        ; #
048C 00       NOP                 ; #
048D 02       LD     (BC),A       ; #
048E FC2E12   CALL   M,$122E      ; #
0491 FA3CFA   JP     M,$FA3C      ; #
0494 9E       SBC    A,(HL)       ; #
0495 03       INC    BC           ; #
0496 FD       ???                 ; #
0497 63       LD     H,E          ; #
0498 03       INC    BC           ; #
0499 12       LD     (DE),A       ; #
049A 00       NOP                 ; #
049B 2C       INC    L            ; #
049C 12       LD     (DE),A       ; #
049D FB       EI                  ; #
049E 2612     LD     H,#12        ; #
04A0 00       NOP                 ; #
04A1 02       LD     (BC),A       ; #
04A2 FC2E12   CALL   M,$122E      ; #
04A5 FA1812   JP     M,$1218      ; #
04A8 00       NOP                 ; #
04A9 10FF     DJNZ   $4AA         ; #
04AB 12       LD     (DE),A       ; #
04AC 1813     JR     $4C1         ; #
04AE F2C604   JP     P,$04C6      ; #
04B1 00       NOP                 ; #
04B2 00       NOP                 ; #
04B3 08       EX     AF,A'F'      ; #
04B4 F2CF04   JP     P,$04CF      ; #
04B7 00       NOP                 ; #
04B8 00       NOP                 ; #
04B9 08       EX     AF,A'F'      ; #
04BA 12       LD     (DE),A       ; #
04BB 180B     JR     $4C8         ; #
04BD 12       LD     (DE),A       ; #
04BE 00       NOP                 ; #
04BF 34       INC    (HL)         ; #
04C0 12       LD     (DE),A       ; #
04C1 FB       EI                  ; #
04C2 26FD     LD     H,#FD        ; #
04C4 58       LD     E,B          ; #
04C5 03       INC    BC           ; #
04C6 12       LD     (DE),A       ; #
04C7 00       NOP                 ; #
04C8 1012     DJNZ   $4DC         ; #
04CA 180B     JR     $4D7         ; #
04CC FD       ???                 ; #
04CD D8       RET    C            ; #
04CE 04       INC    B            ; #
04CF 12       LD     (DE),A       ; #
04D0 00       NOP                 ; #
04D1 08       EX     AF,A'F'      ; #
04D2 12       LD     (DE),A       ; #
04D3 180B     JR     $4E0         ; #
04D5 12       LD     (DE),A       ; #
04D6 00       NOP                 ; #
04D7 0612     LD     B,#12        ; #
04D9 00       NOP                 ; #
04DA 2212FB   LD     ($FB12),HL   ; #
04DD 2612     LD     H,#12        ; #
04DF 00       NOP                 ; #
04E0 02       LD     (BC),A       ; #
04E1 FC2E12   CALL   M,$122E      ; #
04E4 FA1812   JP     M,$1218      ; #
04E7 00       NOP                 ; #
04E8 20FF     JR     NZ,$4E9      ; #
04EA 12       LD     (DE),A       ; #
04EB 181E     JR     $50B         ; #
04ED 12       LD     (DE),A       ; #
04EE 00       NOP                 ; #
04EF 14       INC    D            ; #
04F0 F20205   JP     P,$0502      ; #
04F3 12       LD     (DE),A       ; #
04F4 00       NOP                 ; #
04F5 08       EX     AF,A'F'      ; #
04F6 F20205   JP     P,$0502      ; #
04F9 12       LD     (DE),A       ; #
04FA 00       NOP                 ; #
04FB 1812     JR     $50F         ; #
04FD FB       EI                  ; #
04FE 26FD     LD     H,#FD        ; #
0500 58       LD     E,B          ; #
0501 03       INC    BC           ; #
0502 12       LD     (DE),A       ; #
0503 E201F3   JP     P0,$F301     ; #
0506 08       EX     AF,A'F'      ; #
0507 07       RLCA                ; #
0508 0605     LD     B,#05        ; #
050A 04       INC    B            ; #
050B 03       INC    BC           ; #
050C 02       LD     (BC),A       ; #
050D 01F523   LD     BC,$23F5     ; #
0510 00       NOP                 ; #
0511 48       LD     C,B          ; #
0512 FF       RST    38H          ; #

;================================================================
; Interrupt comes here
; Interrupt is ignored if DSW2:5 is clear [FREEZE].
0513 AF       XOR    A            ; Disable ...
0514 322168   LD     ($6821),A    ; ... interrupt delivery
0517 3A0468   LD     A,($6804)    ; Read DSW bit 5
051A E602     AND    #02          ; FREEZE DIP switch set to 0?
051C CA7505   JP     Z,$0575      ; Yes - skip processing
051F 3AA092   LD     A,($92A0)    ; Bump counter ...
0522 3C       INC    A            ; ...
0523 32A092   LD     ($92A0),A    ; ... in 92A0
0526 2AA192   LD     HL,($92A1)   ; Pair of special counters
0529 E61F     AND    #1F          ; Mask off upper three bits of count
052B 3D       DEC    A            ; Is the current count 1?
052C 2808     JR     Z,$536       ; Yes, add 1 to H
052E 3C       INC    A            ; Was it 0?
052F 2006     JR     NZ,$537      ; No, leave 92A1 alone
0531 7C       LD     A,H          ; Set ...
0532 F601     OR     #01          ; ... bit 0 ...
0534 67       LD     H,A          ; ... of H
0535 2C       INC    L            ; Add 1 to L
0536 24       INC    H            ; Add 1 to H
0537 22A192   LD     ($92A1),HL   ; TOPHER ?
053A 3AC799   LD     A,($99C7)    ;
053D 5F       LD     E,A          ;
053E 3AA792   LD     A,($92A7)    ;
0541 BB       CP     E            ;
0542 CB10     RL     B            ;
0544 3A1590   LD     A,($9015)    ;
0547 A0       AND    B            ;
0548 E601     AND    #01          ;
054A 32AA92   LD     ($92AA),A    ;
;
054D 0E00     LD     C,#00        ; First command
054F 212090   LD     HL,$9020     ; Command flags
0552 79       LD     A,C          ; Command to A
0553 85       ADD    A,L          ; Bump HL ...
0554 6F       LD     L,A          ; ... by command number
0555 7E       LD     A,(HL)       ; Get flag
0556 A7       AND    A            ; Do command ...
0557 2003     JR     NZ,$55C      ; ... if flag is not 0
0559 0C       INC    C            ; Else ...
055A 18F3     JR     $54F         ; ... continue with next command.
;
; Do commands
055C 47       LD     B,A          ; Hold flag byte
055D 213B00   LD     HL,$003B     ; Jump table
0560 79       LD     A,C          ; Command
0561 CB27     SLA    A            ; *2
0563 85       ADD    A,L          ; Offset into table
0564 6F       LD     L,A          ; Set HL to table point
0565 5E       LD     E,(HL)       ; Get LSB
0566 23       INC    HL           ; Bump
0567 56       LD     D,(HL)       ; Get MSB
0568 EB       EX     DE,HL        ; HL to DE
0569 C5       PUSH   BC           ; Preserve BC (B=flag,C=command)
056A CD3400   CALL   $0034        ; Vector to command
056D C1       POP    BC           ; Restore BC
056E 78       LD     A,B          ; Flag byte
056F 81       ADD    A,C          ; Add to command number
0570 4F       LD     C,A          ; Back to command number
0571 E6F8     AND    #F8          ; Only 8 commands
0573 28DA     JR     Z,$54F       ; Reload flag table
;
0575 3E01     LD     A,#01        ; Enable ...
0577 322168   LD     ($6821),A    ; ... interrupt delivery
057A FB       EI                  ; Enable interrupt receiver
057B C9       RET                 ; Done

;================================================================
; Initialization
; Wait for CLEAR, send checksum results, and wait for CLEAR.
; Enable IRQ
; Initialize 7 bytes of memory at 89E0
; Infinite loop processing IRQ and resetting stack to 9100.
057C 110091   LD     DE,$9100     ; Semaphore
057F 1A       LD     A,(DE)       ; Wait for ...
0580 A7       AND    A            ; ... CPU1 to ...
0581 20FC     JR     NZ,$57F      ; ... initialize
0583 67       LD     H,A          ; Zero H
0584 6F       LD     L,A          ; Zero L
0585 011000   LD     BC,$0010     ; Checksum ...
0588 86       ADD    A,(HL)       ; ... first ...
0589 23       INC    HL           ; ... 1000 ...
058A 10FC     DJNZ   $588         ; ... bytes
058C 0D       DEC    C            ; ...
058D 20F9     JR     NZ,$588      ; ... of ROM
058F FEFF     CP     #FF          ; ROM checksum looks good?
0591 2802     JR     Z,$595       ; Yes - move on
0593 3E11     LD     A,#11        ; Bad checksum value
0595 12       LD     (DE),A       ; Tell CPU2
0596 1A       LD     A,(DE)       ; Wait ...
0597 A7       AND    A            ; ... for ...
0598 20FC     JR     NZ,$596      ; ... acknowledgement
059A ED56     IM     1            ; Set interrupt mode
059C AF       XOR    A            ; Zero
059D 32E089   LD     ($89E0),A    ; Clear byte
05A0 21B705   LD     HL,$05B7     ; Copy ...
05A3 112190   LD     DE,$9021     ; ... bytes ...
05A6 010700   LD     BC,$0007     ; ... from ...
05A9 EDB0     LDIR                ; ... ROM
05AB 3E01     LD     A,#01        ; Enable ...
05AD 322168   LD     ($6821),A    ; ... IRQ delivery
05B0 FB       EI                  ; Enable IRQ handling
05B1 310091   LD     SP,$9100     ; Infinte loop ...
05B4 C3B105   JP     $05B1        ; ... resets stack after each

;================================================================
; TOPHER Moved to 89E0
05B7 010100   LD     BC,$0001     ;
05BA 010100   LD     BC,$0001     ;
05BD 0A       LD     A,(BC)       ;

; Commands 0,3,6
05BE C9       RET                 ;

;================================================================
; Command 1 : Looks like drawing of the blue bees and the big bees
; TOPHER What exactly is going on here?
; Linked to CPU1 0863
05BF 3E01     LD     A,#01        ; Flag move ...
05C1 32D792   LD     ($92D7),A    ; ... in progress
05C4 21008B   LD     HL,$8B00     ; Move 0x40 bytes ...
05C7 11808B   LD     DE,$8B80     ; ... from ...
05CA 014000   LD     BC,$0040     ; ... 8B80 to 8B00 ...
05CD EDB0     LDIR                ; .
05CF 210093   LD     HL,$9300     ; Move 0x40 bytes ...
05D2 118093   LD     DE,$9380     ; ... from ...
05D5 0E40     LD     C,#40        ; ...
05D7 EDB0     LDIR                ;.
05D9 21009B   LD     HL,$9B00     ; Move 0x40 bytes ...
05DC 11809B   LD     DE,$9B80     ; ... from ...
05DF 0E40     LD     C,#40        ;...
05E1 EDB0     LDIR                ;.
05E3 AF       XOR    A            ; Flag move ...
05E4 32D792   LD     ($92D7),A    ; ... is complete
05E7 3AD692   LD     A,($92D6)    ; Wait for 92D6 ...
05EA 3D       DEC    A            ; ... to got to ...
05EB 28FA     JR     Z,$5E7       ; ... 01
05ED C9       RET                 ; Done

;================================================================
; Command 5: Player Collision Detection
05EE 3A1490   LD     A,($9014)    ; Do detection?
05F1 A7       AND    A            ; No ...
05F2 C8       RET    Z            ; ... return
05F3 321792   LD     ($9217),A    ;
05F6 3A2798   LD     A,($9827)    ;
05F9 A7       AND    A            ;
05FA 2817     JR     Z,$613       ;
05FC 216093   LD     HL,$9360     ;
05FF 7E       LD     A,(HL)       ;
0600 A7       AND    A            ;
0601 2810     JR     Z,$613       ;
0603 CD8106   CALL   $0681        ;
0606 3ABF99   LD     A,($99BF)    ;
0609 A7       AND    A            ;
060A 2807     JR     Z,$613       ;
060C CD4906   CALL   $0649        ;
060F AF       XOR    A            ;
0610 322B98   LD     ($982B),A    ;
0613 216293   LD     HL,$9362     ;
0616 7E       LD     A,(HL)       ;
0617 A7       AND    A            ;
0618 C8       RET    Z            ;
0619 CD8106   CALL   $0681        ;
061C 3ABF99   LD     A,($99BF)    ;
061F A7       AND    A            ;
0620 C8       RET    Z            ;
0621 3A2798   LD     A,($9827)    ;
0624 A7       AND    A            ;
0625 2812     JR     Z,$639       ;
0627 AF       XOR    A            ;
0628 322B98   LD     ($982B),A    ;
062B 3A6093   LD     A,($9360)    ;
062E 326293   LD     ($9362),A    ;
0631 3AE293   LD     A,($93E2)    ;
0634 21E093   LD     HL,$93E0     ;
0637 1816     JR     $64F         ;
0639 AF       XOR    A            ;
063A 321490   LD     ($9014),A    ;
063D 321590   LD     ($9015),A    ;
0640 322590   LD     ($9025),A    ;
0643 32B999   LD     ($99B9),A    ;
0646 321792   LD     ($9217),A    ;
0649 EB       EX     DE,HL        ;
064A 2693     LD     H,#93        ;
064C CBFD     SET    7,L          ;
064E 7E       LD     A,(HL)       ;
064F D608     SUB    #08          ;
0651 CBBD     RES    7,L          ;
0653 77       LD     (HL),A       ;
0654 2C       INC    L            ;
0655 7E       LD     A,(HL)       ;
0656 D608     SUB    #08          ;
0658 77       LD     (HL),A       ;
0659 268B     LD     H,#8B        ;
065B 360B     LD     (HL),#0B     ;
065D 2D       DEC    L            ;
065E 3620     LD     (HL),#20     ;
0660 2688     LD     H,#88        ;
0662 3608     LD     (HL),#08     ;
0664 2C       INC    L            ;
0665 360F     LD     (HL),#0F     ;
0667 2D       DEC    L            ;
0668 269B     LD     H,#9B        ;
066A 360C     LD     (HL),#0C     ;
066C AF       XOR    A            ;
066D 322798   LD     ($9827),A    ;
0670 3A0192   LD     A,($9201)    ;
0673 3D       DEC    A            ;
0674 32B99A   LD     ($9AB9),A    ;
0677 3A1792   LD     A,($9217)    ;
067A A7       AND    A            ;
067B C0       RET    NZ           ;
067C 3C       INC    A            ;
067D 321392   LD     ($9213),A    ;
0680 C9       RET                 ;
;
0681 AF       XOR    A            ;
0682 32BF99   LD     ($99BF),A    ;
0685 2688     LD     H,#88        ;
0687 7E       LD     A,(HL)       ;
0688 2693     LD     H,#93        ;
068A FE08     CP     #08          ;
068C C8       RET    Z            ;
068D 7E       LD     A,(HL)       ;
068E DD       ???                 ;
068F 6F       LD     L,A          ;
0690 2C       INC    L            ;
0691 46       LD     B,(HL)       ;
0692 269B     LD     H,#9B        ;
0694 7E       LD     A,(HL)       ;
0695 0F       RRCA                ;
0696 CB18     RR     B            ;
0698 DD       ???                 ;
0699 60       LD     H,B          ;
069A 2D       DEC    L            ;
069B 5D       LD     E,L          ;
069C 3A0890   LD     A,($9008)    ;
069F A7       AND    A            ;
06A0 2806     JR     Z,$6A8       ;
06A2 2E38     LD     L,#38        ;
06A4 0604     LD     B,#04        ;
06A6 1804     JR     $6AC         ;
06A8 2E00     LD     L,#00        ;
06AA 0630     LD     B,#30        ; 48 Bees to check
06AC CDB706   CALL   $06B7        ; Check collision with bees
06AF 2E68     LD     L,#68        ; Shot space
06B1 0608     LD     B,#08        ; Eight shots to check
06B3 CDB706   CALL   $06B7        ; Check collision with fire
06B6 C9       RET                 ;
;
06B7 2692     LD     H,#92        ; 
06B9 7E       LD     A,(HL)       ; 
06BA 2688     LD     H,#88        ;
06BC B6       OR     (HL)         ;
06BD 07       RLCA                ; Upper bit set?
06BE 3830     JR     C,$6F0       ; Yes ... next entity
06C0 7E       LD     A,(HL)       ;
06C1 E6FE     AND    #FE          ;
06C3 FE04     CP     #04          ;
06C5 2829     JR     Z,$6F0       ; Next entity
06C7 2693     LD     H,#93        ;
06C9 7E       LD     A,(HL)       ;
06CA A7       AND    A            ;
06CB 2823     JR     Z,$6F0       ; Next entity
06CD DD       ???                 ;
06CE 95       SUB    L            ;
06CF D607     SUB    #07          ;
06D1 C60D     ADD    A,#0D        ;
06D3 301B     JR     NZ,$6F0      ; Next entity
06D5 2C       INC    L            ;
06D6 7E       LD     A,(HL)       ;
06D7 269B     LD     H,#9B        ;
06D9 4E       LD     C,(HL)       ;
06DA 2D       DEC    L            ;
06DB CB09     RRC    C            ;
06DD 1F       RRA                 ;
06DE DD       ???                 ;
06DF 94       SUB    H            ;
06E0 D604     SUB    #04          ;
06E2 C607     ADD    A,#07        ;
06E4 300A     JR     NZ,$6F0      ; Next entity
06E6 3E01     LD     A,#01        ;
06E8 32BF99   LD     ($99BF),A    ;
06EB B7       OR     A            ;
06EC 08       EX     AF,A'F'      ;
06ED C3C207   JP     $07C2        ; User hit?
;
06F0 2C       INC    L            ; Next ... 
06F1 2C       INC    L            ; ... pointer
06F2 10C3     DJNZ   $6B7         ; Do until all checked.
06F4 C9       RET                 ; Then return

;================================================================
; Command 4 : Move the player's fire
06F5 11A492   LD     DE,$92A4     ;
06F8 216493   LD     HL,$9364     ;
06FB CD0407   CALL   $0704        ;
06FE 11A592   LD     DE,$92A5     ;
0701 216693   LD     HL,$9366     ;
0704 7E       LD     A,(HL)       ;
0705 A7       AND    A            ;
0706 C8       RET    Z            ;
0707 1A       LD     A,(DE)       ;
0708 47       LD     B,A          ;
0709 E607     AND    #07          ;
070B 08       EX     AF,A'F'      ;
070C 3E06     LD     A,#06        ;
070E CB78     BIT    7,B          ;
0710 2801     JR     Z,$713       ;
0712 08       EX     AF,A'F'      ;
0713 CB70     BIT    6,B          ;
0715 2802     JR     Z,$719       ;
0717 ED44     NEG                 ;
0719 86       ADD    A,(HL)       ;
071A 77       LD     (HL),A       ;
071B FEF0     CP     #F0          ;
071D 3044     JR     NZ,$763      ;
071F DD       ???                 ;
0720 6F       LD     L,A          ;
0721 2C       INC    L            ;
0722 08       EX     AF,A'F'      ;
0723 CB68     BIT    5,B          ;
0725 2802     JR     Z,$729       ;
0727 ED44     NEG                 ;
0729 4F       LD     C,A          ;
072A 86       ADD    A,(HL)       ;
072B 77       LD     (HL),A       ;
072C 1F       RRA                 ;
072D A9       XOR    C            ;
072E 269B     LD     H,#9B        ;
0730 07       RLCA                ;
0731 3005     JR     NZ,$738      ;
0733 CB0E     RRC    (HL)         ;
0735 3F       CCF                 ;
0736 CB16     RL     (HL)         ;
0738 4E       LD     C,(HL)       ;
0739 2693     LD     H,#93        ;
073B 7E       LD     A,(HL)       ;
073C CB09     RRC    C            ;
073E 1F       RRA                 ;
073F DD       ???                 ;
0740 67       LD     H,A          ;
0741 FE14     CP     #14          ;
0743 381B     JR     C,$760       ;
0745 FE9C     CP     #9C          ;
0747 3017     JR     NZ,$760      ;
0749 5D       LD     E,L          ;
074A 3A1D90   LD     A,($901D)    ;
074D A7       AND    A            ;
074E 2807     JR     Z,$757       ;
0750 210893   LD     HL,$9308     ;
0753 062C     LD     B,#2C        ;
0755 1805     JR     $75C         ;
0757 210093   LD     HL,$9300     ;
075A 0630     LD     B,#30        ; 48 descriptors to check
075C CD6A07   CALL   $076A        ; Check them ...
075F C9       RET                 ; ... and out
;
0760 2D       DEC    L            ;
0761 2693     LD     H,#93        ;
0763 3600     LD     (HL),#00     ;
0765 269B     LD     H,#9B        ;
0767 3600     LD     (HL),#00     ;
0769 C9       RET                 ;
;
076A 2692     LD     H,#92        ; ** Loop starts here **
076C 7E       LD     A,(HL)       ;
076D 2688     LD     H,#88        ;
076F B6       OR     (HL)         ;
0770 07       RLCA                ;
0771 3841     JR     C,$7B4       ; Cary set if #80 --
0773 7E       LD     A,(HL)       ;
0774 4F       LD     C,A          ;
0775 E6FE     AND    #FE          ;
0777 FE04     CP     #04          ;
0779 2839     JR     Z,$7B4       ;
077B 2C       INC    L            ;
077C 269B     LD     H,#9B        ;
077E 56       LD     D,(HL)       ;
077F 2693     LD     H,#93        ;
0781 7E       LD     A,(HL)       ;
0782 CB0A     RRC    D            ;
0784 1F       RRA                 ;
0785 2D       DEC    L            ;
0786 DD       ???                 ;
0787 94       SUB    H            ;
0788 D603     SUB    #03          ;
078A C606     ADD    A,#06        ;
078C 3026     JR     NZ,$7B4      ; Move on to next
078E 79       LD     A,C          ;
078F 3D       DEC    A            ;
0790 E6FE     AND    #FE          ;
0792 08       EX     AF,A'F'      ;
0793 3A2798   LD     A,($9827)    ;
0796 A7       AND    A            ;
0797 7E       LD     A,(HL)       ;
0798 200A     JR     NZ,$7A4      ;
079A DD       ???                 ;
079B 95       SUB    L            ;
079C D606     SUB    #06          ;
079E C60B     ADD    A,#0B        ;
07A0 3817     JR     C,$7B9       ;
07A2 1810     JR     $7B4         ; Move on to next
07A4 DD       ???                 ;
07A5 95       SUB    L            ;
07A6 D614     SUB    #14          ;
07A8 C60B     ADD    A,#0B        ;
07AA 380D     JR     C,$7B9       ;
07AC C604     ADD    A,#04        ;
07AE 3804     JR     C,$7B4       ;
07B0 C60B     ADD    A,#0B        ;
07B2 3805     JR     C,$7B9       ;
07B4 2C       INC    L            ; Next ...
07B5 2C       INC    L            ; ... descriptor
07B6 10B2     DJNZ   $76A         ; Do all
07B8 C9       RET                 ; Return after all descriptors are processed
07B9 7D       LD     A,L          ;
07BA 2A4498   LD     HL,($9844)   ;
07BD 23       INC    HL           ;
07BE 224498   LD     ($9844),HL   ;
07C1 6F       LD     L,A          ;
;
07C2 1693     LD     D,#93        ;
07C4 AF       XOR    A            ;
07C5 12       LD     (DE),A       ;
07C6 169B     LD     D,#9B        ;
07C8 12       LD     (DE),A       ;
07C9 2C       INC    L            ;
07CA 268B     LD     H,#8B        ;
07CC 7E       LD     A,(HL)       ;
07CD 4F       LD     C,A          ;
07CE A7       AND    A            ;
07CF CACA08   JP     Z,$08CA      ;
07D2 2D       DEC    L            ;
07D3 FE0B     CP     #0B          ;
07D5 283E     JR     Z,$815       ;
07D7 08       EX     AF,A'F'      ;
07D8 2044     JR     NZ,$81E      ;
07DA 08       EX     AF,A'F'      ;
07DB 2692     LD     H,#92        ;
07DD 3681     LD     (HL),#81     ;
07DF 3A2898   LD     A,($9828)    ;
07E2 95       SUB    L            ;
07E3 2007     JR     NZ,$7EC      ;
07E5 322B98   LD     ($982B),A    ;
07E8 3C       INC    A            ;
07E9 322898   LD     ($9828),A    ;
07EC E5       PUSH   HL           ;
07ED 79       LD     A,C          ;
07EE FE07     CP     #07          ;
07F0 2003     JR     NZ,$7F5      ;
07F2 3D       DEC    A            ;
07F3 1803     JR     $7F8         ;
07F5 3D       DEC    A            ;
07F6 E603     AND    #03          ;
07F8 21A19A   LD     HL,$9AA1     ;
07FB D7       RST    10H          ;
07FC 3601     LD     (HL),#01     ;
07FE 79       LD     A,C          ;
07FF FE07     CP     #07          ;
0801 2005     JR     NZ,$808      ;
0803 212B98   LD     HL,$982B     ;
0806 3600     LD     (HL),#00     ;
0808 219092   LD     HL,$9290     ;
080B D7       RST    10H          ;
080C 34       INC    (HL)         ;
080D 08       EX     AF,A'F'      ;
080E 2801     JR     Z,$811       ;
0810 34       INC    (HL)         ;
0811 E1       POP    HL           ;
0812 C3B407   JP     $07B4        ;
;
0815 2693     LD     H,#93        ; Putting a return here crashes the game at lev 3
0817 3600     LD     (HL),#00     ;
0819 2688     LD     H,#88        ;
081B 3680     LD     (HL),#80     ; Doesn't seem to be called anywhere
081D C9       RET                 ;
;
081E 2688     LD     H,#88        ;
0820 E5       PUSH   HL           ;
0821 08       EX     AF,A'F'      ;
0822 2C       INC    L            ;
0823 7E       LD     A,(HL)       ;
0824 2691     LD     H,#91        ;
0826 C613     ADD    A,#13        ;
0828 6F       LD     L,A          ;
0829 3600     LD     (HL),#00     ;
082B 218892   LD     HL,$9288     ;
082E 34       INC    (HL)         ;
082F 21A892   LD     HL,$92A8     ;
0832 35       DEC    (HL)         ;
0833 E1       POP    HL           ;
0834 2013     JR     NZ,$849      ;
0836 2692     LD     H,#92        ;
0838 3A8592   LD     A,($9285)    ;
083B 77       LD     (HL),A       ;
083C 3A8492   LD     A,($9284)    ;
083F 67       LD     H,A          ;
0840 3A9F92   LD     A,($929F)    ;
0843 84       ADD    A,H          ;
0844 329F92   LD     ($929F),A    ;
0847 1896     JR     $7DF         ;
0849 79       LD     A,C          ;
084A FE07     CP     #07          ;
084C 2004     JR     NZ,$852      ;
084E 16B8     LD     D,#B8        ;
0850 185E     JR     $8B0         ;
0852 3A2D98   LD     A,($982D)    ;
0855 BD       CP     L            ;
0856 CAB608   JP     Z,$08B6      ;
0859 7D       LD     A,L          ;
085A E638     AND    #38          ;
085C FE38     CP     #38          ;
085E CAB608   JP     Z,$08B6      ;
0861 79       LD     A,C          ;
0862 FE01     CP     #01          ;
0864 C2DB07   JP     NZ,$07DB     ;
0867 D5       PUSH   DE           ;
0868 7D       LD     A,L          ;
0869 E607     AND    #07          ;
086B 5F       LD     E,A          ;
086C 1688     LD     D,#88        ;
086E 1A       LD     A,(DE)       ;
086F FE09     CP     #09          ;
0871 2026     JR     NZ,$899      ;
0873 E5       PUSH   HL           ;
0874 EB       EX     DE,HL        ;
0875 2C       INC    L            ;
0876 7E       LD     A,(HL)       ;
0877 C613     ADD    A,#13        ;
0879 5F       LD     E,A          ;
087A 1691     LD     D,#91        ;
087C AF       XOR    A            ;
087D 12       LD     (DE),A       ;
087E 268B     LD     H,#8B        ;
0880 3609     LD     (HL),#09     ;
0882 2D       DEC    L            ;
0883 7D       LD     A,L          ;
0884 322898   LD     ($9828),A    ;
0887 2688     LD     H,#88        ;
0889 AF       XOR    A            ;
088A 77       LD     (HL),A       ;
088B 328B92   LD     ($928B),A    ;
088E 3C       INC    A            ;
088F 321D90   LD     ($901D),A    ;
0892 328D92   LD     ($928D),A    ;
0895 32B19A   LD     ($9AB1),A    ;
0898 E1       POP    HL           ;
0899 D1       POP    DE           ;
089A E5       PUSH   HL           ;
089B 3E06     LD     A,#06        ;
089D 32AD92   LD     ($92AD),A    ;
08A0 7D       LD     A,L          ;
08A1 E607     AND    #07          ;
08A3 213098   LD     HL,$9830     ;
08A6 D7       RST    10H          ;
08A7 7E       LD     A,(HL)       ;
08A8 2C       INC    L            ;
08A9 56       LD     D,(HL)       ;
08AA 219F92   LD     HL,$929F     ;
08AD 86       ADD    A,(HL)       ;
08AE 77       LD     (HL),A       ;
08AF E1       POP    HL           ;
08B0 2692     LD     H,#92        ;
08B2 72       LD     (HL),D       ;
08B3 C3DF07   JP     $07DF        ;
08B6 E5       PUSH   HL           ;
08B7 21B099   LD     HL,$99B0     ;
08BA 35       DEC    (HL)         ;
08BB E1       POP    HL           ;
08BC C2DB07   JP     NZ,$07DB     ;
08BF 3AB299   LD     A,($99B2)    ;
08C2 57       LD     D,A          ;
08C3 3AB199   LD     A,($99B1)    ;
08C6 E5       PUSH   HL           ;
08C7 C3AA08   JP     $08AA        ;
08CA 3C       INC    A            ;
08CB 77       LD     (HL),A       ;
08CC 32A49A   LD     ($9AA4),A    ;
08CF 2D       DEC    L            ;
08D0 C3B407   JP     $07B4        ;

;================================================================
; Command 2: Process All Enemies
08D3 DD210091 LD     IX,$9100     ; Bee space
08D7 3E0C     LD     A,#0C        ; 12 to do
08D9 328992   LD     ($9289),A    ; Set counter
08DC 218692   LD     HL,$9286     ; Move (9286) ...
08DF 7E       LD     A,(HL)       ; ... to (9287) ...
08E0 3600     LD     (HL),#00     ; ... and ...
08E2 23       INC    HL           ; ... clear ...
08E3 77       LD     (HL),A       ; ... 9286.
; 
08E4 DDCB1346 BIT    0,(IX+#13)   ; This bee active?
08E8 CAFA0D   JP     Z,$0DFA      ; No ... next bee
08EB 218692   LD     HL,$9286     ;
08EE 34       INC    (HL)         ;
08EF DD6E10   LD     L,(IX+#10)   ;
08F2 2688     LD     H,#88        ;
08F4 7E       LD     A,(HL)       ;
08F5 FE03     CP     #03          ;
08F7 2809     JR     Z,$902       ;
08F9 FE09     CP     #09          ;
08FB 2805     JR     Z,$902       ; 
08FD FE07     CP     #07          ;
08FF C2480E   JP     NZ,$0E48     ; Movement Routine 0: Not 7

0902 DD350D   DEC    (IX+#0D)     ;
0905 C2000C   JP     NZ,$0C00     ;
0908 DD6E08   LD     L,(IX+#08)   ; Get movement ...
090B DD6609   LD     H,(IX+#09)   ; ... command byte
090E 7E       LD     A,(HL)       ; Movement routine
090F FEEF     CP     #EF          ; CPL(EF) = 00010000
0911 DAD70B   JP     C,$0BD7      ; Not in table - jump into routine 5
0914 E5       PUSH   HL           ; Save descriptor on stack
0915 2F       CPL                 ; Complement
0916 212009   LD     HL,$0920     ; Movement routines
0919 CF       RST    08H          ; Get offset
091A 7E       LD     A,(HL)       ; Put ...
091B 23       INC    HL           ; ... routine ...
091C 66       LD     H,(HL)       ; ... pointer ...
091D 6F       LD     L,A          ; ... in HL.
091E E3       EX     (SP),HL      ; Put routine on the stack
091F C9       RET                 ; Continue with movement routine

; Movement routines
0920 480E  0: (Code does little.) ?
0922 110B  1: Blue Bees Attack Pattern
0924 410B  2:
0926 490B  3:
0928 9B0A  4: Keeps ships from leaving initial circle to formation
092A CC0B  5: Keeps attack pattern from returning to formation
092C 5A0B  6: "
092E 820B  7: Keeps pick-up bee from returning to formation
0930 930B  8: Something strange in the very first fly-on
0932 A30B  9: Something strange late in a wave
0934 4209  A: CHECK THIS OUT -- freezes blue bees after "cheat bee's" first dive
0936 500A  B: Pickers caught in circle at top
0938 FE09  C: Red bee caught in large circle
093A 7B09  D: Split bee into specail bees
093C 6809  E: ?
093E 5509  F: Initial wave caught in initial circle
0940 4E09 10: ?

; Move command A
0942 DD5E10   LD     E,(IX+#10)   ;
0945 1688     LD     D,#88        ;
0947 3E03     LD     A,#03        ;
0949 12       LD     (DE),A       ;
094A 23       INC    HL           ;
094B C30E09   JP     $090E        ;

; Movement Routine 10
094E 3AC999   LD     A,($99C9)    ;
0951 A7       AND    A            ;
0952 C35909   JP     $0959        ;

; Movement Routine F
0955 3AC899   LD     A,($99C8)    ;
0958 A7       AND    A            ;
0959 2808     JR     Z,$963       ;
095B 23       INC    HL           ;
095C 7E       LD     A,(HL)       ;
095D 23       INC    HL           ;
095E 66       LD     H,(HL)       ;
095F 6F       LD     L,A          ;
0960 C3870B   JP     $0B87        ;
0963 23       INC    HL           ;
0964 23       INC    HL           ;
0965 C3860B   JP     $0B86        ;

; Movement Routine E
0968 DD5E10   LD     E,(IX+#10)   ;
096B 1601     LD     D,#01        ;
096D 1A       LD     A,(DE)       ;
096E 5F       LD     E,A          ;
096F 1699     LD     D,#99        ;
0971 1C       INC    E            ;
0972 1A       LD     A,(DE)       ;
0973 C620     ADD    A,#20        ; Add 20
0975 DD7701   LD     (IX+#01),A   ; Y coordinate
0978 C3860B   JP     $0B86        ;

; Movement Routine D (Split blue bee into special bees)
097B E5       PUSH   HL           ;
097C DD5E10   LD     E,(IX+#10)   ;
097F 213888   LD     HL,$8838     ;
0982 0604     LD     B,#04        ; 4 to do
0984 7E       LD     A,(HL)       ; Get flag
0985 07       RLCA                ; Left bit into C
0986 3807     JR     C,$98F       ; Slot is empty - so something
0988 2C       INC    L            ; Find ...
0989 2C       INC    L            ; ... next slot
098A 10F8     DJNZ   $984         ; Look at all
098C C3FA09   JP     $09FA        ; No slots found. Can't do this.
098F 268B     LD     H,#8B        ;
0991 54       LD     D,H          ;
0992 1A       LD     A,(DE)       ;
0993 77       LD     (HL),A       ;
0994 2C       INC    L            ;
0995 1C       INC    E            ;
0996 1A       LD     A,(DE)       ;
0997 77       LD     (HL),A       ;
0998 2D       DEC    L            ;
0999 7D       LD     A,L          ;
099A 08       EX     AF,A'F'      ;
099B 21EF91   LD     HL,$91EF     ;
099E 11ECFF   LD     DE,$FFEC     ; -0x14?
09A1 060C     LD     B,#0C        ; 12 bees
09A3 7E       LD     A,(HL)       ; Check the bee
09A4 E601     AND    #01          ; Good one ...
09A6 2806     JR     Z,$9AE       ; ... use it
09A8 19       ADD    HL,DE        ; Back up a bee
09A9 10F8     DJNZ   $9A3         ; Do all bees
09AB C3FA09   JP     $09FA        ; Next bee
09AE 19       ADD    HL,DE        ; Back up a bee
09AF 23       INC    HL           ;
09B0 DD7E00   LD     A,(IX+#00)   ; X Coordinate
09B3 DD       ???                 ;
09B4 5D       LD     E,L          ;
09B5 DD       ???                 ;
09B6 54       LD     D,H          ;
09B7 EB       EX     DE,HL        ;
09B8 FD       ???                 ;
09B9 6B       LD     L,E          ;
09BA FD       ???                 ;
09BB 62       ???                 ;
09BC 010600   LD     BC,$0006     ;
09BF EDB0     LDIR                ;
09C1 0E06     LD     C,#06        ;
09C3 09       ADD    HL,BC        ;
09C4 EB       EX     DE,HL        ;
09C5 19       ADD    HL,DE        ;
09C6 EB       EX     DE,HL        ;
09C7 0E04     LD     C,#04        ;
09C9 EDB0     LDIR                ;
09CB DD7E13   LD     A,(IX+#13)   ;
09CE FD7713   LD     (IY+#13),A   ;
09D1 E1       POP    HL           ;
09D2 23       INC    HL           ;
09D3 7E       LD     A,(HL)       ;
09D4 FD7708   LD     (IY+#08),A   ;
09D7 23       INC    HL           ;
09D8 7E       LD     A,(HL)       ;
09D9 FD7709   LD     (IY+#09),A   ;
09DC FD360A01 LD     (IY+#0A),#01 ;
09E0 FD360B02 LD     (IY+#0B),#02 ;
09E4 FD360D01 LD     (IY+#0D),#01  ;
09E8 08       EX     AF,A'F'      ;
09E9 FD7710   LD     (IY+#10),A   ;
09EC 5F       LD     E,A          ;
09ED 1688     LD     D,#88        ;
09EF 3E09     LD     A,#09        ;
09F1 12       LD     (DE),A       ;
09F2 1C       INC    E            ;
09F3 FD       ???                 ;
09F4 7D       LD     A,L          ;
09F5 12       LD     (DE),A       ;
09F6 23       INC    HL           ;
09F7 C30E09   JP     $090E        ;
09FA E1       POP    HL           ;
09FB C39D0B   JP     $0B9D        ;

; Movement Routine C
09FE E5       PUSH   HL           ;
09FF EB       EX     DE,HL        ;
0A00 3A1592   LD     A,($9215)    ;
0A03 4F       LD     C,A          ;
0A04 3A6293   LD     A,($9362)    ;
0A07 FE1E     CP     #1E          ;
0A09 3002     JR     NZ,$A0D      ;
0A0B 3E1E     LD     A,#1E        ;
0A0D FED1     CP     #D1          ;
0A0F 3802     JR     C,$A13       ;
0A11 3ED1     LD     A,#D1        ;
0A13 CB41     BIT    0,C          ;
0A15 2804     JR     Z,$A1B       ;
0A17 C60E     ADD    A,#0E        ;
0A19 ED44     NEG                 ;
0A1B CB3F     SRL    A            ;
0A1D DD9603   SUB    (IX+#03)     ;
0A20 1F       RRA                 ;
0A21 DDCB137E BIT    7,(IX+#13)   ;
0A25 2802     JR     Z,$A29       ;
0A27 ED44     NEG                 ;
0A29 C618     ADD    A,#18        ;
0A2B F22F0A   JP     P,$0A2F      ;
0A2E AF       XOR    A            ;
0A2F FE30     CP     #30          ;
0A31 3802     JR     C,$A35       ;
0A33 3E2F     LD     A,#2F        ;
0A35 67       LD     H,A          ;
0A36 3E06     LD     A,#06        ;
0A38 CDA90E   CALL   $0EA9        ;
0A3B 7C       LD     A,H          ;
0A3C 3C       INC    A            ;
0A3D EB       EX     DE,HL        ;
0A3E D7       RST    10H          ;
0A3F 7E       LD     A,(HL)       ;
0A40 DD770D   LD     (IX+#0D),A   ;
0A43 E1       POP    HL           ;
0A44 3E09     LD     A,#09        ;
0A46 D7       RST    10H          ;
0A47 DD7508   LD     (IX+#08),L   ;
0A4A DD7409   LD     (IX+#09),H   ;
0A4D C3FA0B   JP     $0BFA        ;

; Movement Routine B
0A50 E5       PUSH   HL           ;
0A51 3A1592   LD     A,($9215)    ;
0A54 4F       LD     C,A          ;
0A55 3A6293   LD     A,($9362)    ;
0A58 C603     ADD    A,#03        ;
0A5A E6F8     AND    #F8          ;
0A5C 3C       INC    A            ;
0A5D FE29     CP     #29          ;
0A5F 3002     JR     NZ,$A63      ;
0A61 3E29     LD     A,#29        ;
0A63 FECA     CP     #CA          ;
0A65 3802     JR     C,$A69       ;
0A67 3EC9     LD     A,#C9        ;
0A69 CB41     BIT    0,C          ;
0A6B 2803     JR     Z,$A70       ;
0A6D C60D     ADD    A,#0D        ;
0A6F 2F       CPL                 ;
0A70 328A92   LD     ($928A),A    ;
0A73 CB3F     SRL    A            ;
0A75 5F       LD     E,A          ;
0A76 1648     LD     D,#48        ;
0A78 DD6601   LD     H,(IX+#01)   ; Y coordinate
0A7B DD6E03   LD     L,(IX+#03)   ;
0A7E CD5A0E   CALL   $0E5A        ;
0A81 CB3C     SRL    H            ;
0A83 CB1D     RR     L            ;
0A85 DD7504   LD     (IX+#04),L   ;
0A88 DD7405   LD     (IX+#05),H   ;
0A8B AF       XOR    A            ;
0A8C 328B92   LD     ($928B),A    ;
0A8F 3C       INC    A            ;
0A90 321990   LD     ($9019),A    ;
0A93 DD       ???                 ;
0A94 7D       LD     A,L          ;
0A95 322998   LD     ($9829),A    ;
0A98 C30C0B   JP     $0B0C        ;

; Movement Routine 4
0A9B E5       PUSH   HL           ;
0A9C DD6E10   LD     L,(IX+#10)   ;
0A9F 2688     LD     H,#88        ;
0AA1 3609     LD     (HL),#09     ;
0AA3 2601     LD     H,#01        ;
0AA5 4E       LD     C,(HL)       ;
0AA6 2C       INC    L            ;
0AA7 6E       LD     L,(HL)       ;
0AA8 2699     LD     H,#99        ;
0AAA 46       LD     B,(HL)       ;
0AAB 2C       INC    L            ;
0AAC 5E       LD     E,(HL)       ;
0AAD 69       LD     L,C          ;
0AAE 4E       LD     C,(HL)       ;
0AAF 2C       INC    L            ;
0AB0 56       LD     D,(HL)       ;
0AB1 CB3B     SRL    E            ;
0AB3 D5       PUSH   DE           ;
0AB4 DD7011   LD     (IX+#11),B   ;
0AB7 DD7112   LD     (IX+#12),C   ;
0ABA 3A1592   LD     A,($9215)    ;
0ABD A7       AND    A            ;
0ABE 2808     JR     Z,$AC8       ;
0AC0 78       LD     A,B          ;
0AC1 ED44     NEG                 ;
0AC3 47       LD     B,A          ;
0AC4 79       LD     A,C          ;
0AC5 ED44     NEG                 ;
0AC7 4F       LD     C,A          ;
0AC8 DD6E00   LD     L,(IX+#00)   ; X Coordinate
0ACB DD6601   LD     H,(IX+#01)   ; Y Coordinate
0ACE 51       LD     D,C          ;
0ACF 1E00     LD     E,#00        ;
0AD1 CB2A     SRA    D            ;
0AD3 CB1B     RR     E            ;
0AD5 19       ADD    HL,DE        ;
0AD6 DD7500   LD     (IX+#00),L   ; New X coordinate
0AD9 DD7401   LD     (IX+#01),H   ; New Y coordiante
0ADC 5C       LD     E,H          ;
0ADD DD6E02   LD     L,(IX+#02)   ;
0AE0 DD6603   LD     H,(IX+#03)   ;
0AE3 0E00     LD     C,#00        ;
0AE5 CB28     SRA    B            ;
0AE7 CB19     RR     C            ;
0AE9 ED42     SBC    HL,BC        ;
0AEB DD7502   LD     (IX+#02),L   ;
0AEE DD7403   LD     (IX+#03),H   ;
0AF1 6C       LD     L,H          ;
0AF2 63       LD     H,E          ;
0AF3 4A       LD     C,D          ;
0AF4 D1       POP    DE           ;
0AF5 CD5A0E   CALL   $0E5A        ;
0AF8 CB3C     SRL    H            ;
0AFA CB1D     RR     L            ;
0AFC DD7504   LD     (IX+#04),L   ;
0AFF DD7405   LD     (IX+#05),H   ;
0B02 DD7206   LD     (IX+#06),D   ;
0B05 DD7307   LD     (IX+#07),E   ;
0B08 DDCB13F6 SET    6,(IX+#13)   ;
0B0C E1       POP    HL           ;
0B0D 23       INC    HL           ;
0B0E C30E09   JP     $090E        ;

; Movement Routine 1
0B11 E5       PUSH   HL           ;
0B12 EB       EX     DE,HL        ;
0B13 3A1592   LD     A,($9215)    ;
0B16 0F       RRCA                ;
0B17 DD4613   LD     B,(IX+#13)   ;
0B1A A8       XOR    B            ;
0B1B 07       RLCA                ;
0B1C 3AE293   LD     A,($93E2)    ;
0B1F 3C       INC    A            ;
0B20 3D       DEC    A            ;
0B21 2002     JR     NZ,$B25      ;
0B23 3E80     LD     A,#80        ;
0B25 3804     JR     C,$B2B       ;
0B27 ED44     NEG                 ;
0B29 C6F2     ADD    A,#F2        ;
0B2B C60E     ADD    A,#0E        ;
0B2D 67       LD     H,A          ;
0B2E 3E1E     LD     A,#1E        ;
0B30 CDA90E   CALL   $0EA9        ;
0B33 7C       LD     A,H          ;
0B34 EB       EX     DE,HL        ;
0B35 D7       RST    10H          ; HL+=A
0B36 7E       LD     A,(HL)       ;
0B37 DD770D   LD     (IX+#0D),A   ;
0B3A E1       POP    HL           ;
0B3B 3E09     LD     A,#09        ; Add ...
0B3D D7       RST    10H          ; ... 9 to HL
0B3E C3FA0B   JP     $0BFA        ;

; Movement Routine 2
0B41 23       INC    HL           ;
0B42 5E       LD     E,(HL)       ;
0B43 23       INC    HL           ;
0B44 56       LD     D,(HL)       ;
0B45 EB       EX     DE,HL        ;
0B46 C30E09   JP     $090E        ;

; Movement Routine 3
0B49 23       INC    HL           ;
0B4A 5E       LD     E,(HL)       ;
0B4B 23       INC    HL           ;
0B4C DD7306   LD     (IX+#06),E   ;
0B4F DD360700 LD     (IX+#07),#00 ;
0B53 DDCB13EE SET    5,(IX+#13)   ;
0B57 C3FA0B   JP     $0BFA        ;

; Movement Routine 6
0B5A 3A1592   LD     A,($9215)    ;
0B5D 4F       LD     C,A          ;
0B5E DD5E10   LD     E,(IX+#10)   ;
0B61 1C       INC    E            ;
0B62 1601     LD     D,#01        ;
0B64 1A       LD     A,(DE)       ;
0B65 5F       LD     E,A          ;
0B66 1698     LD     D,#98        ;
0B68 1A       LD     A,(DE)       ;
0B69 CB41     BIT    0,C          ;
0B6B 2804     JR     Z,$B71       ;
0B6D C60E     ADD    A,#0E        ;
0B6F ED44     NEG                 ;
0B71 CB3F     SRL    A            ;
0B73 DD7703   LD     (IX+#03),A   ;
0B76 3AAA92   LD     A,($92AA)    ;
0B79 A7       AND    A            ;
0B7A CA860B   JP     Z,$0B86      ;

0B7D 32B39A   LD     ($9AB3),A    ;
0B80 1804     JR     $B86         ;

; Movement Routine 7
0B82 DD36019C LD     (IX+#01),#9C ; Set Y coorinate to top of screen

0B86 23       INC    HL           ;
0B87 DD7508   LD     (IX+#08),L   ;
0B8A DD7409   LD     (IX+#09),H   ;
0B8D DD340D   INC    (IX+#0D)     ;
0B90 C3FA0D   JP     $0DFA        ; Next Bee

; Movement Routine 8
0B93 DD7E10   LD     A,(IX+#10)   ;
0B96 E638     AND    #38          ;
0B98 FE38     CP     #38          ;
0B9A CA410B   JP     Z,$0B41      ;
0B9D 23       INC    HL           ;
0B9E 23       INC    HL           ;
0B9F 23       INC    HL           ;
0BA0 C30E09   JP     $090E        ;

; Starts getting called when there are less than 6 bees alive.
; Cheat happens when this is called 255 times in a row.
; Movement Routine 9
0BA3 23       INC    HL           ;
0BA4 7E       LD     A,(HL)       ;
0BA5 DDCB137E BIT    7,(IX+#13)   ;
0BA9 2804     JR     Z,$BAF       ;
0BAB C680     ADD    A,#80        ;
0BAD ED44     NEG                 ;
0BAF 0E00     LD     C,#00        ;
0BB1 CB27     SLA    A            ;
0BB3 CB11     RL     C            ;
0BB5 CB27     SLA    A            ;
0BB7 CB11     RL     C            ;
0BB9 DD7704   LD     (IX+#04),A   ;
0BBC DD7105   LD     (IX+#05),C   ;
0BBF DD360E1E LD     (IX+#0E),#1E ; Hard set delay between shots.
0BC3 3AC892   LD     A,($92C8)    ; Reload shot ...
0BC6 DD770F   LD     (IX+#0F),A   ; ... delay shift from CPU1.
0BC9 C3860B   JP     $0B86        ; Continue

; Movement Routine 5
0BCC 3AAA92   LD     A,($92AA)    ;
0BCF 4F       LD     C,A          ;
0BD0 3A1D90   LD     A,($901D)    ;
0BD3 3D       DEC    A            ;
0BD4 A1       AND    C            ;
0BD5 18C3     JR     $B9A         ;
0BD7 4F       LD     C,A          ;
0BD8 E60F     AND    #0F          ;
0BDA DD770A   LD     (IX+#0A),A   ;
0BDD 79       LD     A,C          ;
0BDE 07       RLCA                ;
0BDF 07       RLCA                ;
0BE0 07       RLCA                ;
0BE1 07       RLCA                ;
0BE2 E60F     AND    #0F          ;
0BE4 23       INC    HL           ;
0BE5 DD770B   LD     (IX+#0B),A   ;
0BE8 7E       LD     A,(HL)       ;
0BE9 23       INC    HL           ;
0BEA DDCB137E BIT    7,(IX+#13)   ;
0BEE 2802     JR     Z,$BF2       ;
0BF0 ED44     NEG                 ;
0BF2 DD770C   LD     (IX+#0C),A   ;
0BF5 7E       LD     A,(HL)       ;
0BF6 23       INC    HL           ;
0BF7 DD770D   LD     (IX+#0D),A   ;
0BFA DD7508   LD     (IX+#08),L   ;
0BFD DD7409   LD     (IX+#09),H   ;
0C00 DDCB1376 BIT    6,(IX+#13)   ;
0C04 2822     JR     Z,$C28       ;
0C06 DD7E01   LD     A,(IX+#01)   ; Y coordinate
0C09 DD9606   SUB    (IX+#06)     ;
0C0C 2808     JR     Z,$C16       ;
0C0E F2130C   JP     P,$0C13      ;
0C11 ED44     NEG                 ;
0C13 3D       DEC    A            ;
0C14 2012     JR     NZ,$C28      ;
0C16 DD7E03   LD     A,(IX+#03)   ;
0C19 DD9607   SUB    (IX+#07)     ;
0C1C CA070E   JP     Z,$0E07      ;
0C1F F2240C   JP     P,$0C24      ;
0C22 ED44     NEG                 ;
0C24 3D       DEC    A            ;
0C25 CA070E   JP     Z,$0E07      ;
0C28 DDCB136E BIT    5,(IX+#13)   ;
0C2C 2813     JR     Z,$C41       ;
0C2E DD7E01   LD     A,(IX+#01)   ;  Y coordiante
0C31 DD9606   SUB    (IX+#06)     ;
0C34 2803     JR     Z,$C39       ;
0C36 3C       INC    A            ;
0C37 2008     JR     NZ,$C41      ;
0C39 DD360D01 LD     (IX+#0D),#01 ;
0C3D DDCB13AE RES    5,(IX+#13)   ;
0C41 DD460C   LD     B,(IX+#0C)   ;
0C44 DD7E04   LD     A,(IX+#04)   ;
0C47 5F       LD     E,A          ;
0C48 80       ADD    A,B          ;
0C49 DD7704   LD     (IX+#04),A   ;
0C4C DD5605   LD     D,(IX+#05)   ;
0C4F 2E01     LD     L,#01        ;
0C51 CB78     BIT    7,B          ;
0C53 2802     JR     Z,$C57       ;
0C55 2EFF     LD     L,#FF        ;
0C57 1F       RRA                 ;
0C58 A8       XOR    B            ;
0C59 7A       LD     A,D          ;
0C5A F25E0C   JP     P,$0C5E      ;
0C5D 85       ADD    A,L          ;
0C5E DD7705   LD     (IX+#05),A   ;
0C61 7B       LD     A,E          ;
0C62 4A       LD     C,D          ;
0C63 CB41     BIT    0,C          ;
0C65 2801     JR     Z,$C68       ;
0C67 2F       CPL                 ;
0C68 C615     ADD    A,#15        ;
0C6A 3004     JR     NZ,$C70      ;
0C6C 0606     LD     B,#06        ;
0C6E 180C     JR     $C7C         ;
0C70 CB3F     SRL    A            ;
0C72 47       LD     B,A          ;
0C73 CB38     SRL    B            ;
0C75 80       ADD    A,B          ;
0C76 07       RLCA                ;
0C77 07       RLCA                ;
0C78 07       RLCA                ;
0C79 E607     AND    #07          ;
0C7B 47       LD     B,A          ;
0C7C 268B     LD     H,#8B        ;
0C7E DD6E10   LD     L,(IX+#10)   ;
0C81 7E       LD     A,(HL)       ;
0C82 E6F8     AND    #F8          ;
0C84 B0       OR     B            ;
0C85 77       LD     (HL),A       ;
0C86 269B     LD     H,#9B        ;
0C88 79       LD     A,C          ;
0C89 CB09     RRC    C            ;
0C8B A9       XOR    C            ;
0C8C 3C       INC    A            ;
0C8D CB09     RRC    C            ;
0C8F 17       RLA                 ;
0C90 E603     AND    #03          ;
0C92 77       LD     (HL),A       ;
0C93 3AA092   LD     A,($92A0)    ;
0C96 E601     AND    #01          ;
0C98 2805     JR     Z,$C9F       ;
0C9A DD7E0A   LD     A,(IX+#0A)   ;
0C9D 1803     JR     $CA2         ;
0C9F DD7E0B   LD     A,(IX+#0B)   ;
0CA2 A7       AND    A            ;
0CA3 CAFE0C   JP     Z,$0CFE      ;
0CA6 E5       PUSH   HL           ;
0CA7 DDE5     PUSH   IX           ;
0CA9 E1       POP    HL           ;
0CAA 47       LD     B,A          ;
0CAB 7A       LD     A,D          ;
0CAC E603     AND    #03          ;
0CAE 57       LD     D,A          ;
0CAF CB03     RLC    E            ;
0CB1 CB12     RL     D            ;
0CB3 D5       PUSH   DE           ;
0CB4 AA       XOR    D            ;
0CB5 0F       RRCA                ;
0CB6 3802     JR     C,$CBA       ;
0CB8 2C       INC    L            ;
0CB9 2C       INC    L            ;
0CBA 14       INC    D            ;
0CBB CB52     BIT    2,D          ;
0CBD 78       LD     A,B          ;
0CBE 2802     JR     Z,$CC2       ;
0CC0 ED44     NEG                 ;
0CC2 4F       LD     C,A          ;
0CC3 CB29     SRA    C            ;
0CC5 3004     JR     NZ,$CCB      ;
0CC7 7E       LD     A,(HL)       ;
0CC8 C680     ADD    A,#80        ;
0CCA 77       LD     (HL),A       ;
0CCB 2C       INC    L            ;
0CCC 7E       LD     A,(HL)       ;
0CCD 89       ADC    A,C          ;
0CCE 77       LD     (HL),A       ;
0CCF 2D       DEC    L            ;
0CD0 EB       EX     DE,HL        ;
0CD1 7B       LD     A,E          ;
0CD2 EE02     XOR    #02          ;
0CD4 5F       LD     E,A          ;
0CD5 E1       POP    HL           ;
0CD6 CB3D     SRL    L            ;
0CD8 3004     JR     NZ,$CDE      ;
0CDA 7D       LD     A,L          ;
0CDB EE7F     XOR    #7F          ;
0CDD 6F       LD     L,A          ;
0CDE 78       LD     A,B          ;
0CDF 44       LD     B,H          ;
0CE0 2600     LD     H,#00        ;
0CE2 CD960E   CALL   $0E96        ; HL = HL * A
0CE5 78       LD     A,B          ;
0CE6 EE02     XOR    #02          ;
0CE8 3D       DEC    A            ;
0CE9 CB57     BIT    2,A          ;
0CEB 2808     JR     Z,$CF5       ;
0CED 44       LD     B,H          ;
0CEE 4D       LD     C,L          ;
0CEF 210000   LD     HL,$0000     ;
0CF2 A7       AND    A            ;
0CF3 ED42     SBC    HL,BC        ;
0CF5 EB       EX     DE,HL        ;
0CF6 7B       LD     A,E          ;
0CF7 86       ADD    A,(HL)       ;
0CF8 77       LD     (HL),A       ;
0CF9 2C       INC    L            ;
0CFA 7A       LD     A,D          ;
0CFB 8E       ADC    A,(HL)       ;
0CFC 77       LD     (HL),A       ;
0CFD E1       POP    HL           ;
0CFE 3A1592   LD     A,($9215)    ;
0D01 4F       LD     C,A          ;
0D02 2693     LD     H,#93        ;
0D04 DD5603   LD     D,(IX+#03)   ;
0D07 3E7F     LD     A,#7F        ;
0D09 DDBE02   CP     (IX+#02)     ;
0D0C 7A       LD     A,D          ;
0D0D 17       RLA                 ;
0D0E CB41     BIT    0,C          ;
0D10 2803     JR     Z,$D15       ;
0D12 C60D     ADD    A,#0D        ;
0D14 2F       CPL                 ;
0D15 DDCB1376 BIT    6,(IX+#13)   ;
0D19 2803     JR     Z,$D1E       ;
0D1B DD8611   ADD    A,(IX+#11)   ;
0D1E 77       LD     (HL),A       ;
0D1F 2C       INC    L            ;
0D20 DD4601   LD     B,(IX+#01)   ; Y coordinate
0D23 3E7F     LD     A,#7F        ;
0D25 DDBE00   CP     (IX+#00)     ; X coordinate
0D28 CB13     RL     E            ;
0D2A 78       LD     A,B          ;
0D2B CB41     BIT    0,C          ;
0D2D 2004     JR     NZ,$D33      ;
0D2F C64F     ADD    A,#4F        ;
0D31 2F       CPL                 ;
0D32 1D       DEC    E            ;
0D33 CB1B     RR     E            ;
0D35 17       RLA                 ;
0D36 CB13     RL     E            ;
0D38 DDCB1376 BIT    6,(IX+#13)   ;
0D3C 280D     JR     Z,$D4B       ;
0D3E DD8612   ADD    A,(IX+#12)   ;
0D41 57       LD     D,A          ;
0D42 1F       RRA                 ;
0D43 DDAE12   XOR    (IX+#12)     ;
0D46 07       RLCA                ;
0D47 7A       LD     A,D          ;
0D48 3001     JR     NZ,$D4B      ;
0D4A 1C       INC    E            ;
0D4B 77       LD     (HL),A       ;
0D4C 269B     LD     H,#9B        ;
0D4E CB0E     RRC    (HL)         ;
0D50 CB0B     RRC    E            ;
0D52 CB16     RL     (HL)         ;
0D54 DD350E   DEC    (IX+#0E)     ; Enough time ellapsed between shots?
0D57 C2FA0D   JP     NZ,$0DFA     ; No ... skip shooting.
0D5A DDCB0F3E SRL    (IX+#0F)     ; Another delay component ...
0D5E D2F40D   JP     NC,$0DF4     ; Too soon to drop another.
0D61 DD7E01   LD     A,(IX+#01)   ; Y coordinate
0D64 FE4C     CP     #4C          ; Don't fire if ...
0D66 DAF40D   JP     C,$0DF4      ; ... too close to the bottom.
0D69 3A1590   LD     A,($9015)    ; Fighter ...
0D6C A7       AND    A            ; ... capture sequence?
0D6D CAF40D   JP     Z,$0DF4      ; Yes ... no shooting
0D70 3AAD92   LD     A,($92AD)    ; After user ...
0D73 A7       AND    A            ; ... explosion?
0D74 C2F40D   JP     NZ,$0DF4     ; Yes ... skip shooting
0D77 EB       EX     DE,HL        ; Hold HL
0D78 216888   LD     HL,$8868     ; Shot pointers
0D7B 0608     LD     B,#08        ; 8 shots
0D7D 7E       LD     A,(HL)       ; Get shot info
0D7E FE80     CP     #80          ; Shot active?
0D80 2806     JR     Z,$D88       ; No -- use it
0D82 2C       INC    L            ; Try ...
0D83 2C       INC    L            ; ... next slot.
0D84 10F7     DJNZ   $D7D         ; Try all slots
0D86 186C     JR     $DF4         ; None available ... reload 0E for this bee and do next bee
;
; While the cheat is in effect, all shots end up not
; finding a slot. All slots are taken. The question is ...
; ... why and what does it have to do with Movement9?
;
; Initialize shot
0D88 3606     LD     (HL),#06     ; First byte no longer 0x80
0D8A 269B     LD     H,#9B        ;
0D8C 3601     LD     (HL),#01     ; 
0D8E E5       PUSH   HL           ; Hold the 88xx pointer
0D8F 2693     LD     H,#93        ; Shot coordinates
0D91 54       LD     D,H          ; Hold onto it
0D92 1D       DEC    E            ;
0D93 1A       LD     A,(DE)       ; Get bee coordinate
0D94 4F       LD     C,A          ;
0D95 77       LD     (HL),A       ; Set X
0D96 1C       INC    E            ;
0D97 2C       INC    L            ; Point to Y
0D98 1A       LD     A,(DE)       ;
0D99 47       LD     B,A          ;
0D9A 77       LD     (HL),A       ; Set Y
0D9B 269B     LD     H,#9B        ;
0D9D 54       LD     D,H          ;
0D9E 1A       LD     A,(DE)       ;
0D9F CB0E     RRC    (HL)         ;
0DA1 0F       RRCA                ;
0DA2 CB16     RL     (HL)         ;
0DA4 07       RLCA                ;
0DA5 CB18     RR     B            ;
0DA7 3A6293   LD     A,($9362)    ;
0DAA 91       SUB    C            ;
0DAB F5       PUSH   AF           ;
0DAC 3002     JR     NZ,$DB0      ;
0DAE ED44     NEG                 ;
0DB0 67       LD     H,A          ;
0DB1 3A1592   LD     A,($9215)    ;
0DB4 A7       AND    A            ;
0DB5 3E95     LD     A,#95        ;
0DB7 2802     JR     Z,$DBB       ;
0DB9 3E1C     LD     A,#1C        ;
0DBB 90       SUB    B            ;
0DBC 3002     JR     NZ,$DC0      ;
0DBE ED44     NEG                 ;
0DC0 CDA90E   CALL   $0EA9        ;
0DC3 44       LD     B,H          ;
0DC4 4D       LD     C,L          ;
0DC5 CB3C     SRL    H            ;
0DC7 CB1D     RR     L            ;
0DC9 CB3C     SRL    H            ;
0DCB CB1D     RR     L            ;
0DCD 09       ADD    HL,BC        ;
0DCE CB3C     SRL    H            ;
0DD0 CB1D     RR     L            ;
0DD2 CB3C     SRL    H            ;
0DD4 CB1D     RR     L            ;
0DD6 7C       LD     A,H          ;
0DD7 A7       AND    A            ;
0DD8 2005     JR     NZ,$DDF      ; Yes ... use max X velocity
0DDA 7D       LD     A,L          ; Get calculated X velocity
0DDB FE60     CP     #60          ; X velocity too great?
0DDD 3802     JR     C,$DE1       ; No -- keep it
0DDF 3E60     LD     A,#60        ; Set max X velocity
0DE1 47       LD     B,A          ; Hold in B
0DE2 F1       POP    AF           ;
0DE3 CB18     RR     B            ; X velocity divided by 2
0DE5 E1       POP    HL           ; Restore 88xx pointer
0DE6 7D       LD     A,L          ; Add 8 bytes ...
0DE7 C608     ADD    A,#08        ; ... to LSB ...
0DE9 E60F     AND    #0F          ; ... and Make it 0-15
0DEB 21B092   LD     HL,$92B0     ; Read by CPU1 while moving shots
0DEE 85       ADD    A,L          ; Add in new ...
0DEF 6F       LD     L,A          ; ... LSB offset.
0DF0 70       LD     (HL),B       ; Set X velocity
0DF1 23       INC    HL           ; Point to Y velocity
0DF2 3600     LD     (HL),#00     ; Set Y velocity to 0 (not used by CPU1)
0DF4 3AE292   LD     A,($92E2)    ; Reload ....
0DF7 DD770E   LD     (IX+#0E),A   ; ... shot delay counter.
; Next bee
0DFA 218992   LD     HL,$9289     ; Counter
0DFD 35       DEC    (HL)         ; All done?
0DFE C8       RET    Z            ; Yes ... out
0DFF 111400   LD     DE,$0014     ; Point to next ...
0E02 DD19     ADD    IX,DE        ; ... structure
0E04 C3E408   JP     $08E4        ; Continue with next bee.

0E07 AF       XOR    A            ; 0
0E08 DDCB1386 RES    0,(IX+#13)   ;
0E0C DD7700   LD     (IX+#00),A   ; 0 out X coordinate
0E0F DD7702   LD     (IX+#02),A   ;
0E12 2688     LD     H,#88        ;
0E14 DD6E10   LD     L,(IX+#10)   ;
0E17 3602     LD     (HL),#02     ;
0E19 268B     LD     H,#8B        ;
0E1B 2C       INC    L            ;
0E1C 7E       LD     A,(HL)       ;
0E1D 2D       DEC    L            ;
0E1E 3C       INC    A            ;
0E1F E607     AND    #07          ;
0E21 FE05     CP     #05          ;
0E23 3814     JR     C,$E39       ;
0E25 3A2E98   LD     A,($982E)    ;
0E28 4F       LD     C,A          ;
0E29 E6F8     AND    #F8          ;
0E2B C606     ADD    A,#06        ;
0E2D 77       LD     (HL),A       ;
0E2E 2C       INC    L            ;
0E2F 79       LD     A,C          ;
0E30 E607     AND    #07          ;
0E32 77       LD     (HL),A       ;
0E33 2D       DEC    L            ;
0E34 3E01     LD     A,#01        ;
0E36 322D98   LD     ($982D),A    ;
0E39 DD7E06   LD     A,(IX+#06)   ;
0E3C DD7701   LD     (IX+#01),A   ;  Y coordinate
0E3F DD7E07   LD     A,(IX+#07)   ;
0E42 DD7703   LD     (IX+#03),A   ;
0E45 C3FE0C   JP     $0CFE        ;

; Movement Routine 0 : Remove bee from active processing
0E48 2688     LD     H,#88        ;
0E4A DD6E10   LD     L,(IX+#10)   ;
0E4D 3680     LD     (HL),#80     ; ? Make sprite available ?
0E4F 2693     LD     H,#93        ;
0E51 3600     LD     (HL),#00     ;
0E53 DD361300 LD     (IX+#13),#00 ; Flag bee as inactive
0E57 C3FA0D   JP     $0DFA        ; Continue with next bee

; Math routines
0E5A C5       PUSH   BC           ;
0E5B D5       PUSH   DE           ;
0E5C 7B       LD     A,E          ;
0E5D 95       SUB    L            ;
0E5E 0600     LD     B,#00        ;
0E60 3004     JR     NC,$E66      ;
0E62 CBC0     SET    0,B          ;
0E64 ED44     NEG                 ;
0E66 4F       LD     C,A          ;
0E67 7A       LD     A,D          ;
0E68 94       SUB    H            ;
0E69 300A     JR     NC,$E75      ;
0E6B 57       LD     D,A          ;
0E6C 78       LD     A,B          ;
0E6D EE01     XOR    #01          ;
0E6F F602     OR     #02          ;
0E71 47       LD     B,A          ;
0E72 7A       LD     A,D          ;
0E73 ED44     NEG                 ;
0E75 B9       CP     C            ;
0E76 F5       PUSH   AF           ;
0E77 17       RLA                 ;
0E78 A8       XOR    B            ;
0E79 1F       RRA                 ;
0E7A 3F       CCF                 ;
0E7B CB10     RL     B            ;
0E7D F1       POP    AF           ;
0E7E 3003     JR     NC,$E83      ;
0E80 51       LD     D,C          ;
0E81 4F       LD     C,A          ;
0E82 7A       LD     A,D          ;
0E83 61       LD     H,C          ;
0E84 2E00     LD     L,#00        ;
0E86 CDA90E   CALL   $0EA9        ;
0E89 7C       LD     A,H          ;
0E8A A8       XOR    B            ;
0E8B E601     AND    #01          ;
0E8D 2803     JR     Z,$E92       ;
0E8F 7D       LD     A,L          ;
0E90 2F       CPL                 ;
0E91 6F       LD     L,A          ;
0E92 60       LD     H,B          ;
0E93 D1       POP    DE           ;
0E94 C1       POP    BC           ;
0E95 C9       RET                 ;

; HL = HL * A
0E96 D5       PUSH   DE           ; Hold DE
0E97 EB       EX     DE,HL        ; HL -> DE 
0E98 210000   LD     HL,$0000     ; Accumulator
0E9B CB3F     SRL    A            ; Is bit set
0E9D 3001     JR     NZ,$EA0      ; No ... skip adding
0E9F 19       ADD    HL,DE        ; Add the target
0EA0 CB23     SLA    E            ; Slide target to
0EA2 CB12     RL     D            ; ... the left
0EA4 A7       AND    A            ; All bits in A done?
0EA5 20F4     JR     NZ,$E9B      ; No ... keep looping
0EA7 D1       POP    DE           ; Restore DE
0EA8 C9       RET                 ; Done

; HL=HL/A (remainder in A)
0EA9 C5       PUSH   BC           ; Preserve B and C
0EAA 4F       LD     C,A          ; Hold original divisor
0EAB AF       XOR    A            ; Clear remainder (and carry)
0EAC 0611     LD     B,#11        ; Loop 17 times
0EAE 8F       ADC    A,A          ; Remainder left and add in cary
0EAF 380B     JR     C,$EBC       ; Overflow ...
0EB1 B9       CP     C            ; Remainder still less than divisor?
0EB2 3801     JR     C,$EB5       ; Yes
0EB4 91       SUB    C            ; Reset remainder, set bit in result
0EB5 3F       CCF                 ; Set bit for result
0EB6 ED6A     ADC    HL,HL        ; Shift result and add in new bit
0EB8 10F4     DJNZ   $EAE         ; Do all bits
0EBA C1       POP    BC           ; Restore B and C
0EBB C9       RET                 ; Done
0EBC 91       SUB    C            ; Back down remainder
0EBD 37       SCF                 ; Set C flag (fill result with 1's)
0EBE C3B60E   JP     $0EB6        ; Continue

0EC1 FF       RST    38H          ; Room for growth
0EC2 FF       RST    38H          ;
0EC3 FF       RST    38H          ;
0EC4 FF       RST    38H          ;
0EC5 FF       RST    38H          ;
0EC6 FF       RST    38H          ;
0EC7 FF       RST    38H          ;
0EC8 FF       RST    38H          ;
0EC9 FF       RST    38H          ;

; Command 7 : 
; Automatic Rack Advance (cheat mode) WHATEVER THAT MEANS
0ECA 3A0668   LD     A,($6806)    ; 2nd DSW Bit 6 
0ECD E602     AND    #02          ; Bit clear?
0ECF C0       RET    NZ           ; Normal operation
0ED0 21FF10   LD     HL,$10FF     ; Address beyond this ROM
0ED3 7E       LD     A,(HL)       ; Get byte
0ED4 2EDF     LD     L,#DF        ; From 10DF
0ED6 4E       LD     C,(HL)       ; Check for ...
0ED7 7E       LD     A,(HL)       ; ...
0ED8 A9       XOR    C            ; ...
0ED9 CB67     BIT    4,A          ; ... valid data
0EDB 2001     JR     NZ,$EDE      ; Yes ... use it
0EDD C7       RST    00H          ; Restart this CPU
0EDE 11F789   LD     DE,$89F7     ;
0EE1 21F689   LD     HL,$89F6     ;
0EE4 011300   LD     BC,$0013     ;
0EE7 EDB8     LDDR                ;
0EE9 DD21D50F LD     IX,$0FD5     ; Data at the end of ROM
0EED 1EE0     LD     E,#E0        ;
0EEF 010405   LD     BC,$0504     ;
;
0EF2 DD7E00   LD     A,(IX+#00)   ; 
0EF5 DD23     INC    IX           ;
0EF7 6F       LD     L,A          ;
0EF8 2610     LD     H,#10        ;
0EFA 7E       LD     A,(HL)       ;
0EFB 7B       LD     A,E          ;
0EFC 81       ADD    A,C          ;
0EFD 5F       LD     E,A          ;
0EFE 7E       LD     A,(HL)       ;
0EFF 12       LD     (DE),A       ;
0F00 10F0     DJNZ   $EF2         ;
;
0F02 0605     LD     B,#05        ;
0F04 21E489   LD     HL,$89E4     ;
0F07 7E       LD     A,(HL)       ;
0F08 2C       INC    L            ;
0F09 B6       OR     (HL)         ;
0F0A 2C       INC    L            ;
0F0B 2F       CPL                 ;
0F0C A6       AND    (HL)         ;
0F0D 2C       INC    L            ;
0F0E A6       AND    (HL)         ;
0F0F 2C       INC    L            ;
0F10 E60F     AND    #0F          ;
0F12 2004     JR     NZ,$F18      ;
0F14 10F1     DJNZ   $F07         ;
0F16 1840     JR     $F58         ;
0F18 05       DEC    B            ;
0F19 284F     JR     Z,$F6A       ;
0F1B 05       DEC    B            ;
0F1C CB20     SLA    B            ;
0F1E CB20     SLA    B            ;
0F20 0F       RRCA                ;
0F21 3803     JR     C,$F26       ;
0F23 04       INC    B            ;
0F24 18FA     JR     $F20         ;
0F26 3AE089   LD     A,($89E0)    ;
0F29 CB3F     SRL    A            ;
0F2B 5F       LD     E,A          ;
0F2C CB11     RL     C            ;
0F2E C6E1     ADD    A,#E1        ;
0F30 6F       LD     L,A          ;
0F31 2689     LD     H,#89        ;
0F33 7E       LD     A,(HL)       ;
0F34 CB41     BIT    0,C          ;
0F36 2804     JR     Z,$F3C       ;
0F38 07       RLCA                ;
0F39 07       RLCA                ;
0F3A 07       RLCA                ;
0F3B 07       RLCA                ;
0F3C E6F0     AND    #F0          ;
0F3E B0       OR     B            ;
0F3F CB41     BIT    0,C          ;
0F41 2804     JR     Z,$F47       ;
0F43 07       RLCA                ;
0F44 07       RLCA                ;
0F45 07       RLCA                ;
0F46 07       RLCA                ;
0F47 77       LD     (HL),A       ;
0F48 3AE089   LD     A,($89E0)    ;
0F4B A7       AND    A            ;
0F4C 2002     JR     NZ,$F50      ;
0F4E 3E02     LD     A,#02        ;
0F50 3D       DEC    A            ;
0F51 32E089   LD     ($89E0),A    ;
0F54 7B       LD     A,E          ;
0F55 A7       AND    A            ;
0F56 2809     JR     Z,$F61       ;
0F58 2AE289   LD     HL,($89E2)   ;
0F5B 7E       LD     A,(HL)       ;
0F5C 32E189   LD     ($89E1),A    ;
0F5F 1842     JR     $FA3         ;
0F61 2AE289   LD     HL,($89E2)   ;
0F64 3AE189   LD     A,($89E1)    ;
0F67 77       LD     (HL),A       ;
0F68 1839     JR     $FA3         ;
0F6A 4F       LD     C,A          ;
0F6B 21E089   LD     HL,$89E0     ;
0F6E CB41     BIT    0,C          ;
0F70 202D     JR     NZ,$F9F      ;
0F72 7E       LD     A,(HL)       ;
0F73 CB3F     SRL    A            ;
0F75 2813     JR     Z,$F8A       ;
0F77 CB59     BIT    3,C          ;
0F79 200C     JR     NZ,$F87      ;
0F7B 7E       LD     A,(HL)       ;
0F7C FE05     CP     #05          ;
0F7E 3003     JR     NZ,$F83      ;
0F80 34       INC    (HL)         ;
0F81 18D5     JR     $F58         ;
0F83 3605     LD     (HL),#05     ;
0F85 18D1     JR     $F58         ;
0F87 35       DEC    (HL)         ;
0F88 18CE     JR     $F58         ;
0F8A 2AE289   LD     HL,($89E2)   ;
0F8D CB59     BIT    3,C          ;
0F8F 2003     JR     NZ,$F94      ;
0F91 2B       DEC    HL           ;
0F92 1801     JR     $F95         ;
0F94 23       INC    HL           ;
0F95 22E289   LD     ($89E2),HL   ;
0F98 3E01     LD     A,#01        ;
0F9A 32E089   LD     ($89E0),A    ;
0F9D 18B9     JR     $F58         ;
0F9F 3605     LD     (HL),#05     ;
0FA1 18B5     JR     $F58         ;
0FA3 21CA83   LD     HL,$83CA     ;
0FA6 11E189   LD     DE,$89E1     ;
0FA9 0603     LD     B,#03        ; 3 bytes (6 nibbles)
0FAB 1A       LD     A,(DE)       ; Get nibble
0FAC 1C       INC    E            ; Next nibble
0FAD CDC60F   CALL   $0FC6        ; Separate nibbles
0FB0 10F9     DJNZ   $FAB         ; Do all bytes
0FB2 21CA87   LD     HL,$87CA     ;
0FB5 3AE089   LD     A,($89E0)    ;
0FB8 0606     LD     B,#06        ;
0FBA A7       AND    A            ;
0FBB 4F       LD     C,A          ;
0FBC 2802     JR     Z,$FC0       ;
0FBE 0E01     LD     C,#01        ;
0FC0 71       LD     (HL),C       ;
0FC1 2C       INC    L            ;
0FC2 3D       DEC    A            ;
0FC3 10F5     DJNZ   $FBA         ;
0FC5 C9       RET                 ;

; Store LSNibble to (HL) and MSNibble to (HL+1).
; HL=HL+2
0FC6 4F       LD     C,A          ;
0FC7 E60F     AND    #0F          ; Mask off upper 4 bits
0FC9 77       LD     (HL),A       ; Set byte
0FCA 2C       INC    L            ; Next pointer
0FCB 79       LD     A,C          ; Original
0FCC 07       RLCA                ; Move upper 4 bits ...
0FCD 07       RLCA                ; ...
0FCE 07       RLCA                ; ...
0FCF 07       RLCA                ; ... to lower 4 bits.
0FD0 E60F     AND    #0F          ; Mask off the upper
0FD2 77       LD     (HL),A       ; Store byte
0FD3 2C       INC    L            ; Next pointer
0FD4 C9       RET                 ; Out

; Looks like data from here down
0FD5 FD       ???                 ;
0FD6 FB       EI                  ;
0FD7 F7       RST    30H          ;
0FD8 EF       RST    28H          ;
0FD9 FE23     CP     #23          ;
0FDB 00       NOP                 ;
0FDC 1B       DEC    DE           ;
0FDD 23       INC    HL           ;
0FDE F0       RET    P            ;
0FDF 40       LD     B,B          ;
0FE0 23       INC    HL           ;
0FE1 00       NOP                 ;
0FE2 09       ADD    HL,BC        ;
0FE3 23       INC    HL           ;
0FE4 05       DEC    B            ;
0FE5 112300   LD     DE,$0023     ;
0FE8 1023     DJNZ   $100D        ;
0FEA 1040     DJNZ   $102C        ;
0FEC 23       INC    HL           ;
0FED 04       INC    B            ;
0FEE 30FF     JR     NZ,$FEF      ;
0FF0 23       INC    HL           ;
0FF1 02       LD     (BC),A       ;
0FF2 35       DEC    (HL)         ;
0FF3 23       INC    HL           ;
0FF4 08       EX     AF,A'F'      ;
0FF5 1023     DJNZ   $101A        ;
0FF7 103C     DJNZ   $1035        ;
0FF9 23       INC    HL           ;
0FFA 00       NOP                 ;
0FFB FF       RST    38H          ;
0FFC FF       RST    38H          ;
0FFD AC       XOR    H            ;
0FFE FF       RST    38H          ;
0FFF FF       RST    38H          ;

; CDs from here on