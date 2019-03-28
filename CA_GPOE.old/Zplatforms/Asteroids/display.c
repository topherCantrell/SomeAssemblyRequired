/*
 * display.c: Atari DVG and AVG simulators
 *
 * Copyright 1991, 1992, 1996, 2003 Eric Smith
 *
 *    This program is free software; you can redistribute it and/or modify
 *    it under the terms of the GNU General Public License as published by
 *    the Free Software Foundation; either version 2 of the License, or
 *    (at your option) any later version.
 *
 *    This program is distributed in the hope that it will be useful,
 *    but WITHOUT ANY WARRANTY; without even the implied warranty of
 *    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *    GNU General Public License for more details.
 *
 *    You should have received a copy of the GNU General Public License
 *    along with this program; if not, write to the Free Software
 *    Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
 *
 * $Id$
 */

#include <stdio.h>
#include <stdlib.h>

#include "memory.h"
#include "display.h"

int dvg = 0;
int portrait = 0;

#ifdef VG_DEBUG
int trace_vgo = 0;
int vg_step = 0; /* single step the vector generator */
int vg_print = 0;
unsigned long last_vgo_cyc=0;
unsgined long vgo_count=0;
#endif /* VG_DEBUG */

int vg_busy = 0;
unsigned long vg_done_cyc; /* cycle after which VG will be done */
unsigned vector_mem_offset;


#define MAXSTACK 4

#define VCTR 0
#define HALT 1
#define SVEC 2
#define STAT 3
#define CNTR 4
#define JSRL 5
#define RTSL 6
#define JMPL 7
#define SCAL 8

#define DVCTR 0x01
#define DLABS 0x0a
#define DHALT 0x0b
#define DJSRL 0x0c
#define DRTSL 0x0d
#define DJMPL 0x0e
#define DSVEC 0x0f

#define twos_comp_val(num,bits) ((num&(1<<(bits-1)))?(num|~((1<<bits)-1)):(num&((1<<bits)-1)))

char *avg_mnem[] = { "vctr", "halt", "svec", "stat", "cntr", "jsrl", "rtsl",
		 "jmpl", "scal" };

char *dvg_mnem[] = { "????", "vct1", "vct2", "vct3",
		     "vct4", "vct5", "vct6", "vct7",
		     "vct8", "vct9", "labs", "halt",
		     "jsrl", "rtsl", "jmpl", "svec" };

#define map_addr(n) (((n)<<1)+vector_mem_offset)

#define max(x,y) (((x)>(y))?(x):(y))

static void vector_timer (long deltax, long deltay)
{
  deltax = labs (deltax);
  deltay = labs (deltay);
  vg_done_cyc += max (deltax, deltay) >> 17;
}


static void dvg_vector_timer (int scale)
{
  vg_done_cyc += 4 << scale;
}


static void dvg_draw_vector_list (void)
{
  static int pc;
  static int sp;
  static int stack [MAXSTACK];

  static long scale;
  static int statz;

  static long currentx;
  static long currenty;

  int done = 0;

  int firstwd, secondwd;
  int opcode;

  long x, y;
  int z, temp;
  int a;

  long oldx, oldy;
  long deltax, deltay;

#if 0
  if (!cont)
#endif
    {
      pc = 0;
      sp = 0;
      scale = 0;
      statz = 0;
      if (portrait)
	{
	  currentx = 1023 * 8192;
	  currenty = 512 * 8192;
	}
      else
	{
	  currentx = 512 * 8192;
	  currenty = 1023 * 8192;
	}
    }

#ifdef VG_DEBUG
  open_page (vg_step);
#else
  open_page (0);
#endif

  while (!done)
    {
      vg_done_cyc += 8;
#ifdef VG_DEBUG
      if (vg_step)
	{
	  printf ("Current beam position: (%d, %d)\n",
		  currentx, currenty);
	  getchar();
	}
#endif
      firstwd = memrdwd (map_addr (pc), 0, 0);
      opcode = firstwd >> 12;
#ifdef VG_DEBUG
      if (vg_print)
	printf ("%4x: %4x ", map_addr (pc), firstwd);
#endif
      pc++;
      if ((opcode >= 0 /* DVCTR */) && (opcode <= DLABS))
	{
	  secondwd = memrdwd (map_addr (pc), 0, 0);
	  pc++;
#ifdef VG_DEBUG
	  if (vg_print)
	    printf ("%4x  ", secondwd);
#endif
	}
#ifdef VG_DEBUG
      else
	if (vg_print)
	  printf ("      ");
#endif

#ifdef VG_DEBUG
      if (vg_print)
	printf ("%s ", dvg_mnem [opcode]);
#endif

      switch (opcode)
	{
	case 0:
#ifdef DVG_OP_0_ERR
	  printf ("Error: DVG opcode 0!  Addr %4x Instr %4x %4x\n", map_addr (pc-2), firstwd, secondwd);
	  done = 1;
	  break;
#endif
	case 1:
	case 2:
	case 3:
	case 4:
	case 5:
	case 6:
	case 7:
	case 8:
	case 9:
	  y = firstwd & 0x03ff;
	  if (firstwd & 0x0400)
	    y = -y;
	  x = secondwd & 0x03ff;
	  if (secondwd & 0x400)
	    x = -x;
	  z = secondwd >> 12;
#ifdef VG_DEBUG
	  if (vg_print)
	    {
	      printf ("(%d,%d) z: %d scal: %d", x, y, z, opcode);
	    }
#endif
#if 0
	  if (vg_step)
	    {
	      printf ("\nx: %x  x<<21: %x  (x<<21)>>%d: %x\n", x, x<<21, 30-(scale+opcode), (x<<21)>>(30-(scale+opcode)));
	      printf ("y: %x  y<<21: %x  (y<<21)>>%d: %x\n", y, y<<21, 30-(scale+opcode), (y<<21)>>(30-(scale+opcode)));
	    }
#endif
	  oldx = currentx; oldy = currenty;
	  temp = (scale + opcode) & 0x0f;
	  if (temp > 9)
	    temp = -1;
	  deltax = (x << 21) >> (30 - temp);
	  deltay = (y << 21) >> (30 - temp);
#if 0
	  if (vg_step)
	    {
	      printf ("deltax: %x  deltay: %x\n", deltax, deltay);
	    }
#endif
	  currentx += deltax;
	  currenty -= deltay;
	  dvg_vector_timer (temp);
	  draw_line (oldx, oldy, currentx, currenty, 7, z);
	  break;

	case DLABS:
	  x = twos_comp_val (secondwd, 12);
	  y = twos_comp_val (firstwd, 12);
/*
	  x = secondwd & 0x07ff;
	  if (secondwd & 0x0800)
	    x = x - 0x1000;
	  y = firstwd & 0x07ff;
	  if (firstwd & 0x0800)
	    y = y - 0x1000;
*/
	  scale = secondwd >> 12;
	  currentx = x;
	  currenty = (896 - y);
#ifdef VG_DEBUG
	  if (vg_print)
	    {
	      printf ("(%d,%d) scal: %d", x, y, secondwd >> 12);
	    }
#endif
	  break;

	case DHALT:
#ifdef VG_DEBUG
	  if (vg_print)
	    if ((firstwd & 0x0fff) != 0)
	      printf ("(%d?)", firstwd & 0x0fff);
#endif
	  done = 1;
	  break;

	case DJSRL:
	  a = firstwd & 0x0fff;
#ifdef VG_DEBUG
	  if (vg_print)
	    printf ("%4x", map_addr(a));
#endif
	  stack [sp] = pc;
	  if (sp == (MAXSTACK - 1))
	    {
	      printf ("\n*** Vector generator stack overflow! ***\n");
	      done = 1;
	      sp = 0;
	    }
	  else
	    sp++;
	  pc = a;
	  break;
	
	case DRTSL:
#ifdef VG_DEBUG
	  if (vg_print)
	    if ((firstwd & 0x0fff) != 0)
	      printf ("(%d?)", firstwd & 0x0fff);
#endif
	  if (sp == 0)
	    {
	      printf ("\n*** Vector generator stack underflow! ***\n");
	      done = 1;
	      sp = MAXSTACK - 1;
	    }
	  else
	    sp--;
	  pc = stack [sp];
	  break;

	case DJMPL:
	  a = firstwd & 0x0fff;
#ifdef VG_DEBUG
	  if (vg_print)
	    printf ("%4x", map_addr(a));
#endif
	  pc = a;
	  break;
	
	case DSVEC:
	  y = firstwd & 0x0300;
	  if (firstwd & 0x0400)
	    y = -y;
	  x = (firstwd & 0x03) << 8;
	  if (firstwd & 0x04)
	    x = -x;
	  z = (firstwd >> 4) & 0x0f;
	  temp = 2 + ((firstwd >> 2) & 0x02) + ((firstwd >> 11) & 0x01);
#ifdef VG_DEBUG
	  if (vg_print)
	    {
	      printf ("(%d,%d) z: %d scal: %d", x, y, z, temp);
	    }
#endif
#if 0
	  if (vg_step)
	    {
	      printf ("\nx: %x  x<<21: %x  (x<<21)>>%d: %x\n", x, x<<21, 30-(scale+temp), (x<<21)>>(30-(scale+temp)));
	      printf ("y: %x  y<<21: %x  (y<<21)>>%d: %x\n", y, y<<21, 30-(scale+temp), (y<<21)>>(30-(scale+temp)));
	    }
#endif
	  oldx = currentx; oldy = currenty;
	  temp = (scale + temp) & 0x0f;
	  if (temp > 9)
	    temp = -1;
	  deltax = (x << 21) >> (30 - temp);
	  deltay = (y << 21) >> (30 - temp);
#if 0
	  if (vg_step)
	    {
	      printf ("deltax: %x  deltay: %x\n", deltax, deltay);
	    }
#endif
	  currentx += deltax;
	  currenty -= deltay;
	  dvg_vector_timer (temp);
	  draw_line (oldx, oldy, currentx, currenty, 7, z);
	  break;

	default:
	  fprintf (stderr, "internal error\n");
	  done = 1;
	}
#ifdef VG_DEBUG
      if (vg_print)
	printf ("\n");
#endif
    }

  close_page ();
}


static void avg_draw_vector_list (void)
{
  static int pc;
  static int sp;
  static int stack [MAXSTACK];

  static long scale;
  static int statz;
  static int color;

  static long currentx;
  static long currenty;

  int done = 0;

  int firstwd, secondwd;
  int opcode;

  int x, y, z, b, l, d, a;

  long oldx, oldy;
  long deltax, deltay;

#if 0
  if (!cont)
#endif
    {
      pc = 0;
      sp = 0;
      scale = 16384;
      statz = 0;
      color = 0;
      if (portrait)
        {
	  currentx = 384 * 8192;
	  currenty = 512 * 8192;
	}
      else
        {
	  currentx = 512 * 8192;
	  currenty = 384 * 8192;
	}

      firstwd = memrdwd (map_addr (pc), 0, 0);
      secondwd = memrdwd (map_addr (pc+1), 0, 0);
      if ((firstwd == 0) && (secondwd == 0))
	{
	  printf ("VGO with zeroed vector memory\n");
	  return;
	}
    }

#ifdef VG_DEBUG
  open_page (vg_step);
#else
  open_page (0);
#endif

  while (!done)
    {
      vg_done_cyc += 8;
#ifdef VG_DEBUG
      if (vg_step)
	getchar();
#endif
      firstwd = memrdwd (map_addr (pc), 0, 0);
      opcode = firstwd >> 13;
#ifdef VG_DEBUG
      if (vg_print)
	printf ("%4x: %4x ", map_addr (pc), firstwd);
#endif
      pc++;
      if (opcode == VCTR)
	{
	  secondwd = memrdwd (map_addr (pc), 0, 0);
	  pc++;
#ifdef VG_DEBUG
	  if (vg_print)
	    printf ("%4x  ", secondwd);
#endif
	}
#ifdef VG_DEBUG
      else
	if (vg_print)
	  printf ("      ");
#endif

      if ((opcode == STAT) && ((firstwd & 0x1000) != 0))
	opcode = SCAL;

#ifdef VG_DEBUG
      if (vg_print)
	printf ("%s ", avg_mnem [opcode]);
#endif

      switch (opcode)
	{
	case VCTR:
	  x = twos_comp_val (secondwd,13);
	  y = twos_comp_val (firstwd,13);
	  z = 2 * (secondwd >> 13);
#ifdef VG_DEBUG
	  if (vg_print)
	    printf ("%d,%d,", x, y);
#endif
	  if (z == 0)
	    {
#ifdef VG_DEBUG
	      if (vg_print)
		printf ("blank");
#endif
	    }
	  else if (z == 2)
	    {
	      z = statz;
#ifdef VG_DEBUG
	      if (vg_print)
		printf ("stat (%d)", z);
#endif
	    }
#ifdef VG_DEBUG
	  else
	    if (vg_print)
	      printf ("%d", z);
#endif
	  oldx = currentx; oldy = currenty;
	  deltax = x * scale; deltay = y * scale;
	  currentx += deltax;
	  currenty -= deltay;
	  vector_timer (deltax, deltay);
	  draw_line (oldx>>13, oldy>>13, currentx>>13, currenty>>13, color, z);
	  break;
	
	case SVEC:
	  x = twos_comp_val (firstwd, 5) << 1;
	  y = twos_comp_val (firstwd >> 8, 5) << 1;
	  z = 2 * ((firstwd >> 5) & 7);
#ifdef VG_DEBUG
	  if (vg_print)
	    printf ("%d,%d,", x, y);
#endif
	  if (z == 0)
	    {
#ifdef VG_DEBUG
	      if (vg_print)
		printf ("blank");
#endif
	    }
	  else if (z == 2)
	    {
	      z = statz;
#ifdef VG_DEBUG
	      if (vg_print)
		printf ("stat");
#endif
	    }
#ifdef VG_DEBUG
	  else
	    if (vg_print)
	      printf ("%d", z);
#endif
	  oldx = currentx; oldy = currenty;
	  deltax = x * scale; deltay = y * scale;
	  currentx += deltax;
	  currenty -= deltay;
	  vector_timer (labs (deltax), labs (deltay));
	  draw_line (oldx>>13, oldy>>13, currentx>>13, currenty>>13, color, z);
	  break;
	
	case STAT:
	  color = firstwd & 0x0f;
	  statz = (firstwd >> 4) & 0x0f;
#ifdef VG_DEBUG
	  if (vg_print)
	    printf ("z: %d color: %d", statz, color);
#endif
	  /* should do e, h, i flags here! */
	  break;
      
	case SCAL:
	  b = (firstwd >> 8) & 0x07;
	  l = firstwd & 0xff;
	  scale = (16384 - (l << 6)) >> b;
	  /* scale = (1.0-(l/256.0)) * (2.0 / (1 << b)); */
#ifdef VG_DEBUG
	  if (vg_print)
	    {
	      printf ("bin: %d, lin: ", b);
	      if (l > 0x80)
		printf ("(%d?)", l);
	      else
		printf ("%d", l);
	      printf (" scale: %f", (scale/8192.0));
	    }
#endif
	  break;
	
	case CNTR:
	  d = firstwd & 0xff;
#ifdef VG_DEBUG
	  if (vg_print)
	    {
	      if (d != 0x40)
		printf ("%d", d);
	    }
#endif
	  if (portrait)
	    {
	      currentx = 384 * 8192;
	      currenty = 512 * 8192;
	    }
          else
	    {
	      currentx = 512 * 8192;
	      currenty = 384 * 8192;
	    }
	  break;
	
	case RTSL:
#ifdef VG_DEBUG
	  if (vg_print)
	    if ((firstwd & 0x1fff) != 0)
	      printf ("(%d?)", firstwd & 0x1fff);
#endif
	  if (sp == 0)
	    {
	      printf ("\n*** Vector generator stack underflow! ***\n");
	      done = 1;
	      sp = MAXSTACK - 1;
	    }
	  else
	    sp--;
	  pc = stack [sp];
	  break;

	case HALT:
#ifdef VG_DEBUG
	  if (vg_print)
	    if ((firstwd & 0x1fff) != 0)
	      printf ("(%d?)", firstwd & 0x1fff);
#endif
	  done = 1;
	  break;

	case JMPL:
	  a = firstwd & 0x1fff;
#ifdef VG_DEBUG
	  if (vg_print)
	    printf ("%4x", map_addr(a));
#endif
	  pc = a;
	  break;
	
	case JSRL:
	  a = firstwd & 0x1fff;
#ifdef VG_DEBUG
	  if (vg_print)
	    printf ("%4x", map_addr(a));
#endif
	  stack [sp] = pc;
	  if (sp == (MAXSTACK - 1))
	    {
	      printf ("\n*** Vector generator stack overflow! ***\n");
	      done = 1;
	      sp = 0;
	    }
	  else
	    sp++;
	  pc = a;
	  break;
	
	default:
	  fprintf (stderr, "internal error\n");
	}
#ifdef VG_DEBUG
      if (vg_print)
	printf ("\n");
#endif
    }

  close_page ();
}

int vg_done (unsigned long cyc)
{
  if (vg_busy && (cyc > vg_done_cyc))
    vg_busy = 0;

  return (! vg_busy);
}


int drop_frames = 0;
static int df = 1;

void vg_go (unsigned long cyc)
{
  vg_busy = 1;
  vg_done_cyc = cyc + 8;
#ifdef VG_DEBUG
  vgo_count++;
  if (trace_vgo)
    printf("VGO #%d at cycle %d, delta %d\n", vgo_count, cyc, cyc-last_vgo_cyc);
  last_vgo_cyc = cyc;
#endif

  if (--df == 0)
    {
      df = (drop_frames > 0) ? drop_frames : 1;
      if (dvg)
	dvg_draw_vector_list ();
      else
	avg_draw_vector_list ();
    }
}

void vg_reset (unsigned long cyc)
{
  vg_busy = 0;
#ifdef VG_DEBUG
  if (trace_vgo)
    printf ("vector generator reset @%04x\n", PC);
#endif
}

