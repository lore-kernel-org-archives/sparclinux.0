From: "David S. Miller" <davem@davemloft.net>
Date: Fri, 14 Oct 2005 22:27:52 +0000
Subject: Re: Ultra2 poweroff patch
Message-Id: <20051014.152752.48016660.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20050924092014.GA852@sparc>
In-Reply-To: <20050924092014.GA852@sparc>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Christopher Zimmermann <madroach@zakweb.de>
Date: Sat, 24 Sep 2005 11:20:14 +0200

> I don't know why, but the following change lets my Ultra2 poweroff.

Calling SUNW,stop-self turns out to be the wrong thing
to do when we're about to power-off or halt.

The best thing to do would be to quiesce the other
processors inside the kernel, and then make them
just spin in a loop.

But the safest fix is to simply kill the smp_promstop_others()
stuff, as in the patch below which I will push upstream.

Thanks.

diff-tree b4d1b825785847cddee6d104113da913f2ca8efb (from f75884d28a6eae5a422d0454b982da3842f777af)
Author: David S. Miller <davem@davemloft.net>
Date:   Fri Oct 14 15:26:08 2005 -0700

    [SPARC64]: Fix powering off on SMP.
    
    Doing a "SUNW,stop-self" firmware call on the other cpus is not the
    correct thing to do when dropping into the firmware for a halt,
    reboot, or power-off.
    
    For now, just do nothing to quiet the other cpus, as the system should
    be quiescent enough.  Later we may decide to implement smp_send_stop()
    like the other SMP platforms do.
    
    Based upon a report from Christopher Zimmermann.
    
    Signed-off-by: David S. Miller <davem@davemloft.net>

diff --git a/arch/sparc64/kernel/smp.c b/arch/sparc64/kernel/smp.c
index 590df5a..b137fd6 100644
--- a/arch/sparc64/kernel/smp.c
+++ b/arch/sparc64/kernel/smp.c
@@ -1001,13 +1001,6 @@ void smp_penguin_jailcell(int irq, struc
 	preempt_enable();
 }
 
-extern unsigned long xcall_promstop;
-
-void smp_promstop_others(void)
-{
-	smp_cross_call(&xcall_promstop, 0, 0, 0);
-}
-
 #define prof_multiplier(__cpu)		cpu_data(__cpu).multiplier
 #define prof_counter(__cpu)		cpu_data(__cpu).counter
 
diff --git a/arch/sparc64/mm/ultra.S b/arch/sparc64/mm/ultra.S
index 058b812..e4c9151 100644
--- a/arch/sparc64/mm/ultra.S
+++ b/arch/sparc64/mm/ultra.S
@@ -453,22 +453,6 @@ xcall_flush_dcache_page_spitfire: /* %g1
 	nop
 	nop
 
-	.globl		xcall_promstop
-xcall_promstop:
-	rdpr		%pstate, %g2
-	wrpr		%g2, PSTATE_IG | PSTATE_AG, %pstate
-	rdpr		%pil, %g2
-	wrpr		%g0, 15, %pil
-	sethi		%hi(109f), %g7
-	b,pt		%xcc, etrap_irq
-109:	 or		%g7, %lo(109b), %g7
-	flushw
-	call		prom_stopself
-	 nop
-	/* We should not return, just spin if we do... */
-1:	b,a,pt		%xcc, 1b
-	nop
-
 	.data
 
 errata32_hwbug:
diff --git a/arch/sparc64/prom/misc.c b/arch/sparc64/prom/misc.c
index 9b895fa..87f5cfc 100644
--- a/arch/sparc64/prom/misc.c
+++ b/arch/sparc64/prom/misc.c
@@ -68,19 +68,11 @@ void prom_cmdline(void)
 	local_irq_restore(flags);
 }
 
-#ifdef CONFIG_SMP
-extern void smp_promstop_others(void);
-#endif
-
 /* Drop into the prom, but completely terminate the program.
  * No chance of continuing.
  */
 void prom_halt(void)
 {
-#ifdef CONFIG_SMP
-	smp_promstop_others();
-	udelay(8000);
-#endif
 again:
 	p1275_cmd("exit", P1275_INOUT(0, 0));
 	goto again; /* PROM is out to get me -DaveM */
@@ -88,10 +80,6 @@ again:
 
 void prom_halt_power_off(void)
 {
-#ifdef CONFIG_SMP
-	smp_promstop_others();
-	udelay(8000);
-#endif
 	p1275_cmd("SUNW,power-off", P1275_INOUT(0, 0));
 
 	/* if nothing else helps, we just halt */
