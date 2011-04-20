From: Daniel Hellstrom <daniel@gaisler.com>
Date: Wed, 20 Apr 2011 09:41:27 +0000
Subject: [PATCH 8/8] sparc32,leon: operate on boot-cpu IRQ controller registers
Message-Id: <1303292487-12623-8-git-send-email-daniel@gaisler.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Each CPU has a separate set of IRQ controller registers, this
patch makes sure that the boot-cpu registers are used instead
of CPU0's. Note that there are other parts of the SPARC32/LEON
port which does not support booting on other than CPU0 anyway,
however this cleans up the IRQ controller layer in that regard.

Signed-off-by: Daniel Hellstrom <daniel@gaisler.com>
---
 arch/sparc/include/asm/leon.h   |    1 +
 arch/sparc/kernel/leon_kernel.c |    8 ++++----
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/arch/sparc/include/asm/leon.h b/arch/sparc/include/asm/leon.h
index 31fb2ac..1776f71 100644
--- a/arch/sparc/include/asm/leon.h
+++ b/arch/sparc/include/asm/leon.h
@@ -335,6 +335,7 @@ extern int leon_flush_needed(void);
 extern void leon_switch_mm(void);
 extern int srmmu_swprobe_trace;
 extern int leon3_ticker_irq;
+extern int leon3_boot_cpu;
 
 #ifdef CONFIG_SMP
 extern int leon_smp_nrcpus(void);
diff --git a/arch/sparc/kernel/leon_kernel.c b/arch/sparc/kernel/leon_kernel.c
index ab14584..7a3bcb3 100644
--- a/arch/sparc/kernel/leon_kernel.c
+++ b/arch/sparc/kernel/leon_kernel.c
@@ -79,8 +79,8 @@ void leon_eirq_setup(unsigned int eirq)
 	 */
 	irq_link(veirq);
 	mask = 1 << eirq;
-	oldmask = LEON3_BYPASS_LOAD_PA(LEON_IMASK(0));
-	LEON3_BYPASS_STORE_PA(LEON_IMASK(0), (oldmask | mask));
+	oldmask = LEON3_BYPASS_LOAD_PA(LEON_IMASK(boot_cpu_id));
+	LEON3_BYPASS_STORE_PA(LEON_IMASK(boot_cpu_id), (oldmask | mask));
 	sparc_leon_eirq = eirq;
 }
 
@@ -106,12 +106,12 @@ static int irq_choose_cpu(const struct cpumask *affinity)
 
 	cpus_and(mask, cpu_online_map, *affinity);
 	if (cpus_equal(mask, cpu_online_map) || cpus_empty(mask))
-		return 0;
+		return boot_cpu_id;
 	else
 		return first_cpu(mask);
 }
 #else
-#define irq_choose_cpu(affinity) 0
+#define irq_choose_cpu(affinity) boot_cpu_id
 #endif
 
 static int leon_set_affinity(struct irq_data *data, const struct cpumask *dest,
-- 
1.5.4

