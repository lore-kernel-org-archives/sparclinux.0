From: David Miller <davem@davemloft.net>
Date: Tue, 15 Sep 2009 08:08:39 +0000
Subject: Re: Sparc release requalification
Message-Id: <20090915.010839.161719031.davem@davemloft.net>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="--Next_Part(Tue_Sep_15_01_08_39_2009_681)--"
List-Id: <sparclinux.vger.kernel.org>
References: <4AA427E6.5000801@nerim.net>
In-Reply-To: <4AA427E6.5000801@nerim.net>
To: sparclinux@vger.kernel.org

----Next_Part(Tue_Sep_15_01_08_39_2009_681)--
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

From: Josip Rodin <joy@entuzijast.net>
Date: Mon, 14 Sep 2009 14:36:48 +0200

> It seems to work just fine without SMP.
> 
> This is start_watchdog(), writing picl_value(nmi_hz)=-17214228922368000 into PIC...
> This is nmi_init(), entering check_nmi_watchdog()...
> Testing NMI watchdog ... OK.
> [...]

Ok, great.

This is all so strange because I have the exact same cpu types
and cpu numbers as these V240's that see the problems.

Ok, next test.  Rebuild SMP and try the following two patches,
one at a time.

1) The first patch disables the idle spin loop used to help
   ensure the cpu is actually executing instructions during
   the NMI test.

   This might be it because this doesn't actually even get used
   in UP builds.

2) The second patch forces the NMI interrupt handler to only
   end up executing once.  The NMI test will fail if this
   test "fixes" things, and it's to see if somehow the
   rescheduling of the NMI event is to blame.

Thanks!

----Next_Part(Tue_Sep_15_01_08_39_2009_681)--
Content-Type: Text/X-Patch; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline; filename="test1.diff"

diff --git a/arch/sparc/kernel/nmi.c b/arch/sparc/kernel/nmi.c
index 2c0cc72..21ec244 100644
--- a/arch/sparc/kernel/nmi.c
+++ b/arch/sparc/kernel/nmi.c
@@ -164,7 +164,8 @@ static int __init check_nmi_watchdog(void)
 
 	printk(KERN_INFO "Testing NMI watchdog ... ");
 
-	smp_call_function(nmi_cpu_busy, (void *)&endflag, 0);
+	if (0)
+		smp_call_function(nmi_cpu_busy, (void *)&endflag, 0);
 
 	for_each_possible_cpu(cpu)
 		prev_nmi_count[cpu] = get_nmi_count(cpu);

----Next_Part(Tue_Sep_15_01_08_39_2009_681)--
Content-Type: Text/X-Patch; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline; filename="test2.diff"

diff --git a/arch/sparc/kernel/nmi.c b/arch/sparc/kernel/nmi.c
index 2c0cc72..b985ae8 100644
--- a/arch/sparc/kernel/nmi.c
+++ b/arch/sparc/kernel/nmi.c
@@ -110,10 +110,12 @@ notrace __kprobes void perfctr_irq(int irq, struct pt_regs *regs)
 		__get_cpu_var(last_irq_sum) = sum;
 		local_set(&__get_cpu_var(alert_counter), 0);
 	}
+#if 0
 	if (nmi_usable) {
 		write_pic(picl_value(nmi_hz));
 		pcr_ops->write(pcr_enable);
 	}
+#endif
 }
 
 static inline unsigned int get_nmi_count(int cpu)

----Next_Part(Tue_Sep_15_01_08_39_2009_681)----
