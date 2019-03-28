; The 8080 interrupt system is based on RST 0-8 that execute 8-byte boundary addresses
; at the very top of the memory map. In this case, the top of memory is ROM. So we'll
; re-vector these to RAM. RST 1 will jump to 2000 and RST 2 will jump to 2008. 

; Interrupts will be disabled at start-up.

; The SpaceInvaders hardware will generate RST 1 and RST 2 only.

 .processor Z80
; build-command java preprocessor.Blend RAMLoader.asm R2.asm
; build-command tasm -b -t8580 R2.asm R2.bin
; build-command java EpromTool -pad R2.bin 2048 255 invaders.h
; build-command jar -cf \mame\roms\invaders.zip invaders.h invaders.g invaders.f invaders.e

;<EditorTab name="Port 1 Map">

;Port 1
;   bit 0 = CREDIT (Normally 1, 0 if deposit)     
;   bit 1 = 2P start (1 if pressed)   
;   bit 2 = 1P start (1 if pressed)   [RAMLoader DataBit 1]
;   bit 3 = Always 1
;   bit 4 = 1P shot (1 if pressed)    [RAMLoader CLOCK]
;   bit 5 = 1P left (1 if pressed)    [RAMLoader DataBit 0]
;   bit 6 = 1P right (1 if pressed)
;   bit 7 = Not connected

;</EditorTab>

;<EditorTab name="RST0 Startup">

  .org 0
; RST 0 (RESET/POWER-ON)
  nop
  nop
  nop
  jp      START
  nop
  nop

;</EditorTab>

;<EditorTab name="RST1">

; RST 1
  jp   0x2000  
  nop
  nop
  nop
  nop 
  nop

;</EditorTab>
 
;<EditorTab name="RST2">

; RST 2
  jp   0x2008 
  nop
  nop
  nop
  nop
  nop

;</EditorTab>

;<EditorTab name="START">

.equ   TMP_ADDRESS   = 0x2010
.equ   TMP_COUNT     = 0x2012

;HELLO_WORLD() {

;      ld     HL,0x2400
;      ld     (TMP_ADDRESS),HL
;      ld     HL,0xC00
;      ld     (TMP_COUNT),HL

;      ld     c,0
      
;Loop11:
     
;      ld    HL,(TMP_ADDRESS)  ; Get the current address
;      ld    (HL),c            ; Store the value there
;      inc   c
;      inc   HL                ; Next address
;      ld    (TMP_ADDRESS),HL  ; Update the current address      

;      ld    HL,(TMP_COUNT)    ; Get the count
;      dec   HL                ; Decrement the count     
;      ld    (TMP_COUNT),HL    ; Update the count
;      ld    a,h
;      cp    0x0
;      jp    NZ,Loop11          ; Do all bytes
;      ld    a,l
;      cp    0x0
;      jp    NZ,Loop11

;AA:   ld    HL,0x2550
;      inc   (HL) 
;      jp    AA

;}

START() {

      di               ; Disable interrupts (just in case)  
      out   (6),a      ; Feed the watchdog

      ld    a,0        ; Turn off ...
      out   (3),a      ; ... all ...
      out   (5),a      ; ... sound
      ld    sp,0x2400   ; Stack at the bottom of user-RAM  

; Read word (start address)
      ReadWord()
      ld    a,40
      out   (3),a
      ld    (TMP_ADDRESS),HL ; Store the address for the fill
      ld    (0x2554),HL       ; Echo to screen
      PUSH  HL               ; Hold address to jump to later
   
  ; Read word (length)
      ReadWord()
      ld    a,36
      out   (3),a
      ld    (TMP_COUNT),HL     ; Hold number of bytes
      ld    (0x2556),HL         ; Echo to screen
      
Loop1:

      ReadByte()              ; Get next byte
      ld    b,l               ; Hold it somewhere besides HL
      ld    HL,(TMP_ADDRESS)  ; Get the current address
      ld    (HL),b            ; Store the value there
      inc   HL                ; Next address
      ld    (TMP_ADDRESS),HL  ; Update the current address      

      ld    HL,(TMP_COUNT)    ; Get the count
      dec   HL                ; Decrement the count  
      ld    (0x2556),HL         ; Echo to screen   
      ld    (TMP_COUNT),HL    ; Update the count
      ld    a,h
      cp    0x0
      jp    NZ,Loop1          ; Do all bytes
      ld    a,l
      cp    0x0
      jp    NZ,Loop1

  ; Execute start
      POP   HL                ; Get the start address
      ld    a,40
      out   (3),a
      out   (6),a             ; Feed the watchdog one last time
      JP    (HL)              ; Jump to address ... no return

}
;</EditorTab>


;<EditorTab name="ReadByte">

ReadByte() { ; L<= read byte
 
  push  af        ; We will mangle this
  push  bc        ; We will mangle this

  ld    L,0       ; Accumulated byte
  ld    c,2       ; 2 sets of 2 4 bits

rb_1:
  out    (6),a    ; Feed the watchdog
  in     a,(1)    ; Read the input port   
  ld    (0x2550),a ; Screen echo of port value
  ld     b,a      ; Hold it
  and    0x10      ; Get the clock value
  jp     Z,rb_1   ; Clock pin still 0 ... keep waiting
 
  ld     a,l      ; Shift accumulation ...
  rla             ; ... left 2 bits ...
  rla             ; ... to make room for ...
  ld     l,a      ; ... reading next 2 bits

  ld     a,b      ; The original value back
  rrca            ; Move D2 of input (1P start = D1) ...
  rrca            ; .... into ...
  rrca            ; ... CF flag
  jp     NC,rb_A  ; If the CF is 0, skip adding 2
  inc    l        ; CF must be 1 ...
  inc    l        ; ... set bit 1
rb_A:
  rrca            ; Move D5 of input (1P left = D0) ...
  rrca            ; ... into ...
  rrca            ; ... CF flag
  jp    NC,rb_2   ; If the CF is 0, skip adding 1
  inc    l        ; CF must be 1 ... set bit 0
rb_2:
  out    (6),a    ; Feed the watchdog
  in     a,(1)    ; Read the input port
  ld    (0x2550),a ; Screen echo of port value
  ld     b,a      ; Hold it
  and    0x10      ; Get the clock value
  jp     nz,rb_2  ; Clock pin still 1 ... keep waiting

  ld     a,l      ; Shift accumulation ...
  rla             ; ... left 2 bits ...
  rla             ; ... to make room for ...
  ld     l,a      ; ... reading next 2 bits

  ld     a,b      ; The original value back
  rrca            ; Move D2 of input (1P start = D1) ...
  rrca            ; .... into ...
  rrca            ; ... CF flag
  jp     NC,rb_A2 ; If the CF is 0, skip adding 2
  inc    l        ; CF must be 1 ...
  inc    l        ; ... set bit 1
rb_A2:
  rrca            ; Move D5 of input (1P left = D0) ...
  rrca            ; ... into ...
  rrca            ; ... CF flag
  jp    NC,rb_B2  ; If the CF is 0, skip adding 1
  inc    l        ; CF must be 1 ... set bit 0
rb_B2:

  dec   c         ; Done both sets of 4 bits?
  jp    nz,rb_1   ; No ... back for more

  ld    a,l       ; Screen echo ...
  ld    (0x2551),a ; ... the read byte

  POP   bc        ; Restore ...
  POP   af        ; ... these
 
}

ReadWord() { ; HL <= read word

   ReadByte()    ; Get MSB to L
   ld    h,l     ; Move it up to H
   ReadByte()    ; Get LSB to L

}

;</EditorTab>
