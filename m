From: Jim Gifford <maillist@jg555.com>
Date: Fri, 28 Aug 2009 00:18:39 +0000
Subject: Re: [PATCH]: sparc64: Validate linear D-TLB misses.
Message-Id: <4A97225F.7040701@jg555.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20090824.232349.236950384.davem@davemloft.net>
In-Reply-To: <20090824.232349.236950384.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


> 2009/8/27 Jim Gifford <maillist@jg555.com>:
>   
>>
>>
>> Dave, This also seems to fix the error I was having on the Netra X1, so far
>> it's been up 24 hours with no issues.
>>
>>     

Spoke too soon, it's started again. So that patch has only delayed the 
issue.

Aug 24 05:53:19 mail kernel: [   81.739235] EXT3 FS on hda2, internal 
journal
Aug 24 05:53:19 mail kernel: [   82.649915] Adding 1510088k swap on 
/dev/hda4.  Priority:-1 extents:1 across:1510088k
Aug 27 01:58:01 mail kernel: [72307.489683] ------------[ cut here 
]------------
Aug 27 01:58:01 mail kernel: [72307.489738] WARNING: at 
net/sched/sch_generic.c:226 dev_watchdog+0x24c/0x260()
Aug 27 01:58:01 mail kernel: [72307.489754] NETDEV WATCHDOG: eth1 
(tulip): transmit timed out
Aug 27 01:58:01 mail kernel: [72307.489766] Modules linked in: tulip 
bitrev crc32
Aug 27 01:58:01 mail kernel: [72307.489786] Call Trace:
Aug 27 01:58:01 mail kernel: [72307.489808]  [0000000000452308] 
warn_slowpath_fmt+0x28/0x40
Aug 27 01:58:01 mail kernel: [72307.489829]  [000000000060420c] 
dev_watchdog+0x24c/0x260
Aug 27 01:58:01 mail kernel: [72307.489851]  [000000000045c520] 
run_timer_softirq+0x180/0x200
Aug 27 01:58:01 mail kernel: [72307.489875]  [00000000004577e8] 
__do_softirq+0xa8/0x180
Aug 27 01:58:01 mail kernel: [72307.489897]  [000000000042a470] 
do_softirq+0x70/0xa0
Aug 27 01:58:01 mail kernel: [72307.489916]  [0000000000457478] 
irq_exit+0x78/0xa0
Aug 27 01:58:01 mail kernel: [72307.489938]  [000000000042f578] 
timer_interrupt+0x58/0xa0
Aug 27 01:58:01 mail kernel: [72307.489959]  [00000000004209d4] 
tl0_irq14+0x14/0x20
Aug 27 01:58:01 mail kernel: [72307.489976]  [000000000042c408] 
cpu_idle+0x48/0xe0
Aug 27 01:58:01 mail kernel: [72307.490002]  [000000000074e738] 
start_kernel+0x278/0x2b4
Aug 27 01:58:01 mail kernel: [72307.490028]  [000000000065c344] 
tlb_fixup_done+0x80/0x9c
Aug 27 01:58:01 mail kernel: [72307.490041]  [0000000000000000] (null)
Aug 27 01:58:01 mail kernel: [72307.490053] ---[ end trace 
ab817fc60b30ccb6 ]---
Aug 27 01:58:01 mail kernel: [72307.491397] 0000:00:05.0: 
tulip_stop_rxtx() failed (CSR5 0xfc508100 CSR6 0x20e8000)
Aug 27 01:58:09 mail kernel: [72315.487043] 0000:00:05.0: 
tulip_stop_rxtx() failed (CSR5 0xfc508100 CSR6 0x20e8000)
Aug 27 01:58:17 mail kernel: [72323.483023] 0000:00:05.0: 
tulip_stop_rxtx() failed (CSR5 0xfc508100 CSR6 0x20e8000)
Aug 27 01:58:25 mail kernel: [72331.478976] 0000:00:05.0: 
tulip_stop_rxtx() failed (CSR5 0xfc508100 CSR6 0x20e8000)

