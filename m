From: Pasi Pirhonen <upi@centos.fi>
Date: Sat, 14 Apr 2007 10:38:30 +0000
Subject: Re: [TESTERS NEEDED]: Rewritten ESP driver
Message-Id: <20070414103830.GA6300@centos.fi>
List-Id: <sparclinux.vger.kernel.org>
References: <20070412.233350.41640545.davem@davemloft.net>
In-Reply-To: <20070412.233350.41640545.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hi,


On Fri, Apr 13, 2007 at 01:33:14PM -0700, David Miller wrote:
> From: Pasi Pirhonen <upi@centos.fi>
> 
> > Something else? Long term stability and some _real_ I/O load is still
> > something to be tested ......
> 
> Thanks a lot for the testing and the info, I really appreciate
> it.
> 
> If something goes wrong, do report it, and if not then simply
> enjoy :-)


Wrong and wrong. First of all it's quite amateurish for me that the
email i did export for 'IOMMU patch' was not the right one, so i did
get few horrible deaths while the I/O load was involved more heavily.

Now i can't anymore kill it with the same load i did kill it in minutes
before, so the esp part seems still solid with the new driver.

The sad part is that when i finally did got the right IOMMU-patch in
and booted, the qlogicpti-driver did break as below. I know i could
hack in a if() for 'SBUS_DMA_NONE', but i'd rather not as i have no
idea how the SCSI-layer generally works ....

qlogicpti happily initializes when i just turned the plugged D1000 off


Loadingqpti0: IRQ 11 SCSI ID 7  qlogicpti.ko module
<6>scsi1 : PTI Qlogic,ISP SBUS SCSI irq 11 regs at 000001c510010000
(Firmware v1.31.32)(Firmware 1.21 95/05/18) [Fast Wide, using differential interface]
scsi 1:0:2:0: Direct-Access     IBM      DDYST3695SUN36G  S96H PQ: 0 ANSI: 3
kernel BUG at arch/sparc64/kernel/sbus.c:333!
              \|/ ____ \|/
              "@'/ .. \              /_| \__/ |_\
                 \__U_/
swapper(0): Kernel bad sw trap 5 [#1]
TSTATE: 0000000080f09600 TPC: 00000000004268ec TNPC: 00000000004268f0 Y: 00000000    Not tainted
TPC: <sbus_unmap_single+0xd4/0xe0>
g0: 0000000000000000 g1: 00000000007d2000 g2: 0000000000000001 g3: 000000000073d400
g4: 0000000000739400 g5: fffff80003686000 g6: 0000000000735400 g7: 000000000073d7f8
o0: 0000000000000031 o1: 00000000006f0b88 o2: 000000000000014d o3: 00000000006ac910
o4: 0000000000000000 o5: 0000000000000014 sp: 0000000000738491 ret_pc: 00000000004268e4
RPC: <sbus_unmap_single+0xcc/0xe0>
l0: fffff800007ac1f4 l1: 0000000000000000 l2: 0000000000000000 l3: fffff80004ecd080
l4: fffff800007ac000 l5: fffff800007ac0e8 l6: fffff80004ecd08c l7: fffff800007ac240
i0: fffff801ff72ddc0 i1: 0000000000000000 i2: 0000000000000000 i3: 0000000000000003
i4: fffff801fea71ac8 i5: 0000000000000000 i6: 0000000000738551 i7: 0000000010085130
I7: <qpti_intr+0x238/0x340 [qlogicpti]>
Caller[0000000010085130]: qpti_intr+0x238/0x340 [qlogicpti]
Caller[000000000048170c]: handle_IRQ_event+0x34/0xa0
Caller[0000000000481824]: __do_IRQ+0xac/0x120
Caller[000000000041c9c4]: handler_irq+0x8c/0xc0
Caller[00000000004108b4]: tl0_irq5+0x1c/0x20
Caller[00000000004183e8]: cpu_idle+0xb0/0xc0
Caller[0000000000780b48]: start_kernel+0x2b0/0x320
Caller[00000000004045c0]: setup_trap_table+0x0/0x100
Caller[0000000000000000]: 0x8
Instruction DUMP: 9210214d  7fffcfcf  90122388 <91d02005> 30680004 01000000  01000000  01000000  9de3bf40
Kernel panic - not syncing: Aiee, killing interrupt handler!
Press Stop-A (L1-A) to return to the boot prom


-- 
Pasi Pirhonen - upi@iki.fi - http://pasi.pirhonen.eu/
Top-postings silently ignored
