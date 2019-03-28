	PAGE	,132
	TITLE MNEM48 - 7 SEP 1984

; ****************************************************************
; **								**
; **		      MNEMONIC AND BYTES TABLES			**
; **								**
; ****************************************************************

; ..... MODULE CONNECTION POINTS .....

	PUBLIC	MNEM
	PUBLIC	BYTES


; ..... CONSTANTS .....

TAB	EQU	09H		; ASCII TAB
RS	EQU	1EH		; ASCII RECORD SEPARATOR
FS	EQU	1CH		; ASCII FIELD SEPARATOR
	PAGE
DATA	SEGMENT PUBLIC		; DATA SEGMENT

; ****************************************************************
; **								**
; **			  MNEMONIC TABLE			**
; **								**
; ** EACH ENTRY IN THIS TABLE CONTAINS AN ASCII STRING THAT IS	**
; ** TO BE USED AS A MNEMONIC FOR THE PROGRAM DASM.  TABLE EN-	**
; ** TRIES ARE SEPARATED BY AN ASCII RECORD SEPARATOR AND THE	**
; ** TABLE IS TERMINATED BY AN ASCII FIELD SEPARATOR.  THE	**
; ** TABLE IS ORGANIZED BY ASCENDING OP-CODE.  UNDEFINED	**
; ** OP-CODES ARE ASSIGNED THE MNEMONIC "DB      ".		**
; **								**
; ****************************************************************

MNEM	EQU	THIS BYTE
	DB	'NOP',TAB,RS		; 00
	DB	'LXI',TAB,'B,',RS	; 01
	DB	'STAX',TAB,'B',RS	; 02
	DB	'INX',TAB,'B',RS 	; 03
	DB	'INR',TAB,'B',RS 	; 04
	DB	'DCR',TAB,'B',RS 	; 05
	DB	'MVI',TAB,'B,',RS	; 06
	DB	'RLC',TAB,RS		; 07
	DB	'DB',TAB,RS		; 08
	DB	'DAD',TAB,'B',RS 	; 09
	DB	'LDAX',TAB,'B',RS	; 0A
	DB	'DCX',TAB,'B',RS 	; 0B
	DB	'INR',TAB,'C',RS 	; 0C
	PAGE
	DB	'DCR',TAB,'C',RS 	; 0D
	DB	'MVI',TAB,'C,',RS	; 0E
	DB	'RRC',TAB,RS		; 0F
	DB	'DB',TAB,RS		; 10
	DB	'LXI',TAB,'D,',RS	; 11
	DB	'STAX',TAB,'D',RS	; 12
	DB	'INX',TAB,'D',RS 	; 13
	DB	'INR',TAB,'D',RS 	; 14
	DB	'DCR',TAB,'D',RS 	; 15
	DB	'MVI',TAB,'D,',RS	; 16
	DB	'RAL',TAB,RS		; 17
	DB	'DB',TAB,RS		; 18
	DB	'DAD',TAB,'D',RS 	; 19
	DB	'LDAX',TAB,'D',RS	; 1A
	DB	'DCX',TAB,'D',RS 	; 1B
	DB	'INR',TAB,'E',RS 	; 1C
	DB	'DCR',TAB,'E',RS 	; 1D
	DB	'MVI',TAB,'E,',RS	; 1E
	DB	'RAR',TAB,RS		; 1F
	PAGE
	DB	'RIM',TAB,RS		; 20
	DB	'LXI',TAB,'H,',RS	; 21
	DB	'SHLD',TAB,RS		; 22
	DB	'INX',TAB,'H',RS 	; 23
	DB	'INR',TAB,'H',RS 	; 24
	DB	'DCR',TAB,'H',RS 	; 25
	DB	'MVI',TAB,'H,',RS	; 26
	DB	'DAA',TAB,RS		; 27
	DB	'DB',TAB,RS		; 28
	DB	'DAD',TAB,'H',RS 	; 29
	DB	'LHLD',TAB,RS		; 2A
	DB	'DCX',TAB,'H',RS 	; 2B
	DB	'INR',TAB,'L',RS 	; 2C
	DB	'DCR',TAB,'L',RS 	; 2D
	DB	'MVI',TAB,'L,',RS	; 2E
	DB	'CMA',TAB,RS		; 2F
	PAGE
	DB	'SIM',TAB,RS		; 30
	DB	'LXI',TAB,'SP,',RS	; 31
	DB	'STA',TAB,RS		; 32
	DB	'INX',TAB,'SP',RS	; 33
	DB	'INR',TAB,'M',RS 	; 34
	DB	'DCR',TAB,'M',RS 	; 35
	DB	'MVI',TAB,'M,',RS	; 36
	DB	'STC',TAB,RS		; 37
	DB	'DB',TAB,RS		; 38
	DB	'DAD',TAB,'SP',RS	; 39
	DB	'LDA',TAB,RS		; 3A
	DB	'DCX',TAB,'SP',RS	; 3B
	DB	'INR',TAB,'A',RS 	; 3C
	DB	'DCR',TAB,'A',RS 	; 3D
	DB	'MVI',TAB,'A,',RS	; 3E
	DB	'CMC',TAB,RS		; 3F
	PAGE
	DB	'MOV',TAB,'B,B',RS	; 40
	DB	'MOV',TAB,'B,C',RS	; 41
	DB	'MOV',TAB,'B,D',RS	; 42
	DB	'MOV',TAB,'B,E',RS	; 43
	DB	'MOV',TAB,'B,H',RS	; 44
	DB	'MOV',TAB,'B,L',RS	; 45
	DB	'MOV',TAB,'B,M',RS	; 46
	DB	'MOV',TAB,'B,A',RS	; 47
	DB	'MOV',TAB,'C,B',RS	; 48
	DB	'MOV',TAB,'C,C',RS	; 49
	DB	'MOV',TAB,'C,D',RS	; 4A
	DB	'MOV',TAB,'C,E',RS	; 4B
	DB	'MOV',TAB,'C,H',RS	; 4C
	DB	'MOV',TAB,'C,L',RS	; 4D
	DB	'MOV',TAB,'C,M',RS	; 4E
	DB	'MOV',TAB,'C,A',RS	; 4F
	PAGE
	DB	'MOV',TAB,'D,B',RS	; 50
	DB	'MOV',TAB,'D,C',RS	; 51
	DB	'MOV',TAB,'D,D',RS	; 52
	DB	'MOV',TAB,'D,E',RS	; 53
	DB	'MOV',TAB,'D,H',RS	; 54
	DB	'MOV',TAB,'D,L',RS	; 55
	DB	'MOV',TAB,'D,M',RS	; 56
	DB	'MOV',TAB,'D,A',RS	; 57
	DB	'MOV',TAB,'E,B',RS	; 58
	DB	'MOV',TAB,'E,C',RS	; 59
	DB	'MOV',TAB,'E,D',RS	; 5A
	DB	'MOV',TAB,'E,E',RS	; 5B
	DB	'MOV',TAB,'E,H',RS	; 5C
	DB	'MOV',TAB,'E,L',RS	; 5D
	DB	'MOV',TAB,'E,M',RS	; 5E
	DB	'MOV',TAB,'E,A',RS	; 5F
	PAGE
	DB	'MOV',TAB,'H,B',RS	; 60
	DB	'MOV',TAB,'H,C',RS	; 61
	DB	'MOV',TAB,'H,D',RS	; 62
	DB	'MOV',TAB,'H,E',RS	; 63
	DB	'MOV',TAB,'H,H',RS	; 64
	DB	'MOV',TAB,'H,L',RS	; 65
	DB	'MOV',TAB,'H,M',RS	; 66
	DB	'MOV',TAB,'H,A',RS	; 67
	DB	'MOV',TAB,'L,B',RS	; 68
	DB	'MOV',TAB,'L,C',RS	; 69
	DB	'MOV',TAB,'L,D',RS	; 6A
	DB	'MOV',TAB,'L,E',RS	; 6B
	DB	'MOV',TAB,'L,H',RS	; 6C
	DB	'MOV',TAB,'L,L',RS	; 6D
	DB	'MOV',TAB,'L,M',RS	; 6E
	DB	'MOV',TAB,'L,A',RS	; 6F
	PAGE
	DB	'MOV',TAB,'M,B',RS	; 70
	DB	'MOV',TAB,'M,C',RS	; 71
	DB	'MOV',TAB,'M,D',RS	; 72
	DB	'MOV',TAB,'M,E',RS	; 73
	DB	'MOV',TAB,'M,H',RS	; 74
	DB	'MOV',TAB,'M,L',RS	; 75
	DB	'HLT',TAB,RS		; 76
	DB	'MOV',TAB,'M,A',RS	; 77
	DB	'MOV',TAB,'A,B',RS	; 78
	DB	'MOV',TAB,'A,C',RS	; 79
	DB	'MOV',TAB,'A,D',RS	; 7A
	DB	'MOV',TAB,'A,E',RS	; 7B
	DB	'MOV',TAB,'A,H',RS	; 7C
	DB	'MOV',TAB,'A,L',RS	; 7D
	DB	'MOV',TAB,'A,M',RS	; 7E
	DB	'MOV',TAB,'A,A',RS	; 7F
	PAGE
	DB	'ADD',TAB,'B',RS 	; 80
	DB	'ADD',TAB,'C',RS 	; 81
	DB	'ADD',TAB,'D',RS 	; 82
	DB	'ADD',TAB,'E',RS 	; 83
	DB	'ADD',TAB,'H',RS 	; 84
	DB	'ADD',TAB,'L',RS 	; 85
	DB	'ADD',TAB,'M',RS 	; 86
	DB	'ADD',TAB,'A',RS 	; 87
	DB	'ADC',TAB,'B',RS 	; 88
	DB	'ADC',TAB,'C',RS 	; 89
	DB	'ADC',TAB,'D',RS 	; 8A
	DB	'ADC',TAB,'E',RS 	; 8B
	DB	'ADC',TAB,'H',RS 	; 8C
	DB	'ADC',TAB,'L',RS 	; 8D
	DB	'ADC',TAB,'M',RS 	; 8E
	DB	'ADC',TAB,'A',RS 	; 8F
	PAGE
	DB	'SUB',TAB,'B',RS 	; 90
	DB	'SUB',TAB,'C',RS 	; 91
	DB	'SUB',TAB,'D',RS 	; 92
	DB	'SUB',TAB,'E',RS 	; 93
	DB	'SUB',TAB,'H',RS 	; 94
	DB	'SUB',TAB,'L',RS 	; 95
	DB	'SUB',TAB,'M',RS 	; 96
	DB	'SUB',TAB,'A',RS 	; 97
	DB	'SBB',TAB,'B',RS 	; 98
	DB	'SBB',TAB,'C',RS 	; 99
	DB	'SBB',TAB,'D',RS 	; 9A
	DB	'SBB',TAB,'E',RS 	; 9B
	DB	'SBB',TAB,'H',RS 	; 9C
	DB	'SBB',TAB,'L',RS 	; 9D
	DB	'SBB',TAB,'M',RS 	; 9E
	DB	'SBB',TAB,'A',RS 	; 9F
	PAGE
	DB	'ANA',TAB,'B',RS 	; A0
	DB	'ANA',TAB,'C',RS 	; A1
	DB	'ANA',TAB,'D',RS 	; A2
	DB	'ANA',TAB,'E',RS 	; A3
	DB	'ANA',TAB,'H',RS 	; A4
	DB	'ANA',TAB,'L',RS 	; A5
	DB	'ANA',TAB,'M',RS 	; A6
	DB	'ANA',TAB,'A',RS 	; A7
	DB	'XRA',TAB,'B',RS 	; A8
	DB	'XRA',TAB,'C',RS 	; A9
	DB	'XRA',TAB,'D',RS 	; AA
	DB	'XRA',TAB,'E',RS 	; AB
	DB	'XRA',TAB,'H',RS 	; AC
	DB	'XRA',TAB,'L',RS 	; AD
	DB	'XRA',TAB,'M',RS 	; AE
	DB	'XRA',TAB,'A',RS 	; AF
	PAGE
	DB	'ORA',TAB,'B',RS 	; B0
	DB	'ORA',TAB,'C',RS 	; B1
	DB	'ORA',TAB,'D',RS 	; B2
	DB	'ORA',TAB,'E',RS 	; B3
	DB	'ORA',TAB,'H',RS 	; B4
	DB	'ORA',TAB,'L',RS 	; B5
	DB	'ORA',TAB,'M',RS 	; B6
	DB	'ORA',TAB,'A',RS 	; B7
	DB	'CMP',TAB,'B',RS 	; B8
	DB	'CMP',TAB,'C',RS 	; B9
	DB	'CMP',TAB,'D',RS 	; BA
	DB	'CMP',TAB,'E',RS 	; BB
	DB	'CMP',TAB,'H',RS 	; BC
	DB	'CMP',TAB,'L',RS 	; BD
	DB	'CMP',TAB,'M',RS 	; BE
	DB	'CMP',TAB,'A',RS 	; BF
	PAGE
	DB	'RNZ',TAB,RS		; C0
	DB	'POP',TAB,'B',RS 	; C1
	DB	'JNZ',TAB,RS		; C2
	DB	'JMP',TAB,RS		; C3
	DB	'CNZ',TAB,RS		; C4
	DB	'PUSH',TAB,'B',RS	; C5
	DB	'ADI',TAB,RS		; C6
	DB	'RST',TAB,'0',RS 	; C7
	DB	'RZ',TAB,RS		; C8
	DB	'RET',TAB,RS		; C9
	DB	'JZ',TAB,RS		; CA
	DB	'DB',TAB,RS		; CB
	DB	'CZ',TAB,RS		; CC
	DB	'CALL',TAB,RS		; CD
	DB	'ACI',TAB,RS		; CE
	DB	'RST',TAB,'1',RS 	; CF
	PAGE
	DB	'RNC',TAB,RS		; D0
	DB	'POP',TAB,'D',RS 	; D1
	DB	'JNC',TAB,RS		; D2
	DB	'OUT',TAB,RS		; D3
	DB	'CNC',TAB,RS		; D4
	DB	'PUSH',TAB,'D',RS	; D5
	DB	'SUI',TAB,RS		; D6
	DB	'RST',TAB,'2',RS 	; D7
	DB	'RC',TAB,RS		; D8
	DB	'DB',TAB,RS		; D9
	DB	'JC',TAB,RS		; DA
	DB	'IN',TAB,RS		; DB
	DB	'CC',TAB,RS		; DC
	DB	'DB',TAB,RS		; DD
	DB	'SBI',TAB,RS		; DE
	DB	'RST',TAB,'3',RS 	; DF
	PAGE
	DB	'RPO',TAB,RS		; E0
	DB	'POP',TAB,'H',RS 	; E1
	DB	'JPO',TAB,RS		; E2
	DB	'XTHL',TAB,RS		; E3
	DB	'CPO',TAB,RS		; E4
	DB	'PUSH',TAB,'H',RS	; E5
	DB	'ANI',TAB,RS		; E6
	DB	'RST',TAB,'4',RS 	; E7
	DB	'RPE',TAB,RS		; E8
	DB	'PCHL',TAB,RS		; E9
	DB	'JPE',TAB,RS		; EA
	DB	'XCHG',TAB,RS		; EB
	DB	'CPE',TAB,RS		; EC
	DB	'DB',TAB,RS		; ED
	DB	'XRI',TAB,RS		; EE
	DB	'RST',TAB,'5',RS 	; EF
	PAGE
	DB	'RP',TAB,RS		; F0
	DB	'POP',TAB,'PSW',RS	; F1
	DB	'JP',TAB,RS		; F2
	DB	'DI',TAB,RS		; F3
	DB	'CP',TAB,RS		; F4
	DB	'PUSH',TAB,'PSW',RS	; F5
	DB	'ORI',TAB,RS		; F6
	DB	'RST',TAB,'6',RS 	; F7
	DB	'RM',TAB,RS		; F8
	DB	'SPHL',TAB,RS		; F9
	DB	'JM',TAB,RS		; FA
	DB	'EI',TAB,RS		; FB
	DB	'CM',TAB,RS		; FC
	DB	'DB',TAB,RS		; FD
	DB	'CPI',TAB,RS		; FE
	DB	'RST',TAB,'7',RS,FS	; FF
	PAGE
; ****************************************************************
; **								**
; **			   BYTES TABLE				**
; **								**
; ** EACH ENTRY IN THIS TABLE CONTAINS THE NUMBER OF BYTES RE-	**
; ** QUIRED FOR FOUR 8085 INSTRUCTIONS.  THE TABLE IS BYTE AND	**
; ** BIT ORGANIZED BY ACSENDING OP-CODE WITH TWO BITS ASSIGNED	**
; ** TO EACH INSTRUCTION.  UNDEFINED OP-CODES ARE ASSIGNED ZERO	**
; ** BYTES.							**
; **								**
; ****************************************************************

;		3 2 1 0
BYTES	EQU	THIS BYTE
	DB	01011101B	; 00
	DB	01100101B	; 04
	DB	01010100B	; 08
	DB	01100101B	; 0C
	DB	01011100B	; 10
	DB	01100101B	; 14
	DB	01010100B	; 18
	DB	01100101B	; 1C
	DB	01111101B	; 20
	DB	01100101B	; 24
	DB	01110100B	; 28
	DB	01100101B	; 2C
	DB	01111101B	; 30
	DB	01100101B	; 34
	DB	01110100B	; 38
	DB	01100101B	; 3C

	DB	11110101B	; C0
	DB	01100111B	; C4
	DB	00110101B	; C8
	DB	01101111B	; CC
	DB	10110101B	; D0
	DB	01100111B	; D4
	DB	10110001B	; D8
	DB	01100011B	; DC
	DB	01110101B	; E0
	DB	01100111B	; E4
	DB	01110101B	; E8
	DB	01100011B	; EC
	DB	01110101B	; F0
	DB	01100111B	; F4
	DB	01110101B	; F8
	DB	01100011B	; FC
	PAGE
DATA	ENDS

	END
