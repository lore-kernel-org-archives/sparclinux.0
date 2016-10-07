From: Don Zickus <dzickus@redhat.com>
Date: Fri, 07 Oct 2016 15:51:28 +0000
Subject: Re: [PATCH 0/2] Introduce update_arch_nmi_watchdog for arch specific handlers
Message-Id: <20161007155128.GP98438@redhat.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1475792203-230942-1-git-send-email-babu.moger@oracle.com>
In-Reply-To: <1475792203-230942-1-git-send-email-babu.moger@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Babu Moger <babu.moger@oracle.com>
Cc: mingo@kernel.org, akpm@linux-foundation.org, ak@linux.intel.com, jkosina@suse.cz, baiyaowei@cmss.chinamobile.com, atomlin@redhat.com, uobergfe@redhat.com, tj@kernel.org, hidehiro.kawai.ez@hitachi.com, johunt@akamai.com, davem@davemloft.net, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org

On Thu, Oct 06, 2016 at 03:16:41PM -0700, Babu Moger wrote:
> During our testing we noticed that nmi watchdogs in sparc could not be disabled or
> enabled dynamically using sysctl/proc interface. Sparc uses its own arch specific
> nmi watchdogs. There is a sysctl and proc interface(proc/sys/kernel/nmi_watchdog)
> to enable/disable nmi watchdogs. However, that is not working for sparc. There
> is no interface to feed this parameter to arch specific nmi watchdogs.
> 
> These patches extend the same sysctl/proc interface to enable or disable
> these arch specific nmi watchdogs dynamically. Introduced new function
> update_arch_nmi_watchdog which can be implemented in arch specific handlers.
> If you think there is a better way to do this. Please advice.
> 
> Tested on sparc. Compile tested on x86.

Hi Babu,

Thanks for the patch.  Yeah, I don't test sparc at all (lack of hardware).
Sorry about that.

We did spend quite a bit of time trying to get various soft/hard lockup
logic going for the /proc stuff and I am wondering if your patches are to
simple and expose some of the races we tried to fix.

Therefore I am wondering if we could re-use some of our logic for your case.

The perf stuff is really the x86 equivalent of arch_watchdog_enable.  I am
wondering if we break that out as a __weak default function and then have
sparc override it with its own enable/disable functions.  Something along
the lines below (compiled on x86 but untested)?

Cheers,
Don


diff --git a/kernel/watchdog.c b/kernel/watchdog.c
index 9acb29f..55cd2d3 100644
--- a/kernel/watchdog.c
+++ b/kernel/watchdog.c
@@ -585,15 +585,11 @@ static void watchdog(unsigned int cpu)
  */
 static unsigned long cpu0_err;
 
-static int watchdog_nmi_enable(unsigned int cpu)
+int __weak arch_watchdog_nmi_enable(unsigned int cpu)
 {
 	struct perf_event_attr *wd_attr;
 	struct perf_event *event = per_cpu(watchdog_ev, cpu);
 
-	/* nothing to do if the hard lockup detector is disabled */
-	if (!(watchdog_enabled & NMI_WATCHDOG_ENABLED))
-		goto out;
-
 	/* is it already setup and enabled? */
 	if (event && event->state > PERF_EVENT_STATE_OFF)
 		goto out;
@@ -619,18 +615,6 @@ static int watchdog_nmi_enable(unsigned int cpu)
 		goto out_save;
 	}
 
-	/*
-	 * Disable the hard lockup detector if _any_ CPU fails to set up
-	 * set up the hardware perf event. The watchdog() function checks
-	 * the NMI_WATCHDOG_ENABLED bit periodically.
-	 *
-	 * The barriers are for syncing up watchdog_enabled across all the
-	 * cpus, as clear_bit() does not use barriers.
-	 */
-	smp_mb__before_atomic();
-	clear_bit(NMI_WATCHDOG_ENABLED_BIT, &watchdog_enabled);
-	smp_mb__after_atomic();
-
 	/* skip displaying the same error again */
 	if (cpu > 0 && (PTR_ERR(event) = cpu0_err))
 		return PTR_ERR(event);
@@ -658,7 +642,36 @@ out:
 	return 0;
 }
 
-static void watchdog_nmi_disable(unsigned int cpu)
+static int watchdog_nmi_enable(unsigned int cpu)
+{
+	int err;
+
+	/* nothing to do if the hard lockup detector is disabled */
+	if (!(watchdog_enabled & NMI_WATCHDOG_ENABLED))
+		return 0;
+
+	err = arch_watchdog_nmi_enable(cpu);
+
+	if (err) {
+		/*
+		 * Disable the hard lockup detector if _any_ CPU fails to set up
+		 * set up the hardware perf event. The watchdog() function checks
+		 * the NMI_WATCHDOG_ENABLED bit periodically.
+		 *
+		 * The barriers are for syncing up watchdog_enabled across all the
+		 * cpus, as clear_bit() does not use barriers.
+		 */
+		smp_mb__before_atomic();
+		clear_bit(NMI_WATCHDOG_ENABLED_BIT, &watchdog_enabled);
+		smp_mb__after_atomic();
+
+		return err;
+	}
+
+	return 0;
+}
+
+void __weak arch_watchdog_nmi_disable(unsigned int cpu)
 {
 	struct perf_event *event = per_cpu(watchdog_ev, cpu);
 
@@ -675,6 +688,11 @@ static void watchdog_nmi_disable(unsigned int cpu)
 	}
 }
 
+static void watchdog_nmi_disable(unsigned int cpu)
+{
+	arch_watchdog_nmi_disable(cpu);
+}
+
 #else
 static int watchdog_nmi_enable(unsigned int cpu) { return 0; }
 static void watchdog_nmi_disable(unsigned int cpu) { return; }
