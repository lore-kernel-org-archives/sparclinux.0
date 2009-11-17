From: Thomas Gleixner <tglx@linutronix.de>
Date: Tue, 17 Nov 2009 22:50:40 +0000
Subject: [patch 04/13] sparc: Fixup last users of irq_chip->typename
Message-Id: <20091117224916.491090342@linutronix.de>
List-Id: <sparclinux.vger.kernel.org>
References: <20091117224852.846805939@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: LKML <linux-kernel@vger.kernel.org>
Cc: Ingo Molnar <mingo@elte.hu>, "David S. Miller" <davem@davemloft.net>, sparclinux@vger.kernel.org

The typename member of struct irq_chip was kept for migration purposes
and is obsolete since more than 2 years. Fix up the leftovers.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: David S. Miller <davem@davemloft.net>
Cc: sparclinux@vger.kernel.org
---
 arch/sparc/kernel/irq_64.c  |    8 ++++----
 arch/sparc/kernel/pci_msi.c |    2 +-
 2 files changed, 5 insertions(+), 5 deletions(-)

Index: linux-2.6/arch/sparc/kernel/irq_64.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D--- linux-2.6.orig/arch/sparc/kernel/irq_64.c
+++ linux-2.6/arch/sparc/kernel/irq_64.c
@@ -187,7 +187,7 @@ int show_interrupts(struct seq_file *p,=20
 		for_each_online_cpu(j)
 			seq_printf(p, "%10u ", kstat_irqs_cpu(i, j));
 #endif
-		seq_printf(p, " %9s", irq_desc[i].chip->typename);
+		seq_printf(p, " %9s", irq_desc[i].chip->name);
 		seq_printf(p, "  %s", action->name);
=20
 		for (action=ACtion->next; action; action =3D action->next)
@@ -484,7 +484,7 @@ static void sun4v_virq_eoi(unsigned int=20
 }
=20
 static struct irq_chip sun4u_irq =3D {
-	.typename	=3D "sun4u",
+	.name		=3D "sun4u",
 	.enable		=3D sun4u_irq_enable,
 	.disable	=3D sun4u_irq_disable,
 	.eoi		=3D sun4u_irq_eoi,
@@ -492,7 +492,7 @@ static struct irq_chip sun4u_irq =3D {
 };
=20
 static struct irq_chip sun4v_irq =3D {
-	.typename	=3D "sun4v",
+	.name		=3D "sun4v",
 	.enable		=3D sun4v_irq_enable,
 	.disable	=3D sun4v_irq_disable,
 	.eoi		=3D sun4v_irq_eoi,
@@ -500,7 +500,7 @@ static struct irq_chip sun4v_irq =3D {
 };
=20
 static struct irq_chip sun4v_virq =3D {
-	.typename	=3D "vsun4v",
+	.name		=3D "vsun4v",
 	.enable		=3D sun4v_virq_enable,
 	.disable	=3D sun4v_virq_disable,
 	.eoi		=3D sun4v_virq_eoi,
Index: linux-2.6/arch/sparc/kernel/pci_msi.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D--- linux-2.6.orig/arch/sparc/kernel/pci_msi.c
+++ linux-2.6/arch/sparc/kernel/pci_msi.c
@@ -112,7 +112,7 @@ static void free_msi(struct pci_pbm_info
 }
=20
 static struct irq_chip msi_irq =3D {
-	.typename	=3D "PCI-MSI",
+	.name		=3D "PCI-MSI",
 	.mask		=3D mask_msi_irq,
 	.unmask		=3D unmask_msi_irq,
 	.enable		=3D unmask_msi_irq,


