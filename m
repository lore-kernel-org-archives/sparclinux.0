From: Daniel Hellstrom <daniel@gaisler.com>
Date: Wed, 16 Mar 2011 15:54:49 +0000
Subject: [PATCH 1/2] sparc32,leon: added irq_shutdown handler for genirq implementation
Message-Id: <1300290890-20694-1-git-send-email-daniel@gaisler.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Signed-off-by: Daniel Hellstrom <daniel@gaisler.com>
---
 arch/sparc/kernel/irq.h         |    1 +
 arch/sparc/kernel/irq_32.c      |   14 ++++++++++++++
 arch/sparc/kernel/leon_kernel.c |    7 +++++++
 3 files changed, 22 insertions(+), 0 deletions(-)

diff --git a/arch/sparc/kernel/irq.h b/arch/sparc/kernel/irq.h
index a43fc46..ecff50f 100644
--- a/arch/sparc/kernel/irq.h
+++ b/arch/sparc/kernel/irq.h
@@ -54,6 +54,7 @@ extern struct sparc_irq_config sparc_irq_config;
 
 unsigned int irq_alloc(unsigned int real_irq, unsigned int pil);
 void irq_link(unsigned int irq);
+void irq_unlink(unsigned int irq);
 void handler_irq(unsigned int pil, struct pt_regs *regs);
 
 /* Dave Redman (djhr@tadpole.co.uk)
diff --git a/arch/sparc/kernel/irq_32.c b/arch/sparc/kernel/irq_32.c
index 46a573a..1be0ae3 100644
--- a/arch/sparc/kernel/irq_32.c
+++ b/arch/sparc/kernel/irq_32.c
@@ -175,6 +175,20 @@ void irq_link(unsigned int irq)
 	irq_map[pil] = p;
 }
 
+void irq_unlink(unsigned int irq)
+{
+	struct irq_bucket *p, **pnext;
+
+	BUG_ON(irq >= NR_IRQS);
+
+	p = &irq_table[irq];
+	BUG_ON(p->pil > SUN4D_MAX_IRQ);
+	pnext = &irq_map[p->pil];
+	while (*pnext != p)
+		pnext = &(*pnext)->next;
+	*pnext = p->next;
+}
+
 int show_interrupts(struct seq_file *p, void *v)
 {
 	int i = *(loff_t *) v, j;
diff --git a/arch/sparc/kernel/leon_kernel.c b/arch/sparc/kernel/leon_kernel.c
index 0c1ae2b..4ddf367 100644
--- a/arch/sparc/kernel/leon_kernel.c
+++ b/arch/sparc/kernel/leon_kernel.c
@@ -113,9 +113,16 @@ static unsigned int leon_startup_irq(struct irq_data *data)
 	return 0;
 }
 
+static void leon_shutdown_irq(struct irq_data *data)
+{
+	irq_unlink(data->irq);
+	leon_mask_irq(data);
+}
+
 static struct irq_chip leon_irq = {
 	.name		= "leon",
 	.irq_startup	= leon_startup_irq,
+	.irq_shutdown	= leon_shutdown_irq,
 	.irq_mask	= leon_mask_irq,
 	.irq_unmask	= leon_unmask_irq,
 };
-- 
1.5.4

