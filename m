From: Meelis Roos <mroos@ut.ee>
Date: Sun, 01 Feb 2009 18:51:23 +0000
Subject: Re: SBus HME startup failure - not only SBus
Message-Id: <Pine.SOC.4.64.0902012048030.26264@math.ut.ee>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

> it's me again with the E3500 and 2.6.29-rc2+git. I said it was working 
> fine but I have found 2 glitches and this is one of them.
> 
> It seems the SBus HME card is detected but initialization fails:
> 
> [  145.666490] sunhme.c:v3.10 August 26, 2008 David S. Miller (davem@davemloft.net)
> [  145.755837] eth0: HAPPY MEAL (SBUS) 10/100baseT Ethernet 08:00:20:b6:ee:e2
> [  145.836295] happymeal: Cannot map MAC TX registers.
> [  145.895305] PCI: Enabling device: (0000:00:01.1), cmd 2
> [  145.897821] eth1: HAPPY MEAL (PCI/CheerIO) 10/100BaseT Ethernet 08:00:20:b6:ee:e2
> 
> PCI one is detected and works fine.

I got a E450 working, installed Debian (2.6.26-1-sparc64-smp was OK) and 
tried todays 2.6.29-rc3+git on that. The system has 1 onbard HME and 1 
PCI quad HME. The same "Cannot map MAC TX registers" message appears on 
the quad HME interfaces, followed by oops and printk recursion crash 
(seems to be realted to interrupts, maybe from the other HME):

[    0.000000] PROMLIB: Sun IEEE Boot Prom 'OBP 3.30.0 2003/11/11 10:41'
[    0.000000] PROMLIB: Root node compatible: sun4u
[    0.000000] Linux version 2.6.29-rc3-00324-g45c82b5 (mroos@karusmari) (gcc version 4.3.3 20090117 (prerelease) (Debian 4.3.2-3) ) #1 SMP Sun Feb 1 20:12:42 EET 2009
[    0.000000] debug: ignoring loglevel setting.
[    0.000000] console [earlyprom0] enabled
[    0.000000] ARCH: SUN4U
[    0.000000] Ethernet address: 08:00:20:c4:93:e3
[    0.000000] Kernel: Using 2 locked TLB entries for main kernel image.
[    0.000000] Remapping the kernel... done.
[    0.000000] OF stdout device is: /pci@1f,4000/ebus@1/se@14,400000:a
[    0.000000] PROM: Built device tree with 104972 bytes of memory.
[    0.000000] Top of RAM: 0xdfeb8000, Total RAM: 0xbfea4000
[    0.000000] Memory hole size: 512MB
[    0.000000] [0000000200000000-fffff80000400000] page_structs1072 node=0 entry=0/0
[    0.000000] [0000000200000000-fffff80000800000] page_structs1072 node=0 entry=1/0
[    0.000000] [0000000200800000-fffff80000c00000] page_structs1072 node=0 entry=2/0
[    0.000000] [0000000200800000-fffff80001000000] page_structs1072 node=0 entry=3/0
[    0.000000] [0000000201000000-fffff80001400000] page_structs1072 node=0 entry=4/0
[    0.000000] [0000000201000000-fffff80001800000] page_structs1072 node=0 entry=5/0
[    0.000000] [0000000201800000-fffff80001c00000] page_structs1072 node=0 entry=6/0
[    0.000000] [0000000201800000-fffff80002000000] page_structs1072 node=0 entry=7/0
[    0.000000] Zone PFN ranges:
[    0.000000]   Normal   0x00000000 -> 0x0006ff5c
[    0.000000] Movable zone start PFN for each node
[    0.000000] early_node_map[6] active PFN ranges
[    0.000000]     0: 0x00000000 -> 0x00010000
[    0.000000]     0: 0x00020000 -> 0x0006fe00
[    0.000000]     0: 0x0006fe01 -> 0x0006feff
[    0.000000]     0: 0x0006ff00 -> 0x0006ff48
[    0.000000]     0: 0x0006ff49 -> 0x0006ff54
[    0.000000]     0: 0x0006ff5b -> 0x0006ff5c
[    0.000000] On node 0 totalpages: 393042
[    0.000000]   Normal zone: 3583 pages used for memmap
[    0.000000]   Normal zone: 0 pages reserved
[    0.000000]   Normal zone: 389459 pages, LIFO batch:15
[    0.000000] Booting Linux...
[    0.000000] Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 389459
[    0.000000] Kernel command line: root=/dev/sda2 ro debug ignore_loglevel
[    0.000000] PID hash table entries: 4096 (order: 12, 32768 bytes)
[    0.000000] clocksource: mult[28000] shift[16]
[    0.000000] clockevent: mult[66666666] shift[32]
[  141.902272] Console: colour dummy device 80x25
[  141.955329] console handover: boot [earlyprom0] -> real [tty0]
[    0.000000] PROMLIB: Sun IEEE Boot Prom 'OBP 3.30.0 2003/11/11 10:41'
[    0.000000] PROMLIB: Root node compatible: sun4u
[    0.000000] Linux version 2.6.29-rc3-00324-g45c82b5 (mroos@karusmari) (gcc version 4.3.3 20090117 (prerelease) (Debian 4.3.2-3) ) #1 SMP Sun Feb 1 20:12:42 EET 2009
[    0.000000] debug: ignoring loglevel setting.
[    0.000000] console [earlyprom0] enabled
[    0.000000] ARCH: SUN4U
[    0.000000] Ethernet address: 08:00:20:c4:93:e3
[    0.000000] Kernel: Using 2 locked TLB entries for main kernel image.
[    0.000000] Remapping the kernel... done.
[    0.000000] OF stdout device is: /pci@1f,4000/ebus@1/se@14,400000:a
[    0.000000] PROM: Built device tree with 104972 bytes of memory.
[    0.000000] Top of RAM: 0xdfeb8000, Total RAM: 0xbfea4000
[    0.000000] Memory hole size: 512MB
[    0.000000] [0000000200000000-fffff80000400000] page_structs1072 node=0 entry=0/0
[    0.000000] [0000000200000000-fffff80000800000] page_structs1072 node=0 entry=1/0
[    0.000000] [0000000200800000-fffff80000c00000] page_structs1072 node=0 entry=2/0
[    0.000000] [0000000200800000-fffff80001000000] page_structs1072 node=0 entry=3/0
[    0.000000] [0000000201000000-fffff80001400000] page_structs1072 node=0 entry=4/0
[    0.000000] [0000000201000000-fffff80001800000] page_structs1072 node=0 entry=5/0
[    0.000000] [0000000201800000-fffff80001c00000] page_structs1072 node=0 entry=6/0
[    0.000000] [0000000201800000-fffff80002000000] page_structs1072 node=0 entry=7/0
[    0.000000] Zone PFN ranges:
[    0.000000]   Normal   0x00000000 -> 0x0006ff5c
[    0.000000] Movable zone start PFN for each node
[    0.000000] early_node_map[6] active PFN ranges
[    0.000000]     0: 0x00000000 -> 0x00010000
[    0.000000]     0: 0x00020000 -> 0x0006fe00
[    0.000000]     0: 0x0006fe01 -> 0x0006feff
[    0.000000]     0: 0x0006ff00 -> 0x0006ff48
[    0.000000]     0: 0x0006ff49 -> 0x0006ff54
[    0.000000]     0: 0x0006ff5b -> 0x0006ff5c
[    0.000000] On node 0 totalpages: 393042
[    0.000000]   Normal zone: 3583 pages used for memmap
[    0.000000]   Normal zone: 0 pages reserved
[    0.000000]   Normal zone: 389459 pages, LIFO batch:15
[    0.000000] Booting Linux...
[    0.000000] Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 389459
[    0.000000] Kernel command line: root=/dev/sda2 ro debug ignore_loglevel
[    0.000000] PID hash table entries: 4096 (order: 12, 32768 bytes)
[    0.000000] clocksource: mult[28000] shift[16]
[    0.000000] clockevent: mult[66666666] shift[32]
[  141.902272] Console: colour dummy device 80x25
[  141.955329] console handover: boot [earlyprom0] -> real [tty0]
[  142.045457] Dentry cache hash table entries: 524288 (order: 9, 4194304 bytes)
[  142.062470] Inode-cache hash table entries: 262144 (order: 8, 2097152 bytes)
[  142.286806] Memory: 3097200k available (2880k kernel code, 1280k data, 160k init) [fffff80000000000,00000000dfeb8000]
[  142.287077] SLUB: Genslabs, HWalign2, Order=0-3, MinObjects=0, CPUs=4, Nodes=1
[  142.435762] Calibrating delay using timer specific routine.. 801.41 BogoMIPS (lpj@07080)
[  142.436067] Mount-cache hash table entries: 512
[  142.477933] CPU 1: synchronized TICK with master CPU (last diff 0 cycles, maxerr 537 cycles)
[  142.515016] CPU 2: synchronized TICK with master CPU (last diff 0 cycles, maxerr 545 cycles)
[  142.552127] CPU 3: synchronized TICK with master CPU (last diff 0 cycles, maxerr 545 cycles)
[  142.552154] Brought up 4 CPUs
[  142.555057] khelper used greatest stack depth: 11496 bytes left
[  142.555470] net_namespace: 1888 bytes
[  142.555810] NET: Registered protocol family 16
[  142.599878] /pci@1f,4000: PCI IO[1fe02010000] MEM[1ff80000000]
[  142.599930] /pci@1f,4000: PSYCHO PCI Bus Module ver[4:0]
[  142.599960] PCI: Scanning PBM /pci@1f,4000
[  142.603371] /pci@1f,2000: PCI IO[1fe02000000] MEM[1ff00000000]
[  142.603409] /pci@1f,2000: PSYCHO PCI Bus Module ver[4:0]
[  142.603436] PCI: Scanning PBM /pci@1f,2000
[  142.610754] /pci@4,4000: PCI IO[1c802010000] MEM[1c980000000]
[  142.610810] /pci@4,4000: PSYCHO PCI Bus Module ver[4:0]
[  142.610852] PCI: Scanning PBM /pci@4,4000
[  142.611544] /pci@4,2000: PCI IO[1c802000000] MEM[1c900000000]
[  142.611596] /pci@4,2000: PSYCHO PCI Bus Module ver[4:0]
[  142.611638] PCI: Scanning PBM /pci@4,2000
[  142.619414] /pci@6,4000: PCI IO[1cc02010000] MEM[1cd80000000]
[  142.619472] /pci@6,4000: PSYCHO PCI Bus Module ver[4:0]
[  142.619514] PCI: Scanning PBM /pci@6,4000
[  142.620190] /pci@6,2000: PCI IO[1cc02000000] MEM[1cd00000000]
[  142.620243] /pci@6,2000: PSYCHO PCI Bus Module ver[4:0]
[  142.620284] PCI: Scanning PBM /pci@6,2000
[  142.640216] bio: create slab <bio-0> at 0
[  142.644260] SCSI subsystem initialized
[  142.687361] /pci@1f,4000/ebus@1/eeprom@14,0: Mostek regs at 0x1fff1000000
[  142.688772] AUXIO: Found device at /pci@1f,4000/ebus@1/auxio@14,726000
[  142.692938] NET: Registered protocol family 2
[  142.696125] Switched to high resolution mode on CPU 0
[  142.697687] Switched to high resolution mode on CPU 1
[  142.701792] Switched to high resolution mode on CPU 3
[  142.704698] Switched to high resolution mode on CPU 2
[  142.806352] IP route cache hash table entries: 131072 (order: 7, 1048576 bytes)
[  142.812203] TCP established hash table entries: 524288 (order: 10, 8388608 bytes)
[  142.851281] TCP bind hash table entries: 65536 (order: 7, 1048576 bytes)
[  142.856275] TCP: Hash tables configured (established 524288 bind 65536)
[  142.856328] TCP reno registered
[  142.886751] NET: Registered protocol family 1
[  142.887080] power: Control reg at 1fff1724000
[  142.940337] VFS: Disk quotas dquot_6.5.2
[  142.941012] Dquot-cache hash table entries: 1024 (order 0, 8192 bytes)
[  142.945058] msgmni has been set to 6050
[  142.946477] alg: No test for stdrng (krng)
[  142.947573] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 253)
[  142.947652] io scheduler noop registered
[  142.948290] io scheduler cfq registered (default)
[  142.976335] /pci@1f,4000/ebus@1/su@14,3083f8: Keyboard port at 1fff13083f8, irq 8
[  142.976564] /pci@1f,4000/ebus@1/su@14,3062f8: Mouse port at 1fff13062f8, irq 9
[  142.977520] f0071b64: ttyS0 at MMIO 0x1fff1400000 (irq = 7) is a SAB82532 V3.2
[  142.977593] Console: ttyS0 (SAB82532)
[  142.977718] console [ttyS0] enabled
[  149.730867] f0071b64: ttyS1 at MMIO 0x1fff1400040 (irq = 7) is a SAB82532 V3.2
[  149.818077] sunhme.c:v3.10 August 26, 2008 David S. Miller (davem@davemloft.net)
[  149.905766] happymeal: Cannot map MAC TX registers.
[  149.964116] happymeal: Cannot map MAC TX registers.
[  150.022447] happymeal: Cannot map MAC TX registers.
[  150.080763] happymeal: Cannot map MAC TX registers.
[  150.139432] OOPS: Bogus kernel PC [0000000000000000] in fault handler
[  150.216104] OOPS: RPC [00000000005ef2e0]
[  150.262985] OOPS: RPC <quattro_sbus_interrupt+0x40/0x120>
[  150.327549] OOPS: Fault was to vaddr[200400000]
[  150.381708] Call Trace:
[  150.410879]  [00000000006d0b5c] do_sparc64_fault+0x51c/0x660
[  150.478584]  [0000000000407964] sparc64_realfault_common+0x10/0x20
[  150.552528]  [0000000000000000] (null)
[  150.597320]  [000000000048f42c] request_irq+0xec/0x140
[  150.658776]  [0000000000835720] happy_meal_probe+0x50/0xc0
[  150.724394]  [0000000000426a68] do_one_initcall+0x28/0x160
[  150.790017]  [00000000008242a4] kernel_init+0x180/0x1e0
[  150.852509]  [000000000042bd5c] kernel_thread+0x3c/0x60
[  150.915001]  [00000000006c19dc] rest_init+0x1c/0x80
[  150.973322] Unable to handle kernel NULL pointer dereference
[  151.041024] tsk->{mm,active_mm}->context = 0000000000000000
[  151.107683] tsk->{mm,active_mm}->pgd = fffff80040453764
[  151.170180]               \|/ ____ \|/
[  151.170189]               "@'/ .. \`@"
[  151.170197]               /_| \__/ |_\
[  151.170206]                  \__U_/
[  151.346202] swapper(1): Oops [#1]
[  151.385790] TSTATE: 0000000080e01600 TPC: 0000000000000000 TNPC: 0000000000000004 Y: 00000000    Not tainted
[  151.503506] TPC: <(null)>
[  151.534726] g0: 0000000000000000 g1: 0000000000000000 g2: 00000000fc7efc00 g3: fffff800df03b9c1
[  151.638911] g4: fffff800df048000 g5: fffff800df1ba000 g6: fffff800df03c000 g7: 0000000073000000
[  151.743065] o0: 0000000000000108 o1: fffff800de498640 o2: 0000000000000000 o3: fffff800de480000
[  151.847225] o4: fffff800dfa029b8 o5: 0000000000009600 sp: fffff800df03f331 ret_pc: 00000000005ef2e0
[  151.955552] RPC: <quattro_sbus_interrupt+0x40/0x120>
[  152.014895] l0: fffff800de0d0000 l1: 0000000000000000 l2: fffff800de0d0640 l3: 00000000fefffefc
[  152.119074] l4: 00000000fc7efefc l5: 0000000000010000 l6: 0000000002000000 l7: 0000000000800000
[  152.223231] i0: 0000000000000021 i1: fffff800de496300 i2: fffff800de498640 i3: fffff800de49b000
[  152.327388] i4: 0000000000000000 i5: 0000000000000000 i6: fffff800df03f3f1 i7: 000000000048f42c
[  152.431548] I7: <request_irq+0xec/0x140>
[  152.478395] Caller[000000000048f42c]: request_irq+0xec/0x140
[  152.546100] Caller[0000000000835720]: happy_meal_probe+0x50/0xc0
[  152.617968] Caller[0000000000426a68]: do_one_initcall+0x28/0x160
[  152.689838] Caller[00000000008242a4]: kernel_init+0x180/0x1e0
[  152.758582] Caller[000000000042bd5c]: kernel_thread+0x3c/0x60
[  152.827323] Caller[00000000006c19dc]: rest_init+0x1c/0x80
[  152.891893] Instruction DUMP:<2>BUG: recent printk recursion!
[  152.925510] Kernel panic - not syncing: Attempted to kill init!
[  153.031555] Press Stop-A (L1-A) to return to the boot prom

-- 
Meelis Roos (mroos@ut.ee)      http://www.cs.ut.ee/~mroos/
