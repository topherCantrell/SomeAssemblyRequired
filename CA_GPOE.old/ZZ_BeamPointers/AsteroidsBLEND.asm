                                           ;  processor 6502
                                           
                                           ;  build-command Blend Asteroids.asm AstoidsBLEND.asm
                                           ;  build-command tasm -b -65 AsteroidsBLEND.asm Asteroids.bin
                                           
                                           ;  ROM order: 035145.02 + 035144.02 + 035143.02
                                           ;  2K each starting at 6800
                                           
                                           ;  ---------------------------------------------------------------------------
                                           ;  File Name   : C:\asteroid\CombinedRoms.bin
                                           ;  Format      : Binary File
                                           ;  Base Address: 0000h Range: 6800h - 8000h Loaded length: 1800h
                                           
                                           ;  Processor:        M6502
                                           ;  Target assembler: SVENSON ELECTRONICS 6502/65C02 ASSEMBLER - V.1.0 - MAY, 1988
                                           ;  ---------------------------------------------------------------------------
                                           ;  NOTE: This code is property of Atari Inc. All requests from said company to remove
                                           ;  This code from public display will be honored
                                           ;  Disassembly By Lonnie Howell     displacer1@excite.com
                                           ;  Updated 10/8/04
                                           
                                           ;  Memory map:
                                           ;  $18              Current Player (0 = Player 1, 1 = Player 2)
                                           ;  $1C              Number Of Players In Current Game
                                           ;  $1D - $30        High Score Table (Scores) 2 Byte Format In Decimal
                                           ;                   Byte 1 Tens, Byte 2 Thousands (In Decimal)
                                           ;  $34 - $51        High Score Table (Initials) 3 Byte Format
                                           ;  $52              Player 1 Score Tens (In Decimal)
                                           ;  $53              Player 1 Score Thousands (In Decimal)
                                           ;  $54              Player 2 Score Tens (In Decimal)
                                           ;  $55              Player 2 Score Thousands (In Decimal)
                                           ;  $56              Number Of Starting Ships Per Game
                                           ;  $57              Current Number Of Ships, Player 1
                                           ;  $58              Current Number Of Ships, Player 2
                                           ;  $59              Hyperspace Flag: 1 = Successful Hyperspace Jump
                                           ;                                    #$80 = Unsuccessful Hyperspace Jump (DEATH)
                                           ;                                    0 = Hyperspace Not Currently Active
                                           ;  $5C              Fast Timer
                                           ;  $5D              Slow Timer
                                           ;  $61              Ship Direction
                                           ;  $62              Direction Shot Is Fired From Saucer (?)
                                           ;  $68              TIMER: Length Of Time To Play Bonus Ship Sound
                                           ;  $6A              Fire Sound Flag For Player
                                           ;  $6B              Fire Sound Flag For Saucer
                                           ;  $6C              Current Volume & Frequency Settings For THUMP Sound
                                           ;  $6D              TIMER: Time THUMP Sound Remains On
                                           ;  $6E              TIMER: Time THUMP Sound Remains Off (Speeds Up As Game Progresses)
                                           ;  $6F              Bitmap Of Changes To Be Made In $3200
                                           ;  $70              Current Number Of Credits
                                           ;  $71              Bitmap Of DIP Switches 4-8
                                           ;  $72              Slam Switch Flag
                                           ;  $73              Total Coins (After Multiplyers) To Be Converted To Credits
                                           
                                           ;  $0100 - $01FF    Stack Space
                                           ;  $021B            Player Flag, 1 = Player Alive And Active, #$A0+ = Player Currently Exploding
                                           ;  $021C            Saucer Flag, 0 = No Saucer, 1 = Small Saucer, 2 = Large Saucer
                                           ;  $021D - $021E    Countdown Timers For Saucer Shots
                                           ;  $021F - $0222    Countdown Timers For Ship Shots
                                           ;  $02F7            Countdown Timer For Saucer, At 0, Saucer Appears
                                           ;                   Possibly A Dual Purpous Timer
                                           ;  $02F8            Starting Value For Timer @ $02F7
                                           ;  $02FC            Starting Value For Timer @ $6E
                                           ;  $0200 - 02FF     Player 1 RAM
                                           ;  $0300 - 03FF     Player 2 RAM
                                           
                                           ;  $2001            3 KHz
                                           ;  $2002            HALT
                                           ;  $2003            Hyperspace Switch
                                           ;  $2004            Fire Switch
                                           ;  $2005            Diag. Step
                                           ;  $2006            Slam Switch
                                           ;  $2007            Self Test Switch
                                           
                                           ;  $2400            Left Coin Switch
                                           ;  $2401            Center Coin Switch
                                           ;  $2402            Right Coin Switch
                                           ;  $2403            1 Player Start Switch
                                           ;  $2404            2 Player Start Switch
                                           ;  $2405            Thrust Switch
                                           ;  $2406            Rotate Right Switch
                                           ;  $2407            Rotate Left Switch
                                           ;  $3200            Bit 1 = 2 Player Start Lamp
                                           ;                   Bit 2 = 1 Player Start Lamp
                                           ;                   Bit 3 = RAMSEL
                                           ;                   Bit 4 = Left Coin Counter
                                           ;                   Bit 5 = Center Coin Counter
                                           ;                   Bit 6 = Right Coin Counter
                                           
                                           
                                           
                 .ORG     $6800            ; OLine=91
                 JMP      loc_7CF3         ; OLine=92
                                           
loc_6803:                                  ; OLine=94
                                           
                 JSR      sub_6EFA         ; OLine=96  Reset Sound, Zero Out Sound Timers
                 JSR      sub_6ED8         ; OLine=97  Number Of Starting Ships To $56 And Zero
                                           ;  Out Players Scores *BUG*
loc_6809:                                  ; OLine=99
                 JSR      sub_7168         ; OLine=100 
                                           
loc_680C:                                  ; OLine=102
                                           
                 LDA      $2007            ; OLine=104  Self test switch
                                           
loc_680F:                                  ; OLine=106
                 BMI      loc_680F         ; OLine=107  Branch If Switch Is On
                 LSR      $5B              ; OLine=108 
                 BCC      loc_680C         ; OLine=109 
                                           
loc_6815:                                  ; OLine=111
                 LDA      $2002            ; OLine=112  HALT
                 BMI      loc_6815         ; OLine=113  Wait For State Machine To Finish
                 LDA      $4001            ; OLine=114 
                 EOR      #2               ; OLine=115 
                 STA      $4001            ; OLine=116 
                 STA      $3000            ; OLine=117  DMAGO
                 STA      $3400            ; OLine=118  Reset WatchDog
                 INC      $5C              ; OLine=119  Update Fast Timer
                 BNE      loc_682E         ; OLine=120 
                 INC      $5D              ; OLine=121  Update Slow Timer
                                           
loc_682E:                                  ; OLine=123
                 LDX      #$40             ; OLine=124 
                 AND      #2               ; OLine=125 
                 BNE      loc_6836         ; OLine=126 
                 LDX      #$44             ; OLine=127 
                                           
loc_6836:                                  ; OLine=129
                 LDA      #2               ; OLine=130 
                 STA      2                ; OLine=131 
                 STX      3                ; OLine=132 
                 JSR      sub_6885         ; OLine=133 
                 BCS      loc_6803         ; OLine=134 
                 JSR      sub_765C         ; OLine=135 
                 JSR      sub_6D90         ; OLine=136 
                 BPL      loc_6864         ; OLine=137 
                 JSR      sub_73C4         ; OLine=138 
                 BCS      loc_6864         ; OLine=139 
                 LDA      $5A              ; OLine=140 
                 BNE      loc_685E         ; OLine=141 
                 JSR      sub_6CD7         ; OLine=142 
                 JSR      sub_6E74         ; OLine=143 
                 JSR      sub_703F         ; OLine=144 
                 JSR      sub_6B93         ; OLine=145 
                                           
loc_685E:                                  ; OLine=147
                 JSR      sub_6F57         ; OLine=148 
                 JSR      sub_69F0         ; OLine=149 
                                           
loc_6864:                                  ; OLine=151
                                           
                 JSR      sub_724F         ; OLine=153 
                 JSR      sub_7555         ; OLine=154 
                 LDA      #$7F             ; OLine=155 
                 TAX                       ; OLine=156 
                 JSR      sub_7C03         ; OLine=157 
                 JSR      sub_77B5         ; OLine=158 
                 JSR      sub_7BC0         ; OLine=159 
                 LDA      $2FB             ; OLine=160 
                 BEQ      loc_687E         ; OLine=161 
                 DEC      $2FB             ; OLine=162 
                                           
loc_687E:                                  ; OLine=164
                 ORA      $2F6             ; OLine=165 
                 BNE      loc_680C         ; OLine=166 
                 BEQ      loc_6809         ; OLine=167 
                                           
                                           ;  ¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦ S U B R O U T I N E ¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦
                                           
                                           
sub_6885:                                  ; OLine=172
                 LDA      $1C              ; OLine=173  Number Of Players In Current Game
                 BEQ      loc_689D         ; OLine=174  None, Branch
                 LDA      $5A              ; OLine=175 
                 BNE      loc_6890         ; OLine=176 
                 JMP      loc_6960         ; OLine=177 
                                           ;  ---------------------------------------------------------------------------
                                           
loc_6890:                                  ; OLine=180
                 DEC      $5A              ; OLine=181 
                 JSR      sub_69E2         ; OLine=182 
                                           
loc_6895:                                  ; OLine=184
                 CLC                       ; OLine=185 
                 RTS                       ; OLine=186 
                                           ;  ---------------------------------------------------------------------------
                                           
loc_6897:                                  ; OLine=189
                 LDA      #2               ; OLine=190  Free Credits!
                 STA      $70              ; OLine=191  Can Only Play A 2 Player Game, So Only Need To Add 2
                 BNE      loc_68B0         ; OLine=192  Credits For Free Play
                                           
loc_689D:                                  ; OLine=194
                 LDA      $71              ; OLine=195  DIP Switch Settings Bitmap
                 AND      #3               ; OLine=196  Mask Off Settings For Switches 8 & 7
                 BEQ      loc_6897         ; OLine=197  Check For Free Play, Branch If Yes
                 CLC                       ; OLine=198 
                 ADC      #7               ; OLine=199  Determine Which Message To Display Based On DIP Settings
                 TAY                       ; OLine=200  Into Y For The Offset
                                           ;  Y = 8, "1 COIN 2 PLAYS"
                                           ;  Y = 9, "1 COIN 1 PLAY"
                                           ;  Y = A, "2 COINS 1 PLAY"
                 LDA      $32              ; OLine=204 
                 AND      $33              ; OLine=205 
                 BPL      loc_68B0         ; OLine=206 
                 JSR      sub_77F6         ; OLine=207  And Draw It To Screen
                                           
loc_68B0:                                  ; OLine=209
                                           
                 LDY      $70              ; OLine=211  Current Number Of Credits
                 BEQ      loc_6895         ; OLine=212  No Credits, Branch
                 LDX      #1               ; OLine=213  Assume 1 Player Game 
                 LDA      $2403            ; OLine=214  1 Player start button
                 BMI      loc_68DE         ; OLine=215  Branch If Pressed
                 CPY      #2               ; OLine=216  Enough Credits For A 2 Player Game?
                 BCC      loc_693B         ; OLine=217  No, Branch
                 LDA      $2404            ; OLine=218  2 Player start button
                 BPL      loc_693B         ; OLine=219  Branch if NOT pressed
                 LDA      $6F              ; OLine=220  $3200 Bitmap
                 ORA      #4               ; OLine=221  Set Bit 3, RAMSEL (Swap In $0200 Memory)
                 STA      $6F              ; OLine=222  Update Bitmap
                 STA      $3200            ; OLine=223  And Make The Change
                 JSR      sub_6ED8         ; OLine=224 
                 JSR      sub_7168         ; OLine=225 
                 JSR      sub_71E8         ; OLine=226 
                 LDA      $56              ; OLine=227  Number Of Starting Ships
                 STA      $58              ; OLine=228  To Player 2 Current Ships
                 LDX      #2               ; OLine=229  2 Player Game
                 DEC      $70              ; OLine=230  Subtract Credit
                                           
loc_68DE:                                  ; OLine=232
                 STX      $1C              ; OLine=233  Flag Number Of Players In Current Game
                 DEC      $70              ; OLine=234  Subtract Credit
                 LDA      $6F              ; OLine=235  $3200 Bitmap
                 AND      #$F8             ; OLine=236 
                 EOR      $1C              ; OLine=237  Change Player Start Lamps For This Game
                 STA      $6F              ; OLine=238  Update Bitmap
                 STA      $3200            ; OLine=239  And Make The Change
                 JSR      sub_71E8         ; OLine=240 
                 LDA      #1               ; OLine=241 
                 STA      $2FA             ; OLine=242 
                 STA      $3FA             ; OLine=243 
                 LDA      #$92             ; OLine=244 
                 STA      $2F8             ; OLine=245 
                 STA      $3F8             ; OLine=246 
                 STA      $3F7             ; OLine=247 
                 STA      $2F7             ; OLine=248  Countdown Timer For When Saucer Appears
                 LDA      #$7F             ; OLine=249 
                 STA      $2FB             ; OLine=250 
                 STA      $3FB             ; OLine=251 
                 LDA      #5               ; OLine=252 
                 STA      $2FD             ; OLine=253 
                 STA      $3FD             ; OLine=254 
                 LDA      #$FF             ; OLine=255 
                 STA      $32              ; OLine=256 
                 STA      $33              ; OLine=257 
                 LDA      #$80             ; OLine=258 
                 STA      $5A              ; OLine=259 
                 ASL      A                ; OLine=260  Zero A, And Set Carry Flag
                 STA      $18              ; OLine=261  Current Player. New Game So Start With Player 1
                 STA      $19              ; OLine=262 
                 LDA      $56              ; OLine=263 
                 STA      $57              ; OLine=264 
                 LDA      #4               ; OLine=265 
                 STA      $6C              ; OLine=266 
                 STA      $6E              ; OLine=267 
                 LDA      #$30             ; OLine=268 
                 STA      $2FC             ; OLine=269  Starting Value For Timer @ $6E
                 STA      $3FC             ; OLine=270 
                 STA      $3E00            ; OLine=271 
                 RTS                       ; OLine=272  Noise Reset
                                           ;  ---------------------------------------------------------------------------
                                           
loc_693B:                                  ; OLine=275
                                           
                 LDA      $32              ; OLine=277 
                 AND      $32              ; OLine=278 
                 BPL      loc_694C         ; OLine=279 
                 LDA      $5C              ; OLine=280  Fast Timer
                 AND      #$20             ; OLine=281  Time To Draw Message To Screen?
                 BNE      loc_694C         ; OLine=282  No, Branch
                 LDY      #6               ; OLine=283  Offset For "PUSH START"
                 JSR      sub_77F6         ; OLine=284  And Draw It On Screen
                                           
loc_694C:                                  ; OLine=286
                                           
                 LDA      $5C              ; OLine=288  Fast Timer
                 AND      #$F              ; OLine=289  Time To Blink Player Start Lamp(s)?
                 BNE      loc_695E         ; OLine=290  No, Branch
                 LDA      #1               ; OLine=291 
                 CMP      $70              ; OLine=292  Current Number Of Credits
                 ADC      #1               ; OLine=293  Calculate Which Lamp(s) To Blink
                 EOR      #1               ; OLine=294 
                 EOR      $6F              ; OLine=295  Switch Their Status (On Or Off)
                 STA      $6F              ; OLine=296  Update Bitmap
                                           
loc_695E:                                  ; OLine=298
                 CLC                       ; OLine=299 
                 RTS                       ; OLine=300 
                                           ;  ---------------------------------------------------------------------------
                                           
loc_6960:                                  ; OLine=303
                 LDA      $5C              ; OLine=304  Fast Timer
                 AND      #$3F             ; OLine=305 
                 BNE      loc_6970         ; OLine=306 
                 LDA      $2FC             ; OLine=307  Starting Value For Timer @ $6E
                 CMP      #8               ; OLine=308  At The Lowest Value It Can Be?
                 BEQ      loc_6970         ; OLine=309  Yes, Branch
                 DEC      $2FC             ; OLine=310 
                                           
loc_6970:                                  ; OLine=312
                                           
                 LDX      $18              ; OLine=314  Current Player
                 LDA      $57,X            ; OLine=315  Number Of Ships For Current Player
                 BNE      loc_6992         ; OLine=316  Any Ships Left? Branch If Yes
                 LDA      $21F             ; OLine=317  Check If Current Player Has Any Shots Active
                 ORA      $220             ; OLine=318 
                 ORA      $221             ; OLine=319 
                 ORA      $222             ; OLine=320 
                 BNE      loc_6992         ; OLine=321  Still Have Active Shots, Branch
                 LDY      #7               ; OLine=322  Offset For "GAME OVER"
                 JSR      sub_77F6         ; OLine=323  And Draw It To Screen
                 LDA      $1C              ; OLine=324  Number Of Players In Current Game
                 CMP      #2               ; OLine=325  2 Player Game?
                 BCC      loc_6992         ; OLine=326  No, Branch
                 JSR      sub_69E2         ; OLine=327  Display On Screen Which Player's Game Is Over
                                           
loc_6992:                                  ; OLine=329
                                           
                 LDA      $21B             ; OLine=331 
                 BNE      loc_69CD         ; OLine=332 
                 LDA      $2FA             ; OLine=333 
                 CMP      #$80             ; OLine=334 
                 BNE      loc_69CD         ; OLine=335 
                 LDA      #$10             ; OLine=336 
                 STA      $2FA             ; OLine=337 
                 LDX      $1C              ; OLine=338  Number Of Players In Current Game
                 LDA      $57              ; OLine=339  Check If ANY Player Has ANY Ships Left
                 ORA      $58              ; OLine=340 
                 BEQ      loc_69CF         ; OLine=341  Branch If All Players Are Out Of Ships
                 JSR      sub_702D         ; OLine=342 
                 DEX                       ; OLine=343 
                 BEQ      loc_69CD         ; OLine=344  Will Branch If Only 1 Player Remaining In Game
                 LDA      #$80             ; OLine=345 
                 STA      $5A              ; OLine=346 
                 LDA      $18              ; OLine=347  Current Player
                 EOR      #1               ; OLine=348  Switch To Next Player
                 TAX                       ; OLine=349 
                 LDA      $57,X            ; OLine=350  Any Ships Left For This Player?
                 BEQ      loc_69CD         ; OLine=351  No, Branch
                 STX      $18              ; OLine=352  Flag Switch To Next Player
                 LDA      #4               ; OLine=353  And Switch RAM To Next Player
                 EOR      $6F              ; OLine=354  Bit 3, RAMSEL
                 STA      $6F              ; OLine=355  Update Bitmap
                 STA      $3200            ; OLine=356  Make The Switch 
                 TXA                       ; OLine=357 
                 ASL      A                ; OLine=358 
                 STA      $19              ; OLine=359 
                                           
loc_69CD:                                  ; OLine=361
                                           
                 CLC                       ; OLine=363 
                 RTS                       ; OLine=364 
                                           ;  ---------------------------------------------------------------------------
                                           
loc_69CF:                                  ; OLine=367
                 STX      $1A              ; OLine=368 
                 LDA      #$FF             ; OLine=369 
                 STA      $1C              ; OLine=370  Number Of Players In Current Game
                 JSR      sub_6EFA         ; OLine=371  Turn Off All Sounds, Zero Sound Timers
                 LDA      $6F              ; OLine=372  Bitmap Of $3200
                 AND      #$F8             ; OLine=373 
                 ORA      #3               ; OLine=374  Turn On Player 1 & 2 Start Lamps
                 STA      $6F              ; OLine=375  Update Bitmap
                 CLC                       ; OLine=376 
                 RTS                       ; OLine=377 
                                           ;  End of function sub_6885
                                           
                                           
                                           ;  ¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦ S U B R O U T I N E ¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦
                                           
                                           
sub_69E2:                                  ; OLine=384
                                           
                 LDY      #1               ; OLine=386  Offset For "PLAYER "
                 JSR      sub_77F6         ; OLine=387  And Draw It On Screen
                 LDY      $18              ; OLine=388  Current Player
                 INY                       ; OLine=389  Used To Draw Either "1" Or "2" After "PLAYER "
                 TYA                       ; OLine=390 
                 JSR      sub_7BD1         ; OLine=391  Draw It To Screen
                 RTS                       ; OLine=392
                                           ;  End of function sub_69E2
                                           
                                           ;  ---------------------------------------------------------------------------
                 .BYTE    $71              ; OLine=396
                                           
                                           ;  ¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦ S U B R O U T I N E ¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦
                                           
                                           
sub_69F0:                                  ; OLine=401
                 LDX      #7               ; OLine=402 
                                           
loc_69F2:                                  ; OLine=404
                 LDA      $21B,X           ; OLine=405  Check If Any Active Shot In This Slot
                 BEQ      loc_69F9         ; OLine=406  No, Branch
                 BPL      loc_69FD         ; OLine=407  Shot Still Active, Branch
                                           
loc_69F9:                                  ; OLine=409
                                           
                 DEX                       ; OLine=411 
                 BPL      loc_69F2         ; OLine=412 
                 RTS                       ; OLine=413 
                                           ;  ---------------------------------------------------------------------------
                                           
loc_69FD:                                  ; OLine=416
                 LDY      #$1C             ; OLine=417 
                 CPX      #4               ; OLine=418 
                 BCS      loc_6A0A         ; OLine=419 
                 DEY                       ; OLine=420 
                 TXA                       ; OLine=421
                 BNE      loc_6A0A         ; OLine=422
                                           
loc_6A07:                                  ; OLine=424
                                           
                 DEY                       ; OLine=426
                 BMI      loc_69F9         ; OLine=427 
                                           
loc_6A0A:                                  ; OLine=429
                                           
                 LDA      $200,Y           ; OLine=431 
                 BEQ      loc_6A07         ; OLine=432 
                 BMI      loc_6A07         ; OLine=433 
                 STA      $B               ; OLine=434 
                 LDA      $2AF,Y           ; OLine=435 
                 SEC                       ; OLine=436 
                 SBC      $2CA,X           ; OLine=437 
                 STA      8                ; OLine=438 
                 LDA      $269,Y           ; OLine=439 
                 SBC      $284,X           ; OLine=440 
                 LSR      A                ; OLine=441 
                 ROR      8                ; OLine=442 
                 ASL      A                ; OLine=443 
                 BEQ      loc_6A34         ; OLine=444 
                 BPL      loc_6A97         ; OLine=445 
                 EOR      #$FE             ; OLine=446 
                 BNE      loc_6A97         ; OLine=447 
                 LDA      8                ; OLine=448 
                 EOR      #$FF             ; OLine=449 
                 STA      8                ; OLine=450 
                                           
loc_6A34:                                  ; OLine=452
                 LDA      $2D2,Y           ; OLine=453 
                 SEC                       ; OLine=454 
                 SBC      $2ED,X           ; OLine=455 
                 STA      9                ; OLine=456 
                 LDA      $28C,Y           ; OLine=457 
                 SBC      $2A7,X           ; OLine=458 
                 LSR      A                ; OLine=459 
                 ROR      9                ; OLine=460 
                 ASL      A                ; OLine=461 
                 BEQ      loc_6A55         ; OLine=462 
                 BPL      loc_6A97         ; OLine=463 
                 EOR      #$FE             ; OLine=464 
                 BNE      loc_6A97         ; OLine=465 
                 LDA      9                ; OLine=466 
                 EOR      #$FF             ; OLine=467 
                 STA      9                ; OLine=468 
                                           
loc_6A55:                                  ; OLine=470
                 LDA      #$2A             ; OLine=471 
                 LSR      $B               ; OLine=472 
                 BCS      loc_6A63         ; OLine=473 
                 LDA      #$48             ; OLine=474 
                 LSR      $B               ; OLine=475 
                 BCS      loc_6A63         ; OLine=476 
                 LDA      #$84             ; OLine=477 
                                           
loc_6A63:                                  ; OLine=479
                                           
                 CPX      #1               ; OLine=481 
                 BCS      loc_6A69         ; OLine=482 
                 ADC      #$1C             ; OLine=483 
                                           
loc_6A69:                                  ; OLine=485
                 BNE      loc_6A77         ; OLine=486 
                 ADC      #$12             ; OLine=487 
                 LDX      $21C             ; OLine=488  Saucer Flag
                 DEX                       ; OLine=489 
                 BEQ      loc_6A75         ; OLine=490  Small Saucer, Branch
                 ADC      #$12             ; OLine=491 
                                           
loc_6A75:                                  ; OLine=493
                 LDX      #1               ; OLine=494 
                                           
loc_6A77:                                  ; OLine=496
                 CMP      8                ; OLine=497 
                 BCC      loc_6A97         ; OLine=498 
                 CMP      9                ; OLine=499 
                 BCC      loc_6A97         ; OLine=500 
                 STA      $B               ; OLine=501 
                 LSR      A                ; OLine=502 
                 CLC                       ; OLine=503 
                 ADC      $B               ; OLine=504 
                 STA      $B               ; OLine=505 
                 LDA      9                ; OLine=506 
                 ADC      8                ; OLine=507 
                 BCS      loc_6A97         ; OLine=508 
                 CMP      $B               ; OLine=509 
                 BCS      loc_6A97         ; OLine=510
                 JSR      sub_6B0F         ; OLine=511
                                           
loc_6A94:                                  ; OLine=513
                 JMP      loc_69F9         ; OLine=514 
                                           ;  ---------------------------------------------------------------------------
                                           
loc_6A97:                                  ; OLine=517
                                           
                 DEY                       ; OLine=519
                 BMI      loc_6A94         ; OLine=520 
                 JMP      loc_6A0A         ; OLine=521
                                           ;  End of function sub_69F0
                                           
                                           
                                           ;  ¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦ S U B R O U T I N E ¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦
                                           
                                           
sub_6A9D:                                  ; OLine=528
                                           
                 LDA      $200,Y           ; OLine=530 
                 AND      #7               ; OLine=531 
                 STA      8                ; OLine=532 
                 JSR      sub_77B5         ; OLine=533 
                 AND      #$18             ; OLine=534 
                 ORA      8                ; OLine=535 
                 STA      $200,X           ; OLine=536 
                 LDA      $2AF,Y           ; OLine=537
                 STA      $2AF,X           ; OLine=538
                 LDA      $269,Y           ; OLine=539
                 STA      $269,X           ; OLine=540 
                 LDA      $2D2,Y           ; OLine=541
                 STA      $2D2,X           ; OLine=542
                 LDA      $28C,Y           ; OLine=543
                 STA      $28C,X           ; OLine=544
                 LDA      $223,Y           ; OLine=545
                 STA      $223,X           ; OLine=546
                 LDA      $246,Y           ; OLine=547 
                 STA      $246,X           ; OLine=548
                 RTS                       ; OLine=549
                                           ;  End of function sub_6A9D
                                           
                                           
                                           ;  ¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦ S U B R O U T I N E ¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦
                                           
                                           
sub_6AD3:                                  ; OLine=556
                                           
                 STA      $B               ; OLine=558 
                 STX      $C               ; OLine=559
                                           ;  End of function sub_6AD3
                                           
                                           
                                           ;  ¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦ S U B R O U T I N E ¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦
                                           
                                           
sub_6AD7:                                  ; OLine=566
                 LDY      #0               ; OLine=567 
                                           
loc_6AD9:                                  ; OLine=569
                 INY                       ; OLine=570 
                 LDA      ($B),Y           ; OLine=571 
                 EOR      9                ; OLine=572
                 STA      (2),Y            ; OLine=573
                 DEY                       ; OLine=574
                 CMP      #$F0             ; OLine=575
                 BCS      loc_6B03         ; OLine=576 
                 CMP      #$A0             ; OLine=577
                 BCS      loc_6AFF         ; OLine=578
                 LDA      ($B),Y           ; OLine=579
                 STA      (2),Y            ; OLine=580
                 INY                       ; OLine=581
                 INY                       ; OLine=582
                 LDA      ($B),Y           ; OLine=583 
                 STA      (2),Y            ; OLine=584
                 INY                       ; OLine=585
                 LDA      ($B),Y           ; OLine=586 
                 EOR      8                ; OLine=587
                 ADC      $17              ; OLine=588
                 STA      (2),Y            ; OLine=589 
                                           
loc_6AFC:                                  ; OLine=591
                 INY                       ; OLine=592
                 BNE      loc_6AD9         ; OLine=593 
                                           
loc_6AFF:                                  ; OLine=595
                 DEY                       ; OLine=596
                 JMP      sub_7C39         ; OLine=597 
                                           ;  ---------------------------------------------------------------------------
                                           
loc_6B03:                                  ; OLine=600
                 LDA      ($B),Y           ; OLine=601 
                 EOR      8                ; OLine=602
                 CLC                       ; OLine=603
                 ADC      $17              ; OLine=604
                 STA      (2),Y            ; OLine=605
                 INY                       ; OLine=606
                 BNE      loc_6AFC         ; OLine=607 
                                           ;  End of function sub_6AD7
                                           
                                           
                                           ;  ¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦ S U B R O U T I N E ¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦
                                           
                                           
sub_6B0F:                                  ; OLine=614
                 CPX      #1               ; OLine=615
                 BNE      loc_6B1B         ; OLine=616 
                 CPY      #$1B             ; OLine=617
                 BNE      loc_6B29         ; OLine=618 
                 LDX      #0               ; OLine=619
                 LDY      #$1C             ; OLine=620 
                                           
loc_6B1B:                                  ; OLine=622
                 TXA                       ; OLine=623 
                 BNE      loc_6B3C         ; OLine=624
                 LDA      #$81             ; OLine=625
                 STA      $2FA             ; OLine=626 
                 LDX      $18              ; OLine=627  Current Player
                 DEC      $57,X            ; OLine=628  Subtract Ship
                 LDX      #0               ; OLine=629 
                                           
loc_6B29:                                  ; OLine=631
                 LDA      #$A0             ; OLine=632
                 STA      $21B,X           ; OLine=633 
                 LDA      #0               ; OLine=634
                 STA      $23E,X           ; OLine=635
                 STA      $261,X           ; OLine=636
                 CPY      #$1B             ; OLine=637
                 BCC      loc_6B47         ; OLine=638 
                 BCS      loc_6B73         ; OLine=639
                                           
loc_6B3C:                                  ; OLine=641
                 LDA      #0               ; OLine=642
                 STA      $21B,X           ; OLine=643 
                 CPY      #$1B             ; OLine=644
                 BEQ      loc_6B66         ; OLine=645
                 BCS      loc_6B73         ; OLine=646 
                                           
loc_6B47:                                  ; OLine=648
                 JSR      sub_75EC         ; OLine=649 
                                           
loc_6B4A:                                  ; OLine=651
                                           
                 LDA      $200,Y           ; OLine=653 
                 AND      #3               ; OLine=654
                 EOR      #2               ; OLine=655
                 LSR      A                ; OLine=656 
                 ROR      A                ; OLine=657
                 ROR      A                ; OLine=658
                 ORA      #$3F             ; OLine=659 
                 STA      $69              ; OLine=660
                 LDA      #$A0             ; OLine=661
                 STA      $200,Y           ; OLine=662 
                 LDA      #0               ; OLine=663
                 STA      $223,Y           ; OLine=664
                 STA      $246,Y           ; OLine=665 
                 RTS                       ; OLine=666
                                           ;  ---------------------------------------------------------------------------
                                           
loc_6B66:                                  ; OLine=669
                 TXA                       ; OLine=670 
                 LDX      $18              ; OLine=671  Current Player
                 DEC      $57,X            ; OLine=672  Subtract Ship
                 TAX                       ; OLine=673
                 LDA      #$81             ; OLine=674
                 STA      $2FA             ; OLine=675 
                 BNE      loc_6B4A         ; OLine=676
                                           
loc_6B73:                                  ; OLine=678
                                           
                 LDA      $2F8             ; OLine=680 
                 STA      $2F7             ; OLine=681  Countdown Timer For When Saucer Appears
                 LDA      $1C              ; OLine=682  Number Of Players In Current Game
                 BEQ      loc_6B4A         ; OLine=683  None, Branch
                 STX      $D               ; OLine=684 
                 LDX      $19              ; OLine=685 
                 LDA      $21C             ; OLine=686  Saucer Flag
                 LSR      A                ; OLine=687  Shift It To Carry
                 LDA      #$99             ; OLine=688  990 Points, Assume Small Saucer
                 BCS      loc_6B8B         ; OLine=689  Carry Will Be Set If Small Saucer
                 LDA      #$20             ; OLine=690  200 Points, Its The Large Saucer
                                           
loc_6B8B:                                  ; OLine=692
                 JSR      sub_7397         ; OLine=693  And Add It To Score
                 LDX      $D               ; OLine=694
                 JMP      loc_6B4A         ; OLine=695 
                                           ;  End of function sub_6B0F
                                           
                                           
                                           ;  ¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦ S U B R O U T I N E ¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦
                                           
                                           
sub_6B93:                                  ; OLine=702
                 LDA      $5C              ; OLine=703 
                 AND      #3               ; OLine=704
                 BEQ      loc_6B9A         ; OLine=705 
                                           
locret_6B99:                               ; OLine=707
                                           
                 RTS                       ; OLine=709 
                                           ;  ---------------------------------------------------------------------------
                                           
loc_6B9A:                                  ; OLine=712
                 LDA      $21C             ; OLine=713  Saucer Flag
                 BMI      locret_6B99      ; OLine=714  Currently Exploding?, Branch
                 BEQ      loc_6BA4         ; OLine=715  No Saucer Currently Active, Branch
                 JMP      loc_6C34         ; OLine=716 
                                           ;  ---------------------------------------------------------------------------
                                           
loc_6BA4:                                  ; OLine=719
                 LDA      $1C              ; OLine=720  Number Of Players In Current Game
                 BEQ      loc_6BAF         ; OLine=721  None, Branch
                 LDA      $21B             ; OLine=722 
                 BEQ      locret_6B99      ; OLine=723 
                 BMI      locret_6B99      ; OLine=724
                                           
loc_6BAF:                                  ; OLine=726
                 LDA      $2F9             ; OLine=727 
                 BEQ      loc_6BB7         ; OLine=728
                 DEC      $2F9             ; OLine=729 
                                           
loc_6BB7:                                  ; OLine=731
                 DEC      $2F7             ; OLine=732  Update Countdown Timer For When Saucer Appears
                 BNE      locret_6B99      ; OLine=733
                 LDA      #$12             ; OLine=734 
                 STA      $2F7             ; OLine=735
                 LDA      $2F9             ; OLine=736
                 BEQ      loc_6BD0         ; OLine=737 
                 LDA      $2F6             ; OLine=738
                 BEQ      locret_6B99      ; OLine=739 
                 CMP      $2FD             ; OLine=740 
                 BCS      locret_6B99      ; OLine=741 
                                           
loc_6BD0:                                  ; OLine=743
                 LDA      $2F8             ; OLine=744 
                 SEC                       ; OLine=745 
                 SBC      #6               ; OLine=746  Shorten Time Between Saucer Appearence
                 CMP      #$20             ; OLine=747  At Lowest Value?
                 BCC      loc_6BDD         ; OLine=748  Yes, Branch
                 STA      $2F8             ; OLine=749  Make The Update
                                           
loc_6BDD:                                  ; OLine=751
                 LDA      #0               ; OLine=752 
                 STA      $2CB             ; OLine=753 
                 STA      $285             ; OLine=754 
                 JSR      sub_77B5         ; OLine=755 
                 LSR      A                ; OLine=756 
                 ROR      $2EE             ; OLine=757 
                 LSR      A                ; OLine=758 
                 ROR      $2EE             ; OLine=759 
                 LSR      A                ; OLine=760
                 ROR      $2EE             ; OLine=761 
                 CMP      #$18             ; OLine=762
                 BCC      loc_6BFA         ; OLine=763 
                 AND      #$17             ; OLine=764
                                           
loc_6BFA:                                  ; OLine=766
                 STA      $2A8             ; OLine=767 
                 LDX      #$10             ; OLine=768
                 BIT      $60              ; OLine=769
                 BVS      loc_6C0F         ; OLine=770 
                 LDA      #$1F             ; OLine=771
                 STA      $285             ; OLine=772
                 LDA      #$FF             ; OLine=773 
                 STA      $2CB             ; OLine=774
                 LDX      #$F0             ; OLine=775 
                                           
loc_6C0F:                                  ; OLine=777
                 STX      $23F             ; OLine=778 
                 LDX      #2               ; OLine=779  Start With Large Saucer
                 LDA      $2F8             ; OLine=780  Start Checking Score When @ #$7F And Below
                 BMI      loc_6C30         ; OLine=781  Not There Yet, Branch Around Score Check
                 LDY      $19              ; OLine=782
                 LDA      $53,Y            ; OLine=783  Current Player Score, Thousands
                 CMP      #$30             ; OLine=784  30,000 Points Or More?
                 BCS      loc_6C2F         ; OLine=785  Yes, Branch
                 JSR      sub_77B5         ; OLine=786
                 STA      8                ; OLine=787
                 LDA      $2F8             ; OLine=788 
                 LSR      A                ; OLine=789
                 CMP      8                ; OLine=790
                 BCS      loc_6C30         ; OLine=791  Going To Be A large Saucer, Branch
                                           
loc_6C2F:                                  ; OLine=793
                 DEX                       ; OLine=794  Make It A Small Saucer
                                           
loc_6C30:                                  ; OLine=796
                                           
                 STX      $21C             ; OLine=798  Saucer Flag
                 RTS                       ; OLine=799
                                           ;  ---------------------------------------------------------------------------
                                           
loc_6C34:                                  ; OLine=802
                 LDA      $5C              ; OLine=803  Fast Timer
                 ASL      A                ; OLine=804  Time To Change Saucer Direction? ( $5C = #$80 )
                 BNE      loc_6C45         ; OLine=805  No, Branch
                 JSR      sub_77B5         ; OLine=806 
                 AND      #3               ; OLine=807 
                 TAX                       ; OLine=808
                 LDA      $6CD3,X          ; OLine=809  Direction Table
                 STA      $262             ; OLine=810
                                           
loc_6C45:                                  ; OLine=812
                 LDA      $1C              ; OLine=813  Number Of Players In Current Game
                 BEQ      loc_6C4E         ; OLine=814  None, Branch
                 LDA      $2FA             ; OLine=815
                 BNE      locret_6C53      ; OLine=816 
                                           
loc_6C4E:                                  ; OLine=818
                 DEC      $2F7             ; OLine=819
                 BEQ      loc_6C54         ; OLine=820 
                                           
locret_6C53:                               ; OLine=822
                 RTS                       ; OLine=823 
                                           ;  ---------------------------------------------------------------------------
                                           
loc_6C54:                                  ; OLine=826
                 LDA      #$A              ; OLine=827  Time Between Saucer Shots
                 STA      $2F7             ; OLine=828
                 LDA      $21C             ; OLine=829  Saucer Flag
                 LSR      A                ; OLine=830  Check Saucer Size
                 BEQ      loc_6C65         ; OLine=831  Branch If Small One
                 JSR      sub_77B5         ; OLine=832
                 JMP      loc_6CC4         ; OLine=833 
                                           ;  ---------------------------------------------------------------------------
                                           
loc_6C65:                                  ; OLine=836
                 LDA      $23F             ; OLine=837 
                 CMP      #$80             ; OLine=838
                 ROR      A                ; OLine=839
                 STA      $C               ; OLine=840 
                 LDA      $2CA             ; OLine=841
                 SEC                       ; OLine=842 
                 SBC      $2CB             ; OLine=843
                 STA      $B               ; OLine=844 
                 LDA      $284             ; OLine=845
                 SBC      $285             ; OLine=846 
                 ASL      $B               ; OLine=847
                 ROL      A                ; OLine=848
                 ASL      $B               ; OLine=849 
                 ROL      A                ; OLine=850
                 SEC                       ; OLine=851
                 SBC      $C               ; OLine=852 
                 TAX                       ; OLine=853
                 LDA      $262             ; OLine=854
                 CMP      #$80             ; OLine=855 
                 ROR      A                ; OLine=856
                 STA      $C               ; OLine=857
                 LDA      $2ED             ; OLine=858 
                 SEC                       ; OLine=859
                 SBC      $2EE             ; OLine=860 
                 STA      $B               ; OLine=861
                 LDA      $2A7             ; OLine=862
                 SBC      $2A8             ; OLine=863 
                 ASL      $B               ; OLine=864
                 ROL      A                ; OLine=865
                 ASL      $B               ; OLine=866 
                 ROL      A                ; OLine=867
                 SEC                       ; OLine=868 
                 SBC      $C               ; OLine=869
                 TAY                       ; OLine=870 
                 JSR      loc_76F0         ; OLine=871 
                 STA      $62              ; OLine=872 
                 JSR      sub_77B5         ; OLine=873 
                 LDX      $19              ; OLine=874 
                 LDY      $53,X            ; OLine=875  Current Players Score, Thousands
                 CPY      #$35             ; OLine=876  35,000?
                 LDX      #0               ; OLine=877 
                 BCC      loc_6CBA         ; OLine=878  Branch If Less
                 INX                       ; OLine=879 
                                           
loc_6CBA:                                  ; OLine=881
                 AND      $6CCF,X          ; OLine=882 
                 BPL      loc_6CC2         ; OLine=883 
                 ORA      $6CD1,X          ; OLine=884 
                                           
loc_6CC2:                                  ; OLine=886
                 ADC      $62              ; OLine=887  Direction Shot Is Traveling???
                                           
loc_6CC4:                                  ; OLine=889
                 STA      $62              ; OLine=890 
                 LDY      #3               ; OLine=891 
                 LDX      #1               ; OLine=892 
                 STX      $E               ; OLine=893 
                 JMP      loc_6CF2         ; OLine=894 
                                           ;  End of function sub_6B93
                                           
                                           ;  ---------------------------------------------------------------------------
                 .BYTE    $8F              ; OLine=898
                 .BYTE    $87              ; OLine=899
                                           
                 .BYTE    $70              ; OLine=901
                 .BYTE    $78              ; OLine=902
                                           ;  First Colum Is Saucer Enters From Left Side Of Screen
                                           ;  Second Colum Is Saucer Enters From Right Side Of Screen
                 .BYTE    $F0              ; OLine=905  SE SW
                 .BYTE    0                ; OLine=906  E  W
                 .BYTE    0                ; OLine=907  E  W
                 .BYTE    $10              ; OLine=908  NE NW
                                           
                                           ;  ¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦ S U B R O U T I N E ¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦
                                           
                                           
sub_6CD7:                                  ; OLine=913
                 LDA      $1C              ; OLine=914  Number Of Players In Current Game
                 BEQ      locret_6CFC      ; OLine=915  None, Branch
                 ASL      $2004            ; OLine=916  Fire Switch
                 ROR      $63              ; OLine=917 
                 BIT      $63              ; OLine=918 
                 BPL      locret_6CFC      ; OLine=919 
                 BVS      locret_6CFC      ; OLine=920 
                 LDA      $2FA             ; OLine=921 
                 BNE      locret_6CFC      ; OLine=922 
                 TAX                       ; OLine=923 
                 LDA      #3               ; OLine=924 
                 STA      $E               ; OLine=925 
                 LDY      #7               ; OLine=926 
                                           
loc_6CF2:                                  ; OLine=928
                                           
                 LDA      $21B,Y           ; OLine=930  Check For A Open Slot For The Shot
                 BEQ      loc_6CFD         ; OLine=931  Branch If This Slot Is Open
                 DEY                       ; OLine=932  Point To Next Slot
                 CPY      $E               ; OLine=933  Out Of Slots?
                 BNE      loc_6CF2         ; OLine=934  No, Branch And Keep Checking
                                           
locret_6CFC:                               ; OLine=936
                                           
                 RTS                       ; OLine=938 
                                           ;  ---------------------------------------------------------------------------
                                           
loc_6CFD:                                  ; OLine=941
                 STX      $D               ; OLine=942 
                 LDA      #$12             ; OLine=943 
                 STA      $21B,Y           ; OLine=944 
                 LDA      $61,X            ; OLine=945 
                 JSR      sub_77D2         ; OLine=946 
                 LDX      $D               ; OLine=947 
                 CMP      #$80             ; OLine=948 
                 ROR      A                ; OLine=949 
                 STA      9                ; OLine=950 
                 CLC                       ; OLine=951 
                 ADC      $23E,X           ; OLine=952
                 BMI      loc_6D1E         ; OLine=953 
                 CMP      #$70             ; OLine=954
                 BCC      loc_6D24         ; OLine=955 
                 LDA      #$6F             ; OLine=956
                 BNE      loc_6D24         ; OLine=957 
                                           
loc_6D1E:                                  ; OLine=959
                 CMP      #$91             ; OLine=960 
                 BCS      loc_6D24         ; OLine=961
                 LDA      #$91             ; OLine=962
                                           
loc_6D24:                                  ; OLine=964
                                           
                 STA      $23E,Y           ; OLine=966 
                 LDA      $61,X            ; OLine=967
                 JSR      sub_77D5         ; OLine=968
                 LDX      $D               ; OLine=969 
                 CMP      #$80             ; OLine=970
                 ROR      A                ; OLine=971 
                 STA      $C               ; OLine=972
                 CLC                       ; OLine=973
                 ADC      $261,X           ; OLine=974 
                 BMI      loc_6D41         ; OLine=975
                 CMP      #$70             ; OLine=976 
                 BCC      loc_6D47         ; OLine=977
                 LDA      #$6F             ; OLine=978
                 BNE      loc_6D47         ; OLine=979 
                                           
loc_6D41:                                  ; OLine=981
                 CMP      #$91             ; OLine=982
                 BCS      loc_6D47         ; OLine=983
                 LDA      #$91             ; OLine=984 
                                           
loc_6D47:                                  ; OLine=986
                                           
                 STA      $261,Y           ; OLine=988 
                 LDX      #0               ; OLine=989
                 LDA      9                ; OLine=990
                 BPL      loc_6D51         ; OLine=991 
                 DEX                       ; OLine=992 
                                           
loc_6D51:                                  ; OLine=994
                 STX      8                ; OLine=995 
                 LDX      $D               ; OLine=996 
                 CMP      #$80             ; OLine=997 
                 ROR      A                ; OLine=998 
                 CLC                       ; OLine=999 
                 ADC      9                ; OLine=1000 
                 CLC                       ; OLine=1001 
                 ADC      $2CA,X           ; OLine=1002 
                 STA      $2CA,Y           ; OLine=1003 
                 LDA      8                ; OLine=1004 
                 ADC      $284,X           ; OLine=1005
                 STA      $284,Y           ; OLine=1006
                 LDX      #0               ; OLine=1007 
                 LDA      $C               ; OLine=1008
                 BPL      loc_6D71         ; OLine=1009
                 DEX                       ; OLine=1010 
                                           
loc_6D71:                                  ; OLine=1012
                 STX      $B               ; OLine=1013 
                 LDX      $D               ; OLine=1014
                 CMP      #$80             ; OLine=1015
                 ROR      A                ; OLine=1016 
                 CLC                       ; OLine=1017
                 ADC      $C               ; OLine=1018 
                 CLC                       ; OLine=1019
                 ADC      $2ED,X           ; OLine=1020
                 STA      $2ED,Y           ; OLine=1021 
                 LDA      $B               ; OLine=1022
                 ADC      $2A7,X           ; OLine=1023
                 STA      $2A7,Y           ; OLine=1024 
                 LDA      #$80             ; OLine=1025
                 STA      $66,X            ; OLine=1026 
                 RTS                       ; OLine=1027
                                           ;  End of function sub_6CD7
                                           
                                           ;  ---------------------------------------------------------------------------
                 .BYTE    $D8              ; OLine=1031
                                           
                                           ;  ¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦ S U B R O U T I N E ¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦
                                           
                                           
sub_6D90:                                  ; OLine=1036
                 LDA      $32              ; OLine=1037 
                 AND      $33              ; OLine=1038
                 BPL      loc_6D97         ; OLine=1039 
                 RTS                       ; OLine=1040
                                           ;  ---------------------------------------------------------------------------
                                           
loc_6D97:                                  ; OLine=1043
                 LDA      $1A              ; OLine=1044 
                 LSR      A                ; OLine=1045
                 BEQ      loc_6DB4         ; OLine=1046
                 LDY      #1               ; OLine=1047  Offset For "PLAYER "
                 JSR      sub_77F6         ; OLine=1048  And Draw To Screen
                 LDY      #2               ; OLine=1049 
                 LDX      $33              ; OLine=1050 
                 BPL      loc_6DA8         ; OLine=1051 
                 DEY                       ; OLine=1052
                                           
loc_6DA8:                                  ; OLine=1054
                 STY      $18              ; OLine=1055  Current Player
                 LDA      $5C              ; OLine=1056  Fast Timer
                 AND      #$10             ; OLine=1057 
                 BNE      loc_6DB4         ; OLine=1058 
                 TYA                       ; OLine=1059 
                 JSR      sub_7BD1         ; OLine=1060 
                                           
loc_6DB4:                                  ; OLine=1062
                                           
                 LSR      $18              ; OLine=1064  Current Player
                 JSR      sub_73B2         ; OLine=1065 
                 LDY      #2               ; OLine=1066  Offset For "YOUR SCORE IS ONE OF THE TEN BEST"
                 JSR      sub_77F6         ; OLine=1067  And Draw It To Screen
                 LDY      #3               ; OLine=1068  Offset For "PLEASE ENTER YOUR INITIALS"
                 JSR      sub_77F6         ; OLine=1069  And Draw It To Screen
                 LDY      #4               ; OLine=1070  Offset For "PUSH ROTATE TO SELECT LETTER"
                 JSR      sub_77F6         ; OLine=1071  And Draw It To Screen
                 LDY      #5               ; OLine=1072  Offset For "PUSH HYPERSPACE WHEN LETTER IS CORRECT"
                 JSR      sub_77F6         ; OLine=1073  And Draw It To Screen
                 LDA      #$20             ; OLine=1074 
                 STA      0                ; OLine=1075 
                 LDA      #$64             ; OLine=1076 
                 LDX      #$39             ; OLine=1077
                 JSR      sub_7C03         ; OLine=1078
                 LDA      #$70             ; OLine=1079
                 JSR      sub_7CDE         ; OLine=1080
                 LDX      $18              ; OLine=1081  Current Player
                 LDY      $32,X            ; OLine=1082
                 STY      $B               ; OLine=1083 
                 TYA                       ; OLine=1084
                 CLC                       ; OLine=1085 
                 ADC      $31              ; OLine=1086
                 STA      $C               ; OLine=1087
                 JSR      sub_6F1A         ; OLine=1088 
                 LDY      $B               ; OLine=1089
                 INY                       ; OLine=1090 
                 JSR      sub_6F1A         ; OLine=1091
                 LDY      $B               ; OLine=1092 
                 INY                       ; OLine=1093
                 INY                       ; OLine=1094 
                 JSR      sub_6F1A         ; OLine=1095
                 LDA      $2003            ; OLine=1096  Hyperspace Switch
                 ROL      A                ; OLine=1097 
                 ROL      $63              ; OLine=1098 
                 LDA      $63              ; OLine=1099 
                 AND      #$1F             ; OLine=1100 
                 CMP      #7               ; OLine=1101 
                 BNE      loc_6E2E         ; OLine=1102 
                 INC      $31              ; OLine=1103
                 LDA      $31              ; OLine=1104
                 CMP      #3               ; OLine=1105 
                 BCC      loc_6E22         ; OLine=1106
                 LDX      $18              ; OLine=1107  Current Player
                 LDA      #$FF             ; OLine=1108 
                 STA      $32,X            ; OLine=1109 
                                           
loc_6E15:                                  ; OLine=1111
                 LDX      #0               ; OLine=1112 
                 STX      $18              ; OLine=1113
                 STX      $31              ; OLine=1114 
                 LDX      #$F0             ; OLine=1115
                 STX      $5D              ; OLine=1116  Slow Timer
                 JMP      sub_73B2         ; OLine=1117
                                           ;  ---------------------------------------------------------------------------
                                           
loc_6E22:                                  ; OLine=1120
                 INC      $C               ; OLine=1121 
                 LDX      $C               ; OLine=1122
                 LDA      #$F4             ; OLine=1123
                 STA      $5D              ; OLine=1124  Slow Timer
                 LDA      #$B              ; OLine=1125
                 STA      $34,X            ; OLine=1126 
                                           
loc_6E2E:                                  ; OLine=1128
                 LDA      $5D              ; OLine=1129  Slow Timer
                 BNE      loc_6E3A         ; OLine=1130
                 LDA      #$FF             ; OLine=1131 
                 STA      $32              ; OLine=1132
                 STA      $33              ; OLine=1133 
                 BMI      loc_6E15         ; OLine=1134
                                           
loc_6E3A:                                  ; OLine=1136
                 LDA      $5C              ; OLine=1137  Fast Timer
                 AND      #7               ; OLine=1138
                 BNE      loc_6E71         ; OLine=1139
                 LDA      $2407            ; OLine=1140  Rotate Left Switch
                 BPL      loc_6E49         ; OLine=1141
                 LDA      #1               ; OLine=1142
                 BNE      loc_6E50         ; OLine=1143
                                           
loc_6E49:                                  ; OLine=1145
                 LDA      $2406            ; OLine=1146  Rotate Right Switch
                 BPL      loc_6E71         ; OLine=1147 
                 LDA      #$FF             ; OLine=1148 
                                           
loc_6E50:                                  ; OLine=1150
                 LDX      $C               ; OLine=1151 
                 CLC                       ; OLine=1152
                 ADC      $34,X            ; OLine=1153
                 BMI      loc_6E67         ; OLine=1154 
                 CMP      #$B              ; OLine=1155
                 BCS      loc_6E69         ; OLine=1156
                 CMP      #1               ; OLine=1157 
                 BEQ      loc_6E63         ; OLine=1158
                 LDA      #0               ; OLine=1159
                 BEQ      loc_6E6F         ; OLine=1160
                                           
loc_6E63:                                  ; OLine=1162
                 LDA      #$B              ; OLine=1163 
                 BNE      loc_6E6F         ; OLine=1164
                                           
loc_6E67:                                  ; OLine=1166
                 LDA      #$24             ; OLine=1167 
                                           
loc_6E69:                                  ; OLine=1169
                 CMP      #$25             ; OLine=1170 
                 BCC      loc_6E6F         ; OLine=1171
                 LDA      #0               ; OLine=1172 
                                           
loc_6E6F:                                  ; OLine=1174
                                           
                 STA      $34,X            ; OLine=1176 
                                           
loc_6E71:                                  ; OLine=1178
                                           
                 LDA      #0               ; OLine=1180 
                 RTS                       ; OLine=1181
                                           ;  End of function sub_6D90
                                           
                                           
                                           ;  ¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦ S U B R O U T I N E ¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦
                                           
                                           
sub_6E74:                                  ; OLine=1188
                 LDA      $1C              ; OLine=1189  Number Of Players In Current Game
                 BEQ      locret_6ED7      ; OLine=1190  None, Branch
                 LDA      $21B             ; OLine=1191  Player Flag
                 BMI      locret_6ED7      ; OLine=1192  Branch If Currently Exploding
                 LDA      $2FA             ; OLine=1193 
                 BNE      locret_6ED7      ; OLine=1194 
                 LDA      $2003            ; OLine=1195  Hyperspace Switch
                 BPL      locret_6ED7      ; OLine=1196  Branch If NOT Pressed
                 LDA      #0               ; OLine=1197 
                 STA      $21B             ; OLine=1198 
                 STA      $23E             ; OLine=1199 
                 STA      $261             ; OLine=1200 
                 LDA      #$30             ; OLine=1201 
                 STA      $2FA             ; OLine=1202 
                 JSR      sub_77B5         ; OLine=1203 
                 AND      #$1F             ; OLine=1204 
                 CMP      #$1D             ; OLine=1205 
                 BCC      loc_6EA2         ; OLine=1206 
                 LDA      #$1C             ; OLine=1207 
                                           
loc_6EA2:                                  ; OLine=1209
                 CMP      #3               ; OLine=1210 
                 BCS      loc_6EA8         ; OLine=1211 
                 LDA      #3               ; OLine=1212 
                                           
loc_6EA8:                                  ; OLine=1214
                 STA      $284             ; OLine=1215 
                 LDX      #5               ; OLine=1216 
                                           
loc_6EAD:                                  ; OLine=1218
                 JSR      sub_77B5         ; OLine=1219 
                 DEX                       ; OLine=1220 
                 BNE      loc_6EAD         ; OLine=1221 
                 AND      #$1F             ; OLine=1222 
                 INX                       ; OLine=1223  Assume Success ( X = 1 At This Point )
                 CMP      #$18             ; OLine=1224 
                 BCC      loc_6EC6         ; OLine=1225 
                 AND      #7               ; OLine=1226 
                 ASL      A                ; OLine=1227 
                 ADC      #4               ; OLine=1228 
                 CMP      $2F6             ; OLine=1229 
                 BCC      loc_6EC6         ; OLine=1230 
                 LDX      #$80             ; OLine=1231  Flag Hyperspace Unsuccessful
                                           
loc_6EC6:                                  ; OLine=1233
                                           
                 CMP      #$15             ; OLine=1235 
                 BCC      loc_6ECC         ; OLine=1236 
                 LDA      #$14             ; OLine=1237 
                                           
loc_6ECC:                                  ; OLine=1239
                 CMP      #3               ; OLine=1240 
                 BCS      loc_6ED2         ; OLine=1241 
                 LDA      #3               ; OLine=1242 
                                           
loc_6ED2:                                  ; OLine=1244
                 STA      $2A7             ; OLine=1245 
                 STX      $59              ; OLine=1246  Hyperspace Flag
                                           
locret_6ED7:                               ; OLine=1248
                                           
                 RTS                       ; OLine=1250 
                                           ;  End of function sub_6E74
                                           
                                           
                                           ;  ¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦ S U B R O U T I N E ¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦
                                           
                                           
sub_6ED8:                                  ; OLine=1257
                                           
                 LDA      #2               ; OLine=1259 
                 STA      $2F5             ; OLine=1260 
                 LDX      #3               ; OLine=1261  Assume A 3 Ship Game
                 LSR      $2802            ; OLine=1262  Shift Number Of Starting Ships Bit To Carry
                 BCS      loc_6EE5         ; OLine=1263  3 Ship Game
                 INX                       ; OLine=1264  4 Ship Game
                                           
loc_6EE5:                                  ; OLine=1266
                 STX      $56              ; OLine=1267 
                 LDA      #0               ; OLine=1268 
                 LDX      #4               ; OLine=1269 
                                           
loc_6EEB:                                  ; OLine=1271
                 STA      $21B,X           ; OLine=1272 
                 STA      $21F,X           ; OLine=1273
                 STA      $51,X            ; OLine=1274  *BUG* Should Be $52,X
                 DEX                       ; OLine=1275
                 BPL      loc_6EEB         ; OLine=1276 
                 STA      $2F6             ; OLine=1277
                 RTS                       ; OLine=1278 
                                           ;  End of function sub_6ED8
                                           
                                           
                                           ;  ¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦ S U B R O U T I N E ¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦
                                           
                                           
sub_6EFA:                                  ; OLine=1285
                                           
                 LDA      #0               ; OLine=1287 
                 STA      $3600            ; OLine=1288
                 STA      $3A00            ; OLine=1289
                 STA      $3C00            ; OLine=1290 
                 STA      $3C01            ; OLine=1291
                 STA      $3C03            ; OLine=1292
                 STA      $3C04            ; OLine=1293
                 STA      $3C05            ; OLine=1294 
                 STA      $69              ; OLine=1295
                 STA      $66              ; OLine=1296
                 STA      $67              ; OLine=1297
                 STA      $68              ; OLine=1298 
                 RTS                       ; OLine=1299
                                           ;  End of function sub_6EFA
                                           
                                           
                                           ;  ¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦ S U B R O U T I N E ¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦
                                           
                                           
sub_6F1A:                                  ; OLine=1306
                                           
                 LDA      $34,Y            ; OLine=1308 
                 ASL      A                ; OLine=1309
                 TAY                       ; OLine=1310
                 BNE      sub_6F35         ; OLine=1311 
                 LDA      $32              ; OLine=1312
                 AND      $33              ; OLine=1313
                 BMI      sub_6F35         ; OLine=1314 
                 LDA      #$72             ; OLine=1315
                 LDX      #$F8             ; OLine=1316 
                 JSR      sub_7D45         ; OLine=1317
                 LDA      #1               ; OLine=1318 
                 LDX      #$F8             ; OLine=1319
                 JMP      sub_7D45         ; OLine=1320 
                                           ;  End of function sub_6F1A
                                           
                                           
                                           ;  ¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦ S U B R O U T I N E ¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦
                                           
                                           
sub_6F35:                                  ; OLine=1327
                                           
                 LDX      $56D5,Y          ; OLine=1329 
                 LDA      $56D4,Y          ; OLine=1330
                 JMP      sub_7D45         ; OLine=1331 
                                           ;  End of function sub_6F35
                                           
                                           
                                           ;  ¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦ S U B R O U T I N E ¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦
                                           
                                           
sub_6F3E:                                  ; OLine=1338
                                           
                 BEQ      locret_6F56      ; OLine=1340 
                 STY      8                ; OLine=1341
                 LDX      #$D5             ; OLine=1342
                 LDY      #$E0             ; OLine=1343 
                 STY      0                ; OLine=1344
                 JSR      sub_7C03         ; OLine=1345
                                           
loc_6F4B:                                  ; OLine=1347
                 LDX      #$DA             ; OLine=1348 
                 LDA      #$54             ; OLine=1349
                 JSR      sub_7BFC         ; OLine=1350
                 DEC      8                ; OLine=1351 
                 BNE      loc_6F4B         ; OLine=1352
                                           
locret_6F56:                               ; OLine=1354
                 RTS                       ; OLine=1355 
                                           ;  End of function sub_6F3E
                                           
                                           
                                           ;  ¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦ S U B R O U T I N E ¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦
                                           
                                           
sub_6F57:                                  ; OLine=1362
                 LDX      #$22             ; OLine=1363 
                                           
loc_6F59:                                  ; OLine=1365
                 LDA      $200,X           ; OLine=1366
                 BNE      loc_6F62         ; OLine=1367 
                                           
loc_6F5E:                                  ; OLine=1369
                                           
                 DEX                       ; OLine=1371 
                 BPL      loc_6F59         ; OLine=1372
                 RTS                       ; OLine=1373 
                                           ;  ---------------------------------------------------------------------------
                                           
loc_6F62:                                  ; OLine=1376
                 BPL      loc_6FC7         ; OLine=1377 
                 JSR      sub_7708         ; OLine=1378 
                 LSR      A                ; OLine=1379
                 LSR      A                ; OLine=1380 
                 LSR      A                ; OLine=1381
                 LSR      A                ; OLine=1382
                 CPX      #$1B             ; OLine=1383 
                 BNE      loc_6F76         ; OLine=1384 
                 LDA      $5C              ; OLine=1385 
                 AND      #1               ; OLine=1386 
                 LSR      A                ; OLine=1387
                 BEQ      loc_6F77         ; OLine=1388 
                                           
loc_6F76:                                  ; OLine=1390
                 SEC                       ; OLine=1391 
                                           
loc_6F77:                                  ; OLine=1393
                 ADC      $200,X           ; OLine=1394
                 BMI      loc_6FA1         ; OLine=1395 
                 CPX      #$1B             ; OLine=1396
                 BEQ      loc_6F93         ; OLine=1397
                 BCS      loc_6F99         ; OLine=1398 
                 DEC      $2F6             ; OLine=1399
                 BNE      loc_6F8C         ; OLine=1400
                 LDY      #$7F             ; OLine=1401 
                 STY      $2FB             ; OLine=1402 
                                           
loc_6F8C:                                  ; OLine=1404
                                           
                 LDA      #0               ; OLine=1406 
                 STA      $200,X           ; OLine=1407
                 BEQ      loc_6F5E         ; OLine=1408 
                                           
loc_6F93:                                  ; OLine=1410
                 JSR      sub_71E8         ; OLine=1411 
                 JMP      loc_6F8C         ; OLine=1412 
                                           ;  ---------------------------------------------------------------------------
                                           
loc_6F99:                                  ; OLine=1415
                 LDA      $2F8             ; OLine=1416 
                 STA      $2F7             ; OLine=1417  Countdown Timer For When Saucer Appears
                 BNE      loc_6F8C         ; OLine=1418 
                                           
loc_6FA1:                                  ; OLine=1420
                 STA      $200,X           ; OLine=1421 
                 AND      #$F0             ; OLine=1422 
                 CLC                       ; OLine=1423 
                 ADC      #$10             ; OLine=1424 
                 CPX      #$1B             ; OLine=1425
                 BNE      loc_6FAF         ; OLine=1426
                 LDA      #0               ; OLine=1427 
                                           
loc_6FAF:                                  ; OLine=1429
                 TAY                       ; OLine=1430 
                 LDA      $2AF,X           ; OLine=1431
                 STA      4                ; OLine=1432
                 LDA      $269,X           ; OLine=1433 
                 STA      5                ; OLine=1434
                 LDA      $2D2,X           ; OLine=1435
                 STA      6                ; OLine=1436 
                 LDA      $28C,X           ; OLine=1437
                 STA      7                ; OLine=1438
                 JMP      loc_7027         ; OLine=1439 
                                           ;  ---------------------------------------------------------------------------
                                           
loc_6FC7:                                  ; OLine=1442
                 CLC                       ; OLine=1443 
                 LDY      #0               ; OLine=1444
                 LDA      $223,X           ; OLine=1445
                 BPL      loc_6FD0         ; OLine=1446 
                 DEY                       ; OLine=1447
                                           
loc_6FD0:                                  ; OLine=1449
                 ADC      $2AF,X           ; OLine=1450 
                 STA      $2AF,X           ; OLine=1451
                 STA      4                ; OLine=1452
                 TYA                       ; OLine=1453 
                 ADC      $269,X           ; OLine=1454
                 CMP      #$20             ; OLine=1455
                 BCC      loc_6FEC         ; OLine=1456 
                 AND      #$1F             ; OLine=1457
                 CPX      #$1C             ; OLine=1458
                 BNE      loc_6FEC         ; OLine=1459 
                 JSR      sub_702D         ; OLine=1460
                 JMP      loc_6F5E         ; OLine=1461 
                                           ;  ---------------------------------------------------------------------------
                                           
loc_6FEC:                                  ; OLine=1464
                                           
                 STA      $269,X           ; OLine=1466 
                 STA      5                ; OLine=1467
                 CLC                       ; OLine=1468
                 LDY      #0               ; OLine=1469 
                 LDA      $246,X           ; OLine=1470
                 BPL      loc_6FFB         ; OLine=1471
                 LDY      #$FF             ; OLine=1472 
                                           
loc_6FFB:                                  ; OLine=1474
                 ADC      $2D2,X           ; OLine=1475
                 STA      $2D2,X           ; OLine=1476 
                 STA      6                ; OLine=1477
                 TYA                       ; OLine=1478
                 ADC      $28C,X           ; OLine=1479
                 CMP      #$18             ; OLine=1480 
                 BCC      loc_7013         ; OLine=1481
                 BEQ      loc_7011         ; OLine=1482
                 LDA      #$17             ; OLine=1483
                 BNE      loc_7013         ; OLine=1484 
                                           
loc_7011:                                  ; OLine=1486
                 LDA      #0               ; OLine=1487 
                                           
loc_7013:                                  ; OLine=1489
                                           
                 STA      $28C,X           ; OLine=1491 
                 STA      7                ; OLine=1492 
                 LDA      $200,X           ; OLine=1493
                 LDY      #$E0             ; OLine=1494
                 LSR      A                ; OLine=1495 
                 BCS      loc_7027         ; OLine=1496
                 LDY      #$F0             ; OLine=1497
                 LSR      A                ; OLine=1498
                 BCS      loc_7027         ; OLine=1499 
                 LDY      #0               ; OLine=1500 
                                           
loc_7027:                                  ; OLine=1502
                                           
                 JSR      sub_72FE         ; OLine=1504 
                 JMP      loc_6F5E         ; OLine=1505 
                                           ;  End of function sub_6F57
                                           
                                           
                                           ;  ¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦ S U B R O U T I N E ¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦
                                           
                                           
sub_702D:                                  ; OLine=1512
                                           
                 LDA      $2F8             ; OLine=1514  Starting Value For Timer @ $02F7
                 STA      $2F7             ; OLine=1515  Countdown Timer For When Saucer Appears
                 LDA      #0               ; OLine=1516
                 STA      $21C             ; OLine=1517  Saucer Flag
                 STA      $23F             ; OLine=1518 
                 STA      $262             ; OLine=1519
                 RTS                       ; OLine=1520 
                                           ;  End of function sub_702D
                                           
                                           
                                           ;  ¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦ S U B R O U T I N E ¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦
                                           
                                           
sub_703F:                                  ; OLine=1527
                 LDA      $1C              ; OLine=1528  Number Of Players In Current Game
                 BEQ      locret_7085      ; OLine=1529  None, Branch
                 LDA      $21B             ; OLine=1530  Player Flag
                 BMI      locret_7085      ; OLine=1531  Branch If Currently Exploding
                 LDA      $2FA             ; OLine=1532 
                 BEQ      loc_7086         ; OLine=1533 
                 DEC      $2FA             ; OLine=1534 
                 BNE      locret_7085      ; OLine=1535 
                 LDY      $59              ; OLine=1536  Hyperspace Flag
                 BMI      loc_706F         ; OLine=1537  Gonna Die From Hyperspace, Branch
                 BNE      loc_7068         ; OLine=1538  Successful Hyperspace, Branch
                 JSR      sub_7139         ; OLine=1539 
                 BNE      loc_7081         ; OLine=1540 
                 LDY      $21C             ; OLine=1541 
                 BEQ      loc_7068         ; OLine=1542 
                 LDY      #2               ; OLine=1543 
                 STY      $2FA             ; OLine=1544 
                 RTS                       ; OLine=1545 
                                           ;  ---------------------------------------------------------------------------
                                           
loc_7068:                                  ; OLine=1548
                                           
                 LDA      #1               ; OLine=1550  Flag Ship OK
                 STA      $21B             ; OLine=1551 
                 BNE      loc_7081         ; OLine=1552  Will Always Branch
                                           
loc_706F:                                  ; OLine=1554
                 LDA      #$A0             ; OLine=1555  Switch To Explosion Timer
                 STA      $21B             ; OLine=1556 
                 LDX      #$3E             ; OLine=1557 
                 STX      $69              ; OLine=1558 
                 LDX      $18              ; OLine=1559  Current Player
                 DEC      $57,X            ; OLine=1560  Subtract Ship
                 LDA      #$81             ; OLine=1561
                 STA      $2FA             ; OLine=1562 
                                           
loc_7081:                                  ; OLine=1564
                                           
                 LDA      #0               ; OLine=1566 
                 STA      $59              ; OLine=1567
                                           
locret_7085:                               ; OLine=1569
                                           
                 RTS                       ; OLine=1571 
                                           ;  ---------------------------------------------------------------------------
                                           
loc_7086:                                  ; OLine=1574
                 LDA      $2407            ; OLine=1575  Rotate Left Switch
                 BPL      loc_708F         ; OLine=1576  Branch If NOT Pressed
                 LDA      #3               ; OLine=1577 
                 BNE      loc_7096         ; OLine=1578  Will Always Branch
                                           
loc_708F:                                  ; OLine=1580
                 LDA      $2406            ; OLine=1581  Rotate Right Switch
                 BPL      loc_709B         ; OLine=1582  Branch If NOT Pressed
                 LDA      #$FD             ; OLine=1583 
                                           
loc_7096:                                  ; OLine=1585
                 CLC                       ; OLine=1586 
                 ADC      $61              ; OLine=1587  Current Ship Direction
                 STA      $61              ; OLine=1588 
                                           
loc_709B:                                  ; OLine=1590
                 LDA      $5C              ; OLine=1591  Fast Timer
                 LSR      A                ; OLine=1592 
                 BCS      locret_7085      ; OLine=1593 
                 LDA      $2405            ; OLine=1594  Thrust Switch
                 BPL      loc_70E1         ; OLine=1595  Branch If NOT Pressed
                 LDA      #$80             ; OLine=1596 
                 STA      $3C03            ; OLine=1597  Ship Thrust Sound
                 LDY      #0               ; OLine=1598 
                 LDA      $61              ; OLine=1599  Current Ship Direction
                 JSR      sub_77D2         ; OLine=1600 
                 BPL      loc_70B4         ; OLine=1601
                 DEY                       ; OLine=1602 
                                           
loc_70B4:                                  ; OLine=1604
                 ASL      A                ; OLine=1605 
                 CLC                       ; OLine=1606
                 ADC      $64              ; OLine=1607
                 TAX                       ; OLine=1608
                 TYA                       ; OLine=1609 
                 ADC      $23E             ; OLine=1610
                 JSR      sub_7125         ; OLine=1611
                 STA      $23E             ; OLine=1612
                 STX      $64              ; OLine=1613 
                 LDY      #0               ; OLine=1614
                 LDA      $61              ; OLine=1615
                 JSR      sub_77D5         ; OLine=1616 
                 BPL      loc_70CF         ; OLine=1617
                 DEY                       ; OLine=1618 
                                           
loc_70CF:                                  ; OLine=1620
                 ASL      A                ; OLine=1621 
                 CLC                       ; OLine=1622
                 ADC      $65              ; OLine=1623
                 TAX                       ; OLine=1624 
                 TYA                       ; OLine=1625
                 ADC      $261             ; OLine=1626
                 JSR      sub_7125         ; OLine=1627 
                 STA      $261             ; OLine=1628
                 STX      $65              ; OLine=1629
                 RTS                       ; OLine=1630 
                                           ;  ---------------------------------------------------------------------------
                                           
loc_70E1:                                  ; OLine=1633
                 LDA      #0               ; OLine=1634 
                 STA      $3C03            ; OLine=1635  Ship Thrust Sound
                 LDA      $23E             ; OLine=1636
                 ORA      $64              ; OLine=1637
                 BEQ      loc_7105         ; OLine=1638
                 LDA      $23E             ; OLine=1639 
                 ASL      A                ; OLine=1640
                 LDX      #$FF             ; OLine=1641
                 CLC                       ; OLine=1642
                 EOR      #$FF             ; OLine=1643 
                 BMI      loc_70FA         ; OLine=1644
                 INX                       ; OLine=1645
                 SEC                       ; OLine=1646 
                                           
loc_70FA:                                  ; OLine=1648
                 ADC      $64              ; OLine=1649
                 STA      $64              ; OLine=1650 
                 TXA                       ; OLine=1651
                 ADC      $23E             ; OLine=1652
                 STA      $23E             ; OLine=1653 
                                           
loc_7105:                                  ; OLine=1655
                 LDA      $65              ; OLine=1656 
                 ORA      $261             ; OLine=1657
                 BEQ      locret_7124      ; OLine=1658
                 LDA      $261             ; OLine=1659 
                 ASL      A                ; OLine=1660
                 LDX      #$FF             ; OLine=1661
                 CLC                       ; OLine=1662
                 EOR      #$FF             ; OLine=1663 
                 BMI      loc_7119         ; OLine=1664
                 SEC                       ; OLine=1665
                 INX                       ; OLine=1666 
                                           
loc_7119:                                  ; OLine=1668
                 ADC      $65              ; OLine=1669
                 STA      $65              ; OLine=1670 
                 TXA                       ; OLine=1671
                 ADC      $261             ; OLine=1672
                 STA      $261             ; OLine=1673 
                                           
locret_7124:                               ; OLine=1675
                 RTS                       ; OLine=1676 
                                           ;  End of function sub_703F
                                           
                                           
                                           ;  ¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦ S U B R O U T I N E ¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦
                                           
                                           
sub_7125:                                  ; OLine=1683
                                           
                 BMI      loc_7130         ; OLine=1685 
                 CMP      #$40             ; OLine=1686
                 BCC      locret_7138      ; OLine=1687
                 LDX      #$FF             ; OLine=1688 
                 LDA      #$3F             ; OLine=1689
                 RTS                       ; OLine=1690 
                                           ;  ---------------------------------------------------------------------------
                                           
loc_7130:                                  ; OLine=1693
                 CMP      #$C0             ; OLine=1694
                 BCS      locret_7138      ; OLine=1695 
                 LDX      #1               ; OLine=1696
                 LDA      #$C0             ; OLine=1697 
                                           
locret_7138:                               ; OLine=1699
                                           
                 RTS                       ; OLine=1701 
                                           ;  End of function sub_7125
                                           
                                           
                                           ;  ¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦ S U B R O U T I N E ¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦
                                           
                                           
sub_7139:                                  ; OLine=1708
                 LDX      #$1C             ; OLine=1709 
                                           
loc_713B:                                  ; OLine=1711
                 LDA      $200,X           ; OLine=1712 
                 BEQ      loc_715E         ; OLine=1713
                 LDA      $269,X           ; OLine=1714
                 SEC                       ; OLine=1715 
                 SBC      $284             ; OLine=1716
                 CMP      #4               ; OLine=1717 
                 BCC      loc_714F         ; OLine=1718
                 CMP      #$FC             ; OLine=1719
                 BCC      loc_715E         ; OLine=1720 
                                           
loc_714F:                                  ; OLine=1722
                 LDA      $28C,X           ; OLine=1723 
                 SEC                       ; OLine=1724
                 SBC      $2A7             ; OLine=1725
                 CMP      #4               ; OLine=1726 
                 BCC      loc_7163         ; OLine=1727
                 CMP      #$FC             ; OLine=1728
                 BCS      loc_7163         ; OLine=1729 
                                           
loc_715E:                                  ; OLine=1731
                                           
                 DEX                       ; OLine=1733 
                 BPL      loc_713B         ; OLine=1734
                 INX                       ; OLine=1735
                 RTS                       ; OLine=1736 
                                           ;  ---------------------------------------------------------------------------
                                           
loc_7163:                                  ; OLine=1739
                                           
                 INC      $2FA             ; OLine=1741 
                 RTS                       ; OLine=1742 
                                           ;  End of function sub_7139
                                           
                                           ;  ---------------------------------------------------------------------------
                 .BYTE    $90              ; OLine=1746
                                           
                                           ;  ¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦ S U B R O U T I N E ¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦
                                           
                                           
sub_7168:                                  ; OLine=1751
                                           
                 LDX      #$1A             ; OLine=1753 
                 LDA      $2FB             ; OLine=1754
                 BNE      loc_71DF         ; OLine=1755
                 LDA      $21C             ; OLine=1756  Saucer Flag
                 BNE      locret_71E7      ; OLine=1757  Branch If Saucer Is Currently Active
                 STA      $23F             ; OLine=1758
                 STA      $262             ; OLine=1759
                 INC      $2FD             ; OLine=1760
                 LDA      $2FD             ; OLine=1761 
                 CMP      #$B              ; OLine=1762
                 BCC      loc_7187         ; OLine=1763
                 DEC      $2FD             ; OLine=1764 
                                           
loc_7187:                                  ; OLine=1766
                 LDA      $2F5             ; OLine=1767 
                 CLC                       ; OLine=1768
                 ADC      #2               ; OLine=1769
                 CMP      #$B              ; OLine=1770
                 BCC      loc_7193         ; OLine=1771 
                 LDA      #$B              ; OLine=1772 
                                           
loc_7193:                                  ; OLine=1774
                 STA      $2F6             ; OLine=1775 
                 STA      $2F5             ; OLine=1776
                 STA      8                ; OLine=1777 
                 LDY      #$1C             ; OLine=1778 
                                           
loc_719D:                                  ; OLine=1780
                 JSR      sub_77B5         ; OLine=1781 
                 AND      #$18             ; OLine=1782
                 ORA      #4               ; OLine=1783 
                 STA      $200,X           ; OLine=1784
                 JSR      sub_7203         ; OLine=1785
                 JSR      sub_77B5         ; OLine=1786 
                 LSR      A                ; OLine=1787
                 AND      #$1F             ; OLine=1788
                 BCC      loc_71C5         ; OLine=1789 
                 CMP      #$18             ; OLine=1790
                 BCC      loc_71B8         ; OLine=1791
                 AND      #$17             ; OLine=1792 
                                           
loc_71B8:                                  ; OLine=1794
                 STA      $28C,X           ; OLine=1795 
                 LDA      #0               ; OLine=1796
                 STA      $269,X           ; OLine=1797
                 STA      $2AF,X           ; OLine=1798 
                 BEQ      loc_71D0         ; OLine=1799 
                                           
loc_71C5:                                  ; OLine=1801
                 STA      $269,X           ; OLine=1802 
                 LDA      #0               ; OLine=1803
                 STA      $28C,X           ; OLine=1804 
                 STA      $2D2,X           ; OLine=1805 
                                           
loc_71D0:                                  ; OLine=1807
                 DEX                       ; OLine=1808
                 DEC      8                ; OLine=1809 
                 BNE      loc_719D         ; OLine=1810
                 LDA      #$7F             ; OLine=1811
                 STA      $2F7             ; OLine=1812  Countdown Timer For When Saucer Appears
                 LDA      #$30             ; OLine=1813
                 STA      $2FC             ; OLine=1814  Starting Value For Timer @ $6E
                                           
loc_71DF:                                  ; OLine=1816
                 LDA      #0               ; OLine=1817 
                                           
loc_71E1:                                  ; OLine=1819
                 STA      $200,X           ; OLine=1820 
                 DEX                       ; OLine=1821
                 BPL      loc_71E1         ; OLine=1822 
                                           
locret_71E7:                               ; OLine=1824
                 RTS                       ; OLine=1825 
                                           ;  End of function sub_7168
                                           
                                           
                                           ;  ¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦ S U B R O U T I N E ¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦
                                           
                                           
sub_71E8:                                  ; OLine=1832
                                           
                 LDA      #$60             ; OLine=1834 
                 STA      $2CA             ; OLine=1835
                 STA      $2ED             ; OLine=1836
                 LDA      #0               ; OLine=1837
                 STA      $23E             ; OLine=1838 
                 STA      $261             ; OLine=1839
                 LDA      #$10             ; OLine=1840
                 STA      $284             ; OLine=1841
                 LDA      #$C              ; OLine=1842 
                 STA      $2A7             ; OLine=1843
                 RTS                       ; OLine=1844 
                                           ;  End of function sub_71E8
                                           
                                           
                                           ;  ¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦ S U B R O U T I N E ¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦
                                           
                                           
sub_7203:                                  ; OLine=1851
                                           
                 JSR      sub_77B5         ; OLine=1853 
                 AND      #$8F             ; OLine=1854
                 BPL      loc_720C         ; OLine=1855
                 ORA      #$F0             ; OLine=1856 
                                           
loc_720C:                                  ; OLine=1858
                 CLC                       ; OLine=1859
                 ADC      $223,Y           ; OLine=1860
                 JSR      sub_7233         ; OLine=1861 
                 STA      $223,X           ; OLine=1862
                 JSR      sub_77B5         ; OLine=1863
                 JSR      sub_77B5         ; OLine=1864 
                 JSR      sub_77B5         ; OLine=1865
                 JSR      sub_77B5         ; OLine=1866
                 AND      #$8F             ; OLine=1867 
                 BPL      loc_7228         ; OLine=1868
                 ORA      #$F0             ; OLine=1869 
                                           
loc_7228:                                  ; OLine=1871
                 CLC                       ; OLine=1872 
                 ADC      $246,Y           ; OLine=1873
                 JSR      sub_7233         ; OLine=1874 
                 STA      $246,X           ; OLine=1875
                 RTS                       ; OLine=1876 
                                           ;  End of function sub_7203
                                           
                                           
                                           ;  ¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦ S U B R O U T I N E ¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦
                                           
                                           
sub_7233:                                  ; OLine=1883
                                           
                 BPL      loc_7242         ; OLine=1885 
                 CMP      #$E1             ; OLine=1886
                 BCS      loc_723B         ; OLine=1887
                 LDA      #$E1             ; OLine=1888 
                                           
loc_723B:                                  ; OLine=1890
                 CMP      #$FB             ; OLine=1891 
                 BCC      locret_724E      ; OLine=1892
                 LDA      #$FA             ; OLine=1893 
                 RTS                       ; OLine=1894 
                                           ;  ---------------------------------------------------------------------------
                                           
loc_7242:                                  ; OLine=1897
                 CMP      #6               ; OLine=1898 
                 BCS      loc_7248         ; OLine=1899
                 LDA      #6               ; OLine=1900 
                                           
loc_7248:                                  ; OLine=1902
                 CMP      #$20             ; OLine=1903 
                 BCC      locret_724E      ; OLine=1904
                 LDA      #$1F             ; OLine=1905 
                                           
locret_724E:                               ; OLine=1907
                                           
                 RTS                       ; OLine=1909 
                                           ;  End of function sub_7233
                                           
                                           
                                           ;  ¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦ S U B R O U T I N E ¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦
                                           
                                           
sub_724F:                                  ; OLine=1916
                 LDA      #$10             ; OLine=1917 
                 STA      0                ; OLine=1918
                 LDA      #$50             ; OLine=1919 
                 LDX      #$A4             ; OLine=1920
                 JSR      sub_7BFC         ; OLine=1921
                 LDA      #$19             ; OLine=1922 
                 LDX      #$DB             ; OLine=1923
                 JSR      sub_7C03         ; OLine=1924
                 LDA      #$70             ; OLine=1925
                 JSR      sub_7CDE         ; OLine=1926
                 LDX      #0               ; OLine=1927
                 LDA      $1C              ; OLine=1928  Number Of Players In Current Game
                 CMP      #2               ; OLine=1929  2 Players?
                 BNE      loc_7286         ; OLine=1930  No, Branch
                 LDA      $18              ; OLine=1931  Current Player
                 BNE      loc_7286         ; OLine=1932  Player 2? Yes, Branch
                 LDX      #$20             ; OLine=1933 
                 LDA      $21B             ; OLine=1934  Player Flag
                 ORA      $59              ; OLine=1935  Hyperspace Flag
                 BNE      loc_7286         ; OLine=1936 
                 LDA      $2FA             ; OLine=1937
                 BMI      loc_7286         ; OLine=1938 
                 LDA      $5C              ; OLine=1939  Fast Timer
                 AND      #$10             ; OLine=1940 
                 BEQ      loc_7293         ; OLine=1941 
                                           
loc_7286:                                  ; OLine=1943
                                           
                 LDA      #$52             ; OLine=1945 
                 LDY      #2               ; OLine=1946
                 SEC                       ; OLine=1947 
                 JSR      sub_773F         ; OLine=1948
                 LDA      #0               ; OLine=1949 
                 JSR      sub_778B         ; OLine=1950
                                           
loc_7293:                                  ; OLine=1952
                 LDA      #$28             ; OLine=1953 
                 LDY      $57              ; OLine=1954  Number Of Ships Remaining, Player 1
                 JSR      sub_6F3E         ; OLine=1955
                 LDA      #0               ; OLine=1956
                 STA      0                ; OLine=1957
                 LDA      #$78             ; OLine=1958 
                 LDX      #$DB             ; OLine=1959
                 JSR      sub_7C03         ; OLine=1960
                 LDA      #$50             ; OLine=1961
                 JSR      sub_7CDE         ; OLine=1962
                 LDA      #$1D             ; OLine=1963
                 LDY      #2               ; OLine=1964 
                 SEC                       ; OLine=1965
                 JSR      sub_773F         ; OLine=1966 
                 LDA      #0               ; OLine=1967
                 JSR      sub_7BD1         ; OLine=1968 
                 LDA      #$10             ; OLine=1969
                 STA      0                ; OLine=1970
                 LDA      #$C0             ; OLine=1971 
                 LDX      #$DB             ; OLine=1972
                 JSR      sub_7C03         ; OLine=1973
                 LDA      #$50             ; OLine=1974
                 JSR      sub_7CDE         ; OLine=1975 
                 LDX      #0               ; OLine=1976 
                 LDA      $1C              ; OLine=1977  Number Of Players In Current Game
                 CMP      #1               ; OLine=1978  Only 1 Player?
                 BEQ      locret_72FD      ; OLine=1979  Yes, Branch
                 BCC      loc_72E9         ; OLine=1980 
                 LDA      $18              ; OLine=1981  Current Player
                 BEQ      loc_72E9         ; OLine=1982  Branch If Player 1
                 LDX      #$20             ; OLine=1983 
                 LDA      $21B             ; OLine=1984  Player Flag
                 ORA      $59              ; OLine=1985  Hyperspace Flag
                 BNE      loc_72E9         ; OLine=1986
                 LDA      $2FA             ; OLine=1987 
                 BMI      loc_72E9         ; OLine=1988
                 LDA      $5C              ; OLine=1989  Fast Timer
                 AND      #$10             ; OLine=1990 
                 BEQ      loc_72F6         ; OLine=1991 
                                           
loc_72E9:                                  ; OLine=1993
                                           
                 LDA      #$54             ; OLine=1995 
                 LDY      #2               ; OLine=1996
                 SEC                       ; OLine=1997
                 JSR      sub_773F         ; OLine=1998 
                 LDA      #0               ; OLine=1999
                 JSR      sub_778B         ; OLine=2000
                                           
loc_72F6:                                  ; OLine=2002
                 LDA      #$CF             ; OLine=2003 
                 LDY      $58              ; OLine=2004  Current Number Of Ships, Player 2
                 JMP      sub_6F3E         ; OLine=2005 
                                           ;  ---------------------------------------------------------------------------
                                           
locret_72FD:                               ; OLine=2008
                 RTS                       ; OLine=2009 
                                           ;  End of function sub_724F
                                           
                                           
                                           ;  ¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦ S U B R O U T I N E ¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦
                                           
                                           
sub_72FE:                                  ; OLine=2016
                 STY      0                ; OLine=2017 
                 STX      $D               ; OLine=2018
                 LDA      5                ; OLine=2019
                 LSR      A                ; OLine=2020
                 ROR      4                ; OLine=2021
                 LSR      A                ; OLine=2022 
                 ROR      4                ; OLine=2023
                 LSR      A                ; OLine=2024
                 ROR      4                ; OLine=2025
                 STA      5                ; OLine=2026 
                 LDA      7                ; OLine=2027
                 CLC                       ; OLine=2028
                 ADC      #4               ; OLine=2029
                 LSR      A                ; OLine=2030 
                 ROR      6                ; OLine=2031
                 LSR      A                ; OLine=2032
                 ROR      6                ; OLine=2033
                 LSR      A                ; OLine=2034
                 ROR      6                ; OLine=2035 
                 STA      7                ; OLine=2036
                 LDX      #4               ; OLine=2037
                 JSR      sub_7C1C         ; OLine=2038 
                 LDA      #$70             ; OLine=2039
                 SEC                       ; OLine=2040
                 SBC      0                ; OLine=2041
                 CMP      #$A0             ; OLine=2042 
                 BCC      loc_733B         ; OLine=2043 
                                           
loc_732D:                                  ; OLine=2045
                 PHA                       ; OLine=2046 
                 LDA      #$90             ; OLine=2047
                 JSR      sub_7CDE         ; OLine=2048 
                 PLA                       ; OLine=2049
                 SEC                       ; OLine=2050 
                 SBC      #$10             ; OLine=2051
                 CMP      #$A0             ; OLine=2052 
                 BCS      loc_732D         ; OLine=2053 
                                           
loc_733B:                                  ; OLine=2055
                 JSR      sub_7CDE         ; OLine=2056 
                 LDX      $D               ; OLine=2057
                 LDA      $200,X           ; OLine=2058
                 BPL      loc_735B         ; OLine=2059 
                 CPX      #$1B             ; OLine=2060
                 BEQ      loc_7355         ; OLine=2061
                 AND      #$C              ; OLine=2062
                 LSR      A                ; OLine=2063 
                 TAY                       ; OLine=2064
                 LDA      $50F8,Y          ; OLine=2065
                 LDX      $50F9,Y          ; OLine=2066
                 BNE      loc_7370         ; OLine=2067 
                                           
loc_7355:                                  ; OLine=2069
                 JSR      sub_7465         ; OLine=2070 
                 LDX      $D               ; OLine=2071
                 RTS                       ; OLine=2072 
                                           ;  ---------------------------------------------------------------------------
                                           
loc_735B:                                  ; OLine=2075
                 CPX      #$1B             ; OLine=2076 
                 BEQ      loc_7376         ; OLine=2077
                 CPX      #$1C             ; OLine=2078
                 BEQ      loc_737C         ; OLine=2079
                 BCS      loc_7384         ; OLine=2080 
                 AND      #$18             ; OLine=2081
                 LSR      A                ; OLine=2082
                 LSR      A                ; OLine=2083
                 TAY                       ; OLine=2084 
                 LDA      $51DE,Y          ; OLine=2085
                 LDX      $51DF,Y          ; OLine=2086 
                                           
loc_7370:                                  ; OLine=2088
                                           
                 JSR      sub_7D45         ; OLine=2090 
                 LDX      $D               ; OLine=2091
                 RTS                       ; OLine=2092 
                                           ;  ---------------------------------------------------------------------------
                                           
loc_7376:                                  ; OLine=2095
                 JSR      sub_750B         ; OLine=2096 
                 LDX      $D               ; OLine=2097
                 RTS                       ; OLine=2098 
                                           ;  ---------------------------------------------------------------------------
                                           
loc_737C:                                  ; OLine=2101
                 LDA      $5250            ; OLine=2102 
                 LDX      $5251            ; OLine=2103
                 BNE      loc_7370         ; OLine=2104 
                                           
loc_7384:                                  ; OLine=2106
                 LDA      #$70             ; OLine=2107 
                 LDX      #$F0             ; OLine=2108
                 JSR      sub_7CE0         ; OLine=2109 
                 LDX      $D               ; OLine=2110
                 LDA      $5C              ; OLine=2111  Fast Timer
                 AND      #3               ; OLine=2112
                 BNE      locret_7396      ; OLine=2113 
                 DEC      $200,X           ; OLine=2114
                                           
locret_7396:                               ; OLine=2116
                 RTS                       ; OLine=2117 
                                           ;  End of function sub_72FE
                                           
                                           
                                           ;  ¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦ S U B R O U T I N E ¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦
                                           
                                           
sub_7397:                                  ; OLine=2124
                                           
                 SED                       ; OLine=2126  Set Decimal Mode
                 ADC      $52,X            ; OLine=2127  Add To Current Players Score, Tens
                 STA      $52,X            ; OLine=2128 
                 BCC      loc_73B0         ; OLine=2129  Increase In Thousands?, No, Branch
                 LDA      $53,X            ; OLine=2130  Current Players Score, Thousands
                 ADC      #0               ; OLine=2131  Add In The Carry
                 STA      $53,X            ; OLine=2132
                 AND      #$F              ; OLine=2133  Will Be 0 If Another 10,000 Points Reached
                 BNE      loc_73B0         ; OLine=2134  Branch If Not Enough Points For Bonus Ship
                 LDA      #$B0             ; OLine=2135  Length Of Time To Play Bonus Ship Sound
                 STA      $68              ; OLine=2136  Into Timer
                 LDX      $18              ; OLine=2137  Current Player
                 INC      $57,X            ; OLine=2138  Award Bonus Ship
                                           
loc_73B0:                                  ; OLine=2140
                                           
                 CLD                       ; OLine=2142  Clear Decimal Mode
                 RTS                       ; OLine=2143 
                                           ;  End of function sub_7397
                                           
                                           
                                           ;  ¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦ S U B R O U T I N E ¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦
                                           
                                           
sub_73B2:                                  ; OLine=2150
                                           
                 LDA      $18              ; OLine=2152  Current Player
                 ASL      A                ; OLine=2153
                 ASL      A                ; OLine=2154
                 STA      8                ; OLine=2155
                 LDA      $6F              ; OLine=2156
                 AND      #$FB             ; OLine=2157
                 ORA      8                ; OLine=2158 
                 STA      $6F              ; OLine=2159
                 STA      $3200            ; OLine=2160
                 RTS                       ; OLine=2161 
                                           ;  End of function sub_73B2
                                           
                                           
                                           ;  ¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦ S U B R O U T I N E ¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦
                                           
                                           
sub_73C4:                                  ; OLine=2168
                 LDA      $1C              ; OLine=2169  Number Of Players In Current Game
                 BEQ      loc_73CA         ; OLine=2170  None, Branch
                                           
loc_73C8:                                  ; OLine=2172
                                           
                 CLC                       ; OLine=2174 
                 RTS                       ; OLine=2175
                                           
loc_73CA:                                  ; OLine=2177
                 LDA      $5D              ; OLine=2178  Slow Timer
                 AND      #4               ; OLine=2179
                 BNE      loc_73C8         ; OLine=2180
                 LDA      $1D              ; OLine=2181  Highest Score In Table
                 ORA      $1E              ; OLine=2182
                 BEQ      loc_73C8         ; OLine=2183  Table Empty, Branch
                 LDY      #0               ; OLine=2184  Offset To "HIGH SCORE"
                 JSR      sub_77F6         ; OLine=2185  And Draw To Screen
                 LDX      #0               ; OLine=2186
                 STX      $10              ; OLine=2187
                 LDA      #1               ; OLine=2188
                 STA      0                ; OLine=2189 
                 LDA      #$A7             ; OLine=2190
                 STA      $E               ; OLine=2191
                 LDA      #$10             ; OLine=2192
                 STA      0                ; OLine=2193 
                                           
loc_73EB:                                  ; OLine=2195
                 LDA      $1D,X            ; OLine=2196  High Score Table
                 ORA      $1E,X            ; OLine=2197 
                 BEQ      loc_7458         ; OLine=2198  No Score In This Entry, Branch
                 STX      $F               ; OLine=2199
                 LDA      #$5F             ; OLine=2200 
                 LDX      $E               ; OLine=2201
                 JSR      sub_7C03         ; OLine=2202
                 LDA      #$40             ; OLine=2203
                 JSR      sub_7CDE         ; OLine=2204 
                 LDA      $F               ; OLine=2205
                 LSR      A                ; OLine=2206
                 SED                       ; OLine=2207  Set Decimal Mode
                 ADC      #1               ; OLine=2208 
                 CLD                       ; OLine=2209  Clear Decimal Mode
                 STA      $D               ; OLine=2210
                 LDA      #$D              ; OLine=2211
                 SEC                       ; OLine=2212 
                 LDY      #1               ; OLine=2213
                 LDX      #0               ; OLine=2214
                 JSR      sub_773F         ; OLine=2215
                 LDA      #$40             ; OLine=2216 
                 TAX                       ; OLine=2217
                 JSR      sub_7CE0         ; OLine=2218
                 LDY      #0               ; OLine=2219
                 JSR      sub_6F35         ; OLine=2220 
                 LDA      $F               ; OLine=2221
                 CLC                       ; OLine=2222
                 ADC      #$1D             ; OLine=2223
                 LDY      #2               ; OLine=2224 
                 SEC                       ; OLine=2225
                 LDX      #0               ; OLine=2226
                 JSR      sub_773F         ; OLine=2227
                 LDA      #0               ; OLine=2228 
                 JSR      sub_7BD1         ; OLine=2229
                 LDY      #0               ; OLine=2230
                 JSR      sub_6F35         ; OLine=2231
                 LDY      $10              ; OLine=2232 
                 JSR      sub_6F1A         ; OLine=2233
                 INC      $10              ; OLine=2234
                 LDY      $10              ; OLine=2235
                 JSR      sub_6F1A         ; OLine=2236 
                 INC      $10              ; OLine=2237
                 LDY      $10              ; OLine=2238
                 JSR      sub_6F1A         ; OLine=2239
                 INC      $10              ; OLine=2240 
                 LDA      $E               ; OLine=2241
                 SEC                       ; OLine=2242
                 SBC      #8               ; OLine=2243
                 STA      $E               ; OLine=2244 
                 LDX      $F               ; OLine=2245 
                 INX                       ; OLine=2246 
                 INX                       ; OLine=2247  Point To Next Entry In Table
                 CPX      #$14             ; OLine=2248  End Of Table?
                 BCC      loc_73EB         ; OLine=2249  No, Branch
                                           
loc_7458:                                  ; OLine=2251
                 SEC                       ; OLine=2252
                 RTS                       ; OLine=2253 
                                           ;  End of function sub_73C4
                                           
                                           
                                           ;  ¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦ S U B R O U T I N E ¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦
                                           
                                           
sub_745A:                                  ; OLine=2260
                 LDX      #$1A             ; OLine=2261 
                                           ;  End of function sub_745A
                                           
                                           
                                           ;  ¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦ S U B R O U T I N E ¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦
                                           
                                           
sub_745C:                                  ; OLine=2268
                                           
                 LDA      $200,X           ; OLine=2270 
                 BEQ      locret_7464      ; OLine=2271
                 DEX                       ; OLine=2272
                 BPL      sub_745C         ; OLine=2273 
                                           
locret_7464:                               ; OLine=2275
                 RTS                       ; OLine=2276 
                                           ;  End of function sub_745C
                                           
                                           
                                           ;  ¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦ S U B R O U T I N E ¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦
                                           
                                           
sub_7465:                                  ; OLine=2283
                 LDA      $21B             ; OLine=2284 
                 CMP      #$A2             ; OLine=2285
                 BCS      loc_748E         ; OLine=2286 
                 LDX      #$A              ; OLine=2287
                                           
loc_746E:                                  ; OLine=2289
                 LDA      $50EC,X          ; OLine=2290 
                 LSR      A                ; OLine=2291
                 LSR      A                ; OLine=2292
                 LSR      A                ; OLine=2293
                 LSR      A                ; OLine=2294
                 CLC                       ; OLine=2295 
                 ADC      #$F8             ; OLine=2296
                 EOR      #$F8             ; OLine=2297
                 STA      $7E,X            ; OLine=2298
                 LDA      $50ED,X          ; OLine=2299 
                 LSR      A                ; OLine=2300
                 LSR      A                ; OLine=2301
                 LSR      A                ; OLine=2302
                 LSR      A                ; OLine=2303 
                 CLC                       ; OLine=2304
                 ADC      #$F8             ; OLine=2305
                 EOR      #$F8             ; OLine=2306
                 STA      $8A,X            ; OLine=2307 
                 DEX                       ; OLine=2308
                 DEX                       ; OLine=2309
                 BPL      loc_746E         ; OLine=2310 
                                           
loc_748E:                                  ; OLine=2312
                 LDA      $21B             ; OLine=2313 
                 EOR      #$FF             ; OLine=2314
                 AND      #$70             ; OLine=2315
                 LSR      A                ; OLine=2316 
                 LSR      A                ; OLine=2317
                 LSR      A                ; OLine=2318
                 TAX                       ; OLine=2319 
                                           
loc_7499:                                  ; OLine=2321
                 STX      9                ; OLine=2322
                 LDY      #0               ; OLine=2323 
                 LDA      $50EC,X          ; OLine=2324
                 BPL      loc_74A3         ; OLine=2325
                 DEY                       ; OLine=2326 
                                           
loc_74A3:                                  ; OLine=2328
                 CLC                       ; OLine=2329 
                 ADC      $7D,X            ; OLine=2330
                 STA      $7D,X            ; OLine=2331
                 TYA                       ; OLine=2332 
                 ADC      $7E,X            ; OLine=2333
                 STA      $7E,X            ; OLine=2334
                 STA      4                ; OLine=2335
                 STY      5                ; OLine=2336 
                 LDY      #0               ; OLine=2337
                 LDA      $50ED,X          ; OLine=2338
                 BPL      loc_74B9         ; OLine=2339
                 DEY                       ; OLine=2340 
                                           
loc_74B9:                                  ; OLine=2342
                 CLC                       ; OLine=2343 
                 ADC      $89,X            ; OLine=2344
                 STA      $89,X            ; OLine=2345
                 TYA                       ; OLine=2346
                 ADC      $8A,X            ; OLine=2347 
                 STA      $8A,X            ; OLine=2348
                 STA      6                ; OLine=2349
                 STY      7                ; OLine=2350
                 LDA      2                ; OLine=2351 
                 STA      $B               ; OLine=2352
                 LDA      3                ; OLine=2353
                 STA      $C               ; OLine=2354
                 JSR      sub_7C49         ; OLine=2355 
                 LDY      9                ; OLine=2356
                 LDA      $50E0,Y          ; OLine=2357
                 LDX      $50E1,Y          ; OLine=2358
                 JSR      sub_7D45         ; OLine=2359 
                 LDY      9                ; OLine=2360
                 LDA      $50E1,Y          ; OLine=2361
                 EOR      #4               ; OLine=2362
                 TAX                       ; OLine=2363 
                 LDA      $50E0,Y          ; OLine=2364
                 AND      #$F              ; OLine=2365
                 EOR      #4               ; OLine=2366
                 JSR      sub_7D45         ; OLine=2367 
                 LDY      #$FF             ; OLine=2368 
                                           
loc_74F1:                                  ; OLine=2370
                 INY                       ; OLine=2371 
                 LDA      ($B),Y           ; OLine=2372
                 STA      (2),Y            ; OLine=2373
                 INY                       ; OLine=2374
                 LDA      ($B),Y           ; OLine=2375 
                 EOR      #4               ; OLine=2376
                 STA      (2),Y            ; OLine=2377
                 CPY      #3               ; OLine=2378
                 BCC      loc_74F1         ; OLine=2379 
                 JSR      sub_7C39         ; OLine=2380
                 LDX      9                ; OLine=2381
                 DEX                       ; OLine=2382
                 DEX                       ; OLine=2383 
                 BPL      loc_7499         ; OLine=2384
                 RTS                       ; OLine=2385 
                                           ;  End of function sub_7465
                                           
                                           
                                           ;  ¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦ S U B R O U T I N E ¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦
                                           
                                           
sub_750B:                                  ; OLine=2392
                 LDX      #0               ; OLine=2393 
                 STX      $17              ; OLine=2394 
                 LDY      #0               ; OLine=2395 
                 LDA      $61              ; OLine=2396  Ship Direction
                 BPL      loc_751B         ; OLine=2397 
                 LDY      #4               ; OLine=2398
                 TXA                       ; OLine=2399
                 SEC                       ; OLine=2400
                 SBC      $61              ; OLine=2401 
                                           
loc_751B:                                  ; OLine=2403
                 STA      8                ; OLine=2404 
                 BIT      8                ; OLine=2405
                 BMI      loc_7523         ; OLine=2406
                 BVC      loc_752A         ; OLine=2407 
                                           
loc_7523:                                  ; OLine=2409
                 LDX      #4               ; OLine=2410 
                 LDA      #$80             ; OLine=2411
                 SEC                       ; OLine=2412
                 SBC      8                ; OLine=2413 
                                           
loc_752A:                                  ; OLine=2415
                 STX      8                ; OLine=2416 
                 STY      9                ; OLine=2417
                 LSR      A                ; OLine=2418
                 AND      #$FE             ; OLine=2419
                 TAY                       ; OLine=2420 
                 LDA      $526E,Y          ; OLine=2421
                 LDX      $526F,Y          ; OLine=2422
                 JSR      sub_6AD3         ; OLine=2423
                 LDA      $2405            ; OLine=2424  Thrust Switch
                 BPL      locret_7554      ; OLine=2425  Branch If NOT Pressed
                 LDA      $5C              ; OLine=2426  Fast Timer
                 AND      #4               ; OLine=2427
                 BEQ      locret_7554      ; OLine=2428 
                 INY                       ; OLine=2429
                 INY                       ; OLine=2430
                 SEC                       ; OLine=2431
                 LDX      $C               ; OLine=2432 
                 TYA                       ; OLine=2433
                 ADC      $B               ; OLine=2434
                 BCC      loc_7551         ; OLine=2435
                 INX                       ; OLine=2436 
                                           
loc_7551:                                  ; OLine=2438
                 JSR      sub_6AD3         ; OLine=2439 
                                           
locret_7554:                               ; OLine=2441
                                           
                 RTS                       ; OLine=2443 
                                           ;  End of function sub_750B
                                           
                                           
                                           ;  ¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦ S U B R O U T I N E ¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦
                                           
                                           
sub_7555:                                  ; OLine=2450
                 LDA      $1C              ; OLine=2451  Number Of Players In Current Game
                 BNE      loc_755A         ; OLine=2452  Branch If At Least 1 Player Left
                 RTS                       ; OLine=2453 
                                           ;  ---------------------------------------------------------------------------
                                           
loc_755A:                                  ; OLine=2456
                 LDX      #0               ; OLine=2457 
                 LDA      $21C             ; OLine=2458  Saucer Flag
                 BMI      loc_756B         ; OLine=2459  Currently Exploding, Branch
                 BEQ      loc_756B         ; OLine=2460  No Active Saucer, Branch
                 ROR      A                ; OLine=2461
                 ROR      A                ; OLine=2462
                 ROR      A                ; OLine=2463
                 STA      $3C02            ; OLine=2464  Saucer Sound Select
                 LDX      #$80             ; OLine=2465
                                           
loc_756B:                                  ; OLine=2467
                                           
                 STX      $3C00            ; OLine=2469  Saucer Sound
                 LDX      #1               ; OLine=2470
                 JSR      sub_75CD         ; OLine=2471
                 STA      $3C01            ; OLine=2472  Saucer Fire Sound
                 DEX                       ; OLine=2473
                 JSR      sub_75CD         ; OLine=2474
                 STA      $3C04            ; OLine=2475  Ship Fire Sound
                 LDA      $21B             ; OLine=2476
                 CMP      #1               ; OLine=2477
                 BEQ      loc_7588         ; OLine=2478
                 TXA                       ; OLine=2479
                 STA      $3C03            ; OLine=2480  Ship Thrust Sound
                                           
loc_7588:                                  ; OLine=2482
                 LDA      $2F6             ; OLine=2483 
                 BEQ      loc_759E         ; OLine=2484 
                 LDA      $21B             ; OLine=2485  Player Flag
                 BMI      loc_759E         ; OLine=2486  Currently Exploding, Branch
                 ORA      $59              ; OLine=2487  Hyperspace Flag
                 BEQ      loc_759E         ; OLine=2488 
                 LDA      $6D              ; OLine=2489 
                 BEQ      loc_75AE         ; OLine=2490 
                 DEC      $6D              ; OLine=2491 
                 BNE      loc_75BF         ; OLine=2492 
                                           
loc_759E:                                  ; OLine=2494
                                           
                 LDA      $6C              ; OLine=2496  Current Volume And Frequency Of THUMP Sound
                 AND      #$F              ; OLine=2497  Mask Off Frequency Control
                 STA      $6C              ; OLine=2498
                 STA      $3A00            ; OLine=2499  Turn Off Volume, Retain Current Frequency
                 LDA      $2FC             ; OLine=2500 
                 STA      $6E              ; OLine=2501
                 BPL      loc_75BF         ; OLine=2502 
                                           
loc_75AE:                                  ; OLine=2504
                 DEC      $6E              ; OLine=2505 
                 BNE      loc_75BF         ; OLine=2506
                 LDA      #4               ; OLine=2507
                 STA      $6D              ; OLine=2508
                 LDA      $6C              ; OLine=2509 
                 EOR      #$14             ; OLine=2510  Turn On Volume, Switch Frequency
                 STA      $6C              ; OLine=2511  Store It In Current Settings
                 STA      $3A00            ; OLine=2512  Make The Change
                                           
loc_75BF:                                  ; OLine=2514
                                           
                 LDA      $69              ; OLine=2516 
                 TAX                       ; OLine=2517
                 AND      #$3F             ; OLine=2518
                 BEQ      loc_75C7         ; OLine=2519
                 DEX                       ; OLine=2520 
                                           
loc_75C7:                                  ; OLine=2522
                 STX      $69              ; OLine=2523 
                 STX      $3600            ; OLine=2524  Explosion Pitch/Volume
                 RTS                       ; OLine=2525 
                                           ;  End of function sub_7555
                                           
                                           
                                           ;  ¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦ S U B R O U T I N E ¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦
                                           
                                           ;  Fire Sound Handling
                                           
                                           
sub_75CD:                                  ; OLine=2534
                                           
                 LDA      $6A,X            ; OLine=2536  X = 0 Ship Fire, X = 1 Saucer Fire
                 BMI      loc_75DD         ; OLine=2537
                 LDA      $66,X            ; OLine=2538
                 BPL      loc_75E7         ; OLine=2539 
                 LDA      #$10             ; OLine=2540
                 STA      $66,X            ; OLine=2541  TIMER: Length Of Time Sound Is On
                                           
loc_75D9:                                  ; OLine=2543
                 LDA      #$80             ; OLine=2544  Turn Fire Sound On
                 BMI      loc_75E9         ; OLine=2545  Will Always Branch
                                           
loc_75DD:                                  ; OLine=2547
                 LDA      $66,X            ; OLine=2548 
                 BEQ      loc_75E7         ; OLine=2549
                 BMI      loc_75E7         ; OLine=2550
                 DEC      $66,X            ; OLine=2551
                 BNE      loc_75D9         ; OLine=2552 
                                           
loc_75E7:                                  ; OLine=2554
                                           
                 LDA      #0               ; OLine=2556  Turn Fire Sound Off
                                           
loc_75E9:                                  ; OLine=2558
                 STA      $6A,X            ; OLine=2559 
                 RTS                       ; OLine=2560 
                                           ;  End of function sub_75CD
                                           
                                           
                                           ;  ¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦ S U B R O U T I N E ¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦
                                           
                                           
sub_75EC:                                  ; OLine=2567
                 STX      $D               ; OLine=2568 
                 LDA      #$50             ; OLine=2569
                 STA      $2F9             ; OLine=2570
                 LDA      $200,Y           ; OLine=2571
                 AND      #$78             ; OLine=2572 
                 STA      $E               ; OLine=2573
                 LDA      $200,Y           ; OLine=2574
                 AND      #7               ; OLine=2575
                 LSR      A                ; OLine=2576 
                 TAX                       ; OLine=2577
                 BEQ      loc_7605         ; OLine=2578
                 ORA      $E               ; OLine=2579 
                                           
loc_7605:                                  ; OLine=2581
                 STA      $200,Y           ; OLine=2582 
                 LDA      $1C              ; OLine=2583  Number Of Players In Current Game
                 BEQ      loc_761D         ; OLine=2584  None, Branch
                 LDA      $D               ; OLine=2585
                 BEQ      loc_7614         ; OLine=2586
                 CMP      #4               ; OLine=2587
                 BCC      loc_761D         ; OLine=2588 
                                           
loc_7614:                                  ; OLine=2590
                 LDA      $7659,X          ; OLine=2591 
                 LDX      $19              ; OLine=2592
                 CLC                       ; OLine=2593
                 JSR      sub_7397         ; OLine=2594 
                                           
loc_761D:                                  ; OLine=2596
                                           
                 LDX      $200,Y           ; OLine=2598 
                 BEQ      loc_7656         ; OLine=2599
                 JSR      sub_745A         ; OLine=2600
                 BMI      loc_7656         ; OLine=2601
                 INC      $2F6             ; OLine=2602 
                 JSR      sub_6A9D         ; OLine=2603
                 JSR      sub_7203         ; OLine=2604
                 LDA      $223,X           ; OLine=2605
                 AND      #$1F             ; OLine=2606 
                 ASL      A                ; OLine=2607
                 EOR      $2AF,X           ; OLine=2608
                 STA      $2AF,X           ; OLine=2609
                 JSR      sub_745C         ; OLine=2610 
                 BMI      loc_7656         ; OLine=2611
                 INC      $2F6             ; OLine=2612
                 JSR      sub_6A9D         ; OLine=2613
                 JSR      sub_7203         ; OLine=2614 
                 LDA      $246,X           ; OLine=2615
                 AND      #$1F             ; OLine=2616
                 ASL      A                ; OLine=2617
                 EOR      $2D2,X           ; OLine=2618 
                 STA      $2D2,X           ; OLine=2619 
                                           
loc_7656:                                  ; OLine=2621
                                           
                 LDX      $D               ; OLine=2623 
                 RTS                       ; OLine=2624 
                                           ;  End of function sub_75EC
                                           
                                           ;  ---------------------------------------------------------------------------
                 .BYTE    $10              ; OLine=2628  100 Points
                 .BYTE    5                ; OLine=2629  50 Points
                 .BYTE    2                ; OLine=2630  20 Points
                                           
                                           ;  ¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦ S U B R O U T I N E ¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦
                                           
                                           
sub_765C:                                  ; OLine=2635
                 LDA      $1C              ; OLine=2636  Number Of Players In Current Game
                 BPL      locret_7698      ; OLine=2637
                 LDX      #2               ; OLine=2638 
                 STA      $5D              ; OLine=2639  Slow Timer
                 STA      $32              ; OLine=2640
                 STA      $33              ; OLine=2641 
                                           
loc_7668:                                  ; OLine=2643
                 LDY      #0               ; OLine=2644 
                                           
loc_766A:                                  ; OLine=2646
                 LDA      $1D,Y            ; OLine=2647  High Score Table, Tens
                 CMP      $52,X            ; OLine=2648  Player Score, Tens
                 LDA      $1E,Y            ; OLine=2649  High Score Table, Thousands
                 SBC      $53,X            ; OLine=2650 
                 BCC      loc_7699         ; OLine=2651 
                 INY                       ; OLine=2652
                 INY                       ; OLine=2653
                 CPY      #$14             ; OLine=2654
                 BCC      loc_766A         ; OLine=2655 
                                           
loc_767C:                                  ; OLine=2657
                 DEX                       ; OLine=2658 
                 DEX                       ; OLine=2659
                 BPL      loc_7668         ; OLine=2660
                 LDA      $33              ; OLine=2661
                 BMI      loc_7692         ; OLine=2662 
                 CMP      $32              ; OLine=2663
                 BCC      loc_7692         ; OLine=2664
                 ADC      #2               ; OLine=2665
                 CMP      #$1E             ; OLine=2666 
                 BCC      loc_7690         ; OLine=2667
                 LDA      #$FF             ; OLine=2668 
                                           
loc_7690:                                  ; OLine=2670
                 STA      $33              ; OLine=2671 
                                           
loc_7692:                                  ; OLine=2673
                                           
                 LDA      #0               ; OLine=2675 
                 STA      $1C              ; OLine=2676
                 STA      $31              ; OLine=2677
                                           
locret_7698:                               ; OLine=2679
                 RTS                       ; OLine=2680 
                                           ;  ---------------------------------------------------------------------------
                                           
loc_7699:                                  ; OLine=2683
                 STX      $B               ; OLine=2684 
                 STY      $C               ; OLine=2685
                 TXA                       ; OLine=2686
                 LSR      A                ; OLine=2687
                 TAX                       ; OLine=2688 
                 TYA                       ; OLine=2689
                 LSR      A                ; OLine=2690
                 ADC      $C               ; OLine=2691
                 STA      $D               ; OLine=2692 
                 STA      $32,X            ; OLine=2693
                 LDX      #$1B             ; OLine=2694
                 LDY      #$12             ; OLine=2695 
                                           
loc_76AC:                                  ; OLine=2697
                 CPX      $D               ; OLine=2698 
                 BEQ      loc_76CF         ; OLine=2699
                 LDA      $31,X            ; OLine=2700
                 STA      $34,X            ; OLine=2701
                 LDA      $32,X            ; OLine=2702 
                 STA      $35,X            ; OLine=2703
                 LDA      $33,X            ; OLine=2704
                 STA      $36,X            ; OLine=2705
                 LDA      $1B,Y            ; OLine=2706 
                 STA      $1D,Y            ; OLine=2707
                 LDA      $1C,Y            ; OLine=2708
                 STA      $1E,Y            ; OLine=2709
                 DEY                       ; OLine=2710 
                 DEY                       ; OLine=2711
                 DEX                       ; OLine=2712
                 DEX                       ; OLine=2713
                 DEX                       ; OLine=2714
                 BNE      loc_76AC         ; OLine=2715 
                                           
loc_76CF:                                  ; OLine=2717
                 LDA      #$B              ; OLine=2718 
                 STA      $34,X            ; OLine=2719
                 LDA      #0               ; OLine=2720
                 STA      $35,X            ; OLine=2721
                 STA      $36,X            ; OLine=2722
                 LDA      #$F0             ; OLine=2723 
                 STA      $5D              ; OLine=2724  Slow Timer
                 LDX      $B               ; OLine=2725
                 LDY      $C               ; OLine=2726
                 LDA      $53,X            ; OLine=2727  Players Score, Thousands
                 STA      $1E,Y            ; OLine=2728
                 LDA      $52,X            ; OLine=2729  Players Score, Tens
                 STA      $1D,Y            ; OLine=2730
                 LDY      #0               ; OLine=2731 
                 BEQ      loc_767C         ; OLine=2732
                                           
                 .BYTE    $DF              ; OLine=2734 
                                           ;  ---------------------------------------------------------------------------
loc_76F0:                                  ; OLine=2736
                 TYA                       ; OLine=2737 
                 BPL      loc_76FC         ; OLine=2738 
                                           ;  End of function sub_765C
                                           
                 JSR      sub_7708         ; OLine=2741 
                 JSR      loc_76FC         ; OLine=2742
                 JMP      sub_7708         ; OLine=2743 
                                           ;  ---------------------------------------------------------------------------
                                           
loc_76FC:                                  ; OLine=2746
                                           
                 TAY                       ; OLine=2748 
                 TXA                       ; OLine=2749
                 BPL      sub_770E         ; OLine=2750
                 JSR      sub_7708         ; OLine=2751
                 JSR      sub_770E         ; OLine=2752
                 EOR      #$80             ; OLine=2753 
                                           
                                           ;  ¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦ S U B R O U T I N E ¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦
                                           
                                           
sub_7708:                                  ; OLine=2758
                                           
                 EOR      #$FF             ; OLine=2760 
                 CLC                       ; OLine=2761
                 ADC      #1               ; OLine=2762
                 RTS                       ; OLine=2763 
                                           ;  End of function sub_7708
                                           
                                           
                                           ;  ¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦ S U B R O U T I N E ¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦
                                           
                                           
sub_770E:                                  ; OLine=2770
                                           
                 STA      $C               ; OLine=2772 
                 TYA                       ; OLine=2773
                 CMP      $C               ; OLine=2774
                 BEQ      loc_7725         ; OLine=2775
                 BCC      sub_7728         ; OLine=2776 
                 LDY      $C               ; OLine=2777
                 STA      $C               ; OLine=2778
                 TYA                       ; OLine=2779
                 JSR      sub_7728         ; OLine=2780 
                 SEC                       ; OLine=2781
                 SBC      #$40             ; OLine=2782
                 JMP      sub_7708         ; OLine=2783 
                                           ;  ---------------------------------------------------------------------------
                                           
loc_7725:                                  ; OLine=2786
                 LDA      #$20             ; OLine=2787 
                 RTS                       ; OLine=2788
                                           ;  End of function sub_770E
                                           
                                           
                                           ;  ¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦ S U B R O U T I N E ¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦
                                           
                                           
sub_7728:                                  ; OLine=2795
                                           
                 JSR      sub_776C         ; OLine=2797 
                 LDA      $772F,X          ; OLine=2798
                 RTS                       ; OLine=2799 
                                           ;  End of function sub_7728
                                           
                                           ;  ---------------------------------------------------------------------------
                 .BYTE    0                ; OLine=2803
                 .BYTE    2                ; OLine=2804
                 .BYTE    5                ; OLine=2805
                 .BYTE    7                ; OLine=2806
                 .BYTE    $A               ; OLine=2807
                 .BYTE    $C               ; OLine=2808
                 .BYTE    $F               ; OLine=2809
                 .BYTE    $11              ; OLine=2810
                 .BYTE    $13              ; OLine=2811
                 .BYTE    $15              ; OLine=2812
                 .BYTE    $17              ; OLine=2813
                 .BYTE    $19              ; OLine=2814
                 .BYTE    $1A              ; OLine=2815
                 .BYTE    $1C              ; OLine=2816
                 .BYTE    $1D              ; OLine=2817
                 .BYTE    $1F              ; OLine=2818
                                           
                                           ;  ¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦ S U B R O U T I N E ¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦
                                           
                                           
sub_773F:                                  ; OLine=2823
                                           
                 PHP                       ; OLine=2825 
                 STX      $17              ; OLine=2826
                 DEY                       ; OLine=2827
                 STY      $16              ; OLine=2828
                 CLC                       ; OLine=2829 
                 ADC      $16              ; OLine=2830
                 STA      $15              ; OLine=2831
                 PLP                       ; OLine=2832
                 TAX                       ; OLine=2833 
                                           
loc_774C:                                  ; OLine=2835
                 PHP                       ; OLine=2836 
                 LDA      0,X              ; OLine=2837
                 LSR      A                ; OLine=2838
                 LSR      A                ; OLine=2839
                 LSR      A                ; OLine=2840 
                 LSR      A                ; OLine=2841
                 PLP                       ; OLine=2842
                 JSR      sub_7785         ; OLine=2843
                 LDA      $16              ; OLine=2844 
                 BNE      loc_775C         ; OLine=2845
                 CLC                       ; OLine=2846 
                                           
loc_775C:                                  ; OLine=2848
                 LDX      $15              ; OLine=2849 
                 LDA      0,X              ; OLine=2850
                 JSR      sub_7785         ; OLine=2851
                 DEC      $15              ; OLine=2852
                 LDX      $15              ; OLine=2853 
                 DEC      $16              ; OLine=2854
                 BPL      loc_774C         ; OLine=2855
                 RTS                       ; OLine=2856 
                                           ;  End of function sub_773F
                                           
                                           
                                           ;  ¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦ S U B R O U T I N E ¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦
                                           
                                           
sub_776C:                                  ; OLine=2863
                 LDY      #0               ; OLine=2864 
                 STY      $B               ; OLine=2865
                 LDY      #4               ; OLine=2866 
                                           
loc_7772:                                  ; OLine=2868
                 ROL      $B               ; OLine=2869 
                 ROL      A                ; OLine=2870
                 CMP      $C               ; OLine=2871
                 BCC      loc_777B         ; OLine=2872 
                 SBC      $C               ; OLine=2873 
                                           
loc_777B:                                  ; OLine=2875
                 DEY                       ; OLine=2876 
                 BNE      loc_7772         ; OLine=2877
                 LDA      $B               ; OLine=2878
                 ROL      A                ; OLine=2879
                 AND      #$F              ; OLine=2880 
                 TAX                       ; OLine=2881
                 RTS                       ; OLine=2882 
                                           ;  End of function sub_776C
                                           
                                           
                                           ;  ¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦ S U B R O U T I N E ¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦
                                           
                                           
sub_7785:                                  ; OLine=2889
                                           
                 BCC      sub_778B         ; OLine=2891 
                 AND      #$F              ; OLine=2892
                 BEQ      loc_77B2         ; OLine=2893 
                                           ;  End of function sub_7785
                                           
                                           
                                           ;  ¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦ S U B R O U T I N E ¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦
                                           
                                           
sub_778B:                                  ; OLine=2900
                                           
                 LDX      $17              ; OLine=2902 
                 BEQ      loc_77B2         ; OLine=2903
                 AND      #$F              ; OLine=2904
                 CLC                       ; OLine=2905
                 ADC      #1               ; OLine=2906 
                 PHP                       ; OLine=2907
                 ASL      A                ; OLine=2908
                 TAY                       ; OLine=2909
                 LDA      $56D4,Y          ; OLine=2910 
                 ASL      A                ; OLine=2911
                 STA      $B               ; OLine=2912
                 LDA      $56D5,Y          ; OLine=2913
                 ROL      A                ; OLine=2914 
                 AND      #$1F             ; OLine=2915
                 ORA      #$40             ; OLine=2916
                 STA      $C               ; OLine=2917
                 LDA      #0               ; OLine=2918 
                 STA      8                ; OLine=2919
                 STA      9                ; OLine=2920
                 JSR      sub_6AD7         ; OLine=2921
                 PLP                       ; OLine=2922 
                 RTS                       ; OLine=2923 
                                           ;  ---------------------------------------------------------------------------
                                           
loc_77B2:                                  ; OLine=2926
                                           
                 JMP      loc_7BCB         ; OLine=2928 
                                           ;  End of function sub_778B
                                           
                                           
                                           ;  ¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦ S U B R O U T I N E ¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦
                                           
                                           
sub_77B5:                                  ; OLine=2935
                                           
                 ASL      $5F              ; OLine=2937 
                 ROL      $60              ; OLine=2938
                 BPL      loc_77BD         ; OLine=2939
                 INC      $5F              ; OLine=2940 
                                           
loc_77BD:                                  ; OLine=2942
                 LDA      $5F              ; OLine=2943 
                 BIT      byte_77D1        ; OLine=2944
                 BEQ      loc_77C8         ; OLine=2945 
                 EOR      #1               ; OLine=2946
                 STA      $5F              ; OLine=2947 
                                           
loc_77C8:                                  ; OLine=2949
                 ORA      $60              ; OLine=2950 
                 BNE      loc_77CE         ; OLine=2951
                 INC      $5F              ; OLine=2952 
                                           
loc_77CE:                                  ; OLine=2954
                 LDA      $5F              ; OLine=2955 
                 RTS                       ; OLine=2956 
                                           ;  End of function sub_77B5
                                           
                                           ;  ---------------------------------------------------------------------------
byte_77D1:       .BYTE    2                ; OLine=2960
                                           
                                           ;  ¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦ S U B R O U T I N E ¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦
                                           
                                           
sub_77D2:                                  ; OLine=2965
                                           
                 CLC                       ; OLine=2967 
                 ADC      #$40             ; OLine=2968 
                                           ;  End of function sub_77D2
                                           
                                           
                                           ;  ¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦ S U B R O U T I N E ¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦
                                           
                                           
sub_77D5:                                  ; OLine=2975
                                           
                 BPL      sub_77DF         ; OLine=2977 
                 AND      #$7F             ; OLine=2978
                 JSR      sub_77DF         ; OLine=2979
                 JMP      sub_7708         ; OLine=2980 
                                           ;  End of function sub_77D5
                                           
                                           
                                           ;  ¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦ S U B R O U T I N E ¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦
                                           
                                           
sub_77DF:                                  ; OLine=2987
                                           
                 CMP      #$41             ; OLine=2989 
                 BCC      loc_77E7         ; OLine=2990
                 EOR      #$7F             ; OLine=2991
                 ADC      #0               ; OLine=2992 
                                           
loc_77E7:                                  ; OLine=2994
                 TAX                       ; OLine=2995 
                 LDA      $57B9,X          ; OLine=2996
                 RTS                       ; OLine=2997 
                                           ;  End of function sub_77DF
                                           
                                           ;  ---------------------------------------------------------------------------
                 .BYTE    0                ; OLine=3001
                 .BYTE    0                ; OLine=3002
                 .BYTE    0                ; OLine=3003
                 .BYTE    0                ; OLine=3004
                 .BYTE    0                ; OLine=3005
                 .BYTE    0                ; OLine=3006
                 .BYTE    0                ; OLine=3007
                 .BYTE    0                ; OLine=3008
                 .BYTE    0                ; OLine=3009
                 .BYTE    0                ; OLine=3010
                                           
                                           ;  ¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦ S U B R O U T I N E ¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦
                                           
                                           
sub_77F6:                                  ; OLine=3015
                                           
                 LDA      $2803            ; OLine=3017  DIP Switches 1 & 2, Language
                 AND      #3               ; OLine=3018
                 ASL      A                ; OLine=3019
                 TAX                       ; OLine=3020
                 LDA      #$10             ; OLine=3021
                 STA      0                ; OLine=3022
                 LDA      $7888,X          ; OLine=3023  Address Of Message Offset Table
                 STA      9                ; OLine=3024
                 LDA      $7887,X          ; OLine=3025
                 STA      8                ; OLine=3026
                 ADC      (8),Y            ; OLine=3027  Add In The Offset To Get Starting
                 STA      8                ; OLine=3028  Address Of Message
                 BCC      loc_7813         ; OLine=3029
                 INC      9                ; OLine=3030
                                           
loc_7813:                                  ; OLine=3032
                 TYA                       ; OLine=3033 
                 ASL      A                ; OLine=3034
                 TAY                       ; OLine=3035
                 LDA      $7871,Y          ; OLine=3036
                 LDX      $7872,Y          ; OLine=3037 
                 JSR      sub_7C03         ; OLine=3038
                 LDA      #$70             ; OLine=3039
                 JSR      sub_7CDE         ; OLine=3040
                 LDY      #0               ; OLine=3041 
                 LDX      #0               ; OLine=3042 
                                           
loc_7828:                                  ; OLine=3044
                 LDA      (8,X)            ; OLine=3045 
                 STA      $B               ; OLine=3046
                 LSR      A                ; OLine=3047
                 LSR      A                ; OLine=3048
                 JSR      sub_784D         ; OLine=3049 
                 LDA      (8,X)            ; OLine=3050
                 ROL      A                ; OLine=3051
                 ROL      $B               ; OLine=3052
                 ROL      A                ; OLine=3053 
                 LDA      $B               ; OLine=3054
                 ROL      A                ; OLine=3055
                 ASL      A                ; OLine=3056
                 JSR      sub_7853         ; OLine=3057 
                 LDA      (8,X)            ; OLine=3058
                 STA      $B               ; OLine=3059
                 JSR      sub_784D         ; OLine=3060
                 LSR      $B               ; OLine=3061 
                 BCC      loc_7828         ; OLine=3062 
                                           
loc_7849:                                  ; OLine=3064
                 DEY                       ; OLine=3065 
                 JMP      sub_7C39         ; OLine=3066 
                                           ;  End of function sub_77F6
                                           
                                           
                                           ;  ¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦ S U B R O U T I N E ¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦
                                           
                                           
sub_784D:                                  ; OLine=3073
                                           
                 INC      8                ; OLine=3075 
                 BNE      sub_7853         ; OLine=3076
                 INC      9                ; OLine=3077 
                                           ;  End of function sub_784D
                                           
                                           
                                           ;  ¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦ S U B R O U T I N E ¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦
                                           
                                           
sub_7853:                                  ; OLine=3084
                                           
                 AND      #$3E             ; OLine=3086 
                 BNE      loc_785B         ; OLine=3087
                 PLA                       ; OLine=3088
                 PLA                       ; OLine=3089 
                 BNE      loc_7849         ; OLine=3090 
                                           
loc_785B:                                  ; OLine=3092
                 CMP      #$A              ; OLine=3093 
                 BCC      loc_7861         ; OLine=3094
                 ADC      #$D              ; OLine=3095 
                                           
loc_7861:                                  ; OLine=3097
                 TAX                       ; OLine=3098 
                 LDA      $56D2,X          ; OLine=3099
                 STA      (2),Y            ; OLine=3100
                 INY                       ; OLine=3101 
                 LDA      $56D3,X          ; OLine=3102
                 STA      (2),Y            ; OLine=3103
                 INY                       ; OLine=3104
                 LDX      #0               ; OLine=3105 
                 RTS                       ; OLine=3106 
                                           ;  End of function sub_7853
                                           
                                           ;  ---------------------------------------------------------------------------
                 .BYTE    $64              ; OLine=3110
                 .BYTE    $B6              ; OLine=3111
                                           
                 .BYTE    $64              ; OLine=3113
                 .BYTE    $B6              ; OLine=3114
                                           
                 .BYTE    $C               ; OLine=3116
                 .BYTE    $AA              ; OLine=3117
                                           
                 .BYTE    $C               ; OLine=3119
                 .BYTE    $A2              ; OLine=3120
                                           
                 .BYTE    $C               ; OLine=3122
                 .BYTE    $9A              ; OLine=3123
                                           
                 .BYTE    $C               ; OLine=3125
                 .BYTE    $92              ; OLine=3126
                                           
                 .BYTE    $64              ; OLine=3128
                 .BYTE    $C6              ; OLine=3129
                                           
                 .BYTE    $64              ; OLine=3131
                 .BYTE    $9D              ; OLine=3132
                                           
                 .BYTE    $50              ; OLine=3134
                 .BYTE    $39              ; OLine=3135
                                           
                 .BYTE    $50              ; OLine=3137
                 .BYTE    $39              ; OLine=3138
                                           
                 .BYTE    $50              ; OLine=3140
                 .BYTE    $39              ; OLine=3141
                                           
                                           
                 .BYTE    $1E              ; OLine=3144  English
                 .BYTE    $57              ; OLine=3145
                                           
                 .BYTE    $8F              ; OLine=3147
                 .BYTE    $78              ; OLine=3148
                                           
                 .BYTE    $46              ; OLine=3150
                 .BYTE    $79              ; OLine=3151
                                           
                 .BYTE    $F3              ; OLine=3153
                 .BYTE    $79              ; OLine=3154
                                           
                 .BYTE    $B               ; OLine=3156
                 .BYTE    $15              ; OLine=3157
                 .BYTE    $1B              ; OLine=3158
                 .BYTE    $35              ; OLine=3159
                 .BYTE    $4D              ; OLine=3160
                 .BYTE    $65              ; OLine=3161
                 .BYTE    $7F              ; OLine=3162
                 .BYTE    $8D              ; OLine=3163
                 .BYTE    $93              ; OLine=3164
                 .BYTE    $9F              ; OLine=3165
                 .BYTE    $AB              ; OLine=3166
                                           
                 .BYTE    $64              ; OLine=3168
                 .BYTE    $D2              ; OLine=3169
                 .BYTE    $3B              ; OLine=3170
                 .BYTE    $2E              ; OLine=3171
                 .BYTE    $C2              ; OLine=3172
                 .BYTE    $6C              ; OLine=3173
                 .BYTE    $5A              ; OLine=3174
                 .BYTE    $4C              ; OLine=3175
                 .BYTE    $93              ; OLine=3176
                 .BYTE    $6F              ; OLine=3177
                 .BYTE    $BD              ; OLine=3178
                 .BYTE    $1A              ; OLine=3179
                 .BYTE    $4C              ; OLine=3180
                 .BYTE    $12              ; OLine=3181
                 .BYTE    $B0              ; OLine=3182
                 .BYTE    $40              ; OLine=3183
                 .BYTE    $6B              ; OLine=3184
                 .BYTE    $2C              ; OLine=3185
                 .BYTE    $A               ; OLine=3186
                 .BYTE    $6C              ; OLine=3187
                 .BYTE    $5A              ; OLine=3188
                 .BYTE    $4C              ; OLine=3189
                 .BYTE    $93              ; OLine=3190
                 .BYTE    $6E              ; OLine=3191
                 .BYTE    $B               ; OLine=3192
                 .BYTE    $6E              ; OLine=3193
                 .BYTE    $C0              ; OLine=3194
                 .BYTE    $52              ; OLine=3195
                 .BYTE    $6C              ; OLine=3196
                 .BYTE    $92              ; OLine=3197
                 .BYTE    $B8              ; OLine=3198
                 .BYTE    $50              ; OLine=3199
                 .BYTE    $4D              ; OLine=3200
                 .BYTE    $82              ; OLine=3201
                 .BYTE    $F2              ; OLine=3202
                 .BYTE    $58              ; OLine=3203
                 .BYTE    $90              ; OLine=3204
                 .BYTE    $4C              ; OLine=3205
                 .BYTE    $4D              ; OLine=3206
                 .BYTE    $F0              ; OLine=3207
                 .BYTE    $4C              ; OLine=3208
                 .BYTE    $80              ; OLine=3209
                 .BYTE    $33              ; OLine=3210
                 .BYTE    $70              ; OLine=3211
                 .BYTE    $C2              ; OLine=3212
                 .BYTE    $42              ; OLine=3213
                 .BYTE    $5A              ; OLine=3214
                 .BYTE    $4C              ; OLine=3215
                 .BYTE    $4C              ; OLine=3216
                 .BYTE    $82              ; OLine=3217
                 .BYTE    $BB              ; OLine=3218
                 .BYTE    $52              ; OLine=3219
                 .BYTE    $B               ; OLine=3220
                 .BYTE    $58              ; OLine=3221
                 .BYTE    $B2              ; OLine=3222
                 .BYTE    $42              ; OLine=3223
                 .BYTE    $6C              ; OLine=3224
                 .BYTE    $9A              ; OLine=3225
                 .BYTE    $C3              ; OLine=3226
                 .BYTE    $4A              ; OLine=3227
                 .BYTE    $82              ; OLine=3228
                 .BYTE    $64              ; OLine=3229
                 .BYTE    $A               ; OLine=3230
                 .BYTE    $5A              ; OLine=3231
                 .BYTE    $90              ; OLine=3232
                 .BYTE    0                ; OLine=3233
                 .BYTE    $F6              ; OLine=3234
                 .BYTE    $6C              ; OLine=3235
                 .BYTE    9                ; OLine=3236
                 .BYTE    $B2              ; OLine=3237
                 .BYTE    $3B              ; OLine=3238
                 .BYTE    $2E              ; OLine=3239
                 .BYTE    $C1              ; OLine=3240
                 .BYTE    $4C              ; OLine=3241
                 .BYTE    $4C              ; OLine=3242
                 .BYTE    $B6              ; OLine=3243
                 .BYTE    $2B              ; OLine=3244
                 .BYTE    $20              ; OLine=3245
                 .BYTE    $D               ; OLine=3246
                 .BYTE    $A6              ; OLine=3247
                 .BYTE    $C1              ; OLine=3248
                 .BYTE    $70              ; OLine=3249
                 .BYTE    $48              ; OLine=3250
                 .BYTE    $50              ; OLine=3251
                 .BYTE    $B6              ; OLine=3252
                 .BYTE    $52              ; OLine=3253
                 .BYTE    $3B              ; OLine=3254
                 .BYTE    $D2              ; OLine=3255
                 .BYTE    $90              ; OLine=3256
                 .BYTE    0                ; OLine=3257
                 .BYTE    $DA              ; OLine=3258
                 .BYTE    $64              ; OLine=3259
                 .BYTE    $90              ; OLine=3260
                 .BYTE    $4C              ; OLine=3261
                 .BYTE    $C9              ; OLine=3262
                 .BYTE    $D8              ; OLine=3263
                 .BYTE    $BE              ; OLine=3264
                 .BYTE    $A               ; OLine=3265
                 .BYTE    $32              ; OLine=3266
                 .BYTE    $42              ; OLine=3267
                 .BYTE    $9B              ; OLine=3268
                 .BYTE    $C2              ; OLine=3269
                 .BYTE    $67              ; OLine=3270
                 .BYTE    $68              ; OLine=3271
                 .BYTE    $4D              ; OLine=3272
                 .BYTE    $AE              ; OLine=3273
                 .BYTE    $A1              ; OLine=3274
                 .BYTE    $4E              ; OLine=3275
                 .BYTE    $48              ; OLine=3276
                 .BYTE    $50              ; OLine=3277
                 .BYTE    $B6              ; OLine=3278
                 .BYTE    $52              ; OLine=3279
                 .BYTE    $3B              ; OLine=3280
                 .BYTE    $D2              ; OLine=3281
                 .BYTE    $90              ; OLine=3282
                 .BYTE    0                ; OLine=3283
                 .BYTE    $BE              ; OLine=3284
                 .BYTE    $A               ; OLine=3285
                 .BYTE    $B6              ; OLine=3286
                 .BYTE    $1E              ; OLine=3287
                 .BYTE    $94              ; OLine=3288
                 .BYTE    $D2              ; OLine=3289
                 .BYTE    $A2              ; OLine=3290
                 .BYTE    $92              ; OLine=3291
                 .BYTE    $A               ; OLine=3292
                 .BYTE    $2C              ; OLine=3293
                 .BYTE    $CA              ; OLine=3294
                 .BYTE    $4E              ; OLine=3295
                 .BYTE    $7A              ; OLine=3296
                 .BYTE    $65              ; OLine=3297
                 .BYTE    $BD              ; OLine=3298
                 .BYTE    $1A              ; OLine=3299
                 .BYTE    $4C              ; OLine=3300
                 .BYTE    $12              ; OLine=3301
                 .BYTE    $92              ; OLine=3302
                 .BYTE    $13              ; OLine=3303
                 .BYTE    $18              ; OLine=3304
                 .BYTE    $62              ; OLine=3305
                 .BYTE    $CA              ; OLine=3306
                 .BYTE    $64              ; OLine=3307
                 .BYTE    $F2              ; OLine=3308
                 .BYTE    $42              ; OLine=3309
                 .BYTE    $20              ; OLine=3310
                 .BYTE    $6E              ; OLine=3311
                 .BYTE    $A3              ; OLine=3312
                 .BYTE    $52              ; OLine=3313
                 .BYTE    $82              ; OLine=3314
                 .BYTE    $40              ; OLine=3315
                 .BYTE    $18              ; OLine=3316
                 .BYTE    $62              ; OLine=3317
                 .BYTE    $CA              ; OLine=3318
                 .BYTE    $64              ; OLine=3319
                 .BYTE    $F2              ; OLine=3320
                 .BYTE    $42              ; OLine=3321
                 .BYTE    $18              ; OLine=3322
                 .BYTE    $6E              ; OLine=3323
                 .BYTE    $A3              ; OLine=3324
                 .BYTE    $52              ; OLine=3325
                 .BYTE    $80              ; OLine=3326
                 .BYTE    0                ; OLine=3327
                 .BYTE    $20              ; OLine=3328
                 .BYTE    $62              ; OLine=3329
                 .BYTE    $CA              ; OLine=3330
                 .BYTE    $64              ; OLine=3331
                 .BYTE    $F2              ; OLine=3332
                 .BYTE    $64              ; OLine=3333
                 .BYTE    8                ; OLine=3334
                 .BYTE    $C2              ; OLine=3335
                 .BYTE    $BD              ; OLine=3336
                 .BYTE    $1A              ; OLine=3337
                 .BYTE    $4C              ; OLine=3338
                 .BYTE    0                ; OLine=3339
                                           
                 .BYTE    $B               ; OLine=3341
                 .BYTE    $15              ; OLine=3342
                 .BYTE    $19              ; OLine=3343
                 .BYTE    $31              ; OLine=3344
                 .BYTE    $41              ; OLine=3345
                 .BYTE    $57              ; OLine=3346
                 .BYTE    $73              ; OLine=3347
                 .BYTE    $7F              ; OLine=3348
                 .BYTE    $89              ; OLine=3349
                 .BYTE    $95              ; OLine=3350
                 .BYTE    $A1              ; OLine=3351
                                           
                 .BYTE    $8A              ; OLine=3353
                 .BYTE    $5A              ; OLine=3354
                 .BYTE    $84              ; OLine=3355
                 .BYTE    $12              ; OLine=3356
                 .BYTE    $CD              ; OLine=3357
                 .BYTE    $82              ; OLine=3358
                 .BYTE    $B9              ; OLine=3359
                 .BYTE    $E6              ; OLine=3360
                 .BYTE    $B2              ; OLine=3361
                 .BYTE    $40              ; OLine=3362
                 .BYTE    $74              ; OLine=3363
                 .BYTE    $F2              ; OLine=3364
                 .BYTE    $4D              ; OLine=3365
                 .BYTE    $83              ; OLine=3366
                 .BYTE    $D4              ; OLine=3367
                 .BYTE    $F0              ; OLine=3368
                 .BYTE    $B2              ; OLine=3369
                 .BYTE    $42              ; OLine=3370
                 .BYTE    $B9              ; OLine=3371
                 .BYTE    $E6              ; OLine=3372
                 .BYTE    $B2              ; OLine=3373
                 .BYTE    $42              ; OLine=3374
                 .BYTE    $4D              ; OLine=3375
                 .BYTE    $F0              ; OLine=3376
                 .BYTE    $E               ; OLine=3377
                 .BYTE    $64              ; OLine=3378
                 .BYTE    $A               ; OLine=3379
                 .BYTE    $12              ; OLine=3380
                 .BYTE    $B8              ; OLine=3381
                 .BYTE    $46              ; OLine=3382
                 .BYTE    $10              ; OLine=3383
                 .BYTE    $62              ; OLine=3384
                 .BYTE    $4B              ; OLine=3385
                 .BYTE    $60              ; OLine=3386
                 .BYTE    $82              ; OLine=3387
                 .BYTE    $72              ; OLine=3388
                 .BYTE    $B5              ; OLine=3389
                 .BYTE    $C0              ; OLine=3390
                 .BYTE    $BE              ; OLine=3391
                 .BYTE    $A8              ; OLine=3392
                 .BYTE    $A               ; OLine=3393
                 .BYTE    $64              ; OLine=3394
                 .BYTE    $C5              ; OLine=3395
                 .BYTE    $92              ; OLine=3396
                 .BYTE    $F0              ; OLine=3397
                 .BYTE    $74              ; OLine=3398
                 .BYTE    $9D              ; OLine=3399
                 .BYTE    $C2              ; OLine=3400
                 .BYTE    $6C              ; OLine=3401
                 .BYTE    $9A              ; OLine=3402
                 .BYTE    $C3              ; OLine=3403
                 .BYTE    $4A              ; OLine=3404
                 .BYTE    $82              ; OLine=3405
                 .BYTE    $6F              ; OLine=3406
                 .BYTE    $A4              ; OLine=3407
                 .BYTE    $F2              ; OLine=3408
                 .BYTE    $BD              ; OLine=3409
                 .BYTE    $D2              ; OLine=3410
                 .BYTE    $F0              ; OLine=3411
                 .BYTE    $6C              ; OLine=3412
                 .BYTE    $9E              ; OLine=3413
                 .BYTE    $A               ; OLine=3414
                 .BYTE    $C2              ; OLine=3415
                 .BYTE    $42              ; OLine=3416
                 .BYTE    $A4              ; OLine=3417
                 .BYTE    $F2              ; OLine=3418
                 .BYTE    $B0              ; OLine=3419
                 .BYTE    $74              ; OLine=3420
                 .BYTE    $9D              ; OLine=3421
                 .BYTE    $C2              ; OLine=3422
                 .BYTE    $6C              ; OLine=3423
                 .BYTE    $9A              ; OLine=3424
                 .BYTE    $C3              ; OLine=3425
                 .BYTE    $4A              ; OLine=3426
                 .BYTE    $82              ; OLine=3427
                 .BYTE    $6F              ; OLine=3428
                 .BYTE    $A4              ; OLine=3429
                 .BYTE    $F2              ; OLine=3430
                 .BYTE    $BD              ; OLine=3431
                 .BYTE    $D2              ; OLine=3432
                 .BYTE    $F0              ; OLine=3433
                 .BYTE    $58              ; OLine=3434
                 .BYTE    $ED              ; OLine=3435
                 .BYTE    $12              ; OLine=3436
                 .BYTE    $B5              ; OLine=3437
                 .BYTE    $E8              ; OLine=3438
                 .BYTE    $29              ; OLine=3439
                 .BYTE    $D2              ; OLine=3440
                 .BYTE    $D               ; OLine=3441
                 .BYTE    $72              ; OLine=3442
                 .BYTE    $2C              ; OLine=3443
                 .BYTE    $90              ; OLine=3444
                 .BYTE    $C               ; OLine=3445
                 .BYTE    $12              ; OLine=3446
                 .BYTE    $C6              ; OLine=3447
                 .BYTE    $2C              ; OLine=3448
                 .BYTE    $48              ; OLine=3449
                 .BYTE    $4E              ; OLine=3450
                 .BYTE    $9D              ; OLine=3451
                 .BYTE    $AC              ; OLine=3452
                 .BYTE    $49              ; OLine=3453
                 .BYTE    $F0              ; OLine=3454
                 .BYTE    $48              ; OLine=3455
                 .BYTE    0                ; OLine=3456
                 .BYTE    $2D              ; OLine=3457
                 .BYTE    $28              ; OLine=3458
                 .BYTE    $CF              ; OLine=3459
                 .BYTE    $52              ; OLine=3460
                 .BYTE    $B0              ; OLine=3461
                 .BYTE    $6E              ; OLine=3462
                 .BYTE    $CD              ; OLine=3463
                 .BYTE    $82              ; OLine=3464
                 .BYTE    $BE              ; OLine=3465
                 .BYTE    $A               ; OLine=3466
                 .BYTE    $B6              ; OLine=3467
                 .BYTE    0                ; OLine=3468
                 .BYTE    $53              ; OLine=3469
                 .BYTE    $64              ; OLine=3470
                 .BYTE    $A               ; OLine=3471
                 .BYTE    $12              ; OLine=3472
                 .BYTE    $D               ; OLine=3473
                 .BYTE    $A               ; OLine=3474
                 .BYTE    $B6              ; OLine=3475
                 .BYTE    $1A              ; OLine=3476
                 .BYTE    $48              ; OLine=3477
                 .BYTE    0                ; OLine=3478
                 .BYTE    $18              ; OLine=3479
                 .BYTE    $68              ; OLine=3480
                 .BYTE    $6A              ; OLine=3481
                 .BYTE    $4E              ; OLine=3482
                 .BYTE    $48              ; OLine=3483
                 .BYTE    $48              ; OLine=3484
                 .BYTE    $B               ; OLine=3485
                 .BYTE    $A6              ; OLine=3486
                 .BYTE    $CA              ; OLine=3487
                 .BYTE    $72              ; OLine=3488
                 .BYTE    $B5              ; OLine=3489
                 .BYTE    $C0              ; OLine=3490
                 .BYTE    $18              ; OLine=3491
                 .BYTE    $68              ; OLine=3492
                 .BYTE    $6A              ; OLine=3493
                 .BYTE    $4E              ; OLine=3494
                 .BYTE    $48              ; OLine=3495
                 .BYTE    $46              ; OLine=3496
                 .BYTE    $B               ; OLine=3497
                 .BYTE    $A6              ; OLine=3498
                 .BYTE    $CA              ; OLine=3499
                 .BYTE    $72              ; OLine=3500
                 .BYTE    $B0              ; OLine=3501
                 .BYTE    0                ; OLine=3502
                 .BYTE    $20              ; OLine=3503
                 .BYTE    $68              ; OLine=3504
                 .BYTE    $6A              ; OLine=3505
                 .BYTE    $4E              ; OLine=3506
                 .BYTE    $4D              ; OLine=3507
                 .BYTE    $C2              ; OLine=3508
                 .BYTE    $18              ; OLine=3509
                 .BYTE    $5C              ; OLine=3510
                 .BYTE    $9E              ; OLine=3511
                 .BYTE    $52              ; OLine=3512
                 .BYTE    $CD              ; OLine=3513
                 .BYTE    $80              ; OLine=3514
                                           
                 .BYTE    $B               ; OLine=3516
                 .BYTE    $11              ; OLine=3517
                 .BYTE    $17              ; OLine=3518
                 .BYTE    $31              ; OLine=3519
                 .BYTE    $45              ; OLine=3520
                 .BYTE    $5F              ; OLine=3521
                 .BYTE    $6B              ; OLine=3522
                 .BYTE    $73              ; OLine=3523
                 .BYTE    $7D              ; OLine=3524
                 .BYTE    $89              ; OLine=3525
                 .BYTE    $93              ; OLine=3526
                                           
                 .BYTE    $B2              ; OLine=3528
                 .BYTE    $4E              ; OLine=3529
                 .BYTE    $9D              ; OLine=3530
                 .BYTE    $90              ; OLine=3531
                 .BYTE    $B8              ; OLine=3532
                 .BYTE    0                ; OLine=3533
                 .BYTE    $76              ; OLine=3534
                 .BYTE    $56              ; OLine=3535
                 .BYTE    $2A              ; OLine=3536
                 .BYTE    $26              ; OLine=3537
                 .BYTE    $B0              ; OLine=3538
                 .BYTE    $40              ; OLine=3539
                 .BYTE    $BE              ; OLine=3540
                 .BYTE    $42              ; OLine=3541
                 .BYTE    $A6              ; OLine=3542
                 .BYTE    $64              ; OLine=3543
                 .BYTE    $C1              ; OLine=3544
                 .BYTE    $5C              ; OLine=3545
                 .BYTE    $48              ; OLine=3546
                 .BYTE    $52              ; OLine=3547
                 .BYTE    $BE              ; OLine=3548
                 .BYTE    $A               ; OLine=3549
                 .BYTE    $A               ; OLine=3550
                 .BYTE    $64              ; OLine=3551
                 .BYTE    $C5              ; OLine=3552
                 .BYTE    $92              ; OLine=3553
                 .BYTE    $C               ; OLine=3554
                 .BYTE    $26              ; OLine=3555
                 .BYTE    $B8              ; OLine=3556
                 .BYTE    $50              ; OLine=3557
                 .BYTE    $6A              ; OLine=3558
                 .BYTE    $7C              ; OLine=3559
                 .BYTE    $C               ; OLine=3560
                 .BYTE    $52              ; OLine=3561
                 .BYTE    $74              ; OLine=3562
                 .BYTE    $EC              ; OLine=3563
                 .BYTE    $4D              ; OLine=3564
                 .BYTE    $C0              ; OLine=3565
                 .BYTE    $A4              ; OLine=3566
                 .BYTE    $EC              ; OLine=3567
                 .BYTE    $A               ; OLine=3568
                 .BYTE    $8A              ; OLine=3569
                 .BYTE    $D4              ; OLine=3570
                 .BYTE    $EC              ; OLine=3571
                 .BYTE    $A               ; OLine=3572
                 .BYTE    $64              ; OLine=3573
                 .BYTE    $C5              ; OLine=3574
                 .BYTE    $92              ; OLine=3575
                 .BYTE    $D               ; OLine=3576
                 .BYTE    $F2              ; OLine=3577
                 .BYTE    $B8              ; OLine=3578
                 .BYTE    $5A              ; OLine=3579
                 .BYTE    $93              ; OLine=3580
                 .BYTE    $4E              ; OLine=3581
                 .BYTE    $69              ; OLine=3582
                 .BYTE    $60              ; OLine=3583
                 .BYTE    $4D              ; OLine=3584
                 .BYTE    $C0              ; OLine=3585
                 .BYTE    $9D              ; OLine=3586
                 .BYTE    $2C              ; OLine=3587
                 .BYTE    $6C              ; OLine=3588
                 .BYTE    $4A              ; OLine=3589
                 .BYTE    $D               ; OLine=3590
                 .BYTE    $A6              ; OLine=3591
                 .BYTE    $C1              ; OLine=3592
                 .BYTE    $70              ; OLine=3593
                 .BYTE    $48              ; OLine=3594
                 .BYTE    $68              ; OLine=3595
                 .BYTE    $2D              ; OLine=3596
                 .BYTE    $8A              ; OLine=3597
                 .BYTE    $D               ; OLine=3598
                 .BYTE    $D2              ; OLine=3599
                 .BYTE    $82              ; OLine=3600
                 .BYTE    $4E              ; OLine=3601
                 .BYTE    $3B              ; OLine=3602
                 .BYTE    $66              ; OLine=3603
                 .BYTE    $91              ; OLine=3604
                 .BYTE    $6C              ; OLine=3605
                 .BYTE    $C               ; OLine=3606
                 .BYTE    $A               ; OLine=3607
                 .BYTE    $C               ; OLine=3608
                 .BYTE    $12              ; OLine=3609
                 .BYTE    $C5              ; OLine=3610
                 .BYTE    $8B              ; OLine=3611
                 .BYTE    $9D              ; OLine=3612
                 .BYTE    $2C              ; OLine=3613
                 .BYTE    $6C              ; OLine=3614
                 .BYTE    $4A              ; OLine=3615
                 .BYTE    $B               ; OLine=3616
                 .BYTE    $3A              ; OLine=3617
                 .BYTE    $A2              ; OLine=3618
                 .BYTE    $6C              ; OLine=3619
                 .BYTE    $BD              ; OLine=3620
                 .BYTE    $A               ; OLine=3621
                 .BYTE    $3A              ; OLine=3622
                 .BYTE    $40              ; OLine=3623
                 .BYTE    $A6              ; OLine=3624
                 .BYTE    $60              ; OLine=3625
                 .BYTE    $B9              ; OLine=3626
                 .BYTE    $6C              ; OLine=3627
                 .BYTE    $D               ; OLine=3628
                 .BYTE    $F0              ; OLine=3629
                 .BYTE    $2D              ; OLine=3630
                 .BYTE    $B1              ; OLine=3631
                 .BYTE    $76              ; OLine=3632
                 .BYTE    $52              ; OLine=3633
                 .BYTE    $5C              ; OLine=3634
                 .BYTE    $C2              ; OLine=3635
                 .BYTE    $C2              ; OLine=3636
                 .BYTE    $6C              ; OLine=3637
                 .BYTE    $8B              ; OLine=3638
                 .BYTE    $64              ; OLine=3639
                 .BYTE    $2A              ; OLine=3640
                 .BYTE    $27              ; OLine=3641
                 .BYTE    $18              ; OLine=3642
                 .BYTE    $54              ; OLine=3643
                 .BYTE    $69              ; OLine=3644
                 .BYTE    $D8              ; OLine=3645
                 .BYTE    $28              ; OLine=3646
                 .BYTE    $48              ; OLine=3647
                 .BYTE    $B               ; OLine=3648
                 .BYTE    $B2              ; OLine=3649
                 .BYTE    $4A              ; OLine=3650
                 .BYTE    $E6              ; OLine=3651
                 .BYTE    $B8              ; OLine=3652
                 .BYTE    0                ; OLine=3653
                 .BYTE    $18              ; OLine=3654
                 .BYTE    $54              ; OLine=3655
                 .BYTE    $69              ; OLine=3656
                 .BYTE    $D8              ; OLine=3657
                 .BYTE    $28              ; OLine=3658
                 .BYTE    $46              ; OLine=3659
                 .BYTE    $B               ; OLine=3660
                 .BYTE    $B2              ; OLine=3661
                 .BYTE    $4A              ; OLine=3662
                 .BYTE    $E7              ; OLine=3663
                 .BYTE    $20              ; OLine=3664
                 .BYTE    $54              ; OLine=3665
                 .BYTE    $69              ; OLine=3666
                 .BYTE    $D8              ; OLine=3667
                 .BYTE    $2D              ; OLine=3668
                 .BYTE    $C2              ; OLine=3669
                 .BYTE    $18              ; OLine=3670
                 .BYTE    $5C              ; OLine=3671
                 .BYTE    $CA              ; OLine=3672
                 .BYTE    $56              ; OLine=3673
                 .BYTE    $98              ; OLine=3674
                 .BYTE    0                ; OLine=3675
                 .BYTE    $52              ; OLine=3676
                                           
                                           
                                           ;  ¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦ S U B R O U T I N E ¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦
                                           
                                           
sub_7A93:                                  ; OLine=3682
                 LDX      #2               ; OLine=3683
                                           
loc_7A95:                                  ; OLine=3685
                 LDA      $2400,X          ; OLine=3686  Coin Switch
                 ASL      A                ; OLine=3687  Shift High Bit To Carry
                 LDA      $7A,X            ; OLine=3688
                 AND      #$1F             ; OLine=3689  00011111
                 BCC      loc_7AD6         ; OLine=3690  No Coin For This Slot, Branch
                 BEQ      loc_7AB1         ; OLine=3691
                 CMP      #$1B             ; OLine=3692
                 BCS      loc_7AAF         ; OLine=3693 
                 TAY                       ; OLine=3694
                 LDA      $5E              ; OLine=3695
                 AND      #7               ; OLine=3696
                 CMP      #7               ; OLine=3697 
                 TYA                       ; OLine=3698
                 BCC      loc_7AB1         ; OLine=3699 
                                           
loc_7AAF:                                  ; OLine=3701
                 SBC      #1               ; OLine=3702 
                                           
loc_7AB1:                                  ; OLine=3704
                                           
                 STA      $7A,X            ; OLine=3706 
                 LDA      $2006            ; OLine=3707  Slam Switch
                 AND      #$80             ; OLine=3708 
                 BEQ      loc_7ABE         ; OLine=3709  Valid Coin, Branch
                 LDA      #$F0             ; OLine=3710  Flag Ill Gotten Gain
                 STA      $72              ; OLine=3711  Into Slam Switch Flag
                                           
loc_7ABE:                                  ; OLine=3713
                 LDA      $72              ; OLine=3714  Honest Coin?
                 BEQ      loc_7ACA         ; OLine=3715  Yes, Branch
                 DEC      $72              ; OLine=3716
                 LDA      #0               ; OLine=3717
                 STA      $7A,X            ; OLine=3718
                 STA      $77,X            ; OLine=3719 
                                           
loc_7ACA:                                  ; OLine=3721
                 CLC                       ; OLine=3722 
                 LDA      $77,X            ; OLine=3723
                 BEQ      loc_7AF2         ; OLine=3724
                 DEC      $77,X            ; OLine=3725 
                 BNE      loc_7AF2         ; OLine=3726
                 SEC                       ; OLine=3727 
                 BCS      loc_7AF2         ; OLine=3728 
                                           
loc_7AD6:                                  ; OLine=3730
                 CMP      #$1B             ; OLine=3731 
                 BCS      loc_7AE3         ; OLine=3732
                 LDA      $7A,X            ; OLine=3733 
                 ADC      #$20             ; OLine=3734
                 BCC      loc_7AB1         ; OLine=3735
                 BEQ      loc_7AE3         ; OLine=3736 
                 CLC                       ; OLine=3737
                                           
loc_7AE3:                                  ; OLine=3739
                                           
                 LDA      #$1F             ; OLine=3741 
                 BCS      loc_7AB1         ; OLine=3742
                 STA      $7A,X            ; OLine=3743 
                 LDA      $77,X            ; OLine=3744
                 BEQ      loc_7AEE         ; OLine=3745
                 SEC                       ; OLine=3746 
                                           
loc_7AEE:                                  ; OLine=3748
                 LDA      #$78             ; OLine=3749 
                 STA      $77,X            ; OLine=3750 
                                           
loc_7AF2:                                  ; OLine=3752
                                           
                 BCC      loc_7B17         ; OLine=3754 
                 LDA      #0               ; OLine=3755 
                 CPX      #1               ; OLine=3756 
                 BCC      loc_7B10         ; OLine=3757 
                 BEQ      loc_7B08         ; OLine=3758 
                 LDA      $71              ; OLine=3759  DIP Switch Bitmap
                 AND      #$C              ; OLine=3760  Mask Off Switches 5 & 6, Right Coin Slot Multiplier
                 LSR      A                ; OLine=3761 
                 LSR      A                ; OLine=3762 
                 BEQ      loc_7B10         ; OLine=3763  x1, Branch
                 ADC      #2               ; OLine=3764  2 + Set Bits From Settings = Total Coins After Multiplier
                 BNE      loc_7B10         ; OLine=3765  Will Always Branch
                                           
loc_7B08:                                  ; OLine=3767
                 LDA      $71              ; OLine=3768 
                 AND      #$10             ; OLine=3769 
                 BEQ      loc_7B10         ; OLine=3770 
                 LDA      #1               ; OLine=3771 
                                           
loc_7B10:                                  ; OLine=3773
                                           
                 SEC                       ; OLine=3775  Set Carry, This Will Add 1 To The Total
                 ADC      $73              ; OLine=3776 
                 STA      $73              ; OLine=3777 
                 INC      $74,X            ; OLine=3778 
                                           
loc_7B17:                                  ; OLine=3780
                 DEX                       ; OLine=3781
                 BMI      loc_7B1D         ; OLine=3782 
                 JMP      loc_7A95         ; OLine=3783 
                                           ;  ---------------------------------------------------------------------------
                                           
loc_7B1D:                                  ; OLine=3786
                 LDA      $71              ; OLine=3787  DIP Switch Settings
                 AND      #3               ; OLine=3788  Mask Off Switches 7 & 8, Coins Per Play
                 TAY                       ; OLine=3789 
                 BEQ      loc_7B36         ; OLine=3790  Free Play, Branch
                 LSR      A                ; OLine=3791 
                 ADC      #0               ; OLine=3792 
                 EOR      #$FF             ; OLine=3793
                 SEC                       ; OLine=3794
                 ADC      $73              ; OLine=3795 
                 BCC      loc_7B38         ; OLine=3796
                 CPY      #2               ; OLine=3797
                 BCS      loc_7B34         ; OLine=3798
                 INC      $70              ; OLine=3799  Add Credit
                                           
loc_7B34:                                  ; OLine=3801
                 INC      $70              ; OLine=3802  Add Credit
                                           
loc_7B36:                                  ; OLine=3804
                 STA      $73              ; OLine=3805 
                                           
loc_7B38:                                  ; OLine=3807
                 LDA      $5E              ; OLine=3808 
                 LSR      A                ; OLine=3809
                 BCS      locret_7B64      ; OLine=3810
                 LDY      #0               ; OLine=3811
                 LDX      #2               ; OLine=3812 
                                           
loc_7B41:                                  ; OLine=3814
                 LDA      $74,X            ; OLine=3815 
                 BEQ      loc_7B4E         ; OLine=3816
                 CMP      #$10             ; OLine=3817
                 BCC      loc_7B4E         ; OLine=3818
                 ADC      #$EF             ; OLine=3819 
                 INY                       ; OLine=3820
                 STA      $74,X            ; OLine=3821 
                                           
loc_7B4E:                                  ; OLine=3823
                                           
                 DEX                       ; OLine=3825 
                 BPL      loc_7B41         ; OLine=3826
                 TYA                       ; OLine=3827
                 BNE      locret_7B64      ; OLine=3828
                 LDX      #2               ; OLine=3829 
                                           
loc_7B56:                                  ; OLine=3831
                 LDA      $74,X            ; OLine=3832 
                 BEQ      loc_7B61         ; OLine=3833
                 CLC                       ; OLine=3834
                 ADC      #$EF             ; OLine=3835
                 STA      $74,X            ; OLine=3836 
                 BMI      locret_7B64      ; OLine=3837 
                                           
loc_7B61:                                  ; OLine=3839
                 DEX                       ; OLine=3840 
                 BPL      loc_7B56         ; OLine=3841 
                                           
locret_7B64:                               ; OLine=3843
                                           
                 RTS                       ; OLine=3845 
                                           ;  End of function sub_7A93
                                           
                                           ;  ---------------------------------------------------------------------------
                 PHA                       ; OLine=3849 
                 TYA                       ; OLine=3850
                 PHA                       ; OLine=3851
                 TXA                       ; OLine=3852
                 PHA                       ; OLine=3853 
                 CLD                       ; OLine=3854
                 LDA      $1FF             ; OLine=3855  Stack Space!
                 ORA      $1D0             ; OLine=3856 
                                           
loc_7B71:                                  ; OLine=3858
                 BNE      loc_7B71         ; OLine=3859  Endless Loop! Watchdog Will Time Out
                 INC      $5E              ; OLine=3860 
                 LDA      $5E              ; OLine=3861 
                 AND      #3               ; OLine=3862 
                 BNE      loc_7B83         ; OLine=3863
                 INC      $5B              ; OLine=3864 
                 LDA      $5B              ; OLine=3865
                 CMP      #4               ; OLine=3866 
                                           
loc_7B81:                                  ; OLine=3868
                 BCS      loc_7B81         ; OLine=3869  Endless Loop! Watchdog Will Time Out
                                           
loc_7B83:                                  ; OLine=3871
                 JSR      sub_7A93         ; OLine=3872 
                 LDA      $6F              ; OLine=3873
                 AND      #$C7             ; OLine=3874
                 BIT      $74              ; OLine=3875
                 BPL      loc_7B90         ; OLine=3876 
                 ORA      #8               ; OLine=3877
                                           
loc_7B90:                                  ; OLine=3879
                 BIT      $75              ; OLine=3880 
                 BPL      loc_7B96         ; OLine=3881
                 ORA      #$10             ; OLine=3882 
                                           
loc_7B96:                                  ; OLine=3884
                 BIT      $76              ; OLine=3885 
                 BPL      loc_7B9C         ; OLine=3886
                 ORA      #$20             ; OLine=3887 
                                           
loc_7B9C:                                  ; OLine=3889
                 STA      $6F              ; OLine=3890 
                 STA      $3200            ; OLine=3891 
                 LDA      $72              ; OLine=3892  Slam Switch Flag
                 BEQ      loc_7BA9         ; OLine=3893  Branch If Not Set
                 LDA      #$80             ; OLine=3894  Gonna Make Noise To Let 'Em Know They've Been Caught!
                 BNE      loc_7BB7         ; OLine=3895  Will Always Branch
                                           
loc_7BA9:                                  ; OLine=3897
                 LDA      $68              ; OLine=3898  Bonus Ship Sound Timer
                 BEQ      loc_7BB7         ; OLine=3899 
                 LDA      $5C              ; OLine=3900  Fast Timer
                 ROR      A                ; OLine=3901
                 BCC      loc_7BB4         ; OLine=3902 
                 DEC      $68              ; OLine=3903
                                           
loc_7BB4:                                  ; OLine=3905
                 ROR      A                ; OLine=3906 
                 ROR      A                ; OLine=3907
                 ROR      A                ; OLine=3908
                                           
loc_7BB7:                                  ; OLine=3910
                                           
                 STA      $3C05            ; OLine=3912  Life Sound
                 PLA                       ; OLine=3913
                 TAX                       ; OLine=3914
                 PLA                       ; OLine=3915
                 TAY                       ; OLine=3916 
                 PLA                       ; OLine=3917
                 RTI                       ; OLine=3918
                                           
                                           ;  ¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦ S U B R O U T I N E ¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦
                                           
                                           
sub_7BC0:                                  ; OLine=3923
                                           
                 LDA      #$B0             ; OLine=3925
                 LDY      #0               ; OLine=3926
                 STA      (2),Y            ; OLine=3927
                 INY                       ; OLine=3928
                 STA      (2),Y            ; OLine=3929
                 BNE      sub_7C39         ; OLine=3930
                                           
loc_7BCB:                                  ; OLine=3932
                 BCC      sub_7BD1         ; OLine=3933
                 AND      #$F              ; OLine=3934
                 BEQ      loc_7BD6         ; OLine=3935
                                           ;  End of function sub_7BC0
                                           
                                           
                                           ;  ¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦ S U B R O U T I N E ¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦
                                           
                                           
sub_7BD1:                                  ; OLine=3942
                                           
                 AND      #$F              ; OLine=3944
                 CLC                       ; OLine=3945
                 ADC      #1               ; OLine=3946
                                           
loc_7BD6:                                  ; OLine=3948
                 PHP                       ; OLine=3949
                 ASL      A                ; OLine=3950
                 LDY      #0               ; OLine=3951
                 TAX                       ; OLine=3952
                 LDA      $56D4,X          ; OLine=3953
                 STA      (2),Y            ; OLine=3954
                 LDA      $56D5,X          ; OLine=3955
                 INY                       ; OLine=3956
                 STA      (2),Y            ; OLine=3957
                 JSR      sub_7C39         ; OLine=3958
                 PLP                       ; OLine=3959
                 RTS                       ; OLine=3960
                                           ;  End of function sub_7BD1
                                           
                                           ;  ---------------------------------------------------------------------------
                 .BYTE    $4A              ; OLine=3964
                 .BYTE    $29              ; OLine=3965
                 .BYTE    $F               ; OLine=3966
                 .BYTE    9                ; OLine=3967
                 .BYTE    $E0              ; OLine=3968
                                           ;  ---------------------------------------------------------------------------
                                           
loc_7BF0:                                  ; OLine=3971
                 LDY      #1               ; OLine=3972
                 STA      (2),Y            ; OLine=3973
                 DEY                       ; OLine=3974
                 TXA                       ; OLine=3975
                 ROR      A                ; OLine=3976
                 STA      (2),Y            ; OLine=3977
                 INY                       ; OLine=3978
                 BNE      sub_7C39         ; OLine=3979
                                           
                                           ;  ¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦ S U B R O U T I N E ¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦
                                           
                                           
sub_7BFC:                                  ; OLine=3984
                                           
                 LSR      A                ; OLine=3986
                 AND      #$F              ; OLine=3987
                 ORA      #$C0             ; OLine=3988
                 BNE      loc_7BF0         ; OLine=3989
                                           ;  End of function sub_7BFC
                                           
                                           
                                           ;  ¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦ S U B R O U T I N E ¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦
                                           
                                           
sub_7C03:                                  ; OLine=3996
                                           
                 LDY      #0               ; OLine=3998
                 STY      5                ; OLine=3999
                 STY      7                ; OLine=4000
                 ASL      A                ; OLine=4001
                 ROL      5                ; OLine=4002
                 ASL      A                ; OLine=4003
                 ROL      5                ; OLine=4004
                 STA      4                ; OLine=4005
                 TXA                       ; OLine=4006
                 ASL      A                ; OLine=4007
                 ROL      7                ; OLine=4008
                 ASL      A                ; OLine=4009
                 ROL      7                ; OLine=4010
                 STA      6                ; OLine=4011
                 LDX      #4               ; OLine=4012
                                           ;  End of function sub_7C03
                                           
                                           
                                           ;  ¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦ S U B R O U T I N E ¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦
                                           
                                           
sub_7C1C:                                  ; OLine=4019
                 LDA      2,X              ; OLine=4020
                 LDY      #0               ; OLine=4021
                 STA      (2),Y            ; OLine=4022
                 LDA      3,X              ; OLine=4023
                 AND      #$F              ; OLine=4024
                 ORA      #$A0             ; OLine=4025
                 INY                       ; OLine=4026
                 STA      (2),Y            ; OLine=4027
                 LDA      0,X              ; OLine=4028
                 INY                       ; OLine=4029
                 STA      (2),Y            ; OLine=4030
                 LDA      1,X              ; OLine=4031
                 AND      #$F              ; OLine=4032
                 ORA      0                ; OLine=4033
                 INY                       ; OLine=4034
                 STA      (2),Y            ; OLine=4035
                                           ;  End of function sub_7C1C
                                           
                                           
                                           ;  ¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦ S U B R O U T I N E ¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦
                                           
                                           
sub_7C39:                                  ; OLine=4042
                                           
                 TYA                       ; OLine=4044
                 SEC                       ; OLine=4045
                 ADC      2                ; OLine=4046
                 STA      2                ; OLine=4047
                 BCC      locret_7C43      ; OLine=4048
                 INC      3                ; OLine=4049
                                           
locret_7C43:                               ; OLine=4051
                 RTS                       ; OLine=4052
                                           ;  End of function sub_7C39
                                           
                                           ;  ---------------------------------------------------------------------------
                 .BYTE    $A9              ; OLine=4056
                 .BYTE    $D0              ; OLine=4057
                 .BYTE    $4C              ; OLine=4058
                 .BYTE    $C2              ; OLine=4059
                 .BYTE    $7B              ; OLine=4060
                                           
                                           ;  ¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦ S U B R O U T I N E ¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦
                                           
                                           
sub_7C49:                                  ; OLine=4065
                 LDA      5                ; OLine=4066
                 CMP      #$80             ; OLine=4067
                 BCC      loc_7C60         ; OLine=4068
                 EOR      #$FF             ; OLine=4069
                 STA      5                ; OLine=4070
                 LDA      4                ; OLine=4071
                 EOR      #$FF             ; OLine=4072
                 ADC      #0               ; OLine=4073
                 STA      4                ; OLine=4074
                 BCC      loc_7C5F         ; OLine=4075
                 INC      5                ; OLine=4076
                                           
loc_7C5F:                                  ; OLine=4078
                 SEC                       ; OLine=4079
                                           
loc_7C60:                                  ; OLine=4081
                 ROL      8                ; OLine=4082
                 LDA      7                ; OLine=4083
                 CMP      #$80             ; OLine=4084
                 BCC      loc_7C79         ; OLine=4085
                 EOR      #$FF             ; OLine=4086
                 STA      7                ; OLine=4087
                 LDA      6                ; OLine=4088
                 EOR      #$FF             ; OLine=4089
                 ADC      #0               ; OLine=4090
                 STA      6                ; OLine=4091
                 BCC      loc_7C78         ; OLine=4092
                 INC      7                ; OLine=4093
                                           
loc_7C78:                                  ; OLine=4095
                 SEC                       ; OLine=4096
                                           
loc_7C79:                                  ; OLine=4098
                 ROL      8                ; OLine=4099
                 LDA      5                ; OLine=4100
                 ORA      7                ; OLine=4101
                 BEQ      loc_7C8B         ; OLine=4102
                 LDX      #0               ; OLine=4103
                 CMP      #2               ; OLine=4104
                 BCS      loc_7CAB         ; OLine=4105
                 LDY      #1               ; OLine=4106
                 BNE      loc_7C9B         ; OLine=4107
                                           
loc_7C8B:                                  ; OLine=4109
                 LDY      #2               ; OLine=4110
                 LDX      #9               ; OLine=4111
                 LDA      4                ; OLine=4112
                 ORA      6                ; OLine=4113
                 BEQ      loc_7CAB         ; OLine=4114
                 BMI      loc_7C9B         ; OLine=4115
                                           
loc_7C97:                                  ; OLine=4117
                 INY                       ; OLine=4118
                 ASL      A                ; OLine=4119
                 BPL      loc_7C97         ; OLine=4120
                                           
loc_7C9B:                                  ; OLine=4122
                                           
                 TYA                       ; OLine=4124
                 TAX                       ; OLine=4125
                 LDA      5                ; OLine=4126
                                           
loc_7C9F:                                  ; OLine=4128
                 ASL      4                ; OLine=4129
                 ROL      A                ; OLine=4130
                 ASL      6                ; OLine=4131
                 ROL      7                ; OLine=4132
                 DEY                       ; OLine=4133
                 BNE      loc_7C9F         ; OLine=4134
                 STA      5                ; OLine=4135
                                           
loc_7CAB:                                  ; OLine=4137
                                           
                 TXA                       ; OLine=4139
                 SEC                       ; OLine=4140
                 SBC      #$A              ; OLine=4141
                 EOR      #$FF             ; OLine=4142
                 ASL      A                ; OLine=4143
                 ROR      8                ; OLine=4144
                 ROL      A                ; OLine=4145
                 ROR      8                ; OLine=4146
                 ROL      A                ; OLine=4147
                 ASL      A                ; OLine=4148
                 STA      8                ; OLine=4149
                 LDY      #0               ; OLine=4150
                 LDA      6                ; OLine=4151
                 STA      (2),Y            ; OLine=4152
                 LDA      8                ; OLine=4153
                 AND      #$F4             ; OLine=4154
                 ORA      7                ; OLine=4155
                 INY                       ; OLine=4156
                 STA      (2),Y            ; OLine=4157
                 LDA      4                ; OLine=4158
                 INY                       ; OLine=4159
                 STA      (2),Y            ; OLine=4160
                 LDA      8                ; OLine=4161
                 AND      #2               ; OLine=4162
                 ASL      A                ; OLine=4163
                 ORA      1                ; OLine=4164
                 ORA      5                ; OLine=4165
                 INY                       ; OLine=4166
                 STA      (2),Y            ; OLine=4167
                 JMP      sub_7C39         ; OLine=4168
                                           ;  End of function sub_7C49
                                           
                                           
                                           ;  ¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦ S U B R O U T I N E ¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦
                                           
                                           
sub_7CDE:                                  ; OLine=4175
                                           
                 LDX      #0               ; OLine=4177
                                           ;  End of function sub_7CDE
                                           
                                           
                                           ;  ¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦ S U B R O U T I N E ¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦
                                           
                                           
sub_7CE0:                                  ; OLine=4184
                                           
                 LDY      #1               ; OLine=4186
                 STA      (2),Y            ; OLine=4187
                 DEY                       ; OLine=4188
                 TYA                       ; OLine=4189
                 STA      (2),Y            ; OLine=4190
                 INY                       ; OLine=4191
                 INY                       ; OLine=4192
                 STA      (2),Y            ; OLine=4193
                 INY                       ; OLine=4194
                 TXA                       ; OLine=4195
                 STA      (2),Y            ; OLine=4196
                 JMP      sub_7C39         ; OLine=4197
                                           ;  End of function sub_7CE0
                                           
                                           ;  ---------------------------------------------------------------------------
                                           
loc_7CF3:                                  ; OLine=4202
                 LDX      #$FE             ; OLine=4203
                 TXS                       ; OLine=4204
                 CLD                       ; OLine=4205
                 LDA      #0               ; OLine=4206
                 TAX                       ; OLine=4207
                                           
loc_7CFA:                                  ; OLine=4209
                 DEX                       ; OLine=4210
                 STA      $300,X           ; OLine=4211
                 STA      $200,X           ; OLine=4212
                 STA      $100,X           ; OLine=4213
                 STA      0,X              ; OLine=4214
                 BNE      loc_7CFA         ; OLine=4215 
                 LDY      $2007            ; OLine=4216  Self test switch
                 BMI      loc_7D50         ; OLine=4217
                 INX                       ; OLine=4218
                 STX      $4000            ; OLine=4219
                 LDA      #$E2             ; OLine=4220
                 STA      $4001            ; OLine=4221
                 LDA      #$B0             ; OLine=4222
                 STA      $4003            ; OLine=4223
                 STA      $32              ; OLine=4224
                 STA      $33              ; OLine=4225
                 LDA      #3               ; OLine=4226
                 STA      $6F              ; OLine=4227
                 STA      $3200            ; OLine=4228
                 AND      $2800            ; OLine=4229  DIP switches 8 & 7: # Of Coins For Play
                 STA      $71              ; OLine=4230
                 LDA      $2801            ; OLine=4231  DIP switches 6 & 5: Coin Multiplier, Right Slot
                 AND      #3               ; OLine=4232
                 ASL      A                ; OLine=4233
                 ASL      A                ; OLine=4234
                 ORA      $71              ; OLine=4235
                 STA      $71              ; OLine=4236
                 LDA      $2802            ; OLine=4237  DIP switches 4 & 3: 3 - # Of Starting Ships
                 AND      #2               ; OLine=4238  4 - Coin Multiplier Center/Left Slot
                 ASL      A                ; OLine=4239
                 ASL      A                ; OLine=4240
                 ASL      A                ; OLine=4241
                 ORA      $71              ; OLine=4242
                 STA      $71              ; OLine=4243
                 JMP      loc_6803         ; OLine=4244
                                           
                                           ;  ¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦ S U B R O U T I N E ¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦
                                           
                                           
sub_7D45:                                  ; OLine=4249
                                           
                 LDY      #0               ; OLine=4251
                 STA      (2),Y            ; OLine=4252
                 INY                       ; OLine=4253
                 TXA                       ; OLine=4254
                 STA      (2),Y            ; OLine=4255
                 JMP      sub_7C39         ; OLine=4256
                                           ;  End of function sub_7D45
                                           
                                           ;  ---------------------------------------------------------------------------
                                           
loc_7D50:                                  ; OLine=4261
                                           
                 STA      $4000,X          ; OLine=4263
                 STA      $4100,X          ; OLine=4264
                 STA      $4200,X          ; OLine=4265
                 STA      $4300,X          ; OLine=4266
                 STA      $4400,X          ; OLine=4267
                 STA      $4500,X          ; OLine=4268
                 STA      $4600,X          ; OLine=4269
                 STA      $4700,X          ; OLine=4270
                 INX                       ; OLine=4271
                 BNE      loc_7D50         ; OLine=4272
                 STA      $3400            ; OLine=4273
                 LDX      #0               ; OLine=4274
                                           
loc_7D70:                                  ; OLine=4276
                 LDA      0,X              ; OLine=4277
                 BNE      loc_7DBB         ; OLine=4278
                 LDA      #$11             ; OLine=4279
                                           
loc_7D76:                                  ; OLine=4281
                 STA      0,X              ; OLine=4282
                 TAY                       ; OLine=4283
                 EOR      0,X              ; OLine=4284
                 BNE      loc_7DBB         ; OLine=4285
                 TYA                       ; OLine=4286
                 ASL      A                ; OLine=4287
                 BCC      loc_7D76         ; OLine=4288
                 INX                       ; OLine=4289
                 BNE      loc_7D70         ; OLine=4290
                 STA      $3400            ; OLine=4291
                 TXA                       ; OLine=4292
                 STA      0                ; OLine=4293
                 ROL      A                ; OLine=4294
                                           
loc_7D8B:                                  ; OLine=4296
                 STA      1                ; OLine=4297
                 LDY      #0               ; OLine=4298
                                           
loc_7D8F:                                  ; OLine=4300
                                           
                 LDX      #$11             ; OLine=4302
                 LDA      (0),Y            ; OLine=4303
                 BNE      loc_7DBF         ; OLine=4304
                                           
loc_7D95:                                  ; OLine=4306
                 TXA                       ; OLine=4307
                 STA      (0),Y            ; OLine=4308
                 EOR      (0),Y            ; OLine=4309
                 BNE      loc_7DBF         ; OLine=4310
                 TXA                       ; OLine=4311
                 ASL      A                ; OLine=4312
                 TAX                       ; OLine=4313
                 BCC      loc_7D95         ; OLine=4314
                 INY                       ; OLine=4315
                 BNE      loc_7D8F         ; OLine=4316
                 STA      $3400            ; OLine=4317
                 INC      1                ; OLine=4318
                 LDX      1                ; OLine=4319
                 CPX      #4               ; OLine=4320
                 BCC      loc_7D8F         ; OLine=4321
                 LDA      #$40             ; OLine=4322
                 CPX      #$40             ; OLine=4323
                 BCC      loc_7D8B         ; OLine=4324
                 CPX      #$48             ; OLine=4325
                 BCC      loc_7D8F         ; OLine=4326
                 BCS      loc_7E24         ; OLine=4327
                                           
loc_7DBB:                                  ; OLine=4329
                                           
                 LDY      #0               ; OLine=4331
                 BEQ      loc_7DCD         ; OLine=4332
                                           
loc_7DBF:                                  ; OLine=4334
                                           
                 LDY      #0               ; OLine=4336
                 LDX      1                ; OLine=4337
                 CPX      #4               ; OLine=4338
                 BCC      loc_7DCD         ; OLine=4339
                 INY                       ; OLine=4340
                 CPX      #$44             ; OLine=4341
                 BCC      loc_7DCD         ; OLine=4342
                 INY                       ; OLine=4343
                                           
loc_7DCD:                                  ; OLine=4345
                                           
                 CMP      #$10             ; OLine=4347
                 ROL      A                ; OLine=4348
                 AND      #$1F             ; OLine=4349
                 CMP      #2               ; OLine=4350
                 ROL      A                ; OLine=4351
                 AND      #3               ; OLine=4352
                                           
loc_7DD7:                                  ; OLine=4354
                 DEY                       ; OLine=4355
                 BMI      loc_7DDE         ; OLine=4356
                 ASL      A                ; OLine=4357
                 ASL      A                ; OLine=4358
                 BCC      loc_7DD7         ; OLine=4359
                                           
loc_7DDE:                                  ; OLine=4361
                                           
                 LSR      A                ; OLine=4363
                 LDX      #$14             ; OLine=4364
                 BCC      loc_7DE5         ; OLine=4365
                 LDX      #$1D             ; OLine=4366
                                           
loc_7DE5:                                  ; OLine=4368
                 STX      $3A00            ; OLine=4369
                 LDX      #0               ; OLine=4370
                 LDY      #8               ; OLine=4371
                                           
loc_7DEC:                                  ; OLine=4373
                                           
                 BIT      $2001            ; OLine=4375
                 BPL      loc_7DEC         ; OLine=4376
                                           
loc_7DF1:                                  ; OLine=4378
                 BIT      $2001            ; OLine=4379
                 BMI      loc_7DF1         ; OLine=4380
                 DEX                       ; OLine=4381
                 STA      $3400            ; OLine=4382
                 BNE      loc_7DEC         ; OLine=4383
                 DEY                       ; OLine=4384
                 BNE      loc_7DEC         ; OLine=4385
                 STX      $3A00            ; OLine=4386
                 LDY      #8               ; OLine=4387
                                           
loc_7E04:                                  ; OLine=4389
                                           
                 BIT      $2001            ; OLine=4391
                 BPL      loc_7E04         ; OLine=4392
                                           
loc_7E09:                                  ; OLine=4394
                 BIT      $2001            ; OLine=4395
                 BMI      loc_7E09         ; OLine=4396
                 DEX                       ; OLine=4397
                 STA      $3400            ; OLine=4398
                 BNE      loc_7E04         ; OLine=4399
                 DEY                       ; OLine=4400
                 BNE      loc_7E04         ; OLine=4401
                 TAX                       ; OLine=4402
                 BNE      loc_7DDE         ; OLine=4403
                                           
loc_7E1A:                                  ; OLine=4405
                 STA      $3400            ; OLine=4406
                 LDA      $2007            ; OLine=4407
                 BMI      loc_7E1A         ; OLine=4408
                                           
loc_7E22:                                  ; OLine=4410
                 BPL      loc_7E22         ; OLine=4411
                                           
loc_7E24:                                  ; OLine=4413
                 LDA      #0               ; OLine=4414
                 TAY                       ; OLine=4415
                 TAX                       ; OLine=4416
                 STA      8                ; OLine=4417
                 LDA      #$50             ; OLine=4418
                                           
loc_7E2C:                                  ; OLine=4420
                                           
                 STA      9                ; OLine=4422
                 LDA      #4               ; OLine=4423
                 STA      $B               ; OLine=4424
                 LDA      #$FF             ; OLine=4425
                                           
loc_7E34:                                  ; OLine=4427
                                           
                 EOR      (8),Y            ; OLine=4429
                 INY                       ; OLine=4430
                 BNE      loc_7E34         ; OLine=4431
                 INC      9                ; OLine=4432
                 DEC      $B               ; OLine=4433
                 BNE      loc_7E34         ; OLine=4434
                 STA      $D,X             ; OLine=4435
                 INX                       ; OLine=4436
                 STA      $3400            ; OLine=4437
                 LDA      9                ; OLine=4438
                 CMP      #$58             ; OLine=4439
                 BCC      loc_7E2C         ; OLine=4440
                 BNE      loc_7E4F         ; OLine=4441
                 LDA      #$68             ; OLine=4442
                                           
loc_7E4F:                                  ; OLine=4444
                 CMP      #$80             ; OLine=4445
                 BCC      loc_7E2C         ; OLine=4446
                 STA      $300             ; OLine=4447
                 LDX      #4               ; OLine=4448
                 STX      $3200            ; OLine=4449
                 STX      $15              ; OLine=4450
                 LDX      #0               ; OLine=4451
                 CMP      $200             ; OLine=4452
                 BEQ      loc_7E65         ; OLine=4453
                 INX                       ; OLine=4454
                                           
loc_7E65:                                  ; OLine=4456
                 LDA      $300             ; OLine=4457
                 CMP      #$88             ; OLine=4458
                 BEQ      loc_7E6D         ; OLine=4459
                 INX                       ; OLine=4460
                                           
loc_7E6D:                                  ; OLine=4462
                 STX      $16              ; OLine=4463
                 LDA      #$10             ; OLine=4464
                 STA      0                ; OLine=4465
                                           
loc_7E73:                                  ; OLine=4467
                 LDX      #$24             ; OLine=4468
                                           
loc_7E75:                                  ; OLine=4470
                                           
                 LDA      $2001            ; OLine=4472
                 BPL      loc_7E75         ; OLine=4473
                                           
loc_7E7A:                                  ; OLine=4475
                 LDA      $2001            ; OLine=4476
                 BMI      loc_7E7A         ; OLine=4477
                 DEX                       ; OLine=4478
                 BPL      loc_7E75         ; OLine=4479
                                           
loc_7E82:                                  ; OLine=4481
                 BIT      $2002            ; OLine=4482
                 BMI      loc_7E82         ; OLine=4483
                 STA      $3400            ; OLine=4484
                 LDA      #0               ; OLine=4485
                 STA      2                ; OLine=4486
                 LDA      #$40             ; OLine=4487
                 STA      3                ; OLine=4488
                 LDA      $2005            ; OLine=4489
                 BPL      loc_7EF2         ; OLine=4490
                 LDX      $15              ; OLine=4491
                 LDA      $2003            ; OLine=4492
                 BPL      loc_7EA8         ; OLine=4493
                                           ; EOR     $0009
                 .BYTE    $4D,$09,$00      ; OLine=4495
                 BPL      loc_7EA8         ; OLine=4496
                 DEX                       ; OLine=4497
                 BEQ      loc_7EA8         ; OLine=4498
                 STX      $15              ; OLine=4499
                                           
loc_7EA8:                                  ; OLine=4501
                                           
                 LDY      $7EBB,X          ; OLine=4503
                 LDA      #$B0             ; OLine=4504
                 STA      (2),Y            ; OLine=4505
                 DEY                       ; OLine=4506
                 DEY                       ; OLine=4507
                                           
loc_7EB1:                                  ; OLine=4509
                 LDA      $7EC0,Y          ; OLine=4510
                 STA      (2),Y            ; OLine=4511
                 DEY                       ; OLine=4512
                 BPL      loc_7EB1         ; OLine=4513
                 JMP      loc_7F9D         ; OLine=4514
                                           ;  ---------------------------------------------------------------------------
                 .BYTE    $33              ; OLine=4516
                 .BYTE    $1D              ; OLine=4517
                 .BYTE    $17              ; OLine=4518
                 .BYTE    $D               ; OLine=4519
                 .BYTE    $80              ; OLine=4520
                 .BYTE    $A0              ; OLine=4521
                 .BYTE    0                ; OLine=4522
                 .BYTE    0                ; OLine=4523
                 .BYTE    0                ; OLine=4524
                 .BYTE    $70              ; OLine=4525
                 .BYTE    0                ; OLine=4526
                 .BYTE    0                ; OLine=4527
                 .BYTE    $FF              ; OLine=4528
                 .BYTE    $92              ; OLine=4529
                 .BYTE    $FF              ; OLine=4530
                 .BYTE    $73              ; OLine=4531
                 .BYTE    $D0              ; OLine=4532
                 .BYTE    $A1              ; OLine=4533
                 .BYTE    $30              ; OLine=4534
                 .BYTE    2                ; OLine=4535
                 .BYTE    0                ; OLine=4536
                 .BYTE    $70              ; OLine=4537
                 .BYTE    0                ; OLine=4538
                 .BYTE    0                ; OLine=4539
                 .BYTE    $7F              ; OLine=4540
                 .BYTE    $FB              ; OLine=4541
                 .BYTE    $D               ; OLine=4542
                 .BYTE    $E0              ; OLine=4543
                 .BYTE    0                ; OLine=4544
                 .BYTE    $B0              ; OLine=4545
                 .BYTE    $7E              ; OLine=4546
                 .BYTE    $FA              ; OLine=4547
                 .BYTE    $11              ; OLine=4548
                 .BYTE    $C0              ; OLine=4549
                 .BYTE    $78              ; OLine=4550
                 .BYTE    $FE              ; OLine=4551
                 .BYTE    0                ; OLine=4552
                 .BYTE    $B0              ; OLine=4553
                 .BYTE    $13              ; OLine=4554
                 .BYTE    $C0              ; OLine=4555
                 .BYTE    0                ; OLine=4556
                 .BYTE    $D0              ; OLine=4557
                 .BYTE    $15              ; OLine=4558
                 .BYTE    $C0              ; OLine=4559
                 .BYTE    0                ; OLine=4560
                 .BYTE    $D0              ; OLine=4561
                 .BYTE    $17              ; OLine=4562
                 .BYTE    $C0              ; OLine=4563
                 .BYTE    0                ; OLine=4564
                 .BYTE    $D0              ; OLine=4565
                 .BYTE    $7A              ; OLine=4566
                 .BYTE    $F8              ; OLine=4567
                 .BYTE    0                ; OLine=4568
                 .BYTE    $D0              ; OLine=4569
                                           ;  ---------------------------------------------------------------------------
                                           
loc_7EF2:                                  ; OLine=4572
                 LDA      #$50             ; OLine=4573
                 LDX      #0               ; OLine=4574
                 JSR      sub_7BFC         ; OLine=4575
                 LDA      #$69             ; OLine=4576
                 LDX      #$93             ; OLine=4577
                 JSR      sub_7C03         ; OLine=4578
                 LDA      #$30             ; OLine=4579
                 JSR      sub_7CDE         ; OLine=4580
                 LDX      #3               ; OLine=4581
                                           
loc_7F07:                                  ; OLine=4583
                 LDA      $2800,X          ; OLine=4584
                 AND      #1               ; OLine=4585
                 STX      $B               ; OLine=4586
                 JSR      sub_7BD1         ; OLine=4587
                 LDX      $B               ; OLine=4588
                 LDA      $2800,X          ; OLine=4589
                 AND      #2               ; OLine=4590
                 LSR      A                ; OLine=4591
                 JSR      sub_7BD1         ; OLine=4592
                 LDX      $B               ; OLine=4593
                 DEX                       ; OLine=4594
                 BPL      loc_7F07         ; OLine=4595
                 LDA      #$7A             ; OLine=4596
                 LDX      #$9D             ; OLine=4597
                 JSR      sub_7C03         ; OLine=4598
                 LDA      #$10             ; OLine=4599
                 JSR      sub_7CDE         ; OLine=4600
                 LDA      $2802            ; OLine=4601
                 AND      #2               ; OLine=4602
                 LSR      A                ; OLine=4603
                 ADC      #1               ; OLine=4604
                 JSR      sub_7BD1         ; OLine=4605
                 LDA      $2801            ; OLine=4606
                 AND      #3               ; OLine=4607
                 TAX                       ; OLine=4608
                 LDA      $7FF5,X          ; OLine=4609
                 JSR      sub_7BD1         ; OLine=4610
                 LDA      $16              ; OLine=4611
                 BEQ      loc_7F4F         ; OLine=4612
                 LDX      #$88             ; OLine=4613
                 LDA      #$50             ; OLine=4614
                 JSR      sub_7BFC         ; OLine=4615
                                           
loc_7F4F:                                  ; OLine=4617
                 LDX      #$96             ; OLine=4618
                                           ;  STX     $C
                 .byte    $8E,$C,$00       ; OLine=4620
                 LDX      #7               ; OLine=4621
                                           
loc_7F56:                                  ; OLine=4623
                 LDA      $D,X             ; OLine=4624
                 BEQ      loc_7F91         ; OLine=4625
                 PHA                       ; OLine=4626
                                           ; STX     $B
                 .byte    $8E,$B,$00       ; OLine=4628
                                           ; LDX     $C
                 .byte    $AE,$C,$00       ; OLine=4630
                 TXA                       ; OLine=4631
                 SEC                       ; OLine=4632
                 SBC      #8               ; OLine=4633
                                           ; STA     $C
                 .byte    $8D,$0C,$00      ; OLine=4635
                 LDA      #$20             ; OLine=4636
                 JSR      sub_7C03         ; OLine=4637
                 LDA      #$70             ; OLine=4638
                 JSR      sub_7CDE         ; OLine=4639
                                           ; LDA     $B
                 .byte    $AD,$0B,$00      ; OLine=4641
                 JSR      sub_7BD1         ; OLine=4642
                 LDA      $56D4            ; OLine=4643
                 LDX      $56D5            ; OLine=4644
                 JSR      sub_7D45         ; OLine=4645
                 PLA                       ; OLine=4646
                 PHA                       ; OLine=4647
                 LSR      A                ; OLine=4648
                 LSR      A                ; OLine=4649
                 LSR      A                ; OLine=4650
                 LSR      A                ; OLine=4651
                 JSR      sub_7BD1         ; OLine=4652
                 PLA                       ; OLine=4653
                 JSR      sub_7BD1         ; OLine=4654
                                           ; LDX     $B
                 .byte    $AE,$0B,$ 00     ; OLine=4656
                                           
loc_7F91:                                  ; OLine=4658
                 DEX                       ; OLine=4659
                 BPL      loc_7F56         ; OLine=4660
                 LDA      #$7F             ; OLine=4661
                 TAX                       ; OLine=4662
                 JSR      sub_7C03         ; OLine=4663
                 JSR      sub_7BC0         ; OLine=4664
                                           
loc_7F9D:                                  ; OLine=4666
                 LDA      #0               ; OLine=4667
                 LDX      #4               ; OLine=4668
                                           
loc_7FA1:                                  ; OLine=4670
                 ROL      $2003,X          ; OLine=4671
                 ROR      A                ; OLine=4672
                 DEX                       ; OLine=4673
                 BPL      loc_7FA1         ; OLine=4674
                 TAY                       ; OLine=4675
                 LDX      #7               ; OLine=4676
                                           
loc_7FAB:                                  ; OLine=4678
                 ROL      $2400,X          ; OLine=4679
                 ROL      A                ; OLine=4680
                 DEX                       ; OLine=4681
                 BPL      loc_7FAB         ; OLine=4682
                 TAX                       ; OLine=4683
                 EOR      8                ; OLine=4684
                 STX      8                ; OLine=4685
                 PHP                       ; OLine=4686
                 LDA      #4               ; OLine=4687
                 STA      $3200            ; OLine=4688
                 ROL      $2003            ; OLine=4689
                 ROL      A                ; OLine=4690
                 ROL      $2004            ; OLine=4691
                 ROL      A                ; OLine=4692
                 ROL      $2407            ; OLine=4693
                 ROL      A                ; OLine=4694
                 ROL      $2406            ; OLine=4695
                 ROL      A                ; OLine=4696
                 ROL      $2405            ; OLine=4697
                 ROL      A                ; OLine=4698
                 TAX                       ; OLine=4699
                 PLP                       ; OLine=4700
                 BNE      loc_7FDE         ; OLine=4701
                 EOR      $A               ; OLine=4702
                 BNE      loc_7FDE         ; OLine=4703
                 TYA                       ; OLine=4704
                 EOR      9                ; OLine=4705
                 BEQ      loc_7FE0         ; OLine=4706
                                           
loc_7FDE:                                  ; OLine=4708
                                           
                 LDA      #$80             ; OLine=4710
                                           
loc_7FE0:                                  ; OLine=4712
                 STA      $3C05            ; OLine=4713
                 STA      $3200            ; OLine=4714
                 STA      $3000            ; OLine=4715
                 STX      $A               ; OLine=4716
                 STY      9                ; OLine=4717
                 LDA      $2007            ; OLine=4718
                                           
loc_7FF0:                                  ; OLine=4720
                 BPL      loc_7FF0         ; OLine=4721
                 JMP      loc_7E73         ; OLine=4722
                                           ;  ---------------------------------------------------------------------------
                 .BYTE    1                ; OLine=4724
                 .BYTE    4                ; OLine=4725
                 .BYTE    5                ; OLine=4726
                 .BYTE    6                ; OLine=4727
                 .BYTE    $4E              ; OLine=4728
                                           
                 .BYTE    $65              ; OLine=4730  NMI
                 .BYTE    $7B              ; OLine=4731
                                           
                 .BYTE    $F3              ; OLine=4733  RESET
                 .BYTE    $7C              ; OLine=4734
                                           
                 .BYTE    $F3              ; OLine=4736  IRQ
                 .BYTE    $7C              ; OLine=4737
                                           ;  end of 'ROM'
                                           
                 .END                      ; OLine=4740
                                           
