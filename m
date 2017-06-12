From: Pavel Tatashin <pasha.tatashin@oracle.com>
Date: Mon, 12 Jun 2017 16:48:26 +0000
Subject: [v2 7/8] sparc64: add hot-patched and inlined get_tick()
Message-Id: <1497286107-974183-8-git-send-email-pasha.tatashin@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Add the new get_tick() function that is hot-patched during boot based on
processor we are booting on.

Signed-off-by: Pavel Tatashin <pasha.tatashin@oracle.com>
Reviewed-by: Steven Sistare <steven.sistare@oracle.com>
---
 arch/sparc/include/asm/timer_64.h |   60 +++++++++++++++++++++++++++++++++++++
 arch/sparc/kernel/time_64.c       |   28 +++++++++++++----
 arch/sparc/kernel/vmlinux.lds.S   |    5 +++
 3 files changed, 87 insertions(+), 6 deletions(-)

diff --git a/arch/sparc/include/asm/timer_64.h b/arch/sparc/include/asm/timer_64.h
index 61d0725..51bc3bc 100644
--- a/arch/sparc/include/asm/timer_64.h
+++ b/arch/sparc/include/asm/timer_64.h
@@ -34,4 +34,64 @@ struct sparc64_tick_ops {
 void setup_sparc64_timer(void);
 void __init time_init(void);
 
+#define TICK_PRIV_BIT		BIT(63)
+#define TICKCMP_IRQ_BIT		BIT(63)
+
+#define HBIRD_STICKCMP_ADDR	0x1fe0000f060UL
+#define HBIRD_STICK_ADDR	0x1fe0000f070UL
+
+#define GET_TICK_NINSTR		13
+struct get_tick_patch {
+	unsigned int	addr;
+	unsigned int	tick[GET_TICK_NINSTR];
+	unsigned int	stick[GET_TICK_NINSTR];
+};
+
+extern struct get_tick_patch __get_tick_patch;
+extern struct get_tick_patch __get_tick_patch_end;
+
+static inline unsigned long get_tick(void)
+{
+	unsigned long tick, tmp1, tmp2;
+
+	__asm__ __volatile__(
+	/* read hbtick 13 instructions */
+	"661:\n"
+	"	mov	0x1fe, %1\n"
+	"	sllx	%1, 0x20, %1\n"
+	"	sethi	%%hi(0xf000), %2\n"
+	"	or	%2, 0x70, %2\n"
+	"	or	%1, %2, %1\n"	/* %1 = HBIRD_STICK_ADDR */
+	"	add	%1, 8, %2\n"
+	"	ldxa	[%2]%3, %0\n"
+	"	ldxa	[%1]%3, %1\n"
+	"	ldxa	[%2]%3, %2\n"
+	"	sub	%2, %0, %0\n"	/* don't modify %xcc */
+	"	brnz,pn	%0, 661b\n"	/* restart to save one register */
+	"	 sllx	%2, 32, %2\n"
+	"	or	%2, %1, %0\n"
+	/* Common/not patched code */
+	"	sllx	%0, 1, %0\n"
+	"	srlx	%0, 1, %0\n"	/* Clear TICK_PRIV_BIT */
+	/* Beginning of patch section */
+	"	.section .get_tick_patch, \"ax\"\n"
+	"	.word	661b\n"
+	/* read tick 2 instructions and 11 skipped */
+	"	ba	1f\n"
+	"	 rd	%%tick, %0\n"
+	"	.skip	4 * (%4 - 2)\n"
+	"1:\n"
+	/* read stick 2 instructions and 11 skipped */
+	"	ba	1f\n"
+	"	 rd	%%asr24, %0\n"
+	"	.skip	4 * (%4 - 2)\n"
+	"1:\n"
+	/* End of patch section */
+	"	.previous\n"
+	: "=&r" (tick), "=&r" (tmp1), "=&r" (tmp2)
+	: "i" (ASI_PHYS_BYPASS_EC_E), "i" (GET_TICK_NINSTR));
+
+	return tick;
+}
+
 #endif /* _SPARC64_TIMER_H */
diff --git a/arch/sparc/kernel/time_64.c b/arch/sparc/kernel/time_64.c
index 3acfea0..5fe595a 100644
--- a/arch/sparc/kernel/time_64.c
+++ b/arch/sparc/kernel/time_64.c
@@ -47,15 +47,13 @@
 #include <asm/cpudata.h>
 #include <linux/uaccess.h>
 #include <asm/irq_regs.h>
+#include <asm/cacheflush.h>
 
 #include "entry.h"
 #include "kernel.h"
 
 DEFINE_SPINLOCK(rtc_lock);
 
-#define TICK_PRIV_BIT	(1UL << 63)
-#define TICKCMP_IRQ_BIT	(1UL << 63)
-
 #ifdef CONFIG_SMP
 unsigned long profile_pc(struct pt_regs *regs)
 {
@@ -290,9 +288,6 @@ static unsigned long stick_get_frequency(void)
  * 2) write high
  * 3) write low
  */
-#define HBIRD_STICKCMP_ADDR	0x1fe0000f060UL
-#define HBIRD_STICK_ADDR	0x1fe0000f070UL
-
 static unsigned long __hbird_read_stick(void)
 {
 	unsigned long ret, tmp1, tmp2, tmp3;
@@ -777,6 +772,26 @@ static u64 clocksource_tick_read(struct clocksource *cs)
 	return tick_operations.get_tick();
 }
 
+static void __init get_tick_patch(void)
+{
+	unsigned int *addr, *instr, i;
+	struct get_tick_patch *p;
+
+	if (tlb_type = spitfire && is_hummingbird())
+		return;
+
+	for (p = &__get_tick_patch; p < &__get_tick_patch_end; p++) {
+		instr = (tlb_type = spitfire) ? p->tick : p->stick;
+		addr = (unsigned int *)(unsigned long)p->addr;
+		for (i = 0; i < GET_TICK_NINSTR; i++) {
+			addr[i] = instr[i];
+			/* ensure that address is modified before flush */
+			wmb();
+			flushi(&addr[i]);
+		}
+	}
+}
+
 static void init_tick_ops(struct sparc64_tick_ops *ops)
 {
 	unsigned long freq, quotient, tick;
@@ -789,6 +804,7 @@ static void init_tick_ops(struct sparc64_tick_ops *ops)
 	ops->ticks_per_nsec_quotient = quotient;
 	ops->frequency = freq;
 	tick_operations = *ops;
+	get_tick_patch();
 }
 
 void __init time_init_early(void)
diff --git a/arch/sparc/kernel/vmlinux.lds.S b/arch/sparc/kernel/vmlinux.lds.S
index 572db68..03b3d65 100644
--- a/arch/sparc/kernel/vmlinux.lds.S
+++ b/arch/sparc/kernel/vmlinux.lds.S
@@ -149,6 +149,11 @@ SECTIONS
 		*(.sun_m7_2insn_patch)
 		__sun_m7_2insn_patch_end = .;
 	}
+	.get_tick_patch : {
+		__get_tick_patch = .;
+		*(.get_tick_patch)
+		__get_tick_patch_end = .;
+	}
 	PERCPU_SECTION(SMP_CACHE_BYTES)
 
 #ifdef CONFIG_JUMP_LABEL
-- 
1.7.1

