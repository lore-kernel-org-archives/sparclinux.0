From: Daniel Hellstrom <daniel@gaisler.com>
Date: Mon, 14 Mar 2011 11:25:42 +0000
Subject: Re: Status update on sparc32 genirq support
Message-Id: <4D7DFB36.5040200@gaisler.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20110307.230120.226776255.davem@davemloft.net>
In-Reply-To: <20110307.230120.226776255.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Sam Ravnborg wrote:

>Hi Daniel - thanks for looking at this patch.
>
>I was actually planning to send it to David tonight.
>But after your comments I will wait.
>  
>
Thanks, please hold it a couple of days until I can test this a bit more.

Below is a patch that adds irq_unlink (havn't tested it yet), I figure 
we must have that in order to implement irq_shutdown?

I used the patch on irq_alloc() below to get LEON booting, this will 
make VIRQs map 1:1 to real IRQs in most cases. This is needed in order 
to get APBUART driver working, however as said in previous email I will 
try fixing APBUART driver instead so you should probably ignore that hunk.

Daniel


---
 arch/sparc/kernel/irq.h    |    1 +
 arch/sparc/kernel/irq_32.c |   28 +++++++++++++++++++++++-----
 2 files changed, 24 insertions(+), 5 deletions(-)

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
index 9ce6b97..f698f07 100644
--- a/arch/sparc/kernel/irq_32.c
+++ b/arch/sparc/kernel/irq_32.c
@@ -105,12 +105,12 @@ EXPORT_SYMBOL(arch_local_irq_restore);
  * Sun4d complicates things even further.  IRQ numbers are arbitrary
  * 32-bit values in that case.  Since this is similar to sparc64,
  * we adopt a virtual IRQ numbering scheme as is done there.
- * Virutal interrupt numbers are allocated by build_irq().  So NR_IRQS
+ * Virtual interrupt numbers are allocated by build_irq().  So NR_IRQS
  * just becomes a limit of how many interrupt sources we can handle in
  * a single system.  Even fully loaded SS2000 machines top off at
  * about 32 interrupt sources or so, therefore a NR_IRQS value of 64
  * is more than enough.
-  *
+ *
  * We keep a map of per-PIL enable interrupts.  These get wired
  * up via the irq_chip->startup() method which gets invoked by
  * the generic IRQ layer during request_irq().
@@ -135,9 +135,13 @@ unsigned int irq_alloc(unsigned int real_irq, 
unsigned int pil)
             return i;
     }
 
-    for (i = 1; i < NR_IRQS; i++) {
-        if (!irq_table[i].irq)
-            break;
+    if (real_irq < NR_IRQS && irq_table[real_irq].irq = 0) {
+        i = real_irq;
+    } else {
+        for (i = 1; i < NR_IRQS; i++) {
+            if (!irq_table[i].irq)
+                break;
+        }
     }
 
     if (i >= NR_IRQS) {
@@ -170,6 +174,20 @@ void irq_link(unsigned int irq)
     irq_map[pil] = p;
 }
 
+void irq_unlink(unsigned int irq)
+{
+    struct irq_bucket *p, **pnext;
+
+    BUG_ON(irq >= NR_IRQS);
+
+    p = &irq_table[irq];
+    BUG_ON(p->pil > SUN4D_MAX_IRQ);
+    pnext = &irq_map[p->pil];
+    while (*pnext != p)
+        pnext = &(*pnext)->next;
+    *pnext = p->next;
+}
+
 int show_interrupts(struct seq_file *p, void *v)
 {
     int i = *(loff_t *) v, j;
-- 
1.6.3.3
