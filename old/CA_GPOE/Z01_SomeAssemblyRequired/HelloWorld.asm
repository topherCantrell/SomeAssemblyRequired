.PROCESSOR 6502

.EQU ScreenMemory = 0x2000

.EQU OurStart = ScreenMemory + 32*3 + 10

0x0000:

A = #0x48       ; ASCII code for 'H'
0x206A = A      ; Memory location

A = #'e'        ; Let the assembler convert
OurStart+1 = A  ; Let the assembler do the math

A = #'l'
OurStart+2 = A

A = #'l'
OurStart+3 = A

A = #'o'
OurStart+4 = A