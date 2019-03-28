This assembler was written to bootstrap a z80 system with cpm/80.It is not designed to be an every day assembler. It will not assembler most cpm source without minor modifications to the source.

Included is a disassembler which produces  source code which the assembler can assemble. 

Included is a program which can convert a binary or a dump listing into commands which can be used to Set memory with DDT or the SD systems firmware monitor.

Included is a program which can be used to create a raw disk image suitable for use with dd (linux-not included)or rawwrite(linux tool for windows- not included)

None of these programs are guaranteed to work in every situation in which one may wish to use them. They may contain bugs which produce erroneous binary code. The programs may contain bugs which cause them to abend. Once you have a workable cpm system, use the commercial development programs to produce a final system.


----
--Assembler
----


---Numeric values

Numeric values can be numbers in hex dec oct or binary or single quoted chars

123 5d6h 377o 101010b &h8d &o377

'a'  '6'  '='  '"'  '''

*note - due to a poorly writen parser, single quoted characters of 
	the following are listed as their numeric equivalent
	(these are the operators and separators)

';'  '+'  '-'  '*'  '/'  '|'  '%'  ' '(space)  ','  '@'  '^'  ':'  '!'

---Symbolic values

Symbols are case sensitive

Xyz is a different symbol than xyz or XYZ or xYz

Any symbol which starts with two periods is a redefinable backward reference

symbolic values may be preceded by # to logically NOT the symbol's value
	(NUMERIC values can not be NOTted by a #)

	mvi	a,#xyz|1010b

Symbols can NOT be constructed which contain a separator (space, comma, semicolon, colon, tab, lf, cr)
Symbols can be defined which contain operators, but can NOT be referenced.
Symbols can be defined which appear to be numeric values, but can NOT be referenced.

---Expressions

Expressions can be two values seperated by an operator or one value preceded by a minus sign 

3+8   xyz|101001b   vers/10    #test+#com   -45   -'y'  -#xyz


---Operators

+ addition
- subtraction
* Multiplication
/ integer division
% modulo
| logical OR
@ logical AND
^ logical exclusive OR

---Directives

org
equ
ds
db	- single quoted chars allowed but no strings
dw	- single quoted chars allowed but no strings
text,dt	- one multicharacter string allowed
	 (fisrt char of operand is the quote mark char)

	text	'He said, "string"'		; ' is the quote mark
	dt	"string's"			; " is the quote mark
	text	qHe asked, "What's he doing?"q	; q is the quote mark

textz	- string terminated with null(0)
texts	- string terminated with last byte's sign bit set

z80	- no warning on z80 use - warns on 64180 use
z180	- no warning on z80 or 64180 use
i8080	- default - warns on z80 and 64180 use

end	- specifies starting address for Srecs and HEX files(default =0)

page	- does nothing
title	- does nothing

if ift ifnz ifne -assembles if operand expression is not 0 (true=not 0)
iff ifz	ifeq	 -assembles if operand expression is zero (false = 0)

ifgt		 -assembles if operand expression is greater than 0
ifge		 -assembles if operand expression is greater than or equal 0
iflt		 -assembles if operand expression is less than 0
ifle		 -assembles if operand expression is less than or equal 0

else		
endif

---Labels


Any label which starts with two periods is a redefinable backward reference

..loop	mvi 	m,6
	dcx	hl
	jnz	..loop	; jumps to ..loop at MVI instruction
..loop	dcr 	b
	jz	..loop	; jumps to ..loop at DCR instruction 

A label can be terminated with a :(colon)

label: jmp	label

Labels may start in a column other than column one if and only if the label is terminated by ':'

The bang '!' is a logical line separator

----
--Disassembler
---

The disassembler can accept either a raw binary file or a dump listing.

If input is a binary file you must specify the Origin. Default is 0100h.

If input is a dump listing, the addresses must be contiguous and all lines must contain 16 bytes of data. If not, the program may crash. Prior to using a dump listing you must edit it to ensure that there are 16 bytes per line and that the addresses are contiguous. Ascii listings at the end of each line are allowed and are ignored.

You may save a listing(simular to an assembler listing),or a source file which can be edited and assembled by the included assembler, or a dump listing, or a binary file.

If you have a dump listing and you want to create a binary file, after dissassembling, use the view binary and save. A binary file will be created. 

If you have a binary file and you want to create a dump listing, after dissassembling, use the view hex and save. A dump listing file will be created. 

-----
--Build image
-----

Build image allows you to create a raw disk image. When you create a disk image, it will be made only large enough to hold all the binaries which you include. You must specify the starting sector for each binary file as 128 byte units. 

You can add files to an image, but you can NOT remove them.You can overwrite files in an image. To remove a file, you will have to make a new image and then only put the binaries you want. The "add" and "remove" command button only add or remove files from the list, not the actual image. The "insert into image" will cause all the files in the list to be placed in the image, overwritting whatever is in the image and expanding the image, if neccessary.

As a convience you may fill an image with a value(default e5h). Note- if you fill an empty image with a value, it will still be empty!

Existing binary images can be updated. Only the areas to be occupied by the new binary files will be modified. The disk image may expand, but will NOT contract.

Typically you would create only the system tracks.  Caution, if you want to keep the existing data files intact, before you write to your disk, make sure that the image is not larger than the system tracks. Rawwrite will write however many sector are in the image. If the image is larger than the data tracks, it wont stop at the data tracks. Use of dd(linux) allows you to specify exactly how many blocks(linux blocks) get writen.

If you want to create blank disks for cpm, make sure you put "e5h"s in the area reserved for the directory. Remember that on a blank disk, the directory area must contain E5h in the first byte of each available directory entry, or cpm believes that it is an unavailable directory entry.

----
-- BinToSde
---

BinToSde is a kludge. It can convert a binary file to either DDT set memory format or SDsystems firmware monitor Examine memory format or a dump listing. The resulting data can either be pasted to the host or saved and sent latter as a text file to the host. If DDT or equivalent is running, data from the original binary will be loaded into memory. Afterward you may use the save command to write it to disk.

If a binary file is to large to fit into available memory, BinToSde can be used to break the large file into 16k or smaller blocks. Each chunck can be tranfered to cpm and then concatenated with PIP (use binary/object option - o)to create the original file. To accomplish, check "direct" and "split" and "binary". The original binary will be split into smaller files named "out0.bin" though "outX.bin"

To create a dump listing of a binary file, check "dump" then save as text. If you select "direct" an output file named out0.dmp is created with out having to "save". If you dont check "direct" then you may save with any name you chose. "Binary", also, only, creates a file directly.

(The BinToSDE program was writen and modified as needed, it is a kludge, it does not attempt to prevent you from making errors. All controls remain enabled whether they are valid for the choosen function or not. When "direct" is chosen, this program writes to only a fixed set of filenames. If they already exist, they will be deleted first!)
