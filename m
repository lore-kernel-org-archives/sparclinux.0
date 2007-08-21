From: Meelis Roos <mroos@linux.ee>
Date: Tue, 21 Aug 2007 15:47:16 +0000
Subject: oops in sunsab_interrupt
Message-Id: <Pine.SOC.4.64.0708211359080.24028@math.ut.ee>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

I switched fro Ultra 1 to Ultra 5 with my intermittent boot hang 
debugging because of faster compilation. However, the "booting" kernel 
hangs later in boot process with this oops after switching away from 
serial console (? - I do use serial console actually, why is it telling 
about switching console to colour frame buffer device??). This was with 
last weeks kernel snapshot, tried with todays 2.6.23-rc3 + git, now it 
just hangs after Mouse port detection.

atyfb: 3D RAGE PRO (Mach64 GP, PQFP, PCI) [0x4750 rev 0x7c]
atyfb: 4M SGRAM (1:1), 14.31818 MHz XTAL, 230 MHz PLL, 100 Mhz MCLK, 100 MHz XCLK
Console: switching to colour frame buffer device 144x56
atyfb: fb0: ATY Mach64 frame buffer device on PCI
/pci@1f,0/pci@1,1/ebus@1/su@14,3083f8: Keyboard port at 1fff13083f8, irq 6
/pci@1f,0/pci@1,1/ebus@1/su@14,3062f8: Mouse port at 1fff13062f8, irq 7
Unable to handle kernel NULL pointer dereference
tsk->{mm,active_mm}->context = 0000000000000000
tsk->{mm,active_mm}->pgd = fffff800007999b0
              \|/ ____ \|/
              "@'/ .. \`@"
              /_| \__/ |_\
                 \__U_/
swapper(1): Oops [#1]
TSTATE: 0000008880f01606 TPC: 00000000005aa2b8 TNPC: 00000000005aa2bc Y: 00000000    Not tainted
TPC: <receive_chars+0x320/0x440>
g0: 00000000004209d0 g1: 0000000000000000 g2: 0000000000000000 g3: 0000000000000000
g4: fffff800015d8000 g5: 0000000000000000 g6: fffff800015dc000 g7: fffff8001febb980
o0: fffff8001febbb40 o1: 0000000000000000 o2: 0000000000000000 o3: fffff8001febbb40
o4: 0000000000000000 o5: 0000000000000000 sp: fffff800015dedd1 ret_pc: 00000000004abfb4
RPC: <kmem_cache_alloc+0x9c/0xc0>
l0: 0000000000763380 l1: fffff800015dfd80 l2: 0000000000000000 l3: 00000000000001f4
l4: 0000000000000000 l5: 00000000006fc800 l6: 0000000000000000 l7: 000000000079d800
i0: fffff8001feb38e0 i1: fffff800015df77e i2: ffffffffffffffff i3: 000000000048529c
i4: fffff80000b53c58 i5: 000001fff1400000 i6: fffff800015deec1 i7: 00000000005aab84
I7: <sunsab_interrupt+0x1ec/0x240>
Caller[00000000005aab84]: sunsab_interrupt+0x1ec/0x240
Caller[000000000048532c]: request_irq+0x114/0x120
Caller[00000000005a9950]: sunsab_init_one+0x158/0x1a0
Caller[00000000005ab0b4]: sab_probe+0x3c/0x120
Caller[0000000000607d88]: of_platform_device_probe+0x50/0xe0
Caller[00000000005aea08]: driver_probe_device+0x90/0x1c0
Caller[00000000005aeba0]: __driver_attach+0x68/0x80
Caller[00000000005ade3c]: bus_for_each_dev+0x44/0x80
Caller[00000000005ae1f8]: bus_add_driver+0x80/0x1c0
Caller[0000000000774264]: kernel_init+0xac/0x2a0
Caller[00000000004278d0]: kernel_thread+0x38/0x60
Caller[000000000068fd10]: rest_init+0x18/0x60
Instruction DUMP: c60e4000  c25e2060  c406208c <c6506042> 84188003  80a00002  ac603fff  80a52000  344fff96


-- 
Meelis Roos (mroos@linux.ee)
