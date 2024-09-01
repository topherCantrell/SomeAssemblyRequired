._CPU = 6502

.include stella.asm

0xF000:
start1:
    LDA    #0           ; Set Port B to ...
    STA    RIOT_B_DDR   ; ... inputs (switches)
    LDA    #0xFF        ; Set Port A to ...
    STA    RIOT_A_DDR   ; ... outputs (joysticks)

here:
    LDA    RIOT_B_DATA  ; Copy switch states ...
    STA    RIOT_A_DATA  ; ... to joystick lines
    JMP    here         ; Forever

0xF800:
start2:
    LDA    #0
    STA    RIOT_B_DDR
    LDA    #0xFF
    STA    RIOT_A_DDR
    LDA    #0xA5
    STA    RIOT_A_DATA
here2:
    JMP    here2

0xFFFA:
    .word  start2        ; NMI vector
    .word  start2        ; RESET vector
    .word  start2        ; IRQ vector
