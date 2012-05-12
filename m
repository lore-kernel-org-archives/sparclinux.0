From: Sam Ravnborg <sam@ravnborg.org>
Date: Sat, 12 May 2012 20:44:13 +0000
Subject: [PATCH] sparc32: drop unused code in process_32
Message-Id: <20120512204412.GA5255@merkur.ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From 09d905845b68e521e30729cea048aaf982b8d1ac Mon Sep 17 00:00:00 2001
From: Sam Ravnborg <sam@ravnborg.org>
Date: Sat, 12 May 2012 22:40:45 +0200
Subject: [PATCH] sparc32: drop unused code in process_32

It is commented out using #ifdef 0 / #endif,
and has been so for a long time.

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
---
 arch/sparc/kernel/process_32.c |   82 ----------------------------------------
 1 files changed, 0 insertions(+), 82 deletions(-)

diff --git a/arch/sparc/kernel/process_32.c b/arch/sparc/kernel/process_32.c
index bb23036..fe6787c 100644
--- a/arch/sparc/kernel/process_32.c
+++ b/arch/sparc/kernel/process_32.c
@@ -145,88 +145,6 @@ void machine_power_off(void)
 	machine_halt();
 }
 
-#if 0
-
-static DEFINE_SPINLOCK(sparc_backtrace_lock);
-
-void __show_backtrace(unsigned long fp)
-{
-	struct reg_window32 *rw;
-	unsigned long flags;
-	int cpu = smp_processor_id();
-
-	spin_lock_irqsave(&sparc_backtrace_lock, flags);
-
-	rw = (struct reg_window32 *)fp;
-        while(rw && (((unsigned long) rw) >= PAGE_OFFSET) &&
-            !(((unsigned long) rw) & 0x7)) {
-		printk("CPU[%d]: ARGS[%08lx,%08lx,%08lx,%08lx,%08lx,%08lx] "
-		       "FP[%08lx] CALLER[%08lx]: ", cpu,
-		       rw->ins[0], rw->ins[1], rw->ins[2], rw->ins[3],
-		       rw->ins[4], rw->ins[5],
-		       rw->ins[6],
-		       rw->ins[7]);
-		printk("%pS\n", (void *) rw->ins[7]);
-		rw = (struct reg_window32 *) rw->ins[6];
-	}
-	spin_unlock_irqrestore(&sparc_backtrace_lock, flags);
-}
-
-#define __SAVE __asm__ __volatile__("save %sp, -0x40, %sp\n\t")
-#define __RESTORE __asm__ __volatile__("restore %g0, %g0, %g0\n\t")
-#define __GET_FP(fp) __asm__ __volatile__("mov %%i6, %0" : "=r" (fp))
-
-void show_backtrace(void)
-{
-	unsigned long fp;
-
-	__SAVE; __SAVE; __SAVE; __SAVE;
-	__SAVE; __SAVE; __SAVE; __SAVE;
-	__RESTORE; __RESTORE; __RESTORE; __RESTORE;
-	__RESTORE; __RESTORE; __RESTORE; __RESTORE;
-
-	__GET_FP(fp);
-
-	__show_backtrace(fp);
-}
-
-#ifdef CONFIG_SMP
-void smp_show_backtrace_all_cpus(void)
-{
-	xc0((smpfunc_t) show_backtrace);
-	show_backtrace();
-}
-#endif
-
-void show_stackframe(struct sparc_stackf *sf)
-{
-	unsigned long size;
-	unsigned long *stk;
-	int i;
-
-	printk("l0: %08lx l1: %08lx l2: %08lx l3: %08lx "
-	       "l4: %08lx l5: %08lx l6: %08lx l7: %08lx\n",
-	       sf->locals[0], sf->locals[1], sf->locals[2], sf->locals[3],
-	       sf->locals[4], sf->locals[5], sf->locals[6], sf->locals[7]);
-	printk("i0: %08lx i1: %08lx i2: %08lx i3: %08lx "
-	       "i4: %08lx i5: %08lx fp: %08lx i7: %08lx\n",
-	       sf->ins[0], sf->ins[1], sf->ins[2], sf->ins[3],
-	       sf->ins[4], sf->ins[5], (unsigned long)sf->fp, sf->callers_pc);
-	printk("sp: %08lx x0: %08lx x1: %08lx x2: %08lx "
-	       "x3: %08lx x4: %08lx x5: %08lx xx: %08lx\n",
-	       (unsigned long)sf->structptr, sf->xargs[0], sf->xargs[1],
-	       sf->xargs[2], sf->xargs[3], sf->xargs[4], sf->xargs[5],
-	       sf->xxargs[0]);
-	size = ((unsigned long)sf->fp) - ((unsigned long)sf);
-	size -= STACKFRAME_SZ;
-	stk = (unsigned long *)((unsigned long)sf + STACKFRAME_SZ);
-	i = 0;
-	do {
-		printk("s%d: %08lx\n", i++, *stk++);
-	} while ((size -= sizeof(unsigned long)));
-}
-#endif
-
 void show_regs(struct pt_regs *r)
 {
 	struct reg_window32 *rw = (struct reg_window32 *) r->u_regs[14];
-- 
1.6.0.6

