From: David Miller <davem@davemloft.net>
Date: Fri, 19 Sep 2008 22:39:27 +0000
Subject: [PATCH 13/13]: sparc32: Add more extensive documentation of sun4m
Message-Id: <20080919.153927.22520555.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


sparc32: Add more extensive documentation of sun4m interrupts.

Signed-off-by: David S. Miller <davem@davemloft.net>
---
 arch/sparc/kernel/sun4m_irq.c |   53 +++++++++++++++++++++++++++++++++++++++++
 1 files changed, 53 insertions(+), 0 deletions(-)

diff --git a/arch/sparc/kernel/sun4m_irq.c b/arch/sparc/kernel/sun4m_irq.c
index c6096fc..ec66d4a 100644
--- a/arch/sparc/kernel/sun4m_irq.c
+++ b/arch/sparc/kernel/sun4m_irq.c
@@ -87,6 +87,59 @@ struct sun4m_irq_global __iomem *sun4m_irq_global;
 #define SUN4M_INT_SBUS(x)	(1 << (x+7))
 #define SUN4M_INT_VME(x)	(1 << (x))
 
+/* Interrupt level assignment on sun4m:
+ *
+ *	level		source
+ * ------------------------------------------------------------
+ *        1		softint-1
+ *	  2		softint-2, VME/SBUS level 1
+ *	  3		softint-3, VME/SBUS level 2
+ *	  4		softint-4, onboard SCSI
+ *	  5		softint-5, VME/SBUS level 3
+ *	  6		softint-6, onboard ETHERNET
+ *	  7		softint-7, VME/SBUS level 4
+ *	  8		softint-8, onboard VIDEO
+ *	  9		softint-9, VME/SBUS level 5, Module Interrupt
+ *	 10		softint-10, system counter/timer
+ *	 11		softint-11, VME/SBUS level 6, Floppy
+ *	 12		softint-12, Keyboard/Mouse, Serial
+ *	 13		softint-13, VME/SBUS level 7, ISDN Audio
+ *	 14		softint-14, per-processor counter/timer
+ *	 15		softint-15, Asynchronous Errors (broadcast)
+ *
+ * Each interrupt source is masked distinctly in the sun4m interrupt
+ * registers.  The PIL level alone is therefore ambiguous, since multiple
+ * interrupt sources map to a single PIL.
+ *
+ * This ambiguity is resolved in the 'intr' property for device nodes
+ * in the OF device tree.  Each 'intr' property entry is composed of
+ * two 32-bit words.  The first word is the IRQ priority value, which
+ * is what we're intersted in.  The second word is the IRQ vector, which
+ * is unused.
+ *
+ * The low 4 bits of the IRQ priority indicate the PIL, and the upper
+ * 4 bits indicate onboard vs. SBUS leveled vs. VME leveled.  0x20
+ * means onboard, 0x30 means SBUS leveled, and 0x40 means VME leveled.
+ *
+ * For example, an 'intr' IRQ priority value of 0x24 is onboard SCSI
+ * whereas a value of 0x33 is SBUS level 2.  Here are some sample
+ * 'intr' property IRQ priority values from ss4, ss5, ss10, ss20, and
+ * Tadpole S3 GX systems.
+ *
+ * esp: 	0x24	onboard ESP SCSI
+ * le:  	0x26	onboard Lance ETHERNET
+ * p9100:	0x32	SBUS level 1 P9100 video
+ * bpp:  	0x33	SBUS level 2 BPP parallel port device
+ * DBRI:	0x39	SBUS level 5 DBRI ISDN audio
+ * SUNW,leo:	0x39	SBUS level 5 LEO video
+ * pcmcia:	0x3b	SBUS level 6 PCMCIA controller
+ * uctrl:	0x3b	SBUS level 6 UCTRL device
+ * modem:	0x3d	SBUS level 7 MODEM
+ * zs:		0x2c	onboard keyboard/mouse/serial
+ * floppy:	0x2b	onboard Floppy
+ * power:	0x22	onboard power device (XXX unknown mask bit XXX)
+ */
+
 /* These tables only apply for interrupts greater than 15..
  * 
  * any intr value below 0x10 is considered to be a soft-int
-- 
1.5.6.5

