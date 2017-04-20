From: Petr Mladek <pmladek@suse.com>
Date: Thu, 20 Apr 2017 13:11:54 +0000
Subject: Re: [PATCH v5 1/4] printk/nmi: generic solution for safe printk in NMI
Message-Id: <20170420131154.GL3452@pathway.suse.cz>
List-Id: <sparclinux.vger.kernel.org>
References: <1461239325-22779-1-git-send-email-pmladek@suse.com>
 <1461239325-22779-2-git-send-email-pmladek@suse.com>
 <20170419131341.76bc7634@gandalf.local.home>
 <20170420033112.GB542@jagdpanzerIV.localdomain>
In-Reply-To: <20170420033112.GB542@jagdpanzerIV.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: linux-arm-kernel@lists.infradead.org

On Thu 2017-04-20 12:31:12, Sergey Senozhatsky wrote:
> Hello Steven,
>=20
> On (04/19/17 13:13), Steven Rostedt wrote:
> > > printk() takes some locks and could not be used a safe way in NMI con=
text.
> >=20
> > I just found a problem with this solution. It kills ftrace dumps from
> > NMI context :-(
> >=20
> > [ 1295.168495]    <...>-67423  10dNh1 382171111us : do_raw_spin_lock <-=
_raw_spin_lock
> > [ 1295.168495]    <...>-67423  10dNh1 382171111us : sched_stat_runtime:=
 comm=CC1 pidg423 runtime=96858 [ns] vruntime=11924198270 [ns]
> > [ 1295.168496]    <...>-67423  10dNh1 382171111us : lock_acquire: fffff=
fff81c5c940 read rcu_read_lock
> > [ 1295.168497]
> > [ 1295.168498] Lost 4890096 message(s)!
> > [ 1296.805063] ---[ end Kernel panic - not syncing: Hard LOCKUP
> > [ 1296.811553] unchecked MSR access error: WRMSR to 0x83f (tried to wri=
te 0x00000000000000f6) at rIP: 0xffffffff81046fc7 (native_apic_msr_write+0x=
27/0x40)
> > [ 1296.811553] Call Trace:
> > [ 1296.811553]  <NMI>
> >=20
> > I was hoping to see a cause of a hard lockup by enabling
> > ftrace_dump_on_oops. But as NMIs now have a very small buffer that
> > gets flushed, we need to find a new way to print out the full ftrace
> > buffer over serial.
> >=20
> > Thoughts?
>=20
> hmmm... a really tough one.
>=20
> well, someone has to say this:
>  the simplest thing is to have a bigger PRINTK_SAFE_LOG_BUF_SHIFT value :)
>=20
>=20
> just thinking (well, sort of) out loud. the problem is that we can't tell=
 if
> we already hold any printk related locks ("printk related locks" is not e=
ven
> well defined term). so printk from NMI can deadlock or it can be OK, we
> never know. but looking and vprintk_emit() and console_unlock() it seems =
that
> we have some sort of a hint now, which is this_cpu_read(printk_context) -=
 if
> we are not in printk_safe context then we can say that _probably_ (and th=
at's
> a Russian roulette) doing "normal" printk() will work. that is a *very-ve=
ry*
> risky (and admittedly dumb) thing to assume, so we will move in a slightly
> different direction. checking this_cpu_read(printk_context) only assures =
us
> that we don't hold `logbuf_lock' on this CPU. and that is sort of somethi=
ng,
> at least we can be sure that doing printk_deferred() from this CPU is saf=
e.
> printk_deferred() means that your NMI messages will end up in the logbuf,
> which is a) bigger in size than per-CPU buffer and b) some other CPU can
> immediately print those messages (hopefully).
>=20
> we also switch to printk_safe mode for call_console_drivers() in
> console_unlock(). but we can't make any solid assumptions there - serial
> console lock can already be acquired, we don't have any markers for that.
> it may be reasonable to assume that if we are not in printk_safe mode on
> this CPU then serial console is not locked from this CPU, but there is
> nothing that can assure us.

Good analyze. I would summarize it that we need to be careful of:

  + logbug_lock
  + PRINTK_SAFE_CONTEXT
  + locks used by console drivers

The first two things are easy to check. Except that a check for logbuf_lock
might produce false negatives. The last check is very hard.

> so at the moment what I can think of is something like
>=20
>   -- check this_cpu_read(printk_context) in NMI prink
>=20
> 	-- if we are NOT in printk_safe on this CPU, then do printk_deferred()
> 	   and bypass `nmi_print_seq' buffer

I would add also a check for logbuf_lock.

> 	-- if we are in printk_safe
> 	  -- well... bad luck... have a bigger buffer.

Yup, we do the best effort while still trying to stay on the safe
side.

I have cooked up a patch based on this. It uses printk_deferred()
in NMI when it is safe. Note that console_flush_on_panic() will
try to get them on the console when a kdump is not generated.
I believe that it will help Steven.


From c530d9dee91c74db5e6a198479e2e63b24cb84a2 Mon Sep 17 00:00:00 2001
From: Petr Mladek <pmladek@suse.com>
Date: Thu, 20 Apr 2017 10:52:31 +0200
Subject: [PATCH] printk: Use the main logbuf in NMI when logbuf_lock is
 available

The commit 42a0bb3f71383b457a7d ("printk/nmi: generic solution for safe
printk in NMI") caused that printk stores messages into a temporary
buffer in NMI context.

The buffer is per-CPU and therefore the size is rather limited.
It works quite well for NMI backtraces. But there are longer logs
that might get printed in NMI context, for example, lockdep
warnings, ftrace_dump_on_oops.

The temporary buffer is used to avoid deadlocks caused by
logbuf_lock. Also it is needed to avoid races with the other
temporary buffer that is used when PRINTK_SAFE_CONTEXT is entered.
But the main buffer can be used in NMI if the lock is available
and we did not interrupt PRINTK_SAFE_CONTEXT.

The lock is checked using raw_spin_is_locked(). It might cause
false negatives when the lock is taken on another CPU outside NMI.
For this reason, we do the check in printk_nmi_enter(). It makes
the handling consistent for the entire NMI handler and avoids
reshuffling of the messages.

The patch also defines special printk context that allows
to use printk_deferred() in NMI. Note that we could not flush
the messages to the consoles because console drivers might use
many other internal locks.

The newly created vprintk_deferred() disables the preemption
only around the irq work handling. It is needed there to keep
the consistency between the two per-CPU variables. But there
is no reason to disable preemption around vprintk_emit().

Finally, the patch patch puts back explicit serialization
of the NMI backtraces from different CPUs. It was removed
by the commit a9edc88093287183ac934b ("x86/nmi: Perform
a safe NMI stack trace on all CPUs"). It was not needed
because the flushing of the temporary per-CPU buffers
was serialized.

Suggested-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Signed-off-by: Petr Mladek <pmladek@suse.com>
---
 kernel/printk/internal.h    |  6 ++++--
 kernel/printk/printk.c      | 19 ++++++++++++++-----
 kernel/printk/printk_safe.c | 25 +++++++++++++++++++++++--
 lib/nmi_backtrace.c         |  3 +++
 4 files changed, 44 insertions(+), 9 deletions(-)

diff --git a/kernel/printk/internal.h b/kernel/printk/internal.h
index 1db044f808b7..2a7d04049af4 100644
--- a/kernel/printk/internal.h
+++ b/kernel/printk/internal.h
@@ -18,12 +18,14 @@
=20
 #ifdef CONFIG_PRINTK
=20
-#define PRINTK_SAFE_CONTEXT_MASK	0x7fffffff
-#define PRINTK_NMI_CONTEXT_MASK	0x80000000
+#define PRINTK_SAFE_CONTEXT_MASK	 0x3fffffff
+#define PRINTK_NMI_DEFERRED_CONTEXT_MASK 0x40000000
+#define PRINTK_NMI_CONTEXT_MASK		 0x80000000
=20
 extern raw_spinlock_t logbuf_lock;
=20
 __printf(1, 0) int vprintk_default(const char *fmt, va_list args);
+__printf(1, 0) int vprintk_deferred(const char *fmt, va_list args);
 __printf(1, 0) int vprintk_func(const char *fmt, va_list args);
 void __printk_safe_enter(void);
 void __printk_safe_exit(void);
diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 2984fb0f0257..16b519927d35 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -2691,16 +2691,13 @@ void wake_up_klogd(void)
 	preempt_enable();
 }
=20
-int printk_deferred(const char *fmt, ...)
+int vprintk_deferred(const char *fmt, va_list args)
 {
-	va_list args;
 	int r;
=20
-	preempt_disable();
-	va_start(args, fmt);
 	r =3D vprintk_emit(0, LOGLEVEL_SCHED, NULL, 0, fmt, args);
-	va_end(args);
=20
+	preempt_disable();
 	__this_cpu_or(printk_pending, PRINTK_PENDING_OUTPUT);
 	irq_work_queue(this_cpu_ptr(&wake_up_klogd_work));
 	preempt_enable();
@@ -2708,6 +2705,18 @@ int printk_deferred(const char *fmt, ...)
 	return r;
 }
=20
+int printk_deferred(const char *fmt, ...)
+{
+	va_list args;
+	int r;
+
+	va_start(args, fmt);
+	r =3D vprintk_deferred(fmt, args);
+	va_end(args);
+
+	return r;
+}
+
 /*
  * printk rate limiting, lifted from the networking subsystem.
  *
diff --git a/kernel/printk/printk_safe.c b/kernel/printk/printk_safe.c
index 033e50a7d706..c3d165bcde42 100644
--- a/kernel/printk/printk_safe.c
+++ b/kernel/printk/printk_safe.c
@@ -308,12 +308,23 @@ static int vprintk_nmi(const char *fmt, va_list args)
=20
 void printk_nmi_enter(void)
 {
-	this_cpu_or(printk_context, PRINTK_NMI_CONTEXT_MASK);
+	/*
+	 * The size of the extra per-CPU buffer is limited. Use it
+	 * only when really needed.
+	 */
+	if (this_cpu_read(printk_context) & PRINTK_SAFE_CONTEXT_MASK ||
+	    raw_spin_is_locked(&logbuf_lock)) {
+		this_cpu_or(printk_context, PRINTK_NMI_CONTEXT_MASK);
+	} else {
+		this_cpu_or(printk_context, PRINTK_NMI_DEFERRED_CONTEXT_MASK);
+	}
 }
=20
 void printk_nmi_exit(void)
 {
-	this_cpu_and(printk_context, ~PRINTK_NMI_CONTEXT_MASK);
+	this_cpu_and(printk_context,
+		     ~(PRINTK_NMI_CONTEXT_MASK ||
+		       PRINTK_NMI_DEFERRED_CONTEXT_MASK));
 }
=20
 #else
@@ -351,12 +362,22 @@ void __printk_safe_exit(void)
=20
 __printf(1, 0) int vprintk_func(const char *fmt, va_list args)
 {
+	/* Use extra buffer in NMI when logbuf_lock is taken or in safe mode. */
 	if (this_cpu_read(printk_context) & PRINTK_NMI_CONTEXT_MASK)
 		return vprintk_nmi(fmt, args);
=20
+	/* Use extra buffer to prevent a recursion deadlock in safe mode. */
 	if (this_cpu_read(printk_context) & PRINTK_SAFE_CONTEXT_MASK)
 		return vprintk_safe(fmt, args);
=20
+	/*
+	 * Use the main logbuf when logbuf_lock is available in NMI.
+	 * But avoid calling console drivers that might have their own locks.
+	 */
+	if (this_cpu_read(printk_context) & PRINTK_NMI_DEFERRED_CONTEXT_MASK)
+		return vprintk_deferred(fmt, args);
+
+	/* No obstacles. */
 	return vprintk_default(fmt, args);
 }
=20
diff --git a/lib/nmi_backtrace.c b/lib/nmi_backtrace.c
index 4e8a30d1c22f..0bc0a3535a8a 100644
--- a/lib/nmi_backtrace.c
+++ b/lib/nmi_backtrace.c
@@ -86,9 +86,11 @@ void nmi_trigger_cpumask_backtrace(const cpumask_t *mask,
=20
 bool nmi_cpu_backtrace(struct pt_regs *regs)
 {
+	static arch_spinlock_t lock =3D __ARCH_SPIN_LOCK_UNLOCKED;
 	int cpu =3D smp_processor_id();
=20
 	if (cpumask_test_cpu(cpu, to_cpumask(backtrace_mask))) {
+		arch_spin_lock(&lock);
 		if (regs && cpu_in_idle(instruction_pointer(regs))) {
 			pr_warn("NMI backtrace for cpu %d skipped: idling at pc %#lx\n",
 				cpu, instruction_pointer(regs));
@@ -99,6 +101,7 @@ bool nmi_cpu_backtrace(struct pt_regs *regs)
 			else
 				dump_stack();
 		}
+		arch_spin_unlock(&lock);
 		cpumask_clear_cpu(cpu, to_cpumask(backtrace_mask));
 		return true;
 	}
--=20
1.8.5.6

