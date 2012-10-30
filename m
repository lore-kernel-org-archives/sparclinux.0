From: Andreas Larsson <andreas@gaisler.com>
Date: Tue, 30 Oct 2012 10:09:46 +0000
Subject: [PATCH] sparc32,leon: Check for existent irq_map entry in leon_handle_ext_irq
Message-Id: <1351591786-21024-1-git-send-email-andreas@gaisler.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

If an irq is being unlinked concurrently with leon_handle_ext_irq,
irq_map[eirq] might be null in leon_handle_ext_irq. Make sure that
this is not dereferenced.

Signed-off-by: Andreas Larsson <andreas@gaisler.com>
---
 arch/sparc/kernel/leon_kernel.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/sparc/kernel/leon_kernel.c b/arch/sparc/kernel/leon_kernel.c
index f8b6eee..87f60ee 100644
--- a/arch/sparc/kernel/leon_kernel.c
+++ b/arch/sparc/kernel/leon_kernel.c
@@ -56,11 +56,13 @@ static inline unsigned int leon_eirq_get(int cpu)
 static void leon_handle_ext_irq(unsigned int irq, struct irq_desc *desc)
 {
 	unsigned int eirq;
+	struct irq_bucket *p;
 	int cpu = sparc_leon3_cpuid();
 
 	eirq = leon_eirq_get(cpu);
-	if ((eirq & 0x10) && irq_map[eirq]->irq) /* bit4 tells if IRQ happened */
-		generic_handle_irq(irq_map[eirq]->irq);
+	p = irq_map[eirq];
+	if ((eirq & 0x10) && p && p->irq) /* bit4 tells if IRQ happened */
+		generic_handle_irq(p->irq);
 }
 
 /* The extended IRQ controller has been found, this function registers it */
-- 
1.7.0.4

