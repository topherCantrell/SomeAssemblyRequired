# Riding the Address/Data Bus

## Decimal Bus

![](decimalBus.jpg)

The address bus is 4 decimal digits. The data bus is 2 decimal digits.

The screen is 10x5 cells. Write ASCII to 99. 

The three switches are three cells. A 1 means the switch is closed. A 0 means the switch is open.

Memory Map:
  - 0000 - 0049 Screen. Ghosts every 50.
  - 0050 - 0052 Switches. Ghosts every 10.
  - Ghosts at 1000, 2000, 3000, 4000
  - 5000 - 5999 RAM.
  - No RAM/ROM ghosts
  - 9000 - 9999 ROM. (fill with program later chapter)
  
Let the user read/write the bus. See the ghosts. See how simple the CPU's view of the system really is.
Show decoding logic.

  - Screen: Digit 3 is 0, Digit 1 is 0. Use lower two digits as address.
  - Switches: Digit 3 is 0, Digit 1 is 1. Use lower digit as address.
  - RAM: Digit 3 is 5. Use lower 3 digits as address.
  - ROM: Digit 3 is 9. Use lower 3 digits as address.
  
## View From the CPU

![](TRONTROFF.png)

In the movie "TRON" comes from "elecTRONic".

http://en.wikipedia.org/wiki/Tron

In 1982 a nasty computer virus called the Master Control Program (MCP) was on the verge of taking over the entire planet. The documentary, TRON, explains how two programmers and a couple of renegade programs (con-scripts) took down the MCP and saved the world.

The details are complicated. But in the end Kevin Flynn distracted the MCP while the security program, TRON,

They exploited a design flaw in the MCP. Despite is size and power it connected to the rest of the system through one tiny interface -- its achiles heel. The MCP was a giant cylinder spinning like a top on its sharp cone interface. The MCP funneled all its power and control through this one tiny tip. A plastic frisbie thrown into this fragile interface was enough to separate the MCP from the computer. Game over.

## Atari2600 Memory Map

![](Hardware.jpg)

