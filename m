From: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Date: Wed, 13 Jun 2018 00:57:36 +0000
Subject: [RFC PATCH 16/23] watchdog/hardlockup: Add an HPET-based hardlockup detector
Message-Id: <1528851463-21140-17-git-send-email-ricardo.neri-calderon@linux.intel.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1528851463-21140-1-git-send-email-ricardo.neri-calderon@linux.intel.com>
In-Reply-To: <1528851463-21140-1-git-send-email-ricardo.neri-calderon@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>
Cc: Andi Kleen <andi.kleen@intel.com>, Ashok Raj <ashok.raj@intel.com>, Borislav Petkov <bp@suse.de>, Tony Luck <tony.luck@intel.com>, "Ravi V. Shankar" <ravi.v.shankar@intel.com>, x86@kernel.org, sparclinux@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, Ricardo Neri <ricardo.neri-calderon@linux.intel.com>, Jacob Pan <jacob.jun.pan@intel.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Don Zickus <dzickus@redhat.com>, Nicholas Piggin <npiggin@gmail.com>, Michael Ellerman <mpe@ellerman.id.au>, Frederic Weisbecker <frederic@kernel.org>, Alexei Starovoitov <ast@kernel.org>, Babu Moger <babu.moger@oracle.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Masami Hiramatsu <mhiramat@kernel.org>, Peter Zijlstra <peterz@infra>

This is the initial implementation of a hardlockup detector driven by an
HPET timer. This initial implementation includes functions to control
the timer via its registers. It also requests such timer, installs
a minimal interrupt handler and performs the initial configuration of
the timer.

The detector is not functional at this stage. Subsequent changesets will
populate the NMI watchdog operations and register it with the lockup
detector.

This detector depends on HPET_TIMER since platform code performs the
initialization of the timer and maps its registers to memory. It depends
on HPET to compute the ticks per second of the timer.

Cc: Ashok Raj <ashok.raj@intel.com>
Cc: Andi Kleen <andi.kleen@intel.com>
Cc: Tony Luck <tony.luck@intel.com>
Cc: Borislav Petkov <bp@suse.de>
Cc: Jacob Pan <jacob.jun.pan@intel.com>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Cc: Don Zickus <dzickus@redhat.com>
Cc: Nicholas Piggin <npiggin@gmail.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Frederic Weisbecker <frederic@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Babu Moger <babu.moger@oracle.com>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Philippe Ombredanne <pombredanne@nexb.com>
Cc: Colin Ian King <colin.king@canonical.com>
Cc: Byungchul Park <byungchul.park@lge.com>
Cc: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc: "Luis R. Rodriguez" <mcgrof@kernel.org>
Cc: Waiman Long <longman@redhat.com>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Randy Dunlap <rdunlap@infradead.org>
Cc: Davidlohr Bueso <dave@stgolabs.net>
Cc: Christoffer Dall <cdall@linaro.org>
Cc: Marc Zyngier <marc.zyngier@arm.com>
Cc: Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc: David Rientjes <rientjes@google.com>
Cc: "Ravi V. Shankar" <ravi.v.shankar@intel.com>
Cc: x86@kernel.org
Cc: iommu@lists.linux-foundation.org
Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
---
 kernel/Makefile            |   1 +
 kernel/watchdog_hld_hpet.c | 334 +++++++++++++++++++++++++++++++++++++++++++++
 lib/Kconfig.debug          |  10 ++
 3 files changed, 345 insertions(+)
 create mode 100644 kernel/watchdog_hld_hpet.c

diff --git a/kernel/Makefile b/kernel/Makefile
index 0a0d86d..73c79b2 100644
--- a/kernel/Makefile
+++ b/kernel/Makefile
@@ -86,6 +86,7 @@ obj-$(CONFIG_KGDB) += debug/
 obj-$(CONFIG_DETECT_HUNG_TASK) += hung_task.o
 obj-$(CONFIG_LOCKUP_DETECTOR) += watchdog.o
 obj-$(CONFIG_HARDLOCKUP_DETECTOR_PERF) += watchdog_hld.o watchdog_hld_perf.o
+obj-$(CONFIG_HARDLOCKUP_DETECTOR_HPET) += watchdog_hld.o watchdog_hld_hpet.o
 obj-$(CONFIG_SECCOMP) += seccomp.o
 obj-$(CONFIG_RELAY) += relay.o
 obj-$(CONFIG_SYSCTL) += utsname_sysctl.o
diff --git a/kernel/watchdog_hld_hpet.c b/kernel/watchdog_hld_hpet.c
new file mode 100644
index 0000000..8fa4e55
--- /dev/null
+++ b/kernel/watchdog_hld_hpet.c
@@ -0,0 +1,334 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * A hardlockup detector driven by an HPET timer.
+ *
+ * Copyright (C) Intel Corporation 2018
+ */
+
+#define pr_fmt(fmt) "NMI hpet watchdog: " fmt
+
+#include <linux/nmi.h>
+#include <linux/hpet.h>
+#include <asm/hpet.h>
+
+#undef pr_fmt
+#define pr_fmt(fmt) "NMI hpet watchdog: " fmt
+
+static struct hpet_hld_data *hld_data;
+
+/**
+ * get_count() - Get the current count of the HPET timer
+ *
+ * Returns:
+ *
+ * Value of the main counter of the HPET timer
+ */
+static inline unsigned long get_count(void)
+{
+	return hpet_readq(HPET_COUNTER);
+}
+
+/**
+ * set_comparator() - Update the comparator in an HPET timer instance
+ * @hdata:	A data structure with the timer instance to update
+ * @cmp:	The value to write in the in the comparator registere
+ *
+ * Returns:
+ *
+ * None
+ */
+static inline void set_comparator(struct hpet_hld_data *hdata,
+				  unsigned long cmp)
+{
+	hpet_writeq(cmp, HPET_Tn_CMP(hdata->num));
+}
+
+/**
+ * kick_timer() - Reprogram timer to expire in the future
+ * @hdata:	A data structure with the timer instance to update
+ *
+ * Reprogram the timer to expire within watchdog_thresh seconds in the future.
+ *
+ * Returns:
+ *
+ * None
+ */
+static void kick_timer(struct hpet_hld_data *hdata)
+{
+	unsigned long new_compare, count;
+
+	/*
+	 * Update the comparator in increments of watch_thresh seconds relative
+	 * to the current count. Since watch_thresh is given in seconds, we
+	 * are able to update the comparator before the counter reaches such new
+	 * value.
+	 *
+	 * Let it wrap around if needed.
+	 */
+	count = get_count();
+
+	new_compare = count + watchdog_thresh * hdata->ticks_per_second;
+
+	set_comparator(hdata, new_compare);
+}
+
+/**
+ * disable() - Disable an HPET timer instance
+ * @hdata:	A data structure with the timer instance to disable
+ *
+ * Returns:
+ *
+ * None
+ */
+static void disable(struct hpet_hld_data *hdata)
+{
+	unsigned int v;
+
+	v = hpet_readl(HPET_Tn_CFG(hdata->num));
+	v &= ~HPET_TN_ENABLE;
+	hpet_writel(v, HPET_Tn_CFG(hdata->num));
+}
+
+/**
+ * enable() - Enable an HPET timer instance
+ * @hdata:	A data structure with the timer instance to enable
+ *
+ * Returns:
+ *
+ * None
+ */
+static void enable(struct hpet_hld_data *hdata)
+{
+	unsigned long v;
+
+	/* Clear any previously active interrupt. */
+	hpet_writel(BIT(hdata->num), HPET_STATUS);
+
+	v = hpet_readl(HPET_Tn_CFG(hdata->num));
+	v |= HPET_TN_ENABLE;
+	hpet_writel(v, HPET_Tn_CFG(hdata->num));
+}
+
+/**
+ * set_periodic() - Set an HPET timer instance in periodic mode
+ * @hdata:	A data structure with the timer instance to enable
+ *
+ * If the timer supports periodic mode, configure it in such mode.
+ * Returns:
+ *
+ * None
+ */
+static void set_periodic(struct hpet_hld_data *hdata)
+{
+	unsigned long v;
+
+	v = hpet_readl(HPET_Tn_CFG(hdata->num));
+	if (v & HPET_TN_PERIODIC_CAP) {
+		v |= HPET_TN_PERIODIC;
+		hpet_writel(v, HPET_Tn_CFG(hdata->num));
+		hdata->flags |= HPET_DEV_PERI_CAP;
+	}
+}
+
+/**
+ * is_hpet_wdt_interrupt() - Determine if an HPET timer caused interrupt
+ * @hdata:	A data structure with the timer instance to enable
+ *
+ * To be used when the timer is programmed in level-triggered mode, determine
+ * if an instance of an HPET timer indicates that it asserted an interrupt by
+ * checking the status register.
+ *
+ * Returns:
+ *
+ * True if a level-triggered timer asserted an interrupt. False otherwise.
+ */
+static bool is_hpet_wdt_interrupt(struct hpet_hld_data *hdata)
+{
+	unsigned long this_isr;
+	unsigned int lvl_trig;
+
+	this_isr = hpet_readl(HPET_STATUS) & BIT(hdata->num);
+
+	lvl_trig = hpet_readl(HPET_Tn_CFG(hdata->num)) & HPET_TN_LEVEL;
+
+	if (lvl_trig && this_isr)
+		return true;
+
+	return false;
+}
+
+/**
+ * hardlockup_detector_irq_handler() - Interrupt handler
+ * @irq:	Interrupt number
+ * @data:	Data associated with the interrupt
+ *
+ * A simple interrupt handler. Simply kick the timer and acknowledge the
+ * interrupt.
+ *
+ * Returns:
+ *
+ * IRQ_NONE if the HPET timer did not cause the interrupt. IRQ_HANDLED
+ * otherwise.
+ */
+static irqreturn_t hardlockup_detector_irq_handler(int irq, void *data)
+{
+	struct hpet_hld_data *hdata = data;
+	unsigned int use_fsb;
+
+	use_fsb = hdata->flags & HPET_DEV_FSB_CAP;
+
+	if (!use_fsb && !is_hpet_wdt_interrupt(hdata))
+		return IRQ_NONE;
+
+	if (!(hdata->flags & HPET_DEV_PERI_CAP))
+		kick_timer(hdata);
+
+	/* Acknowledge interrupt if in level-triggered mode */
+	if (!use_fsb)
+		hpet_writel(BIT(hdata->num), HPET_STATUS);
+
+	return IRQ_HANDLED;
+}
+
+/**
+ * setup_irq_msi_mode() - Configure the timer to deliver an MSI interrupt
+ * @data:	Data associated with the instance of the HPET timer to configure
+ *
+ * Configure an instance of the HPET timer to deliver interrupts via the Front-
+ * Side Bus.
+ *
+ * Returns:
+ *
+ * 0 success. An error code in configuration was unsuccessful.
+ */
+static int setup_irq_msi_mode(struct hpet_hld_data *hdata)
+{
+	unsigned int v;
+
+	v = hpet_readl(HPET_Tn_CFG(hdata->num));
+
+	/*
+	 * If FSB interrupt delivery is used, configure as edge-triggered
+	 * interrupt. We are certain the interrupt comes from the HPET timer as
+	 * we receive the MSI message.
+	 *
+	 * Also, the FSB delivery mode and the FSB route are configured when the
+	 * interrupt is unmasked.
+	 */
+	v &= ~HPET_TN_LEVEL;
+
+	hpet_writel(v, HPET_Tn_CFG(hdata->num));
+
+	return 0;
+}
+
+/**
+ * setup_irq_legacy_mode() - Configure the timer to deliver an pin interrupt
+ * @data:	Data associated with the instance of the HPET timer to configure
+ *
+ * Configure an instance of the HPET timer to deliver interrupts via a pin of
+ * the IO APIC.
+ *
+ * Returns:
+ *
+ * 0 success. An error code in configuration was unsuccessful.
+ */
+static int setup_irq_legacy_mode(struct hpet_hld_data *hdata)
+{
+	int hwirq = hdata->irq;
+	unsigned long v;
+
+	v = hpet_readl(HPET_Tn_CFG(hdata->num));
+
+	v |= hwirq << HPET_TN_ROUTE_SHIFT;
+	hpet_writel(v, HPET_Tn_CFG(hdata->num));
+
+	/*
+	 * If IO APIC interrupt delivery is used, configure as level-triggered.
+	 * In this way, the ISR register can be used to determine if this HPET
+	 * timer caused the interrupt at the IO APIC pin.
+	 */
+	v |= HPET_TN_LEVEL;
+
+	/* Disable Front-Side Bus delivery. */
+	v &= ~HPET_TN_FSB;
+
+	hpet_writel(v, HPET_Tn_CFG(hdata->num));
+
+	return 0;
+}
+
+/**
+ * setup_hpet_irq() - Configure the interrupt delivery of an HPET timer
+ * @data:	Data associated with the instance of the HPET timer to configure
+ *
+ * Configure the interrupt parameters of an HPET timer. If supported, configure
+ * interrupts to be delivered via the Front-Side Bus. Also, install an interrupt
+ * handler.
+ *
+ * Returns:
+ *
+ * 0 success. An error code in configuration was unsuccessful.
+ */
+static int setup_hpet_irq(struct hpet_hld_data *hdata)
+{
+	int hwirq = hdata->irq, ret;
+
+	if (hdata->flags & HPET_DEV_FSB_CAP)
+		ret = setup_irq_msi_mode(hdata);
+	else
+		ret = setup_irq_legacy_mode(hdata);
+
+	if (ret)
+		return ret;
+
+	/*
+	 * Request an interrupt to activate the irq in all the needed domains.
+	 */
+	ret = request_irq(hwirq, hardlockup_detector_irq_handler,
+			  IRQF_TIMER, "hpet_hld", hdata);
+
+	return ret;
+}
+
+/**
+ * hardlockup_detector_hpet_init() - Initialize the hardlockup detector
+ *
+ * Only initialize and configure the detector if an HPET is available on the
+ * system.
+ *
+ * Returns:
+ *
+ * 0 success. An error code if initialization was unsuccessful.
+ */
+static int __init hardlockup_detector_hpet_init(void)
+{
+	int ret;
+
+	if (!is_hpet_enabled())
+		return -ENODEV;
+
+	hld_data = hpet_hardlockup_detector_assign_timer();
+	if (!hld_data)
+		return -ENODEV;
+
+	/* Disable before configuring. */
+	disable(hld_data);
+
+	set_periodic(hld_data);
+
+	/* Set timer for the first time relative to the current count. */
+	kick_timer(hld_data);
+
+	ret = setup_hpet_irq(hld_data);
+	if (ret)
+		return -ENODEV;
+
+	/*
+	 * Timer might have been enabled when the interrupt was unmasked.
+	 * This should be done via the .enable operation.
+	 */
+	disable(hld_data);
+
+	return 0;
+}
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index c40c7b7..6e79833 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -828,6 +828,16 @@ config HARDLOCKUP_DETECTOR_PERF
 	bool
 	select SOFTLOCKUP_DETECTOR
 
+config HARDLOCKUP_DETECTOR_HPET
+	bool "Use HPET Timer for Hard Lockup Detection"
+	select SOFTLOCKUP_DETECTOR
+	select HARDLOCKUP_DETECTOR
+	depends on HPET_TIMER && HPET
+	help
+	  Say y to enable a hardlockup detector that is driven by an High-Precision
+	  Event Timer. In addition to selecting this option, the command-line
+	  parameter nmi_watchdog option. See Documentation/admin-guide/kernel-parameters.rst
+
 #
 # Enables a timestamp based low pass filter to compensate for perf based
 # hard lockup detection which runs too fast due to turbo modes.
-- 
2.7.4

