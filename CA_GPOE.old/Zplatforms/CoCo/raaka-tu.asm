Archive size is:14625 bytes.
Disassembly base address  is 0x0600


0600: 4F              CLRa        ; 512 bytes 
0601: 8E 04 00        LDX #$0400  ; Start of screen
0604: CE 60 60        LDU #$6060  ; Double space
0607: EF 81           STU ,X++    ; Clear ...
0609: 4A              DECa        ; ... the ...
060A: 26 FB           BNE $0607   ; ... screen
060C: 10 CE 03 FF     LDS #$03FF  ; Set the stack
0610: 86 1D           LDa #$1D
0612: B7 01 D2        STa $01D2
0615: 8E 05 E0        LDX #$05E0
0618: 9F 88           STX $88
061A: C6 96           LDb #$96
061C: F7 01 D5        STb $01D5
061F: 8E 15 23        LDX #$1523
0622: BD 0A 1F        JSR $0A1F
0625: BF 01 D6        STX $01D6
0628: BD 0D 4A        JSR $0D4A
062B: 86 0D           LDa #$0D
062D: BD 11 84        JSR $1184
0630: 10 CE 03 FF     LDS #$03FF
0634: BD 0A CC        JSR $0ACC
0637: 7F 01 B7        CLR $01B7
063A: 7F 01 BA        CLR $01BA
063D: 7F 01 BB        CLR $01BB
0640: 7F 01 B2        CLR $01B2
0643: 7F 01 B3        CLR $01B3
0646: 7F 01 B9        CLR $01B9
0649: 7F 01 B8        CLR $01B8
064C: 7F 01 B4        CLR $01B4
064F: 7F 01 B5        CLR $01B5
0652: 7F 01 BF        CLR $01BF
0655: 7F 01 C3        CLR $01C3
0658: 7F 01 C9        CLR $01C9
065B: C6 1D           LDb #$1D
065D: F7 01 D2        STb $01D2
0660: BD 11 33        JSR $1133
0663: BF 01 D3        STX $01D3
0666: BD 0A 42        JSR $0A42
0669: E6 84           LDb ,X
066B: F7 01 D5        STb $01D5
066E: 8E 15 23        LDX #$1523
0671: BD 0A 1F        JSR $0A1F
0674: BF 01 D6        STX $01D6
0677: 8E 01 E3        LDX #$01E3
067A: BF 01 D8        STX $01D8
067D: 6F 84           CLR ,X
067F: 8E 05 E0        LDX #$05E0
0682: BD 0B 42        JSR $0B42
0685: 27 0B           BEQ $0692
0687: A6 80           LDa ,X+
0689: 81 60           CMPa #$60
068B: 27 F5           BEQ $0682
068D: 8C 06 00        CMPX #$0600
0690: 26 F5           BNE $0687
0692: 8C 06 00        CMPX #$0600
0695: 26 EB           BNE $0682
0697: 6F 9F 01 D8     CLR [$01D8]
069B: 8E 01 E3        LDX #$01E3
069E: A6 84           LDa ,X
06A0: 10 27 00 92     LBEQ $0736
06A4: 81 02           CMPa #$02
06A6: 26 0F           BNE $06B7
06A8: 30 01           LEAX +$01,X
06AA: A6 84           LDa ,X
06AC: 30 1F           LEAX -$01,X
06AE: 81 06           CMPa #$06
06B0: 24 05           BCC $06B7
06B2: B7 01 B8        STa $01B8
06B5: 30 03           LEAX +$03,X
06B7: A6 80           LDa ,X+
06B9: 27 7B           BEQ $0736
06BB: E6 84           LDb ,X
06BD: EE 81           LDU ,X++ 
06BF: 34 10           PSHS ,X
06C1: 4A              DECa
06C2: 26 21           BNE $06E5
06C4: 8E 13 32        LDX #$1332
06C7: BD 0A 1F        JSR $0A1F
06CA: 24 13           BCC $06DF
06CC: BD 0A 42        JSR $0A42
06CF: BD 0A 58        JSR $0A58
06D2: 1F 98           TFR B,A
06D4: 24 09           BCC $06DF
06D6: E6 80           LDb ,X+
06D8: A6 80           LDa ,X+
06DA: F1 01 B3        CMPb $01B3
06DD: 26 F0           BNE $06CF
06DF: F7 01 B3        STb $01B3
06E2: 7E 07 31        JMP $0731
06E5: 4A              DECa
06E6: 26 36           BNE $071E
06E8: 7D 01 B5        TST $01B5
06EB: 27 20           BEQ $070D
06ED: 8E 01 C9        LDX #$01C9
06F0: E7 80           STb ,X+
06F2: B6 01 B7        LDa $01B7
06F5: A7 80           STa ,X+
06F7: B6 01 BA        LDa $01BA
06FA: A7 84           STa ,X
06FC: 26 04           BNE $0702
06FE: 1F 30           TFR U,D
0700: E7 84           STb ,X
0702: 7F 01 B7        CLR $01B7
0705: 7F 01 B5        CLR $01B5
0708: 7F 01 BA        CLR $01BA
070B: 20 24           BRA $0731
070D: BE 01 C3        LDX $01C3
0710: BF 01 C9        STX $01C9
0713: BE 01 C5        LDX $01C5
0716: BF 01 CB        STX $01CB
0719: 8E 01 C3        LDX #$01C3
071C: 20 D2           BRA $06F0
071E: 4A              DECa
071F: 26 0A           BNE $072B
0721: F7 01 B7        STb $01B7
0724: 1F 30           TFR U,D
0726: F7 01 BA        STb $01BA
0729: 20 06           BRA $0731
072B: F7 01 B4        STb $01B4
072E: F7 01 B5        STb $01B5
0731: 35 10           PULS ,X
0733: 7E 06 B7        JMP $06B7
0736: 7D 01 B3        TST $01B3
0739: 10 27 02 58     LBEQ $0995
073D: 8E 01 C9        LDX #$01C9
0740: BD 08 22        JSR $0822
0743: B7 01 C9        STa $01C9
0746: BF 01 CC        STX $01CC
0749: 8E 01 C3        LDX #$01C3
074C: BD 08 22        JSR $0822
074F: B7 01 C3        STa $01C3
0752: BF 01 C6        STX $01C6
0755: 7F 01 B5        CLR $01B5
0758: BE 01 C6        LDX $01C6
075B: B6 01 C3        LDa $01C3
075E: 27 07           BEQ $0767
0760: BD 0A 42        JSR $0A42
0763: 30 02           LEAX +$02,X
0765: A6 84           LDa ,X
0767: B7 01 C8        STa $01C8
076A: BE 01 CC        LDX $01CC
076D: B6 01 C9        LDa $01C9
0770: 27 07           BEQ $0779
0772: BD 0A 42        JSR $0A42
0775: 30 02           LEAX +$02,X
0777: A6 84           LDa ,X
0779: B7 01 CE        STa $01CE
077C: 8E 13 5B        LDX #$135B
077F: A6 84           LDa ,X
0781: 10 27 01 CC     LBEQ $0951
0785: B6 01 B3        LDa $01B3
0788: A1 80           CMPa ,X+
078A: 26 5B           BNE $07E7
078C: A6 84           LDa ,X
078E: B7 01 B6        STa $01B6
0791: B6 01 B4        LDa $01B4
0794: 27 04           BEQ $079A
0796: A1 84           CMPa ,X
0798: 26 4D           BNE $07E7
079A: 30 01           LEAX +$01,X
079C: A6 84           LDa ,X
079E: 27 14           BEQ $07B4
07A0: B6 01 C3        LDa $01C3
07A3: 26 16           BNE $07BB
07A5: B6 01 BB        LDa $01BB
07A8: B7 01 BD        STa $01BD
07AB: 10 8E 01 C3     LDY #$01C3
07AF: BD 08 D2        JSR $08D2
07B2: 20 07           BRA $07BB
07B4: B6 01 C3        LDa $01C3
07B7: 10 26 01 96     LBNE $0951
07BB: 30 01           LEAX +$01,X
07BD: A6 84           LDa ,X
07BF: 27 19           BEQ $07DA
07C1: B6 01 C9        LDa $01C9
07C4: 26 1B           BNE $07E1
07C6: B6 01 BC        LDa $01BC
07C9: B7 01 BD        STa $01BD
07CC: 86 01           LDa #$01
07CE: B7 01 B5        STa $01B5
07D1: 10 8E 01 C9     LDY #$01C9
07D5: BD 08 D2        JSR $08D2
07D8: 20 07           BRA $07E1
07DA: B6 01 C9        LDa $01C9
07DD: 10 26 01 70     LBNE $0951
07E1: 30 01           LEAX +$01,X
07E3: A6 84           LDa ,X
07E5: 20 09           BRA $07F0
07E7: 30 01           LEAX +$01,X
07E9: 30 01           LEAX +$01,X
07EB: 30 02           LEAX +$02,X
07ED: 7E 07 7F        JMP $077F
07F0: B7 01 D1        STa $01D1
07F3: 8E 05 FF        LDX #$05FF
07F6: 9F 88           STX $88
07F8: 86 0D           LDa #$0D
07FA: BD 11 84        JSR $1184
07FD: B6 01 C3        LDa $01C3
0800: 26 0C           BNE $080E
0802: BE 01 CC        LDX $01CC
0805: BF 01 C6        STX $01C6
0808: B6 01 C9        LDa $01C9
080B: B7 01 C3        STa $01C3
080E: 8E 32 3C        LDX #$323C
0811: BD 0A 42        JSR $0A42
0814: BD 0C 03        JSR $0C03
0817: BD 0F 66        JSR $0F66
081A: 86 0D           LDa #$0D
081C: BD 11 84        JSR $1184
081F: 7E 06 30        JMP $0630
0822: 7F 01 BF        CLR $01BF
0825: E6 80           LDb ,X+
0827: F7 01 B2        STb $01B2
082A: 26 02           BNE $082E
082C: 4F              CLRa
082D: 39              RTS
082E: A6 80           LDa ,X+
0830: B7 01 B7        STa $01B7
0833: A6 84           LDa ,X
0835: B7 01 CF        STa $01CF
0838: 8E 20 FF        LDX #$20FF
083B: BD 0A 1F        JSR $0A1F
083E: 24 5A           BCC $089A
0840: 34 20           PSHS ,Y
0842: 34 10           PSHS ,X
0844: B6 01 E1        LDa $01E1
0847: B7 01 E2        STa $01E2
084A: BD 08 AA        JSR $08AA
084D: 26 57           BNE $08A6
084F: B6 01 B7        LDa $01B7
0852: 27 1F           BEQ $0873
0854: 35 10           PULS ,X
0856: 34 10           PSHS ,X
0858: BD 0A 42        JSR $0A42
085B: 30 03           LEAX +$03,X
085D: C6 01           LDb #$01
085F: BD 0A 27        JSR $0A27
0862: 24 0F           BCC $0873
0864: BD 0A 42        JSR $0A42
0867: BD 0A 58        JSR $0A58
086A: 24 3A           BCC $08A6
086C: B6 01 B7        LDa $01B7
086F: A1 80           CMPa ,X+
0871: 26 F4           BNE $0867
0873: 35 10           PULS ,X
0875: B6 01 BF        LDa $01BF
0878: 10 26 01 10     LBNE $098C
087C: B6 01 E2        LDa $01E2
087F: B7 01 BF        STa $01BF
0882: BF 01 C0        STX $01C0
0885: BD 0A 42        JSR $0A42
0888: 1F 21           TFR Y,X
088A: 35 20           PULS ,Y
088C: F6 01 B2        LDb $01B2
088F: B6 01 E2        LDa $01E2
0892: B7 01 E1        STa $01E1
0895: BD 0A 27        JSR $0A27
0898: 25 A6           BCS $0840
089A: BE 01 C0        LDX $01C0
089D: B6 01 BF        LDa $01BF
08A0: 26 03           BNE $08A5
08A2: 7E 09 48        JMP $0948
08A5: 39              RTS
08A6: 35 10           PULS ,X
08A8: 20 DB           BRA $0885
08AA: BD 0A 42        JSR $0A42
08AD: B6 01 D5        LDa $01D5
08B0: A1 84           CMPa ,X
08B2: 27 F1           BEQ $08A5
08B4: A6 84           LDa ,X
08B6: 27 17           BEQ $08CF
08B8: 81 FF           CMPa #$FF
08BA: 27 E9           BEQ $08A5
08BC: 85 80           BITa #$80
08BE: 26 0F           BNE $08CF
08C0: E6 84           LDb ,X
08C2: F1 01 D2        CMPb $01D2
08C5: 27 DE           BEQ $08A5
08C7: 8E 20 FF        LDX #$20FF
08CA: BD 11 33        JSR $1133
08CD: 20 DB           BRA $08AA
08CF: 8A 01           ORa #$01
08D1: 39              RTS
08D2: 34 10           PSHS ,X
08D4: 7F 01 B2        CLR $01B2
08D7: 7F 01 E1        CLR $01E1
08DA: 34 20           PSHS ,Y
08DC: A6 84           LDa ,X
08DE: B7 01 AB        STa $01AB
08E1: 8E 20 FF        LDX #$20FF
08E4: BD 0A 42        JSR $0A42
08E7: BD 0A 58        JSR $0A58
08EA: 24 40           BCC $092C
08EC: 7C 01 E1        INC $01E1
08EF: 34 20           PSHS ,Y
08F1: 34 10           PSHS ,X
08F3: BD 08 AA        JSR $08AA
08F6: 35 10           PULS ,X
08F8: 26 2D           BNE $0927
08FA: E6 84           LDb ,X
08FC: BF 01 D8        STX $01D8
08FF: BD 0A 42        JSR $0A42
0902: 30 02           LEAX +$02,X
0904: A6 84           LDa ,X
0906: B4 01 AB        ANDa $01AB
0909: B1 01 AB        CMPa $01AB
090C: 26 13           BNE $0921
090E: B6 01 B2        LDa $01B2
0911: 26 47           BNE $095A
0913: F7 01 B2        STb $01B2
0916: A6 84           LDa ,X
0918: B7 01 B7        STa $01B7
091B: BE 01 D8        LDX $01D8
091E: BF 01 AD        STX $01AD
0921: 1E 12           EXG X,Y
0923: 35 20           PULS ,Y
0925: 20 C0           BRA $08E7
0927: BD 0A 42        JSR $0A42
092A: 20 F5           BRA $0921
092C: B6 01 B2        LDa $01B2
092F: 27 29           BEQ $095A
0931: 35 20           PULS ,Y
0933: BE 01 AD        LDX $01AD
0936: B6 01 E1        LDa $01E1
0939: A7 A4           STa ,Y
093B: 31 23           LEAY +$03,Y
093D: AF A1           STX ,Y++ 
093F: B6 01 B7        LDa $01B7
0942: A7 A4           STa ,Y
0944: 35 10           PULS ,X
0946: 4F              CLRa
0947: 39              RTS
0948: 10 8E 13 43     LDY #$1343
094C: B6 01 CF        LDa $01CF
094F: 20 4A           BRA $099B
0951: 10 8E 13 52     LDY #$1352
0955: B6 01 BC        LDa $01BC
0958: 20 41           BRA $099B
095A: B6 01 B5        LDa $01B5
095D: 27 24           BEQ $0983
095F: B6 01 B4        LDa $01B4
0962: 26 1F           BNE $0983
0964: 8E 3E CF        LDX #$3ECF
0967: E6 84           LDb ,X
0969: 27 18           BEQ $0983
096B: 34 10           PSHS ,X
096D: E6 80           LDb ,X+
096F: 3A              ABX
0970: B6 01 B6        LDa $01B6
0973: A1 80           CMPa ,X+
0975: 27 04           BEQ $097B
0977: 35 06           PULS ,A,B
0979: 20 EC           BRA $0967
097B: 35 20           PULS ,Y
097D: B6 01 BD        LDa $01BD
0980: BD 09 E1        JSR $09E1
0983: 10 8E 13 43     LDY #$1343
0987: B6 01 BD        LDa $01BD
098A: 20 0F           BRA $099B
098C: 10 8E 13 4A     LDY #$134A
0990: B6 01 CF        LDa $01CF
0993: 20 06           BRA $099B
0995: 10 8E 13 3C     LDY #$133C
0999: 86 E0           LDa #$E0
099B: 10 CE 03 FF     LDS #$03FF
099F: 8E 05 E0        LDX #$05E0
09A2: BD 09 E1        JSR $09E1
09A5: A6 A4           LDa ,Y
09A7: B7 01 AB        STa $01AB
09AA: 34 10           PSHS ,X
09AC: 86 60           LDa #$60
09AE: A7 80           STa ,X+
09B0: 7A 01 AB        DEC $01AB
09B3: 26 F7           BNE $09AC
09B5: BD 09 D6        JSR $09D6
09B8: 35 10           PULS ,X
09BA: 5A              DECb
09BB: 26 14           BNE $09D1
09BD: A6 A4           LDa ,Y
09BF: 4C              INCa
09C0: B7 01 AB        STa $01AB
09C3: BD 0A DB        JSR $0ADB
09C6: 7A 01 AB        DEC $01AB
09C9: 26 F8           BNE $09C3
09CB: BD 0A 63        JSR $0A63
09CE: 7E 06 37        JMP $0637
09D1: BD 0A 00        JSR $0A00
09D4: 20 CF           BRA $09A5
09D6: 86 32           LDa #$32
09D8: 7A 01 AB        DEC $01AB
09DB: 26 FB           BNE $09D8
09DD: 4A              DECa
09DE: 26 F8           BNE $09D8
09E0: 39              RTS
09E1: B7 01 AB        STa $01AB
09E4: CC 05 E0        LDD #$05E0
09E7: F6 01 AB        LDb $01AB
09EA: 1F 01           TFR D,X
09EC: A6 A4           LDa ,Y
09EE: 4C              INCa
09EF: B7 01 AB        STa $01AB
09F2: 34 20           PSHS ,Y
09F4: BD 0B 06        JSR $0B06
09F7: 7A 01 AB        DEC $01AB
09FA: 26 F8           BNE $09F4
09FC: 35 20           PULS ,Y
09FE: C6 08           LDb #$08
0A00: A6 A4           LDa ,Y
0A02: B7 01 AB        STa $01AB
0A05: 34 34           PSHS ,Y,X,B
0A07: 31 21           LEAY +$01,Y
0A09: A6 A0           LDa ,Y+
0A0B: A7 80           STa ,X+
0A0D: 7A 01 AB        DEC $01AB
0A10: 26 F7           BNE $0A09
0A12: 30 01           LEAX +$01,X
0A14: 1F 10           TFR X,D
0A16: F7 01 BD        STb $01BD
0A19: BD 09 D6        JSR $09D6
0A1C: 35 34           PULS ,B,X,Y
0A1E: 39              RTS
0A1F: 30 01           LEAX +$01,X
0A21: BD 0A 44        JSR $0A44
0A24: 7F 01 E1        CLR $01E1
0A27: BD 0A 58        JSR $0A58
0A2A: 25 01           BCS $0A2D
0A2C: 39              RTS
0A2D: 7C 01 E1        INC $01E1
0A30: E1 84           CMPb ,X
0A32: 27 0B           BEQ $0A3F
0A34: 34 20           PSHS ,Y
0A36: BD 0A 42        JSR $0A42
0A39: 1F 21           TFR Y,X
0A3B: 35 20           PULS ,Y
0A3D: 20 E8           BRA $0A27
0A3F: 1A 01           ORCC #$01
0A41: 39              RTS
0A42: 30 01           LEAX +$01,X
0A44: 4F              CLRa
0A45: 34 04           PSHS ,B
0A47: E6 80           LDb ,X+
0A49: C5 80           BITb #$80
0A4B: 27 06           BEQ $0A53
0A4D: C4 7F           ANDb #$7F
0A4F: 1F 98           TFR B,A
0A51: E6 80           LDb ,X+
0A53: 31 8B           LEAY D,X
0A55: 35 04           PULS ,B
0A57: 39              RTS
0A58: 10 BF 01 A9     STY $01A9
0A5C: BC 01 A9        CMPX $01A9
0A5F: 39              RTS
0A60: 8E 05 E0        LDX #$05E0
0A63: BD 0B 23        JSR $0B23
0A66: BD 0B 2B        JSR $0B2B
0A69: 81 15           CMPa #$15
0A6B: 27 20           BEQ $0A8D
0A6D: 81 5D           CMPa #$5D
0A6F: 27 2F           BEQ $0AA0
0A71: 81 09           CMPa #$09
0A73: 27 3E           BEQ $0AB3
0A75: 81 0D           CMPa #$0D
0A77: 27 4F           BEQ $0AC8
0A79: 81 0C           CMPa #$0C
0A7B: 27 4F           BEQ $0ACC
0A7D: 81 08           CMPa #$08
0A7F: 27 3B           BEQ $0ABC
0A81: 8C 05 FF        CMPX #$05FF
0A84: 27 E0           BEQ $0A66
0A86: BD 0B 06        JSR $0B06
0A89: A7 80           STa ,X+
0A8B: 20 D9           BRA $0A66
0A8D: 8C 05 E0        CMPX #$05E0
0A90: 27 D4           BEQ $0A66
0A92: 30 1F           LEAX -$01,X
0A94: A6 80           LDa ,X+
0A96: A7 84           STa ,X
0A98: 30 1F           LEAX -$01,X
0A9A: 86 CF           LDa #$CF
0A9C: A7 84           STa ,X
0A9E: 20 C6           BRA $0A66
0AA0: 8C 05 FF        CMPX #$05FF
0AA3: 27 C1           BEQ $0A66
0AA5: 30 01           LEAX +$01,X
0AA7: A6 84           LDa ,X
0AA9: 30 1F           LEAX -$01,X
0AAB: A7 80           STa ,X+
0AAD: 86 CF           LDa #$CF
0AAF: A7 84           STa ,X
0AB1: 20 B3           BRA $0A66
0AB3: BD 0A DB        JSR $0ADB
0AB6: 86 CF           LDa #$CF
0AB8: A7 84           STa ,X
0ABA: 20 AA           BRA $0A66
0ABC: 8C 05 E0        CMPX #$05E0
0ABF: 27 A5           BEQ $0A66
0AC1: 30 1F           LEAX -$01,X
0AC3: BD 0A DB        JSR $0ADB
0AC6: 20 9E           BRA $0A66
0AC8: BD 0A DB        JSR $0ADB
0ACB: 39              RTS
0ACC: 8E 05 E0        LDX #$05E0
0ACF: C6 20           LDb #$20
0AD1: 86 60           LDa #$60
0AD3: A7 80           STa ,X+
0AD5: 5A              DECb
0AD6: 26 FB           BNE $0AD3
0AD8: 7E 0A 60        JMP $0A60
0ADB: 1F 13           TFR X,U
0ADD: 31 01           LEAY +$01,X
0ADF: 86 60           LDa #$60
0AE1: A7 84           STa ,X
0AE3: 10 8C 06 00     CMPY #$0600
0AE7: 27 E2           BEQ $0ACB
0AE9: 10 8C 06 01     CMPY #$0601
0AED: 27 DC           BEQ $0ACB
0AEF: 10 8C 06 02     CMPY #$0602
0AF3: 27 D6           BEQ $0ACB
0AF5: A6 A0           LDa ,Y+
0AF7: A7 80           STa ,X+
0AF9: 10 8C 06 00     CMPY #$0600
0AFD: 26 F6           BNE $0AF5
0AFF: 86 60           LDa #$60
0B01: A7 84           STa ,X
0B03: 1F 31           TFR U,X
0B05: 39              RTS
0B06: 8C 06 00        CMPX #$0600
0B09: 27 17           BEQ $0B22
0B0B: BF 01 A7        STX $01A7
0B0E: 8E 06 00        LDX #$0600
0B11: 10 8E 05 FF     LDY #$05FF
0B15: E6 A2           LDb ,-Y
0B17: E7 82           STb ,-X
0B19: BC 01 A7        CMPX $01A7
0B1C: 26 F7           BNE $0B15
0B1E: C6 60           LDb #$60
0B20: E7 84           STb ,X
0B22: 39              RTS
0B23: BD 0B 06        JSR $0B06
0B26: 86 CF           LDa #$CF
0B28: A7 84           STa ,X
0B2A: 39              RTS
0B2B: BD 12 A8        JSR $12A8
0B2E: AD 9F A0 00     JSR [$A000]
0B32: 4D              TSTa
0B33: 27 F6           BEQ $0B2B
0B35: 81 41           CMPa #$41
0B37: 24 06           BCC $0B3F
0B39: 81 20           CMPa #$20
0B3B: 25 02           BCS $0B3F
0B3D: 8B 40           ADDa #$40
0B3F: 39              RTS
0B40: 30 01           LEAX +$01,X
0B42: 1F 10           TFR X,D
0B44: F7 01 CF        STb $01CF
0B47: 8C 06 00        CMPX #$0600
0B4A: 27 F3           BEQ $0B3F
0B4C: A6 84           LDa ,X
0B4E: 81 60           CMPa #$60
0B50: 24 EE           BCC $0B40
0B52: 10 8E 3C 29     LDY #$3C29
0B56: BD 0B 8B        JSR $0B8B
0B59: 27 E7           BEQ $0B42
0B5B: C6 01           LDb #$01
0B5D: 31 21           LEAY +$01,Y
0B5F: BD 0B 8B        JSR $0B8B
0B62: 27 08           BEQ $0B6C
0B64: 5C              INCb
0B65: C1 05           CMPb #$05
0B67: 26 F4           BNE $0B5D
0B69: 8A 01           ORa #$01
0B6B: 39              RTS
0B6C: 1E 12           EXG X,Y
0B6E: BE 01 D8        LDX $01D8
0B71: E7 80           STb ,X+
0B73: A7 80           STa ,X+
0B75: B6 01 CF        LDa $01CF
0B78: A7 80           STa ,X+
0B7A: BF 01 D8        STX $01D8
0B7D: 1E 12           EXG X,Y
0B7F: C1 01           CMPb #$01
0B81: 26 06           BNE $0B89
0B83: B6 01 BC        LDa $01BC
0B86: B7 01 BB        STa $01BB
0B89: 4F              CLRa
0B8A: 39              RTS
0B8B: A6 A4           LDa ,Y
0B8D: 26 03           BNE $0B92
0B8F: 8A 01           ORa #$01
0B91: 39              RTS
0B92: B7 01 AB        STa $01AB
0B95: B7 01 D0        STa $01D0
0B98: 34 10           PSHS ,X
0B9A: 31 21           LEAY +$01,Y
0B9C: A6 84           LDa ,X
0B9E: 81 60           CMPa #$60
0BA0: 27 53           BEQ $0BF5
0BA2: 8C 06 00        CMPX #$0600
0BA5: 27 4E           BEQ $0BF5
0BA7: 81 60           CMPa #$60
0BA9: 25 04           BCS $0BAF
0BAB: 30 01           LEAX +$01,X
0BAD: 20 ED           BRA $0B9C
0BAF: A1 A4           CMPa ,Y
0BB1: 26 42           BNE $0BF5
0BB3: 30 01           LEAX +$01,X
0BB5: 31 21           LEAY +$01,Y
0BB7: 7A 01 AB        DEC $01AB
0BBA: 26 E0           BNE $0B9C
0BBC: B6 01 D0        LDa $01D0
0BBF: 81 06           CMPa #$06
0BC1: 27 06           BEQ $0BC9
0BC3: A6 84           LDa ,X
0BC5: 81 60           CMPa #$60
0BC7: 25 33           BCS $0BFC
0BC9: A6 A4           LDa ,Y
0BCB: 35 20           PULS ,Y
0BCD: B7 01 AB        STa $01AB
0BD0: A6 84           LDa ,X
0BD2: 81 60           CMPa #$60
0BD4: 27 0C           BEQ $0BE2
0BD6: BF 01 A7        STX $01A7
0BD9: 8C 06 00        CMPX #$0600
0BDC: 27 0A           BEQ $0BE8
0BDE: 30 01           LEAX +$01,X
0BE0: 20 EE           BRA $0BD0
0BE2: BF 01 A7        STX $01A7
0BE5: 7C 01 A8        INC $01A8
0BE8: B6 01 A8        LDa $01A8
0BEB: B7 01 BC        STa $01BC
0BEE: B6 01 AB        LDa $01AB
0BF1: 7F 01 A7        CLR $01A7
0BF4: 39              RTS
0BF5: 31 21           LEAY +$01,Y
0BF7: 7A 01 AB        DEC $01AB
0BFA: 26 F9           BNE $0BF5
0BFC: 35 10           PULS ,X
0BFE: 31 21           LEAY +$01,Y
0C00: 7E 0B 8B        JMP $0B8B
0C03: A6 80           LDa ,X+
0C05: 1F 89           TFR A,B
0C07: 85 80           BITa #$80
0C09: 27 13           BEQ $0C1E
0C0B: 34 30           PSHS ,Y,X
0C0D: 8E 37 FA        LDX #$37FA
0C10: BD 0A 1F        JSR $0A1F
0C13: 24 06           BCC $0C1B
0C15: BD 0A 42        JSR $0A42
0C18: BD 0C 03        JSR $0C03
0C1B: 35 30           PULS ,X,Y
0C1D: 39              RTS
0C1E: 1F 98           TFR B,A
0C20: 10 8E 12 E5     LDY #$12E5
0C24: 48              ASLa
0C25: 6E B6           JMP [A,Y]
0C27: BD 0A 44        JSR $0A44
0C2A: BD 0A 58        JSR $0A58
0C2D: 24 0C           BCC $0C3B
0C2F: 34 20           PSHS ,Y
0C31: BD 0C 03        JSR $0C03
0C34: 35 20           PULS ,Y
0C36: 27 F2           BEQ $0C2A
0C38: 1E 12           EXG X,Y
0C3A: 39              RTS
0C3B: 1E 12           EXG X,Y
0C3D: 4F              CLRa
0C3E: 39              RTS
0C3F: BD 0A 44        JSR $0A44
0C42: BD 0A 58        JSR $0A58
0C45: 24 0C           BCC $0C53
0C47: 34 20           PSHS ,Y
0C49: BD 0C 03        JSR $0C03
0C4C: 35 20           PULS ,Y
0C4E: 26 F2           BNE $0C42
0C50: 1E 12           EXG X,Y
0C52: 39              RTS
0C53: 1E 12           EXG X,Y
0C55: 8A 01           ORa #$01
0C57: 39              RTS
0C58: BD 0A 44        JSR $0A44
0C5B: E6 80           LDb ,X+
0C5D: BD 0A 58        JSR $0A58
0C60: 24 F1           BCC $0C53
0C62: 34 20           PSHS ,Y
0C64: 34 04           PSHS ,B
0C66: 1F 98           TFR B,A
0C68: BD 0C 20        JSR $0C20
0C6B: 35 04           PULS ,B
0C6D: 27 09           BEQ $0C78
0C6F: BD 0A 44        JSR $0A44
0C72: 1E 12           EXG X,Y
0C74: 35 20           PULS ,Y
0C76: 20 E5           BRA $0C5D
0C78: BD 0A 44        JSR $0A44
0C7B: BD 0C 03        JSR $0C03
0C7E: 35 10           PULS ,X
0C80: 39              RTS
0C81: BD 0C 8D        JSR $0C8D
0C84: 34 10           PSHS ,X
0C86: BD 0D 4A        JSR $0D4A
0C89: 35 10           PULS ,X
0C8B: 4F              CLRa
0C8C: 39              RTS
0C8D: A6 80           LDa ,X+
0C8F: 34 10           PSHS ,X
0C91: B7 01 D5        STa $01D5
0C94: 1F 89           TFR A,B
0C96: 8E 15 23        LDX #$1523
0C99: BD 0A 1F        JSR $0A1F
0C9C: BF 01 D6        STX $01D6
0C9F: BE 01 D3        LDX $01D3
0CA2: BD 0A 42        JSR $0A42
0CA5: B6 01 D5        LDa $01D5
0CA8: A7 84           STa ,X
0CAA: 35 10           PULS ,X
0CAC: 4F              CLRa
0CAD: 39              RTS
0CAE: FE 01 C6        LDU $01C6
0CB1: FF 01 C0        STU $01C0
0CB4: B6 01 C3        LDa $01C3
0CB7: B7 01 BF        STa $01BF
0CBA: 4F              CLRa
0CBB: 39              RTS
0CBC: FE 01 CC        LDU $01CC
0CBF: FF 01 C0        STU $01C0
0CC2: B6 01 C9        LDa $01C9
0CC5: B7 01 BF        STa $01BF
0CC8: 4F              CLRa
0CC9: 39              RTS
0CCA: E6 80           LDb ,X+
0CCC: 34 10           PSHS ,X
0CCE: F7 01 BF        STb $01BF
0CD1: 27 06           BEQ $0CD9
0CD3: BD 11 33        JSR $1133
0CD6: BF 01 C0        STX $01C0
0CD9: 35 10           PULS ,X
0CDB: 4F              CLRa
0CDC: 39              RTS
0CDD: FE 01 C6        LDU $01C6
0CE0: 34 40           PSHS ,U
0CE2: FE 01 CC        LDU $01CC
0CE5: 34 40           PSHS ,U
0CE7: B6 01 C9        LDa $01C9
0CEA: F6 01 C3        LDb $01C3
0CED: 34 06           PSHS ,B,A
0CEF: B6 01 D1        LDa $01D1
0CF2: 34 02           PSHS ,A
0CF4: A6 80           LDa ,X+
0CF6: B7 01 D1        STa $01D1
0CF9: EC 81           LDD ,X++ 
0CFB: F7 01 AB        STb $01AB
0CFE: 34 10           PSHS ,X
0D00: B7 01 C3        STa $01C3
0D03: 1F 89           TFR A,B
0D05: 27 06           BEQ $0D0D
0D07: BD 11 33        JSR $1133
0D0A: BF 01 C6        STX $01C6
0D0D: F6 01 AB        LDb $01AB
0D10: F7 01 C9        STb $01C9
0D13: 27 06           BEQ $0D1B
0D15: BD 11 33        JSR $1133
0D18: BF 01 CC        STX $01CC
0D1B: 8E 32 3C        LDX #$323C
0D1E: BD 0A 42        JSR $0A42
0D21: BD 0C 03        JSR $0C03
0D24: 1F A8           TFR CC,A
0D26: B7 01 AB        STa $01AB
0D29: 35 20           PULS ,Y
0D2B: 35 02           PULS ,A
0D2D: B7 01 D1        STa $01D1
0D30: 35 06           PULS ,A,B
0D32: F7 01 C3        STb $01C3
0D35: B7 01 C9        STa $01C9
0D38: 35 40           PULS ,U
0D3A: FF 01 CC        STU $01CC
0D3D: 35 40           PULS ,U
0D3F: FF 01 C6        STU $01C6
0D42: 1E 12           EXG X,Y
0D44: B6 01 AB        LDa $01AB
0D47: 1F 8A           TFR A,CC
0D49: 39              RTS
0D4A: B6 01 D2        LDa $01D2
0D4D: 81 1D           CMPa #$1D
0D4F: 26 F8           BNE $0D49
0D51: BE 01 D6        LDX $01D6
0D54: BD 0A 42        JSR $0A42
0D57: 30 01           LEAX +$01,X
0D59: C6 03           LDb #$03
0D5B: BD 0A 27        JSR $0A27
0D5E: 24 05           BCC $0D65
0D60: 30 01           LEAX +$01,X
0D62: BD 11 4C        JSR $114C
0D65: 8E 20 FF        LDX #$20FF
0D68: BD 0A 42        JSR $0A42
0D6B: 34 20           PSHS ,Y
0D6D: BD 0A 42        JSR $0A42
0D70: B6 01 D5        LDa $01D5
0D73: A1 84           CMPa ,X
0D75: 26 12           BNE $0D89
0D77: 30 03           LEAX +$03,X
0D79: C6 03           LDb #$03
0D7B: BD 0A 27        JSR $0A27
0D7E: 24 09           BCC $0D89
0D80: 30 01           LEAX +$01,X
0D82: 34 20           PSHS ,Y
0D84: BD 11 4C        JSR $114C
0D87: 35 20           PULS ,Y
0D89: 1E 12           EXG X,Y
0D8B: 35 20           PULS ,Y
0D8D: BD 0A 58        JSR $0A58
0D90: 25 D9           BCS $0D6B
0D92: 39              RTS
0D93: E6 80           LDb ,X+
0D95: 34 10           PSHS ,X
0D97: BD 11 33        JSR $1133
0D9A: BD 08 AA        JSR $08AA
0D9D: 35 10           PULS ,X
0D9F: 39              RTS
0DA0: B6 01 D2        LDa $01D2
0DA3: A1 80           CMPa ,X+
0DA5: 39              RTS
0DA6: E6 80           LDb ,X+
0DA8: 7E 0F 5F        JMP $0F5F
0DAB: EC 81           LDD ,X++ 
0DAD: 34 10           PSHS ,X
0DAF: B7 01 AB        STa $01AB
0DB2: BD 11 33        JSR $1133
0DB5: BD 0A 42        JSR $0A42
0DB8: EC 81           LDD ,X++ 
0DBA: B1 01 AB        CMPa $01AB
0DBD: 35 10           PULS ,X
0DBF: 39              RTS
0DC0: 8A 01           ORa #$01
0DC2: 39              RTS
0DC3: B6 01 D2        LDa $01D2
0DC6: 81 1D           CMPa #$1D
0DC8: 26 0E           BNE $0DD8
0DCA: C6 1D           LDb #$1D
0DCC: 34 10           PSHS ,X
0DCE: BD 11 33        JSR $1133
0DD1: BD 08 AA        JSR $08AA
0DD4: 35 10           PULS ,X
0DD6: 27 07           BEQ $0DDF
0DD8: BD 0A 44        JSR $0A44
0DDB: 1E 12           EXG X,Y
0DDD: 20 03           BRA $0DE2
0DDF: BD 11 4C        JSR $114C
0DE2: 4F              CLRa
0DE3: 39              RTS
0DE4: BD 0D 4A        JSR $0D4A
0DE7: 4F              CLRa
0DE8: 39              RTS
0DE9: 34 10           PSHS ,X
0DEB: 86 0D           LDa #$0D
0DED: BD 11 84        JSR $1184
0DF0: 8E 20 FF        LDX #$20FF
0DF3: BD 0A 42        JSR $0A42
0DF6: BD 0A 58        JSR $0A58
0DF9: 24 24           BCC $0E1F
0DFB: 34 20           PSHS ,Y
0DFD: BD 0A 42        JSR $0A42
0E00: E6 84           LDb ,X
0E02: F1 01 D2        CMPb $01D2
0E05: 26 12           BNE $0E19
0E07: 30 03           LEAX +$03,X
0E09: C6 02           LDb #$02
0E0B: BD 0A 27        JSR $0A27
0E0E: 24 09           BCC $0E19
0E10: 30 01           LEAX +$01,X
0E12: 34 20           PSHS ,Y
0E14: BD 11 43        JSR $1143
0E17: 35 20           PULS ,Y
0E19: 1E 12           EXG X,Y
0E1B: 35 20           PULS ,Y
0E1D: 20 D7           BRA $0DF6
0E1F: 4F              CLRa
0E20: 35 10           PULS ,X
0E22: 39              RTS
0E23: FE 01 C6        LDU $01C6
0E26: B6 01 C3        LDa $01C3
0E29: FF 01 D8        STU $01D8
0E2C: 4D              TSTa
0E2D: 27 10           BEQ $0E3F
0E2F: E6 80           LDb ,X+
0E31: 34 10           PSHS ,X
0E33: BD 11 33        JSR $1133
0E36: 1E 12           EXG X,Y
0E38: 35 10           PULS ,X
0E3A: 10 BC 01 D8     CMPY $01D8
0E3E: 39              RTS
0E3F: 5D              TSTb
0E40: 39              RTS
0E41: FE 01 CC        LDU $01CC
0E44: B6 01 C9        LDa $01C9
0E47: 20 E0           BRA $0E29
0E49: E6 80           LDb ,X+
0E4B: F1 01 D1        CMPb $01D1
0E4E: 39              RTS
0E4F: 34 10           PSHS ,X
0E51: BE 01 C0        LDX $01C0
0E54: BD 0A 42        JSR $0A42
0E57: B6 01 D2        LDa $01D2
0E5A: A7 84           STa ,X
0E5C: 4F              CLRa
0E5D: 35 10           PULS ,X
0E5F: 39              RTS
0E60: 34 10           PSHS ,X
0E62: BE 01 C0        LDX $01C0
0E65: BD 0A 42        JSR $0A42
0E68: B6 01 D5        LDa $01D5
0E6B: A7 84           STa ,X
0E6D: 35 10           PULS ,X
0E6F: 4F              CLRa
0E70: 39              RTS
0E71: 34 10           PSHS ,X
0E73: BE 01 D6        LDX $01D6
0E76: BD 0A 42        JSR $0A42
0E79: 30 01           LEAX +$01,X
0E7B: C6 04           LDb #$04
0E7D: BD 0A 27        JSR $0A27
0E80: 24 08           BCC $0E8A
0E82: BD 0A 42        JSR $0A42
0E85: BD 0C 03        JSR $0C03
0E88: 27 3B           BEQ $0EC5
0E8A: B6 01 C9        LDa $01C9
0E8D: 27 17           BEQ $0EA6
0E8F: BE 01 CC        LDX $01CC
0E92: BD 0A 42        JSR $0A42
0E95: 30 03           LEAX +$03,X
0E97: C6 06           LDb #$06
0E99: BD 0A 27        JSR $0A27
0E9C: 24 08           BCC $0EA6
0E9E: BD 0A 42        JSR $0A42
0EA1: BD 0C 03        JSR $0C03
0EA4: 27 1F           BEQ $0EC5
0EA6: B6 01 C3        LDa $01C3
0EA9: 26 05           BNE $0EB0
0EAB: 35 10           PULS ,X
0EAD: 8A 01           ORa #$01
0EAF: 39              RTS
0EB0: BE 01 C6        LDX $01C6
0EB3: BD 0A 42        JSR $0A42
0EB6: 30 03           LEAX +$03,X
0EB8: C6 07           LDb #$07
0EBA: BD 0A 27        JSR $0A27
0EBD: 24 EC           BCC $0EAB
0EBF: BD 0A 42        JSR $0A42
0EC2: BD 0C 03        JSR $0C03
0EC5: 35 10           PULS ,X
0EC7: 39              RTS
0EC8: 34 10           PSHS ,X
0ECA: BE 01 C0        LDX $01C0
0ECD: B6 01 BF        LDa $01BF
0ED0: 20 08           BRA $0EDA
0ED2: 34 10           PSHS ,X
0ED4: BE 01 C6        LDX $01C6
0ED7: B6 01 C3        LDa $01C3
0EDA: 27 E9           BEQ $0EC5
0EDC: C6 1D           LDb #$1D
0EDE: 34 10           PSHS ,X
0EE0: BD 11 33        JSR $1133
0EE3: BD 08 AA        JSR $08AA
0EE6: 35 10           PULS ,X
0EE8: 26 11           BNE $0EFB
0EEA: BD 0A 42        JSR $0A42
0EED: 30 03           LEAX +$03,X
0EEF: C6 02           LDb #$02
0EF1: BD 0A 27        JSR $0A27
0EF4: 24 05           BCC $0EFB
0EF6: 30 01           LEAX +$01,X
0EF8: BD 11 4C        JSR $114C
0EFB: 35 10           PULS ,X
0EFD: 4F              CLRa
0EFE: 39              RTS
0EFF: 34 10           PSHS ,X
0F01: BE 01 CC        LDX $01CC
0F04: B6 01 C9        LDa $01C9
0F07: 20 D1           BRA $0EDA
0F09: 34 10           PSHS ,X
0F0B: BE 01 C0        LDX $01C0
0F0E: B6 01 BF        LDa $01BF
0F11: 27 0E           BEQ $0F21
0F13: BD 0A 42        JSR $0A42
0F16: 30 02           LEAX +$02,X
0F18: A6 84           LDa ,X
0F1A: 35 10           PULS ,X
0F1C: A4 84           ANDa ,X
0F1E: A8 80           EORa ,X+
0F20: 39              RTS
0F21: 35 10           PULS ,X
0F23: 30 01           LEAX +$01,X
0F25: 8A 01           ORa #$01
0F27: 39              RTS
0F28: BD 0C 03        JSR $0C03
0F2B: 26 03           BNE $0F30
0F2D: 8A 01           ORa #$01
0F2F: 39              RTS
0F30: 4F              CLRa
0F31: 39              RTS
0F32: E6 80           LDb ,X+
0F34: 34 10           PSHS ,X
0F36: BD 11 33        JSR $1133
0F39: BD 0A 42        JSR $0A42
0F3C: 35 20           PULS ,Y
0F3E: A6 A0           LDa ,Y+
0F40: A7 84           STa ,X
0F42: 1E 12           EXG X,Y
0F44: 4F              CLRa
0F45: 39              RTS
0F46: 34 10           PSHS ,X
0F48: BE 01 C0        LDX $01C0
0F4B: BD 0A 42        JSR $0A42
0F4E: E6 84           LDb ,X
0F50: 35 10           PULS ,X
0F52: 10 27 F9 79     LBEQ $08CF
0F56: F1 01 D2        CMPb $01D2
0F59: 27 EA           BEQ $0F45
0F5B: C5 80           BITb #$80
0F5D: 26 E6           BNE $0F45
0F5F: 34 10           PSHS ,X
0F61: BD 11 33        JSR $1133
0F64: 20 E5           BRA $0F4B
0F66: 8E 20 FF        LDX #$20FF
0F69: 7F 01 D0        CLR $01D0
0F6C: BD 0A 42        JSR $0A42
0F6F: BD 0A 58        JSR $0A58
0F72: 24 D1           BCC $0F45
0F74: 7C 01 D0        INC $01D0
0F77: 34 20           PSHS ,Y
0F79: BD 0A 42        JSR $0A42
0F7C: A6 84           LDa ,X
0F7E: B7 01 AB        STa $01AB
0F81: 34 20           PSHS ,Y
0F83: A6 84           LDa ,X
0F85: 27 42           BEQ $0FC9
0F87: 30 03           LEAX +$03,X
0F89: C6 08           LDb #$08
0F8B: BD 0A 27        JSR $0A27
0F8E: 24 39           BCC $0FC9
0F90: BD 0A 42        JSR $0A42
0F93: 34 10           PSHS ,X
0F95: BD 12 A8        JSR $12A8
0F98: F6 01 D0        LDb $01D0
0F9B: F7 01 D2        STb $01D2
0F9E: BD 11 33        JSR $1133
0FA1: BF 01 D3        STX $01D3
0FA4: F6 01 AB        LDb $01AB
0FA7: 5D              TSTb
0FA8: 2B 0E           BMI $0FB8
0FAA: BD 11 33        JSR $1133
0FAD: BD 0A 42        JSR $0A42
0FB0: E6 84           LDb ,X
0FB2: 26 F3           BNE $0FA7
0FB4: 35 10           PULS ,X
0FB6: 20 11           BRA $0FC9
0FB8: F7 01 D5        STb $01D5
0FBB: 8E 15 23        LDX #$1523
0FBE: BD 0A 1F        JSR $0A1F
0FC1: BF 01 D6        STX $01D6
0FC4: 35 10           PULS ,X
0FC6: BD 0C 03        JSR $0C03
0FC9: 35 10           PULS ,X
0FCB: 35 20           PULS ,Y
0FCD: 20 A0           BRA $0F6F
0FCF: B6 13 38        LDa $1338
0FD2: A1 80           CMPa ,X+
0FD4: 25 05           BCS $0FDB
0FD6: 27 03           BEQ $0FDB
0FD8: 8A 01           ORa #$01
0FDA: 39              RTS
0FDB: 4F              CLRa
0FDC: 39              RTS
0FDD: A6 80           LDa ,X+
0FDF: B7 01 AB        STa $01AB
0FE2: 34 10           PSHS ,X
0FE4: BE 01 C0        LDX $01C0
0FE7: BD 0A 42        JSR $0A42
0FEA: 30 03           LEAX +$03,X
0FEC: 34 10           PSHS ,X
0FEE: 34 20           PSHS ,Y
0FF0: C6 09           LDb #$09
0FF2: BD 0A 27        JSR $0A27
0FF5: 24 29           BCC $1020
0FF7: BD 0A 42        JSR $0A42
0FFA: 30 01           LEAX +$01,X
0FFC: A6 84           LDa ,X
0FFE: B0 01 AB        SUBa $01AB
1001: 24 01           BCC $1004
1003: 4F              CLRa
1004: A7 84           STa ,X
1006: 35 20           PULS ,Y
1008: 35 10           PULS ,X
100A: 4D              TSTa
100B: 27 04           BEQ $1011
100D: 35 10           PULS ,X
100F: 4F              CLRa
1010: 39              RTS
1011: C6 0A           LDb #$0A
1013: BD 0A 27        JSR $0A27
1016: 24 F5           BCC $100D
1018: BD 0A 42        JSR $0A42
101B: BD 0C 03        JSR $0C03
101E: 20 ED           BRA $100D
1020: 35 20           PULS ,Y
1022: 35 10           PULS ,X
1024: 20 E7           BRA $100D
1026: E6 80           LDb ,X+
1028: A6 80           LDa ,X+
102A: B7 01 AB        STa $01AB
102D: 34 10           PSHS ,X
102F: BD 11 33        JSR $1133
1032: BD 0A 42        JSR $0A42
1035: 1F 13           TFR X,U
1037: F6 01 AB        LDb $01AB
103A: BD 11 33        JSR $1133
103D: BD 0A 42        JSR $0A42
1040: A6 84           LDa ,X
1042: E6 C4           LDb ,U
1044: A7 C4           STa ,U
1046: E7 84           STb ,X
1048: 35 10           PULS ,X
104A: 4F              CLRa
104B: 39              RTS
104C: A6 80           LDa ,X+
104E: 34 10           PSHS ,X
1050: B7 01 AB        STa $01AB
1053: BE 01 C0        LDX $01C0
1056: BD 0A 42        JSR $0A42
1059: 30 03           LEAX +$03,X
105B: C6 09           LDb #$09
105D: BD 0A 27        JSR $0A27
1060: 24 0E           BCC $1070
1062: BD 0A 42        JSR $0A42
1065: 30 01           LEAX +$01,X
1067: A6 84           LDa ,X
1069: B1 01 AB        CMPa $01AB
106C: 25 07           BCS $1075
106E: 27 05           BEQ $1075
1070: 35 10           PULS ,X
1072: 8A 01           ORa #$01
1074: 39              RTS
1075: 35 10           PULS ,X
1077: 4F              CLRa
1078: 39              RTS
1079: A6 80           LDa ,X+
107B: B7 01 AB        STa $01AB
107E: 34 10           PSHS ,X
1080: BE 01 C0        LDX $01C0
1083: BD 0A 42        JSR $0A42
1086: 30 03           LEAX +$03,X
1088: C6 09           LDb #$09
108A: BD 0A 27        JSR $0A27
108D: 24 E6           BCC $1075
108F: BD 0A 42        JSR $0A42
1092: EC 84           LDD ,X
1094: FB 01 AB        ADDb $01AB
1097: B7 01 AB        STa $01AB
109A: F1 01 AB        CMPb $01AB
109D: 25 03           BCS $10A2
109F: F6 01 AB        LDb $01AB
10A2: 30 01           LEAX +$01,X
10A4: E7 84           STb ,X
10A6: 20 CD           BRA $1075
10A8: 86 0D           LDa #$0D
10AA: BD 11 84        JSR $1184
10AD: 86 0D           LDa #$0D
10AF: BD 11 84        JSR $1184
10B2: 7E 06 0C        JMP $060C
10B5: 20 FE           BRA $10B5
10B7: A6 A0           LDa ,Y+
10B9: 27 09           BEQ $10C4
10BB: 34 20           PSHS ,Y
10BD: BD 11 84        JSR $1184
10C0: 35 20           PULS ,Y
10C2: 20 F3           BRA $10B7
10C4: 39              RTS
10C5: 34 10           PSHS ,X
10C7: 7F 01 AF        CLR $01AF
10CA: 7F 01 B0        CLR $01B0
10CD: B6 01 D5        LDa $01D5
10D0: 81 96           CMPa #$96
10D2: 26 03           BNE $10D7
10D4: 7C 01 B0        INC $01B0
10D7: 8E 20 FF        LDX #$20FF
10DA: BD 0A 42        JSR $0A42
10DD: BD 0A 58        JSR $0A58
10E0: 24 2D           BCC $110F
10E2: 34 20           PSHS ,Y
10E4: BD 0A 42        JSR $0A42
10E7: E6 80           LDb ,X+
10E9: C1 96           CMPb #$96
10EB: 27 04           BEQ $10F1
10ED: C1 1D           CMPb #$1D
10EF: 26 18           BNE $1109
10F1: B6 01 AF        LDa $01AF
10F4: AB 84           ADDa ,X
10F6: 19              DAA
10F7: B7 01 AF        STa $01AF
10FA: C1 96           CMPb #$96
10FC: 27 05           BEQ $1103
10FE: 7D 01 B0        TST $01B0
1101: 27 06           BEQ $1109
1103: AB 84           ADDa ,X
1105: 19              DAA
1106: B7 01 AF        STa $01AF
1109: 1F 21           TFR Y,X
110B: 35 20           PULS ,Y
110D: 20 CE           BRA $10DD
110F: B6 01 AF        LDa $01AF
1112: 47              ASRa
1113: 47              ASRa
1114: 47              ASRa
1115: 47              ASRa
1116: 8B 30           ADDa #$30
1118: BD 11 84        JSR $1184
111B: B6 01 AF        LDa $01AF
111E: 84 0F           ANDa #$0F
1120: 8B 30           ADDa #$30
1122: BD 11 84        JSR $1184
1125: 86 2E           LDa #$2E
1127: BD 11 84        JSR $1184
112A: 86 20           LDa #$20
112C: BD 11 84        JSR $1184
112F: 35 10           PULS ,X
1131: 4F              CLRa
1132: 39              RTS
1133: 8E 20 FF        LDX #$20FF
1136: BD 0A 42        JSR $0A42
1139: 5A              DECb
113A: 27 88           BEQ $10C4
113C: BD 0A 42        JSR $0A42
113F: 1E 12           EXG X,Y
1141: 20 F6           BRA $1139
1143: BD 11 4C        JSR $114C
1146: 86 0D           LDa #$0D
1148: BD 11 84        JSR $1184
114B: 39              RTS
114C: 4F              CLRa
114D: E6 84           LDb ,X
114F: C5 80           BITb #$80
1151: 27 04           BEQ $1157
1153: A6 80           LDa ,X+
1155: 84 7F           ANDa #$7F
1157: E6 80           LDb ,X+
1159: FD 01 AB        STD $01AB
115C: FC 01 AB        LDD $01AB
115F: 10 83 00 02     CMPD #$0002
1163: 25 0E           BCS $1173
1165: BD 11 EC        JSR $11EC
1168: FC 01 AB        LDD $01AB
116B: 83 00 02        SUBd #$0002
116E: FD 01 AB        STD $01AB
1171: 20 E9           BRA $115C
1173: 5D              TSTb
1174: 27 08           BEQ $117E
1176: A6 80           LDa ,X+
1178: BD 11 84        JSR $1184
117B: 5A              DECb
117C: 20 F5           BRA $1173
117E: 86 20           LDa #$20
1180: BD 11 84        JSR $1184
1183: 39              RTS
1184: 34 06           PSHS ,B,A
1186: B6 01 BE        LDa $01BE
1189: 81 20           CMPa #$20
118B: 26 1A           BNE $11A7
118D: 35 06           PULS ,A,B
118F: 81 20           CMPa #$20
1191: 27 57           BEQ $11EA
1193: 81 2E           CMPa #$2E
1195: 27 08           BEQ $119F
1197: 81 3F           CMPa #$3F
1199: 27 04           BEQ $119F
119B: 81 21           CMPa #$21
119D: 26 0A           BNE $11A9
119F: DE 88           LDU $88
11A1: 33 5F           LEAU -$01,U
11A3: DF 88           STU $88
11A5: 20 02           BRA $11A9
11A7: 35 06           PULS ,A,B
11A9: B7 01 BE        STa $01BE
11AC: AD 9F A0 02     JSR [$A002]
11B0: 96 89           LDa $89
11B2: 81 FE           CMPa #$FE
11B4: 25 34           BCS $11EA
11B6: DE 88           LDU $88
11B8: 33 C8 DF        LEAU -$21,U
11BB: 86 0D           LDa #$0D
11BD: AD 9F A0 02     JSR [$A002]
11C1: A6 C4           LDa ,U
11C3: 81 60           CMPa #$60
11C5: 27 04           BEQ $11CB
11C7: 33 5F           LEAU -$01,U
11C9: 20 F6           BRA $11C1
11CB: 33 41           LEAU +$01,U
11CD: A6 C4           LDa ,U
11CF: 81 60           CMPa #$60
11D1: 27 17           BEQ $11EA
11D3: 34 04           PSHS ,B
11D5: C6 60           LDb #$60
11D7: E7 C4           STb ,U
11D9: 35 04           PULS ,B
11DB: 81 60           CMPa #$60
11DD: 25 02           BCS $11E1
11DF: 80 40           SUBa #$40
11E1: B7 01 BE        STa $01BE
11E4: AD 9F A0 02     JSR [$A002]
11E8: 20 E1           BRA $11CB
11EA: 39              RTS
11EB: 39              RTS
11EC: 10 8E 12 A4     LDY #$12A4
11F0: C6 03           LDb #$03
11F2: F7 12 A1        STb $12A1
11F5: A6 80           LDa ,X+
11F7: B7 01 DE        STa $01DE
11FA: A6 80           LDa ,X+
11FC: B7 01 DD        STa $01DD
11FF: 31 23           LEAY +$03,Y
1201: CE 00 28        LDU #$0028
1204: FF 12 A2        STU $12A2
1207: 86 11           LDa #$11
1209: B7 01 DA        STa $01DA
120C: 7F 01 DB        CLR $01DB
120F: 7F 01 DC        CLR $01DC
1212: 79 01 DE        ROL $01DE
1215: 79 01 DD        ROL $01DD
1218: 7A 01 DA        DEC $01DA
121B: 27 39           BEQ $1256
121D: 86 00           LDa #$00
121F: 89 00           ADCa #$00
1221: 78 01 DC        LSL $01DC
1224: 79 01 DB        ROL $01DB
1227: BB 01 DC        ADDa $01DC
122A: B0 12 A3        SUBa $12A3
122D: B7 01 E0        STa $01E0
1230: B6 01 DB        LDa $01DB
1233: B2 12 A2        SBCa $12A2
1236: B7 01 DF        STa $01DF
1239: 24 0B           BCC $1246
123B: FC 01 DF        LDD $01DF
123E: F3 12 A2        ADDD $12A2
1241: FD 01 DB        STD $01DB
1244: 20 06           BRA $124C
1246: FC 01 DF        LDD $01DF
1249: FD 01 DB        STD $01DB
124C: 25 04           BCS $1252
124E: 1A 01           ORCC #$01
1250: 20 C0           BRA $1212
1252: 1C FE           ANDCC #$FE
1254: 20 BC           BRA $1212
1256: FC 01 DB        LDD $01DB
1259: C3 12 79        ADDd #$1279
125C: 1F 03           TFR D,U
125E: A6 C4           LDa ,U
1260: A7 A2           STa ,-Y
1262: 7A 12 A1        DEC $12A1
1265: 26 9A           BNE $1201
1267: 10 8E 12 A4     LDY #$12A4
126B: C6 03           LDb #$03
126D: A6 A0           LDa ,Y+
126F: BD 11 84        JSR $1184
1272: 5A              DECb
1273: 26 F8           BNE $126D
1275: FC 01 AB        LDD $01AB
1278: 39              RTS
1279: 3F              SWI1
127A: 21 32           BRN $12AE
127C: 20 22           BRA $12A0
127E: 27 3C           BEQ $12BC
1280: 3E              RESET*
1281: 2F 30           BLE $12B3
1283: 33 41           LEAU +$01,U
1285: 42              ?????
1286: 43              COMa
1287: 44              LSRa
1288: 45              ?????
1289: 46              RORa
128A: 47              ASRa
128B: 48              ASLa
128C: 49              ROLa
128D: 4A              DECa
128E: 4B              ?????
128F: 4C              INCa
1290: 4D              TSTa
1291: 4E              ?????
1292: 4F              CLRa
1293: 50              NEGb
1294: 51              ?????
1295: 52              ?????
1296: 53              COMb
1297: 54              LSRb
1298: 55              ?????
1299: 56              RORb
129A: 57              ASRb
129B: 58              ASLb
129C: 59              ROLb
129D: 5A              DECb
129E: 2D 2C           BLT $12CC
12A0: 2E 00           BGT $12A2
12A2: 00 00           NEG $00
12A4: 00 00           NEG $00
12A6: 00 00           NEG $00
12A8: 34 14           PSHS ,X,B
12AA: 8E 13 38        LDX #$1338
12AD: C6 17           LDb #$17
12AF: A6 84           LDa ,X
12B1: 30 01           LEAX +$01,X
12B3: 1A 01           ORCC #$01
12B5: 84 06           ANDa #$06
12B7: 27 07           BEQ $12C0
12B9: 81 06           CMPa #$06
12BB: 1A 01           ORCC #$01
12BD: 27 01           BEQ $12C0
12BF: 4F              CLRa
12C0: A6 84           LDa ,X
12C2: 25 03           BCS $12C7
12C4: 44              LSRa
12C5: 20 03           BRA $12CA
12C7: 44              LSRa
12C8: 8A 80           ORa #$80
12CA: A7 84           STa ,X
12CC: 30 1F           LEAX -$01,X
12CE: A6 84           LDa ,X
12D0: 25 03           BCS $12D5
12D2: 44              LSRa
12D3: 20 03           BRA $12D8
12D5: 44              LSRa
12D6: 8A 80           ORa #$80
12D8: 84 FE           ANDa #$FE
12DA: A7 84           STa ,X
12DC: 5A              DECb
12DD: 26 D2           BNE $12B1
12DF: B6 13 39        LDa $1339
12E2: 35 14           PULS ,B,X
12E4: 39              RTS
12E5: 0C 81           INC $81
12E7: 0D 93           TST $93
12E9: 0D A6           TST $A6
12EB: 0D AB           TST $AB
12ED: 0D C3           TST $C3
12EF: 0F CF           CLR $CF
12F1: 0D E9           TST $E9
12F3: 0D E4           TST $E4
12F5: 0E 23           JMP $23
12F7: 0E 41           JMP $41
12F9: 0E 49           JMP $49
12FB: 0C 58           INC $58
12FD: 0D C0           TST $C0
12FF: 0C 27           INC $27
1301: 0C 3F           INC $3F
1303: 0E 4F           JMP $4F
1305: 0E 60           JMP $60
1307: 0E D2           JMP $D2
1309: 0E FF           JMP $FF
130B: 0E 71           JMP $71
130D: 0F 28           CLR $28
130F: 0F 09           CLR $09
1311: 0E C8           JMP $C8
1313: 0F 32           CLR $32
1315: 0F 46           CLR $46
1317: 0C 8D           INC $8D
1319: 0C AE           INC $AE
131B: 0C BC           INC $BC
131D: 0C CA           INC $CA
131F: 0F DD           CLR $DD
1321: 10 26 0D CA     LBNE $20EF
1325: 0D A0           TST $A0
1327: 0C DD           INC $DD
1329: 10 4C           ?????
132B: 10 79           ?????
132D: 10 B5           ?????
132F: 10 A8           ?????
1331: 10 C5           ?????
1333: 00 12           NEG $12
1335: 23 44           BLS $137B
1337: 1D              SEX
1338: 27 4D           BEQ $1387
133A: 2D 13           BLT $134F
133C: 06 3F           ROR $3F
133E: 56              RORb
133F: 45              ?????
1340: 52              ?????
1341: 42              ?????
1342: 3F              SWI1
1343: 06 3F           ROR $3F
1345: 57              ASRb
1346: 48              ASLa
1347: 41              ?????
1348: 54              LSRb
1349: 3F              SWI1
134A: 07 3F           ASR $3F
134C: 57              ASRb
134D: 48              ASLa
134E: 49              ROLa
134F: 43              COMa
1350: 48              ASLa
1351: 3F              SWI1
1352: 08 3F           LSL $3F
1354: 50              NEGb
1355: 48              ASLa
1356: 52              ?????
1357: 41              ?????
1358: 53              COMb
1359: 45              ?????
135A: 3F              SWI1
135B: 05              ?????
135C: 00 00           NEG $00
135E: 00 01           NEG $01
1360: 06 00           ROR $00
1362: 00 00           NEG $00
1364: 02              ?????
1365: 07 00           ASR $00
1367: 00 00           NEG $00
1369: 03 08           COM $08
136B: 00 00           NEG $00
136D: 00 04           NEG $04
136F: 09 00           ROL $00
1371: 20 00           BRA $1373
1373: 05              ?????
1374: 34 07           PSHS ,B,A,CC
1376: 00 80           NEG $80
1378: 05              ?????
1379: 34 07           PSHS ,B,A,CC
137B: 80 00           SUBa #$00
137D: 05              ?????
137E: 0A 00           DEC $00
1380: 20 00           BRA $1382
1382: 06 0A           ROR $0A
1384: 05              ?????
1385: 80 80           SUBa #$80
1387: 0F 0A           CLR $0A
1389: 06 00           ROR $00
138B: 88 16           EORa #$16
138D: 0B              ?????
138E: 00 00           NEG $00
1390: 00 07           NEG $07
1392: 01              ?????
1393: 00 04           NEG $04
1395: 00 08           NEG $08
1397: 04 02           LSR $02
1399: 10 40           ?????
139B: 09 0C           ROL $0C
139D: 00 00           NEG $00
139F: 00 0A           NEG $0A
13A1: 0C 03           INC $03
13A3: 00 80           NEG $80
13A5: 0B              ?????
13A6: 0C 04           INC $04
13A8: 00 80           NEG $80
13AA: 0C 0C           INC $0C
13AC: 05              ?????
13AD: 00 80           NEG $80
13AF: 10 03           ?????
13B1: 03 40           COM $40
13B3: 10 0D           ?????
13B5: 03 05           COM $05
13B7: 80 80           SUBa #$80
13B9: 39              RTS
13BA: 03 08           COM $08
13BC: 00 20           NEG $20
13BE: 06 03           ROR $03
13C0: 01              ?????
13C1: 80 10           SUBa #$10
13C3: 0E 0D           JMP $0D
13C5: 01              ?????
13C6: 80 10           SUBa #$10
13C8: 0E 0E           JMP $0E
13CA: 00 80           NEG $80
13CC: 00 0B           NEG $0B
13CE: 0E 05           JMP $05
13D0: 00 80           NEG $80
13D2: 0B              ?????
13D3: 0F 00           CLR $00
13D5: 80 00           SUBa #$00
13D7: 11 0F           ?????
13D9: 02              ?????
13DA: 80 80           SUBa #$80
13DC: 3A              ABX
13DD: 10 00           ?????
13DF: 80 00           SUBa #$00
13E1: 12              NOP 
13E2: 10 08           ?????
13E4: 00 80           NEG $80
13E6: 12              NOP 
13E7: 10 06           ?????
13E9: 00 80           NEG $80
13EB: 05              ?????
13EC: 10 06           ?????
13EE: 80 00           SUBa #$00
13F0: 05              ?????
13F1: 10 07           ?????
13F3: 00 80           NEG $80
13F5: 2D 10           BLT $1407
13F7: 07 80           ASR $80
13F9: 00 2D           NEG $2D
13FB: 11 02           ?????
13FD: 88 88           EORa #$88
13FF: 14              ?????
1400: 12              NOP 
1401: 00 80           NEG $80
1403: 00 15           NEG $15
1405: 13              SYNC
1406: 06 00           ROR $00
1408: 88 16           EORa #$16
140A: 14              ?????
140B: 00 88           NEG $88
140D: 00 16           NEG $16
140F: 15              ?????
1410: 00 80           NEG $80
1412: 00 17           NEG $17
1414: 15              ?????
1415: 07 00           ASR $00
1417: 80 17           SUBa #$17
1419: 15              ?????
141A: 08 00           LSL $00
141C: 80 17           SUBa #$17
141E: 15              ?????
141F: 09 00           ROL $00
1421: 80 17           SUBa #$17
1423: 15              ?????
1424: 0C 00           INC $00
1426: 80 17           SUBa #$17
1428: 15              ?????
1429: 05              ?????
142A: 00 00           NEG $00
142C: 36 15           PSHU ,X,B,CC
142E: 05              ?????
142F: 00 80           NEG $80
1431: 36 15           PSHU ,X,B,CC
1433: 06 00           ROR $00
1435: 00 37           NEG $37
1437: 15              ?????
1438: 06 00           ROR $00
143A: 80 37           SUBa #$37
143C: 15              ?????
143D: 04 00           LSR $00
143F: 80 38           SUBa #$38
1441: 16 00 80        LBRA $14C4
1444: 00 18           NEG $18
1446: 18              ?????
1447: 00 00           NEG $00
1449: 00 1A           NEG $1A
144B: 05              ?????
144C: 01              ?????
144D: 00 00           NEG $00
144F: 01              ?????
1450: 06 01           ROR $01
1452: 00 00           NEG $00
1454: 02              ?????
1455: 07 01           ASR $01
1457: 00 00           NEG $00
1459: 03 08           COM $08
145B: 01              ?????
145C: 00 00           NEG $00
145E: 04 0A           LSR $0A
1460: 08 00           LSL $00
1462: 20 06           BRA $146A
1464: 0A 08           DEC $08
1466: 20 00           BRA $1468
1468: 06 0A           ROR $0A
146A: 0A 20           DEC $20
146C: 80 06           SUBa #$06
146E: 0A 04           DEC $04
1470: 20 80           BRA $13F2
1472: 06 0A           ROR $0A
1474: 0C 20           INC $20
1476: 80 06           SUBa #$06
1478: 0C 07           INC $07
147A: 00 00           NEG $00
147C: 0A 0C           DEC $0C
147E: 08 00           LSL $00
1480: 00 0A           NEG $0A
1482: 0C 09           INC $09
1484: 80 00           SUBa #$00
1486: 0B              ?????
1487: 0C 09           INC $09
1489: 00 80           NEG $80
148B: 0B              ?????
148C: 0C 0B           INC $0B
148E: 00 00           NEG $00
1490: 0A 0C           DEC $0C
1492: 0A 00           DEC $00
1494: 00 0A           NEG $0A
1496: 0C 0B           INC $0B
1498: 00 80           NEG $80
149A: 1B              ?????
149B: 0C 0A           INC $0A
149D: 00 80           NEG $80
149F: 1C 32           ANDCC #$32
14A1: 00 00           NEG $00
14A3: 00 21           NEG $21
14A5: 2B 00           BMI $14A7
14A7: 00 00           NEG $00
14A9: 22 2D           BHI $14D8
14AB: 00 00           NEG $00
14AD: 00 23           NEG $23
14AF: 2C 00           BGE $14B1
14B1: 00 00           NEG $00
14B3: 25 2C           BCS $14E1
14B5: 00 20           NEG $20
14B7: 00 06           NEG $06
14B9: 21 00           BRN $14BB
14BB: 00 00           NEG $00
14BD: 25 21           BCS $14E0
14BF: 01              ?????
14C0: 00 80           NEG $80
14C2: 3D              MUL
14C3: 21 05           BRN $14CA
14C5: 00 80           NEG $80
14C7: 36 21           PSHU ,Y,CC
14C9: 06 00           ROR $00
14CB: 80 37           SUBa #$37
14CD: 21 04           BRN $14D3
14CF: 00 80           NEG $80
14D1: 38              ?????
14D2: 21 07           BRN $14DB
14D4: 00 80           NEG $80
14D6: 17 21 08        LBSR $35E1
14D9: 00 80           NEG $80
14DB: 17 21 0B        LBSR $35E9
14DE: 00 80           NEG $80
14E0: 26 23           BNE $1505
14E2: 00 80           NEG $80
14E4: 00 27           NEG $27
14E6: 23 08           BLS $14F0
14E8: 00 80           NEG $80
14EA: 27 23           BEQ $150F
14EC: 05              ?????
14ED: 00 80           NEG $80
14EF: 27 24           BEQ $1515
14F1: 02              ?????
14F2: 10 80           ?????
14F4: 28 24           BVC $151A
14F6: 01              ?????
14F7: 80 10           SUBa #$10
14F9: 29 28           BVS $1523
14FB: 00 00           NEG $00
14FD: 00 2C           NEG $2C
14FF: 1C 00           ANDCC #$00
1501: 80 00           SUBa #$00
1503: 2D 1F           BLT $1524
1505: 00 00           NEG $00
1507: 00 2F           NEG $2F
1509: 1F 0B           TFR D,DP
150B: 00 00           NEG $00
150D: 2F 09           BLE $1518
150F: 07 00           ASR $00
1511: 00 2F           NEG $2F
1513: 20 09           BRA $151E
1515: 00 80           NEG $80
1517: 34 20           PSHS ,Y
1519: 05              ?????
151A: 00 80           NEG $80
151C: 36 20           PSHU ,Y
151E: 06 00           ROR $00
1520: 80 37           SUBa #$37
1522: 00 00           NEG $00
1524: 8B D9           ADDa #$D9
1526: 81 5E           CMPa #$5E
1528: 00 03           NEG $03
152A: 52              ?????
152B: C7              ?????
152C: DE 94           LDU $94
152E: 14              ?????
152F: 4B              ?????
1530: 5E              ?????
1531: 83 96 5F        SUBd #$965F
1534: 17 46 48        LBSR $5B7F
1537: 39              RTS
1538: 17 DB 9F        LBSR $F0DA
153B: 56              RORb
153C: D1 09           CMPb $09
153E: 71              ?????
153F: D0 B0           SUBb $B0
1541: 7F 7B F3        CLR $7BF3
1544: 17 0D 8D        LBSR $22D4
1547: 90 14           SUBa $14
1549: 08 58           LSL $58
154B: 81 8D           CMPa #$8D
154D: 1B              ?????
154E: B5 5F BE        BITa $5FBE
1551: 5B              ?????
1552: B1 4B 7B        CMPa $4B7B
1555: 55              ?????
1556: 45              ?????
1557: 8E 91 11        LDX #$9111
155A: 8A F0           ORa #$F0
155C: A4 91           ANDa [,X++]
155E: 7A 89 17        DEC $8917
1561: 82 17           SBCa #$17
1563: 47              ASRa
1564: 5E              ?????
1565: 66 49           ROR +$09,U
1567: 90 14           SUBa $14
1569: 03 58           COM $58
156B: 3B              RTI
156C: 16 B7 B1        LBRA $CD20
156F: A9 15           ADCa -$0B,X
1571: DB 8B           ADDb $8B
1573: 83 7A 5F        SUBd #$7A5F
1576: BE D7 14        LDX $D714
1579: 43              COMa
157A: 7A CF 98        DEC $CF98
157D: 04 07           LSR $07
157F: 0B              ?????
1580: 05              ?????
1581: 0A 03           DEC $03
1583: 02              ?????
1584: 00 82           NEG $82
1586: 82 80           SBCa #$80
1588: C4 00           ANDb #$00
158A: 03 80           COM $80
158C: AB C7           ADDa ??
158E: DE 94           LDU $94
1590: 14              ?????
1591: 4B              ?????
1592: 5E              ?????
1593: 83 96 3B        SUBd #$963B
1596: 16 B7 B1        LBRA $CD4A
1599: 2F 17           BLE $15B2
159B: FB 55 C7        ADDb $55C7
159E: 98 54           EORa $54
15A0: 8B 39           ADDa #$39
15A2: 17 FF 9F        LBSR $1544
15A5: C0 16           SUBb #$16
15A7: 82 17           SBCa #$17
15A9: 48              ASLa
15AA: 5E              ?????
15AB: 81 8D           CMPa #$8D
15AD: 91 AF           CMPa $AF
15AF: 96 64           LDa $64
15B1: DB 72           ADDb $72
15B3: 95 5F           BITa $5F
15B5: 15              ?????
15B6: BC FF 78        CMPX $FF78
15B9: B8 16 82        EORa $1682
15BC: 17 54 5E        LBSR $6A1D
15BF: 3F              SWI1
15C0: A0 D5           SUBa [B,U]
15C2: 15              ?????
15C3: 90 14           SUBa $14
15C5: D0 15           SUBb $15
15C7: F3 BF 16        ADDD $BF16
15CA: 53              COMb
15CB: 51              ?????
15CC: 5E              ?????
15CD: 07 B2           ASR $B2
15CF: BB 9A 14        ADDa $9A14
15D2: 8A 6B           ORa #$6B
15D4: C4 0C           ANDb #$0C
15D6: BA 7D 62        ORa $7D62
15D9: 90 73           SUBa $73
15DB: C4 6A           ANDb #$6A
15DD: 91 62           CMPa $62
15DF: 30 60           LEAX +$00,S
15E1: 82 17           SBCa #$17
15E3: 50              NEGb
15E4: 5E              ?????
15E5: BE A0 03        LDX $A003
15E8: 71              ?????
15E9: 33 98 47        LEAU [+$47,X]
15EC: B9 53 BE        ADCa $53BE
15EF: 0E D0           JMP $D0
15F1: 2F 8E           BLE $1581
15F3: D0 15           SUBb $15
15F5: 82 17           SBCa #$17
15F7: 47              ASRa
15F8: 5E              ?????
15F9: 66 49           ROR +$09,U
15FB: F3 17 F3        ADDD $17F3
15FE: 8C 4B 7B        CMPX #$4B7B
1601: 4A              DECa
1602: 45              ?????
1603: 77 C4 D3        ASR $C4D3
1606: 14              ?????
1607: 0F B4           CLR $B4
1609: 19              DAA
160A: 58              ASLb
160B: 36 A0           PSHU ,PC,Y
160D: 83 61 81        SUBd #$6181
1610: 5B              ?????
1611: 1B              ?????
1612: B5 6B BF        BITa $6BBF
1615: 5F              CLRb
1616: BE 61 17        LDX $6117
1619: 82 C6           SBCa #$C6
161B: 03 EE           COM $EE
161D: 5F              CLRb
161E: 17 46 48        LBSR $5C69
1621: A9 15           ADCa -$0B,X
1623: DB 8B           ADDb $8B
1625: E3 8B           ADDD D,X
1627: 0B              ?????
1628: 5C              INCb
1629: 6B              ?????
162A: BF 46 45        STX $4645
162D: 35 49           PULS ,CC,DP,U
162F: DB 16           ADDb $16
1631: D3 B9           ADDD $B9
1633: 9B 6C           ADDa $6C
1635: 1B              ?????
1636: D0 2E           SUBb $2E
1638: 04 13           LSR $13
163A: 0B              ?????
163B: 11 0A           ?????
163D: 04 02           LSR $02
163F: 00 81           NEG $81
1641: 02              ?????
1642: 02              ?????
1643: 00 83           NEG $83
1645: 03 06           COM $06
1647: 0D 04           TST $04
1649: 20 1D           BRA $1668
164B: 8B 81           ADDa #$81
164D: 83 3A 00        SUBd #$3A00
1650: 03 2A           COM $2A
1652: C7              ?????
1653: DE 94           LDU $94
1655: 14              ?????
1656: 4B              ?????
1657: 5E              ?????
1658: 83 96 FB        SUBd #$96FB
165B: 14              ?????
165C: 4B              ?????
165D: B2 55 A4        SBCa $55A4
1660: 09 B7           ROL $B7
1662: 59              ROLb
1663: 5E              ?????
1664: 3B              RTI
1665: 4A              DECa
1666: 23 D1           BLS $1639
1668: 13              SYNC
1669: 54              LSRb
166A: C9 B8           ADCb #$B8
166C: F5 A4 B2        BITb $A4B2
166F: 17 90 14        LBSR $A686
1672: 16 58 D6        LBRA $6F4B
1675: 9C DB           CMPX $DB
1677: 72              ?????
1678: 47              ASRa
1679: B9 77 BE        ADCa $77BE
167C: 04 0B           LSR $0B
167E: 0B              ?????
167F: 09 0A           ROL $0A
1681: 01              ?????
1682: 02              ?????
1683: 00 82           NEG $82
1685: 02              ?????
1686: 02              ?????
1687: 00 84           NEG $84
1689: 84 67           ANDa #$67
168B: 00 03           NEG $03
168D: 53              COMb
168E: C7              ?????
168F: DE 94           LDU $94
1691: 14              ?????
1692: 43              COMa
1693: 5E              ?????
1694: 16 BC DB        LBRA $D372
1697: 72              ?????
1698: 82 BF           SBCa #$BF
169A: B8 16 7B        EORa $167B
169D: 14              ?????
169E: 55              ?????
169F: A4 09           ANDa +$09,X
16A1: B7 59 5E        STa $595E
16A4: 85 73           BITa #$73
16A6: 15              ?????
16A7: 71              ?????
16A8: 82 8D           SBCa #$8D
16AA: 4B              ?????
16AB: 62              ?????
16AC: 89 5B           ADCa #$5B
16AE: 83 96 33        SUBd #$9633
16B1: 98 6B           EORa $6B
16B3: BF 5F BE        STX $5FBE
16B6: 99 16           ADCa $16
16B8: C2 B3           SBCb #$B3
16BA: 56              RORb
16BB: F4 F4 72        ANDb $F472
16BE: 4B              ?????
16BF: 5E              ?????
16C0: C3 B5 E1        ADDd #$B5E1
16C3: 14              ?????
16C4: 73 B3 84        COM $B384
16C7: 5B              ?????
16C8: 89 17           ADCa #$17
16CA: 82 17           SBCa #$17
16CC: 47              ASRa
16CD: 5E              ?????
16CE: 66 49           ROR +$09,U
16D0: 90 14           SUBa $14
16D2: 03 58           COM $58
16D4: 06 9A           ROR $9A
16D6: F4 72 89        ANDb $7289
16D9: 17 82 17        LBSR $98F3
16DC: 59              ROLb
16DD: 5E              ?????
16DE: 66 62           ROR +$02,S
16E0: 2E 04           BGT $16E6
16E2: 0F 0B           CLR $0B
16E4: 0D 0A           TST $0A
16E6: 01              ?????
16E7: 02              ?????
16E8: 00 83           NEG $83
16EA: 04 02           LSR $02
16EC: 00 A1           NEG $A1
16EE: 03 02           COM $02
16F0: 00 85           NEG $85
16F2: 85 44           BITa #$44
16F4: 00 03           NEG $03
16F6: 26 63           BNE $175B
16F8: BE CB B5        LDX $CBB5
16FB: C3 B5 73        ADDd #$B573
16FE: 17 1B B8        LBSR $32B9
1701: E6 A4           LDb ,Y
1703: 39              RTS
1704: 17 DB 9F        LBSR $F2A6
1707: 56              RORb
1708: D1 07           CMPb $07
170A: 71              ?????
170B: 96 D7           LDa $D7
170D: C7              ?????
170E: B5 66 49        BITa $6649
1711: 15              ?????
1712: EE 36           LDU -$0A,Y
1714: A1 73           CMPa -$0D,S
1716: 76 8E 48        ROR $8E48
1719: F7 17 17        STb $1717
171C: BA 04 19        ORa $0419
171F: 0B              ?????
1720: 17 0A 04        LBSR $2127
1723: 02              ?????
1724: 00 84           NEG $84
1726: 02              ?????
1727: 02              ?????
1728: 00 86           NEG $86
172A: 03 0C           COM $0C
172C: 0D 0A           TST $0A
172E: 00 88           NEG $88
1730: 14              ?????
1731: 0D 05           TST $05
1733: 20 1D           BRA $1752
1735: 01              ?????
1736: 07 82           ASR $82
1738: 86 3F           LDa #$3F
173A: 00 03           NEG $03
173C: 2F C7           BLE $1705
173E: DE 94           LDU $94
1740: 14              ?????
1741: 4B              ?????
1742: 5E              ?????
1743: 83 96 39        SUBd #$9639
1746: 17 DB 9F        LBSR $F2E8
1749: 56              RORb
174A: D1 09           CMPb $09
174C: 71              ?????
174D: DB B0           ADDb $B0
174F: 66 17           ROR -$09,X
1751: 0F A0           CLR $A0
1753: F3 17 0D        ADDD $170D
1756: 8D 52           BSR $17AA
1758: F4 65 49        ANDb $6549
175B: 77 47 CE        ASR $47CE
175E: B5 86 5F        BITa $865F
1761: 99 16           ADCa $16
1763: C2 B3           SBCb #$B3
1765: 90 14           SUBa $14
1767: 07 58           ASR $58
1769: 66 49           ROR +$09,U
176B: 2E 04           BGT $1771
176D: 0B              ?????
176E: 0B              ?????
176F: 09 0A           ROL $0A
1771: 01              ?????
1772: 02              ?????
1773: 00 85           NEG $85
1775: 03 02           COM $02
1777: 00 87           NEG $87
1779: 87              ?????
177A: 44              LSRa
177B: 00 03           NEG $03
177D: 2F 63           BLE $17E2
177F: BE CB B5        LDX $CBB5
1782: C3 B5 39        ADDd #$B539
1785: 17 8E C5        LBSR $A64D
1788: 39              RTS
1789: 17 DB 9F        LBSR $F32B
178C: 56              RORb
178D: D1 0A           CMPb $0A
178F: 71              ?????
1790: 7A 79 F3        DEC $79F3
1793: 17 0D 8D        LBSR $2523
1796: 56              RORb
1797: F4 DB 72        ANDb $DB72
179A: 16 A0 51        LBRA $B7EE
179D: DB F0           ADDb $F0
179F: A4 91           ANDa [,X++]
17A1: 7A D5 15        DEC $D515
17A4: 89 17           ADCa #$17
17A6: 82 17           SBCa #$17
17A8: 59              ROLb
17A9: 5E              ?????
17AA: 66 62           ROR +$02,S
17AC: 2E 04           BGT $17B2
17AE: 10 0B           ?????
17B0: 0E 0A           JMP $0A
17B2: 05              ?????
17B3: 07 0D           ASR $0D
17B5: 05              ?????
17B6: 08 08           LSL $08
17B8: 19              DAA
17B9: 8C 0C 04        CMPX #$0C04
17BC: 02              ?????
17BD: 00 86           NEG $86
17BF: 88 79           EORa #$79
17C1: 00 03           NEG $03
17C3: 57              ASRb
17C4: C7              ?????
17C5: DE 94           LDU $94
17C7: 14              ?????
17C8: 4B              ?????
17C9: 5E              ?????
17CA: 83 96 8C        SUBd #$968C
17CD: 17 90 78        LBSR $A848
17D0: 2E 6F           BGT $1841
17D2: 23 49           BLS $181D
17D4: 01              ?????
17D5: B3 59 90        SUBD $5990
17D8: 82 7B           SBCa #$7B
17DA: C2 16           SBCb #$16
17DC: 93 61           SUBd $61
17DE: C5 98           BITb #$98
17E0: D0 15           SUBb $15
17E2: 82 17           SBCa #$17
17E4: 47              ASRa
17E5: 5E              ?????
17E6: 66 49           ROR +$09,U
17E8: 90 14           SUBa $14
17EA: 19              DAA
17EB: 58              ASLb
17EC: 66 62           ROR +$02,S
17EE: E1 14           CMPb -$0C,X
17F0: CF              ?????
17F1: B2 AF B3        SBCa $AFB3
17F4: 82 17           SBCa #$17
17F6: 2F 62           BLE $185A
17F8: D5 15           BITb $15
17FA: 7B              ?????
17FB: 14              ?????
17FC: FB B9 67        ADDb $B967
17FF: C0 D0           SUBb #$D0
1801: 15              ?????
1802: 82 17           SBCa #$17
1804: 55              ?????
1805: 5E              ?????
1806: 36 A1           PSHU ,PC,Y,CC
1808: 05              ?????
1809: 71              ?????
180A: B8 A0 23        EORa $A023
180D: 62              ?????
180E: 56              RORb
180F: D1 04           CMPb $04
1811: 71              ?????
1812: 6B              ?????
1813: A1 8E           CMPa ??
1815: 48              ASLa
1816: 94 14           ANDa $14
1818: 09 B3           ROL $B3
181A: 2E 04           BGT $1820
181C: 1D              SEX
181D: 0B              ?????
181E: 1B              ?????
181F: 0A 04           DEC $04
1821: 0B              ?????
1822: 0E 09           JMP $09
1824: 0D 05           TST $05
1826: 20 1D           BRA $1845
1828: 01              ?????
1829: 07 82           ASR $82
182B: 00 85           NEG $85
182D: 03 0B           COM $0B
182F: 0E 09           JMP $09
1831: 0D 05           TST $05
1833: 20 1D           BRA $1852
1835: 01              ?????
1836: 06 82           ROR $82
1838: 00 89           NEG $89
183A: 89 5D           ADCa #$5D
183C: 00 03           NEG $03
183E: 3F              SWI1
183F: C7              ?????
1840: DE 94           LDU $94
1842: 14              ?????
1843: 43              COMa
1844: 5E              ?????
1845: 16 BC DB        LBRA $D523
1848: 72              ?????
1849: 47              ASRa
184A: B9 53 BE        ADCa $53BE
184D: 8E 61 B8        LDX #$61B8
1850: 16 82 17        LBRA $9A6A
1853: 49              ROLa
1854: 5E              ?????
1855: 63 B1           COM [,Y++]
1857: 05              ?????
1858: BC 9E 61        CMPX $9E61
185B: CE B0 9B        LDU #$B09B
185E: 15              ?????
185F: 11 8D           ?????
1861: 5F              CLRb
1862: 4A              DECa
1863: 3A              ABX
1864: 15              ?????
1865: 8D 7B           BSR $18E2
1867: 3A              ABX
1868: 15              ?????
1869: 66 7B           ROR -$05,S
186B: D0 15           SUBb $15
186D: 82 17           SBCa #$17
186F: 47              ASRa
1870: 5E              ?????
1871: 66 49           ROR +$09,U
1873: 90 14           SUBa $14
1875: 19              DAA
1876: 58              ASLb
1877: 66 62           ROR +$02,S
1879: F3 17 0D        ADDD $170D
187C: 8D 2E           BSR $18AC
187E: 04 19           LSR $19
1880: 0B              ?????
1881: 17 0A 04        LBSR $2288
1884: 0C 0D           INC $0D
1886: 0A 00           DEC $00
1888: 88 14           EORa #$14
188A: 0D 05           TST $05
188C: 20 1D           BRA $18AB
188E: 01              ?????
188F: 06 82           ROR $82
1891: 01              ?????
1892: 02              ?????
1893: 00 90           NEG $90
1895: 03 02           COM $02
1897: 00 8A           NEG $8A
1899: 8A 3A           ORa #$3A
189B: 00 03           NEG $03
189D: 26 63           BNE $1902
189F: BE CB B5        LDX $CBB5
18A2: C3 B5 73        ADDd #$B573
18A5: 17 1B B8        LBSR $3460
18A8: E6 A4           LDb ,Y
18AA: 39              RTS
18AB: 17 DB 9F        LBSR $F44D
18AE: 56              RORb
18AF: D1 07           CMPb $07
18B1: 71              ?????
18B2: 96 D7           LDa $D7
18B4: C7              ?????
18B5: B5 66 49        BITa $6649
18B8: 15              ?????
18B9: EE 36           LDU -$0A,Y
18BB: A1 73           CMPa -$0D,S
18BD: 76 8E 48        ROR $8E48
18C0: F7 17 17        STb $1717
18C3: BA 04 0F        ORa $040F
18C6: 0B              ?????
18C7: 0D 0A           TST $0A
18C9: 04 02           LSR $02
18CB: 00 89           NEG $89
18CD: 02              ?????
18CE: 02              ?????
18CF: 00 8B           NEG $8B
18D1: 03 02           COM $02
18D3: 00 8D           NEG $8D
18D5: 8B 3F           ADDa #$3F
18D7: 00 03           NEG $03
18D9: 2F C7           BLE $18A2
18DB: DE 94           LDU $94
18DD: 14              ?????
18DE: 4B              ?????
18DF: 5E              ?????
18E0: 83 96 39        SUBd #$9639
18E3: 17 DB 9F        LBSR $F485
18E6: 56              RORb
18E7: D1 09           CMPb $09
18E9: 71              ?????
18EA: 7B              ?????
18EB: B1 66 17        CMPa $6617
18EE: 0F A0           CLR $A0
18F0: F3 17 0D        ADDD $170D
18F3: 8D 52           BSR $1947
18F5: F4 65 49        ANDb $6549
18F8: 77 47 CE        ASR $47CE
18FB: B5 86 5F        BITa $865F
18FE: 99 16           ADCa $16
1900: C2 B3           SBCb #$B3
1902: 90 14           SUBa $14
1904: 07 58           ASR $58
1906: 66 49           ROR +$09,U
1908: 2E 04           BGT $190E
190A: 0B              ?????
190B: 0B              ?????
190C: 09 0A           ROL $0A
190E: 01              ?????
190F: 02              ?????
1910: 00 8A           NEG $8A
1912: 03 02           COM $02
1914: 00 8C           NEG $8C
1916: 8C 44 00        CMPX #$4400
1919: 03 2F           COM $2F
191B: 63 BE           COM ??
191D: CB B5           ADDb #$B5
191F: C3 B5 39        ADDd #$B539
1922: 17 8E C5        LBSR $A7EA
1925: 39              RTS
1926: 17 DB 9F        LBSR $F4C8
1929: 56              RORb
192A: D1 0A           CMPb $0A
192C: 71              ?????
192D: 7A 79 F3        DEC $79F3
1930: 17 0D 8D        LBSR $26C0
1933: 56              RORb
1934: F4 DB 72        ANDb $DB72
1937: 16 A0 51        LBRA $B98B
193A: DB F0           ADDb $F0
193C: A4 91           ANDa [,X++]
193E: 7A D5 15        DEC $D515
1941: 89 17           ADCa #$17
1943: 82 17           SBCa #$17
1945: 59              ROLb
1946: 5E              ?????
1947: 66 62           ROR +$02,S
1949: 2E 04           BGT $194F
194B: 10 0B           ?????
194D: 0E 0A           JMP $0A
194F: 05              ?????
1950: 07 0D           ASR $0D
1952: 05              ?????
1953: 08 08           LSL $08
1955: 19              DAA
1956: 87              ?????
1957: 0C 04           INC $04
1959: 02              ?????
195A: 00 8B           NEG $8B
195C: 8D 4D           BSR $19AB
195E: 00 03           NEG $03
1960: 3D              MUL
1961: C7              ?????
1962: DE 94           LDU $94
1964: 14              ?????
1965: 4B              ?????
1966: 5E              ?????
1967: 83 96 DF        SUBd #$96DF
196A: 16 96 BE        LBRA $B02B
196D: 45              ?????
196E: 5E              ?????
196F: 4F              CLRa
1970: 72              ?????
1971: 74 4D 56        LSR $4D56
1974: F4 F4 72        ANDb $F472
1977: 4B              ?????
1978: 5E              ?????
1979: C3 B5 3B        ADDd #$B53B
197C: 16 B7 B1        LBRA $D130
197F: 94 AF           ANDa $AF
1981: 3F              SWI1
1982: A0 89 17 82     SUBa $1782,X
1986: 17 50 5E        LBSR $69E7
1989: BE A0 03        LDX $A003
198C: 71              ?????
198D: 33 98 52        LEAU [+$52,X]
1990: 45              ?????
1991: 65              ?????
1992: 49              ROLa
1993: 77 47 89        ASR $4789
1996: 17 82 17        LBSR $9BB0
1999: 59              ROLb
199A: 5E              ?????
199B: 66 62           ROR +$02,S
199D: 2E 04           BGT $19A3
199F: 0B              ?????
19A0: 0B              ?????
19A1: 09 0A           ROL $0A
19A3: 04 02           LSR $02
19A5: 00 8A           NEG $8A
19A7: 01              ?????
19A8: 02              ?????
19A9: 00 8E           NEG $8E
19AB: 8E 80 A2        LDX #$80A2
19AE: 00 03           NEG $03
19B0: 3B              RTI
19B1: C7              ?????
19B2: DE 94           LDU $94
19B4: 14              ?????
19B5: 4B              ?????
19B6: 5E              ?????
19B7: 83 96 3B        SUBd #$963B
19BA: 16 B7 B1        LBRA $D16E
19BD: 39              RTS
19BE: 17 DB 9F        LBSR $F560
19C1: 23 D1           BLS $1994
19C3: 13              SYNC
19C4: 54              LSRb
19C5: E7 B8 0D        STb [+$ D,Y]
19C8: 8D B8           BSR $1982
19CA: 16 FF 14        LBRA $18E1
19CD: 1B              ?????
19CE: 53              COMb
19CF: 91 7A           CMPa $7A
19D1: 56              RORb
19D2: 15              ?????
19D3: 5A              DECb
19D4: 62              ?????
19D5: 56              RORb
19D6: F4 F4 72        ANDb $F472
19D9: 43              COMa
19DA: 5E              ?????
19DB: 5B              ?????
19DC: B1 23 63        CMPa $2363
19DF: 0B              ?????
19E0: C0 04           SUBb #$04
19E2: 9A 53           ORa $53
19E4: BE 8E 48        LDX $8E48
19E7: 61              ?????
19E8: 17 82 C6        LBSR $9CB1
19EB: 2E 04           BGT $19F1
19ED: 62              ?????
19EE: 0B              ?????
19EF: 60 0A           NEG +$0A,X
19F1: 02              ?????
19F2: 02              ?????
19F3: 00 8D           NEG $8D
19F5: 01              ?????
19F6: 59              ROLb
19F7: 0E 57           JMP $57
19F9: 0D 1D           TST $1D
19FB: 01              ?????
19FC: 1E 20           EXG Y,D
19FE: 1D              SEX
19FF: 04 17           LSR $17
1A01: 5F              CLRb
1A02: BE 73 15        LDX $7315
1A05: C1 B1           CMPb #$B1
1A07: 3F              SWI1
1A08: DE B6           LDU $B6
1A0A: 14              ?????
1A0B: 5D              TSTb
1A0C: 9E D6           LDX $D6
1A0E: B5 DB 72        BITa $DB72
1A11: 1B              ?????
1A12: D0 99           SUBb $99
1A14: 16 C2 B3        LBRA $DCCA
1A17: 2E 0D           BGT $1A26
1A19: 34 20           PSHS ,Y
1A1B: 1D              SEX
1A1C: 01              ?????
1A1D: 0A 17           DEC $17
1A1F: 0A 00           DEC $00
1A21: 17 1E 8E        LBSR $38B2
1A24: 04 28           LSR $28
1A26: 5F              CLRb
1A27: BE 73 15        LDX $7315
1A2A: C1 B1           CMPb #$B1
1A2C: 3F              SWI1
1A2D: DE E1           LDU $E1
1A2F: 14              ?????
1A30: 35 92           PULS ,A,X,PC
1A32: 89 17           ADCa #$17
1A34: 43              COMa
1A35: 16 5B 66        LBRA $759E
1A38: 8E 48 FF        LDX #$48FF
1A3B: 15              ?????
1A3C: ED 93           STD [,--X]
1A3E: 09 15           ROL $15
1A40: 03 D2           COM $D2
1A42: 6B              ?????
1A43: BF 89 4E        STX $894E
1A46: 8B 54           ADDa #$54
1A48: C7              ?????
1A49: DE 99           LDU $99
1A4B: AF 39           STX -$07,Y
1A4D: 4A              DECa
1A4E: 00 8F           NEG $8F
1A50: 8F              ?????
1A51: 3A              ABX
1A52: 00 03           NEG $03
1A54: 2E 63           BGT $1AB9
1A56: BE CB B5        LDX $CBB5
1A59: C3 B5 7B        ADDd #$B57B
1A5C: 17 F3 8C        LBSR $0DEB
1A5F: 01              ?????
1A60: B3 45 90        SUBD $4590
1A63: 40              NEGa
1A64: 49              ROLa
1A65: F3 5F C3        ADDD $5FC3
1A68: 9E 09           LDX $09
1A6A: BA 5B 98        ORa $5B98
1A6D: 56              RORb
1A6E: D1 03           CMPb $03
1A70: 71              ?????
1A71: 5B              ?????
1A72: 17 BE 98        LBSR $D90D
1A75: 47              ASRa
1A76: 5E              ?????
1A77: 96 D7           LDa $D7
1A79: 89 17           ADCa #$17
1A7B: 82 17           SBCa #$17
1A7D: 55              ?????
1A7E: 5E              ?????
1A7F: 36 A1           PSHU ,PC,Y,CC
1A81: 9B 76           ADDa $76
1A83: 04 07           LSR $07
1A85: 0B              ?????
1A86: 05              ?????
1A87: 0A 02           DEC $02
1A89: 02              ?????
1A8A: 00 8E           NEG $8E
1A8C: 90 80           SUBa $80
1A8E: A2 00           SBCa +$00,X
1A90: 03 56           COM $56
1A92: C7              ?????
1A93: DE 94           LDU $94
1A95: 14              ?????
1A96: 43              COMa
1A97: 5E              ?????
1A98: 16 BC DB        LBRA $D776
1A9B: 72              ?????
1A9C: 04 9A           LSR $9A
1A9E: 53              COMb
1A9F: BE 8E 61        LDX $8E61
1AA2: B8 16 82        EORa $1682
1AA5: 17 49 5E        LBSR $6406
1AA8: 63 B1           COM [,Y++]
1AAA: 05              ?????
1AAB: BC 9E 61        CMPX $9E61
1AAE: CE B0 9B        LDU #$B09B
1AB1: 15              ?????
1AB2: 11 8D           ?????
1AB4: 5F              CLRb
1AB5: 4A              DECa
1AB6: 3A              ABX
1AB7: 15              ?????
1AB8: 8D 7B           BSR $1B35
1ABA: 3A              ABX
1ABB: 15              ?????
1ABC: 66 7B           ROR -$05,S
1ABE: D0 15           SUBb $15
1AC0: 82 17           SBCa #$17
1AC2: 47              ASRa
1AC3: 5E              ?????
1AC4: 66 49           ROR +$09,U
1AC6: 90 14           SUBa $14
1AC8: 19              DAA
1AC9: 58              ASLb
1ACA: 66 62           ROR +$02,S
1ACC: F3 17 0D        ADDD $170D
1ACF: 8D 56           BSR $1B27
1AD1: F4 F4 72        ANDb $F472
1AD4: 4B              ?????
1AD5: 5E              ?????
1AD6: C3 B5 09        ADDd #$B509
1AD9: 15              ?????
1ADA: A3 A0           SUBD ,Y+
1ADC: 03 A0           COM $A0
1ADE: 5F              CLRb
1ADF: BE 99 16        LDX $9916
1AE2: C2 B3           SBCb #$B3
1AE4: F3 17 17        ADDD $1717
1AE7: 8D 04           BSR $1AED
1AE9: 47              ASRa
1AEA: 0B              ?????
1AEB: 45              ?????
1AEC: 0A 02           DEC $02
1AEE: 02              ?????
1AEF: 00 89           NEG $89
1AF1: 03 02           COM $02
1AF3: 00 A0           NEG $A0
1AF5: 01              ?????
1AF6: 36 0E           PSHU ,DP,B,A
1AF8: 34 0D           PSHS ,DP,B,CC
1AFA: 14              ?????
1AFB: 01              ?????
1AFC: 1B              ?????
1AFD: 04 10           LSR $10
1AFF: 5F              CLRb
1B00: BE 09 15        LDX $0915
1B03: A3 A0           SUBD ,Y+
1B05: 89 4E           ADCa #$4E
1B07: A5 54           BITa -$0C,U
1B09: DB 16           ADDb $16
1B0B: D3 B9           ADDD $B9
1B0D: BF 6C 0D        STX $6C0D
1B10: 1C 00           ANDCC #$00
1B12: 91 17           CMPa $17
1B14: 1B              ?????
1B15: 91 04           CMPa $04
1B17: 12              NOP 
1B18: 5F              CLRb
1B19: BE 09 15        LDX $0915
1B1C: A3 A0           SUBD ,Y+
1B1E: C9 54           ADCb #$54
1B20: B5 B7 AF        BITa $B7AF
1B23: 14              ?????
1B24: 90 73           SUBa $73
1B26: 1B              ?????
1B27: 58              ASLb
1B28: 3F              SWI1
1B29: A1 17           CMPa -$09,X
1B2B: 1C 00           ANDCC #$00
1B2D: 04 02           LSR $02
1B2F: 00 92           NEG $92
1B31: 91 80           CMPa $80
1B33: 8F              ?????
1B34: 00 03           NEG $03
1B36: 22 C7           BHI $1AFF
1B38: DE 94           LDU $94
1B3A: 14              ?????
1B3B: 4B              ?????
1B3C: 5E              ?????
1B3D: 83 96 CB        SUBd #$96CB
1B40: 17 4E C5        LBSR $6A08
1B43: FB 17 53        ADDb $1753
1B46: BE 4E 45        LDX $4E45
1B49: 31 49           LEAY +$09,U
1B4B: 46              RORa
1B4C: 5E              ?????
1B4D: 44              LSRa
1B4E: A0 89 17 82     SUBa $1782,X
1B52: 17 55 5E        LBSR $70B3
1B55: 36 A1           PSHU ,PC,Y,CC
1B57: 9B 76           ADDa $76
1B59: 04 68           LSR $68
1B5B: 0B              ?????
1B5C: 66 0A           ROR +$0A,X
1B5E: 02              ?????
1B5F: 2F 0E           BLE $1B6F
1B61: 2D 0D           BLT $1B70
1B63: 10 01           ?????
1B65: 1B              ?????
1B66: 04 0C           LSR $0C
1B68: 5F              CLRb
1B69: BE 09 15        LDX $0915
1B6C: A3 A0           SUBD ,Y+
1B6E: 4B              ?????
1B6F: 7B              ?????
1B70: 2F B8           BLE $1B2A
1B72: 9B C1           ADDa $C1
1B74: 0D 19           TST $19
1B76: 00 90           NEG $90
1B78: 17 1B 90        LBSR $370B
1B7B: 04 0F           LSR $0F
1B7D: 5F              CLRb
1B7E: BE 09 15        LDX $0915
1B81: A3 A0           SUBD ,Y+
1B83: C9 54           ADCb #$54
1B85: B5 B7 89        BITa $B789
1B88: 14              ?????
1B89: D0 47           SUBb $47
1B8B: 2E 17           BGT $1BA4
1B8D: 1C 00           ANDCC #$00
1B8F: 11 32           ?????
1B91: 0E 30           JMP $30
1B93: 0D 10           TST $10
1B95: 08 1C           LSL $1C
1B97: 04 0C           LSR $0C
1B99: 8D 7B           BSR $1C16
1B9B: 8E 14 63        LDX #$1463
1B9E: B1 FB 5C        CMPa $FB5C
1BA1: 5F              CLRb
1BA2: A0 1B           SUBa -$05,X
1BA4: 9C 0D           CMPX $0D
1BA6: 1C 08           ANDCC #$08
1BA8: 1B              ?????
1BA9: 17 1C 91        LBSR $383D
1BAC: 17 1B 00        LBSR $36AF
1BAF: 04 12           LSR $12
1BB1: 64 B7           LSR ??
1BB3: B7 C6 B0        STa $C6B0
1BB6: C6 D6           LDb #$D6
1BB8: 6A DB           DEC [D,U]
1BBA: 72              ?????
1BBB: 81 5B           CMPa #$5B
1BBD: 91 AF           CMPa $AF
1BBF: F0 A4 5B        SUBb $A45B
1BC2: BB 92 4B        ADDa $924B
1BC5: 00 03           NEG $03
1BC7: 3B              RTI
1BC8: C7              ?????
1BC9: DE 94           LDU $94
1BCB: 14              ?????
1BCC: 43              COMa
1BCD: 5E              ?????
1BCE: 16 BC DB        LBRA $D8AC
1BD1: 72              ?????
1BD2: 9E 61           LDX $61
1BD4: D0 B0           SUBb $B0
1BD6: 9B 53           ADDa $53
1BD8: 6B              ?????
1BD9: BF 4E 45        STX $4E45
1BDC: 11 A0           ?????
1BDE: FB 14 4B        ADDb $144B
1BE1: B2 70 C0        SBCa $70C0
1BE4: 6E 98 FA        JMP [-$ 6,X]
1BE7: 17 DA 78        LBSR $F662
1BEA: 3F              SWI1
1BEB: 16 0D 47        LBRA $2935
1BEE: F7 17 17        STb $1717
1BF1: BA 82 17        ORa $8217
1BF4: 2F 62           BLE $1C58
1BF6: D5 15           BITb $15
1BF8: 7B              ?????
1BF9: 14              ?????
1BFA: 55              ?????
1BFB: A4 09           ANDa +$09,X
1BFD: B7 47 5E        STa $475E
1C00: 66 49           ROR +$09,U
1C02: 2E 04           BGT $1C08
1C04: 0B              ?????
1C05: 0B              ?????
1C06: 09 0A           ROL $0A
1C08: 03 02           COM $02
1C0A: 00 90           NEG $90
1C0C: 04 02           LSR $02
1C0E: 00 93           NEG $93
1C10: 93 22           SUBd $22
1C12: 00 03           NEG $03
1C14: 12              NOP 
1C15: C7              ?????
1C16: DE 94           LDU $94
1C18: 14              ?????
1C19: 4B              ?????
1C1A: 5E              ?????
1C1B: 96 96           LDa $96
1C1D: DB 72           ADDb $72
1C1F: 54              LSRb
1C20: 59              ROLb
1C21: D6 83           LDb $83
1C23: 98 C5           EORa $C5
1C25: 57              ASRb
1C26: 61              ?????
1C27: 04 0B           LSR $0B
1C29: 0B              ?????
1C2A: 09 0A           ROL $0A
1C2C: 03 02           COM $02
1C2E: 00 92           NEG $92
1C30: 04 02           LSR $02
1C32: 00 94           NEG $94
1C34: 94 58           ANDa $58
1C36: 00 03           NEG $03
1C38: 3B              RTI
1C39: C7              ?????
1C3A: DE 94           LDU $94
1C3C: 14              ?????
1C3D: 43              COMa
1C3E: 5E              ?????
1C3F: 16 BC DB        LBRA $D91D
1C42: 72              ?????
1C43: 9E 61           LDX $61
1C45: D0 B0           SUBb $B0
1C47: 9B 53           ADDa $53
1C49: 6B              ?????
1C4A: BF 4E 45        STX $4E45
1C4D: 11 A0           ?????
1C4F: FB 14 4B        ADDb $144B
1C52: B2 70 C0        SBCa $70C0
1C55: 6E 98 FA        JMP [-$ 6,X]
1C58: 17 DA 78        LBSR $F6D3
1C5B: 3F              SWI1
1C5C: 16 0D 47        LBRA $29A6
1C5F: 23 15           BLS $1C76
1C61: 17 BA 82        LBSR $D6E6
1C64: 17 2F 62        LBSR $4BC9
1C67: D5 15           BITb $15
1C69: 7B              ?????
1C6A: 14              ?????
1C6B: 55              ?????
1C6C: A4 09           ANDa +$09,X
1C6E: B7 59 5E        STa $595E
1C71: 66 62           ROR +$02,S
1C73: 2E 04           BGT $1C79
1C75: 18              ?????
1C76: 0B              ?????
1C77: 16 0A 03        LBRA $267D
1C7A: 02              ?????
1C7B: 00 93           NEG $93
1C7D: 04 0F           LSR $0F
1C7F: 0E 0D           JMP $0D
1C81: 0D 09           TST $09
1C83: 20 1D           BRA $1CA2
1C85: 03 00           COM $00
1C87: 16 17 15        LBRA $339F
1C8A: 95 0C           BITa $0C
1C8C: 00 95           NEG $95
1C8E: 95 32           BITa $32
1C90: 00 03           NEG $03
1C92: 20 C7           BRA $1C5B
1C94: DE 94           LDU $94
1C96: 14              ?????
1C97: 4B              ?????
1C98: 5E              ?????
1C99: 83 96 3B        SUBd #$963B
1C9C: 16 B7 B1        LBRA $D450
1C9F: 39              RTS
1CA0: 17 DB 9F        LBSR $F842
1CA3: 56              RORb
1CA4: D1 03           CMPb $03
1CA6: 71              ?????
1CA7: 5B              ?????
1CA8: 17 BE 98        LBSR $DB43
1CAB: 47              ASRa
1CAC: 5E              ?????
1CAD: 96 D7           LDa $D7
1CAF: 23 15           BLS $1CC6
1CB1: 17 BA 04        LBSR $D6B8
1CB4: 0D 0B           TST $0B
1CB6: 0B              ?????
1CB7: 0A 36           DEC $36
1CB9: 01              ?????
1CBA: 8F              ?????
1CBB: 17 01 8F        LBSR $1E4D
1CBE: 03 02           COM $02
1CC0: 00 94           NEG $94
1CC2: 96 30           LDa $30
1CC4: 00 03           NEG $03
1CC6: 18              ?????
1CC7: C7              ?????
1CC8: DE 94           LDU $94
1CCA: 14              ?????
1CCB: 4B              ?????
1CCC: 5E              ?????
1CCD: 83 96 FF        SUBd #$96FF
1CD0: 14              ?????
1CD1: 97 9A           STa $9A
1CD3: FB 14 4B        ADDb $144B
1CD6: B2 4F 59        SBCa $4F59
1CD9: 0C A3           INC $A3
1CDB: 91 C5           CMPa $C5
1CDD: FF 8B 04        STU $8B04
1CE0: 13              SYNC
1CE1: 0B              ?????
1CE2: 11 0A           ?????
1CE4: 01              ?????
1CE5: 02              ?????
1CE6: 00 A3           NEG $A3
1CE8: 02              ?????
1CE9: 02              ?????
1CEA: 00 A4           NEG $A4
1CEC: 04 02           LSR $02
1CEE: 00 97           NEG $97
1CF0: 03 02           COM $02
1CF2: 00 A4           NEG $A4
1CF4: 97 30           STa $30
1CF6: 00 03           NEG $03
1CF8: 18              ?????
1CF9: C7              ?????
1CFA: DE 94           LDU $94
1CFC: 14              ?????
1CFD: 4B              ?????
1CFE: 5E              ?????
1CFF: 83 96 FB        SUBd #$96FB
1D02: 14              ?????
1D03: 4B              ?????
1D04: B2 F0 59        SBCa $F059
1D07: 9B B7           ADDa $B7
1D09: 4F              CLRa
1D0A: 59              ROLb
1D0B: 0C A3           INC $A3
1D0D: 91 C5           CMPa $C5
1D0F: FF 8B 04        STU $8B04
1D12: 13              SYNC
1D13: 0B              ?????
1D14: 11 0A           ?????
1D16: 01              ?????
1D17: 02              ?????
1D18: 00 A2           NEG $A2
1D1A: 02              ?????
1D1B: 02              ?????
1D1C: 00 96           NEG $96
1D1E: 03 02           COM $02
1D20: 00 A3           NEG $A3
1D22: 04 02           LSR $02
1D24: 00 98           NEG $98
1D26: 98 40           EORa $40
1D28: 00 03           NEG $03
1D2A: 28 6C           BVC $1D98
1D2C: BE 29 A1        LDX $29A1
1D2F: 16 71 DB        LBRA $8F0D
1D32: 72              ?????
1D33: F0 81 BF        SUBb $81BF
1D36: 6D 51           TST -$0F,U
1D38: 18              ?????
1D39: 55              ?????
1D3A: C2 1B           SBCb #$1B
1D3C: 60 5F           NEG -$01,U
1D3E: BE 23 15        LDX $2315
1D41: F3 B9 0E        ADDD $B90E
1D44: D0 11           SUBb $11
1D46: 8A 83           ORa #$83
1D48: 64 84           LSR ,X
1D4A: 15              ?????
1D4B: 96 5F           LDa $5F
1D4D: 7F 17 E6        CLR $17E6
1D50: 93 DB           SUBd $DB
1D52: 63 04           COM +$04,X
1D54: 13              SYNC
1D55: 0B              ?????
1D56: 11 0A           ?????
1D58: 01              ?????
1D59: 02              ?????
1D5A: 00 9B           NEG $9B
1D5C: 02              ?????
1D5D: 02              ?????
1D5E: 00 99           NEG $99
1D60: 03 02           COM $02
1D62: 00 97           NEG $97
1D64: 04 02           LSR $02
1D66: 00 9E           NEG $9E
1D68: 99 44           ADCa $44
1D6A: 00 03           NEG $03
1D6C: 2C 83           BGE $1CF1
1D6E: 7A 45 45        DEC $4545
1D71: E3 8B           ADDD D,X
1D73: 10 B2           ?????
1D75: C4 6A           ANDb #$6A
1D77: 59              ROLb
1D78: 60 5B           NEG -$05,U
1D7A: B1 C7 DE        CMPa $C7DE
1D7D: 66 17           ROR -$09,X
1D7F: 8E 48 D6        LDX #$48D6
1D82: B5 DB 72        BITa $DB72
1D85: 47              ASRa
1D86: B9 53 BE        ADCa $53BE
1D89: 0E D0           JMP $D0
1D8B: 11 8A           ?????
1D8D: 83 64 84        SUBd #$6484
1D90: 15              ?????
1D91: 96 5F           LDa $5F
1D93: 7F 17 E6        CLR $17E6
1D96: 93 DB           SUBd $DB
1D98: 63 04           COM +$04,X
1D9A: 13              SYNC
1D9B: 0B              ?????
1D9C: 11 0A           ?????
1D9E: 01              ?????
1D9F: 02              ?????
1DA0: 00 9F           NEG $9F
1DA2: 02              ?????
1DA3: 02              ?????
1DA4: 00 96           NEG $96
1DA6: 03 02           COM $02
1DA8: 00 98           NEG $98
1DAA: 04 02           LSR $02
1DAC: 00 9A           NEG $9A
1DAE: 9A 59           ORa $59
1DB0: 00 03           NEG $03
1DB2: 41              ?????
1DB3: 6C BE           INC ??
1DB5: 29 A1           BVS $1D58
1DB7: 16 71 DB        LBRA $8F95
1DBA: 72              ?????
1DBB: F0 59 9B        SUBb $599B
1DBE: B7 8E C5        STa $8EC5
1DC1: 31 62           LEAY +$02,S
1DC3: 09 B3           ROL $B3
1DC5: 76 BE 51        ROR $BE51
1DC8: 18              ?????
1DC9: 45              ?????
1DCA: C2 83           SBCb #$83
1DCC: 48              ASLa
1DCD: A7 B7           STa ??
1DCF: 82 17           SBCa #$17
1DD1: 49              ROLa
1DD2: 5E              ?????
1DD3: 63 B1           COM [,Y++]
1DD5: 04 BC           LSR $BC
1DD7: 00 B3           NEG $B3
1DD9: 5B              ?????
1DDA: E3 16           ADDD -$0A,X
1DDC: 6C 4B           INC +$0B,U
1DDE: 62              ?????
1DDF: 03 A0           COM $A0
1DE1: 5F              CLRb
1DE2: BE F7 17        LDX $F717
1DE5: F3 B9 0E        ADDD $B90E
1DE8: D0 11           SUBb $11
1DEA: 8A 96           ORa #$96
1DEC: 64 DB           LSR [D,U]
1DEE: 72              ?????
1DEF: EF BD FF A5     STU [$FFA5,PC]
1DF3: 2E 04           BGT $1DF9
1DF5: 13              SYNC
1DF6: 0B              ?????
1DF7: 11 0A           ?????
1DF9: 01              ?????
1DFA: 02              ?????
1DFB: 00 9B           NEG $9B
1DFD: 02              ?????
1DFE: 02              ?????
1DFF: 00 99           NEG $99
1E01: 03 02           COM $02
1E03: 00 9C           NEG $9C
1E05: 04 02           LSR $02
1E07: 00 A4           NEG $A4
1E09: 9B 4D           ADDa $4D
1E0B: 00 03           NEG $03
1E0D: 35 6C           PULS ,B,DP,Y,U
1E0F: BE 29 A1        LDX $29A1
1E12: 03 71           COM $71
1E14: 73 15 0B        COM $150B
1E17: A3 96           SUBD [A,X]
1E19: 96 DB           LDa $DB
1E1B: 72              ?????
1E1C: F0 81 BF        SUBb $81BF
1E1F: 6D 51           TST -$0F,U
1E21: 18              ?????
1E22: 45              ?????
1E23: C2 83           SBCb #$83
1E25: 48              ASLa
1E26: A7 B7           STa ??
1E28: 82 17           SBCa #$17
1E2A: 50              NEGb
1E2B: 5E              ?????
1E2C: BE A0 19        LDX $A019
1E2F: 71              ?????
1E30: 46              RORa
1E31: 48              ASLa
1E32: B8 16 7B        EORa $167B
1E35: 14              ?????
1E36: 89 91           ADCa #$91
1E38: 08 99           LSL $99
1E3A: D7 78           STb $78
1E3C: B3 9A EF        SUBD $9AEF
1E3F: BD FF A5        JSR $FFA5
1E42: 2E 04           BGT $1E48
1E44: 13              SYNC
1E45: 0B              ?????
1E46: 11 0A           ?????
1E48: 01              ?????
1E49: 02              ?????
1E4A: 00 A2           NEG $A2
1E4C: 02              ?????
1E4D: 02              ?????
1E4E: 00 9D           NEG $9D
1E50: 04 02           LSR $02
1E52: 00 9A           NEG $9A
1E54: 03 02           COM $02
1E56: 00 98           NEG $98
1E58: 9C 3A           CMPX $3A
1E5A: 00 03           NEG $03
1E5C: 26 C7           BNE $1E25
1E5E: DE 94           LDU $94
1E60: 14              ?????
1E61: 55              ?????
1E62: 5E              ?????
1E63: 50              NEGb
1E64: BD 90 5A        JSR $905A
1E67: C4 6A           ANDb #$6A
1E69: 59              ROLb
1E6A: 60 5B           NEG -$05,U
1E6C: B1 5F BE        CMPa $5FBE
1E6F: F7 17 F3        STb $17F3
1E72: B9 9E 61        ADCa $9E61
1E75: D0 B0           SUBb $B0
1E77: 9B 53           ADDa $53
1E79: C3 9E 5F        ADDd #$9E5F
1E7C: BE 7F 17        LDX $7F17
1E7F: E6 93           LDb [,--X]
1E81: DB 63           ADDb $63
1E83: 04 0F           LSR $0F
1E85: 0B              ?????
1E86: 0D 0A           TST $0A
1E88: 01              ?????
1E89: 02              ?????
1E8A: 00 9D           NEG $9D
1E8C: 02              ?????
1E8D: 02              ?????
1E8E: 00 9F           NEG $9F
1E90: 04 02           LSR $02
1E92: 00 9A           NEG $9A
1E94: 9D 80           JSR $80
1E96: B3 00 03        SUBD $0003
1E99: 12              NOP 
1E9A: C7              ?????
1E9B: DE 94           LDU $94
1E9D: 14              ?????
1E9E: 43              COMa
1E9F: 5E              ?????
1EA0: 16 BC DB        LBRA $DB7E
1EA3: 72              ?????
1EA4: 04 9A           LSR $9A
1EA6: 53              COMb
1EA7: BE 0E D0        LDX $0ED0
1EAA: 9B 8F           ADDa $8F
1EAC: 04 80           LSR $80
1EAE: 9B 0B           ADDa $0B
1EB0: 80 98           SUBa #$98
1EB2: 0A 01           DEC $01
1EB4: 02              ?????
1EB5: 00 9B           NEG $9B
1EB7: 03 02           COM $02
1EB9: 00 9E           NEG $9E
1EBB: 17 80 88        LBSR $9F46
1EBE: 0D 80           TST $80
1EC0: 85 08           BITa #$08
1EC2: 21 0E           BRN $1ED2
1EC4: 80 80           SUBa #$80
1EC6: 0D 54           TST $54
1EC8: 05              ?????
1EC9: 7F 04 2A        CLR $042A
1ECC: C7              ?????
1ECD: DE DE           LDU $DE
1ECF: 14              ?????
1ED0: 64 7A           LSR -$06,S
1ED2: 89 17           ADCa #$17
1ED4: 82 17           SBCa #$17
1ED6: 54              LSRb
1ED7: 5E              ?????
1ED8: 38              ?????
1ED9: A0 3B           SUBa -$05,Y
1EDB: F4 4B 49        ANDb $4B49
1EDE: C7              ?????
1EDF: DE 66           LDU $66
1EE1: 17 D3 61        LBSR $F245
1EE4: 03 A0           COM $A0
1EE6: 5F              CLRb
1EE7: BE 39 17        LDX $3917
1EEA: E6 9E           LDb ??
1EEC: D6 15           LDb $15
1EEE: E1 14           CMPb -$0C,X
1EF0: FB 8C 17        ADDb $8C17
1EF3: A7 5B           STa -$05,U
1EF5: BB 17 36        ADDa $1736
1EF8: 00 17           NEG $17
1EFA: 29 FF           BVS $1EFB
1EFC: 17 2A FF        LBSR $49FE
1EFF: 17 2B FF        LBSR $4B01
1F02: 17 2C FF        LBSR $4C04
1F05: 17 2D FF        LBSR $4D07
1F08: 17 2E FF        LBSR $4E0A
1F0B: 17 31 FF        LBSR $510D
1F0E: 17 34 FF        LBSR $5410
1F11: 17 35 FF        LBSR $5513
1F14: 17 3A FF        LBSR $5A16
1F17: 17 3C 00        LBSR $5B1A
1F1A: 00 81           NEG $81
1F1C: 04 28           LSR $28
1F1E: 4B              ?????
1F1F: 49              ROLa
1F20: C7              ?????
1F21: DE DE           LDU $DE
1F23: 14              ?????
1F24: 64 7A           LSR -$06,S
1F26: 16 EE DB        LBRA $0E04
1F29: 72              ?????
1F2A: 10 CB           ?????
1F2C: 49              ROLa
1F2D: 5E              ?????
1F2E: CF              ?????
1F2F: 7B              ?????
1F30: D9 B5           ADCb $B5
1F32: 3B              RTI
1F33: 4A              DECa
1F34: 8E 48 51        LDX #$4851
1F37: 18              ?????
1F38: 48              ASLa
1F39: C2 46           SBCb #$46
1F3B: 48              ASLa
1F3C: 89 17           ADCa #$17
1F3E: 82 17           SBCa #$17
1F40: 49              ROLa
1F41: 5E              ?????
1F42: 07 B3           ASR $B3
1F44: 57              ASRb
1F45: 98 04           EORa $04
1F47: 02              ?????
1F48: 00 9C           NEG $9C
1F4A: 9E 25           LDX $25
1F4C: 00 03           NEG $03
1F4E: 11 C7           ?????
1F50: DE 94           LDU $94
1F52: 14              ?????
1F53: 43              COMa
1F54: 5E              ?????
1F55: 16 BC DB        LBRA $DC33
1F58: 72              ?????
1F59: 95 5F           BITa $5F
1F5B: 19              DAA
1F5C: BC 46 48        CMPX $4648
1F5F: 2E 04           BGT $1F65
1F61: 0F 0B           CLR $0B
1F63: 0D 0A           TST $0A
1F65: 01              ?????
1F66: 02              ?????
1F67: 00 9D           NEG $9D
1F69: 02              ?????
1F6A: 02              ?????
1F6B: 00 9F           NEG $9F
1F6D: 03 02           COM $02
1F6F: 00 98           NEG $98
1F71: 9F 26           STX $26
1F73: 00 03           NEG $03
1F75: 12              NOP 
1F76: C7              ?????
1F77: DE 94           LDU $94
1F79: 14              ?????
1F7A: 43              COMa
1F7B: 5E              ?????
1F7C: 16 BC DB        LBRA $DC5A
1F7F: 72              ?????
1F80: 47              ASRa
1F81: B9 53 BE        ADCa $53BE
1F84: 0E D0           JMP $D0
1F86: 9B 8F           ADDa $8F
1F88: 04 0F           LSR $0F
1F8A: 0B              ?????
1F8B: 0D 0A           TST $0A
1F8D: 04 02           LSR $02
1F8F: 00 9C           NEG $9C
1F91: 03 02           COM $02
1F93: 00 9E           NEG $9E
1F95: 02              ?????
1F96: 02              ?????
1F97: 00 99           NEG $99
1F99: A0 20           SUBa +$00,Y
1F9B: 00 03           NEG $03
1F9D: 14              ?????
1F9E: C7              ?????
1F9F: DE 94           LDU $94
1FA1: 14              ?????
1FA2: 4B              ?????
1FA3: 5E              ?????
1FA4: 83 96 CF        SUBd #$96CF
1FA7: 17 7B B4        LBSR $9B5E
1FAA: E3 B8 F3        ADDD [-$ D,Y]
1FAD: 8C 01 B3        CMPX #$01B3
1FB0: DB 95           ADDb $95
1FB2: 04 07           LSR $07
1FB4: 0B              ?????
1FB5: 05              ?????
1FB6: 0A 04           DEC $04
1FB8: 02              ?????
1FB9: 00 90           NEG $90
1FBB: A1 2C           CMPa +$0C,Y
1FBD: 00 03           NEG $03
1FBF: 20 C7           BRA $1F88
1FC1: DE 94           LDU $94
1FC3: 14              ?????
1FC4: 4B              ?????
1FC5: 5E              ?????
1FC6: 83 96 5F        SUBd #$965F
1FC9: 17 46 48        LBSR $6614
1FCC: 39              RTS
1FCD: 17 DB 9F        LBSR $FB6F
1FD0: 56              RORb
1FD1: D1 03           CMPb $03
1FD3: 71              ?????
1FD4: 5B              ?????
1FD5: 17 BE 98        LBSR $DE70
1FD8: 47              ASRa
1FD9: 5E              ?????
1FDA: 96 D7           LDa $D7
1FDC: 23 15           BLS $1FF3
1FDE: 17 BA 04        LBSR $D9E5
1FE1: 07 0B           ASR $0B
1FE3: 05              ?????
1FE4: 0A 03           DEC $03
1FE6: 02              ?????
1FE7: 00 84           NEG $84
1FE9: A2 30           SBCa -$10,Y
1FEB: 00 03           NEG $03
1FED: 18              ?????
1FEE: C7              ?????
1FEF: DE 94           LDU $94
1FF1: 14              ?????
1FF2: 4B              ?????
1FF3: 5E              ?????
1FF4: 83 96 FB        SUBd #$96FB
1FF7: 14              ?????
1FF8: 4B              ?????
1FF9: B2 4F 59        SBCa $4F59
1FFC: 06 A3           ROR $A3
1FFE: 9D 61           JSR $61
2000: 4C              INCa
2001: 5E              ?????
2002: 91 C5           CMPa $C5
2004: FF 8B 04        STU $8B04
2007: 13              SYNC
2008: 0B              ?????
2009: 11 0A           ?????
200B: 03 02           COM $02
200D: 00 A4           NEG $A4
200F: 01              ?????
2010: 02              ?????
2011: 00 96           NEG $96
2013: 02              ?????
2014: 02              ?????
2015: 00 A3           NEG $A3
2017: 04 02           LSR $02
2019: 00 97           NEG $97
201B: A3 30           SUBD -$10,Y
201D: 00 03           NEG $03
201F: 18              ?????
2020: C7              ?????
2021: DE 94           LDU $94
2023: 14              ?????
2024: 4B              ?????
2025: 5E              ?????
2026: 83 96 FF        SUBd #$96FF
2029: 14              ?????
202A: 97 9A           STa $9A
202C: FB 14 D3        ADDb $14D3
202F: 93 54           SUBd $54
2031: 59              ROLb
2032: CC 83 91        LDD #$8391
2035: C5 FF           BITb #$FF
2037: 8B 04           ADDa #$04
2039: 13              SYNC
203A: 0B              ?????
203B: 11 0A           ?????
203D: 03 02           COM $02
203F: 00 A4           NEG $A4
2041: 01              ?????
2042: 02              ?????
2043: 00 A2           NEG $A2
2045: 02              ?????
2046: 02              ?????
2047: 00 96           NEG $96
2049: 04 02           LSR $02
204B: 00 97           NEG $97
204D: A4 30           ANDa -$10,Y
204F: 00 03           NEG $03
2051: 18              ?????
2052: C7              ?????
2053: DE 94           LDU $94
2055: 14              ?????
2056: 4B              ?????
2057: 5E              ?????
2058: 83 96 FB        SUBd #$96FB
205B: 14              ?????
205C: D3 93           ADDD $93
205E: 54              LSRb
205F: 59              ROLb
2060: C6 83           LDb #$83
2062: 9D 61           JSR $61
2064: 4C              INCa
2065: 5E              ?????
2066: 91 C5           CMPa $C5
2068: FF 8B 04        STU $8B04
206B: 13              SYNC
206C: 0B              ?????
206D: 11 0A           ?????
206F: 03 02           COM $02
2071: 00 A3           NEG $A3
2073: 01              ?????
2074: 02              ?????
2075: 00 A2           NEG $A2
2077: 02              ?????
2078: 02              ?????
2079: 00 96           NEG $96
207B: 04 02           LSR $02
207D: 00 A3           NEG $A3
207F: A5 2C           BITa +$0C,Y
2081: 00 03           NEG $03
2083: 20 C7           BRA $204C
2085: DE 94           LDU $94
2087: 14              ?????
2088: 4B              ?????
2089: 5E              ?????
208A: 96 96           LDa $96
208C: DB 72           ADDb $72
208E: A5 B7           BITa ??
2090: 76 B1 DB        ROR $B1DB
2093: 16 D3 B9        LBRA $F44F
2096: 9B 6C           ADDa $6C
2098: 23 D1           BLS $206B
209A: 13              SYNC
209B: 54              LSRb
209C: E3 8B           ADDD D,X
209E: 0B              ?????
209F: 5C              INCb
20A0: 95 5F           BITa $5F
20A2: 9B C1           ADDa $C1
20A4: 04 07           LSR $07
20A6: 0B              ?????
20A7: 05              ?????
20A8: 0A 03           DEC $03
20AA: 02              ?????
20AB: 00 A6           NEG $A6
20AD: A6 50           LDa -$10,U
20AF: 00 03           NEG $03
20B1: 2C C7           BGE $207A
20B3: DE 94           LDU $94
20B5: 14              ?????
20B6: 43              COMa
20B7: 5E              ?????
20B8: 16 BC DB        LBRA $DD96
20BB: 72              ?????
20BC: 8E 61 B8        LDX #$61B8
20BF: 16 82 17        LBRA $A2D9
20C2: 52              ?????
20C3: 5E              ?????
20C4: 65              ?????
20C5: 49              ROLa
20C6: 77 47 56        ASR $4756
20C9: F4 F4 72        ANDb $F472
20CC: 4B              ?????
20CD: 5E              ?????
20CE: C3 B5 A9        ADDd #$B5A9
20D1: 15              ?????
20D2: DB 8B           ADDb $8B
20D4: 83 7A 5F        SUBd #$7A5F
20D7: BE D7 14        LDX $D714
20DA: 43              COMa
20DB: 7A CF 98        DEC $CF98
20DE: 04 1F           LSR $1F
20E0: 0B              ?????
20E1: 1D              SEX
20E2: 0A 04           DEC $04
20E4: 02              ?????
20E5: 00 A5           NEG $A5
20E7: 17 05 0D        LBSR $25F7
20EA: 03 08           COM $08
20EC: 2C 91           BGE $207F
20EE: 36 05           PSHU ,B,CC
20F0: 0D 03           TST $03
20F2: 08 2C           LSL $2C
20F4: 91 37           CMPa $37
20F6: 05              ?????
20F7: 0D 03           TST $03
20F9: 08 2C           LSL $2C
20FB: 91 33           CMPa $33
20FD: 01              ?????
20FE: 91 00           CMPa $00
2100: 91 3A           CMPa $3A
2102: 01              ?????
2103: 03 00           COM $00
2105: 00 00           NEG $00
2107: 03 03           COM $03
2109: 00 00           NEG $00
210B: 00 06           NEG $06
210D: 48              ASLa
210E: 82 00           SBCa #$00
2110: 80 02           SUBa #$02
2112: 02              ?????
2113: E9 B3           ADCb [,--Y]
2115: 07 3F           ASR $3F
2117: 0B              ?????
2118: 3D              MUL
2119: 0A 0C           DEC $0C
211B: 01              ?????
211C: 8C 36 01        CMPX #$3601
211F: 8A 33           ORa #$33
2121: 01              ?????
2122: 8A 34           ORa #$34
2124: 01              ?????
2125: 8A 35           ORa #$35
2127: 01              ?????
2128: 8B 2D           ADDa #$2D
212A: 01              ?????
212B: 8C 26 28        CMPX #$2628
212E: 04 26           LSR $26
2130: C7              ?????
2131: DE D3           LDU $D3
2133: 14              ?????
2134: E6 96           LDb [A,X]
2136: 16 EE DB        LBRA $1014
2139: 72              ?????
213A: E9 B3           ADCb [,--Y]
213C: 66 17           ROR -$09,X
213E: 76 B1 1F        ROR $B11F
2141: 54              LSRb
2142: C3 B5 F3        ADDd #$B5F3
2145: 8C 5F BE        CMPX #$5FBE
2148: F3 17 43        ADDD $1743
214B: DB B9           ADDb $B9
214D: 55              ?????
214E: CB B9           ADDb #$B9
2150: 5F              CLRb
2151: BE 39 17        LDX $3917
2154: FF 9F 09        STU $9F09
2157: 5E              ?????
2158: 82 00           SBCa #$00
215A: 84 02           ANDa #$02
215C: 03 81           COM $81
215E: 5B              ?????
215F: 52              ?????
2160: 07 54           ASR $54
2162: 0E 52           JMP $52
2164: 0D 22           TST $22
2166: 0A 08           DEC $08
2168: 04 1E           LSR $1E
216A: 5F              CLRb
216B: BE D3 14        LDX $D314
216E: 13              SYNC
216F: B4 C5 98        ANDa $C598
2172: C0 16           SUBb #$16
2174: 82 17           SBCa #$17
2176: 46              RORa
2177: 5E              ?????
2178: 44              LSRa
2179: A0 53           SUBa -$0D,U
217B: 17 B3 E0        LBSR $D55E
217E: 49              ROLa
217F: 1B              ?????
2180: 99 16           ADCa $16
2182: 07 BC           ASR $BC
2184: BF 9A 1C        STX $9A1C
2187: B5 0D 2C        BITa $0D2C
218A: 14              ?????
218B: 0A 0B           DEC $0B
218D: 04 27           LSR $27
218F: C7              ?????
2190: DE C6           LDU $C6
2192: 22 9B           BHI $212F
2194: 15              ?????
2195: 5B              ?????
2196: CA 6B           ORb #$6B
2198: BF 2B 6E        STX $2B6E
219B: 6B              ?????
219C: BF 5F BE        STX $5FBE
219F: 23 15           BLS $21B6
21A1: F3 B9 46        ADDD $B946
21A4: B8 51 5E        EORa $515E
21A7: 96 64           LDa $64
21A9: DB 72           ADDb $72
21AB: 01              ?????
21AC: B3 56 90        SUBD $5690
21AF: C6 9C           LDb #$9C
21B1: D6 9C           LDb $9C
21B3: 56              RORb
21B4: 72              ?????
21B5: 2E 0C           BGT $21C3
21B7: 2A 84           BPL $213D
21B9: 00 A0           NEG $A0
21BB: 03 0D           COM $0D
21BD: 5F              CLRb
21BE: BE 5B B1        LDX $5BB1
21C1: 4B              ?????
21C2: 7B              ?????
21C3: 01              ?????
21C4: 68 0A           LSL +$0A,X
21C6: 58              ASLb
21C7: 2F 62           BLE $222B
21C9: 2E 07           BGT $21D2
21CB: 11 0D           ?????
21CD: 0F 0A           CLR $0A
21CF: 15              ?????
21D0: 04 04           LSR $04
21D2: F4 4F AB        ANDb $4FAB
21D5: A2 17           SBCa -$09,X
21D7: 05              ?????
21D8: 00 1C           NEG $1C
21DA: 1D              SEX
21DB: 23 0F           BLS $21EC
21DD: 02              ?????
21DE: 03 01           COM $01
21E0: 68 44           LSL +$04,U
21E2: 0D 2A           TST $2A
21E4: 88 00           EORa #$00
21E6: 80 02           SUBa #$02
21E8: 04 FB           LSR $FB
21EA: B9 67 C0        ADCa $67C0
21ED: 07 05           ASR $05
21EF: 0D 03           TST $03
21F1: 0A 12           DEC $12
21F3: 8D 03           BSR $21F8
21F5: 18              ?????
21F6: 5F              CLRb
21F7: BE 66 17        LDX $6617
21FA: 8F              ?????
21FB: 49              ROLa
21FC: 4B              ?????
21FD: 5E              ?????
21FE: C8 B5           EORb #$B5
2200: DB 46           ADDb $46
2202: AB 98 5F        ADDa [+$5F,X]
2205: BE 23 15        LDX $2315
2208: F3 B9 81        ADDD $B981
220B: 5B              ?????
220C: 1B              ?????
220D: B5 0D 2A        BITa $0D2A
2210: 00 00           NEG $00
2212: 80 02           SUBa #$02
2214: 04 FB           LSR $FB
2216: B9 67 C0        ADCa $67C0
2219: 07 05           ASR $05
221B: 0D 03           TST $03
221D: 0A 12           DEC $12
221F: 8D 03           BSR $2224
2221: 18              ?????
2222: 5F              CLRb
2223: BE 66 17        LDX $6617
2226: 8F              ?????
2227: 49              ROLa
2228: 4B              ?????
2229: 5E              ?????
222A: C8 B5           EORb #$B5
222C: DB 46           ADDb $46
222E: AB 98 5F        ADDa [+$5F,X]
2231: BE F7 17        LDX $F717
2234: F3 B9 81        ADDD $B981
2237: 5B              ?????
2238: 1B              ?????
2239: B5 12 44        BITa $1244
223C: 8C 05 A4        CMPX #$05A4
223F: 03 14           COM $14
2241: 54              LSRb
2242: 45              ?????
2243: 91 7A           CMPa $7A
2245: B8 16 53        EORa $1653
2248: 15              ?????
2249: 75              ?????
224A: 98 09           EORa $09
224C: BC BE 9F        CMPX $BE9F
224F: D5 15           BITb $15
2251: 9F 15           STX $15
2253: 7F B1 02        CLR $B102
2256: 06 3E           ROR $3E
2258: 6E 14           JMP -$0C,X
225A: 58              ASLb
225B: 91 7A           CMPa $7A
225D: 07 21           ASR $21
225F: 0D 1F           TST $1F
2261: 0A 08           DEC $08
2263: 04 1B           LSR $1B
2265: 5F              CLRb
2266: BE D0 15        LDX $D015
2269: 64 B7           LSR ??
226B: EE 7A           LDU -$06,S
226D: C0 7A           SUBb #$7A
226F: 2F 17           BLE $2288
2271: 0D 47           TST $47
2273: FC ED 10        LDD $ED10
2276: B2 D1 6A        SBCa $D16A
2279: 8F              ?????
227A: 64 03           LSR +$03,X
227C: A1 27           CMPa +$07,Y
227E: A0 22           SUBa +$02,Y
2280: 0E 42           JMP $42
2282: A1 00           CMPa +$00,X
2284: E4 03           ANDb +$03,X
2286: 19              DAA
2287: 5F              CLRb
2288: BE 5B B1        LDX $5BB1
228B: 4B              ?????
228C: 7B              ?????
228D: 4E              ?????
228E: 45              ?????
228F: 31 49           LEAY +$09,U
2291: 55              ?????
2292: 5E              ?????
2293: 44              LSRa
2294: D2 0E           SBCb $0E
2296: 58              ASLb
2297: 4B              ?????
2298: 4A              DECa
2299: AB 98 63        ADDa [+$63,X]
229C: 98 03           EORa $03
229E: B1 2E 07        CMPa $2E07
22A1: 18              ?????
22A2: 0D 16           TST $16
22A4: 0A 08           DEC $08
22A6: 04 12           LSR $12
22A8: 2C 1D           BGE $22C7
22AA: 5F              CLRb
22AB: A0 D3           SUBa [,--U]
22AD: B3 B8 16        SUBD $B816
22B0: 43              COMa
22B1: 16 57 63        LBRA $7A17
22B4: 28 54           BVC $230A
22B6: BD 5F 23        JSR $5F23
22B9: BC 02 08        CMPX $0208
22BC: 54              LSRb
22BD: 8B 9B           ADDa #$9B
22BF: 6C 81           INC ,X++ 
22C1: BA 33 B1        ORa $33B1
22C4: 0F 6B           CLR $6B
22C6: 8E 00 80        LDX #$0080
22C9: 03 34           COM $34
22CB: 5F              CLRb
22CC: BE 5B B1        LDX $5BB1
22CF: 4B              ?????
22D0: 7B              ?????
22D1: 4A              DECa
22D2: 45              ?????
22D3: FF 78 35        STU $7835
22D6: A1 66           CMPa +$06,S
22D8: 17 0F A0        LBSR $327B
22DB: 73 15 C1        COM $15C1
22DE: B1 3F DE        CMPa $3FDE
22E1: DF 16           STU $16
22E3: 1A B1           ORCC #$B1
22E5: F3 5F 03        ADDD $5F03
22E8: A0 4E           SUBa +$0E,U
22EA: 45              ?????
22EB: 01              ?????
22EC: 60 43           NEG +$03,U
22EE: 5E              ?????
22EF: 08 4F           LSL $4F
22F1: 56              RORb
22F2: 5E              ?????
22F3: DB 72           ADDb $72
22F5: 04 9A           LSR $9A
22F7: 53              COMb
22F8: BE 55 A4        LDX $55A4
22FB: 09 B7           ROL $B7
22FD: DB 63           ADDb $63
22FF: 07 24           ASR $24
2301: 0D 22           TST $22
2303: 0A 0B           DEC $0B
2305: 04 1E           LSR $1E
2307: 5F              CLRb
2308: BE 5B B1        LDX $5BB1
230B: EA 48           ORb +$08,U
230D: 94 5F           ANDa $5F
230F: D6 B5           LDb $B5
2311: C4 9C           ANDb #$9C
2313: 46              RORa
2314: 5E              ?????
2315: 07 B2           ASR $B2
2317: 04 58           LSR $58
2319: 81 8D           CMPa #$8D
231B: 11 58           ?????
231D: 8A 96           ORa #$96
231F: 4B              ?????
2320: 7B              ?????
2321: BB 54 C9        ADDa $54C9
2324: D2 02           SBCb $02
2326: 0A 09           DEC $09
2328: BA 5B 98        ORa $5B98
232B: 14              ?????
232C: 6C 4B           INC +$0B,U
232E: 6E DB           JMP [D,U]
2330: 8B 22           ADDa #$22
2332: 58              ASLb
2333: 95 00           BITa $00
2335: 80 03           SUBa #$03
2337: 32 68           LEAS +$08,S
2339: 4D              TSTa
233A: AF A0           STX ,Y+
233C: 51              ?????
233D: 18              ?????
233E: 55              ?????
233F: C2 50           SBCb #$50
2341: BD 0B 5C        JSR $0B5C
2344: 83 48 4E        SUBd #$484E
2347: 48              ASLa
2348: 46              RORa
2349: 49              ROLa
234A: 66 17           ROR -$09,X
234C: D0 47           SUBb $47
234E: F3 5F 56        ADDD $5F56
2351: D1 16           CMPb $16
2353: 71              ?????
2354: DB 72           ADDb $72
2356: 89 4E           ADCa #$4E
2358: 73 9E C3        COM $9EC3
235B: 9E 47           LDX $47
235D: 55              ?????
235E: C6 9A           LDb #$9A
2360: 65              ?????
2361: 62              ?????
2362: 53              COMb
2363: 17 B3 55        LBSR $D6BB
2366: 05              ?????
2367: 67 6F           ASR +$0F,S
2369: 62              ?????
236A: 07 10           ASR $10
236C: 0B              ?????
236D: 0E 0A           JMP $0A
236F: 12              NOP 
2370: 01              ?????
2371: 8E 0C 01        LDX #$0C01
2374: 8E 38 05        LDX #$3805
2377: 0D 03           TST $03
2379: 00 A5           NEG $A5
237B: 90 02           SUBa $02
237D: 0D 89           TST $89
237F: 4E              ?????
2380: 73 9E FB        COM $9EFB
2383: B9 8F 7A        ADCa $8F7A
2386: 03 58           COM $58
2388: 3B              RTI
2389: 8E 52 23        LDX #$5223
238C: 2F 95           BLE $2323
238E: 05              ?????
238F: A0 03           SUBa +$03,X
2391: 20 49           BRA $23DC
2393: 45              ?????
2394: BE 9F 83        LDX $9F83
2397: 61              ?????
2398: 09 79           ROL $79
239A: 15              ?????
239B: 8A 50           ORa #$50
239D: BD 0B 5C        JSR $0B5C
23A0: 83 7A 5F        SUBd #$7A5F
23A3: BE D7 14        LDX $D714
23A6: BF 9A 91        STX $9A91
23A9: AF 96           STX [A,X]
23AB: 64 DB           LSR [D,U]
23AD: 72              ?????
23AE: 01              ?????
23AF: B3 DB 95        SUBD $DB95
23B2: 02              ?????
23B3: 08 3E           LSL $3E
23B5: 6E F0           JMP [,S+]
23B7: 59              ROLb
23B8: C6 15           LDb #$15
23BA: B3 9F 27        SUBD $9F27
23BD: 80 9A           SUBa #$9A
23BF: 9C 00           CMPX $00
23C1: 80 03           SUBa #$03
23C3: 34 AF           PSHS ,PC,Y,DP,B,A,CC
23C5: 6E 73           JMP -$0D,S
23C7: 49              ROLa
23C8: 79 4F AF        ROL $4FAF
23CB: 9B 73           ADDa $73
23CD: 15              ?????
23CE: F5 BD 30        BITb $BD30
23D1: 15              ?????
23D2: AB 6E           ADDa +$0E,S
23D4: 66 CA           ROR ??
23D6: FB 17 53        ADDb $1753
23D9: BE 63 7A        LDX $637A
23DC: B5 6C B8        BITa $6CB8
23DF: 16 57 17        LBRA $7AF9
23E2: 1F B3           TFR DP,U
23E4: CD              ?????
23E5: 9A 66           ORa $66
23E7: 17 8E 48        LBSR $B232
23EA: 5B              ?????
23EB: 17 F0 8B        LBSR $1479
23EE: 13              SYNC
23EF: BF AF 14        STX $AF14
23F2: 04 68           LSR $68
23F4: 5B              ?????
23F5: 5E              ?????
23F6: 3F              SWI1
23F7: A1 07           CMPa +$07,X
23F9: 55              ?????
23FA: 0B              ?????
23FB: 53              COMb
23FC: 0A 11           DEC $11
23FE: 20 04           BRA $2404
2400: 1E 5F           EXG PC,??
2402: BE 73 15        LDX $7315
2405: F5 BD 94        BITb $BD94
2408: 14              ?????
2409: 4E              ?????
240A: 5E              ?????
240B: 5D              TSTb
240C: 9E 16           LDX $16
240E: 60 51           NEG -$0F,U
2410: 18              ?????
2411: 45              ?????
2412: C2 83           SBCb #$83
2414: 48              ASLa
2415: 06 9A           ROR $9A
2417: C2 16           SBCb #$16
2419: 83 61 5F        SUBd #$615F
241C: BE DB 95        LDX $DB95
241F: 36 10           PSHU ,X
2421: 04 0E           LSR $0E
2423: 5F              CLRb
2424: BE 73 15        LDX $7315
2427: F5 BD 94        BITb $BD94
242A: 14              ?????
242B: 45              ?????
242C: 5E              ?????
242D: 85 8D           BITa #$8D
242F: 17 60 17        LBSR $8449
2432: 19              DAA
2433: 04 17           LSR $17
2435: 5F              CLRb
2436: BE 73 15        LDX $7315
2439: F5 BD 94        BITb $BD94
243C: 14              ?????
243D: 56              RORb
243E: 5E              ?????
243F: 2B A0           BMI $23E1
2441: F1 B8 02        CMPb $B802
2444: A1 89 17 DE     CMPa $17DE,X
2448: 14              ?????
2449: 64 7A           LSR -$06,S
244B: 2E 34           BGT $2481
244D: 01              ?????
244E: 89 02           ADCa #$02
2450: 08 79           LSL $79
2452: 4F              CLRa
2453: AF 9B           STX [D,X]
2455: 73 15 F5        COM $15F5
2458: BD 16 59        JSR $1659
245B: 91 00           CMPa $00
245D: A0 02           SUBa +$02,X
245F: 04 F8           LSR $F8
2461: 8B 23           ADDa #$23
2463: 62              ?????
2464: 03 16           COM $16
2466: 44              LSRa
2467: 45              ?????
2468: EF 60           STU +$00,S
246A: AE D0           LDX [,U+]
246C: F3 5F F8        ADDD $5FF8
246F: 8B 23           ADDa #$23
2471: 62              ?????
2472: 4B              ?????
2473: 7B              ?????
2474: 03 A0           COM $A0
2476: 0F A0           CLR $A0
2478: F3 17 17        ADDD $1717
247B: 8D 07           BSR $2484
247D: 36 0D           PSHU ,DP,B,CC
247F: 34 0A           PSHS ,DP,A
2481: 12              NOP 
2482: 04 2F           LSR $2F
2484: 56              RORb
2485: 45              ?????
2486: D2 B0           SBCb $B0
2488: 09 15           ROL $15
248A: A3 A0           SUBD ,Y+
248C: 5F              CLRb
248D: A0 8B           SUBa D,X
248F: 9A B9           ORa $B9
2491: 46              RORa
2492: 5B              ?????
2493: CA C7           ORb #$C7
2495: DE 3B           LDU $3B
2497: F4 3E 6E        ANDb $3E6E
249A: 06 58           ROR $58
249C: 66 C6           ROR A,U
249E: 53              COMb
249F: 15              ?????
24A0: 0D 8D           TST $8D
24A2: 82 17           SBCa #$17
24A4: 54              LSRb
24A5: 5E              ?????
24A6: 3F              SWI1
24A7: A0 90           SUBa [,X+]
24A9: 14              ?????
24AA: 06 58           ROR $58
24AC: 09 B3           ROL $B3
24AE: 8B 9A           ADDa #$9A
24B0: C7              ?????
24B1: DE 2E           LDU $2E
24B3: 81 16           CMPa #$16
24B5: 42              ?????
24B6: 00 05           NEG $05
24B8: A0 03           SUBa +$03,X
24BA: 12              NOP 
24BB: 44              LSRa
24BC: 45              ?????
24BD: EF 60           STU +$00,S
24BF: AE D0           LDX [,U+]
24C1: F3 5F F8        ADDD $5FF8
24C4: 8B 23           ADDa #$23
24C6: 62              ?????
24C7: 4B              ?????
24C8: 7B              ?????
24C9: F4 72 DB        ANDb $72DB
24CC: 63 02           COM +$02,X
24CE: 0A 6C           DEC $6C
24D0: 4D              TSTa
24D1: F7 62 E6        STb $62E6
24D4: 8B 3F           ADDa #$3F
24D6: 16 74 CA        LBRA $99A3
24D9: 07 1D           ASR $1D
24DB: 0D 1B           TST $1B
24DD: 0A 12           DEC $12
24DF: 04 17           LSR $17
24E1: 5F              CLRb
24E2: BE 3F 16        LDX $3F16
24E5: 74 CA D3        LSR $CAD3
24E8: 14              ?????
24E9: 90 96           SUBa $96
24EB: CE 9C 11        LDU #$9C11
24EE: A0 23           SUBa +$03,Y
24F0: 62              ?????
24F1: 5B              ?????
24F2: 4D              TSTa
24F3: 6E A7           JMP ??
24F5: E6 8B           LDb D,X
24F7: 2E 18           BGT $2511
24F9: 80 C5           SUBa #$C5
24FB: 91 00           CMPa $00
24FD: 84 07           ANDa #$07
24FF: 80 98           SUBa #$98
2501: 0D 80           TST $80
2503: 95 0A           BITa $0A
2505: 08 04           LSL $04
2507: 80 90           SUBa #$90
2509: 9E C5           LDX $C5
250B: BE 9F 33        LDX $9F33
250E: 17 1F 54        LBSR $4465
2511: CE B5 1B        LDU #$B51B
2514: 79 56 D1        ROL $56D1
2517: 90 73           SUBa $73
2519: 2F 17           BLE $2532
251B: DA 46           ORb $46
251D: 0A EE           DEC $EE
251F: 2F 62           BLE $2583
2521: D6 E7           LDb $E7
2523: C3 9C 7B        ADDd #$9C7B
2526: 9B 19           ADDa $19
2528: 87              ?????
2529: 50              NEGb
252A: D1 33           CMPb $33
252C: 70 98 8C        NEG $988C
252F: 91 7A           CMPa $7A
2531: E4 14           ANDb -$0C,X
2533: 96 5F           LDa $5F
2535: 2F C6           BLE $24FD
2537: 44              LSRa
2538: F4 59 5E        ANDb $595E
253B: 43              COMa
253C: 49              ROLa
253D: 82 17           SBCa #$17
253F: 29 A1           BVS $24E2
2541: 73 76 EB        COM $76EB
2544: 99 96           ADCa $96
2546: 91 F4           CMPa $F4
2548: BD FA 17        JSR $FA17
254B: 73 49 73        COM $4973
254E: BE E4 14        LDX $E414
2551: 26 60           BNE $25B3
2553: 16 EE 56        LBRA $13AC
2556: 72              ?????
2557: 82 17           SBCa #$17
2559: 1B              ?????
255A: A1 54           CMPa -$0C,U
255C: 72              ?????
255D: 75              ?????
255E: 98 C3           EORa $C3
2560: B5 33 98        BITa $3398
2563: 8F              ?????
2564: 8C 73 7B        CMPX #$737B
2567: 73 BE E9        COM $BEE9
256A: 16 B4 D0        LBRA $DA3D
256D: EE 68           LDU +$08,S
256F: 84 15           ANDa #$15
2571: 26 60           BNE $25D3
2573: 3B              RTI
2574: F4 6E A7        ANDb $6EA7
2577: 16 8A DB        LBRA $B055
257A: 72              ?????
257B: F8 8B 23        EORb $8B23
257E: 62              ?????
257F: 6B              ?????
2580: BF 0B 6C        STX $0B6C
2583: 96 96           LDa $96
2585: FB 75 A3        ADDb $75A3
2588: D0 42           SUBb $42
258A: 8E 04 EE        LDX #$04EE
258D: 52              ?????
258E: 5E              ?????
258F: 72              ?????
2590: B1 2F 49        CMPa $2F49
2593: 16 58 DF        LBRA $7E75
2596: 9C DB           CMPX $DB
2598: F9 03 1F        ADCb $031F
259B: 5F              CLRb
259C: BE 5B B1        LDX $5BB1
259F: 4B              ?????
25A0: 7B              ?????
25A1: 52              ?????
25A2: 45              ?????
25A3: 53              COMb
25A4: 8B 1B           ADDa #$1B
25A6: C4 03           ANDb #$03
25A8: A0 5F           SUBa -$01,U
25AA: BE F3 17        LDX $F317
25AD: F3 8C B9        ADDD $8CB9
25B0: 46              RORa
25B1: 5B              ?????
25B2: CA 5F           ORb #$5F
25B4: BE 3F 16        LDX $3F16
25B7: 74 CA 2E        LSR $CA2E
25BA: 02              ?????
25BB: 04 FB           LSR $FB
25BD: A5 A7           BITa ??
25BF: AD 19           JSR -$07,X
25C1: 6F 92           CLR [,-X]
25C3: 00 A8           NEG $A8
25C5: 03 10           COM $10
25C7: 45              ?????
25C8: 45              ?????
25C9: 8E 48 DB        LDX #$48DB
25CC: 8B 4B           ADDa #$4B
25CE: 7B              ?????
25CF: 83 7A 5F        SUBd #$7A5F
25D2: BE 39 17        LDX $3917
25D5: FF 9F 02        STU $9F02
25D8: 04 10           LSR $10
25DA: 53              COMb
25DB: FF 5A 07        STU $5A07
25DE: 52              ?????
25DF: 0B              ?????
25E0: 50              NEGb
25E1: 0A 14           DEC $14
25E3: 34 0E           PSHS ,DP,B,A
25E5: 32 0D           LEAS +$0D,X
25E7: 2F 09           BLE $25F2
25E9: 14              ?????
25EA: 1E 11           EXG X,X
25EC: 12              NOP 
25ED: 04 28           LSR $28
25EF: 5F              CLRb
25F0: BE D3 14        LDX $D314
25F3: 46              RORa
25F4: 98 4B           EORa $4B
25F6: 5E              ?????
25F7: D0 B5           SUBb $B5
25F9: 6B              ?????
25FA: A1 F4           CMPa [,S]
25FC: 4F              CLRa
25FD: 10 99           ?????
25FF: 33 70           LEAU -$10,S
2601: 55              ?????
2602: 45              ?????
2603: A7 D0           STa [,U+]
2605: 15              ?????
2606: BC B0 53        CMPX $B053
2609: 12              NOP 
260A: BC 37 62        CMPX $3762
260D: 96 5F           LDa $5F
260F: 4B              ?????
2610: 62              ?????
2611: 5F              CLRb
2612: BE 39 17        LDX $3917
2615: FF 9F 88        STU $9F88
2618: 15              ?????
2619: 17 0D 15        LBSR $3331
261C: 04 12           LSR $12
261E: 55              ?????
261F: BD F5 BD        JSR $F5BD
2622: F3 17 1E        ADDD $171E
2625: DA D6           ORb $D6
2627: 15              ?????
2628: D2 B5           SBCb $B5
262A: 55              ?????
262B: 9F 19           STX $19
262D: A0 49           SUBa +$09,U
262F: C6 81           LDb #$81
2631: 19              DAA
2632: 80 C6           SUBa #$C6
2634: 00 00           NEG $00
2636: A8 03           EORa +$03,X
2638: 12              NOP 
2639: 45              ?????
263A: 45              ?????
263B: 8E 48 DB        LDX #$48DB
263E: 8B 4B           ADDa #$4B
2640: 7B              ?????
2641: F4 4F 10        ANDb $4F10
2644: 99 C6           ADCa $C6
2646: 6A 6E           DEC +$0E,S
2648: 7A DB E0        DEC $DBE0
264B: 02              ?????
264C: 0A F4           DEC $F4
264E: 4F              CLRa
264F: 10 99           ?????
2651: C5 6A           BITb #$6A
2653: 8E 48 DB        LDX #$48DB
2656: 8B 07           ADDa #$07
2658: 59              ROLb
2659: 0E 57           JMP $57
265B: 0D 1C           TST $1C
265D: 0E 04           JMP $04
265F: 0A 13           DEC $13
2661: 0A 14           DEC $14
2663: 04 14           LSR $14
2665: 5F              CLRb
2666: BE D3 14        LDX $D314
2669: 46              RORa
266A: 98 4B           EORa $4B
266C: 5E              ?????
266D: C3 B5 EF        ADDd #$B5EF
2670: 8D 13           BSR $2685
2672: 47              ASRa
2673: BF 14 D3        STX $14D3
2676: B2 CF 98        SBCa $CF98
2679: 0D 19           TST $19
267B: 0A 16           DEC $16
267D: 1E 11           EXG X,X
267F: 12              NOP 
2680: 04 12           LSR $12
2682: 5F              CLRb
2683: BE D3 14        LDX $D314
2686: 46              RORa
2687: 98 4B           EORa $4B
2689: 5E              ?????
268A: C7              ?????
268B: B5 43 D9        BITa $43D9
268E: C7              ?????
268F: 98 5A           EORa $5A
2691: 7B              ?????
2692: 17 60 0D        LBSR $86A2
2695: 1C 0A           ANDCC #$0A
2697: 15              ?????
2698: 04 18           LSR $18
269A: C7              ?????
269B: DE 2F           LDU $2F
269D: 17 46 48        LBSR $6CE8
26A0: 55              ?????
26A1: DB 87           ADDb $87
26A3: 74 B3 8B        LSR $B38B
26A6: 76 A7 D6        ROR $A7D6
26A9: 15              ?????
26AA: C7              ?????
26AB: 16 08 BC        LBRA $2F6A
26AE: 3D              MUL
26AF: 7B              ?????
26B0: 9B C1           ADDa $C1
26B2: 08 46           LSL $46
26B4: 0D 44           TST $44
26B6: 1F 24           TFR Y,S
26B8: 5F              CLRb
26B9: BE 43 16        LDX $4316
26BC: 2E 6D           BGT $272B
26BE: 5C              INCb
26BF: 15              ?????
26C0: DB 9F           ADDb $9F
26C2: 5F              CLRb
26C3: BE D3 14        LDX $D314
26C6: 46              RORa
26C7: 98 55           EORa $55
26C9: 5E              ?????
26CA: 2F 60           BLE $272C
26CC: D6 B5           LDb $B5
26CE: C4 9C           ANDb #$9C
26D0: 49              ROLa
26D1: 5E              ?????
26D2: 09 B3           ROL $B3
26D4: 91 7A           CMPa $7A
26D6: 03 15           COM $15
26D8: 67 93           ASR [,--X]
26DA: 1B              ?????
26DB: B5 0B 1C        BITa $0B1C
26DE: 01              ?????
26DF: 1D              SEX
26E0: 07 0D           ASR $0D
26E2: 05              ?????
26E3: 1C 1D           ANDCC #$1D
26E5: 1D              SEX
26E6: 14              ?????
26E7: 0C 1E           INC $1E
26E9: 07 0D           ASR $0D
26EB: 05              ?????
26EC: 1C 1E           ANDCC #$1E
26EE: 1D              SEX
26EF: 32 0C           LEAS +$0C,X
26F1: 15              ?????
26F2: 07 0D           ASR $0D
26F4: 05              ?????
26F5: 1C 15           ANDCC #$15
26F7: 1D              SEX
26F8: 0F 0C           CLR $0C
26FA: 18              ?????
26FB: 80 84           SUBa #$84
26FD: 92 00           SBCa $00
26FF: 84 07           ANDa #$07
2701: 5B              ?????
2702: 0D 59           TST $59
2704: 0A 08           DEC $08
2706: 04 55           LSR $55
2708: 9E 7A           LDX $7A
270A: D6 9C           LDb $9C
270C: DB 72           ADDb $72
270E: 70 C0 6E        NEG $C06E
2711: 98 30           EORa $30
2713: 15              ?????
2714: F4 BD D6        ANDb $BDD6
2717: B5 DB 72        BITa $DB72
271A: A7 B7           STa ??
271C: B4 85 04        ANDa $8504
271F: EE D8 B0        LDU [-$50,U]
2722: 53              COMb
2723: 61              ?????
2724: 90 14           SUBa $14
2726: 19              DAA
2727: 58              ASLb
2728: 57              ASRb
2729: 7B              ?????
272A: FB 8E DB        ADDb $8EDB
272D: 72              ?????
272E: 37 6E           PULU ,A,B,DP,Y,S
2730: 5B              ?????
2731: BB 04 68        ADDa $0468
2734: 9F 15           STX $15
2736: FB 17 F3        ADDb $17F3
2739: 8C 65 B1        CMPX #$65B1
273C: 00 9F           NEG $9F
273E: 6F 7C           CLR -$04,S
2740: 82 17           SBCa #$17
2742: 54              LSRb
2743: 5E              ?????
2744: 92 5F           SBCa $5F
2746: 46              RORa
2747: 62              ?????
2748: 95 14           BITa $14
274A: 82 17           SBCa #$17
274C: 4E              ?????
274D: 5E              ?????
274E: 7A 79 04        DEC $7904
2751: BC 59 60        CMPX $5960
2754: 5B              ?????
2755: B1 8F 73        CMPa $8F73
2758: 7E 15 85        JMP $1585
275B: A1 2E           CMPa +$0E,Y
275D: 03 1C           COM $1C
275F: 5F              CLRb
2760: BE 5B B1        LDX $5BB1
2763: 2F 49           BLE $27AE
2765: E4 14           ANDb -$0C,X
2767: EE DE           LDU ??
2769: CB 78           ADDb #$78
276B: F0 B3 4B        SUBb $B34B
276E: 62              ?????
276F: B9 46 5B        ADCa $465B
2772: CA 5F           ORb #$5F
2774: BE 8F 17        LDX $8F17
2777: CF              ?????
2778: 99 9B           ADCa $9B
277A: 8F              ?????
277B: 02              ?????
277C: 04 F0           LSR $F0
277E: B3 4B 62        SUBD $4B62
2781: 1B              ?????
2782: 80 B5           SUBa #$B5
2784: A0 00           SUBa +$00,X
2786: AC 03           CMPX +$03,X
2788: 14              ?????
2789: 5F              CLRb
278A: BE 5B B1        LDX $5BB1
278D: 4B              ?????
278E: 7B              ?????
278F: 44              LSRa
2790: 45              ?????
2791: 38              ?????
2792: C6 91           LDb #$91
2794: 7A 3B 16        DEC $3B16
2797: D3 93           ADDD $93
2799: F4 72 DB        ANDb $72DB
279C: 63 07           COM +$07,X
279E: 80 8F           SUBa #$8F
27A0: 0E 80           JMP $80
27A2: 8C 0D 1B        CMPX #$0D1B
27A5: 0E 04           JMP $04
27A7: 0A 13           DEC $13
27A9: 0A 14           DEC $14
27AB: 04 13           LSR $13
27AD: 5F              CLRb
27AE: BE 3B 16        LDX $3B16
27B1: D3 93           ADDD $93
27B3: 4B              ?????
27B4: 7B              ?????
27B5: 4C              INCa
27B6: 48              ASLa
27B7: 86 5F           LDa #$5F
27B9: 44              LSRa
27BA: DB 38           ADDb $38
27BC: C6 91           LDb #$91
27BE: 7A 2E 0B        DEC $2E0B
27C1: 6D 0A           TST +$0A,X
27C3: 16 12 0D        LBRA $39D3
27C6: 10 1E           ?????
27C8: 28 14           BVC $27DE
27CA: 04 0B           LSR $0B
27CC: 5F              CLRb
27CD: BE 3B 16        LDX $3B16
27D0: D3 93           ADDD $93
27D2: 4B              ?????
27D3: 7B              ?????
27D4: 36 A1           PSHU ,PC,Y,CC
27D6: 2E 18           BGT $27F0
27D8: 2D 0D           BLT $27E7
27DA: 2B 04           BMI $27E0
27DC: 26 5F           BNE $283D
27DE: BE 3B 16        LDX $3B16
27E1: D3 93           ADDD $93
27E3: 37 6E           PULU ,A,B,DP,Y,S
27E5: D1 B5           CMPb $B5
27E7: 97 C6           STa $C6
27E9: 51              ?????
27EA: 18              ?????
27EB: 4F              CLRa
27EC: C2 66           SBCb #$66
27EE: C6 9B           LDb #$9B
27F0: 15              ?????
27F1: 5B              ?????
27F2: CA E4           ORb #$E4
27F4: B3 66 4D        SUBD $664D
27F7: D6 15           LDb $15
27F9: 82 17           SBCa #$17
27FB: 59              ROLb
27FC: 5E              ?????
27FD: 00 B3           NEG $B3
27FF: D9 6A           ADCb $6A
2801: 39              RTS
2802: 4A              DECa
2803: 1E 28           EXG Y,A
2805: 14              ?????
2806: 08 27           LSL $27
2808: 04 25           LSR $25
280A: 5F              CLRb
280B: BE 3B 16        LDX $3B16
280E: D3 93           ADDD $93
2810: 4B              ?????
2811: 7B              ?????
2812: 48              ASLa
2813: 55              ?????
2814: 2F 62           BLE $2878
2816: 19              DAA
2817: 58              ASLb
2818: 82 7B           SBCa #$7B
281A: 7B              ?????
281B: 17 D3 B2        LBSR $FBD0
281E: 13              SYNC
281F: B8 8E 48        EORa $8E48
2822: 51              ?????
2823: 18              ?????
2824: 45              ?????
2825: C2 85           SBCb #$85
2827: 48              ASLa
2828: 14              ?????
2829: BC 86 5F        CMPX $865F
282C: D6 15           LDb $15
282E: 2E 02           BGT $2832
2830: 08 F4           LSL $F4
2832: 4F              CLRa
2833: 10 99           ?????
2835: CE 6A 72        LDU #$6A72
2838: 48              ASLa
2839: 24 81           BCC $27BC
283B: C0 00           SUBb #$00
283D: 00 90           NEG $90
283F: 03 1C           COM $1C
2841: 4E              ?????
2842: 45              ?????
2843: 31 49           LEAY +$09,U
2845: 55              ?????
2846: 5E              ?????
2847: 3A              ABX
2848: 62              ?????
2849: 9E 61           LDX $61
284B: 43              COMa
284C: 16 4B 62        LBRA $73B1
284F: 3B              RTI
2850: 55              ?????
2851: E6 8B           LDb D,X
2853: C0 16           SUBb #$16
2855: 82 17           SBCa #$17
2857: 48              ASLa
2858: 5E              ?????
2859: 81 8D           CMPa #$8D
285B: 1B              ?????
285C: B5 09 02        BITa $0902
285F: 3C 3C           CWAI #3C
2861: 07 80           ASR $80
2863: B3 0B 80        SUBD $0B80
2866: B0 0A 09        SUBa $0A09
2869: 80 9A           SUBa #$9A
286B: 0D 80           TST $80
286D: 97 1A           STa $1A
286F: 09 09           ROL $09
2871: 0B              ?????
2872: 80 91           SUBa #$91
2874: 05              ?????
2875: 99 2B           ADCa $2B
2877: 0D 29           TST $29
2879: 04 03           LSR $03
287B: C7              ?????
287C: DE 52           LDU $52
287E: 12              NOP 
287F: 04 1F           LSR $1F
2881: 50              NEGb
2882: B8 CB 87        EORa $CB87
2885: 6B              ?????
2886: BF 5F BE        STX $5FBE
2889: A3 15           SUBD -$0B,X
288B: 33 8E           LEAU ??
288D: 83 7A 5F        SUBd #$7A5F
2890: BE 57 17        LDX $5717
2893: 1F B3           TFR DP,U
2895: B5 9A D5        BITa $9AD5
2898: B5 0E 53        BITa $0E53
289B: 44              LSRa
289C: DB 93           ADDb $93
289E: 9E 21           LDX $21
28A0: 1D              SEX
28A1: 11 CC           ?????
28A3: 2E 0D           BGT $28B2
28A5: 2C 04           BGE $28AB
28A7: 03 C7           COM $C7
28A9: DE 52           LDU $52
28AB: 12              NOP 
28AC: 04 24           LSR $24
28AE: 6C BE           INC ??
28B0: 85 A1           BITa #$A1
28B2: 7B              ?????
28B3: 14              ?????
28B4: 29 B8           BVS $286E
28B6: B4 D0 B8        ANDa $D0B8
28B9: 16 62 17        LBRA $8AD3
28BC: 35 49           PULS ,CC,DP,U
28BE: C3 B5 CB        ADDd #$B5CB
28C1: B5 09 BC        BITa $09BC
28C4: 50              NEGb
28C5: 8B B5           ADDa #$B5
28C7: 53              COMb
28C8: B8 16 96        EORa $1696
28CB: 64 DB           LSR [D,U]
28CD: 72              ?????
28CE: 0E D0           JMP $D0
28D0: AB 89 FF 31     ADDa $FF31,X
28D4: 0D 2F           TST $2F
28D6: 04 2B           LSR $2B
28D8: 5F              CLRb
28D9: BE 57 17        LDX $5717
28DC: 1F B3           TFR DP,U
28DE: B5 9A CA        BITa $9ACA
28E1: B5 86 5F        BITa $865F
28E4: D5 15           BITb $15
28E6: 57              ASRb
28E7: 17 74 CA        LBSR $9DB4
28EA: F3 5F 79        ADDD $5F79
28ED: 68 4A           LSL +$0A,U
28EF: 90 4B           SUBa $4B
28F1: 7B              ?????
28F2: F6 4E EB        LDb $4EEB
28F5: DA 4F           ORb $4F
28F7: 45              ?????
28F8: 80 47           SUBa #$47
28FA: 53              COMb
28FB: 79 B0 53        ROL $B053
28FE: 04 BC           LSR $BC
2900: 89 8D           ADCa #$8D
2902: 21 1D           BRN $2921
2904: FF 15 10        STU $1510
2907: 04 0E           LSR $0E
2909: 76 4D F4        ROR $4DF4
290C: BD 1B 16        JSR $1B16
290F: F3 8C 73        ADDD $8C73
2912: 7B              ?????
2913: 14              ?????
2914: 67 F1           ASR [,S++]
2916: B9 08 80        ADCa $0880
2919: C4 0D           ANDb #$0D
291B: 80 C1           SUBa #$C1
291D: 0E 3E           JMP $3E
291F: 0D 32           TST $32
2921: 14              ?????
2922: 01              ?????
2923: 1D              SEX
2924: 0B              ?????
2925: 19              DAA
2926: 0A 04           DEC $04
2928: 04 21           LSR $21
292A: 04 00           LSR $00
292C: 00 03           NEG $03
292E: 04 21           LSR $21
2930: 03 00           COM $00
2932: 00 01           NEG $01
2934: 04 21           LSR $21
2936: 01              ?????
2937: 00 00           NEG $00
2939: 02              ?????
293A: 04 21           LSR $21
293C: 02              ?????
293D: 00 00           NEG $00
293F: 1F 12           TFR X,Y
2941: 5F              CLRb
2942: BE 57 17        LDX $5717
2945: 1F B3           TFR DP,U
2947: B3 9A 74        SUBD $9A74
294A: A7 27           STa +$07,Y
294C: BA DB B5        ORa $DBB5
294F: 1B              ?????
2950: A1 8E           CMPa ??
2952: 48              ASLa
2953: 1F 08           TFR D,A
2955: 5F              CLRb
2956: BE 57 17        LDX $5717
2959: 1F B3           TFR DP,U
295B: B3 9A 0D        SUBD $9A0D
295E: 7F 01 1D        CLR $011D
2961: 1C 1D           ANDCC #$1D
2963: 0B              ?????
2964: 79 05 33        ROL $0533
2967: 23 0D           BLS $2976
2969: 21 1F           BRN $298A
296B: 1D              SEX
296C: 0C BA           INC $BA
296E: 17 7A 33        LBSR $A3A4
2971: BB 7B A6        ADDa $7BA6
2974: 40              NEGa
2975: B9 E1 14        ADCa $E114
2978: 3D              MUL
2979: C6 4B           LDb #$4B
297B: 62              ?????
297C: 6C BE           INC ??
297E: 29 A1           BVS $2921
2980: 1B              ?????
2981: 71              ?????
2982: 34 A1           PSHS ,PC,Y,CC
2984: CF              ?????
2985: 17 9D 7A        LBSR $C702
2988: 21 1D           BRN $29A7
298A: 14              ?????
298B: 99 16           ADCa $16
298D: 1F 14           TFR X,S
298F: 0C BA           INC $BA
2991: 17 7A 33        LBSR $A3C7
2994: BB C7 DE        ADDa $C7DE
2997: 09 15           ROL $15
2999: 37 5A           PULU ,A,DP,X,S
299B: A3 15           SUBD -$0B,X
299D: CE B5 91        LDU #$B591
29A0: C5 EB           BITb #$EB
29A2: 5D              TSTb
29A3: CC 21 0D        LDD #$210D
29A6: 1F 1F           TFR X,??
29A8: 1B              ?????
29A9: 3B              RTI
29AA: 55              ?????
29AB: 0B              ?????
29AC: 8E D2 B0        LDX #$D2B0
29AF: 06 79           ROR $79
29B1: 43              COMa
29B2: DB 07           ADDb $07
29B4: B3 33 98        SUBD $3398
29B7: C7              ?????
29B8: DE 90           LDU $90
29BA: 14              ?????
29BB: 05              ?????
29BC: 58              ASLb
29BD: 1D              SEX
29BE: A0 F3           SUBa [,--S]
29C0: BF 0D 56        STX $0D56
29C3: 21 1D           BRN $29E2
29C5: 14              ?????
29C6: FF 16 1F        STU $161F
29C9: 14              ?????
29CA: 16 6C F4        LBRA $96C1
29CD: 72              ?????
29CE: CB B5           ADDb #$B5
29D0: 17 C0 03        LBSR $E9D6
29D3: 8C 04 68        CMPX #$0468
29D6: 90 14           SUBa $14
29D8: 96 14           LDa $14
29DA: 45              ?????
29DB: BD 5B 89        JSR $5B89
29DE: 0A 15           DEC $15
29E0: 0D 13           TST $13
29E2: 1F 0E           TFR D,??
29E4: 5F              CLRb
29E5: BE 57 17        LDX $5717
29E8: 1F B3           TFR DP,U
29EA: B3 9A 4B        SUBD $9A4B
29ED: 7B              ?????
29EE: E3 59           ADDD -$07,U
29F0: 9B 5D           ADDa $5D
29F2: 1E 15           EXG X,PC
29F4: 16 02 05        LBRA $2BFC
29F7: B4 B7 F0        ANDa $B7F0
29FA: A4 54           ANDa -$0C,U
29FC: 24 40           BCC $2A3E
29FE: 00 00           NEG $00
2A00: 80 03           SUBa #$03
2A02: 1A 4E           ORCC #$4E
2A04: 45              ?????
2A05: 31 49           LEAY +$09,U
2A07: 46              RORa
2A08: 5E              ?????
2A09: 86 5F           LDa #$5F
2A0B: 57              ASRb
2A0C: 17 1F B3        LBSR $49C2
2A0F: B3 9A 87        SUBD $9A87
2A12: 8C D1 B5        CMPX #$D1B5
2A15: 96 96           LDa $96
2A17: DB 72           ADDb $72
2A19: 89 67           ADCa #$67
2A1B: C7              ?????
2A1C: A0 07           SUBa +$07,X
2A1E: 15              ?????
2A1F: 0D 13           TST $13
2A21: 0A 15           DEC $15
2A23: 04 0F           LSR $0F
2A25: A8 77           EORa -$09,S
2A27: 4E              ?????
2A28: 5E              ?????
2A29: E6 A0           LDb ,Y+
2A2B: 7B              ?????
2A2C: 16 92 14        LBRA $BC43
2A2F: F6 A4 7F        LDb $A47F
2A32: 7B              ?????
2A33: 21 02           BRN $2A37
2A35: 08 E3           LSL $E3
2A37: 59              ROLb
2A38: 15              ?????
2A39: 58              ASLb
2A3A: 3A              ABX
2A3B: 62              ?????
2A3C: 9E 61           LDX $61
2A3E: 1F 09           TFR D,B
2A40: FF 00 80        STU $0080
2A43: 02              ?????
2A44: 04 50           LSR $50
2A46: 72              ?????
2A47: 0B              ?????
2A48: 5C              INCb
2A49: 20 34           BRA $2A7F
2A4B: 9C 05           CMPX $05
2A4D: A4 03           ANDa +$03,X
2A4F: 14              ?????
2A50: 5F              CLRb
2A51: BE 5B B1        LDX $5BB1
2A54: 4B              ?????
2A55: 7B              ?????
2A56: 45              ?????
2A57: 45              ?????
2A58: 50              NEGb
2A59: 9F C0           STX $C0
2A5B: 16 82 17        LBRA $AC75
2A5E: 49              ROLa
2A5F: 5E              ?????
2A60: 07 B3           ASR $B3
2A62: 57              ASRb
2A63: 98 07           EORa $07
2A65: 14              ?????
2A66: 0D 12           TST $12
2A68: 0A 08           DEC $08
2A6A: 04 0E           LSR $0E
2A6C: 2C 1D           BGE $2A8B
2A6E: D5 47           BITb $47
2A70: F3 5F 5B        ADDD $5F5B
2A73: 4D              TSTa
2A74: C3 B0 1D        ADDd #$B01D
2A77: 85 5C           BITa #$5C
2A79: C0 02           SUBb #$02
2A7B: 03 3B           COM $3B
2A7D: 55              ?????
2A7E: 4E              ?????
2A7F: 21 7F           BRN $2A00
2A81: 88 00           EORa #$00
2A83: 80 03           SUBa #$03
2A85: 1D              SEX
2A86: 5F              CLRb
2A87: BE 5B B1        LDX $5BB1
2A8A: 4B              ?????
2A8B: 7B              ?????
2A8C: 56              RORb
2A8D: 45              ?????
2A8E: A3 7A           SUBD -$06,S
2A90: 5E              ?????
2A91: 17 F3 A0        LBSR $1E34
2A94: 36 56           PSHU ,S,X,B,A
2A96: D0 15           SUBb $15
2A98: 82 17           SBCa #$17
2A9A: 50              NEGb
2A9B: 5E              ?????
2A9C: BE A0 19        LDX $A019
2A9F: 71              ?????
2AA0: 46              RORa
2AA1: 48              ASLa
2AA2: 2E 02           BGT $2AA6
2AA4: 06 90           ROR $90
2AA6: BE 55 DB        LDX $55DB
2AA9: 86 8D           LDa #$8D
2AAB: 06 53           ROR $53
2AAD: 0D 51           TST $51
2AAF: 0A 0F           DEC $0F
2AB1: 0E 4D           JMP $4D
2AB3: 0D 24           TST $24
2AB5: 14              ?????
2AB6: 08 18           LSL $18
2AB8: 04 02           LSR $02
2ABA: 5F              CLRb
2ABB: BE 11 04        LDX $1104
2ABE: 1A 4B           ORCC #$4B
2AC0: 7B              ?????
2AC1: 81 BF           CMPa #$BF
2AC3: B3 14 D6        SUBD $14D6
2AC6: 6A C8 9C        DEC -$64,U
2AC9: 73 7B 83        COM $7B83
2ACC: 7A 25 BA        DEC $25BA
2ACF: 03 71           COM $71
2AD1: 83 17 7B        SUBd #$177B
2AD4: 9B C9           ADDa $C9
2AD6: B8 9B C1        EORa $9BC1
2AD9: 0D 25           TST $25
2ADB: 17 06 00        LBSR $30DE
2ADE: 17 07 88        LBSR $3269
2AE1: 17 18 00        LBSR $42E4
2AE4: 04 1A           LSR $1A
2AE6: 5F              CLRb
2AE7: BE 66 17        LDX $6617
2AEA: 8F              ?????
2AEB: 49              ROLa
2AEC: 56              RORb
2AED: 5E              ?????
2AEE: 38              ?????
2AEF: C6 D6           LDb #$D6
2AF1: B5 C8 9C        BITa $C89C
2AF4: D7 46           STb $46
2AF6: 82 17           SBCa #$17
2AF8: 59              ROLb
2AF9: 5E              ?????
2AFA: 66 62           ROR +$02,S
2AFC: 09 15           ROL $15
2AFE: C7              ?????
2AFF: A0 18           SUBa -$08,X
2B01: 53              COMb
2B02: 88 00           EORa #$00
2B04: 84 03           ANDa #$03
2B06: 1C 5F           ANDCC #$5F
2B08: BE 5B B1        LDX $5BB1
2B0B: 4B              ?????
2B0C: 7B              ?????
2B0D: 4F              CLRa
2B0E: 45              ?????
2B0F: 65              ?????
2B10: 62              ?????
2B11: 77 47 D3        ASR $47D3
2B14: 14              ?????
2B15: 0F B4           CLR $B4
2B17: 17 58 3F        LBSR $8359
2B1A: 98 96           EORa $96
2B1C: AF DB           STX [D,U]
2B1E: 72              ?????
2B1F: C9 B8           ADCb #$B8
2B21: 9B C1           ADDa $C1
2B23: 02              ?????
2B24: 0A 14           DEC $14
2B26: 53              COMb
2B27: 66 CA           ROR ??
2B29: 67 16           ASR -$0A,X
2B2B: D3 B9           ADDD $B9
2B2D: 9B 6C           ADDa $6C
2B2F: 07 24           ASR $24
2B31: 0D 22           TST $22
2B33: 0A 08           DEC $08
2B35: 04 1E           LSR $1E
2B37: 5F              CLRb
2B38: BE 67 16        LDX $6716
2B3B: D3 B9           ADDD $B9
2B3D: 9B 6C           ADDa $6C
2B3F: 1B              ?????
2B40: B7 33 BB        STa $33BB
2B43: 93 1D           SUBd $1D
2B45: 5B              ?????
2B46: 66 55           ROR -$0B,U
2B48: A4 09           ANDa +$09,X
2B4A: B7 48 5E        STa $485E
2B4D: A3 A0           SUBD ,Y+
2B4F: 52              ?????
2B50: 45              ?????
2B51: 05              ?????
2B52: B2 DC 63        SBCa $DC63
2B55: 09 3B           ROL $3B
2B57: 90 00           SUBa $00
2B59: 80 03           SUBa #$03
2B5B: 0D 5F           TST $5F
2B5D: BE 09 15        LDX $0915
2B60: A3 A0           SUBD ,Y+
2B62: 4B              ?????
2B63: 7B              ?????
2B64: C9 54           ADCb #$54
2B66: A6 B7           LDa ??
2B68: 2E 02           BGT $2B6C
2B6A: 03 81           COM $81
2B6C: 5B              ?????
2B6D: 52              ?????
2B6E: 07 22           ASR $22
2B70: 0D 20           TST $20
2B72: 0A 11           DEC $11
2B74: 17 1B 00        LBSR $4677
2B77: 17 1C 90        LBSR $480A
2B7A: 04 16           LSR $16
2B7C: 7C B3 6F        INC $B36F
2B7F: B3 27 60        SUBD $2760
2B82: 2D 60           BLT $2BE4
2B84: 8B 18           ADDa #$18
2B86: 5F              CLRb
2B87: BE 09 15        LDX $0915
2B8A: A3 A0           SUBD ,Y+
2B8C: 4B              ?????
2B8D: 7B              ?????
2B8E: 5F              CLRb
2B8F: A0 1B           SUBa -$05,X
2B91: 9C 09           CMPX $09
2B93: 30 00           LEAX +$00,X
2B95: 00 80           NEG $80
2B97: 03 12           COM $12
2B99: 5F              CLRb
2B9A: BE 09 15        LDX $0915
2B9D: A3 A0           SUBD ,Y+
2B9F: 4B              ?????
2BA0: 7B              ?????
2BA1: FB B9 43        ADDb $B943
2BA4: 98 AB           EORa $AB
2BA6: 98 5F           EORa $5F
2BA8: A0 1B           SUBa -$05,X
2BAA: 9C 02           CMPX $02
2BAC: 03 81           COM $81
2BAE: 5B              ?????
2BAF: 52              ?????
2BB0: 07 12           ASR $12
2BB2: 0D 10           TST $10
2BB4: 0A 11           DEC $11
2BB6: 04 0C           LSR $0C
2BB8: 8D 7B           BSR $2C35
2BBA: 8E 14 63        LDX #$1463
2BBD: B1 FB 5C        CMPa $FB5C
2BC0: 5F              CLRb
2BC1: A0 1B           SUBa -$05,X
2BC3: 9C FF           CMPX $FF
2BC5: 80 87           SUBa #$87
2BC7: 96 00           LDa $00
2BC9: 80 0A           SUBa #$0A
2BCB: 76 0E 74        ROR $0E74
2BCE: 0B              ?????
2BCF: 07 20           ASR $20
2BD1: 1D              SEX
2BD2: 01              ?????
2BD3: 81 23           CMPa #$23
2BD5: 01              ?????
2BD6: 81 0D           CMPa #$0D
2BD8: 69 1F           ROL -$01,X
2BDA: 66 C7           ROR ??
2BDC: DE DB           LDU $DB
2BDE: 16 CB B9        LBRA $F79A
2BE1: 36 A1           PSHU ,PC,Y,CC
2BE3: 59              ROLb
2BE4: F4 F0 72        ANDb $F072
2BE7: 51              ?????
2BE8: 18              ?????
2BE9: 43              COMa
2BEA: C2 0D           SBCb #$0D
2BEC: D0 A6           SUBb $A6
2BEE: 61              ?????
2BEF: 51              ?????
2BF0: 18              ?????
2BF1: 48              ASLa
2BF2: C2 8E           SBCb #$8E
2BF4: 7A 51 18        DEC $5118
2BF7: 3D              MUL
2BF8: C6 40           LDb #$40
2BFA: 61              ?????
2BFB: DA 14           ORb $14
2BFD: D0 47           SUBb $47
2BFF: F3 5F 6B        ADDD $5F6B
2C02: BF 44 45        STX $4445
2C05: 81 8D           CMPa #$8D
2C07: 15              ?????
2C08: 58              ASLb
2C09: 4B              ?????
2C0A: BD 66 98        JSR $6698
2C0D: 8E 14 54        LDX #$1454
2C10: BD 43 F4        JSR $43F4
2C13: EC 16           LDD -$0A,X
2C15: 35 79           PULS ,CC,DP,X,Y,U
2C17: 0B              ?????
2C18: BC CD B5        CMPX $CDB5
2C1B: 67 98 90        ASR [-$70,X]
2C1E: 8C D1 6A        CMPX #$D16A
2C21: 74 CA 51        LSR $CA51
2C24: 18              ?????
2C25: 59              ROLb
2C26: C2 82           SBCb #$82
2C28: 7B              ?????
2C29: 7B              ?????
2C2A: 14              ?????
2C2B: 13              SYNC
2C2C: 87              ?????
2C2D: 7F 66 D6        CLR $66D6
2C30: 15              ?????
2C31: 49              ROLa
2C32: 16 A5 9F        LBRA $D1D4
2C35: 43              COMa
2C36: 16 9B 85        LBRA $C7BE
2C39: 63 BE           COM ??
2C3B: CB B5           ADDb #$B5
2C3D: CB B5           ADDb #$B5
2C3F: 9B C1           ADDa $C1
2C41: 81 08           CMPa #$08
2C43: 06 0D           ROR $0D
2C45: 04 1C           LSR $1C
2C47: 1D              SEX
2C48: 23 05           BLS $2C4F
2C4A: 09 02           ROL $02
2C4C: 46              RORa
2C4D: 46              RORa
2C4E: 0F 81           CLR $81
2C50: B4 00 00        ANDa $0000
2C53: 90 03           SUBa $03
2C55: 25 5F           BCS $2CB6
2C57: BE 5B B1        LDX $5BB1
2C5A: 4B              ?????
2C5B: 7B              ?????
2C5C: 4A              DECa
2C5D: 45              ?????
2C5E: FF 78 35        STU $7835
2C61: A1 73           CMPa -$0D,S
2C63: 15              ?????
2C64: C1 B1           CMPb #$B1
2C66: 3F              SWI1
2C67: DE B6           LDU $B6
2C69: 14              ?????
2C6A: 5D              TSTb
2C6B: 9E 91           LDX $91
2C6D: 7A 82 17        DEC $8217
2C70: 50              NEGb
2C71: 5E              ?????
2C72: BE A0 12        LDX $A012
2C75: 71              ?????
2C76: 65              ?????
2C77: 49              ROLa
2C78: 77 47 2E        ASR $472E
2C7B: 02              ?????
2C7C: 06 14           ROR $14
2C7E: 6C 4B           INC +$0B,U
2C80: 6E DB           JMP [D,U]
2C82: 8B 09           ADDa #$09
2C84: 02              ?????
2C85: FF FF 07        STU $FF07
2C88: 22 0D           BHI $2C97
2C8A: 20 0A           BRA $2C96
2C8C: 15              ?????
2C8D: 04 1C           LSR $1C
2C8F: DD 72           STD $72
2C91: F3 8C 96        ADDD $8C96
2C94: 5F              CLRb
2C95: 51              ?????
2C96: 18              ?????
2C97: 4E              ?????
2C98: C2 11           SBCb #$11
2C9A: A0 AF 14 04     SUBa $1404,Y
2C9E: 68 5B           LSL -$05,U
2CA0: 5E              ?????
2CA1: 1D              SEX
2CA2: A1 F3           CMPa [,--S]
2CA4: 8C 96 5F        CMPX #$965F
2CA7: A3 15           SUBD -$0B,X
2CA9: EB 8F 08 81     ADDb $0881,X
2CAD: 29 0D           BVS $2CBC
2CAF: 81 26           CMPa #$26
2CB1: 01              ?????
2CB2: 1D              SEX
2CB3: 1C 1D           ANDCC #$1D
2CB5: 14              ?????
2CB6: 01              ?????
2CB7: 12              NOP 
2CB8: 0B              ?????
2CB9: 81 1C           CMPa #$1C
2CBB: 05              ?????
2CBC: 19              DAA
2CBD: 2E 0D           BGT $2CCC
2CBF: 2C 1F           BGE $2CE0
2CC1: 28 5F           BVC $2D22
2CC3: BE 73 15        LDX $7315
2CC6: C1 B1           CMPb #$B1
2CC8: 3F              SWI1
2CC9: DE 81           LDU $81
2CCB: 15              ?????
2CCC: 75              ?????
2CCD: B1 51 18        CMPa $5118
2CD0: 59              ROLb
2CD1: C2 82           SBCb #$82
2CD3: 7B              ?????
2CD4: A3 15           SUBD -$0B,X
2CD6: CA B5           ORb #$B5
2CD8: B8 A0 90        EORa $A090
2CDB: 14              ?????
2CDC: 14              ?????
2CDD: 58              ASLb
2CDE: ED 7A           STD -$06,S
2CE0: 51              ?????
2CE1: 18              ?????
2CE2: 23 C6           BLS $2CAA
2CE4: 36 6F           PSHU ,S,Y,DP,B,A,CC
2CE6: D1 B5           CMPb $B5
2CE8: 71              ?????
2CE9: C6 1D           LDb #$1D
2CEB: FF 3F 21        STU $3F21
2CEE: 0D 1F           TST $1F
2CF0: 1F 1B           TFR X,DP
2CF2: 5F              CLRb
2CF3: BE 73 15        LDX $7315
2CF6: C1 B1           CMPb #$B1
2CF8: 3F              SWI1
2CF9: DE DE           LDU $DE
2CFB: 14              ?????
2CFC: 05              ?????
2CFD: 4A              DECa
2CFE: 51              ?????
2CFF: 18              ?????
2D00: 43              COMa
2D01: C2 B9           SBCb #$B9
2D03: 55              ?????
2D04: CB B9           ADDb #$B9
2D06: 5F              CLRb
2D07: BE DA 14        LDX $DA14
2D0A: 66 62           ROR +$02,S
2D0C: 21 1D           BRN $2D2B
2D0E: 32 64           LEAS +$04,S
2D10: 2E 0D           BGT $2D1F
2D12: 2C 1F           BGE $2D33
2D14: 28 C7           BVC $2CDD
2D16: DE 4F           LDU $4F
2D18: 15              ?????
2D19: 33 61           LEAU +$01,S
2D1B: 5F              CLRb
2D1C: BE 80 15        LDX $8015
2D1F: 5A              DECb
2D20: 49              ROLa
2D21: 91 7A           CMPa $7A
2D23: B8 16 82        EORa $1682
2D26: 17 49 5E        LBSR $7687
2D29: 31 49           LEAY +$09,U
2D2B: CE A1 A5        LDU #$A1A5
2D2E: 5E              ?????
2D2F: 7F 17 82        CLR $1782
2D32: 62              ?????
2D33: D0 15           SUBb $15
2D35: 51              ?????
2D36: 18              ?????
2D37: 23 C6           BLS $2CFF
2D39: 46              RORa
2D3A: B8 EB 5D        EORa $EB5D
2D3D: 1D              SEX
2D3E: 32 A3           LEAS ,--Y
2D40: 3C 0D           CWAI #0D
2D42: 3A              ABX
2D43: 1F 36           TFR U,??
2D45: 5F              CLRb
2D46: BE DE 14        LDX $DE14
2D49: 05              ?????
2D4A: 4A              DECa
2D4B: B8 16 82        EORa $1682
2D4E: 17 49 5E        LBSR $76AF
2D51: 31 49           LEAY +$09,U
2D53: CE A1 54        LDU #$A154
2D56: 5E              ?????
2D57: D3 7A           ADDD $7A
2D59: 6C BE           INC ??
2D5B: 29 A1           BVS $2CFE
2D5D: 1B              ?????
2D5E: 71              ?????
2D5F: 34 A1           PSHS ,PC,Y,CC
2D61: 94 14           ANDa $14
2D63: 4B              ?????
2D64: 90 83           SUBa $83
2D66: 96 83           LDa $83
2D68: 96 3F           LDa $3F
2D6A: C0 EE           SUBb #$EE
2D6C: 93 89           SUBd $89
2D6E: 17 2F 17        LBSR $5C88
2D71: DA 46           ORb $46
2D73: 51              ?????
2D74: 18              ?????
2D75: 23 C6           BLS $2D3D
2D77: F6 4E EB        LDb $4EEB
2D7A: DA 1D           ORb $1D
2D7C: 19              DAA
2D7D: E1 3E           CMPb -$02,Y
2D7F: 0D 3C           TST $3C
2D81: 1F 38           TFR U,A
2D83: 5F              CLRb
2D84: BE 73 15        LDX $7315
2D87: C1 B1           CMPb #$B1
2D89: 3F              SWI1
2D8A: DE 4F           LDU $4F
2D8C: 16 B7 98        LBRA $E527
2D8F: C3 B5 1B        ADDd #$B51B
2D92: BC 34 A1        CMPX $34A1
2D95: 4B              ?????
2D96: 15              ?????
2D97: 9B 53           ADDa $53
2D99: F6 4F 51        LDb $4F51
2D9C: 18              ?????
2D9D: 52              ?????
2D9E: C2 46           SBCb #$46
2DA0: C5 AB           BITb #$AB
2DA2: 14              ?????
2DA3: AF 54           STX -$0C,U
2DA5: 4A              DECa
2DA6: 13              SYNC
2DA7: 44              LSRa
2DA8: 5E              ?????
2DA9: 7F 7B DB        CLR $7BDB
2DAC: B5 34 A1        BITa $34A1
2DAF: 5A              DECb
2DB0: 17 2E A1        LBSR $5C54
2DB3: F4 59 D0        ANDb $59D0
2DB6: 15              ?????
2DB7: FF B9 F1        STU $B9F1
2DBA: 46              RORa
2DBB: 1D              SEX
2DBC: 19              DAA
2DBD: FF 18 0D        STU $180D
2DC0: 16 1F 14        LBRA $4CD7
2DC3: C7              ?????
2DC4: DE 09           LDU $09
2DC6: 15              ?????
2DC7: 37 5A           PULU ,A,DP,X,S
2DC9: 82 17           SBCa #$17
2DCB: 49              ROLa
2DCC: 5E              ?????
2DCD: 31 49           LEAY +$09,U
2DCF: CE A1 A5        LDU #$A1A5
2DD2: 5E              ?????
2DD3: A9 15           ADCa -$0B,X
2DD5: E7 B2           STb [,-Y]
2DD7: 0A 2C           DEC $2C
2DD9: 0D 2A           TST $2A
2DDB: 1F 22           TFR Y,Y
2DDD: 5F              CLRb
2DDE: BE 73 15        LDX $7315
2DE1: C1 B1           CMPb #$B1
2DE3: 3F              SWI1
2DE4: DE 7B           LDU $7B
2DE6: 17 B5 85        LBSR $E36E
2DE9: 7B              ?????
2DEA: 14              ?????
2DEB: 10 67           ?????
2DED: 33 48           LEAU +$08,U
2DEF: 6F 4F           CLR +$0F,U
2DF1: 82 49           SBCa #$49
2DF3: 90 14           SUBa $14
2DF5: 16 58 F0        LBRA $86E8
2DF8: 72              ?????
2DF9: 3A              ABX
2DFA: 15              ?????
2DFB: 94 A5           ANDa $A5
2DFD: 6F 62           CLR +$02,S
2DFF: 17 1E 00        LBSR $4C02
2E02: 17 1F 8E        LBSR $4D93
2E05: 0F 53           CLR $53
2E07: 00 00           NEG $00
2E09: 80 03           SUBa #$03
2E0B: 24 5F           BCC $2E6C
2E0D: BE 5B B1        LDX $5BB1
2E10: 4B              ?????
2E11: 7B              ?????
2E12: 5F              CLRb
2E13: BE FF 14        LDX $FF14
2E16: F3 46 14        ADDD $4614
2E19: 53              COMb
2E1A: 15              ?????
2E1B: 53              COMb
2E1C: D1 B5           CMPb $B5
2E1E: 83 64 97        SUBd #$6497
2E21: 96 D3           LDa $D3
2E23: 6D 73           TST -$0D,S
2E25: 15              ?????
2E26: C1 B1           CMPb #$B1
2E28: 3F              SWI1
2E29: DE 8F           LDU $8F
2E2B: 16 2C 49        LBRA $5A77
2E2E: DB E0           ADDb $E0
2E30: 07 1D           ASR $1D
2E32: 0D 1B           TST $1B
2E34: 0A 15           DEC $15
2E36: 04 17           LSR $17
2E38: 7A C4 CB        DEC $C4CB
2E3B: 06 82           ROR $82
2E3D: 17 95 7A        LBSR $C3BA
2E40: BD 15 49        JSR $1549
2E43: 90 50           SUBa $50
2E45: 9F D6           STX $D6
2E47: 6A C4           DEC ,U
2E49: 9C 55           CMPX $55
2E4B: 5E              ?????
2E4C: DD 78           STD $78
2E4E: 21 02           BRN $2E52
2E50: 09 E3           ROL $E3
2E52: 59              ROLb
2E53: 09 58           ROL $58
2E55: 31 49           LEAY +$09,U
2E57: CE A1 45        LDU #$A145
2E5A: 25 32           BCS $2E8E
2E5C: FF 00 80        STU $0080
2E5F: 07 28           ASR $28
2E61: 0B              ?????
2E62: 26 0A           BNE $2E6E
2E64: 17 20 04        LBSR $4E6B
2E67: 1E C7           EXG ??,??
2E69: DE D3           LDU $D3
2E6B: 14              ?????
2E6C: 90 96           SUBa $96
2E6E: F3 A0 C3        ADDD $A0C3
2E71: 54              LSRb
2E72: A3 91           SUBD [,X++]
2E74: 5F              CLRb
2E75: BE F3 17        LDX $F317
2E78: 16 8D D6        LBRA $BC51
2E7B: 15              ?????
2E7C: D5 15           BITb $15
2E7E: 89 17           ADCa #$17
2E80: D5 9C           BITb $9C
2E82: C1 93           CMPb #$93
2E84: 77 BE 34        ASR $BE34
2E87: 01              ?????
2E88: 89 02           ADCa #$02
2E8A: 03 0E           COM $0E
2E8C: D0 4C           SUBb $4C
2E8E: 26 29           BNE $2EB9
2E90: 9D 00           JSR $00
2E92: 80 03           SUBa #$03
2E94: 1E 4E           EXG S,??
2E96: 45              ?????
2E97: 31 49           LEAY +$09,U
2E99: 50              NEGb
2E9A: 5E              ?????
2E9B: 91 62           CMPa $62
2E9D: B5 A0 B8        BITa $A0B8
2EA0: 16 D3 17        LBRA $01BA
2EA3: 75              ?????
2EA4: 98 DE           EORa $DE
2EA6: 14              ?????
2EA7: 91 7A           CMPa $7A
2EA9: D6 B5           LDb $B5
2EAB: D6 9C           LDb $9C
2EAD: DB 72           ADDb $72
2EAF: 0E D0           JMP $D0
2EB1: 9B 8F           ADDa $8F
2EB3: 02              ?????
2EB4: 04 10           LSR $10
2EB6: CB 4B           ADDb #$4B
2EB8: 62              ?????
2EB9: 1E 28           EXG Y,A
2EBB: 8F              ?????
2EBC: 05              ?????
2EBD: A0 03           SUBa +$03,X
2EBF: 16 5F BE        LBRA $8E80
2EC2: 5B              ?????
2EC3: B1 4B 7B        CMPa $4B7B
2EC6: 49              ROLa
2EC7: 45              ?????
2EC8: BE 9F 83        LDX $9F83
2ECB: 61              ?????
2ECC: 29 54           BVS $2F22
2ECE: 26 A7           BNE $2E77
2ED0: DD 78           STD $78
2ED2: 9F 15           STX $15
2ED4: 7F B1 02        CLR $B102
2ED7: 0B              ?????
2ED8: 3E              RESET*
2ED9: 6E F0           JMP [,S+]
2EDB: 59              ROLb
2EDC: DA 14           ORb $14
2EDE: 6D A0           TST ,Y+
2EE0: 85 BE           BITa #$BE
2EE2: 4B              ?????
2EE3: 28 80           BVC $2E65
2EE5: CA 9C           ORb #$9C
2EE7: 00 90           NEG $90
2EE9: 03 27           COM $27
2EEB: B8 B7 2B        EORa $B72B
2EEE: 62              ?????
2EEF: 09 8A           ROL $8A
2EF1: 94 C3           ANDa $C3
2EF3: 0B              ?????
2EF4: 5C              INCb
2EF5: 14              ?????
2EF6: 53              COMb
2EF7: 8B B4           ADDa #$B4
2EF9: AB 98 F6        ADDa [-$ A,X]
2EFC: 8B 4E           ADDa #$4E
2EFE: 72              ?????
2EFF: E4 14           ANDb -$0C,X
2F01: E5 A0           BITb ,Y+
2F03: 09 4F           ROL $4F
2F05: D6 B5           LDb $B5
2F07: 38              ?????
2F08: C6 89           LDb #$89
2F0A: 17 4B 15        LBSR $7A22
2F0D: 9B 53           ADDa $53
2F0F: C7              ?????
2F10: DE 2E           LDU $2E
2F12: 08 80           LSL $80
2F14: 95 0E           BITa $0E
2F16: 80 92           SUBa #$92
2F18: 0D 2F           TST $2F
2F1A: 14              ?????
2F1B: 01              ?????
2F1C: 1D              SEX
2F1D: 0B              ?????
2F1E: 29 03           BVS $2F23
2F20: 9C 23           CMPX $23
2F22: 07 0D           ASR $0D
2F24: 05              ?????
2F25: 00 9D           NEG $9D
2F27: 01              ?????
2F28: 1D              SEX
2F29: 86 9F           LDa #$9F
2F2B: 23 07           BLS $2F34
2F2D: 0D 05           TST $05
2F2F: 00 9C           NEG $9C
2F31: 01              ?????
2F32: 1D              SEX
2F33: 86 9E           LDa #$9E
2F35: 23 07           BLS $2F3E
2F37: 0D 05           TST $05
2F39: 00 9F           NEG $9F
2F3B: 01              ?????
2F3C: 1D              SEX
2F3D: 86 9D           LDa #$9D
2F3F: 23 07           BLS $2F48
2F41: 0D 05           TST $05
2F43: 00 9E           NEG $9E
2F45: 01              ?????
2F46: 1D              SEX
2F47: 86 0C           LDa #$0C
2F49: 0D 5F           TST $5F
2F4B: 01              ?????
2F4C: 1D              SEX
2F4D: 1C 1D           ANDCC #$1D
2F4F: 1F 58           TFR PC,A
2F51: A6 1D           LDa -$03,X
2F53: 51              ?????
2F54: A0 D0           SUBa [,U+]
2F56: 15              ?????
2F57: 06 67           ROR $67
2F59: 33 61           LEAU +$01,S
2F5B: 79 5B 06        ROL $5B06
2F5E: 07 82           ASR $82
2F60: 17 49 5E        LBSR $78C1
2F63: 94 C3           ANDa $C3
2F65: 0B              ?????
2F66: 5C              INCb
2F67: F8 8B 33        EORb $8B33
2F6A: 61              ?????
2F6B: 5F              CLRb
2F6C: BE 23 7B        LDX $237B
2F6F: B9 55 D4        ADCa $55D4
2F72: B9 85 A1        ADCa $85A1
2F75: 90 14           SUBa $14
2F77: 0E 58           JMP $58
2F79: 45              ?????
2F7A: A0 56           SUBa -$0A,U
2F7C: 5E              ?????
2F7D: EB 72           ADDb -$0E,S
2F7F: 84 AF           ANDa #$AF
2F81: CE 9F 6B        LDU #$9F6B
2F84: B5 C7 DE        BITa $C7DE
2F87: 84 AF           ANDa #$AF
2F89: 93 9E           SUBd $9E
2F8B: 4B              ?????
2F8C: 15              ?????
2F8D: 0D 8D           TST $8D
2F8F: 89 17           ADCa #$17
2F91: 82 17           SBCa #$17
2F93: 49              ROLa
2F94: 5E              ?????
2F95: 07 B3           ASR $B3
2F97: 33 98 06        LEAU [+$ 6,X]
2F9A: B2 FF 5A        SBCa $FF5A
2F9D: 19              DAA
2F9E: 58              ASLb
2F9F: 82 7B           SBCa #$7B
2FA1: 82 17           SBCa #$17
2FA3: 55              ?????
2FA4: 5E              ?????
2FA5: 48              ASLa
2FA6: 72              ?????
2FA7: 09 C0           ROL $C0
2FA9: 81 02           CMPa #$02
2FAB: 04 23           LSR $23
2FAD: 6F 4D           CLR +$0D,U
2FAF: B1 29 4C        CMPa $294C
2FB2: 1D              SEX
2FB3: 00 00           NEG $00
2FB5: 08 47           LSL $47
2FB7: 0B              ?????
2FB8: 45              ?????
2FB9: 03 9C           COM $9C
2FBB: 23 0E           BLS $2FCB
2FBD: 0E 0C           JMP $0C
2FBF: 0D 04           TST $04
2FC1: 03 9A           COM $9A
2FC3: 1D              SEX
2FC4: 85 0D           BITa #$0D
2FC6: 04 03           LSR $03
2FC8: 99 1D           ADCa $1D
2FCA: 87              ?????
2FCB: 9F 23           STX $23
2FCD: 0E 0E           JMP $0E
2FCF: 0C 0D           INC $0D
2FD1: 04 03           LSR $03
2FD3: 99 1D           ADCa $1D
2FD5: 85 0D           BITa #$0D
2FD7: 04 03           LSR $03
2FD9: 98 1D           EORa $1D
2FDB: 87              ?????
2FDC: 9E 23           LDX $23
2FDE: 0E 0E           JMP $0E
2FE0: 0C 0D           INC $0D
2FE2: 04 03           LSR $03
2FE4: 98 1D           EORa $1D
2FE6: 85 0D           BITa #$0D
2FE8: 04 03           LSR $03
2FEA: 9B 1D           ADDa $1D
2FEC: 87              ?????
2FED: 9D 23           JSR $23
2FEF: 0E 0E           JMP $0E
2FF1: 0C 0D           INC $0D
2FF3: 04 03           LSR $03
2FF5: 9B 1D           ADDa $1D
2FF7: 85 0D           BITa #$0D
2FF9: 04 03           LSR $03
2FFB: 9A 1D           ORa $1D
2FFD: 87              ?????
2FFE: 13              SYNC
2FFF: 30 9C 00        LEAX [+$00,PC]
3002: A0 02           SUBa +$02,X
3004: 08 EF           LSL $EF
3006: A6 51           LDa -$0F,U
3008: 54              LSRb
3009: 4B              ?????
300A: C6 AF           LDb #$AF
300C: 6C 08           INC +$08,X
300E: 21 0D           BRN $301D
3010: 1F 03           TFR D,U
3012: 9C 25           CMPX $25
3014: 0B              ?????
3015: 1A 05           ORCC #$05
3017: 33 03           LEAU +$03,X
3019: 17 25 89        LBSR $55A5
301C: 66 03           ROR +$03,X
301E: 17 25 94        LBSR $55B5
3021: 99 03           ADCa $03
3023: 17 25 86        LBSR $55AC
3026: CC 03 17        LDD #$0317
3029: 25 8E           BCS $2FB9
302B: FF 03 17        STU $0317
302E: 25 83           BCS $2FB3
3030: 13              SYNC
3031: 23 00           BLS $3033
3033: 05              ?????
3034: A0 02           SUBa +$02,X
3036: 08 EF           LSL $EF
3038: A6 51           LDa -$0F,U
303A: 54              LSRb
303B: 4B              ?????
303C: C6 AF           LDb #$AF
303E: 6C 03           INC +$03,X
3040: 14              ?????
3041: 5F              CLRb
3042: BE 5B B1        LDX $5BB1
3045: 4B              ?????
3046: 7B              ?????
3047: 52              ?????
3048: 45              ?????
3049: 65              ?????
304A: B1 C7 7A        CMPa $C77A
304D: C9 B5           ADCb #$B5
304F: 5B              ?????
3050: 61              ?????
3051: F4 72 DB        ANDb $72DB
3054: 63 2A           COM +$0A,Y
3056: 32 FF 00 00     LEAS [$0000]
305A: 02              ?????
305B: 03 01           COM $01
305D: B3 4D 07        SUBD $4D07
3060: 28 0D           BVC $306F
3062: 26 0A           BNE $306E
3064: 0B              ?????
3065: 01              ?????
3066: 25 04           BCS $306C
3068: 20 C7           BRA $3031
306A: DE 03           LDU $03
306C: 15              ?????
306D: 61              ?????
306E: B7 74 CA        STa $74CA
3071: 7B              ?????
3072: 14              ?????
3073: EF A6           STU A,Y
3075: 51              ?????
3076: 54              LSRb
3077: 4B              ?????
3078: C6 AF           LDb #$AF
307A: 6C A3           INC ,--Y
307C: 15              ?????
307D: BF 59 8B        STX $598B
3080: 96 83           LDa $83
3082: 96 E4           LDa $E4
3084: 14              ?????
3085: D3 62           ADDD $62
3087: BF 53 1B        STX $531B
308A: 62              ?????
308B: 00 00           NEG $00
308D: AC 02           CMPX +$02,X
308F: 03 4F           COM $4F
3091: 8B 50           ADDa #$50
3093: 03 0E           COM $0E
3095: 5F              CLRb
3096: BE 5B B1        LDX $5BB1
3099: 4B              ?????
309A: 7B              ?????
309B: 4E              ?????
309C: 45              ?????
309D: 72              ?????
309E: 48              ASLa
309F: 9F 15           STX $15
30A1: 7F B1 07        CLR $B107
30A4: 48              ASLa
30A5: 0B              ?????
30A6: 46              RORa
30A7: 0A 14           DEC $14
30A9: 1C 0E           ANDCC #$0E
30AB: 1A 0D           ORCC #$0D
30AD: 17 09 12        LBSR $39C2
30B0: 1E 28           EXG Y,A
30B2: 14              ?????
30B3: 04 10           LSR $10
30B5: 5F              CLRb
30B6: BE 3B 16        LDX $3B16
30B9: D3 93           ADDD $93
30BB: 4B              ?????
30BC: 7B              ?????
30BD: 09 9A           ROL $9A
30BF: BF 14 D3        STX $14D3
30C2: B2 CF 98        SBCa $CF98
30C5: 88 18           EORa #$18
30C7: 19              DAA
30C8: 04 17           LSR $17
30CA: 29 D1           BVS $309D
30CC: 09 15           ROL $15
30CE: 51              ?????
30CF: 18              ?????
30D0: 56              RORb
30D1: C2 90           SBCb #$90
30D3: 73 DB 83        COM $DB83
30D6: 1B              ?????
30D7: A1 2F           CMPa +$0F,Y
30D9: 49              ROLa
30DA: 03 EE           COM $EE
30DC: 46              RORa
30DD: 8B 90           ADDa #$90
30DF: 5A              DECb
30E0: 3F              SWI1
30E1: 08 0A           LSL $0A
30E3: 04 08           LSR $08
30E5: 49              ROLa
30E6: 1B              ?????
30E7: 99 16           ADCa $16
30E9: 14              ?????
30EA: BC A4 C3        CMPX $A4C3
30ED: 2B 09           BMI $30F8
30EF: 00 00           NEG $00
30F1: 80 02           SUBa #$02
30F3: 04 89           LSR $89
30F5: 67 A3           ASR ,--Y
30F7: A0 2C           SUBa +$0C,Y
30F9: 0B              ?????
30FA: 00 00           NEG $00
30FC: 80 07           SUBa #$07
30FE: 01              ?????
30FF: 93 02           SUBd $02
3101: 03 23           COM $23
3103: 63 54           COM -$0C,U
3105: 2D 0D           BLT $3114
3107: 00 00           NEG $00
3109: 80 07           SUBa #$07
310B: 01              ?????
310C: 93 02           SUBd $02
310E: 05              ?????
310F: 55              ?????
3110: A4 09           ANDa +$09,X
3112: B7 45 2E        STa $452E
3115: 0B              ?????
3116: 00 00           NEG $00
3118: 80 07           SUBa #$07
311A: 01              ?????
311B: 93 02           SUBd $02
311D: 03 7E           COM $7E
311F: 74 45 2F        LSR $452F
3122: 0E 00           JMP $00
3124: 00 80           NEG $80
3126: 07 01           ASR $01
3128: 93 02           SUBd $02
312A: 06 44           ROR $44
312C: 55              ?????
312D: 06 B2           ROR $B2
312F: A3 A0           SUBD ,Y+
3131: 30 09           LEAX +$09,X
3133: 00 00           NEG $00
3135: 80 02           SUBa #$02
3137: 04 44           LSR $44
3139: 55              ?????
313A: 74 98 31        LSR $9831
313D: 07 88           ASR $88
313F: 00 80           NEG $80
3141: 02              ?????
3142: 02              ?????
3143: 09 4F           ROL $4F
3145: 32 09           LEAS +$09,X
3147: 88 00           EORa #$00
3149: 80 02           SUBa #$02
314B: 04 3C           LSR $3C
314D: 49              ROLa
314E: 6B              ?????
314F: A1 33           CMPa -$0D,Y
3151: 0D 00           TST $00
3153: 00 80           NEG $80
3155: 07 01           ASR $01
3157: 93 02           SUBd $02
3159: 05              ?????
315A: 4E              ?????
315B: 72              ?????
315C: B3 8E 59        SUBD $8E59
315F: 34 0A           PSHS ,DP,A
3161: 8D 00           BSR $3163
3163: 80 02           SUBa #$02
3165: 05              ?????
3166: 1B              ?????
3167: 54              LSRb
3168: AF 91           STX [,X++]
316A: 52              ?????
316B: 35 09           PULS ,CC,DP
316D: 91 00           CMPa $00
316F: 80 02           SUBa #$02
3171: 04 D7           LSR $D7
3173: C9 33           ADCb #$33
3175: 8E 36 0E        LDX #$360E
3178: 00 00           NEG $00
317A: 80 07           SUBa #$07
317C: 01              ?????
317D: 93 02           SUBd $02
317F: 06 9E           ROR $9E
3181: 61              ?????
3182: D0 B0           SUBb $B0
3184: 9B 53           ADDa $53
3186: 37 0C           PULU ,B,DP
3188: 00 00           NEG $00
318A: 80 07           SUBa #$07
318C: 01              ?????
318D: 93 02           SUBd $02
318F: 04 70           LSR $70
3191: C0 6E           SUBb #$6E
3193: 98 38           EORa $38
3195: 0C FF           INC $FF
3197: 00 80           NEG $80
3199: 07 01           ASR $01
319B: 93 02           SUBd $02
319D: 04 F0           LSR $F0
319F: 81 BF           CMPa #$BF
31A1: 6D 39           TST -$07,Y
31A3: 0C FF           INC $FF
31A5: 00 80           NEG $80
31A7: 07 01           ASR $01
31A9: 93 02           SUBd $02
31AB: 04 EF           LSR $EF
31AD: BD FF A5        JSR $FFA5
31B0: 24 0B           BCC $31BD
31B2: 9C 00           CMPX $00
31B4: 80 02           SUBa #$02
31B6: 06 B4           ROR $B4
31B8: B7 F0 A4        STa $F0A4
31BB: 0B              ?????
31BC: C0 3A           SUBb #$3A
31BE: 31 82           LEAY ,-X
31C0: 00 80           NEG $80
31C2: 07 28           ASR $28
31C4: 0B              ?????
31C5: 26 0A           BNE $31D1
31C7: 36 01           PSHU ,CC
31C9: 8A 33           ORa #$33
31CB: 01              ?????
31CC: 8A 34           ORa #$34
31CE: 01              ?????
31CF: 8A 26           ORa #$26
31D1: 17 04 15        LBSR $35E9
31D4: 5F              CLRb
31D5: BE 5B B1        LDX $5BB1
31D8: 4B              ?????
31D9: 7B              ?????
31DA: EB 99 1B D0     ADDb [$1BD0,X]
31DE: 94 14           ANDa $14
31E0: 30 A1           LEAX ,Y++ 
31E2: 16 58 DB        LBRA $8AC0
31E5: 72              ?????
31E6: 96 A5           LDa $A5
31E8: 2E 17           BGT $3201
31EA: 01              ?????
31EB: 8A 02           ORa #$02
31ED: 02              ?????
31EE: 96 A5           LDa $A5
31F0: 3B              RTI
31F1: 0A 00           DEC $00
31F3: 00 80           NEG $80
31F5: 02              ?????
31F6: 05              ?????
31F7: AB 53           ADDa -$0D,U
31F9: 90 8C           SUBa $8C
31FB: 47              ASRa
31FC: 22 39           BHI $3237
31FE: A5 00           BITa +$00,X
3200: 80 02           SUBa #$02
3202: 04 4E           LSR $4E
3204: 48              ASLa
3205: 23 62           BLS $3269
3207: 07 2E           ASR $2E
3209: 0D 2C           TST $2C
320B: 0A 12           DEC $12
320D: 04 28           LSR $28
320F: C7              ?????
3210: DE D3           LDU $D3
3212: 14              ?????
3213: 90 96           SUBa $96
3215: F3 A0 C8        ADDD $A0C8
3218: 93 56           SUBd $56
321A: 5E              ?????
321B: DB 72           ADDb $72
321D: 4E              ?????
321E: 48              ASLa
321F: 23 62           BLS $3283
3221: 79 68 44        ROL $6844
3224: 90 8F           SUBa $8F
3226: 61              ?????
3227: 82 49           SBCa #$49
3229: D6 15           LDb $15
322B: 0B              ?????
322C: EE 0B           LDU +$0B,X
322E: BC D6 B5        CMPX $D6B5
3231: 2B A0           BMI $31D3
3233: E3 72           ADDD -$0E,S
3235: 9F CD           STX $CD
3237: 3C 03           CWAI #03
3239: 1D              SEX
323A: 00 80           NEG $80
323C: 00 85           NEG $85
323E: BB 0E 85        ADDa $0E85
3241: B8 0D 2C        EORa $0D2C
3244: 0E 08           JMP $08
3246: 0A 01           DEC $01
3248: 0A 02           DEC $02
324A: 0A 03           DEC $03
324C: 0A 04           DEC $04
324E: 0E 20           JMP $20
3250: 13              SYNC
3251: 0D 1D           TST $1D
3253: 04 19           LSR $19
3255: 5F              CLRb
3256: BE 5B B1        LDX $5BB1
3259: 4B              ?????
325A: 7B              ?????
325B: EB 99 1B D0     ADDb [$1BD0,X]
325F: 89 17           ADCa #$17
3261: 81 15           CMPa #$15
3263: 82 17           SBCa #$17
3265: 73 49 94        COM $4994
3268: 5A              DECb
3269: E6 5F           LDb -$01,U
326B: C0 7A           SUBb #$7A
326D: 2E 20           BGT $328F
326F: 1D              SEX
3270: 0B              ?????
3271: 85 83           BITa #$83
3273: 0A 05           DEC $05
3275: 21 0E           BRN $3285
3277: 1F 0D           TFR D,??
3279: 19              DAA
327A: 1A 18           ORCC #$18
327C: 04 13           LSR $13
327E: C7              ?????
327F: DE 94           LDU $94
3281: 14              ?????
3282: 43              COMa
3283: 5E              ?????
3284: EF 8D 13 47     STU $1347,PC
3288: D3 14           ADDD $14
328A: 83 B3 91        SUBd #$B391
328D: 7A 82 17        DEC $8217
3290: 45              ?????
3291: 16 84 13        LBRA $B6A7
3294: 83 14 0C        SUBd #$140C
3297: 06 0C           ROR $0C
3299: 0D 0A           TST $0A
329B: 1A 10           ORCC #$10
329D: 04 06           LSR $06
329F: F9 5B 9F        ADCb $5B9F
32A2: A6 9B           LDa [D,X]
32A4: 5D              TSTb
32A5: 08 17           LSL $17
32A7: 0E 15           JMP $15
32A9: 13              SYNC
32AA: 0D 12           TST $12
32AC: 04 0E           LSR $0E
32AE: 89 74           ADCa #$74
32B0: D3 14           ADDD $14
32B2: 9B 96           ADDa $96
32B4: 1B              ?????
32B5: A1 63           CMPa +$03,S
32B7: B1 16 58        CMPa $1658
32BA: DB 72           ADDb $72
32BC: 11 84           ?????
32BE: 11 16           ?????
32C0: 0E 14           JMP $14
32C2: 13              SYNC
32C3: 0D 11           TST $11
32C5: 04 0D           LSR $0D
32C7: EB 99 0F A0     ADDb [$0FA0,X]
32CB: D3 14           ADDD $14
32CD: 91 96           CMPa $96
32CF: F0 A4 82        SUBb $A482
32D2: 17 45 11        LBSR $77E6
32D5: 84 12           ANDa #$12
32D7: 21 0E           BRN $32E7
32D9: 1F 13           TFR X,U
32DB: 0D 1C           TST $1C
32DD: 04 13           LSR $13
32DF: 33 D1           LEAU [,U++]
32E1: 09 15           ROL $15
32E3: E6 96           LDb [A,X]
32E5: 51              ?????
32E6: 18              ?????
32E7: 4E              ?????
32E8: C2 98           SBCb #$98
32EA: 5F              CLRb
32EB: 56              RORb
32EC: 5E              ?????
32ED: DB 72           ADDb $72
32EF: 81 A6           CMPa #$A6
32F1: 52              ?????
32F2: 11 04           ?????
32F4: 04 49           LSR $49
32F6: 48              ASLa
32F7: 7F 98 09        CLR $9809
32FA: 81 37           CMPa #$37
32FC: 0E 81           JMP $81
32FE: 34 14           PSHS ,X,B
3300: 1B              ?????
3301: 14              ?????
3302: 0E 03           JMP $03
3304: 09 17           ROL $17
3306: 83 0E 81        SUBd #$0E81
3309: 29 0D           BVS $3318
330B: 1F 14           TFR X,S
330D: 15              ?????
330E: 40              NEGa
330F: 14              ?????
3310: 09 17           ROL $17
3312: 04 0C           LSR $0C
3314: C7              ?????
3315: DE D3           LDU $D3
3317: 14              ?????
3318: E6 96           LDb [A,X]
331A: AF 15           STX -$0B,X
331C: B3 B3 5F        SUBD $B35F
331F: BE 11 04        LDX $1104
3322: 06 56           ROR $56
3324: D1 16           CMPb $16
3326: 71              ?????
3327: DB 72           ADDb $72
3329: 12              NOP 
332A: 84 13           ANDa #$13
332C: 0D 1A           TST $1A
332E: 1A 14           ORCC #$14
3330: 15              ?????
3331: 10 04           ?????
3333: 12              NOP 
3334: 73 7B 77        COM $7B77
3337: 5B              ?????
3338: D0 B5           SUBb $B5
333A: C9 9C           ADCb #$9C
333C: 36 A0           PSHU ,PC,Y
333E: 89 17           ADCa #$17
3340: 96 14           LDa $14
3342: 45              ?????
3343: BD C3 83        JSR $C383
3346: 11 84           ?????
3348: 0D 80           TST $80
334A: D7 1A           STb $1A
334C: 0B              ?????
334D: 80 D3           SUBa #$D3
334F: 09 09           ROL $09
3351: 80 99           SUBa #$99
3353: 0B              ?????
3354: 80 96           SUBa #$96
3356: 05              ?????
3357: 52              ?????
3358: 28 0D           BVC $3367
335A: 26 04           BNE $3360
335C: 17 4F 45        LBSR $82A4
335F: 7A 79 FB        DEC $79FB
3362: C0 6C           SUBb #$6C
3364: BE 66 C6        LDX $66C6
3367: 04 EE           LSR $EE
3369: 73 C6 73        COM $C673
336C: 7B              ?????
336D: D5 92           BITb $92
336F: B5 B7 82        BITa $B782
3372: 17 45 16        LBSR $788B
3375: 04 0A           LSR $0A
3377: 7B              ?????
3378: 50              NEGb
3379: 4D              TSTa
337A: 45              ?????
337B: 49              ROLa
337C: 7A 36 92        DEC $3692
337F: 21 62           BRN $33E3
3381: A4 2D           ANDa +$0D,Y
3383: 0D 2B           TST $2B
3385: 04 1C           LSR $1C
3387: 89 4E           ADCa #$4E
3389: 73 9E F5        COM $9EF5
338C: B3 F5 72        SUBD $F572
338F: 59              ROLb
3390: 15              ?????
3391: C2 B3           SBCb #$B3
3393: 95 14           BITa $14
3395: 51              ?????
3396: 18              ?????
3397: 4A              DECa
3398: C2 CF           SBCb #$CF
339A: 49              ROLa
339B: 5E              ?????
339C: 17 5A 49        LBSR $8DE8
339F: F3 5F 5F        ADDD $5F5F
33A2: BE 16 04        LDX $1604
33A5: 08 83           LSL $83
33A7: 7A 5F BE        DEC $5FBE
33AA: 94 14           ANDa $14
33AC: EB 8F 1D 0A     ADDb $1D0A,X
33B0: FD 20 0D        STD $200D
33B3: 1E 04           EXG D,S
33B5: 1A C7           ORCC #$C7
33B7: DE 63           LDU $63
33B9: 16 C9 97        LBRA $FD53
33BC: 43              COMa
33BD: 5E              ?????
33BE: 84 15           ANDa #$15
33C0: 73 4A AB        COM $4AAB
33C3: 98 89           EORa $89
33C5: 4E              ?????
33C6: D6 CE           LDb $CE
33C8: D6 9C           LDb $9C
33CA: DB 72           ADDb $72
33CC: 1F 54           TFR PC,S
33CE: F1 B9 1D        CMPb $B91D
33D1: 14              ?????
33D2: FF 18 0D        STU $180D
33D5: 16 04 12        LBRA $37EA
33D8: 4E              ?????
33D9: 45              ?????
33DA: DD C3           STD $C3
33DC: 44              LSRa
33DD: DB 89           ADDb $89
33DF: 8D 89           BSR $336A
33E1: 17 82 17        LBSR $B5FB
33E4: 4A              DECa
33E5: 5E              ?????
33E6: 94 5F           ANDa $5F
33E8: AB BB           ADDa [D,Y]
33EA: 1D              SEX
33EB: FF 17 34        STU $1734
33EE: 0B              ?????
33EF: 32 05           LEAS +$05,X
33F1: AF 14           STX -$0C,X
33F3: 04 12           LSR $12
33F5: 59              ROLb
33F6: 45              ?????
33F7: 3E              RESET*
33F8: 7A EF 16        DEC $EF16
33FB: 1A 98           ORCC #$98
33FD: 90 14           SUBa $14
33FF: 1B              ?????
3400: 58              ASLb
3401: 1B              ?????
3402: A1 D5           CMPa [B,U]
3404: 92 5B           SBCa $5B
3406: BB FF 19        ADDa $FF19
3409: 0D 17           TST $17
340B: 04 13           LSR $13
340D: C7              ?????
340E: DE EF           LDU $EF
3410: 16 1A 98        LBRA $4EAB
3413: F3 5F 8F        ADDD $5F8F
3416: 73 D0 15        COM $D015
3419: 82 17           SBCa #$17
341B: 4A              DECa
341C: 5E              ?????
341D: 86 5F           LDa #$5F
341F: 21 1D           BRN $343E
3421: 03 0D           COM $0D
3423: 0F 04           CLR $04
3425: 02              ?????
3426: 5F              CLRb
3427: BE 11 04        LDX $1104
342A: 08 4B           LSL $4B
342C: 7B              ?????
342D: 92 C5           SBCa $C5
342F: 37 49           PULU ,CC,DP,S
3431: 17 60 0A        LBSR $943E
3434: 01              ?????
3435: 07 15           ASR $15
3437: 29 0E           BVS $3447
3439: 27 13           BEQ $344E
343B: 0D 24           TST $24
343D: 04 0D           LSR $0D
343F: 80 5B           SUBa #$5B
3441: F3 23 5B        ADDD $235B
3444: 4D              TSTa
3445: 4E              ?????
3446: B8 F9 8E        EORa $F98E
3449: 82 17           SBCa #$17
344B: 45              ?????
344C: 11 04           ?????
344E: 12              NOP 
344F: 47              ASRa
3450: D2 C8           SBCb $C8
3452: 8B F3           ADDa #$F3
3454: 23 55           BLS $34AB
3456: BD DB BD        JSR $DBBD
3459: 41              ?????
345A: 6E 03           JMP +$03,X
345C: 58              ASLb
345D: 99 9B           ADCa $9B
345F: 5F              CLRb
3460: 4A              DECa
3461: 17 51 0E        LBSR $8572
3464: 4F              CLRa
3465: 13              SYNC
3466: 0D 25           TST $25
3468: 1A 15           ORCC #$15
346A: 10 04           ?????
346C: 0C 46           INC $46
346E: 77 05 A0        ASR $05A0
3471: 16 BC 90        LBRA $F104
3474: 73 D6 83        COM $D683
3477: DB 72           ADDb $72
3479: 11 04           ?????
347B: 11 4E           ?????
347D: D1 15           CMPb $15
347F: 8A 50           ORa #$50
3481: BD 15 58        JSR $1558
3484: 8E BE 08        LDX #$BE08
3487: 8A BE           ORa #$BE
3489: A0 56           SUBa -$0A,U
348B: 72              ?????
348C: 2E 0D           BGT $349B
348E: 25 04           BCS $3494
3490: 12              NOP 
3491: CF              ?????
3492: 62              ?????
3493: 8B 96           ADDa #$96
3495: 9B 64           ADDa $64
3497: 1B              ?????
3498: A1 47           CMPa +$07,U
349A: 55              ?????
349B: B3 8B C3        SUBD $8BC3
349E: 54              LSRb
349F: A3 91           SUBD [,X++]
34A1: 5F              CLRb
34A2: BE 11 04        LDX $1104
34A5: 0E 73           JMP $73
34A7: 7B              ?????
34A8: 47              ASRa
34A9: D2 C8           SBCb $C8
34AB: 8B F3           ADDa #$F3
34AD: 23 EE           BLS $349D
34AF: 72              ?????
34B0: 1B              ?????
34B1: A3 3F           SUBD -$01,Y
34B3: A1 16           CMPa -$0A,X
34B5: 16 0E 14        LBRA $42CC
34B8: 13              SYNC
34B9: 0D 11           TST $11
34BB: 04 02           LSR $02
34BD: 5F              CLRb
34BE: BE 11 04        LDX $1104
34C1: 0A 4B           DEC $4B
34C3: 7B              ?????
34C4: 06 9A           ROR $9A
34C6: BF 14 D3        STX $14D3
34C9: B2 CF 98        SBCa $CF98
34CC: 18              ?????
34CD: 35 0E           PULS ,A,B,DP
34CF: 33 13           LEAU -$0D,X
34D1: 0D 18           TST $18
34D3: 1A 15           ORCC #$15
34D5: 10 04           ?????
34D7: 11 5B           ?????
34D9: BE 65 BC        LDX $65BC
34DC: 99 16           ADCa $16
34DE: F3 17 56        ADDD $1756
34E1: DB CA           ADDb $CA
34E3: 9C 3E           CMPX $3E
34E5: C6 82           LDb #$82
34E7: 17 45 16        LBSR $7A00
34EA: 84 0D           ANDa #$0D
34EC: 16 04 02        LBRA $38F1
34EF: 5F              CLRb
34F0: BE 11 04        LDX $1104
34F3: 0F 81           CLR $81
34F5: 8D CB           BSR $34C2
34F7: 87              ?????
34F8: A5 94           BITa [,X]
34FA: 04 71           LSR $71
34FC: 8E 62 23        LDX #$6223
34FF: 62              ?????
3500: 09 9A           ROL $9A
3502: 2E 0B           BGT $350F
3504: 3A              ABX
3505: 0E 38           JMP $38
3507: 13              SYNC
3508: 0D 19           TST $19
350A: 1A 15           ORCC #$15
350C: 04 04           LSR $04
350E: 12              NOP 
350F: 3F              SWI1
3510: B9 82 62        ADCa $8262
3513: 91 7A           CMPa $7A
3515: D5 15           BITb $15
3517: 04 18           LSR $18
3519: 8E 7B 83        LDX #$7B83
351C: 61              ?????
351D: 03 A0           COM $A0
351F: 5F              CLRb
3520: BE 16 84        LDX $1684
3523: 0D 1A           TST $1A
3525: 04 16           LSR $16
3527: 5F              CLRb
3528: BE 5D B1        LDX $5DB1
352B: D0 B5           SUBb $B5
352D: 02              ?????
352E: A1 91           CMPa [,X++]
3530: 7A 62 17        DEC $6217
3533: DB 5F           ADDb $5F
3535: 33 48           LEAU +$08,U
3537: B9 46 73        ADCa $4673
353A: C6 5F           LDb #$5F
353C: BE 11 84        LDX $1184
353F: 0C 1A           INC $1A
3541: 0E 18           JMP $18
3543: 13              SYNC
3544: 0D 15           TST $15
3546: 04 11           LSR $11
3548: 5F              CLRb
3549: BE 5D B1        LDX $5DB1
354C: D0 B5           SUBb $B5
354E: 02              ?????
354F: A1 91           CMPa [,X++]
3551: 7A B0 17        DEC $B017
3554: F4 59 82        ANDb $5982
3557: 17 45 11        LBSR $7A6B
355A: 84 10           ANDa #$10
355C: 18              ?????
355D: 0E 16           JMP $16
355F: 13              SYNC
3560: 0D 13           TST $13
3562: 04 0F           LSR $0F
3564: 5F              CLRb
3565: BE 5D B1        LDX $5DB1
3568: D0 B5           SUBb $B5
356A: 02              ?????
356B: A1 91           CMPa [,X++]
356D: 7A D0 15        DEC $D015
3570: 82 17           SBCa #$17
3572: 45              ?????
3573: 11 84           ?????
3575: 1B              ?????
3576: 20 0E           BRA $3586
3578: 1E 13           EXG X,U
357A: 0D 03           TST $03
357C: 08 00           LSL $00
357E: 07 0D           ASR $0D
3580: 16 04 12        LBRA $3995
3583: 5F              CLRb
3584: BE 5B B1        LDX $5BB1
3587: 4B              ?????
3588: 7B              ?????
3589: 06 9A           ROR $9A
358B: 90 73           SUBa $73
358D: C3 6A 07        ADDd #$6A07
3590: B3 33 98        SUBD $3398
3593: 5F              CLRb
3594: BE 11 84        LDX $1184
3597: 1C 34           ANDCC #$34
3599: 0E 32           JMP $32
359B: 13              SYNC
359C: 0D 17           TST $17
359E: 08 00           LSL $00
35A0: 04 13           LSR $13
35A2: 5F              CLRb
35A3: BE 5B B1        LDX $5BB1
35A6: 4B              ?????
35A7: 7B              ?????
35A8: 06 9A           ROR $9A
35AA: 90 73           SUBa $73
35AC: C4 6A           ANDb #$6A
35AE: A3 60           SUBD +$00,S
35B0: 33 98 C7        LEAU [-$39,X]
35B3: DE 2E           LDU $2E
35B5: 0D 16           TST $16
35B7: 04 12           LSR $12
35B9: 5F              CLRb
35BA: BE 5B B1        LDX $5BB1
35BD: 4B              ?????
35BE: 7B              ?????
35BF: 06 9A           ROR $9A
35C1: 90 73           SUBa $73
35C3: C4 6A           ANDb #$6A
35C5: A3 60           SUBD +$00,S
35C7: 33 98 5F        LEAU [+$5F,X]
35CA: BE 11 84        LDX $1184
35CD: 21 0A           BRN $35D9
35CF: 04 08           LSR $08
35D1: B5 6C 8E        BITa $6C8E
35D4: C5 EB           BITb #$EB
35D6: 72              ?????
35D7: AB BB           ADDa [D,Y]
35D9: 22 12           BHI $35ED
35DB: 04 10           LSR $10
35DD: 5B              ?????
35DE: E0 27           SUBb +$07,Y
35E0: 60 31           NEG -$0F,Y
35E2: 60 41           NEG +$01,U
35E4: A0 49           SUBa +$09,U
35E6: A0 89 D3 89     SUBa $D389,X
35EA: D3 69           ADDD $69
35EC: CE 23 05        LDU #$2305
35EF: 0D 03           TST $03
35F1: 92 26           SBCa $26
35F3: 24 2C           BCC $3621
35F5: 04 0D           LSR $0D
35F7: 02              ?????
35F8: 92 26           SBCa $26
35FA: 3E              RESET*
35FB: 01              ?????
35FC: 27 3F           BEQ $363D
35FE: 01              ?????
35FF: 28 25           BVC $3626
3601: 0D 04           TST $04
3603: 0B              ?????
3604: 03 C0           COM $C0
3606: 7B              ?????
3607: 14              ?????
3608: 94 5A           ANDa $5A
360A: E6 5F           LDb -$01,U
360C: C0 7A           SUBb #$7A
360E: 2E 26           BGT $3636
3610: 24 0E           BCC $3620
3612: 22 13           BHI $3627
3614: 0D 17           TST $17
3616: 1A 15           ORCC #$15
3618: 10 04           ?????
361A: 02              ?????
361B: 5F              CLRb
361C: BE 11 04        LDX $1104
361F: 0D 40           TST $40
3621: D2 F3           SBCb $F3
3623: 23 F6           BLS $361B
3625: 8B 51           ADDa #$51
3627: 18              ?????
3628: 52              ?????
3629: C2 65           SBCb #$65
362B: 49              ROLa
362C: 21 04           BRN $3632
362E: 06 09           ROR $09
3630: 9A FA           ORa $FA
3632: 17 70 49        LBSR $A67E
3635: 3D              MUL
3636: 01              ?????
3637: 94 27           ANDa $27
3639: 0E 0E           JMP $0E
363B: 0C 13           INC $13
363D: 04 09           LSR $09
363F: 25 A1           BCS $35E2
3641: AB 70           ADDa -$10,S
3643: 3B              RTI
3644: 95 77           BITa $77
3646: BF 21 28        STX $2128
3649: 0A 0E           DEC $0E
364B: 08 13           LSL $13
364D: 0D 04           TST $04
364F: 1A 15           ORCC #$15
3651: 10 96           ?????
3653: 97 29           STa $29
3655: 0A 0E           DEC $0E
3657: 08 13           LSL $13
3659: 0D 04           TST $04
365B: 1B              ?????
365C: 15              ?????
365D: 10 96           ?????
365F: 97 2F           STa $2F
3661: 07 04           ASR $04
3663: 05              ?????
3664: 9B 29           ADDa $29
3666: 57              ASRb
3667: C6 3E           LDb #$3E
3669: 2D 09           BLT $3674
366B: 0E 07           JMP $07
366D: 13              SYNC
366E: 0D 02           TST $02
3670: 1A 83           ORCC #$83
3672: 14              ?????
3673: 0C 33           INC $33
3675: 04 0E           LSR $0E
3677: 02              ?????
3678: 13              SYNC
3679: 98 34           EORa $34
367B: 04 0E           LSR $0E
367D: 02              ?????
367E: 13              SYNC
367F: 98 36           EORa $36
3681: 17 0E 15        LBSR $4499
3684: 13              SYNC
3685: 0D 12           TST $12
3687: 04 0E           LSR $0E
3689: C7              ?????
368A: DE D3           LDU $D3
368C: 14              ?????
368D: E6 96           LDb [A,X]
368F: 77 15 0B        ASR $150B
3692: BC 96 96        CMPX $9696
3695: DB 72           ADDb $72
3697: 11 84           ?????
3699: 37 15           PULU ,CC,B,X
369B: 0E 13           JMP $13
369D: 13              SYNC
369E: 0D 10           TST $10
36A0: 04 0C           LSR $0C
36A2: C7              ?????
36A3: DE 94           LDU $94
36A5: 14              ?????
36A6: 85 61           BITa #$61
36A8: 0B              ?????
36A9: BC 96 96        CMPX $9696
36AC: DB 72           ADDb $72
36AE: 11 84           ?????
36B0: 38              ?????
36B1: 20 0E           BRA $36C1
36B3: 1E 13           EXG X,U
36B5: 0D 1B           TST $1B
36B7: 04 17           LSR $17
36B9: 5F              CLRb
36BA: BE 5B B1        LDX $5BB1
36BD: 4B              ?????
36BE: 7B              ?????
36BF: 06 9A           ROR $9A
36C1: 30 15           LEAX -$0B,X
36C3: 29 A1           BVS $3666
36C5: 14              ?????
36C6: 71              ?????
36C7: 3F              SWI1
36C8: A0 B0           SUBa [,Y+]
36CA: 17 F4 59        LBSR $2B26
36CD: 82 17           SBCa #$17
36CF: 45              ?????
36D0: 11 84           ?????
36D2: 39              RTS
36D3: 1D              SEX
36D4: 0E 1B           JMP $1B
36D6: 13              SYNC
36D7: 0D 18           TST $18
36D9: 04 16           LSR $16
36DB: C7              ?????
36DC: DE FB           LDU $FB
36DE: 17 F3 8C        LBSR $2A6D
36E1: 58              ASLb
36E2: 72              ?????
36E3: 56              RORb
36E4: 5E              ?????
36E5: D2 9C           SBCb $9C
36E7: 73 C6 73        COM $C673
36EA: 7B              ?????
36EB: 83 7A 5F        SUBd #$7A5F
36EE: BE 7F B1        LDX $7FB1
36F1: 3A              ABX
36F2: 1E 0E           EXG D,??
36F4: 1C 13           ANDCC #$13
36F6: 0D 19           TST $19
36F8: 04 0C           LSR $0C
36FA: C7              ?????
36FB: DE D3           LDU $D3
36FD: 14              ?????
36FE: E6 96           LDb [A,X]
3700: C2 16           SBCb #$16
3702: 83 61 5F        SUBd #$615F
3705: BE 11 04        LDX $1104
3708: 06 56           ROR $56
370A: D1 16           CMPb $16
370C: 71              ?????
370D: DB 72           ADDb $72
370F: 12              NOP 
3710: 84 0D           ANDa #$0D
3712: 34 0E           PSHS ,DP,B,A
3714: 32 0D           LEAS +$0D,X
3716: 2E 1A           BGT $3732
3718: 83 0E 2A        SUBd #$0E2A
371B: 0D 27           TST $27
371D: 0E 07           JMP $07
371F: 14              ?????
3720: 15              ?????
3721: 10 1B           ?????
3723: 14              ?????
3724: 15              ?????
3725: 40              NEGa
3726: 04 02           LSR $02
3728: 5F              CLRb
3729: BE 11 04        LDX $1104
372C: 14              ?????
372D: 07 4F           ASR $4F
372F: 17 98 CA        LBSR $CFFC
3732: B5 37 49        BITa $3749
3735: F5 8B D3        BITb $8BD3
3738: B8 B8 16        EORa $B816
373B: 91 64           CMPa $64
373D: 96 64           LDa $64
373F: DB 72           ADDb $72
3741: 12              NOP 
3742: 84 10           ANDa #$10
3744: 13              SYNC
3745: 14              ?????
3746: 0C 0E           INC $0E
3748: 39              RTS
3749: 0E 37           JMP $37
374B: 0D 1B           TST $1B
374D: 1B              ?????
374E: 14              ?????
374F: 15              ?????
3750: 10 04           ?????
3752: 02              ?????
3753: 5F              CLRb
3754: BE 12 04        LDX $1204
3757: 10 4B           ?????
3759: 7B              ?????
375A: 06 9A           ROR $9A
375C: 85 14           BITa #$14
375E: B2 53 90        SBCa $5390
3761: BE C9 6A        LDX $C96A
3764: 5E              ?????
3765: 79 5B BB        ROL $5BBB
3768: 13              SYNC
3769: 0D 17           TST $17
376B: 04 02           LSR $02
376D: 5F              CLRb
376E: BE 12 04        LDX $1204
3771: 10 60           ?????
3773: 7B              ?????
3774: F3 23 D5        ADDD $23D5
3777: 46              RORa
3778: EE 61           LDU +$01,S
377A: 91 7A           CMPa $7A
377C: BC 14 AF        CMPX $14AF
377F: 78 5B BB        LSL $5BBB
3782: 0F 19           CLR $19
3784: 0E 17           JMP $17
3786: 13              SYNC
3787: 0D 14           TST $14
3789: 04 02           LSR $02
378B: 5F              CLRb
378C: BE 11 04        LDX $1104
378F: 0B              ?????
3790: 40              NEGa
3791: D2 F3           SBCb $F3
3793: 23 16           BLS $37AB
3795: 67 D0           ASR [,U+]
3797: 15              ?????
3798: 82 17           SBCa #$17
379A: 45              ?????
379B: 12              NOP 
379C: 84 14           ANDa #$14
379E: 3B              RTI
379F: 0D 39           TST $39
37A1: 1B              ?????
37A2: 83 0E 35        SUBd #$0E35
37A5: 0D 18           TST $18
37A7: 1A 15           ORCC #$15
37A9: 08 0E           LSL $0E
37AB: 04 09           LSR $09
37AD: 12              NOP 
37AE: 09 14           ROL $14
37B0: 0E 0D           JMP $0D
37B2: 13              SYNC
37B3: 04 0A           LSR $0A
37B5: 73 7B 40        COM $7B40
37B8: D2 F3           SBCb $F3
37BA: 23 F4           BLS $37B0
37BC: 4F              CLRa
37BD: 1B              ?????
37BE: 9C 0D           CMPX $0D
37C0: 19              DAA
37C1: 04 0C           LSR $0C
37C3: C7              ?????
37C4: DE D3           LDU $D3
37C6: 14              ?????
37C7: E6 96           LDb [A,X]
37C9: BF 14 C3        STX $14C3
37CC: B2 5F BE        SBCa $5FBE
37CF: 11 04           ?????
37D1: 06 56           ROR $56
37D3: D1 16           CMPb $16
37D5: 71              ?????
37D6: DB 72           ADDb $72
37D8: 12              NOP 
37D9: 84 07           ANDa #$07
37DB: 1A 0D           ORCC #$0D
37DD: 18              ?????
37DE: 04 15           LSR $15
37E0: C7              ?????
37E1: DE 94           LDU $94
37E3: 14              ?????
37E4: 45              ?????
37E5: 5E              ?????
37E6: 3C 49           CWAI #49
37E8: D0 DD           SUBb $DD
37EA: D6 6A           LDb $6A
37EC: DB 72           ADDb $72
37EE: FE 67 89        LDU $6789
37F1: 8D 91           BSR $3784
37F3: 7A 3A 06        DEC $3A06
37F6: 04 02           LSR $02
37F8: 00 00           NEG $00
37FA: 00 84           NEG $84
37FC: 2C 81           BGE $377F
37FE: 63 0D           COM +$0D,X
3800: 61              ?????
3801: 1F 10           TFR X,D
3803: C7              ?????
3804: DE AF           LDU $AF
3806: 23 FF           BLS $3807
3808: 14              ?????
3809: 17 47 8C        LBSR $7F98
380C: 17 43 DB        LBSR $7BEA
380F: 0B              ?????
3810: 6C 1B           INC -$05,X
3812: 9C 95           CMPX $95
3814: 17 01 81        LBSR $3998
3817: 17 05 84        LBSR $3D9E
381A: 17 06 88        LBSR $3EA5
381D: 17 07 00        LBSR $3F20
3820: 17 08 8C        LBSR $40AF
3823: 17 09 A1        LBSR $41C7
3826: 17 0A 8E        LBSR $42B7
3829: 17 0C 95        LBSR $44C1
382C: 17 0E 91        LBSR $46C0
382F: 17 0F 00        LBSR $4732
3832: 17 11 92        LBSR $49C7
3835: 17 12 00        LBSR $4A38
3838: 17 14 A0        LBSR $4CDB
383B: 17 15 00        LBSR $4D3E
383E: 17 16 00        LBSR $4E41
3841: 17 18 9C        LBSR $50E0
3844: 17 1E 00        LBSR $5647
3847: 17 1F 00        LBSR $574A
384A: 17 22 8F        LBSR $5ADC
384D: 17 25 9C        LBSR $5DEC
3850: 17 26 00        LBSR $5E53
3853: 17 28 00        LBSR $6056
3856: 1C 15           ANDCC #$15
3858: 23 3C           BLS $3896
385A: 1C 1D           ANDCC #$1D
385C: 23 46           BLS $38A4
385E: 17 1D 96        LBSR $55F7
3861: 25 82           BCS $37E5
3863: 2C 0D           BGE $3872
3865: 2A 1F           BPL $3886
3867: 27 5F           BEQ $38C8
3869: BE 66 17        LDX $6617
386C: 8F              ?????
386D: 49              ROLa
386E: 54              LSRb
386F: 5E              ?????
3870: 3F              SWI1
3871: 61              ?????
3872: 57              ASRb
3873: 49              ROLa
3874: D6 B5           LDb $B5
3876: DB 72           ADDb $72
3878: 3C 49           CWAI #49
387A: 6B              ?????
387B: A1 23           CMPa +$03,Y
387D: D1 13           CMPb $13
387F: 54              LSRb
3880: F0 A4 8C        SUBb $A48C
3883: 62              ?????
3884: 7F 49 DB        CLR $49DB
3887: B5 34 A1        BITa $34A1
388A: 9F 15           STX $15
388C: 3E              RESET*
388D: 49              ROLa
388E: 2E 81           BGT $3811
3890: 83 66 0D        SUBd #$660D
3893: 64 0E           LSR +$0E,X
3895: 61              ?????
3896: 0D 08           TST $08
3898: 08 0E           LSL $0E
389A: 17 0E 00        LBSR $469D
389D: 1C 0F           ANDCC #$0F
389F: 0C 0D           INC $0D
38A1: 08 08           LSL $08
38A3: 25 17           BCS $38BC
38A5: 25 00           BCS $38A7
38A7: 1C 26           ANDCC #$26
38A9: 0C 0D           INC $0D
38AB: 1D              SEX
38AC: 15              ?????
38AD: 10 04           ?????
38AF: 0C 46           INC $46
38B1: 77 05 A0        ASR $05A0
38B4: 16 BC 90        LBRA $F547
38B7: 73 D6 83        COM $D683
38BA: DB 72           ADDb $72
38BC: 16 04 0A        LBRA $3CC9
38BF: 4E              ?????
38C0: D1 05           CMPb $05
38C2: 8A 42           ORa #$42
38C4: A0 2B           SUBa +$0B,Y
38C6: 62              ?????
38C7: FF BD 0D        STU $BD0D
38CA: 21 14           BRN $38E0
38CC: 15              ?????
38CD: 20 04           BRA $38D3
38CF: 1A C7           ORCC #$C7
38D1: DE 94           LDU $94
38D3: 14              ?????
38D4: 53              COMb
38D5: 5E              ?????
38D6: D6 C4           LDb $C4
38D8: 4B              ?????
38D9: 5E              ?????
38DA: 13              SYNC
38DB: 98 44           EORa $44
38DD: A4 DB           ANDa [D,U]
38DF: 8B C3           ADDa #$C3
38E1: 9E 6F           LDX $6F
38E3: B1 53 A1        CMPa $53A1
38E6: AB 98 5F        ADDa [+$5F,X]
38E9: BE 16 84        LDX $1684
38EC: 18              ?????
38ED: 0D 08           TST $08
38EF: 0F 16           CLR $16
38F1: 04 04           LSR $04
38F3: 4D              TSTa
38F4: BD A7 61        JSR $A761
38F7: 18              ?????
38F8: 84 04           ANDa #$04
38FA: 04 02           LSR $02
38FC: 3B              RTI
38FD: F4 85 29        ANDb $8529
3900: 1F 27           TFR Y,??
3902: 49              ROLa
3903: 45              ?????
3904: 07 B3           ASR $B3
3906: 11 A3 89 64 94  CMPU $6494,X
390B: C3 0B 5C        ADDd #$0B5C
390E: 94 91           ANDa $91
3910: 1F 54           TFR PC,S
3912: C3 B5 07        ADDd #$B507
3915: B3 33 98        SUBD $3398
3918: 5F              CLRb
3919: BE E1 14        LDX $E114
391C: CF              ?????
391D: B2 96 AF        SBCa $96AF
3920: DB 9C           ADDb $9C
3922: 34 A1           PSHS ,PC,Y,CC
3924: 33 17           LEAU -$09,X
3926: 2E 6D           BGT $3995
3928: 2E 87           BGT $38B1
392A: 2A 1F           BPL $394B
392C: 28 49           BVC $3977
392E: 45              ?????
392F: 07 B3           ASR $B3
3931: 11 A3 89 64 94  CMPU $6494,X
3936: C3 0B 5C        ADDd #$0B5C
3939: 95 5A           BITa $5A
393B: EA 48           ORb +$08,U
393D: 94 5F           ANDa $5F
393F: C3 B5 07        ADDd #$B507
3942: B3 33 98        SUBD $3398
3945: 5F              CLRb
3946: BE E1 14        LDX $E114
3949: CF              ?????
394A: B2 96 AF        SBCa $96AF
394D: DB 9C           ADDb $9C
394F: 34 A1           PSHS ,PC,Y,CC
3951: 3F              SWI1
3952: 16 D7 68        LBRA $10BD
3955: 86 1E           LDa #$1E
3957: 1F 1C           TFR X,??
3959: 49              ROLa
395A: 45              ?????
395B: 07 B3           ASR $B3
395D: 11 A3 89 64 94  CMPU $6494,X
3962: C3 0B 5C        ADDd #$0B5C
3965: 3F              SWI1
3966: 55              ?????
3967: 4B              ?????
3968: 62              ?????
3969: 39              RTS
396A: 49              ROLa
396B: 8E C5 82        LDX #$C582
396E: 17 45 5E        LBSR $7ECF
3971: B8 A0 47        EORa $A047
3974: 62              ?????
3975: 88 13           EORa #$13
3977: 0D 11           TST $11
3979: 04 02           LSR $02
397B: 5F              CLRb
397C: BE 12 04        LDX $1204
397F: 0A 4B           DEC $4B
3981: 7B              ?????
3982: 06 9A           ROR $9A
3984: BF 14 10        STX $1410
3987: B2 5B 70        SBCa $5B70
398A: 92 1C           SBCa $1C
398C: 1F 1A           TFR X,CC
398E: 36 A1           PSHU ,PC,Y,CC
3990: B8 16 7B        EORa $167B
3993: 14              ?????
3994: 85 A6           BITa #$A6
3996: 44              LSRa
3997: B8 DB 8B        EORa $DB8B
399A: 08 67           LSL $67
399C: 1E C1           EXG ??,X
399E: 51              ?????
399F: 18              ?????
39A0: 23 C6           BLS $3968
39A2: 61              ?????
39A3: B7 5B B1        STa $5BB1
39A6: 4B              ?????
39A7: 7B              ?????
39A8: 89 12           ADCa #$12
39AA: 1F 10           TFR X,D
39AC: C7              ?????
39AD: DE D3           LDU $D3
39AF: 14              ?????
39B0: E6 96           LDb [A,X]
39B2: FF 15 D3        STU $15D3
39B5: 93 5B           SUBd $5B
39B7: BE 08 BC        LDX $08BC
39BA: 21 49           BRN $3A05
39BC: 8A 32           ORa #$32
39BE: 0D 30           TST $30
39C0: 1F 2D           TFR Y,??
39C2: C7              ?????
39C3: DE 3B           LDU $3B
39C5: 16 33 98        LBRA $6D60
39C8: 03 A0           COM $A0
39CA: 55              ?????
39CB: 45              ?????
39CC: 8D A5           BSR $3973
39CE: 43              COMa
39CF: 5E              ?????
39D0: 16 BC DB        LBRA $F6AE
39D3: 72              ?????
39D4: 06 4F           ROR $4F
39D6: 7F BF B8        CLR $BFB8
39D9: 16 82 17        LBRA $BBF3
39DC: 52              ?????
39DD: 5E              ?????
39DE: 73 7B 23        COM $7B23
39E1: D1 13           CMPb $13
39E3: 54              LSRb
39E4: 5F              CLRb
39E5: BE 3F 17        LDX $3F17
39E8: C5 6A           BITb #$6A
39EA: 4F              CLRa
39EB: A1 66           CMPa +$06,S
39ED: B1 2E 81        CMPa $2E81
39F0: 8B 79           ADDa #$79
39F2: 0D 77           TST $77
39F4: 1F 74           TFR ??,S
39F6: C7              ?????
39F7: DE 2F           LDU $2F
39F9: 17 43 48        LBSR $7D44
39FC: 5B              ?????
39FD: E3 23           ADDD +$03,Y
39FF: D1 DB           CMPb $DB
3A01: 8B C7           ADDa #$C7
3A03: DE AF           LDU $AF
3A05: 23 4B           BLS $3A52
3A07: 15              ?????
3A08: 03 8D           COM $8D
3A0A: AB 98 5B        ADDa [+$5B,X]
3A0D: BE 16 BC        LDX $16BC
3A10: DB 72           ADDb $72
3A12: E9 B3           ADCb [,--Y]
3A14: E1 14           CMPb -$0C,X
3A16: 74 CA F3        LSR $CAF3
3A19: 5F              CLRb
3A1A: 52              ?????
3A1B: 45              ?????
3A1C: 97 7B           STa $7B
3A1E: 82 17           SBCa #$17
3A20: 44              LSRa
3A21: 5E              ?????
3A22: 0E A1           JMP $A1
3A24: DB 9F           ADDb $9F
3A26: C3 9E 5F        ADDd #$9E5F
3A29: BE E3 16        LDX $E316
3A2C: 0B              ?????
3A2D: BC C5 B5        CMPX $C5B5
3A30: 4F              CLRa
3A31: A1 66           CMPa +$06,S
3A33: B1 FB 17        CMPa $FB17
3A36: 53              COMb
3A37: BE 63 B9        LDX $63B9
3A3A: B5 85 84        BITa $8584
3A3D: 14              ?????
3A3E: 36 A1           PSHU ,PC,Y,CC
3A40: 59              ROLb
3A41: 15              ?????
3A42: 23 C6           BLS $3A0A
3A44: 67 66           ASR +$06,S
3A46: 16 BC 46        LBRA $F68F
3A49: 48              ASLa
3A4A: 8B 18           ADDa #$18
3A4C: C7              ?????
3A4D: DE 09           LDU $09
3A4F: 15              ?????
3A50: E6 96           LDb [A,X]
3A52: 9B 15           ADDa $15
3A54: 5B              ?????
3A55: CA 8F           ORb #$8F
3A57: BE 56 5E        LDX $565E
3A5A: CF              ?????
3A5B: 9C 95           CMPX $95
3A5D: 5F              CLRb
3A5E: 2F C6           BLE $3A26
3A60: 82 17           SBCa #$17
3A62: 5B              ?????
3A63: 61              ?????
3A64: 1B              ?????
3A65: 63 06           COM +$06,X
3A67: 56              RORb
3A68: DB E0           ADDb $E0
3A6A: 81 8C           CMPa #$8C
3A6C: 49              ROLa
3A6D: 1F 47           TFR S,??
3A6F: C7              ?????
3A70: DE 03           LDU $03
3A72: 15              ?????
3A73: 61              ?????
3A74: B7 74 CA        STa $74CA
3A77: 7B              ?????
3A78: 14              ?????
3A79: E7 59           STb -$07,U
3A7B: 06 A3           ROR $A3
3A7D: 35 49           PULS ,CC,DP,U
3A7F: E3 16           ADDD -$0A,X
3A81: 19              DAA
3A82: BC 85 73        CMPX $8573
3A85: 07 71           ASR $71
3A87: 3F              SWI1
3A88: D9 4D           ADCb $4D
3A8A: 98 5C           EORa $5C
3A8C: 15              ?????
3A8D: DB 9F           ADDb $9F
3A8F: 5F              CLRb
3A90: BE 99 16        LDX $9916
3A93: C2 B3           SBCb #$B3
3A95: 89 17           ADCa #$17
3A97: 82 17           SBCa #$17
3A99: 55              ?????
3A9A: 5E              ?????
3A9B: 36 A1           PSHU ,PC,Y,CC
3A9D: 19              DAA
3A9E: 71              ?????
3A9F: 46              RORa
3AA0: 48              ASLa
3AA1: 56              RORb
3AA2: F4 DB 72        ANDb $DB72
3AA5: 96 A5           LDa $A5
3AA7: D5 15           BITb $15
3AA9: 89 17           ADCa #$17
3AAB: C4 9C           ANDb #$9C
3AAD: F3 B2 16        ADDD $B216
3AB0: 58              ASLb
3AB1: CC 9C 72        LDD #$9C72
3AB4: C5 2E           BITb #$2E
3AB6: 8D 20           BSR $3AD8
3AB8: 04 1E           LSR $1E
3ABA: 5F              CLRb
3ABB: BE 66 17        LDX $6617
3ABE: 8F              ?????
3ABF: 49              ROLa
3AC0: 4B              ?????
3AC1: 5E              ?????
3AC2: CF              ?????
3AC3: B5 DA C3        BITa $DAC3
3AC6: 89 17           ADCa #$17
3AC8: CA 9C           ORb #$9C
3ACA: 98 5F           EORa $5F
3ACC: 48              ASLa
3ACD: DB A3           ADDb $A3
3ACF: A0 C7           SUBa ??
3AD1: DE 89           LDU $89
3AD3: 17 71 16        LBSR $ABEC
3AD6: 7F CA 8E        CLR $CA8E
3AD9: 3E              RESET*
3ADA: 04 3C           LSR $3C
3ADC: 7A C4 D9        DEC $C4D9
3ADF: 06 82           ROR $82
3AE1: 7B              ?????
3AE2: 84 15           ANDa #$15
3AE4: 96 5F           LDa $5F
3AE6: 03 15           COM $15
3AE8: 93 66           SUBd $66
3AEA: 2E 56           BGT $3B42
3AEC: FB C0 C7        ADDb $C0C7
3AEF: DE 63           LDU $63
3AF1: 16 C9 97        LBRA $048B
3AF4: 56              RORb
3AF5: 5E              ?????
3AF6: CF              ?????
3AF7: 9C 4F           CMPX $4F
3AF9: A1 82           CMPa ,-X
3AFB: 17 43 5E        LBSR $7E5C
3AFE: 3B              RTI
3AFF: 8E 83 AF        LDX #$83AF
3B02: 33 98 C7        LEAU [-$39,X]
3B05: DE 03           LDU $03
3B07: 15              ?????
3B08: 61              ?????
3B09: B7 74 CA        STa $74CA
3B0C: 7B              ?????
3B0D: 14              ?????
3B0E: A5 B7           BITa ??
3B10: 76 B1 DB        ROR $B1DB
3B13: 16 D3 B9        LBRA $0ECF
3B16: BF 6C 8F        STX $6C8F
3B19: 07 0D           ASR $0D
3B1B: 05              ?????
3B1C: 08 2B           LSL $2B
3B1E: 00 A5           NEG $A5
3B20: 90 90           SUBa $90
3B22: 22 1F           BHI $3B43
3B24: 20 5F           BRA $3B85
3B26: BE 8E 14        LDX $8E14
3B29: 54              LSRb
3B2A: BD 71 16        JSR $7116
3B2D: 75              ?????
3B2E: CA AB           ORb #$AB
3B30: 14              ?????
3B31: 8B 54           ADDa #$54
3B33: 6B              ?????
3B34: BF A3 B7        STX $A3B7
3B37: 16 8A DB        LBRA $C615
3B3A: 72              ?????
3B3B: 7E 74 43        JMP $7443
3B3E: 5E              ?????
3B3F: 08 4F           LSL $4F
3B41: 5B              ?????
3B42: 5E              ?????
3B43: 3F              SWI1
3B44: A1 91           CMPa [,X++]
3B46: 37 0D           PULU ,CC,B,DP
3B48: 35 1F           PULS ,CC,A,B,DP,X
3B4A: 30 4B           LEAX +$0B,U
3B4C: 49              ROLa
3B4D: C7              ?????
3B4E: DE DE           LDU $DE
3B50: 14              ?????
3B51: 64 7A           LSR -$06,S
3B53: C7              ?????
3B54: 16 11 BC        LBRA $4D13
3B57: 96 64           LDa $64
3B59: DB 72           ADDb $72
3B5B: 7E 74 B3        JMP $74B3
3B5E: 63 73           COM -$0D,S
3B60: 7B              ?????
3B61: A7 B7           STa ??
3B63: 4B              ?????
3B64: 94 6B           ANDa $6B
3B66: BF 89 91        STX $8991
3B69: D3 78           ADDD $78
3B6B: 13              SYNC
3B6C: 8D 57           BSR $3BC5
3B6E: 17 33 48        LBSR $6EB9
3B71: D3 C5           ADDD $C5
3B73: 6A 4D           DEC +$0D,U
3B75: 8E 7A 51        LDX #$7A51
3B78: 18              ?????
3B79: DB C7           ADDb $C7
3B7B: 00 9F           NEG $9F
3B7D: 95 93           BITa $93
3B7F: 09 0B           ROL $0B
3B81: 07 0A           ASR $0A
3B83: 36 01           PSHU ,CC
3B85: 94 37           ANDa $37
3B87: 01              ?????
3B88: 94 94           ANDa $94
3B8A: 19              DAA
3B8B: 1F 17           TFR X,??
3B8D: FF A5 57        STU $A557
3B90: 49              ROLa
3B91: B5 17 46        BITa $1746
3B94: 5E              ?????
3B95: 2F 7B           BLE $3C12
3B97: 03 56           COM $56
3B99: 1D              SEX
3B9A: A0 A6           SUBa A,Y
3B9C: 16 3F BB        LBRA $7B5A
3B9F: 11 EE           ?????
3BA1: 99 AF           ADCa $AF
3BA3: 2E 95           BGT $3B3A
3BA5: 26 0D           BNE $3BB4
3BA7: 24 17           BCC $3BC0
3BA9: 36 FF           PSHU ,PC,S,Y,X,DP,B,A,CC
3BAB: 17 29 00        LBSR $64AE
3BAE: 17 2A 00        LBSR $65B1
3BB1: 17 2B 00        LBSR $66B4
3BB4: 17 2C 00        LBSR $67B7
3BB7: 17 2D 00        LBSR $68BA
3BBA: 17 2E 00        LBSR $69BD
3BBD: 17 31 00        LBSR $6CC0
3BC0: 17 34 00        LBSR $6FC3
3BC3: 17 35 00        LBSR $70C6
3BC6: 17 3A 00        LBSR $75C9
3BC9: 17 3C 1D        LBSR $77E9
3BCC: 96 1A           LDa $1A
3BCE: 04 18           LSR $18
3BD0: 5B              ?????
3BD1: BE 65 BC        LDX $65BC
3BD4: 7B              ?????
3BD5: 14              ?????
3BD6: 41              ?????
3BD7: 6E 19           JMP -$07,X
3BD9: 58              ASLb
3BDA: 3B              RTI
3BDB: 4A              DECa
3BDC: 6B              ?????
3BDD: BF 85 8D        STX $858D
3BE0: 5B              ?????
3BE1: 5E              ?????
3BE2: 34 A1           PSHS ,PC,Y,CC
3BE4: 9B 15           ADDa $15
3BE6: 31 98 97        LEAY [-$69,X]
3BE9: 19              DAA
3BEA: 04 17           LSR $17
3BEC: 43              COMa
3BED: 79 C7 DE        ROL $C7DE
3BF0: D3 14           ADDD $14
3BF2: 88 96           EORa #$96
3BF4: 8E 7A 7B        LDX #$7A7B
3BF7: 14              ?????
3BF8: C7              ?????
3BF9: 93 76           SUBd $76
3BFB: BE BD 15        LDX $BD15
3BFE: 49              ROLa
3BFF: 90 67           SUBa $67
3C01: 48              ASLa
3C02: 21 98           BRN $3B9C
3C04: 24 04           BCC $3C0A
3C06: 22 0F           BHI $3C17
3C08: A0 5F           SUBa -$01,U
3C0A: 17 46 48        LBSR $8255
3C0D: 66 17           ROR -$09,X
3C0F: D3 61           ADDD $61
3C11: 04 68           LSR $68
3C13: 63 16           COM -$0A,X
3C15: 5B              ?????
3C16: 99 56           ADCa $56
3C18: 98 C0           EORa $C0
3C1A: 16 49 5E        LBRA $857B
3C1D: 90 78           SUBa $78
3C1F: 0E BC           JMP $BC
3C21: 92 5F           SBCa $5F
3C23: 59              ROLb
3C24: 15              ?????
3C25: 9B AF           ADDa $AF
3C27: 19              DAA
3C28: A1 00           CMPa +$00,X
3C2A: 04 52           LSR $52
3C2C: 45              ?????
3C2D: 41              ?????
3C2E: 44              LSRa
3C2F: 01              ?????
3C30: 03 47           COM $47
3C32: 45              ?????
3C33: 54              LSRb
3C34: 09 05           ROL $05
3C36: 54              LSRb
3C37: 48              ASLa
3C38: 52              ?????
3C39: 4F              CLRa
3C3A: 57              ASRb
3C3B: 03 06           COM $06
3C3D: 41              ?????
3C3E: 54              LSRb
3C3F: 54              LSRb
3C40: 41              ?????
3C41: 43              COMa
3C42: 4B              ?????
3C43: 04 04           LSR $04
3C45: 4B              ?????
3C46: 49              ROLa
3C47: 4C              INCa
3C48: 4C              INCa
3C49: 04 03           LSR $03
3C4B: 48              ASLa
3C4C: 49              ROLa
3C4D: 54              LSRb
3C4E: 04 05           LSR $05
3C50: 4E              ?????
3C51: 4F              CLRa
3C52: 52              ?????
3C53: 54              LSRb
3C54: 48              ASLa
3C55: 05              ?????
3C56: 01              ?????
3C57: 4E              ?????
3C58: 05              ?????
3C59: 05              ?????
3C5A: 53              COMb
3C5B: 4F              CLRa
3C5C: 55              ?????
3C5D: 54              LSRb
3C5E: 48              ASLa
3C5F: 06 01           ROR $01
3C61: 53              COMb
3C62: 06 04           ROR $04
3C64: 45              ?????
3C65: 41              ?????
3C66: 53              COMb
3C67: 54              LSRb
3C68: 07 01           ASR $01
3C6A: 45              ?????
3C6B: 07 04           ASR $04
3C6D: 57              ASRb
3C6E: 45              ?????
3C6F: 53              COMb
3C70: 54              LSRb
3C71: 08 01           LSL $01
3C73: 57              ASRb
3C74: 08 04           LSL $04
3C76: 54              LSRb
3C77: 41              ?????
3C78: 4B              ?????
3C79: 45              ?????
3C7A: 09 04           ROL $04
3C7C: 44              LSRa
3C7D: 52              ?????
3C7E: 4F              CLRa
3C7F: 50              NEGb
3C80: 0A 03           DEC $03
3C82: 50              NEGb
3C83: 55              ?????
3C84: 54              LSRb
3C85: 0A 06           DEC $06
3C87: 49              ROLa
3C88: 4E              ?????
3C89: 56              RORb
3C8A: 45              ?????
3C8B: 4E              ?????
3C8C: 54              LSRb
3C8D: 0B              ?????
3C8E: 04 4C           LSR $4C
3C90: 4F              CLRa
3C91: 4F              CLRa
3C92: 4B              ?????
3C93: 0C 04           INC $04
3C95: 47              ASRa
3C96: 49              ROLa
3C97: 56              RORb
3C98: 45              ?????
3C99: 0D 05           TST $05
3C9B: 4F              CLRa
3C9C: 46              RORa
3C9D: 46              RORa
3C9E: 45              ?????
3C9F: 52              ?????
3CA0: 0D 06           TST $06
3CA2: 45              ?????
3CA3: 58              ASLb
3CA4: 41              ?????
3CA5: 4D              TSTa
3CA6: 49              ROLa
3CA7: 4E              ?????
3CA8: 0E 06           JMP $06
3CAA: 53              COMb
3CAB: 45              ?????
3CAC: 41              ?????
3CAD: 52              ?????
3CAE: 43              COMa
3CAF: 48              ASLa
3CB0: 0E 04           JMP $04
3CB2: 4F              CLRa
3CB3: 50              NEGb
3CB4: 45              ?????
3CB5: 4E              ?????
3CB6: 0F 04           CLR $04
3CB8: 50              NEGb
3CB9: 55              ?????
3CBA: 4C              INCa
3CBB: 4C              INCa
3CBC: 10 05           ?????
3CBE: 4C              INCa
3CBF: 49              ROLa
3CC0: 47              ASRa
3CC1: 48              ASLa
3CC2: 54              LSRb
3CC3: 11 04           ?????
3CC5: 42              ?????
3CC6: 55              ?????
3CC7: 52              ?????
3CC8: 4E              ?????
3CC9: 11 03           ?????
3CCB: 45              ?????
3CCC: 41              ?????
3CCD: 54              LSRb
3CCE: 12              NOP 
3CCF: 05              ?????
3CD0: 54              LSRb
3CD1: 41              ?????
3CD2: 53              COMb
3CD3: 54              LSRb
3CD4: 45              ?????
3CD5: 12              NOP 
3CD6: 04 42           LSR $42
3CD8: 4C              INCa
3CD9: 4F              CLRa
3CDA: 57              ASRb
3CDB: 13              SYNC
3CDC: 06 45           ROR $45
3CDE: 58              ASLb
3CDF: 54              LSRb
3CE0: 49              ROLa
3CE1: 4E              ?????
3CE2: 47              ASRa
3CE3: 14              ?????
3CE4: 05              ?????
3CE5: 43              COMa
3CE6: 4C              INCa
3CE7: 49              ROLa
3CE8: 4D              TSTa
3CE9: 42              ?????
3CEA: 15              ?????
3CEB: 03 52           COM $52
3CED: 55              ?????
3CEE: 42              ?????
3CEF: 16 04 57        LBRA $4149
3CF2: 49              ROLa
3CF3: 50              NEGb
3CF4: 45              ?????
3CF5: 16 06 50        LBRA $4348
3CF8: 4F              CLRa
3CF9: 4C              INCa
3CFA: 49              ROLa
3CFB: 53              COMb
3CFC: 48              ASLa
3CFD: 16 04 4C        LBRA $414C
3D00: 49              ROLa
3D01: 46              RORa
3D02: 54              LSRb
3D03: 1C 04           ANDCC #$04
3D05: 57              ASRb
3D06: 41              ?????
3D07: 49              ROLa
3D08: 54              LSRb
3D09: 1F 04           TFR D,S
3D0B: 53              COMb
3D0C: 54              LSRb
3D0D: 41              ?????
3D0E: 59              ROLb
3D0F: 1F 04           TFR D,S
3D11: 4A              DECa
3D12: 55              ?????
3D13: 4D              TSTa
3D14: 50              NEGb
3D15: 20 02           BRA $3D19
3D17: 47              ASRa
3D18: 4F              CLRa
3D19: 21 03           BRN $3D1E
3D1B: 52              ?????
3D1C: 55              ?????
3D1D: 4E              ?????
3D1E: 21 05           BRN $3D25
3D20: 45              ?????
3D21: 4E              ?????
3D22: 54              LSRb
3D23: 45              ?????
3D24: 52              ?????
3D25: 21 04           BRN $3D2B
3D27: 50              NEGb
3D28: 55              ?????
3D29: 53              COMb
3D2A: 48              ASLa
3D2B: 10 04           ?????
3D2D: 4D              TSTa
3D2E: 4F              CLRa
3D2F: 56              RORb
3D30: 45              ?????
3D31: 10 04           ?????
3D33: 4B              ?????
3D34: 49              ROLa
3D35: 43              COMa
3D36: 4B              ?????
3D37: 23 04           BLS $3D3D
3D39: 46              RORa
3D3A: 45              ?????
3D3B: 45              ?????
3D3C: 44              LSRa
3D3D: 24 05           BCC $3D44
3D3F: 53              COMb
3D40: 43              COMa
3D41: 4F              CLRa
3D42: 52              ?????
3D43: 45              ?????
3D44: 28 06           BVC $3D4C
3D46: 53              COMb
3D47: 43              COMa
3D48: 52              ?????
3D49: 45              ?????
3D4A: 41              ?????
3D4B: 4D              TSTa
3D4C: 2B 04           BMI $3D52
3D4E: 59              ROLb
3D4F: 45              ?????
3D50: 4C              INCa
3D51: 4C              INCa
3D52: 2B 04           BMI $3D58
3D54: 51              ?????
3D55: 55              ?????
3D56: 49              ROLa
3D57: 54              LSRb
3D58: 2D 04           BLT $3D5E
3D5A: 53              COMb
3D5B: 54              LSRb
3D5C: 4F              CLRa
3D5D: 50              NEGb
3D5E: 2D 05           BLT $3D65
3D60: 50              NEGb
3D61: 4C              INCa
3D62: 55              ?????
3D63: 47              ASRa
3D64: 48              ASLa
3D65: 32 05           LEAS +$05,X
3D67: 4C              INCa
3D68: 45              ?????
3D69: 41              ?????
3D6A: 56              RORb
3D6B: 45              ?????
3D6C: 2C 04           BGE $3D72
3D6E: 50              NEGb
3D6F: 49              ROLa
3D70: 43              COMa
3D71: 4B              ?????
3D72: 34 00           PSHS ??
3D74: 06 50           ROR $50
3D76: 4F              CLRa
3D77: 54              LSRb
3D78: 49              ROLa
3D79: 4F              CLRa
3D7A: 4E              ?????
3D7B: 03 03           COM $03
3D7D: 52              ?????
3D7E: 55              ?????
3D7F: 47              ASRa
3D80: 06 04           ROR $04
3D82: 44              LSRa
3D83: 4F              CLRa
3D84: 4F              CLRa
3D85: 52              ?????
3D86: 09 04           ROL $04
3D88: 46              RORa
3D89: 4F              CLRa
3D8A: 4F              CLRa
3D8B: 44              LSRa
3D8C: 0C 06           INC $06
3D8E: 53              COMb
3D8F: 54              LSRb
3D90: 41              ?????
3D91: 54              LSRb
3D92: 55              ?????
3D93: 45              ?????
3D94: 0D 05           TST $05
3D96: 53              COMb
3D97: 57              ASRb
3D98: 4F              CLRa
3D99: 52              ?????
3D9A: 44              LSRa
3D9B: 0E 06           JMP $06
3D9D: 47              ASRa
3D9E: 41              ?????
3D9F: 52              ?????
3DA0: 47              ASRa
3DA1: 4F              CLRa
3DA2: 59              ROLb
3DA3: 0F 04           CLR $04
3DA5: 52              ?????
3DA6: 49              ROLa
3DA7: 4E              ?????
3DA8: 47              ASRa
3DA9: 12              NOP 
3DAA: 03 47           COM $47
3DAC: 45              ?????
3DAD: 4D              TSTa
3DAE: 13              SYNC
3DAF: 05              ?????
3DB0: 4C              INCa
3DB1: 45              ?????
3DB2: 56              RORb
3DB3: 45              ?????
3DB4: 52              ?????
3DB5: 16 06 50        LBRA $4408
3DB8: 4C              INCa
3DB9: 41              ?????
3DBA: 51              ?????
3DBB: 55              ?????
3DBC: 45              ?????
3DBD: 18              ?????
3DBE: 05              ?????
3DBF: 52              ?????
3DC0: 55              ?????
3DC1: 4E              ?????
3DC2: 45              ?????
3DC3: 53              COMb
3DC4: 18              ?????
3DC5: 04 53           LSR $53
3DC7: 49              ROLa
3DC8: 47              ASRa
3DC9: 4E              ?????
3DCA: 18              ?????
3DCB: 06 4D           ROR $4D
3DCD: 45              ?????
3DCE: 53              COMb
3DCF: 53              COMb
3DD0: 41              ?????
3DD1: 47              ASRa
3DD2: 18              ?????
3DD3: 06 43           ROR $43
3DD5: 41              ?????
3DD6: 4E              ?????
3DD7: 44              LSRa
3DD8: 4C              INCa
3DD9: 45              ?????
3DDA: 19              DAA
3DDB: 04 4C           LSR $4C
3DDD: 41              ?????
3DDE: 4D              TSTa
3DDF: 50              NEGb
3DE0: 1B              ?????
3DE1: 06 43           ROR $43
3DE3: 48              ASLa
3DE4: 4F              CLRa
3DE5: 50              NEGb
3DE6: 53              COMb
3DE7: 54              LSRb
3DE8: 1E 04           EXG D,S
3DEA: 48              ASLa
3DEB: 41              ?????
3DEC: 4E              ?????
3DED: 44              LSRa
3DEE: 1F 05           TFR D,PC
3DF0: 48              ASLa
3DF1: 41              ?????
3DF2: 4E              ?????
3DF3: 44              LSRa
3DF4: 53              COMb
3DF5: 1F 04           TFR D,S
3DF7: 43              COMa
3DF8: 4F              CLRa
3DF9: 49              ROLa
3DFA: 4E              ?????
3DFB: 20 04           BRA $3E01
3DFD: 53              COMb
3DFE: 4C              INCa
3DFF: 4F              CLRa
3E00: 54              LSRb
3E01: 21 05           BRN $3E08
3E03: 41              ?????
3E04: 4C              INCa
3E05: 54              LSRb
3E06: 41              ?????
3E07: 52              ?????
3E08: 22 04           BHI $3E0E
3E0A: 49              ROLa
3E0B: 44              LSRa
3E0C: 4F              CLRa
3E0D: 4C              INCa
3E0E: 23 06           BLS $3E16
3E10: 53              COMb
3E11: 45              ?????
3E12: 52              ?????
3E13: 50              NEGb
3E14: 45              ?????
3E15: 4E              ?????
3E16: 24 05           BCC $3E1D
3E18: 53              COMb
3E19: 4E              ?????
3E1A: 41              ?????
3E1B: 4B              ?????
3E1C: 45              ?????
3E1D: 24 04           BCC $3E23
3E1F: 57              ASRb
3E20: 41              ?????
3E21: 4C              INCa
3E22: 4C              INCa
3E23: 25 05           BCS $3E2A
3E25: 57              ASRb
3E26: 41              ?????
3E27: 4C              INCa
3E28: 4C              INCa
3E29: 53              COMb
3E2A: 25 04           BCS $3E30
3E2C: 56              RORb
3E2D: 49              ROLa
3E2E: 4E              ?????
3E2F: 45              ?????
3E30: 26 05           BNE $3E37
3E32: 56              RORb
3E33: 49              ROLa
3E34: 4E              ?????
3E35: 45              ?????
3E36: 53              COMb
3E37: 26 04           BNE $3E3D
3E39: 47              ASRa
3E3A: 41              ?????
3E3B: 54              LSRb
3E3C: 45              ?????
3E3D: 27 05           BEQ $3E44
3E3F: 47              ASRa
3E40: 41              ?????
3E41: 54              LSRb
3E42: 45              ?????
3E43: 53              COMb
3E44: 27 05           BEQ $3E4B
3E46: 47              ASRa
3E47: 55              ?????
3E48: 41              ?????
3E49: 52              ?????
3E4A: 44              LSRa
3E4B: 28 06           BVC $3E53
3E4D: 47              ASRa
3E4E: 55              ?????
3E4F: 41              ?????
3E50: 52              ?????
3E51: 44              LSRa
3E52: 53              COMb
3E53: 28 04           BVC $3E59
3E55: 52              ?????
3E56: 4F              CLRa
3E57: 4F              CLRa
3E58: 4D              TSTa
3E59: 2A 05           BPL $3E60
3E5B: 46              RORa
3E5C: 4C              INCa
3E5D: 4F              CLRa
3E5E: 4F              CLRa
3E5F: 52              ?????
3E60: 2B 04           BMI $3E66
3E62: 45              ?????
3E63: 58              ASLb
3E64: 49              ROLa
3E65: 54              LSRb
3E66: 2C 06           BGE $3E6E
3E68: 50              NEGb
3E69: 41              ?????
3E6A: 53              COMb
3E6B: 53              COMb
3E6C: 41              ?????
3E6D: 47              ASRa
3E6E: 2D 04           BLT $3E74
3E70: 48              ASLa
3E71: 4F              CLRa
3E72: 4C              INCa
3E73: 45              ?????
3E74: 2E 06           BGT $3E7C
3E76: 43              COMa
3E77: 4F              CLRa
3E78: 52              ?????
3E79: 52              ?????
3E7A: 49              ROLa
3E7B: 44              LSRa
3E7C: 2F 03           BLE $3E81
3E7E: 42              ?????
3E7F: 4F              CLRa
3E80: 57              ASRb
3E81: 31 05           LEAY +$05,X
3E83: 41              ?????
3E84: 52              ?????
3E85: 52              ?????
3E86: 4F              CLRa
3E87: 57              ASRb
3E88: 32 06           LEAS +$06,X
3E8A: 48              ASLa
3E8B: 41              ?????
3E8C: 4C              INCa
3E8D: 4C              INCa
3E8E: 57              ASRb
3E8F: 41              ?????
3E90: 33 06           LEAU +$06,X
3E92: 43              COMa
3E93: 48              ASLa
3E94: 41              ?????
3E95: 4D              TSTa
3E96: 42              ?????
3E97: 45              ?????
3E98: 34 05           PSHS ,B,CC
3E9A: 56              RORb
3E9B: 41              ?????
3E9C: 55              ?????
3E9D: 4C              INCa
3E9E: 54              LSRb
3E9F: 35 06           PULS ,A,B
3EA1: 45              ?????
3EA2: 4E              ?????
3EA3: 54              LSRb
3EA4: 52              ?????
3EA5: 41              ?????
3EA6: 4E              ?????
3EA7: 36 06           PSHU ,B,A
3EA9: 54              LSRb
3EAA: 55              ?????
3EAB: 4E              ?????
3EAC: 4E              ?????
3EAD: 45              ?????
3EAE: 4C              INCa
3EAF: 37 06           PULU ,A,B
3EB1: 4A              DECa
3EB2: 55              ?????
3EB3: 4E              ?????
3EB4: 47              ASRa
3EB5: 4C              INCa
3EB6: 45              ?????
3EB7: 38              ?????
3EB8: 06 54           ROR $54
3EBA: 45              ?????
3EBB: 4D              TSTa
3EBC: 50              NEGb
3EBD: 4C              INCa
3EBE: 45              ?????
3EBF: 39              RTS
3EC0: 03 50           COM $50
3EC2: 49              ROLa
3EC3: 54              LSRb
3EC4: 3A              ABX
3EC5: 06 43           ROR $43
3EC7: 45              ?????
3EC8: 49              ROLa
3EC9: 4C              INCa
3ECA: 49              ROLa
3ECB: 4E              ?????
3ECC: 3B              RTI
3ECD: 00 00           NEG $00
3ECF: 02              ?????
3ED0: 54              LSRb
3ED1: 4F              CLRa
3ED2: 01              ?????
3ED3: 04 57           LSR $57
3ED5: 49              ROLa
3ED6: 54              LSRb
3ED7: 48              ASLa
3ED8: 02              ?????
3ED9: 02              ?????
3EDA: 41              ?????
3EDB: 54              LSRb
3EDC: 03 05           COM $05
3EDE: 55              ?????
3EDF: 4E              ?????
3EE0: 44              LSRa
3EE1: 45              ?????
3EE2: 52              ?????
3EE3: 04 02           LSR $02
3EE5: 49              ROLa
3EE6: 4E              ?????
3EE7: 05              ?????
3EE8: 04 49           LSR $49
3EEA: 4E              ?????
3EEB: 54              LSRb
3EEC: 4F              CLRa
3EED: 05              ?????
3EEE: 03 4F           COM $4F
3EF0: 55              ?????
3EF1: 54              LSRb
3EF2: 06 02           ROR $02
3EF4: 55              ?????
3EF5: 50              NEGb
3EF6: 07 04           ASR $04
3EF8: 44              LSRa
3EF9: 4F              CLRa
3EFA: 57              ASRb
3EFB: 4E              ?????
3EFC: 08 04           LSL $04
3EFE: 4F              CLRa
3EFF: 56              RORb
3F00: 45              ?????
3F01: 52              ?????
3F02: 09 06           ROL $06
3F04: 42              ?????
3F05: 45              ?????
3F06: 48              ASLa
3F07: 49              ROLa
3F08: 4E              ?????
3F09: 44              LSRa
3F0A: 0A 06           DEC $06
3F0C: 41              ?????
3F0D: 52              ?????
3F0E: 4F              CLRa
3F0F: 55              ?????
3F10: 4E              ?????
3F11: 44              LSRa
3F12: 0B              ?????
3F13: 02              ?????
3F14: 4F              CLRa
3F15: 4E              ?????
3F16: 0C 00           INC $00
3F18: 03 CE           COM $CE
3F1A: 80 01           SUBa #$01
3F1C: 03 00           COM $00
3F1E: 00 40           NEG $40
3F20: FF 00 00        STU $0000
