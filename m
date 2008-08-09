From: David Miller <davem@davemloft.net>
Date: Sat, 09 Aug 2008 23:23:59 +0000
Subject: Re: [PATCH] Only call smp_fetch_global_regs if CONFIG_MAGIC_SYSRQ
Message-Id: <20080809.162359.127196490.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20080809123144.GA2024@v32062.1blu.de>
In-Reply-To: <20080809123144.GA2024@v32062.1blu.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Friedrich Oslage <bluebird@gentoo.org>
Date: Sat, 9 Aug 2008 14:31:44 +0200

> sparc64: Only call smp_fetch_global_regs if CONFIG_MAGIC_SYSRQ is set
> 
> Fixes this build error:
>   arch/sparc64/kernel/built-in.o: In function `__trigger_all_cpu_backtrace':
>   (.text+0xa88): undefined reference to `smp_fetch_global_regs'
> 
> Signed-off-by: Friedrich Oslage <bluebird@gentoo.org>

No, the intention is to provide this facility for
__trigger_all_cpu_backtrace even if MAGIC_SYSRQ is not set.

The only part that should have MAGIC_SYSRQ ifdef protection
is the sparc_globalreg_op sysrq regitration and immediate code.

Therefore I'll commit something like the following:

diff --git a/arch/sparc64/kernel/smp.c b/arch/sparc64/kernel/smp.c
index 27b8177..743ccad 100644
--- a/arch/sparc64/kernel/smp.c
+++ b/arch/sparc64/kernel/smp.c
@@ -858,9 +858,7 @@ void smp_tsb_sync(struct mm_struct *mm)
 extern unsigned long xcall_flush_tlb_mm;
 extern unsigned long xcall_flush_tlb_pending;
 extern unsigned long xcall_flush_tlb_kernel_range;
-#ifdef CONFIG_MAGIC_SYSRQ
 extern unsigned long xcall_fetch_glob_regs;
-#endif
 extern unsigned long xcall_receive_signal;
 extern unsigned long xcall_new_mmu_context_version;
 #ifdef CONFIG_KGDB
@@ -1005,12 +1003,10 @@ void kgdb_roundup_cpus(unsigned long flags)
 }
 #endif
 
-#ifdef CONFIG_MAGIC_SYSRQ
 void smp_fetch_global_regs(void)
 {
 	smp_cross_call(&xcall_fetch_glob_regs, 0, 0, 0);
 }
-#endif
 
 /* We know that the window frames of the user have been flushed
  * to the stack before we get here because all callers of us
diff --git a/arch/sparc64/mm/ultra.S b/arch/sparc64/mm/ultra.S
index ff1dc44..86773e8 100644
--- a/arch/sparc64/mm/ultra.S
+++ b/arch/sparc64/mm/ultra.S
@@ -480,7 +480,6 @@ xcall_sync_tick:
 	b		rtrap_xcall
 	 ldx		[%sp + PTREGS_OFF + PT_V9_TSTATE], %l1
 
-#ifdef CONFIG_MAGIC_SYSRQ
 	.globl		xcall_fetch_glob_regs
 xcall_fetch_glob_regs:
 	sethi		%hi(global_reg_snapshot), %g1
@@ -511,7 +510,6 @@ xcall_fetch_glob_regs:
 	membar		#StoreStore
 	stx		%g3, [%g1 + GR_SNAP_THREAD]
 	retry
-#endif /* CONFIG_MAGIC_SYSRQ */
 
 #ifdef DCACHE_ALIASING_POSSIBLE
 	.align		32
