.PROCESSOR 6502

0xF800:
main:

  A = #'0'
  CALL ASCIItoBinary

  A = #'F'
  CALL ASCIItoBinary

  GOTO main

;---------------------
ASCIItoBinary:

  A to  #'A'
  GO(<)  ItIsNumeric

  A = A - #55

ItIsNumeric:

  A = A - #'0'

  RTS

;---------------------
0xFFFA:                
  .WORD  0x0000        ; NMI vector (not used)
  .WORD  main          ; Reset vector (start of program)
  .WORD  0x0000        ; IRQ vector
