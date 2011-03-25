From: Thomas Gleixner <tglx@linutronix.de>
Date: Fri, 25 Mar 2011 14:10:47 +0000
Subject: [patch 4/4] sparc: Use generic show_interrupts()
Message-Id: <20110325140947.231703709@linutronix.de>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: sparclinux@vger.kernel.org
---
 arch/sparc/Kconfig         |    1 +
 arch/sparc/kernel/irq_64.c |   45 +++++-----------------------------------=
-----
 2 files changed, 6 insertions(+), 40 deletions(-)

Index: linux-2.6-tip/arch/sparc/Kconfig
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D--- linux-2.6-tip.orig/arch/sparc/Kconfig
+++ linux-2.6-tip/arch/sparc/Kconfig
@@ -52,6 +52,7 @@ config SPARC64
 	select PERF_USE_VMALLOC
 	select HAVE_GENERIC_HARDIRQS
 	select GENERIC_HARDIRQS_NO_DEPRECATED
+	select GENERIC_IRQ_SHOW
 	select IRQ_PREFLOW_FASTEOI
=20
 config ARCH_DEFCONFIG
Index: linux-2.6-tip/arch/sparc/kernel/irq_64.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D--- linux-2.6-tip.orig/arch/sparc/kernel/irq_64.c
+++ linux-2.6-tip/arch/sparc/kernel/irq_64.c
@@ -162,47 +162,12 @@ void irq_free(unsigned int irq)
 /*
  * /proc/interrupts printing:
  */
-
-int show_interrupts(struct seq_file *p, void *v)
+int arch_show_interrupts(struct seq_file *p, int prec)
 {
-	int i =3D *(loff_t *) v, j;
-	struct irqaction * action;
-	unsigned long flags;
-
-	if (i =3D 0) {
-		seq_printf(p, "           ");
-		for_each_online_cpu(j)
-			seq_printf(p, "CPU%d       ",j);
-		seq_putc(p, '\n');
-	}
-
-	if (i < NR_IRQS) {
-		raw_spin_lock_irqsave(&irq_desc[i].lock, flags);
-		action =3D irq_desc[i].action;
-		if (!action)
-			goto skip;
-		seq_printf(p, "%3d: ",i);
-#ifndef CONFIG_SMP
-		seq_printf(p, "%10u ", kstat_irqs(i));
-#else
-		for_each_online_cpu(j)
-			seq_printf(p, "%10u ", kstat_irqs_cpu(i, j));
-#endif
-		seq_printf(p, " %9s", irq_desc[i].irq_data.chip->name);
-		seq_printf(p, "  %s", action->name);
-
-		for (action=ACtion->next; action; action =3D action->next)
-			seq_printf(p, ", %s", action->name);
-
-		seq_putc(p, '\n');
-skip:
-		raw_spin_unlock_irqrestore(&irq_desc[i].lock, flags);
-	} else if (i =3D NR_IRQS) {
-		seq_printf(p, "NMI: ");
-		for_each_online_cpu(j)
-			seq_printf(p, "%10u ", cpu_data(j).__nmi_count);
-		seq_printf(p, "     Non-maskable interrupts\n");
-	}
+	seq_printf(p, "NMI: ");
+	for_each_online_cpu(j)
+		seq_printf(p, "%10u ", cpu_data(j).__nmi_count);
+	seq_printf(p, "     Non-maskable interrupts\n");
 	return 0;
 }
=20


