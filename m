From: Daniel Hellstrom <daniel@gaisler.com>
Date: Thu, 09 Jun 2011 12:54:09 +0000
Subject: [PATCH 2/2] sparc32, leon: bugfix in LEON SMP interrupt init
Message-Id: <1307624049-29690-2-git-send-email-daniel@gaisler.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

During converting per-cpu ticker to genirq layer some
IRQ initialization code was removed by commit
2cf9530420e446bb61f665d02afeb81070106900 ("sparc32,leon:
per-cpu ticker use genirq per-cpu handler").

This patch reintroduces the code at the same place it was
removed from. IRQ12 - IRQ14 will crash on LEON SMP without
this patch because it will run the SUN4M IRQ trap handler.

Reported-by: Jan Andersson <jan@gaisler.com>
Signed-off-by: Daniel Hellstrom <daniel@gaisler.com>
---
 arch/sparc/kernel/leon_kernel.c |   16 ++++++++++++++++
 1 files changed, 16 insertions(+), 0 deletions(-)

diff --git a/arch/sparc/kernel/leon_kernel.c b/arch/sparc/kernel/leon_kernel.c
index c23d61e..d17255a 100644
--- a/arch/sparc/kernel/leon_kernel.c
+++ b/arch/sparc/kernel/leon_kernel.c
@@ -376,6 +376,22 @@ void __init leon_init_timers(irq_handler_t counter_fn)
 		prom_halt();
 	}
 
+#ifdef CONFIG_SMP
+	{
+		unsigned long flags;
+
+		/*
+		 * In SMP, sun4m adds a IPI handler to IRQ trap handler that
+		 * LEON never must take, sun4d and LEON overwrites the branch
+		 * with a NOP.
+		 */
+		local_irq_save(flags);
+		patchme_maybe_smp_msg[0] = 0x01000000; /* NOP out the branch */
+		local_flush_cache_all();
+		local_irq_restore(flags);
+	}
+#endif
+
 	LEON3_BYPASS_STORE_PA(&leon3_gptimer_regs->e[leon3_gptimer_idx].ctrl,
 			      LEON3_GPTIMER_EN |
 			      LEON3_GPTIMER_RL |
-- 
1.5.4

