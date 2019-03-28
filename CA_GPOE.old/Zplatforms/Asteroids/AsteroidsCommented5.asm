                  ; ---------------------------------------------------------------------------
                  ; File Name   : C:\asteroid\CombinedRoms.bin
                  ; Format      : Binary File
                  ; Base Address: 0000h Range: 6800h - 8000h Loaded length: 1800h
                  ;
                  ; Processor:        M6502
                  ; Target assembler: SVENSON ELECTRONICS 6502/65C02 ASSEMBLER - V.1.0 - MAY, 1988
                  ; ---------------------------------------------------------------------------
                  ; NOTE: This code is property of Atari Inc. All requests from said company to remove
                  ; This code from public display will be honored
                  ; Disassembly By Lonnie Howell     displacer1@excite.com
                  ; Updated 10/8/04

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


6800              ; Segment type: Pure code
6800                              ;.segment ROM
6800                              * =  $6800
6800 4C F3 7C                     JMP     loc_7CF3
6803                
6803              loc_6803:
6803
6803 20 FA 6E                     JSR     sub_6EFA          ; Reset Sound, Zero Out Sound Timers
6806 20 D8 6E                     JSR     sub_6ED8          ; Number Of Starting Ships To $56 And Zero
6809                                                        ; Out Players Scores *BUG*
6809              loc_6809:
6809 20 68 71                     JSR     sub_7168          ;
680C                
680C              loc_680C:
680C
680C AD 07 20                     LDA     $2007             ; Self test switch
680F                
680F              loc_680F:
680F 30 FE                        BMI     loc_680F          ; Branch If Switch Is On
6811 46 5B                        LSR     $5B               ;
6813 90 F7                        BCC     loc_680C          ;
6815                
6815              loc_6815:
6815 AD 02 20                     LDA     $2002             ; HALT
6818 30 FB                        BMI     loc_6815          ; Wait For State Machine To Finish
681A AD 01 40                     LDA     $4001             ;
681D 49 02                        EOR     #2                ;
681F 8D 01 40                     STA     $4001             ;
6822 8D 00 30                     STA     $3000             ; DMAGO
6825 8D 00 34                     STA     $3400             ; Reset WatchDog
6828 E6 5C                        INC     $5C               ; Update Fast Timer
682A D0 02                        BNE     loc_682E          ;
682C E6 5D                        INC     $5D               ; Update Slow Timer
682E                
682E              loc_682E:
682E A2 40                        LDX     #$40              ;
6830 29 02                        AND     #2                ;
6832 D0 02                        BNE     loc_6836          ;
6834 A2 44                        LDX     #$44              ;
6836                
6836              loc_6836:
6836 A9 02                        LDA     #2                ;
6838 85 02                        STA     2                 ;
683A 86 03                        STX     3                 ;
683C 20 85 68                     JSR     sub_6885          ;
683F B0 C2                        BCS     loc_6803          ;
6841 20 5C 76                     JSR     sub_765C          ;
6844 20 90 6D                     JSR     sub_6D90          ;
6847 10 1B                        BPL     loc_6864          ;
6849 20 C4 73                     JSR     sub_73C4          ;
684C B0 16                        BCS     loc_6864          ;
684E A5 5A                        LDA     $5A               ;
6850 D0 0C                        BNE     loc_685E          ;
6852 20 D7 6C                     JSR     sub_6CD7          ;
6855 20 74 6E                     JSR     sub_6E74          ;
6858 20 3F 70                     JSR     sub_703F          ;
685B 20 93 6B                     JSR     sub_6B93          ;
685E                
685E              loc_685E:
685E 20 57 6F                     JSR     sub_6F57          ;
6861 20 F0 69                     JSR     sub_69F0          ;
6864                
6864              loc_6864:
6864
6864 20 4F 72                     JSR     sub_724F          ;
6867 20 55 75                     JSR     sub_7555          ;
686A A9 7F                        LDA     #$7F              ;
686C AA                           TAX                       ;
686D 20 03 7C                     JSR     sub_7C03          ;
6870 20 B5 77                     JSR     sub_77B5          ;
6873 20 C0 7B                     JSR     sub_7BC0          ;
6876 AD FB 02                     LDA     $2FB              ;
6879 F0 03                        BEQ     loc_687E          ;
687B CE FB 02                     DEC     $2FB              ;
687E                
687E              loc_687E:
687E 0D F6 02                     ORA     $2F6              ;
6881 D0 89                        BNE     loc_680C          ;
6883 F0 84                        BEQ     loc_6809          ;
6885                
6885              ; ��������������� S U B R O U T I N E ���������������������������������������
6885                
6885                
6885              sub_6885:
6885 A5 1C                        LDA     $1C               ; Number Of Players In Current Game
6887 F0 14                        BEQ     loc_689D          ; None, Branch
6889 A5 5A                        LDA     $5A               ;
688B D0 03                        BNE     loc_6890          ;
688D 4C 60 69                     JMP     loc_6960          ;
6890              ; ---------------------------------------------------------------------------
6890                
6890              loc_6890:
6890 C6 5A                        DEC     $5A               ;
6892 20 E2 69                     JSR     sub_69E2          ;
6895                
6895              loc_6895:
6895 18                           CLC                       ;
6896 60                           RTS                       ;
6897              ; ---------------------------------------------------------------------------
6897                
6897              loc_6897:
6897 A9 02                        LDA     #2                ; Free Credits!
6899 85 70                        STA     $70               ; Can Only Play A 2 Player Game, So Only Need To Add 2
689B D0 13                        BNE     loc_68B0          ; Credits For Free Play
689D                
689D              loc_689D:
689D A5 71                        LDA     $71               ; DIP Switch Settings Bitmap
689F 29 03                        AND     #3                ; Mask Off Settings For Switches 8 & 7
68A1 F0 F4                        BEQ     loc_6897          ; Check For Free Play, Branch If Yes
68A3 18                           CLC                       ;
68A4 69 07                        ADC     #7                ; Determine Which Message To Display Based On DIP Settings
68A6 A8                           TAY                       ; Into Y For The Offset
68A6                                                        ; Y = 8, "1 COIN 2 PLAYS"
68A6                                                        ; Y = 9, "1 COIN 1 PLAY"
68A6                                                        ; Y = A, "2 COINS 1 PLAY"
68A7 A5 32                        LDA     $32               ;
68A9 25 33                        AND     $33               ;
68AB 10 03                        BPL     loc_68B0          ;
68AD 20 F6 77                     JSR     sub_77F6          ; And Draw It To Screen
68B0                
68B0              loc_68B0:
68B0
68B0 A4 70                        LDY     $70               ; Current Number Of Credits
68B2 F0 E1                        BEQ     loc_6895          ; No Credits, Branch
68B4 A2 01                        LDX     #1                ; Assume 1 Player Game 
68B6 AD 03 24                     LDA     $2403             ; 1 Player start button
68B9 30 23                        BMI     loc_68DE          ; Branch If Pressed
68BB C0 02                        CPY     #2                ; Enough Credits For A 2 Player Game?
68BD 90 7C                        BCC     loc_693B          ; No, Branch
68BF AD 04 24                     LDA     $2404             ; 2 Player start button
68C2 10 77                        BPL     loc_693B          ; Branch if NOT pressed
68C4 A5 6F                        LDA     $6F               ; $3200 Bitmap
68C6 09 04                        ORA     #4                ; Set Bit 3, RAMSEL (Swap In $0200 Memory)
68C8 85 6F                        STA     $6F               ; Update Bitmap
68CA 8D 00 32                     STA     $3200             ; And Make The Change
68CD 20 D8 6E                     JSR     sub_6ED8          ;
68D0 20 68 71                     JSR     sub_7168          ;
68D3 20 E8 71                     JSR     sub_71E8          ;
68D6 A5 56                        LDA     $56               ; Number Of Starting Ships
68D8 85 58                        STA     $58               ; To Player 2 Current Ships
68DA A2 02                        LDX     #2                ; 2 Player Game
68DC C6 70                        DEC     $70               ; Subtract Credit
68DE                
68DE              loc_68DE:
68DE 86 1C                        STX     $1C               ; Flag Number Of Players In Current Game
68E0 C6 70                        DEC     $70               ; Subtract Credit
68E2 A5 6F                        LDA     $6F               ; $3200 Bitmap
68E4 29 F8                        AND     #$F8              ;
68E6 45 1C                        EOR     $1C               ; Change Player Start Lamps For This Game
68E8 85 6F                        STA     $6F               ; Update Bitmap
68EA 8D 00 32                     STA     $3200             ; And Make The Change
68ED 20 E8 71                     JSR     sub_71E8          ;
68F0 A9 01                        LDA     #1                ;
68F2 8D FA 02                     STA     $2FA              ;
68F5 8D FA 03                     STA     $3FA              ;
68F8 A9 92                        LDA     #$92              ;
68FA 8D F8 02                     STA     $2F8              ;
68FD 8D F8 03                     STA     $3F8              ;
6900 8D F7 03                     STA     $3F7              ;
6903 8D F7 02                     STA     $2F7              ; Countdown Timer For When Saucer Appears
6906 A9 7F                        LDA     #$7F              ;
6908 8D FB 02                     STA     $2FB              ;
690B 8D FB 03                     STA     $3FB              ;
690E A9 05                        LDA     #5                ;
6910 8D FD 02                     STA     $2FD              ;
6913 8D FD 03                     STA     $3FD              ;
6916 A9 FF                        LDA     #$FF              ;
6918 85 32                        STA     $32               ;
691A 85 33                        STA     $33               ;
691C A9 80                        LDA     #$80              ;
691E 85 5A                        STA     $5A               ;
6920 0A                           ASL     A                 ; Zero A, And Set Carry Flag
6921 85 18                        STA     $18               ; Current Player. New Game So Start With Player 1
6923 85 19                        STA     $19               ;
6925 A5 56                        LDA     $56               ;
6927 85 57                        STA     $57               ;
6929 A9 04                        LDA     #4                ;
692B 85 6C                        STA     $6C               ;
692D 85 6E                        STA     $6E               ;
692F A9 30                        LDA     #$30              ;
6931 8D FC 02                     STA     $2FC              ; Starting Value For Timer @ $6E
6934 8D FC 03                     STA     $3FC              ;
6937 8D 00 3E                     STA     $3E00             ;
693A 60                           RTS                       ; Noise Reset
693B              ; ---------------------------------------------------------------------------
693B                
693B              loc_693B:
693B
693B A5 32                        LDA     $32               ;
693D 25 32                        AND     $32               ;
693F 10 0B                        BPL     loc_694C          ;
6941 A5 5C                        LDA     $5C               ; Fast Timer
6943 29 20                        AND     #$20              ; Time To Draw Message To Screen?
6945 D0 05                        BNE     loc_694C          ; No, Branch
6947 A0 06                        LDY     #6                ; Offset For "PUSH START"
6949 20 F6 77                     JSR     sub_77F6          ; And Draw It On Screen
694C                
694C              loc_694C:
694C
694C A5 5C                        LDA     $5C               ; Fast Timer
694E 29 0F                        AND     #$F               ; Time To Blink Player Start Lamp(s)?
6950 D0 0C                        BNE     loc_695E          ; No, Branch
6952 A9 01                        LDA     #1                ;
6954 C5 70                        CMP     $70               ; Current Number Of Credits
6956 69 01                        ADC     #1                ; Calculate Which Lamp(s) To Blink
6958 49 01                        EOR     #1                ;
695A 45 6F                        EOR     $6F               ; Switch Their Status (On Or Off)
695C 85 6F                        STA     $6F               ; Update Bitmap
695E                
695E              loc_695E:
695E 18                           CLC                       ;
695F 60                           RTS                       ;
6960              ; ---------------------------------------------------------------------------
6960                
6960              loc_6960:
6960 A5 5C                        LDA     $5C               ; Fast Timer
6962 29 3F                        AND     #$3F              ;
6964 D0 0A                        BNE     loc_6970          ;
6966 AD FC 02                     LDA     $2FC              ; Starting Value For Timer @ $6E
6969 C9 08                        CMP     #8                ; At The Lowest Value It Can Be?
696B F0 03                        BEQ     loc_6970          ; Yes, Branch
696D CE FC 02                     DEC     $2FC              ;
6970                
6970              loc_6970:
6970
6970 A6 18                        LDX     $18               ; Current Player
6972 B5 57                        LDA     $57,X             ; Number Of Ships For Current Player
6974 D0 1C                        BNE     loc_6992          ; Any Ships Left? Branch If Yes
6976 AD 1F 02                     LDA     $21F              ; Check If Current Player Has Any Shots Active
6979 0D 20 02                     ORA     $220              ;
697C 0D 21 02                     ORA     $221              ;
697F 0D 22 02                     ORA     $222              ;
6982 D0 0E                        BNE     loc_6992          ; Still Have Active Shots, Branch
6984 A0 07                        LDY     #7                ; Offset For "GAME OVER"
6986 20 F6 77                     JSR     sub_77F6          ; And Draw It To Screen
6989 A5 1C                        LDA     $1C               ; Number Of Players In Current Game
698B C9 02                        CMP     #2                ; 2 Player Game?
698D 90 03                        BCC     loc_6992          ; No, Branch
698F 20 E2 69                     JSR     sub_69E2          ; Display On Screen Which Player's Game Is Over
6992                
6992              loc_6992:
6992
6992 AD 1B 02                     LDA     $21B              ;
6995 D0 36                        BNE     loc_69CD          ;
6997 AD FA 02                     LDA     $2FA              ;
699A C9 80                        CMP     #$80              ;
699C D0 2F                        BNE     loc_69CD          ;
699E A9 10                        LDA     #$10              ;
69A0 8D FA 02                     STA     $2FA              ;
69A3 A6 1C                        LDX     $1C               ; Number Of Players In Current Game
69A5 A5 57                        LDA     $57               ; Check If ANY Player Has ANY Ships Left
69A7 05 58                        ORA     $58               ;
69A9 F0 24                        BEQ     loc_69CF          ; Branch If All Players Are Out Of Ships
69AB 20 2D 70                     JSR     sub_702D          ;
69AE CA                           DEX                       ;
69AF F0 1C                        BEQ     loc_69CD          ; Will Branch If Only 1 Player Remaining In Game
69B1 A9 80                        LDA     #$80              ;
69B3 85 5A                        STA     $5A               ;
69B5 A5 18                        LDA     $18               ; Current Player
69B7 49 01                        EOR     #1                ; Switch To Next Player
69B9 AA                           TAX                       ;
69BA B5 57                        LDA     $57,X             ; Any Ships Left For This Player?
69BC F0 0F                        BEQ     loc_69CD          ; No, Branch
69BE 86 18                        STX     $18               ; Flag Switch To Next Player
69C0 A9 04                        LDA     #4                ; And Switch RAM To Next Player
69C2 45 6F                        EOR     $6F               ; Bit 3, RAMSEL
69C4 85 6F                        STA     $6F               ; Update Bitmap
69C6 8D 00 32                     STA     $3200             ; Make The Switch 
69C9 8A                           TXA                       ;
69CA 0A                           ASL     A                 ;
69CB 85 19                        STA     $19               ;
69CD                
69CD              loc_69CD:
69CD
69CD 18                           CLC                       ;
69CE 60                           RTS                       ;
69CF              ; ---------------------------------------------------------------------------
69CF                
69CF              loc_69CF:
69CF 86 1A                        STX     $1A               ;
69D1 A9 FF                        LDA     #$FF              ;
69D3 85 1C                        STA     $1C               ; Number Of Players In Current Game
69D5 20 FA 6E                     JSR     sub_6EFA          ; Turn Off All Sounds, Zero Sound Timers
69D8 A5 6F                        LDA     $6F               ; Bitmap Of $3200
69DA 29 F8                        AND     #$F8              ;
69DC 09 03                        ORA     #3                ; Turn On Player 1 & 2 Start Lamps
69DE 85 6F                        STA     $6F               ; Update Bitmap
69E0 18                           CLC                       ;
69E1 60                           RTS                       ;
69E1              ; End of function sub_6885
69E1                
69E2                
69E2              ; ��������������� S U B R O U T I N E ���������������������������������������
69E2                
69E2                
69E2              sub_69E2:
69E2
69E2 A0 01                        LDY     #1                ; Offset For "PLAYER "
69E4 20 F6 77                     JSR     sub_77F6          ; And Draw It On Screen
69E7 A4 18                        LDY     $18               ; Current Player
69E9 C8                           INY                       ; Used To Draw Either "1" Or "2" After "PLAYER "
69EA 98                           TYA                       ;
69EB 20 D1 7B                     JSR     sub_7BD1          ; Draw It To Screen
69EE 60                           RTS     
69EE              ; End of function sub_69E2
69EE                
69EE              ; ---------------------------------------------------------------------------
69EF 71                           .BYTE  $71
69F0                
69F0              ; ��������������� S U B R O U T I N E ���������������������������������������
69F0                
69F0                
69F0              sub_69F0:
69F0 A2 07                        LDX     #7                ;
69F2                
69F2              loc_69F2:
69F2 BD 1B 02                     LDA     $21B,X            ; Check If Any Active Shot In This Slot
69F5 F0 02                        BEQ     loc_69F9          ; No, Branch
69F7 10 04                        BPL     loc_69FD          ; Shot Still Active, Branch
69F9                
69F9              loc_69F9:
69F9
69F9 CA                           DEX                       ;
69FA 10 F6                        BPL     loc_69F2          ;
69FC 60                           RTS                       ;
69FD              ; ---------------------------------------------------------------------------
69FD                
69FD              loc_69FD:
69FD A0 1C                        LDY     #$1C              ;
69FF E0 04                        CPX     #4                ;
6A01 B0 07                        BCS     loc_6A0A          ;
6A03 88                           DEY                       ;
6A04 8A                           TXA     
6A05 D0 03                        BNE     loc_6A0A
6A07                
6A07              loc_6A07:
6A07
6A07 88                           DEY     
6A08 30 EF                        BMI     loc_69F9          ;
6A0A                
6A0A              loc_6A0A:
6A0A
6A0A B9 00 02                     LDA     $200,Y            ;
6A0D F0 F8                        BEQ     loc_6A07          ;
6A0F 30 F6                        BMI     loc_6A07          ;
6A11 85 0B                        STA     $B                ;
6A13 B9 AF 02                     LDA     $2AF,Y            ;
6A16 38                           SEC                       ;
6A17 FD CA 02                     SBC     $2CA,X            ;
6A1A 85 08                        STA     8                 ;
6A1C B9 69 02                     LDA     $269,Y            ;
6A1F FD 84 02                     SBC     $284,X            ;
6A22 4A                           LSR     A                 ;
6A23 66 08                        ROR     8                 ;
6A25 0A                           ASL     A                 ;
6A26 F0 0C                        BEQ     loc_6A34          ;
6A28 10 6D                        BPL     loc_6A97          ;
6A2A 49 FE                        EOR     #$FE              ;
6A2C D0 69                        BNE     loc_6A97          ;
6A2E A5 08                        LDA     8                 ;
6A30 49 FF                        EOR     #$FF              ;
6A32 85 08                        STA     8                 ;
6A34                
6A34              loc_6A34:
6A34 B9 D2 02                     LDA     $2D2,Y            ;
6A37 38                           SEC                       ;
6A38 FD ED 02                     SBC     $2ED,X            ;
6A3B 85 09                        STA     9                 ;
6A3D B9 8C 02                     LDA     $28C,Y            ;
6A40 FD A7 02                     SBC     $2A7,X            ;
6A43 4A                           LSR     A                 ;
6A44 66 09                        ROR     9                 ;
6A46 0A                           ASL     A                 ;
6A47 F0 0C                        BEQ     loc_6A55          ;
6A49 10 4C                        BPL     loc_6A97          ;
6A4B 49 FE                        EOR     #$FE              ;
6A4D D0 48                        BNE     loc_6A97          ;
6A4F A5 09                        LDA     9                 ;
6A51 49 FF                        EOR     #$FF              ;
6A53 85 09                        STA     9                 ;
6A55                
6A55              loc_6A55:
6A55 A9 2A                        LDA     #$2A              ;
6A57 46 0B                        LSR     $B                ;
6A59 B0 08                        BCS     loc_6A63          ;
6A5B A9 48                        LDA     #$48              ;
6A5D 46 0B                        LSR     $B                ;
6A5F B0 02                        BCS     loc_6A63          ;
6A61 A9 84                        LDA     #$84              ;
6A63                
6A63              loc_6A63:
6A63
6A63 E0 01                        CPX     #1                ;
6A65 B0 02                        BCS     loc_6A69          ;
6A67 69 1C                        ADC     #$1C              ;
6A69                
6A69              loc_6A69:
6A69 D0 0C                        BNE     loc_6A77          ;
6A6B 69 12                        ADC     #$12              ;
6A6D AE 1C 02                     LDX     $21C              ; Saucer Flag
6A70 CA                           DEX                       ;
6A71 F0 02                        BEQ     loc_6A75          ; Small Saucer, Branch
6A73 69 12                        ADC     #$12              ;
6A75                
6A75              loc_6A75:
6A75 A2 01                        LDX     #1                ;
6A77                
6A77              loc_6A77:
6A77 C5 08                        CMP     8                 ;
6A79 90 1C                        BCC     loc_6A97          ;
6A7B C5 09                        CMP     9                 ;
6A7D 90 18                        BCC     loc_6A97          ;
6A7F 85 0B                        STA     $B                ;
6A81 4A                           LSR     A                 ;
6A82 18                           CLC                       ;
6A83 65 0B                        ADC     $B                ;
6A85 85 0B                        STA     $B                ;
6A87 A5 09                        LDA     9                 ;
6A89 65 08                        ADC     8                 ;
6A8B B0 0A                        BCS     loc_6A97          ;
6A8D C5 0B                        CMP     $B                ;
6A8F B0 06                        BCS     loc_6A97
6A91 20 0F 6B                     JSR     sub_6B0F
6A94                
6A94              loc_6A94:
6A94 4C F9 69                     JMP     loc_69F9          ;
6A97              ; ---------------------------------------------------------------------------
6A97                
6A97              loc_6A97:
6A97
6A97 88                           DEY     
6A98 30 FA                        BMI     loc_6A94          ;
6A9A 4C 0A 6A                     JMP     loc_6A0A
6A9A              ; End of function sub_69F0
6A9A                
6A9D                
6A9D              ; ��������������� S U B R O U T I N E ���������������������������������������
6A9D                
6A9D                
6A9D              sub_6A9D:
6A9D
6A9D B9 00 02                     LDA     $200,Y            ;
6AA0 29 07                        AND     #7                ;
6AA2 85 08                        STA     8                 ;
6AA4 20 B5 77                     JSR     sub_77B5          ;
6AA7 29 18                        AND     #$18              ;
6AA9 05 08                        ORA     8                 ;
6AAB 9D 00 02                     STA     $200,X            ;
6AAE B9 AF 02                     LDA     $2AF,Y
6AB1 9D AF 02                     STA     $2AF,X
6AB4 B9 69 02                     LDA     $269,Y
6AB7 9D 69 02                     STA     $269,X            ;
6ABA B9 D2 02                     LDA     $2D2,Y
6ABD 9D D2 02                     STA     $2D2,X
6AC0 B9 8C 02                     LDA     $28C,Y
6AC3 9D 8C 02                     STA     $28C,X
6AC6 B9 23 02                     LDA     $223,Y
6AC9 9D 23 02                     STA     $223,X
6ACC B9 46 02                     LDA     $246,Y            ;
6ACF 9D 46 02                     STA     $246,X
6AD2 60                           RTS     
6AD2              ; End of function sub_6A9D
6AD2                
6AD3                
6AD3              ; ��������������� S U B R O U T I N E ���������������������������������������
6AD3                
6AD3                
6AD3              sub_6AD3:
6AD3
6AD3 85 0B                        STA     $B                ;
6AD5 86 0C                        STX     $C
6AD5              ; End of function sub_6AD3
6AD5                
6AD7                
6AD7              ; ��������������� S U B R O U T I N E ���������������������������������������
6AD7                
6AD7                
6AD7              sub_6AD7:
6AD7 A0 00                        LDY     #0                ;
6AD9                
6AD9              loc_6AD9:
6AD9 C8                           INY                       ;
6ADA B1 0B                        LDA     ($B),Y            ;
6ADC 45 09                        EOR     9
6ADE 91 02                        STA     (2),Y
6AE0 88                           DEY     
6AE1 C9 F0                        CMP     #$F0
6AE3 B0 1E                        BCS     loc_6B03          ;
6AE5 C9 A0                        CMP     #$A0
6AE7 B0 16                        BCS     loc_6AFF
6AE9 B1 0B                        LDA     ($B),Y
6AEB 91 02                        STA     (2),Y
6AED C8                           INY     
6AEE C8                           INY     
6AEF B1 0B                        LDA     ($B),Y            ;
6AF1 91 02                        STA     (2),Y
6AF3 C8                           INY     
6AF4 B1 0B                        LDA     ($B),Y            ;
6AF6 45 08                        EOR     8
6AF8 65 17                        ADC     $17
6AFA 91 02                        STA     (2),Y             ;
6AFC                
6AFC              loc_6AFC:
6AFC C8                           INY     
6AFD D0 DA                        BNE     loc_6AD9          ;
6AFF                
6AFF              loc_6AFF:
6AFF 88                           DEY     
6B00 4C 39 7C                     JMP     sub_7C39          ;
6B03              ; ---------------------------------------------------------------------------
6B03                
6B03              loc_6B03:
6B03 B1 0B                        LDA     ($B),Y            ;
6B05 45 08                        EOR     8
6B07 18                           CLC     
6B08 65 17                        ADC     $17
6B0A 91 02                        STA     (2),Y
6B0C C8                           INY     
6B0D D0 ED                        BNE     loc_6AFC          ;
6B0D              ; End of function sub_6AD7
6B0D                
6B0F                
6B0F              ; ��������������� S U B R O U T I N E ���������������������������������������
6B0F                
6B0F                
6B0F              sub_6B0F:
6B0F E0 01                        CPX     #1
6B11 D0 08                        BNE     loc_6B1B          ;
6B13 C0 1B                        CPY     #$1B
6B15 D0 12                        BNE     loc_6B29          ;
6B17 A2 00                        LDX     #0
6B19 A0 1C                        LDY     #$1C              ;
6B1B                
6B1B              loc_6B1B:
6B1B 8A                           TXA                       ;
6B1C D0 1E                        BNE     loc_6B3C
6B1E A9 81                        LDA     #$81
6B20 8D FA 02                     STA     $2FA              ;
6B23 A6 18                        LDX     $18               ; Current Player
6B25 D6 57                        DEC     $57,X             ; Subtract Ship
6B27 A2 00                        LDX     #0                ;
6B29                
6B29              loc_6B29:
6B29 A9 A0                        LDA     #$A0
6B2B 9D 1B 02                     STA     $21B,X            ;
6B2E A9 00                        LDA     #0
6B30 9D 3E 02                     STA     $23E,X
6B33 9D 61 02                     STA     $261,X
6B36 C0 1B                        CPY     #$1B
6B38 90 0D                        BCC     loc_6B47          ;
6B3A B0 37                        BCS     loc_6B73
6B3C                
6B3C              loc_6B3C:
6B3C A9 00                        LDA     #0
6B3E 9D 1B 02                     STA     $21B,X            ;
6B41 C0 1B                        CPY     #$1B
6B43 F0 21                        BEQ     loc_6B66
6B45 B0 2C                        BCS     loc_6B73          ;
6B47                
6B47              loc_6B47:
6B47 20 EC 75                     JSR     sub_75EC          ;
6B4A                
6B4A              loc_6B4A:
6B4A
6B4A B9 00 02                     LDA     $200,Y            ;
6B4D 29 03                        AND     #3
6B4F 49 02                        EOR     #2
6B51 4A                           LSR     A                 ;
6B52 6A                           ROR     A
6B53 6A                           ROR     A
6B54 09 3F                        ORA     #$3F              ;
6B56 85 69                        STA     $69
6B58 A9 A0                        LDA     #$A0
6B5A 99 00 02                     STA     $200,Y            ;
6B5D A9 00                        LDA     #0
6B5F 99 23 02                     STA     $223,Y
6B62 99 46 02                     STA     $246,Y            ;
6B65 60                           RTS     
6B66              ; ---------------------------------------------------------------------------
6B66                
6B66              loc_6B66:
6B66 8A                           TXA                       ;
6B67 A6 18                        LDX     $18               ; Current Player
6B69 D6 57                        DEC     $57,X             ; Subtract Ship
6B6B AA                           TAX     
6B6C A9 81                        LDA     #$81
6B6E 8D FA 02                     STA     $2FA              ;
6B71 D0 D7                        BNE     loc_6B4A
6B73                
6B73              loc_6B73:
6B73
6B73 AD F8 02                     LDA     $2F8              ;
6B76 8D F7 02                     STA     $2F7              ; Countdown Timer For When Saucer Appears
6B79 A5 1C                        LDA     $1C               ; Number Of Players In Current Game
6B7B F0 CD                        BEQ     loc_6B4A          ; None, Branch
6B7D 86 0D                        STX     $D                ;
6B7F A6 19                        LDX     $19               ;
6B81 AD 1C 02                     LDA     $21C              ; Saucer Flag
6B84 4A                           LSR     A                 ; Shift It To Carry
6B85 A9 99                        LDA     #$99              ; 990 Points, Assume Small Saucer
6B87 B0 02                        BCS     loc_6B8B          ; Carry Will Be Set If Small Saucer
6B89 A9 20                        LDA     #$20              ; 200 Points, Its The Large Saucer
6B8B                
6B8B              loc_6B8B:
6B8B 20 97 73                     JSR     sub_7397          ; And Add It To Score
6B8E A6 0D                        LDX     $D
6B90 4C 4A 6B                     JMP     loc_6B4A          ;
6B90              ; End of function sub_6B0F
6B90                
6B93                
6B93              ; ��������������� S U B R O U T I N E ���������������������������������������
6B93                
6B93                
6B93              sub_6B93:
6B93 A5 5C                        LDA     $5C               ;
6B95 29 03                        AND     #3
6B97 F0 01                        BEQ     loc_6B9A          ;
6B99                
6B99              locret_6B99:
6B99
6B99 60                           RTS                       ;
6B9A              ; ---------------------------------------------------------------------------
6B9A                
6B9A              loc_6B9A:
6B9A AD 1C 02                     LDA     $21C              ; Saucer Flag
6B9D 30 FA                        BMI     locret_6B99       ; Currently Exploding?, Branch
6B9F F0 03                        BEQ     loc_6BA4          ; No Saucer Currently Active, Branch
6BA1 4C 34 6C                     JMP     loc_6C34          ;
6BA4              ; ---------------------------------------------------------------------------
6BA4                
6BA4              loc_6BA4:
6BA4 A5 1C                        LDA     $1C               ; Number Of Players In Current Game
6BA6 F0 07                        BEQ     loc_6BAF          ; None, Branch
6BA8 AD 1B 02                     LDA     $21B              ;
6BAB F0 EC                        BEQ     locret_6B99       ;
6BAD 30 EA                        BMI     locret_6B99
6BAF                
6BAF              loc_6BAF:
6BAF AD F9 02                     LDA     $2F9              ;
6BB2 F0 03                        BEQ     loc_6BB7
6BB4 CE F9 02                     DEC     $2F9              ;
6BB7                
6BB7              loc_6BB7:
6BB7 CE F7 02                     DEC     $2F7              ; Update Countdown Timer For When Saucer Appears
6BBA D0 DD                        BNE     locret_6B99
6BBC A9 12                        LDA     #$12              ;
6BBE 8D F7 02                     STA     $2F7
6BC1 AD F9 02                     LDA     $2F9
6BC4 F0 0A                        BEQ     loc_6BD0          ;
6BC6 AD F6 02                     LDA     $2F6
6BC9 F0 CE                        BEQ     locret_6B99       ;
6BCB CD FD 02                     CMP     $2FD              ;
6BCE B0 C9                        BCS     locret_6B99       ;
6BD0                
6BD0              loc_6BD0:
6BD0 AD F8 02                     LDA     $2F8              ;
6BD3 38                           SEC                       ;
6BD4 E9 06                        SBC     #6                ; Shorten Time Between Saucer Appearence
6BD6 C9 20                        CMP     #$20              ; At Lowest Value?
6BD8 90 03                        BCC     loc_6BDD          ; Yes, Branch
6BDA 8D F8 02                     STA     $2F8              ; Make The Update
6BDD                
6BDD              loc_6BDD:
6BDD A9 00                        LDA     #0                ;
6BDF 8D CB 02                     STA     $2CB              ;
6BE2 8D 85 02                     STA     $285              ;
6BE5 20 B5 77                     JSR     sub_77B5          ;
6BE8 4A                           LSR     A                 ;
6BE9 6E EE 02                     ROR     $2EE              ;
6BEC 4A                           LSR     A                 ;
6BED 6E EE 02                     ROR     $2EE              ;
6BF0 4A                           LSR     A
6BF1 6E EE 02                     ROR     $2EE              ;
6BF4 C9 18                        CMP     #$18
6BF6 90 02                        BCC     loc_6BFA          ;
6BF8 29 17                        AND     #$17
6BFA                
6BFA              loc_6BFA:
6BFA 8D A8 02                     STA     $2A8              ;
6BFD A2 10                        LDX     #$10
6BFF 24 60                        BIT     $60
6C01 70 0C                        BVS     loc_6C0F          ;
6C03 A9 1F                        LDA     #$1F
6C05 8D 85 02                     STA     $285
6C08 A9 FF                        LDA     #$FF              ;
6C0A 8D CB 02                     STA     $2CB
6C0D A2 F0                        LDX     #$F0              ;
6C0F                
6C0F              loc_6C0F:
6C0F 8E 3F 02                     STX     $23F              ;
6C12 A2 02                        LDX     #2                ; Start With Large Saucer
6C14 AD F8 02                     LDA     $2F8              ; Start Checking Score When @ #$7F And Below
6C17 30 17                        BMI     loc_6C30          ; Not There Yet, Branch Around Score Check
6C19 A4 19                        LDY     $19
6C1B B9 53 00                     LDA     $53,Y             ; Current Player Score, Thousands
6C1E C9 30                        CMP     #$30              ; 30,000 Points Or More?
6C20 B0 0D                        BCS     loc_6C2F          ; Yes, Branch
6C22 20 B5 77                     JSR     sub_77B5
6C25 85 08                        STA     8
6C27 AD F8 02                     LDA     $2F8              ;
6C2A 4A                           LSR     A
6C2B C5 08                        CMP     8
6C2D B0 01                        BCS     loc_6C30          ; Going To Be A large Saucer, Branch
6C2F                
6C2F              loc_6C2F:
6C2F CA                           DEX                       ; Make It A Small Saucer
6C30                
6C30              loc_6C30:
6C30
6C30 8E 1C 02                     STX     $21C              ; Saucer Flag
6C33 60                           RTS     
6C34              ; ---------------------------------------------------------------------------
6C34                
6C34              loc_6C34:
6C34 A5 5C                        LDA     $5C               ; Fast Timer
6C36 0A                           ASL     A                 ; Time To Change Saucer Direction? ( $5C = #$80 )
6C37 D0 0C                        BNE     loc_6C45          ; No, Branch
6C39 20 B5 77                     JSR     sub_77B5          ;
6C3C 29 03                        AND     #3                ;
6C3E AA                           TAX     
6C3F BD D3 6C                     LDA     $6CD3,X           ; Direction Table
6C42 8D 62 02                     STA     $262
6C45                
6C45              loc_6C45:
6C45 A5 1C                        LDA     $1C               ; Number Of Players In Current Game
6C47 F0 05                        BEQ     loc_6C4E          ; None, Branch
6C49 AD FA 02                     LDA     $2FA
6C4C D0 05                        BNE     locret_6C53       ;
6C4E                
6C4E              loc_6C4E:
6C4E CE F7 02                     DEC     $2F7
6C51 F0 01                        BEQ     loc_6C54          ;
6C53                
6C53              locret_6C53:
6C53 60                           RTS                       ;
6C54              ; ---------------------------------------------------------------------------
6C54                
6C54              loc_6C54:
6C54 A9 0A                        LDA     #$A               ; Time Between Saucer Shots
6C56 8D F7 02                     STA     $2F7
6C59 AD 1C 02                     LDA     $21C              ; Saucer Flag
6C5C 4A                           LSR     A                 ; Check Saucer Size
6C5D F0 06                        BEQ     loc_6C65          ; Branch If Small One
6C5F 20 B5 77                     JSR     sub_77B5
6C62 4C C4 6C                     JMP     loc_6CC4          ;
6C65              ; ---------------------------------------------------------------------------
6C65                
6C65              loc_6C65:
6C65 AD 3F 02                     LDA     $23F              ;
6C68 C9 80                        CMP     #$80
6C6A 6A                           ROR     A
6C6B 85 0C                        STA     $C                ;
6C6D AD CA 02                     LDA     $2CA
6C70 38                           SEC                       ;
6C71 ED CB 02                     SBC     $2CB
6C74 85 0B                        STA     $B                ;
6C76 AD 84 02                     LDA     $284
6C79 ED 85 02                     SBC     $285              ;
6C7C 06 0B                        ASL     $B
6C7E 2A                           ROL     A
6C7F 06 0B                        ASL     $B                ;
6C81 2A                           ROL     A
6C82 38                           SEC     
6C83 E5 0C                        SBC     $C                ;
6C85 AA                           TAX     
6C86 AD 62 02                     LDA     $262
6C89 C9 80                        CMP     #$80              ;
6C8B 6A                           ROR     A
6C8C 85 0C                        STA     $C
6C8E AD ED 02                     LDA     $2ED              ;
6C91 38                           SEC     
6C92 ED EE 02                     SBC     $2EE              ;
6C95 85 0B                        STA     $B
6C97 AD A7 02                     LDA     $2A7
6C9A ED A8 02                     SBC     $2A8              ;
6C9D 06 0B                        ASL     $B
6C9F 2A                           ROL     A
6CA0 06 0B                        ASL     $B                ;
6CA2 2A                           ROL     A
6CA3 38                           SEC                       ;
6CA4 E5 0C                        SBC     $C
6CA6 A8                           TAY                       ;
6CA7 20 F0 76                     JSR     loc_76F0          ;
6CAA 85 62                        STA     $62               ;
6CAC 20 B5 77                     JSR     sub_77B5          ;
6CAF A6 19                        LDX     $19               ;
6CB1 B4 53                        LDY     $53,X             ; Current Players Score, Thousands
6CB3 C0 35                        CPY     #$35              ; 35,000?
6CB5 A2 00                        LDX     #0                ;
6CB7 90 01                        BCC     loc_6CBA          ; Branch If Less
6CB9 E8                           INX                       ;
6CBA                
6CBA              loc_6CBA:
6CBA 3D CF 6C                     AND     $6CCF,X           ;
6CBD 10 03                        BPL     loc_6CC2          ;
6CBF 1D D1 6C                     ORA     $6CD1,X           ;
6CC2                
6CC2              loc_6CC2:
6CC2 65 62                        ADC     $62               ; Direction Shot Is Traveling???
6CC4                
6CC4              loc_6CC4:
6CC4 85 62                        STA     $62               ;
6CC6 A0 03                        LDY     #3                ;
6CC8 A2 01                        LDX     #1                ;
6CCA 86 0E                        STX     $E                ;
6CCC 4C F2 6C                     JMP     loc_6CF2          ;
6CCC              ; End of function sub_6B93
6CCC                
6CCC              ; ---------------------------------------------------------------------------
6CCF 8F                           .BYTE  $8F
6CD0 87                           .BYTE  $87

6CD1 70                           .BYTE  $70
6CD2 78                           .BYTE  $78
6CD3                                                        ; First Colum Is Saucer Enters From Left Side Of Screen
6CD3                                                        ; Second Colum Is Saucer Enters From Right Side Of Screen
6CD3 F0                           .BYTE  $F0                ; SE SW
6CD4 00                           .BYTE    0                ; E  W
6CD5 00                           .BYTE    0                ; E  W
6CD6 10                           .BYTE  $10                ; NE NW
6CD7                
6CD7              ; ��������������� S U B R O U T I N E ���������������������������������������
6CD7                
6CD7                
6CD7              sub_6CD7:
6CD7 A5 1C                        LDA     $1C               ; Number Of Players In Current Game
6CD9 F0 21                        BEQ     locret_6CFC       ; None, Branch
6CDB 0E 04 20                     ASL     $2004             ; Fire Switch
6CDE 66 63                        ROR     $63               ;
6CE0 24 63                        BIT     $63               ;
6CE2 10 18                        BPL     locret_6CFC       ;
6CE4 70 16                        BVS     locret_6CFC       ;
6CE6 AD FA 02                     LDA     $2FA              ;
6CE9 D0 11                        BNE     locret_6CFC       ;
6CEB AA                           TAX                       ;
6CEC A9 03                        LDA     #3                ;
6CEE 85 0E                        STA     $E                ;
6CF0 A0 07                        LDY     #7                ;
6CF2                
6CF2              loc_6CF2:
6CF2
6CF2 B9 1B 02                     LDA     $21B,Y            ; Check For A Open Slot For The Shot
6CF5 F0 06                        BEQ     loc_6CFD          ; Branch If This Slot Is Open
6CF7 88                           DEY                       ; Point To Next Slot
6CF8 C4 0E                        CPY     $E                ; Out Of Slots?
6CFA D0 F6                        BNE     loc_6CF2          ; No, Branch And Keep Checking
6CFC                
6CFC              locret_6CFC:
6CFC
6CFC 60                           RTS                       ;
6CFD              ; ---------------------------------------------------------------------------
6CFD                
6CFD              loc_6CFD:
6CFD 86 0D                        STX     $D                ;
6CFF A9 12                        LDA     #$12              ;
6D01 99 1B 02                     STA     $21B,Y            ;
6D04 B5 61                        LDA     $61,X             ;
6D06 20 D2 77                     JSR     sub_77D2          ;
6D09 A6 0D                        LDX     $D                ;
6D0B C9 80                        CMP     #$80              ;
6D0D 6A                           ROR     A                 ;
6D0E 85 09                        STA     9                 ;
6D10 18                           CLC                       ;
6D11 7D 3E 02                     ADC     $23E,X
6D14 30 08                        BMI     loc_6D1E          ;
6D16 C9 70                        CMP     #$70
6D18 90 0A                        BCC     loc_6D24          ;
6D1A A9 6F                        LDA     #$6F
6D1C D0 06                        BNE     loc_6D24          ;
6D1E                
6D1E              loc_6D1E:
6D1E C9 91                        CMP     #$91              ;
6D20 B0 02                        BCS     loc_6D24
6D22 A9 91                        LDA     #$91
6D24                
6D24              loc_6D24:
6D24
6D24 99 3E 02                     STA     $23E,Y            ;
6D27 B5 61                        LDA     $61,X
6D29 20 D5 77                     JSR     sub_77D5
6D2C A6 0D                        LDX     $D                ;
6D2E C9 80                        CMP     #$80
6D30 6A                           ROR     A                 ;
6D31 85 0C                        STA     $C
6D33 18                           CLC     
6D34 7D 61 02                     ADC     $261,X            ;
6D37 30 08                        BMI     loc_6D41
6D39 C9 70                        CMP     #$70              ;
6D3B 90 0A                        BCC     loc_6D47
6D3D A9 6F                        LDA     #$6F
6D3F D0 06                        BNE     loc_6D47          ;
6D41                
6D41              loc_6D41:
6D41 C9 91                        CMP     #$91
6D43 B0 02                        BCS     loc_6D47
6D45 A9 91                        LDA     #$91              ;
6D47                
6D47              loc_6D47:
6D47
6D47 99 61 02                     STA     $261,Y            ;
6D4A A2 00                        LDX     #0
6D4C A5 09                        LDA     9
6D4E 10 01                        BPL     loc_6D51          ;
6D50 CA                           DEX                       ;
6D51                
6D51              loc_6D51:
6D51 86 08                        STX     8                 ;
6D53 A6 0D                        LDX     $D                ;
6D55 C9 80                        CMP     #$80              ;
6D57 6A                           ROR     A                 ;
6D58 18                           CLC                       ;
6D59 65 09                        ADC     9                 ;
6D5B 18                           CLC                       ;
6D5C 7D CA 02                     ADC     $2CA,X            ;
6D5F 99 CA 02                     STA     $2CA,Y            ;
6D62 A5 08                        LDA     8                 ;
6D64 7D 84 02                     ADC     $284,X
6D67 99 84 02                     STA     $284,Y
6D6A A2 00                        LDX     #0                ;
6D6C A5 0C                        LDA     $C
6D6E 10 01                        BPL     loc_6D71
6D70 CA                           DEX                       ;
6D71                
6D71              loc_6D71:
6D71 86 0B                        STX     $B                ;
6D73 A6 0D                        LDX     $D
6D75 C9 80                        CMP     #$80
6D77 6A                           ROR     A                 ;
6D78 18                           CLC     
6D79 65 0C                        ADC     $C                ;
6D7B 18                           CLC     
6D7C 7D ED 02                     ADC     $2ED,X
6D7F 99 ED 02                     STA     $2ED,Y            ;
6D82 A5 0B                        LDA     $B
6D84 7D A7 02                     ADC     $2A7,X
6D87 99 A7 02                     STA     $2A7,Y            ;
6D8A A9 80                        LDA     #$80
6D8C 95 66                        STA     $66,X             ;
6D8E 60                           RTS     
6D8E              ; End of function sub_6CD7
6D8E                
6D8E              ; ---------------------------------------------------------------------------
6D8F D8                           .BYTE  $D8
6D90                
6D90              ; ��������������� S U B R O U T I N E ���������������������������������������
6D90                
6D90                
6D90              sub_6D90:
6D90 A5 32                        LDA     $32               ;
6D92 25 33                        AND     $33
6D94 10 01                        BPL     loc_6D97          ;
6D96 60                           RTS     
6D97              ; ---------------------------------------------------------------------------
6D97                
6D97              loc_6D97:
6D97 A5 1A                        LDA     $1A               ;
6D99 4A                           LSR     A
6D9A F0 18                        BEQ     loc_6DB4
6D9C A0 01                        LDY     #1                ; Offset For "PLAYER "
6D9E 20 F6 77                     JSR     sub_77F6          ; And Draw To Screen
6DA1 A0 02                        LDY     #2                ;
6DA3 A6 33                        LDX     $33               ;
6DA5 10 01                        BPL     loc_6DA8          ;
6DA7 88                           DEY     
6DA8                
6DA8              loc_6DA8:
6DA8 84 18                        STY     $18               ; Current Player
6DAA A5 5C                        LDA     $5C               ; Fast Timer
6DAC 29 10                        AND     #$10              ;
6DAE D0 04                        BNE     loc_6DB4          ;
6DB0 98                           TYA                       ;
6DB1 20 D1 7B                     JSR     sub_7BD1          ;
6DB4                
6DB4              loc_6DB4:
6DB4
6DB4 46 18                        LSR     $18               ; Current Player
6DB6 20 B2 73                     JSR     sub_73B2          ;
6DB9 A0 02                        LDY     #2                ; Offset For "YOUR SCORE IS ONE OF THE TEN BEST"
6DBB 20 F6 77                     JSR     sub_77F6          ; And Draw It To Screen
6DBE A0 03                        LDY     #3                ; Offset For "PLEASE ENTER YOUR INITIALS"
6DC0 20 F6 77                     JSR     sub_77F6          ; And Draw It To Screen
6DC3 A0 04                        LDY     #4                ; Offset For "PUSH ROTATE TO SELECT LETTER"
6DC5 20 F6 77                     JSR     sub_77F6          ; And Draw It To Screen
6DC8 A0 05                        LDY     #5                ; Offset For "PUSH HYPERSPACE WHEN LETTER IS CORRECT"
6DCA 20 F6 77                     JSR     sub_77F6          ; And Draw It To Screen
6DCD A9 20                        LDA     #$20              ;
6DCF 85 00                        STA     0                 ;
6DD1 A9 64                        LDA     #$64              ;
6DD3 A2 39                        LDX     #$39
6DD5 20 03 7C                     JSR     sub_7C03
6DD8 A9 70                        LDA     #$70
6DDA 20 DE 7C                     JSR     sub_7CDE
6DDD A6 18                        LDX     $18               ; Current Player
6DDF B4 32                        LDY     $32,X
6DE1 84 0B                        STY     $B                ;
6DE3 98                           TYA     
6DE4 18                           CLC                       ;
6DE5 65 31                        ADC     $31
6DE7 85 0C                        STA     $C
6DE9 20 1A 6F                     JSR     sub_6F1A          ;
6DEC A4 0B                        LDY     $B
6DEE C8                           INY                       ;
6DEF 20 1A 6F                     JSR     sub_6F1A
6DF2 A4 0B                        LDY     $B                ;
6DF4 C8                           INY     
6DF5 C8                           INY                       ;
6DF6 20 1A 6F                     JSR     sub_6F1A
6DF9 AD 03 20                     LDA     $2003             ; Hyperspace Switch
6DFC 2A                           ROL     A                 ;
6DFD 26 63                        ROL     $63               ;
6DFF A5 63                        LDA     $63               ;
6E01 29 1F                        AND     #$1F              ;
6E03 C9 07                        CMP     #7                ;
6E05 D0 27                        BNE     loc_6E2E          ;
6E07 E6 31                        INC     $31
6E09 A5 31                        LDA     $31
6E0B C9 03                        CMP     #3                ;
6E0D 90 13                        BCC     loc_6E22
6E0F A6 18                        LDX     $18               ; Current Player
6E11 A9 FF                        LDA     #$FF              ;
6E13 95 32                        STA     $32,X             ;
6E15                
6E15              loc_6E15:
6E15 A2 00                        LDX     #0                ;
6E17 86 18                        STX     $18
6E19 86 31                        STX     $31               ;
6E1B A2 F0                        LDX     #$F0
6E1D 86 5D                        STX     $5D               ; Slow Timer
6E1F 4C B2 73                     JMP     sub_73B2
6E22              ; ---------------------------------------------------------------------------
6E22                
6E22              loc_6E22:
6E22 E6 0C                        INC     $C                ;
6E24 A6 0C                        LDX     $C
6E26 A9 F4                        LDA     #$F4
6E28 85 5D                        STA     $5D               ; Slow Timer
6E2A A9 0B                        LDA     #$B
6E2C 95 34                        STA     $34,X             ;
6E2E                
6E2E              loc_6E2E:
6E2E A5 5D                        LDA     $5D               ; Slow Timer
6E30 D0 08                        BNE     loc_6E3A
6E32 A9 FF                        LDA     #$FF              ;
6E34 85 32                        STA     $32
6E36 85 33                        STA     $33               ;
6E38 30 DB                        BMI     loc_6E15
6E3A                
6E3A              loc_6E3A:
6E3A A5 5C                        LDA     $5C               ; Fast Timer
6E3C 29 07                        AND     #7
6E3E D0 31                        BNE     loc_6E71
6E40 AD 07 24                     LDA     $2407             ; Rotate Left Switch
6E43 10 04                        BPL     loc_6E49
6E45 A9 01                        LDA     #1
6E47 D0 07                        BNE     loc_6E50
6E49                
6E49              loc_6E49:
6E49 AD 06 24                     LDA     $2406             ; Rotate Right Switch
6E4C 10 23                        BPL     loc_6E71          ;
6E4E A9 FF                        LDA     #$FF              ;
6E50                
6E50              loc_6E50:
6E50 A6 0C                        LDX     $C                ;
6E52 18                           CLC     
6E53 75 34                        ADC     $34,X
6E55 30 10                        BMI     loc_6E67          ;
6E57 C9 0B                        CMP     #$B
6E59 B0 0E                        BCS     loc_6E69
6E5B C9 01                        CMP     #1                ;
6E5D F0 04                        BEQ     loc_6E63
6E5F A9 00                        LDA     #0
6E61 F0 0C                        BEQ     loc_6E6F
6E63                
6E63              loc_6E63:
6E63 A9 0B                        LDA     #$B               ;
6E65 D0 08                        BNE     loc_6E6F
6E67                
6E67              loc_6E67:
6E67 A9 24                        LDA     #$24              ;
6E69                
6E69              loc_6E69:
6E69 C9 25                        CMP     #$25              ;
6E6B 90 02                        BCC     loc_6E6F
6E6D A9 00                        LDA     #0                ;
6E6F                
6E6F              loc_6E6F:
6E6F
6E6F 95 34                        STA     $34,X             ;
6E71                
6E71              loc_6E71:
6E71
6E71 A9 00                        LDA     #0                ;
6E73 60                           RTS     
6E73              ; End of function sub_6D90
6E73                
6E74                
6E74              ; ��������������� S U B R O U T I N E ���������������������������������������
6E74                
6E74                
6E74              sub_6E74:
6E74 A5 1C                        LDA     $1C               ; Number Of Players In Current Game
6E76 F0 5F                        BEQ     locret_6ED7       ; None, Branch
6E78 AD 1B 02                     LDA     $21B              ; Player Flag
6E7B 30 5A                        BMI     locret_6ED7       ; Branch If Currently Exploding
6E7D AD FA 02                     LDA     $2FA              ;
6E80 D0 55                        BNE     locret_6ED7       ;
6E82 AD 03 20                     LDA     $2003             ; Hyperspace Switch
6E85 10 50                        BPL     locret_6ED7       ; Branch If NOT Pressed
6E87 A9 00                        LDA     #0                ;
6E89 8D 1B 02                     STA     $21B              ;
6E8C 8D 3E 02                     STA     $23E              ;
6E8F 8D 61 02                     STA     $261              ;
6E92 A9 30                        LDA     #$30              ;
6E94 8D FA 02                     STA     $2FA              ;
6E97 20 B5 77                     JSR     sub_77B5          ;
6E9A 29 1F                        AND     #$1F              ;
6E9C C9 1D                        CMP     #$1D              ;
6E9E 90 02                        BCC     loc_6EA2          ;
6EA0 A9 1C                        LDA     #$1C              ;
6EA2                
6EA2              loc_6EA2:
6EA2 C9 03                        CMP     #3                ;
6EA4 B0 02                        BCS     loc_6EA8          ;
6EA6 A9 03                        LDA     #3                ;
6EA8                
6EA8              loc_6EA8:
6EA8 8D 84 02                     STA     $284              ;
6EAB A2 05                        LDX     #5                ;
6EAD                
6EAD              loc_6EAD:
6EAD 20 B5 77                     JSR     sub_77B5          ;
6EB0 CA                           DEX                       ;
6EB1 D0 FA                        BNE     loc_6EAD          ;
6EB3 29 1F                        AND     #$1F              ;
6EB5 E8                           INX                       ; Assume Success ( X = 1 At This Point )
6EB6 C9 18                        CMP     #$18              ;
6EB8 90 0C                        BCC     loc_6EC6          ;
6EBA 29 07                        AND     #7                ;
6EBC 0A                           ASL     A                 ;
6EBD 69 04                        ADC     #4                ;
6EBF CD F6 02                     CMP     $2F6              ;
6EC2 90 02                        BCC     loc_6EC6          ;
6EC4 A2 80                        LDX     #$80              ; Flag Hyperspace Unsuccessful
6EC6                
6EC6              loc_6EC6:
6EC6
6EC6 C9 15                        CMP     #$15              ;
6EC8 90 02                        BCC     loc_6ECC          ;
6ECA A9 14                        LDA     #$14              ;
6ECC                
6ECC              loc_6ECC:
6ECC C9 03                        CMP     #3                ;
6ECE B0 02                        BCS     loc_6ED2          ;
6ED0 A9 03                        LDA     #3                ;
6ED2                
6ED2              loc_6ED2:
6ED2 8D A7 02                     STA     $2A7              ;
6ED5 86 59                        STX     $59               ; Hyperspace Flag
6ED7                
6ED7              locret_6ED7:
6ED7
6ED7 60                           RTS                       ;
6ED7              ; End of function sub_6E74
6ED7                
6ED8                
6ED8              ; ��������������� S U B R O U T I N E ���������������������������������������
6ED8                
6ED8                
6ED8              sub_6ED8:
6ED8
6ED8 A9 02                        LDA     #2                ;
6EDA 8D F5 02                     STA     $2F5              ;
6EDD A2 03                        LDX     #3                ; Assume A 3 Ship Game
6EDF 4E 02 28                     LSR     $2802             ; Shift Number Of Starting Ships Bit To Carry
6EE2 B0 01                        BCS     loc_6EE5          ; 3 Ship Game
6EE4 E8                           INX                       ; 4 Ship Game
6EE5                
6EE5              loc_6EE5:
6EE5 86 56                        STX     $56               ;
6EE7 A9 00                        LDA     #0                ;
6EE9 A2 04                        LDX     #4                ;
6EEB                
6EEB              loc_6EEB:
6EEB 9D 1B 02                     STA     $21B,X            ;
6EEE 9D 1F 02                     STA     $21F,X
6EF1 95 51                        STA     $51,X             ; *BUG* Should Be $52,X
6EF3 CA                           DEX     
6EF4 10 F5                        BPL     loc_6EEB          ;
6EF6 8D F6 02                     STA     $2F6
6EF9 60                           RTS                       ;
6EF9              ; End of function sub_6ED8
6EF9                
6EFA                
6EFA              ; ��������������� S U B R O U T I N E ���������������������������������������
6EFA                
6EFA                
6EFA              sub_6EFA:
6EFA
6EFA A9 00                        LDA     #0                ;
6EFC 8D 00 36                     STA     $3600
6EFF 8D 00 3A                     STA     $3A00
6F02 8D 00 3C                     STA     $3C00             ;
6F05 8D 01 3C                     STA     $3C01
6F08 8D 03 3C                     STA     $3C03
6F0B 8D 04 3C                     STA     $3C04
6F0E 8D 05 3C                     STA     $3C05             ;
6F11 85 69                        STA     $69
6F13 85 66                        STA     $66
6F15 85 67                        STA     $67
6F17 85 68                        STA     $68               ;
6F19 60                           RTS     
6F19              ; End of function sub_6EFA
6F19                
6F1A                
6F1A              ; ��������������� S U B R O U T I N E ���������������������������������������
6F1A                
6F1A                
6F1A              sub_6F1A:
6F1A
6F1A B9 34 00                     LDA     $34,Y             ;
6F1D 0A                           ASL     A
6F1E A8                           TAY     
6F1F D0 14                        BNE     sub_6F35          ;
6F21 A5 32                        LDA     $32
6F23 25 33                        AND     $33
6F25 30 0E                        BMI     sub_6F35          ;
6F27 A9 72                        LDA     #$72
6F29 A2 F8                        LDX     #$F8              ;
6F2B 20 45 7D                     JSR     sub_7D45
6F2E A9 01                        LDA     #1                ;
6F30 A2 F8                        LDX     #$F8
6F32 4C 45 7D                     JMP     sub_7D45          ;
6F32              ; End of function sub_6F1A
6F32                
6F35                
6F35              ; ��������������� S U B R O U T I N E ���������������������������������������
6F35                
6F35                
6F35              sub_6F35:
6F35
6F35 BE D5 56                     LDX     $56D5,Y           ;
6F38 B9 D4 56                     LDA     $56D4,Y
6F3B 4C 45 7D                     JMP     sub_7D45          ;
6F3B              ; End of function sub_6F35
6F3B                
6F3E                
6F3E              ; ��������������� S U B R O U T I N E ���������������������������������������
6F3E                
6F3E                
6F3E              sub_6F3E:
6F3E
6F3E F0 16                        BEQ     locret_6F56       ;
6F40 84 08                        STY     8
6F42 A2 D5                        LDX     #$D5
6F44 A0 E0                        LDY     #$E0              ;
6F46 84 00                        STY     0
6F48 20 03 7C                     JSR     sub_7C03
6F4B                
6F4B              loc_6F4B:
6F4B A2 DA                        LDX     #$DA              ;
6F4D A9 54                        LDA     #$54
6F4F 20 FC 7B                     JSR     sub_7BFC
6F52 C6 08                        DEC     8                 ;
6F54 D0 F5                        BNE     loc_6F4B
6F56                
6F56              locret_6F56:
6F56 60                           RTS                       ;
6F56              ; End of function sub_6F3E
6F56                
6F57                
6F57              ; ��������������� S U B R O U T I N E ���������������������������������������
6F57                
6F57                
6F57              sub_6F57:
6F57 A2 22                        LDX     #$22              ;
6F59                
6F59              loc_6F59:
6F59 BD 00 02                     LDA     $200,X
6F5C D0 04                        BNE     loc_6F62          ;
6F5E                
6F5E              loc_6F5E:
6F5E
6F5E CA                           DEX                       ;
6F5F 10 F8                        BPL     loc_6F59
6F61 60                           RTS                       ;
6F62              ; ---------------------------------------------------------------------------
6F62                
6F62              loc_6F62:
6F62 10 63                        BPL     loc_6FC7          ;
6F64 20 08 77                     JSR     sub_7708          ;
6F67 4A                           LSR     A
6F68 4A                           LSR     A                 ;
6F69 4A                           LSR     A
6F6A 4A                           LSR     A
6F6B E0 1B                        CPX     #$1B              ;
6F6D D0 07                        BNE     loc_6F76          ;
6F6F A5 5C                        LDA     $5C               ;
6F71 29 01                        AND     #1                ;
6F73 4A                           LSR     A
6F74 F0 01                        BEQ     loc_6F77          ;
6F76                
6F76              loc_6F76:
6F76 38                           SEC                       ;
6F77                
6F77              loc_6F77:
6F77 7D 00 02                     ADC     $200,X
6F7A 30 25                        BMI     loc_6FA1          ;
6F7C E0 1B                        CPX     #$1B
6F7E F0 13                        BEQ     loc_6F93
6F80 B0 17                        BCS     loc_6F99          ;
6F82 CE F6 02                     DEC     $2F6
6F85 D0 05                        BNE     loc_6F8C
6F87 A0 7F                        LDY     #$7F              ;
6F89 8C FB 02                     STY     $2FB              ;
6F8C                
6F8C              loc_6F8C:
6F8C
6F8C A9 00                        LDA     #0                ;
6F8E 9D 00 02                     STA     $200,X
6F91 F0 CB                        BEQ     loc_6F5E          ;
6F93                
6F93              loc_6F93:
6F93 20 E8 71                     JSR     sub_71E8          ;
6F96 4C 8C 6F                     JMP     loc_6F8C          ;
6F99              ; ---------------------------------------------------------------------------
6F99                
6F99              loc_6F99:
6F99 AD F8 02                     LDA     $2F8              ;
6F9C 8D F7 02                     STA     $2F7              ; Countdown Timer For When Saucer Appears
6F9F D0 EB                        BNE     loc_6F8C          ;
6FA1                
6FA1              loc_6FA1:
6FA1 9D 00 02                     STA     $200,X            ;
6FA4 29 F0                        AND     #$F0              ;
6FA6 18                           CLC                       ;
6FA7 69 10                        ADC     #$10              ;
6FA9 E0 1B                        CPX     #$1B
6FAB D0 02                        BNE     loc_6FAF
6FAD A9 00                        LDA     #0                ;
6FAF                
6FAF              loc_6FAF:
6FAF A8                           TAY                       ;
6FB0 BD AF 02                     LDA     $2AF,X
6FB3 85 04                        STA     4
6FB5 BD 69 02                     LDA     $269,X            ;
6FB8 85 05                        STA     5
6FBA BD D2 02                     LDA     $2D2,X
6FBD 85 06                        STA     6                 ;
6FBF BD 8C 02                     LDA     $28C,X
6FC2 85 07                        STA     7
6FC4 4C 27 70                     JMP     loc_7027          ;
6FC7              ; ---------------------------------------------------------------------------
6FC7                
6FC7              loc_6FC7:
6FC7 18                           CLC                       ;
6FC8 A0 00                        LDY     #0
6FCA BD 23 02                     LDA     $223,X
6FCD 10 01                        BPL     loc_6FD0          ;
6FCF 88                           DEY     
6FD0                
6FD0              loc_6FD0:
6FD0 7D AF 02                     ADC     $2AF,X            ;
6FD3 9D AF 02                     STA     $2AF,X
6FD6 85 04                        STA     4
6FD8 98                           TYA                       ;
6FD9 7D 69 02                     ADC     $269,X
6FDC C9 20                        CMP     #$20
6FDE 90 0C                        BCC     loc_6FEC          ;
6FE0 29 1F                        AND     #$1F
6FE2 E0 1C                        CPX     #$1C
6FE4 D0 06                        BNE     loc_6FEC          ;
6FE6 20 2D 70                     JSR     sub_702D
6FE9 4C 5E 6F                     JMP     loc_6F5E          ;
6FEC              ; ---------------------------------------------------------------------------
6FEC                
6FEC              loc_6FEC:
6FEC
6FEC 9D 69 02                     STA     $269,X            ;
6FEF 85 05                        STA     5
6FF1 18                           CLC     
6FF2 A0 00                        LDY     #0                ;
6FF4 BD 46 02                     LDA     $246,X
6FF7 10 02                        BPL     loc_6FFB
6FF9 A0 FF                        LDY     #$FF              ;
6FFB                
6FFB              loc_6FFB:
6FFB 7D D2 02                     ADC     $2D2,X
6FFE 9D D2 02                     STA     $2D2,X            ;
7001 85 06                        STA     6
7003 98                           TYA     
7004 7D 8C 02                     ADC     $28C,X
7007 C9 18                        CMP     #$18              ;
7009 90 08                        BCC     loc_7013
700B F0 04                        BEQ     loc_7011
700D A9 17                        LDA     #$17
700F D0 02                        BNE     loc_7013          ;
7011                
7011              loc_7011:
7011 A9 00                        LDA     #0                ;
7013                
7013              loc_7013:
7013
7013 9D 8C 02                     STA     $28C,X            ;
7016 85 07                        STA     7                 ;
7018 BD 00 02                     LDA     $200,X
701B A0 E0                        LDY     #$E0
701D 4A                           LSR     A                 ;
701E B0 07                        BCS     loc_7027
7020 A0 F0                        LDY     #$F0
7022 4A                           LSR     A
7023 B0 02                        BCS     loc_7027          ;
7025 A0 00                        LDY     #0                ;
7027                
7027              loc_7027:
7027
7027 20 FE 72                     JSR     sub_72FE          ;
702A 4C 5E 6F                     JMP     loc_6F5E          ;
702A              ; End of function sub_6F57
702A                
702D                
702D              ; ��������������� S U B R O U T I N E ���������������������������������������
702D                
702D                
702D              sub_702D:
702D
702D AD F8 02                     LDA     $2F8              ; Starting Value For Timer @ $02F7
7030 8D F7 02                     STA     $2F7              ; Countdown Timer For When Saucer Appears
7033 A9 00                        LDA     #0
7035 8D 1C 02                     STA     $21C              ; Saucer Flag
7038 8D 3F 02                     STA     $23F              ;
703B 8D 62 02                     STA     $262
703E 60                           RTS                       ;
703E              ; End of function sub_702D
703E                
703F                
703F              ; ��������������� S U B R O U T I N E ���������������������������������������
703F                
703F                
703F              sub_703F:
703F A5 1C                        LDA     $1C               ; Number Of Players In Current Game
7041 F0 42                        BEQ     locret_7085       ; None, Branch
7043 AD 1B 02                     LDA     $21B              ; Player Flag
7046 30 3D                        BMI     locret_7085       ; Branch If Currently Exploding
7048 AD FA 02                     LDA     $2FA              ;
704B F0 39                        BEQ     loc_7086          ;
704D CE FA 02                     DEC     $2FA              ;
7050 D0 33                        BNE     locret_7085       ;
7052 A4 59                        LDY     $59               ; Hyperspace Flag
7054 30 19                        BMI     loc_706F          ; Gonna Die From Hyperspace, Branch
7056 D0 10                        BNE     loc_7068          ; Successful Hyperspace, Branch
7058 20 39 71                     JSR     sub_7139          ;
705B D0 24                        BNE     loc_7081          ;
705D AC 1C 02                     LDY     $21C              ;
7060 F0 06                        BEQ     loc_7068          ;
7062 A0 02                        LDY     #2                ;
7064 8C FA 02                     STY     $2FA              ;
7067 60                           RTS                       ;
7068              ; ---------------------------------------------------------------------------
7068                
7068              loc_7068:
7068
7068 A9 01                        LDA     #1                ; Flag Ship OK
706A 8D 1B 02                     STA     $21B              ;
706D D0 12                        BNE     loc_7081          ; Will Always Branch
706F                
706F              loc_706F:
706F A9 A0                        LDA     #$A0              ; Switch To Explosion Timer
7071 8D 1B 02                     STA     $21B              ;
7074 A2 3E                        LDX     #$3E              ;
7076 86 69                        STX     $69               ;
7078 A6 18                        LDX     $18               ; Current Player
707A D6 57                        DEC     $57,X             ; Subtract Ship
707C A9 81                        LDA     #$81
707E 8D FA 02                     STA     $2FA              ;
7081                
7081              loc_7081:
7081
7081 A9 00                        LDA     #0                ;
7083 85 59                        STA     $59
7085                
7085              locret_7085:
7085
7085 60                           RTS                       ;
7086              ; ---------------------------------------------------------------------------
7086                
7086              loc_7086:
7086 AD 07 24                     LDA     $2407             ; Rotate Left Switch
7089 10 04                        BPL     loc_708F          ; Branch If NOT Pressed
708B A9 03                        LDA     #3                ;
708D D0 07                        BNE     loc_7096          ; Will Always Branch
708F                
708F              loc_708F:
708F AD 06 24                     LDA     $2406             ; Rotate Right Switch
7092 10 07                        BPL     loc_709B          ; Branch If NOT Pressed
7094 A9 FD                        LDA     #$FD              ;
7096                
7096              loc_7096:
7096 18                           CLC                       ;
7097 65 61                        ADC     $61               ; Current Ship Direction
7099 85 61                        STA     $61               ;
709B                
709B              loc_709B:
709B A5 5C                        LDA     $5C               ; Fast Timer
709D 4A                           LSR     A                 ;
709E B0 E5                        BCS     locret_7085       ;
70A0 AD 05 24                     LDA     $2405             ; Thrust Switch
70A3 10 3C                        BPL     loc_70E1          ; Branch If NOT Pressed
70A5 A9 80                        LDA     #$80              ;
70A7 8D 03 3C                     STA     $3C03             ; Ship Thrust Sound
70AA A0 00                        LDY     #0                ;
70AC A5 61                        LDA     $61               ; Current Ship Direction
70AE 20 D2 77                     JSR     sub_77D2          ;
70B1 10 01                        BPL     loc_70B4
70B3 88                           DEY                       ;
70B4                
70B4              loc_70B4:
70B4 0A                           ASL     A                 ;
70B5 18                           CLC     
70B6 65 64                        ADC     $64
70B8 AA                           TAX     
70B9 98                           TYA                       ;
70BA 6D 3E 02                     ADC     $23E
70BD 20 25 71                     JSR     sub_7125
70C0 8D 3E 02                     STA     $23E
70C3 86 64                        STX     $64               ;
70C5 A0 00                        LDY     #0
70C7 A5 61                        LDA     $61
70C9 20 D5 77                     JSR     sub_77D5          ;
70CC 10 01                        BPL     loc_70CF
70CE 88                           DEY                       ;
70CF                
70CF              loc_70CF:
70CF 0A                           ASL     A                 ;
70D0 18                           CLC     
70D1 65 65                        ADC     $65
70D3 AA                           TAX                       ;
70D4 98                           TYA     
70D5 6D 61 02                     ADC     $261
70D8 20 25 71                     JSR     sub_7125          ;
70DB 8D 61 02                     STA     $261
70DE 86 65                        STX     $65
70E0 60                           RTS                       ;
70E1              ; ---------------------------------------------------------------------------
70E1                
70E1              loc_70E1:
70E1 A9 00                        LDA     #0                ;
70E3 8D 03 3C                     STA     $3C03             ; Ship Thrust Sound
70E6 AD 3E 02                     LDA     $23E
70E9 05 64                        ORA     $64
70EB F0 18                        BEQ     loc_7105
70ED AD 3E 02                     LDA     $23E              ;
70F0 0A                           ASL     A
70F1 A2 FF                        LDX     #$FF
70F3 18                           CLC     
70F4 49 FF                        EOR     #$FF              ;
70F6 30 02                        BMI     loc_70FA
70F8 E8                           INX     
70F9 38                           SEC                       ;
70FA                
70FA              loc_70FA:
70FA 65 64                        ADC     $64
70FC 85 64                        STA     $64               ;
70FE 8A                           TXA     
70FF 6D 3E 02                     ADC     $23E
7102 8D 3E 02                     STA     $23E              ;
7105                
7105              loc_7105:
7105 A5 65                        LDA     $65               ;
7107 0D 61 02                     ORA     $261
710A F0 18                        BEQ     locret_7124
710C AD 61 02                     LDA     $261              ;
710F 0A                           ASL     A
7110 A2 FF                        LDX     #$FF
7112 18                           CLC     
7113 49 FF                        EOR     #$FF              ;
7115 30 02                        BMI     loc_7119
7117 38                           SEC     
7118 E8                           INX                       ;
7119                
7119              loc_7119:
7119 65 65                        ADC     $65
711B 85 65                        STA     $65               ;
711D 8A                           TXA     
711E 6D 61 02                     ADC     $261
7121 8D 61 02                     STA     $261              ;
7124                
7124              locret_7124:
7124 60                           RTS                       ;
7124              ; End of function sub_703F
7124                
7125                
7125              ; ��������������� S U B R O U T I N E ���������������������������������������
7125                
7125                
7125              sub_7125:
7125
7125 30 09                        BMI     loc_7130          ;
7127 C9 40                        CMP     #$40
7129 90 0D                        BCC     locret_7138
712B A2 FF                        LDX     #$FF              ;
712D A9 3F                        LDA     #$3F
712F 60                           RTS                       ;
7130              ; ---------------------------------------------------------------------------
7130                
7130              loc_7130:
7130 C9 C0                        CMP     #$C0
7132 B0 04                        BCS     locret_7138       ;
7134 A2 01                        LDX     #1
7136 A9 C0                        LDA     #$C0              ;
7138                
7138              locret_7138:
7138
7138 60                           RTS                       ;
7138              ; End of function sub_7125
7138                
7139                
7139              ; ��������������� S U B R O U T I N E ���������������������������������������
7139                
7139                
7139              sub_7139:
7139 A2 1C                        LDX     #$1C              ;
713B               
713B              loc_713B:
713B BD 00 02                     LDA     $200,X            ;
713E F0 1E                        BEQ     loc_715E
7140 BD 69 02                     LDA     $269,X
7143 38                           SEC                       ;
7144 ED 84 02                     SBC     $284
7147 C9 04                        CMP     #4                ;
7149 90 04                        BCC     loc_714F
714B C9 FC                        CMP     #$FC
714D 90 0F                        BCC     loc_715E          ;
714F                
714F              loc_714F:
714F BD 8C 02                     LDA     $28C,X            ;
7152 38                           SEC     
7153 ED A7 02                     SBC     $2A7
7156 C9 04                        CMP     #4                ;
7158 90 09                        BCC     loc_7163
715A C9 FC                        CMP     #$FC
715C B0 05                        BCS     loc_7163          ;
715E                
715E              loc_715E:
715E
715E CA                           DEX                       ;
715F 10 DA                        BPL     loc_713B
7161 E8                           INX     
7162 60                           RTS                       ;
7163              ; ---------------------------------------------------------------------------
7163                
7163              loc_7163:
7163
7163 EE FA 02                     INC     $2FA              ;
7166 60                           RTS                       ;
7166              ; End of function sub_7139
7166                
7166              ; ---------------------------------------------------------------------------
7167 90                           .BYTE  $90
7168                
7168              ; ��������������� S U B R O U T I N E ���������������������������������������
7168                
7168                
7168              sub_7168:
7168
7168 A2 1A                        LDX     #$1A              ;
716A AD FB 02                     LDA     $2FB
716D D0 70                        BNE     loc_71DF
716F AD 1C 02                     LDA     $21C              ; Saucer Flag
7172 D0 73                        BNE     locret_71E7       ; Branch If Saucer Is Currently Active
7174 8D 3F 02                     STA     $23F
7177 8D 62 02                     STA     $262
717A EE FD 02                     INC     $2FD
717D AD FD 02                     LDA     $2FD              ;
7180 C9 0B                        CMP     #$B
7182 90 03                        BCC     loc_7187
7184 CE FD 02                     DEC     $2FD              ;
7187                
7187              loc_7187:
7187 AD F5 02                     LDA     $2F5              ;
718A 18                           CLC     
718B 69 02                        ADC     #2
718D C9 0B                        CMP     #$B
718F 90 02                        BCC     loc_7193          ;
7191 A9 0B                        LDA     #$B               ;
7193                
7193              loc_7193:
7193 8D F6 02                     STA     $2F6              ;
7196 8D F5 02                     STA     $2F5
7199 85 08                        STA     8                 ;
719B A0 1C                        LDY     #$1C              ;
719D                
719D              loc_719D:
719D 20 B5 77                     JSR     sub_77B5          ;
71A0 29 18                        AND     #$18
71A2 09 04                        ORA     #4                ;
71A4 9D 00 02                     STA     $200,X
71A7 20 03 72                     JSR     sub_7203
71AA 20 B5 77                     JSR     sub_77B5          ;
71AD 4A                           LSR     A
71AE 29 1F                        AND     #$1F
71B0 90 13                        BCC     loc_71C5          ;
71B2 C9 18                        CMP     #$18
71B4 90 02                        BCC     loc_71B8
71B6 29 17                        AND     #$17              ;
71B8                
71B8              loc_71B8:
71B8 9D 8C 02                     STA     $28C,X            ;
71BB A9 00                        LDA     #0
71BD 9D 69 02                     STA     $269,X
71C0 9D AF 02                     STA     $2AF,X            ;
71C3 F0 0B                        BEQ     loc_71D0          ;
71C5                
71C5              loc_71C5:
71C5 9D 69 02                     STA     $269,X            ;
71C8 A9 00                        LDA     #0
71CA 9D 8C 02                     STA     $28C,X            ;
71CD 9D D2 02                     STA     $2D2,X            ;
71D0                
71D0              loc_71D0:
71D0 CA                           DEX     
71D1 C6 08                        DEC     8                 ;
71D3 D0 C8                        BNE     loc_719D
71D5 A9 7F                        LDA     #$7F
71D7 8D F7 02                     STA     $2F7              ; Countdown Timer For When Saucer Appears
71DA A9 30                        LDA     #$30
71DC 8D FC 02                     STA     $2FC              ; Starting Value For Timer @ $6E
71DF                
71DF              loc_71DF:
71DF A9 00                        LDA     #0                ;
71E1               
71E1              loc_71E1:
71E1 9D 00 02                     STA     $200,X            ;
71E4 CA                           DEX     
71E5 10 FA                        BPL     loc_71E1          ;
71E7                
71E7              locret_71E7:
71E7 60                           RTS                       ;
71E7              ; End of function sub_7168
71E7                
71E8                
71E8              ; ��������������� S U B R O U T I N E ���������������������������������������
71E8                
71E8                
71E8              sub_71E8:
71E8
71E8 A9 60                        LDA     #$60              ;
71EA 8D CA 02                     STA     $2CA
71ED 8D ED 02                     STA     $2ED
71F0 A9 00                        LDA     #0
71F2 8D 3E 02                     STA     $23E              ;
71F5 8D 61 02                     STA     $261
71F8 A9 10                        LDA     #$10
71FA 8D 84 02                     STA     $284
71FD A9 0C                        LDA     #$C               ;
71FF 8D A7 02                     STA     $2A7
7202 60                           RTS                       ;
7202              ; End of function sub_71E8
7202                
7203                
7203              ; ��������������� S U B R O U T I N E ���������������������������������������
7203                
7203                
7203              sub_7203:
7203
7203 20 B5 77                     JSR     sub_77B5          ;
7206 29 8F                        AND     #$8F
7208 10 02                        BPL     loc_720C
720A 09 F0                        ORA     #$F0              ;
720C              
720C              loc_720C:
720C 18                           CLC     
720D 79 23 02                     ADC     $223,Y
7210 20 33 72                     JSR     sub_7233          ;
7213 9D 23 02                     STA     $223,X
7216 20 B5 77                     JSR     sub_77B5
7219 20 B5 77                     JSR     sub_77B5          ;
721C 20 B5 77                     JSR     sub_77B5
721F 20 B5 77                     JSR     sub_77B5
7222 29 8F                        AND     #$8F              ;
7224 10 02                        BPL     loc_7228
7226 09 F0                        ORA     #$F0              ;
7228                
7228              loc_7228:
7228 18                           CLC                       ;
7229 79 46 02                     ADC     $246,Y
722C 20 33 72                     JSR     sub_7233          ;
722F 9D 46 02                     STA     $246,X
7232 60                           RTS                       ;
7232              ; End of function sub_7203
7232                
7233                
7233              ; ��������������� S U B R O U T I N E ���������������������������������������
7233                
7233                
7233              sub_7233:
7233
7233 10 0D                        BPL     loc_7242          ;
7235 C9 E1                        CMP     #$E1
7237 B0 02                        BCS     loc_723B
7239 A9 E1                        LDA     #$E1              ;
723B                
723B              loc_723B:
723B C9 FB                        CMP     #$FB              ;
723D 90 0F                        BCC     locret_724E
723F A9 FA                        LDA     #$FA              ;
7241 60                           RTS                       ;
7242              ; ---------------------------------------------------------------------------
7242                
7242              loc_7242:
7242 C9 06                        CMP     #6                ;
7244 B0 02                        BCS     loc_7248
7246 A9 06                        LDA     #6                ;
7248                
7248              loc_7248:
7248 C9 20                        CMP     #$20              ;
724A 90 02                        BCC     locret_724E
724C A9 1F                        LDA     #$1F              ;
724E                
724E              locret_724E:
724E
724E 60                           RTS                       ;
724E              ; End of function sub_7233
724E                
724F                
724F              ; ��������������� S U B R O U T I N E ���������������������������������������
724F                
724F                
724F              sub_724F:
724F A9 10                        LDA     #$10              ;
7251 85 00                        STA     0
7253 A9 50                        LDA     #$50              ;
7255 A2 A4                        LDX     #$A4
7257 20 FC 7B                     JSR     sub_7BFC
725A A9 19                        LDA     #$19              ;
725C A2 DB                        LDX     #$DB
725E 20 03 7C                     JSR     sub_7C03
7261 A9 70                        LDA     #$70
7263 20 DE 7C                     JSR     sub_7CDE
7266 A2 00                        LDX     #0
7268 A5 1C                        LDA     $1C               ; Number Of Players In Current Game
726A C9 02                        CMP     #2                ; 2 Players?
726C D0 18                        BNE     loc_7286          ; No, Branch
726E A5 18                        LDA     $18               ; Current Player
7270 D0 14                        BNE     loc_7286          ; Player 2? Yes, Branch
7272 A2 20                        LDX     #$20              ;
7274 AD 1B 02                     LDA     $21B              ; Player Flag
7277 05 59                        ORA     $59               ; Hyperspace Flag
7279 D0 0B                        BNE     loc_7286          ;
727B AD FA 02                     LDA     $2FA
727E 30 06                        BMI     loc_7286          ;
7280 A5 5C                        LDA     $5C               ; Fast Timer
7282 29 10                        AND     #$10              ;
7284 F0 0D                        BEQ     loc_7293          ;
7286                
7286              loc_7286:
7286
7286 A9 52                        LDA     #$52              ;
7288 A0 02                        LDY     #2
728A 38                           SEC                       ;
728B 20 3F 77                     JSR     sub_773F
728E A9 00                        LDA     #0                ;
7290 20 8B 77                     JSR     sub_778B
7293                
7293              loc_7293:
7293 A9 28                        LDA     #$28              ;
7295 A4 57                        LDY     $57               ; Number Of Ships Remaining, Player 1
7297 20 3E 6F                     JSR     sub_6F3E
729A A9 00                        LDA     #0
729C 85 00                        STA     0
729E A9 78                        LDA     #$78              ;
72A0 A2 DB                        LDX     #$DB
72A2 20 03 7C                     JSR     sub_7C03
72A5 A9 50                        LDA     #$50
72A7 20 DE 7C                     JSR     sub_7CDE
72AA A9 1D                        LDA     #$1D
72AC A0 02                        LDY     #2                ;
72AE 38                           SEC     
72AF 20 3F 77                     JSR     sub_773F          ;
72B2 A9 00                        LDA     #0
72B4 20 D1 7B                     JSR     sub_7BD1          ;
72B7 A9 10                        LDA     #$10
72B9 85 00                        STA     0
72BB A9 C0                        LDA     #$C0              ;
72BD A2 DB                        LDX     #$DB
72BF 20 03 7C                     JSR     sub_7C03
72C2 A9 50                        LDA     #$50
72C4 20 DE 7C                     JSR     sub_7CDE          ;
72C7 A2 00                        LDX     #0                ;
72C9 A5 1C                        LDA     $1C               ; Number Of Players In Current Game
72CB C9 01                        CMP     #1                ; Only 1 Player?
72CD F0 2E                        BEQ     locret_72FD       ; Yes, Branch
72CF 90 18                        BCC     loc_72E9          ;
72D1 A5 18                        LDA     $18               ; Current Player
72D3 F0 14                        BEQ     loc_72E9          ; Branch If Player 1
72D5 A2 20                        LDX     #$20              ;
72D7 AD 1B 02                     LDA     $21B              ; Player Flag
72DA 05 59                        ORA     $59               ; Hyperspace Flag
72DC D0 0B                        BNE     loc_72E9
72DE AD FA 02                     LDA     $2FA              ;
72E1 30 06                        BMI     loc_72E9
72E3 A5 5C                        LDA     $5C               ; Fast Timer
72E5 29 10                        AND     #$10              ;
72E7 F0 0D                        BEQ     loc_72F6          ;
72E9                
72E9              loc_72E9:
72E9
72E9 A9 54                        LDA     #$54              ;
72EB A0 02                        LDY     #2
72ED 38                           SEC     
72EE 20 3F 77                     JSR     sub_773F          ;
72F1 A9 00                        LDA     #0
72F3 20 8B 77                     JSR     sub_778B
72F6              
72F6              loc_72F6:
72F6 A9 CF                        LDA     #$CF              ;
72F8 A4 58                        LDY     $58               ; Current Number Of Ships, Player 2
72FA 4C 3E 6F                     JMP     sub_6F3E          ;
72FD              ; ---------------------------------------------------------------------------
72FD                
72FD              locret_72FD:
72FD 60                           RTS                       ;
72FD              ; End of function sub_724F
72FD                
72FE                
72FE              ; ��������������� S U B R O U T I N E ���������������������������������������
72FE                
72FE                
72FE              sub_72FE:
72FE 84 00                        STY     0                 ;
7300 86 0D                        STX     $D
7302 A5 05                        LDA     5
7304 4A                           LSR     A
7305 66 04                        ROR     4
7307 4A                           LSR     A                 ;
7308 66 04                        ROR     4
730A 4A                           LSR     A
730B 66 04                        ROR     4
730D 85 05                        STA     5                 ;
730F A5 07                        LDA     7
7311 18                           CLC     
7312 69 04                        ADC     #4
7314 4A                           LSR     A                 ;
7315 66 06                        ROR     6
7317 4A                           LSR     A
7318 66 06                        ROR     6
731A 4A                           LSR     A
731B 66 06                        ROR     6                 ;
731D 85 07                        STA     7
731F A2 04                        LDX     #4
7321 20 1C 7C                     JSR     sub_7C1C          ;
7324 A9 70                        LDA     #$70
7326 38                           SEC     
7327 E5 00                        SBC     0
7329 C9 A0                        CMP     #$A0              ;
732B 90 0E                        BCC     loc_733B          ;
732D                
732D              loc_732D:
732D 48                           PHA                       ;
732E A9 90                        LDA     #$90
7330 20 DE 7C                     JSR     sub_7CDE          ;
7333 68                           PLA     
7334 38                           SEC                       ;
7335 E9 10                        SBC     #$10
7337 C9 A0                        CMP     #$A0              ;
7339 B0 F2                        BCS     loc_732D          ;
733B                
733B              loc_733B:
733B 20 DE 7C                     JSR     sub_7CDE          ;
733E A6 0D                        LDX     $D
7340 BD 00 02                     LDA     $200,X
7343 10 16                        BPL     loc_735B          ;
7345 E0 1B                        CPX     #$1B
7347 F0 0C                        BEQ     loc_7355
7349 29 0C                        AND     #$C
734B 4A                           LSR     A                 ;
734C A8                           TAY     
734D B9 F8 50                     LDA     $50F8,Y
7350 BE F9 50                     LDX     $50F9,Y
7353 D0 1B                        BNE     loc_7370          ;
7355                
7355              loc_7355:
7355 20 65 74                     JSR     sub_7465          ;
7358 A6 0D                        LDX     $D
735A 60                           RTS                       ;
735B              ; ---------------------------------------------------------------------------
735B                
735B              loc_735B:
735B E0 1B                        CPX     #$1B              ;
735D F0 17                        BEQ     loc_7376
735F E0 1C                        CPX     #$1C
7361 F0 19                        BEQ     loc_737C
7363 B0 1F                        BCS     loc_7384          ;
7365 29 18                        AND     #$18
7367 4A                           LSR     A
7368 4A                           LSR     A
7369 A8                           TAY                       ;
736A B9 DE 51                     LDA     $51DE,Y
736D BE DF 51                     LDX     $51DF,Y           ;
7370                
7370              loc_7370:
7370
7370 20 45 7D                     JSR     sub_7D45          ;
7373 A6 0D                        LDX     $D
7375 60                           RTS                       ;
7376              ; ---------------------------------------------------------------------------
7376                
7376              loc_7376:
7376 20 0B 75                     JSR     sub_750B          ;
7379 A6 0D                        LDX     $D
737B 60                           RTS                       ;
737C              ; ---------------------------------------------------------------------------
737C                
737C              loc_737C:
737C AD 50 52                     LDA     $5250             ;
737F AE 51 52                     LDX     $5251
7382 D0 EC                        BNE     loc_7370          ;
7384                
7384              loc_7384:
7384 A9 70                        LDA     #$70              ;
7386 A2 F0                        LDX     #$F0
7388 20 E0 7C                     JSR     sub_7CE0          ;
738B A6 0D                        LDX     $D
738D A5 5C                        LDA     $5C               ; Fast Timer
738F 29 03                        AND     #3
7391 D0 03                        BNE     locret_7396       ;
7393 DE 00 02                     DEC     $200,X
7396                
7396              locret_7396:
7396 60                           RTS                       ;
7396              ; End of function sub_72FE
7396                
7397                
7397              ; ��������������� S U B R O U T I N E ���������������������������������������
7397                
7397                
7397              sub_7397:
7397
7397 F8                           SED                       ; Set Decimal Mode
7398 75 52                        ADC     $52,X             ; Add To Current Players Score, Tens
739A 95 52                        STA     $52,X             ;
739C 90 12                        BCC     loc_73B0          ; Increase In Thousands?, No, Branch
739E B5 53                        LDA     $53,X             ; Current Players Score, Thousands
73A0 69 00                        ADC     #0                ; Add In The Carry
73A2 95 53                        STA     $53,X
73A4 29 0F                        AND     #$F               ; Will Be 0 If Another 10,000 Points Reached
73A6 D0 08                        BNE     loc_73B0          ; Branch If Not Enough Points For Bonus Ship
73A8 A9 B0                        LDA     #$B0              ; Length Of Time To Play Bonus Ship Sound
73AA 85 68                        STA     $68               ; Into Timer
73AC A6 18                        LDX     $18               ; Current Player
73AE F6 57                        INC     $57,X             ; Award Bonus Ship
73B0                
73B0              loc_73B0:
73B0
73B0 D8                           CLD                       ; Clear Decimal Mode
73B1 60                           RTS                       ;
73B1              ; End of function sub_7397
73B1                
73B2                
73B2              ; ��������������� S U B R O U T I N E ���������������������������������������
73B2                
73B2                
73B2              sub_73B2:
73B2
73B2 A5 18                        LDA     $18               ; Current Player
73B4 0A                           ASL     A
73B5 0A                           ASL     A
73B6 85 08                        STA     8
73B8 A5 6F                        LDA     $6F
73BA 29 FB                        AND     #$FB
73BC 05 08                        ORA     8                 ;
73BE 85 6F                        STA     $6F
73C0 8D 00 32                     STA     $3200
73C3 60                           RTS                       ;
73C3              ; End of function sub_73B2
73C3                
73C4                
73C4              ; ��������������� S U B R O U T I N E ���������������������������������������
73C4                
73C4                
73C4              sub_73C4:
73C4 A5 1C                        LDA     $1C               ; Number Of Players In Current Game
73C6 F0 02                        BEQ     loc_73CA          ; None, Branch
73C8                
73C8              loc_73C8:
73C8
73C8 18                           CLC                       ;
73C9 60                           RTS     
73CA                
73CA              loc_73CA:
73CA A5 5D                        LDA     $5D               ; Slow Timer
73CC 29 04                        AND     #4
73CE D0 F8                        BNE     loc_73C8
73D0 A5 1D                        LDA     $1D               ; Highest Score In Table
73D2 05 1E                        ORA     $1E
73D4 F0 F2                        BEQ     loc_73C8          ; Table Empty, Branch
73D6 A0 00                        LDY     #0                ; Offset To "HIGH SCORE"
73D8 20 F6 77                     JSR     sub_77F6          ; And Draw To Screen
73DB A2 00                        LDX     #0
73DD 86 10                        STX     $10
73DF A9 01                        LDA     #1
73E1 85 00                        STA     0                 ;
73E3 A9 A7                        LDA     #$A7
73E5 85 0E                        STA     $E
73E7 A9 10                        LDA     #$10
73E9 85 00                        STA     0                 ;
73EB                
73EB              loc_73EB:
73EB B5 1D                        LDA     $1D,X             ; High Score Table
73ED 15 1E                        ORA     $1E,X             ;
73EF F0 67                        BEQ     loc_7458          ; No Score In This Entry, Branch
73F1 86 0F                        STX     $F
73F3 A9 5F                        LDA     #$5F              ;
73F5 A6 0E                        LDX     $E
73F7 20 03 7C                     JSR     sub_7C03
73FA A9 40                        LDA     #$40
73FC 20 DE 7C                     JSR     sub_7CDE          ;
73FF A5 0F                        LDA     $F
7401 4A                           LSR     A
7402 F8                           SED                       ; Set Decimal Mode
7403 69 01                        ADC     #1                ;
7405 D8                           CLD                       ; Clear Decimal Mode
7406 85 0D                        STA     $D
7408 A9 0D                        LDA     #$D
740A 38                           SEC                       ;
740B A0 01                        LDY     #1
740D A2 00                        LDX     #0
740F 20 3F 77                     JSR     sub_773F
7412 A9 40                        LDA     #$40              ;
7414 AA                           TAX     
7415 20 E0 7C                     JSR     sub_7CE0
7418 A0 00                        LDY     #0
741A 20 35 6F                     JSR     sub_6F35          ;
741D A5 0F                        LDA     $F
741F 18                           CLC     
7420 69 1D                        ADC     #$1D
7422 A0 02                        LDY     #2                ;
7424 38                           SEC     
7425 A2 00                        LDX     #0
7427 20 3F 77                     JSR     sub_773F
742A A9 00                        LDA     #0                ;
742C 20 D1 7B                     JSR     sub_7BD1
742F A0 00                        LDY     #0
7431 20 35 6F                     JSR     sub_6F35
7434 A4 10                        LDY     $10               ;
7436 20 1A 6F                     JSR     sub_6F1A
7439 E6 10                        INC     $10
743B A4 10                        LDY     $10
743D 20 1A 6F                     JSR     sub_6F1A          ;
7440 E6 10                        INC     $10
7442 A4 10                        LDY     $10
7444 20 1A 6F                     JSR     sub_6F1A
7447 E6 10                        INC     $10               ;
7449 A5 0E                        LDA     $E
744B 38                           SEC     
744C E9 08                        SBC     #8
744E 85 0E                        STA     $E                ;
7450 A6 0F                        LDX     $F                ;
7452 E8                           INX                       ;
7453 E8                           INX                       ; Point To Next Entry In Table
7454 E0 14                        CPX     #$14              ; End Of Table?
7456 90 93                        BCC     loc_73EB          ; No, Branch
7458                
7458              loc_7458:
7458 38                           SEC     
7459 60                           RTS                       ;
7459              ; End of function sub_73C4
7459                
745A                
745A              ; ��������������� S U B R O U T I N E ���������������������������������������
745A                
745A                
745A              sub_745A:
745A A2 1A                        LDX     #$1A              ;
745A              ; End of function sub_745A
745A                
745C                
745C              ; ��������������� S U B R O U T I N E ���������������������������������������
745C                
745C                
745C              sub_745C:
745C
745C BD 00 02                     LDA     $200,X            ;
745F F0 03                        BEQ     locret_7464
7461 CA                           DEX     
7462 10 F8                        BPL     sub_745C          ;
7464                
7464              locret_7464:
7464 60                           RTS                       ;
7464              ; End of function sub_745C
7464                
7465                
7465              ; ��������������� S U B R O U T I N E ���������������������������������������
7465                
7465                
7465              sub_7465:
7465 AD 1B 02                     LDA     $21B              ;
7468 C9 A2                        CMP     #$A2
746A B0 22                        BCS     loc_748E          ;
746C A2 0A                        LDX     #$A
746E                
746E              loc_746E:
746E BD EC 50                     LDA     $50EC,X           ;
7471 4A                           LSR     A
7472 4A                           LSR     A
7473 4A                           LSR     A
7474 4A                           LSR     A
7475 18                           CLC                       ;
7476 69 F8                        ADC     #$F8
7478 49 F8                        EOR     #$F8
747A 95 7E                        STA     $7E,X
747C BD ED 50                     LDA     $50ED,X           ;
747F 4A                           LSR     A
7480 4A                           LSR     A
7481 4A                           LSR     A
7482 4A                           LSR     A                 ;
7483 18                           CLC     
7484 69 F8                        ADC     #$F8
7486 49 F8                        EOR     #$F8
7488 95 8A                        STA     $8A,X             ;
748A CA                           DEX     
748B CA                           DEX     
748C 10 E0                        BPL     loc_746E          ;
748E                
748E              loc_748E:
748E AD 1B 02                     LDA     $21B              ;
7491 49 FF                        EOR     #$FF
7493 29 70                        AND     #$70
7495 4A                           LSR     A                 ;
7496 4A                           LSR     A
7497 4A                           LSR     A
7498 AA                           TAX                       ;
7499                
7499              loc_7499:
7499 86 09                        STX     9
749B A0 00                        LDY     #0                ;
749D BD EC 50                     LDA     $50EC,X
74A0 10 01                        BPL     loc_74A3
74A2 88                           DEY                       ;
74A3                
74A3              loc_74A3:
74A3 18                           CLC                       ;
74A4 75 7D                        ADC     $7D,X
74A6 95 7D                        STA     $7D,X
74A8 98                           TYA                       ;
74A9 75 7E                        ADC     $7E,X
74AB 95 7E                        STA     $7E,X
74AD 85 04                        STA     4
74AF 84 05                        STY     5                 ;
74B1 A0 00                        LDY     #0
74B3 BD ED 50                     LDA     $50ED,X
74B6 10 01                        BPL     loc_74B9
74B8 88                           DEY                       ;
74B9                
74B9              loc_74B9:
74B9 18                           CLC                       ;
74BA 75 89                        ADC     $89,X
74BC 95 89                        STA     $89,X
74BE 98                           TYA     
74BF 75 8A                        ADC     $8A,X             ;
74C1 95 8A                        STA     $8A,X
74C3 85 06                        STA     6
74C5 84 07                        STY     7
74C7 A5 02                        LDA     2                 ;
74C9 85 0B                        STA     $B
74CB A5 03                        LDA     3
74CD 85 0C                        STA     $C
74CF 20 49 7C                     JSR     sub_7C49          ;
74D2 A4 09                        LDY     9
74D4 B9 E0 50                     LDA     $50E0,Y
74D7 BE E1 50                     LDX     $50E1,Y
74DA 20 45 7D                     JSR     sub_7D45          ;
74DD A4 09                        LDY     9
74DF B9 E1 50                     LDA     $50E1,Y
74E2 49 04                        EOR     #4
74E4 AA                           TAX                       ;
74E5 B9 E0 50                     LDA     $50E0,Y
74E8 29 0F                        AND     #$F
74EA 49 04                        EOR     #4
74EC 20 45 7D                     JSR     sub_7D45          ;
74EF A0 FF                        LDY     #$FF              ;
74F1                
74F1              loc_74F1:
74F1 C8                           INY                       ;
74F2 B1 0B                        LDA     ($B),Y
74F4 91 02                        STA     (2),Y
74F6 C8                           INY     
74F7 B1 0B                        LDA     ($B),Y            ;
74F9 49 04                        EOR     #4
74FB 91 02                        STA     (2),Y
74FD C0 03                        CPY     #3
74FF 90 F0                        BCC     loc_74F1          ;
7501 20 39 7C                     JSR     sub_7C39
7504 A6 09                        LDX     9
7506 CA                           DEX     
7507 CA                           DEX                       ;
7508 10 8F                        BPL     loc_7499
750A 60                           RTS                       ;
750A              ; End of function sub_7465
750A                
750B                
750B              ; ��������������� S U B R O U T I N E ���������������������������������������
750B                
750B                
750B              sub_750B:
750B A2 00                        LDX     #0                ;
750D 86 17                        STX     $17               ;
750F A0 00                        LDY     #0                ;
7511 A5 61                        LDA     $61               ; Ship Direction
7513 10 06                        BPL     loc_751B          ;
7515 A0 04                        LDY     #4
7517 8A                           TXA     
7518 38                           SEC     
7519 E5 61                        SBC     $61               ;
751B                
751B              loc_751B:
751B 85 08                        STA     8                 ;
751D 24 08                        BIT     8
751F 30 02                        BMI     loc_7523
7521 50 07                        BVC     loc_752A          ;
7523                
7523              loc_7523:
7523 A2 04                        LDX     #4                ;
7525 A9 80                        LDA     #$80
7527 38                           SEC     
7528 E5 08                        SBC     8                 ;
752A                
752A              loc_752A:
752A 86 08                        STX     8                 ;
752C 84 09                        STY     9
752E 4A                           LSR     A
752F 29 FE                        AND     #$FE
7531 A8                           TAY                       ;
7532 B9 6E 52                     LDA     $526E,Y
7535 BE 6F 52                     LDX     $526F,Y
7538 20 D3 6A                     JSR     sub_6AD3
753B AD 05 24                     LDA     $2405             ; Thrust Switch
753E 10 14                        BPL     locret_7554       ; Branch If NOT Pressed
7540 A5 5C                        LDA     $5C               ; Fast Timer
7542 29 04                        AND     #4
7544 F0 0E                        BEQ     locret_7554       ;
7546 C8                           INY     
7547 C8                           INY     
7548 38                           SEC     
7549 A6 0C                        LDX     $C                ;
754B 98                           TYA     
754C 65 0B                        ADC     $B
754E 90 01                        BCC     loc_7551
7550 E8                           INX                       ;
7551                
7551              loc_7551:
7551 20 D3 6A                     JSR     sub_6AD3          ;
7554                
7554              locret_7554:
7554
7554 60                           RTS                       ;
7554              ; End of function sub_750B
7554                
7555                
7555              ; ��������������� S U B R O U T I N E ���������������������������������������
7555                
7555                
7555              sub_7555:
7555 A5 1C                        LDA     $1C               ; Number Of Players In Current Game
7557 D0 01                        BNE     loc_755A          ; Branch If At Least 1 Player Left
7559 60                           RTS                       ;
755A              ; ---------------------------------------------------------------------------
755A                
755A              loc_755A:
755A A2 00                        LDX     #0                ;
755C AD 1C 02                     LDA     $21C              ; Saucer Flag
755F 30 0A                        BMI     loc_756B          ; Currently Exploding, Branch
7561 F0 08                        BEQ     loc_756B          ; No Active Saucer, Branch
7563 6A                           ROR     A
7564 6A                           ROR     A
7565 6A                           ROR     A
7566 8D 02 3C                     STA     $3C02             ; Saucer Sound Select
7569 A2 80                        LDX     #$80
756B                
756B              loc_756B:
756B
756B 8E 00 3C                     STX     $3C00             ; Saucer Sound
756E A2 01                        LDX     #1
7570 20 CD 75                     JSR     sub_75CD
7573 8D 01 3C                     STA     $3C01             ; Saucer Fire Sound
7576 CA                           DEX     
7577 20 CD 75                     JSR     sub_75CD
757A 8D 04 3C                     STA     $3C04             ; Ship Fire Sound
757D AD 1B 02                     LDA     $21B
7580 C9 01                        CMP     #1
7582 F0 04                        BEQ     loc_7588
7584 8A                           TXA     
7585 8D 03 3C                     STA     $3C03             ; Ship Thrust Sound
7588                
7588              loc_7588:
7588 AD F6 02                     LDA     $2F6              ;
758B F0 11                        BEQ     loc_759E          ;
758D AD 1B 02                     LDA     $21B              ; Player Flag
7590 30 0C                        BMI     loc_759E          ; Currently Exploding, Branch
7592 05 59                        ORA     $59               ; Hyperspace Flag
7594 F0 08                        BEQ     loc_759E          ;
7596 A5 6D                        LDA     $6D               ;
7598 F0 14                        BEQ     loc_75AE          ;
759A C6 6D                        DEC     $6D               ;
759C D0 21                        BNE     loc_75BF          ;
759E                
759E              loc_759E:
759E
759E A5 6C                        LDA     $6C               ; Current Volume And Frequency Of THUMP Sound
75A0 29 0F                        AND     #$F               ; Mask Off Frequency Control
75A2 85 6C                        STA     $6C
75A4 8D 00 3A                     STA     $3A00             ; Turn Off Volume, Retain Current Frequency
75A7 AD FC 02                     LDA     $2FC              ;
75AA 85 6E                        STA     $6E
75AC 10 11                        BPL     loc_75BF          ;
75AE                
75AE              loc_75AE:
75AE C6 6E                        DEC     $6E               ;
75B0 D0 0D                        BNE     loc_75BF
75B2 A9 04                        LDA     #4
75B4 85 6D                        STA     $6D
75B6 A5 6C                        LDA     $6C               ;
75B8 49 14                        EOR     #$14              ; Turn On Volume, Switch Frequency
75BA 85 6C                        STA     $6C               ; Store It In Current Settings
75BC 8D 00 3A                     STA     $3A00             ; Make The Change
75BF                
75BF              loc_75BF:
75BF
75BF A5 69                        LDA     $69               ;
75C1 AA                           TAX     
75C2 29 3F                        AND     #$3F
75C4 F0 01                        BEQ     loc_75C7
75C6 CA                           DEX                       ;
75C7                
75C7              loc_75C7:
75C7 86 69                        STX     $69               ;
75C9 8E 00 36                     STX     $3600             ; Explosion Pitch/Volume
75CC 60                           RTS                       ;
75CC              ; End of function sub_7555
75CC                
75CD                
75CD              ; ��������������� S U B R O U T I N E ���������������������������������������
75CD
75CD              ; Fire Sound Handling
75CD                
75CD                
75CD              sub_75CD:
75CD
75CD B5 6A                        LDA     $6A,X             ; X = 0 Ship Fire, X = 1 Saucer Fire
75CF 30 0C                        BMI     loc_75DD
75D1 B5 66                        LDA     $66,X
75D3 10 12                        BPL     loc_75E7          ;
75D5 A9 10                        LDA     #$10
75D7 95 66                        STA     $66,X             ; TIMER: Length Of Time Sound Is On
75D9                
75D9              loc_75D9:
75D9 A9 80                        LDA     #$80              ; Turn Fire Sound On
75DB 30 0C                        BMI     loc_75E9          ; Will Always Branch
75DD                
75DD              loc_75DD:
75DD B5 66                        LDA     $66,X             ;
75DF F0 06                        BEQ     loc_75E7
75E1 30 04                        BMI     loc_75E7
75E3 D6 66                        DEC     $66,X
75E5 D0 F2                        BNE     loc_75D9          ;
75E7                
75E7              loc_75E7:
75E7
75E7 A9 00                        LDA     #0                ; Turn Fire Sound Off
75E9                
75E9              loc_75E9:
75E9 95 6A                        STA     $6A,X             ;
75EB 60                           RTS                       ;
75EB              ; End of function sub_75CD
75EB                
75EC                
75EC              ; ��������������� S U B R O U T I N E ���������������������������������������
75EC                
75EC                
75EC              sub_75EC:
75EC 86 0D                        STX     $D                ;
75EE A9 50                        LDA     #$50
75F0 8D F9 02                     STA     $2F9
75F3 B9 00 02                     LDA     $200,Y
75F6 29 78                        AND     #$78              ;
75F8 85 0E                        STA     $E
75FA B9 00 02                     LDA     $200,Y
75FD 29 07                        AND     #7
75FF 4A                           LSR     A                 ;
7600 AA                           TAX     
7601 F0 02                        BEQ     loc_7605
7603 05 0E                        ORA     $E                ;
7605                
7605              loc_7605:
7605 99 00 02                     STA     $200,Y            ;
7608 A5 1C                        LDA     $1C               ; Number Of Players In Current Game
760A F0 11                        BEQ     loc_761D          ; None, Branch
760C A5 0D                        LDA     $D
760E F0 04                        BEQ     loc_7614
7610 C9 04                        CMP     #4
7612 90 09                        BCC     loc_761D          ;
7614                
7614              loc_7614:
7614 BD 59 76                     LDA     $7659,X           ;
7617 A6 19                        LDX     $19
7619 18                           CLC     
761A 20 97 73                     JSR     sub_7397          ;
761D                
761D              loc_761D:
761D
761D BE 00 02                     LDX     $200,Y            ;
7620 F0 34                        BEQ     loc_7656
7622 20 5A 74                     JSR     sub_745A
7625 30 2F                        BMI     loc_7656
7627 EE F6 02                     INC     $2F6              ;
762A 20 9D 6A                     JSR     sub_6A9D
762D 20 03 72                     JSR     sub_7203
7630 BD 23 02                     LDA     $223,X
7633 29 1F                        AND     #$1F              ;
7635 0A                           ASL     A
7636 5D AF 02                     EOR     $2AF,X
7639 9D AF 02                     STA     $2AF,X
763C 20 5C 74                     JSR     sub_745C          ;
763F 30 15                        BMI     loc_7656
7641 EE F6 02                     INC     $2F6
7644 20 9D 6A                     JSR     sub_6A9D
7647 20 03 72                     JSR     sub_7203          ;
764A BD 46 02                     LDA     $246,X
764D 29 1F                        AND     #$1F
764F 0A                           ASL     A
7650 5D D2 02                     EOR     $2D2,X            ;
7653 9D D2 02                     STA     $2D2,X            ;
7656                
7656              loc_7656:
7656
7656 A6 0D                        LDX     $D                ;
7658 60                           RTS                       ;
7658              ; End of function sub_75EC
7658                
7658              ; ---------------------------------------------------------------------------
7659 10                           .BYTE  $10                ; 100 Points
765A 05                           .BYTE    5                ; 50 Points
765B 02                           .BYTE    2                ; 20 Points
765C                
765C              ; ��������������� S U B R O U T I N E ���������������������������������������
765C                
765C                
765C              sub_765C:
765C A5 1C                        LDA     $1C               ; Number Of Players In Current Game
765E 10 38                        BPL     locret_7698
7660 A2 02                        LDX     #2                ;
7662 85 5D                        STA     $5D               ; Slow Timer
7664 85 32                        STA     $32
7666 85 33                        STA     $33               ;
7668                
7668              loc_7668:
7668 A0 00                        LDY     #0                ;
766A                
766A              loc_766A:
766A B9 1D 00                     LDA     $1D,Y             ; High Score Table, Tens
766D D5 52                        CMP     $52,X             ; Player Score, Tens
766F B9 1E 00                     LDA     $1E,Y             ; High Score Table, Thousands
7672 F5 53                        SBC     $53,X             ;
7674 90 23                        BCC     loc_7699          ;
7676 C8                           INY     
7677 C8                           INY     
7678 C0 14                        CPY     #$14
767A 90 EE                        BCC     loc_766A          ;
767C                
767C              loc_767C:
767C CA                           DEX                       ;
767D CA                           DEX     
767E 10 E8                        BPL     loc_7668
7680 A5 33                        LDA     $33
7682 30 0E                        BMI     loc_7692          ;
7684 C5 32                        CMP     $32
7686 90 0A                        BCC     loc_7692
7688 69 02                        ADC     #2
768A C9 1E                        CMP     #$1E              ;
768C 90 02                        BCC     loc_7690
768E A9 FF                        LDA     #$FF              ;
7690                
7690              loc_7690:
7690 85 33                        STA     $33               ;
7692                
7692              loc_7692:
7692
7692 A9 00                        LDA     #0                ;
7694 85 1C                        STA     $1C
7696 85 31                        STA     $31
7698                
7698              locret_7698:
7698 60                           RTS                       ;
7699              ; ---------------------------------------------------------------------------
7699                
7699              loc_7699:
7699 86 0B                        STX     $B                ;
769B 84 0C                        STY     $C
769D 8A                           TXA     
769E 4A                           LSR     A
769F AA                           TAX                       ;
76A0 98                           TYA     
76A1 4A                           LSR     A
76A2 65 0C                        ADC     $C
76A4 85 0D                        STA     $D                ;
76A6 95 32                        STA     $32,X
76A8 A2 1B                        LDX     #$1B
76AA A0 12                        LDY     #$12              ;
76AC                
76AC              loc_76AC:
76AC E4 0D                        CPX     $D                ;
76AE F0 1F                        BEQ     loc_76CF
76B0 B5 31                        LDA     $31,X
76B2 95 34                        STA     $34,X
76B4 B5 32                        LDA     $32,X             ;
76B6 95 35                        STA     $35,X
76B8 B5 33                        LDA     $33,X
76BA 95 36                        STA     $36,X
76BC B9 1B 00                     LDA     $1B,Y             ;
76BF 99 1D 00                     STA     $1D,Y
76C2 B9 1C 00                     LDA     $1C,Y
76C5 99 1E 00                     STA     $1E,Y
76C8 88                           DEY                       ;
76C9 88                           DEY     
76CA CA                           DEX     
76CB CA                           DEX     
76CC CA                           DEX     
76CD D0 DD                        BNE     loc_76AC          ;
76CF                
76CF              loc_76CF:
76CF A9 0B                        LDA     #$B               ;
76D1 95 34                        STA     $34,X
76D3 A9 00                        LDA     #0
76D5 95 35                        STA     $35,X
76D7 95 36                        STA     $36,X
76D9 A9 F0                        LDA     #$F0              ;
76DB 85 5D                        STA     $5D               ; Slow Timer
76DD A6 0B                        LDX     $B
76DF A4 0C                        LDY     $C
76E1 B5 53                        LDA     $53,X             ; Players Score, Thousands
76E3 99 1E 00                     STA     $1E,Y
76E6 B5 52                        LDA     $52,X             ; Players Score, Tens
76E8 99 1D 00                     STA     $1D,Y
76EB A0 00                        LDY     #0                ;
76ED F0 8D                        BEQ     loc_767C
76EF                
76EF DF                           .BYTE   $DF               ;
76F0              ; ---------------------------------------------------------------------------
76F0 98                           TYA                       ;
76F1 10 09                        BPL     loc_76FC          ;
76F1              ; End of function sub_765C
76F1
76F3 20 08 77                     JSR     sub_7708          ;
76F6 20 FC 76                     JSR     loc_76FC
76F9 4C 08 77                     JMP     sub_7708          ;
76FC              ; ---------------------------------------------------------------------------
76FC
76FC              loc_76FC:
76FC
76FC A8                           TAY                       ;
76FD 8A                           TXA     
76FE 10 0E                        BPL     sub_770E
7700 20 08 77                     JSR     sub_7708
7703 20 0E 77                     JSR     sub_770E
7706 49 80                        EOR     #$80              ;
7708                
7708              ; ��������������� S U B R O U T I N E ���������������������������������������
7708                
7708                
7708              sub_7708:
7708
7708 49 FF                        EOR     #$FF              ;
770A 18                           CLC     
770B 69 01                        ADC     #1
770D 60                           RTS                       ;
770D              ; End of function sub_7708
770D                
770E                
770E              ; ��������������� S U B R O U T I N E ���������������������������������������
770E                
770E                
770E              sub_770E:
770E
770E 85 0C                        STA     $C                ;
7710 98                           TYA     
7711 C5 0C                        CMP     $C
7713 F0 10                        BEQ     loc_7725
7715 90 11                        BCC     sub_7728          ;
7717 A4 0C                        LDY     $C
7719 85 0C                        STA     $C
771B 98                           TYA     
771C 20 28 77                     JSR     sub_7728          ;
771F 38                           SEC     
7720 E9 40                        SBC     #$40
7722 4C 08 77                     JMP     sub_7708          ;
7725              ; ---------------------------------------------------------------------------
7725                
7725              loc_7725:
7725 A9 20                        LDA     #$20              ;
7727 60                           RTS     
7727              ; End of function sub_770E
7727                
7728                
7728              ; ��������������� S U B R O U T I N E ���������������������������������������
7728                
7728                
7728              sub_7728:
7728
7728 20 6C 77                     JSR     sub_776C          ;
772B BD 2F 77                     LDA     $772F,X
772E 60                           RTS                       ;
772E              ; End of function sub_7728
772E                
772E              ; ---------------------------------------------------------------------------
772F 00                           .BYTE    0  
7730 02                           .BYTE    2  
7731 05                           .BYTE    5  
7732 07                           .BYTE    7  
7733 0A                           .BYTE   $A  
7734 0C                           .BYTE   $C  
7735 0F                           .BYTE   $F  
7736 11                           .BYTE  $11  
7737 13                           .BYTE  $13  
7738 15                           .BYTE  $15  
7739 17                           .BYTE  $17  
773A 19                           .BYTE  $19  
773B 1A                           .BYTE  $1A  
773C 1C                           .BYTE  $1C  
773D 1D                           .BYTE  $1D  
773E 1F                           .BYTE  $1F  
773F                
773F              ; ��������������� S U B R O U T I N E ���������������������������������������
773F                
773F                
773F              sub_773F:
773F
773F 08                           PHP                       ;
7740 86 17                        STX     $17
7742 88                           DEY     
7743 84 16                        STY     $16
7745 18                           CLC                       ;
7746 65 16                        ADC     $16
7748 85 15                        STA     $15
774A 28                           PLP     
774B AA                           TAX                       ;
774C                
774C              loc_774C:
774C 08                           PHP                       ;
774D B5 00                        LDA     0,X
774F 4A                           LSR     A
7750 4A                           LSR     A
7751 4A                           LSR     A                 ;
7752 4A                           LSR     A
7753 28                           PLP     
7754 20 85 77                     JSR     sub_7785
7757 A5 16                        LDA     $16               ;
7759 D0 01                        BNE     loc_775C
775B 18                           CLC                       ;
775C                
775C              loc_775C:
775C A6 15                        LDX     $15               ;
775E B5 00                        LDA     0,X
7760 20 85 77                     JSR     sub_7785
7763 C6 15                        DEC     $15
7765 A6 15                        LDX     $15               ;
7767 C6 16                        DEC     $16
7769 10 E1                        BPL     loc_774C
776B 60                           RTS                       ;
776B              ; End of function sub_773F
776B                
776C                
776C              ; ��������������� S U B R O U T I N E ���������������������������������������
776C                
776C                
776C              sub_776C:
776C A0 00                        LDY     #0                ;
776E 84 0B                        STY     $B
7770 A0 04                        LDY     #4                ;
7772                
7772              loc_7772:
7772 26 0B                        ROL     $B                ;
7774 2A                           ROL     A
7775 C5 0C                        CMP     $C
7777 90 02                        BCC     loc_777B          ;
7779 E5 0C                        SBC     $C                ;
777B                
777B              loc_777B:
777B 88                           DEY                       ;
777C D0 F4                        BNE     loc_7772
777E A5 0B                        LDA     $B
7780 2A                           ROL     A
7781 29 0F                        AND     #$F               ;
7783 AA                           TAX     
7784 60                           RTS                       ;
7784              ; End of function sub_776C
7784                
7785                
7785              ; ��������������� S U B R O U T I N E ���������������������������������������
7785                
7785                
7785              sub_7785:
7785
7785 90 04                        BCC     sub_778B          ;
7787 29 0F                        AND     #$F
7789 F0 27                        BEQ     loc_77B2          ;
7789              ; End of function sub_7785
7789                
778B                
778B              ; ��������������� S U B R O U T I N E ���������������������������������������
778B                
778B                
778B              sub_778B:
778B
778B A6 17                        LDX     $17               ;
778D F0 23                        BEQ     loc_77B2
778F 29 0F                        AND     #$F
7791 18                           CLC     
7792 69 01                        ADC     #1                ;
7794 08                           PHP     
7795 0A                           ASL     A
7796 A8                           TAY     
7797 B9 D4 56                     LDA     $56D4,Y           ;
779A 0A                           ASL     A
779B 85 0B                        STA     $B
779D B9 D5 56                     LDA     $56D5,Y
77A0 2A                           ROL     A                 ;
77A1 29 1F                        AND     #$1F
77A3 09 40                        ORA     #$40
77A5 85 0C                        STA     $C
77A7 A9 00                        LDA     #0                ;
77A9 85 08                        STA     8
77AB 85 09                        STA     9
77AD 20 D7 6A                     JSR     sub_6AD7
77B0 28                           PLP                       ;
77B1 60                           RTS                       ;
77B2              ; ---------------------------------------------------------------------------
77B2                
77B2              loc_77B2:
77B2
77B2 4C CB 7B                     JMP     loc_7BCB          ;
77B2              ; End of function sub_778B
77B2                
77B5                
77B5              ; ��������������� S U B R O U T I N E ���������������������������������������
77B5                
77B5                
77B5              sub_77B5:
77B5
77B5 06 5F                        ASL     $5F               ;
77B7 26 60                        ROL     $60
77B9 10 02                        BPL     loc_77BD
77BB E6 5F                        INC     $5F               ;
77BD                
77BD              loc_77BD:
77BD A5 5F                        LDA     $5F               ;
77BF 2C D1 77                     BIT     byte_77D1
77C2 F0 04                        BEQ     loc_77C8          ;
77C4 49 01                        EOR     #1
77C6 85 5F                        STA     $5F               ;
77C8                
77C8              loc_77C8:
77C8 05 60                        ORA     $60               ;
77CA D0 02                        BNE     loc_77CE
77CC E6 5F                        INC     $5F               ;
77CE                
77CE              loc_77CE:
77CE A5 5F                        LDA     $5F               ;
77D0 60                           RTS                       ;
77D0              ; End of function sub_77B5
77D0              
77D0              ; ---------------------------------------------------------------------------
77D1 02           byte_77D1:      .BYTE 2
77D2                
77D2              ; ��������������� S U B R O U T I N E ���������������������������������������
77D2                
77D2                
77D2              sub_77D2:
77D2
77D2 18                           CLC                       ;
77D3 69 40                        ADC     #$40              ;
77D3              ; End of function sub_77D2
77D3                
77D5                
77D5              ; ��������������� S U B R O U T I N E ���������������������������������������
77D5                
77D5                
77D5              sub_77D5:
77D5
77D5 10 08                        BPL     sub_77DF          ;
77D7 29 7F                        AND     #$7F
77D9 20 DF 77                     JSR     sub_77DF
77DC 4C 08 77                     JMP     sub_7708          ;
77DC              ; End of function sub_77D5
77DC                
77DF                
77DF              ; ��������������� S U B R O U T I N E ���������������������������������������
77DF                
77DF                
77DF              sub_77DF:
77DF
77DF C9 41                        CMP     #$41              ;
77E1 90 04                        BCC     loc_77E7
77E3 49 7F                        EOR     #$7F
77E5 69 00                        ADC     #0                ;
77E7                
77E7              loc_77E7:
77E7 AA                           TAX                       ;
77E8 BD B9 57                     LDA     $57B9,X
77EB 60                           RTS                       ;
77EB              ; End of function sub_77DF
77EB                
77EB              ; ---------------------------------------------------------------------------
77EC 00                           .BYTE    0  
77ED 00                           .BYTE    0  
77EE 00                           .BYTE    0  
77EF 00                           .BYTE    0  
77F0 00                           .BYTE    0  
77F1 00                           .BYTE    0  
77F2 00                           .BYTE    0  
77F3 00                           .BYTE    0  
77F4 00                           .BYTE    0  
77F5 00                           .BYTE    0  
77F6                
77F6              ; ��������������� S U B R O U T I N E ���������������������������������������
77F6                
77F6                
77F6              sub_77F6:
77F6
77F6 AD 03 28                     LDA     $2803             ; DIP Switches 1 & 2, Language
77F9 29 03                        AND     #3
77FB 0A                           ASL     A
77FC AA                           TAX     
77FD A9 10                        LDA     #$10
77FF 85 00                        STA     0
7801 BD 88 78                     LDA     $7888,X           ; Address Of Message Offset Table
7804 85 09                        STA     9
7806 BD 87 78                     LDA     $7887,X
7809 85 08                        STA     8
780B 71 08                        ADC     (8),Y             ; Add In The Offset To Get Starting
780D 85 08                        STA     8                 ; Address Of Message
780F 90 02                        BCC     loc_7813
7811 E6 09                        INC     9
7813                
7813              loc_7813:
7813 98                           TYA                       ;
7814 0A                           ASL     A
7815 A8                           TAY     
7816 B9 71 78                     LDA     $7871,Y
7819 BE 72 78                     LDX     $7872,Y           ;
781C 20 03 7C                     JSR     sub_7C03
781F A9 70                        LDA     #$70
7821 20 DE 7C                     JSR     sub_7CDE
7824 A0 00                        LDY     #0                ;
7826 A2 00                        LDX     #0                ;
7828                
7828              loc_7828:
7828 A1 08                        LDA     (8,X)             ;
782A 85 0B                        STA     $B
782C 4A                           LSR     A
782D 4A                           LSR     A
782E 20 4D 78                     JSR     sub_784D          ;
7831 A1 08                        LDA     (8,X)
7833 2A                           ROL     A
7834 26 0B                        ROL     $B
7836 2A                           ROL     A                 ;
7837 A5 0B                        LDA     $B
7839 2A                           ROL     A
783A 0A                           ASL     A
783B 20 53 78                     JSR     sub_7853          ;
783E A1 08                        LDA     (8,X)
7840 85 0B                        STA     $B
7842 20 4D 78                     JSR     sub_784D
7845 46 0B                        LSR     $B                ;
7847 90 DF                        BCC     loc_7828          ;
7849                
7849              loc_7849:
7849 88                           DEY                       ;
784A 4C 39 7C                     JMP     sub_7C39          ;
784A              ; End of function sub_77F6
784A                
784D                
784D              ; ��������������� S U B R O U T I N E ���������������������������������������
784D                
784D                
784D              sub_784D:
784D
784D E6 08                        INC     8                 ;
784F D0 02                        BNE     sub_7853
7851 E6 09                        INC     9                 ;
7851              ; End of function sub_784D
7851                
7853                
7853              ; ��������������� S U B R O U T I N E ���������������������������������������
7853                
7853                
7853              sub_7853:
7853
7853 29 3E                        AND     #$3E              ;
7855 D0 04                        BNE     loc_785B
7857 68                           PLA     
7858 68                           PLA                       ;
7859 D0 EE                        BNE     loc_7849          ;
785B                
785B              loc_785B:
785B C9 0A                        CMP     #$A               ;
785D 90 02                        BCC     loc_7861
785F 69 0D                        ADC     #$D               ;
7861                
7861              loc_7861:
7861 AA                           TAX                       ;
7862 BD D2 56                     LDA     $56D2,X
7865 91 02                        STA     (2),Y
7867 C8                           INY                       ;
7868 BD D3 56                     LDA     $56D3,X
786B 91 02                        STA     (2),Y
786D C8                           INY     
786E A2 00                        LDX     #0                ;
7870 60                           RTS                       ;
7870              ; End of function sub_7853
7870                
7870              ; ---------------------------------------------------------------------------
7871 64                           .BYTE  $64
7872 B6                           .BYTE  $B6

7873 64                           .BYTE  $64
7874 B6                           .BYTE  $B6

7875 0C                           .BYTE   $C
7876 AA                           .BYTE  $AA

7877 0C                           .BYTE   $C  
7878 A2                           .BYTE  $A2

7879 0C                           .BYTE   $C  
787A 9A                           .BYTE  $9A

787B 0C                           .BYTE   $C  
787C 92                           .BYTE  $92

787D 64                           .BYTE  $64
787E C6                           .BYTE  $C6

787F 64                           .BYTE  $64
7880 9D                           .BYTE  $9D

7881 50                           .BYTE  $50
7882 39                           .BYTE  $39

7883 50                           .BYTE  $50
7884 39                           .BYTE  $39

7885 50                           .BYTE  $50
7886 39                           .BYTE  $39


7887 1E                           .BYTE  $1E                ; English
7888 57                           .BYTE  $57

7889 8F                           .BYTE  $8F
788A 78                           .BYTE  $78

788B 46                           .BYTE  $46
788C 79                           .BYTE  $79

788D F3                           .BYTE  $F3
788E 79                           .BYTE  $79

788F 0B                           .BYTE   $B  
7890 15                           .BYTE  $15  
7891 1B                           .BYTE  $1B  
7892 35                           .BYTE  $35
7893 4D                           .BYTE  $4D
7894 65                           .BYTE  $65
7895 7F                           .BYTE  $7F
7896 8D                           .BYTE  $8D
7897 93                           .BYTE  $93
7898 9F                           .BYTE  $9F
7899 AB                           .BYTE  $AB

789A 64                           .BYTE  $64
789B D2                           .BYTE  $D2
789C 3B                           .BYTE  $3B
789D 2E                           .BYTE  $2E
789E C2                           .BYTE  $C2
789F 6C                           .BYTE  $6C
78A0 5A                           .BYTE  $5A
78A1 4C                           .BYTE  $4C
78A2 93                           .BYTE  $93
78A3 6F                           .BYTE  $6F
78A4 BD                           .BYTE  $BD
78A5 1A                           .BYTE  $1A  
78A6 4C                           .BYTE  $4C
78A7 12                           .BYTE  $12  
78A8 B0                           .BYTE  $B0
78A9 40                           .BYTE  $40
78AA 6B                           .BYTE  $6B
78AB 2C                           .BYTE  $2C
78AC 0A                           .BYTE   $A  
78AD 6C                           .BYTE  $6C
78AE 5A                           .BYTE  $5A
78AF 4C                           .BYTE  $4C
78B0 93                           .BYTE  $93
78B1 6E                           .BYTE  $6E
78B2 0B                           .BYTE   $B  
78B3 6E                           .BYTE  $6E
78B4 C0                           .BYTE  $C0
78B5 52                           .BYTE  $52
78B6 6C                           .BYTE  $6C
78B7 92                           .BYTE  $92
78B8 B8                           .BYTE  $B8
78B9 50                           .BYTE  $50
78BA 4D                           .BYTE  $4D
78BB 82                           .BYTE  $82
78BC F2                           .BYTE  $F2
78BD 58                           .BYTE  $58
78BE 90                           .BYTE  $90
78BF 4C                           .BYTE  $4C
78C0 4D                           .BYTE  $4D
78C1 F0                           .BYTE  $F0
78C2 4C                           .BYTE  $4C
78C3 80                           .BYTE  $80
78C4 33                           .BYTE  $33
78C5 70                           .BYTE  $70
78C6 C2                           .BYTE  $C2
78C7 42                           .BYTE  $42
78C8 5A                           .BYTE  $5A
78C9 4C                           .BYTE  $4C
78CA 4C                           .BYTE  $4C
78CB 82                           .BYTE  $82
78CC BB                           .BYTE  $BB
78CD 52                           .BYTE  $52
78CE 0B                           .BYTE   $B  
78CF 58                           .BYTE  $58
78D0 B2                           .BYTE  $B2
78D1 42                           .BYTE  $42
78D2 6C                           .BYTE  $6C
78D3 9A                           .BYTE  $9A
78D4 C3                           .BYTE  $C3
78D5 4A                           .BYTE  $4A
78D6 82                           .BYTE  $82
78D7 64                           .BYTE  $64
78D8 0A                           .BYTE   $A  
78D9 5A                           .BYTE  $5A
78DA 90                           .BYTE  $90
78DB 00                           .BYTE    0  
78DC F6                           .BYTE  $F6
78DD 6C                           .BYTE  $6C
78DE 09                           .BYTE    9  
78DF B2                           .BYTE  $B2
78E0 3B                           .BYTE  $3B
78E1 2E                           .BYTE  $2E
78E2 C1                           .BYTE  $C1
78E3 4C                           .BYTE  $4C
78E4 4C                           .BYTE  $4C
78E5 B6                           .BYTE  $B6
78E6 2B                           .BYTE  $2B
78E7 20                           .BYTE  $20  
78E8 0D                           .BYTE   $D  
78E9 A6                           .BYTE  $A6
78EA C1                           .BYTE  $C1
78EB 70                           .BYTE  $70
78EC 48                           .BYTE  $48
78ED 50                           .BYTE  $50
78EE B6                           .BYTE  $B6
78EF 52                           .BYTE  $52
78F0 3B                           .BYTE  $3B
78F1 D2                           .BYTE  $D2
78F2 90                           .BYTE  $90
78F3 00                           .BYTE    0  
78F4 DA                           .BYTE  $DA
78F5 64                           .BYTE  $64
78F6 90                           .BYTE  $90
78F7 4C                           .BYTE  $4C
78F8 C9                           .BYTE  $C9
78F9 D8                           .BYTE  $D8
78FA BE                           .BYTE  $BE
78FB 0A                           .BYTE   $A  
78FC 32                           .BYTE  $32
78FD 42                           .BYTE  $42
78FE 9B                           .BYTE  $9B
78FF C2                           .BYTE  $C2
7900 67                           .BYTE  $67
7901 68                           .BYTE  $68
7902 4D                           .BYTE  $4D
7903 AE                           .BYTE  $AE
7904 A1                           .BYTE  $A1
7905 4E                           .BYTE  $4E
7906 48                           .BYTE  $48
7907 50                           .BYTE  $50
7908 B6                           .BYTE  $B6
7909 52                           .BYTE  $52
790A 3B                           .BYTE  $3B
790B D2                           .BYTE  $D2
790C 90                           .BYTE  $90
790D 00                           .BYTE    0  
790E BE                           .BYTE  $BE
790F 0A                           .BYTE   $A  
7910 B6                           .BYTE  $B6
7911 1E                           .BYTE  $1E  
7912 94                           .BYTE  $94
7913 D2                           .BYTE  $D2
7914 A2                           .BYTE  $A2
7915 92                           .BYTE  $92
7916 0A                           .BYTE   $A  
7917 2C                           .BYTE  $2C
7918 CA                           .BYTE  $CA
7919 4E                           .BYTE  $4E
791A 7A                           .BYTE  $7A
791B 65                           .BYTE  $65
791C BD                           .BYTE  $BD
791D 1A                           .BYTE  $1A  
791E 4C                           .BYTE  $4C
791F 12                           .BYTE  $12  
7920 92                           .BYTE  $92
7921 13                           .BYTE  $13  
7922 18                           .BYTE  $18  
7923 62                           .BYTE  $62
7924 CA                           .BYTE  $CA
7925 64                           .BYTE  $64
7926 F2                           .BYTE  $F2
7927 42                           .BYTE  $42
7928 20                           .BYTE  $20  
7929 6E                           .BYTE  $6E
792A A3                           .BYTE  $A3
792B 52                           .BYTE  $52
792C 82                           .BYTE  $82
792D 40                           .BYTE  $40
792E 18                           .BYTE  $18  
792F 62                           .BYTE  $62
7930 CA                           .BYTE  $CA
7931 64                           .BYTE  $64
7932 F2                           .BYTE  $F2
7933 42                           .BYTE  $42
7934 18                           .BYTE  $18
7935 6E                           .BYTE  $6E
7936 A3                           .BYTE  $A3
7937 52                           .BYTE  $52
7938 80                           .BYTE  $80
7939 00                           .BYTE    0
793A 20                           .BYTE  $20
793B 62                           .BYTE  $62
793C CA                           .BYTE  $CA
793D 64                           .BYTE  $64
793E F2                           .BYTE  $F2
793F 64                           .BYTE  $64
7940 08                           .BYTE    8
7941 C2                           .BYTE  $C2
7942 BD                           .BYTE  $BD
7943 1A                           .BYTE  $1A
7944 4C                           .BYTE  $4C
7945 00                           .BYTE    0

7946 0B                           .BYTE   $B
7947 15                           .BYTE  $15
7948 19                           .BYTE  $19
7949 31                           .BYTE  $31
794A 41                           .BYTE  $41
794B 57                           .BYTE  $57
794C 73                           .BYTE  $73
794D 7F                           .BYTE  $7F
794E 89                           .BYTE  $89
794F 95                           .BYTE  $95
7950 A1                           .BYTE  $A1

7951 8A                           .BYTE  $8A
7952 5A                           .BYTE  $5A
7953 84                           .BYTE  $84
7954 12                           .BYTE  $12
7955 CD                           .BYTE  $CD
7956 82                           .BYTE  $82
7957 B9                           .BYTE  $B9
7958 E6                           .BYTE  $E6
7959 B2                           .BYTE  $B2
795A 40                           .BYTE  $40
795B 74                           .BYTE  $74
795C F2                           .BYTE  $F2
795D 4D                           .BYTE  $4D
795E 83                           .BYTE  $83
795F D4                           .BYTE  $D4
7960 F0                           .BYTE  $F0
7961 B2                           .BYTE  $B2
7962 42                           .BYTE  $42
7963 B9                           .BYTE  $B9
7964 E6                           .BYTE  $E6
7965 B2                           .BYTE  $B2
7966 42                           .BYTE  $42
7967 4D                           .BYTE  $4D
7968 F0                           .BYTE  $F0
7969 0E                           .BYTE   $E
796A 64                           .BYTE  $64
796B 0A                           .BYTE   $A
796C 12                           .BYTE  $12
796D B8                           .BYTE  $B8
796E 46                           .BYTE  $46
796F 10                           .BYTE  $10
7970 62                           .BYTE  $62
7971 4B                           .BYTE  $4B
7972 60                           .BYTE  $60
7973 82                           .BYTE  $82
7974 72                           .BYTE  $72
7975 B5                           .BYTE  $B5
7976 C0                           .BYTE  $C0
7977 BE                           .BYTE  $BE
7978 A8                           .BYTE  $A8
7979 0A                           .BYTE   $A
797A 64                           .BYTE  $64
797B C5                           .BYTE  $C5
797C 92                           .BYTE  $92
797D F0                           .BYTE  $F0
797E 74                           .BYTE  $74
797F 9D                           .BYTE  $9D
7980 C2                           .BYTE  $C2
7981 6C                           .BYTE  $6C
7982 9A                           .BYTE  $9A
7983 C3                           .BYTE  $C3
7984 4A                           .BYTE  $4A
7985 82                           .BYTE  $82
7986 6F                           .BYTE  $6F
7987 A4                           .BYTE  $A4
7988 F2                           .BYTE  $F2
7989 BD                           .BYTE  $BD
798A D2                           .BYTE  $D2
798B F0                           .BYTE  $F0
798C 6C                           .BYTE  $6C
798D 9E                           .BYTE  $9E
798E 0A                           .BYTE   $A
798F C2                           .BYTE  $C2
7990 42                           .BYTE  $42
7991 A4                           .BYTE  $A4
7992 F2                           .BYTE  $F2
7993 B0                           .BYTE  $B0
7994 74                           .BYTE  $74
7995 9D                           .BYTE  $9D
7996 C2                           .BYTE  $C2
7997 6C                           .BYTE  $6C
7998 9A                           .BYTE  $9A
7999 C3                           .BYTE  $C3
799A 4A                           .BYTE  $4A
799B 82                           .BYTE  $82
799C 6F                           .BYTE  $6F
799D A4                           .BYTE  $A4
799E F2                           .BYTE  $F2
799F BD                           .BYTE  $BD
79A0 D2                           .BYTE  $D2
79A1 F0                           .BYTE  $F0
79A2 58                           .BYTE  $58
79A3 ED                           .BYTE  $ED
79A4 12                           .BYTE  $12
79A5 B5                           .BYTE  $B5
79A6 E8                           .BYTE  $E8
79A7 29                           .BYTE  $29
79A8 D2                           .BYTE  $D2
79A9 0D                           .BYTE   $D
79AA 72                           .BYTE  $72
79AB 2C                           .BYTE  $2C
79AC 90                           .BYTE  $90
79AD 0C                           .BYTE   $C
79AE 12                           .BYTE  $12
79AF C6                           .BYTE  $C6
79B0 2C                           .BYTE  $2C
79B1 48                           .BYTE  $48
79B2 4E                           .BYTE  $4E
79B3 9D                           .BYTE  $9D
79B4 AC                           .BYTE  $AC
79B5 49                           .BYTE  $49
79B6 F0                           .BYTE  $F0
79B7 48                           .BYTE  $48
79B8 00                           .BYTE    0
79B9 2D                           .BYTE  $2D
79BA 28                           .BYTE  $28
79BB CF                           .BYTE  $CF
79BC 52                           .BYTE  $52
79BD B0                           .BYTE  $B0
79BE 6E                           .BYTE  $6E
79BF CD                           .BYTE  $CD
79C0 82                           .BYTE  $82
79C1 BE                           .BYTE  $BE
79C2 0A                           .BYTE   $A
79C3 B6                           .BYTE  $B6
79C4 00                           .BYTE    0
79C5 53                           .BYTE  $53
79C6 64                           .BYTE  $64
79C7 0A                           .BYTE   $A
79C8 12                           .BYTE  $12
79C9 0D                           .BYTE   $D
79CA 0A                           .BYTE   $A
79CB B6                           .BYTE  $B6
79CC 1A                           .BYTE  $1A
79CD 48                           .BYTE  $48
79CE 00                           .BYTE    0
79CF 18                           .BYTE  $18
79D0 68                           .BYTE  $68
79D1 6A                           .BYTE  $6A
79D2 4E                           .BYTE  $4E
79D3 48                           .BYTE  $48
79D4 48                           .BYTE  $48
79D5 0B                           .BYTE   $B
79D6 A6                           .BYTE  $A6
79D7 CA                           .BYTE  $CA
79D8 72                           .BYTE  $72
79D9 B5                           .BYTE  $B5
79DA C0                           .BYTE  $C0
79DB 18                           .BYTE  $18
79DC 68                           .BYTE  $68
79DD 6A                           .BYTE  $6A
79DE 4E                           .BYTE  $4E
79DF 48                           .BYTE  $48
79E0 46                           .BYTE  $46
79E1 0B                           .BYTE   $B
79E2 A6                           .BYTE  $A6
79E3 CA                           .BYTE  $CA
79E4 72                           .BYTE  $72
79E5 B0                           .BYTE  $B0
79E6 00                           .BYTE    0
79E7 20                           .BYTE  $20
79E8 68                           .BYTE  $68
79E9 6A                           .BYTE  $6A
79EA 4E                           .BYTE  $4E
79EB 4D                           .BYTE  $4D
79EC C2                           .BYTE  $C2
79ED 18                           .BYTE  $18
79EE 5C                           .BYTE  $5C
79EF 9E                           .BYTE  $9E
79F0 52                           .BYTE  $52
79F1 CD                           .BYTE  $CD
79F2 80                           .BYTE  $80

79F3 0B                           .BYTE   $B
79F4 11                           .BYTE  $11
79F5 17                           .BYTE  $17
79F6 31                           .BYTE  $31
79F7 45                           .BYTE  $45
79F8 5F                           .BYTE  $5F
79F9 6B                           .BYTE  $6B
79FA 73                           .BYTE  $73
79FB 7D                           .BYTE  $7D
79FC 89                           .BYTE  $89
79FD 93                           .BYTE  $93

79FE B2                           .BYTE  $B2
79FF 4E                           .BYTE  $4E
7A00 9D                           .BYTE  $9D
7A01 90                           .BYTE  $90
7A02 B8                           .BYTE  $B8
7A03 00                           .BYTE    0
7A04 76                           .BYTE  $76
7A05 56                           .BYTE  $56
7A06 2A                           .BYTE  $2A
7A07 26                           .BYTE  $26
7A08 B0                           .BYTE  $B0
7A09 40                           .BYTE  $40
7A0A BE                           .BYTE  $BE
7A0B 42                           .BYTE  $42
7A0C A6                           .BYTE  $A6
7A0D 64                           .BYTE  $64
7A0E C1                           .BYTE  $C1
7A0F 5C                           .BYTE  $5C
7A10 48                           .BYTE  $48
7A11 52                           .BYTE  $52
7A12 BE                           .BYTE  $BE
7A13 0A                           .BYTE   $A
7A14 0A                           .BYTE   $A
7A15 64                           .BYTE  $64
7A16 C5                           .BYTE  $C5
7A17 92                           .BYTE  $92
7A18 0C                           .BYTE   $C
7A19 26                           .BYTE  $26
7A1A B8                           .BYTE  $B8
7A1B 50                           .BYTE  $50
7A1C 6A                           .BYTE  $6A
7A1D 7C                           .BYTE  $7C
7A1E 0C                           .BYTE   $C
7A1F 52                           .BYTE  $52
7A20 74                           .BYTE  $74
7A21 EC                           .BYTE  $EC
7A22 4D                           .BYTE  $4D
7A23 C0                           .BYTE  $C0
7A24 A4                           .BYTE  $A4
7A25 EC                           .BYTE  $EC
7A26 0A                           .BYTE   $A
7A27 8A                           .BYTE  $8A
7A28 D4                           .BYTE  $D4
7A29 EC                           .BYTE  $EC
7A2A 0A                           .BYTE   $A
7A2B 64                           .BYTE  $64
7A2C C5                           .BYTE  $C5
7A2D 92                           .BYTE  $92
7A2E 0D                           .BYTE   $D
7A2F F2                           .BYTE  $F2
7A30 B8                           .BYTE  $B8
7A31 5A                           .BYTE  $5A
7A32 93                           .BYTE  $93
7A33 4E                           .BYTE  $4E
7A34 69                           .BYTE  $69
7A35 60                           .BYTE  $60
7A36 4D                           .BYTE  $4D
7A37 C0                           .BYTE  $C0
7A38 9D                           .BYTE  $9D
7A39 2C                           .BYTE  $2C
7A3A 6C                           .BYTE  $6C
7A3B 4A                           .BYTE  $4A
7A3C 0D                           .BYTE   $D
7A3D A6                           .BYTE  $A6
7A3E C1                           .BYTE  $C1
7A3F 70                           .BYTE  $70
7A40 48                           .BYTE  $48
7A41 68                           .BYTE  $68
7A42 2D                           .BYTE  $2D
7A43 8A                           .BYTE  $8A
7A44 0D                           .BYTE   $D
7A45 D2                           .BYTE  $D2
7A46 82                           .BYTE  $82
7A47 4E                           .BYTE  $4E
7A48 3B                           .BYTE  $3B
7A49 66                           .BYTE  $66
7A4A 91                           .BYTE  $91
7A4B 6C                           .BYTE  $6C
7A4C 0C                           .BYTE   $C
7A4D 0A                           .BYTE   $A
7A4E 0C                           .BYTE   $C
7A4F 12                           .BYTE  $12
7A50 C5                           .BYTE  $C5
7A51 8B                           .BYTE  $8B
7A52 9D                           .BYTE  $9D
7A53 2C                           .BYTE  $2C
7A54 6C                           .BYTE  $6C
7A55 4A                           .BYTE  $4A
7A56 0B                           .BYTE   $B
7A57 3A                           .BYTE  $3A
7A58 A2                           .BYTE  $A2
7A59 6C                           .BYTE  $6C
7A5A BD                           .BYTE  $BD
7A5B 0A                           .BYTE   $A
7A5C 3A                           .BYTE  $3A
7A5D 40                           .BYTE  $40
7A5E A6                           .BYTE  $A6
7A5F 60                           .BYTE  $60
7A60 B9                           .BYTE  $B9
7A61 6C                           .BYTE  $6C
7A62 0D                           .BYTE   $D
7A63 F0                           .BYTE  $F0
7A64 2D                           .BYTE  $2D
7A65 B1                           .BYTE  $B1
7A66 76                           .BYTE  $76
7A67 52                           .BYTE  $52
7A68 5C                           .BYTE  $5C
7A69 C2                           .BYTE  $C2
7A6A C2                           .BYTE  $C2
7A6B 6C                           .BYTE  $6C
7A6C 8B                           .BYTE  $8B
7A6D 64                           .BYTE  $64
7A6E 2A                           .BYTE  $2A
7A6F 27                           .BYTE  $27
7A70 18                           .BYTE  $18
7A71 54                           .BYTE  $54
7A72 69                           .BYTE  $69
7A73 D8                           .BYTE  $D8
7A74 28                           .BYTE  $28
7A75 48                           .BYTE  $48
7A76 0B                           .BYTE   $B
7A77 B2                           .BYTE  $B2
7A78 4A                           .BYTE  $4A
7A79 E6                           .BYTE  $E6
7A7A B8                           .BYTE  $B8
7A7B 00                           .BYTE    0
7A7C 18                           .BYTE  $18
7A7D 54                           .BYTE  $54
7A7E 69                           .BYTE  $69
7A7F D8                           .BYTE  $D8
7A80 28                           .BYTE  $28
7A81 46                           .BYTE  $46
7A82 0B                           .BYTE   $B
7A83 B2                           .BYTE  $B2
7A84 4A                           .BYTE  $4A
7A85 E7                           .BYTE  $E7
7A86 20                           .BYTE  $20
7A87 54                           .BYTE  $54
7A88 69                           .BYTE  $69
7A89 D8                           .BYTE  $D8
7A8A 2D                           .BYTE  $2D
7A8B C2                           .BYTE  $C2
7A8C 18                           .BYTE  $18
7A8D 5C                           .BYTE  $5C
7A8E CA                           .BYTE  $CA
7A8F 56                           .BYTE  $56
7A90 98                           .BYTE  $98
7A91 00                           .BYTE    0
7A92 52                           .BYTE  $52

7A93              
7A93              ; ��������������� S U B R O U T I N E ���������������������������������������
7A93                
7A93                
7A93              sub_7A93:
7A93 A2 02                        LDX     #2
7A95                
7A95              loc_7A95:
7A95 BD 00 24                     LDA     $2400,X           ; Coin Switch
7A98 0A                           ASL     A                 ; Shift High Bit To Carry
7A99 B5 7A                        LDA     $7A,X
7A9B 29 1F                        AND     #$1F              ; 00011111
7A9D 90 37                        BCC     loc_7AD6          ; No Coin For This Slot, Branch
7A9F F0 10                        BEQ     loc_7AB1
7AA1 C9 1B                        CMP     #$1B
7AA3 B0 0A                        BCS     loc_7AAF          ;
7AA5 A8                           TAY     
7AA6 A5 5E                        LDA     $5E
7AA8 29 07                        AND     #7
7AAA C9 07                        CMP     #7                ;
7AAC 98                           TYA     
7AAD 90 02                        BCC     loc_7AB1          ;
7AAF                
7AAF              loc_7AAF:
7AAF E9 01                        SBC     #1                ;
7AB1                
7AB1              loc_7AB1:
7AB1
7AB1 95 7A                        STA     $7A,X             ;
7AB3 AD 06 20                     LDA     $2006             ; Slam Switch
7AB6 29 80                        AND     #$80              ;
7AB8 F0 04                        BEQ     loc_7ABE          ; Valid Coin, Branch
7ABA A9 F0                        LDA     #$F0              ; Flag Ill Gotten Gain
7ABC 85 72                        STA     $72               ; Into Slam Switch Flag
7ABE                
7ABE              loc_7ABE:
7ABE A5 72                        LDA     $72               ; Honest Coin?
7AC0 F0 08                        BEQ     loc_7ACA          ; Yes, Branch
7AC2 C6 72                        DEC     $72
7AC4 A9 00                        LDA     #0
7AC6 95 7A                        STA     $7A,X
7AC8 95 77                        STA     $77,X             ;
7ACA                
7ACA              loc_7ACA:
7ACA 18                           CLC                       ;
7ACB B5 77                        LDA     $77,X
7ACD F0 23                        BEQ     loc_7AF2
7ACF D6 77                        DEC     $77,X             ;
7AD1 D0 1F                        BNE     loc_7AF2
7AD3 38                           SEC                       ;
7AD4 B0 1C                        BCS     loc_7AF2          ;
7AD6                
7AD6              loc_7AD6:
7AD6 C9 1B                        CMP     #$1B              ;
7AD8 B0 09                        BCS     loc_7AE3
7ADA B5 7A                        LDA     $7A,X             ;
7ADC 69 20                        ADC     #$20
7ADE 90 D1                        BCC     loc_7AB1
7AE0 F0 01                        BEQ     loc_7AE3          ;
7AE2 18                           CLC     
7AE3                
7AE3              loc_7AE3:
7AE3
7AE3 A9 1F                        LDA     #$1F              ;
7AE5 B0 CA                        BCS     loc_7AB1
7AE7 95 7A                        STA     $7A,X             ;
7AE9 B5 77                        LDA     $77,X
7AEB F0 01                        BEQ     loc_7AEE
7AED 38                           SEC                       ;
7AEE                
7AEE              loc_7AEE:
7AEE A9 78                        LDA     #$78              ;
7AF0 95 77                        STA     $77,X             ;
7AF2                
7AF2              loc_7AF2:
7AF2
7AF2 90 23                        BCC     loc_7B17          ;
7AF4 A9 00                        LDA     #0                ;
7AF6 E0 01                        CPX     #1                ;
7AF8 90 16                        BCC     loc_7B10          ;
7AFA F0 0C                        BEQ     loc_7B08          ;
7AFC A5 71                        LDA     $71               ; DIP Switch Bitmap
7AFE 29 0C                        AND     #$C               ; Mask Off Switches 5 & 6, Right Coin Slot Multiplier
7B00 4A                           LSR     A                 ;
7B01 4A                           LSR     A                 ;
7B02 F0 0C                        BEQ     loc_7B10          ; x1, Branch
7B04 69 02                        ADC     #2                ; 2 + Set Bits From Settings = Total Coins After Multiplier
7B06 D0 08                        BNE     loc_7B10          ; Will Always Branch
7B08                
7B08              loc_7B08:
7B08 A5 71                        LDA     $71               ;
7B0A 29 10                        AND     #$10              ;
7B0C F0 02                        BEQ     loc_7B10          ;
7B0E A9 01                        LDA     #1                ;
7B10                
7B10              loc_7B10:
7B10
7B10 38                           SEC                       ; Set Carry, This Will Add 1 To The Total
7B11 65 73                        ADC     $73               ;
7B13 85 73                        STA     $73               ;
7B15 F6 74                        INC     $74,X             ;
7B17                
7B17              loc_7B17:
7B17 CA                           DEX     
7B18 30 03                        BMI     loc_7B1D          ;
7B1A 4C 95 7A                     JMP     loc_7A95          ;
7B1D              ; ---------------------------------------------------------------------------
7B1D                
7B1D              loc_7B1D:
7B1D A5 71                        LDA     $71               ; DIP Switch Settings
7B1F 29 03                        AND     #3                ; Mask Off Switches 7 & 8, Coins Per Play
7B21 A8                           TAY                       ;
7B22 F0 12                        BEQ     loc_7B36          ; Free Play, Branch
7B24 4A                           LSR     A                 ;
7B25 69 00                        ADC     #0                ;
7B27 49 FF                        EOR     #$FF
7B29 38                           SEC     
7B2A 65 73                        ADC     $73               ;
7B2C 90 0A                        BCC     loc_7B38
7B2E C0 02                        CPY     #2
7B30 B0 02                        BCS     loc_7B34
7B32 E6 70                        INC     $70               ; Add Credit
7B34                
7B34              loc_7B34:
7B34 E6 70                        INC     $70               ; Add Credit
7B36                
7B36              loc_7B36:
7B36 85 73                        STA     $73               ;
7B38                
7B38              loc_7B38:
7B38 A5 5E                        LDA     $5E               ;
7B3A 4A                           LSR     A
7B3B B0 27                        BCS     locret_7B64
7B3D A0 00                        LDY     #0
7B3F A2 02                        LDX     #2                ;
7B41                
7B41              loc_7B41:
7B41 B5 74                        LDA     $74,X             ;
7B43 F0 09                        BEQ     loc_7B4E
7B45 C9 10                        CMP     #$10
7B47 90 05                        BCC     loc_7B4E
7B49 69 EF                        ADC     #$EF              ;
7B4B C8                           INY     
7B4C 95 74                        STA     $74,X             ;
7B4E                
7B4E              loc_7B4E:
7B4E
7B4E CA                           DEX                       ;
7B4F 10 F0                        BPL     loc_7B41
7B51 98                           TYA     
7B52 D0 10                        BNE     locret_7B64
7B54 A2 02                        LDX     #2                ;
7B56                
7B56              loc_7B56:
7B56 B5 74                        LDA     $74,X             ;
7B58 F0 07                        BEQ     loc_7B61
7B5A 18                           CLC     
7B5B 69 EF                        ADC     #$EF
7B5D 95 74                        STA     $74,X             ;
7B5F 30 03                        BMI     locret_7B64       ;
7B61                
7B61              loc_7B61:
7B61 CA                           DEX                       ;
7B62 10 F2                        BPL     loc_7B56          ;
7B64                
7B64              locret_7B64:
7B64
7B64 60                           RTS                       ;
7B64              ; End of function sub_7A93
7B64                
7B65              ; ---------------------------------------------------------------------------
7B65 48                           PHA                       ;
7B66 98                           TYA     
7B67 48                           PHA     
7B68 8A                           TXA     
7B69 48                           PHA                       ;
7B6A D8                           CLD     
7B6B AD FF 01                     LDA     $1FF              ; Stack Space!
7B6E 0D D0 01                     ORA     $1D0              ;
7B71                
7B71              loc_7B71:
7B71 D0 FE                        BNE     loc_7B71          ; Endless Loop! Watchdog Will Time Out
7B73 E6 5E                        INC     $5E               ;
7B75 A5 5E                        LDA     $5E               ;
7B77 29 03                        AND     #3                ;
7B79 D0 08                        BNE     loc_7B83
7B7B E6 5B                        INC     $5B               ;
7B7D A5 5B                        LDA     $5B
7B7F C9 04                        CMP     #4                ;
7B81                
7B81              loc_7B81:
7B81 B0 FE                        BCS     loc_7B81          ; Endless Loop! Watchdog Will Time Out
7B83                
7B83              loc_7B83:
7B83 20 93 7A                     JSR     sub_7A93          ;
7B86 A5 6F                        LDA     $6F
7B88 29 C7                        AND     #$C7
7B8A 24 74                        BIT     $74
7B8C 10 02                        BPL     loc_7B90          ;
7B8E 09 08                        ORA     #8
7B90                
7B90              loc_7B90:
7B90 24 75                        BIT     $75               ;
7B92 10 02                        BPL     loc_7B96
7B94 09 10                        ORA     #$10              ;
7B96                
7B96              loc_7B96:
7B96 24 76                        BIT     $76               ;
7B98 10 02                        BPL     loc_7B9C
7B9A 09 20                        ORA     #$20              ;
7B9C                
7B9C              loc_7B9C:
7B9C 85 6F                        STA     $6F               ;
7B9E 8D 00 32                     STA     $3200             ;
7BA1 A5 72                        LDA     $72               ; Slam Switch Flag
7BA3 F0 04                        BEQ     loc_7BA9          ; Branch If Not Set
7BA5 A9 80                        LDA     #$80              ; Gonna Make Noise To Let 'Em Know They've Been Caught!
7BA7 D0 0E                        BNE     loc_7BB7          ; Will Always Branch
7BA9                
7BA9              loc_7BA9:
7BA9 A5 68                        LDA     $68               ; Bonus Ship Sound Timer
7BAB F0 0A                        BEQ     loc_7BB7          ;
7BAD A5 5C                        LDA     $5C               ; Fast Timer
7BAF 6A                           ROR     A
7BB0 90 02                        BCC     loc_7BB4          ;
7BB2 C6 68                        DEC     $68
7BB4                
7BB4              loc_7BB4:
7BB4 6A                           ROR     A                 ;
7BB5 6A                           ROR     A
7BB6 6A                           ROR     A
7BB7                
7BB7              loc_7BB7:
7BB7
7BB7 8D 05 3C                     STA     $3C05             ; Life Sound
7BBA 68                           PLA     
7BBB AA                           TAX     
7BBC 68                           PLA     
7BBD A8                           TAY                       ;
7BBE 68                           PLA     
7BBF 40                           RTI     
7BC0                
7BC0              ; ��������������� S U B R O U T I N E ���������������������������������������
7BC0                
7BC0                
7BC0              sub_7BC0:
7BC0
7BC0 A9 B0                        LDA     #$B0
7BC2 A0 00                        LDY     #0
7BC4 91 02                        STA     (2),Y
7BC6 C8                           INY     
7BC7 91 02                        STA     (2),Y
7BC9 D0 6E                        BNE     sub_7C39
7BCB                
7BCB              loc_7BCB:
7BCB 90 04                        BCC     sub_7BD1
7BCD 29 0F                        AND     #$F
7BCF F0 05                        BEQ     loc_7BD6
7BCF              ; End of function sub_7BC0
7BCF                
7BD1                
7BD1              ; ��������������� S U B R O U T I N E ���������������������������������������
7BD1                
7BD1                
7BD1              sub_7BD1:
7BD1
7BD1 29 0F                        AND     #$F
7BD3 18                           CLC     
7BD4 69 01                        ADC     #1
7BD6                
7BD6              loc_7BD6:
7BD6 08                           PHP     
7BD7 0A                           ASL     A
7BD8 A0 00                        LDY     #0
7BDA AA                           TAX     
7BDB BD D4 56                     LDA     $56D4,X
7BDE 91 02                        STA     (2),Y
7BE0 BD D5 56                     LDA     $56D5,X
7BE3 C8                           INY     
7BE4 91 02                        STA     (2),Y
7BE6 20 39 7C                     JSR     sub_7C39
7BE9 28                           PLP     
7BEA 60                           RTS     
7BEA              ; End of function sub_7BD1
7BEA                
7BEA              ; ---------------------------------------------------------------------------
7BEB 4A                           .BYTE  $4A
7BEC 29                           .BYTE  $29
7BED 0F                           .BYTE   $F
7BEE 09                           .BYTE    9
7BEF E0                           .BYTE  $E0
7BF0              ; ---------------------------------------------------------------------------
7BF0                
7BF0              loc_7BF0:
7BF0 A0 01                        LDY     #1
7BF2 91 02                        STA     (2),Y
7BF4 88                           DEY     
7BF5 8A                           TXA     
7BF6 6A                           ROR     A
7BF7 91 02                        STA     (2),Y
7BF9 C8                           INY     
7BFA D0 3D                        BNE     sub_7C39
7BFC                
7BFC              ; ��������������� S U B R O U T I N E ���������������������������������������
7BFC                
7BFC                
7BFC              sub_7BFC:
7BFC
7BFC 4A                           LSR     A
7BFD 29 0F                        AND     #$F
7BFF 09 C0                        ORA     #$C0
7C01 D0 ED                        BNE     loc_7BF0
7C01              ; End of function sub_7BFC
7C01                
7C03                
7C03              ; ��������������� S U B R O U T I N E ���������������������������������������
7C03                
7C03                
7C03              sub_7C03:
7C03
7C03 A0 00                        LDY     #0
7C05 84 05                        STY     5
7C07 84 07                        STY     7
7C09 0A                           ASL     A
7C0A 26 05                        ROL     5
7C0C 0A                           ASL     A
7C0D 26 05                        ROL     5
7C0F 85 04                        STA     4
7C11 8A                           TXA     
7C12 0A                           ASL     A
7C13 26 07                        ROL     7
7C15 0A                           ASL     A
7C16 26 07                        ROL     7
7C18 85 06                        STA     6
7C1A A2 04                        LDX     #4
7C1A              ; End of function sub_7C03
7C1A                
7C1C                
7C1C              ; ��������������� S U B R O U T I N E ���������������������������������������
7C1C                
7C1C                
7C1C              sub_7C1C:
7C1C B5 02                        LDA     2,X
7C1E A0 00                        LDY     #0
7C20 91 02                        STA     (2),Y
7C22 B5 03                        LDA     3,X
7C24 29 0F                        AND     #$F
7C26 09 A0                        ORA     #$A0
7C28 C8                           INY     
7C29 91 02                        STA     (2),Y
7C2B B5 00                        LDA     0,X
7C2D C8                           INY     
7C2E 91 02                        STA     (2),Y
7C30 B5 01                        LDA     1,X
7C32 29 0F                        AND     #$F
7C34 05 00                        ORA     0
7C36 C8                           INY     
7C37 91 02                        STA     (2),Y
7C37              ; End of function sub_7C1C
7C37                
7C39                
7C39              ; ��������������� S U B R O U T I N E ���������������������������������������
7C39                
7C39                
7C39              sub_7C39:
7C39
7C39 98                           TYA     
7C3A 38                           SEC     
7C3B 65 02                        ADC     2
7C3D 85 02                        STA     2
7C3F 90 02                        BCC     locret_7C43
7C41 E6 03                        INC     3
7C43                
7C43              locret_7C43:
7C43 60                           RTS     
7C43              ; End of function sub_7C39
7C43                
7C43              ; ---------------------------------------------------------------------------
7C44 A9                           .BYTE  $A9
7C45 D0                           .BYTE  $D0
7C46 4C                           .BYTE  $4C
7C47 C2                           .BYTE  $C2
7C48 7B                           .BYTE  $7B
7C49                
7C49              ; ��������������� S U B R O U T I N E ���������������������������������������
7C49                
7C49                
7C49              sub_7C49:
7C49 A5 05                        LDA     5
7C4B C9 80                        CMP     #$80
7C4D 90 11                        BCC     loc_7C60
7C4F 49 FF                        EOR     #$FF
7C51 85 05                        STA     5
7C53 A5 04                        LDA     4
7C55 49 FF                        EOR     #$FF
7C57 69 00                        ADC     #0
7C59 85 04                        STA     4
7C5B 90 02                        BCC     loc_7C5F
7C5D E6 05                        INC     5
7C5F                
7C5F              loc_7C5F:
7C5F 38                           SEC     
7C60                
7C60              loc_7C60:
7C60 26 08                        ROL     8
7C62 A5 07                        LDA     7
7C64 C9 80                        CMP     #$80
7C66 90 11                        BCC     loc_7C79
7C68 49 FF                        EOR     #$FF
7C6A 85 07                        STA     7
7C6C A5 06                        LDA     6
7C6E 49 FF                        EOR     #$FF
7C70 69 00                        ADC     #0
7C72 85 06                        STA     6
7C74 90 02                        BCC     loc_7C78
7C76 E6 07                        INC     7
7C78                
7C78              loc_7C78:
7C78 38                           SEC     
7C79                
7C79              loc_7C79:
7C79 26 08                        ROL     8
7C7B A5 05                        LDA     5
7C7D 05 07                        ORA     7
7C7F F0 0A                        BEQ     loc_7C8B
7C81 A2 00                        LDX     #0
7C83 C9 02                        CMP     #2
7C85 B0 24                        BCS     loc_7CAB
7C87 A0 01                        LDY     #1
7C89 D0 10                        BNE     loc_7C9B
7C8B                
7C8B              loc_7C8B:
7C8B A0 02                        LDY     #2
7C8D A2 09                        LDX     #9
7C8F A5 04                        LDA     4
7C91 05 06                        ORA     6
7C93 F0 16                        BEQ     loc_7CAB
7C95 30 04                        BMI     loc_7C9B
7C97                
7C97              loc_7C97:
7C97 C8                           INY     
7C98 0A                           ASL     A
7C99 10 FC                        BPL     loc_7C97
7C9B                
7C9B              loc_7C9B:
7C9B
7C9B 98                           TYA     
7C9C AA                           TAX     
7C9D A5 05                        LDA     5
7C9F                
7C9F              loc_7C9F:
7C9F 06 04                        ASL     4
7CA1 2A                           ROL     A
7CA2 06 06                        ASL     6
7CA4 26 07                        ROL     7
7CA6 88                           DEY     
7CA7 D0 F6                        BNE     loc_7C9F
7CA9 85 05                        STA     5
7CAB                
7CAB              loc_7CAB:
7CAB
7CAB 8A                           TXA     
7CAC 38                           SEC     
7CAD E9 0A                        SBC     #$A
7CAF 49 FF                        EOR     #$FF
7CB1 0A                           ASL     A
7CB2 66 08                        ROR     8
7CB4 2A                           ROL     A
7CB5 66 08                        ROR     8
7CB7 2A                           ROL     A
7CB8 0A                           ASL     A
7CB9 85 08                        STA     8
7CBB A0 00                        LDY     #0
7CBD A5 06                        LDA     6
7CBF 91 02                        STA     (2),Y
7CC1 A5 08                        LDA     8
7CC3 29 F4                        AND     #$F4
7CC5 05 07                        ORA     7
7CC7 C8                           INY     
7CC8 91 02                        STA     (2),Y
7CCA A5 04                        LDA     4
7CCC C8                           INY     
7CCD 91 02                        STA     (2),Y
7CCF A5 08                        LDA     8
7CD1 29 02                        AND     #2
7CD3 0A                           ASL     A
7CD4 05 01                        ORA     1
7CD6 05 05                        ORA     5
7CD8 C8                           INY     
7CD9 91 02                        STA     (2),Y
7CDB 4C 39 7C                     JMP     sub_7C39
7CDB              ; End of function sub_7C49
7CDB                
7CDE                
7CDE              ; ��������������� S U B R O U T I N E ���������������������������������������
7CDE                
7CDE                
7CDE              sub_7CDE:
7CDE
7CDE A2 00                        LDX     #0
7CDE              ; End of function sub_7CDE
7CDE                
7CE0                
7CE0              ; ��������������� S U B R O U T I N E ���������������������������������������
7CE0                
7CE0                
7CE0              sub_7CE0:
7CE0
7CE0 A0 01                        LDY     #1
7CE2 91 02                        STA     (2),Y
7CE4 88                           DEY     
7CE5 98                           TYA     
7CE6 91 02                        STA     (2),Y
7CE8 C8                           INY     
7CE9 C8                           INY     
7CEA 91 02                        STA     (2),Y
7CEC C8                           INY     
7CED 8A                           TXA     
7CEE 91 02                        STA     (2),Y
7CF0 4C 39 7C                     JMP     sub_7C39
7CF0              ; End of function sub_7CE0
7CF0                
7CF3              ; ---------------------------------------------------------------------------
7CF3                
7CF3              loc_7CF3:
7CF3 A2 FE                        LDX     #$FE
7CF5 9A                           TXS     
7CF6 D8                           CLD     
7CF7 A9 00                        LDA     #0
7CF9 AA                           TAX     
7CFA                
7CFA              loc_7CFA:
7CFA CA                           DEX     
7CFB 9D 00 03                     STA     $300,X
7CFE 9D 00 02                     STA     $200,X
7D01 9D 00 01                     STA     $100,X
7D04 95 00                        STA     0,X
7D06 D0 F2                        BNE     loc_7CFA          ;
7D08 AC 07 20                     LDY     $2007             ; Self test switch
7D0B 30 43                        BMI     loc_7D50
7D0D E8                           INX     
7D0E 8E 00 40                     STX     $4000
7D11 A9 E2                        LDA     #$E2
7D13 8D 01 40                     STA     $4001
7D16 A9 B0                        LDA     #$B0
7D18 8D 03 40                     STA     $4003
7D1B 85 32                        STA     $32
7D1D 85 33                        STA     $33
7D1F A9 03                        LDA     #3
7D21 85 6F                        STA     $6F
7D23 8D 00 32                     STA     $3200
7D26 2D 00 28                     AND     $2800             ; DIP switches 8 & 7: # Of Coins For Play
7D29 85 71                        STA     $71
7D2B AD 01 28                     LDA     $2801             ; DIP switches 6 & 5: Coin Multiplier, Right Slot
7D2E 29 03                        AND     #3
7D30 0A                           ASL     A
7D31 0A                           ASL     A
7D32 05 71                        ORA     $71
7D34 85 71                        STA     $71
7D36 AD 02 28                     LDA     $2802             ; DIP switches 4 & 3: 3 - # Of Starting Ships
7D39 29 02                        AND     #2                ; 4 - Coin Multiplier Center/Left Slot
7D3B 0A                           ASL     A
7D3C 0A                           ASL     A
7D3D 0A                           ASL     A
7D3E 05 71                        ORA     $71
7D40 85 71                        STA     $71
7D42 4C 03 68                     JMP     loc_6803
7D45                
7D45              ; ��������������� S U B R O U T I N E ���������������������������������������
7D45                
7D45                
7D45              sub_7D45:
7D45
7D45 A0 00                        LDY     #0
7D47 91 02                        STA     (2),Y
7D49 C8                           INY     
7D4A 8A                           TXA     
7D4B 91 02                        STA     (2),Y
7D4D 4C 39 7C                     JMP     sub_7C39
7D4D              ; End of function sub_7D45
7D4D                
7D50              ; ---------------------------------------------------------------------------
7D50                
7D50              loc_7D50:
7D50
7D50 9D 00 40                     STA     $4000,X
7D53 9D 00 41                     STA     $4100,X
7D56 9D 00 42                     STA     $4200,X
7D59 9D 00 43                     STA     $4300,X
7D5C 9D 00 44                     STA     $4400,X
7D5F 9D 00 45                     STA     $4500,X
7D62 9D 00 46                     STA     $4600,X
7D65 9D 00 47                     STA     $4700,X
7D68 E8                           INX     
7D69 D0 E5                        BNE     loc_7D50
7D6B 8D 00 34                     STA     $3400
7D6E A2 00                        LDX     #0
7D70                
7D70              loc_7D70:
7D70 B5 00                        LDA     0,X
7D72 D0 47                        BNE     loc_7DBB
7D74 A9 11                        LDA     #$11
7D76                
7D76              loc_7D76:
7D76 95 00                        STA     0,X
7D78 A8                           TAY     
7D79 55 00                        EOR     0,X
7D7B D0 3E                        BNE     loc_7DBB
7D7D 98                           TYA     
7D7E 0A                           ASL     A
7D7F 90 F5                        BCC     loc_7D76
7D81 E8                           INX     
7D82 D0 EC                        BNE     loc_7D70
7D84 8D 00 34                     STA     $3400
7D87 8A                           TXA     
7D88 85 00                        STA     0
7D8A 2A                           ROL     A
7D8B                
7D8B              loc_7D8B:
7D8B 85 01                        STA     1
7D8D A0 00                        LDY     #0
7D8F                
7D8F              loc_7D8F:
7D8F
7D8F A2 11                        LDX     #$11
7D91 B1 00                        LDA     (0),Y
7D93 D0 2A                        BNE     loc_7DBF
7D95                
7D95              loc_7D95:
7D95 8A                           TXA     
7D96 91 00                        STA     (0),Y
7D98 51 00                        EOR     (0),Y
7D9A D0 23                        BNE     loc_7DBF
7D9C 8A                           TXA     
7D9D 0A                           ASL     A
7D9E AA                           TAX     
7D9F 90 F4                        BCC     loc_7D95
7DA1 C8                           INY     
7DA2 D0 EB                        BNE     loc_7D8F
7DA4 8D 00 34                     STA     $3400
7DA7 E6 01                        INC     1
7DA9 A6 01                        LDX     1
7DAB E0 04                        CPX     #4
7DAD 90 E0                        BCC     loc_7D8F
7DAF A9 40                        LDA     #$40
7DB1 E0 40                        CPX     #$40
7DB3 90 D6                        BCC     loc_7D8B
7DB5 E0 48                        CPX     #$48
7DB7 90 D6                        BCC     loc_7D8F
7DB9 B0 69                        BCS     loc_7E24
7DBB                
7DBB              loc_7DBB:
7DBB
7DBB A0 00                        LDY     #0
7DBD F0 0E                        BEQ     loc_7DCD
7DBF                
7DBF              loc_7DBF:
7DBF
7DBF A0 00                        LDY     #0
7DC1 A6 01                        LDX     1
7DC3 E0 04                        CPX     #4
7DC5 90 06                        BCC     loc_7DCD
7DC7 C8                           INY     
7DC8 E0 44                        CPX     #$44
7DCA 90 01                        BCC     loc_7DCD
7DCC C8                           INY     
7DCD                
7DCD              loc_7DCD:
7DCD
7DCD C9 10                        CMP     #$10
7DCF 2A                           ROL     A
7DD0 29 1F                        AND     #$1F
7DD2 C9 02                        CMP     #2
7DD4 2A                           ROL     A
7DD5 29 03                        AND     #3
7DD7                
7DD7              loc_7DD7:
7DD7 88                           DEY     
7DD8 30 04                        BMI     loc_7DDE
7DDA 0A                           ASL     A
7DDB 0A                           ASL     A
7DDC 90 F9                        BCC     loc_7DD7
7DDE                
7DDE              loc_7DDE:
7DDE
7DDE 4A                           LSR     A
7DDF A2 14                        LDX     #$14
7DE1 90 02                        BCC     loc_7DE5
7DE3 A2 1D                        LDX     #$1D
7DE5                
7DE5              loc_7DE5:
7DE5 8E 00 3A                     STX     $3A00
7DE8 A2 00                        LDX     #0
7DEA A0 08                        LDY     #8
7DEC                
7DEC              loc_7DEC:
7DEC
7DEC 2C 01 20                     BIT     $2001
7DEF 10 FB                        BPL     loc_7DEC
7DF1                
7DF1              loc_7DF1:
7DF1 2C 01 20                     BIT     $2001
7DF4 30 FB                        BMI     loc_7DF1
7DF6 CA                           DEX     
7DF7 8D 00 34                     STA     $3400
7DFA D0 F0                        BNE     loc_7DEC
7DFC 88                           DEY     
7DFD D0 ED                        BNE     loc_7DEC
7DFF 8E 00 3A                     STX     $3A00
7E02 A0 08                        LDY     #8
7E04                
7E04              loc_7E04:
7E04
7E04 2C 01 20                     BIT     $2001
7E07 10 FB                        BPL     loc_7E04
7E09                
7E09              loc_7E09:
7E09 2C 01 20                     BIT     $2001
7E0C 30 FB                        BMI     loc_7E09
7E0E CA                           DEX     
7E0F 8D 00 34                     STA     $3400
7E12 D0 F0                        BNE     loc_7E04
7E14 88                           DEY     
7E15 D0 ED                        BNE     loc_7E04
7E17 AA                           TAX     
7E18 D0 C4                        BNE     loc_7DDE
7E1A                
7E1A              loc_7E1A:
7E1A 8D 00 34                     STA     $3400
7E1D AD 07 20                     LDA     $2007
7E20 30 F8                        BMI     loc_7E1A
7E22                
7E22              loc_7E22:
7E22 10 FE                        BPL     loc_7E22
7E24                
7E24              loc_7E24:
7E24 A9 00                        LDA     #0
7E26 A8                           TAY     
7E27 AA                           TAX     
7E28 85 08                        STA     8
7E2A A9 50                        LDA     #$50
7E2C                
7E2C              loc_7E2C:
7E2C
7E2C 85 09                        STA     9
7E2E A9 04                        LDA     #4
7E30 85 0B                        STA     $B
7E32 A9 FF                        LDA     #$FF
7E34                
7E34              loc_7E34:
7E34
7E34 51 08                        EOR     (8),Y
7E36 C8                           INY     
7E37 D0 FB                        BNE     loc_7E34
7E39 E6 09                        INC     9
7E3B C6 0B                        DEC     $B
7E3D D0 F5                        BNE     loc_7E34
7E3F 95 0D                        STA     $D,X
7E41 E8                           INX     
7E42 8D 00 34                     STA     $3400
7E45 A5 09                        LDA     9
7E47 C9 58                        CMP     #$58
7E49 90 E1                        BCC     loc_7E2C
7E4B D0 02                        BNE     loc_7E4F
7E4D A9 68                        LDA     #$68
7E4F                
7E4F              loc_7E4F:
7E4F C9 80                        CMP     #$80
7E51 90 D9                        BCC     loc_7E2C
7E53 8D 00 03                     STA     $300
7E56 A2 04                        LDX     #4
7E58 8E 00 32                     STX     $3200
7E5B 86 15                        STX     $15
7E5D A2 00                        LDX     #0
7E5F CD 00 02                     CMP     $200
7E62 F0 01                        BEQ     loc_7E65
7E64 E8                           INX     
7E65                
7E65              loc_7E65:
7E65 AD 00 03                     LDA     $300
7E68 C9 88                        CMP     #$88
7E6A F0 01                        BEQ     loc_7E6D
7E6C E8                           INX     
7E6D                
7E6D              loc_7E6D:
7E6D 86 16                        STX     $16
7E6F A9 10                        LDA     #$10
7E71 85 00                        STA     0
7E73                
7E73              loc_7E73:
7E73 A2 24                        LDX     #$24
7E75                
7E75              loc_7E75:
7E75
7E75 AD 01 20                     LDA     $2001
7E78 10 FB                        BPL     loc_7E75
7E7A                
7E7A              loc_7E7A:
7E7A AD 01 20                     LDA     $2001
7E7D 30 FB                        BMI     loc_7E7A
7E7F CA                           DEX     
7E80 10 F3                        BPL     loc_7E75
7E82                
7E82              loc_7E82:
7E82 2C 02 20                     BIT     $2002
7E85 30 FB                        BMI     loc_7E82
7E87 8D 00 34                     STA     $3400
7E8A A9 00                        LDA     #0
7E8C 85 02                        STA     2
7E8E A9 40                        LDA     #$40
7E90 85 03                        STA     3
7E92 AD 05 20                     LDA     $2005
7E95 10 5B                        BPL     loc_7EF2
7E97 A6 15                        LDX     $15
7E99 AD 03 20                     LDA     $2003
7E9C 10 0A                        BPL     loc_7EA8
7E9E 4D 09 00                     EOR     9
7EA1 10 05                        BPL     loc_7EA8
7EA3 CA                           DEX     
7EA4 F0 02                        BEQ     loc_7EA8
7EA6 86 15                        STX     $15
7EA8                
7EA8              loc_7EA8:
7EA8
7EA8 BC BB 7E                     LDY     $7EBB,X
7EAB A9 B0                        LDA     #$B0
7EAD 91 02                        STA     (2),Y
7EAF 88                           DEY     
7EB0 88                           DEY     
7EB1                
7EB1              loc_7EB1:
7EB1 B9 C0 7E                     LDA     $7EC0,Y
7EB4 91 02                        STA     (2),Y
7EB6 88                           DEY     
7EB7 10 F8                        BPL     loc_7EB1
7EB9 4C 9D 7F                     JMP     loc_7F9D
7EB9              ; ---------------------------------------------------------------------------
7EBC 33                           .BYTE  $33
7EBD 1D                           .BYTE  $1D
7EBE 17                           .BYTE  $17
7EBF 0D                           .BYTE   $D
7EC0 80                           .BYTE  $80
7EC1 A0                           .BYTE  $A0
7EC2 00                           .BYTE    0
7EC3 00                           .BYTE    0
7EC4 00                           .BYTE    0
7EC5 70                           .BYTE  $70
7EC6 00                           .BYTE    0
7EC7 00                           .BYTE    0
7EC8 FF                           .BYTE  $FF
7EC9 92                           .BYTE  $92
7ECA FF                           .BYTE  $FF
7ECB 73                           .BYTE  $73
7ECC D0                           .BYTE  $D0
7ECD A1                           .BYTE  $A1
7ECE 30                           .BYTE  $30
7ECF 02                           .BYTE    2
7ED0 00                           .BYTE    0
7ED1 70                           .BYTE  $70
7ED2 00                           .BYTE    0
7ED3 00                           .BYTE    0
7ED4 7F                           .BYTE  $7F
7ED5 FB                           .BYTE  $FB
7ED6 0D                           .BYTE   $D
7ED7 E0                           .BYTE  $E0
7ED8 00                           .BYTE    0
7ED9 B0                           .BYTE  $B0
7EDA 7E                           .BYTE  $7E
7EDB FA                           .BYTE  $FA
7EDC 11                           .BYTE  $11
7EDD C0                           .BYTE  $C0
7EDE 78                           .BYTE  $78
7EDF FE                           .BYTE  $FE
7EE0 00                           .BYTE    0
7EE1 B0                           .BYTE  $B0
7EE2 13                           .BYTE  $13
7EE3 C0                           .BYTE  $C0
7EE4 00                           .BYTE    0
7EE5 D0                           .BYTE  $D0
7EE6 15                           .BYTE  $15
7EE7 C0                           .BYTE  $C0
7EE8 00                           .BYTE    0
7EE9 D0                           .BYTE  $D0
7EEA 17                           .BYTE  $17
7EEB C0                           .BYTE  $C0
7EEC 00                           .BYTE    0
7EED D0                           .BYTE  $D0
7EEE 7A                           .BYTE  $7A
7EEF F8                           .BYTE  $F8
7EF0 00                           .BYTE    0
7EF1 D0                           .BYTE  $D0
7EF2              ; ---------------------------------------------------------------------------
7EF2                
7EF2              loc_7EF2:
7EF2 A9 50                        LDA     #$50
7EF4 A2 00                        LDX     #0
7EF6 20 FC 7B                     JSR     sub_7BFC
7EF9 A9 69                        LDA     #$69
7EFB A2 93                        LDX     #$93
7EFD 20 03 7C                     JSR     sub_7C03
7F00 A9 30                        LDA     #$30
7F02 20 DE 7C                     JSR     sub_7CDE
7F05 A2 03                        LDX     #3
7F07                
7F07              loc_7F07:
7F07 BD 00 28                     LDA     $2800,X
7F0A 29 01                        AND     #1
7F0C 86 0B                        STX     $B
7F0E 20 D1 7B                     JSR     sub_7BD1
7F11 A6 0B                        LDX     $B
7F13 BD 00 28                     LDA     $2800,X
7F16 29 02                        AND     #2
7F18 4A                           LSR     A
7F19 20 D1 7B                     JSR     sub_7BD1
7F1C A6 0B                        LDX     $B
7F1E CA                           DEX     
7F1F 10 E6                        BPL     loc_7F07
7F21 A9 7A                        LDA     #$7A
7F23 A2 9D                        LDX     #$9D
7F25 20 03 7C                     JSR     sub_7C03
7F28 A9 10                        LDA     #$10
7F2A 20 DE 7C                     JSR     sub_7CDE
7F2D AD 02 28                     LDA     $2802
7F30 29 02                        AND     #2
7F32 4A                           LSR     A
7F33 69 01                        ADC     #1
7F35 20 D1 7B                     JSR     sub_7BD1
7F38 AD 01 28                     LDA     $2801
7F3B 29 03                        AND     #3
7F3D AA                           TAX     
7F3E BD F5 7F                     LDA     $7FF5,X
7F41 20 D1 7B                     JSR     sub_7BD1
7F44 A5 16                        LDA     $16
7F46 F0 07                        BEQ     loc_7F4F
7F48 A2 88                        LDX     #$88
7F4A A9 50                        LDA     #$50
7F4C 20 FC 7B                     JSR     sub_7BFC
7F4F                
7F4F              loc_7F4F:
7F4F A2 96                        LDX     #$96
7F51 8E 0C 00                     STX     $C
7F54 A2 07                        LDX     #7
7F56                
7F56              loc_7F56:
7F56 B5 0D                        LDA     $D,X
7F58 F0 37                        BEQ     loc_7F91
7F5A 48                           PHA     
7F5B 8E 0B 00                     STX     $B
7F5E AE 0C 00                     LDX     $C
7F61 8A                           TXA     
7F62 38                           SEC     
7F63 E9 08                        SBC     #8
7F65 8D 0C 00                     STA     $C
7F68 A9 20                        LDA     #$20
7F6A 20 03 7C                     JSR     sub_7C03
7F6D A9 70                        LDA     #$70
7F6F 20 DE 7C                     JSR     sub_7CDE
7F72 AD 0B 00                     LDA     $B
7F75 20 D1 7B                     JSR     sub_7BD1
7F78 AD D4 56                     LDA     $56D4
7F7B AE D5 56                     LDX     $56D5
7F7E 20 45 7D                     JSR     sub_7D45
7F81 68                           PLA     
7F82 48                           PHA     
7F83 4A                           LSR     A
7F84 4A                           LSR     A
7F85 4A                           LSR     A
7F86 4A                           LSR     A
7F87 20 D1 7B                     JSR     sub_7BD1
7F8A 68                           PLA     
7F8B 20 D1 7B                     JSR     sub_7BD1
7F8E AE 0B 00                     LDX     $B
7F91                
7F91              loc_7F91:
7F91 CA                           DEX     
7F92 10 C2                        BPL     loc_7F56
7F94 A9 7F                        LDA     #$7F
7F96 AA                           TAX     
7F97 20 03 7C                     JSR     sub_7C03
7F9A 20 C0 7B                     JSR     sub_7BC0
7F9D                
7F9D              loc_7F9D:
7F9D A9 00                        LDA     #0
7F9F A2 04                        LDX     #4
7FA1                
7FA1              loc_7FA1:
7FA1 3E 03 20                     ROL     $2003,X
7FA4 6A                           ROR     A
7FA5 CA                           DEX     
7FA6 10 F9                        BPL     loc_7FA1
7FA8 A8                           TAY     
7FA9 A2 07                        LDX     #7
7FAB                
7FAB              loc_7FAB:
7FAB 3E 00 24                     ROL     $2400,X
7FAE 2A                           ROL     A
7FAF CA                           DEX     
7FB0 10 F9                        BPL     loc_7FAB
7FB2 AA                           TAX     
7FB3 45 08                        EOR     8
7FB5 86 08                        STX     8
7FB7 08                           PHP     
7FB8 A9 04                        LDA     #4
7FBA 8D 00 32                     STA     $3200
7FBD 2E 03 20                     ROL     $2003
7FC0 2A                           ROL     A
7FC1 2E 04 20                     ROL     $2004
7FC4 2A                           ROL     A
7FC5 2E 07 24                     ROL     $2407
7FC8 2A                           ROL     A
7FC9 2E 06 24                     ROL     $2406
7FCC 2A                           ROL     A
7FCD 2E 05 24                     ROL     $2405
7FD0 2A                           ROL     A
7FD1 AA                           TAX     
7FD2 28                           PLP     
7FD3 D0 09                        BNE     loc_7FDE
7FD5 45 0A                        EOR     $A
7FD7 D0 05                        BNE     loc_7FDE
7FD9 98                           TYA     
7FDA 45 09                        EOR     9
7FDC F0 02                        BEQ     loc_7FE0
7FDE                
7FDE              loc_7FDE:
7FDE
7FDE A9 80                        LDA     #$80
7FE0                
7FE0              loc_7FE0:
7FE0 8D 05 3C                     STA     $3C05
7FE3 8D 00 32                     STA     $3200
7FE6 8D 00 30                     STA     $3000
7FE9 86 0A                        STX     $A
7FEB 84 09                        STY     9
7FED AD 07 20                     LDA     $2007
7FF0                
7FF0              loc_7FF0:
7FF0 10 FE                        BPL     loc_7FF0
7FF2 4C 73 7E                     JMP     loc_7E73
7FF2              ; ---------------------------------------------------------------------------
7FF5 01                           .BYTE    1
7FF6 04                           .BYTE    4
7FF7 05                           .BYTE    5
7FF8 06                           .BYTE    6
7FF9 4E                           .BYTE  $4E

7FFA 65                           .BYTE  $65                ; NMI
7FFB 7B                           .BYTE  $7B

7FFC F3                           .BYTE  $F3                ; RESET
7FFD 7C                           .BYTE  $7C

7FFE F3                           .BYTE  $F3                ; IRQ
7FFF 7C                           .BYTE  $7C
7FFF              ; end of 'ROM'
7FFF                

