                                           ;  The 8080 interrupt system is based on RST 0-8 that execute 8-byte boundary addresses
                                           ;  at the very top of the memory map. In this case, the top of memory is ROM. So we'll
                                           ;  re-vector these to RAM. RST 1 will jump to 2000 and RST 2 will jump to 2008. 
                                           
                                           ;  Interrupts will be disabled at start-up.
                                           
                                           ;  The SpaceInvaders hardware will generate RST 1 and RST 2 only.
                                           
                 .processor Z80              ; OLine=9
                                           ;  build-command java preprocessor.Blend RAMLoader.asm R2.asm
                                           ;  build-command tasm -b -t8580 R2.asm R2.bin
                                           ;  build-command java EpromTool -pad R2.bin 2048 255 invaders.h
                                           ;  build-command jar -cf \mame\roms\invaders.zip invaders.h invaders.g invaders.f invaders.e
                                           
                                           ; <EditorTab name="Port 1 Map">
                                           
                                           ; Port 1
                                           ;    bit 0 = CREDIT (Normally 1, 0 if deposit)     
                                           ;    bit 1 = 2P start (1 if pressed)   
                                           ;    bit 2 = 1P start (1 if pressed)   [RAMLoader DataBit 1]
                                           ;    bit 3 = Always 1
                                           ;    bit 4 = 1P shot (1 if pressed)    [RAMLoader CLOCK]
                                           ;    bit 5 = 1P left (1 if pressed)    [RAMLoader DataBit 0]
                                           ;    bit 6 = 1P right (1 if pressed)
                                           ;    bit 7 = Not connected
                                           
                                           ; </EditorTab>
                                           
                                           ; <EditorTab name="RST0 Startup">
                                           
                 .org     0                ; OLine=31
                                           ;  RST 0 (RESET/POWER-ON)
                 nop                       ; OLine=33
                 nop                       ; OLine=34
                 nop                       ; OLine=35
                 jp       START            ; OLine=36
                 nop                       ; OLine=37
                 nop                       ; OLine=38
                                           
                                           ; </EditorTab>
                                           
                                           ; <EditorTab name="RST1">
                                           
                                           ;  RST 1
                 jp       $2000            ; OLine=45
                 nop                       ; OLine=46
                 nop                       ; OLine=47
                 nop                       ; OLine=48
                 nop                       ; OLine=49
                 nop                       ; OLine=50
                                           
                                           ; </EditorTab>
                                           
                                           ; <EditorTab name="RST2">
                                           
                                           ;  RST 2
                 jp       $2008            ; OLine=57
                 nop                       ; OLine=58
                 nop                       ; OLine=59
                 nop                       ; OLine=60
                 nop                       ; OLine=61
                 nop                       ; OLine=62
                                           
                                           ; </EditorTab>
                                           
                                           ; <EditorTab name="START">
                                           
                 TMP_ADDRESS .equ   $2010     ; OLine=68
                 TMP_COUNT .equ   $2012     ; OLine=69
                                           
                                           ; HELLO_WORLD() {
                                           
                                           ;       ld     HL,$2400
                                           ;       ld     (TMP_ADDRESS),HL
                                           ;       ld     HL,$C00
                                           ;       ld     (TMP_COUNT),HL
                                           
                                           ;       ld     c,0
                                           
                                           ; Loop11:
                                           
                                           ;       ld    HL,(TMP_ADDRESS)  ; Get the current address
                                           ;       ld    (HL),c            ; Store the value there
                                           ;       inc   c
                                           ;       inc   HL                ; Next address
                                           ;       ld    (TMP_ADDRESS),HL  ; Update the current address      
                                           
                                           ;       ld    HL,(TMP_COUNT)    ; Get the count
                                           ;       dec   HL                ; Decrement the count     
                                           ;       ld    (TMP_COUNT),HL    ; Update the count
                                           ;       ld    a,h
                                           ;       cp    $0
                                           ;       jp    NZ,Loop11          ; Do all bytes
                                           ;       ld    a,l
                                           ;       cp    $0
                                           ;       jp    NZ,Loop11
                                           
                                           ; AA:   ld    HL,$2550
                                           ;       inc   (HL) 
                                           ;       jp    AA
                                           
                                           ; }
                                           
START:                                     ;  --SubroutineContextBegins--
                                           
                 di                        ; OLine=106  Disable interrupts (just in case)  
                 out      (6),a            ; OLine=107  Feed the watchdog
                                           
                 ld       a,0              ; OLine=109  Turn off ...
                 out      (3),a            ; OLine=110  ... all ...
                 out      (5),a            ; OLine=111  ... sound
                 ld       sp,$2400         ; OLine=112  Stack at the bottom of user-RAM  
                                           
                                           ;  Read word (start address)
                 JSR      ReadWord         ; OLine=115
                 ld       a,40             ; OLine=116
                 out      (3),a            ; OLine=117
                 ld       (TMP_ADDRESS),HL ; OLine=118  Store the address for the fill
                 ld       ($2554),HL       ; OLine=119  Echo to screen
                 PUSH     HL               ; OLine=120  Hold address to jump to later
                                           
                                           ;  Read word (length)
                 JSR      ReadWord         ; OLine=123
                 ld       a,36             ; OLine=124
                 out      (3),a            ; OLine=125
                 ld       (TMP_COUNT),HL   ; OLine=126  Hold number of bytes
                 ld       ($2556),HL       ; OLine=127  Echo to screen
                                           
Loop1:                                     ; OLine=129
                                           
                 JSR      ReadByte         ; OLine=131  Get next byte
                 ld       b,l              ; OLine=132  Hold it somewhere besides HL
                 ld       HL,(TMP_ADDRESS) ; OLine=133  Get the current address
                 ld       (HL),b           ; OLine=134  Store the value there
                 inc      HL               ; OLine=135  Next address
                 ld       (TMP_ADDRESS),HL ; OLine=136  Update the current address      
                                           
                 ld       HL,(TMP_COUNT)   ; OLine=138  Get the count
                 dec      HL               ; OLine=139  Decrement the count  
                 ld       ($2556),HL       ; OLine=140  Echo to screen   
                 ld       (TMP_COUNT),HL   ; OLine=141  Update the count
                 ld       a,h              ; OLine=142
                 cp       $0               ; OLine=143
                 jp       NZ,Loop1         ; OLine=144  Do all bytes
                 ld       a,l              ; OLine=145
                 cp       $0               ; OLine=146
                 jp       NZ,Loop1         ; OLine=147
                                           
                                           ;  Execute start
                 POP      HL               ; OLine=150  Get the start address
                 ld       a,40             ; OLine=151
                 out      (3),a            ; OLine=152
                 out      (6),a            ; OLine=153  Feed the watchdog one last time
                 JP       (HL)             ; OLine=154  Jump to address ... no return
                                           
                 RTS                       ;  --SubroutineContextEnds--
                                           ; </EditorTab>
                                           
                                           
                                           ; <EditorTab name="ReadByte">
                                           
ReadByte:                                  ;  --SubroutineContextBegins--
                                           
                 push     af               ; OLine=164  We will mangle this
                 push     bc               ; OLine=165  We will mangle this
                                           
                 ld       L,0              ; OLine=167  Accumulated byte
                 ld       c,2              ; OLine=168  2 sets of 2 4 bits
                                           
rb_1:                                      ; OLine=170
                 out      (6),a            ; OLine=171  Feed the watchdog
                 in       a,(1)            ; OLine=172  Read the input port   
                 ld       ($2550),a        ; OLine=173  Screen echo of port value
                 ld       b,a              ; OLine=174  Hold it
                 and      $10              ; OLine=175  Get the clock value
                 jp       Z,rb_1           ; OLine=176  Clock pin still 0 ... keep waiting
                                           
                 ld       a,l              ; OLine=178  Shift accumulation ...
                 rla                       ; OLine=179  ... left 2 bits ...
                 rla                       ; OLine=180  ... to make room for ...
                 ld       l,a              ; OLine=181  ... reading next 2 bits
                                           
                 ld       a,b              ; OLine=183  The original value back
                 rrca                      ; OLine=184  Move D2 of input (1P start = D1) ...
                 rrca                      ; OLine=185  .... into ...
                 rrca                      ; OLine=186  ... CF flag
                 jp       NC,rb_A          ; OLine=187  If the CF is 0, skip adding 2
                 inc      l                ; OLine=188  CF must be 1 ...
                 inc      l                ; OLine=189  ... set bit 1
rb_A:                                      ; OLine=190
                 rrca                      ; OLine=191  Move D5 of input (1P left = D0) ...
                 rrca                      ; OLine=192  ... into ...
                 rrca                      ; OLine=193  ... CF flag
                 jp       NC,rb_2          ; OLine=194  If the CF is 0, skip adding 1
                 inc      l                ; OLine=195  CF must be 1 ... set bit 0
rb_2:                                      ; OLine=196
                 out      (6),a            ; OLine=197  Feed the watchdog
                 in       a,(1)            ; OLine=198  Read the input port
                 ld       ($2550),a        ; OLine=199  Screen echo of port value
                 ld       b,a              ; OLine=200  Hold it
                 and      $10              ; OLine=201  Get the clock value
                 jp       nz,rb_2          ; OLine=202  Clock pin still 1 ... keep waiting
                                           
                 ld       a,l              ; OLine=204  Shift accumulation ...
                 rla                       ; OLine=205  ... left 2 bits ...
                 rla                       ; OLine=206  ... to make room for ...
                 ld       l,a              ; OLine=207  ... reading next 2 bits
                                           
                 ld       a,b              ; OLine=209  The original value back
                 rrca                      ; OLine=210  Move D2 of input (1P start = D1) ...
                 rrca                      ; OLine=211  .... into ...
                 rrca                      ; OLine=212  ... CF flag
                 jp       NC,rb_A2         ; OLine=213  If the CF is 0, skip adding 2
                 inc      l                ; OLine=214  CF must be 1 ...
                 inc      l                ; OLine=215  ... set bit 1
rb_A2:                                     ; OLine=216
                 rrca                      ; OLine=217  Move D5 of input (1P left = D0) ...
                 rrca                      ; OLine=218  ... into ...
                 rrca                      ; OLine=219  ... CF flag
                 jp       NC,rb_B2         ; OLine=220  If the CF is 0, skip adding 1
                 inc      l                ; OLine=221  CF must be 1 ... set bit 0
rb_B2:                                     ; OLine=222
                                           
                 dec      c                ; OLine=224  Done both sets of 4 bits?
                 jp       nz,rb_1          ; OLine=225  No ... back for more
                                           
                 ld       a,l              ; OLine=227  Screen echo ...
                 ld       ($2551),a        ; OLine=228  ... the read byte
                                           
                 POP      bc               ; OLine=230  Restore ...
                 POP      af               ; OLine=231  ... these
                                           
                 RTS                       ;  --SubroutineContextEnds--
                                           
ReadWord:                                  ;  --SubroutineContextBegins--
                                           
                 JSR      ReadByte         ; OLine=237  Get MSB to L
                 ld       h,l              ; OLine=238  Move it up to H
                 JSR      ReadByte         ; OLine=239  Get LSB to L
                                           
                 RTS                       ;  --SubroutineContextEnds--
                                           
                                           ; </EditorTab>
                                           
                 .end                      ; OLine=245
