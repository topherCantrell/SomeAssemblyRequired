
; DoubleGap by Christopher Cantrell 2005
; ccantrell@knology.net

; TO DO
; - Expert switches are backwards
; - Debounce switches

; This file uses the "FLOW" program for assembly pre-processing
processor 6502

#include "Stella.asm" ; Equates to give names to hardware memory locations

;<EditorTab name="RAM">
; ======================================
;
; RAM usage
;
TMP0      .EQU   $80 ; Temporary storage
TMP1      .EQU   $81 ; Temporary storage
TMP2      .EQU   $82 ; Temporary storage
PLAYR0Y   .EQU   $83 ; Player 0's Y location (normal or pro)
PLAYR1Y   .EQU   $84 ; Player 1's Y location (normal, pro, or off)
MUS_TMP0  .EQU   $85 ; Game-over mode sound FX storage (frame delay)
MUS_TMP1  .EQU   $86 ; Game-over mode sound FX storage (frequency)
SCANCNT   .EQU   $87 ; Scanline counter during screen drawing
MODE      .EQU   $88 ; Game mode: 0=GameOver 1=Play 2=Select
WALL_INC  .EQU   $89 ; How much to add to wall's Y position
WALLCNT   .EQU   $8A ; Number of walls passed (score)
WALLDELY  .EQU   $8B ; Wall movement frame skip counter
WALLDELYR .EQU   $8C ; Number of frames to skip between wall increments
ENTROPYA  .EQU   $8D ; Incremeneted with every frame
ENTROPYB  .EQU   $8E ; SWCHA adds in
ENTROPYC  .EQU   $8F ; Left/Right movements added to other entropies
DEBOUNCE  .EQU   $90 ; Last state of the Reset/Select switches
WALLDRELA .EQU   $91 ; PF0 pattern for wall
WALLDRELB .EQU   $92 ; PF1 pattern for wall
WALLDRELC .EQU   $93 ; PF2 pattern for wall
WALLSTART .EQU   $94 ; Wall's Y position (scanline)
WALLHEI   .EQU   $95 ; Height of wall
GAPBITS   .EQU   $96 ; Wall's gap pattern (used to make WALLDRELx)
SCORE_PF1 .EQU   $97 ; 6-bytes. PF1 pattern for each row of the score
SCORE_PF2 .EQU   $9D ; 6-bytes. PF2 pattern for each row of the score
MUSADEL   .EQU   $A3 ; Music A delay count
MUSAIND   .EQU   $A4 ; Music A pointer
MUSAVOL   .EQU   $A5 ; Music A volume
MUSBDEL   .EQU   $A6 ; Music B delay count
MUSBIND   .EQU   $A7 ; Music B pointer
MUSBVOL   .EQU   $A8 ; Music B volume

; Remember, stack builds down from $FF ... leave some space
;
; 80 - A8 ... that's 41 bytes of RAM
;</EditorTab>

  .org $F000

;<EditorTab name="main">
main() {
  SEI        ; Turn off interrupts
  CLD        ; Clear the "decimal" flag
  X = 0xFF   ; Set the stack pointer ...
  S = X      ; ... to the end of RAM
  INIT()          ; Initialize game environment
  INIT_SELMODE()  ; Start out in SELECT-MODE
  VIDEO_KERNEL()  ; No return
}
;</EditorTab>
  
;<EditorTab name="kernel">
VIDEO_KERNEL() {
;  (start here at the END of every frame)
;
  while(true) {

      A = 2          ; D1 bit ON
      WSYNC  = A     ; Wait for the end of the current line
      VBLANK = A     ; Turn the electron beam off
      WSYNC  = A     ; Wait for all ...
      WSYNC  = A     ; ... the electrons ...
      WSYNC  = A     ; ... to drain out.
      VSYNC  = A     ; Trigger the vertical sync signal
      WSYNC  = A     ; Hold the vsync signal for ...
      WSYNC  = A     ; ... three ...
      WSYNC  = A     ; ... scanlines
      HMOVE  = A     ; Move all moving game objects
      A = 0          ; D1 bit OFF
      VSYNC  = A     ; Release the vertical sync signal
      A  = 43        ; Set timer to 43*64 = 2752 machine ...
      TIM64T = A     ; ... cycles 2752/(228/3) = 36 scanlines

      ; ***** LENGTHY GAME LOGIC PROCESSING BEGINS HERE *****

      ; Do one of 3 routines
      ; 0 = Game Over processing
      ; 1 = Playing-Game processing
      ; 2 = Selecting-Game processing

      ++ENTROPYA    ; Counting video frames as part of random number
      A = MODE      ; What are we doing between frames?

      if(A==0) {
          GOMODE()      ; Game-over processing
      } else if(A==1) {
          PLAYMODE()    ; Playing-game processing
      } else {
          SELMODE()     ; Selecting game processing
      }
      
      ; ***** LENGTHY GAME LOGIC PROCESSING ENDS HERE *****

      do {
          A = INTIM   ; Wait for the visible area of the screen
      } while(A!=0);

      WSYNC = A       ; 37th scanline
      A = 0           ; Turn the ...
      VBLANK = A      ; ... electron beam back on
            
      A = 0           ; Zero out ...
      SCANCNT = A     ; ... scanline count ...
      TMP0 = A        ; ... and all ...
      TMP1 = A        ; ... returns ...
      TMP2 = A        ; ... expected ...
      X = A           ; ... to come from ...
      Y = A           ; ... BUILDROW
      CXCLR = A       ; Clear collision detection

      do {

          A = TMP0       ; Get A ready (PF0)
          WSYNC = A      ; Wait for very start of row
          GRP0 = X       ; Player 0 -- in X
          GRP1 = Y       ; Player 1 -- in Y
          PF0 = A        ; PF0      -- in TMP0 (already in A)
          A = TMP1       ; PF1      -- in TMP1
          PF1 = A        ; ...
          A = TMP2       ; PP2      -- in TMP2
          PF2 = A        ; ...

          BUILDROW()     ; This MUST take through to the next line

          ++SCANCNT      ; Next scan line
          A = SCANCNT    ; Do 109*2 = 218 lines

      } while(A!=109);      

      A = 0          ; Turning off visuals
      WSYNC = A      ; Next scanline
      PF0 = A        ; Play field 0 off
      GRP0 = A       ; Player 0 off
      GRP1 = A       ; Player 1 off
      PF1 = A        ; Play field 1 off
      PF2 = A        ; Play field 2 off
      WSYNC = A      ; Next scanline
      
  }

}

; ======================================

BUILDROW() {        
  
  LDA  SCANCNT    ; Current scanline

  if(A<6) {     ; Top 6 rows are for the score

      AND  #7     ; Only need the lower 3 bits
      TAY         ; Soon to be an index into a list

      ; At this point, the beam is past the loading of the
      ; playfield for the left half. We want to make sure
      ; that the right half of the playfield is off, so do that
      ; now.

      LDX  #0     ; Blank bit pattern
      STX  TMP0   ; This will always be blank
      STX  PF1    ; Turn off playfield ...
      STX  PF2    ; ... for right half of the screen
      
      TAX               ; Another index
      LDA  SCORE_PF1,Y  ; Lookup the PF1 graphics for this row
      STA  TMP1         ; Return it to the caller
      TAY               ; We'll need this value again in a second
      LDA  SCORE_PF2,X  ; Lookup the PF2 graphics for this row
      STA  TMP2         ; Return it to the caller
      
      STA  WSYNC  ; Now on the next row
      
      STY  PF1    ; Repeat the left-side playfield ...
      STA  PF2    ; ... onto the new row

      LDA  SCORE_PF2,X  ; Kill some time
      LDA  SCORE_PF2,X  ; 
      LDA  SCORE_PF2,X  ; 
      LDA  SCORE_PF2,X  ; 
      LDA  SCORE_PF2,X  ; 
      LDA  SCORE_PF2,X  ; 

      LDX  #0     ; Return 0 (off) for player 0 ...
      LDY  #0     ; ... and player 1

      ; The beam is past the left half of the field again.
      ; Turn off the playfield.

      STX  PF1    ; 0 to PF1 ...
      STX  PF2    ; ... and PF2

  } else {
      
      AND  #7           ; Lower 3 bits as an index again
      TAY               ; Using Y to lookup graphics
      LDA  GR_PLAYER,Y  ; Get the graphics (if enabled on this row)
      TAX               ; Hold it (for return as player 0)
      TAY               ; Hold it (for return as player 1)
      LDA  SCANCNT      ; Scanline count again
      LSR  A            ; This time ...
      LSR  A            ; ... we divide ...
      LSR  A            ; ... by eight (8 rows in picture)

      if(A!=PLAYR0Y) {
          LDX  #0       ; Not time for Player 0 ... no graphics
      }

      if(A!=PLAYR1Y) {
          LDY  #0       ; Not time for Player 0 ... no graphics
      }

      LDA  WALLSTART    ; Calculate ...
      CLC               ; ... the ...
      ADC  WALLHEI      ; ... end row of ...
      STA  TMP0         ; ... the wall

      LDA  SCANCNT      ; Scanline count

      if(A>=WALLSTART && A<TMP0) {
          LDA  WALLDRELA     ; Draw wall ...
          STA  TMP0          ; ... by transfering ...
          LDA  WALLDRELB     ; ... playfield ...
          STA  TMP1          ; ... patterns ...
          LDA  WALLDRELC     ; ... to ...
          STA  TMP2          ; ... return area
      } else {
          LDA  #0            ; No walls on this row
          STA  TMP0          ; ... clear ...
          STA  TMP1          ; ... out ...
          STA  TMP2          ; ... the playfield
      }
      
  }
  
}
;</EditorTab>

; ============= END OF VIDEO KERNEL ===================


; ======================================
;<EditorTab name="init">
INIT() {          
;
; This function is called ONCE at power-up/reset to initialize various
; hardware and temporaries.
;
  LDA  #$40        ; Playfield ...
  STA  COLUPF      ; ... redish
  LDA  #$7E        ; Player 0 ...
  STA  COLUP0      ; ... white
  LDA  #0          ; Player 1 ...
  STA  COLUP1      ; ... black

  LDA  #5          ; Right half of playfield is reflection of left ...
  STA  CTRLPF      ; ... and playfield is on top of players

  LDX  #4          ; Player 0 position count
  LDY  #3          ; Player 1 position count
  STA  WSYNC       ; Get a fresh scanline

  do {
      DEX          ; Kill time while the beam moves 
  } while(X!=0);
  STA  RESP0       ; Mark player 0's X position

  do {
      DEY          ; Kill more time
  } while(Y!=0);
  STA  RESP1       ; Mark player 1's X position

  EXPERTISE()   ; Initialize the players' Y positions
  
  LDA  #10         ; Wall is ...
  STA  WALLHEI     ; ... 10 double-scanlines high
  
  LDA  #0          ; Set score to ...
  STA  WALLCNT     ; ... 0
  MAKE_SCORE()  ; Blank the score digits
  LDA  #0          ; Blank bits ...
  STA  SCORE_PF2+5 ; ... on the end of each ...
  STA  SCORE_PF1+5 ; ... digit pattern

  ADJUST_DIF()  ; Initialize the wall parameters
  NEW_GAPS()    ; Build the wall's initial gap
  
  LDA  #112        ; Set wall position off bottom ...
  STA  WALLSTART   ; ... to force a restart on first move

  LDA  #0          ; Zero out ...
  STA  HMP0        ; ... player 0 motion ...
  STA  HMP1        ; ... and player 1 motion
  
}
;</EditorTab>

; ===================================
;<EditorTab name="play-mode">
INIT_PLAYMODE() {
;
; This function initializes the game play mode
;
  LDA  #$C0       ; Background color ...
  STA  COLUBK     ; ... greenish
  LDA  #1         ; Game mode is ...
  STA  MODE       ; ... SELECT
  LDA  #255       ; Restart wall score to ...
  STA  WALLCNT    ; ... 0 on first move
  LDA  #112       ; Force wall to start ...
  STA  WALLSTART  ; ... over on first move
  INIT_MUSIC()    ; Initialize the music
}

; ======================================
PLAYMODE() {  
;
; This function is called once per frame to process the main game play.
;
  
  SEL_RESET_CHK() ; Check to see if Reset/Select has changed

  if(A!=0) {         ; A!=0 if reset/select has been toggled
      STX  DEBOUNCE      ; Restore the old value ...
      INIT_SELMODE()  ; ... and let select-mode process the toggle
      return
  }
  
  PROCESS_MUSIC() ; Process any playing music
  MOVE_WALLS()    ; Move the walls

  if(A==1) {        ; A==1 if wall reached bottom
      INC  WALLCNT       ; Bump the score
      ADJUST_DIF()    ; Change the wall parameters based on score
      LDA  WALLCNT       ; Change the ...
      MAKE_SCORE()    ; ... score pattern
      NEW_GAPS()      ; Calculate the new gap position
  }

  LDA  CXP0FB  ; Player 0 collision with playfield
  STA  TMP0    ; Hold it
  LDA  CXP1FB  ; Player 1 collision with playfield
  ORA  TMP0    ; Did either ...
  AND  #$80    ; ... player collide with wall?

  if(A!=0) {
      INIT_GOMODE()  ; Go to Game-Over mode
      return
  }

  LDA  SWCHA     ; Joystick
  ADC  ENTROPYB  ; Add to ...
  STA  ENTROPYB  ; ... entropy

  LDA  SWCHA     ; Joystick
  AND  #$80      ; Player 0 left switch
  if(A==0) {     ; A==0 if joystick-left
      LDA  #$F0    ; Moving left value
  } else {
      LDA  SWCHA     ; Joystick
      AND  #$40      ; Player 0 right switch
      if(A==0) {         ; A==0 if joystick-right
          INC  ENTROPYC    ; Yes ... increase entropy
          LDA  #$10        ; Moving right value
      } else {
          LDA  #0          ; Not moving value
      }
  }
  STA  HMP0      ; New movement value P0

  LDA  SWCHA     ; Joystick
  AND  #$08      ; Player 1 left switch
  if(A==0) {
      LDA  #$F0    ; Moving left value
  } else {
      LDA  SWCHA     ; Joystick
      AND  #$04      ; Player 1 right switch
      if(A==0) {
          LDA  #$10        ; Moving right value
      } else {
          INC  ENTROPYC    ; Increase entropy
          LDA  #0          ; Not moving value
      }
  }
  STA  HMP1      ; New movement value P1

}
;</EditorTab>

; ===================================
;<EditorTab name="select-mode">
INIT_SELMODE() {
;
; This function initializes the games SELECT-MODE
;          
  LDA  #0        ; Turn off ...
  STA  AUDV0     ; ... all ...
  STA  AUDV1     ; ... sound
  LDA  #$C8      ; Background color ...
  STA  COLUBK    ; ... greenish bright
  LDA  #2        ; Now in ...
  STA  MODE      ; SELECT game mode
}

; ======================================
SELMODE() {
;
; This function is called once per frame to process the SELECT-MODE.
; The wall moves here, but doesn't change or collide with players.
; This function selects between 1 and 2 player game.
;
  MOVE_WALLS()    ; Move the walls
  SEL_RESET_CHK() ; Check the reset/select switches
  
  if(A==1 || A==3) {
      INIT_PLAYMODE()  ; Reset toggled ... start game
  } else if(A==2) {
      LDA  PLAYR1Y        ; Select toggled. Get player 1 Y coordinate
      if(A==255) {
          LDA  #12        ; Onscreen if it is currently off
      } else {
          LDA  #255       ; Offscreen if it is currently on
      }
      STA  PLAYR1Y        ; Toggled Y coordinate
  }

  EXPERTISE()     ; Adjust both players for pro settings
}
;</EditorTab>

; ======================================
;<EditorTab name="go-mode">
INIT_GOMODE() {
;
; This function initializes the GAME-OVER game mode.
;   
  STA  HMCLR     ; Stop both players from moving
  LDA  CXP0FB    ; P0 collision with wall
  AND  #$80      ; Did player 0 collide?

  if(A==0) {
      LDA  #2        ; No ... move player 0 ...
      STA  PLAYR0Y   ; ... up the screen
  }

  LDA  CXP1FB    ; P1 collision with wall
  AND  #$80      ; Did player 1 collide?

  if(A==0 ) {
      LDA  PLAYR1Y
      if(A!=255) { 
          LDA  #2        ; Player 1 is onscreen and didn't collide ...
          STA  PLAYR1Y   ; ... move up the screen
      }
  }

  LDA  #0         ; Going to ...
  STA  MODE       ; ... game-over mode
  STA  AUDV0      ; Turn off any ...
  STA  AUDV1      ; ... sound
  INIT_GO_FX() ; Initialize sound effects
}

; ======================================
GOMODE() {
;
; This function is called every frame to process the game
; over sequence. When the sound effect has finished, the
; game switches to select mode.
;
  PROCESS_GO_FX() ; Process the sound effects
  if(A!=0) {
      INIT_SELMODE()  ; When effect is over, go to select mode
  }
}   ; Keep coming back till the effect is over
;</EditorTab>

; ======================================
;<EditorMode name="utils">
MOVE_WALLS() {
;
; This function moves the wall down the screen and back to position 0
; when it reaches (or passes) 112.
;
;
  DEC  WALLDELY     ; Time to move the wall
  LDA  WALLDELY

  if(A!=0) {            ; A!=0 if still delaying wall movement
      LDA  #0           ; Return flag that wall did NOT restart
  } else {
      LDA  WALLDELYR    ; Reset the ...
      STA  WALLDELY     ; ... delay count
      LDA  WALLSTART    ; Current wall position
      CLC               ; No accidental carry
      ADC  WALL_INC     ; Increment wall position
      if(A<112) {     ; A>=112 if wall is off screen
          STA  WALLSTART    ; Store new wall position
          LDA  #0           ; Return flag that wall did NOT restart
      } else {
          LDA  #0            ; Else restart ...
          STA  WALLSTART    ; ... wall at top of screen
          LDA  #1           ; Return flag that wall DID restart
      }
  }
  
}

; ======================================
NEW_GAPS() {
;
; This function builds the PF0, PF1, and PF2 graphics for a wall
; with the gap pattern (GAPBITS) placed at random in the 20 bit
; area.
;
  LDA  #255       ; Start with ...
  STA  WALLDRELA  ; ... solid wall in PF0 ...
  STA  WALLDRELB  ; ... and PF1
  LDA  GAPBITS    ; Store the gap pattern ...
  STA  WALLDRELC  ; ... in PF2
  
  LDA  ENTROPYA   ; Get ...
  ADC  ENTROPYB   ; ... a randomish ...
  ADC  ENTROPYC   ; ... number ...
  STA  ENTROPYC   ; ... from ...
  AND  #15        ; ... 0 to 15

  if(A>12) {
      SBC  #9     ; Actually, we want it from 0-11
  }
  
  while(A!=0) {
      SEC             ; Roll gap ...
      ROR  WALLDRELC  ; ... left ...
      ROL  WALLDRELB  ; ... desired ...
      ROR  WALLDRELA  ; ... times ...
      SEC             ; ... and roll ...
      SBC  #1         ; ... a 1 (solid) ...
  }

}

; ======================================
MAKE_SCORE() {
;
; This function builds the PF1 and PF2 graphics rows for
; the byte value passed in A. The current implementation is
; two-digits only ... PF2 is blank.
;
  LDX  #0    ; 100's digit
  LDY  #0    ; 10's digit

  while(A>=100) {
      INX          ; Count ...
      SEC          ; ... the 100s...
      SBC  #100    ; ... value
  }

  while(A>=10) {
      INY          ; Count ...
      SEC          ; ... the 10s ...
	  SBC  #10     ; ... value
  }

  ASL  A     ; One's digit ...
  ASL  A     ; ... *8 ....
  ASL  A     ; ... to find picture
  TAX        ; One's digit picture to X
  TYA        ; Now the 10's digit
  ASL  A     ; Multiply ...
  ASL  A     ; ... by 8 ...
  ASL  A     ; ... to find picture
  TAY        ; 10's picture in Y
  
  LDA  DIGITS,Y  ; Get the 10's digit
  AND  #$F0      ; Only use the left side of the picture
  STA  SCORE_PF1 ; Store left side
  LDA  DIGITS,X  ; Get the 1's digit
  AND  #$0F      ; Only use the right side of the picture
  ORA  SCORE_PF1 ; Put left and right half together
  STA  SCORE_PF1 ; And store image

  LDA  DIGITS+1,Y ; Repeat for 2nd line of picture
  AND  #$F0
  STA  SCORE_PF1+1
  LDA  DIGITS+1,X
  AND  #$0F
  ORA  SCORE_PF1+1
  STA  SCORE_PF1+1

  LDA  DIGITS+2,Y ; Repeat for 3nd line of picture
  AND  #$F0
  STA  SCORE_PF1+2
  LDA  DIGITS+2,X
  AND  #$0F
  ORA  SCORE_PF1+2
  STA  SCORE_PF1+2

  LDA  DIGITS+3,Y ; Repeat for 4th line of picture
  AND  #$F0
  STA  SCORE_PF1+3
  LDA  DIGITS+3,X
  AND  #$0F
  ORA  SCORE_PF1+3
  STA  SCORE_PF1+3

  LDA  DIGITS+4,Y ; Repeat for 5th line of picture
  AND  #$F0
  STA  SCORE_PF1+4
  LDA  DIGITS+4,X
  AND  #$0F
  ORA  SCORE_PF1+4
  STA  SCORE_PF1+4

  LDA  #0           ; For now ...
  STA  SCORE_PF2   ; ... there ...
  STA  SCORE_PF2+1 ; ... is ...
  STA  SCORE_PF2+2 ; ... no ...
  STA  SCORE_PF2+3 ; ... 100s ...
  STA  SCORE_PF2+4 ; ... digit drawn

}

; ======================================
EXPERTISE() {
;
; This function changes the Y position of the players based on the
; position of their respective pro/novice switches. The player 1
; position is NOT changed if the mode is a single-player game.
;
  LDA  SWCHB   ; Pro/novice settings
  AND  #$80    ; Novice for Player 0?
  if(A==0) {
      LDA  #12  ; Novice ... near the bottom
  } else {
      LDA  #8   ; Pro ... near the top
  }
  STA  PLAYR0Y ; ... to Player 0
  
  LDX  PLAYR1Y
  if(X!=255) {  ; Only move player 1 if it is a 2-player game
      LDA  SWCHB
      AND  #$40
      if(A==0) {
          LDX  #12  ; Novice ... near the bottom
      } else {
          LDX  #8   ; Pro ... near the top
      }
      STX  PLAYR1Y
  }

}

; ======================================
ADJUST_DIF() {
;
; This function adjusts the wall game difficulty values based on the
; current score. The music can also change with the difficulty. A single
; table describes the new values and when they take effect.
;              
  LDX  #0  ; Starting at index 0

  while(true) {

      LDA  SKILL_VALUES,X  ; Get the score match
      if(A==255) {
          return         ; End of the table ... leave it alone
      }
      if(A==WALLCNT) {
          INX                 ; Copy ...
          LDA  SKILL_VALUES,X ; ... new ...
          STA  WALL_INC       ; ... wall increment
          INX                 ; Copy ...
          LDA  SKILL_VALUES,X ; ... new ...
          STA  WALLDELY       ; ... wall ...
          STA  WALLDELYR      ; ... delay
          INX                 ; Copy ...
          LDA  SKILL_VALUES,X ; ... new ...
          STA  GAPBITS        ; ... gap pattern
          INX                 ; Copy ...
          LDA  SKILL_VALUES,X ; ... new ...
          STA  MUSAIND        ; ... MusicA index
          INX                 ; Copy ...
          LDA  SKILL_VALUES,X ; ... new ...
          STA  MUSBIND        ; ... MusicB index
          LDA  #1             ; Force ...
          STA  MUSADEL        ; ... music to ...
          STA  MUSBDEL        ; ... start new
          return
      }
      
      INX     ; Move ...
      INX     ; ... X ...
      INX     ; ... to ...
      INX     ; ... next ...
      INX     ; ... row of ...
      INX     ; ... table
  }
}  

; ======================================
SEL_RESET_CHK() {
;
; This function checks for changes to the reset/select
; switches and debounces the transitions.
;
  
  LDX  DEBOUNCE  ; Hold onto old value
  LDA  SWCHB     ; New value
  AND  #3         ; Only need bottom 2 bits

  if(A==DEBOUNCE) {
      LDA  #0        ; Return 0 ... nothing changed
  } else {
      STA  DEBOUNCE  ; Hold new value
      EOR  #$FF      ; Complement the value (active low hardware)
      AND  #3        ; Only need select/reset
  }
  
}
;</EditorTab>

; ======================================
;<EditorTab name="sound">
INIT_MUSIC() {
;
; This function initializes the hardware and temporaries
; for 2-channel music
;
  LDA  #$06    ; Initialize sound ...
  STA  AUDC0   ; ... to pure ...
  STA  AUDC1   ; ... tones
  LDA  #0      ; Turn off ...
  STA  AUDV0   ; ... all ...
  STA  AUDV1   ; ... sound
  STA  MUSAIND ; Music pointers ...
  STA  MUSBIND ; ... to top of data
  LDA  #1      ; Force ...
  STA  MUSADEL ; ... music ...
  STA  MUSBDEL ; ... reload
  LDA  #15     ; Set volume levels ...
  STA  MUSAVOL ; ... to ...
  STA  MUSBVOL ; ... maximum
}

; ======================================
PROCESS_MUSIC() {
;
; This function is called once per frame to process the
; 2 channel music. Two tables contain the commands/notes
; for individual channels. This function changes the
; notes at the right time.
;           
  DEC  MUSADEL   ; Last note ended?
  if(ZERO-SET) {

      do {
          LDX  MUSAIND   ; Voice-A index
          LDA  MUSICA,X  ; Get the next music command
          if(A==0) {  ; A==0 for JUMP command
              INX            ; Point to jump value
              TXA            ; X to ...
              TAY            ; ... Y (pointer to jump value)
              INX            ; Point one past jump value
              TXA            ; Into A so we can subtract
              SEC            ; No accidental borrow
              SBC  MUSICA,Y  ; New index
              STA  MUSAIND   ; Store it
              LDA  #0        ; Continue processing
          } else if(A==1) {  ; A==1 for CONTROL command
              INX            ; Point to the control value
              INC  MUSAIND   ; Bump the music pointer
              LDA  MUSICA,X  ; Get the control value
              INC  MUSAIND   ; Bump the music pointer
              STA  AUDC0     ; Store the new control value
              LDA  #0        ; Continue processing
          } else if(A==2) {  ; A==2 for VOLUME command
              INX            ; Point to volume value
              INC  MUSAIND   ; Bump the music pointer
              LDA  MUSICA,X  ; Get the volume value
              INC  MUSAIND   ; Bump the music pointer
              STA  MUSAVOL   ; Store the new volume value
              LDA  #0        ; Continue processing
          }
      } while(A==0);

      LDY  MUSAVOL   ; Get the volume
      AND  #31       ; Lower 5 bits are frequency
      if(A==31) {
          LDY  #0      ; Frequency of 31 flags silence
      }
      STA  AUDF0     ; Store the frequency
      STY  AUDV0     ; Store the volume
      LDA  MUSICA,X  ; Get the note value again
      INC  MUSAIND   ; Bump to the next command
      ROR  A         ; The upper ...
      ROR  A         ; ... three ...
      ROR  A         ; ... bits ...
      ROR  A         ; ... hold ...
      ROR  A         ; ... the ...
      AND  #7        ; ... delay
      CLC            ; No accidental carry
      ROL  A         ; Every delay tick ...
      ROL  A         ; ... is *4 frames
      STA  MUSADEL   ; Store the note delay
  }
  
  DEC  MUSBDEL   ; Repeat Channel A sequence for Channel B
  if(ZERO-SET) {
      
      do {
          LDX  MUSBIND
          LDA  MUSICB,X
          if(A==0) {
              INX  
              TXA     
              TAY     
              INX     
              TXA         
              SEC            
              SBC  MUSICB,Y  
              STA  MUSBIND   
              LDA  #0
          } else if(A==1) {
              INX           
              INC  MUSBIND  
              LDA  MUSICB,X 
              INC  MUSBIND   
              STA  AUDC1    
              LDA  #0
          } else if(A==2) {
              INX            
              INC  MUSBIND   
              LDA  MUSICB,X 
              INC  MUSBIND  
              STA  MUSBVOL  
              LDA  #0
              }
      } while(A==0);

      LDY  MUSBVOL
      AND  #31
      if(A==31) {
          LDY  #0
      }
      STA  AUDF1
      STY  AUDV1
      LDA  MUSICB,X
      INC  MUSBIND
      ROR  A
      ROR  A
      ROR  A
      ROR  A
      ROR  A
      AND  #7
      CLC
      ROL  A
      ROL  A
      STA  MUSBDEL
  }
}

; ======================================
INIT_GO_FX() {
;
; This function initializes the hardware and temporaries
; to play the soundeffect of a player hitting the wall
;
  LDA  #5       ; Set counter for frame delay ...
  STA  MUS_TMP1 ; ... between frequency change
  LDA  #3       ; Tone type ...
  STA  AUDC0    ; ... poly tone
  LDA  #15      ; Volume A ...
  STA  AUDV0    ; ... to max
  LDA  #0       ; Volume B ...
  STA  AUDV1    ; ... silence
  LDA  #240     ; Initial ...
  STA  MUS_TMP0 ; ... sound ...
  STA  AUDF0    ; ... frequency
}

; ======================================
PROCESS_GO_FX() {
;
; This function is called once per scanline to play the
; soundeffects of a player hitting the wall.
;        
  DEC   MUS_TMP1 ; Time to change the frequency?
  if(ZERO-SET) {
      LDA   #5       ; Reload ...
      STA   MUS_TMP1 ; ... the frame count
      INC   MUS_TMP0 ; Increment ...
      LDA   MUS_TMP0 ; ... the frequency divisor
      STA   AUDF0    ; Change the frequency
      if(A==0) {
          LDA   #1       ; All done ... return 1
          return
      }
  }
  LDA   #0
  
}
;</EditorTab>

;</EditorTab name="data">
; ======================================
; Music commands for Channel A and Channel B
  
  ; A word on music and wall timing ...

  ; Wall moves between scanlines 0 and 111 (112 total)

  ; Wall-increment   frames-to-top
  ;      3             336
  ;      2             224
  ;      1             112
  ;     0.5             56  ; Ah ... but we are getting one less
  
  ; Each tick is multiplied by 4 to yield 4 frames per tick
  ; 32 ticks/song = 32*4 = 128 frames / song

  ; We want songs to start with wall at top ...

  ; Find the least-common-multiple
  ; 336 and 128 : 2688 8 walls, 21 musics
  ; 224 and 128 :  896 4 walls,  7 musics
  ; 112 and 128 :  896 8 walls,  7 musics
  ;  56 and 128 :  896 16 walls, 7 musics

  ; Wall moving every other gives us 112*2=224 scanlines
  ; Song and wall are at start every 4
  ; 1 scanline, every 8
  ; Wall delay=3 gives us 128*3=336 scanlines 2

; MUSIC EQUATES
;
MUSCMD_JUMP    .equ 0
MUSCMD_CONTROL .equ 1
MUSCMD_VOLUME  .equ 2
MUS_REST       .equ 31
MUS_DEL_1      .equ 32*1
MUS_DEL_2      .equ 32*2
MUS_DEL_3      .equ 32*3
MUS_DEL_4      .equ 32*4



MUSICA

MA_SONG_1

  .BYTE MUSCMD_CONTROL, $0C  ; Control (pure tone)
  .BYTE MUSCMD_VOLUME,  15   ; Volume (full)

MA1_01
  .BYTE MUS_DEL_3  +  15
  .BYTE MUS_DEL_1  +  MUS_REST
  .BYTE MUS_DEL_3  +  15
  .BYTE MUS_DEL_1  +  MUS_REST
  .BYTE MUS_DEL_1  +  7
  .BYTE MUS_DEL_1  +  MUS_REST
  .BYTE MUS_DEL_1  +  7
  .BYTE MUS_DEL_1  +  MUS_REST
  .BYTE MUS_DEL_2  +  MUS_REST
  .BYTE MUS_DEL_1  +  8
  .BYTE MUS_DEL_1  +  MUS_REST
  .BYTE MUS_DEL_4  +  MUS_REST
  .BYTE MUS_DEL_2  +  17
  .BYTE MUS_DEL_2  +  MUS_REST
  .BYTE MUS_DEL_2  +  17
  .BYTE MUS_DEL_2  +  MUS_REST
  .BYTE MUS_DEL_3  +  16
  .BYTE MUS_DEL_1  +  MUS_REST
  .BYTE MUSCMD_JUMP, (MA1_END - MA1_01)  ; Repeat back to top
MA1_END

MA_SONG_2

  .BYTE MUSCMD_CONTROL, $0C
  .BYTE MUSCMD_VOLUME,  15

MA2_01
  .BYTE MUS_DEL_1  +  15
  .BYTE MUS_DEL_1  +  MUS_REST
  .BYTE MUS_DEL_1  +  15
  .BYTE MUS_DEL_1  +  MUS_REST
  .BYTE MUS_DEL_2  +  MUS_REST
  .BYTE MUS_DEL_4  +  7
  .BYTE MUS_DEL_4  +  MUS_REST
  .BYTE MUS_DEL_2  +  15
  .BYTE MUS_DEL_4  +  MUS_REST
  .BYTE MUS_DEL_2  +  12
  .BYTE MUS_DEL_2  +  MUS_REST
  .BYTE MUS_DEL_2  +  15
  .BYTE MUS_DEL_2  +  MUS_REST
  .BYTE MUS_DEL_2  +  17
  .BYTE MUS_DEL_2  +  MUS_REST  
  .BYTE MUSCMD_JUMP, (MA2_END - MA2_01) ; Repeat back to top
MA2_END



MUSICB

MB_SONG_1

  .BYTE MUSCMD_CONTROL, $08  ; Control (white noise)
  .BYTE MUSCMD_VOLUME,  8    ; Volume (half)

MB1_01     
  .BYTE MUS_DEL_1  +  10
  .BYTE MUS_DEL_1  +  MUS_REST
  .BYTE MUS_DEL_1  +  20
  .BYTE MUS_DEL_1  +  MUS_REST
  .BYTE MUS_DEL_1  +  30
  .BYTE MUS_DEL_1  +  MUS_REST
  .BYTE MUS_DEL_1  +  15
  .BYTE MUS_DEL_1  +  MUS_REST
  .BYTE MUS_DEL_1  +  10
  .BYTE MUS_DEL_1  +  MUS_REST
  .BYTE MUS_DEL_1  +  20
  .BYTE MUS_DEL_1  +  MUS_REST
  .BYTE MUS_DEL_1  +  30
  .BYTE MUS_DEL_1  +  MUS_REST
  .BYTE MUS_DEL_1  +  15
  .BYTE MUS_DEL_1  +  MUS_REST
  .BYTE MUSCMD_JUMP, (MB1_END - MB1_01) ; Repeat back to top
MB1_END

MB_SONG_2

  .BYTE MUSCMD_CONTROL, $08
  .BYTE MUSCMD_VOLUME,  8

MB2_01    
  .BYTE MUS_DEL_1  +  1
  .BYTE MUS_DEL_1  +  MUS_REST
  .BYTE MUS_DEL_1  +  1
  .BYTE MUS_DEL_1  +  MUS_REST
  .BYTE MUS_DEL_1  +  1
  .BYTE MUS_DEL_1  +  MUS_REST
  .BYTE MUS_DEL_1  +  1
  .BYTE MUS_DEL_1  +  MUS_REST
  .BYTE MUS_DEL_1  +  30
  .BYTE MUS_DEL_1  +  MUS_REST
  .BYTE MUS_DEL_1  +  30
  .BYTE MUS_DEL_1  +  MUS_REST
  .BYTE MUS_DEL_1  +  30
  .BYTE MUS_DEL_1  +  MUS_REST
  .BYTE MUS_DEL_1  +  30
  .BYTE MUS_DEL_1  +  MUS_REST
  .BYTE MUSCMD_JUMP, (MB2_END - MB2_01) ; Repeat back to top
MB2_END


; ======================================
SKILL_VALUES
;
; This table describes how to change the various
; difficulty parameters as the game progresses.
; For instance, the second entry in the table 
; says that when the score is 4, change the values of
; wall-increment to 1, frame-delay to 2, gap-pattern to 0,
; MusicA to 24, and MusicB to 22.
;
; A 255 on the end of the table indicates the end 
;
  ; Wall  Inc  Delay     Gap   MA                 MB
  .BYTE  0,    1,   3,     0  ,MA_SONG_1-MUSICA , MB_SONG_1-MUSICB
  .BYTE  4,    1,   2,     0  ,MA_SONG_2-MUSICA , MB_SONG_2-MUSICB
  .BYTE  8,    1,   1,     0  ,MA_SONG_1-MUSICA , MB_SONG_1-MUSICB
  .BYTE 16,    1,   1,     1  ,MA_SONG_2-MUSICA , MB_SONG_2-MUSICB
  .BYTE 24,    1,   1,     3  ,MA_SONG_1-MUSICA , MB_SONG_1-MUSICB
  .BYTE 32,    1,   1,     7  ,MA_SONG_2-MUSICA , MB_SONG_2-MUSICB
  .BYTE 40,    1,   1,    15  ,MA_SONG_1-MUSICA , MB_SONG_1-MUSICB
  .BYTE 48,    2,   1,     0  ,MA_SONG_2-MUSICA , MB_SONG_2-MUSICB
  .BYTE 64,    2,   1,     1  ,MA_SONG_1-MUSICA , MB_SONG_1-MUSICB
  .BYTE 80,    2,   1,     3  ,MA_SONG_2-MUSICA , MB_SONG_2-MUSICB
  .BYTE 96 ,   2,   1,     7  ,MA_SONG_1-MUSICA , MB_SONG_1-MUSICB
  .BYTE 255

; ======================================
; Image for players
GR_PLAYER:
;<Graphic widthBits="8" heightBits="8" bitDepth="1" name="player">     
  .BYTE $10 ; ...*....
  .BYTE $10 ; ...*....
  .BYTE $28 ; ..*.*...
  .BYTE $28 ; ..*.*...
  .BYTE $54 ; .*.*.*..
  .BYTE $54 ; .*.*.*..
  .BYTE $AA ; *.*.*.*.
  .BYTE $7C ; .*****..
;</Graphic>

; ======================================
; Images for numbers
DIGITS: 
; We only need 5 rows, but the extra space on the end makes each digit 8 rows,
; which makes it the multiplication easier.
;<Graphic widthBits="8" heightBits="8" bitDepth="1" images="10" name="digits">
  .BYTE  $0E ,$0A ,$0A ,$0A ,$0E, 0,0,0 ; 00
  .BYTE  $22 ,$22 ,$22 ,$22 ,$22, 0,0,0 ; 11
  .BYTE  $EE ,$22 ,$EE ,$88 ,$EE, 0,0,0 ; 22
  .BYTE  $EE ,$22 ,$66 ,$22 ,$EE, 0,0,0 ; 33
  .BYTE  $AA ,$AA ,$EE ,$22 ,$22, 0,0,0 ; 44
  .BYTE  $EE ,$88 ,$EE ,$22 ,$EE, 0,0,0 ; 55
  .BYTE  $EE ,$88 ,$EE ,$AA ,$EE, 0,0,0 ; 66
  .BYTE  $EE ,$22 ,$22 ,$22 ,$22, 0,0,0 ; 77
  .BYTE  $EE ,$AA ,$EE ,$AA ,$EE, 0,0,0 ; 88
  .BYTE  $EE ,$AA ,$EE ,$22 ,$EE, 0,0,0 ; 99
;</Graphic>

;</EditorTab>

;<EditorTab name="vectors">
; ====================================== 
; 6502 Hardware vectors at the end of memory
.org $F7FA  ; Ghosting to $FFFA for 2K part
  .WORD  $0000   ; NMI vector (not used)
  .WORD  main    ; Reset vector (top of program)
  .WORD  $0000   ; IRQ vector (not used)

;</EditorTab>

.end
