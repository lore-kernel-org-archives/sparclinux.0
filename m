From: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Date: Wed, 13 Jun 2018 00:57:42 +0000
Subject: [RFC PATCH 22/23] watchdog/hardlockup/hpet: Only enable the HPET watchdog via a boot parameter
Message-Id: <1528851463-21140-23-git-send-email-ricardo.neri-calderon@linux.intel.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1528851463-21140-1-git-send-email-ricardo.neri-calderon@linux.intel.com>
In-Reply-To: <1528851463-21140-1-git-send-email-ricardo.neri-calderon@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>
Cc: Andi Kleen <andi.kleen@intel.com>, Ashok Raj <ashok.raj@intel.com>, Borislav Petkov <bp@suse.de>, Tony Luck <tony.luck@intel.com>, "Ravi V. Shankar" <ravi.v.shankar@intel.com>, x86@kernel.org, sparclinux@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, Ricardo Neri <ricardo.neri-calderon@linux.intel.com>, Jacob Pan <jacob.jun.pan@intel.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Don Zickus <dzickus@redhat.com>, Nicholas Piggin <npiggin@gmail.com>, Michael Ellerman <mpe@ellerman.id.au>, Frederic Weisbecker <frederic@kernel.org>, Alexei Starovoitov <ast@kernel.org>, Babu Moger <babu.moger@oracle.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Masami Hiramatsu <mhiramat@kernel.org>, Peter Zijlstra <peterz@infra>

Keep the HPET-based hardlockup detector disabled unless explicitly enabled
via a command line argument. If such parameter is not given, the hardlockup
detector will fallback to use the perf-based implementation.

The function hardlockup_panic_setup() is updated to return 0 in order to
to allow __setup functions of specific hardlockup detectors (in this case
hardlockup_detector_hpet_setup()) to inspect the nmi_watchdog boot
parameter.

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
--
checkpatch gives the following warning:

CHECK: __setup appears un-documented -- check Documentation/admin-guide/kernel-parameters.rst
+__setup("nmi_watchdog=", hardlockup_detector_hpet_setup);

This is a false-positive as the option nmi_watchdog is already
documented. The option is re-evaluated in this file as well.
---
 Documentation/admin-guide/kernel-parameters.txt |  5 ++++-
 kernel/watchdog.c                               |  2 +-
 kernel/watchdog_hld_hpet.c                      | 13 +++++++++++++
 3 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index f2040d4..a8833c7 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -2577,7 +2577,7 @@
 			Format: [state][,regs][,debounce][,die]
 
 	nmi_watchdog=	[KNL,BUGS=X86] Debugging features for SMP kernels
-			Format: [panic,][nopanic,][num]
+			Format: [panic,][nopanic,][num,][hpet]
 			Valid num: 0 or 1
 			0 - turn hardlockup detector in nmi_watchdog off
 			1 - turn hardlockup detector in nmi_watchdog on
@@ -2587,6 +2587,9 @@
 			please see 'nowatchdog'.
 			This is useful when you use a panic=... timeout and
 			need the box quickly up again.
+			When hpet is specified, the NMI watchdog will be driven
+			by an HPET timer, if available in the system. Otherwise,
+			the perf-based implementation will be used.
 
 			These settings can be accessed at runtime via
 			the nmi_watchdog and hardlockup_panic sysctls.
diff --git a/kernel/watchdog.c b/kernel/watchdog.c
index b94bbe3..b5ce6e4 100644
--- a/kernel/watchdog.c
+++ b/kernel/watchdog.c
@@ -84,7 +84,7 @@ static int __init hardlockup_panic_setup(char *str)
 		nmi_watchdog_user_enabled = 0;
 	else if (!strncmp(str, "1", 1))
 		nmi_watchdog_user_enabled = 1;
-	return 1;
+	return 0;
 }
 __setup("nmi_watchdog=", hardlockup_panic_setup);
 
diff --git a/kernel/watchdog_hld_hpet.c b/kernel/watchdog_hld_hpet.c
index ebb820d..12e5937 100644
--- a/kernel/watchdog_hld_hpet.c
+++ b/kernel/watchdog_hld_hpet.c
@@ -17,6 +17,7 @@
 #define pr_fmt(fmt) "NMI hpet watchdog: " fmt
 
 static struct hpet_hld_data *hld_data;
+static bool hardlockup_use_hpet;
 
 /**
  * get_count() - Get the current count of the HPET timer
@@ -488,6 +489,15 @@ static void hardlockup_detector_hpet_stop(void)
 	spin_unlock(&hld_data->lock);
 }
 
+static int __init hardlockup_detector_hpet_setup(char *str)
+{
+	if (strstr(str, "hpet"))
+		hardlockup_use_hpet = true;
+
+	return 0;
+}
+__setup("nmi_watchdog=", hardlockup_detector_hpet_setup);
+
 /**
  * hardlockup_detector_hpet_init() - Initialize the hardlockup detector
  *
@@ -502,6 +512,9 @@ static int __init hardlockup_detector_hpet_init(void)
 {
 	int ret;
 
+	if (!hardlockup_use_hpet)
+		return -EINVAL;
+
 	if (!is_hpet_enabled())
 		return -ENODEV;
 
-- 
2.7.4

