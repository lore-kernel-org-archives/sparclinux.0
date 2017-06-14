From: Rob Gardner <rob.gardner@oracle.com>
Date: Wed, 14 Jun 2017 05:05:57 +0000
Subject: [PATCH] sparc64: Exclude perf user callchain during critical sections
Message-Id: <1497416757-9894-1-git-send-email-rob.gardner@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

This fixes another cause of random segfaults and bus errors that
may occur while running perf with the callgraph (-g) option.

Critical sections beginning with spin_lock_irqsave() raise the
interrupt level to PIL_NORMAL_MAX (14) and intentionally do not block
performance counter interrupts, which arrive at PIL_NMI (15).  So perf
code must be very careful about what it does since it might execute in
the middle of one of these critical sections. In particular, the
perf_callchain_user() path is problematic because it accesses user
space and may cause TLB activity as well as faults as it unwinds the
user stack.

One particular critical section occurs in switch_mm:

        spin_lock_irqsave(&mm->context.lock, flags);
        ...
        load_secondary_context(mm);
        tsb_context_switch(mm);
        ...
        spin_unlock_irqrestore(&mm->context.lock, flags);

If a perf interrupt arrives in between load_secondary_context() and
tsb_context_switch(), then perf_callchain_user() could execute with
the context ID of one process, but with an active tsb for a different
process. When the user stack is accessed, it is very likely to
incur a TLB miss, since the h/w context ID has been changed. The TLB
will then be reloaded with a translation from the TSB for one process,
but using a context ID for another process. This exposes memory from
one process to another, and since it is a mapping for stack memory,
this usually causes the new process to crash quickly.

Some potential solutions are:

1) Make critical sections run at PIL_NMI instead of PIL_NORMAL_MAX.
This would certainly eliminate the problem, but it would also prevent
perf from having any visibility into code running in these critical
sections, and it seems clear that PIL_NORMAL_MAX is used for just
this reason.

2) Protect this particular critical section by masking all interrupts,
either by setting %pil to PIL_NMI or by clearing pstate.ie around the
calls to load_secondary_context() and tsb_context_switch(). This approach
has a few drawbacks:

 - It would only address this particular critical section, and would
   have to be repeated in several other known places. There might be
   other such critical sections that are not known.

 - It has a performance cost which would be incurred at every context
   switch, since it would require additional accesses to %pil or
   %pstate.

 - Turning off pstate.ie would require changing __tsb_context_switch(),
   which expects to be called with pstate.ie on.

3) Avoid user space MMU activity entirely in perf_callchain_user() by
implementing a new copy_from_user() function that accesses the user
stack via physical addresses. This works, but requires quite a bit of
new code to get it to perform reasonably, ie, caching of translations,
etc.

4) Allow the perf interrupt to happen in existing critical sections as
it does now, but have perf code detect that this is happening, and
skip any user callchain processing. This approach was deemed best, as
the change is extremely localized and covers both known and unknown
instances of perf interrupting critical sections. Perf has interrupted
a critical section when %pil = PIL_NORMAL_MAX at the time of the perf
interrupt.

Ordinarily, a function that has a pt_regs passed in can simply examine
(reg->tstate & TSTATE_PIL) to extract the interrupt level that was in
effect at the time of the perf interrupt.  However, when the perf
interrupt occurs while executing in the kernel, the pt_regs pointer is
replaced with task_pt_regs(current) in perf_callchain(), and so
perf_callchain_user() does not have access to the state of the machine
at the time of the perf interrupt. To work around this, we check
(regs->tstate & TSTATE_PIL) in perf_event_nmi_handler() before calling
in to the arch independent part of perf, and temporarily change the
event attributes so that user callchain processing is avoided. Though
a user stack sample is not collected, this loss is not statistically
significant. Kernel call graph collection is not affected.

Orabug: 25577560

Signed-off-by: Rob Gardner <rob.gardner@oracle.com>
Signed-off-by: Dave Aldridge <david.j.aldridge@oracle.com>
Reviewed-by: Bob Picco <bob.picco@oracle.com>
---
 arch/sparc/kernel/perf_event.c |   12 +++++++++++-
 1 files changed, 11 insertions(+), 1 deletions(-)

diff --git a/arch/sparc/kernel/perf_event.c b/arch/sparc/kernel/perf_event.c
index 710f327..5295dda 100644
--- a/arch/sparc/kernel/perf_event.c
+++ b/arch/sparc/kernel/perf_event.c
@@ -1602,6 +1602,7 @@ static int __kprobes perf_event_nmi_handler(struct notifier_block *self,
 	struct perf_sample_data data;
 	struct cpu_hw_events *cpuc;
 	struct pt_regs *regs;
+	bool irq_disabled;
 	int i;
 
 	if (!atomic_read(&active_events))
@@ -1630,6 +1631,7 @@ static int __kprobes perf_event_nmi_handler(struct notifier_block *self,
 	    sparc_pmu->num_pcrs = 1)
 		pcr_ops->write_pcr(0, cpuc->pcr[0]);
 
+	irq_disabled = ((regs->tstate & TSTATE_PIL) >> 20) = PIL_NORMAL_MAX;
 	for (i = 0; i < cpuc->n_events; i++) {
 		struct perf_event *event = cpuc->event[i];
 		int idx = cpuc->current_idx[i];
@@ -1649,8 +1651,16 @@ static int __kprobes perf_event_nmi_handler(struct notifier_block *self,
 		if (!sparc_perf_event_set_period(event, hwc, idx))
 			continue;
 
-		if (perf_event_overflow(event, &data, regs))
+		if (unlikely(irq_disabled)) {
+			u64 saved_exclude = event->attr.exclude_callchain_user;
+
+			event->attr.exclude_callchain_user = 1;
+			if (perf_event_overflow(event, &data, regs))
+				sparc_pmu_stop(event, 0);
+			event->attr.exclude_callchain_user = saved_exclude;
+		} else if (perf_event_overflow(event, &data, regs)) {
 			sparc_pmu_stop(event, 0);
+		}
 	}
 
 	return NOTIFY_STOP;
-- 
1.7.1

