From: Ben Collins <bcollins@debian.org>
Date: Wed, 25 Feb 2004 03:09:13 +0000
Subject: Re: oops in sched_init() on E3000
Message-Id: <20040225030913.GQ468@phunnypharm.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20040222043448.GG703@holomorphy.com>
In-Reply-To: <20040222043448.GG703@holomorphy.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

I had a feeling this whole problem with the IRQ's was another
smp_processor_id() issue.

Dave, the first time that init_irqwork_curcpu() gets called from head.S
for the boot cpu, smp_processor_id() is returning 0, so the __irq_work
isn't getting setup properly. Hopefully this is the last issue with
this.

The attached patch fixes it. It's in my repo, so you can pull it along
with the debug rwlock fix I sent you earlier.



diff -Nru a/arch/sparc64/kernel/irq.c b/arch/sparc64/kernel/irq.c
--- a/arch/sparc64/kernel/irq.c	Tue Feb 24 22:07:06 2004
+++ b/arch/sparc64/kernel/irq.c	Tue Feb 24 22:07:06 2004
@@ -1104,8 +1104,9 @@
 {
 	register struct irq_work_struct *workp asm("o2");
 	unsigned long tmp;
+	int cpu = hard_smp_processor_id();
 
-	memset(__irq_work + smp_processor_id(), 0, sizeof(*workp));
+	memset(__irq_work + cpu, 0, sizeof(*workp));
 
 	/* Make sure we are called with PSTATE_IE disabled.  */
 	__asm__ __volatile__("rdpr	%%pstate, %0\n\t"
@@ -1120,7 +1121,7 @@
 	}
 
 	/* Set interrupt globals.  */
-	workp = &__irq_work[smp_processor_id()];
+	workp = &__irq_work[cpu];
 	__asm__ __volatile__(
 	"rdpr	%%pstate, %0\n\t"
 	"wrpr	%0, %1, %%pstate\n\t"

-- 
Debian     - http://www.debian.org/
Linux 1394 - http://www.linux1394.org/
Subversion - http://subversion.tigris.org/
WatchGuard - http://www.watchguard.com/
