From: Patrick Finnegan <pat@computer-refuge.org>
Date: Wed, 12 May 2004 00:57:44 +0000
Subject: [PATCH] Re: BUG: 2.6.6-rc3 on SMP/SPARC64 (Sun E3000)?
Message-Id: <200405111957.44756.pat@computer-refuge.org>
List-Id: <sparclinux.vger.kernel.org>
References: <200405071049.14725.pat@computer-refuge.org>
In-Reply-To: <200405071049.14725.pat@computer-refuge.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org
Cc: brylow@cs.purdue.edu

On Friday 07 May 2004 10:49, you wrote:
> I've been trying to get 2.6.6-rc3 to work in SMP mode on my E3000
> without much success yet.  It boots fine with a uniprocessor kernel,
> but trying to enable SMP gives me this as the last few lines of the
> kernel messages (booted with -p early printk option):

It appears that the problem is that on Sparc64, smp_processor_id() gives
the hardware ID, not a logical number (ie 0..n for the first n+1 
processors).  I had NR_CPUS set to 8, and the first (boot) CPU was 
numbered by the hardware to be CPU 10.

The patch catches if the boot CPU is greater than NR_CPUS, since that is
possible with Sparc64.  I see that the condition is explicitly checked 
for in smp_tick_init(), but that must not get called soon enough to 
catch the problem (which manifested in sched_init()s call to
wake_up_forked_process() ), so I moved it to smp_prepare_boot_cpu().

Comments?

Pat
-- 
Purdue University ITAP/RCS        ---  http://www.itap.purdue.edu/rcs/
The Computer Refuge               ---  http://computer-refuge.org

--- linux-2.6.6.orig/arch/sparc64/kernel/smp.c  2004-05-09 21:31:55.000000000 -0500
+++ linux-2.6.6/arch/sparc64/kernel/smp.c       2004-05-11 19:46:15.692007000 -0500
@@ -1108,11 +1108,6 @@
        boot_cpu_id = hard_smp_processor_id();
        current_tick_offset = timer_tick_offset;

-       if (boot_cpu_id >= NR_CPUS) {
-               prom_printf("Serious problem, boot cpu id >= NR_CPUS\n");
-               prom_halt();
-       }
-
        cpu_set(boot_cpu_id, cpu_online_map);
        prof_counter(boot_cpu_id) = prof_multiplier(boot_cpu_id) = 1;
 }
@@ -1254,6 +1249,11 @@

 void __devinit smp_prepare_boot_cpu(void)
 {
+       if (hard_smp_processor_id() >= NR_CPUS) {
+               prom_printf("Serious problem, boot cpu id >= NR_CPUS\n");
+               prom_halt();
+       }
+
        current_thread_info()->cpu = hard_smp_processor_id();
        cpu_set(smp_processor_id(), cpu_online_map);
        cpu_set(smp_processor_id(), phys_cpu_present_map);
