# Address Line A12

There is nothing particularly exciting about address line A12. Big brothers do the heavy decoding. A15 right down the middle
RAM/ROM. Upper or lower depends on the processor -- continue 6502 in this chapter, so ROM in upper.

To further divide, we bring in brother A14. Maybe split the ROM area into two blocks -- ROM and IO. Or maybe the three top
brothers A15, A14, A13 with a 74138 to get 8 blocks of 8K. Lots of RAMs, ROMs, and devices.

But A12? He's a hopeful middle child stuck down at the 4K divider -- good for dividing an 8K block into two. 
Oh, he's plenty useful in indexing. Got an 8K ROM or RAM? You'll need A12 along with the
other brothers as address indexes within the block -- but no glamourous decoding. Just indexing. Devices that have
less than 8K of addresses don't even need A12. That's usually just RAM and ROM -- no exciting I/O devices.

![](decode.jpg)

Notice A12 is only used in the boring memory blocks -- doesn't get to participate in the exciting I/O. A0, on the
other hand, is used by everybody.

6507 ... limited pins

A12 ... low for things inside the console and high for things inside the cartridge.

Atari2600 memory map -- just two chips plus the external rom.

RIOT chip is used in a lot of things. We used it in the last chapter. TIA ... a little discussion
on that magic in the next chapter.

Need RAM to be lower 00 and lower 100. Show the stack ghosting.

# Make a cartridge

Hacking a 4K cartridge. Show 2K Combat was missing a trace.

[] cartridges after disassembly

Need changes for A12 inverted.

[] schematic for changes
[] modified cartridge with EPROM

Blinking a light through the joystick port (headless).

[] modified cables

# Bank switching

Breadboard breakout. 13-input AND

# RAM

The m-systems game BurgerTime