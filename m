From: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Date: Fri, 24 May 2019 01:16:09 +0000
Subject: [RFC PATCH v4 07/21] watchdog/hardlockup: Define a generic function to detect hardlockups
Message-Id: <1558660583-28561-8-git-send-email-ricardo.neri-calderon@linux.intel.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1558660583-28561-1-git-send-email-ricardo.neri-calderon@linux.intel.com>
In-Reply-To: <1558660583-28561-1-git-send-email-ricardo.neri-calderon@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@suse.de>
Cc: Peter Zijlstra <peterz@infradead.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Ricardo Neri <ricardo.neri@intel.com>, Stephane Eranian <eranian@google.com>, Paul Mackerras <paulus@samba.org>, "H. Peter Anvin" <hpa@zytor.com>, sparclinux@vger.kernel.org, Ashok Raj <ashok.raj@intel.com>, Michael Ellerman <mpe@ellerman.id.au>, x86@kernel.org, "Luis R. Rodriguez" <mcgrof@kernel.org>, Andi Kleen <andi.kleen@intel.com>, Don Zickus <dzickus@redhat.com>, "Ravi V. Shankar" <ravi.v.shankar@intel.com>, Ricardo Neri <ricardo.neri-calderon@linux.intel.com>, Frederic Weisbecker <frederic@kernel.org>, Nicholas Piggin <npiggin@gmail.com>, Babu Moger <Babu.Moger@amd.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Tony Luck <tony.luck@intel.com>, Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org, Masami Hiramatsu <mhiramat@kernel.org>, Philippe Ombredanne <pombredanne@nexb.com>, Colin Ian King <colin.king@canonical.com>, Andrew Morton <akpm@linux-foundation.org>, linuxppc-dev@lists.ozlabs.org, "David S. Miller" <davem@davemloft.net>

The procedure to detect hardlockups is independent of the underlying
mechanism that generates the non-maskable interrupt used to drive the
detector. Thus, it can be put in a separate, generic function. In this
manner, it can be invoked by various implementations of the NMI watchdog.

For this purpose, move the bulk of watchdog_overflow_callback() to the
new function inspect_for_hardlockups(). This function can then be called
from the applicable NMI handlers.

Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Ashok Raj <ashok.raj@intel.com>
Cc: Andi Kleen <andi.kleen@intel.com>
Cc: Tony Luck <tony.luck@intel.com>
Cc: Don Zickus <dzickus@redhat.com>
Cc: Nicholas Piggin <npiggin@gmail.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Frederic Weisbecker <frederic@kernel.org>
Cc: Babu Moger <Babu.Moger@amd.com>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Philippe Ombredanne <pombredanne@nexb.com>
Cc: Colin Ian King <colin.king@canonical.com>
Cc: "Luis R. Rodriguez" <mcgrof@kernel.org>
Cc: Stephane Eranian <eranian@google.com>
Cc: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
Cc: "Ravi V. Shankar" <ravi.v.shankar@intel.com>
Cc: x86@kernel.org
Cc: sparclinux@vger.kernel.org
Cc: linuxppc-dev@lists.ozlabs.org
Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
---
 include/linux/nmi.h   |  1 +
 kernel/watchdog_hld.c | 18 +++++++++++-------
 2 files changed, 12 insertions(+), 7 deletions(-)

diff --git a/include/linux/nmi.h b/include/linux/nmi.h
index 9003e29cde46..5a8b19749769 100644
--- a/include/linux/nmi.h
+++ b/include/linux/nmi.h
@@ -212,6 +212,7 @@ extern int proc_watchdog_thresh(struct ctl_table *, int ,
 				void __user *, size_t *, loff_t *);
 extern int proc_watchdog_cpumask(struct ctl_table *, int,
 				 void __user *, size_t *, loff_t *);
+void inspect_for_hardlockups(struct pt_regs *regs);
 
 #ifdef CONFIG_HAVE_ACPI_APEI_NMI
 #include <asm/nmi.h>
diff --git a/kernel/watchdog_hld.c b/kernel/watchdog_hld.c
index 247bf0b1582c..b352e507b17f 100644
--- a/kernel/watchdog_hld.c
+++ b/kernel/watchdog_hld.c
@@ -106,14 +106,8 @@ static struct perf_event_attr wd_hw_attr = {
 	.disabled	= 1,
 };
 
-/* Callback function for perf event subsystem */
-static void watchdog_overflow_callback(struct perf_event *event,
-				       struct perf_sample_data *data,
-				       struct pt_regs *regs)
+void inspect_for_hardlockups(struct pt_regs *regs)
 {
-	/* Ensure the watchdog never gets throttled */
-	event->hw.interrupts = 0;
-
 	if (__this_cpu_read(watchdog_nmi_touch) = true) {
 		__this_cpu_write(watchdog_nmi_touch, false);
 		return;
@@ -163,6 +157,16 @@ static void watchdog_overflow_callback(struct perf_event *event,
 	return;
 }
 
+/* Callback function for perf event subsystem */
+static void watchdog_overflow_callback(struct perf_event *event,
+				       struct perf_sample_data *data,
+				       struct pt_regs *regs)
+{
+	/* Ensure the watchdog never gets throttled */
+	event->hw.interrupts = 0;
+	inspect_for_hardlockups(regs);
+}
+
 static int hardlockup_detector_event_create(void)
 {
 	unsigned int cpu = smp_processor_id();
-- 
2.17.1
