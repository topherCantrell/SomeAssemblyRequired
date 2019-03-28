.PROCESSOR 6502

.EQU HW_TextDisplay = 0x2000
.EQU HW_Keyboard = 0xD000

.EQU RAM_Temp = 0
 
0xF800:
main:

  JMP main

;---------------------
InputDigit:
  A = HW_TextDisplay[Y]
  A to #'?'
  GO(==) ID_Cursor1
  A = #'?'
  GOTO ID_Cursor2
ID_Cursor1:
  A = #' '
ID_Cursor2:
  HW_TextDisplay[Y] = A
  A = HW_Keyboard
  CALL IsValidHexKey
  A to #0
  GO(==) InputDigit
  HW_TextDisplay[Y] = A
  RETURN

;---------------------
InputByte:
  CALL InputDigit

  CALL ASCIItoBinary
  A<<1
  A<<1
  A<<1
  A<<1
  RAM_Temp = A

  ++Y
  CALL InputDigit
  CALL ASCIItoBinary
  A = A | RAM_Temp
  RETURN

;---------------------
PrintMessage:

  A = MESSAGES[X]
  GO(ZERO) PM_Out
  HW_TextDisplay[Y] = A
  ++X
  ++Y
  GOTO PrintMessage
PM_Out:
  RETURN

MESSAGES:
  .BYTE  "Hello World!",0
MESSAGES_2:
  .BYTE  "How are you?",0
MESSAGES_3:
  .BYTE  "I am fine.",0

;---------------------
ClearScreen:

  X = #0
CS_1:
  HW_TextDisplay[X] = A
  ++X
  GO(!ZERO) CS_1
  RETURN

;---------------------
IsValidHexKey:

  A to #'0'
  GO(<) NoGood
  A to #'9'+1
  GO(<) Good

  A to #'A'
  GO(<) NoGood
  A to #'F'+1
  GO(<) Good

  A to #'a'
  GO(<) NoGood
  A to #'f'+1
  GO(<) GoodLower

NoGood:
  A = #0
Good:
  RETURN

GoodLower:
  A = A - #('a'-'A')
  RETURN

;---------------------
ASCIItoBinary:

  A to #'A'
  GO(<) ItIsNumeric

  A = A - #('A'-10+'0')

ItIsNumeric:

  A = A -#'0'

  RETURN

;---------------------
0xFFFA:                
  .WORD  0x0000        ; NMI vector (not used)
  .WORD  main          ; Reset vector (start of program)
  .WORD  0x0000        ; IRQ vector
