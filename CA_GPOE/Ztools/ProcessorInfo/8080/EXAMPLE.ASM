; To become familiar with the segment feature you
; should assemble this file with and without the
; single object module swicth enabled.
;
;   a85  -o example         ;three object module files
                            ;     code.seg
                            ;     memory.seg
                            ;     rom2.seg
;
;   a85  example            ;one object module file example.obj



         jmp loop
         .org  h'20         ;start assembly at location 20 hex.
         .segment .memory   ;declare a new segmemt for ram memory
                            ;allocation
         .memory            ;select segment .memory as active(locaton counter)
                            ;for the .code segment(created by the assembler) is
                            ;saved for when we switch back.
         .org  h'8000       ;assume ram space starts at address h'8000
v1:      .rs 2               ;reserve storage for a program variable
array:   .rs 100*2           ;reserve storage for an array of 100 words
         .eject             ;lets start on a fresh page of paper.
         .code              ;switch back to code segment
                            ; origin is where we left off.
loop:    mvi a,h'22
         lxi sp,h'2000
         sphl
         .equ cr,13         ;equated identifiers are constant.
         .equ tab,9
         .set temp,23       ;set identifiers may be re-set.
         .set temp,24
         .set temp,25
         .db  1,2,3,4,5,'p'
         .db  6,7,"this is a test\r\n\0"
         .dw  1,h'1234
         .drw 1,h'1234
         mvi b,loop2 >> 8   ;isolate high byte of address
         mvi b,loop2 & h'ff ;isolate low half of address
         .page              ;start on a new 256 byte boundary.
loop2:   jmp loop
         .segment .rom2
         .rom2
         .org h'4000
         .db  "this is possibly a second rom programmed seperately."
         .code
         .end loop          ;end of assembly, specifying start address.

