From: Sam Ravnborg <sam@ravnborg.org>
Date: Fri, 06 Jun 2008 21:00:13 +0000
Subject: [PATCH 01/21] sparc: copy exported sparc64 specific header files to asm-sparc
Message-Id: <1212786033-4227-1-git-send-email-sam@ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org

To get rid of ALTARCH in Kbuild copy remaining
exported header files that are sparc64 specific to asm-sparc.

Copy was done using the following simple script:

set -e
SPARC64=3D"apb.h bbc.h display7seg.h envctrl.h psrcompat.h pstate.h uctx.h =
utrap.h watchdog.h"
for FILE in ${SPARC64}; do
	if [ -f asm-sparc/$FILE ]; then
		echo $FILE exist in asm-sparc
	fi
	cat asm-sparc64/$FILE > asm-sparc/$FILE
	printf "#include <asm-sparc/$FILE>\n" > asm-sparc64/$FILE
done

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
---
 include/asm-sparc/apb.h           |   36 ++++++
 include/asm-sparc/bbc.h           |  225 +++++++++++++++++++++++++++++++++=
+++
 include/asm-sparc/display7seg.h   |   79 +++++++++++++
 include/asm-sparc/envctrl.h       |  103 +++++++++++++++++
 include/asm-sparc/psrcompat.h     |   45 ++++++++
 include/asm-sparc/pstate.h        |   91 +++++++++++++++
 include/asm-sparc/uctx.h          |   71 ++++++++++++
 include/asm-sparc/utrap.h         |   51 +++++++++
 include/asm-sparc/watchdog.h      |   31 +++++
 include/asm-sparc64/apb.h         |   37 +------
 include/asm-sparc64/bbc.h         |  226 +--------------------------------=
----
 include/asm-sparc64/display7seg.h |   80 +-------------
 include/asm-sparc64/envctrl.h     |  104 +-----------------
 include/asm-sparc64/psrcompat.h   |   46 +--------
 include/asm-sparc64/pstate.h      |   92 +---------------
 include/asm-sparc64/uctx.h        |   72 +------------
 include/asm-sparc64/utrap.h       |   52 +---------
 include/asm-sparc64/watchdog.h    |   32 +-----
 18 files changed, 741 insertions(+), 732 deletions(-)
 create mode 100644 include/asm-sparc/apb.h
 create mode 100644 include/asm-sparc/bbc.h
 create mode 100644 include/asm-sparc/display7seg.h
 create mode 100644 include/asm-sparc/envctrl.h
 create mode 100644 include/asm-sparc/psrcompat.h
 create mode 100644 include/asm-sparc/pstate.h
 create mode 100644 include/asm-sparc/uctx.h
 create mode 100644 include/asm-sparc/utrap.h
 create mode 100644 include/asm-sparc/watchdog.h

diff --git a/include/asm-sparc/apb.h b/include/asm-sparc/apb.h
new file mode 100644
index 0000000..8f3b57d
--- /dev/null
+++ b/include/asm-sparc/apb.h
@@ -0,0 +1,36 @@
+/*
+ * apb.h: Advanced PCI Bridge Configuration Registers and Bits
+ *
+ * Copyright (C) 1998  Eddie C. Dost  (ecd@skynet.be)
+ */
+
+#ifndef _SPARC64_APB_H
+#define _SPARC64_APB_H
+
+#define APB_TICK_REGISTER			0xb0
+#define APB_INT_ACK				0xb8
+#define APB_PRIMARY_MASTER_RETRY_LIMIT		0xc0
+#define APB_DMA_ASFR				0xc8
+#define APB_DMA_AFAR				0xd0
+#define APB_PIO_TARGET_RETRY_LIMIT		0xd8
+#define APB_PIO_TARGET_LATENCY_TIMER		0xd9
+#define APB_DMA_TARGET_RETRY_LIMIT		0xda
+#define APB_DMA_TARGET_LATENCY_TIMER		0xdb
+#define APB_SECONDARY_MASTER_RETRY_LIMIT	0xdc
+#define APB_SECONDARY_CONTROL			0xdd
+#define APB_IO_ADDRESS_MAP			0xde
+#define APB_MEM_ADDRESS_MAP			0xdf
+
+#define APB_PCI_CONTROL_LOW			0xe0
+#  define APB_PCI_CTL_LOW_ARB_PARK			(1 << 21)
+#  define APB_PCI_CTL_LOW_ERRINT_EN			(1 << 8)
+
+#define APB_PCI_CONTROL_HIGH			0xe4
+#  define APB_PCI_CTL_HIGH_SERR				(1 << 2)
+#  define APB_PCI_CTL_HIGH_ARBITER_EN			(1 << 0)
+
+#define APB_PIO_ASFR				0xe8
+#define APB_PIO_AFAR				0xf0
+#define APB_DIAG_REGISTER			0xf8
+
+#endif /* !(_SPARC64_APB_H) */
diff --git a/include/asm-sparc/bbc.h b/include/asm-sparc/bbc.h
new file mode 100644
index 0000000..423a858
--- /dev/null
+++ b/include/asm-sparc/bbc.h
@@ -0,0 +1,225 @@
+/*
+ * bbc.h: Defines for BootBus Controller found on UltraSPARC-III
+ *        systems.
+ *
+ * Copyright (C) 2000 David S. Miller (davem@redhat.com)
+ */
+
+#ifndef _SPARC64_BBC_H
+#define _SPARC64_BBC_H
+
+/* Register sizes are indicated by "B" (Byte, 1-byte),
+ * "H" (Half-word, 2 bytes), "W" (Word, 4 bytes) or
+ * "Q" (Quad, 8 bytes) inside brackets.
+ */
+
+#define BBC_AID		0x00	/* [B] Agent ID			*/
+#define BBC_DEVP	0x01	/* [B] Device Present		*/
+#define BBC_ARB		0x02	/* [B] Arbitration		*/
+#define BBC_QUIESCE	0x03	/* [B] Quiesce			*/
+#define BBC_WDACTION	0x04	/* [B] Watchdog Action		*/
+#define BBC_SPG		0x06	/* [B] Soft POR Gen		*/
+#define BBC_SXG		0x07	/* [B] Soft XIR Gen		*/
+#define BBC_PSRC	0x08	/* [W] POR Source		*/
+#define BBC_XSRC	0x0c	/* [B] XIR Source		*/
+#define BBC_CSC		0x0d	/* [B] Clock Synthesizers Control*/
+#define BBC_ES_CTRL	0x0e	/* [H] Energy Star Control	*/
+#define BBC_ES_ACT	0x10	/* [W] E* Assert Change Time	*/
+#define BBC_ES_DACT	0x14	/* [B] E* De-Assert Change Time	*/
+#define BBC_ES_DABT	0x15	/* [B] E* De-Assert Bypass Time	*/
+#define BBC_ES_ABT	0x16	/* [H] E* Assert Bypass Time	*/
+#define BBC_ES_PST	0x18	/* [W] E* PLL Settle Time	*/
+#define BBC_ES_FSL	0x1c	/* [W] E* Frequency Switch Latency*/
+#define BBC_EBUST	0x20	/* [Q] EBUS Timing		*/
+#define BBC_JTAG_CMD	0x28	/* [W] JTAG+ Command		*/
+#define BBC_JTAG_CTRL	0x2c	/* [B] JTAG+ Control		*/
+#define BBC_I2C_SEL	0x2d	/* [B] I2C Selection		*/
+#define BBC_I2C_0_S1	0x2e	/* [B] I2C ctrlr-0 reg S1	*/
+#define BBC_I2C_0_S0	0x2f	/* [B] I2C ctrlr-0 regs S0,S0',S2,S3*/
+#define BBC_I2C_1_S1	0x30	/* [B] I2C ctrlr-1 reg S1	*/
+#define BBC_I2C_1_S0	0x31	/* [B] I2C ctrlr-1 regs S0,S0',S2,S3*/
+#define BBC_KBD_BEEP	0x32	/* [B] Keyboard Beep		*/
+#define BBC_KBD_BCNT	0x34	/* [W] Keyboard Beep Counter	*/
+
+#define BBC_REGS_SIZE	0x40
+
+/* There is a 2K scratch ram area at offset 0x80000 but I doubt
+ * we will use it for anything.
+ */
+
+/* Agent ID register.  This register shows the Safari Agent ID
+ * for the processors.  The value returned depends upon which
+ * cpu is reading the register.
+ */
+#define BBC_AID_ID	0x07	/* Safari ID		*/
+#define BBC_AID_RESV	0xf8	/* Reserved		*/
+
+/* Device Present register.  One can determine which cpus are actually
+ * present in the machine by interrogating this register.
+ */
+#define BBC_DEVP_CPU0	0x01	/* Processor 0 present	*/
+#define BBC_DEVP_CPU1	0x02	/* Processor 1 present	*/
+#define BBC_DEVP_CPU2	0x04	/* Processor 2 present	*/
+#define BBC_DEVP_CPU3	0x08	/* Processor 3 present	*/
+#define BBC_DEVP_RESV	0xf0	/* Reserved		*/
+
+/* Arbitration register.  This register is used to block access to
+ * the BBC from a particular cpu.
+ */
+#define BBC_ARB_CPU0	0x01	/* Enable cpu 0 BBC arbitratrion */
+#define BBC_ARB_CPU1	0x02	/* Enable cpu 1 BBC arbitratrion */
+#define BBC_ARB_CPU2	0x04	/* Enable cpu 2 BBC arbitratrion */
+#define BBC_ARB_CPU3	0x08	/* Enable cpu 3 BBC arbitratrion */
+#define BBC_ARB_RESV	0xf0	/* Reserved			 */
+
+/* Quiesce register.  Bus and BBC segments for cpus can be disabled
+ * with this register, ie. for hot plugging.
+ */
+#define BBC_QUIESCE_S02	0x01	/* Quiesce Safari segment for cpu 0 and 2 */
+#define BBC_QUIESCE_S13	0x02	/* Quiesce Safari segment for cpu 1 and 3 */
+#define BBC_QUIESCE_B02	0x04	/* Quiesce BBC segment for cpu 0 and 2    */
+#define BBC_QUIESCE_B13	0x08	/* Quiesce BBC segment for cpu 1 and 3    */
+#define BBC_QUIESCE_FD0 0x10	/* Disable Fatal_Error[0] reporting	  */
+#define BBC_QUIESCE_FD1 0x20	/* Disable Fatal_Error[1] reporting	  */
+#define BBC_QUIESCE_FD2 0x40	/* Disable Fatal_Error[2] reporting	  */
+#define BBC_QUIESCE_FD3 0x80	/* Disable Fatal_Error[3] reporting	  */
+
+/* Watchdog Action register.  When the watchdog device timer expires
+ * a line is enabled to the BBC.  The action BBC takes when this line
+ * is asserted can be controlled by this regiser.
+ */
+#define BBC_WDACTION_RST  0x01	/* When set, watchdog causes system reset.
+				 * When clear, BBC ignores watchdog signal.
+				 */
+#define BBC_WDACTION_RESV 0xfe	/* Reserved */
+
+/* Soft_POR_GEN register.  The POR (Power On Reset) signal may be asserted
+ * for specific processors or all processors via this register.
+ */
+#define BBC_SPG_CPU0	0x01 /* Assert POR for processor 0	*/
+#define BBC_SPG_CPU1	0x02 /* Assert POR for processor 1	*/
+#define BBC_SPG_CPU2	0x04 /* Assert POR for processor 2	*/
+#define BBC_SPG_CPU3	0x08 /* Assert POR for processor 3	*/
+#define BBC_SPG_CPUALL	0x10 /* Reset all processors and reset
+			      * the entire system.
+			      */
+#define BBC_SPG_RESV	0xe0 /* Reserved			*/
+
+/* Soft_XIR_GEN register.  The XIR (eXternally Initiated Reset) signal
+ * may be asserted to specific processors via this register.
+ */
+#define BBC_SXG_CPU0	0x01 /* Assert XIR for processor 0	*/
+#define BBC_SXG_CPU1	0x02 /* Assert XIR for processor 1	*/
+#define BBC_SXG_CPU2	0x04 /* Assert XIR for processor 2	*/
+#define BBC_SXG_CPU3	0x08 /* Assert XIR for processor 3	*/
+#define BBC_SXG_RESV	0xf0 /* Reserved			*/
+
+/* POR Source register.  One may identify the cause of the most recent
+ * reset by reading this register.
+ */
+#define BBC_PSRC_SPG0	0x0001 /* CPU 0 reset via BBC_SPG register	*/
+#define BBC_PSRC_SPG1	0x0002 /* CPU 1 reset via BBC_SPG register	*/
+#define BBC_PSRC_SPG2	0x0004 /* CPU 2 reset via BBC_SPG register	*/
+#define BBC_PSRC_SPG3	0x0008 /* CPU 3 reset via BBC_SPG register	*/
+#define BBC_PSRC_SPGSYS	0x0010 /* System reset via BBC_SPG register	*/
+#define BBC_PSRC_JTAG	0x0020 /* System reset via JTAG+		*/
+#define BBC_PSRC_BUTTON	0x0040 /* System reset via push-button dongle	*/
+#define BBC_PSRC_PWRUP	0x0080 /* System reset via power-up		*/
+#define BBC_PSRC_FE0	0x0100 /* CPU 0 reported Fatal_Error		*/
+#define BBC_PSRC_FE1	0x0200 /* CPU 1 reported Fatal_Error		*/
+#define BBC_PSRC_FE2	0x0400 /* CPU 2 reported Fatal_Error		*/
+#define BBC_PSRC_FE3	0x0800 /* CPU 3 reported Fatal_Error		*/
+#define BBC_PSRC_FE4	0x1000 /* Schizo reported Fatal_Error		*/
+#define BBC_PSRC_FE5	0x2000 /* Safari device 5 reported Fatal_Error	*/
+#define BBC_PSRC_FE6	0x4000 /* CPMS reported Fatal_Error		*/
+#define BBC_PSRC_SYNTH	0x8000 /* System reset when on-board clock synthesi=
zers
+				* were updated.
+				*/
+#define BBC_PSRC_WDT   0x10000 /* System reset via Super I/O watchdog	*/
+#define BBC_PSRC_RSC   0x20000 /* System reset via RSC remote monitoring
+				* device
+				*/
+
+/* XIR Source register.  The source of an XIR event sent to a processor may
+ * be determined via this register.
+ */
+#define BBC_XSRC_SXG0	0x01	/* CPU 0 received XIR via Soft_XIR_GEN reg */
+#define BBC_XSRC_SXG1	0x02	/* CPU 1 received XIR via Soft_XIR_GEN reg */
+#define BBC_XSRC_SXG2	0x04	/* CPU 2 received XIR via Soft_XIR_GEN reg */
+#define BBC_XSRC_SXG3	0x08	/* CPU 3 received XIR via Soft_XIR_GEN reg */
+#define BBC_XSRC_JTAG	0x10	/* All CPUs received XIR via JTAG+         */
+#define BBC_XSRC_W_OR_B	0x20	/* All CPUs received XIR either because:
+				 * a) Super I/O watchdog fired, or
+				 * b) XIR push button was activated
+				 */
+#define BBC_XSRC_RESV	0xc0	/* Reserved				   */
+
+/* Clock Synthesizers Control register.  This register provides the big-ba=
ng
+ * programming interface to the two clock synthesizers of the machine.
+ */
+#define BBC_CSC_SLOAD	0x01	/* Directly connected to S_LOAD pins	*/
+#define BBC_CSC_SDATA	0x02	/* Directly connected to S_DATA pins	*/
+#define BBC_CSC_SCLOCK	0x04	/* Directly connected to S_CLOCK pins	*/
+#define BBC_CSC_RESV	0x78	/* Reserved				*/
+#define BBC_CSC_RST	0x80	/* Generate system reset when S_LOAD=3D1	*/
+
+/* Energy Star Control register.  This register is used to generate the
+ * clock frequency change trigger to the main system devices (Schizo and
+ * the processors).  The transition occurs when bits in this register
+ * go from 0 to 1, only one bit must be set at once else no action
+ * occurs.  Basically the sequence of events is:
+ * a) Choose new frequency: full, 1/2 or 1/32
+ * b) Program this desired frequency into the cpus and Schizo.
+ * c) Set the same value in this register.
+ * d) 16 system clocks later, clear this register.
+ */
+#define BBC_ES_CTRL_1_1		0x01	/* Full frequency	*/
+#define BBC_ES_CTRL_1_2		0x02	/* 1/2 frequency	*/
+#define BBC_ES_CTRL_1_32	0x20	/* 1/32 frequency	*/
+#define BBC_ES_RESV		0xdc	/* Reserved		*/
+
+/* Energy Star Assert Change Time register.  This determines the number
+ * of BBC clock cycles (which is half the system frequency) between
+ * the detection of FREEZE_ACK being asserted and the assertion of
+ * the CLK_CHANGE_L[2:0] signals.
+ */
+#define BBC_ES_ACT_VAL	0xff
+
+/* Energy Star Assert Bypass Time register.  This determines the number
+ * of BBC clock cycles (which is half the system frequency) between
+ * the assertion of the CLK_CHANGE_L[2:0] signals and the assertion of
+ * the ESTAR_PLL_BYPASS signal.
+ */
+#define BBC_ES_ABT_VAL	0xffff
+
+/* Energy Star PLL Settle Time register.  This determines the number of
+ * BBC clock cycles (which is half the system frequency) between the
+ * de-assertion of CLK_CHANGE_L[2:0] and the de-assertion of the FREEZE_L
+ * signal.
+ */
+#define BBC_ES_PST_VAL	0xffffffff
+
+/* Energy Star Frequency Switch Latency register.  This is the number of
+ * BBC clocks between the de-assertion of CLK_CHANGE_L[2:0] and the first
+ * edge of the Safari clock at the new frequency.
+ */
+#define BBC_ES_FSL_VAL	0xffffffff
+
+/* Keyboard Beep control register.  This is a simple enabler for the audio
+ * beep sound.
+ */
+#define BBC_KBD_BEEP_ENABLE	0x01 /* Enable beep	*/
+#define BBC_KBD_BEEP_RESV	0xfe /* Reserved	*/
+
+/* Keyboard Beep Counter register.  There is a free-running counter inside
+ * the BBC which runs at half the system clock.  The bit set in this regis=
ter
+ * determines when the audio sound is generated.  So for example if bit
+ * 10 is set, the audio beep will oscillate at 1/(2**12).  The keyboard be=
ep
+ * generator automatically selects a different bit to use if the system cl=
ock
+ * is changed via Energy Star.
+ */
+#define BBC_KBD_BCNT_BITS	0x0007fc00
+#define BBC_KBC_BCNT_RESV	0xfff803ff
+
+#endif /* _SPARC64_BBC_H */
+
diff --git a/include/asm-sparc/display7seg.h b/include/asm-sparc/display7se=
g.h
new file mode 100644
index 0000000..c066a89
--- /dev/null
+++ b/include/asm-sparc/display7seg.h
@@ -0,0 +1,79 @@
+/*
+ *
+ * display7seg - Driver interface for the 7-segment display
+ * present on Sun Microsystems CP1400 and CP1500
+ *
+ * Copyright (c) 2000 Eric Brower <ebrower@usa.net>
+ *
+ */
+
+#ifndef __display7seg_h__
+#define __display7seg_h__
+
+#define D7S_IOC	'p'
+
+#define D7SIOCRD _IOR(D7S_IOC, 0x45, int)	/* Read device state	*/
+#define D7SIOCWR _IOW(D7S_IOC, 0x46, int)	/* Write device state	*/
+#define D7SIOCTM _IO (D7S_IOC, 0x47)		/* Translate mode (FLIP)*/
+
+/*
+ * ioctl flag definitions
+ *
+ * POINT	- Toggle decimal point	(0=ABsent 1=3Dpresent)
+ * ALARM	- Toggle alarm LED 		(0=3Dgreen  1=3Dred)
+ * FLIP		- Toggle inverted mode 	(0=3Dnormal 1=3Dflipped)=20
+ * bits 0-4	- Character displayed	(see definitions below)
+ *
+ * Display segments are defined as follows,=20
+ * subject to D7S_FLIP register state:
+ *
+ *    a
+ *   ---
+ * f|   |b
+ *   -g-
+ * e|   |c
+ *   ---
+ *    d
+ */
+
+#define D7S_POINT	(1 << 7)	/* Decimal point*/
+#define D7S_ALARM	(1 << 6)	/* Alarm LED 	*/
+#define D7S_FLIP	(1 << 5)	/* Flip display */
+
+#define D7S_0		0x00		/* Numerals 0-9 */
+#define D7S_1		0x01
+#define D7S_2		0x02
+#define D7S_3		0x03
+#define D7S_4		0x04
+#define D7S_5		0x05
+#define D7S_6		0x06
+#define D7S_7		0x07
+#define D7S_8		0x08
+#define D7S_9		0x09
+#define D7S_A		0x0A		/* Letters A-F, H, L, P */
+#define D7S_B		0x0B
+#define D7S_C		0x0C
+#define D7S_D		0x0D
+#define D7S_E		0x0E
+#define D7S_F		0x0F
+#define D7S_H		0x10
+#define D7S_E2		0x11
+#define D7S_L		0x12
+#define D7S_P		0x13
+#define D7S_SEGA	0x14		/* Individual segments */
+#define D7S_SEGB	0x15
+#define D7S_SEGC	0x16
+#define D7S_SEGD	0x17
+#define D7S_SEGE	0x18
+#define D7S_SEGF	0x19
+#define D7S_SEGG	0x1A
+#define D7S_SEGABFG 0x1B		/* Segment groupings */
+#define D7S_SEGCDEG	0x1C
+#define D7S_SEGBCEF 0x1D
+#define D7S_SEGADG	0x1E
+#define D7S_BLANK	0x1F		/* Clear all segments */
+
+#define D7S_MIN_VAL	0x0
+#define D7S_MAX_VAL	0x1F
+
+#endif /* ifndef __display7seg_h__ */
diff --git a/include/asm-sparc/envctrl.h b/include/asm-sparc/envctrl.h
new file mode 100644
index 0000000..a5668a0
--- /dev/null
+++ b/include/asm-sparc/envctrl.h
@@ -0,0 +1,103 @@
+/*
+ *
+ * envctrl.h: Definitions for access to the i2c environment
+ *            monitoring on Ultrasparc systems.
+ *
+ * Copyright (C) 1998  Eddie C. Dost  (ecd@skynet.be)
+ * Copyright (C) 2000  Vinh Truong  (vinh.truong@eng.sun.com)
+ * VT - Add all ioctl commands and environment status definitions=20
+ * VT - Add application note=20
+ */
+#ifndef _SPARC64_ENVCTRL_H
+#define _SPARC64_ENVCTRL_H 1
+
+#include <linux/ioctl.h>
+
+/* Application note:
+ *
+ * The driver supports 4 operations: open(), close(), ioctl(), read()
+ * The device name is /dev/envctrl.
+ * Below is sample usage:
+ *
+ *	fd =3D open("/dev/envtrl", O_RDONLY);
+ *	if (ioctl(fd, ENVCTRL_READ_SHUTDOWN_TEMPERATURE, 0) < 0)
+ *		printf("error\n");
+ *	ret =3D read(fd, buf, 10);
+ *	close(fd);
+ *
+ * Notice in the case of cpu voltage and temperature, the default is
+ * cpu0.  If we need to know the info of cpu1, cpu2, cpu3, we need to
+ * pass in cpu number in ioctl() last parameter.  For example, to
+ * get the voltage of cpu2:
+ *
+ *	ioctlbuf[0] =3D 2;
+ *	if (ioctl(fd, ENVCTRL_READ_CPU_VOLTAGE, ioctlbuf) < 0)
+ *		printf("error\n");
+ *	ret =3D read(fd, buf, 10);
+ *
+ * All the return values are in ascii.  So check read return value
+ * and do appropriate conversions in your application.
+ */
+
+/* IOCTL commands */
+
+/* Note: these commands reflect possible monitor features.
+ * Some boards choose to support some of the features only.
+ */
+#define ENVCTRL_RD_CPU_TEMPERATURE	_IOR('p', 0x40, int)
+#define ENVCTRL_RD_CPU_VOLTAGE		_IOR('p', 0x41, int)
+#define ENVCTRL_RD_FAN_STATUS		_IOR('p', 0x42, int)
+#define ENVCTRL_RD_WARNING_TEMPERATURE	_IOR('p', 0x43, int)
+#define ENVCTRL_RD_SHUTDOWN_TEMPERATURE	_IOR('p', 0x44, int)
+#define ENVCTRL_RD_VOLTAGE_STATUS	_IOR('p', 0x45, int)
+#define ENVCTRL_RD_SCSI_TEMPERATURE	_IOR('p', 0x46, int)
+#define ENVCTRL_RD_ETHERNET_TEMPERATURE	_IOR('p', 0x47, int)
+#define ENVCTRL_RD_MTHRBD_TEMPERATURE	_IOR('p', 0x48, int)
+
+#define ENVCTRL_RD_GLOBALADDRESS	_IOR('p', 0x49, int)
+
+/* Read return values for a voltage status request. */
+#define ENVCTRL_VOLTAGE_POWERSUPPLY_GOOD	0x01
+#define ENVCTRL_VOLTAGE_BAD			0x02
+#define ENVCTRL_POWERSUPPLY_BAD			0x03
+#define ENVCTRL_VOLTAGE_POWERSUPPLY_BAD		0x04
+
+/* Read return values for a fan status request.
+ * A failure match means either the fan fails or
+ * the fan is not connected.  Some boards have optional
+ * connectors to connect extra fans.
+ *
+ * There are maximum 8 monitor fans.  Some are cpu fans
+ * some are system fans.  The mask below only indicates
+ * fan by order number.
+ * Below is a sample application:
+ *
+ *	if (ioctl(fd, ENVCTRL_READ_FAN_STATUS, 0) < 0) {
+ *		printf("ioctl fan failed\n");
+ *	}
+ *	if (read(fd, rslt, 1) <=3D 0) {
+ *		printf("error or fan not monitored\n");
+ *	} else {
+ *		if (rslt[0] =3D ENVCTRL_ALL_FANS_GOOD) {
+ *			printf("all fans good\n");
+ *	} else if (rslt[0] =3D ENVCTRL_ALL_FANS_BAD) {
+ *		printf("all fans bad\n");
+ *	} else {
+ *		if (rslt[0] & ENVCTRL_FAN0_FAILURE_MASK) {
+ *			printf("fan 0 failed or not connected\n");
+ *	}
+ *	......
+ */ =20
+
+#define ENVCTRL_ALL_FANS_GOOD			0x00
+#define ENVCTRL_FAN0_FAILURE_MASK		0x01
+#define ENVCTRL_FAN1_FAILURE_MASK		0x02
+#define ENVCTRL_FAN2_FAILURE_MASK		0x04
+#define ENVCTRL_FAN3_FAILURE_MASK		0x08
+#define ENVCTRL_FAN4_FAILURE_MASK		0x10
+#define ENVCTRL_FAN5_FAILURE_MASK		0x20
+#define ENVCTRL_FAN6_FAILURE_MASK		0x40
+#define ENVCTRL_FAN7_FAILURE_MASK		0x80
+#define ENVCTRL_ALL_FANS_BAD 			0xFF
+
+#endif /* !(_SPARC64_ENVCTRL_H) */
diff --git a/include/asm-sparc/psrcompat.h b/include/asm-sparc/psrcompat.h
new file mode 100644
index 0000000..44b6327
--- /dev/null
+++ b/include/asm-sparc/psrcompat.h
@@ -0,0 +1,45 @@
+#ifndef _SPARC64_PSRCOMPAT_H
+#define _SPARC64_PSRCOMPAT_H
+
+#include <asm/pstate.h>
+
+/* Old 32-bit PSR fields for the compatibility conversion code. */
+#define PSR_CWP     0x0000001f         /* current window pointer     */
+#define PSR_ET      0x00000020         /* enable traps field         */
+#define PSR_PS      0x00000040         /* previous privilege level   */
+#define PSR_S       0x00000080         /* current privilege level    */
+#define PSR_PIL     0x00000f00         /* processor interrupt level  */
+#define PSR_EF      0x00001000         /* enable floating point      */
+#define PSR_EC      0x00002000         /* enable co-processor        */
+#define PSR_SYSCALL 0x00004000         /* inside of a syscall        */
+#define PSR_LE      0x00008000         /* SuperSparcII little-endian */
+#define PSR_ICC     0x00f00000         /* integer condition codes    */
+#define PSR_C       0x00100000         /* carry bit                  */
+#define PSR_V       0x00200000         /* overflow bit               */
+#define PSR_Z       0x00400000         /* zero bit                   */
+#define PSR_N       0x00800000         /* negative bit               */
+#define PSR_VERS    0x0f000000         /* cpu-version field          */
+#define PSR_IMPL    0xf0000000         /* cpu-implementation field   */
+
+#define PSR_V8PLUS  0xff000000         /* fake impl/ver, meaning a 64bit C=
PU is present */
+#define PSR_XCC	    0x000f0000         /* if PSR_V8PLUS, this is %xcc */
+
+static inline unsigned int tstate_to_psr(unsigned long tstate)
+{
+	return ((tstate & TSTATE_CWP)			|
+		PSR_S					|
+		((tstate & TSTATE_ICC) >> 12)		|
+		((tstate & TSTATE_XCC) >> 20)		|
+		((tstate & TSTATE_SYSCALL) ? PSR_SYSCALL : 0) |
+		PSR_V8PLUS);
+}
+
+static inline unsigned long psr_to_tstate_icc(unsigned int psr)
+{
+	unsigned long tstate =3D ((unsigned long)(psr & PSR_ICC)) << 12;
+	if ((psr & (PSR_VERS|PSR_IMPL)) =3D PSR_V8PLUS)
+		tstate |=3D ((unsigned long)(psr & PSR_XCC)) << 20;
+	return tstate;
+}
+
+#endif /* !(_SPARC64_PSRCOMPAT_H) */
diff --git a/include/asm-sparc/pstate.h b/include/asm-sparc/pstate.h
new file mode 100644
index 0000000..a26a537
--- /dev/null
+++ b/include/asm-sparc/pstate.h
@@ -0,0 +1,91 @@
+#ifndef _SPARC64_PSTATE_H
+#define _SPARC64_PSTATE_H
+
+#include <linux/const.h>
+
+/* The V9 PSTATE Register (with SpitFire extensions).
+ *
+ * -----------------------------------------------------------------------
+ * | Resv | IG | MG | CLE | TLE |  MM  | RED | PEF | AM | PRIV | IE | AG |
+ * -----------------------------------------------------------------------
+ *  63  12  11   10    9     8    7   6   5     4     3     2     1    0
+ */
+#define PSTATE_IG   _AC(0x0000000000000800,UL) /* Interrupt Globals.	*/
+#define PSTATE_MG   _AC(0x0000000000000400,UL) /* MMU Globals.		*/
+#define PSTATE_CLE  _AC(0x0000000000000200,UL) /* Current Little Endian.*/
+#define PSTATE_TLE  _AC(0x0000000000000100,UL) /* Trap Little Endian.	*/
+#define PSTATE_MM   _AC(0x00000000000000c0,UL) /* Memory Model.		*/
+#define PSTATE_TSO  _AC(0x0000000000000000,UL) /* MM: TotalStoreOrder	*/
+#define PSTATE_PSO  _AC(0x0000000000000040,UL) /* MM: PartialStoreOrder	*/
+#define PSTATE_RMO  _AC(0x0000000000000080,UL) /* MM: RelaxedMemoryOrder*/
+#define PSTATE_RED  _AC(0x0000000000000020,UL) /* Reset Error Debug.	*/
+#define PSTATE_PEF  _AC(0x0000000000000010,UL) /* Floating Point Enable.*/
+#define PSTATE_AM   _AC(0x0000000000000008,UL) /* Address Mask.		*/
+#define PSTATE_PRIV _AC(0x0000000000000004,UL) /* Privilege.		*/
+#define PSTATE_IE   _AC(0x0000000000000002,UL) /* Interrupt Enable.	*/
+#define PSTATE_AG   _AC(0x0000000000000001,UL) /* Alternate Globals.	*/
+
+/* The V9 TSTATE Register (with SpitFire and Linux extensions).
+ *
+ * ---------------------------------------------------------------------
+ * |  Resv |  GL  |  CCR  |  ASI  |  %pil  |  PSTATE  |  Resv  |  CWP  |
+ * ---------------------------------------------------------------------
+ *  63   43 42  40 39   32 31   24 23    20 19       8 7      5 4     0
+ */
+#define TSTATE_GL	_AC(0x0000070000000000,UL) /* Global reg level  */
+#define TSTATE_CCR	_AC(0x000000ff00000000,UL) /* Condition Codes.	*/
+#define TSTATE_XCC	_AC(0x000000f000000000,UL) /* Condition Codes.	*/
+#define TSTATE_XNEG	_AC(0x0000008000000000,UL) /* %xcc Negative.	*/
+#define TSTATE_XZERO	_AC(0x0000004000000000,UL) /* %xcc Zero.	*/
+#define TSTATE_XOVFL	_AC(0x0000002000000000,UL) /* %xcc Overflow.	*/
+#define TSTATE_XCARRY	_AC(0x0000001000000000,UL) /* %xcc Carry.	*/
+#define TSTATE_ICC	_AC(0x0000000f00000000,UL) /* Condition Codes.	*/
+#define TSTATE_INEG	_AC(0x0000000800000000,UL) /* %icc Negative.	*/
+#define TSTATE_IZERO	_AC(0x0000000400000000,UL) /* %icc Zero.	*/
+#define TSTATE_IOVFL	_AC(0x0000000200000000,UL) /* %icc Overflow.	*/
+#define TSTATE_ICARRY	_AC(0x0000000100000000,UL) /* %icc Carry.	*/
+#define TSTATE_ASI	_AC(0x00000000ff000000,UL) /* AddrSpace ID.	*/
+#define TSTATE_PIL	_AC(0x0000000000f00000,UL) /* %pil (Linux traps)*/
+#define TSTATE_PSTATE	_AC(0x00000000000fff00,UL) /* PSTATE.		*/
+#define TSTATE_IG	_AC(0x0000000000080000,UL) /* Interrupt Globals.*/
+#define TSTATE_MG	_AC(0x0000000000040000,UL) /* MMU Globals.	*/
+#define TSTATE_CLE	_AC(0x0000000000020000,UL) /* CurrLittleEndian.	*/
+#define TSTATE_TLE	_AC(0x0000000000010000,UL) /* TrapLittleEndian.	*/
+#define TSTATE_MM	_AC(0x000000000000c000,UL) /* Memory Model.	*/
+#define TSTATE_TSO	_AC(0x0000000000000000,UL) /* MM: TSO		*/
+#define TSTATE_PSO	_AC(0x0000000000004000,UL) /* MM: PSO		*/
+#define TSTATE_RMO	_AC(0x0000000000008000,UL) /* MM: RMO		*/
+#define TSTATE_RED	_AC(0x0000000000002000,UL) /* Reset Error Debug.*/
+#define TSTATE_PEF	_AC(0x0000000000001000,UL) /* FPU Enable.	*/
+#define TSTATE_AM	_AC(0x0000000000000800,UL) /* Address Mask.	*/
+#define TSTATE_PRIV	_AC(0x0000000000000400,UL) /* Privilege.	*/
+#define TSTATE_IE	_AC(0x0000000000000200,UL) /* Interrupt Enable.	*/
+#define TSTATE_AG	_AC(0x0000000000000100,UL) /* Alternate Globals.*/
+#define TSTATE_SYSCALL	_AC(0x0000000000000020,UL) /* in syscall trap   */
+#define TSTATE_CWP	_AC(0x000000000000001f,UL) /* Curr Win-Pointer.	*/
+
+/* Floating-Point Registers State Register.
+ *
+ * --------------------------------
+ * |  Resv  |  FEF  |  DU  |  DL  |
+ * --------------------------------
+ *  63     3    2       1      0
+ */
+#define FPRS_FEF	_AC(0x0000000000000004,UL) /* FPU Enable.	*/
+#define FPRS_DU		_AC(0x0000000000000002,UL) /* Dirty Upper.	*/
+#define FPRS_DL		_AC(0x0000000000000001,UL) /* Dirty Lower.	*/
+
+/* Version Register.
+ *
+ * ------------------------------------------------------
+ * | MANUF | IMPL | MASK | Resv | MAXTL | Resv | MAXWIN |
+ * ------------------------------------------------------
+ *  63   48 47  32 31  24 23  16 15    8 7    5 4      0
+ */
+#define VERS_MANUF	_AC(0xffff000000000000,UL) /* Manufacturer.	*/
+#define VERS_IMPL	_AC(0x0000ffff00000000,UL) /* Implementation.	*/
+#define VERS_MASK	_AC(0x00000000ff000000,UL) /* Mask Set Revision.*/
+#define VERS_MAXTL	_AC(0x000000000000ff00,UL) /* Max Trap Level.	*/
+#define VERS_MAXWIN	_AC(0x000000000000001f,UL) /* Max RegWindow Idx.*/
+
+#endif /* !(_SPARC64_PSTATE_H) */
diff --git a/include/asm-sparc/uctx.h b/include/asm-sparc/uctx.h
new file mode 100644
index 0000000..dc937c7
--- /dev/null
+++ b/include/asm-sparc/uctx.h
@@ -0,0 +1,71 @@
+/*
+ * uctx.h: Sparc64 {set,get}context() register state layouts.
+ *
+ * Copyright (C) 1997 David S. Miller (davem@caip.rutgers.edu)
+ */
+
+#ifndef __SPARC64_UCTX_H
+#define __SPARC64_UCTX_H
+
+#define MC_TSTATE	0
+#define MC_PC		1
+#define MC_NPC		2
+#define MC_Y		3
+#define MC_G1		4
+#define MC_G2		5
+#define MC_G3		6
+#define MC_G4		7
+#define MC_G5		8
+#define MC_G6		9
+#define MC_G7		10
+#define MC_O0		11
+#define MC_O1		12
+#define MC_O2		13
+#define MC_O3		14
+#define MC_O4		15
+#define MC_O5		16
+#define MC_O6		17
+#define MC_O7		18
+#define MC_NGREG	19
+
+typedef unsigned long mc_greg_t;
+typedef mc_greg_t mc_gregset_t[MC_NGREG];
+
+#define MC_MAXFPQ	16
+struct mc_fq {
+	unsigned long	*mcfq_addr;
+	unsigned int	mcfq_insn;
+};
+
+struct mc_fpu {
+	union {
+		unsigned int	sregs[32];
+		unsigned long	dregs[32];
+		long double	qregs[16];
+	} mcfpu_fregs;
+	unsigned long	mcfpu_fsr;
+	unsigned long	mcfpu_fprs;
+	unsigned long	mcfpu_gsr;
+	struct mc_fq	*mcfpu_fq;
+	unsigned char	mcfpu_qcnt;
+	unsigned char	mcfpu_qentsz;
+	unsigned char	mcfpu_enab;
+};
+typedef struct mc_fpu mc_fpu_t;
+
+typedef struct {
+	mc_gregset_t	mc_gregs;
+	mc_greg_t	mc_fp;
+	mc_greg_t	mc_i7;
+	mc_fpu_t	mc_fpregs;
+} mcontext_t;
+
+struct ucontext {
+	struct ucontext		*uc_link;
+	unsigned long		uc_flags;
+	sigset_t		uc_sigmask;
+	mcontext_t		uc_mcontext;
+};
+typedef struct ucontext ucontext_t;
+
+#endif /* __SPARC64_UCTX_H */
diff --git a/include/asm-sparc/utrap.h b/include/asm-sparc/utrap.h
new file mode 100644
index 0000000..e49e5c4
--- /dev/null
+++ b/include/asm-sparc/utrap.h
@@ -0,0 +1,51 @@
+/*
+ * include/asm-sparc64/utrap.h
+ *
+ * Copyright (C) 1997 Jakub Jelinek (jj@sunsite.mff.cuni.cz)
+ */
+
+#ifndef __ASM_SPARC64_UTRAP_H
+#define __ASM_SPARC64_UTRAP_H
+
+#define UT_INSTRUCTION_EXCEPTION		1
+#define UT_INSTRUCTION_ERROR			2
+#define UT_INSTRUCTION_PROTECTION		3
+#define UT_ILLTRAP_INSTRUCTION			4
+#define UT_ILLEGAL_INSTRUCTION			5
+#define UT_PRIVILEGED_OPCODE			6
+#define UT_FP_DISABLED				7
+#define UT_FP_EXCEPTION_IEEE_754		8
+#define UT_FP_EXCEPTION_OTHER			9
+#define UT_TAG_OVERVIEW				10
+#define UT_DIVISION_BY_ZERO			11
+#define UT_DATA_EXCEPTION			12
+#define UT_DATA_ERROR				13
+#define UT_DATA_PROTECTION			14
+#define UT_MEM_ADDRESS_NOT_ALIGNED		15
+#define UT_PRIVILEGED_ACTION			16
+#define UT_ASYNC_DATA_ERROR			17
+#define UT_TRAP_INSTRUCTION_16			18
+#define UT_TRAP_INSTRUCTION_17			19
+#define UT_TRAP_INSTRUCTION_18			20
+#define UT_TRAP_INSTRUCTION_19			21
+#define UT_TRAP_INSTRUCTION_20			22
+#define UT_TRAP_INSTRUCTION_21			23
+#define UT_TRAP_INSTRUCTION_22			24
+#define UT_TRAP_INSTRUCTION_23			25
+#define UT_TRAP_INSTRUCTION_24			26
+#define UT_TRAP_INSTRUCTION_25			27
+#define UT_TRAP_INSTRUCTION_26			28
+#define UT_TRAP_INSTRUCTION_27			29
+#define UT_TRAP_INSTRUCTION_28			30
+#define UT_TRAP_INSTRUCTION_29			31
+#define UT_TRAP_INSTRUCTION_30			32
+#define UT_TRAP_INSTRUCTION_31			33
+
+#define	UTH_NOCHANGE				(-1)
+
+#ifndef __ASSEMBLY__=20
+typedef int utrap_entry_t;
+typedef void *utrap_handler_t;
+#endif /* __ASSEMBLY__ */
+
+#endif /* !(__ASM_SPARC64_PROCESSOR_H) */
diff --git a/include/asm-sparc/watchdog.h b/include/asm-sparc/watchdog.h
new file mode 100644
index 0000000..5baf2d3
--- /dev/null
+++ b/include/asm-sparc/watchdog.h
@@ -0,0 +1,31 @@
+/*
+ *
+ * watchdog - Driver interface for the hardware watchdog timers
+ * present on Sun Microsystems boardsets
+ *
+ * Copyright (c) 2000 Eric Brower <ebrower@usa.net>
+ *
+ */
+
+#ifndef _SPARC64_WATCHDOG_H
+#define _SPARC64_WATCHDOG_H
+
+#include <linux/watchdog.h>
+
+/* Solaris compatibility ioctls--
+ * Ref. <linux/watchdog.h> for standard linux watchdog ioctls
+ */
+#define WIOCSTART _IO (WATCHDOG_IOCTL_BASE, 10)		/* Start Timer		*/
+#define WIOCSTOP  _IO (WATCHDOG_IOCTL_BASE, 11)		/* Stop Timer		*/
+#define WIOCGSTAT _IOR(WATCHDOG_IOCTL_BASE, 12, int)/* Get Timer Status	*/
+
+/* Status flags from WIOCGSTAT ioctl
+ */
+#define WD_FREERUN	0x01	/* timer is running, interrupts disabled	*/
+#define WD_EXPIRED	0x02	/* timer has expired						*/
+#define WD_RUNNING	0x04	/* timer is running, interrupts enabled		*/
+#define WD_STOPPED	0x08	/* timer has not been started				*/
+#define WD_SERVICED 0x10	/* timer interrupt was serviced				*/
+
+#endif /* ifndef _SPARC64_WATCHDOG_H */
+
diff --git a/include/asm-sparc64/apb.h b/include/asm-sparc64/apb.h
index 8f3b57d..5e236ca 100644
--- a/include/asm-sparc64/apb.h
+++ b/include/asm-sparc64/apb.h
@@ -1,36 +1 @@
-/*
- * apb.h: Advanced PCI Bridge Configuration Registers and Bits
- *
- * Copyright (C) 1998  Eddie C. Dost  (ecd@skynet.be)
- */
-
-#ifndef _SPARC64_APB_H
-#define _SPARC64_APB_H
-
-#define APB_TICK_REGISTER			0xb0
-#define APB_INT_ACK				0xb8
-#define APB_PRIMARY_MASTER_RETRY_LIMIT		0xc0
-#define APB_DMA_ASFR				0xc8
-#define APB_DMA_AFAR				0xd0
-#define APB_PIO_TARGET_RETRY_LIMIT		0xd8
-#define APB_PIO_TARGET_LATENCY_TIMER		0xd9
-#define APB_DMA_TARGET_RETRY_LIMIT		0xda
-#define APB_DMA_TARGET_LATENCY_TIMER		0xdb
-#define APB_SECONDARY_MASTER_RETRY_LIMIT	0xdc
-#define APB_SECONDARY_CONTROL			0xdd
-#define APB_IO_ADDRESS_MAP			0xde
-#define APB_MEM_ADDRESS_MAP			0xdf
-
-#define APB_PCI_CONTROL_LOW			0xe0
-#  define APB_PCI_CTL_LOW_ARB_PARK			(1 << 21)
-#  define APB_PCI_CTL_LOW_ERRINT_EN			(1 << 8)
-
-#define APB_PCI_CONTROL_HIGH			0xe4
-#  define APB_PCI_CTL_HIGH_SERR				(1 << 2)
-#  define APB_PCI_CTL_HIGH_ARBITER_EN			(1 << 0)
-
-#define APB_PIO_ASFR				0xe8
-#define APB_PIO_AFAR				0xf0
-#define APB_DIAG_REGISTER			0xf8
-
-#endif /* !(_SPARC64_APB_H) */
+#include <asm-sparc/apb.h>
diff --git a/include/asm-sparc64/bbc.h b/include/asm-sparc64/bbc.h
index 423a858..06e8b63 100644
--- a/include/asm-sparc64/bbc.h
+++ b/include/asm-sparc64/bbc.h
@@ -1,225 +1 @@
-/*
- * bbc.h: Defines for BootBus Controller found on UltraSPARC-III
- *        systems.
- *
- * Copyright (C) 2000 David S. Miller (davem@redhat.com)
- */
-
-#ifndef _SPARC64_BBC_H
-#define _SPARC64_BBC_H
-
-/* Register sizes are indicated by "B" (Byte, 1-byte),
- * "H" (Half-word, 2 bytes), "W" (Word, 4 bytes) or
- * "Q" (Quad, 8 bytes) inside brackets.
- */
-
-#define BBC_AID		0x00	/* [B] Agent ID			*/
-#define BBC_DEVP	0x01	/* [B] Device Present		*/
-#define BBC_ARB		0x02	/* [B] Arbitration		*/
-#define BBC_QUIESCE	0x03	/* [B] Quiesce			*/
-#define BBC_WDACTION	0x04	/* [B] Watchdog Action		*/
-#define BBC_SPG		0x06	/* [B] Soft POR Gen		*/
-#define BBC_SXG		0x07	/* [B] Soft XIR Gen		*/
-#define BBC_PSRC	0x08	/* [W] POR Source		*/
-#define BBC_XSRC	0x0c	/* [B] XIR Source		*/
-#define BBC_CSC		0x0d	/* [B] Clock Synthesizers Control*/
-#define BBC_ES_CTRL	0x0e	/* [H] Energy Star Control	*/
-#define BBC_ES_ACT	0x10	/* [W] E* Assert Change Time	*/
-#define BBC_ES_DACT	0x14	/* [B] E* De-Assert Change Time	*/
-#define BBC_ES_DABT	0x15	/* [B] E* De-Assert Bypass Time	*/
-#define BBC_ES_ABT	0x16	/* [H] E* Assert Bypass Time	*/
-#define BBC_ES_PST	0x18	/* [W] E* PLL Settle Time	*/
-#define BBC_ES_FSL	0x1c	/* [W] E* Frequency Switch Latency*/
-#define BBC_EBUST	0x20	/* [Q] EBUS Timing		*/
-#define BBC_JTAG_CMD	0x28	/* [W] JTAG+ Command		*/
-#define BBC_JTAG_CTRL	0x2c	/* [B] JTAG+ Control		*/
-#define BBC_I2C_SEL	0x2d	/* [B] I2C Selection		*/
-#define BBC_I2C_0_S1	0x2e	/* [B] I2C ctrlr-0 reg S1	*/
-#define BBC_I2C_0_S0	0x2f	/* [B] I2C ctrlr-0 regs S0,S0',S2,S3*/
-#define BBC_I2C_1_S1	0x30	/* [B] I2C ctrlr-1 reg S1	*/
-#define BBC_I2C_1_S0	0x31	/* [B] I2C ctrlr-1 regs S0,S0',S2,S3*/
-#define BBC_KBD_BEEP	0x32	/* [B] Keyboard Beep		*/
-#define BBC_KBD_BCNT	0x34	/* [W] Keyboard Beep Counter	*/
-
-#define BBC_REGS_SIZE	0x40
-
-/* There is a 2K scratch ram area at offset 0x80000 but I doubt
- * we will use it for anything.
- */
-
-/* Agent ID register.  This register shows the Safari Agent ID
- * for the processors.  The value returned depends upon which
- * cpu is reading the register.
- */
-#define BBC_AID_ID	0x07	/* Safari ID		*/
-#define BBC_AID_RESV	0xf8	/* Reserved		*/
-
-/* Device Present register.  One can determine which cpus are actually
- * present in the machine by interrogating this register.
- */
-#define BBC_DEVP_CPU0	0x01	/* Processor 0 present	*/
-#define BBC_DEVP_CPU1	0x02	/* Processor 1 present	*/
-#define BBC_DEVP_CPU2	0x04	/* Processor 2 present	*/
-#define BBC_DEVP_CPU3	0x08	/* Processor 3 present	*/
-#define BBC_DEVP_RESV	0xf0	/* Reserved		*/
-
-/* Arbitration register.  This register is used to block access to
- * the BBC from a particular cpu.
- */
-#define BBC_ARB_CPU0	0x01	/* Enable cpu 0 BBC arbitratrion */
-#define BBC_ARB_CPU1	0x02	/* Enable cpu 1 BBC arbitratrion */
-#define BBC_ARB_CPU2	0x04	/* Enable cpu 2 BBC arbitratrion */
-#define BBC_ARB_CPU3	0x08	/* Enable cpu 3 BBC arbitratrion */
-#define BBC_ARB_RESV	0xf0	/* Reserved			 */
-
-/* Quiesce register.  Bus and BBC segments for cpus can be disabled
- * with this register, ie. for hot plugging.
- */
-#define BBC_QUIESCE_S02	0x01	/* Quiesce Safari segment for cpu 0 and 2 */
-#define BBC_QUIESCE_S13	0x02	/* Quiesce Safari segment for cpu 1 and 3 */
-#define BBC_QUIESCE_B02	0x04	/* Quiesce BBC segment for cpu 0 and 2    */
-#define BBC_QUIESCE_B13	0x08	/* Quiesce BBC segment for cpu 1 and 3    */
-#define BBC_QUIESCE_FD0 0x10	/* Disable Fatal_Error[0] reporting	  */
-#define BBC_QUIESCE_FD1 0x20	/* Disable Fatal_Error[1] reporting	  */
-#define BBC_QUIESCE_FD2 0x40	/* Disable Fatal_Error[2] reporting	  */
-#define BBC_QUIESCE_FD3 0x80	/* Disable Fatal_Error[3] reporting	  */
-
-/* Watchdog Action register.  When the watchdog device timer expires
- * a line is enabled to the BBC.  The action BBC takes when this line
- * is asserted can be controlled by this regiser.
- */
-#define BBC_WDACTION_RST  0x01	/* When set, watchdog causes system reset.
-				 * When clear, BBC ignores watchdog signal.
-				 */
-#define BBC_WDACTION_RESV 0xfe	/* Reserved */
-
-/* Soft_POR_GEN register.  The POR (Power On Reset) signal may be asserted
- * for specific processors or all processors via this register.
- */
-#define BBC_SPG_CPU0	0x01 /* Assert POR for processor 0	*/
-#define BBC_SPG_CPU1	0x02 /* Assert POR for processor 1	*/
-#define BBC_SPG_CPU2	0x04 /* Assert POR for processor 2	*/
-#define BBC_SPG_CPU3	0x08 /* Assert POR for processor 3	*/
-#define BBC_SPG_CPUALL	0x10 /* Reset all processors and reset
-			      * the entire system.
-			      */
-#define BBC_SPG_RESV	0xe0 /* Reserved			*/
-
-/* Soft_XIR_GEN register.  The XIR (eXternally Initiated Reset) signal
- * may be asserted to specific processors via this register.
- */
-#define BBC_SXG_CPU0	0x01 /* Assert XIR for processor 0	*/
-#define BBC_SXG_CPU1	0x02 /* Assert XIR for processor 1	*/
-#define BBC_SXG_CPU2	0x04 /* Assert XIR for processor 2	*/
-#define BBC_SXG_CPU3	0x08 /* Assert XIR for processor 3	*/
-#define BBC_SXG_RESV	0xf0 /* Reserved			*/
-
-/* POR Source register.  One may identify the cause of the most recent
- * reset by reading this register.
- */
-#define BBC_PSRC_SPG0	0x0001 /* CPU 0 reset via BBC_SPG register	*/
-#define BBC_PSRC_SPG1	0x0002 /* CPU 1 reset via BBC_SPG register	*/
-#define BBC_PSRC_SPG2	0x0004 /* CPU 2 reset via BBC_SPG register	*/
-#define BBC_PSRC_SPG3	0x0008 /* CPU 3 reset via BBC_SPG register	*/
-#define BBC_PSRC_SPGSYS	0x0010 /* System reset via BBC_SPG register	*/
-#define BBC_PSRC_JTAG	0x0020 /* System reset via JTAG+		*/
-#define BBC_PSRC_BUTTON	0x0040 /* System reset via push-button dongle	*/
-#define BBC_PSRC_PWRUP	0x0080 /* System reset via power-up		*/
-#define BBC_PSRC_FE0	0x0100 /* CPU 0 reported Fatal_Error		*/
-#define BBC_PSRC_FE1	0x0200 /* CPU 1 reported Fatal_Error		*/
-#define BBC_PSRC_FE2	0x0400 /* CPU 2 reported Fatal_Error		*/
-#define BBC_PSRC_FE3	0x0800 /* CPU 3 reported Fatal_Error		*/
-#define BBC_PSRC_FE4	0x1000 /* Schizo reported Fatal_Error		*/
-#define BBC_PSRC_FE5	0x2000 /* Safari device 5 reported Fatal_Error	*/
-#define BBC_PSRC_FE6	0x4000 /* CPMS reported Fatal_Error		*/
-#define BBC_PSRC_SYNTH	0x8000 /* System reset when on-board clock synthesi=
zers
-				* were updated.
-				*/
-#define BBC_PSRC_WDT   0x10000 /* System reset via Super I/O watchdog	*/
-#define BBC_PSRC_RSC   0x20000 /* System reset via RSC remote monitoring
-				* device
-				*/
-
-/* XIR Source register.  The source of an XIR event sent to a processor may
- * be determined via this register.
- */
-#define BBC_XSRC_SXG0	0x01	/* CPU 0 received XIR via Soft_XIR_GEN reg */
-#define BBC_XSRC_SXG1	0x02	/* CPU 1 received XIR via Soft_XIR_GEN reg */
-#define BBC_XSRC_SXG2	0x04	/* CPU 2 received XIR via Soft_XIR_GEN reg */
-#define BBC_XSRC_SXG3	0x08	/* CPU 3 received XIR via Soft_XIR_GEN reg */
-#define BBC_XSRC_JTAG	0x10	/* All CPUs received XIR via JTAG+         */
-#define BBC_XSRC_W_OR_B	0x20	/* All CPUs received XIR either because:
-				 * a) Super I/O watchdog fired, or
-				 * b) XIR push button was activated
-				 */
-#define BBC_XSRC_RESV	0xc0	/* Reserved				   */
-
-/* Clock Synthesizers Control register.  This register provides the big-ba=
ng
- * programming interface to the two clock synthesizers of the machine.
- */
-#define BBC_CSC_SLOAD	0x01	/* Directly connected to S_LOAD pins	*/
-#define BBC_CSC_SDATA	0x02	/* Directly connected to S_DATA pins	*/
-#define BBC_CSC_SCLOCK	0x04	/* Directly connected to S_CLOCK pins	*/
-#define BBC_CSC_RESV	0x78	/* Reserved				*/
-#define BBC_CSC_RST	0x80	/* Generate system reset when S_LOAD=3D1	*/
-
-/* Energy Star Control register.  This register is used to generate the
- * clock frequency change trigger to the main system devices (Schizo and
- * the processors).  The transition occurs when bits in this register
- * go from 0 to 1, only one bit must be set at once else no action
- * occurs.  Basically the sequence of events is:
- * a) Choose new frequency: full, 1/2 or 1/32
- * b) Program this desired frequency into the cpus and Schizo.
- * c) Set the same value in this register.
- * d) 16 system clocks later, clear this register.
- */
-#define BBC_ES_CTRL_1_1		0x01	/* Full frequency	*/
-#define BBC_ES_CTRL_1_2		0x02	/* 1/2 frequency	*/
-#define BBC_ES_CTRL_1_32	0x20	/* 1/32 frequency	*/
-#define BBC_ES_RESV		0xdc	/* Reserved		*/
-
-/* Energy Star Assert Change Time register.  This determines the number
- * of BBC clock cycles (which is half the system frequency) between
- * the detection of FREEZE_ACK being asserted and the assertion of
- * the CLK_CHANGE_L[2:0] signals.
- */
-#define BBC_ES_ACT_VAL	0xff
-
-/* Energy Star Assert Bypass Time register.  This determines the number
- * of BBC clock cycles (which is half the system frequency) between
- * the assertion of the CLK_CHANGE_L[2:0] signals and the assertion of
- * the ESTAR_PLL_BYPASS signal.
- */
-#define BBC_ES_ABT_VAL	0xffff
-
-/* Energy Star PLL Settle Time register.  This determines the number of
- * BBC clock cycles (which is half the system frequency) between the
- * de-assertion of CLK_CHANGE_L[2:0] and the de-assertion of the FREEZE_L
- * signal.
- */
-#define BBC_ES_PST_VAL	0xffffffff
-
-/* Energy Star Frequency Switch Latency register.  This is the number of
- * BBC clocks between the de-assertion of CLK_CHANGE_L[2:0] and the first
- * edge of the Safari clock at the new frequency.
- */
-#define BBC_ES_FSL_VAL	0xffffffff
-
-/* Keyboard Beep control register.  This is a simple enabler for the audio
- * beep sound.
- */
-#define BBC_KBD_BEEP_ENABLE	0x01 /* Enable beep	*/
-#define BBC_KBD_BEEP_RESV	0xfe /* Reserved	*/
-
-/* Keyboard Beep Counter register.  There is a free-running counter inside
- * the BBC which runs at half the system clock.  The bit set in this regis=
ter
- * determines when the audio sound is generated.  So for example if bit
- * 10 is set, the audio beep will oscillate at 1/(2**12).  The keyboard be=
ep
- * generator automatically selects a different bit to use if the system cl=
ock
- * is changed via Energy Star.
- */
-#define BBC_KBD_BCNT_BITS	0x0007fc00
-#define BBC_KBC_BCNT_RESV	0xfff803ff
-
-#endif /* _SPARC64_BBC_H */
-
+#include <asm-sparc/bbc.h>
diff --git a/include/asm-sparc64/display7seg.h b/include/asm-sparc64/displa=
y7seg.h
index c066a89..e74f046 100644
--- a/include/asm-sparc64/display7seg.h
+++ b/include/asm-sparc64/display7seg.h
@@ -1,79 +1 @@
-/*
- *
- * display7seg - Driver interface for the 7-segment display
- * present on Sun Microsystems CP1400 and CP1500
- *
- * Copyright (c) 2000 Eric Brower <ebrower@usa.net>
- *
- */
-
-#ifndef __display7seg_h__
-#define __display7seg_h__
-
-#define D7S_IOC	'p'
-
-#define D7SIOCRD _IOR(D7S_IOC, 0x45, int)	/* Read device state	*/
-#define D7SIOCWR _IOW(D7S_IOC, 0x46, int)	/* Write device state	*/
-#define D7SIOCTM _IO (D7S_IOC, 0x47)		/* Translate mode (FLIP)*/
-
-/*
- * ioctl flag definitions
- *
- * POINT	- Toggle decimal point	(0=ABsent 1=3Dpresent)
- * ALARM	- Toggle alarm LED 		(0=3Dgreen  1=3Dred)
- * FLIP		- Toggle inverted mode 	(0=3Dnormal 1=3Dflipped)=20
- * bits 0-4	- Character displayed	(see definitions below)
- *
- * Display segments are defined as follows,=20
- * subject to D7S_FLIP register state:
- *
- *    a
- *   ---
- * f|   |b
- *   -g-
- * e|   |c
- *   ---
- *    d
- */
-
-#define D7S_POINT	(1 << 7)	/* Decimal point*/
-#define D7S_ALARM	(1 << 6)	/* Alarm LED 	*/
-#define D7S_FLIP	(1 << 5)	/* Flip display */
-
-#define D7S_0		0x00		/* Numerals 0-9 */
-#define D7S_1		0x01
-#define D7S_2		0x02
-#define D7S_3		0x03
-#define D7S_4		0x04
-#define D7S_5		0x05
-#define D7S_6		0x06
-#define D7S_7		0x07
-#define D7S_8		0x08
-#define D7S_9		0x09
-#define D7S_A		0x0A		/* Letters A-F, H, L, P */
-#define D7S_B		0x0B
-#define D7S_C		0x0C
-#define D7S_D		0x0D
-#define D7S_E		0x0E
-#define D7S_F		0x0F
-#define D7S_H		0x10
-#define D7S_E2		0x11
-#define D7S_L		0x12
-#define D7S_P		0x13
-#define D7S_SEGA	0x14		/* Individual segments */
-#define D7S_SEGB	0x15
-#define D7S_SEGC	0x16
-#define D7S_SEGD	0x17
-#define D7S_SEGE	0x18
-#define D7S_SEGF	0x19
-#define D7S_SEGG	0x1A
-#define D7S_SEGABFG 0x1B		/* Segment groupings */
-#define D7S_SEGCDEG	0x1C
-#define D7S_SEGBCEF 0x1D
-#define D7S_SEGADG	0x1E
-#define D7S_BLANK	0x1F		/* Clear all segments */
-
-#define D7S_MIN_VAL	0x0
-#define D7S_MAX_VAL	0x1F
-
-#endif /* ifndef __display7seg_h__ */
+#include <asm-sparc/display7seg.h>
diff --git a/include/asm-sparc64/envctrl.h b/include/asm-sparc64/envctrl.h
index a5668a0..a2cc0ca 100644
--- a/include/asm-sparc64/envctrl.h
+++ b/include/asm-sparc64/envctrl.h
@@ -1,103 +1 @@
-/*
- *
- * envctrl.h: Definitions for access to the i2c environment
- *            monitoring on Ultrasparc systems.
- *
- * Copyright (C) 1998  Eddie C. Dost  (ecd@skynet.be)
- * Copyright (C) 2000  Vinh Truong  (vinh.truong@eng.sun.com)
- * VT - Add all ioctl commands and environment status definitions=20
- * VT - Add application note=20
- */
-#ifndef _SPARC64_ENVCTRL_H
-#define _SPARC64_ENVCTRL_H 1
-
-#include <linux/ioctl.h>
-
-/* Application note:
- *
- * The driver supports 4 operations: open(), close(), ioctl(), read()
- * The device name is /dev/envctrl.
- * Below is sample usage:
- *
- *	fd =3D open("/dev/envtrl", O_RDONLY);
- *	if (ioctl(fd, ENVCTRL_READ_SHUTDOWN_TEMPERATURE, 0) < 0)
- *		printf("error\n");
- *	ret =3D read(fd, buf, 10);
- *	close(fd);
- *
- * Notice in the case of cpu voltage and temperature, the default is
- * cpu0.  If we need to know the info of cpu1, cpu2, cpu3, we need to
- * pass in cpu number in ioctl() last parameter.  For example, to
- * get the voltage of cpu2:
- *
- *	ioctlbuf[0] =3D 2;
- *	if (ioctl(fd, ENVCTRL_READ_CPU_VOLTAGE, ioctlbuf) < 0)
- *		printf("error\n");
- *	ret =3D read(fd, buf, 10);
- *
- * All the return values are in ascii.  So check read return value
- * and do appropriate conversions in your application.
- */
-
-/* IOCTL commands */
-
-/* Note: these commands reflect possible monitor features.
- * Some boards choose to support some of the features only.
- */
-#define ENVCTRL_RD_CPU_TEMPERATURE	_IOR('p', 0x40, int)
-#define ENVCTRL_RD_CPU_VOLTAGE		_IOR('p', 0x41, int)
-#define ENVCTRL_RD_FAN_STATUS		_IOR('p', 0x42, int)
-#define ENVCTRL_RD_WARNING_TEMPERATURE	_IOR('p', 0x43, int)
-#define ENVCTRL_RD_SHUTDOWN_TEMPERATURE	_IOR('p', 0x44, int)
-#define ENVCTRL_RD_VOLTAGE_STATUS	_IOR('p', 0x45, int)
-#define ENVCTRL_RD_SCSI_TEMPERATURE	_IOR('p', 0x46, int)
-#define ENVCTRL_RD_ETHERNET_TEMPERATURE	_IOR('p', 0x47, int)
-#define ENVCTRL_RD_MTHRBD_TEMPERATURE	_IOR('p', 0x48, int)
-
-#define ENVCTRL_RD_GLOBALADDRESS	_IOR('p', 0x49, int)
-
-/* Read return values for a voltage status request. */
-#define ENVCTRL_VOLTAGE_POWERSUPPLY_GOOD	0x01
-#define ENVCTRL_VOLTAGE_BAD			0x02
-#define ENVCTRL_POWERSUPPLY_BAD			0x03
-#define ENVCTRL_VOLTAGE_POWERSUPPLY_BAD		0x04
-
-/* Read return values for a fan status request.
- * A failure match means either the fan fails or
- * the fan is not connected.  Some boards have optional
- * connectors to connect extra fans.
- *
- * There are maximum 8 monitor fans.  Some are cpu fans
- * some are system fans.  The mask below only indicates
- * fan by order number.
- * Below is a sample application:
- *
- *	if (ioctl(fd, ENVCTRL_READ_FAN_STATUS, 0) < 0) {
- *		printf("ioctl fan failed\n");
- *	}
- *	if (read(fd, rslt, 1) <=3D 0) {
- *		printf("error or fan not monitored\n");
- *	} else {
- *		if (rslt[0] =3D ENVCTRL_ALL_FANS_GOOD) {
- *			printf("all fans good\n");
- *	} else if (rslt[0] =3D ENVCTRL_ALL_FANS_BAD) {
- *		printf("all fans bad\n");
- *	} else {
- *		if (rslt[0] & ENVCTRL_FAN0_FAILURE_MASK) {
- *			printf("fan 0 failed or not connected\n");
- *	}
- *	......
- */ =20
-
-#define ENVCTRL_ALL_FANS_GOOD			0x00
-#define ENVCTRL_FAN0_FAILURE_MASK		0x01
-#define ENVCTRL_FAN1_FAILURE_MASK		0x02
-#define ENVCTRL_FAN2_FAILURE_MASK		0x04
-#define ENVCTRL_FAN3_FAILURE_MASK		0x08
-#define ENVCTRL_FAN4_FAILURE_MASK		0x10
-#define ENVCTRL_FAN5_FAILURE_MASK		0x20
-#define ENVCTRL_FAN6_FAILURE_MASK		0x40
-#define ENVCTRL_FAN7_FAILURE_MASK		0x80
-#define ENVCTRL_ALL_FANS_BAD 			0xFF
-
-#endif /* !(_SPARC64_ENVCTRL_H) */
+#include <asm-sparc/envctrl.h>
diff --git a/include/asm-sparc64/psrcompat.h b/include/asm-sparc64/psrcompa=
t.h
index 44b6327..587846f 100644
--- a/include/asm-sparc64/psrcompat.h
+++ b/include/asm-sparc64/psrcompat.h
@@ -1,45 +1 @@
-#ifndef _SPARC64_PSRCOMPAT_H
-#define _SPARC64_PSRCOMPAT_H
-
-#include <asm/pstate.h>
-
-/* Old 32-bit PSR fields for the compatibility conversion code. */
-#define PSR_CWP     0x0000001f         /* current window pointer     */
-#define PSR_ET      0x00000020         /* enable traps field         */
-#define PSR_PS      0x00000040         /* previous privilege level   */
-#define PSR_S       0x00000080         /* current privilege level    */
-#define PSR_PIL     0x00000f00         /* processor interrupt level  */
-#define PSR_EF      0x00001000         /* enable floating point      */
-#define PSR_EC      0x00002000         /* enable co-processor        */
-#define PSR_SYSCALL 0x00004000         /* inside of a syscall        */
-#define PSR_LE      0x00008000         /* SuperSparcII little-endian */
-#define PSR_ICC     0x00f00000         /* integer condition codes    */
-#define PSR_C       0x00100000         /* carry bit                  */
-#define PSR_V       0x00200000         /* overflow bit               */
-#define PSR_Z       0x00400000         /* zero bit                   */
-#define PSR_N       0x00800000         /* negative bit               */
-#define PSR_VERS    0x0f000000         /* cpu-version field          */
-#define PSR_IMPL    0xf0000000         /* cpu-implementation field   */
-
-#define PSR_V8PLUS  0xff000000         /* fake impl/ver, meaning a 64bit C=
PU is present */
-#define PSR_XCC	    0x000f0000         /* if PSR_V8PLUS, this is %xcc */
-
-static inline unsigned int tstate_to_psr(unsigned long tstate)
-{
-	return ((tstate & TSTATE_CWP)			|
-		PSR_S					|
-		((tstate & TSTATE_ICC) >> 12)		|
-		((tstate & TSTATE_XCC) >> 20)		|
-		((tstate & TSTATE_SYSCALL) ? PSR_SYSCALL : 0) |
-		PSR_V8PLUS);
-}
-
-static inline unsigned long psr_to_tstate_icc(unsigned int psr)
-{
-	unsigned long tstate =3D ((unsigned long)(psr & PSR_ICC)) << 12;
-	if ((psr & (PSR_VERS|PSR_IMPL)) =3D PSR_V8PLUS)
-		tstate |=3D ((unsigned long)(psr & PSR_XCC)) << 20;
-	return tstate;
-}
-
-#endif /* !(_SPARC64_PSRCOMPAT_H) */
+#include <asm-sparc/psrcompat.h>
diff --git a/include/asm-sparc64/pstate.h b/include/asm-sparc64/pstate.h
index a26a537..3ccf0be 100644
--- a/include/asm-sparc64/pstate.h
+++ b/include/asm-sparc64/pstate.h
@@ -1,91 +1 @@
-#ifndef _SPARC64_PSTATE_H
-#define _SPARC64_PSTATE_H
-
-#include <linux/const.h>
-
-/* The V9 PSTATE Register (with SpitFire extensions).
- *
- * -----------------------------------------------------------------------
- * | Resv | IG | MG | CLE | TLE |  MM  | RED | PEF | AM | PRIV | IE | AG |
- * -----------------------------------------------------------------------
- *  63  12  11   10    9     8    7   6   5     4     3     2     1    0
- */
-#define PSTATE_IG   _AC(0x0000000000000800,UL) /* Interrupt Globals.	*/
-#define PSTATE_MG   _AC(0x0000000000000400,UL) /* MMU Globals.		*/
-#define PSTATE_CLE  _AC(0x0000000000000200,UL) /* Current Little Endian.*/
-#define PSTATE_TLE  _AC(0x0000000000000100,UL) /* Trap Little Endian.	*/
-#define PSTATE_MM   _AC(0x00000000000000c0,UL) /* Memory Model.		*/
-#define PSTATE_TSO  _AC(0x0000000000000000,UL) /* MM: TotalStoreOrder	*/
-#define PSTATE_PSO  _AC(0x0000000000000040,UL) /* MM: PartialStoreOrder	*/
-#define PSTATE_RMO  _AC(0x0000000000000080,UL) /* MM: RelaxedMemoryOrder*/
-#define PSTATE_RED  _AC(0x0000000000000020,UL) /* Reset Error Debug.	*/
-#define PSTATE_PEF  _AC(0x0000000000000010,UL) /* Floating Point Enable.*/
-#define PSTATE_AM   _AC(0x0000000000000008,UL) /* Address Mask.		*/
-#define PSTATE_PRIV _AC(0x0000000000000004,UL) /* Privilege.		*/
-#define PSTATE_IE   _AC(0x0000000000000002,UL) /* Interrupt Enable.	*/
-#define PSTATE_AG   _AC(0x0000000000000001,UL) /* Alternate Globals.	*/
-
-/* The V9 TSTATE Register (with SpitFire and Linux extensions).
- *
- * ---------------------------------------------------------------------
- * |  Resv |  GL  |  CCR  |  ASI  |  %pil  |  PSTATE  |  Resv  |  CWP  |
- * ---------------------------------------------------------------------
- *  63   43 42  40 39   32 31   24 23    20 19       8 7      5 4     0
- */
-#define TSTATE_GL	_AC(0x0000070000000000,UL) /* Global reg level  */
-#define TSTATE_CCR	_AC(0x000000ff00000000,UL) /* Condition Codes.	*/
-#define TSTATE_XCC	_AC(0x000000f000000000,UL) /* Condition Codes.	*/
-#define TSTATE_XNEG	_AC(0x0000008000000000,UL) /* %xcc Negative.	*/
-#define TSTATE_XZERO	_AC(0x0000004000000000,UL) /* %xcc Zero.	*/
-#define TSTATE_XOVFL	_AC(0x0000002000000000,UL) /* %xcc Overflow.	*/
-#define TSTATE_XCARRY	_AC(0x0000001000000000,UL) /* %xcc Carry.	*/
-#define TSTATE_ICC	_AC(0x0000000f00000000,UL) /* Condition Codes.	*/
-#define TSTATE_INEG	_AC(0x0000000800000000,UL) /* %icc Negative.	*/
-#define TSTATE_IZERO	_AC(0x0000000400000000,UL) /* %icc Zero.	*/
-#define TSTATE_IOVFL	_AC(0x0000000200000000,UL) /* %icc Overflow.	*/
-#define TSTATE_ICARRY	_AC(0x0000000100000000,UL) /* %icc Carry.	*/
-#define TSTATE_ASI	_AC(0x00000000ff000000,UL) /* AddrSpace ID.	*/
-#define TSTATE_PIL	_AC(0x0000000000f00000,UL) /* %pil (Linux traps)*/
-#define TSTATE_PSTATE	_AC(0x00000000000fff00,UL) /* PSTATE.		*/
-#define TSTATE_IG	_AC(0x0000000000080000,UL) /* Interrupt Globals.*/
-#define TSTATE_MG	_AC(0x0000000000040000,UL) /* MMU Globals.	*/
-#define TSTATE_CLE	_AC(0x0000000000020000,UL) /* CurrLittleEndian.	*/
-#define TSTATE_TLE	_AC(0x0000000000010000,UL) /* TrapLittleEndian.	*/
-#define TSTATE_MM	_AC(0x000000000000c000,UL) /* Memory Model.	*/
-#define TSTATE_TSO	_AC(0x0000000000000000,UL) /* MM: TSO		*/
-#define TSTATE_PSO	_AC(0x0000000000004000,UL) /* MM: PSO		*/
-#define TSTATE_RMO	_AC(0x0000000000008000,UL) /* MM: RMO		*/
-#define TSTATE_RED	_AC(0x0000000000002000,UL) /* Reset Error Debug.*/
-#define TSTATE_PEF	_AC(0x0000000000001000,UL) /* FPU Enable.	*/
-#define TSTATE_AM	_AC(0x0000000000000800,UL) /* Address Mask.	*/
-#define TSTATE_PRIV	_AC(0x0000000000000400,UL) /* Privilege.	*/
-#define TSTATE_IE	_AC(0x0000000000000200,UL) /* Interrupt Enable.	*/
-#define TSTATE_AG	_AC(0x0000000000000100,UL) /* Alternate Globals.*/
-#define TSTATE_SYSCALL	_AC(0x0000000000000020,UL) /* in syscall trap   */
-#define TSTATE_CWP	_AC(0x000000000000001f,UL) /* Curr Win-Pointer.	*/
-
-/* Floating-Point Registers State Register.
- *
- * --------------------------------
- * |  Resv  |  FEF  |  DU  |  DL  |
- * --------------------------------
- *  63     3    2       1      0
- */
-#define FPRS_FEF	_AC(0x0000000000000004,UL) /* FPU Enable.	*/
-#define FPRS_DU		_AC(0x0000000000000002,UL) /* Dirty Upper.	*/
-#define FPRS_DL		_AC(0x0000000000000001,UL) /* Dirty Lower.	*/
-
-/* Version Register.
- *
- * ------------------------------------------------------
- * | MANUF | IMPL | MASK | Resv | MAXTL | Resv | MAXWIN |
- * ------------------------------------------------------
- *  63   48 47  32 31  24 23  16 15    8 7    5 4      0
- */
-#define VERS_MANUF	_AC(0xffff000000000000,UL) /* Manufacturer.	*/
-#define VERS_IMPL	_AC(0x0000ffff00000000,UL) /* Implementation.	*/
-#define VERS_MASK	_AC(0x00000000ff000000,UL) /* Mask Set Revision.*/
-#define VERS_MAXTL	_AC(0x000000000000ff00,UL) /* Max Trap Level.	*/
-#define VERS_MAXWIN	_AC(0x000000000000001f,UL) /* Max RegWindow Idx.*/
-
-#endif /* !(_SPARC64_PSTATE_H) */
+#include <asm-sparc/pstate.h>
diff --git a/include/asm-sparc64/uctx.h b/include/asm-sparc64/uctx.h
index dc937c7..9e1b579 100644
--- a/include/asm-sparc64/uctx.h
+++ b/include/asm-sparc64/uctx.h
@@ -1,71 +1 @@
-/*
- * uctx.h: Sparc64 {set,get}context() register state layouts.
- *
- * Copyright (C) 1997 David S. Miller (davem@caip.rutgers.edu)
- */
-
-#ifndef __SPARC64_UCTX_H
-#define __SPARC64_UCTX_H
-
-#define MC_TSTATE	0
-#define MC_PC		1
-#define MC_NPC		2
-#define MC_Y		3
-#define MC_G1		4
-#define MC_G2		5
-#define MC_G3		6
-#define MC_G4		7
-#define MC_G5		8
-#define MC_G6		9
-#define MC_G7		10
-#define MC_O0		11
-#define MC_O1		12
-#define MC_O2		13
-#define MC_O3		14
-#define MC_O4		15
-#define MC_O5		16
-#define MC_O6		17
-#define MC_O7		18
-#define MC_NGREG	19
-
-typedef unsigned long mc_greg_t;
-typedef mc_greg_t mc_gregset_t[MC_NGREG];
-
-#define MC_MAXFPQ	16
-struct mc_fq {
-	unsigned long	*mcfq_addr;
-	unsigned int	mcfq_insn;
-};
-
-struct mc_fpu {
-	union {
-		unsigned int	sregs[32];
-		unsigned long	dregs[32];
-		long double	qregs[16];
-	} mcfpu_fregs;
-	unsigned long	mcfpu_fsr;
-	unsigned long	mcfpu_fprs;
-	unsigned long	mcfpu_gsr;
-	struct mc_fq	*mcfpu_fq;
-	unsigned char	mcfpu_qcnt;
-	unsigned char	mcfpu_qentsz;
-	unsigned char	mcfpu_enab;
-};
-typedef struct mc_fpu mc_fpu_t;
-
-typedef struct {
-	mc_gregset_t	mc_gregs;
-	mc_greg_t	mc_fp;
-	mc_greg_t	mc_i7;
-	mc_fpu_t	mc_fpregs;
-} mcontext_t;
-
-struct ucontext {
-	struct ucontext		*uc_link;
-	unsigned long		uc_flags;
-	sigset_t		uc_sigmask;
-	mcontext_t		uc_mcontext;
-};
-typedef struct ucontext ucontext_t;
-
-#endif /* __SPARC64_UCTX_H */
+#include <asm-sparc/uctx.h>
diff --git a/include/asm-sparc64/utrap.h b/include/asm-sparc64/utrap.h
index e49e5c4..b030a41 100644
--- a/include/asm-sparc64/utrap.h
+++ b/include/asm-sparc64/utrap.h
@@ -1,51 +1 @@
-/*
- * include/asm-sparc64/utrap.h
- *
- * Copyright (C) 1997 Jakub Jelinek (jj@sunsite.mff.cuni.cz)
- */
-
-#ifndef __ASM_SPARC64_UTRAP_H
-#define __ASM_SPARC64_UTRAP_H
-
-#define UT_INSTRUCTION_EXCEPTION		1
-#define UT_INSTRUCTION_ERROR			2
-#define UT_INSTRUCTION_PROTECTION		3
-#define UT_ILLTRAP_INSTRUCTION			4
-#define UT_ILLEGAL_INSTRUCTION			5
-#define UT_PRIVILEGED_OPCODE			6
-#define UT_FP_DISABLED				7
-#define UT_FP_EXCEPTION_IEEE_754		8
-#define UT_FP_EXCEPTION_OTHER			9
-#define UT_TAG_OVERVIEW				10
-#define UT_DIVISION_BY_ZERO			11
-#define UT_DATA_EXCEPTION			12
-#define UT_DATA_ERROR				13
-#define UT_DATA_PROTECTION			14
-#define UT_MEM_ADDRESS_NOT_ALIGNED		15
-#define UT_PRIVILEGED_ACTION			16
-#define UT_ASYNC_DATA_ERROR			17
-#define UT_TRAP_INSTRUCTION_16			18
-#define UT_TRAP_INSTRUCTION_17			19
-#define UT_TRAP_INSTRUCTION_18			20
-#define UT_TRAP_INSTRUCTION_19			21
-#define UT_TRAP_INSTRUCTION_20			22
-#define UT_TRAP_INSTRUCTION_21			23
-#define UT_TRAP_INSTRUCTION_22			24
-#define UT_TRAP_INSTRUCTION_23			25
-#define UT_TRAP_INSTRUCTION_24			26
-#define UT_TRAP_INSTRUCTION_25			27
-#define UT_TRAP_INSTRUCTION_26			28
-#define UT_TRAP_INSTRUCTION_27			29
-#define UT_TRAP_INSTRUCTION_28			30
-#define UT_TRAP_INSTRUCTION_29			31
-#define UT_TRAP_INSTRUCTION_30			32
-#define UT_TRAP_INSTRUCTION_31			33
-
-#define	UTH_NOCHANGE				(-1)
-
-#ifndef __ASSEMBLY__=20
-typedef int utrap_entry_t;
-typedef void *utrap_handler_t;
-#endif /* __ASSEMBLY__ */
-
-#endif /* !(__ASM_SPARC64_PROCESSOR_H) */
+#include <asm-sparc/utrap.h>
diff --git a/include/asm-sparc64/watchdog.h b/include/asm-sparc64/watchdog.h
index 5baf2d3..b0f2857 100644
--- a/include/asm-sparc64/watchdog.h
+++ b/include/asm-sparc64/watchdog.h
@@ -1,31 +1 @@
-/*
- *
- * watchdog - Driver interface for the hardware watchdog timers
- * present on Sun Microsystems boardsets
- *
- * Copyright (c) 2000 Eric Brower <ebrower@usa.net>
- *
- */
-
-#ifndef _SPARC64_WATCHDOG_H
-#define _SPARC64_WATCHDOG_H
-
-#include <linux/watchdog.h>
-
-/* Solaris compatibility ioctls--
- * Ref. <linux/watchdog.h> for standard linux watchdog ioctls
- */
-#define WIOCSTART _IO (WATCHDOG_IOCTL_BASE, 10)		/* Start Timer		*/
-#define WIOCSTOP  _IO (WATCHDOG_IOCTL_BASE, 11)		/* Stop Timer		*/
-#define WIOCGSTAT _IOR(WATCHDOG_IOCTL_BASE, 12, int)/* Get Timer Status	*/
-
-/* Status flags from WIOCGSTAT ioctl
- */
-#define WD_FREERUN	0x01	/* timer is running, interrupts disabled	*/
-#define WD_EXPIRED	0x02	/* timer has expired						*/
-#define WD_RUNNING	0x04	/* timer is running, interrupts enabled		*/
-#define WD_STOPPED	0x08	/* timer has not been started				*/
-#define WD_SERVICED 0x10	/* timer interrupt was serviced				*/
-
-#endif /* ifndef _SPARC64_WATCHDOG_H */
-
+#include <asm-sparc/watchdog.h>
--=20
1.5.4.1.143.ge7e51

