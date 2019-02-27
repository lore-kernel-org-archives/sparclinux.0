From: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Date: Wed, 27 Feb 2019 16:05:14 +0000
Subject: [RFC PATCH v2 10/14] kernel/watchdog: Add a function to obtain the watchdog_allowed_mask
Message-Id: <1551283518-18922-11-git-send-email-ricardo.neri-calderon@linux.intel.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1551283518-18922-1-git-send-email-ricardo.neri-calderon@linux.intel.com>
In-Reply-To: <1551283518-18922-1-git-send-email-ricardo.neri-calderon@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@suse.de>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Peter Zijlstra <peterz@infradead.org>, Alexei Starovoitov <ast@kernel.org>, Kai-Heng Feng <kai.heng.feng@canonical.com>, Paul Mackerras <paulus@samba.org>, "H. Peter Anvin" <hpa@zytor.com>, sparclinux@vger.kernel.org, Christoffer Dall <cdall@linaro.org>, Davidlohr Bueso <dave@stgolabs.net>, Ashok Raj <ashok.raj@intel.com>, x86@kernel.org, David Rientjes <rientjes@google.com>, Andi Kleen <andi.kleen@intel.com>, Waiman Long <longman@redhat.com>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Don Zickus <dzickus@redhat.com>, "Ravi V. Shankar" <ravi.v.shankar@intel.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Marc Zyngier <marc.zyngier@arm.com>, Ricardo Neri <ricardo.neri-calderon@linux.intel.com>, Frederic Weisbecker <frederic@kernel.org>, Nicholas Piggin <npiggin@gmail.com>, Ricardo Neri <ricardo.neri@intel.com>, Byungchul Park <byungchul.park@lge.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Josh Poimboeuf <jpoimboe@redhat.com>, Tony Luck <tony.luck@intel.com>, Babu Moger <babu.moger@oracle.com>, Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org, "Luis R. Rodriguez" <mcgrof@kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>, Philippe Ombredanne <pombredanne@nexb.com>, Colin Ian King <colin.king@canonical.com>, Andrew Morton <akpm@linux-foundation.org>, linuxppc-dev@lists.ozlabs.org, "David S. Miller" <davem@davemloft.net>

Implementations of NMI watchdogs that use a single piece of hardware to
monitor all the CPUs in the system (as opposed to per-CPU implementations
such as perf) need to know which CPUs the watchdog is allowed to monitor.
In this manner, non-maskable interrupts are directed only to the monitored
CPUs.

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
Cc: sparclinux@vger.kernel.org
Cc: linuxppc-dev@lists.ozlabs.org
Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
---
 include/linux/nmi.h | 1 +
 kernel/watchdog.c   | 7 ++++++-
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/include/linux/nmi.h b/include/linux/nmi.h
index bf5ebcfdd590..b563fb6ef21d 100644
--- a/include/linux/nmi.h
+++ b/include/linux/nmi.h
@@ -83,6 +83,7 @@ static inline void reset_hung_task_detector(void) { }
 
 #if defined(CONFIG_HARDLOCKUP_DETECTOR)
 extern void hardlockup_detector_disable(void);
+extern struct cpumask *watchdog_get_allowed_cpumask(void);
 extern unsigned int hardlockup_panic;
 #else
 static inline void hardlockup_detector_disable(void) {}
diff --git a/kernel/watchdog.c b/kernel/watchdog.c
index 8fbfda94a67b..367aa81294ef 100644
--- a/kernel/watchdog.c
+++ b/kernel/watchdog.c
@@ -44,7 +44,7 @@ int __read_mostly soft_watchdog_user_enabled = 1;
 int __read_mostly watchdog_thresh = 10;
 int __read_mostly nmi_watchdog_available;
 
-struct cpumask watchdog_allowed_mask __read_mostly;
+static struct cpumask watchdog_allowed_mask __read_mostly;
 
 struct cpumask watchdog_cpumask __read_mostly;
 unsigned long *watchdog_cpumask_bits = cpumask_bits(&watchdog_cpumask);
@@ -92,6 +92,11 @@ static int __init hardlockup_all_cpu_backtrace_setup(char *str)
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
2.17.1
