;
; Space Invaders
; (8080 code as if Z80)
;

I/O ports:
read:
01        IN0
02        IN1
03        bit shift register read
write:
02        shift amount
03        sound
04        shift data
05        sound
06        ?
Space Invaders
--------------
Input:
Port 1
   bit 0 = CREDIT (0 if deposit)
   bit 1 = 2P start(1 if pressed)
   bit 2 = 1P start(1 if pressed)
   bit 3 = 0 if TILT
   bit 4 = shot(1 if pressed)
   bit 5 = left(1 if pressed)
   bit 6 = right(1 if pressed)
   bit 7 = Always 1
Port 2
   bit 0 = 00 = 3 ships  10 = 5 ships
   bit 1 = 01 = 4 ships  11 = 6 ships
   bit 2 = Always 0 (1 if TILT)
   bit 3 = 0 = extra ship at 1500, 1 = extra ship at 1000
   bit 4 = shot player 2 (1 if pressed)
   bit 5 = left player 2 (1 if pressed)
   bit 6 = right player 2 (1 if pressed)
   bit 7 = Coin info if 0, last screen

Port 3:
  bit 0=UFO (repeats)        0.raw
  bit 1=Shot                 1.raw
  bit 2=Base hit             2.raw
  bit 3=Invader hit          3.raw
Port 5:
  bit 0=Fleet movement 1     4.raw
  bit 1=Fleet movement 2     5.raw
  bit 2=Fleet movement 3     6.raw
  bit 3=Fleet movement 4     7.raw
  bit 4=UFO 2                8.raw

;=============================================================
0000  00        nop     	; Interesting. Why waste the ...
0001  00        nop     	; ... CPU cycles with NOPs ? ...
0002  00        nop     	; ... Slow hardware?
0003  c3d418    jp      #18d4	; Continue
0006  00        nop     
0007  00        nop     

;=============================================================
0008  f5        push    af	; Save ...
0009  c5        push    bc	; ... everything
000a  d5        push    de	; (Mirror of 0010)
000b  e5        push    hl	; '
000c  c38c00    jp      #008c	; Continue
000f  00        nop     

;=============================================================
; Interrupt service
;
0010  f5        push    af		; Save ...
0011  c5        push    bc		; ... everything
0012  d5        push    de		; '
0013  e5        push    hl		; '
0014  3e80      ld      a,#80
0016  327220    ld      (#2072),a
0019  21c020    ld      hl,#20c0	; General counter
001c  35        dec     (hl)		; Decrement
001d  cdcd17    call    #17cd		; Check and handle TILT
0020  db01      in      a,(#01)	; Read port 1
0022  0f        rrca    		; Bit0 into carry
0023  da6700    jp      c,#0067	; Coin deposited ... handle it
; This seems strange ... unless the 20EA is being set somewhere else
; like if you can win a free game. I can't find it if it is!
0026  3aea20    ld      a,(#20ea)	; Credit need ...
0029  a7        and     a		; ... registering?
002a  ca4200    jp      z,#0042	; No
;
; Handle bumping credit count
002d  3aeb20    ld      a,(#20eb)	; Number of credits
0030  fe99      cp      #99		; 99 credits already?
0032  ca3e00    jp      z,#003e	; Yes ... ignore this
0035  c601      add     a,#01		; Bump number of credits
0037  27        daa     		; Make it decimal coded
0038  32eb20    ld      (#20eb),a	; New number of credits
003b  cd4719    call    #1947		; Draw credits on screen
003e  af        xor     a		; Marke credit ...
003f  32ea20    ld      (#20ea),a	; ... as handled
0042  3ae920    ld      a,(#20e9)	; Do we know about the ...
0045  a7        and     a		; ... player standing there?
0046  ca8200    jp      z,#0082	; Yes ... restore registers and out
0049  3aef20    ld      a,(#20ef)
004c  a7        and     a
004d  c26f00    jp      nz,#006f
0050  3aeb20    ld      a,(#20eb)
0053  a7        and     a
0054  c25d00    jp      nz,#005d
0057  cdbf0a    call    #0abf
005a  c38200    jp      #0082		; Restore registers and out
005d  3a9320    ld      a,(#2093)
0060  a7        and     a
0061  c28200    jp      nz,#0082	; Restore registers and out
0064  c36507    jp      #0765		; Begin the start-button wait loop
;
; Mark credit as needing registering
0067  3e01      ld      a,#01		; Mark credit ...
0069  32ea20    ld      (#20ea),a	; ... as needing registering
006c  c33f00    jp      #003f		; Go register it
;
006f  cd4017    call    #1740
0072  3a3220    ld      a,(#2032)
0075  328020    ld      (#2080),a
0078  cd0001    call    #0100
007b  cd4802    call    #0248
007e  cd1309    call    #0913
0081  00        nop     		; Why are we waiting?
;
0082  e1        pop     hl		; Restore ...
0083  d1        pop     de		; ... everything
0084  c1        pop     bc		; '
0085  f1        pop     af		; '
0086  fb        ei      		; Enable interrupts
0087  c9        ret   			; Return from interrupt

;=============================================================
; Vectored from RST 0008
0088  00        nop     
0089  00        nop     
008a  00        nop     
008b  00        nop     
008c  af        xor     a
008d  327220    ld      (#2072),a
0090  3ae920    ld      a,(#20e9)
0093  a7        and     a
0094  ca8200    jp      z,#0082	; Restore and return
0097  3aef20    ld      a,(#20ef)
009a  a7        and     a
009b  c2a500    jp      nz,#00a5
009e  3ac120    ld      a,(#20c1)
00a1  0f        rrca    
00a2  d28200    jp      nc,#0082	; Restore and return
00a5  212020    ld      hl,#2020
00a8  cd4b02    call    #024b
00ab  cd4101    call    #0141
00ae  c38200    jp      #0082		; Restore and return
00b1  cd8608    call    #0886
00b4  e5        push    hl
00b5  7e        ld      a,(hl)
00b6  23        inc     hl
00b7  66        ld      h,(hl)
00b8  6f        ld      l,a
00b9  220920    ld      (#2009),hl
00bc  220b20    ld      (#200b),hl
00bf  e1        pop     hl
00c0  2b        dec     hl
00c1  7e        ld      a,(hl)
00c2  fe03      cp      #03
00c4  c2c800    jp      nz,#00c8
00c7  3d        dec     a
00c8  320820    ld      (#2008),a
00cb  fefe      cp      #fe
00cd  3e00      ld      a,#00
00cf  c2d300    jp      nz,#00d3
00d2  3c        inc     a
00d3  320d20    ld      (#200d),a
00d6  c9        ret     

;=============================================================
00d7  3e02      ld      a,#02
00d9  32fb21    ld      (#21fb),a
00dc  32fb22    ld      (#22fb),a
00df  c3e408    jp      #08e4

; 00e2 - 00ff 00's

;=============================================================
;
0100  210220    ld      hl,#2002
0103  7e        ld      a,(hl)
0104  a7        and     a
0105  c23815    jp      nz,#1538
0108  e5        push    hl
0109  3a0620    ld      a,(#2006)
010c  6f        ld      l,a
010d  3a6720    ld      a,(#2067)
0110  67        ld      h,a
0111  7e        ld      a,(hl)
0112  a7        and     a
0113  e1        pop     hl
0114  ca3601    jp      z,#0136	; Skip drawing sprite
0117  23        inc     hl		; Bump descriptor
0118  23        inc     hl		; Bump descriptor
0119  7e        ld      a,(hl)	; Get type (*2)
011a  23        inc     hl		; Bump descriptor
011b  46        ld      b,(hl)	; Get position indicator
011c  e6fe      and     #fe		; Must be pre-shifted (mask lower bit)
011e  07        rlca  			; *2  
011f  07        rlca    		; *4
0120  07        rlca    		; *8
0121  5f        ld      e,a		; Sprite's LSB
0122  1600      ld      d,#00		; Clear base MSB
0124  21001c    ld      hl,#1c00	; Position 0 alien sprites
0127  19        add     hl,de		; Offset to sprite
0128  eb        ex      de,hl		; To DE
0129  78        ld      a,b		; Position indicator
012a  a7        and     a		; Is it position 0?
012b  c43b01    call    nz,#013b	; No ... use Position 1 alien sprites
012e  2a0b20    ld      hl,(#200b)	; Pixel position
0131  0610      ld      b,#10		; 16 rows in alien sprites
0133  cdd315    call    #15d3		; Draw shifted sprite
0136  af        xor     a		; Clear ...
0137  320020    ld      (#2000),a	; ... ? Flag ?
013a  c9        ret     		; Out
;
013b  213000    ld      hl,#0030	; Offset sprites ...
013e  19        add     hl,de		; ... to position 1 sprites
013f  eb        ex      de,hl		; Back to DE
0140  c9        ret     		; Out

0141  3a6820    ld      a,(#2068)
0144  a7        and     a
0145  c8        ret     z
0146  3a0020    ld      a,(#2000)	; Check ? Flag ?
0149  a7        and     a		; Return if ...
014a  c0        ret     nz		; ... not cleared by DrawAlienSprite
014b  3a6720    ld      a,(#2067)
014e  67        ld      h,a
014f  3a0620    ld      a,(#2006)
0152  1602      ld      d,#02
0154  3c        inc     a
0155  fe37      cp      #37
0157  cca101    call    z,#01a1
015a  6f        ld      l,a
015b  46        ld      b,(hl)
015c  05        dec     b
015d  c25401    jp      nz,#0154
0160  320620    ld      (#2006),a
0163  cd7a01    call    #017a
0166  61        ld      h,c
0167  220b20    ld      (#200b),hl
016a  7d        ld      a,l
016b  fe28      cp      #28
016d  da7119    jp      c,#1971
0170  7a        ld      a,d
0171  320420    ld      (#2004),a
0174  3e01      ld      a,#01		; Set ...
0176  320020    ld      (#2000),a	; ... ? Flag ?
0179  c9        ret     

017a  1600      ld      d,#00
017c  7d        ld      a,l
017d  210920    ld      hl,#2009
0180  46        ld      b,(hl)
0181  23        inc     hl
0182  4e        ld      c,(hl)
0183  fe0b      cp      #0b
0185  fa9401    jp      m,#0194
0188  de0b      sbc     a,#0b
018a  5f        ld      e,a
018b  78        ld      a,b
018c  c610      add     a,#10
018e  47        ld      b,a
018f  7b        ld      a,e
0190  14        inc     d
0191  c38301    jp      #0183
0194  68        ld      l,b
0195  a7        and     a
0196  c8        ret     z
0197  5f        ld      e,a
0198  79        ld      a,c
0199  c610      add     a,#10
019b  4f        ld      c,a
019c  7b        ld      a,e
019d  3d        dec     a
019e  c39501    jp      #0195
01a1  15        dec     d
01a2  cacd01    jp      z,#01cd
01a5  210620    ld      hl,#2006
01a8  3600      ld      (hl),#00
01aa  23        inc     hl
01ab  4e        ld      c,(hl)
01ac  3600      ld      (hl),#00
01ae  cdd901    call    #01d9
01b1  210520    ld      hl,#2005
01b4  7e        ld      a,(hl)
01b5  3c        inc     a
01b6  e601      and     #01
01b8  77        ld      (hl),a
01b9  af        xor     a
01ba  216720    ld      hl,#2067
01bd  66        ld      h,(hl)
01be  c9        ret     
01bf  00        nop     
01c0  210021    ld      hl,#2100
01c3  0637      ld      b,#37
01c5  3601      ld      (hl),#01
01c7  23        inc     hl
01c8  05        dec     b
01c9  c2c501    jp      nz,#01c5
01cc  c9        ret     
01cd  e1        pop     hl
01ce  c9        ret     
01cf  3e01      ld      a,#01
01d1  06e0      ld      b,#e0
01d3  210224    ld      hl,#2402
01d6  c3cc14    jp      #14cc
01d9  23        inc     hl
01da  46        ld      b,(hl)
01db  23        inc     hl
01dc  79        ld      a,c
01dd  86        add     a,(hl)
01de  77        ld      (hl),a
01df  23        inc     hl
01e0  78        ld      a,b
01e1  86        add     a,(hl)
01e2  77        ld      (hl),a
01e3  c9        ret     

;=============================================================
; Block copy ROM mirror to initialize RAM
01e4  06c0      ld      b,#c0
;
01e6  11001b    ld      de,#1b00	; RAM mirror in ROM
01e9  210020    ld      hl,#2000	; Start of RAM
01ec  c3321a    jp      #1a32		; Copy [DE]->[HL]and return

;=============================================================
01ef  214221    ld      hl,#2142
01f2  c3f801    jp      #01f8
01f5  214222    ld      hl,#2242
01f8  0e04      ld      c,#04
01fa  11201d    ld      de,#1d20
01fd  d5        push    de
01fe  062c      ld      b,#2c
0200  cd321a    call    #1a32
0203  d1        pop     de
0204  0d        dec     c
0205  c2fd01    jp      nz,#01fd
0208  c9        ret     

0209  3e01      ld      a,#01
020b  c31b02    jp      #021b

020e  3e01      ld      a,#01
0210  c31402    jp      #0214

0213  af        xor     a
0214  114222    ld      de,#2242
0217  c31e02    jp      #021e

021a  af        xor     a
021b  114221    ld      de,#2142	; Sprites? In RAM? 
021e  328120    ld      (#2081),a
0221  010216    ld      bc,#1602	; 22 rows, 2 bytes/row
0224  210628    ld      hl,#2806	; Screen coordinates
0227  3e04      ld      a,#04
0229  f5        push    af
022a  c5        push    bc
022b  3a8120    ld      a,(#2081)
022e  a7        and     a
022f  c24202    jp      nz,#0242
0232  cd691a    call    #1a69		; OR sprite onto screen
0235  c1        pop     bc
0236  f1        pop     af
0237  3d        dec     a
0238  c8        ret     z

0239  d5        push    de
023a  11e002    ld      de,#02e0
023d  19        add     hl,de
023e  d1        pop     de
023f  c32902    jp      #0229

0242  cd7c14    call    #147c
0245  c33502    jp      #0235
0248  211020    ld      hl,#2010
024b  7e        ld      a,(hl)
024c  feff      cp      #ff
024e  c8        ret     z
024f  fefe      cp      #fe
0251  ca8102    jp      z,#0281
0254  23        inc     hl
0255  46        ld      b,(hl)
0256  4f        ld      c,a
0257  b0        or      b
0258  79        ld      a,c
0259  c27702    jp      nz,#0277
025c  23        inc     hl
025d  7e        ld      a,(hl)
025e  a7        and     a
025f  c28802    jp      nz,#0288
0262  23        inc     hl
0263  5e        ld      e,(hl)
0264  23        inc     hl
0265  56        ld      d,(hl)
0266  e5        push    hl
0267  eb        ex      de,hl
0268  e5        push    hl
0269  216f02    ld      hl,#026f
026c  e3        ex      (sp),hl
026d  d5        push    de
026e  e9        jp      (hl)
026f  e1        pop     hl
0270  110c00    ld      de,#000c
0273  19        add     hl,de
0274  c34b02    jp      #024b
0277  05        dec     b
0278  04        inc     b
0279  c27d02    jp      nz,#027d
027c  3d        dec     a
027d  05        dec     b
027e  70        ld      (hl),b
027f  2b        dec     hl
0280  77        ld      (hl),a
0281  111000    ld      de,#0010
0284  19        add     hl,de
0285  c34b02    jp      #024b
0288  35        dec     (hl)
0289  2b        dec     hl
028a  2b        dec     hl
028b  c38102    jp      #0281
028e  e1        pop     hl
028f  23        inc     hl
0290  7e        ld      a,(hl)
0291  feff      cp      #ff
0293  ca3b03    jp      z,#033b
0296  23        inc     hl
0297  35        dec     (hl)
0298  c0        ret     nz

0299  47        ld      b,a
029a  af        xor     a
029b  326820    ld      (#2068),a
029e  326920    ld      (#2069),a
02a1  3e30      ld      a,#30
02a3  326a20    ld      (#206a),a
02a6  78        ld      a,b
02a7  3605      ld      (hl),#05
02a9  23        inc     hl
02aa  35        dec     (hl)
02ab  c29b03    jp      nz,#039b	; Ship blowing up???
02ae  2a1a20    ld      hl,(#201a)
02b1  0610      ld      b,#10
02b3  cd2414    call    #1424
02b6  211020    ld      hl,#2010
02b9  11101b    ld      de,#1b10
02bc  0610      ld      b,#10
02be  cd321a    call    #1a32
02c1  0600      ld      b,#00
02c3  cddc19    call    #19dc
02c6  3a6d20    ld      a,(#206d)
02c9  a7        and     a
02ca  c0        ret     nz

02cb  3aef20    ld      a,(#20ef)
02ce  a7        and     a
02cf  c8        ret     z

02d0  310024    ld      sp,#2400
02d3  fb        ei      
02d4  cdd719    call    #19d7		
02d7  cd2e09    call    #092e
02da  a7        and     a
02db  ca6d16    jp      z,#166d
02de  cde718    call    #18e7
02e1  7e        ld      a,(hl)
02e2  a7        and     a
02e3  ca2c03    jp      z,#032c
02e6  3ace20    ld      a,(#20ce)
02e9  a7        and     a
02ea  ca2c03    jp      z,#032c
02ed  3a6720    ld      a,(#2067)
02f0  f5        push    af
02f1  0f        rrca    
02f2  da3203    jp      c,#0332
02f5  cd0e02    call    #020e
02f8  cd7808    call    #0878
02fb  73        ld      (hl),e
02fc  23        inc     hl
02fd  72        ld      (hl),d
02fe  2b        dec     hl
02ff  2b        dec     hl
0300  70        ld      (hl),b
0301  00        nop     
0302  cde401    call    #01e4
0305  f1        pop     af
0306  0f        rrca    
0307  3e21      ld      a,#21
0309  0600      ld      b,#00
030b  d21203    jp      nc,#0312
030e  0620      ld      b,#20
0310  3e22      ld      a,#22
0312  326720    ld      (#2067),a
0315  cdb60a    call    #0ab6
0318  af        xor     a
0319  321120    ld      (#2011),a
031c  78        ld      a,b
031d  d305      out     (#05),a	; Sound
031f  3c        inc     a
0320  329820    ld      (#2098),a
0323  cdd609    call    #09d6		; Clear center window
0326  cd7f1a    call    #1a7f		; Remove a ship and update indicators
0329  c3f907    jp      #07f9

032c  cd7f1a    call    #1a7f		; Remove a ship and update indicators
032f  c31708    jp      #0817
0332  cd0902    call    #0209
0335  c3f802    jp      #02f8

0338  00        nop     
0339  00        nop     
033a  00        nop     
033b  216820    ld      hl,#2068
033e  3601      ld      (hl),#01
0340  23        inc     hl
0341  7e        ld      a,(hl)
0342  a7        and     a
0343  c3b003    jp      #03b0

0346  00        nop     
0347  2b        dec     hl
0348  3601      ld      (hl),#01
;
034a  3a1b20    ld      a,(#201b)	; Current player coordinates
034d  47        ld      b,a		; Hold it
034e  3aef20    ld      a,(#20ef)	; Demo flag
0351  a7        and     a		; Demo = 0
0352  c26303    jp      nz,#0363	; Use player controls
; Demo is in control
0355  3a1d20    ld      a,(#201d)	; Get demo command
0358  0f        rrca    		; Is it right?
0359  da8103    jp      c,#0381	; Yes ... do right
035c  0f        rrca    		; Is it left?
035d  da8e03    jp      c,#038e	; Yes ... do left
0360  c36f03    jp      #036f		; Skip over movement
;Player is in control
0363  cdc017    call    #17c0		; Read active player controls
0366  07        rlca    		; Test for ...
0367  07        rlca    		; ... right button
0368  da8103    jp      c,#0381	; Yes ... handle move right
036b  07        rlca    		; Test for left button
036c  da8e03    jp      c,#038e	; Yes ... handle move left
;
036f  211820    ld      hl,#2018	; Active player descriptor
0372  cd3b1a    call    #1a3b		; Load 5 bytes
0375  cd471a    call    #1a47		; Convert to screen coordinates
0378  cd3914    call    #1439		; Display character
037b  3e00      ld      a,#00
037d  321220    ld      (#2012),a
0380  c9        ret     

;=============================================================
; Handle player moving right
0381  78        ld      a,b		; Player coordinate
0382  fed9      cp      #d9		; At right edge?
0384  ca6f03    jp      z,#036f	; Yes ... ignore this
0387  3c        inc     a		; Bump X coordinate
0388  321b20    ld      (#201b),a	; New X coordinate
038b  c36f03    jp      #036f		; Continue

;=============================================================
; Handle player moving left
038e  78        ld      a,b		; Player coordinate
038f  fe30      cp      #30		; At left edge
0391  ca6f03    jp      z,#036f	; Yes ... ignore this
0394  3d        dec     a		; Bump X coordinate
0395  321b20    ld      (#201b),a	; New X coordinate
0398  c36f03    jp      #036f		; Continue

;=============================================================
;
039b  3c        inc     a
039c  e601      and     #01
039e  321520    ld      (#2015),a
03a1  07        rlca    		; *2
03a2  07        rlca    		; *4
03a3  07        rlca    		; *8
03a4  07        rlca    		; *16
03a5  21701c    ld      hl,#1c70	; Player sprite location
03a8  85        add     a,l		; Offset sprite ...
03a9  6f        ld      l,a		; ... pointer
03aa  221820    ld      (#2018),hl	; New sprite
03ad  c36f03    jp      #036f		; Draw new sprite

03b0  c24a03    jp      nz,#034a
03b3  23        inc     hl
03b4  35        dec     (hl)
03b5  c24a03    jp      nz,#034a	; Move player's ship 
03b8  c34603    jp      #0346		; Dec HL, set to 1, and move player's ship
03bb  112a20    ld      de,#202a
03be  cd061a    call    #1a06
03c1  e1        pop     hl
03c2  d0        ret     nc

03c3  23        inc     hl
03c4  7e        ld      a,(hl)
03c5  a7        and     a
03c6  c8        ret     z

03c7  fe01      cp      #01
03c9  cafa03    jp      z,#03fa
03cc  fe02      cp      #02
03ce  ca0a04    jp      z,#040a
03d1  23        inc     hl
03d2  fe03      cp      #03
03d4  c22a04    jp      nz,#042a
03d7  35        dec     (hl)
03d8  ca3604    jp      z,#0436
03db  7e        ld      a,(hl)
03dc  fe0f      cp      #0f
03de  c0        ret     nz

03df  e5        push    hl
03e0  cd3004    call    #0430
03e3  cd5214    call    #1452
03e6  e1        pop     hl
03e7  23        inc     hl
03e8  34        inc     (hl)
03e9  23        inc     hl
03ea  23        inc     hl
03eb  35        dec     (hl)
03ec  35        dec     (hl)
03ed  23        inc     hl
03ee  35        dec     (hl)
03ef  35        dec     (hl)
03f0  35        dec     (hl)
03f1  23        inc     hl
03f2  3608      ld      (hl),#08
03f4  cd3004    call    #0430
03f7  c30014    jp      #1400
03fa  3c        inc     a
03fb  77        ld      (hl),a
03fc  3a1b20    ld      a,(#201b)
03ff  c608      add     a,#08
0401  322a20    ld      (#202a),a
0404  cd3004    call    #0430
0407  c30014    jp      #1400
040a  cd3004    call    #0430
040d  d5        push    de
040e  e5        push    hl
040f  c5        push    bc
0410  cd5214    call    #1452
0413  c1        pop     bc
0414  e1        pop     hl
0415  d1        pop     de
0416  3a2c20    ld      a,(#202c)
0419  85        add     a,l
041a  6f        ld      l,a
041b  322920    ld      (#2029),a
041e  cd9114    call    #1491
0421  3a6120    ld      a,(#2061)
0424  a7        and     a
0425  c8        ret     z

0426  320220    ld      (#2002),a
0429  c9        ret     

042a  fe05      cp      #05
042c  c8        ret     z

042d  c33604    jp      #0436
0430  212720    ld      hl,#2027
0433  c33b1a    jp      #1a3b
0436  cd3004    call    #0430
0439  cd5214    call    #1452
043c  212520    ld      hl,#2025	; Active player shot descriptor
043f  11251b    ld      de,#1b25	; Initialize data
0442  0607      ld      b,#07		; 7 bytes
0444  cd321a    call    #1a32		; Initiate player shot descriptor
0447  2a8d20    ld      hl,(#208d)
044a  2c        inc     l
044b  7d        ld      a,l
044c  fe63      cp      #63
044e  da5304    jp      c,#0453
0451  2e54      ld      l,#54
0453  228d20    ld      (#208d),hl
0456  2a8f20    ld      hl,(#208f)
0459  2c        inc     l
045a  228f20    ld      (#208f),hl
045d  3a8420    ld      a,(#2084)
0460  a7        and     a
0461  c0        ret     nz

0462  7e        ld      a,(hl)
0463  e601      and     #01
0465  012902    ld      bc,#0229
0468  c26e04    jp      nz,#046e
046b  01e0fe    ld      bc,#fee0
046e  218a20    ld      hl,#208a
0471  71        ld      (hl),c
0472  23        inc     hl
0473  23        inc     hl
0474  70        ld      (hl),b
0475  c9        ret     

0476  e1        pop     hl
0477  3a321b    ld      a,(#1b32)
047a  323220    ld      (#2032),a
047d  2a3820    ld      hl,(#2038)
0480  7d        ld      a,l
0481  b4        or      h
0482  c28a04    jp      nz,#048a
0485  2b        dec     hl
0486  223820    ld      (#2038),hl
0489  c9        ret     

048a  113520    ld      de,#2035
048d  3ef9      ld      a,#f9
048f  cd5005    call    #0550
0492  3a4620    ld      a,(#2046)
0495  327020    ld      (#2070),a
0498  3a5620    ld      a,(#2056)
049b  327120    ld      (#2071),a
049e  cd6305    call    #0563
04a1  3a7820    ld      a,(#2078)
04a4  a7        and     a
04a5  213520    ld      hl,#2035
04a8  c25b05    jp      nz,#055b
04ab  11301b    ld      de,#1b30
04ae  213020    ld      hl,#2030
04b1  0610      ld      b,#10
04b3  c3321a    jp      #1a32
04b6  e1        pop     hl
04b7  3a6e20    ld      a,(#206e)
04ba  a7        and     a
04bb  c0        ret     nz

04bc  3a8020    ld      a,(#2080)
04bf  fe01      cp      #01
04c1  c0        ret     nz

04c2  114520    ld      de,#2045
04c5  3eed      ld      a,#ed
04c7  cd5005    call    #0550
04ca  3a3620    ld      a,(#2036)
04cd  327020    ld      (#2070),a
04d0  3a5620    ld      a,(#2056)
04d3  327120    ld      (#2071),a
04d6  cd6305    call    #0563
04d9  3a7620    ld      a,(#2076)
04dc  fe10      cp      #10
04de  dae704    jp      c,#04e7
04e1  3a481b    ld      a,(#1b48)
04e4  327620    ld      (#2076),a
04e7  3a7820    ld      a,(#2078)
04ea  a7        and     a
04eb  214520    ld      hl,#2045
04ee  c25b05    jp      nz,#055b
04f1  11401b    ld      de,#1b40
04f4  214020    ld      hl,#2040
04f7  0610      ld      b,#10
04f9  cd321a    call    #1a32
04fc  3a8220    ld      a,(#2082)	; Number of aliens on screen
04ff  3d        dec     a
0500  c20805    jp      nz,#0508
0503  3e01      ld      a,#01
0505  326e20    ld      (#206e),a
0508  2a7620    ld      hl,(#2076)
050b  c37e06    jp      #067e
050e  e1        pop     hl
050f  115520    ld      de,#2055
0512  3edb      ld      a,#db
0514  cd5005    call    #0550
0517  3a4620    ld      a,(#2046)
051a  327020    ld      (#2070),a
051d  3a3620    ld      a,(#2036)
0520  327120    ld      (#2071),a
0523  cd6305    call    #0563
0526  3a7620    ld      a,(#2076)
0529  fe15      cp      #15
052b  da3405    jp      c,#0534
052e  3a581b    ld      a,(#1b58)
0531  327620    ld      (#2076),a
0534  3a7820    ld      a,(#2078)
0537  a7        and     a
0538  215520    ld      hl,#2055
053b  c25b05    jp      nz,#055b
053e  11501b    ld      de,#1b50
0541  215020    ld      hl,#2050
0544  0610      ld      b,#10
0546  cd321a    call    #1a32
0549  2a7620    ld      hl,(#2076)
054c  225820    ld      (#2058),hl
054f  c9        ret     

0550  327f20    ld      (#207f),a
0553  217320    ld      hl,#2073
0556  060b      ld      b,#0b
0558  c3321a    jp      #1a32
055b  117320    ld      de,#2073
055e  060b      ld      b,#0b
0560  c3321a    jp      #1a32
0563  217320    ld      hl,#2073
0566  7e        ld      a,(hl)
0567  e680      and     #80
0569  c2c105    jp      nz,#05c1
056c  3ac120    ld      a,(#20c1)
056f  fe04      cp      #04
0571  3a6920    ld      a,(#2069)
0574  cab705    jp      z,#05b7
0577  a7        and     a
0578  c8        ret     z

0579  23        inc     hl
057a  3600      ld      (hl),#00
057c  3a7020    ld      a,(#2070)
057f  a7        and     a
0580  ca8905    jp      z,#0589
0583  47        ld      b,a
0584  3acf20    ld      a,(#20cf)
0587  b8        cp      b
0588  d0        ret     nc

0589  3a7120    ld      a,(#2071)
058c  a7        and     a
058d  ca9605    jp      z,#0596
0590  47        ld      b,a
0591  3acf20    ld      a,(#20cf)
0594  b8        cp      b
0595  d0        ret     nc

0596  23        inc     hl
0597  7e        ld      a,(hl)
0598  a7        and     a
0599  ca1b06    jp      z,#061b
059c  2a7620    ld      hl,(#2076)
059f  4e        ld      c,(hl)
05a0  23        inc     hl
05a1  00        nop     
05a2  227620    ld      (#2076),hl
05a5  cd2f06    call    #062f
05a8  d0        ret     nc

05a9  cd7a01    call    #017a
05ac  79        ld      a,c
05ad  c607      add     a,#07
05af  67        ld      h,a
05b0  7d        ld      a,l
05b1  d60a      sub     #0a
05b3  6f        ld      l,a
05b4  227b20    ld      (#207b),hl
05b7  217320    ld      hl,#2073
05ba  7e        ld      a,(hl)
05bb  f680      or      #80
05bd  77        ld      (hl),a
05be  23        inc     hl
05bf  34        inc     (hl)
05c0  c9        ret     

05c1  117c20    ld      de,#207c
05c4  cd061a    call    #1a06
05c7  d0        ret     nc

05c8  23        inc     hl
05c9  7e        ld      a,(hl)
05ca  e601      and     #01
05cc  c24406    jp      nz,#0644
05cf  23        inc     hl
05d0  34        inc     (hl)
05d1  cd7506    call    #0675
05d4  3a7920    ld      a,(#2079)
05d7  c603      add     a,#03
05d9  217f20    ld      hl,#207f
05dc  be        cp      (hl)
05dd  dae205    jp      c,#05e2
05e0  d60c      sub     #0c
05e2  327920    ld      (#2079),a
05e5  3a7b20    ld      a,(#207b)
05e8  47        ld      b,a
05e9  3a7e20    ld      a,(#207e)
05ec  80        add     a,b
05ed  327b20    ld      (#207b),a
05f0  cd6c06    call    #066c
05f3  3a7b20    ld      a,(#207b)
05f6  fe15      cp      #15
05f8  da1206    jp      c,#0612
05fb  3a6120    ld      a,(#2061)
05fe  a7        and     a
05ff  c8        ret     z

0600  3a7b20    ld      a,(#207b)
0603  fe1e      cp      #1e
0605  da1206    jp      c,#0612
0608  fe27      cp      #27
060a  00        nop     
060b  d21206    jp      nc,#0612
060e  97        sub     a
060f  321520    ld      (#2015),a
0612  3a7320    ld      a,(#2073)
0615  f601      or      #01
0617  327320    ld      (#2073),a
061a  c9        ret     

061b  3a1b20    ld      a,(#201b)
061e  c608      add     a,#08
0620  67        ld      h,a
0621  cd6f15    call    #156f
0624  79        ld      a,c
0625  fe0c      cp      #0c
0627  daa505    jp      c,#05a5
062a  0e0b      ld      c,#0b
062c  c3a505    jp      #05a5
062f  0d        dec     c
0630  3a6720    ld      a,(#2067)
0633  67        ld      h,a
0634  69        ld      l,c
0635  1605      ld      d,#05
0637  7e        ld      a,(hl)
0638  a7        and     a
0639  37        scf     
063a  c0        ret     nz

063b  7d        ld      a,l
063c  c60b      add     a,#0b
063e  6f        ld      l,a
063f  15        dec     d
0640  c23706    jp      nz,#0637
0643  c9        ret     

0644  217820    ld      hl,#2078
0647  35        dec     (hl)
0648  7e        ld      a,(hl)
0649  fe03      cp      #03
064b  c26706    jp      nz,#0667
064e  cd7506    call    #0675
0651  21dc1c    ld      hl,#1cdc
0654  227920    ld      (#2079),hl
0657  217c20    ld      hl,#207c
065a  35        dec     (hl)
065b  35        dec     (hl)
065c  2b        dec     hl
065d  35        dec     (hl)
065e  35        dec     (hl)
065f  3e06      ld      a,#06
0661  327d20    ld      (#207d),a
0664  c36c06    jp      #066c
0667  a7        and     a
0668  c0        ret     nz

0669  c37506    jp      #0675
066c  217920    ld      hl,#2079
066f  cd3b1a    call    #1a3b
0672  c39114    jp      #1491
0675  217920    ld      hl,#2079
0678  cd3b1a    call    #1a3b
067b  c35214    jp      #1452
067e  224820    ld      (#2048),hl
0681  c9        ret     

0682  e1        pop     hl
0683  3a8020    ld      a,(#2080)
0686  fe02      cp      #02
0688  c0        ret     nz

0689  218320    ld      hl,#2083
068c  7e        ld      a,(hl)
068d  a7        and     a
068e  ca0f05    jp      z,#050f
0691  3a5620    ld      a,(#2056)
0694  a7        and     a
0695  c20f05    jp      nz,#050f
0698  23        inc     hl
0699  7e        ld      a,(hl)
069a  a7        and     a
069b  c2ab06    jp      nz,#06ab
069e  3a8220    ld      a,(#2082)	; Number of aliens remaining
06a1  fe08      cp      #08		; Less than ...
06a3  da0f05    jp      c,#050f	; 8, do this ...
06a6  3601      ld      (hl),#01
06a8  cd3c07    call    #073c
06ab  118a20    ld      de,#208a
06ae  cd061a    call    #1a06
06b1  d0        ret     nc

06b2  218520    ld      hl,#2085
06b5  7e        ld      a,(hl)
06b6  a7        and     a
06b7  c2d606    jp      nz,#06d6
06ba  218a20    ld      hl,#208a
06bd  7e        ld      a,(hl)
06be  23        inc     hl
06bf  23        inc     hl
06c0  86        add     a,(hl)
06c1  328a20    ld      (#208a),a
06c4  cd3c07    call    #073c
06c7  218a20    ld      hl,#208a
06ca  7e        ld      a,(hl)
06cb  fe28      cp      #28
06cd  daf906    jp      c,#06f9
06d0  fee1      cp      #e1
06d2  d2f906    jp      nc,#06f9
06d5  c9        ret     

06d6  06fe      ld      b,#fe		; Something ...
06d8  cddc19    call    #19dc		; ... with sound
06db  23        inc     hl
06dc  35        dec     (hl)
06dd  7e        ld      a,(hl)
06de  fe1f      cp      #1f
06e0  ca4b07    jp      z,#074b
06e3  fe18      cp      #18
06e5  ca0c07    jp      z,#070c
06e8  a7        and     a
06e9  c0        ret     nz
06ea  06ef      ld      b,#ef
06ec  219820    ld      hl,#2098
06ef  7e        ld      a,(hl)
06f0  a0        and     b
06f1  77        ld      (hl),a
06f2  e620      and     #20		; All off but 
06f4  d305      out     (#05),a	; Sound
06f6  00        nop     		; Pause
06f7  00        nop     		; Pause
06f8  00        nop     		; Pause
06f9  cd4207    call    #0742		; Covert pixel pos from descriptor to HL screen and shift
06fc  cdcb14    call    #14cb		; Clear a one byte sprite at HL
06ff  218320    ld      hl,#2083	; RAM ?
0702  060a      ld      b,#0a		; 10 bytes
0704  cd5f07    call    #075f		; Re-initialize some RAM
0707  06fe      ld      b,#fe		; Do ...
0709  c3dc19    jp      #19dc		; ... some more sound and out

070c  3e01      ld      a,#01
070e  32f120    ld      (#20f1),a
0711  2a8d20    ld      hl,(#208d)
0714  46        ld      b,(hl)
0715  0e04      ld      c,#04
0717  21501d    ld      hl,#1d50
071a  114c1d    ld      de,#1d4c
071d  1a        ld      a,(de)
071e  b8        cp      b
071f  ca2807    jp      z,#0728
0722  23        inc     hl
0723  13        inc     de
0724  0d        dec     c
0725  c21d07    jp      nz,#071d
0728  7e        ld      a,(hl)
0729  328720    ld      (#2087),a	; First of descriptor (X coordinate)
072c  2600      ld      h,#00		; MSB = 0 ...
072e  68        ld      l,b		; HL = B
072f  29        add     hl,hl		; *2
0730  29        add     hl,hl		; *4
0731  29        add     hl,hl		; *8
0732  29        add     hl,hl		; *16
0733  22f220    ld      (#20f2),hl	; Score for hitting saucer???
0736  cd4207    call    #0742		; Fetch 5 bytes from 2087 descriptor
0739  c3f108    jp      #08f1		; Print message of length 3 (saucer score?)

073c  cd4207    call    #0742		; Fetch info from 2087 descriptor
073f  c33914    jp      #1439		; Print single character

0742  218720    ld      hl,#2087	? Descriptor ?
0745  cd3b1a    call    #1a3b		; Load 5 bytes from HL
0748  c3471a    jp      #1a47		; Convert pixel number to screen and shift
;
074b  0610      ld      b,#10
074d  219820    ld      hl,#2098
0750  7e        ld      a,(hl)
0751  b0        or      b
0752  77        ld      (hl),a
0753  cd7017    call    #1770
0756  217c1d    ld      hl,#1d7c
0759  228720    ld      (#2087),hl
075c  c33c07    jp      #073c
;
075f  11831b    ld      de,#1b83	; Data for ?
0762  c3321a    jp      #1a32		; Block copy [HL] to [DE]

;=============================================================
; Wait for 1 or 2 player start button press
0765  3e01      ld      a,#01
0767  329320    ld      (#2093),a
076a  310024    ld      sp,#2400	; Reset stack
076d  fb        ei      		; Enable interrupts
076e  cd7919    call    #1979		; Clear the 20E9 flag ???
0771  cdd609    call    #09d6		; Clear center window
0774  211330    ld      hl,#3013	; Screen coordinates
0777  11f31f    ld      de,#1ff3	; "PRESS"
077a  0e04      ld      c,#04		; Message length
077c  cdf308    call    #08f3		; Print it
077f  3aeb20    ld      a,(#20eb)	; Number of credits
0782  3d        dec     a		; Set flags
0783  211028    ld      hl,#2810	; Screen coordinates
0786  0e14      ld      c,#14		; Message length
0788  c25708    jp      nz,#0857	; Take 1 or 2 player start
078b  11cf1a    ld      de,#1acf	; "ONLY 1PLAYER BUTTON "
078e  cdf308    call    #08f3		; Print message
0791  db01      in      a,(#01)	; Read player controls
0793  e604      and     #04		; 1Player start button?
0795  ca7f07    jp      z,#077f	; No ... wait for button or credit

;=============================================================
; START NEW GAME
;
; 1 Player start
0798  0699      ld      b,#99		; Essentially a -1 for DAA
079a  af        xor     a		; Clear two player flag	
;
; 2 player start sequence enters here with a=1 and B=98 (-2)
079b  32ce20    ld      (#20ce),a	; Set flag for 1 or 2 players
079e  3aeb20    ld      a,(#20eb)	; Number of credits
07a1  80        add     a,b		; Take away credits
07a2  27        daa     		; Convert back to DAA
07a3  32eb20    ld      (#20eb),a	; New credit count
07a6  cd4719    call    #1947		; Display number of credits
07a9  210000    ld      hl,#0000
07ac  22f820    ld      (#20f8),hl
07af  22fc20    ld      (#20fc),hl
07b2  cd2519    call    #1925
07b5  cd2b19    call    #192b
07b8  cdd719    call    #19d7		
07bb  210101    ld      hl,#0101
07be  7c        ld      a,h
07bf  32ef20    ld      (#20ef),a
07c2  22e720    ld      (#20e7),hl
07c5  22e520    ld      (#20e5),hl
07c8  cd5619    call    #1956		; Print scores and credits
07cb  cdef01    call    #01ef
07ce  cdf501    call    #01f5
07d1  cdd108    call    #08d1		; Get number of ships from DIP settings
07d4  32ff21    ld      (#21ff),a
07d7  32ff22    ld      (#22ff),a
07da  cdd700    call    #00d7
07dd  af        xor     a
07de  32fe21    ld      (#21fe),a
07e1  32fe22    ld      (#22fe),a
07e4  cdc001    call    #01c0
07e7  cd0419    call    #1904
07ea  217838    ld      hl,#3878
07ed  22fc21    ld      (#21fc),hl
07f0  22fc22    ld      (#22fc),hl
07f3  cde401    call    #01e4
07f6  cd7f1a    call    #1a7f		; Initialize ship hold indicator
;
07f9  cd8d08    call    #088d
07fc  cdd609    call    #09d6
07ff  00        nop     
0800  af        xor     a
0801  32c120    ld      (#20c1),a
0804  cdcf01    call    #01cf
0807  3a6720    ld      a,(#2067)
080a  0f        rrca    
080b  da7208    jp      c,#0872
080e  cd1302    call    #0213
0811  cdcf01    call    #01cf
0814  cdb100    call    #00b1
0817  cdd119    call    #19d1		; Set 20E9 flag to 1
081a  0620      ld      b,#20
081c  cdfa18    call    #18fa		; Some sound stuff
;
; GAME LOOP
;
081f  cd1816    call    #1618		; Initiate player shot if button pressed
0822  cd0a19    call    #190a		; ??? Collision detection for shot ???
0825  cdf315    call    #15f3		; ???
0828  cd8809    call    #0988		; ???
082b  3a8220    ld      a,(#2082)
082e  a7        and     a
082f  caef09    jp      z,#09ef	; ???
0832  cd0e17    call    #170e		; ???
0835  cd3509    call    #0935		; Check (and handle) extra ship award
0838  cdd808    call    #08d8		; ???
083b  cd2c17    call    #172c		; Shot sound on or off with 2025
083e  cd590a    call    #0a59		; Check if player is hit
0841  ca4908    jp      z,#0849	; No hit ... jump handler
0844  0604      ld      b,#04		; Player hit sound
0846  cdfa18    call    #18fa		; Make explosion sound
0849  cd7517    call    #1775		; ???
084c  d306      out     (#06),a	; ?OUT??? Could be something with the video hardware
084e  cd0418    call    #1804		; ???
0851  c31f08    jp      #081f		; Continue game loop

0854  00        nop     
0855  00        nop     
0856  00        nop     

;=============================================================
; Test for 1 or 2 player start button press
0857  11ba1a    ld      de,#1aba	; "1 OR 2PLAYERS BUTTON"
085a  cdf308    call    #08f3		; Print message
085d  0698      ld      b,#98		; -2 (take away 2 credits)
085f  db01      in      a,(#01)	; Read player controls
0861  0f        rrca    		; Test ...
0862  0f        rrca    		; ... bit 2
0863  da6d08    jp      c,#086d	; 2 player button pressed ... do it
0866  0f        rrca    		; Test bit 3
0867  da9807    jp      c,#0798	; One player start ... do it
086a  c37f07    jp      #077f		; Keep waiting on credit or button
; 2 PLAYER START
086d  3e01      ld      a,#01		; Flag 2 player game
086f  c39b07    jp      #079b		; Continue normal startup

;=============================================================
0872  cd1a02    call    #021a
0875  c31408    jp      #0814
0878  3a0820    ld      a,(#2008)
087b  47        ld      b,a
087c  2a0920    ld      hl,(#2009)
087f  eb        ex      de,hl
0880  c38608    jp      #0886
0883  00        nop     
0884  00        nop     
0885  00        nop     
0886  3a6720    ld      a,(#2067)
0889  67        ld      h,a
088a  2efc      ld      l,#fc
088c  c9        ret     

088d  21112b    ld      hl,#2b11
0890  11701b    ld      de,#1b70
0893  0e0e      ld      c,#0e
0895  cdf308    call    #08f3
0898  3a6720    ld      a,(#2067)
089b  0f        rrca    
089c  3e1c      ld      a,#1c
089e  211137    ld      hl,#3711
08a1  d4ff08    call    nc,#08ff
08a4  3eb0      ld      a,#b0
08a6  32c020    ld      (#20c0),a
08a9  3ac020    ld      a,(#20c0)
08ac  a7        and     a
08ad  c8        ret     z

08ae  e604      and     #04
08b0  c2bc08    jp      nz,#08bc
08b3  cdca09    call    #09ca
08b6  cd3119    call    #1931
08b9  c3a908    jp      #08a9
08bc  0620      ld      b,#20
08be  211c27    ld      hl,#271c
08c1  3a6720    ld      a,(#2067)
08c4  0f        rrca    
08c5  dacb08    jp      c,#08cb
08c8  211c39    ld      hl,#391c
08cb  cdcb14    call    #14cb		; Clear a one byte sprite at HL
08ce  c3a908    jp      #08a9


;=============================================================
; Get number of ships from DIP settings
08d1  db02      in      a,(#02)	; DIP settings
08d3  e603      and     #03		; Get number of ships
08d5  c603      add     a,#03		; From 3-6
08d7  c9        ret     		; Out

08d8  3a8220    ld      a,(#2082)	; Number of aliens on screen
08db  fe09      cp      #09
08dd  d0        ret     nc
08de  3efb      ld      a,#fb
08e0  327e20    ld      (#207e),a
08e3  c9        ret     

08e4  3ace20    ld      a,(#20ce)
08e7  a7        and     a
08e8  c0        ret     nz

08e9  211c39    ld      hl,#391c
08ec  0620      ld      b,#20		; 32 rows
08ee  c3cb14    jp      #14cb		; Clear a one byte sprite at HL

08f1  0e03      ld      c,#03

;=============================================================
; Print a message on the screen
; HL = coordinates
; DE = message buffer
; C = length
08f3  1a        ld      a,(de)	; Get character
08f4  d5        push    de		; Preserve
08f5  cdff08    call    #08ff		; Print character
08f8  d1        pop     de		; Restore
08f9  13        inc     de		; Next character
08fa  0d        dec     c		; All done?
08fb  c2f308    jp      nz,#08f3	; Print all of message
08fe  c9        ret     		; Out

;=============================================================
; Get pointer to 8 byte sprite number in A and
; draw sprite on screen at HL
08ff  11001e    ld      de,#1e00	; Character set
0902  e5        push    hl		; Preserve
0903  2600      ld      h,#00		; MSB=0
0905  6f        ld      l,a		; Character number to L
0906  29        add     hl,hl		; HL = HL *2
0907  29        add     hl,hl		; *4
0908  29        add     hl,hl		; *8 (8 bytes each)
0909  19        add     hl,de		; Get pointer to sprite
090a  eb        ex      de,hl		; Now into DE
090b  e1        pop     hl		; Restore HL
090c  0608      ld      b,#08		; 8 bytes each
090e  d306      out     (#06),a	; ?OUT?
0910  c33914    jp      #1439		; To screen

;=============================================================
0913  3a0920    ld      a,(#2009)
0916  fe78      cp      #78
0918  d0        ret     nc
0919  2a9120    ld      hl,(#2091)
091c  7d        ld      a,l
091d  b4        or      h
091e  c22909    jp      nz,#0929
0921  210006    ld      hl,#0600
0924  3e01      ld      a,#01
0926  328320    ld      (#2083),a
0929  2b        dec     hl
092a  229120    ld      (#2091),hl
092d  c9        ret     

;=============================================================
; Get number of ships for acive player
092e  cd1116    call    #1611		; HL points to player data
0931  2eff      ld      l,#ff		; Last byte = numbe of ships
0933  7e        ld      a,(hl)	; Get number of ships
0934  c9        ret     		; Done

;=============================================================
; Award extra ship if score has reached ceiling
0935  cd1019    call    #1910		; Get descriptor of sorts
0938  2b        dec     hl		; Back up ...
0939  2b        dec     hl		; ... two bytes
093a  7e        ld      a,(hl)	; Has extra ship ...
093b  a7        and     a		; already been awarded?
093c  c8        ret     z		; Yes ... ignore
093d  0615      ld      b,#15		; Default 1500
093f  db02      in      a,(#02)	; Read DIP settings
0941  e608      and     #08		; Extra ship at 1000 or 1500
0943  ca4809    jp      z,#0948	; 0=1500
0946  0610      ld      b,#10		; Awarded at 1000
0948  cdca09    call    #09ca		; Get score descriptor for active player
094b  23        inc     hl		; MSB of score ...
094c  7e        ld      a,(hl)	; ... to accumulator
094d  b8        cp      b		; Time for an extra ship?
094e  d8        ret     c		; No ... out
094f  cd2e09    call    #092e		; Get pointer to number of ships
0952  34        inc     (hl)		; Bump number of ships
0953  7e        ld      a,(hl)	; Get the new total
0954  f5        push    af		; Hang onto it for a bit
0955  210125    ld      hl,#2501	; Screen coords for ship hold
0958  24        inc     h		; Bump to ...
0959  24        inc     h		; ... next
095a  3d        dec     a		; ... spot
095b  c25809    jp      nz,#0958	; Find spot for new ship
095e  0610      ld      b,#10		; 16 byte sprite
0960  11601c    ld      de,#1c60	; Player sprite
0963  cd3914    call    #1439		; Draw the sprite
0966  f1        pop     af		; Restore the count
0967  3c        inc     a		; +1
0968  cd8b1a    call    #1a8b		; Print the number of ships
096b  cd1019    call    #1910		; Get descriptor for active player of some sort
096e  2b        dec     hl		; Back up ...
096f  2b        dec     hl		; ... two bytes
0970  3600      ld      (hl),#00	; Flag extra ship has been awarded
0972  3eff      ld      a,#ff		; Set timer ...
0974  329920    ld      (#2099),a	; ... for extra-ship sound
0977  0610      ld      b,#10		; Make sound ...
0979  c3fa18    jp      #18fa		; ... for extra man

097c  21a01d    ld      hl,#1da0
097f  fe02      cp      #02
0981  d8        ret     c
0982  23        inc     hl
0983  fe04      cp      #04
0985  d8        ret     c
0986  23        inc     hl
0987  c9        ret     

0988  cdca09    call    #09ca
098b  3af120    ld      a,(#20f1)
098e  a7        and     a
098f  c8        ret     z
0990  af        xor     a
0991  32f120    ld      (#20f1),a
0994  e5        push    hl
0995  2af220    ld      hl,(#20f2)
0998  eb        ex      de,hl
0999  e1        pop     hl
099a  7e        ld      a,(hl)
099b  83        add     a,e
099c  27        daa     
099d  77        ld      (hl),a
099e  5f        ld      e,a
099f  23        inc     hl
09a0  7e        ld      a,(hl)
09a1  8a        adc     a,d
09a2  27        daa     
09a3  77        ld      (hl),a
09a4  57        ld      d,a
09a5  23        inc     hl
09a6  7e        ld      a,(hl)
09a7  23        inc     hl
09a8  66        ld      h,(hl)
09a9  6f        ld      l,a
09aa  c3ad09    jp      #09ad	; Why on earth are we jumping to next?

;=============================================================
; Print 4 digits in DE
09ad  7a        ld      a,d
09ae  cdb209    call    #09b2
09b1  7b        ld      a,e

;=============================================================
; Display 2 digits in A to screen at HL
09b2  d5        push    de	; Preserve
09b3  f5        push    af	; Save for later
09b4  0f        rrca    	; Get ...
09b5  0f        rrca    	; ...
09b6  0f        rrca    	; ...
09b7  0f        rrca    	; ... left digit
09b8  e60f      and     #0f	; Mask out lower digit's bits
09ba  cdc509    call    #09c5	; To screen at HL
09bd  f1        pop     af	; Restore digit
09be  e60f      and     #0f	; Mask out upper digit
09c0  cdc509    call    #09c5	; To screen
09c3  d1        pop     de	; Restore
09c4  c9        ret     	; Done
;
09c5  c61a      add     a,#1a	; Bump to number characters
09c7  c3ff08    jp      #08ff	; Continue ...

;=============================================================
; Get score descriptor for active player
09ca  3a6720    ld      a,(#2067)	; Get active player
09cd  0f        rrca    		; Test for player
09ce  21f820    ld      hl,#20f8	; Player 1 score descriptor
09d1  d8        ret     c		; Keep it if player 1 is active
09d2  21fc20    ld      hl,#20fc	; Else get player 2 descriptor
09d5  c9        ret     		; Out

;=============================================================
; Clear center window of screen
09d6  210224    ld      hl,#2402	; Thrid from left, top of screen
09d9  3600      ld      (hl),#00	; Clear screen byte
09db  23        inc     hl		; Next in row
09dc  7d        ld      a,l		; Get X ...
09dd  e61f      and     #1f		; ... coordinate
09df  fe1c      cp      #1c		; Edge minus a buffer?
09e1  dae809    jp      c,#09e8	; No ... keep going
09e4  110600    ld      de,#0006	; Else ... bump to
09e7  19        add     hl,de		; ... next edge + buffer
09e8  7c        ld      a,h		; Get Y coordinate
09e9  fe40      cp      #40		; Reached bottom?
09eb  dad909    jp      c,#09d9	; No ... keep going
09ee  c9        ret     		; Done

09ef  cd3c0a    call    #0a3c
09f2  af        xor     a
09f3  32e920    ld      (#20e9),a
09f6  cdd609    call    #09d6
09f9  3a6720    ld      a,(#2067)
09fc  f5        push    af
09fd  cde401    call    #01e4
0a00  f1        pop     af
0a01  326720    ld      (#2067),a
0a04  3a6720    ld      a,(#2067)
0a07  67        ld      h,a
0a08  e5        push    hl
0a09  2efe      ld      l,#fe
0a0b  7e        ld      a,(hl)
0a0c  e607      and     #07
0a0e  3c        inc     a
0a0f  77        ld      (hl),a
0a10  21a21d    ld      hl,#1da2
0a13  23        inc     hl
0a14  3d        dec     a
0a15  c2130a    jp      nz,#0a13
0a18  7e        ld      a,(hl)
0a19  e1        pop     hl
0a1a  2efc      ld      l,#fc
0a1c  77        ld      (hl),a
0a1d  23        inc     hl
0a1e  3638      ld      (hl),#38
0a20  7c        ld      a,h
0a21  0f        rrca    
0a22  da330a    jp      c,#0a33
0a25  3e21      ld      a,#21
0a27  329820    ld      (#2098),a
0a2a  cdf501    call    #01f5
0a2d  cd0419    call    #1904
0a30  c30408    jp      #0804
0a33  cdef01    call    #01ef
0a36  cdc001    call    #01c0
0a39  c30408    jp      #0804
0a3c  cd590a    call    #0a59
0a3f  c2520a    jp      nz,#0a52
0a42  3e30      ld      a,#30
0a44  32c020    ld      (#20c0),a
0a47  3ac020    ld      a,(#20c0)
0a4a  a7        and     a
0a4b  c8        ret     z

0a4c  cd590a    call    #0a59
0a4f  ca470a    jp      z,#0a47
0a52  cd590a    call    #0a59
0a55  c2520a    jp      nz,#0a52
0a58  c9        ret     

;=============================================================
; Check to see if player is hit
0a59  3a1520    ld      a,(#2015)	; Active player hit flag
0a5c  feff      cp      #ff		; All FFs means player is OK
0a5e  c9        ret     		; Out

0a5f  3aef20    ld      a,(#20ef)	; Test for demo play
0a62  a7        and     a		; '
0a63  ca7c0a    jp      z,#0a7c	; Yes ... skip
0a66  48        ld      c,b		; Hold B
0a67  0608      ld      b,#08		; Alien hit sound
0a69  cdfa18    call    #18fa		; Enable sound
0a6c  41        ld      b,c		; Restore B
0a6d  78        ld      a,b		; Into A
0a6e  cd7c09    call    #097c
0a71  7e        ld      a,(hl)
0a72  21f320    ld      hl,#20f3
0a75  3600      ld      (hl),#00
0a77  2b        dec     hl
0a78  77        ld      (hl),a
0a79  2b        dec     hl
0a7a  3601      ld      (hl),#01
0a7c  216220    ld      hl,#2062	; Return exploding-alien descriptor
0a7f  c9        ret     		; Out

0a80  3e02      ld      a,#02
0a82  32c120    ld      (#20c1),a
0a85  d306      out     (#06),a	; ?OUT?
0a87  3acb20    ld      a,(#20cb)
0a8a  a7        and     a
0a8b  ca850a    jp      z,#0a85
0a8e  af        xor     a
0a8f  32c120    ld      (#20c1),a
0a92  c9        ret     

;=============================================================
; Print message from DE to screen at HL (length in B) with a
; delay between letters.
0a93  d5        push    de		; Preserve
0a94  1a        ld      a,(de)	; Get character
0a95  cdff08    call    #08ff		; Draw character on screen
0a98  d1        pop     de		; Preserve
0a99  3e07      ld      a,#07		; Delay between letters
0a9b  32c020    ld      (#20c0),a	; Set counter
0a9e  3ac020    ld      a,(#20c0)	; Get counter
0aa1  3d        dec     a		; Is it 1?
0aa2  c29e0a    jp      nz,#0a9e	; No ... wait on it
0aa5  13        inc     de		; Next in message
0aa6  0d        dec     c		; All done?
0aa7  c2930a    jp      nz,#0a93	; No ... do all
0aaa  c9        ret     		; Out

0aab  215020    ld      hl,#2050
0aae  c34b02    jp      #024b

;=============================================================
; Delay 40 interrupts
0ab1  3e40      ld      a,#40		; Delay of 40
0ab3  c3d70a    jp      #0ad7		; Do delay

;=============================================================
; Delay 80 interrupts
0ab6  3e80      ld      a,#80		; Delay of 80
0ab8  c3d70a    jp      #0ad7		; Do delay

0abb  e1        pop     hl
0abc  c37200    jp      #0072

;=============================================================
0abf  3ac120    ld      a,(#20c1)
0ac2  0f        rrca    
0ac3  dabb0a    jp      c,#0abb
0ac6  0f        rrca    
0ac7  da6818    jp      c,#1868
0aca  0f        rrca    
0acb  daab0a    jp      c,#0aab
0ace  c9        ret     
0acf  21142b    ld      hl,#2b14
0ad2  0e0f      ld      c,#0f
0ad4  c3930a    jp      #0a93

;=============================================================
; Wait on ISR counter to reach 0
0ad7  32c020    ld      (#20c0),a	; Delay counter
0ada  3ac020    ld      a,(#20c0)	; Get current delay
0add  a7        and     a		; Zero yet?
0ade  c2da0a    jp      nz,#0ada	; No ... wait on it
0ae1  c9        ret     		; Out

0ae2  21c220    ld      hl,#20c2	; RAM
0ae5  060c      ld      b,#0c		; C bytes
0ae7  c3321a    jp      #1a32		; Block copy DE to HL (B)

;=============================================================
; After initialization
0aea  af        xor     a
0aeb  d303      out     (#03),a	; Turn off sound
0aed  d305      out     (#05),a	; Turn off sound
0aef  cd8219    call    #1982
0af2  fb        ei      
0af3  cdb10a    call    #0ab1
0af6  3aec20    ld      a,(#20ec)
0af9  a7        and     a
0afa  211730    ld      hl,#3017
0afd  0e04      ld      c,#04
0aff  c2e80b    jp      nz,#0be8
0b02  11fa1c    ld      de,#1cfa
0b05  cd930a    call    #0a93
0b08  11af1d    ld      de,#1daf
0b0b  cdcf0a    call    #0acf
0b0e  cdb10a    call    #0ab1
0b11  cd1518    call    #1815
0b14  cdb60a    call    #0ab6
0b17  3aec20    ld      a,(#20ec)
0b1a  a7        and     a
0b1b  c24a0b    jp      nz,#0b4a
0b1e  11951a    ld      de,#1a95
0b21  cde20a    call    #0ae2		; Copy to RAM 
0b24  cd800a    call    #0a80
0b27  11b01b    ld      de,#1bb0
0b2a  cde20a    call    #0ae2
0b2d  cd800a    call    #0a80
0b30  cdb10a    call    #0ab1
0b33  11c91f    ld      de,#1fc9
0b36  cde20a    call    #0ae2
0b39  cd800a    call    #0a80
0b3c  cdb10a    call    #0ab1
0b3f  21b733    ld      hl,#33b7
0b42  060a      ld      b,#0a		; 10 rows
0b44  cdcb14    call    #14cb		; Clear a one byte sprite at HL
0b47  cdb60a    call    #0ab6
0b4a  cdd609    call    #09d6
0b4d  3aff21    ld      a,(#21ff)
0b50  a7        and     a
0b51  c25d0b    jp      nz,#0b5d
0b54  cdd108    call    #08d1		; Get number of ships from DIP settings
0b57  32ff21    ld      (#21ff),a
0b5a  cd7f1a    call    #1a7f		; Remove a ship and update indicators
0b5d  cde401    call    #01e4
0b60  cdc001    call    #01c0
0b63  cdef01    call    #01ef
0b66  cd1a02    call    #021a
0b69  3e01      ld      a,#01
0b6b  32c120    ld      (#20c1),a
0b6e  cdcf01    call    #01cf
0b71  cd1816    call    #1618
0b74  cdf10b    call    #0bf1
0b77  d306      out     (#06),a	; ?OUT?
0b79  cd590a    call    #0a59
0b7c  ca710b    jp      z,#0b71
0b7f  af        xor     a		; Remove player shot ...
0b80  322520    ld      (#2025),a	; ... from activity
0b83  cd590a    call    #0a59
0b86  c2830b    jp      nz,#0b83
0b89  af        xor     a
0b8a  32c120    ld      (#20c1),a
0b8d  cdb10a    call    #0ab1
0b90  cd8819    call    #1988
0b93  0e0c      ld      c,#0c
0b95  21112c    ld      hl,#2c11	; Screen coordinates
0b98  11901f    ld      de,#1f90	; "INSERT  COIN"
0b9b  cdf308    call    #08f3		; Print message
0b9e  3aec20    ld      a,(#20ec)
0ba1  fe00      cp      #00
0ba3  c2ae0b    jp      nz,#0bae
0ba6  211133    ld      hl,#3311	; Screen coordinates
0ba9  3e02      ld      a,#02		; Number 2
0bab  cdff08    call    #08ff		; Print number 2
0bae  019c1f    ld      bc,#1f9c
0bb1  cd5618    call    #1856
0bb4  cd4c18    call    #184c
0bb7  db02      in      a,(#02)
0bb9  07        rlca    
0bba  dac30b    jp      c,#0bc3
0bbd  01a01f    ld      bc,#1fa0
0bc0  cd3a18    call    #183a
0bc3  cdb60a    call    #0ab6
0bc6  3aec20    ld      a,(#20ec)
0bc9  fe00      cp      #00
0bcb  c2da0b    jp      nz,#0bda
0bce  11d51f    ld      de,#1fd5
0bd1  cde20a    call    #0ae2
0bd4  cd800a    call    #0a80
0bd7  cd9e18    call    #189e
0bda  21ec20    ld      hl,#20ec
0bdd  7e        ld      a,(hl)
0bde  3c        inc     a
0bdf  e601      and     #01
0be1  77        ld      (hl),a
0be2  cdd609    call    #09d6
0be5  c3df18    jp      #18df		; Gets back to AfterInitialization

0be8  11ab1d    ld      de,#1dab
0beb  cd930a    call    #0a93
0bee  c30b0b    jp      #0b0b
0bf1  cd0a19    call    #190a
0bf4  c39a19    jp      #199a

; Message = "TAITO COP"
0bf7  130008130e26020e0f      

0c00 - 13ff 00's

1400  00        nop     
1401  cd7414    call    #1474
1404  00        nop     
1405  c5        push    bc
1406  e5        push    hl
1407  1a        ld      a,(de)
1408  d304      out     (#04),a
140a  db03      in      a,(#03)	; Read shift register
140c  b6        or      (hl)
140d  77        ld      (hl),a
140e  23        inc     hl
140f  13        inc     de
1410  af        xor     a
1411  d304      out     (#04),a
1413  db03      in      a,(#03)	; Read shift register
1415  b6        or      (hl)
1416  77        ld      (hl),a
1417  e1        pop     hl
1418  012000    ld      bc,#0020
141b  09        add     hl,bc
141c  c1        pop     bc
141d  05        dec     b
141e  c20514    jp      nz,#1405
1421  c9        ret     

1422  00        nop     
1423  00        nop   

;=============================================================
; Clear a sprite from the screen (standard pixel number descriptor)  
1424  cd7414    call    #1474		; Convert pixel number in HL
1427  c5        push    bc		; Hold
1428  e5        push    hl		; Hold
1429  af        xor     a		; 0
142a  77        ld      (hl),a	; Clear screen byte
142b  23        inc     hl		; Next byte
142c  77        ld      (hl),a	; Clear byte
142d  23        inc     hl		; ? Why do this ?
142e  e1        pop     hl		; Restore screen coordinate
142f  012000    ld      bc,#0020	; Add 1 row ...
1432  09        add     hl,bc		; ... to screen coordinate
1433  c1        pop     bc		; Restore counter
1434  05        dec     b		; All rows done?
1435  c22714    jp      nz,#1427	; Do all rows
1438  c9        ret     		; out

;=============================================================
; Display character to screen
; HL = screen coordinates
; DE = character data
; B = number of rows
1439  c5        push    bc		; Preserve counter
143a  1a        ld      a,(de)	; From character set ...
143b  77        ld      (hl),a	; ... to screen
143c  13        inc     de		; Next in character set
143d  012000    ld      bc,#0020	; Next row ...
1440  09        add     hl,bc		; ... on screen
1441  c1        pop     bc		; Restore counter
1442  05        dec     b		; Decrement counter
1443  c23914    jp      nz,#1439	; Do all
1446  c9        ret     		; Out

1447  00        nop     
1448  00        nop     
1449  00        nop     
144a  00        nop     
144b  00        nop     
144c  00        nop     
144d  00        nop     
144e  00        nop     
144f  00        nop     
1450  00        nop     
1451  00        nop     
1452  cd7414    call    #1474
1455  c5        push    bc
1456  e5        push    hl
1457  1a        ld      a,(de)
1458  d304      out     (#04),a
145a  db03      in      a,(#03)	; Read shift-register
145c  2f        cpl     
145d  a6        and     (hl)
145e  77        ld      (hl),a
145f  23        inc     hl
1460  13        inc     de
1461  af        xor     a
1462  d304      out     (#04),a
1464  db03      in      a,(#03)	; Read shift register
1466  2f        cpl     
1467  a6        and     (hl)
1468  77        ld      (hl),a
1469  e1        pop     hl
146a  012000    ld      bc,#0020
146d  09        add     hl,bc
146e  c1        pop     bc
146f  05        dec     b
1470  c25514    jp      nz,#1455
1473  c9        ret     

;=============================================================
; Convert pixel number in HL to screen coordinate and shift amount.
; HL gets screen coordinate.
; Hardware shift-register gets amount.
1474  7d        ld      a,l		; Get X coordinate 
1475  e607      and     #07		; Shift by pixel position
1477  d302      out     (#02),a	; Write shift amount
1479  c3471a    jp      #1a47		; HL = HL/8 + 2000 (screen coordinate)

147c  c5        push    bc
147d  e5        push    hl
147e  7e        ld      a,(hl)
147f  12        ld      (de),a
1480  13        inc     de
1481  23        inc     hl
1482  0d        dec     c
1483  c27e14    jp      nz,#147e
1486  e1        pop     hl
1487  012000    ld      bc,#0020
148a  09        add     hl,bc
148b  c1        pop     bc
148c  05        dec     b
148d  c27c14    jp      nz,#147c
1490  c9        ret     

1491  cd7414    call    #1474
1494  af        xor     a
1495  326120    ld      (#2061),a
1498  c5        push    bc
1499  e5        push    hl
149a  1a        ld      a,(de)
149b  d304      out     (#04),a
149d  db03      in      a,(#03)	; Read shift-register
149f  f5        push    af
14a0  a6        and     (hl)
14a1  caa914    jp      z,#14a9
14a4  3e01      ld      a,#01
14a6  326120    ld      (#2061),a
14a9  f1        pop     af
14aa  b6        or      (hl)
14ab  77        ld      (hl),a
14ac  23        inc     hl
14ad  13        inc     de
14ae  af        xor     a
14af  d304      out     (#04),a
14b1  db03      in      a,(#03)	; Read shift register
14b3  f5        push    af
14b4  a6        and     (hl)
14b5  cabd14    jp      z,#14bd
14b8  3e01      ld      a,#01
14ba  326120    ld      (#2061),a
14bd  f1        pop     af
14be  b6        or      (hl)
14bf  77        ld      (hl),a
14c0  e1        pop     hl
14c1  012000    ld      bc,#0020
14c4  09        add     hl,bc
14c5  c1        pop     bc
14c6  05        dec     b
14c7  c29814    jp      nz,#1498
14ca  c9        ret     

;=============================================================
; Clear a one byte sprite at HL. B=number of rows.
14cb  af        xor     a		; 0
14cc  c5        push    bc		; Preserve BC
14cd  77        ld      (hl),a	; Clear screen byte
14ce  012000    ld      bc,#0020	; Bump HL ...
14d1  09        add     hl,bc		; ... one screen row
14d2  c1        pop     bc		; Restore
14d3  05        dec     b		; All done?
14d4  c2cc14    jp      nz,#14cc	; No ... clear all
14d7  c9        ret     

;=============================================================
;
14d8  3a2520    ld      a,(#2025)	; Player shot flag
14db  fe05      cp      #05		; Alien explosion in progress?
14dd  c8        ret     z		; Yes ... ignore this function
14de  fe02      cp      #02
14e0  c0        ret     nz
14e1  3a2920    ld      a,(#2029)	; Get Y coordinate of player shot
14e4  fed8      cp      #d8		 
14e6  47        ld      b,a
14e7  d23015    jp      nc,#1530	; If less than D8, set shot flag to 03 and ???
14ea  3a0220    ld      a,(#2002)
14ed  a7        and     a
14ee  c8        ret     z
14ef  78        ld      a,b		; Get original Y coordinate
14f0  fece      cp      #ce		
14f2  d27915    jp      nc,#1579	; If less than CE, set 2085 to 3 ???
14f5  c606      add     a,#06
14f7  47        ld      b,a
14f8  3a0920    ld      a,(#2009)
14fb  fe90      cp      #90
14fd  d20415    jp      nc,#1504
1500  b8        cp      b
1501  d23015    jp      nc,#1530
1504  68        ld      l,b
1505  cd6215    call    #1562
1508  3a2a20    ld      a,(#202a)
150b  67        ld      h,a
150c  cd6f15    call    #156f		; Get alien's coordinate
150f  226420    ld      (#2064),hl	; Put it in the exploding-alien descriptor
1512  3e05      ld      a,#05		; Flag alien explosion ...
1514  322520    ld      (#2025),a	; ... in progress
1517  cd8115    call    #1581		; Get descriptor for alien
151a  7e        ld      a,(hl)	; Is alien ...
151b  a7        and     a		; ... alive
151c  ca3015    jp      z,#1530	; No ... skip
151f  3600      ld      (hl),#00	; Make alien invader dead
1521  cd5f0a    call    #0a5f		; ??? Makes alien explosion sound and other things ???
1524  cd3b1a    call    #1a3b		; Load 5 byte sprite descriptor
1527  cdd315    call    #15d3		; Draw explosion sprite on screen
152a  3e10      ld      a,#10		; Initiate alien-explosion  
152c  320320    ld      (#2003),a	; ... timer
152f  c9        ret     		; Out

1530  3e03      ld      a,#03
1532  322520    ld      (#2025),a
1535  c34a15    jp      #154a

1538  210320    ld      hl,#2003	; Decrement explosion ...
153b  35        dec     (hl)		; ... timer
153c  c0        ret     nz		; Not time ... out
153d  2a6420    ld      hl,(#2064)	; Pixel pointer for exploding alien
1540  0610      ld      b,#10		; 16 row pixel
1542  cd2414    call    #1424		; Clear the explosion sprite from the screen
1545  3e04      ld      a,#04
1547  322520    ld      (#2025),a
154a  af        xor     a
154b  320220    ld      (#2002),a
154e  06f7      ld      b,#f7		; Turn off ...
1550  c3dc19    jp      #19dc		; ... alien exploding sound

1553  00        nop 
    
1554  0e00      ld      c,#00
1556  bc        cp      h
1557  d49015    call    nc,#1590
155a  bc        cp      h
155b  d0        ret     nc
155c  c610      add     a,#10
155e  0c        inc     c
155f  c35a15    jp      #155a

1562  3a0920    ld      a,(#2009)
1565  65        ld      h,l
1566  cd5415    call    #1554
1569  41        ld      b,c
156a  05        dec     b
156b  de10      sbc     a,#10
156d  6f        ld      l,a
156e  c9        ret     

156f  3a0a20    ld      a,(#200a)
1572  cd5415    call    #1554
1575  de10      sbc     a,#10
1577  67        ld      h,a
1578  c9        ret     

1579  3e01      ld      a,#01
157b  328520    ld      (#2085),a
157e  c34515    jp      #1545

;=============================================================
; Get pointer into 11 byte descriptor. A = structure number,
; C = byte number (1 based).
; A*11+C-1 -> L
; ActivePlayer -> H
1581  78        ld      a,b		; Hold original
1582  07        rlca    		; *2
1583  07        rlca    		; *4
1584  07        rlca    		; *8
1585  80        add     a,b		; *9
1586  80        add     a,b		; *10
1587  80        add     a,b		; *11
1588  81        add     a,c		; Add offset into descriptor
1589  3d        dec     a		; -1
158a  6f        ld      l,a		; Set LSB of HL
158b  3a6720    ld      a,(#2067)	; Set ...
158e  67        ld      h,a		; ... MSB of HL with active player indicator
158f  c9        ret     

1590  0c        inc     c		; ++C
1591  c610      add     a,#10		; Add 16 to A
1593  fa9015    jp      m,#1590	; Keep going if result is negative
1596  c9        ret     		; Out

1597  3a0d20    ld      a,(#200d)
159a  a7        and     a
159b  c2b715    jp      nz,#15b7
159e  21a43e    ld      hl,#3ea4
15a1  cdc515    call    #15c5
15a4  d0        ret     nc
15a5  06fe      ld      b,#fe
15a7  3e01      ld      a,#01
15a9  320d20    ld      (#200d),a
15ac  78        ld      a,b
15ad  320820    ld      (#2008),a
15b0  3a0e20    ld      a,(#200e)
15b3  320720    ld      (#2007),a
15b6  c9        ret     
;
15b7  212425    ld      hl,#2524
15ba  cdc515    call    #15c5
15bd  d0        ret     nc
15be  cdf118    call    #18f1
15c1  af        xor     a
15c2  c3a915    jp      #15a9
;
15c5  0617      ld      b,#17
15c7  7e        ld      a,(hl)
15c8  a7        and     a
15c9  c26b16    jp      nz,#166b
15cc  23        inc     hl
15cd  05        dec     b
15ce  c2c715    jp      nz,#15c7
15d1  c9        ret     

15d2  00        nop 
    
;=============================================================
; Draw sprite at [DE] to screen at pixel position in HL
; The hardware shift register is used in converting pixel positions
; to screen coordinates.
15d3  cd7414    call    #1474		; Convert pixel number to screen/shift
15d6  e5        push    hl		; Preserve screen coordinate
15d7  c5        push    bc		; Hold for a second
15d8  e5        push    hl		; Hold for a second
15d9  1a        ld      a,(de)	; From sprite data
15da  d304      out     (#04),a	; Write data to shift register
15dc  db03      in      a,(#03)	; Read back shifted amount
15de  77        ld      (hl),a	; Shifted sprite to screen
15df  23        inc     hl		; Adjacent cell
15e0  13        inc     de		; Next in sprite data
15e1  af        xor     a		; 0
15e2  d304      out     (#04),a	; Write 0 to shift register
15e4  db03      in      a,(#03)	; Read back remainder of previous
15e6  77        ld      (hl),a	; Write remainder to adjacent
15e7  e1        pop     hl		; Old screen coordinate
15e8  012000    ld      bc,#0020	; Offset screen ...
15eb  09        add     hl,bc		; ... to next row
15ec  c1        pop     bc		; Restore count
15ed  05        dec     b		; All done?
15ee  c2d715    jp      nz,#15d7	; No ... do all
15f1  e1        pop     hl		; Restore HL
15f2  c9        ret     		; Done

;=============================================================
; Count number of aliens remaining in active game and return count
; 2082 holds the current count
; If only 1, 206b gets a flag of 1
15f3  cd1116    call    #1611		; Get active player descriptor
15f6  010037    ld      bc,#3700	; B=55 aliens to check?
15f9  7e        ld      a,(hl)	; Get byte
15fa  a7        and     a		; Is it a zero?
15fb  caff15    jp      z,#15ff	; Yes ... don't count it
15fe  0c        inc     c		; Count the zeros
15ff  23        inc     hl		; Next slot
1600  05        dec     b		; Count ...
1601  c2f915    jp      nz,#15f9	; ... all alien indicators
1604  79        ld      a,c		; Get the count
1605  328220    ld      (#2082),a	; Hold it
1608  fe01      cp      #01		; Just one?
160a  c0        ret     nz		; No keep going
160b  216b20    ld      hl,#206b	; ???
160e  3601      ld      (hl),#01	; ???
1610  c9        ret     		; Out

;=============================================================
; Set HL with 0000 if player 1 is active
; or 0100 if player 2 is active
1611  2e00      ld      l,#00		; Byte boundary
1613  3a6720    ld      a,(#2067)	; Active player number
1616  67        ld      h,a		; Set HL to data
1617  c9        ret     		; Done

;=============================================================
; Initiate player fire if button is pressed.
; Demo commands are parsed here if in demo mode
1618  3a1520    ld      a,(#2015)	; Is there an active player?
161b  feff      cp      #ff		; FF = alive
161d  c0        ret     nz		; Player has been shot - no firing
161e  211020    ld      hl,#2010
1621  7e        ld      a,(hl)
1622  23        inc     hl
1623  46        ld      b,(hl)
1624  b0        or      b
1625  c0        ret     nz
1626  3a2520    ld      a,(#2025)	; Does the player have ...
1629  a7        and     a		; ... a shot on the screen?
162a  c0        ret     nz		; Yes ... ignore
162b  3aef20    ld      a,(#20ef)	; Demo play flag
162e  a7        and     a		; Is demo playing?
162f  ca5216    jp      z,#1652	; Yes ... 
1632  3a2d20    ld      a,(#202d)	; Is fire button being held down?
1635  a7        and     a		; ...
1636  c24816    jp      nz,#1648	; Yes ... wait for bounce
1639  cdc017    call    #17c0		; Read active player controls
163c  e610      and     #10		; Fire-button pressed?
163e  c8        ret     z		; No ... out
163f  3e01      ld      a,#01		; Flag
1641  322520    ld      (#2025),a	; Flag shot active
1644  322d20    ld      (#202d),a	; Flag that fire button is down
1647  c9        ret     		; Out
1648  cdc017    call    #17c0		; Read active player controls
164b  e610      and     #10		; Fire-button pressed?
164d  c0        ret     nz		; Yes ... ignore
164e  322d20    ld      (#202d),a	; Else ... clear flag
1651  c9        ret     		; Out
; Handle demo (constant fire, parse demo commands)
1652  212520    ld      hl,#2025	; Demo fires ...
1655  3601      ld      (hl),#01	; ... constantly
1657  2aed20    ld      hl,(#20ed)	; Demo command bufer
165a  23        inc     hl		; Next position
165b  7d        ld      a,l		; Command buffer ...
165c  fe7e      cp      #7e		; ... wraps around
165e  da6316    jp      c,#1663	; ... Buffer from 1F74 to 1F7E
1661  2e74      ld      l,#74		; ... overflow
1663  22ed20    ld      (#20ed),hl	; Next demo command
1666  7e        ld      a,(hl)	; Get next command
1667  321d20    ld      (#201d),a	; Set command for movement
166a  c9        ret     		; Done

166b  37        scf     
166c  c9        ret     

166d  af        xor     a
166e  cd8b1a    call    #1a8b
1671  cd1019    call    #1910
1674  3600      ld      (hl),#00
1676  cdca09    call    #09ca
1679  23        inc     hl
167a  11f520    ld      de,#20f5
167d  1a        ld      a,(de)
167e  be        cp      (hl)
167f  1b        dec     de
1680  2b        dec     hl
1681  1a        ld      a,(de)
1682  ca8b16    jp      z,#168b
1685  d29816    jp      nc,#1698
1688  c38f16    jp      #168f
168b  be        cp      (hl)
168c  d29816    jp      nc,#1698
168f  7e        ld      a,(hl)
1690  12        ld      (de),a
1691  13        inc     de
1692  23        inc     hl
1693  7e        ld      a,(hl)
1694  12        ld      (de),a
1695  cd5019    call    #1950
1698  3ace20    ld      a,(#20ce)	; Number of players
169b  a7        and     a		; Is this a single player game?
169c  cac916    jp      z,#16c9	; Yes ... short message
169f  210328    ld      hl,#2803	; Screen coordinates
16a2  11a61a    ld      de,#1aa6	; "GAME OVER PLAYER< >"
16a5  0e14      ld      c,#14		; 20 characters
16a7  cd930a    call    #0a93		; Print message
16aa  25        dec     h		; Back up ...
16ab  25        dec     h		; ... to player indicator
16ac  061b      ld      b,#1b		; "1"
16ae  3a6720    ld      a,(#2067)	; Player number
16b1  0f        rrca    		; Is this player 1?
16b2  dab716    jp      c,#16b7	; Yes ... keep the digit
16b5  061c      ld      b,#1c		; Else ... set digit 2
16b7  78        ld      a,b		; To A
16b8  cdff08    call    #08ff		; Print player number
16bb  cdb10a    call    #0ab1		; Short delay
16be  cde718    call    #18e7
16c1  7e        ld      a,(hl)
16c2  a7        and     a
16c3  cac916    jp      z,#16c9
16c6  c3ed02    jp      #02ed
;
16c9  21182d    ld      hl,#2d18	; Screen coordinates
16cc  11a61a    ld      de,#1aa6	; "GAME OVER PLAYER< >"
16cf  0e0a      ld      c,#0a		; Just the "GAME OVER" part
16d1  cd930a    call    #0a93		; Print message
16d4  cdb60a    call    #0ab6		; Long delay
16d7  cdd609    call    #09d6		; Clear center window
16da  af        xor     a
16db  32ef20    ld      (#20ef),a
16de  d305      out     (#05),a	; Sound
16e0  cdd119    call    #19d1		; Set 20E9 flag to 1
16e3  c3890b    jp      #0b89

16e6  310024    ld      sp,#2400	; Reset stack
16e9  fb        ei      		; Enable interrupts
16ea  af        xor     a		; Flag ...
16eb  321520    ld      (#2015),a	; ... player is shot
16ee  cdd814    call    #14d8
16f1  0604      ld      b,#04		; Player hit ...
16f3  cdfa18    call    #18fa		; ... sound
16f6  cd590a    call    #0a59		; Has flag been set?
16f9  c2ee16    jp      nz,#16ee	; No ... wait for the flag
16fc  cdd719    call    #19d7		
16ff  210127    ld      hl,#2701
1702  cdfa19    call    #19fa
1705  af        xor     a
1706  cd8b1a    call    #1a8b
1709  06fb      ld      b,#fb
170b  c36b19    jp      #196b
170e  cdca09    call    #09ca
1711  23        inc     hl
1712  7e        ld      a,(hl)
1713  11b81c    ld      de,#1cb8
1716  21a11a    ld      hl,#1aa1	;
1719  0e04      ld      c,#04
171b  47        ld      b,a
171c  1a        ld      a,(de)
171d  b8        cp      b
171e  d22717    jp      nc,#1727
1721  23        inc     hl
1722  13        inc     de
1723  0d        dec     c
1724  c21c17    jp      nz,#171c
1727  7e        ld      a,(hl)
1728  32cf20    ld      (#20cf),a
172b  c9        ret     

;=============================================================
; Shot sound on or off depending on 2025
172c  3a2520    ld      a,(#2025)	; Player shot flag
172f  fe00      cp      #00		; Active shot?
1731  c23917    jp      nz,#1739	; Yes ... go
1734  06fd      ld      b,#fd		; Sound mask
1736  c3dc19    jp      #19dc		; Mask off sound
;
1739  0602      ld      b,#02		; Sound bit
173b  c3fa18    jp      #18fa		; OR on sound


173e  00        nop     
173f  00        nop     
1740  219b20    ld      hl,#209b
1743  35        dec     (hl)
1744  cc6d17    call    z,#176d
1747  3a6820    ld      a,(#2068)
174a  a7        and     a
174b  ca6d17    jp      z,#176d
174e  219620    ld      hl,#2096
1751  35        dec     (hl)
1752  c0        ret     nz

1753  219820    ld      hl,#2098
1756  7e        ld      a,(hl)
1757  d305      out     (#05),a	; Sound
1759  3a8220    ld      a,(#2082)	; Number of aliens on active screen
175c  a7        and     a		; Is is zero?
175d  ca6d17    jp      z,#176d
1760  2b        dec     hl
1761  7e        ld      a,(hl)
1762  2b        dec     hl
1763  77        ld      (hl),a
1764  2b        dec     hl
1765  3601      ld      (hl),#01
1767  3e04      ld      a,#04
1769  329b20    ld      (#209b),a
176c  c9        ret     

176d  3a9820    ld      a,(#2098)
1770  e630      and     #30
1772  d305      out     (#05),a	; Sound
1774  c9        ret     

;=============================================================
;  ??? Called from game loop 
1775  3a9520    ld      a,(#2095)
1778  a7        and     a
1779  caaa17    jp      z,#17aa
177c  21111a    ld      hl,#1a11
177f  11211a    ld      de,#1a21
1782  3a8220    ld      a,(#2082)
1785  be        cp      (hl)
1786  d28e17    jp      nc,#178e
1789  23        inc     hl
178a  13        inc     de
178b  c38517    jp      #1785
178e  1a        ld      a,(de)
178f  329720    ld      (#2097),a
1792  219820    ld      hl,#2098
1795  7e        ld      a,(hl)
1796  e630      and     #30
1798  47        ld      b,a
1799  7e        ld      a,(hl)
179a  e60f      and     #0f
179c  07        rlca    
179d  fe10      cp      #10
179f  c2a417    jp      nz,#17a4
17a2  3e01      ld      a,#01
17a4  b0        or      b
17a5  77        ld      (hl),a
17a6  af        xor     a		; Clear ...
17a7  329520    ld      (#2095),a	; ... ??? something to do with shot
17aa  219920    ld      hl,#2099	; Sound timer for award extra ship
17ad  35        dec     (hl)		; Time ?
17ae  c0        ret     nz		; No ... leave sound playing
17af  06ef      ld      b,#ef		; Turn off bit set with #10 (award extra ship)
17b1  c3dc19    jp      #19dc		; Mask it out

;=============================================================
17b4  06ef      ld      b,#ef
17b6  219820    ld      hl,#2098
17b9  7e        ld      a,(hl)
17ba  a0        and     b
17bb  77        ld      (hl),a
17bc  d305      out     (#05),a	; Sound
17be  c9        ret     

17bf  00        nop     

;=============================================================
; Read control inputs for active player
17c0  3a6720    ld      a,(#2067)	; Get active player
17c3  0f        rrca    		; Test player
17c4  d2ca17    jp      nc,#17ca	; Player 2 ... read port 2
17c7  db01      in      a,(#01)	; Player 1 ... read port 1
17c9  c9        ret     		; Out
17ca  db02      in      a,(#02)	; Get controls for player 2
17cc  c9        ret     		; Out

;=============================================================
; Check and handle TILT
17cd  db02      in      a,(#02)	; Read input port
17cf  e604      and     #04		; Tilt?
17d1  c8        ret     z		; No tilt ... return
17d2  3a9a20    ld      a,(#209a)	; Already in TILT handle?
17d5  a7        and     a		; 1 = yes
17d6  c0        ret     nz		; Yes ... ignore it now
17d7  310024    ld      sp,#2400	; Reset stack
17da  0604      ld      b,#04		; Do this 4 times
17dc  cdd609    call    #09d6		; Clear center window
17df  05        dec     b		; All done?
17e0  c2dc17    jp      nz,#17dc	; No ... do again
17e3  3e01      ld      a,#01		; Flag ...
17e5  329a20    ld      (#209a),a	; ... handling TILT
17e8  cdd719    call    #19d7		
17eb  fb        ei      		; Re-enable interrupts
17ec  11bc1c    ld      de,#1cbc	; Message "TILT"
17ef  211630    ld      hl,#3016	; Center of screen
17f2  0e04      ld      c,#04		; Four letters
17f4  cd930a    call    #0a93		; Print "TILT"
17f7  cdb10a    call    #0ab1		; Short delay
17fa  af        xor     a		; Zero
17fb  329a20    ld      (#209a),a	; TILT handle over
17fe  329320    ld      (#2093),a
1801  c3c916    jp      #16c9		; Handle game over for player

;=============================================================
; Called from game loop
1804  218420    ld      hl,#2084
1807  7e        ld      a,(hl)
1808  a7        and     a
1809  ca0707    jp      z,#0707
180c  23        inc     hl
180d  7e        ld      a,(hl)
180e  a7        and     a
180f  c0        ret     nz
1810  0601      ld      b,#01
1812  c3fa18    jp      #18fa
1815  211028    ld      hl,#2810
1818  11a31c    ld      de,#1ca3
181b  0e15      ld      c,#15
181d  cdf308    call    #08f3
1820  3e0a      ld      a,#0a
1822  326c20    ld      (#206c),a
1825  01be1d    ld      bc,#1dbe
1828  cd5618    call    #1856
182b  da3718    jp      c,#1837
182e  cd4418    call    #1844
1831  c32818    jp      #1828
1834  cdb10a    call    #0ab1
1837  01cf1d    ld      bc,#1dcf
183a  cd5618    call    #1856
183d  d8        ret     c
183e  cd4c18    call    #184c
1841  c33a18    jp      #183a
;
1844  c5        push    bc
1845  0610      ld      b,#10
1847  cd3914    call    #1439
184a  c1        pop     bc
184b  c9        ret     
;
184c  c5        push    bc
184d  3a6c20    ld      a,(#206c)
1850  4f        ld      c,a
1851  cd930a    call    #0a93
1854  c1        pop     bc
1855  c9        ret     

;=============================================================
1856  0a        ld      a,(bc)
1857  feff      cp      #ff
1859  37        scf     
185a  c8        ret     z

185b  6f        ld      l,a
185c  03        inc     bc
185d  0a        ld      a,(bc)
185e  67        ld      h,a
185f  03        inc     bc
1860  0a        ld      a,(bc)
1861  5f        ld      e,a
1862  03        inc     bc
1863  0a        ld      a,(bc)
1864  57        ld      d,a
1865  03        inc     bc
1866  a7        and     a
1867  c9        ret     

1868  21c220    ld      hl,#20c2
186b  34        inc     (hl)
186c  23        inc     hl
186d  4e        ld      c,(hl)
186e  cdd901    call    #01d9
1871  47        ld      b,a
1872  3aca20    ld      a,(#20ca)
1875  b8        cp      b
1876  ca9818    jp      z,#1898
1879  3ac220    ld      a,(#20c2)
187c  e604      and     #04
187e  2acc20    ld      hl,(#20cc)
1881  c28818    jp      nz,#1888
1884  113000    ld      de,#0030
1887  19        add     hl,de
1888  22c720    ld      (#20c7),hl
188b  21c520    ld      hl,#20c5
188e  cd3b1a    call    #1a3b
1891  eb        ex      de,hl
1892  c3d315    jp      #15d3
1895  00        nop     
1896  00        nop     
1897  00        nop     
1898  3e01      ld      a,#01
189a  32cb20    ld      (#20cb),a
189d  c9        ret     

189e  215020    ld      hl,#2050
18a1  11c01b    ld      de,#1bc0
18a4  0610      ld      b,#10
18a6  cd321a    call    #1a32
18a9  3e02      ld      a,#02
18ab  328020    ld      (#2080),a
18ae  3eff      ld      a,#ff
18b0  327e20    ld      (#207e),a
18b3  3e04      ld      a,#04
18b5  32c120    ld      (#20c1),a
18b8  3a5520    ld      a,(#2055)
18bb  e601      and     #01
18bd  cab818    jp      z,#18b8
18c0  3a5520    ld      a,(#2055)
18c3  e601      and     #01
18c5  c2c018    jp      nz,#18c0
18c8  211133    ld      hl,#3311
18cb  3e26      ld      a,#26
18cd  00        nop     
18ce  cdff08    call    #08ff
18d1  c3b60a    jp      #0ab6

;=============================================================
; Initializiation comes here
;
18d4  310024    ld      sp,#2400	; Set stack pointer just below screen
18d7  0600      ld      b,#00		; Count 256 bytes
18d9  cde601    call    #01e6		; Copy ROM to RAM
18dc  cd5619    call    #1956		; Print scores and credits
18df  3e08      ld      a,#08
18e1  32cf20    ld      (#20cf),a
18e4  c3ea0a    jp      #0aea

;=============================================================
??? See 1910
18e7  3a6720    ld      a,(#2067)	; Player indicator
18ea  21e720    ld      hl,#20e7	; Strange descriptor
18ed  0f        rrca    
18ee  d0        ret     nc
18ef  23        inc     hl
18f0  c9        ret     

18f1  0602      ld      b,#02
18f3  3a8220    ld      a,(#2082)
18f6  3d        dec     a
18f7  c0        ret     nz
18f8  04        inc     b
18f9  c9        ret     

;=============================================================
; Add in bit for sound
18fa  3a9420    ld      a,(#2094)
18fd  b0        or      b
18fe  329420    ld      (#2094),a
1901  d303      out     (#03),a	; Sound
1903  c9        ret     

1904  210022    ld      hl,#2200
1907  c3c301    jp      #01c3

;=============================================================
; Called from main game loop (collision detection for player shot ???)
190a  cdd814    call    #14d8
190d  c39715    jp      #1597

;=============================================================
; ??? See 18E7
1910  21e720    ld      hl,#20e7
1913  3a6720    ld      a,(#2067)	; Player 1 or 2 
1916  0f        rrca    		; Test
1917  d8        ret     c		; Return if player 1
1918  23        inc     hl		; Bump to next ???
1919  c9        ret     		; Return

;=============================================================
; Print score header " SCORE<1> HI-SCORE SCORE<2> "
191a  0e1c      ld      c,#1c		; 28 bytes in message
191c  211e24    ld      hl,#241e	; Screen coordinates
191f  11e41a    ld      de,#1ae4	; Score header message
1922  c3f308    jp      #08f3		; Print score header

1925  21f820    ld      hl,#20f8	; Player 1 score descriptor
1928  c33119    jp      #1931		; Print score

192b  21fc20    ld      hl,#20fc	; Player 2 score descriptor
192e  c33119    jp      #1931		; Print score

;=============================================================
; Print score.
; HL = descriptor
1931  5e        ld      e,(hl)	; Get score LSB
1932  23        inc     hl		; Next
1933  56        ld      d,(hl)	; Get score MSB
1934  23        inc     hl		; Next
1935  7e        ld      a,(hl)	; Get coordinate LSB
1936  23        inc     hl		; Next
1937  66        ld      h,(hl)	; Get coordiante MSB
1938  6f        ld      l,a		; Set LSB
1939  c3ad09    jp      #09ad		; Print 4 digits in DE

;=============================================================
; Print message "CREDIT "
193c  0e07      ld      c,#07		; 7 bytes in message
193e  210135    ld      hl,#3501	; Screen coordinates
1941  11a91f    ld      de,#1fa9	; Message = "CREDIT "
1944  c3f308    jp      #08f3

;=============================================================
; Display number of credits on screen
1947  3aeb20    ld      a,(#20eb)	; Number of credits
194a  21013c    ld      hl,#3c01	; Screen coordinates
194d  c3b209    jp      #09b2		; Character to screen

;=============================================================
1950  21f420    ld      hl,#20f4	; Hi Score descriptor
1953  c33119    jp      #1931		; Print Hi-Score

;=============================================================
; Print scores (with header) and credits (with label)
1956  cd5c1a    call    #1a5c		; Clear 2 rows on the screen
1959  cd1a19    call    #191a		; Print score header
195c  cd2519    call    #1925		; Print player 1 score
195f  cd2b19    call    #192b		; Print player 2 score
1962  cd5019    call    #1950		; Print hi score
1965  cd3c19    call    #193c		; Print credit lable
1968  c34719    jp      #1947		; Number of credits

;=============================================================
196b  cddc19    call    #19dc
196e  c37116    jp      #1671
1971  3e01      ld      a,#01
1973  326d20    ld      (#206d),a
1976  c3e616    jp      #16e6

1979  cdd719    call    #19d7		; 
197c  cd4719    call    #1947		; Display number of credits on screen
197f  c33c19    jp      #193c		; Print message "CREDIT"

1982  32c120    ld      (#20c1),a
1985  c9        ret     

1986  8b        adc     a,e
1987  19        add     hl,de
1988  c3d609    jp      #09d6

;=============================================================
; Print "*TAITO CORPORATION*"
198b  210328    ld      hl,#2803	; Screen coordinates
198e  11be19    ld      de,#19be	; Message "*TAITO CORPORATION*"
1991  0e13      ld      c,#13		; Messgae length
1993  c3f308    jp      #08f3		; Print message

1996  00        nop     
1997  00        nop     
1998  00        nop     
1999  00        nop     
199a  3a1e20    ld      a,(#201e)
199d  a7        and     a
199e  c2ac19    jp      nz,#19ac
19a1  db01      in      a,(#01)
19a3  e676      and     #76
19a5  d672      sub     #72
19a7  c0        ret     nz
19a8  3c        inc     a
19a9  321e20    ld      (#201e),a
19ac  db01      in      a,(#01)
19ae  e676      and     #76
19b0  fe34      cp      #34
19b2  c0        ret     nz

19b3  211b2e    ld      hl,#2e1b	; Coordinate
19b6  11f70b    ld      de,#0bf7	; Message = "TAITO COP"
19b9  0e09      ld      c,#09		; Message length
19bb  c3f308    jp      #08f3		; Print message

; Message = "*TAITO CORPORATION*"
19be  28130008130e26020e110f0e11      
19cb  0013080e0d28

;=============================================================
; Set 20E9 flag
19d1  3e01      ld     a,#01		; Set 20e9
19d3  32e920    ld     (#20e9),a	; 
19d6	          ret			; 

;=============================================================
; Clear 20E9 flag
19d7  af        xor     a		; Clear 20e9
19d8  c3d319    jp      #19d3		; 

19db  00        nop    
; 

;=============================================================
; Turn off bit in sound port
19dc  3a9420    ld      a,(#2094)
19df  a0        and     b
19e0  329420    ld      (#2094),a
19e3  d303      out     (#03),a	; Sound
19e5  c9        ret     

;=============================================================
; Show ships remaining in hold for the player
19e6  210127    ld      hl,#2701	; Screen coordinates
19e9  cafa19    jp      z,#19fa	; None in reserve ... skip display 
; Draw line of ships
19ec  11601c    ld      de,#1c60	; Player sprite
19ef  0610      ld      b,#10		; 16 rows
19f1  4f        ld      c,a		; Hold count
19f2  cd3914    call    #1439		; Display 1byte sprite to screen
19f5  79        ld      a,c		; Restore remaining
19f6  3d        dec     a		; All done?
19f7  c2ec19    jp      nz,#19ec	; No ... keep going
; Clear remainder of line
19fa  0610      ld      b,#10		; 16 rows
19fc  cdcb14    call    #14cb		; Clear 1byte sprite at HL
19ff  7c        ld      a,h		; Get Y coordinate
1a00  fe35      cp      #35		; At edge?
1a02  c2fa19    jp      nz,#19fa	; No ... do all
1a05  c9        ret     		; Out

;=============================================================
; Compare upper bit at [DE] with upper bit at [2072]
; CF=0 if they are different. CF=1 if they are the same.
1a06  217220    ld      hl,#2072
1a09  46        ld      b,(hl)
1a0a  1a        ld      a,(de)
1a0b  e680      and     #80
1a0d  a8        xor     b
1a0e  c0        ret     nz
1a0f  37        scf     
1a10  c9        ret     

1a11  322b241c16110d0a0807060504030201
1a21  342e27221c181513100e0d0c0b090705        
1a31  ff        

;=============================================================
; Copy from [DE] to [HL] (b bytes)
1a32  1a        ld      a,(de)	; Copy from [DE] to ...
1a33  77        ld      (hl),a	; ... [HL]
1a34  23        inc     hl		;
1a35  13        inc     de		;
1a36  05        dec     b		; Count in B
1a37  c2321a    jp      nz,#1a32	; Do all
1a3a  c9        ret     		; And return

;=============================================================
; Load 5 bytes from [HL] and hold them in this order:
; edlhb
1a3b  5e        ld      e,(hl)
1a3c  23        inc     hl
1a3d  56        ld      d,(hl)
1a3e  23        inc     hl
1a3f  7e        ld      a,(hl)
1a40  23        inc     hl
1a41  4e        ld      c,(hl)
1a42  23        inc     hl
1a43  46        ld      b,(hl)
1a44  61        ld      h,c
1a45  6f        ld      l,a
1a46  c9        ret     

;=============================================================
; Convert from pixel number to screen coordinates (without shift)
; Shift HL right 3 bits (clearing the top 2 bits)
; and set the third bit from the left.
1a47  c5        push    bc
1a48  0603      ld      b,#03
1a4a  7c        ld      a,h
1a4b  1f        rra     
1a4c  67        ld      h,a
1a4d  7d        ld      a,l
1a4e  1f        rra     
1a4f  6f        ld      l,a
1a50  05        dec     b
1a51  c24a1a    jp      nz,#1a4a
1a54  7c        ld      a,h
1a55  e63f      and     #3f
1a57  f620      or      #20
1a59  67        ld      h,a
1a5a  c1        pop     bc
1a5b  c9        ret     

;=============================================================
; Clear 2 rows on the screen (2 vertical lines when rotated)
1a5c  210024    ld      hl,#2400	; Screen coordinate
1a5f  3600      ld      (hl),#00	; Clear it
1a61  23        inc     hl		; Next byte
1a62  7c        ld      a,h		; Have we done ...
1a63  fe40      cp      #40		; ... 2 rows?
1a65  c25f1a    jp      nz,#1a5f	; No ... keep going
1a68  c9        ret     		; Out

;=============================================================
; Logically OR a sprite onto the screen
; DE = sprite
; HL = screen
; C = bytes per row
; B = number of rows
1a69  c5        push    bc		; Preserve BC
1a6a  e5        push    hl		; Hold for a bit
1a6b  1a        ld      a,(de)	; From sprite
1a6c  b6        or      (hl)		; OR with screen
1a6d  77        ld      (hl),a	; Back to screen
1a6e  13        inc     de		; Next sprite
1a6f  23        inc     hl		; Next on screen
1a70  0d        dec     c		; Row done?
1a71  c26b1a    jp      nz,#1a6b	; No ... do entire row
1a74  e1        pop     hl		; Original start
1a75  012000    ld      bc,#0020	; Bump HL by ...
1a78  09        add     hl,bc		; ... one screen row
1a79  c1        pop     bc		; Restore
1a7a  05        dec     b		; Row counter
1a7b  c2691a    jp      nz,#1a69	; Do all rows
1a7e  c9        ret     

;=============================================================
; Remove a ship from the players stash and update the
; hold indicators on the screen.
1a7f  cd2e09    call    #092e		; Get last byte from player data
1a82  a7        and     a		; Is it 0?
1a83  c8        ret     z		; Skip
1a84  f5        push    af		; Preserve number remaining
1a85  3d        dec     a		; Remove a ship from the stash
1a86  77        ld      (hl),a	; New number of ships
1a87  cde619    call    #19e6		; Draw the line of ships
1a8a  f1        pop     af		; Restore number
1a8b  210125    ld      hl,#2501	; Screen coordinates
1a8e  e60f      and     #0f		; Make sure it is a digit
1a90  c3c509    jp      #09c5		; Print number remaining

;==========================================================
; Looks like data from here down

1a93  0000	; ? Never accessed ?

1a95  0000ffb8fe201c109e00201c

1aa1  30100b08
1aa5  07
;
; Message = "GAME OVER PLAYER< >"
1aa6  06000c04260e15041126260f       
1ab2  0b00180411242625       
;
; Message = "1 OR 2PLAYERS BUTTON"
1aba  1b260e11261c0f0b001804
1ac5  111226011413130e0d
; 
1ace  26	; Comment on this (both messages are 20 bytes)
;
; Message = "ONLY 1PLAYER BUTTON "
1acf  0e0d0b18261b0f0b001804112626
1add  011413130e0d26
;
; 28 bytes in message = " SCORE<1> HI-SCORE SCORE<2>"
;
1ae4  2612020e1104241b25260708        
1af0  3f12020e11042612020e1104        
1afc  241c2526
;
; Coppied to RAM (2000) as initialization
1b00  01
1b01  00
1b02  00
1b03  1000
1b05  00
1b06  00
1b07  00
1b08  02
1b09  78
1b0a  3878
1b0c  3800
1b0e  f8
1b0f  00
;
1b10  00
1b11  80
1b12  00
1b13  8e
1b14  02
1b15  ff
1b16  05
1b17  0c
;
; Active player descriptor
1b18  601c	; Sprite location (1C60)
1b1a  2030	; Initial pixel location
1b1c  10	; 16 bytes in sprite
;
1b1d  01
1b1e  00
1b1f  00
1b20  00
1b21  00
1b22  00
1b23  bb
1b24  03
;
; Active player shot descriptor
1b25  00	; 00 if available, various others if not
1b26  10901c28300104
;
1b2d  00
1b2e  ff
1b2f  ff
1b30  00
1b31  00
1b32  02
1b33  76
1b34  04
1b35  00
1b36  00
1b37  00
1b38  00
1b39  00
1b3a  04
1b3b  ee1c
1b3d  00
1b3e  00
1b3f  03
1b40  00
1b41  00
1b42  00
1b43  b6
1b44  04
1b45  00
1b46  00
1b47  01001d
1b4a  04
1b4b  e21c00
1b4e  00
1b4f  03
1b50  00
1b51  00
1b52  00
1b53  82
1b54  0600
1b56  00
1b57  01061d
1b5a  04
1b5b  d0
1b5c  1c
1b5d  00
1b5e  00
1b5f  03
1b60  ff
1b61  00
;
; Exploding alien descriptor
1b62  c01c	; Sprite
1b64  0000	; Filled in
1b66  10	; 16 bytes
;
1b67  21
1b68  010030
1b6b  00
1b6c  12
1b6d  00
1b6e  00
1b6f  00
1b70  0f
1b71  0b
1b72  00
1b73  1826
1b75  0f
1b76  0b
1b77  00
1b78  1804
1b7a  11241b
1b7d  25
1b7e  fc0001
1b81  ff
1b82  ff
;
1b83  00
1b84  00
1b85  00 
1b86  20
;
1b87  64
1b88  1d
1b89  d0
1b8a  29
1b8b  18
;
1b8c  02
1b8d  54
1b8e  1d
1b8f  00
1b90  08
1b91  00
1b92  0600
1b94  00
1b95  014000
1b98  010000
1b9b  109e
1b9d  00
1b9e  201c
1ba0  00
1ba1  03
1ba2  04
1ba3  78
1ba4  14
1ba5  13
1ba6  08
1ba7  1a
1ba8  3d
1ba9  68
1baa  fcfc68
1bad  3d
1bae  1a
1baf  00
1bb0  00
1bb1  00
1bb2  01b898
1bb5  a0
1bb6  1b
1bb7  10ff
1bb9  00
1bba  a0
1bbb  1b
1bbc  00
1bbd  00
1bbe  00
1bbf  00
;
1bc0  00
1bc1  1000
1bc3  0e05
1bc5  00
1bc6  00
1bc7  00
1bc8  00
1bc9  00
1bca  07
1bcb  d0
1bcc  1c
1bcd  c8
1bce  9b
1bcf  03
1bd0  00
1bd1  00
1bd2  03
1bd3  04
1bd4  78
1bd5  14
1bd6  0b
1bd7  19
1bd8  3a6dfa
1bdb  fa6d3a
1bde  19
1bdf  00
1be0  00
1be1  00
1be2  00
1be3  00
1be4  00
1be5  00
1be6  00
1be7  00
1be8  00
1be9  010000
1bec  01
;
1bed  741f		; Pointer to demo commands
;
1bef  00
1bf0  80
1bf1  00
1bf2  00
1bf3  00
1bf4  00001c2f  ; Hi-Score descriptor
1bf8  00001c27  ; Player 1 score descriptor
1bfc  00001c39  ; Player 2 score descriptor

; Alien sprite type A,B, and C at positions 0
1c00  000039797a6eecfafaec6e7a79390000
1c10  000000781dbe6c3c3c3c6cbe1d780000
1c20  00000000193a6dfafa6d3a1900000000

; Alien sprite type A,B, and C at positions 1
1c30  0000387a7f6decfafaec6d7f7a380000
1c40  0000000e18be6d3d3c3d6dbe180e0000
1c50  000000001a3d68fcfc683d1a00000000

; Player sprite    
1c60  00000f1f1f1f1f7fff7f1f1f1f1f0f00

1c70  00
1c71  04
1c72  011303
1c75  07
1c76  b3
1c77  0f
1c78  2f
1c79  03
1c7a  2f
1c7b  49
1c7c  04
1c7d  03
1c7e  00
1c7f  014008
1c82  05
1c83  a3
1c84  0a
1c85  03
1c86  5b
1c87  0f
1c88  27
1c89  27
1c8a  0b
1c8b  4b
1c8c  40
1c8d  84
1c8e  11480f
1c91  99
1c92  3c
1c93  7e
1c94  3d
1c95  bc
1c96  3e7c
1c98  99
1c99  27
1c9a  1b
1c9b  1a
1c9c  260f 
1c9e  0e08
1ca0  0d
1ca1  13
1ca2  12
1ca3  2812
1ca5  02
1ca6  0e11
1ca8  04
1ca9  2600
1cab  03
1cac  15
1cad  00
1cae  0d
1caf  02 
1cb0  04
1cb1  2613
1cb3  00
1cb4  010b04
1cb7  28
;
1cb8  02102030
;
; Message = "TILT"
1cbc  13080b13        
;
; Alien exploding sprite
1cc0  00084922148142004281142249080000
;
1cd0  44
1cd1  aa
1cd2  1088
1cd4  54
1cd5  2210aa
1cd8  44
1cd9  225488
1cdc  4a
1cdd  15
1cde  be
1cdf  3f
1ce0  5e
1ce1  25
1ce2  04
1ce3  fc0410
1ce6  fc1020
1ce9  fc2080
1cec  fc8000
1cef  fe00
1cf1  24
1cf2  fe12
1cf4  00
1cf5  fe00
1cf7  48
1cf8  fe90
1cfa  0f
1cfb  0b
1cfc  00
1cfd  29
1cfe  00
1cff  00
1d00  010701
1d03  010104
1d06  0b
1d07  010603
1d0a  01010b
1d0d  09
1d0e  02
1d0f  08
1d10  02
1d11  0b
1d12  04
1d13  07
1d14  0a  
1d15  05
1d16  02
1d17  05
1d18  04
1d19  0607
1d1b  08
1d1c  0a
1d1d  060a
1d1f  03
1d20  ff
1d21  0f
1d22  ff
1d23  1f
1d24  ff
1d25  3f
1d26  ff
1d27  7f
1d28  ff
1d29  ff
1d2a  fcfff8
1d2d  ff
1d2e  f0
1d2f  ff
1d30  f0
1d31  ff
1d32  f0
1d33  ff
1d34  f0
1d35  ff
1d36  f0
1d37  ff
1d38  f0
1d39  ff
1d3a  f0
1d3b  ff
1d3c  f8
1d3d  ff
1d3e  fcffff
1d41  ff
1d42  ff
1d43  ff
1d44  ff
1d45  7f
1d46  ff
1d47  3f
1d48  ff
1d49  1f
1d4a  ff
1d4b  0f
1d4c  05
1d4d  1015
1d4f  3094
1d51  97
1d52  9a
1d53  9d
1d54  1005
1d56  05
1d57  1015
1d59  1010
1d5b  05
1d5c  3010
1d5e  1010
1d60  05
1d61  15
1d62  1005
1d64  00
1d65  00
1d66  00
1d67  00
1d68  04
1d69  0c
1d6a  1e37
1d6c  3e7c
1d6e  74
1d6f  7e
1d70  7e
1d71  74
1d72  7c
1d73  3e37
1d75  1e0c 
1d77  04
1d78  00
1d79  00
1d7a  00
1d7b  00
1d7c  00
1d7d  2200a5
1d80  40
1d81  08
1d82  98
1d83  3d
1d84  b6
1d85  3c
1d86  361d
1d88  1048
1d8a  62
1d8b  b6
1d8c  1d
1d8d  98
1d8e  08
1d8f  42
1d90  90
1d91  08
1d92  00
1d93  00
1d94  261f
1d96  1a   
1d97  1b
1d98  1a
1d99  1a
1d9a  1b
1d9b  1f
1d9c  1a
1d9d  1d
1d9e  1a
1d9f  1a

1da0  10  
1da1  20  
1da2  30  
1da3  60  
1da4  50  
1da5  48  
1da6  48  
1da7  48  
1da8  40
1da9  40
1daa  40
1dab  0f
1dac  0b
1dad  00
1dae  1812
1db0  0f
1db1  00
1db2  02
1db3  04
1db4  2626
1db6  08
1db7  0d
1db8  15
1db9  00
1dba  03
1dbb  04
1dbc  11120e
1dbf  2c
1dc0  68
1dc1  1d
1dc2  0c
1dc3  2c
1dc4  201c
1dc6  0a
1dc7  2c
1dc8  40
1dc9  1c
1dca  08
1dcb  2c
1dcc  00
1dcd  1c
1dce  ff
1dcf  0e2e
1dd1  e0
1dd2  1d
1dd3  0c
1dd4  2eea
1dd6  1d
1dd7  0a
1dd8  2ef4
1dda  1d
1ddb  08
1ddc  2e99
1dde  1c
1ddf  ff
1de0  27
1de1  3826
1de3  0c
1de4  1812
1de6  13
1de7  04
1de8  111827
1deb  1d
1dec  1a
1ded  260f
1def  0e08
1df1  0d
1df2  13
1df3  12
1df4  27
1df5  1c
1df6  1a
1df7  260f
1df9  0e08
1dfb  0d
1dfc  13
1dfd  12
1dfe  00
1dff  00

;=============================================================
; 8 byte sprites 
1e00  001f2444241f0000 ; 00:"A"
1e08  007f494949360000 ; 01:"B"
1e10  003e414141220000 ; 02:"C"
1e18  007f4141413e0000 ; 03:"D"
1e20  007f494949410000 ; 04:"E"

1e28  
  00    ; ........
  7f    ; .*******
  48    ; .*..*...
  48    ; .*..*...
  48    ; .*..*...
  40    ; .*......
  00    ; ........
  00    ; ........
; 05:"F"

1e30  003e414145470000 ; 06:"G"
1e38  007f0808087f0000 ; 07:"H"
1e40  0000417f41000000 ; 08:"I"
1e48  00020101017e0000 ; 09:"J"
1e50  007f081422410000 ; 0A:"K"
1e58  007f010101010000 ; 0B:"L"
1e60  007f2018207f0000 ; 0C:"M"
1e68  007f1008047f0000 ; 0D:"N"
1e70  003e4141413e0000 ; 0E:"O"
1e78  007f484848300000 ; 0F:"P"
1e80  003e4145423d0000 ; 10:"Q"
1e88  007f484c4a310000 ; 11:"R"
1e90  0032494949260000 ; 12:"S"
1e98  0040407f40400000 ; 13:"T"
1ea0  007e0101017e0000 ; 14:"U"
1ea8  007c0201027c0000 ; 15:"V"
1eb0  007f020c027f0000 ; 16:"W"
1eb8  0063140814630000 ; 17:"X"
1ec0  0060100f10600000 ; 18:"Y"
1ec8  0043454951610000 ; 19:"Z"
1ed0  003e4549513e0000 ; 1A:"0"
1ed8  0000217f01000000 ; 1B:"1"
1ee0  0023454949310000 ; 1C:"2"
1ee8  0042414959660000 ; 1D:"3"
1ef0  000c14247f040000 ; 1E:"4"
1ef8  00725151514e0000 ; 1F:"5"
1f00  001e294949460000 ; 20:"6"
1f08  0040474850600000 ; 21:"7"
1f10  0036494949360000 ; 22:"8"
1f18  003149494a3c0000 ; 23:"9"
1f20  0008142241000000 ; 24:"" Down arrow-head
1f28  0000412214080000 ; 25:"^"
1f30  0000000000000000 ; 26:" "
1f38  0014141414140000 ; 27:"="
1f40  0022147f14220000 ; 28:"*"
1f48  0003047804030000 ; 29:"" Upside-down Y
;
1f50  241b260e11261c26
1f58  0f0b001804111225
1f60  2626281b260f0b00 
1f68  18041126261b2602
1f70  0e080d26
;
; Demo movement commands (1=Right, 2=Left)
1f74  0101000001000201000201
;
1f7f  00
1f80  60100f106030181a
1f88  3d68fcfc683d1a00  
;
; Message = "INSERT  COIN"
1f90  080d120411132626
1f98  020e080d
;
1f9c  0d2a501f
1fa0  0a2a621f072ae11f
1fa8  ff
;
; Message = "CREDIT "
1fa9  02110403081326
;
1fb0  0060100f10603819
1fb8  3a6dfafa6d3a1900
;
1fc0  0020404d50200000 ; "?"
1fc8  000000ffb8ff801f
1fd0  109700801f000001
1fd8  d022201c10940020
;
1fe0  1c281c260f0b0018
1fe8  041112261c26020e
1ff0  080d12
; Message = "PUSH"
1ff3  0f141207
1ff7  26
;
1ff8  0008080808080000 ; 3F:"-"