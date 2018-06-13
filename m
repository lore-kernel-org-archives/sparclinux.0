From: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Date: Wed, 13 Jun 2018 00:57:23 +0000
Subject: [RFC PATCH 03/23] genirq: Introduce IRQF_DELIVER_AS_NMI
Message-Id: <1528851463-21140-4-git-send-email-ricardo.neri-calderon@linux.intel.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1528851463-21140-1-git-send-email-ricardo.neri-calderon@linux.intel.com>
In-Reply-To: <1528851463-21140-1-git-send-email-ricardo.neri-calderon@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>
Cc: Andi Kleen <andi.kleen@intel.com>, Ashok Raj <ashok.raj@intel.com>, Borislav Petkov <bp@suse.de>, Tony Luck <tony.luck@intel.com>, "Ravi V. Shankar" <ravi.v.shankar@intel.com>, x86@kernel.org, sparclinux@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, Ricardo Neri <ricardo.neri-calderon@linux.intel.com>, Jacob Pan <jacob.jun.pan@intel.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Andrew Morton <akpm@linux-foundation.org>, "Levin, Alexander (Sasha Levin)" <alexander.levin@verizon.com>, Randy Dunlap <rdunlap@infradead.org>, Masami Hiramatsu <mhiramat@kernel.org>, Marc Zyngier <marc.zyngier@arm.com>, Bartosz Golaszewski <brgl@bgdev.pl>, Doug Berger <opendmb@gmail.com>, Palmer Dabbelt <palmer@sifive.com>, iommu@lists.linux-found

Certain interrupt controllers (such as APIC) are capable of delivering
interrupts as non-maskable. Likewise, drivers or subsystems (e.g., the
hardlockup detector) might be interested in requesting a non-maskable
interrupt. The new flag IRQF_DELIVER_AS_NMI serves this purpose.

When setting up an interrupt, non-maskable delivery will be set in the
interrupt state data only if supported by the underlying interrupt
controller chips.

Interrupt controller chips can declare that they support non-maskable
delivery by using the new flag IRQCHIP_CAN_DELIVER_AS_NMI.

Cc: Ashok Raj <ashok.raj@intel.com>
Cc: Andi Kleen <andi.kleen@intel.com>
Cc: Tony Luck <tony.luck@intel.com>
Cc: Borislav Petkov <bp@suse.de>
Cc: Jacob Pan <jacob.jun.pan@intel.com>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: "Levin, Alexander (Sasha Levin)" <alexander.levin@verizon.com>
Cc: Randy Dunlap <rdunlap@infradead.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Marc Zyngier <marc.zyngier@arm.com>
Cc: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Doug Berger <opendmb@gmail.com>
Cc: Palmer Dabbelt <palmer@sifive.com>
Cc: "Ravi V. Shankar" <ravi.v.shankar@intel.com>
Cc: x86@kernel.org
Cc: iommu@lists.linux-foundation.org
Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
---
 include/linux/interrupt.h |  3 +++
 include/linux/irq.h       |  3 +++
 kernel/irq/manage.c       | 22 +++++++++++++++++++++-
 3 files changed, 27 insertions(+), 1 deletion(-)

diff --git a/include/linux/interrupt.h b/include/linux/interrupt.h
index 5426627..dbc5e02 100644
--- a/include/linux/interrupt.h
+++ b/include/linux/interrupt.h
@@ -61,6 +61,8 @@
  *                interrupt handler after suspending interrupts. For system
  *                wakeup devices users need to implement wakeup detection in
  *                their interrupt handlers.
+ * IRQF_DELIVER_AS_NMI - Configure interrupt to be delivered as non-maskable, if
+ *                supported by the chip.
  */
 #define IRQF_SHARED		0x00000080
 #define IRQF_PROBE_SHARED	0x00000100
@@ -74,6 +76,7 @@
 #define IRQF_NO_THREAD		0x00010000
 #define IRQF_EARLY_RESUME	0x00020000
 #define IRQF_COND_SUSPEND	0x00040000
+#define IRQF_DELIVER_AS_NMI	0x00080000
 
 #define IRQF_TIMER		(__IRQF_TIMER | IRQF_NO_SUSPEND | IRQF_NO_THREAD)
 
diff --git a/include/linux/irq.h b/include/linux/irq.h
index 7271a2c..d2520ae 100644
--- a/include/linux/irq.h
+++ b/include/linux/irq.h
@@ -515,6 +515,8 @@ struct irq_chip {
  * IRQCHIP_SKIP_SET_WAKE:	Skip chip.irq_set_wake(), for this irq chip
  * IRQCHIP_ONESHOT_SAFE:	One shot does not require mask/unmask
  * IRQCHIP_EOI_THREADED:	Chip requires eoi() on unmask in threaded mode
+ * IRQCHIP_CAN_DELIVER_AS_NMI	Chip can deliver interrupts it receives as non-
+ *				maskable.
  */
 enum {
 	IRQCHIP_SET_TYPE_MASKED		= (1 <<  0),
@@ -524,6 +526,7 @@ enum {
 	IRQCHIP_SKIP_SET_WAKE		= (1 <<  4),
 	IRQCHIP_ONESHOT_SAFE		= (1 <<  5),
 	IRQCHIP_EOI_THREADED		= (1 <<  6),
+	IRQCHIP_CAN_DELIVER_AS_NMI	= (1 <<  7),
 };
 
 #include <linux/irqdesc.h>
diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
index e3336d9..d058aa8 100644
--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -1137,7 +1137,7 @@ __setup_irq(unsigned int irq, struct irq_desc *desc, struct irqaction *new)
 {
 	struct irqaction *old, **old_ptr;
 	unsigned long flags, thread_mask = 0;
-	int ret, nested, shared = 0;
+	int ret, nested, shared = 0, deliver_as_nmi = 0;
 
 	if (!desc)
 		return -EINVAL;
@@ -1156,6 +1156,16 @@ __setup_irq(unsigned int irq, struct irq_desc *desc, struct irqaction *new)
 	if (!(new->flags & IRQF_TRIGGER_MASK))
 		new->flags |= irqd_get_trigger_type(&desc->irq_data);
 
+	/* Only deliver as non-maskable interrupt if supported by chip. */
+	if (new->flags & IRQF_DELIVER_AS_NMI) {
+		if (desc->irq_data.chip->flags & IRQCHIP_CAN_DELIVER_AS_NMI) {
+			irqd_set_deliver_as_nmi(&desc->irq_data);
+			deliver_as_nmi = 1;
+		} else {
+			return -EINVAL;
+		}
+	}
+
 	/*
 	 * Check whether the interrupt nests into another interrupt
 	 * thread.
@@ -1166,6 +1176,13 @@ __setup_irq(unsigned int irq, struct irq_desc *desc, struct irqaction *new)
 			ret = -EINVAL;
 			goto out_mput;
 		}
+
+		/* Don't allow nesting if interrupt will be delivered as NMI. */
+		if (deliver_as_nmi) {
+			ret = -EINVAL;
+			goto out_mput;
+		}
+
 		/*
 		 * Replace the primary handler which was provided from
 		 * the driver for non nested interrupt handling by the
@@ -1186,6 +1203,9 @@ __setup_irq(unsigned int irq, struct irq_desc *desc, struct irqaction *new)
 	 * thread.
 	 */
 	if (new->thread_fn && !nested) {
+		if (deliver_as_nmi)
+			goto out_mput;
+
 		ret = setup_irq_thread(new, irq, false);
 		if (ret)
 			goto out_mput;
-- 
2.7.4

