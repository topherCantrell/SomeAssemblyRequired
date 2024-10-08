{{

 Z80-like CPU Emulator
 by Chris Cantrell
 8/14/1022
 Copyright (c) 2011 Chris Cantrell
 See end of file for terms of use.

' based on the 3-vector decode table in z80_emu v0.0 by Michael Rychlik

' Overflow flag (carry for signed numbers) is not computed.
' Parrity works, but not overflow.

' DAA is implemented as NOP

' TODO add Z80 opcodes

}}

CON

  ' Flags
  sign_bit   =   %10000000
  zero_bit   =   %01000000
  '              %00100000
  'half_bit  =   %00010000
  '              %00001000
  parity_bit =   %00000100
  'subtract_bit= %00000010
  carry_bit  =   %00000001

  ' Shift amounts for each flag that can be used
  ' in a conditional flow instruction
  bn_carry =  0
  bn_parity = 2
  bn_zero =   6
  bn_sign =   7

  ' Port commands
  io_cmd_out = $01 
  io_cmd_in  = $02

  ' Shift amounts for decode-table parameters
  dec_param    = 26
  dec_reg_v1   = 26  
  dec_reg_v3   = 29

  ' Shift amounts for decode-table vectors  
  dec_v1  =  0
  dec_v2  =  9
  dec_v3  = 18        
  Dv1     =  0
  Dv2     =  9
  Dv3     = 18
  Dr1     = 26
  Dr3     = 29

  ' Register offset within the COG memory  
  dec_a = 0
  dec_f = 1
  dec_b = 2 
  dec_c = 3
  dec_d = 4
  dec_e = 5
  dec_h = 6
  dec_l = 7

PUB start(cpu_params) : okay | reg_base, io_base
'
'' The controlStatus allows external debugging control of the CPU.
''   0 means the CPU is running freely
''   1 means the CPU is waiting for any other value (0 to continue or other commands)
''   2 means run one instruction then issue a HALT opcode
''   3 means load the registers from the status block and start running.
''   Any other value will issue a HALT opcode
''
'' The HALT opcode writes the CPU registers to the status block, sets the control
'' to 1, and waits. This can be used as a code breakpoint.  

  ' First parameter is the shared-ram address of the 8080's address 0000
  memory_base := LONG[cpu_params]    

  ' The second parameter is the shared-ram address of the I/O control block
  io_base := LONG[cpu_params +4]    
  io_command :=  io_base
  io_port := io_base + 4
  io_data := io_base + 8      

  ' The third parameter is the shared-ram address of interrupt control
  interrupt := LONG[cpu_params + 8]

  ' The 4th parameter is the shared-ram address of the CPU control/status
  controlStatus := LONG[cpu_params + 12]

  object_base := @@0 'Set up the base address of this object        

  cognew(@entry, 0) 'Start emulator in a new COG

DAT                          
         org       0                            

entry   

         add       dispatch_tab_addr, object_base 'Fixup this object offset to HUB real address

         jmp       #fetch

         ' Pointer to opcode decode table in global memory
dispatch_tab_addr long @dispatch_table

'---------------------------------------------------------------------------------------------------------
' Data Destination Functions (these are vector3 functions that always end with fetching next instruction)
' These appear early in the code because the upper bit of the vector's address is used as a
' 6th bit for the parameter field. The upper bit must be 0.

' -- Set PC --
set_pc   mov       pc,data_16          ' Set the new PC value
         jmp       #fetch              ' Done

' -- Set SP --         
set_sp   mov       sp,data_16          ' Set the new SP value
         jmp       #fetch              ' Done

' -- Set R8
setR8    movd      sr8a, paramRegD     ' Set the address of the destination register
         nop                           ' Required gap before access
sr8a     mov       0,data_8            ' Copy data_8 to target register   
         jmp       #fetch              ' Done

' -- Set R16                                         
setR16   movd      sr16a,paramRegD     ' Address of upper register of pair
         movd      sr16b,paramRegD     ' Address of upper register of pair (again)
         add       paramRegD,#1        ' Next register is lower
         movd      sr16c,paramRegD     ' Address of lower register of pair
         movd      sr16d,paramRegD     ' Address of lower register of pair (again)
sr16a    mov       0,data_16           ' Set upper register
sr16b    shr       0,#8                ' Shift upper byte into place
sr16c    mov       0,data_16           ' Set lower register
sr16d    and       0,#$FF              ' Mask lower byte into place          
         jmp       #fetch              ' Done  

' -- Set byte[R16]
setBR16  movs      sbr16a,paramRegD    ' Address of upper register of pair
         add       paramRegD,#1        ' Next register is lower
         movs      sbr16b,paramRegD    ' Address of lower register of pair
sbr16a   mov       address, 0          ' Get the upper byte
         shl       address,#8          ' Shift into place
sbr16b   or        address, 0          ' OR in the lower byte
         call      #write_memory_byte  ' Write the value from data_8            
         jmp       #fetch              ' Done

' -- Push PC then set PC
push_set_pc
         mov       t1,data_16          ' Hold the new PC value
         mov       data_16,pc          ' Value to push is the current PC
         call      #push               ' Push current PC on stack
         mov       pc,t1               ' Set PC to new value           
nop_v3   jmp       #fetch              ' Done

' -- Set byte[address_from_opcode]     
set_byte_caddr
         mov       t1,data_8           ' Hold the value to write
         mov       address, pc         ' Read address ...
         call      #read_memory_word   ' ... from immediate code memory
         add       pc, #2              ' Skip over the address in code
         mov       address,data_16     ' The address we just read
         mov       data_8,t1           ' The original value
         call      #write_memory_byte  ' Write the value
         jmp       #fetch              ' Done

' -- Set word memory[address_from_opcode]
set_word_caddr
         mov       t1,data_16          ' Hold the value to write
         mov       address, pc         ' Read address ...
         call      #read_memory_word   ' ... from immediate code memory
         add       pc, #2              ' Skip over the address in code
         mov       address,data_16     ' The address we just read
         mov       data_16,t1          ' The original value
         call      #write_memory_word  ' Write the value
         jmp       #fetch              ' Done

' -- Pop PC
pop_pc   call      #pop                ' Pop the value from the stack
         mov       pc,data_16          ' Move value to PC           
         jmp       #fetch              ' Done

' -- Set PC based on RST number
set_pc_rst
         mov       data_16,param       ' Get RST number from param field
         shl       data_16,#3          ' *8
         jmp       #push_set_pc        ' Push the PC and set the PC     

' -- Push R16        
pushReg  movs      pra,paramRegD       ' Address of upper register of pair
         add       paramRegD,#1        ' Next register is lower
         movs      prb,paramRegD       ' Address of lower register of pair
pra      mov       data_16,0           ' Get the upper byte
         shl       data_16,#8          ' Shift it into position
prb      or        data_16,0           ' OR in the lower byte
         call      #push               ' Push the value              
         jmp       #fetch              ' Done

' -- Pop R16
popReg   call      #pop                ' Pop the value from the stack
         jmp       #setR16             ' Set the target register pair

' The upper bit of the last vector is used as a param
         fit       $100     

'---------------------------------------------------------------------------------------------------------
'Data Source Functions (these are vector1 jumps that always end with vector2)

' -- Get SP
get_sp   mov       data_16, sp         ' Get the value of the SP register
nop_v1   jmp       #vect_2             ' Done           

' -- Get R8
getR8    movs      gr8b,paramRegS       ' Address of the 8-bit register
         nop                           ' Required gap before access
gr8b     mov       data_8, 0           ' Get the value of the desired register
         jmp       #vect_2             ' Done  

' -- Get R16         
getR16   movs      gr16b, paramRegS    ' Address of upper register of pair
         add       paramRegS,#1        ' Next regsiter is lower
         movs      gr16c, paramRegS    ' Address of lower register of pair         
gr16b    mov       data_16,0           ' Get the upper byte
         shl       data_16,#8          ' Shift it into place
gr16c    or        data_16,0           ' OR in the lower byte
         jmp       #vect_2             ' Done  

' -- Get byte[PC] then PC+=1
get_code_byte
         mov       address, pc         ' Program counter points to immediate
         call      #read_memory_byte   ' Read byte from code
         add       pc, #1              ' Bump the PC
         jmp       #vect_2             ' Done     

' -- Get word[PC] then PC+=2
get_code_word  
         mov       address, pc         ' Program counter points to immediate
         call      #read_memory_word   ' Read word from code
         add       pc, #2              ' Bump the PC
         jmp       #vect_2             ' Done      

' -- Get byte[R16]
getBR16  movs      gbr16a, paramRegS   ' Address of upper register of pair
         add       paramRegS,#1        ' Next register is lower
         movs      gbr16b, paramRegS   ' Address of lower register or pair        
gbr16a   mov       address, 0          ' Get the upper byte
         shl       address, #8         ' Shift it into place
gbr16b   or        address, 0          ' OR in the lower byte
getbdone call      #read_memory_byte   ' Read the byte from 8080 ram
         jmp       #vect_2             ' Done    

' -- Get byte[address_from_opcode]       
get_byte_caddr
         mov       address, pc         ' PC points to the immediate
         call      #read_memory_word   ' Read the address from the code
         add       pc, #2              ' Bump the PC
         mov       address,data_16     ' Immediate value is the address
         jmp       #getbdone           ' Read byte and done

' -- Get word[address_from_opcode]
get_word_caddr
         mov       address, pc         ' PC points to the immediate
         call      #read_memory_word   ' Read the address from the code
         add       pc, #2              ' Bump the PC
         mov       address,data_16     ' Immediate value is the address
         call      #read_memory_word   ' Get the word
         jmp       #vect_2             ' Done

' -- Get word[HL]
get_word_hl
         mov       address, h_reg      ' H is the upper register of pair
         shl       address,#8          ' Shift it into place
         or        address, l_reg      ' OR in the lower byte
         call      #read_memory_word   ' Read the word from 8080 ram
         jmp       #vect_2             ' Done

'---------------------------------------------------------------------------------------------------------
' Execution Functions (these are vector2 functions that always end with vector3)

un_v1    ' Unimplemented opcodes go to halt
un_v2
un_v3

' -- Do HALT
halt     mov       t1,#16                   ' 16 longs to write
         mov       t2,#a_reg                ' Start of source
         mov       t3,controlStatus         ' Start of destination ...
         add       t3,#4                    ' ... is one past control
haltb    movd      halta,t2                 ' Store pointer to source
         nop                                ' Kill time
halta    wrlong    0-0,t3                   ' Write the source to the destination
         add       t3,#4                    ' Next long in destination
         add       t2,#1                    ' Next long in source
         djnz      t1,#haltb                ' Do them all
haltc    mov       t1,#1                    ' Signal a ...
         wrlong    t1,controlStatus         ' ... CPU in wait
         jmp       #fetch                   ' Infinite loop

' -- Do skip vector 3 if flag not set
flagSetOrSkip
         mov       t1,#1               ' Bit number 0
         shl       t1,param            ' Set desired bit number
         and       f_reg,t1 wz, nr     ' Test the desired flag
   if_z  jmp       #fetch              ' If it isn't set then skip last vector
nop_v2   jmp       #vect_3             ' Process the last vector (flag is set)

' -- Do skip vector 3 if flag not clear
flagClearOrSkip
         mov       t1,#1               ' Bit number 0
         shl       t1,param            ' Set desired bit number         
         and       f_reg,t1 wz, nr     ' Test the desired flag
   if_nz jmp       #fetch              ' If it is set then skip last vector
         jmp       #vect_3             ' Process the last vector (flag is not set)

' -- Do enable interrupts
enableInt
         mov       intEnable,param     ' Set the enabled flag (1 or 0 from param)
         jmp       #vect_3             ' Process the last vector
         
' -- Do  I/O port input 
ioIn     wrlong    data_8,io_port           ' Write the port address
         mov       data_8,#io_cmd_in        ' Write the ...
         wrlong    data_8,io_command        ' ... IN command
ioWI     rdlong    data_8,io_command wz     ' Wait for port handler ...
 if_nz   jmp       #ioWI                    ' ... to respond
         rdlong    a_reg,io_data            ' Get the value
         jmp       #vect_3                  ' Done

' -- Do I/O port output
ioOut    wrlong    data_8,io_port           ' Write the port address
         wrlong    a_reg,io_data            ' Write the port data
         mov       data_8,#io_cmd_out       ' Write the ...
         wrlong    data_8,io_command        ' ... OUT command
ioWO     rdlong    data_8,io_command wz     ' Wait for port handler ...
 if_nz   jmp       #ioWO                    ' ... to respond          
         jmp       #vect_3                  ' Done   

' -- Do complement carry flag
opCCF    xor       f_reg,#carry_bit         ' Flip the carry bit
         jmp       #vect_3                  ' Done

' -- Do set carry flag
opSCF    or        f_reg,#carry_bit         ' Set the carry-bit
         jmp       #vect_3                  ' Done

' -- Do OR operation
opOR     or        data_8,a_reg wc, wz ' OR A with data_8 (C = result parity, Z = result zero)
         mov       f_reg,#0            ' Clear all flags (will set the right ones)
         jmp       #logicFlags         ' Set the flags

' -- Do XOR operation
opXOR    xor       data_8,a_reg wc, wz ' XOR A with data_8 (C = result parity, Z = result zero)
         mov       f_reg,#0            ' Clear all flags (will set the right ones)
         jmp       #logicFlags         ' Set the flags

' -- Do AND operation
opAND    and       data_8,a_reg wc, wz ' AND A with data_8 (C = result parity, Z = result zero)       
         mov       f_reg,#0            ' Clear all flags
         
logicFlags
  if_c   or        f_reg,#parity_bit   ' Copy parity flag from C
  if_z   or        f_reg,#zero_bit     ' Copy zero flag from Z        
         and       data_8,#sign_bit wz, nr ' Copy sign ...
  if_nz  or        f_reg,#sign_bit     ' ... bit from result
         jmp       #vect_3             ' Done

' -- Do 16-bit increment
opINC16  add       data_16,#1          ' Increment the 16-bit value (no flags)
         and       data_16,C_FFFF      ' Wrap if needed
         jmp       #vect_3             ' Done

' -- Do 16-bit decrement         
opDEC16  sub       data_16,#1          ' Decrement the 16-bit value (no flags)
         and       data_16,C_FFFF      ' Wrap if needed
         jmp       #vect_3             ' Done

' -- Do Complement the A register
opCPL    xor       a_reg,#%11111111    ' Toggle all bits in the A register
         mov       f_reg,#0            ' Clear flags
         jmp       #vect_3             ' Done

' -- Do exchange DE and HL
opEXDEHL mov       t1,d_reg            ' Exchange ...
         mov       d_reg,h_reg         ' ... D ...
         mov       h_reg,t1            ' ... and H
         mov       t1,e_reg            ' Exchange ...
         mov       e_reg,l_reg         ' ... E ...
         mov       l_reg,t1            ' ... and L
         jmp       #vect_3             ' Done

' -- Do exchange SP and HL
opEXSPHL call      #pop                ' Get the value from the stack
         mov       t1,data_16          ' Hold the value
         mov       data_16,h_reg       ' Get value ...
         shl       data_16,#8          ' ... of ...
         or        data_16,l_reg       ' ... HL
         call      #push               ' Push HL on stack
         mov       h_reg,t1            ' Set H ...
         shr       h_reg,#8            ' ... to upper value
         mov       l_reg,t1            ' Set L ...
         and       l_reg,#255          ' ... to lower value
         jmp       #vect_3             ' Done 

' -- Do subtract with borrow
opSBC    mov       t1,a_reg                 ' Hold this as "original value" for HV flags  
         mov       t2,a_reg                 ' Do the math on t2 so we leave A alone
         sub       t2,data_8                ' Subtract data_8 from A (t2 = A - data)
         and       f_reg,#carry_bit wz,nr   ' If borrow is set ...
  if_nz  sub       t2,#1                    ' ... take one more away
         mov       f_reg,#0                 ' Clear all flags (will set shortly)
         jmp       #opSCom                  ' Common flag setting with SUB command

' -- Do 8-bit decrement
opDEC    mov       t1,data_8                ' Hold this as "original value" for HV flags
         mov       t2,data_8                ' Do the math on t2 so we leave A alone
         sub       t2,#1                    ' t2 = data - 1
         mov       f_reg,#0                 ' Clear all flags (will set shortly)
         jmp       #opSCom2                 ' Common flag setting with SBC and SUB

' -- Do 8-bit increment
opINC    mov       t1,data_8                ' Hold this as "original value" for HV flags
         mov       t2,data_8                ' Do the math on t2 so we leave A alone
         add       t2,#1                    ' t2 = data + 1
         mov       f_reg,#0                 ' Clear all flags (will set shortly)
         jmp       #opACom2                 ' Common flag setting with ADC and ADD

' -- Do add with carry
opADC    mov       t1,a_reg                 ' Hold this as "original value" for HV flags
         mov       t2,a_reg                 ' Do the math on t2 so we leave A alone
         add       t2,data_8                ' t2 = A + data
         and       f_reg,#carry_bit wz,nr   ' If the carr is set ...
  if_nz  add       t2,#1                    ' ... then add one more
         mov       f_reg,#0                 ' Clear all flags (will set shortly)
         jmp       #opACom                  ' Common flag setting with ADD command

' -- Do add         
opADD    mov       t1,a_reg                 ' Hold this as "original value" for HV flags
         mov       t2,a_reg                 ' Do the math on t2 so we leave A alone
         add       t2,data_8                ' t2 = A + data
         mov       f_reg,#0                 ' Clear all flags (will set shortly)

opACom   cmp       t2,#$FF wc, wz           ' Set carry if ...
  if_a   or        f_reg,#carry_bit         ' ... result is > 255

opACom2  ' This is where to handle the overflow flag      
opASCom
         and       t2,#%1000_0000  nr, wz   ' Copy sign bit ...
  if_nz  or        f_reg,#sign_bit          ' ... from result to flags
         and       t2,#%1111_1111  nr, wz   ' If result is zero ...
   if_z  or        f_reg,#zero_bit          ' ... then set zero flag
         and       t2,#255                  ' Limit result to a byte
         mov       data_8,t2                ' Result back to data_8 (again, A is untouched)
         jmp       #vect_3                 ' Set S and Z. Common to all ADD, SUB, INC, and DEC                

opSUB    mov       t1,a_reg                 ' Hold this as "original value" for HV flags
         mov       t2,a_reg                 ' Do the math on t2 so we leave A alone
         sub       t2,data_8                ' t2 = A - data
         mov       f_reg,#0                 ' Clear all flags (will set shortly)

opSCom   cmp       t2,#$FF wc, wz           ' Set borrow ...
  if_a   or        f_reg,#carry_bit         ' ... if reslut is > 255
  
opSCom2  ' This is where to handle the overflow flag     

opSCom3  ' Set sz flags
         jmp       #opASCom            ' Sign, zero, wrap, and move result

' -- Do 16-bit add
opADD16  mov       t1,h_reg            ' Use t1 ...
         shl       t1,#8               ' ... as original ...
         or        t1,l_reg            ' ... HL value
         mov       t2,t1               ' Do the math of t2 so we leave A
         add       t2,data_16          ' t2 = HL - data 
         mov       f_reg,#0            ' Clear all flags (will set shortly) 
                 
         cmp       t2,C_FFFF wz, wc    ' If result is > 65535 ...
  if_z   or        f_reg,#carry_bit    ' ... then set carry
         and       t2,C_FFFF           ' Wrap result if needed
         mov       data_16,t2          ' Result back to data_16 (again, HL is unaffected)
         jmp       #vect_3             ' Done                    

' -- Do RLA        
opRLA    shl       a_reg,#1                           ' Shift A to the left
         and       f_reg,#carry_bit nr, wz            ' Copy carry ...
  if_nz  or        a_reg,#1                           ' ... to right most bit
         and       a_reg,#%1_00000000 nr, wz          ' Copy bit ...
         andn      f_reg,#carry_bit                   ' ... shifted out of left ...
  if_nz  or        f_reg,#carry_bit                   ' ... to the carry bit
         and       a_reg,#255                         ' Limit to 1 byte         
         jmp       #vect_3                            ' Done

' -- Do RRA
opRRA    mov       t1,a_reg                           ' Hold lowest bit
         shr       a_reg,#1                           ' Shift A to the right
         and       f_reg,#carry_bit nr, wz            ' Copy carry ...
  if_nz  or        a_reg,#%1000_0000                  ' ... to left most bit
         andn      f_reg,#carry_bit                   ' Copy bit ...
         and       t1,#1 nr, wz                       ' ... shifted out of right ...
  if_nz  or        f_reg,#carry_bit                   ' ... to the carry bit         
         jmp       #vect_3                            ' Done

' -- Do RLCA         
opRLCA   shl       a_reg,#1                           ' Shift A to the left
         and       a_reg,#%1_00000000 nr, wz          ' Copy bit ...
         andn      a_reg,#carry_bit                   ' ... shifted out of left ...
  if_nz  or        a_reg,#1                           ' ... to right most bit ...
  if_nz  or        f_reg,#carry_bit                   ' ... and carry
         and       a_reg,#255                         ' Limit to 1 byte                  
         jmp       #vect_3                            ' Done

' -- Do RRCA
opRRCA   mov       t1,a_reg                           ' Hold lowest bit
         shr       a_reg,#1                           ' Shift A to the right
         andn      f_reg,#carry_bit                   ' Copy bit ...
         and       t1,#1 nr, wz                       ' ... shifted out of right ...
  if_nz  or        a_reg,#%10000000                   ' ... to left most bit ...
  if_nz  or        f_reg,#carry_bit                   ' ... and carry         
         jmp       #vect_3                            ' Done



' Common memory read/write functions
read_memory_byte
         mov       hub_pointer,memory_base  ' Pointer to start of 8080 memory
         add       hub_pointer,address      ' Offset to address
         rdbyte    data_8, hub_pointer      ' Read the byte
read_memory_byte_ret                        '
         ret                                ' Done     

write_memory_byte
         mov       hub_pointer,memory_base  ' Pointer to start of 8080 memory
         add       hub_pointer,address      ' Offset to address
         wrbyte    data_8, hub_pointer      ' Write the byte
write_memory_byte_ret                       '
         ret                                ' Done

read_memory_word
         call      #read_memory_byte   ' Read the low byte
         mov       data_16, data_8     ' Hold the low byte
         add       address, #1         ' Next address
         call      #read_memory_byte   ' Read the high byte
         shl       data_8,#8           ' Shift high byte into position
         or        data_16, data_8     ' Merge high and low byte
read_memory_word_ret                   '
         ret                           ' Done

write_memory_word
         mov       data_8, data_16     ' Get the low byte
         call      #write_memory_byte  ' Write the low byte
         shr       data_8, #8          ' Get the high byte
         add       address, #1         ' Next address
         call      #write_memory_byte  ' Write the high byte
write_memory_word_ret                  '
         ret                           ' Done

' 8080 stacks grows by decrement. Only words are pushed/popped (not bytes).
' The stack pointer points to the the last word pushed (the next word to pop).

push     sub        sp,#2              ' Make room for the next word
         mov        address,sp         ' SP is the address
         call       #write_memory_word ' Write data_16 to stack
push_ret ret                           ' Done
                                       
pop      mov       address,sp          ' SP is the address
         call      #read_memory_word   ' Read data_16 from stack
         add       sp,#2               ' Drop word from the stack
pop_ret  ret                           ' Done






'---------------------------------------------------------------------------------------------------------
' Top of processing loop
         
fetch 
         rdlong    t1,controlStatus    ' Check the outside control
         cmp       t1,#0 wz            ' 0 means ...
    if_z jmp       #cycle              ' ... run freely
         cmp       t1,#1 wz            ' 1 means ...
    if_z jmp       #fetch              ' ... just wait for command
         cmp       t1,#2               ' 2 means ...  
    if_z jmp       #singStep           ' ... single step
         cmp       t1,#3 wz            ' 3 means load registers and run
  if_nz  jmp       #halt               ' Any other value initiates a halt

' Operation-3 ... load registers and run
         mov       t1,#15              ' 15 longs to read (skip the last write-status long)
         mov       t2,#a_reg           ' Start of destination
         mov       t3,controlStatus    ' Start of source ...
         add       t3,#4               ' ... one long past control 
taltb    movd      talta,t2            ' Store pointer to destination
         nop                           ' Kill time
talta    rdlong    0-0,t3              ' Write the source to the destination
         add       t3,#4               ' Next long in source
         add       t2,#1               ' Next long in destination
         djnz      t1,#taltb           ' Do them all

         mov       t1,#0               ' Signal a ...
         wrlong    t1,controlStatus    ' ... CPU running                           

' Check for interrupts and handle
cycle    rdlong    t1,interrupt        ' Read the interrupt status
         mov       t2,t1               ' Get ...
         shr       t2,#12               ' ... interrupt type
         cmp       t2,#1 wz            ' 1 means IRQ?
  if_nz  jmp       #int1               ' No ... move on
         cmp       intEnable,#1 wz     ' IRQ enabled?
  if_nz  jmp       #int1               ' No ... move on
  
         jmp       #int3               ' Take the interrupt

int1     cmp       t2,#2 wz            ' 2 means NMI?
  if_nz  jmp       #intEnd             ' No ... move on

int3     mov       t2,#0               ' Remove the ...
         wrlong    t2,interrupt        ' ... interrupt request for next pass
         mov       data_16,pc          ' Push the ...
         call      #push               ' ... program counter
         mov       pc,t1               ' Get the address
         and       pc,#$FF             ' Mask off the command

' Fetch the next instruction and execute it         
intEnd   mov       address, pc         ' PC to address parameter
         call      #read_memory_byte   ' Read the instruction byte there 
         add       pc, #1              ' Increment the program counter
         
         mov       disp_ptr, data_8    ' Dispatch table look up
         shl       disp_ptr, #2        ' Mul by 4 to get a LONG offset into the table
         add       disp_ptr, dispatch_tab_addr 'Index into table
         rdlong    vector, disp_ptr    ' Read the instruction handlers vectors (3 per long)
         
         mov       param,vector        ' The param field ...
         shr       param,#26           ' ... is top 6 bits
         mov       paramRegS,param     ' The lower three ...
         and       paramRegS,#%111     ' ... bits of param ...
         add       paramRegS,#a_reg    ' ... could be src register
         mov       paramRegD,param     ' The upper three ...
         shr       paramRegD,#3        ' ... bits of param ...
         add       paramRegD,#a_reg    ' ... could be dst register      
         jmp       vector              ' Jump to the instruction handler 
         
vect_2   shr       vector, #9          ' Shift to 2nd vector
         jmp       vector              ' Execute get functions

vect_3   shr       vector, #9          ' Shift to 3rd vector
         and       vector, #$FF        ' The upper bit here is part of the params
         jmp       vector              ' Execute set functions

singStep and    stepFlag,stepFlag wz   ' Have we been through the fectch once with single-step?
  if_nz  jmp    #halt                  ' Yes ... do a halt
         mov    stepFlag,#1            ' Next time we halt
         jmp    #cycle                 ' Noted ... do the instruction

' ----------         
' The HALT writes 16 longs to memory beginning with a_reg. The last to go is the
' constant C_FFFF. The memory where this goes can be cleared first. Then the non-0
' value will indicate the registers have been written. The first 15 are also read
' back in. We include T1, T2, T3 here since they can be mangled (space holder for
' future information).
'
' Z80 (8080) registers
a_reg    long $0
f_reg    long 0
b_reg    long 0 
c_reg    long 0
d_reg    long 0
e_reg    long 0
h_reg    long 0
l_reg    long 0
x_reg    long 0 ' 2-byte
y_reg    long 0 ' 2-byte
'
sp       long 0        
pc       long 0
'
t1       long 0
t2       long 0
t3       long 0
'
C_FFFF   long $FFFF
' End of HALT-copy longs 
' ---------- 

address                 long    0                          
data_8                  long    0                         
data_16                 long    0

vector                  long    0
disp_ptr                long    0        
hub_pointer             long    0       

param                   long    0
paramRegS               long    0
paramRegD               long    0

stepFlag                long    0
intEnable               long    0

controlStatus           long    0-0    ' Pointer to the control/status block for the CPU
interrupt               long    0-0    ' Pointer to interrupt-request long in shared ram
object_base             long    0-0    ' Location of object in shared ram                    
memory_base             long    0-0    ' Start of 8080 ram in shared ram                   
io_command              long    0-0    ' Port-command long in shared ram
io_port                 long    0-0    ' Port-address long in shared ram
io_data                 long    0-0    ' Port-data long in shared ram                     

last     fit







'---------------------------------------------------------------------------------------------------------
dispatch_table  '  29  26       18         9         0
'                 yyy_xxx_cccccccc_bbbbbbbbb_aaaaaaaaa
'
'    VECTOR-1 (a)           VECTOR-2 (b)     VECTOR-3 (c)     PARAM-1 (x)     PARAM-3 (y)
long (nop_v1        <<Dv1)+ (nop_v2  <<Dv2)+ (nop_v3  <<Dv3)                                '  00      NOP          --------
long (get_code_word <<Dv1)+ (nop_v2  <<Dv2)+ (setR16  <<Dv3)+                 (dec_b <<Dr3) '  01wlwm  LD   BC,w    --------
long (getR8         <<Dv1)+ (nop_v2  <<Dv2)+ (setBR16 <<Dv3)+ (dec_a <<Dr1) + (dec_b <<Dr3) '  02      LD   (BC),A  --------
long (getR16        <<Dv1)+ (opINC16 <<Dv2)+ (setR16  <<Dv3)+ (dec_b <<Dr1) + (dec_b <<Dr3) '  03      INC  BC      --------
long (getR8         <<Dv1)+ (opINC   <<Dv2)+ (setR8   <<Dv3)+ (dec_b <<Dr1) + (dec_b <<Dr3) '  04      INC  B       sz-h-v0-
long (getR8         <<Dv1)+ (opDEC   <<Dv2)+ (setR8   <<Dv3)+ (dec_b <<Dr1) + (dec_b <<Dr3) '  05      DEC  B       sz-u-v1-
long (get_code_byte <<Dv1)+ (nop_v2  <<Dv2)+ (setR8   <<Dv3)+                 (dec_b <<Dr3) '  06bb    LD   B,b     --------
long (nop_v1        <<Dv1)+ (opRLCA  <<Dv2)+ (nop_v3  <<Dv3)                                '  07      RLCA         ---0--0x

' The above was prettied up for documentation purposes

{08} long (un_v1<<dec_v1) + (un_v2<<dec_v2) + (un_v3<<dec_v3)
{09} long (getR16<<dec_v1) + (opADD16<<dec_v2) + (setR16<<dec_v3) + (dec_b<<dec_reg_v1) + (dec_h<<dec_reg_v3) '  09       ADD HL,BC            ---H--0C
{0A} long (getBR16<<dec_v1) + (nop_v2<<dec_v2) + (setR8<<dec_v3) + (dec_b<<dec_reg_v1) + (dec_a<<dec_reg_v3) '  0A       LD A,(BC)            --------
{0B} long (getR16<<dec_v1) + (opDEC16<<dec_v2) + (setR16<<dec_v3) + (dec_b<<dec_reg_v1) + (dec_b<<dec_reg_v3) '  0B       DEC BC               --------
{0C} long (getR8<<dec_v1) + (opINC<<dec_v2) + (setR8<<dec_v3) + (dec_c<<dec_reg_v1) + (dec_c<<dec_reg_v3)     '  0C       INC C                sz-h-v0-
{0D} long (getR8<<dec_v1) + (opDEC<<dec_v2) + (setR8<<dec_v3) + (dec_c<<dec_reg_v1) + (dec_c<<dec_reg_v3)     '  0D       DEC C                sz-u-v1-
{0E} long (get_code_byte<<dec_v1) + (nop_v2<<dec_v2) + (setR8<<dec_v3) + (dec_c<<dec_reg_v3) '  0Ebb     LD C,b               --------
{0F} long (nop_v1<<dec_v1) + (opRRCA<<dec_v2) +  (nop_v3<<dec_v3)  '  0F       RRCA                 ---0--0x
{10} long (un_v1<<dec_v1) + (un_v2<<dec_v2) + (un_v3<<dec_v3)
{11} long (get_code_word<<dec_v1) + (nop_v2<<dec_v2) + (setR16<<dec_v3) + (dec_d<<dec_reg_v3) '  11wlwm   LD DE,w              --------
{12} long (getR8<<dec_v1) + (nop_v2<<dec_v2) + (setBR16<<dec_v3) + (dec_d<<dec_reg_v3) + (dec_a<<dec_reg_v1) '  12       LD (DE),A            --------
{13} long (getR16<<dec_v1) + (opINC16<<dec_v2) + (setR16<<dec_v3) + (dec_d<<dec_reg_v1) + (dec_d<<dec_reg_v3) '  13       INC DE               --------
{14} long (getR8<<dec_v1) + (opINC<<dec_v2) + (setR8<<dec_v3) + (dec_d<<dec_reg_v1) + (dec_d<<dec_reg_v3)     '  14       INC D                sz-h-v0-
{15} long (getR8<<dec_v1) + (opDEC<<dec_v2) + (setR8<<dec_v3) + (dec_d<<dec_reg_v1) + (dec_d<<dec_reg_v3)     '  15       DEC D                sz-u-v1-
{16} long (get_code_byte<<dec_v1) + (nop_v2<<dec_v2) + (setR8<<dec_v3) + (dec_d<<dec_reg_v3) '  16bb     LD D,b               --------
{17} long (nop_v1<<dec_v1) + (opRLA<<dec_v2) + (nop_v3<<dec_v3)    '  17       RLA                  ---0--0x
{18} long (un_v1<<dec_v1) + (un_v2<<dec_v2) + (un_v3<<dec_v3)
{19} long (getR16<<dec_v1) + (opADD16<<dec_v2) + (setR16<<dec_v3) + (dec_d<<dec_reg_v1) + (dec_h<<dec_reg_v3) '  19       ADD HL,DE            ---H--0C
{1A} long (getBR16<<dec_v1) + (nop_v2<<dec_v2) + (setR8<<dec_v3) + (dec_d<<dec_reg_v1) + (dec_a<<dec_reg_v3) '  1A       LD A,(DE)            --------
{1B} long (getR16<<dec_v1) + (opDEC16<<dec_v2) + (setR16<<dec_v3) + (dec_d<<dec_reg_v1) + (dec_d<<dec_reg_v3) '  1B       DEC DE               --------
{1C} long (getR8<<dec_v1) + (opINC<<dec_v2) + (setR8<<dec_v3) + (dec_e<<dec_reg_v1) + (dec_e<<dec_reg_v3)     '  1C       INC E                sz-h-v0-
{1D} long (getR8<<dec_v1) + (opDEC<<dec_v2) + (setR8<<dec_v3) + (dec_e<<dec_reg_v1) + (dec_e<<dec_reg_v3)     '  1D       DEC E                sz-u-v1-
{1E} long (get_code_byte<<dec_v1) + (nop_v2<<dec_v2) + (setR8<<dec_v3) + (dec_e<<dec_reg_v3) '  1Ebb     LD E,b               --------
{1F} long (nop_v1<<dec_v1) + (opRRA<<dec_v2) + (nop_v3<<dec_v3)    '  1F       RRA                  ---0--0x
{20} long (un_v1<<dec_v1) + (un_v2<<dec_v2) + (un_v3<<dec_v3)
{21} long (get_code_word<<dec_v1) + (nop_v2<<dec_v2) + (setR16<<dec_v3) + (dec_h<<dec_reg_v3) '  21wlwm   LD HL,w              --------
{22} long (getR16<<dec_v1) + (nop_v2<<dec_v2) + (set_word_caddr<<dec_v3) + (dec_h<<dec_reg_v1)  '  22tltm   LD (t),HL            --------
{23} long (getR16<<dec_v1) + (opINC16<<dec_v2) + (setR16<<dec_v3) + (dec_h<<dec_reg_v1) + (dec_h<<dec_reg_v3) '  23       INC HL               --------
{24} long (getR8<<dec_v1) + (opINC<<dec_v2) + (setR8<<dec_v3) + (dec_h<<dec_reg_v1) + (dec_h<<dec_reg_v3)     '  24       INC H                sz-h-v0-
{25} long (getR8<<dec_v1) + (opDEC<<dec_v2) + (setR8<<dec_v3) + (dec_h<<dec_reg_v1) + (dec_h<<dec_reg_v3)     '  25       DEC H                sz-u-v1-
{26} long (get_code_byte<<dec_v1) + (nop_v2<<dec_v2) + (setR8<<dec_v3) + (dec_h<<dec_reg_v3) '  26bb     LD H,b               --------

' Not supporting DAA
{27} long (nop_v1<<Dv1)        + (nop_v2<<Dv2)  + (nop_v3<<Dv3)                                '  00      NOP          --------                                       

{28} long (un_v1<<dec_v1) + (un_v2<<dec_v2) + (un_v3<<dec_v3)
{29} long (getR16<<dec_v1) + (opADD16<<dec_v2) + (setR16<<dec_v3) + (dec_h<<dec_reg_v1) + (dec_h<<dec_reg_v3) '  29       ADD HL,HL            ---H--0C
{2A} long (get_word_caddr<<dec_v1) + (nop_v2<<dec_v2) + (setR16<<dec_v3) + (dec_h<<dec_reg_v3)  '  2Atltm   LD HL,(t)            --------
{2B} long (getR16<<dec_v1) + (opDEC16<<dec_v2) + (setR16<<dec_v3) + (dec_h<<dec_reg_v1) + (dec_h<<dec_reg_v3) '  2B       DEC HL               --------
{2C} long (getR8<<dec_v1) + (opINC<<dec_v2) + (setR8<<dec_v3) + (dec_l<<dec_reg_v1) + (dec_l<<dec_reg_v3)     '  2C       INC L                sz-h-v0-
{2D} long (getR8<<dec_v1) + (opDEC<<dec_v2) + (setR8<<dec_v3) + (dec_l<<dec_reg_v1) + (dec_l<<dec_reg_v3)     '  2D       DEC L                sz-u-v1-
{2E} long (get_code_byte<<dec_v1) + (nop_v2<<dec_v2) + (setR8<<dec_v3) + (dec_l<<dec_reg_v3) '  2Ebb     LD L,b               --------
{2F} long (nop_v1<<dec_v1) + (opCPL<<dec_v2) + (nop_v3<<dec_v3)    '  2F       CPL                  ---1--1-
{30} long (un_v1<<dec_v1) + (un_v2<<dec_v2) + (un_v3<<dec_v3)
{31} long (get_code_word<<dec_v1) + (nop_v2<<dec_v2) + (set_sp<<dec_v3)                       '  31wlwm   LD SP,w              --------
{32} long (getR8<<dec_v1) + (nop_v2<<dec_v2) + (set_byte_caddr<<dec_v3)  + (dec_a<<dec_reg_v1)  '  32tltm   LD (t),A             --------
{33} long (get_sp<<dec_v1) + (opINC16<<dec_v2) + (set_sp<<dec_v3)                                             '  33       INC SP               --------
{34} long (getBR16<<dec_v1) + (opINC<<dec_v2) + (setBR16<<dec_v3) + (dec_h<<dec_reg_v1) + (dec_h<<dec_reg_v3) '  34       INC (HL)             sz-h-v0-
{35} long (getBR16<<dec_v1) + (opDEC<<dec_v2) + (setBR16<<dec_v3) + (dec_h<<dec_reg_v1) + (dec_h<<dec_reg_v3) '  35       DEC (HL)             sz-u-v1-
{36} long (get_code_byte<<dec_v1) + (nop_v2<<dec_v2) + (setBR16<<dec_v3) + (dec_h<<dec_reg_v3)  '  36bb     LD (HL),b            --------
{37} long (nop_v1<<dec_v1) + (opSCF<<dec_v2) + (nop_v3<<dec_v3) '  37       SCF                  ---0--01                                     
{38} long (un_v1<<dec_v1) + (un_v2<<dec_v2) + (un_v3<<dec_v3)
{39} long (get_sp) + (opADD16<<dec_v2) + (setR16<<dec_v3)                               + (dec_h<<dec_reg_v3) '  39       ADD HL,SP            ---H--0C
{3A} long (get_byte_caddr<<dec_v1) + (nop_v2<<dec_v2) + (setR8<<dec_v3)  + (dec_a<<dec_reg_v3)  '  3Atltm   LD A,(t)             --------
{3B} long (get_sp<<dec_v1) + (opDEC16<<dec_v2) + (set_sp<<dec_v3)                                             '  3B       DEC SP               --------
{3C} long (getR8<<dec_v1) + (opINC<<dec_v2) + (setR8<<dec_v3) + (dec_a<<dec_reg_v1) + (dec_a<<dec_reg_v3)     '  3C       INC A                sz-h-v0-
{3D} long (getR8<<dec_v1) + (opDEC<<dec_v2) + (setR8<<dec_v3) + (dec_a<<dec_reg_v1) + (dec_a<<dec_reg_v3)     '  3D       DEC A                sz-u-v1-
{3E} long (get_code_byte<<dec_v1) + (nop_v2<<dec_v2) + (setR8<<dec_v3) + (dec_a<<dec_reg_v3) '  3Ebb     LD A,b               --------
{3F} long (nop_v1<<dec_v1) + (opCCF<<dec_v2) + (nop_v3<<dec_v3) '  3F       CCF                  ---x--0x
{40} long (getR8<<dec_v1) + (nop_v2<<dec_v2) + (setR8<<dec_v3) + (dec_b<<dec_reg_v1) + (dec_b<<dec_reg_v3) '  40       LD B,B               --------
{41} long (getR8<<dec_v1) + (nop_v2<<dec_v2) + (setR8<<dec_v3) + (dec_c<<dec_reg_v1) + (dec_b<<dec_reg_v3) '  41       LD B,C               --------
{42} long (getR8<<dec_v1) + (nop_v2<<dec_v2) + (setR8<<dec_v3) + (dec_d<<dec_reg_v1) + (dec_b<<dec_reg_v3) '  42       LD B,D               --------
{43} long (getR8<<dec_v1) + (nop_v2<<dec_v2) + (setR8<<dec_v3) + (dec_e<<dec_reg_v1) + (dec_b<<dec_reg_v3) '  43       LD B,E               --------
{44} long (getR8<<dec_v1) + (nop_v2<<dec_v2) + (setR8<<dec_v3) + (dec_h<<dec_reg_v1) + (dec_b<<dec_reg_v3) '  44       LD B,H               --------
{45} long (getR8<<dec_v1) + (nop_v2<<dec_v2) + (setR8<<dec_v3) + (dec_l<<dec_reg_v1) + (dec_b<<dec_reg_v3) '  45       LD B,L               --------
{46} long (getBR16<<dec_v1) + (nop_v2<<dec_v2) + (setR8<<dec_v3) + (dec_h<<dec_reg_v1) + (dec_b<<dec_reg_v3) '  46       LD B,(HL)            --------
{47} long (getR8<<dec_v1) + (nop_v2<<dec_v2) + (setR8<<dec_v3) + (dec_a<<dec_reg_v1) + (dec_b<<dec_reg_v3) '  47       LD B,A               --------
{48} long (getR8<<dec_v1) + (nop_v2<<dec_v2) + (setR8<<dec_v3) + (dec_b<<dec_reg_v1) + (dec_c<<dec_reg_v3) '  48       LD C,B               --------
{49} long (getR8<<dec_v1) + (nop_v2<<dec_v2) + (setR8<<dec_v3) + (dec_c<<dec_reg_v1) + (dec_c<<dec_reg_v3) '  49       LD C,C               --------
{4A} long (getR8<<dec_v1) + (nop_v2<<dec_v2) + (setR8<<dec_v3) + (dec_d<<dec_reg_v1) + (dec_c<<dec_reg_v3) '  4A       LD C,D               --------
{4B} long (getR8<<dec_v1) + (nop_v2<<dec_v2) + (setR8<<dec_v3) + (dec_e<<dec_reg_v1) + (dec_c<<dec_reg_v3) '  4B       LD C,E               --------
{4C} long (getR8<<dec_v1) + (nop_v2<<dec_v2) + (setR8<<dec_v3) + (dec_h<<dec_reg_v1) + (dec_c<<dec_reg_v3) '  4C       LD C,H               --------
{4D} long (getR8<<dec_v1) + (nop_v2<<dec_v2) + (setR8<<dec_v3) + (dec_l<<dec_reg_v1) + (dec_c<<dec_reg_v3) '  4D       LD C,L               --------
{4E} long (getBR16<<dec_v1) + (nop_v2<<dec_v2) + (setR8<<dec_v3) + (dec_h<<dec_reg_v1) + (dec_c<<dec_reg_v3) '  4E       LD C,(HL)            --------
{4F} long (getR8<<dec_v1) + (nop_v2<<dec_v2) + (setR8<<dec_v3) + (dec_a<<dec_reg_v1) + (dec_c<<dec_reg_v3) '  4F       LD C,A               --------
{50} long (getR8<<dec_v1) + (nop_v2<<dec_v2) + (setR8<<dec_v3) + (dec_b<<dec_reg_v1) + (dec_d<<dec_reg_v3) '  50       LD D,B               --------
{51} long (getR8<<dec_v1) + (nop_v2<<dec_v2) + (setR8<<dec_v3) + (dec_c<<dec_reg_v1) + (dec_d<<dec_reg_v3) '  51       LD D,C               --------
{52} long (getR8<<dec_v1) + (nop_v2<<dec_v2) + (setR8<<dec_v3) + (dec_d<<dec_reg_v1) + (dec_d<<dec_reg_v3) '  52       LD D,D               --------
{53} long (getR8<<dec_v1) + (nop_v2<<dec_v2) + (setR8<<dec_v3) + (dec_e<<dec_reg_v1) + (dec_d<<dec_reg_v3) '  53       LD D,E               --------
{54} long (getR8<<dec_v1) + (nop_v2<<dec_v2) + (setR8<<dec_v3) + (dec_h<<dec_reg_v1) + (dec_d<<dec_reg_v3) '  54       LD D,H               --------
{55} long (getR8<<dec_v1) + (nop_v2<<dec_v2) + (setR8<<dec_v3) + (dec_l<<dec_reg_v1) + (dec_d<<dec_reg_v3) '  55       LD D,L               --------
{56} long (getBR16<<dec_v1) + (nop_v2<<dec_v2) + (setR8<<dec_v3) + (dec_h<<dec_reg_v1) + (dec_d<<dec_reg_v3) '  56       LD D,(HL)            --------
{57} long (getR8<<dec_v1) + (nop_v2<<dec_v2) + (setR8<<dec_v3) + (dec_a<<dec_reg_v1) + (dec_d<<dec_reg_v3) '  57       LD D,A               --------
{58} long (getR8<<dec_v1) + (nop_v2<<dec_v2) + (setR8<<dec_v3) + (dec_b<<dec_reg_v1) + (dec_e<<dec_reg_v3) '  58       LD E,B               --------
{59} long (getR8<<dec_v1) + (nop_v2<<dec_v2) + (setR8<<dec_v3) + (dec_c<<dec_reg_v1) + (dec_e<<dec_reg_v3) '  59       LD E,C               --------
{5A} long (getR8<<dec_v1) + (nop_v2<<dec_v2) + (setR8<<dec_v3) + (dec_d<<dec_reg_v1) + (dec_e<<dec_reg_v3) '  5A       LD E,D               --------
{5B} long (getR8<<dec_v1) + (nop_v2<<dec_v2) + (setR8<<dec_v3) + (dec_e<<dec_reg_v1) + (dec_e<<dec_reg_v3) '  5B       LD E,E               --------
{5C} long (getR8<<dec_v1) + (nop_v2<<dec_v2) + (setR8<<dec_v3) + (dec_h<<dec_reg_v1) + (dec_e<<dec_reg_v3) '  5C       LD E,H               --------
{5D} long (getR8<<dec_v1) + (nop_v2<<dec_v2) + (setR8<<dec_v3) + (dec_l<<dec_reg_v1) + (dec_e<<dec_reg_v3) '  5D       LD E,L               --------
{5E} long (getBR16<<dec_v1) + (nop_v2<<dec_v2) + (setR8<<dec_v3) + (dec_h<<dec_reg_v1) + (dec_e<<dec_reg_v3) '  5E       LD E,(HL)            --------
{5F} long (getR8<<dec_v1) + (nop_v2<<dec_v2) + (setR8<<dec_v3) + (dec_a<<dec_reg_v1) + (dec_e<<dec_reg_v3) '  5F       LD E,A               --------
{60} long (getR8<<dec_v1) + (nop_v2<<dec_v2) + (setR8<<dec_v3) + (dec_b<<dec_reg_v1) + (dec_h<<dec_reg_v3) '  60       LD H,B               --------
{61} long (getR8<<dec_v1) + (nop_v2<<dec_v2) + (setR8<<dec_v3) + (dec_c<<dec_reg_v1) + (dec_h<<dec_reg_v3) '  61       LD H,C               --------
{62} long (getR8<<dec_v1) + (nop_v2<<dec_v2) + (setR8<<dec_v3) + (dec_d<<dec_reg_v1) + (dec_h<<dec_reg_v3) '  62       LD H,D               --------
{63} long (getR8<<dec_v1) + (nop_v2<<dec_v2) + (setR8<<dec_v3) + (dec_e<<dec_reg_v1) + (dec_h<<dec_reg_v3) '  63       LD H,E               --------
{64} long (getR8<<dec_v1) + (nop_v2<<dec_v2) + (setR8<<dec_v3) + (dec_h<<dec_reg_v1) + (dec_h<<dec_reg_v3) '  64       LD H,H               --------
{65} long (getR8<<dec_v1) + (nop_v2<<dec_v2) + (setR8<<dec_v3) + (dec_l<<dec_reg_v1) + (dec_h<<dec_reg_v3) '  65       LD H,L               --------
{66} long (getBR16<<dec_v1) + (nop_v2<<dec_v2) + (setR8<<dec_v3) + (dec_h<<dec_reg_v1) + (dec_h<<dec_reg_v3) '  66       LD H,(HL)            --------
{67} long (getR8<<dec_v1) + (nop_v2<<dec_v2) + (setR8<<dec_v3) + (dec_a<<dec_reg_v1) + (dec_h<<dec_reg_v3) '  67       LD H,A               --------
{68} long (getR8<<dec_v1) + (nop_v2<<dec_v2) + (setR8<<dec_v3) + (dec_b<<dec_reg_v1) + (dec_l<<dec_reg_v3) '  68       LD L,B               --------
{69} long (getR8<<dec_v1) + (nop_v2<<dec_v2) + (setR8<<dec_v3) + (dec_c<<dec_reg_v1) + (dec_l<<dec_reg_v3) '  69       LD L,C               --------
{6A} long (getR8<<dec_v1) + (nop_v2<<dec_v2) + (setR8<<dec_v3) + (dec_d<<dec_reg_v1) + (dec_l<<dec_reg_v3) '  6A       LD L,D               --------
{6B} long (getR8<<dec_v1) + (nop_v2<<dec_v2) + (setR8<<dec_v3) + (dec_e<<dec_reg_v1) + (dec_l<<dec_reg_v3) '  6B       LD L,E               --------
{6C} long (getR8<<dec_v1) + (nop_v2<<dec_v2) + (setR8<<dec_v3) + (dec_h<<dec_reg_v1) + (dec_l<<dec_reg_v3) '  6C       LD L,H               --------
{6D} long (getR8<<dec_v1) + (nop_v2<<dec_v2) + (setR8<<dec_v3) + (dec_l<<dec_reg_v1) + (dec_l<<dec_reg_v3) '  6D       LD L,L               --------
{6E} long (getBR16<<dec_v1) + (nop_v2<<dec_v2) + (setR8<<dec_v3) + (dec_h<<dec_reg_v1) + (dec_l<<dec_reg_v3) '  6E       LD L,(HL)            --------
{6F} long (getR8<<dec_v1) + (nop_v2<<dec_v2) + (setR8<<dec_v3) + (dec_a<<dec_reg_v1) + (dec_l<<dec_reg_v3) '  6F       LD L,A               --------
{70} long (getR8<<dec_v1) + (nop_v2<<dec_v2) + (setBR16<<dec_v3) + (dec_h<<dec_reg_v3) + (dec_b<<dec_reg_v1) '  70       LD (HL),B            --------
{71} long (getR8<<dec_v1) + (nop_v2<<dec_v2) + (setBR16<<dec_v3) + (dec_h<<dec_reg_v3) + (dec_c<<dec_reg_v1) '  71       LD (HL),C            --------
{72} long (getR8<<dec_v1) + (nop_v2<<dec_v2) + (setBR16<<dec_v3) + (dec_h<<dec_reg_v3) + (dec_d<<dec_reg_v1) '  72       LD (HL),D            --------
{73} long (getR8<<dec_v1) + (nop_v2<<dec_v2) + (setBR16<<dec_v3) + (dec_h<<dec_reg_v3) + (dec_e<<dec_reg_v1) '  73       LD (HL),E            --------
{74} long (getR8<<dec_v1) + (nop_v2<<dec_v2) + (setBR16<<dec_v3) + (dec_h<<dec_reg_v3) + (dec_h<<dec_reg_v1) '  74       LD (HL),H            --------
{75} long (getR8<<dec_v1) + (nop_v2<<dec_v2) + (setBR16<<dec_v3) + (dec_h<<dec_reg_v3) + (dec_l<<dec_reg_v1) '  75       LD (HL),L            --------
{76} long (nop_v1<<dec_v1)        + (halt<<dec_v2)  + (nop_v3<<dec_v3) '  76       HALT                 xxxxxxxx                 
{77} long (getR8<<dec_v1) + (nop_v2<<dec_v2) + (setBR16<<dec_v3) + (dec_h<<dec_reg_v3) + (dec_a<<dec_reg_v1) '  77       LD (HL),A            --------
{78} long (getR8<<dec_v1) + (nop_v2<<dec_v2) + (setR8<<dec_v3) + (dec_b<<dec_reg_v1) + (dec_a<<dec_reg_v3) '  78       LD A,B               --------
{79} long (getR8<<dec_v1) + (nop_v2<<dec_v2) + (setR8<<dec_v3) + (dec_c<<dec_reg_v1) + (dec_a<<dec_reg_v3) '  79       LD A,C               --------
{7A} long (getR8<<dec_v1) + (nop_v2<<dec_v2) + (setR8<<dec_v3) + (dec_d<<dec_reg_v1) + (dec_a<<dec_reg_v3) '  7A       LD A,D               --------
{7B} long (getR8<<dec_v1) + (nop_v2<<dec_v2) + (setR8<<dec_v3) + (dec_e<<dec_reg_v1) + (dec_a<<dec_reg_v3) '  7B       LD A,E               --------
{7C} long (getR8<<dec_v1) + (nop_v2<<dec_v2) + (setR8<<dec_v3) + (dec_h<<dec_reg_v1) + (dec_a<<dec_reg_v3) '  7C       LD A,H               --------
{7D} long (getR8<<dec_v1) + (nop_v2<<dec_v2) + (setR8<<dec_v3) + (dec_l<<dec_reg_v1) + (dec_a<<dec_reg_v3) '  7D       LD A,L               --------
{7E} long (getBR16<<dec_v1) + (nop_v2<<dec_v2) + (setR8<<dec_v3) + (dec_h<<dec_reg_v1) + (dec_a<<dec_reg_v3) '  7E       LD A,(HL)            --------
{7F} long (getR8<<dec_v1) + (nop_v2<<dec_v2) + (setR8<<dec_v3) + (dec_a<<dec_reg_v1) + (dec_a<<dec_reg_v3) '  7F       LD A,A               --------
{80} long (getR8<<dec_v1) + (opADD<<dec_v2) + (setR8<<dec_v3)   + (dec_b<<dec_reg_v1) + (dec_a<<dec_reg_v3) '  80       ADD A,B              sz-h-v0c
{81} long (getR8<<dec_v1) + (opADD<<dec_v2) + (setR8<<dec_v3)   + (dec_c<<dec_reg_v1) + (dec_a<<dec_reg_v3) '  81       ADD A,C              sz-h-v0c
{82} long (getR8<<dec_v1) + (opADD<<dec_v2) + (setR8<<dec_v3)   + (dec_d<<dec_reg_v1) + (dec_a<<dec_reg_v3) '  82       ADD A,D              sz-h-v0c
{83} long (getR8<<dec_v1) + (opADD<<dec_v2) + (setR8<<dec_v3)   + (dec_e<<dec_reg_v1) + (dec_a<<dec_reg_v3) '  83       ADD A,E              sz-h-v0c
{84} long (getR8<<dec_v1) + (opADD<<dec_v2) + (setR8<<dec_v3)   + (dec_h<<dec_reg_v1) + (dec_a<<dec_reg_v3) '  84       ADD A,H              sz-h-v0c
{85} long (getR8<<dec_v1) + (opADD<<dec_v2) + (setR8<<dec_v3)   + (dec_l<<dec_reg_v1) + (dec_a<<dec_reg_v3) '  85       ADD A,L              sz-h-v0c
{86} long (getBR16<<dec_v1) + (opADD<<dec_v2) + (setR8<<dec_v3) + (dec_h<<dec_reg_v1) + (dec_a<<dec_reg_v3) '  86       ADD A,(HL)           sz-h-v0c
{87} long (getR8<<dec_v1) + (opADD<<dec_v2) + (setR8<<dec_v3)   + (dec_a<<dec_reg_v1) + (dec_a<<dec_reg_v3) '  87       ADD A,A              sz-h-v0c
{88} long (getR8<<dec_v1) + (opADC<<dec_v2) + (setR8<<dec_v3)   + (dec_b<<dec_reg_v1) + (dec_a<<dec_reg_v3) '  88       ADC A,B              sz-h-v0c
{89} long (getR8<<dec_v1) + (opADC<<dec_v2) + (setR8<<dec_v3)   + (dec_c<<dec_reg_v1) + (dec_a<<dec_reg_v3) '  89       ADC A,C              sz-h-v0c
{8A} long (getR8<<dec_v1) + (opADC<<dec_v2) + (setR8<<dec_v3)   + (dec_d<<dec_reg_v1) + (dec_a<<dec_reg_v3) '  8A       ADC A,D              sz-h-v0c
{8B} long (getR8<<dec_v1) + (opADC<<dec_v2) + (setR8<<dec_v3)   + (dec_e<<dec_reg_v1) + (dec_a<<dec_reg_v3) '  8B       ADC A,E              sz-h-v0c
{8C} long (getR8<<dec_v1) + (opADC<<dec_v2) + (setR8<<dec_v3)   + (dec_h<<dec_reg_v1) + (dec_a<<dec_reg_v3) '  8C       ADC A,H              sz-h-v0c
{8D} long (getR8<<dec_v1) + (opADC<<dec_v2) + (setR8<<dec_v3)   + (dec_l<<dec_reg_v1) + (dec_a<<dec_reg_v3) '  8D       ADC A,L              sz-h-v0c
{8E} long (getBR16<<dec_v1) + (opADC<<dec_v2) + (setR8<<dec_v3) + (dec_h<<dec_reg_v1) + (dec_a<<dec_reg_v3) '  8E       ADC A,(HL)           sz-h-v0c
{8F} long (getR8<<dec_v1) + (opADC<<dec_v2) + (setR8<<dec_v3)   + (dec_a<<dec_reg_v1) + (dec_a<<dec_reg_v3) '  8F       ADC A,A              sz-h-v0c
{90} long (getR8<<dec_v1) + (opSUB<<dec_v2) + (setR8<<dec_v3)   + (dec_b<<dec_reg_v1) + (dec_a<<dec_reg_v3) '  90       SUB B                sz-u-v1b
{91} long (getR8<<dec_v1) + (opSUB<<dec_v2) + (setR8<<dec_v3)   + (dec_c<<dec_reg_v1) + (dec_a<<dec_reg_v3) '  91       SUB C                sz-u-v1b
{92} long (getR8<<dec_v1) + (opSUB<<dec_v2) + (setR8<<dec_v3)   + (dec_d<<dec_reg_v1) + (dec_a<<dec_reg_v3) '  92       SUB D                sz-u-v1b
{93} long (getR8<<dec_v1) + (opSUB<<dec_v2) + (setR8<<dec_v3)   + (dec_e<<dec_reg_v1) + (dec_a<<dec_reg_v3) '  93       SUB E                sz-u-v1b
{94} long (getR8<<dec_v1) + (opSUB<<dec_v2) + (setR8<<dec_v3)   + (dec_h<<dec_reg_v1) + (dec_a<<dec_reg_v3) '  94       SUB H                sz-u-v1b
{95} long (getR8<<dec_v1) + (opSUB<<dec_v2) + (setR8<<dec_v3)   + (dec_l<<dec_reg_v1) + (dec_a<<dec_reg_v3) '  95       SUB L                sz-u-v1b
{96} long (getBR16<<dec_v1) + (opSUB<<dec_v2) + (setR8<<dec_v3) + (dec_h<<dec_reg_v1) + (dec_a<<dec_reg_v3) '  96       SUB (HL)             sz-u-v1b
{97} long (getR8<<dec_v1) + (opSUB<<dec_v2) + (setR8<<dec_v3)   + (dec_a<<dec_reg_v1) + (dec_a<<dec_reg_v3) '  97       SUB A                sz-u-v1b
{98} long (getR8<<dec_v1) + (opSBC<<dec_v2) + (setR8<<dec_v3)   + (dec_b<<dec_reg_v1) + (dec_a<<dec_reg_v3) '  98       SBC B                sz-u-v1b
{99} long (getR8<<dec_v1) + (opSBC<<dec_v2) + (setR8<<dec_v3)   + (dec_c<<dec_reg_v1) + (dec_a<<dec_reg_v3) '  99       SBC C                sz-u-v1b
{9A} long (getR8<<dec_v1) + (opSBC<<dec_v2) + (setR8<<dec_v3)   + (dec_d<<dec_reg_v1) + (dec_a<<dec_reg_v3) '  9A       SBC D                sz-u-v1b
{9B} long (getR8<<dec_v1) + (opSBC<<dec_v2) + (setR8<<dec_v3)   + (dec_e<<dec_reg_v1) + (dec_a<<dec_reg_v3) '  9B       SBC E                sz-u-v1b
{9C} long (getR8<<dec_v1) + (opSBC<<dec_v2) + (setR8<<dec_v3)   + (dec_h<<dec_reg_v1) + (dec_a<<dec_reg_v3) '  9C       SBC H                sz-u-v1b
{9D} long (getR8<<dec_v1) + (opSBC<<dec_v2) + (setR8<<dec_v3)   + (dec_l<<dec_reg_v1) + (dec_a<<dec_reg_v3) '  9D       SBC L                sz-u-v1b
{9E} long (getBR16<<dec_v1) + (opSBC<<dec_v2) + (setR8<<dec_v3) + (dec_h<<dec_reg_v1) + (dec_a<<dec_reg_v3) '  9E       SBC (HL)             sz-u-v1b
{9F} long (getR8<<dec_v1) + (opSBC<<dec_v2) + (setR8<<dec_v3)   + (dec_a<<dec_reg_v1) + (dec_a<<dec_reg_v3) '  9F       SBC A                sz-u-v1b
{A0} long (getR8<<dec_v1) + (opAND<<dec_v2) + (setR8<<dec_v3)   + (dec_b<<dec_reg_v1) + (dec_a<<dec_reg_v3) '  A0       AND B                sz-1-p00
{A1} long (getR8<<dec_v1) + (opAND<<dec_v2) + (setR8<<dec_v3)   + (dec_c<<dec_reg_v1) + (dec_a<<dec_reg_v3) '  A1       AND C                sz-1-p00
{A2} long (getR8<<dec_v1) + (opAND<<dec_v2) + (setR8<<dec_v3)   + (dec_d<<dec_reg_v1) + (dec_a<<dec_reg_v3) '  A2       AND D                sz-1-p00
{A3} long (getR8<<dec_v1) + (opAND<<dec_v2) + (setR8<<dec_v3)   + (dec_e<<dec_reg_v1) + (dec_a<<dec_reg_v3) '  A3       AND E                sz-1-p00
{A4} long (getR8<<dec_v1) + (opAND<<dec_v2) + (setR8<<dec_v3)   + (dec_h<<dec_reg_v1) + (dec_a<<dec_reg_v3) '  A4       AND H                sz-1-p00
{A5} long (getR8<<dec_v1) + (opAND<<dec_v2) + (setR8<<dec_v3)   + (dec_l<<dec_reg_v1) + (dec_a<<dec_reg_v3) '  A5       AND L                sz-1-p00
{A6} long (getBR16<<dec_v1) + (opAND<<dec_v2) + (setR8<<dec_v3) + (dec_h<<dec_reg_v1) + (dec_a<<dec_reg_v3) '  A6       AND (HL)             sz-1-p00
{A7} long (getR8<<dec_v1) + (opAND<<dec_v2) + (setR8<<dec_v3)   + (dec_a<<dec_reg_v1) + (dec_a<<dec_reg_v3) '  A7       AND A                sz-1-p00
{A8} long (getR8<<dec_v1) + (opXOR<<dec_v2) + (setR8<<dec_v3)   + (dec_b<<dec_reg_v1) + (dec_a<<dec_reg_v3) '  A8       XOR B                sz-0-p00
{A9} long (getR8<<dec_v1) + (opXOR<<dec_v2) + (setR8<<dec_v3)   + (dec_c<<dec_reg_v1) + (dec_a<<dec_reg_v3) '  A9       XOR C                sz-0-p00
{AA} long (getR8<<dec_v1) + (opXOR<<dec_v2) + (setR8<<dec_v3)   + (dec_d<<dec_reg_v1) + (dec_a<<dec_reg_v3) '  AA       XOR D                sz-0-p00
{AB} long (getR8<<dec_v1) + (opXOR<<dec_v2) + (setR8<<dec_v3)   + (dec_e<<dec_reg_v1) + (dec_a<<dec_reg_v3) '  AB       XOR E                sz-0-p00
{AC} long (getR8<<dec_v1) + (opXOR<<dec_v2) + (setR8<<dec_v3)   + (dec_h<<dec_reg_v1) + (dec_a<<dec_reg_v3) '  AC       XOR H                sz-0-p00
{AD} long (getR8<<dec_v1) + (opXOR<<dec_v2) + (setR8<<dec_v3)   + (dec_l<<dec_reg_v1) + (dec_a<<dec_reg_v3) '  AD       XOR L                sz-0-p00
{AE} long (getBR16<<dec_v1) + (opXOR<<dec_v2) + (setR8<<dec_v3) + (dec_h<<dec_reg_v1) + (dec_a<<dec_reg_v3) '  AE       XOR (HL)             sz-0-p00
{AF} long (getR8<<dec_v1) + (opXOR<<dec_v2) + (setR8<<dec_v3)   + (dec_a<<dec_reg_v1) + (dec_a<<dec_reg_v3) '  AF       XOR A                sz-0-p00
{B0} long (getR8<<dec_v1) + (opOR<<dec_v2) + (setR8<<dec_v3)   + (dec_b<<dec_reg_v1) + (dec_a<<dec_reg_v3) '  B0       OR B                 sz-0-p00
{B1} long (getR8<<dec_v1) + (opOR<<dec_v2) + (setR8<<dec_v3)   + (dec_c<<dec_reg_v1) + (dec_a<<dec_reg_v3) '  B1       OR C                 sz-0-p00
{B2} long (getR8<<dec_v1) + (opOR<<dec_v2) + (setR8<<dec_v3)   + (dec_d<<dec_reg_v1) + (dec_a<<dec_reg_v3) '  B2       OR D                 sz-0-p00
{B3} long (getR8<<dec_v1) + (opOR<<dec_v2) + (setR8<<dec_v3)   + (dec_e<<dec_reg_v1) + (dec_a<<dec_reg_v3) '  B3       OR E                 sz-0-p00
{B4} long (getR8<<dec_v1) + (opOR<<dec_v2) + (setR8<<dec_v3)   + (dec_h<<dec_reg_v1) + (dec_a<<dec_reg_v3) '  B4       OR H                 sz-0-p00
{B5} long (getR8<<dec_v1) + (opOR<<dec_v2) + (setR8<<dec_v3)   + (dec_l<<dec_reg_v1) + (dec_a<<dec_reg_v3) '  B5       OR L                 sz-0-p00
{B6} long (getBR16<<dec_v1) + (opOR<<dec_v2) + (setR8<<dec_v3) + (dec_h<<dec_reg_v1) + (dec_a<<dec_reg_v3) '  B6       OR (HL)              sz-0-p00
{B7} long (getR8<<dec_v1) + (opOR<<dec_v2) + (setR8<<dec_v3)   + (dec_a<<dec_reg_v1) + (dec_a<<dec_reg_v3) '  B7       OR A                 sz-0-p00
{B8} long (getR8<<dec_v1) + (opSUB<<dec_v2) + (nop_v3<<dec_v3) + (dec_b<<dec_reg_v1)   '  B8       CP B                 sz-u-v1b
{B9} long (getR8<<dec_v1) + (opSUB<<dec_v2) + (nop_v3<<dec_v3) + (dec_c<<dec_reg_v1)   '  B9       CP C                 sz-u-v1b
{BA} long (getR8<<dec_v1) + (opSUB<<dec_v2) + (nop_v3<<dec_v3) + (dec_d<<dec_reg_v1)   '  BA       CP D                 sz-u-v1b
{BB} long (getR8<<dec_v1) + (opSUB<<dec_v2) + (nop_v3<<dec_v3) + (dec_e<<dec_reg_v1)   '  BB       CP E                 sz-u-v1b
{BC} long (getR8<<dec_v1) + (opSUB<<dec_v2) + (nop_v3<<dec_v3) + (dec_h<<dec_reg_v1)   '  BC       CP H                 sz-u-v1b
{BD} long (getR8<<dec_v1) + (opSUB<<dec_v2) + (nop_v3<<dec_v3) + (dec_l<<dec_reg_v1)   '  BD       CP L                 sz-u-v1b
{BE} long (getBR16<<dec_v1) + (opSUB<<dec_v2) + (nop_v3<<dec_v3) + (dec_h<<dec_reg_v1) '  BE       CP (HL)              sz-u-v1b
{BF} long (getR8<<dec_v1) + (opSUB<<dec_v2) + (nop_v3<<dec_v3) + (dec_a<<dec_reg_v1)   '  BF       CP A                 sz-u-v1b
{C0} long (nop_v1<<dec_v1) + (flagClearOrSkip<<dec_v2) + (pop_pc<<dec_v3) + (bn_zero<<dec_param)    '  C0       RET NZ               --------
{C1} long (nop_v1<<dec_v1) + (nop_v2<<dec_v2) + (popReg<<dec_v3)  + (dec_b<<dec_reg_v3) '  C1       POP BC               --------
{C2} long (get_code_word<<dec_v1) + (flagClearOrSkip<<dec_v2) + (set_pc<<dec_v3) + (bn_zero<<dec_param)    '  C2mlmm   JP NZ,m              --------
{C3} long (get_code_word<<dec_v1) + (nop_v2<<dec_v2)          + (set_pc<<dec_v3)                       '  C3mlmm   JP m                 --------
{C4} long (get_code_word<<dec_v1) + (flagClearOrSkip<<dec_v2) + (push_set_pc<<dec_v3) + (bn_zero<<dec_param)   '  C4mlmm   CALL NZ,m            --------
{C5} long (nop_v1<<dec_v1) + (nop_v2<<dec_v2) + (pushReg<<dec_v3) + (dec_b<<dec_reg_v3) '  C5       PUSH BC              --------
{C6} long (get_code_byte<<dec_v1) + (opADD<<dec_v2) + (setR8<<dec_v3)                 + (dec_a<<dec_reg_v3) '  C6bb     ADD A,b              sz-h-v0c
{C7} long (nop_v1<<dec_v1) + (nop_v2<<dec_v2) + (set_pc_rst<<dec_v3) + (0<<dec_param) '  C7       RST $00              --------
{C8} long (nop_v1<<dec_v1) + (flagSetOrSkip<<dec_v2)   + (pop_pc<<dec_v3) + (bn_zero<<dec_param)    '  C8       RET Z                --------
{C9} long (nop_v1<<dec_v1) + (nop_v2<<dec_v2)          + (pop_pc<<dec_v3)                           '  C9       RET                  -------- 
{CA} long (get_code_word<<dec_v1) + (flagSetOrSkip<<dec_v2)   + (set_pc<<dec_v3) + (bn_zero<<dec_param)    '  CAmlmm   JP Z,m               --------
{CB} long (un_v1<<dec_v1) + (un_v2<<dec_v2) + (un_v3<<dec_v3)
{CC} long (get_code_word<<dec_v1) + (flagSetOrSkip<<dec_v2)   + (push_set_pc<<dec_v3) + (bn_zero<<dec_param)   '  CCmlmm   CALL Z,m             --------               
{CD} long (get_code_word<<dec_v1) + (nop_v2<<dec_v2)          + (push_set_pc<<dec_v3)                          '  CDmlmm   CALL m               --------
{CE} long (get_code_byte<<dec_v1) + (opADC<<dec_v2) + (setR8<<dec_v3)                 + (dec_a<<dec_reg_v3) '  CEbb     ADC A,b              sz-h-v0c
{CF} long (nop_v1<<dec_v1) + (nop_v2<<dec_v2) + (set_pc_rst<<dec_v3) + (1<<dec_param) '  CF       RST $08              --------
{D0} long (nop_v1<<dec_v1) + (flagClearOrSkip<<dec_v2) + (pop_pc<<dec_v3) + (bn_carry<<dec_param)   '  D0       RET NC               --------
{D1} long (nop_v1<<dec_v1) + (nop_v2<<dec_v2) + (popReg<<dec_v3)  + (dec_d<<dec_reg_v3) '  D1       POP DE               --------
{D2} long (get_code_word<<dec_v1) + (flagClearOrSkip<<dec_v2) + (set_pc<<dec_v3) + (bn_carry<<dec_param)   '  D2mlmm   JP NC,m              --------
{D3} long (get_code_byte<<dec_v1) + (ioOut<<dec_v2) + (nop_v3<<dec_v3) '  D3oo     OUT (o),A            --------
{D4} long (get_code_word<<dec_v1) + (flagClearOrSkip<<dec_v2) + (push_set_pc<<dec_v3) + (bn_carry<<dec_param)  '  D4mlmm   CALL NC,m            --------
{D5} long (nop_v1<<dec_v1) + (nop_v2<<dec_v2) + (pushReg<<dec_v3) + (dec_d<<dec_reg_v3) '  D5       PUSH DE              --------
{D6} long (get_code_byte<<dec_v1) + (opSUB<<dec_v2) + (setR8<<dec_v3)                 + (dec_a<<dec_reg_v3) '  D6bb     SUB b                sz-u-v1b
{D7} long (nop_v1<<dec_v1) + (nop_v2<<dec_v2) + (set_pc_rst<<dec_v3) + (2<<dec_param) '  D7       RST $10              --------
{D8} long (nop_v1<<dec_v1) + (flagSetOrSkip<<dec_v2)   + (pop_pc<<dec_v3) + (bn_carry<<dec_param)   '  D8       RET C                --------
{D9} long (un_v1<<dec_v1) + (un_v2<<dec_v2) + (un_v3<<dec_v3)
{DA} long (get_code_word<<dec_v1) + (flagSetOrSkip<<dec_v2)   + (set_pc<<dec_v3) + (bn_carry<<dec_param)   '  DAmlmm   JP C,m               --------
{DB} long (get_code_byte<<dec_v1) + (ioIn<<dec_v2)  + (nop_v3<<dec_v3) '  DBoo     IN A,(o)             --------
{DC} long (get_code_word<<dec_v1) + (flagSetOrSkip<<dec_v2)   + (push_set_pc<<dec_v3) + (bn_carry<<dec_param)  '  DCmlmm   CALL C,m             --------
{DD} long (un_v1<<dec_v1) + (un_v2<<dec_v2) + (un_v3<<dec_v3)
{DE} long (get_code_byte<<dec_v1) + (opSBC<<dec_v2) + (setR8<<dec_v3)                 + (dec_a<<dec_reg_v3) '  DEbb     SBC A,b              sz-u-v1b
{DF} long (nop_v1<<dec_v1) + (nop_v2<<dec_v2) + (set_pc_rst<<dec_v3) + (3<<dec_param) '  DF       RST $18              --------
{E0} long (nop_v1<<dec_v1) + (flagClearOrSkip<<dec_v2) + (pop_pc<<dec_v3) + (bn_parity<<dec_param)  '  E0       RET PO               --------
{E1} long (nop_v1<<dec_v1) + (nop_v2<<dec_v2) + (popReg<<dec_v3)  + (dec_h<<dec_reg_v3) '  E1       POP HL               --------
{E2} long (get_code_word<<dec_v1) + (flagClearOrSkip<<dec_v2) + (set_pc<<dec_v3) + (bn_parity<<dec_param)  '  E2mlmm   JP PO,m              --------
{E3} long (nop_v1<<dec_v1) + (opEXSPHL<<dec_v2) + (nop_v3<<dec_v3) '  E3       EX (SP),HL           --------
{E4} long (get_code_word<<dec_v1) + (flagClearOrSkip<<dec_v2) + (push_set_pc<<dec_v3) + (bn_parity<<dec_param) '  E4mlmm   CALL PO,m            --------
{E5} long (nop_v1<<dec_v1) + (nop_v2<<dec_v2) + (pushReg<<dec_v3) + (dec_h<<dec_reg_v3) '  E5       PUSH HL              --------
{E6} long (get_code_byte<<dec_v1) + (opAND<<dec_v2) + (setR8<<dec_v3)                 + (dec_a<<dec_reg_v3) '  E6bb     AND b                sz-1-p00
{E7} long (nop_v1<<dec_v1) + (nop_v2<<dec_v2) + (set_pc_rst<<dec_v3) + (4<<dec_param) '  E7       RST $20              --------
{E8} long (nop_v1<<dec_v1) + (flagSetOrSkip<<dec_v2)   + (pop_pc<<dec_v3) + (bn_parity<<dec_param)  '  E8       RET PE               --------
{E9} long (getR16<<dec_v1)   + (nop_v2<<dec_v2)          + (set_pc<<dec_v3) + (dec_h<<dec_reg_v1)                      '  E9       JP (HL)              --------
{EA} long (get_code_word<<dec_v1) + (flagSetOrSkip<<dec_v2)   + (set_pc<<dec_v3) + (bn_parity<<dec_param)  '  EAmlmm   JP PE,m              --------
{EB} long (nop_v1<<dec_v1) + (opEXDEHL<<dec_v2) + (nop_v3<<dec_v3) '  EB       EX DE,HL             --------
{EC} long (get_code_word<<dec_v1) + (flagSetOrSkip<<dec_v2)   + (push_set_pc<<dec_v3) + (bn_parity<<dec_param) '  ECmlmm   CALL PE,m            --------
{ED} long (un_v1<<dec_v1) + (un_v2<<dec_v2) + (un_v3<<dec_v3)
{EE} long (get_code_byte<<dec_v1) + (opXOR<<dec_v2) + (setR8<<dec_v3)                 + (dec_a<<dec_reg_v3) '  EEbb     XOR b                sz-0-p00
{EF} long (nop_v1<<dec_v1) + (nop_v2<<dec_v2) + (set_pc_rst<<dec_v3) + (5<<dec_param) '  EF       RST $28              --------
{F0} long (nop_v1<<dec_v1) + (flagClearOrSkip<<dec_v2) + (pop_pc<<dec_v3) + (bn_sign<<dec_param)    '  F0       RET P                --------
{F1} long (nop_v1<<dec_v1) + (nop_v2<<dec_v2) + (popReg<<dec_v3)  + (dec_a<<dec_reg_v3) '  F1       POP AF               xxxxxxxx
{F2} long (get_code_word<<dec_v1) + (flagClearOrSkip<<dec_v2) + (set_pc<<dec_v3) + (bn_sign<<dec_param)    '  F2mlmm   JP P,m               --------
{F3} long (nop_v1<<dec_v1) + (enableInt<<dec_v2) + (nop_v3<<dec_v3) + (0<<dec_param) '  F3       DI                   xxxxxxxx
{F4} long (get_code_word<<dec_v1) + (flagClearOrSkip<<dec_v2) + (push_set_pc<<dec_v3) + (bn_sign<<dec_param)   '  F4mlmm   CALL P,m             --------
{F5} long (nop_v1<<dec_v1) + (nop_v2<<dec_v2) + (pushReg<<dec_v3) + (dec_a<<dec_reg_v3) '  F5       PUSH AF              --------
{F6} long (get_code_byte<<dec_v1) + (opOR<<dec_v2) + (setR8<<dec_v3)                 + (dec_a<<dec_reg_v3) '  F6bb     OR b                 sz-0-p00
{F7} long (nop_v1<<dec_v1) + (nop_v2<<dec_v2) + (set_pc_rst<<dec_v3) + (6<<dec_param) '  F7       RST $30              --------
{F8} long (nop_v1<<dec_v1) + (flagSetOrSkip<<dec_v2)   + (pop_pc<<dec_v3) + (bn_sign<<dec_param)    '  F8       RET M                --------
{F9} long (getR16<<dec_v1) + (nop_v2<<dec_v2) + (set_sp<<dec_v3) + (dec_h<<dec_reg_v1)          '  F9       LD SP,HL             --------
{FA} long (get_code_word<<dec_v1) + (flagSetOrSkip<<dec_v2)   + (set_pc<<dec_v3) + (bn_sign<<dec_param)    '  FAmlmm   JP M,m               --------
{FB} long (nop_v1<<dec_v1) + (enableInt<<dec_v2) + (nop_v3<<dec_v3) + (1<<dec_param) '  FB       EI                   xxxxxxxx
{FC} long (get_code_word<<dec_v1) + (flagSetOrSkip<<dec_v2)   + (push_set_pc<<dec_v3) + (bn_sign<<dec_param)   '  FCmlmm   CALL M,m             --------
{FD} long (un_v1<<dec_v1) + (un_v2<<dec_v2) + (un_v3<<dec_v3)
{FE} long (get_code_byte<<dec_v1) + (opSUB<<dec_v2) + (nop_v3<<dec_v3)                 '  FEbb     CP b                 sz-u-v1b
{FF} long (nop_v1<<dec_v1) + (nop_v2<<dec_v2) + (set_pc_rst<<dec_v3) + (7<<dec_param) '  FF       RST $38              --------


{
08         EX AF,AF'        xxxxxxxx
10rr       DJNZ r           xxxxxxxx
18rr       JR r             --------
20rr       JR NZ,r          --------
28rr       JR Z,r           --------
30rr       JR NC,r          --------
38rr       JR C,r           --------
D9         EXX              xxxxxxxx




CB00       RLC B            sz-0-p0x
CB01       RLC C            sz-0-p0x
CB02       RLC D            sz-0-p0x
CB03       RLC E            sz-0-p0x
CB04       RLC H            sz-0-p0x
CB05       RLC L            sz-0-p0x
CB06       RLC (HL)         sz-0-p0x
CB07       RLC A            sz-0-p0x
CB08       RRC B            sz-0-p0x
CB09       RRC C            sz-0-p0x
CB0A       RRC D            sz-0-p0x
CB0B       RRC E            sz-0-p0x
CB0C       RRC H            sz-0-p0x
CB0D       RRC L            sz-0-p0x
CB0E       RRC (HL)         sz-0-p0x
CB0F       RRC A            sz-0-p0x
CB10       RL B             sz-0-p0x
CB11       RL C             sz-0-p0x
CB12       RL D             sz-0-p0x
CB13       RL E             sz-0-p0x
CB14       RL H             sz-0-p0x
CB15       RL L             sz-0-p0x
CB16       RL (HL)          sz-0-p0x
CB17       RL A             sz-0-p0x
CB18       RR B             sz-0-p0x
CB19       RR C             sz-0-p0x
CB1A       RR D             sz-0-p0x
CB1B       RR E             sz-0-p0x
CB1C       RR H             sz-0-p0x
CB1D       RR L             sz-0-p0x
CB1E       RR (HL)          sz-0-p0x
CB1F       RR A             sz-0-p0x
CB20       SLA B            sz-0-p0x
CB21       SLA C            sz-0-p0x
CB22       SLA D            sz-0-p0x
CB23       SLA E            sz-0-p0x
CB24       SLA H            sz-0-p0x
CB25       SLA L            sz-0-p0x
CB26       SLA (HL)         sz-0-p0x
CB27       SLA A            sz-0-p0x
CB28       SRA B            sz-0-p0x
CB29       SRA C            sz-0-p0x
CB2A       SRA D            sz-0-p0x
CB2B       SRA E            sz-0-p0x
CB2C       SRA H            sz-0-p0x
CB2D       SRA L            sz-0-p0x
CB2E       SRA (HL)         sz-0-p0x
CB2F       SRA A            sz-0-p0x
CB38       SRL B            sz-0-p0x
CB39       SRL C            sz-0-p0x
CB3A       SRL D            sz-0-p0x
CB3B       SRL E            sz-0-p0x
CB3C       SRL H            sz-0-p0x
CB3D       SRL L            sz-0-p0x
CB3E       SRL (HL)         sz-0-p0x
CB3F       SRL A            sz-0-p0x
CB40       BIT 0,B          ?z-1-?0-
CB41       BIT 0,C          ?z-1-?0-
CB42       BIT 0,D          ?z-1-?0-
CB43       BIT 0,E          ?z-1-?0-
CB44       BIT 0,H          ?z-1-?0-
CB45       BIT 0,L          ?z-1-?0-
CB46       BIT 0,(HL)       ?z-1-?0-
CB47       BIT 0,A          ?z-1-?0-
CB48       BIT 1,B          ?z-1-?0-
CB49       BIT 1,C          ?z-1-?0-
CB4A       BIT 1,D          ?z-1-?0-
CB4B       BIT 1,E          ?z-1-?0-
CB4C       BIT 1,H          ?z-1-?0-
CB4D       BIT 1,L          ?z-1-?0-
CB4E       BIT 1,(HL)       ?z-1-?0-
CB4F       BIT 1,A          ?z-1-?0-
CB50       BIT 2,B          ?z-1-?0-
CB51       BIT 2,C          ?z-1-?0-
CB52       BIT 2,D          ?z-1-?0-
CB53       BIT 2,E          ?z-1-?0-
CB54       BIT 2,H          ?z-1-?0-
CB55       BIT 2,L          ?z-1-?0-
CB56       BIT 2,(HL)       ?z-1-?0-
CB57       BIT 2,A          ?z-1-?0-
CB58       BIT 3,B          ?z-1-?0-
CB59       BIT 3,C          ?z-1-?0-
CB5A       BIT 3,D          ?z-1-?0-
CB5B       BIT 3,E          ?z-1-?0-
CB5C       BIT 3,H          ?z-1-?0-
CB5D       BIT 3,L          ?z-1-?0-
CB5E       BIT 3,(HL)       ?z-1-?0-
CB5F       BIT 3,A          ?z-1-?0-
CB60       BIT 4,B          ?z-1-?0-
CB61       BIT 4,C          ?z-1-?0-
CB62       BIT 4,D          ?z-1-?0-
CB63       BIT 4,E          ?z-1-?0-
CB64       BIT 4,H          ?z-1-?0-
CB65       BIT 4,L          ?z-1-?0-
CB66       BIT 4,(HL)       ?z-1-?0-
CB67       BIT 4,A          ?z-1-?0-
CB68       BIT 5,B          ?z-1-?0-
CB69       BIT 5,C          ?z-1-?0-
CB6A       BIT 5,D          ?z-1-?0-
CB6B       BIT 5,E          ?z-1-?0-
CB6C       BIT 5,H          ?z-1-?0-
CB6D       BIT 5,L          ?z-1-?0-
CB6E       BIT 5,(HL)       ?z-1-?0-
CB6F       BIT 5,A          ?z-1-?0-
CB70       BIT 6,B          ?z-1-?0-
CB71       BIT 6,C          ?z-1-?0-
CB72       BIT 6,D          ?z-1-?0-
CB73       BIT 6,E          ?z-1-?0-
CB74       BIT 6,H          ?z-1-?0-
CB75       BIT 6,L          ?z-1-?0-
CB76       BIT 6,(HL)       ?z-1-?0-
CB77       BIT 6,A          ?z-1-?0-
CB78       BIT 7,B          ?z-1-?0-
CB79       BIT 7,C          ?z-1-?0-
CB7A       BIT 7,D          ?z-1-?0-
CB7B       BIT 7,E          ?z-1-?0-
CB7C       BIT 7,H          ?z-1-?0-
CB7D       BIT 7,L          ?z-1-?0-
CB7E       BIT 7,(HL)       ?z-1-?0-
CB7F       BIT 7,A          ?z-1-?0-
CB80       RES 0,B          --------
CB81       RES 0,C          --------
CB82       RES 0,D          --------
CB83       RES 0,E          --------
CB84       RES 0,H          --------
CB85       RES 0,L          --------
CB86       RES 0,(HL)       --------
CB87       RES 0,A          --------
CB88       RES 1,B          --------
CB89       RES 1,C          --------
CB8A       RES 1,D          --------
CB8B       RES 1,E          --------
CB8C       RES 1,H          --------
CB8D       RES 1,L          --------
CB8E       RES 1,(HL)       --------
CB8F       RES 1,A          --------
CB90       RES 2,B          --------
CB91       RES 2,C          --------
CB92       RES 2,D          --------
CB93       RES 2,E          --------
CB94       RES 2,H          --------
CB95       RES 2,L          --------
CB96       RES 2,(HL)       --------
CB97       RES 2,A          --------
CB98       RES 3,B          --------
CB99       RES 3,C          --------
CB9A       RES 3,D          --------
CB9B       RES 3,E          --------
CB9C       RES 3,H          --------
CB9D       RES 3,L          --------
CB9E       RES 3,(HL)       --------
CB9F       RES 3,A          --------
CBA0       RES 4,B          --------
CBA1       RES 4,C          --------
CBA2       RES 4,D          --------
CBA3       RES 4,E          --------
CBA4       RES 4,H          --------
CBA5       RES 4,L          --------
CBA6       RES 4,(HL)       --------
CBA7       RES 4,A          --------
CBA8       RES 5,B          --------
CBA9       RES 5,C          --------
CBAA       RES 5,D          --------
CBAB       RES 5,E          --------
CBAC       RES 5,H          --------
CBAD       RES 5,L          --------
CBAE       RES 5,(HL)       --------
CBAF       RES 5,A          --------
CBB0       RES 6,B          --------
CBB1       RES 6,C          --------
CBB2       RES 6,D          --------
CBB3       RES 6,E          --------
CBB4       RES 6,H          --------
CBB5       RES 6,L          --------
CBB6       RES 6,(HL)       --------
CBB7       RES 6,A          --------
CBB8       RES 7,B          --------
CBB9       RES 7,C          --------
CBBA       RES 7,D          --------
CBBB       RES 7,E          --------
CBBC       RES 7,H          --------
CBBD       RES 7,L          --------
CBBE       RES 7,(HL)       --------
CBBF       RES 7,A          --------
CBC0       SET 0,B          --------
CBC1       SET 0,C          --------
CBC2       SET 0,D          --------
CBC3       SET 0,E          --------
CBC4       SET 0,H          --------
CBC5       SET 0,L          --------
CBC6       SET 0,(HL)       --------
CBC7       SET 0,A          --------
CBC8       SET 1,B          --------
CBC9       SET 1,C          --------
CBCA       SET 1,D          --------
CBCB       SET 1,E          --------
CBCC       SET 1,H          --------
CBCD       SET 1,L          --------
CBCE       SET 1,(HL)       --------
CBCF       SET 1,A          --------
CBD0       SET 2,B          --------
CBD1       SET 2,C          --------
CBD2       SET 2,D          --------
CBD3       SET 2,E          --------
CBD4       SET 2,H          --------
CBD5       SET 2,L          --------
CBD6       SET 2,(HL)       --------
CBD7       SET 2,A          --------
CBD8       SET 3,B          --------
CBD9       SET 3,C          --------
CBDA       SET 3,D          --------
CBDB       SET 3,E          --------
CBDC       SET 3,H          --------
CBDD       SET 3,L          --------
CBDE       SET 3,(HL)       --------
CBDF       SET 3,A          --------
CBE0       SET 4,B          --------
CBE1       SET 4,C          --------
CBE2       SET 4,D          --------
CBE3       SET 4,E          --------
CBE4       SET 4,H          --------
CBE5       SET 4,L          --------
CBE6       SET 4,(HL)       --------
CBE7       SET 4,A          --------
CBE8       SET 5,B          --------
CBE9       SET 5,C          --------
CBEA       SET 5,D          --------
CBEB       SET 5,E          --------
CBEC       SET 5,H          --------
CBED       SET 5,L          --------
CBEE       SET 5,(HL)       --------
CBEF       SET 5,A          --------
CBF0       SET 6,B          --------
CBF1       SET 6,C          --------
CBF2       SET 6,D          --------
CBF3       SET 6,E          --------
CBF4       SET 6,H          --------
CBF5       SET 6,L          --------
CBF6       SET 6,(HL)       --------
CBF7       SET 6,A          --------
CBF8       SET 7,B          --------
CBF9       SET 7,C          --------
CBFA       SET 7,D          --------
CBFB       SET 7,E          --------
CBFC       SET 7,H          --------
CBFD       SET 7,L          --------
CBFE       SET 7,(HL)       --------
CBFF       SET 7,A          --------

DD09       ADD IX,BC        ---H--0C
DD0A       LD A,(BC)        null
DD19       ADD IX,DE        ---H--0C
DD1B       DEC DE           null
DD21wlwm   LD IX,w          --------
DD22tltm   LD (t),IX        --------
DD23       INC IX           --------
DD26bb     LD IXH,b         null
DD29       ADD IX,IX        ---H--0C
DD2Atltm   LD IX,(t)        --------
DD2B       DEC IX           --------
DD2C       INC IXL          null
DD2D       DEC IXL          null
DD2Ebb     LD IXL,b         null
DD34ii     INC (IX+i)       sz-h-v0-
DD35ii     DEC (IX+i)       sz-u-v1-
DD36iibb   LD (IX+i),b      --------
DD39       ADD IX,SP        ---H--0C
DD46ii     LD B,(IX+i)      --------
DD4C       LD C,IXH         null
DD4Eii     LD C,(IX+i)      --------
DD54       LD D,IXH         null
DD56ii     LD D,(IX+i)      --------
DD5D       LD E,IXL         null
DD5Eii     LD E,(IX+i)      --------
DD60       LD IXH,B         null
DD61       LD IXH,C         null
DD62       LD IXH,D         null
DD63       LD IXH,E         null
DD66ii     LD H,(IX+i)      --------
DD67       LD IXH,A         null
DD6Eii     LD L,(IX+i)      --------
DD6F       LD IXL,A         --------
DD70ii     LD (IX+i),B      --------
DD71ii     LD (IX+i),C      --------
DD72ii     LD (IX+i),D      --------
DD73ii     LD (IX+i),E      --------
DD74ii     LD (IX+i),H      --------
DD75ii     LD (IX+i),L      --------
DD77ii     LD (IX+i),A      --------
DD7C       LD A,IXH         null
DD7D       LD A,IXL         --------
DD7D       LD A,IXL         null
DD7Eii     LD A,(IX+i)      --------
DD84       ADD A,IXH        null
DD85       ADD A,IXL        sz-h-v0c
DD85       ADD A,IXL        null
DD86ii     ADD A,(IX+i)     sz-h-v0c
DD8Eii     ADC A,(IX+i)     sz-h-v0c
DD94       SUB IXH          null
DD95       SUB IXL          null
DD96ii     SUB (IX+i)       sz-u-v1b
DD9Eii     SBC A,(IX+i)     sz-u-v1b*
DDA6ii     AND (IX+i)       sz-1-p00
DDAC       XOR IXH          null
DDAEii     XOR (IX+i)       sz-0-p00
DDB6ii     OR (IX+i)        sz-0-p00
DDBEii     CP (IX+i)        sz-u-v1b
DDCBii06   RLC (IX+i)       sz-0-p0x
DDCBii0E   RRC (IX+i)       sz-0-p0x
DDCBii16   RL (IX+i)        sz-0-p0x
DDCBii1E   RR (IX+i)        sz-0-p0x
DDCBii26   SLA (IX+i)       sz-0-p0x
DDCBii2E   SRA (IX+i)       sz-0-p0x
DDCBii3E   SRL (IX+i)       sz-0-p0x
DDCBii46   BIT 0,(IX+i)     ?z-1-?0-
DDCBii4E   BIT 1,(IX+i)     ?z-1-?0-
DDCBii56   BIT 2,(IX+i)     ?z-1-?0-
DDCBii5E   BIT 3,(IX+i)     ?z-1-?0-
DDCBii66   BIT 4,(IX+i)     ?z-1-?0-
DDCBii6E   BIT 5,(IX+i)     ?z-1-?0-
DDCBii76   BIT 6,(IX+i)     ?z-1-?0-
DDCBii7E   BIT 7,(IX+i)     ?z-1-?0-
DDCBii86   RES 0,(IX+i)     --------
DDCBii8E   RES 1,(IX+i)     --------
DDCBii96   RES 2,(IX+i)     --------
DDCBii9E   RES 3,(IX+i)     --------
DDCBiiA6   RES 4,(IX+i)     --------
DDCBiiAE   RES 5,(IX+i)     --------
DDCBiiB6   RES 6,(IX+i)     --------
DDCBiiBE   RES 7,(IX+i)     --------
DDCBiiC6   SET 0,(IX+i)     --------
DDCBiiCE   SET 1,(IX+i)     --------
DDCBiiD6   SET 2,(IX+i)     --------
DDCBiiDE   SET 3,(IX+i)     --------
DDCBiiE6   SET 4,(IX+i)     --------
DDCBiiEE   SET 5,(IX+i)     --------
DDCBiiF6   SET 6,(IX+i)     --------
DDCBiiFE   SET 7,(IX+i)     --------
DDE1       POP IX           --------
DDE3       EX (SP),IX       --------
DDE5       PUSH IX          --------
DDE9       JP (IX)          --------
DDF9       LD SP,IX         --------


ED40       IN B,(C)         sz-0-p0-
ED41       OUT (C),B        --------
ED42       SBC HL,BC        sz-U-v1b
ED43tltm   LD (t),BC        --------
ED44       NEG              sz-u-v1c
ED45       RETN             xxxxxxxx
ED46       IM 0             xxxxxxxx
ED47       LD I,A           --------
ED48       IN C,(C)         sz-0-p0-
ED49       OUT (C),C        --------
ED4A       ADC HL,BC        sz-h-v0c
ED4Btltm   LD BC,(t)        --------
ED4D       RETI             xxxxxxxx
ED4F       LD R,A           --------
ED50       IN D,(C)         sz-0-p0-
ED51       OUT (C),D        --------
ED52       SBC HL,DE        sz-U-v1b
ED53tltm   LD (t),DE        --------
ED56       IM 1             xxxxxxxx
ED57       LD A,I           sz-0-i0-
ED58       IN E,(C)         sz-0-p0-
ED59       OUT (C),E        --------
ED5A       ADC HL,DE        sz-h-v0c
ED5Btltm   LD DE,(t)        --------
ED5E       IM 2             xxxxxxxx
ED5F       LD A,R           sz-0-i0-
ED60       IN H,(C)         sz-0-p0-
ED61       OUT (C),H        --------
ED62       SBC HL,HL        sz-U-v1b
ED67       RRD              xxxxxxxx
ED68       IN L,(C)         sz-0-p0-
ED69       OUT (C),L        --------
ED6A       ADC HL,HL        sz-h-v0c
ED6Btltm   LD HL,(t)        --------
ED6F       RLD              xxxxxxxx
ED72       SBC HL,SP        sz-U-v1b
ED73tltm   LD (t),SP        --------
ED78       IN A,(C)         sz-0-p0-
ED79       OUT (C),A        --------
ED7A       ADC HL,SP        sz-h-v0c
ED7Btltm   LD SP,(t)        --------
EDA0       LDI              ---0-y0-
EDA1       CPI              sz-u-y1-
EDA2       INI              xxxxxxxx
EDA3       OUTI             xxxxxxxx
EDA8       LDD              ---0-y0-
EDA9       CPD              sz-u-y1-
EDAA       IND              xxxxxxxx
EDAB       OUTD             xxxxxxxx
EDB0       LDIR             xxxxxxxx
EDB1       CPIR             xxxxxxxx
EDB2       INIR             xxxxxxxx
EDB3       OTIR             xxxxxxxx
EDB8       LDDR             xxxxxxxx
EDB9       CPDR             xxxxxxxx
EDBA       INDR             xxxxxxxx
EDBB       OTDR             xxxxxxxx


FD09       ADD IY,BC        ---H--0C
FD0B       DEC BC           null
FD19       ADD IY,DE        ---H--0C
FD1B       DEC DE           null
FD20rr     JR NZ,r          null
FD21wlwm   LD IY,w          --------
FD22tltm   LD (t),IY        --------
FD23       INC IY           --------
FD25       DEC IYH          null
FD29       ADD IY,IY        ---H--0C
FD2Atltm   LD IY,(t)        --------
FD2B       DEC IY           --------
FD34ii     INC (IY+i)       sz-h-v0-
FD35ii     DEC (IY+i)       sz-u-v1-
FD36iibb   LD (IY+i),b      --------
FD39       ADD IY,SP        ---H--0C
FD46ii     LD B,(IY+i)      --------
FD48       LD C,B           null
FD4Eii     LD C,(IY+i)      --------
FD56ii     LD D,(IY+i)      --------
FD5Eii     LD E,(IY+i)      --------
FD62       LD IYH,D         --------
FD63       LD IYH,E         null
FD66ii     LD H,(IY+i)      --------
FD6B       LD IYL,E         null
FD6Eii     LD L,(IY+i)      --------
FD6F       LD IXH,A         --------
FD70ii     LD (IY+i),B      --------
FD71ii     LD (IY+i),C      --------
FD72ii     LD (IY+i),D      --------
FD73ii     LD (IY+i),E      --------
FD74ii     LD (IY+i),H      --------
FD75ii     LD (IY+i),L      --------
FD77ii     LD (IY+i),A      --------
FD7C       LD A,IYH         null
FD7D       LD A,IYL         null
FD7Eii     LD A,(IY+i)      --------
FD86ii     ADD A,(IY+i)     sz-h-v0c
FD8Eii     ADC A,(IY+i)     sz-h-v0c
FD96ii     SUB (IY+i)       sz-u-v1b
FD9Eii     SBC A,(IY+i)     sz-u-v1b
FDA6ii     AND (IY+i)       sz-1-p00
FDAC       XOR IYH          null
FDAEii     XOR (IY+i)       sz-0-p00
FDB6ii     OR (IY+i)        sz-0-p00
FDBEii     CP (IY+i)        sz-u-v1b
FDCBii06   RLC (IY+i)       sz-0-p0x
FDCBii0E   RRC (IY+i)       sz-0-p0x
FDCBii16   RL (IY+i)        sz-0-p0x
FDCBii1E   RR (IY+i)        sz-0-p0x
FDCBii26   SLA (IY+i)       sz-0-p0x
FDCBii2E   SRA (IY+i)       sz-0-p0x
FDCBii3E   SRL (IY+i)       sz-0-p0x
FDCBii46   BIT 0,(IY+i)     ?z-1-?0-
FDCBii4E   BIT 1,(IY+i)     ?z-1-?0-
FDCBii56   BIT 2,(IY+i)     ?z-1-?0-
FDCBii5E   BIT 3,(IY+i)     ?z-1-?0-
FDCBii66   BIT 4,(IY+i)     ?z-1-?0-
FDCBii6E   BIT 5,(IY+i)     ?z-1-?0-
FDCBii76   BIT 6,(IY+i)     ?z-1-?0-
FDCBii7E   BIT 7,(IY+i)     ?z-1-?0-
FDCBii86   RES 0,(IY+i)     --------
FDCBii8E   RES 1,(IY+i)     --------
FDCBii96   RES 2,(IY+i)     --------
FDCBii9E   RES 3,(IY+i)     --------
FDCBiiA6   RES 4,(IY+i)     --------
FDCBiiAE   RES 5,(IY+i)     --------
FDCBiiB6   RES 6,(IY+i)     --------
FDCBiiBE   RES 7,(IY+i)     --------
FDCBiiC6   SET 0,(IY+i)     --------
FDCBiiCE   SET 1,(IY+i)     --------
FDCBiiD6   SET 2,(IY+i)     --------
FDCBiiDE   SET 3,(IY+i)     --------
FDCBiiE6   SET 4,(IY+i)     --------
FDCBiiEE   SET 5,(IY+i)     --------
FDCBiiF6   SET 6,(IY+i)     --------
FDCBiiFE   SET 7,(IY+i)     --------
FDCCmlmm   CALL Z,m         null
FDD8       RET C            null
FDE1       POP IY           --------
FDE3       EX (SP),IY       --------
FDE5       PUSH IY          --------
FDE9       JP (IY)          --------
FDF9       LD SP,IY         --------
FDFB       EI               null
}