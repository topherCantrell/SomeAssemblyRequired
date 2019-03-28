; GALAGA CPU #1
;
;======================================================================
0000 3E10     LD     A,#10        ; Send command ...
0002 320071   LD     ($7100),A    ; ... to IO processor
0005 C3C402   JP     $02C4        ; Continue
;======================================================================
; Add A*2 to HL.
; If A=0, add 0x100 to HL
0008 87       ADD    A,A          ; A*2
0009 3005     JR     NZ,$10       ; Not a special
000B 24       INC    H            ; Else HL+=0x100
000C C31000   JP     $0010        ; Continue
000F FF       RST    38H          ; Filler
;======================================================================
; Add A to HL
0010 85       ADD    A,L          ; Add offset to HL ...
0011 6F       LD     L,A          ; ... LSB
0012 D0       RET    NC           ; No overflow 
0013 24       INC    H            ; Else add in overvlow
0014 C9       RET                 ; Out
0015 FF       RST    38H          ; Filler
0016 FF       RST    38H          ; Filler
0017 FF       RST    38H          ; Filler
;======================================================================
; Fill buffer with value in A HL = pointer B = length
0018 77       LD     (HL),A       ; Fill byte in buffer
0019 23       INC    HL           ; Next byte
001A 10FC     DJNZ   $18          ; Do until done
001C C9       RET                 ; Done
001D FF       RST    38H          ; Filler
001E FF       RST    38H          ; Filler
001F FF       RST    38H          ; Filler
;======================================================================
; Subtract 0x20 from DE
; Subtracting 20 moves to the right one character on the screen
0020 7B       LD     A,E          ; LSB
0021 D620     SUB    #20          ; Subtract 0x20
0023 5F       LD     E,A          ; Back to LSB
0024 D0       RET    NC           ; No overflow
0025 15       DEC    D            ; Else borrow
0026 C9       RET                 ; Done
0027 FF       RST    38H          ; Filler
;======================================================================
; Clear 0xF0 bytes starting at 9100 (bee space)
0028 210091   LD     HL,$9100     ; Bee space
002B 06F0     LD     B,#F0        ; Count
002D AF       XOR    A            ; Clear value
002E DF       RST    18H          ; Clear the bee buffer
002F C9       RET                 ; Done
;======================================================================
0030 37       SCF                 ; Set carry flag
0031 08       EX     AF,A'F'      ; Switch register bank
0032 C3B513   JP     $13B5        ;
0035 FF       RST    38H          ; Filler
0036 FF       RST    38H          ; Filler
0037 FF       RST    38H          ; Filler
;======================================================================
; Interrupt comes here
0038 C33702   JP     $0237        ; Revector interrupt

;======================================================================
003B E9       JP     (HL)         ; Indirection to HL

;======================================================================
; Clear 80 byte buffers at 9300 and 9B00
; Fill 8800 80 bytes with #80
; (All sprites available, all shot slots available)
003C 210093   LD     HL,$9300     ; Clear ...
003F 0680     LD     B,#80        ; ... 0x80 bytes ...
0041 AF       XOR    A            ; ... starting at ...
0042 DF       RST    18H          ; ... 9300
0043 21009B   LD     HL,$9B00     ;
0046 0680     LD     B,#80        ;
0048 DF       RST    18H          ;
0049 210088   LD     HL,$8800     ;
004C 3E80     LD     A,#80        ;
004E 0680     LD     B,#80        ;
0050 DF       RST    18H          ;
0051 C9       RET                 ;

; FFs till next

;======================================================================
; An interrupt comes here
0066 D9       EXX                 ; Switch to our bank
0067 EDA0     LDI                 ; Block load (backwards)
0069 EA8F00   JP     PE,$008F     ;
006C F5       PUSH   AF           ;
006D 210071   LD     HL,$7100     ;
0070 3610     LD     (HL),#10     ;
0072 3AB99A   LD     A,($9AB9)    ;
0075 A7       AND    A            ;
0076 2816     JR     Z,$8E        ;
0078 AF       XOR    A            ;
0079 32B99A   LD     ($9AB9),A    ;
007C 219200   LD     HL,$0092     ;
007F 110070   LD     DE,$7000     ;
0082 010400   LD     BC,$0004     ;
0085 D9       EXX                 ;
0086 3EA8     LD     A,#A8        ;
0088 320071   LD     ($7100),A    ;
008B F1       POP    AF           ;
008C ED45     RETN                ;
008E F1       POP    AF           ;
008F D9       EXX                 ; Switch bank back out 
0090 ED45     RETN                ;

0092 1010 ; # What in the world ...
0094 2020 ; # ... are these?

; Play functions called from ISR
0096 3A08 ;00:RET
0098 3B08 ;01:Draw player
009A B217 ;02:?
009C 0017 ;03:? 
009E 861A ;04:?
00A0 6A08 ;05:?
00A2 3A08 ;06:RET
00A3 3A08 ;07:RET
00A6 2429 ;08:No bees come out on screen
00A8 EC1D ;09:No bees come out on screen
00AA 9E2A ;0A:Explosion sequence for dead bee
00AC B91D ;0B:Bees freeze when shot and when entering block formation
00AE EB23 ;0C:Bees freak out when they leave their initial spin
00B0 AA1E ;0D:MOVE BEE FIRE
00B2 381D ;0E:?
00B4 4809 ;0F:Bees never leave the block formation
00B6 6B1B ;10:Start attack patterns 
00B8 B219 ;11:Pause game for "Fighter Captured" and handle fighter to top
00BA 7C1D ;12:?
00BC 3A08 ;13:RET
00BE 8B1F ;14:Move player left or right
00C0 0A1F ;15:Initiate player fire
00C2 3A08 ;16:RET
00C4 D81D ;17:?Display icon and STAGE message at start of wave?
00C6 3022 ;18:Initiate tractor beam
00C8 D921 ;19:?More of tractor beam?
00CA 3A08 ;1A:RET
00CC 3A08 ;1B:RET
00CE F220 ;1C:Fighter becomes "captured"
00D0 0020 ;1D:Coordinate free-fighter sequence
00D2 3A08 ;1E:RET
00D4 8A09 ;1F:Process inputs (coins)

;======================================================================
00D6 11ED83   LD     DE,$83ED     ;
00D9 21B902   LD     HL,$02B9     ;
00DC 010500   LD     BC,$0005     ;
00DF EDB0     LDIR                ;
00E1 1ECB     LD     E,#CB        ;
00E3 21EB00   LD     HL,$00EB     ;
00E6 0E11     LD     C,#11        ;
00E8 EDB0     LDIR                ;
00EA C9       RET                 ;

00EB 0E1B     LD     C,#1B        ; #
00ED 180C     JR     $FB          ; #
00EF 1C       INC    E            ; #
00F0 24       INC    H            ; #
00F1 111012   LD     DE,$1210     ; #
00F4 112424   LD     DE,$2424     ; #
00F7 24       INC    H            ; #
00F8 24       INC    H            ; #
00F9 19       ADD    HL,DE        ; #
00FA 1E01     LD     E,#01        ; #
00FC FF       RST    38H          ; #
00FD FF       RST    38H          ; #
00FE FF       RST    38H          ; #
00FF FF       RST    38H          ; #
;
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

0160 214080   LD     HL,$8040     ;
0163 114180   LD     DE,$8041     ;
0166 017F03   LD     BC,$037F     ;
0169 3624     LD     (HL),#24     ;
016B EDB0     LDIR                ;
016D 214084   LD     HL,$8440     ;
0170 114184   LD     DE,$8441     ;
0173 017F03   LD     BC,$037F     ;
0176 3600     LD     (HL),#00     ; 
0178 EDB0     LDIR                ;
017A 3E04     LD     A,#04        ;
017C 0620     LD     B,#20        ;
017E DF       RST    18H          ;
017F 3E4E     LD     A,#4E        ;
0181 0620     LD     B,#20        ;
0183 DF       RST    18H          ;
0184 C9       RET                 ;

0185 212198   LD     HL,$9821     ;
0188 34       INC    (HL)         ;
0189 7E       LD     A,(HL)       ;
018A 3C       INC    A            ;
018B E603     AND    #03          ;
018D 322598   LD     ($9825),A    ;
0190 2810     JR     Z,$1A2       ;
0192 0E06     LD     C,#06        ;
0194 F7       RST    30H          ;
0195 EB       EX     DE,HL        ;
0196 3A2198   LD     A,($9821)    ;
0199 6F       LD     L,A          ;
019A 2600     LD     H,#00        ;
019C CD660A   CALL   $0A66        ;
019F AF       XOR    A            ;
01A0 180A     JR     $1AC         ;
01A2 0E07     LD     C,#07        ;
01A4 F7       RST    30H          ;
01A5 3E01     LD     A,#01        ;
01A7 32AD9A   LD     ($9AAD),A    ;
01AA 3E08     LD     A,#08        ;
01AC 32A892   LD     ($92A8),A    ;
01AF 3E03     LD     A,#03        ;
01B1 32AE92   LD     ($92AE),A    ;
01B4 320B92   LD     ($920B),A    ; Three shots!
01B7 3A2598   LD     A,($9825)    ;
01BA A7       AND    A            ;
01BB 08       EX     AF,A'F'      ;
01BC CD7F11   CALL   $117F        ;
01BF 3AAE92   LD     A,($92AE)    ;
01C2 A7       AND    A            ;
01C3 20FA     JR     NZ,$1BF      ;
01C5 3E78     LD     A,#78        ;
01C7 32AE92   LD     ($92AE),A    ;
01CA CDA428   CALL   $28A4        ;
01CD CDB025   CALL   $25B0        ;
01D0 3E02     LD     A,#02        ;
01D2 32AC92   LD     ($92AC),A    ;
01D5 AF       XOR    A            ;
01D6 CDD512   CALL   $12D5        ;
01D9 AF       XOR    A            ;
01DA 0630     LD     B,#30        ;
01DC 210092   LD     HL,$9200     ;
01DF 77       LD     (HL),A       ;
01E0 2C       INC    L            ;
01E1 2C       INC    L            ;
01E2 10FB     DJNZ   $1DF         ;
01E4 320990   LD     ($9009),A    ; 0's
01E7 321090   LD     ($9010),A    ;
01EA 320490   LD     ($9004),A    ;
01ED 328892   LD     ($9288),A    ;
01F0 322C98   LD     ($982C),A    ;
01F3 324198   LD     ($9841),A    ;
01F6 324298   LD     ($9842),A    ;
01F9 322698   LD     ($9826),A    ;
01FC 32B099   LD     ($99B0),A    ;
01FF 322498   LD     ($9824),A    ;
0202 3C       INC    A            ;
0203 322D98   LD     ($982D),A    ; 1's
0206 326D98   LD     ($986D),A    ;
0209 322898   LD     ($9828),A    ;
020C 320B90   LD     ($900B),A    ;
020F 320890   LD     ($9008),A    ;
0212 320A90   LD     ($900A),A    ;
0215 CD002C   CALL   $2C00        ;
0218 213098   LD     HL,$9830     ;
021B 11B501   LD     DE,$01B5     ;
021E 0604     LD     B,#04        ;
0220 72       LD     (HL),D       ;
0221 2C       INC    L            ;
0222 73       LD     (HL),E       ;
0223 2C       INC    L            ;
0224 10FA     DJNZ   $220         ;
0226 3A0568   LD     A,($6805)    ;
0229 CB4F     BIT    1,A          ;
022B C0       RET    NZ           ;
022C 0E0B     LD     C,#0B        ;
022E 21B083   LD     HL,$83B0     ;
0231 CDB313   CALL   $13B3        ;
0234 C38501   JP     $0185        ;

; Interrupt vectors here
0237 F5       PUSH   AF           ; Save ...
0238 08       EX     AF,A'F'      ; ...
0239 F5       PUSH   AF           ; ...
023A C5       PUSH   BC           ; ...
023B D5       PUSH   DE           ; ...
023C E5       PUSH   HL           ; ...
023D DDE5     PUSH   IX           ; ...
023F FDE5     PUSH   IY           ; ... Everyting
0241 3A0468   LD     A,($6804)    ; Bit 5s
0244 57       LD     D,A          ; Hold it.
0245 3AA092   LD     A,($92A0)    ;
0248 E61C     AND    #1C          ;
024A 4F       LD     C,A          ;
024B 0F       RRCA                ;
024C A9       XOR    C            ;
024D E618     AND    #18          ;
024F 4F       LD     C,A          ;
0250 3ABE99   LD     A,($99BE)    ;
0253 CB4A     BIT    1,D          ; Rack test?
0255 2002     JR     NZ,$259      ; No
0257 3E07     LD     A,#07        ; If rack test, set all bits
0259 E607     AND    #07          ; Mask all but lower
025B B1       OR     C            ;
025C 0605     LD     B,#05        ;
025E 2100A0   LD     HL,$A000     ;
0261 77       LD     (HL),A       ;
0262 2C       INC    L            ;
0263 0F       RRCA                ;
0264 10FB     DJNZ   $261         ;
0266 323068   LD     ($6830),A    ; Watchdog reset
0269 AF       XOR    A            ; 0 will ...
026A 322068   LD     ($6820),A    ; ... disable interrupt
026D CB4A     BIT    1,D          ;
026F CAA802   JP     Z,$02A8      ;
0272 4F       LD     C,A          ;
0273 210090   LD     HL,$9000     ;
0276 79       LD     A,C          ;
0277 85       ADD    A,L          ;
0278 6F       LD     L,A          ;
0279 7E       LD     A,(HL)       ;
027A A7       AND    A            ;
027B 2003     JR     NZ,$280      ;
027D 0C       INC    C            ;
027E 18F3     JR     $273         ;
0280 47       LD     B,A          ;
0281 219600   LD     HL,$0096     ; Jump table
0284 79       LD     A,C          ;
0285 CB27     SLA    A            ;
0287 85       ADD    A,L          ;
0288 6F       LD     L,A          ;
0289 5E       LD     E,(HL)       ;
028A 23       INC    HL           ;
028B 56       LD     D,(HL)       ;
028C EB       EX     DE,HL        ;
028D C5       PUSH   BC           ;
028E CD3B00   CALL   $003B        ; Redirection to HL
0291 C1       POP    BC           ;
0292 78       LD     A,B          ;
0293 81       ADD    A,C          ;
0294 4F       LD     C,A          ;
0295 E6E0     AND    #E0          ;
0297 28DA     JR     Z,$273       ;
0299 210070   LD     HL,$7000     ;
029C 11B599   LD     DE,$99B5     ;
029F 010300   LD     BC,$0003     ;
02A2 D9       EXX                 ;
02A3 3E71     LD     A,#71        ;
02A5 320071   LD     ($7100),A    ;
02A8 3E01     LD     A,#01        ;
02AA 322068   LD     ($6820),A    ;
02AD FDE1     POP    IY           ; Pop ...
02AF DDE1     POP    IX           ; ...
02B1 E1       POP    HL           ; ...
02B2 D1       POP    DE           ; ...
02B3 C1       POP    BC           ; ...
02B4 F1       POP    AF           ; ...
02B5 08       EX     AF,A'F'      ; ...
02B6 F1       POP    AF           ; ... Everything
02B7 FB       EI                  ; Enable interrups
02B8 C9       RET                 ; Done

02B9 00       NOP                 ;
02BA 00       NOP                 ;
02BB 00       NOP                 ;
02BC 00       NOP                 ;
02BD 02       LD     (BC),A       ;
02BE 24       INC    H            ;
02BF 17       RLA                 ;
02C0 0A       LD     A,(BC)       ;
02C1 160C     LD     D,#0C        ;
02C3 18

; Initialization
02C4 ED56     IM     1            ;
02C6 AF       XOR    A            ;
02C7 21E099   LD     HL,$99E0     ;
02CA 0610     LD     B,#10        ;
02CC 77       LD     (HL),A       ;
02CD 23       INC    HL           ;
02CE 10FC     DJNZ   $2CC         ;
02D0 C36C33   JP     $336C        ;
02D3 31A090   LD     SP,$90A0     ;
02D6 AF       XOR    A            ;
02D7 21AC92   LD     HL,$92AC     ;
02DA 0604     LD     B,#04        ;
02DC DF       RST    18H          ;
02DD 21A09A   LD     HL,$9AA0     ;
02E0 0620     LD     B,#20        ;
02E2 DF       RST    18H          ;
02E3 3207A0   LD     ($A007),A    ;
02E6 321592   LD     ($9215),A    ;
02E9 32B999   LD     ($99B9),A    ;
02EC 3D       DEC    A            ;
02ED 21CA92   LD     HL,$92CA     ;
02F0 0610     LD     B,#10        ;
02F2 DF       RST    18H          ;
02F3 3E01     LD     A,#01        ;
02F5 322068   LD     ($6820),A    ;
02F8 21C083   LD     HL,$83C0     ;
02FB 0640     LD     B,#40        ;
02FD 3E24     LD     A,#24        ;
02FF DF       RST    18H          ;
0300 2680     LD     H,#80        ;
0302 0640     LD     B,#40        ;
0304 DF       RST    18H          ;
0305 210084   LD     HL,$8400     ;
0308 0640     LD     B,#40        ;
030A 3E03     LD     A,#03        ;
030C DF       RST    18H          ;
030D CD6001   CALL   $0160        ;
0310 11208A   LD     DE,$8A20     ;
0313 3E05     LD     A,#05        ;
0315 0600     LD     B,#00        ;
0317 21B902   LD     HL,$02B9     ;
031A 0E06     LD     C,#06        ;
031C EDB0     LDIR                ;
031E 3D       DEC    A            ;
031F 20F6     JR     NZ,$317      ;
0321 21BF02   LD     HL,$02BF     ;
0324 3E2A     LD     A,#2A        ;
0326 0605     LD     B,#05        ;
0328 0EFF     LD     C,#FF        ;
032A EDA0     LDI                 ;
032C 2B       DEC    HL           ;
032D 12       LD     (DE),A       ;
032E 1C       INC    E            ;
032F EDA0     LDI                 ;
0331 10F7     DJNZ   $32A         ;
0333 3E01     LD     A,#01        ;
0335 320192   LD     ($9201),A    ;
0338 2105A0   LD     HL,$A005     ;
033B 3600     LD     (HL),#00     ;
033D 77       LD     (HL),A       ;
033E CD3C00   CALL   $003C        ;
0341 CDD600   CALL   $00D6        ;
0344 CD4212   CALL   $1242        ;
0347 EF       RST    28H          ;
0348 3E20     LD     A,#20        ;
034A 321E90   LD     ($901E),A    ;
034D 3AB599   LD     A,($99B5)    ;
0350 32B899   LD     ($99B8),A    ;
0353 AF       XOR    A            ;
0354 321E90   LD     ($901E),A    ;
0357 322090   LD     ($9020),A    ;
035A AF       XOR    A            ;
035B 3207A0   LD     ($A007),A    ;
035E 321592   LD     ($9215),A    ;
0361 321290   LD     ($9012),A    ;
0364 0680     LD     B,#80        ;
0366 210092   LD     HL,$9200     ;
0369 DF       RST    18H          ;
036A 3E06     LD     A,#06        ;
036C 32BE99   LD     ($99BE),A    ;
036F EF       RST    28H          ;
0370 CD3C00   CALL   $003C        ;
0373 CD4212   CALL   $1242        ;
0376 3AB899   LD     A,($99B8)    ;
0379 A7       AND    A            ;
037A 3E01     LD     A,#01        ;
037C 2802     JR     Z,$380       ;
037E 3E02     LD     A,#02        ;
0380 320192   LD     ($9201),A    ;
0383 2018     JR     NZ,$39D      ;
0385 AF       XOR    A            ;
0386 320392   LD     ($9203),A    ;
0389 3C       INC    A            ;
038A 320290   LD     ($9002),A    ;
038D 3A0192   LD     A,($9201)    ;
0390 3D       DEC    A            ;
0391 28FA     JR     Z,$38D       ;
0393 CD4212   CALL   $1242        ;
0396 CD6001   CALL   $0160        ;
0399 EF       RST    28H          ;
039A CD3C00   CALL   $003C        ;
039D AF       XOR    A            ;
039E 320B92   LD     ($920B),A    ; Disables fire
03A1 0E13     LD     C,#13        ;
03A3 F7       RST    30H          ;
03A4 0E01     LD     C,#01        ;
03A6 F7       RST    30H          ;
03A7 215204   LD     HL,$0452     ;
03AA 228092   LD     ($9280),HL   ;
03AD 3A8099   LD     A,($9980)    ;
03B0 FEFF     CP     #FF          ;
03B2 2824     JR     Z,$3D8       ;
03B4 5F       LD     E,A          ;
03B5 0E1B     LD     C,#1B        ;
03B7 CD3D04   CALL   $043D        ;
03BA 3A8199   LD     A,($9981)    ;
03BD FEFF     CP     #FF          ;
03BF 2817     JR     Z,$3D8       ;
03C1 E67F     AND    #7F          ;
03C3 5F       LD     E,A          ;
03C4 0E1C     LD     C,#1C        ;
03C6 CD3D04   CALL   $043D        ;
03C9 3A8199   LD     A,($9981)    ;
03CC CB7F     BIT    7,A          ;
03CE 2008     JR     NZ,$3D8      ;
03D0 E67F     AND    #7F          ;
03D2 5F       LD     E,A          ;
03D3 0E1D     LD     C,#1D        ;
03D5 CD3D04   CALL   $043D        ;
03D8 3A0192   LD     A,($9201)    ;
03DB FE02     CP     #02          ;
03DD 28F9     JR     Z,$3D8       ;
03DF 32B79A   LD     ($9AB7),A    ;
03E2 CD6001   CALL   $0160        ;
03E5 CD3C00   CALL   $003C        ;
03E8 2105A0   LD     HL,$A005     ;
03EB 3600     LD     (HL),#00     ;
03ED 3601     LD     (HL),#01     ;
03EF 212098   LD     HL,$9820     ;
03F2 AF       XOR    A            ;
03F3 06A0     LD     B,#A0        ;
03F5 DF       RST    18H          ;
03F6 32B79A   LD     ($9AB7),A    ;
03F9 32B999   LD     ($99B9),A    ;
03FC 3C       INC    A            ;
03FD 32AB9A   LD     ($9AAB),A    ;
0400 321290   LD     ($9012),A    ;
0403 32F298   LD     ($98F2),A    ;
0406 CD6604   CALL   $0466        ;
0409 CD7B12   CALL   $127B        ;
040C 0E04     LD     C,#04        ;
040E F7       RST    30H          ;
040F 21AF92   LD     HL,$92AF     ;
0412 3608     LD     (HL),#08     ;
0414 7E       LD     A,(HL)       ;
0415 A7       AND    A            ;
0416 20FC     JR     NZ,$414      ;
0418 219092   LD     HL,$9290     ;
041B 0610     LD     B,#10        ;
041D DF       RST    18H          ;
041E 0630     LD     B,#30        ;
0420 21B098   LD     HL,$98B0     ;
0423 DF       RST    18H          ;
0424 21B083   LD     HL,$83B0     ;
0427 0E0B     LD     C,#0B        ;
0429 CDB313   CALL   $13B3        ;
042C 3E01     LD     A,#01        ;
042E 328098   LD     ($9880),A    ;
0431 3A8099   LD     A,($9980)    ;
0434 323E98   LD     ($983E),A    ;
0437 327E98   LD     ($987E),A    ;
043A C32206   JP     $0622        ;
043D F7       RST    30H          ;
043E EB       EX     DE,HL        ;
043F 7B       LD     A,E          ;
0440 C640     ADD    A,#40        ;
0442 5F       LD     E,A          ;
0443 2600     LD     H,#00        ;
0445 CD660A   CALL   $0A66        ;
0448 EB       EX     DE,HL        ;
0449 0E1E     LD     C,#1E        ;
044B CDB313   CALL   $13B3        ;
044E CD9E12   CALL   $129E        ;
0451 C9       RET                 ;
0452 00       NOP                 ;
0453 81       ADD    A,C          ;
0454 19       ADD    HL,DE        ;
0455 56       LD     D,(HL)       ;
0456 02       LD     (BC),A       ;
0457 81       ADD    A,C          ;
0458 19       ADD    HL,DE        ;
0459 62       ???                 ;
045A 04       INC    B            ;
045B 81       ADD    A,C          ;
045C 19       ADD    HL,DE        ;
045D 6E       LD     L,(HL)       ;
045E CD3B07   CALL   $073B        ;
0461 CD1E08   CALL   $081E        ;
0464 18F8     JR     $45E         ;
0466 3A0068   LD     A,($6800)    ;
0469 4F       LD     C,A          ;
046A 21B399   LD     HL,$99B3     ;
046D 3A8299   LD     A,($9982)    ;
0470 CB46     BIT    0,(HL)       ;
0472 2808     JR     Z,$47C       ;
0474 CB49     BIT    1,C          ;
0476 2004     JR     NZ,$47C      ;
0478 3C       INC    A            ;
0479 87       ADD    A,A          ;
047A 3600     LD     (HL),#00     ;
047C 322098   LD     ($9820),A    ;
047F 326098   LD     ($9860),A    ;
0482 11F883   LD     DE,$83F8     ;
0485 21A804   LD     HL,$04A8     ;
0488 CD9904   CALL   $0499        ;
048B 11E383   LD     DE,$83E3     ;
048E 21A804   LD     HL,$04A8     ;
0491 3AB399   LD     A,($99B3)    ;
0494 A7       AND    A            ;
0495 2002     JR     NZ,$499      ;
0497 23       INC    HL           ;
0498 23       INC    HL           ;
0499 0E07     LD     C,#07        ;
049B EDB0     LDIR                ;
049D 21AA04   LD     HL,$04AA     ;
04A0 11C383   LD     DE,$83C3     ;
04A3 0E04     LD     C,#04        ;
04A5 EDB0     LDIR                ;
04A7 C9       RET                 ;

04A8 00       NOP                 ; #
04A9 00       NOP                 ; #
04AA 24       INC    H            ; #
04AB 24       INC    H            ; #
04AC 24       INC    H            ; #
04AD 24       INC    H            ; #
04AE 24       INC    H            ; #
04AF 24       INC    H            ; #
04B0 24       INC    H            ; #
04B1 E1       POP    HL           ; #

04B2 21AF92   LD     HL,$92AF     ;
04B5 3604     LD     (HL),#04     ;
04B7 3A1D90   LD     A,($901D)    ;
04BA A7       AND    A            ;
04BB 2817     JR     Z,$4D4       ;
04BD AF       XOR    A            ;
04BE 321392   LD     ($9213),A    ;
04C1 3C       INC    A            ;
04C2 322590   LD     ($9025),A    ;
04C5 3AA792   LD     A,($92A7)    ;
04C8 A7       AND    A            ;
04C9 C25E04   JP     NZ,$045E     ;
04CC 3A1D90   LD     A,($901D)    ;
04CF A7       AND    A            ;
04D0 20FA     JR     NZ,$4CC      ;
04D2 181B     JR     $4EF         ;
04D4 7E       LD     A,(HL)       ;
04D5 A7       AND    A            ;
04D6 20DF     JR     NZ,$4B7      ;
04D8 CD3B07   CALL   $073B        ;
04DB 3AA792   LD     A,($92A7)    ;
04DE 324398   LD     ($9843),A    ;
04E1 4F       LD     C,A          ;
04E2 3A1392   LD     A,($9213)    ;
04E5 B1       OR     C            ;
04E6 200D     JR     NZ,$4F5      ;
04E8 3A2598   LD     A,($9825)    ;
04EB A7       AND    A            ;
04EC CA6306   JP     Z,$0663      ;
04EF CD8501   CALL   $0185        ;
04F2 C34506   JP     $0645        ;
04F5 212098   LD     HL,$9820     ;
04F8 7E       LD     A,(HL)       ;
04F9 35       DEC    (HL)         ;
04FA A7       AND    A            ;
04FB C28C05   JP     NZ,$058C     ;
04FE 3AB399   LD     A,($99B3)    ;
0501 A7       AND    A            ;
0502 280C     JR     Z,$510       ;
0504 214E82   LD     HL,$824E     ;
0507 3A4098   LD     A,($9840)    ;
050A C604     ADD    A,#04        ;
050C 4F       LD     C,A          ;
050D CDB313   CALL   $13B3        ;
0510 0E02     LD     C,#02        ;
0512 F7       RST    30H          ;
0513 CD3113   CALL   $1331        ;
0516 CD3113   CALL   $1331        ;
0519 211890   LD     HL,$9018     ;
051C 7E       LD     A,(HL)       ;
051D A7       AND    A            ;
051E 20FC     JR     NZ,$51C      ;
0520 EF       RST    28H          ;
0521 CD3C00   CALL   $003C        ;
0524 CD6001   CALL   $0160        ;
0527 0E15     LD     C,#15        ;
0529 F7       RST    30H          ;
052A 0E16     LD     C,#16        ;
052C F7       RST    30H          ;
052D 113281   LD     DE,$8132     ;
0530 2A4698   LD     HL,($9846)   ;
0533 CD660A   CALL   $0A66        ;
0536 0E18     LD     C,#18        ;
0538 F7       RST    30H          ;
0539 113581   LD     DE,$8135     ;
053C 2A4498   LD     HL,($9844)   ;
053F CD660A   CALL   $0A66        ;
0542 0E19     LD     C,#19        ;
0544 F7       RST    30H          ;
0545 CD850A   CALL   $0A85        ;
0548 EB       EX     DE,HL        ;
0549 0E1A     LD     C,#1A        ;
054B CDB313   CALL   $13B3        ;
054E 21AE92   LD     HL,$92AE     ;
0551 360E     LD     (HL),#0E     ;
0553 7E       LD     A,(HL)       ;
0554 A7       AND    A            ;
0555 20FC     JR     NZ,$553      ;
0557 CD6001   CALL   $0160        ;
055A CD0030   CALL   $3000        ;
055D AF       XOR    A            ;
055E 32B09A   LD     ($9AB0),A    ;
0561 21AC9A   LD     HL,$9AAC     ;
0564 11B69A   LD     DE,$9AB6     ;
0567 1A       LD     A,(DE)       ;
0568 46       LD     B,(HL)       ;
0569 B0       OR     B            ;
056A 2809     JR     Z,$575       ;
056C 04       INC    B            ;
056D 05       DEC    B            ;
056E 2802     JR     Z,$572       ;
0570 3601     LD     (HL),#01     ;
0572 76       HALT                ;
0573 18F2     JR     $567         ;
0575 CD6001   CALL   $0160        ;
0578 3AB399   LD     A,($99B3)    ;
057B A7       AND    A            ;
057C CAF106   JP     Z,$06F1      ; Halt
057F 3A6098   LD     A,($9860)    ;
0582 3C       INC    A            ;
0583 CAF106   JP     Z,$06F1      ; Halt
0586 3A1392   LD     A,($9213)    ;
0589 3D       DEC    A            ;
058A 2015     JR     NZ,$5A1      ;
058C 3AB399   LD     A,($99B3)    ;
058F A7       AND    A            ;
0590 CA1706   JP     Z,$0617      ;
0593 3A6098   LD     A,($9860)    ;
0596 3C       INC    A            ;
0597 CA2506   JP     Z,$0625      ;
059A 3A1392   LD     A,($9213)    ;
059D 3D       DEC    A            ;
059E C22506   JP     NZ,$0625     ;
05A1 3AA792   LD     A,($92A7)    ;
05A4 A7       AND    A            ;
05A5 2806     JR     Z,$5AD       ;
05A7 3A8792   LD     A,($9287)    ;
05AA A7       AND    A            ;
05AB 20FA     JR     NZ,$5A7      ;
05AD AF       XOR    A            ;
05AE 32B499   LD     ($99B4),A    ;
05B1 3C       INC    A            ;
05B2 210E90   LD     HL,$900E     ;
05B5 77       LD     (HL),A       ;
05B6 7E       LD     A,(HL)       ;
05B7 A7       AND    A            ;
05B8 20FC     JR     NZ,$5B6      ;
05BA 3AA09A   LD     A,($9AA0)    ;
05BD 324898   LD     ($9848),A    ;
05C0 3AAE92   LD     A,($92AE)    ;
05C3 323F98   LD     ($983F),A    ;
05C6 CD0C11   CALL   $110C        ;
05C9 CD002C   CALL   $2C00        ;
05CC 3A3F98   LD     A,($983F)    ;
05CF 32AE92   LD     ($92AE),A    ;
05D2 3A4898   LD     A,($9848)    ;
05D5 32A09A   LD     ($9AA0),A    ;
05D8 CD7E13   CALL   $137E        ;
05DB 3A4398   LD     A,($9843)    ;
05DE A7       AND    A            ;
05DF 2803     JR     Z,$5E4       ;
05E1 CDB025   CALL   $25B0        ;
05E4 3A4098   LD     A,($9840)    ;
05E7 4F       LD     C,A          ;
05E8 3A8399   LD     A,($9983)    ;
05EB A1       AND    C            ;
05EC 3207A0   LD     ($A007),A    ;
05EF 321592   LD     ($9215),A    ;
05F2 3E3F     LD     A,#3F        ;
05F4 CDD512   CALL   $12D5        ;
05F7 37       SCF                 ;
05F8 08       EX     AF,A'F'      ;
05F9 CD7F11   CALL   $117F        ;
05FC 3A4398   LD     A,($9843)    ;
05FF A7       AND    A            ;
0600 2820     JR     Z,$622       ;
0602 0E03     LD     C,#03        ;
0604 F7       RST    30H          ;
0605 3E80     LD     A,#80        ;
0607 32B499   LD     ($99B4),A    ;
060A 210E90   LD     HL,$900E     ;
060D 3E01     LD     A,#01        ;
060F 77       LD     (HL),A       ;
0610 7E       LD     A,(HL)       ;
0611 A7       AND    A            ;
0612 20FC     JR     NZ,$610      ;
0614 C32506   JP     $0625        ;
0617 3A4398   LD     A,($9843)    ;
061A A7       AND    A            ;
061B 2014     JR     NZ,$631      ;
061D CD8501   CALL   $0185        ;
0620 180F     JR     $631         ;
0622 CD8501   CALL   $0185        ;
0625 3A4098   LD     A,($9840)    ;
0628 C604     ADD    A,#04        ;
062A 4F       LD     C,A          ;
062B 216E82   LD     HL,$826E     ;
062E CDB313   CALL   $13B3        ;
0631 CD3D13   CALL   $133D        ;
0634 3AAE92   LD     A,($92AE)    ;
0637 C61E     ADD    A,#1E        ;
0639 FE78     CP     #78          ;
063B 3802     JR     C,$63F       ;
063D 3E78     LD     A,#78        ;
063F 32AE92   LD     ($92AE),A    ;
0642 CD3113   CALL   $1331        ;
0645 3E01     LD     A,#01        ;
0647 321590   LD     ($9015),A    ;
064A 322590   LD     ($9025),A    ;
064D 324298   LD     ($9842),A    ;
0650 0E0B     LD     C,#0B        ;
0652 21B083   LD     HL,$83B0     ;
0655 CDB313   CALL   $13B3        ;
0658 0E0B     LD     C,#0B        ;
065A 21AE83   LD     HL,$83AE     ;
065D CDB313   CALL   $13B3        ;
0660 C35E04   JP     $045E        ;
0663 3A8892   LD     A,($9288)    ;
0666 5F       LD     E,A          ;
0667 21AE9A   LD     HL,$9AAE     ;
066A FE28     CP     #28          ;
066C 2003     JR     NZ,$671      ;
066E 21B49A   LD     HL,$9AB4     ;
0671 3601     LD     (HL),#01     ;
0673 CD3113   CALL   $1331        ;
0676 0E08     LD     C,#08        ;
0678 F7       RST    30H          ;
0679 CD3113   CALL   $1331        ;
067C 6B       LD     L,E          ;
067D 2600     LD     H,#00        ;
067F 111081   LD     DE,$8110     ;
0682 CD660A   CALL   $0A66        ;
0685 CD3113   CALL   $1331        ;
0688 3A8892   LD     A,($9288)    ;
068B FE28     CP     #28          ;
068D 281D     JR     Z,$6AC       ;
068F 0E09     LD     C,#09        ;
0691 F7       RST    30H          ;
0692 CD3113   CALL   $1331        ;
0695 EB       EX     DE,HL        ;
0696 3A8892   LD     A,($9288)    ;
0699 A7       AND    A            ;
069A 280A     JR     Z,$6A6       ;
069C 6F       LD     L,A          ;
069D 2600     LD     H,#00        ;
069F CD660A   CALL   $0A66        ;
06A2 AF       XOR    A            ;
06A3 12       LD     (DE),A       ;
06A4 E7       RST    20H          ;
06A5 AF       XOR    A            ;
06A6 12       LD     (DE),A       ;
06A7 3A8892   LD     A,($9288)    ;
06AA 1821     JR     $6CD         ;
06AC 0607     LD     B,#07        ;
06AE 3AA092   LD     A,($92A0)    ;
06B1 E60F     AND    #0F          ;
06B3 20F9     JR     NZ,$6AE      ;
06B5 0E0B     LD     C,#0B        ;
06B7 CB40     BIT    0,B          ;
06B9 2801     JR     Z,$6BC       ;
06BB 0C       INC    C            ;
06BC C5       PUSH   BC           ;
06BD F7       RST    30H          ;
06BE C1       POP    BC           ;
06BF 3AA092   LD     A,($92A0)    ;
06C2 E60F     AND    #0F          ;
06C4 28F9     JR     Z,$6BF       ;
06C6 10E6     DJNZ   $6AE         ;
06C8 0E0D     LD     C,#0D        ;
06CA F7       RST    30H          ;
06CB 3E64     LD     A,#64        ;
06CD 219F92   LD     HL,$929F     ;
06D0 86       ADD    A,(HL)       ;
06D1 77       LD     (HL),A       ;
06D2 CD3B07   CALL   $073B        ;
06D5 CD3113   CALL   $1331        ;
06D8 CD3113   CALL   $1331        ;
06DB 21B083   LD     HL,$83B0     ;
06DE 0E0B     LD     C,#0B        ;
06E0 CDB313   CALL   $13B3        ;
06E3 21B383   LD     HL,$83B3     ;
06E6 0E0B     LD     C,#0B        ;
06E8 CDB313   CALL   $13B3        ;
06EB 0E0B     LD     C,#0B        ;
06ED F7       RST    30H          ;
06EE C3EF04   JP     $04EF        ;
06F1 76       HALT                ;

06F2 F3       DI                  ;
06F3 3A0071   LD     A,($7100)    ;
06F6 FE10     CP     #10          ;
06F8 20F9     JR     NZ,$6F3      ;
06FA 213807   LD     HL,$0738     ;
06FD 110070   LD     DE,$7000     ;
0700 010300   LD     BC,$0003     ;
0703 D9       EXX                 ;
0704 3E61     LD     A,#61        ;
0706 320071   LD     ($7100),A    ;
0709 76       HALT                ;
070A AF       XOR    A            ;
070B CD4F09   CALL   $094F        ;
070E FB       EI                  ;
070F AF       XOR    A            ;
0710 0620     LD     B,#20        ;
0712 21A09A   LD     HL,$9AA0     ;
0715 DF       RST    18H          ;
0716 11F983   LD     DE,$83F9     ;
0719 CD3A0A   CALL   $0A3A        ;
071C 11E483   LD     DE,$83E4     ;
071F CD3A0A   CALL   $0A3A        ;
0722 3AB399   LD     A,($99B3)    ;
0725 3C       INC    A            ;
0726 21E199   LD     HL,$99E1     ;
0729 86       ADD    A,(HL)       ;
072A 27       DAA                 ;
072B 77       LD     (HL),A       ;
072C D25A03   JP     NC,$035A     ;
072F 2B       DEC    HL           ;
0730 7E       LD     A,(HL)       ;
0731 C601     ADD    A,#01        ;
0733 27       DAA                 ;
0734 77       LD     (HL),A       ;
0735 C35A03   JP     $035A        ;
0738 02       LD     (BC),A       ;
0739 02       LD     (BC),A       ;
073A 02       LD     (BC),A       ;
073B 3A4098   LD     A,($9840)    ;
073E A7       AND    A            ;
073F 3EF9     LD     A,#F9        ;
0741 2802     JR     Z,$745       ;
0743 3EE4     LD     A,#E4        ;
0745 DD       ???                 ;
0746 6F       LD     L,A          ;
0747 0610     LD     B,#10        ;
0749 219092   LD     HL,$9290     ;
074C EB       EX     DE,HL        ;
074D 210D08   LD     HL,$080D     ;
0750 78       LD     A,B          ;
0751 D7       RST    10H          ;
0752 4E       LD     C,(HL)       ;
0753 EB       EX     DE,HL        ;
0754 7E       LD     A,(HL)       ;
0755 A7       AND    A            ;
0756 281D     JR     Z,$775       ;
0758 35       DEC    (HL)         ;
0759 EB       EX     DE,HL        ;
075A 2683     LD     H,#83        ;
075C DD       ???                 ;
075D 7D       LD     A,L          ;
075E 6F       LD     L,A          ;
075F 79       LD     A,C          ;
0760 E60F     AND    #0F          ;
0762 CDEB07   CALL   $07EB        ;
0765 DD       ???                 ;
0766 7D       LD     A,L          ;
0767 3C       INC    A            ;
0768 6F       LD     L,A          ;
0769 79       LD     A,C          ;
076A 07       RLCA                ;
076B 07       RLCA                ;
076C 07       RLCA                ;
076D 07       RLCA                ;
076E E60F     AND    #0F          ;
0770 CDEB07   CALL   $07EB        ;
0773 18DE     JR     $753         ;
0775 2C       INC    L            ;
0776 10D4     DJNZ   $74C         ;
0778 DD       ???                 ;
0779 7D       LD     A,L          ;
077A C604     ADD    A,#04        ;
077C 5F       LD     E,A          ;
077D 21F283   LD     HL,$83F2     ;
0780 1683     LD     D,#83        ;
0782 0606     LD     B,#06        ;
0784 1A       LD     A,(DE)       ;
0785 96       SUB    (HL)         ;
0786 C609     ADD    A,#09        ;
0788 FEE5     CP     #E5          ;
078A 300F     JR     NZ,$79B      ;
078C D60A     SUB    #0A          ;
078E FE09     CP     #09          ;
0790 3809     JR     C,$79B       ;
0792 3C       INC    A            ;
0793 200C     JR     NZ,$7A1      ;
0795 2D       DEC    L            ;
0796 1D       DEC    E            ;
0797 10EB     DJNZ   $784         ;
0799 1806     JR     $7A1         ;
079B 1A       LD     A,(DE)       ;
079C 77       LD     (HL),A       ;
079D 2D       DEC    L            ;
079E 1D       DEC    E            ;
079F 10FA     DJNZ   $79B         ;
07A1 DD       ???                 ;
07A2 7D       LD     A,L          ;
07A3 C604     ADD    A,#04        ;
07A5 6F       LD     L,A          ;
07A6 7E       LD     A,(HL)       ;
07A7 FE24     CP     #24          ;
07A9 2001     JR     NZ,$7AC      ;
07AB AF       XOR    A            ;
07AC E63F     AND    #3F          ;
07AE 07       RLCA                ;
07AF 4F       LD     C,A          ;
07B0 07       RLCA                ;
07B1 07       RLCA                ;
07B2 81       ADD    A,C          ;
07B3 4F       LD     C,A          ;
07B4 2D       DEC    L            ;
07B5 7E       LD     A,(HL)       ;
07B6 FE24     CP     #24          ;
07B8 2001     JR     NZ,$7BB      ;
07BA AF       XOR    A            ;
07BB 81       ADD    A,C          ;
07BC 213E98   LD     HL,$983E     ;
07BF BE       CP     (HL)         ;
07C0 C0       RET    NZ           ;
07C1 3A8199   LD     A,($9981)    ;
07C4 47       LD     B,A          ;
07C5 E67F     AND    #7F          ;
07C7 4F       LD     C,A          ;
07C8 7E       LD     A,(HL)       ;
07C9 B9       CP     C            ;
07CA 3003     JR     NZ,$7CF      ;
07CC 79       LD     A,C          ;
07CD 1801     JR     $7D0         ;
07CF 80       ADD    A,B          ;
07D0 77       LD     (HL),A       ;
07D1 32AA9A   LD     ($9AAA),A    ;
07D4 212098   LD     HL,$9820     ;
07D7 34       INC    (HL)         ;
07D8 CD7E13   CALL   $137E        ;
07DB 21EB99   LD     HL,$99EB     ;
07DE 7E       LD     A,(HL)       ;
07DF C601     ADD    A,#01        ;
07E1 27       DAA                 ;
07E2 77       LD     (HL),A       ;
07E3 D0       RET    NC           ;
07E4 2D       DEC    L            ;
07E5 7E       LD     A,(HL)       ;
07E6 C601     ADD    A,#01        ;
07E8 27       DAA                 ;
07E9 77       LD     (HL),A       ;
07EA C9       RET                 ;
07EB A7       AND    A            ;
07EC C8       RET    Z            ;
07ED 86       ADD    A,(HL)       ;
07EE FE24     CP     #24          ;
07F0 3802     JR     C,$7F4       ;
07F2 D624     SUB    #24          ;
07F4 FE0A     CP     #0A          ;
07F6 3002     JR     NZ,$7FA      ;
07F8 77       LD     (HL),A       ;
07F9 C9       RET                 ;
07FA D60A     SUB    #0A          ;
07FC 77       LD     (HL),A       ;
07FD 2C       INC    L            ;
07FE 7E       LD     A,(HL)       ;
07FF FE24     CP     #24          ;
0801 2001     JR     NZ,$804      ;
0803 AF       XOR    A            ;
0804 FE09     CP     #09          ;
0806 2803     JR     Z,$80B       ;
0808 3C       INC    A            ;
0809 77       LD     (HL),A       ;
080A C9       RET                 ;
080B AF       XOR    A            ;
080C 18EE     JR     $7FC         ;

080E 1000     DJNZ   $810         ;
0810 00       NOP                 ;
0811 00       NOP                 ;
0812 00       NOP                 ;
0813 00       NOP                 ;
0814 00       NOP                 ;
0815 00       NOP                 ;
0816 50       LD     D,B          ;
0817 08       EX     AF,A'F'      ;
0818 08       EX     AF,A'F'      ;
0819 08       EX     AF,A'F'      ;
081A 05       DEC    B            ;
081B 08       EX     AF,A'F'      ;
081C 15       DEC    D            ;
081D 00       NOP                 ;
081E 3A0890   LD     A,($9008)    ;
0821 47       LD     B,A          ;
0822 3AA792   LD     A,($92A7)    ;
0825 B0       OR     B            ;
0826 2006     JR     NZ,$82E      ;
0828 32A09A   LD     ($9AA0),A    ;
082B C3B104   JP     $04B1        ;
082E 3A1392   LD     A,($9213)    ;
0831 A7       AND    A            ;
0832 C8       RET    Z            ;
0833 AF       XOR    A            ;
0834 324298   LD     ($9842),A    ;
0837 C3B104   JP     $04B1        ;
083A C9       RET                 ;

;======================================================================
; PLAY COMMAND 01 (Draw Player)
;
083B 3E01     LD     A,#01        ; Flag CPU2 05EB to ...
083D 32D692   LD     ($92D6),A    ; ... continue
0840 21408B   LD     HL,$8B40     ;
0843 11C08B   LD     DE,$8BC0     ;
0846 014000   LD     BC,$0040     ;
0849 EDB0     LDIR                ;
084B 214093   LD     HL,$9340     ;
084E 11C093   LD     DE,$93C0     ;
0851 0E40     LD     C,#40        ;
0853 EDB0     LDIR                ;
0855 21409B   LD     HL,$9B40     ;
0858 11C09B   LD     DE,$9BC0     ;
085B 0E40     LD     C,#40        ;
085D EDB0     LDIR                ;
085F AF       XOR    A            ; Flag CPU2 05EB to ...
0860 32D692   LD     ($92D6),A    ; ... wait
0863 3AD792   LD     A,($92D7)    ; Wait for CPU2 05C1 ...
0866 3D       DEC    A            ; ... to go to ...
0867 28FA     JR     Z,$863       ; ... 01
0869 C9       RET                 ; ... Done

;======================================================================
; PLAY COMMAND 05 (??)
;
086A 3AAE92   LD     A,($92AE)    ;
086D 47       LD     B,A          ;
086E FE3C     CP     #3C          ;
0870 3006     JR     NZ,$878      ;
0872 3AC599   LD     A,($99C5)    ;
0875 32C499   LD     ($99C4),A    ;
0878 3AA792   LD     A,($92A7)    ;
087B 4F       LD     C,A          ;
087C 3AC099   LD     A,($99C0)    ;
087F 211C09   LD     HL,$091C     ;
0882 CDD108   CALL   $08D1        ;
0885 32C892   LD     ($92C8),A    ;
0888 3AAA92   LD     A,($92AA)    ;
088B A7       AND    A            ;
088C 280D     JR     Z,$89B       ;
088E 21C492   LD     HL,$92C4     ;
0891 3E02     LD     A,#02        ;
0893 0603     LD     B,#03        ;
0895 DF       RST    18H          ;
0896 AF       XOR    A            ;
0897 32A09A   LD     ($9AA0),A    ;
089A C9       RET                 ;
089B 3AC199   LD     A,($99C1)    ;
089E 213C09   LD     HL,$093C     ;
08A1 CDD108   CALL   $08D1        ;
08A4 32C492   LD     ($92C4),A    ;
08A7 3AC299   LD     A,($99C2)    ;
08AA 21E008   LD     HL,$08E0     ;
08AD CDC008   CALL   $08C0        ;
08B0 32C592   LD     ($92C5),A    ;
08B3 3AC399   LD     A,($99C3)    ;
08B6 21FE08   LD     HL,$08FE     ;
08B9 CDC008   CALL   $08C0        ;
08BC 32C692   LD     ($92C6),A    ;
08BF C9       RET                 ;
08C0 5F       LD     E,A          ;
08C1 CB27     SLA    A            ;
08C3 83       ADD    A,E          ;
08C4 D7       RST    10H          ;
08C5 78       LD     A,B          ;
08C6 FE28     CP     #28          ;
08C8 3001     JR     NZ,$8CB      ;
08CA 23       INC    HL           ;
08CB A7       AND    A            ;
08CC 2001     JR     NZ,$8CF      ;
08CE 23       INC    HL           ;
08CF 7E       LD     A,(HL)       ;
08D0 C9       RET                 ;
;
08D1 CB27     SLA    A            ;
08D3 CF       RST    08H          ;
08D4 EB       EX     DE,HL        ;
08D5 61       LD     H,C          ;
08D6 3E0A     LD     A,#0A        ;
08D8 CD6110   CALL   $1061        ;
08DB EB       EX     DE,HL        ;
08DC 7A       LD     A,D          ;
08DD D7       RST    10H          ;
08DE 7E       LD     A,(HL)       ;
08DF C9       RET                 ;
;
08E0 09       ADD    HL,BC        ; #
08E1 07       RLCA                ; #
08E2 05       DEC    B            ; #
08E3 08       EX     AF,A'F'      ; #
08E4 0604     LD     B,#04        ; #
08E6 07       RLCA                ; #
08E7 05       DEC    B            ; #
08E8 04       INC    B            ; #
08E9 0604     LD     B,#04        ; #
08EB 03       INC    BC           ; #
08EC 05       DEC    B            ; #
08ED 03       INC    BC           ; #
08EE 03       INC    BC           ; #
08EF 04       INC    B            ; #
08F0 03       INC    BC           ; #
08F1 03       INC    BC           ; #
08F2 04       INC    B            ; #
08F3 02       LD     (BC),A       ; #
08F4 02       LD     (BC),A       ; #
08F5 03       INC    BC           ; #
08F6 03       INC    BC           ; #
08F7 02       LD     (BC),A       ; #
08F8 03       INC    BC           ; #
08F9 02       LD     (BC),A       ; #
08FA 02       LD     (BC),A       ; #
08FB 02       LD     (BC),A       ; #
08FC 02       LD     (BC),A       ; #
08FD 02       LD     (BC),A       ; #
08FE 0605     LD     B,#05        ; #
0900 04       INC    B            ; #
0901 05       DEC    B            ; #
0902 04       INC    B            ; #
0903 03       INC    BC           ; #
0904 05       DEC    B            ; #
0905 03       INC    BC           ; #
0906 03       INC    BC           ; #
0907 04       INC    B            ; #
0908 03       INC    BC           ; #
0909 02       LD     (BC),A       ; #
090A 04       INC    B            ; #
090B 02       LD     (BC),A       ; #
090C 02       LD     (BC),A       ; #
090D 03       INC    BC           ; #
090E 03       INC    BC           ; #
090F 02       LD     (BC),A       ; #
0910 03       INC    BC           ; #
0911 02       LD     (BC),A       ; #
0912 010202   LD     BC,$0202     ; #
0915 010201   LD     BC,$0102     ; #
0918 010101   LD     BC,$0101     ; #
091B 010303   LD     BC,$0303     ; #
091E 010103   LD     BC,$0301     ; #
0921 03       INC    BC           ; #
0922 03       INC    BC           ; #
0923 010703   LD     BC,$0307     ; #
0926 03       INC    BC           ; #
0927 010703   LD     BC,$0307     ; #
092A 03       INC    BC           ; #
092B 03       INC    BC           ; #
092C 07       RLCA                ; #
092D 07       RLCA                ; #
092E 03       INC    BC           ; #
092F 03       INC    BC           ; #
0930 0F       RRCA                ; #
0931 07       RLCA                ; #
0932 03       INC    BC           ; #
0933 03       INC    BC           ; #
0934 0F       RRCA                ; #
0935 07       RLCA                ; #
0936 07       RLCA                ; #
0937 03       INC    BC           ; #
0938 0F       RRCA                ; #
0939 07       RLCA                ; #
093A 07       RLCA                ; #
093B 07       RLCA                ; #
093C 060A     LD     B,#0A        ; #
093E 0F       RRCA                ; #
093F 0F       RRCA                ; #
0940 04       INC    B            ; #
0941 08       EX     AF,A'F'      ; #
0942 0D       DEC    C            ; #
0943 0D       DEC    C            ; #
0944 04       INC    B            ; #
0945 060A     LD     B,#0A        ; #
0947 0A       LD     A,(BC)       ; #

;======================================================================
; PLAY COMMAND 0F (??)
;
0948 3AA092   LD     A,($92A0)    ;
094B 07       RLCA                ;
094C 07       RLCA                ;
094D 07       RLCA                ;
094E 07       RLCA                ;
094F 4F       LD     C,A          ;
0950 3A0192   LD     A,($9201)    ;
0953 FE03     CP     #03          ;
0955 C0       RET    NZ           ;
0956 3A4098   LD     A,($9840)    ;
0959 47       LD     B,A          ;
095A 2F       CPL                 ;
095B A1       AND    C            ;
095C 218109   LD     HL,$0981     ;
095F 11D983   LD     DE,$83D9     ;
0962 CD7209   CALL   $0972        ;
0965 3AB399   LD     A,($99B3)    ;
0968 A7       AND    A            ;
0969 C8       RET    Z            ;
096A 78       LD     A,B          ;
096B A1       AND    C            ;
096C 218409   LD     HL,$0984     ;
096F 11C483   LD     DE,$83C4     ;
0972 C5       PUSH   BC           ;
0973 E601     AND    #01          ;
0975 2803     JR     Z,$97A       ;
0977 218709   LD     HL,$0987     ;
097A 010300   LD     BC,$0003     ;
097D EDB0     LDIR                ;
097F C1       POP    BC           ;
0980 C9       RET                 ;
;
0981 19       ADD    HL,DE        ; #
0982 1E01     LD     E,#01        ; #
0984 19       ADD    HL,DE        ; #
0985 1E02     LD     E,#02        ; #
0987 24       INC    H            ; #
0988 24       INC    H            ; #
0989 24       INC    H            ; #

;======================================================================
; PLAY COMMAND 1F Process inputs (like coins)
;
098A 3AB599   LD     A,($99B5)    ;
098D FEBB     CP     #BB          ;
098F CA6C33   JP     Z,$336C      ;
0992 3A0192   LD     A,($9201)    ;
0995 FE03     CP     #03          ;
0997 2019     JR     NZ,$9B2      ;
0999 21E999   LD     HL,$99E9     ;
099C 7E       LD     A,(HL)       ;
099D C601     ADD    A,#01        ;
099F 27       DAA                 ;
09A0 FE60     CP     #60          ;
09A2 2001     JR     NZ,$9A5      ;
09A4 AF       XOR    A            ;
09A5 0604     LD     B,#04        ;
09A7 3F       CCF                 ;
09A8 77       LD     (HL),A       ;
09A9 2D       DEC    L            ;
09AA 7E       LD     A,(HL)       ;
09AB CE00     ADC    A,#00        ;
09AD 27       DAA                 ;
09AE 10F8     DJNZ   $9A8         ;
09B0 1842     JR     $9F4         ;
09B2 3AB899   LD     A,($99B8)    ;
09B5 FEA0     CP     #A0          ;
09B7 113C80   LD     DE,$803C     ;
09BA 2830     JR     Z,$9EC       ;
09BC 3AB599   LD     A,($99B5)    ;
09BF 21E209   LD     HL,$09E2     ;
09C2 010600   LD     BC,$0006     ;
09C5 EDB8     LDDR                ;
09C7 1D       DEC    E            ;
09C8 4F       LD     C,A          ;
09C9 07       RLCA                ;
09CA 07       RLCA                ;
09CB 07       RLCA                ;
09CC 07       RLCA                ;
09CD E60F     AND    #0F          ;
09CF 2802     JR     Z,$9D3       ;
09D1 12       LD     (DE),A       ;
09D2 1D       DEC    E            ;
09D3 79       LD     A,C          ;
09D4 E60F     AND    #0F          ;
09D6 12       LD     (DE),A       ;
09D7 1D       DEC    E            ;
09D8 3E24     LD     A,#24        ;
09DA 12       LD     (DE),A       ;
09DB 1817     JR     $9F4         ;
09DD 1D       DEC    E            ;
09DE 12       LD     (DE),A       ;
09DF 0D       DEC    C            ;
09E0 0E1B     LD     C,#1B        ;
09E2 0C       INC    C            ;
09E3 220A15   LD     ($150A),HL   ;
09E6 19       ADD    HL,DE        ;
09E7 24       INC    H            ;
09E8 0E0E     LD     C,#0E        ;
09EA 1B       DEC    DE           ;
09EB 0F       RRCA                ;
09EC 21EB09   LD     HL,$09EB     ;
09EF 010900   LD     BC,$0009     ;
09F2 EDB8     LDDR                ;
09F4 3A0192   LD     A,($9201)    ;
09F7 A7       AND    A            ;
09F8 C8       RET    Z            ;
09F9 3D       DEC    A            ;
09FA 2016     JR     NZ,$A12      ;
09FC 3AB599   LD     A,($99B5)    ;
09FF A7       AND    A            ;
0A00 2810     JR     Z,$A12       ;
0A02 3E02     LD     A,#02        ;
0A04 320192   LD     ($9201),A    ;
0A07 AF       XOR    A            ;
0A08 21A09A   LD     HL,$9AA0     ;
0A0B 0608     LD     B,#08        ;
0A0D DF       RST    18H          ;
0A0E 2C       INC    L            ;
0A0F 060F     LD     B,#0F        ;
0A11 DF       RST    18H          ;
0A12 3AB599   LD     A,($99B5)    ;
0A15 4F       LD     C,A          ;
0A16 3AB899   LD     A,($99B8)    ;
0A19 47       LD     B,A          ;
0A1A 91       SUB    C            ;
0A1B C8       RET    Z            ;
0A1C 380F     JR     C,$A2D       ;
0A1E 27       DAA                 ;
0A1F 3D       DEC    A            ;
0A20 32B399   LD     ($99B3),A    ;
0A23 79       LD     A,C          ;
0A24 32B899   LD     ($99B8),A    ;
0A27 3E03     LD     A,#03        ;
0A29 320192   LD     ($9201),A    ;
0A2C C9       RET                 ;
0A2D 79       LD     A,C          ;
0A2E 32B899   LD     ($99B8),A    ;
0A31 FEA0     CP     #A0          ;
0A33 C8       RET    Z            ;
0A34 90       SUB    B            ;
0A35 27       DAA                 ;
0A36 32799A   LD     ($9A79),A    ;
0A39 C9       RET                 ;
0A3A 210391   LD     HL,$9103     ;
0A3D 0605     LD     B,#05        ;
0A3F 1A       LD     A,(DE)       ;
0A40 1C       INC    E            ;
0A41 FE24     CP     #24          ;
0A43 2001     JR     NZ,$A46      ;
0A45 AF       XOR    A            ;
0A46 ED67     RRD                 ;
0A48 CB40     BIT    0,B          ;
0A4A 2001     JR     NZ,$A4D      ;
0A4C 2D       DEC    L            ;
0A4D 10F0     DJNZ   $A3F         ;
0A4F AF       XOR    A            ;
0A50 ED67     RRD                 ;
0A52 2D       DEC    L            ;
0A53 3600     LD     (HL),#00     ;
0A55 2E03     LD     L,#03        ;
0A57 11E599   LD     DE,$99E5     ;
0A5A 0604     LD     B,#04        ;
0A5C A7       AND    A            ;
0A5D 1A       LD     A,(DE)       ;
0A5E 8E       ADC    A,(HL)       ;
0A5F 27       DAA                 ;
0A60 12       LD     (DE),A       ;
0A61 1D       DEC    E            ;
0A62 2D       DEC    L            ;
0A63 10F8     DJNZ   $A5D         ;
0A65 C9       RET                 ;
0A66 0601     LD     B,#01        ;
0A68 25       DEC    H            ;
0A69 24       INC    H            ;
0A6A 2005     JR     NZ,$A71      ;
0A6C 7D       LD     A,L          ;
0A6D FE0A     CP     #0A          ;
0A6F 380A     JR     C,$A7B       ;
0A71 3E0A     LD     A,#0A        ;
0A73 CD6110   CALL   $1061        ;
0A76 F5       PUSH   AF           ;
0A77 04       INC    B            ;
0A78 18EE     JR     $A68         ;
0A7A F1       POP    AF           ;
0A7B CD810A   CALL   $0A81        ;
0A7E 10FA     DJNZ   $A7A         ;
0A80 C9       RET                 ;
0A81 12       LD     (DE),A       ;
0A82 C32000   JP     $0020        ;
0A85 2A4498   LD     HL,($9844)   ;
0A88 ED5B4698 LD     DE,($9846)   ;
0A8C 7A       LD     A,D          ;
0A8D B3       OR     E            ;
0A8E 2005     JR     NZ,$A95      ;
0A90 110000   LD     DE,$0000     ;
0A93 1851     JR     $AE6         ;
0A95 CB7A     BIT    7,D          ;
0A97 200A     JR     NZ,$AA3      ;
0A99 CB7C     BIT    7,H          ;
0A9B 2006     JR     NZ,$AA3      ;
0A9D 29       ADD    HL,HL        ;
0A9E EB       EX     DE,HL        ;
0A9F 29       ADD    HL,HL        ;
0AA0 EB       EX     DE,HL        ;
0AA1 18F2     JR     $A95         ;
0AA3 7A       LD     A,D          ;
0AA4 CD6110   CALL   $1061        ;
0AA7 E5       PUSH   HL           ;
0AA8 67       LD     H,A          ;
0AA9 2E00     LD     L,#00        ;
0AAB 7A       LD     A,D          ;
0AAC CD6110   CALL   $1061        ;
0AAF E3       EX     (SP),HL      ;
0AB0 11B099   LD     DE,$99B0     ;
0AB3 0604     LD     B,#04        ;
0AB5 7C       LD     A,H          ;
0AB6 2600     LD     H,#00        ;
0AB8 EB       EX     DE,HL        ;
0AB9 ED6F     RLD                 ;
0ABB CB40     BIT    0,B          ;
0ABD 2801     JR     Z,$AC0       ;
0ABF 2C       INC    L            ;
0AC0 EB       EX     DE,HL        ;
0AC1 CD190B   CALL   $0B19        ;
0AC4 08       EX     AF,A'F'      ;
0AC5 E3       EX     (SP),HL      ;
0AC6 CD190B   CALL   $0B19        ;
0AC9 E3       EX     (SP),HL      ;
0ACA D7       RST    10H          ;
0ACB 08       EX     AF,A'F'      ;
0ACC 84       ADD    A,H          ;
0ACD 2600     LD     H,#00        ;
0ACF 10E7     DJNZ   $AB8         ;
0AD1 D1       POP    DE           ;
0AD2 FE05     CP     #05          ;
0AD4 3814     JR     C,$AEA       ;
0AD6 ED5BB099 LD     DE,($99B0)   ;
0ADA 7A       LD     A,D          ;
0ADB C601     ADD    A,#01        ;
0ADD 27       DAA                 ;
0ADE 57       LD     D,A          ;
0ADF 3005     JR     NZ,$AE6      ;
0AE1 7B       LD     A,E          ;
0AE2 C601     ADD    A,#01        ;
0AE4 27       DAA                 ;
0AE5 5F       LD     E,A          ;
0AE6 ED53B099 LD     ($99B0),DE   ;
0AEA 0604     LD     B,#04        ;
0AEC 0E00     LD     C,#00        ;
0AEE 21B099   LD     HL,$99B0     ;
0AF1 113881   LD     DE,$8138     ;
0AF4 05       DEC    B            ;
0AF5 2004     JR     NZ,$AFB      ;
0AF7 3E2A     LD     A,#2A        ;
0AF9 12       LD     (DE),A       ;
0AFA E7       RST    20H          ;
0AFB 04       INC    B            ;
0AFC AF       XOR    A            ;
0AFD ED6F     RLD                 ;
0AFF CB40     BIT    0,B          ;
0B01 2801     JR     Z,$B04       ;
0B03 2C       INC    L            ;
0B04 A7       AND    A            ;
0B05 2004     JR     NZ,$B0B      ;
0B07 CB41     BIT    0,C          ;
0B09 2804     JR     Z,$B0F       ;
0B0B CBC1     SET    0,C          ;
0B0D 12       LD     (DE),A       ;
0B0E E7       RST    20H          ;
0B0F 78       LD     A,B          ;
0B10 FE03     CP     #03          ;
0B12 2002     JR     NZ,$B16      ;
0B14 CBC1     SET    0,C          ;
0B16 10DC     DJNZ   $AF4         ;
0B18 C9       RET                 ;
0B19 3E0A     LD     A,#0A        ;
0B1B CD4E10   CALL   $104E        ;
0B1E 7C       LD     A,H          ;
0B1F 2600     LD     H,#00        ;
0B21 C9       RET                 ;

; FFs (RST 38H) From here to next

0FFF C4 ;

1000 E5       PUSH   HL           ;
1001 ED5F     LD     A,R          ;
1003 67       LD     H,A          ;
1004 3AA092   LD     A,($92A0)    ;
1007 84       ADD    A,H          ;
1008 6F       LD     L,A          ;
1009 2601     LD     H,#01        ;
100B 7E       LD     A,(HL)       ;
100C 67       LD     H,A          ;
100D ED5F     LD     A,R          ;
100F 84       ADD    A,H          ;
1010 E1       POP    HL           ;
1011 C9       RET                 ;
1012 C5       PUSH   BC           ;
1013 D5       PUSH   DE           ;
1014 7B       LD     A,E          ;
1015 95       SUB    L            ;
1016 0600     LD     B,#00        ;
1018 3004     JR     NZ,$101E     ;
101A CBC0     SET    0,B          ;
101C ED44     NEG                 ;
101E 4F       LD     C,A          ;
101F 7A       LD     A,D          ;
1020 94       SUB    H            ;
1021 300A     JR     NZ,$102D     ;
1023 57       LD     D,A          ;
1024 78       LD     A,B          ;
1025 EE01     XOR    #01          ;
1027 F602     OR     #02          ;
1029 47       LD     B,A          ;
102A 7A       LD     A,D          ;
102B ED44     NEG                 ;
102D B9       CP     C            ;
102E F5       PUSH   AF           ;
102F 17       RLA                 ;
1030 A8       XOR    B            ;
1031 1F       RRA                 ;
1032 3F       CCF                 ;
1033 CB10     RL     B            ;
1035 F1       POP    AF           ;
1036 3003     JR     NZ,$103B     ;
1038 51       LD     D,C          ;
1039 4F       LD     C,A          ;
103A 7A       LD     A,D          ;
103B 61       LD     H,C          ;
103C 2E00     LD     L,#00        ;
103E CD6110   CALL   $1061        ;
1041 7C       LD     A,H          ;
1042 A8       XOR    B            ;
1043 E601     AND    #01          ;
1045 2803     JR     Z,$104A      ;
1047 7D       LD     A,L          ;
1048 2F       CPL                 ;
1049 6F       LD     L,A          ;
104A 60       LD     H,B          ;
104B D1       POP    DE           ;
104C C1       POP    BC           ;
104D C9       RET                 ;
104E D5       PUSH   DE           ;
104F EB       EX     DE,HL        ;
1050 210000   LD     HL,$0000     ;
1053 CB3F     SRL    A            ;
1055 3001     JR     NZ,$1058     ;
1057 19       ADD    HL,DE        ;
1058 CB23     SLA    E            ;
105A CB12     RL     D            ;
105C A7       AND    A            ;
105D 20F4     JR     NZ,$1053     ;
105F D1       POP    DE           ;
1060 C9       RET                 ;

1061 C5       PUSH   BC           ;
1062 4F       LD     C,A          ;
1063 AF       XOR    A            ;
1064 0611     LD     B,#11        ;
1066 8F       ADC    A,A          ;
1067 380B     JR     C,$1074      ;
1069 B9       CP     C            ;
106A 3801     JR     C,$106D      ;
106C 91       SUB    C            ;
106D 3F       CCF                 ;
106E ED6A     ADC    HL,HL        ;
1070 10F4     DJNZ   $1066        ;
1072 C1       POP    BC           ;
1073 C9       RET                 ;
1074 91       SUB    C            ;
1075 37       SCF                 ;
1076 C36E10   JP     $106E        ;

; Process next moving bee (After they have setup)
1079 7D       LD     A,L          ;
107A E680     AND    #80          ;
107C 3C       INC    A            ;
107D 08       EX     AF,A'F'      ;
107E CBBD     RES    7,L          ;
1080 C38A10   JP     $108A        ;

1083 7D       LD     A,L          ;
1084 0F       RRCA                ;
1085 0F       RRCA                ;
1086 E680     AND    #80          ;
1088 3C       INC    A            ;
1089 08       EX     AF,A'F'      ;
108A D5       PUSH   DE           ; Hold DE
108B 111400   LD     DE,$0014     ; 14 Bytes per bee
108E 060C     LD     B,#0C        ; 12 bees to process
1090 DD210091 LD     IX,$9100     ; Bee memory
1094 DDCB1346 BIT    0,(IX+#13)   ; Bee alive?
1098 2806     JR     Z,$10A0      ; Yes -- handle it
109A DD19     ADD    IX,DE        ; Next bee
109C 10F6     DJNZ   $1094        ; Check all bees
109E D1       POP    DE           ; Restore DE
109F C9       RET                 ; Out
10A0 D1       POP    DE           ;
10A1 DD7308   LD     (IX+#08),E   ;
10A4 DD7209   LD     (IX+#09),D   ;
10A7 DD360D01 LD     (IX+#0D),#01 ;
10AB DD360400 LD     (IX+#04),#00 ;
10AF DD360501 LD     (IX+#05),#00 ;
10B3 4D       LD     C,L          ;
10B4 DD7110   LD     (IX+#10),C   ;
10B7 08       EX     AF,A'F'      ;
10B8 57       LD     D,A          ;
10B9 3609     LD     (HL),#09     ; Crashes as soon as all are out.
10BB DD       ???                 ;
10BC 7D       LD     A,L          ;
10BD 2C       INC    L            ;
10BE 77       LD     (HL),A       ;
10BF 3A1592   LD     A,($9215)    ;
10C2 5F       LD     E,A          ;
10C3 69       LD     L,C          ;
10C4 2693     LD     H,#93        ; Sprite position
10C6 4E       LD     C,(HL)       ;
10C7 2C       INC    L            ;
10C8 46       LD     B,(HL)       ;
10C9 269B     LD     H,#9B        ; Sprite control
10CB 7E       LD     A,(HL)       ;
10CC 0F       RRCA                ;
10CD CB18     RR     B            ;
10CF CB43     BIT    0,E          ;
10D1 2009     JR     NZ,$10DC     ;
10D3 08       EX     AF,A'F'      ;
10D4 78       LD     A,B          ;
10D5 C650     ADD    A,#50        ;
10D7 ED44     NEG                 ;
10D9 47       LD     B,A          ;
10DA 08       EX     AF,A'F'      ;
10DB 3F       CCF                 ;
10DC DD7001   LD     (IX+#01),B   ; Y coordinate
10DF 1F       RRA                 ; /2
10E0 E680     AND    #80          ;
10E2 DD7700   LD     (IX+#00),A   ; X coordinate
10E5 79       LD     A,C          ;
10E6 CB43     BIT    0,E          ;
10E8 2803     JR     Z,$10ED      ;
10EA C60D     ADD    A,#0D        ;
10EC 2F       CPL                 ;
10ED CB3F     SRL    A            ;
10EF DD7703   LD     (IX+#03),A   ;
10F2 1F       RRA                 ;
10F3 E680     AND    #80          ;
10F5 DD7702   LD     (IX+#02),A   ;
10F8 DD7213   LD     (IX+#13),D   ;
10FB DD360E1E LD     (IX+#0E),#1E ; Prepare shot delay 
10FF 3A0B92   LD     A,($920B)    ;
1102 A7       AND    A            ;
1103 2803     JR     Z,$1108      ;
1105 3AC892   LD     A,($92C8)    ;
1108 DD770F   LD     (IX+#0F),A   ; Shots
110B C9       RET                 ;

110C 3E1F     LD     A,#1F        ;
110E 320090   LD     ($9000),A    ;
1111 32E098   LD     ($98E0),A    ;
1114 212098   LD     HL,$9820     ;
1117 116098   LD     DE,$9860     ;
111A 0640     LD     B,#40        ;
111C 4E       LD     C,(HL)       ;
111D 1A       LD     A,(DE)       ;
111E 77       LD     (HL),A       ;
111F 79       LD     A,C          ;
1120 12       LD     (DE),A       ;
1121 2C       INC    L            ;
1122 1C       INC    E            ;
1123 10F7     DJNZ   $111C        ;
1125 210088   LD     HL,$8800     ;
1128 11B098   LD     DE,$98B0     ;
112B 0630     LD     B,#30        ; 0x30 to check
112D 7E       LD     A,(HL)       ; Next bee
112E 4F       LD     C,A          ;
112F 268B     LD     H,#8B        ; Sprite color
1131 7E       LD     A,(HL)       ;
1132 E67F     AND    #7F          ; Mask out upper bit
1134 0D       DEC    C            ;
1135 200B     JR     NZ,$1142     ;
1137 E678     AND    #78          ;
1139 4F       LD     C,A          ;
113A 2C       INC    L            ;
113B 7E       LD     A,(HL)       ;
113C 2D       DEC    L            ;
113D E607     AND    #07          ;
113F B1       OR     C            ;
1140 F680     OR     #80          ; Set upper bit
1142 EB       EX     DE,HL        ;
1143 4E       LD     C,(HL)       ;
1144 77       LD     (HL),A       ;
1145 EB       EX     DE,HL        ;
1146 CB79     BIT    7,C          ;
1148 2810     JR     Z,$115A      ;
114A 79       LD     A,C          ;
114B E678     AND    #78          ;
114D C606     ADD    A,#06        ;
114F 77       LD     (HL),A       ;
1150 2C       INC    L            ;
1151 79       LD     A,C          ;
1152 E607     AND    #07          ;
1154 77       LD     (HL),A       ;
1155 2D       DEC    L            ;
1156 3E01     LD     A,#01        ;
1158 1807     JR     $1161        ;
115A 71       LD     (HL),C       ;
115B 2693     LD     H,#93        ; Sprite control 
115D 3600     LD     (HL),#00     ; Turn off sprite
115F 3E80     LD     A,#80        ; Flag no longer active FA NOPE
1161 2688     LD     H,#88        ; Bee memory
1163 77       LD     (HL),A       ;
1164 13       INC    DE           ;
1165 2C       INC    L            ;
1166 2C       INC    L            ;
1167 10C4     DJNZ   $112D        ;
1169 210090   LD     HL,$9000     ;
116C 11E098   LD     DE,$98E0     ;
116F 0620     LD     B,#20        ;
1171 4E       LD     C,(HL)       ;
1172 1A       LD     A,(DE)       ;
1173 77       LD     (HL),A       ;
1174 79       LD     A,C          ;
1175 12       LD     (DE),A       ;
1176 2C       INC    L            ;
1177 1C       INC    E            ;
1178 10F7     DJNZ   $1171        ;
117A AF       XOR    A            ;
117B 320090   LD     ($9000),A    ;
117E C9       RET                 ;

117F 210280   LD     HL,$8002     ;
1182 0612     LD     B,#12        ;
1184 7E       LD     A,(HL)       ;
1185 FE4A     CP     #4A          ;
1187 3002     JR     NZ,$118B     ;
1189 3624     LD     (HL),#24     ;
118B 2C       INC    L            ;
118C 10F6     DJNZ   $1184        ;
118E 2E22     LD     L,#22        ;
1190 0612     LD     B,#12        ;
1192 7E       LD     A,(HL)       ;
1193 FE4A     CP     #4A          ;
1195 3002     JR     NZ,$1199     ;
1197 3624     LD     (HL),#24     ;
1199 2C       INC    L            ;
119A 10F6     DJNZ   $1192        ;
119C 3A2198   LD     A,($9821)    ;
119F 0600     LD     B,#00        ;
11A1 210180   LD     HL,$8001     ;
11A4 FE32     CP     #32          ;
11A6 3807     JR     C,$11AF      ;
11A8 D632     SUB    #32          ;
11AA 04       INC    B            ;
11AB 2C       INC    L            ;
11AC 2C       INC    L            ;
11AD 18F5     JR     $11A4        ;
11AF EB       EX     DE,HL        ;
11B0 6F       LD     L,A          ;
11B1 2600     LD     H,#00        ;
11B3 3E0A     LD     A,#0A        ;
11B5 CD6110   CALL   $1061        ;
11B8 67       LD     H,A          ;
11B9 E5       PUSH   HL           ;
11BA EB       EX     DE,HL        ;
11BB FE05     CP     #05          ;
11BD 3802     JR     C,$11C1      ;
11BF D604     SUB    #04          ;
11C1 4F       LD     C,A          ;
11C2 7B       LD     A,E          ;
11C3 CB47     BIT    0,A          ;
11C5 2802     JR     Z,$11C9      ;
11C7 3E02     LD     A,#02        ;
11C9 81       ADD    A,C          ;
11CA D7       RST    10H          ;
11CB 04       INC    B            ;
11CC 1020     DJNZ   $11EE        ;
11CE C1       POP    BC           ;
11CF 79       LD     A,C          ;
11D0 CDF511   CALL   $11F5        ;
11D3 78       LD     A,B          ;
11D4 FE05     CP     #05          ;
11D6 3808     JR     C,$11E0      ;
11D8 1638     LD     D,#38        ;
11DA CD1312   CALL   $1213        ;
11DD 78       LD     A,B          ;
11DE D605     SUB    #05          ;
11E0 47       LD     B,A          ;
11E1 04       INC    B            ;
11E2 1003     DJNZ   $11E7        ;
11E4 C37E13   JP     $137E        ;
11E7 1636     LD     D,#36        ;
11E9 CD1312   CALL   $1213        ;
11EC 18F4     JR     $11E2        ;
11EE 3E04     LD     A,#04        ;
11F0 CDFB11   CALL   $11FB        ;
11F3 18D7     JR     $11CC        ;
11F5 A7       AND    A            ;
11F6 C8       RET    Z            ;
11F7 FE04     CP     #04          ;
11F9 2807     JR     Z,$1202      ;
11FB 07       RLCA                ;
11FC 07       RLCA                ;
11FD C636     ADD    A,#36        ;
11FF 57       LD     D,A          ;
1200 180A     JR     $120C        ;
1202 1642     LD     D,#42        ;
1204 CD1312   CALL   $1213        ;
1207 CD2812   CALL   $1228        ;
120A 163A     LD     D,#3A        ;
120C CD1312   CALL   $1213        ;
120F CD2812   CALL   $1228        ;
1212 C9       RET                 ;
1213 08       EX     AF,A'F'      ;
1214 3811     JR     C,$1227      ;
1216 08       EX     AF,A'F'      ;
1217 3AA092   LD     A,($92A0)    ;
121A C608     ADD    A,#08        ;
121C 5F       LD     E,A          ;
121D 3AA092   LD     A,($92A0)    ;
1220 93       SUB    E            ;
1221 20FA     JR     NZ,$121D     ;
1223 08       EX     AF,A'F'      ;
1224 32B59A   LD     ($9AB5),A    ;
1227 08       EX     AF,A'F'      ;

1228 72       LD     (HL),D       ;
1229 14       INC    D            ;
122A CBED     SET    5,L          ;
122C 72       LD     (HL),D       ;
122D 14       INC    D            ;
122E CBD4     SET    2,H          ;
1230 7A       LD     A,D          ;
1231 E60C     AND    #0C          ;
1233 FE08     CP     #08          ;
1235 3E01     LD     A,#01        ;
1237 2801     JR     Z,$123A      ;
1239 3C       INC    A            ;
123A 77       LD     (HL),A       ;
123B CBAD     RES    5,L          ;
123D 77       LD     (HL),A       ;
123E CB94     RES    2,H          ;
1240 2D       DEC    L            ;
1241 C9       RET                 ;

1242 215B12   LD     HL,$125B     ;
1245 110090   LD     DE,$9000     ;
1248 012000   LD     BC,$0020     ;
124B C5       PUSH   BC           ;
124C E5       PUSH   HL           ;
124D EDB0     LDIR                ;
124F E1       POP    HL           ;
1250 C1       POP    BC           ;
1251 11E098   LD     DE,$98E0     ;
1254 EDB0     LDIR                ;
1256 AF       XOR    A            ;
1257 320090   LD     ($9000),A    ;
125A C9       RET                 ;

125B 1F       RRA                 ;
125C 010000   LD     BC,$0000     ;
125F 00       NOP                 ;
1260 010000   LD     BC,$0000     ;
1263 00       NOP                 ;
1264 00       NOP                 ;
1265 00       NOP                 ;
1266 00       NOP                 ;
1267 010100   LD     BC,$0001     ;
126A 010000   LD     BC,$0000     ;
126D 00       NOP                 ;
126E 00       NOP                 ;
126F 00       NOP                 ;
1270 00       NOP                 ;
1271 00       NOP                 ;
1272 010000   LD     BC,$0000     ;
1275 00       NOP                 ;
1276 00       NOP                 ;
1277 00       NOP                 ;
1278 00       NOP                 ;
1279 00       NOP                 ;
127A 0A       LD     A,(BC)       ;

; Something to do with drawing shot sprites
127B 21648B   LD     HL,$8B64     ;
127E 113009   LD     DE,$0930     ; Player
1281 0E00     LD     C,#00        ; Player
1283 060A     LD     B,#0A        ; Loop 10 times
1285 73       LD     (HL),E       ; Set to color 30
1286 2693     LD     H,#93        ; Sprite position
1288 3600     LD     (HL),#00     ;
128A 269B     LD     H,#9B        ;
128C 71       LD     (HL),C       ; Sprite control = 0 (or 1)
128D 268B     LD     H,#8B        ; Sprite color
128F 2C       INC    L            ;
1290 72       LD     (HL),D       ; #09 (or 0B)
1291 2C       INC    L            ;
1292 78       LD     A,B          ;
1293 FE09     CP     #09          ; 
1295 2004     JR     NZ,$129B     ; No -- do it
1297 0E01     LD     C,#01        ; Bee ...
1299 160B     LD     D,#0B        ; ... shots
129B 10E8     DJNZ   $1285        ; Do all shots
129D C9       RET                 ;

; ??? TOPHER ???
129E 268B     LD     H,#8B        ;
12A0 ED5B8092 LD     DE,($9280)   ;
12A4 1A       LD     A,(DE)       ;
12A5 6F       LD     L,A          ;
12A6 13       INC    DE           ;
12A7 1A       LD     A,(DE)       ;
12A8 4F       LD     C,A          ;
12A9 E678     AND    #78          ;
12AB C606     ADD    A,#06        ;
12AD 77       LD     (HL),A       ;
12AE 2C       INC    L            ;
12AF 79       LD     A,C          ;
12B0 E607     AND    #07          ;
12B2 CB79     BIT    7,C          ;
12B4 2802     JR     Z,$12B8      ;
12B6 F608     OR     #08          ;
12B8 77       LD     (HL),A       ;
12B9 13       INC    DE           ;
12BA 2D       DEC    L            ;
12BB 2688     LD     H,#88        ; Bee descriptors
12BD 3601     LD     (HL),#01     ;
12BF 2693     LD     H,#93        ; Sprite control
12C1 1A       LD     A,(DE)       ;
12C2 77       LD     (HL),A       ;
12C3 13       INC    DE           ;
12C4 2C       INC    L            ;
12C5 1A       LD     A,(DE)       ;
12C6 CB27     SLA    A            ;
12C8 77       LD     (HL),A       ;
12C9 3E00     LD     A,#00        ;
12CB 17       RLA                 ;
12CC 269B     LD     H,#9B        ; Sprite color
12CE 77       LD     (HL),A       ;
12CF 13       INC    DE           ;
12D0 ED538092 LD     ($9280),DE   ;
12D4 C9       RET                 ;

12D5 DD       ???                 ;
12D6 6F       LD     L,A          ;
12D7 3A1592   LD     A,($9215)    ;
12DA 4F       LD     C,A          ;
12DB 210099   LD     HL,$9900     ;
12DE 112113   LD     DE,$1321     ;
12E1 0610     LD     B,#10        ;
12E3 3600     LD     (HL),#00     ;
12E5 2C       INC    L            ;
12E6 1A       LD     A,(DE)       ;
12E7 13       INC    DE           ;
12E8 77       LD     (HL),A       ;
12E9 2C       INC    L            ;
12EA 10F7     DJNZ   $12E3        ;
12EC 210098   LD     HL,$9800     ;
12EF 112113   LD     DE,$1321     ;
12F2 060A     LD     B,#0A        ;
12F4 1A       LD     A,(DE)       ;
12F5 13       INC    DE           ;
12F6 CB41     BIT    0,C          ;
12F8 2803     JR     Z,$12FD      ;
12FA C60D     ADD    A,#0D        ;
12FC 2F       CPL                 ;
12FD 77       LD     (HL),A       ;
12FE 2C       INC    L            ;
12FF 2C       INC    L            ;
1300 10F2     DJNZ   $12F4        ;
1302 0606     LD     B,#06        ;
1304 1A       LD     A,(DE)       ;
1305 DD       ???                 ;
1306 85       ADD    A,L          ;
1307 13       INC    DE           ;
1308 CB41     BIT    0,C          ;
130A 2003     JR     NZ,$130F     ;
130C C64F     ADD    A,#4F        ;
130E 2F       CPL                 ;
130F CB27     SLA    A            ;
1311 77       LD     (HL),A       ;
1312 2C       INC    L            ;
1313 3E00     LD     A,#00        ;
1315 17       RLA                 ;
1316 77       LD     (HL),A       ;
1317 2C       INC    L            ;
1318 10EA     DJNZ   $1304        ;
131A 3A1592   LD     A,($9215)    ;
131D 320F92   LD     ($920F),A    ;
1320 C9       RET                 ;
1321 314151   LD     SP,$5141     ;
1324 61       LD     H,C          ;
1325 71       LD     (HL),C       ;
1326 81       ADD    A,C          ;
1327 91       SUB    C            ;
1328 A1       AND    C            ;
1329 B1       OR     C            ;
132A C1       POP    BC           ;
132B 92       SUB    D            ;
132C 8A       ADC    A,D          ;
132D 82       ADD    A,D          ;
132E 7C       LD     A,H          ;
132F 76       HALT                ;
1330 70       ???                 ;
1331 E5       PUSH   HL           ;
1332 21AF92   LD     HL,$92AF     ;
1335 3603     LD     (HL),#03     ;
1337 7E       LD     A,(HL)       ;
1338 A7       AND    A            ;
1339 20FC     JR     NZ,$1337     ;
133B E1       POP    HL           ;
133C C9       RET                 ;
133D 3E01     LD     A,#01        ;
133F 321490   LD     ($9014),A    ;
1342 3A7082   LD     A,($8270)    ;
1345 FE24     CP     #24          ;
1347 2003     JR     NZ,$134C     ;
1349 0E03     LD     C,#03        ;
134B F7       RST    30H          ;

134C 3A8792   LD     A,($9287)    ;
134F A7       AND    A            ;
1350 20FA     JR     NZ,$134C     ;
1352 CD7E13   CALL   $137E        ;
1355 210609   LD     HL,$0906     ;
1358 22628B   LD     ($8B62),HL   ;
135B 216293   LD     HL,$9362     ;
135E 3A1592   LD     A,($9215)    ;
1361 E601     AND    #01          ;
1363 3E29     LD     A,#29        ;
1365 0E01     LD     C,#01        ;
1367 2803     JR     Z,$136C      ;
1369 C60E     ADD    A,#0E        ;
136B 0D       DEC    C            ;
136C 367A     LD     (HL),#7A     ;
136E 2C       INC    L            ;
136F 77       LD     (HL),A       ;
1370 269B     LD     H,#9B        ;
1372 71       LD     (HL),C       ;
1373 2D       DEC    L            ;
1374 AF       XOR    A            ;
1375 77       LD     (HL),A       ;
1376 321392   LD     ($9213),A    ;
1379 3C       INC    A            ;
137A 32B999   LD     ($99B9),A    ;
137D C9       RET                 ;

137E 3A2098   LD     A,($9820)    ;
1381 2F       CPL                 ;
1382 C609     ADD    A,#09        ;
1384 5F       LD     E,A          ;
1385 1649     LD     D,#49        ;
1387 211D80   LD     HL,$801D     ;
138A CD9813   CALL   $1398        ;
138D 2D       DEC    L            ;
138E CD9813   CALL   $1398        ;
1391 CBED     SET    5,L          ;
1393 2C       INC    L            ;
1394 CD9813   CALL   $1398        ;
1397 2D       DEC    L            ;
1398 E5       PUSH   HL           ;
1399 14       INC    D            ;
139A 4A       LD     C,D          ;
139B 0608     LD     B,#08        ;
139D 78       LD     A,B          ;
139E BB       CP     E            ;
139F 2002     JR     NZ,$13A3     ;
13A1 0E24     LD     C,#24        ;
13A3 7E       LD     A,(HL)       ;
13A4 FE36     CP     #36          ;
13A6 3804     JR     C,$13AC      ;
13A8 FE4A     CP     #4A          ;
13AA 3801     JR     C,$13AD      ;
13AC 71       LD     (HL),C       ;
13AD 2D       DEC    L            ;
13AE 2D       DEC    L            ;
13AF 10EC     DJNZ   $139D        ;
13B1 E1       POP    HL           ;
13B2 C9       RET                 ;

; 
13B3 A7       AND    A            ;
13B4 08       EX     AF,A'F'      ;
13B5 D5       PUSH   DE           ;
13B6 EB       EX     DE,HL        ;
13B7 79       LD     A,C          ;
13B8 21EF13   LD     HL,$13EF     ; Vector into giant data block
13BB CF       RST    08H          ; Add A*2 to HL (add 100 it A=0)
13BC 7E       LD     A,(HL)       ;
13BD 23       INC    HL           ;
13BE 66       LD     H,(HL)       ;
13BF 6F       LD     L,A          ;
13C0 08       EX     AF,A'F'      ;
13C1 3006     JR     NZ,$13C9     ;
13C3 2B       DEC    HL           ;
13C4 2B       DEC    HL           ;
13C5 5E       LD     E,(HL)       ;
13C6 23       INC    HL           ;
13C7 56       LD     D,(HL)       ;
13C8 23       INC    HL           ;
13C9 4E       LD     C,(HL)       ;
13CA 23       INC    HL           ;
13CB EB       EX     DE,HL        ;
13CC 1A       LD     A,(DE)       ;
13CD FE2F     CP     #2F          ;
13CF 281E     JR     Z,$13EF      ;
13D1 D630     SUB    #30          ;
13D3 3004     JR     NZ,$13D9     ;
13D5 3E24     LD     A,#24        ;
13D7 1806     JR     $13DF        ;
13D9 FE11     CP     #11          ;
13DB 3802     JR     C,$13DF      ;
13DD D607     SUB    #07          ;
13DF 77       LD     (HL),A       ;
13E0 CBD4     SET    2,H          ;
13E2 71       LD     (HL),C       ;
13E3 CB94     RES    2,H          ;
13E5 13       INC    DE           ;
13E6 7D       LD     A,L          ;
13E7 D620     SUB    #20          ;
13E9 6F       LD     L,A          ;
13EA 30E0     JR     NZ,$13CC     ;
13EC 25       DEC    H            ;
13ED 18DD     JR     $13CC        ;
13EF D1       POP    DE           ;
13F0 C9       RET                 ;

; Looks like a giant data block
;
13F1 2F       CPL                 ; #
13F2 14       INC    D            ; #
13F3 44       LD     B,H          ; #
13F4 14       INC    D            ; #
13F5 51       LD     D,C          ; #
13F6 14       INC    D            ; #
13F7 5C       LD     E,H          ; #
13F8 14       INC    D            ; #
13F9 66       LD     H,(HL)       ; #
13FA 14       INC    D            ; #
13FB 72       LD     (HL),D       ; #
13FC 14       INC    D            ; #
13FD 7C       LD     A,H          ; #
13FE 14       INC    D            ; #
13FF 91       SUB    C            ; #
1400 14       INC    D            ; #
1401 A3       AND    E            ; #
1402 14       INC    D            ; #
1403 AE       XOR    (HL)         ; #
1404 14       INC    D            ; #
1405 C214E1   JP     NZ,$E114     ; #
1408 14       INC    D            ; #
1409 EE14     XOR    #14          ; #
140B 09       ADD    HL,BC        ; #
140C 15       DEC    D            ; #
140D 13       INC    DE           ; #
140E 15       DEC    D            ; #
140F 22152F   LD     ($2F15),HL   ; #
1412 15       DEC    D            ; #
1413 3C       INC    A            ; #
1414 15       DEC    D            ; #
1415 40       LD     B,B          ; #
1416 15       DEC    D            ; #
1417 59       LD     E,C          ; #
1418 15       DEC    D            ; #
1419 5D       LD     E,L          ; #
141A 15       DEC    D            ; #
141B 6A       LD     L,D          ; #
141C 15       DEC    D            ; #
141D 81       ADD    A,C          ; #
141E 15       DEC    D            ; #
141F 8F       ADC    A,A          ; #
1420 15       DEC    D            ; #
1421 A8       XOR    B            ; #
1422 15       DEC    D            ; #
1423 BF       CP     A            ; #
1424 15       DEC    D            ; #
1425 C5       PUSH   BC           ; #
1426 15       DEC    D            ; #
1427 D9       EXX                 ; #
1428 15       DEC    D            ; #
1429 ED       ???                 ; #
142A 15       DEC    D            ; #
142B FF       RST    38H          ; #
142C 15       DEC    D            ; #
142D EB       EX     DE,HL        ; #
142E 82       ADD    A,D          ; #
142F 00       NOP                 ; #
1430 50       LD     D,B          ; #
1431 55       LD     D,L          ; #
1432 53       LD     D,E          ; #
1433 48       LD     C,B          ; #
1434 2053     JR     NZ,$1489     ; #
1436 54       LD     D,H          ; #
1437 41       LD     B,C          ; #
1438 52       LD     D,D          ; #
1439 54       LD     D,H          ; #
143A 2042     JR     NZ,$147E     ; #
143C 55       LD     D,L          ; #
143D 54       LD     D,H          ; #
143E 54       LD     D,H          ; #
143F 4F       LD     C,A          ; #
1440 4E       LD     C,(HL)       ; #
1441 2F       CPL                 ; #
1442 70       ???                 ; #
1443 82       ADD    A,D          ; #
1444 00       NOP                 ; #
1445 47       LD     B,A          ; #
1446 41       LD     B,C          ; #
1447 4D       LD     C,L          ; #
1448 45       LD     B,L          ; #
1449 204F     JR     NZ,$149A     ; #
144B 56       LD     D,(HL)       ; #
144C 45       LD     B,L          ; #
144D 52       LD     D,D          ; #
144E 2F       CPL                 ; #
144F 70       ???                 ; #
1450 82       ADD    A,D          ; #
1451 00       NOP                 ; #
1452 52       LD     D,D          ; #
1453 45       LD     B,L          ; #
1454 41       LD     B,C          ; #
1455 44       LD     B,H          ; #
1456 59       LD     E,C          ; #
1457 2021     JR     NZ,$147A     ; #
1459 2F       CPL                 ; #
145A 50       LD     D,B          ; #
145B 82       ADD    A,D          ; #
145C 00       NOP                 ; #
145D 50       LD     D,B          ; #
145E 4C       LD     C,H          ; #
145F 41       LD     B,C          ; #
1460 59       LD     E,C          ; #
1461 45       LD     B,L          ; #
1462 52       LD     D,D          ; #
1463 2031     JR     NZ,$1496     ; #
1465 2F       CPL                 ; #
1466 00       NOP                 ; #
1467 50       LD     D,B          ; #
1468 4C       LD     C,H          ; #
1469 41       LD     B,C          ; #
146A 59       LD     E,C          ; #
146B 45       LD     B,L          ; #
146C 52       LD     D,D          ; #
146D 2032     JR     NZ,$14A1     ; #
146F 2F       CPL                 ; #
1470 70       ???                 ; #
1471 82       ADD    A,D          ; #
1472 00       NOP                 ; #
1473 53       LD     D,E          ; #
1474 54       LD     D,H          ; #
1475 41       LD     B,C          ; #
1476 47       LD     B,A          ; #
1477 45       LD     B,L          ; #
1478 202F     JR     NZ,$14A9     ; #
147A 1083     DJNZ   $13FF        ; #
147C 00       NOP                 ; #
147D 43       LD     B,E          ; #
147E 48       LD     C,B          ; #
147F 41       LD     B,C          ; #
1480 4C       LD     C,H          ; #
1481 4C       LD     C,H          ; #
1482 45       LD     B,L          ; #
1483 4E       LD     C,(HL)       ; #
1484 47       LD     B,A          ; #
1485 49       LD     C,C          ; #
1486 4E       LD     C,(HL)       ; #
1487 47       LD     B,A          ; #
1488 2053     JR     NZ,$14DD     ; #
148A 54       LD     D,H          ; #
148B 41       LD     B,C          ; #
148C 47       LD     B,A          ; #
148D 45       LD     B,L          ; #
148E 2F       CPL                 ; #
148F 1083     DJNZ   $1414        ; #
1491 00       NOP                 ; #
1492 4E       LD     C,(HL)       ; #
1493 55       LD     D,L          ; #
1494 4D       LD     C,L          ; #
1495 42       LD     B,D          ; #
1496 45       LD     B,L          ; #
1497 52       LD     D,D          ; #
1498 204F     JR     NZ,$14E9     ; #
149A 46       LD     B,(HL)       ; #
149B 2048     JR     NZ,$14E5     ; #
149D 49       LD     C,C          ; #
149E 54       LD     D,H          ; #
149F 53       LD     D,E          ; #
14A0 2F       CPL                 ; #
14A1 B3       OR     E            ; #
14A2 82       ADD    A,D          ; #
14A3 00       NOP                 ; #
14A4 42       LD     B,D          ; #
14A5 4F       LD     C,A          ; #
14A6 4E       LD     C,(HL)       ; #
14A7 55       LD     D,L          ; #
14A8 53       LD     D,E          ; #
14A9 2020     JR     NZ,$14CB     ; #
14AB 2F       CPL                 ; #
14AC F1       POP    AF           ; #
14AD 82       ADD    A,D          ; #
14AE 04       INC    B            ; #
14AF 46       LD     B,(HL)       ; #
14B0 49       LD     C,C          ; #
14B1 47       LD     B,A          ; #
14B2 48       LD     C,B          ; #
14B3 54       LD     D,H          ; #
14B4 45       LD     B,L          ; #
14B5 52       LD     D,D          ; #
14B6 2043     JR     NZ,$14FB     ; #
14B8 41       LD     B,C          ; #
14B9 50       LD     D,B          ; #
14BA 54       LD     D,H          ; #
14BB 55       LD     D,L          ; #
14BC 52       LD     D,D          ; #
14BD 45       LD     B,L          ; #
14BE 44       LD     B,H          ; #
14BF 2F       CPL                 ; #
14C0 AD       XOR    L            ; #
14C1 83       ADD    A,E          ; #
14C2 00       NOP                 ; #
14C3 2020     JR     NZ,$14E5     ; #
14C5 2020     JR     NZ,$14E7     ; #
14C7 2020     JR     NZ,$14E9     ; #
14C9 2020     JR     NZ,$14EB     ; #
14CB 2020     JR     NZ,$14ED     ; #
14CD 2020     JR     NZ,$14EF     ; #
14CF 2020     JR     NZ,$14F1     ; #
14D1 2020     JR     NZ,$14F3     ; #
14D3 2020     JR     NZ,$14F5     ; #
14D5 2020     JR     NZ,$14F7     ; #
14D7 2020     JR     NZ,$14F9     ; #
14D9 2020     JR     NZ,$14FB     ; #
14DB 2020     JR     NZ,$14FD     ; #
14DD 202F     JR     NZ,$150E     ; #
14DF 6D       LD     L,L          ; #
14E0 82       ADD    A,D          ; #
14E1 04       INC    B            ; #
14E2 50       LD     D,B          ; #
14E3 45       LD     B,L          ; #
14E4 52       LD     D,D          ; #
14E5 46       LD     B,(HL)       ; #
14E6 45       LD     B,L          ; #
14E7 43       LD     B,E          ; #
14E8 54       LD     D,H          ; #
14E9 2063     JR     NZ,$154E     ; #
14EB 2F       CPL                 ; #
14EC 73       LD     (HL),E       ; #
14ED 83       ADD    A,E          ; #
14EE 05       DEC    B            ; #
14EF 53       LD     D,E          ; #
14F0 50       LD     D,B          ; #
14F1 45       LD     B,L          ; #
14F2 43       LD     B,E          ; #
14F3 49       LD     C,C          ; #
14F4 41       LD     B,C          ; #
14F5 4C       LD     C,H          ; #
14F6 2042     JR     NZ,$153A     ; #
14F8 4F       LD     C,A          ; #
14F9 4E       LD     C,(HL)       ; #
14FA 55       LD     D,L          ; #
14FB 53       LD     D,E          ; #
14FC 2031     JR     NZ,$152F     ; #
14FE 3030     JR     NZ,$1530     ; #
1500 3030     JR     NZ,$1532     ; #
1502 2050     JR     NZ,$1554     ; #
1504 54       LD     D,H          ; #
1505 53       LD     D,E          ; #
1506 2F       CPL                 ; #
1507 42       LD     B,D          ; #
1508 82       ADD    A,D          ; #
1509 00       NOP                 ; #
150A 47       LD     B,A          ; #
150B 41       LD     B,C          ; #
150C 4C       LD     C,H          ; #
150D 41       LD     B,C          ; #
150E 47       LD     B,A          ; #
150F 41       LD     B,C          ; #
1510 2F       CPL                 ; #
1511 A5       AND    L            ; #
1512 82       ADD    A,D          ; #
1513 00       NOP                 ; #
1514 5D       LD     E,L          ; #
1515 5D       LD     E,L          ; #
1516 2053     JR     NZ,$156B     ; #
1518 43       LD     B,E          ; #
1519 4F       LD     C,A          ; #
151A 52       LD     D,D          ; #
151B 45       LD     B,L          ; #
151C 205D     JR     NZ,$157B     ; #
151E 5D       LD     E,L          ; #
151F 2F       CPL                 ; #
1520 2882     JR     Z,$14A4      ; #
1522 00       NOP                 ; #
1523 35       DEC    (HL)         ; #
1524 3020     JR     NZ,$1546     ; #
1526 2020     JR     NZ,$1548     ; #
1528 2031     JR     NZ,$155B     ; #
152A 3030     JR     NZ,$155C     ; #
152C 2F       CPL                 ; #
152D 2A8200   LD     HL,($0082)   ; #
1530 3830     JR     C,$1562      ; #
1532 2020     JR     NZ,$1554     ; #
1534 2020     JR     NZ,$1556     ; #
1536 313630   LD     SP,$3036     ; #
1539 2F       CPL                 ; #
153A 2B       DEC    HL           ; #
153B 82       ADD    A,D          ; #
153C 00       NOP                 ; #
153D 2F       CPL                 ; #
153E 3B       DEC    SP           ; #
153F 83       ADD    A,E          ; #
1540 03       INC    BC           ; #
1541 65       LD     H,L          ; #
1542 2031     JR     NZ,$1575     ; #
1544 39       ADD    HL,SP        ; #
1545 3831     JR     C,$1578      ; #
1547 204D     JR     NZ,$1596     ; #
1549 49       LD     C,C          ; #
154A 44       LD     B,H          ; #
154B 57       LD     D,A          ; #
154C 41       LD     B,C          ; #
154D 59       LD     E,C          ; #
154E 204D     JR     NZ,$159D     ; #
1550 46       LD     B,(HL)       ; #
1551 47       LD     B,A          ; #
1552 61       LD     H,C          ; #
1553 43       LD     B,E          ; #
1554 4F       LD     C,A          ; #
1555 61       LD     H,C          ; #
1556 2F       CPL                 ; #
1557 5E       LD     E,(HL)       ; #
1558 82       ADD    A,D          ; #
1559 04       INC    B            ; #
155A 2F       CPL                 ; #
155B 8F       ADC    A,A          ; #
155C 82       ADD    A,D          ; #
155D 04       INC    B            ; #
155E 5D       LD     E,L          ; #
155F 52       LD     D,D          ; #
1560 45       LD     B,L          ; #
1561 53       LD     D,E          ; #
1562 55       LD     D,L          ; #
1563 4C       LD     C,H          ; #
1564 54       LD     D,H          ; #
1565 53       LD     D,E          ; #
1566 5D       LD     E,L          ; #
1567 2F       CPL                 ; #
1568 328305   LD     ($0583),A    ; #
156B 53       LD     D,E          ; #
156C 48       LD     C,B          ; #
156D 4F       LD     C,A          ; #
156E 54       LD     D,H          ; #
156F 53       LD     D,E          ; #
1570 2046     JR     NZ,$15B8     ; #
1572 49       LD     C,C          ; #
1573 52       LD     D,D          ; #
1574 45       LD     B,L          ; #
1575 44       LD     B,H          ; #
1576 2020     JR     NZ,$1598     ; #
1578 2020     JR     NZ,$159A     ; #
157A 2020     JR     NZ,$159C     ; #
157C 2020     JR     NZ,$159E     ; #
157E 2020     JR     NZ,$15A0     ; #
1580 2F       CPL                 ; #
1581 05       DEC    B            ; #
1582 2020     JR     NZ,$15A4     ; #
1584 4D       LD     C,L          ; #
1585 49       LD     C,C          ; #
1586 53       LD     D,E          ; #
1587 53       LD     D,E          ; #
1588 49       LD     C,C          ; #
1589 4C       LD     C,H          ; #
158A 45       LD     B,L          ; #
158B 53       LD     D,E          ; #
158C 2F       CPL                 ; #
158D 35       DEC    (HL)         ; #
158E 83       ADD    A,E          ; #
158F 05       DEC    B            ; #
1590 4E       LD     C,(HL)       ; #
1591 55       LD     D,L          ; #
1592 4D       LD     C,L          ; #
1593 42       LD     B,D          ; #
1594 45       LD     B,L          ; #
1595 52       LD     D,D          ; #
1596 204F     JR     NZ,$15E7     ; #
1598 46       LD     B,(HL)       ; #
1599 2048     JR     NZ,$15E3     ; #
159B 49       LD     C,C          ; #
159C 54       LD     D,H          ; #
159D 53       LD     D,E          ; #
159E 2020     JR     NZ,$15C0     ; #
15A0 2020     JR     NZ,$15C2     ; #
15A2 2020     JR     NZ,$15C4     ; #
15A4 202F     JR     NZ,$15D5     ; #
15A6 3883     JR     C,$152B      ; #
15A8 03       INC    BC           ; #
15A9 48       LD     C,B          ; #
15AA 49       LD     C,C          ; #
15AB 54       LD     D,H          ; #
15AC 5D       LD     E,L          ; #
15AD 4D       LD     C,L          ; #
15AE 49       LD     C,C          ; #
15AF 53       LD     D,E          ; #
15B0 53       LD     D,E          ; #
15B1 2052     JR     NZ,$1605     ; #
15B3 41       LD     B,C          ; #
15B4 54       LD     D,H          ; #
15B5 49       LD     C,C          ; #
15B6 4F       LD     C,A          ; #
15B7 2020     JR     NZ,$15D9     ; #
15B9 2020     JR     NZ,$15DB     ; #
15BB 2020     JR     NZ,$15DD     ; #
15BD 202F     JR     NZ,$15EE     ; #
15BF 03       INC    BC           ; #
15C0 24       INC    H            ; #
15C1 60       LD     H,B          ; #
15C2 2F       CPL                 ; #
15C3 2F       CPL                 ; #
15C4 83       ADD    A,E          ; #
15C5 05       DEC    B            ; #
15C6 315354   LD     SP,$5453     ; #
15C9 2042     JR     NZ,$160D     ; #
15CB 4F       LD     C,A          ; #
15CC 4E       LD     C,(HL)       ; #
15CD 55       LD     D,L          ; #
15CE 53       LD     D,E          ; #
15CF 2046     JR     NZ,$1617     ; #
15D1 4F       LD     C,A          ; #
15D2 52       LD     D,D          ; #
15D3 2020     JR     NZ,$15F5     ; #
15D5 202F     JR     NZ,$1606     ; #
15D7 328305   LD     ($0583),A    ; #
15DA 324E44   LD     ($444E),A    ; #
15DD 2042     JR     NZ,$1621     ; #
15DF 4F       LD     C,A          ; #
15E0 4E       LD     C,(HL)       ; #
15E1 55       LD     D,L          ; #
15E2 53       LD     D,E          ; #
15E3 2046     JR     NZ,$162B     ; #
15E5 4F       LD     C,A          ; #
15E6 52       LD     D,D          ; #
15E7 2020     JR     NZ,$1609     ; #
15E9 202F     JR     NZ,$161A     ; #
15EB 35       DEC    (HL)         ; #
15EC 83       ADD    A,E          ; #
15ED 05       DEC    B            ; #
15EE 41       LD     B,C          ; #
15EF 4E       LD     C,(HL)       ; #
15F0 44       LD     B,H          ; #
15F1 2046     JR     NZ,$1639     ; #
15F3 4F       LD     C,A          ; #
15F4 52       LD     D,D          ; #
15F5 2045     JR     NZ,$163C     ; #
15F7 56       LD     D,(HL)       ; #
15F8 45       LD     B,L          ; #
15F9 52       LD     D,D          ; #
15FA 59       LD     E,C          ; #
15FB 2020     JR     NZ,$161D     ; #
15FD 202F     JR     NZ,$162E     ; #
15FF 05       DEC    B            ; #
1600 3030     JR     NZ,$1632     ; #
1602 3030     JR     NZ,$1634     ; #
1604 2050     JR     NZ,$1656     ; #
1606 54       LD     D,H          ; #
1607 53       LD     D,E          ; #
1608 2F       CPL                 ; #

; FFs (RST 38H) From here to next

; PLAY COMMAND 03 (??)
1700 ED5B8292 LD     DE,($9282)   ;
1704 1A       LD     A,(DE)       ;
1705 07       RLCA                ;
1706 07       RLCA                ;
1707 07       RLCA                ;
1708 E607     AND    #07          ;
170A 211317   LD     HL,$1713     ;
170D CF       RST    08H          ;
170E 7E       LD     A,(HL)       ;
170F 23       INC    HL           ;
1710 66       LD     H,(HL)       ;
1711 6F       LD     L,A          ;
1712 E9       JP     (HL)         ; Sub command

1713 6617; # These have something to do with
1715 6617; # The demo play.
1717 1F17; #
1719 6617; #
171B 3417; #
171D 2D17; #

; Subcommand 02
171F 3AA092   LD     A,($92A0)    ;
1722 E60F     AND    #0F          ;
1724 C0       RET    NZ           ;
1725 210792   LD     HL,$9207     ;
1728 35       DEC    (HL)         ;
1729 C0       RET    NZ           ;
172A C36617   JP     $1766        ;

; Subcommand 05
172D CD151F   CALL   $1F15        ;
1730 ED5B8292 LD     DE,($9282)   ;

; Subcommand 04
1734 1A       LD     A,(DE)       ;
1735 212798   LD     HL,$9827     ;
1738 5E       LD     E,(HL)       ;
1739 CB47     BIT    0,A          ;
173B 2004     JR     NZ,$1741     ;
173D E60A     AND    #0A          ;
173F 1814     JR     $1755        ;
1741 3A0992   LD     A,($9209)    ;
1744 6F       LD     L,A          ;
1745 2693     LD     H,#93        ;
1747 3A6293   LD     A,($9362)    ;
174A 96       SUB    (HL)         ;
174B 3E0A     LD     A,#0A        ;
174D 2806     JR     Z,$1755      ;
174F 3E08     LD     A,#08        ;
1751 3802     JR     C,$1755      ;
1753 3E02     LD     A,#02        ;
1755 CD981F   CALL   $1F98        ;
1758 3AA092   LD     A,($92A0)    ;
175B E603     AND    #03          ;
175D C0       RET    NZ           ;
175E 210792   LD     HL,$9207     ;
1761 35       DEC    (HL)         ;
1762 C0       RET    NZ           ;
1763 CD151F   CALL   $1F15        ;

; Subcommand 00,01,03
1766 ED5B8292 LD     DE,($9282)   ;
176A 1A       LD     A,(DE)       ;
176B E6C0     AND    #C0          ;
176D FE80     CP     #80          ;
176F 2001     JR     NZ,$1772     ;
1771 13       INC    DE           ;
1772 13       INC    DE           ;
1773 1A       LD     A,(DE)       ;
1774 ED538292 LD     ($9282),DE   ;
1778 07       RLCA                ;
1779 07       RLCA                ;
177A 07       RLCA                ;
177B E607     AND    #07          ;
177D 218617   LD     HL,$1786     ;
1780 CF       RST    08H          ;
1781 7E       LD     A,(HL)       ;
1782 23       INC    HL           ;
1783 66       LD     H,(HL)       ;
1784 6F       LD     L,A          ;
1785 E9       JP     (HL)         ;

1786 9417       RLA                 ; #
1788 9417       RLA                 ; #
178A A117       RLA                 ; #
178C A817       RLA                 ; #
178E AE17       RLA                 ; #
1790 AE17       RLA                 ; #
1792 9C17       RLA                 ; #

; Secondsubcommand 00,01
1794 1A       LD     A,(DE)       ;
1795 07       RLCA                ;
1796 E67E     AND    #7E          ;
1798 320992   LD     ($9209),A    ;
179B C9       RET                 ;

; Secondsubcommand 06
179C AF       XOR    A            ;
179D 320390   LD     ($9003),A    ;
17A0 C9       RET                 ;

; Secondsubcommand 02
17A1 1A       LD     A,(DE)       ;
17A2 E61F     AND    #1F          ;
17A4 320792   LD     ($9207),A    ;
17A7 C9       RET                 ;

; Secondsubcommand 03
17A8 1A       LD     A,(DE)       ;
17A9 E61F     AND    #1F          ;
17AB 4F       LD     C,A          ;
17AC F7       RST    30H          ;
17AD C9       RET                 ;

; Secondsubcommand 04,05
17AE 13       INC    DE           ;
17AF 1A       LD     A,(DE)       ;
17B0 18F2     JR     $17A4        ;

; PLAY COMMAND 02 (??)
17B2 3A0192   LD     A,($9201)    ;
17B5 3D       DEC    A            ;
17B6 C0       RET    NZ           ;
17B7 3A0392   LD     A,($9203)    ;
17BA 21C317   LD     HL,$17C3     ;
17BD CF       RST    08H          ;
17BE 5E       LD     E,(HL)       ;
17BF 23       INC    HL           ;
17C0 56       LD     D,(HL)       ;
17C1 EB       EX     DE,HL        ;
17C2 E9       JP     (HL)         ;

17C3 4019; # Looks like more demo 
17C5 4819; # routines
17C7 8419; #
17C9 D918; #
17CB D118; #
17CD AC18; #
17CF 4019; #
17D1 F517; #
17D3 5218; #
17D5 D118; #
17D7 0818; #
17D9 D118; #
17DB 4018; #
17DD 4019; #
17DF E117; # Do High Score stuff

17E1 3AAF92   LD     A,($92AF)    ;
17E4 A7       AND    A            ;
17E5 2805     JR     Z,$17EC      ;
17E7 3D       DEC    A            ;
17E8 CAA719   JP     Z,$19A7      ;
17EB C9       RET                 ;

17EC CD1432   CALL   $3214        ;
17EF 3E0A     LD     A,#0A        ;
17F1 32AF92   LD     ($92AF),A    ;
17F4 C9       RET                 ;

17F5 3AA092   LD     A,($92A0)    ;
17F8 E61F     AND    #1F          ;
17FA FE1F     CP     #1F          ;
17FC C0       RET    NZ           ;
17FD 3E01     LD     A,#01        ;
17FF 320590   LD     ($9005),A    ;
1802 0E02     LD     C,#02        ;
1804 F7       RST    30H          ;
1805 C3A719   JP     $19A7        ;

1808 CD4C13   CALL   $134C        ;
180B 211F18   LD     HL,$181F     ;
180E 228292   LD     ($9282),HL   ;
1811 3E01     LD     A,#01        ;
1813 320390   LD     ($9003),A    ;
1816 321590   LD     ($9015),A    ;
1819 322590   LD     ($9025),A    ;
181C C3A719   JP     $19A7        ;

181F 08       EX     AF,A'F'      ;
1820 188A     JR     $17AC        ;

1822 08       EX     AF,A'F'      ;
1823 88       ADC    A,B          ;
1824 0681     LD     B,#81        ;
1826 2881     JR     Z,$17A9      ;
1828 05       DEC    B            ;
1829 54       LD     D,H          ;
182A 1A       LD     A,(DE)       ;
182B 88       ADC    A,B          ;
182C 12       LD     (DE),A       ;
182D 81       ADD    A,C          ;
182E 0F       RRCA                ;
182F A2       AND    D            ;
1830 16AA     LD     D,#AA        ;
1832 14       INC    D            ;
1833 88       ADC    A,B          ;
1834 1888     JR     $17BE        ;
1836 1043     DJNZ   $187B        ;
1838 82       ADD    A,D          ;
1839 1088     DJNZ   $17C3        ;
183B 06A2     LD     B,#A2        ;
183D 2056     JR     NZ,$1895     ;
183F C0       RET    NZ           ;
1840 EF       RST    28H          ;
1841 CD4212   CALL   $1242        ;
1844 AF       XOR    A            ;
1845 321090   LD     ($9010),A    ;
1848 320B92   LD     ($920B),A    ; Disable shots
184B 3C       INC    A            ;
184C 320290   LD     ($9002),A    ;
184F C3A719   JP     $19A7        ;
1852 AF       XOR    A            ;
1853 322B98   LD     ($982B),A    ;
1856 3C       INC    A            ;
1857 32B79A   LD     ($9AB7),A    ;
185A 322198   LD     ($9821),A    ;
185D 320390   LD     ($9003),A    ;
1860 321590   LD     ($9015),A    ;
1863 322598   LD     ($9825),A    ;
1866 218718   LD     HL,$1887     ;
1869 228292   LD     ($9282),HL   ;
186C CDC501   CALL   $01C5        ;
186F CD4C13   CALL   $134C        ;
1872 3E01     LD     A,#01        ;
1874 320B92   LD     ($920B),A    ; One shot
1877 324298   LD     ($9842),A    ;
187A 322C98   LD     ($982C),A    ;
187D 3C       INC    A            ;
187E 32C499   LD     ($99C4),A    ;
1881 32C599   LD     ($99C5),A    ;
1884 C3A719   JP     $19A7        ;
1887 02       LD     (BC),A       ;
1888 8A       ADC    A,D          ;
1889 04       INC    B            ;
188A 82       ADD    A,D          ;
188B 07       RLCA                ;
188C AA       XOR    D            ;
188D 2888     JR     Z,$1817      ;
188F 10AA     DJNZ   $183B        ;
1891 3882     JR     C,$1815      ;
1893 12       LD     (DE),A       ;
1894 AA       XOR    D            ;
1895 2088     JR     NZ,$181F     ;
1897 14       INC    D            ;
1898 AA       XOR    D            ;
1899 2082     JR     NZ,$181D     ;
189B 06A8     LD     B,#A8        ;
189D 0EA2     LD     C,#A2        ;
189F 17       RLA                 ;
18A0 88       ADC    A,B          ;
18A1 12       LD     (DE),A       ;
18A2 A2       AND    D            ;
18A3 14       INC    D            ;
18A4 1888     JR     $182E        ;
18A6 1B       DEC    DE           ;
18A7 81       ADD    A,C          ;
18A8 2A5F4C   LD     HL,($4C5F)   ;
18AB C0       RET    NZ           ;
18AC 3AAE92   LD     A,($92AE)    ;
18AF A7       AND    A            ;
18B0 2809     JR     Z,$18BB      ;
18B2 3D       DEC    A            ;
18B3 CAA719   JP     Z,$19A7      ;
18B6 FE05     CP     #05          ;
18B8 280C     JR     Z,$18C6      ;
18BA C9       RET                 ;

18BB 3E34     LD     A,#34        ;
18BD 323492   LD     ($9234),A    ;
18C0 3E09     LD     A,#09        ;
18C2 32AE92   LD     ($92AE),A    ;
18C5 C9       RET                 ;

18C6 AF       XOR    A            ;
18C7 326293   LD     ($9362),A    ;
18CA 0E13     LD     C,#13        ;
18CC F7       RST    30H          ;
18CD 0E14     LD     C,#14        ;
18CF F7       RST    30H          ;
18D0 C9       RET                 ;

18D1 3A0390   LD     A,($9003)    ;
18D4 A7       AND    A            ;
18D5 CAA719   JP     Z,$19A7      ;
18D8 C9       RET                 ;

18D9 0607     LD     B,#07        ; Do this ...
18DB CD9E12   CALL   $129E        ; ...
18DE 10FB     DJNZ   $18DB        ; ... seven times.
18E0 AF       XOR    A            ;
18E1 322098   LD     ($9820),A    ;
18E4 320590   LD     ($9005),A    ;
18E7 CD4C13   CALL   $134C        ;
18EA 210DFF   LD     HL,$FF0D     ;
18ED 22C592   LD     ($92C5),HL   ;
18F0 22C492   LD     ($92C4),HL   ;
18F3 22C192   LD     ($92C1),HL   ;
18F6 22C092   LD     ($92C0),HL   ;
18F9 212819   LD     HL,$1928     ;
18FC 228292   LD     ($9282),HL   ;
18FF AF       XOR    A            ;
1900 0610     LD     B,#10        ;
1902 21CA92   LD     HL,$92CA     ;
1905 DF       RST    18H          ;
1906 322798   LD     ($9827),A    ;
1909 320B92   LD     ($920B),A    ; Disable shots
190C 3C       INC    A            ;
190D 322B98   LD     ($982B),A    ;
1910 321090   LD     ($9010),A    ;
1913 320B90   LD     ($900B),A    ;
1916 320390   LD     ($9003),A    ;
1919 3A0368   LD     A,($6803)    ;
191C 0F       RRCA                ;
191D E601     AND    #01          ;
191F 32B79A   LD     ($9AB7),A    ;
1922 CD7B12   CALL   $127B        ;
1925 C3A719   JP     $19A7        ;

1928 08       EX     AF,A'F'      ;
1929 1B       DEC    DE           ;
192A 81       ADD    A,C          ;
192B 3D       DEC    A            ;
192C 81       ADD    A,C          ;
192D 0A       LD     A,(BC)       ;
192E 42       LD     B,D          ;
192F 19       ADD    HL,DE        ;
1930 81       ADD    A,C          ;
1931 2881     JR     Z,$18B4      ;
1933 08       EX     AF,A'F'      ;
1934 1881     JR     $18B7        ;

1936 2E81     LD     L,#81        ;
1938 03       INC    BC           ;
1939 1A       LD     A,(DE)       ;
193A 81       ADD    A,C          ;
193B 118105   LD     DE,$0581     ;
193E 42       LD     B,D          ;
193F C0       RET    NZ           ;
1940 CD6001   CALL   $0160        ;
1943 CD3C00   CALL   $003C        ;
1946 185F     JR     $19A7        ;
1948 215C19   LD     HL,$195C     ;
194B 228092   LD     ($9280),HL   ;
194E AF       XOR    A            ;
194F 320592   LD     ($9205),A    ;
1952 32A892   LD     ($92A8),A    ;
1955 3E02     LD     A,#02        ;
1957 32AE92   LD     ($92AE),A    ;
195A 184B     JR     $19A7        ;

195C 08       EX     AF,A'F'      ;
195D 1B       DEC    DE           ;
195E 44       LD     B,H          ;
195F 3A0A12   LD     A,($120A)    ;
1962 44       LD     B,H          ;
1963 42       LD     B,D          ;
1964 0C       INC    C            ;
1965 08       EX     AF,A'F'      ;
1966 7C       LD     A,H          ;
1967 50       LD     D,B          ;
1968 34       INC    (HL)         ;
1969 08       EX     AF,A'F'      ;
196A 34       INC    (HL)         ;
196B 5C       LD     E,H          ;
196C 3008     JR     NZ,$1976     ;
196E 64       LD     H,H          ;
196F 5C       LD     E,H          ;
1970 320894   LD     ($9408),A    ;
1973 5C       LD     E,H          ;
1974 4A       LD     C,D          ;
1975 12       LD     (DE),A       ;
1976 A4       AND    H            ;
1977 64       LD     H,H          ;
1978 3608     LD     (HL),#08     ;
197A C45C58   CALL   NZ,$585C     ;
197D 12       LD     (DE),A       ;
197E B4       OR     H            ;
197F 64       LD     H,H          ;
1980 52       LD     D,D          ;

1981 12       LD     (DE),A       ;
1982 D4643A   CALL   NC,$3A64     ;
1985 AE       XOR    (HL)         ;
1986 92       SUB    D            ;
1987 A7       AND    A            ;
1988 C0       RET    NZ           ;
1989 3E02     LD     A,#02        ;
198B 32AE92   LD     ($92AE),A    ;
198E 3A0592   LD     A,($9205)    ;
1991 FE05     CP     #05          ;
1993 2812     JR     Z,$19A7      ;
1995 3C       INC    A            ;
1996 320592   LD     ($9205),A    ;
1999 C60D     ADD    A,#0D        ;
199B 4F       LD     C,A          ;
199C F7       RST    30H          ;
199D 3A0592   LD     A,($9205)    ;
19A0 FE03     CP     #03          ;
19A2 D8       RET    C            ;
19A3 CD9E12   CALL   $129E        ;
19A6 C9       RET                 ;
19A7 210392   LD     HL,$9203     ;
19AA 34       INC    (HL)         ;
19AB 7E       LD     A,(HL)       ;
19AC FE0F     CP     #0F          ;
19AE C0       RET    NZ           ;
19AF 3600     LD     (HL),#00     ;
19B1 C9       RET                 ;

;======================================================================
; PLAY COMMAND 11
;
19B2 3A8E92   LD     A,($928E)    ;
19B5 A7       AND    A            ;
19B6 201A     JR     NZ,$19D2     ;
19B8 21AD92   LD     HL,$92AD     ;
19BB B6       OR     (HL)         ;
19BC 2828     JR     Z,$19E6      ;
19BE FE04     CP     #04          ;
19C0 2005     JR     NZ,$19C7     ;
19C2 3D       DEC    A            ;
19C3 77       LD     (HL),A       ;
19C4 32A99A   LD     ($9AA9),A    ;
19C7 3A2998   LD     A,($9829)    ;
19CA C60D     ADD    A,#0D        ;
19CC 6F       LD     L,A          ;
19CD 2691     LD     H,#91        ;
19CF 3604     LD     (HL),#04     ;
19D1 C9       RET                 ;

19D2 0E0A     LD     C,#0A        ;
19D4 F7       RST    30H          ;
19D5 3E06     LD     A,#06        ;
19D7 32AD92   LD     ($92AD),A    ;
19DA 3C       INC    A            ;
19DB 32638B   LD     ($8B63),A    ;
19DE AF       XOR    A            ;
19DF 328B92   LD     ($928B),A    ;
19E2 328E92   LD     ($928E),A    ;
19E5 C9       RET                 ;

19E6 3AD182   LD     A,($82D1)    ;
19E9 FE24     CP     #24          ;
19EB 2829     JR     Z,$1A16      ;
19ED 216293   LD     HL,$9362     ;
19F0 3A2898   LD     A,($9828)    ;
19F3 E607     AND    #07          ;
19F5 5F       LD     E,A          ;
19F6 54       LD     D,H          ;
19F7 7E       LD     A,(HL)       ;
19F8 12       LD     (DE),A       ;
19F9 3600     LD     (HL),#00     ;
19FB 2C       INC    L            ;
19FC 1C       INC    E            ;
19FD 7E       LD     A,(HL)       ;
19FE 12       LD     (DE),A       ;
19FF 269B     LD     H,#9B        ;
1A01 54       LD     D,H          ;
1A02 EDA8     LDD                 ;
1A04 EDA0     LDI                 ;
1A06 268B     LD     H,#8B        ;
1A08 6B       LD     L,E          ;
1A09 3607     LD     (HL),#07     ;
1A0B 2D       DEC    L            ;
1A0C 3607     LD     (HL),#07     ;
1A0E 0E0B     LD     C,#0B        ;
1A10 21B183   LD     HL,$83B1     ;
1A13 CDB313   CALL   $13B3        ;
1A16 3A2898   LD     A,($9828)    ;
1A19 6F       LD     L,A          ;
1A1A E607     AND    #07          ;
1A1C 5F       LD     E,A          ;
1A1D 2688     LD     H,#88        ;
1A1F 3A1592   LD     A,($9215)    ;
1A22 4F       LD     C,A          ;
1A23 7E       LD     A,(HL)       ;
1A24 FE09     CP     #09          ;
1A26 201D     JR     NZ,$1A45     ;
1A28 2693     LD     H,#93        ;
1A2A 54       LD     D,H          ;
1A2B 7E       LD     A,(HL)       ;
1A2C 12       LD     (DE),A       ;
1A2D 2C       INC    L            ;
1A2E 1C       INC    E            ;
1A2F 3E10     LD     A,#10        ;
1A31 CB41     BIT    0,C          ;
1A33 2802     JR     Z,$1A37      ;
1A35 ED44     NEG                 ;
1A37 47       LD     B,A          ;
1A38 86       ADD    A,(HL)       ;
1A39 12       LD     (DE),A       ;
1A3A 1F       RRA                 ;
1A3B A8       XOR    B            ;
1A3C 07       RLCA                ;
1A3D E601     AND    #01          ;
1A3F 269B     LD     H,#9B        ;
1A41 54       LD     D,H          ;
1A42 AE       XOR    (HL)         ; FA NOPE
1A43 12       LD     (DE),A       ;
1A44 C9       RET                 ;
1A45 218B92   LD     HL,$928B     ;
1A48 7E       LD     A,(HL)       ;
1A49 A7       AND    A            ;
1A4A 2005     JR     NZ,$1A51     ;
1A4C 168B     LD     D,#8B        ;
1A4E 3E06     LD     A,#06        ;
1A50 12       LD     (DE),A       ;
1A51 34       INC    (HL)         ;
1A52 FE24     CP     #24          ;
1A54 281A     JR     Z,$1A70      ;
1A56 0601     LD     B,#01        ;
1A58 CB41     BIT    0,C          ;
1A5A 2002     JR     NZ,$1A5E     ;
1A5C 05       DEC    B            ;
1A5D 05       DEC    B            ;
1A5E 6B       LD     L,E          ;
1A5F 2C       INC    L            ;
1A60 2693     LD     H,#93        ;
1A62 78       LD     A,B          ;
1A63 86       ADD    A,(HL)       ;
1A64 77       LD     (HL),A       ;
1A65 1F       RRA                 ;
1A66 A8       XOR    B            ;
1A67 07       RLCA                ;
1A68 D0       RET    NC           ;
1A69 269B     LD     H,#9B        ;
1A6B 7E       LD     A,(HL)       ;
1A6C EE01     XOR    #01          ;
1A6E 77       LD     (HL),A       ;
1A6F C9       RET                 ;
1A70 AF       XOR    A            ;
1A71 321190   LD     ($9011),A    ;
1A74 32A99A   LD     ($9AA9),A    ;
1A77 1688     LD     D,#88        ;
1A79 3C       INC    A            ;
1A7A 12       LD     (DE),A       ;
1A7B 322898   LD     ($9828),A    ;
1A7E 32B999   LD     ($99B9),A    ;
1A81 3C       INC    A            ;
1A82 321392   LD     ($9213),A    ;
1A85 C9       RET                 ;

; PLAY COMMAND 04 (??)
1A86 3ACA99   LD     A,($99CA)    ;
1A89 4F       LD     C,A          ;
1A8A 3AA792   LD     A,($92A7)    ;
1A8D B9       CP     C            ;
1A8E D0       RET    NC           ;
1A8F 3A4198   LD     A,($9841)    ;
1A92 A7       AND    A            ;
1A93 2046     JR     NZ,$1ADB     ;
1A95 210788   LD     HL,$8807     ;
1A98 01FF14   LD     BC,$14FF     ;
1A9B 3E01     LD     A,#01        ;
1A9D 2C       INC    L            ;
1A9E EDA1     CPI                 ;
1AA0 280F     JR     Z,$1AB1      ;
1AA2 10F9     DJNZ   $1A9D        ;
1AA4 213F88   LD     HL,$883F     ;
1AA7 0610     LD     B,#10        ;
1AA9 2C       INC    L            ;
1AAA EDA1     CPI                 ;
1AAC 2803     JR     Z,$1AB1      ;
1AAE 10F9     DJNZ   $1AA9        ;
1AB0 C9       RET                 ;
1AB1 3EC0     LD     A,#C0        ;
1AB3 324198   LD     ($9841),A    ;
1AB6 2D       DEC    L            ;
1AB7 5D       LD     E,L          ;
1AB8 168B     LD     D,#8B        ;
1ABA 1C       INC    E            ;
1ABB 1A       LD     A,(DE)       ;
1ABC 1D       DEC    E            ;
1ABD 4F       LD     C,A          ;
1ABE 3A2198   LD     A,($9821)    ;
1AC1 CB3F     SRL    A            ;
1AC3 CB3F     SRL    A            ;
1AC5 6F       LD     L,A          ;
1AC6 2600     LD     H,#00        ;
1AC8 3E03     LD     A,#03        ;
1ACA CD6110   CALL   $1061        ;
1ACD C604     ADD    A,#04        ;
1ACF 212D98   LD     HL,$982D     ;
1AD2 73       LD     (HL),E       ;
1AD3 2C       INC    L            ;
1AD4 71       LD     (HL),C       ;
1AD5 2C       INC    L            ;
1AD6 77       LD     (HL),A       ;
1AD7 32B29A   LD     ($9AB2),A    ;
1ADA C9       RET                 ;
1ADB 3C       INC    A            ;
1ADC 281C     JR     Z,$1AFA      ;
1ADE 324198   LD     ($9841),A    ;
1AE1 08       EX     AF,A'F'      ;
1AE2 212D98   LD     HL,$982D     ;
1AE5 5E       LD     E,(HL)       ;
1AE6 1688     LD     D,#88        ;
1AE8 1A       LD     A,(DE)       ;
1AE9 3D       DEC    A            ;
1AEA C25A1B   JP     NZ,$1B5A     ;
1AED 168B     LD     D,#8B        ;
1AEF 2C       INC    L            ;
1AF0 08       EX     AF,A'F'      ;
1AF1 CB67     BIT    4,A          ;
1AF3 2801     JR     Z,$1AF6      ;
1AF5 2C       INC    L            ;
1AF6 7E       LD     A,(HL)       ;
1AF7 1C       INC    E            ;
1AF8 12       LD     (DE),A       ;
1AF9 C9       RET                 ;
1AFA 3A1590   LD     A,($9015)    ;
1AFD A7       AND    A            ;
1AFE 2006     JR     NZ,$1B06     ;
1B00 3EE0     LD     A,#E0        ;
1B02 324198   LD     ($9841),A    ;
1B05 C9       RET                 ;
1B06 3A2D98   LD     A,($982D)    ;
1B09 6F       LD     L,A          ;
1B0A 2688     LD     H,#88        ;
1B0C 7E       LD     A,(HL)       ;
1B0D 3D       DEC    A            ;
1B0E 204A     JR     NZ,$1B5A     ;
1B10 2692     LD     H,#92        ;
1B12 7E       LD     A,(HL)       ;
1B13 CB7F     BIT    7,A          ;
1B15 2043     JR     NZ,$1B5A     ;
1B17 3A2F98   LD     A,($982F)    ;
1B1A D604     SUB    #04          ;
1B1C 215F1B   LD     HL,$1B5F     ;
1B1F CF       RST    08H          ;
1B20 11B099   LD     DE,$99B0     ;
1B23 3E03     LD     A,#03        ;
1B25 12       LD     (DE),A       ;
1B26 1C       INC    E            ;
1B27 EDA0     LDI                 ;
1B29 EDA0     LDI                 ;
1B2B 3A2F98   LD     A,($982F)    ;
1B2E D604     SUB    #04          ;
1B30 E60F     AND    #0F          ;
1B32 4F       LD     C,A          ;
1B33 21651B   LD     HL,$1B65     ;
1B36 CF       RST    08H          ;
1B37 5E       LD     E,(HL)       ;
1B38 23       INC    HL           ;
1B39 56       LD     D,(HL)       ;
1B3A 268B     LD     H,#8B        ;
1B3C 3A2D98   LD     A,($982D)    ;
1B3F 6F       LD     L,A          ;
1B40 79       LD     A,C          ;
1B41 07       RLCA                ;
1B42 07       RLCA                ;
1B43 07       RLCA                ;
1B44 C656     ADD    A,#56        ;
1B46 4E       LD     C,(HL)       ;
1B47 77       LD     (HL),A       ;
1B48 79       LD     A,C          ;
1B49 E6F8     AND    #F8          ;
1B4B 4F       LD     C,A          ;
1B4C 3A2E98   LD     A,($982E)    ;
1B4F E607     AND    #07          ;
1B51 B1       OR     C            ;
1B52 322E98   LD     ($982E),A    ;
1B55 2688     LD     H,#88        ;
1B57 CD8310   CALL   $1083        ; Process next moving bee
1B5A AF       XOR    A            ;
1B5B 320490   LD     ($9004),A    ;
1B5E C9       RET                 ;
1B5F 1EBD     LD     E,#BD        ;
1B61 0A       LD     A,(BC)       ;
1B62 B8       CP     B            ;
1B63 14       INC    D            ;
1B64 BC       CP     H            ;
1B65 EA0473   JP     PE,$7304     ; #
1B68 04       INC    B            ;
1B69 AB       XOR    E            ;
1B6A 04       INC    B            ;

;======================================================================
; PLAY COMMAND 10
;
1B6B 3A0B92   LD     A,($920B)    ;
1B6E A7       AND    A            ;
1B6F 280A     JR     Z,$1B7B      ;
1B71 3A1590   LD     A,($9015)    ;
1B74 4F       LD     C,A          ;
1B75 3A1D90   LD     A,($901D)    ;
1B78 2F       CPL                 ;
1B79 A1       AND    C            ;
1B7A C8       RET    Z            ;
1B7B 0604     LD     B,#04        ;
1B7D 21CA92   LD     HL,$92CA     ;
1B80 7E       LD     A,(HL)       ;
1B81 3C       INC    A            ;
1B82 200D     JR     NZ,$1B91     ;
1B84 2C       INC    L            ;
1B85 2C       INC    L            ;
1B86 2C       INC    L            ;
1B87 10F7     DJNZ   $1B80        ;
1B89 3AA092   LD     A,($92A0)    ;
1B8C E60F     AND    #0F          ;
1B8E 281E     JR     Z,$1BAE      ;
1B90 C9       RET                 ;
1B91 36FF     LD     (HL),#FF     ;
1B93 3D       DEC    A            ;
1B94 1688     LD     D,#88        ;
1B96 5F       LD     E,A          ;
1B97 CBBB     RES    7,E          ;
1B99 08       EX     AF,A'F'      ;
1B9A 1A       LD     A,(DE)       ;
1B9B 3D       DEC    A            ;
1B9C C0       RET    NZ           ;
1B9D 2C       INC    L            ;
1B9E 5E       LD     E,(HL)       ;
1B9F 2C       INC    L            ;
1BA0 56       LD     D,(HL)       ;
1BA1 08       EX     AF,A'F'      ;
1BA2 6F       LD     L,A          ;
1BA3 2688     LD     H,#88        ;
1BA5 CD7910   CALL   $1079        ;
1BA8 3E01     LD     A,#01        ;
1BAA 32B39A   LD     ($9AB3),A    ;
1BAD C9       RET                 ;
1BAE 21C092   LD     HL,$92C0     ;
1BB1 0603     LD     B,#03        ;
1BB3 35       DEC    (HL)         ;
1BB4 2804     JR     Z,$1BBA      ;
1BB6 2C       INC    L            ;
1BB7 10FA     DJNZ   $1BB3        ;
1BB9 C9       RET                 ;
1BBA 3AC499   LD     A,($99C4)    ;
1BBD 4F       LD     C,A          ;
1BBE 3A8792   LD     A,($9287)    ;
1BC1 B9       CP     C            ;
1BC2 3802     JR     C,$1BC6      ;
1BC4 34       INC    (HL)         ;
1BC5 C9       RET                 ;
1BC6 CBD5     SET    2,L          ;
1BC8 7E       LD     A,(HL)       ;
1BC9 CB95     RES    2,L          ;
1BCB 77       LD     (HL),A       ;
1BCC 78       LD     A,B          ;
1BCD 3D       DEC    A            ;
1BCE 21D71B   LD     HL,$1BD7     ;
1BD1 CF       RST    08H          ;
1BD2 7E       LD     A,(HL)       ;
1BD3 23       INC    HL           ;
1BD4 66       LD     H,(HL)       ;
1BD5 6F       LD     L,A          ;
1BD6 E9       JP     (HL)         ;
1BD7 DD       ???                 ;
1BD8 1B       DEC    DE           ;
1BD9 FD       ???                 ;
1BDA 1B       DEC    DE           ;
1BDB 07       RLCA                ;
1BDC 1C       INC    E            ;
1BDD 0614     LD     B,#14        ;
1BDF 210888   LD     HL,$8808     ;
1BE2 114F03   LD     DE,$034F     ;
1BE5 3A2D98   LD     A,($982D)    ;
1BE8 4F       LD     C,A          ;
1BE9 7E       LD     A,(HL)       ;
1BEA 3D       DEC    A            ;
1BEB 2004     JR     NZ,$1BF1     ;
1BED 79       LD     A,C          ;
1BEE BD       CP     L            ;
1BEF 2005     JR     NZ,$1BF6     ;
1BF1 2C       INC    L            ;
1BF2 2C       INC    L            ;
1BF3 10F4     DJNZ   $1BE9        ;
1BF5 C9       RET                 ;
1BF6 32B39A   LD     ($9AB3),A    ;
1BF9 CD8310   CALL   $1083        ; Process next moving bee
1BFC C9       RET                 ;
1BFD 0610     LD     B,#10        ;
1BFF 214088   LD     HL,$8840     ;
1C02 11A903   LD     DE,$03A9     ;
1C05 18DE     JR     $1BE5        ;
1C07 3A2B98   LD     A,($982B)    ;
1C0A A7       AND    A            ;
1C0B 2029     JR     NZ,$1C36     ;
1C0D 212C98   LD     HL,$982C     ;
1C10 34       INC    (HL)         ;
1C11 CB46     BIT    0,(HL)       ;
1C13 2021     JR     NZ,$1C36     ;
1C15 DD       ???                 ;
1C16 2E02     LD     L,#02        ;
1C18 FD215404 LD     IY,$0454     ;
1C1C 113088   LD     DE,$8830     ;
1C1F 0604     LD     B,#04        ;
1C21 1A       LD     A,(DE)       ;
1C22 3D       DEC    A            ;
1C23 2805     JR     Z,$1C2A      ;
1C25 1C       INC    E            ;
1C26 1C       INC    E            ;
1C27 10F8     DJNZ   $1C21        ;
1C29 C9       RET                 ;
1C2A 3E01     LD     A,#01        ;
1C2C 322B98   LD     ($982B),A    ;
1C2F 7B       LD     A,E          ;
1C30 322898   LD     ($9828),A    ;
1C33 C3B41C   JP     $1CB4        ;
1C36 21321D   LD     HL,$1D32     ;
1C39 1688     LD     D,#88        ;
1C3B 010006   LD     BC,$0600     ;
1C3E 5E       LD     E,(HL)       ;
1C3F 23       INC    HL           ;
1C40 3A2D98   LD     A,($982D)    ;
1C43 BB       CP     E            ;
1C44 2804     JR     Z,$1C4A      ;
1C46 1A       LD     A,(DE)       ;
1C47 3D       DEC    A            ;
1C48 D601     SUB    #01          ;
1C4A CB11     RL     C            ;
1C4C 10F0     DJNZ   $1C3E        ;
1C4E DD       ???                 ;
1C4F 2E00     LD     L,#00        ;
1C51 0604     LD     B,#04        ;
1C53 DD       ???                 ;
1C54 61       LD     H,C          ;
1C55 79       LD     A,C          ;
1C56 E607     AND    #07          ;
1C58 FE04     CP     #04          ;
1C5A 2805     JR     Z,$1C61      ;
1C5C FE03     CP     #03          ;
1C5E D4931C   CALL   NC,$1C93     ;
1C61 CB19     RR     C            ;
1C63 10F0     DJNZ   $1C55        ;
1C65 DD       ???                 ;
1C66 2C       INC    L            ;
1C67 DD       ???                 ;
1C68 4C       LD     C,H          ;
1C69 0604     LD     B,#04        ;
1C6B 79       LD     A,C          ;
1C6C E607     AND    #07          ;
1C6E C4931C   CALL   NZ,$1C93     ;
1C71 CB19     RR     C            ;
1C73 10F6     DJNZ   $1C6B        ;
1C75 DD       ???                 ;
1C76 2C       INC    L            ;
1C77 113088   LD     DE,$8830     ;
1C7A 0604     LD     B,#04        ;
1C7C 1A       LD     A,(DE)       ;
1C7D 3D       DEC    A            ;
1C7E 2826     JR     Z,$1CA6      ;
1C80 1C       INC    E            ;
1C81 1C       INC    E            ;
1C82 10F8     DJNZ   $1C7C        ;
1C84 210088   LD     HL,$8800     ;
1C87 0604     LD     B,#04        ;
1C89 7E       LD     A,(HL)       ;
1C8A 3D       DEC    A            ;
1C8B CA2B1D   JP     Z,$1D2B      ;
1C8E 2C       INC    L            ;
1C8F 2C       INC    L            ;
1C90 10F7     DJNZ   $1C89        ;
1C92 C9       RET                 ;
1C93 78       LD     A,B          ;
1C94 CB4F     BIT    1,A          ;
1C96 2802     JR     Z,$1C9A      ;
1C98 EE01     XOR    #01          ;
1C9A E603     AND    #03          ;
1C9C CB27     SLA    A            ;
1C9E C630     ADD    A,#30        ;
1CA0 5F       LD     E,A          ;
1CA1 1A       LD     A,(DE)       ;
1CA2 FE01     CP     #01          ;
1CA4 C0       RET    NZ           ;
1CA5 E1       POP    HL           ;
1CA6 FD211104 LD     IY,$0411     ;
1CAA 3A0B92   LD     A,($920B)    ;
1CAD A7       AND    A            ;
1CAE 2004     JR     NZ,$1CB4     ;
1CB0 FD21F100 LD     IY,$00F1     ;
1CB4 7B       LD     A,E          ;
1CB5 0F       RRCA                ;
1CB6 0F       RRCA                ;
1CB7 7B       LD     A,E          ;
1CB8 17       RLA                 ;
1CB9 0F       RRCA                ;
1CBA 32CA92   LD     ($92CA),A    ;
1CBD 08       EX     AF,A'F'      ;
1CBE FD22CB92 LD     ($92CB),IY   ;
1CC2 04       INC    B            ;
1CC3 7B       LD     A,E          ;
1CC4 E607     AND    #07          ;
1CC6 213098   LD     HL,$9830     ;
1CC9 D7       RST    10H          ;
1CCA DD       ???                 ;
1CCB 7D       LD     A,L          ;
1CCC EB       EX     DE,HL        ;
1CCD 21031D   LD     HL,$1D03     ;
1CD0 CF       RST    08H          ;
1CD1 7E       LD     A,(HL)       ;
1CD2 12       LD     (DE),A       ;
1CD3 23       INC    HL           ;
1CD4 1C       INC    E            ;
1CD5 7E       LD     A,(HL)       ;
1CD6 12       LD     (DE),A       ;
1CD7 DD       ???                 ;
1CD8 7D       LD     A,L          ;
1CD9 FE02     CP     #02          ;
1CDB 280C     JR     Z,$1CE9      ;
1CDD 11CD92   LD     DE,$92CD     ;
1CE0 3D       DEC    A            ;
1CE1 2803     JR     Z,$1CE6      ;
1CE3 CD091D   CALL   $1D09        ;
1CE6 CD091D   CALL   $1D09        ;
1CE9 3ACA92   LD     A,($92CA)    ;
1CEC E607     AND    #07          ;
1CEE 6F       LD     L,A          ;
1CEF 2688     LD     H,#88        ;
1CF1 7E       LD     A,(HL)       ;
1CF2 3D       DEC    A            ;
1CF3 C0       RET    NZ           ;
1CF4 4D       LD     C,L          ;
1CF5 21CA92   LD     HL,$92CA     ;
1CF8 2C       INC    L            ;
1CF9 2C       INC    L            ;
1CFA 2C       INC    L            ;
1CFB 7E       LD     A,(HL)       ;
1CFC 3C       INC    A            ;
1CFD 20F9     JR     NZ,$1CF8     ;
1CFF 08       EX     AF,A'F'      ;
1D00 79       LD     A,C          ;
1D01 1819     JR     $1D1C        ;
1D03 0D       DEC    C            ;
1D04 BA       CP     D            ;
1D05 05       DEC    B            ;
1D06 B7       OR     A            ;
1D07 01B5CB   LD     BC,$CBB5     ;
1D0A 09       ADD    HL,BC        ;
1D0B 3806     JR     C,$1D13      ;
1D0D 05       DEC    B            ;
1D0E CB09     RRC    C            ;
1D10 3801     JR     C,$1D13      ;
1D12 05       DEC    B            ;
1D13 78       LD     A,B          ;
1D14 05       DEC    B            ;
1D15 21321D   LD     HL,$1D32     ;
1D18 D7       RST    10H          ;
1D19 08       EX     AF,A'F'      ;
1D1A 7E       LD     A,(HL)       ;
1D1B EB       EX     DE,HL        ;
1D1C 17       RLA                 ;
1D1D 0F       RRCA                ;
1D1E 77       LD     (HL),A       ;
1D1F 08       EX     AF,A'F'      ;
1D20 2C       INC    L            ;
1D21 FD       ???                 ;
1D22 7D       LD     A,L          ;
1D23 77       LD     (HL),A       ;
1D24 2C       INC    L            ;
1D25 FD       ???                 ;
1D26 7C       LD     A,H          ;
1D27 77       LD     (HL),A       ;
1D28 2C       INC    L            ;
1D29 EB       EX     DE,HL        ;
1D2A C9       RET                 ;

1D2B 114404   LD     DE,$0444     ;
1D2E CD8310   CALL   $1083        ; Process next moving bee
1D31 C9       RET                 ;

1D32 4A       LD     C,D          ;
1D33 52       LD     D,D          ;
1D34 5A       LD     E,D          ;
1D35 58       LD     E,B          ;
1D36 50       LD     D,B          ;
1D37 48       LD     C,B          ;

; PLAY COMMAND 0E (??)
1D38 21B499   LD     HL,$99B4     ;
1D3B 7E       LD     A,(HL)       ;
1D3C E67F     AND    #7F          ;
1D3E D67E     SUB    #7E          ;
1D40 2836     JR     Z,$1D78      ;
1D42 4E       LD     C,(HL)       ;
1D43 34       INC    (HL)         ;
1D44 3A1592   LD     A,($9215)    ;
1D47 CB01     RLC    C            ;
1D49 A9       XOR    C            ;
1D4A 0F       RRCA                ;
1D4B 3E01     LD     A,#01        ;
1D4D 3802     JR     C,$1D51      ;
1D4F ED44     NEG                 ;
1D51 4F       LD     C,A          ;
1D52 211498   LD     HL,$9814     ;
1D55 0606     LD     B,#06        ;
1D57 7E       LD     A,(HL)       ;
1D58 81       ADD    A,C          ;
1D59 77       LD     (HL),A       ;
1D5A 1F       RRA                 ;
1D5B A9       XOR    C            ;
1D5C 2C       INC    L            ;
1D5D 07       RLCA                ;
1D5E 3004     JR     NZ,$1D64     ;
1D60 7E       LD     A,(HL)       ;
1D61 EE01     XOR    #01          ;
1D63 77       LD     (HL),A       ;
1D64 2C       INC    L            ;
1D65 10F0     DJNZ   $1D57        ;
1D67 3AA092   LD     A,($92A0)    ;
1D6A E6FC     AND    #FC          ;
1D6C 3C       INC    A            ;
1D6D F5       PUSH   AF           ;
1D6E CDEE23   CALL   $23EE        ;
1D71 F1       POP    AF           ;
1D72 C602     ADD    A,#02        ;
1D74 CDEE23   CALL   $23EE        ;
1D77 C9       RET                 ;
1D78 320E90   LD     ($900E),A    ;
1D7B C9       RET                 ;

;======================================================================
; PLAY COMMAND 12
;
1D7C 3A1592   LD     A,($9215)    ;
1D7F 47       LD     B,A          ;
1D80 21B999   LD     HL,$99B9     ;
1D83 7E       LD     A,(HL)       ;
1D84 2C       INC    L            ;
1D85 A7       AND    A            ;
1D86 2826     JR     Z,$1DAE      ;
1D88 7E       LD     A,(HL)       ;
1D89 A7       AND    A            ;
1D8A 3EFD     LD     A,#FD        ;
1D8C 2013     JR     NZ,$1DA1     ;
1D8E 2C       INC    L            ;
1D8F 7E       LD     A,(HL)       ;
1D90 2C       INC    L            ;
1D91 BE       CP     (HL)         ;
1D92 2801     JR     Z,$1D95      ;
1D94 34       INC    (HL)         ;
1D95 7E       LD     A,(HL)       ;
1D96 2C       INC    L            ;
1D97 86       ADD    A,(HL)       ;
1D98 4F       LD     C,A          ;
1D99 E63F     AND    #3F          ;
1D9B 77       LD     (HL),A       ;
1D9C 79       LD     A,C          ;
1D9D 07       RLCA                ;
1D9E 07       RLCA                ;
1D9F E603     AND    #03          ;
1DA1 CB40     BIT    0,B          ;
1DA3 2002     JR     NZ,$1DA7     ;
1DA5 ED44     NEG                 ;
1DA7 3D       DEC    A            ;
1DA8 E607     AND    #07          ;
1DAA 32BE99   LD     ($99BE),A    ;
1DAD C9       RET                 ;
1DAE AF       XOR    A            ;
1DAF 77       LD     (HL),A       ;
1DB0 2C       INC    L            ;
1DB1 2C       INC    L            ;
1DB2 77       LD     (HL),A       ;
1DB3 2C       INC    L            ;
1DB4 77       LD     (HL),A       ;
1DB5 3E07     LD     A,#07        ;
1DB7 18F1     JR     $1DAA        ;

; PLAY COMMAND 0B
1DB9 210092   LD     HL,$9200     ;
1DBC 0630     LD     B,#30        ;
1DBE CB7E     BIT    7,(HL)       ;
1DC0 2005     JR     NZ,$1DC7     ;
1DC2 2C       INC    L            ;
1DC3 2C       INC    L            ;
1DC4 10F8     DJNZ   $1DBE        ;
1DC6 C9       RET                 ;
1DC7 CBBE     RES    7,(HL)       ;
1DC9 2688     LD     H,#88        ;
1DCB 3604     LD     (HL),#04     ;
1DCD 2C       INC    L            ;
1DCE 3640     LD     (HL),#40     ;
1DD0 268B     LD     H,#8B        ;
1DD2 360A     LD     (HL),#0A     ;
1DD4 2692     LD     H,#92        ;
1DD6 18EB     JR     $1DC3        ;

;======================================================================
; PLAY COMMAND 17
;
1DD8 3AA292   LD     A,($92A2)    ;
1DDB E601     AND    #01          ;
1DDD C0       RET    NZ           ;
1DDE 21AC92   LD     HL,$92AC     ;
1DE1 0604     LD     B,#04        ;
1DE3 7E       LD     A,(HL)       ;
1DE4 A7       AND    A            ;
1DE5 2801     JR     Z,$1DE8      ;
1DE7 35       DEC    (HL)         ;
1DE8 2C       INC    L            ;
1DE9 10F8     DJNZ   $1DE3        ;
1DEB C9       RET                 ;

; PLAY COMMAND 09 (??)
1DEC 3AA092   LD     A,($92A0)    ;
1DEF E603     AND    #03          ;
1DF1 C0       RET    NZ           ;
1DF2 210F92   LD     HL,$920F     ;
1DF5 7E       LD     A,(HL)       ;
1DF6 5F       LD     E,A          ;
1DF7 16FF     LD     D,#FF        ;
1DF9 CB7F     BIT    7,A          ;
1DFB 2005     JR     NZ,$1E02     ;
1DFD 14       INC    D            ;
1DFE 14       INC    D            ;
1DFF 34       INC    (HL)         ;
1E00 1801     JR     $1E03        ;
1E02 35       DEC    (HL)         ;
1E03 FE1F     CP     #1F          ;
1E05 2002     JR     NZ,$1E09     ;
1E07 CBFE     SET    7,(HL)       ;
1E09 FE81     CP     #81          ;
1E0B 2002     JR     NZ,$1E0F     ;
1E0D CBBE     RES    7,(HL)       ;
1E0F 4E       LD     C,(HL)       ;
1E10 E607     AND    #07          ;
1E12 7A       LD     A,D          ;
1E13 321192   LD     ($9211),A    ;
1E16 7B       LD     A,E          ;
1E17 2010     JR     NZ,$1E29     ;
1E19 216A1E   LD     HL,$1E6A     ;
1E1C 79       LD     A,C          ;
1E1D E618     AND    #18          ;
1E1F CF       RST    08H          ;
1E20 7B       LD     A,E          ;
1E21 112099   LD     DE,$9920     ;
1E24 011000   LD     BC,$0010     ;
1E27 EDB0     LDIR                ;
1E29 211592   LD     HL,$9215     ;
1E2C 07       RLCA                ;
1E2D AE       XOR    (HL)         ;
1E2E 0F       RRCA                ;
1E2F 212099   LD     HL,$9920     ;
1E32 110099   LD     DE,$9900     ;
1E35 3005     JR     NZ,$1E3C     ;
1E37 01FF01   LD     BC,$01FF     ;
1E3A 1803     JR     $1E3F        ;
1E3C 0101FF   LD     BC,$FF01     ;
1E3F DD       ???                 ;
1E40 2E05     LD     L,#05        ;
1E42 CD491E   CALL   $1E49        ;
1E45 41       LD     B,C          ;
1E46 DD       ???                 ;
1E47 2E0B     LD     L,#0B        ;
1E49 CB0E     RRC    (HL)         ;
1E4B 3015     JR     NZ,$1E62     ;
1E4D 1A       LD     A,(DE)       ;
1E4E 80       ADD    A,B          ;
1E4F 12       LD     (DE),A       ;
1E50 1698     LD     D,#98        ;
1E52 1A       LD     A,(DE)       ;
1E53 80       ADD    A,B          ;
1E54 12       LD     (DE),A       ;
1E55 1F       RRA                 ;
1E56 A8       XOR    B            ;
1E57 07       RLCA                ;
1E58 3006     JR     NZ,$1E60     ;
1E5A 1C       INC    E            ;
1E5B 1A       LD     A,(DE)       ;
1E5C EE01     XOR    #01          ;
1E5E 12       LD     (DE),A       ;
1E5F 1D       DEC    E            ;
1E60 1699     LD     D,#99        ;
1E62 1C       INC    E            ;
1E63 1C       INC    E            ;
1E64 2C       INC    L            ;
1E65 DD       ???                 ;
1E66 2D       DEC    L            ;
1E67 20E0     JR     NZ,$1E49     ;
1E69 C9       RET                 ;
1E6A FF       RST    38H          ;
1E6B 77       LD     (HL),A       ;
1E6C 55       LD     D,L          ;
1E6D 14       INC    D            ;
1E6E 1010     DJNZ   $1E80        ;
1E70 14       INC    D            ;
1E71 55       LD     D,L          ;
1E72 77       LD     (HL),A       ;
1E73 FF       RST    38H          ;
1E74 00       NOP                 ;
1E75 1014     DJNZ   $1E8B        ;
1E77 55       LD     D,L          ;
1E78 77       LD     (HL),A       ;
1E79 FF       RST    38H          ;
1E7A FF       RST    38H          ;
1E7B 77       LD     (HL),A       ;
1E7C 55       LD     D,L          ;
1E7D 51       LD     D,C          ;
1E7E 1010     DJNZ   $1E90        ;
1E80 51       LD     D,C          ;
1E81 55       LD     D,L          ;
1E82 77       LD     (HL),A       ;
1E83 FF       RST    38H          ;
1E84 00       NOP                 ;
1E85 1051     DJNZ   $1ED8        ;
1E87 55       LD     D,L          ;
1E88 77       LD     (HL),A       ;
1E89 FF       RST    38H          ;
1E8A FF       RST    38H          ;
1E8B 77       LD     (HL),A       ;
1E8C 57       LD     D,A          ;
1E8D 15       DEC    D            ;
1E8E 1010     DJNZ   $1EA0        ;
1E90 15       DEC    D            ;
1E91 57       LD     D,A          ;
1E92 77       LD     (HL),A       ;
1E93 FF       RST    38H          ;
1E94 00       NOP                 ;
1E95 1015     DJNZ   $1EAC        ;
1E97 57       LD     D,A          ;
1E98 77       LD     (HL),A       ;
1E99 FF       RST    38H          ;
1E9A FF       RST    38H          ;
1E9B F7       RST    30H          ;
1E9C D5       PUSH   DE           ;
1E9D 91       SUB    C            ;
1E9E 1010     DJNZ   $1EB0        ;
1EA0 91       SUB    C            ;
1EA1 D5       PUSH   DE           ;
1EA2 F7       RST    30H          ;
1EA3 FF       RST    38H          ;
1EA4 00       NOP                 ;
1EA5 1091     DJNZ   $1E38        ;
1EA7 D5       PUSH   DE           ;
1EA8 F7       RST    30H          ;
1EA9 FF       RST    38H          ;

;======================================================================
; PLAY COMMAND 0D (Move Bee Fire)
;
1EAA 3AA092   LD     A,($92A0)    ;
1EAD E601     AND    #01          ;
1EAF C602     ADD    A,#02        ;
1EB1 47       LD     B,A          ;
1EB2 3A1592   LD     A,($9215)    ; 0 = shots move up
1EB5 A7       AND    A            ;
1EB6 78       LD     A,B          ;
1EB7 2802     JR     Z,$1EBB      ; Jump if 9215 is zero
1EB9 ED44     NEG                 ; Shots moving down!
1EBB DD       ???                 ; Disassembler error
1EBC 67       LD     H,A          ;
1EBD 2E68     LD     L,#68        ; Offset to fire space
1EBF 11B092   LD     DE,$92B0     ; X and Y velocity
1EC2 DD       ???                 ; Disassembler error!
1EC3 2E08     LD     L,#08        ; Eight shots to do
;
; Loop Here
1EC5 268B     LD     H,#8B        ; Sprite color code
1EC7 7E       LD     A,(HL)       ; Get sprite color
1EC8 FE30     CP     #30          ; Sprite color of a bee shot?
1ECA 2039     JR     NZ,$1F05     ; Not 30 - skip moving it
;
1ECC 2693     LD     H,#93        ; Sprite position
1ECE 7E       LD     A,(HL)       ; Get position
1ECF A7       AND    A            ; Set flags
1ED0 2833     JR     Z,$1F05      ; If it is 0, skip moving it
;
1ED2 EB       EX     DE,HL        ;
1ED3 46       LD     B,(HL)       ; Get X velocity
1ED4 78       LD     A,B          ;
1ED5 E67E     AND    #7E          ; 
1ED7 2C       INC    L            ;
1ED8 86       ADD    A,(HL)       ;
1ED9 4F       LD     C,A          ;
1EDA E61F     AND    #1F          ;
1EDC 77       LD     (HL),A       ;
1EDD 2C       INC    L            ;
1EDE 79       LD     A,C          ;
1EDF 07       RLCA                ;
1EE0 07       RLCA                ;
1EE1 07       RLCA                ;
1EE2 E607     AND    #07          ;
1EE4 CB78     BIT    7,B          ; Left or right?
1EE6 2802     JR     Z,$1EEA      ; Right -- keep it
1EE8 ED44     NEG                 ; Shots move to left
1EEA EB       EX     DE,HL        ;
1EEB 86       ADD    A,(HL)       ; Offset X coordinate
1EEC 77       LD     (HL),A       ; New X coordinate
1EED 2C       INC    L            ; Y coordinate
1EEE 7E       LD     A,(HL)       ; Get Y coordinate
1EEF DD       ???                 ;
1EF0 84       ADD    A,H          ; Offset Y coordinate
1EF1 77       LD     (HL),A       ; New Y coordinate
1EF2 1F       RRA                 ;
1EF3 DD       ???                 ;
1EF4 AC       XOR    H            ;
1EF5 07       RLCA                ;
1EF6 3007     JR     NZ,$1EFF     ;
;
; Here if shot is close to bottom of screen
1EF8 269B     LD     H,#9B        ; Sprite control
1EFA CB0E     RRC    (HL)         ; Rotate Right Circular
1EFC 3F       CCF                 ; 
1EFD CB16     RL     (HL)         ; Rotate Left (through carry)
;
1EFF 2C       INC    L            ; Point ...
1F00 DD       ???                 ; ...
1F01 2D       DEC    L            ; ... to next shot (before)
1F02 20C1     JR     NZ,$1EC5     ; Process next shot
1F04 C9       RET                 ; Done
;
1F05 2C       INC    L            ; 
1F06 1C       INC    E            ;
1F07 1C       INC    E            ;
1F08 18F5     JR     $1EFF        ; Next shot
;======================================================================

;======================================================================
; PLAY COMMAND 15 Initiate Player Fire
;
1F0A 3A1592   LD     A,($9215)    ;
1F0D C6B6     ADD    A,#B6        ;
1F0F 6F       LD     L,A          ;
1F10 2699     LD     H,#99        ;
1F12 CB66     BIT    4,(HL)       ;
1F14 C0       RET    NZ           ;
1F15 216493   LD     HL,$9364     ;
1F18 11A492   LD     DE,$92A4     ;
1F1B AF       XOR    A            ;
1F1C BE       CP     (HL)         ;
1F1D 2805     JR     Z,$1F24      ;
1F1F 2E66     LD     L,#66        ;
1F21 1C       INC    E            ;
1F22 BE       CP     (HL)         ;
1F23 C0       RET    NZ           ;
1F24 D5       PUSH   DE           ;
1F25 EB       EX     DE,HL        ;
1F26 21639B   LD     HL,$9B63     ;
1F29 54       LD     D,H          ;
1F2A 1C       INC    E            ;
1F2B CB56     BIT    2,(HL)       ;
1F2D 2802     JR     Z,$1F31      ;
1F2F D1       POP    DE           ;
1F30 C9       RET                 ;
1F31 EDA8     LDD                 ;
1F33 2693     LD     H,#93        ;
1F35 54       LD     D,H          ;
1F36 EDA0     LDI                 ;
1F38 EDA8     LDD                 ;
1F3A 269B     LD     H,#9B        ;
1F3C 54       LD     D,H          ;
1F3D 46       LD     B,(HL)       ;
1F3E EB       EX     DE,HL        ;
1F3F 3A2798   LD     A,($9827)    ;
1F42 E601     AND    #01          ;
1F44 07       RLCA                ;
1F45 07       RLCA                ;
1F46 07       RLCA                ;
1F47 B0       OR     B            ;
1F48 77       LD     (HL),A       ;
1F49 168B     LD     D,#8B        ;
1F4B 1A       LD     A,(DE)       ;
1F4C 62       ???                 ;
1F4D E607     AND    #07          ;
1F4F 0E30     LD     C,#30        ;
1F51 FE05     CP     #05          ;
1F53 3007     JR     NZ,$1F5C     ;
1F55 0C       INC    C            ;
1F56 FE02     CP     #02          ;
1F58 3002     JR     NZ,$1F5C     ;
1F5A 0C       INC    C            ;
1F5B 0C       INC    C            ;
1F5C 71       LD     (HL),C       ;
1F5D FE04     CP     #04          ;
1F5F 3803     JR     C,$1F64      ;
1F61 2F       CPL                 ;
1F62 C647     ADD    A,#47        ;
1F64 CB27     SLA    A            ;
1F66 4F       LD     C,A          ;
1F67 78       LD     A,B          ;
1F68 0F       RRCA                ;
1F69 0F       RRCA                ;
1F6A 0F       RRCA                ;
1F6B E660     AND    #60          ;
1F6D 47       LD     B,A          ;
1F6E 3A1592   LD     A,($9215)    ;
1F71 A7       AND    A            ;
1F72 78       LD     A,B          ;
1F73 2002     JR     NZ,$1F77     ;
1F75 EE60     XOR    #60          ;
;
; Add player shot to buffers
1F77 B1       OR     C            ;
1F78 D1       POP    DE           ;
1F79 12       LD     (DE),A       ;
1F7A 2688     LD     H,#88        ; Shot slots
1F7C 3606     LD     (HL),#06     ; Add players shot
1F7E 3E01     LD     A,#01        ;
1F80 32AF9A   LD     ($9AAF),A    ;
1F83 2A4698   LD     HL,($9846)   ;
1F86 23       INC    HL           ;
1F87 224698   LD     ($9846),HL   ;
1F8A C9       RET                 ;
;======================================================================

;======================================================================
; PLAY COMMAND 14 (Move player left or right)
;
1F8B 3A2798   LD     A,($9827)    ;
1F8E 5F       LD     E,A          ;
1F8F 3A1592   LD     A,($9215)    ;
1F92 C6B6     ADD    A,#B6        ;
1F94 6F       LD     L,A          ;
1F95 2699     LD     H,#99        ;
1F97 7E       LD     A,(HL)       ;
1F98 E60A     AND    #0A          ;
1F9A FE0A     CP     #0A          ;
1F9C 2837     JR     Z,$1FD5      ;
1F9E 211592   LD     HL,$9215     ;
1FA1 CB46     BIT    0,(HL)       ;
1FA3 2802     JR     Z,$1FA7      ;
1FA5 EE0A     XOR    #0A          ;
1FA7 21A392   LD     HL,$92A3     ;
1FAA 47       LD     B,A          ;
1FAB 0E01     LD     C,#01        ;
1FAD 7E       LD     A,(HL)       ;
1FAE EE01     XOR    #01          ;
1FB0 77       LD     (HL),A       ;
1FB1 2001     JR     NZ,$1FB4     ;
1FB3 0C       INC    C            ;
1FB4 216293   LD     HL,$9362     ;
1FB7 7E       LD     A,(HL)       ;
1FB8 A7       AND    A            ;
1FB9 C8       RET    Z            ;
1FBA CB48     BIT    1,B          ;
1FBC 200F     JR     NZ,$1FCD     ;
1FBE 7E       LD     A,(HL)       ;
1FBF FED1     CP     #D1          ;
1FC1 3803     JR     C,$1FC6      ;
1FC3 CB43     BIT    0,E          ;
1FC5 C0       RET    NZ           ;
1FC6 FEE1     CP     #E1          ;
1FC8 D0       RET    NC           ;
1FC9 81       ADD    A,C          ;
1FCA 77       LD     (HL),A       ;
1FCB 180D     JR     $1FDA        ;
1FCD 7E       LD     A,(HL)       ;
1FCE FE12     CP     #12          ;
1FD0 D8       RET    C            ;
1FD1 91       SUB    C            ;
1FD2 77       LD     (HL),A       ;
1FD3 1805     JR     $1FDA        ;
1FD5 AF       XOR    A            ;
1FD6 32A392   LD     ($92A3),A    ;
1FD9 C9       RET                 ;
1FDA CB43     BIT    0,E          ;
1FDC C8       RET    Z            ;
1FDD C60F     ADD    A,#0F        ;
1FDF 326093   LD     ($9360),A    ;
1FE2 C9       RET                 ;
;======================================================================

; FFs (RST 38H) From here to next

;======================================================================
; PLAY COMMAND 1D Coordinate Free-fighter sequence
;
2000 3A2898   LD     A,($9828)    ;
2003 6F       LD     L,A          ;
2004 2688     LD     H,#88        ;
2006 7E       LD     A,(HL)       ;
2007 A7       AND    A            ;
2008 C2BF20   JP     NZ,$20BF     ; Turn off "freed music" and return
200B 3A8B92   LD     A,($928B)    ;
200E A7       AND    A            ;
200F CAC720   JP     Z,$20C7      ;
2012 3D       DEC    A            ;
2013 CAD120   JP     Z,$20D1      ;
2016 2693     LD     H,#93        ;
2018 7E       LD     A,(HL)       ;
2019 FE80     CP     #80          ;
201B 2809     JR     Z,$2026      ;
201D F22320   JP     P,$2023      ;
2020 34       INC    (HL)         ;
2021 183B     JR     $205E        ;
2023 35       DEC    (HL)         ;
2024 1838     JR     $205E        ;
2026 2C       INC    L            ;
2027 3A1592   LD     A,($9215)    ;
202A A7       AND    A            ;
202B 201F     JR     NZ,$204C     ;
202D 7E       LD     A,(HL)       ;
202E FE29     CP     #29          ;
2030 200F     JR     NZ,$2041     ;
2032 269B     LD     H,#9B        ;
2034 7E       LD     A,(HL)       ;
2035 2693     LD     H,#93        ;
2037 3D       DEC    A            ;
2038 2007     JR     NZ,$2041     ;
203A 3E03     LD     A,#03        ;
203C 328B92   LD     ($928B),A    ;
203F 181D     JR     $205E        ;
2041 34       INC    (HL)         ;
2042 201A     JR     NZ,$205E     ;
2044 269B     LD     H,#9B        ;
2046 7E       LD     A,(HL)       ;
2047 EE01     XOR    #01          ;
2049 77       LD     (HL),A       ;
204A 1812     JR     $205E        ;
204C 7E       LD     A,(HL)       ;
204D FE37     CP     #37          ;
204F 2008     JR     NZ,$2059     ;
2051 269B     LD     H,#9B        ;
2053 7E       LD     A,(HL)       ;
2054 2693     LD     H,#93        ;
2056 A7       AND    A            ;
2057 28E1     JR     Z,$203A      ;
2059 35       DEC    (HL)         ;
205A 7E       LD     A,(HL)       ;
205B 3C       INC    A            ;
205C 28E6     JR     Z,$2044      ;
205E 21628B   LD     HL,$8B62     ;
2061 7E       LD     A,(HL)       ;
2062 D606     SUB    #06          ;
2064 4F       LD     C,A          ;
2065 2693     LD     H,#93        ;
2067 200C     JR     NZ,$2075     ;
2069 7E       LD     A,(HL)       ;
206A FE71     CP     #71          ;
206C 2807     JR     Z,$2075      ;
206E F27320   JP     P,$2073      ;
2071 34       INC    (HL)         ;
2072 C9       RET                 ;
2073 35       DEC    (HL)         ;
2074 C9       RET                 ;
2075 3A8B92   LD     A,($928B)    ;
2078 FE03     CP     #03          ;
207A C0       RET    NZ           ;
207B 3A2898   LD     A,($9828)    ;
207E 6F       LD     L,A          ;
207F 3600     LD     (HL),#00     ;
2081 2C       INC    L            ;
2082 0D       DEC    C            ;
2083 0C       INC    C            ;
2084 2809     JR     Z,$208F      ;
2086 116393   LD     DE,$9363     ;
2089 AF       XOR    A            ;
208A 322B98   LD     ($982B),A    ;
208D 1808     JR     $2097        ;
208F 3E01     LD     A,#01        ;
2091 322798   LD     ($9827),A    ;
2094 116193   LD     DE,$9361     ;
2097 7E       LD     A,(HL)       ;
2098 12       LD     (DE),A       ;
2099 269B     LD     H,#9B        ;
209B 54       LD     D,H          ;
209C 7E       LD     A,(HL)       ;
209D 12       LD     (DE),A       ;
209E 2D       DEC    L            ;
209F 2688     LD     H,#88        ;
20A1 3680     LD     (HL),#80     ;
20A3 268B     LD     H,#8B        ;
20A5 6B       LD     L,E          ;
20A6 2D       DEC    L            ;
20A7 3606     LD     (HL),#06     ;
20A9 2C       INC    L            ;
20AA 3609     LD     (HL),#09     ; This is in a section that hits
20AC 2D       DEC    L            ; ... as soon as second fighter drops
20AD 2693     LD     H,#93        ; ... with first for dual.
20AF 3680     LD     (HL),#80     ;
20B1 3E01     LD     A,#01        ;
20B3 321490   LD     ($9014),A    ;
20B6 321590   LD     ($9015),A    ;
20B9 322590   LD     ($9025),A    ;
20BC 32B999   LD     ($99B9),A    ;
;
20BF AF       XOR    A            ; Flag freed music ...
20C0 321D90   LD     ($901D),A    ; ... turned ...
20C3 32B19A   LD     ($9AB1),A    ; ... off 
20C6 C9       RET                 ; out
;
20C7 3C       INC    A            ; Initiate ...
20C8 328B92   LD     ($928B),A    ; ... moving freed ship ...
20CB 3E02     LD     A,#02        ; ... down to bottom ...
20CD 32AD92   LD     ($92AD),A    ; ... with current
20D0 C9       RET                 ; out
;
20D1 269B     LD     H,#9B        ;
20D3 3AAD92   LD     A,($92AD)    ;
20D6 5F       LD     E,A          ;
20D7 3A8792   LD     A,($9287)    ;
20DA B3       OR     E            ;
20DB 328D92   LD     ($928D),A    ;
20DE CD9621   CALL   $2196        ;
20E1 05       DEC    B            ;
20E2 C0       RET    NZ           ;
20E3 321490   LD     ($9014),A    ;
20E6 321590   LD     ($9015),A    ;
20E9 322590   LD     ($9025),A    ;
20EC 3E02     LD     A,#02        ;
20EE 328B92   LD     ($928B),A    ;
20F1 C9       RET                 ;

;======================================================================
; PLAY COMMAND 1C
;
20F2 21628B   LD     HL,$8B62     ;
20F5 7E       LD     A,(HL)       ;
20F6 FE40     CP     #40          ;
20F8 3808     JR     C,$2102      ;
20FA AF       XOR    A            ;
20FB 321C90   LD     ($901C),A    ;
20FE 32BA99   LD     ($99BA),A    ;
2101 C9       RET                 ;
2102 269B     LD     H,#9B        ;
2104 CD9621   CALL   $2196        ;
2107 CB40     BIT    0,B          ;
2109 2054     JR     NZ,$215F     ;
210B 3A8B92   LD     A,($928B)    ;
210E CB7F     BIT    7,A          ;
2110 2059     JR     NZ,$216B     ;
2112 3A8D92   LD     A,($928D)    ;
2115 A7       AND    A            ;
2116 C8       RET    Z            ;
2117 2693     LD     H,#93        ;
2119 3A2898   LD     A,($9828)    ;
211C 5F       LD     E,A          ;
211D 54       LD     D,H          ;
211E 1A       LD     A,(DE)       ;
211F BE       CP     (HL)         ;
2120 2807     JR     Z,$2129      ;
2122 F22821   JP     P,$2128      ;
2125 35       DEC    (HL)         ;
2126 1801     JR     $2129        ;
2128 34       INC    (HL)         ;
2129 2C       INC    L            ;
212A 3A1592   LD     A,($9215)    ;
212D A7       AND    A            ;
212E 280B     JR     Z,$213B      ;
2130 34       INC    (HL)         ;
2131 7E       LD     A,(HL)       ;
2132 FE7A     CP     #7A          ;
2134 2824     JR     Z,$215A      ;
2136 FE80     CP     #80          ;
2138 2816     JR     Z,$2150      ;
213A C9       RET                 ;
213B 35       DEC    (HL)         ;
213C 7E       LD     A,(HL)       ;
213D 3C       INC    A            ;
213E 2008     JR     NZ,$2148     ;
2140 269B     LD     H,#9B        ;
2142 7E       LD     A,(HL)       ;
2143 EE01     XOR    #01          ;
2145 77       LD     (HL),A       ;
2146 2693     LD     H,#93        ;
2148 7E       LD     A,(HL)       ;
2149 FEE6     CP     #E6          ;
214B 280D     JR     Z,$215A      ;
214D FEE0     CP     #E0          ;
214F C0       RET    NZ           ;
2150 AF       XOR    A            ;
2151 328D92   LD     ($928D),A    ;
2154 3E07     LD     A,#07        ;
2156 32638B   LD     ($8B63),A    ;
2159 C9       RET                 ;
215A AF       XOR    A            ;
215B 321590   LD     ($9015),A    ;
215E C9       RET                 ;
215F 3A1590   LD     A,($9015)    ;
2162 A7       AND    A            ;
2163 2006     JR     NZ,$216B     ;
2165 3C       INC    A            ;
2166 320D92   LD     ($920D),A    ;
2169 1822     JR     $218D        ;
216B 2693     LD     H,#93        ;
216D 2C       INC    L            ;
216E 3A1592   LD     A,($9215)    ;
2171 A7       AND    A            ;
2172 2807     JR     Z,$217B      ;
2174 7E       LD     A,(HL)       ;
2175 FE37     CP     #37          ;
2177 2812     JR     Z,$218B      ;
2179 35       DEC    (HL)         ;
217A C9       RET                 ;
217B 7E       LD     A,(HL)       ;
217C FE29     CP     #29          ;
217E 280B     JR     Z,$218B      ;
2180 34       INC    (HL)         ;
2181 C0       RET    NZ           ;
2182 269B     LD     H,#9B        ;
2184 7E       LD     A,(HL)       ;
2185 EE01     XOR    #01          ;
2187 77       LD     (HL),A       ;
2188 2693     LD     H,#93        ;
218A C9       RET                 ;
218B 05       DEC    B            ;
218C C0       RET    NZ           ;
218D AF       XOR    A            ;
218E 321C90   LD     ($901C),A    ;
2191 3C       INC    A            ;
2192 322590   LD     ($9025),A    ;
2195 C9       RET                 ;
2196 7E       LD     A,(HL)       ;
2197 4F       LD     C,A          ;
2198 CB3F     SRL    A            ;
219A A9       XOR    C            ;
219B 4F       LD     C,A          ;
219C 268B     LD     H,#8B        ;
219E 0600     LD     B,#00        ;
21A0 7E       LD     A,(HL)       ;
21A1 E607     AND    #07          ;
21A3 FE06     CP     #06          ;
21A5 200E     JR     NZ,$21B5     ;
21A7 0D       DEC    C            ;
21A8 0C       INC    C            ;
21A9 200A     JR     NZ,$21B5     ;
21AB 08       EX     AF,A'F'      ;
21AC 3A8D92   LD     A,($928D)    ;
21AF A7       AND    A            ;
21B0 2002     JR     NZ,$21B4     ;
21B2 04       INC    B            ;
21B3 C9       RET                 ;
21B4 08       EX     AF,A'F'      ;
21B5 CB41     BIT    0,C          ;
21B7 2007     JR     NZ,$21C0     ;
21B9 FE06     CP     #06          ;
21BB 2809     JR     Z,$21C6      ;
21BD 34       INC    (HL)         ;
21BE 180E     JR     $21CE        ;
21C0 A7       AND    A            ;
21C1 2803     JR     Z,$21C6      ;
21C3 35       DEC    (HL)         ;
21C4 1808     JR     $21CE        ;
21C6 0D       DEC    C            ;
21C7 F2B521   JP     P,$21B5      ;
21CA 0E03     LD     C,#03        ;
21CC 18E7     JR     $21B5        ;
21CE 79       LD     A,C          ;
21CF CB4F     BIT    1,A          ;
21D1 2802     JR     Z,$21D5      ;
21D3 EE01     XOR    #01          ;
21D5 269B     LD     H,#9B        ;
21D7 77       LD     (HL),A       ;
21D8 C9       RET                 ;

;======================================================================
; PLAY COMMAND 19
;
21D9 212898   LD     HL,$9828     ;
21DC 5E       LD     E,(HL)       ;
21DD 1688     LD     D,#88        ;
21DF 1A       LD     A,(DE)       ;
21E0 FE09     CP     #09          ;
21E2 2044     JR     NZ,$2228     ;
21E4 2C       INC    L            ;
21E5 7E       LD     A,(HL)       ;
21E6 DD       ???                 ;
21E7 6F       LD     L,A          ;
21E8 DD       ???                 ;
21E9 2691     LD     H,#91        ;
21EB DD7E0A   LD     A,(IX+#0A)   ;
21EE A7       AND    A            ;
21EF C0       RET    NZ           ;
21F0 3E0C     LD     A,#0C        ;
21F2 DDCB0546 BIT    0,(IX+#05)   ;
21F6 2802     JR     Z,$21FA      ;
21F8 ED44     NEG                 ;
21FA DD770C   LD     (IX+#0C),A   ;
21FD DD7E05   LD     A,(IX+#05)   ;
2200 0F       RRCA                ;
2201 DD7E04   LD     A,(IX+#04)   ;
2204 1F       RRA                 ;
2205 D678     SUB    #78          ;
2207 FE10     CP     #10          ;
2209 D0       RET    NC           ;
220A 3AC699   LD     A,($99C6)    ;
220D 322A98   LD     ($982A),A    ;
2210 AF       XOR    A            ;
2211 DD770C   LD     (IX+#0C),A   ;
2214 321990   LD     ($9019),A    ;
2217 328B92   LD     ($928B),A    ;
221A 320D92   LD     ($920D),A    ;
221D 3C       INC    A            ;
221E 321890   LD     ($9018),A    ;
2221 328C92   LD     ($928C),A    ;
2224 328D92   LD     ($928D),A    ;
2227 C9       RET                 ;
2228 AF       XOR    A            ;
2229 321990   LD     ($9019),A    ;
222C 322B98   LD     ($982B),A    ;
222F C9       RET                 ;

;======================================================================
; PLAY COMMAND 18
;
2230 3AA092   LD     A,($92A0)    ;
2233 4F       LD     C,A          ;
2234 E603     AND    #03          ;
2236 202D     JR     NZ,$2265     ;
2238 3A8A92   LD     A,($928A)    ;
223B ED44     NEG                 ;
223D D618     SUB    #18          ;
223F 2621     LD     H,#21        ;
2241 07       RLCA                ;
2242 CB14     RL     H            ;
2244 07       RLCA                ;
2245 CB14     RL     H            ;
2247 E6E0     AND    #E0          ;
2249 C615     ADD    A,#15        ;
224B 6F       LD     L,A          ;
224C 79       LD     A,C          ;
224D 0F       RRCA                ;
224E 0F       RRCA                ;
224F E603     AND    #03          ;
2251 2001     JR     NZ,$2254     ;
2253 3C       INC    A            ;
2254 C617     ADD    A,#17        ;
2256 111600   LD     DE,$0016     ;
2259 0E06     LD     C,#06        ;
225B 060A     LD     B,#0A        ;
225D 77       LD     (HL),A       ;
225E 2C       INC    L            ;
225F 10FC     DJNZ   $225D        ;
2261 19       ADD    HL,DE        ;
2262 0D       DEC    C            ;
2263 20F6     JR     NZ,$225B     ;
2265 218B92   LD     HL,$928B     ;
2268 CB7E     BIT    7,(HL)       ;
226A 200C     JR     NZ,$2278     ;
226C 3A2898   LD     A,($9828)    ;
226F 5F       LD     E,A          ;
2270 1688     LD     D,#88        ;
2272 1A       LD     A,(DE)       ;
2273 FE09     CP     #09          ;
2275 C23523   JP     NZ,$2335     ;
2278 218C92   LD     HL,$928C     ;
227B 35       DEC    (HL)         ;
227C C24B23   JP     NZ,$234B     ;
227F 3A2A98   LD     A,($982A)    ;
2282 77       LD     (HL),A       ;
2283 218B92   LD     HL,$928B     ;
2286 CB7E     BIT    7,(HL)       ;
2288 202F     JR     NZ,$22B9     ;
228A 32A59A   LD     ($9AA5),A    ;
228D 3A2998   LD     A,($9829)    ;
2290 C60D     ADD    A,#0D        ;
2292 5F       LD     E,A          ;
2293 1691     LD     D,#91        ;
2295 3EFF     LD     A,#FF        ;
2297 12       LD     (DE),A       ;
2298 34       INC    (HL)         ;
2299 7E       LD     A,(HL)       ;
229A E60F     AND    #0F          ;
229C FE0B     CP     #0B          ;
229E 2840     JR     Z,$22E0      ;
22A0 CB76     BIT    6,(HL)       ;
22A2 202B     JR     NZ,$22CF     ;
22A4 F5       PUSH   AF           ;
22A5 4F       LD     C,A          ;
22A6 07       RLCA                ;
22A7 81       ADD    A,C          ;
22A8 21A923   LD     HL,$23A9     ;
22AB CF       RST    08H          ;
22AC F1       POP    AF           ;
22AD CD9823   CALL   $2398        ;
22B0 0606     LD     B,#06        ;
22B2 7E       LD     A,(HL)       ;
22B3 12       LD     (DE),A       ;
22B4 23       INC    HL           ;
22B5 E7       RST    20H          ;
22B6 10FA     DJNZ   $22B2        ;
22B8 C9       RET                 ;

22B9 34       INC    (HL)         ;
22BA 7E       LD     A,(HL)       ;
22BB E60F     AND    #0F          ;
22BD FE0B     CP     #0B          ;
22BF 2012     JR     NZ,$22D3     ;
22C1 AF       XOR    A            ;
22C2 321890   LD     ($9018),A    ;
22C5 32A59A   LD     ($9AA5),A    ;
22C8 32A69A   LD     ($9AA6),A    ;
22CB 322B98   LD     ($982B),A    ;
22CE C9       RET                 ;

22CF ED44     NEG                 ;
22D1 C60B     ADD    A,#0B        ;
22D3 CD9823   CALL   $2398        ;
22D6 0606     LD     B,#06        ;
22D8 0E24     LD     C,#24        ;
22DA 79       LD     A,C          ;
22DB 12       LD     (DE),A       ;
22DC E7       RST    20H          ;
22DD 10FB     DJNZ   $22DA        ;
22DF C9       RET                 ;

22E0 CB76     BIT    6,(HL)       ;
22E2 2846     JR     Z,$232A      ;
22E4 3A0D92   LD     A,($920D)    ;
22E7 A7       AND    A            ;
22E8 2807     JR     Z,$22F1      ;
22EA CB6E     BIT    5,(HL)       ;
22EC 2003     JR     NZ,$22F1     ;
22EE 3668     LD     (HL),#68     ;
22F0 C9       RET                 ;

22F1 AF       XOR    A            ;
22F2 321890   LD     ($9018),A    ;
22F5 32A59A   LD     ($9AA5),A    ;
22F8 32A69A   LD     ($9AA6),A    ;
22FB 3A0D92   LD     A,($920D)    ;
22FE A7       AND    A            ;
22FF 3A2998   LD     A,($9829)    ;
2302 200F     JR     NZ,$2313     ;
2304 C60D     ADD    A,#0D        ;
2306 5F       LD     E,A          ;
2307 1691     LD     D,#91        ;
2309 AF       XOR    A            ;
230A 322B98   LD     ($982B),A    ;
230D 3C       INC    A            ;
230E 322898   LD     ($9828),A    ;
2311 12       LD     (DE),A       ;
2312 C9       RET                 ;
2313 C608     ADD    A,#08        ;
2315 6F       LD     L,A          ;
2316 2691     LD     H,#91        ;
2318 116B04   LD     DE,$046B     ;
231B 73       LD     (HL),E       ;
231C 2C       INC    L            ;
231D 72       LD     (HL),D       ;
231E AF       XOR    A            ;
231F 32BA99   LD     ($99BA),A    ;
2322 3C       INC    A            ;
2323 321190   LD     ($9011),A    ;
2326 328E92   LD     ($928E),A    ;
2329 C9       RET                 ;

232A 3E40     LD     A,#40        ;
232C 328C92   LD     ($928C),A    ;
232F 3E40     LD     A,#40        ;
2331 328B92   LD     ($928B),A    ;
2334 C9       RET                 ;

2335 3E03     LD     A,#03        ;
2337 322A98   LD     ($982A),A    ;
233A 3680     LD     (HL),#80     ;
233C AF       XOR    A            ;
233D 328D92   LD     ($928D),A    ;
2340 32BA99   LD     ($99BA),A    ;
2343 3C       INC    A            ;
2344 328C92   LD     ($928C),A    ;
2347 321490   LD     ($9014),A    ;
234A C9       RET                 ;

234B 3A8B92   LD     A,($928B)    ;
234E FE40     CP     #40          ;
2350 C0       RET    NZ           ;
2351 3A1592   LD     A,($9215)    ;
2354 4F       LD     C,A          ;
2355 3A6293   LD     A,($9362)    ;
2358 CB41     BIT    0,C          ;
235A 2804     JR     Z,$2360      ;
235C C60E     ADD    A,#0E        ;
235E ED44     NEG                 ;
2360 47       LD     B,A          ;
2361 3A8A92   LD     A,($928A)    ;
2364 90       SUB    B            ;
2365 C61B     ADD    A,#1B        ;
2367 FE36     CP     #36          ;
2369 D0       RET    NC           ;
236A 3A0192   LD     A,($9201)    ;
236D 3D       DEC    A            ;
236E 280B     JR     Z,$237B      ;
2370 3A1490   LD     A,($9014)    ;
2373 4F       LD     C,A          ;
2374 3A1392   LD     A,($9213)    ;
2377 EE01     XOR    #01          ;
2379 A1       AND    C            ;
237A C8       RET    Z            ;
237B AF       XOR    A            ;
237C 321490   LD     ($9014),A    ;
237F 32A59A   LD     ($9AA5),A    ;
2382 322590   LD     ($9025),A    ;
2385 321392   LD     ($9213),A    ;
2388 3C       INC    A            ;
2389 321C90   LD     ($901C),A    ;
238C 32A69A   LD     ($9AA6),A    ;
238F 32BA99   LD     ($99BA),A    ;
2392 3E0A     LD     A,#0A        ;
2394 322A98   LD     ($982A),A    ;
2397 C9       RET                 ;
2398 4F       LD     C,A          ;
2399 3A8A92   LD     A,($928A)    ;
239C ED44     NEG                 ;
239E C610     ADD    A,#10        ;
23A0 1620     LD     D,#20        ;
23A2 07       RLCA                ;
23A3 CB12     RL     D            ;
23A5 07       RLCA                ;
23A6 CB12     RL     D            ;
23A8 E6E0     AND    #E0          ;
23AA C614     ADD    A,#14        ;
23AC 81       ADD    A,C          ;
23AD 5F       LD     E,A          ;
23AE C9       RET                 ;
23AF 24       INC    H            ;
23B0 4E       LD     C,(HL)       ;
23B1 4F       LD     C,A          ;
23B2 50       LD     D,B          ;
23B3 51       LD     D,C          ;
23B4 24       INC    H            ;
23B5 24       INC    H            ;
23B6 52       LD     D,D          ;
23B7 53       LD     D,E          ;
23B8 54       LD     D,H          ;
23B9 55       LD     D,L          ;
23BA 24       INC    H            ;
23BB 24       INC    H            ;
23BC 56       LD     D,(HL)       ;
23BD 57       LD     D,A          ;
23BE 58       LD     E,B          ;
23BF 59       LD     E,C          ;
23C0 24       INC    H            ;
23C1 24       INC    H            ;
23C2 5A       LD     E,D          ;
23C3 5B       LD     E,E          ;
23C4 5C       LD     E,H          ;
23C5 5D       LD     E,L          ;
23C6 24       INC    H            ;
23C7 24       INC    H            ;
23C8 5E       LD     E,(HL)       ;
23C9 5F       LD     E,A          ;
23CA 60       LD     H,B          ;
23CB 61       LD     H,C          ;
23CC 24       INC    H            ;
23CD 62       ???                 ;
23CE 63       LD     H,E          ;
23CF 64       LD     H,H          ;
23D0 65       LD     H,L          ;
23D1 66       LD     H,(HL)       ;
23D2 67       LD     H,A          ;
23D3 68       LD     L,B          ;
23D4 69       LD     L,C          ;
23D5 6A       LD     L,D          ;
23D6 6B       LD     L,E          ;
23D7 6C       LD     L,H          ;
23D8 6D       LD     L,L          ;
23D9 6E       LD     L,(HL)       ;
23DA 6F       LD     L,A          ;
23DB 70       ???                 ;
23DC 71       LD     (HL),C       ;
23DD 72       LD     (HL),D       ;
23DE 73       LD     (HL),E       ;
23DF 74       LD     (HL),H       ;
23E0 75       LD     (HL),L       ;
23E1 76       HALT                ;
23E2 77       LD     (HL),A       ;
23E3 78       LD     A,B          ;
23E4 79       LD     A,C          ;
23E5 7A       LD     A,D          ;
23E6 7B       LD     A,E          ;
23E7 7C       LD     A,H          ;
23E8 7D       LD     A,L          ;
23E9 7E       LD     A,(HL)       ;
23EA 7F       LD     A,A          ;

;======================================================================
; PLAY COMMAND 0C (Something to do with erasing dead things)
;
23EB 3AA092   LD     A,($92A0)    ;
23EE CB47     BIT    0,A          ;
23F0 CAA425   JP     Z,$25A4      ;
23F3 E602     AND    #02          ;
23F5 5F       LD     E,A          ;
23F6 3AA692   LD     A,($92A6)    ;
23F9 DD       ???                 ;
23FA 6F       LD     L,A          ;
23FB 0620     LD     B,#20        ; Count is 64
;
23FD 1688     LD     D,#88        ; Slots
23FF 1A       LD     A,(DE)       ; Get byte
2400 CB27     SLA    A            ; *2 bytes (and check upper bit)
2402 3820     JR     C,$2424      ; Skip command (an empty slot would skip)
2404 210D24   LD     HL,$240D     ; Jump table
2407 D7       RST    10H          ; Add A to HL
2408 7E       LD     A,(HL)       ; Get LS
2409 23       INC    HL           ; Next
240A 66       LD     H,(HL)       ; Get MSB
240B 6F       LD     L,A          ; To HL
240C E9       JP     (HL)         ; Jump to routine
;
; JUMP TABLE
240D 2424; 01:Do next
240F 9624; 02:??? Bees pulsing in formatin ???
2411 6D24; 03:??? Bees straightening up into formatin ???
2413 5B25; 04:?? Couldn't tell
2415 C024; 05:?? Initiate explosion removal of bee
2417 4325; 06:Remove score from screen
2419 5B25; 07:<Contains the removing shot slots>
241B 9E25; 08:?? Couldn't tell
241D 4A24; 09:?? Couldn't tell
241F 3024; 0A:?? Couldn't tell
;
;============
2421 1D       DEC    E            ; 
2422 DD       ???                 ; 
2423 2C       INC    L            ; 
;
;============
; Jump01:Do next
;
2424 3E04     LD     A,#04        ;
2426 83       ADD    A,E          ;
2427 5F       LD     E,A          ;
2428 10D3     DJNZ   $23FD        ;
242A DD       ???                 ;
242B 7D       LD     A,L          ;
242C 32A692   LD     ($92A6),A    ;
242F C9       RET                 ;
;
;============
; Jump0A:
2430 6B       LD     L,E          ;
2431 2601     LD     H,#01        ;
2433 4E       LD     C,(HL)       ;
2434 2C       INC    L            ;
2435 6E       LD     L,(HL)       ;
2436 2699     LD     H,#99        ;
2438 7E       LD     A,(HL)       ;
2439 08       EX     AF,A'F'      ;
243A 69       LD     L,C          ;
243B 4E       LD     C,(HL)       ;
243C 1C       INC    E            ;
243D 1A       LD     A,(DE)       ;
243E C611     ADD    A,#11        ;
2440 6F       LD     L,A          ;
2441 2691     LD     H,#91        ;
2443 08       EX     AF,A'F'      ;
2444 77       LD     (HL),A       ;
2445 2C       INC    L            ;
2446 71       LD     (HL),C       ;
2447 C32124   JP     $2421        ;
;
;============
; Jump09:
244A 268B     LD     H,#8B        ;
244C 6B       LD     L,E          ;
244D 1C       INC    E            ;
244E 1A       LD     A,(DE)       ;
244F 3D       DEC    A            ;
2450 280D     JR     Z,$245F      ;
2452 12       LD     (DE),A       ;
2453 1D       DEC    E            ;
2454 E603     AND    #03          ;
2456 20CC     JR     NZ,$2424     ;
2458 7E       LD     A,(HL)       ;
2459 C604     ADD    A,#04        ;
245B 77       LD     (HL),A       ;
245C C32424   JP     $2424        ;
245F 2693     LD     H,#93        ;
2461 AF       XOR    A            ;
2462 77       LD     (HL),A       ;
2463 269B     LD     H,#9B        ;
2465 77       LD     (HL),A       ;
2466 1D       DEC    E            ;
2467 3E80     LD     A,#80        ;
2469 12       LD     (DE),A       ;
246A C32424   JP     $2424        ;
;
;============
; Jump03:
246D 269B     LD     H,#9B        ;
246F 6B       LD     L,E          ;
2470 7E       LD     A,(HL)       ;
2471 E601     AND    #01          ;
2473 268B     LD     H,#8B        ;
2475 200A     JR     NZ,$2481     ;
2477 7E       LD     A,(HL)       ;
2478 E607     AND    #07          ;
247A FE06     CP     #06          ;
247C 2813     JR     Z,$2491      ;
247E 34       INC    (HL)         ;
247F 1828     JR     $24A9        ;
2481 7E       LD     A,(HL)       ;
2482 E607     AND    #07          ;
2484 2008     JR     NZ,$248E     ;
2486 269B     LD     H,#9B        ;
2488 CB86     RES    0,(HL)       ;
248A 268B     LD     H,#8B        ;
248C 181B     JR     $24A9        ;
248E 35       DEC    (HL)         ;
248F 1818     JR     $24A9        ;
2491 3E01     LD     A,#01        ;
2493 12       LD     (DE),A       ;
2494 1813     JR     $24A9        ;
;
;============
; Jump02:
2496 268B     LD     H,#8B        ;
2498 6B       LD     L,E          ;
2499 3AA292   LD     A,($92A2)    ;
249C CB0E     RRC    (HL)         ;
249E 0F       RRCA                ;
249F 0F       RRCA                ;
24A0 CB16     RL     (HL)         ;
24A2 3A0B92   LD     A,($920B)    ;
24A5 A7       AND    A            ;
24A6 CA2224   JP     Z,$2422      ;
24A9 2601     LD     H,#01        ;
24AB 4E       LD     C,(HL)       ;
24AC 2C       INC    L            ;
24AD 6E       LD     L,(HL)       ;
24AE 2698     LD     H,#98        ;
24B0 7E       LD     A,(HL)       ;
24B1 1693     LD     D,#93        ;
24B3 12       LD     (DE),A       ;
24B4 1C       INC    E            ;
24B5 69       LD     L,C          ;
24B6 7E       LD     A,(HL)       ;
24B7 12       LD     (DE),A       ;
24B8 169B     LD     D,#9B        ;
24BA 2C       INC    L            ;
24BB 7E       LD     A,(HL)       ;
24BC 12       LD     (DE),A       ;
24BD C32124   JP     $2421        ;
;
;============
; Jump05:
24C0 6B       LD     L,E          ;
24C1 1C       INC    E            ;
24C2 1A       LD     A,(DE)       ;
24C3 FE45     CP     #45          ;
24C5 282D     JR     Z,$24F4      ;
24C7 3C       INC    A            ;
24C8 12       LD     (DE),A       ;
24C9 1D       DEC    E            ;
24CA FE45     CP     #45          ;
24CC 2002     JR     NZ,$24D0     ;
24CE C603     ADD    A,#03        ;
24D0 FE44     CP     #44          ;
24D2 201A     JR     NZ,$24EE     ;
24D4 2693     LD     H,#93        ;
24D6 08       EX     AF,A'F'      ;
24D7 7E       LD     A,(HL)       ;
24D8 D608     SUB    #08          ;
24DA 77       LD     (HL),A       ;
24DB 2C       INC    L            ;
24DC 7E       LD     A,(HL)       ;
24DD D608     SUB    #08          ;
24DF 77       LD     (HL),A       ;
24E0 3006     JR     NZ,$24E8     ;
24E2 269B     LD     H,#9B        ;
24E4 7E       LD     A,(HL)       ;
24E5 EE01     XOR    #01          ;
24E7 77       LD     (HL),A       ;
24E8 2D       DEC    L            ;
24E9 269B     LD     H,#9B        ;
24EB 360C     LD     (HL),#0C     ;
24ED 08       EX     AF,A'F'      ;
24EE 268B     LD     H,#8B        ;
24F0 77       LD     (HL),A       ;
24F1 C32424   JP     $2424        ;
24F4 1D       DEC    E            ;
24F5 2692     LD     H,#92        ;
24F7 7E       LD     A,(HL)       ;
24F8 FE01     CP     #01          ;
24FA 200F     JR     NZ,$250B     ;
24FC 2693     LD     H,#93        ;
24FE 3600     LD     (HL),#00     ;
2500 269B     LD     H,#9B        ;
2502 3600     LD     (HL),#00     ;
2504 2688     LD     H,#88        ;
2506 3680     LD     (HL),#80     ; After explosion, free ship from active duty
2508 C32424   JP     $2424        ;
250B 268B     LD     H,#8B        ;
250D 77       LD     (HL),A       ;
250E FE37     CP     #37          ;
2510 380A     JR     C,$251C      ;
2512 0E0D     LD     C,#0D        ;
2514 2C       INC    L            ;
2515 FE3A     CP     #3A          ;
2517 3801     JR     C,$251A      ;
2519 0C       INC    C            ;
251A 71       LD     (HL),C       ;
251B 2D       DEC    L            ;
251C 2693     LD     H,#93        ;
251E 0E08     LD     C,#08        ;
2520 FE3B     CP     #3B          ;
2522 3006     JR     NZ,$252A     ;
2524 0E00     LD     C,#00        ;
2526 7E       LD     A,(HL)       ;
2527 C608     ADD    A,#08        ;
2529 77       LD     (HL),A       ;
252A 2C       INC    L            ;
252B 7E       LD     A,(HL)       ;
252C C608     ADD    A,#08        ;
252E 77       LD     (HL),A       ;
252F 269B     LD     H,#9B        ;
2531 3004     JR     NZ,$2537     ;
2533 7E       LD     A,(HL)       ;
2534 EE01     XOR    #01          ;
2536 77       LD     (HL),A       ;
2537 2D       DEC    L            ;
2538 71       LD     (HL),C       ;
2539 2688     LD     H,#88        ;
253B 3605     LD     (HL),#05     ;
253D 2C       INC    L            ;
253E 3613     LD     (HL),#13     ;
2540 C32424   JP     $2424        ;
;
;============
; Jump06:
; Time down and remove score indicator from screen.
2543 6B       LD     L,E          ;
2544 2C       INC    L            ; Second byte
2545 62       ???                 ;
2546 35       DEC    (HL)         ; Decrement time
2547 C22424   JP     NZ,$2424     ; Not time yet
254A 2D       DEC    L            ; Restore pointer
254B 3680     LD     (HL),#80     ; This section ...
254D 2693     LD     H,#93        ; ... removes score ...
254F 3600     LD     (HL),#00     ; ... indicator from ...
2551 269B     LD     H,#9B        ; ... screen.
2553 3600     LD     (HL),#00     ; '
2555 3E80     LD     A,#80        ; '
2557 12       LD     (DE),A       ; '
2558 C32424   JP     $2424        ; Do next
;
;============
; Jump04,07:
; Remove item if Y coordinate is too close to bottom or top of screen.
255B 2693     LD     H,#93        ; Coordinates
255D 6B       LD     L,E          ;
255E CBFD     SET    7,L          ; ?
2560 7E       LD     A,(HL)       ; {13} [00] Get X coordinate
2561 FEF4     CP     #F4          ; => F4 ?
2563 301A     JR     NC,$257F     ; Yes ... Remove from duty
2565 2C       INC    L            ; Point to Y 
2566 4E       LD     C,(HL)       ; {4A} [74] Get Y coordinate
2567 269B     LD     H,#9B        ; This gets set as a special in the movement code
2569 7E       LD     A,(HL)       ; {01} [00]
256A 2D       DEC    L            ; Restore pointer
256B 0F       RRCA                ; {C=1} [C=0]
256C 79       LD     A,C          ; {4A} [74] Y coordinate
256D 1F       RRA                 ; {A5}
256E FE0B     CP     #0B          ; If Y coordinate is too close to top of screen ...
2570 380D     JR     C,$257F      ; ... remove it (Y< 0B).
2572 FEA5     CP     #A5          ; If Y coordinate is too close to bottom of screen ...
2574 3009     JR     NC,$257F     ; ... remove it (Y>= A5).
2576 1A       LD     A,(DE)       ; Get type
2577 FE06     CP     #06          ; Bee shot?
2579 C22224   JP     NZ,$2422     ; Not a bee shot ... do something and next
257C C32424   JP     $2424        ; Do next
; Remove item from active duty
257F CBBD     RES    7,L          ;
2581 1A       LD     A,(DE)       ; Type
2582 FE03     CP     #03          ;
2584 280A     JR     Z,$2590      ;
2586 3E80     LD     A,#80        ; Flag free slot
2588 12       LD     (DE),A       ; Here it is -- shots are erased here.
2589 2693     LD     H,#93        ; Free ...
258B 3600     LD     (HL),#00     ; ... sprite
258D C32424   JP     $2424        ; Do next
;
; Additional processing and remove from duty
2590 1C       INC    E            ; 2nd byte 
2591 1A       LD     A,(DE)       ; Get ???
2592 1D       DEC    E            ; Restore pointer
2593 C613     ADD    A,#13        ;
2595 6F       LD     L,A          ;
2596 2691     LD     H,#91        ;
2598 3600     LD     (HL),#00     ;
259A 6B       LD     L,E          ;
259B C38625   JP     $2586        ; Continue removing from active duty
;
;============
; Jump08:
259E 3E03     LD     A,#03        ;
25A0 12       LD     (DE),A       ;
25A1 C32224   JP     $2422        ;
25A4 CB4F     BIT    1,A          ;
25A6 C8       RET    Z            ;
25A7 21A692   LD     HL,$92A6     ;
25AA 7E       LD     A,(HL)       ;
25AB 3600     LD     (HL),#00     ;
25AD 2C       INC    L            ;
25AE 77       LD     (HL),A       ;
25AF C9       RET                 ;

;======================================================================
;
25B0 217C28   LD     HL,$287C     ;
25B3 22E092   LD     ($92E0),HL   ;
25B6 3A2198   LD     A,($9821)    ;
25B9 4F       LD     C,A          ;
25BA FE17     CP     #17          ;
25BC 3804     JR     C,$25C2      ;
25BE D604     SUB    #04          ;
25C0 18F8     JR     $25BA        ;
25C2 47       LD     B,A          ;
25C3 3C       INC    A            ;
25C4 E603     AND    #03          ;
25C6 2819     JR     Z,$25E1      ;
25C8 3A8499   LD     A,($9984)    ;
25CB 2E11     LD     L,#11        ;
25CD CD4E10   CALL   $104E        ;
25D0 7D       LD     A,L          ;
25D1 21B626   LD     HL,$26B6     ;
25D4 D7       RST    10H          ;
25D5 110227   LD     DE,$2702     ;
25D8 78       LD     A,B          ;
25D9 CB38     SRL    B            ;
25DB CB38     SRL    B            ;
25DD 90       SUB    B            ;
25DE 3D       DEC    A            ;
25DF 180D     JR     $25EE        ;
25E1 21FA26   LD     HL,$26FA     ;
25E4 79       LD     A,C          ;
25E5 CB3F     SRL    A            ;
25E7 CB3F     SRL    A            ;
25E9 E607     AND    #07          ;
25EB 11EC27   LD     DE,$27EC     ;
25EE D7       RST    10H          ;
25EF 7E       LD     A,(HL)       ;
25F0 EB       EX     DE,HL        ;
25F1 D7       RST    10H          ;
25F2 7E       LD     A,(HL)       ;
25F3 23       INC    HL           ;
25F4 32E292   LD     ($92E2),A    ;
25F7 7E       LD     A,(HL)       ;
25F8 23       INC    HL           ;
25F9 32E392   LD     ($92E3),A    ;
25FC 112089   LD     DE,$8920     ;
25FF 3E7E     LD     A,#7E        ;
2601 12       LD     (DE),A       ;
2602 1C       INC    E            ;
2603 7E       LD     A,(HL)       ;
2604 23       INC    HL           ;
2605 FEFF     CP     #FF          ;
2607 CA8F26   JP     Z,$268F      ;
260A 4F       LD     C,A          ;
260B D5       PUSH   DE           ;
260C E5       PUSH   HL           ;
260D 210091   LD     HL,$9100     ; Bee space
2610 3EFF     LD     A,#FF        ; 
2612 0610     LD     B,#10        ;
2614 DF       RST    18H          ; Fill first 16 bytes with FF?
2615 79       LD     A,C          ;
2616 E60F     AND    #0F          ;
2618 282A     JR     Z,$2644      ;
261A 47       LD     B,A          ;
261B CB3F     SRL    A            ;
261D C604     ADD    A,#04        ;
261F 5F       LD     E,A          ;
2620 CD0010   CALL   $1000        ;
2623 6F       LD     L,A          ;
2624 2600     LD     H,#00        ;
2626 7B       LD     A,E          ;
2627 CD6110   CALL   $1061        ;
262A CB40     BIT    0,B          ;
262C 2802     JR     Z,$2630      ;
262E CBDF     SET    3,A          ;
2630 2691     LD     H,#91        ;
2632 6F       LD     L,A          ;
2633 7E       LD     A,(HL)       ;
2634 3C       INC    A            ;
2635 20E9     JR     NZ,$2620     ;
2637 78       LD     A,B          ;
2638 07       RLCA                ;
2639 CB01     RLC    C            ;
263B 3002     JR     NZ,$263F     ;
263D F640     OR     #40          ;
263F F638     OR     #38          ;
2641 77       LD     (HL),A       ;
2642 10DC     DJNZ   $2620        ;
;
2644 210091   LD     HL,$9100     ; 
2647 ED5BE092 LD     DE,($92E0)   ;
264B 0608     LD     B,#08        ; 
264D 7E       LD     A,(HL)       ; 
264E FEFF     CP     #FF          ; 
2650 2803     JR     Z,$2655      ; 
2652 23       INC    HL           ;
2653 18F8     JR     $264D        ; Find first FF starting at 9100
2655 1A       LD     A,(DE)       ;
2656 77       LD     (HL),A       ;
2657 13       INC    DE           ;
2658 23       INC    HL           ;
2659 78       LD     A,B          ;
265A FE05     CP     #05          ;
265C 2002     JR     NZ,$2660     ;
265E 2E08     LD     L,#08        ;
2660 10EB     DJNZ   $264D        ;
2662 ED53E092 LD     ($92E0),DE   ;
2666 E1       POP    HL           ;
2667 D1       POP    DE           ;
2668 46       LD     B,(HL)       ;
2669 23       INC    HL           ;
266A 4E       LD     C,(HL)       ;
266B 23       INC    HL           ;
266C E5       PUSH   HL           ;
266D 210091   LD     HL,$9100     ; 
2670 78       LD     A,B          ;
2671 12       LD     (DE),A       ;
2672 7E       LD     A,(HL)       ; 
2673 FEFF     CP     #FF          ; 
2675 2810     JR     Z,$2687      ;
2677 1C       INC    E            ;
2678 12       LD     (DE),A       ;
2679 1C       INC    E            ;
267A 79       LD     A,C          ;
267B 12       LD     (DE),A       ;
267C 1C       INC    E            ;
267D CBDD     SET    3,L          ;
267F 7E       LD     A,(HL)       ;
2680 12       LD     (DE),A       ;
2681 1C       INC    E            ;
2682 CB9D     RES    3,L          ;
2684 23       INC    HL           ;
2685 18E9     JR     $2670        ;
2687 3E7E     LD     A,#7E        ;
2689 12       LD     (DE),A       ;
268A 1C       INC    E            ;
268B E1       POP    HL           ;
268C C30326   JP     $2603        ;
268F 1D       DEC    E            ; 
2690 3A2B98   LD     A,($982B)    ; 
2693 47       LD     B,A          ; 
2694 3A2798   LD     A,($9827)    ; 
2697 3D       DEC    A            ; 
2698 A0       AND    B            ; 
2699 2817     JR     Z,$26B2      ; 
269B 3A2598   LD     A,($9825)    ; 
269E A7       AND    A            ; 
269F 2811     JR     Z,$26B2      ; 
26A1 62       ???                 ; 
26A2 7B       LD     A,E          ; 
26A3 D604     SUB    #04          ;
26A5 6F       LD     L,A          ;
26A6 7E       LD     A,(HL)       ;
26A7 12       LD     (DE),A       ;
26A8 1C       INC    E            ;
26A9 3E04     LD     A,#04        ;
26AB 12       LD     (DE),A       ;
26AC 1C       INC    E            ;
26AD 3E87     LD     A,#87        ;
26AF 32048B   LD     ($8B04),A    ;
26B2 3E7F     LD     A,#7F        ;
26B4 12       LD     (DE),A       ;
26B5 C9       RET                 ;

26B6 00       NOP                 ; #
26B7 12       LD     (DE),A       ; #
26B8 24       INC    H            ; #
26B9 3600     LD     (HL),#00     ; #
26BB 48       LD     C,B          ; #
26BC 6C       LD     L,H          ; #
26BD 5A       LD     E,D          ; #
26BE 48       LD     C,B          ; #
26BF 6C       LD     L,H          ; #
26C0 00       NOP                 ; #
26C1 7E       LD     A,(HL)       ; #
26C2 A2       AND    D            ; #
26C3 90       SUB    B            ; #
26C4 B4       OR     H            ; #
26C5 D8       RET    C            ; #
26C6 C600     ADD    A,#00        ; #
26C8 12       LD     (DE),A       ; #
26C9 48       LD     C,B          ; #
26CA 6C       LD     L,H          ; #
26CB 5A       LD     E,D          ; #
26CC 7E       LD     A,(HL)       ; #
26CD A2       AND    D            ; #
26CE 00       NOP                 ; #
26CF 7E       LD     A,(HL)       ; #
26D0 D8       RET    C            ; #
26D1 C6B4     ADD    A,#B4        ; #
26D3 D8       RET    C            ; #
26D4 C6B4     ADD    A,#B4        ; #
26D6 D8       RET    C            ; #
26D7 C600     ADD    A,#00        ; #
26D9 12       LD     (DE),A       ; #
26DA 7E       LD     A,(HL)       ; #
26DB A2       AND    D            ; #
26DC 90       SUB    B            ; #
26DD 7E       LD     A,(HL)       ; #
26DE D8       RET    C            ; #
26DF C6B4     ADD    A,#B4        ; #
26E1 D8       RET    C            ; #
26E2 C6B4     ADD    A,#B4        ; #
26E4 D8       RET    C            ; #
26E5 C6B4     ADD    A,#B4        ; #
26E7 D8       RET    C            ; #
26E8 C600     ADD    A,#00        ; #
26EA 12       LD     (DE),A       ; #
26EB 48       LD     C,B          ; #
26EC 3624     LD     (HL),#24     ; #
26EE 48       LD     C,B          ; #
26EF 6C       LD     L,H          ; #
26F0 00       NOP                 ; #
26F1 7E       LD     A,(HL)       ; #
26F2 A2       AND    D            ; #
26F3 90       SUB    B            ; #
26F4 B4       OR     H            ; #
26F5 D8       RET    C            ; #
26F6 00       NOP                 ; #
26F7 B4       OR     H            ; #
26F8 D8       RET    C            ; #
26F9 C600     ADD    A,#00        ; #
26FB 12       LD     (DE),A       ; #
26FC 24       INC    H            ; #
26FD 3648     LD     (HL),#48     ; #
26FF 5A       LD     E,D          ; #
2700 6C       LD     L,H          ; #
2701 7E       LD     A,(HL)       ; #
;
2702 14       INC    D            ; #
2703 00       NOP                 ; #
2704 00       NOP                 ; #
2705 00       NOP                 ; #
2706 C0       RET    NZ           ; #
2707 00       NOP                 ; #
2708 010100   LD     BC,$0001     ; #
270B 41       LD     B,C          ; #
270C 41       LD     B,C          ; #
270D 00       NOP                 ; #
270E 40       LD     B,B          ; #
270F 40       LD     B,B          ; #
2710 00       NOP                 ; #
2711 00       NOP                 ; #
2712 00       NOP                 ; #
2713 FF       RST    38H          ; #
2714 14       INC    D            ; #
2715 010042   LD     BC,$4200     ; #
2718 82       ADD    A,D          ; #
2719 00       NOP                 ; #
271A 03       INC    BC           ; #
271B 85       ADD    A,L          ; #
271C 00       NOP                 ; #
271D 43       LD     B,E          ; #
271E C5       PUSH   BC           ; #
271F 00       NOP                 ; #
2720 42       LD     B,D          ; #
2721 C40002   CALL   NZ,$0200     ; #
2724 84       ADD    A,H          ; #
2725 FF       RST    38H          ; #
2726 14       INC    D            ; #
2727 018200   LD     BC,$0082     ; #
272A C0       RET    NZ           ; #
272B 00       NOP                 ; #
272C 010100   LD     BC,$0001     ; #
272F 41       LD     B,C          ; #
2730 41       LD     B,C          ; #
2731 02       LD     (BC),A       ; #
2732 40       LD     B,B          ; #
2733 40       LD     B,B          ; #
2734 02       LD     (BC),A       ; #
2735 00       NOP                 ; #
2736 00       NOP                 ; #
2737 FF       RST    38H          ; #
2738 14       INC    D            ; #
2739 018202   LD     BC,$0282     ; #
273C C20003   JP     NZ,$0300     ; #
273F 85       ADD    A,L          ; #
2740 00       NOP                 ; #
2741 43       LD     B,E          ; #
2742 C5       PUSH   BC           ; #
2743 02       LD     (BC),A       ; #
2744 42       LD     B,D          ; #
2745 C40202   CALL   NZ,$0202     ; #
2748 84       ADD    A,H          ; #
2749 FF       RST    38H          ; #
274A 14       INC    D            ; #
274B 018200   LD     BC,$0082     ; #
274E C0       RET    NZ           ; #
274F 00       NOP                 ; #
2750 01C100   LD     BC,$00C1     ; #
2753 41       LD     B,C          ; #
2754 81       ADD    A,C          ; #
2755 02       LD     (BC),A       ; #
2756 40       LD     B,B          ; #
2757 80       ADD    A,B          ; #
2758 02       LD     (BC),A       ; #
2759 40       LD     B,B          ; #
275A 80       ADD    A,B          ; #
275B FF       RST    38H          ; #
275C 14       INC    D            ; #
275D 018200   LD     BC,$0082     ; #
2760 C0       RET    NZ           ; #
2761 42       LD     B,D          ; #
2762 0101F2   LD     BC,$F201     ; #
2765 41       LD     B,C          ; #
2766 41       LD     B,C          ; #
2767 02       LD     (BC),A       ; #
2768 40       LD     B,B          ; #
2769 40       LD     B,B          ; #
276A 02       LD     (BC),A       ; #
276B 00       NOP                 ; #
276C 00       NOP                 ; #
276D FF       RST    38H          ; #
276E 14       INC    D            ; #
276F 01A402   LD     BC,$02A4     ; #
2772 C25203   JP     NZ,$0352     ; #
2775 85       ADD    A,L          ; #
2776 F243C5   JP     P,$C543      ; #
2779 02       LD     (BC),A       ; #
277A 42       LD     B,D          ; #
277B C40202   CALL   NZ,$0202     ; #
277E 84       ADD    A,H          ; #
277F FF       RST    38H          ; #
2780 14       INC    D            ; #
2781 018200   LD     BC,$0082     ; #
2784 C0       RET    NZ           ; #
2785 52       LD     D,D          ; #
2786 01C1F2   LD     BC,$F2C1     ; #
2789 41       LD     B,C          ; #
278A 81       ADD    A,C          ; #
278B 02       LD     (BC),A       ; #
278C 40       LD     B,B          ; #
278D 80       ADD    A,B          ; #
278E 02       LD     (BC),A       ; #
278F 40       LD     B,B          ; #
2790 80       ADD    A,B          ; #
2791 FF       RST    38H          ; #
2792 14       INC    D            ; #
2793 01A400   LD     BC,$00A4     ; #
2796 C0       RET    NZ           ; #
2797 42       LD     B,D          ; #
2798 0101F4   LD     BC,$F401     ; #
279B 41       LD     B,C          ; #
279C 41       LD     B,C          ; #
279D 04       INC    B            ; #
279E 40       LD     B,B          ; #
279F 40       LD     B,B          ; #
27A0 04       INC    B            ; #
27A1 00       NOP                 ; #
27A2 00       NOP                 ; #
27A3 FF       RST    38H          ; #
27A4 14       INC    D            ; #
27A5 01A402   LD     BC,$02A4     ; #
27A8 C25203   JP     NZ,$0352     ; #
27AB 85       ADD    A,L          ; #
27AC F443C5   CALL   P,$C543      ; #
27AF 04       INC    B            ; #
27B0 42       LD     B,D          ; #
27B1 C40402   CALL   NZ,$0204     ; #
27B4 84       ADD    A,H          ; #
27B5 FF       RST    38H          ; #
27B6 14       INC    D            ; #
27B7 03       INC    BC           ; #
27B8 A4       AND    H            ; #
27B9 00       NOP                 ; #
27BA C0       RET    NZ           ; #
27BB 54       LD     D,H          ; #
27BC 01C1F4   LD     BC,$F4C1     ; #
27BF 41       LD     B,C          ; #
27C0 81       ADD    A,C          ; #
27C1 04       INC    B            ; #
27C2 40       LD     B,B          ; #
27C3 80       ADD    A,B          ; #
27C4 04       INC    B            ; #
27C5 40       LD     B,B          ; #
27C6 80       ADD    A,B          ; #
27C7 FF       RST    38H          ; #
27C8 14       INC    D            ; #
27C9 03       INC    BC           ; #
27CA A4       AND    H            ; #
27CB 00       NOP                 ; #
27CC C0       RET    NZ           ; #
27CD 54       LD     D,H          ; #
27CE 0101F4   LD     BC,$F401     ; #
27D1 41       LD     B,C          ; #
27D2 41       LD     B,C          ; #
27D3 04       INC    B            ; #
27D4 40       LD     B,B          ; #
27D5 40       LD     B,B          ; #
27D6 04       INC    B            ; #
27D7 00       NOP                 ; #
27D8 00       NOP                 ; #
27D9 FF       RST    38H          ; #
27DA 14       INC    D            ; #
27DB 03       INC    BC           ; #
27DC A4       AND    H            ; #
27DD 02       LD     (BC),A       ; #
27DE C25403   JP     NZ,$0354     ; #
27E1 85       ADD    A,L          ; #
27E2 F443C5   CALL   P,$C543      ; #
27E5 04       INC    B            ; #
27E6 42       LD     B,D          ; #
27E7 C40402   CALL   NZ,$0204     ; #
27EA 84       ADD    A,H          ; #
27EB FF       RST    38H          ; #
27EC FF       RST    38H          ; #
27ED 00       NOP                 ; #
27EE 00       NOP                 ; #
27EF 06C6     LD     B,#C6        ; #
27F1 00       NOP                 ; #
27F2 07       RLCA                ; #
27F3 07       RLCA                ; #
27F4 00       NOP                 ; #
27F5 47       LD     B,A          ; #
27F6 47       LD     B,A          ; #
27F7 00       NOP                 ; #
27F8 46       LD     B,(HL)       ; #
27F9 46       LD     B,(HL)       ; #
27FA 00       NOP                 ; #
27FB 0606     LD     B,#06        ; #
27FD FF       RST    38H          ; #
27FE FF       RST    38H          ; #
27FF 00       NOP                 ; #
2800 00       NOP                 ; #
2801 08       EX     AF,A'F'      ; #
2802 C8       RET    Z            ; #
2803 00       NOP                 ; #
2804 09       ADD    HL,BC        ; #
2805 C9       RET                 ; #
2806 00       NOP                 ; #
2807 09       ADD    HL,BC        ; #
2808 C9       RET                 ; #
2809 00       NOP                 ; #
280A 48       LD     C,B          ; #
280B 48       LD     C,B          ; #
280C 00       NOP                 ; #
280D 08       EX     AF,A'F'      ; #
280E 08       EX     AF,A'F'      ; #
280F FF       RST    38H          ; #
2810 FF       RST    38H          ; #
2811 00       NOP                 ; #
2812 00       NOP                 ; #
2813 0A       LD     A,(BC)       ; #
2814 4A       LD     C,D          ; #
2815 00       NOP                 ; #
2816 0B       DEC    BC           ; #
2817 CB00     RLC    B            ; #
2819 0B       DEC    BC           ; #
281A CB00     RLC    B            ; #
281C 0A       LD     A,(BC)       ; #
281D 4A       LD     C,D          ; #
281E 00       NOP                 ; #
281F 1656     LD     D,#56        ; #
2821 FF       RST    38H          ; #
2822 FF       RST    38H          ; #
2823 00       NOP                 ; #
2824 00       NOP                 ; #
2825 0C       INC    C            ; #
2826 CC000D   CALL   Z,$0D00      ; #
2829 0D       DEC    C            ; #
282A 00       NOP                 ; #
282B 4D       LD     C,L          ; #
282C 4D       LD     C,L          ; #
282D 00       NOP                 ; #
282E 0C       INC    C            ; #
282F CC0017   CALL   Z,$1700      ; #
2832 D7       RST    10H          ; #
2833 FF       RST    38H          ; #
2834 FF       RST    38H          ; #
2835 00       NOP                 ; #
2836 00       NOP                 ; #
2837 0E0E     LD     C,#0E        ; #
2839 00       NOP                 ; #
283A 0F       RRCA                ; #
283B 0F       RRCA                ; #
283C 00       NOP                 ; #
283D 4F       LD     C,A          ; #
283E 4F       LD     C,A          ; #
283F 00       NOP                 ; #
2840 0E0E     LD     C,#0E        ; #
2842 00       NOP                 ; #
2843 4E       LD     C,(HL)       ; #
2844 4E       LD     C,(HL)       ; #
2845 FF       RST    38H          ; #
2846 FF       RST    38H          ; #
2847 00       NOP                 ; #
2848 00       NOP                 ; #
2849 1010     DJNZ   $285B        ; #
284B 00       NOP                 ; #
284C 11D100   LD     DE,$00D1     ; #
284F 11D100   LD     DE,$00D1     ; #
2852 50       LD     D,B          ; #
2853 50       LD     D,B          ; #
2854 00       NOP                 ; #
2855 1010     DJNZ   $2867        ; #
2857 FF       RST    38H          ; #
2858 FF       RST    38H          ; #
2859 00       NOP                 ; #
285A 00       NOP                 ; #
285B 12       LD     (DE),A       ; #
285C 12       LD     (DE),A       ; #
285D 00       NOP                 ; #
285E 13       INC    DE           ; #
285F 13       INC    DE           ; #
2860 00       NOP                 ; #
2861 53       LD     D,E          ; #
2862 53       LD     D,E          ; #
2863 00       NOP                 ; #
2864 52       LD     D,D          ; #
2865 52       LD     D,D          ; #
2866 00       NOP                 ; #
2867 12       LD     (DE),A       ; #
2868 12       LD     (DE),A       ; #
2869 FF       RST    38H          ; #
286A FF       RST    38H          ; #
286B 00       NOP                 ; #
286C 00       NOP                 ; #
286D 14       INC    D            ; #
286E D40015   CALL   NC,$1500     ; #
2871 15       DEC    D            ; #
2872 00       NOP                 ; #
2873 55       LD     D,L          ; #
2874 55       LD     D,L          ; #
2875 00       NOP                 ; #
2876 14       INC    D            ; #
2877 D40014   CALL   NC,$1400     ; #
287A D4FF58   CALL   NC,$58FF     ; #
287D 5A       LD     E,D          ; #
287E 5C       LD     E,H          ; #
287F 5E       LD     E,(HL)       ; #
2880 282A     JR     Z,$28AC      ; #
2882 2C       INC    L            ; #
2883 2E30     LD     L,#30        ; #
2885 34       INC    (HL)         ; #
2886 3632     LD     (HL),#32     ; #
2888 50       LD     D,B          ; #
2889 52       LD     D,D          ; #
288A 54       LD     D,H          ; #
288B 56       LD     D,(HL)       ; #
288C 42       LD     B,D          ; #
288D 46       LD     B,(HL)       ; #
288E 40       LD     B,B          ; #
288F 44       LD     B,H          ; #
2890 4A       LD     C,D          ; #
2891 4E       LD     C,(HL)       ; #
2892 48       LD     C,B          ; #
2893 4C       LD     C,H          ; #
2894 1A       LD     A,(DE)       ; #
2895 1E20     LD     E,#20        ; #
2897 24       INC    H            ; #
2898 222618   LD     ($1826),HL   ; #
289B 1C       INC    E            ; #
289C 08       EX     AF,A'F'      ; #
289D 0C       INC    C            ; #
289E 12       LD     (DE),A       ; #
289F 1610     LD     D,#10        ; #
28A1 14       INC    D            ; #
28A2 0A       LD     A,(BC)       ; #
28A3 0E21     LD     C,#21        ; #
28A5 2089     JR     NZ,$2830     ; #

28A7 222298   LD     ($9822),HL   ;
28AA FD211629 LD     IY,$2916     ;
28AE 3A2598   LD     A,($9825)    ;
28B1 A7       AND    A            ;
28B2 2027     JR     NZ,$28DB     ;
28B4 3A2198   LD     A,($9821)    ;
28B7 0F       RRCA                ;
28B8 0F       RRCA                ;
28B9 4F       LD     C,A          ;
28BA 0F       RRCA                ;
28BB 47       LD     B,A          ;
28BC E61C     AND    #1C          ;
28BE 78       LD     A,B          ;
28BF 2802     JR     Z,$28C3      ;
28C1 3E03     LD     A,#03        ;
28C3 E603     AND    #03          ;
28C5 210E29   LD     HL,$290E     ; Data block after routine
28C8 CF       RST    08H          ; HL=HL+A*2
28C9 118492   LD     DE,$9284     ;
28CC 79       LD     A,C          ;
28CD EDA0     LDI                 ;
28CF EDA0     LDI                 ;
28D1 211C29   LD     HL,$291C     ;
28D4 E607     AND    #07          ;
28D6 D7       RST    10H          ;
28D7 56       LD     D,(HL)       ;
28D8 5A       LD     E,D          ;
28D9 1803     JR     $28DE        ;
28DB 112436   LD     DE,$3624     ;
28DE 21088B   LD     HL,$8B08     ;
28E1 DD       ???                 ;
28E2 2E01     LD     L,#01        ;
28E4 0614     LD     B,#14        ;
28E6 DD       ???                 ;
28E7 62       ???                 ;
28E8 CDF728   CALL   $28F7        ;
28EB 0608     LD     B,#08        ;
28ED DD       ???                 ;
28EE 2610     LD     H,#10        ;
28F0 CDF728   CALL   $28F7        ;
28F3 0610     LD     B,#10        ;
28F5 DD       ???                 ;
28F6 63       LD     H,E          ;
28F7 DD       ???                 ;
28F8 2D       DEC    L            ;
28F9 2008     JR     NZ,$2903     ;
28FB FD4E00   LD     C,(IY+#00)   ;
28FE FD23     INC    IY           ;
2900 DD       ???                 ;
2901 2E08     LD     L,#08        ;
2903 CB01     RLC    C            ;
2905 DD       ???                 ;
2906 7C       LD     A,H          ;
2907 1F       RRA                 ;
2908 77       LD     (HL),A       ;
2909 2C       INC    L            ;
290A 2C       INC    L            ;
290B 10EA     DJNZ   $28F7        ;
290D C9       RET                 ;
;
290E 0AB8;
2910 0FB9;
2912 14BC;
2914 1EBD;
2916 A55A;
2918 A90F;
291A 0A50;
291C 3624;
291E D4BA;
2920 E4CC;
2922 A8F4;

;======================================================================
; PLAY COMMAND 08 ??
;
2924 2A2298   LD     HL,($9822)   ;
2927 7E       LD     A,(HL)       ;
2928 FE7F     CP     #7F          ;
292A CA372A   JP     Z,$2A37      ;
292D FE7E     CP     #7E          ;
292F 2030     JR     NZ,$2961     ;
2931 3A4298   LD     A,($9842)    ;
2934 A7       AND    A            ;
2935 C8       RET    Z            ;
2936 3A8792   LD     A,($9287)    ;
2939 A7       AND    A            ;
293A 201F     JR     NZ,$295B     ;
293C 3A2598   LD     A,($9825)    ;
293F 47       LD     B,A          ;
2940 A7       AND    A            ;
2941 200F     JR     NZ,$2952     ;
2943 3AAC92   LD     A,($92AC)    ;
2946 FE01     CP     #01          ;
2948 2006     JR     NZ,$2950     ;
294A 3E08     LD     A,#08        ;
294C 32A892   LD     ($92A8),A    ;
294F C9       RET                 ;
2950 A7       AND    A            ;
2951 C0       RET    NZ           ;
2952 23       INC    HL           ;
2953 222298   LD     ($9822),HL   ;
2956 212698   LD     HL,$9826     ;
2959 34       INC    (HL)         ;
295A C9       RET                 ;
295B 3E02     LD     A,#02        ;
295D 32AC92   LD     ($92AC),A    ;
2960 C9       RET                 ;
2961 4F       LD     C,A          ;
2962 CB7F     BIT    7,A          ;
2964 2006     JR     NZ,$296C     ;
2966 3AA092   LD     A,($92A0)    ;
2969 E607     AND    #07          ;
296B C0       RET    NZ           ;
296C CB21     SLA    C            ;
296E 060C     LD     B,#0C        ;
2970 111400   LD     DE,$0014     ; 14 Bytes per bee
2973 DD210091 LD     IX,$9100     ; Bee space
2977 DDCB1346 BIT    0,(IX+#13)   ; Process this?
297B 2805     JR     Z,$2982      ; Yes ...
297D DD19     ADD    IX,DE        ; Else next bee
297F 10F6     DJNZ   $2977        ; Keep going
2981 C9       RET                 ; Done

2982 23       INC    HL           ;
2983 7E       LD     A,(HL)       ;
2984 47       LD     B,A          ;
2985 E678     AND    #78          ;
2987 FE78     CP     #78          ;
2989 78       LD     A,B          ;
298A 2002     JR     NZ,$298E     ;
298C CBB7     RES    6,A          ;
298E DD7710   LD     (IX+#10),A   ;
2991 23       INC    HL           ;
2992 222298   LD     ($9822),HL   ;
2995 2688     LD     H,#88        ;
2997 6F       LD     L,A          ;
2998 3607     LD     (HL),#07     ;
299A 2C       INC    L            ;
299B DD       ???                 ;
299C 5D       LD     E,L          ;
299D 73       LD     (HL),E       ;
299E 2693     LD     H,#93        ;
29A0 E638     AND    #38          ;
29A2 FE38     CP     #38          ;
29A4 281B     JR     Z,$29C1      ;
29A6 2D       DEC    L            ;
29A7 268B     LD     H,#8B        ;
29A9 7E       LD     A,(HL)       ;
29AA 57       LD     D,A          ;
29AB E678     AND    #78          ;
29AD 77       LD     (HL),A       ;
29AE 2C       INC    L            ;
29AF 7A       LD     A,D          ;
29B0 E607     AND    #07          ;
29B2 CB7A     BIT    7,D          ;
29B4 77       LD     (HL),A       ;
29B5 3E00     LD     A,#00        ;
29B7 2803     JR     Z,$29BC      ;
29B9 3AE392   LD     A,($92E3)    ;
29BC DD770F   LD     (IX+#0F),A   ;
29BF 181E     JR     $29DF        ;
29C1 111002   LD     DE,$0210     ;
29C4 CB70     BIT    6,B          ;
29C6 200D     JR     NZ,$29D5     ;
29C8 111803   LD     DE,$0318     ;
29CB 3A2698   LD     A,($9826)    ;
29CE FE02     CP     #02          ;
29D0 2003     JR     NZ,$29D5     ;
29D2 110800   LD     DE,$0008     ;
29D5 268B     LD     H,#8B        ;
29D7 72       LD     (HL),D       ;
29D8 2D       DEC    L            ;
29D9 73       LD     (HL),E       ;
29DA 2C       INC    L            ;
29DB DD360F00 LD     (IX+#0F),#00 ; No firing
29DF 51       LD     D,C          ;
29E0 CBB9     RES    7,C          ;
29E2 0608     LD     B,#08        ;
29E4 CB49     BIT    1,C          ;
29E6 2802     JR     Z,$29EA      ;
29E8 0644     LD     B,#44        ;
29EA DD700E   LD     (IX+#0E),B   ;
29ED 0600     LD     B,#00        ;
29EF 214A2A   LD     HL,$2A4A     ;
29F2 09       ADD    HL,BC        ;
29F3 7E       LD     A,(HL)       ;
29F4 23       INC    HL           ;
29F5 DD7708   LD     (IX+#08),A   ;
29F8 AF       XOR    A            ;
29F9 ED6F     RLD                 ;
29FB 47       LD     B,A          ;
29FC 7E       LD     A,(HL)       ;
29FD E61F     AND    #1F          ;
29FF DD7709   LD     (IX+#09),A   ;
2A02 78       LD     A,B          ;
2A03 E60E     AND    #0E          ;
2A05 47       LD     B,A          ;
2A06 07       RLCA                ;
2A07 80       ADD    A,B          ;
2A08 217A2A   LD     HL,$2A7A     ;
2A0B D7       RST    10H          ;
2A0C CB7A     BIT    7,D          ;
2A0E 2803     JR     Z,$2A13      ;
2A10 23       INC    HL           ;
2A11 23       INC    HL           ;
2A12 23       INC    HL           ;
2A13 7E       LD     A,(HL)       ;
2A14 23       INC    HL           ;
2A15 DD7701   LD     (IX+#01),A   ;
2A18 7E       LD     A,(HL)       ;
2A19 23       INC    HL           ;
2A1A DD7703   LD     (IX+#03),A   ;
2A1D 7E       LD     A,(HL)       ;
2A1E 23       INC    HL           ;
2A1F DD7705   LD     (IX+#05),A   ;
2A22 AF       XOR    A            ;
2A23 DD7700   LD     (IX+#00),A   ;
2A26 DD7702   LD     (IX+#02),A   ;
2A29 DD7704   LD     (IX+#04),A   ;
2A2C 3C       INC    A            ;
2A2D DD770D   LD     (IX+#0D),A   ;
2A30 B2       OR     D            ;
2A31 E681     AND    #81          ;
2A33 DD7713   LD     (IX+#13),A   ;
2A36 C9       RET                 ;

2A37 3A8792   LD     A,($9287)    ;
2A3A A7       AND    A            ;
2A3B C0       RET    NZ           ;
2A3C 320890   LD     ($9008),A    ;
2A3F 3C       INC    A            ;
2A40 320490   LD     ($9004),A    ;
2A43 321090   LD     ($9010),A    ;
2A46 322498   LD     ($9824),A    ;
2A49 C9       RET                 ;

2A4A 1D       DEC    E            ; #
2A4B 00       NOP                 ; #
2A4C 67       LD     H,A          ; #
2A4D 209F     JR     NZ,$29EE     ; #
2A4F 40       LD     B,B          ; #
2A50 D4207B   CALL   NC,$7B20     ; #
2A53 01B061   LD     BC,$61B0     ; #
2A56 E8       RET    PE           ; #
2A57 01F521   LD     BC,$21F5     ; #
2A5A 0B       DEC    BC           ; #
2A5B 02       LD     (BC),A       ; #
2A5C 1B       DEC    DE           ; #
2A5D 222B82   LD     ($822B),HL   ; #
2A60 41       LD     B,C          ; #
2A61 225D82   LD     ($825D),HL   ; #
2A64 79       LD     A,C          ; #
2A65 229E02   LD     ($029E),HL   ; #
2A68 BA       CP     D            ; #
2A69 22D902   LD     ($02D9),HL   ; #
2A6C FB       EI                  ; #
2A6D 221D03   LD     ($031D),HL   ; #
2A70 33       INC    SP           ; #
2A71 23       INC    HL           ; #
2A72 DA0FF0   JP     C,$F00F      ; #
2A75 2F       CPL                 ; #
2A76 2B       DEC    HL           ; #
2A77 A2       AND    D            ; #
2A78 5D       LD     E,L          ; #
2A79 A2       AND    D            ; #
2A7A 9B       SBC    A,E          ; #
2A7B 34       INC    (HL)         ; #
2A7C 03       INC    BC           ; #
2A7D 9B       SBC    A,E          ; #
2A7E 44       LD     B,H          ; #
2A7F 03       INC    BC           ; #
2A80 23       INC    HL           ; #
2A81 00       NOP                 ; #
2A82 00       NOP                 ; #
2A83 23       INC    HL           ; #
2A84 78       LD     A,B          ; #
2A85 02       LD     (BC),A       ; #
2A86 9B       SBC    A,E          ; #
2A87 2C       INC    L            ; #
2A88 03       INC    BC           ; #
2A89 9B       SBC    A,E          ; #
2A8A 4C       LD     C,H          ; #
2A8B 03       INC    BC           ; #
2A8C 2B       DEC    HL           ; #
2A8D 00       NOP                 ; #
2A8E 00       NOP                 ; #
2A8F 2B       DEC    HL           ; #
2A90 78       LD     A,B          ; #
2A91 02       LD     (BC),A       ; #
2A92 9B       SBC    A,E          ; #
2A93 34       INC    (HL)         ; #
2A94 03       INC    BC           ; #
2A95 9B       SBC    A,E          ; #
2A96 34       INC    (HL)         ; #
2A97 03       INC    BC           ; #
2A98 9B       SBC    A,E          ; #
2A99 44       LD     B,H          ; #
2A9A 03       INC    BC           ; #
2A9B 9B       SBC    A,E          ; #
2A9C 44       LD     B,H          ; #
2A9D 03       INC    BC           ; #

;======================================================================
; PLAY COMMAND 0A (?Explosion sequence for bee?)
;
2A9E 3AA092   LD     A,($92A0)    ;
2AA1 3D       DEC    A            ;
2AA2 E603     AND    #03          ;
2AA4 C0       RET    NZ           ;
2AA5 3AA792   LD     A,($92A7)    ;
2AA8 47       LD     B,A          ;
2AA9 3A0890   LD     A,($9008)    ;
2AAC B0       OR     B            ;
2AAD 2848     JR     Z,$2AF7      ;
2AAF 3A0F92   LD     A,($920F)    ;
2AB2 A7       AND    A            ;
2AB3 0E01     LD     C,#01        ;
2AB5 2802     JR     Z,$2AB9      ;
2AB7 0D       DEC    C            ;
2AB8 0D       DEC    C            ;
2AB9 2E00     LD     L,#00        ;
2ABB 060A     LD     B,#0A        ;
2ABD 2699     LD     H,#99        ;
2ABF 7E       LD     A,(HL)       ;
2AC0 81       ADD    A,C          ;
2AC1 77       LD     (HL),A       ;
2AC2 2698     LD     H,#98        ;
2AC4 7E       LD     A,(HL)       ;
2AC5 81       ADD    A,C          ;
2AC6 77       LD     (HL),A       ;
2AC7 2C       INC    L            ;
2AC8 2C       INC    L            ;
2AC9 10F2     DJNZ   $2ABD        ;
2ACB 3A2498   LD     A,($9824)    ;
2ACE A7       AND    A            ;
2ACF 3A0099   LD     A,($9900)    ;
2AD2 2803     JR     Z,$2AD7      ;
2AD4 A7       AND    A            ;
2AD5 2811     JR     Z,$2AE8      ;
2AD7 FE20     CP     #20          ;
2AD9 2006     JR     NZ,$2AE1     ;
2ADB 3E01     LD     A,#01        ;
2ADD 320F92   LD     ($920F),A    ;
2AE0 C9       RET                 ;
;
2AE1 D6E0     SUB    #E0          ;
2AE3 C0       RET    NZ           ;
2AE4 320F92   LD     ($920F),A    ;
2AE7 C9       RET                 ;
;
2AE8 AF       XOR    A            ;
2AE9 320F92   LD     ($920F),A    ;
2AEC 320A90   LD     ($900A),A    ;
2AEF 3C       INC    A            ;
2AF0 32A09A   LD     ($9AA0),A    ;
2AF3 320990   LD     ($9009),A    ;
2AF6 C9       RET                 ;
;
2AF7 320A90   LD     ($900A),A    ;
2AFA C9       RET                 ;

; FFs (RST 38H) From here to next

;======================================================================
;
2C00 3A2198   LD     A,($9821)    ;
2C03 FE1B     CP     #1B          ;
2C05 3804     JR     C,$2C0B      ;
2C07 D604     SUB    #04          ;
2C09 18F8     JR     $2C03        ;
2C0B 3D       DEC    A            ;
2C0C 6F       LD     L,A          ;
2C0D 07       RLCA                ;
2C0E 07       RLCA                ;
2C0F 85       ADD    A,L          ;
2C10 5F       LD     E,A          ;
2C11 3A8499   LD     A,($9984)    ;
2C14 21652C   LD     HL,$2C65     ;
2C17 CF       RST    08H          ;
2C18 7E       LD     A,(HL)       ;
2C19 23       INC    HL           ;
2C1A 66       LD     H,(HL)       ;
2C1B 6F       LD     L,A          ;
2C1C 7B       LD     A,E          ;
2C1D D7       RST    10H          ;
2C1E 11C099   LD     DE,$99C0     ;
2C21 0605     LD     B,#05        ;
2C23 7E       LD     A,(HL)       ;
2C24 4F       LD     C,A          ;
2C25 07       RLCA                ;
2C26 07       RLCA                ;
2C27 07       RLCA                ;
2C28 07       RLCA                ;
2C29 E60F     AND    #0F          ;
2C2B 12       LD     (DE),A       ;
2C2C 1C       INC    E            ;
2C2D 79       LD     A,C          ;
2C2E E60F     AND    #0F          ;
2C30 12       LD     (DE),A       ;
2C31 1C       INC    E            ;
2C32 23       INC    HL           ;
2C33 10EE     DJNZ   $2C23        ;
2C35 3A2198   LD     A,($9821)    ;
2C38 FE03     CP     #03          ;
2C3A 3003     JR     NZ,$2C3F     ;
2C3C AF       XOR    A            ;
2C3D 1807     JR     $2C46        ;
2C3F F6FC     OR     #FC          ;
2C41 3C       INC    A            ;
2C42 2802     JR     Z,$2C46      ;
2C44 3E0A     LD     A,#0A        ;
2C46 12       LD     (DE),A       ;
2C47 011602   LD     BC,$0216     ;
2C4A ED43C192 LD     ($92C1),BC   ;
2C4E ED43C092 LD     ($92C0),BC   ;
2C52 3A2198   LD     A,($9821)    ;
2C55 FE10     CP     #10          ;
2C57 3802     JR     C,$2C5B      ;
2C59 3E10     LD     A,#10        ;
2C5B 07       RLCA                ;
2C5C 07       RLCA                ;
2C5D E670     AND    #70          ;
2C5F C640     ADD    A,#40        ;
2C61 32BB99   LD     ($99BB),A    ;
2C64 C9       RET                 ;

;======================================================================
;
2C65 EF       RST    28H          ; #
2C66 2C       INC    L            ; #
2C67 71       LD     (HL),C       ; #
2C68 2D       DEC    L            ; #
2C69 F3       DI                  ; #
2C6A 2D       DEC    L            ; #
2C6B 6D       LD     L,L          ; #
2C6C 2C       INC    L            ; #
2C6D 00       NOP                 ; #
2C6E 00       NOP                 ; #
2C6F 22C600   LD     ($00C6),HL   ; #
2C72 00       NOP                 ; #
2C73 1123C7   LD     DE,$C723     ; #
2C76 00       NOP                 ; #
2C77 00       NOP                 ; #
2C78 00       NOP                 ; #
2C79 00       NOP                 ; #
2C7A C0       RET    NZ           ; #
2C7B 00       NOP                 ; #
2C7C 111223   LD     DE,$2312     ; #
2C7F 97       SUB    A            ; #
2C80 00       NOP                 ; #
2C81 112323   LD     DE,$2323     ; #
2C84 98       SBC    A,B          ; #
2C85 00       NOP                 ; #
2C86 212433   LD     HL,$3324     ; #
2C89 98       SBC    A,B          ; #
2C8A 00       NOP                 ; #
2C8B 00       NOP                 ; #
2C8C 00       NOP                 ; #
2C8D 00       NOP                 ; #
2C8E 90       SUB    B            ; #
2C8F 00       NOP                 ; #
2C90 222533   LD     ($3325),HL   ; #
2C93 99       SBC    A,C          ; #
2C94 1022     DJNZ   $2CB8        ; #
2C96 3634     LD     (HL),#34     ; #
2C98 69       LD     L,C          ; #
2C99 1010     DJNZ   $2CAB        ; #
2C9B 112397   LD     DE,$9723     ; #
2C9E 00       NOP                 ; #
2C9F 00       NOP                 ; #
2CA0 00       NOP                 ; #
2CA1 00       NOP                 ; #
2CA2 60       LD     H,B          ; #
2CA3 00       NOP                 ; #
2CA4 324634   LD     ($3446),A    ; #
2CA7 67       LD     H,A          ; #
2CA8 113267   LD     DE,$6732     ; #
2CAB 44       LD     B,H          ; #
2CAC 68       LD     L,B          ; #
2CAD 113267   LD     DE,$6732     ; #
2CB0 45       LD     B,L          ; #
2CB1 68       LD     L,B          ; #
2CB2 110000   LD     DE,$0000     ; #
2CB5 00       NOP                 ; #
2CB6 60       LD     H,B          ; #
2CB7 00       NOP                 ; #
2CB8 42       LD     B,D          ; #
2CB9 78       LD     A,B          ; #
2CBA 45       LD     B,L          ; #
2CBB 69       LD     L,C          ; #
2CBC 114278   LD     DE,$7842     ; #
2CBF 45       LD     B,L          ; #
2CC0 69       LD     L,C          ; #
2CC1 111122   LD     DE,$2211     ; #
2CC4 23       INC    HL           ; #
2CC5 97       SUB    A            ; #
2CC6 110000   LD     DE,$0000     ; #
2CC9 00       NOP                 ; #
2CCA 60       LD     H,B          ; #
2CCB 00       NOP                 ; #
2CCC 52       LD     D,D          ; #
2CCD 88       ADC    A,B          ; #
2CCE 46       LD     B,(HL)       ; #
2CCF 3A1152   LD     A,($5211)    ; #
2CD2 88       ADC    A,B          ; #
2CD3 56       LD     D,(HL)       ; #
2CD4 3A1152   LD     A,($5211)    ; #
2CD7 88       ADC    A,B          ; #
2CD8 56       LD     D,(HL)       ; #
2CD9 3C       INC    A            ; #
2CDA 110000   LD     DE,$0000     ; #
2CDD 00       NOP                 ; #
2CDE 3000     JR     NZ,$2CE0     ; #
2CE0 62       ???                 ; #
2CE1 89       ADC    A,C          ; #
2CE2 57       LD     D,A          ; #
2CE3 3C       INC    A            ; #
2CE4 116299   LD     DE,$9962     ; #
2CE7 57       LD     D,A          ; #
2CE8 3C       INC    A            ; #
2CE9 116299   LD     DE,$9962     ; #
2CEC 57       LD     D,A          ; #
2CED 3C       INC    A            ; #
2CEE 110000   LD     DE,$0000     ; #
2CF1 12       LD     (DE),A       ; #
2CF2 C600     ADD    A,#00        ; #
2CF4 00       NOP                 ; #
2CF5 1122C6   LD     DE,$C622     ; #
2CF8 00       NOP                 ; #
2CF9 00       NOP                 ; #
2CFA 00       NOP                 ; #
2CFB 00       NOP                 ; #
2CFC C0       RET    NZ           ; #
2CFD 00       NOP                 ; #
2CFE 111223   LD     DE,$2312     ; #
2D01 97       SUB    A            ; #
2D02 00       NOP                 ; #
2D03 111223   LD     DE,$2312     ; #
2D06 97       SUB    A            ; #
2D07 00       NOP                 ; #
2D08 00       NOP                 ; #
2D09 1123C7   LD     DE,$C723     ; #
2D0C 00       NOP                 ; #
2D0D 00       NOP                 ; #
2D0E 00       NOP                 ; #
2D0F 00       NOP                 ; #
2D10 90       SUB    B            ; #
2D11 00       NOP                 ; #
2D12 212333   LD     HL,$3323     ; #
2D15 98       SBC    A,B          ; #
2D16 1021     DJNZ   $2D39        ; #
2D18 24       INC    H            ; #
2D19 33       INC    SP           ; #
2D1A 98       SBC    A,B          ; #
2D1B 1021     DJNZ   $2D3E        ; #
2D1D 25       DEC    H            ; #
2D1E 34       INC    (HL)         ; #
2D1F 98       SBC    A,B          ; #
2D20 1000     DJNZ   $2D22        ; #
2D22 00       NOP                 ; #
2D23 00       NOP                 ; #
2D24 60       LD     H,B          ; #
2D25 00       NOP                 ; #
2D26 222534   LD     ($3425),HL   ; #
2D29 68       LD     L,B          ; #
2D2A 113236   LD     DE,$3632     ; #
2D2D 44       LD     B,H          ; #
2D2E 68       LD     L,B          ; #
2D2F 111111   LD     DE,$1111     ; #
2D32 23       INC    HL           ; #
2D33 67       LD     H,A          ; #
2D34 010000   LD     BC,$0000     ; #
2D37 00       NOP                 ; #
2D38 60       LD     H,B          ; #
2D39 00       NOP                 ; #
2D3A 323645   LD     ($4536),A    ; #
2D3D 68       LD     L,B          ; #
2D3E 113246   LD     DE,$4632     ; #
2D41 45       LD     B,L          ; #
2D42 69       LD     L,C          ; #
2D43 113267   LD     DE,$6732     ; #
2D46 45       LD     B,L          ; #
2D47 69       LD     L,C          ; #
2D48 110000   LD     DE,$0000     ; #
2D4B 00       NOP                 ; #
2D4C 60       LD     H,B          ; #
2D4D 00       NOP                 ; #
2D4E 42       LD     B,D          ; #
2D4F 67       LD     H,A          ; #
2D50 46       LD     B,(HL)       ; #
2D51 3A1142   LD     A,($4211)    ; #
2D54 78       LD     A,B          ; #
2D55 56       LD     D,(HL)       ; #
2D56 3A1152   LD     A,($5211)    ; #
2D59 78       LD     A,B          ; #
2D5A 56       LD     D,(HL)       ; #
2D5B 3A1100   LD     A,($0011)    ; #
2D5E 00       NOP                 ; #
2D5F 00       NOP                 ; #
2D60 3000     JR     NZ,$2D62     ; #
2D62 52       LD     D,D          ; #
2D63 88       ADC    A,B          ; #
2D64 56       LD     D,(HL)       ; #
2D65 3C       INC    A            ; #
2D66 116299   LD     DE,$9962     ; #
2D69 57       LD     D,A          ; #
2D6A 3C       INC    A            ; #
2D6B 116299   LD     DE,$9962     ; #
2D6E 57       LD     D,A          ; #
2D6F 3C       INC    A            ; #
2D70 110000   LD     DE,$0000     ; #
2D73 23       INC    HL           ; #
2D74 C600     ADD    A,#00        ; #
2D76 1011     DJNZ   $2D89        ; #
2D78 23       INC    HL           ; #
2D79 97       SUB    A            ; #
2D7A 00       NOP                 ; #
2D7B 00       NOP                 ; #
2D7C 00       NOP                 ; #
2D7D 00       NOP                 ; #
2D7E C0       RET    NZ           ; #
2D7F 00       NOP                 ; #
2D80 111233   LD     DE,$3312     ; #
2D83 98       SBC    A,B          ; #
2D84 00       NOP                 ; #
2D85 212334   LD     HL,$3423     ; #
2D88 68       LD     L,B          ; #
2D89 00       NOP                 ; #
2D8A 212434   LD     HL,$3424     ; #
2D8D 68       LD     L,B          ; #
2D8E 00       NOP                 ; #
2D8F 00       NOP                 ; #
2D90 00       NOP                 ; #
2D91 00       NOP                 ; #
2D92 90       SUB    B            ; #
2D93 00       NOP                 ; #
2D94 323634   LD     ($3436),A    ; #
2D97 67       LD     H,A          ; #
2D98 1032     DJNZ   $2DCC        ; #
2D9A 46       LD     B,(HL)       ; #
2D9B 44       LD     B,H          ; #
2D9C 68       LD     L,B          ; #
2D9D 1011     DJNZ   $2DB0        ; #
2D9F 112397   LD     DE,$9723     ; #
2DA2 1000     DJNZ   $2DA4        ; #
2DA4 00       NOP                 ; #
2DA5 00       NOP                 ; #
2DA6 60       LD     H,B          ; #
2DA7 00       NOP                 ; #
2DA8 42       LD     B,D          ; #
2DA9 67       LD     H,A          ; #
2DAA 45       LD     B,L          ; #
2DAB 68       LD     L,B          ; #
2DAC 114267   LD     DE,$6742     ; #
2DAF 45       LD     B,L          ; #
2DB0 69       LD     L,C          ; #
2DB1 114278   LD     DE,$7842     ; #
2DB4 46       LD     B,(HL)       ; #
2DB5 69       LD     L,C          ; #
2DB6 110000   LD     DE,$0000     ; #
2DB9 00       NOP                 ; #
2DBA 60       LD     H,B          ; #
2DBB 00       NOP                 ; #
2DBC 52       LD     D,D          ; #
2DBD 78       LD     A,B          ; #
2DBE 46       LD     B,(HL)       ; #
2DBF 3A1152   LD     A,($5211)    ; #
2DC2 88       ADC    A,B          ; #
2DC3 56       LD     D,(HL)       ; #
2DC4 3A1152   LD     A,($5211)    ; #
2DC7 88       ADC    A,B          ; #
2DC8 56       LD     D,(HL)       ; #
2DC9 3A1100   LD     A,($0011)    ; #
2DCC 00       NOP                 ; #
2DCD 00       NOP                 ; #
2DCE 60       LD     H,B          ; #
2DCF 00       NOP                 ; #
2DD0 62       ???                 ; #
2DD1 88       ADC    A,B          ; #
2DD2 56       LD     D,(HL)       ; #
2DD3 3C       INC    A            ; #
2DD4 116289   LD     DE,$8962     ; #
2DD7 57       LD     D,A          ; #
2DD8 3C       INC    A            ; #
2DD9 116289   LD     DE,$8962     ; #
2DDC 57       LD     D,A          ; #
2DDD 3E11     LD     A,#11        ; #
2DDF 00       NOP                 ; #
2DE0 00       NOP                 ; #
2DE1 00       NOP                 ; #
2DE2 3000     JR     NZ,$2DE4     ; #
2DE4 72       LD     (HL),D       ; #
2DE5 99       SBC    A,C          ; #
2DE6 57       LD     D,A          ; #
2DE7 3E11     LD     A,#11        ; #
2DE9 72       LD     (HL),D       ; #
2DEA 99       SBC    A,C          ; #
2DEB 68       LD     L,B          ; #
2DEC 3E11     LD     A,#11        ; #
2DEE 72       LD     (HL),D       ; #
2DEF 99       SBC    A,C          ; #
2DF0 68       LD     L,B          ; #
2DF1 3E11     LD     A,#11        ; #
2DF3 00       NOP                 ; #
2DF4 00       NOP                 ; #
2DF5 23       INC    HL           ; #
2DF6 C600     ADD    A,#00        ; #
2DF8 1011     DJNZ   $2E0B        ; #
2DFA 23       INC    HL           ; #
2DFB 97       SUB    A            ; #
2DFC 00       NOP                 ; #
2DFD 00       NOP                 ; #
2DFE 00       NOP                 ; #
2DFF 00       NOP                 ; #
2E00 C0       RET    NZ           ; #
2E01 00       NOP                 ; #
2E02 111234   LD     DE,$3412     ; #
2E05 98       SBC    A,B          ; #
2E06 00       NOP                 ; #
2E07 212334   LD     HL,$3423     ; #
2E0A 68       LD     L,B          ; #
2E0B 00       NOP                 ; #
2E0C 212434   LD     HL,$3424     ; #
2E0F 68       LD     L,B          ; #
2E10 00       NOP                 ; #
2E11 00       NOP                 ; #
2E12 00       NOP                 ; #
2E13 00       NOP                 ; #
2E14 90       SUB    B            ; #
2E15 00       NOP                 ; #
2E16 323645   LD     ($4536),A    ; #
2E19 67       LD     H,A          ; #
2E1A 113246   LD     DE,$4632     ; #
2E1D 46       LD     B,(HL)       ; #
2E1E 68       LD     L,B          ; #
2E1F 113256   LD     DE,$5632     ; #
2E22 46       LD     B,(HL)       ; #
2E23 69       LD     L,C          ; #
2E24 110000   LD     DE,$0000     ; #
2E27 00       NOP                 ; #
2E28 60       LD     H,B          ; #
2E29 00       NOP                 ; #
2E2A 42       LD     B,D          ; #
2E2B 67       LD     H,A          ; #
2E2C 56       LD     D,(HL)       ; #
2E2D 6A       LD     L,D          ; #
2E2E 114267   LD     DE,$6742     ; #
2E31 56       LD     D,(HL)       ; #
2E32 6A       LD     L,D          ; #
2E33 114278   LD     DE,$7842     ; #
2E36 57       LD     D,A          ; #
2E37 6A       LD     L,D          ; #
2E38 110000   LD     DE,$0000     ; #
2E3B 00       NOP                 ; #
2E3C 60       LD     H,B          ; #
2E3D 00       NOP                 ; #
2E3E 52       LD     D,D          ; #
2E3F 78       LD     A,B          ; #
2E40 57       LD     D,A          ; #
2E41 3A1152   LD     A,($5211)    ; #
2E44 88       ADC    A,B          ; #
2E45 57       LD     D,A          ; #
2E46 3A1152   LD     A,($5211)    ; #
2E49 88       ADC    A,B          ; #
2E4A 68       LD     L,B          ; #
2E4B 3C       INC    A            ; #
2E4C 110000   LD     DE,$0000     ; #
2E4F 00       NOP                 ; #
2E50 60       LD     H,B          ; #
2E51 00       NOP                 ; #
2E52 62       ???                 ; #
2E53 88       ADC    A,B          ; #
2E54 68       LD     L,B          ; #
2E55 3C       INC    A            ; #
2E56 116289   LD     DE,$8962     ; #
2E59 68       LD     L,B          ; #
2E5A 3C       INC    A            ; #
2E5B 116289   LD     DE,$8962     ; #
2E5E 68       LD     L,B          ; #
2E5F 3E11     LD     A,#11        ; #
2E61 00       NOP                 ; #
2E62 00       NOP                 ; #
2E63 00       NOP                 ; #
2E64 3000     JR     NZ,$2E66     ; #
2E66 72       LD     (HL),D       ; #
2E67 99       SBC    A,C          ; #
2E68 68       LD     L,B          ; #
2E69 3E11     LD     A,#11        ; #
2E6B 72       LD     (HL),D       ; #
2E6C 99       SBC    A,C          ; #
2E6D 68       LD     L,B          ; #
2E6E 3E11     LD     A,#11        ; #
2E70 72       LD     (HL),D       ; #
2E71 99       SBC    A,C          ; #
2E72 68       LD     L,B          ; #
2E73 3E11     LD     A,#11        ; #

; FFs (RST 38H) From here to next

2FFF 50       LD     D,B          ;

;======================================================================
;
3000 21FD83   LD     HL,$83FD     ;
3003 3A4098   LD     A,($9840)    ;
3006 A7       AND    A            ;
3007 2803     JR     Z,$300C      ;
3009 21E883   LD     HL,$83E8     ;
300C 22008A   LD     ($8A00),HL   ;
300F 113D8A   LD     DE,$8A3D     ;
3012 CDF731   CALL   $31F7        ;
3015 D0       RET    NC           ;
3016 11378A   LD     DE,$8A37     ;
3019 CDF731   CALL   $31F7        ;
301C 3E05     LD     A,#05        ;
301E 3027     JR     NZ,$3047     ;
3020 11318A   LD     DE,$8A31     ;
3023 CDF731   CALL   $31F7        ;
3026 3E04     LD     A,#04        ;
3028 301D     JR     NZ,$3047     ;
302A 112B8A   LD     DE,$8A2B     ;
302D CDF731   CALL   $31F7        ;
3030 3E03     LD     A,#03        ;
3032 3013     JR     NZ,$3047     ;
3034 11258A   LD     DE,$8A25     ;
3037 CDF731   CALL   $31F7        ;
303A 3E02     LD     A,#02        ;
303C 3009     JR     NZ,$3047     ;
303E 3EFF     LD     A,#FF        ;
3040 32AC9A   LD     ($9AAC),A    ;
3043 3E01     LD     A,#01        ;
3045 1803     JR     $304A        ;
3047 32B09A   LD     ($9AB0),A    ;
304A 32118A   LD     ($8A11),A    ;
304D 21A631   LD     HL,$31A6     ;
3050 3D       DEC    A            ;
3051 CF       RST    08H          ;
3052 CD1831   CALL   $3118        ;
3055 3A118A   LD     A,($8A11)    ;
3058 21A131   LD     HL,$31A1     ;
305B 3D       DEC    A            ;
305C D7       RST    10H          ;
305D 7E       LD     A,(HL)       ;
305E 21498A   LD     HL,$8A49     ;
3061 114C8A   LD     DE,$8A4C     ;
3064 A7       AND    A            ;
3065 2805     JR     Z,$306C      ;
3067 4F       LD     C,A          ;
3068 0600     LD     B,#00        ;
306A EDB8     LDDR                ;
306C 0603     LD     B,#03        ;
306E 3E24     LD     A,#24        ;
3070 22048A   LD     ($8A04),HL   ;
3073 2C       INC    L            ;
3074 77       LD     (HL),A       ;
3075 10FC     DJNZ   $3073        ;
3077 3E49     LD     A,#49        ;
3079 32108A   LD     ($8A10),A    ;
307C 217F32   LD     HL,$327F     ;
307F CD2833   CALL   $3328        ;
3082 CD1B33   CALL   $331B        ;
3085 CD2833   CALL   $3328        ;
3088 110983   LD     DE,$8309     ;
308B 2A008A   LD     HL,($8A00)   ;
308E CD7532   CALL   $3275        ;
3091 214981   LD     HL,$8149     ;
3094 11E0FF   LD     DE,$FFE0     ;
3097 360A     LD     (HL),#0A     ;
3099 19       ADD    HL,DE        ;
309A 360A     LD     (HL),#0A     ;
309C 19       ADD    HL,DE        ;
309D 360A     LD     (HL),#0A     ;
309F CD1D32   CALL   $321D        ;
30A2 CD8031   CALL   $3180        ;
30A5 3E04     LD     A,#04        ;
30A7 32AE92   LD     ($92AE),A    ;
30AA 3AAE92   LD     A,($92AE)    ;
30AD A7       AND    A            ;
30AE 20FA     JR     NZ,$30AA     ;
30B0 3E28     LD     A,#28        ;
30B2 32AE92   LD     ($92AE),A    ;
30B5 CD1D32   CALL   $321D        ;
30B8 CD8031   CALL   $3180        ;
30BB 3AA092   LD     A,($92A0)    ;
30BE 4F       LD     C,A          ;
30BF CDED32   CALL   $32ED        ;
30C2 3AA092   LD     A,($92A0)    ;
30C5 B9       CP     C            ;
30C6 28F7     JR     Z,$30BF      ;
30C8 4F       LD     C,A          ;
30C9 E60F     AND    #0F          ;
30CB CC4131   CALL   Z,$3141      ;
30CE 21B699   LD     HL,$99B6     ;
30D1 3A1592   LD     A,($9215)    ;
30D4 A7       AND    A            ;
30D5 2801     JR     Z,$30D8      ;
30D7 23       INC    HL           ;
30D8 CB66     BIT    4,(HL)       ;
30DA CA4C31   JP     Z,$314C      ;
30DD 7E       LD     A,(HL)       ;
30DE E60A     AND    #0A          ;
30E0 21028A   LD     HL,$8A02     ;
30E3 11038A   LD     DE,$8A03     ;
30E6 BE       CP     (HL)         ;
30E7 2804     JR     Z,$30ED      ;
30E9 77       LD     (HL),A       ;
30EA 3EFD     LD     A,#FD        ;
30EC 12       LD     (DE),A       ;
30ED 1A       LD     A,(DE)       ;
30EE 3C       INC    A            ;
30EF 12       LD     (DE),A       ;
30F0 E60F     AND    #0F          ;
30F2 20CB     JR     NZ,$30BF     ;
30F4 7E       LD     A,(HL)       ;
30F5 FE08     CP     #08          ;
30F7 2824     JR     Z,$311D      ;
30F9 FE02     CP     #02          ;
30FB 20C2     JR     NZ,$30BF     ;
30FD 3E28     LD     A,#28        ;
30FF 32AE92   LD     ($92AE),A    ;
3102 3A108A   LD     A,($8A10)    ;
3105 6F       LD     L,A          ;
3106 2681     LD     H,#81        ;
3108 7E       LD     A,(HL)       ;
3109 3D       DEC    A            ;
310A FE09     CP     #09          ;
310C CC3831   CALL   Z,$3138      ;
310F FE29     CP     #29          ;
3111 CC3B31   CALL   Z,$313B      ;
3114 77       LD     (HL),A       ;
3115 C3BF30   JP     $30BF        ;
3118 7E       LD     A,(HL)       ;
3119 23       INC    HL           ;
311A 66       LD     H,(HL)       ;
311B 6F       LD     L,A          ;
311C E9       JP     (HL)         ;
311D 3A108A   LD     A,($8A10)    ;
3120 6F       LD     L,A          ;
3121 2681     LD     H,#81        ;
3123 3E28     LD     A,#28        ;
3125 32AE92   LD     ($92AE),A    ;
3128 7E       LD     A,(HL)       ;
3129 3C       INC    A            ;
312A FE2B     CP     #2B          ;
312C CC3E31   CALL   Z,$313E      ;
312F FE25     CP     #25          ;
3131 CC3831   CALL   Z,$3138      ;
3134 77       LD     (HL),A       ;
3135 C3BF30   JP     $30BF        ;

3138 3E2A     LD     A,#2A        ;
313A C9       RET                 ;

313B 3E24     LD     A,#24        ; <space>
313D C9       RET                 ;

313E 3E0A     LD     A,#0A        ; <cr>
3140 C9       RET                 ;

3141 3A108A   LD     A,($8A10)    ;
3144 6F       LD     L,A          ;
3145 2685     LD     H,#85        ;
3147 7E       LD     A,(HL)       ;
3148 EE05     XOR    #05          ;
314A 77       LD     (HL),A       ;
314B C9       RET                 ;

314C 3A108A   LD     A,($8A10)    ;
314F 6F       LD     L,A          ;
3150 2685     LD     H,#85        ;
3152 3600     LD     (HL),#00     ;
3154 2681     LD     H,#81        ;
3156 4E       LD     C,(HL)       ;
3157 3E28     LD     A,#28        ;
3159 32AE92   LD     ($92AE),A    ;
315C 2A048A   LD     HL,($8A04)   ;
315F 23       INC    HL           ;
3160 71       LD     (HL),C       ;
3161 22048A   LD     ($8A04),HL   ;
3164 21108A   LD     HL,$8A10     ;
3167 7E       LD     A,(HL)       ;
3168 D620     SUB    #20          ;
316A 77       LD     (HL),A       ;
316B D2B530   JP     NC,$30B5     ;
316E CD1D32   CALL   $321D        ;
3171 CD8031   CALL   $3180        ;
3174 3E4C     LD     A,#4C        ;
3176 32A092   LD     ($92A0),A    ;
3179 3AA092   LD     A,($92A0)    ;
317C A7       AND    A            ;
317D 20FA     JR     NZ,$3179     ;
317F C9       RET                 ;
3180 3A118A   LD     A,($8A11)    ;
3183 219731   LD     HL,$3197     ;
3186 3D       DEC    A            ;
3187 CF       RST    08H          ;
3188 7E       LD     A,(HL)       ;
3189 23       INC    HL           ;
318A 66       LD     H,(HL)       ;
318B 6F       LD     L,A          ;
318C 0616     LD     B,#16        ;
318E 11E0FF   LD     DE,$FFE0     ;
3191 3605     LD     (HL),#05     ;
3193 19       ADD    HL,DE        ;
3194 10FB     DJNZ   $3191        ;
3196 C9       RET                 ;
3197 74       LD     (HL),H       ;
3198 87       ADD    A,A          ;
3199 76       HALT                ;
319A 87       ADD    A,A          ;
319B 78       LD     A,B          ;
319C 87       ADD    A,A          ;
319D 7A       LD     A,D          ;
319E 87       ADD    A,A          ;
319F 7C       LD     A,H          ;
31A0 87       ADD    A,A          ;
31A1 0C       INC    C            ;
31A2 09       ADD    HL,BC        ;
31A3 0603     LD     B,#03        ;
31A5 00       NOP                 ;
31A6 B0       OR     B            ;
31A7 31B431   LD     SP,$31B4     ;
31AA B8       CP     B            ;
31AB 31CE31   LD     SP,$31CE     ;
31AE D9       EXX                 ;
31AF 313E12   LD     SP,$123E     ;
31B2 1806     JR     $31BA        ;
31B4 3E0C     LD     A,#0C        ;
31B6 1802     JR     $31BA        ;
31B8 3E06     LD     A,#06        ;
31BA 21378A   LD     HL,$8A37     ;
31BD 113D8A   LD     DE,$8A3D     ;
31C0 010600   LD     BC,$0006     ;
31C3 EDB8     LDDR                ;
31C5 11378A   LD     DE,$8A37     ;
31C8 4F       LD     C,A          ;
31C9 EDB8     LDDR                ;
31CB C3D931   JP     $31D9        ;
31CE 113D8A   LD     DE,$8A3D     ;
31D1 21378A   LD     HL,$8A37     ;
31D4 010600   LD     BC,$0006     ;
31D7 EDB8     LDDR                ;
31D9 3A118A   LD     A,($8A11)    ;
31DC 3D       DEC    A            ;
31DD 21ED31   LD     HL,$31ED     ;
31E0 CF       RST    08H          ;
31E1 5E       LD     E,(HL)       ;
31E2 23       INC    HL           ;
31E3 56       LD     D,(HL)       ;
31E4 2A008A   LD     HL,($8A00)   ;
31E7 010600   LD     BC,$0006     ;
31EA EDB8     LDDR                ;
31EC C9       RET                 ;
31ED 25       DEC    H            ;
31EE 8A       ADC    A,D          ;
31EF 2B       DEC    HL           ;
31F0 8A       ADC    A,D          ;
31F1 318A37   LD     SP,$378A     ;
31F4 8A       ADC    A,D          ;
31F5 3D       DEC    A            ;
31F6 8A       ADC    A,D          ;
31F7 2A008A   LD     HL,($8A00)   ;
31FA 0606     LD     B,#06        ;
31FC 1A       LD     A,(DE)       ;
31FD FE24     CP     #24          ;
31FF 280D     JR     Z,$320E      ;
3201 7E       LD     A,(HL)       ;
3202 FE24     CP     #24          ;
3204 C8       RET    Z            ;
3205 1A       LD     A,(DE)       ;
3206 BE       CP     (HL)         ;
3207 C0       RET    NZ           ;
3208 2D       DEC    L            ;
3209 1D       DEC    E            ;
320A 10F0     DJNZ   $31FC        ;
320C AF       XOR    A            ;
320D C9       RET                 ;
320E BE       CP     (HL)         ;
320F 28F7     JR     Z,$3208      ;
3211 AF       XOR    A            ;
3212 18F2     JR     $3206        ;
3214 214533   LD     HL,$3345     ;
3217 CD2833   CALL   $3328        ;
321A CD2833   CALL   $3328        ;
321D 21B432   LD     HL,$32B4     ;
3220 CD1B33   CALL   $331B        ;
3223 0601     LD     B,#01        ;
3225 CD3132   CALL   $3231        ;
3228 CD3132   CALL   $3231        ;
322B CD3132   CALL   $3231        ;
322E CD3132   CALL   $3231        ;
3231 78       LD     A,B          ;
3232 3D       DEC    A            ;
3233 87       ADD    A,A          ;
3234 87       ADD    A,A          ;
3235 87       ADD    A,A          ;
3236 21C532   LD     HL,$32C5     ;
3239 D7       RST    10H          ;
323A 5E       LD     E,(HL)       ;
323B 23       INC    HL           ;
323C 56       LD     D,(HL)       ;
323D 23       INC    HL           ;
323E 78       LD     A,B          ;
323F 12       LD     (DE),A       ;
3240 CD7332   CALL   $3273        ;
3243 CD7032   CALL   $3270        ;
3246 CD7032   CALL   $3270        ;
3249 CD7332   CALL   $3273        ;
324C CD7332   CALL   $3273        ;
324F 7E       LD     A,(HL)       ;
3250 23       INC    HL           ;
3251 4E       LD     C,(HL)       ;
3252 23       INC    HL           ;
3253 E5       PUSH   HL           ;
3254 61       LD     H,C          ;
3255 6F       LD     L,A          ;
3256 CD7532   CALL   $3275        ;
3259 7B       LD     A,E          ;
325A D6C0     SUB    #C0          ;
325C 5F       LD     E,A          ;
325D 3001     JR     NZ,$3260     ;
325F 15       DEC    D            ;
3260 E1       POP    HL           ;
3261 7E       LD     A,(HL)       ;
3262 23       INC    HL           ;
3263 66       LD     H,(HL)       ;
3264 6F       LD     L,A          ;
3265 CD7032   CALL   $3270        ;
3268 CD7032   CALL   $3270        ;
326B CD7032   CALL   $3270        ;
326E 04       INC    B            ;
326F C9       RET                 ;
3270 7E       LD     A,(HL)       ;
3271 12       LD     (DE),A       ;
3272 23       INC    HL           ;
3273 E7       RST    20H          ;
3274 C9       RET                 ;

3275 0E06     LD     C,#06        ;
3277 7E       LD     A,(HL)       ;
3278 12       LD     (DE),A       ;
3279 2B       DEC    HL           ;
327A E7       RST    20H          ;
327B 0D       DEC    C            ;
327C 20F9     JR     NZ,$3277     ;
327E C9       RET                 ;

327F 24       INC    H            ; #
3280 83       ADD    A,E          ; #
3281 15       DEC    D            ; #
3282 04       INC    B            ; #
3283 0E17     LD     C,#17        ; #
3285 1D       DEC    E            ; #
3286 0E1B     LD     C,#1B        ; #
3288 24       INC    H            ; #
3289 22181E   LD     ($1E18),HL   ; #
328C 1B       DEC    DE           ; #
328D 24       INC    H            ; #
328E 12       LD     (DE),A       ; #
328F 17       RLA                 ; #
3290 12       LD     (DE),A       ; #
3291 1D       DEC    E            ; #
3292 12       LD     (DE),A       ; #
3293 0A       LD     A,(BC)       ; #
3294 15       DEC    D            ; #
3295 1C       INC    E            ; #
3296 24       INC    H            ; #
3297 2C       INC    L            ; #
3298 E7       RST    20H          ; #
3299 82       ADD    A,D          ; #
329A 101C     DJNZ   $32B8        ; #
329C 0C       INC    C            ; #
329D 181B     JR     $32BA        ; #
329F 0E24     LD     C,#24        ; #
32A1 24       INC    H            ; #
32A2 24       INC    H            ; #
32A3 24       INC    H            ; #
32A4 24       INC    H            ; #
32A5 24       INC    H            ; #
32A6 24       INC    H            ; #
32A7 17       RLA                 ; #
32A8 0A       LD     A,(BC)       ; #
32A9 160E     LD     D,#0E        ; #
32AB 50       LD     D,B          ; #
32AC 82       ADD    A,D          ; #
32AD 05       DEC    B            ; #
32AE 04       INC    B            ; #
32AF 1D       DEC    E            ; #
32B0 1819     JR     $32CB        ; #
32B2 24       INC    H            ; #
32B3 05       DEC    B            ; #
32B4 92       SUB    D            ; #
32B5 82       ADD    A,D          ; #
32B6 0E1C     LD     C,#1C        ; #
32B8 0C       INC    C            ; #
32B9 181B     JR     $32D6        ; #
32BB 0E24     LD     C,#24        ; #
32BD 24       INC    H            ; #
32BE 24       INC    H            ; #
32BF 24       INC    H            ; #
32C0 24       INC    H            ; #
32C1 17       RLA                 ; #
32C2 0A       LD     A,(BC)       ; #
32C3 160E     LD     D,#0E        ; #
32C5 54       LD     D,H          ; #
32C6 83       ADD    A,E          ; #
32C7 1C       INC    E            ; #
32C8 1D       DEC    E            ; #
32C9 25       DEC    H            ; #
32CA 8A       ADC    A,D          ; #
32CB 3E8A     LD     A,#8A        ; #
32CD 56       LD     D,(HL)       ; #
32CE 83       ADD    A,E          ; #
32CF 17       RLA                 ; #
32D0 0D       DEC    C            ; #
32D1 2B       DEC    HL           ; #
32D2 8A       ADC    A,D          ; #
32D3 41       LD     B,C          ; #
32D4 8A       ADC    A,D          ; #
32D5 58       LD     E,B          ; #
32D6 83       ADD    A,E          ; #
32D7 1B       DEC    DE           ; #
32D8 0D       DEC    C            ; #
32D9 318A44   LD     SP,$448A     ; #
32DC 8A       ADC    A,D          ; #
32DD 5A       LD     E,D          ; #
32DE 83       ADD    A,E          ; #
32DF 1D       DEC    E            ; #

32E0 11378A   LD     DE,$8A37     ;
32E3 47       LD     B,A          ;
32E4 8A       ADC    A,D          ;
32E5 5C       LD     E,H          ;
32E6 83       ADD    A,E          ;
32E7 1D       DEC    E            ;
32E8 113D8A   LD     DE,$8A3D     ;
32EB 4A       LD     C,D          ;
32EC 8A       ADC    A,D          ;
32ED 3AB599   LD     A,($99B5)    ;
32F0 FEA0     CP     #A0          ;
32F2 2807     JR     Z,$32FB      ;
32F4 47       LD     B,A          ;
32F5 3AB899   LD     A,($99B8)    ;
32F8 B8       CP     B            ;
32F9 3805     JR     C,$3300      ;
32FB 3AAE92   LD     A,($92AE)    ;
32FE A7       AND    A            ;
32FF C0       RET    NZ           ;
3300 E1       POP    HL           ;
3301 2681     LD     H,#81        ;
3303 3A108A   LD     A,($8A10)    ;
3306 6F       LD     L,A          ;
3307 ED5B048A LD     DE,($8A04)   ;
330B 13       INC    DE           ;
330C EDA0     LDI                 ;
330E 3EDF     LD     A,#DF        ;
3310 25       DEC    H            ;
3311 85       ADD    A,L          ;
3312 3001     JR     NZ,$3315     ;
3314 24       INC    H            ;
3315 6F       LD     L,A          ;
3316 CB44     BIT    0,H          ;
3318 20F2     JR     NZ,$330C     ;
331A C9       RET                 ;

; Display message on screen.
; HL points to descriptor as follows:
; LSB,MSB of screen
; Length of message
; Message bytes
331B 5E       LD     E,(HL)       ; LSB of screen start
331C 23       INC    HL           ; .
331D 56       LD     D,(HL)       ; MSB of screen start
331E 23       INC    HL           ; .
331F 46       LD     B,(HL)       ; Message length
3320 23       INC    HL           ; .
3321 7E       LD     A,(HL)       ; Get byte
3322 12       LD     (DE),A       ; To screen
3323 23       INC    HL           ; Next in buffer
3324 E7       RST    20H          ; (DE=DE-20) Next on screen
3325 10FA     DJNZ   $3321        ; Do all
3327 C9       RET                 ; Done

; Message going down? No ...
3328 5E       LD     E,(HL)       ;
3329 23       INC    HL           ;
332A 56       LD     D,(HL)       ;
332B 23       INC    HL           ;
332C 46       LD     B,(HL)       ;
332D 23       INC    HL           ;
332E 4E       LD     C,(HL)       ;
332F 23       INC    HL           ;
3330 EB       EX     DE,HL        ;
3331 1A       LD     A,(DE)       ; From the buffer ...
3332 77       LD     (HL),A       ; ... to the screen
3333 CBD4     SET    2,H          ;
3335 71       LD     (HL),C       ;
3336 CB94     RES    2,H          ;
3338 13       INC    DE           ;
3339 3EE0     LD     A,#E0        ;
333B 25       DEC    H            ;
333C 85       ADD    A,L          ;
333D 3001     JR     NZ,$3340     ;
333F 24       INC    H            ;
3340 6F       LD     L,A          ;
3341 10EE     DJNZ   $3331        ;
3343 EB       EX     DE,HL        ;
3344 C9       RET                 ;

3345 25       DEC    H            ; #
3346 83       ADD    A,E          ; #
3347 13       INC    DE           ; #
3348 02       LD     (BC),A       ; #
3349 1D       DEC    E            ; #
334A 110E24   LD     DE,$240E     ; #
334D 100A     DJNZ   $3359        ; #
334F 15       DEC    D            ; #
3350 0A       LD     A,(BC)       ; #
3351 0C       INC    C            ; #
3352 1D       DEC    E            ; #
3353 12       LD     (DE),A       ; #
3354 0C       INC    C            ; #
3355 24       INC    H            ; #
3356 110E1B   LD     DE,$1B0E     ; #
3359 180E     JR     $3369        ; #
335B 1C       INC    E            ; #
335C CC820C   CALL   Z,$0C82      ; #
335F 04       INC    B            ; #
3360 2626     LD     H,#26        ; #
3362 24       INC    H            ; #
3363 0B       DEC    BC           ; #
3364 0E1C     LD     C,#1C        ; #
3366 1D       DEC    E            ; #
3367 24       INC    H            ; #
3368 05       DEC    B            ; #
3369 24       INC    H            ; #
336A 2626     LD     H,#26        ; #

; Initialization comes here
336C AF       XOR    A            ; Zero
336D 322368   LD     ($6823),A    ; Halt CPUs 2 and 3
3370 3C       INC    A            ; Enable ...
3371 322268   LD     ($6822),A    ; ... NMI CPU 3
3374 F3       DI                  ; Disable local interrupt handling
3375 323068   LD     ($6830),A    ; Watchdog reset
3378 060A     LD     B,#0A        ;
337A D9       EXX                 ;
337B 110080   LD     DE,$8000     ;
337E 210000   LD     HL,$0000     ;
3381 010004   LD     BC,$0400     ;
3384 7D       LD     A,L          ;
3385 AC       XOR    H            ;
3386 2F       CPL                 ;
3387 87       ADD    A,A          ;
3388 87       ADD    A,A          ;
3389 ED6A     ADC    HL,HL        ;
338B 7D       LD     A,L          ;
338C 323068   LD     ($6830),A    ; Watchdog reset
338F 12       LD     (DE),A       ;
3390 13       INC    DE           ;
3391 0B       DEC    BC           ;
3392 78       LD     A,B          ;
3393 B1       OR     C            ;
3394 20EE     JR     NZ,$3384     ;
3396 110080   LD     DE,$8000     ;
3399 210000   LD     HL,$0000     ;
339C 010004   LD     BC,$0400     ;
339F 7D       LD     A,L          ;
33A0 AC       XOR    H            ;
33A1 2F       CPL                 ;
33A2 87       ADD    A,A          ;
33A3 87       ADD    A,A          ;
33A4 ED6A     ADC    HL,HL        ;
33A6 1A       LD     A,(DE)       ;
33A7 AD       XOR    L            ;
33A8 C2C034   JP     NZ,$34C0     ;
33AB 13       INC    DE           ;
33AC 323068   LD     ($6830),A    ; Watchdog
33AF 0B       DEC    BC           ;
33B0 78       LD     A,B          ;
33B1 B1       OR     C            ;
33B2 20EB     JR     NZ,$339F     ;
33B4 110080   LD     DE,$8000     ;
33B7 215555   LD     HL,$5555     ;
33BA 010004   LD     BC,$0400     ;
33BD 7D       LD     A,L          ;
33BE AC       XOR    H            ;
33BF 2F       CPL                 ;
33C0 87       ADD    A,A          ;
33C1 87       ADD    A,A          ;
33C2 ED6A     ADC    HL,HL        ;
33C4 7D       LD     A,L          ;
33C5 323068   LD     ($6830),A    ; Watchdog
33C8 12       LD     (DE),A       ;
33C9 13       INC    DE           ;
33CA 0B       DEC    BC           ;
33CB 78       LD     A,B          ;
33CC B1       OR     C            ;
33CD 20EE     JR     NZ,$33BD     ;
33CF 110080   LD     DE,$8000     ;
33D2 215555   LD     HL,$5555     ;
33D5 010004   LD     BC,$0400     ;
33D8 7D       LD     A,L          ;
33D9 AC       XOR    H            ;
33DA 2F       CPL                 ;
33DB 87       ADD    A,A          ;
33DC 87       ADD    A,A          ;
33DD ED6A     ADC    HL,HL        ;
33DF 1A       LD     A,(DE)       ;
33E0 AD       XOR    L            ;
33E1 C2C034   JP     NZ,$34C0     ;
33E4 13       INC    DE           ;
33E5 323068   LD     ($6830),A    ; Watchdog
33E8 0B       DEC    BC           ;
33E9 78       LD     A,B          ;
33EA B1       OR     C            ;
33EB 20EB     JR     NZ,$33D8     ;
33ED 110080   LD     DE,$8000     ;
33F0 21AAAA   LD     HL,$AAAA     ;
33F3 010004   LD     BC,$0400     ;
33F6 7D       LD     A,L          ;
33F7 AC       XOR    H            ;
33F8 2F       CPL                 ;
33F9 87       ADD    A,A          ;
33FA 87       ADD    A,A          ;
33FB ED6A     ADC    HL,HL        ;
33FD 7D       LD     A,L          ;
33FE 323068   LD     ($6830),A    ; Watchdog
3401 12       LD     (DE),A       ;
3402 13       INC    DE           ;
3403 0B       DEC    BC           ;
3404 78       LD     A,B          ;
3405 B1       OR     C            ;
3406 20EE     JR     NZ,$33F6     ;
3408 110080   LD     DE,$8000     ;
340B 21AAAA   LD     HL,$AAAA     ;
340E 010004   LD     BC,$0400     ;
3411 7D       LD     A,L          ;
3412 AC       XOR    H            ;
3413 2F       CPL                 ;
3414 87       ADD    A,A          ;
3415 87       ADD    A,A          ;
3416 ED6A     ADC    HL,HL        ;
3418 1A       LD     A,(DE)       ;
3419 AD       XOR    L            ;
341A C2C034   JP     NZ,$34C0     ;
341D 13       INC    DE           ;
341E 323068   LD     ($6830),A    ; Watchdog
3421 0B       DEC    BC           ;
3422 78       LD     A,B          ;
3423 B1       OR     C            ;
3424 20EB     JR     NZ,$3411     ;
3426 D9       EXX                 ;
3427 05       DEC    B            ;
3428 C27A33   JP     NZ,$337A     ;
342B 310084   LD     SP,$8400     ;
342E 110084   LD     DE,$8400     ;
3431 CD7F34   CALL   $347F        ;
3434 110088   LD     DE,$8800     ;
3437 CD7F34   CALL   $347F        ;
343A 110090   LD     DE,$9000     ;
343D CD7F34   CALL   $347F        ;
3440 21E099   LD     HL,$99E0     ;
3443 110090   LD     DE,$9000     ;
3446 012000   LD     BC,$0020     ;
3449 EDB0     LDIR                ;
344B 110098   LD     DE,$9800     ;
344E CD7F34   CALL   $347F        ;
3451 210090   LD     HL,$9000     ;
3454 11E099   LD     DE,$99E0     ;
3457 012000   LD     BC,$0020     ;
345A EDB0     LDIR                ;
345C 31008B   LD     SP,$8B00     ;
345F 110080   LD     DE,$8000     ; Start of RAM
3462 CD7F34   CALL   $347F        ;
3465 CD5839   CALL   $3958        ; Set RAM and screen
3468 21813B   LD     HL,$3B81     ; RAM Report message
346B CD1B33   CALL   $331B        ; Print RAM report
346E 323068   LD     ($6830),A    ; Watchdog
3471 CD3C3A   CALL   $3A3C        ;
3474 3E07     LD     A,#07        ;
3476 322090   LD     ($9020),A    ;
3479 CD7239   CALL   $3972        ;
347C C35035   JP     $3550        ; Continue with ROM checks
347F 061E     LD     B,#1E        ;
3481 210000   LD     HL,$0000     ;
3484 C5       PUSH   BC           ;
3485 CD8C34   CALL   $348C        ;
3488 C1       POP    BC           ;
3489 10F9     DJNZ   $3484        ;
348B C9       RET                 ;

348C D5       PUSH   DE           ;
348D E5       PUSH   HL           ;
348E 010004   LD     BC,$0400     ;
3491 7D       LD     A,L          ;
3492 AC       XOR    H            ;
3493 2F       CPL                 ;
3494 87       ADD    A,A          ;
3495 87       ADD    A,A          ;
3496 ED6A     ADC    HL,HL        ;
3498 7D       LD     A,L          ;
3499 323068   LD     ($6830),A    ; Watchdog
349C 12       LD     (DE),A       ;
349D 13       INC    DE           ;
349E 0B       DEC    BC           ;
349F 78       LD     A,B          ;
34A0 B1       OR     C            ;
34A1 20EE     JR     NZ,$3491     ;
34A3 E1       POP    HL           ;
34A4 D1       POP    DE           ;
34A5 D5       PUSH   DE           ;
34A6 010004   LD     BC,$0400     ;
34A9 7D       LD     A,L          ;
34AA AC       XOR    H            ;
34AB 2F       CPL                 ;
34AC 87       ADD    A,A          ;
34AD 87       ADD    A,A          ;
34AE ED6A     ADC    HL,HL        ;
34B0 1A       LD     A,(DE)       ;
34B1 AD       XOR    L            ;
34B2 C2C034   JP     NZ,$34C0     ;
34B5 13       INC    DE           ;
34B6 323068   LD     ($6830),A    ; Watchdog
34B9 0B       DEC    BC           ;
34BA 78       LD     A,B          ;
34BB B1       OR     C            ;
34BC 20EB     JR     NZ,$34A9     ;
34BE D1       POP    DE           ;
34BF C9       RET                 ;
34C0 47       LD     B,A          ;
34C1 7A       LD     A,D          ;
34C2 1F       RRA                 ;
34C3 1F       RRA                 ;
34C4 E607     AND    #07          ;
34C6 FE04     CP     #04          ;
34C8 3801     JR     C,$34CB      ;
34CA 3D       DEC    A            ;
34CB FE05     CP     #05          ;
34CD 3801     JR     C,$34D0      ;
34CF 3D       DEC    A            ;
34D0 5F       LD     E,A          ;
34D1 78       LD     A,B          ;
34D2 1615     LD     D,#15        ;
34D4 E60F     AND    #0F          ;
34D6 2002     JR     NZ,$34DA     ;
34D8 1611     LD     D,#11        ;
34DA 323068   LD     ($6830),A    ; Watchdog
34DD D9       EXX                 ;
34DE 210080   LD     HL,$8000     ;
34E1 110180   LD     DE,$8001     ;
34E4 010004   LD     BC,$0400     ;
34E7 3624     LD     (HL),#24     ;
34E9 EDB0     LDIR                ;
34EB 3600     LD     (HL),#00     ;
34ED 01FF03   LD     BC,$03FF     ;
34F0 EDB0     LDIR                ;
34F2 323068   LD     ($6830),A    ;
34F5 D9       EXX                 ;
34F6 21E282   LD     HL,$82E2     ;
34F9 361B     LD     (HL),#1B     ;
34FB 3EE0     LD     A,#E0        ;
34FD 25       DEC    H            ;
34FE D7       RST    10H          ;
34FF 360A     LD     (HL),#0A     ;
3501 3EE0     LD     A,#E0        ;
3503 25       DEC    H            ;
3504 D7       RST    10H          ;
3505 3616     LD     (HL),#16     ;
3507 3EA0     LD     A,#A0        ;
3509 25       DEC    H            ;
350A D7       RST    10H          ;
350B 73       LD     (HL),E       ;
350C 3EE0     LD     A,#E0        ;
350E 25       DEC    H            ;
350F D7       RST    10H          ;
3510 72       LD     (HL),D       ;
3511 218093   LD     HL,$9380     ;
3514 0680     LD     B,#80        ;
3516 36F1     LD     (HL),#F1     ;
3518 23       INC    HL           ;
3519 10FB     DJNZ   $3516        ;
351B 323068   LD     ($6830),A    ; Infinte ...
351E C31B35   JP     $351B        ; ... loop

3521 E5       PUSH   HL           ;
3522 EB       EX     DE,HL        ;
3523 1610     LD     D,#10        ;
3525 AF       XOR    A            ;
3526 47       LD     B,A          ;
3527 86       ADD    A,(HL)       ;
3528 323068   LD     ($6830),A    ; Watchdog
352B 23       INC    HL           ;
352C 10F9     DJNZ   $3527        ;
352E 15       DEC    D            ;
352F 20F6     JR     NZ,$3527     ;
3531 EB       EX     DE,HL        ;
3532 E1       POP    HL           ;
3533 B9       CP     C            ;
3534 C8       RET    Z            ;

; Display ROM error report
3535 218B3B   LD     HL,$3B8B     ; "ROM  OK"
3538 CD1B33   CALL   $331B        ; Print message
353B 114482   LD     DE,$8244     ; Screen Location for error code
353E 210291   LD     HL,$9102     ; Get error code
3541 AF       XOR    A            ; 0 to start
3542 ED6F     RLD                 ; Rotate BCD first digit into A
3544 12       LD     (DE),A       ; Store the first code
3545 E7       RST    20H          ; Next spot
3546 AF       XOR    A            ; 0 to start
3547 ED6F     RLD                 ; Rotate BSC second digit into A
3549 12       LD     (DE),A       ; Store to screen
354A 323068   LD     ($6830),A    ; Watchdog
354D C34A35   JP     $354A        ; Infinite loop if ROMs are wrong

; Make sure all ROMs are OK
3550 210091   LD     HL,$9100     ; Start CPU2 ...
3553 3600     LD     (HL),#00     ; ... checksum
3555 23       INC    HL           ; Start CPU3 ...
3556 3600     LD     (HL),#00     ; ... checksum
3558 23       INC    HL           ; 9102 = ...
3559 3601     LD     (HL),#01     ; ... 01
355B AF       XOR    A            ;
355C 327092   LD     ($9270),A    ;
355F 3C       INC    A            ;
3560 322368   LD     ($6823),A    ; Watchdog
3563 110000   LD     DE,$0000     ; ROM area ...
3566 0E00     LD     C,#00        ;
3568 CD2135   CALL   $3521        ; Checksum ROM 1
356B 34       INC    (HL)         ;
356C 0E00     LD     C,#00        ;
356E CD2135   CALL   $3521        ; Checksum ROM 2
3571 34       INC    (HL)         ;
3572 0E00     LD     C,#00        ;
3574 CD2135   CALL   $3521        ; Checksum ROM 3
3577 34       INC    (HL)         ;
3578 0E00     LD     C,#00        ;
357A CD2135   CALL   $3521        ; Checksum ROM 4
357D 36FF     LD     (HL),#FF     ;
357F 3A0091   LD     A,($9100)    ; CPU2 ROMs
3582 323068   LD     ($6830),A    ; Watchdog reset
3585 A7       AND    A            ; Wait ...
3586 28F7     JR     Z,$357F      ; ... For CPU 2
3588 3C       INC    A            ; OK?
3589 2807     JR     Z,$3592      ; Yes ... move on to CPU3
358B 3D       DEC    A            ; Restore error
358C 320291   LD     ($9102),A    ; Save error code
358F C33535   JP     $3535        ; Print ROM/RAM report
3592 3A0191   LD     A,($9101)    ; CPU3 ROMs
3595 323068   LD     ($6830),A    ; Watchdog reset
3598 A7       AND    A            ; Wait ...
3599 28F7     JR     Z,$3592      ; ... For CPU 3
359B 3C       INC    A            ; OK?
359C 2817     JR     Z,$35B5      ; Yes ... continue
359E 3D       DEC    A            ; Restore error
359F 320291   LD     ($9102),A    ; Save error code
35A2 C33535   JP     $3535        ; Print ROM/RAM report

; Looks like data
35A5 05       DEC    B            ; #
35A6 05       DEC    B            ; #
35A7 05       DEC    B            ; #
35A8 05       DEC    B            ; #
35A9 3040     JR     NZ,$35EB     ; #
35AB 00       NOP                 ; #
35AC 02       LD     (BC),A       ; #
35AD DF       RST    18H          ; #
35AE 40       LD     B,B          ; #
35AF 3030     JR     NZ,$35E1     ; #
35B1 03       INC    BC           ; #
35B2 DF       RST    18H          ; #
35B3 1020     DJNZ   $35D5        ; #

35B5 218B3B   LD     HL,$3B8B     ; Print some report
35B8 CD1B33   CALL   $331B        ;
35BB CDF437   CALL   $37F4        ;
35BE 210091   LD     HL,$9100     ; Acknowledge ...
35C1 0603     LD     B,#03        ; ... slave ...
35C3 3600     LD     (HL),#00     ; ... checksum ...
35C5 23       INC    HL           ; ...
35C6 10FB     DJNZ   $35C3        ; ... Reports
35C8 3E20     LD     A,#20        ;
35CA 320090   LD     ($9000),A    ;
35CD 21A535   LD     HL,$35A5     ;
35D0 110070   LD     DE,$7000     ;
35D3 010400   LD     BC,$0004     ;
35D6 D9       EXX                 ;
35D7 3EA1     LD     A,#A1        ; What command?
35D9 320071   LD     ($7100),A    ; Custom IO
35DC 323068   LD     ($6830),A    ; Watchdog
35DF CDEC37   CALL   $37EC        ;
35E2 AF       XOR    A            ;
35E3 323068   LD     ($6830),A    ; Watchdog
35E6 32A092   LD     ($92A0),A    ;
35E9 3AA092   LD     A,($92A0)    ;
35EC FE02     CP     #02          ;
35EE 20F9     JR     NZ,$35E9     ;
35F0 21A935   LD     HL,$35A9     ;
35F3 110070   LD     DE,$7000     ;
35F6 010C00   LD     BC,$000C     ;
35F9 D9       EXX                 ;
35FA 3EA8     LD     A,#A8        ; IO Command
35FC 320071   LD     ($7100),A    ;
35FF 323068   LD     ($6830),A    ;
3602 CDEC37   CALL   $37EC        ;
3605 323068   LD     ($6830),A    ;
3608 ED56     IM     1            ;
360A 212068   LD     HL,$6820     ;
360D 3600     LD     (HL),#00     ;
360F 3601     LD     (HL),#01     ;
3611 FB       EI                  ;
3612 CDF239   CALL   $39F2        ;
3615 AF       XOR    A            ;
3616 32A092   LD     ($92A0),A    ;
3619 3AA092   LD     A,($92A0)    ;
361C E608     AND    #08          ;
361E 28F9     JR     Z,$3619      ;
3620 3AA092   LD     A,($92A0)    ;
3623 4F       LD     C,A          ;
3624 3AA092   LD     A,($92A0)    ;
3627 B9       CP     C            ;
3628 28FA     JR     Z,$3624      ;
362A 211691   LD     HL,$9116     ;
362D 111791   LD     DE,$9117     ;
3630 010700   LD     BC,$0007     ;
3633 EDB8     LDDR                ;
3635 EB       EX     DE,HL        ;
3636 11B599   LD     DE,$99B5     ;
3639 1A       LD     A,(DE)       ;
363A CB7F     BIT    7,A          ;
363C C2BA36   JP     NZ,$36BA     ;
363F 77       LD     (HL),A       ;
3640 23       INC    HL           ;
3641 B6       OR     (HL)         ;
3642 23       INC    HL           ;
3643 2F       CPL                 ;
3644 A6       AND    (HL)         ;
3645 23       INC    HL           ;
3646 A6       AND    (HL)         ;
3647 77       LD     (HL),A       ;
3648 47       LD     B,A          ;
3649 23       INC    HL           ;
364A 13       INC    DE           ;
364B 1A       LD     A,(DE)       ;
364C 77       LD     (HL),A       ;
364D 23       INC    HL           ;
364E B6       OR     (HL)         ;
364F 23       INC    HL           ;
3650 2F       CPL                 ;
3651 A6       AND    (HL)         ;
3652 23       INC    HL           ;
3653 A6       AND    (HL)         ;
3654 77       LD     (HL),A       ;
3655 6F       LD     L,A          ;
3656 60       LD     H,B          ;
3657 0610     LD     B,#10        ;
3659 29       ADD    HL,HL        ;
365A DCD639   CALL   C,$39D6      ;
365D 10FA     DJNZ   $3659        ;
365F CDF437   CALL   $37F4        ;
3662 2A7292   LD     HL,($9272)   ;
3665 7C       LD     A,H          ;
3666 B5       OR     L            ;
3667 2809     JR     Z,$3672      ;
3669 2B       DEC    HL           ;
366A 227292   LD     ($9272),HL   ;
366D 7C       LD     A,H          ;
366E B5       OR     L            ;
366F CCBB39   CALL   Z,$39BB      ;
3672 3A1091   LD     A,($9110)    ;
3675 1F       RRA                 ;
3676 3007     JR     NZ,$367F     ;
3678 AF       XOR    A            ;
3679 327192   LD     ($9271),A    ;
367C C32036   JP     $3620        ;
367F 3A1791   LD     A,($9117)    ;
3682 E60F     AND    #0F          ;
3684 CA2036   JP     Z,$3620      ;
3687 4F       LD     C,A          ;
3688 218237   LD     HL,$3782     ;
368B 117192   LD     DE,$9271     ;
368E 1A       LD     A,(DE)       ;
368F D7       RST    10H          ;
3690 7E       LD     A,(HL)       ;
3691 B9       CP     C            ;
3692 2805     JR     Z,$3699      ;
3694 AF       XOR    A            ;
3695 12       LD     (DE),A       ;
3696 C32036   JP     $3620        ;
3699 EB       EX     DE,HL        ;
369A 34       INC    (HL)         ;
369B 13       INC    DE           ;
369C 1A       LD     A,(DE)       ;
369D 3C       INC    A            ;
369E C22036   JP     NZ,$3620     ;
36A1 CD5839   CALL   $3958        ;
36A4 CD7239   CALL   $3972        ;
36A7 119837   LD     DE,$3798     ;
36AA 214280   LD     HL,$8042     ;
36AD 061C     LD     B,#1C        ;
36AF CD6637   CALL   $3766        ;
36B2 10FB     DJNZ   $36AF        ;
36B4 3AB599   LD     A,($99B5)    ;
36B7 87       ADD    A,A          ;
36B8 30FA     JR     NZ,$36B4     ;
36BA AF       XOR    A            ;
36BB 32A092   LD     ($92A0),A    ;
36BE 3AA092   LD     A,($92A0)    ;
36C1 FE08     CP     #08          ;
36C3 38F9     JR     C,$36BE      ;
36C5 3AB599   LD     A,($99B5)    ;
36C8 87       ADD    A,A          ;
36C9 D22036   JP     NC,$3620     ;
36CC CD7239   CALL   $3972        ;
36CF 210080   LD     HL,$8000     ;
36D2 0610     LD     B,#10        ;
36D4 3628     LD     (HL),#28     ;
36D6 23       INC    HL           ;
36D7 3627     LD     (HL),#27     ;
36D9 23       INC    HL           ;
36DA 10F8     DJNZ   $36D4        ;
36DC 0610     LD     B,#10        ;
36DE 362D     LD     (HL),#2D     ;
36E0 23       INC    HL           ;
36E1 362B     LD     (HL),#2B     ;
36E3 23       INC    HL           ;
36E4 10F8     DJNZ   $36DE        ;
36E6 0610     LD     B,#10        ;
36E8 3628     LD     (HL),#28     ;
36EA 23       INC    HL           ;
36EB 362D     LD     (HL),#2D     ;
36ED 23       INC    HL           ;
36EE 10F8     DJNZ   $36E8        ;
36F0 0610     LD     B,#10        ;
36F2 3627     LD     (HL),#27     ;
36F4 23       INC    HL           ;
36F5 362B     LD     (HL),#2B     ;
36F7 23       INC    HL           ;
36F8 10F8     DJNZ   $36F2        ;
36FA EB       EX     DE,HL        ;
36FB 214080   LD     HL,$8040     ;
36FE 014003   LD     BC,$0340     ;
3701 EDB0     LDIR                ;
3703 210080   LD     HL,$8000     ;
3706 014000   LD     BC,$0040     ;
3709 EDB0     LDIR                ;
370B AF       XOR    A            ;
370C 32A092   LD     ($92A0),A    ;
370F 3AA092   LD     A,($92A0)    ;
3712 87       ADD    A,A          ;
3713 30FA     JR     NZ,$370F     ;
3715 3AB599   LD     A,($99B5)    ;
3718 87       ADD    A,A          ;
3719 30FA     JR     NZ,$3715     ;
371B F3       DI                  ;
371C CDEC37   CALL   $37EC        ;
371F 3EFE     LD     A,#FE        ;
3721 32A092   LD     ($92A0),A    ;
3724 3AA092   LD     A,($92A0)    ;
3727 A7       AND    A            ;
3728 20FA     JR     NZ,$3724     ;
372A 323068   LD     ($6830),A    ;
372D 218092   LD     HL,$9280     ;
3730 110070   LD     DE,$7000     ;
3733 010800   LD     BC,$0008     ;
3736 D9       EXX                 ;
3737 3EE1     LD     A,#E1        ;
3739 320071   LD     ($7100),A    ; IO Processor
373C CDEC37   CALL   $37EC        ;
373F 210070   LD     HL,$7000     ;
3742 118892   LD     DE,$9288     ;
3745 010300   LD     BC,$0003     ;
3748 D9       EXX                 ;
3749 3EB1     LD     A,#B1        ;
374B 320071   LD     ($7100),A    ;
374E CDEC37   CALL   $37EC        ;
3751 3A8892   LD     A,($9288)    ;
3754 FEA1     CP     #A1          ;
3756 30D5     JR     NZ,$372D     ;
3758 E60F     AND    #0F          ;
375A FE0A     CP     #0A          ;
375C 30CF     JR     NZ,$372D     ;
375E FB       EI                  ;
375F AF       XOR    A            ;
3760 321082   LD     ($8210),A    ;
3763 C3D302   JP     $02D3        ;
3766 CD7437   CALL   $3774        ;
3769 CD7437   CALL   $3774        ;
376C CD7437   CALL   $3774        ;
376F 3E05     LD     A,#05        ;
3771 C31000   JP     $0010        ;
3774 1A       LD     A,(DE)       ;
3775 0E08     LD     C,#08        ;
3777 87       ADD    A,A          ;
3778 3001     JR     NZ,$377B     ;
377A 34       INC    (HL)         ;
377B 23       INC    HL           ;
377C 0D       DEC    C            ;
377D 20F8     JR     NZ,$3777     ;
377F 13       INC    DE           ;
3780 23       INC    HL           ;
3781 C9       RET                 ;

3782 02       LD     (BC),A       ; #
3783 02       LD     (BC),A       ; #
3784 02       LD     (BC),A       ; #
3785 02       LD     (BC),A       ; #
3786 02       LD     (BC),A       ; #
3787 08       EX     AF,A'F'      ; #
3788 08       EX     AF,A'F'      ; #
3789 08       EX     AF,A'F'      ; #
378A 08       EX     AF,A'F'      ; #
378B 08       EX     AF,A'F'      ; #
378C 08       EX     AF,A'F'      ; #
378D 02       LD     (BC),A       ; #
378E 02       LD     (BC),A       ; #
378F 02       LD     (BC),A       ; #
3790 08       EX     AF,A'F'      ; #
3791 08       EX     AF,A'F'      ; #
3792 08       EX     AF,A'F'      ; #
3793 08       EX     AF,A'F'      ; #
3794 08       EX     AF,A'F'      ; #
3795 08       EX     AF,A'F'      ; #
3796 08       EX     AF,A'F'      ; #
3797 FF       RST    38H          ; #
3798 013E00   LD     BC,$003E     ; #
379B 7F       LD     A,A          ; #
379C 41       LD     B,C          ; #
379D 00       NOP                 ; #
379E 214100   LD     HL,$0041     ; #
37A1 00       NOP                 ; #
37A2 41       LD     B,C          ; #
37A3 00       NOP                 ; #
37A4 363E     LD     (HL),#3E     ; #
37A6 00       NOP                 ; #
37A7 49       LD     C,C          ; #
37A8 00       NOP                 ; #
37A9 03       INC    BC           ; #
37AA 49       LD     C,C          ; #
37AB 220349   LD     ($4903),HL   ; #
37AE 41       LD     B,C          ; #
37AF 00       NOP                 ; #
37B0 3641     LD     (HL),#41     ; #
37B2 3E00     LD     A,#00        ; #
37B4 3E41     LD     A,#41        ; #
37B6 3E00     LD     A,#00        ; #
37B8 41       LD     B,C          ; #
37B9 49       LD     C,C          ; #
37BA 7F       LD     A,A          ; #
37BB 41       LD     B,C          ; #
37BC 49       LD     C,C          ; #
37BD 207F     JR     NZ,$383E     ; #
37BF 49       LD     C,C          ; #
37C0 1800     JR     $37C2        ; #
37C2 322040   LD     ($4020),A    ; #
37C5 00       NOP                 ; #
37C6 7F       LD     A,A          ; #
37C7 40       LD     B,B          ; #
37C8 01007F   LD     BC,$7F00     ; #
37CB 7F       LD     A,A          ; #
37CC 3F       CCF                 ; #
37CD 40       LD     B,B          ; #
37CE 214440   LD     HL,$4044     ; #
37D1 00       NOP                 ; #
37D2 44       LD     B,H          ; #
37D3 00       NOP                 ; #
37D4 3C       INC    A            ; #
37D5 44       LD     B,H          ; #
37D6 01423F   LD     BC,$3F42     ; #
37D9 018100   LD     BC,$0081     ; #
37DC 01A57F   LD     BC,$7FA5     ; #
37DF 01A504   LD     BC,$04A5     ; #
37E2 7F       LD     A,A          ; #
37E3 99       SBC    A,C          ; #
37E4 08       EX     AF,A'F'      ; #
37E5 00       NOP                 ; #
37E6 42       LD     B,D          ; #
37E7 1000     DJNZ   $37E9        ; #
37E9 3C       INC    A            ; #
37EA 7F       LD     A,A          ; #
37EB 00       NOP                 ; #

; Wait for IO processor to complete
37EC 3A0071   LD     A,($7100)    ; Status of IO processor.
37EF FE10     CP     #10          ; Wait ...
37F1 C8       RET    Z            ; ... for ...
37F2 18F8     JR     $37EC        ; ... status = 10

37F4 3A0768   LD     A,($6807)    ;
37F7 1F       RRA                 ;
37F8 3C       INC    A            ;
37F9 E601     AND    #01          ;
37FB 328399   LD     ($9983),A    ;
37FE 21CC3A   LD     HL,$3ACC     ;
3801 CF       RST    08H          ;
3802 CD613A   CALL   $3A61        ;
3805 3AB599   LD     A,($99B5)    ;
3808 0E00     LD     C,#00        ;
380A E60C     AND    #0C          ;
380C 2001     JR     NZ,$380F     ;
380E 0C       INC    C            ;
380F 79       LD     A,C          ;
3810 3207A0   LD     ($A007),A    ;
3813 210168   LD     HL,$6801     ;
3816 7E       LD     A,(HL)       ;
3817 1F       RRA                 ;
3818 E601     AND    #01          ;
381A 4F       LD     C,A          ;
381B 23       INC    HL           ;
381C 7E       LD     A,(HL)       ;
381D E602     AND    #02          ;
381F B1       OR     C            ;
3820 328499   LD     ($9984),A    ;
3823 21683A   LD     HL,$3A68     ;
3826 D7       RST    10H          ;
3827 112C82   LD     DE,$822C     ;
382A EDA0     LDI                 ;
382C 21E43A   LD     HL,$3AE4     ;
382F CD1B33   CALL   $331B        ;
3832 210668   LD     HL,$6806     ;
3835 7E       LD     A,(HL)       ;
3836 23       INC    HL           ;
3837 4E       LD     C,(HL)       ;
3838 CB19     RR     C            ;
383A 8F       ADC    A,A          ;
383B E603     AND    #03          ;
383D 3C       INC    A            ;
383E 328299   LD     ($9982),A    ;
3841 3C       INC    A            ;
3842 32EA82   LD     ($82EA),A    ;
3845 21EB3A   LD     HL,$3AEB     ;
3848 CD1B33   CALL   $331B        ;
384B 21C43A   LD     HL,$3AC4     ;
384E 118092   LD     DE,$9280     ;
3851 010800   LD     BC,$0008     ;
3854 EDB0     LDIR                ;
3856 210068   LD     HL,$6800     ;
3859 0603     LD     B,#03        ;
385B AF       XOR    A            ;
385C 4E       LD     C,(HL)       ;
385D CB19     RR     C            ;
385F 8F       ADC    A,A          ;
3860 23       INC    HL           ;
3861 10F9     DJNZ   $385C        ;
3863 E607     AND    #07          ;
3865 2834     JR     Z,$389B      ;
3867 3D       DEC    A            ;
3868 87       ADD    A,A          ;
3869 87       ADD    A,A          ;
386A 87       ADD    A,A          ;
386B 216C3A   LD     HL,$3A6C     ;
386E D7       RST    10H          ;
386F 118192   LD     DE,$9281     ;
3872 010400   LD     BC,$0004     ;
3875 EDB0     LDIR                ;
3877 11E882   LD     DE,$82E8     ;
387A EDA0     LDI                 ;
387C 112882   LD     DE,$8228     ;
387F EDA0     LDI                 ;
3881 11E881   LD     DE,$81E8     ;
3884 EDA0     LDI                 ;
3886 11E880   LD     DE,$80E8     ;
3889 EDA0     LDI                 ;
388B 3E24     LD     A,#24        ;
388D 320882   LD     ($8208),A    ;
3890 21F63A   LD     HL,$3AF6     ;
3893 CD1B33   CALL   $331B        ;
3896 CD1B33   CALL   $331B        ;
3899 1810     JR     $38AB        ;
389B 218192   LD     HL,$9281     ;
389E 0604     LD     B,#04        ;
38A0 3600     LD     (HL),#00     ;
38A2 23       INC    HL           ;
38A3 10FB     DJNZ   $38A0        ;
38A5 21073B   LD     HL,$3B07     ;
38A8 CD1B33   CALL   $331B        ;
38AB 210368   LD     HL,$6803     ;
38AE 0603     LD     B,#03        ;
38B0 AF       XOR    A            ;
38B1 4E       LD     C,(HL)       ;
38B2 CB19     RR     C            ;
38B4 8F       ADC    A,A          ;
38B5 23       INC    HL           ;
38B6 10F9     DJNZ   $38B1        ;
38B8 E607     AND    #07          ;
38BA CA2D39   JP     Z,$392D      ;
38BD 4F       LD     C,A          ;
38BE 3A8299   LD     A,($9982)    ;
38C1 E604     AND    #04          ;
38C3 87       ADD    A,A          ;
38C4 81       ADD    A,C          ;
38C5 87       ADD    A,A          ;
38C6 21A43A   LD     HL,$3AA4     ;
38C9 D7       RST    10H          ;
38CA 118099   LD     DE,$9980     ;
38CD EDA0     LDI                 ;
38CF EDA0     LDI                 ;
38D1 2B       DEC    HL           ;
38D2 0E01     LD     C,#01        ;
38D4 CDDA38   CALL   $38DA        ;
38D7 2B       DEC    HL           ;
38D8 0E00     LD     C,#00        ;
38DA 7E       LD     A,(HL)       ;
38DB 3C       INC    A            ;
38DC CA3B39   JP     Z,$393B      ;
38DF 79       LD     A,C          ;
38E0 87       ADD    A,A          ;
38E1 E5       PUSH   HL           ;
38E2 211D3B   LD     HL,$3B1D     ;
38E5 D7       RST    10H          ;
38E6 7E       LD     A,(HL)       ;
38E7 23       INC    HL           ;
38E8 66       LD     H,(HL)       ;
38E9 6F       LD     L,A          ;
38EA C5       PUSH   BC           ;
38EB CD1B33   CALL   $331B        ;
38EE CD1B33   CALL   $331B        ;
38F1 C1       POP    BC           ;
38F2 E1       POP    HL           ;
38F3 7E       LD     A,(HL)       ;
38F4 E67F     AND    #7F          ;
38F6 EB       EX     DE,HL        ;
38F7 21F081   LD     HL,$81F0     ;
38FA 41       LD     B,C          ;
38FB 1002     DJNZ   $38FF        ;
38FD 23       INC    HL           ;
38FE 23       INC    HL           ;
38FF CD1E39   CALL   $391E        ;
3902 EB       EX     DE,HL        ;
3903 0D       DEC    C            ;
3904 C0       RET    NZ           ;
3905 EB       EX     DE,HL        ;
3906 1A       LD     A,(DE)       ;
3907 CB7F     BIT    7,A          ;
3909 C24939   JP     NZ,$3949     ;
390C 21F481   LD     HL,$81F4     ;
390F CD1E39   CALL   $391E        ;
3912 D5       PUSH   DE           ;
3913 21503B   LD     HL,$3B50     ;
3916 CD1B33   CALL   $331B        ;
3919 CD1B33   CALL   $331B        ;
391C E1       POP    HL           ;
391D C9       RET                 ;
391E FE0A     CP     #0A          ;
3920 0624     LD     B,#24        ;
3922 3804     JR     C,$3928      ;
3924 0601     LD     B,#01        ;
3926 D60A     SUB    #0A          ;
3928 70       ???                 ;
3929 CBAD     RES    5,L          ;
392B 77       LD     (HL),A       ;
392C C9       RET                 ;
392D 21673B   LD     HL,$3B67     ; BONUS Report message
3930 CD1B33   CALL   $331B        ; Print message
3933 218099   LD     HL,$9980     ;
3936 36FF     LD     (HL),#FF     ;
3938 23       INC    HL           ;
3939 36FF     LD     (HL),#FF     ;
393B EB       EX     DE,HL        ;
393C 213283   LD     HL,$8332     ;
393F 0616     LD     B,#16        ;
3941 3624     LD     (HL),#24     ;
3943 3EE0     LD     A,#E0        ;
3945 25       DEC    H            ;
3946 D7       RST    10H          ;
3947 10F8     DJNZ   $3941        ;
3949 213483   LD     HL,$8334     ;
394C 0616     LD     B,#16        ;
394E 3624     LD     (HL),#24     ;
3950 3EE0     LD     A,#E0        ;
3952 25       DEC    H            ;
3953 D7       RST    10H          ;
3954 10F8     DJNZ   $394E        ;
3956 EB       EX     DE,HL        ;
3957 C9       RET                 ;

; Clear screen
3958 210080   LD     HL,$8000     ; Start of RAM
395B 110180   LD     DE,$8001     ; RAM +1
395E 010004   LD     BC,$0400     ; 400 bytes of screen
3961 3624     LD     (HL),#24     ; Space character
3963 EDB0     LDIR                ; Clear screen
3965 3603     LD     (HL),#03     ; Next pattern 03
3967 01FF03   LD     BC,$03FF     ; 3FF bytes
396A EDB0     LDIR                ; 
396C 3E07     LD     A,#07        ;
396E 32BE99   LD     ($99BE),A    ;
3971 C9       RET                 ;

3972 218093   LD     HL,$9380     ;
3975 0680     LD     B,#80        ;
3977 36F1     LD     (HL),#F1     ;
3979 23       INC    HL           ;
397A 10FB     DJNZ   $3977        ;
397C C9       RET                 ;

397D 21E099   LD     HL,$99E0     ;
3980 115E83   LD     DE,$835E     ;
3983 0E02     LD     C,#02        ;
3985 0601     LD     B,#01        ;
3987 CD9739   CALL   $3997        ;
398A 0603     LD     B,#03        ;
398C CD9739   CALL   $3997        ;
398F 0602     LD     B,#02        ;
3991 CD9739   CALL   $3997        ;
3994 23       INC    HL           ;
3995 0601     LD     B,#01        ;
3997 CDAA39   CALL   $39AA        ;
399A CDA039   CALL   $39A0        ;
399D 10FB     DJNZ   $399A        ;
399F C9       RET                 ;
39A0 3E99     LD     A,#99        ;
39A2 96       SUB    (HL)         ;
39A3 1F       RRA                 ;
39A4 1F       RRA                 ;
39A5 1F       RRA                 ;
39A6 1F       RRA                 ;
39A7 CDAE39   CALL   $39AE        ;
39AA 3E99     LD     A,#99        ;
39AC 96       SUB    (HL)         ;
39AD 23       INC    HL           ;
39AE E60F     AND    #0F          ;
39B0 12       LD     (DE),A       ;
39B1 E7       RST    20H          ;
39B2 0D       DEC    C            ;
39B3 C0       RET    NZ           ;
39B4 3E2A     LD     A,#2A        ;
39B6 0E04     LD     C,#04        ;
39B8 12       LD     (DE),A       ;
39B9 E7       RST    20H          ;
39BA C9       RET                 ;
39BB 215E83   LD     HL,$835E     ;
39BE 0617     LD     B,#17        ;
39C0 11E0FF   LD     DE,$FFE0     ;
39C3 3624     LD     (HL),#24     ;
39C5 19       ADD    HL,DE        ;
39C6 10FB     DJNZ   $39C3        ;
39C8 C9       RET                 ;

39C9 E5       PUSH   HL           ;
39CA CD7D39   CALL   $397D        ;
39CD 218403   LD     HL,$0384     ;
39D0 227292   LD     ($9272),HL   ;
39D3 E1       POP    HL           ;
39D4 C1       POP    BC           ;
39D5 C9       RET                 ;

39D6 C5       PUSH   BC           ;
39D7 78       LD     A,B          ;
39D8 FE0F     CP     #0F          ;
39DA 28ED     JR     Z,$39C9      ;
39DC FE02     CP     #02          ;
39DE 2815     JR     Z,$39F5      ;
39E0 FE04     CP     #04          ;
39E2 203D     JR     NZ,$3A21     ;
39E4 3A7092   LD     A,($9270)    ;
39E7 D601     SUB    #01          ;
39E9 3002     JR     NZ,$39ED     ;
39EB 3E11     LD     A,#11        ;
39ED 327092   LD     ($9270),A    ;
39F0 180A     JR     $39FC        ;
39F2 C5       PUSH   BC           ;
39F3 1807     JR     $39FC        ;
39F5 3A7092   LD     A,($9270)    ;
39F8 3C       INC    A            ;
39F9 327092   LD     ($9270),A    ;
39FC 3A7092   LD     A,($9270)    ;
39FF FE12     CP     #12          ;
3A01 3801     JR     C,$3A04      ;
3A03 AF       XOR    A            ;
3A04 327092   LD     ($9270),A    ;
3A07 E5       PUSH   HL           ;
3A08 0E00     LD     C,#00        ;
3A0A FE0A     CP     #0A          ;
3A0C 3803     JR     C,$3A11      ;
3A0E 0C       INC    C            ;
3A0F D60A     SUB    #0A          ;
3A11 212E82   LD     HL,$822E     ;
3A14 71       LD     (HL),C       ;
3A15 2E0E     LD     L,#0E        ;
3A17 77       LD     (HL),A       ;
3A18 21473A   LD     HL,$3A47     ;
3A1B CD1B33   CALL   $331B        ;
3A1E E1       POP    HL           ;
3A1F C1       POP    BC           ;
3A20 C9       RET                 ;

3A21 3A7092   LD     A,($9270)    ;
3A24 FE12     CP     #12          ;
3A26 3801     JR     C,$3A29      ;
3A28 AF       XOR    A            ;
3A29 327092   LD     ($9270),A    ;
3A2C EB       EX     DE,HL        ;
3A2D CD3C3A   CALL   $3A3C        ;
3A30 214F3A   LD     HL,$3A4F     ;
3A33 D7       RST    10H          ;
3A34 6E       LD     L,(HL)       ;
3A35 269A     LD     H,#9A        ;
3A37 3601     LD     (HL),#01     ;
3A39 EB       EX     DE,HL        ;
3A3A C1       POP    BC           ;
3A3B C9       RET                 ;

3A3C 21A09A   LD     HL,$9AA0     ;
3A3F 0640     LD     B,#40        ;
3A41 3600     LD     (HL),#00     ;
3A43 23       INC    HL           ;
3A44 10FB     DJNZ   $3A41        ;
3A46 C9       RET                 ;

3A47 EE82     XOR    #82          ; #
3A49 05       DEC    B            ; #
3A4A 1C       INC    E            ; #
3A4B 181E     JR     $3A6B        ; #
3A4D 17       RLA                 ; #
3A4E 0D       DEC    C            ; #
3A4F A1       AND    C            ; #
3A50 A2       AND    D            ; #
3A51 A3       AND    E            ; #
3A52 A4       AND    H            ; #
3A53 A7       AND    A            ; #
3A54 AA       XOR    D            ; #
3A55 AB       XOR    E            ; #
3A56 AC       XOR    H            ; #
3A57 AD       XOR    L            ; #
3A58 AE       XOR    (HL)         ; #
3A59 AF       XOR    A            ; #
3A5A B0       OR     B            ; #
3A5B B2       OR     D            ; #
3A5C B3       OR     E            ; #
3A5D B4       OR     H            ; #
3A5E B5       OR     L            ; #
3A5F B6       OR     (HL)         ; #
3A60 B9       CP     C            ; #

3A61 7E       LD     A,(HL)       ;
3A62 23       INC    HL           ;
3A63 66       LD     H,(HL)       ;

3A64 6F       LD     L,A          ;
3A65 C31B33   JP     $331B        ; Print message on screen

3A68 0B       DEC    BC           ; #
3A69 0C       INC    C            ; #
3A6A 0D       DEC    C            ; #
3A6B 0A       LD     A,(BC)       ; #
3A6C 04       INC    B            ; #
3A6D 010401   LD     BC,$0104     ; #
3A70 04       INC    B            ; #
3A71 1C       INC    E            ; #
3A72 012403   LD     BC,$0324     ; #
3A75 010301   LD     BC,$0103     ; #
3A78 03       INC    BC           ; #
3A79 1C       INC    E            ; #
3A7A 012402   LD     BC,$0224     ; #
3A7D 010201   LD     BC,$0102     ; #
3A80 02       LD     (BC),A       ; #
3A81 1C       INC    E            ; #
3A82 012402   LD     BC,$0224     ; #
3A85 03       INC    BC           ; #
3A86 02       LD     (BC),A       ; #
3A87 03       INC    BC           ; #
3A88 02       LD     (BC),A       ; #
3A89 1C       INC    E            ; #
3A8A 03       INC    BC           ; #
3A8B 1C       INC    E            ; #
3A8C 010301   LD     BC,$0103     ; #
3A8F 03       INC    BC           ; #
3A90 012403   LD     BC,$0324     ; #
3A93 1C       INC    E            ; #
3A94 010201   LD     BC,$0102     ; #
3A97 02       LD     (BC),A       ; #
3A98 012402   LD     BC,$0224     ; #
3A9B 1C       INC    E            ; #
3A9C 010101   LD     BC,$0101     ; #
3A9F 010124   LD     BC,$2401     ; #
3AA2 0124FF   LD     BC,$FF24     ; #
3AA5 FF       RST    38H          ; #
3AA6 02       LD     (BC),A       ; #
3AA7 0602     LD     B,#02        ; #
3AA9 07       RLCA                ; #
3AAA 02       LD     (BC),A       ; #
3AAB 08       EX     AF,A'F'      ; #
3AAC 03       INC    BC           ; #
3AAD 0A       LD     A,(BC)       ; #
3AAE 03       INC    BC           ; #
3AAF 0C       INC    C            ; #
3AB0 02       LD     (BC),A       ; #
3AB1 86       ADD    A,(HL)       ; #
3AB2 03       INC    BC           ; #
3AB3 88       ADC    A,B          ; #
3AB4 FF       RST    38H          ; #
3AB5 FF       RST    38H          ; #
3AB6 03       INC    BC           ; #
3AB7 0A       LD     A,(BC)       ; #
3AB8 03       INC    BC           ; #
3AB9 0C       INC    C            ; #
3ABA 03       INC    BC           ; #
3ABB 0F       RRCA                ; #
3ABC 03       INC    BC           ; #
3ABD 8A       ADC    A,D          ; #
3ABE 03       INC    BC           ; #
3ABF 8C       ADC    A,H          ; #
3AC0 03       INC    BC           ; #
3AC1 8F       ADC    A,A          ; #
3AC2 03       INC    BC           ; #
3AC3 FF       RST    38H          ; #
3AC4 010101   LD     BC,$0101     ; #
3AC7 010102   LD     BC,$0201     ; #
3ACA 03       INC    BC           ; #
3ACB 00       NOP                 ; #
3ACC D0       RET    NC           ; #
3ACD 3ADA3A   LD     A,($3ADA)    ; #
3AD0 E682     AND    #82          ; #
3AD2 07       RLCA                ; #
3AD3 1E19     LD     E,#19        ; #
3AD5 1B       DEC    DE           ; #
3AD6 12       LD     (DE),A       ; #
3AD7 1011     DJNZ   $3AEA        ; #
3AD9 1D       DEC    E            ; #
3ADA E682     AND    #82          ; #
3ADC 07       RLCA                ; #
3ADD 1D       DEC    E            ; #
3ADE 0A       LD     A,(BC)       ; #
3ADF 0B       DEC    BC           ; #
3AE0 15       DEC    D            ; #
3AE1 0E24     LD     C,#24        ; #
3AE3 24       INC    H            ; #
3AE4 EC8204   CALL   PE,$0482     ; #
3AE7 1B       DEC    DE           ; #
3AE8 0A       LD     A,(BC)       ; #
3AE9 17       RLA                 ; #
3AEA 14       INC    D            ; #
3AEB AA       XOR    D            ; #
3AEC 82       ADD    A,D          ; #
3AED 08       EX     AF,A'F'      ; #
3AEE 0F       RRCA                ; #
3AEF 12       LD     (DE),A       ; #
3AF0 1011     DJNZ   $3B03        ; #
3AF2 1D       DEC    E            ; #
3AF3 0E1B     LD     C,#1B        ; #
3AF5 1C       INC    E            ; #
3AF6 C8       RET    Z            ; #
3AF7 82       ADD    A,D          ; #
3AF8 05       DEC    B            ; #
3AF9 24       INC    H            ; #
3AFA 0C       INC    C            ; #
3AFB 1812     JR     $3B0F        ; #
3AFD 17       RLA                 ; #
3AFE A8       XOR    B            ; #
3AFF 81       ADD    A,C          ; #
3B00 060C     LD     B,#0C        ; #
3B02 1B       DEC    DE           ; #
3B03 0E0D     LD     C,#0D        ; #
3B05 12       LD     (DE),A       ; #
3B06 1D       DEC    E            ; #
3B07 E8       RET    PE           ; #
3B08 82       ADD    A,D          ; #
3B09 12       LD     (DE),A       ; #
3B0A 0F       RRCA                ; #
3B0B 1B       DEC    DE           ; #
3B0C 0E0E     LD     C,#0E        ; #
3B0E 24       INC    H            ; #
3B0F 19       ADD    HL,DE        ; #
3B10 15       DEC    D            ; #
3B11 0A       LD     A,(BC)       ; #
3B12 222424   LD     ($2424),HL   ; #
3B15 24       INC    H            ; #
3B16 24       INC    H            ; #
3B17 24       INC    H            ; #
3B18 24       INC    H            ; #
3B19 24       INC    H            ; #
3B1A 24       INC    H            ; #
3B1B 24       INC    H            ; #
3B1C 24       INC    H            ; #
3B1D 213B39   LD     HL,$393B     ; #
3B20 3B       DEC    SP           ; #
3B21 3083     JR     NZ,$3AA6     ; #
3B23 0A       LD     A,(BC)       ; #
3B24 011C1D   LD     BC,$1D1C     ; #
3B27 24       INC    H            ; #
3B28 0B       DEC    BC           ; #
3B29 1817     JR     $3B42        ; #
3B2B 1E1C     LD     E,#1C        ; #
3B2D 24       INC    H            ; #
3B2E B0       OR     B            ; #
3B2F 81       ADD    A,C          ; #
3B30 08       EX     AF,A'F'      ; #
3B31 00       NOP                 ; #
3B32 00       NOP                 ; #
3B33 00       NOP                 ; #
3B34 00       NOP                 ; #
3B35 24       INC    H            ; #
3B36 19       ADD    HL,DE        ; #
3B37 1D       DEC    E            ; #
3B38 1C       INC    E            ; #
3B39 328309   LD     ($0983),A    ; #
3B3C 02       LD     (BC),A       ; #
3B3D 17       RLA                 ; #
3B3E 0D       DEC    C            ; #
3B3F 24       INC    H            ; #
3B40 0B       DEC    BC           ; #
3B41 1817     JR     $3B5A        ; #
3B43 1E1C     LD     E,#1C        ; #
3B45 B2       OR     D            ; #
3B46 81       ADD    A,C          ; #
3B47 08       8
3B48 00       0
3B49 00       0
3B4A 00       0
3B4B 00       0
3B4C 24       <space>
3B4D 19       P
3B4E 1D       T
3B4F 1C       S
3B50 34       
3B51 83       
3B52 09       
3B53 0A       A
3B54 17       N
3B55 0D       D
3B56 24        <space>
3B57 0E1F     EV
3B59 0E1B     ER
3B5B 22       Y

; Points display
35BC B48108  ; Start on screen at 81B4 - 8 bytes
3B5F 00       0
3B60 00       0
3B61 00       0
3B62 00       0
3B63 24       <space>
3B64 19       P
3B65 1D       T
3B66 1C       S

; Bonus report
3B67 308316  ; Start on screen at 8330 - 0x16 bytes
3B6A 0B      B
3B6B 1817    ON
3B6D 1E1C    US
3B6F 24      <space>
3B70 17      N
3B71 181D    OT
3B73 111217  HIN
3B76 1024    G
3B78 24      
3B79 24      
3B7A 24      
3B7B 24      <spaces for digits>
3B7C 24      
3B7D 24      
3B7E 24      
3B7F 24      
3B80 24       

; RAM Report
3B81 E28207  ; Start on screen at 8207 - 7 bytes  
3B84 1B      R 
3B85 0A      A 
3B86 1624    M <space> 
3B88 24      <space> 
3B89 1814    OK 

; ROM Report
3B8B E48207   ; Start on screen at 82E4 - 7 bytes
3B8E 1B       R
3B8F 1816     OM
3B91 24       <space>
3B92 24       <space>
3B93 1814     OK

; FFs from here on
