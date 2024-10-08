{{
 This port implementation exposes the Hi/Lo hardware on 4 ports as follows:
   0 (output only) Left digit: hgfedcba 
   1 (output only) Right digit:  hgfedcba  
   2 (output onlu) Frequency 00-off FF-high
   3 (input only)  Switches:      ---54321  (CCW from bottom right)
}}

PUB start(parameterBlock)

  portOp := LONG[parameterBlock]
  portAddress := portOp+4
  portValue := portOp+8

  cognew(@entry,0)   
   
DAT
         org

entry

         mov       dira,C_DIRA             ' Digits and speaker as outputs
         mov       ctra,C_CTRA             ' Set up NCO on counter-A
         
mainClear
         mov       tmp,#0                  ' Tell CPU ...
         wrlong    tmp,portOp              ' ... we are done

main     rdlong    cmd,portOp              ' Wait for ...
         and       cmd,cmd wz, nr          ' ... a ...
  if_z   jmp       #main                   ' ... request          

         cmp       cmd,#1 wz               ' 1 for out (write)
         rdlong    cmd,portAddress         ' Get port address (doesn't change Z) 
  if_z   jmp       #doWrites               ' Do writes


doReads  cmp       cmd,#3 wc, wz           ' Range ...
  if_a   jmp       #mainClear              ' ... check
         add       cmd,#readPortsTable     ' Jump to ...
         jmp       cmd                     ' ... target "read port"

doWrites cmp       cmd,#3 wc,wz             ' Range ...
  if_a   jmp       #mainClear               ' ... check
         add       cmd,#writePortsTable     ' Jump to ...
         jmp       cmd                      ' ... target "write port"  

readPortsTable
         jmp       #mainClear
         jmp       #mainClear
         jmp       #mainClear
         jmp       #readPort3

writePortsTable
         jmp       #writePort0
         jmp       #writePort1
         jmp       #writePort2
         jmp       #mainClear
                 
         

writePort0
         rdlong    tmp,portValue
         and       tmp,#$FF
         andn      outa,#$FF
         or        outa,tmp         
         jmp       #mainClear
writePort1
         rdlong    tmp,portValue
         and       tmp,#$FF
         shl       tmp,#8
         andn      outa,C_FF_00
         or        outa,tmp         
         jmp       #mainClear
writePort2
         rdlong    tmp,portValue
         and       tmp,#$FF
         shl       tmp,#9
         mov       frqa,tmp
         jmp       #mainClear            

readPort3
         mov       tmp,ina
         shr       tmp,#16
         and       tmp,#$FF
         wrlong    tmp,portValue
         jmp       #mainClear      

C_CTRA long %00100_000 << 23 + 1 << 9 + 24
C_DIRA long %00000001_00000000_11111111_11111111

C_FF_00 long $00_00_FF_00

cmd           long $0
tmp           long $0

portOp        long  0-0
portAddress   long  0-0
portValue     long  0-0