; "Hello World" program for Atari 2600
.PROCESSOR 6502

; Hardware registers
.EQU  VSYNC  = 0x0000
.EQU  VBLANK = 0x0001
.EQU  WSYNC  = 0x0002
.EQU  COLUPF = 0x0008
.EQU  COLUBK = 0x0009
.EQU  PF0    = 0x000D
.EQU  PF1    = 0x000E
.EQU  PF2    = 0x000F
.EQU  INTIM  = 0x0284
.EQU  TIM64T = 0x0296

0xF800:
  SEI             ; Turn off interrupts
  CLD             ; Clear the "decimal" flag
  LDX  #0xFF      ; Start stack ...
  TXS             ; ... at end of RAM		
  LDA  #0xC0      ; Background color ...
  STA  COLUBK     ; ... greenish		
  LDA  #0x40      ; Playfield ...
  STA  COLUPF     ; ... redish	
        
;============= BETWEEN FRAMES ===================
;  (start here at the END of every frame)
;
NewFrame: 
  LDA   #0x02     ; D1 bit ON
  STA   WSYNC     ; Wait for the end of the current line		
  STA   VBLANK    ; Start the vertical blanking
  STA   WSYNC     ; Hold ...
  STA   WSYNC     ; ... for three ...
  STA   WSYNC     ; ... scanlines.
  STA   VSYNC     ; Trigger the vertical sync signal
  STA   WSYNC     ; Hold the vsync signal for ...
  STA   WSYNC     ; ... three ...
  STA   WSYNC     ; ... scanlines
  LDA   #0x00     ; D1 bit OFF                
  STA   VSYNC     ; Release the vertical sync signal
  LDA   #43       ; Set timer to 43*64 = 2752 machine ...
  STA   TIM64T    ; ... cycles 2752/(228/3) = 36 scanlines

; Process game-logic here.

WaitTimer:
  LDA   INTIM     ; Wait for the electron gun ...
  BNE   WaitTimer ; ... to move to upper left corner  
  STA   WSYNC     ; 37th scanline
  LDA   #0x00     ; Turn the ...
  STA   VBLANK    ; ... electron beam back on			
	
;============= VISIBLE PART OF FRAME ==============
        
  LDX   #220      ; 220 scan lines (~213 visible on my TV)
  LDA   #1        ; Start value for playfield
DrawRow:
  STA   PF0       ; Draw the playfield pattern      
  STA   PF1
  STA   PF2          
  STA   WSYNC     ; Wait for the end of the line
  ADC   #1        ; Bump the playfield pattern
  DEX             ; Count ...
  BNE   DrawRow   ; ... 220 lines

  JMP   NewFrame  ; Next TV frame

;=== 6502 Hardware vectors at the end of memory ===

0xFFFA:
  .WORD 0x0000    ; NMI vector (not used)
  .WORD 0xF800    ; Reset vector (top of program)
  .WORD 0x0000    ; IRQ vector (not used)
