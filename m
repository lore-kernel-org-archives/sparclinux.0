From: Kirill Tkhai <tkhai@yandex.ru>
Date: Thu, 05 Jan 2012 02:27:54 +0000
Subject: [PATCH][resending] SPARC32: forced setting of mode of SUN4M per-cpu timers
Message-Id: <772801325730475@web77.yandex.ru>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

SPARC32: forced setting of mode of SUN4M per-cpu timers

SUN4M per-cpu timers have two modes of work. These are timer mode and counter mode.
SPARC32 doesn't write anything to the register, which is connected with mode choice.
So, the mode is chosen by bootloader. This patch forces to use timer mode from the
kernel and to be independent of bootloader.

I had this problem with OpenBIOS. Timers didn't use to tick and kernel on QEMU used
to fail, when it's compiled with SMP support. The patch fixes problem.

Signed-off-by: Tkhai Kirill <tkhai@yandex.ru>
---

diff --git a/arch/sparc/kernel/sun4m_irq.c b/arch/sparc/kernel/sun4m_irq.c
index 422c16d..aa0b9df 100644
--- a/arch/sparc/kernel/sun4m_irq.c
+++ b/arch/sparc/kernel/sun4m_irq.c
@@ -414,6 +414,10 @@ static void __init sun4m_init_timers(irq_handler_t counter_fn)
 
 	for (i = 0; i < num_cpu_timers; i++)
 		sbus_writel(0, &timers_percpu[i]->l14_limit);
+#ifdef CONFIG_SMP
+	/* Timer-mode for every per-cpu timer (bit '0' is timer mode) */
+	sbus_writel(0x00000000, &timers_global->timer_config);
+#endif
 	if (num_cpu_timers = 4)
 		sbus_writel(SUN4M_INT_E14, &sun4m_irq_global->mask_set);
 
