                                           ;  DoubleGap by Christopher Cantrell 2006
                                           ;  ccantrell@knology.net
                                           
                                           ;  TO DO
                                           ;  - Expert switches are backwards
                                           ;  - Debounce switches
                                           
                                           ;  build-command java Blend gap.asm g2.asm
                                           ;  build-command tasm -b -65 g2.asm g2.bin
                                           
                                           ;  This file uses the "BLEND" program for assembly pre-processing
                                           
                 .PROCESSOR 6502             
                                           
                 .INCLUDE "Stella.asm"     ;  Equates to give names to hardware memory locations
                                           
                                           
                                           ;  RAM usage
                                           
                 .EQU     TMP0      = 0x80 ;  Temporary storage
                 .EQU     TMP1      = 0x81 ;  Temporary storage
                 .EQU     TMP2      = 0x82 ;  Temporary storage
                 .EQU     PLAYR0Y   = 0x83 ;  Player 0's Y location (normal or pro)
                 .EQU     PLAYR1Y   = 0x84 ;  Player 1's Y location (normal, pro, or off)
                 .EQU     MUS_TMP0  = 0x85 ;  Game-over mode sound FX storage (frame delay)
                 .EQU     MUS_TMP1  = 0x86 ;  Game-over mode sound FX storage (frequency)
                 .EQU     SCANCNT   = 0x87 ;  Scanline counter during screen drawing
                 .EQU     MODE      = 0x88 ;  Game mode: 0=GameOver 1=Play 2=Select
                 .EQU     WALL_INC  = 0x89 ;  How much to add to wall's Y position
                 .EQU     WALLCNT   = 0x8A ;  Number of walls passed (score)
                 .EQU     WALLDELY  = 0x8B ;  Wall movement frame skip counter
                 .EQU     WALLDELYR = 0x8C ;  Number of frames to skip between wall increments
                 .EQU     ENTROPYA  = 0x8D ;  Incremeneted with every frame
                 .EQU     ENTROPYB  = 0x8E ;  SWCHA adds in
                 .EQU     ENTROPYC  = 0x8F ;  Left/Right movements added to other entropies
                 .EQU     DEBOUNCE  = 0x90 ;  Last state of the Reset/Select switches
                 .EQU     WALLDRELA = 0x91 ;  PF0 pattern for wall
                 .EQU     WALLDRELB = 0x92 ;  PF1 pattern for wall
                 .EQU     WALLDRELC = 0x93 ;  PF2 pattern for wall
                 .EQU     WALLSTART = 0x94 ;  Wall's Y position (scanline)
                 .EQU     WALLHEI   = 0x95 ;  Height of wall
                 .EQU     GAPBITS   = 0x96 ;  Wall's gap pattern (used to make WALLDRELx)
                 .EQU     SCORE_PF1 = 0x97 ;  6-bytes. PF1 pattern for each row of the score
                 .EQU     SCORE_PF2 = 0x9D ;  6-bytes. PF2 pattern for each row of the score
                 .EQU     MUSADEL   = 0xA3 ;  Music A delay count
                 .EQU     MUSAIND   = 0xA4 ;  Music A pointer
                 .EQU     MUSAVOL   = 0xA5 ;  Music A volume
                 .EQU     MUSBDEL   = 0xA6 ;  Music B delay count
                 .EQU     MUSBIND   = 0xA7 ;  Music B pointer
                 .EQU     MUSBVOL   = 0xA8 ;  Music B volume
                                           
                                           ;  Remember, stack builds down from 0xFF
                                           
0xF000:                                    
                                           
                 main()   {                
                 I_Flag   = 1              ;  Turn off interrupts
                 D_Flag   = 0              ;  Clear the "decimal" flag
                 X        = 0xFF           ;  Set the stack pointer ...
                 S        = X              ;  ... to the end of RAM
                 INIT()                    ;  Initialize game environment
                 INIT_SELMODE()                  ;  Start out in SELECT-MODE
                 VIDEO_KERNEL()                  ;  There should be no return from the KERNEL
