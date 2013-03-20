From: Kirill Tkhai <tkhai@yandex.ru>
Date: Wed, 20 Mar 2013 01:11:07 +0000
Subject: [PATCH v2 0/1]sparc64: Hibernation support
Message-Id: <757071363741867@web15e.yandex.ru>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

This patch adds CONFIG_HIBERNATION support for sparc64
architecture. The suspend function is the same as on another
platforms. The restore function uses Bypass feature of MMU
which allows to make the process more comfortable and plesant.

Signed-off-by: Kirill Tkhai <tkhai@yandex.ru>
CC: David Miller <davem@davemloft.net>
CC: Sam Ravnborg <sam@ravnborg.org> 
---
 arch/sparc/Kconfig                 |    7 ++
 arch/sparc/Makefile                |    1 +
 arch/sparc/include/asm/hibernate.h |   23 +++++++
 arch/sparc/kernel/asm-offsets.c    |   15 +++++
 arch/sparc/power/Makefile          |    3 +
 arch/sparc/power/hibernate.c       |   42 ++++++++++++
 arch/sparc/power/hibernate_asm.S   |  131 ++++++++++++++++++++++++++++++++++++
 7 files changed, 222 insertions(+)
 create mode 100644 arch/sparc/include/asm/hibernate.h
 create mode 100644 arch/sparc/power/Makefile
 create mode 100644 arch/sparc/power/hibernate.c
 create mode 100644 arch/sparc/power/hibernate_asm.S
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
diff --git a/arch/sparc/include/asm/hibernate.h b/arch/sparc/include/asm/hibernate.h
new file mode 100644
index 0000000..2ec34f8
--- /dev/null
+++ b/arch/sparc/include/asm/hibernate.h
@@ -0,0 +1,23 @@
+/*
+ * hibernate.h:  Hibernaton support specific for sparc64.
+ *
+ * Copyright (C) 2013 Kirill V Tkhai (tkhai@yandex.ru)
+ */
+
+#ifndef ___SPARC_HIBERNATE_H
+#define ___SPARC_HIBERNATE_H
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
+};
+
+#endif
diff --git a/arch/sparc/kernel/asm-offsets.c b/arch/sparc/kernel/asm-offsets.c
index 68f7e11..961b87f 100644
--- a/arch/sparc/kernel/asm-offsets.c
+++ b/arch/sparc/kernel/asm-offsets.c
@@ -14,6 +14,8 @@
 // #include <linux/mm.h>
 #include <linux/kbuild.h>
 
+#include <asm/hibernate.h>
+
 #ifdef CONFIG_SPARC32
 int sparc32_foo(void)
 {
@@ -24,6 +26,19 @@ int sparc32_foo(void)
 #else
 int sparc64_foo(void)
 {
+#ifdef CONFIG_HIBERNATION
+	BLANK();
+	OFFSET(SC_REG_FP, saved_context, fp);
+	OFFSET(SC_REG_CWP, saved_context, cwp);
+	OFFSET(SC_REG_WSTATE, saved_context, wstate);
+
+	OFFSET(SC_REG_TICK, saved_context, tick);
+	OFFSET(SC_REG_PSTATE, saved_context, pstate);
+
+	OFFSET(SC_REG_G4, saved_context, g4);
+	OFFSET(SC_REG_G5, saved_context, g5);
+	OFFSET(SC_REG_G6, saved_context, g6);
+#endif
 	return 0;
 }
 #endif
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
index 0000000..42b0b8c
--- /dev/null
+++ b/arch/sparc/power/hibernate.c
@@ -0,0 +1,42 @@
+/*
+ * hibernate.c:  Hibernaton support specific for sparc64.
+ *
+ * Copyright (C) 2013 Kirill V Tkhai (tkhai@yandex.ru)
+ */
+
+#include <linux/mm.h>
+
+#include <asm/hibernate.h>
+#include <asm/visasm.h>
+#include <asm/page.h>
+#include <asm/tlb.h>
+
+/* References to section boundaries */
+extern const void __nosave_begin, __nosave_end;
+
+struct saved_context saved_context;
+
+/*
+ *	pfn_is_nosave - check if given pfn is in the 'nosave' section
+ */
+
+int pfn_is_nosave(unsigned long pfn)
+{
+	unsigned long nosave_begin_pfn = PFN_DOWN((unsigned long)&__nosave_begin);
+	unsigned long nosave_end_pfn = PFN_DOWN((unsigned long)&__nosave_end);
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
diff --git a/arch/sparc/power/hibernate_asm.S b/arch/sparc/power/hibernate_asm.S
new file mode 100644
index 0000000..7994216
--- /dev/null
+++ b/arch/sparc/power/hibernate_asm.S
@@ -0,0 +1,131 @@
+/*
+ * hibernate_asm.S:  Hibernaton support specific for sparc64.
+ *
+ * Copyright (C) 2013 Kirill V Tkhai (tkhai@yandex.ru)
+ */
+
+#include <linux/linkage.h>
+
+#include <asm/asm-offsets.h>
+#include <asm/cpudata.h>
+#include <asm/page.h>
+
+ENTRY(swsusp_arch_suspend)
+	save	%sp, -128, %sp
+	save	%sp, -128, %sp
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
+	mov	%o0, %i0
+	ret
+	 restore
+
+ENTRY(swsusp_arch_resume)
+	/* Write restore_pblist to %l0 */
+	sethi	%hi(restore_pblist), %l0
+	ldx	[%l0 + %lo(restore_pblist)], %l0
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
+	ba	fill_itlb
+	 nop
+
+pbe_loop:
+	cmp	%l0, %g0
+	be	restore_ctx
+	 sub	%l0, %g7, %l0
+
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
+fill_itlb:
+	ba	pbe_loop
+	 wrpr	%g0, 15, %pil
