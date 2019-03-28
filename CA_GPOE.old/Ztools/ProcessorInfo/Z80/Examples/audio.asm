; Sound processor for the arcade game "Time Pilot"
; 1982 by Centuri/Konami

; Reverse-commented by Chris Cantrell 1998

; TODO:
; - Figure out what the DEVICE 8000 does
; - Comment the individual sound commands
; - Get the disassembly to compile

; Z80 CPU and 2 AY-3-8910 Sound Chips
; The sound board receives commands from the game board through
; the two ports of one sound chip. Port A receives the command.
; The upper nibble of Port B must be all 0's to enable sound processing.

; Here is a list of the sound commands:
; 00 Stop all sounds
; 01 Coin Drop
; 02 Plane Fire
; 03 1910 Bomb
; 04 ? Semi-boss ?
; 05 ? Missile (helicopter/jet) ?
; 06 ? Space-tracker ?
; 07 User Fire
; 08 Enemy Explosion Component (thud)
; 09 Enemy Explosion Component (white-noise)
; 0A Traker or Bomb Explosion
; 0B Squad Appears
; 0C 1st Boss (Blimp)
; 0D 2nd Boss (Jet)
; 0E 3rd Boss (Helicopter)
; 0F 4th Boss (Jet)
; 10 5th Boss (Mothership)
; 11 User Explosion Component
; 12 User Explosion Component
; 13 User Explosion Component
; 14 User Explosion Component
; 15 User Explosion Component
; 16 Pickup Parachute
; 17 Free Man
; 18 Time Jump 1
; 19 Time Jump 2
; 1A Play Song 0 (Intro)
; 1B Play Song 1 (High score)
; 1C Music Descriptor 1 (internal command)
; 1D Music Descriptor 2 (internal command)
; 1E Music Descriptor 3 (internal command)
; 1F Music Descriptor 4 (internal command)
; 20 Music Descriptor 5 (internal command)

; Memory usage starts at 3000
; 3000-0B Command Buffer (see ##### COMMAND BUFFER)
; 300C,0D Current ?device? settings (see ##### DEVICE 8000)
; 300E Voice number = command index

; Music descriptors (see ##### MUSIC PROCESSING)
; 300F,10,11,12,13,14,15,16,17,18
; 3019,1A,1B,1C,1D,1E,1F,00,01,02
; 3023,24,25,26,27,28,29,2A,2B,2C
; 302D,2E,2F,30,31,32,33,34,35,36
; 3037,38,39,3A,3B,3C,3D,3E,3F,40

; Individual sound routines use some memory above 3040

; Reset/Startup
0000 210030   LD     HL,$3000     ; Command buffer
0003 0600     LD     B,#00        ; Fill value
0005 C39B00   JP     $009B        ; continue initialization ...

; Read CHIP0 register. A=register, return in A
0008 320050   LD     ($5000),A    ; Store the register number
000B 3A0040   LD     A,($4000)    ; Read the value
000E C9       RET                 ; Return
000F FF       RST    38H          ; Filler to align RST routines

; Read CHIP1 register. A=register, retun in A
0010 320070   LD     ($7000),A    ; ...
0013 3A0060   LD     A,($6000)    ; ...
0016 C9       RET                 ; ...
0017 FF       RST    38H          ; ...

; Write CHIP0 register. A=register, C=value
0018 320050   LD     ($5000),A    ; Store register number
001B 79       LD     A,C          ; Value ...
001C 320040   LD     ($4000),A    ; ... write value
001F C9       RET                 ; Done

; Write CHIP1 register. A=register, C=value
0020 320070   LD     ($7000),A    ; ...
0023 79       LD     A,C          ; ...
0024 320060   LD     ($6000),A    ; ...
0027 C9       RET                 ; ...

; Vector to desired function indexed by A
; HL = address table
; A  = index
0028 87       ADD    A,A          ; *2
0029 85       ADD    A,L          ; Add to offset 
002A 6F       LD     L,A          ; Set LSB of pointer
002B 7C       LD     A,H          ; Carry into ...
002C CE00     ADC    A,#00        ; ... MSB of pointer
002E 67       LD     H,A          ; Set MSB of pointer
002F 7E       LD     A,(HL)       ; Get LSB of address
0030 23       INC    HL           ; Next in table
0031 66       LD     H,(HL)       ; Get MSB of address
0032 6F       LD     L,A          ; Get LSB of address
0033 E9       JP     (HL)         ; Jump to routine
0034 FF       RST    38H          ; Filler ...
0035 FF       RST    38H          ; ...
0036 FF       RST    38H          ; ...
0037 FF       RST    38H          ; ...

; Switch banks and call the command fetch routine
0038 D9       EXX                 ; Switch banks B-L
0039 08       EX     AF,A'F'      ; Switch AF banks
003A CD4000   CALL   $0040        ; Make the call
003D 08       EX     AF,A'F'      ; Set the AF banks back
003E D9       EXX                 ; Set the B-L banks back
003F C9       RET                 ; Done

;##### COMMAND BUFFER########################################
;
; COMMAND BUFFER
; Command Buffer is kept at 3000 and contains 6 2-byte entries.
; The first byte is the command. A zero marks an available slot.
; Commands are read from Port A of Chip 0. A zero command clears
; the buffer. If the upper bit is set, the command is removed from
; the buffer. Command values above 0x20 are ignored. If the command
; is already in the buffer, the second byte is set to 0.
; If the command is not in the buffer, it is added to the first 
; available slot. If there are no available slots, the new command
; replaces the lowest numbered command in the buffer if the new
; command is even lower than that one.
;
; The second byte indicates initialization status. 0=not initialized, 1=
; initialized. Note that entries are removed by setting them to 0000 which
; forces an initialization of command 00 which turns the voice off.
;
;############################################################

; Fetch a command from the port and place it in the
; command buffer.
0040 3E0E     LD     A,#0E        ; Port A
0042 CF       RST    08H          ; Read CHIP0 Port A
0043 B7       OR     A            ; Set flags
0044 282F     JR     Z,$75        ; If 0, clear 3000-300B and out
0046 57       LD     D,A          ; Hang onto command
0047 E67F     AND    #7F          ; Mask off upper bit
0049 FE21     CP     #21          ; Compare command to 21
004B D0       RET    NC           ; Invalid command (above 20)
004C CB7A     BIT    7,D          ; Upper bit set?
004E 2042     JR     NZ,$92       ; Yes -- remove the command from the buffer
0050 CD8000   CALL   $0080        ; Is the command already in the buffer?
0053 201C     JR     NZ,$71       ; Found ... set second byte to zero.
0055 CD8000   CALL   $0080        ; Find 0 in the buffer
0058 2016     JR     NZ,$70       ; Found a slot -- store command in buffer
; Find the lowest numbered command
005A 210030   LD     HL,$3000     ; Buffer
005D 1E06     LD     E,#06        ; 6 entries
005F 7E       LD     A,(HL)       ; Get guess from buffer
0060 1D       DEC    E            ; Count down
0061 2808     JR     Z,$6B        ; All checked -- 
0063 2C       INC    L            ; Bump to next ...
0064 2C       INC    L            ; ... entry
0065 BE       CP     (HL)         ; Compare guess with next entry
0066 38F8     JR     C,$60        ; Next entry is higher -- ignore it
0068 C35F00   JP     $005F        ; Next entry is <= -- use it
006B BA       CP     D            ; Is the new command higher?
006C D0       RET    NC           ; Yes -- ignore the command
; Find entry, replace type with D and clear second byte
006D CD8000   CALL   $0080        ; Find entry
0070 72       LD     (HL),D       ; Store D
0071 2C       INC    L            ; Second byte in entry
0072 3600     LD     (HL),#00     ; Clear it out
0074 C9       RET                 ; Done

; Clear buffer
0075 210030   LD     HL,$3000     ; Clear 13 bytes ...
0078 060C     LD     B,#0C        ; ... starting at ...
007A AF       XOR    A            ; ...
007B 77       LD     (HL),A       ; ...
007C 2C       INC    L            ; ...
007D 10FC     DJNZ   $7B          ; ... 3000
007F C9       RET                 ; Done

; Find entry A in buffer. Return 7-index and HL if found.
; If not found, return 0
0080 210030   LD     HL,$3000     ; Buffer area.
0083 0606     LD     B,#06        ; 6 entries to check.
0085 0E07     LD     C,#07        ; Subtraction value.
0087 BE       CP     (HL)         ; Found?
0088 2805     JR     Z,$8F        ; Yes -- done
008A 2C       INC    L            ; Bump to ...
008B 2C       INC    L            ; ... next entry
008C 10F9     DJNZ   $87          ; Check all entries
008E 41       LD     B,C          ; Not found -- use 7 as index
008F 79       LD     A,C          ; Substract found ...
0090 90       SUB    B            ; ... index from 7
0091 C9       RET                 ; Return index

; Remove entry from buffer
0092 CD8000   CALL   $0080        ; Find entry
0095 C8       RET    Z            ; Not found -- out
0096 AF       XOR    A            ; Fast 0
0097 77       LD     (HL),A       ; Clear ...
0098 2C       INC    L            ; ... entry ...
0099 77       LD     (HL),A       ; ... from buffer.
009A C9       RET                 ; Out

; Initialization continued.
; Clear RAM
009B 70       LD     (HL),B       ; Store 0
009C 23       INC    HL           ; Bump pointer
009D 7C       LD     A,H          ; Clear until ...
009E FE34     CP     #34          ; ... done
00A0 20F9     JR     NZ,$9B       ; Loop back
00A2 F9       LD     SP,HL        ; Set SP to 3400
00A3 ED56     IM     1            ; Set interrupt MODE 1
00A5 210080   LD     HL,$8000     ; 
00A8 220C30   LD     ($300C),HL   ; DEVICE 8000 ???
00AB 77       LD     (HL),A       ; 

; Initialize sound chips
00AC 0E00     LD     C,#00        ; Value 0
00AE 1606     LD     D,#06        ; 6 voices
00B0 7A       LD     A,D          ; Pass to function
00B1 CD9C01   CALL   $019C        ; Amplitude to silence.
00B4 15       DEC    D            ; ...
00B5 20F9     JR     NZ,$B0       ; Silence all voices
00B7 0E38     LD     C,#38        ; Both IO Ports IN, Tones only on ...
00B9 3E07     LD     A,#07        ; ... all voices.
00BB DF       RST    18H          ; Configure AY38910 chip 0
00BC 3E07     LD     A,#07        ; "Enable" register again
00BE E7       RST    20H          ; Configure AY38910 chip 1

; == MAIN PROCESSING LOOP ==
00BF FB       EI                  ; Enable interrupts
00C0 3E0F     LD     A,#0F        ; Port B
00C2 CF       RST    08H          ; Read CHIP0 Port B
00C3 E6F0     AND    #F0          ; Run flag active?
00C5 20F9     JR     NZ,$C0       ; No -- keep waiting

; Process Entry Index 1
00C7 F3       DI                  ; Disable interrupts
00C8 3E01     LD     A,#01        ; Voice index 1
00CA 320E30   LD     ($300E),A    ; Hang onto it
00CD 3A0130   LD     A,($3001)    ; First voice, 2nd byte
00D0 B7       OR     A            ; Set flags about 2nd byte
00D1 3A0030   LD     A,($3000)    ; Get commmand (no flags)
00D4 2806     JR     Z,$DC        ; 2nd byte == 0
00D6 CD7F01   CALL   $017F        ; Continue command
00D9 C3DF00   JP     $00DF        ; Skip over
00DC CD6901   CALL   $0169        ; Initialize command
00DF FB       EI                  ; Enable interrupts
00E0 00       NOP                 ; Pause
00E1 00       NOP                 ; Pause

; Process Entry Index 2 (see Index 1 above)
00E2 F3       DI                  ;
00E3 3E02     LD     A,#02        ;
00E5 320E30   LD     ($300E),A    ;
00E8 3A0330   LD     A,($3003)    ;
00EB B7       OR     A            ;
00EC 3A0230   LD     A,($3002)    ;
00EF 2806     JR     Z,$F7        ;
00F1 CD7F01   CALL   $017F        ;
00F4 C3FA00   JP     $00FA        ;
00F7 CD6901   CALL   $0169        ;
00FA FB       EI                  ;
00FB 00       NOP                 ;
00FC 00       NOP                 ;

; Process Entry Index 3 (see Index 1 above)
00FD F3       DI                  ;
00FE 3E03     LD     A,#03        ;
0100 320E30   LD     ($300E),A    ;
0103 3A0530   LD     A,($3005)    ;
0106 B7       OR     A            ;
0107 3A0430   LD     A,($3004)    ;
010A 2806     JR     Z,$112       ;
010C CD7F01   CALL   $017F        ;
010F C31501   JP     $0115        ;
0112 CD6901   CALL   $0169        ;
0115 FB       EI                  ;
0116 00       NOP                 ;
0117 00       NOP                 ;

; Process Entry Index 4 (see Index 1 above)
0118 F3       DI                  ;
0119 3E04     LD     A,#04        ;
011B 320E30   LD     ($300E),A    ;
011E 3A0730   LD     A,($3007)    ;
0121 B7       OR     A            ;
0122 3A0630   LD     A,($3006)    ;
0125 2806     JR     Z,$12D       ;
0127 CD7F01   CALL   $017F        ;
012A C33001   JP     $0130        ;
012D CD6901   CALL   $0169        ;
0130 FB       EI                  ;
0131 00       NOP                 ;
0132 00       NOP                 ;

; Process Entry Index 5 (see Index 1 above)
0133 F3       DI                  ;
0134 3E05     LD     A,#05        ;
0136 320E30   LD     ($300E),A    ;
0139 3A0930   LD     A,($3009)    ;
013C B7       OR     A            ;
013D 3A0830   LD     A,($3008)    ;
0140 2806     JR     Z,$148       ;
0142 CD7F01   CALL   $017F        ;
0145 C34B01   JP     $014B        ;
0148 CD6901   CALL   $0169        ;
014B FB       EI                  ;
014C 00       NOP                 ;
014D 00       NOP                 ;

; Process Entry Index 6 (see Index 1 above)
014E F3       DI                  ;
014F 3E06     LD     A,#06        ;
0151 320E30   LD     ($300E),A    ;
0154 3A0B30   LD     A,($300B)    ;
0157 B7       OR     A            ;
0158 3A0A30   LD     A,($300A)    ;
015B 2806     JR     Z,$163       ;
015D CD7F01   CALL   $017F        ;
0160 C3BF00   JP     $00BF        ;
0163 CD6901   CALL   $0169        ;

; Commands return 0 if still playing or else to remove from buffer

0166 C3BF00   JP     $00BF        ; Continue main loop

; Initialize command and flag it initialized
; Vector to command. If return is 0, set second byte to 1. If return
; is not 0, remove the command from the buffer.
0169 21920A   LD     HL,$0A92     ; Jump table
016C EF       RST    28H          ; Vector to address A in table HL
016D B7       OR     A            ; Test return
016E 2017     JR     NZ,$187      ; Remove the command
0170 210130   LD     HL,$3001     ; Command buffer (2nd bytes)
0173 3A0E30   LD     A,($300E)    ; Index of command
0176 3D       DEC    A            ; Convert to ...
0177 87       ADD    A,A          ; ... pointer
0178 5F       LD     E,A          ; LSB
0179 1600     LD     D,#00        ; MSB=0
017B 19       ADD    HL,DE        ; Pointer to command 2nd byte
017C 3601     LD     (HL),#01     ; Set second byte to 1
017E C9       RET                 ; Done

; Continue processing a command
; Vector to command. If return is 0, leave buffer alone. If return
; is not 0, remove command from buffer.
017F B7       OR     A            ; If slot is empty ...
0180 C8       RET    Z            ; ... do nothing
0181 21D40A   LD     HL,$0AD4     ; Jump table
0184 EF       RST    28H          ; Vector to address A in table HL
0185 B7       OR     A            ; Test return
0186 C8       RET    Z            ; If zero -- out
0187 210030   LD     HL,$3000     ; Command buffer
018A 3A0E30   LD     A,($300E)    ; Index of command
018D 3D       DEC    A            ; Convert to ...
018E 87       ADD    A,A          ; ... pointer
018F 4F       LD     C,A          ; LSB
0190 0600     LD     B,#00        ; MSB=0
0192 09       ADD    HL,BC        ; Pointer to command
0193 70       LD     (HL),B       ; Clear command type
0194 2C       INC    L            ; Next byte
0193 70       LD     (HL),B       ; Clear second byte
0196 C9       RET                 ; Done

; Initialize Routine Vector 00

; Clear register
0197 0E00     LD     C,#00        ; Silence the voice
;  Write to amplitude control of given voice
0199 3A0E30   LD     A,($300E)    ; Get command index
019C FE04     CP     #04          ; Voice 4-6
019E 3005     JR     NC,$1A5      ; Yes -- do chip 1
01A0 C607     ADD    A,#07        ; Bump to register 11?
01A2 C31800   JP     $0018        ; Write C to reg A chip 0
01A5 C604     ADD    A,#04        ; Add 4
01A7 C32000   JP     $0020        ; Write C to reg A chip 1

; Write to tone registers for the specified voice.
; Write HL = value, voice (1-3 Chip0, 4-6 Chip1)
01AA 3A0E30   LD     A,($300E)    ; Get register
01AD FE04     CP     #04          ; Register 4-6
01AF 300B     JR     NC,$1BC      ; Yes ... next chip
01B1 3D       DEC    A            ; -1
01B2 87       ADD    A,A          ; *2
01B3 47       LD     B,A          ; Hold onto register
01B4 4D       LD     C,L          ; Value
01B5 DF       RST    18H          ; Write Chip 0
01B6 78       LD     A,B          ; Restore register
01B7 3C       INC    A            ; Next
01B8 4C       LD     C,H          ; Value
01B9 C31800   JP     $0018        ; Write Chip 0
01BC D604     SUB    #04          ; Registers in chip 1
01BE 87       ADD    A,A          ; ...
01BF 47       LD     B,A          ; ...
01C0 4D       LD     C,L          ; ...
01C1 E7       RST    20H          ; ...
01C2 78       LD     A,B          ; ...
01C3 3C       INC    A            ; ...
01C4 4C       LD     C,H          ; ...
01C5 C32000   JP     $0020        ; Done

;##### 8000 DEVICE ########################################
;
; There must be a device mapped to any write at or above 8000.
; The address lines must form the data lines to this address.
; Each voice maps to 2 bits in this data value. Each sound routine
; initializes these two bits.
;
; This could be an enable of some sort. Perhaps it maps the channels
; to speakers -- left, right, or both. Could be a crude volume control.
;
; There could be multiple sets of speakers. Perhaps this routes sounds
; to different places in the chasis.
;
; The bit pattern is passed in in A. Here is how the voice maps the
; pattern to an address:
; (note that the lower bits in A are reversed before setting)
;
; V1 1000xxxxAAxxxxxx
; V2 1000xxAAxxxxxxxx
; V3 1000AAxxxxxxxxxx
; V4 1000xxxxxxxxxxAA
; V5 1000xxxxxxxxAAxx
; V6 1000xxxxxxAAxxxx
;
;############################################################

; Reverse A bits
01C8 01FCFF   LD     BC,$FFFC     ; 11111111 11111100
01CB 210000   LD     HL,$0000     ; Clear HL
01CE 1F       RRA                 ; Bit 0 ...
01CF CB15     RL     L            ; ... into L
01D1 1F       RRA                 ; Bit 1 ...
01D2 CB15     RL     L            ; ... into L
; Move bits and calculate mask
; V=1 HL*=64    BC=1111111100111111
;   2 HL*=256   BC=1111110011111111
;   3 HL*=1024  BC=1111001111111111
;   4 HL*=1     BC=1111111111111100
;   5 HL*=4     BC=1111111111110011
;   6 HL*=16    BC=1111111111001111
01D4 3A0E30   LD     A,($300E)    ; Voice number
01D7 C602     ADD    A,#02        ; 2 bits in field
01D9 FE06     CP     #06          ; Split the field map
01DB 3804     JR     C,$1E1       ; ...
01DD D606     SUB    #06          ; ...
01DF 280A     JR     Z,$1EB       ; ...
01E1 87       ADD    A,A          ; = number of moves
01E2 29       ADD    HL,HL        ; HL * 2
01E3 37       SCF                 ; Set carry flag
01E4 CB11     RL     C            ; Roll ...
01E6 CB10     RL     B            ; ... the mask
01E8 3D       DEC    A            ; Position counter
01E9 20F7     JR     NZ,$1E2      ; Complete the pattern
; CurrentValue = (CurrentValue & Mask) | HL
01EB EB       EX     DE,HL        ; HL->DE
01EC 2A0C30   LD     HL,($300C)   ; Old value
01EF 7D       LD     A,L          ; LSB
01F0 A1       AND    C            ; Mask
01F1 B3       OR     E            ; OR in old value
01F2 6F       LD     L,A          ; New LSB
01F3 7C       LD     A,H          ; MSB
01F4 A0       AND    B            ; Mask
01F5 B2       OR     D            ; OR in old value
01F6 67       LD     H,A          ; New MSB
01F7 220C30   LD     ($300C),HL   ; New configuration value
; Write to memory -- why?
01FA 77       LD     (HL),A       ; Any write will do (using the ...
01FB C9       RET                 ; ... address lines as data.)

;#### MUSIC PROCESSING #######################################
;
; Bytes are loaded from the music pointer. The upper three bits
; define the MSB delay and the lower five bits define a note
; offset from the base note pointer. If the lower five bits are
; all ones, a special command is executed instead and then
; processing continues.
;
; The MSB delay is a power of 2 (ie 128th,64th, ... quarter,half,whole).
; The Running LSB delay is the base counter for note delay.
; The Music Pointer points to the next byte in the song to process.
; The Base Note Table Pointer points to the start of an octave in
;   the note table. Subsequent notes are relative to the base.
; The initial amplitude is the initial volume of the note.
; The running amplitude is the current volume level. The modifier is
;   used to change the volume ever other MSB delay count. (The volume
;   becomes fixed when silenced.)
; The LSB delay is the 128th-note-equals specification. This is used
;   to reload the running count.
; The Amplitude Modification is the value added (or subtracted) to
;   the amplitude each change.
;
; Music Descriptors
;
; 00 01 02 03 04 05 06 07 08 09 0A
;
; 00 - MSB Note Delay
; 01 - Running LSB Note delay (base delay)
; 02,03 - Music Pointer
; 04,05 - Note Table Base Pointer
; 06 Initial Amplitude
; 07 Running amplitude
; 08 LSB delay reload
; 09 Amplitude modification
; 0A -- not used
;
;############################################################

; Process Music Descriptor
; Amplitude of a note is reduced at a rate of 0.5 the MSB delay.
01FC DD3501   DEC    (IX+#01)     ; Decrement LSB of delay
01FF C0       RET    NZ           ; Not time for new note -- out
0200 DD7E08   LD     A,(IX+#08)   ; Reload ...
0203 DD7701   LD     (IX+#01),A   ; ... LSB of delay
0206 DD3500   DEC    (IX+#00)     ; Decrement MSB of delay
0209 2815     JR     Z,$220       ; Load next note
020B DDCB0046 BIT    0,(IX+#00)   ; Test bit 0 of MSB of delay
020F C8       RET    Z            ; Not time to fool with volume
0210 DD7E09   LD     A,(IX+#09)   ; Get volume modifier
0213 B7       OR     A            ; Test it
0214 C8       RET    Z            ; No modification ... out
0215 DD8607   ADD    A,(IX+#07)   ; Modify current volume.
0218 F8       RET    M            ; Ignore it if it wrapped
0219 DD7707   LD     (IX+#07),A   ; New amplitude
021C 4F       LD     C,A          ; To C
021D C39901   JP     $0199        ; Set amplitude and out
; Load next note
0220 DD6E02   LD     L,(IX+#02)   ; LSB of music pointer
0223 DD6603   LD     H,(IX+#03)   ; MSB of music pointer
0226 7E       LD     A,(HL)       ; Get next command
0227 57       LD     D,A          ; Hang onto it
0228 E61F     AND    #1F          ; Mask out note
022A 2824     JR     Z,$250       ; Note 0? Just set delay
022C FE1F     CP     #1F          ; Special command?
022E 2837     JR     Z,$267       ; Yes ... process special command.
0230 CD5002   CALL   $0250        ; Regular note -- set delay
0233 7A       LD     A,D          ; Get note
0234 E61F     AND    #1F          ; Mask off upper 3 bits
0236 3D       DEC    A            ; -1 (0 is not a note)
0237 07       RLCA                ; *2 (2 bytes per note)
0238 4F       LD     C,A          ; Hold it
0239 DD6E04   LD     L,(IX+#04)   ; Base pointer into ...
023C DD6605   LD     H,(IX+#05)   ; ... note table
023F 09       ADD    HL,BC        ; B got set to 0 in the delay set!
0240 5E       LD     E,(HL)       ; Get tone ...
0241 23       INC    HL           ; ... value ...
0242 56       LD     D,(HL)       ; ... from table
0243 EB       EX     DE,HL        ; To HL
0244 CDAA01   CALL   $01AA        ; Write tone
0247 DD4E06   LD     C,(IX+#06)   ; Get amplitude
024A DD7107   LD     (IX+#07),C   ; Initialize running amplitude
024D C39901   JP     $0199        ; Set amplitude and out

; Convert next byte to power of 2 and store as delay MSB
0250 23       INC    HL           ; Next byte in music
0251 DD7502   LD     (IX+#02),L   ; Update ...
0254 DD7403   LD     (IX+#03),H   ; ... music pointer
0257 7A       LD     A,D          ; Restore command
0258 E6E0     AND    #E0          ; Mask off lower 5 bits
025A 07       RLCA                ; Move upper three bits ...
025B 07       RLCA                ; ...
025C 07       RLCA                ; ... to lower bits.
025D 47       LD     B,A          ; Save it
025E 3E80     LD     A,#80        ; One bit
0260 07       RLCA                ; Set bit position ...
0261 10FD     DJNZ   $260         ; ... B
0263 DD7700   LD     (IX+#00),A   ; Store to MSB delay
0266 C9       RET                 ; Done

; Music byte xxx11111
; Vector to function xxx and continue processing
0267 7A       LD     A,D          ; Restore command
0268 E6E0     AND    #E0          ; Mask off lower bits
026A 07       RLCA                ; Move upper ...
026B 07       RLCA                ; ... three bits ...
026C 07       RLCA                ; ... to low end
026D 112002   LD     DE,$0220     ; Return to process ... 
0270 D5       PUSH   DE           ; ... next command
0271 23       INC    HL           ; Bump music pointer
0272 5D       LD     E,L          ; Hold ...
0273 54       LD     D,H          ; ... pointer
0274 23       INC    HL           ; Next
0275 DD7502   LD     (IX+#02),L   ; Save ...
0278 DD7403   LD     (IX+#03),H   ; ... music pointer
027B 218102   LD     HL,$0281     ; Jump table
027E C32800   JP     $0028        ; Do command and continue with next

; Music commands (DE contains pointer to 2nd byte)
0281 9102 ; Load base note table pointer from music
0283 A502 ; Load LSB delay from music
0285 B502 ; Load amplitude from music
0287 BA02 ; Load amplitude modification from music
0289 C902 ; End sound command
028B C902 ; End sound command
028D BF02 ; Jump to new music address
028F C902 ; End sound command

; Music function 00
; Load base note table pointer
0291 EB       EX     DE,HL        ; Pointer to second byte
0292 4E       LD     C,(HL)       ; Get second byte
0293 CB21     SLA    C            ; *2 
0295 0600     LD     B,#00        ; MSB = 0
0297 21CE02   LD     HL,$02CE     ; Octave pointers
029A 09       ADD    HL,BC        ; Offset into table
029B 5E       LD     E,(HL)       ; Get byte
029C 23       INC    HL           ; Next
029D 56       LD     D,(HL)       ; Get byte
029E DD7304   LD     (IX+#04),E   ; Store ...
02A1 DD7205   LD     (IX+#05),D   ; ... tone pointer
02A4 C9       RET                 ;

; Music function 01
; Load delay from table
02A5 EB       EX     DE,HL        ; Second byte pointer
02A6 4E       LD     C,(HL)       ; Get second byte
02A7 0600     LD     B,#00        ; MSB = 0
02A9 216603   LD     HL,$0366     ; Data
02AC 09       ADD    HL,BC        ; Point to entry
02AD 7E       LD     A,(HL)       ; Get data
02AE DD7708   LD     (IX+#08),A   ; Delay
02B1 DD7701   LD     (IX+#01),A   ; Delay
02B4 C9       RET                 ; Done

; Music function 02
; Load amplitude
02B5 1A       LD     A,(DE)       ; Get second byte
02B6 DD7706   LD     (IX+#06),A   ; Store it to amplitude
02B9 C9       RET                 ; Done

; Music function 03
; Set 09 Amplitude modification
02BA 1A       LD     A,(DE)       ; Get second byte
02BB DD7709   LD     (IX+#09),A   ; Store it to ?
02BE C9       RET                 ; Done

; Music function 06
; Jump to new music address
02BF 1A       LD     A,(DE)       ; Get second byte
02C0 DD7702   LD     (IX+#02),A   ; Set ...
02C3 13       INC    DE           ; ...
02C4 1A       LD     A,(DE)       ; ...
02C5 DD7703   LD     (IX+#03),A   ; ... new pointer
02C8 C9       RET                 ; Done

; Music function 04, 05, 07
; End this music command abruptly
02C9 E1       POP    HL           ; Clear for return ...
02CA E1       POP    HL           ; ... from music routine
02CB 3EFF     LD     A,#FF        ; Flag end of processing
02CD C9       RET                 ; Done

;Octave offsets into note table
02CE EE02
02D0 F202
02D2 F602
02D4 FA02
02D6 FE02
02D8 0203
02DA 0603
02DC 0A03
02DE 0E03
02E0 1203
02E2 1603
02E4 1A03
02E6 1E03
02E8 2203
02EA 2603
02EC 2A03

; Note Table -- tones for notes on the chromatic scale
02EE FF0F ; Lowest possible note
02F0 F207
02F2 8007
02F4 1407
02F6 AE06
02F8 4E06
02FA F305
02FC 9E05
02FE 4E05
0300 0105
0302 B904
0304 7604
0306 3604
0308 F903
030A C003
030C 8A03
030E 5703
0310 2703
0312 FA02
0314 CF02
0316 A702
0318 8102
031A 5D02
031C 3B02
031E 1B02
0320 FD01
0322 E001
0324 C501
0326 AC01
0328 9401
032A 7D01
032C 6801
032E 5301
0330 4001
0332 2E01
0334 1D01
0336 0D01
0338 FE00
033A F000
033C E300
033E D600
0340 CA00
0342 BE00
0344 B400
0346 AA00
0348 A000
034A 9700
034C 8F00 
034E 8700
0350 7F00
0352 7800
0354 7100
0356 6B00
0358 6500
035A 5F00
035C 5A00
035E 5500
0360 5000
0362 4C00
0364 0700 ; Really high

; Delay table (bytes)
0366 3C
0367 3834
0369 302C
036B 2824
036D 201E
036F 1C
0370 1A
0371 1816
0373 14
0374 12
0375 100F
0377 0E0D
0379 0C
037A 0B
037B 0A
037C 09
037D 08

; Initialize descriptors for a specified song number
037E 21B503   LD     HL,$03B5     ; Initialization data
0381 110F30   LD     DE,$300F     ; First music descriptor
0384 013200   LD     BC,$0032     ; 10*5 = 50 bytes
0387 EDB0     LDIR                ; Initialize the data
0389 87       ADD    A,A          ; *2
038A 4F       LD     C,A          ; Hold
038B 87       ADD    A,A          ; *4
038C 87       ADD    A,A          ; *8
038D 81       ADD    A,C          ; *10
038E 4F       LD     C,A          ; Hold it
038F 0600     LD     B,#00        ; MSB = 0
0391 216E0B   LD     HL,$0B6E     ; Data region
0394 09       ADD    HL,BC        ; Point to song
0395 111130   LD     DE,$3011     ; Music pointer descriptor 1
0398 EDA0     LDI                 ; Set ...
039A EDA0     LDI                 ; ... pointer
039C 1E1B     LD     E,#1B        ; Music pointer descriptor 2
039E EDA0     LDI                 ; Set ...
03A0 EDA0     LDI                 ; ... pointer
03A2 1E25     LD     E,#25        ; Music pointer descriptor 2
03A4 EDA0     LDI                 ; Set ...
03A6 EDA0     LDI                 ; ... pointer
03A8 1E2F     LD     E,#2F        ; Music pointer descriptor 2
03AA EDA0     LDI                 ; Set ...
03AC EDA0     LDI                 ; ... pointer
03AE 1E39     LD     E,#39        ; Music pointer descriptor 2
03B0 EDA0     LDI                 ; Set ...
03B2 EDA0     LDI                 ; ... pointer
03B4 C9       RET                 ; Done

; Initialization data for music descriptors (10 bytes each)
03B5 010100000000000000FF
03BF 010100000000000000FF
03C9 010100000000000000FF
03D3 010100000000000000FF
03DD 010100000000000000FF

; The sounds produced by this code were discovered by modifying
; the game code ROM to play a single sound and go into an infinite
; loop. The modified code was run through the MAME emulator.

; Initialize Routine Vector 01 (Coin Drop)
03E7 AF       XOR    A            ;
03E8 CDC801   CALL   $01C8        ;
03EB 216B00   LD     HL,$006B     ; Fine=6B, Coars=00
03EE CDAA01   CALL   $01AA        ; Write to tone registers
03F1 214130   LD     HL,$3041     ;
03F4 3600     LD     (HL),#00     ;
03F6 2C       INC    L            ;
03F7 3647     LD     (HL),#47     ;
03F9 2C       INC    L            ;
03FA 0E09     LD     C,#09        ; Amplitude
03FC 71       LD     (HL),C       ;
03FD CD9901   CALL   $0199        ; Set amplitude
0400 AF       XOR    A            ; Return 0
0401 C9       RET                 ; Done

; Continue Sound Routine Vector 01  (Coin Drop)
0402 214130   LD     HL,$3041     ;
0405 35       DEC    (HL)         ;
0406 7E       LD     A,(HL)       ;
0407 E603     AND    #03          ;
0409 2018     JR     NZ,$423      ;
040B 2C       INC    L            ;
040C 35       DEC    (HL)         ;
040D 7E       LD     A,(HL)       ;
040E 281D     JR     Z,$42D       ; Return 1
0410 E607     AND    #07          ;
0412 2811     JR     Z,$425       ;
0414 E603     AND    #03          ;
0416 3D       DEC    A            ;
0417 4F       LD     C,A          ;
0418 0600     LD     B,#00        ;
041A 212F04   LD     HL,$042F     ;
041D 09       ADD    HL,BC        ;
041E 6E       LD     L,(HL)       ;
041F 60       LD     H,B          ;
0420 CDAA01   CALL   $01AA        ; Write tone registers
0423 AF       XOR    A            ; Return 0
0424 C9       RET                 ; Out
0425 2C       INC    L            ;
0426 35       DEC    (HL)         ;
0427 4E       LD     C,(HL)       ;
0428 CD9901   CALL   $0199        ; Set amplitude
042B AF       XOR    A            ; Return 0
042C C9       RET                 ; Out
042D 3D       DEC    A            ; Zero becomes FF
042E C9       RET                 ; Done

042F 47       LD     B,A          ;
0430 55       LD     D,L          ;
0431 6B       LD     L,E          ;

; Initialization Vector Routine 02 (1910 Plane Fire)
0432 AF       XOR    A            ;
0433 CDC801   CALL   $01C8        ;
0436 0E0A     LD     C,#0A        ;
0438 CD9901   CALL   $0199        ; Set volume
043B 3E80     LD     A,#80        ;
043D 324430   LD     ($3044),A    ;
0440 210400   LD     HL,$0004     ;
0443 224530   LD     ($3045),HL   ;
0446 CDAA01   CALL   $01AA        ; Write tone
0449 AF       XOR    A            ;
044A C9       RET                 ;

; Continue Sound Routine Vector 02 (1910 Plane Fire)
044B 214430   LD     HL,$3044     ;
044E 35       DEC    (HL)         ;
044F 7E       LD     A,(HL)       ;
0450 280E     JR     Z,$460       ;
0452 FE6D     CP     #6D          ;
0454 28EA     JR     Z,$440       ;
0456 2A4530   LD     HL,($3045)   ;
0459 011800   LD     BC,$0018     ;
045C 09       ADD    HL,BC        ;
045D C34304   JP     $0443        ;
0460 3D       DEC    A            ;
0461 C9       RET                 ;

; Initialization Routine Vector 03 (1910 Bomb)
0462 AF       XOR    A            ;
0463 CDC801   CALL   $01C8        ;
0466 21C000   LD     HL,$00C0     ;
0469 224730   LD     ($3047),HL   ;
046C CDAA01   CALL   $01AA        ; Write tone
046F 0E09     LD     C,#09        ;
0471 CD9901   CALL   $0199        ; Set volume
0474 AF       XOR    A            ;
0475 214930   LD     HL,$3049     ;
0478 77       LD     (HL),A       ;
0479 C9       RET                 ;

; Continue Sound Routine Vector 03 (1910 Bomb)
047A 214930   LD     HL,$3049     ;
047D 35       DEC    (HL)         ;
047E 7E       LD     A,(HL)       ;
047F E607     AND    #07          ;
0481 2012     JR     NZ,$495      ;
0483 2A4730   LD     HL,($3047)   ;
0486 014000   LD     BC,$0040     ;
0489 09       ADD    HL,BC        ;
048A 7C       LD     A,H          ;
048B FE0C     CP     #0C          ;
048D 2808     JR     Z,$497       ;
048F 224730   LD     ($3047),HL   ;
0492 CDAA01   CALL   $01AA        ; Write tone
0495 AF       XOR    A            ;
0496 C9       RET                 ;
0497 3EFF     LD     A,#FF        ;
0499 C9       RET                 ;

; Initialization Routine Vector 04 (?2001?)
049A 3E01     LD     A,#01        ;
049C CDC801   CALL   $01C8        ;
049F 214A30   LD     HL,$304A     ;
04A2 3600     LD     (HL),#00     ;
04A4 2C       INC    L            ;
04A5 0E0F     LD     C,#0F        ;
04A7 71       LD     (HL),C       ;
04A8 CD9901   CALL   $0199        ; Set volume
04AB 216000   LD     HL,$0060     ;
04AE 224C30   LD     ($304C),HL   ;
04B1 AF       XOR    A            ;
04B2 C9       RET                 ;

; Continue Sound Routine Vector 04 (?2001?)
04B3 214A30   LD     HL,$304A     ;
04B6 35       DEC    (HL)         ;
04B7 7E       LD     A,(HL)       ;
04B8 E60F     AND    #0F          ;
04BA 2816     JR     Z,$4D2       ;
04BC 2A4C30   LD     HL,($304C)   ;
04BF FE0C     CP     #0C          ;
04C1 011000   LD     BC,$0010     ;
04C4 3003     JR     NC,$4C9      ;
04C6 01D0FF   LD     BC,$FFD0     ;
04C9 09       ADD    HL,BC        ;
04CA 224C30   LD     ($304C),HL   ;
04CD CDAA01   CALL   $01AA        ; Write tone
04D0 AF       XOR    A            ;
04D1 C9       RET                 ;
04D2 2C       INC    L            ;
04D3 35       DEC    (HL)         ;
04D4 4E       LD     C,(HL)       ;
04D5 20D1     JR     NZ,$4A8      ;
04D7 3D       DEC    A            ;
04D8 C9       RET                 ;

; Initialization Routine Vector 05 (?2001?)
04D9 AF       XOR    A            ;
04DA CDC801   CALL   $01C8        ;
04DD 214E30   LD     HL,$304E     ;
04E0 36B0     LD     (HL),#B0     ;
04E2 2C       INC    L            ;
04E3 360D     LD     (HL),#0D     ;
04E5 35       DEC    (HL)         ;
04E6 4E       LD     C,(HL)       ;
04E7 CD9901   CALL   $0199        ; Set volume
04EA 2C       INC    L            ;
04EB 3620     LD     (HL),#20     ;
04ED 6E       LD     L,(HL)       ;
04EE 2600     LD     H,#00        ;
04F0 CDAA01   CALL   $01AA        ; Write tone
04F3 AF       XOR    A            ;
04F4 C9       RET                 ;

; Continue Sound Routine Vector 05 (?2001?)
04F5 214E30   LD     HL,$304E     ;
04F8 35       DEC    (HL)         ;
04F9 7E       LD     A,(HL)       ;
04FA 280C     JR     Z,$508       ;
04FC 2C       INC    L            ;
04FD E60F     AND    #0F          ;
04FF 28E4     JR     Z,$4E5       ;
0501 2C       INC    L            ;
0502 34       INC    (HL)         ;
0503 C3ED04   JP     $04ED        ;
0506 AF       XOR    A            ;
0507 C9       RET                 ;
0508 3D       DEC    A            ;
0509 C9       RET                 ;

; Initialization Routine Vector 06 (?2001 Tracker?)
050A AF       XOR    A            ;
050B CDC801   CALL   $01C8        ;
050E 215000   LD     HL,$0050     ;
0511 CDAA01   CALL   $01AA        ; Write tone
0514 215130   LD     HL,$3051     ;
0517 3640     LD     (HL),#40     ;
0519 2C       INC    L            ;
051A 0E05     LD     C,#05        ;
051C 71       LD     (HL),C       ;
051D CD9901   CALL   $0199        ; Set volume
0520 2C       INC    L            ;
0521 3617     LD     (HL),#17     ;
0523 2C       INC    L            ;
0524 3650     LD     (HL),#50     ;
0526 AF       XOR    A            ;
0527 C9       RET                 ;

; Continue Sound Routine Vector 06 (?2001 Tracker?)
0528 215130   LD     HL,$3051     ;
052B 35       DEC    (HL)         ;
052C 28E9     JR     Z,$517       ;
052E 7E       LD     A,(HL)       ;
052F 2C       INC    L            ;
0530 E60F     AND    #0F          ;
0532 2005     JR     NZ,$539      ;
0534 34       INC    (HL)         ;
0535 4E       LD     C,(HL)       ;
0536 CD9901   CALL   $0199        ; Set volume
0539 2C       INC    L            ;
053A 7E       LD     A,(HL)       ;
053B C629     ADD    A,#29        ;
053D 77       LD     (HL),A       ;
053E 2C       INC    L            ;
053F AE       XOR    (HL)         ;
0540 E63F     AND    #3F          ;
0542 C650     ADD    A,#50        ;
0544 77       LD     (HL),A       ;
0545 6F       LD     L,A          ;
0546 2600     LD     H,#00        ;
0548 CDAA01   CALL   $01AA        ; Write tone
054B AF       XOR    A            ;
054C C9       RET                 ;

; Initialization Routine Vector 07 (User Fire)
054D AF       XOR    A            ;
054E CDC801   CALL   $01C8        ;
0551 215630   LD     HL,$3056     ;
0554 3608     LD     (HL),#08     ;
0556 2D       DEC    L            ;
0557 362C     LD     (HL),#2C     ;
0559 2C       INC    L            ;
055A 35       DEC    (HL)         ;
055B 2829     JR     Z,$586       ;
055D 4E       LD     C,(HL)       ;
055E CD9901   CALL   $0199        ; Set volume
0561 210000   LD     HL,$0000     ;
0564 225730   LD     ($3057),HL   ;
0567 CDAA01   CALL   $01AA        ; Write tone
056A AF       XOR    A            ;
056B C9       RET                 ;

; Continue Sound Routine Vector 07 (User Fire)
056C 215530   LD     HL,$3055     ;
056F 35       DEC    (HL)         ;
0570 7E       LD     A,(HL)       ;
0571 28E4     JR     Z,$557       ;
0573 FE16     CP     #16          ;
0575 28EA     JR     Z,$561       ;
0577 2A5730   LD     HL,($3057)   ;
057A 011000   LD     BC,$0010     ;
057D 09       ADD    HL,BC        ;
057E 225730   LD     ($3057),HL   ;
0581 CDAA01   CALL   $01AA        ; Write tone
0584 AF       XOR    A            ;
0585 C9       RET                 ;
0586 3D       DEC    A            ;
0587 C9       RET                 ;

; Initialization Routine Vector 08 (Enemy Explosion Component - thud)
0588 3E01     LD     A,#01        ;
058A CDC801   CALL   $01C8        ;
058D 215C30   LD     HL,$305C     ;
0590 360C     LD     (HL),#0C     ;
0592 4E       LD     C,(HL)       ;
0593 CD9901   CALL   $0199        ; Set volume
0596 2D       DEC    L            ;
0597 3600     LD     (HL),#00     ;
0599 218000   LD     HL,$0080     ;
059C 225930   LD     ($3059),HL   ;
059F CDAA01   CALL   $01AA        ; Write tone
05A2 AF       XOR    A            ;
05A3 C9       RET                 ;

; Continue Sound Routine Vector 08 (Enemy Explosion Component - thud)
05A4 215B30   LD     HL,$305B     ;
05A7 34       INC    (HL)         ;
05A8 7E       LD     A,(HL)       ;
05A9 FE59     CP     #59          ;
05AB 280F     JR     Z,$5BC       ;
05AD 4F       LD     C,A          ;
05AE 0600     LD     B,#00        ;
05B0 2A5930   LD     HL,($3059)   ;
05B3 09       ADD    HL,BC        ;
05B4 225930   LD     ($3059),HL   ;
05B7 CDAA01   CALL   $01AA        ; Write tone
05BA AF       XOR    A            ;
05BB C9       RET                 ;
05BC 2C       INC    L            ;
05BD 7E       LD     A,(HL)       ;
05BE D604     SUB    #04          ;
05C0 2804     JR     Z,$5C6       ;
05C2 77       LD     (HL),A       ;
05C3 C39205   JP     $0592        ;
05C6 3D       DEC    A            ;
05C7 C9       RET                 ;

; Initialization Routine Vector 09 (Enemy Explosion Component white-noise)
05C8 3E01     LD     A,#01        ;
05CA CDC801   CALL   $01C8        ;
05CD 215D30   LD     HL,$305D     ;
05D0 3600     LD     (HL),#00     ;
05D2 2C       INC    L            ;
05D3 36E0     LD     (HL),#E0     ;
05D5 2C       INC    L            ;
05D6 0E0D     LD     C,#0D        ;
05D8 71       LD     (HL),C       ;
05D9 CD9901   CALL   $0199        ; Set volume
05DC 2C       INC    L            ;
05DD 3693     LD     (HL),#93     ;
05DF 2C       INC    L            ;
05E0 36D5     LD     (HL),#D5     ;
05E2 21C000   LD     HL,$00C0     ;
05E5 CDAA01   CALL   $01AA        ; Write tone
05E8 AF       XOR    A            ;
05E9 C9       RET                 ;

; Continue Sound Routine Vector 09 (Enemy Explosion Component white-noise)
05EA 215D30   LD     HL,$305D     ;
05ED 35       DEC    (HL)         ;
05EE CB46     BIT    0,(HL)       ;
05F0 2025     JR     NZ,$617      ;
05F2 2C       INC    L            ;
05F3 35       DEC    (HL)         ;
05F4 7E       LD     A,(HL)       ;
05F5 2822     JR     Z,$619       ;
05F7 FED0     CP     #D0          ;
05F9 28DA     JR     Z,$5D5       ;
05FB 2C       INC    L            ;
05FC E60F     AND    #0F          ;
05FE 2005     JR     NZ,$605      ;
0600 35       DEC    (HL)         ;
0601 4E       LD     C,(HL)       ;
0602 CD9901   CALL   $0199        ; Set volume
0605 2C       INC    L            ;
0606 7E       LD     A,(HL)       ;
0607 C653     ADD    A,#53        ;
0609 77       LD     (HL),A       ;
060A 2C       INC    L            ;
060B AE       XOR    (HL)         ;
060C 77       LD     (HL),A       ;
060D 6F       LD     L,A          ;
060E FEE0     CP     #E0          ;
0610 3801     JR     C,$613       ;
0612 AF       XOR    A            ;
0613 67       LD     H,A          ;
0614 CDAA01   CALL   $01AA        ; Write tone
0617 AF       XOR    A            ;
0618 C9       RET                 ;
0619 3D       DEC    A            ;
061A C9       RET                 ;

; Initialization Routine Vector 0A (Traker or Bomb Explosion)
061B AF       XOR    A            ;
061C CDC801   CALL   $01C8        ;
061F 216230   LD     HL,$3062     ;
0622 3600     LD     (HL),#00     ;
0624 2C       INC    L            ;
0625 36C0     LD     (HL),#C0     ;
0627 2C       INC    L            ;
0628 360D     LD     (HL),#0D     ;
062A 35       DEC    (HL)         ;
062B 4E       LD     C,(HL)       ;
062C CD9901   CALL   $0199        ; Set volume
062F 212000   LD     HL,$0020     ;
0632 226530   LD     ($3065),HL   ;
0635 CDAA01   CALL   $01AA        ; Write tone
0638 AF       XOR    A            ;
0639 C9       RET                 ;

; Continue Sound Routine Vector 0A (Traker or Bomb Explosion)
063A 216230   LD     HL,$3062     ;
063D 35       DEC    (HL)         ;
063E 7E       LD     A,(HL)       ;
063F E601     AND    #01          ;
0641 2017     JR     NZ,$65A      ;
0643 2C       INC    L            ;
0644 35       DEC    (HL)         ;
0645 7E       LD     A,(HL)       ;
0646 2814     JR     Z,$65C       ;
0648 2C       INC    L            ;
0649 E60F     AND    #0F          ;
064B 28DD     JR     Z,$62A       ;
064D 2A6530   LD     HL,($3065)   ;
0650 014000   LD     BC,$0040     ;
0653 09       ADD    HL,BC        ;
0654 226530   LD     ($3065),HL   ;
0657 CDAA01   CALL   $01AA        ; Write tone
065A AF       XOR    A            ;
065B C9       RET                 ;
065C 3D       DEC    A            ;
065D C9       RET                 ;

; Initialization Routine Vector 0B
065E AF       XOR    A            ;
065F CDC801   CALL   $01C8        ;
0662 0E0C     LD     C,#0C        ;
0664 CD9901   CALL   $0199        ; Set volume
0667 216730   LD     HL,$3067     ;
066A 36B8     LD     (HL),#B8     ;
066C 2C       INC    L            ;
066D 361F     LD     (HL),#1F     ;
066F 211F00   LD     HL,$001F     ;
0672 CDAA01   CALL   $01AA        ; Write tone
0675 AF       XOR    A            ;
0676 C9       RET                 ;

; Continue Sound Routine Vector 0B
0677 216730   LD     HL,$3067     ;
067A 35       DEC    (HL)         ;
067B 7E       LD     A,(HL)       ;
067C 2815     JR     Z,$693       ;
067E FE60     CP     #60          ;
0680 28EA     JR     Z,$66C       ;
0682 E603     AND    #03          ;
0684 200B     JR     NZ,$691      ;
0686 2C       INC    L            ;
0687 7E       LD     A,(HL)       ;
0688 C620     ADD    A,#20        ;
068A 77       LD     (HL),A       ;
068B 6F       LD     L,A          ;
068C 2600     LD     H,#00        ;
068E CDAA01   CALL   $01AA        ; Write tone
0691 AF       XOR    A            ;
0692 C9       RET                 ;
0693 3D       DEC    A            ;
0694 C9       RET                 ;

; Initialization Routine Vector 0C
0695 3E01     LD     A,#01        ;
0697 CDC801   CALL   $01C8        ;
069A 21C000   LD     HL,$00C0     ;
069D CDAA01   CALL   $01AA        ; Write tone
06A0 0E0F     LD     C,#0F        ;
06A2 CD9901   CALL   $0199        ; Set volume
06A5 AF       XOR    A            ;
06A6 216930   LD     HL,$3069     ;
06A9 77       LD     (HL),A       ;
06AA 2C       INC    L            ;
06AB 3653     LD     (HL),#53     ;
06AD 2C       INC    L            ;
06AE 3609     LD     (HL),#09     ;
06B0 2C       INC    L            ;
06B1 3637     LD     (HL),#37     ;
06B3 C9       RET                 ;

; Continue Sound Routine Vector 0C
06B4 216930   LD     HL,$3069     ;
06B7 35       DEC    (HL)         ;
06B8 56       LD     D,(HL)       ;
06B9 2C       INC    L            ;
06BA 7E       LD     A,(HL)       ;
06BB C6D5     ADD    A,#D5        ;
06BD 77       LD     (HL),A       ;
06BE 2C       INC    L            ;
06BF CB42     BIT    0,D          ;
06C1 2009     JR     NZ,$6CC      ;
06C3 AE       XOR    (HL)         ;
06C4 77       LD     (HL),A       ;
06C5 E6EF     AND    #EF          ;
06C7 4F       LD     C,A          ;
06C8 CD9901   CALL   $0199        ; Set volume
06CB 79       LD     A,C          ;
06CC 2C       INC    L            ;
06CD AE       XOR    (HL)         ;
06CE 77       LD     (HL),A       ;
06CF F680     OR     #80          ;
06D1 6F       LD     L,A          ;
06D2 2600     LD     H,#00        ;
06D4 CDAA01   CALL   $01AA        ; Write tone
06D7 AF       XOR    A            ;
06D8 C9       RET                 ;

; Initialization Routine Vector 0D
06D9 3E01     LD     A,#01        ;
06DB CDC801   CALL   $01C8        ;
06DE 216D30   LD     HL,$306D     ;
06E1 3628     LD     (HL),#28     ;
06E3 2C       INC    L            ;
06E4 3605     LD     (HL),#05     ;
06E6 2C       INC    L            ;
06E7 3630     LD     (HL),#30     ;
06E9 210006   LD     HL,$0600     ;
06EC CDAA01   CALL   $01AA        ; Write tone
06EF 0E08     LD     C,#08        ;
06F1 CD9901   CALL   $0199        ; Set volume
06F4 AF       XOR    A            ;
06F5 C9       RET                 ;

; Continue Sound Routine Vector 0D
06F6 216D30   LD     HL,$306D     ;
06F9 35       DEC    (HL)         ;
06FA 28E5     JR     Z,$6E1       ;
06FC 7E       LD     A,(HL)       ;
06FD E607     AND    #07          ;
06FF C608     ADD    A,#08        ;
0701 4F       LD     C,A          ;
0702 CD9901   CALL   $0199        ; Set volume
0705 2C       INC    L            ;
0706 7E       LD     A,(HL)       ;
0707 C6B9     ADD    A,#B9        ;
0709 77       LD     (HL),A       ;
070A 2C       INC    L            ;
070B AE       XOR    (HL)         ;
070C 77       LD     (HL),A       ;
070D 6F       LD     L,A          ;
070E 2606     LD     H,#06        ;
0710 CDAA01   CALL   $01AA        ; Write tone
0713 AF       XOR    A            ;
0714 C9       RET                 ;

; Initialization Routine Vector 0E
0715 3E01     LD     A,#01        ;
0717 CDC801   CALL   $01C8        ;
071A 210001   LD     HL,$0100     ;
071D CDAA01   CALL   $01AA        ; Write tone
0720 217030   LD     HL,$3070     ;
0723 3600     LD     (HL),#00     ;
0725 2C       INC    L            ;
0726 0E0F     LD     C,#0F        ;
0728 71       LD     (HL),C       ;
0729 CD9901   CALL   $0199        ; Set volume
072C AF       XOR    A            ;
072D 2C       INC    L            ;
072E 77       LD     (HL),A       ;
072F 2C       INC    L            ;
0730 77       LD     (HL),A       ;
0731 C9       RET                 ;

; Continue Sound Routine Vector 0E
0732 217030   LD     HL,$3070     ;
0735 35       DEC    (HL)         ;
0736 7E       LD     A,(HL)       ;
0737 CB47     BIT    0,A          ;
0739 23       INC    HL           ;
073A 200B     JR     NZ,$747      ;
073C 35       DEC    (HL)         ;
073D E610     AND    #10          ;
073F 2002     JR     NZ,$743      ;
0741 34       INC    (HL)         ;
0742 34       INC    (HL)         ;
0743 4E       LD     C,(HL)       ;
0744 CD9901   CALL   $0199        ; Set volume
0747 2C       INC    L            ;
0748 7E       LD     A,(HL)       ;
0749 C6D3     ADD    A,#D3        ;
074B 77       LD     (HL),A       ;
074C 2C       INC    L            ;
074D AE       XOR    (HL)         ;
074E 77       LD     (HL),A       ;
074F E67F     AND    #7F          ;
0751 C6A8     ADD    A,#A8        ;
0753 6F       LD     L,A          ;
0754 E607     AND    #07          ;
0756 67       LD     H,A          ;
0757 CDAA01   CALL   $01AA        ; Write tone
075A AF       XOR    A            ;
075B C9       RET                 ;

; Initialization Routine Vector 0F
075C 3E01     LD     A,#01        ;
075E CDC801   CALL   $01C8        ;
0761 210001   LD     HL,$0100     ;
0764 CDAA01   CALL   $01AA        ; Write tone
0767 0E0C     LD     C,#0C        ;
0769 CD9901   CALL   $0199        ; Set volume
076C AF       XOR    A            ;
076D 217430   LD     HL,$3074     ;
0770 77       LD     (HL),A       ;
0771 2C       INC    L            ;
0772 77       LD     (HL),A       ;
0773 C9       RET                 ;

; Continue Sound Routine Vector 0F
0774 217430   LD     HL,$3074     ;
0777 7E       LD     A,(HL)       ;
0778 C697     ADD    A,#97        ;
077A 77       LD     (HL),A       ;
077B 2C       INC    L            ;
077C AE       XOR    (HL)         ;
077D 77       LD     (HL),A       ;
077E E67F     AND    #7F          ;
0780 C6C0     ADD    A,#C0        ;
0782 6F       LD     L,A          ;
0783 2601     LD     H,#01        ;
0785 CDAA01   CALL   $01AA        ; Write tone
0788 AF       XOR    A            ;
0789 C9       RET                 ;

; Initialization Routine Vector 10
078A 3E01     LD     A,#01        ;
078C CDC801   CALL   $01C8        ;
078F 0E0A     LD     C,#0A        ;
0791 CD9901   CALL   $0199        ; Set volume
0794 217630   LD     HL,$3076     ;
0797 3630     LD     (HL),#30     ;
0799 2C       INC    L            ;
079A 3602     LD     (HL),#02     ;
079C 2C       INC    L            ;
079D 3EE0     LD     A,#E0        ;
079F 77       LD     (HL),A       ;
07A0 2C       INC    L            ;
07A1 77       LD     (HL),A       ;
07A2 6F       LD     L,A          ;
07A3 2600     LD     H,#00        ;
07A5 CDAA01   CALL   $01AA        ; Write tone
07A8 AF       XOR    A            ;
07A9 C9       RET                 ;

; Continue Sound Routine Vector 10
07AA 217630   LD     HL,$3076     ;
07AD 35       DEC    (HL)         ;
07AE 7E       LD     A,(HL)       ;
07AF 28E6     JR     Z,$797       ;
07B1 2C       INC    L            ;
07B2 E60F     AND    #0F          ;
07B4 2807     JR     Z,$7BD       ;
07B6 7E       LD     A,(HL)       ;
07B7 2C       INC    L            ;
07B8 2C       INC    L            ;
07B9 86       ADD    A,(HL)       ;
07BA C3A107   JP     $07A1        ;
07BD 34       INC    (HL)         ;
07BE 34       INC    (HL)         ;
07BF 2C       INC    L            ;
07C0 7E       LD     A,(HL)       ;
07C1 D620     SUB    #20          ;
07C3 C39F07   JP     $079F        ;

; Initialization Routine Vector 11 (User Explosion Component)
07C6 3E01     LD     A,#01        ;
07C8 CDC801   CALL   $01C8        ;
07CB 210000   LD     HL,$0000     ;
07CE CDAA01   CALL   $01AA        ; Write tone
07D1 217A30   LD     HL,$307A     ;
07D4 3600     LD     (HL),#00     ;
07D6 2C       INC    L            ;
07D7 0E0F     LD     C,#0F        ;
07D9 71       LD     (HL),C       ;
07DA CD9901   CALL   $0199        ; Set volume
07DD 2C       INC    L            ;
07DE 3645     LD     (HL),#45     ;
07E0 2C       INC    L            ;
07E1 3699     LD     (HL),#99     ;
07E3 AF       XOR    A            ;
07E4 C9       RET                 ;

; Continue Sound Routine Vector 11 (User Explosion Component)
07E5 217A30   LD     HL,$307A     ;
07E8 35       DEC    (HL)         ;
07E9 7E       LD     A,(HL)       ;
07EA CB47     BIT    0,A          ;
07EC 2019     JR     NZ,$807      ;
07EE 2C       INC    L            ;
07EF E63F     AND    #3F          ;
07F1 2007     JR     NZ,$7FA      ;
07F3 35       DEC    (HL)         ;
07F4 2813     JR     Z,$809       ;
07F6 4E       LD     C,(HL)       ;
07F7 CD9901   CALL   $0199        ; Set volume
07FA 2C       INC    L            ;
07FB 7E       LD     A,(HL)       ;
07FC C6D3     ADD    A,#D3        ;
07FE 77       LD     (HL),A       ;
07FF 2C       INC    L            ;
0800 AE       XOR    (HL)         ;
0801 77       LD     (HL),A       ;
0802 6F       LD     L,A          ;
0803 67       LD     H,A          ;
0804 CDAA01   CALL   $01AA        ; Write tone
0807 AF       XOR    A            ;
0808 C9       RET                 ;
0809 3D       DEC    A            ;
080A C9       RET                 ;

; Initialization Routine Vector 12 (User Explosion Component)
080B 3E01     LD     A,#01        ;
080D CDC801   CALL   $01C8        ;
0810 210000   LD     HL,$0000     ;
0813 228130   LD     ($3081),HL   ;
0816 CDAA01   CALL   $01AA        ; Write tone
0819 217E30   LD     HL,$307E     ;
081C 3600     LD     (HL),#00     ;
081E 2C       INC    L            ;
081F 0E0F     LD     C,#0F        ;
0821 71       LD     (HL),C       ;
0822 CD9901   CALL   $0199        ; Set volume
0825 2C       INC    L            ;
0826 AF       XOR    A            ;
0827 77       LD     (HL),A       ;
0828 C9       RET                 ;

; Continue Sound Routine Vector 12 (User Explosion Component)
0829 217E30   LD     HL,$307E     ;
082C 35       DEC    (HL)         ;
082D 7E       LD     A,(HL)       ;
082E 57       LD     D,A          ;
082F 2C       INC    L            ;
0830 E61F     AND    #1F          ;
0832 2007     JR     NZ,$83B      ;
0834 35       DEC    (HL)         ;
0835 281E     JR     Z,$855       ;
0837 4E       LD     C,(HL)       ;
0838 CD9901   CALL   $0199        ; Set volume
083B 2C       INC    L            ;
083C 7E       LD     A,(HL)       ;
083D C6C5     ADD    A,#C5        ;
083F 77       LD     (HL),A       ;
0840 2A8130   LD     HL,($3081)   ;
0843 AA       XOR    D            ;
0844 AD       XOR    L            ;
0845 6F       LD     L,A          ;
0846 67       LD     H,A          ;
0847 FE80     CP     #80          ;
0849 3002     JR     NC,$84D      ;
084B 2601     LD     H,#01        ;
084D 228130   LD     ($3081),HL   ;
0850 CDAA01   CALL   $01AA        ; Write tone
0853 AF       XOR    A            ;
0854 C9       RET                 ;
0855 3D       DEC    A            ;
0856 C9       RET                 ;

; Initialization Routine Vector 13 (User Explosion Component)
0857 3E02     LD     A,#02        ;
0859 CDC801   CALL   $01C8        ;
085C 210000   LD     HL,$0000     ;
085F CDAA01   CALL   $01AA        ; Write tone
0862 218330   LD     HL,$3083     ;
0865 0E0F     LD     C,#0F        ;
0867 71       LD     (HL),C       ;
0868 CD9901   CALL   $0199        ; Set volume
086B 2C       INC    L            ;
086C 3630     LD     (HL),#30     ;
086E 2C       INC    L            ;
086F 3695     LD     (HL),#95     ;
0871 2C       INC    L            ;
0872 363D     LD     (HL),#3D     ;
0874 217000   LD     HL,$0070     ;
0877 228730   LD     ($3087),HL   ;
087A 228930   LD     ($3089),HL   ;
087D AF       XOR    A            ;
087E C9       RET                 ;

; Continue Sound Routine Vector 13 (User Explosion Component)
087F 218430   LD     HL,$3084     ;
0882 35       DEC    (HL)         ;
0883 7E       LD     A,(HL)       ;
0884 2828     JR     Z,$8AE       ;
0886 FE10     CP     #10          ;
0888 3810     JR     C,$89A       ;
088A 2C       INC    L            ;
088B 7E       LD     A,(HL)       ;
088C C6C9     ADD    A,#C9        ;
088E 77       LD     (HL),A       ;
088F 2C       INC    L            ;
0890 AE       XOR    (HL)         ;
0891 77       LD     (HL),A       ;
0892 6F       LD     L,A          ;
0893 2601     LD     H,#01        ;
0895 CDAA01   CALL   $01AA        ; Write tone
0898 AF       XOR    A            ;
0899 C9       RET                 ;
089A D610     SUB    #10          ;
089C ED44     NEG                 ;
089E 87       ADD    A,A          ;
089F 4F       LD     C,A          ;
08A0 0600     LD     B,#00        ;
08A2 2A8930   LD     HL,($3089)   ;
08A5 09       ADD    HL,BC        ;
08A6 228930   LD     ($3089),HL   ;
08A9 CDAA01   CALL   $01AA        ; Write tone
08AC AF       XOR    A            ;
08AD C9       RET                 ;
08AE 2D       DEC    L            ;
08AF 35       DEC    (HL)         ;
08B0 281C     JR     Z,$8CE       ;
08B2 4E       LD     C,(HL)       ;
08B3 CD9901   CALL   $0199        ; Set volume
08B6 2C       INC    L            ;
08B7 3A8530   LD     A,($3085)    ;
08BA E63F     AND    #3F          ;
08BC C630     ADD    A,#30        ;
08BE 77       LD     (HL),A       ;
08BF 2A8730   LD     HL,($3087)   ;
08C2 016000   LD     BC,$0060     ;
08C5 09       ADD    HL,BC        ;
08C6 228730   LD     ($3087),HL   ;
08C9 228930   LD     ($3089),HL   ;
08CC AF       XOR    A            ;
08CD C9       RET                 ;
08CE 3D       DEC    A            ;
08CF C9       RET                 ;

; Initialization Routine Vector 14 (User Explosion Component)
08D0 3E02     LD     A,#02        ;
08D2 CDC801   CALL   $01C8        ;
08D5 210000   LD     HL,$0000     ;
08D8 CDAA01   CALL   $01AA        ; Write tone
08DB 218B30   LD     HL,$308B     ;
08DE 0E0F     LD     C,#0F        ;
08E0 71       LD     (HL),C       ;
08E1 CD9901   CALL   $0199        ; Set volume
08E4 2C       INC    L            ;
08E5 3630     LD     (HL),#30     ;
08E7 2C       INC    L            ;
08E8 3695     LD     (HL),#95     ;
08EA 2C       INC    L            ;
08EB 363D     LD     (HL),#3D     ;
08ED 213800   LD     HL,$0038     ;
08F0 228F30   LD     ($308F),HL   ;
08F3 229130   LD     ($3091),HL   ;
08F6 AF       XOR    A            ;
08F7 C9       RET                 ;

; Continue Sound Routine Vector 14 (User Explosion Component)
08F8 218C30   LD     HL,$308C     ;
08FB 35       DEC    (HL)         ;
08FC 7E       LD     A,(HL)       ;
08FD 2823     JR     Z,$922       ;
08FF FE10     CP     #10          ;
0901 3810     JR     C,$913       ;
0903 2C       INC    L            ;
0904 7E       LD     A,(HL)       ;
0905 C6D3     ADD    A,#D3        ;
0907 77       LD     (HL),A       ;
0908 2C       INC    L            ;
0909 AE       XOR    (HL)         ;
090A 77       LD     (HL),A       ;
090B 6F       LD     L,A          ;
090C 2601     LD     H,#01        ;
090E CDAA01   CALL   $01AA        ; Write tone
0911 AF       XOR    A            ;
0912 C9       RET                 ;
0913 2A9130   LD     HL,($3091)   ;
0916 013000   LD     BC,$0030     ;
0919 09       ADD    HL,BC        ;
091A 229130   LD     ($3091),HL   ;
091D CDAA01   CALL   $01AA        ; Write tone
0920 AF       XOR    A            ;
0921 C9       RET                 ;
0922 2D       DEC    L            ;
0923 35       DEC    (HL)         ;
0924 281C     JR     Z,$942       ;
0926 4E       LD     C,(HL)       ;
0927 CD9901   CALL   $0199        ; Set volume
092A 2C       INC    L            ;
092B 3A8D30   LD     A,($308D)    ;
092E E63F     AND    #3F          ;
0930 C630     ADD    A,#30        ;
0932 77       LD     (HL),A       ;
0933 2A8F30   LD     HL,($308F)   ;
0936 010600   LD     BC,$0006     ;
0939 09       ADD    HL,BC        ;
093A 228F30   LD     ($308F),HL   ;
093D 229130   LD     ($3091),HL   ;
0940 AF       XOR    A            ;
0941 C9       RET                 ;
0942 3D       DEC    A            ;
0943 C9       RET                 ;

; Initialization Routine Vector 15 (User Explosion Component)
0944 3E01     LD     A,#01        ;
0946 CDC801   CALL   $01C8        ;
0949 219330   LD     HL,$3093     ;
094C 3600     LD     (HL),#00     ;
094E 2C       INC    L            ;
094F 36D0     LD     (HL),#D0     ;
0951 2C       INC    L            ;
0952 0E0D     LD     C,#0D        ;
0954 71       LD     (HL),C       ;
0955 CD9901   CALL   $0199        ; Set volume
0958 2C       INC    L            ;
0959 3693     LD     (HL),#93     ;
095B 2C       INC    L            ;
095C 36D5     LD     (HL),#D5     ;
095E 21C000   LD     HL,$00C0     ;
0961 CDAA01   CALL   $01AA        ; Write tone
0964 AF       XOR    A            ;
0965 C9       RET                 ;

; Continue Sound Routine Vector 15 (User Explosion Component)
0966 219330   LD     HL,$3093     ;
0969 35       DEC    (HL)         ;
096A 7E       LD     A,(HL)       ;
096B E603     AND    #03          ;
096D 2029     JR     NZ,$998      ;
096F 2C       INC    L            ;
0970 35       DEC    (HL)         ;
0971 2827     JR     Z,$99A       ;
0973 7E       LD     A,(HL)       ;
0974 FE98     CP     #98          ;
0976 28D9     JR     Z,$951       ;
0978 FE80     CP     #80          ;
097A 28D5     JR     Z,$951       ;
097C 2C       INC    L            ;
097D E60F     AND    #0F          ;
097F 2005     JR     NZ,$986      ;
0981 35       DEC    (HL)         ;
0982 4E       LD     C,(HL)       ;
0983 CD9901   CALL   $0199        ; Set volume
0986 2C       INC    L            ;
0987 7E       LD     A,(HL)       ;
0988 C653     ADD    A,#53        ;
098A 77       LD     (HL),A       ;
098B 2C       INC    L            ;
098C AE       XOR    (HL)         ;
098D 77       LD     (HL),A       ;
098E 6F       LD     L,A          ;
098F FEE0     CP     #E0          ;
0991 3801     JR     C,$994       ;
0993 AF       XOR    A            ;
0994 67       LD     H,A          ;
0995 CDAA01   CALL   $01AA        ; Write tone
0998 AF       XOR    A            ;
0999 C9       RET                 ;
099A 3D       DEC    A            ;
099B C9       RET                 ;

; Initialization Routine Vector 16 (Pickup Parachute)
099C AF       XOR    A            ;
099D CDC801   CALL   $01C8        ;
09A0 0E09     LD     C,#09        ;
09A2 CD9901   CALL   $0199        ; Set volume
09A5 219930   LD     HL,$3099     ;
09A8 3EF6     LD     A,#F6        ;
09AA D606     SUB    #06          ;
09AC 77       LD     (HL),A       ;
09AD D67E     SUB    #7E          ;
09AF 281E     JR     Z,$9CF       ;
09B1 2D       DEC    L            ;
09B2 3630     LD     (HL),#30     ;
09B4 213000   LD     HL,$0030     ;
09B7 CDAA01   CALL   $01AA        ; Write tone
09BA AF       XOR    A            ;
09BB C9       RET                 ;

; Continue Sound Routine Vector 16 (Pickup Parachute)
09BC 219830   LD     HL,$3098     ;
09BF 7E       LD     A,(HL)       ;
09C0 C606     ADD    A,#06        ;
09C2 77       LD     (HL),A       ;
09C3 2C       INC    L            ;
09C4 BE       CP     (HL)         ;
09C5 28E3     JR     Z,$9AA       ;
09C7 6F       LD     L,A          ;
09C8 2600     LD     H,#00        ;
09CA CDAA01   CALL   $01AA        ; Write tone
09CD AF       XOR    A            ;
09CE C9       RET                 ;
09CF 3D       DEC    A            ;
09D0 C9       RET                 ;

; Initialization Routine Vector 17 (Free Man)
09D1 3E01     LD     A,#01        ;
09D3 CDC801   CALL   $01C8        ;
09D6 0E0F     LD     C,#0F        ;
09D8 CD9901   CALL   $0199        ; Set volume
09DB 219A30   LD     HL,$309A     ;
09DE 361D     LD     (HL),#1D     ;
09E0 2C       INC    L            ;
09E1 2D       DEC    L            ;
09E2 35       DEC    (HL)         ;
09E3 7E       LD     A,(HL)       ;
09E4 281A     JR     Z,$A00       ;
09E6 2C       INC    L            ;
09E7 77       LD     (HL),A       ;
09E8 87       ADD    A,A          ;
09E9 6F       LD     L,A          ;
09EA 2600     LD     H,#00        ;
09EC CDAA01   CALL   $01AA        ; Write tone
09EF AF       XOR    A            ;
09F0 C9       RET                 ;

; Continue Sound Routine Vector 17 (Free Man)
09F1 219B30   LD     HL,$309B     ;
09F4 35       DEC    (HL)         ;
09F5 28EA     JR     Z,$9E1       ;
09F7 6E       LD     L,(HL)       ;
09F8 2600     LD     H,#00        ;
09FA 29       ADD    HL,HL        ;
09FB CDAA01   CALL   $01AA        ; Write tone
09FE AF       XOR    A            ;
09FF C9       RET                 ;
0A00 3D       DEC    A            ;
0A01 C9       RET                 ;

; Initialization Routine Vector 18 (Time Jump 1)
0A02 AF       XOR    A            ;
0A03 CDC801   CALL   $01C8        ;
0A06 0E0A     LD     C,#0A        ;
0A08 CD9901   CALL   $0199        ; Set volume
0A0B 3E80     LD     A,#80        ;
0A0D 329E30   LD     ($309E),A    ;
0A10 219C30   LD     HL,$309C     ;
0A13 3600     LD     (HL),#00     ;
0A15 2C       INC    L            ;
0A16 36C0     LD     (HL),#C0     ;
0A18 21C000   LD     HL,$00C0     ;
0A1B CDAA01   CALL   $01AA        ; Write tone
0A1E AF       XOR    A            ;
0A1F C9       RET                 ;

; Continue Sound Routine Vector 18 (Time Jump 1)
0A20 219C30   LD     HL,$309C     ;
0A23 35       DEC    (HL)         ;
0A24 CB46     BIT    0,(HL)       ;
0A26 23       INC    HL           ;
0A27 7E       LD     A,(HL)       ;
0A28 2015     JR     NZ,$A3F      ;
0A2A 35       DEC    (HL)         ;
0A2B 7E       LD     A,(HL)       ;
0A2C FE20     CP     #20          ;
0A2E 2818     JR     Z,$A48       ;
0A30 2C       INC    L            ;
0A31 BE       CP     (HL)         ;
0A32 3A9D30   LD     A,($309D)    ;
0A35 2009     JR     NZ,$A40      ;
0A37 7E       LD     A,(HL)       ;
0A38 C605     ADD    A,#05        ;
0A3A 77       LD     (HL),A       ;
0A3B 2D       DEC    L            ;
0A3C C3160A   JP     $0A16        ;
0A3F 1F       RRA                 ;
0A40 6F       LD     L,A          ;
0A41 2600     LD     H,#00        ;
0A43 CDAA01   CALL   $01AA        ; Write tone
0A46 AF       XOR    A            ;
0A47 C9       RET                 ;
0A48 3EFF     LD     A,#FF        ;
0A4A C9       RET                 ;

; Initialization Routine Vector 19 (Time Jump 2)
0A4B AF       XOR    A            ;
0A4C CDC801   CALL   $01C8        ;
0A4F 21C000   LD     HL,$00C0     ;
0A52 CDAA01   CALL   $01AA        ; Write tone
0A55 0E0F     LD     C,#0F        ;
0A57 CD9901   CALL   $0199        ; Set volume
0A5A 219F30   LD     HL,$309F     ;
0A5D 3600     LD     (HL),#00     ;
0A5F 2C       INC    L            ;
0A60 3610     LD     (HL),#10     ;
0A62 2C       INC    L            ;
0A63 3603     LD     (HL),#03     ;
0A65 2C       INC    L            ;
0A66 3605     LD     (HL),#05     ;
0A68 AF       XOR    A            ;
0A69 C9       RET                 ;

; Continue Sound Routine Vector 19 (Time Jump 2)
0A6A 219F30   LD     HL,$309F     ;
0A6D 35       DEC    (HL)         ;
0A6E 7E       LD     A,(HL)       ;
0A6F 2C       INC    L            ;
0A70 E63F     AND    #3F          ;
0A72 2003     JR     NZ,$A77      ;
0A74 35       DEC    (HL)         ;
0A75 2819     JR     Z,$A90       ;
0A77 E603     AND    #03          ;
0A79 2013     JR     NZ,$A8E      ;
0A7B 56       LD     D,(HL)       ;
0A7C 2C       INC    L            ;
0A7D 7E       LD     A,(HL)       ;
0A7E C605     ADD    A,#05        ;
0A80 77       LD     (HL),A       ;
0A81 2C       INC    L            ;
0A82 AE       XOR    (HL)         ;
0A83 E60F     AND    #0F          ;
0A85 77       LD     (HL),A       ;
0A86 BA       CP     D            ;
0A87 3801     JR     C,$A8A       ;
0A89 AF       XOR    A            ;
0A8A 4F       LD     C,A          ;
0A8B CD9901   CALL   $0199        ; Set volume
0A8E AF       XOR    A            ;
0A8F C9       RET                 ;
0A90 3D       DEC    A            ;
0A91 C9       RET                 ;

; Initialize sound routines
0A92 9701 ;   Write 0 to voice
0A94 E703 ; 0 Coin Drop
0A96 3204 ; 0 Plane Fire
0A98 6204 ; 0 1910 Bomb
0A9A 9A04 ; 1 ? Semi-boss ?
0A9C D904 ; 0 ? Missile ?
0A9E 0A05 ; 0 ? Space-tracker
0AA0 4D05 ; 0 User Fire
0AA2 8805 ; 1 Enemy Explosion Component (thud)
0AA4 C805 ; 1 Enemy Explosion Component (white-noise)
0AA6 1B06 ; 0 Tracker or Bomb Explosion
0AA8 5E06 ; 0 Squad Appears
0AAA 9506 ; 1 1st Boss
0AAC D906 ; 1 2nd Boss
0AAE 1507 ; 1 3rd Boss
0AB0 5C07 ; 1 4th Boss
0AB2 8A07 ; 1 5th Boss
0AB4 C607 ; 1 User Explosion Component
0AB6 0B08 ; 1 User Explosion Component
0AB8 5708 ; 2 User Explosion Component
0ABA D008 ; 2 User Explosion Component
0ABC 4409 ; 1 User Explosion Component
0ABE 9C09 ; 0 Pickup Parachute
0AC0 D109 ; 1 Free Man
0AC2 020A ; 0 Time Jump 1
0AC4 4B0A ; 0 Time Jump 2
0AC6 160B ; 0 Initialize song 2
0AC8 1A0B ; 1 Initialize song 1
0ACA 3B0B ; 0 Initialize music D1
0ACC 3B0B ; 0 Initialize music D2
0ACE 3B0B ; 0 Initialize music D3
0AD0 3B0B ; 0 Initialize music D4
0AD2 3B0B ; 0 Initialize music D5

; Continue sound routines
0AD4 0000 ; Place holder for initialize command
0AD6 0204 ;
0AD8 4B04 ;
0ADA 7A04 ;
0ADC B304 ;
0ADE F504 ;
0AE0 2805 ;
0AE2 6C05 ;
0AE4 A405 ;
0AE6 EA05 ;
0AE8 3A06 ;
0AEA 7706 ;
0AEC B406 ;
0AEE F606 ;
0AF0 3207 ;
0AF2 7407 ;
0AF4 AA07 ;
0AF6 E507 ;
0AF8 2908 ;
0AFA 7F08 ;
0AFC F808 ;
0AFE 6609 ;
0B00 BC09 ;
0B02 F109 ;
0B04 200A ;
0B06 6A0A ;
0B08 0000 ; -- Playing song 0 (never kept in buffer)
0B0A 0000 ; -- Playing song 1 (never kept in buffer)
0B0C 410B ; Continue music D1
0B0E 4A0B ; Continue music D2
0B10 530B ; Continue music D3
0B12 5C0B ; Continue music D4
0B14 650B ; Continue music D5

; Initialization Routine Vector 1A
0B16 AF       XOR    A            ; Play song 0
0B17 C31C0B   JP     $0B1C        ; Play it

; Initialization Routine Vector 1B
0B1A 3E01     LD     A,#01        ; Play song 1
0B1C CD7E03   CALL   $037E        ; Initialize music descriptors
0B1F 110030   LD     DE,$3000     ; Command table
0B22 212F0B   LD     HL,$0B2F     ; Fill ...
0B25 010C00   LD     BC,$000C     ; ... symultaneous
0B28 EDB0     LDIR                ; ... commands
0B2A E1       POP    HL           ; Clean ...
0B2B E1       POP    HL           ; ... stack frame
0B2C C3BF00   JP     $00BF        ; Goto main loop

; Play song command buffer
0B2F 1C00 ; All five music processors playing
0B31 1D00 ; ...
0B33 1E00 ; ...
0B35 1F00 ; ...
0B37 2000 ; ...
0B39 0000 ;

; Initialization Routine Vector 1C,1D,1E,1F,20 Music
; Do nothing.
0B3B AF       XOR    A            ; 
0B3C CDC801   CALL   $01C8        ; That mysterious routine ?
0B3F AF       XOR    A            ; Initialized 
0B40 C9       RET                 ; Done

; Continue Sound Routine Vector 1C
0B41 DD210F30 LD     IX,$300F     ; Descriptor 1
0B45 CDFC01   CALL   $01FC        ; Process
0B48 AF       XOR    A            ; Continue flag
0B49 C9       RET                 ; Done

; Continue Sound Routine Vector 1D
0B4A DD211930 LD     IX,$3019     ; Descriptor 2
0B4E CDFC01   CALL   $01FC        ; Process
0B51 AF       XOR    A            ; Continue flag
0B52 C9       RET                 ; Done

; Continue Sound Routine Vector 1E
0B53 DD212330 LD     IX,$3023     ; Descriptor 3
0B57 CDFC01   CALL   $01FC        ; Process
0B5A AF       XOR    A            ; Continue flag
0B5B C9       RET                 ; Done

; Continue Sound Routine Vector 1F
0B5C DD212D30 LD     IX,$302D     ; Descriptor 4
0B60 CDFC01   CALL   $01FC        ; Process
0B63 AF       XOR    A            ; Continue flag
0B64 C9       RET                 ; Done

; Continue Sound Routine Vector 20
0B65 DD213730 LD     IX,$3037     ; Descriptor 5
0B69 CDFC01   CALL   $01FC        ; Process
0B6C AF       XOR    A            ; Continue flag
0B6D C9       RET                 ; Done

; Descriptor pointers for songs (10 bytes each)
; Song 0
0B6E 820B
0B70 B20B
0B72 E20B
0B84 080C
0B76 2D0C
; Song 1
0B78 2E0C
0B7A 700C
0B7C AD0C
0B7E EB0C
0B80 040D

;Song data
; Song 0 Descriptor 0
0B82 1F0E3F165F0081605F0866A8AD927F
0B91 00B1917FFFB1B2917F00D4B47FFFB4
0BA0 60743F1377767474737171706D6D70
0BAF 71ADFF

; Song 0 Descriptor 1
0BB2 1F023F165F0081605F0866A8AD927F
0BC1 00B1917FFFB1B2917F00D4B47FFFB4
0BD0 60743F1377767474737171706D6D70
0BDF 71ADFF

; Song 0 Descriptor 2
0BE2 1F0E3F135F088D6D8D6D8D6D8D6D8D
0BF1 6D8D6D8D6D8D6D8868856086608760
0C00 7F00CB7FFFABADFF

; Song 0 Descriptor 3
0C08 1F023F135F088D6D8D6D8D6D8D6D8D
0C17 6D8D6D8D6D8D6D8868856086608760
0C26 7F00CB7FFFABAD

; Song 0 Descriptor 4
0C2D FF

; Song 1 Descriptor 0
0C2E 1F0E3F155F00815F07656525252525
0C3D A5856585656580656525252525A585
0C4C 6561686C6F806A6A2A2A2A2AAA8A6A
0C5B 8A6A6A806A6A2A2A2A2AAA8A686868
0C6A 6A6A80DF370C

; Song 1 Descriptor 1
0C70 1F0E3F155F00815F07686828282828
0C7F A8886888686880686828282828A888
0C8E A860806D6D2D2D2D2DAD8D6D8D6D6D
0C9D 806D6D2D2D2D2DAD8D6D6D6DADDF79
0CAC 0C

; Song 1 Descriptor 2
0CAD 1F0E3F155F00815F076C6C2C2C2C2C
0CBC AC8C6C8C6C6C806C6C2C2C2C2CAC8C
0CCB AC6080727232323232B29272927272
0CDA 80727232323232B2927272729280DF
0CE9 B60C

; Song 1 Descriptor 3
0CEB 1F0E3F155F00E1E0E0C0A05F077874
0CFA 7976E0E0E0C0A0DFF80C

; Song 1 Descriptor 4
0D04 1F023F155F078D606D88606D606D60
0D13 6D2828282888608D606D88606D606D
0D22 606D886D688F606F8A606F606F606F
0D31 2A2A2A2A8A608F606F8A608F8F6F6A
0D40 6F6A6EDF0A0D1F0E3F165F09BFB3B2
0D4F A9B0B9BBBAAEE2B7B3B4C1B5B9FF

; FF from here to end of ROM -- typical for EPROM fills.

