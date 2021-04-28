.PROCESSOR 6502

0x0000:
  
  A to #'A'
  GO(<) ItIsNumeric

  A=A-#55
  GOTO Done

ItIsNumeric:
  A=A-#48

Done:
