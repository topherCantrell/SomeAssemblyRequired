
processor 6502

;<EditorTab name="BUILD">
; *** Complie the assembly
; build-command java Blend Asteroids.asm AstoidsBLEND.asm
; build-command tasm -b -65 AsteroidsBLEND.asm Asteroids.bin

; *** Split the resulting binary into the 3 EPROMs needed by MAME
; build-command java EpromTool -split Asteroids.bin 035145.02 035144.02 035143.02

; *** Copy results to the MAME directory for running
; build-command jar -cfM c:\mame\roms\asteroid.zip *.02

;</EditorTab>


; NOTE: This code is property of Atari Inc. All requests from said company to remove
; This code from public display will be honored
; Disassembly By Lonnie Howell     displacer1@excite.com
; Updated 10/8/04

;<EditorTab name="RAM">
; Memory map:
; $18              Current Player (0 = Player 1, 1 = Player 2)
; $1C              Number Of Players In Current Game
; $1D - $30        High Score Table (Scores) 2 Byte Format In Decimal
;                  Byte 1 Tens, Byte 2 Thousands (In Decimal)
; $34 - $51        High Score Table (Initials) 3 Byte Format
; $52              Player 1 Score Tens (In Decimal)
; $53              Player 1 Score Thousands (In Decimal)
; $54              Player 2 Score Tens (In Decimal)
; $55              Player 2 Score Thousands (In Decimal)
; $56              Number Of Starting Ships Per Game
; $57              Current Number Of Ships, Player 1
; $58              Current Number Of Ships, Player 2
; $59              Hyperspace Flag: 1 = Successful Hyperspace Jump
;                                   #$80 = Unsuccessful Hyperspace Jump (DEATH)
;                                   0 = Hyperspace Not Currently Active
; $5C              Fast Timer
; $5D              Slow Timer
; $61              Ship Direction
; $62              Direction Shot Is Fired From Saucer (?)
; $68              TIMER: Length Of Time To Play Bonus Ship Sound
; $6A              Fire Sound Flag For Player
; $6B              Fire Sound Flag For Saucer
; $6C              Current Volume & Frequency Settings For THUMP Sound
; $6D              TIMER: Time THUMP Sound Remains On
; $6E              TIMER: Time THUMP Sound Remains Off (Speeds Up As Game Progresses)
; $6F              Bitmap Of Changes To Be Made In $3200
; $70              Current Number Of Credits
; $71              Bitmap Of DIP Switches 4-8
; $72              Slam Switch Flag
; $73              Total Coins (After Multiplyers) To Be Converted To Credits

; $0100 - $01FF    Stack Space

; $021B            Player Flag, 1 = Player Alive And Active, #$A0+ = Player Currently Exploding
; $021C            Saucer Flag, 0 = No Saucer, 1 = Small Saucer, 2 = Large Saucer
; $021D - $021E    Countdown Timers For Saucer Shots
; $021F - $0222    Countdown Timers For Ship Shots
; $02F7            Countdown Timer For Saucer, At 0, Saucer Appears
;                  Possibly A Dual Purpous Timer
; $02F8            Starting Value For Timer @ $02F7
; $02FC            Starting Value For Timer @ $6E
; $0200 - 02FF     Player 1 RAM
; $0300 - 03FF     Player 2 RAM

;</EditorTab>

;<EditorTab name="Hardware">

; $2001            3 KHz
; $2002            HALT
; $2003            Hyperspace Switch
; $2004            Fire Switch
; $2005            Diag. Step
; $2006            Slam Switch
; $2007            Self Test Switch

; $2400            Left Coin Switch
; $2401            Center Coin Switch
; $2402            Right Coin Switch
; $2403            1 Player Start Switch
; $2404            2 Player Start Switch
; $2405            Thrust Switch
; $2406            Rotate Right Switch
; $2407            Rotate Left Switch

; $3200            Bit 1 = 2 Player Start Lamp
;                  Bit 2 = 1 Player Start Lamp
;                  Bit 3 = RAMSEL
;                  Bit 4 = Left Coin Counter
;                  Bit 5 = Center Coin Counter
;                  Bit 6 = Right Coin Counter
;</EditorTab>



                .ORG    $6800
                JMP     main
  
loc_6803:

                JSR     sub_6EFA          ; Reset Sound, Zero Out Sound Timers
                JSR     sub_6ED8          ; Number Of Starting Ships To $56 And Zero
                                          ; Out Players Scores *BUG*
loc_6809:
                JSR     sub_7168          ;
  
loc_680C:

                LDA     $2007             ; Self test switch
  
loc_680F:
                BMI     loc_680F          ; Branch If Switch Is On
                LSR     $5B               ;
                BCC     loc_680C          ;
  
loc_6815:
                LDA     $2002             ; HALT
                BMI     loc_6815          ; Wait For State Machine To Finish
                LDA     $4001             ;
                EOR     #2                ;
                STA     $4001             ;
                STA     $3000             ; DMAGO
                STA     $3400             ; Reset WatchDog
                INC     $5C               ; Update Fast Timer
                BNE     loc_682E          ;
                INC     $5D               ; Update Slow Timer
  
loc_682E:
                LDX     #$40              ;
                AND     #2                ;
                BNE     loc_6836          ;
                LDX     #$44              ;
  
loc_6836:
                LDA     #2                ;
                STA     2                 ;
                STX     3                 ;
                JSR     sub_6885          ;
                BCS     loc_6803          ;
                JSR     sub_765C          ;
                JSR     sub_6D90          ;
                BPL     loc_6864          ;
                JSR     sub_73C4          ;
                BCS     loc_6864          ;
                LDA     $5A               ;
                BNE     loc_685E          ;
                JSR     sub_6CD7          ;
                JSR     sub_6E74          ;
                JSR     sub_703F          ;
                JSR     sub_6B93          ;
  
loc_685E:
                JSR     sub_6F57          ;
                JSR     sub_69F0          ;
  
loc_6864:

                JSR     sub_724F          ;
                JSR     sub_7555          ;
                LDA     #$7F              ;
                TAX                       ;
                JSR     sub_7C03          ;
                JSR     sub_77B5          ;
                JSR     sub_7BC0          ;
                LDA     $2FB              ;
                BEQ     loc_687E          ;
                DEC     $2FB              ;
  
loc_687E:
                ORA     $2F6              ;
                BNE     loc_680C          ;
                BEQ     loc_6809          ;
  
; ¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦ S U B R O U T I N E ¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦
  
  
sub_6885:
                LDA     $1C               ; Number Of Players In Current Game
                BEQ     loc_689D          ; None, Branch
                LDA     $5A               ;
                BNE     loc_6890          ;
                JMP     loc_6960          ;
; ---------------------------------------------------------------------------
  
loc_6890:
                DEC     $5A               ;
                JSR     sub_69E2          ;
  
loc_6895:
                CLC                       ;
                RTS                       ;
; ---------------------------------------------------------------------------
  
loc_6897:
                LDA     #2                ; Free Credits!
                STA     $70               ; Can Only Play A 2 Player Game, So Only Need To Add 2
                BNE     loc_68B0          ; Credits For Free Play
  
loc_689D:
                LDA     $71               ; DIP Switch Settings Bitmap
                AND     #3                ; Mask Off Settings For Switches 8 & 7
                BEQ     loc_6897          ; Check For Free Play, Branch If Yes
                CLC                       ;
                ADC     #7                ; Determine Which Message To Display Based On DIP Settings
                TAY                       ; Into Y For The Offset
                                          ; Y = 8, "1 COIN 2 PLAYS"
                                          ; Y = 9, "1 COIN 1 PLAY"
                                          ; Y = A, "2 COINS 1 PLAY"
                LDA     $32               ;
                AND     $33               ;
                BPL     loc_68B0          ;
                JSR     sub_77F6          ; And Draw It To Screen
  
loc_68B0:

                LDY     $70               ; Current Number Of Credits
                BEQ     loc_6895          ; No Credits, Branch
                LDX     #1                ; Assume 1 Player Game 
                LDA     $2403             ; 1 Player start button
                BMI     loc_68DE          ; Branch If Pressed
                CPY     #2                ; Enough Credits For A 2 Player Game?
                BCC     loc_693B          ; No, Branch
                LDA     $2404             ; 2 Player start button
                BPL     loc_693B          ; Branch if NOT pressed
                LDA     $6F               ; $3200 Bitmap
                ORA     #4                ; Set Bit 3, RAMSEL (Swap In $0200 Memory)
                STA     $6F               ; Update Bitmap
                STA     $3200             ; And Make The Change
                JSR     sub_6ED8          ;
                JSR     sub_7168          ;
                JSR     sub_71E8          ;
                LDA     $56               ; Number Of Starting Ships
                STA     $58               ; To Player 2 Current Ships
                LDX     #2                ; 2 Player Game
                DEC     $70               ; Subtract Credit
  
loc_68DE:
                STX     $1C               ; Flag Number Of Players In Current Game
                DEC     $70               ; Subtract Credit
                LDA     $6F               ; $3200 Bitmap
                AND     #$F8              ;
                EOR     $1C               ; Change Player Start Lamps For This Game
                STA     $6F               ; Update Bitmap
                STA     $3200             ; And Make The Change
                JSR     sub_71E8          ;
                LDA     #1                ;
                STA     $2FA              ;
                STA     $3FA              ;
                LDA     #$92              ;
                STA     $2F8              ;
                STA     $3F8              ;
                STA     $3F7              ;
                STA     $2F7              ; Countdown Timer For When Saucer Appears
                LDA     #$7F              ;
                STA     $2FB              ;
                STA     $3FB              ;
                LDA     #5                ;
                STA     $2FD              ;
                STA     $3FD              ;
                LDA     #$FF              ;
                STA     $32               ;
                STA     $33               ;
                LDA     #$80              ;
                STA     $5A               ;
                ASL     A                 ; Zero A, And Set Carry Flag
                STA     $18               ; Current Player. New Game So Start With Player 1
                STA     $19               ;
                LDA     $56               ;
                STA     $57               ;
                LDA     #4                ;
                STA     $6C               ;
                STA     $6E               ;
                LDA     #$30              ;
                STA     $2FC              ; Starting Value For Timer @ $6E
                STA     $3FC              ;
                STA     $3E00             ;
                RTS                       ; Noise Reset
; ---------------------------------------------------------------------------
  
loc_693B:

                LDA     $32               ;
                AND     $32               ;
                BPL     loc_694C          ;
                LDA     $5C               ; Fast Timer
                AND     #$20              ; Time To Draw Message To Screen?
                BNE     loc_694C          ; No, Branch
                LDY     #6                ; Offset For "PUSH START"
                JSR     sub_77F6          ; And Draw It On Screen
  
loc_694C:

                LDA     $5C               ; Fast Timer
                AND     #$F               ; Time To Blink Player Start Lamp(s)?
                BNE     loc_695E          ; No, Branch
                LDA     #1                ;
                CMP     $70               ; Current Number Of Credits
                ADC     #1                ; Calculate Which Lamp(s) To Blink
                EOR     #1                ;
                EOR     $6F               ; Switch Their Status (On Or Off)
                STA     $6F               ; Update Bitmap
  
loc_695E:
                CLC                       ;
                RTS                       ;
; ---------------------------------------------------------------------------
  
loc_6960:
                LDA     $5C               ; Fast Timer
                AND     #$3F              ;
                BNE     loc_6970          ;
                LDA     $2FC              ; Starting Value For Timer @ $6E
                CMP     #8                ; At The Lowest Value It Can Be?
                BEQ     loc_6970          ; Yes, Branch
                DEC     $2FC              ;
  
loc_6970:

                LDX     $18               ; Current Player
                LDA     $57,X             ; Number Of Ships For Current Player
                BNE     loc_6992          ; Any Ships Left? Branch If Yes
                LDA     $21F              ; Check If Current Player Has Any Shots Active
                ORA     $220              ;
                ORA     $221              ;
                ORA     $222              ;
                BNE     loc_6992          ; Still Have Active Shots, Branch
                LDY     #7                ; Offset For "GAME OVER"
                JSR     sub_77F6          ; And Draw It To Screen
                LDA     $1C               ; Number Of Players In Current Game
                CMP     #2                ; 2 Player Game?
                BCC     loc_6992          ; No, Branch
                JSR     sub_69E2          ; Display On Screen Which Player's Game Is Over
  
loc_6992:

                LDA     $21B              ;
                BNE     loc_69CD          ;
                LDA     $2FA              ;
                CMP     #$80              ;
                BNE     loc_69CD          ;
                LDA     #$10              ;
                STA     $2FA              ;
                LDX     $1C               ; Number Of Players In Current Game
                LDA     $57               ; Check If ANY Player Has ANY Ships Left
                ORA     $58               ;
                BEQ     loc_69CF          ; Branch If All Players Are Out Of Ships
                JSR     sub_702D          ;
                DEX                       ;
                BEQ     loc_69CD          ; Will Branch If Only 1 Player Remaining In Game
                LDA     #$80              ;
                STA     $5A               ;
                LDA     $18               ; Current Player
                EOR     #1                ; Switch To Next Player
                TAX                       ;
                LDA     $57,X             ; Any Ships Left For This Player?
                BEQ     loc_69CD          ; No, Branch
                STX     $18               ; Flag Switch To Next Player
                LDA     #4                ; And Switch RAM To Next Player
                EOR     $6F               ; Bit 3, RAMSEL
                STA     $6F               ; Update Bitmap
                STA     $3200             ; Make The Switch 
                TXA                       ;
                ASL     A                 ;
                STA     $19               ;
  
loc_69CD:

                CLC                       ;
                RTS                       ;
; ---------------------------------------------------------------------------
  
loc_69CF:
                STX     $1A               ;
                LDA     #$FF              ;
                STA     $1C               ; Number Of Players In Current Game
                JSR     sub_6EFA          ; Turn Off All Sounds, Zero Sound Timers
                LDA     $6F               ; Bitmap Of $3200
                AND     #$F8              ;
                ORA     #3                ; Turn On Player 1 & 2 Start Lamps
                STA     $6F               ; Update Bitmap
                CLC                       ;
                RTS                       ;
; End of function sub_6885
  
  
; ¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦ S U B R O U T I N E ¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦
  
  
sub_69E2:

                LDY     #1                ; Offset For "PLAYER "
                JSR     sub_77F6          ; And Draw It On Screen
                LDY     $18               ; Current Player
                INY                       ; Used To Draw Either "1" Or "2" After "PLAYER "
                TYA                       ;
                JSR     sub_7BD1          ; Draw It To Screen
                RTS     
; End of function sub_69E2
  
; ---------------------------------------------------------------------------
                .BYTE  $71
  
; ¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦ S U B R O U T I N E ¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦
  
  
sub_69F0:
                LDX     #7                ;
  
loc_69F2:
                LDA     $21B,X            ; Check If Any Active Shot In This Slot
                BEQ     loc_69F9          ; No, Branch
                BPL     loc_69FD          ; Shot Still Active, Branch
  
loc_69F9:

                DEX                       ;
                BPL     loc_69F2          ;
                RTS                       ;
; ---------------------------------------------------------------------------
  
loc_69FD:
                LDY     #$1C              ;
                CPX     #4                ;
                BCS     loc_6A0A          ;
                DEY                       ;
                TXA     
                BNE     loc_6A0A
  
loc_6A07:

                DEY     
                BMI     loc_69F9          ;
  
loc_6A0A:

                LDA     $200,Y            ;
                BEQ     loc_6A07          ;
                BMI     loc_6A07          ;
                STA     $B                ;
                LDA     $2AF,Y            ;
                SEC                       ;
                SBC     $2CA,X            ;
                STA     8                 ;
                LDA     $269,Y            ;
                SBC     $284,X            ;
                LSR     A                 ;
                ROR     8                 ;
                ASL     A                 ;
                BEQ     loc_6A34          ;
                BPL     loc_6A97          ;
                EOR     #$FE              ;
                BNE     loc_6A97          ;
                LDA     8                 ;
                EOR     #$FF              ;
                STA     8                 ;
  
loc_6A34:
                LDA     $2D2,Y            ;
                SEC                       ;
                SBC     $2ED,X            ;
                STA     9                 ;
                LDA     $28C,Y            ;
                SBC     $2A7,X            ;
                LSR     A                 ;
                ROR     9                 ;
                ASL     A                 ;
                BEQ     loc_6A55          ;
                BPL     loc_6A97          ;
                EOR     #$FE              ;
                BNE     loc_6A97          ;
                LDA     9                 ;
                EOR     #$FF              ;
                STA     9                 ;
  
loc_6A55:
                LDA     #$2A              ;
                LSR     $B                ;
                BCS     loc_6A63          ;
                LDA     #$48              ;
                LSR     $B                ;
                BCS     loc_6A63          ;
                LDA     #$84              ;
  
loc_6A63:

                CPX     #1                ;
                BCS     loc_6A69          ;
                ADC     #$1C              ;
  
loc_6A69:
                BNE     loc_6A77          ;
                ADC     #$12              ;
                LDX     $21C              ; Saucer Flag
                DEX                       ;
                BEQ     loc_6A75          ; Small Saucer, Branch
                ADC     #$12              ;
  
loc_6A75:
                LDX     #1                ;
  
loc_6A77:
                CMP     8                 ;
                BCC     loc_6A97          ;
                CMP     9                 ;
                BCC     loc_6A97          ;
                STA     $B                ;
                LSR     A                 ;
                CLC                       ;
                ADC     $B                ;
                STA     $B                ;
                LDA     9                 ;
                ADC     8                 ;
                BCS     loc_6A97          ;
                CMP     $B                ;
                BCS     loc_6A97
                JSR     sub_6B0F
  
loc_6A94:
                JMP     loc_69F9          ;
; ---------------------------------------------------------------------------
  
loc_6A97:

                DEY     
                BMI     loc_6A94          ;
                JMP     loc_6A0A
; End of function sub_69F0
  
  
; ¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦ S U B R O U T I N E ¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦
  
  
sub_6A9D:

                LDA     $200,Y            ;
                AND     #7                ;
                STA     8                 ;
                JSR     sub_77B5          ;
                AND     #$18              ;
                ORA     8                 ;
                STA     $200,X            ;
                LDA     $2AF,Y
                STA     $2AF,X
                LDA     $269,Y
                STA     $269,X            ;
                LDA     $2D2,Y
                STA     $2D2,X
                LDA     $28C,Y
                STA     $28C,X
                LDA     $223,Y
                STA     $223,X
                LDA     $246,Y            ;
                STA     $246,X
                RTS     
; End of function sub_6A9D
  
  
; ¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦ S U B R O U T I N E ¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦
  
  
sub_6AD3:

                STA     $B                ;
                STX     $C
; End of function sub_6AD3
  
  
; ¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦ S U B R O U T I N E ¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦
  
  
sub_6AD7:
                LDY     #0                ;
  
loc_6AD9:
                INY                       ;
                LDA     ($B),Y            ;
                EOR     9
                STA     (2),Y
                DEY     
                CMP     #$F0
                BCS     loc_6B03          ;
                CMP     #$A0
                BCS     loc_6AFF
                LDA     ($B),Y
                STA     (2),Y
                INY     
                INY     
                LDA     ($B),Y            ;
                STA     (2),Y
                INY     
                LDA     ($B),Y            ;
                EOR     8
                ADC     $17
                STA     (2),Y             ;
  
loc_6AFC:
                INY     
                BNE     loc_6AD9          ;
  
loc_6AFF:
                DEY     
                JMP     sub_7C39          ;
; ---------------------------------------------------------------------------
  
loc_6B03:
                LDA     ($B),Y            ;
                EOR     8
                CLC     
                ADC     $17
                STA     (2),Y
                INY     
                BNE     loc_6AFC          ;
; End of function sub_6AD7
  
  
; ¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦ S U B R O U T I N E ¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦
  
  
sub_6B0F:
                CPX     #1
                BNE     loc_6B1B          ;
                CPY     #$1B
                BNE     loc_6B29          ;
                LDX     #0
                LDY     #$1C              ;
  
loc_6B1B:
                TXA                       ;
                BNE     loc_6B3C
                LDA     #$81
                STA     $2FA              ;
                LDX     $18               ; Current Player
                DEC     $57,X             ; Subtract Ship
                LDX     #0                ;
  
loc_6B29:
                LDA     #$A0
                STA     $21B,X            ;
                LDA     #0
                STA     $23E,X
                STA     $261,X
                CPY     #$1B
                BCC     loc_6B47          ;
                BCS     loc_6B73
  
loc_6B3C:
                LDA     #0
                STA     $21B,X            ;
                CPY     #$1B
                BEQ     loc_6B66
                BCS     loc_6B73          ;
  
loc_6B47:
                JSR     sub_75EC          ;
  
loc_6B4A:

                LDA     $200,Y            ;
                AND     #3
                EOR     #2
                LSR     A                 ;
                ROR     A
                ROR     A
                ORA     #$3F              ;
                STA     $69
                LDA     #$A0
                STA     $200,Y            ;
                LDA     #0
                STA     $223,Y
                STA     $246,Y            ;
                RTS     
; ---------------------------------------------------------------------------
  
loc_6B66:
                TXA                       ;
                LDX     $18               ; Current Player
                DEC     $57,X             ; Subtract Ship
                TAX     
                LDA     #$81
                STA     $2FA              ;
                BNE     loc_6B4A
  
loc_6B73:

                LDA     $2F8              ;
                STA     $2F7              ; Countdown Timer For When Saucer Appears
                LDA     $1C               ; Number Of Players In Current Game
                BEQ     loc_6B4A          ; None, Branch
                STX     $D                ;
                LDX     $19               ;
                LDA     $21C              ; Saucer Flag
                LSR     A                 ; Shift It To Carry
                LDA     #$99              ; 990 Points, Assume Small Saucer
                BCS     loc_6B8B          ; Carry Will Be Set If Small Saucer
                LDA     #$20              ; 200 Points, Its The Large Saucer
  
loc_6B8B:
                JSR     sub_7397          ; And Add It To Score
                LDX     $D
                JMP     loc_6B4A          ;
; End of function sub_6B0F
  
  
; ¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦ S U B R O U T I N E ¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦
  
  
sub_6B93:
                LDA     $5C               ;
                AND     #3
                BEQ     loc_6B9A          ;
  
locret_6B99:

                RTS                       ;
; ---------------------------------------------------------------------------
  
loc_6B9A:
                LDA     $21C              ; Saucer Flag
                BMI     locret_6B99       ; Currently Exploding?, Branch
                BEQ     loc_6BA4          ; No Saucer Currently Active, Branch
                JMP     loc_6C34          ;
; ---------------------------------------------------------------------------
  
loc_6BA4:
                LDA     $1C               ; Number Of Players In Current Game
                BEQ     loc_6BAF          ; None, Branch
                LDA     $21B              ;
                BEQ     locret_6B99       ;
                BMI     locret_6B99
  
loc_6BAF:
                LDA     $2F9              ;
                BEQ     loc_6BB7
                DEC     $2F9              ;
  
loc_6BB7:
                DEC     $2F7              ; Update Countdown Timer For When Saucer Appears
                BNE     locret_6B99
                LDA     #$12              ;
                STA     $2F7
                LDA     $2F9
                BEQ     loc_6BD0          ;
                LDA     $2F6
                BEQ     locret_6B99       ;
                CMP     $2FD              ;
                BCS     locret_6B99       ;
  
loc_6BD0:
                LDA     $2F8              ;
                SEC                       ;
                SBC     #6                ; Shorten Time Between Saucer Appearence
                CMP     #$20              ; At Lowest Value?
                BCC     loc_6BDD          ; Yes, Branch
                STA     $2F8              ; Make The Update
  
loc_6BDD:
                LDA     #0                ;
                STA     $2CB              ;
                STA     $285              ;
                JSR     sub_77B5          ;
                LSR     A                 ;
                ROR     $2EE              ;
                LSR     A                 ;
                ROR     $2EE              ;
                LSR     A
                ROR     $2EE              ;
                CMP     #$18
                BCC     loc_6BFA          ;
                AND     #$17
  
loc_6BFA:
                STA     $2A8              ;
                LDX     #$10
                BIT     $60
                BVS     loc_6C0F          ;
                LDA     #$1F
                STA     $285
                LDA     #$FF              ;
                STA     $2CB
                LDX     #$F0              ;
  
loc_6C0F:
                STX     $23F              ;
                LDX     #2                ; Start With Large Saucer
                LDA     $2F8              ; Start Checking Score When @ #$7F And Below
                BMI     loc_6C30          ; Not There Yet, Branch Around Score Check
                LDY     $19
                LDA     $53,Y             ; Current Player Score, Thousands
                CMP     #$30              ; 30,000 Points Or More?
                BCS     loc_6C2F          ; Yes, Branch
                JSR     sub_77B5
                STA     8
                LDA     $2F8              ;
                LSR     A
                CMP     8
                BCS     loc_6C30          ; Going To Be A large Saucer, Branch
  
loc_6C2F:
                DEX                       ; Make It A Small Saucer
  
loc_6C30:

                STX     $21C              ; Saucer Flag
                RTS     
; ---------------------------------------------------------------------------
  
loc_6C34:
                LDA     $5C               ; Fast Timer
                ASL     A                 ; Time To Change Saucer Direction? ( $5C = #$80 )
                BNE     loc_6C45          ; No, Branch
                JSR     sub_77B5          ;
                AND     #3                ;
                TAX     
                LDA     $6CD3,X           ; Direction Table
                STA     $262
  
loc_6C45:
                LDA     $1C               ; Number Of Players In Current Game
                BEQ     loc_6C4E          ; None, Branch
                LDA     $2FA
                BNE     locret_6C53       ;
  
loc_6C4E:
                DEC     $2F7
                BEQ     loc_6C54          ;
  
locret_6C53:
                RTS                       ;
; ---------------------------------------------------------------------------
  
loc_6C54:
                LDA     #$A               ; Time Between Saucer Shots
                STA     $2F7
                LDA     $21C              ; Saucer Flag
                LSR     A                 ; Check Saucer Size
                BEQ     loc_6C65          ; Branch If Small One
                JSR     sub_77B5
                JMP     loc_6CC4          ;
; ---------------------------------------------------------------------------
  
loc_6C65:
                LDA     $23F              ;
                CMP     #$80
                ROR     A
                STA     $C                ;
                LDA     $2CA
                SEC                       ;
                SBC     $2CB
                STA     $B                ;
                LDA     $284
                SBC     $285              ;
                ASL     $B
                ROL     A
                ASL     $B                ;
                ROL     A
                SEC     
                SBC     $C                ;
                TAX     
                LDA     $262
                CMP     #$80              ;
                ROR     A
                STA     $C
                LDA     $2ED              ;
                SEC     
                SBC     $2EE              ;
                STA     $B
                LDA     $2A7
                SBC     $2A8              ;
                ASL     $B
                ROL     A
                ASL     $B                ;
                ROL     A
                SEC                       ;
                SBC     $C
                TAY                       ;
                JSR     loc_76F0          ;
                STA     $62               ;
                JSR     sub_77B5          ;
                LDX     $19               ;
                LDY     $53,X             ; Current Players Score, Thousands
                CPY     #$35              ; 35,000?
                LDX     #0                ;
                BCC     loc_6CBA          ; Branch If Less
                INX                       ;
  
loc_6CBA:
                AND     $6CCF,X           ;
                BPL     loc_6CC2          ;
                ORA     $6CD1,X           ;
  
loc_6CC2:
                ADC     $62               ; Direction Shot Is Traveling???
  
loc_6CC4:
                STA     $62               ;
                LDY     #3                ;
                LDX     #1                ;
                STX     $E                ;
                JMP     loc_6CF2          ;
; End of function sub_6B93
  
; ---------------------------------------------------------------------------
                .BYTE  $8F
                .BYTE  $87

                .BYTE  $70
                .BYTE  $78
                                          ; First Colum Is Saucer Enters From Left Side Of Screen
                                          ; Second Colum Is Saucer Enters From Right Side Of Screen
                .BYTE  $F0                ; SE SW
                .BYTE    0                ; E  W
                .BYTE    0                ; E  W
                .BYTE  $10                ; NE NW
  
; ¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦ S U B R O U T I N E ¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦
  
  
sub_6CD7:
                LDA     $1C               ; Number Of Players In Current Game
                BEQ     locret_6CFC       ; None, Branch
                ASL     $2004             ; Fire Switch
                ROR     $63               ;
                BIT     $63               ;
                BPL     locret_6CFC       ;
                BVS     locret_6CFC       ;
                LDA     $2FA              ;
                BNE     locret_6CFC       ;
                TAX                       ;
                LDA     #3                ;
                STA     $E                ;
                LDY     #7                ;
  
loc_6CF2:

                LDA     $21B,Y            ; Check For A Open Slot For The Shot
                BEQ     loc_6CFD          ; Branch If This Slot Is Open
                DEY                       ; Point To Next Slot
                CPY     $E                ; Out Of Slots?
                BNE     loc_6CF2          ; No, Branch And Keep Checking
  
locret_6CFC:

                RTS                       ;
; ---------------------------------------------------------------------------
  
loc_6CFD:
                STX     $D                ;
                LDA     #$12              ;
                STA     $21B,Y            ;
                LDA     $61,X             ;
                JSR     sub_77D2          ;
                LDX     $D                ;
                CMP     #$80              ;
                ROR     A                 ;
                STA     9                 ;
                CLC                       ;
                ADC     $23E,X
                BMI     loc_6D1E          ;
                CMP     #$70
                BCC     loc_6D24          ;
                LDA     #$6F
                BNE     loc_6D24          ;
  
loc_6D1E:
                CMP     #$91              ;
                BCS     loc_6D24
                LDA     #$91
  
loc_6D24:

                STA     $23E,Y            ;
                LDA     $61,X
                JSR     sub_77D5
                LDX     $D                ;
                CMP     #$80
                ROR     A                 ;
                STA     $C
                CLC     
                ADC     $261,X            ;
                BMI     loc_6D41
                CMP     #$70              ;
                BCC     loc_6D47
                LDA     #$6F
                BNE     loc_6D47          ;
  
loc_6D41:
                CMP     #$91
                BCS     loc_6D47
                LDA     #$91              ;
  
loc_6D47:

                STA     $261,Y            ;
                LDX     #0
                LDA     9
                BPL     loc_6D51          ;
                DEX                       ;
  
loc_6D51:
                STX     8                 ;
                LDX     $D                ;
                CMP     #$80              ;
                ROR     A                 ;
                CLC                       ;
                ADC     9                 ;
                CLC                       ;
                ADC     $2CA,X            ;
                STA     $2CA,Y            ;
                LDA     8                 ;
                ADC     $284,X
                STA     $284,Y
                LDX     #0                ;
                LDA     $C
                BPL     loc_6D71
                DEX                       ;
  
loc_6D71:
                STX     $B                ;
                LDX     $D
                CMP     #$80
                ROR     A                 ;
                CLC     
                ADC     $C                ;
                CLC     
                ADC     $2ED,X
                STA     $2ED,Y            ;
                LDA     $B
                ADC     $2A7,X
                STA     $2A7,Y            ;
                LDA     #$80
                STA     $66,X             ;
                RTS     
; End of function sub_6CD7
  
; ---------------------------------------------------------------------------
                .BYTE  $D8
  
; ¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦ S U B R O U T I N E ¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦
  
  
sub_6D90:
                LDA     $32               ;
                AND     $33
                BPL     loc_6D97          ;
                RTS     
; ---------------------------------------------------------------------------
  
loc_6D97:
                LDA     $1A               ;
                LSR     A
                BEQ     loc_6DB4
                LDY     #1                ; Offset For "PLAYER "
                JSR     sub_77F6          ; And Draw To Screen
                LDY     #2                ;
                LDX     $33               ;
                BPL     loc_6DA8          ;
                DEY     
  
loc_6DA8:
                STY     $18               ; Current Player
                LDA     $5C               ; Fast Timer
                AND     #$10              ;
                BNE     loc_6DB4          ;
                TYA                       ;
                JSR     sub_7BD1          ;
  
loc_6DB4:

                LSR     $18               ; Current Player
                JSR     sub_73B2          ;
                LDY     #2                ; Offset For "YOUR SCORE IS ONE OF THE TEN BEST"
                JSR     sub_77F6          ; And Draw It To Screen
                LDY     #3                ; Offset For "PLEASE ENTER YOUR INITIALS"
                JSR     sub_77F6          ; And Draw It To Screen
                LDY     #4                ; Offset For "PUSH ROTATE TO SELECT LETTER"
                JSR     sub_77F6          ; And Draw It To Screen
                LDY     #5                ; Offset For "PUSH HYPERSPACE WHEN LETTER IS CORRECT"
                JSR     sub_77F6          ; And Draw It To Screen
                LDA     #$20              ;
                STA     0                 ;
                LDA     #$64              ;
                LDX     #$39
                JSR     sub_7C03
                LDA     #$70
                JSR     sub_7CDE
                LDX     $18               ; Current Player
                LDY     $32,X
                STY     $B                ;
                TYA     
                CLC                       ;
                ADC     $31
                STA     $C
                JSR     sub_6F1A          ;
                LDY     $B
                INY                       ;
                JSR     sub_6F1A
                LDY     $B                ;
                INY     
                INY                       ;
                JSR     sub_6F1A
                LDA     $2003             ; Hyperspace Switch
                ROL     A                 ;
                ROL     $63               ;
                LDA     $63               ;
                AND     #$1F              ;
                CMP     #7                ;
                BNE     loc_6E2E          ;
                INC     $31
                LDA     $31
                CMP     #3                ;
                BCC     loc_6E22
                LDX     $18               ; Current Player
                LDA     #$FF              ;
                STA     $32,X             ;
  
loc_6E15:
                LDX     #0                ;
                STX     $18
                STX     $31               ;
                LDX     #$F0
                STX     $5D               ; Slow Timer
                JMP     sub_73B2
; ---------------------------------------------------------------------------
  
loc_6E22:
                INC     $C                ;
                LDX     $C
                LDA     #$F4
                STA     $5D               ; Slow Timer
                LDA     #$B
                STA     $34,X             ;
  
loc_6E2E:
                LDA     $5D               ; Slow Timer
                BNE     loc_6E3A
                LDA     #$FF              ;
                STA     $32
                STA     $33               ;
                BMI     loc_6E15
  
loc_6E3A:
                LDA     $5C               ; Fast Timer
                AND     #7
                BNE     loc_6E71
                LDA     $2407             ; Rotate Left Switch
                BPL     loc_6E49
                LDA     #1
                BNE     loc_6E50
  
loc_6E49:
                LDA     $2406             ; Rotate Right Switch
                BPL     loc_6E71          ;
                LDA     #$FF              ;
  
loc_6E50:
                LDX     $C                ;
                CLC     
                ADC     $34,X
                BMI     loc_6E67          ;
                CMP     #$B
                BCS     loc_6E69
                CMP     #1                ;
                BEQ     loc_6E63
                LDA     #0
                BEQ     loc_6E6F
  
loc_6E63:
                LDA     #$B               ;
                BNE     loc_6E6F
  
loc_6E67:
                LDA     #$24              ;
  
loc_6E69:
                CMP     #$25              ;
                BCC     loc_6E6F
                LDA     #0                ;
  
loc_6E6F:

                STA     $34,X             ;
  
loc_6E71:

                LDA     #0                ;
                RTS     
; End of function sub_6D90
  
  
; ¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦ S U B R O U T I N E ¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦
  
  
sub_6E74:
                LDA     $1C               ; Number Of Players In Current Game
                BEQ     locret_6ED7       ; None, Branch
                LDA     $21B              ; Player Flag
                BMI     locret_6ED7       ; Branch If Currently Exploding
                LDA     $2FA              ;
                BNE     locret_6ED7       ;
                LDA     $2003             ; Hyperspace Switch
                BPL     locret_6ED7       ; Branch If NOT Pressed
                LDA     #0                ;
                STA     $21B              ;
                STA     $23E              ;
                STA     $261              ;
                LDA     #$30              ;
                STA     $2FA              ;
                JSR     sub_77B5          ;
                AND     #$1F              ;
                CMP     #$1D              ;
                BCC     loc_6EA2          ;
                LDA     #$1C              ;
  
loc_6EA2:
                CMP     #3                ;
                BCS     loc_6EA8          ;
                LDA     #3                ;
  
loc_6EA8:
                STA     $284              ;
                LDX     #5                ;
  
loc_6EAD:
                JSR     sub_77B5          ;
                DEX                       ;
                BNE     loc_6EAD          ;
                AND     #$1F              ;
                INX                       ; Assume Success ( X = 1 At This Point )
                CMP     #$18              ;
                BCC     loc_6EC6          ;
                AND     #7                ;
                ASL     A                 ;
                ADC     #4                ;
                CMP     $2F6              ;
                BCC     loc_6EC6          ;
                LDX     #$80              ; Flag Hyperspace Unsuccessful
  
loc_6EC6:

                CMP     #$15              ;
                BCC     loc_6ECC          ;
                LDA     #$14              ;
  
loc_6ECC:
                CMP     #3                ;
                BCS     loc_6ED2          ;
                LDA     #3                ;
  
loc_6ED2:
                STA     $2A7              ;
                STX     $59               ; Hyperspace Flag
  
locret_6ED7:

                RTS                       ;
; End of function sub_6E74
  
  
; ¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦ S U B R O U T I N E ¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦
  
  
sub_6ED8:

                LDA     #2                ;
                STA     $2F5              ;
                LDX     #3                ; Assume A 3 Ship Game
                LSR     $2802             ; Shift Number Of Starting Ships Bit To Carry
                BCS     loc_6EE5          ; 3 Ship Game
                INX                       ; 4 Ship Game
  
loc_6EE5:
                STX     $56               ;
                LDA     #0                ;
                LDX     #4                ;
  
loc_6EEB:
                STA     $21B,X            ;
                STA     $21F,X
                STA     $51,X             ; *BUG* Should Be $52,X
                DEX     
                BPL     loc_6EEB          ;
                STA     $2F6
                RTS                       ;
; End of function sub_6ED8
  
  
; ¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦ S U B R O U T I N E ¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦
  
  
sub_6EFA:

                LDA     #0                ;
                STA     $3600
                STA     $3A00
                STA     $3C00             ;
                STA     $3C01
                STA     $3C03
                STA     $3C04
                STA     $3C05             ;
                STA     $69
                STA     $66
                STA     $67
                STA     $68               ;
                RTS     
; End of function sub_6EFA
  
  
; ¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦ S U B R O U T I N E ¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦
  
  
sub_6F1A:

                LDA     $34,Y             ;
                ASL     A
                TAY     
                BNE     sub_6F35          ;
                LDA     $32
                AND     $33
                BMI     sub_6F35          ;
                LDA     #$72
                LDX     #$F8              ;
                JSR     sub_7D45
                LDA     #1                ;
                LDX     #$F8
                JMP     sub_7D45          ;
; End of function sub_6F1A
  
  
; ¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦ S U B R O U T I N E ¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦
  
  
sub_6F35:

                LDX     $56D5,Y           ;
                LDA     $56D4,Y
                JMP     sub_7D45          ;
; End of function sub_6F35
  
  
; ¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦ S U B R O U T I N E ¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦
  
  
sub_6F3E:

                BEQ     locret_6F56       ;
                STY     8
                LDX     #$D5
                LDY     #$E0              ;
                STY     0
                JSR     sub_7C03
  
loc_6F4B:
                LDX     #$DA              ;
                LDA     #$54
                JSR     sub_7BFC
                DEC     8                 ;
                BNE     loc_6F4B
  
locret_6F56:
                RTS                       ;
; End of function sub_6F3E
  
  
; ¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦ S U B R O U T I N E ¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦
  
  
sub_6F57:
                LDX     #$22              ;
  
loc_6F59:
                LDA     $200,X
                BNE     loc_6F62          ;
  
loc_6F5E:

                DEX                       ;
                BPL     loc_6F59
                RTS                       ;
; ---------------------------------------------------------------------------
  
loc_6F62:
                BPL     loc_6FC7          ;
                JSR     sub_7708          ;
                LSR     A
                LSR     A                 ;
                LSR     A
                LSR     A
                CPX     #$1B              ;
                BNE     loc_6F76          ;
                LDA     $5C               ;
                AND     #1                ;
                LSR     A
                BEQ     loc_6F77          ;
  
loc_6F76:
                SEC                       ;
  
loc_6F77:
                ADC     $200,X
                BMI     loc_6FA1          ;
                CPX     #$1B
                BEQ     loc_6F93
                BCS     loc_6F99          ;
                DEC     $2F6
                BNE     loc_6F8C
                LDY     #$7F              ;
                STY     $2FB              ;
  
loc_6F8C:

                LDA     #0                ;
                STA     $200,X
                BEQ     loc_6F5E          ;
  
loc_6F93:
                JSR     sub_71E8          ;
                JMP     loc_6F8C          ;
; ---------------------------------------------------------------------------
  
loc_6F99:
                LDA     $2F8              ;
                STA     $2F7              ; Countdown Timer For When Saucer Appears
                BNE     loc_6F8C          ;
  
loc_6FA1:
                STA     $200,X            ;
                AND     #$F0              ;
                CLC                       ;
                ADC     #$10              ;
                CPX     #$1B
                BNE     loc_6FAF
                LDA     #0                ;
  
loc_6FAF:
                TAY                       ;
                LDA     $2AF,X
                STA     4
                LDA     $269,X            ;
                STA     5
                LDA     $2D2,X
                STA     6                 ;
                LDA     $28C,X
                STA     7
                JMP     loc_7027          ;
; ---------------------------------------------------------------------------
  
loc_6FC7:
                CLC                       ;
                LDY     #0
                LDA     $223,X
                BPL     loc_6FD0          ;
                DEY     
  
loc_6FD0:
                ADC     $2AF,X            ;
                STA     $2AF,X
                STA     4
                TYA                       ;
                ADC     $269,X
                CMP     #$20
                BCC     loc_6FEC          ;
                AND     #$1F
                CPX     #$1C
                BNE     loc_6FEC          ;
                JSR     sub_702D
                JMP     loc_6F5E          ;
; ---------------------------------------------------------------------------
  
loc_6FEC:

                STA     $269,X            ;
                STA     5
                CLC     
                LDY     #0                ;
                LDA     $246,X
                BPL     loc_6FFB
                LDY     #$FF              ;
  
loc_6FFB:
                ADC     $2D2,X
                STA     $2D2,X            ;
                STA     6
                TYA     
                ADC     $28C,X
                CMP     #$18              ;
                BCC     loc_7013
                BEQ     loc_7011
                LDA     #$17
                BNE     loc_7013          ;
  
loc_7011:
                LDA     #0                ;
  
loc_7013:

                STA     $28C,X            ;
                STA     7                 ;
                LDA     $200,X
                LDY     #$E0
                LSR     A                 ;
                BCS     loc_7027
                LDY     #$F0
                LSR     A
                BCS     loc_7027          ;
                LDY     #0                ;
  
loc_7027:

                JSR     sub_72FE          ;
                JMP     loc_6F5E          ;
; End of function sub_6F57
  
  
; ¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦ S U B R O U T I N E ¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦
  
  
sub_702D:

                LDA     $2F8              ; Starting Value For Timer @ $02F7
                STA     $2F7              ; Countdown Timer For When Saucer Appears
                LDA     #0
                STA     $21C              ; Saucer Flag
                STA     $23F              ;
                STA     $262
                RTS                       ;
; End of function sub_702D
  
  
; ¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦ S U B R O U T I N E ¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦
  
  
sub_703F:
                LDA     $1C               ; Number Of Players In Current Game
                BEQ     locret_7085       ; None, Branch
                LDA     $21B              ; Player Flag
                BMI     locret_7085       ; Branch If Currently Exploding
                LDA     $2FA              ;
                BEQ     loc_7086          ;
                DEC     $2FA              ;
                BNE     locret_7085       ;
                LDY     $59               ; Hyperspace Flag
                BMI     loc_706F          ; Gonna Die From Hyperspace, Branch
                BNE     loc_7068          ; Successful Hyperspace, Branch
                JSR     sub_7139          ;
                BNE     loc_7081          ;
                LDY     $21C              ;
                BEQ     loc_7068          ;
                LDY     #2                ;
                STY     $2FA              ;
                RTS                       ;
; ---------------------------------------------------------------------------
  
loc_7068:

                LDA     #1                ; Flag Ship OK
                STA     $21B              ;
                BNE     loc_7081          ; Will Always Branch
  
loc_706F:
                LDA     #$A0              ; Switch To Explosion Timer
                STA     $21B              ;
                LDX     #$3E              ;
                STX     $69               ;
                LDX     $18               ; Current Player
                DEC     $57,X             ; Subtract Ship
                LDA     #$81
                STA     $2FA              ;
  
loc_7081:

                LDA     #0                ;
                STA     $59
  
locret_7085:

                RTS                       ;
; ---------------------------------------------------------------------------
  
loc_7086:
                LDA     $2407             ; Rotate Left Switch
                BPL     loc_708F          ; Branch If NOT Pressed
                LDA     #3                ;
                BNE     loc_7096          ; Will Always Branch
  
loc_708F:
                LDA     $2406             ; Rotate Right Switch
                BPL     loc_709B          ; Branch If NOT Pressed
                LDA     #$FD              ;
  
loc_7096:
                CLC                       ;
                ADC     $61               ; Current Ship Direction
                STA     $61               ;
  
loc_709B:
                LDA     $5C               ; Fast Timer
                LSR     A                 ;
                BCS     locret_7085       ;
                LDA     $2405             ; Thrust Switch
                BPL     loc_70E1          ; Branch If NOT Pressed
                LDA     #$80              ;
                STA     $3C03             ; Ship Thrust Sound
                LDY     #0                ;
                LDA     $61               ; Current Ship Direction
                JSR     sub_77D2          ;
                BPL     loc_70B4
                DEY                       ;
  
loc_70B4:
                ASL     A                 ;
                CLC     
                ADC     $64
                TAX     
                TYA                       ;
                ADC     $23E
                JSR     sub_7125
                STA     $23E
                STX     $64               ;
                LDY     #0
                LDA     $61
                JSR     sub_77D5          ;
                BPL     loc_70CF
                DEY                       ;
  
loc_70CF:
                ASL     A                 ;
                CLC     
                ADC     $65
                TAX                       ;
                TYA     
                ADC     $261
                JSR     sub_7125          ;
                STA     $261
                STX     $65
                RTS                       ;
; ---------------------------------------------------------------------------
  
loc_70E1:
                LDA     #0                ;
                STA     $3C03             ; Ship Thrust Sound
                LDA     $23E
                ORA     $64
                BEQ     loc_7105
                LDA     $23E              ;
                ASL     A
                LDX     #$FF
                CLC     
                EOR     #$FF              ;
                BMI     loc_70FA
                INX     
                SEC                       ;
  
loc_70FA:
                ADC     $64
                STA     $64               ;
                TXA     
                ADC     $23E
                STA     $23E              ;
  
loc_7105:
                LDA     $65               ;
                ORA     $261
                BEQ     locret_7124
                LDA     $261              ;
                ASL     A
                LDX     #$FF
                CLC     
                EOR     #$FF              ;
                BMI     loc_7119
                SEC     
                INX                       ;
  
loc_7119:
                ADC     $65
                STA     $65               ;
                TXA     
                ADC     $261
                STA     $261              ;
  
locret_7124:
                RTS                       ;
; End of function sub_703F
  
  
; ¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦ S U B R O U T I N E ¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦
  
  
sub_7125:

                BMI     loc_7130          ;
                CMP     #$40
                BCC     locret_7138
                LDX     #$FF              ;
                LDA     #$3F
                RTS                       ;
; ---------------------------------------------------------------------------
  
loc_7130:
                CMP     #$C0
                BCS     locret_7138       ;
                LDX     #1
                LDA     #$C0              ;
  
locret_7138:

                RTS                       ;
; End of function sub_7125
  
  
; ¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦ S U B R O U T I N E ¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦
  
  
sub_7139:
                LDX     #$1C              ;
 
loc_713B:
                LDA     $200,X            ;
                BEQ     loc_715E
                LDA     $269,X
                SEC                       ;
                SBC     $284
                CMP     #4                ;
                BCC     loc_714F
                CMP     #$FC
                BCC     loc_715E          ;
  
loc_714F:
                LDA     $28C,X            ;
                SEC     
                SBC     $2A7
                CMP     #4                ;
                BCC     loc_7163
                CMP     #$FC
                BCS     loc_7163          ;
  
loc_715E:

                DEX                       ;
                BPL     loc_713B
                INX     
                RTS                       ;
; ---------------------------------------------------------------------------
  
loc_7163:

                INC     $2FA              ;
                RTS                       ;
; End of function sub_7139
  
; ---------------------------------------------------------------------------
                .BYTE  $90
  
; ¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦ S U B R O U T I N E ¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦
  
  
sub_7168:

                LDX     #$1A              ;
                LDA     $2FB
                BNE     loc_71DF
                LDA     $21C              ; Saucer Flag
                BNE     locret_71E7       ; Branch If Saucer Is Currently Active
                STA     $23F
                STA     $262
                INC     $2FD
                LDA     $2FD              ;
                CMP     #$B
                BCC     loc_7187
                DEC     $2FD              ;
  
loc_7187:
                LDA     $2F5              ;
                CLC     
                ADC     #2
                CMP     #$B
                BCC     loc_7193          ;
                LDA     #$B               ;
  
loc_7193:
                STA     $2F6              ;
                STA     $2F5
                STA     8                 ;
                LDY     #$1C              ;
  
loc_719D:
                JSR     sub_77B5          ;
                AND     #$18
                ORA     #4                ;
                STA     $200,X
                JSR     sub_7203
                JSR     sub_77B5          ;
                LSR     A
                AND     #$1F
                BCC     loc_71C5          ;
                CMP     #$18
                BCC     loc_71B8
                AND     #$17              ;
  
loc_71B8:
                STA     $28C,X            ;
                LDA     #0
                STA     $269,X
                STA     $2AF,X            ;
                BEQ     loc_71D0          ;
  
loc_71C5:
                STA     $269,X            ;
                LDA     #0
                STA     $28C,X            ;
                STA     $2D2,X            ;
  
loc_71D0:
                DEX     
                DEC     8                 ;
                BNE     loc_719D
                LDA     #$7F
                STA     $2F7              ; Countdown Timer For When Saucer Appears
                LDA     #$30
                STA     $2FC              ; Starting Value For Timer @ $6E
  
loc_71DF:
                LDA     #0                ;
 
loc_71E1:
                STA     $200,X            ;
                DEX     
                BPL     loc_71E1          ;
  
locret_71E7:
                RTS                       ;
; End of function sub_7168
  
  
; ¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦ S U B R O U T I N E ¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦
  
  
sub_71E8:

                LDA     #$60              ;
                STA     $2CA
                STA     $2ED
                LDA     #0
                STA     $23E              ;
                STA     $261
                LDA     #$10
                STA     $284
                LDA     #$C               ;
                STA     $2A7
                RTS                       ;
; End of function sub_71E8
  
  
; ¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦ S U B R O U T I N E ¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦
  
  
sub_7203:

                JSR     sub_77B5          ;
                AND     #$8F
                BPL     loc_720C
                ORA     #$F0              ;

loc_720C:
                CLC     
                ADC     $223,Y
                JSR     sub_7233          ;
                STA     $223,X
                JSR     sub_77B5
                JSR     sub_77B5          ;
                JSR     sub_77B5
                JSR     sub_77B5
                AND     #$8F              ;
                BPL     loc_7228
                ORA     #$F0              ;
  
loc_7228:
                CLC                       ;
                ADC     $246,Y
                JSR     sub_7233          ;
                STA     $246,X
                RTS                       ;
; End of function sub_7203
  
  
; ¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦ S U B R O U T I N E ¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦
  
  
sub_7233:

                BPL     loc_7242          ;
                CMP     #$E1
                BCS     loc_723B
                LDA     #$E1              ;
  
loc_723B:
                CMP     #$FB              ;
                BCC     locret_724E
                LDA     #$FA              ;
                RTS                       ;
; ---------------------------------------------------------------------------
  
loc_7242:
                CMP     #6                ;
                BCS     loc_7248
                LDA     #6                ;
  
loc_7248:
                CMP     #$20              ;
                BCC     locret_724E
                LDA     #$1F              ;
  
locret_724E:

                RTS                       ;
; End of function sub_7233
  
  
; ¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦ S U B R O U T I N E ¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦
  
  
sub_724F:
                LDA     #$10              ;
                STA     0
                LDA     #$50              ;
                LDX     #$A4
                JSR     sub_7BFC
                LDA     #$19              ;
                LDX     #$DB
                JSR     sub_7C03
                LDA     #$70
                JSR     sub_7CDE
                LDX     #0
                LDA     $1C               ; Number Of Players In Current Game
                CMP     #2                ; 2 Players?
                BNE     loc_7286          ; No, Branch
                LDA     $18               ; Current Player
                BNE     loc_7286          ; Player 2? Yes, Branch
                LDX     #$20              ;
                LDA     $21B              ; Player Flag
                ORA     $59               ; Hyperspace Flag
                BNE     loc_7286          ;
                LDA     $2FA
                BMI     loc_7286          ;
                LDA     $5C               ; Fast Timer
                AND     #$10              ;
                BEQ     loc_7293          ;
  
loc_7286:

                LDA     #$52              ;
                LDY     #2
                SEC                       ;
                JSR     sub_773F
                LDA     #0                ;
                JSR     sub_778B
  
loc_7293:
                LDA     #$28              ;
                LDY     $57               ; Number Of Ships Remaining, Player 1
                JSR     sub_6F3E
                LDA     #0
                STA     0
                LDA     #$78              ;
                LDX     #$DB
                JSR     sub_7C03
                LDA     #$50
                JSR     sub_7CDE
                LDA     #$1D
                LDY     #2                ;
                SEC     
                JSR     sub_773F          ;
                LDA     #0
                JSR     sub_7BD1          ;
                LDA     #$10
                STA     0
                LDA     #$C0              ;
                LDX     #$DB
                JSR     sub_7C03
                LDA     #$50
                JSR     sub_7CDE          ;
                LDX     #0                ;
                LDA     $1C               ; Number Of Players In Current Game
                CMP     #1                ; Only 1 Player?
                BEQ     locret_72FD       ; Yes, Branch
                BCC     loc_72E9          ;
                LDA     $18               ; Current Player
                BEQ     loc_72E9          ; Branch If Player 1
                LDX     #$20              ;
                LDA     $21B              ; Player Flag
                ORA     $59               ; Hyperspace Flag
                BNE     loc_72E9
                LDA     $2FA              ;
                BMI     loc_72E9
                LDA     $5C               ; Fast Timer
                AND     #$10              ;
                BEQ     loc_72F6          ;
  
loc_72E9:

                LDA     #$54              ;
                LDY     #2
                SEC     
                JSR     sub_773F          ;
                LDA     #0
                JSR     sub_778B

loc_72F6:
                LDA     #$CF              ;
                LDY     $58               ; Current Number Of Ships, Player 2
                JMP     sub_6F3E          ;
; ---------------------------------------------------------------------------
  
locret_72FD:
                RTS                       ;
; End of function sub_724F
  
  
; ¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦ S U B R O U T I N E ¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦
  
  
sub_72FE:
                STY     0                 ;
                STX     $D
                LDA     5
                LSR     A
                ROR     4
                LSR     A                 ;
                ROR     4
                LSR     A
                ROR     4
                STA     5                 ;
                LDA     7
                CLC     
                ADC     #4
                LSR     A                 ;
                ROR     6
                LSR     A
                ROR     6
                LSR     A
                ROR     6                 ;
                STA     7
                LDX     #4
                JSR     sub_7C1C          ;
                LDA     #$70
                SEC     
                SBC     0
                CMP     #$A0              ;
                BCC     loc_733B          ;
  
loc_732D:
                PHA                       ;
                LDA     #$90
                JSR     sub_7CDE          ;
                PLA     
                SEC                       ;
                SBC     #$10
                CMP     #$A0              ;
                BCS     loc_732D          ;
  
loc_733B:
                JSR     sub_7CDE          ;
                LDX     $D
                LDA     $200,X
                BPL     loc_735B          ;
                CPX     #$1B
                BEQ     loc_7355
                AND     #$C
                LSR     A                 ;
                TAY     
                LDA     $50F8,Y
                LDX     $50F9,Y
                BNE     loc_7370          ;
  
loc_7355:
                JSR     sub_7465          ;
                LDX     $D
                RTS                       ;
; ---------------------------------------------------------------------------
  
loc_735B:
                CPX     #$1B              ;
                BEQ     loc_7376
                CPX     #$1C
                BEQ     loc_737C
                BCS     loc_7384          ;
                AND     #$18
                LSR     A
                LSR     A
                TAY                       ;
                LDA     $51DE,Y
                LDX     $51DF,Y           ;
  
loc_7370:

                JSR     sub_7D45          ;
                LDX     $D
                RTS                       ;
; ---------------------------------------------------------------------------
  
loc_7376:
                JSR     sub_750B          ;
                LDX     $D
                RTS                       ;
; ---------------------------------------------------------------------------
  
loc_737C:
                LDA     $5250             ;
                LDX     $5251
                BNE     loc_7370          ;
  
loc_7384:
                LDA     #$70              ;
                LDX     #$F0
                JSR     sub_7CE0          ;
                LDX     $D
                LDA     $5C               ; Fast Timer
                AND     #3
                BNE     locret_7396       ;
                DEC     $200,X
  
locret_7396:
                RTS                       ;
; End of function sub_72FE
  
  
; ¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦ S U B R O U T I N E ¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦
  
  
sub_7397:

                SED                       ; Set Decimal Mode
                ADC     $52,X             ; Add To Current Players Score, Tens
                STA     $52,X             ;
                BCC     loc_73B0          ; Increase In Thousands?, No, Branch
                LDA     $53,X             ; Current Players Score, Thousands
                ADC     #0                ; Add In The Carry
                STA     $53,X
                AND     #$F               ; Will Be 0 If Another 10,000 Points Reached
                BNE     loc_73B0          ; Branch If Not Enough Points For Bonus Ship
                LDA     #$B0              ; Length Of Time To Play Bonus Ship Sound
                STA     $68               ; Into Timer
                LDX     $18               ; Current Player
                INC     $57,X             ; Award Bonus Ship
  
loc_73B0:

                CLD                       ; Clear Decimal Mode
                RTS                       ;
; End of function sub_7397
  
  
; ¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦ S U B R O U T I N E ¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦
  
  
sub_73B2:

                LDA     $18               ; Current Player
                ASL     A
                ASL     A
                STA     8
                LDA     $6F
                AND     #$FB
                ORA     8                 ;
                STA     $6F
                STA     $3200
                RTS                       ;
; End of function sub_73B2
  
  
; ¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦ S U B R O U T I N E ¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦
  
  
sub_73C4:
                LDA     $1C               ; Number Of Players In Current Game
                BEQ     loc_73CA          ; None, Branch
  
loc_73C8:

                CLC                       ;
                RTS     
  
loc_73CA:
                LDA     $5D               ; Slow Timer
                AND     #4
                BNE     loc_73C8
                LDA     $1D               ; Highest Score In Table
                ORA     $1E
                BEQ     loc_73C8          ; Table Empty, Branch
                LDY     #0                ; Offset To "HIGH SCORE"
                JSR     sub_77F6          ; And Draw To Screen
                LDX     #0
                STX     $10
                LDA     #1
                STA     0                 ;
                LDA     #$A7
                STA     $E
                LDA     #$10
                STA     0                 ;
  
loc_73EB:
                LDA     $1D,X             ; High Score Table
                ORA     $1E,X             ;
                BEQ     loc_7458          ; No Score In This Entry, Branch
                STX     $F
                LDA     #$5F              ;
                LDX     $E
                JSR     sub_7C03
                LDA     #$40
                JSR     sub_7CDE          ;
                LDA     $F
                LSR     A
                SED                       ; Set Decimal Mode
                ADC     #1                ;
                CLD                       ; Clear Decimal Mode
                STA     $D
                LDA     #$D
                SEC                       ;
                LDY     #1
                LDX     #0
                JSR     sub_773F
                LDA     #$40              ;
                TAX     
                JSR     sub_7CE0
                LDY     #0
                JSR     sub_6F35          ;
                LDA     $F
                CLC     
                ADC     #$1D
                LDY     #2                ;
                SEC     
                LDX     #0
                JSR     sub_773F
                LDA     #0                ;
                JSR     sub_7BD1
                LDY     #0
                JSR     sub_6F35
                LDY     $10               ;
                JSR     sub_6F1A
                INC     $10
                LDY     $10
                JSR     sub_6F1A          ;
                INC     $10
                LDY     $10
                JSR     sub_6F1A
                INC     $10               ;
                LDA     $E
                SEC     
                SBC     #8
                STA     $E                ;
                LDX     $F                ;
                INX                       ;
                INX                       ; Point To Next Entry In Table
                CPX     #$14              ; End Of Table?
                BCC     loc_73EB          ; No, Branch
  
loc_7458:
                SEC     
                RTS                       ;
; End of function sub_73C4
  
  
; ¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦ S U B R O U T I N E ¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦
  
  
sub_745A:
                LDX     #$1A              ;
; End of function sub_745A
  
  
; ¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦ S U B R O U T I N E ¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦
  
  
sub_745C:

                LDA     $200,X            ;
                BEQ     locret_7464
                DEX     
                BPL     sub_745C          ;
  
locret_7464:
                RTS                       ;
; End of function sub_745C
  
  
; ¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦ S U B R O U T I N E ¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦
  
  
sub_7465:
                LDA     $21B              ;
                CMP     #$A2
                BCS     loc_748E          ;
                LDX     #$A
  
loc_746E:
                LDA     $50EC,X           ;
                LSR     A
                LSR     A
                LSR     A
                LSR     A
                CLC                       ;
                ADC     #$F8
                EOR     #$F8
                STA     $7E,X
                LDA     $50ED,X           ;
                LSR     A
                LSR     A
                LSR     A
                LSR     A                 ;
                CLC     
                ADC     #$F8
                EOR     #$F8
                STA     $8A,X             ;
                DEX     
                DEX     
                BPL     loc_746E          ;
  
loc_748E:
                LDA     $21B              ;
                EOR     #$FF
                AND     #$70
                LSR     A                 ;
                LSR     A
                LSR     A
                TAX                       ;
  
loc_7499:
                STX     9
                LDY     #0                ;
                LDA     $50EC,X
                BPL     loc_74A3
                DEY                       ;
  
loc_74A3:
                CLC                       ;
                ADC     $7D,X
                STA     $7D,X
                TYA                       ;
                ADC     $7E,X
                STA     $7E,X
                STA     4
                STY     5                 ;
                LDY     #0
                LDA     $50ED,X
                BPL     loc_74B9
                DEY                       ;
  
loc_74B9:
                CLC                       ;
                ADC     $89,X
                STA     $89,X
                TYA     
                ADC     $8A,X             ;
                STA     $8A,X
                STA     6
                STY     7
                LDA     2                 ;
                STA     $B
                LDA     3
                STA     $C
                JSR     sub_7C49          ;
                LDY     9
                LDA     $50E0,Y
                LDX     $50E1,Y
                JSR     sub_7D45          ;
                LDY     9
                LDA     $50E1,Y
                EOR     #4
                TAX                       ;
                LDA     $50E0,Y
                AND     #$F
                EOR     #4
                JSR     sub_7D45          ;
                LDY     #$FF              ;
  
loc_74F1:
                INY                       ;
                LDA     ($B),Y
                STA     (2),Y
                INY     
                LDA     ($B),Y            ;
                EOR     #4
                STA     (2),Y
                CPY     #3
                BCC     loc_74F1          ;
                JSR     sub_7C39
                LDX     9
                DEX     
                DEX                       ;
                BPL     loc_7499
                RTS                       ;
; End of function sub_7465
  
  
; ¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦ S U B R O U T I N E ¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦
  
  
sub_750B:
                LDX     #0                ;
                STX     $17               ;
                LDY     #0                ;
                LDA     $61               ; Ship Direction
                BPL     loc_751B          ;
                LDY     #4
                TXA     
                SEC     
                SBC     $61               ;
  
loc_751B:
                STA     8                 ;
                BIT     8
                BMI     loc_7523
                BVC     loc_752A          ;
  
loc_7523:
                LDX     #4                ;
                LDA     #$80
                SEC     
                SBC     8                 ;
  
loc_752A:
                STX     8                 ;
                STY     9
                LSR     A
                AND     #$FE
                TAY                       ;
                LDA     $526E,Y
                LDX     $526F,Y
                JSR     sub_6AD3
                LDA     $2405             ; Thrust Switch
                BPL     locret_7554       ; Branch If NOT Pressed
                LDA     $5C               ; Fast Timer
                AND     #4
                BEQ     locret_7554       ;
                INY     
                INY     
                SEC     
                LDX     $C                ;
                TYA     
                ADC     $B
                BCC     loc_7551
                INX                       ;
  
loc_7551:
                JSR     sub_6AD3          ;
  
locret_7554:

                RTS                       ;
; End of function sub_750B
  
  
; ¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦ S U B R O U T I N E ¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦
  
  
sub_7555:
                LDA     $1C               ; Number Of Players In Current Game
                BNE     loc_755A          ; Branch If At Least 1 Player Left
                RTS                       ;
; ---------------------------------------------------------------------------
  
loc_755A:
                LDX     #0                ;
                LDA     $21C              ; Saucer Flag
                BMI     loc_756B          ; Currently Exploding, Branch
                BEQ     loc_756B          ; No Active Saucer, Branch
                ROR     A
                ROR     A
                ROR     A
                STA     $3C02             ; Saucer Sound Select
                LDX     #$80
  
loc_756B:

                STX     $3C00             ; Saucer Sound
                LDX     #1
                JSR     sub_75CD
                STA     $3C01             ; Saucer Fire Sound
                DEX     
                JSR     sub_75CD
                STA     $3C04             ; Ship Fire Sound
                LDA     $21B
                CMP     #1
                BEQ     loc_7588
                TXA     
                STA     $3C03             ; Ship Thrust Sound
  
loc_7588:
                LDA     $2F6              ;
                BEQ     loc_759E          ;
                LDA     $21B              ; Player Flag
                BMI     loc_759E          ; Currently Exploding, Branch
                ORA     $59               ; Hyperspace Flag
                BEQ     loc_759E          ;
                LDA     $6D               ;
                BEQ     loc_75AE          ;
                DEC     $6D               ;
                BNE     loc_75BF          ;
  
loc_759E:

                LDA     $6C               ; Current Volume And Frequency Of THUMP Sound
                AND     #$F               ; Mask Off Frequency Control
                STA     $6C
                STA     $3A00             ; Turn Off Volume, Retain Current Frequency
                LDA     $2FC              ;
                STA     $6E
                BPL     loc_75BF          ;
  
loc_75AE:
                DEC     $6E               ;
                BNE     loc_75BF
                LDA     #4
                STA     $6D
                LDA     $6C               ;
                EOR     #$14              ; Turn On Volume, Switch Frequency
                STA     $6C               ; Store It In Current Settings
                STA     $3A00             ; Make The Change
  
loc_75BF:

                LDA     $69               ;
                TAX     
                AND     #$3F
                BEQ     loc_75C7
                DEX                       ;
  
loc_75C7:
                STX     $69               ;
                STX     $3600             ; Explosion Pitch/Volume
                RTS                       ;
; End of function sub_7555
  
  
; ¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦ S U B R O U T I N E ¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦

; Fire Sound Handling
  
  
sub_75CD:

                LDA     $6A,X             ; X = 0 Ship Fire, X = 1 Saucer Fire
                BMI     loc_75DD
                LDA     $66,X
                BPL     loc_75E7          ;
                LDA     #$10
                STA     $66,X             ; TIMER: Length Of Time Sound Is On
  
loc_75D9:
                LDA     #$80              ; Turn Fire Sound On
                BMI     loc_75E9          ; Will Always Branch
  
loc_75DD:
                LDA     $66,X             ;
                BEQ     loc_75E7
                BMI     loc_75E7
                DEC     $66,X
                BNE     loc_75D9          ;
  
loc_75E7:

                LDA     #0                ; Turn Fire Sound Off
  
loc_75E9:
                STA     $6A,X             ;
                RTS                       ;
; End of function sub_75CD
  
  
; ¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦ S U B R O U T I N E ¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦
  
  
sub_75EC:
                STX     $D                ;
                LDA     #$50
                STA     $2F9
                LDA     $200,Y
                AND     #$78              ;
                STA     $E
                LDA     $200,Y
                AND     #7
                LSR     A                 ;
                TAX     
                BEQ     loc_7605
                ORA     $E                ;
  
loc_7605:
                STA     $200,Y            ;
                LDA     $1C               ; Number Of Players In Current Game
                BEQ     loc_761D          ; None, Branch
                LDA     $D
                BEQ     loc_7614
                CMP     #4
                BCC     loc_761D          ;
  
loc_7614:
                LDA     $7659,X           ;
                LDX     $19
                CLC     
                JSR     sub_7397          ;
  
loc_761D:

                LDX     $200,Y            ;
                BEQ     loc_7656
                JSR     sub_745A
                BMI     loc_7656
                INC     $2F6              ;
                JSR     sub_6A9D
                JSR     sub_7203
                LDA     $223,X
                AND     #$1F              ;
                ASL     A
                EOR     $2AF,X
                STA     $2AF,X
                JSR     sub_745C          ;
                BMI     loc_7656
                INC     $2F6
                JSR     sub_6A9D
                JSR     sub_7203          ;
                LDA     $246,X
                AND     #$1F
                ASL     A
                EOR     $2D2,X            ;
                STA     $2D2,X            ;
  
loc_7656:

                LDX     $D                ;
                RTS                       ;
; End of function sub_75EC
  
; ---------------------------------------------------------------------------
                .BYTE  $10                ; 100 Points
                .BYTE    5                ; 50 Points
                .BYTE    2                ; 20 Points
  
; ¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦ S U B R O U T I N E ¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦
  
  
sub_765C:
                LDA     $1C               ; Number Of Players In Current Game
                BPL     locret_7698
                LDX     #2                ;
                STA     $5D               ; Slow Timer
                STA     $32
                STA     $33               ;
  
loc_7668:
                LDY     #0                ;
  
loc_766A:
                LDA     $1D,Y             ; High Score Table, Tens
                CMP     $52,X             ; Player Score, Tens
                LDA     $1E,Y             ; High Score Table, Thousands
                SBC     $53,X             ;
                BCC     loc_7699          ;
                INY     
                INY     
                CPY     #$14
                BCC     loc_766A          ;
  
loc_767C:
                DEX                       ;
                DEX     
                BPL     loc_7668
                LDA     $33
                BMI     loc_7692          ;
                CMP     $32
                BCC     loc_7692
                ADC     #2
                CMP     #$1E              ;
                BCC     loc_7690
                LDA     #$FF              ;
  
loc_7690:
                STA     $33               ;
  
loc_7692:

                LDA     #0                ;
                STA     $1C
                STA     $31
  
locret_7698:
                RTS                       ;
; ---------------------------------------------------------------------------
  
loc_7699:
                STX     $B                ;
                STY     $C
                TXA     
                LSR     A
                TAX                       ;
                TYA     
                LSR     A
                ADC     $C
                STA     $D                ;
                STA     $32,X
                LDX     #$1B
                LDY     #$12              ;
  
loc_76AC:
                CPX     $D                ;
                BEQ     loc_76CF
                LDA     $31,X
                STA     $34,X
                LDA     $32,X             ;
                STA     $35,X
                LDA     $33,X
                STA     $36,X
                LDA     $1B,Y             ;
                STA     $1D,Y
                LDA     $1C,Y
                STA     $1E,Y
                DEY                       ;
                DEY     
                DEX     
                DEX     
                DEX     
                BNE     loc_76AC          ;
  
loc_76CF:
                LDA     #$B               ;
                STA     $34,X
                LDA     #0
                STA     $35,X
                STA     $36,X
                LDA     #$F0              ;
                STA     $5D               ; Slow Timer
                LDX     $B
                LDY     $C
                LDA     $53,X             ; Players Score, Thousands
                STA     $1E,Y
                LDA     $52,X             ; Players Score, Tens
                STA     $1D,Y
                LDY     #0                ;
                BEQ     loc_767C
  
                .BYTE   $DF               ;
; ---------------------------------------------------------------------------
loc_76F0:
                TYA                       ;
                BPL     loc_76FC          ;
; End of function sub_765C

                JSR     sub_7708          ;
                JSR     loc_76FC
                JMP     sub_7708          ;
; ---------------------------------------------------------------------------

loc_76FC:

                TAY                       ;
                TXA     
                BPL     sub_770E
                JSR     sub_7708
                JSR     sub_770E
                EOR     #$80              ;
  
; ¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦ S U B R O U T I N E ¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦
  
  
sub_7708:

                EOR     #$FF              ;
                CLC     
                ADC     #1
                RTS                       ;
; End of function sub_7708
  
  
; ¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦ S U B R O U T I N E ¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦
  
  
sub_770E:

                STA     $C                ;
                TYA     
                CMP     $C
                BEQ     loc_7725
                BCC     sub_7728          ;
                LDY     $C
                STA     $C
                TYA     
                JSR     sub_7728          ;
                SEC     
                SBC     #$40
                JMP     sub_7708          ;
; ---------------------------------------------------------------------------
  
loc_7725:
                LDA     #$20              ;
                RTS     
; End of function sub_770E
  
  
; ¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦ S U B R O U T I N E ¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦
  
  
sub_7728:

                JSR     sub_776C          ;
                LDA     $772F,X
                RTS                       ;
; End of function sub_7728
  
; ---------------------------------------------------------------------------
                .BYTE    0  
                .BYTE    2  
                .BYTE    5  
                .BYTE    7  
                .BYTE   $A  
                .BYTE   $C  
                .BYTE   $F  
                .BYTE  $11  
                .BYTE  $13  
                .BYTE  $15  
                .BYTE  $17  
                .BYTE  $19  
                .BYTE  $1A  
                .BYTE  $1C  
                .BYTE  $1D  
                .BYTE  $1F  
  
; ¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦ S U B R O U T I N E ¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦
  
  
sub_773F:

                PHP                       ;
                STX     $17
                DEY     
                STY     $16
                CLC                       ;
                ADC     $16
                STA     $15
                PLP     
                TAX                       ;
  
loc_774C:
                PHP                       ;
                LDA     0,X
                LSR     A
                LSR     A
                LSR     A                 ;
                LSR     A
                PLP     
                JSR     sub_7785
                LDA     $16               ;
                BNE     loc_775C
                CLC                       ;
  
loc_775C:
                LDX     $15               ;
                LDA     0,X
                JSR     sub_7785
                DEC     $15
                LDX     $15               ;
                DEC     $16
                BPL     loc_774C
                RTS                       ;
; End of function sub_773F
  
  
; ¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦ S U B R O U T I N E ¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦
  
  
sub_776C:
                LDY     #0                ;
                STY     $B
                LDY     #4                ;
  
loc_7772:
                ROL     $B                ;
                ROL     A
                CMP     $C
                BCC     loc_777B          ;
                SBC     $C                ;
  
loc_777B:
                DEY                       ;
                BNE     loc_7772
                LDA     $B
                ROL     A
                AND     #$F               ;
                TAX     
                RTS                       ;
; End of function sub_776C
  
  
; ¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦ S U B R O U T I N E ¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦
  
  
sub_7785:

                BCC     sub_778B          ;
                AND     #$F
                BEQ     loc_77B2          ;
; End of function sub_7785
  
  
; ¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦ S U B R O U T I N E ¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦
  
  
sub_778B:

                LDX     $17               ;
                BEQ     loc_77B2
                AND     #$F
                CLC     
                ADC     #1                ;
                PHP     
                ASL     A
                TAY     
                LDA     $56D4,Y           ;
                ASL     A
                STA     $B
                LDA     $56D5,Y
                ROL     A                 ;
                AND     #$1F
                ORA     #$40
                STA     $C
                LDA     #0                ;
                STA     8
                STA     9
                JSR     sub_6AD7
                PLP                       ;
                RTS                       ;
; ---------------------------------------------------------------------------
  
loc_77B2:

                JMP     loc_7BCB          ;
; End of function sub_778B
  
  
; ¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦ S U B R O U T I N E ¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦
  
  
sub_77B5:

                ASL     $5F               ;
                ROL     $60
                BPL     loc_77BD
                INC     $5F               ;
  
loc_77BD:
                LDA     $5F               ;
                BIT     byte_77D1
                BEQ     loc_77C8          ;
                EOR     #1
                STA     $5F               ;
  
loc_77C8:
                ORA     $60               ;
                BNE     loc_77CE
                INC     $5F               ;
  
loc_77CE:
                LDA     $5F               ;
                RTS                       ;
; End of function sub_77B5

; ---------------------------------------------------------------------------
byte_77D1:      .BYTE 2
  
; ¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦ S U B R O U T I N E ¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦
  
  
sub_77D2:

                CLC                       ;
                ADC     #$40              ;
; End of function sub_77D2
  
  
; ¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦ S U B R O U T I N E ¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦
  
  
sub_77D5:

                BPL     sub_77DF          ;
                AND     #$7F
                JSR     sub_77DF
                JMP     sub_7708          ;
; End of function sub_77D5
  
  
; ¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦ S U B R O U T I N E ¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦
  
  
sub_77DF:

                CMP     #$41              ;
                BCC     loc_77E7
                EOR     #$7F
                ADC     #0                ;
  
loc_77E7:
                TAX                       ;
                LDA     $57B9,X
                RTS                       ;
; End of function sub_77DF
  
; ---------------------------------------------------------------------------
                .BYTE    0  
                .BYTE    0  
                .BYTE    0  
                .BYTE    0  
                .BYTE    0  
                .BYTE    0  
                .BYTE    0  
                .BYTE    0  
                .BYTE    0  
                .BYTE    0  
  
; ¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦ S U B R O U T I N E ¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦
  
  
sub_77F6:

                LDA     $2803             ; DIP Switches 1 & 2, Language
                AND     #3
                ASL     A
                TAX     
                LDA     #$10
                STA     0
                LDA     $7888,X           ; Address Of Message Offset Table
                STA     9
                LDA     $7887,X
                STA     8
                ADC     (8),Y             ; Add In The Offset To Get Starting
                STA     8                 ; Address Of Message
                BCC     loc_7813
                INC     9
  
loc_7813:
                TYA                       ;
                ASL     A
                TAY     
                LDA     $7871,Y
                LDX     $7872,Y           ;
                JSR     sub_7C03
                LDA     #$70
                JSR     sub_7CDE
                LDY     #0                ;
                LDX     #0                ;
  
loc_7828:
                LDA     (8,X)             ;
                STA     $B
                LSR     A
                LSR     A
                JSR     sub_784D          ;
                LDA     (8,X)
                ROL     A
                ROL     $B
                ROL     A                 ;
                LDA     $B
                ROL     A
                ASL     A
                JSR     sub_7853          ;
                LDA     (8,X)
                STA     $B
                JSR     sub_784D
                LSR     $B                ;
                BCC     loc_7828          ;
  
loc_7849:
                DEY                       ;
                JMP     sub_7C39          ;
; End of function sub_77F6
  
  
; ¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦ S U B R O U T I N E ¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦
  
  
sub_784D:

                INC     8                 ;
                BNE     sub_7853
                INC     9                 ;
; End of function sub_784D
  
  
; ¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦ S U B R O U T I N E ¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦
  
  
sub_7853:

                AND     #$3E              ;
                BNE     loc_785B
                PLA     
                PLA                       ;
                BNE     loc_7849          ;
  
loc_785B:
                CMP     #$A               ;
                BCC     loc_7861
                ADC     #$D               ;
  
loc_7861:
                TAX                       ;
                LDA     $56D2,X
                STA     (2),Y
                INY                       ;
                LDA     $56D3,X
                STA     (2),Y
                INY     
                LDX     #0                ;
                RTS                       ;
; End of function sub_7853
  
; ---------------------------------------------------------------------------
                .BYTE  $64
                .BYTE  $B6

                .BYTE  $64
                .BYTE  $B6

                .BYTE   $C
                .BYTE  $AA

                .BYTE   $C  
                .BYTE  $A2

                .BYTE   $C  
                .BYTE  $9A

                .BYTE   $C  
                .BYTE  $92

                .BYTE  $64
                .BYTE  $C6

                .BYTE  $64
                .BYTE  $9D

                .BYTE  $50
                .BYTE  $39

                .BYTE  $50
                .BYTE  $39

                .BYTE  $50
                .BYTE  $39


                .BYTE  $1E                ; English
                .BYTE  $57

                .BYTE  $8F
                .BYTE  $78

                .BYTE  $46
                .BYTE  $79

                .BYTE  $F3
                .BYTE  $79

                .BYTE   $B  
                .BYTE  $15  
                .BYTE  $1B  
                .BYTE  $35
                .BYTE  $4D
                .BYTE  $65
                .BYTE  $7F
                .BYTE  $8D
                .BYTE  $93
                .BYTE  $9F
                .BYTE  $AB

                .BYTE  $64
                .BYTE  $D2
                .BYTE  $3B
                .BYTE  $2E
                .BYTE  $C2
                .BYTE  $6C
                .BYTE  $5A
                .BYTE  $4C
                .BYTE  $93
                .BYTE  $6F
                .BYTE  $BD
                .BYTE  $1A  
                .BYTE  $4C
                .BYTE  $12  
                .BYTE  $B0
                .BYTE  $40
                .BYTE  $6B
                .BYTE  $2C
                .BYTE   $A  
                .BYTE  $6C
                .BYTE  $5A
                .BYTE  $4C
                .BYTE  $93
                .BYTE  $6E
                .BYTE   $B  
                .BYTE  $6E
                .BYTE  $C0
                .BYTE  $52
                .BYTE  $6C
                .BYTE  $92
                .BYTE  $B8
                .BYTE  $50
                .BYTE  $4D
                .BYTE  $82
                .BYTE  $F2
                .BYTE  $58
                .BYTE  $90
                .BYTE  $4C
                .BYTE  $4D
                .BYTE  $F0
                .BYTE  $4C
                .BYTE  $80
                .BYTE  $33
                .BYTE  $70
                .BYTE  $C2
                .BYTE  $42
                .BYTE  $5A
                .BYTE  $4C
                .BYTE  $4C
                .BYTE  $82
                .BYTE  $BB
                .BYTE  $52
                .BYTE   $B  
                .BYTE  $58
                .BYTE  $B2
                .BYTE  $42
                .BYTE  $6C
                .BYTE  $9A
                .BYTE  $C3
                .BYTE  $4A
                .BYTE  $82
                .BYTE  $64
                .BYTE   $A  
                .BYTE  $5A
                .BYTE  $90
                .BYTE    0  
                .BYTE  $F6
                .BYTE  $6C
                .BYTE    9  
                .BYTE  $B2
                .BYTE  $3B
                .BYTE  $2E
                .BYTE  $C1
                .BYTE  $4C
                .BYTE  $4C
                .BYTE  $B6
                .BYTE  $2B
                .BYTE  $20  
                .BYTE   $D  
                .BYTE  $A6
                .BYTE  $C1
                .BYTE  $70
                .BYTE  $48
                .BYTE  $50
                .BYTE  $B6
                .BYTE  $52
                .BYTE  $3B
                .BYTE  $D2
                .BYTE  $90
                .BYTE    0  
                .BYTE  $DA
                .BYTE  $64
                .BYTE  $90
                .BYTE  $4C
                .BYTE  $C9
                .BYTE  $D8
                .BYTE  $BE
                .BYTE   $A  
                .BYTE  $32
                .BYTE  $42
                .BYTE  $9B
                .BYTE  $C2
                .BYTE  $67
                .BYTE  $68
                .BYTE  $4D
                .BYTE  $AE
                .BYTE  $A1
                .BYTE  $4E
                .BYTE  $48
                .BYTE  $50
                .BYTE  $B6
                .BYTE  $52
                .BYTE  $3B
                .BYTE  $D2
                .BYTE  $90
                .BYTE    0  
                .BYTE  $BE
                .BYTE   $A  
                .BYTE  $B6
                .BYTE  $1E  
                .BYTE  $94
                .BYTE  $D2
                .BYTE  $A2
                .BYTE  $92
                .BYTE   $A  
                .BYTE  $2C
                .BYTE  $CA
                .BYTE  $4E
                .BYTE  $7A
                .BYTE  $65
                .BYTE  $BD
                .BYTE  $1A  
                .BYTE  $4C
                .BYTE  $12  
                .BYTE  $92
                .BYTE  $13  
                .BYTE  $18  
                .BYTE  $62
                .BYTE  $CA
                .BYTE  $64
                .BYTE  $F2
                .BYTE  $42
                .BYTE  $20  
                .BYTE  $6E
                .BYTE  $A3
                .BYTE  $52
                .BYTE  $82
                .BYTE  $40
                .BYTE  $18  
                .BYTE  $62
                .BYTE  $CA
                .BYTE  $64
                .BYTE  $F2
                .BYTE  $42
                .BYTE  $18
                .BYTE  $6E
                .BYTE  $A3
                .BYTE  $52
                .BYTE  $80
                .BYTE    0
                .BYTE  $20
                .BYTE  $62
                .BYTE  $CA
                .BYTE  $64
                .BYTE  $F2
                .BYTE  $64
                .BYTE    8
                .BYTE  $C2
                .BYTE  $BD
                .BYTE  $1A
                .BYTE  $4C
                .BYTE    0

                .BYTE   $B
                .BYTE  $15
                .BYTE  $19
                .BYTE  $31
                .BYTE  $41
                .BYTE  $57
                .BYTE  $73
                .BYTE  $7F
                .BYTE  $89
                .BYTE  $95
                .BYTE  $A1

                .BYTE  $8A
                .BYTE  $5A
                .BYTE  $84
                .BYTE  $12
                .BYTE  $CD
                .BYTE  $82
                .BYTE  $B9
                .BYTE  $E6
                .BYTE  $B2
                .BYTE  $40
                .BYTE  $74
                .BYTE  $F2
                .BYTE  $4D
                .BYTE  $83
                .BYTE  $D4
                .BYTE  $F0
                .BYTE  $B2
                .BYTE  $42
                .BYTE  $B9
                .BYTE  $E6
                .BYTE  $B2
                .BYTE  $42
                .BYTE  $4D
                .BYTE  $F0
                .BYTE   $E
                .BYTE  $64
                .BYTE   $A
                .BYTE  $12
                .BYTE  $B8
                .BYTE  $46
                .BYTE  $10
                .BYTE  $62
                .BYTE  $4B
                .BYTE  $60
                .BYTE  $82
                .BYTE  $72
                .BYTE  $B5
                .BYTE  $C0
                .BYTE  $BE
                .BYTE  $A8
                .BYTE   $A
                .BYTE  $64
                .BYTE  $C5
                .BYTE  $92
                .BYTE  $F0
                .BYTE  $74
                .BYTE  $9D
                .BYTE  $C2
                .BYTE  $6C
                .BYTE  $9A
                .BYTE  $C3
                .BYTE  $4A
                .BYTE  $82
                .BYTE  $6F
                .BYTE  $A4
                .BYTE  $F2
                .BYTE  $BD
                .BYTE  $D2
                .BYTE  $F0
                .BYTE  $6C
                .BYTE  $9E
                .BYTE   $A
                .BYTE  $C2
                .BYTE  $42
                .BYTE  $A4
                .BYTE  $F2
                .BYTE  $B0
                .BYTE  $74
                .BYTE  $9D
                .BYTE  $C2
                .BYTE  $6C
                .BYTE  $9A
                .BYTE  $C3
                .BYTE  $4A
                .BYTE  $82
                .BYTE  $6F
                .BYTE  $A4
                .BYTE  $F2
                .BYTE  $BD
                .BYTE  $D2
                .BYTE  $F0
                .BYTE  $58
                .BYTE  $ED
                .BYTE  $12
                .BYTE  $B5
                .BYTE  $E8
                .BYTE  $29
                .BYTE  $D2
                .BYTE   $D
                .BYTE  $72
                .BYTE  $2C
                .BYTE  $90
                .BYTE   $C
                .BYTE  $12
                .BYTE  $C6
                .BYTE  $2C
                .BYTE  $48
                .BYTE  $4E
                .BYTE  $9D
                .BYTE  $AC
                .BYTE  $49
                .BYTE  $F0
                .BYTE  $48
                .BYTE    0
                .BYTE  $2D
                .BYTE  $28
                .BYTE  $CF
                .BYTE  $52
                .BYTE  $B0
                .BYTE  $6E
                .BYTE  $CD
                .BYTE  $82
                .BYTE  $BE
                .BYTE   $A
                .BYTE  $B6
                .BYTE    0
                .BYTE  $53
                .BYTE  $64
                .BYTE   $A
                .BYTE  $12
                .BYTE   $D
                .BYTE   $A
                .BYTE  $B6
                .BYTE  $1A
                .BYTE  $48
                .BYTE    0
                .BYTE  $18
                .BYTE  $68
                .BYTE  $6A
                .BYTE  $4E
                .BYTE  $48
                .BYTE  $48
                .BYTE   $B
                .BYTE  $A6
                .BYTE  $CA
                .BYTE  $72
                .BYTE  $B5
                .BYTE  $C0
                .BYTE  $18
                .BYTE  $68
                .BYTE  $6A
                .BYTE  $4E
                .BYTE  $48
                .BYTE  $46
                .BYTE   $B
                .BYTE  $A6
                .BYTE  $CA
                .BYTE  $72
                .BYTE  $B0
                .BYTE    0
                .BYTE  $20
                .BYTE  $68
                .BYTE  $6A
                .BYTE  $4E
                .BYTE  $4D
                .BYTE  $C2
                .BYTE  $18
                .BYTE  $5C
                .BYTE  $9E
                .BYTE  $52
                .BYTE  $CD
                .BYTE  $80

                .BYTE   $B
                .BYTE  $11
                .BYTE  $17
                .BYTE  $31
                .BYTE  $45
                .BYTE  $5F
                .BYTE  $6B
                .BYTE  $73
                .BYTE  $7D
                .BYTE  $89
                .BYTE  $93

                .BYTE  $B2
                .BYTE  $4E
                .BYTE  $9D
                .BYTE  $90
                .BYTE  $B8
                .BYTE    0
                .BYTE  $76
                .BYTE  $56
                .BYTE  $2A
                .BYTE  $26
                .BYTE  $B0
                .BYTE  $40
                .BYTE  $BE
                .BYTE  $42
                .BYTE  $A6
                .BYTE  $64
                .BYTE  $C1
                .BYTE  $5C
                .BYTE  $48
                .BYTE  $52
                .BYTE  $BE
                .BYTE   $A
                .BYTE   $A
                .BYTE  $64
                .BYTE  $C5
                .BYTE  $92
                .BYTE   $C
                .BYTE  $26
                .BYTE  $B8
                .BYTE  $50
                .BYTE  $6A
                .BYTE  $7C
                .BYTE   $C
                .BYTE  $52
                .BYTE  $74
                .BYTE  $EC
                .BYTE  $4D
                .BYTE  $C0
                .BYTE  $A4
                .BYTE  $EC
                .BYTE   $A
                .BYTE  $8A
                .BYTE  $D4
                .BYTE  $EC
                .BYTE   $A
                .BYTE  $64
                .BYTE  $C5
                .BYTE  $92
                .BYTE   $D
                .BYTE  $F2
                .BYTE  $B8
                .BYTE  $5A
                .BYTE  $93
                .BYTE  $4E
                .BYTE  $69
                .BYTE  $60
                .BYTE  $4D
                .BYTE  $C0
                .BYTE  $9D
                .BYTE  $2C
                .BYTE  $6C
                .BYTE  $4A
                .BYTE   $D
                .BYTE  $A6
                .BYTE  $C1
                .BYTE  $70
                .BYTE  $48
                .BYTE  $68
                .BYTE  $2D
                .BYTE  $8A
                .BYTE   $D
                .BYTE  $D2
                .BYTE  $82
                .BYTE  $4E
                .BYTE  $3B
                .BYTE  $66
                .BYTE  $91
                .BYTE  $6C
                .BYTE   $C
                .BYTE   $A
                .BYTE   $C
                .BYTE  $12
                .BYTE  $C5
                .BYTE  $8B
                .BYTE  $9D
                .BYTE  $2C
                .BYTE  $6C
                .BYTE  $4A
                .BYTE   $B
                .BYTE  $3A
                .BYTE  $A2
                .BYTE  $6C
                .BYTE  $BD
                .BYTE   $A
                .BYTE  $3A
                .BYTE  $40
                .BYTE  $A6
                .BYTE  $60
                .BYTE  $B9
                .BYTE  $6C
                .BYTE   $D
                .BYTE  $F0
                .BYTE  $2D
                .BYTE  $B1
                .BYTE  $76
                .BYTE  $52
                .BYTE  $5C
                .BYTE  $C2
                .BYTE  $C2
                .BYTE  $6C
                .BYTE  $8B
                .BYTE  $64
                .BYTE  $2A
                .BYTE  $27
                .BYTE  $18
                .BYTE  $54
                .BYTE  $69
                .BYTE  $D8
                .BYTE  $28
                .BYTE  $48
                .BYTE   $B
                .BYTE  $B2
                .BYTE  $4A
                .BYTE  $E6
                .BYTE  $B8
                .BYTE    0
                .BYTE  $18
                .BYTE  $54
                .BYTE  $69
                .BYTE  $D8
                .BYTE  $28
                .BYTE  $46
                .BYTE   $B
                .BYTE  $B2
                .BYTE  $4A
                .BYTE  $E7
                .BYTE  $20
                .BYTE  $54
                .BYTE  $69
                .BYTE  $D8
                .BYTE  $2D
                .BYTE  $C2
                .BYTE  $18
                .BYTE  $5C
                .BYTE  $CA
                .BYTE  $56
                .BYTE  $98
                .BYTE    0
                .BYTE  $52


; ¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦ S U B R O U T I N E ¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦
  
  
sub_7A93:
                LDX     #2
  
loc_7A95:
                LDA     $2400,X           ; Coin Switch
                ASL     A                 ; Shift High Bit To Carry
                LDA     $7A,X
                AND     #$1F              ; 00011111
                BCC     loc_7AD6          ; No Coin For This Slot, Branch
                BEQ     loc_7AB1
                CMP     #$1B
                BCS     loc_7AAF          ;
                TAY     
                LDA     $5E
                AND     #7
                CMP     #7                ;
                TYA     
                BCC     loc_7AB1          ;
  
loc_7AAF:
                SBC     #1                ;
  
loc_7AB1:

                STA     $7A,X             ;
                LDA     $2006             ; Slam Switch
                AND     #$80              ;
                BEQ     loc_7ABE          ; Valid Coin, Branch
                LDA     #$F0              ; Flag Ill Gotten Gain
                STA     $72               ; Into Slam Switch Flag
  
loc_7ABE:
                LDA     $72               ; Honest Coin?
                BEQ     loc_7ACA          ; Yes, Branch
                DEC     $72
                LDA     #0
                STA     $7A,X
                STA     $77,X             ;
  
loc_7ACA:
                CLC                       ;
                LDA     $77,X
                BEQ     loc_7AF2
                DEC     $77,X             ;
                BNE     loc_7AF2
                SEC                       ;
                BCS     loc_7AF2          ;
  
loc_7AD6:
                CMP     #$1B              ;
                BCS     loc_7AE3
                LDA     $7A,X             ;
                ADC     #$20
                BCC     loc_7AB1
                BEQ     loc_7AE3          ;
                CLC     
  
loc_7AE3:

                LDA     #$1F              ;
                BCS     loc_7AB1
                STA     $7A,X             ;
                LDA     $77,X
                BEQ     loc_7AEE
                SEC                       ;
  
loc_7AEE:
                LDA     #$78              ;
                STA     $77,X             ;
  
loc_7AF2:

                BCC     loc_7B17          ;
                LDA     #0                ;
                CPX     #1                ;
                BCC     loc_7B10          ;
                BEQ     loc_7B08          ;
                LDA     $71               ; DIP Switch Bitmap
                AND     #$C               ; Mask Off Switches 5 & 6, Right Coin Slot Multiplier
                LSR     A                 ;
                LSR     A                 ;
                BEQ     loc_7B10          ; x1, Branch
                ADC     #2                ; 2 + Set Bits From Settings = Total Coins After Multiplier
                BNE     loc_7B10          ; Will Always Branch
  
loc_7B08:
                LDA     $71               ;
                AND     #$10              ;
                BEQ     loc_7B10          ;
                LDA     #1                ;
  
loc_7B10:

                SEC                       ; Set Carry, This Will Add 1 To The Total
                ADC     $73               ;
                STA     $73               ;
                INC     $74,X             ;
  
loc_7B17:
                DEX     
                BMI     loc_7B1D          ;
                JMP     loc_7A95          ;
; ---------------------------------------------------------------------------
  
loc_7B1D:
                LDA     $71               ; DIP Switch Settings
                AND     #3                ; Mask Off Switches 7 & 8, Coins Per Play
                TAY                       ;
                BEQ     loc_7B36          ; Free Play, Branch
                LSR     A                 ;
                ADC     #0                ;
                EOR     #$FF
                SEC     
                ADC     $73               ;
                BCC     loc_7B38
                CPY     #2
                BCS     loc_7B34
                INC     $70               ; Add Credit
  
loc_7B34:
                INC     $70               ; Add Credit
  
loc_7B36:
                STA     $73               ;
  
loc_7B38:
                LDA     $5E               ;
                LSR     A
                BCS     locret_7B64
                LDY     #0
                LDX     #2                ;
  
loc_7B41:
                LDA     $74,X             ;
                BEQ     loc_7B4E
                CMP     #$10
                BCC     loc_7B4E
                ADC     #$EF              ;
                INY     
                STA     $74,X             ;
  
loc_7B4E:

                DEX                       ;
                BPL     loc_7B41
                TYA     
                BNE     locret_7B64
                LDX     #2                ;
  
loc_7B56:
                LDA     $74,X             ;
                BEQ     loc_7B61
                CLC     
                ADC     #$EF
                STA     $74,X             ;
                BMI     locret_7B64       ;
  
loc_7B61:
                DEX                       ;
                BPL     loc_7B56          ;
  
locret_7B64:

                RTS                       ;
; End of function sub_7A93
  
; ---------------------------------------------------------------------------
                PHA                       ;
                TYA     
                PHA     
                TXA     
                PHA                       ;
                CLD     
                LDA     $1FF              ; Stack Space!
                ORA     $1D0              ;
  
loc_7B71:
                BNE     loc_7B71          ; Endless Loop! Watchdog Will Time Out
                INC     $5E               ;
                LDA     $5E               ;
                AND     #3                ;
                BNE     loc_7B83
                INC     $5B               ;
                LDA     $5B
                CMP     #4                ;
  
loc_7B81:
                BCS     loc_7B81          ; Endless Loop! Watchdog Will Time Out
  
loc_7B83:
                JSR     sub_7A93          ;
                LDA     $6F
                AND     #$C7
                BIT     $74
                BPL     loc_7B90          ;
                ORA     #8
  
loc_7B90:
                BIT     $75               ;
                BPL     loc_7B96
                ORA     #$10              ;
  
loc_7B96:
                BIT     $76               ;
                BPL     loc_7B9C
                ORA     #$20              ;
  
loc_7B9C:
                STA     $6F               ;
                STA     $3200             ;
                LDA     $72               ; Slam Switch Flag
                BEQ     loc_7BA9          ; Branch If Not Set
                LDA     #$80              ; Gonna Make Noise To Let 'Em Know They've Been Caught!
                BNE     loc_7BB7          ; Will Always Branch
  
loc_7BA9:
                LDA     $68               ; Bonus Ship Sound Timer
                BEQ     loc_7BB7          ;
                LDA     $5C               ; Fast Timer
                ROR     A
                BCC     loc_7BB4          ;
                DEC     $68
  
loc_7BB4:
                ROR     A                 ;
                ROR     A
                ROR     A
  
loc_7BB7:

                STA     $3C05             ; Life Sound
                PLA     
                TAX     
                PLA     
                TAY                       ;
                PLA     
                RTI     
  
; ¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦ S U B R O U T I N E ¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦
  
  
sub_7BC0:

                LDA     #$B0
                LDY     #0
                STA     (2),Y
                INY     
                STA     (2),Y
                BNE     sub_7C39
  
loc_7BCB:
                BCC     sub_7BD1
                AND     #$F
                BEQ     loc_7BD6
; End of function sub_7BC0
  
  
; ¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦ S U B R O U T I N E ¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦
  
  
sub_7BD1:

                AND     #$F
                CLC     
                ADC     #1
  
loc_7BD6:
                PHP     
                ASL     A
                LDY     #0
                TAX     
                LDA     $56D4,X
                STA     (2),Y
                LDA     $56D5,X
                INY     
                STA     (2),Y
                JSR     sub_7C39
                PLP     
                RTS     
; End of function sub_7BD1
  
; ---------------------------------------------------------------------------
                .BYTE  $4A
                .BYTE  $29
                .BYTE   $F
                .BYTE    9
                .BYTE  $E0
; ---------------------------------------------------------------------------
  
loc_7BF0:
                LDY     #1
                STA     (2),Y
                DEY     
                TXA     
                ROR     A
                STA     (2),Y
                INY     
                BNE     sub_7C39
  
; ¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦ S U B R O U T I N E ¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦
  
  
sub_7BFC:

                LSR     A
                AND     #$F
                ORA     #$C0
                BNE     loc_7BF0
; End of function sub_7BFC
  
  
; ¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦ S U B R O U T I N E ¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦
  
  
sub_7C03:

                LDY     #0
                STY     5
                STY     7
                ASL     A
                ROL     5
                ASL     A
                ROL     5
                STA     4
                TXA     
                ASL     A
                ROL     7
                ASL     A
                ROL     7
                STA     6
                LDX     #4
; End of function sub_7C03
  
  
; ¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦ S U B R O U T I N E ¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦
  
  
sub_7C1C:
                LDA     2,X
                LDY     #0
                STA     (2),Y
                LDA     3,X
                AND     #$F
                ORA     #$A0
                INY     
                STA     (2),Y
                LDA     0,X
                INY     
                STA     (2),Y
                LDA     1,X
                AND     #$F
                ORA     0
                INY     
                STA     (2),Y
; End of function sub_7C1C
  
  
; ¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦ S U B R O U T I N E ¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦
  
  
sub_7C39:

                TYA     
                SEC     
                ADC     2
                STA     2
                BCC     locret_7C43
                INC     3
  
locret_7C43:
                RTS     
; End of function sub_7C39
  
; ---------------------------------------------------------------------------
                .BYTE  $A9
                .BYTE  $D0
                .BYTE  $4C
                .BYTE  $C2
                .BYTE  $7B
  
; ¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦ S U B R O U T I N E ¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦
  
  
sub_7C49:
                LDA     5
                CMP     #$80
                BCC     loc_7C60
                EOR     #$FF
                STA     5
                LDA     4
                EOR     #$FF
                ADC     #0
                STA     4
                BCC     loc_7C5F
                INC     5
  
loc_7C5F:
                SEC     
  
loc_7C60:
                ROL     8
                LDA     7
                CMP     #$80
                BCC     loc_7C79
                EOR     #$FF
                STA     7
                LDA     6
                EOR     #$FF
                ADC     #0
                STA     6
                BCC     loc_7C78
                INC     7
  
loc_7C78:
                SEC     
  
loc_7C79:
                ROL     8
                LDA     5
                ORA     7
                BEQ     loc_7C8B
                LDX     #0
                CMP     #2
                BCS     loc_7CAB
                LDY     #1
                BNE     loc_7C9B
  
loc_7C8B:
                LDY     #2
                LDX     #9
                LDA     4
                ORA     6
                BEQ     loc_7CAB
                BMI     loc_7C9B
  
loc_7C97:
                INY     
                ASL     A
                BPL     loc_7C97
  
loc_7C9B:

                TYA     
                TAX     
                LDA     5
  
loc_7C9F:
                ASL     4
                ROL     A
                ASL     6
                ROL     7
                DEY     
                BNE     loc_7C9F
                STA     5
  
loc_7CAB:

                TXA     
                SEC     
                SBC     #$A
                EOR     #$FF
                ASL     A
                ROR     8
                ROL     A
                ROR     8
                ROL     A
                ASL     A
                STA     8
                LDY     #0
                LDA     6
                STA     (2),Y
                LDA     8
                AND     #$F4
                ORA     7
                INY     
                STA     (2),Y
                LDA     4
                INY     
                STA     (2),Y
                LDA     8
                AND     #2
                ASL     A
                ORA     1
                ORA     5
                INY     
                STA     (2),Y
                JMP     sub_7C39
; End of function sub_7C49
  
  
; ¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦ S U B R O U T I N E ¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦
  
  
sub_7CDE:

                LDX     #0
; End of function sub_7CDE
  
  
; ¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦ S U B R O U T I N E ¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦
  
  
sub_7CE0:

                LDY     #1
                STA     (2),Y
                DEY     
                TYA     
                STA     (2),Y
                INY     
                INY     
                STA     (2),Y
                INY     
                TXA     
                STA     (2),Y
                JMP     sub_7C39
; End of function sub_7CE0
  
; ---------------------------------------------------------------------------
  
;<EditorTab name="main">
main:
                LDX     #$FE
                TXS     
                CLD     
                LDA     #0
                TAX     
  
loc_7CFA:
                DEX     
                STA     $300,X
                STA     $200,X
                STA     $100,X
                STA     0,X
                BNE     loc_7CFA          ;
                LDY     $2007             ; Self test switch
                BMI     loc_7D50
                INX     
                STX     $4000
                LDA     #$E2
                STA     $4001
                LDA     #$B0
                STA     $4003
                STA     $32
                STA     $33
                LDA     #3
                STA     $6F
                STA     $3200
                AND     $2800             ; DIP switches 8 & 7: # Of Coins For Play
                STA     $71
                LDA     $2801             ; DIP switches 6 & 5: Coin Multiplier, Right Slot
                AND     #3
                ASL     A
                ASL     A
                ORA     $71
                STA     $71
                LDA     $2802             ; DIP switches 4 & 3: 3 - # Of Starting Ships
                AND     #2                ; 4 - Coin Multiplier Center/Left Slot
                ASL     A
                ASL     A
                ASL     A
                ORA     $71
                STA     $71
                JMP     loc_6803
;</EditorTab>
  
; ¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦ S U B R O U T I N E ¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦
  
  
sub_7D45:

                LDY     #0
                STA     (2),Y
                INY     
                TXA     
                STA     (2),Y
                JMP     sub_7C39
; End of function sub_7D45
  
; ---------------------------------------------------------------------------
  
loc_7D50:

                STA     $4000,X
                STA     $4100,X
                STA     $4200,X
                STA     $4300,X
                STA     $4400,X
                STA     $4500,X
                STA     $4600,X
                STA     $4700,X
                INX     
                BNE     loc_7D50
                STA     $3400
                LDX     #0
  
loc_7D70:
                LDA     0,X
                BNE     loc_7DBB
                LDA     #$11
  
loc_7D76:
                STA     0,X
                TAY     
                EOR     0,X
                BNE     loc_7DBB
                TYA     
                ASL     A
                BCC     loc_7D76
                INX     
                BNE     loc_7D70
                STA     $3400
                TXA     
                STA     0
                ROL     A
  
loc_7D8B:
                STA     1
                LDY     #0
  
loc_7D8F:

                LDX     #$11
                LDA     (0),Y
                BNE     loc_7DBF
  
loc_7D95:
                TXA     
                STA     (0),Y
                EOR     (0),Y
                BNE     loc_7DBF
                TXA     
                ASL     A
                TAX     
                BCC     loc_7D95
                INY     
                BNE     loc_7D8F
                STA     $3400
                INC     1
                LDX     1
                CPX     #4
                BCC     loc_7D8F
                LDA     #$40
                CPX     #$40
                BCC     loc_7D8B
                CPX     #$48
                BCC     loc_7D8F
                BCS     loc_7E24
  
loc_7DBB:

                LDY     #0
                BEQ     loc_7DCD
  
loc_7DBF:

                LDY     #0
                LDX     1
                CPX     #4
                BCC     loc_7DCD
                INY     
                CPX     #$44
                BCC     loc_7DCD
                INY     
  
loc_7DCD:

                CMP     #$10
                ROL     A
                AND     #$1F
                CMP     #2
                ROL     A
                AND     #3
  
loc_7DD7:
                DEY     
                BMI     loc_7DDE
                ASL     A
                ASL     A
                BCC     loc_7DD7
  
loc_7DDE:

                LSR     A
                LDX     #$14
                BCC     loc_7DE5
                LDX     #$1D
  
loc_7DE5:
                STX     $3A00
                LDX     #0
                LDY     #8
  
loc_7DEC:

                BIT     $2001
                BPL     loc_7DEC
  
loc_7DF1:
                BIT     $2001
                BMI     loc_7DF1
                DEX     
                STA     $3400
                BNE     loc_7DEC
                DEY     
                BNE     loc_7DEC
                STX     $3A00
                LDY     #8
  
loc_7E04:

                BIT     $2001
                BPL     loc_7E04
  
loc_7E09:
                BIT     $2001
                BMI     loc_7E09
                DEX     
                STA     $3400
                BNE     loc_7E04
                DEY     
                BNE     loc_7E04
                TAX     
                BNE     loc_7DDE
  
loc_7E1A:
                STA     $3400
                LDA     $2007
                BMI     loc_7E1A
  
loc_7E22:
                BPL     loc_7E22
  
loc_7E24:
                LDA     #0
                TAY     
                TAX     
                STA     8
                LDA     #$50
  
loc_7E2C:

                STA     9
                LDA     #4
                STA     $B
                LDA     #$FF
  
loc_7E34:

                EOR     (8),Y
                INY     
                BNE     loc_7E34
                INC     9
                DEC     $B
                BNE     loc_7E34
                STA     $D,X
                INX     
                STA     $3400
                LDA     9
                CMP     #$58
                BCC     loc_7E2C
                BNE     loc_7E4F
                LDA     #$68
  
loc_7E4F:
                CMP     #$80
                BCC     loc_7E2C
                STA     $300
                LDX     #4
                STX     $3200
                STX     $15
                LDX     #0
                CMP     $200
                BEQ     loc_7E65
                INX     
  
loc_7E65:
                LDA     $300
                CMP     #$88
                BEQ     loc_7E6D
                INX     
  
loc_7E6D:
                STX     $16
                LDA     #$10
                STA     0
  
loc_7E73:
                LDX     #$24
  
loc_7E75:

                LDA     $2001
                BPL     loc_7E75
  
loc_7E7A:
                LDA     $2001
                BMI     loc_7E7A
                DEX     
                BPL     loc_7E75
  
loc_7E82:
                BIT     $2002
                BMI     loc_7E82
                STA     $3400
                LDA     #0
                STA     2
                LDA     #$40
                STA     3
                LDA     $2005
                BPL     loc_7EF2
                LDX     $15
                LDA     $2003
                BPL     loc_7EA8
                ;EOR     $0009
                .BYTE   $4D,$09,$00
                BPL     loc_7EA8
                DEX     
                BEQ     loc_7EA8
                STX     $15
  
loc_7EA8:

                LDY     $7EBB,X
                LDA     #$B0
                STA     (2),Y
                DEY     
                DEY     
  
loc_7EB1:
                LDA     $7EC0,Y
                STA     (2),Y
                DEY     
                BPL     loc_7EB1
                JMP     loc_7F9D
; ---------------------------------------------------------------------------
                .BYTE  $33
                .BYTE  $1D
                .BYTE  $17
                .BYTE   $D
                .BYTE  $80
                .BYTE  $A0
                .BYTE    0
                .BYTE    0
                .BYTE    0
                .BYTE  $70
                .BYTE    0
                .BYTE    0
                .BYTE  $FF
                .BYTE  $92
                .BYTE  $FF
                .BYTE  $73
                .BYTE  $D0
                .BYTE  $A1
                .BYTE  $30
                .BYTE    2
                .BYTE    0
                .BYTE  $70
                .BYTE    0
                .BYTE    0
                .BYTE  $7F
                .BYTE  $FB
                .BYTE   $D
                .BYTE  $E0
                .BYTE    0
                .BYTE  $B0
                .BYTE  $7E
                .BYTE  $FA
                .BYTE  $11
                .BYTE  $C0
                .BYTE  $78
                .BYTE  $FE
                .BYTE    0
                .BYTE  $B0
                .BYTE  $13
                .BYTE  $C0
                .BYTE    0
                .BYTE  $D0
                .BYTE  $15
                .BYTE  $C0
                .BYTE    0
                .BYTE  $D0
                .BYTE  $17
                .BYTE  $C0
                .BYTE    0
                .BYTE  $D0
                .BYTE  $7A
                .BYTE  $F8
                .BYTE    0
                .BYTE  $D0
; ---------------------------------------------------------------------------
  
loc_7EF2:
                LDA     #$50
                LDX     #0
                JSR     sub_7BFC
                LDA     #$69
                LDX     #$93
                JSR     sub_7C03
                LDA     #$30
                JSR     sub_7CDE
                LDX     #3
  
loc_7F07:
                LDA     $2800,X
                AND     #1
                STX     $B
                JSR     sub_7BD1
                LDX     $B
                LDA     $2800,X
                AND     #2
                LSR     A
                JSR     sub_7BD1
                LDX     $B
                DEX     
                BPL     loc_7F07
                LDA     #$7A
                LDX     #$9D
                JSR     sub_7C03
                LDA     #$10
                JSR     sub_7CDE
                LDA     $2802
                AND     #2
                LSR     A
                ADC     #1
                JSR     sub_7BD1
                LDA     $2801
                AND     #3
                TAX     
                LDA     $7FF5,X
                JSR     sub_7BD1
                LDA     $16
                BEQ     loc_7F4F
                LDX     #$88
                LDA     #$50
                JSR     sub_7BFC
  
loc_7F4F:
                LDX     #$96
                ; STX     $C
                .byte   $8E,$C,$00
                LDX     #7
  
loc_7F56:
                LDA     $D,X
                BEQ     loc_7F91
                PHA     
                ;STX     $B
                .byte   $8E,$B,$00
                ;LDX     $C
                .byte   $AE,$C,$00                
                TXA     
                SEC     
                SBC     #8
                ;STA     $C
                .byte   $8D,$0C,$00
                LDA     #$20
                JSR     sub_7C03
                LDA     #$70
                JSR     sub_7CDE
                ;LDA     $B
                .byte   $AD,$0B,$00
                JSR     sub_7BD1
                LDA     $56D4
                LDX     $56D5
                JSR     sub_7D45
                PLA     
                PHA     
                LSR     A
                LSR     A
                LSR     A
                LSR     A
                JSR     sub_7BD1
                PLA     
                JSR     sub_7BD1
                ;LDX     $B
                .byte   $AE,$0B,$ 00
  
loc_7F91:
                DEX     
                BPL     loc_7F56
                LDA     #$7F
                TAX     
                JSR     sub_7C03
                JSR     sub_7BC0
  
loc_7F9D:
                LDA     #0
                LDX     #4
  
loc_7FA1:
                ROL     $2003,X
                ROR     A
                DEX     
                BPL     loc_7FA1
                TAY     
                LDX     #7
  
loc_7FAB:
                ROL     $2400,X
                ROL     A
                DEX     
                BPL     loc_7FAB
                TAX     
                EOR     8
                STX     8
                PHP     
                LDA     #4
                STA     $3200
                ROL     $2003
                ROL     A
                ROL     $2004
                ROL     A
                ROL     $2407
                ROL     A
                ROL     $2406
                ROL     A
                ROL     $2405
                ROL     A
                TAX     
                PLP     
                BNE     loc_7FDE
                EOR     $A
                BNE     loc_7FDE
                TYA     
                EOR     9
                BEQ     loc_7FE0
  
loc_7FDE:

                LDA     #$80
  
loc_7FE0:
                STA     $3C05
                STA     $3200
                STA     $3000
                STX     $A
                STY     9
                LDA     $2007
  
loc_7FF0:
                BPL     loc_7FF0
                JMP     loc_7E73
; ---------------------------------------------------------------------------
                .BYTE    1
                .BYTE    4
                .BYTE    5
                .BYTE    6
                .BYTE  $4E

                .BYTE  $65                ; NMI
                .BYTE  $7B

                .WORD  main               ; RESET

                .BYTE  $F3                ; IRQ
                .BYTE  $7C
; end of 'ROM'
  
                .END

