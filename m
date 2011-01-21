From: Sam Ravnborg <sam@ravnborg.org>
Date: Fri, 21 Jan 2011 22:26:55 +0000
Subject: [PATCH 4/5] sparc64: use {get,set}_irq_data for handler_data
Message-Id: <1295648816-29516-4-git-send-email-sam@ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20110121222451.GA29468@merkur.ravnborg.org>
In-Reply-To: <20110121222451.GA29468@merkur.ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "David S. Miller" <davem@davemloft.net>, Thomas Gleixner <tglx@linutronix.de>
Cc: sparclinux <sparclinux@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>, Sam Ravnborg <sam@ravnborg.org>

{get,set}_irq_data uses the member "handler_data" in irq_data
which fits the nae of the datatype
The change has no functional impact and cosmetic only

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
---
 arch/sparc/kernel/irq_64.c |   20 ++++++++++----------
 1 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/arch/sparc/kernel/irq_64.c b/arch/sparc/kernel/irq_64.c
index a763f9a..b07fc79 100644
--- a/arch/sparc/kernel/irq_64.c
+++ b/arch/sparc/kernel/irq_64.c
@@ -277,7 +277,7 @@ static int irq_choose_cpu(unsigned int virt_irq, const struct cpumask *affinity)
 
 static void sun4u_irq_enable(unsigned int virt_irq)
 {
-	struct irq_handler_data *handler_data = get_irq_chip_data(virt_irq);
+	struct irq_handler_data *handler_data = get_irq_data(virt_irq);
 
 	if (likely(handler_data)) {
 		unsigned long cpuid, imap, val;
@@ -301,7 +301,7 @@ static void sun4u_irq_enable(unsigned int virt_irq)
 static int sun4u_set_affinity(unsigned int virt_irq,
 			       const struct cpumask *mask)
 {
-	struct irq_handler_data *handler_data = get_irq_chip_data(virt_irq);
+	struct irq_handler_data *handler_data = get_irq_data(virt_irq);
 
 	if (likely(handler_data)) {
 		unsigned long cpuid, imap, val;
@@ -346,7 +346,7 @@ static void sun4u_irq_disable(unsigned int virt_irq)
 
 static void sun4u_irq_eoi(unsigned int virt_irq)
 {
-	struct irq_handler_data *handler_data = get_irq_chip_data(virt_irq);
+	struct irq_handler_data *handler_data = get_irq_data(virt_irq);
 	struct irq_desc *desc = irq_desc + virt_irq;
 
 	if (unlikely(desc->status & (IRQ_DISABLED|IRQ_INPROGRESS)))
@@ -530,7 +530,7 @@ static struct irq_chip sun4v_virq = {
 static void pre_flow_handler(unsigned int virt_irq,
 				      struct irq_desc *desc)
 {
-	struct irq_handler_data *handler_data = get_irq_chip_data(virt_irq);
+	struct irq_handler_data *handler_data = get_irq_data(virt_irq);
 	unsigned int ino = virt_irq_table[virt_irq].dev_ino;
 
 	handler_data->pre_handler(ino, handler_data->arg1, handler_data->arg2);
@@ -542,7 +542,7 @@ void irq_install_pre_handler(int virt_irq,
 			     void (*func)(unsigned int, void *, void *),
 			     void *arg1, void *arg2)
 {
-	struct irq_handler_data *handler_data = get_irq_chip_data(virt_irq);
+	struct irq_handler_data *handler_data = get_irq_data(virt_irq);
 	struct irq_desc *desc = irq_desc + virt_irq;
 
 	handler_data->pre_handler = func;
@@ -573,7 +573,7 @@ unsigned int build_irq(int inofixup, unsigned long iclr, unsigned long imap)
 					      "IVEC");
 	}
 
-	handler_data = get_irq_chip_data(virt_irq);
+	handler_data = get_irq_data(virt_irq);
 	if (unlikely(handler_data))
 		goto out;
 
@@ -582,7 +582,7 @@ unsigned int build_irq(int inofixup, unsigned long iclr, unsigned long imap)
 		prom_printf("IRQ: kzalloc(irq_handler_data) failed.\n");
 		prom_halt();
 	}
-	set_irq_chip_data(virt_irq, handler_data);
+	set_irq_data(virt_irq, handler_data);
 
 	handler_data->imap  = imap;
 	handler_data->iclr  = iclr;
@@ -610,7 +610,7 @@ static unsigned int sun4v_build_common(unsigned long sysino,
 					      "IVEC");
 	}
 
-	handler_data = get_irq_chip_data(virt_irq);
+	handler_data = get_irq_data(virt_irq);
 	if (unlikely(handler_data))
 		goto out;
 
@@ -619,7 +619,7 @@ static unsigned int sun4v_build_common(unsigned long sysino,
 		prom_printf("IRQ: kzalloc(irq_handler_data) failed.\n");
 		prom_halt();
 	}
-	set_irq_chip_data(virt_irq, handler_data);
+	set_irq_data(virt_irq, handler_data);
 
 	/* Catch accidental accesses to these things.  IMAP/ICLR handling
 	 * is done by hypervisor calls on sun4v platforms, not by direct
@@ -680,7 +680,7 @@ unsigned int sun4v_build_virq(u32 devhandle, unsigned int devino)
 	desc = irq_desc + virt_irq;
 	desc->status |= IRQ_NOAUTOEN;
 
-	set_irq_chip_data(virt_irq, handler_data);
+	set_irq_data(virt_irq, handler_data);
 
 	/* Catch accidental accesses to these things.  IMAP/ICLR handling
 	 * is done by hypervisor calls on sun4v platforms, not by direct
-- 
1.6.0.6

