From: David Miller <davem@davemloft.net>
Date: Thu, 09 Apr 2009 04:04:57 +0000
Subject: Re: inconsistent lock state in 2.6.29-rc6
Message-Id: <20090408.210457.60079516.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.SOC.4.64.0903040949120.6557@math.ut.ee>
In-Reply-To: <Pine.SOC.4.64.0903040949120.6557@math.ut.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Meelis Roos <mroos@linux.ee>
Date: Wed, 4 Mar 2009 09:51:50 +0200 (EET)

> This another problem from my 6-CPU E3000 - just got it while compiling 
> 2.6.29-rc7 but the compilation continues fine.
> 
> [  412.896568] ================> [  412.964373] [ INFO: inconsistent lock state ]
> [  413.016474] 2.6.29-rc6 #2
> [  413.047705] ---------------------------------
> [  413.099822] inconsistent {softirq-on-W} -> {in-softirq-W} usage.
> [  413.171717] cc1/2007 [HC0[0]:SC1[1]:HE0:SE0] takes:
> [  413.230048]  (call_function_lock){-+..}, at: [<000000000049003c>] generic_smp_call_function_interrupt+0x11c/0x1c0
> [  413.353010] {softirq-on-W} state was registered at:

Please try this patch:

diff --git a/arch/sparc/kernel/smp_64.c b/arch/sparc/kernel/smp_64.c
index f1c8208..1de47d2 100644
--- a/arch/sparc/kernel/smp_64.c
+++ b/arch/sparc/kernel/smp_64.c
@@ -119,9 +119,9 @@ void __cpuinit smp_callin(void)
 	while (!cpu_isset(cpuid, smp_commenced_mask))
 		rmb();
 
-	ipi_call_lock();
+	ipi_call_lock_irq();
 	cpu_set(cpuid, cpu_online_map);
-	ipi_call_unlock();
+	ipi_call_unlock_irq();
 
 	/* idle thread is expected to have preempt disabled */
 	preempt_disable();
