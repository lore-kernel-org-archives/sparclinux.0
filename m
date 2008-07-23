From: David Miller <davem@davemloft.net>
Date: Wed, 23 Jul 2008 23:23:03 +0000
Subject: Re: sparc64 show_stack() prints garbage
Message-Id: <20080723.162303.31721608.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20080723094154.GD14846@cs181140183.pp.htv.fi>
In-Reply-To: <20080723094154.GD14846@cs181140183.pp.htv.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Adrian Bunk <bunk@kernel.org>
Date: Wed, 23 Jul 2008 12:41:54 +0300

> http://bugzilla.kernel.org/show_bug.cgi?id139 contains a bug report 
> with the following trace:
> 
> ------------[ cut here ]------------                                            
> WARNING: at drivers/cpufreq/cpufreq.c:1391
> cpufreq_register_notifier+0x50/0x60()
> Modules linked in:                                                              
> Call Trace:                                                                     
>  [0000000000605270] cpufreq_register_notifier+0x58/0x60                         
>  [00000000007708e0] start_kernel+0x1f0/0x324                                    
>  [0000000000680e08] auxio_probe+0x0/0xe8                                        
>  [0000000000000000] 0x8                                                         
> ---[ end trace 139ce121c98e96c9 ]---
> 
> The first two lines of the trace are correct (and comment #3 contains a 
> description what the bug is), but the latter two lines are obviously 
> garbage.
> 
> The problem might be related to the fact that a WARN_ON was triggered 
> during time_init(), which runs quite early after bootup.
> 

The stack backtrace issues should have been fixed by:

commit 14d2c68baa659cfd15dc782dd229ea304330c4f6
Author: David S. Miller <davem@davemloft.net>
Date:   Wed May 21 18:15:53 2008 -0700

    sparc64: Fix stack tracing through trap frames.
    
    The offset to the pt_regs area was wrong, so we weren't
    looking at the right location for the magic cookie.
    
    A trap frame is composed of a "struct sparc_stackf" then
    a "struct pt_regs", the code was using "struct reg_window"
    instead of "struct sparc_stackf".
    
    Signed-off-by: David S. Miller <davem@davemloft.net>

As for the bug itself, it should be fixed by the following:
(I noticed after writing this patch that someone wrote a suggested
fix already and attached it to the bugzilla, things like that get
lost, which is why I absolutely hate bugzilla, the bug and the
patches for the bug should always be discussed on the mailing list
at least for things I maintain and care about)

I'll push this to -stable as well.

sparc64: Fix cpufreq notifier registry.

Based upon a report by Daniel Smolik.

We do it too early, which triggers a BUG in
cpufreq_register_notifier().

Signed-off-by: David S. Miller <davem@davemloft.net>
---
 arch/sparc64/kernel/time.c |   15 ++++++++++-----
 1 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/arch/sparc64/kernel/time.c b/arch/sparc64/kernel/time.c
index bedc4c1..a0c6a97 100644
--- a/arch/sparc64/kernel/time.c
+++ b/arch/sparc64/kernel/time.c
@@ -884,6 +884,16 @@ static struct notifier_block sparc64_cpufreq_notifier_block = {
 	.notifier_call	= sparc64_cpufreq_notifier
 };
 
+static int __init register_sparc64_cpufreq_notifier(void)
+{
+
+	cpufreq_register_notifier(&sparc64_cpufreq_notifier_block,
+				  CPUFREQ_TRANSITION_NOTIFIER);
+	return 0;
+}
+
+core_initcall(register_sparc64_cpufreq_notifier);
+
 #endif /* CONFIG_CPU_FREQ */
 
 static int sparc64_next_event(unsigned long delta,
@@ -1050,11 +1060,6 @@ void __init time_init(void)
 	       sparc64_clockevent.mult, sparc64_clockevent.shift);
 
 	setup_sparc64_timer();
-
-#ifdef CONFIG_CPU_FREQ
-	cpufreq_register_notifier(&sparc64_cpufreq_notifier_block,
-				  CPUFREQ_TRANSITION_NOTIFIER);
-#endif
 }
 
 unsigned long long sched_clock(void)
-- 
1.6.0.rc0.14.g95f8

