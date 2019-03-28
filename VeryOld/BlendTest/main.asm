. CPU = Z80

0000:  

   SP = 0x2000         ; Initialize the stack to the end of RAM 



   H=1

   if(A==4) {
     H=2
   } else if(A==5) {
     H=3
   } else if(A==6) {
     H=4
   } else {
     H=5
   } 

   H=6

   HALT

