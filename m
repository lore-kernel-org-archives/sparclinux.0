From: David Miller <davem@davemloft.net>
Date: Sun, 04 May 2014 05:27:10 +0000
Subject: [PATCH] sparc64: Normalize NMI watchdog logging and behavior.
Message-Id: <20140504.012710.2211195166500423039.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


Bring this code in line with the perf based generic NMI watchdog
in kernel/watchdog.c (which we should convert over to at some
point).

In particular, don't do anything super fancy when the watchdog
triggers, and specifically don't do a do_exit() which only makes
things worse.

Either panic(), or WARN().  The latter of which will do all of
the actions such as give us a stack backtrace.

Signed-off-by: David S. Miller <davem@davemloft.net>
---

I noticed this while trying to debug various kinds of hangs I can
trigger in 3.15, hopefully these adjustments make debugging easier
for other people as well.

Committed to 'sparc' GIT.

 arch/sparc/kernel/nmi.c | 21 +++++----------------
 1 file changed, 5 insertions(+), 16 deletions(-)

diff --git a/arch/sparc/kernel/nmi.c b/arch/sparc/kernel/nmi.c
index 6479256..3370945 100644
--- a/arch/sparc/kernel/nmi.c
+++ b/arch/sparc/kernel/nmi.c
@@ -68,27 +68,16 @@ EXPORT_SYMBOL(touch_nmi_watchdog);
 
 static void die_nmi(const char *str, struct pt_regs *regs, int do_panic)
 {
+	int this_cpu = smp_processor_id();
+
 	if (notify_die(DIE_NMIWATCHDOG, str, regs, 0,
 		       pt_regs_trap_type(regs), SIGINT) = NOTIFY_STOP)
 		return;
 
-	console_verbose();
-	bust_spinlocks(1);
-
-	printk(KERN_EMERG "%s", str);
-	printk(" on CPU%d, ip %08lx, registers:\n",
-	       smp_processor_id(), regs->tpc);
-	show_regs(regs);
-	dump_stack();
-
-	bust_spinlocks(0);
-
 	if (do_panic || panic_on_oops)
-		panic("Non maskable interrupt");
-
-	nmi_exit();
-	local_irq_enable();
-	do_exit(SIGBUS);
+		panic("Watchdog detected hard LOCKUP on cpu %d", this_cpu);
+	else
+		WARN(1, "Watchdog detected hard LOCKUP on cpu %d", this_cpu);
 }
 
 notrace __kprobes void perfctr_irq(int irq, struct pt_regs *regs)
-- 
1.8.1.2

