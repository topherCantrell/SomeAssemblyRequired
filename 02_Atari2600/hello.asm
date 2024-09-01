; "Hello World" program for Atari 2600

._CPU = 6502

; Hardware registers used in this code
.VSYNC  = 0x0000
.VBLANK = 0x0001
.WSYNC  = 0x0002
.COLUPF = 0x0008
.COLUBK = 0x0009
.PF0    = 0x000D
.PF1    = 0x000E
.PF2    = 0x000F
;
.RIOT_A_DATA   = 0x0280
.RIOT_A_DDR    = 0x0281
.RIOT_B_DATA   = 0x0282
.RIOT_B_DDR    = 0x0283
;
.INTIM  = 0x0284
.TIM64T = 0x0296

0xF000:  ; Highest nibble could be 1,3,5,7,9,B,D,F
reset:
  SEI              ; Turn off interrupts
  CLD              ; Clear the "decimal" flag
  LDX  #0xFF       ; Start stack ...
  TXS              ; ... at end of RAM (01FF)
  LDA  #0xC0       ; Background color ...
  STA  COLUBK      ; ... greenish
  LDA  #0x40       ; Playfield ...
  STA  COLUPF      ; ... redish

  LDA  #0xFF       ; Joystick ports are now ...
  STA  RIOT_A_DDR  ; ... OUTPUTS! WARNING!

;============= BETWEEN FRAMES ===================
;  (start here at the END of every frame)
;
NewFrame:
  LDA   #0x02     ; D1 bit ON (vsync and vblank bits)
  STA   WSYNC     ; Wait for the end of the current line
  STA   VBLANK    ; Start the vertical blanking
  STA   WSYNC     ; Hold ...
  STA   WSYNC     ; ... for three ...
  STA   WSYNC     ; ... scanlines.
  STA   VSYNC     ; Trigger the vertical sync signal
  STA   WSYNC     ; Hold the vsync signal for ...
  STA   WSYNC     ; ... three ...
  STA   WSYNC     ; ... scanlines
  LDA   #0x00     ; D1 bit OFF (vsync and vblank bits)
  STA   VSYNC     ; Release the vertical sync signal
  LDA   #43       ; Set timer to 43*64 = 2752 machine ...
  STA   TIM64T    ; ... cycles 2752/(228/3) = 36 scanlines

  LDA   RIOT_B_DATA  ; Copy switches ...
  STA   RIOT_A_DATA  ; ... to output

; Lots and lots of time here for game logic.

WaitTimer:
  LDA   INTIM     ; Wait for the visible ...
  BNE   WaitTimer ; ... part of the screen
  STA   WSYNC     ; 37th scanline
  LDA   #0x00     ; Release the ...
  STA   VBLANK    ; ... blanking

;============= VISIBLE PART OF FRAME ==============

  LDA   RIOT_B_DATA  ; Copy switches ...
  STA   RIOT_A_DATA  ; ... to output

  LDX   #92       ; 220 total scan lines (~213 visible on my TV)
DrawRow1:
  STA   PF0       ; Draw the ...
  STA   PF1       ; ... playfield ...
  STA   PF2       ; ... pattern
  STA   WSYNC     ; Wait for the end of the line
  DEX             ; Count ...
  BNE   DrawRow1  ; ... 220 lines

  LDX   #128      ; 220 scan lines (~213 visible on my TV)
  LDA   #1        ; Start value for playfield
DrawRow2:
  STA   PF0       ; Draw the ...
  STA   PF1       ; ... playfield ...
  STA   PF2       ; ... pattern
  STA   WSYNC     ; Wait for the end of the line
  CLC             ; Clear the carry for next add
  ADC   #1        ; Bump the playfield pattern
  DEX             ; Count ...
  BNE   DrawRow2  ; ... 220 lines

  JMP   NewFrame  ; Next TV frame

;=== 6502 Hardware vectors at the end of memory ===

0xFFFA:
    .word  reset        ; NMI vector
    .word  reset        ; RESET vector
    .word  reset        ; IRQ vector
