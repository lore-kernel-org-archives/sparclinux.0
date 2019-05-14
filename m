From: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Date: Tue, 14 May 2019 14:02:03 +0000
Subject: [RFC PATCH v3 10/21] watchdog/hardlockup: Add function to enable NMI watchdog on all allowed CPUs at
Message-Id: <1557842534-4266-11-git-send-email-ricardo.neri-calderon@linux.intel.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1557842534-4266-1-git-send-email-ricardo.neri-calderon@linux.intel.com>
In-Reply-To: <1557842534-4266-1-git-send-email-ricardo.neri-calderon@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@suse.de>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Peter Zijlstra <peterz@infradead.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Alexei Starovoitov <ast@kernel.org>, Stephane Eranian <eranian@google.com>, Kai-Heng Feng <kai.heng.feng@canonical.com>, Paul Mackerras <paulus@samba.org>, "H. Peter Anvin" <hpa@zytor.com>, sparclinux@vger.kernel.org, Davidlohr Bueso <dave@stgolabs.net>, Ashok Raj <ashok.raj@intel.com>, Michael Ellerman <mpe@ellerman.id.au>, x86@kernel.org, "Luis R. Rodriguez" <mcgrof@kernel.org>, David Rientjes <rientjes@google.com>, Andi Kleen <andi.kleen@intel.com>, Waiman Long <longman@redhat.com>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Don Zickus <dzickus@redhat.com>, "Ravi V. Shankar" <ravi.v.shankar@intel.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Marc Zyngier <marc.zyngier@arm.com>, Ricardo Neri <ricardo.neri-calderon@linux.intel.com>, Frederic Weisbecker <frederic@kernel.org>, Nicholas Piggin <npiggin@gmail.com>, Ricardo Neri <ricardo.neri@intel.com>, Byungchul Park <byungchul.park@lge.com>, Babu Moger <Babu.Moger@amd.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Josh Poimboeuf <jpoimboe@redhat.com>, Tony Luck <tony.luck@intel.com>, Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org, Masami Hiramatsu <mhiramat@kernel.org>, Philippe Ombredanne <pombredanne@nexb.com>, Colin Ian King <colin.king@canonical.com>, Andrew Morton <akpm@linux-foundation.org>, linuxppc-dev@lists.ozlabs.org, "David S. Miller" <davem@davemloft.net>

When there are more than one implementation of the NMI watchdog, there may
be situations in which switching from one to another is needed (e.g., if
the time-stamp counter becomes unstable, the HPET-based NMI watchdog can
no longer be used.

The perf-based implementation of the hardlockup detector makes use of
various per-CPU variables which are accessed via this_cpu operations.
Hence, each CPU needs to enable its own NMI watchdog if using the perf
implementation.

Add functionality to switch from one NMI watchdog to another and do it
from each allowed CPU.

Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Ashok Raj <ashok.raj@intel.com>
Cc: Andi Kleen <andi.kleen@intel.com>
Cc: Tony Luck <tony.luck@intel.com>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Cc: Don Zickus <dzickus@redhat.com>
Cc: Nicholas Piggin <npiggin@gmail.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Frederic Weisbecker <frederic@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>
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
Cc: Byungchul Park <byungchul.park@lge.com>
Cc: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc: "Luis R. Rodriguez" <mcgrof@kernel.org>
Cc: Waiman Long <longman@redhat.com>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Randy Dunlap <rdunlap@infradead.org>
Cc: Davidlohr Bueso <dave@stgolabs.net>
Cc: Marc Zyngier <marc.zyngier@arm.com>
Cc: Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc: David Rientjes <rientjes@google.com>
Cc: Stephane Eranian <eranian@google.com>
Cc: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
Cc: "Ravi V. Shankar" <ravi.v.shankar@intel.com>
Cc: x86@kernel.org
Cc: sparclinux@vger.kernel.org
Cc: linuxppc-dev@lists.ozlabs.org
Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
---
 include/linux/nmi.h |  2 ++
 kernel/watchdog.c   | 15 +++++++++++++++
 2 files changed, 17 insertions(+)

diff --git a/include/linux/nmi.h b/include/linux/nmi.h
index e5f1a86e20b7..6d828334348b 100644
--- a/include/linux/nmi.h
+++ b/include/linux/nmi.h
@@ -83,9 +83,11 @@ static inline void reset_hung_task_detector(void) { }
 
 #if defined(CONFIG_HARDLOCKUP_DETECTOR)
 extern void hardlockup_detector_disable(void);
+extern void hardlockup_start_all(void);
 extern unsigned int hardlockup_panic;
 #else
 static inline void hardlockup_detector_disable(void) {}
+static inline void hardlockup_start_all(void) {}
 #endif
 
 #if defined(CONFIG_HAVE_NMI_WATCHDOG) || defined(CONFIG_HARDLOCKUP_DETECTOR)
diff --git a/kernel/watchdog.c b/kernel/watchdog.c
index 7f9e7b9306fe..be589001200a 100644
--- a/kernel/watchdog.c
+++ b/kernel/watchdog.c
@@ -566,6 +566,21 @@ int lockup_detector_offline_cpu(unsigned int cpu)
 	return 0;
 }
 
+static int hardlockup_start_fn(void *data)
+{
+	watchdog_nmi_enable(smp_processor_id());
+	return 0;
+}
+
+void hardlockup_start_all(void)
+{
+	int cpu;
+
+	cpumask_copy(&watchdog_allowed_mask, &watchdog_cpumask);
+	for_each_cpu(cpu, &watchdog_allowed_mask)
+		smp_call_on_cpu(cpu, hardlockup_start_fn, NULL, false);
+}
+
 static void lockup_detector_reconfigure(void)
 {
 	cpus_read_lock();
-- 
2.17.1
