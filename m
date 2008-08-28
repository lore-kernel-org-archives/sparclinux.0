From: David Miller <davem@davemloft.net>
Date: Thu, 28 Aug 2008 04:24:53 +0000
Subject: [PATCH 37/49]:
Message-Id: <20080827.212453.64441335.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


sparc: Convert remaining sbus_ioremap() and sbus_iounmap() users.

Use of_ioremap() and of_iounmap() instead.

Signed-off-by: David S. Miller <davem@davemloft.net>
---
 arch/sparc/include/asm/floppy_32.h |    5 ++++-
 arch/sparc/kernel/auxio.c          |    6 ++++--
 arch/sparc/kernel/sun4c_irq.c      |    5 +++--
 arch/sparc/kernel/sun4d_irq.c      |    5 +++--
 arch/sparc/kernel/sun4m_irq.c      |   11 ++++++-----
 arch/sparc/kernel/time.c           |    5 +++--
 6 files changed, 23 insertions(+), 14 deletions(-)

diff --git a/arch/sparc/include/asm/floppy_32.h b/arch/sparc/include/asm/floppy_32.h
index ff2b91c..c792830 100644
--- a/arch/sparc/include/asm/floppy_32.h
+++ b/arch/sparc/include/asm/floppy_32.h
@@ -6,6 +6,9 @@
 #ifndef __ASM_SPARC_FLOPPY_H
 #define __ASM_SPARC_FLOPPY_H
 
+#include <linux/of.h>
+#include <linux/of_device.h>
+
 #include <asm/page.h>
 #include <asm/pgtable.h>
 #include <asm/system.h>
@@ -343,7 +346,7 @@ static int sun_floppy_init(void)
 	r.flags = fd_regs[0].which_io;
 	r.start = fd_regs[0].phys_addr;
 	sun_fdc = (struct sun_flpy_controller *)
-	    sbus_ioremap(&r, 0, fd_regs[0].reg_size, "floppy");
+	    of_ioremap(&r, 0, fd_regs[0].reg_size, "floppy");
 
 	/* Last minute sanity check... */
 	if(sun_fdc->status_82072 = 0xff) {
diff --git a/arch/sparc/kernel/auxio.c b/arch/sparc/kernel/auxio.c
index baf4ed3..09c8572 100644
--- a/arch/sparc/kernel/auxio.c
+++ b/arch/sparc/kernel/auxio.c
@@ -6,6 +6,8 @@
 #include <linux/stddef.h>
 #include <linux/init.h>
 #include <linux/spinlock.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
 #include <asm/oplib.h>
 #include <asm/io.h>
 #include <asm/auxio.h>
@@ -59,7 +61,7 @@ void __init auxio_probe(void)
 	r.flags = auxregs[0].which_io & 0xF;
 	r.start = auxregs[0].phys_addr;
 	r.end = auxregs[0].phys_addr + auxregs[0].reg_size - 1;
-	auxio_register = sbus_ioremap(&r, 0, auxregs[0].reg_size, "auxio");
+	auxio_register = of_ioremap(&r, 0, auxregs[0].reg_size, "auxio");
 	/* Fix the address on sun4m and sun4c. */
 	if((((unsigned long) auxregs[0].phys_addr) & 3) = 3 ||
 	   sparc_cpu_model = sun4c)
@@ -128,7 +130,7 @@ void __init auxio_power_probe(void)
 	r.flags = regs.which_io & 0xF;
 	r.start = regs.phys_addr;
 	r.end = regs.phys_addr + regs.reg_size - 1;
-	auxio_power_register = (unsigned char *) sbus_ioremap(&r, 0,
+	auxio_power_register = (unsigned char *) of_ioremap(&r, 0,
 	    regs.reg_size, "auxpower");
 
 	/* Display a quick message on the console. */
diff --git a/arch/sparc/kernel/sun4c_irq.c b/arch/sparc/kernel/sun4c_irq.c
index a5a32a0..a745824 100644
--- a/arch/sparc/kernel/sun4c_irq.c
+++ b/arch/sparc/kernel/sun4c_irq.c
@@ -18,6 +18,8 @@
 #include <linux/interrupt.h>
 #include <linux/slab.h>
 #include <linux/init.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
 #include "irq.h"
 
 #include <asm/ptrace.h>
@@ -34,7 +36,6 @@
 #include <asm/sun4paddr.h>
 #include <asm/idprom.h>
 #include <asm/machines.h>
-#include <asm/sbus.h>
 
 #if 0
 static struct resource sun4c_timer_eb = { "sun4c_timer" };
@@ -224,7 +225,7 @@ void __init sun4c_init_IRQ(void)
 			memset(&phyres, 0, sizeof(struct resource));
 			phyres.flags = int_regs[0].which_io;
 			phyres.start = int_regs[0].phys_addr;
-			interrupt_enable = (char *) sbus_ioremap(&phyres, 0,
+			interrupt_enable = (char *) of_ioremap(&phyres, 0,
 			    int_regs[0].reg_size, "sun4c_intr");
 		}
 	}
diff --git a/arch/sparc/kernel/sun4d_irq.c b/arch/sparc/kernel/sun4d_irq.c
index acfb447..c4a2bfb 100644
--- a/arch/sparc/kernel/sun4d_irq.c
+++ b/arch/sparc/kernel/sun4d_irq.c
@@ -19,6 +19,8 @@
 #include <linux/smp.h>
 #include <linux/spinlock.h>
 #include <linux/seq_file.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
 
 #include <asm/ptrace.h>
 #include <asm/processor.h>
@@ -34,7 +36,6 @@
 #include <asm/io.h>
 #include <asm/pgalloc.h>
 #include <asm/pgtable.h>
-#include <asm/sbus.h>
 #include <asm/sbi.h>
 #include <asm/cacheflush.h>
 #include <asm/irq_regs.h>
@@ -475,7 +476,7 @@ static void __init sun4d_init_timers(irq_handler_t counter_fn)
 	r.start = CSR_BASE(0)+BW_TIMER_LIMIT;
 #endif
 	r.flags = 0xf;
-	sun4d_timers = (struct sun4d_timer_regs *) sbus_ioremap(&r, 0,
+	sun4d_timers = (struct sun4d_timer_regs *) of_ioremap(&r, 0,
 	    PAGE_SIZE, "user timer");
 
 	sun4d_timers->l10_timer_limit =  (((1000000/HZ) + 1) << 10);
diff --git a/arch/sparc/kernel/sun4m_irq.c b/arch/sparc/kernel/sun4m_irq.c
index d66334b..3481fec 100644
--- a/arch/sparc/kernel/sun4m_irq.c
+++ b/arch/sparc/kernel/sun4m_irq.c
@@ -20,6 +20,8 @@
 #include <linux/slab.h>
 #include <linux/init.h>
 #include <linux/ioport.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
 
 #include <asm/ptrace.h>
 #include <asm/processor.h>
@@ -35,7 +37,6 @@
 #include <asm/smp.h>
 #include <asm/irq.h>
 #include <asm/io.h>
-#include <asm/sbus.h>
 #include <asm/cacheflush.h>
 
 #include "irq.h"
@@ -327,13 +328,13 @@ static void __init sun4m_init_timers(irq_handler_t counter_fn)
 	/* Map the per-cpu Counter registers. */
 	r.flags = cnt_regs[0].which_io;
 	r.start = cnt_regs[0].phys_addr;
-	sun4m_timers = (struct sun4m_timer_regs *) sbus_ioremap(&r, 0,
+	sun4m_timers = (struct sun4m_timer_regs *) of_ioremap(&r, 0,
 	    PAGE_SIZE*SUN4M_NCPUS, "sun4m_cpu_cnt");
 	/* Map the system Counter register. */
 	/* XXX Here we expect consequent calls to yeld adjusent maps. */
 	r.flags = cnt_regs[4].which_io;
 	r.start = cnt_regs[4].phys_addr;
-	sbus_ioremap(&r, 0, cnt_regs[4].reg_size, "sun4m_sys_cnt");
+	of_ioremap(&r, 0, cnt_regs[4].reg_size, "sun4m_sys_cnt");
 
 	sun4m_timers->l10_timer_limit =  (((1000000/HZ) + 1) << 10);
 	master_l10_counter = &sun4m_timers->l10_cur_count;
@@ -411,13 +412,13 @@ void __init sun4m_init_IRQ(void)
 	/* Map the interrupt registers for all possible cpus. */
 	r.flags = int_regs[0].which_io;
 	r.start = int_regs[0].phys_addr;
-	sun4m_interrupts = (struct sun4m_intregs *) sbus_ioremap(&r, 0,
+	sun4m_interrupts = (struct sun4m_intregs *) of_ioremap(&r, 0,
 	    PAGE_SIZE*SUN4M_NCPUS, "interrupts_percpu");
 
 	/* Map the system interrupt control registers. */
 	r.flags = int_regs[4].which_io;
 	r.start = int_regs[4].phys_addr;
-	sbus_ioremap(&r, 0, int_regs[4].reg_size, "interrupts_system");
+	of_ioremap(&r, 0, int_regs[4].reg_size, "interrupts_system");
 
 	sun4m_interrupts->set = ~SUN4M_INT_MASKALL;
 	for (i = 0; !cpu_find_by_instance(i, NULL, &mid); i++)
diff --git a/arch/sparc/kernel/time.c b/arch/sparc/kernel/time.c
index 0762f5d..a713bb4 100644
--- a/arch/sparc/kernel/time.c
+++ b/arch/sparc/kernel/time.c
@@ -28,6 +28,7 @@
 #include <linux/pci.h>
 #include <linux/ioport.h>
 #include <linux/profile.h>
+#include <linux/of.h>
 #include <linux/of_device.h>
 
 #include <asm/oplib.h>
@@ -260,7 +261,7 @@ static inline void sun4_clock_probe(void)
 	if( idprom->id_machtype = (SM_SUN4 | SM_4_330) ) {
 		sp_clock_typ = MSTK48T02;
 		r.start = sun4_clock_physaddr;
-		mstk48t02_regs = sbus_ioremap(&r, 0,
+		mstk48t02_regs = of_ioremap(&r, 0,
 				       sizeof(struct mostek48t02), NULL);
 		mstk48t08_regs = NULL;  /* To catch weirdness */
 		intersil_clock = NULL;  /* just in case */
@@ -274,7 +275,7 @@ static inline void sun4_clock_probe(void)
 		sp_clock_typ = INTERSIL;
 		r.start = sun4_clock_physaddr;
 		intersil_clock = (struct intersil *) 
-		    sbus_ioremap(&r, 0, sizeof(*intersil_clock), "intersil");
+		    of_ioremap(&r, 0, sizeof(*intersil_clock), "intersil");
 		mstk48t02_regs = 0;  /* just be sure */
 		mstk48t08_regs = NULL;  /* ditto */
 		/* initialise the clock */
-- 
1.5.6.5.GIT

