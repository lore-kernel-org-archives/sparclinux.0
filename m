From: Daniel Hellstrom <daniel@gaisler.com>
Date: Wed, 20 Apr 2011 08:39:06 +0000
Subject: [PATCH 4/7 v2] sparc32,leon: cleaned away code from the LEON2 days
Message-Id: <1303288747-28521-4-git-send-email-daniel@gaisler.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Signed-off-by: Daniel Hellstrom <daniel@gaisler.com>
Acked-by: Sam Ravnborg <sam@ravnborg.org>
---
 arch/sparc/include/asm/leon.h   |   23 -----------------------
 arch/sparc/kernel/leon_kernel.c |    2 +-
 2 files changed, 1 insertions(+), 24 deletions(-)

diff --git a/arch/sparc/include/asm/leon.h b/arch/sparc/include/asm/leon.h
index 204dc0f..31fb2ac 100644
--- a/arch/sparc/include/asm/leon.h
+++ b/arch/sparc/include/asm/leon.h
@@ -52,29 +52,6 @@
 #define LEON_DIAGF_VALID	0x2000
 #define LEON_DIAGF_VALID_SHIFT	13
 
-/*
- *  Interrupt Sources
- *
- *  The interrupt source numbers directly map to the trap type and to
- *  the bits used in the Interrupt Clear, Interrupt Force, Interrupt Mask,
- *  and the Interrupt Pending Registers.
- */
-#define LEON_INTERRUPT_CORRECTABLE_MEMORY_ERROR	1
-#define LEON_INTERRUPT_UART_1_RX_TX		2
-#define LEON_INTERRUPT_UART_0_RX_TX		3
-#define LEON_INTERRUPT_EXTERNAL_0		4
-#define LEON_INTERRUPT_EXTERNAL_1		5
-#define LEON_INTERRUPT_EXTERNAL_2		6
-#define LEON_INTERRUPT_EXTERNAL_3		7
-#define LEON_INTERRUPT_TIMER1			8
-#define LEON_INTERRUPT_TIMER2			9
-#define LEON_INTERRUPT_EMPTY1			10
-#define LEON_INTERRUPT_EMPTY2			11
-#define LEON_INTERRUPT_OPEN_ETH			12
-#define LEON_INTERRUPT_EMPTY4			13
-#define LEON_INTERRUPT_EMPTY5			14
-#define LEON_INTERRUPT_EMPTY6			15
-
 /* irq masks */
 #define LEON_HARD_INT(x)	(1 << (x))	/* irq 0-15 */
 #define LEON_IRQMASK_R		0x0000fffe	/* bit 15- 1 of lregs.irqmask */
diff --git a/arch/sparc/kernel/leon_kernel.c b/arch/sparc/kernel/leon_kernel.c
index d867543..5d7e41c 100644
--- a/arch/sparc/kernel/leon_kernel.c
+++ b/arch/sparc/kernel/leon_kernel.c
@@ -316,7 +316,7 @@ void __init leon_init_timers(irq_handler_t counter_fn)
 
 	if (err) {
 		printk(KERN_ERR "leon_time_init: unable to attach IRQ%d\n",
-		       LEON_INTERRUPT_TIMER1);
+		       irq);
 		prom_halt();
 	}
 
-- 
1.5.4

