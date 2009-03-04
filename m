From: Meelis Roos <mroos@linux.ee>
Date: Wed, 04 Mar 2009 07:51:50 +0000
Subject: inconsistent lock state in 2.6.29-rc6
Message-Id: <Pine.SOC.4.64.0903040949120.6557@math.ut.ee>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

This another problem from my 6-CPU E3000 - just got it while compiling 
2.6.29-rc7 but the compilation continues fine.

[  412.896568] ================[  412.964373] [ INFO: inconsistent lock state ]
[  413.016474] 2.6.29-rc6 #2
[  413.047705] ---------------------------------
[  413.099822] inconsistent {softirq-on-W} -> {in-softirq-W} usage.
[  413.171717] cc1/2007 [HC0[0]:SC1[1]:HE0:SE0] takes:
[  413.230048]  (call_function_lock){-+..}, at: [<000000000049003c>] generic_smp_call_function_interrupt+0x11c/0x1c0
[  413.353010] {softirq-on-W} state was registered at:
[  413.411319]   [<000000000048a270>] lock_acquire+0x50/0x80
[  413.475905]   [<00000000006d7708>] _spin_lock+0x28/0x40
[  413.538420]   [<000000000048f814>] ipi_call_lock+0x14/0x40
[  413.604053]   [<00000000006d0fe8>] smp_callin+0x100/0x148
[  413.668649]   [<00000000006d0c30>] after_lock_tlb+0x1ac/0x1cc
[  413.737408]   [<0000000000484d48>] trace_hardirqs_off_caller+0x8/0xc0
[  413.814515] irq event stamp: 26969
[  413.855132] hardirqs last  enabled at (26968): [<0000000000463a0c>] __do_softirq+0x6c/0x180
[  413.955170] hardirqs last disabled at (26969): [<0000000000426a20>] sys_call_table+0x510/0x770
[  414.058315] softirqs last  enabled at (26962): [<0000000000463ad4>] __do_softirq+0x134/0x180
[  414.159373] softirqs last disabled at (26967): [<000000000042acf0>] do_softirq+0xb0/0xe0
[  414.256269]
[  414.256278] other info that might help us debug this:
[  414.334389] 1 lock held by cc1/2007:
[  414.377083]  #0:  (rcu_read_lock){..--}, at: [<000000000048ff20>] generic_smp_call_function_interrupt+0x0/0x1c0
[  414.497975]
[  414.497983] stack backtrace:
[  414.550034] Call Trace:
[  414.579206]  [000000000048630c] print_usage_bug+0x16c/0x200
[  414.645902]  [0000000000487644] mark_lock+0xee4/0x1000
[  414.707365]  [0000000000488ed0] __lock_acquire+0x870/0x1bc0
[  414.774045]  [000000000048a270] lock_acquire+0x50/0x80
[  414.835514]  [00000000006d7708] _spin_lock+0x28/0x40
[  414.894899]  [000000000049003c] generic_smp_call_function_interrupt+0x11c/0x1c0
[  414.982462]  [000000000043cda0] smp_call_function_client+0x20/0x40
[  415.056383]  [0000000000426a2c] sys_call_table+0x51c/0x770
[  415.122013]  [0000000000463a18] __do_softirq+0x78/0x180
[  415.184527]  [000000000042acf0] do_softirq+0xb0/0xe0
[  415.243904]  [00000000004634b4] irq_exit+0x94/0xc0
[  415.301208]  [000000000042adf8] handler_irq+0xd8/0x120
[  415.362673]  [0000000000426a8c] sys_call_table+0x57c/0x770


-- 
Meelis Roos (mroos@linux.ee)
