From: Daniel Hellstrom <daniel@gaisler.com>
Date: Tue, 26 Oct 2010 17:55:31 +0000
Subject: [PATCH] SPARC/LEON: removed constant timer initialization as if HZ=100, now it reflects the value of
Message-Id: <1288115731-28803-1-git-send-email-daniel@gaisler.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Signed-off-by: Daniel Hellstrom <daniel@gaisler.com>
---
 arch/sparc/kernel/leon_kernel.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/sparc/kernel/leon_kernel.c b/arch/sparc/kernel/leon_kernel.c
index 6a7b4db..dcefd22 100644
--- a/arch/sparc/kernel/leon_kernel.c
+++ b/arch/sparc/kernel/leon_kernel.c
@@ -114,7 +114,7 @@ void __init leon_init_timers(irq_handler_t counter_fn)
 	if (leon3_gptimer_regs && leon3_irqctrl_regs) {
 		LEON3_BYPASS_STORE_PA(&leon3_gptimer_regs->e[0].val, 0);
 		LEON3_BYPASS_STORE_PA(&leon3_gptimer_regs->e[0].rld,
-				      (((1000000 / 100) - 1)));
+				      (((1000000 / HZ) - 1)));
 		LEON3_BYPASS_STORE_PA(&leon3_gptimer_regs->e[0].ctrl, 0);
 
 #ifdef CONFIG_SMP
@@ -128,7 +128,7 @@ void __init leon_init_timers(irq_handler_t counter_fn)
 		}
 
 		LEON3_BYPASS_STORE_PA(&leon3_gptimer_regs->e[1].val, 0);
-		LEON3_BYPASS_STORE_PA(&leon3_gptimer_regs->e[1].rld, (((1000000/100) - 1)));
+		LEON3_BYPASS_STORE_PA(&leon3_gptimer_regs->e[1].rld, (((1000000/HZ) - 1)));
 		LEON3_BYPASS_STORE_PA(&leon3_gptimer_regs->e[1].ctrl, 0);
 # endif
 
-- 
1.5.4

