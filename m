From: Kirill Tkhai <tkhai@yandex.ru>
Date: Tue, 10 Jan 2012 23:17:03 +0000
Subject: [PATCH]sparc32: forced setting of mode of sun4m per-cpu timers
Message-Id: <1326237423.7307.13.camel@hp>
List-Id: <sparclinux.vger.kernel.org>
References: <1325885691.21461.8.camel@hp>
In-Reply-To: <1325885691.21461.8.camel@hp>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

SUN4M per-cpu timers have two modes of work. These are timer mode and
counter mode. Kernel doesn't write anything to the register, which is
connected with mode choice.
So, the mode is chosen by bootloader. This patch forces to use timer
mode from the kernel and to be independent of bootloader.

I had this problem with OpenBIOS. Timers don't tick and kernel fails on
QEMU, when it's compiled with SMP support. The patch fixes problem.

Signed-off-by: Tkhai Kirill <tkhai@yandex.ru>
Acked-by: Sam Ravnborg <sam@ravnborg.org>
---
diff --git a/arch/sparc/kernel/sun4m_irq.c b/arch/sparc/kernel/sun4m_irq.c
index 422c16d..e611651 100644
--- a/arch/sparc/kernel/sun4m_irq.c
+++ b/arch/sparc/kernel/sun4m_irq.c
@@ -399,6 +399,9 @@ static void __init sun4m_init_timers(irq_handler_t counter_fn)
 	timers_global = (void __iomem *)
 		(unsigned long) addr[num_cpu_timers];
 
+	/* Every per-cpu timer works in timer mode */
+	sbus_writel(0x00000000, &timers_global->timer_config);
+
 	sbus_writel((((1000000/HZ) + 1) << 10), &timers_global->l10_limit);
 
 	master_l10_counter = &timers_global->l10_count;


