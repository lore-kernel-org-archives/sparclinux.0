From: Bernd Zeimetz <bernd@bzed.de>
Date: Tue, 06 Nov 2007 03:51:07 +0000
Subject: Re: unkillable dpkg-query processes
Message-Id: <472FE4AB.60607@bzed.de>
List-Id: <sparclinux.vger.kernel.org>
References: <20071024223332.GA24557@keid.carnet.hr>
In-Reply-To: <20071024223332.GA24557@keid.carnet.hr>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


>> So I'm not sure if the result is really useful for you - if not just let
>> me know. I've attached the last ~10-20 sysrq-g outputs - as it was
>> running in a loop I have a ton of them. In case you're wondering: http
>> is aptitude's http method.
> 
> The http module is stuck in a different place, I'll try to
> see if I can make sense of it.


Here's also some output from apt-get which got stuck in my unstable
chroot while I wanted to retrieve the klibc source to try to debug it...

ov  6 04:43:19 titan kernel: [100896.376237] SysRq : Show Global CPU Regs
Nov  6 04:43:19 titan kernel: [100896.423254] * CPU[  0]: TSTATE[0000000000000000] TPC[0000000000000000] TNPC[0000000000000000] TASK[bash:11762]
Nov  6 04:43:19 titan kernel: [100896.544064]   CPU[  1]: TSTATE[0000004411009602] TPC[000000000067b59c] TNPC[000000000067b5a0] TASK[swapper:0]
Nov  6 04:43:19 titan kernel: [100896.663869]              TPC[schedule+0x5f8/0x7a4]
Nov  6 04:43:19 titan kernel: [100896.722179]              O7[schedule+0x5cc/0x7a4]
Nov  6 04:43:19 titan kernel: [100896.779474]              I7[cpu_idle+0xa8/0xb8]
Nov  6 04:43:19 titan kernel: [100896.834677]   CPU[  2]: TSTATE[0000009911009601] TPC[000000000042888c] TNPC[0000000000428890] TASK[swapper:0]
Nov  6 04:43:19 titan kernel: [100896.954474]              TPC[cpu_idle+0x80/0xb8]
Nov  6 04:43:19 titan kernel: [100897.010715]              O7[cpu_idle+0xa8/0xb8]
Nov  6 04:43:19 titan kernel: [100897.065932]              I7[after_lock_tlb+0x19c/0x1b0]
Nov  6 04:43:19 titan kernel: [100897.129468]   CPU[  3]: TSTATE[0000004411009602] TPC[000000000053a0c4] TNPC[000000000053a0c8] TASK[apt-get:11759]
Nov  6 04:43:19 titan kernel: [100897.253443]              TPC[__first_cpu+0x4/0x28]
Nov  6 04:43:19 titan kernel: [100897.311767]              O7[__delay+0x28/0x48]
Nov  6 04:43:20 titan kernel: [100897.365923]              I7[cheetah_xcall_deliver+0x1c0/0x23c]
Nov  6 04:43:31 titan kernel: [100909.020406] SysRq : Show Global CPU Regs
Nov  6 04:43:31 titan kernel: [100909.067374] * CPU[  0]: TSTATE[0000000000000000] TPC[0000000000000000] TNPC[0000000000000000] TASK[bash:11762]
Nov  6 04:43:31 titan kernel: [100909.188209]   CPU[  1]: TSTATE[0000004411009604] TPC[000000000045731c] TNPC[0000000000457320] TASK[swapper:0]
Nov  6 04:43:32 titan kernel: [100909.308013]              TPC[update_stats_wait_end+0x24/0x88]
Nov  6 04:43:32 titan kernel: [100909.377808]              O7[sched_clock+0x10/0x30]
Nov  6 04:43:32 titan kernel: [100909.436116]              I7[pick_next_task_fair+0x24/0x44]
Nov  6 04:43:32 titan kernel: [100909.502782]   CPU[  2]: TSTATE[0000009911009601] TPC[000000000042888c] TNPC[0000000000428890] TASK[swapper:0]
Nov  6 04:43:32 titan kernel: [100909.622580]              TPC[cpu_idle+0x80/0xb8]
Nov  6 04:43:32 titan kernel: [100909.678817]              O7[cpu_idle+0xa8/0xb8]
Nov  6 04:43:32 titan kernel: [100909.734029]              I7[after_lock_tlb+0x19c/0x1b0]
Nov  6 04:43:32 titan kernel: [100909.797570]   CPU[  3]: TSTATE[0000000011009601] TPC[0000000000441a78] TNPC[0000000000441a7c] TASK[apt-get:11759]
Nov  6 04:43:32 titan kernel: [100909.921536]              TPC[cheetah_xcall_deliver+0x174/0x23c]
Nov  6 04:43:32 titan kernel: [100909.993401]              O7[cheetah_xcall_deliver+0x6c/0x23c]
Nov  6 04:43:32 titan kernel: [100910.063193]              I7[flush_dcache_page_all+0x178/0x240]
Nov  6 04:43:33 titan kernel: [100910.766366] SysRq : Show Global CPU Regs
Nov  6 04:43:33 titan kernel: [100910.813292] * CPU[  0]: TSTATE[0000000000000000] TPC[0000000000000000] TNPC[0000000000000000] TASK[bash:11762]
Nov  6 04:43:33 titan kernel: [100910.934129]   CPU[  1]: TSTATE[0000004411009604] TPC[000000000045731c] TNPC[0000000000457320] TASK[swapper:0]
Nov  6 04:43:33 titan kernel: [100911.053923]              TPC[update_stats_wait_end+0x24/0x88]
Nov  6 04:43:33 titan kernel: [100911.123706]              O7[sched_clock+0x10/0x30]
Nov  6 04:43:33 titan kernel: [100911.182037]              I7[pick_next_task_fair+0x24/0x44]
Nov  6 04:43:33 titan kernel: [100911.248702]   CPU[  2]: TSTATE[0000004411009601] TPC[00000000004288a0] TNPC[00000000004288a4] TASK[swapper:0]
Nov  6 04:43:34 titan kernel: [100911.368498]              TPC[cpu_idle+0x94/0xb8]
Nov  6 04:43:34 titan kernel: [100911.424738]              O7[cpu_idle+0xa8/0xb8]
Nov  6 04:43:34 titan kernel: [100911.479949]              I7[after_lock_tlb+0x19c/0x1b0]
Nov  6 04:43:34 titan kernel: [100911.543490]   CPU[  3]: TSTATE[0000000011009601] TPC[000000000042fc44] TNPC[000000000042fbe8] TASK[apt-get:11759]
Nov  6 04:43:34 titan kernel: [100911.667456]              TPC[udelay+0x14/0x1c]
Nov  6 04:43:34 titan kernel: [100911.721611]              O7[udelay+0x10/0x1c]
Nov  6 04:43:34 titan kernel: [100911.774739]              I7[flush_dcache_page_all+0x178/0x240]
Nov  6 04:43:35 titan kernel: [100912.474070] SysRq : Show Global CPU Regs
Nov  6 04:43:35 titan kernel: [100912.520982] * CPU[  0]: TSTATE[0000000000000000] TPC[0000000000000000] TNPC[0000000000000000] TASK[bash:11762]
Nov  6 04:43:35 titan kernel: [100912.641822]   CPU[  1]: TSTATE[0000004411009604] TPC[000000000045731c] TNPC[0000000000457320] TASK[swapper:0]
Nov  6 04:43:35 titan kernel: [100912.761614]              TPC[update_stats_wait_end+0x24/0x88]
Nov  6 04:43:35 titan kernel: [100912.831396]              O7[sched_clock+0x10/0x30]
Nov  6 04:43:35 titan kernel: [100912.889728]              I7[pick_next_task_fair+0x24/0x44]
Nov  6 04:43:35 titan kernel: [100912.956393]   CPU[  2]: TSTATE[0000004411009601] TPC[00000000004288a0] TNPC[00000000004288a4] TASK[swapper:0]
Nov  6 04:43:35 titan kernel: [100913.076191]              TPC[cpu_idle+0x94/0xb8]
Nov  6 04:43:35 titan kernel: [100913.132429]              O7[cpu_idle+0xa8/0xb8]
Nov  6 04:43:35 titan kernel: [100913.187640]              I7[after_lock_tlb+0x19c/0x1b0]
Nov  6 04:43:35 titan kernel: [100913.251181]   CPU[  3]: TSTATE[0000000011009601] TPC[0000000000441a78] TNPC[0000000000441a7c] TASK[apt-get:11759]
Nov  6 04:43:36 titan kernel: [100913.375147]              TPC[cheetah_xcall_deliver+0x174/0x23c]
Nov  6 04:43:36 titan kernel: [100913.447011]              O7[cheetah_xcall_deliver+0x6c/0x23c]
Nov  6 04:43:36 titan kernel: [100913.516805]              I7[flush_dcache_page_all+0x178/0x240]
Nov  6 04:43:36 titan kernel: [100914.295153] SysRq : Show Global CPU Regs
Nov  6 04:43:37 titan kernel: [100914.342110] * CPU[  0]: TSTATE[0000000000000000] TPC[0000000000000000] TNPC[0000000000000000] TASK[bash:11762]
Nov  6 04:43:37 titan kernel: [100914.462949]   CPU[  1]: TSTATE[0000004411009604] TPC[000000000045731c] TNPC[0000000000457320] TASK[swapper:0]
Nov  6 04:43:37 titan kernel: [100914.582741]              TPC[update_stats_wait_end+0x24/0x88]
Nov  6 04:43:37 titan kernel: [100914.652524]              O7[sched_clock+0x10/0x30]
Nov  6 04:43:37 titan kernel: [100914.710855]              I7[pick_next_task_fair+0x24/0x44]
Nov  6 04:43:37 titan kernel: [100914.777522]   CPU[  2]: TSTATE[0000009911009601] TPC[000000000042888c] TNPC[0000000000428890] TASK[swapper:0]
Nov  6 04:43:37 titan kernel: [100914.897319]              TPC[cpu_idle+0x80/0xb8]
Nov  6 04:43:37 titan kernel: [100914.953557]              O7[cpu_idle+0xa8/0xb8]
Nov  6 04:43:37 titan kernel: [100915.008768]              I7[after_lock_tlb+0x19c/0x1b0]
Nov  6 04:43:37 titan kernel: [100915.072310]   CPU[  3]: TSTATE[0000000011009601] TPC[0000000000441a78] TNPC[0000000000441a7c] TASK[apt-get:11759]
Nov  6 04:43:37 titan kernel: [100915.196274]              TPC[cheetah_xcall_deliver+0x174/0x23c]
Nov  6 04:43:37 titan kernel: [100915.268140]              O7[cheetah_xcall_deliver+0x6c/0x23c]
Nov  6 04:43:38 titan kernel: [100915.337932]              I7[flush_dcache_page_all+0x178/0x240]


Sorry to the klibc people - I'll try it again later.

-- 
Bernd Zeimetz
<bernd@bzed.de>                         <http://bzed.de/>

