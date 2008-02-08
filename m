From: =?ISO-8859-1?Q?BERTRAND_Jo=EBl?= <joel.bertrand@systella.fr>
Date: Fri, 08 Feb 2008 10:53:42 +0000
Subject: gcc 4.2 or kernel bug ?
Message-Id: <47AC34B6.4000302@systella.fr>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

	Hello,

	On a U60 SMP running debian/testing, 2.6.24 kernel, I can seen in dmesg :

Mem-info:
Normal per-cpu:
CPU    0: Hot: hi:   90, btch:  15 usd:  56   Cold: hi:   30, btch:   7 
usd:  23
CPU    2: Hot: hi:   90, btch:  15 usd:   0   Cold: hi:   30, btch:   7 
usd:   0
Active:98801 inactive:19262 dirty:68 writeback:0 unstable:0
  free:530 slab:3845 mapped:6871 pagetables:553 bounce:0
Normal free:4104kB min:4040kB low:5048kB high:6056kB active:790408kB 
inactive:15
4096kB present:1023992kB pages_scanned:33 all_unreclaimable? no
lowmem_reserve[]: 0 0
Normal: 449*8kB 1*16kB 1*32kB 1*64kB 1*128kB 1*256kB 0*512kB 0*1024kB 
0*2048kB 0
*4096kB 0*8192kB = 4088kB
Swap cache: add 150320, delete 132225, find 212550/233466, race 0+1
Free swap  = 1682128kB
Total swap = 1951792kB
Free swap:       1682128kB
360340 pages of RAM
233704 reserved pages
41539 pages shared
18049 pages swap cached
68 pages dirty
0 pages writeback
6871 pages mapped
3845 pages slab
553 pages pagetables
swapper: page allocation failure. order:1, mode:0x4020
Call Trace:
  [00000000004b67e0] __slab_alloc+0x248/0x660
  [00000000004b8c00] __kmalloc_track_caller+0xe8/0x100
  [0000000000634b20] __alloc_skb+0x48/0x100
  [00000000005b662c] happy_meal_rx+0x114/0x420
  [00000000005b7954] happy_meal_interrupt+0x7c/0xe0
  [000000000048efcc] handle_IRQ_event+0x34/0xa0
  [0000000000490a38] handle_fasteoi_irq+0xa0/0x140
  [000000000042ef48] handler_irq+0x90/0xc0
  [00000000004208b4] tl0_irq5+0x1c/0x20
  [0000000000474108] __rcu_process_callbacks+0x90/0x280
  [0000000000474318] rcu_process_callbacks+0x20/0x40
  [00000000004667d4] tasklet_action+0x7c/0x160
  [0000000000466054] __do_softirq+0xbc/0x100
  [00000000004660fc] do_softirq+0x64/0x80
  [0000000000432ae8] timer_interrupt+0x90/0x100
  [00000000004209d4] tl0_irq14+0x1c/0x20

	Running kernel was build with gcc 4.2. Can 2.6.24 kernel be built with 
this release of gcc ?

	Regards,

	JKB
