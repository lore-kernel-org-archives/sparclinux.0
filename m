From: Meelis Roos <mroos@linux.ee>
Date: Mon, 09 Mar 2009 21:32:31 +0000
Subject: Re: inconsistent lock state in 2.6.29-rc6
Message-Id: <Pine.SOC.4.64.0903092331140.22556@math.ut.ee>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.SOC.4.64.0903040949120.6557@math.ut.ee>
In-Reply-To: <Pine.SOC.4.64.0903040949120.6557@math.ut.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


Just got a similar one from 2.6.29-rc7+git, also during compilation 
(make -j12 on the same 6-CPU machine):

[88235.161904] 
[88235.161927] ================[88235.229699] [ INFO: inconsistent lock state ]
[88235.281798] 2.6.29-rc7 #5
[88235.313039] ---------------------------------
[88235.365144] inconsistent {softirq-on-W} -> {in-softirq-W} usage.
[88235.437048] cc1/5669 [HC0[0]:SC1[1]:HE0:SE0] takes:
[88235.495374]  (call_function_lock){-+..}, at: [<000000000049011c>] generic_smp_call_function_interrupt+0x11c/0x1c0
[88235.618340] {softirq-on-W} state was registered at:
[88235.676651]   [<000000000048a350>] lock_acquire+0x50/0x80
[88235.741236]   [<00000000006d7808>] _spin_lock+0x28/0x40
[88235.803745]   [<000000000048f8f4>] ipi_call_lock+0x14/0x40
[88235.869381]   [<00000000006d10c8>] smp_callin+0x100/0x148
[88235.933973]   [<00000000006d0d10>] after_lock_tlb+0x1ac/0x1cc
[88236.002740]   [<00000000004600b0>] wait_consider_task+0x3d0/0x9a0
[88236.075677] irq event stamp: 12251
[88236.116296] hardirqs last  enabled at (12250): [<00000000004639ec>] __do_softirq+0x6c/0x180
[88236.216337] hardirqs last disabled at (12251): [<0000000000426a20>] sys_call_table+0x510/0x770
[88236.319480] softirqs last  enabled at (12220): [<0000000000463ab4>] __do_softirq+0x134/0x180
[88236.420535] softirqs last disabled at (12249): [<000000000042ad10>] do_softirq+0xb0/0xe0
[88236.517420] 
[88236.517429] other info that might help us debug this:
[88236.595555] 1 lock held by cc1/5669:
[88236.638256]  #0:  (rcu_read_lock){..--}, at: [<0000000000490000>] generic_smp_call_function_interrupt+0x0/0x1c0
[88236.759146] 
[88236.759156] stack backtrace:
[88236.811197] Call Trace:
[88236.840381]  [00000000004863ec] print_usage_bug+0x16c/0x200
[88236.907076]  [0000000000487724] mark_lock+0xee4/0x1000
[88236.968538]  [0000000000488fb0] __lock_acquire+0x870/0x1bc0
[88237.035216]  [000000000048a350] lock_acquire+0x50/0x80
[88237.096682]  [00000000006d7808] _spin_lock+0x28/0x40
[88237.156072]  [000000000049011c] generic_smp_call_function_interrupt+0x11c/0x1c0
[88237.243632]  [000000000043cd60] smp_call_function_client+0x20/0x40
[88237.317555]  [0000000000426a2c] sys_call_table+0x51c/0x770
[88237.383191]  [00000000004639f8] __do_softirq+0x78/0x180
[88237.445702]  [000000000042ad10] do_softirq+0xb0/0xe0
[88237.505079]  [0000000000463494] irq_exit+0x94/0xc0
[88237.562396]  [0000000000430510] timer_interrupt+0x90/0xc0
[88237.626980]  [0000000000426ad4] sys_call_table+0x5c4/0x770

-- 
Meelis Roos (mroos@linux.ee)
