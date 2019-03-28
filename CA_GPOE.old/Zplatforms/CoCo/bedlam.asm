Archive size is:14625 bytes.
Disassembly base address  is 0x0600


0600: 86 0D           LDa #$0D
0602: B7 01 E3        STa $01E3
0605: 4F              CLRa
0606: 8E 04 00        LDX #$0400  ; Screen memory
0609: CE 60 60        LDU #$6060  ; Double space
060C: EF 81           STU ,X++    ; Clear ...
060E: 4A              DECa        ; ... the ...
060F: 26 FB           BNE $060C   ; ... screen
0611: 10 CE 03 FF     LDS #$03FF  ; Set stack
0615: 86 13           LDa #$13
0617: B7 01 D2        STa $01D2
061A: 8E 05 E0        LDX #$05E0
061D: 9F 88           STX $88
061F: 8E 13 55        LDX #$1355
0622: BD 0C 44        JSR $0C44
0625: 86 0D           LDa #$0D
0627: BD 11 D5        JSR $11D5
062A: BD 0B 6C        JSR $0B6C
062D: 8E 13 54        LDX #$1354
0630: BD 0C 44        JSR $0C44
0633: 86 0D           LDa #$0D
0635: BD 11 D5        JSR $11D5
0638: 10 CE 03 FF     LDS #$03FF
063C: BD 0B 0D        JSR $0B0D
063F: 86 0D           LDa #$0D
0641: B7 01 E3        STa $01E3
0644: 7F 01 B7        CLR $01B7
0647: 7F 01 BA        CLR $01BA
064A: 7F 01 BB        CLR $01BB
064D: 7F 01 B2        CLR $01B2
0650: 7F 01 B3        CLR $01B3
0653: 7F 01 B9        CLR $01B9
0656: 7F 01 B8        CLR $01B8
0659: 7F 01 B4        CLR $01B4
065C: 7F 01 B5        CLR $01B5
065F: 7F 01 BF        CLR $01BF
0662: 7F 01 C3        CLR $01C3
0665: 7F 01 C9        CLR $01C9
0668: C6 13           LDb #$13
066A: F7 01 D2        STb $01D2
066D: BD 11 7D        JSR $117D
0670: BF 01 D3        STX $01D3
0673: BD 0A 83        JSR $0A83
0676: E6 84           LDb ,X
0678: F7 01 D5        STb $01D5
067B: 8E 15 A1        LDX #$15A1
067E: BD 0A 60        JSR $0A60
0681: BF 01 D6        STX $01D6
0684: 8E 01 E4        LDX #$01E4
0687: BF 01 D8        STX $01D8
068A: 6F 84           CLR ,X
068C: 8E 05 E0        LDX #$05E0
068F: BD 0B 83        JSR $0B83
0692: 27 0B           BEQ $069F
0694: A6 80           LDa ,X+
0696: 81 60           CMPa #$60
0698: 27 F5           BEQ $068F
069A: 8C 06 00        CMPX #$0600
069D: 26 F5           BNE $0694
069F: 8C 06 00        CMPX #$0600
06A2: 26 EB           BNE $068F
06A4: 6F 9F 01 D8     CLR [$01D8]
06A8: 8E 01 E4        LDX #$01E4
06AB: A6 84           LDa ,X
06AD: 10 27 00 92     LBEQ $0743
06B1: 81 02           CMPa #$02
06B3: 26 0F           BNE $06C4
06B5: 30 01           LEAX +$01,X
06B7: A6 84           LDa ,X
06B9: 30 1F           LEAX -$01,X
06BB: 81 09           CMPa #$09
06BD: 24 05           BCC $06C4
06BF: B7 01 B8        STa $01B8
06C2: 30 03           LEAX +$03,X
06C4: A6 80           LDa ,X+
06C6: 27 7B           BEQ $0743
06C8: E6 84           LDb ,X
06CA: EE 81           LDU ,X++ 
06CC: 34 10           PSHS ,X
06CE: 4A              DECa
06CF: 26 21           BNE $06F2
06D1: 8E 13 B2        LDX #$13B2
06D4: BD 0A 60        JSR $0A60
06D7: 24 13           BCC $06EC
06D9: BD 0A 83        JSR $0A83
06DC: BD 0A 99        JSR $0A99
06DF: 1F 98           TFR B,A
06E1: 24 09           BCC $06EC
06E3: E6 80           LDb ,X+
06E5: A6 80           LDa ,X+
06E7: F1 01 B3        CMPb $01B3
06EA: 26 F0           BNE $06DC
06EC: F7 01 B3        STb $01B3
06EF: 7E 07 3E        JMP $073E
06F2: 4A              DECa
06F3: 26 36           BNE $072B
06F5: 7D 01 B5        TST $01B5
06F8: 27 20           BEQ $071A
06FA: 8E 01 C9        LDX #$01C9
06FD: E7 80           STb ,X+
06FF: B6 01 B7        LDa $01B7
0702: A7 80           STa ,X+
0704: B6 01 BA        LDa $01BA
0707: A7 84           STa ,X
0709: 26 04           BNE $070F
070B: 1F 30           TFR U,D
070D: E7 84           STb ,X
070F: 7F 01 B7        CLR $01B7
0712: 7F 01 B5        CLR $01B5
0715: 7F 01 BA        CLR $01BA
0718: 20 24           BRA $073E
071A: BE 01 C3        LDX $01C3
071D: BF 01 C9        STX $01C9
0720: BE 01 C5        LDX $01C5
0723: BF 01 CB        STX $01CB
0726: 8E 01 C3        LDX #$01C3
0729: 20 D2           BRA $06FD
072B: 4A              DECa
072C: 26 0A           BNE $0738
072E: F7 01 B7        STb $01B7
0731: 1F 30           TFR U,D
0733: F7 01 BA        STb $01BA
0736: 20 06           BRA $073E
0738: F7 01 B4        STb $01B4
073B: F7 01 B5        STb $01B5
073E: 35 10           PULS ,X
0740: 7E 06 C4        JMP $06C4
0743: 7D 01 B3        TST $01B3
0746: 10 27 02 8C     LBEQ $09D6
074A: 8E 01 C9        LDX #$01C9
074D: BD 08 63        JSR $0863
0750: B7 01 C9        STa $01C9
0753: BF 01 CC        STX $01CC
0756: 8E 01 C3        LDX #$01C3
0759: BD 08 63        JSR $0863
075C: B7 01 C3        STa $01C3
075F: BF 01 C6        STX $01C6
0762: 7F 01 B5        CLR $01B5
0765: BE 01 C6        LDX $01C6
0768: B6 01 C3        LDa $01C3
076B: 27 07           BEQ $0774
076D: BD 0A 83        JSR $0A83
0770: 30 02           LEAX +$02,X
0772: A6 84           LDa ,X
0774: B7 01 C8        STa $01C8
0777: BE 01 CC        LDX $01CC
077A: B6 01 C9        LDa $01C9
077D: 27 07           BEQ $0786
077F: BD 0A 83        JSR $0A83
0782: 30 02           LEAX +$02,X
0784: A6 84           LDa ,X
0786: B7 01 CE        STa $01CE
0789: 8E 13 E3        LDX #$13E3
078C: A6 84           LDa ,X
078E: 10 27 02 00     LBEQ $0992
0792: B6 01 B3        LDa $01B3
0795: A1 80           CMPa ,X+
0797: 26 57           BNE $07F0
0799: A6 84           LDa ,X
079B: B7 01 B6        STa $01B6
079E: B6 01 B4        LDa $01B4
07A1: 27 04           BEQ $07A7
07A3: A1 84           CMPa ,X
07A5: 26 49           BNE $07F0
07A7: 30 01           LEAX +$01,X
07A9: A6 84           LDa ,X
07AB: 27 14           BEQ $07C1
07AD: B6 01 C3        LDa $01C3
07B0: 26 14           BNE $07C6
07B2: B6 01 BB        LDa $01BB
07B5: B7 01 BD        STa $01BD
07B8: 10 8E 01 C3     LDY #$01C3
07BC: BD 09 13        JSR $0913
07BF: 20 05           BRA $07C6
07C1: B6 01 C3        LDa $01C3
07C4: 26 2C           BNE $07F2
07C6: 30 01           LEAX +$01,X
07C8: A6 84           LDa ,X
07CA: 27 19           BEQ $07E5
07CC: B6 01 C9        LDa $01C9
07CF: 26 19           BNE $07EA
07D1: B6 01 BC        LDa $01BC
07D4: B7 01 BD        STa $01BD
07D7: 86 01           LDa #$01
07D9: B7 01 B5        STa $01B5
07DC: 10 8E 01 C9     LDY #$01C9
07E0: BD 09 13        JSR $0913
07E3: 20 05           BRA $07EA
07E5: B6 01 C9        LDa $01C9
07E8: 26 0A           BNE $07F4
07EA: 30 01           LEAX +$01,X
07EC: A6 84           LDa ,X
07EE: 20 09           BRA $07F9
07F0: 30 01           LEAX +$01,X
07F2: 30 01           LEAX +$01,X
07F4: 30 02           LEAX +$02,X
07F6: 7E 07 8C        JMP $078C
07F9: B7 01 D1        STa $01D1
07FC: 8E 05 FF        LDX #$05FF
07FF: 9F 88           STX $88
0801: B6 01 C3        LDa $01C3
0804: 26 0C           BNE $0812
0806: BE 01 CC        LDX $01CC
0809: BF 01 C6        STX $01C6
080C: B6 01 C9        LDa $01C9
080F: B7 01 C3        STa $01C3
0812: B6 01 B8        LDa $01B8
0815: 27 33           BEQ $084A
0817: 8E 01 E5        LDX #$01E5
081A: A6 84           LDa ,X
081C: 6F 84           CLR ,X
081E: A7 82           STa ,-X
0820: BD 08 63        JSR $0863
0823: B7 01 D2        STa $01D2
0826: BF 01 D3        STX $01D3
0829: 86 0D           LDa #$0D
082B: BD 11 D5        JSR $11D5
082E: BD 0A 83        JSR $0A83
0831: 30 03           LEAX +$03,X
0833: C6 0B           LDb #$0B
0835: BD 0A 68        JSR $0A68
0838: 25 08           BCS $0842
083A: 8E 13 56        LDX #$1356
083D: BD 0C 44        JSR $0C44
0840: 20 16           BRA $0858
0842: BD 0A 83        JSR $0A83
0845: BD 0C 44        JSR $0C44
0848: 20 0E           BRA $0858
084A: 86 0D           LDa #$0D
084C: BD 11 D5        JSR $11D5
084F: 8E 2F 24        LDX #$2F24
0852: BD 0A 83        JSR $0A83
0855: BD 0C 44        JSR $0C44
0858: BD 10 51        JSR $1051
085B: 86 0D           LDa #$0D
085D: BD 11 D5        JSR $11D5
0860: 7E 06 38        JMP $0638
0863: 7F 01 BF        CLR $01BF
0866: E6 80           LDb ,X+
0868: F7 01 B2        STb $01B2
086B: 26 02           BNE $086F
086D: 4F              CLRa
086E: 39              RTS
086F: A6 80           LDa ,X+
0871: B7 01 B7        STa $01B7
0874: A6 84           LDa ,X
0876: B7 01 CF        STa $01CF
0879: 8E 1B 42        LDX #$1B42
087C: BD 0A 60        JSR $0A60
087F: 24 5A           BCC $08DB
0881: 34 20           PSHS ,Y
0883: 34 10           PSHS ,X
0885: B6 01 E1        LDa $01E1
0888: B7 01 E2        STa $01E2
088B: BD 08 EB        JSR $08EB
088E: 26 57           BNE $08E7
0890: B6 01 B7        LDa $01B7
0893: 27 1F           BEQ $08B4
0895: 35 10           PULS ,X
0897: 34 10           PSHS ,X
0899: BD 0A 83        JSR $0A83
089C: 30 03           LEAX +$03,X
089E: C6 01           LDb #$01
08A0: BD 0A 68        JSR $0A68
08A3: 24 0F           BCC $08B4
08A5: BD 0A 83        JSR $0A83
08A8: BD 0A 99        JSR $0A99
08AB: 24 3A           BCC $08E7
08AD: B6 01 B7        LDa $01B7
08B0: A1 80           CMPa ,X+
08B2: 26 F4           BNE $08A8
08B4: 35 10           PULS ,X
08B6: B6 01 BF        LDa $01BF
08B9: 10 26 01 10     LBNE $09CD
08BD: B6 01 E2        LDa $01E2
08C0: B7 01 BF        STa $01BF
08C3: BF 01 C0        STX $01C0
08C6: BD 0A 83        JSR $0A83
08C9: 1F 21           TFR Y,X
08CB: 35 20           PULS ,Y
08CD: F6 01 B2        LDb $01B2
08D0: B6 01 E2        LDa $01E2
08D3: B7 01 E1        STa $01E1
08D6: BD 0A 68        JSR $0A68
08D9: 25 A6           BCS $0881
08DB: BE 01 C0        LDX $01C0
08DE: B6 01 BF        LDa $01BF
08E1: 26 03           BNE $08E6
08E3: 7E 09 89        JMP $0989
08E6: 39              RTS
08E7: 35 10           PULS ,X
08E9: 20 DB           BRA $08C6
08EB: BD 0A 83        JSR $0A83
08EE: B6 01 D5        LDa $01D5
08F1: A1 84           CMPa ,X
08F3: 27 F1           BEQ $08E6
08F5: A6 84           LDa ,X
08F7: 27 17           BEQ $0910
08F9: 81 FF           CMPa #$FF
08FB: 27 E9           BEQ $08E6
08FD: 85 80           BITa #$80
08FF: 26 0F           BNE $0910
0901: E6 84           LDb ,X
0903: F1 01 D2        CMPb $01D2
0906: 27 DE           BEQ $08E6
0908: 8E 1B 42        LDX #$1B42
090B: BD 11 7D        JSR $117D
090E: 20 DB           BRA $08EB
0910: 8A 01           ORa #$01
0912: 39              RTS
0913: 34 10           PSHS ,X
0915: 7F 01 B2        CLR $01B2
0918: 7F 01 E1        CLR $01E1
091B: 34 20           PSHS ,Y
091D: A6 84           LDa ,X
091F: B7 01 AB        STa $01AB
0922: 8E 1B 42        LDX #$1B42
0925: BD 0A 83        JSR $0A83
0928: BD 0A 99        JSR $0A99
092B: 24 40           BCC $096D
092D: 7C 01 E1        INC $01E1
0930: 34 20           PSHS ,Y
0932: 34 10           PSHS ,X
0934: BD 08 EB        JSR $08EB
0937: 35 10           PULS ,X
0939: 26 2D           BNE $0968
093B: E6 84           LDb ,X
093D: BF 01 D8        STX $01D8
0940: BD 0A 83        JSR $0A83
0943: 30 02           LEAX +$02,X
0945: A6 84           LDa ,X
0947: B4 01 AB        ANDa $01AB
094A: B1 01 AB        CMPa $01AB
094D: 26 13           BNE $0962
094F: B6 01 B2        LDa $01B2
0952: 26 47           BNE $099B
0954: F7 01 B2        STb $01B2
0957: A6 84           LDa ,X
0959: B7 01 B7        STa $01B7
095C: BE 01 D8        LDX $01D8
095F: BF 01 AD        STX $01AD
0962: 1E 12           EXG X,Y
0964: 35 20           PULS ,Y
0966: 20 C0           BRA $0928
0968: BD 0A 83        JSR $0A83
096B: 20 F5           BRA $0962
096D: B6 01 B2        LDa $01B2
0970: 27 29           BEQ $099B
0972: 35 20           PULS ,Y
0974: BE 01 AD        LDX $01AD
0977: B6 01 E1        LDa $01E1
097A: A7 A4           STa ,Y
097C: 31 23           LEAY +$03,Y
097E: AF A1           STX ,Y++ 
0980: B6 01 B7        LDa $01B7
0983: A7 A4           STa ,Y
0985: 35 10           PULS ,X
0987: 4F              CLRa
0988: 39              RTS
0989: 10 8E 13 C3     LDY #$13C3
098D: B6 01 CF        LDa $01CF
0990: 20 4A           BRA $09DC
0992: 10 8E 13 D2     LDY #$13D2
0996: B6 01 BC        LDa $01BC
0999: 20 41           BRA $09DC
099B: B6 01 B5        LDa $01B5
099E: 27 24           BEQ $09C4
09A0: B6 01 B4        LDa $01B4
09A3: 26 1F           BNE $09C4
09A5: 8E 3E A2        LDX #$3EA2
09A8: E6 84           LDb ,X
09AA: 27 18           BEQ $09C4
09AC: 34 10           PSHS ,X
09AE: E6 80           LDb ,X+
09B0: 3A              ABX
09B1: B6 01 B6        LDa $01B6
09B4: A1 80           CMPa ,X+
09B6: 27 04           BEQ $09BC
09B8: 35 06           PULS ,A,B
09BA: 20 EC           BRA $09A8
09BC: 35 20           PULS ,Y
09BE: B6 01 BD        LDa $01BD
09C1: BD 0A 22        JSR $0A22
09C4: 10 8E 13 C3     LDY #$13C3
09C8: B6 01 BD        LDa $01BD
09CB: 20 0F           BRA $09DC
09CD: 10 8E 13 CA     LDY #$13CA
09D1: B6 01 CF        LDa $01CF
09D4: 20 06           BRA $09DC
09D6: 10 8E 13 BC     LDY #$13BC
09DA: 86 E0           LDa #$E0
09DC: 10 CE 03 FF     LDS #$03FF
09E0: 8E 05 E0        LDX #$05E0
09E3: BD 0A 22        JSR $0A22
09E6: A6 A4           LDa ,Y
09E8: B7 01 AB        STa $01AB
09EB: 34 10           PSHS ,X
09ED: 86 60           LDa #$60
09EF: A7 80           STa ,X+
09F1: 7A 01 AB        DEC $01AB
09F4: 26 F7           BNE $09ED
09F6: BD 0A 17        JSR $0A17
09F9: 35 10           PULS ,X
09FB: 5A              DECb
09FC: 26 14           BNE $0A12
09FE: A6 A4           LDa ,Y
0A00: 4C              INCa
0A01: B7 01 AB        STa $01AB
0A04: BD 0B 1C        JSR $0B1C
0A07: 7A 01 AB        DEC $01AB
0A0A: 26 F8           BNE $0A04
0A0C: BD 0A A4        JSR $0AA4
0A0F: 7E 06 44        JMP $0644
0A12: BD 0A 41        JSR $0A41
0A15: 20 CF           BRA $09E6
0A17: 86 32           LDa #$32
0A19: 7A 01 AB        DEC $01AB
0A1C: 26 FB           BNE $0A19
0A1E: 4A              DECa
0A1F: 26 F8           BNE $0A19
0A21: 39              RTS
0A22: B7 01 AB        STa $01AB
0A25: CC 05 E0        LDD #$05E0
0A28: F6 01 AB        LDb $01AB
0A2B: 1F 01           TFR D,X
0A2D: A6 A4           LDa ,Y
0A2F: 4C              INCa
0A30: B7 01 AB        STa $01AB
0A33: 34 20           PSHS ,Y
0A35: BD 0B 47        JSR $0B47
0A38: 7A 01 AB        DEC $01AB
0A3B: 26 F8           BNE $0A35
0A3D: 35 20           PULS ,Y
0A3F: C6 08           LDb #$08
0A41: A6 A4           LDa ,Y
0A43: B7 01 AB        STa $01AB
0A46: 34 34           PSHS ,Y,X,B
0A48: 31 21           LEAY +$01,Y
0A4A: A6 A0           LDa ,Y+
0A4C: A7 80           STa ,X+
0A4E: 7A 01 AB        DEC $01AB
0A51: 26 F7           BNE $0A4A
0A53: 30 01           LEAX +$01,X
0A55: 1F 10           TFR X,D
0A57: F7 01 BD        STb $01BD
0A5A: BD 0A 17        JSR $0A17
0A5D: 35 34           PULS ,B,X,Y
0A5F: 39              RTS
0A60: 30 01           LEAX +$01,X
0A62: BD 0A 85        JSR $0A85
0A65: 7F 01 E1        CLR $01E1
0A68: BD 0A 99        JSR $0A99
0A6B: 25 01           BCS $0A6E
0A6D: 39              RTS
0A6E: 7C 01 E1        INC $01E1
0A71: E1 84           CMPb ,X
0A73: 27 0B           BEQ $0A80
0A75: 34 20           PSHS ,Y
0A77: BD 0A 83        JSR $0A83
0A7A: 1F 21           TFR Y,X
0A7C: 35 20           PULS ,Y
0A7E: 20 E8           BRA $0A68
0A80: 1A 01           ORCC #$01
0A82: 39              RTS
0A83: 30 01           LEAX +$01,X
0A85: 4F              CLRa
0A86: 34 04           PSHS ,B
0A88: E6 80           LDb ,X+
0A8A: C5 80           BITb #$80
0A8C: 27 06           BEQ $0A94
0A8E: C4 7F           ANDb #$7F
0A90: 1F 98           TFR B,A
0A92: E6 80           LDb ,X+
0A94: 31 8B           LEAY D,X
0A96: 35 04           PULS ,B
0A98: 39              RTS
0A99: 10 BF 01 A9     STY $01A9
0A9D: BC 01 A9        CMPX $01A9
0AA0: 39              RTS
0AA1: 8E 05 E0        LDX #$05E0
0AA4: BD 0B 64        JSR $0B64
0AA7: BD 0B 6C        JSR $0B6C
0AAA: 81 15           CMPa #$15
0AAC: 27 20           BEQ $0ACE
0AAE: 81 5D           CMPa #$5D
0AB0: 27 2F           BEQ $0AE1
0AB2: 81 09           CMPa #$09
0AB4: 27 3E           BEQ $0AF4
0AB6: 81 0D           CMPa #$0D
0AB8: 27 4F           BEQ $0B09
0ABA: 81 0C           CMPa #$0C
0ABC: 27 4F           BEQ $0B0D
0ABE: 81 08           CMPa #$08
0AC0: 27 3B           BEQ $0AFD
0AC2: 8C 05 FF        CMPX #$05FF
0AC5: 27 E0           BEQ $0AA7
0AC7: BD 0B 47        JSR $0B47
0ACA: A7 80           STa ,X+
0ACC: 20 D9           BRA $0AA7
0ACE: 8C 05 E0        CMPX #$05E0
0AD1: 27 D4           BEQ $0AA7
0AD3: 30 1F           LEAX -$01,X
0AD5: A6 80           LDa ,X+
0AD7: A7 84           STa ,X
0AD9: 30 1F           LEAX -$01,X
0ADB: 86 CF           LDa #$CF
0ADD: A7 84           STa ,X
0ADF: 20 C6           BRA $0AA7
0AE1: 8C 05 FF        CMPX #$05FF
0AE4: 27 C1           BEQ $0AA7
0AE6: 30 01           LEAX +$01,X
0AE8: A6 84           LDa ,X
0AEA: 30 1F           LEAX -$01,X
0AEC: A7 80           STa ,X+
0AEE: 86 CF           LDa #$CF
0AF0: A7 84           STa ,X
0AF2: 20 B3           BRA $0AA7
0AF4: BD 0B 1C        JSR $0B1C
0AF7: 86 CF           LDa #$CF
0AF9: A7 84           STa ,X
0AFB: 20 AA           BRA $0AA7
0AFD: 8C 05 E0        CMPX #$05E0
0B00: 27 A5           BEQ $0AA7
0B02: 30 1F           LEAX -$01,X
0B04: BD 0B 1C        JSR $0B1C
0B07: 20 9E           BRA $0AA7
0B09: BD 0B 1C        JSR $0B1C
0B0C: 39              RTS
0B0D: 8E 05 E0        LDX #$05E0
0B10: C6 20           LDb #$20
0B12: 86 60           LDa #$60
0B14: A7 80           STa ,X+
0B16: 5A              DECb
0B17: 26 FB           BNE $0B14
0B19: 7E 0A A1        JMP $0AA1
0B1C: 1F 13           TFR X,U
0B1E: 31 01           LEAY +$01,X
0B20: 86 60           LDa #$60
0B22: A7 84           STa ,X
0B24: 10 8C 06 00     CMPY #$0600
0B28: 27 E2           BEQ $0B0C
0B2A: 10 8C 06 01     CMPY #$0601
0B2E: 27 DC           BEQ $0B0C
0B30: 10 8C 06 02     CMPY #$0602
0B34: 27 D6           BEQ $0B0C
0B36: A6 A0           LDa ,Y+
0B38: A7 80           STa ,X+
0B3A: 10 8C 06 00     CMPY #$0600
0B3E: 26 F6           BNE $0B36
0B40: 86 60           LDa #$60
0B42: A7 84           STa ,X
0B44: 1F 31           TFR U,X
0B46: 39              RTS
0B47: 8C 06 00        CMPX #$0600
0B4A: 27 17           BEQ $0B63
0B4C: BF 01 A7        STX $01A7
0B4F: 8E 06 00        LDX #$0600
0B52: 10 8E 05 FF     LDY #$05FF
0B56: E6 A2           LDb ,-Y
0B58: E7 82           STb ,-X
0B5A: BC 01 A7        CMPX $01A7
0B5D: 26 F7           BNE $0B56
0B5F: C6 60           LDb #$60
0B61: E7 84           STb ,X
0B63: 39              RTS
0B64: BD 0B 47        JSR $0B47
0B67: 86 CF           LDa #$CF
0B69: A7 84           STa ,X
0B6B: 39              RTS
0B6C: BD 13 19        JSR $1319
0B6F: AD 9F A0 00     JSR [$A000]
0B73: 4D              TSTa
0B74: 27 F6           BEQ $0B6C
0B76: 81 41           CMPa #$41
0B78: 24 06           BCC $0B80
0B7A: 81 20           CMPa #$20
0B7C: 25 02           BCS $0B80
0B7E: 8B 40           ADDa #$40
0B80: 39              RTS
0B81: 30 01           LEAX +$01,X
0B83: 1F 10           TFR X,D
0B85: F7 01 CF        STb $01CF
0B88: 8C 06 00        CMPX #$0600
0B8B: 27 F3           BEQ $0B80
0B8D: A6 84           LDa ,X
0B8F: 81 60           CMPa #$60
0B91: 24 EE           BCC $0B81
0B93: 10 8E 3B D5     LDY #$3BD5
0B97: BD 0B CC        JSR $0BCC
0B9A: 27 E7           BEQ $0B83
0B9C: C6 01           LDb #$01
0B9E: 31 21           LEAY +$01,Y
0BA0: BD 0B CC        JSR $0BCC
0BA3: 27 08           BEQ $0BAD
0BA5: 5C              INCb
0BA6: C1 05           CMPb #$05
0BA8: 26 F4           BNE $0B9E
0BAA: 8A 01           ORa #$01
0BAC: 39              RTS
0BAD: 1E 12           EXG X,Y
0BAF: BE 01 D8        LDX $01D8
0BB2: E7 80           STb ,X+
0BB4: A7 80           STa ,X+
0BB6: B6 01 CF        LDa $01CF
0BB9: A7 80           STa ,X+
0BBB: BF 01 D8        STX $01D8
0BBE: 1E 12           EXG X,Y
0BC0: C1 01           CMPb #$01
0BC2: 26 06           BNE $0BCA
0BC4: B6 01 BC        LDa $01BC
0BC7: B7 01 BB        STa $01BB
0BCA: 4F              CLRa
0BCB: 39              RTS
0BCC: A6 A4           LDa ,Y
0BCE: 26 03           BNE $0BD3
0BD0: 8A 01           ORa #$01
0BD2: 39              RTS
0BD3: B7 01 AB        STa $01AB
0BD6: B7 01 D0        STa $01D0
0BD9: 34 10           PSHS ,X
0BDB: 31 21           LEAY +$01,Y
0BDD: A6 84           LDa ,X
0BDF: 81 60           CMPa #$60
0BE1: 27 53           BEQ $0C36
0BE3: 8C 06 00        CMPX #$0600
0BE6: 27 4E           BEQ $0C36
0BE8: 81 60           CMPa #$60
0BEA: 25 04           BCS $0BF0
0BEC: 30 01           LEAX +$01,X
0BEE: 20 ED           BRA $0BDD
0BF0: A1 A4           CMPa ,Y
0BF2: 26 42           BNE $0C36
0BF4: 30 01           LEAX +$01,X
0BF6: 31 21           LEAY +$01,Y
0BF8: 7A 01 AB        DEC $01AB
0BFB: 26 E0           BNE $0BDD
0BFD: B6 01 D0        LDa $01D0
0C00: 81 06           CMPa #$06
0C02: 27 06           BEQ $0C0A
0C04: A6 84           LDa ,X
0C06: 81 60           CMPa #$60
0C08: 25 33           BCS $0C3D
0C0A: A6 A4           LDa ,Y
0C0C: 35 20           PULS ,Y
0C0E: B7 01 AB        STa $01AB
0C11: A6 84           LDa ,X
0C13: 81 60           CMPa #$60
0C15: 27 0C           BEQ $0C23
0C17: BF 01 A7        STX $01A7
0C1A: 8C 06 00        CMPX #$0600
0C1D: 27 0A           BEQ $0C29
0C1F: 30 01           LEAX +$01,X
0C21: 20 EE           BRA $0C11
0C23: BF 01 A7        STX $01A7
0C26: 7C 01 A8        INC $01A8
0C29: B6 01 A8        LDa $01A8
0C2C: B7 01 BC        STa $01BC
0C2F: B6 01 AB        LDa $01AB
0C32: 7F 01 A7        CLR $01A7
0C35: 39              RTS
0C36: 31 21           LEAY +$01,Y
0C38: 7A 01 AB        DEC $01AB
0C3B: 26 F9           BNE $0C36
0C3D: 35 10           PULS ,X
0C3F: 31 21           LEAY +$01,Y
0C41: 7E 0B CC        JMP $0BCC

0C44: A6 80           LDa ,X+
0C46: 1F 89           TFR A,B
0C48: 85 80           BITa #$80
0C4A: 27 13           BEQ $0C5F
0C4C: 34 30           PSHS ,Y,X
0C4E: 8E 33 9C        LDX #$339C
0C51: BD 0A 60        JSR $0A60
0C54: 24 06           BCC $0C5C
0C56: BD 0A 83        JSR $0A83
0C59: BD 0C 44        JSR $0C44
0C5C: 35 30           PULS ,X,Y
0C5E: 39              RTS

0C5F: 1F 98           TFR B,A
0C61: 10 8E 13 57     LDY #$1357
0C65: 48              ASLa
0C66: 6E B6           JMP [A,Y]
0C68: BD 0A 85        JSR $0A85
0C6B: BD 0A 99        JSR $0A99
0C6E: 24 0C           BCC $0C7C
0C70: 34 20           PSHS ,Y
0C72: BD 0C 44        JSR $0C44
0C75: 35 20           PULS ,Y
0C77: 27 F2           BEQ $0C6B
0C79: 1E 12           EXG X,Y
0C7B: 39              RTS
0C7C: 1E 12           EXG X,Y
0C7E: 4F              CLRa
0C7F: 39              RTS
0C80: BD 0A 85        JSR $0A85
0C83: BD 0A 99        JSR $0A99
0C86: 24 0C           BCC $0C94
0C88: 34 20           PSHS ,Y
0C8A: BD 0C 44        JSR $0C44
0C8D: 35 20           PULS ,Y
0C8F: 26 F2           BNE $0C83
0C91: 1E 12           EXG X,Y
0C93: 39              RTS
0C94: 1E 12           EXG X,Y
0C96: 8A 01           ORa #$01
0C98: 39              RTS
0C99: BD 0A 85        JSR $0A85
0C9C: E6 80           LDb ,X+
0C9E: BD 0A 99        JSR $0A99
0CA1: 24 F1           BCC $0C94
0CA3: 34 20           PSHS ,Y
0CA5: 34 04           PSHS ,B
0CA7: 1F 98           TFR B,A
0CA9: BD 0C 61        JSR $0C61
0CAC: 35 04           PULS ,B
0CAE: 27 09           BEQ $0CB9
0CB0: BD 0A 85        JSR $0A85
0CB3: 1E 12           EXG X,Y
0CB5: 35 20           PULS ,Y
0CB7: 20 E5           BRA $0C9E
0CB9: BD 0A 85        JSR $0A85
0CBC: BD 0C 44        JSR $0C44
0CBF: 35 10           PULS ,X
0CC1: 39              RTS
0CC2: BD 0C CE        JSR $0CCE
0CC5: 34 10           PSHS ,X
0CC7: BD 0D 8B        JSR $0D8B
0CCA: 35 10           PULS ,X
0CCC: 4F              CLRa
0CCD: 39              RTS
0CCE: A6 80           LDa ,X+
0CD0: 34 10           PSHS ,X
0CD2: B7 01 D5        STa $01D5
0CD5: 1F 89           TFR A,B
0CD7: 8E 15 A1        LDX #$15A1
0CDA: BD 0A 60        JSR $0A60
0CDD: BF 01 D6        STX $01D6
0CE0: BE 01 D3        LDX $01D3
0CE3: BD 0A 83        JSR $0A83
0CE6: B6 01 D5        LDa $01D5
0CE9: A7 84           STa ,X
0CEB: 35 10           PULS ,X
0CED: 4F              CLRa
0CEE: 39              RTS
0CEF: FE 01 C6        LDU $01C6
0CF2: FF 01 C0        STU $01C0
0CF5: B6 01 C3        LDa $01C3
0CF8: B7 01 BF        STa $01BF
0CFB: 4F              CLRa
0CFC: 39              RTS
0CFD: FE 01 CC        LDU $01CC
0D00: FF 01 C0        STU $01C0
0D03: B6 01 C9        LDa $01C9
0D06: B7 01 BF        STa $01BF
0D09: 4F              CLRa
0D0A: 39              RTS
0D0B: E6 80           LDb ,X+
0D0D: 34 10           PSHS ,X
0D0F: F7 01 BF        STb $01BF
0D12: 27 06           BEQ $0D1A
0D14: BD 11 7D        JSR $117D
0D17: BF 01 C0        STX $01C0
0D1A: 35 10           PULS ,X
0D1C: 4F              CLRa
0D1D: 39              RTS
0D1E: FE 01 C6        LDU $01C6
0D21: 34 40           PSHS ,U
0D23: FE 01 CC        LDU $01CC
0D26: 34 40           PSHS ,U
0D28: B6 01 C9        LDa $01C9
0D2B: F6 01 C3        LDb $01C3
0D2E: 34 06           PSHS ,B,A
0D30: B6 01 D1        LDa $01D1
0D33: 34 02           PSHS ,A
0D35: A6 80           LDa ,X+
0D37: B7 01 D1        STa $01D1
0D3A: EC 81           LDD ,X++ 
0D3C: F7 01 AB        STb $01AB
0D3F: 34 10           PSHS ,X
0D41: B7 01 C3        STa $01C3
0D44: 1F 89           TFR A,B
0D46: 27 06           BEQ $0D4E
0D48: BD 11 7D        JSR $117D
0D4B: BF 01 C6        STX $01C6
0D4E: F6 01 AB        LDb $01AB
0D51: F7 01 C9        STb $01C9
0D54: 27 06           BEQ $0D5C
0D56: BD 11 7D        JSR $117D
0D59: BF 01 CC        STX $01CC
0D5C: 8E 2F 24        LDX #$2F24
0D5F: BD 0A 83        JSR $0A83
0D62: BD 0C 44        JSR $0C44
0D65: 1F A8           TFR CC,A
0D67: B7 01 AB        STa $01AB
0D6A: 35 20           PULS ,Y
0D6C: 35 02           PULS ,A
0D6E: B7 01 D1        STa $01D1
0D71: 35 06           PULS ,A,B
0D73: F7 01 C3        STb $01C3
0D76: B7 01 C9        STa $01C9
0D79: 35 40           PULS ,U
0D7B: FF 01 CC        STU $01CC
0D7E: 35 40           PULS ,U
0D80: FF 01 C6        STU $01C6
0D83: 1E 12           EXG X,Y
0D85: B6 01 AB        LDa $01AB
0D88: 1F 8A           TFR A,CC
0D8A: 39              RTS
0D8B: B6 01 D2        LDa $01D2
0D8E: 81 38           CMPa #$38
0D90: 27 04           BEQ $0D96
0D92: 81 13           CMPa #$13
0D94: 26 F4           BNE $0D8A
0D96: BE 01 D6        LDX $01D6
0D99: BD 0A 83        JSR $0A83
0D9C: 30 01           LEAX +$01,X
0D9E: C6 03           LDb #$03
0DA0: BD 0A 68        JSR $0A68
0DA3: 24 1F           BCC $0DC4
0DA5: B6 01 D2        LDa $01D2
0DA8: 81 38           CMPa #$38
0DAA: 27 0A           BEQ $0DB6
0DAC: 34 10           PSHS ,X
0DAE: 8E 0E 23        LDX #$0E23
0DB1: BD 0C 44        JSR $0C44
0DB4: 35 10           PULS ,X
0DB6: BD 0A 83        JSR $0A83
0DB9: BD 0C 44        JSR $0C44
0DBC: B6 01 D2        LDa $01D2
0DBF: 81 38           CMPa #$38
0DC1: 26 01           BNE $0DC4
0DC3: 39              RTS
0DC4: 8E 1B 42        LDX #$1B42
0DC7: BD 0A 83        JSR $0A83
0DCA: 34 20           PSHS ,Y
0DCC: BD 0A 83        JSR $0A83
0DCF: B6 01 D5        LDa $01D5
0DD2: A1 84           CMPa ,X
0DD4: 26 41           BNE $0E17
0DD6: 30 02           LEAX +$02,X
0DD8: A6 80           LDa ,X+
0DDA: 34 02           PSHS ,A
0DDC: C6 03           LDb #$03
0DDE: BD 0A 68        JSR $0A68
0DE1: 24 32           BCC $0E15
0DE3: 34 20           PSHS ,Y
0DE5: BD 0A 83        JSR $0A83
0DE8: BD 0C 44        JSR $0C44
0DEB: 35 20           PULS ,Y
0DED: 35 02           PULS ,A
0DEF: 34 02           PSHS ,A
0DF1: 84 08           ANDa #$08
0DF3: 27 20           BEQ $0E15
0DF5: 35 02           PULS ,A
0DF7: 34 02           PSHS ,A
0DF9: 84 0A           ANDa #$0A
0DFB: 88 0A           EORa #$0A
0DFD: 26 0C           BNE $0E0B
0DFF: 34 20           PSHS ,Y
0E01: 8E 0E 21        LDX #$0E21
0E04: BD 0C 44        JSR $0C44
0E07: 35 20           PULS ,Y
0E09: 20 0A           BRA $0E15
0E0B: 34 20           PSHS ,Y
0E0D: 8E 0E 22        LDX #$0E22
0E10: BD 0C 44        JSR $0C44
0E13: 35 20           PULS ,Y
0E15: 35 02           PULS ,A
0E17: 1E 12           EXG X,Y
0E19: 35 20           PULS ,Y
0E1B: BD 0A 99        JSR $0A99
0E1E: 25 AA           BCS $0DCA
0E20: 39              RTS
0E21: 8A 8B           ORa #$8B
0E23: 8C E6 80        CMPX #$E680
0E26: 34 10           PSHS ,X
0E28: BD 11 7D        JSR $117D
0E2B: BD 08 EB        JSR $08EB
0E2E: 35 10           PULS ,X
0E30: 39              RTS
0E31: B6 01 D2        LDa $01D2
0E34: A1 80           CMPa ,X+
0E36: 39              RTS
0E37: E6 80           LDb ,X+
0E39: 34 10           PSHS ,X
0E3B: F7 01 D2        STb $01D2
0E3E: BD 11 7D        JSR $117D
0E41: BF 01 D3        STX $01D3
0E44: 35 10           PULS ,X
0E46: 4F              CLRa
0E47: 39              RTS
0E48: E6 80           LDb ,X+
0E4A: 7E 10 4A        JMP $104A
0E4D: EC 81           LDD ,X++ 
0E4F: 34 10           PSHS ,X
0E51: B7 01 AB        STa $01AB
0E54: BD 11 7D        JSR $117D
0E57: BD 0A 83        JSR $0A83
0E5A: EC 81           LDD ,X++ 
0E5C: B1 01 AB        CMPa $01AB
0E5F: 35 10           PULS ,X
0E61: 39              RTS
0E62: 8A 01           ORa #$01
0E64: 39              RTS
0E65: B6 01 D2        LDa $01D2
0E68: 81 38           CMPa #$38
0E6A: 27 19           BEQ $0E85
0E6C: 81 13           CMPa #$13
0E6E: 26 0E           BNE $0E7E
0E70: C6 13           LDb #$13
0E72: 34 10           PSHS ,X
0E74: BD 11 7D        JSR $117D
0E77: BD 08 EB        JSR $08EB
0E7A: 35 10           PULS ,X
0E7C: 27 07           BEQ $0E85
0E7E: BD 0A 85        JSR $0A85
0E81: 1E 12           EXG X,Y
0E83: 20 03           BRA $0E88
0E85: BD 11 99        JSR $1199
0E88: 4F              CLRa
0E89: 39              RTS
0E8A: BD 0D 8B        JSR $0D8B
0E8D: 4F              CLRa
0E8E: 39              RTS
0E8F: 34 10           PSHS ,X
0E91: 86 0D           LDa #$0D
0E93: BD 11 D5        JSR $11D5
0E96: 8E 1B 42        LDX #$1B42
0E99: BD 0A 83        JSR $0A83
0E9C: BD 0A 99        JSR $0A99
0E9F: 24 2A           BCC $0ECB
0EA1: 34 20           PSHS ,Y
0EA3: BD 0A 83        JSR $0A83
0EA6: E6 84           LDb ,X
0EA8: F1 01 D2        CMPb $01D2
0EAB: 26 18           BNE $0EC5
0EAD: 30 02           LEAX +$02,X
0EAF: A6 80           LDa ,X+
0EB1: 84 20           ANDa #$20
0EB3: 27 10           BEQ $0EC5
0EB5: C6 02           LDb #$02
0EB7: BD 0A 68        JSR $0A68
0EBA: 24 09           BCC $0EC5
0EBC: 30 01           LEAX +$01,X
0EBE: 34 20           PSHS ,Y
0EC0: BD 11 8D        JSR $118D
0EC3: 35 20           PULS ,Y
0EC5: 1E 12           EXG X,Y
0EC7: 35 20           PULS ,Y
0EC9: 20 D1           BRA $0E9C
0ECB: 4F              CLRa
0ECC: 35 10           PULS ,X
0ECE: 39              RTS
0ECF: FE 01 C6        LDU $01C6
0ED2: B6 01 C3        LDa $01C3
0ED5: FF 01 D8        STU $01D8
0ED8: 4D              TSTa
0ED9: 27 10           BEQ $0EEB
0EDB: E6 80           LDb ,X+
0EDD: 34 10           PSHS ,X
0EDF: BD 11 7D        JSR $117D
0EE2: 1E 12           EXG X,Y
0EE4: 35 10           PULS ,X
0EE6: 10 BC 01 D8     CMPY $01D8
0EEA: 39              RTS
0EEB: 5D              TSTb
0EEC: 39              RTS
0EED: FE 01 CC        LDU $01CC
0EF0: B6 01 C9        LDa $01C9
0EF3: 20 E0           BRA $0ED5
0EF5: FE 01 C0        LDU $01C0
0EF8: B6 01 BF        LDa $01BF
0EFB: 7E 0E D5        JMP $0ED5
0EFE: E6 80           LDb ,X+
0F00: F1 01 D1        CMPb $01D1
0F03: 39              RTS
0F04: 34 10           PSHS ,X
0F06: BE 01 C0        LDX $01C0
0F09: BD 0A 83        JSR $0A83
0F0C: B6 01 D2        LDa $01D2
0F0F: A7 84           STa ,X
0F11: 4F              CLRa
0F12: 35 10           PULS ,X
0F14: 39              RTS
0F15: 34 10           PSHS ,X
0F17: BE 01 C0        LDX $01C0
0F1A: BD 0A 83        JSR $0A83
0F1D: B6 01 D5        LDa $01D5
0F20: A7 84           STa ,X
0F22: 35 10           PULS ,X
0F24: 4F              CLRa
0F25: 39              RTS
0F26: 34 10           PSHS ,X
0F28: BE 01 D6        LDX $01D6
0F2B: BD 0A 83        JSR $0A83
0F2E: 30 01           LEAX +$01,X
0F30: C6 04           LDb #$04
0F32: BD 0A 68        JSR $0A68
0F35: 24 08           BCC $0F3F
0F37: BD 0A 83        JSR $0A83
0F3A: BD 0C 44        JSR $0C44
0F3D: 27 3B           BEQ $0F7A
0F3F: B6 01 C9        LDa $01C9
0F42: 27 17           BEQ $0F5B
0F44: BE 01 CC        LDX $01CC
0F47: BD 0A 83        JSR $0A83
0F4A: 30 03           LEAX +$03,X
0F4C: C6 06           LDb #$06
0F4E: BD 0A 68        JSR $0A68
0F51: 24 08           BCC $0F5B
0F53: BD 0A 83        JSR $0A83
0F56: BD 0C 44        JSR $0C44
0F59: 27 1F           BEQ $0F7A
0F5B: B6 01 C3        LDa $01C3
0F5E: 26 05           BNE $0F65
0F60: 35 10           PULS ,X
0F62: 8A 01           ORa #$01
0F64: 39              RTS
0F65: BE 01 C6        LDX $01C6
0F68: BD 0A 83        JSR $0A83
0F6B: 30 03           LEAX +$03,X
0F6D: C6 07           LDb #$07
0F6F: BD 0A 68        JSR $0A68
0F72: 24 EC           BCC $0F60
0F74: BD 0A 83        JSR $0A83
0F77: BD 0C 44        JSR $0C44
0F7A: 35 10           PULS ,X
0F7C: 39              RTS
0F7D: 34 10           PSHS ,X
0F7F: BE 01 C0        LDX $01C0
0F82: B6 01 BF        LDa $01BF
0F85: 20 08           BRA $0F8F
0F87: 34 10           PSHS ,X
0F89: BE 01 C6        LDX $01C6
0F8C: B6 01 C3        LDa $01C3
0F8F: 27 E9           BEQ $0F7A
0F91: C6 13           LDb #$13
0F93: 34 10           PSHS ,X
0F95: BD 11 7D        JSR $117D
0F98: BD 08 EB        JSR $08EB
0F9B: 35 10           PULS ,X
0F9D: 26 11           BNE $0FB0
0F9F: BD 0A 83        JSR $0A83
0FA2: 30 03           LEAX +$03,X
0FA4: C6 02           LDb #$02
0FA6: BD 0A 68        JSR $0A68
0FA9: 24 05           BCC $0FB0
0FAB: 30 01           LEAX +$01,X
0FAD: BD 11 99        JSR $1199
0FB0: 35 10           PULS ,X
0FB2: 4F              CLRa
0FB3: 39              RTS
0FB4: 34 10           PSHS ,X
0FB6: BE 01 CC        LDX $01CC
0FB9: B6 01 C9        LDa $01C9
0FBC: 20 D1           BRA $0F8F
0FBE: 34 10           PSHS ,X
0FC0: BE 01 C0        LDX $01C0
0FC3: B6 01 BF        LDa $01BF
0FC6: 27 0E           BEQ $0FD6
0FC8: BD 0A 83        JSR $0A83
0FCB: 30 02           LEAX +$02,X
0FCD: A6 84           LDa ,X
0FCF: 35 10           PULS ,X
0FD1: A4 84           ANDa ,X
0FD3: A8 80           EORa ,X+
0FD5: 39              RTS
0FD6: 35 10           PULS ,X
0FD8: 30 01           LEAX +$01,X
0FDA: 8A 01           ORa #$01
0FDC: 39              RTS
0FDD: 34 10           PSHS ,X
0FDF: BE 01 C0        LDX $01C0
0FE2: B6 01 BF        LDa $01BF
0FE5: 10 27 FF 77     LBEQ $0F60
0FE9: BD 0A 83        JSR $0A83
0FEC: 30 02           LEAX +$02,X
0FEE: A6 84           LDa ,X
0FF0: 88 02           EORa #$02
0FF2: A7 84           STa ,X
0FF4: 35 10           PULS ,X
0FF6: 4F              CLRa
0FF7: 39              RTS
0FF8: 34 10           PSHS ,X
0FFA: BE 01 C0        LDX $01C0
0FFD: B6 01 BF        LDa $01BF
1000: 10 27 FF 5C     LBEQ $0F60
1004: BD 0A 83        JSR $0A83
1007: 30 02           LEAX +$02,X
1009: A6 84           LDa ,X
100B: 88 01           EORa #$01
100D: A7 84           STa ,X
100F: 35 10           PULS ,X
1011: 4F              CLRa
1012: 39              RTS
1013: BD 0C 44        JSR $0C44
1016: 26 03           BNE $101B
1018: 8A 01           ORa #$01
101A: 39              RTS
101B: 4F              CLRa
101C: 39              RTS
101D: E6 80           LDb ,X+
101F: 34 10           PSHS ,X
1021: BD 11 7D        JSR $117D
1024: BD 0A 83        JSR $0A83
1027: 35 20           PULS ,Y
1029: A6 A0           LDa ,Y+
102B: A7 84           STa ,X
102D: 1E 12           EXG X,Y
102F: 4F              CLRa
1030: 39              RTS
1031: 34 10           PSHS ,X
1033: BE 01 C0        LDX $01C0
1036: BD 0A 83        JSR $0A83
1039: E6 84           LDb ,X
103B: 35 10           PULS ,X
103D: 10 27 F8 CF     LBEQ $0910
1041: F1 01 D2        CMPb $01D2
1044: 27 EA           BEQ $1030
1046: C5 80           BITb #$80
1048: 26 E6           BNE $1030
104A: 34 10           PSHS ,X
104C: BD 11 7D        JSR $117D
104F: 20 E5           BRA $1036
1051: 8E 1B 42        LDX #$1B42
1054: 7F 01 D0        CLR $01D0
1057: BD 0A 83        JSR $0A83
105A: BD 0A 99        JSR $0A99
105D: 24 D1           BCC $1030
105F: 7C 01 D0        INC $01D0
1062: 34 20           PSHS ,Y
1064: BD 0A 83        JSR $0A83
1067: A6 84           LDa ,X
1069: B7 01 AB        STa $01AB
106C: 34 20           PSHS ,Y
106E: A6 84           LDa ,X
1070: 27 42           BEQ $10B4
1072: 30 03           LEAX +$03,X
1074: C6 08           LDb #$08
1076: BD 0A 68        JSR $0A68
1079: 24 39           BCC $10B4
107B: BD 0A 83        JSR $0A83
107E: 34 10           PSHS ,X
1080: BD 13 19        JSR $1319
1083: F6 01 D0        LDb $01D0
1086: F7 01 D2        STb $01D2
1089: BD 11 7D        JSR $117D
108C: BF 01 D3        STX $01D3
108F: F6 01 AB        LDb $01AB
1092: 5D              TSTb
1093: 2B 0E           BMI $10A3
1095: BD 11 7D        JSR $117D
1098: BD 0A 83        JSR $0A83
109B: E6 84           LDb ,X
109D: 26 F3           BNE $1092
109F: 35 10           PULS ,X
10A1: 20 11           BRA $10B4
10A3: F7 01 D5        STb $01D5
10A6: 8E 15 A1        LDX #$15A1
10A9: BD 0A 60        JSR $0A60
10AC: BF 01 D6        STX $01D6
10AF: 35 10           PULS ,X
10B1: BD 0C 44        JSR $0C44
10B4: 35 10           PULS ,X
10B6: 35 20           PULS ,Y
10B8: 20 A0           BRA $105A
10BA: B6 13 B8        LDa $13B8
10BD: A1 80           CMPa ,X+
10BF: 25 05           BCS $10C6
10C1: 27 03           BEQ $10C6
10C3: 8A 01           ORa #$01
10C5: 39              RTS
10C6: 4F              CLRa
10C7: 39              RTS
10C8: A6 80           LDa ,X+
10CA: B7 01 AB        STa $01AB
10CD: 34 10           PSHS ,X
10CF: BE 01 C0        LDX $01C0
10D2: BD 0A 83        JSR $0A83
10D5: 30 03           LEAX +$03,X
10D7: 34 10           PSHS ,X
10D9: 34 20           PSHS ,Y
10DB: C6 09           LDb #$09
10DD: BD 0A 68        JSR $0A68
10E0: 24 29           BCC $110B
10E2: BD 0A 83        JSR $0A83
10E5: 30 01           LEAX +$01,X
10E7: A6 84           LDa ,X
10E9: B0 01 AB        SUBa $01AB
10EC: 24 01           BCC $10EF
10EE: 4F              CLRa
10EF: A7 84           STa ,X
10F1: 35 20           PULS ,Y
10F3: 35 10           PULS ,X
10F5: 4D              TSTa
10F6: 27 04           BEQ $10FC
10F8: 35 10           PULS ,X
10FA: 4F              CLRa
10FB: 39              RTS
10FC: C6 0A           LDb #$0A
10FE: BD 0A 68        JSR $0A68
1101: 24 F5           BCC $10F8
1103: BD 0A 83        JSR $0A83
1106: BD 0C 44        JSR $0C44
1109: 20 ED           BRA $10F8
110B: 35 20           PULS ,Y
110D: 35 10           PULS ,X
110F: 20 E7           BRA $10F8
1111: E6 80           LDb ,X+
1113: A6 80           LDa ,X+
1115: B7 01 AB        STa $01AB
1118: 34 10           PSHS ,X
111A: BD 11 7D        JSR $117D
111D: BD 0A 83        JSR $0A83
1120: 1F 13           TFR X,U
1122: F6 01 AB        LDb $01AB
1125: BD 11 7D        JSR $117D
1128: BD 0A 83        JSR $0A83
112B: A6 84           LDa ,X
112D: E6 C4           LDb ,U
112F: A7 C4           STa ,U
1131: E7 84           STb ,X
1133: 35 10           PULS ,X
1135: 4F              CLRa
1136: 39              RTS
1137: 35 10           PULS ,X
1139: 4F              CLRa
113A: 39              RTS
113B: A6 80           LDa ,X+
113D: B7 01 AB        STa $01AB
1140: 34 10           PSHS ,X
1142: BE 01 C0        LDX $01C0
1145: BD 0A 83        JSR $0A83
1148: 30 03           LEAX +$03,X
114A: C6 09           LDb #$09
114C: BD 0A 68        JSR $0A68
114F: 24 E6           BCC $1137
1151: BD 0A 83        JSR $0A83
1154: EC 84           LDD ,X
1156: FB 01 AB        ADDb $01AB
1159: B7 01 AB        STa $01AB
115C: F1 01 AB        CMPb $01AB
115F: 25 03           BCS $1164
1161: F6 01 AB        LDb $01AB
1164: 30 01           LEAX +$01,X
1166: E7 84           STb ,X
1168: 20 CD           BRA $1137
116A: B6 01 D2        LDa $01D2
116D: 81 13           CMPa #$13
116F: 26 08           BNE $1179
1171: 7A 01 E3        DEC $01E3
1174: 86 0D           LDa #$0D
1176: BD 11 D5        JSR $11D5
1179: 4F              CLRa
117A: 39              RTS
117B: 20 FE           BRA $117B
117D: 8E 1B 42        LDX #$1B42
1180: BD 0A 83        JSR $0A83
1183: 5A              DECb
1184: 27 F4           BEQ $117A
1186: BD 0A 83        JSR $0A83
1189: 1E 12           EXG X,Y
118B: 20 F6           BRA $1183
118D: BD 11 99        JSR $1199
1190: 86 0D           LDa #$0D
1192: BD 11 D5        JSR $11D5
1195: 7A 01 E3        DEC $01E3
1198: 39              RTS
1199: 4F              CLRa
119A: E6 84           LDb ,X
119C: C5 80           BITb #$80
119E: 27 04           BEQ $11A4
11A0: A6 80           LDa ,X+
11A2: 84 7F           ANDa #$7F
11A4: E6 80           LDb ,X+
11A6: FD 01 AB        STD $01AB
11A9: FC 01 AB        LDD $01AB
11AC: 10 83 00 02     CMPD #$0002
11B0: 25 0E           BCS $11C0
11B2: BD 12 59        JSR $1259
11B5: FC 01 AB        LDD $01AB
11B8: 83 00 02        SUBd #$0002
11BB: FD 01 AB        STD $01AB
11BE: 20 E9           BRA $11A9
11C0: 5D              TSTb
11C1: 27 0C           BEQ $11CF
11C3: A6 80           LDa ,X+
11C5: 34 04           PSHS ,B
11C7: BD 11 D5        JSR $11D5
11CA: 35 04           PULS ,B
11CC: 5A              DECb
11CD: 20 F1           BRA $11C0
11CF: 86 20           LDa #$20
11D1: BD 11 D5        JSR $11D5
11D4: 39              RTS
11D5: F6 01 BE        LDb $01BE
11D8: C1 20           CMPb #$20
11DA: 26 16           BNE $11F2
11DC: 81 20           CMPa #$20
11DE: 27 52           BEQ $1232
11E0: 81 2E           CMPa #$2E
11E2: 27 08           BEQ $11EC
11E4: 81 3F           CMPa #$3F
11E6: 27 04           BEQ $11EC
11E8: 81 21           CMPa #$21
11EA: 26 06           BNE $11F2
11EC: DE 88           LDU $88
11EE: 33 5F           LEAU -$01,U
11F0: DF 88           STU $88
11F2: B7 01 BE        STa $01BE
11F5: AD 9F A0 02     JSR [$A002]
11F9: 96 89           LDa $89
11FB: 81 FE           CMPa #$FE
11FD: 25 33           BCS $1232
11FF: DE 88           LDU $88
1201: 33 C8 DF        LEAU -$21,U
1204: 86 0D           LDa #$0D
1206: AD 9F A0 02     JSR [$A002]
120A: 7A 01 E3        DEC $01E3
120D: A6 C4           LDa ,U
120F: 81 60           CMPa #$60
1211: 27 04           BEQ $1217
1213: 33 5F           LEAU -$01,U
1215: 20 F6           BRA $120D
1217: 33 41           LEAU +$01,U
1219: A6 C4           LDa ,U
121B: 81 60           CMPa #$60
121D: 27 13           BEQ $1232
121F: C6 60           LDb #$60
1221: E7 C4           STb ,U
1223: 81 60           CMPa #$60
1225: 25 02           BCS $1229
1227: 80 40           SUBa #$40
1229: B7 01 BE        STa $01BE
122C: AD 9F A0 02     JSR [$A002]
1230: 20 E5           BRA $1217
1232: 7D 01 E3        TST $01E3
1235: 2B 01           BMI $1238
1237: 39              RTS
1238: B6 01 BE        LDa $01BE
123B: 34 76           PSHS ,U,Y,X,B,A
123D: 86 0D           LDa #$0D
123F: B7 01 E3        STa $01E3
1242: 8E 13 DB        LDX #$13DB
1245: E6 80           LDb ,X+
1247: BD 11 C0        JSR $11C0
124A: BD 0B 6C        JSR $0B6C
124D: 9E 88           LDX $88
124F: 30 18           LEAX -$08,X
1251: 9F 88           STX $88
1253: 35 76           PULS ,A,B,X,Y,U
1255: B7 01 BE        STa $01BE
1258: 39              RTS
1259: 10 8E 13 15     LDY #$1315
125D: C6 03           LDb #$03
125F: F7 13 12        STb $1312
1262: A6 80           LDa ,X+
1264: B7 01 DE        STa $01DE
1267: A6 80           LDa ,X+
1269: B7 01 DD        STa $01DD
126C: 31 23           LEAY +$03,Y
126E: CE 00 28        LDU #$0028
1271: FF 13 13        STU $1313
1274: 86 11           LDa #$11
1276: B7 01 DA        STa $01DA
1279: 7F 01 DB        CLR $01DB
127C: 7F 01 DC        CLR $01DC
127F: 79 01 DE        ROL $01DE
1282: 79 01 DD        ROL $01DD
1285: 7A 01 DA        DEC $01DA
1288: 27 39           BEQ $12C3
128A: 86 00           LDa #$00
128C: 89 00           ADCa #$00
128E: 78 01 DC        LSL $01DC
1291: 79 01 DB        ROL $01DB
1294: BB 01 DC        ADDa $01DC
1297: B0 13 14        SUBa $1314
129A: B7 01 E0        STa $01E0
129D: B6 01 DB        LDa $01DB
12A0: B2 13 13        SBCa $1313
12A3: B7 01 DF        STa $01DF
12A6: 24 0B           BCC $12B3
12A8: FC 01 DF        LDD $01DF
12AB: F3 13 13        ADDD $1313
12AE: FD 01 DB        STD $01DB
12B1: 20 06           BRA $12B9
12B3: FC 01 DF        LDD $01DF
12B6: FD 01 DB        STD $01DB
12B9: 25 04           BCS $12BF
12BB: 1A 01           ORCC #$01
12BD: 20 C0           BRA $127F
12BF: 1C FE           ANDCC #$FE
12C1: 20 BC           BRA $127F
12C3: FC 01 DB        LDD $01DB
12C6: C3 12 EA        ADDd #$12EA
12C9: 1F 03           TFR D,U
12CB: A6 C4           LDa ,U
12CD: A7 A2           STa ,-Y
12CF: 7A 13 12        DEC $1312
12D2: 26 9A           BNE $126E
12D4: 10 8E 13 15     LDY #$1315
12D8: C6 03           LDb #$03
12DA: A6 A0           LDa ,Y+
12DC: 34 04           PSHS ,B
12DE: BD 11 D5        JSR $11D5
12E1: 35 04           PULS ,B
12E3: 5A              DECb
12E4: 26 F4           BNE $12DA
12E6: FC 01 AB        LDD $01AB
12E9: 39              RTS

12EA: 3F              SWI1
12EB: 21 32           BRN $131F
12ED: 20 22           BRA $1311
12EF: 27 3C           BEQ $132D
12F1: 3E              RESET*
12F2: 2F 30           BLE $1324
12F4: 33 41           LEAU +$01,U
12F6: 42              ?????
12F7: 43              COMa
12F8: 44              LSRa
12F9: 45              ?????
12FA: 46              RORa
12FB: 47              ASRa
12FC: 48              ASLa
12FD: 49              ROLa
12FE: 4A              DECa
12FF: 4B              ?????
1300: 4C              INCa
1301: 4D              TSTa
1302: 4E              ?????
1303: 4F              CLRa
1304: 50              NEGb
1305: 51              ?????
1306: 52              ?????
1307: 53              COMb
1308: 54              LSRb
1309: 55              ?????
130A: 56              RORb
130B: 57              ASRb
130C: 58              ASLb
130D: 59              ROLb
130E: 5A              DECb
130F: 2D 2C           BLT $133D
1311: 2E 00           BGT $1313
1313: 00 00           NEG $00
1315: 00 00           NEG $00
1317: 00 00           NEG $00
1319: 34 14           PSHS ,X,B
131B: 8E 13 B8        LDX #$13B8
131E: C6 17           LDb #$17
1320: A6 84           LDa ,X
1322: 30 01           LEAX +$01,X
1324: 1A 01           ORCC #$01
1326: 84 06           ANDa #$06
1328: 27 07           BEQ $1331
132A: 81 06           CMPa #$06
132C: 1A 01           ORCC #$01
132E: 27 01           BEQ $1331
1330: 4F              CLRa
1331: A6 84           LDa ,X
1333: 25 03           BCS $1338
1335: 44              LSRa
1336: 20 03           BRA $133B
1338: 44              LSRa
1339: 8A 80           ORa #$80
133B: A7 84           STa ,X
133D: 30 1F           LEAX -$01,X
133F: A6 84           LDa ,X
1341: 25 03           BCS $1346
1343: 44              LSRa
1344: 20 03           BRA $1349
1346: 44              LSRa
1347: 8A 80           ORa #$80
1349: 84 FE           ANDa #$FE
134B: A7 84           STa ,X
134D: 5A              DECb
134E: 26 D2           BNE $1322
1350: 4F              CLRa
1351: 35 14           PULS ,B,X
1353: 39              RTS
1354: 94 A3           ANDa $A3
1356: AC 0C           CMPX +$0C,X
1358: C2 0E           SBCb #$0E
135A: 24 0E           BCC $136A
135C: 48              ASLa
135D: 0E 4D           JMP $4D
135F: 0E 65           JMP $65
1361: 10 BA           ?????
1363: 0E 8F           JMP $8F
1365: 0E 8A           JMP $8A
1367: 0E CF           JMP $CF
1369: 0E ED           JMP $ED
136B: 0E FE           JMP $FE
136D: 0C 99           INC $99
136F: 0E 62           JMP $62
1371: 0C 68           INC $68
1373: 0C 80           INC $80
1375: 0F 04           CLR $04
1377: 0F 15           CLR $15
1379: 0F 87           CLR $87
137B: 0F B4           CLR $B4
137D: 0F 26           CLR $26
137F: 10 13           ?????
1381: 0F BE           CLR $BE
1383: 0F 7D           CLR $7D
1385: 10 1D           ?????
1387: 10 31           ?????
1389: 0C CE           INC $CE
138B: 0C EF           INC $EF
138D: 0C FD           INC $FD
138F: 0D 0B           TST $0B
1391: 10 C8           ?????
1393: 11 11           ?????
1395: 0E 70           JMP $70
1397: 0E 31           JMP $31
1399: 0D 1E           TST $1E
139B: 11 6A           ?????
139D: 11 3B           ?????
139F: 11 7B           ?????
13A1: 11 6A           ?????
13A3: 11 6A           ?????
13A5: 11 6A           ?????
13A7: 11 6A           ?????
13A9: 0F DD           CLR $DD
13AB: 0F F8           CLR $F8
13AD: 13              SYNC
13AE: 19              DAA
13AF: 0E 37           JMP $37
13B1: 0E F5           JMP $F5
13B3: 00 12           NEG $12
13B5: 23 44           BLS $13FB
13B7: 1D              SEX
13B8: 27 4D           BEQ $1407
13BA: 2D 13           BLT $13CF
13BC: 06 3F           ROR $3F
13BE: 56              RORb
13BF: 45              ?????
13C0: 52              ?????
13C1: 42              ?????
13C2: 3F              SWI1
13C3: 06 3F           ROR $3F
13C5: 57              ASRb
13C6: 48              ASLa
13C7: 41              ?????
13C8: 54              LSRb
13C9: 3F              SWI1
13CA: 07 3F           ASR $3F
13CC: 57              ASRb
13CD: 48              ASLa
13CE: 49              ROLa
13CF: 43              COMa
13D0: 48              ASLa
13D1: 3F              SWI1
13D2: 08 3F           LSL $3F
13D4: 50              NEGb
13D5: 48              ASLa
13D6: 52              ?????
13D7: 41              ?????
13D8: 53              COMb
13D9: 45              ?????
13DA: 3F              SWI1
13DB: 07 2D           ASR $2D
13DD: 3C 4D           CWAI #4D
13DF: 4F              CLRa
13E0: 52              ?????
13E1: 45              ?????
13E2: 3E              RESET*
13E3: 05              ?????
13E4: 00 00           NEG $00
13E6: 00 01           NEG $01
13E8: 06 00           ROR $00
13EA: 00 00           NEG $00
13EC: 02              ?????
13ED: 07 00           ASR $00
13EF: 00 00           NEG $00
13F1: 03 08           COM $08
13F3: 00 00           NEG $00
13F5: 00 04           NEG $04
13F7: 09 00           ROL $00
13F9: 20 00           BRA $13FB
13FB: 05              ?????
13FC: 09 02           ROL $02
13FE: 20 20           BRA $1420
1400: 43              COMa
1401: 34 07           PSHS ,B,A,CC
1403: 00 80           NEG $80
1405: 05              ?????
1406: 34 07           PSHS ,B,A,CC
1408: 80 00           SUBa #$00
140A: 05              ?????
140B: 0A 00           DEC $00
140D: 20 00           BRA $140F
140F: 06 0A           ROR $0A
1411: 05              ?????
1412: 80 80           SUBa #$80
1414: 0F 0B           CLR $0B
1416: 00 00           NEG $00
1418: 00 07           NEG $07
141A: 04 02           LSR $02
141C: 10 40           ?????
141E: 09 04           ROL $04
1420: 00 10           NEG $10
1422: 00 09           NEG $09
1424: 0C 00           INC $00
1426: 00 00           NEG $00
1428: 0A 0C           DEC $0C
142A: 03 00           COM $00
142C: 80 0B           SUBa #$0B
142E: 0C 05           INC $05
1430: 00 80           NEG $80
1432: 10 03           ?????
1434: 03 40           COM $40
1436: 10 0D           ?????
1438: 03 08           COM $08
143A: 00 20           NEG $20
143C: 06 03           ROR $03
143E: 01              ?????
143F: 80 10           SUBa #$10
1441: 0E 0D           JMP $0D
1443: 01              ?????
1444: 80 10           SUBa #$10
1446: 0E 0E           JMP $0E
1448: 00 80           NEG $80
144A: 00 0B           NEG $0B
144C: 0E 05           JMP $05
144E: 00 80           NEG $80
1450: 0B              ?????
1451: 0F 00           CLR $00
1453: 02              ?????
1454: 00 11           NEG $11
1456: 0F 02           CLR $02
1458: 02              ?????
1459: 80 3A           SUBa #$3A
145B: 38              ?????
145C: 00 08           NEG $08
145E: 00 40           NEG $40
1460: 39              RTS
1461: 02              ?????
1462: 08 80           LSL $80
1464: 41              ?????
1465: 3A              ABX
1466: 02              ?????
1467: 01              ?????
1468: 80 42           SUBa #$42
146A: 10 00           ?????
146C: 80 00           SUBa #$00
146E: 12              NOP 
146F: 10 08           ?????
1471: 80 00           SUBa #$00
1473: 12              NOP 
1474: 10 08           ?????
1476: 00 80           NEG $80
1478: 12              NOP 
1479: 10 06           ?????
147B: 00 80           NEG $80
147D: 05              ?????
147E: 10 06           ?????
1480: 80 00           SUBa #$00
1482: 05              ?????
1483: 10 07           ?????
1485: 00 80           NEG $80
1487: 2D 10           BLT $1499
1489: 07 80           ASR $80
148B: 00 2D           NEG $2D
148D: 12              NOP 
148E: 00 80           NEG $80
1490: 00 15           NEG $15
1492: 15              ?????
1493: 00 80           NEG $80
1495: 00 17           NEG $17
1497: 15              ?????
1498: 07 00           ASR $00
149A: 80 17           SUBa #$17
149C: 15              ?????
149D: 08 00           LSL $00
149F: 80 17           SUBa #$17
14A1: 15              ?????
14A2: 09 00           ROL $00
14A4: 80 17           SUBa #$17
14A6: 15              ?????
14A7: 0C 00           INC $00
14A9: 80 17           SUBa #$17
14AB: 05              ?????
14AC: 01              ?????
14AD: 00 00           NEG $00
14AF: 01              ?????
14B0: 06 01           ROR $01
14B2: 00 00           NEG $00
14B4: 02              ?????
14B5: 07 01           ASR $01
14B7: 00 00           NEG $00
14B9: 03 08           COM $08
14BB: 01              ?????
14BC: 00 00           NEG $00
14BE: 04 0A           LSR $0A
14C0: 08 00           LSL $00
14C2: 20 06           BRA $14CA
14C4: 0A 08           DEC $08
14C6: 20 00           BRA $14C8
14C8: 06 0A           ROR $0A
14CA: 0A 20           DEC $20
14CC: 80 06           SUBa #$06
14CE: 0A 04           DEC $04
14D0: 20 80           BRA $1452
14D2: 06 0A           ROR $0A
14D4: 0C 20           INC $20
14D6: 80 06           SUBa #$06
14D8: 0C 07           INC $07
14DA: 00 00           NEG $00
14DC: 0A 0C           DEC $0C
14DE: 08 00           LSL $00
14E0: 00 0A           NEG $0A
14E2: 0C 09           INC $09
14E4: 80 00           SUBa #$00
14E6: 0B              ?????
14E7: 0C 09           INC $09
14E9: 00 80           NEG $80
14EB: 0A 0C           DEC $0C
14ED: 0B              ?????
14EE: 00 00           NEG $00
14F0: 0A 0C           DEC $0C
14F2: 0A 00           DEC $00
14F4: 00 0A           NEG $0A
14F6: 32 00           LEAS +$00,X
14F8: 00 00           NEG $00
14FA: 21 2B           BRN $1527
14FC: 00 00           NEG $00
14FE: 00 22           NEG $22
1500: 2D 00           BLT $1502
1502: 00 00           NEG $00
1504: 23 3B           BLS $1541
1506: 00 00           NEG $00
1508: 00 44           NEG $44
150A: 3B              RTI
150B: 00 10           NEG $10
150D: 00 45           NEG $45
150F: 3B              RTI
1510: 01              ?????
1511: 00 00           NEG $00
1513: 44              LSRa
1514: 3B              RTI
1515: 01              ?????
1516: 00 10           NEG $10
1518: 45              ?????
1519: 3C 00           CWAI #00
151B: 00 00           NEG $00
151D: 46              RORa
151E: 3C 00           CWAI #00
1520: 80 00           SUBa #$00
1522: 47              ASRa
1523: 3B              RTI
1524: 01              ?????
1525: 10 00           ?????
1527: 45              ?????
1528: 21 00           BRN $152A
152A: 00 00           NEG $00
152C: 25 21           BCS $154F
152E: 01              ?????
152F: 00 80           NEG $80
1531: 3D              MUL
1532: 21 07           BRN $153B
1534: 00 80           NEG $80
1536: 17 21 08        LBSR $3641
1539: 00 80           NEG $80
153B: 17 21 0B        LBSR $3649
153E: 00 80           NEG $80
1540: 26 23           BNE $1565
1542: 00 80           NEG $80
1544: 00 27           NEG $27
1546: 23 08           BLS $1550
1548: 00 80           NEG $80
154A: 27 23           BEQ $156F
154C: 05              ?????
154D: 00 80           NEG $80
154F: 27 24           BEQ $1575
1551: 02              ?????
1552: 10 80           ?????
1554: 28 24           BVC $157A
1556: 01              ?????
1557: 80 10           SUBa #$10
1559: 29 1C           BVS $1577
155B: 00 80           NEG $80
155D: 00 2D           NEG $2D
155F: 1F 00           TFR D,D
1561: 00 00           NEG $00
1563: 2F 1F           BLE $1584
1565: 0B              ?????
1566: 00 00           NEG $00
1568: 2F 09           BLE $1573
156A: 07 00           ASR $00
156C: 00 2F           NEG $2F
156E: 20 09           BRA $1579
1570: 00 80           NEG $80
1572: 34 3D           PSHS ,Y,X,DP,B,CC
1574: 00 80           NEG $80
1576: 00 48           NEG $48
1578: 3E              RESET*
1579: 08 80           LSL $80
157B: 00 48           NEG $48
157D: 3E              RESET*
157E: 08 00           LSL $00
1580: 80 48           SUBa #$48
1582: 09 08           ROL $08
1584: 00 80           NEG $80
1586: 48              ASLa
1587: 09 08           ROL $08
1589: 80 00           SUBa #$00
158B: 48              ASLa
158C: 3F              SWI1
158D: 00 00           NEG $00
158F: 00 4A           NEG $4A
1591: 3F              SWI1
1592: 02              ?????
1593: 00 00           NEG $00
1595: 4A              DECa
1596: 40              NEGa
1597: 00 80           NEG $80
1599: 00 49           NEG $49
159B: 40              NEGa
159C: 01              ?????
159D: 80 80           SUBa #$80
159F: 49              ROLa
15A0: 00 00           NEG $00
15A2: 85 9E           BITa #$9E
15A4: 81 3A           CMPa #$3A
15A6: 00 03           NEG $03
15A8: 2A 04           BPL $15AE
15AA: 28 5F           BVC $160B
15AC: BE 63 16        LDX $6316
15AF: 9E 7A           LDX $7A
15B1: 8B 61           ADDa #$61
15B3: 17 98 39        LBSR $ADEF
15B6: 17 FE 9F        LBSR $1458
15B9: 7B              ?????
15BA: 14              ?????
15BB: 54              LSRb
15BC: 8B 9B           ADDa #$9B
15BE: 6C 01           INC +$01,X
15C0: B3 59 90        SUBD $5990
15C3: 82 7B           SBCa #$7B
15C5: 3A              ABX
15C6: 15              ?????
15C7: 8D 7B           BSR $1644
15C9: 23 15           BLS $15E0
15CB: F3 B9 8E        ADDD $B98E
15CE: 48              ASLa
15CF: F7 17 17        STb $1717
15D2: BA 04 0B        ORa $040B
15D5: 0B              ?????
15D6: 09 0A           ROL $0A
15D8: 04 02           LSR $02
15DA: 00 95           NEG $95
15DC: 03 02           COM $02
15DE: 00 82           NEG $82
15E0: 82 49           SBCa #$49
15E2: 00 03           NEG $03
15E4: 35 04           PULS ,B
15E6: 33 5F           LEAU -$01,U
15E8: BE 03 15        LDX $0315
15EB: 5F              CLRb
15EC: B9 93 9A        ADCa $939A
15EF: 9E B4           LDX $B4
15F1: 7B              ?????
15F2: 14              ?????
15F3: E3 B8 F3        ADDD [-$ D,Y]
15F6: 8C 97 B9        CMPX #$97B9
15F9: 2F 49           BLE $1644
15FB: 39              RTS
15FC: 17 DB 9F        LBSR $F19E
15FF: 56              RORb
1600: D1 07           CMPb $07
1602: 71              ?????
1603: 96 D7           LDa $D7
1605: D6 B5           LDb $B5
1607: D6 9C           LDb $9C
1609: DB 72           ADDb $72
160B: 95 5F           BITa $5F
160D: 73 C1 B5        COM $C1B5
1610: D0 73           SUBb $73
1612: C1 8E           CMPb #$8E
1614: 48              ASLa
1615: 61              ?????
1616: 17 82 C6        LBSR $98DF
1619: 2E 04           BGT $161F
161B: 0F 0B           CLR $0B
161D: 0D 0A           TST $0A
161F: 04 02           LSR $02
1621: 00 81           NEG $81
1623: 02              ?????
1624: 02              ?????
1625: 00 83           NEG $83
1627: 03 02           COM $02
1629: 00 84           NEG $84
162B: 83 46 00        SUBd #$4600
162E: 03 3A           COM $3A
1630: 04 38           LSR $38
1632: 5F              CLRb
1633: BE 3A 15        LDX $3A15
1636: 6B              ?????
1637: 48              ASLa
1638: D6 97           LDb $97
163A: C0 7A           SUBb #$7A
163C: 39              RTS
163D: 17 DB 9F        LBSR $F1DF
1640: 1F D1           TFR ??,X
1642: 5B              ?????
1643: B1 5F BE        CMPa $5FBE
1646: 09 15           ROL $15
1648: 09 56           ROL $56
164A: 96 AF           LDa $AF
164C: 63 B1           COM [,Y++]
164E: 0B              ?????
164F: C0 56           SUBb #$56
1651: A4 30           ANDa -$10,Y
1653: 79 2F C0        ROL $2FC0
1656: 82 17           SBCa #$17
1658: 2F 62           BLE $16BC
165A: D5 15           BITb $15
165C: 7B              ?????
165D: 14              ?????
165E: 50              NEGb
165F: B8 BF 6D        EORa $BF6D
1662: 3A              ABX
1663: 15              ?????
1664: 73 7B 04        COM $7B04
1667: 9A 77           ORa $77
1669: BE 04 07        LDX $0407
166C: 0B              ?????
166D: 05              ?????
166E: 0A 01           DEC $01
1670: 02              ?????
1671: 00 82           NEG $82
1673: 84 5B           ANDa #$5B
1675: 00 03           NEG $03
1677: 37 04           PULU ,B
1679: 35 5F           PULS ,CC,A,B,DP,X,U
167B: BE F7 17        LDX $F717
167E: F3 B9 8E        ADDD $B98E
1681: 61              ?????
1682: B8 16 7B        EORa $167B
1685: 14              ?????
1686: 74 CA 4E        LSR $CA4E
1689: DB 11           ADDb $11
168B: A0 23           SUBa +$03,Y
168D: 15              ?????
168E: 15              ?????
168F: BA B5 D0        ORa $B5D0
1692: 0A BC           DEC $BC
1694: 46              RORa
1695: 48              ASLa
1696: 1B              ?????
1697: D0 56           SUBb $56
1699: F4 F4 72        ANDb $F472
169C: 4B              ?????
169D: 5E              ?????
169E: C3 B5 91        ADDd #$B591
16A1: 96 F0           LDa $F0
16A3: A4 91           ANDa [,X++]
16A5: 7A 89 17        DEC $8917
16A8: 82 17           SBCa #$17
16AA: 59              ROLb
16AB: 5E              ?????
16AC: 66 62           ROR +$02,S
16AE: 2E 04           BGT $16B4
16B0: 1F 0B           TFR D,DP
16B2: 1D              SEX
16B3: 0A 04           DEC $04
16B5: 02              ?????
16B6: 00 82           NEG $82
16B8: 03 02           COM $02
16BA: 00 87           NEG $87
16BC: 01              ?????
16BD: 08 0E           LSL $0E
16BF: 06 14           ROR $14
16C1: 1C 02           ANDCC #$02
16C3: 8D 00           BSR $16C5
16C5: 85 02           BITa #$02
16C7: 08 0E           LSL $0E
16C9: 06 14           ROR $14
16CB: 1C 03           ANDCC #$03
16CD: 8D 00           BSR $16CF
16CF: 86 85           LDa #$85
16D1: 13              SYNC
16D2: 00 03           NEG $03
16D4: 01              ?????
16D5: 81 04           CMPa #$04
16D7: 0D 0B           TST $0B
16D9: 0B              ?????
16DA: 0A 02           DEC $02
16DC: 08 0E           LSL $0E
16DE: 06 14           ROR $14
16E0: 1C 01           ANDCC #$01
16E2: 8D 00           BSR $16E4
16E4: 84 86           ANDa #$86
16E6: 13              SYNC
16E7: 00 03           NEG $03
16E9: 01              ?????
16EA: 81 04           CMPa #$04
16EC: 0D 0B           TST $0B
16EE: 0B              ?????
16EF: 0A 01           DEC $01
16F1: 08 0E           LSL $0E
16F3: 06 14           ROR $14
16F5: 1C 04           ANDCC #$04
16F7: 8D 00           BSR $16F9
16F9: 84 87           ANDa #$87
16FB: 25 00           BCS $16FD
16FD: 03 01           COM $01
16FF: 82 04           SBCa #$04
1701: 1F 0B           TFR D,DP
1703: 1D              SEX
1704: 0A 03           DEC $03
1706: 02              ?????
1707: 00 8A           NEG $8A
1709: 04 02           LSR $02
170B: 00 84           NEG $84
170D: 01              ?????
170E: 08 0E           LSL $0E
1710: 06 14           ROR $14
1712: 1C 06           ANDCC #$06
1714: 8D 00           BSR $1716
1716: 88 02           EORa #$02
1718: 08 0E           LSL $0E
171A: 06 14           ROR $14
171C: 1C 07           ANDCC #$07
171E: 8D 00           BSR $1720
1720: 89 88           ADCa #$88
1722: 42              ?????
1723: 00 03           NEG $03
1725: 30 04           LEAX +$04,X
1727: 2E 55           BGT $177E
1729: 45              ?????
172A: 8E 91 15        LDX #$9115
172D: 8A A3           ORa #$A3
172F: AD 5B           JSR -$05,U
1731: B1 01 B3        CMPa $01B3
1734: DB 95           ADDb $95
1736: 46              RORa
1737: 48              ASLa
1738: 59              ROLb
1739: 15              ?????
173A: 23 C6           BLS $1702
173C: 0E D0           JMP $D0
173E: 0B              ?????
173F: 8E 2F 49        LDX #$2F49
1742: E1 14           CMPb -$0C,X
1744: 74 CA F3        LSR $CAF3
1747: 5F              CLRb
1748: 56              RORb
1749: D1 03           CMPb $03
174B: 71              ?????
174C: 82 17           SBCa #$17
174E: DD 78           STD $78
1750: DB 16           ADDb $16
1752: C3 59 CF        ADDd #$59CF
1755: 98 04           EORa $04
1757: 0D 0B           TST $0B
1759: 0B              ?????
175A: 0A 02           DEC $02
175C: 08 0E           LSL $0E
175E: 06 14           ROR $14
1760: 1C 05           ANDCC #$05
1762: 8D 00           BSR $1764
1764: 87              ?????
1765: 89 13           ADCa #$13
1767: 00 03           NEG $03
1769: 01              ?????
176A: 81 04           CMPa #$04
176C: 0D 0B           TST $0B
176E: 0B              ?????
176F: 0A 01           DEC $01
1771: 08 0E           LSL $0E
1773: 06 14           ROR $14
1775: 1C 08           ANDCC #$08
1777: 8D 00           BSR $1779
1779: 87              ?????
177A: 8A 25           ORa #$25
177C: 00 03           NEG $03
177E: 01              ?????
177F: 82 04           SBCa #$04
1781: 1F 0B           TFR D,DP
1783: 1D              SEX
1784: 0A 04           DEC $04
1786: 02              ?????
1787: 00 87           NEG $87
1789: 03 02           COM $02
178B: 00 8C           NEG $8C
178D: 01              ?????
178E: 08 0E           LSL $0E
1790: 06 14           ROR $14
1792: 1C 0A           ANDCC #$0A
1794: 8D 00           BSR $1796
1796: 8B 02           ADDa #$02
1798: 08 0E           LSL $0E
179A: 06 14           ROR $14
179C: 1C 0B           ANDCC #$0B
179E: 8D 00           BSR $17A0
17A0: 8F              ?????
17A1: 8B 13           ADDa #$13
17A3: 00 03           NEG $03
17A5: 01              ?????
17A6: 81 04           CMPa #$04
17A8: 0D 0B           TST $0B
17AA: 0B              ?????
17AB: 0A 02           DEC $02
17AD: 08 0E           LSL $0E
17AF: 06 14           ROR $14
17B1: 1C 09           ANDCC #$09
17B3: 8D 00           BSR $17B5
17B5: 8A 8C           ORa #$8C
17B7: 41              ?????
17B8: 00 03           NEG $03
17BA: 27 0D           BEQ $17C9
17BC: 25 04           BCS $17C2
17BE: 0A 5F           DEC $5F
17C0: BE 23 15        LDX $2315
17C3: F3 B9 8E        ADDD $B98E
17C6: 61              ?????
17C7: B8 16 82        EORa $1682
17CA: 04 16           LSR $16
17CC: 5F              CLRb
17CD: BE 5B B1        LDX $5BB1
17D0: 4B              ?????
17D1: 7B              ?????
17D2: 83 48 5F        SUBd #$485F
17D5: A0 10           SUBa -$10,X
17D7: 99 D6           ADCa $D6
17D9: 6A D6           DEC [A,U]
17DB: 9C DB           CMPX $DB
17DD: 72              ?????
17DE: 95 5F           BITa $5F
17E0: 9B C1           ADDa $C1
17E2: 04 15           LSR $15
17E4: 0B              ?????
17E5: 13              SYNC
17E6: 0A 03           DEC $03
17E8: 02              ?????
17E9: 00 8E           NEG $8E
17EB: 04 02           LSR $02
17ED: 00 8A           NEG $8A
17EF: 01              ?????
17F0: 08 0E           LSL $0E
17F2: 06 14           ROR $14
17F4: 1C 0D           ANDCC #$0D
17F6: 8D 00           BSR $17F8
17F8: 8D 8D           BSR $1787
17FA: 13              SYNC
17FB: 00 03           NEG $03
17FD: 01              ?????
17FE: 81 04           CMPa #$04
1800: 0D 0B           TST $0B
1802: 0B              ?????
1803: 0A 02           DEC $02
1805: 08 0E           LSL $0E
1807: 06 14           ROR $14
1809: 1C 0C           ANDCC #$0C
180B: 8D 00           BSR $180D
180D: 8C 8E 36        CMPX #$8E36
1810: 00 03           NEG $03
1812: 2A 04           BPL $1818
1814: 28 5F           BVC $1875
1816: BE 2E 15        LDX $2E15
1819: E6 5F           LDb -$01,U
181B: 05              ?????
181C: B3 75 74        SUBD $7574
181F: D6 83           LDb $83
1821: F4 72 F3        ANDb $72F3
1824: 48              ASLa
1825: 39              RTS
1826: 17 FF 9F        LBSR $17C8
1829: 82 17           SBCa #$17
182B: 2F 62           BLE $188F
182D: D5 15           BITb $15
182F: 7B              ?????
1830: 14              ?????
1831: 50              NEGb
1832: B8 BF 6D        EORa $BF6D
1835: 3A              ABX
1836: 15              ?????
1837: 73 7B B5        COM $7BB5
183A: D0 9B           SUBb $9B
183C: C1 04           CMPb #$04
183E: 07 0B           ASR $0B
1840: 05              ?????
1841: 0A 04           DEC $04
1843: 02              ?????
1844: 00 8C           NEG $8C
1846: 8F              ?????
1847: 30 00           LEAX +$00,X
1849: 03 10           COM $10
184B: 0D 0E           TST $0E
184D: 04 0B           LSR $0B
184F: 5F              CLRb
1850: BE 99 16        LDX $9916
1853: C2 B3           SBCb #$B3
1855: 30 15           LEAX -$0B,X
1857: 11 58           ?????
1859: 46              RORa
185A: 83 04 1B        SUBd #$041B
185D: 0B              ?????
185E: 19              DAA
185F: 0A 01           DEC $01
1861: 08 0E           LSL $0E
1863: 06 14           ROR $14
1865: 1C 0E           ANDCC #$0E
1867: 8D 00           BSR $1869
1869: 8A 02           ORa #$02
186B: 02              ?????
186C: 00 91           NEG $91
186E: 03 08           COM $08
1870: 0E 06           JMP $06
1872: 14              ?????
1873: 1C 0F           ANDCC #$0F
1875: 8D 00           BSR $1877
1877: 90 90           SUBa $90
1879: 13              SYNC
187A: 00 03           NEG $03
187C: 01              ?????
187D: 81 04           CMPa #$04
187F: 0D 0B           TST $0B
1881: 0B              ?????
1882: 0A 04           DEC $04
1884: 08 0E           LSL $0E
1886: 06 14           ROR $14
1888: 1C 10           ANDCC #$10
188A: 8D 00           BSR $188C
188C: 8F              ?????
188D: 91 32           CMPa $32
188F: 00 03           NEG $03
1891: 14              ?????
1892: 0D 12           TST $12
1894: 83 04 0F        SUBd #$040F
1897: 5F              CLRb
1898: BE 5B B1        LDX $5BB1
189B: 4B              ?????
189C: 7B              ?????
189D: 83 48 23        SUBd #$4823
18A0: 63 07           COM +$07,X
18A2: BC 66 49        CMPX $6649
18A5: 2E 04           BGT $18AB
18A7: 19              DAA
18A8: 0B              ?????
18A9: 17 0A 01        LBSR $22AD
18AC: 02              ?????
18AD: 00 8F           NEG $8F
18AF: 02              ?????
18B0: 02              ?????
18B1: 00 96           NEG $96
18B3: 03 02           COM $02
18B5: 00 92           NEG $92
18B7: 04 08           LSR $08
18B9: 0E 06           JMP $06
18BB: 14              ?????
18BC: 1C 11           ANDCC #$11
18BE: 8D 00           BSR $18C0
18C0: 94 92           ANDa $92
18C2: 38              ?????
18C3: 00 03           NEG $03
18C5: 24 04           BCC $18CB
18C7: 22 5F           BHI $1928
18C9: BE 1B 16        LDX $1B16
18CC: 9A BD           ORa $BD
18CE: 83 61 23        SUBd #$6123
18D1: D1 13           CMPb $13
18D3: 54              LSRb
18D4: 55              ?????
18D5: 72              ?????
18D6: 3A              ABX
18D7: 15              ?????
18D8: 8D 7B           BSR $1955
18DA: 23 15           BLS $18F1
18DC: 16 BA F7        LBRA $D3D6
18DF: 17 16 BA        LBSR $2F9C
18E2: 90 14           SUBa $14
18E4: 15              ?????
18E5: 58              ASLb
18E6: 36 A1           PSHU ,PC,Y,CC
18E8: 9B 76           ADDa $76
18EA: 04 0F           LSR $0F
18EC: 0B              ?????
18ED: 0D 0A           TST $0A
18EF: 03 02           COM $02
18F1: 00 93           NEG $93
18F3: 02              ?????
18F4: 02              ?????
18F5: 00 97           NEG $97
18F7: 04 02           LSR $02
18F9: 00 91           NEG $91
18FB: 93 81           SUBd $81
18FD: 0F 00           CLR $00
18FF: 03 2B           COM $2B
1901: 04 29           LSR $29
1903: 5F              CLRb
1904: BE 17 16        LDX $1716
1907: CF              ?????
1908: 99 9B           ADCa $9B
190A: 8F              ?????
190B: 5F              CLRb
190C: BE 5B B1        LDX $5BB1
190F: 4B              ?????
1910: 7B              ?????
1911: 59              ROLb
1912: 45              ?????
1913: 66 62           ROR +$02,S
1915: 3A              ABX
1916: 15              ?????
1917: 73 7B 8E        COM $7B8E
191A: 48              ASLa
191B: 90 14           SUBa $14
191D: C2 16           SBCb #$16
191F: 93 61           SUBd $61
1921: AB 98 6B        ADDa [+$6B,X]
1924: BF 5F BE        STX $5FBE
1927: 61              ?????
1928: 17 82 C6        LBSR $9BF1
192B: 2E 04           BGT $1931
192D: 80 DE           SUBa #$DE
192F: 0B              ?????
1930: 80 DB           SUBa #$DB
1932: 0A 02           DEC $02
1934: 80 D3           SUBa #$D3
1936: 0E 80           JMP $80
1938: D0 0D           SUBb $0D
193A: 18              ?????
193B: 01              ?????
193C: 1A 04           ORCC #$04
193E: 14              ?????
193F: 5F              CLRb
1940: BE 09 15        LDX $0915
1943: D9 6A           ADCb $6A
1945: 46              RORa
1946: 7A 99 16        DEC $9916
1949: 0E BC           JMP $BC
194B: 73 62 C7        COM $62C7
194E: DE DB           LDU $DB
1950: 16 C9 B9        LBRA $E30C
1953: 0D 80           TST $80
1955: B3 0E 80        SUBD $0E80
1958: B0 0D 19        SUBa $0D19
195B: 20 38           BRA $1995
195D: 04 15           LSR $15
195F: C7              ?????
1960: DE 9B           LDU $9B
1962: 15              ?????
1963: 5B              ?????
1964: CA 07           ORb #$07
1966: 68 33           LSL -$0D,Y
1968: 98 85           EORa $85
196A: A6 44           LDa +$04,U
196C: B8 DB 8B        EORa $DB8B
196F: 55              ?????
1970: 62              ?????
1971: DF 48           STU $48
1973: 21 0D           BRN $1982
1975: 80 92           SUBa #$92
1977: 20 13           BRA $198C
1979: 04 26           LSR $26
197B: 4B              ?????
197C: 49              ROLa
197D: C7              ?????
197E: DE 3F           LDU $3F
1980: 16 CF 49        LBRA $E8CC
1983: 15              ?????
1984: EE CF 62 CE     LDU $62CE,U
1988: B0 87 15        SUBa $8715
198B: 2E 49           BGT $19D6
198D: D2 B5           SBCb $B5
198F: E6 A0           LDb ,Y+
1991: F3 5F 36        ADDD $5F36
1994: A1 46           CMPa +$06,U
1996: B8 49 5E        EORa $495E
1999: C4 B0           ANDb #$B0
199B: 51              ?????
199C: 18              ?????
199D: 43              COMa
199E: C2 33           SBCb #$33
19A0: 98 0E           EORa $0E
19A2: 15              ?????
19A3: 14              ?????
19A4: 0D 05           TST $05
19A6: 01              ?????
19A7: 3C 17           CWAI #17
19A9: 3C 99           CWAI #99
19AB: 04 0B           LSR $0B
19AD: 5F              CLRb
19AE: BE FF 14        LDX $FF14
19B1: F3 46 79        ADDD $4679
19B4: 5B              ?????
19B5: 90 14           SUBa $14
19B7: 44              LSRa
19B8: 04 40           LSR $40
19BA: 6C BE           INC ??
19BC: 6B              ?????
19BD: A1 C7           CMPa ??
19BF: DE D0           LDU $D0
19C1: 15              ?????
19C2: 7B              ?????
19C3: 14              ?????
19C4: E3 B8 F3        ADDD [-$ D,Y]
19C7: 8C 09 BA        CMPX #$09BA
19CA: C9 B0           ADCb #$B0
19CC: 55              ?????
19CD: 5E              ?????
19CE: E6 72           LDb -$0E,S
19D0: AF 14           STX -$0C,X
19D2: 90 73           SUBa $73
19D4: 16 58 DB        LBRA $72B2
19D7: 72              ?????
19D8: EB 4F           ADDb +$0F,U
19DA: C3 8B CF        ADDd #$8BCF
19DD: 98 51           EORa $51
19DF: 18              ?????
19E0: 4A              DECa
19E1: C2 94           SBCb #$94
19E3: 5F              CLRb
19E4: 82 17           SBCa #$17
19E6: 5B              ?????
19E7: 61              ?????
19E8: 75              ?????
19E9: 8D D6           BSR $19C1
19EB: 83 DB 72        SUBd #$DB72
19EE: 81 5B           CMPa #$5B
19F0: 83 AF 33        SUBd #$AF33
19F3: 98 2B           EORa $2B
19F5: 6E F3           JMP [,--S]
19F7: 49              ROLa
19F8: DB E0           ADDb $E0
19FA: 1C 40           ANDCC #$40
19FC: 0E 03           JMP $03
19FE: 15              ?????
19FF: 02              ?????
1A00: 29 0E           BVS $1A10
1A02: 03 15           COM $15
1A04: 01              ?????
1A05: 2A 17           BPL $1A1E
1A07: 13              SYNC
1A08: 99 04           ADCa $04
1A0A: 02              ?????
1A0B: 00 92           NEG $92
1A0D: 94 13           ANDa $13
1A0F: 00 03           NEG $03
1A11: 01              ?????
1A12: 81 04           CMPa #$04
1A14: 0D 0B           TST $0B
1A16: 0B              ?????
1A17: 0A 03           DEC $03
1A19: 08 0E           LSL $0E
1A1B: 06 14           ROR $14
1A1D: 1C 12           ANDCC #$12
1A1F: 8D 00           BSR $1A21
1A21: 91 95           CMPa $95
1A23: 29 00           BVS $1A25
1A25: 03 1D           COM $1D
1A27: 04 1B           LSR $1B
1A29: 5F              CLRb
1A2A: BE B8 16        LDX $B816
1A2D: 05              ?????
1A2E: 67 DB           ASR [D,U]
1A30: 63 5F           COM -$01,U
1A32: BE 5B B1        LDX $5BB1
1A35: 4B              ?????
1A36: 7B              ?????
1A37: 55              ?????
1A38: 45              ?????
1A39: 91 7A           CMPa $7A
1A3B: DB 8B           ADDb $8B
1A3D: 23 63           BLS $1AA2
1A3F: 07 BC           ASR $BC
1A41: 66 49           ROR +$09,U
1A43: 2E 04           BGT $1A49
1A45: 07 0B           ASR $0B
1A47: 05              ?????
1A48: 0A 03           DEC $03
1A4A: 02              ?????
1A4B: 00 81           NEG $81
1A4D: 96 46           LDa $46
1A4F: 00 03           NEG $03
1A51: 32 04           LEAS +$04,X
1A53: 30 5F           LEAX -$01,U
1A55: BE 61 17        LDX $6117
1A58: 82 C6           SBCa #$C6
1A5A: 30 15           LEAX -$0B,X
1A5C: 11 58           ?????
1A5E: 96 64           LDa $64
1A60: DB 72           ADDb $72
1A62: 04 9A           LSR $9A
1A64: 75              ?????
1A65: BE 47 B9        LDX $47B9
1A68: 53              COMb
1A69: BE 4E 72        LDX $4E72
1A6C: B3 8E DB        SUBD $8EDB
1A6F: E0 5F           SUBb -$01,U
1A71: BE 5B B1        LDX $5BB1
1A74: 2F 49           BLE $1ABF
1A76: 23 15           BLS $1A8D
1A78: F3 B9 8E        ADDD $B98E
1A7B: 48              ASLa
1A7C: F7 17 F3        STb $17F3
1A7F: B9 23 63        ADCa $2363
1A82: 2F C0           BLE $1A44
1A84: 04 0F           LSR $0F
1A86: 0B              ?????
1A87: 0D 0A           TST $0A
1A89: 01              ?????
1A8A: 02              ?????
1A8B: 00 91           NEG $91
1A8D: 04 02           LSR $02
1A8F: 00 98           NEG $98
1A91: 03 02           COM $02
1A93: 00 97           NEG $97
1A95: 97 32           STa $32
1A97: 00 03           NEG $03
1A99: 22 04           BHI $1A9F
1A9B: 20 5F           BRA $1AFC
1A9D: BE 03 15        LDX $0315
1AA0: 10 99           ?????
1AA2: D4 6A           ANDb$6A
1AA4: 3F              SWI1
1AA5: A0 56           SUBa -$0A,U
1AA7: F4 F4 72        ANDb $F472
1AAA: 43              COMa
1AAB: 5E              ?????
1AAC: 5B              ?????
1AAD: B1 23 63        CMPa $2363
1AB0: 0B              ?????
1AB1: C0 04           SUBb #$04
1AB3: 9A 53           ORa $53
1AB5: BE 8E 48        LDX $8E48
1AB8: F7 17 17        STb $1717
1ABB: BA 04 0B        ORa $040B
1ABE: 0B              ?????
1ABF: 09 0A           ROL $0A
1AC1: 01              ?????
1AC2: 02              ?????
1AC3: 00 92           NEG $92
1AC5: 04 02           LSR $02
1AC7: 00 96           NEG $96
1AC9: 98 37           EORa $37
1ACB: 00 03           NEG $03
1ACD: 2B 04           BMI $1AD3
1ACF: 29 5F           BVS $1B30
1AD1: BE 2F 17        LDX $2F17
1AD4: AF 55           STX -$0B,U
1AD6: 83 49 03        SUBd #$4903
1AD9: A0 01           SUBa +$01,X
1ADB: B3 DB 95        SUBD $DB95
1ADE: 5F              CLRb
1ADF: BE 5B B1        LDX $5BB1
1AE2: 4B              ?????
1AE3: 7B              ?????
1AE4: 16 A0 51        LBRA $BB38
1AE7: DB 5B           ADDb $5B
1AE9: 98 23           EORa $23
1AEB: 63 19           COM -$07,X
1AED: BC 85 73        CMPX $8573
1AF0: 0E 71           JMP $71
1AF2: 86 5F           LDa #$5F
1AF4: C7              ?????
1AF5: B5 66 49        BITa $6649
1AF8: 2E 04           BGT $1AFE
1AFA: 07 0B           ASR $0B
1AFC: 05              ?????
1AFD: 0A 03           DEC $03
1AFF: 02              ?????
1B00: 00 96           NEG $96
1B02: 99 3E           ADCa $3E
1B04: 00 03           NEG $03
1B06: 0E 04           JMP $04
1B08: 0C 5F           INC $5F
1B0A: BE 66 17        LDX $6617
1B0D: AB A0           ADDa ,Y+
1B0F: 9B 6C           ADDa $6C
1B11: 1F B8           TFR DP,A
1B13: 9B 5D           ADDa $5D
1B15: 04 2B           LSR $2B
1B17: 0B              ?????
1B18: 29 0A           BVS $1B24
1B1A: 01              ?????
1B1B: 26 0E           BNE $1B2B
1B1D: 24 14           BCC $1B33
1B1F: 1C 40           ANDCC #$40
1B21: 8D 0D           BSR $1B30
1B23: 1E 04           EXG D,S
1B25: 1B              ?????
1B26: C7              ?????
1B27: DE 3A           LDU $3A
1B29: 15              ?????
1B2A: 73 7B 5F        COM $7B5F
1B2D: BE 5A 17        LDX $5A17
1B30: F3 5F 8E        ADDD $5F8E
1B33: 48              ASLa
1B34: 35 15           PULS ,CC,B,X
1B36: 12              NOP 
1B37: 53              COMb
1B38: 56              RORb
1B39: 5E              ?????
1B3A: C8 9C           EORb #$9C
1B3C: 67 B1           ASR [,Y++]
1B3E: 7F 5B 21        CLR $5B21
1B41: 24 00           BCC $1B43
1B43: 93 DF           SUBd $DF
1B45: 0B              ?????
1B46: 12              NOP 
1B47: 85 00           BITa #$00
1B49: 88 03           EORa #$03
1B4B: 01              ?????
1B4C: 84 01           ANDa #$01
1B4E: 01              ?????
1B4F: 14              ?????
1B50: 02              ?????
1B51: 07 AF           ASR $AF
1B53: 6E 83           JMP ,--X
1B55: 61              ?????
1B56: 81 5B           CMPa #$5B
1B58: 52              ?????
1B59: 0B              ?????
1B5A: 12              NOP 
1B5B: 84 00           ANDa #$00
1B5D: 8A 03           ORa #$03
1B5F: 01              ?????
1B60: 86 01           LDa #$01
1B62: 01              ?????
1B63: 14              ?????
1B64: 02              ?????
1B65: 07 AF           ASR $AF
1B67: 6E 83           JMP ,--X
1B69: 61              ?????
1B6A: 81 5B           CMPa #$5B
1B6C: 52              ?????
1B6D: 0B              ?????
1B6E: 11 84           ?????
1B70: 00 8B           NEG $8B
1B72: 03 01           COM $01
1B74: 87              ?????
1B75: 01              ?????
1B76: 01              ?????
1B77: 13              SYNC
1B78: 02              ?????
1B79: 06 66           ROR $66
1B7B: B1 09 15        CMPa $0915
1B7E: A3 A0           SUBD ,Y+
1B80: 0B              ?????
1B81: 11 86           ?????
1B83: 00 88           NEG $88
1B85: 03 01           COM $01
1B87: 85 01           BITa #$01
1B89: 01              ?????
1B8A: 13              SYNC
1B8B: 02              ?????
1B8C: 06 66           ROR $66
1B8E: B1 09 15        CMPa $0915
1B91: A3 A0           SUBD ,Y+
1B93: 0B              ?????
1B94: 12              NOP 
1B95: 88 00           EORa #$00
1B97: 8A 03           ORa #$03
1B99: 01              ?????
1B9A: 84 01           ANDa #$01
1B9C: 01              ?????
1B9D: 14              ?????
1B9E: 02              ?????
1B9F: 07 AF           ASR $AF
1BA1: 6E 83           JMP ,--X
1BA3: 61              ?????
1BA4: 81 5B           CMPa #$5B
1BA6: 52              ?????
1BA7: 0B              ?????
1BA8: 12              NOP 
1BA9: 87              ?????
1BAA: 00 88           NEG $88
1BAC: 03 01           COM $01
1BAE: 86 01           LDa #$01
1BB0: 01              ?????
1BB1: 14              ?????
1BB2: 02              ?????
1BB3: 07 AF           ASR $AF
1BB5: 6E 83           JMP ,--X
1BB7: 61              ?????
1BB8: 81 5B           CMPa #$5B
1BBA: 52              ?????
1BBB: 0B              ?????
1BBC: 11 87           ?????
1BBE: 00 8B           NEG $8B
1BC0: 03 01           COM $01
1BC2: 87              ?????
1BC3: 01              ?????
1BC4: 01              ?????
1BC5: 13              SYNC
1BC6: 02              ?????
1BC7: 06 66           ROR $66
1BC9: B1 09 15        CMPa $0915
1BCC: A3 A0           SUBD ,Y+
1BCE: 0B              ?????
1BCF: 11 89           ?????
1BD1: 00 88           NEG $88
1BD3: 03 01           COM $01
1BD5: 85 01           BITa #$01
1BD7: 01              ?????
1BD8: 13              SYNC
1BD9: 02              ?????
1BDA: 06 66           ROR $66
1BDC: B1 09 15        CMPa $0915
1BDF: A3 A0           SUBD ,Y+
1BE1: 0B              ?????
1BE2: 12              NOP 
1BE3: 8B 00           ADDa #$00
1BE5: 88 03           EORa #$03
1BE7: 01              ?????
1BE8: 84 01           ANDa #$01
1BEA: 01              ?????
1BEB: 14              ?????
1BEC: 02              ?????
1BED: 07 AF           ASR $AF
1BEF: 6E 83           JMP ,--X
1BF1: 61              ?????
1BF2: 81 5B           CMPa #$5B
1BF4: 52              ?????
1BF5: 0B              ?????
1BF6: 12              NOP 
1BF7: 8A 00           ORa #$00
1BF9: 8A 03           ORa #$03
1BFB: 01              ?????
1BFC: 86 01           LDa #$01
1BFE: 01              ?????
1BFF: 14              ?????
1C00: 02              ?????
1C01: 07 AF           ASR $AF
1C03: 6E 83           JMP ,--X
1C05: 61              ?????
1C06: 81 5B           CMPa #$5B
1C08: 52              ?????
1C09: 0B              ?????
1C0A: 11 8A           ?????
1C0C: 00 8B           NEG $8B
1C0E: 03 01           COM $01
1C10: 87              ?????
1C11: 01              ?????
1C12: 01              ?????
1C13: 13              SYNC
1C14: 02              ?????
1C15: 06 66           ROR $66
1C17: B1 09 15        CMPa $0915
1C1A: A3 A0           SUBD ,Y+
1C1C: 0B              ?????
1C1D: 12              NOP 
1C1E: 8D 00           BSR $1C20
1C20: 88 03           EORa #$03
1C22: 01              ?????
1C23: 84 01           ANDa #$01
1C25: 01              ?????
1C26: 14              ?????
1C27: 02              ?????
1C28: 07 AF           ASR $AF
1C2A: 6E 83           JMP ,--X
1C2C: 61              ?????
1C2D: 81 5B           CMPa #$5B
1C2F: 52              ?????
1C30: 0B              ?????
1C31: 12              NOP 
1C32: 8C 00 8A        CMPX #$008A
1C35: 03 01           COM $01
1C37: 86 01           LDa #$01
1C39: 01              ?????
1C3A: 14              ?????
1C3B: 02              ?????
1C3C: 07 AF           ASR $AF
1C3E: 6E 83           JMP ,--X
1C40: 61              ?????
1C41: 81 5B           CMPa #$5B
1C43: 52              ?????
1C44: 0B              ?????
1C45: 11 8F           ?????
1C47: 00 88           NEG $88
1C49: 03 01           COM $01
1C4B: 85 01           BITa #$01
1C4D: 01              ?????
1C4E: 13              SYNC
1C4F: 02              ?????
1C50: 06 66           ROR $66
1C52: B1 09 15        CMPa $0915
1C55: A3 A0           SUBD ,Y+
1C57: 0B              ?????
1C58: 11 8F           ?????
1C5A: 00 8A           NEG $8A
1C5C: 02              ?????
1C5D: 06 8F           ROR $8F
1C5F: 4E              ?????
1C60: 46              RORa
1C61: 5E              ?????
1C62: 44              LSRa
1C63: A0 01           SUBa +$01,X
1C65: 01              ?????
1C66: 15              ?????
1C67: 03 01           COM $01
1C69: 88 0B           EORa #$0B
1C6B: 11 90           ?????
1C6D: 00 88           NEG $88
1C6F: 03 01           COM $01
1C71: 89 01           ADCa #$01
1C73: 01              ?????
1C74: 15              ?????
1C75: 02              ?????
1C76: 06 8F           ROR $8F
1C78: 4E              ?????
1C79: 46              RORa
1C7A: 5E              ?????
1C7B: 44              LSRa
1C7C: A0 0B           SUBa +$0B,X
1C7E: 11 91           ?????
1C80: 00 8A           NEG $8A
1C82: 03 01           COM $01
1C84: 89 01           ADCa #$01
1C86: 01              ?????
1C87: 15              ?????
1C88: 02              ?????
1C89: 06 8F           ROR $8F
1C8B: 4E              ?????
1C8C: 46              RORa
1C8D: 5E              ?????
1C8E: 44              LSRa
1C8F: A0 0B           SUBa +$0B,X
1C91: 11 94           ?????
1C93: 00 88           NEG $88
1C95: 03 01           COM $01
1C97: 88 01           EORa #$01
1C99: 01              ?????
1C9A: 15              ?????
1C9B: 02              ?????
1C9C: 06 8F           ROR $8F
1C9E: 4E              ?????
1C9F: 46              RORa
1CA0: 5E              ?????
1CA1: 44              LSRa
1CA2: A0 FF 42 88     SUBa [$4288]
1CA6: 00 80           NEG $80
1CA8: 08 06           LSL $06
1CAA: 0D 04           TST $04
1CAC: 03 13           COM $13
1CAE: 3A              ABX
1CAF: 9B 0A           ADDa $0A
1CB1: 31 0D           LEAY +$0D,X
1CB3: 2F 1F           BLE $1CD4
1CB5: 29 C7           BVS $1C7E
1CB7: DE DB           LDU $DB
1CB9: 16 CB B9        LBRA $E875
1CBC: 36 A1           PSHU ,PC,Y,CC
1CBE: B0 17 F4        SUBa $17F4
1CC1: 59              ROLb
1CC2: 82 17           SBCa #$17
1CC4: 73 49 55        COM $4955
1CC7: 8B 03           ADDa #$03
1CC9: BC 3B C0        CMPX $3BC0
1CCC: AF 54           STX -$0C,U
1CCE: 51              ?????
1CCF: 18              ?????
1CD0: 43              COMa
1CD1: C2 0D           SBCb #$0D
1CD3: D0 83           SUBb $83
1CD5: 61              ?????
1CD6: 83 7A C7        SUBd #$7AC7
1CD9: DE 85           LDU $85
1CDB: AF 46           STX +$06,U
1CDD: 61              ?????
1CDE: 2E 2C           BGT $1D0C
1CE0: 13              SYNC
1CE1: 19              DAA
1CE2: 88 09           EORa #$09
1CE4: 02              ?????
1CE5: 46              RORa
1CE6: 46              RORa
1CE7: 16 21 00        LBRA $3DEA
1CEA: 00 A0           NEG $A0
1CEC: 03 12           COM $12
1CEE: 04 10           LSR $10
1CF0: 5F              CLRb
1CF1: BE 5B B1        LDX $5BB1
1CF4: 4B              ?????
1CF5: 7B              ?????
1CF6: 54              LSRb
1CF7: 45              ?????
1CF8: F3 5F BB        ADDD $5FBB
1CFB: 85 9F           BITa #$9F
1CFD: 15              ?????
1CFE: 7F B1 01        CLR $B101
1D01: 01              ?????
1D02: 13              SYNC
1D03: 02              ?????
1D04: 05              ?????
1D05: 66 B1           ROR [,Y++]
1D07: 17 16 59        LBSR $3363
1D0A: 17 11 82        LBSR $2E8F
1D0D: 00 A0           NEG $A0
1D0F: 03 01           COM $01
1D11: 9D 07           JSR $07
1D13: 01              ?????
1D14: B0 02 06        SUBa $0206
1D17: 8F              ?????
1D18: 4E              ?????
1D19: 52              ?????
1D1A: 5E              ?????
1D1B: 46              RORa
1D1C: 7A 18 2C        DEC $182C
1D1F: 81 00           CMPa #$00
1D21: A0 03           SUBa +$03,X
1D23: 1D              SEX
1D24: 04 1B           LSR $1B
1D26: 5F              CLRb
1D27: BE 5B B1        LDX $5BB1
1D2A: 4B              ?????
1D2B: 7B              ?????
1D2C: 4E              ?????
1D2D: 45              ?????
1D2E: 11 A0           ?????
1D30: 9B 15           ADDa $15
1D32: 46              RORa
1D33: 98 59           EORa $59
1D35: 5E              ?????
1D36: 8E 7A 6B        LDX #$7A6B
1D39: A1 81           CMPa ,X++ 
1D3B: 74 CA 83        LSR $CA83
1D3E: 2F 62           BLE $1DA2
1D40: 2E 02           BGT $1D44
1D42: 08 50           LSL $50
1D44: D1 89           CMPb $89
1D46: 5B              ?????
1D47: A9 15           ADCa -$0B,X
1D49: 8B 9F           ADDa #$9F
1D4B: 19              DAA
1D4C: 80 9C           SUBa #$9C
1D4E: 82 00           SBCa #$00
1D50: 83 03 2A        SUBd #$032A
1D53: 04 28           LSR $28
1D55: 03 A0           COM $A0
1D57: 0F A0           CLR $A0
1D59: F3 17 F3        ADDD $17F3
1D5C: 8C 4B 7B        CMPX #$4B7B
1D5F: 45              ?????
1D60: 45              ?????
1D61: B3 46 76        SUBD $4676
1D64: 98 56           EORa $56
1D66: F4 DB 72        ANDb $DB72
1D69: 04 53           LSR $53
1D6B: 8F              ?????
1D6C: 7A 0A BC        DEC $0ABC
1D6F: 4B              ?????
1D70: 49              ROLa
1D71: 56              RORb
1D72: 45              ?????
1D73: A3 7A           SUBD -$06,S
1D75: A9 15           ADCa -$0B,X
1D77: DB 8B           ADDb $8B
1D79: 83 7A 97        SUBd #$7A97
1D7C: 7B              ?????
1D7D: 07 64           ASR $64
1D7F: 0E 62           JMP $62
1D81: 0D 23           TST $23
1D83: 0E 06           JMP $06
1D85: 0A 42           DEC $42
1D87: 0A 3A           DEC $3A
1D89: 0A 11           DEC $11
1D8B: 04 19           LSR $19
1D8D: C7              ?????
1D8E: DE D3           LDU $D3
1D90: 14              ?????
1D91: E6 96           LDb [A,X]
1D93: 57              ASRb
1D94: 17 5B 61        LBSR $78F8
1D97: 6B              ?????
1D98: BF 96 C5        STX $96C5
1D9B: 5D              TSTb
1D9C: 9E 82           LDX $82
1D9E: 17 45 5E        LBSR $62FF
1DA1: B3 46 76        SUBD $4676
1DA4: 98 2E           EORa $2E
1DA6: 0D 3B           TST $3B
1DA8: 0E 04           JMP $04
1DAA: 0A 10           DEC $10
1DAC: 0A 0B           DEC $0B
1DAE: 03 82           COM $82
1DB0: 3B              RTI
1DB1: 04 30           LSR $30
1DB3: 0C BA           INC $BA
1DB5: D0 47           SUBb $47
1DB7: 91 7A           CMPa $7A
1DB9: 89 17           ADCa #$17
1DBB: 57              ASRb
1DBC: 17 56 5E        LBSR $741D
1DBF: F9 74 7A        ADCb $747A
1DC2: C4 82           ANDb #$82
1DC4: 17 56 5E        LBSR $7425
1DC7: A3 7A           SUBD -$06,S
1DC9: A9 15           ADCa -$0B,X
1DCB: FE 8B 51        LDU $8B51
1DCE: 18              ?????
1DCF: 45              ?????
1DD0: C2 83           SBCb #$83
1DD2: 48              ASLa
1DD3: F5 81 0F        BITb $810F
1DD6: BC 17 48        CMPX $1748
1DD9: C7              ?????
1DDA: 16 03 BC        LBRA $2199
1DDD: 2F 17           BLE $1DF6
1DDF: 0D 58           TST $58
1DE1: 5F              CLRb
1DE2: 63 02           COM +$02,X
1DE4: 05              ?????
1DE5: 04 53           LSR $53
1DE7: 8F              ?????
1DE8: 7A 54 1A        DEC $541A
1DEB: 80 C9           SUBa #$C9
1DED: 92 00           SBCa $00
1DEF: 8A 03           ORa #$03
1DF1: 2E 04           BGT $1DF7
1DF3: 2C 83           BGE $1D78
1DF5: 7A 5F BE        DEC $5FBE
1DF8: 99 16           ADCa $16
1DFA: C2 B3           SBCb #$B3
1DFC: 95 5F           BITa $5F
1DFE: 05              ?????
1DFF: BC B8 A0        CMPX $B8A0
1E02: 23 62           BLS $1E66
1E04: C3 9E 5F        ADDd #$9E5F
1E07: BE 39 17        LDX $3917
1E0A: DB 9F           ADDb $9F
1E0C: 5F              CLRb
1E0D: BE 5B B1        LDX $5BB1
1E10: 4B              ?????
1E11: 7B              ?????
1E12: 4E              ?????
1E13: 45              ?????
1E14: 31 49           LEAY +$09,U
1E16: 54              LSRb
1E17: 5E              ?????
1E18: 5C              INCb
1E19: 60 77           NEG -$09,S
1E1B: 79 D6 B0        ROL $D6B0
1E1E: A3 A0           SUBD ,Y+
1E20: 06 3D           ROR $3D
1E22: 0D 3B           TST $3B
1E24: 0A 0F           DEC $0F
1E26: 1B              ?????
1E27: 0D 0C           TST $0C
1E29: 15              ?????
1E2A: 02              ?????
1E2B: A9 04           ADCa +$04,X
1E2D: 07 4B           ASR $4B
1E2F: 7B              ?????
1E30: C9 54           ADCb #$54
1E32: A6 B7           LDa ??
1E34: 2E A8           BGT $1DDE
1E36: 04 08           LSR $08
1E38: CE 65 0B        LDU #$650B
1E3B: 8E 36 A1        LDX #$36A1
1E3E: B8 16 A9        EORa $16A9
1E41: 04 1A           LSR $1A
1E43: 1E A0           EXG CC,D
1E45: D6 9C           LDb $9C
1E47: DB 72           ADDb $72
1E49: 89 67           ADCa #$67
1E4B: A3 A0           SUBD ,Y+
1E4D: 68 4D           LSL +$0D,U
1E4F: AF A0           STX ,Y+
1E51: C7              ?????
1E52: DE D3           LDU $D3
1E54: 14              ?????
1E55: 85 96           BITa #$96
1E57: 85 8D           BITa #$8D
1E59: 4B              ?????
1E5A: 5E              ?????
1E5B: 9B C1           ADDa $C1
1E5D: 1A 10           ORCC #$10
1E5F: 07 4B           ASR $4B
1E61: 0D 49           TST $49
1E63: 0A 11           DEC $11
1E65: 1A 15           ORCC #$15
1E67: 02              ?????
1E68: 03 18           COM $18
1E6A: 42              ?????
1E6B: 29 17           BVS $1E84
1E6D: 19              DAA
1E6E: 92 17           SBCa $17
1E70: 42              ?????
1E71: 00 04           NEG $04
1E73: 38              ?????
1E74: 1F D1           TFR ??,X
1E76: 9B 96           ADDa $96
1E78: 1B              ?????
1E79: A1 5F           CMPa -$01,U
1E7B: A0 96           SUBa [A,X]
1E7D: 96 DB           LDa $DB
1E7F: 72              ?????
1E80: 68 B1           LSL [,Y++]
1E82: 09 B2           ROL $B2
1E84: 2B 62           BMI $1EE8
1E86: 84 BF           ANDa #$BF
1E88: 15              ?????
1E89: EE E7           LDU ??
1E8B: 9F 9B           STX $9B
1E8D: 15              ?????
1E8E: BF 91 B7        STX $91B7
1E91: B1 8F AF        CMPa $8FAF
1E94: 96 5F           LDa $5F
1E96: 4B              ?????
1E97: 15              ?????
1E98: 0D 8D           TST $8D
1E9A: C7              ?????
1E9B: 16 11 BC        LBRA $305A
1E9E: 8B 64           ADDa #$64
1EA0: 11 BC C9 9A     CMPS $C99A
1EA4: 82 17           SBCa #$17
1EA6: 48              ASLa
1EA7: 5E              ?????
1EA8: 81 8D           CMPa #$8D
1EAA: 1B              ?????
1EAB: B5 02 08        BITa $0208
1EAE: 68 B1           LSL [,Y++]
1EB0: 09 B2           ROL $B2
1EB2: 2B 62           BMI $1F16
1EB4: 84 BF           ANDa #$BF
1EB6: 1B              ?????
1EB7: 6E 00           JMP +$00,X
1EB9: 00 A0           NEG $A0
1EBB: 03 19           COM $19
1EBD: 04 17           LSR $17
1EBF: 5F              CLRb
1EC0: BE 5B B1        LDX $5BB1
1EC3: 4B              ?????
1EC4: 7B              ?????
1EC5: 3F              SWI1
1EC6: B9 4A 5E        ADCa $4A5E
1EC9: 64 48           LSR +$08,U
1ECB: 31 C6           LEAY A,U
1ECD: 23 62           BLS $1F31
1ECF: 23 92           BLS $1E63
1ED1: 0A BC           DEC $BC
1ED3: 2F 62           BLE $1F37
1ED5: 2E 06           BGT $1EDD
1ED7: 16 0D 14        LBRA $2BEE
1EDA: 0A 0F           DEC $0F
1EDC: 0E 10           JMP $10
1EDE: 0D 06           TST $06
1EE0: 08 15           LSL $15
1EE2: 17 15 19        LBSR $33FE
1EE5: A0 0D           SUBa +$0D,X
1EE7: 06 08           ROR $08
1EE9: 39              RTS
1EEA: 17 39 19        LBSR $5806
1EED: A0 07           SUBa +$07,X
1EEF: 2A 0D           BPL $1EFE
1EF1: 28 0A           BVC $1EFD
1EF3: 15              ?????
1EF4: 04 21           LSR $21
1EF6: F4 4F AB        ANDb $4FAB
1EF9: A2 AB           SBCa D,Y
1EFB: AD DB           JSR [D,U]
1EFD: BD 41 6E        JSR $416E
1F00: 73 5D F6        COM $5DF6
1F03: 4F              CLRa
1F04: 7B              ?????
1F05: 14              ?????
1F06: 96 8C           LDa $8C
1F08: FF BE 2B        STU $BE2B
1F0B: 17 5B B1        LBSR $7ABF
1F0E: 04 68           LSR $68
1F10: 7B              ?????
1F11: 16 7B 17        LBRA $9A2B
1F14: FF B9 2E        STU $B92E
1F17: 17 19 00        LBSR $381A
1F1A: 02              ?????
1F1B: 0A 4F           DEC $4F
1F1D: 72              ?????
1F1E: F4 4F B4        ANDb $4FB4
1F21: 6C 67           INC +$07,S
1F23: 16 73 49        LBRA $926F
1F26: 08 81           LSL $81
1F28: 03 93           COM $93
1F2A: 00 90           NEG $90
1F2C: 03 33           COM $33
1F2E: 04 31           LSR $31
1F30: 58              ASLb
1F31: 45              ?????
1F32: DB 78           ADDb $78
1F34: 35 A1           PULS ,CC,Y,PC
1F36: 87              ?????
1F37: 15              ?????
1F38: 2E 49           BGT $1F83
1F3A: 09 15           ROL $15
1F3C: CB 6A           ADDb #$6A
1F3E: C5 B5           BITb #$B5
1F40: 4B              ?????
1F41: 72              ?????
1F42: 66 98 89        ROR [-$77,X]
1F45: 17 82 17        LBSR $A15F
1F48: 55              ?????
1F49: 5E              ?????
1F4A: 36 A1           PSHU ,PC,Y,CC
1F4C: 19              DAA
1F4D: 71              ?????
1F4E: 46              RORa
1F4F: 48              ASLa
1F50: B6 14 5D        LDa $145D
1F53: 9E 91           LDX $91
1F55: 7A 82 17        DEC $8217
1F58: 55              ?????
1F59: 5E              ?????
1F5A: 36 A1           PSHU ,PC,Y,CC
1F5C: 07 71           ASR $71
1F5E: 96 D7           LDa $D7
1F60: 2E 07           BGT $1F69
1F62: 01              ?????
1F63: A1 06           CMPa +$06,X
1F65: 01              ?????
1F66: A1 0A           CMPa +$0A,X
1F68: 1C 0D           ANDCC #$0D
1F6A: 1A 1F           ORCC #$1F
1F6C: 15              ?????
1F6D: C7              ?????
1F6E: DE 4F           LDU $4F
1F70: 24 63           BCC $1FD5
1F72: 16 C9 97        LBRA $E90C
1F75: F3 5F 6B        ADDD $5F6B
1F78: BF 4E 86        STX $4E86
1F7B: 16 8A DB        LBRA $AA59
1F7E: 72              ?????
1F7F: 79 5B 2E        ROL $5B2E
1F82: 1E 1A           EXG X,CC
1F84: 3C 08           CWAI #08
1F86: 80 94           SUBa #$94
1F88: 0E 80           JMP $80
1F8A: 91 0D           CMPa $0D
1F8C: 7D 0A 09        TST $0A09
1F8F: 1C 13           ANDCC #$13
1F91: 0B              ?????
1F92: 77 05 55        ASR $0555
1F95: 22 0D           BHI $1FA4
1F97: 20 1F           BRA $1FB8
1F99: 1C 5F           ANDCC #$5F
1F9B: BE 09 15        LDX $0915
1F9E: D6 6A           LDb $6A
1FA0: 94 5F           ANDa $5F
1FA2: C3 B5 1B        ADDd #$B51B
1FA5: BC 34 A1        CMPX $34A1
1FA8: 3F              SWI1
1FA9: 16 C3 6A        LBRA $E316
1FAC: 33 98 EB        LEAU [-$15,X]
1FAF: 5B              ?????
1FB0: CB D2           ADDb #$D2
1FB2: 89 4E           ADCa #$4E
1FB4: 71              ?????
1FB5: 9E 1D           LDX $1D
1FB7: 06 AF           ROR $AF
1FB9: 26 0D           BNE $1FC8
1FBB: 24 1F           BCC $1FDC
1FBD: 20 5F           BRA $201E
1FBF: BE 09 15        LDX $0915
1FC2: C4 6A           ANDb #$6A
1FC4: 7F 7B DB        CLR $7BDB
1FC7: B5 34 A1        BITa $34A1
1FCA: 94 14           ANDa $14
1FCC: 43              COMa
1FCD: 90 33           SUBa $33
1FCF: 98 C7           EORa $C7
1FD1: DE E4           LDU $E4
1FD3: 14              ?????
1FD4: 91 7A           CMPa $7A
1FD6: 59              ROLb
1FD7: 5E              ?????
1FD8: 82 7B           SBCa #$7B
1FDA: DB 16           ADDb $16
1FDC: 81 7A           CMPa #$7A
1FDE: 1D              SEX
1FDF: 07 FF           ASR $FF
1FE1: 28 1F           BVC $2002
1FE3: 26 5F           BNE $2044
1FE5: BE 09 15        LDX $0915
1FE8: CE 6A 91        LDU #$6A91
1FEB: C5 4B           BITb #$4B
1FED: 62              ?????
1FEE: 04 68           LSR $68
1FF0: 51              ?????
1FF1: 18              ?????
1FF2: 23 C6           BLS $1FBA
1FF4: 65              ?????
1FF5: 98 33           EORa $33
1FF7: 89 F6           ADCa #$F6
1FF9: 4F              CLRa
1FFA: 51              ?????
1FFB: 18              ?????
1FFC: 52              ?????
1FFD: C2 46           SBCb #$46
1FFF: C5 AB           BITb #$AB
2001: 14              ?????
2002: 8B 54           ADDa #$54
2004: 83 7A 8F        SUBd #$7A8F
2007: BE EB 5D        LDX $EB5D
200A: 1F 10           TFR X,D
200C: 41              ?????
200D: 1E C3           EXG ??,U
200F: 9E B9           LDX $B9
2011: 6E B3           JMP [,--Y]
2013: D1 41           CMPb $41
2015: D2 99           SBCb $99
2017: 64 38           LSR -$08,Y
2019: A0 E3           SUBa ,--S
201B: 06 09           ROR $09
201D: 02              ?????
201E: 46              RORa
201F: 46              RORa
2020: 02              ?????
2021: 0A 5F           DEC $5F
2023: BE D3 17        LDX $D317
2026: 51              ?????
2027: 54              LSRb
2028: 4B              ?????
2029: C6 79           LDb #$79
202B: 5B              ?????
202C: 16 24 8E        LBRA $44BD
202F: 00 A0           NEG $A0
2031: 03 14           COM $14
2033: 04 12           LSR $12
2035: 5F              CLRb
2036: BE 5B B1        LDX $5BB1
2039: 4B              ?????
203A: 7B              ?????
203B: 49              ROLa
203C: 45              ?????
203D: 67 B1           ASR [,Y++]
203F: 8D 96           BSR $1FD7
2041: 3B              RTI
2042: 63 F4           COM [,S]
2044: 72              ?????
2045: DB 63           ADDb $63
2047: 01              ?????
2048: 01              ?????
2049: 14              ?????
204A: 02              ?????
204B: 06 AF           ROR $AF
204D: 6E 83           JMP ,--X
204F: 61              ?????
2050: BB 85 03        ADDa $8503
2053: 81 60           CMPa #$60
2055: 00 00           NEG $00
2057: 90 03           SUBa $03
2059: 18              ?????
205A: 04 16           LSR $16
205C: DB B0           ADDb $B0
205E: 57              ASRb
205F: 17 75 61        LBSR $95C3
2062: 89 17           ADCa #$17
2064: AF 14           STX -$0C,X
2066: 3B              RTI
2067: 15              ?????
2068: D0 60           SUBb $60
206A: D6 6A           LDb $6A
206C: DB 72           ADDb $72
206E: 0E D0           JMP $D0
2070: 2F 8E           BLE $2000
2072: 09 02           ROL $02
2074: 46              RORa
2075: 46              RORa
2076: 0B              ?????
2077: 81 2D           CMPa #$2D
2079: 0E 81           JMP $81
207B: 2A 0D           BPL $208A
207D: 80 DF           SUBa #$DF
207F: 0E 0A           JMP $0A
2081: 0A 01           DEC $01
2083: 0A 02           DEC $02
2085: 0A 03           DEC $03
2087: 0A 04           DEC $04
2089: 0A 0A           DEC $0A
208B: 1F 0F           TFR D,??
208D: DB B0           ADDb $B0
208F: 2F 17           BLE $20A8
2091: 84 A6           ANDa #$A6
2093: 0B              ?????
2094: C0 DB           SUBb #$DB
2096: 72              ?????
2097: 10 53           ?????
2099: 57              ASRb
209A: 17 45 1C        LBSR $65B9
209D: 38              ?????
209E: 10 2C 38 0E     LBGE $58B0
20A2: 80 B8           SUBa #$B8
20A4: 0D 33           TST $33
20A6: 01              ?????
20A7: 3D              MUL
20A8: 1F 2E           TFR Y,??
20AA: 55              ?????
20AB: 45              ?????
20AC: E4 5F           ANDb -$01,U
20AE: 73 62 81        COM $6281
20B1: 5B              ?????
20B2: 8A AF           ORa #$AF
20B4: 2F 62           BLE $2118
20B6: 19              DAA
20B7: EE 85           LDU B,X
20B9: 73 0F 71        COM $0F71
20BC: 3B              RTI
20BD: 4A              DECa
20BE: E3 8B           ADDD D,X
20C0: 16 58 C7        LBRA $798A
20C3: 9C 53           CMPX $53
20C5: B7 FF A4        STa $FFA4
20C8: AF 14           STX -$0C,X
20CA: 46              RORa
20CB: B8 4B 62        EORa $4B62
20CE: 5B              ?????
20CF: BE 73 C1        LDX $73C1
20D2: 5F              CLRb
20D3: BE 5B B1        LDX $5BB1
20D6: 4B              ?????
20D7: 7B              ?????
20D8: 0C 0D           INC $0D
20DA: 3D              MUL
20DB: 03 00           COM $00
20DD: 22 03           BHI $20E2
20DF: 88 1C           EORa #$1C
20E1: 1F 34           TFR U,S
20E3: 5B              ?????
20E4: BE 04 BC        LDX $04BC
20E7: 51              ?????
20E8: 63 33           COM -$0D,Y
20EA: 98 5F           EORa $5F
20EC: BE 99 16        LDX $9916
20EF: C2 B3           SBCb #$B3
20F1: F3 17 F3        ADDD $17F3
20F4: 8C 4B 7B        CMPX #$4B7B
20F7: 52              ?????
20F8: 45              ?????
20F9: E5 A0           BITb ,Y+
20FB: B6 78 47        LDa $7847
20FE: 5E              ?????
20FF: 53              COMb
2100: B7 DB A4        STa $DBA4
2103: 07 B3           ASR $B3
2105: FF BD AF        STU $BDAF
2108: 14              ?????
2109: 46              RORa
210A: B8 4B 62        EORa $4B62
210D: 5B              ?????
210E: BE 73 C1        LDX $73C1
2111: 5F              CLRb
2112: BE 5B B1        LDX $5BB1
2115: 4B              ?????
2116: 7B              ?????
2117: 0C 0D           INC $0D
2119: 06 0A           ROR $0A
211B: 03 21           COM $21
211D: 03 00           COM $00
211F: 00 0D           NEG $0D
2121: 06 0A           ROR $0A
2123: 04 21           LSR $21
2125: 04 00           LSR $00
2127: 00 0D           NEG $0D
2129: 06 0A           ROR $0A
212B: 01              ?????
212C: 21 01           BRN $212F
212E: 00 00           NEG $00
2130: 0D 06           TST $06
2132: 0A 02           DEC $02
2134: 21 02           BRN $2138
2136: 00 00           NEG $00
2138: 1F 22           TFR Y,Y
213A: 06 9A           ROR $9A
213C: 90 73           SUBa $73
213E: 5B              ?????
213F: 70 B7 1C        NEG $B71C
2142: F3 B9 5B        ADDD $B95B
2145: 4D              TSTa
2146: 3F              SWI1
2147: B9 4E 5E        ADCa $4E5E
214A: 86 5F           LDa #$5F
214C: C3 EA 66        ADDd #$EA66
214F: 98 F3           EORa $F3
2151: 17 0D 8D        LBSR $2EE1
2154: E3 06           ADDD +$06,X
2156: DB 72           ADDb $72
2158: 1B              ?????
2159: B7 5B BB        STa $5BBB
215C: 2C 1C           BGE $217A
215E: 0D 45           TST $45
2160: 0E 06           JMP $06
2162: 0A 11           DEC $11
2164: 0A 42           DEC $42
2166: 0A 09           DEC $09
2168: 1F 3B           TFR U,DP
216A: DB B0           ADDb $B0
216C: 63 16           COM -$0A,X
216E: B5 85 7B        BITa $857B
2171: 14              ?????
2172: 67 66           ASR +$06,S
2174: 7F 4E 96        CLR $4E96
2177: 14              ?????
2178: EF BD 33 A7     STU [$33A7,PC]
217C: 8E 48 82        LDX #$4882
217F: 17 83 61        LBSR $A4E3
2182: EB 5B           ADDb -$05,U
2184: CB D2           ADDb #$D2
2186: C5 4C           BITb #$4C
2188: 5B              ?????
2189: 89 A1           ADCa #$A1
218B: 1D              SEX
218C: 83 B3 0B        SUBd #$B30B
218F: EE 4F           LDU +$0F,U
2191: 24 AF           BCC $2142
2193: 14              ?????
2194: 83 61 D6        SUBd #$61D6
2197: B0 F4 72        SUBa $F472
219A: 90 14           SUBa $14
219C: 6B              ?????
219D: 61              ?????
219E: CE 51 7F        LDU #$517F
21A1: 49              ROLa
21A2: F9 8E 22        ADCb $8E22
21A5: 9A 08           ORa $08
21A7: 06 0D           ROR $0D
21A9: 04 9C           LSR $9C
21AB: 1C 1C           ANDCC #$1C
21AD: 9E 07           LDX $07
21AF: 01              ?????
21B0: AB 02           ADDa +$02,X
21B2: 02              ?????
21B3: DB B0           ADDb $B0
21B5: 03 80           COM $80
21B7: AE 00           LDX +$00,X
21B9: 00 90           NEG $90
21BB: 03 80           COM $80
21BD: A8 0D           EORa +$0D,X
21BF: 80 A5           SUBa #$A5
21C1: 04 80           LSR $80
21C3: 9F 4F           STX $4F
21C5: 45              ?????
21C6: 83 48 83        SUBd #$4883
21C9: 7A 94 5A        DEC $945A
21CC: FB C0 4F        ADDb $C04F
21CF: A1 CE           CMPa ??
21D1: B0 0B 8E        SUBa $0B8E
21D4: 8E 48 F7        LDX #$48F7
21D7: 17 33 49        LBSR $5523
21DA: AB 98 39        ADDa [+$39,X]
21DD: 6E BF 6D C3     JMP [$6DC3]
21E1: B5 AC A6        BITa $ACA6
21E4: 05              ?????
21E5: 9E F5           LDX $F5
21E7: 72              ?????
21E8: 51              ?????
21E9: 18              ?????
21EA: 43              COMa
21EB: C2 33           SBCb #$33
21ED: 98 9E           EORa $9E
21EF: 7A F6 B2        DEC $F6B2
21F2: D7 C3           STb $C3
21F4: CA B5           ORb #$B5
21F6: 75              ?????
21F7: 7A 40 61        DEC $4061
21FA: 3C F4           CWAI #F4
21FC: 79 73 7B        ROL $737B
21FF: 16 8B 16        LBRA $AD18
2202: 1B              ?????
2203: 92 4B           SBCa $4B
2205: 7B              ?????
2206: EB D8 4C        ADDb [+$4C,U]
2209: DB 28           ADDb $28
220B: 9F 40           STX $40
220D: B9 04 EE        ADCa $04EE
2210: 73 C6 C7        COM $C6C7
2213: DE D3           LDU $D3
2215: 14              ?????
2216: 85 96           BITa #$96
2218: 46              RORa
2219: 48              ASLa
221A: 67 16           ASR -$0A,X
221C: 2B 17           BMI $2235
221E: DB E0           ADDb $E0
2220: 4A              DECa
2221: 77 CF 49        ASR $CF49
2224: 2C 18           BGE $223E
2226: 3B              RTI
2227: 4A              DECa
2228: 15              ?????
2229: CB C0           ADDb #$C0
222B: 7A 1B EE        DEC $1BEE
222E: 1B              ?????
222F: A1 19           CMPa -$07,X
2231: 87              ?????
2232: 5B              ?????
2233: D4 1B           ANDb$1B
2235: B7 1B EE        STa $1BEE
2238: 1B              ?????
2239: A1 76           CMPa -$0A,S
223B: 4D              TSTa
223C: F4 BD 9B        ANDb $BD9B
223F: 15              ?????
2240: 5B              ?????
2241: CA 5B           ORb #$5B
2243: BE 15 BC        LDX $15BC
2246: 86 A6           LDa #$A6
2248: C0 16           SUBb #$16
224A: 51              ?????
224B: 18              ?????
224C: 23 C6           BLS $2214
224E: E8 8B           EORb D,X
2250: 0E BC           JMP $BC
2252: 91 C5           CMPa $C5
2254: DA 14           ORb $14
2256: DD 5F           STD $5F
2258: F3 5F 7B        ADDD $5F7B
225B: 50              NEGb
225C: 46              RORa
225D: 45              ?????
225E: 66 9E           ROR ??
2260: A1 A0           CMPa ,Y+
2262: 22 1E           BHI $2282
2264: 1C 1D           ANDCC #$1D
2266: 02              ?????
2267: 77 00 00        ASR $0000
226A: 90 03           SUBa $03
226C: 01              ?????
226D: 97 02           STa $02
226F: 06 D2           ROR $D2
2271: 97 BF           STa $BF
2273: 9F 03           STX $03
2275: A0 0B           SUBa +$0B,X
2277: 58              ASLb
2278: 0E 56           JMP $56
227A: 0D 53           TST $53
227C: 0E 06           JMP $06
227E: 0A 11           DEC $11
2280: 0A 42           DEC $42
2282: 0A 09           DEC $09
2284: 1A 15           ORCC #$15
2286: 08 1F           LSL $1F
2288: 46              RORa
2289: D2 97           SBCb $97
228B: BF 9F 03        STX $9F03
228E: A0 AB           SUBa D,Y
2290: 6E 8B           JMP D,X
2292: 4F              CLRa
2293: 96 7B           LDa $7B
2295: BF 14 0A        STX $140A
2298: BC 45 5E        CMPX $455E
229B: 85 48           BITa #$48
229D: 04 BC           LSR $BC
229F: 01              ?????
22A0: C4 4B           ANDb #$4B
22A2: 5E              ?????
22A3: AB BB           ADDa [D,Y]
22A5: DB 72           ADDb $72
22A7: 74 C0 8B        LSR $C08B
22AA: 9A 6B           ORa $6B
22AC: BF C7 DE        STX $C7DE
22AF: 90 14           SUBa $14
22B1: 0F 58           CLR $58
22B3: 64 C5           LSR B,U
22B5: F5 8B 61        BITb $8B61
22B8: 17 36 92        LBSR $594D
22BB: 90 73           SUBa $73
22BD: C3 6A 07        ADDd #$6A07
22C0: 4F              CLRa
22C1: 04 BC           LSR $BC
22C3: D0 60           SUBb $60
22C5: D4 6A           ANDb$6A
22C7: 82 49           SBCa #$49
22C9: 23 62           BLS $232D
22CB: 94 BE           ANDa $BE
22CD: 17 60 9A        LBSR $836A
22D0: 07 01           ASR $01
22D2: AB 08           ADDa +$08,X
22D4: 06 0D           ROR $0D
22D6: 04 9C           LSR $9C
22D8: 1C 1E           ANDCC #$1E
22DA: 9E 09           LDX $09
22DC: 02              ?????
22DD: 46              RORa
22DE: 46              RORa
22DF: 02              ?????
22E0: 0B              ?????
22E1: 00 00           NEG $00
22E3: 90 03           SUBa $03
22E5: 06 0D           ROR $0D
22E7: 04 96           LSR $96
22E9: 1E 1E           EXG X,??
22EB: 1F 02           TFR D,Y
22ED: 80 97           SUBa #$97
22EF: 00 00           NEG $00
22F1: 90 03           SUBa $03
22F3: 01              ?????
22F4: 97 02           STa $02
22F6: 06 D2           ROR $D2
22F8: 97 BF           STa $BF
22FA: 9F 03           STX $03
22FC: A0 0B           SUBa +$0B,X
22FE: 78 0E 76        LSL $0E76
2301: 0D 73           TST $73
2303: 0E 06           JMP $06
2305: 0A 11           DEC $11
2307: 0A 42           DEC $42
2309: 0A 09           DEC $09
230B: 1A 15           ORCC #$15
230D: 08 0E           LSL $0E
230F: 66 0D           ROR +$0D,X
2311: 49              ROLa
2312: 15              ?????
2313: 02              ?????
2314: 1F 0A           TFR D,CC
2316: D2 97           SBCb $97
2318: BF 9F 03        STX $9F03
231B: A0 AB           SUBa D,Y
231D: 6E 8B           JMP D,X
231F: 4F              CLRa
2320: A8 1F           EORa -$01,X
2322: 0C 8E           INC $8E
2324: 48              ASLa
2325: BF 14 0D        STX $140D
2328: BA D6 15        ORa $D615
232B: C2 16           SBCb #$16
232D: 81 61           CMPa #$61
232F: 29 0E           BVS $233F
2331: 29 0D           BVS $2340
2333: 25 08           BCS $233D
2335: 3D              MUL
2336: 1F 20           TFR Y,D
2338: 5F              CLRb
2339: BE 57 17        LDX $5717
233C: AF 55           STX -$0B,U
233E: 06 BC           ROR $BC
2340: 44              LSRa
2341: A0 3F           SUBa -$01,Y
2343: 16 0D 47        LBRA $308D
2346: 89 17           ADCa #$17
2348: 35 15           PULS ,CC,B,X
234A: 12              NOP 
234B: 53              COMb
234C: EB 5D           ADDb -$03,U
234E: C7              ?????
234F: DE 4F           LDU $4F
2351: 24 63           BCC $23B6
2353: 16 DB 59        LBRA $FEAF
2356: 71              ?????
2357: 7B              ?????
2358: 24 14           BCC $236E
235A: 0C 0D           INC $0D
235C: 19              DAA
235D: 1F 0E           TFR D,??
235F: D2 97           SBCb $97
2361: BF 9F 03        STX $9F03
2364: A0 72           SUBa -$0E,S
2366: B1 BE A0        CMPa $BEA0
2369: D6 B5           LDb $B5
236B: 56              RORb
236C: 72              ?????
236D: A8 1F           EORa -$01,X
236F: 06 4B           ROR $4B
2371: 7B              ?????
2372: 5F              CLRb
2373: A0 1B           SUBa -$05,X
2375: 9C 9A           CMPX $9A
2377: 07 01           ASR $01
2379: AB 08           ADDa +$08,X
237B: 06 0D           ROR $0D
237D: 04 9C           LSR $9C
237F: 1C 20           ANDCC #$20
2381: 9E 09           LDX $09
2383: 02              ?????
2384: 46              RORa
2385: 46              RORa
2386: 02              ?????
2387: 0B              ?????
2388: 00 00           NEG $00
238A: 90 03           SUBa $03
238C: 06 0D           ROR $0D
238E: 04 96           LSR $96
2390: 1E 20           EXG Y,D
2392: 21 05           BRN $2399
2394: 25 00           BCS $2396
2396: 00 90           NEG $90
2398: 03 01           COM $01
239A: 99 02           ADCa $02
239C: 05              ?????
239D: 85 A5           BITa #$A5
239F: 65              ?????
23A0: 49              ROLa
23A1: 4F              CLRa
23A2: 0B              ?????
23A3: 01              ?????
23A4: 9A 07           ORa $07
23A6: 01              ?????
23A7: AB 08           ADDa +$08,X
23A9: 0C 0E           INC $0E
23AB: 0A 0D           DEC $0D
23AD: 04 9C           LSR $9C
23AF: 1C 22           ANDCC #$22
23B1: 9E 14           LDX $14
23B3: 1C 3F           ANDCC #$3F
23B5: 10 09           ?????
23B7: 02              ?????
23B8: 46              RORa
23B9: 46              RORa
23BA: 05              ?????
23BB: 0B              ?????
23BC: 00 00           NEG $00
23BE: 90 03           SUBa $03
23C0: 06 0D           ROR $0D
23C2: 04 98           LSR $98
23C4: 1E 22           EXG Y,Y
23C6: 23 05           BLS $23CD
23C8: 34 00           PSHS ??
23CA: 00 90           NEG $90
23CC: 03 01           COM $01
23CE: 99 02           ADCa $02
23D0: 05              ?????
23D1: 85 A5           BITa #$A5
23D3: 65              ?????
23D4: 49              ROLa
23D5: 4F              CLRa
23D6: 07 01           ASR $01
23D8: AB 0B           ADDa +$0B,X
23DA: 01              ?????
23DB: 9A 08           ORa $08
23DD: 1B              ?????
23DE: 0E 19           JMP $19
23E0: 0D 08           TST $08
23E2: 14              ?????
23E3: 03 88           COM $88
23E5: 24 1C           BCC $2403
23E7: 3F              SWI1
23E8: 10 0C           ?????
23EA: 0D 07           TST $07
23EC: 03 88           COM $88
23EE: 24 17           BCC $2407
23F0: 3E              RESET*
23F1: 88 0C           EORa #$0C
23F3: 0D 04           TST $04
23F5: 9C 1C           CMPX $1C
23F7: 24 9E           BCC $2397
23F9: 09 02           ROL $02
23FB: 46              RORa
23FC: 46              RORa
23FD: 05              ?????
23FE: 0B              ?????
23FF: 00 00           NEG $00
2401: 90 03           SUBa $03
2403: 06 0D           ROR $0D
2405: 04 98           LSR $98
2407: 1E 24           EXG Y,S
2409: 25 06           BCS $2411
240B: 80 FD           SUBa #$FD
240D: 00 00           NEG $00
240F: 90 03           SUBa $03
2411: 25 04           BCS $2417
2413: 23 34           BLS $2449
2415: 92 90           SBCa $90
2417: 8C D5 15        CMPX #$D515
241A: 8F              ?????
241B: 16 2C 49        LBRA $5067
241E: B3 E0 1B        SUBD $E01B
2421: 54              LSRb
2422: C3 9A AB        ADDd #$9AAB
2425: 98 8E           EORa $8E
2427: 48              ASLa
2428: 77 15 03        ASR $1503
242B: BA 2E 56        ORa $2E56
242E: 83 49 AB        SUBd #$49AB
2431: 98 73           EORa $73
2433: 49              ROLa
2434: C7              ?????
2435: DE 2E           LDU $2E
2437: 02              ?????
2438: 04 34           LSR $34
243A: 92 90           SBCa $90
243C: 8C 0B 01        CMPX #$0B01
243F: 9A 07           ORa $07
2441: 01              ?????
2442: AB 08           ADDa +$08,X
2444: 80 C0           SUBa #$C0
2446: 0E 80           JMP $80
2448: BD 0D 04        JSR $0D04
244B: 9C 1C           CMPX $1C
244D: 26 9E           BNE $23ED
244F: 0B              ?????
2450: 80 B4           SUBa #$B4
2452: 05              ?????
2453: 08 30           LSL $30
2455: 1F 2E           TFR Y,??
2457: 34 92           PSHS ,PC,X,A
2459: 90 8C           SUBa $8C
245B: 53              COMb
245C: 17 6E DF        LBSR $933E
245F: 6E 13           JMP -$0D,X
2461: 71              ?????
2462: 61              ?????
2463: F3 9B 45        ADDD $9B45
2466: 77 EF 9F        ASR $EF9F
2469: 8E 48 51        LDX #$4851
246C: 18              ?????
246D: EB C1           ADDb ,U++ 
246F: 78 B1 8E        LSL $B18E
2472: 5F              CLRb
2473: 89 17           ADCa #$17
2475: 67 16           ASR -$0A,X
2477: 82 17           SBCa #$17
2479: 46              RORa
247A: 5E              ?????
247B: 44              LSRa
247C: A0 B8 16        SUBa [+$16,Y]
247F: 35 15           PULS ,CC,B,X
2481: 12              NOP 
2482: 53              COMb
2483: EC 5D           LDD -$03,U
2485: 10 42           ?????
2487: 1F 40           TFR S,D
2489: 34 92           PSHS ,PC,X,A
248B: 90 8C           SUBa $8C
248D: 77 15 0F        ASR $150F
2490: BA 75 B1        ORa $75B1
2493: 96 14           LDa $14
2495: 51              ?????
2496: 18              ?????
2497: 43              COMa
2498: C2 33           SBCb #$33
249A: 98 1B           EORa $1B
249C: B7 33 BB        STa $33BB
249F: FB 1B 10        ADDb $1B10
24A2: 53              COMb
24A3: F3 23 8E        ADDD $238E
24A6: C5 3D           BITb #$3D
24A8: 62              ?????
24A9: 50              NEGb
24AA: BD 0B 58        JSR $0B58
24AD: 9B C1           ADDa $C1
24AF: 4F              CLRa
24B0: 77 66 C6        ASR $66C6
24B3: 9B 15           ADDa $15
24B5: 5B              ?????
24B6: CA 40           ORb #$40
24B8: 55              ?????
24B9: F4 81 F3        ANDb $81F3
24BC: 5F              CLRb
24BD: 5F              CLRb
24BE: BE 04 18        LDX $0418
24C1: 11 A0           ?????
24C3: FF 14 C0        STU $14C0
24C6: 93 63           SUBd $63
24C8: F4 18 3B        ANDb $183B
24CB: 1F 39           TFR U,B
24CD: 34 92           PSHS ,PC,X,A
24CF: 90 8C           SUBa $8C
24D1: E9 16           ADCb -$0A,X
24D3: 9E 7A           LDX $7A
24D5: C3 B5 1B        ADDd #$B51B
24D8: BC 3E A1        CMPX $3EA1
24DB: 6F 13           CLR -$0D,X
24DD: 1B              ?????
24DE: DD C3           STD $C3
24E0: 9E 77           LDX $77
24E2: 98 F9           EORa $F9
24E4: BF F3 9B        STX $F39B
24E7: 14              ?????
24E8: D0 11           SUBb $11
24EA: BC 8A 64        CMPX $8A64
24ED: 0E 9F           JMP $9F
24EF: FF 14 C0        STU $14C0
24F2: 93 09           SUBd $09
24F4: 15              ?????
24F5: 82 17           SBCa #$17
24F7: 59              ROLb
24F8: DB 46           ADDb $46
24FA: 7A 16 EE        DEC $16EE
24FD: F0 72 AF        SUBb $72AF
2500: 14              ?????
2501: 81 15           CMPa #$15
2503: 59              ROLb
2504: 98 22           EORa $22
2506: 09 02           ROL $02
2508: 46              RORa
2509: 46              RORa
250A: 06 6E           ROR $6E
250C: 00 00           NEG $00
250E: 90 03           SUBa $03
2510: 69 0D           ROL +$0D,X
2512: 67 04           ASR +$04,X
2514: 62              ?????
2515: 83 48 8D        SUBd #$488D
2518: 48              ASLa
2519: 30 79           LEAX -$07,S
251B: 0F BC           CLR $BC
251D: 83 48 83        SUBd #$4883
2520: 7A 44 45        DEC $4445
2523: 45              ?????
2524: 8B C5           ADDa #$C5
2526: 83 73 8D        SUBd #$738D
2529: C3 83 33        ADDd #$8333
252C: 98 7B           EORa $7B
252E: A6 BF 9A 0A     LDa [$9A0A]
2532: 58              ASLb
2533: 73 49 B5        COM $49B5
2536: 6C 74           INC -$0C,S
2538: C0 4B           SUBb #$4B
253A: 62              ?????
253B: 73 49 C7        COM $49C7
253E: DE FC           LDU $FC
2540: ED EF 59 01     STD $5901,S
2544: A0 BB           SUBa [D,Y]
2546: 15              ?????
2547: 58              ASLb
2548: 72              ?????
2549: 55              ?????
254A: 5E              ?????
254B: 6F C5           CLR B,U
254D: 0F A0           CLR $A0
254F: 1B              ?????
2550: 58              ASLb
2551: 19              DAA
2552: A1 BB           CMPa [D,Y]
2554: 15              ?????
2555: 5B              ?????
2556: 48              ASLa
2557: C7              ?????
2558: DE 8F           LDU $8F
255A: AF 66           STX +$06,S
255C: 49              ROLa
255D: 46              RORa
255E: 62              ?????
255F: 67 16           ASR -$0A,X
2561: 83 B2 2B        SUBd #$B22B
2564: 96 C7           LDa $C7
2566: DE 77           LDU $77
2568: 16 F3 B9        LBRA $1924
256B: 2F 9E           BLE $250B
256D: 4F              CLRa
256E: DB 45           ADDb $45
2570: DB EF           ADDb $EF
2572: 9F 8E           STX $8E
2574: 48              ASLa
2575: E3 06           ADDD +$06,X
2577: 1E 26           EXG Y,??
2579: 27 07           BEQ $2582
257B: 54              LSRb
257C: 00 00           NEG $00
257E: 80 03           SUBa #$03
2580: 27 04           BEQ $2586
2582: 25 5F           BCS $25E3
2584: BE 7C 13        LDX $7C13
2587: 8E 5F 86        LDX #$5F86
258A: 19              DAA
258B: 66 9E           ROR ??
258D: A3 A0           SUBD ,Y+
258F: 03 BA           COM $BA
2591: F3 8C 87        ADDD $8C87
2594: 8C D7 B5        CMPX #$D7B5
2597: 21 98           BRN $2531
2599: 95 9A           BITa $9A
259B: C7              ?????
259C: 7A CB B5        DEC $CBB5
259F: 96 96           LDa $96
25A1: DB 72           ADDb $72
25A3: 44              LSRa
25A4: 55              ?????
25A5: 74 98 2E        LSR $982E
25A8: 02              ?????
25A9: 0C 8D           INC $8D
25AB: C5 0D           BITb #$0D
25AD: A0 C7           SUBa ??
25AF: 7A C6 B5        DEC $C6B5
25B2: 66 9E           ROR ??
25B4: A3 A0           SUBD ,Y+
25B6: 0B              ?????
25B7: 14              ?????
25B8: 1F 12           TFR X,Y
25BA: 5F              CLRb
25BB: BE 09 15        LDX $0915
25BE: 09 56           ROL $56
25C0: 8B AF           ADDa #$AF
25C2: D7 B5           STb $B5
25C4: 21 98           BRN $255E
25C6: 95 9A           BITa $9A
25C8: C7              ?????
25C9: 7A 5B BB        DEC $5BBB
25CC: 09 02           ROL $02
25CE: 46              RORa
25CF: 01              ?????
25D0: 07 80           ASR $80
25D2: F5 00 00        BITb $0000
25D5: 90 03           SUBa $03
25D7: 80 EF           SUBa #$EF
25D9: 0D 80           TST $80
25DB: EC 04           LDD +$04,X
25DD: 80 E6           SUBa #$E6
25DF: 5F              CLRb
25E0: BE 5B B1        LDX $5BB1
25E3: 4B              ?????
25E4: 7B              ?????
25E5: 4F              CLRa
25E6: 45              ?????
25E7: 83 48 83        SUBd #$4883
25EA: 7A 55 45        DEC $5545
25ED: EB BF 73 7B     ADDb [$737B]
25F1: C5 7E           BITb #$7E
25F3: B6 85 D0        LDa $85D0
25F6: 15              ?????
25F7: 82 17           SBCa #$17
25F9: 45              ?????
25FA: 5E              ?????
25FB: B8 A0 47        EORa $A047
25FE: 62              ?????
25FF: 9F 15           STX $15
2601: 49              ROLa
2602: 16 A5 9F        LBRA $CBA4
2605: B2 17 96        SBCa $1796
2608: 14              ?????
2609: 51              ?????
260A: 18              ?????
260B: 43              COMa
260C: C2 33           SBCb #$33
260E: 98 AF           EORa $AF
2610: 94 7F           ANDa $7F
2612: 4E              ?????
2613: 33 BB           LEAU [D,Y]
2615: FA 1C FF        ORb $1CFF
2618: F9 73 7B        ADCb $737B
261B: 4B              ?????
261C: 7B              ?????
261D: F4 BD 04        ANDb $BD04
2620: B2 FF 8B        SBCa $FF8B
2623: F6 F9 DB        LDb $F9DB
2626: 72              ?????
2627: 75              ?????
2628: 5B              ?????
2629: 84 BF           ANDa #$BF
262B: 9B 15           ADDa $15
262D: C4 B5           ANDb #$B5
262F: E1 5F           CMPb -$01,U
2631: 1B              ?????
2632: 92 5F           SBCa $5F
2634: BE DB 16        LDX $DB16
2637: 87              ?????
2638: BE B3 9A        LDX $B39A
263B: 8E 48 82        LDX #$4882
263E: 17 52 5E        LBSR $789F
2641: 83 49 9E        SUBd #$499E
2644: 61              ?????
2645: 82 17           SBCa #$17
2647: 46              RORa
2648: 5E              ?????
2649: 66 9E           ROR ??
264B: C7              ?????
264C: A0 EE           SUBa ??
264E: F9 66 7B        ADCb $667B
2651: 83 61 6B        SUBd #$616B
2654: BF 3F 92        STX $3F92
2657: EB F9 8F 14     ADDb [$8F14,S]
265B: 82 17           SBCa #$17
265D: 46              RORa
265E: 5E              ?????
265F: 66 9E           ROR ??
2661: C7              ?????
2662: A0 FB           SUBa [D,S]
2664: F9 1B A1        ADCb $1BA1
2667: B5 94 09        BITa $9409
266A: BC D6 9C        CMPX $D69C
266D: D6 9C           LDb $9C
266F: DB 72           ADDb $72
2671: B6 49 84        LDa $4984
2674: 74 83 7B        LSR $837B
2677: 4B              ?????
2678: 62              ?????
2679: 8E 48 7F        LDX #$487F
267C: 17 F3 8C        LBSR $1A0B
267F: 5F              CLRb
2680: BE 51 90        LDX $5190
2683: 96 64           LDa $64
2685: 95 73           BITa $73
2687: 8C 17 CF        CMPX #$17CF
268A: 49              ROLa
268B: 13              SYNC
268C: BA CA 06        ORa $CA06
268F: 3C C6           CWAI #C6
2691: B3 E0 68        SUBD $E068
2694: 4D              TSTa
2695: AF A0           STX ,Y+
2697: D6 15           LDb $15
2699: D5 15           BITb $15
269B: 89 17           ADCa #$17
269D: CE 9C 7F        LDU #$9C7F
26A0: 49              ROLa
26A1: 63 F4           COM [,S]
26A3: 95 73           BITa $73
26A5: 3B              RTI
26A6: 15              ?????
26A7: 4B              ?????
26A8: 62              ?????
26A9: FE B2 04        LDU $B204
26AC: 8A DD           ORa #$DD
26AE: 46              RORa
26AF: D0 15           SUBb $15
26B1: 6B              ?????
26B2: BF 95 73        STX $9573
26B5: 9F 15           STX $15
26B7: F3 46 8E        ADDD $468E
26BA: 48              ASLa
26BB: 9F 15           STX $15
26BD: DB 16           ADDb $16
26BF: D7 B9           STb $B9
26C1: D1 B5           CMPb $B5
26C3: 97 C6           STa $C6
26C5: 1E 28           EXG Y,A
26C7: 29 04           BVS $26CD
26C9: 81 0A           CMPa #$0A
26CB: 00 00           NEG $00
26CD: 90 03           SUBa $03
26CF: 29 04           BVS $26D5
26D1: 27 87           BEQ $265A
26D3: 74 90 5A        LSR $905A
26D6: 4B              ?????
26D7: 77 D9 B5        ASR $D9B5
26DA: 16 B2 90        LBRA $D96D
26DD: 73 5B 70        COM $5B70
26E0: FD 1B F3        STD $1BF3
26E3: 8C 5B 4D        CMPX #$5B4D
26E6: 89 5B           ADCa #$5B
26E8: 88 96           EORa #$96
26EA: FF B2 9F        STU $B29F
26ED: 15              ?????
26EE: 5B              ?????
26EF: B1 83 7A        CMPa $837A
26F2: 4F              CLRa
26F3: 45              ?????
26F4: 9F 7A           STX $7A
26F6: D9 BD           ADCb $BD
26F8: 22 02           BHI $26FC
26FA: 05              ?????
26FB: 87              ?????
26FC: 74 90 5A        LSR $905A
26FF: 49              ROLa
2700: 07 80           ASR $80
2702: CB 0D           ADDb #$0D
2704: 80 C8           SUBa #$C8
2706: 0E 04           JMP $04
2708: 0A 48           DEC $48
270A: 0A 12           DEC $12
270C: 04 80           LSR $80
270E: BC C7 DE        CMPX $C7DE
2711: 3F              SWI1
2712: 16 0A BC        LBRA $31D1
2715: 26 A1           BNE $26B8
2717: 93 7A           SUBd $7A
2719: 09 15           ROL $15
271B: 26 D2           BNE $26EF
271D: BF 14 1B        STX $141B
2720: BC 1B A1        CMPX $1BA1
2723: 2F 49           BLE $276E
2725: B0 17 B6        SUBa $17B6
2728: 46              RORa
2729: 56              RORb
272A: 5E              ?????
272B: D4 9C           ANDb$9C
272D: 71              ?????
272E: 61              ?????
272F: 5B              ?????
2730: CA 95           ORb #$95
2732: 73 66 17        COM $6617
2735: CB B0           ADDb #$B0
2737: 0C BC           INC $BC
2739: DD 46           STD $46
273B: 97 62           STa $62
273D: A9 15           ADCa -$0B,X
273F: 03 C4           COM $C4
2741: FB 98 1B        ADDb $981B
2744: B7 33 BB        STa $33BB
2747: 91 1E           CMPa $1E
2749: 46              RORa
274A: C2 08           SBCb #$08
274C: 79 F3 23        ROL $F323
274F: 58              ASLb
2750: 72              ?????
2751: 56              RORb
2752: 5E              ?????
2753: C6 9C           LDb #$9C
2755: D6 9C           LDb $9C
2757: 56              RORb
2758: 72              ?????
2759: CB 06           ADDb #$06
275B: 01              ?????
275C: 18              ?????
275D: 3E              RESET*
275E: C5 9B           BITb #$9B
2760: 15              ?????
2761: 5B              ?????
2762: CA 67           ORb #$67
2764: 4D              TSTa
2765: 86 96           LDa #$96
2767: 80 A1           SUBa #$A1
2769: D0 15           SUBb $15
276B: 7B              ?????
276C: 14              ?????
276D: D0 92           SUBb $92
276F: 7F C6 44        CLR $C644
2772: F4 73 C6        ANDb $73C6
2775: 9E 77           LDX $77
2777: 15              ?????
2778: 8A 8E           ORa #$8E
277A: BE 16 8A        LDX $168A
277D: 17 48 51        LBSR $6FD1
2780: 18              ?????
2781: 59              ROLb
2782: C2 82           SBCb #$82
2784: 7B              ?????
2785: 67 16           ASR -$0A,X
2787: FA 17 83        ORb $1783
278A: 61              ?????
278B: 47              ASRa
278C: 77 53 B7        ASR $53B7
278F: FE A4 FF        LDU $A4FF
2792: 15              ?????
2793: F3 B9 4B        ADDD $B94B
2796: 49              ROLa
2797: 41              ?????
2798: B9 83 96        ADCa $8396
279B: CB B5           ADDb #$B5
279D: 77 15 11        ASR $1511
27A0: BC 73 C6        CMPX $73C6
27A3: C3 9E 63        ADDd #$9E63
27A6: BE D6 B5        LDX $D6B5
27A9: 90 73           SUBa $73
27AB: 6C 6A           INC +$0A,S
27AD: 9F 15           STX $15
27AF: AF 14           STX -$0C,X
27B1: 50              NEGb
27B2: 6D D9 B5 75     TST [$B575,U]
27B6: B1 03 BF        CMPa $03BF
27B9: AB 98 56        ADDa [+$56,X]
27BC: D1 0A           CMPb $0A
27BE: 71              ?????
27BF: 4B              ?????
27C0: 7B              ?????
27C1: 0C BA           INC $BA
27C3: D6 47           LDb $47
27C5: EB 15           ADDb -$0B,X
27C7: 97 54           STa $54
27C9: 9B C1           ADDa $C1
27CB: 1E 2A           EXG Y,CC
27CD: 2C 0B           BGE $27DA
27CF: 01              ?????
27D0: 9A 09           ORa $09
27D2: 02              ?????
27D3: 46              RORa
27D4: 46              RORa
27D5: 04 80           LSR $80
27D7: D9 00           ADCb $00
27D9: 00 90           NEG $90
27DB: 03 80           COM $80
27DD: D3 0D           ADDD $0D
27DF: 80 D0           SUBa #$D0
27E1: 04 80           LSR $80
27E3: CA 5F           ORb #$5F
27E5: BE 5B B1        LDX $5BB1
27E8: 4B              ?????
27E9: 7B              ?????
27EA: 48              ASLa
27EB: 45              ?????
27EC: 98 C5           EORa $C5
27EE: 4E              ?????
27EF: DB 3D           ADDb $3D
27F1: A0 91           SUBa [,X++]
27F3: 7A 63 16        DEC $6316
27F6: 8A 96           ORa #$96
27F8: 91 48           CMPa $48
27FA: 91 7A           CMPa $7A
27FC: 83 17 F3        SUBd #$17F3
27FF: 5F              CLRb
2800: 56              RORb
2801: D1 03           CMPb $03
2803: 71              ?????
2804: 39              RTS
2805: 17 DB A4        LBSR $03AC
2808: 7B              ?????
2809: 50              NEGb
280A: 95 73           BITa $73
280C: 4F              CLRa
280D: 15              ?????
280E: 73 62 6B        COM $626B
2811: BF 5F BE        STX $5FBE
2814: D7 14           STb $14
2816: 43              COMa
2817: 7A CF 98        DEC $CF98
281A: 9F 15           STX $15
281C: D5 15           BITb $15
281E: F7 17 33        STb $1733
2821: 49              ROLa
2822: AB 98 55        ADDa [+$55,X]
2825: 45              ?????
2826: EB BF 73 7B     ADDb [$737B]
282A: C5 7E           BITb #$7E
282C: B6 85 4A        LDa $854A
282F: F4 56 5E        ANDb $565E
2832: 38              ?????
2833: C6 CA           LDb #$CA
2835: B5 4B 7B        BITa $4B7B
2838: E3 72           ADDD -$0E,S
283A: 16 58 73        LBRA $80B0
283D: A1 33           CMPa -$0D,Y
283F: B1 C7 DE        CMPa $C7DE
2842: FC ED EE        LDD $EDEE
2845: 72              ?????
2846: 69 8D BB 15     ROL $BB15,PC
284A: 5B              ?????
284B: 48              ASLa
284C: 5F              CLRb
284D: BE 84 15        LDX $8415
2850: 96 5F           LDa $5F
2852: A9 15           ADCa -$0B,X
2854: 03 C4           COM $C4
2856: F9 98 99        ADCb $9899
2859: 16 B9 14        LBRA $E170
285C: 4D              TSTa
285D: 98 D3           EORa $D3
285F: 14              ?????
2860: 8A 96           ORa #$96
2862: BE 9F 67        LDX $9F67
2865: 16 10 EE        LBRA $3956
2868: CE 9C 5D        LDU #$9C5D
286B: 9E C5           LDX $C5
286D: B5 83 48        BITa $8348
2870: 75              ?????
2871: B1 66 7B        CMPa $667B
2874: 67 16           ASR -$0A,X
2876: D9 06           ADCb $06
2878: D6 47           LDb $47
287A: 0E EE           JMP $EE
287C: 73 62 1B        COM $621B
287F: 92 29           SBCa $29
2881: B8 DB CE        EORa $DBCE
2884: 19              DAA
2885: A1 BB           CMPa [D,Y]
2887: 15              ?????
2888: 10 53           ?????
288A: 77 15 17        ASR $1517
288D: BC C4 B5        CMPX $C4B5
2890: 02              ?????
2891: A1 C7           CMPa ??
2893: 16 11 BC        LBRA $3A52
2896: 96 64           LDa $64
2898: 95 73           BITa $73
289A: E6 16           LDb -$0A,X
289C: D7 46           STb $46
289E: E3 06           ADDD +$06,X
28A0: DB 72           ADDb $72
28A2: 69 4D           ROL +$0D,U
28A4: 9D 7A           JSR $7A
28A6: 04 18           LSR $18
28A8: 79 79 90        ROL $7990
28AB: 8C 5B 70        CMPX #$5B70
28AE: 1E 2A           EXG Y,CC
28B0: 2B 04           BMI $28B6
28B2: 80 93           SUBa #$93
28B4: 00 00           NEG $00
28B6: 90 03           SUBa $03
28B8: 36 04           PSHU ,B
28BA: 34 87           PSHS ,PC,B,A,CC
28BC: 74 90 5A        LSR $905A
28BF: 4B              ?????
28C0: 77 D9 B5        ASR $D9B5
28C3: 75              ?????
28C4: B1 03 BF        CMPa $03BF
28C7: AB 98 56        ADDa [+$56,X]
28CA: D1 0A           CMPb $0A
28CC: 71              ?????
28CD: 4B              ?????
28CE: 7B              ?????
28CF: 0C BA           INC $BA
28D1: D6 47           LDb $47
28D3: EB 15           ADDb -$0B,X
28D5: 97 54           STa $54
28D7: 9B C1           ADDa $C1
28D9: FD 1B F3        STD $1BF3
28DC: 8C 5B 4D        CMPX #$5B4D
28DF: 36 A1           PSHU ,PC,Y,CC
28E1: B8 16 82        EORa $1682
28E4: 17 4B 7B        LBSR $7462
28E7: 83 7A EB        SUBd #$7AEB
28EA: 99 8F           ADCa $8F
28EC: BE EC 5D        LDX $EC5D
28EF: 02              ?????
28F0: 05              ?????
28F1: 87              ?????
28F2: 74 90 5A        LSR $905A
28F5: 49              ROLa
28F6: 08 45           LSL $45
28F8: 0E 43           JMP $43
28FA: 0D 04           TST $04
28FC: 9C 1C           CMPX $1C
28FE: 2C 9E           BGE $289E
2900: 0B              ?????
2901: 3B              RTI
2902: 05              ?????
2903: 08 1A           LSL $1A
2905: 1F 18           TFR X,A
2907: 87              ?????
2908: 74 90 5A        LSR $905A
290B: 4F              CLRa
290C: 77 64 C5        ASR $64C5
290F: F5 8B FC        BITb $8BFC
2912: ED A3           STD ,--Y
2914: 48              ASLa
2915: 6B              ?????
2916: 16 F6 9A        LBRA $1FB3
2919: 50              NEGb
291A: 5E              ?????
291B: 8F              ?????
291C: A1 DC F9        CMPa [-$07,PC]
291F: 10 1C           ?????
2921: 1F 1A           TFR X,CC
2923: 87              ?????
2924: 74 90 5A        LSR $905A
2927: 46              RORa
2928: 77 DE 5F        ASR $DE5F
292B: 2F 49           BLE $2976
292D: 33 BB           LEAU [D,Y]
292F: FD 1B 5B        STD $1B5B
2932: CA 47           ORb #$47
2934: 48              ASLa
2935: E6 A0           LDb ,Y+
2937: 81 15           CMPa #$15
2939: 0B              ?????
293A: BC AC BB        CMPX $ACBB
293D: 07 01           ASR $01
293F: AB 0B           ADDa +$0B,X
2941: 01              ?????
2942: 9A 09           ORa $09
2944: 02              ?????
2945: 46              RORa
2946: 46              RORa
2947: 01              ?????
2948: 81 CA           CMPa #$CA
294A: 8E 00 90        LDX #$0090
294D: 03 60           COM $60
294F: 04 5E           LSR $5E
2951: 5F              CLRb
2952: BE 5B B1        LDX $5BB1
2955: 4B              ?????
2956: 7B              ?????
2957: 58              ASLb
2958: 45              ?????
2959: 43              COMa
295A: 62              ?????
295B: 3B              RTI
295C: 16 B7 B1        LBRA $E110
295F: 01              ?????
2960: 18              ?????
2961: 90 91           SUBa $91
2963: 0C 15           INC $15
2965: 65              ?????
2966: 62              ?????
2967: F3 5F 83        ADDD $5F83
296A: 7A 57 45        DEC $5745
296D: 08 99           LSL $99
296F: B7 A0 9F        STa $A09F
2972: 15              ?????
2973: 7F B1 5A        CLR $B15A
2976: 17 4E 5E        LBSR $77D7
2979: 3D              MUL
297A: A0 CE           SUBa ??
297C: B5 17 7A        BITa $177A
297F: 82 17           SBCa #$17
2981: 54              LSRb
2982: 5E              ?????
2983: C6 9F           LDb #$9F
2985: 23 62           BLS $29E9
2987: F4 59 7B        ANDb $597B
298A: 50              NEGb
298B: A7 AD A7 61     STa $A761,PC
298F: 5A              DECb
2990: 17 4A 5E        LBSR $73F1
2993: 4B              ?????
2994: 49              ROLa
2995: 4C              INCa
2996: 45              ?????
2997: 79 47 F3        ROL $47F3
299A: 5F              CLRb
299B: 53              COMb
299C: B7 8C AF        STa $8CAF
299F: 66 C6           ROR A,U
29A1: AF 14           STX -$0C,X
29A3: 89 8D           ADCa #$8D
29A5: 9F 15           STX $15
29A7: 8A AF           ORa #$AF
29A9: D4 47           ANDb$47
29AB: 90 8C           SUBa $8C
29AD: DB 63           ADDb $63
29AF: 02              ?????
29B0: 06 5F           ROR $5F
29B2: BE 9F 16        LDX $9F16
29B5: 97 B3           STa $B3
29B7: 0B              ?????
29B8: 01              ?????
29B9: 9A 07           ORa $07
29BB: 01              ?????
29BC: AB 08           ADDa +$08,X
29BE: 81 50           CMPa #$50
29C0: 0D 81           TST $81
29C2: 4D              TSTa
29C3: 01              ?????
29C4: 13              SYNC
29C5: 0E 81           JMP $81
29C7: 48              ASLa
29C8: 0D 71           TST $71
29CA: 0A 03           DEC $03
29CC: 1F 6D           TFR ??,??
29CE: 1F B8           TFR DP,A
29D0: 8F              ?????
29D1: 17 DD B2        LBSR $0786
29D4: 89 17           ADCa #$17
29D6: 14              ?????
29D7: D0 1B           SUBb $1B
29D9: 58              ASLb
29DA: 1B              ?????
29DB: A1 8E           CMPa ??
29DD: 48              ASLa
29DE: 53              COMb
29DF: 17 6E DF        LBSR $98C1
29E2: 79 13 AB        ROL $13AB
29E5: 70 C7 DE        NEG $C7DE
29E8: 77 16 F3        ASR $16F3
29EB: B9 5B 4D        ADCa $5B4D
29EE: F4 72 48        ANDb $7248
29F1: 5E              ?????
29F2: A3 A0           SUBD ,Y+
29F4: EF BF 87 49     STU [$8749]
29F8: 9E 61           LDX $61
29FA: 4C              INCa
29FB: F4 66 C6        ANDb $66C6
29FE: E1 14           CMPb -$0C,X
2A00: 1B              ?????
2A01: 92 09           SBCa $09
2A03: B2 33 75        SBCa $3375
2A06: 4F              CLRa
2A07: A1 8A           CMPa ??
2A09: AF 2F           STX +$0F,Y
2A0B: 62              ?????
2A0C: FF F9 95        STU $F995
2A0F: 19              DAA
2A10: DB 72           ADDb $72
2A12: B5 6C 74        BITa $6C74
2A15: C0 4B           SUBb #$4B
2A17: 62              ?????
2A18: 89 BF           ADCa #$BF
2A1A: 2E 49           BGT $2A65
2A1C: 61              ?????
2A1D: 17 36 92        LBSR $60B2
2A20: 90 73           SUBa $73
2A22: D9 6A           ADCb $6A
2A24: 85 73           BITa #$73
2A26: 0E 71           JMP $71
2A28: 3D              MUL
2A29: A0 CE           SUBa ??
2A2B: B5 17 7A        BITa $177A
2A2E: 90 14           SUBa $14
2A30: 2E 15           BGT $2A47
2A32: E6 5F           LDb -$01,U
2A34: 05              ?????
2A35: B2 E1 14        SBCa $E114
2A38: DA C3           ORb $C3
2A3A: 2E 0D           BGT $2A49
2A3C: 80 D2           SUBa #$D2
2A3E: 1F 73           TFR ??,U
2A40: 91 1E           CMPa $1E
2A42: A4 C2           ANDa ,-U
2A44: 50              NEGb
2A45: 5E              ?????
2A46: F3 A0 41        ADDD $A041
2A49: 55              ?????
2A4A: F4 A4 83        ANDb $A483
2A4D: 49              ROLa
2A4E: CF              ?????
2A4F: 98 DC           EORa $DC
2A51: F9 15 EE        ADCb $15EE
2A54: 55              ?????
2A55: 4A              DECa
2A56: 82 17           SBCa #$17
2A58: 50              NEGb
2A59: 5E              ?????
2A5A: 3D              MUL
2A5B: C6 43           LDb #$43
2A5D: 5E              ?????
2A5E: D5 B5           BITb $B5
2A60: DB 72           ADDb $72
2A62: 70 8E B5        NEG $8EB5
2A65: 6C 85           INC B,X
2A67: 14              ?????
2A68: 05              ?????
2A69: B3 D6 B5        SUBD $D6B5
2A6C: DB 72           ADDb $72
2A6E: 01              ?????
2A6F: B3 43 90        SUBD $4390
2A72: 33 98 45        LEAU [+$45,X]
2A75: BD BF 86        JSR $BF86
2A78: DB B5           ADDb $B5
2A7A: 3F              SWI1
2A7B: A1 5A           CMPa -$06,U
2A7D: 17 46 5E        LBSR $70DE
2A80: C9 B0           ADCb #$B0
2A82: DB B5           ADDb $B5
2A84: 1B              ?????
2A85: A1 6B           CMPa +$0B,S
2A87: BF 5F BE        STX $5FBE
2A8A: E1 14           CMPb -$0C,X
2A8C: DA C3           ORb $C3
2A8E: 90 14           SUBa $14
2A90: 15              ?????
2A91: 58              ASLb
2A92: EB BF 0B A7     ADDb [$0BA7]
2A96: C7              ?????
2A97: DE D0           LDU $D0
2A99: 15              ?????
2A9A: 56              RORb
2A9B: F4 F0 72        ANDb $F072
2A9E: 5A              DECb
2A9F: 17 52 5E        LBSR $7D00
2AA2: 46              RORa
2AA3: C5 C3           BITb #$C3
2AA5: B5 91 96        BITa $9196
2AA8: D0 92           SUBb $92
2AAA: 35 A1           PULS ,CC,Y,PC
2AAC: 3F              SWI1
2AAD: 16 74 CA        LBRA $9F7A
2AB0: 90 14           SUBa $14
2AB2: 44              LSRa
2AB3: 0E 24           JMP $24
2AB5: 03 13           COM $13
2AB7: 3A              ABX
2AB8: 1F 1F           TFR X,??
2ABA: C7              ?????
2ABB: DE 3A           LDU $3A
2ABD: 15              ?????
2ABE: F4 A4 30        ANDb $A430
2AC1: 79 9B 53        ROL $9B53
2AC4: 5F              CLRb
2AC5: BE AE 17        LDX $AE17
2AC8: 8F              ?????
2AC9: BE 7F 49        LDX $7F49
2ACC: 89 14           ADCa #$14
2ACE: 23 A0           BLS $2A70
2AD0: CF              ?????
2AD1: 06 2D           ROR $2D
2AD3: 62              ?????
2AD4: 5F              CLRb
2AD5: 79 13 8D        ROL $138D
2AD8: 2C 1F           BGE $2AF9
2ADA: 0A C7           DEC $C7
2ADC: DE DB           LDU $DB
2ADE: 16 CB B9        LBRA $F69A
2AE1: 36 A1           PSHU ,PC,Y,CC
2AE3: FF F9 2C        STU $F92C
2AE6: 13              SYNC
2AE7: 19              DAA
2AE8: 88 17           EORa #$17
2AEA: 1B              ?????
2AEB: 8E 17 41        LDX #$1741
2AEE: 8C 1C 05        CMPX #$1C05
2AF1: 0E 03           JMP $03
2AF3: 15              ?????
2AF4: 02              ?????
2AF5: 29 1C           BVS $2B13
2AF7: 06 0E           ROR $0E
2AF9: 04 14           LSR $14
2AFB: 15              ?????
2AFC: 02              ?????
2AFD: 29 1F           BVS $2B1E
2AFF: 10 C7           ?????
2B01: DE 99           LDU $99
2B03: 14              ?????
2B04: 17 48 8B        LBSR $7392
2B07: 96 9B           LDa $9B
2B09: 96 34           LDa $34
2B0B: A1 D7           CMPa ??
2B0D: 14              ?????
2B0E: 17 8D 09        LBSR $B81A
2B11: 02              ?????
2B12: 46              RORa
2B13: 46              RORa
2B14: 07 81           ASR $81
2B16: AE 00           LDX +$00,X
2B18: 00 90           NEG $90
2B1A: 03 01           COM $01
2B1C: 9F 02           STX $02
2B1E: 07 5F           ASR $5F
2B20: BE 09 15        LDX $0915
2B23: 09 56           ROL $56
2B25: 52              ?????
2B26: 08 81           LSL $81
2B28: 95 0E           BITa $0E
2B2A: 81 92           CMPa #$92
2B2C: 0D 1C           TST $1C
2B2E: 14              ?????
2B2F: 01              ?????
2B30: 13              SYNC
2B31: 9B 1F           ADDa $1F
2B33: 15              ?????
2B34: C7              ?????
2B35: DE 9F           LDU $9F
2B37: 15              ?????
2B38: 23 49           BLS $2B83
2B3A: 50              NEGb
2B3B: 45              ?????
2B3C: 55              ?????
2B3D: 9F 43           STX $43
2B3F: 5E              ?????
2B40: 33 98 C7        LEAU [-$39,X]
2B43: DE 99           LDU $99
2B45: 16 85 BE        LBRA $B106
2B48: 45              ?????
2B49: 9F 0D           STX $0D
2B4B: 81 71           CMPa #$71
2B4D: 01              ?????
2B4E: 13              SYNC
2B4F: 1F 0C           TFR D,??
2B51: 5F              CLRb
2B52: BE 09 15        LDX $0915
2B55: 09 56           ROL $56
2B57: 95 AF           BITa $AF
2B59: 55              ?????
2B5A: 4A              DECa
2B5B: FB ED 0B        ADDb $ED0B
2B5E: 81 5E           CMPa #$5E
2B60: 05              ?????
2B61: 33 42           LEAU +$02,U
2B63: 1F 40           TFR S,D
2B65: 91 1E           CMPa $1E
2B67: 43              COMa
2B68: C2 5B           SBCb #$5B
2B6A: B1 06 9A        CMPa $069A
2B6D: AF 14           STX -$0C,X
2B6F: 91 7A           CMPa $7A
2B71: 7B              ?????
2B72: 14              ?????
2B73: 41              ?????
2B74: 6E 0E           JMP +$0E,X
2B76: 58              ASLb
2B77: 8E 7B DB        LDX #$7BDB
2B7A: 8B 56           ADDa #$56
2B7C: A4 30           ANDa -$10,Y
2B7E: 79 AB BB        ROL $ABBB
2B81: 09 9A           ROL $9A
2B83: 2F 17           BLE $2B9C
2B85: 74 C0 96        LSR $C096
2B88: 96 DB           LDa $DB
2B8A: 9C 34           CMPX $34
2B8C: A1 D7           CMPa ??
2B8E: 14              ?????
2B8F: 16 8D C4        LBRA $B956
2B92: 16 51 18        LBRA $7CAD
2B95: 59              ROLb
2B96: C2 46           SBCb #$46
2B98: 7A 8F 16        DEC $8F16
2B9B: F3 5F 4E        ADDD $5F4E
2B9E: 45              ?????
2B9F: 39              RTS
2BA0: 9E 7F           LDX $7F
2BA2: BF EC DA        STX $ECDA
2BA5: 66 20           ROR +$00,Y
2BA7: 1F 1E           TFR X,??
2BA9: FB 1B B9        ADDb $1BB9
2BAC: 6E D6           JMP [A,U]
2BAE: CE 2F 7B        LDU #$2F7B
2BB1: 11 58           ?????
2BB3: 86 64           LDa #$64
2BB5: 8E 5F 91        LDX #$5F91
2BB8: 7A FB 17        DEC $FB17
2BBB: 53              COMb
2BBC: BE C7 DE        LDX $C7DE
2BBF: D0 15           SUBb $15
2BC1: 74 66 C4        LSR $66C4
2BC4: 7A 6C B5        DEC $6CB5
2BC7: 99 22           ADCa $22
2BC9: 1F 20           TFR Y,D
2BCB: 3A              ABX
2BCC: 1E 73           EXG ??,U
2BCE: 49              ROLa
2BCF: 2F 49           BLE $2C1A
2BD1: 51              ?????
2BD2: 18              ?????
2BD3: 46              RORa
2BD4: C2 50           SBCb #$50
2BD6: 9F CA           STX $CA
2BD8: 6A 2F           DEC +$0F,Y
2BDA: 62              ?????
2BDB: 89 00           ADCa #$00
2BDD: D9 9C           ADCb $9C
2BDF: F4 72 5B        ANDb $725B
2BE2: 5E              ?????
2BE3: 1B              ?????
2BE4: A1 6E           CMPa +$0E,S
2BE6: 4D              TSTa
2BE7: 11 A0           ?????
2BE9: E3 06           ADDD +$06,X
2BEB: FF 80 D0        STU $80D0
2BEE: 0D 80           TST $80
2BF0: CD              ?????
2BF1: 1F 80           TFR A,D
2BF3: B4 FD 1B        ANDa $FD1B
2BF6: 43              COMa
2BF7: 90 6B           SUBa $6B
2BF9: 68 F3           LSL [,--S]
2BFB: 78 9F 77        LSL $9F77
2BFE: 81 15           CMPa #$15
2C00: 91 7A           CMPa $7A
2C02: 89 17           ADCa #$17
2C04: 9B 15           ADDa $15
2C06: 5B              ?????
2C07: CA 6B           ORb #$6B
2C09: BF 58 6D        STX $586D
2C0C: 5B              ?????
2C0D: 5E              ?????
2C0E: 1B              ?????
2C0F: A1 48           CMPa +$08,U
2C11: 45              ?????
2C12: 00 B3           NEG $B3
2C14: 4E              ?????
2C15: BD 49 16        JSR $4916
2C18: 06 4F           ROR $4F
2C1A: FB 9F E3        ADDb $9FE3
2C1D: 06 DB           ROR $DB
2C1F: 72              ?????
2C20: 03 BA           COM $BA
2C22: A5 54           BITa -$0C,U
2C24: 51              ?????
2C25: 18              ?????
2C26: 59              ROLb
2C27: C2 82           SBCb #$82
2C29: 7B              ?????
2C2A: A3 15           SUBD -$0B,X
2C2C: CA B5           ORb #$B5
2C2E: E9 DE           ADCb ??
2C30: 90 14           SUBa $14
2C32: 1B              ?????
2C33: 58              ASLb
2C34: 1B              ?????
2C35: A1 55           CMPa -$0B,U
2C37: A4 D1           ANDa [,U++]
2C39: B5 97 C6        BITa $97C6
2C3C: FA 17 83        ORb $1783
2C3F: 61              ?????
2C40: C7              ?????
2C41: DE 99           LDU $99
2C43: 14              ?????
2C44: 17 48 F3        LBSR $753A
2C47: 9B C7           ADDa $C7
2C49: DE 4F           LDU $4F
2C4B: 15              ?????
2C4C: 33 61           LEAU +$01,S
2C4E: 3F              SWI1
2C4F: B9 FA 62        ADCa $FA62
2C52: 73 49 8E        COM $498E
2C55: 7A 50 79        DEC $5079
2C58: 2F 62           BLE $2CBC
2C5A: B3 9A 6B        SUBD $9A6B
2C5D: BF C7 DE        STX $C7DE
2C60: 95 AF           BITa $AF
2C62: 3C C6           CWAI #C6
2C64: 30 A1           LEAX ,Y++ 
2C66: 90 5A           SUBa $5A
2C68: EF 6E           STU +$0E,S
2C6A: 51              ?????
2C6B: 18              ?????
2C6C: 50              NEGb
2C6D: C2 03           SBCb #$03
2C6F: A1 9B           CMPa [D,X]
2C71: 53              COMb
2C72: 89 4E           ADCa #$4E
2C74: 73 9E 03        COM $9E03
2C77: A0 C7           SUBa ??
2C79: DE 89           LDU $89
2C7B: AF 80           STX ,X+
2C7D: A1 04           CMPa +$04,X
2C7F: EE 73           LDU -$0D,S
2C81: C6 73           LDb #$73
2C83: 7B              ?????
2C84: 77 5B 05        ASR $5B05
2C87: B9 15 BC        ADCa $15BC
2C8A: 2F 60           BLE $2CEC
2C8C: 89 17           ADCa #$17
2C8E: B9 14 5F        ADCa $145F
2C91: BE 9B AF        LDX $9BAF
2C94: 3F              SWI1
2C95: A1 51           CMPa -$0F,U
2C97: 18              ?????
2C98: 48              ASLa
2C99: C2 2E           SBCb #$2E
2C9B: 60 43           NEG +$03,U
2C9D: 16 9B 85        LBRA $C825
2CA0: 10 D0           ?????
2CA2: F4 59 91        ANDb $5991
2CA5: 7A FF F9        DEC $FFF9
2CA8: 1C 05           ANDCC #$05
2CAA: 0E 03           JMP $03
2CAC: 15              ?????
2CAD: 02              ?????
2CAE: 29 1C           BVS $2CCC
2CB0: 06 0E           ROR $0E
2CB2: 04 14           LSR $14
2CB4: 15              ?????
2CB5: 02              ?????
2CB6: 29 2C           BVS $2CE4
2CB8: 13              SYNC
2CB9: 17 3A 13        LBSR $66CF
2CBC: 19              DAA
2CBD: 88 0B           EORa #$0B
2CBF: 01              ?????
2CC0: 9A 09           ORa $09
2CC2: 02              ?????
2CC3: 46              RORa
2CC4: 46              RORa
2CC5: 25 0C           BCS $2CD3
2CC7: FF 00 80        STU $0080
2CCA: 07 01           ASR $01
2CCC: A4 02           ANDa +$02,X
2CCE: 04 0E           LSR $0E
2CD0: D0 0B           SUBb $0B
2CD2: 8E 2A 0B        LDX #$2A0B
2CD5: FF 00 80        STU $0080
2CD8: 07 01           ASR $01
2CDA: A4 02           ANDa +$02,X
2CDC: 03 01           COM $01
2CDE: B3 4D 2B        SUBD $4D2B
2CE1: 09 FF           ROL $FF
2CE3: 00 80           NEG $80
2CE5: 02              ?????
2CE6: 04 89           LSR $89
2CE8: 67 A3           ASR ,--Y
2CEA: A0 2C           SUBa +$0C,Y
2CEC: 08 FF           LSL $FF
2CEE: 00 80           NEG $80
2CF0: 02              ?????
2CF1: 03 23           COM $23
2CF3: 63 54           COM -$0C,U
2CF5: 30 0C           LEAX +$0C,X
2CF7: FF 00 80        STU $0080
2CFA: 07 01           ASR $01
2CFC: A4 02           ANDa +$02,X
2CFE: 04 44           LSR $44
2D00: 55              ?????
2D01: 74 98 33        LSR $9833
2D04: 0D FF           TST $FF
2D06: 00 80           NEG $80
2D08: 07 01           ASR $01
2D0A: A4 02           ANDa +$02,X
2D0C: 05              ?????
2D0D: 4E              ?????
2D0E: 72              ?????
2D0F: B3 8E 59        SUBD $8E59
2D12: 36 0B           PSHU ,DP,A,CC
2D14: FF 00 80        STU $0080
2D17: 02              ?????
2D18: 06 9E           ROR $9E
2D1A: 61              ?????
2D1B: D0 B0           SUBb $B0
2D1D: 9B 53           ADDa $53
2D1F: 3B              RTI
2D20: 0A FF           DEC $FF
2D22: 00 80           NEG $80
2D24: 02              ?????
2D25: 05              ?????
2D26: AB 53           ADDa -$0D,U
2D28: 90 8C           SUBa $8C
2D2A: 47              ASRa
2D2B: 1F 09           TFR D,B
2D2D: 13              SYNC
2D2E: 00 C0           NEG $C0
2D30: 02              ?????
2D31: 04 50           LSR $50
2D33: 72              ?????
2D34: 0B              ?????
2D35: 5C              INCb
2D36: 20 03           BRA $2D3B
2D38: 00 00           NEG $00
2D3A: 80 17           SUBa #$17
2D3C: 11 82           ?????
2D3E: 00 A0           NEG $A0
2D40: 03 01           COM $01
2D42: 9D 07           JSR $07
2D44: 01              ?????
2D45: B0 02 06        SUBa $0206
2D48: 8F              ?????
2D49: 4E              ?????
2D4A: 52              ?????
2D4B: 5E              ?????
2D4C: 46              RORa
2D4D: 7A 3C 03        DEC $3C03
2D50: 00 00           NEG $00
2D52: 00 16           NEG $16
2D54: 4B              ?????
2D55: 82 00           SBCa #$00
2D57: 80 02           SUBa #$02
2D59: 05              ?????
2D5A: 66 B1           ROR [,Y++]
2D5C: 17 16 59        LBSR $43B8
2D5F: 01              ?????
2D60: 01              ?????
2D61: 13              SYNC
2D62: 07 3C           ASR $3C
2D64: 0E 3A           JMP $3A
2D66: 0D 11           TST $11
2D68: 0A 43           DEC $43
2D6A: 09 16           ROL $16
2D6C: 03 82           COM $82
2D6E: 3B              RTI
2D6F: 03 00           COM $00
2D71: 14              ?????
2D72: 17 3B 00        LBSR $6875
2D75: 17 14 13        LBSR $418B
2D78: B1 0D 24        CMPa $0D24
2D7B: 0A 05           DEC $05
2D7D: 04 20           LSR $20
2D7F: C7              ?????
2D80: DE D3           LDU $D3
2D82: 14              ?????
2D83: 90 96           SUBa $96
2D85: F3 A0 85        ADDD $A085
2D88: A6 44           LDa +$04,U
2D8A: B8 FB 8E        EORa $FB8E
2D8D: 63 B1           COM [,Y++]
2D8F: 13              SYNC
2D90: 54              LSRb
2D91: 9E 7A           LDX $7A
2D93: D6 9C           LDb $9C
2D95: 56              RORb
2D96: 72              ?????
2D97: 83 17 7B        SUBd #$177B
2D9A: 9B 7E           ADDa $7E
2D9C: 74 EB 5D        LSR $EB5D
2D9F: B2 08 20        SBCa $0820
2DA2: 00 00           NEG $00
2DA4: A0 02           SUBa +$02,X
2DA6: 06 E3           ROR $E3
2DA8: 59              ROLb
2DA9: 06 58           ROR $58
2DAB: EB 9E           ADDb ??
2DAD: 03 13           COM $13
2DAF: 04 11           LSR $11
2DB1: 5F              CLRb
2DB2: BE 5B B1        LDX $5BB1
2DB5: 4B              ?????
2DB6: 7B              ?????
2DB7: 46              RORa
2DB8: 45              ?????
2DB9: 86 5F           LDa #$5F
2DBB: 09 15           ROL $15
2DBD: CA 6A           ORb #$6A
2DBF: 2F 62           BLE $2E23
2DC1: 2E 0B           BGT $2DCE
2DC3: 42              ?????
2DC4: 00 00           NEG $00
2DC6: 8A 07           ORa #$07
2DC8: 30 0D           LEAX +$0D,X
2DCA: 2E 0A           BGT $2DD6
2DCC: 11 04           ?????
2DCE: 2A 5F           BPL $2E2F
2DD0: BE 57 17        LDX $5717
2DD3: AF 55           STX -$0B,U
2DD5: 06 BC           ROR $BC
2DD7: 44              LSRa
2DD8: A0 D5           SUBa [B,U]
2DDA: 15              ?????
2DDB: 66 17           ROR -$09,X
2DDD: DD C3           STD $C3
2DDF: 5B              ?????
2DE0: F4 1B A1        ANDb $1BA1
2DE3: 2F 49           BLE $2E2E
2DE5: 99 16           ADCa $16
2DE7: 15              ?????
2DE8: BC F9 BF        CMPX $F9BF
2DEB: AB 98 99        ADDa [-$67,X]
2DEE: 61              ?????
2DEF: 7A C4 89        DEC $C489
2DF2: 17 C2 16        LBSR $F00B
2DF5: 83 61 97        SUBd #$6197
2DF8: 7B              ?????
2DF9: 02              ?????
2DFA: 08 A5           LSL $A5
2DFC: B7 76 B1        STa $76B1
2DFF: 09 15           ROL $15
2E01: A3 A0           SUBD ,Y+
2E03: 01              ?????
2E04: 01              ?????
2E05: 3D              MUL
2E06: 0B              ?????
2E07: 76 00 00        ROR $0000
2E0A: 8A 02           ORa #$02
2E0C: 08 4B           LSL $4B
2E0E: A4 BF 9A 06     ANDa [$9A06]
2E12: 58              ASLb
2E13: 44              LSRa
2E14: A0 03           SUBa +$03,X
2E16: 24 04           BCC $2E1C
2E18: 22 03           BHI $2E1D
2E1A: A0 5F           SUBa -$01,U
2E1C: BE 99 16        LDX $9916
2E1F: C2 B3           SBCb #$B3
2E21: F3 17 F3        ADDD $17F3
2E24: 8C 4B 7B        CMPX #$4B7B
2E27: 0F A0           CLR $A0
2E29: B8 16 E3        EORa $16E3
2E2C: 16 15 53        LBRA $4382
2E2F: 2D B9           BLT $2DEA
2E31: D2 B5           SBCb $B5
2E33: D0 47           SUBb $47
2E35: E6 BD 09 15     LDb [$0915,PC]
2E39: BD A0 07        JSR $A007
2E3C: 3E              RESET*
2E3D: 0D 3C           TST $3C
2E3F: 0E 0A           JMP $0A
2E41: 0A 11           DEC $11
2E43: 0A 3A           DEC $3A
2E45: 0A 41           DEC $41
2E47: 0A 42           DEC $42
2E49: 0A 40           DEC $40
2E4B: 04 2D           LSR $2D
2E4D: 5F              CLRb
2E4E: BE DB 16        LDX $DB16
2E51: 9E 7A           LDX $7A
2E53: F3 5F 81        ADDD $5F81
2E56: 5B              ?????
2E57: 91 AF           CMPa $AF
2E59: F0 A4 D6        SUBb $A4D6
2E5C: B5 D4 9C        BITa $D49C
2E5F: CF              ?????
2E60: 62              ?????
2E61: 33 48           LEAU +$08,U
2E63: 83 48 55        SUBd #$4855
2E66: 62              ?????
2E67: DF 48           STU $48
2E69: 39              RTS
2E6A: 17 7F C6        LBSR $AE33
2E6D: DB 06           ADDb $06
2E6F: 1B              ?????
2E70: A1 58           CMPa -$08,U
2E72: 72              ?????
2E73: 47              ASRa
2E74: 5E              ?????
2E75: 53              COMb
2E76: B7 E6 A4        STa $E6A4
2E79: 21 24           BRN $2E9F
2E7B: 01              ?????
2E7C: 01              ?????
2E7D: 3E              RESET*
2E7E: 0B              ?????
2E7F: 3E              RESET*
2E80: 00 00           NEG $00
2E82: 80 02           SUBa #$02
2E84: 08 4B           LSL $4B
2E86: A4 BF 9A 06     ANDa [$9A06]
2E8A: 58              ASLb
2E8B: 44              LSRa
2E8C: A0 07           SUBa +$07,X
2E8E: 2C 0D           BGE $2E9D
2E90: 2A 0E           BPL $2EA0
2E92: 0A 0A           DEC $0A
2E94: 11 0A           ?????
2E96: 3A              ABX
2E97: 0A 40           DEC $40
2E99: 0A 41           DEC $41
2E9B: 0A 42           DEC $42
2E9D: 04 1C           LSR $1C
2E9F: 2F 49           BLE $2EEA
2EA1: 51              ?????
2EA2: 18              ?????
2EA3: 45              ?????
2EA4: C2 DC           SBCb #$DC
2EA6: B0 C3 DA        SUBa $C3DA
2EA9: 73 7B 4B        COM $7B4B
2EAC: 7B              ?????
2EAD: F5 81 03        BITb $8103
2EB0: BC DB 16        CMPX $DB16
2EB3: 9E 7A           LDX $7A
2EB5: F3 5F 81        ADDD $5F81
2EB8: 5B              ?????
2EB9: 2B AF           BMI $2E6A
2EBB: 01              ?????
2EBC: 01              ?????
2EBD: 3E              RESET*
2EBE: 0B              ?????
2EBF: 12              NOP 
2EC0: 99 00           ADCa $00
2EC2: 8B 03           ADDa #$03
2EC4: 01              ?????
2EC5: 86 01           LDa #$01
2EC7: 01              ?????
2EC8: 14              ?????
2EC9: 02              ?????
2ECA: 07 AF           ASR $AF
2ECC: 6E 83           JMP ,--X
2ECE: 61              ?????
2ECF: 81 5B           CMPa #$5B
2ED1: 52              ?????
2ED2: 16 4B 8C        LBRA $7A61
2ED5: 00 80           NEG $80
2ED7: 02              ?????
2ED8: 06 AF           ROR $AF
2EDA: 6E 83           JMP ,--X
2EDC: 61              ?????
2EDD: BB 85 01        ADDa $8501
2EE0: 01              ?????
2EE1: 14              ?????
2EE2: 07 3B           ASR $3B
2EE4: 0E 39           JMP $39
2EE6: 0D 11           TST $11
2EE8: 0A 43           DEC $43
2EEA: 09 16           ROL $16
2EEC: 03 8C           COM $8C
2EEE: 41              ?????
2EEF: 03 8E           COM $8E
2EF1: 1B              ?????
2EF2: 17 41 00        LBSR $6FF5
2EF5: 17 1B 13        LBSR $4A0B
2EF8: B1 0D 23        CMPa $0D23
2EFB: 0A 05           DEC $05
2EFD: 04 1F           LSR $1F
2EFF: C7              ?????
2F00: DE D3           LDU $D3
2F02: 14              ?????
2F03: 90 96           SUBa $96
2F05: F3 A0 63        ADDD $A063
2F08: B1 13 54        CMPa $1354
2F0B: 5F              CLRb
2F0C: BE 84 15        LDX $8415
2F0F: 30 60           LEAX +$00,S
2F11: 17 16 48        LBSR $455C
2F14: DB FF           ADDb $FF
2F16: B2 C7 16        SBCa $C716
2F19: 0A BC           DEC $BC
2F1B: 2F 62           BLE $2F7F
2F1D: 2E B2           BGT $2ED1
2F1F: 42              ?????
2F20: 03 18           COM $18
2F22: 00 00           NEG $00
2F24: 00 84           NEG $84
2F26: 75              ?????
2F27: 0E 84           JMP $84
2F29: 72              ?????
2F2A: 0D 28           TST $28
2F2C: 0E 08           JMP $08
2F2E: 0A 01           DEC $01
2F30: 0A 02           DEC $02
2F32: 0A 03           DEC $03
2F34: 0A 04           DEC $04
2F36: 0E 1C           JMP $1C
2F38: 13              SYNC
2F39: 0D 19           TST $19
2F3B: 20 13           BRA $2F50
2F3D: 04 15           LSR $15
2F3F: C7              ?????
2F40: DE F3           LDU $F3
2F42: 17 CB 8C        LBSR $FAD1
2F45: CF              ?????
2F46: 47              ASRa
2F47: F5 8B D3        BITb $8BD3
2F4A: B8 D0 15        EORa $D015
2F4D: 6B              ?????
2F4E: BF 59 45        STX $5945
2F51: 46              RORa
2F52: 48              ASLa
2F53: 2E 0B           BGT $2F60
2F55: 84 45           ANDa #$45
2F57: 0A 05           DEC $05
2F59: 07 0E           ASR $0E
2F5B: 05              ?????
2F5C: A2 13           SBCa -$0D,X
2F5E: 8F              ?????
2F5F: 14              ?????
2F60: 0C 43           INC $43
2F62: 0D 0E           TST $0E
2F64: 0B              ?????
2F65: A2 13           SBCa -$0D,X
2F67: 0D 03           TST $03
2F69: 1B              ?????
2F6A: 14              ?????
2F6B: 8F              ?????
2F6C: 0D 02           TST $02
2F6E: 1A 8F           ORCC #$8F
2F70: 06 34           ROR $34
2F72: 0E 32           JMP $32
2F74: 0D 0E           TST $0E
2F76: 1A 18           ORCC #$18
2F78: 14              ?????
2F79: 08 37           LSL $37
2F7B: 10 04           ?????
2F7D: 06 F9           ROR $F9
2F7F: 5B              ?????
2F80: 9F A6           STX $A6
2F82: 9B 5D           ADDa $5D
2F84: 0D 11           TST $11
2F86: 14              ?????
2F87: 08 37           LSL $37
2F89: 04 0C           LSR $0C
2F8B: C7              ?????
2F8C: DE 09           LDU $09
2F8E: 15              ?????
2F8F: E6 96           LDb [A,X]
2F91: 9B 15           ADDa $15
2F93: 5B              ?????
2F94: CA 71           ORb #$71
2F96: 7B              ?????
2F97: 04 0D           LSR $0D
2F99: C7              ?????
2F9A: DE 57           LDU $57
2F9C: 17 5B 61        LBSR $8B00
2F9F: 95 5A           BITa $5A
2FA1: 35 6F           PULS ,CC,A,B,DP,Y,U
2FA3: E6 BD 2E 11     LDb [$2E11,PC]
2FA7: 15              ?????
2FA8: 0E 13           JMP $13
2FAA: 13              SYNC
2FAB: 92 0D           SBCa $0D
2FAD: 0D 1A           TST $1A
2FAF: 15              ?????
2FB0: 01              ?????
2FB1: A8 04           EORa +$04,X
2FB3: 07 4B           ASR $4B
2FB5: 7B              ?????
2FB6: 75              ?????
2FB7: 8D A6           BSR $2F5F
2FB9: 85 2E           BITa #$2E
2FBB: A5 A6           BITa A,Y
2FBD: 3A              ABX
2FBE: 12              NOP 
2FBF: 0E 10           JMP $10
2FC1: 0D 03           TST $03
2FC3: 1B              ?????
2FC4: 14              ?????
2FC5: 8F              ?????
2FC6: 13              SYNC
2FC7: 92 A5           SBCa $A5
2FC9: A7 0D           STa +$0D,X
2FCB: 04 15           LSR $15
2FCD: 01              ?????
2FCE: 2A 0C           BPL $2FDC
2FD0: A6 40           LDa +$00,U
2FD2: 24 0E           BCC $2FE2
2FD4: 22 13           BHI $2FE9
2FD6: 92 0D           SBCa $0D
2FD8: 0E 1A           JMP $1A
2FDA: 15              ?????
2FDB: 02              ?????
2FDC: A8 04           EORa +$04,X
2FDE: 08 4B           LSL $4B
2FE0: 7B              ?????
2FE1: 06 9A           ROR $9A
2FE3: C2 16           SBCb #$16
2FE5: A7 61           STa +$01,S
2FE7: 0D 0E           TST $0E
2FE9: 29 A8           BVS $2F93
2FEB: 04 0A           LSR $0A
2FED: 4B              ?????
2FEE: 7B              ?????
2FEF: 09 9A           ROL $9A
2FF1: DE 14           LDU $14
2FF3: D7 A0           STb $A0
2FF5: 9B 5D           ADDa $5D
2FF7: 42              ?????
2FF8: 2F 0E           BLE $3008
2FFA: 2D 0D           BLT $3009
2FFC: 03 1B           COM $1B
2FFE: 14              ?????
2FFF: 8F              ?????
3000: 13              SYNC
3001: 92 0D           SBCa $0D
3003: 11 1A           ?????
3005: 14              ?????
3006: 15              ?????
3007: 01              ?????
3008: A8 04           EORa +$04,X
300A: 0A 4B           DEC $4B
300C: 7B              ?????
300D: 06 9A           ROR $9A
300F: 49              ROLa
3010: 16 97 54        LBRA $C767
3013: 9B 5D           ADDa $5D
3015: A5 A7           BITa ??
3017: 0D 0F           TST $0F
3019: 2A A8           BPL $2FC3
301B: 04 0B           LSR $0B
301D: 4B              ?????
301E: 7B              ?????
301F: 09 9A           ROL $9A
3021: B0 17 75        SUBa $1775
3024: 8D A6           BSR $2FCC
3026: 85 2E           BITa #$2E
3028: 41              ?????
3029: 46              RORa
302A: 0E 44           JMP $44
302C: 0D 03           TST $03
302E: 1B              ?????
302F: 14              ?????
3030: 8F              ?????
3031: 13              SYNC
3032: 92 A5           SBCa $A5
3034: 0D 17           TST $17
3036: 14              ?????
3037: 09 14           ROL $14
3039: 04 0A           LSR $0A
303B: C7              ?????
303C: DE D3           LDU $D3
303E: 14              ?????
303F: E6 96           LDb [A,X]
3041: 49              ROLa
3042: 16 8B 54        LBRA $BB99
3045: A8 04           EORa +$04,X
3047: 03 56           COM $56
3049: D1 48           CMPb $48
304B: A9 8B           ADCa D,X
304D: 0D 11           TST $11
304F: 1A 15           ORCC #$15
3051: 01              ?????
3052: A8 04           EORa +$04,X
3054: 0B              ?????
3055: 4B              ?????
3056: 7B              ?????
3057: 06 9A           ROR $9A
3059: B0 17 75        SUBa $1775
305C: 8D A6           BSR $3004
305E: 85 2E           BITa #$2E
3060: 0D 0E           TST $0E
3062: 2A A8           BPL $300C
3064: 04 0A           LSR $0A
3066: 4B              ?????
3067: 7B              ?????
3068: 09 9A           ROL $9A
306A: 49              ROLa
306B: 16 97 54        LBRA $C7C2
306E: 9B 5D           ADDa $5D
3070: 12              NOP 
3071: 21 0E           BRN $3081
3073: 1F 13           TFR X,U
3075: 0D 1C           TST $1C
3077: 04 13           LSR $13
3079: 33 D1           LEAU [,U++]
307B: 09 15           ROL $15
307D: E6 96           LDb [A,X]
307F: 51              ?????
3080: 18              ?????
3081: 4E              ?????
3082: C2 98           SBCb #$98
3084: 5F              CLRb
3085: 56              RORb
3086: 5E              ?????
3087: DB 72           ADDb $72
3089: 81 A6           CMPa #$A6
308B: 52              ?????
308C: 11 04           ?????
308E: 04 49           LSR $49
3090: 48              ASLa
3091: 7F 98 09        CLR $9809
3094: 80 A1           SUBa #$A1
3096: 0E 80           JMP $80
3098: 9E 14           LDX $14
309A: 1B              ?????
309B: 14              ?????
309C: 0E 05           JMP $05
309E: 09 37           ROL $37
30A0: 09 00           ROL $00
30A2: 8F              ?????
30A3: 0E 80           JMP $80
30A5: 84 0D           ANDa #$0D
30A7: 1A 14           ORCC #$14
30A9: 15              ?????
30AA: 40              NEGa
30AB: 14              ?????
30AC: 09 00           ROL $00
30AE: 04 0A           LSR $0A
30B0: C7              ?????
30B1: DE D3           LDU $D3
30B3: 14              ?????
30B4: E6 96           LDb [A,X]
30B6: AF 15           STX -$0B,X
30B8: B3 B3 A8        SUBD $B3A8
30BB: 04 03           LSR $03
30BD: 56              RORb
30BE: D1 48           CMPb $48
30C0: A9 8B           ADCa D,X
30C2: 13              SYNC
30C3: 0D 1C           TST $1C
30C5: 1A 14           ORCC #$14
30C7: 15              ?????
30C8: 10 04           ?????
30CA: 14              ?????
30CB: 73 7B 77        COM $7B77
30CE: 5B              ?????
30CF: D0 B5           SUBb $B5
30D1: C9 9C           ADCb #$9C
30D3: 36 A0           PSHU ,PC,Y
30D5: 89 17           ADCa #$17
30D7: 96 14           LDa $14
30D9: 45              ?????
30DA: BD D6 83        JSR $D683
30DD: DB 72           ADDb $72
30DF: 11 8B           ?????
30E1: 0D 47           TST $47
30E3: 1A 0E           ORCC #$0E
30E5: 04 09           LSR $09
30E7: 37 09           PULU ,CC,DP
30E9: 00 0B           NEG $0B
30EB: 3E              RESET*
30EC: 05              ?????
30ED: 55              ?????
30EE: 13              SYNC
30EF: 0D 11           TST $11
30F1: 04 0D           LSR $0D
30F3: 44              LSRa
30F4: 45              ?????
30F5: 89 8D           ADCa #$8D
30F7: 89 17           ADCa #$17
30F9: 82 17           SBCa #$17
30FB: 44              LSRa
30FC: 5E              ?????
30FD: 93 9E           SUBd $9E
30FF: 21 1D           BRN $311E
3101: 04 AF           LSR $AF
3103: 14              ?????
3104: 04 12           LSR $12
3106: 59              ROLb
3107: 45              ?????
3108: 3E              RESET*
3109: 7A EF 16        DEC $EF16
310C: 1A 98           ORCC #$98
310E: 90 14           SUBa $14
3110: 1B              ?????
3111: 58              ASLb
3112: 1B              ?????
3113: A1 D5           CMPa [B,U]
3115: 92 5B           SBCa $5B
3117: BB FF 10        ADDa $FF10
311A: 0D 0E           TST $0E
311C: 04 0A           LSR $0A
311E: C7              ?????
311F: DE AF           LDU $AF
3121: 14              ?????
3122: 8F              ?????
3123: 48              ASLa
3124: 0A 58           DEC $58
3126: 59              ROLb
3127: 7A 1D 03        DEC $1D03
312A: 0D 0B           TST $0B
312C: A8 04           EORa +$04,X
312E: 08 4B           LSL $4B
3130: 7B              ?????
3131: 92 C5           SBCa $C5
3133: 37 49           PULU ,CC,DP,S
3135: 17 60 0A        LBSR $9142
3138: 01              ?????
3139: 07 15           ASR $15
313B: 26 0E           BNE $314B
313D: 24 13           BCC $3152
313F: 0D 21           TST $21
3141: 04 0A           LSR $0A
3143: 80 5B           SUBa #$5B
3145: F3 23 5B        ADDD $235B
3148: 4D              TSTa
3149: 4E              ?????
314A: B8 F9 8E        EORa $F98E
314D: A8 04           EORa +$04,X
314F: 12              NOP 
3150: 47              ASRa
3151: D2 C8           SBCb $C8
3153: 8B F3           ADDa #$F3
3155: 23 55           BLS $31AC
3157: BD DB BD        JSR $DBBD
315A: 41              ?????
315B: 6E 03           JMP +$03,X
315D: 58              ASLb
315E: 99 9B           ADCa $9B
3160: 5F              CLRb
3161: 4A              DECa
3162: 17 4C 0E        LBSR $7D73
3165: 4A              DECa
3166: 13              SYNC
3167: 0D 22           TST $22
3169: 1A 15           ORCC #$15
316B: 10 04           ?????
316D: 09 46           ROL $46
316F: 77 05 A0        ASR $05A0
3172: 16 BC 90        LBRA $EE05
3175: 73 4B A8        COM $4BA8
3178: 04 11           LSR $11
317A: 4E              ?????
317B: D1 15           CMPb $15
317D: 8A 50           ORa #$50
317F: BD 15 58        JSR $1558
3182: 8E BE 08        LDX #$BE08
3185: 8A BE           ORa #$BE
3187: A0 56           SUBa -$0A,U
3189: 72              ?????
318A: 2E 0D           BGT $3199
318C: 23 04           BLS $3192
318E: 10 CF           ?????
3190: 62              ?????
3191: 8B 96           ADDa #$96
3193: 9B 64           ADDa $64
3195: 1B              ?????
3196: A1 47           CMPa +$07,U
3198: 55              ?????
3199: B3 8B C3        SUBD $8BC3
319C: 54              LSRb
319D: A3 91           SUBD [,X++]
319F: A8 04           EORa +$04,X
31A1: 0E 73           JMP $73
31A3: 7B              ?????
31A4: 47              ASRa
31A5: D2 C8           SBCb $C8
31A7: 8B F3           ADDa #$F3
31A9: 23 EE           BLS $3199
31AB: 72              ?????
31AC: 1B              ?????
31AD: A3 3F           SUBD -$01,Y
31AF: A1 0B           CMPa +$0B,X
31B1: 36 0E           PSHU ,DP,B,A
31B3: 34 13           PSHS ,X,A,CC
31B5: 0D 17           TST $17
31B7: 1A 15           ORCC #$15
31B9: 04 04           LSR $04
31BB: 10 3F           SWI2 
31BD: B9 82 62        ADCa $8262
31C0: 91 7A           CMPa $7A
31C2: D5 15           BITb $15
31C4: 04 18           LSR $18
31C6: 8E 7B 83        LDX #$7B83
31C9: 61              ?????
31CA: 03 A0           COM $A0
31CC: AA 8B           ORa D,X
31CE: 0D 18           TST $18
31D0: 04 14           LSR $14
31D2: 5F              CLRb
31D3: BE 5D B1        LDX $5DB1
31D6: D0 B5           SUBb $B5
31D8: 02              ?????
31D9: A1 91           CMPa [,X++]
31DB: 7A 62 17        DEC $6217
31DE: DB 5F           ADDb $5F
31E0: 33 48           LEAU +$08,U
31E2: B9 46 73        ADCa $4673
31E5: C6 A8           LDb #$A8
31E7: 8B 10           ADDa #$10
31E9: 15              ?????
31EA: 0E 13           JMP $13
31EC: 13              SYNC
31ED: 0D 10           TST $10
31EF: 04 0C           LSR $0C
31F1: 5F              CLRb
31F2: BE 5D B1        LDX $5DB1
31F5: D0 B5           SUBb $B5
31F7: 02              ?????
31F8: A1 91           CMPa [,X++]
31FA: 7A D0 15        DEC $D015
31FD: A8 8B           EORa D,X
31FF: 21 1A           BRN $321B
3201: 0E 18           JMP $18
3203: 0D 05           TST $05
3205: 03 00           COM $00
3207: 3A              ABX
3208: 00 8E           NEG $8E
320A: 0D 0F           TST $0F
320C: 04 0A           LSR $0A
320E: C7              ?????
320F: DE 81           LDU $81
3211: 15              ?????
3212: 04 BC           LSR $BC
3214: 8E 62 47        LDX #$6247
3217: 62              ?????
3218: 17 3A 00        LBSR $6C1B
321B: 22 12           BHI $322F
321D: 04 10           LSR $10
321F: 5B              ?????
3220: E0 27           SUBb +$07,Y
3222: 60 31           NEG -$0F,Y
3224: 60 41           NEG +$01,U
3226: A0 49           SUBa +$09,U
3228: A0 89 D3 89     SUBa $D389,X
322C: D3 69           ADDD $69
322E: CE 23 01        LDU #$2301
3231: 24 25           BCC $3258
3233: 01              ?????
3234: 91 26           CMPa $26
3236: 01              ?????
3237: 91 3D           CMPa $3D
3239: 01              ?????
323A: 91 27           CMPa $27
323C: 0E 0E           JMP $0E
323E: 0C 13           INC $13
3240: 04 09           LSR $09
3242: 25 A1           BCS $31E5
3244: AB 70           ADDa -$10,S
3246: 3B              RTI
3247: 95 77           BITa $77
3249: BF 21 44        STX $2144
324C: 09 04           ROL $04
324E: 07 AF           ASR $AF
3250: 6E 83           JMP ,--X
3252: 62              ?????
3253: C5 98           BITb #$98
3255: 21 45           BRN $329C
3257: 31 0E           LEAY +$0E,X
3259: 2F 13           BLE $326E
325B: 0D 12           TST $12
325D: 1A 15           ORCC #$15
325F: 10 A8           ?????
3261: 04 0C           LSR $0C
3263: 72              ?????
3264: B1 87 8C        CMPa $878C
3267: 33 BB           LEAU [D,Y]
3269: DF 1B           STU $1B
326B: 09 8D           ROL $8D
326D: 63 F4           COM [,S]
326F: 0D 18           TST $18
3271: 04 14           LSR $14
3273: 16 A0 43        LBRA $D2B9
3276: DB E4           ADDb $E4
3278: 14              ?????
3279: 83 4A 01        SUBd #$4A01
327C: 18              ?????
327D: 3E              RESET*
327E: C5 7B           BITb #$7B
3280: 17 CB 8C        LBSR $FE0F
3283: 6B              ?????
3284: BF 5F BE        STX $5FBE
3287: 11 8B           ?????
3289: 46              RORa
328A: 08 04           LSL $04
328C: 06 46           ROR $46
328E: 77 98 C5        ASR $98C5
3291: 5B              ?????
3292: A2 47           SBCa +$07,U
3294: 09 04           ROL $04
3296: 07 29           ASR $29
3298: D1 20           CMPb $20
329A: 16 85 A1        LBRA $B83E
329D: 3F              SWI1
329E: 4A              DECa
329F: 18              ?????
32A0: 0E 16           JMP $16
32A2: 13              SYNC
32A3: 0D 13           TST $13
32A5: 04 11           LSR $11
32A7: 9E 77           LDX $77
32A9: 08 8A           LSL $8A
32AB: C6 9F           LDb #$9F
32AD: 6B              ?????
32AE: A1 C7           CMPa ??
32B0: DE 90           LDU $90
32B2: 14              ?????
32B3: FA DF 2F        ORb $DF2F
32B6: 62              ?????
32B7: 21 49           BRN $3302
32B9: 26 0E           BNE $32C9
32BB: 24 13           BCC $32D0
32BD: 0D 11           TST $11
32BF: 09 00           ROL $00
32C1: A8 04           EORa +$04,X
32C3: 0C 09           INC $09
32C5: 4F              CLRa
32C6: CB B5           ADDb #$B5
32C8: 89 96           ADCa #$96
32CA: 67 B1           ASR [,Y++]
32CC: 90 BE           SUBa $BE
32CE: 5B              ?????
32CF: 70 04 0E        NEG $040E
32D2: 5F              CLRb
32D3: BE 44 DB        LDX $44DB
32D6: 6B              ?????
32D7: A1 83           CMPa ,--X
32D9: 7A AF 6E        DEC $AF6E
32DC: 83 62 CF        SUBd #$62CF
32DF: 98 28           EORa $28
32E1: 0A 0E           DEC $0E
32E3: 08 13           LSL $13
32E5: 0D 04           TST $04
32E7: 1A 15           ORCC #$15
32E9: 10 AD           ?????
32EB: AE 29           LDX +$09,Y
32ED: 0A 0E           DEC $0E
32EF: 08 13           LSL $13
32F1: 0D 04           TST $04
32F3: 1B              ?????
32F4: 15              ?????
32F5: 10 AD           ?????
32F7: AE 2F           LDX +$0F,Y
32F9: 07 04           ASR $04
32FB: 05              ?????
32FC: 9B 29           ADDa $29
32FE: 57              ASRb
32FF: C6 3E           LDb #$3E
3301: 2D 09           BLT $330C
3303: 0E 07           JMP $07
3305: 13              SYNC
3306: 0D 02           TST $02
3308: 1A 8F           ORCC #$8F
330A: 14              ?????
330B: 0C 48           INC $48
330D: 11 0E           ?????
330F: 0F 13           CLR $13
3311: 04 0C           LSR $0C
3313: C7              ?????
3314: DE D3           LDU $D3
3316: 14              ?????
3317: E6 96           LDb [A,X]
3319: 09 15           ROL $15
331B: 82 17           SBCa #$17
331D: 97 49           STa $49
331F: 33 01           LEAU +$01,X
3321: AF 34           STX -$0C,Y
3323: 01              ?????
3324: AF 0D           STX +$0D,X
3326: 2B 0E           BMI $3336
3328: 29 0D           BVS $3337
332A: 25 1A           BCS $3346
332C: 8F              ?????
332D: 0E 21           JMP $21
332F: 0D 1E           TST $1E
3331: 0E 07           JMP $07
3333: 14              ?????
3334: 15              ?????
3335: 10 1B           ?????
3337: 14              ?????
3338: 15              ?????
3339: 40              NEGa
333A: A8 04           EORa +$04,X
333C: 0F 07           CLR $07
333E: 4F              CLRa
333F: 17 98 CA        LBSR $CC0C
3342: B5 37 49        BITa $3749
3345: F5 8B D3        BITb $8BD3
3348: B8 B8 16        EORa $B816
334B: 46              RORa
334C: A9 8B           ADCa D,X
334E: 10 13           ?????
3350: 14              ?????
3351: 0C 0E           INC $0E
3353: 13              SYNC
3354: 0E 11           JMP $11
3356: 13              SYNC
3357: 0D 0E           TST $0E
3359: A9 04           ADCa +$04,X
335B: 0B              ?????
335C: 77 5B 05        ASR $5B05
335F: B9 19 BC        ADCa $19BC
3362: 9E 48           LDX $48
3364: D6 15           LDb $15
3366: 2E 0F           BGT $3377
3368: 17 0E 15        LBSR $4180
336B: 0D 03           TST $03
336D: 1A 14           ORCC #$14
336F: 8F              ?????
3370: 13              SYNC
3371: 0D 0D           TST $0D
3373: A8 04           EORa +$04,X
3375: 08 40           LSL $40
3377: D2 F3           SBCb $F3
3379: 23 16           BLS $3391
337B: 67 D0           ASR [,U+]
337D: 15              ?????
337E: A9 8B           ADCa D,X
3380: 07 1A           ASR $1A
3382: 0D 18           TST $18
3384: 04 15           LSR $15
3386: C7              ?????
3387: DE 94           LDU $94
3389: 14              ?????
338A: 45              ?????
338B: 5E              ?????
338C: 3C 49           CWAI #49
338E: D0 DD           SUBb $DD
3390: D6 6A           LDb $6A
3392: DB 72           ADDb $72
3394: FE 67 89        LDU $6789
3397: 8D 91           BSR $332A
3399: 7A 3A 06        DEC $3A06
339C: 00 88           NEG $88
339E: 36 81           PSHU ,PC,CC
33A0: 14              ?????
33A1: 04 12           LSR $12
33A3: 99 48           ADCa $48
33A5: 5F              CLRb
33A6: BE 95 AF        LDX $95AF
33A9: 8E 91 12        LDX #$9112
33AC: 8A FE           ORa #$FE
33AE: 46              RORa
33AF: F3 5F 01        ADDD $5F01
33B2: B3 DB 95        SUBD $DB95
33B5: 82 11           SBCa #$11
33B7: 04 0F           LSR $0F
33B9: 5F              CLRb
33BA: BE 23 15        LDX $2315
33BD: 15              ?????
33BE: BA B5 D0        ORa $B5D0
33C1: 0A BC           DEC $BC
33C3: 46              RORa
33C4: 48              ASLa
33C5: 1B              ?????
33C6: D0 2E           SUBb $2E
33C8: 83 12 04        SUBd #$1204
33CB: 10 5F           ?????
33CD: BE 99 16        LDX $9916
33D0: C2 B3           SBCb #$B3
33D2: E1 EB           CMPb D,S
33D4: 82 C6           SBCa #$C6
33D6: 9B 15           ADDa $15
33D8: 11 8D           ?????
33DA: 5F              CLRb
33DB: 4A              DECa
33DC: 84 1C           ANDa #$1C
33DE: 04 1A           LSR $1A
33E0: 03 A0           COM $A0
33E2: 5F              CLRb
33E3: BE 61 17        LDX $6117
33E6: 82 C6           SBCa #$C6
33E8: F3 17 F3        ADDD $17F3
33EB: 8C 5F BE        CMPX #$5FBE
33EE: 5B              ?????
33EF: B1 4B 7B        CMPa $4B7B
33F2: 49              ROLa
33F3: 45              ?????
33F4: 67 B1           ASR [,Y++]
33F6: 86 96           LDa #$96
33F8: 44              LSRa
33F9: A0 85           SUBa B,X
33FB: 1B              ?????
33FC: 04 19           LSR $19
33FE: 03 A0           COM $A0
3400: 5F              CLRb
3401: BE 99 16        LDX $9916
3404: C2 B3           SBCb #$B3
3406: F3 17 F3        ADDD $17F3
3409: 8C 5F BE        CMPX #$5FBE
340C: 5B              ?????
340D: B1 4B 7B        CMPa $4B7B
3410: 54              LSRb
3411: 45              ?????
3412: F3 5F 81        ADDD $5F81
3415: 5B              ?????
3416: 52              ?????
3417: 86 1C           LDa #$1C
3419: 04 1A           LSR $1A
341B: 03 A0           COM $A0
341D: 5F              CLRb
341E: BE 99 16        LDX $9916
3421: C2 B3           SBCb #$B3
3423: F3 17 F3        ADDD $17F3
3426: 8C 5F BE        CMPX #$5FBE
3429: 5B              ?????
342A: B1 4B 7B        CMPa $4B7B
342D: 49              ROLa
342E: 45              ?????
342F: 67 B1           ASR [,Y++]
3431: 86 96           LDa #$96
3433: 44              LSRa
3434: A0 87           SUBa ??
3436: 1B              ?????
3437: 04 19           LSR $19
3439: 03 A0           COM $A0
343B: 5F              CLRb
343C: BE 61 17        LDX $6117
343F: 82 C6           SBCa #$C6
3441: F3 17 F3        ADDD $17F3
3444: 8C 5F BE        CMPX #$5FBE
3447: 5B              ?????
3448: B1 4B 7B        CMPa $4B7B
344B: 54              LSRb
344C: 45              ?????
344D: F3 5F 81        ADDD $5F81
3450: 5B              ?????
3451: 52              ?????
3452: 88 1B           EORa #$1B
3454: 04 19           LSR $19
3456: 03 A0           COM $A0
3458: 5F              CLRb
3459: BE 23 15        LDX $2315
345C: F3 B9 0E        ADDD $B90E
345F: D0 16           SUBb $16
3461: 8A F4           ORa #$F4
3463: 72              ?????
3464: 4B              ?????
3465: 5E              ?????
3466: C3 B5 B6        ADDd #$B5B6
3469: 14              ?????
346A: 1B              ?????
346B: C4 81           ANDb #$81
346D: 5B              ?????
346E: 52              ?????
346F: 89 1B           ADCa #$1B
3471: 04 19           LSR $19
3473: 03 A0           COM $A0
3475: 5F              CLRb
3476: BE F7 17        LDX $F717
3479: F3 B9 0E        ADDD $B90E
347C: D0 16           SUBb $16
347E: 8A F4           ORa #$F4
3480: 72              ?????
3481: 4B              ?????
3482: 5E              ?????
3483: C3 B5 B6        ADDd #$B5B6
3486: 14              ?????
3487: 1B              ?????
3488: C4 81           ANDb #$81
348A: 5B              ?????
348B: 52              ?????
348C: 8A 0D           ORa #$0D
348E: 04 0B           LSR $0B
3490: 23 D1           BLS $3463
3492: 13              SYNC
3493: 54              LSRb
3494: 4B              ?????
3495: 7B              ?????
3496: C9 54           ADCb #$54
3498: A6 B7           LDa ??
349A: 2E 8C           BGT $3428
349C: 17 0B 15        LBSR $3FB4
349F: 05              ?????
34A0: 7F 07 04        CLR $0704
34A3: 05              ?????
34A4: 63 BE           COM ??
34A6: CB B5           ADDb #$B5
34A8: 53              COMb
34A9: FF 09 04        STU $0904
34AC: 07 C7           ASR $C7
34AE: DE 94           LDU $94
34B0: 14              ?????
34B1: 4B              ?????
34B2: 5E              ?????
34B3: 4E              ?????
34B4: 8B 04           ADDa #$04
34B6: 04 02           LSR $02
34B8: 3B              RTI
34B9: F4 8D 11        ANDb $8D11
34BC: 0D 0F           TST $0F
34BE: 14              ?????
34BF: 20 38           BRA $34F9
34C1: 15              ?????
34C2: 02              ?????
34C3: AA 04           ORa +$04,X
34C5: 07 4B           ASR $4B
34C7: 7B              ?????
34C8: C9 54           ADCb #$54
34CA: A6 B7           LDa ??
34CC: 2E 8F           BGT $345D
34CE: 4F              CLRa
34CF: 0D 4D           TST $4D
34D1: 0E 4A           JMP $4A
34D3: 2D 37           BLT $350C
34D5: 0D 1A           TST $1A
34D7: 15              ?????
34D8: 10 04           ?????
34DA: 16 46 77        LBRA $7B54
34DD: 05              ?????
34DE: A0 16           SUBa -$0A,X
34E0: BC 90 73        CMPX $9073
34E3: CA 83           ORb #$83
34E5: 59              ROLb
34E6: 5E              ?????
34E7: 46              RORa
34E8: 7A E1 14        DEC $E114
34EB: 5F              CLRb
34EC: A0 D6           SUBa [A,U]
34EE: B0 DB 63        SUBa $DB63
34F1: 0D 1F           TST $1F
34F3: 14              ?????
34F4: 15              ?????
34F5: 20 04           BRA $34FB
34F7: 18              ?????
34F8: C7              ?????
34F9: DE 94           LDU $94
34FB: 14              ?????
34FC: 53              COMb
34FD: 5E              ?????
34FE: D6 C4           LDb $C4
3500: 4B              ?????
3501: 5E              ?????
3502: 13              SYNC
3503: 98 44           EORa $44
3505: A4 DB           ANDa [D,U]
3507: 8B C3           ADDa #$C3
3509: 9E 6F           LDX $6F
350B: B1 53 A1        CMPa $53A1
350E: AB 98 AA        ADDa [-$56,X]
3511: 8B 18           ADDa #$18
3513: 0D 08           TST $08
3515: 0F AA           CLR $AA
3517: 04 04           LSR $04
3519: 4D              TSTa
351A: BD A7 61        JSR $A761
351D: 18              ?????
351E: A2 13           SBCa -$0D,X
3520: 0D 11           TST $11
3522: 1A 18           ORCC #$18
3524: 04 0B           LSR $0B
3526: C7              ?????
3527: DE 8E           LDU $8E
3529: 14              ?????
352A: 63 B1           COM [,Y++]
352C: FB 5C 58        ADDb $5C58
352F: 72              ?????
3530: 45              ?????
3531: AA 8B           ORa D,X
3533: 90 09           SUBa $09
3535: 0B              ?????
3536: 07 0A           ASR $0A
3538: 36 01           PSHU ,CC
353A: 91 37           CMPa $37
353C: 01              ?????
353D: 91 91           CMPa $91
353F: 19              DAA
3540: 1F 17           TFR X,??
3542: FF A5 57        STU $A557
3545: 49              ROLa
3546: B5 17 46        BITa $1746
3549: 5E              ?????
354A: 2F 7B           BLE $35C7
354C: 03 56           COM $56
354E: 1D              SEX
354F: A0 A6           SUBa A,Y
3551: 16 3F BB        LBRA $750F
3554: 11 EE           ?????
3556: 99 AF           ADCa $AF
3558: 2E 92           BGT $34EC
355A: 18              ?????
355B: 0D 16           TST $16
355D: 1A 14           ORCC #$14
355F: 15              ?????
3560: 08 04           LSL $04
3562: 0E C7           JMP $C7
3564: DE D3           LDU $D3
3566: 14              ?????
3567: E6 96           LDb [A,X]
3569: 09 15           ROL $15
356B: 82 17           SBCa #$17
356D: 73 49 6B        COM $496B
3570: BF A8 8B        STX $A88B
3573: 94 80           ANDa $80
3575: 8C 0D 80        CMPX #$0D80
3578: 89 17           ADCa #$17
357A: 1C 00           ANDCC #$00
357C: 17 1D 00        LBSR $527F
357F: 17 1E 00        LBSR $5382
3582: 17 1F 00        LBSR $5485
3585: 17 20 00        LBSR $5588
3588: 17 21 00        LBSR $568B
358B: 17 22 00        LBSR $578E
358E: 17 23 00        LBSR $5891
3591: 17 24 00        LBSR $5994
3594: 17 25 00        LBSR $5A97
3597: 17 26 00        LBSR $5B9A
359A: 17 27 00        LBSR $5C9D
359D: 17 28 00        LBSR $5DA0
35A0: 17 29 00        LBSR $5EA3
35A3: 17 2A 00        LBSR $5FA6
35A6: 17 2B 00        LBSR $60A9
35A9: 17 2C 00        LBSR $61AC
35AC: 17 1B 8E        LBSR $513D
35AF: 17 14 00        LBSR $49B2
35B2: 17 16 81        LBSR $4C36
35B5: 17 3B 82        LBSR $713A
35B8: 17 3D 00        LBSR $72BB
35BB: 17 15 00        LBSR $4ABE
35BE: 17 39 00        LBSR $6EC1
35C1: 17 41 8C        LBSR $7750
35C4: 0B              ?????
35C5: 2B 05           BMI $35CC
35C7: 55              ?????
35C8: 0B              ?????
35C9: 0D 09           TST $09
35CB: 17 15 82        LBSR $4B50
35CE: 1C 1F           ANDCC #$1F
35D0: 95 1C           BITa $1C
35D2: 23 95           BLS $3569
35D4: AB 0E           ADDa +$0E,X
35D6: 0D 0C           TST $0C
35D8: 17 39 82        LBSR $6F5D
35DB: 1C 21           ANDCC #$21
35DD: 95 1C           BITa $1C
35DF: 3D              MUL
35E0: 95 1C           BITa $1C
35E2: 23 95           BLS $3579
35E4: FF 0B 0D        STU $0B0D
35E7: 09 17           ROL $17
35E9: 39              RTS
35EA: 82 1C           SBCa #$1C
35EC: 1F 95           TFR B,PC
35EE: 1C 25           ANDCC #$25
35F0: 95 1C           BITa $1C
35F2: 1D              SEX
35F3: 95 1C           BITa $1C
35F5: 27 95           BEQ $358C
35F7: 1C 29           ANDCC #$29
35F9: 95 1C           BITa $1C
35FB: 2B 95           BMI $3592
35FD: 17 2E 95        LBSR $6495
3600: 00 88           NEG $88
3602: 95 53           BITa $53
3604: 0D 51           TST $51
3606: 2B 0B           BMI $3613
3608: 4E              ?????
3609: 05              ?????
360A: 18              ?????
360B: 05              ?????
360C: 0D 03           TST $03
360E: 19              DAA
360F: 85 10           BITa #$10
3611: 30 05           LEAX +$05,X
3613: 0D 03           TST $03
3615: 19              DAA
3616: 86 10           LDa #$10
3618: 47              ASRa
3619: 05              ?????
361A: 0D 03           TST $03
361C: 19              DAA
361D: 89 10           ADCa #$10
361F: 5E              ?????
3620: 05              ?????
3621: 0D 03           TST $03
3623: 19              DAA
3624: 8B 10           ADDa #$10
3626: 75              ?????
3627: 05              ?????
3628: 0D 03           TST $03
362A: 19              DAA
362B: 8D 10           BSR $363D
362D: 8C 05 0D        CMPX #$050D
3630: 03 19           COM $19
3632: 90 10           SUBa $10
3634: A3 05           SUBD +$05,X
3636: 0D 03           TST $03
3638: 19              DAA
3639: 92 10           SBCa $10
363B: BA 05 0D        ORa $050D
363E: 03 19           COM $19
3640: 96 10           LDa $10
3642: D1 05           CMPb $05
3644: 0D 03           TST $03
3646: 19              DAA
3647: 97 10           STa $10
3649: E8 05           EORb +$05,X
364B: 0D 03           TST $03
364D: 19              DAA
364E: 98 10           EORa $10
3650: FF 05 0D        STU $050D
3653: 03 19           COM $19
3655: 94 10           ANDa $10
3657: A3 61           SUBD +$01,S
3659: 0D 5F           TST $5F
365B: 2C 13           BGE $3670
365D: 19              DAA
365E: 88 1F           EORa #$1F
3660: 59              ROLb
3661: C7              ?????
3662: DE 4F           LDU $4F
3664: 15              ?????
3665: 33 61           LEAU +$01,S
3667: 4B              ?????
3668: 49              ROLa
3669: 69 BE           ROL ??
366B: 7A C4 51        DEC $C451
366E: 18              ?????
366F: 4A              DECa
3670: C2 CF           SBCb #$CF
3672: 49              ROLa
3673: FF 15 F3        STU $15F3
3676: B9 F3 49        ADCa $F349
3679: B0 85 F3        SUBa $85F3
367C: 5F              CLRb
367D: 79 68 43        ROL $6843
3680: 90 CF           SUBa $CF
3682: 17 7B B4        LBSR $B239
3685: 80 8D           SUBa #$8D
3687: C4 6A           ANDb #$6A
3689: F3 46 EF        ADDD $46EF
368C: 5B              ?????
368D: 5B              ?????
368E: 48              ASLa
368F: B9 46 73        ADCa $4673
3692: C6 75           LDb #$75
3694: 5B              ?????
3695: 84 BF           ANDa #$BF
3697: C3 B5 33        ADDd #$B533
369A: 98 46           EORa $46
369C: A4 E6           ANDa A,S
369E: 59              ROLb
369F: 39              RTS
36A0: 17 F5 9F        LBSR $2C42
36A3: 5B              ?????
36A4: F4 34 A1        ANDb $34A1
36A7: 82 17           SBCa #$17
36A9: 29 A1           BVS $364C
36AB: 4D              TSTa
36AC: 75              ?????
36AD: 94 14           ANDa $14
36AF: B3 63 3A        SUBD $633A
36B2: 1E 2F           EXG Y,??
36B4: 62              ?????
36B5: 8F              ?????
36B6: 14              ?????
36B7: B8 15 22        EORa $1522
36BA: 96 62           LDa $62
36BC: 04 60           LSR $60
36BE: 55              ?????
36BF: 45              ?????
36C0: 84 74           ANDa #$74
36C2: 73 C1 F0        COM $C1F0
36C5: 68 7B           LSL -$05,S
36C7: 9B 81           ADDa $81
36C9: 8D 50           BSR $371B
36CB: 86 CF           LDa #$CF
36CD: 6A 83           DEC ,--X
36CF: 48              ASLa
36D0: FB B9 4D        ADDb $B94D
36D3: 98 8F           EORa $8F
36D5: 16 2C 49        LBRA $6321
36D8: DB E0           ADDb $E0
36DA: DB 72           ADDb $72
36DC: 81 8D           CMPa #$8D
36DE: CB 87           ADDb #$87
36E0: 73 49 C7        COM $49C7
36E3: DE FC           LDU $FC
36E5: ED 09           STD +$09,X
36E7: 4F              CLRa
36E8: D0 15           SUBb $15
36EA: 82 17           SBCa #$17
36EC: 52              ?????
36ED: 5E              ?????
36EE: 75              ?????
36EF: B1 8D 61        CMPa $8D61
36F2: 51              ?????
36F3: 5E              ?????
36F4: 90 64           SUBa $64
36F6: E9 48           ADCb +$08,U
36F8: F1 8B 84        CMPb $8B84
36FB: 96 0B           LDa $0B
36FD: A0 54           SUBa -$0C,U
36FF: A4 D9 BD BB     ANDa [$BDBB,U]
3703: 15              ?????
3704: 5B              ?????
3705: 48              ASLa
3706: 5F              CLRb
3707: BE 6B 16        LDX $6B16
370A: 2E 6D           BGT $3779
370C: 35 79           PULS ,CC,DP,X,Y,U
370E: 0E BC           JMP $BC
3710: 86 5F           LDa #$5F
3712: 23 62           BLS $3776
3714: 83 7A 5F        SUBd #$7A5F
3717: BE 01 18        LDX $0118
371A: 7E B2 E3        JMP $B2E3
371D: 06 97           ROR $97
371F: 20 04           BRA $3725
3721: 1E D2           EXG ??,Y
3723: 97 BF           STa $BF
3725: 9F 03           STX $03
3727: A0 4B           SUBa +$0B,U
3729: 7B              ?????
372A: F0 B3 10        SUBb $B310
372D: 99 CA           ADCa $CA
372F: 6A 4B           DEC +$0B,U
3731: 7B              ?????
3732: 50              NEGb
3733: 72              ?????
3734: 0B              ?????
3735: 5C              INCb
3736: 4F              CLRa
3737: A1 96           CMPa [A,X]
3739: AF DB           STX [D,U]
373B: 72              ?????
373C: 0E D0           JMP $D0
373E: 2F 8E           BLE $36CE
3740: 98 80           EORa $80
3742: 80 04           SUBa #$04
3744: 7E 4F 45        JMP $4F45
3747: 83 48 83        SUBd #$4883
374A: 7A 59 45        DEC $5945
374D: 96 73           LDa $73
374F: 48              ASLa
3750: 5E              ?????
3751: F5 B2 33        BITb $B233
3754: 89 44           ADCa #$44
3756: 45              ?????
3757: 2F 62           BLE $37BB
3759: 73 C1 8E        COM $C18E
375C: 48              ASLa
375D: A9 15           ADCa -$0B,X
375F: C3 8B AB        ADDd #$8BAB
3762: 98 52           EORa $52
3764: 45              ?????
3765: 3F              SWI1
3766: 48              ASLa
3767: 3F              SWI1
3768: C0 90           SUBb #$90
376A: 14              ?????
376B: 04 58           LSR $58
376D: F5 B3 15        BITb $B315
3770: 71              ?????
3771: 2F 60           BLE $37D3
3773: D6 B5           LDb $B5
3775: C4 9C           ANDb #$9C
3777: 52              ?????
3778: 5E              ?????
3779: D0 47           SUBb $47
377B: 90 BE           SUBa $BE
377D: D9 6A           ADCb $6A
377F: 56              RORb
3780: 72              ?????
3781: 49              ROLa
3782: 16 A5 9F        LBRA $DD24
3785: 43              COMa
3786: 16 9B 85        LBRA $D30E
3789: 46              RORa
378A: 45              ?????
378B: 44              LSRa
378C: A0 C0           SUBa ,U+
378E: 16 C0 16        LBRA $F7A7
3791: 51              ?????
3792: 5E              ?????
3793: 96 64           LDa $64
3795: DB 72           ADDb $72
3797: 0E D0           JMP $D0
3799: 2F 8E           BLE $3729
379B: 9F 15           STX $15
379D: 49              ROLa
379E: 16 A5 9F        LBRA $DD40
37A1: B2 17 FC        SBCa $17FC
37A4: ED 47           STD +$07,U
37A6: 63 8F 14 7B     COM $147B,X
37AA: 14              ?????
37AB: AB 6E           ADDa +$0E,S
37AD: DB BD           ADDb $BD
37AF: 3E              RESET*
37B0: 49              ROLa
37B1: 35 60           PULS ,Y,U
37B3: AB BB           ADDa [D,Y]
37B5: 8A 91           ORa #$91
37B7: 8B 16           ADDa #$16
37B9: 47              ASRa
37BA: 90 63           SUBa $63
37BC: 63 85           COM B,X
37BE: A5 65           BITa +$05,S
37C0: 49              ROLa
37C1: 6C 9C 99        INC [-$67,PC]
37C4: 22 04           BHI $37CA
37C6: 20 85           BRA $374D
37C8: A5 65           BITa +$05,S
37CA: 49              ROLa
37CB: D5 9C           BITb $9C
37CD: 2F 60           BLE $382F
37CF: D6 B5           LDb $B5
37D1: C4 9C           ANDb #$9C
37D3: 52              ?????
37D4: 5E              ?????
37D5: D0 47           SUBb $47
37D7: 90 BE           SUBa $BE
37D9: C3 6A 09        ADDd #$6A09
37DC: 15              ?????
37DD: A3 A0           SUBD ,Y+
37DF: 03 A0           COM $A0
37E1: 0F A0           CLR $A0
37E3: F3 17 17        ADDD $1717
37E6: 8D 9D           BSR $3785
37E8: 14              ?????
37E9: 04 12           LSR $12
37EB: 5F              CLRb
37EC: BE 5B B1        LDX $5BB1
37EF: 4B              ?????
37F0: 7B              ?????
37F1: 44              LSRa
37F2: 45              ?????
37F3: 67 8E           ASR ??
37F5: E3 16           ADDD -$0A,X
37F7: F3 8C F4        ADDD $8CF4
37FA: 72              ?????
37FB: DB 63           ADDb $63
37FD: 9F 50           STX $50
37FF: 1F 4E           TFR S,??
3801: 55              ?????
3802: 45              ?????
3803: 84 74           ANDa #$74
3805: 73 C1 09        COM $C109
3808: BA AB 54        ORa $AB54
380B: 17 EE 9A        LBSR $26A8
380E: 9A CF           ORa $CF
3810: 49              ROLa
3811: 8F              ?????
3812: 96 83           LDa $83
3814: 48              ASLa
3815: A3 D0           SUBD [,U+]
3817: 10 B2           ?????
3819: C3 6A B6        ADDd #$6AB6
381C: 14              ?????
381D: 36 A0           PSHU ,PC,Y
381F: 59              ROLb
3820: DB 96           ADDb $96
3822: 73 55 5E        COM $555E
3825: 31 C6           LEAY A,U
3827: D3 78           ADDD $78
3829: 09 8A           ROL $8A
382B: 80 A1           SUBa #$A1
382D: 90 14           SUBa $14
382F: 0A 58           DEC $58
3831: BE 9F 91        LDX $9F91
3834: 7A 7B 14        DEC $7B14
3837: 54              LSRb
3838: 8B 9B           ADDa #$9B
383A: 6C 12           INC -$0E,X
383C: 76 7F 9E        ROR $7F9E
383F: AB B2           ADDa [,-Y]
3841: CB 51           ADDb #$51
3843: D5 B5           BITb $B5
3845: 54              LSRb
3846: BD 91 7A        JSR $917A
3849: 96 14           LDa $14
384B: 51              ?????
384C: 18              ?????
384D: DB C7           ADDb $C7
384F: 9A 80           ORa $80
3851: C5 0E           BITb #$0E
3853: 80 C2           SUBa #$C2
3855: 0D 20           TST $20
3857: 0E 04           JMP $04
3859: 0A 46           DEC $46
385B: 0A 47           DEC $47
385D: 1F 18           TFR X,A
385F: 91 1E           CMPa $1E
3861: 59              ROLb
3862: C2 46           SBCb #$46
3864: 7A 9B 15        DEC $9B15
3867: 5B              ?????
3868: CA C7           ORb #$C7
386A: DE 83           LDU $83
386C: AF A9 9A 23     STX $9A23,Y
3870: 62              ?????
3871: 83 7A 8F        SUBd #$7A8F
3874: BE DC 63        LDX $DC63
3877: 0D 13           TST $13
3879: 0A 49           DEC $49
387B: 1F 0F           TFR D,??
387D: 5F              CLRb
387E: BE 49 DB        LDX $49DB
3881: 67 B1           ASR [,Y++]
3883: 07 BC           ASR $BC
3885: DA 46           ORb $46
3887: C6 16           LDb #$16
3889: F4 72 2E        ANDb $722E
388C: 0D 11           TST $11
388E: 0A 4A           DEC $4A
3890: 1F 0D           TFR D,??
3892: FD 1C 0E        STD $1C0E
3895: EE 86           LDU A,X
3897: 5F              CLRb
3898: 82 17           SBCa #$17
389A: 59              ROLb
389B: 5E              ?????
389C: 5F              CLRb
389D: 4A              DECa
389E: 22 0D           BHI $38AD
38A0: 18              ?????
38A1: 0A 2F           DEC $2F
38A3: 1F 14           TFR X,S
38A5: 91 1E           CMPa $1E
38A7: 59              ROLb
38A8: C2 2E           SBCb #$2E
38AA: A1 45           CMPa +$05,U
38AC: 5B              ?????
38AD: 0E BC           JMP $BC
38AF: 98 5F           EORa $5F
38B1: 4F              CLRa
38B2: 5E              ?????
38B3: 4A              DECa
38B4: 5E              ?????
38B5: 2F 62           BLE $3919
38B7: E3 06           ADDD +$06,X
38B9: 0D 5C           TST $5C
38BB: 1F 0F           TFR D,??
38BD: 5F              CLRb
38BE: BE B4 16        LDX $B416
38C1: 03 BA           COM $BA
38C3: D6 97           LDb $97
38C5: 54              LSRb
38C6: 5E              ?????
38C7: E6 61           LDb +$01,S
38C9: 4B              ?????
38CA: DB 53           ADDb $53
38CC: 0B              ?????
38CD: 49              ROLa
38CE: 05              ?????
38CF: 41              ?????
38D0: 14              ?????
38D1: 1F 12           TFR X,Y
38D3: D9 1C           ADCb $1C
38D5: 0B              ?????
38D6: EE DB           LDU [D,U]
38D8: 22 06           BHI $38E0
38DA: 9A 51           ORa $51
38DC: 18              ?????
38DD: 23 C6           BLS $38A5
38DF: B4 B7 D0        ANDa $B7D0
38E2: C9 AC           ADCb #$AC
38E4: BB 82 0E        ADDa $820E
38E7: 1F 0C           TFR D,??
38E9: 49              ROLa
38EA: 1B              ?????
38EB: D6 15           LDb $15
38ED: 51              ?????
38EE: 18              ?????
38EF: 3D              MUL
38F0: C6 40           LDb #$40
38F2: 61              ?????
38F3: E3 06           ADDD +$06,X
38F5: C3 10 1F        ADDd #$101F
38F8: 0E 91           JMP $91
38FA: 1E 4F           EXG S,??
38FC: C2 66           SBCb #$66
38FE: C6 AF           LDb #$AF
3900: 14              ?????
3901: E4 14           ANDb -$0C,X
3903: 83 4A E3        SUBd #$4AE3
3906: 06 FF           ROR $FF
3908: 0E 1F           JMP $1F
390A: 0C FB           INC $FB
390C: 1B              ?????
390D: 80 5B           SUBa #$5B
390F: F3 23 10        ADDD $2310
3912: D0 16           SUBb $16
3914: BC 5C A2        CMPX $5CA2
3917: 9C 34           CMPX $34
3919: 0B              ?????
391A: 32 05           LEAS +$05,X
391C: E6 27           LDb +$07,Y
391E: 0D 25           TST $25
3920: 14              ?????
3921: 01              ?????
3922: 13              SYNC
3923: 0E 05           JMP $05
3925: 20 2C           BRA $3953
3927: 14              ?????
3928: 01              ?????
3929: 2C 0B           BGE $3936
392B: 19              DAA
392C: 0A 04           DEC $04
392E: 04 21           LSR $21
3930: 04 00           LSR $00
3932: 00 03           NEG $03
3934: 04 21           LSR $21
3936: 03 00           COM $00
3938: 00 01           NEG $01
393A: 04 21           LSR $21
393C: 01              ?????
393D: 00 00           NEG $00
393F: 02              ?????
3940: 04 21           LSR $21
3942: 02              ?????
3943: 00 00           NEG $00
3945: FF 06 0D        STU $060D
3948: 04 14           LSR $14
394A: 01              ?????
394B: 13              SYNC
394C: 9B 9B           ADDa $9B
394E: 41              ?????
394F: 0B              ?????
3950: 3F              SWI1
3951: 05              ?????
3952: 3F              SWI1
3953: 0D 0D           TST $0D
3955: 0B              ?????
3956: 25 04           BCS $395C
3958: 03 B5           COM $B5
395A: D0 54           SUBb $54
395C: 25 21           BCS $397F
395E: 04 00           LSR $00
3960: 00 7F           NEG $7F
3962: 0D 0D           TST $0D
3964: 0B              ?????
3965: 25 04           BCS $396B
3967: 03 95           COM $95
3969: 5F              CLRb
396A: 54              LSRb
396B: 25 21           BCS $398E
396D: 03 00           COM $00
396F: 00 BF           NEG $BF
3971: 0E 0D           JMP $0D
3973: 0C 25           INC $25
3975: 04 04           LSR $04
3977: 04 9A           LSR $9A
3979: 53              COMb
397A: BE 25 21        LDX $2521
397D: 01              ?????
397E: 00 00           NEG $00
3980: FF 0E 0D        STU $0E0D
3983: 0C 25           INC $25
3985: 04 04           LSR $04
3987: 47              ASRa
3988: B9 53 BE        ADCa $53BE
398B: 25 21           BCS $39AE
398D: 02              ?????
398E: 00 00           NEG $00
3990: 9E 14           LDX $14
3992: 0D 12           TST $12
3994: 01              ?????
3995: 13              SYNC
3996: 2C 13           BGE $39AB
3998: AA 04           ORa +$04,X
399A: 0B              ?????
399B: 9E 61           LDX $61
399D: 3D              MUL
399E: 62              ?????
399F: 82 17           SBCa #$17
39A1: 54              LSRb
39A2: 5E              ?????
39A3: 3F              SWI1
39A4: A0 2E           SUBa +$0E,Y
39A6: A0 20           SUBa +$00,Y
39A8: 04 1E           LSR $1E
39AA: 5F              CLRb
39AB: BE E3 16        LDX $E316
39AE: F3 8C A7        ADDD $8CA7
39B1: B7 4B 94        STa $4B94
39B4: 6B              ?????
39B5: BF 95 5A        STX $955A
39B8: 3E              RESET*
39B9: B9 5B CA        ADCa $5BCA
39BC: 83 7A 5F        SUBd #$7A5F
39BF: BE 9B 15        LDX $9B15
39C2: BF 91 B7        STX $91B7
39C5: B1 1B B5        CMPa $1BB5
39C8: A1 6F           CMPa +$0F,S
39CA: 0D 6D           TST $6D
39CC: 0E 08           JMP $08
39CE: 0A 28           DEC $28
39D0: 0A 0E           DEC $0E
39D2: 0A 29           DEC $29
39D4: 0A 0D           DEC $0D
39D6: 0E 04           JMP $04
39D8: 09 19           ROL $19
39DA: 08 19           LSL $19
39DC: 04 28           LSR $28
39DE: 5F              CLRb
39DF: BE 09 15        LDX $0915
39E2: D9 6A           ADCb $6A
39E4: C0 9F           SUBb #$9F
39E6: C6 B5           LDb #$B5
39E8: 80 A1           SUBa #$A1
39EA: 82 17           SBCa #$17
39EC: 4A              DECa
39ED: 5E              ?????
39EE: 64 48           LSR +$08,U
39F0: 31 C6           LEAY A,U
39F2: 47              ASRa
39F3: 62              ?????
39F4: 9F 15           STX $15
39F6: 77 16 F3        ASR $16F3
39F9: B9 5B 4D        ADCa $5B4D
39FC: EF A6           STU A,Y
39FE: 53              COMb
39FF: C0 AF           SUBb #$AF
3A01: 15              ?????
3A02: C4 98           ANDb #$98
3A04: EB DA           ADDb ??
3A06: 17 19 00        LBSR $5309
3A09: 0E 2E           JMP $2E
3A0B: 0D 2A           TST $2A
3A0D: 03 19           COM $19
3A0F: 15              ?????
3A10: 04 22           LSR $22
3A12: 5F              CLRb
3A13: BE 09 15        LDX $0915
3A16: CE 6A 3D        LDU #$6A3D
3A19: A0 D5           SUBa [B,U]
3A1B: B5 DD 78        BITa $DD78
3A1E: 4A              DECa
3A1F: F4 59 5E        ANDb $595E
3A22: 98 5F           EORa $5F
3A24: 4B              ?????
3A25: 62              ?????
3A26: 8E 48 4B        LDX #$484B
3A29: 15              ?????
3A2A: 0D 8D           TST $8D
3A2C: C8 16           EORb #$16
3A2E: 23 62           BLS $3A92
3A30: E3 59           ADDD -$07,U
3A32: 9B 5D           ADDa $5D
3A34: 1E 1A           EXG X,CC
3A36: 3C 14           CWAI #14
3A38: 0C A4           INC $A4
3A3A: 43              COMa
3A3B: 0D 41           TST $41
3A3D: 0A 0B           DEC $0B
3A3F: 0E 3D           JMP $3D
3A41: 0D 17           TST $17
3A43: 01              ?????
3A44: 3D              MUL
3A45: 1F 13           TFR X,U
3A47: 5F              CLRb
3A48: BE 5B B1        LDX $5BB1
3A4B: 4B              ?????
3A4C: 7B              ?????
3A4D: 55              ?????
3A4E: 45              ?????
3A4F: E4 5F           ANDb -$01,U
3A51: 73 62 81        COM $6281
3A54: 5B              ?????
3A55: 8A AF           ORa #$AF
3A57: 2F 62           BLE $3ABB
3A59: 2E 0D           BGT $3A68
3A5B: 22 0E           BHI $3A6B
3A5D: 04 01           LSR $01
3A5F: 3E              RESET*
3A60: 01              ?????
3A61: 3F              SWI1
3A62: 1F 1A           TFR X,CC
3A64: 85 A5           BITa #$A5
3A66: 65              ?????
3A67: 49              ROLa
3A68: CA 9C           ORb #$9C
3A6A: 4B              ?????
3A6B: 49              ROLa
3A6C: 4B              ?????
3A6D: A4 BF 9A 03     ANDa [$9A03]
3A71: 58              ASLb
3A72: 09 15           ROL $15
3A74: A3 A0           SUBD ,Y+
3A76: 03 A0           COM $A0
3A78: 0F A0           CLR $A0
3A7A: F3 17 17        ADDD $1717
3A7D: 8D A5           BSR $3A24
3A7F: 12              NOP 
3A80: 0D 10           TST $10
3A82: 14              ?????
3A83: 15              ?????
3A84: 02              ?????
3A85: A8 04           EORa +$04,X
3A87: 0A 4B           DEC $4B
3A89: 7B              ?????
3A8A: 06 9A           ROR $9A
3A8C: DE 14           LDU $14
3A8E: D7 A0           STb $A0
3A90: 9B 5D           ADDa $5D
3A92: A6 0E           LDa +$0E,X
3A94: 0D 0C           TST $0C
3A96: 29 A8           BVS $3A40
3A98: 04 08           LSR $08
3A9A: 4B              ?????
3A9B: 7B              ?????
3A9C: 09 9A           ROL $9A
3A9E: C2 16           SBCb #$16
3AA0: A7 61           STa +$01,S
3AA2: A7 2A           STa +$0A,Y
3AA4: 0D 28           TST $28
3AA6: 15              ?????
3AA7: 01              ?????
3AA8: 0E 0F           JMP $0F
3AAA: 0D 05           TST $05
3AAC: 08 40           LSL $40
3AAE: 14              ?????
3AAF: 09 1B           ROL $1B
3AB1: 0D 06           TST $06
3AB3: 14              ?????
3AB4: 08 40           LSL $40
3AB6: 14              ?????
3AB7: 09 14           ROL $14
3AB9: 04 0B           LSR $0B
3ABB: C7              ?????
3ABC: DE D3           LDU $D3
3ABE: 14              ?????
3ABF: E6 96           LDb [A,X]
3AC1: B0 17 75        SUBa $1775
3AC4: 8D 4B           BSR $3B11
3AC6: A8 04           EORa +$04,X
3AC8: 03 56           COM $56
3ACA: D1 48           CMPb $48
3ACC: A9 8B           ADCa D,X
3ACE: A8 0C           EORa +$0C,X
3AD0: 0D 0A           TST $0A
3AD2: 1A 0E           ORCC #$0E
3AD4: 06 15           ROR $15
3AD6: 10 1F           ?????
3AD8: 02              ?????
3AD9: 5F              CLRb
3ADA: BE 11 A9        LDX $11A9
3ADD: 0C 0D           INC $0D
3ADF: 0A 1B           DEC $1B
3AE1: 0E 06           JMP $06
3AE3: 15              ?????
3AE4: 10 1F           ?????
3AE6: 02              ?????
3AE7: 5F              CLRb
3AE8: BE 12 AA        LDX $12AA
3AEB: 0B              ?????
3AEC: 0D 09           TST $09
3AEE: 0E 06           JMP $06
3AF0: 15              ?????
3AF1: 10 1F           ?????
3AF3: 02              ?????
3AF4: 5F              CLRb
3AF5: BE 16 AB        LDX $16AB
3AF8: 35 0D           PULS ,CC,B,DP
3AFA: 33 0A           LEAU +$0A,X
3AFC: 09 A8           ROL $A8
3AFE: 1F 2E           TFR Y,??
3B00: C5 4C           BITb #$4C
3B02: CB 87           ADDb #$87
3B04: F3 49 48        ADDD $4948
3B07: DB FF           ADDb $FF
3B09: B2 51 18        SBCa $5118
3B0C: 23 C6           BLS $3AD4
3B0E: 8E 49 DD        LDX #$49DD
3B11: 46              RORa
3B12: 03 EE           COM $EE
3B14: 33 98 1B        LEAU [+$1B,X]
3B17: B7 33 BB        STa $33BB
3B1A: 91 1E           CMPa $1E
3B1C: 4F              CLRa
3B1D: C2 66           SBCb #$66
3B1F: C6 AF           LDb #$AF
3B21: 14              ?????
3B22: 7B              ?????
3B23: 14              ?????
3B24: AB 55           ADDa -$0B,U
3B26: 7B              ?????
3B27: E6 F4           LDb [,S]
3B29: A4 40           ANDa +$00,U
3B2B: B9 E3 06        ADCa $E306
3B2E: AC 01           CMPX +$01,X
3B30: AA AD 15 0D     ORa $150D,PC
3B34: 13              SYNC
3B35: AA 04           ORa +$04,X
3B37: 10 60           ?????
3B39: 7B              ?????
3B3A: F3 23 70        ADDD $2370
3B3D: 75              ?????
3B3E: C3 6E 33        ADDd #$6E33
3B41: 17 2E 6D        LBSR $69B1
3B44: 99 16           ADCa $16
3B46: 5B              ?????
3B47: D4 AE           ANDb$AE
3B49: 19              DAA
3B4A: 04 17           LSR $17
3B4C: 43              COMa
3B4D: 79 C7 DE        ROL $C7DE
3B50: D3 14           ADDD $14
3B52: 88 96           EORa #$96
3B54: 8E 7A 7B        LDX #$7A7B
3B57: 14              ?????
3B58: C7              ?????
3B59: 93 76           SUBd $76
3B5B: BE BD 15        LDX $BD15
3B5E: 49              ROLa
3B5F: 90 67           SUBa $67
3B61: 48              ASLa
3B62: 21 AF           BRN $3B13
3B64: 23 0E           BLS $3B74
3B66: 21 13           BRN $3B7B
3B68: 04 1E           LSR $1E
3B6A: C7              ?????
3B6B: DE 95           LDU $95
3B6D: AF D5           STX [B,U]
3B6F: C3 65 62        ADDd #$6562
3B72: D5 15           BITb $15
3B74: 67 16           ASR -$0A,X
3B76: 67 49           ASR +$09,U
3B78: 66 B1           ROR [,Y++]
3B7A: D0 15           SUBb $15
3B7C: 3F              SWI1
3B7D: 16 ED 48        LBRA $28C8
3B80: 90 14           SUBa $14
3B82: 04 58           LSR $58
3B84: 30 A1           LEAX ,Y++ 
3B86: 09 5C           ROL $5C
3B88: B0 18 0D        SUBa $180D
3B8B: 16 0A 15        LBRA $45A3
3B8E: 04 12           LSR $12
3B90: 2E 6F           BGT $3C01
3B92: AB A2           ADDa ,-Y
3B94: 25 DD           BCS $3B73
3B96: 36 54           PSHU ,S,X,B
3B98: 7B              ?????
3B99: 17 FF B9        LBSR $3B55
3B9C: C3 B5 DF        ADDd #$B5DF
3B9F: D0 AB           SUBb $AB
3BA1: 89 B1           ADCa #$B1
3BA3: 18              ?????
3BA4: 0D 16           TST $16
3BA6: 04 05           LSR $05
3BA8: C7              ?????
3BA9: DE 77           LDU $77
3BAB: 15              ?????
3BAC: 54              LSRb
3BAD: A8 04           EORa +$04,X
3BAF: 03 56           COM $56
3BB1: D1 48           CMPb $48
3BB3: A9 8B           ADCa D,X
3BB5: A8 04           EORa +$04,X
3BB7: 04 4D           LSR $4D
3BB9: BD A7 61        JSR $A761
3BBC: B2 17 0D        SBCa $170D
3BBF: 15              ?????
3BC0: 0A 43           DEC $43
3BC2: 04 09           LSR $09
3BC4: C7              ?????
3BC5: DE D3           LDU $D3
3BC7: 14              ?????
3BC8: E6 96           LDb [A,X]
3BCA: 77 15 54        ASR $1554
3BCD: A8 04           EORa +$04,X
3BCF: 03 56           COM $56
3BD1: D1 48           CMPb $48
3BD3: A9 8B           ADCa D,X
3BD5: 00 03           NEG $03
3BD7: 47              ASRa
3BD8: 45              ?????
3BD9: 54              LSRb
3BDA: 09 04           ROL $04
3BDC: 47              ASRa
3BDD: 52              ?????
3BDE: 41              ?????
3BDF: 42              ?????
3BE0: 09 05           ROL $05
3BE2: 54              LSRb
3BE3: 48              ASLa
3BE4: 52              ?????
3BE5: 4F              CLRa
3BE6: 57              ASRb
3BE7: 03 06           COM $06
3BE9: 41              ?????
3BEA: 54              LSRb
3BEB: 54              LSRb
3BEC: 41              ?????
3BED: 43              COMa
3BEE: 4B              ?????
3BEF: 04 05           LSR $05
3BF1: 42              ?????
3BF2: 52              ?????
3BF3: 45              ?????
3BF4: 41              ?????
3BF5: 4B              ?????
3BF6: 04 04           LSR $04
3BF8: 4B              ?????
3BF9: 49              ROLa
3BFA: 4C              INCa
3BFB: 4C              INCa
3BFC: 04 03           LSR $03
3BFE: 48              ASLa
3BFF: 49              ROLa
3C00: 54              LSRb
3C01: 04 05           LSR $05
3C03: 4E              ?????
3C04: 4F              CLRa
3C05: 52              ?????
3C06: 54              LSRb
3C07: 48              ASLa
3C08: 05              ?????
3C09: 01              ?????
3C0A: 4E              ?????
3C0B: 05              ?????
3C0C: 05              ?????
3C0D: 53              COMb
3C0E: 4F              CLRa
3C0F: 55              ?????
3C10: 54              LSRb
3C11: 48              ASLa
3C12: 06 01           ROR $01
3C14: 53              COMb
3C15: 06 04           ROR $04
3C17: 45              ?????
3C18: 41              ?????
3C19: 53              COMb
3C1A: 54              LSRb
3C1B: 07 01           ASR $01
3C1D: 45              ?????
3C1E: 07 04           ASR $04
3C20: 57              ASRb
3C21: 45              ?????
3C22: 53              COMb
3C23: 54              LSRb
3C24: 08 01           LSL $01
3C26: 57              ASRb
3C27: 08 04           LSL $04
3C29: 54              LSRb
3C2A: 41              ?????
3C2B: 4B              ?????
3C2C: 45              ?????
3C2D: 09 05           ROL $05
3C2F: 43              COMa
3C30: 41              ?????
3C31: 52              ?????
3C32: 52              ?????
3C33: 59              ROLb
3C34: 09 04           ROL $04
3C36: 44              LSRa
3C37: 52              ?????
3C38: 4F              CLRa
3C39: 50              NEGb
3C3A: 0A 03           DEC $03
3C3C: 50              NEGb
3C3D: 55              ?????
3C3E: 54              LSRb
3C3F: 0A 06           DEC $06
3C41: 49              ROLa
3C42: 4E              ?????
3C43: 56              RORb
3C44: 45              ?????
3C45: 4E              ?????
3C46: 54              LSRb
3C47: 0B              ?????
3C48: 04 4C           LSR $4C
3C4A: 4F              CLRa
3C4B: 4F              CLRa
3C4C: 4B              ?????
3C4D: 0C 04           INC $04
3C4F: 47              ASRa
3C50: 49              ROLa
3C51: 56              RORb
3C52: 45              ?????
3C53: 0D 05           TST $05
3C55: 4F              CLRa
3C56: 46              RORa
3C57: 46              RORa
3C58: 45              ?????
3C59: 52              ?????
3C5A: 0D 06           TST $06
3C5C: 45              ?????
3C5D: 58              ASLb
3C5E: 41              ?????
3C5F: 4D              TSTa
3C60: 49              ROLa
3C61: 4E              ?????
3C62: 0E 06           JMP $06
3C64: 53              COMb
3C65: 45              ?????
3C66: 41              ?????
3C67: 52              ?????
3C68: 43              COMa
3C69: 48              ASLa
3C6A: 0E 04           JMP $04
3C6C: 4F              CLRa
3C6D: 50              NEGb
3C6E: 45              ?????
3C6F: 4E              ?????
3C70: 0F 04           CLR $04
3C72: 50              NEGb
3C73: 55              ?????
3C74: 4C              INCa
3C75: 4C              INCa
3C76: 10 03           ?????
3C78: 45              ?????
3C79: 41              ?????
3C7A: 54              LSRb
3C7B: 12              NOP 
3C7C: 05              ?????
3C7D: 43              COMa
3C7E: 4C              INCa
3C7F: 49              ROLa
3C80: 4D              TSTa
3C81: 42              ?????
3C82: 15              ?????
3C83: 06 41           ROR $41
3C85: 53              COMb
3C86: 43              COMa
3C87: 45              ?????
3C88: 4E              ?????
3C89: 44              LSRa
3C8A: 15              ?????
3C8B: 06 44           ROR $44
3C8D: 45              ?????
3C8E: 53              COMb
3C8F: 43              COMa
3C90: 45              ?????
3C91: 4E              ?????
3C92: 15              ?????
3C93: 04 4C           LSR $4C
3C95: 49              ROLa
3C96: 46              RORa
3C97: 54              LSRb
3C98: 1C 04           ANDCC #$04
3C9A: 57              ASRb
3C9B: 41              ?????
3C9C: 49              ROLa
3C9D: 54              LSRb
3C9E: 1F 04           TFR D,S
3CA0: 53              COMb
3CA1: 54              LSRb
3CA2: 41              ?????
3CA3: 59              ROLb
3CA4: 1F 04           TFR D,S
3CA6: 4A              DECa
3CA7: 55              ?????
3CA8: 4D              TSTa
3CA9: 50              NEGb
3CAA: 20 02           BRA $3CAE
3CAC: 47              ASRa
3CAD: 4F              CLRa
3CAE: 21 03           BRN $3CB3
3CB0: 52              ?????
3CB1: 55              ?????
3CB2: 4E              ?????
3CB3: 21 04           BRN $3CB9
3CB5: 4C              INCa
3CB6: 45              ?????
3CB7: 46              RORa
3CB8: 54              LSRb
3CB9: 21 05           BRN $3CC0
3CBB: 52              ?????
3CBC: 49              ROLa
3CBD: 47              ASRa
3CBE: 48              ASLa
3CBF: 54              LSRb
3CC0: 21 05           BRN $3CC7
3CC2: 45              ?????
3CC3: 4E              ?????
3CC4: 54              LSRb
3CC5: 45              ?????
3CC6: 52              ?????
3CC7: 21 04           BRN $3CCD
3CC9: 50              NEGb
3CCA: 55              ?????
3CCB: 53              COMb
3CCC: 48              ASLa
3CCD: 10 04           ?????
3CCF: 4D              TSTa
3CD0: 4F              CLRa
3CD1: 56              RORb
3CD2: 45              ?????
3CD3: 10 04           ?????
3CD5: 4B              ?????
3CD6: 49              ROLa
3CD7: 43              COMa
3CD8: 4B              ?????
3CD9: 23 04           BLS $3CDF
3CDB: 46              RORa
3CDC: 45              ?????
3CDD: 45              ?????
3CDE: 44              LSRa
3CDF: 24 06           BCC $3CE7
3CE1: 53              COMb
3CE2: 43              COMa
3CE3: 52              ?????
3CE4: 45              ?????
3CE5: 41              ?????
3CE6: 4D              TSTa
3CE7: 2B 04           BMI $3CED
3CE9: 59              ROLb
3CEA: 45              ?????
3CEB: 4C              INCa
3CEC: 4C              INCa
3CED: 2B 04           BMI $3CF3
3CEF: 51              ?????
3CF0: 55              ?????
3CF1: 49              ROLa
3CF2: 54              LSRb
3CF3: 2D 04           BLT $3CF9
3CF5: 53              COMb
3CF6: 54              LSRb
3CF7: 4F              CLRa
3CF8: 50              NEGb
3CF9: 2D 05           BLT $3D00
3CFB: 50              NEGb
3CFC: 4C              INCa
3CFD: 55              ?????
3CFE: 47              ASRa
3CFF: 48              ASLa
3D00: 32 04           LEAS +$04,X
3D02: 50              NEGb
3D03: 49              ROLa
3D04: 43              COMa
3D05: 4B              ?????
3D06: 34 05           PSHS ,B,CC
3D08: 43              COMa
3D09: 4C              INCa
3D0A: 4F              CLRa
3D0B: 53              COMb
3D0C: 45              ?????
3D0D: 38              ?????
3D0E: 04 4C           LSR $4C
3D10: 4F              CLRa
3D11: 43              COMa
3D12: 4B              ?????
3D13: 39              RTS
3D14: 06 55           ROR $55
3D16: 4E              ?????
3D17: 4C              INCa
3D18: 4F              CLRa
3D19: 43              COMa
3D1A: 4B              ?????
3D1B: 3A              ABX
3D1C: 05              ?????
3D1D: 48              ASLa
3D1E: 45              ?????
3D1F: 4C              INCa
3D20: 4C              INCa
3D21: 4F              CLRa
3D22: 3B              RTI
3D23: 02              ?????
3D24: 48              ASLa
3D25: 49              ROLa
3D26: 3B              RTI
3D27: 03 42           COM $42
3D29: 4F              CLRa
3D2A: 57              ASRb
3D2B: 3B              RTI
3D2C: 05              ?????
3D2D: 47              ASRa
3D2E: 52              ?????
3D2F: 45              ?????
3D30: 45              ?????
3D31: 54              LSRb
3D32: 3B              RTI
3D33: 04 57           LSR $57
3D35: 48              ASLa
3D36: 41              ?????
3D37: 54              LSRb
3D38: 3C 03           CWAI #03
3D3A: 57              ASRb
3D3B: 48              ASLa
3D3C: 59              ROLb
3D3D: 3C 03           CWAI #03
3D3F: 48              ASLa
3D40: 4F              CLRa
3D41: 57              ASRb
3D42: 3C 05           CWAI #05
3D44: 57              ASRb
3D45: 48              ASLa
3D46: 45              ?????
3D47: 52              ?????
3D48: 45              ?????
3D49: 3C 03           CWAI #03
3D4B: 57              ASRb
3D4C: 48              ASLa
3D4D: 4F              CLRa
3D4E: 3C 04           CWAI #04
3D50: 57              ASRb
3D51: 48              ASLa
3D52: 45              ?????
3D53: 4E              ?????
3D54: 3C 05           CWAI #05
3D56: 4C              INCa
3D57: 4F              CLRa
3D58: 57              ASRb
3D59: 45              ?????
3D5A: 52              ?????
3D5B: 3D              MUL
3D5C: 05              ?????
3D5D: 55              ?????
3D5E: 4E              ?????
3D5F: 54              LSRb
3D60: 49              ROLa
3D61: 45              ?????
3D62: 3D              MUL
3D63: 03 4C           COM $4C
3D65: 45              ?????
3D66: 54              LSRb
3D67: 3E              RESET*
3D68: 04 43           LSR $43
3D6A: 4F              CLRa
3D6B: 4D              TSTa
3D6C: 45              ?????
3D6D: 3F              SWI1
3D6E: 06 46           ROR $46
3D70: 4F              CLRa
3D71: 4C              INCa
3D72: 4C              INCa
3D73: 4F              CLRa
3D74: 57              ASRb
3D75: 3F              SWI1
3D76: 04 4D           LSR $4D
3D78: 45              ?????
3D79: 45              ?????
3D7A: 54              LSRb
3D7B: 40              NEGa
3D7C: 06 49           ROR $49
3D7E: 4E              ?????
3D7F: 54              LSRb
3D80: 52              ?????
3D81: 4F              CLRa
3D82: 44              LSRa
3D83: 40              NEGa
3D84: 00 03           NEG $03
3D86: 4B              ?????
3D87: 45              ?????
3D88: 59              ROLb
3D89: 16 04 50        LBRA $41DC
3D8C: 49              ROLa
3D8D: 4C              INCa
3D8E: 4C              INCa
3D8F: 17 04 48        LBSR $41DA
3D92: 4F              CLRa
3D93: 4F              CLRa
3D94: 4B              ?????
3D95: 18              ?????
3D96: 04 44           LSR $44
3D98: 4F              CLRa
3D99: 4F              CLRa
3D9A: 52              ?????
3D9B: 0B              ?????
3D9C: 06 43           ROR $43
3D9E: 41              ?????
3D9F: 42              ?????
3DA0: 49              ROLa
3DA1: 4E              ?????
3DA2: 45              ?????
3DA3: 19              DAA
3DA4: 06 52           ROR $52
3DA6: 45              ?????
3DA7: 46              RORa
3DA8: 52              ?????
3DA9: 49              ROLa
3DAA: 47              ASRa
3DAB: 1A 06           ORCC #$06
3DAD: 48              ASLa
3DAE: 41              ?????
3DAF: 4D              TSTa
3DB0: 42              ?????
3DB1: 55              ?????
3DB2: 52              ?????
3DB3: 1B              ?????
3DB4: 06 42           ROR $42
3DB6: 55              ?????
3DB7: 52              ?????
3DB8: 47              ASRa
3DB9: 45              ?????
3DBA: 52              ?????
3DBB: 1B              ?????
3DBC: 04 4D           LSR $4D
3DBE: 45              ?????
3DBF: 41              ?????
3DC0: 54              LSRb
3DC1: 1B              ?????
3DC2: 03 44           COM $44
3DC4: 4F              CLRa
3DC5: 47              ASRa
3DC6: 08 04           LSL $04
3DC8: 48              ASLa
3DC9: 41              ?????
3DCA: 4E              ?????
3DCB: 44              LSRa
3DCC: 1F 05           TFR D,PC
3DCE: 48              ASLa
3DCF: 41              ?????
3DD0: 4E              ?????
3DD1: 44              LSRa
3DD2: 53              COMb
3DD3: 1F 06           TFR D,??
3DD5: 4E              ?????
3DD6: 41              ?????
3DD7: 50              NEGb
3DD8: 4F              CLRa
3DD9: 4C              INCa
3DDA: 45              ?????
3DDB: 02              ?????
3DDC: 06 42           ROR $42
3DDE: 4F              CLRa
3DDF: 4E              ?????
3DE0: 41              ?????
3DE1: 50              NEGb
3DE2: 41              ?????
3DE3: 02              ?????
3DE4: 03 52           COM $52
3DE6: 41              ?????
3DE7: 59              ROLb
3DE8: 03 04           COM $04
3DEA: 58              ASLb
3DEB: 52              ?????
3DEC: 41              ?????
3DED: 59              ROLb
3DEE: 03 06           COM $06
3DF0: 4A              DECa
3DF1: 4F              CLRa
3DF2: 48              ASLa
3DF3: 4E              ?????
3DF4: 53              COMb
3DF5: 4F              CLRa
3DF6: 03 06           COM $06
3DF8: 48              ASLa
3DF9: 4F              CLRa
3DFA: 55              ?????
3DFB: 44              LSRa
3DFC: 49              ROLa
3DFD: 4E              ?????
3DFE: 04 06           LSR $06
3E00: 50              NEGb
3E01: 49              ROLa
3E02: 43              COMa
3E03: 41              ?????
3E04: 53              COMb
3E05: 53              COMb
3E06: 05              ?????
3E07: 06 4D           ROR $4D
3E09: 45              ?????
3E0A: 52              ?????
3E0B: 4C              INCa
3E0C: 49              ROLa
3E0D: 4E              ?????
3E0E: 06 06           ROR $06
3E10: 44              LSRa
3E11: 4F              CLRa
3E12: 43              COMa
3E13: 54              LSRb
3E14: 4F              CLRa
3E15: 52              ?????
3E16: 07 05           ASR $05
3E18: 4E              ?????
3E19: 55              ?????
3E1A: 52              ?????
3E1B: 53              COMb
3E1C: 45              ?????
3E1D: 01              ?????
3E1E: 06 54           ROR $54
3E20: 48              ASLa
3E21: 45              ?????
3E22: 52              ?????
3E23: 41              ?????
3E24: 50              NEGb
3E25: 01              ?????
3E26: 04 57           LSR $57
3E28: 41              ?????
3E29: 4C              INCa
3E2A: 4C              INCa
3E2B: 25 05           BCS $3E32
3E2D: 57              ASRb
3E2E: 41              ?????
3E2F: 4C              INCa
3E30: 4C              INCa
3E31: 53              COMb
3E32: 25 04           BCS $3E38
3E34: 52              ?????
3E35: 4F              CLRa
3E36: 4F              CLRa
3E37: 4D              TSTa
3E38: 2A 04           BPL $3E3E
3E3A: 43              COMa
3E3B: 45              ?????
3E3C: 4C              INCa
3E3D: 4C              INCa
3E3E: 2A 06           BPL $3E46
3E40: 4F              CLRa
3E41: 46              RORa
3E42: 46              RORa
3E43: 49              ROLa
3E44: 43              COMa
3E45: 45              ?????
3E46: 2A 04           BPL $3E4C
3E48: 53              COMb
3E49: 48              ASLa
3E4A: 45              ?????
3E4B: 44              LSRa
3E4C: 2A 05           BPL $3E53
3E4E: 46              RORa
3E4F: 4C              INCa
3E50: 4F              CLRa
3E51: 4F              CLRa
3E52: 52              ?????
3E53: 2B 04           BMI $3E59
3E55: 45              ?????
3E56: 58              ASLb
3E57: 49              ROLa
3E58: 54              LSRb
3E59: 2C 04           BGE $3E5F
3E5B: 48              ASLa
3E5C: 4F              CLRa
3E5D: 4C              INCa
3E5E: 45              ?????
3E5F: 19              DAA
3E60: 06 48           ROR $48
3E62: 41              ?????
3E63: 4C              INCa
3E64: 4C              INCa
3E65: 57              ASRb
3E66: 41              ?????
3E67: 33 06           LEAU +$06,X
3E69: 45              ?????
3E6A: 4E              ?????
3E6B: 54              LSRb
3E6C: 52              ?????
3E6D: 41              ?????
3E6E: 4E              ?????
3E6F: 36 06           PSHU ,B,A
3E71: 43              COMa
3E72: 45              ?????
3E73: 49              ROLa
3E74: 4C              INCa
3E75: 49              ROLa
3E76: 4E              ?????
3E77: 3B              RTI
3E78: 04 52           LSR $52
3E7A: 4F              CLRa
3E7B: 4F              CLRa
3E7C: 46              RORa
3E7D: 3B              RTI
3E7E: 00 03           NEG $03
3E80: 52              ?????
3E81: 45              ?????
3E82: 44              LSRa
3E83: 13              SYNC
3E84: 05              ?????
3E85: 47              ASRa
3E86: 52              ?????
3E87: 45              ?????
3E88: 45              ?????
3E89: 4E              ?????
3E8A: 14              ?????
3E8B: 04 42           LSR $42
3E8D: 4C              INCa
3E8E: 55              ?????
3E8F: 45              ?????
3E90: 15              ?????
3E91: 06 53           ROR $53
3E93: 45              ?????
3E94: 43              COMa
3E95: 52              ?????
3E96: 45              ?????
3E97: 54              LSRb
3E98: 3D              MUL
3E99: 06 50           ROR $50
3E9B: 41              ?????
3E9C: 49              ROLa
3E9D: 4E              ?????
3E9E: 54              LSRb
3E9F: 45              ?????
3EA0: 3E              RESET*
3EA1: 00 02           NEG $02
3EA3: 54              LSRb
3EA4: 4F              CLRa
3EA5: 01              ?????
3EA6: 04 57           LSR $57
3EA8: 49              ROLa
3EA9: 54              LSRb
3EAA: 48              ASLa
3EAB: 02              ?????
3EAC: 05              ?????
3EAD: 55              ?????
3EAE: 53              COMb
3EAF: 49              ROLa
3EB0: 4E              ?????
3EB1: 47              ASRa
3EB2: 02              ?????
3EB3: 02              ?????
3EB4: 41              ?????
3EB5: 54              LSRb
3EB6: 03 05           COM $05
3EB8: 55              ?????
3EB9: 4E              ?????
3EBA: 44              LSRa
3EBB: 45              ?????
3EBC: 52              ?????
3EBD: 04 02           LSR $02
3EBF: 49              ROLa
3EC0: 4E              ?????
3EC1: 05              ?????
3EC2: 04 49           LSR $49
3EC4: 4E              ?????
3EC5: 54              LSRb
3EC6: 4F              CLRa
3EC7: 05              ?????
3EC8: 06 49           ROR $49
3ECA: 4E              ?????
3ECB: 53              COMb
3ECC: 49              ROLa
3ECD: 44              LSRa
3ECE: 45              ?????
3ECF: 05              ?????
3ED0: 03 4F           COM $4F
3ED2: 55              ?????
3ED3: 54              LSRb
3ED4: 06 06           ROR $06
3ED6: 4F              CLRa
3ED7: 55              ?????
3ED8: 54              LSRb
3ED9: 53              COMb
3EDA: 49              ROLa
3EDB: 44              LSRa
3EDC: 06 02           ROR $02
3EDE: 55              ?????
3EDF: 50              NEGb
3EE0: 07 04           ASR $04
3EE2: 44              LSRa
3EE3: 4F              CLRa
3EE4: 57              ASRb
3EE5: 4E              ?????
3EE6: 08 04           LSL $04
3EE8: 4F              CLRa
3EE9: 56              RORb
3EEA: 45              ?????
3EEB: 52              ?????
3EEC: 09 06           ROL $06
3EEE: 42              ?????
3EEF: 45              ?????
3EF0: 48              ASLa
3EF1: 49              ROLa
3EF2: 4E              ?????
3EF3: 44              LSRa
3EF4: 0A 06           DEC $06
3EF6: 41              ?????
3EF7: 52              ?????
3EF8: 4F              CLRa
3EF9: 55              ?????
3EFA: 4E              ?????
3EFB: 44              LSRa
3EFC: 0B              ?????
3EFD: 02              ?????
3EFE: 4F              CLRa
3EFF: 4E              ?????
3F00: 0C 00           INC $00
3F02: FF FF FF        STU $FFFF
3F05: FF FF FF        STU $FFFF
3F08: FF FF FF        STU $FFFF
3F0B: FF FF FF        STU $FFFF
3F0E: FF FF DF        STU $FFDF
3F11: FF DF FF        STU $DFFF
3F14: 80 40           SUBa #$40
3F16: 0D 00           TST $00
3F18: 03 4B           COM $4B
3F1A: 89 2C           ADCa #$2C
3F1C: 00 87           NEG $87
3F1E: 55              ?????
3F1F: 00 00           NEG $00
