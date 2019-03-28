;				Atari Combat Game



; Memory Usage
; E0-E3		score pattern offsets
; DE-DF		score pattern calculation temporaries
; A1-A2		scores
; D2		score conversion temporary

; 9B-9C		sound pitch storage
; B5-BA		lo-res indirect addresses
; DA		hi-res patterns
; D6-D7		colors



;=============================================================================
; HARDWARE
;
; TIA WRITE ADDRESSES
SYNC   .EQU $0000
VBLANK .EQU $0001
WSYNC  .EQU $0002
RSYNC  .EQU $0003
NUSIZ0 .EQU $0004
NUSIZ1 .EQU $0005
COLUP0 .EQU $0006
COLUP1 .EQU $0007
COLUPF .EQU $0008
COLUBK .EQU $0009
CTRLPF .EQU $000A
REFP0  .EQU $000B
REFP1  .EQU $000C
PF0    .EQU $000D
PF1    .EQU $000E
PF2    .EQU $000F
RESP0  .EQU $0010
RESP1  .EQU $0011
RESM0  .EQU $0012
RESM1  .EQU $0013
RESBL  .EQU $0014
AUDC0  .EQU $0015
AUDC1  .EQU $0016
AUDF0  .EQU $0017
AUDF1  .EQU $0018
AUDV0  .EQU $0019
AUDV1  .EQU $001A
GRP0   .EQU $001B
GRP1   .EQU $001C
ENAM0  .EQU $001D
ENAM1  .EQU $001E
ENABL  .EQU $001F
HMP0   .EQU $0020
HMP1   .EQU $0021
HMM0   .EQU $0022
HMM1   .EQU $0023
HMBL   .EQU $0024
VDELP0 .EQU $0025
VDEL01 .EQU $0026
VDELBL .EQU $0027
RESMP0 .EQU $0028
RESMP1 .EQU $0029
HMOVE  .EQU $002A
HMCLR  .EQU $002B
CXCLR  .EQU $002C
;
; TIA READ ADDRESSES (Ghosting from the $0000 base?)
CXM0P  .EQU $0030
CXM1P  .EQU $0031
CXP0FB .EQU $0032
CXP1FB .EQU $0033
CXM0FB .EQU $0034
CXM1FB .EQU $0035
CXBLPF .EQU $0036
CXPPMM .EQU $0037
INPT0  .EQU $0038
INPT1  .EQU $0039
INPT2  .EQU $003A
INPT3  .EQU $003B
INPT4  .EQU $003C
INPT5  .EQU $003D
;
; PIA I/O
SWCHA  .EQU $0280
SWACNT .EQU $0281
SWCHB  .EQU $0282
SWBCNT .EQU $0283
; PIA Timer
INTIM  .EQU $0284
TIM1T  .EQU $0294
TIM8T  .EQU $0295
TIM64T .EQU $0296
T1024T .EQU $0297
;
;=============================================================================

.org $F000

		SEI  
		CLD  
		LDX  #$FF			; Start stack ...
		TXS					; ... at top of RAM
		LDX  #$5D			; Clear memory from ... 
		JSR  ClearMemory	; ... $00 - $A2		
		LDA  #$10
		STA  SWCHB+1
		STA  $88
		JSR  J11A3

MLOOP	JSR  NWSCR		; $1014
		JSR  J1157
		JSR  J1572
		JSR  J12DA
		JSR  J1444
		JSR  J1214
		JSR  J12A9
		JSR  J11F2
		JSR  J1054
		JMP  MLOOP

;----------------------------------------------------------------------------
; VIDEO KERNEL
;----------------------------------------------------------------------------

NWSCR	INC  $86;		initial blanking and retrace start
		STA  HMCLR
		LDA  #$02
		STA  WSYNC
		STA  VBLANK
		STA  WSYNC
		STA  WSYNC
		STA  WSYNC		
		STA  SYNC
		STA  WSYNC
		STA  WSYNC
		LDA  #$00
		STA  WSYNC
		STA  SYNC
		LDA  #$2B
		STA  TIM64T
		RTS  

J1054	LDA  #$20
		STA  $B4
		STA  WSYNC
		STA  HMOVE
B105C	LDA  INTIM
		BNE  B105C
		STA  WSYNC
		STA  CXCLR
		STA  VBLANK
		TSX  
		STX  $D3 ;		Save stack pointer
		LDA  #$02
		STA  CTRLPF
		LDX  $DC
B1070	STA  WSYNC
		DEX  
		BNE  B1070
		LDA  $DC
		CMP  #$0E
		BEQ  B10CD
		LDX  #$05
		LDA  #$00
		STA  $DE
		STA  $DF
J1083	STA  WSYNC
		LDA  $DE
		STA  PF1
		LDY  $E2
		LDA  L15C5,Y
		AND  #$F0
		STA  $DE
		LDY  $E0
		LDA  $L15C5,Y
		AND  #$0F
		ORA  $DE
		STA  $DE
		LDA  $DF
		STA  PF1
		LDY  $E3
		LDA  L15C5,Y
		AND  #$F0
		STA  $DF
		LDY  $E1
		LDA  L15C5,Y
		AND  $87
		STA  WSYNC
		ORA  $DF
		STA  $DF
		LDA  $DE
		STA  PF1
		DEX  
		BMI  B10CD
		INC  $E0
		INC  $E2
		INC  $E1
		INC  $E3
		LDA  $DF
		STA  PF1
		JMP  J1083
;

B10CD	LDA  #$00 ;		Inner Display Loop
		STA  PF1
		STA  WSYNC		
		LDA  #$05
		STA  CTRLPF
		LDA  $D6
		STA  COLUP0
		LDA  $D7
		STA  COLUP1
B10DF	LDX  #$1E
		TXS ;			Very Sneaky - set stack to missle registers
		SEC  
		LDA  $A4
		SBC  $B4
		AND  #$FE
		TAX  
		AND  #$F0
		BEQ  B10F2
		LDA  #$00
		BEQ  B10F4
B10F2	LDA  $BD,X
B10F4	STA  WSYNC ;		End of 1 line
		STA  GRP0
		LDA  $A7
		EOR  $B4
		AND  #$FE
		PHP ;			This turns the missle 1 on/off
		LDA  $A6
		EOR  $B4
		AND  #$FE
		PHP ;			This turns the missle 0 on/off
		LDA  $B4
		BPL  B110C
		EOR  #$F8
B110C	CMP  #$20
		BCC  B1114
		LSR  A
		LSR  A
		LSR  A
		TAY  
B1114	LDA  $A5
		SEC  
		SBC  $B4
		INC  $B4
		NOP  
		ORA  #$01
		TAX  
		AND  #$F0
		BEQ  B1127
		LDA  #$00
		BEQ  B1129
B1127	LDA  $BD,X
B1129	BIT  $82
		STA  GRP1
		BMI  B113B
		LDA  ($B5),Y
		STA  PF0
		LDA  ($B7),Y
		STA  PF1
		LDA  ($B9),Y
		STA  PF2
B113B	INC  $B4
		LDA  $B4
		EOR  #$EC
		BNE  B10DF
		LDX  $D3 ;		Restore stack pointer
		TXS  
		STA  ENAM0
		STA  ENAM1
		STA  GRP0
		STA  GRP1
		STA  GRP0
		STA  PF0
		STA  PF1
		STA  PF2
		RTS  
;

J1157	LDA  SWCHB
		LSR  A
		BCS  B1170
		LDA  #$0F
		STA  $87
		LDA  #$FF
		STA  $88
		LDA  #$80
		STA  $DD
		LDX  #$E6
		JSR  ClearMemory ;		zero out $89 thru $A2
		BEQ  B11D0
B1170	LDY  #$02
		LDA  $DD
		AND  $88
		CMP  #$F0
		BCC  B1182
		LDA  $86
		AND  #$30
		BNE  B1182
		LDY  #$0E
B1182	STY  $DC
		LDA  $86
		AND  #$3F
		BNE  B1192
		STA  $89
		INC  $DD
		BNE  B1192
		STA  $88
B1192	LDA  SWCHB
		AND  #$02
		BEQ  B119D
		STA  $89
		BNE  B11F1
B119D	BIT  $89
		BMI  B11F1
		INC  $80
J11A3	LDX  #$DF
B11A5	JSR  ClearMemory
		LDA  #$FF
		STA  $89
		LDY  $80
		LDA  L17D8,Y
		STA  $A3
		EOR  #$FF
		BNE  B11BB
		LDX  #$DD
		BNE  B11A5
B11BB	LDA  $81
		SED  
		CLC  
		ADC  #$01
		STA  $81
		STA  $A1
		CLD  
		BIT  $A3
		BPL  B11D0
		INC  $85
		BVC  B11D0
		INC  $85
B11D0	JSR  J1525
		LDA  #$32
		STA  $A5
		LDA  #$86
		STA  $A4
		BIT  $A3
		BMI  B11F1
		STA  $A5
		STA  RESP1
		LDA  #$08
		STA  $96
		LDA  #$20
		STA  HMP0
		STA  HMP1
		STA  WSYNC
		STA  HMOVE
B11F1	RTS  
;
J11F2	LDX  #$01 ;		convert BCD scores to score pattern offset
B11F4	LDA  $A1,X
		AND  #$0F
		STA  $D2
		ASL  A
		ASL  A
		CLC  
		ADC  $D2
		STA  $E0,X
		LDA  $A1,X
		AND  #$F0
		LSR  A
		LSR  A
		STA  $D2
		LSR  A
		LSR  A
		CLC  
		ADC  $D2
		STA  $E2,X
		DEX  
		BPL  B11F4
		RTS  
;
J1214	BIT  $83
		BVC  B121C
		LDA  #$30
		BPL  B121E
B121C	LDA  #$20
B121E	STA  $B1
		LDX  #$03
		JSR  J1254
		DEX  
		JSR  J1254
		DEX  
B122A	LDA  $8D,X
		AND  #$08
		LSR  A
		LSR  A
		STX  $D1
		CLC  
		ADC  $D1
		TAY  
		LDA  $00A8,Y
		SEC  
		BMI  B123D
		CLC  
B123D	ROL  A
		STA  $00A8,Y
		BCC  B1250
		LDA  $AC,X
		AND  #$01
		ASL  A
		ASL  A
		ASL  A
		ASL  A
		STA  $B1
		JSR  J1254
B1250	DEX  
		BEQ  B122A
		RTS  
;
J1254	INC  $AC,X
		LDA  $95,X
		AND  #$0F
		CLC  
		ADC  $B1
		TAY  
		LDA  L15F7,Y
		STA  $B0
		BIT  $82
		BVS  B127A
		LDA  $95,X
		SEC  
		SBC  #$02
		AND  #$03
		BNE  B127A
		LDA  $AC,X
		AND  #$03
		BNE  B127A
		LDA  #$08
		STA  $B0
B127A	LDA  $B0
J127C	STA  HMP0,X
		AND  #$0F
		SEC  
		SBC  #$08
		STA  $D4
		CLC  
		ADC  $A4,X
		BIT  $A3
		BMI  B1290
		CPX  #$02
		BCS  B12A0
B1290	CMP  #$DB
		BCS  B1298
		CMP  #$25
		BCS  B12A0
B1298	LDA  #$D9
		BIT  $D4
		BMI  B12A0
		LDA  #$28
B12A0	STA  $A4,X
		CPX  #$02
		BCS  B12A8
		STA  VDELP0,X
B12A8	RTS  


;
J12A9	LDA  #$01
		AND  $86
		TAX  
		LDA  $95,X
		STA  REFP0,X
		AND  #$0F
		TAY  
		BIT  $83
		BPL  B12BB
		STY  $97,X
B12BB	TXA  
		EOR  #$0E
		TAX  
		TYA  
		ASL  A
		ASL  A
		ASL  A
		CMP  #$3F
		CLC  
		BMI  B12CB
		SEC  
		EOR  #$47
B12CB	TAY  
B12CC	LDA  ($BB),Y
		STA  $BD,X
		BCC  B12D4
		DEY  
		DEY		 
B12D4	INY  
		DEX  
		DEX  
		BPL  B12CC
		RTS  
;
J12DA	LDA  $8A
		SEC  
		SBC  #$02
		BCC  B130C
		STA  $8A
		CMP  #$02
		BCC  B130B
		AND  #$01
		TAX  
		INC  $95,X
		LDA  $D8,X
		STA  $D6,X
		LDA  $8A
		CMP  #$F7
		BCC  B12F9
		JSR  J1508
B12F9	LDA  $8A
		BPL  B130B
		LSR  A
		LSR  A
		LSR  A
J1300	STA  AUDV0,X
		LDA  #$08
		STA  AUDC0,X
		LDA  L17FE,X
		STA  AUDF0,X
B130B	RTS
;
B130C	LDX  #$01
		LDA  SWCHB
		STA  $D5
		LDA  SWCHA
B1316	BIT  $88
		BMI  B131C
		LDA  #$FF
B131C	EOR  #$FF
		AND  #$0F
		STA  $D2
		LDY  $85
		LDA  L170F,Y
		CLC  
		ADC  $D2
		TAY  
		LDA  L1712,Y
		AND  #$0F
		STA  $D1
		BEQ  B1338
		CMP  $91,X
		BNE  B133C
B1338	DEC  $93,X
		BNE  B1349
B133C	STA  $91,X
		LDA  #$0F
		STA  $93,X
		LDA  $D1
		CLC  
		ADC  $95,X
		STA  $95,X
B1349	INC  $8D,X
		BMI  B136B
		LDA  L1712,Y
		LSR  A
		LSR  A
		LSR  A
		LSR  A
		BIT  $D5
		BMI  B137B
B1358	STA  $8B,X
		ASL  A
		TAY  
		LDA  L1637,Y
		STA  $A8,X
		INY  
		LDA  L1637,Y
		STA  $AA,X
		LDA  #$F0
		STA  $8D,X
B136B	JSR  J1380
		LDA  SWCHA
		LSR  A
		LSR  A
		LSR  A
		LSR  A
		ASL  $D5
		DEX  
		BEQ  B1316
		RTS  
;
B137B	SEC  
		SBC  $85
		BPL  B1358
J1380	LDA  $A3
		BMI  B138C
		AND  #$01
		BEQ  B138C
		LDA  $DB
		STA  $D6,X
B138C	LDA  $99,X
		BEQ  B13B7
		LDA  $D8,X
		STA  $D6,X
		LDA  $99,X
		CMP  #$07
		BCC  J13AE
		BIT  $D5
		BPL  B13A2
		CMP  #$1C
		BCC  J13AE
B13A2	CMP  #$30
		BCC  B13C5
		CMP  #$37
		BCS  J13CB
		BIT  $83
		BVC  J13CB
J13AE	LDA  #$00
		STA  $99,X
		LDA  #$FF
B13B4	STA  RESMP0,X
		RTS  
;
B13B7	BIT  $88
		BPL  B13BF
		LDA  INPT4,X
		BPL  B13F6
B13BF	JSR  J1410
		JMP  J13AE
;
B13C5	JSR  J1410
		JMP  J13DE
;
J13CB	LDA  $9F,X
		BEQ  B13D9
		JSR  J1410
		LDA  #$30
		STA  $99,X
		JMP  J13DE
;
B13D9	LDA  $99,X
		JSR  J1300
J13DE	LDA  $86
		AND  #$03
		BEQ  B13F0
		BIT  $84
		BVS  B13F2
		BIT  $82
		BVC  B13F0
		AND  #$01
		BNE  B13F2
B13F0	DEC  $99,X
B13F2	LDA  #$00
		BEQ  B13B4
B13F6	LDA  #$3F
		STA  $99,X
		SEC  
		LDA  $A4,X
		SBC  #$06
		STA  $A6,X
		LDA  $95,X
		STA  $97,X
		LDA  #$1F
		STA  $9B,X
		LDA  #$00
		STA  $9D,X
		JMP  J13CB
;
J1410	LDA  $9F,X
		BEQ  B1421
		LDA  #$04
		STA  AUDC0,X
		LDA  #$07
		STA  AUDV0,X
		LDA  $9B,X
		STA  AUDF0,X
		RTS  
;
B1421	LDY  $85
		LDA  L1733,Y
		AND  $88
		STA  AUDV0,X
		LDA  L1736,Y
		STA  AUDC0,X
		CLC  
		LDA  #$00
B1432	DEY  
		BMI  B1439
		ADC  #$0C
		BPL  B1432
B1439	ADC  $8B,X
		TAY  
		TXA  
		ASL  A
		ADC  L1739,Y
		STA  AUDF0,X
		RTS  
;
J1444	LDX  #$01
J1446	LDA  CXM0P,X
		BPL  B1476
		BIT  $84
		BVC  B1454
		LDA  $9B,X
		CMP  #$1F
		BEQ  B1476
B1454	INC  $95,X
		INC  $97,X
		SED  
		LDA  $A1,X
		CLC  
		ADC  #$01
		STA  $A1,X
		CLD  
		TXA  
		CLC  
		ADC  #$FD
		STA  $8A
		LDA  #$FF
		STA  RESMP0
		STA  RESMP1
		LDA  #$00
		STA  AUDV0,X
		STA  $99
		STA  $9A
		RTS  
;
B1476	BIT  $A3
		BPL  B147D
		JMP  J1501
;
B147D	LDA  $9F,X
		BEQ  B148B
		CMP  #$04
		INC  $9F,X
		BCC  B148B
		LDA  #$00
		STA  $9F,X
B148B	LDA  CXM0FB,X
		BMI  B1496
		LDA  #$00
		STA  $9D,X
		JMP  J14D6
;
B1496	BIT  $82
		BVC  B14D0
		LDA  $9D,X
		BNE  B14B7
		INC  $9F,X
		DEC  $9B,X
		LDA  $97,X
		STA  $B2,X
		EOR  #$FF
		STA  $97,X
		INC  $97,X
		LDA  $97,X
		AND  #$03
		BNE  B14B4
		INC  $97,X
B14B4	JMP  J14D4
;
B14B7	CMP  #$01
		BEQ  B14C6
		CMP  #$03
		BCC  J14D4
		BNE  J14D4
		LDA  $B2,X
		JMP  J14C8
;
B14C6	LDA  $97,X
J14C8	CLC  
		ADC  #$08
		STA  $97,X
		JMP  J14D4
;
B14D0	LDA  #$01
		STA  $99,X
J14D4	INC  $9D,X
J14D6	LDA  CXP0FB,X
		BMI  B14DE
		LDA  CXPPMM
		BPL  B14E7
B14DE	LDA  $8A
		CMP  #$02
		BCC  B14ED
		JSR  J1508
B14E7	LDA  #$03
		STA  $E4,X
		BNE  J1501
B14ED	DEC  $E4,X
		BMI  B14F7
		LDA  $8B,X
		BEQ  J1501
		BNE  B14F9
B14F7	INC  $95,X
B14F9	LDA  $95,X
		CLC  
		ADC  #$08
		JSR  J150F
J1501	DEX  
		BMI  B1507
		JMP  J1446
B1507	RTS  
;
J1508	TXA  
		EOR  #$01
		TAY  
		LDA  $0097,Y
J150F	AND  #$0F
		TAY  
		LDA  L1627,Y
		JSR  J127C
		LDA  #$00
		STA  $A8,X
		STA  $AA,X
		STA  $8D,X
		LDA  $D8,X
		STA  $D6,X
		RTS  

J1525	LDX  $85
		LDA  L17C6,X
		STA  $BB
		LDA  L17C9,X
		STA  $BC
		LDA  $A3
		LSR  A
		LSR  A
		AND  #$03
		TAX  
		LDA  $A3
		BPL  B1546
		AND  #$08
		BEQ  B1544
		LDX  #$03
		BPL  B1548
B1544	LDA  #$80
B1546	STA  $82
B1548	LDA  $A3
		ASL  A
		ASL  A
		BIT  $A3
		BMI  B1556
		STA  WSYNC
		STA  $84
		AND  #$80
B1556	STA  $83
		LDA  #$F7
		STA  $B6
		STA  $B8
		STA  $BA
		LDA  L17CC,X
		STA  RESP0
		STA  $B5
		LDA  L17D0,X
		STA  $B7
		LDA  L17D4,X
		STA  $B9
		RTS  
;
J1572	LDA  $A3
		AND  #$87
		BMI  B157A
		LDA  #$00
B157A	ASL  A
		TAX  
		LDA  L175D,X
		STA  NUSIZ0
		LDA  L175E,X
		STA  NUSIZ1
		LDA  $A3
		AND  #$C0
		LSR  A
		LSR  A
		LSR  A
		LSR  A
		TAY  
		LDA  $88
		STA  SWCHB
		EOR  #$FF
		AND  $DD
		STA  $D1
		LDX  #$FF
		LDA  SWCHB
		AND  #$08
		BNE  B15A7
		LDY  #$10
		LDX  #$0F
B15A7	STX  $D2
		LDX  #$03
B15AB	LDA  L1765,Y
		EOR  $D1
		AND  $D2
		STA  COLUP0,X
		STA  $D6,X
		STA  $D8,X
		INY  
		DEX  
		BPL  B15AB
		RTS  

;==============================================================
; Clear $A2[X++] until X==0
;
ClearMemory
;
		LDA  #$00
CLRM01	INX  
		STA  $A2,X
		BNE  CLRM01
		RTS  
;==============================================================

; Patterns for numbers
;
L15C5	
    .BYTE  $0E ,$0A ,$0A ,$0A ,$0E ; 00 
;  ....***.
;  ....*.*.
;  ....*.*.
;  ....*.*.
;  ....***.

	.BYTE  $22 ,$22 ,$22 ,$22 ,$22 ; 11
; ..*...*.
; ..*...*.
; ..*...*.
; ..*...*.
; ..*...*.

	.BYTE  $EE ,$22 ,$EE ,$88 ,$EE ; 22
; ***.***.
; ..*...*.
; ***.***.
; *...*...
; ***.***.

	.BYTE  $EE ,$22 ,$66 ,$22 ,$EE ; 33
; ***.***.
; ..*...*.
; .**..**.
; ..*...*.
; ***.***.

	.BYTE  $AA ,$AA ,$EE ,$22 ,$22 ; 44
; *.*.*.*.
; *.*.*.*.
; ***.***.
; ..*...*.
; ..*...*.

	.BYTE  $EE ,$88 ,$EE ,$22 ,$EE ; 55
; ***.***.
; *...*...
; ***.***.
; ..*...*.
; ***.***.

	.BYTE  $EE ,$88 ,$EE ,$AA ,$EE ; 66
; ***.***.
; *...*...
; ***.***.
; *.*.*.*.
; ***.***.

	.BYTE  $EE ,$22 ,$22 ,$22 ,$22 ; 77
; ***.***.
; ..*...*.
; ..*...*.
; ..*...*.
; ..*...*.

	.BYTE  $EE ,$AA ,$EE ,$AA ,$EE ; 88
; ***.***.
; *.*.*.*.
; ***.***.
; *.*.*.*.
; ***.***.

	.BYTE  $EE ,$AA ,$EE ,$22 ,$EE ; 99
; ***.***.
; *.*.*.*.
; ***.***.
; ..*...*.
; ***.***.

L15F7	
    .BYTE  $F8 ,$F7 ,$F6 ,$06 ,$06
	.BYTE  $06 ,$16 ,$17 ,$18 ;	$15FC
	.BYTE  $19 ,$1A ,$0A ,$0A ;	$1600
	.BYTE  $0A ,$FA ,$F9 ,$F8 ;	$1604
	.BYTE  $F7 ,$F6 ,$F6 ,$06 ;	$1608
	.BYTE  $16 ,$16 ,$17 ,$18 ;	$160C
	.BYTE  $19 ,$1A ,$1A ,$0A ;	$1610
	.BYTE  $FA ,$FA ,$F9 ,$E8 ;	$1614
	.BYTE  $E6 ,$E4 ,$F4 ,$04 ;	$1618
	.BYTE  $14 ,$24 ,$26 ,$28 ;	$161C
	.BYTE  $2A ,$2C ,$1C ,$0C ;	$1620
	.BYTE  $FC ,$EC ,$EA ;		$1624
;
L1627	
    .BYTE  $C8 ,$C4 ,$C0 ,$E0 ,$00
	.BYTE  $20 ,$40 ,$44 ,$48
	.BYTE  $4C ,$4F ,$2F ,$0F
	.BYTE  $EF ,$CF ,$CC
;
L1637	
        .BYTE $0, $0, $80, $80, $84, $20, $88, $88
; ........
; ........
; *.......
; *.......
; *....*..
; ..*.....
; *...*...
; *...*...
    .BYTE $92, $48, $a4, $a4, $a9, $52, $aa, $aa
; *..*..*.
; .*..*...
; *.*..*..
; *.*..*..
; *.*.*..*
; .*.*..*.
; *.*.*.*.
; *.*.*.*.
    .BYTE $d5, $aa, $da, $da, $db, $6d, $ee, $ee
; **.*.*.*
; *.*.*.*.
; **.**.*.
; **.**.*.
; **.**.**
; .**.**.*
; ***.***.
; ***.***.

    .BYTE $0, $fc, $fc, $38, $3f, $38, $fc, $fc
; ........
; ******..
; ******..
; ..***...
; ..******
; ..***...
; ******..
; ******..
    .BYTE $1c, $78, $fb, $7c, $1c, $1f, $3e, $18
; ...***..
; .****...
; *****.**
; .*****..
; ...***..
; ...*****
; ..*****.
; ...**...
    .BYTE $19, $3a, $7c, $ff, $df, $e, $1c, $18
; ...**..*
; ..***.*.
; .*****..
; ********
; **.*****
; ....***.
; ...***..
; ...**...
    .BYTE $24, $64, $79, $ff, $ff, $4e, $e, $4
; ..*..*..
; .**..*..
; .****..*
; ********
; ********
; .*..***.
; ....***.
; .....*..
    .BYTE $8, $8, $6b, $7f, $7f, $7f, $63, $63
; ....*...
; ....*...
; .**.*.**
; .*******
; .*******
; .*******
; .**...**
; .**...**
    .BYTE $24, $26, $9e, $ff, $ff, $72, $70, $20
; ..*..*..
; ..*..**.
; *..****.
; ********
; ********
; .***..*.
; .***....
; ..*.....
    .BYTE $98, $5c, $3e, $ff, $fb, $70, $38, $18
; *..**...
; .*.***..
; ..*****.
; ********
; *****.**
; .***....
; ..***...
; ...**...
    .BYTE $38, $1e, $df, $3e, $38, $f8, $7c, $18
; ..***...
; ...****.
; **.*****
; ..*****.
; ..***...
; *****...
; .*****..
; ...**...

    .BYTE $60, $70, $78, $ff, $78, $70, $60, $0
; .**.....
; .***....
; .****...
; ********
; .****...
; .***....
; .**.....
; ........
    .BYTE $0, $c1, $fe, $7c, $78, $30, $30, $30
; ........
; **.....*
; *******.
; .*****..
; .****...
; ..**....
; ..**....
; ..**....
    .BYTE $0, $3, $6, $fc, $fc, $3c, $c, $c
; ........
; ......**
; .....**.
; ******..
; ******..
; ..****..
; ....**..
; ....**..
    .BYTE $2, $4, $c, $1c, $fc, $fc, $1e, $6
; ......*.
; .....*..
; ....**..
; ...***..
; ******..
; ******..
; ...****.
; .....**.
    .BYTE $10, $10, $10, $38, $7c, $fe, $fe, $10
; ...*....
; ...*....
; ...*....
; ..***...
; .*****..
; *******.
; *******.
; ...*....
    .BYTE $40, $20, $30, $38, $3f, $3f, $78, $60
; .*......
; ..*.....
; ..**....
; ..***...
; ..******
; ..******
; .****...
; .**.....
    .BYTE $40, $60, $3f, $1f, $1e, $1e, $18, $18
; .*......
; .**.....
; ..******
; ...*****
; ...****.
; ...****.
; ...**...
; ...**...
    .BYTE $0, $83, $7f, $3e, $1e, $c, $c, $c
; ........
; *.....**
; .*******
; ..*****.
; ...****.
; ....**..
; ....**..
; ....**..

    .BYTE $0, $8e, $84, $ff, $ff, $4, $e, $0
; ........
; *...***.
; *....*..
; ********
; ********
; .....*..
; ....***.
; ........
    .BYTE $0, $e, $4, $8f, $7f, $72, $7, $0
; ........
; ....***.
; .....*..
; *...****
; .*******
; .***..*.
; .....***
; ........
    .BYTE $10, $36, $2e, $c, $1f, $b2, $e0, $40
; ...*....
; ..**.**.
; ..*.***.
; ....**..
; ...*****
; *.**..*.
; ***.....
; .*......
    .BYTE $24, $2c, $5d, $1a, $1a, $30, $f0, $60
; ..*..*..
; ..*.**..
; .*.***.*
; ...**.*.
; ...**.*.
; ..**....
; ****....
; .**.....
    .BYTE $18, $5a, $7e, $5a, $18, $18, $18, $78
; ...**...
; .*.**.*.
; .******.
; .*.**.*.
; ...**...
; ...**...
; ...**...
; .****...
    .BYTE $34, $36, $5a, $78, $2c, $c, $6, $c
; ..**.*..
; ..**.**.
; .*.**.*.
; .****...
; ..*.**..
; ....**..
; .....**.
; ....**..
    .BYTE $8, $6c, $70, $b8, $dc, $4e, $7, $6
; ....*...
; .**.**..
; .***....
; *.***...
; **.***..
; .*..***.
; .....***
; .....**.
    .BYTE $38, $10, $f0, $7c, $4f, $e3, $2, $0
; ..***...
; ...*....
; ****....
; .*****..
; .*..****
; ***...**
; ......*.
; ........


L170F	.BYTE  $00 ,$0B ,$16
L1712	.BYTE  $00 ,$10
		.BYTE  $00 ,$FF ,$01 ,$11 ;	$1714
		.BYTE  $01 ,$FF ,$0F ,$1F ;	$1718
		.BYTE  $0F ,$50 ,$5F ,$51 ;	$171C
		.BYTE  $FF ,$30 ,$3F ,$31 ;	$1720
		.BYTE  $FF ,$70 ,$7F ,$71 ;	$1724
		.BYTE  $90 ,$B0 ,$70 ,$FF ;	$1728
		.BYTE  $91 ,$B1 ,$71 ,$FF ;	$172C
		.BYTE  $9F ,$BF ,$7F ;		$1730

L1733	.BYTE  $08 ,$02 ,$02 ;		sound volumes
L1736	.BYTE  $02 ,$03 ,$08 ;		sound types
L1739	.BYTE  $1D ,$05 ,$00 ;		sound pitches
		.BYTE  $00 ,$00 ,$00 ,$00 ;	$173C
		.BYTE  $00 ,$00 ,$00 ,$00 ;	$1740
		.BYTE  $00 ,$00 ,$00 ,$1D ;	$1744
		.BYTE  $1D ,$16 ,$16 ,$0F ;	$1748
		.BYTE  $0F ,$00 ,$00 ,$00 ;	$174C
		.BYTE  $00 ,$00 ,$00 ,$00 ;	$1750
		.BYTE  $00 ,$00 ,$12 ,$10 ;	$1754
		.BYTE  $10 ,$0C ,$0C ,$07 ,$07 ;	$1758
;
L175D	.BYTE  $00
L175E	.BYTE  $00 ,$01
		.BYTE  $01 ,$00 ,$03 ,$27 ,$03
;
L1765	.BYTE  $EA ,$3C ,$82
		.BYTE  $44 ,$32 ,$2C ,$8A ;	$1768
		.BYTE  $DA ,$80 ,$9C ,$DA ;	$176C
		.BYTE  $3A ,$64 ,$A8 ,$DA ;	$1770
		.BYTE  $4A ,$08 ,$04 ,$00 ;	$1774
		.BYTE  $0E ,$F0 ,$10 ,$10 ;	$1778
		.BYTE  $10 ,$10 ,$10 ,$10 ;	$177C
		.BYTE  $10 ,$10 ,$10 ,$10 ;	$1780
		.BYTE  $10 ,$FF ,$00 ,$00 ;	$1784
		.BYTE  $00 ,$38 ,$00 ,$00 ;	$1788
		.BYTE  $00 ,$60 ,$20 ,$20 ;	$178C
		.BYTE  $23 ,$FF ,$80 ,$80 ;	$1790
		.BYTE  $00 ,$00 ,$00 ,$1C ;	$1794
		.BYTE  $04 ,$00 ,$00 ,$00 ;	$1798
		.BYTE  $00 ,$FF ,$00 ,$00 ;	$179C
		.BYTE  $00 ,$00 ,$00 ,$00 ;	$17A0
		.BYTE  $00 ,$00 ,$00 ,$00 ;	$17A4
		.BYTE  $00 ,$00 ,$07 ,$1F ;	$17A8
		.BYTE  $3F ,$7F ,$FF ,$00 ;	$17AC
		.BYTE  $00 ,$00 ,$00 ,$00 ;	$17B0
		.BYTE  $00 ,$00 ,$00 ,$60 ;	$17B4
		.BYTE  $20 ,$21 ,$FF ,$00 ;	$17B8
		.BYTE  $00 ,$00 ,$80 ,$80 ;	$17BC
		.BYTE  $80 ,$80 ,$00 ,$00 ;	$17C0
		.BYTE  $00 ,$07
;
L17C6	.BYTE  $4F ,$CF ,$8F
L17C9	.BYTE  $F6 ,$F6 ,$F6
L17CC	.BYTE  $75 ,$75 ,$75 ,$9A
L17D0	.BYTE  $81 ,$99 ,$AA ,$9D
L17D4	.BYTE  $8D ,$99 ,$B6 ,$9D
L17D8	.BYTE  $24 ,$28 ,$08 ,$20
		.BYTE  $00 ,$48 ,$40 ,$54 ;	$17DC
		.BYTE  $58 ,$25 ,$29 ,$49 ;	$17E0
		.BYTE  $55 ,$59 ,$A8 ,$88 ;	$17E4
		.BYTE  $98 ,$90 ,$A1 ,$83 ;	$17E8
		.BYTE  $E8 ,$C8 ,$E0 ,$C0 ;	$17EC
		.BYTE  $E9 ,$E2 ,$C1 ,$FF ;	$17F0
		.BYTE  $00 ,$00 ,$00 ,$00 ;	$17F4
		.BYTE  $00 ,$00

		.WORD  $0000 ;		NMI
		.WORD  $F000 ;		Reset

L17FE  .BYTE  $0F, $11 ;	IRQ - (used as pitch for sound generator)

.end
