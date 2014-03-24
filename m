From: David Miller <davem@davemloft.net>
Date: Mon, 24 Mar 2014 16:53:58 +0000
Subject: Re: Generic idle causes boot hang on T1000
Message-Id: <20140324.125358.1420654948419843545.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <alpine.LSU.2.11.1403232347380.23553@nerf08.vanv.qr>
In-Reply-To: <alpine.LSU.2.11.1403232347380.23553@nerf08.vanv.qr>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Jan Engelhardt <jengelh@inai.de>
Date: Mon, 24 Mar 2014 11:33:30 +0100 (CET)

> 
> On Monday 2014-03-24 01:38, David Miller wrote:
>>> Trying to update beyond 3.9 gives me a boot hang on SPARC T1000.
>>> The following commit is the result of the bisect:
>>> 
>>> commit 87fa05aeb3a5e8e21b1a5510eef6983650eff092
>>> Author: Sam Ravnborg <sam@ravnborg.org>
>>> Date:   Thu Apr 11 21:38:50 2013 +0200
>>> 
>>>     sparc: Use generic idle loop
>>
>>Interesting.
>>
>>> mptbase: ioc0: Initiating bringup
>>> <hangs>
>>> 
>>> after ~1 minute:
>>> 
>>> INFO: rcu_sched self-detected stall on CPU { 0}  (t0061 jiffies
>>> g446744073709551319 c446744073709551318 qA4)
>>> INFO: rcu_sched detected stalls on CPUs/tasks:* CPU[  0]:
>>> TSTATE[0000000080001603] TPC[000000000042b9b4] TNPC[000000000042b9b8]
>>> TASK[swapper/0:0]
>>>              TPC[arch_cpu_idle+0x74/0xa0] O7[arch_cpu_idle+0x5c/0xa0]
>>>  I7[cpu_startup_entry+0x114/0x1a0] RPC[start_kernel+0x384/0x394]
>>
>>I suspect the cpu yield hypervisor call requires local cpu interrupts
>>to be enabled in order to function properly.  Prior to this commit
>>above, they did.
>>
>>Please try this:
>>
>>commit 87fa05aeb3a5e8e21b1a5510eef6983650eff092
> 
> This is the same commit as before (both in ID, as well as patch content).
> Did you intend to paste another patch?

My bad, I intended to post this:

diff --git a/arch/sparc/kernel/process_64.c b/arch/sparc/kernel/process_64.c
index 32a280e..d7b4967 100644
--- a/arch/sparc/kernel/process_64.c
+++ b/arch/sparc/kernel/process_64.c
@@ -58,9 +58,12 @@ void arch_cpu_idle(void)
 {
 	if (tlb_type != hypervisor) {
 		touch_nmi_watchdog();
+		local_irq_enable();
 	} else {
 		unsigned long pstate;
 
+		local_irq_enable();
+
                 /* The sun4v sleeping code requires that we have PSTATE.IE cleared over
                  * the cpu sleep hypervisor call.
                  */
@@ -82,7 +85,6 @@ void arch_cpu_idle(void)
 			: "=&r" (pstate)
 			: "i" (PSTATE_IE));
 	}
-	local_irq_enable();
 }
 
 #ifdef CONFIG_HOTPLUG_CPU
