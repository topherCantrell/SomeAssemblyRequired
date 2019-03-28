                                           
                                           ;  processor 6502
                                           
                                           ; <EditorTab name="BUILD">
                                           ;  *** Complie the assembly
                                           ;  build-command java Blend Asteroids.asm AstoidsBLEND.asm
                                           ;  build-command tasm -b -65 AsteroidsBLEND.asm Asteroids.bin
                                           
                                           ;  *** Split the resulting binary into the 3 EPROMs needed by MAME
                                           ;  build-command java EpromTool -split Asteroids.bin 035145.02 035144.02 035143.02
                                           
                                           ;  *** Copy results to the MAME directory for running
                                           ;  build-command jar -cfM c:\mame\roms\asteroid.zip *.02
                                           
                                           ; </EditorTab>
                                           
                                           
                                           ;  NOTE: This code is property of Atari Inc. All requests from said company to remove
                                           ;  This code from public display will be honored
                                           ;  Disassembly By Lonnie Howell     displacer1@excite.com
                                           ;  Updated 10/8/04
                                           
                                           ; <EditorTab name="RAM">
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
                                           
                                           ; </EditorTab>
                                           
                                           ; <EditorTab name="Hardware">
                                           
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
                                           ; </EditorTab>
                                           
                                           
                                           
                 .ORG     $6800            ; OLine=100
                 JMP      main             ; OLine=101
                                           
loc_6803:                                  ; OLine=103
                                           
                 JSR      sub_6EFA         ; OLine=105  Reset Sound, Zero Out Sound Timers
                 JSR      sub_6ED8         ; OLine=106  Number Of Starting Ships To $56 And Zero
                                           ;  Out Players Scores *BUG*
loc_6809:                                  ; OLine=108
                 JSR      sub_7168         ; OLine=109 
                                           
loc_680C:                                  ; OLine=111
                                           
                 LDA      $2007            ; OLine=113  Self test switch
                                           
loc_680F:                                  ; OLine=115
                 BMI      loc_680F         ; OLine=116  Branch If Switch Is On
                 LSR      $5B              ; OLine=117 
                 BCC      loc_680C         ; OLine=118 
                                           
loc_6815:                                  ; OLine=120
                 LDA      $2002            ; OLine=121  HALT
                 BMI      loc_6815         ; OLine=122  Wait For State Machine To Finish
                 LDA      $4001            ; OLine=123 
                 EOR      #2               ; OLine=124 
                 STA      $4001            ; OLine=125 
                 STA      $3000            ; OLine=126  DMAGO
                 STA      $3400            ; OLine=127  Reset WatchDog
                 INC      $5C              ; OLine=128  Update Fast Timer
                 BNE      loc_682E         ; OLine=129 
                 INC      $5D              ; OLine=130  Update Slow Timer
                                           
loc_682E:                                  ; OLine=132
                 LDX      #$40             ; OLine=133 
                 AND      #2               ; OLine=134 
                 BNE      loc_6836         ; OLine=135 
                 LDX      #$44             ; OLine=136 
                                           
loc_6836:                                  ; OLine=138
                 LDA      #2               ; OLine=139 
                 STA      2                ; OLine=140 
                 STX      3                ; OLine=141 
                 JSR      sub_6885         ; OLine=142 
                 BCS      loc_6803         ; OLine=143 
                 JSR      sub_765C         ; OLine=144 
                 JSR      sub_6D90         ; OLine=145 
                 BPL      loc_6864         ; OLine=146 
                 JSR      sub_73C4         ; OLine=147 
                 BCS      loc_6864         ; OLine=148 
                 LDA      $5A              ; OLine=149 
                 BNE      loc_685E         ; OLine=150 
                 JSR      sub_6CD7         ; OLine=151 
                 JSR      sub_6E74         ; OLine=152 
                 JSR      sub_703F         ; OLine=153 
                 JSR      sub_6B93         ; OLine=154 
                                           
loc_685E:                                  ; OLine=156
                 JSR      sub_6F57         ; OLine=157 
                 JSR      sub_69F0         ; OLine=158 
                                           
loc_6864:                                  ; OLine=160
                                           
                 JSR      sub_724F         ; OLine=162 
                 JSR      sub_7555         ; OLine=163 
                 LDA      #$7F             ; OLine=164 
                 TAX                       ; OLine=165 
                 JSR      sub_7C03         ; OLine=166 
                 JSR      sub_77B5         ; OLine=167 
                 JSR      sub_7BC0         ; OLine=168 
                 LDA      $2FB             ; OLine=169 
                 BEQ      loc_687E         ; OLine=170 
                 DEC      $2FB             ; OLine=171 
                                           
loc_687E:                                  ; OLine=173
                 ORA      $2F6             ; OLine=174 
                 BNE      loc_680C         ; OLine=175 
                 BEQ      loc_6809         ; OLine=176 
                                           
                                           ;  ¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦ S U B R O U T I N E ¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦
                                           
                                           
sub_6885:                                  ; OLine=181
                 LDA      $1C              ; OLine=182  Number Of Players In Current Game
                 BEQ      loc_689D         ; OLine=183  None, Branch
                 LDA      $5A              ; OLine=184 
                 BNE      loc_6890         ; OLine=185 
                 JMP      loc_6960         ; OLine=186 
                                           ;  ---------------------------------------------------------------------------
                                           
loc_6890:                                  ; OLine=189
                 DEC      $5A              ; OLine=190 
                 JSR      sub_69E2         ; OLine=191 
                                           
loc_6895:                                  ; OLine=193
                 CLC                       ; OLine=194 
                 RTS                       ; OLine=195 
                                           ;  ---------------------------------------------------------------------------
                                           
loc_6897:                                  ; OLine=198
                 LDA      #2               ; OLine=199  Free Credits!
                 STA      $70              ; OLine=200  Can Only Play A 2 Player Game, So Only Need To Add 2
                 BNE      loc_68B0         ; OLine=201  Credits For Free Play
                                           
loc_689D:                                  ; OLine=203
                 LDA      $71              ; OLine=204  DIP Switch Settings Bitmap
                 AND      #3               ; OLine=205  Mask Off Settings For Switches 8 & 7
                 BEQ      loc_6897         ; OLine=206  Check For Free Play, Branch If Yes
                 CLC                       ; OLine=207 
                 ADC      #7               ; OLine=208  Determine Which Message To Display Based On DIP Settings
                 TAY                       ; OLine=209  Into Y For The Offset
                                           ;  Y = 8, "1 COIN 2 PLAYS"
                                           ;  Y = 9, "1 COIN 1 PLAY"
                                           ;  Y = A, "2 COINS 1 PLAY"
                 LDA      $32              ; OLine=213 
                 AND      $33              ; OLine=214 
                 BPL      loc_68B0         ; OLine=215 
                 JSR      sub_77F6         ; OLine=216  And Draw It To Screen
                                           
loc_68B0:                                  ; OLine=218
                                           
                 LDY      $70              ; OLine=220  Current Number Of Credits
                 BEQ      loc_6895         ; OLine=221  No Credits, Branch
                 LDX      #1               ; OLine=222  Assume 1 Player Game 
                 LDA      $2403            ; OLine=223  1 Player start button
                 BMI      loc_68DE         ; OLine=224  Branch If Pressed
                 CPY      #2               ; OLine=225  Enough Credits For A 2 Player Game?
                 BCC      loc_693B         ; OLine=226  No, Branch
                 LDA      $2404            ; OLine=227  2 Player start button
                 BPL      loc_693B         ; OLine=228  Branch if NOT pressed
                 LDA      $6F              ; OLine=229  $3200 Bitmap
                 ORA      #4               ; OLine=230  Set Bit 3, RAMSEL (Swap In $0200 Memory)
                 STA      $6F              ; OLine=231  Update Bitmap
                 STA      $3200            ; OLine=232  And Make The Change
                 JSR      sub_6ED8         ; OLine=233 
                 JSR      sub_7168         ; OLine=234 
                 JSR      sub_71E8         ; OLine=235 
                 LDA      $56              ; OLine=236  Number Of Starting Ships
                 STA      $58              ; OLine=237  To Player 2 Current Ships
                 LDX      #2               ; OLine=238  2 Player Game
                 DEC      $70              ; OLine=239  Subtract Credit
                                           
loc_68DE:                                  ; OLine=241
                 STX      $1C              ; OLine=242  Flag Number Of Players In Current Game
                 DEC      $70              ; OLine=243  Subtract Credit
                 LDA      $6F              ; OLine=244  $3200 Bitmap
                 AND      #$F8             ; OLine=245 
                 EOR      $1C              ; OLine=246  Change Player Start Lamps For This Game
                 STA      $6F              ; OLine=247  Update Bitmap
                 STA      $3200            ; OLine=248  And Make The Change
                 JSR      sub_71E8         ; OLine=249 
                 LDA      #1               ; OLine=250 
                 STA      $2FA             ; OLine=251 
                 STA      $3FA             ; OLine=252 
                 LDA      #$92             ; OLine=253 
                 STA      $2F8             ; OLine=254 
                 STA      $3F8             ; OLine=255 
                 STA      $3F7             ; OLine=256 
                 STA      $2F7             ; OLine=257  Countdown Timer For When Saucer Appears
                 LDA      #$7F             ; OLine=258 
                 STA      $2FB             ; OLine=259 
                 STA      $3FB             ; OLine=260 
                 LDA      #5               ; OLine=261 
                 STA      $2FD             ; OLine=262 
                 STA      $3FD             ; OLine=263 
                 LDA      #$FF             ; OLine=264 
                 STA      $32              ; OLine=265 
                 STA      $33              ; OLine=266 
                 LDA      #$80             ; OLine=267 
                 STA      $5A              ; OLine=268 
                 ASL      A                ; OLine=269  Zero A, And Set Carry Flag
                 STA      $18              ; OLine=270  Current Player. New Game So Start With Player 1
                 STA      $19              ; OLine=271 
                 LDA      $56              ; OLine=272 
                 STA      $57              ; OLine=273 
                 LDA      #4               ; OLine=274 
                 STA      $6C              ; OLine=275 
                 STA      $6E              ; OLine=276 
                 LDA      #$30             ; OLine=277 
                 STA      $2FC             ; OLine=278  Starting Value For Timer @ $6E
                 STA      $3FC             ; OLine=279 
                 STA      $3E00            ; OLine=280 
                 RTS                       ; OLine=281  Noise Reset
                                           ;  ---------------------------------------------------------------------------
                                           
loc_693B:                                  ; OLine=284
                                           
                 LDA      $32              ; OLine=286 
                 AND      $32              ; OLine=287 
                 BPL      loc_694C         ; OLine=288 
                 LDA      $5C              ; OLine=289  Fast Timer
                 AND      #$20             ; OLine=290  Time To Draw Message To Screen?
                 BNE      loc_694C         ; OLine=291  No, Branch
                 LDY      #6               ; OLine=292  Offset For "PUSH START"
                 JSR      sub_77F6         ; OLine=293  And Draw It On Screen
                                           
loc_694C:                                  ; OLine=295
                                           
                 LDA      $5C              ; OLine=297  Fast Timer
                 AND      #$F              ; OLine=298  Time To Blink Player Start Lamp(s)?
                 BNE      loc_695E         ; OLine=299  No, Branch
                 LDA      #1               ; OLine=300 
                 CMP      $70              ; OLine=301  Current Number Of Credits
                 ADC      #1               ; OLine=302  Calculate Which Lamp(s) To Blink
                 EOR      #1               ; OLine=303 
                 EOR      $6F              ; OLine=304  Switch Their Status (On Or Off)
                 STA      $6F              ; OLine=305  Update Bitmap
                                           
loc_695E:                                  ; OLine=307
                 CLC                       ; OLine=308 
                 RTS                       ; OLine=309 
                                           ;  ---------------------------------------------------------------------------
                                           
loc_6960:                                  ; OLine=312
                 LDA      $5C              ; OLine=313  Fast Timer
                 AND      #$3F             ; OLine=314 
                 BNE      loc_6970         ; OLine=315 
                 LDA      $2FC             ; OLine=316  Starting Value For Timer @ $6E
                 CMP      #8               ; OLine=317  At The Lowest Value It Can Be?
                 BEQ      loc_6970         ; OLine=318  Yes, Branch
                 DEC      $2FC             ; OLine=319 
                                           
loc_6970:                                  ; OLine=321
                                           
                 LDX      $18              ; OLine=323  Current Player
                 LDA      $57,X            ; OLine=324  Number Of Ships For Current Player
                 BNE      loc_6992         ; OLine=325  Any Ships Left? Branch If Yes
                 LDA      $21F             ; OLine=326  Check If Current Player Has Any Shots Active
                 ORA      $220             ; OLine=327 
                 ORA      $221             ; OLine=328 
                 ORA      $222             ; OLine=329 
                 BNE      loc_6992         ; OLine=330  Still Have Active Shots, Branch
                 LDY      #7               ; OLine=331  Offset For "GAME OVER"
                 JSR      sub_77F6         ; OLine=332  And Draw It To Screen
                 LDA      $1C              ; OLine=333  Number Of Players In Current Game
                 CMP      #2               ; OLine=334  2 Player Game?
                 BCC      loc_6992         ; OLine=335  No, Branch
                 JSR      sub_69E2         ; OLine=336  Display On Screen Which Player's Game Is Over
                                           
loc_6992:                                  ; OLine=338
                                           
                 LDA      $21B             ; OLine=340 
                 BNE      loc_69CD         ; OLine=341 
                 LDA      $2FA             ; OLine=342 
                 CMP      #$80             ; OLine=343 
                 BNE      loc_69CD         ; OLine=344 
                 LDA      #$10             ; OLine=345 
                 STA      $2FA             ; OLine=346 
                 LDX      $1C              ; OLine=347  Number Of Players In Current Game
                 LDA      $57              ; OLine=348  Check If ANY Player Has ANY Ships Left
                 ORA      $58              ; OLine=349 
                 BEQ      loc_69CF         ; OLine=350  Branch If All Players Are Out Of Ships
                 JSR      sub_702D         ; OLine=351 
                 DEX                       ; OLine=352 
                 BEQ      loc_69CD         ; OLine=353  Will Branch If Only 1 Player Remaining In Game
                 LDA      #$80             ; OLine=354 
                 STA      $5A              ; OLine=355 
                 LDA      $18              ; OLine=356  Current Player
                 EOR      #1               ; OLine=357  Switch To Next Player
                 TAX                       ; OLine=358 
                 LDA      $57,X            ; OLine=359  Any Ships Left For This Player?
                 BEQ      loc_69CD         ; OLine=360  No, Branch
                 STX      $18              ; OLine=361  Flag Switch To Next Player
                 LDA      #4               ; OLine=362  And Switch RAM To Next Player
                 EOR      $6F              ; OLine=363  Bit 3, RAMSEL
                 STA      $6F              ; OLine=364  Update Bitmap
                 STA      $3200            ; OLine=365  Make The Switch 
                 TXA                       ; OLine=366 
                 ASL      A                ; OLine=367 
                 STA      $19              ; OLine=368 
                                           
loc_69CD:                                  ; OLine=370
                                           
                 CLC                       ; OLine=372 
                 RTS                       ; OLine=373 
                                           ;  ---------------------------------------------------------------------------
                                           
loc_69CF:                                  ; OLine=376
                 STX      $1A              ; OLine=377 
                 LDA      #$FF             ; OLine=378 
                 STA      $1C              ; OLine=379  Number Of Players In Current Game
                 JSR      sub_6EFA         ; OLine=380  Turn Off All Sounds, Zero Sound Timers
                 LDA      $6F              ; OLine=381  Bitmap Of $3200
                 AND      #$F8             ; OLine=382 
                 ORA      #3               ; OLine=383  Turn On Player 1 & 2 Start Lamps
                 STA      $6F              ; OLine=384  Update Bitmap
                 CLC                       ; OLine=385 
                 RTS                       ; OLine=386 
                                           ;  End of function sub_6885
                                           
                                           
                                           ;  ¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦ S U B R O U T I N E ¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦
                                           
                                           
sub_69E2:                                  ; OLine=393
                                           
                 LDY      #1               ; OLine=395  Offset For "PLAYER "
                 JSR      sub_77F6         ; OLine=396  And Draw It On Screen
                 LDY      $18              ; OLine=397  Current Player
                 INY                       ; OLine=398  Used To Draw Either "1" Or "2" After "PLAYER "
                 TYA                       ; OLine=399 
                 JSR      sub_7BD1         ; OLine=400  Draw It To Screen
                 RTS                       ; OLine=401
                                           ;  End of function sub_69E2
                                           
                                           ;  ---------------------------------------------------------------------------
                 .BYTE    $71              ; OLine=405
                                           
                                           ;  ¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦ S U B R O U T I N E ¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦
                                           
                                           
sub_69F0:                                  ; OLine=410
                 LDX      #7               ; OLine=411 
                                           
loc_69F2:                                  ; OLine=413
                 LDA      $21B,X           ; OLine=414  Check If Any Active Shot In This Slot
                 BEQ      loc_69F9         ; OLine=415  No, Branch
                 BPL      loc_69FD         ; OLine=416  Shot Still Active, Branch
                                           
loc_69F9:                                  ; OLine=418
                                           
                 DEX                       ; OLine=420 
                 BPL      loc_69F2         ; OLine=421 
                 RTS                       ; OLine=422 
                                           ;  ---------------------------------------------------------------------------
                                           
loc_69FD:                                  ; OLine=425
                 LDY      #$1C             ; OLine=426 
                 CPX      #4               ; OLine=427 
                 BCS      loc_6A0A         ; OLine=428 
                 DEY                       ; OLine=429 
                 TXA                       ; OLine=430
                 BNE      loc_6A0A         ; OLine=431
                                           
loc_6A07:                                  ; OLine=433
                                           
                 DEY                       ; OLine=435
                 BMI      loc_69F9         ; OLine=436 
                                           
loc_6A0A:                                  ; OLine=438
                                           
                 LDA      $200,Y           ; OLine=440 
                 BEQ      loc_6A07         ; OLine=441 
                 BMI      loc_6A07         ; OLine=442 
                 STA      $B               ; OLine=443 
                 LDA      $2AF,Y           ; OLine=444 
                 SEC                       ; OLine=445 
                 SBC      $2CA,X           ; OLine=446 
                 STA      8                ; OLine=447 
                 LDA      $269,Y           ; OLine=448 
                 SBC      $284,X           ; OLine=449 
                 LSR      A                ; OLine=450 
                 ROR      8                ; OLine=451 
                 ASL      A                ; OLine=452 
                 BEQ      loc_6A34         ; OLine=453 
                 BPL      loc_6A97         ; OLine=454 
                 EOR      #$FE             ; OLine=455 
                 BNE      loc_6A97         ; OLine=456 
                 LDA      8                ; OLine=457 
                 EOR      #$FF             ; OLine=458 
                 STA      8                ; OLine=459 
                                           
loc_6A34:                                  ; OLine=461
                 LDA      $2D2,Y           ; OLine=462 
                 SEC                       ; OLine=463 
                 SBC      $2ED,X           ; OLine=464 
                 STA      9                ; OLine=465 
                 LDA      $28C,Y           ; OLine=466 
                 SBC      $2A7,X           ; OLine=467 
                 LSR      A                ; OLine=468 
                 ROR      9                ; OLine=469 
                 ASL      A                ; OLine=470 
                 BEQ      loc_6A55         ; OLine=471 
                 BPL      loc_6A97         ; OLine=472 
                 EOR      #$FE             ; OLine=473 
                 BNE      loc_6A97         ; OLine=474 
                 LDA      9                ; OLine=475 
                 EOR      #$FF             ; OLine=476 
                 STA      9                ; OLine=477 
                                           
loc_6A55:                                  ; OLine=479
                 LDA      #$2A             ; OLine=480 
                 LSR      $B               ; OLine=481 
                 BCS      loc_6A63         ; OLine=482 
                 LDA      #$48             ; OLine=483 
                 LSR      $B               ; OLine=484 
                 BCS      loc_6A63         ; OLine=485 
                 LDA      #$84             ; OLine=486 
                                           
loc_6A63:                                  ; OLine=488
                                           
                 CPX      #1               ; OLine=490 
                 BCS      loc_6A69         ; OLine=491 
                 ADC      #$1C             ; OLine=492 
                                           
loc_6A69:                                  ; OLine=494
                 BNE      loc_6A77         ; OLine=495 
                 ADC      #$12             ; OLine=496 
                 LDX      $21C             ; OLine=497  Saucer Flag
                 DEX                       ; OLine=498 
                 BEQ      loc_6A75         ; OLine=499  Small Saucer, Branch
                 ADC      #$12             ; OLine=500 
                                           
loc_6A75:                                  ; OLine=502
                 LDX      #1               ; OLine=503 
                                           
loc_6A77:                                  ; OLine=505
                 CMP      8                ; OLine=506 
                 BCC      loc_6A97         ; OLine=507 
                 CMP      9                ; OLine=508 
                 BCC      loc_6A97         ; OLine=509 
                 STA      $B               ; OLine=510 
                 LSR      A                ; OLine=511 
                 CLC                       ; OLine=512 
                 ADC      $B               ; OLine=513 
                 STA      $B               ; OLine=514 
                 LDA      9                ; OLine=515 
                 ADC      8                ; OLine=516 
                 BCS      loc_6A97         ; OLine=517 
                 CMP      $B               ; OLine=518 
                 BCS      loc_6A97         ; OLine=519
                 JSR      sub_6B0F         ; OLine=520
                                           
loc_6A94:                                  ; OLine=522
                 JMP      loc_69F9         ; OLine=523 
                                           ;  ---------------------------------------------------------------------------
                                           
loc_6A97:                                  ; OLine=526
                                           
                 DEY                       ; OLine=528
                 BMI      loc_6A94         ; OLine=529 
                 JMP      loc_6A0A         ; OLine=530
                                           ;  End of function sub_69F0
                                           
                                           
                                           ;  ¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦ S U B R O U T I N E ¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦
                                           
                                           
sub_6A9D:                                  ; OLine=537
                                           
                 LDA      $200,Y           ; OLine=539 
                 AND      #7               ; OLine=540 
                 STA      8                ; OLine=541 
                 JSR      sub_77B5         ; OLine=542 
                 AND      #$18             ; OLine=543 
                 ORA      8                ; OLine=544 
                 STA      $200,X           ; OLine=545 
                 LDA      $2AF,Y           ; OLine=546
                 STA      $2AF,X           ; OLine=547
                 LDA      $269,Y           ; OLine=548
                 STA      $269,X           ; OLine=549 
                 LDA      $2D2,Y           ; OLine=550
                 STA      $2D2,X           ; OLine=551
                 LDA      $28C,Y           ; OLine=552
                 STA      $28C,X           ; OLine=553
                 LDA      $223,Y           ; OLine=554
                 STA      $223,X           ; OLine=555
                 LDA      $246,Y           ; OLine=556 
                 STA      $246,X           ; OLine=557
                 RTS                       ; OLine=558
                                           ;  End of function sub_6A9D
                                           
                                           
                                           ;  ¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦ S U B R O U T I N E ¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦
                                           
                                           
sub_6AD3:                                  ; OLine=565
                                           
                 STA      $B               ; OLine=567 
                 STX      $C               ; OLine=568
                                           ;  End of function sub_6AD3
                                           
                                           
                                           ;  ¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦ S U B R O U T I N E ¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦
                                           
                                           
sub_6AD7:                                  ; OLine=575
                 LDY      #0               ; OLine=576 
                                           
loc_6AD9:                                  ; OLine=578
                 INY                       ; OLine=579 
                 LDA      ($B),Y           ; OLine=580 
                 EOR      9                ; OLine=581
                 STA      (2),Y            ; OLine=582
                 DEY                       ; OLine=583
                 CMP      #$F0             ; OLine=584
                 BCS      loc_6B03         ; OLine=585 
                 CMP      #$A0             ; OLine=586
                 BCS      loc_6AFF         ; OLine=587
                 LDA      ($B),Y           ; OLine=588
                 STA      (2),Y            ; OLine=589
                 INY                       ; OLine=590
                 INY                       ; OLine=591
                 LDA      ($B),Y           ; OLine=592 
                 STA      (2),Y            ; OLine=593
                 INY                       ; OLine=594
                 LDA      ($B),Y           ; OLine=595 
                 EOR      8                ; OLine=596
                 ADC      $17              ; OLine=597
                 STA      (2),Y            ; OLine=598 
                                           
loc_6AFC:                                  ; OLine=600
                 INY                       ; OLine=601
                 BNE      loc_6AD9         ; OLine=602 
                                           
loc_6AFF:                                  ; OLine=604
                 DEY                       ; OLine=605
                 JMP      sub_7C39         ; OLine=606 
                                           ;  ---------------------------------------------------------------------------
                                           
loc_6B03:                                  ; OLine=609
                 LDA      ($B),Y           ; OLine=610 
                 EOR      8                ; OLine=611
                 CLC                       ; OLine=612
                 ADC      $17              ; OLine=613
                 STA      (2),Y            ; OLine=614
                 INY                       ; OLine=615
                 BNE      loc_6AFC         ; OLine=616 
                                           ;  End of function sub_6AD7
                                           
                                           
                                           ;  ¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦ S U B R O U T I N E ¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦
                                           
                                           
sub_6B0F:                                  ; OLine=623
                 CPX      #1               ; OLine=624
                 BNE      loc_6B1B         ; OLine=625 
                 CPY      #$1B             ; OLine=626
                 BNE      loc_6B29         ; OLine=627 
                 LDX      #0               ; OLine=628
                 LDY      #$1C             ; OLine=629 
                                           
loc_6B1B:                                  ; OLine=631
                 TXA                       ; OLine=632 
                 BNE      loc_6B3C         ; OLine=633
                 LDA      #$81             ; OLine=634
                 STA      $2FA             ; OLine=635 
                 LDX      $18              ; OLine=636  Current Player
                 DEC      $57,X            ; OLine=637  Subtract Ship
                 LDX      #0               ; OLine=638 
                                           
loc_6B29:                                  ; OLine=640
                 LDA      #$A0             ; OLine=641
                 STA      $21B,X           ; OLine=642 
                 LDA      #0               ; OLine=643
                 STA      $23E,X           ; OLine=644
                 STA      $261,X           ; OLine=645
                 CPY      #$1B             ; OLine=646
                 BCC      loc_6B47         ; OLine=647 
                 BCS      loc_6B73         ; OLine=648
                                           
loc_6B3C:                                  ; OLine=650
                 LDA      #0               ; OLine=651
                 STA      $21B,X           ; OLine=652 
                 CPY      #$1B             ; OLine=653
                 BEQ      loc_6B66         ; OLine=654
                 BCS      loc_6B73         ; OLine=655 
                                           
loc_6B47:                                  ; OLine=657
                 JSR      sub_75EC         ; OLine=658 
                                           
loc_6B4A:                                  ; OLine=660
                                           
                 LDA      $200,Y           ; OLine=662 
                 AND      #3               ; OLine=663
                 EOR      #2               ; OLine=664
                 LSR      A                ; OLine=665 
                 ROR      A                ; OLine=666
                 ROR      A                ; OLine=667
                 ORA      #$3F             ; OLine=668 
                 STA      $69              ; OLine=669
                 LDA      #$A0             ; OLine=670
                 STA      $200,Y           ; OLine=671 
                 LDA      #0               ; OLine=672
                 STA      $223,Y           ; OLine=673
                 STA      $246,Y           ; OLine=674 
                 RTS                       ; OLine=675
                                           ;  ---------------------------------------------------------------------------
                                           
loc_6B66:                                  ; OLine=678
                 TXA                       ; OLine=679 
                 LDX      $18              ; OLine=680  Current Player
                 DEC      $57,X            ; OLine=681  Subtract Ship
                 TAX                       ; OLine=682
                 LDA      #$81             ; OLine=683
                 STA      $2FA             ; OLine=684 
                 BNE      loc_6B4A         ; OLine=685
                                           
loc_6B73:                                  ; OLine=687
                                           
                 LDA      $2F8             ; OLine=689 
                 STA      $2F7             ; OLine=690  Countdown Timer For When Saucer Appears
                 LDA      $1C              ; OLine=691  Number Of Players In Current Game
                 BEQ      loc_6B4A         ; OLine=692  None, Branch
                 STX      $D               ; OLine=693 
                 LDX      $19              ; OLine=694 
                 LDA      $21C             ; OLine=695  Saucer Flag
                 LSR      A                ; OLine=696  Shift It To Carry
                 LDA      #$99             ; OLine=697  990 Points, Assume Small Saucer
                 BCS      loc_6B8B         ; OLine=698  Carry Will Be Set If Small Saucer
                 LDA      #$20             ; OLine=699  200 Points, Its The Large Saucer
                                           
loc_6B8B:                                  ; OLine=701
                 JSR      sub_7397         ; OLine=702  And Add It To Score
                 LDX      $D               ; OLine=703
                 JMP      loc_6B4A         ; OLine=704 
                                           ;  End of function sub_6B0F
                                           
                                           
                                           ;  ¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦ S U B R O U T I N E ¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦
                                           
                                           
sub_6B93:                                  ; OLine=711
                 LDA      $5C              ; OLine=712 
                 AND      #3               ; OLine=713
                 BEQ      loc_6B9A         ; OLine=714 
                                           
locret_6B99:                               ; OLine=716
                                           
                 RTS                       ; OLine=718 
                                           ;  ---------------------------------------------------------------------------
                                           
loc_6B9A:                                  ; OLine=721
                 LDA      $21C             ; OLine=722  Saucer Flag
                 BMI      locret_6B99      ; OLine=723  Currently Exploding?, Branch
                 BEQ      loc_6BA4         ; OLine=724  No Saucer Currently Active, Branch
                 JMP      loc_6C34         ; OLine=725 
                                           ;  ---------------------------------------------------------------------------
                                           
loc_6BA4:                                  ; OLine=728
                 LDA      $1C              ; OLine=729  Number Of Players In Current Game
                 BEQ      loc_6BAF         ; OLine=730  None, Branch
                 LDA      $21B             ; OLine=731 
                 BEQ      locret_6B99      ; OLine=732 
                 BMI      locret_6B99      ; OLine=733
                                           
loc_6BAF:                                  ; OLine=735
                 LDA      $2F9             ; OLine=736 
                 BEQ      loc_6BB7         ; OLine=737
                 DEC      $2F9             ; OLine=738 
                                           
loc_6BB7:                                  ; OLine=740
                 DEC      $2F7             ; OLine=741  Update Countdown Timer For When Saucer Appears
                 BNE      locret_6B99      ; OLine=742
                 LDA      #$12             ; OLine=743 
                 STA      $2F7             ; OLine=744
                 LDA      $2F9             ; OLine=745
                 BEQ      loc_6BD0         ; OLine=746 
                 LDA      $2F6             ; OLine=747
                 BEQ      locret_6B99      ; OLine=748 
                 CMP      $2FD             ; OLine=749 
                 BCS      locret_6B99      ; OLine=750 
                                           
loc_6BD0:                                  ; OLine=752
                 LDA      $2F8             ; OLine=753 
                 SEC                       ; OLine=754 
                 SBC      #6               ; OLine=755  Shorten Time Between Saucer Appearence
                 CMP      #$20             ; OLine=756  At Lowest Value?
                 BCC      loc_6BDD         ; OLine=757  Yes, Branch
                 STA      $2F8             ; OLine=758  Make The Update
                                           
loc_6BDD:                                  ; OLine=760
                 LDA      #0               ; OLine=761 
                 STA      $2CB             ; OLine=762 
                 STA      $285             ; OLine=763 
                 JSR      sub_77B5         ; OLine=764 
                 LSR      A                ; OLine=765 
                 ROR      $2EE             ; OLine=766 
                 LSR      A                ; OLine=767 
                 ROR      $2EE             ; OLine=768 
                 LSR      A                ; OLine=769
                 ROR      $2EE             ; OLine=770 
                 CMP      #$18             ; OLine=771
                 BCC      loc_6BFA         ; OLine=772 
                 AND      #$17             ; OLine=773
                                           
loc_6BFA:                                  ; OLine=775
                 STA      $2A8             ; OLine=776 
                 LDX      #$10             ; OLine=777
                 BIT      $60              ; OLine=778
                 BVS      loc_6C0F         ; OLine=779 
                 LDA      #$1F             ; OLine=780
                 STA      $285             ; OLine=781
                 LDA      #$FF             ; OLine=782 
                 STA      $2CB             ; OLine=783
                 LDX      #$F0             ; OLine=784 
                                           
loc_6C0F:                                  ; OLine=786
                 STX      $23F             ; OLine=787 
                 LDX      #2               ; OLine=788  Start With Large Saucer
                 LDA      $2F8             ; OLine=789  Start Checking Score When @ #$7F And Below
                 BMI      loc_6C30         ; OLine=790  Not There Yet, Branch Around Score Check
                 LDY      $19              ; OLine=791
                 LDA      $53,Y            ; OLine=792  Current Player Score, Thousands
                 CMP      #$30             ; OLine=793  30,000 Points Or More?
                 BCS      loc_6C2F         ; OLine=794  Yes, Branch
                 JSR      sub_77B5         ; OLine=795
                 STA      8                ; OLine=796
                 LDA      $2F8             ; OLine=797 
                 LSR      A                ; OLine=798
                 CMP      8                ; OLine=799
                 BCS      loc_6C30         ; OLine=800  Going To Be A large Saucer, Branch
                                           
loc_6C2F:                                  ; OLine=802
                 DEX                       ; OLine=803  Make It A Small Saucer
                                           
loc_6C30:                                  ; OLine=805
                                           
                 STX      $21C             ; OLine=807  Saucer Flag
                 RTS                       ; OLine=808
                                           ;  ---------------------------------------------------------------------------
                                           
loc_6C34:                                  ; OLine=811
                 LDA      $5C              ; OLine=812  Fast Timer
                 ASL      A                ; OLine=813  Time To Change Saucer Direction? ( $5C = #$80 )
                 BNE      loc_6C45         ; OLine=814  No, Branch
                 JSR      sub_77B5         ; OLine=815 
                 AND      #3               ; OLine=816 
                 TAX                       ; OLine=817
                 LDA      $6CD3,X          ; OLine=818  Direction Table
                 STA      $262             ; OLine=819
                                           
loc_6C45:                                  ; OLine=821
                 LDA      $1C              ; OLine=822  Number Of Players In Current Game
                 BEQ      loc_6C4E         ; OLine=823  None, Branch
                 LDA      $2FA             ; OLine=824
                 BNE      locret_6C53      ; OLine=825 
                                           
loc_6C4E:                                  ; OLine=827
                 DEC      $2F7             ; OLine=828
                 BEQ      loc_6C54         ; OLine=829 
                                           
locret_6C53:                               ; OLine=831
                 RTS                       ; OLine=832 
                                           ;  ---------------------------------------------------------------------------
                                           
loc_6C54:                                  ; OLine=835
                 LDA      #$A              ; OLine=836  Time Between Saucer Shots
                 STA      $2F7             ; OLine=837
                 LDA      $21C             ; OLine=838  Saucer Flag
                 LSR      A                ; OLine=839  Check Saucer Size
                 BEQ      loc_6C65         ; OLine=840  Branch If Small One
                 JSR      sub_77B5         ; OLine=841
                 JMP      loc_6CC4         ; OLine=842 
                                           ;  ---------------------------------------------------------------------------
                                           
loc_6C65:                                  ; OLine=845
                 LDA      $23F             ; OLine=846 
                 CMP      #$80             ; OLine=847
                 ROR      A                ; OLine=848
                 STA      $C               ; OLine=849 
                 LDA      $2CA             ; OLine=850
                 SEC                       ; OLine=851 
                 SBC      $2CB             ; OLine=852
                 STA      $B               ; OLine=853 
                 LDA      $284             ; OLine=854
                 SBC      $285             ; OLine=855 
                 ASL      $B               ; OLine=856
                 ROL      A                ; OLine=857
                 ASL      $B               ; OLine=858 
                 ROL      A                ; OLine=859
                 SEC                       ; OLine=860
                 SBC      $C               ; OLine=861 
                 TAX                       ; OLine=862
                 LDA      $262             ; OLine=863
                 CMP      #$80             ; OLine=864 
                 ROR      A                ; OLine=865
                 STA      $C               ; OLine=866
                 LDA      $2ED             ; OLine=867 
                 SEC                       ; OLine=868
                 SBC      $2EE             ; OLine=869 
                 STA      $B               ; OLine=870
                 LDA      $2A7             ; OLine=871
                 SBC      $2A8             ; OLine=872 
                 ASL      $B               ; OLine=873
                 ROL      A                ; OLine=874
                 ASL      $B               ; OLine=875 
                 ROL      A                ; OLine=876
                 SEC                       ; OLine=877 
                 SBC      $C               ; OLine=878
                 TAY                       ; OLine=879 
                 JSR      loc_76F0         ; OLine=880 
                 STA      $62              ; OLine=881 
                 JSR      sub_77B5         ; OLine=882 
                 LDX      $19              ; OLine=883 
                 LDY      $53,X            ; OLine=884  Current Players Score, Thousands
                 CPY      #$35             ; OLine=885  35,000?
                 LDX      #0               ; OLine=886 
                 BCC      loc_6CBA         ; OLine=887  Branch If Less
                 INX                       ; OLine=888 
                                           
loc_6CBA:                                  ; OLine=890
                 AND      $6CCF,X          ; OLine=891 
                 BPL      loc_6CC2         ; OLine=892 
                 ORA      $6CD1,X          ; OLine=893 
                                           
loc_6CC2:                                  ; OLine=895
                 ADC      $62              ; OLine=896  Direction Shot Is Traveling???
                                           
loc_6CC4:                                  ; OLine=898
                 STA      $62              ; OLine=899 
                 LDY      #3               ; OLine=900 
                 LDX      #1               ; OLine=901 
                 STX      $E               ; OLine=902 
                 JMP      loc_6CF2         ; OLine=903 
                                           ;  End of function sub_6B93
                                           
                                           ;  ---------------------------------------------------------------------------
                 .BYTE    $8F              ; OLine=907
                 .BYTE    $87              ; OLine=908
                                           
                 .BYTE    $70              ; OLine=910
                 .BYTE    $78              ; OLine=911
                                           ;  First Colum Is Saucer Enters From Left Side Of Screen
                                           ;  Second Colum Is Saucer Enters From Right Side Of Screen
                 .BYTE    $F0              ; OLine=914  SE SW
                 .BYTE    0                ; OLine=915  E  W
                 .BYTE    0                ; OLine=916  E  W
                 .BYTE    $10              ; OLine=917  NE NW
                                           
                                           ;  ¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦ S U B R O U T I N E ¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦
                                           
                                           
sub_6CD7:                                  ; OLine=922
                 LDA      $1C              ; OLine=923  Number Of Players In Current Game
                 BEQ      locret_6CFC      ; OLine=924  None, Branch
                 ASL      $2004            ; OLine=925  Fire Switch
                 ROR      $63              ; OLine=926 
                 BIT      $63              ; OLine=927 
                 BPL      locret_6CFC      ; OLine=928 
                 BVS      locret_6CFC      ; OLine=929 
                 LDA      $2FA             ; OLine=930 
                 BNE      locret_6CFC      ; OLine=931 
                 TAX                       ; OLine=932 
                 LDA      #3               ; OLine=933 
                 STA      $E               ; OLine=934 
                 LDY      #7               ; OLine=935 
                                           
loc_6CF2:                                  ; OLine=937
                                           
                 LDA      $21B,Y           ; OLine=939  Check For A Open Slot For The Shot
                 BEQ      loc_6CFD         ; OLine=940  Branch If This Slot Is Open
                 DEY                       ; OLine=941  Point To Next Slot
                 CPY      $E               ; OLine=942  Out Of Slots?
                 BNE      loc_6CF2         ; OLine=943  No, Branch And Keep Checking
                                           
locret_6CFC:                               ; OLine=945
                                           
                 RTS                       ; OLine=947 
                                           ;  ---------------------------------------------------------------------------
                                           
loc_6CFD:                                  ; OLine=950
                 STX      $D               ; OLine=951 
                 LDA      #$12             ; OLine=952 
                 STA      $21B,Y           ; OLine=953 
                 LDA      $61,X            ; OLine=954 
                 JSR      sub_77D2         ; OLine=955 
                 LDX      $D               ; OLine=956 
                 CMP      #$80             ; OLine=957 
                 ROR      A                ; OLine=958 
                 STA      9                ; OLine=959 
                 CLC                       ; OLine=960 
                 ADC      $23E,X           ; OLine=961
                 BMI      loc_6D1E         ; OLine=962 
                 CMP      #$70             ; OLine=963
                 BCC      loc_6D24         ; OLine=964 
                 LDA      #$6F             ; OLine=965
                 BNE      loc_6D24         ; OLine=966 
                                           
loc_6D1E:                                  ; OLine=968
                 CMP      #$91             ; OLine=969 
                 BCS      loc_6D24         ; OLine=970
                 LDA      #$91             ; OLine=971
                                           
loc_6D24:                                  ; OLine=973
                                           
                 STA      $23E,Y           ; OLine=975 
                 LDA      $61,X            ; OLine=976
                 JSR      sub_77D5         ; OLine=977
                 LDX      $D               ; OLine=978 
                 CMP      #$80             ; OLine=979
                 ROR      A                ; OLine=980 
                 STA      $C               ; OLine=981
                 CLC                       ; OLine=982
                 ADC      $261,X           ; OLine=983 
                 BMI      loc_6D41         ; OLine=984
                 CMP      #$70             ; OLine=985 
                 BCC      loc_6D47         ; OLine=986
                 LDA      #$6F             ; OLine=987
                 BNE      loc_6D47         ; OLine=988 
                                           
loc_6D41:                                  ; OLine=990
                 CMP      #$91             ; OLine=991
                 BCS      loc_6D47         ; OLine=992
                 LDA      #$91             ; OLine=993 
                                           
loc_6D47:                                  ; OLine=995
                                           
                 STA      $261,Y           ; OLine=997 
                 LDX      #0               ; OLine=998
                 LDA      9                ; OLine=999
                 BPL      loc_6D51         ; OLine=1000 
                 DEX                       ; OLine=1001 
                                           
loc_6D51:                                  ; OLine=1003
                 STX      8                ; OLine=1004 
                 LDX      $D               ; OLine=1005 
                 CMP      #$80             ; OLine=1006 
                 ROR      A                ; OLine=1007 
                 CLC                       ; OLine=1008 
                 ADC      9                ; OLine=1009 
                 CLC                       ; OLine=1010 
                 ADC      $2CA,X           ; OLine=1011 
                 STA      $2CA,Y           ; OLine=1012 
                 LDA      8                ; OLine=1013 
                 ADC      $284,X           ; OLine=1014
                 STA      $284,Y           ; OLine=1015
                 LDX      #0               ; OLine=1016 
                 LDA      $C               ; OLine=1017
                 BPL      loc_6D71         ; OLine=1018
                 DEX                       ; OLine=1019 
                                           
loc_6D71:                                  ; OLine=1021
                 STX      $B               ; OLine=1022 
                 LDX      $D               ; OLine=1023
                 CMP      #$80             ; OLine=1024
                 ROR      A                ; OLine=1025 
                 CLC                       ; OLine=1026
                 ADC      $C               ; OLine=1027 
                 CLC                       ; OLine=1028
                 ADC      $2ED,X           ; OLine=1029
                 STA      $2ED,Y           ; OLine=1030 
                 LDA      $B               ; OLine=1031
                 ADC      $2A7,X           ; OLine=1032
                 STA      $2A7,Y           ; OLine=1033 
                 LDA      #$80             ; OLine=1034
                 STA      $66,X            ; OLine=1035 
                 RTS                       ; OLine=1036
                                           ;  End of function sub_6CD7
                                           
                                           ;  ---------------------------------------------------------------------------
                 .BYTE    $D8              ; OLine=1040
                                           
                                           ;  ¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦ S U B R O U T I N E ¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦
                                           
                                           
sub_6D90:                                  ; OLine=1045
                 LDA      $32              ; OLine=1046 
                 AND      $33              ; OLine=1047
                 BPL      loc_6D97         ; OLine=1048 
                 RTS                       ; OLine=1049
                                           ;  ---------------------------------------------------------------------------
                                           
loc_6D97:                                  ; OLine=1052
                 LDA      $1A              ; OLine=1053 
                 LSR      A                ; OLine=1054
                 BEQ      loc_6DB4         ; OLine=1055
                 LDY      #1               ; OLine=1056  Offset For "PLAYER "
                 JSR      sub_77F6         ; OLine=1057  And Draw To Screen
                 LDY      #2               ; OLine=1058 
                 LDX      $33              ; OLine=1059 
                 BPL      loc_6DA8         ; OLine=1060 
                 DEY                       ; OLine=1061
                                           
loc_6DA8:                                  ; OLine=1063
                 STY      $18              ; OLine=1064  Current Player
                 LDA      $5C              ; OLine=1065  Fast Timer
                 AND      #$10             ; OLine=1066 
                 BNE      loc_6DB4         ; OLine=1067 
                 TYA                       ; OLine=1068 
                 JSR      sub_7BD1         ; OLine=1069 
                                           
loc_6DB4:                                  ; OLine=1071
                                           
                 LSR      $18              ; OLine=1073  Current Player
                 JSR      sub_73B2         ; OLine=1074 
                 LDY      #2               ; OLine=1075  Offset For "YOUR SCORE IS ONE OF THE TEN BEST"
                 JSR      sub_77F6         ; OLine=1076  And Draw It To Screen
                 LDY      #3               ; OLine=1077  Offset For "PLEASE ENTER YOUR INITIALS"
                 JSR      sub_77F6         ; OLine=1078  And Draw It To Screen
                 LDY      #4               ; OLine=1079  Offset For "PUSH ROTATE TO SELECT LETTER"
                 JSR      sub_77F6         ; OLine=1080  And Draw It To Screen
                 LDY      #5               ; OLine=1081  Offset For "PUSH HYPERSPACE WHEN LETTER IS CORRECT"
                 JSR      sub_77F6         ; OLine=1082  And Draw It To Screen
                 LDA      #$20             ; OLine=1083 
                 STA      0                ; OLine=1084 
                 LDA      #$64             ; OLine=1085 
                 LDX      #$39             ; OLine=1086
                 JSR      sub_7C03         ; OLine=1087
                 LDA      #$70             ; OLine=1088
                 JSR      sub_7CDE         ; OLine=1089
                 LDX      $18              ; OLine=1090  Current Player
                 LDY      $32,X            ; OLine=1091
                 STY      $B               ; OLine=1092 
                 TYA                       ; OLine=1093
                 CLC                       ; OLine=1094 
                 ADC      $31              ; OLine=1095
                 STA      $C               ; OLine=1096
                 JSR      sub_6F1A         ; OLine=1097 
                 LDY      $B               ; OLine=1098
                 INY                       ; OLine=1099 
                 JSR      sub_6F1A         ; OLine=1100
                 LDY      $B               ; OLine=1101 
                 INY                       ; OLine=1102
                 INY                       ; OLine=1103 
                 JSR      sub_6F1A         ; OLine=1104
                 LDA      $2003            ; OLine=1105  Hyperspace Switch
                 ROL      A                ; OLine=1106 
                 ROL      $63              ; OLine=1107 
                 LDA      $63              ; OLine=1108 
                 AND      #$1F             ; OLine=1109 
                 CMP      #7               ; OLine=1110 
                 BNE      loc_6E2E         ; OLine=1111 
                 INC      $31              ; OLine=1112
                 LDA      $31              ; OLine=1113
                 CMP      #3               ; OLine=1114 
                 BCC      loc_6E22         ; OLine=1115
                 LDX      $18              ; OLine=1116  Current Player
                 LDA      #$FF             ; OLine=1117 
                 STA      $32,X            ; OLine=1118 
                                           
loc_6E15:                                  ; OLine=1120
                 LDX      #0               ; OLine=1121 
                 STX      $18              ; OLine=1122
                 STX      $31              ; OLine=1123 
                 LDX      #$F0             ; OLine=1124
                 STX      $5D              ; OLine=1125  Slow Timer
                 JMP      sub_73B2         ; OLine=1126
                                           ;  ---------------------------------------------------------------------------
                                           
loc_6E22:                                  ; OLine=1129
                 INC      $C               ; OLine=1130 
                 LDX      $C               ; OLine=1131
                 LDA      #$F4             ; OLine=1132
                 STA      $5D              ; OLine=1133  Slow Timer
                 LDA      #$B              ; OLine=1134
                 STA      $34,X            ; OLine=1135 
                                           
loc_6E2E:                                  ; OLine=1137
                 LDA      $5D              ; OLine=1138  Slow Timer
                 BNE      loc_6E3A         ; OLine=1139
                 LDA      #$FF             ; OLine=1140 
                 STA      $32              ; OLine=1141
                 STA      $33              ; OLine=1142 
                 BMI      loc_6E15         ; OLine=1143
                                           
loc_6E3A:                                  ; OLine=1145
                 LDA      $5C              ; OLine=1146  Fast Timer
                 AND      #7               ; OLine=1147
                 BNE      loc_6E71         ; OLine=1148
                 LDA      $2407            ; OLine=1149  Rotate Left Switch
                 BPL      loc_6E49         ; OLine=1150
                 LDA      #1               ; OLine=1151
                 BNE      loc_6E50         ; OLine=1152
                                           
loc_6E49:                                  ; OLine=1154
                 LDA      $2406            ; OLine=1155  Rotate Right Switch
                 BPL      loc_6E71         ; OLine=1156 
                 LDA      #$FF             ; OLine=1157 
                                           
loc_6E50:                                  ; OLine=1159
                 LDX      $C               ; OLine=1160 
                 CLC                       ; OLine=1161
                 ADC      $34,X            ; OLine=1162
                 BMI      loc_6E67         ; OLine=1163 
                 CMP      #$B              ; OLine=1164
                 BCS      loc_6E69         ; OLine=1165
                 CMP      #1               ; OLine=1166 
                 BEQ      loc_6E63         ; OLine=1167
                 LDA      #0               ; OLine=1168
                 BEQ      loc_6E6F         ; OLine=1169
                                           
loc_6E63:                                  ; OLine=1171
                 LDA      #$B              ; OLine=1172 
                 BNE      loc_6E6F         ; OLine=1173
                                           
loc_6E67:                                  ; OLine=1175
                 LDA      #$24             ; OLine=1176 
                                           
loc_6E69:                                  ; OLine=1178
                 CMP      #$25             ; OLine=1179 
                 BCC      loc_6E6F         ; OLine=1180
                 LDA      #0               ; OLine=1181 
                                           
loc_6E6F:                                  ; OLine=1183
                                           
                 STA      $34,X            ; OLine=1185 
                                           
loc_6E71:                                  ; OLine=1187
                                           
                 LDA      #0               ; OLine=1189 
                 RTS                       ; OLine=1190
                                           ;  End of function sub_6D90
                                           
                                           
                                           ;  ¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦ S U B R O U T I N E ¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦
                                           
                                           
sub_6E74:                                  ; OLine=1197
                 LDA      $1C              ; OLine=1198  Number Of Players In Current Game
                 BEQ      locret_6ED7      ; OLine=1199  None, Branch
                 LDA      $21B             ; OLine=1200  Player Flag
                 BMI      locret_6ED7      ; OLine=1201  Branch If Currently Exploding
                 LDA      $2FA             ; OLine=1202 
                 BNE      locret_6ED7      ; OLine=1203 
                 LDA      $2003            ; OLine=1204  Hyperspace Switch
                 BPL      locret_6ED7      ; OLine=1205  Branch If NOT Pressed
                 LDA      #0               ; OLine=1206 
                 STA      $21B             ; OLine=1207 
                 STA      $23E             ; OLine=1208 
                 STA      $261             ; OLine=1209 
                 LDA      #$30             ; OLine=1210 
                 STA      $2FA             ; OLine=1211 
                 JSR      sub_77B5         ; OLine=1212 
                 AND      #$1F             ; OLine=1213 
                 CMP      #$1D             ; OLine=1214 
                 BCC      loc_6EA2         ; OLine=1215 
                 LDA      #$1C             ; OLine=1216 
                                           
loc_6EA2:                                  ; OLine=1218
                 CMP      #3               ; OLine=1219 
                 BCS      loc_6EA8         ; OLine=1220 
                 LDA      #3               ; OLine=1221 
                                           
loc_6EA8:                                  ; OLine=1223
                 STA      $284             ; OLine=1224 
                 LDX      #5               ; OLine=1225 
                                           
loc_6EAD:                                  ; OLine=1227
                 JSR      sub_77B5         ; OLine=1228 
                 DEX                       ; OLine=1229 
                 BNE      loc_6EAD         ; OLine=1230 
                 AND      #$1F             ; OLine=1231 
                 INX                       ; OLine=1232  Assume Success ( X = 1 At This Point )
                 CMP      #$18             ; OLine=1233 
                 BCC      loc_6EC6         ; OLine=1234 
                 AND      #7               ; OLine=1235 
                 ASL      A                ; OLine=1236 
                 ADC      #4               ; OLine=1237 
                 CMP      $2F6             ; OLine=1238 
                 BCC      loc_6EC6         ; OLine=1239 
                 LDX      #$80             ; OLine=1240  Flag Hyperspace Unsuccessful
                                           
loc_6EC6:                                  ; OLine=1242
                                           
                 CMP      #$15             ; OLine=1244 
                 BCC      loc_6ECC         ; OLine=1245 
                 LDA      #$14             ; OLine=1246 
                                           
loc_6ECC:                                  ; OLine=1248
                 CMP      #3               ; OLine=1249 
                 BCS      loc_6ED2         ; OLine=1250 
                 LDA      #3               ; OLine=1251 
                                           
loc_6ED2:                                  ; OLine=1253
                 STA      $2A7             ; OLine=1254 
                 STX      $59              ; OLine=1255  Hyperspace Flag
                                           
locret_6ED7:                               ; OLine=1257
                                           
                 RTS                       ; OLine=1259 
                                           ;  End of function sub_6E74
                                           
                                           
                                           ;  ¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦ S U B R O U T I N E ¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦
                                           
                                           
sub_6ED8:                                  ; OLine=1266
                                           
                 LDA      #2               ; OLine=1268 
                 STA      $2F5             ; OLine=1269 
                 LDX      #3               ; OLine=1270  Assume A 3 Ship Game
                 LSR      $2802            ; OLine=1271  Shift Number Of Starting Ships Bit To Carry
                 BCS      loc_6EE5         ; OLine=1272  3 Ship Game
                 INX                       ; OLine=1273  4 Ship Game
                                           
loc_6EE5:                                  ; OLine=1275
                 STX      $56              ; OLine=1276 
                 LDA      #0               ; OLine=1277 
                 LDX      #4               ; OLine=1278 
                                           
loc_6EEB:                                  ; OLine=1280
                 STA      $21B,X           ; OLine=1281 
                 STA      $21F,X           ; OLine=1282
                 STA      $51,X            ; OLine=1283  *BUG* Should Be $52,X
                 DEX                       ; OLine=1284
                 BPL      loc_6EEB         ; OLine=1285 
                 STA      $2F6             ; OLine=1286
                 RTS                       ; OLine=1287 
                                           ;  End of function sub_6ED8
                                           
                                           
                                           ;  ¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦ S U B R O U T I N E ¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦
                                           
                                           
sub_6EFA:                                  ; OLine=1294
                                           
                 LDA      #0               ; OLine=1296 
                 STA      $3600            ; OLine=1297
                 STA      $3A00            ; OLine=1298
                 STA      $3C00            ; OLine=1299 
                 STA      $3C01            ; OLine=1300
                 STA      $3C03            ; OLine=1301
                 STA      $3C04            ; OLine=1302
                 STA      $3C05            ; OLine=1303 
                 STA      $69              ; OLine=1304
                 STA      $66              ; OLine=1305
                 STA      $67              ; OLine=1306
                 STA      $68              ; OLine=1307 
                 RTS                       ; OLine=1308
                                           ;  End of function sub_6EFA
                                           
                                           
                                           ;  ¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦ S U B R O U T I N E ¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦
                                           
                                           
sub_6F1A:                                  ; OLine=1315
                                           
                 LDA      $34,Y            ; OLine=1317 
                 ASL      A                ; OLine=1318
                 TAY                       ; OLine=1319
                 BNE      sub_6F35         ; OLine=1320 
                 LDA      $32              ; OLine=1321
                 AND      $33              ; OLine=1322
                 BMI      sub_6F35         ; OLine=1323 
                 LDA      #$72             ; OLine=1324
                 LDX      #$F8             ; OLine=1325 
                 JSR      sub_7D45         ; OLine=1326
                 LDA      #1               ; OLine=1327 
                 LDX      #$F8             ; OLine=1328
                 JMP      sub_7D45         ; OLine=1329 
                                           ;  End of function sub_6F1A
                                           
                                           
                                           ;  ¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦ S U B R O U T I N E ¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦
                                           
                                           
sub_6F35:                                  ; OLine=1336
                                           
                 LDX      $56D5,Y          ; OLine=1338 
                 LDA      $56D4,Y          ; OLine=1339
                 JMP      sub_7D45         ; OLine=1340 
                                           ;  End of function sub_6F35
                                           
                                           
                                           ;  ¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦ S U B R O U T I N E ¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦
                                           
                                           
sub_6F3E:                                  ; OLine=1347
                                           
                 BEQ      locret_6F56      ; OLine=1349 
                 STY      8                ; OLine=1350
                 LDX      #$D5             ; OLine=1351
                 LDY      #$E0             ; OLine=1352 
                 STY      0                ; OLine=1353
                 JSR      sub_7C03         ; OLine=1354
                                           
loc_6F4B:                                  ; OLine=1356
                 LDX      #$DA             ; OLine=1357 
                 LDA      #$54             ; OLine=1358
                 JSR      sub_7BFC         ; OLine=1359
                 DEC      8                ; OLine=1360 
                 BNE      loc_6F4B         ; OLine=1361
                                           
locret_6F56:                               ; OLine=1363
                 RTS                       ; OLine=1364 
                                           ;  End of function sub_6F3E
                                           
                                           
                                           ;  ¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦ S U B R O U T I N E ¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦
                                           
                                           
sub_6F57:                                  ; OLine=1371
                 LDX      #$22             ; OLine=1372 
                                           
loc_6F59:                                  ; OLine=1374
                 LDA      $200,X           ; OLine=1375
                 BNE      loc_6F62         ; OLine=1376 
                                           
loc_6F5E:                                  ; OLine=1378
                                           
                 DEX                       ; OLine=1380 
                 BPL      loc_6F59         ; OLine=1381
                 RTS                       ; OLine=1382 
                                           ;  ---------------------------------------------------------------------------
                                           
loc_6F62:                                  ; OLine=1385
                 BPL      loc_6FC7         ; OLine=1386 
                 JSR      sub_7708         ; OLine=1387 
                 LSR      A                ; OLine=1388
                 LSR      A                ; OLine=1389 
                 LSR      A                ; OLine=1390
                 LSR      A                ; OLine=1391
                 CPX      #$1B             ; OLine=1392 
                 BNE      loc_6F76         ; OLine=1393 
                 LDA      $5C              ; OLine=1394 
                 AND      #1               ; OLine=1395 
                 LSR      A                ; OLine=1396
                 BEQ      loc_6F77         ; OLine=1397 
                                           
loc_6F76:                                  ; OLine=1399
                 SEC                       ; OLine=1400 
                                           
loc_6F77:                                  ; OLine=1402
                 ADC      $200,X           ; OLine=1403
                 BMI      loc_6FA1         ; OLine=1404 
                 CPX      #$1B             ; OLine=1405
                 BEQ      loc_6F93         ; OLine=1406
                 BCS      loc_6F99         ; OLine=1407 
                 DEC      $2F6             ; OLine=1408
                 BNE      loc_6F8C         ; OLine=1409
                 LDY      #$7F             ; OLine=1410 
                 STY      $2FB             ; OLine=1411 
                                           
loc_6F8C:                                  ; OLine=1413
                                           
                 LDA      #0               ; OLine=1415 
                 STA      $200,X           ; OLine=1416
                 BEQ      loc_6F5E         ; OLine=1417 
                                           
loc_6F93:                                  ; OLine=1419
                 JSR      sub_71E8         ; OLine=1420 
                 JMP      loc_6F8C         ; OLine=1421 
                                           ;  ---------------------------------------------------------------------------
                                           
loc_6F99:                                  ; OLine=1424
                 LDA      $2F8             ; OLine=1425 
                 STA      $2F7             ; OLine=1426  Countdown Timer For When Saucer Appears
                 BNE      loc_6F8C         ; OLine=1427 
                                           
loc_6FA1:                                  ; OLine=1429
                 STA      $200,X           ; OLine=1430 
                 AND      #$F0             ; OLine=1431 
                 CLC                       ; OLine=1432 
                 ADC      #$10             ; OLine=1433 
                 CPX      #$1B             ; OLine=1434
                 BNE      loc_6FAF         ; OLine=1435
                 LDA      #0               ; OLine=1436 
                                           
loc_6FAF:                                  ; OLine=1438
                 TAY                       ; OLine=1439 
                 LDA      $2AF,X           ; OLine=1440
                 STA      4                ; OLine=1441
                 LDA      $269,X           ; OLine=1442 
                 STA      5                ; OLine=1443
                 LDA      $2D2,X           ; OLine=1444
                 STA      6                ; OLine=1445 
                 LDA      $28C,X           ; OLine=1446
                 STA      7                ; OLine=1447
                 JMP      loc_7027         ; OLine=1448 
                                           ;  ---------------------------------------------------------------------------
                                           
loc_6FC7:                                  ; OLine=1451
                 CLC                       ; OLine=1452 
                 LDY      #0               ; OLine=1453
                 LDA      $223,X           ; OLine=1454
                 BPL      loc_6FD0         ; OLine=1455 
                 DEY                       ; OLine=1456
                                           
loc_6FD0:                                  ; OLine=1458
                 ADC      $2AF,X           ; OLine=1459 
                 STA      $2AF,X           ; OLine=1460
                 STA      4                ; OLine=1461
                 TYA                       ; OLine=1462 
                 ADC      $269,X           ; OLine=1463
                 CMP      #$20             ; OLine=1464
                 BCC      loc_6FEC         ; OLine=1465 
                 AND      #$1F             ; OLine=1466
                 CPX      #$1C             ; OLine=1467
                 BNE      loc_6FEC         ; OLine=1468 
                 JSR      sub_702D         ; OLine=1469
                 JMP      loc_6F5E         ; OLine=1470 
                                           ;  ---------------------------------------------------------------------------
                                           
loc_6FEC:                                  ; OLine=1473
                                           
                 STA      $269,X           ; OLine=1475 
                 STA      5                ; OLine=1476
                 CLC                       ; OLine=1477
                 LDY      #0               ; OLine=1478 
                 LDA      $246,X           ; OLine=1479
                 BPL      loc_6FFB         ; OLine=1480
                 LDY      #$FF             ; OLine=1481 
                                           
loc_6FFB:                                  ; OLine=1483
                 ADC      $2D2,X           ; OLine=1484
                 STA      $2D2,X           ; OLine=1485 
                 STA      6                ; OLine=1486
                 TYA                       ; OLine=1487
                 ADC      $28C,X           ; OLine=1488
                 CMP      #$18             ; OLine=1489 
                 BCC      loc_7013         ; OLine=1490
                 BEQ      loc_7011         ; OLine=1491
                 LDA      #$17             ; OLine=1492
                 BNE      loc_7013         ; OLine=1493 
                                           
loc_7011:                                  ; OLine=1495
                 LDA      #0               ; OLine=1496 
                                           
loc_7013:                                  ; OLine=1498
                                           
                 STA      $28C,X           ; OLine=1500 
                 STA      7                ; OLine=1501 
                 LDA      $200,X           ; OLine=1502
                 LDY      #$E0             ; OLine=1503
                 LSR      A                ; OLine=1504 
                 BCS      loc_7027         ; OLine=1505
                 LDY      #$F0             ; OLine=1506
                 LSR      A                ; OLine=1507
                 BCS      loc_7027         ; OLine=1508 
                 LDY      #0               ; OLine=1509 
                                           
loc_7027:                                  ; OLine=1511
                                           
                 JSR      sub_72FE         ; OLine=1513 
                 JMP      loc_6F5E         ; OLine=1514 
                                           ;  End of function sub_6F57
                                           
                                           
                                           ;  ¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦ S U B R O U T I N E ¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦
                                           
                                           
sub_702D:                                  ; OLine=1521
                                           
                 LDA      $2F8             ; OLine=1523  Starting Value For Timer @ $02F7
                 STA      $2F7             ; OLine=1524  Countdown Timer For When Saucer Appears
                 LDA      #0               ; OLine=1525
                 STA      $21C             ; OLine=1526  Saucer Flag
                 STA      $23F             ; OLine=1527 
                 STA      $262             ; OLine=1528
                 RTS                       ; OLine=1529 
                                           ;  End of function sub_702D
                                           
                                           
                                           ;  ¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦ S U B R O U T I N E ¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦
                                           
                                           
sub_703F:                                  ; OLine=1536
                 LDA      $1C              ; OLine=1537  Number Of Players In Current Game
                 BEQ      locret_7085      ; OLine=1538  None, Branch
                 LDA      $21B             ; OLine=1539  Player Flag
                 BMI      locret_7085      ; OLine=1540  Branch If Currently Exploding
                 LDA      $2FA             ; OLine=1541 
                 BEQ      loc_7086         ; OLine=1542 
                 DEC      $2FA             ; OLine=1543 
                 BNE      locret_7085      ; OLine=1544 
                 LDY      $59              ; OLine=1545  Hyperspace Flag
                 BMI      loc_706F         ; OLine=1546  Gonna Die From Hyperspace, Branch
                 BNE      loc_7068         ; OLine=1547  Successful Hyperspace, Branch
                 JSR      sub_7139         ; OLine=1548 
                 BNE      loc_7081         ; OLine=1549 
                 LDY      $21C             ; OLine=1550 
                 BEQ      loc_7068         ; OLine=1551 
                 LDY      #2               ; OLine=1552 
                 STY      $2FA             ; OLine=1553 
                 RTS                       ; OLine=1554 
                                           ;  ---------------------------------------------------------------------------
                                           
loc_7068:                                  ; OLine=1557
                                           
                 LDA      #1               ; OLine=1559  Flag Ship OK
                 STA      $21B             ; OLine=1560 
                 BNE      loc_7081         ; OLine=1561  Will Always Branch
                                           
loc_706F:                                  ; OLine=1563
                 LDA      #$A0             ; OLine=1564  Switch To Explosion Timer
                 STA      $21B             ; OLine=1565 
                 LDX      #$3E             ; OLine=1566 
                 STX      $69              ; OLine=1567 
                 LDX      $18              ; OLine=1568  Current Player
                 DEC      $57,X            ; OLine=1569  Subtract Ship
                 LDA      #$81             ; OLine=1570
                 STA      $2FA             ; OLine=1571 
                                           
loc_7081:                                  ; OLine=1573
                                           
                 LDA      #0               ; OLine=1575 
                 STA      $59              ; OLine=1576
                                           
locret_7085:                               ; OLine=1578
                                           
                 RTS                       ; OLine=1580 
                                           ;  ---------------------------------------------------------------------------
                                           
loc_7086:                                  ; OLine=1583
                 LDA      $2407            ; OLine=1584  Rotate Left Switch
                 BPL      loc_708F         ; OLine=1585  Branch If NOT Pressed
                 LDA      #3               ; OLine=1586 
                 BNE      loc_7096         ; OLine=1587  Will Always Branch
                                           
loc_708F:                                  ; OLine=1589
                 LDA      $2406            ; OLine=1590  Rotate Right Switch
                 BPL      loc_709B         ; OLine=1591  Branch If NOT Pressed
                 LDA      #$FD             ; OLine=1592 
                                           
loc_7096:                                  ; OLine=1594
                 CLC                       ; OLine=1595 
                 ADC      $61              ; OLine=1596  Current Ship Direction
                 STA      $61              ; OLine=1597 
                                           
loc_709B:                                  ; OLine=1599
                 LDA      $5C              ; OLine=1600  Fast Timer
                 LSR      A                ; OLine=1601 
                 BCS      locret_7085      ; OLine=1602 
                 LDA      $2405            ; OLine=1603  Thrust Switch
                 BPL      loc_70E1         ; OLine=1604  Branch If NOT Pressed
                 LDA      #$80             ; OLine=1605 
                 STA      $3C03            ; OLine=1606  Ship Thrust Sound
                 LDY      #0               ; OLine=1607 
                 LDA      $61              ; OLine=1608  Current Ship Direction
                 JSR      sub_77D2         ; OLine=1609 
                 BPL      loc_70B4         ; OLine=1610
                 DEY                       ; OLine=1611 
                                           
loc_70B4:                                  ; OLine=1613
                 ASL      A                ; OLine=1614 
                 CLC                       ; OLine=1615
                 ADC      $64              ; OLine=1616
                 TAX                       ; OLine=1617
                 TYA                       ; OLine=1618 
                 ADC      $23E             ; OLine=1619
                 JSR      sub_7125         ; OLine=1620
                 STA      $23E             ; OLine=1621
                 STX      $64              ; OLine=1622 
                 LDY      #0               ; OLine=1623
                 LDA      $61              ; OLine=1624
                 JSR      sub_77D5         ; OLine=1625 
                 BPL      loc_70CF         ; OLine=1626
                 DEY                       ; OLine=1627 
                                           
loc_70CF:                                  ; OLine=1629
                 ASL      A                ; OLine=1630 
                 CLC                       ; OLine=1631
                 ADC      $65              ; OLine=1632
                 TAX                       ; OLine=1633 
                 TYA                       ; OLine=1634
                 ADC      $261             ; OLine=1635
                 JSR      sub_7125         ; OLine=1636 
                 STA      $261             ; OLine=1637
                 STX      $65              ; OLine=1638
                 RTS                       ; OLine=1639 
                                           ;  ---------------------------------------------------------------------------
                                           
loc_70E1:                                  ; OLine=1642
                 LDA      #0               ; OLine=1643 
                 STA      $3C03            ; OLine=1644  Ship Thrust Sound
                 LDA      $23E             ; OLine=1645
                 ORA      $64              ; OLine=1646
                 BEQ      loc_7105         ; OLine=1647
                 LDA      $23E             ; OLine=1648 
                 ASL      A                ; OLine=1649
                 LDX      #$FF             ; OLine=1650
                 CLC                       ; OLine=1651
                 EOR      #$FF             ; OLine=1652 
                 BMI      loc_70FA         ; OLine=1653
                 INX                       ; OLine=1654
                 SEC                       ; OLine=1655 
                                           
loc_70FA:                                  ; OLine=1657
                 ADC      $64              ; OLine=1658
                 STA      $64              ; OLine=1659 
                 TXA                       ; OLine=1660
                 ADC      $23E             ; OLine=1661
                 STA      $23E             ; OLine=1662 
                                           
loc_7105:                                  ; OLine=1664
                 LDA      $65              ; OLine=1665 
                 ORA      $261             ; OLine=1666
                 BEQ      locret_7124      ; OLine=1667
                 LDA      $261             ; OLine=1668 
                 ASL      A                ; OLine=1669
                 LDX      #$FF             ; OLine=1670
                 CLC                       ; OLine=1671
                 EOR      #$FF             ; OLine=1672 
                 BMI      loc_7119         ; OLine=1673
                 SEC                       ; OLine=1674
                 INX                       ; OLine=1675 
                                           
loc_7119:                                  ; OLine=1677
                 ADC      $65              ; OLine=1678
                 STA      $65              ; OLine=1679 
                 TXA                       ; OLine=1680
                 ADC      $261             ; OLine=1681
                 STA      $261             ; OLine=1682 
                                           
locret_7124:                               ; OLine=1684
                 RTS                       ; OLine=1685 
                                           ;  End of function sub_703F
                                           
                                           
                                           ;  ¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦ S U B R O U T I N E ¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦
                                           
                                           
sub_7125:                                  ; OLine=1692
                                           
                 BMI      loc_7130         ; OLine=1694 
                 CMP      #$40             ; OLine=1695
                 BCC      locret_7138      ; OLine=1696
                 LDX      #$FF             ; OLine=1697 
                 LDA      #$3F             ; OLine=1698
                 RTS                       ; OLine=1699 
                                           ;  ---------------------------------------------------------------------------
                                           
loc_7130:                                  ; OLine=1702
                 CMP      #$C0             ; OLine=1703
                 BCS      locret_7138      ; OLine=1704 
                 LDX      #1               ; OLine=1705
                 LDA      #$C0             ; OLine=1706 
                                           
locret_7138:                               ; OLine=1708
                                           
                 RTS                       ; OLine=1710 
                                           ;  End of function sub_7125
                                           
                                           
                                           ;  ¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦ S U B R O U T I N E ¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦
                                           
                                           
sub_7139:                                  ; OLine=1717
                 LDX      #$1C             ; OLine=1718 
                                           
loc_713B:                                  ; OLine=1720
                 LDA      $200,X           ; OLine=1721 
                 BEQ      loc_715E         ; OLine=1722
                 LDA      $269,X           ; OLine=1723
                 SEC                       ; OLine=1724 
                 SBC      $284             ; OLine=1725
                 CMP      #4               ; OLine=1726 
                 BCC      loc_714F         ; OLine=1727
                 CMP      #$FC             ; OLine=1728
                 BCC      loc_715E         ; OLine=1729 
                                           
loc_714F:                                  ; OLine=1731
                 LDA      $28C,X           ; OLine=1732 
                 SEC                       ; OLine=1733
                 SBC      $2A7             ; OLine=1734
                 CMP      #4               ; OLine=1735 
                 BCC      loc_7163         ; OLine=1736
                 CMP      #$FC             ; OLine=1737
                 BCS      loc_7163         ; OLine=1738 
                                           
loc_715E:                                  ; OLine=1740
                                           
                 DEX                       ; OLine=1742 
                 BPL      loc_713B         ; OLine=1743
                 INX                       ; OLine=1744
                 RTS                       ; OLine=1745 
                                           ;  ---------------------------------------------------------------------------
                                           
loc_7163:                                  ; OLine=1748
                                           
                 INC      $2FA             ; OLine=1750 
                 RTS                       ; OLine=1751 
                                           ;  End of function sub_7139
                                           
                                           ;  ---------------------------------------------------------------------------
                 .BYTE    $90              ; OLine=1755
                                           
                                           ;  ¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦ S U B R O U T I N E ¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦
                                           
                                           
sub_7168:                                  ; OLine=1760
                                           
                 LDX      #$1A             ; OLine=1762 
                 LDA      $2FB             ; OLine=1763
                 BNE      loc_71DF         ; OLine=1764
                 LDA      $21C             ; OLine=1765  Saucer Flag
                 BNE      locret_71E7      ; OLine=1766  Branch If Saucer Is Currently Active
                 STA      $23F             ; OLine=1767
                 STA      $262             ; OLine=1768
                 INC      $2FD             ; OLine=1769
                 LDA      $2FD             ; OLine=1770 
                 CMP      #$B              ; OLine=1771
                 BCC      loc_7187         ; OLine=1772
                 DEC      $2FD             ; OLine=1773 
                                           
loc_7187:                                  ; OLine=1775
                 LDA      $2F5             ; OLine=1776 
                 CLC                       ; OLine=1777
                 ADC      #2               ; OLine=1778
                 CMP      #$B              ; OLine=1779
                 BCC      loc_7193         ; OLine=1780 
                 LDA      #$B              ; OLine=1781 
                                           
loc_7193:                                  ; OLine=1783
                 STA      $2F6             ; OLine=1784 
                 STA      $2F5             ; OLine=1785
                 STA      8                ; OLine=1786 
                 LDY      #$1C             ; OLine=1787 
                                           
loc_719D:                                  ; OLine=1789
                 JSR      sub_77B5         ; OLine=1790 
                 AND      #$18             ; OLine=1791
                 ORA      #4               ; OLine=1792 
                 STA      $200,X           ; OLine=1793
                 JSR      sub_7203         ; OLine=1794
                 JSR      sub_77B5         ; OLine=1795 
                 LSR      A                ; OLine=1796
                 AND      #$1F             ; OLine=1797
                 BCC      loc_71C5         ; OLine=1798 
                 CMP      #$18             ; OLine=1799
                 BCC      loc_71B8         ; OLine=1800
                 AND      #$17             ; OLine=1801 
                                           
loc_71B8:                                  ; OLine=1803
                 STA      $28C,X           ; OLine=1804 
                 LDA      #0               ; OLine=1805
                 STA      $269,X           ; OLine=1806
                 STA      $2AF,X           ; OLine=1807 
                 BEQ      loc_71D0         ; OLine=1808 
                                           
loc_71C5:                                  ; OLine=1810
                 STA      $269,X           ; OLine=1811 
                 LDA      #0               ; OLine=1812
                 STA      $28C,X           ; OLine=1813 
                 STA      $2D2,X           ; OLine=1814 
                                           
loc_71D0:                                  ; OLine=1816
                 DEX                       ; OLine=1817
                 DEC      8                ; OLine=1818 
                 BNE      loc_719D         ; OLine=1819
                 LDA      #$7F             ; OLine=1820
                 STA      $2F7             ; OLine=1821  Countdown Timer For When Saucer Appears
                 LDA      #$30             ; OLine=1822
                 STA      $2FC             ; OLine=1823  Starting Value For Timer @ $6E
                                           
loc_71DF:                                  ; OLine=1825
                 LDA      #0               ; OLine=1826 
                                           
loc_71E1:                                  ; OLine=1828
                 STA      $200,X           ; OLine=1829 
                 DEX                       ; OLine=1830
                 BPL      loc_71E1         ; OLine=1831 
                                           
locret_71E7:                               ; OLine=1833
                 RTS                       ; OLine=1834 
                                           ;  End of function sub_7168
                                           
                                           
                                           ;  ¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦ S U B R O U T I N E ¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦
                                           
                                           
sub_71E8:                                  ; OLine=1841
                                           
                 LDA      #$60             ; OLine=1843 
                 STA      $2CA             ; OLine=1844
                 STA      $2ED             ; OLine=1845
                 LDA      #0               ; OLine=1846
                 STA      $23E             ; OLine=1847 
                 STA      $261             ; OLine=1848
                 LDA      #$10             ; OLine=1849
                 STA      $284             ; OLine=1850
                 LDA      #$C              ; OLine=1851 
                 STA      $2A7             ; OLine=1852
                 RTS                       ; OLine=1853 
                                           ;  End of function sub_71E8
                                           
                                           
                                           ;  ¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦ S U B R O U T I N E ¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦
                                           
                                           
sub_7203:                                  ; OLine=1860
                                           
                 JSR      sub_77B5         ; OLine=1862 
                 AND      #$8F             ; OLine=1863
                 BPL      loc_720C         ; OLine=1864
                 ORA      #$F0             ; OLine=1865 
                                           
loc_720C:                                  ; OLine=1867
                 CLC                       ; OLine=1868
                 ADC      $223,Y           ; OLine=1869
                 JSR      sub_7233         ; OLine=1870 
                 STA      $223,X           ; OLine=1871
                 JSR      sub_77B5         ; OLine=1872
                 JSR      sub_77B5         ; OLine=1873 
                 JSR      sub_77B5         ; OLine=1874
                 JSR      sub_77B5         ; OLine=1875
                 AND      #$8F             ; OLine=1876 
                 BPL      loc_7228         ; OLine=1877
                 ORA      #$F0             ; OLine=1878 
                                           
loc_7228:                                  ; OLine=1880
                 CLC                       ; OLine=1881 
                 ADC      $246,Y           ; OLine=1882
                 JSR      sub_7233         ; OLine=1883 
                 STA      $246,X           ; OLine=1884
                 RTS                       ; OLine=1885 
                                           ;  End of function sub_7203
                                           
                                           
                                           ;  ¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦ S U B R O U T I N E ¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦
                                           
                                           
sub_7233:                                  ; OLine=1892
                                           
                 BPL      loc_7242         ; OLine=1894 
                 CMP      #$E1             ; OLine=1895
                 BCS      loc_723B         ; OLine=1896
                 LDA      #$E1             ; OLine=1897 
                                           
loc_723B:                                  ; OLine=1899
                 CMP      #$FB             ; OLine=1900 
                 BCC      locret_724E      ; OLine=1901
                 LDA      #$FA             ; OLine=1902 
                 RTS                       ; OLine=1903 
                                           ;  ---------------------------------------------------------------------------
                                           
loc_7242:                                  ; OLine=1906
                 CMP      #6               ; OLine=1907 
                 BCS      loc_7248         ; OLine=1908
                 LDA      #6               ; OLine=1909 
                                           
loc_7248:                                  ; OLine=1911
                 CMP      #$20             ; OLine=1912 
                 BCC      locret_724E      ; OLine=1913
                 LDA      #$1F             ; OLine=1914 
                                           
locret_724E:                               ; OLine=1916
                                           
                 RTS                       ; OLine=1918 
                                           ;  End of function sub_7233
                                           
                                           
                                           ;  ¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦ S U B R O U T I N E ¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦
                                           
                                           
sub_724F:                                  ; OLine=1925
                 LDA      #$10             ; OLine=1926 
                 STA      0                ; OLine=1927
                 LDA      #$50             ; OLine=1928 
                 LDX      #$A4             ; OLine=1929
                 JSR      sub_7BFC         ; OLine=1930
                 LDA      #$19             ; OLine=1931 
                 LDX      #$DB             ; OLine=1932
                 JSR      sub_7C03         ; OLine=1933
                 LDA      #$70             ; OLine=1934
                 JSR      sub_7CDE         ; OLine=1935
                 LDX      #0               ; OLine=1936
                 LDA      $1C              ; OLine=1937  Number Of Players In Current Game
                 CMP      #2               ; OLine=1938  2 Players?
                 BNE      loc_7286         ; OLine=1939  No, Branch
                 LDA      $18              ; OLine=1940  Current Player
                 BNE      loc_7286         ; OLine=1941  Player 2? Yes, Branch
                 LDX      #$20             ; OLine=1942 
                 LDA      $21B             ; OLine=1943  Player Flag
                 ORA      $59              ; OLine=1944  Hyperspace Flag
                 BNE      loc_7286         ; OLine=1945 
                 LDA      $2FA             ; OLine=1946
                 BMI      loc_7286         ; OLine=1947 
                 LDA      $5C              ; OLine=1948  Fast Timer
                 AND      #$10             ; OLine=1949 
                 BEQ      loc_7293         ; OLine=1950 
                                           
loc_7286:                                  ; OLine=1952
                                           
                 LDA      #$52             ; OLine=1954 
                 LDY      #2               ; OLine=1955
                 SEC                       ; OLine=1956 
                 JSR      sub_773F         ; OLine=1957
                 LDA      #0               ; OLine=1958 
                 JSR      sub_778B         ; OLine=1959
                                           
loc_7293:                                  ; OLine=1961
                 LDA      #$28             ; OLine=1962 
                 LDY      $57              ; OLine=1963  Number Of Ships Remaining, Player 1
                 JSR      sub_6F3E         ; OLine=1964
                 LDA      #0               ; OLine=1965
                 STA      0                ; OLine=1966
                 LDA      #$78             ; OLine=1967 
                 LDX      #$DB             ; OLine=1968
                 JSR      sub_7C03         ; OLine=1969
                 LDA      #$50             ; OLine=1970
                 JSR      sub_7CDE         ; OLine=1971
                 LDA      #$1D             ; OLine=1972
                 LDY      #2               ; OLine=1973 
                 SEC                       ; OLine=1974
                 JSR      sub_773F         ; OLine=1975 
                 LDA      #0               ; OLine=1976
                 JSR      sub_7BD1         ; OLine=1977 
                 LDA      #$10             ; OLine=1978
                 STA      0                ; OLine=1979
                 LDA      #$C0             ; OLine=1980 
                 LDX      #$DB             ; OLine=1981
                 JSR      sub_7C03         ; OLine=1982
                 LDA      #$50             ; OLine=1983
                 JSR      sub_7CDE         ; OLine=1984 
                 LDX      #0               ; OLine=1985 
                 LDA      $1C              ; OLine=1986  Number Of Players In Current Game
                 CMP      #1               ; OLine=1987  Only 1 Player?
                 BEQ      locret_72FD      ; OLine=1988  Yes, Branch
                 BCC      loc_72E9         ; OLine=1989 
                 LDA      $18              ; OLine=1990  Current Player
                 BEQ      loc_72E9         ; OLine=1991  Branch If Player 1
                 LDX      #$20             ; OLine=1992 
                 LDA      $21B             ; OLine=1993  Player Flag
                 ORA      $59              ; OLine=1994  Hyperspace Flag
                 BNE      loc_72E9         ; OLine=1995
                 LDA      $2FA             ; OLine=1996 
                 BMI      loc_72E9         ; OLine=1997
                 LDA      $5C              ; OLine=1998  Fast Timer
                 AND      #$10             ; OLine=1999 
                 BEQ      loc_72F6         ; OLine=2000 
                                           
loc_72E9:                                  ; OLine=2002
                                           
                 LDA      #$54             ; OLine=2004 
                 LDY      #2               ; OLine=2005
                 SEC                       ; OLine=2006
                 JSR      sub_773F         ; OLine=2007 
                 LDA      #0               ; OLine=2008
                 JSR      sub_778B         ; OLine=2009
                                           
loc_72F6:                                  ; OLine=2011
                 LDA      #$CF             ; OLine=2012 
                 LDY      $58              ; OLine=2013  Current Number Of Ships, Player 2
                 JMP      sub_6F3E         ; OLine=2014 
                                           ;  ---------------------------------------------------------------------------
                                           
locret_72FD:                               ; OLine=2017
                 RTS                       ; OLine=2018 
                                           ;  End of function sub_724F
                                           
                                           
                                           ;  ¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦ S U B R O U T I N E ¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦
                                           
                                           
sub_72FE:                                  ; OLine=2025
                 STY      0                ; OLine=2026 
                 STX      $D               ; OLine=2027
                 LDA      5                ; OLine=2028
                 LSR      A                ; OLine=2029
                 ROR      4                ; OLine=2030
                 LSR      A                ; OLine=2031 
                 ROR      4                ; OLine=2032
                 LSR      A                ; OLine=2033
                 ROR      4                ; OLine=2034
                 STA      5                ; OLine=2035 
                 LDA      7                ; OLine=2036
                 CLC                       ; OLine=2037
                 ADC      #4               ; OLine=2038
                 LSR      A                ; OLine=2039 
                 ROR      6                ; OLine=2040
                 LSR      A                ; OLine=2041
                 ROR      6                ; OLine=2042
                 LSR      A                ; OLine=2043
                 ROR      6                ; OLine=2044 
                 STA      7                ; OLine=2045
                 LDX      #4               ; OLine=2046
                 JSR      sub_7C1C         ; OLine=2047 
                 LDA      #$70             ; OLine=2048
                 SEC                       ; OLine=2049
                 SBC      0                ; OLine=2050
                 CMP      #$A0             ; OLine=2051 
                 BCC      loc_733B         ; OLine=2052 
                                           
loc_732D:                                  ; OLine=2054
                 PHA                       ; OLine=2055 
                 LDA      #$90             ; OLine=2056
                 JSR      sub_7CDE         ; OLine=2057 
                 PLA                       ; OLine=2058
                 SEC                       ; OLine=2059 
                 SBC      #$10             ; OLine=2060
                 CMP      #$A0             ; OLine=2061 
                 BCS      loc_732D         ; OLine=2062 
                                           
loc_733B:                                  ; OLine=2064
                 JSR      sub_7CDE         ; OLine=2065 
                 LDX      $D               ; OLine=2066
                 LDA      $200,X           ; OLine=2067
                 BPL      loc_735B         ; OLine=2068 
                 CPX      #$1B             ; OLine=2069
                 BEQ      loc_7355         ; OLine=2070
                 AND      #$C              ; OLine=2071
                 LSR      A                ; OLine=2072 
                 TAY                       ; OLine=2073
                 LDA      $50F8,Y          ; OLine=2074
                 LDX      $50F9,Y          ; OLine=2075
                 BNE      loc_7370         ; OLine=2076 
                                           
loc_7355:                                  ; OLine=2078
                 JSR      sub_7465         ; OLine=2079 
                 LDX      $D               ; OLine=2080
                 RTS                       ; OLine=2081 
                                           ;  ---------------------------------------------------------------------------
                                           
loc_735B:                                  ; OLine=2084
                 CPX      #$1B             ; OLine=2085 
                 BEQ      loc_7376         ; OLine=2086
                 CPX      #$1C             ; OLine=2087
                 BEQ      loc_737C         ; OLine=2088
                 BCS      loc_7384         ; OLine=2089 
                 AND      #$18             ; OLine=2090
                 LSR      A                ; OLine=2091
                 LSR      A                ; OLine=2092
                 TAY                       ; OLine=2093 
                 LDA      $51DE,Y          ; OLine=2094
                 LDX      $51DF,Y          ; OLine=2095 
                                           
loc_7370:                                  ; OLine=2097
                                           
                 JSR      sub_7D45         ; OLine=2099 
                 LDX      $D               ; OLine=2100
                 RTS                       ; OLine=2101 
                                           ;  ---------------------------------------------------------------------------
                                           
loc_7376:                                  ; OLine=2104
                 JSR      sub_750B         ; OLine=2105 
                 LDX      $D               ; OLine=2106
                 RTS                       ; OLine=2107 
                                           ;  ---------------------------------------------------------------------------
                                           
loc_737C:                                  ; OLine=2110
                 LDA      $5250            ; OLine=2111 
                 LDX      $5251            ; OLine=2112
                 BNE      loc_7370         ; OLine=2113 
                                           
loc_7384:                                  ; OLine=2115
                 LDA      #$70             ; OLine=2116 
                 LDX      #$F0             ; OLine=2117
                 JSR      sub_7CE0         ; OLine=2118 
                 LDX      $D               ; OLine=2119
                 LDA      $5C              ; OLine=2120  Fast Timer
                 AND      #3               ; OLine=2121
                 BNE      locret_7396      ; OLine=2122 
                 DEC      $200,X           ; OLine=2123
                                           
locret_7396:                               ; OLine=2125
                 RTS                       ; OLine=2126 
                                           ;  End of function sub_72FE
                                           
                                           
                                           ;  ¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦ S U B R O U T I N E ¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦
                                           
                                           
sub_7397:                                  ; OLine=2133
                                           
                 SED                       ; OLine=2135  Set Decimal Mode
                 ADC      $52,X            ; OLine=2136  Add To Current Players Score, Tens
                 STA      $52,X            ; OLine=2137 
                 BCC      loc_73B0         ; OLine=2138  Increase In Thousands?, No, Branch
                 LDA      $53,X            ; OLine=2139  Current Players Score, Thousands
                 ADC      #0               ; OLine=2140  Add In The Carry
                 STA      $53,X            ; OLine=2141
                 AND      #$F              ; OLine=2142  Will Be 0 If Another 10,000 Points Reached
                 BNE      loc_73B0         ; OLine=2143  Branch If Not Enough Points For Bonus Ship
                 LDA      #$B0             ; OLine=2144  Length Of Time To Play Bonus Ship Sound
                 STA      $68              ; OLine=2145  Into Timer
                 LDX      $18              ; OLine=2146  Current Player
                 INC      $57,X            ; OLine=2147  Award Bonus Ship
                                           
loc_73B0:                                  ; OLine=2149
                                           
                 CLD                       ; OLine=2151  Clear Decimal Mode
                 RTS                       ; OLine=2152 
                                           ;  End of function sub_7397
                                           
                                           
                                           ;  ¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦ S U B R O U T I N E ¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦
                                           
                                           
sub_73B2:                                  ; OLine=2159
                                           
                 LDA      $18              ; OLine=2161  Current Player
                 ASL      A                ; OLine=2162
                 ASL      A                ; OLine=2163
                 STA      8                ; OLine=2164
                 LDA      $6F              ; OLine=2165
                 AND      #$FB             ; OLine=2166
                 ORA      8                ; OLine=2167 
                 STA      $6F              ; OLine=2168
                 STA      $3200            ; OLine=2169
                 RTS                       ; OLine=2170 
                                           ;  End of function sub_73B2
                                           
                                           
                                           ;  ¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦ S U B R O U T I N E ¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦
                                           
                                           
sub_73C4:                                  ; OLine=2177
                 LDA      $1C              ; OLine=2178  Number Of Players In Current Game
                 BEQ      loc_73CA         ; OLine=2179  None, Branch
                                           
loc_73C8:                                  ; OLine=2181
                                           
                 CLC                       ; OLine=2183 
                 RTS                       ; OLine=2184
                                           
loc_73CA:                                  ; OLine=2186
                 LDA      $5D              ; OLine=2187  Slow Timer
                 AND      #4               ; OLine=2188
                 BNE      loc_73C8         ; OLine=2189
                 LDA      $1D              ; OLine=2190  Highest Score In Table
                 ORA      $1E              ; OLine=2191
                 BEQ      loc_73C8         ; OLine=2192  Table Empty, Branch
                 LDY      #0               ; OLine=2193  Offset To "HIGH SCORE"
                 JSR      sub_77F6         ; OLine=2194  And Draw To Screen
                 LDX      #0               ; OLine=2195
                 STX      $10              ; OLine=2196
                 LDA      #1               ; OLine=2197
                 STA      0                ; OLine=2198 
                 LDA      #$A7             ; OLine=2199
                 STA      $E               ; OLine=2200
                 LDA      #$10             ; OLine=2201
                 STA      0                ; OLine=2202 
                                           
loc_73EB:                                  ; OLine=2204
                 LDA      $1D,X            ; OLine=2205  High Score Table
                 ORA      $1E,X            ; OLine=2206 
                 BEQ      loc_7458         ; OLine=2207  No Score In This Entry, Branch
                 STX      $F               ; OLine=2208
                 LDA      #$5F             ; OLine=2209 
                 LDX      $E               ; OLine=2210
                 JSR      sub_7C03         ; OLine=2211
                 LDA      #$40             ; OLine=2212
                 JSR      sub_7CDE         ; OLine=2213 
                 LDA      $F               ; OLine=2214
                 LSR      A                ; OLine=2215
                 SED                       ; OLine=2216  Set Decimal Mode
                 ADC      #1               ; OLine=2217 
                 CLD                       ; OLine=2218  Clear Decimal Mode
                 STA      $D               ; OLine=2219
                 LDA      #$D              ; OLine=2220
                 SEC                       ; OLine=2221 
                 LDY      #1               ; OLine=2222
                 LDX      #0               ; OLine=2223
                 JSR      sub_773F         ; OLine=2224
                 LDA      #$40             ; OLine=2225 
                 TAX                       ; OLine=2226
                 JSR      sub_7CE0         ; OLine=2227
                 LDY      #0               ; OLine=2228
                 JSR      sub_6F35         ; OLine=2229 
                 LDA      $F               ; OLine=2230
                 CLC                       ; OLine=2231
                 ADC      #$1D             ; OLine=2232
                 LDY      #2               ; OLine=2233 
                 SEC                       ; OLine=2234
                 LDX      #0               ; OLine=2235
                 JSR      sub_773F         ; OLine=2236
                 LDA      #0               ; OLine=2237 
                 JSR      sub_7BD1         ; OLine=2238
                 LDY      #0               ; OLine=2239
                 JSR      sub_6F35         ; OLine=2240
                 LDY      $10              ; OLine=2241 
                 JSR      sub_6F1A         ; OLine=2242
                 INC      $10              ; OLine=2243
                 LDY      $10              ; OLine=2244
                 JSR      sub_6F1A         ; OLine=2245 
                 INC      $10              ; OLine=2246
                 LDY      $10              ; OLine=2247
                 JSR      sub_6F1A         ; OLine=2248
                 INC      $10              ; OLine=2249 
                 LDA      $E               ; OLine=2250
                 SEC                       ; OLine=2251
                 SBC      #8               ; OLine=2252
                 STA      $E               ; OLine=2253 
                 LDX      $F               ; OLine=2254 
                 INX                       ; OLine=2255 
                 INX                       ; OLine=2256  Point To Next Entry In Table
                 CPX      #$14             ; OLine=2257  End Of Table?
                 BCC      loc_73EB         ; OLine=2258  No, Branch
                                           
loc_7458:                                  ; OLine=2260
                 SEC                       ; OLine=2261
                 RTS                       ; OLine=2262 
                                           ;  End of function sub_73C4
                                           
                                           
                                           ;  ¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦ S U B R O U T I N E ¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦
                                           
                                           
sub_745A:                                  ; OLine=2269
                 LDX      #$1A             ; OLine=2270 
                                           ;  End of function sub_745A
                                           
                                           
                                           ;  ¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦ S U B R O U T I N E ¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦
                                           
                                           
sub_745C:                                  ; OLine=2277
                                           
                 LDA      $200,X           ; OLine=2279 
                 BEQ      locret_7464      ; OLine=2280
                 DEX                       ; OLine=2281
                 BPL      sub_745C         ; OLine=2282 
                                           
locret_7464:                               ; OLine=2284
                 RTS                       ; OLine=2285 
                                           ;  End of function sub_745C
                                           
                                           
                                           ;  ¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦ S U B R O U T I N E ¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦
                                           
                                           
sub_7465:                                  ; OLine=2292
                 LDA      $21B             ; OLine=2293 
                 CMP      #$A2             ; OLine=2294
                 BCS      loc_748E         ; OLine=2295 
                 LDX      #$A              ; OLine=2296
                                           
loc_746E:                                  ; OLine=2298
                 LDA      $50EC,X          ; OLine=2299 
                 LSR      A                ; OLine=2300
                 LSR      A                ; OLine=2301
                 LSR      A                ; OLine=2302
                 LSR      A                ; OLine=2303
                 CLC                       ; OLine=2304 
                 ADC      #$F8             ; OLine=2305
                 EOR      #$F8             ; OLine=2306
                 STA      $7E,X            ; OLine=2307
                 LDA      $50ED,X          ; OLine=2308 
                 LSR      A                ; OLine=2309
                 LSR      A                ; OLine=2310
                 LSR      A                ; OLine=2311
                 LSR      A                ; OLine=2312 
                 CLC                       ; OLine=2313
                 ADC      #$F8             ; OLine=2314
                 EOR      #$F8             ; OLine=2315
                 STA      $8A,X            ; OLine=2316 
                 DEX                       ; OLine=2317
                 DEX                       ; OLine=2318
                 BPL      loc_746E         ; OLine=2319 
                                           
loc_748E:                                  ; OLine=2321
                 LDA      $21B             ; OLine=2322 
                 EOR      #$FF             ; OLine=2323
                 AND      #$70             ; OLine=2324
                 LSR      A                ; OLine=2325 
                 LSR      A                ; OLine=2326
                 LSR      A                ; OLine=2327
                 TAX                       ; OLine=2328 
                                           
loc_7499:                                  ; OLine=2330
                 STX      9                ; OLine=2331
                 LDY      #0               ; OLine=2332 
                 LDA      $50EC,X          ; OLine=2333
                 BPL      loc_74A3         ; OLine=2334
                 DEY                       ; OLine=2335 
                                           
loc_74A3:                                  ; OLine=2337
                 CLC                       ; OLine=2338 
                 ADC      $7D,X            ; OLine=2339
                 STA      $7D,X            ; OLine=2340
                 TYA                       ; OLine=2341 
                 ADC      $7E,X            ; OLine=2342
                 STA      $7E,X            ; OLine=2343
                 STA      4                ; OLine=2344
                 STY      5                ; OLine=2345 
                 LDY      #0               ; OLine=2346
                 LDA      $50ED,X          ; OLine=2347
                 BPL      loc_74B9         ; OLine=2348
                 DEY                       ; OLine=2349 
                                           
loc_74B9:                                  ; OLine=2351
                 CLC                       ; OLine=2352 
                 ADC      $89,X            ; OLine=2353
                 STA      $89,X            ; OLine=2354
                 TYA                       ; OLine=2355
                 ADC      $8A,X            ; OLine=2356 
                 STA      $8A,X            ; OLine=2357
                 STA      6                ; OLine=2358
                 STY      7                ; OLine=2359
                 LDA      2                ; OLine=2360 
                 STA      $B               ; OLine=2361
                 LDA      3                ; OLine=2362
                 STA      $C               ; OLine=2363
                 JSR      sub_7C49         ; OLine=2364 
                 LDY      9                ; OLine=2365
                 LDA      $50E0,Y          ; OLine=2366
                 LDX      $50E1,Y          ; OLine=2367
                 JSR      sub_7D45         ; OLine=2368 
                 LDY      9                ; OLine=2369
                 LDA      $50E1,Y          ; OLine=2370
                 EOR      #4               ; OLine=2371
                 TAX                       ; OLine=2372 
                 LDA      $50E0,Y          ; OLine=2373
                 AND      #$F              ; OLine=2374
                 EOR      #4               ; OLine=2375
                 JSR      sub_7D45         ; OLine=2376 
                 LDY      #$FF             ; OLine=2377 
                                           
loc_74F1:                                  ; OLine=2379
                 INY                       ; OLine=2380 
                 LDA      ($B),Y           ; OLine=2381
                 STA      (2),Y            ; OLine=2382
                 INY                       ; OLine=2383
                 LDA      ($B),Y           ; OLine=2384 
                 EOR      #4               ; OLine=2385
                 STA      (2),Y            ; OLine=2386
                 CPY      #3               ; OLine=2387
                 BCC      loc_74F1         ; OLine=2388 
                 JSR      sub_7C39         ; OLine=2389
                 LDX      9                ; OLine=2390
                 DEX                       ; OLine=2391
                 DEX                       ; OLine=2392 
                 BPL      loc_7499         ; OLine=2393
                 RTS                       ; OLine=2394 
                                           ;  End of function sub_7465
                                           
                                           
                                           ;  ¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦ S U B R O U T I N E ¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦
                                           
                                           
sub_750B:                                  ; OLine=2401
                 LDX      #0               ; OLine=2402 
                 STX      $17              ; OLine=2403 
                 LDY      #0               ; OLine=2404 
                 LDA      $61              ; OLine=2405  Ship Direction
                 BPL      loc_751B         ; OLine=2406 
                 LDY      #4               ; OLine=2407
                 TXA                       ; OLine=2408
                 SEC                       ; OLine=2409
                 SBC      $61              ; OLine=2410 
                                           
loc_751B:                                  ; OLine=2412
                 STA      8                ; OLine=2413 
                 BIT      8                ; OLine=2414
                 BMI      loc_7523         ; OLine=2415
                 BVC      loc_752A         ; OLine=2416 
                                           
loc_7523:                                  ; OLine=2418
                 LDX      #4               ; OLine=2419 
                 LDA      #$80             ; OLine=2420
                 SEC                       ; OLine=2421
                 SBC      8                ; OLine=2422 
                                           
loc_752A:                                  ; OLine=2424
                 STX      8                ; OLine=2425 
                 STY      9                ; OLine=2426
                 LSR      A                ; OLine=2427
                 AND      #$FE             ; OLine=2428
                 TAY                       ; OLine=2429 
                 LDA      $526E,Y          ; OLine=2430
                 LDX      $526F,Y          ; OLine=2431
                 JSR      sub_6AD3         ; OLine=2432
                 LDA      $2405            ; OLine=2433  Thrust Switch
                 BPL      locret_7554      ; OLine=2434  Branch If NOT Pressed
                 LDA      $5C              ; OLine=2435  Fast Timer
                 AND      #4               ; OLine=2436
                 BEQ      locret_7554      ; OLine=2437 
                 INY                       ; OLine=2438
                 INY                       ; OLine=2439
                 SEC                       ; OLine=2440
                 LDX      $C               ; OLine=2441 
                 TYA                       ; OLine=2442
                 ADC      $B               ; OLine=2443
                 BCC      loc_7551         ; OLine=2444
                 INX                       ; OLine=2445 
                                           
loc_7551:                                  ; OLine=2447
                 JSR      sub_6AD3         ; OLine=2448 
                                           
locret_7554:                               ; OLine=2450
                                           
                 RTS                       ; OLine=2452 
                                           ;  End of function sub_750B
                                           
                                           
                                           ;  ¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦ S U B R O U T I N E ¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦
                                           
                                           
sub_7555:                                  ; OLine=2459
                 LDA      $1C              ; OLine=2460  Number Of Players In Current Game
                 BNE      loc_755A         ; OLine=2461  Branch If At Least 1 Player Left
                 RTS                       ; OLine=2462 
                                           ;  ---------------------------------------------------------------------------
                                           
loc_755A:                                  ; OLine=2465
                 LDX      #0               ; OLine=2466 
                 LDA      $21C             ; OLine=2467  Saucer Flag
                 BMI      loc_756B         ; OLine=2468  Currently Exploding, Branch
                 BEQ      loc_756B         ; OLine=2469  No Active Saucer, Branch
                 ROR      A                ; OLine=2470
                 ROR      A                ; OLine=2471
                 ROR      A                ; OLine=2472
                 STA      $3C02            ; OLine=2473  Saucer Sound Select
                 LDX      #$80             ; OLine=2474
                                           
loc_756B:                                  ; OLine=2476
                                           
                 STX      $3C00            ; OLine=2478  Saucer Sound
                 LDX      #1               ; OLine=2479
                 JSR      sub_75CD         ; OLine=2480
                 STA      $3C01            ; OLine=2481  Saucer Fire Sound
                 DEX                       ; OLine=2482
                 JSR      sub_75CD         ; OLine=2483
                 STA      $3C04            ; OLine=2484  Ship Fire Sound
                 LDA      $21B             ; OLine=2485
                 CMP      #1               ; OLine=2486
                 BEQ      loc_7588         ; OLine=2487
                 TXA                       ; OLine=2488
                 STA      $3C03            ; OLine=2489  Ship Thrust Sound
                                           
loc_7588:                                  ; OLine=2491
                 LDA      $2F6             ; OLine=2492 
                 BEQ      loc_759E         ; OLine=2493 
                 LDA      $21B             ; OLine=2494  Player Flag
                 BMI      loc_759E         ; OLine=2495  Currently Exploding, Branch
                 ORA      $59              ; OLine=2496  Hyperspace Flag
                 BEQ      loc_759E         ; OLine=2497 
                 LDA      $6D              ; OLine=2498 
                 BEQ      loc_75AE         ; OLine=2499 
                 DEC      $6D              ; OLine=2500 
                 BNE      loc_75BF         ; OLine=2501 
                                           
loc_759E:                                  ; OLine=2503
                                           
                 LDA      $6C              ; OLine=2505  Current Volume And Frequency Of THUMP Sound
                 AND      #$F              ; OLine=2506  Mask Off Frequency Control
                 STA      $6C              ; OLine=2507
                 STA      $3A00            ; OLine=2508  Turn Off Volume, Retain Current Frequency
                 LDA      $2FC             ; OLine=2509 
                 STA      $6E              ; OLine=2510
                 BPL      loc_75BF         ; OLine=2511 
                                           
loc_75AE:                                  ; OLine=2513
                 DEC      $6E              ; OLine=2514 
                 BNE      loc_75BF         ; OLine=2515
                 LDA      #4               ; OLine=2516
                 STA      $6D              ; OLine=2517
                 LDA      $6C              ; OLine=2518 
                 EOR      #$14             ; OLine=2519  Turn On Volume, Switch Frequency
                 STA      $6C              ; OLine=2520  Store It In Current Settings
                 STA      $3A00            ; OLine=2521  Make The Change
                                           
loc_75BF:                                  ; OLine=2523
                                           
                 LDA      $69              ; OLine=2525 
                 TAX                       ; OLine=2526
                 AND      #$3F             ; OLine=2527
                 BEQ      loc_75C7         ; OLine=2528
                 DEX                       ; OLine=2529 
                                           
loc_75C7:                                  ; OLine=2531
                 STX      $69              ; OLine=2532 
                 STX      $3600            ; OLine=2533  Explosion Pitch/Volume
                 RTS                       ; OLine=2534 
                                           ;  End of function sub_7555
                                           
                                           
                                           ;  ¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦ S U B R O U T I N E ¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦
                                           
                                           ;  Fire Sound Handling
                                           
                                           
sub_75CD:                                  ; OLine=2543
                                           
                 LDA      $6A,X            ; OLine=2545  X = 0 Ship Fire, X = 1 Saucer Fire
                 BMI      loc_75DD         ; OLine=2546
                 LDA      $66,X            ; OLine=2547
                 BPL      loc_75E7         ; OLine=2548 
                 LDA      #$10             ; OLine=2549
                 STA      $66,X            ; OLine=2550  TIMER: Length Of Time Sound Is On
                                           
loc_75D9:                                  ; OLine=2552
                 LDA      #$80             ; OLine=2553  Turn Fire Sound On
                 BMI      loc_75E9         ; OLine=2554  Will Always Branch
                                           
loc_75DD:                                  ; OLine=2556
                 LDA      $66,X            ; OLine=2557 
                 BEQ      loc_75E7         ; OLine=2558
                 BMI      loc_75E7         ; OLine=2559
                 DEC      $66,X            ; OLine=2560
                 BNE      loc_75D9         ; OLine=2561 
                                           
loc_75E7:                                  ; OLine=2563
                                           
                 LDA      #0               ; OLine=2565  Turn Fire Sound Off
                                           
loc_75E9:                                  ; OLine=2567
                 STA      $6A,X            ; OLine=2568 
                 RTS                       ; OLine=2569 
                                           ;  End of function sub_75CD
                                           
                                           
                                           ;  ¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦ S U B R O U T I N E ¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦
                                           
                                           
sub_75EC:                                  ; OLine=2576
                 STX      $D               ; OLine=2577 
                 LDA      #$50             ; OLine=2578
                 STA      $2F9             ; OLine=2579
                 LDA      $200,Y           ; OLine=2580
                 AND      #$78             ; OLine=2581 
                 STA      $E               ; OLine=2582
                 LDA      $200,Y           ; OLine=2583
                 AND      #7               ; OLine=2584
                 LSR      A                ; OLine=2585 
                 TAX                       ; OLine=2586
                 BEQ      loc_7605         ; OLine=2587
                 ORA      $E               ; OLine=2588 
                                           
loc_7605:                                  ; OLine=2590
                 STA      $200,Y           ; OLine=2591 
                 LDA      $1C              ; OLine=2592  Number Of Players In Current Game
                 BEQ      loc_761D         ; OLine=2593  None, Branch
                 LDA      $D               ; OLine=2594
                 BEQ      loc_7614         ; OLine=2595
                 CMP      #4               ; OLine=2596
                 BCC      loc_761D         ; OLine=2597 
                                           
loc_7614:                                  ; OLine=2599
                 LDA      $7659,X          ; OLine=2600 
                 LDX      $19              ; OLine=2601
                 CLC                       ; OLine=2602
                 JSR      sub_7397         ; OLine=2603 
                                           
loc_761D:                                  ; OLine=2605
                                           
                 LDX      $200,Y           ; OLine=2607 
                 BEQ      loc_7656         ; OLine=2608
                 JSR      sub_745A         ; OLine=2609
                 BMI      loc_7656         ; OLine=2610
                 INC      $2F6             ; OLine=2611 
                 JSR      sub_6A9D         ; OLine=2612
                 JSR      sub_7203         ; OLine=2613
                 LDA      $223,X           ; OLine=2614
                 AND      #$1F             ; OLine=2615 
                 ASL      A                ; OLine=2616
                 EOR      $2AF,X           ; OLine=2617
                 STA      $2AF,X           ; OLine=2618
                 JSR      sub_745C         ; OLine=2619 
                 BMI      loc_7656         ; OLine=2620
                 INC      $2F6             ; OLine=2621
                 JSR      sub_6A9D         ; OLine=2622
                 JSR      sub_7203         ; OLine=2623 
                 LDA      $246,X           ; OLine=2624
                 AND      #$1F             ; OLine=2625
                 ASL      A                ; OLine=2626
                 EOR      $2D2,X           ; OLine=2627 
                 STA      $2D2,X           ; OLine=2628 
                                           
loc_7656:                                  ; OLine=2630
                                           
                 LDX      $D               ; OLine=2632 
                 RTS                       ; OLine=2633 
                                           ;  End of function sub_75EC
                                           
                                           ;  ---------------------------------------------------------------------------
                 .BYTE    $10              ; OLine=2637  100 Points
                 .BYTE    5                ; OLine=2638  50 Points
                 .BYTE    2                ; OLine=2639  20 Points
                                           
                                           ;  ¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦ S U B R O U T I N E ¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦
                                           
                                           
sub_765C:                                  ; OLine=2644
                 LDA      $1C              ; OLine=2645  Number Of Players In Current Game
                 BPL      locret_7698      ; OLine=2646
                 LDX      #2               ; OLine=2647 
                 STA      $5D              ; OLine=2648  Slow Timer
                 STA      $32              ; OLine=2649
                 STA      $33              ; OLine=2650 
                                           
loc_7668:                                  ; OLine=2652
                 LDY      #0               ; OLine=2653 
                                           
loc_766A:                                  ; OLine=2655
                 LDA      $1D,Y            ; OLine=2656  High Score Table, Tens
                 CMP      $52,X            ; OLine=2657  Player Score, Tens
                 LDA      $1E,Y            ; OLine=2658  High Score Table, Thousands
                 SBC      $53,X            ; OLine=2659 
                 BCC      loc_7699         ; OLine=2660 
                 INY                       ; OLine=2661
                 INY                       ; OLine=2662
                 CPY      #$14             ; OLine=2663
                 BCC      loc_766A         ; OLine=2664 
                                           
loc_767C:                                  ; OLine=2666
                 DEX                       ; OLine=2667 
                 DEX                       ; OLine=2668
                 BPL      loc_7668         ; OLine=2669
                 LDA      $33              ; OLine=2670
                 BMI      loc_7692         ; OLine=2671 
                 CMP      $32              ; OLine=2672
                 BCC      loc_7692         ; OLine=2673
                 ADC      #2               ; OLine=2674
                 CMP      #$1E             ; OLine=2675 
                 BCC      loc_7690         ; OLine=2676
                 LDA      #$FF             ; OLine=2677 
                                           
loc_7690:                                  ; OLine=2679
                 STA      $33              ; OLine=2680 
                                           
loc_7692:                                  ; OLine=2682
                                           
                 LDA      #0               ; OLine=2684 
                 STA      $1C              ; OLine=2685
                 STA      $31              ; OLine=2686
                                           
locret_7698:                               ; OLine=2688
                 RTS                       ; OLine=2689 
                                           ;  ---------------------------------------------------------------------------
                                           
loc_7699:                                  ; OLine=2692
                 STX      $B               ; OLine=2693 
                 STY      $C               ; OLine=2694
                 TXA                       ; OLine=2695
                 LSR      A                ; OLine=2696
                 TAX                       ; OLine=2697 
                 TYA                       ; OLine=2698
                 LSR      A                ; OLine=2699
                 ADC      $C               ; OLine=2700
                 STA      $D               ; OLine=2701 
                 STA      $32,X            ; OLine=2702
                 LDX      #$1B             ; OLine=2703
                 LDY      #$12             ; OLine=2704 
                                           
loc_76AC:                                  ; OLine=2706
                 CPX      $D               ; OLine=2707 
                 BEQ      loc_76CF         ; OLine=2708
                 LDA      $31,X            ; OLine=2709
                 STA      $34,X            ; OLine=2710
                 LDA      $32,X            ; OLine=2711 
                 STA      $35,X            ; OLine=2712
                 LDA      $33,X            ; OLine=2713
                 STA      $36,X            ; OLine=2714
                 LDA      $1B,Y            ; OLine=2715 
                 STA      $1D,Y            ; OLine=2716
                 LDA      $1C,Y            ; OLine=2717
                 STA      $1E,Y            ; OLine=2718
                 DEY                       ; OLine=2719 
                 DEY                       ; OLine=2720
                 DEX                       ; OLine=2721
                 DEX                       ; OLine=2722
                 DEX                       ; OLine=2723
                 BNE      loc_76AC         ; OLine=2724 
                                           
loc_76CF:                                  ; OLine=2726
                 LDA      #$B              ; OLine=2727 
                 STA      $34,X            ; OLine=2728
                 LDA      #0               ; OLine=2729
                 STA      $35,X            ; OLine=2730
                 STA      $36,X            ; OLine=2731
                 LDA      #$F0             ; OLine=2732 
                 STA      $5D              ; OLine=2733  Slow Timer
                 LDX      $B               ; OLine=2734
                 LDY      $C               ; OLine=2735
                 LDA      $53,X            ; OLine=2736  Players Score, Thousands
                 STA      $1E,Y            ; OLine=2737
                 LDA      $52,X            ; OLine=2738  Players Score, Tens
                 STA      $1D,Y            ; OLine=2739
                 LDY      #0               ; OLine=2740 
                 BEQ      loc_767C         ; OLine=2741
                                           
                 .BYTE    $DF              ; OLine=2743 
                                           ;  ---------------------------------------------------------------------------
loc_76F0:                                  ; OLine=2745
                 TYA                       ; OLine=2746 
                 BPL      loc_76FC         ; OLine=2747 
                                           ;  End of function sub_765C
                                           
                 JSR      sub_7708         ; OLine=2750 
                 JSR      loc_76FC         ; OLine=2751
                 JMP      sub_7708         ; OLine=2752 
                                           ;  ---------------------------------------------------------------------------
                                           
loc_76FC:                                  ; OLine=2755
                                           
                 TAY                       ; OLine=2757 
                 TXA                       ; OLine=2758
                 BPL      sub_770E         ; OLine=2759
                 JSR      sub_7708         ; OLine=2760
                 JSR      sub_770E         ; OLine=2761
                 EOR      #$80             ; OLine=2762 
                                           
                                           ;  ¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦ S U B R O U T I N E ¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦
                                           
                                           
sub_7708:                                  ; OLine=2767
                                           
                 EOR      #$FF             ; OLine=2769 
                 CLC                       ; OLine=2770
                 ADC      #1               ; OLine=2771
                 RTS                       ; OLine=2772 
                                           ;  End of function sub_7708
                                           
                                           
                                           ;  ¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦ S U B R O U T I N E ¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦
                                           
                                           
sub_770E:                                  ; OLine=2779
                                           
                 STA      $C               ; OLine=2781 
                 TYA                       ; OLine=2782
                 CMP      $C               ; OLine=2783
                 BEQ      loc_7725         ; OLine=2784
                 BCC      sub_7728         ; OLine=2785 
                 LDY      $C               ; OLine=2786
                 STA      $C               ; OLine=2787
                 TYA                       ; OLine=2788
                 JSR      sub_7728         ; OLine=2789 
                 SEC                       ; OLine=2790
                 SBC      #$40             ; OLine=2791
                 JMP      sub_7708         ; OLine=2792 
                                           ;  ---------------------------------------------------------------------------
                                           
loc_7725:                                  ; OLine=2795
                 LDA      #$20             ; OLine=2796 
                 RTS                       ; OLine=2797
                                           ;  End of function sub_770E
                                           
                                           
                                           ;  ¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦ S U B R O U T I N E ¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦
                                           
                                           
sub_7728:                                  ; OLine=2804
                                           
                 JSR      sub_776C         ; OLine=2806 
                 LDA      $772F,X          ; OLine=2807
                 RTS                       ; OLine=2808 
                                           ;  End of function sub_7728
                                           
                                           ;  ---------------------------------------------------------------------------
                 .BYTE    0                ; OLine=2812
                 .BYTE    2                ; OLine=2813
                 .BYTE    5                ; OLine=2814
                 .BYTE    7                ; OLine=2815
                 .BYTE    $A               ; OLine=2816
                 .BYTE    $C               ; OLine=2817
                 .BYTE    $F               ; OLine=2818
                 .BYTE    $11              ; OLine=2819
                 .BYTE    $13              ; OLine=2820
                 .BYTE    $15              ; OLine=2821
                 .BYTE    $17              ; OLine=2822
                 .BYTE    $19              ; OLine=2823
                 .BYTE    $1A              ; OLine=2824
                 .BYTE    $1C              ; OLine=2825
                 .BYTE    $1D              ; OLine=2826
                 .BYTE    $1F              ; OLine=2827
                                           
                                           ;  ¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦ S U B R O U T I N E ¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦
                                           
                                           
sub_773F:                                  ; OLine=2832
                                           
                 PHP                       ; OLine=2834 
                 STX      $17              ; OLine=2835
                 DEY                       ; OLine=2836
                 STY      $16              ; OLine=2837
                 CLC                       ; OLine=2838 
                 ADC      $16              ; OLine=2839
                 STA      $15              ; OLine=2840
                 PLP                       ; OLine=2841
                 TAX                       ; OLine=2842 
                                           
loc_774C:                                  ; OLine=2844
                 PHP                       ; OLine=2845 
                 LDA      0,X              ; OLine=2846
                 LSR      A                ; OLine=2847
                 LSR      A                ; OLine=2848
                 LSR      A                ; OLine=2849 
                 LSR      A                ; OLine=2850
                 PLP                       ; OLine=2851
                 JSR      sub_7785         ; OLine=2852
                 LDA      $16              ; OLine=2853 
                 BNE      loc_775C         ; OLine=2854
                 CLC                       ; OLine=2855 
                                           
loc_775C:                                  ; OLine=2857
                 LDX      $15              ; OLine=2858 
                 LDA      0,X              ; OLine=2859
                 JSR      sub_7785         ; OLine=2860
                 DEC      $15              ; OLine=2861
                 LDX      $15              ; OLine=2862 
                 DEC      $16              ; OLine=2863
                 BPL      loc_774C         ; OLine=2864
                 RTS                       ; OLine=2865 
                                           ;  End of function sub_773F
                                           
                                           
                                           ;  ¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦ S U B R O U T I N E ¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦
                                           
                                           
sub_776C:                                  ; OLine=2872
                 LDY      #0               ; OLine=2873 
                 STY      $B               ; OLine=2874
                 LDY      #4               ; OLine=2875 
                                           
loc_7772:                                  ; OLine=2877
                 ROL      $B               ; OLine=2878 
                 ROL      A                ; OLine=2879
                 CMP      $C               ; OLine=2880
                 BCC      loc_777B         ; OLine=2881 
                 SBC      $C               ; OLine=2882 
                                           
loc_777B:                                  ; OLine=2884
                 DEY                       ; OLine=2885 
                 BNE      loc_7772         ; OLine=2886
                 LDA      $B               ; OLine=2887
                 ROL      A                ; OLine=2888
                 AND      #$F              ; OLine=2889 
                 TAX                       ; OLine=2890
                 RTS                       ; OLine=2891 
                                           ;  End of function sub_776C
                                           
                                           
                                           ;  ¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦ S U B R O U T I N E ¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦
                                           
                                           
sub_7785:                                  ; OLine=2898
                                           
                 BCC      sub_778B         ; OLine=2900 
                 AND      #$F              ; OLine=2901
                 BEQ      loc_77B2         ; OLine=2902 
                                           ;  End of function sub_7785
                                           
                                           
                                           ;  ¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦ S U B R O U T I N E ¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦
                                           
                                           
sub_778B:                                  ; OLine=2909
                                           
                 LDX      $17              ; OLine=2911 
                 BEQ      loc_77B2         ; OLine=2912
                 AND      #$F              ; OLine=2913
                 CLC                       ; OLine=2914
                 ADC      #1               ; OLine=2915 
                 PHP                       ; OLine=2916
                 ASL      A                ; OLine=2917
                 TAY                       ; OLine=2918
                 LDA      $56D4,Y          ; OLine=2919 
                 ASL      A                ; OLine=2920
                 STA      $B               ; OLine=2921
                 LDA      $56D5,Y          ; OLine=2922
                 ROL      A                ; OLine=2923 
                 AND      #$1F             ; OLine=2924
                 ORA      #$40             ; OLine=2925
                 STA      $C               ; OLine=2926
                 LDA      #0               ; OLine=2927 
                 STA      8                ; OLine=2928
                 STA      9                ; OLine=2929
                 JSR      sub_6AD7         ; OLine=2930
                 PLP                       ; OLine=2931 
                 RTS                       ; OLine=2932 
                                           ;  ---------------------------------------------------------------------------
                                           
loc_77B2:                                  ; OLine=2935
                                           
                 JMP      loc_7BCB         ; OLine=2937 
                                           ;  End of function sub_778B
                                           
                                           
                                           ;  ¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦ S U B R O U T I N E ¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦
                                           
                                           
sub_77B5:                                  ; OLine=2944
                                           
                 ASL      $5F              ; OLine=2946 
                 ROL      $60              ; OLine=2947
                 BPL      loc_77BD         ; OLine=2948
                 INC      $5F              ; OLine=2949 
                                           
loc_77BD:                                  ; OLine=2951
                 LDA      $5F              ; OLine=2952 
                 BIT      byte_77D1        ; OLine=2953
                 BEQ      loc_77C8         ; OLine=2954 
                 EOR      #1               ; OLine=2955
                 STA      $5F              ; OLine=2956 
                                           
loc_77C8:                                  ; OLine=2958
                 ORA      $60              ; OLine=2959 
                 BNE      loc_77CE         ; OLine=2960
                 INC      $5F              ; OLine=2961 
                                           
loc_77CE:                                  ; OLine=2963
                 LDA      $5F              ; OLine=2964 
                 RTS                       ; OLine=2965 
                                           ;  End of function sub_77B5
                                           
                                           ;  ---------------------------------------------------------------------------
byte_77D1:       .BYTE    2                ; OLine=2969
                                           
                                           ;  ¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦ S U B R O U T I N E ¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦
                                           
                                           
sub_77D2:                                  ; OLine=2974
                                           
                 CLC                       ; OLine=2976 
                 ADC      #$40             ; OLine=2977 
                                           ;  End of function sub_77D2
                                           
                                           
                                           ;  ¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦ S U B R O U T I N E ¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦
                                           
                                           
sub_77D5:                                  ; OLine=2984
                                           
                 BPL      sub_77DF         ; OLine=2986 
                 AND      #$7F             ; OLine=2987
                 JSR      sub_77DF         ; OLine=2988
                 JMP      sub_7708         ; OLine=2989 
                                           ;  End of function sub_77D5
                                           
                                           
                                           ;  ¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦ S U B R O U T I N E ¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦
                                           
                                           
sub_77DF:                                  ; OLine=2996
                                           
                 CMP      #$41             ; OLine=2998 
                 BCC      loc_77E7         ; OLine=2999
                 EOR      #$7F             ; OLine=3000
                 ADC      #0               ; OLine=3001 
                                           
loc_77E7:                                  ; OLine=3003
                 TAX                       ; OLine=3004 
                 LDA      $57B9,X          ; OLine=3005
                 RTS                       ; OLine=3006 
                                           ;  End of function sub_77DF
                                           
                                           ;  ---------------------------------------------------------------------------
                 .BYTE    0                ; OLine=3010
                 .BYTE    0                ; OLine=3011
                 .BYTE    0                ; OLine=3012
                 .BYTE    0                ; OLine=3013
                 .BYTE    0                ; OLine=3014
                 .BYTE    0                ; OLine=3015
                 .BYTE    0                ; OLine=3016
                 .BYTE    0                ; OLine=3017
                 .BYTE    0                ; OLine=3018
                 .BYTE    0                ; OLine=3019
                                           
                                           ;  ¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦ S U B R O U T I N E ¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦
                                           
                                           
sub_77F6:                                  ; OLine=3024
                                           
                 LDA      $2803            ; OLine=3026  DIP Switches 1 & 2, Language
                 AND      #3               ; OLine=3027
                 ASL      A                ; OLine=3028
                 TAX                       ; OLine=3029
                 LDA      #$10             ; OLine=3030
                 STA      0                ; OLine=3031
                 LDA      $7888,X          ; OLine=3032  Address Of Message Offset Table
                 STA      9                ; OLine=3033
                 LDA      $7887,X          ; OLine=3034
                 STA      8                ; OLine=3035
                 ADC      (8),Y            ; OLine=3036  Add In The Offset To Get Starting
                 STA      8                ; OLine=3037  Address Of Message
                 BCC      loc_7813         ; OLine=3038
                 INC      9                ; OLine=3039
                                           
loc_7813:                                  ; OLine=3041
                 TYA                       ; OLine=3042 
                 ASL      A                ; OLine=3043
                 TAY                       ; OLine=3044
                 LDA      $7871,Y          ; OLine=3045
                 LDX      $7872,Y          ; OLine=3046 
                 JSR      sub_7C03         ; OLine=3047
                 LDA      #$70             ; OLine=3048
                 JSR      sub_7CDE         ; OLine=3049
                 LDY      #0               ; OLine=3050 
                 LDX      #0               ; OLine=3051 
                                           
loc_7828:                                  ; OLine=3053
                 LDA      (8,X)            ; OLine=3054 
                 STA      $B               ; OLine=3055
                 LSR      A                ; OLine=3056
                 LSR      A                ; OLine=3057
                 JSR      sub_784D         ; OLine=3058 
                 LDA      (8,X)            ; OLine=3059
                 ROL      A                ; OLine=3060
                 ROL      $B               ; OLine=3061
                 ROL      A                ; OLine=3062 
                 LDA      $B               ; OLine=3063
                 ROL      A                ; OLine=3064
                 ASL      A                ; OLine=3065
                 JSR      sub_7853         ; OLine=3066 
                 LDA      (8,X)            ; OLine=3067
                 STA      $B               ; OLine=3068
                 JSR      sub_784D         ; OLine=3069
                 LSR      $B               ; OLine=3070 
                 BCC      loc_7828         ; OLine=3071 
                                           
loc_7849:                                  ; OLine=3073
                 DEY                       ; OLine=3074 
                 JMP      sub_7C39         ; OLine=3075 
                                           ;  End of function sub_77F6
                                           
                                           
                                           ;  ¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦ S U B R O U T I N E ¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦
                                           
                                           
sub_784D:                                  ; OLine=3082
                                           
                 INC      8                ; OLine=3084 
                 BNE      sub_7853         ; OLine=3085
                 INC      9                ; OLine=3086 
                                           ;  End of function sub_784D
                                           
                                           
                                           ;  ¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦ S U B R O U T I N E ¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦
                                           
                                           
sub_7853:                                  ; OLine=3093
                                           
                 AND      #$3E             ; OLine=3095 
                 BNE      loc_785B         ; OLine=3096
                 PLA                       ; OLine=3097
                 PLA                       ; OLine=3098 
                 BNE      loc_7849         ; OLine=3099 
                                           
loc_785B:                                  ; OLine=3101
                 CMP      #$A              ; OLine=3102 
                 BCC      loc_7861         ; OLine=3103
                 ADC      #$D              ; OLine=3104 
                                           
loc_7861:                                  ; OLine=3106
                 TAX                       ; OLine=3107 
                 LDA      $56D2,X          ; OLine=3108
                 STA      (2),Y            ; OLine=3109
                 INY                       ; OLine=3110 
                 LDA      $56D3,X          ; OLine=3111
                 STA      (2),Y            ; OLine=3112
                 INY                       ; OLine=3113
                 LDX      #0               ; OLine=3114 
                 RTS                       ; OLine=3115 
                                           ;  End of function sub_7853
                                           
                                           ;  ---------------------------------------------------------------------------
                 .BYTE    $64              ; OLine=3119
                 .BYTE    $B6              ; OLine=3120
                                           
                 .BYTE    $64              ; OLine=3122
                 .BYTE    $B6              ; OLine=3123
                                           
                 .BYTE    $C               ; OLine=3125
                 .BYTE    $AA              ; OLine=3126
                                           
                 .BYTE    $C               ; OLine=3128
                 .BYTE    $A2              ; OLine=3129
                                           
                 .BYTE    $C               ; OLine=3131
                 .BYTE    $9A              ; OLine=3132
                                           
                 .BYTE    $C               ; OLine=3134
                 .BYTE    $92              ; OLine=3135
                                           
                 .BYTE    $64              ; OLine=3137
                 .BYTE    $C6              ; OLine=3138
                                           
                 .BYTE    $64              ; OLine=3140
                 .BYTE    $9D              ; OLine=3141
                                           
                 .BYTE    $50              ; OLine=3143
                 .BYTE    $39              ; OLine=3144
                                           
                 .BYTE    $50              ; OLine=3146
                 .BYTE    $39              ; OLine=3147
                                           
                 .BYTE    $50              ; OLine=3149
                 .BYTE    $39              ; OLine=3150
                                           
                                           
                 .BYTE    $1E              ; OLine=3153  English
                 .BYTE    $57              ; OLine=3154
                                           
                 .BYTE    $8F              ; OLine=3156
                 .BYTE    $78              ; OLine=3157
                                           
                 .BYTE    $46              ; OLine=3159
                 .BYTE    $79              ; OLine=3160
                                           
                 .BYTE    $F3              ; OLine=3162
                 .BYTE    $79              ; OLine=3163
                                           
                 .BYTE    $B               ; OLine=3165
                 .BYTE    $15              ; OLine=3166
                 .BYTE    $1B              ; OLine=3167
                 .BYTE    $35              ; OLine=3168
                 .BYTE    $4D              ; OLine=3169
                 .BYTE    $65              ; OLine=3170
                 .BYTE    $7F              ; OLine=3171
                 .BYTE    $8D              ; OLine=3172
                 .BYTE    $93              ; OLine=3173
                 .BYTE    $9F              ; OLine=3174
                 .BYTE    $AB              ; OLine=3175
                                           
                 .BYTE    $64              ; OLine=3177
                 .BYTE    $D2              ; OLine=3178
                 .BYTE    $3B              ; OLine=3179
                 .BYTE    $2E              ; OLine=3180
                 .BYTE    $C2              ; OLine=3181
                 .BYTE    $6C              ; OLine=3182
                 .BYTE    $5A              ; OLine=3183
                 .BYTE    $4C              ; OLine=3184
                 .BYTE    $93              ; OLine=3185
                 .BYTE    $6F              ; OLine=3186
                 .BYTE    $BD              ; OLine=3187
                 .BYTE    $1A              ; OLine=3188
                 .BYTE    $4C              ; OLine=3189
                 .BYTE    $12              ; OLine=3190
                 .BYTE    $B0              ; OLine=3191
                 .BYTE    $40              ; OLine=3192
                 .BYTE    $6B              ; OLine=3193
                 .BYTE    $2C              ; OLine=3194
                 .BYTE    $A               ; OLine=3195
                 .BYTE    $6C              ; OLine=3196
                 .BYTE    $5A              ; OLine=3197
                 .BYTE    $4C              ; OLine=3198
                 .BYTE    $93              ; OLine=3199
                 .BYTE    $6E              ; OLine=3200
                 .BYTE    $B               ; OLine=3201
                 .BYTE    $6E              ; OLine=3202
                 .BYTE    $C0              ; OLine=3203
                 .BYTE    $52              ; OLine=3204
                 .BYTE    $6C              ; OLine=3205
                 .BYTE    $92              ; OLine=3206
                 .BYTE    $B8              ; OLine=3207
                 .BYTE    $50              ; OLine=3208
                 .BYTE    $4D              ; OLine=3209
                 .BYTE    $82              ; OLine=3210
                 .BYTE    $F2              ; OLine=3211
                 .BYTE    $58              ; OLine=3212
                 .BYTE    $90              ; OLine=3213
                 .BYTE    $4C              ; OLine=3214
                 .BYTE    $4D              ; OLine=3215
                 .BYTE    $F0              ; OLine=3216
                 .BYTE    $4C              ; OLine=3217
                 .BYTE    $80              ; OLine=3218
                 .BYTE    $33              ; OLine=3219
                 .BYTE    $70              ; OLine=3220
                 .BYTE    $C2              ; OLine=3221
                 .BYTE    $42              ; OLine=3222
                 .BYTE    $5A              ; OLine=3223
                 .BYTE    $4C              ; OLine=3224
                 .BYTE    $4C              ; OLine=3225
                 .BYTE    $82              ; OLine=3226
                 .BYTE    $BB              ; OLine=3227
                 .BYTE    $52              ; OLine=3228
                 .BYTE    $B               ; OLine=3229
                 .BYTE    $58              ; OLine=3230
                 .BYTE    $B2              ; OLine=3231
                 .BYTE    $42              ; OLine=3232
                 .BYTE    $6C              ; OLine=3233
                 .BYTE    $9A              ; OLine=3234
                 .BYTE    $C3              ; OLine=3235
                 .BYTE    $4A              ; OLine=3236
                 .BYTE    $82              ; OLine=3237
                 .BYTE    $64              ; OLine=3238
                 .BYTE    $A               ; OLine=3239
                 .BYTE    $5A              ; OLine=3240
                 .BYTE    $90              ; OLine=3241
                 .BYTE    0                ; OLine=3242
                 .BYTE    $F6              ; OLine=3243
                 .BYTE    $6C              ; OLine=3244
                 .BYTE    9                ; OLine=3245
                 .BYTE    $B2              ; OLine=3246
                 .BYTE    $3B              ; OLine=3247
                 .BYTE    $2E              ; OLine=3248
                 .BYTE    $C1              ; OLine=3249
                 .BYTE    $4C              ; OLine=3250
                 .BYTE    $4C              ; OLine=3251
                 .BYTE    $B6              ; OLine=3252
                 .BYTE    $2B              ; OLine=3253
                 .BYTE    $20              ; OLine=3254
                 .BYTE    $D               ; OLine=3255
                 .BYTE    $A6              ; OLine=3256
                 .BYTE    $C1              ; OLine=3257
                 .BYTE    $70              ; OLine=3258
                 .BYTE    $48              ; OLine=3259
                 .BYTE    $50              ; OLine=3260
                 .BYTE    $B6              ; OLine=3261
                 .BYTE    $52              ; OLine=3262
                 .BYTE    $3B              ; OLine=3263
                 .BYTE    $D2              ; OLine=3264
                 .BYTE    $90              ; OLine=3265
                 .BYTE    0                ; OLine=3266
                 .BYTE    $DA              ; OLine=3267
                 .BYTE    $64              ; OLine=3268
                 .BYTE    $90              ; OLine=3269
                 .BYTE    $4C              ; OLine=3270
                 .BYTE    $C9              ; OLine=3271
                 .BYTE    $D8              ; OLine=3272
                 .BYTE    $BE              ; OLine=3273
                 .BYTE    $A               ; OLine=3274
                 .BYTE    $32              ; OLine=3275
                 .BYTE    $42              ; OLine=3276
                 .BYTE    $9B              ; OLine=3277
                 .BYTE    $C2              ; OLine=3278
                 .BYTE    $67              ; OLine=3279
                 .BYTE    $68              ; OLine=3280
                 .BYTE    $4D              ; OLine=3281
                 .BYTE    $AE              ; OLine=3282
                 .BYTE    $A1              ; OLine=3283
                 .BYTE    $4E              ; OLine=3284
                 .BYTE    $48              ; OLine=3285
                 .BYTE    $50              ; OLine=3286
                 .BYTE    $B6              ; OLine=3287
                 .BYTE    $52              ; OLine=3288
                 .BYTE    $3B              ; OLine=3289
                 .BYTE    $D2              ; OLine=3290
                 .BYTE    $90              ; OLine=3291
                 .BYTE    0                ; OLine=3292
                 .BYTE    $BE              ; OLine=3293
                 .BYTE    $A               ; OLine=3294
                 .BYTE    $B6              ; OLine=3295
                 .BYTE    $1E              ; OLine=3296
                 .BYTE    $94              ; OLine=3297
                 .BYTE    $D2              ; OLine=3298
                 .BYTE    $A2              ; OLine=3299
                 .BYTE    $92              ; OLine=3300
                 .BYTE    $A               ; OLine=3301
                 .BYTE    $2C              ; OLine=3302
                 .BYTE    $CA              ; OLine=3303
                 .BYTE    $4E              ; OLine=3304
                 .BYTE    $7A              ; OLine=3305
                 .BYTE    $65              ; OLine=3306
                 .BYTE    $BD              ; OLine=3307
                 .BYTE    $1A              ; OLine=3308
                 .BYTE    $4C              ; OLine=3309
                 .BYTE    $12              ; OLine=3310
                 .BYTE    $92              ; OLine=3311
                 .BYTE    $13              ; OLine=3312
                 .BYTE    $18              ; OLine=3313
                 .BYTE    $62              ; OLine=3314
                 .BYTE    $CA              ; OLine=3315
                 .BYTE    $64              ; OLine=3316
                 .BYTE    $F2              ; OLine=3317
                 .BYTE    $42              ; OLine=3318
                 .BYTE    $20              ; OLine=3319
                 .BYTE    $6E              ; OLine=3320
                 .BYTE    $A3              ; OLine=3321
                 .BYTE    $52              ; OLine=3322
                 .BYTE    $82              ; OLine=3323
                 .BYTE    $40              ; OLine=3324
                 .BYTE    $18              ; OLine=3325
                 .BYTE    $62              ; OLine=3326
                 .BYTE    $CA              ; OLine=3327
                 .BYTE    $64              ; OLine=3328
                 .BYTE    $F2              ; OLine=3329
                 .BYTE    $42              ; OLine=3330
                 .BYTE    $18              ; OLine=3331
                 .BYTE    $6E              ; OLine=3332
                 .BYTE    $A3              ; OLine=3333
                 .BYTE    $52              ; OLine=3334
                 .BYTE    $80              ; OLine=3335
                 .BYTE    0                ; OLine=3336
                 .BYTE    $20              ; OLine=3337
                 .BYTE    $62              ; OLine=3338
                 .BYTE    $CA              ; OLine=3339
                 .BYTE    $64              ; OLine=3340
                 .BYTE    $F2              ; OLine=3341
                 .BYTE    $64              ; OLine=3342
                 .BYTE    8                ; OLine=3343
                 .BYTE    $C2              ; OLine=3344
                 .BYTE    $BD              ; OLine=3345
                 .BYTE    $1A              ; OLine=3346
                 .BYTE    $4C              ; OLine=3347
                 .BYTE    0                ; OLine=3348
                                           
                 .BYTE    $B               ; OLine=3350
                 .BYTE    $15              ; OLine=3351
                 .BYTE    $19              ; OLine=3352
                 .BYTE    $31              ; OLine=3353
                 .BYTE    $41              ; OLine=3354
                 .BYTE    $57              ; OLine=3355
                 .BYTE    $73              ; OLine=3356
                 .BYTE    $7F              ; OLine=3357
                 .BYTE    $89              ; OLine=3358
                 .BYTE    $95              ; OLine=3359
                 .BYTE    $A1              ; OLine=3360
                                           
                 .BYTE    $8A              ; OLine=3362
                 .BYTE    $5A              ; OLine=3363
                 .BYTE    $84              ; OLine=3364
                 .BYTE    $12              ; OLine=3365
                 .BYTE    $CD              ; OLine=3366
                 .BYTE    $82              ; OLine=3367
                 .BYTE    $B9              ; OLine=3368
                 .BYTE    $E6              ; OLine=3369
                 .BYTE    $B2              ; OLine=3370
                 .BYTE    $40              ; OLine=3371
                 .BYTE    $74              ; OLine=3372
                 .BYTE    $F2              ; OLine=3373
                 .BYTE    $4D              ; OLine=3374
                 .BYTE    $83              ; OLine=3375
                 .BYTE    $D4              ; OLine=3376
                 .BYTE    $F0              ; OLine=3377
                 .BYTE    $B2              ; OLine=3378
                 .BYTE    $42              ; OLine=3379
                 .BYTE    $B9              ; OLine=3380
                 .BYTE    $E6              ; OLine=3381
                 .BYTE    $B2              ; OLine=3382
                 .BYTE    $42              ; OLine=3383
                 .BYTE    $4D              ; OLine=3384
                 .BYTE    $F0              ; OLine=3385
                 .BYTE    $E               ; OLine=3386
                 .BYTE    $64              ; OLine=3387
                 .BYTE    $A               ; OLine=3388
                 .BYTE    $12              ; OLine=3389
                 .BYTE    $B8              ; OLine=3390
                 .BYTE    $46              ; OLine=3391
                 .BYTE    $10              ; OLine=3392
                 .BYTE    $62              ; OLine=3393
                 .BYTE    $4B              ; OLine=3394
                 .BYTE    $60              ; OLine=3395
                 .BYTE    $82              ; OLine=3396
                 .BYTE    $72              ; OLine=3397
                 .BYTE    $B5              ; OLine=3398
                 .BYTE    $C0              ; OLine=3399
                 .BYTE    $BE              ; OLine=3400
                 .BYTE    $A8              ; OLine=3401
                 .BYTE    $A               ; OLine=3402
                 .BYTE    $64              ; OLine=3403
                 .BYTE    $C5              ; OLine=3404
                 .BYTE    $92              ; OLine=3405
                 .BYTE    $F0              ; OLine=3406
                 .BYTE    $74              ; OLine=3407
                 .BYTE    $9D              ; OLine=3408
                 .BYTE    $C2              ; OLine=3409
                 .BYTE    $6C              ; OLine=3410
                 .BYTE    $9A              ; OLine=3411
                 .BYTE    $C3              ; OLine=3412
                 .BYTE    $4A              ; OLine=3413
                 .BYTE    $82              ; OLine=3414
                 .BYTE    $6F              ; OLine=3415
                 .BYTE    $A4              ; OLine=3416
                 .BYTE    $F2              ; OLine=3417
                 .BYTE    $BD              ; OLine=3418
                 .BYTE    $D2              ; OLine=3419
                 .BYTE    $F0              ; OLine=3420
                 .BYTE    $6C              ; OLine=3421
                 .BYTE    $9E              ; OLine=3422
                 .BYTE    $A               ; OLine=3423
                 .BYTE    $C2              ; OLine=3424
                 .BYTE    $42              ; OLine=3425
                 .BYTE    $A4              ; OLine=3426
                 .BYTE    $F2              ; OLine=3427
                 .BYTE    $B0              ; OLine=3428
                 .BYTE    $74              ; OLine=3429
                 .BYTE    $9D              ; OLine=3430
                 .BYTE    $C2              ; OLine=3431
                 .BYTE    $6C              ; OLine=3432
                 .BYTE    $9A              ; OLine=3433
                 .BYTE    $C3              ; OLine=3434
                 .BYTE    $4A              ; OLine=3435
                 .BYTE    $82              ; OLine=3436
                 .BYTE    $6F              ; OLine=3437
                 .BYTE    $A4              ; OLine=3438
                 .BYTE    $F2              ; OLine=3439
                 .BYTE    $BD              ; OLine=3440
                 .BYTE    $D2              ; OLine=3441
                 .BYTE    $F0              ; OLine=3442
                 .BYTE    $58              ; OLine=3443
                 .BYTE    $ED              ; OLine=3444
                 .BYTE    $12              ; OLine=3445
                 .BYTE    $B5              ; OLine=3446
                 .BYTE    $E8              ; OLine=3447
                 .BYTE    $29              ; OLine=3448
                 .BYTE    $D2              ; OLine=3449
                 .BYTE    $D               ; OLine=3450
                 .BYTE    $72              ; OLine=3451
                 .BYTE    $2C              ; OLine=3452
                 .BYTE    $90              ; OLine=3453
                 .BYTE    $C               ; OLine=3454
                 .BYTE    $12              ; OLine=3455
                 .BYTE    $C6              ; OLine=3456
                 .BYTE    $2C              ; OLine=3457
                 .BYTE    $48              ; OLine=3458
                 .BYTE    $4E              ; OLine=3459
                 .BYTE    $9D              ; OLine=3460
                 .BYTE    $AC              ; OLine=3461
                 .BYTE    $49              ; OLine=3462
                 .BYTE    $F0              ; OLine=3463
                 .BYTE    $48              ; OLine=3464
                 .BYTE    0                ; OLine=3465
                 .BYTE    $2D              ; OLine=3466
                 .BYTE    $28              ; OLine=3467
                 .BYTE    $CF              ; OLine=3468
                 .BYTE    $52              ; OLine=3469
                 .BYTE    $B0              ; OLine=3470
                 .BYTE    $6E              ; OLine=3471
                 .BYTE    $CD              ; OLine=3472
                 .BYTE    $82              ; OLine=3473
                 .BYTE    $BE              ; OLine=3474
                 .BYTE    $A               ; OLine=3475
                 .BYTE    $B6              ; OLine=3476
                 .BYTE    0                ; OLine=3477
                 .BYTE    $53              ; OLine=3478
                 .BYTE    $64              ; OLine=3479
                 .BYTE    $A               ; OLine=3480
                 .BYTE    $12              ; OLine=3481
                 .BYTE    $D               ; OLine=3482
                 .BYTE    $A               ; OLine=3483
                 .BYTE    $B6              ; OLine=3484
                 .BYTE    $1A              ; OLine=3485
                 .BYTE    $48              ; OLine=3486
                 .BYTE    0                ; OLine=3487
                 .BYTE    $18              ; OLine=3488
                 .BYTE    $68              ; OLine=3489
                 .BYTE    $6A              ; OLine=3490
                 .BYTE    $4E              ; OLine=3491
                 .BYTE    $48              ; OLine=3492
                 .BYTE    $48              ; OLine=3493
                 .BYTE    $B               ; OLine=3494
                 .BYTE    $A6              ; OLine=3495
                 .BYTE    $CA              ; OLine=3496
                 .BYTE    $72              ; OLine=3497
                 .BYTE    $B5              ; OLine=3498
                 .BYTE    $C0              ; OLine=3499
                 .BYTE    $18              ; OLine=3500
                 .BYTE    $68              ; OLine=3501
                 .BYTE    $6A              ; OLine=3502
                 .BYTE    $4E              ; OLine=3503
                 .BYTE    $48              ; OLine=3504
                 .BYTE    $46              ; OLine=3505
                 .BYTE    $B               ; OLine=3506
                 .BYTE    $A6              ; OLine=3507
                 .BYTE    $CA              ; OLine=3508
                 .BYTE    $72              ; OLine=3509
                 .BYTE    $B0              ; OLine=3510
                 .BYTE    0                ; OLine=3511
                 .BYTE    $20              ; OLine=3512
                 .BYTE    $68              ; OLine=3513
                 .BYTE    $6A              ; OLine=3514
                 .BYTE    $4E              ; OLine=3515
                 .BYTE    $4D              ; OLine=3516
                 .BYTE    $C2              ; OLine=3517
                 .BYTE    $18              ; OLine=3518
                 .BYTE    $5C              ; OLine=3519
                 .BYTE    $9E              ; OLine=3520
                 .BYTE    $52              ; OLine=3521
                 .BYTE    $CD              ; OLine=3522
                 .BYTE    $80              ; OLine=3523
                                           
                 .BYTE    $B               ; OLine=3525
                 .BYTE    $11              ; OLine=3526
                 .BYTE    $17              ; OLine=3527
                 .BYTE    $31              ; OLine=3528
                 .BYTE    $45              ; OLine=3529
                 .BYTE    $5F              ; OLine=3530
                 .BYTE    $6B              ; OLine=3531
                 .BYTE    $73              ; OLine=3532
                 .BYTE    $7D              ; OLine=3533
                 .BYTE    $89              ; OLine=3534
                 .BYTE    $93              ; OLine=3535
                                           
                 .BYTE    $B2              ; OLine=3537
                 .BYTE    $4E              ; OLine=3538
                 .BYTE    $9D              ; OLine=3539
                 .BYTE    $90              ; OLine=3540
                 .BYTE    $B8              ; OLine=3541
                 .BYTE    0                ; OLine=3542
                 .BYTE    $76              ; OLine=3543
                 .BYTE    $56              ; OLine=3544
                 .BYTE    $2A              ; OLine=3545
                 .BYTE    $26              ; OLine=3546
                 .BYTE    $B0              ; OLine=3547
                 .BYTE    $40              ; OLine=3548
                 .BYTE    $BE              ; OLine=3549
                 .BYTE    $42              ; OLine=3550
                 .BYTE    $A6              ; OLine=3551
                 .BYTE    $64              ; OLine=3552
                 .BYTE    $C1              ; OLine=3553
                 .BYTE    $5C              ; OLine=3554
                 .BYTE    $48              ; OLine=3555
                 .BYTE    $52              ; OLine=3556
                 .BYTE    $BE              ; OLine=3557
                 .BYTE    $A               ; OLine=3558
                 .BYTE    $A               ; OLine=3559
                 .BYTE    $64              ; OLine=3560
                 .BYTE    $C5              ; OLine=3561
                 .BYTE    $92              ; OLine=3562
                 .BYTE    $C               ; OLine=3563
                 .BYTE    $26              ; OLine=3564
                 .BYTE    $B8              ; OLine=3565
                 .BYTE    $50              ; OLine=3566
                 .BYTE    $6A              ; OLine=3567
                 .BYTE    $7C              ; OLine=3568
                 .BYTE    $C               ; OLine=3569
                 .BYTE    $52              ; OLine=3570
                 .BYTE    $74              ; OLine=3571
                 .BYTE    $EC              ; OLine=3572
                 .BYTE    $4D              ; OLine=3573
                 .BYTE    $C0              ; OLine=3574
                 .BYTE    $A4              ; OLine=3575
                 .BYTE    $EC              ; OLine=3576
                 .BYTE    $A               ; OLine=3577
                 .BYTE    $8A              ; OLine=3578
                 .BYTE    $D4              ; OLine=3579
                 .BYTE    $EC              ; OLine=3580
                 .BYTE    $A               ; OLine=3581
                 .BYTE    $64              ; OLine=3582
                 .BYTE    $C5              ; OLine=3583
                 .BYTE    $92              ; OLine=3584
                 .BYTE    $D               ; OLine=3585
                 .BYTE    $F2              ; OLine=3586
                 .BYTE    $B8              ; OLine=3587
                 .BYTE    $5A              ; OLine=3588
                 .BYTE    $93              ; OLine=3589
                 .BYTE    $4E              ; OLine=3590
                 .BYTE    $69              ; OLine=3591
                 .BYTE    $60              ; OLine=3592
                 .BYTE    $4D              ; OLine=3593
                 .BYTE    $C0              ; OLine=3594
                 .BYTE    $9D              ; OLine=3595
                 .BYTE    $2C              ; OLine=3596
                 .BYTE    $6C              ; OLine=3597
                 .BYTE    $4A              ; OLine=3598
                 .BYTE    $D               ; OLine=3599
                 .BYTE    $A6              ; OLine=3600
                 .BYTE    $C1              ; OLine=3601
                 .BYTE    $70              ; OLine=3602
                 .BYTE    $48              ; OLine=3603
                 .BYTE    $68              ; OLine=3604
                 .BYTE    $2D              ; OLine=3605
                 .BYTE    $8A              ; OLine=3606
                 .BYTE    $D               ; OLine=3607
                 .BYTE    $D2              ; OLine=3608
                 .BYTE    $82              ; OLine=3609
                 .BYTE    $4E              ; OLine=3610
                 .BYTE    $3B              ; OLine=3611
                 .BYTE    $66              ; OLine=3612
                 .BYTE    $91              ; OLine=3613
                 .BYTE    $6C              ; OLine=3614
                 .BYTE    $C               ; OLine=3615
                 .BYTE    $A               ; OLine=3616
                 .BYTE    $C               ; OLine=3617
                 .BYTE    $12              ; OLine=3618
                 .BYTE    $C5              ; OLine=3619
                 .BYTE    $8B              ; OLine=3620
                 .BYTE    $9D              ; OLine=3621
                 .BYTE    $2C              ; OLine=3622
                 .BYTE    $6C              ; OLine=3623
                 .BYTE    $4A              ; OLine=3624
                 .BYTE    $B               ; OLine=3625
                 .BYTE    $3A              ; OLine=3626
                 .BYTE    $A2              ; OLine=3627
                 .BYTE    $6C              ; OLine=3628
                 .BYTE    $BD              ; OLine=3629
                 .BYTE    $A               ; OLine=3630
                 .BYTE    $3A              ; OLine=3631
                 .BYTE    $40              ; OLine=3632
                 .BYTE    $A6              ; OLine=3633
                 .BYTE    $60              ; OLine=3634
                 .BYTE    $B9              ; OLine=3635
                 .BYTE    $6C              ; OLine=3636
                 .BYTE    $D               ; OLine=3637
                 .BYTE    $F0              ; OLine=3638
                 .BYTE    $2D              ; OLine=3639
                 .BYTE    $B1              ; OLine=3640
                 .BYTE    $76              ; OLine=3641
                 .BYTE    $52              ; OLine=3642
                 .BYTE    $5C              ; OLine=3643
                 .BYTE    $C2              ; OLine=3644
                 .BYTE    $C2              ; OLine=3645
                 .BYTE    $6C              ; OLine=3646
                 .BYTE    $8B              ; OLine=3647
                 .BYTE    $64              ; OLine=3648
                 .BYTE    $2A              ; OLine=3649
                 .BYTE    $27              ; OLine=3650
                 .BYTE    $18              ; OLine=3651
                 .BYTE    $54              ; OLine=3652
                 .BYTE    $69              ; OLine=3653
                 .BYTE    $D8              ; OLine=3654
                 .BYTE    $28              ; OLine=3655
                 .BYTE    $48              ; OLine=3656
                 .BYTE    $B               ; OLine=3657
                 .BYTE    $B2              ; OLine=3658
                 .BYTE    $4A              ; OLine=3659
                 .BYTE    $E6              ; OLine=3660
                 .BYTE    $B8              ; OLine=3661
                 .BYTE    0                ; OLine=3662
                 .BYTE    $18              ; OLine=3663
                 .BYTE    $54              ; OLine=3664
                 .BYTE    $69              ; OLine=3665
                 .BYTE    $D8              ; OLine=3666
                 .BYTE    $28              ; OLine=3667
                 .BYTE    $46              ; OLine=3668
                 .BYTE    $B               ; OLine=3669
                 .BYTE    $B2              ; OLine=3670
                 .BYTE    $4A              ; OLine=3671
                 .BYTE    $E7              ; OLine=3672
                 .BYTE    $20              ; OLine=3673
                 .BYTE    $54              ; OLine=3674
                 .BYTE    $69              ; OLine=3675
                 .BYTE    $D8              ; OLine=3676
                 .BYTE    $2D              ; OLine=3677
                 .BYTE    $C2              ; OLine=3678
                 .BYTE    $18              ; OLine=3679
                 .BYTE    $5C              ; OLine=3680
                 .BYTE    $CA              ; OLine=3681
                 .BYTE    $56              ; OLine=3682
                 .BYTE    $98              ; OLine=3683
                 .BYTE    0                ; OLine=3684
                 .BYTE    $52              ; OLine=3685
                                           
                                           
                                           ;  ¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦ S U B R O U T I N E ¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦
                                           
                                           
sub_7A93:                                  ; OLine=3691
                 LDX      #2               ; OLine=3692
                                           
loc_7A95:                                  ; OLine=3694
                 LDA      $2400,X          ; OLine=3695  Coin Switch
                 ASL      A                ; OLine=3696  Shift High Bit To Carry
                 LDA      $7A,X            ; OLine=3697
                 AND      #$1F             ; OLine=3698  00011111
                 BCC      loc_7AD6         ; OLine=3699  No Coin For This Slot, Branch
                 BEQ      loc_7AB1         ; OLine=3700
                 CMP      #$1B             ; OLine=3701
                 BCS      loc_7AAF         ; OLine=3702 
                 TAY                       ; OLine=3703
                 LDA      $5E              ; OLine=3704
                 AND      #7               ; OLine=3705
                 CMP      #7               ; OLine=3706 
                 TYA                       ; OLine=3707
                 BCC      loc_7AB1         ; OLine=3708 
                                           
loc_7AAF:                                  ; OLine=3710
                 SBC      #1               ; OLine=3711 
                                           
loc_7AB1:                                  ; OLine=3713
                                           
                 STA      $7A,X            ; OLine=3715 
                 LDA      $2006            ; OLine=3716  Slam Switch
                 AND      #$80             ; OLine=3717 
                 BEQ      loc_7ABE         ; OLine=3718  Valid Coin, Branch
                 LDA      #$F0             ; OLine=3719  Flag Ill Gotten Gain
                 STA      $72              ; OLine=3720  Into Slam Switch Flag
                                           
loc_7ABE:                                  ; OLine=3722
                 LDA      $72              ; OLine=3723  Honest Coin?
                 BEQ      loc_7ACA         ; OLine=3724  Yes, Branch
                 DEC      $72              ; OLine=3725
                 LDA      #0               ; OLine=3726
                 STA      $7A,X            ; OLine=3727
                 STA      $77,X            ; OLine=3728 
                                           
loc_7ACA:                                  ; OLine=3730
                 CLC                       ; OLine=3731 
                 LDA      $77,X            ; OLine=3732
                 BEQ      loc_7AF2         ; OLine=3733
                 DEC      $77,X            ; OLine=3734 
                 BNE      loc_7AF2         ; OLine=3735
                 SEC                       ; OLine=3736 
                 BCS      loc_7AF2         ; OLine=3737 
                                           
loc_7AD6:                                  ; OLine=3739
                 CMP      #$1B             ; OLine=3740 
                 BCS      loc_7AE3         ; OLine=3741
                 LDA      $7A,X            ; OLine=3742 
                 ADC      #$20             ; OLine=3743
                 BCC      loc_7AB1         ; OLine=3744
                 BEQ      loc_7AE3         ; OLine=3745 
                 CLC                       ; OLine=3746
                                           
loc_7AE3:                                  ; OLine=3748
                                           
                 LDA      #$1F             ; OLine=3750 
                 BCS      loc_7AB1         ; OLine=3751
                 STA      $7A,X            ; OLine=3752 
                 LDA      $77,X            ; OLine=3753
                 BEQ      loc_7AEE         ; OLine=3754
                 SEC                       ; OLine=3755 
                                           
loc_7AEE:                                  ; OLine=3757
                 LDA      #$78             ; OLine=3758 
                 STA      $77,X            ; OLine=3759 
                                           
loc_7AF2:                                  ; OLine=3761
                                           
                 BCC      loc_7B17         ; OLine=3763 
                 LDA      #0               ; OLine=3764 
                 CPX      #1               ; OLine=3765 
                 BCC      loc_7B10         ; OLine=3766 
                 BEQ      loc_7B08         ; OLine=3767 
                 LDA      $71              ; OLine=3768  DIP Switch Bitmap
                 AND      #$C              ; OLine=3769  Mask Off Switches 5 & 6, Right Coin Slot Multiplier
                 LSR      A                ; OLine=3770 
                 LSR      A                ; OLine=3771 
                 BEQ      loc_7B10         ; OLine=3772  x1, Branch
                 ADC      #2               ; OLine=3773  2 + Set Bits From Settings = Total Coins After Multiplier
                 BNE      loc_7B10         ; OLine=3774  Will Always Branch
                                           
loc_7B08:                                  ; OLine=3776
                 LDA      $71              ; OLine=3777 
                 AND      #$10             ; OLine=3778 
                 BEQ      loc_7B10         ; OLine=3779 
                 LDA      #1               ; OLine=3780 
                                           
loc_7B10:                                  ; OLine=3782
                                           
                 SEC                       ; OLine=3784  Set Carry, This Will Add 1 To The Total
                 ADC      $73              ; OLine=3785 
                 STA      $73              ; OLine=3786 
                 INC      $74,X            ; OLine=3787 
                                           
loc_7B17:                                  ; OLine=3789
                 DEX                       ; OLine=3790
                 BMI      loc_7B1D         ; OLine=3791 
                 JMP      loc_7A95         ; OLine=3792 
                                           ;  ---------------------------------------------------------------------------
                                           
loc_7B1D:                                  ; OLine=3795
                 LDA      $71              ; OLine=3796  DIP Switch Settings
                 AND      #3               ; OLine=3797  Mask Off Switches 7 & 8, Coins Per Play
                 TAY                       ; OLine=3798 
                 BEQ      loc_7B36         ; OLine=3799  Free Play, Branch
                 LSR      A                ; OLine=3800 
                 ADC      #0               ; OLine=3801 
                 EOR      #$FF             ; OLine=3802
                 SEC                       ; OLine=3803
                 ADC      $73              ; OLine=3804 
                 BCC      loc_7B38         ; OLine=3805
                 CPY      #2               ; OLine=3806
                 BCS      loc_7B34         ; OLine=3807
                 INC      $70              ; OLine=3808  Add Credit
                                           
loc_7B34:                                  ; OLine=3810
                 INC      $70              ; OLine=3811  Add Credit
                                           
loc_7B36:                                  ; OLine=3813
                 STA      $73              ; OLine=3814 
                                           
loc_7B38:                                  ; OLine=3816
                 LDA      $5E              ; OLine=3817 
                 LSR      A                ; OLine=3818
                 BCS      locret_7B64      ; OLine=3819
                 LDY      #0               ; OLine=3820
                 LDX      #2               ; OLine=3821 
                                           
loc_7B41:                                  ; OLine=3823
                 LDA      $74,X            ; OLine=3824 
                 BEQ      loc_7B4E         ; OLine=3825
                 CMP      #$10             ; OLine=3826
                 BCC      loc_7B4E         ; OLine=3827
                 ADC      #$EF             ; OLine=3828 
                 INY                       ; OLine=3829
                 STA      $74,X            ; OLine=3830 
                                           
loc_7B4E:                                  ; OLine=3832
                                           
                 DEX                       ; OLine=3834 
                 BPL      loc_7B41         ; OLine=3835
                 TYA                       ; OLine=3836
                 BNE      locret_7B64      ; OLine=3837
                 LDX      #2               ; OLine=3838 
                                           
loc_7B56:                                  ; OLine=3840
                 LDA      $74,X            ; OLine=3841 
                 BEQ      loc_7B61         ; OLine=3842
                 CLC                       ; OLine=3843
                 ADC      #$EF             ; OLine=3844
                 STA      $74,X            ; OLine=3845 
                 BMI      locret_7B64      ; OLine=3846 
                                           
loc_7B61:                                  ; OLine=3848
                 DEX                       ; OLine=3849 
                 BPL      loc_7B56         ; OLine=3850 
                                           
locret_7B64:                               ; OLine=3852
                                           
                 RTS                       ; OLine=3854 
                                           ;  End of function sub_7A93
                                           
                                           ;  ---------------------------------------------------------------------------
                 PHA                       ; OLine=3858 
                 TYA                       ; OLine=3859
                 PHA                       ; OLine=3860
                 TXA                       ; OLine=3861
                 PHA                       ; OLine=3862 
                 CLD                       ; OLine=3863
                 LDA      $1FF             ; OLine=3864  Stack Space!
                 ORA      $1D0             ; OLine=3865 
                                           
loc_7B71:                                  ; OLine=3867
                 BNE      loc_7B71         ; OLine=3868  Endless Loop! Watchdog Will Time Out
                 INC      $5E              ; OLine=3869 
                 LDA      $5E              ; OLine=3870 
                 AND      #3               ; OLine=3871 
                 BNE      loc_7B83         ; OLine=3872
                 INC      $5B              ; OLine=3873 
                 LDA      $5B              ; OLine=3874
                 CMP      #4               ; OLine=3875 
                                           
loc_7B81:                                  ; OLine=3877
                 BCS      loc_7B81         ; OLine=3878  Endless Loop! Watchdog Will Time Out
                                           
loc_7B83:                                  ; OLine=3880
                 JSR      sub_7A93         ; OLine=3881 
                 LDA      $6F              ; OLine=3882
                 AND      #$C7             ; OLine=3883
                 BIT      $74              ; OLine=3884
                 BPL      loc_7B90         ; OLine=3885 
                 ORA      #8               ; OLine=3886
                                           
loc_7B90:                                  ; OLine=3888
                 BIT      $75              ; OLine=3889 
                 BPL      loc_7B96         ; OLine=3890
                 ORA      #$10             ; OLine=3891 
                                           
loc_7B96:                                  ; OLine=3893
                 BIT      $76              ; OLine=3894 
                 BPL      loc_7B9C         ; OLine=3895
                 ORA      #$20             ; OLine=3896 
                                           
loc_7B9C:                                  ; OLine=3898
                 STA      $6F              ; OLine=3899 
                 STA      $3200            ; OLine=3900 
                 LDA      $72              ; OLine=3901  Slam Switch Flag
                 BEQ      loc_7BA9         ; OLine=3902  Branch If Not Set
                 LDA      #$80             ; OLine=3903  Gonna Make Noise To Let 'Em Know They've Been Caught!
                 BNE      loc_7BB7         ; OLine=3904  Will Always Branch
                                           
loc_7BA9:                                  ; OLine=3906
                 LDA      $68              ; OLine=3907  Bonus Ship Sound Timer
                 BEQ      loc_7BB7         ; OLine=3908 
                 LDA      $5C              ; OLine=3909  Fast Timer
                 ROR      A                ; OLine=3910
                 BCC      loc_7BB4         ; OLine=3911 
                 DEC      $68              ; OLine=3912
                                           
loc_7BB4:                                  ; OLine=3914
                 ROR      A                ; OLine=3915 
                 ROR      A                ; OLine=3916
                 ROR      A                ; OLine=3917
                                           
loc_7BB7:                                  ; OLine=3919
                                           
                 STA      $3C05            ; OLine=3921  Life Sound
                 PLA                       ; OLine=3922
                 TAX                       ; OLine=3923
                 PLA                       ; OLine=3924
                 TAY                       ; OLine=3925 
                 PLA                       ; OLine=3926
                 RTI                       ; OLine=3927
                                           
                                           ;  ¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦ S U B R O U T I N E ¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦
                                           
                                           
sub_7BC0:                                  ; OLine=3932
                                           
                 LDA      #$B0             ; OLine=3934
                 LDY      #0               ; OLine=3935
                 STA      (2),Y            ; OLine=3936
                 INY                       ; OLine=3937
                 STA      (2),Y            ; OLine=3938
                 BNE      sub_7C39         ; OLine=3939
                                           
loc_7BCB:                                  ; OLine=3941
                 BCC      sub_7BD1         ; OLine=3942
                 AND      #$F              ; OLine=3943
                 BEQ      loc_7BD6         ; OLine=3944
                                           ;  End of function sub_7BC0
                                           
                                           
                                           ;  ¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦ S U B R O U T I N E ¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦
                                           
                                           
sub_7BD1:                                  ; OLine=3951
                                           
                 AND      #$F              ; OLine=3953
                 CLC                       ; OLine=3954
                 ADC      #1               ; OLine=3955
                                           
loc_7BD6:                                  ; OLine=3957
                 PHP                       ; OLine=3958
                 ASL      A                ; OLine=3959
                 LDY      #0               ; OLine=3960
                 TAX                       ; OLine=3961
                 LDA      $56D4,X          ; OLine=3962
                 STA      (2),Y            ; OLine=3963
                 LDA      $56D5,X          ; OLine=3964
                 INY                       ; OLine=3965
                 STA      (2),Y            ; OLine=3966
                 JSR      sub_7C39         ; OLine=3967
                 PLP                       ; OLine=3968
                 RTS                       ; OLine=3969
                                           ;  End of function sub_7BD1
                                           
                                           ;  ---------------------------------------------------------------------------
                 .BYTE    $4A              ; OLine=3973
                 .BYTE    $29              ; OLine=3974
                 .BYTE    $F               ; OLine=3975
                 .BYTE    9                ; OLine=3976
                 .BYTE    $E0              ; OLine=3977
                                           ;  ---------------------------------------------------------------------------
                                           
loc_7BF0:                                  ; OLine=3980
                 LDY      #1               ; OLine=3981
                 STA      (2),Y            ; OLine=3982
                 DEY                       ; OLine=3983
                 TXA                       ; OLine=3984
                 ROR      A                ; OLine=3985
                 STA      (2),Y            ; OLine=3986
                 INY                       ; OLine=3987
                 BNE      sub_7C39         ; OLine=3988
                                           
                                           ;  ¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦ S U B R O U T I N E ¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦
                                           
                                           
sub_7BFC:                                  ; OLine=3993
                                           
                 LSR      A                ; OLine=3995
                 AND      #$F              ; OLine=3996
                 ORA      #$C0             ; OLine=3997
                 BNE      loc_7BF0         ; OLine=3998
                                           ;  End of function sub_7BFC
                                           
                                           
                                           ;  ¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦ S U B R O U T I N E ¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦
                                           
                                           
sub_7C03:                                  ; OLine=4005
                                           
                 LDY      #0               ; OLine=4007
                 STY      5                ; OLine=4008
                 STY      7                ; OLine=4009
                 ASL      A                ; OLine=4010
                 ROL      5                ; OLine=4011
                 ASL      A                ; OLine=4012
                 ROL      5                ; OLine=4013
                 STA      4                ; OLine=4014
                 TXA                       ; OLine=4015
                 ASL      A                ; OLine=4016
                 ROL      7                ; OLine=4017
                 ASL      A                ; OLine=4018
                 ROL      7                ; OLine=4019
                 STA      6                ; OLine=4020
                 LDX      #4               ; OLine=4021
                                           ;  End of function sub_7C03
                                           
                                           
                                           ;  ¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦ S U B R O U T I N E ¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦
                                           
                                           
sub_7C1C:                                  ; OLine=4028
                 LDA      2,X              ; OLine=4029
                 LDY      #0               ; OLine=4030
                 STA      (2),Y            ; OLine=4031
                 LDA      3,X              ; OLine=4032
                 AND      #$F              ; OLine=4033
                 ORA      #$A0             ; OLine=4034
                 INY                       ; OLine=4035
                 STA      (2),Y            ; OLine=4036
                 LDA      0,X              ; OLine=4037
                 INY                       ; OLine=4038
                 STA      (2),Y            ; OLine=4039
                 LDA      1,X              ; OLine=4040
                 AND      #$F              ; OLine=4041
                 ORA      0                ; OLine=4042
                 INY                       ; OLine=4043
                 STA      (2),Y            ; OLine=4044
                                           ;  End of function sub_7C1C
                                           
                                           
                                           ;  ¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦ S U B R O U T I N E ¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦
                                           
                                           
sub_7C39:                                  ; OLine=4051
                                           
                 TYA                       ; OLine=4053
                 SEC                       ; OLine=4054
                 ADC      2                ; OLine=4055
                 STA      2                ; OLine=4056
                 BCC      locret_7C43      ; OLine=4057
                 INC      3                ; OLine=4058
                                           
locret_7C43:                               ; OLine=4060
                 RTS                       ; OLine=4061
                                           ;  End of function sub_7C39
                                           
                                           ;  ---------------------------------------------------------------------------
                 .BYTE    $A9              ; OLine=4065
                 .BYTE    $D0              ; OLine=4066
                 .BYTE    $4C              ; OLine=4067
                 .BYTE    $C2              ; OLine=4068
                 .BYTE    $7B              ; OLine=4069
                                           
                                           ;  ¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦ S U B R O U T I N E ¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦
                                           
                                           
sub_7C49:                                  ; OLine=4074
                 LDA      5                ; OLine=4075
                 CMP      #$80             ; OLine=4076
                 BCC      loc_7C60         ; OLine=4077
                 EOR      #$FF             ; OLine=4078
                 STA      5                ; OLine=4079
                 LDA      4                ; OLine=4080
                 EOR      #$FF             ; OLine=4081
                 ADC      #0               ; OLine=4082
                 STA      4                ; OLine=4083
                 BCC      loc_7C5F         ; OLine=4084
                 INC      5                ; OLine=4085
                                           
loc_7C5F:                                  ; OLine=4087
                 SEC                       ; OLine=4088
                                           
loc_7C60:                                  ; OLine=4090
                 ROL      8                ; OLine=4091
                 LDA      7                ; OLine=4092
                 CMP      #$80             ; OLine=4093
                 BCC      loc_7C79         ; OLine=4094
                 EOR      #$FF             ; OLine=4095
                 STA      7                ; OLine=4096
                 LDA      6                ; OLine=4097
                 EOR      #$FF             ; OLine=4098
                 ADC      #0               ; OLine=4099
                 STA      6                ; OLine=4100
                 BCC      loc_7C78         ; OLine=4101
                 INC      7                ; OLine=4102
                                           
loc_7C78:                                  ; OLine=4104
                 SEC                       ; OLine=4105
                                           
loc_7C79:                                  ; OLine=4107
                 ROL      8                ; OLine=4108
                 LDA      5                ; OLine=4109
                 ORA      7                ; OLine=4110
                 BEQ      loc_7C8B         ; OLine=4111
                 LDX      #0               ; OLine=4112
                 CMP      #2               ; OLine=4113
                 BCS      loc_7CAB         ; OLine=4114
                 LDY      #1               ; OLine=4115
                 BNE      loc_7C9B         ; OLine=4116
                                           
loc_7C8B:                                  ; OLine=4118
                 LDY      #2               ; OLine=4119
                 LDX      #9               ; OLine=4120
                 LDA      4                ; OLine=4121
                 ORA      6                ; OLine=4122
                 BEQ      loc_7CAB         ; OLine=4123
                 BMI      loc_7C9B         ; OLine=4124
                                           
loc_7C97:                                  ; OLine=4126
                 INY                       ; OLine=4127
                 ASL      A                ; OLine=4128
                 BPL      loc_7C97         ; OLine=4129
                                           
loc_7C9B:                                  ; OLine=4131
                                           
                 TYA                       ; OLine=4133
                 TAX                       ; OLine=4134
                 LDA      5                ; OLine=4135
                                           
loc_7C9F:                                  ; OLine=4137
                 ASL      4                ; OLine=4138
                 ROL      A                ; OLine=4139
                 ASL      6                ; OLine=4140
                 ROL      7                ; OLine=4141
                 DEY                       ; OLine=4142
                 BNE      loc_7C9F         ; OLine=4143
                 STA      5                ; OLine=4144
                                           
loc_7CAB:                                  ; OLine=4146
                                           
                 TXA                       ; OLine=4148
                 SEC                       ; OLine=4149
                 SBC      #$A              ; OLine=4150
                 EOR      #$FF             ; OLine=4151
                 ASL      A                ; OLine=4152
                 ROR      8                ; OLine=4153
                 ROL      A                ; OLine=4154
                 ROR      8                ; OLine=4155
                 ROL      A                ; OLine=4156
                 ASL      A                ; OLine=4157
                 STA      8                ; OLine=4158
                 LDY      #0               ; OLine=4159
                 LDA      6                ; OLine=4160
                 STA      (2),Y            ; OLine=4161
                 LDA      8                ; OLine=4162
                 AND      #$F4             ; OLine=4163
                 ORA      7                ; OLine=4164
                 INY                       ; OLine=4165
                 STA      (2),Y            ; OLine=4166
                 LDA      4                ; OLine=4167
                 INY                       ; OLine=4168
                 STA      (2),Y            ; OLine=4169
                 LDA      8                ; OLine=4170
                 AND      #2               ; OLine=4171
                 ASL      A                ; OLine=4172
                 ORA      1                ; OLine=4173
                 ORA      5                ; OLine=4174
                 INY                       ; OLine=4175
                 STA      (2),Y            ; OLine=4176
                 JMP      sub_7C39         ; OLine=4177
                                           ;  End of function sub_7C49
                                           
                                           
                                           ;  ¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦ S U B R O U T I N E ¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦
                                           
                                           
sub_7CDE:                                  ; OLine=4184
                                           
                 LDX      #0               ; OLine=4186
                                           ;  End of function sub_7CDE
                                           
                                           
                                           ;  ¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦ S U B R O U T I N E ¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦
                                           
                                           
sub_7CE0:                                  ; OLine=4193
                                           
                 LDY      #1               ; OLine=4195
                 STA      (2),Y            ; OLine=4196
                 DEY                       ; OLine=4197
                 TYA                       ; OLine=4198
                 STA      (2),Y            ; OLine=4199
                 INY                       ; OLine=4200
                 INY                       ; OLine=4201
                 STA      (2),Y            ; OLine=4202
                 INY                       ; OLine=4203
                 TXA                       ; OLine=4204
                 STA      (2),Y            ; OLine=4205
                 JMP      sub_7C39         ; OLine=4206
                                           ;  End of function sub_7CE0
                                           
                                           ;  ---------------------------------------------------------------------------
                                           
                                           ; <EditorTab name="main">
main:                                      ; OLine=4212
                 LDX      #$FE             ; OLine=4213
                 TXS                       ; OLine=4214
                 CLD                       ; OLine=4215
                 LDA      #0               ; OLine=4216
                 TAX                       ; OLine=4217
                                           
loc_7CFA:                                  ; OLine=4219
                 DEX                       ; OLine=4220
                 STA      $300,X           ; OLine=4221
                 STA      $200,X           ; OLine=4222
                 STA      $100,X           ; OLine=4223
                 STA      0,X              ; OLine=4224
                 BNE      loc_7CFA         ; OLine=4225 
                 LDY      $2007            ; OLine=4226  Self test switch
                 BMI      loc_7D50         ; OLine=4227
                 INX                       ; OLine=4228
                 STX      $4000            ; OLine=4229
                 LDA      #$E2             ; OLine=4230
                 STA      $4001            ; OLine=4231
                 LDA      #$B0             ; OLine=4232
                 STA      $4003            ; OLine=4233
                 STA      $32              ; OLine=4234
                 STA      $33              ; OLine=4235
                 LDA      #3               ; OLine=4236
                 STA      $6F              ; OLine=4237
                 STA      $3200            ; OLine=4238
                 AND      $2800            ; OLine=4239  DIP switches 8 & 7: # Of Coins For Play
                 STA      $71              ; OLine=4240
                 LDA      $2801            ; OLine=4241  DIP switches 6 & 5: Coin Multiplier, Right Slot
                 AND      #3               ; OLine=4242
                 ASL      A                ; OLine=4243
                 ASL      A                ; OLine=4244
                 ORA      $71              ; OLine=4245
                 STA      $71              ; OLine=4246
                 LDA      $2802            ; OLine=4247  DIP switches 4 & 3: 3 - # Of Starting Ships
                 AND      #2               ; OLine=4248  4 - Coin Multiplier Center/Left Slot
                 ASL      A                ; OLine=4249
                 ASL      A                ; OLine=4250
                 ASL      A                ; OLine=4251
                 ORA      $71              ; OLine=4252
                 STA      $71              ; OLine=4253
                 JMP      loc_6803         ; OLine=4254
                                           ; </EditorTab>
                                           
                                           ;  ¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦ S U B R O U T I N E ¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦
                                           
                                           
sub_7D45:                                  ; OLine=4260
                                           
                 LDY      #0               ; OLine=4262
                 STA      (2),Y            ; OLine=4263
                 INY                       ; OLine=4264
                 TXA                       ; OLine=4265
                 STA      (2),Y            ; OLine=4266
                 JMP      sub_7C39         ; OLine=4267
                                           ;  End of function sub_7D45
                                           
                                           ;  ---------------------------------------------------------------------------
                                           
loc_7D50:                                  ; OLine=4272
                                           
                 STA      $4000,X          ; OLine=4274
                 STA      $4100,X          ; OLine=4275
                 STA      $4200,X          ; OLine=4276
                 STA      $4300,X          ; OLine=4277
                 STA      $4400,X          ; OLine=4278
                 STA      $4500,X          ; OLine=4279
                 STA      $4600,X          ; OLine=4280
                 STA      $4700,X          ; OLine=4281
                 INX                       ; OLine=4282
                 BNE      loc_7D50         ; OLine=4283
                 STA      $3400            ; OLine=4284
                 LDX      #0               ; OLine=4285
                                           
loc_7D70:                                  ; OLine=4287
                 LDA      0,X              ; OLine=4288
                 BNE      loc_7DBB         ; OLine=4289
                 LDA      #$11             ; OLine=4290
                                           
loc_7D76:                                  ; OLine=4292
                 STA      0,X              ; OLine=4293
                 TAY                       ; OLine=4294
                 EOR      0,X              ; OLine=4295
                 BNE      loc_7DBB         ; OLine=4296
                 TYA                       ; OLine=4297
                 ASL      A                ; OLine=4298
                 BCC      loc_7D76         ; OLine=4299
                 INX                       ; OLine=4300
                 BNE      loc_7D70         ; OLine=4301
                 STA      $3400            ; OLine=4302
                 TXA                       ; OLine=4303
                 STA      0                ; OLine=4304
                 ROL      A                ; OLine=4305
                                           
loc_7D8B:                                  ; OLine=4307
                 STA      1                ; OLine=4308
                 LDY      #0               ; OLine=4309
                                           
loc_7D8F:                                  ; OLine=4311
                                           
                 LDX      #$11             ; OLine=4313
                 LDA      (0),Y            ; OLine=4314
                 BNE      loc_7DBF         ; OLine=4315
                                           
loc_7D95:                                  ; OLine=4317
                 TXA                       ; OLine=4318
                 STA      (0),Y            ; OLine=4319
                 EOR      (0),Y            ; OLine=4320
                 BNE      loc_7DBF         ; OLine=4321
                 TXA                       ; OLine=4322
                 ASL      A                ; OLine=4323
                 TAX                       ; OLine=4324
                 BCC      loc_7D95         ; OLine=4325
                 INY                       ; OLine=4326
                 BNE      loc_7D8F         ; OLine=4327
                 STA      $3400            ; OLine=4328
                 INC      1                ; OLine=4329
                 LDX      1                ; OLine=4330
                 CPX      #4               ; OLine=4331
                 BCC      loc_7D8F         ; OLine=4332
                 LDA      #$40             ; OLine=4333
                 CPX      #$40             ; OLine=4334
                 BCC      loc_7D8B         ; OLine=4335
                 CPX      #$48             ; OLine=4336
                 BCC      loc_7D8F         ; OLine=4337
                 BCS      loc_7E24         ; OLine=4338
                                           
loc_7DBB:                                  ; OLine=4340
                                           
                 LDY      #0               ; OLine=4342
                 BEQ      loc_7DCD         ; OLine=4343
                                           
loc_7DBF:                                  ; OLine=4345
                                           
                 LDY      #0               ; OLine=4347
                 LDX      1                ; OLine=4348
                 CPX      #4               ; OLine=4349
                 BCC      loc_7DCD         ; OLine=4350
                 INY                       ; OLine=4351
                 CPX      #$44             ; OLine=4352
                 BCC      loc_7DCD         ; OLine=4353
                 INY                       ; OLine=4354
                                           
loc_7DCD:                                  ; OLine=4356
                                           
                 CMP      #$10             ; OLine=4358
                 ROL      A                ; OLine=4359
                 AND      #$1F             ; OLine=4360
                 CMP      #2               ; OLine=4361
                 ROL      A                ; OLine=4362
                 AND      #3               ; OLine=4363
                                           
loc_7DD7:                                  ; OLine=4365
                 DEY                       ; OLine=4366
                 BMI      loc_7DDE         ; OLine=4367
                 ASL      A                ; OLine=4368
                 ASL      A                ; OLine=4369
                 BCC      loc_7DD7         ; OLine=4370
                                           
loc_7DDE:                                  ; OLine=4372
                                           
                 LSR      A                ; OLine=4374
                 LDX      #$14             ; OLine=4375
                 BCC      loc_7DE5         ; OLine=4376
                 LDX      #$1D             ; OLine=4377
                                           
loc_7DE5:                                  ; OLine=4379
                 STX      $3A00            ; OLine=4380
                 LDX      #0               ; OLine=4381
                 LDY      #8               ; OLine=4382
                                           
loc_7DEC:                                  ; OLine=4384
                                           
                 BIT      $2001            ; OLine=4386
                 BPL      loc_7DEC         ; OLine=4387
                                           
loc_7DF1:                                  ; OLine=4389
                 BIT      $2001            ; OLine=4390
                 BMI      loc_7DF1         ; OLine=4391
                 DEX                       ; OLine=4392
                 STA      $3400            ; OLine=4393
                 BNE      loc_7DEC         ; OLine=4394
                 DEY                       ; OLine=4395
                 BNE      loc_7DEC         ; OLine=4396
                 STX      $3A00            ; OLine=4397
                 LDY      #8               ; OLine=4398
                                           
loc_7E04:                                  ; OLine=4400
                                           
                 BIT      $2001            ; OLine=4402
                 BPL      loc_7E04         ; OLine=4403
                                           
loc_7E09:                                  ; OLine=4405
                 BIT      $2001            ; OLine=4406
                 BMI      loc_7E09         ; OLine=4407
                 DEX                       ; OLine=4408
                 STA      $3400            ; OLine=4409
                 BNE      loc_7E04         ; OLine=4410
                 DEY                       ; OLine=4411
                 BNE      loc_7E04         ; OLine=4412
                 TAX                       ; OLine=4413
                 BNE      loc_7DDE         ; OLine=4414
                                           
loc_7E1A:                                  ; OLine=4416
                 STA      $3400            ; OLine=4417
                 LDA      $2007            ; OLine=4418
                 BMI      loc_7E1A         ; OLine=4419
                                           
loc_7E22:                                  ; OLine=4421
                 BPL      loc_7E22         ; OLine=4422
                                           
loc_7E24:                                  ; OLine=4424
                 LDA      #0               ; OLine=4425
                 TAY                       ; OLine=4426
                 TAX                       ; OLine=4427
                 STA      8                ; OLine=4428
                 LDA      #$50             ; OLine=4429
                                           
loc_7E2C:                                  ; OLine=4431
                                           
                 STA      9                ; OLine=4433
                 LDA      #4               ; OLine=4434
                 STA      $B               ; OLine=4435
                 LDA      #$FF             ; OLine=4436
                                           
loc_7E34:                                  ; OLine=4438
                                           
                 EOR      (8),Y            ; OLine=4440
                 INY                       ; OLine=4441
                 BNE      loc_7E34         ; OLine=4442
                 INC      9                ; OLine=4443
                 DEC      $B               ; OLine=4444
                 BNE      loc_7E34         ; OLine=4445
                 STA      $D,X             ; OLine=4446
                 INX                       ; OLine=4447
                 STA      $3400            ; OLine=4448
                 LDA      9                ; OLine=4449
                 CMP      #$58             ; OLine=4450
                 BCC      loc_7E2C         ; OLine=4451
                 BNE      loc_7E4F         ; OLine=4452
                 LDA      #$68             ; OLine=4453
                                           
loc_7E4F:                                  ; OLine=4455
                 CMP      #$80             ; OLine=4456
                 BCC      loc_7E2C         ; OLine=4457
                 STA      $300             ; OLine=4458
                 LDX      #4               ; OLine=4459
                 STX      $3200            ; OLine=4460
                 STX      $15              ; OLine=4461
                 LDX      #0               ; OLine=4462
                 CMP      $200             ; OLine=4463
                 BEQ      loc_7E65         ; OLine=4464
                 INX                       ; OLine=4465
                                           
loc_7E65:                                  ; OLine=4467
                 LDA      $300             ; OLine=4468
                 CMP      #$88             ; OLine=4469
                 BEQ      loc_7E6D         ; OLine=4470
                 INX                       ; OLine=4471
                                           
loc_7E6D:                                  ; OLine=4473
                 STX      $16              ; OLine=4474
                 LDA      #$10             ; OLine=4475
                 STA      0                ; OLine=4476
                                           
loc_7E73:                                  ; OLine=4478
                 LDX      #$24             ; OLine=4479
                                           
loc_7E75:                                  ; OLine=4481
                                           
                 LDA      $2001            ; OLine=4483
                 BPL      loc_7E75         ; OLine=4484
                                           
loc_7E7A:                                  ; OLine=4486
                 LDA      $2001            ; OLine=4487
                 BMI      loc_7E7A         ; OLine=4488
                 DEX                       ; OLine=4489
                 BPL      loc_7E75         ; OLine=4490
                                           
loc_7E82:                                  ; OLine=4492
                 BIT      $2002            ; OLine=4493
                 BMI      loc_7E82         ; OLine=4494
                 STA      $3400            ; OLine=4495
                 LDA      #0               ; OLine=4496
                 STA      2                ; OLine=4497
                 LDA      #$40             ; OLine=4498
                 STA      3                ; OLine=4499
                 LDA      $2005            ; OLine=4500
                 BPL      loc_7EF2         ; OLine=4501
                 LDX      $15              ; OLine=4502
                 LDA      $2003            ; OLine=4503
                 BPL      loc_7EA8         ; OLine=4504
                                           ; EOR     $0009
                 .BYTE    $4D,$09,$00      ; OLine=4506
                 BPL      loc_7EA8         ; OLine=4507
                 DEX                       ; OLine=4508
                 BEQ      loc_7EA8         ; OLine=4509
                 STX      $15              ; OLine=4510
                                           
loc_7EA8:                                  ; OLine=4512
                                           
                 LDY      $7EBB,X          ; OLine=4514
                 LDA      #$B0             ; OLine=4515
                 STA      (2),Y            ; OLine=4516
                 DEY                       ; OLine=4517
                 DEY                       ; OLine=4518
                                           
loc_7EB1:                                  ; OLine=4520
                 LDA      $7EC0,Y          ; OLine=4521
                 STA      (2),Y            ; OLine=4522
                 DEY                       ; OLine=4523
                 BPL      loc_7EB1         ; OLine=4524
                 JMP      loc_7F9D         ; OLine=4525
                                           ;  ---------------------------------------------------------------------------
                 .BYTE    $33              ; OLine=4527
                 .BYTE    $1D              ; OLine=4528
                 .BYTE    $17              ; OLine=4529
                 .BYTE    $D               ; OLine=4530
                 .BYTE    $80              ; OLine=4531
                 .BYTE    $A0              ; OLine=4532
                 .BYTE    0                ; OLine=4533
                 .BYTE    0                ; OLine=4534
                 .BYTE    0                ; OLine=4535
                 .BYTE    $70              ; OLine=4536
                 .BYTE    0                ; OLine=4537
                 .BYTE    0                ; OLine=4538
                 .BYTE    $FF              ; OLine=4539
                 .BYTE    $92              ; OLine=4540
                 .BYTE    $FF              ; OLine=4541
                 .BYTE    $73              ; OLine=4542
                 .BYTE    $D0              ; OLine=4543
                 .BYTE    $A1              ; OLine=4544
                 .BYTE    $30              ; OLine=4545
                 .BYTE    2                ; OLine=4546
                 .BYTE    0                ; OLine=4547
                 .BYTE    $70              ; OLine=4548
                 .BYTE    0                ; OLine=4549
                 .BYTE    0                ; OLine=4550
                 .BYTE    $7F              ; OLine=4551
                 .BYTE    $FB              ; OLine=4552
                 .BYTE    $D               ; OLine=4553
                 .BYTE    $E0              ; OLine=4554
                 .BYTE    0                ; OLine=4555
                 .BYTE    $B0              ; OLine=4556
                 .BYTE    $7E              ; OLine=4557
                 .BYTE    $FA              ; OLine=4558
                 .BYTE    $11              ; OLine=4559
                 .BYTE    $C0              ; OLine=4560
                 .BYTE    $78              ; OLine=4561
                 .BYTE    $FE              ; OLine=4562
                 .BYTE    0                ; OLine=4563
                 .BYTE    $B0              ; OLine=4564
                 .BYTE    $13              ; OLine=4565
                 .BYTE    $C0              ; OLine=4566
                 .BYTE    0                ; OLine=4567
                 .BYTE    $D0              ; OLine=4568
                 .BYTE    $15              ; OLine=4569
                 .BYTE    $C0              ; OLine=4570
                 .BYTE    0                ; OLine=4571
                 .BYTE    $D0              ; OLine=4572
                 .BYTE    $17              ; OLine=4573
                 .BYTE    $C0              ; OLine=4574
                 .BYTE    0                ; OLine=4575
                 .BYTE    $D0              ; OLine=4576
                 .BYTE    $7A              ; OLine=4577
                 .BYTE    $F8              ; OLine=4578
                 .BYTE    0                ; OLine=4579
                 .BYTE    $D0              ; OLine=4580
                                           ;  ---------------------------------------------------------------------------
                                           
loc_7EF2:                                  ; OLine=4583
                 LDA      #$50             ; OLine=4584
                 LDX      #0               ; OLine=4585
                 JSR      sub_7BFC         ; OLine=4586
                 LDA      #$69             ; OLine=4587
                 LDX      #$93             ; OLine=4588
                 JSR      sub_7C03         ; OLine=4589
                 LDA      #$30             ; OLine=4590
                 JSR      sub_7CDE         ; OLine=4591
                 LDX      #3               ; OLine=4592
                                           
loc_7F07:                                  ; OLine=4594
                 LDA      $2800,X          ; OLine=4595
                 AND      #1               ; OLine=4596
                 STX      $B               ; OLine=4597
                 JSR      sub_7BD1         ; OLine=4598
                 LDX      $B               ; OLine=4599
                 LDA      $2800,X          ; OLine=4600
                 AND      #2               ; OLine=4601
                 LSR      A                ; OLine=4602
                 JSR      sub_7BD1         ; OLine=4603
                 LDX      $B               ; OLine=4604
                 DEX                       ; OLine=4605
                 BPL      loc_7F07         ; OLine=4606
                 LDA      #$7A             ; OLine=4607
                 LDX      #$9D             ; OLine=4608
                 JSR      sub_7C03         ; OLine=4609
                 LDA      #$10             ; OLine=4610
                 JSR      sub_7CDE         ; OLine=4611
                 LDA      $2802            ; OLine=4612
                 AND      #2               ; OLine=4613
                 LSR      A                ; OLine=4614
                 ADC      #1               ; OLine=4615
                 JSR      sub_7BD1         ; OLine=4616
                 LDA      $2801            ; OLine=4617
                 AND      #3               ; OLine=4618
                 TAX                       ; OLine=4619
                 LDA      $7FF5,X          ; OLine=4620
                 JSR      sub_7BD1         ; OLine=4621
                 LDA      $16              ; OLine=4622
                 BEQ      loc_7F4F         ; OLine=4623
                 LDX      #$88             ; OLine=4624
                 LDA      #$50             ; OLine=4625
                 JSR      sub_7BFC         ; OLine=4626
                                           
loc_7F4F:                                  ; OLine=4628
                 LDX      #$96             ; OLine=4629
                                           ;  STX     $C
                 .byte    $8E,$C,$00       ; OLine=4631
                 LDX      #7               ; OLine=4632
                                           
loc_7F56:                                  ; OLine=4634
                 LDA      $D,X             ; OLine=4635
                 BEQ      loc_7F91         ; OLine=4636
                 PHA                       ; OLine=4637
                                           ; STX     $B
                 .byte    $8E,$B,$00       ; OLine=4639
                                           ; LDX     $C
                 .byte    $AE,$C,$00       ; OLine=4641
                 TXA                       ; OLine=4642
                 SEC                       ; OLine=4643
                 SBC      #8               ; OLine=4644
                                           ; STA     $C
                 .byte    $8D,$0C,$00      ; OLine=4646
                 LDA      #$20             ; OLine=4647
                 JSR      sub_7C03         ; OLine=4648
                 LDA      #$70             ; OLine=4649
                 JSR      sub_7CDE         ; OLine=4650
                                           ; LDA     $B
                 .byte    $AD,$0B,$00      ; OLine=4652
                 JSR      sub_7BD1         ; OLine=4653
                 LDA      $56D4            ; OLine=4654
                 LDX      $56D5            ; OLine=4655
                 JSR      sub_7D45         ; OLine=4656
                 PLA                       ; OLine=4657
                 PHA                       ; OLine=4658
                 LSR      A                ; OLine=4659
                 LSR      A                ; OLine=4660
                 LSR      A                ; OLine=4661
                 LSR      A                ; OLine=4662
                 JSR      sub_7BD1         ; OLine=4663
                 PLA                       ; OLine=4664
                 JSR      sub_7BD1         ; OLine=4665
                                           ; LDX     $B
                 .byte    $AE,$0B,$ 00     ; OLine=4667
                                           
loc_7F91:                                  ; OLine=4669
                 DEX                       ; OLine=4670
                 BPL      loc_7F56         ; OLine=4671
                 LDA      #$7F             ; OLine=4672
                 TAX                       ; OLine=4673
                 JSR      sub_7C03         ; OLine=4674
                 JSR      sub_7BC0         ; OLine=4675
                                           
loc_7F9D:                                  ; OLine=4677
                 LDA      #0               ; OLine=4678
                 LDX      #4               ; OLine=4679
                                           
loc_7FA1:                                  ; OLine=4681
                 ROL      $2003,X          ; OLine=4682
                 ROR      A                ; OLine=4683
                 DEX                       ; OLine=4684
                 BPL      loc_7FA1         ; OLine=4685
                 TAY                       ; OLine=4686
                 LDX      #7               ; OLine=4687
                                           
loc_7FAB:                                  ; OLine=4689
                 ROL      $2400,X          ; OLine=4690
                 ROL      A                ; OLine=4691
                 DEX                       ; OLine=4692
                 BPL      loc_7FAB         ; OLine=4693
                 TAX                       ; OLine=4694
                 EOR      8                ; OLine=4695
                 STX      8                ; OLine=4696
                 PHP                       ; OLine=4697
                 LDA      #4               ; OLine=4698
                 STA      $3200            ; OLine=4699
                 ROL      $2003            ; OLine=4700
                 ROL      A                ; OLine=4701
                 ROL      $2004            ; OLine=4702
                 ROL      A                ; OLine=4703
                 ROL      $2407            ; OLine=4704
                 ROL      A                ; OLine=4705
                 ROL      $2406            ; OLine=4706
                 ROL      A                ; OLine=4707
                 ROL      $2405            ; OLine=4708
                 ROL      A                ; OLine=4709
                 TAX                       ; OLine=4710
                 PLP                       ; OLine=4711
                 BNE      loc_7FDE         ; OLine=4712
                 EOR      $A               ; OLine=4713
                 BNE      loc_7FDE         ; OLine=4714
                 TYA                       ; OLine=4715
                 EOR      9                ; OLine=4716
                 BEQ      loc_7FE0         ; OLine=4717
                                           
loc_7FDE:                                  ; OLine=4719
                                           
                 LDA      #$80             ; OLine=4721
                                           
loc_7FE0:                                  ; OLine=4723
                 STA      $3C05            ; OLine=4724
                 STA      $3200            ; OLine=4725
                 STA      $3000            ; OLine=4726
                 STX      $A               ; OLine=4727
                 STY      9                ; OLine=4728
                 LDA      $2007            ; OLine=4729
                                           
loc_7FF0:                                  ; OLine=4731
                 BPL      loc_7FF0         ; OLine=4732
                 JMP      loc_7E73         ; OLine=4733
                                           ;  ---------------------------------------------------------------------------
                 .BYTE    1                ; OLine=4735
                 .BYTE    4                ; OLine=4736
                 .BYTE    5                ; OLine=4737
                 .BYTE    6                ; OLine=4738
                 .BYTE    $4E              ; OLine=4739
                                           
                 .BYTE    $65              ; OLine=4741  NMI
                 .BYTE    $7B              ; OLine=4742
                                           
                 .WORD    main             ; OLine=4744  RESET
                                           
                 .BYTE    $F3              ; OLine=4746  IRQ
                 .BYTE    $7C              ; OLine=4747
                                           ;  end of 'ROM'
                                           
                 .END                      ; OLine=4750
                                           
