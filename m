From: Kirill Tkhai <tkhai@yandex.ru>
Date: Fri, 08 Mar 2013 16:19:46 +0000
Subject: [PATCH]sparc64: Hibernation support
Message-Id: <1580671362759586@web24e.yandex.ru>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hi!

This patch is for hibernation support on sparc64.

Two steps to try:
1)"echo disk > /sys/power/state" makes a system sleeping
2)kernel parameter "resume=/dev/[swap_partition]" will say
the system which swap partition to use for restore.

Use MMU bypass to copy data pages. This allowes not to
create temporary page table as on some other architectures.

I changed mm/init_64.c because of restore may be called
from initcall. This moment is before free_initmem(), so
num_physpages must not be changed in it. Otherwise,
restore fails by the reason of mismatched sizes of the loaded
image and the system.

I tested the patch on single-core mcst-r1000 variant of v9.
Everything work, but everybody is welcome to test it on any
more standard v9 :)

Signed-off-by: Kirill Tkhai <tkhai@yandex.ru>
CC: David Miller <davem@davemloft.net>
---
diff --git a/arch/sparc/Kconfig b/arch/sparc/Kconfig
index 9bff3db..9e1256f 100644
--- a/arch/sparc/Kconfig
+++ b/arch/sparc/Kconfig
@@ -103,6 +103,9 @@ config HAVE_LATENCYTOP_SUPPORT
 	bool
 	default y if SPARC64
 
+config ARCH_HIBERNATION_POSSIBLE
+	def_bool y if SPARC64
+
 config AUDIT_ARCH
 	bool
 	default y
@@ -333,6 +336,10 @@ config ARCH_SPARSEMEM_DEFAULT
 
 source "mm/Kconfig"
 
+if SPARC64
+source "kernel/power/Kconfig"
+endif
+
 config SCHED_SMT
 	bool "SMT (Hyperthreading) scheduler support"
 	depends on SPARC64 && SMP
diff --git a/arch/sparc/Makefile b/arch/sparc/Makefile
index 541b8b0..9ff4236 100644
--- a/arch/sparc/Makefile
+++ b/arch/sparc/Makefile
@@ -57,6 +57,7 @@ core-y                 += arch/sparc/
 libs-y                 += arch/sparc/prom/
 libs-y                 += arch/sparc/lib/
 
+drivers-$(CONFIG_PM) += arch/sparc/power/
 drivers-$(CONFIG_OPROFILE)	+= arch/sparc/oprofile/
 
 boot := arch/sparc/boot
diff --git a/arch/sparc/kernel/head_64.S b/arch/sparc/kernel/head_64.S
index 2feb15c..1a2ce1e 100644
diff --git a/arch/sparc/lib/Makefile b/arch/sparc/lib/Makefile
index 8410065..d4fc2f0 100644
diff --git a/arch/sparc/mm/init_64.c b/arch/sparc/mm/init_64.c
index 5c2c6e6..a40a845 100644
--- a/arch/sparc/mm/init_64.c
+++ b/arch/sparc/mm/init_64.c
@@ -2061,7 +2061,7 @@ void __init mem_init(void)
 	 * allocated below.
 	 */
 	totalram_pages -= 1;
-	num_physpages = totalram_pages;
+	num_physpages = memblock_mem_size(last_valid_pfn) >> PAGE_SHIFT;
 
 	/*
 	 * Set up the zero page, mark it reserved, so that page count
@@ -2125,7 +2125,6 @@ void free_initmem(void)
 			ClearPageReserved(p);
 			init_page_count(p);
 			__free_page(p);
-			num_physpages++;
 			totalram_pages++;
 		}
 	}
@@ -2142,7 +2141,6 @@ void free_initrd_mem(unsigned long start, unsigned long end)
 		ClearPageReserved(p);
 		init_page_count(p);
 		__free_page(p);
-		num_physpages++;
 		totalram_pages++;
 	}
 }
diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
index 8ad21a2..380e1a1 100644
diff --git a/arch/sparc/power/Makefile b/arch/sparc/power/Makefile
new file mode 100644
index 0000000..3201ace
--- /dev/null
+++ b/arch/sparc/power/Makefile
@@ -0,0 +1,3 @@
+# Makefile for Sparc-specific hibernate files.
+
+obj-$(CONFIG_HIBERNATION)	+= hibernate.o hibernate_asm.o
diff --git a/arch/sparc/power/hibernate.c b/arch/sparc/power/hibernate.c
new file mode 100644
index 0000000..89ca059
--- /dev/null
+++ b/arch/sparc/power/hibernate.c
@@ -0,0 +1,65 @@
+/*
+ * hibernate.c:  Hibernaton support specific for sparc64.
+ *
+ * Copyright (C) 2013 Kirill V Tkhai (tkhai@yandex.ru)
+ */
+
+#include <linux/mm.h>
+#include <asm/page.h>
+#include <asm/tlb.h>
+#include <asm/visasm.h>
+
+
+#include "hibernate.h"
+
+/* References to section boundaries */
+extern const void __nosave_begin, __nosave_end;
+
+struct saved_context {
+	unsigned long fp;
+	unsigned long cwp;
+	unsigned long wstate;
+
+	unsigned long tick;
+	unsigned long pstate;
+
+	unsigned long g4;
+	unsigned long g5;
+	unsigned long g6;
+} saved_context;
+
+/*
+ *	pfn_is_nosave - check if given pfn is in the 'nosave' section
+ */
+
+int pfn_is_nosave(unsigned long pfn)
+{
+	unsigned long nosave_begin_pfn = ((unsigned long)&__nosave_begin) >> PAGE_SHIFT;
+	unsigned long nosave_end_pfn = ((unsigned long)&__nosave_end) >> PAGE_SHIFT;
+
+	BUILD_BUG_ON(SC_REG_FP != offsetof(struct saved_context, fp));
+	BUILD_BUG_ON(SC_REG_CWP != offsetof(struct saved_context, cwp));
+	BUILD_BUG_ON(SC_REG_WSTATE != offsetof(struct saved_context, wstate));
+
+	BUILD_BUG_ON(SC_REG_TICK != offsetof(struct saved_context, tick));
+	BUILD_BUG_ON(SC_REG_PSTATE != offsetof(struct saved_context, pstate));
+
+	BUILD_BUG_ON(SC_REG_G4 != offsetof(struct saved_context, g4));
+	BUILD_BUG_ON(SC_REG_G5 != offsetof(struct saved_context, g5));
+	BUILD_BUG_ON(SC_REG_G6 != offsetof(struct saved_context, g6));
+
+	return (pfn >= nosave_begin_pfn) && (pfn < nosave_end_pfn);
+}
+
+void save_processor_state(void)
+{
+	save_and_clear_fpu();
+}
+
+void restore_processor_state(void)
+{
+	struct mm_struct *mm = current->active_mm;
+
+	load_secondary_context(mm);
+	tsb_context_switch(mm);
+}
diff --git a/arch/sparc/power/hibernate.h b/arch/sparc/power/hibernate.h
new file mode 100644
index 0000000..6c002f4
--- /dev/null
+++ b/arch/sparc/power/hibernate.h
@@ -0,0 +1,21 @@
+/*
+ * hibernate.c:  Hibernaton support specific for sparc64.
+ *
+ * Copyright (C) 2013 Kirill V Tkhai (tkhai@yandex.ru)
+ */
+
+#ifndef ___SPARC_HIBERNATE_H
+#define ___SPARC_HIBERNATE_H
+
+#define SC_REG_FP	0
+#define SC_REG_CWP	8
+#define SC_REG_WSTATE	16
+
+#define SC_REG_TICK	24
+#define SC_REG_PSTATE	32
+
+#define SC_REG_G4	40
+#define SC_REG_G5	48
+#define SC_REG_G6	56
+
+#endif
diff --git a/arch/sparc/power/hibernate_asm.S b/arch/sparc/power/hibernate_asm.S
new file mode 100644
index 0000000..8cc5c4e
--- /dev/null
+++ b/arch/sparc/power/hibernate_asm.S
@@ -0,0 +1,129 @@
+/*
+ * hibernate.c:  Hibernaton support specific for sparc64.
+ *
+ * Copyright (C) 2013 Kirill V Tkhai (tkhai@yandex.ru)
+ */
+
+#include <linux/linkage.h>
+#include <asm/page.h>
+#include <asm/cpudata.h>
+#include "hibernate.h"
+
+ENTRY(swsusp_arch_suspend)
+	save	%sp, -192, %sp
+	save	%sp, -192, %sp
+	flushw
+
+	setuw	saved_context, %g3
+	
+	/* Save window regs */
+	rdpr	%cwp, %g2
+	stx	%g2, [%g3 + SC_REG_CWP]
+	rdpr	%wstate, %g2
+	stx	%g2, [%g3 + SC_REG_WSTATE]
+	stx	%fp, [%g3 + SC_REG_FP]
+
+	/* Save state regs */
+	rdpr	%tick, %g2
+	stx	%g2, [%g3 + SC_REG_TICK]
+	rdpr	%pstate, %g2
+	stx	%g2, [%g3 + SC_REG_PSTATE]
+
+	/* Save global regs */
+	stx	%g4, [%g3 + SC_REG_G4]
+	stx	%g5, [%g3 + SC_REG_G5]
+	stx	%g6, [%g3 + SC_REG_G6]
+
+	call	swsusp_save
+	 nop
+
+	mov	%o0, %i0
+	restore
+
+        mov	%o0, %i0
+	ret
+	 restore
+
+ENTRY(swsusp_arch_resume)
+	/* Write restore_pblist to %l0 */
+	sethi	%hi(restore_pblist), %l0
+        ldx	[%l0 + %lo(restore_pblist)], %l0
+
+	call	__flush_tlb_all
+	 nop
+	
+	/* Write PAGE_OFFSET to %g7 */
+	sethi	%uhi(PAGE_OFFSET), %g7
+	sllx	%g7, 32, %g7
+
+	setuw	(PAGE_SIZE-8), %g3
+	
+	/* Use MMU Bypass */
+	rd	%asi, %g1
+	wr	%g0, ASI_PHYS_USE_EC, %asi
+
+	/* Fill ITLB */
+	ba	16f
+	 nop
+
+pbe_loop:
+	cmp	%l0, %g0
+	be	restore_ctx
+	 sub	%l0, %g7, %l0
+	ldxa	[%l0    ] %asi, %l1 /* address */
+	ldxa	[%l0 + 8] %asi, %l2 /* orig_address */
+
+	/* phys addr */
+	sub	%l1, %g7, %l1
+	sub	%l2, %g7, %l2
+
+	mov	%g3, %l3 /* PAGE_SIZE-8 */
+copy_loop:
+	ldxa	[%l1 + %l3] ASI_PHYS_USE_EC, %g2
+	stxa	%g2, [%l2 + %l3] ASI_PHYS_USE_EC
+	cmp	%l3, %g0
+	bne	copy_loop
+	 sub	%l3, 8, %l3
+
+	/* next pbe */
+	ba	pbe_loop
+	 ldxa	[%l0 + 16] %asi, %l0
+
+restore_ctx:
+	setuw	saved_context, %g3
+	wrpr	%g0, 15, %pil
+
+	/* Restore window regs */
+	wrpr    %g0, 0, %canrestore
+	wrpr    %g0, 0, %otherwin
+	wrpr	%g0, 6, %cansave
+	wrpr    %g0, 0, %cleanwin
+
+	ldxa	[%g3 + SC_REG_CWP] %asi, %g2
+	wrpr	%g2, %cwp
+	ldxa	[%g3 + SC_REG_WSTATE] %asi, %g2
+	wrpr	%g2, %wstate
+	ldxa	[%g3 + SC_REG_FP] %asi, %fp
+
+	/* Restore state regs */
+	ldxa	[%g3 + SC_REG_PSTATE] %asi, %g2
+	wrpr	%g2, %pstate
+	ldxa	[%g3 + SC_REG_TICK] %asi, %g2
+	wrpr	%g2, %tick
+
+	/* Restore global regs */
+	ldxa	[%g3 + SC_REG_G4] %asi, %g4
+	ldxa	[%g3 + SC_REG_G5] %asi, %g5
+	ldxa	[%g3 + SC_REG_G6] %asi, %g6
+
+	wr	%g1, %g0, %asi
+
+	restore
+	restore
+
+	wrpr	%g0, 14, %pil
+
+	retl
+	 mov	%g0, %o0
+
+16:	ba,a	pbe_loop
