From: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Date: Wed, 13 Jun 2018 00:57:37 +0000
Subject: [RFC PATCH 17/23] watchdog/hardlockup/hpet: Convert the timer's interrupt to NMI
Message-Id: <1528851463-21140-18-git-send-email-ricardo.neri-calderon@linux.intel.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1528851463-21140-1-git-send-email-ricardo.neri-calderon@linux.intel.com>
In-Reply-To: <1528851463-21140-1-git-send-email-ricardo.neri-calderon@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>
Cc: Andi Kleen <andi.kleen@intel.com>, Ashok Raj <ashok.raj@intel.com>, Borislav Petkov <bp@suse.de>, Tony Luck <tony.luck@intel.com>, "Ravi V. Shankar" <ravi.v.shankar@intel.com>, x86@kernel.org, sparclinux@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, Ricardo Neri <ricardo.neri-calderon@linux.intel.com>, Jacob Pan <jacob.jun.pan@intel.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Don Zickus <dzickus@redhat.com>, Nicholas Piggin <npiggin@gmail.com>, Michael Ellerman <mpe@ellerman.id.au>, Frederic Weisbecker <frederic@kernel.org>, Alexei Starovoitov <ast@kernel.org>, Babu Moger <babu.moger@oracle.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Masami Hiramatsu <mhiramat@kernel.org>, Peter Zijlstra <peterz@infra>

In order to detect hardlockups, it is necessary to have the ability to
receive interrupts even when disabled: a non-maskable interrupt is
required. Add the flag IRQF_DELIVER_AS_NMI to the arguments of
request_irq() for this purpose.

Note that the timer, when programmed to deliver interrupts via the IO APIC
is programmed as level-triggered. This is to have an indication that the
NMI comes from HPET timer as indicated in the General Status Interrupt
Register. However, NMIs are always edge-triggered, thus a GSI edge-
triggered interrupt is now requested.

An NMI handler is also implemented. The handler looks for hardlockups and
kicks the timer.

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
 arch/x86/kernel/hpet.c     |  2 +-
 kernel/watchdog_hld_hpet.c | 55 +++++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 55 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/hpet.c b/arch/x86/kernel/hpet.c
index fda6e19..5ca1953 100644
--- a/arch/x86/kernel/hpet.c
+++ b/arch/x86/kernel/hpet.c
@@ -205,7 +205,7 @@ int hpet_hardlockup_detector_assign_legacy_irq(struct hpet_hld_data *hdata)
 			break;
 		}
 
-		gsi = acpi_register_gsi(NULL, hwirq, ACPI_LEVEL_SENSITIVE,
+		gsi = acpi_register_gsi(NULL, hwirq, ACPI_EDGE_SENSITIVE,
 					ACPI_ACTIVE_LOW);
 		if (gsi > 0)
 			break;
diff --git a/kernel/watchdog_hld_hpet.c b/kernel/watchdog_hld_hpet.c
index 8fa4e55..3bedffa 100644
--- a/kernel/watchdog_hld_hpet.c
+++ b/kernel/watchdog_hld_hpet.c
@@ -10,6 +10,7 @@
 #include <linux/nmi.h>
 #include <linux/hpet.h>
 #include <asm/hpet.h>
+#include <asm/irq_remapping.h>
 
 #undef pr_fmt
 #define pr_fmt(fmt) "NMI hpet watchdog: " fmt
@@ -183,6 +184,8 @@ static irqreturn_t hardlockup_detector_irq_handler(int irq, void *data)
 	if (!(hdata->flags & HPET_DEV_PERI_CAP))
 		kick_timer(hdata);
 
+	pr_err("This interrupt should not have happened. Ensure delivery mode is NMI.\n");
+
 	/* Acknowledge interrupt if in level-triggered mode */
 	if (!use_fsb)
 		hpet_writel(BIT(hdata->num), HPET_STATUS);
@@ -191,6 +194,47 @@ static irqreturn_t hardlockup_detector_irq_handler(int irq, void *data)
 }
 
 /**
+ * hardlockup_detector_nmi_handler() - NMI Interrupt handler
+ * @val:	Attribute associated with the NMI. Not used.
+ * @regs:	Register values as seen when the NMI was asserted
+ *
+ * When an NMI is issued, look for hardlockups. If the timer is not periodic,
+ * kick it. The interrupt is always handled when if delivered via the
+ * Front-Side Bus.
+ *
+ * Returns:
+ *
+ * NMI_DONE if the HPET timer did not cause the interrupt. NMI_HANDLED
+ * otherwise.
+ */
+static int hardlockup_detector_nmi_handler(unsigned int val,
+					   struct pt_regs *regs)
+{
+	struct hpet_hld_data *hdata = hld_data;
+	unsigned int use_fsb;
+
+	/*
+	 * If FSB delivery mode is used, the timer interrupt is programmed as
+	 * edge-triggered and there is no need to check the ISR register.
+	 */
+	use_fsb = hdata->flags & HPET_DEV_FSB_CAP;
+
+	if (!use_fsb && !is_hpet_wdt_interrupt(hdata))
+		return NMI_DONE;
+
+	inspect_for_hardlockups(regs);
+
+	if (!(hdata->flags & HPET_DEV_PERI_CAP))
+		kick_timer(hdata);
+
+	/* Acknowledge interrupt if in level-triggered mode */
+	if (!use_fsb)
+		hpet_writel(BIT(hdata->num), HPET_STATUS);
+
+	return NMI_HANDLED;
+}
+
+/**
  * setup_irq_msi_mode() - Configure the timer to deliver an MSI interrupt
  * @data:	Data associated with the instance of the HPET timer to configure
  *
@@ -282,11 +326,20 @@ static int setup_hpet_irq(struct hpet_hld_data *hdata)
 	if (ret)
 		return ret;
 
+	/* Register the NMI handler, which will be the actual handler we use. */
+	ret = register_nmi_handler(NMI_LOCAL, hardlockup_detector_nmi_handler,
+				   0, "hpet_hld");
+	if (ret)
+		return ret;
+
 	/*
 	 * Request an interrupt to activate the irq in all the needed domains.
 	 */
 	ret = request_irq(hwirq, hardlockup_detector_irq_handler,
-			  IRQF_TIMER, "hpet_hld", hdata);
+			  IRQF_TIMER | IRQF_DELIVER_AS_NMI,
+			  "hpet_hld", hdata);
+	if (ret)
+		unregister_nmi_handler(NMI_LOCAL, "hpet_hld");
 
 	return ret;
 }
-- 
2.7.4

