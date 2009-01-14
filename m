From: Jim Gifford <maillist@jg555.com>
Date: Wed, 14 Jan 2009 15:54:09 +0000
Subject: 2.6.26 -2.6.28 Issue on Netra X1
Message-Id: <496E0AA1.1030907@jg555.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

I've reported this several times with no help. System completly shuts 
down the ethernet interface. The only information in the log is the 
following.
[   80.042203] EXT3 FS on hda2, internal journal
[   80.952247] Adding 1510088k swap on /dev/hda4.  Priority:-1 extents:1 
across:1510088k
[131219.643283] ------------[ cut here ]------------
[131219.643314] WARNING: at net/sched/sch_generic.c:219 
dev_watchdog+0x250/0x280()
[131219.643327] NETDEV WATCHDOG: eth0 (tulip): transmit timed out
[131219.643337] Modules linked in: openpromfs tulip
[131219.643353] Call Trace:
[131219.643369]  [00000000005ecf10] dev_watchdog+0x250/0x280
[131219.643392]  [000000000045f64c] run_timer_softirq+0x16c/0x1e0
[131219.643409]  [000000000045ab7c] __do_softirq+0x5c/0xe0
[131219.643435]  [000000000042e3f0] do_softirq+0x70/0xa0
[131219.643450]  [000000000045a764] irq_exit+0x84/0xc0
[131219.643466]  [000000000043327c] timer_interrupt+0x5c/0xc0
[131219.643484]  [00000000004209d4] tl0_irq14+0x14/0x20
[131219.643499]  [0000000000428050] cpu_idle+0x30/0xc0
[131219.643522]  [000000000070c8bc] start_kernel+0x27c/0x2c0
[131219.643538]  [0000000000643744] tlb_fixup_done+0x80/0x9c
[131219.643550]  [0000000000000000] 0x0
[131219.643560] ---[ end trace b95673019322adce ]---
[131219.644916] 0000:00:0c.0: tulip_stop_rxtx() failed (CSR5 0xfc508100 
CSR6 0x20ec000)
[131227.640686] 0000:00:0c.0: tulip_stop_rxtx() failed (CSR5 0xfc508100 
CSR6 0x20ec000)
this last messages just continues

Here is the link to my previous attempts for help.
http://kerneltrap.org/mailarchive/linux-net/2008/10/27/3818464
