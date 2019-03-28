/***************************************************************************

    Asteroids Memory Map (preliminary)

    Asteroids settings:

    0 = OFF  1 = ON  X = Don't Care  $ = Atari suggests


    8 SWITCH DIP
    87654321
    --------
    XXXXXX11   English
    XXXXXX10   German
    XXXXXX01   French
    XXXXXX00   Spanish
    XXXXX1XX   4-ship game
    XXXXX0XX   3-ship game
    11XXXXXX   Free Play
    10XXXXXX   1 Coin  for 2 Plays
    01XXXXXX   1 Coin  for 1 Play
    00XXXXXX   2 Coins for 1 Play
	*/

  

/*************************************
 *
 *  Main CPU memory handlers
 *
 *************************************/

static ADDRESS_MAP_START( asteroid_map, ADDRESS_SPACE_PROGRAM, 8 )
	ADDRESS_MAP_FLAGS( AMEF_ABITS(15) )
	AM_RANGE(0x0000, 0x03ff) AM_RAM
	AM_RANGE(0x2000, 0x2007) AM_READ(asteroid_IN0_r) /* IN0 */
	AM_RANGE(0x2400, 0x2407) AM_READ(asteroid_IN1_r) /* IN1 */
	AM_RANGE(0x2800, 0x2803) AM_READ(asteroid_DSW1_r) /* DSW1 */
	AM_RANGE(0x3000, 0x3000) AM_WRITE(avgdvg_go_w)
	AM_RANGE(0x3200, 0x3200) AM_WRITE(asteroid_bank_switch_w)
	AM_RANGE(0x3400, 0x3400) AM_WRITE(watchdog_reset_w)
	AM_RANGE(0x3600, 0x3600) AM_WRITE(asteroid_explode_w)
	AM_RANGE(0x3a00, 0x3a00) AM_WRITE(asteroid_thump_w)
	AM_RANGE(0x3c00, 0x3c05) AM_WRITE(asteroid_sounds_w)
	AM_RANGE(0x3e00, 0x3e00) AM_WRITE(asteroid_noise_reset_w)
	AM_RANGE(0x4000, 0x47ff) AM_RAM AM_BASE(&vectorram) AM_SIZE(&vectorram_size) AM_REGION(REGION_CPU1, 0x4000)
	AM_RANGE(0x5000, 0x57ff) AM_ROM				/* vector rom */
	AM_RANGE(0x6800, 0x7fff) AM_ROM
ADDRESS_MAP_END

/*************************************
 *
 *  Port definitions
 *
 *************************************/

INPUT_PORTS_START( asteroid )
	PORT_START_TAG("IN0")
	PORT_BIT( 0x01, IP_ACTIVE_HIGH, IPT_UNKNOWN )
	/* Bit 2 and 3 are handled in the machine dependent part. */
	/* Bit 2 is the 3 KHz source and Bit 3 the VG_HALT bit    */
	PORT_BIT( 0x02, IP_ACTIVE_HIGH, IPT_UNKNOWN )
	PORT_BIT( 0x04, IP_ACTIVE_HIGH, IPT_UNKNOWN )
	PORT_BIT( 0x08, IP_ACTIVE_HIGH, IPT_BUTTON3 )
	PORT_BIT( 0x10, IP_ACTIVE_HIGH, IPT_BUTTON1 )
	PORT_BIT(0x20, IP_ACTIVE_HIGH, IPT_SERVICE ) PORT_NAME("Diagnostic Step") PORT_CODE(KEYCODE_F1)
	PORT_BIT( 0x40, IP_ACTIVE_HIGH, IPT_TILT )
	PORT_SERVICE( 0x80, IP_ACTIVE_HIGH )

	PORT_START_TAG("IN1")
	PORT_BIT( 0x01, IP_ACTIVE_HIGH, IPT_COIN1 )
	PORT_BIT( 0x02, IP_ACTIVE_HIGH, IPT_COIN2 )
	PORT_BIT( 0x04, IP_ACTIVE_HIGH, IPT_COIN3 )
	PORT_BIT( 0x08, IP_ACTIVE_HIGH, IPT_START1 )
	PORT_BIT( 0x10, IP_ACTIVE_HIGH, IPT_START2 )
	PORT_BIT( 0x20, IP_ACTIVE_HIGH, IPT_BUTTON2 )
	PORT_BIT( 0x40, IP_ACTIVE_HIGH, IPT_JOYSTICK_RIGHT ) PORT_2WAY
	PORT_BIT( 0x80, IP_ACTIVE_HIGH, IPT_JOYSTICK_LEFT ) PORT_2WAY

	PORT_START_TAG("DSW")
	PORT_DIPNAME( 0x03, 0x00, DEF_STR( Language ) )
	PORT_DIPSETTING (	0x00, DEF_STR( English ) )
	PORT_DIPSETTING (	0x01, DEF_STR( German ) )
	PORT_DIPSETTING (	0x02, DEF_STR( French ) )
	PORT_DIPSETTING (	0x03, DEF_STR( Spanish ) )
	PORT_DIPNAME( 0x04, 0x04, DEF_STR( Lives ) )
	PORT_DIPSETTING (	0x04, "3" )
	PORT_DIPSETTING (	0x00, "4" )
	PORT_DIPNAME( 0x08, 0x00, "Center Mech" ) /*Left same for 2-door mech*/
	PORT_DIPSETTING (	0x00, "X 1" )
	PORT_DIPSETTING (	0x08, "X 2" )
	PORT_DIPNAME( 0x30, 0x00, "Right Mech" )
	PORT_DIPSETTING (	0x00, "X 1" )
	PORT_DIPSETTING (	0x10, "X 4" )
	PORT_DIPSETTING (	0x20, "X 5" )
	PORT_DIPSETTING (	0x30, "X 6" )
	PORT_DIPNAME( 0xc0, 0x80, DEF_STR( Coinage ) )
	PORT_DIPSETTING (	0xc0, DEF_STR( 2C_1C ) )
	PORT_DIPSETTING (	0x80, DEF_STR( 1C_1C ) )
	PORT_DIPSETTING (	0x40, DEF_STR( 1C_2C ) )
	PORT_DIPSETTING (	0x00, DEF_STR( Free_Play ) )
INPUT_PORTS_END


/*************************************
 *
 *  Machine drivers
 *
 *************************************/

static MACHINE_DRIVER_START( asteroid )

	/* basic machine hardware */
	MDRV_CPU_ADD_TAG("main", M6502, 1500000)
	MDRV_CPU_PROGRAM_MAP(asteroid_map,0)
	MDRV_CPU_VBLANK_INT(asteroid_interrupt,4)	/* 250 Hz */

	MDRV_FRAMES_PER_SECOND(60)
	MDRV_MACHINE_INIT(asteroid)

	/* video hardware */
	MDRV_VIDEO_ATTRIBUTES(VIDEO_TYPE_VECTOR | VIDEO_RGB_DIRECT)
	MDRV_SCREEN_SIZE(400,300)
	MDRV_VISIBLE_AREA(0, 1040, 70, 950)
	MDRV_PALETTE_LENGTH(32768)

	MDRV_PALETTE_INIT(avg_white)
	MDRV_VIDEO_START(dvg)
	MDRV_VIDEO_UPDATE(vector)

	/* sound hardware */
	MDRV_SPEAKER_STANDARD_MONO("mono")

	MDRV_SOUND_ADD_TAG("disc", DISCRETE, 0)
	MDRV_SOUND_CONFIG(asteroid_discrete_interface)
	MDRV_SOUND_ROUTE(ALL_OUTPUTS, "mono", 1.0)
MACHINE_DRIVER_END

/*************************************
 *
 *  ROM definitions
 *
 *************************************/

ROM_START( asteroid )
	ROM_REGION( 0x8000, REGION_CPU1, 0 )	/* 64k for code */
	ROM_LOAD( "035145.02",    0x6800, 0x0800, CRC(0cc75459) SHA1(2af85c9689b878155004da47fedbde5853a18723) )
	ROM_LOAD( "035144.02",    0x7000, 0x0800, CRC(096ed35c) SHA1(064d680ded7f30c543f93ae5ca85f90d550f73e5) )
	ROM_LOAD( "035143.02",    0x7800, 0x0800, CRC(312caa02) SHA1(1ce2eac1ab90b972e3f1fc3d250908f26328d6cb) )
	/* Vector ROM */
	ROM_LOAD( "035127.02",    0x5000, 0x0800, CRC(8b71fd9e) SHA1(8cd5005e531eafa361d6b7e9eed159d164776c70) )
ROM_END

/*************************************
 *
 *  Game drivers
 *
 *************************************/

GAME( 1979, asteroid, 0,        asteroid, asteroid, 0,        ROT0, "Atari", "Asteroids (rev 2)", 0 )
