.RIOT_RAM      = 0x0080 ; 80-FF, 128 bytes. Mirrored 180-1FF for stack.

.RIOT_A_DATA   = 0x0280
.RIOT_A_DDR    = 0x0281
;
.RIOT_B_DATA   = 0x0282
.RIOT_B_DDR    = 0x0283
;
.RIOT_RO_TIMER = 0x0284
.RIOT_WO_T1    = 0x0294
.RIOT_WO_T8    = 0x0295
.RIOT_WO_T64   = 0x0296
.RIOT_WO_T1024 = 0x0297

; Joystick port (looking into console)
;  1   2   3   4   5
;    6   7   8   9
;                          Breakout cable
; 7 +5
; 8 Gnd                    black
;
; PA7    Left4      RIGHT  brown
; PA6    Left3      LEFT   green
; PA5    Left2      DOWN   blue
; PA4    Left1      UP     white
;
; PA3    Right4     RIGHT  brown
; PA2    Right3     LEFT   green
; PA1    Right2     DOWN   blue
; PA0    Right1     UP     white
;
; PB7    RightDifficulty
; PB6    LeftDifficulty
; PB5    nc
; PB4    nc
; PB3    B/W-Color
; PB2    nc
; PB1    Select
; PB0    Start
;
; TIA I5 Right6  Trigger   orange
; TIA I4 Left6   Trigger   orange
; TIA I3 Right9  PaddleA
; TIA I2 Right5  PaddleB
; TIA I1 Letf9   PaddleA
; TIA I0 Left5   PaddleB
