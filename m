From: Meelis Roos <mroos@linux.ee>
Date: Fri, 27 Jul 2007 19:29:53 +0000
Subject: new parport_pc BUG
Message-Id: <Pine.SOC.4.64.0707272224450.1678@math.ut.ee>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

I tested todays git (2.6.23-rc1-gd941cf5e) on Ultra 5 and got a new 
parport_pc BUG. This time the call trace is different than last time.

The line in question is BUG_ON(dev->bus != &pci_bus_type);

kernel BUG at include/asm/dma-mapping.h:35!
              \|/ ____ \|/
              "@'/ .. \`@"
              /_| \__/ |_\
                 \__U_/
modprobe(1380): Kernel bad sw trap 5 [#1]
TSTATE: 0000000011009604 TPC: 00000000100de7ac TNPC: 00000000100de7b0 Y: 00000000    Not tainted
TPC: <parport_pc_probe_port+0xfb4/0xfc0 [parport_pc]>
g0: 00000000007bbc00 g1: 00000000007ad800 g2: 0000000000000001 g3: 0000000000739c00
g4: fffff8001f045ae0 g5: 0000000000000020 g6: fffff8001e660000 g7: 0000000000739f88
o0: 000000000000002f o1: 00000000100e2138 o2: 0000000000000023 o3: fffff8001fd14cf0
o4: fffff8001e540e00 o5: 0000000000000001 sp: fffff8001e662f41 ret_pc: 00000000100de7a4
RPC: <parport_pc_probe_port+0xfac/0xfc0 [parport_pc]>
l0: 0000000000000000 l1: 00000000100e6868 l2: ffffffffffffffff l3: fffff8001fee74c0
l4: 00000000100e7000 l5: 000001fff13043bc l6: fffff8001fee6fc0 l7: fffff8001fee7f00
i0: fffff8001e540e00 i1: 000001fff13047bc i2: 000000000073a000 i3: fffff8001fee74e8
i4: fffff8001fe32008 i5: 0000000000024000 i6: fffff8001e663001 i7: 00000000100df8a8
I7: <ecpp_probe+0x190/0x240 [parport_pc]>
Caller[00000000100df8a8]: ecpp_probe+0x190/0x240 [parport_pc]
Caller[0000000000607f28]: of_platform_device_probe+0x50/0xe0
Caller[00000000005aea48]: driver_probe_device+0x90/0x1c0
Caller[00000000005aebe0]: __driver_attach+0x68/0x80
Caller[00000000005ade7c]: bus_for_each_dev+0x44/0x80
Caller[00000000005ae238]: bus_add_driver+0x80/0x1c0
Caller[00000000100ea418]: parport_pc_init+0x300/0x4e0 [parport_pc]
Caller[00000000004806ec]: sys_init_module+0x134/0x1400
Caller[0000000000405f54]: linux_sparc_syscall32+0x3c/0x40
Caller[0000000000013fc4]: 0x13fcc
Instruction DUMP: 92102023  7c0d31cf  90122138 <91d02005> 30680004  01000000  01000000  01000000  9de3bf40

-- 
Meelis Roos (mroos@linux.ee)
