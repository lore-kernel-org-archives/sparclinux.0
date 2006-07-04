From: Mikael Pettersson <mikpe@it.uu.se>
Date: Tue, 04 Jul 2006 20:10:11 +0000
Subject: [PATCH 2.6.17 sparc64] fix stack overflow checking in modular non-SMP kernels
Message-Id: <200607042010.k64KABmC011107@harpo.it.uu.se>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: davem@davemloft.net
Cc: linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org

The sparc64 kernel's EXPORT_SYMBOL(_mcount) is inside an
#ifdef CONFIG_SMP. This breaks modules in non-SMP kernels
built with stack overflow checking (CONFIG_STACK_DEBUG=y),
as modules_install reports:

WARNING: /lib/modules/2.6.17/kernel/drivers/ide/ide-cd.ko needs unknown symbol _mcount

Trivially fixed by moving EXPORT_SYMBOL(_mcount) outside of
the #ifdef CONFIG_SMP.

Signed-off-by: Mikael Pettersson <mikpe@it.uu.se>

--- linux-2.6.17/arch/sparc64/kernel/sparc64_ksyms.c.~1~	2006-06-18 12:13:02.000000000 +0200
+++ linux-2.6.17/arch/sparc64/kernel/sparc64_ksyms.c	2006-07-04 20:41:07.000000000 +0200
@@ -128,11 +128,6 @@ EXPORT_SYMBOL(__write_trylock);
 /* Hard IRQ locking */
 EXPORT_SYMBOL(synchronize_irq);
 
-#if defined(CONFIG_MCOUNT)
-extern void _mcount(void);
-EXPORT_SYMBOL(_mcount);
-#endif
-
 /* CPU online map and active count.  */
 EXPORT_SYMBOL(cpu_online_map);
 EXPORT_SYMBOL(phys_cpu_present_map);
@@ -140,6 +135,11 @@ EXPORT_SYMBOL(phys_cpu_present_map);
 EXPORT_SYMBOL(smp_call_function);
 #endif /* CONFIG_SMP */
 
+#if defined(CONFIG_MCOUNT)
+extern void _mcount(void);
+EXPORT_SYMBOL(_mcount);
+#endif
+
 EXPORT_SYMBOL(sparc64_get_clock_tick);
 
 /* semaphores */
