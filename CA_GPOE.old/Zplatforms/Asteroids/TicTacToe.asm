
processor 6502

; build-command java Blend TicTacToe.asm TTT2.asm
; build-command tasm -fFF -b -65 TTT2.asm 


;<EditorTab name="DVG">
DVG_Trigger  .equ 0x3000
DVG_RAM      .equ 0x4000
;</EditorTab>

;<EditorTab name="RAM">
RAM_CellData .equ 0 
RAM_LineData .equ 9

RAM_Temp     .equ 20
;</EditorTab>

    .org  0xF800

;<EditorTab name="main">
main() {
  
  MakeVectorList()
  DVG_Trigger = A

  do {
  } while(true)

}
;</EditorTab>

;<EditorTab name="MakeVectorList">

RollFlashPattern() { ; A = pattern in/out

  X = A          ; Hold this
  A = A & 0x0F   ; Get lower two four ...
  RAM_Temp = A   ; ... to temporary
  A = X          ; Original value back

  A = A & 0xF0     ; Drop the lower four bits
  ASL A            ; Shift the flash part to the left
  if(CARRY-SET) {  ; If we shifted out a one ...
    A = A | 0x10   ; ... move it back in on the right
  }

  A = A & RAM_Temp   ; Restore the lower two bits

}

ProcessLine() { ; A = line data, Y=commands for line, X=RAM offset
  A = A & 0x83 ; Top bit and bottom two
  if(A>0x80) {
    DVG_CopySequence() ; Draw the win line
  }
}

ProcessCell() { ; A=Cell data, Y=center DVG commands for cell, X=RAM offset
  A = A & 0x83 ; Top bit and bottom two
  if(A>0x80) {
    DVG_CopySequence() ; Center the cell
    if(A==0x81) {
      Y = DVG_X_Commands - DVG_BoardCommands
    } else {
      Y = DVG_O_Commands - DVG_BoardCommands
    }
    DVG_CopySequence() ; X or O
  }
}

; This routine builds the vector command list from the state of the game
; cells and lines
;
MakeVectorList() {

; In the real hardware, trigger the draw, wait, then do this

  X = 0 ; Start of RAM

; First draw the 4 lines of the board

  Y = 0 ; DVG_BoardCommands offset
  DVG_CopySequence()

; Draw the 9 cells

  A = RAM_CellData[0]
  Y = DVG_CenterCell0 - DVG_BoardCommands
  ProcessCell()

  A = RAM_CellData[1]
  Y = DVG_CenterCell1 - DVG_BoardCommands
  ProcessCell()

  A = RAM_CellData[2]
  Y = DVG_CenterCell2 - DVG_BoardCommands
  ProcessCell()

  A = RAM_CellData[3]
  Y = DVG_CenterCell3 - DVG_BoardCommands
  ProcessCell()

  A = RAM_CellData[4]
  Y = DVG_CenterCell4 - DVG_BoardCommands
  ProcessCell()

  A = RAM_CellData[5]
  Y = DVG_CenterCell5 - DVG_BoardCommands
  ProcessCell()

  A = RAM_CellData[6]
  Y = DVG_CenterCell6 - DVG_BoardCommands
  ProcessCell()

  A = RAM_CellData[7]
  Y = DVG_CenterCell7 - DVG_BoardCommands
  ProcessCell()

  A = RAM_CellData[8]
  Y = DVG_CenterCell8 - DVG_BoardCommands
  ProcessCell()  

; Draw the 8 lines

  A = RAM_LineData[0]
  Y = DVG_WinLine0 - DVG_BoardCommands
  ProcessLine() 

  A = RAM_LineData[1]
  Y = DVG_WinLine1 - DVG_BoardCommands
  ProcessLine() 

  A = RAM_LineData[2]
  Y = DVG_WinLine2 - DVG_BoardCommands
  ProcessLine() 

  A = RAM_LineData[3]
  Y = DVG_WinLine3 - DVG_BoardCommands
  ProcessLine() 

  A = RAM_LineData[4]
  Y = DVG_WinLine4 - DVG_BoardCommands
  ProcessLine() 

  A = RAM_LineData[5]
  Y = DVG_WinLine5 - DVG_BoardCommands
  ProcessLine() 

  A = RAM_LineData[6]
  Y = DVG_WinLine6 - DVG_BoardCommands
  ProcessLine() 

  A = RAM_LineData[7]
  Y = DVG_WinLine7 - DVG_BoardCommands
  ProcessLine() 

; End the vector list

  Y = DVG_HaltCommand - DVG_BoardCommands
  DVG_CopySequence()

; Roll all the flash-patterns for lines and cells

  A = RAM_CellData[0]
  RollFlashPattern()
  RAM_CellData[0] = A

  A = RAM_CellData[1]
  RollFlashPattern()
  RAM_CellData[1] = A

  A = RAM_CellData[2]
  RollFlashPattern()
  RAM_CellData[2] = A

  A = RAM_CellData[3]
  RollFlashPattern()
  RAM_CellData[3] = A

  A = RAM_CellData[4]
  RollFlashPattern()
  RAM_CellData[4] = A

  A = RAM_CellData[5]
  RollFlashPattern()
  RAM_CellData[5] = A

  A = RAM_CellData[6]
  RollFlashPattern()
  RAM_CellData[6] = A

  A = RAM_CellData[7]
  RollFlashPattern()
  RAM_CellData[7] = A

  A = RAM_CellData[8]
  RollFlashPattern()
  RAM_CellData[8] = A

  A = RAM_LineData[0]
  RollFlashPattern()
  RAM_LineData[0] = A

  A = RAM_LineData[1]
  RollFlashPattern()
  RAM_LineData[1] = A

  A = RAM_LineData[2]
  RollFlashPattern()
  RAM_LineData[2] = A

  A = RAM_LineData[3]
  RollFlashPattern()
  RAM_LineData[3] = A

  A = RAM_LineData[4]
  RollFlashPattern()
  RAM_LineData[4] = A

  A = RAM_LineData[5]
  RollFlashPattern()
  RAM_LineData[5] = A

  A = RAM_LineData[6]
  RollFlashPattern()
  RAM_LineData[6] = A

  A = RAM_LineData[7]
  RollFlashPattern()
  RAM_LineData[7] = A

}

; This routine copies the WORD commands from the data at Y to
; the DVG at RAM incrementing X along the way.
;
DVG_CopySequence() { ; X=RAM offset, Y=data offset, next RAM offset->X

  do {

    ; Copy first byte as-is
    A = DVG_BoardCommands[Y]    
    ++Y
    DVG_RAM[X] = A   
    ++X     

    ; Get the second byte    
    A = DVG_BoardCommands[Y]
    ++Y
    if(A==0) {      
      --X
      return  ; Back over 1st byte
    }
    
    ; Store second byte         
    DVG_RAM[X] = A 
    ++X  
    
  } while(true)

}

;</EditorTab>

;<EditorTab name="DVG Commands">
DVG_BoardCommands:
  .byte 0xe4,0xa0,0x2c,0x11
  .byte 0x0e,0xf1   
  .byte 0xca,0xf8   
  .byte 0xb,0xf6   
  .byte 0x00,0x60  
  .byte 0x80,0xd6  
  .byte 0xdb,0xf6
  .byte 0xca,0xf8,   0xdb,0xf2,   0xdf,0xf2,  0xcd,0xf2,  0xcd,0xf8,  0xcd,0xf6,  0xdf,0xf6
  .byte 0,0

DVG_X_Commands:
  .byte 0,0

DVG_O_Commands:
  .byte 0,0


DVG_HaltCommand:
  .byte 0,0xb0
  .byte 0,0


DVG_CenterCell0:
  .byte 0,0
DVG_CenterCell1:
  .byte 0,0
DVG_CenterCell2:
  .byte 0,0
DVG_CenterCell3:
  .byte 0,0
DVG_CenterCell4:
  .byte 0,0
DVG_CenterCell5:
  .byte 0,0
DVG_CenterCell6:
  .byte 0,0
DVG_CenterCell7:
  .byte 0,0
DVG_CenterCell8:
  .byte 0,0


DVG_WinLine0:
  .byte 0,0
DVG_WinLine1:
  .byte 0,0
DVG_WinLine2:
  .byte 0,0
DVG_WinLine3:
  .byte 0,0
DVG_WinLine4:
  .byte 0,0
DVG_WinLine5:
  .byte 0,0
DVG_WinLine6:
  .byte 0,0
DVG_WinLine7:
  .byte 0,0


;</EditorTab>

;<EditorTab name="Interrupts">

NMIHandler:
   RTI

IRQHandler:
   RTI

;</EditorTab>

;<EditorTab name="Vectors">

   .org   0xFFFA        ; Ghosting to 0xFFFA for 2K part
   .WORD  NMIHandler    ; NMI vector (not used)
   .WORD  main          ; Reset vector (start of program)
   .WORD  IRQHandler    ; IRQ vector

;</EditorTab>

   .end
