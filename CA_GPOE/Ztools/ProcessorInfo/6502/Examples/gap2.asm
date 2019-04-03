 ;@ 1
; DoubleGap by Christopher Cantrell 2005 ;@ 2
; ccantrell@knology.net ;@ 3
 ;@ 4
; TO DO ;@ 5
; - Expert switches are backwards ;@ 6
; - Debounce switches ;@ 7
 ;@ 8
; This file uses the "FLOW" program for assembly pre-processing ;@ 9
; - processor 6502
 ;@ 11
#include "Stella.asm" ; Equates to give names to hardware memory locations ;@ 12
 ;@ 13
;<EditorTab name="RAM"> ;@ 14
; ====================================== ;@ 15
; ;@ 16
; RAM usage ;@ 17
; ;@ 18
TMP0      .EQU   $80 ; Temporary storage ;@ 19
TMP1      .EQU   $81 ; Temporary storage ;@ 20
TMP2      .EQU   $82 ; Temporary storage ;@ 21
PLAYR0Y   .EQU   $83 ; Player 0's Y location (normal or pro) ;@ 22
PLAYR1Y   .EQU   $84 ; Player 1's Y location (normal, pro, or off) ;@ 23
MUS_TMP0  .EQU   $85 ; Game-over mode sound FX storage (frame delay) ;@ 24
MUS_TMP1  .EQU   $86 ; Game-over mode sound FX storage (frequency) ;@ 25
SCANCNT   .EQU   $87 ; Scanline counter during screen drawing ;@ 26
MODE      .EQU   $88 ; Game mode: 0=GameOver 1=Play 2=Select ;@ 27
WALL_INC  .EQU   $89 ; How much to add to wall's Y position ;@ 28
WALLCNT   .EQU   $8A ; Number of walls passed (score) ;@ 29
WALLDELY  .EQU   $8B ; Wall movement frame skip counter ;@ 30
WALLDELYR .EQU   $8C ; Number of frames to skip between wall increments ;@ 31
ENTROPYA  .EQU   $8D ; Incremeneted with every frame ;@ 32
ENTROPYB  .EQU   $8E ; SWCHA adds in ;@ 33
ENTROPYC  .EQU   $8F ; Left/Right movements added to other entropies ;@ 34
DEBOUNCE  .EQU   $90 ; Last state of the Reset/Select switches ;@ 35
WALLDRELA .EQU   $91 ; PF0 pattern for wall ;@ 36
WALLDRELB .EQU   $92 ; PF1 pattern for wall ;@ 37
WALLDRELC .EQU   $93 ; PF2 pattern for wall ;@ 38
WALLSTART .EQU   $94 ; Wall's Y position (scanline) ;@ 39
WALLHEI   .EQU   $95 ; Height of wall ;@ 40
GAPBITS   .EQU   $96 ; Wall's gap pattern (used to make WALLDRELx) ;@ 41
SCORE_PF1 .EQU   $97 ; 6-bytes. PF1 pattern for each row of the score ;@ 42
SCORE_PF2 .EQU   $9D ; 6-bytes. PF2 pattern for each row of the score ;@ 43
MUSADEL   .EQU   $A3 ; Music A delay count ;@ 44
MUSAIND   .EQU   $A4 ; Music A pointer ;@ 45
MUSAVOL   .EQU   $A5 ; Music A volume ;@ 46
MUSBDEL   .EQU   $A6 ; Music B delay count ;@ 47
MUSBIND   .EQU   $A7 ; Music B pointer ;@ 48
MUSBVOL   .EQU   $A8 ; Music B volume ;@ 49
 ;@ 50
; Remember, stack builds down from $FF ... leave some space ;@ 51
; ;@ 52
; 80 - A8 ... that's 41 bytes of RAM ;@ 53
;</EditorTab> ;@ 54
 ;@ 55
  .org $F000 ;@ 56
 ;@ 57
;<EditorTab name="main"> ;@ 58
main:
  SEI        ; Turn off interrupts ;@ 60
  CLD        ; Clear the "decimal" flag ;@ 61
  LDX  #$FF  ; Start stack ... ;@ 62
  TXS        ; ... at end of RAM ;@ 63
   ;@ 64
  JSR INIT
  JSR INIT_SELMODE
  JSR VIDEO_KERNEL
  RTS
;</EditorTab> ;@ 69
   ;@ 70
;<EditorTab name="kernel"> ;@ 71
VIDEO_KERNEL:
;  (start here at the END of every frame) ;@ 73
; ;@ 74
FLOW_gap_3_1_INPUT:
 ;@ 76
      LDA  #$02      ; D1 bit ON ;@ 77
      STA  WSYNC     ; Wait for the end of the current line ;@ 78
      STA  VBLANK    ; Turn the electron beam off ;@ 79
      STA  WSYNC     ; Wait for all ... ;@ 80
      STA  WSYNC     ; ... the electrons ... ;@ 81
      STA  WSYNC     ; ... to drain out. ;@ 82
      STA  VSYNC     ; Trigger the vertical sync signal ;@ 83
      STA  WSYNC     ; Hold the vsync signal for ... ;@ 84
      STA  WSYNC     ; ... three ... ;@ 85
      STA  WSYNC     ; ... scanlines ;@ 86
      STA  HMOVE     ; Move all moving game objects ;@ 87
      LDA  #$00      ; D1 bit OFF ;@ 88
      STA  VSYNC     ; Release the vertical sync signal ;@ 89
      LDA  #43       ; Set timer to 43*64 = 2752 machine ... ;@ 90
      STA  TIM64T    ; ... cycles 2752/(228/3) = 36 scanlines ;@ 91
 ;@ 92
      ; ***** LENGTHY GAME LOGIC PROCESSING BEGINS HERE ***** ;@ 93
 ;@ 94
      ; Do one of 3 routines ;@ 95
      ; 0 = Game Over processing ;@ 96
      ; 1 = Playing-Game processing ;@ 97
      ; 2 = Selecting-Game processing ;@ 98
 ;@ 99
      INC  ENTROPYA  ; Counting video frames as part of random number ;@ 100
 ;@ 101
      LDA  MODE      ; What are we doing between frames? ;@ 102
 ;@ 103
  CMP   #0
  BEQ FLOW_gap_4_OUTPUT_TRUE
  CMP   #1
  BEQ FLOW_gap_5_OUTPUT_TRUE
  JSR SELMODE
  JMP  FLOW_gap_4_OUTPUT_END; CLEAN-JumpToJump     JMP  FLOW_gap_5_OUTPUT_END
FLOW_gap_5_OUTPUT_TRUE:
  JSR PLAYMODE
    JMP  FLOW_gap_4_OUTPUT_END
FLOW_gap_4_OUTPUT_TRUE:
  JSR GOMODE
FLOW_gap_4_OUTPUT_END:
       ;@ 111
      ; ***** LENGTHY GAME LOGIC PROCESSING ENDS HERE ***** ;@ 112
 ;@ 113
FLOW_gap_6_OUTPUT_TRUE:
          LDA  INTIM  ; Wait for the visible area of the screen ;@ 115
  CMP   #0
  BNE FLOW_gap_6_OUTPUT_TRUE
 ;@ 117
      STA  WSYNC      ; 37th scanline ;@ 118
      LDA  #$00       ; Turn the ... ;@ 119
      STA  VBLANK     ; ... electron beam back on ;@ 120
             ;@ 121
      LDA  #0         ; Zero out ... ;@ 122
      STA  SCANCNT    ; ... scanline count ... ;@ 123
      STA  TMP0       ; ... and all ... ;@ 124
      STA  TMP1       ; ... returns ... ;@ 125
      STA  TMP2       ; ... expected ... ;@ 126
      TAX             ; ... to come from ... ;@ 127
      TAY             ; ... BUILDROW ;@ 128
      STA  CXCLR      ; Clear collision detection ;@ 129
 ;@ 130
FLOW_gap_7_OUTPUT_TRUE:
 ;@ 132
          LDA  TMP0       ; Get A ready (PF0) ;@ 133
          STA  WSYNC      ; Wait for very start of row ;@ 134
          STX  GRP0       ; Player 0 -- in X ;@ 135
          STY  GRP1       ; Player 1 -- in Y ;@ 136
          STA  PF0        ; PF0      -- in TMP0 (already in A) ;@ 137
          LDA  TMP1       ; PF1      -- in TMP1 ;@ 138
          STA  PF1        ; ... ;@ 139
          LDA  TMP2       ; PP2      -- in TMP2 ;@ 140
          STA  PF2        ; ... ;@ 141
 ;@ 142
  JSR BUILDROW
 ;@ 144
          INC  SCANCNT    ; Next scan line ;@ 145
          LDA  SCANCNT    ; Do 109*2 = 218 lines ;@ 146
 ;@ 147
  CMP   #109
  BNE FLOW_gap_7_OUTPUT_TRUE
 ;@ 149
      LDA  #0         ; Turning off visuals ;@ 150
      STA  WSYNC      ; Next scanline ;@ 151
      STA  PF0        ; Play field 0 off ;@ 152
      STA  GRP0       ; Player 0 off ;@ 153
      STA  GRP1       ; Player 1 off ;@ 154
      STA  PF1        ; Play field 1 off ;@ 155
      STA  PF2        ; Play field 2 off ;@ 156
      STA  WSYNC      ; Next scanline ;@ 157
       ;@ 158
  JMP  FLOW_gap_3_1_INPUT; CLEAN-JumpToJump     JMP  FLOW_gap_3_OUTPUT_BEGIN
 ;@ 160
 ;@ 162
; ====================================== ;@ 163
 ;@ 164
BUILDROW:
   ;@ 166
  LDA  SCANCNT    ; Current scanline ;@ 167
 ;@ 168
  CMP   #6
  BCC FLOW_gap_9_OUTPUT_TRUE
       ;@ 213
      AND  #7           ; Lower 3 bits as an index again ;@ 214
      TAY               ; Using Y to lookup graphics ;@ 215
      LDA  GR_PLAYER,Y  ; Get the graphics (if enabled on this row) ;@ 216
      TAX               ; Hold it (for return as player 0) ;@ 217
      TAY               ; Hold it (for return as player 1) ;@ 218
      LDA  SCANCNT      ; Scanline count again ;@ 219
      LSR  A            ; This time ... ;@ 220
      LSR  A            ; ... we divide ... ;@ 221
      LSR  A            ; ... by eight (8 rows in picture) ;@ 222
 ;@ 223
  CMP   PLAYR0Y
  BEQ FLOW_gap_10_OUTPUT_END
          LDX  #0       ; Not time for Player 0 ... no graphics ;@ 225
FLOW_gap_10_OUTPUT_END:
 ;@ 227
  CMP   PLAYR1Y
  BEQ FLOW_gap_11_OUTPUT_END
          LDY  #0       ; Not time for Player 0 ... no graphics ;@ 229
FLOW_gap_11_OUTPUT_END:
 ;@ 231
      LDA  WALLSTART    ; Calculate ... ;@ 232
      CLC               ; ... the ... ;@ 233
      ADC  WALLHEI      ; ... end row of ... ;@ 234
      STA  TMP0         ; ... the wall ;@ 235
 ;@ 236
      LDA  SCANCNT      ; Scanline count ;@ 237
 ;@ 238
  CMP   WALLSTART
  BCC FLOW_gap_12_OUTPUT_FALSE
  CMP   TMP0
  BCS FLOW_gap_12_OUTPUT_FALSE
          LDA  WALLDRELA     ; Draw wall ... ;@ 240
          STA  TMP0          ; ... by transfering ... ;@ 241
          LDA  WALLDRELB     ; ... playfield ... ;@ 242
          STA  TMP1          ; ... patterns ... ;@ 243
          LDA  WALLDRELC     ; ... to ... ;@ 244
          STA  TMP2          ; ... return area ;@ 245
    RTS ; CLEAN-JumpToReturn   JMP  FLOW_gap_9_OUTPUT_END; CLEAN-JumpToJump     JMP  FLOW_gap_12_OUTPUT_END
FLOW_gap_12_OUTPUT_FALSE:
          LDA  #0            ; No walls on this row ;@ 247
          STA  TMP0          ; ... clear ... ;@ 248
          STA  TMP1          ; ... out ... ;@ 249
          STA  TMP2          ; ... the playfield ;@ 250
       ;@ 252
    RTS ; CLEAN-JumpToReturn     JMP  FLOW_gap_9_OUTPUT_END
FLOW_gap_9_OUTPUT_TRUE:
 ;@ 170
      AND  #7     ; Only need the lower 3 bits ;@ 171
      TAY         ; Soon to be an index into a list ;@ 172
 ;@ 173
      ; At this point, the beam is past the loading of the ;@ 174
      ; playfield for the left half. We want to make sure ;@ 175
      ; that the right half of the playfield is off, so do that ;@ 176
      ; now. ;@ 177
 ;@ 178
      LDX  #0     ; Blank bit pattern ;@ 179
      STX  TMP0   ; This will always be blank ;@ 180
      STX  PF1    ; Turn off playfield ... ;@ 181
      STX  PF2    ; ... for right half of the screen ;@ 182
       ;@ 183
      TAX               ; Another index ;@ 184
      LDA  SCORE_PF1,Y  ; Lookup the PF1 graphics for this row ;@ 185
      STA  TMP1         ; Return it to the caller ;@ 186
      TAY               ; We'll need this value again in a second ;@ 187
      LDA  SCORE_PF2,X  ; Lookup the PF2 graphics for this row ;@ 188
      STA  TMP2         ; Return it to the caller ;@ 189
       ;@ 190
      STA  WSYNC  ; Now on the next row ;@ 191
       ;@ 192
      STY  PF1    ; Repeat the left-side playfield ... ;@ 193
      STA  PF2    ; ... onto the new row ;@ 194
 ;@ 195
      LDA  SCORE_PF2,X  ; Kill some time ;@ 196
      LDA  SCORE_PF2,X  ;  ;@ 197
      LDA  SCORE_PF2,X  ;  ;@ 198
      LDA  SCORE_PF2,X  ;  ;@ 199
      LDA  SCORE_PF2,X  ;  ;@ 200
      LDA  SCORE_PF2,X  ;  ;@ 201
 ;@ 202
      LDX  #0     ; Return 0 (off) for player 0 ... ;@ 203
      LDY  #0     ; ... and player 1 ;@ 204
 ;@ 205
      ; The beam is past the left half of the field again. ;@ 206
      ; Turn off the playfield. ;@ 207
 ;@ 208
      STX  PF1    ; 0 to PF1 ... ;@ 209
      STX  PF2    ; ... and PF2 ;@ 210
 ;@ 211
   ;@ 254
  RTS
;</EditorTab> ;@ 256
 ;@ 257
; ============= END OF VIDEO KERNEL =================== ;@ 258
 ;@ 259
 ;@ 260
; ====================================== ;@ 261
;<EditorTab name="init"> ;@ 262
INIT:
; ;@ 264
; This function is called ONCE at power-up/reset to initialize various ;@ 265
; hardware and temporaries. ;@ 266
; ;@ 267
  LDA  #$40        ; Playfield ... ;@ 268
  STA  COLUPF      ; ... redish ;@ 269
  LDA  #$7E        ; Player 0 ... ;@ 270
  STA  COLUP0      ; ... white ;@ 271
  LDA  #0          ; Player 1 ... ;@ 272
  STA  COLUP1      ; ... black ;@ 273
 ;@ 274
  LDA  #5          ; Right half of playfield is reflection of left ... ;@ 275
  STA  CTRLPF      ; ... and playfield is on top of players ;@ 276
 ;@ 277
  LDX  #4          ; Player 0 position count ;@ 278
  LDY  #3          ; Player 1 position count ;@ 279
  STA  WSYNC       ; Get a fresh scanline ;@ 280
 ;@ 281
FLOW_gap_14_OUTPUT_TRUE:
      DEX          ; Kill time while the beam moves  ;@ 283
  CPX   #0
  BNE FLOW_gap_14_OUTPUT_TRUE
  STA  RESP0       ; Mark player 0's X position ;@ 285
 ;@ 286
FLOW_gap_15_OUTPUT_TRUE:
      DEY          ; Kill more time ;@ 288
  CPY   #0
  BNE FLOW_gap_15_OUTPUT_TRUE
  STA  RESP1       ; Mark player 1's X position ;@ 290
 ;@ 291
  JSR EXPERTISE
   ;@ 293
  LDA  #10         ; Wall is ... ;@ 294
  STA  WALLHEI     ; ... 10 double-scanlines high ;@ 295
   ;@ 296
  LDA  #0          ; Set score to ... ;@ 297
  STA  WALLCNT     ; ... 0 ;@ 298
  JSR MAKE_SCORE
  LDA  #0          ; Blank bits ... ;@ 300
  STA  SCORE_PF2+5 ; ... on the end of each ... ;@ 301
  STA  SCORE_PF1+5 ; ... digit pattern ;@ 302
 ;@ 303
  JSR ADJUST_DIF
  JSR NEW_GAPS
   ;@ 306
  LDA  #112        ; Set wall position off bottom ... ;@ 307
  STA  WALLSTART   ; ... to force a restart on first move ;@ 308
 ;@ 309
  LDA  #0          ; Zero out ... ;@ 310
  STA  HMP0        ; ... player 0 motion ... ;@ 311
  STA  HMP1        ; ... and player 1 motion ;@ 312
   ;@ 313
  RTS
;</EditorTab> ;@ 315
 ;@ 316
; =================================== ;@ 317
;<EditorTab name="play-mode"> ;@ 318
INIT_PLAYMODE:
; ;@ 320
; This function initializes the game play mode ;@ 321
; ;@ 322
  LDA  #$C0       ; Background color ... ;@ 323
  STA  COLUBK     ; ... greenish ;@ 324
  LDA  #1         ; Game mode is ... ;@ 325
  STA  MODE       ; ... SELECT ;@ 326
  LDA  #255       ; Restart wall score to ... ;@ 327
  STA  WALLCNT    ; ... 0 on first move ;@ 328
  LDA  #112       ; Force wall to start ... ;@ 329
  STA  WALLSTART  ; ... over on first move ;@ 330
  JSR INIT_MUSIC
  RTS
 ;@ 333
; ====================================== ;@ 334
PLAYMODE:
; ;@ 336
; This function is called once per frame to process the main game play. ;@ 337
; ;@ 338
   ;@ 339
  JSR SEL_RESET_CHK
 ;@ 341
  CMP   #0
  BEQ FLOW_gap_18_OUTPUT_END
      STX  DEBOUNCE      ; Restore the old value ... ;@ 343
  JSR INIT_SELMODE
  RTS
FLOW_gap_18_OUTPUT_END:
   ;@ 347
  JSR PROCESS_MUSIC
  JSR MOVE_WALLS
 ;@ 350
  CMP   #1
  BNE FLOW_gap_19_OUTPUT_END
      INC  WALLCNT       ; Bump the score ;@ 352
  JSR ADJUST_DIF
      LDA  WALLCNT       ; Change the ... ;@ 354
  JSR MAKE_SCORE
  JSR NEW_GAPS
FLOW_gap_19_OUTPUT_END:
 ;@ 358
  LDA  CXP0FB  ; Player 0 collision with playfield ;@ 359
  STA  TMP0    ; Hold it ;@ 360
  LDA  CXP1FB  ; Player 1 collision with playfield ;@ 361
  ORA  TMP0    ; Did either ... ;@ 362
  AND  #$80    ; ... player collide with wall? ;@ 363
 ;@ 364
  CMP   #0
  BEQ FLOW_gap_20_OUTPUT_END
  JSR INIT_GOMODE
  RTS
FLOW_gap_20_OUTPUT_END:
 ;@ 369
  LDA  SWCHA     ; Joystick ;@ 370
  ADC  ENTROPYB  ; Add to ... ;@ 371
  STA  ENTROPYB  ; ... entropy ;@ 372
 ;@ 373
  LDA  SWCHA     ; Joystick ;@ 374
  AND  #$80      ; Player 0 left switch ;@ 375
  CMP   #0
  BEQ FLOW_gap_21_OUTPUT_TRUE
      LDA  SWCHA     ; Joystick ;@ 379
      AND  #$40      ; Player 0 right switch ;@ 380
  CMP   #0
  BEQ FLOW_gap_22_OUTPUT_TRUE
          LDA  #0          ; Not moving value ;@ 385
  JMP  FLOW_gap_21_OUTPUT_END; CLEAN-JumpToJump     JMP  FLOW_gap_22_OUTPUT_END
FLOW_gap_22_OUTPUT_TRUE:
          INC  ENTROPYC    ; Yes ... increase entropy ;@ 382
          LDA  #$10        ; Moving right value ;@ 383
    JMP  FLOW_gap_21_OUTPUT_END
FLOW_gap_21_OUTPUT_TRUE:
      LDA  #$F0    ; Moving left value ;@ 377
FLOW_gap_21_OUTPUT_END:
  STA  HMP0      ; New movement value P0 ;@ 388
 ;@ 389
  LDA  SWCHA     ; Joystick ;@ 390
  AND  #$08      ; Player 1 left switch ;@ 391
  CMP   #0
  BEQ FLOW_gap_23_OUTPUT_TRUE
      LDA  SWCHA     ; Joystick ;@ 395
      AND  #$04      ; Player 1 right switch ;@ 396
  CMP   #0
  BEQ FLOW_gap_24_OUTPUT_TRUE
          INC  ENTROPYC    ; Increase entropy ;@ 400
          LDA  #0          ; Not moving value ;@ 401
  JMP  FLOW_gap_23_OUTPUT_END; CLEAN-JumpToJump     JMP  FLOW_gap_24_OUTPUT_END
FLOW_gap_24_OUTPUT_TRUE:
          LDA  #$10        ; Moving right value ;@ 398
    JMP  FLOW_gap_23_OUTPUT_END
FLOW_gap_23_OUTPUT_TRUE:
      LDA  #$F0    ; Moving left value ;@ 393
FLOW_gap_23_OUTPUT_END:
  STA  HMP1      ; New movement value P1 ;@ 404
 ;@ 405
  RTS
;</EditorTab> ;@ 407
 ;@ 408
; =================================== ;@ 409
;<EditorTab name="select-mode"> ;@ 410
INIT_SELMODE:
; ;@ 412
; This function initializes the games SELECT-MODE ;@ 413
;           ;@ 414
  LDA  #0        ; Turn off ... ;@ 415
  STA  AUDV0     ; ... all ... ;@ 416
  STA  AUDV1     ; ... sound ;@ 417
  LDA  #$C8      ; Background color ... ;@ 418
  STA  COLUBK    ; ... greenish bright ;@ 419
  LDA  #2        ; Now in ... ;@ 420
  STA  MODE      ; SELECT game mode ;@ 421
  RTS
 ;@ 423
; ====================================== ;@ 424
SELMODE:
; ;@ 426
; This function is called once per frame to process the SELECT-MODE. ;@ 427
; The wall moves here, but doesn't change or collide with players. ;@ 428
; This function selects between 1 and 2 player game. ;@ 429
; ;@ 430
  JSR MOVE_WALLS
  JSR SEL_RESET_CHK
   ;@ 433
  CMP   #1
  BEQ FLOW_gap_27_OUTPUT_TRUE
  CMP   #3
  BEQ FLOW_gap_27_OUTPUT_TRUE
  CMP   #2
  BNE FLOW_gap_28_OUTPUT_END
      LDA  PLAYR1Y        ; Select toggled. Get player 1 Y coordinate ;@ 437
  CMP   #255
  BEQ FLOW_gap_29_OUTPUT_TRUE
          LDA  #255       ; Offscreen if it is currently on ;@ 441
    JMP  FLOW_gap_29_OUTPUT_END
FLOW_gap_29_OUTPUT_TRUE:
          LDA  #12        ; Onscreen if it is currently off ;@ 439
FLOW_gap_29_OUTPUT_END:
      STA  PLAYR1Y        ; Toggled Y coordinate ;@ 443
FLOW_gap_28_OUTPUT_END:
    JMP  FLOW_gap_27_OUTPUT_END
FLOW_gap_27_OUTPUT_TRUE:
  JSR INIT_PLAYMODE
FLOW_gap_27_OUTPUT_END:
 ;@ 445
  JSR EXPERTISE
  RTS
;</EditorTab> ;@ 448
 ;@ 449
; ====================================== ;@ 450
;<EditorTab name="go-mode"> ;@ 451
INIT_GOMODE:
; ;@ 453
; This function initializes the GAME-OVER game mode. ;@ 454
;    ;@ 455
  STA  HMCLR     ; Stop both players from moving ;@ 456
  LDA  CXP0FB    ; P0 collision with wall ;@ 457
  AND  #$80      ; Did player 0 collide? ;@ 458
 ;@ 459
  CMP   #0
  BNE FLOW_gap_31_OUTPUT_END
      LDA  #2        ; No ... move player 0 ... ;@ 461
      STA  PLAYR0Y   ; ... up the screen ;@ 462
FLOW_gap_31_OUTPUT_END:
 ;@ 464
  LDA  CXP1FB    ; P1 collision with wall ;@ 465
  AND  #$80      ; Did player 1 collide? ;@ 466
 ;@ 467
  CMP   #0
  BNE FLOW_gap_32_OUTPUT_END
      LDA  PLAYR1Y ;@ 469
  CMP   #255
  BEQ FLOW_gap_32_OUTPUT_END
          LDA  #2        ; Player 1 is onscreen and didn't collide ... ;@ 471
          STA  PLAYR1Y   ; ... move up the screen ;@ 472
FLOW_gap_32_OUTPUT_END:
 ;@ 475
  LDA  #0         ; Going to ... ;@ 476
  STA  MODE       ; ... game-over mode ;@ 477
  STA  AUDV0      ; Turn off any ... ;@ 478
  STA  AUDV1      ; ... sound ;@ 479
  JSR INIT_GO_FX
  RTS
 ;@ 482
; ====================================== ;@ 483
GOMODE:
; ;@ 485
; This function is called every frame to process the game ;@ 486
; over sequence. When the sound effect has finished, the ;@ 487
; game switches to select mode. ;@ 488
; ;@ 489
  JSR PROCESS_GO_FX
  CMP   #0
  BEQ FLOW_gap_35_OUTPUT_END
  JSR INIT_SELMODE
FLOW_gap_35_OUTPUT_END:
  RTS
;</EditorTab> ;@ 495
 ;@ 496
; ====================================== ;@ 497
;<EditorMode name="utils"> ;@ 498
MOVE_WALLS:
; ;@ 500
; This function moves the wall down the screen and back to position 0 ;@ 501
; when it reaches (or passes) 112. ;@ 502
; ;@ 503
; ;@ 504
  DEC  WALLDELY     ; Time to move the wall ;@ 505
  LDA  WALLDELY ;@ 506
 ;@ 507
  CMP   #0
  BNE FLOW_gap_37_OUTPUT_TRUE
      LDA  WALLDELYR    ; Reset the ... ;@ 511
      STA  WALLDELY     ; ... delay count ;@ 512
      LDA  WALLSTART    ; Current wall position ;@ 513
      CLC               ; No accidental carry ;@ 514
      ADC  WALL_INC     ; Increment wall position ;@ 515
  CMP   #112
  BCC FLOW_gap_38_OUTPUT_TRUE
          LDA  #0            ; Else restart ... ;@ 520
          STA  WALLSTART    ; ... wall at top of screen ;@ 521
          LDA  #1           ; Return flag that wall DID restart ;@ 522
    RTS ; CLEAN-JumpToReturn   JMP  FLOW_gap_37_OUTPUT_END; CLEAN-JumpToJump     JMP  FLOW_gap_38_OUTPUT_END
FLOW_gap_38_OUTPUT_TRUE:
          STA  WALLSTART    ; Store new wall position ;@ 517
          LDA  #0           ; Return flag that wall did NOT restart ;@ 518
    RTS ; CLEAN-JumpToReturn     JMP  FLOW_gap_37_OUTPUT_END
FLOW_gap_37_OUTPUT_TRUE:
      LDA  #0           ; Return flag that wall did NOT restart ;@ 509
   ;@ 525
  RTS
 ;@ 527
; ====================================== ;@ 528
NEW_GAPS:
; ;@ 530
; This function builds the PF0, PF1, and PF2 graphics for a wall ;@ 531
; with the gap pattern (GAPBITS) placed at random in the 20 bit ;@ 532
; area. ;@ 533
; ;@ 534
  LDA  #255       ; Start with ... ;@ 535
  STA  WALLDRELA  ; ... solid wall in PF0 ... ;@ 536
  STA  WALLDRELB  ; ... and PF1 ;@ 537
  LDA  GAPBITS    ; Store the gap pattern ... ;@ 538
  STA  WALLDRELC  ; ... in PF2 ;@ 539
   ;@ 540
  LDA  ENTROPYA   ; Get ... ;@ 541
  ADC  ENTROPYB   ; ... a randomish ... ;@ 542
  ADC  ENTROPYC   ; ... number ... ;@ 543
  STA  ENTROPYC   ; ... from ... ;@ 544
  AND  #15        ; ... 0 to 15 ;@ 545
 ;@ 546
  CMP   #12
  BEQ FLOW_gap_40_OUTPUT_END
  BCC FLOW_gap_40_OUTPUT_END
      SBC  #9     ; Actually, we want it from 0-11 ;@ 548
FLOW_gap_40_OUTPUT_END:
   ;@ 550
FLOW_gap_41_1_INPUT:
  CMP   #0
  BEQ FLOW_gap_41_OUTPUT_FALSE
      SEC             ; Roll gap ... ;@ 552
      ROR  WALLDRELC  ; ... left ... ;@ 553
      ROL  WALLDRELB  ; ... desired ... ;@ 554
      ROR  WALLDRELA  ; ... times ... ;@ 555
      SEC             ; ... and roll ... ;@ 556
      SBC  #1         ; ... a 1 (solid) ... ;@ 557
  JMP  FLOW_gap_41_1_INPUT; CLEAN-JumpToJump     JMP  FLOW_gap_41_OUTPUT_BEGIN
FLOW_gap_41_OUTPUT_FALSE:
 ;@ 559
  RTS
 ;@ 561
; ====================================== ;@ 562
MAKE_SCORE:
; ;@ 564
; This function builds the PF1 and PF2 graphics rows for ;@ 565
; the byte value passed in A. The current implementation is ;@ 566
; two-digits only ... PF2 is blank. ;@ 567
; ;@ 568
  LDX  #0    ; 100's digit ;@ 569
  LDY  #0    ; 10's digit ;@ 570
 ;@ 571
FLOW_gap_43_1_INPUT:
  CMP   #100
  BCC FLOW_gap_43_OUTPUT_FALSE
      INX          ; Count ... ;@ 573
      SEC          ; ... the 100s... ;@ 574
      SBC  #100    ; ... value ;@ 575
  JMP  FLOW_gap_43_1_INPUT; CLEAN-JumpToJump     JMP  FLOW_gap_43_OUTPUT_BEGIN
FLOW_gap_43_OUTPUT_FALSE:
 ;@ 577
FLOW_gap_44_1_INPUT:
  CMP   #10
  BCC FLOW_gap_44_OUTPUT_FALSE
      INY          ; Count ... ;@ 579
      SEC          ; ... the 10s ... ;@ 580
	  SBC  #10     ; ... value ;@ 581
  JMP  FLOW_gap_44_1_INPUT; CLEAN-JumpToJump     JMP  FLOW_gap_44_OUTPUT_BEGIN
FLOW_gap_44_OUTPUT_FALSE:
 ;@ 583
  ASL  A     ; One's digit ... ;@ 584
  ASL  A     ; ... *8 .... ;@ 585
  ASL  A     ; ... to find picture ;@ 586
  TAX        ; One's digit picture to X ;@ 587
  TYA        ; Now the 10's digit ;@ 588
  ASL  A     ; Multiply ... ;@ 589
  ASL  A     ; ... by 8 ... ;@ 590
  ASL  A     ; ... to find picture ;@ 591
  TAY        ; 10's picture in Y ;@ 592
   ;@ 593
  LDA  DIGITS,Y  ; Get the 10's digit ;@ 594
  AND  #$F0      ; Only use the left side of the picture ;@ 595
  STA  SCORE_PF1 ; Store left side ;@ 596
  LDA  DIGITS,X  ; Get the 1's digit ;@ 597
  AND  #$0F      ; Only use the right side of the picture ;@ 598
  ORA  SCORE_PF1 ; Put left and right half together ;@ 599
  STA  SCORE_PF1 ; And store image ;@ 600
 ;@ 601
  LDA  DIGITS+1,Y ; Repeat for 2nd line of picture ;@ 602
  AND  #$F0 ;@ 603
  STA  SCORE_PF1+1 ;@ 604
  LDA  DIGITS+1,X ;@ 605
  AND  #$0F ;@ 606
  ORA  SCORE_PF1+1 ;@ 607
  STA  SCORE_PF1+1 ;@ 608
 ;@ 609
  LDA  DIGITS+2,Y ; Repeat for 3nd line of picture ;@ 610
  AND  #$F0 ;@ 611
  STA  SCORE_PF1+2 ;@ 612
  LDA  DIGITS+2,X ;@ 613
  AND  #$0F ;@ 614
  ORA  SCORE_PF1+2 ;@ 615
  STA  SCORE_PF1+2 ;@ 616
 ;@ 617
  LDA  DIGITS+3,Y ; Repeat for 4th line of picture ;@ 618
  AND  #$F0 ;@ 619
  STA  SCORE_PF1+3 ;@ 620
  LDA  DIGITS+3,X ;@ 621
  AND  #$0F ;@ 622
  ORA  SCORE_PF1+3 ;@ 623
  STA  SCORE_PF1+3 ;@ 624
 ;@ 625
  LDA  DIGITS+4,Y ; Repeat for 5th line of picture ;@ 626
  AND  #$F0 ;@ 627
  STA  SCORE_PF1+4 ;@ 628
  LDA  DIGITS+4,X ;@ 629
  AND  #$0F ;@ 630
  ORA  SCORE_PF1+4 ;@ 631
  STA  SCORE_PF1+4 ;@ 632
 ;@ 633
  LDA  #0           ; For now ... ;@ 634
  STA  SCORE_PF2   ; ... there ... ;@ 635
  STA  SCORE_PF2+1 ; ... is ... ;@ 636
  STA  SCORE_PF2+2 ; ... no ... ;@ 637
  STA  SCORE_PF2+3 ; ... 100s ... ;@ 638
  STA  SCORE_PF2+4 ; ... digit drawn ;@ 639
 ;@ 640
  RTS
 ;@ 642
; ====================================== ;@ 643
EXPERTISE:
; ;@ 645
; This function changes the Y position of the players based on the ;@ 646
; position of their respective pro/novice switches. The player 1 ;@ 647
; position is NOT changed if the mode is a single-player game. ;@ 648
; ;@ 649
  LDA  SWCHB   ; Pro/novice settings ;@ 650
  AND  #$80    ; Novice for Player 0? ;@ 651
  CMP   #0
  BEQ FLOW_gap_46_OUTPUT_TRUE
      LDA  #8   ; Pro ... near the top ;@ 655
    JMP  FLOW_gap_46_OUTPUT_END
FLOW_gap_46_OUTPUT_TRUE:
      LDA  #12  ; Novice ... near the bottom ;@ 653
FLOW_gap_46_OUTPUT_END:
  STA  PLAYR0Y ; ... to Player 0 ;@ 657
   ;@ 658
  LDX  PLAYR1Y ;@ 659
  CPX   #255
  BEQ FLOW_gap_47_OUTPUT_END
      LDA  SWCHB ;@ 661
      AND  #$40 ;@ 662
  CMP   #0
  BEQ FLOW_gap_48_OUTPUT_TRUE
          LDX  #8   ; Pro ... near the top ;@ 666
    JMP  FLOW_gap_48_OUTPUT_END
FLOW_gap_48_OUTPUT_TRUE:
          LDX  #12  ; Novice ... near the bottom ;@ 664
FLOW_gap_48_OUTPUT_END:
      STX  PLAYR1Y ;@ 668
FLOW_gap_47_OUTPUT_END:
 ;@ 670
  RTS
 ;@ 672
; ====================================== ;@ 673
ADJUST_DIF:
; ;@ 675
; This function adjusts the wall game difficulty values based on the ;@ 676
; current score. The music can also change with the difficulty. A single ;@ 677
; table describes the new values and when they take effect. ;@ 678
;               ;@ 679
  LDX  #0  ; Starting at index 0 ;@ 680
 ;@ 681
FLOW_gap_50_1_INPUT:
 ;@ 683
      LDA  SKILL_VALUES,X  ; Get the score match ;@ 684
  CMP   #255
  BNE FLOW_gap_51_OUTPUT_END
  RTS
FLOW_gap_51_OUTPUT_END:
  CMP   WALLCNT
  BNE FLOW_gap_52_OUTPUT_END
          INX                 ; Copy ... ;@ 689
          LDA  SKILL_VALUES,X ; ... new ... ;@ 690
          STA  WALL_INC       ; ... wall increment ;@ 691
          INX                 ; Copy ... ;@ 692
          LDA  SKILL_VALUES,X ; ... new ... ;@ 693
          STA  WALLDELY       ; ... wall ... ;@ 694
          STA  WALLDELYR      ; ... delay ;@ 695
          INX                 ; Copy ... ;@ 696
          LDA  SKILL_VALUES,X ; ... new ... ;@ 697
          STA  GAPBITS        ; ... gap pattern ;@ 698
          INX                 ; Copy ... ;@ 699
          LDA  SKILL_VALUES,X ; ... new ... ;@ 700
          STA  MUSAIND        ; ... MusicA index ;@ 701
          INX                 ; Copy ... ;@ 702
          LDA  SKILL_VALUES,X ; ... new ... ;@ 703
          STA  MUSBIND        ; ... MusicB index ;@ 704
          LDA  #1             ; Force ... ;@ 705
          STA  MUSADEL        ; ... music to ... ;@ 706
          STA  MUSBDEL        ; ... start new ;@ 707
  RTS
FLOW_gap_52_OUTPUT_END:
       ;@ 710
      INX     ; Move ... ;@ 711
      INX     ; ... X ... ;@ 712
      INX     ; ... to ... ;@ 713
      INX     ; ... next ... ;@ 714
      INX     ; ... row of ... ;@ 715
      INX     ; ... table ;@ 716
  JMP  FLOW_gap_50_1_INPUT; CLEAN-JumpToJump     JMP  FLOW_gap_50_OUTPUT_BEGIN
 ;@ 719
; ====================================== ;@ 720
SEL_RESET_CHK:
; ;@ 722
; This function checks for changes to the reset/select ;@ 723
; switches and debounces the transitions. ;@ 724
; ;@ 725
   ;@ 726
  LDX  DEBOUNCE  ; Hold onto old value ;@ 727
  LDA  SWCHB     ; New value ;@ 728
  AND  #3         ; Only need bottom 2 bits ;@ 729
 ;@ 730
  CMP   DEBOUNCE
  BEQ FLOW_gap_54_OUTPUT_TRUE
      STA  DEBOUNCE  ; Hold new value ;@ 734
      EOR  #$FF      ; Complement the value (active low hardware) ;@ 735
      AND  #3        ; Only need select/reset ;@ 736
    RTS ; CLEAN-JumpToReturn     JMP  FLOW_gap_54_OUTPUT_END
FLOW_gap_54_OUTPUT_TRUE:
      LDA  #0        ; Return 0 ... nothing changed ;@ 732
   ;@ 738
  RTS
;</EditorTab> ;@ 740
 ;@ 741
; ====================================== ;@ 742
;<EditorTab name="sound"> ;@ 743
INIT_MUSIC:
; ;@ 745
; This function initializes the hardware and temporaries ;@ 746
; for 2-channel music ;@ 747
; ;@ 748
  LDA  #$06    ; Initialize sound ... ;@ 749
  STA  AUDC0   ; ... to pure ... ;@ 750
  STA  AUDC1   ; ... tones ;@ 751
  LDA  #0      ; Turn off ... ;@ 752
  STA  AUDV0   ; ... all ... ;@ 753
  STA  AUDV1   ; ... sound ;@ 754
  STA  MUSAIND ; Music pointers ... ;@ 755
  STA  MUSBIND ; ... to top of data ;@ 756
  LDA  #1      ; Force ... ;@ 757
  STA  MUSADEL ; ... music ... ;@ 758
  STA  MUSBDEL ; ... reload ;@ 759
  LDA  #15     ; Set volume levels ... ;@ 760
  STA  MUSAVOL ; ... to ... ;@ 761
  STA  MUSBVOL ; ... maximum ;@ 762
  RTS
 ;@ 764
; ====================================== ;@ 765
PROCESS_MUSIC:
; ;@ 767
; This function is called once per frame to process the ;@ 768
; 2 channel music. Two tables contain the commands/notes ;@ 769
; for individual channels. This function changes the ;@ 770
; notes at the right time. ;@ 771
;            ;@ 772
  DEC  MUSADEL   ; Last note ended? ;@ 773
  BNE FLOW_gap_57_OUTPUT_END
 ;@ 775
FLOW_gap_58_OUTPUT_TRUE:
          LDX  MUSAIND   ; Voice-A index ;@ 777
          LDA  MUSICA,X  ; Get the next music command ;@ 778
  CMP   #0
  BEQ FLOW_gap_59_OUTPUT_TRUE
  CMP   #1
  BEQ FLOW_gap_60_OUTPUT_TRUE
  CMP   #2
  BNE FLOW_gap_61_OUTPUT_END
              INX            ; Point to volume value ;@ 797
              INC  MUSAIND   ; Bump the music pointer ;@ 798
              LDA  MUSICA,X  ; Get the volume value ;@ 799
              INC  MUSAIND   ; Bump the music pointer ;@ 800
              STA  MUSAVOL   ; Store the new volume value ;@ 801
              LDA  #0        ; Continue processing ;@ 802
FLOW_gap_61_OUTPUT_END:
  JMP  FLOW_gap_59_OUTPUT_END; CLEAN-JumpToJump     JMP  FLOW_gap_60_OUTPUT_END
FLOW_gap_60_OUTPUT_TRUE:
              INX            ; Point to the control value ;@ 790
              INC  MUSAIND   ; Bump the music pointer ;@ 791
              LDA  MUSICA,X  ; Get the control value ;@ 792
              INC  MUSAIND   ; Bump the music pointer ;@ 793
              STA  AUDC0     ; Store the new control value ;@ 794
              LDA  #0        ; Continue processing ;@ 795
    JMP  FLOW_gap_59_OUTPUT_END
FLOW_gap_59_OUTPUT_TRUE:
              INX            ; Point to jump value ;@ 780
              TXA            ; X to ... ;@ 781
              TAY            ; ... Y (pointer to jump value) ;@ 782
              INX            ; Point one past jump value ;@ 783
              TXA            ; Into A so we can subtract ;@ 784
              SEC            ; No accidental borrow ;@ 785
              SBC  MUSICA,Y  ; New index ;@ 786
              STA  MUSAIND   ; Store it ;@ 787
              LDA  #0        ; Continue processing ;@ 788
FLOW_gap_59_OUTPUT_END:
  CMP   #0
  BEQ FLOW_gap_58_OUTPUT_TRUE
 ;@ 805
      LDY  MUSAVOL   ; Get the volume ;@ 806
      AND  #31       ; Lower 5 bits are frequency ;@ 807
  CMP   #31
  BNE FLOW_gap_62_OUTPUT_END
          LDY  #0      ; Frequency of 31 flags silence ;@ 809
FLOW_gap_62_OUTPUT_END:
      STA  AUDF0     ; Store the frequency ;@ 811
      STY  AUDV0     ; Store the volume ;@ 812
      LDA  MUSICA,X  ; Get the note value again ;@ 813
      INC  MUSAIND   ; Bump to the next command ;@ 814
      ROR  A         ; The upper ... ;@ 815
      ROR  A         ; ... three ... ;@ 816
      ROR  A         ; ... bits ... ;@ 817
      ROR  A         ; ... hold ... ;@ 818
      ROR  A         ; ... the ... ;@ 819
      AND  #7        ; ... delay ;@ 820
      CLC            ; No accidental carry ;@ 821
      ROL  A         ; Every delay tick ... ;@ 822
      ROL  A         ; ... is *4 frames ;@ 823
      STA  MUSADEL   ; Store the note delay ;@ 824
FLOW_gap_57_OUTPUT_END:
   ;@ 826
  DEC  MUSBDEL   ; Repeat Channel A sequence for Channel B ;@ 827
  BNE FLOW_gap_63_OUTPUT_END
       ;@ 829
FLOW_gap_64_OUTPUT_TRUE:
          LDX  MUSBIND ;@ 831
          LDA  MUSICB,X ;@ 832
  CMP   #0
  BEQ FLOW_gap_65_OUTPUT_TRUE
  CMP   #1
  BEQ FLOW_gap_66_OUTPUT_TRUE
  CMP   #2
  BNE FLOW_gap_67_OUTPUT_END
              INX             ;@ 851
              INC  MUSBIND    ;@ 852
              LDA  MUSICB,X  ;@ 853
              INC  MUSBIND   ;@ 854
              STA  MUSBVOL   ;@ 855
              LDA  #0 ;@ 856
FLOW_gap_67_OUTPUT_END:
  JMP  FLOW_gap_65_OUTPUT_END; CLEAN-JumpToJump     JMP  FLOW_gap_66_OUTPUT_END
FLOW_gap_66_OUTPUT_TRUE:
              INX            ;@ 844
              INC  MUSBIND   ;@ 845
              LDA  MUSICB,X  ;@ 846
              INC  MUSBIND    ;@ 847
              STA  AUDC1     ;@ 848
              LDA  #0 ;@ 849
    JMP  FLOW_gap_65_OUTPUT_END
FLOW_gap_65_OUTPUT_TRUE:
              INX   ;@ 834
              TXA      ;@ 835
              TAY      ;@ 836
              INX      ;@ 837
              TXA          ;@ 838
              SEC             ;@ 839
              SBC  MUSICB,Y   ;@ 840
              STA  MUSBIND    ;@ 841
              LDA  #0 ;@ 842
FLOW_gap_65_OUTPUT_END:
  CMP   #0
  BEQ FLOW_gap_64_OUTPUT_TRUE
 ;@ 859
      LDY  MUSBVOL ;@ 860
      AND  #31 ;@ 861
  CMP   #31
  BNE FLOW_gap_68_OUTPUT_END
          LDY  #0 ;@ 863
FLOW_gap_68_OUTPUT_END:
      STA  AUDF1 ;@ 865
      STY  AUDV1 ;@ 866
      LDA  MUSICB,X ;@ 867
      INC  MUSBIND ;@ 868
      ROR  A ;@ 869
      ROR  A ;@ 870
      ROR  A ;@ 871
      ROR  A ;@ 872
      ROR  A ;@ 873
      AND  #7 ;@ 874
      CLC ;@ 875
      ROL  A ;@ 876
      ROL  A ;@ 877
      STA  MUSBDEL ;@ 878
FLOW_gap_63_OUTPUT_END:
  RTS
 ;@ 881
; ====================================== ;@ 882
INIT_GO_FX:
; ;@ 884
; This function initializes the hardware and temporaries ;@ 885
; to play the soundeffect of a player hitting the wall ;@ 886
; ;@ 887
  LDA  #5       ; Set counter for frame delay ... ;@ 888
  STA  MUS_TMP1 ; ... between frequency change ;@ 889
  LDA  #3       ; Tone type ... ;@ 890
  STA  AUDC0    ; ... poly tone ;@ 891
  LDA  #15      ; Volume A ... ;@ 892
  STA  AUDV0    ; ... to max ;@ 893
  LDA  #0       ; Volume B ... ;@ 894
  STA  AUDV1    ; ... silence ;@ 895
  LDA  #240     ; Initial ... ;@ 896
  STA  MUS_TMP0 ; ... sound ... ;@ 897
  STA  AUDF0    ; ... frequency ;@ 898
  RTS
 ;@ 900
; ====================================== ;@ 901
PROCESS_GO_FX:
; ;@ 903
; This function is called once per scanline to play the ;@ 904
; soundeffects of a player hitting the wall. ;@ 905
;         ;@ 906
  DEC   MUS_TMP1 ; Time to change the frequency? ;@ 907
  BNE FLOW_gap_71_OUTPUT_END
      LDA   #5       ; Reload ... ;@ 909
      STA   MUS_TMP1 ; ... the frame count ;@ 910
      INC   MUS_TMP0 ; Increment ... ;@ 911
      LDA   MUS_TMP0 ; ... the frequency divisor ;@ 912
      STA   AUDF0    ; Change the frequency ;@ 913
  CMP   #0
  BNE FLOW_gap_71_OUTPUT_END
          LDA   #1       ; All done ... return 1 ;@ 915
  RTS
FLOW_gap_71_OUTPUT_END:
  LDA   #0 ;@ 919
   ;@ 920
  RTS
;</EditorTab> ;@ 922
 ;@ 923
;</EditorTab name="data"> ;@ 924
; ====================================== ;@ 925
; Music commands for Channel A and Channel B ;@ 926
   ;@ 927
  ; A word on music and wall timing ... ;@ 928
 ;@ 929
  ; Wall moves between scanlines 0 and 111 (112 total) ;@ 930
 ;@ 931
  ; Wall-increment   frames-to-top ;@ 932
  ;      3             336 ;@ 933
  ;      2             224 ;@ 934
  ;      1             112 ;@ 935
  ;     0.5             56  ; Ah ... but we are getting one less ;@ 936
   ;@ 937
  ; Each tick is multiplied by 4 to yield 4 frames per tick ;@ 938
  ; 32 ticks/song = 32*4 = 128 frames / song ;@ 939
 ;@ 940
  ; We want songs to start with wall at top ... ;@ 941
 ;@ 942
  ; Find the least-common-multiple ;@ 943
  ; 336 and 128 : 2688 8 walls, 21 musics ;@ 944
  ; 224 and 128 :  896 4 walls,  7 musics ;@ 945
  ; 112 and 128 :  896 8 walls,  7 musics ;@ 946
  ;  56 and 128 :  896 16 walls, 7 musics ;@ 947
 ;@ 948
  ; Wall moving every other gives us 112*2=224 scanlines ;@ 949
  ; Song and wall are at start every 4 ;@ 950
  ; 1 scanline, every 8 ;@ 951
  ; Wall delay=3 gives us 128*3=336 scanlines 2 ;@ 952
 ;@ 953
; MUSIC EQUATES ;@ 954
; ;@ 955
MUSCMD_JUMP    .equ 0 ;@ 956
MUSCMD_CONTROL .equ 1 ;@ 957
MUSCMD_VOLUME  .equ 2 ;@ 958
MUS_REST       .equ 31 ;@ 959
MUS_DEL_1      .equ 32*1 ;@ 960
MUS_DEL_2      .equ 32*2 ;@ 961
MUS_DEL_3      .equ 32*3 ;@ 962
MUS_DEL_4      .equ 32*4 ;@ 963
 ;@ 964
 ;@ 965
 ;@ 966
MUSICA ;@ 967
 ;@ 968
MA_SONG_1 ;@ 969
 ;@ 970
  .BYTE MUSCMD_CONTROL, $0C  ; Control (pure tone) ;@ 971
  .BYTE MUSCMD_VOLUME,  15   ; Volume (full) ;@ 972
 ;@ 973
MA1_01 ;@ 974
  .BYTE MUS_DEL_3  +  15 ;@ 975
  .BYTE MUS_DEL_1  +  MUS_REST ;@ 976
  .BYTE MUS_DEL_3  +  15 ;@ 977
  .BYTE MUS_DEL_1  +  MUS_REST ;@ 978
  .BYTE MUS_DEL_1  +  7 ;@ 979
  .BYTE MUS_DEL_1  +  MUS_REST ;@ 980
  .BYTE MUS_DEL_1  +  7 ;@ 981
  .BYTE MUS_DEL_1  +  MUS_REST ;@ 982
  .BYTE MUS_DEL_2  +  MUS_REST ;@ 983
  .BYTE MUS_DEL_1  +  8 ;@ 984
  .BYTE MUS_DEL_1  +  MUS_REST ;@ 985
  .BYTE MUS_DEL_4  +  MUS_REST ;@ 986
  .BYTE MUS_DEL_2  +  17 ;@ 987
  .BYTE MUS_DEL_2  +  MUS_REST ;@ 988
  .BYTE MUS_DEL_2  +  17 ;@ 989
  .BYTE MUS_DEL_2  +  MUS_REST ;@ 990
  .BYTE MUS_DEL_3  +  16 ;@ 991
  .BYTE MUS_DEL_1  +  MUS_REST ;@ 992
  .BYTE MUSCMD_JUMP, (MA1_END - MA1_01)  ; Repeat back to top ;@ 993
MA1_END ;@ 994
 ;@ 995
MA_SONG_2 ;@ 996
 ;@ 997
  .BYTE MUSCMD_CONTROL, $0C ;@ 998
  .BYTE MUSCMD_VOLUME,  15 ;@ 999
 ;@ 1000
MA2_01 ;@ 1001
  .BYTE MUS_DEL_1  +  15 ;@ 1002
  .BYTE MUS_DEL_1  +  MUS_REST ;@ 1003
  .BYTE MUS_DEL_1  +  15 ;@ 1004
  .BYTE MUS_DEL_1  +  MUS_REST ;@ 1005
  .BYTE MUS_DEL_2  +  MUS_REST ;@ 1006
  .BYTE MUS_DEL_4  +  7 ;@ 1007
  .BYTE MUS_DEL_4  +  MUS_REST ;@ 1008
  .BYTE MUS_DEL_2  +  15 ;@ 1009
  .BYTE MUS_DEL_4  +  MUS_REST ;@ 1010
  .BYTE MUS_DEL_2  +  12 ;@ 1011
  .BYTE MUS_DEL_2  +  MUS_REST ;@ 1012
  .BYTE MUS_DEL_2  +  15 ;@ 1013
  .BYTE MUS_DEL_2  +  MUS_REST ;@ 1014
  .BYTE MUS_DEL_2  +  17 ;@ 1015
  .BYTE MUS_DEL_2  +  MUS_REST   ;@ 1016
  .BYTE MUSCMD_JUMP, (MA2_END - MA2_01) ;@ 1017
MA2_END ;@ 1018
 ;@ 1019
 ;@ 1020
 ;@ 1021
MUSICB ;@ 1022
 ;@ 1023
MB_SONG_1 ;@ 1024
 ;@ 1025
  .BYTE MUSCMD_CONTROL, $08  ; Control (white noise) ;@ 1026
  .BYTE MUSCMD_VOLUME,  8    ; Volume (half) ;@ 1027
 ;@ 1028
MB1_01      ;@ 1029
  .BYTE MUS_DEL_1  +  10 ;@ 1030
  .BYTE MUS_DEL_1  +  MUS_REST ;@ 1031
  .BYTE MUS_DEL_1  +  20 ;@ 1032
  .BYTE MUS_DEL_1  +  MUS_REST ;@ 1033
  .BYTE MUS_DEL_1  +  30 ;@ 1034
  .BYTE MUS_DEL_1  +  MUS_REST ;@ 1035
  .BYTE MUS_DEL_1  +  15 ;@ 1036
  .BYTE MUS_DEL_1  +  MUS_REST ;@ 1037
  .BYTE MUS_DEL_1  +  10 ;@ 1038
  .BYTE MUS_DEL_1  +  MUS_REST ;@ 1039
  .BYTE MUS_DEL_1  +  20 ;@ 1040
  .BYTE MUS_DEL_1  +  MUS_REST ;@ 1041
  .BYTE MUS_DEL_1  +  30 ;@ 1042
  .BYTE MUS_DEL_1  +  MUS_REST ;@ 1043
  .BYTE MUS_DEL_1  +  15 ;@ 1044
  .BYTE MUS_DEL_1  +  MUS_REST ;@ 1045
  .BYTE MUSCMD_JUMP, (MB1_END - MB1_01) ;@ 1046
MB1_END ;@ 1047
 ;@ 1048
MB_SONG_2 ;@ 1049
 ;@ 1050
  .BYTE MUSCMD_CONTROL, $08 ;@ 1051
  .BYTE MUSCMD_VOLUME,  8 ;@ 1052
 ;@ 1053
MB2_01     ;@ 1054
  .BYTE MUS_DEL_1  +  1 ;@ 1055
  .BYTE MUS_DEL_1  +  MUS_REST ;@ 1056
  .BYTE MUS_DEL_1  +  1 ;@ 1057
  .BYTE MUS_DEL_1  +  MUS_REST ;@ 1058
  .BYTE MUS_DEL_1  +  1 ;@ 1059
  .BYTE MUS_DEL_1  +  MUS_REST ;@ 1060
  .BYTE MUS_DEL_1  +  1 ;@ 1061
  .BYTE MUS_DEL_1  +  MUS_REST ;@ 1062
  .BYTE MUS_DEL_1  +  30 ;@ 1063
  .BYTE MUS_DEL_1  +  MUS_REST ;@ 1064
  .BYTE MUS_DEL_1  +  30 ;@ 1065
  .BYTE MUS_DEL_1  +  MUS_REST ;@ 1066
  .BYTE MUS_DEL_1  +  30 ;@ 1067
  .BYTE MUS_DEL_1  +  MUS_REST ;@ 1068
  .BYTE MUS_DEL_1  +  30 ;@ 1069
  .BYTE MUS_DEL_1  +  MUS_REST ;@ 1070
  .BYTE MUSCMD_JUMP, (MB2_END - MB2_01) ;@ 1071
MB2_END ;@ 1072
 ;@ 1073
 ;@ 1074
; ====================================== ;@ 1075
SKILL_VALUES ;@ 1076
; ;@ 1077
; This table describes how to change the various ;@ 1078
; difficulty parameters as the game progresses. ;@ 1079
; For instance, the second entry in the table  ;@ 1080
; says that when the score is 4, change the values of ;@ 1081
; wall-increment to 1, frame-delay to 2, gap-pattern to 0, ;@ 1082
; MusicA to 24, and MusicB to 22. ;@ 1083
; ;@ 1084
; A 255 on the end of the table indicates the end  ;@ 1085
; ;@ 1086
  ; Wall  Inc  Delay     Gap   MA                 MB ;@ 1087
  .BYTE  0,    1,   3,     0  ,MA_SONG_1-MUSICA , MB_SONG_1-MUSICB ;@ 1088
  .BYTE  4,    1,   2,     0  ,MA_SONG_2-MUSICA , MB_SONG_2-MUSICB ;@ 1089
  .BYTE  8,    1,   1,     0  ,MA_SONG_1-MUSICA , MB_SONG_1-MUSICB ;@ 1090
  .BYTE 16,    1,   1,     1  ,MA_SONG_2-MUSICA , MB_SONG_2-MUSICB ;@ 1091
  .BYTE 24,    1,   1,     3  ,MA_SONG_1-MUSICA , MB_SONG_1-MUSICB ;@ 1092
  .BYTE 32,    1,   1,     7  ,MA_SONG_2-MUSICA , MB_SONG_2-MUSICB ;@ 1093
  .BYTE 40,    1,   1,    15  ,MA_SONG_1-MUSICA , MB_SONG_1-MUSICB ;@ 1094
  .BYTE 48,    2,   1,     0  ,MA_SONG_2-MUSICA , MB_SONG_2-MUSICB ;@ 1095
  .BYTE 64,    2,   1,     1  ,MA_SONG_1-MUSICA , MB_SONG_1-MUSICB ;@ 1096
  .BYTE 80,    2,   1,     3  ,MA_SONG_2-MUSICA , MB_SONG_2-MUSICB ;@ 1097
  .BYTE 96 ,   2,   1,     7  ,MA_SONG_1-MUSICA , MB_SONG_1-MUSICB ;@ 1098
  .BYTE 255 ;@ 1099
 ;@ 1100
; ====================================== ;@ 1101
; Image for players ;@ 1102
GR_PLAYER: ;@ 1103
;<Graphic widthBits="8" heightBits="8" bitDepth="1" name="player">      ;@ 1104
  .BYTE $10 ; ...*.... ;@ 1105
  .BYTE $10 ; ...*.... ;@ 1106
  .BYTE $28 ; ..*.*... ;@ 1107
  .BYTE $28 ; ..*.*... ;@ 1108
  .BYTE $54 ; .*.*.*.. ;@ 1109
  .BYTE $54 ; .*.*.*.. ;@ 1110
  .BYTE $AA ; *.*.*.*. ;@ 1111
  .BYTE $7C ; .*****.. ;@ 1112
;</Graphic> ;@ 1113
 ;@ 1114
; ====================================== ;@ 1115
; Images for numbers ;@ 1116
DIGITS:  ;@ 1117
; We only need 5 rows, but the extra space on the end makes each digit 8 rows, ;@ 1118
; which makes it the multiplication easier. ;@ 1119
;<Graphic widthBits="8" heightBits="8" bitDepth="1" images="10" name="digits"> ;@ 1120
  .BYTE  $0E ,$0A ,$0A ,$0A ,$0E, 0,0,0 ; 00 ;@ 1121
  .BYTE  $22 ,$22 ,$22 ,$22 ,$22, 0,0,0 ; 11 ;@ 1122
  .BYTE  $EE ,$22 ,$EE ,$88 ,$EE, 0,0,0 ; 22 ;@ 1123
  .BYTE  $EE ,$22 ,$66 ,$22 ,$EE, 0,0,0 ; 33 ;@ 1124
  .BYTE  $AA ,$AA ,$EE ,$22 ,$22, 0,0,0 ; 44 ;@ 1125
  .BYTE  $EE ,$88 ,$EE ,$22 ,$EE, 0,0,0 ; 55 ;@ 1126
  .BYTE  $EE ,$88 ,$EE ,$AA ,$EE, 0,0,0 ; 66 ;@ 1127
  .BYTE  $EE ,$22 ,$22 ,$22 ,$22, 0,0,0 ; 77 ;@ 1128
  .BYTE  $EE ,$AA ,$EE ,$AA ,$EE, 0,0,0 ; 88 ;@ 1129
  .BYTE  $EE ,$AA ,$EE ,$22 ,$EE, 0,0,0 ; 99 ;@ 1130
;</Graphic> ;@ 1131
 ;@ 1132
;</EditorTab> ;@ 1133
 ;@ 1134
;<EditorTab name="vectors"> ;@ 1135
; ======================================  ;@ 1136
; 6502 Hardware vectors at the end of memory ;@ 1137
.org $F7FA  ; Ghosting to $FFFA for 2K part ;@ 1138
  .WORD  $0000   ; NMI vector (not used) ;@ 1139
  .WORD  main    ; Reset vector (top of program) ;@ 1140
  .WORD  $0000   ; IRQ vector (not used) ;@ 1141
 ;@ 1142
;</EditorTab> ;@ 1143
 ;@ 1144
.end ;@ 1145
