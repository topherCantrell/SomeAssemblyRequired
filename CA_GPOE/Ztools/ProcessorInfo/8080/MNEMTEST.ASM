         .org 0
         aci h'00
         aci h'ff
         adc a
         adc b
         adc c
         adc d
         adc e
         adc h
         adc l
         adc m
         add a
         add b
         add c
         add d
         add e
         add h
         add l
         add m
         adi h'00
         adi h'ff
         ana a
         ana b
         ana c
         ana d
         ana e
         ana h
         ana l
         ana m
         ani h'00
         ani h'ff
         call h'1000
         call ltest
         cc ltest
         cm ltest
         cma
         cmc
         cmp a
         cmp b
         cmp c
         cmp d
         cmp e
         cmp h
         cmp l
         cmp m
         cnc ltest
         cnz ltest
         cp ltest
         cpe ltest
         cpi h'00
         cpi h'ff
         cpo ltest
         cz ltest
         daa
         dad b
         dad bc
         dad d
         dad de
         dad h
         dad hl
         dad sp
         dcr a
         dcr b
         dcr c
         dcr d
         dcr e
         dcr h
         dcr l
         dcr m
         dcx b
         dcx bc
         dcx d
         dcx de
         dcx h
         dcx hl
         dcx sp
         di
         ei
         hlt
         in h'00
         in h'ff
         inr a
         inr b
         inr c
         inr d
         inr e
         inr h
         inr l
         inr m
         inx b
         inx bc
         inx d
         inx de
         inx h
         inx hl
         inx sp
         jc ltest
         jm ltest
         jmp ltest
         jnc ltest
         jnz ltest
         jp  ltest
         jpe ltest
         jpo ltest
         jz ltest
         lda h'1000
         ldax b
         ldax d
         ldax bc
         ldax de
         lhld h'1000
         lxi b,h'1000
         lxi d,h'1001
         lxi h,h'2002
         lxi sp,h'f000
         mov a,a
         mov a,b
         mov a,c
         mov a,d
         mov a,e
         mov a,h
         mov a,l
         mov a,m
         mov b,a
         mov b,b
         mov b,c
         mov b,d
         mov b,e
         mov b,h
         mov b,l
         mov b,m
         mov c,a
         mov c,b
         mov c,c
         mov c,d
         mov c,e
         mov c,h
         mov c,l
         mov c,m
         mov d,a
         mov d,b
         mov d,c
         mov d,d
         mov d,e
         mov d,h
         mov d,l
         mov d,m
         mov e,a
         mov e,b
         mov e,c
         mov e,d
         mov e,e
         mov e,h
         mov e,l
         mov e,m
         mov h,a
         mov h,b
         mov h,c
         mov h,d
         mov h,e
         mov h,h
         mov h,l
         mov h,m
         mov l,a
         mov l,b
         mov l,c
         mov l,d
         mov l,e
         mov l,h
         mov l,l
         mov l,m
         mov m,a
         mov m,b
         mov m,c
         mov m,d
         mov m,e
         mov m,h
         mov m,l
         mvi a,h'00
         mvi b,h'00
         mvi c,h'00
         mvi d,h'00
         mvi e,h'00
         mvi h,h'00
         mvi l,h'00
         mvi m,h'00
         mvi a,h'ff
         mvi b,h'ff
         mvi c,h'ff
         mvi d,h'ff
         mvi e,h'ff
         mvi h,h'ff
         mvi l,h'ff
         mvi m,h'ff
         nop
         ora a
         ora b
         ora c
         ora d
         ora e
         ora h
         ora l
         ora m
         ori h'00
         ori h'ff
         out h'00
         out h'ff
         pchl
         pop b
         pop bc
         pop d
         pop de
         pop h
         pop hl
         pop psw
         push b
         push bc
         push d
         push de
         push h
         push hl
         push psw
         ral
         rar
         rc
         ret
         rim                      ;8085 only
         rlc
         rm
         rnc
         rnz
         rp
         rpe
         rpo
         rrc
         rst 0
         rst 1
         rst 2
         rst 3
         rst 4
         rst 5
         rst 6
         rst 7
         rz
         sbb a
         sbb b
         sbb c
         sbb d
         sbb e
         sbb h
         sbb l
         sbb m
         sbi h'00
         sbi h'ff
         shld h'1000
         sim            ;8085 only
         sphl
         sta h'1000
         stax b
         stax bc
         stax d
         stax de
         stc
         sub a
         sub b
         sub c
         sub d
         sub e
         sub h
         sub l
         sub m
         sui h'00
         sui h'ff
         xchg
         xra a
         xra b
         xra c
         xra d
         xra e
         xra h
         xra l
         xra m
         xri h'00
         xri h'ff
         xthl
         aci forward2
         aci forward1
         adc a
         adc b
         adc c
         adc d
         adc e
         adc h
         adc l
         adc m
         add a
         add b
         add c
         add d
         add e
         add h
         add l
         add m
         adi forward2
         adi forward1
         ana a
         ana b
         ana c
         ana d
         ana e
         ana h
         ana l
         ana m
         ani forward2
         ani forward1
         call h'1000
         call ltest
         cc ltest
         cm ltest
         cma
         cmc
         cmp a
         cmp b
         cmp c
         cmp d
         cmp e
         cmp h
         cmp l
         cmp m
         cnc ltest
         cnz ltest
         cp ltest
         cpe ltest
         cpi forward2
         cpi forward1
         cpo ltest
         cz ltest
         daa
         dad b
         dad bc
         dad d
         dad de
         dad h
         dad hl
         dad sp
         dcr a
         dcr b
         dcr c
         dcr d
         dcr e
         dcr h
         dcr l
         dcr m
         dcx b
         dcx bc
         dcx d
         dcx de
         dcx h
         dcx hl
         dcx sp
         di
         ei
         hlt
         in forward2
         in forward1
         inr a
         inr b
         inr c
         inr d
         inr e
         inr h
         inr l
         inr m
         inx b
         inx bc
         inx d
         inx de
         inx h
         inx hl
         inx sp
         jc ltest
         jm ltest
         jmp ltest
         jnc ltest
         jnz ltest
         jp  ltest
         jpe ltest
         jpo ltest
         jz ltest
         lda h'1000
         ldax b
         ldax d
         ldax bc
         ldax de
         lhld h'1000
         lxi b,h'1000
         lxi d,h'1001
         lxi h,h'2002
         lxi sp,h'f000
         mov a,a
         mov a,b
         mov a,c
         mov a,d
         mov a,e
         mov a,h
         mov a,l
         mov a,m
         mov b,a
         mov b,b
         mov b,c
         mov b,d
         mov b,e
         mov b,h
         mov b,l
         mov b,m
         mov c,a
         mov c,b
         mov c,c
         mov c,d
         mov c,e
         mov c,h
         mov c,l
         mov c,m
         mov d,a
         mov d,b
         mov d,c
         mov d,d
         mov d,e
         mov d,h
         mov d,l
         mov d,m
         mov e,a
         mov e,b
         mov e,c
         mov e,d
         mov e,e
         mov e,h
         mov e,l
         mov e,m
         mov h,a
         mov h,b
         mov h,c
         mov h,d
         mov h,e
         mov h,h
         mov h,l
         mov h,m
         mov l,a
         mov l,b
         mov l,c
         mov l,d
         mov l,e
         mov l,h
         mov l,l
         mov l,m
         mov m,a
         mov m,b
         mov m,c
         mov m,d
         mov m,e
         mov m,h
         mov m,l
         mvi a,forward2
         mvi b,forward2
         mvi c,forward2
         mvi d,forward2
         mvi e,forward2
         mvi h,forward2
         mvi l,forward2
         mvi m,forward2
         mvi a,forward1
         mvi b,forward1
         mvi c,forward1
         mvi d,forward1
         mvi e,forward1
         mvi h,forward1
         mvi l,forward1
         mvi m,forward1
         nop
         ora a
         ora b
         ora c
         ora d
         ora e
         ora h
         ora l
         ora m
         ori forward2
         ori forward1
         out forward2
         out forward1
         pchl
         pop b
         pop bc
         pop d
         pop de
         pop h
         pop hl
         pop psw
         push b
         push bc
         push d
         push de
         push h
         push hl
         push psw
         ral
         rar
         rc
         ret
         rim                      ;8085 only
         rlc
         rm
         rnc
         rnz
         rp
         rpe
         rpo
         rrc
         rst 0
         rst 1
         rst 2
         rst 3
         rst 4
         rst 5
         rst 6
         rst 7
         rz
         sbb a
         sbb b
         sbb c
         sbb d
         sbb e
         sbb h
         sbb l
         sbb m
         sbi forward2
         sbi forward1
         shld h'1000
         sim            ;8085 only
         sphl
         sta h'1000
         stax b
         stax bc
         stax d
         stax de
         stc
         sub a
         sub b
         sub c
         sub d
         sub e
         sub h
         sub l
         sub m
         sui forward2
         sui forward1
         xchg
         xra a
         xra b
         xra c
         xra d
         xra e
         xra h
         xra l
         xra m
         xri forward2
         xri forward1
         xthl
synctst:
ltest:   .equ forward1,h'ff
         .equ forward2,h'00
         .end
