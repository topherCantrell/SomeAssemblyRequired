                                           
                                           ;  processor 6502
                                           
                                           ; <EditorTab name="BUILD">
                                           ;  *** Complie the assembly
                                           ;  build-command java Blend TicTacToe.asm TTT2.asm
                                           ;  build-command tasm -fFF -b -65 TTT2.asm TTT2.bin
                                           
                                           ;  *** Split the resulting binary into the 3 EPROMs needed by MAME
                                           ;  build-command java EpromTool -split TTT2.bin 035145.02 035144.02 035143.02
                                           
                                           ;  *** Copy results to the MAME directory for running
                                           ;  build-command jar -cfM c:\mame\roms\asteroid.zip *.02
                                           
                                           ; </EditorTab>
                                           
                                           
                                           ; <EditorTab name="DVG">
DVG_Trigger      .equ     12288            
DVG_RAM          .equ     16384            
                                           ; </EditorTab>
                                           
                                           ; <EditorTab name="RAM">
RAM_CellData     .equ     0                ; OLine=24
RAM_LineData     .equ     9                ; OLine=25
                                           
RAM_Temp         .equ     20               ; OLine=27
                                           ; </EditorTab>
                                           
                 .org     63488            
                                           
                                           ; <EditorTab name="main">
main:                                      ;  --SubroutineContextBegins--
                                           
                                           
                                           ;  Wait for the DVG to finish
                                           
                 LDX      #16*7            ; OLine=38
FLOW_A_1_OUTPUT_BEGIN:                           
                 LDA      SnapShot,X       ; OLine=40
                 STA      $4000,X          ; OLine=41
                 CPX      #0               
                 BNE      FLOW_A_1_OUTPUT_BEGIN 
                                           
FLOW_A_2_OUTPUT_BEGIN:                           
                 LDA      $2002            ; OLine=45
                 CMP      #127             
                 BEQ      FLOW_A_2_OUTPUT_FALSE 
                 BCS      FLOW_A_2_OUTPUT_BEGIN 
FLOW_A_2_OUTPUT_FALSE:                           
                                           
                                           
                                           
                                           
                                           ;   MakeVectorList()
                                           ;   DVG_Trigger = A
                                           
                                           ;   do {
                                           ;   } while(true)
                                           
                 RTS                       ;  --SubroutineContextEnds--
                                           ; </EditorTab>
                                           
                                           ; <EditorTab name="MakeVectorList">
                                           
RollFlashPattern:                           ;  --SubroutineContextBegins--
                                           
                 TAX                       ; OLine=64  Hold this
                 AND      #15              
                 STA      RAM_Temp         ; OLine=66  ... to temporary
                 TXA                       ; OLine=67  Original value back
                                           
                 AND      #240             
                 ASL      A                ; OLine=70  Shift the flash part to the left
                 BCC      FLOW_A_3_OUTPUT_FALSE 
                 ORA      #16              
FLOW_A_3_OUTPUT_FALSE:                           
                                           
                 AND      RAM_Temp         ; OLine=75  Restore the lower two bits
                                           
                 RTS                       ;  --SubroutineContextEnds--
                                           
ProcessLine:                               ;  --SubroutineContextBegins--
                 AND      #131             
                 CMP      #128             
                 BEQ      FLOW_A_4_OUTPUT_FALSE 
                 BCC      FLOW_A_4_OUTPUT_FALSE 
                 JSR      DVG_CopySequence ; OLine=82  Draw the win line
FLOW_A_4_OUTPUT_FALSE:                           
                 RTS                       ;  --SubroutineContextEnds--
                                           
ProcessCell:                               ;  --SubroutineContextBegins--
                 AND      #131             
                 CMP      #128             
                 BEQ      FLOW_A_5_OUTPUT_FALSE 
                 BCC      FLOW_A_5_OUTPUT_FALSE 
                 JSR      DVG_CopySequence ; OLine=89  Center the cell
                 CMP      #129             
                 BEQ      FLOW_A_6_OUTPUT_TRUE 
                 LDY      #DVG_O_Commands-DVG_BoardCommands ; OLine=93
                 JMP      FLOW_A_6_OUTPUT_END 
FLOW_A_6_OUTPUT_TRUE:                           
                 LDY      #DVG_X_Commands-DVG_BoardCommands ; OLine=91
FLOW_A_6_OUTPUT_END:                           
                 JSR      DVG_CopySequence ; OLine=95  X or O
FLOW_A_5_OUTPUT_FALSE:                           
                 RTS                       ;  --SubroutineContextEnds--
                                           
                                           ;  This routine builds the vector command list from the state of the game
                                           ;  cells and lines
                                           
MakeVectorList:                            ;  --SubroutineContextBegins--
                                           
                                           ;  In the real hardware, trigger the draw, wait, then do this
                                           
                 LDX      #0               ; OLine=106  Start of RAM
                                           
                                           ;  First draw the 4 lines of the board
                                           
                 LDY      #0               ; OLine=110  DVG_BoardCommands offset
                 JSR      DVG_CopySequence ; OLine=111
                                           
                                           ;  Draw the 9 cells
                                           
                 LDA      RAM_CellData+0   ; OLine=115
                 LDY      #DVG_CenterCell0-DVG_BoardCommands ; OLine=116
                 JSR      ProcessCell      ; OLine=117
                                           
                 LDA      RAM_CellData+1   ; OLine=119
                 LDY      #DVG_CenterCell1-DVG_BoardCommands ; OLine=120
                 JSR      ProcessCell      ; OLine=121
                                           
                 LDA      RAM_CellData+2   ; OLine=123
                 LDY      #DVG_CenterCell2-DVG_BoardCommands ; OLine=124
                 JSR      ProcessCell      ; OLine=125
                                           
                 LDA      RAM_CellData+3   ; OLine=127
                 LDY      #DVG_CenterCell3-DVG_BoardCommands ; OLine=128
                 JSR      ProcessCell      ; OLine=129
                                           
                 LDA      RAM_CellData+4   ; OLine=131
                 LDY      #DVG_CenterCell4-DVG_BoardCommands ; OLine=132
                 JSR      ProcessCell      ; OLine=133
                                           
                 LDA      RAM_CellData+5   ; OLine=135
                 LDY      #DVG_CenterCell5-DVG_BoardCommands ; OLine=136
                 JSR      ProcessCell      ; OLine=137
                                           
                 LDA      RAM_CellData+6   ; OLine=139
                 LDY      #DVG_CenterCell6-DVG_BoardCommands ; OLine=140
                 JSR      ProcessCell      ; OLine=141
                                           
                 LDA      RAM_CellData+7   ; OLine=143
                 LDY      #DVG_CenterCell7-DVG_BoardCommands ; OLine=144
                 JSR      ProcessCell      ; OLine=145
                                           
                 LDA      RAM_CellData+8   ; OLine=147
                 LDY      #DVG_CenterCell8-DVG_BoardCommands ; OLine=148
                 JSR      ProcessCell      ; OLine=149
                                           
                                           ;  Draw the 8 lines
                                           
                 LDA      RAM_LineData+0   ; OLine=153
                 LDY      #DVG_WinLine0-DVG_BoardCommands ; OLine=154
                 JSR      ProcessLine      ; OLine=155
                                           
                 LDA      RAM_LineData+1   ; OLine=157
                 LDY      #DVG_WinLine1-DVG_BoardCommands ; OLine=158
                 JSR      ProcessLine      ; OLine=159
                                           
                 LDA      RAM_LineData+2   ; OLine=161
                 LDY      #DVG_WinLine2-DVG_BoardCommands ; OLine=162
                 JSR      ProcessLine      ; OLine=163
                                           
                 LDA      RAM_LineData+3   ; OLine=165
                 LDY      #DVG_WinLine3-DVG_BoardCommands ; OLine=166
                 JSR      ProcessLine      ; OLine=167
                                           
                 LDA      RAM_LineData+4   ; OLine=169
                 LDY      #DVG_WinLine4-DVG_BoardCommands ; OLine=170
                 JSR      ProcessLine      ; OLine=171
                                           
                 LDA      RAM_LineData+5   ; OLine=173
                 LDY      #DVG_WinLine5-DVG_BoardCommands ; OLine=174
                 JSR      ProcessLine      ; OLine=175
                                           
                 LDA      RAM_LineData+6   ; OLine=177
                 LDY      #DVG_WinLine6-DVG_BoardCommands ; OLine=178
                 JSR      ProcessLine      ; OLine=179
                                           
                 LDA      RAM_LineData+7   ; OLine=181
                 LDY      #DVG_WinLine7-DVG_BoardCommands ; OLine=182
                 JSR      ProcessLine      ; OLine=183
                                           
                                           ;  End the vector list
                                           
                 LDY      #DVG_HaltCommand-DVG_BoardCommands ; OLine=187
                 JSR      DVG_CopySequence ; OLine=188
                                           
                                           ;  Roll all the flash-patterns for lines and cells
                                           
                 LDA      RAM_CellData+0   ; OLine=192
                 JSR      RollFlashPattern ; OLine=193
                 STA      RAM_CellData+0   ; OLine=194
                                           
                 LDA      RAM_CellData+1   ; OLine=196
                 JSR      RollFlashPattern ; OLine=197
                 STA      RAM_CellData+1   ; OLine=198
                                           
                 LDA      RAM_CellData+2   ; OLine=200
                 JSR      RollFlashPattern ; OLine=201
                 STA      RAM_CellData+2   ; OLine=202
                                           
                 LDA      RAM_CellData+3   ; OLine=204
                 JSR      RollFlashPattern ; OLine=205
                 STA      RAM_CellData+3   ; OLine=206
                                           
                 LDA      RAM_CellData+4   ; OLine=208
                 JSR      RollFlashPattern ; OLine=209
                 STA      RAM_CellData+4   ; OLine=210
                                           
                 LDA      RAM_CellData+5   ; OLine=212
                 JSR      RollFlashPattern ; OLine=213
                 STA      RAM_CellData+5   ; OLine=214
                                           
                 LDA      RAM_CellData+6   ; OLine=216
                 JSR      RollFlashPattern ; OLine=217
                 STA      RAM_CellData+6   ; OLine=218
                                           
                 LDA      RAM_CellData+7   ; OLine=220
                 JSR      RollFlashPattern ; OLine=221
                 STA      RAM_CellData+7   ; OLine=222
                                           
                 LDA      RAM_CellData+8   ; OLine=224
                 JSR      RollFlashPattern ; OLine=225
                 STA      RAM_CellData+8   ; OLine=226
                                           
                 LDA      RAM_LineData+0   ; OLine=228
                 JSR      RollFlashPattern ; OLine=229
                 STA      RAM_LineData+0   ; OLine=230
                                           
                 LDA      RAM_LineData+1   ; OLine=232
                 JSR      RollFlashPattern ; OLine=233
                 STA      RAM_LineData+1   ; OLine=234
                                           
                 LDA      RAM_LineData+2   ; OLine=236
                 JSR      RollFlashPattern ; OLine=237
                 STA      RAM_LineData+2   ; OLine=238
                                           
                 LDA      RAM_LineData+3   ; OLine=240
                 JSR      RollFlashPattern ; OLine=241
                 STA      RAM_LineData+3   ; OLine=242
                                           
                 LDA      RAM_LineData+4   ; OLine=244
                 JSR      RollFlashPattern ; OLine=245
                 STA      RAM_LineData+4   ; OLine=246
                                           
                 LDA      RAM_LineData+5   ; OLine=248
                 JSR      RollFlashPattern ; OLine=249
                 STA      RAM_LineData+5   ; OLine=250
                                           
                 LDA      RAM_LineData+6   ; OLine=252
                 JSR      RollFlashPattern ; OLine=253
                 STA      RAM_LineData+6   ; OLine=254
                                           
                 LDA      RAM_LineData+7   ; OLine=256
                 JSR      RollFlashPattern ; OLine=257
                 STA      RAM_LineData+7   ; OLine=258
                                           
                 RTS                       ;  --SubroutineContextEnds--
                                           
                                           ;  This routine copies the WORD commands from the data at Y to
                                           ;  the DVG at RAM incrementing X along the way.
                                           
DVG_CopySequence:                           ;  --SubroutineContextBegins--
                                           
FLOW_A_7_OUTPUT_BEGIN:                           
                                           
                                           ;  Copy first byte as-is
                 LDA      DVG_BoardCommands,Y ; OLine=270
                 INY                       ; OLine=271
                 STA      DVG_RAM,X        ; OLine=272
                 INX                       ; OLine=273
                                           
                                           ;  Get the second byte    
                 LDA      DVG_BoardCommands,Y ; OLine=276
                 INY                       ; OLine=277
                 CMP      #0               
                 BNE      FLOW_A_8_OUTPUT_FALSE 
                 DEX                       ; OLine=279
                 RTS                       ; OLine=280  Back over 1st byte
FLOW_A_8_OUTPUT_FALSE:                           
                                           
                                           ;  Store second byte         
                 STA      DVG_RAM,X        ; OLine=284
                 INX                       ; OLine=285
                                           
                 JMP      FLOW_A_7_OUTPUT_BEGIN 
                                           
                 RTS                       ;  --SubroutineContextEnds--
                                           
                                           ; </EditorTab>
                                           
                                           ; <EditorTab name="DVG Commands">
DVG_BoardCommands:                           ; OLine=294
                 .byte    228,160,44,17    
                 .byte    14,241           
                 .byte    202,248          
                 .byte    11,246           
                 .byte    0,96             
                 .byte    128,214          
                 .byte    219,246          
                 .byte    202,248,   219,242,   223,242,  205,242,  205,248,  205,246,  223,246 
                 .byte    0,0              ; OLine=303
                                           
DVG_X_Commands:                            ; OLine=305
                 .byte    0,0              ; OLine=306
                                           
DVG_O_Commands:                            ; OLine=308
                 .byte    0,0              ; OLine=309
                                           
                                           
DVG_HaltCommand:                           ; OLine=312
                 .byte    0,176            
                 .byte    0,0              ; OLine=314
                                           
                                           
DVG_CenterCell0:                           ; OLine=317
                 .byte    0,0              ; OLine=318
DVG_CenterCell1:                           ; OLine=319
                 .byte    0,0              ; OLine=320
DVG_CenterCell2:                           ; OLine=321
                 .byte    0,0              ; OLine=322
DVG_CenterCell3:                           ; OLine=323
                 .byte    0,0              ; OLine=324
DVG_CenterCell4:                           ; OLine=325
                 .byte    0,0              ; OLine=326
DVG_CenterCell5:                           ; OLine=327
                 .byte    0,0              ; OLine=328
DVG_CenterCell6:                           ; OLine=329
                 .byte    0,0              ; OLine=330
DVG_CenterCell7:                           ; OLine=331
                 .byte    0,0              ; OLine=332
DVG_CenterCell8:                           ; OLine=333
                 .byte    0,0              ; OLine=334
                                           
                                           
DVG_WinLine0:                              ; OLine=337
                 .byte    0,0              ; OLine=338
DVG_WinLine1:                              ; OLine=339
                 .byte    0,0              ; OLine=340
DVG_WinLine2:                              ; OLine=341
                 .byte    0,0              ; OLine=342
DVG_WinLine3:                              ; OLine=343
                 .byte    0,0              ; OLine=344
DVG_WinLine4:                              ; OLine=345
                 .byte    0,0              ; OLine=346
DVG_WinLine5:                              ; OLine=347
                 .byte    0,0              ; OLine=348
DVG_WinLine6:                              ; OLine=349
                 .byte    0,0              ; OLine=350
DVG_WinLine7:                              ; OLine=351
                 .byte    0,0              ; OLine=352
                                           
                                           
                                           ; </EditorTab>
                                           
                                           ; <EditorTab name="Interrupts">
                                           
NMIHandler:                                ; OLine=359
                 RTI                       ; OLine=360
                                           
IRQHandler:                                ; OLine=362
                 RTI                       ; OLine=363
                                           
                                           ; </EditorTab>
                                           
                                           ; <EditorTab name="Vectors">
                                           
                 .org     65530            
                 .WORD    NMIHandler       ; OLine=370  NMI vector (not used)
                 .WORD    main             ; OLine=371  Reset vector (start of program)
                 .WORD    IRQHandler       ; OLine=372  IRQ vector
                                           
                                           ; </EditorTab>
                                           
SnapShot:                                  ; OLine=376
                 .byte    1,226,4,162,8,0,0,112,0,0,243,200,24,162,24,3,0,112,0,0,26,201 ; OLine=377
                 .byte    24,162,24,3,0,112,0,0,26,201,24,162,24,3,0,112,0,0,26,201,82,200 ; OLine=378
                 .byte    108,160,100,16,0,112,0,0,44,203,44,203,44,203,221,202,221,202,108 ; OLine=379
                 .byte    160,224,0,0,80,0,0,44,203,44,203,44,203,221,202,221,202,108,160,0 ; OLine=380
                 .byte    16,0,80,0,0,44,203,44,203,44,203,221,202,221,202,252,160,252,16,176 ; OLine=381
                 .byte    176,221,202,252,160,252,16,176,176 ; OLine=382
SnapShotEnd:                               ; OLine=383
                                           
                 .end                      ; OLine=385
