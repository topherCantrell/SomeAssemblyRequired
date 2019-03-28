
; Assemble the Z80 to binary
;@build tools.assembler.Assembler test.asm test.bin -list

; Create a SPIN file with the binary embedded
;@build tools.propeller.BinToSpin test.bin data.spin

; Start the new code running on the propeller
;@build tools.propeller.RunNewCode test.bin

define CPU = Z80


define S_1D =  0x20
define S_1U =  0x40
define S_10D = 0x30
define S_10U = 0x80
define S_HIA = 0xA0
define S_HIB = 0x90
define S_LOA = 0x20
define S_LOB = 0x08

define S_WA = 0x40
define S_WB = 0x48

; Hardware ports:
;   0 (output only) Left digit: hgfedcba 
;   1 (output only) Right digit:  hgfedcba  
;   2 (output onlu) Frequency 00-off FF-high
;   3 (input only)  Switches:      ---54321  (CCW from bottom right)

; The memory map is 8K (0000-1FFF) RAM with the program loaded automatically
; starting at 0000.
;
; 0000-0FFF Program
; 1000-1FFF RAM (stack and variables)

address MyNumber = 0x1000 byte
address another = * byte
address again = * word
address test1 = >0x10 byte
address test2 = * byte
address test3 = * word

   
   ;There are rules you must know. port[x] ... x can only be a number or C. After the = can only be A. There are outd helpers.
   ; Talk about the problems here ... remembering that this mangles A. Compiler keeps up
   ; with it and knows that the second instruction has the same A (255).
   ; Must know the stack builds by decrement and decrements first
   
   ; TODO color nnnnnn()
   ;      color mem[xxxx] and port[xxxx]
   ;      add GOTO and RETURN to keywords
  
0000: ; Z80 starts up at location 0000

  SP = 0x2000         ; Initialize the stack to the end of RAM 
     
  do {
    splash()             ; Splash mode attracts the player to the game
    
    A = C                ; Copy randomized C ...
    MyNumber = A         ; ... to computer's number   
      ; mem[MyNumber] = C
      
    playGame()           ; Play a game
  } while(true)
     
; ----------------------------------------------------------------------------
; This function flashes Hi/Lo on the display and waits for the player to press
; any button to start a game. Througout the splash routine the C register is
; randomized from 00 to 99. The exact value depends on how long the player takes
; to press a button.
;   @return C a random value from 00 to 99
;           
splash:

  A = 0                ; Stop ...
  port[2] = A          ; ... any sounds

  waitNoButton()       ; Wait for all buttons up
     
  do {        

    showHi()             ; Show "Hi"   
    H = 0x80             ; Wait for button or ...
    waitButtonTime()     ; ... timeout (randomizes C)
    if(NOT_ZERO) {
      return             ; Button pressed ... end of splash
    }
      
    showLo()             ; Show "Lo"   
    H  = 0               ; Wait for button or ...
    waitButtonTime()     ; ... timeout (randomizes C)   
    if(NOT_ZERO) {
      return             ; Button pressed ... end of splash
    }
   
  } while(true)
   
; ----------------------------------------------------------------------------   
; This function plays a game of Hi/Lo. When the user guesses the number the
; display flashes and the player must press any key to exit.
;   @param (MyNumber) memory contains the number the computer is thinking of  
; 
playGame:
   
   LD    E,0            ; Start player guessing at 00
      
  do {
    input00to99()        ; Get a number from the player    
    LD    A,(MyNumber)   ; Compare computer number to guess    
   
    if(A==E) {        
      showWin()            ; Flash the winning indicator
      return               ; Done with game        
    }
   
    if(A<E) {
      showLo()             ; Show "Lo" as in "Lower"
      LD    B,S_LOA        ; "Lower" ...
      LD    C,S_LOB        ; ... tones
    } else {      
      showHi()             ; Show "Hi" as in "Higher"
      LD    B,S_HIA        ; "Higher" ...
      LD    C,S_HIB        ; ... tones
    }
   
    LD    H,0x10           ; 16 passes in sound loop
    do {
      LD    A,B            ; Play ...
      OUT   (2),A          ; ... first tone
      debWait()            ; Short ...
      debWait()            ; ... pause
      LD    A,C            ; Play ...
      OUT   (2),A          ; ... second tone
      debWait()            ; Short ...
      debWait()            ; ... pause
      DEC   H              ; All done?
    } while(NOT_ZERO)  
    
    LD    A,0            ; Turn off ...
    OUT   (2),A          ; ... sound
    
    LD    H,0x80         ; Wait for button or ...
    waitButtonTime()     ; ... timeout
   
  } while(true)
   

; This function flashes the winning number and plays a winning
; sound.
;   
showWin:

  showBlank()          ; Blank the screen
  LD    A,S_WA         ; Play first ...
  OUT   (2),A          ; ... win tone for ...
  LD    H,0x20         ; ... for a ...  
  waitTime()           ; ... short time

  do {    
  
    LD    A,(MyNumber)   ; Show the ...
    show00to99()         ; ... winning number ...
    LD    A,S_WB         ; Play second ...
    OUT   (2),A          ; ... win tone
    LD    H,0x20         ; ... for a ...
    waitButtonTime()     ; ... short time
    if(NOT_ZERO) {
      return             ; Return if any button
    }   
     
    showBlank()          ; Blank the screen
    LD    A,S_WA         ; Play first ...
    OUT   (2),A          ; ... win tone
    LD    H,0x20         ; ... screen for ...
    waitButtonTime()     ; ... a short time
    if(NOT_ZERO) {
      return             ; Return if any button
    }    
     
  } while(true)
   
; -----------------------TODO TO HERE ----------------------------------------------------- 
  
; This function waits for a button or a timeout, whichever comes first.
; The C register is incremented each pass through the loop. Thus it becomes
; a random number based on the user's time to press a button.
;   @param H time loop value 
;   @return A is the key value (or 0 if none). The Z flag is set accordingly.   
;
waitButtonTime:
   LD    L,0            ; LSB of long-counter to max decrement
wkt1:
   INC   C              ; Randomize C
   LD    A,C            ; Keep C between 00 and 99
   
   if(A>99) {
     LD C,0             ; Over 99, wrap to 0        
   }
      
   IN    A,(3)          ; Read the switches
   XOR   0x1F           ; Remember ... they are active low
   AND   0x1F           ; Only keep the switch bits
   RET   NZ             ; Something is pressed ... abort the count
   DEC   L              ; Count down the ...
   JP    NZ,wkt1        ; ... LSB of the delay value
   DEC   H              ; Count down the ...
   JP    NZ,wkt1        ; ... MSB of the delay value
   RET                  ; Done
   
waitTime:
   LD    L,0            ; LSB of long-counter to max decrement
wkt11:
   INC   C              ; Randomize C
   LD    A,C            ; Keep C between 00 and 99
   
   if(A>99) {
     LD C,0             ; Over 99, wrap to 0        
   }
      
   IN    A,(3)          ; Read the switches
   XOR   0x1F           ; Remember ... they are active low
   AND   0x1F           ; Only keep the switch bits
   NOP                  ; This is where the abort would be
   DEC   L              ; Count down the ...
   JP    NZ,wkt11       ; ... LSB of the delay value
   DEC   H              ; Count down the ...
   JP    NZ,wkt11       ; ... MSB of the delay value
   RET                  ; Done

; This function shows "Hi" on the display.
;   
showHi:
   LD    A,0x76         ; Pattern ...
   OUT   (0),A          ; ... for H
   LD    A,0x10         ; Pattern ...
   OUT   (1),A          ; ... for i
   RET                  ; Done

; This function shows "Lo" on the display.
;
showLo:
   LD    A,0x38         ; Pattern ...
   OUT   (0),A          ; ... for L
   LD    A,0x5C         ; Pattern ...
   OUT   (1),A          ; ... for o
   RET                  ; Done
 
; This function blanks the display.
;  
showBlank:
   LD    A,0            ; Turn off ...
   OUT   (0),A          ; ... all ...
   OUT   (1),A          ; ... segments
   RET                  ; Done

; This function displays a decimal number 0 to 99 on the
; two digit 7 segment display
;  @param A is the number to show
; 
show00to99:
    LD    DE,0          ; Count the number of 10s to DE
showA:
    CP    10            ; Result less than 10?
    JP    C,showB       ; Yes ... we have the digits separated
    INC   E             ; Bump the 10's digit
    SUB   10            ; Take off the 10
    JP    showA         ; Keep counting
showB:
    LD    B,0           ; Count of 1s ...
    LD    C,A           ; ... to BC
    LD    HL,segSprite  ; Start of sprite table
    ADD   HL,DE         ; Point to the correct sprite
    LD    A,(HL)        ; Get the pattern
    OUT   (0),A         ; Write the left digit    
    LD    HL,segSprite  ; Start of sprite table
    ADD   HL,BC         ; Point to the correct sprite
    LD    A,(HL)        ; Get the pattern
    OUT   (1),A         ; Write the right digit
    RET                 ; Done 

; This function interacts with the user to enter a number
; from 00 to 99.
;  @param E the initial value to edit from
;  @return E the entered value
;
input00to99:

; Show the value 
    PUSH  DE            ; Hold the value
    LD    A,E           ; Show the ...
    show00to99()        ; ... starting point
    POP   DE            ; E now has the edit value again
    
; Wait for no-button
    waitNoButton()      ; Wait for all buttons to lift   
    
; Turn off sounds
    LD    A,0           ; Turn off any ...
    OUT   (2),A         ; ... sounds
        
; Wait for any switch
    waitAnyButton()     ; Wait for a button press
    LD    B,A           ; Will need this for several tests
    
; If ENTER then return
    AND   0x08          ; ENTER pressed?
    if(NOT_ZERO) {
      return            ; Yes ... done
    }
    
; Handle Up/Down on Left/Right digits    
    LD    A,B           ; Original input
    AND   0x01          ; 1s down?    
    JP    NZ,inp1D      ; Yes ... go subtract 1
    
    LD    A,B           ; Original input
    AND   0x02          ; 1s up?
    JP    NZ,inp1U      ; Yes ... go add 1
    
    LD    A,B           ; Original input
    AND   0x04          ; 10s up?
    JP    NZ,inp10U     ; Yes ... go add 10
    
    ; Must be 10s-down    
    LD    A,S_10D       ; Start ...
    OUT   (2),A         ; ... sound
    LD    A,E           ; Value being edited
    SUB   10            ; Subtract 10 (left digit down)
    JP    NC,inpLGood   ; Still in limits
    SUB   156           ; Wrap around to 90s (example 5-10 = 251-156 = 95)
inpLGood:
    LD    E,A           ; Store edited value back to E
    JP    input00to99   ; Back to the top
    
inp1D:
    LD    A,S_1D        ; Start ...
    OUT   (2),A         ; ... sound
    LD    A,E           ; Value being edited
    SUB   1             ; Subtract 1 (right digit down)
    JP    NC,inpLGood   ; No overflow ... keep it
    LD    A,99          ; 0 underflows to 99
    JP    inpLGood      ; Store and keep going
inp1U:
    LD    A,S_1U        ; Start ...
    OUT   (2),A         ; ... sound
    LD    A,E           ; Value being edited
    ADD   A,1           ; Add 1 (right digit up)
    CP    100           ; Overflowed above 99?
    JP    NZ,inpLGood   ; No ... keep it
    LD    A,0           ; 99 overflows to 0
    JP    inpLGood      ; Store and keep going
inp10U:
    LD    A,S_10U       ; Start ...
    OUT   (2),A         ; ... sound
    LD    A,E           ; Value being edited
    ADD   A,10          ; Add 10 (left digit up)
    CP    100           ; Overflow above 99?
    JP    C,inpLGood    ; No ... keep it
    SUB   100           ; Wrap around to the 0s (example 95+10 = 105-100 = 5)
    JP    inpLGood      ; Store and keep going
   
; This function is a short delay loop allowing a change in switches
; to de-bounce
; 
debWait:
  PUSH  AF              ; Hold value in A
  LD    A,0             ; Start with 0    
  do {
    NOP                 ; Kill ...
    NOP                 ; ... time
    SUB   1             ; Count down
  } while(NOT_ZERO)
  POP   AF              ; Restore value in A
  return
  
; Discuss this traditional alternate form
; A = 0
; do {
;  A = A - 1
; } while(A!=0)
; return
    
; This function waits for all switches to open and then
; pauses for debounce
;
waitNoButton:   
  do {
    IN    A,(3)         ; Read the switches
    XOR   0x1F          ; Compliment ...
    AND   0x1F          ; ... mask and test
    if(ZERO) {
      debWait()         ; Debounce the change
      return            ; Done
    }    
  } while(true)
  
; This function waits for any button to close and then
; pauses for debounce. The switch value is returned in A.
;
waitAnyButton:
  do {
    IN    A,(3)         ; Read the switches
    XOR   0x1F          ; Compliment ...
    AND   0x1F          ; ... mask and test
    if(NOT_ZERO) {
      debWait()         ; Debounce the change      
      return            ; Done
    }    
  } while(true)

 
; 7-segment display information on the wiki:
; http://en.wikipedia.org/wiki/Seven-segment_display

; The segment bits are connected in this order: hgfedcba
;
;      a
;    +---+
;  f | g | b
;    +---+
;  e |   | c
;    +---+
;      d    . h

; Patterns for numbers (0-9) and hex (A-F)
segSprite:
# 0x3F, 0x06, 0x5B, 0x4F, 0x66, 0x6D, 0x7D, 0x07
# 0x7F, 0x6F, 0x77, 0x7C, 0x39, 0x5E, 0x79, 0x71

