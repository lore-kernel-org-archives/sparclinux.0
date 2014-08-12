From: David Miller <davem@davemloft.net>
Date: Tue, 12 Aug 2014 00:51:31 +0000
Subject: Re: [PATCH] Fix BREAK handling in sunsab serial driver
Message-Id: <20140811.175131.1370770542897653039.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <201407271519.22272.cat.schulze@alice-dsl.net>
In-Reply-To: <201407271519.22272.cat.schulze@alice-dsl.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: David Miller <davem@davemloft.net>
Date: Mon, 11 Aug 2014 15:19:14 -0700 (PDT)

> This is an indirect call, and the only indirect calls in perf_event_print_debug()
> are the pcr_ops->() method invocations, that is what we are executing here, therefore
> pcr_ops is NULL at this location.
> 
> It confirms my suspicions and I'll therefore work on a fix, thanks!

Here is the patch I am currently testing:

==========
[PATCH] sparc64: Fix pcr_ops initialization and usage bugs.

Christopher reports that perf_event_print_debug() can crash in uniprocessor
builds.  The crash is due to pcr_ops being NULL.

This happens because pcr_arch_init() is only invoked by smp_cpus_done() which
only executes in SMP builds.

init_hw_perf_events() is closely intertwined with pcr_ops being setup properly,
therefore:

1) Call pcr_arch_init() early on from init_hw_perf_events(), instead of
   from smp_cpus_done().

2) Do not hook up a PMU type if pcr_ops is NULL after pcr_arch_init().

3) Move init_hw_perf_events to a later initcall so that it we will be
   sure to invoke pcr_arch_init() after all cpus are brought up.

Finally, guard the one naked sequence of pcr_ops dereferences in
__global_pmu_self() with an appropriate NULL check.

Reported-by: Christopher Alexander Tobias Schulze <cat.schulze@alice-dsl.net>
Signed-off-by: David S. Miller <davem@davemloft.net>
---
 arch/sparc/kernel/perf_event.c | 7 +++++--
 arch/sparc/kernel/process_64.c | 3 +++
 arch/sparc/kernel/smp_64.c     | 1 -
 3 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/arch/sparc/kernel/perf_event.c b/arch/sparc/kernel/perf_event.c
index 8efd337..d35c490 100644
--- a/arch/sparc/kernel/perf_event.c
+++ b/arch/sparc/kernel/perf_event.c
@@ -1671,9 +1671,12 @@ static bool __init supported_pmu(void)
 
 static int __init init_hw_perf_events(void)
 {
+	int err;
+
 	pr_info("Performance events: ");
 
-	if (!supported_pmu()) {
+	err = pcr_arch_init();
+	if (err || !supported_pmu()) {
 		pr_cont("No support for PMU type '%s'\n", sparc_pmu_type);
 		return 0;
 	}
@@ -1685,7 +1688,7 @@ static int __init init_hw_perf_events(void)
 
 	return 0;
 }
-early_initcall(init_hw_perf_events);
+pure_initcall(init_hw_perf_events);
 
 void perf_callchain_kernel(struct perf_callchain_entry *entry,
 			   struct pt_regs *regs)
diff --git a/arch/sparc/kernel/process_64.c b/arch/sparc/kernel/process_64.c
index 027e099..0be7bf9 100644
--- a/arch/sparc/kernel/process_64.c
+++ b/arch/sparc/kernel/process_64.c
@@ -312,6 +312,9 @@ static void __global_pmu_self(int this_cpu)
 	struct global_pmu_snapshot *pp;
 	int i, num;
 
+	if (!pcr_ops)
+		return;
+
 	pp = &global_cpu_snapshot[this_cpu].pmu;
 
 	num = 1;
diff --git a/arch/sparc/kernel/smp_64.c b/arch/sparc/kernel/smp_64.c
index 41aa247..f7ba875 100644
--- a/arch/sparc/kernel/smp_64.c
+++ b/arch/sparc/kernel/smp_64.c
@@ -1383,7 +1383,6 @@ void __cpu_die(unsigned int cpu)
 
 void __init smp_cpus_done(unsigned int max_cpus)
 {
-	pcr_arch_init();
 }
 
 void smp_send_reschedule(int cpu)
-- 
1.8.1.2

