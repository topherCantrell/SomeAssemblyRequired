                                           
                                           ;  processor 6502
                                           
                                           ;  build-command java Blend TicTacToe.asm TTT2.asm
                                           ;  build-command tasm -fFF -b -65 TTT2.asm 
                                           
                                           
                                           ; <EditorTab name="DVG">
DVG_Trigger      .equ     12288            
DVG_RAM          .equ     16384            
                                           ; </EditorTab>
                                           
                                           ; <EditorTab name="RAM">
RAM_CellData     .equ     0                ; OLine=14
RAM_LineData     .equ     9                ; OLine=15
                                           
RAM_Temp         .equ     20               ; OLine=17
                                           ; </EditorTab>
                                           
                 .org     63488            
                                           
                                           ; <EditorTab name="main">
main:                                      ;  --SubroutineContextBegins--
                                           
                 JSR      MakeVectorList   ; OLine=25
                 STA      DVG_Trigger      ; OLine=26
                                           
FLOW_A_1_OUTPUT_BEGIN:                           
                 JMP      FLOW_A_1_OUTPUT_BEGIN 
                                           
                 RTS                       ;  --SubroutineContextEnds--
                                           ; </EditorTab>
                                           
                                           ; <EditorTab name="MakeVectorList">
                                           
RollFlashPattern:                           ;  --SubroutineContextBegins--
                                           
                 TAX                       ; OLine=38  Hold this
                 AND      #15              
                 STA      RAM_Temp         ; OLine=40  ... to temporary
                 TXA                       ; OLine=41  Original value back
                                           
                 AND      #240             
                 ASL      A                ; OLine=44  Shift the flash part to the left
                 BCC      FLOW_A_2_OUTPUT_FALSE 
                 ORA      #16              
FLOW_A_2_OUTPUT_FALSE:                           
                                           
                 AND      RAM_Temp         ; OLine=49  Restore the lower two bits
                                           
                 RTS                       ;  --SubroutineContextEnds--
                                           
ProcessLine:                               ;  --SubroutineContextBegins--
                 AND      #131             
                 CMP      #128             
                 BEQ      FLOW_A_3_OUTPUT_FALSE 
                 BCC      FLOW_A_3_OUTPUT_FALSE 
                 JSR      DVG_CopySequence ; OLine=56  Draw the win line
FLOW_A_3_OUTPUT_FALSE:                           
                 RTS                       ;  --SubroutineContextEnds--
                                           
ProcessCell:                               ;  --SubroutineContextBegins--
                 AND      #131             
                 CMP      #128             
                 BEQ      FLOW_A_4_OUTPUT_FALSE 
                 BCC      FLOW_A_4_OUTPUT_FALSE 
                 JSR      DVG_CopySequence ; OLine=63  Center the cell
                 CMP      #129             
                 BEQ      FLOW_A_5_OUTPUT_TRUE 
                 LDY      #DVG_O_Commands-DVG_BoardCommands ; OLine=67
                 JMP      FLOW_A_5_OUTPUT_END 
FLOW_A_5_OUTPUT_TRUE:                           
                 LDY      #DVG_X_Commands-DVG_BoardCommands ; OLine=65
FLOW_A_5_OUTPUT_END:                           
                 JSR      DVG_CopySequence ; OLine=69  X or O
FLOW_A_4_OUTPUT_FALSE:                           
                 RTS                       ;  --SubroutineContextEnds--
                                           
                                           ;  This routine builds the vector command list from the state of the game
                                           ;  cells and lines
                                           
MakeVectorList:                            ;  --SubroutineContextBegins--
                                           
                                           ;  In the real hardware, trigger the draw, wait, then do this
                                           
                 LDX      #0               ; OLine=80  Start of RAM
                                           
                                           ;  First draw the 4 lines of the board
                                           
                 LDY      #0               ; OLine=84  DVG_BoardCommands offset
                 JSR      DVG_CopySequence ; OLine=85
                                           
                                           ;  Draw the 9 cells
                                           
                 LDA      RAM_CellData+0   ; OLine=89
                 LDY      #DVG_CenterCell0-DVG_BoardCommands ; OLine=90
                 JSR      ProcessCell      ; OLine=91
                                           
                 LDA      RAM_CellData+1   ; OLine=93
                 LDY      #DVG_CenterCell1-DVG_BoardCommands ; OLine=94
                 JSR      ProcessCell      ; OLine=95
                                           
                 LDA      RAM_CellData+2   ; OLine=97
                 LDY      #DVG_CenterCell2-DVG_BoardCommands ; OLine=98
                 JSR      ProcessCell      ; OLine=99
                                           
                 LDA      RAM_CellData+3   ; OLine=101
                 LDY      #DVG_CenterCell3-DVG_BoardCommands ; OLine=102
                 JSR      ProcessCell      ; OLine=103
                                           
                 LDA      RAM_CellData+4   ; OLine=105
                 LDY      #DVG_CenterCell4-DVG_BoardCommands ; OLine=106
                 JSR      ProcessCell      ; OLine=107
                                           
                 LDA      RAM_CellData+5   ; OLine=109
                 LDY      #DVG_CenterCell5-DVG_BoardCommands ; OLine=110
                 JSR      ProcessCell      ; OLine=111
                                           
                 LDA      RAM_CellData+6   ; OLine=113
                 LDY      #DVG_CenterCell6-DVG_BoardCommands ; OLine=114
                 JSR      ProcessCell      ; OLine=115
                                           
                 LDA      RAM_CellData+7   ; OLine=117
                 LDY      #DVG_CenterCell7-DVG_BoardCommands ; OLine=118
                 JSR      ProcessCell      ; OLine=119
                                           
                 LDA      RAM_CellData+8   ; OLine=121
                 LDY      #DVG_CenterCell8-DVG_BoardCommands ; OLine=122
                 JSR      ProcessCell      ; OLine=123
                                           
                                           ;  Draw the 8 lines
                                           
                 LDA      RAM_LineData+0   ; OLine=127
                 LDY      #DVG_WinLine0-DVG_BoardCommands ; OLine=128
                 JSR      ProcessLine      ; OLine=129
                                           
                 LDA      RAM_LineData+1   ; OLine=131
                 LDY      #DVG_WinLine1-DVG_BoardCommands ; OLine=132
                 JSR      ProcessLine      ; OLine=133
                                           
                 LDA      RAM_LineData+2   ; OLine=135
                 LDY      #DVG_WinLine2-DVG_BoardCommands ; OLine=136
                 JSR      ProcessLine      ; OLine=137
                                           
                 LDA      RAM_LineData+3   ; OLine=139
                 LDY      #DVG_WinLine3-DVG_BoardCommands ; OLine=140
                 JSR      ProcessLine      ; OLine=141
                                           
                 LDA      RAM_LineData+4   ; OLine=143
                 LDY      #DVG_WinLine4-DVG_BoardCommands ; OLine=144
                 JSR      ProcessLine      ; OLine=145
                                           
                 LDA      RAM_LineData+5   ; OLine=147
                 LDY      #DVG_WinLine5-DVG_BoardCommands ; OLine=148
                 JSR      ProcessLine      ; OLine=149
                                           
                 LDA      RAM_LineData+6   ; OLine=151
                 LDY      #DVG_WinLine6-DVG_BoardCommands ; OLine=152
                 JSR      ProcessLine      ; OLine=153
                                           
                 LDA      RAM_LineData+7   ; OLine=155
                 LDY      #DVG_WinLine7-DVG_BoardCommands ; OLine=156
                 JSR      ProcessLine      ; OLine=157
                                           
                                           ;  End the vector list
                                           
                 LDY      #DVG_HaltCommand-DVG_BoardCommands ; OLine=161
                 JSR      DVG_CopySequence ; OLine=162
                                           
                                           ;  Roll all the flash-patterns for lines and cells
                                           
                 LDA      RAM_CellData+0   ; OLine=166
                 JSR      RollFlashPattern ; OLine=167
                 STA      RAM_CellData+0   ; OLine=168
                                           
                 LDA      RAM_CellData+1   ; OLine=170
                 JSR      RollFlashPattern ; OLine=171
                 STA      RAM_CellData+1   ; OLine=172
                                           
                 LDA      RAM_CellData+2   ; OLine=174
                 JSR      RollFlashPattern ; OLine=175
                 STA      RAM_CellData+2   ; OLine=176
                                           
                 LDA      RAM_CellData+3   ; OLine=178
                 JSR      RollFlashPattern ; OLine=179
                 STA      RAM_CellData+3   ; OLine=180
                                           
                 LDA      RAM_CellData+4   ; OLine=182
                 JSR      RollFlashPattern ; OLine=183
                 STA      RAM_CellData+4   ; OLine=184
                                           
                 LDA      RAM_CellData+5   ; OLine=186
                 JSR      RollFlashPattern ; OLine=187
                 STA      RAM_CellData+5   ; OLine=188
                                           
                 LDA      RAM_CellData+6   ; OLine=190
                 JSR      RollFlashPattern ; OLine=191
                 STA      RAM_CellData+6   ; OLine=192
                                           
                 LDA      RAM_CellData+7   ; OLine=194
                 JSR      RollFlashPattern ; OLine=195
                 STA      RAM_CellData+7   ; OLine=196
                                           
                 LDA      RAM_CellData+8   ; OLine=198
                 JSR      RollFlashPattern ; OLine=199
                 STA      RAM_CellData+8   ; OLine=200
                                           
                 LDA      RAM_LineData+0   ; OLine=202
                 JSR      RollFlashPattern ; OLine=203
                 STA      RAM_LineData+0   ; OLine=204
                                           
                 LDA      RAM_LineData+1   ; OLine=206
                 JSR      RollFlashPattern ; OLine=207
                 STA      RAM_LineData+1   ; OLine=208
                                           
                 LDA      RAM_LineData+2   ; OLine=210
                 JSR      RollFlashPattern ; OLine=211
                 STA      RAM_LineData+2   ; OLine=212
                                           
                 LDA      RAM_LineData+3   ; OLine=214
                 JSR      RollFlashPattern ; OLine=215
                 STA      RAM_LineData+3   ; OLine=216
                                           
                 LDA      RAM_LineData+4   ; OLine=218
                 JSR      RollFlashPattern ; OLine=219
                 STA      RAM_LineData+4   ; OLine=220
                                           
                 LDA      RAM_LineData+5   ; OLine=222
                 JSR      RollFlashPattern ; OLine=223
                 STA      RAM_LineData+5   ; OLine=224
                                           
                 LDA      RAM_LineData+6   ; OLine=226
                 JSR      RollFlashPattern ; OLine=227
                 STA      RAM_LineData+6   ; OLine=228
                                           
                 LDA      RAM_LineData+7   ; OLine=230
                 JSR      RollFlashPattern ; OLine=231
                 STA      RAM_LineData+7   ; OLine=232
                                           
                 RTS                       ;  --SubroutineContextEnds--
                                           
                                           ;  This routine copies the WORD commands from the data at Y to
                                           ;  the DVG at RAM incrementing X along the way.
                                           
DVG_CopySequence:                           ;  --SubroutineContextBegins--
                                           
FLOW_A_6_OUTPUT_BEGIN:                           
                                           
                                           ;  Copy first byte as-is
                 LDA      DVG_BoardCommands,Y ; OLine=244
                 INY                       ; OLine=245
                 STA      DVG_RAM,X        ; OLine=246
                 INX                       ; OLine=247
                                           
                                           ;  Get the second byte    
                 LDA      DVG_BoardCommands,Y ; OLine=250
                 INY                       ; OLine=251
                 CMP      #0               
                 BNE      FLOW_A_7_OUTPUT_FALSE 
                 DEX                       ; OLine=253
                 RTS                       ; OLine=254  Back over 1st byte
FLOW_A_7_OUTPUT_FALSE:                           
                                           
                                           ;  Store second byte         
                 STA      DVG_RAM,X        ; OLine=258
                 INX                       ; OLine=259
                                           
                 JMP      FLOW_A_6_OUTPUT_BEGIN 
                                           
                 RTS                       ;  --SubroutineContextEnds--
                                           
                                           ; </EditorTab>
                                           
                                           ; <EditorTab name="DVG Commands">
DVG_BoardCommands:                           ; OLine=268
                 .byte    228,160,44,17    
                 .byte    14,241           
                 .byte    202,248          
                 .byte    11,246           
                 .byte    0,96             
                 .byte    128,214          
                 .byte    219,246          
                 .byte    202,248,   219,242,   223,242,  205,242,  205,248,  205,246,  223,246 
                 .byte    0,0              ; OLine=277
                                           
DVG_X_Commands:                            ; OLine=279
                 .byte    0,0              ; OLine=280
                                           
DVG_O_Commands:                            ; OLine=282
                 .byte    0,0              ; OLine=283
                                           
                                           
DVG_HaltCommand:                           ; OLine=286
                 .byte    0,176            
                 .byte    0,0              ; OLine=288
                                           
                                           
DVG_CenterCell0:                           ; OLine=291
                 .byte    0,0              ; OLine=292
DVG_CenterCell1:                           ; OLine=293
                 .byte    0,0              ; OLine=294
DVG_CenterCell2:                           ; OLine=295
                 .byte    0,0              ; OLine=296
DVG_CenterCell3:                           ; OLine=297
                 .byte    0,0              ; OLine=298
DVG_CenterCell4:                           ; OLine=299
                 .byte    0,0              ; OLine=300
DVG_CenterCell5:                           ; OLine=301
                 .byte    0,0              ; OLine=302
DVG_CenterCell6:                           ; OLine=303
                 .byte    0,0              ; OLine=304
DVG_CenterCell7:                           ; OLine=305
                 .byte    0,0              ; OLine=306
DVG_CenterCell8:                           ; OLine=307
                 .byte    0,0              ; OLine=308
                                           
                                           
DVG_WinLine0:                              ; OLine=311
                 .byte    0,0              ; OLine=312
DVG_WinLine1:                              ; OLine=313
                 .byte    0,0              ; OLine=314
DVG_WinLine2:                              ; OLine=315
                 .byte    0,0              ; OLine=316
DVG_WinLine3:                              ; OLine=317
                 .byte    0,0              ; OLine=318
DVG_WinLine4:                              ; OLine=319
                 .byte    0,0              ; OLine=320
DVG_WinLine5:                              ; OLine=321
                 .byte    0,0              ; OLine=322
DVG_WinLine6:                              ; OLine=323
                 .byte    0,0              ; OLine=324
DVG_WinLine7:                              ; OLine=325
                 .byte    0,0              ; OLine=326
                                           
                                           
                                           ; </EditorTab>
                                           
                                           ; <EditorTab name="Interrupts">
                                           
NMIHandler:                                ; OLine=333
                 RTI                       ; OLine=334
                                           
IRQHandler:                                ; OLine=336
                 RTI                       ; OLine=337
                                           
                                           ; </EditorTab>
                                           
                                           ; <EditorTab name="Vectors">
                                           
                 .org     65530            
                 .WORD    NMIHandler       ; OLine=344  NMI vector (not used)
                 .WORD    main             ; OLine=345  Reset vector (start of program)
                 .WORD    IRQHandler       ; OLine=346  IRQ vector
                                           
                                           ; </EditorTab>
                                           
                 .end                      ; OLine=350
