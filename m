From: Bernd Zeimetz <bernd@bzed.de>
Date: Fri, 16 Nov 2007 21:17:07 +0000
Subject: Re: Fix for sparc64 cpu hangs.
Message-Id: <473E08D3.1000507@bzed.de>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="------------090206030708060005040607"
List-Id: <sparclinux.vger.kernel.org>
References: <20071106.203433.144763156.davem@davemloft.net>
In-Reply-To: <20071106.203433.144763156.davem@davemloft.net>
To: sparclinux@vger.kernel.org

This is a multi-part message in MIME format.
--------------090206030708060005040607
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Hi David,

> Please let me know if things go smoothly when the
> build becomes active again.

first the good news:
The U60 here still building and working fine, also I didn't hear any bad
news from lebrun.d.o.

the not so good news:
the v880 (4x US III) here was hit by a stuck process again, after
running fine for some time now. But the machine didn't freeze, one CPU
was running at 100%, but otherwise the machine was responsible.

I think I'll also run a full diag in service mode to make it's not a CPU
bug.
The sysrq-g output is attached, I hope you can make sense out of it.
We'll also add some extra workload to the other machines here to try to
trigger the bug on other CPUs, too.

Best regards,

Bernd

-- 
Bernd Zeimetz
<bernd@bzed.de>                         <http://bzed.de/>

--------------090206030708060005040607
Content-Type: text/plain;
 name="v880-sysrq-g.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="v880-sysrq-g.txt"

Nov 16 21:40:57 titan kernel: [12019.840715] SysRq : Show Global CPU Regs
Nov 16 21:40:57 titan kernel: [12019.886698]   CPU[  0]: TSTATE[0000000000000000] TPC[0000000000000000] TNPC[0000000000000000] TASK[NULL:-1]
Nov 16 21:40:57 titan kernel: [12020.003361]              TPC[atomic_sub_ret+0x0/0x30]
Nov 16 21:40:58 titan kernel: [12020.063757]              O7[schedule+0x6dc/0x7a4]
Nov 16 21:40:58 titan kernel: [12020.120007]              I7[do_syslog+0xfc/0x400]
Nov 16 21:40:58 titan kernel: [12020.176249] * CPU[  1]: TSTATE[0000000000000000] TPC[0000000000000000] TNPC[0000000000000000] TASK[bash:3157]
Nov 16 21:40:58 titan kernel: [12020.295006]   CPU[  2]: TSTATE[0000000011009602] TPC[000000000042fc30] TNPC[000000000042fc34] TASK[cat:4365]
Nov 16 21:40:58 titan kernel: [12020.412726]              TPC[udelay+0x0/0x1c]
Nov 16 21:40:58 titan kernel: [12020.464809]              O7[cheetah_xcall_deliver+0x1b8/0x23c]
Nov 16 21:40:58 titan kernel: [12020.534581]              I7[flush_dcache_page_all+0x178/0x240]
Nov 16 21:40:58 titan kernel: [12020.604370]   CPU[  3]: TSTATE[0000004480009602] TPC[00000000004288a0] TNPC[00000000004288a4] TASK[swapper:0]
Nov 16 21:40:58 titan kernel: [12020.723128]              TPC[cpu_idle+0x94/0xb8]
Nov 16 21:40:58 titan kernel: [12020.778323]              O7[cpu_idle+0xa8/0xb8]
Nov 16 21:40:58 titan kernel: [12020.832498]              I7[start_kernel+0x31c/0x32c]
Nov 16 21:41:05 titan ntpd[2766]: adjusting local clock by -20.711568s
Nov 16 21:41:26 titan kernel: [12048.836922] SysRq : Show Global CPU Regs
Nov 16 21:41:26 titan kernel: [12048.882885] * CPU[  0]: TSTATE[0000000000000000] TPC[0000000000000000] TNPC[0000000000000000] TASK[bash:3157]
Nov 16 21:41:26 titan kernel: [12049.001617]   CPU[  1]: TSTATE[0000009911009602] TPC[0000000000407af0] TNPC[0000000000407af4] TASK[swapper:0]
Nov 16 21:41:27 titan kernel: [12049.120373]              TPC[__tsb_context_switch+0xf0/0x100]
Nov 16 21:41:27 titan kernel: [12049.189109]              O7[schedule+0x514/0x7a4]
Nov 16 21:41:27 titan kernel: [12049.245354]              I7[cpu_idle+0xa8/0xb8]
Nov 16 21:41:27 titan kernel: [12049.299516]   CPU[  2]: TSTATE[0000000011009603] TPC[000000000042faa0] TNPC[000000000042fc18] TASK[cat:4365]
Nov 16 21:41:27 titan kernel: [12049.417244]              TPC[stick_get_tick+0x10/0x14]
Nov 16 21:41:27 titan kernel: [12049.478681]              O7[__delay+0x28/0x48]
Nov 16 21:41:27 titan kernel: [12049.531809]              I7[cheetah_xcall_deliver+0x1b8/0x23c]
Nov 16 21:41:27 titan kernel: [12049.601598]   CPU[  3]: TSTATE[0000004480009602] TPC[00000000004288a0] TNPC[00000000004288a4] TASK[swapper:0]
Nov 16 21:41:27 titan kernel: [12049.720351]              TPC[cpu_idle+0x94/0xb8]
Nov 16 21:41:27 titan kernel: [12049.775551]              O7[cpu_idle+0xa8/0xb8]
Nov 16 21:41:27 titan kernel: [12049.829725]              I7[start_kernel+0x31c/0x32c]
Nov 16 21:41:28 titan kernel: [12050.571422] SysRq : Show Global CPU Regs
Nov 16 21:41:28 titan kernel: [12050.617320] * CPU[  0]: TSTATE[0000000000000000] TPC[0000000000000000] TNPC[0000000000000000] TASK[bash:3157]
Nov 16 21:41:28 titan kernel: [12050.736074]   CPU[  1]: TSTATE[0000004411009604] TPC[000000000045731c] TNPC[0000000000457320] TASK[swapper:0]
Nov 16 21:41:28 titan kernel: [12050.854834]              TPC[update_stats_wait_end+0x24/0x88]
Nov 16 21:41:28 titan kernel: [12050.923565]              O7[sched_clock+0x10/0x30]
Nov 16 21:41:29 titan kernel: [12050.980856]              I7[pick_next_task_fair+0x24/0x44]
Nov 16 21:41:29 titan kernel: [12051.046480]   CPU[  2]: TSTATE[0000000011009602] TPC[0000000000441a78] TNPC[0000000000441a7c] TASK[cat:4365]
Nov 16 21:41:29 titan kernel: [12051.164194]              TPC[cheetah_xcall_deliver+0x174/0x23c]
Nov 16 21:41:29 titan kernel: [12051.235018]              O7[cheetah_xcall_deliver+0x6c/0x23c]
Nov 16 21:41:29 titan kernel: [12051.303771]              I7[flush_dcache_page_all+0x178/0x240]
Nov 16 21:41:29 titan kernel: [12051.373560]   CPU[  3]: TSTATE[0000004480009602] TPC[00000000004288a0] TNPC[00000000004288a4] TASK[swapper:0]
Nov 16 21:41:29 titan kernel: [12051.492314]              TPC[cpu_idle+0x94/0xb8]
Nov 16 21:41:29 titan kernel: [12051.547514]              O7[cpu_idle+0xa8/0xb8]
Nov 16 21:41:29 titan kernel: [12051.601683]              I7[start_kernel+0x31c/0x32c]
Nov 16 21:41:30 titan kernel: [12052.214441] SysRq : Show Global CPU Regs
Nov 16 21:41:30 titan kernel: [12052.260326] * CPU[  0]: TSTATE[0000000000000000] TPC[0000000000000000] TNPC[0000000000000000] TASK[bash:3157]
Nov 16 21:41:30 titan kernel: [12052.379078]   CPU[  1]: TSTATE[0000004411009604] TPC[000000000045731c] TNPC[0000000000457320] TASK[swapper:0]
Nov 16 21:41:30 titan kernel: [12052.497835]              TPC[update_stats_wait_end+0x24/0x88]
Nov 16 21:41:30 titan kernel: [12052.566571]              O7[sched_clock+0x10/0x30]
Nov 16 21:41:30 titan kernel: [12052.623860]              I7[pick_next_task_fair+0x24/0x44]
Nov 16 21:41:30 titan kernel: [12052.689485]   CPU[  2]: TSTATE[0000000011009602] TPC[0000000000441a78] TNPC[0000000000441a7c] TASK[cat:4365]
Nov 16 21:41:30 titan kernel: [12052.807200]              TPC[cheetah_xcall_deliver+0x174/0x23c]
Nov 16 21:41:30 titan kernel: [12052.878023]              O7[cheetah_xcall_deliver+0x6c/0x23c]
Nov 16 21:41:30 titan kernel: [12052.946773]              I7[flush_dcache_page_all+0x178/0x240]
Nov 16 21:41:30 titan kernel: [12053.016564]   CPU[  3]: TSTATE[0000004480009602] TPC[00000000004288a0] TNPC[00000000004288a4] TASK[swapper:0]
Nov 16 21:41:31 titan kernel: [12053.135319]              TPC[cpu_idle+0x94/0xb8]
Nov 16 21:41:31 titan kernel: [12053.190520]              O7[cpu_idle+0xa8/0xb8]
Nov 16 21:41:31 titan kernel: [12053.244688]              I7[start_kernel+0x31c/0x32c]
Nov 16 21:41:32 titan kernel: [12054.286796] SysRq : Show Global CPU Regs
Nov 16 21:41:33 titan kernel: [12054.332702] * CPU[  0]: TSTATE[0000000000000000] TPC[0000000000000000] TNPC[0000000000000000] TASK[bash:3157]
Nov 16 21:41:33 titan kernel: [12054.451456]   CPU[  1]: TSTATE[0000004411009604] TPC[00000000004572fc] TNPC[0000000000457300] TASK[swapper:0]
Nov 16 21:41:33 titan kernel: [12054.570213]              TPC[update_stats_wait_end+0x4/0x88]
Nov 16 21:41:33 titan kernel: [12054.637912]              O7[sched_clock+0x10/0x30]
Nov 16 21:41:33 titan kernel: [12054.695198]              I7[pick_next_task_fair+0x24/0x44]
Nov 16 21:41:33 titan kernel: [12054.760821]   CPU[  2]: TSTATE[0000000011009602] TPC[0000000000441a78] TNPC[0000000000441a7c] TASK[cat:4365]
Nov 16 21:41:33 titan kernel: [12054.878536]              TPC[cheetah_xcall_deliver+0x174/0x23c]
Nov 16 21:41:33 titan kernel: [12054.949358]              O7[cheetah_xcall_deliver+0x6c/0x23c]
Nov 16 21:41:33 titan kernel: [12055.018108]              I7[flush_dcache_page_all+0x178/0x240]
Nov 16 21:41:33 titan kernel: [12055.087900]   CPU[  3]: TSTATE[0000004480009602] TPC[00000000004288a0] TNPC[00000000004288a4] TASK[swapper:0]
Nov 16 21:41:33 titan kernel: [12055.206656]              TPC[cpu_idle+0x94/0xb8]
Nov 16 21:41:33 titan kernel: [12055.261852]              O7[cpu_idle+0xa8/0xb8]
Nov 16 21:41:33 titan kernel: [12055.316017]              I7[start_kernel+0x31c/0x32c]
Nov 16 21:41:34 titan kernel: [12056.187865] SysRq : Show Global CPU Regs
Nov 16 21:41:34 titan kernel: [12056.233830] * CPU[  0]: TSTATE[0000000000000000] TPC[0000000000000000] TNPC[0000000000000000] TASK[bash:3157]
Nov 16 21:41:34 titan kernel: [12056.352582]   CPU[  1]: TSTATE[0000004411009604] TPC[0000000000457300] TNPC[0000000000457304] TASK[swapper:0]
Nov 16 21:41:34 titan kernel: [12056.471342]              TPC[update_stats_wait_end+0x8/0x88]
Nov 16 21:41:34 titan kernel: [12056.539035]              O7[sched_clock+0x10/0x30]
Nov 16 21:41:34 titan kernel: [12056.596324]              I7[pick_next_task_fair+0x24/0x44]
Nov 16 21:41:34 titan kernel: [12056.661947]   CPU[  2]: TSTATE[0000000011009602] TPC[0000000000441a78] TNPC[0000000000441a7c] TASK[cat:4365]
Nov 16 21:41:34 titan kernel: [12056.779663]              TPC[cheetah_xcall_deliver+0x174/0x23c]
Nov 16 21:41:34 titan kernel: [12056.850487]              O7[cheetah_xcall_deliver+0x6c/0x23c]
Nov 16 21:41:34 titan kernel: [12056.919237]              I7[flush_dcache_page_all+0x178/0x240]
Nov 16 21:41:34 titan kernel: [12056.989027]   CPU[  3]: TSTATE[0000004480009602] TPC[00000000004288a0] TNPC[00000000004288a4] TASK[swapper:0]
Nov 16 21:41:35 titan kernel: [12057.107784]              TPC[cpu_idle+0x94/0xb8]
Nov 16 21:41:35 titan kernel: [12057.162981]              O7[cpu_idle+0xa8/0xb8]
Nov 16 21:41:35 titan kernel: [12057.217152]              I7[start_kernel+0x31c/0x32c]
Nov 16 21:41:35 titan kernel: [12057.839154] SysRq : Show Global CPU Regs
Nov 16 21:41:35 titan kernel: [12057.885062] * CPU[  0]: TSTATE[0000000000000000] TPC[0000000000000000] TNPC[0000000000000000] TASK[bash:3157]
Nov 16 21:41:35 titan kernel: [12058.003816]   CPU[  1]: TSTATE[0000004411009604] TPC[0000000000457358] TNPC[000000000045735c] TASK[swapper:0]
Nov 16 21:41:36 titan kernel: [12058.122573]              TPC[update_stats_wait_end+0x60/0x88]
Nov 16 21:41:36 titan kernel: [12058.191309]              O7[sched_clock+0x10/0x30]
Nov 16 21:41:36 titan kernel: [12058.248599]              I7[pick_next_task_fair+0x24/0x44]
Nov 16 21:41:36 titan kernel: [12058.314225]   CPU[  2]: TSTATE[0000000011009602] TPC[0000000000441a78] TNPC[0000000000441a7c] TASK[cat:4365]
Nov 16 21:41:36 titan kernel: [12058.431940]              TPC[cheetah_xcall_deliver+0x174/0x23c]
Nov 16 21:41:36 titan kernel: [12058.502763]              O7[cheetah_xcall_deliver+0x6c/0x23c]
Nov 16 21:41:36 titan kernel: [12058.571513]              I7[flush_dcache_page_all+0x178/0x240]
Nov 16 21:41:36 titan kernel: [12058.641304]   CPU[  3]: TSTATE[0000009980009602] TPC[000000000042888c] TNPC[0000000000428890] TASK[swapper:0]
Nov 16 21:41:36 titan kernel: [12058.760058]              TPC[cpu_idle+0x80/0xb8]
Nov 16 21:41:36 titan kernel: [12058.815257]              O7[cpu_idle+0xa8/0xb8]
Nov 16 21:41:36 titan kernel: [12058.869428]              I7[start_kernel+0x31c/0x32c]
Nov 16 21:41:37 titan kernel: [12059.540545] SysRq : Show Global CPU Regs
Nov 16 21:41:38 titan kernel: [12059.586508] * CPU[  0]: TSTATE[0000000000000000] TPC[0000000000000000] TNPC[0000000000000000] TASK[bash:3157]
Nov 16 21:41:38 titan kernel: [12059.705259]   CPU[  1]: TSTATE[0000004411009604] TPC[000000000045731c] TNPC[0000000000457320] TASK[swapper:0]
Nov 16 21:41:38 titan kernel: [12059.824017]              TPC[update_stats_wait_end+0x24/0x88]
Nov 16 21:41:38 titan kernel: [12059.892758]              O7[sched_clock+0x10/0x30]
Nov 16 21:41:38 titan kernel: [12059.950042]              I7[pick_next_task_fair+0x24/0x44]
Nov 16 21:41:38 titan kernel: [12060.015666]   CPU[  2]: TSTATE[0000000011009602] TPC[000000000044194c] TNPC[0000000000441950] TASK[cat:4365]
Nov 16 21:41:38 titan kernel: [12060.133384]              TPC[cheetah_xcall_deliver+0x48/0x23c]
Nov 16 21:41:38 titan kernel: [12060.203162]              O7[cheetah_xcall_deliver+0x1c0/0x23c]
Nov 16 21:41:38 titan kernel: [12060.272956]              I7[flush_dcache_page_all+0x178/0x240]
Nov 16 21:41:38 titan kernel: [12060.342746]   CPU[  3]: TSTATE[0000004480009602] TPC[00000000004288a0] TNPC[00000000004288a4] TASK[swapper:0]
Nov 16 21:41:38 titan kernel: [12060.461501]              TPC[cpu_idle+0x94/0xb8]
Nov 16 21:41:38 titan kernel: [12060.516701]              O7[cpu_idle+0xa8/0xb8]
Nov 16 21:41:38 titan kernel: [12060.570863]              I7[start_kernel+0x31c/0x32c]
Nov 16 21:41:39 titan kernel: [12061.338017] SysRq : Show Global CPU Regs
Nov 16 21:41:39 titan kernel: [12061.383989] * CPU[  0]: TSTATE[0000000000000000] TPC[0000000000000000] TNPC[0000000000000000] TASK[bash:3157]
Nov 16 21:41:39 titan kernel: [12061.502742]   CPU[  1]: TSTATE[0000004411009604] TPC[000000000045731c] TNPC[0000000000457320] TASK[swapper:0]
Nov 16 21:41:39 titan kernel: [12061.621500]              TPC[update_stats_wait_end+0x24/0x88]
Nov 16 21:41:39 titan kernel: [12061.690239]              O7[sched_clock+0x10/0x30]
Nov 16 21:41:39 titan kernel: [12061.747525]              I7[pick_next_task_fair+0x24/0x44]
Nov 16 21:41:39 titan kernel: [12061.813150]   CPU[  2]: TSTATE[0000000011009602] TPC[0000000000441a78] TNPC[0000000000441a7c] TASK[cat:4365]
Nov 16 21:41:39 titan kernel: [12061.930866]              TPC[cheetah_xcall_deliver+0x174/0x23c]
Nov 16 21:41:39 titan kernel: [12062.001689]              O7[cheetah_xcall_deliver+0x6c/0x23c]
Nov 16 21:41:40 titan kernel: [12062.070439]              I7[flush_dcache_page_all+0x178/0x240]
Nov 16 21:41:40 titan kernel: [12062.140230]   CPU[  3]: TSTATE[0000009980009602] TPC[000000000042888c] TNPC[0000000000428890] TASK[swapper:0]
Nov 16 21:41:40 titan kernel: [12062.258985]              TPC[cpu_idle+0x80/0xb8]
Nov 16 21:41:40 titan kernel: [12062.314182]              O7[cpu_idle+0xa8/0xb8]
Nov 16 21:41:40 titan kernel: [12062.368354]              I7[start_kernel+0x31c/0x32c]
Nov 16 21:41:41 titan kernel: [12063.040690] SysRq : Show Global CPU Regs
Nov 16 21:41:41 titan kernel: [12063.086578] * CPU[  0]: TSTATE[0000000000000000] TPC[0000000000000000] TNPC[0000000000000000] TASK[bash:3157]
Nov 16 21:41:41 titan kernel: [12063.205331]   CPU[  1]: TSTATE[0000004411009604] TPC[000000000045731c] TNPC[0000000000457320] TASK[swapper:0]
Nov 16 21:41:41 titan kernel: [12063.324089]              TPC[update_stats_wait_end+0x24/0x88]
Nov 16 21:41:41 titan kernel: [12063.392824]              O7[sched_clock+0x10/0x30]
Nov 16 21:41:41 titan kernel: [12063.450114]              I7[pick_next_task_fair+0x24/0x44]
Nov 16 21:41:41 titan kernel: [12063.515737]   CPU[  2]: TSTATE[0000000011009602] TPC[0000000000441a78] TNPC[0000000000441a7c] TASK[cat:4365]
Nov 16 21:41:41 titan kernel: [12063.633453]              TPC[cheetah_xcall_deliver+0x174/0x23c]
Nov 16 21:41:41 titan kernel: [12063.704277]              O7[cheetah_xcall_deliver+0x6c/0x23c]
Nov 16 21:41:41 titan kernel: [12063.773026]              I7[flush_dcache_page_all+0x178/0x240]
Nov 16 21:41:41 titan kernel: [12063.842816]   CPU[  3]: TSTATE[0000009980009602] TPC[000000000042888c] TNPC[0000000000428890] TASK[swapper:0]
Nov 16 21:41:41 titan kernel: [12063.961573]              TPC[cpu_idle+0x80/0xb8]
Nov 16 21:41:42 titan kernel: [12064.016772]              O7[cpu_idle+0xa8/0xb8]
Nov 16 21:41:42 titan kernel: [12064.070939]              I7[start_kernel+0x31c/0x32c]
Nov 16 21:41:43 titan kernel: [12065.460173] SysRq : Show Global CPU Regs
Nov 16 21:41:43 titan kernel: [12065.506145] * CPU[  0]: TSTATE[0000000000000000] TPC[0000000000000000] TNPC[0000000000000000] TASK[bash:3157]
Nov 16 21:41:43 titan kernel: [12065.624894]   CPU[  1]: TSTATE[0000004411009604] TPC[0000000000457300] TNPC[0000000000457304] TASK[swapper:0]
Nov 16 21:41:43 titan kernel: [12065.743649]              TPC[update_stats_wait_end+0x8/0x88]
Nov 16 21:41:43 titan kernel: [12065.811345]              O7[sched_clock+0x10/0x30]
Nov 16 21:41:43 titan kernel: [12065.868634]              I7[pick_next_task_fair+0x24/0x44]
Nov 16 21:41:43 titan kernel: [12065.934255]   CPU[  2]: TSTATE[0000000011009603] TPC[000000000042fc0c] TNPC[000000000042fc10] TASK[cat:4365]
Nov 16 21:41:44 titan kernel: [12066.051970]              TPC[__delay+0x24/0x48]
Nov 16 21:41:44 titan kernel: [12066.106127]              O7[__delay+0x10/0x48]
Nov 16 21:41:44 titan kernel: [12066.159254]              I7[cheetah_xcall_deliver+0x1b8/0x23c]
Nov 16 21:41:44 titan kernel: [12066.229046]   CPU[  3]: TSTATE[0000004480009602] TPC[00000000004288a0] TNPC[00000000004288a4] TASK[swapper:0]
Nov 16 21:41:44 titan kernel: [12066.347801]              TPC[cpu_idle+0x94/0xb8]
Nov 16 21:41:44 titan kernel: [12066.402999]              O7[cpu_idle+0xa8/0xb8]
Nov 16 21:41:44 titan kernel: [12066.457170]              I7[start_kernel+0x31c/0x32c]
Nov 16 21:41:45 titan kernel: [12067.584733] SysRq : Show Global CPU Regs
Nov 16 21:41:45 titan kernel: [12067.630702] * CPU[  0]: TSTATE[0000000000000000] TPC[0000000000000000] TNPC[0000000000000000] TASK[bash:3157]
Nov 16 21:41:45 titan kernel: [12067.749456]   CPU[  1]: TSTATE[0000004411009604] TPC[000000000045731c] TNPC[0000000000457320] TASK[swapper:0]
Nov 16 21:41:45 titan kernel: [12067.868214]              TPC[update_stats_wait_end+0x24/0x88]
Nov 16 21:41:45 titan kernel: [12067.936948]              O7[sched_clock+0x10/0x30]
Nov 16 21:41:46 titan kernel: [12067.994238]              I7[pick_next_task_fair+0x24/0x44]
Nov 16 21:41:46 titan kernel: [12068.059861]   CPU[  2]: TSTATE[0000000011009602] TPC[0000000000441a78] TNPC[0000000000441a7c] TASK[cat:4365]
Nov 16 21:41:46 titan kernel: [12068.177579]              TPC[cheetah_xcall_deliver+0x174/0x23c]
Nov 16 21:41:46 titan kernel: [12068.248401]              O7[cheetah_xcall_deliver+0x6c/0x23c]
Nov 16 21:41:46 titan kernel: [12068.317151]              I7[flush_dcache_page_all+0x178/0x240]
Nov 16 21:41:46 titan kernel: [12068.386940]   CPU[  3]: TSTATE[0000004480009602] TPC[00000000004288a0] TNPC[00000000004288a4] TASK[swapper:0]
Nov 16 21:41:46 titan kernel: [12068.505696]              TPC[cpu_idle+0x94/0xb8]
Nov 16 21:41:46 titan kernel: [12068.560896]              O7[cpu_idle+0xa8/0xb8]
Nov 16 21:41:46 titan kernel: [12068.615067]              I7[start_kernel+0x31c/0x32c]
Nov 16 21:44:55 titan kernel: [12257.158581] SysRq : Show Global CPU Regs
Nov 16 21:44:55 titan kernel: [12257.204566] * CPU[  0]: TSTATE[0000000000000000] TPC[0000000000000000] TNPC[0000000000000000] TASK[bash:3157]
Nov 16 21:44:55 titan kernel: [12257.323298]   CPU[  1]: TSTATE[0000008811009602] TPC[000000000067b45c] TNPC[000000000067b460] TASK[swapper:0]
Nov 16 21:44:55 titan kernel: [12257.442053]              TPC[schedule+0x4b8/0x7a4]
Nov 16 21:44:55 titan kernel: [12257.499328]              O7[schedule+0x4a4/0x7a4]
Nov 16 21:44:55 titan kernel: [12257.555582]              I7[cpu_idle+0xa8/0xb8]
Nov 16 21:44:55 titan kernel: [12257.609743]   CPU[  2]: TSTATE[0000009911009603] TPC[000000000053a2a0] TNPC[000000000053a2a4] TASK[cat:4365]
Nov 16 21:44:55 titan kernel: [12257.727474]              TPC[find_next_bit+0x14/0x11c]
Nov 16 21:44:55 titan kernel: [12257.788911]              O7[__first_cpu+0xc/0x28]
Nov 16 21:44:55 titan kernel: [12257.845162]              I7[cheetah_xcall_deliver+0x1c0/0x23c]
Nov 16 21:44:55 titan kernel: [12257.914950]   CPU[  3]: TSTATE[0000004480009602] TPC[00000000004288a0] TNPC[00000000004288a4] TASK[swapper:0]
Nov 16 21:44:55 titan kernel: [12258.033705]              TPC[cpu_idle+0x94/0xb8]
Nov 16 21:44:55 titan kernel: [12258.088902]              O7[cpu_idle+0xa8/0xb8]
Nov 16 21:44:56 titan kernel: [12258.143075]              I7[start_kernel+0x31c/0x32c]
Nov 16 21:44:56 titan kernel: [12258.631365] SysRq : Show Global CPU Regs
Nov 16 21:44:56 titan kernel: [12258.677343] * CPU[  0]: TSTATE[0000000000000000] TPC[0000000000000000] TNPC[0000000000000000] TASK[bash:3157]
Nov 16 21:44:56 titan kernel: [12258.796095]   CPU[  1]: TSTATE[0000009911009602] TPC[0000000000407af0] TNPC[0000000000407af4] TASK[swapper:0]
Nov 16 21:44:56 titan kernel: [12258.914849]              TPC[__tsb_context_switch+0xf0/0x100]
Nov 16 21:44:56 titan kernel: [12258.983586]              O7[schedule+0x514/0x7a4]
Nov 16 21:44:56 titan kernel: [12259.039832]              I7[cpu_idle+0xa8/0xb8]
Nov 16 21:44:56 titan kernel: [12259.094002]   CPU[  2]: TSTATE[0000000011009602] TPC[0000000000441a78] TNPC[0000000000441a7c] TASK[cat:4365]
Nov 16 21:44:57 titan kernel: [12259.211716]              TPC[cheetah_xcall_deliver+0x174/0x23c]
Nov 16 21:44:57 titan kernel: [12259.282539]              O7[cheetah_xcall_deliver+0x6c/0x23c]
Nov 16 21:44:57 titan kernel: [12259.351292]              I7[flush_dcache_page_all+0x178/0x240]
Nov 16 21:44:57 titan kernel: [12259.421080]   CPU[  3]: TSTATE[0000004480009602] TPC[00000000004288a0] TNPC[00000000004288a4] TASK[swapper:0]
Nov 16 21:44:57 titan kernel: [12259.539836]              TPC[cpu_idle+0x94/0xb8]
Nov 16 21:44:57 titan kernel: [12259.595034]              O7[cpu_idle+0xa8/0xb8]
Nov 16 21:44:57 titan kernel: [12259.649205]              I7[start_kernel+0x31c/0x32c]
Nov 16 21:44:58 titan kernel: [12260.261944] SysRq : Show Global CPU Regs
Nov 16 21:44:58 titan kernel: [12260.307849] * CPU[  0]: TSTATE[0000000000000000] TPC[0000000000000000] TNPC[0000000000000000] TASK[bash:3157]
Nov 16 21:44:58 titan kernel: [12260.426600]   CPU[  1]: TSTATE[0000000011009602] TPC[000000000067b520] TNPC[000000000067b524] TASK[swapper:0]
Nov 16 21:44:58 titan kernel: [12260.545350]              TPC[schedule+0x57c/0x7a4]
Nov 16 21:44:58 titan kernel: [12260.602630]              O7[schedule+0x570/0x7a4]
Nov 16 21:44:58 titan kernel: [12260.658881]              I7[cpu_idle+0xa8/0xb8]
Nov 16 21:44:58 titan kernel: [12260.713048]   CPU[  2]: TSTATE[0000000011009602] TPC[000000000042fc3c] TNPC[000000000042fc40] TASK[cat:4365]
Nov 16 21:44:58 titan kernel: [12260.830769]              TPC[udelay+0xc/0x1c]
Nov 16 21:44:58 titan kernel: [12260.882836]              O7[cheetah_xcall_deliver+0x1b8/0x23c]
Nov 16 21:44:58 titan kernel: [12260.952629]              I7[flush_dcache_page_all+0x178/0x240]
Nov 16 21:44:58 titan kernel: [12261.022419]   CPU[  3]: TSTATE[0000004480009602] TPC[00000000004288a0] TNPC[00000000004288a4] TASK[swapper:0]
Nov 16 21:44:59 titan kernel: [12261.141175]              TPC[cpu_idle+0x94/0xb8]
Nov 16 21:44:59 titan kernel: [12261.196374]              O7[cpu_idle+0xa8/0xb8]
Nov 16 21:44:59 titan kernel: [12261.250543]              I7[start_kernel+0x31c/0x32c]
Nov 16 21:45:00 titan kernel: [12263.019145] SysRq : Show Global CPU Regs
Nov 16 21:45:01 titan kernel: [12263.065114] * CPU[  0]: TSTATE[0000000000000000] TPC[0000000000000000] TNPC[0000000000000000] TASK[bash:3157]
Nov 16 21:45:01 titan kernel: [12263.183867]   CPU[  1]: TSTATE[0000009911009602] TPC[0000000000407af0] TNPC[0000000000407af4] TASK[swapper:0]
Nov 16 21:45:01 titan kernel: [12263.302617]              TPC[__tsb_context_switch+0xf0/0x100]
Nov 16 21:45:01 titan kernel: [12263.371356]              O7[schedule+0x514/0x7a4]
Nov 16 21:45:01 titan kernel: [12263.427605]              I7[cpu_idle+0xa8/0xb8]
Nov 16 21:45:01 titan kernel: [12263.481771]   CPU[  2]: TSTATE[0000000011009602] TPC[0000000000441a78] TNPC[0000000000441a7c] TASK[cat:4365]
Nov 16 21:45:01 titan kernel: [12263.599488]              TPC[cheetah_xcall_deliver+0x174/0x23c]
Nov 16 21:45:01 titan kernel: [12263.670311]              O7[cheetah_xcall_deliver+0x6c/0x23c]
Nov 16 21:45:01 titan kernel: [12263.739061]              I7[flush_dcache_page_all+0x178/0x240]
Nov 16 21:45:01 titan kernel: [12263.808853]   CPU[  3]: TSTATE[0000009980009602] TPC[000000000042888c] TNPC[0000000000428890] TASK[swapper:0]
Nov 16 21:45:01 titan kernel: [12263.927608]              TPC[cpu_idle+0x80/0xb8]
Nov 16 21:45:01 titan kernel: [12263.982805]              O7[cpu_idle+0xa8/0xb8]
Nov 16 21:45:02 titan /USR/SBIN/CRON[4397]: (root) CMD (if [ -x /etc/munin/plugins/apt_all ]; then /etc/munin/plugins/apt_all update 7200 12 >/dev/null; elif [ -x /etc/munin/plugins/apt ]; then /etc/munin/plugins/apt update 7200 12 >/dev/null; fi)
Nov 16 21:45:02 titan kernel: [12264.036976]              I7[start_kernel+0x31c/0x32c]
Nov 16 21:45:02 titan kernel: [12264.567544] SysRq : Show Global CPU Regs
Nov 16 21:45:02 titan kernel: [12264.613433] * CPU[  0]: TSTATE[0000000000000000] TPC[0000000000000000] TNPC[0000000000000000] TASK[bash:3157]
Nov 16 21:45:02 titan kernel: [12264.732184]   CPU[  1]: TSTATE[0000008811009602] TPC[000000000067b448] TNPC[000000000067b44c] TASK[swapper:0]
Nov 16 21:45:02 titan kernel: [12264.850937]              TPC[schedule+0x4a4/0x7a4]
Nov 16 21:45:02 titan kernel: [12264.908214]              O7[schedule+0x3f0/0x7a4]
Nov 16 21:45:02 titan kernel: [12264.964465]              I7[cpu_idle+0xa8/0xb8]
Nov 16 21:45:02 titan kernel: [12265.018632]   CPU[  2]: TSTATE[0000000011009602] TPC[0000000000441a78] TNPC[0000000000441a7c] TASK[cat:4365]
Nov 16 21:45:03 titan kernel: [12265.136350]              TPC[cheetah_xcall_deliver+0x174/0x23c]
Nov 16 21:45:03 titan kernel: [12265.207173]              O7[cheetah_xcall_deliver+0x6c/0x23c]
Nov 16 21:45:03 titan kernel: [12265.275923]              I7[flush_dcache_page_all+0x178/0x240]
Nov 16 21:45:03 titan kernel: [12265.345713]   CPU[  3]: TSTATE[0000004480009602] TPC[00000000004288a0] TNPC[00000000004288a4] TASK[swapper:0]
Nov 16 21:45:03 titan kernel: [12265.464467]              TPC[cpu_idle+0x94/0xb8]
Nov 16 21:45:03 titan kernel: [12265.519665]              O7[cpu_idle+0xa8/0xb8]
Nov 16 21:45:03 titan kernel: [12265.573837]              I7[start_kernel+0x31c/0x32c]
Nov 16 21:45:04 titan kernel: [12267.080867] SysRq : Show Global CPU Regs
Nov 16 21:45:05 titan kernel: [12267.126742] * CPU[  0]: TSTATE[0000000000000000] TPC[0000000000000000] TNPC[0000000000000000] TASK[bash:3157]
Nov 16 21:45:05 titan kernel: [12267.245494]   CPU[  1]: TSTATE[0000008811009602] TPC[000000000067d0ec] TNPC[000000000067d0f0] TASK[swapper:0]
Nov 16 21:45:05 titan kernel: [12267.364246]              TPC[_spin_lock_irqsave+0x10/0x24]
Nov 16 21:45:05 titan kernel: [12267.429858]              O7[schedule+0x4a4/0x7a4]
Nov 16 21:45:05 titan kernel: [12267.486107]              I7[cpu_idle+0xa8/0xb8]
Nov 16 21:45:05 titan kernel: [12267.540275]   CPU[  2]: TSTATE[0000000011009602] TPC[0000000000441a78] TNPC[0000000000441a7c] TASK[cat:4365]
Nov 16 21:45:05 titan kernel: [12267.657992]              TPC[cheetah_xcall_deliver+0x174/0x23c]
Nov 16 21:45:05 titan kernel: [12267.728815]              O7[cheetah_xcall_deliver+0x6c/0x23c]
Nov 16 21:45:05 titan kernel: [12267.797566]              I7[flush_dcache_page_all+0x178/0x240]
Nov 16 21:45:05 titan kernel: [12267.867356]   CPU[  3]: TSTATE[0000009980009602] TPC[000000000042888c] TNPC[0000000000428890] TASK[swapper:0]
Nov 16 21:45:05 titan kernel: [12267.986110]              TPC[cpu_idle+0x80/0xb8]
Nov 16 21:45:05 titan kernel: [12268.041309]              O7[cpu_idle+0xa8/0xb8]
Nov 16 21:45:06 titan kernel: [12268.095478]              I7[start_kernel+0x31c/0x32c]
Nov 16 21:45:06 titan kernel: [12268.729495] SysRq : Show Global CPU Regs
Nov 16 21:45:06 titan kernel: [12268.775372] * CPU[  0]: TSTATE[0000000000000000] TPC[0000000000000000] TNPC[0000000000000000] TASK[bash:3157]
Nov 16 21:45:06 titan kernel: [12268.894124]   CPU[  1]: TSTATE[0000008811009602] TPC[000000000067d0ec] TNPC[000000000067d0f0] TASK[swapper:0]
Nov 16 21:45:06 titan kernel: [12269.012875]              TPC[_spin_lock_irqsave+0x10/0x24]
Nov 16 21:45:06 titan kernel: [12269.078489]              O7[schedule+0x4a4/0x7a4]
Nov 16 21:45:07 titan kernel: [12269.134739]              I7[cpu_idle+0xa8/0xb8]
Nov 16 21:45:07 titan kernel: [12269.188905]   CPU[  2]: TSTATE[0000000011009602] TPC[0000000000441a78] TNPC[0000000000441a7c] TASK[cat:4365]
Nov 16 21:45:07 titan kernel: [12269.306621]              TPC[cheetah_xcall_deliver+0x174/0x23c]
Nov 16 21:45:07 titan kernel: [12269.377444]              O7[cheetah_xcall_deliver+0x6c/0x23c]
Nov 16 21:45:07 titan kernel: [12269.446196]              I7[flush_dcache_page_all+0x178/0x240]
Nov 16 21:45:07 titan kernel: [12269.515986]   CPU[  3]: TSTATE[0000004480009602] TPC[00000000004288a0] TNPC[00000000004288a4] TASK[swapper:0]
Nov 16 21:45:07 titan kernel: [12269.634741]              TPC[cpu_idle+0x94/0xb8]
Nov 16 21:45:07 titan kernel: [12269.689942]              O7[cpu_idle+0xa8/0xb8]
Nov 16 21:45:07 titan kernel: [12269.744109]              I7[start_kernel+0x31c/0x32c]
Nov 16 21:45:08 titan kernel: [12270.317470] SysRq : Show Global CPU Regs
Nov 16 21:45:08 titan kernel: [12270.363381] * CPU[  0]: TSTATE[0000000000000000] TPC[0000000000000000] TNPC[0000000000000000] TASK[bash:3157]
Nov 16 21:45:08 titan kernel: [12270.482131]   CPU[  1]: TSTATE[0000008811009602] TPC[000000000067b440] TNPC[000000000067b444] TASK[swapper:0]
Nov 16 21:45:08 titan kernel: [12270.600881]              TPC[schedule+0x49c/0x7a4]
Nov 16 21:45:08 titan kernel: [12270.658160]              O7[schedule+0x3f0/0x7a4]
Nov 16 21:45:08 titan kernel: [12270.714411]              I7[cpu_idle+0xa8/0xb8]
Nov 16 21:45:08 titan kernel: [12270.768579]   CPU[  2]: TSTATE[0000000011009602] TPC[0000000000441a78] TNPC[0000000000441a7c] TASK[cat:4365]
Nov 16 21:45:08 titan kernel: [12270.886295]              TPC[cheetah_xcall_deliver+0x174/0x23c]
Nov 16 21:45:08 titan kernel: [12270.957116]              O7[cheetah_xcall_deliver+0x6c/0x23c]
Nov 16 21:45:08 titan kernel: [12271.025867]              I7[flush_dcache_page_all+0x178/0x240]
Nov 16 21:45:08 titan kernel: [12271.095658]   CPU[  3]: TSTATE[0000004480009602] TPC[00000000004288a0] TNPC[00000000004288a4] TASK[swapper:0]
Nov 16 21:45:09 titan kernel: [12271.214414]              TPC[cpu_idle+0x94/0xb8]
Nov 16 21:45:09 titan kernel: [12271.269613]              O7[cpu_idle+0xa8/0xb8]
Nov 16 21:45:09 titan kernel: [12271.323782]              I7[start_kernel+0x31c/0x32c]
Nov 16 21:45:09 titan kernel: [12272.052636] SysRq : Show Global CPU Regs
Nov 16 21:45:10 titan kernel: [12272.098570] * CPU[  0]: TSTATE[0000000000000000] TPC[0000000000000000] TNPC[0000000000000000] TASK[bash:3157]
Nov 16 21:45:10 titan kernel: [12272.217324]   CPU[  1]: TSTATE[0000009911009602] TPC[000000000067b408] TNPC[000000000067b40c] TASK[swapper:0]
Nov 16 21:45:10 titan kernel: [12272.336073]              TPC[schedule+0x464/0x7a4]
Nov 16 21:45:10 titan kernel: [12272.393352]              O7[schedule+0x3f0/0x7a4]
Nov 16 21:45:10 titan kernel: [12272.449605]              I7[cpu_idle+0xa8/0xb8]
Nov 16 21:45:10 titan kernel: [12272.503770]   CPU[  2]: TSTATE[0000000011009602] TPC[0000000000441a78] TNPC[0000000000441a7c] TASK[cat:4365]
Nov 16 21:45:10 titan kernel: [12272.621485]              TPC[cheetah_xcall_deliver+0x174/0x23c]
Nov 16 21:45:10 titan kernel: [12272.692308]              O7[cheetah_xcall_deliver+0x6c/0x23c]
Nov 16 21:45:10 titan kernel: [12272.761060]              I7[flush_dcache_page_all+0x178/0x240]
Nov 16 21:45:10 titan kernel: [12272.830851]   CPU[  3]: TSTATE[0000009980009602] TPC[000000000042888c] TNPC[0000000000428890] TASK[swapper:0]
Nov 16 21:45:10 titan kernel: [12272.949606]              TPC[cpu_idle+0x80/0xb8]
Nov 16 21:45:10 titan kernel: [12273.004804]              O7[cpu_idle+0xa8/0xb8]
Nov 16 21:45:10 titan kernel: [12273.058974]              I7[start_kernel+0x31c/0x32c]


--------------090206030708060005040607--
