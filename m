From: Daniel Hellstrom <daniel@gaisler.com>
Date: Thu, 21 Apr 2011 14:20:25 +0000
Subject: [PATCH 3/3] sparc32,leon: don't rely on bootloader to mask IRQs
Message-Id: <1303395625-6911-3-git-send-email-daniel@gaisler.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Signed-off-by: Daniel Hellstrom <daniel@gaisler.com>
---
 arch/sparc/kernel/leon_kernel.c |    3 +++
 arch/sparc/kernel/leon_smp.c    |    4 ++++
 2 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/arch/sparc/kernel/leon_kernel.c b/arch/sparc/kernel/leon_kernel.c
index 8417a91..2f538ac 100644
--- a/arch/sparc/kernel/leon_kernel.c
+++ b/arch/sparc/kernel/leon_kernel.c
@@ -345,6 +345,9 @@ void __init leon_init_timers(irq_handler_t counter_fn)
 	icsel = (icsel >> ((7 - (boot_cpu_id&0x7)) * 4)) & 0xf;
 	leon3_irqctrl_regs += icsel;
 
+	/* Mask all IRQs on boot-cpu IRQ controller */
+	LEON3_BYPASS_STORE_PA(&leon3_irqctrl_regs->mask[boot_cpu_id], 0);
+
 	/* Probe extended IRQ controller */
 	eirq = (LEON3_BYPASS_LOAD_PA(&leon3_irqctrl_regs->mpstatus)
 		>> 16) & 0xf;
diff --git a/arch/sparc/kernel/leon_smp.c b/arch/sparc/kernel/leon_smp.c
index 496b95f..826a505 100644
--- a/arch/sparc/kernel/leon_smp.c
+++ b/arch/sparc/kernel/leon_smp.c
@@ -219,6 +219,10 @@ int __cpuinit leon_boot_one_cpu(int i)
 	       (unsigned int)&leon3_irqctrl_regs->mpstatus);
 	local_flush_cache_all();
 
+	/* Make sure all IRQs are of from the start for this new CPU */
+	LEON_BYPASS_STORE_PA(&leon3_irqctrl_regs->mask[i], 0);
+
+	/* Wake one CPU */
 	LEON_BYPASS_STORE_PA(&(leon3_irqctrl_regs->mpstatus), 1 << i);
 
 	/* wheee... it's going... */
-- 
1.5.4

