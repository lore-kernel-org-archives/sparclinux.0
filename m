From: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Date: Wed, 13 Jun 2018 00:57:35 +0000
Subject: [RFC PATCH 15/23] kernel/watchdog: Add a function to obtain the watchdog_allowed_mask
Message-Id: <1528851463-21140-16-git-send-email-ricardo.neri-calderon@linux.intel.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1528851463-21140-1-git-send-email-ricardo.neri-calderon@linux.intel.com>
In-Reply-To: <1528851463-21140-1-git-send-email-ricardo.neri-calderon@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>
Cc: Andi Kleen <andi.kleen@intel.com>, Ashok Raj <ashok.raj@intel.com>, Borislav Petkov <bp@suse.de>, Tony Luck <tony.luck@intel.com>, "Ravi V. Shankar" <ravi.v.shankar@intel.com>, x86@kernel.org, sparclinux@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, Ricardo Neri <ricardo.neri-calderon@linux.intel.com>, Jacob Pan <jacob.jun.pan@intel.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Don Zickus <dzickus@redhat.com>, Nicholas Piggin <npiggin@gmail.com>, Michael Ellerman <mpe@ellerman.id.au>, Frederic Weisbecker <frederic@kernel.org>, Alexei Starovoitov <ast@kernel.org>, Babu Moger <babu.moger@oracle.com>, Paul Mackerras <paulus@samba.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Masami Hiramatsu <mhiramat@kernel>

Implementations of NMI watchdogs that use a single piece of hardware to
monitor all the CPUs in the system (as opposed to per-CPU implementations
such as perf) need to know which CPUs the watchdog is allowed to monitor.
In this manner, non-maskable interrupts are directed only to the monitored
CPUs.

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
Cc: Christoffer Dall <cdall@linaro.org>
Cc: Marc Zyngier <marc.zyngier@arm.com>
Cc: Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc: David Rientjes <rientjes@google.com>
Cc: "Ravi V. Shankar" <ravi.v.shankar@intel.com>
Cc: x86@kernel.org
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: iommu@lists.linux-foundation.org
Cc: sparclinux@vger.kernel.org
Cc: linuxppc-dev@lists.ozlabs.org
Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
---
 include/linux/nmi.h | 1 +
 kernel/watchdog.c   | 7 ++++++-
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/include/linux/nmi.h b/include/linux/nmi.h
index e61b441..e608762 100644
--- a/include/linux/nmi.h
+++ b/include/linux/nmi.h
@@ -77,6 +77,7 @@ static inline void reset_hung_task_detector(void) { }
 
 #if defined(CONFIG_HARDLOCKUP_DETECTOR)
 extern void hardlockup_detector_disable(void);
+extern struct cpumask *watchdog_get_allowed_cpumask(void);
 extern unsigned int hardlockup_panic;
 #else
 static inline void hardlockup_detector_disable(void) {}
diff --git a/kernel/watchdog.c b/kernel/watchdog.c
index 5057376..b94bbe3 100644
--- a/kernel/watchdog.c
+++ b/kernel/watchdog.c
@@ -50,7 +50,7 @@ int __read_mostly nmi_watchdog_available;
 
 static struct nmi_watchdog_ops *nmi_wd_ops;
 
-struct cpumask watchdog_allowed_mask __read_mostly;
+static struct cpumask watchdog_allowed_mask __read_mostly;
 
 struct cpumask watchdog_cpumask __read_mostly;
 unsigned long *watchdog_cpumask_bits = cpumask_bits(&watchdog_cpumask);
@@ -98,6 +98,11 @@ static int __init hardlockup_all_cpu_backtrace_setup(char *str)
 }
 __setup("hardlockup_all_cpu_backtrace=", hardlockup_all_cpu_backtrace_setup);
 # endif /* CONFIG_SMP */
+
+struct cpumask *watchdog_get_allowed_cpumask(void)
+{
+	return &watchdog_allowed_mask;
+}
 #endif /* CONFIG_HARDLOCKUP_DETECTOR */
 
 /*
-- 
2.7.4

