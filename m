From: Peter Zijlstra <a.p.zijlstra@chello.nl>
Date: Tue, 06 Apr 2010 13:28:09 +0000
Subject: [patch 2/3] perf: Use local_irq_save_nmi()
Message-Id: <20100406133140.972113669@chello.nl>
List-Id: <sparclinux.vger.kernel.org>
References: <20100406132807.698467930@chello.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: mingo@elte.hu, David Miller <davem@davemloft.net>, acme@redhat.com, paulus@samba.org, Mike Galbraith <efault@gmx.de>, Frederic Weisbecker <fweisbec@gmail.com>, Thomas Gleixner <tglx@l>
Cc: linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org, linux-arch@vger.kernel.org, Peter Zijlstra <a.p.zijlstra@chello.nl>

Patch 8bb39f9 (perf: Fix 'perf sched record' deadlock) introduced a
local_irq_save() in NMI context, convert that to local_irq_save_nmi()
and move the IRQ disable into perf_output_lock/unlock().

The former is needed because we now disallow local_irq_disable() from
NMI context due to some arch limitations.

The second is because its really about IRQ lock inversion with that
funny output lock, and perf_event_task_output() is only one site that
could trigger it.

Signed-off-by: Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc: Mike Galbraith <efault@gmx.de>
---
 include/linux/perf_event.h |    1 +
 kernel/perf_event.c        |   17 ++++++-----------
 2 files changed, 7 insertions(+), 11 deletions(-)

Index: linux-2.6/include/linux/perf_event.h
=================================--- linux-2.6.orig/include/linux/perf_event.h
+++ linux-2.6/include/linux/perf_event.h
@@ -758,6 +758,7 @@ struct perf_output_handle {
 	struct perf_mmap_data		*data;
 	unsigned long			head;
 	unsigned long			offset;
+	unsigned long			flags;
 	int				nmi;
 	int				sample;
 	int				locked;
Index: linux-2.6/kernel/perf_event.c
=================================--- linux-2.6.orig/kernel/perf_event.c
+++ linux-2.6/kernel/perf_event.c
@@ -2848,6 +2848,10 @@ static void perf_output_lock(struct perf
 	struct perf_mmap_data *data = handle->data;
 	int cur, cpu = get_cpu();
 
+	/*
+	 * Since this is a lock we need to be IRQ-safe
+	 */
+	local_irq_save_nmi(handle->flags);
 	handle->locked = 0;
 
 	for (;;) {
@@ -2906,6 +2910,7 @@ again:
 	if (atomic_xchg(&data->wakeup, 0))
 		perf_output_wakeup(handle);
 out:
+	local_irq_restore_nmi(handle->flags);
 	put_cpu();
 }
 
@@ -3385,19 +3390,10 @@ static void perf_event_task_output(struc
 	unsigned long flags;
 	int size, ret;
 
-	/*
-	 * If this CPU attempts to acquire an rq lock held by a CPU spinning
-	 * in perf_output_lock() from interrupt context, it's game over.
-	 */
-	local_irq_save(flags);
-
 	size  = task_event->event_id.header.size;
 	ret = perf_output_begin(&handle, event, size, 0, 0);
-
-	if (ret) {
-		local_irq_restore(flags);
+	if (ret)
 		return;
-	}
 
 	task_event->event_id.pid = perf_event_pid(event, task);
 	task_event->event_id.ppid = perf_event_pid(event, current);
@@ -3408,7 +3404,6 @@ static void perf_event_task_output(struc
 	perf_output_put(&handle, task_event->event_id);
 
 	perf_output_end(&handle);
-	local_irq_restore(flags);
 }
 
 static int perf_event_task_match(struct perf_event *event)


