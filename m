From: Meelis Roos <mroos@linux.ee>
Date: Thu, 28 May 2015 18:36:56 +0000
Subject: 4.0, sparc64, hugetlb: possible irq lock inversion dependency detected
Message-Id: <alpine.LRH.2.11.1504241657320.18035@math.ut.ee>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org

I Powered on my V240 (last tested long ago because of fan failure).=20
Tried v4.0 on it - works but I got a hugetlb-related locking warning on=20
it (full dmesg below, config too).

This kernel was compiled with old gcc 4.6.4 since no debian upgrade has=20
run for a long time.


[    0.000000] PROMLIB: Sun IEEE Boot Prom 'OBP 4.30.4.a 2010/01/06 14:48'
[    0.000000] PROMLIB: Root node compatible:=20
[    0.000000] Initializing cgroup subsys cpuset
[    0.000000] Initializing cgroup subsys cpu
[    0.000000] Initializing cgroup subsys cpuacct
[    0.000000] Linux version 4.0.0 (mroos@v240) (gcc version 4.6.4 (Debian =
4.6.4-6) ) #3 SMP Tue Apr 21 17:24:22 EEST 2015
[    0.000000] debug: ignoring loglevel setting.
[    0.000000] bootconsole [earlyprom0] enabled
[    0.000000] ARCH: SUN4U
[    0.000000] Ethernet address: 00:03:ba:5a:99:2d
[    0.000000] MM: PAGE_OFFSET is 0xfff0000000000000 (max_phys_bits =3D 42)
[    0.000000] MM: VMALLOC [0x0000000100000000 --> 0x000c000000000000]
[    0.000000] MM: VMEMMAP [0x000c000000000000 --> 0x0018000000000000]
[    0.000000] Kernel: Using 5 locked TLB entries for main kernel image.
[    0.000000] Remapping the kernel... done.
[    0.000000] kmemleak: Kernel memory leak detector disabled
[    0.000000] OF stdout device is: /pci@1e,600000/isa@7/serial@0,3f8
[    0.000000] PROM: Built device tree with 138365 bytes of memory.
[    0.000000] Top of RAM: 0x133feba000, Total RAM: 0x17fe94000
[    0.000000] Memory hole size: 72704MB
[    0.000000] Allocated 40960 bytes for kernel page tables.
[    0.000000] Zone ranges:
[    0.000000]   Normal   [mem 0x0000000000000000-0x000000133feb9fff]
[    0.000000] Movable zone start for each node
[    0.000000] Early memory node ranges
[    0.000000]   node   0: [mem 0x0000000000000000-0x000000003fffffff]
[    0.000000]   node   0: [mem 0x0000000200000000-0x000000023fffffff]
[    0.000000]   node   0: [mem 0x0000000300000000-0x000000033fffffff]
[    0.000000]   node   0: [mem 0x0000001000000000-0x000000103fffffff]
[    0.000000]   node   0: [mem 0x0000001200000000-0x000000123fffffff]
[    0.000000]   node   0: [mem 0x0000001300000000-0x000000133effdfff]
[    0.000000]   node   0: [mem 0x000000133f000000-0x000000133fdb5fff]
[    0.000000]   node   0: [mem 0x000000133fdba000-0x000000133fe81fff]
[    0.000000]   node   0: [mem 0x000000133fe90000-0x000000133fe9ffff]
[    0.000000]   node   0: [mem 0x000000133feb2000-0x000000133feb9fff]
[    0.000000] Initmem setup node 0 [mem 0x0000000000000000-0x000000133feb9=
fff]
[    0.000000] On node 0 totalpages: 786250
[    0.000000]   Normal zone: 6911 pages used for memmap
[    0.000000]   Normal zone: 0 pages reserved
[    0.000000]   Normal zone: 786250 pages, LIFO batch:15
[    0.000000] Booting Linux...
[    0.000000] CPU CAPS: [flush,stbar,swap,muldiv,v9,ultra3,mul32,div32]
[    0.000000] CPU CAPS: [v8plus,vis,vis2]
[    0.000000] PERCPU: Embedded 8 pages/cpu @fff000133f800000 s21632 r8192 =
d35712 u2097152
[    0.000000] pcpu-alloc: s21632 r8192 d35712 u2097152 alloc=3D1*4194304
[    0.000000] pcpu-alloc: [0] 0 1=20
[    0.000000] Built 1 zonelists in Zone order, mobility grouping on.  Tota=
l pages: 779339
[    0.000000] Kernel command line: root=3D/dev/sda2 ro debug ignore_loglev=
el
[    0.000000] PID hash table entries: 4096 (order: 2, 32768 bytes)
[    0.000000] Dentry cache hash table entries: 1048576 (order: 10, 8388608=
 bytes)
[    0.000000] Inode-cache hash table entries: 524288 (order: 9, 4194304 by=
tes)
[    0.000000] Sorting __ex_table...
[    0.000000] Memory: 6158472K/6290000K available (4431K kernel code, 338K=
 rwdata, 1480K rodata, 272K init, 13490K bss, 131528K reserved, 0K cma-rese=
rved)
[    0.000000] Hierarchical RCU implementation.
[    0.000000] 	RCU lockdep checking is enabled.
[    0.000000] 	Additional per-CPU info printed with stalls.
[    0.000000] Running RCU self tests
[    0.000000] NR_IRQS:2048 nr_irqs:2048 1
[   30.477963] clocksource: mult[53555555] shift[24]
[   30.534214] clockevent: mult[3126e98] shift[32]
[   30.589150] Console: colour dummy device 80x25
[   30.642453] console [tty0] enabled
[   30.683123] bootconsole [earlyprom0] disabled
[   30.735324] Lock dependency validator: Copyright (c) 2006 Red Hat, Inc.,=
 Ingo Molnar
[   30.735350] ... MAX_LOCKDEP_SUBCLASSES:  8
[   30.735366] ... MAX_LOCK_DEPTH:          48
[   30.735382] ... MAX_LOCKDEP_KEYS:        8191
[   30.735398] ... CLASSHASH_SIZE:          4096
[   30.735414] ... MAX_LOCKDEP_ENTRIES:     32768
[   30.735430] ... MAX_LOCKDEP_CHAINS:      65536
[   30.735446] ... CHAINHASH_SIZE:          32768
[   30.735462]  memory used by lock dependency info: 8159 kB
[   30.735480]  per task-struct memory footprint: 1920 bytes
[   30.735589] kmemleak: Early log buffer exceeded (2164), please increase =
DEBUG_KMEMLEAK_EARLY_LOG_SIZE
[   30.815489] Calibrating delay using timer specific routine.. 24.08 BogoM=
IPS (lpjH164)
[   30.815523] pid_max: default: 32768 minimum: 301
[   30.815855] Security Framework initialized
[   30.816020] Mount-cache hash table entries: 16384 (order: 4, 131072 byte=
s)
[   30.816054] Mountpoint-cache hash table entries: 16384 (order: 4, 131072=
 bytes)
[   30.819058] Initializing cgroup subsys blkio
[   30.819111] Initializing cgroup subsys memory
[   30.819205] Initializing cgroup subsys devices
[   30.819273] Initializing cgroup subsys freezer
[   30.819363] Initializing cgroup subsys net_cls
[   30.819407] Initializing cgroup subsys hugetlb
[   30.826648] CPU 0: synchronized TICK with master CPU (last diff 0 cycles=
, maxerr 6 cycles)
[   30.827131] Brought up 2 CPUs
[   30.829328] devtmpfs: initialized
[   30.830857] Performance events:=20
[   30.830892] Testing NMI watchdog ... OK.
[   30.910944] Supported PMU type is 'ultra3i'
[   30.933325] prandom: seed boundary self test passed
[   30.935648] prandom: 100 self tests passed
[   30.951777] NET: Registered protocol family 16
[   30.957412] IRQ pre handler NOT supported.
[   30.957507] IRQ pre handler NOT supported.
[   30.957560] IRQ pre handler NOT supported.
[   30.957611] IRQ pre handler NOT supported.
[   30.957661] IRQ pre handler NOT supported.
[   30.957989] IRQ pre handler NOT supported.
[   30.958312] IRQ pre handler NOT supported.
[   30.958602] IRQ pre handler NOT supported.
[   30.958656] IRQ pre handler NOT supported.
[   30.958706] IRQ pre handler NOT supported.
[   30.958756] IRQ pre handler NOT supported.
[   30.958806] IRQ pre handler NOT supported.
[   30.959851] IRQ pre handler NOT supported.
[   30.965299] IRQ pre handler NOT supported.
[   30.965632] IRQ pre handler NOT supported.
[   30.965918] IRQ pre handler NOT supported.
[   30.966210] IRQ pre handler NOT supported.
[   30.966780] IRQ pre handler NOT supported.
[   30.967314] IRQ pre handler NOT supported.
[   30.967654] IRQ pre handler NOT supported.
[   30.968469] IRQ pre handler NOT supported.
[   30.968768] IRQ pre handler NOT supported.
[   30.968821] IRQ pre handler NOT supported.
[   30.968872] IRQ pre handler NOT supported.
[   30.968922] IRQ pre handler NOT supported.
[   30.968972] IRQ pre handler NOT supported.
[   30.969305] IRQ pre handler NOT supported.
[   30.970086] IRQ pre handler NOT supported.
[   30.970849] IRQ pre handler NOT supported.
[   30.970904] IRQ pre handler NOT supported.
[   30.970954] IRQ pre handler NOT supported.
[   30.971015] IRQ pre handler NOT supported.
[   30.971065] IRQ pre handler NOT supported.
[   30.971373] IRQ pre handler NOT supported.
[   30.971701] IRQ pre handler NOT supported.
[   30.975089] /pci@1f,700000: TOMATILLO PCI Bus Module ver[4:0]
[   30.975135] /pci@1f,700000: PCI IO[7f601000000] MEM[7f700000000]
[   30.977313] PCI: Scanning PBM /pci@1f,700000
[   30.977926] schizo f0069c00: PCI host bridge to bus 0000:00
[   30.977973] pci_bus 0000:00: root bus resource [io  0x7f601000000-0x7f60=
1ffffff] (bus address [0x0000-0xffffff])
[   30.978028] pci_bus 0000:00: root bus resource [mem 0x7f700000000-0x7f7f=
fffffff] (bus address [0x00000000-0xffffffff])
[   30.978084] pci_bus 0000:00: root bus resource [bus 00]
[   30.978452] pci 0000:00:02.0: PME# supported from D3hot
[   30.979420] pci 0000:00:02.1: PME# supported from D3hot
[   30.980740] /pci@1e,600000: TOMATILLO PCI Bus Module ver[4:0]
[   30.980781] /pci@1e,600000: PCI IO[7fe01000000] MEM[7ff00000000]
[   30.982845] PCI: Scanning PBM /pci@1e,600000
[   30.983388] schizo f00732d0: PCI host bridge to bus 0001:00
[   30.983432] pci_bus 0001:00: root bus resource [io  0x7fe01000000-0x7fe0=
1ffffff] (bus address [0x0000-0xffffff])
[   30.983486] pci_bus 0001:00: root bus resource [mem 0x7ff00000000-0x7fff=
fffffff] (bus address [0x00000000-0xffffffff])
[   30.983541] pci_bus 0001:00: root bus resource [bus 00]
[   30.984375] pci 0001:00:06.0: quirk: [io  0x7fe01000800-0x7fe0100083f] c=
laimed by ali7101 ACPI
[   30.984431] pci 0001:00:06.0: quirk: [io  0x7fe01000600-0x7fe0100061f] c=
laimed by ali7101 SMB
[   30.985212] pci 0001:00:0a.0: PME# supported from D3cold
[   30.987328] pci 0001:00:07.0: can't claim BAR 0 [io  0x7fe01000000-0x7fe=
0100ffff]: address conflict with 0001:00:06.0 [io  0x7fe01000600-0x7fe01000=
61f]
[   30.987395] pci 0001:00:07.0: can't claim BAR 1 [mem 0x7ff00000000-0x7ff=
000fffff]: address conflict with Video RAM area [??? 0x7ff000a0000-0x7ff000=
bffff flags 0x80000000]
[   30.987469] pci 0001:00:07.0: can't claim BAR 2 [mem 0x7ff00000000-0x7ff=
000fffff]: address conflict with Video RAM area [??? 0x7ff000a0000-0x7ff000=
bffff flags 0x80000000]
[   30.988020] /pci@1c,600000: TOMATILLO PCI Bus Module ver[4:0]
[   30.988060] /pci@1c,600000: PCI IO[7ce01000000] MEM[7cf00000000]
[   30.990176] PCI: Scanning PBM /pci@1c,600000
[   30.990725] schizo f007c6ac: PCI host bridge to bus 0002:00
[   30.990769] pci_bus 0002:00: root bus resource [io  0x7ce01000000-0x7ce0=
1ffffff] (bus address [0x0000-0xffffff])
[   30.990823] pci_bus 0002:00: root bus resource [mem 0x7cf00000000-0x7cff=
fffffff] (bus address [0x00000000-0xffffffff])
[   30.990878] pci_bus 0002:00: root bus resource [bus 00]
[   30.991141] pci 0002:00:02.0: supports D1 D2
[   30.991848] pci 0002:00:02.1: supports D1 D2
[   30.993077] /pci@1d,700000: TOMATILLO PCI Bus Module ver[4:0]
[   30.993118] /pci@1d,700000: PCI IO[7c601000000] MEM[7c700000000]
[   30.995199] PCI: Scanning PBM /pci@1d,700000
[   30.995724] schizo f00859d4: PCI host bridge to bus 0003:00
[   30.995770] pci_bus 0003:00: root bus resource [io  0x7c601000000-0x7c60=
1ffffff] (bus address [0x0000-0xffffff])
[   30.995824] pci_bus 0003:00: root bus resource [mem 0x7c700000000-0x7c7f=
fffffff] (bus address [0x00000000-0xffffffff])
[   30.995880] pci_bus 0003:00: root bus resource [bus 00]
[   30.996221] pci 0003:00:02.0: PME# supported from D3hot
[   30.997266] pci 0003:00:02.1: PME# supported from D3hot
[   31.022260] vgaarb: loaded
[   31.023041] SCSI subsystem initialized
[   31.025931] /pci@1e,600000/isa@7/rtc@0,70: RTC regs at 0x7fe01000070
[   31.028397] Switched to clocksource stick
[   31.054697] NET: Registered protocol family 2
[   31.056642] TCP established hash table entries: 65536 (order: 6, 524288 =
bytes)
[   31.058829] TCP bind hash table entries: 65536 (order: 9, 4194304 bytes)
[   31.084748] TCP: Hash tables configured (established 65536 bind 65536)
[   31.085517] TCP: reno registered
[   31.085666] UDP hash table entries: 4096 (order: 6, 655360 bytes)
[   31.089501] UDP-Lite hash table entries: 4096 (order: 6, 655360 bytes)
[   31.094368] NET: Registered protocol family 1
[   31.094604] pci 0001:00:07.0: Activating ISA DMA hang workarounds
[   31.094684] PCI: Enabling device: (0001:00:0a.0), cmd 2
[   31.148475] PCI: CLS 64 bytes, default 64
[   31.149282] power: Control reg at 7fe01000800
[   31.150795] chmc: UltraSPARC-IIIi memory controller at /memory-controlle=
r@0,0
[   31.150917] chmc: UltraSPARC-IIIi memory controller at /memory-controlle=
r@1,0
[   31.153656] futex hash table entries: 512 (order: 3, 65536 bytes)
[   31.155731] HugeTLB registered 8 MB page size, pre-allocated 0 pages
[   31.159842] cryptomgr_test (31) used greatest stack depth: 9256 bytes le=
ft
[   31.161577] Block layer SCSI generic (bsg) driver version 0.4 loaded (ma=
jor 252)
[   31.162051] io scheduler noop registered
[   31.162178] io scheduler cfq registered (default)
[   31.162216] start plist test
[   31.170196] end plist test
[   31.172215] f00ac5a0: ttyS0 at MMIO 0x7fe010003f8 (irq =3D 15, base_baud=
 =3D 115387) is a 16550A
[   31.172350] Console: ttyS0 (SU)
[   45.304038] console [ttyS0] enabled
[   45.351580] f00ae120: ttyS1 at MMIO 0x7fe010002e8 (irq =3D 15, base_baud=
 =3D 115387) is a 16550A
[   45.464794] PCI: Enabling device: (0002:00:02.0), cmd 147
[   45.536772] sym0: <1010-66> rev 0x1 at pci 0002:00:02.0 irq 25
[   45.616269] sym0: No NVRAM, ID 7, Fast-80, LVD, parity checking
[   45.735005] sym0: SCSI BUS has been reset.
[   45.788821] scsi host0: sym-2.2.3
[   45.835642] PCI: Enabling device: (0002:00:02.1), cmd 147
[   45.907496] sym1: <1010-66> rev 0x1 at pci 0002:00:02.1 irq 26
[   45.986770] sym1: No NVRAM, ID 7, Fast-80, LVD, parity checking
[   46.105504] sym1: SCSI BUS has been reset.
[   46.159386] scsi host1: sym-2.2.3
[   46.207192] mousedev: PS/2 mouse device common for all mice
[   46.282488] rtc_cmos rtc_cmos: rtc core: registered rtc_cmos as rtc0
[   46.366147] rtc_cmos rtc_cmos: no alarms, 114 bytes nvram
[   46.438239] TCP: cubic registered
[   46.481874] NET: Registered protocol family 17
[   46.540555] Key type dns_resolver registered
[   46.598762] registered taskstats version 1
[   46.655116] rtc_cmos rtc_cmos: setting system clock to 2000-11-29 01:29:=
24 UTC (975461364)
[   48.885741] scsi 0:0:0:0: Direct-Access     SEAGATE  ST373307LSUN72G  05=
07 PQ: 0 ANSI: 3
[   48.992261] scsi target0:0:0: tagged command queuing enabled, command qu=
eue depth 16.
[   49.095345] scsi target0:0:0: Beginning Domain Validation
[   49.171668] scsi target0:0:0: FAST-80 WIDE SCSI 160.0 MB/s DT (12.5 ns, =
offset 31)
[   49.277725] scsi target0:0:0: Ending Domain Validation
[   49.349133] scsi 0:0:1:0: Direct-Access     SEAGATE  ST336607LSUN36G  03=
07 PQ: 0 ANSI: 3
[   49.455569] scsi target0:0:1: tagged command queuing enabled, command qu=
eue depth 16.
[   49.558605] scsi target0:0:1: Beginning Domain Validation
[   49.635614] scsi target0:0:1: FAST-80 WIDE SCSI 160.0 MB/s DT (12.5 ns, =
offset 31)
[   49.741665] scsi target0:0:1: Ending Domain Validation
[   53.661298] sd 0:0:0:0: [sda] 143374738 512-byte logical blocks: (73.4 G=
B/68.3 GiB)
[   53.763740] sd 0:0:0:0: [sda] Write Protect is off
[   53.826755] sd 0:0:0:0: [sda] Mode Sense: db 00 10 08
[   53.893690] sd 0:0:1:0: [sdb] 71132959 512-byte logical blocks: (36.4 GB=
/33.9 GiB)
[   53.895460] sd 0:0:0:0: [sda] Write cache: disabled, read cache: enabled=
, supports DPO and FUA
[   54.108283] sd 0:0:1:0: [sdb] Write Protect is off
[   54.120491]  sda: sda1 sda2 sda3 sda4
[   54.180861] sd 0:0:0:0: [sda] Attached SCSI disk
[   54.279971] sd 0:0:1:0: [sdb] Mode Sense: db 00 10 08
[   54.348555] sd 0:0:1:0: [sdb] Write cache: disabled, read cache: enabled=
, supports DPO and FUA
[   54.477405]  sdb: sdb1 sdb2 sdb3 sdb4
[   54.533840] sd 0:0:1:0: [sdb] Attached SCSI disk
[   54.598273] EXT4-fs (sda2): couldn't mount as ext3 due to feature incomp=
atibilities
[   54.706156] EXT4-fs (sda2): couldn't mount as ext2 due to feature incomp=
atibilities
[   54.815808] EXT4-fs (sda2): INFO: recovery required on readonly filesyst=
em
[   54.906278] EXT4-fs (sda2): write access will be enabled during recovery
[   55.836517] EXT4-fs (sda2): recovery complete
[   55.911175] EXT4-fs (sda2): mounted filesystem with ordered data mode. O=
pts: (null)
[   56.011987] VFS: Mounted root (ext4 filesystem) readonly on device 8:2.
[   56.115344] devtmpfs: mounted
[   56.735568] stty (52) used greatest stack depth: 5096 bytes left
[   57.817867] systemd-udevd[152]: starting version 204
[   57.932150] tput (160) used greatest stack depth: 4888 bytes left
[   58.055056] tput (167) used greatest stack depth: 4792 bytes left
[   58.265019] udevadm (172) used greatest stack depth: 4072 bytes left
[   58.663827] alim7101_wdt: Steve Hill <steve@navaho.co.uk>
[   58.734948] alim7101_wdt: Detected old alim7101 revision 'a1d'.  If this=
 is a cobalt board, set the 'use_gpio' module parameter.
[   58.890537] PCI: Enabling device: (0001:00:06.0), cmd 1
[   58.964722] pps_core: LinuxPPS API ver. 1 registered
[   58.964959] PCI: Enabling device: (0001:00:03.0), cmd 3
[   58.965049] skge: 1.14 addr 0x7ff00100000 irq 19 chip Genesis rev 0
[   58.967440] skge 0001:00:03.0 eth0: addr 00:00:5a:9a:43:58
[   59.253389] pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rodolfo =
Giometti <giometti@linux.it>
[   59.391306] alim7101_wdt: Steve Hill <steve@navaho.co.uk>
[   59.462417] alim7101_wdt: Detected old alim7101 revision 'a1d'.  If this=
 is a cobalt board, set the 'use_gpio' module parameter.
[   59.470024] skge 0001:00:03.0 eth4: renamed from eth0
[   59.474613] PTP clock support registered
[   59.748787] systemd-udevd[199]: renamed network interface eth0 to eth4
[   59.868966] tg3.c:v3.137 (May 11, 2014)
[   59.919494] PCI: Enabling device: (0000:00:02.0), cmd 2
[   60.045613] ps (216) used greatest stack depth: 3320 bytes left
[   60.166503] tg3 0000:00:02.0 (unnamed net_device) (uninitialized): Canno=
t get nvram lock, tg3_nvram_init failed
[   60.634353] tg3 0000:00:02.0 eth0: Tigon3 [partno(none) rev 2003] (PCI:6=
6MHz:64-bit) MAC address 00:03:ba:5a:99:2d
[   60.770614] tg3 0000:00:02.0 eth0: attached PHY is 5704 (10/100/1000Base=
-T Ethernet) (WireSpeed[1], EEE[0])
[   60.898793] tg3 0000:00:02.0 eth0: RXcsums[1] LinkChgREG[0] MIirq[0] ASF=
[0] TSOcap[1]
[   61.001828] tg3 0000:00:02.0 eth0: dma_rwctrl[763f0000] dma_mask[32-bit]
[   61.090164] PCI: Enabling device: (0000:00:02.1), cmd 2
[   61.329601] tg3 0000:00:02.1 (unnamed net_device) (uninitialized): Canno=
t get nvram lock, tg3_nvram_init failed
[   61.802283] tg3 0000:00:02.1 eth1: Tigon3 [partno(none) rev 2003] (PCI:6=
6MHz:64-bit) MAC address 00:03:ba:5a:99:2e
[   61.938476] tg3 0000:00:02.1 eth1: attached PHY is 5704 (10/100/1000Base=
-T Ethernet) (WireSpeed[1], EEE[0])
[   62.066673] tg3 0000:00:02.1 eth1: RXcsums[1] LinkChgREG[0] MIirq[0] ASF=
[0] TSOcap[1]
[   62.169700] tg3 0000:00:02.1 eth1: dma_rwctrl[763f0000] dma_mask[32-bit]
[   62.258046] PCI: Enabling device: (0003:00:02.0), cmd 2
[   62.497841] tg3 0003:00:02.0 (unnamed net_device) (uninitialized): Canno=
t get nvram lock, tg3_nvram_init failed
[   62.972327] tg3 0003:00:02.0 eth2: Tigon3 [partno(none) rev 2003] (PCI:6=
6MHz:64-bit) MAC address 00:03:ba:5a:99:2f
[   63.108557] tg3 0003:00:02.0 eth2: attached PHY is 5704 (10/100/1000Base=
-T Ethernet) (WireSpeed[1], EEE[0])
[   63.236755] tg3 0003:00:02.0 eth2: RXcsums[1] LinkChgREG[0] MIirq[0] ASF=
[0] TSOcap[1]
[   63.339784] tg3 0003:00:02.0 eth2: dma_rwctrl[763f0000] dma_mask[32-bit]
[   63.428094] PCI: Enabling device: (0003:00:02.1), cmd 2
[   63.669652] tg3 0003:00:02.1 (unnamed net_device) (uninitialized): Canno=
t get nvram lock, tg3_nvram_init failed
[   64.142562] tg3 0003:00:02.1 eth3: Tigon3 [partno(none) rev 2003] (PCI:6=
6MHz:64-bit) MAC address 00:03:ba:5a:99:30
[   64.278743] tg3 0003:00:02.1 eth3: attached PHY is 5704 (10/100/1000Base=
-T Ethernet) (WireSpeed[1], EEE[0])
[   64.406946] tg3 0003:00:02.1 eth3: RXcsums[1] LinkChgREG[0] MIirq[0] ASF=
[0] TSOcap[1]
[   64.509973] tg3 0003:00:02.1 eth3: dma_rwctrl[763f0000] dma_mask[32-bit]
[   65.476390] Adding 3084472k swap on /dev/sda4.  Priority:-1 extents:1 ac=
ross:3084472k=20
[   65.704558] EXT4-fs (sda2): re-mounted. Opts: (null)
[   66.113521] EXT4-fs (sda2): re-mounted. Opts: errors=3Dremount-ro
[   68.151092] loop: module loaded
[   68.467290] EXT4-fs (sda1): mounting ext2 file system using the ext4 sub=
system
[   68.573346] EXT4-fs (sda1): mounted filesystem without journal. Opts: (n=
ull)
[   69.746667] random: dd urandom read with 97 bits of entropy available
[   70.471214] NET: Registered protocol family 10
[   73.134043] tg3 0000:00:02.0 eth0: No firmware running
[   73.607995] IPv6: ADDRCONF(NETDEV_UP): eth0: link is not ready
[   73.691643] ip (1218) used greatest stack depth: 872 bytes left
[   75.134428] tg3 0000:00:02.0 eth0: Link is up at 100 Mbps, full duplex
[   75.220289] tg3 0000:00:02.0 eth0: Flow control is on for TX and on for =
RX
[   75.311095] IPv6: ADDRCONF(NETDEV_CHANGE): eth0: link becomes ready
[   87.626724] random: nonblocking pool is initialized
[  472.436439]=20
[  472.455919] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D[  472.540644] [ INFO: possible irq lock inversion =
dependency detected ]
[  472.625290] 4.0.0 #3 Not tainted
[  472.667599] ---------------------------------------------------------
[  472.752243] aptitude/1742 just changed the state of lock:
[  472.823155]  (ctx_alloc_lock){+.....}, at: [<00000000004505e4>] hugetlb_=
setup+0xc4/0x120
[  472.929532] but this lock was taken by another, HARDIRQ-safe lock in the=
 past:
[  473.024469]  (&rq->lock){-.-.-.}
[  473.024469]=20
[  473.024469] and interrupts could create inverse lock ordering between th=
em.
[  473.024469]=20
[  473.145720]=20
[  473.145720] other info that might help us debug this:
[  473.231596] Chain exists of:
[  473.231596]   &rq->lock --> &(&mm->context.lock)->rlock --> ctx_alloc_lo=
ck
[  473.231596]=20
[  473.344817]  Possible interrupt unsafe locking scenario:
[  473.344817]=20
[  473.434044]        CPU0                    CPU1
[  473.493510]        ----                    ----
[  473.552987]   lock(ctx_alloc_lock);
[  473.598731]                                local_irq_disable();
[  473.676516]                                lock(&rq->lock);
[  473.749707]                                lock(&(&mm->context.lock)->rl=
ock);
[  473.843496]   <Interrupt>
[  473.877814]     lock(&rq->lock);
[  473.920129]=20
[  473.920129]  *** DEADLOCK ***
[  473.920129]=20
[  473.997933] no locks held by aptitude/1742.
[  474.052817]=20
[  474.052817] the shortest dependencies between 2nd lock and 1st lock:
[  474.155771]   -> (&rq->lock){-.-.-.} ops: 702360296882176 {
[  474.228950]      IN-HARDIRQ-W at:
[  474.272414]                         [<00000000004a836c>] __lock_acquire+=
0x84c/0xae0
[  474.373081]                         [<00000000004a8bac>] lock_acquire+0x=
4c/0x80
[  474.469156]                         [<0000000000856fa8>] _raw_spin_lock+=
0x28/0x40
[  474.567523]                         [<000000000048882c>] scheduler_tick+=
0x2c/0xc0
[  474.665886]                         [<00000000004c7260>] update_process_=
times+0x40/0x60
[  474.771116]                         [<00000000004d479c>] tick_periodic+0=
xbc/0xe0
[  474.868334]                         [<00000000004d47cc>] tick_handle_per=
iodic+0xc/0x80
[  474.972420]                         [<000000000042fb74>] timer_interrupt=
+0x94/0xc0
[  475.071928]                         [<0000000000426bac>] sys_call_table+=
0x630/0x7c4
[  475.172580]                         [<00000000004b8788>] console_unlock+=
0x2e8/0x3a0
[  475.273232]                         [<0000000000a40970>] con_init+0x2a0/=
0x2c0
[  475.367013]                         [<0000000000a3ff4c>] console_init+0x=
1c/0x38
[  475.463098]                         [<0000000000a28938>] start_kernel+0x=
2b0/0x3b8
[  475.561464]                         [<0000000000a2a688>] start_early_boo=
t+0xd0/0xe0
[  475.662116]                         [<0000000000843e18>] tlb_fixup_done+=
0x54/0x5c
[  475.760481]                         [<          (null)>]           (null)
[  475.849689]      IN-SOFTIRQ-W at:
[  475.893146]                         [<00000000004a836c>] __lock_acquire+=
0x84c/0xae0
[  475.993811]                         [<00000000004a8bac>] lock_acquire+0x=
4c/0x80
[  476.089887]                         [<0000000000857080>] _raw_spin_lock_=
irqsave+0x40/0x60
[  476.197405]                         [<0000000000491624>] update_blocked_=
averages+0x24/0x100
[  476.307207]                         [<0000000000497ec4>] rebalance_domai=
ns+0x24/0x3a0
[  476.410145]                         [<0000000000498420>] run_rebalance_d=
omains+0x20/0x40
[  476.516517]                         [<0000000000462114>] __do_softirq+0x=
f4/0x240
[  476.613738]                         [<000000000042bb2c>] do_softirq_own_=
stack+0x2c/0x40
[  476.718967]                         [<000000000046256c>] irq_exit+0x4c/0=
xc0
[  476.810459]                         [<000000000042fb7c>] timer_interrupt=
+0x9c/0xc0
[  476.909976]                         [<0000000000426bac>] sys_call_table+=
0x630/0x7c4
[  477.010629]                         [<00000000008577e8>] _raw_spin_unloc=
k_irqrestore+0x48/0x60
[  477.123864]                         [<0000000000487b60>] sched_ttwu_pend=
ing+0x60/0x80
[  477.226802]                         [<00000000004a0c20>] cpu_idle_loop+0=
x160/0x180
[  477.326312]                         [<00000000004a0c4c>] cpu_startup_ent=
ry+0xc/0x20
[  477.426963]                         [<0000000000843f98>] rest_init+0x178=
/0x1a0
[  477.521897]                         [<0000000000a28a30>] start_kernel+0x=
3a8/0x3b8
[  477.620260]                         [<0000000000a2a688>] start_early_boo=
t+0xd0/0xe0
[  477.720915]                         [<0000000000843e18>] tlb_fixup_done+=
0x54/0x5c
[  477.819279]                         [<          (null)>]           (null)
[  477.908485]      IN-RECLAIM_FS-W at:
[  477.955376]                            [<00000000004a836c>] __lock_acqui=
re+0x84c/0xae0
[  478.059471]                            [<00000000004a8bac>] lock_acquire=
+0x4c/0x80
[  478.158980]                            [<0000000000856fa8>] _raw_spin_lo=
ck+0x28/0x40
[  478.260778]                            [<000000000048c0fc>] set_cpus_all=
owed_ptr+0x3c/0x200
[  478.370580]                            [<000000000051d670>] kswapd+0x30/=
0x1e0
[  478.464361]                            [<000000000047d9e4>] kthread+0xc4=
/0xe0
[  478.558149]                            [<0000000000406124>] ret_from_for=
k+0x1c/0x2c
[  478.658811]                            [<          (null)>]           (n=
ull)
[  478.751449]      INITIAL USE at:
[  478.793763]                        [<00000000004a8bac>] lock_acquire+0x4=
c/0x80
[  478.888710]                        [<0000000000857080>] _raw_spin_lock_i=
rqsave+0x40/0x60
[  478.995081]                        [<0000000000484264>] rq_attach_root+0=
x4/0x1e0
[  479.092301]                        [<0000000000a31214>] sched_init+0x2f4=
/0x468
[  479.187234]                        [<0000000000a28854>] start_kernel+0x1=
cc/0x3b8
[  479.284455]                        [<0000000000a2a688>] start_early_boot=
+0xd0/0xe0
[  479.383966]                        [<0000000000843e18>] tlb_fixup_done+0=
x54/0x5c
[  479.481186]                        [<          (null)>]           (null)
[  479.569249]    }
[  479.593264]    ... key      at: [<0000000000a73784>] __key.45057+0x0/0xc
[  479.681339]    ... acquired at:
[  479.722514]    [<00000000004a71f8>] validate_chain.isra.14+0x558/0x660
[  479.808300]    [<00000000004a8540>] __lock_acquire+0xa20/0xae0
[  479.884932]    [<00000000004a8bac>] lock_acquire+0x4c/0x80
[  479.956989]    [<0000000000857080>] _raw_spin_lock_irqsave+0x40/0x60
[  480.040488]    [<00000000008526ac>] __schedule+0x50c/0x720
[  480.112543]    [<0000000000852aa0>] schedule+0x60/0x80
[  480.180025]    [<0000000000852cec>] schedule_preempt_disabled+0xc/0x40
[  480.265810]    [<00000000004a0c28>] cpu_idle_loop+0x168/0x180
[  480.341299]    [<00000000004a0c4c>] cpu_startup_entry+0xc/0x20
[  480.417931]    [<0000000000843f98>] rest_init+0x178/0x1a0
[  480.488845]    [<0000000000a28a30>] start_kernel+0x3a8/0x3b8
[  480.563190]    [<0000000000a2a688>] start_early_boot+0xd0/0xe0
[  480.639826]    [<0000000000843e18>] tlb_fixup_done+0x54/0x5c
[  480.714170]    [<          (null)>]           (null)
[  480.779364]=20
[  480.798804]  -> (&(&mm->context.lock)->rlock){......} ops: 2511486421303=
296 {
[  480.892593]     INITIAL USE at:
[  480.933769]                      [<00000000004a8bac>] lock_acquire+0x4c/=
0x80
[  481.026421]                      [<0000000000857080>] _raw_spin_lock_irq=
save+0x40/0x60
[  481.130512]                      [<000000000044dfd4>] tsb_grow+0xf4/0x240
[  481.219719]                      [<000000000044e160>] init_new_context+0=
x40/0x80
[  481.316948]                      [<000000000045b5f0>] mm_init+0x130/0x160
[  481.406155]                      [<000000000045bbf0>] mm_alloc+0x30/0x60
[  481.494225]                      [<000000000056c810>] do_execveat_common=
.isra.22+0x1d0/0x3e0
[  481.605181]                      [<000000000056ca3c>] do_execve+0x1c/0x40
[  481.694386]                      [<0000000000426d60>] run_init_process+0=
x20/0x40
[  481.791615]                      [<0000000000426d84>] try_to_run_init_pr=
ocess+0x4/0x60
[  481.895699]                      [<0000000000844050>] kernel_init+0x90/0=
x100
[  481.988338]                      [<0000000000406124>] ret_from_fork+0x1c=
/0x2c
[  482.082126]                      [<          (null)>]           (null)
[  482.167909]   }
[  482.190780]   ... key      at: [<0000000000a6d928>] __key.25425+0x0/0x8
[  482.277712]   ... acquired at:
[  482.317743]    [<00000000004a71f8>] validate_chain.isra.14+0x558/0x660
[  482.403529]    [<00000000004a8540>] __lock_acquire+0xa20/0xae0
[  482.480160]    [<00000000004a8bac>] lock_acquire+0x4c/0x80
[  482.552219]    [<0000000000856fa8>] _raw_spin_lock+0x28/0x40
[  482.626565]    [<000000000044fdf0>] get_new_mmu_context+0x10/0x160
[  482.707775]    [<000000000056b9f0>] exec_mmap+0x90/0x260
[  482.777542]    [<000000000056bbf0>] flush_old_exec+0x30/0xa0
[  482.851888]    [<00000000005b8904>] load_elf_binary+0x304/0xae0
[  482.929665]    [<000000000056b2e8>] search_binary_handler+0x88/0x240
[  483.013161]    [<000000000084b108>] exec_binprm+0x134/0x1a0
[  483.086362]    [<000000000056c8f0>] do_execveat_common.isra.22+0x2b0/0x3=
e0
[  483.176723]    [<000000000056ca3c>] do_execve+0x1c/0x40
[  483.245347]    [<0000000000426d60>] run_init_process+0x20/0x40
[  483.321982]    [<0000000000426d84>] try_to_run_init_process+0x4/0x60
[  483.405477]    [<0000000000844050>] kernel_init+0x90/0x100
[  483.477535]    [<0000000000406124>] ret_from_fork+0x1c/0x2c
[  483.550736]    [<          (null)>]           (null)
[  483.615930]=20
[  483.635370] -> (ctx_alloc_lock){+.....} ops: 24777666330624 {
[  483.710858]    HARDIRQ-ON-W at:
[  483.752035]                     [<00000000004a836c>] __lock_acquire+0x84=
c/0xae0
[  483.848126]                     [<00000000004a8bac>] lock_acquire+0x4c/0=
x80
[  483.939621]                     [<0000000000856fa8>] _raw_spin_lock+0x28=
/0x40
[  484.033409]                     [<00000000004505e4>] hugetlb_setup+0xc4/=
0x120
[  484.127201]                     [<0000000000407bc0>] tsb_miss_page_table=
_walk_sun4v_fastpath+0xf0/0x100
[  484.250739]    INITIAL USE at:
[  484.290754]                    [<00000000004a8bac>] lock_acquire+0x4c/0x=
80
[  484.381118]                    [<0000000000856fa8>] _raw_spin_lock+0x28/=
0x40
[  484.473763]                    [<000000000044fdf0>] get_new_mmu_context+=
0x10/0x160
[  484.573280]                    [<000000000056b9f0>] exec_mmap+0x90/0x260
[  484.661343]                    [<000000000056bbf0>] flush_old_exec+0x30/=
0xa0
[  484.753989]                    [<00000000005b8904>] load_elf_binary+0x30=
4/0xae0
[  484.850074]                    [<000000000056b2e8>] search_binary_handle=
r+0x88/0x240
[  484.951870]                    [<000000000084b108>] exec_binprm+0x134/0x=
1a0
[  485.043364]                    [<000000000056c8f0>] do_execveat_common.i=
sra.22+0x2b0/0x3e0
[  485.152033]                    [<000000000056ca3c>] do_execve+0x1c/0x40
[  485.238950]                    [<0000000000426d60>] run_init_process+0x2=
0/0x40
[  485.333892]                    [<0000000000426d84>] try_to_run_init_proc=
ess+0x4/0x60
[  485.435688]                    [<0000000000844050>] kernel_init+0x90/0x1=
00
[  485.526039]                    [<0000000000406124>] ret_from_fork+0x1c/0=
x2c
[  485.617541]                    [<          (null)>]           (null)
[  485.701036]  }
[  485.722763]  ... key      at: [<00000000009e64f0>] ctx_alloc_lock+0x18/0=
x38
[  485.814270]  ... acquired at:
[  485.853158]    [<00000000008478e0>] mark_lock_irq+0x128/0x344
[  485.928649]    [<00000000004a77b0>] mark_lock+0x3b0/0x500
[  485.999561]    [<00000000004a7a68>] mark_irqflags+0x168/0x220
[  486.075050]    [<00000000004a836c>] __lock_acquire+0x84c/0xae0
[  486.151685]    [<00000000004a8bac>] lock_acquire+0x4c/0x80
[  486.223742]    [<0000000000856fa8>] _raw_spin_lock+0x28/0x40
[  486.298086]    [<00000000004505e4>] hugetlb_setup+0xc4/0x120
[  486.372434]    [<0000000000407bc0>] tsb_miss_page_table_walk_sun4v_fastp=
ath+0xf0/0x100
[  486.476527]=20
[  486.495958]=20
[  486.495958] stack backtrace:
[  486.553163] CPU: 0 PID: 1742 Comm: aptitude Not tainted 4.0.0 #3
[  486.632074] Call Trace:
[  486.664098]  [00000000004a57fc] print_irq_inversion_bug+0x1dc/0x200
[  486.746456]  [00000000004a5a40] check_usage_backwards+0x100/0x120
[  486.826520]  [00000000008478e0] mark_lock_irq+0x128/0x344
[  486.897433]  [00000000004a77b0] mark_lock+0x3b0/0x500
[  486.963771]  [00000000004a7a68] mark_irqflags+0x168/0x220
[  487.034685]  [00000000004a836c] __lock_acquire+0x84c/0xae0
[  487.106745]  [00000000004a8bac] lock_acquire+0x4c/0x80
[  487.174225]  [0000000000856fa8] _raw_spin_lock+0x28/0x40
[  487.243997]  [00000000004505e4] hugetlb_setup+0xc4/0x120
[  487.313769]  [0000000000407bc0] tsb_miss_page_table_walk_sun4v_fastpath+=
0xf0/0x100



#
# Automatically generated file; DO NOT EDIT.
# Linux/sparc64 4.0.0 Kernel Configuration
#
CONFIG_64BIT=3Dy
CONFIG_SPARC=3Dy
# CONFIG_SPARC32 is not set
CONFIG_SPARC64=3Dy
CONFIG_ARCH_DEFCONFIG=3D"arch/sparc/configs/sparc64_defconfig"
CONFIG_ARCH_PROC_KCORE_TEXT=3Dy
CONFIG_IOMMU_HELPER=3Dy
CONFIG_STACKTRACE_SUPPORT=3Dy
CONFIG_LOCKDEP_SUPPORT=3Dy
CONFIG_HAVE_LATENCYTOP_SUPPORT=3Dy
CONFIG_ARCH_HIBERNATION_POSSIBLE=3Dy
CONFIG_AUDIT_ARCH=3Dy
CONFIG_HAVE_SETUP_PER_CPU_AREA=3Dy
CONFIG_NEED_PER_CPU_EMBED_FIRST_CHUNK=3Dy
CONFIG_NEED_PER_CPU_PAGE_FIRST_CHUNK=3Dy
CONFIG_MMU=3Dy
CONFIG_NEED_DMA_MAP_STATE=3Dy
CONFIG_NEED_SG_DMA_LENGTH=3Dy
CONFIG_ARCH_SUPPORTS_DEBUG_PAGEALLOC=3Dy
CONFIG_DEFCONFIG_LIST=3D"/lib/modules/$UNAME_RELEASE/.config"
CONFIG_CONSTRUCTORS=3Dy
CONFIG_IRQ_WORK=3Dy

#
# General setup
#
CONFIG_INIT_ENV_ARG_LIMIT2
CONFIG_CROSS_COMPILE=3D""
# CONFIG_COMPILE_TEST is not set
CONFIG_LOCALVERSION=3D""
CONFIG_LOCALVERSION_AUTO=3Dy
CONFIG_DEFAULT_HOSTNAME=3D"(none)"
CONFIG_SWAP=3Dy
CONFIG_SYSVIPC=3Dy
CONFIG_SYSVIPC_SYSCTL=3Dy
CONFIG_POSIX_MQUEUE=3Dy
CONFIG_POSIX_MQUEUE_SYSCTL=3Dy
CONFIG_CROSS_MEMORY_ATTACH=3Dy
CONFIG_FHANDLE=3Dy
# CONFIG_USELIB is not set
# CONFIG_AUDIT is not set
CONFIG_HAVE_ARCH_AUDITSYSCALL=3Dy

#
# IRQ subsystem
#
CONFIG_GENERIC_IRQ_SHOW=3Dy
CONFIG_IRQ_PREFLOW_FASTEOI=3Dy
CONFIG_GENERIC_MSI_IRQ=3Dy
CONFIG_SPARSE_IRQ=3Dy
CONFIG_GENERIC_CLOCKEVENTS=3Dy
CONFIG_GENERIC_CLOCKEVENTS_BUILD=3Dy
CONFIG_GENERIC_CMOS_UPDATE=3Dy

#
# Timers subsystem
#
CONFIG_TICK_ONESHOT=3Dy
CONFIG_NO_HZ_COMMON=3Dy
# CONFIG_HZ_PERIODIC is not set
CONFIG_NO_HZ_IDLE=3Dy
# CONFIG_NO_HZ_FULL is not set
CONFIG_NO_HZ=3Dy
CONFIG_HIGH_RES_TIMERS=3Dy

#
# CPU/Task time and stats accounting
#
CONFIG_TICK_CPU_ACCOUNTING=3Dy
# CONFIG_VIRT_CPU_ACCOUNTING_GEN is not set
# CONFIG_BSD_PROCESS_ACCT is not set
CONFIG_TASKSTATS=3Dy
CONFIG_TASK_DELAY_ACCT=3Dy
CONFIG_TASK_XACCT=3Dy
CONFIG_TASK_IO_ACCOUNTING=3Dy

#
# RCU Subsystem
#
CONFIG_TREE_RCU=3Dy
CONFIG_SRCU=3Dy
# CONFIG_TASKS_RCU is not set
CONFIG_RCU_STALL_COMMON=3Dy
# CONFIG_RCU_USER_QS is not set
CONFIG_RCU_FANOUTd
CONFIG_RCU_FANOUT_LEAF=16
# CONFIG_RCU_FANOUT_EXACT is not set
# CONFIG_RCU_FAST_NO_HZ is not set
# CONFIG_TREE_RCU_TRACE is not set
CONFIG_RCU_KTHREAD_PRIO=3D0
# CONFIG_RCU_NOCB_CPU is not set
# CONFIG_BUILD_BIN2C is not set
# CONFIG_IKCONFIG is not set
CONFIG_LOG_BUF_SHIFT=17
CONFIG_LOG_CPU_MAX_BUF_SHIFT=12
CONFIG_CGROUPS=3Dy
# CONFIG_CGROUP_DEBUG is not set
CONFIG_CGROUP_FREEZER=3Dy
CONFIG_CGROUP_DEVICE=3Dy
CONFIG_CPUSETS=3Dy
CONFIG_PROC_PID_CPUSET=3Dy
CONFIG_CGROUP_CPUACCT=3Dy
CONFIG_PAGE_COUNTER=3Dy
CONFIG_MEMCG=3Dy
CONFIG_MEMCG_SWAP=3Dy
CONFIG_MEMCG_SWAP_ENABLED=3Dy
# CONFIG_MEMCG_KMEM is not set
CONFIG_CGROUP_HUGETLB=3Dy
# CONFIG_CGROUP_PERF is not set
CONFIG_CGROUP_SCHED=3Dy
CONFIG_FAIR_GROUP_SCHED=3Dy
CONFIG_CFS_BANDWIDTH=3Dy
CONFIG_RT_GROUP_SCHED=3Dy
CONFIG_BLK_CGROUP=3Dy
CONFIG_DEBUG_BLK_CGROUP=3Dy
# CONFIG_CHECKPOINT_RESTORE is not set
CONFIG_NAMESPACES=3Dy
CONFIG_UTS_NS=3Dy
CONFIG_IPC_NS=3Dy
# CONFIG_USER_NS is not set
CONFIG_PID_NS=3Dy
CONFIG_NET_NS=3Dy
# CONFIG_SCHED_AUTOGROUP is not set
# CONFIG_SYSFS_DEPRECATED is not set
# CONFIG_RELAY is not set
# CONFIG_BLK_DEV_INITRD is not set
# CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
CONFIG_SYSCTL=3Dy
CONFIG_ANON_INODES=3Dy
CONFIG_HAVE_UID16=3Dy
CONFIG_SYSCTL_EXCEPTION_TRACE=3Dy
CONFIG_BPF=3Dy
# CONFIG_EXPERT is not set
CONFIG_UID16=3Dy
CONFIG_SGETMASK_SYSCALL=3Dy
CONFIG_SYSFS_SYSCALL=3Dy
# CONFIG_SYSCTL_SYSCALL is not set
CONFIG_KALLSYMS=3Dy
CONFIG_KALLSYMS_ALL=3Dy
CONFIG_PRINTK=3Dy
CONFIG_BUG=3Dy
CONFIG_ELF_CORE=3Dy
CONFIG_BASE_FULL=3Dy
CONFIG_FUTEX=3Dy
CONFIG_EPOLL=3Dy
CONFIG_SIGNALFD=3Dy
CONFIG_TIMERFD=3Dy
CONFIG_EVENTFD=3Dy
# CONFIG_BPF_SYSCALL is not set
CONFIG_SHMEM=3Dy
CONFIG_AIO=3Dy
CONFIG_ADVISE_SYSCALLS=3Dy
CONFIG_PCI_QUIRKS=3Dy
# CONFIG_EMBEDDED is not set
CONFIG_HAVE_PERF_EVENTS=3Dy
CONFIG_PERF_USE_VMALLOC=3Dy

#
# Kernel Performance Events And Counters
#
CONFIG_PERF_EVENTS=3Dy
# CONFIG_DEBUG_PERF_USE_VMALLOC is not set
CONFIG_VM_EVENT_COUNTERS=3Dy
# CONFIG_COMPAT_BRK is not set
CONFIG_SLAB=3Dy
# CONFIG_SLUB is not set
# CONFIG_SYSTEM_TRUSTED_KEYRING is not set
# CONFIG_PROFILING is not set
CONFIG_HAVE_OPROFILE=3Dy
# CONFIG_KPROBES is not set
CONFIG_JUMP_LABEL=3Dy
# CONFIG_UPROBES is not set
CONFIG_HAVE_64BIT_ALIGNED_ACCESS=3Dy
CONFIG_HAVE_KPROBES=3Dy
CONFIG_HAVE_KRETPROBES=3Dy
CONFIG_HAVE_NMI_WATCHDOG=3Dy
CONFIG_HAVE_ARCH_TRACEHOOK=3Dy
CONFIG_HAVE_DMA_ATTRS=3Dy
CONFIG_GENERIC_SMP_IDLE_THREAD=3Dy
CONFIG_HAVE_DMA_API_DEBUG=3Dy
CONFIG_HAVE_ARCH_JUMP_LABEL=3Dy
CONFIG_HAVE_RCU_TABLE_FREE=3Dy
CONFIG_ARCH_HAVE_NMI_SAFE_CMPXCHG=3Dy
CONFIG_ARCH_WANT_IPC_PARSE_VERSION=3Dy
CONFIG_ARCH_WANT_COMPAT_IPC_PARSE_VERSION=3Dy
CONFIG_ARCH_WANT_OLD_COMPAT_IPC=3Dy
# CONFIG_CC_STACKPROTECTOR is not set
CONFIG_HAVE_CONTEXT_TRACKING=3Dy
CONFIG_HAVE_VIRT_CPU_ACCOUNTING_GEN=3Dy
CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE=3Dy
CONFIG_MODULES_USE_ELF_RELA=3Dy
CONFIG_ODD_RT_SIGACTION=3Dy
CONFIG_OLD_SIGSUSPEND=3Dy
CONFIG_COMPAT_OLD_SIGACTION=3Dy

#
# GCOV-based kernel profiling
#
CONFIG_GCOV_KERNEL=3Dy
# CONFIG_ARCH_HAS_GCOV_PROFILE_ALL is not set
CONFIG_GCOV_FORMAT_AUTODETECT=3Dy
# CONFIG_GCOV_FORMAT_3_4 is not set
# CONFIG_GCOV_FORMAT_4_7 is not set
# CONFIG_HAVE_GENERIC_DMA_COHERENT is not set
CONFIG_SLABINFO=3Dy
CONFIG_RT_MUTEXES=3Dy
CONFIG_BASE_SMALL=3D0
CONFIG_MODULES=3Dy
# CONFIG_MODULE_FORCE_LOAD is not set
CONFIG_MODULE_UNLOAD=3Dy
# CONFIG_MODULE_FORCE_UNLOAD is not set
# CONFIG_MODVERSIONS is not set
# CONFIG_MODULE_SRCVERSION_ALL is not set
# CONFIG_MODULE_SIG is not set
# CONFIG_MODULE_COMPRESS is not set
CONFIG_STOP_MACHINE=3Dy
CONFIG_BLOCK=3Dy
CONFIG_BLK_DEV_BSG=3Dy
CONFIG_BLK_DEV_BSGLIB=3Dy
CONFIG_BLK_DEV_INTEGRITY=3Dy
CONFIG_BLK_DEV_THROTTLING=3Dy
# CONFIG_BLK_CMDLINE_PARSER is not set

#
# Partition Types
#
CONFIG_PARTITION_ADVANCED=3Dy
# CONFIG_ACORN_PARTITION is not set
CONFIG_AIX_PARTITION=3Dy
CONFIG_OSF_PARTITION=3Dy
# CONFIG_AMIGA_PARTITION is not set
# CONFIG_ATARI_PARTITION is not set
CONFIG_MAC_PARTITION=3Dy
CONFIG_MSDOS_PARTITION=3Dy
CONFIG_BSD_DISKLABEL=3Dy
CONFIG_MINIX_SUBPARTITION=3Dy
CONFIG_SOLARIS_X86_PARTITION=3Dy
CONFIG_UNIXWARE_DISKLABEL=3Dy
CONFIG_LDM_PARTITION=3Dy
# CONFIG_LDM_DEBUG is not set
CONFIG_SGI_PARTITION=3Dy
CONFIG_ULTRIX_PARTITION=3Dy
CONFIG_SUN_PARTITION=3Dy
CONFIG_KARMA_PARTITION=3Dy
CONFIG_EFI_PARTITION=3Dy
CONFIG_SYSV68_PARTITION=3Dy
# CONFIG_CMDLINE_PARTITION is not set
CONFIG_BLOCK_COMPAT=3Dy

#
# IO Schedulers
#
CONFIG_IOSCHED_NOOP=3Dy
# CONFIG_IOSCHED_DEADLINE is not set
CONFIG_IOSCHED_CFQ=3Dy
CONFIG_CFQ_GROUP_IOSCHED=3Dy
CONFIG_DEFAULT_CFQ=3Dy
# CONFIG_DEFAULT_NOOP is not set
CONFIG_DEFAULT_IOSCHED=3D"cfq"
CONFIG_UNINLINE_SPIN_UNLOCK=3Dy
CONFIG_ARCH_SUPPORTS_ATOMIC_RMW=3Dy
CONFIG_RWSEM_SPIN_ON_OWNER=3Dy
CONFIG_LOCK_SPIN_ON_OWNER=3Dy
CONFIG_FREEZER=3Dy

#
# Processor type and features
#
CONFIG_SMP=3Dy
CONFIG_NR_CPUS=3D2
# CONFIG_HZ_100 is not set
CONFIG_HZ_250=3Dy
# CONFIG_HZ_300 is not set
# CONFIG_HZ_1000 is not set
CONFIG_HZ%0
CONFIG_SCHED_HRTICK=3Dy
CONFIG_RWSEM_XCHGADD_ALGORITHM=3Dy
CONFIG_GENERIC_HWEIGHT=3Dy
CONFIG_GENERIC_CALIBRATE_DELAY=3Dy
CONFIG_ARCH_MAY_HAVE_PC_FDC=3Dy
CONFIG_SPARC64_SMP=3Dy
CONFIG_EARLYFB=3Dy
CONFIG_SECCOMP=3Dy
CONFIG_HOTPLUG_CPU=3Dy

#
# CPU Frequency scaling
#
CONFIG_CPU_FREQ=3Dy
CONFIG_CPU_FREQ_GOV_COMMON=3Dy
CONFIG_CPU_FREQ_STAT=3Dy
# CONFIG_CPU_FREQ_STAT_DETAILS is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_PERFORMANCE is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_POWERSAVE is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_USERSPACE is not set
CONFIG_CPU_FREQ_DEFAULT_GOV_ONDEMAND=3Dy
# CONFIG_CPU_FREQ_DEFAULT_GOV_CONSERVATIVE is not set
CONFIG_CPU_FREQ_GOV_PERFORMANCE=3Dy
# CONFIG_CPU_FREQ_GOV_POWERSAVE is not set
# CONFIG_CPU_FREQ_GOV_USERSPACE is not set
CONFIG_CPU_FREQ_GOV_ONDEMAND=3Dy
# CONFIG_CPU_FREQ_GOV_CONSERVATIVE is not set

#
# CPU frequency scaling drivers
#
CONFIG_SPARC_US3_CPUFREQ=3Dm
CONFIG_SPARC_US2E_CPUFREQ=3Dm
CONFIG_US3_MC=3Dy
# CONFIG_NUMA is not set
CONFIG_ARCH_SELECT_MEMORY_MODEL=3Dy
CONFIG_ARCH_SPARSEMEM_ENABLE=3Dy
CONFIG_ARCH_SPARSEMEM_DEFAULT=3Dy
CONFIG_SELECT_MEMORY_MODEL=3Dy
CONFIG_SPARSEMEM_MANUAL=3Dy
CONFIG_SPARSEMEM=3Dy
CONFIG_HAVE_MEMORY_PRESENT=3Dy
CONFIG_SPARSEMEM_EXTREME=3Dy
CONFIG_SPARSEMEM_VMEMMAP_ENABLE=3Dy
CONFIG_SPARSEMEM_VMEMMAP=3Dy
CONFIG_HAVE_MEMBLOCK=3Dy
CONFIG_HAVE_MEMBLOCK_NODE_MAP=3Dy
CONFIG_NO_BOOTMEM=3Dy
# CONFIG_HAVE_BOOTMEM_INFO_NODE is not set
CONFIG_PAGEFLAGS_EXTENDED=3Dy
CONFIG_SPLIT_PTLOCK_CPUS=3D4
CONFIG_COMPACTION=3Dy
CONFIG_MIGRATION=3Dy
CONFIG_PHYS_ADDR_T_64BIT=3Dy
CONFIG_ZONE_DMA_FLAG=3D0
# CONFIG_KSM is not set
CONFIG_DEFAULT_MMAP_MIN_ADDR@96
CONFIG_TRANSPARENT_HUGEPAGE=3Dy
CONFIG_TRANSPARENT_HUGEPAGE_ALWAYS=3Dy
# CONFIG_TRANSPARENT_HUGEPAGE_MADVISE is not set
# CONFIG_CLEANCACHE is not set
# CONFIG_FRONTSWAP is not set
# CONFIG_CMA is not set
# CONFIG_ZPOOL is not set
# CONFIG_ZBUD is not set
# CONFIG_ZSMALLOC is not set
CONFIG_HIBERNATE_CALLBACKS=3Dy
CONFIG_HIBERNATION=3Dy
CONFIG_PM_STD_PARTITION=3D""
CONFIG_PM_SLEEP=3Dy
CONFIG_PM_SLEEP_SMP=3Dy
# CONFIG_PM_AUTOSLEEP is not set
# CONFIG_PM_WAKELOCKS is not set
CONFIG_PM=3Dy
# CONFIG_PM_DEBUG is not set
# CONFIG_WQ_POWER_EFFICIENT_DEFAULT is not set
# CONFIG_SCHED_SMT is not set
# CONFIG_SCHED_MC is not set
CONFIG_PREEMPT_NONE=3Dy
# CONFIG_PREEMPT_VOLUNTARY is not set
# CONFIG_PREEMPT is not set
CONFIG_PREEMPT_COUNT=3Dy
# CONFIG_CMDLINE_BOOL is not set

#
# Bus options (PCI etc.)
#
CONFIG_SBUS=3Dy
CONFIG_SBUSCHAR=3Dy
# CONFIG_SUN_LDOMS is not set
CONFIG_PCI=3Dy
CONFIG_PCI_DOMAINS=3Dy
CONFIG_PCI_SYSCALL=3Dy
CONFIG_PCI_MSI=3Dy
# CONFIG_PCI_DEBUG is not set
# CONFIG_PCI_REALLOC_ENABLE_AUTO is not set
# CONFIG_PCI_STUB is not set
# CONFIG_PCI_IOV is not set
# CONFIG_PCI_PRI is not set
# CONFIG_PCI_PASID is not set

#
# PCI host controller drivers
#
# CONFIG_PCCARD is not set
CONFIG_SUN_OPENPROMFS=3Dm
CONFIG_SPARC64_PCI=3Dy
CONFIG_SPARC64_PCI_MSI=3Dy

#
# Executable file formats
#
CONFIG_BINFMT_ELF=3Dy
CONFIG_COMPAT_BINFMT_ELF=3Dy
CONFIG_CORE_DUMP_DEFAULT_ELF_HEADERS=3Dy
CONFIG_BINFMT_SCRIPT=3Dy
# CONFIG_HAVE_AOUT is not set
CONFIG_BINFMT_MISC=3Dm
CONFIG_COREDUMP=3Dy
CONFIG_COMPAT=3Dy
CONFIG_SYSVIPC_COMPAT=3Dy
CONFIG_KEYS_COMPAT=3Dy
CONFIG_NET=3Dy

#
# Networking options
#
CONFIG_PACKET=3Dy
CONFIG_PACKET_DIAG=3Dm
CONFIG_UNIX=3Dy
CONFIG_UNIX_DIAG=3Dy
CONFIG_XFRM=3Dy
CONFIG_XFRM_ALGO=3Dm
CONFIG_XFRM_USER=3Dm
CONFIG_XFRM_SUB_POLICY=3Dy
CONFIG_XFRM_MIGRATE=3Dy
# CONFIG_XFRM_STATISTICS is not set
CONFIG_XFRM_IPCOMP=3Dm
CONFIG_NET_KEY=3Dm
CONFIG_NET_KEY_MIGRATE=3Dy
CONFIG_INET=3Dy
CONFIG_IP_MULTICAST=3Dy
CONFIG_IP_ADVANCED_ROUTER=3Dy
# CONFIG_IP_FIB_TRIE_STATS is not set
CONFIG_IP_MULTIPLE_TABLES=3Dy
CONFIG_IP_ROUTE_MULTIPATH=3Dy
CONFIG_IP_ROUTE_VERBOSE=3Dy
CONFIG_IP_ROUTE_CLASSID=3Dy
# CONFIG_IP_PNP is not set
CONFIG_NET_IPIP=3Dm
CONFIG_NET_IPGRE_DEMUX=3Dm
CONFIG_NET_IP_TUNNEL=3Dm
CONFIG_NET_IPGRE=3Dm
CONFIG_NET_IPGRE_BROADCAST=3Dy
CONFIG_IP_MROUTE=3Dy
CONFIG_IP_MROUTE_MULTIPLE_TABLES=3Dy
CONFIG_IP_PIMSM_V1=3Dy
CONFIG_IP_PIMSM_V2=3Dy
CONFIG_SYN_COOKIES=3Dy
CONFIG_NET_IPVTI=3Dm
CONFIG_NET_UDP_TUNNEL=3Dm
# CONFIG_NET_FOU is not set
# CONFIG_NET_FOU_IP_TUNNELS is not set
# CONFIG_GENEVE is not set
CONFIG_INET_AH=3Dm
CONFIG_INET_ESP=3Dm
CONFIG_INET_IPCOMP=3Dm
CONFIG_INET_XFRM_TUNNEL=3Dm
CONFIG_INET_TUNNEL=3Dm
CONFIG_INET_XFRM_MODE_TRANSPORT=3Dm
CONFIG_INET_XFRM_MODE_TUNNEL=3Dm
CONFIG_INET_XFRM_MODE_BEET=3Dm
CONFIG_INET_LRO=3Dm
CONFIG_INET_DIAG=3Dm
CONFIG_INET_TCP_DIAG=3Dm
CONFIG_INET_UDP_DIAG=3Dm
# CONFIG_TCP_CONG_ADVANCED is not set
CONFIG_TCP_CONG_CUBIC=3Dy
CONFIG_DEFAULT_TCP_CONG=3D"cubic"
CONFIG_TCP_MD5SIG=3Dy
CONFIG_IPV6=3Dm
CONFIG_IPV6_ROUTER_PREF=3Dy
CONFIG_IPV6_ROUTE_INFO=3Dy
CONFIG_IPV6_OPTIMISTIC_DAD=3Dy
CONFIG_INET6_AH=3Dm
CONFIG_INET6_ESP=3Dm
CONFIG_INET6_IPCOMP=3Dm
CONFIG_IPV6_MIP6=3Dm
CONFIG_INET6_XFRM_TUNNEL=3Dm
CONFIG_INET6_TUNNEL=3Dm
CONFIG_INET6_XFRM_MODE_TRANSPORT=3Dm
CONFIG_INET6_XFRM_MODE_TUNNEL=3Dm
CONFIG_INET6_XFRM_MODE_BEET=3Dm
CONFIG_INET6_XFRM_MODE_ROUTEOPTIMIZATION=3Dm
CONFIG_IPV6_VTI=3Dm
CONFIG_IPV6_SIT=3Dm
CONFIG_IPV6_SIT_6RD=3Dy
CONFIG_IPV6_NDISC_NODETYPE=3Dy
CONFIG_IPV6_TUNNEL=3Dm
CONFIG_IPV6_GRE=3Dm
CONFIG_IPV6_MULTIPLE_TABLES=3Dy
CONFIG_IPV6_SUBTREES=3Dy
CONFIG_IPV6_MROUTE=3Dy
CONFIG_IPV6_MROUTE_MULTIPLE_TABLES=3Dy
CONFIG_IPV6_PIMSM_V2=3Dy
# CONFIG_NETLABEL is not set
# CONFIG_NETWORK_SECMARK is not set
CONFIG_NET_PTP_CLASSIFY=3Dy
# CONFIG_NETWORK_PHY_TIMESTAMPING is not set
CONFIG_NETFILTER=3Dy
# CONFIG_NETFILTER_DEBUG is not set
CONFIG_NETFILTER_ADVANCED=3Dy
CONFIG_BRIDGE_NETFILTER=3Dm

#
# Core Netfilter Configuration
#
CONFIG_NETFILTER_NETLINK=3Dm
CONFIG_NETFILTER_NETLINK_ACCT=3Dm
CONFIG_NETFILTER_NETLINK_QUEUE=3Dm
CONFIG_NETFILTER_NETLINK_LOG=3Dm
CONFIG_NF_CONNTRACK=3Dm
CONFIG_NF_LOG_COMMON=3Dm
CONFIG_NF_CONNTRACK_MARK=3Dy
CONFIG_NF_CONNTRACK_ZONES=3Dy
CONFIG_NF_CONNTRACK_PROCFS=3Dy
CONFIG_NF_CONNTRACK_EVENTS=3Dy
CONFIG_NF_CONNTRACK_TIMEOUT=3Dy
CONFIG_NF_CONNTRACK_TIMESTAMP=3Dy
CONFIG_NF_CONNTRACK_LABELS=3Dy
CONFIG_NF_CT_PROTO_DCCP=3Dm
CONFIG_NF_CT_PROTO_GRE=3Dm
CONFIG_NF_CT_PROTO_SCTP=3Dm
CONFIG_NF_CT_PROTO_UDPLITE=3Dm
CONFIG_NF_CONNTRACK_AMANDA=3Dm
CONFIG_NF_CONNTRACK_FTP=3Dm
CONFIG_NF_CONNTRACK_H323=3Dm
CONFIG_NF_CONNTRACK_IRC=3Dm
CONFIG_NF_CONNTRACK_BROADCAST=3Dm
CONFIG_NF_CONNTRACK_NETBIOS_NS=3Dm
CONFIG_NF_CONNTRACK_SNMP=3Dm
CONFIG_NF_CONNTRACK_PPTP=3Dm
CONFIG_NF_CONNTRACK_SANE=3Dm
CONFIG_NF_CONNTRACK_SIP=3Dm
CONFIG_NF_CONNTRACK_TFTP=3Dm
CONFIG_NF_CT_NETLINK=3Dm
CONFIG_NF_CT_NETLINK_TIMEOUT=3Dm
CONFIG_NF_CT_NETLINK_HELPER=3Dm
CONFIG_NETFILTER_NETLINK_QUEUE_CT=3Dy
CONFIG_NF_NAT=3Dm
CONFIG_NF_NAT_NEEDED=3Dy
CONFIG_NF_NAT_PROTO_DCCP=3Dm
CONFIG_NF_NAT_PROTO_UDPLITE=3Dm
CONFIG_NF_NAT_PROTO_SCTP=3Dm
CONFIG_NF_NAT_AMANDA=3Dm
CONFIG_NF_NAT_FTP=3Dm
CONFIG_NF_NAT_IRC=3Dm
CONFIG_NF_NAT_SIP=3Dm
CONFIG_NF_NAT_TFTP=3Dm
CONFIG_NF_NAT_REDIRECT=3Dm
CONFIG_NETFILTER_SYNPROXY=3Dm
CONFIG_NF_TABLES=3Dm
CONFIG_NF_TABLES_INET=3Dm
CONFIG_NFT_EXTHDR=3Dm
CONFIG_NFT_META=3Dm
CONFIG_NFT_CT=3Dm
CONFIG_NFT_RBTREE=3Dm
CONFIG_NFT_HASH=3Dm
CONFIG_NFT_COUNTER=3Dm
CONFIG_NFT_LOG=3Dm
CONFIG_NFT_LIMIT=3Dm
CONFIG_NFT_MASQ=3Dm
CONFIG_NFT_REDIR=3Dm
CONFIG_NFT_NAT=3Dm
CONFIG_NFT_QUEUE=3Dm
CONFIG_NFT_REJECT=3Dm
CONFIG_NFT_REJECT_INET=3Dm
CONFIG_NFT_COMPAT=3Dm
CONFIG_NETFILTER_XTABLES=3Dm

#
# Xtables combined modules
#
CONFIG_NETFILTER_XT_MARK=3Dm
CONFIG_NETFILTER_XT_CONNMARK=3Dm
# CONFIG_NETFILTER_XT_SET is not set

#
# Xtables targets
#
# CONFIG_NETFILTER_XT_TARGET_CHECKSUM is not set
CONFIG_NETFILTER_XT_TARGET_CLASSIFY=3Dm
CONFIG_NETFILTER_XT_TARGET_CONNMARK=3Dm
CONFIG_NETFILTER_XT_TARGET_CT=3Dm
# CONFIG_NETFILTER_XT_TARGET_DSCP is not set
CONFIG_NETFILTER_XT_TARGET_HL=3Dm
CONFIG_NETFILTER_XT_TARGET_HMARK=3Dm
CONFIG_NETFILTER_XT_TARGET_IDLETIMER=3Dm
CONFIG_NETFILTER_XT_TARGET_LOG=3Dm
CONFIG_NETFILTER_XT_TARGET_MARK=3Dm
CONFIG_NETFILTER_XT_NAT=3Dm
CONFIG_NETFILTER_XT_TARGET_NETMAP=3Dm
CONFIG_NETFILTER_XT_TARGET_NFLOG=3Dm
CONFIG_NETFILTER_XT_TARGET_NFQUEUE=3Dm
CONFIG_NETFILTER_XT_TARGET_NOTRACK=3Dm
CONFIG_NETFILTER_XT_TARGET_RATEEST=3Dm
CONFIG_NETFILTER_XT_TARGET_REDIRECT=3Dm
CONFIG_NETFILTER_XT_TARGET_TEE=3Dm
CONFIG_NETFILTER_XT_TARGET_TPROXY=3Dm
# CONFIG_NETFILTER_XT_TARGET_TRACE is not set
CONFIG_NETFILTER_XT_TARGET_TCPMSS=3Dm
# CONFIG_NETFILTER_XT_TARGET_TCPOPTSTRIP is not set

#
# Xtables matches
#
CONFIG_NETFILTER_XT_MATCH_ADDRTYPE=3Dm
CONFIG_NETFILTER_XT_MATCH_BPF=3Dm
CONFIG_NETFILTER_XT_MATCH_CGROUP=3Dm
CONFIG_NETFILTER_XT_MATCH_CLUSTER=3Dm
CONFIG_NETFILTER_XT_MATCH_COMMENT=3Dm
CONFIG_NETFILTER_XT_MATCH_CONNBYTES=3Dm
CONFIG_NETFILTER_XT_MATCH_CONNLABEL=3Dm
CONFIG_NETFILTER_XT_MATCH_CONNLIMIT=3Dm
CONFIG_NETFILTER_XT_MATCH_CONNMARK=3Dm
CONFIG_NETFILTER_XT_MATCH_CONNTRACK=3Dm
CONFIG_NETFILTER_XT_MATCH_CPU=3Dm
CONFIG_NETFILTER_XT_MATCH_DCCP=3Dm
CONFIG_NETFILTER_XT_MATCH_DEVGROUP=3Dm
CONFIG_NETFILTER_XT_MATCH_DSCP=3Dm
CONFIG_NETFILTER_XT_MATCH_ECN=3Dm
CONFIG_NETFILTER_XT_MATCH_ESP=3Dm
CONFIG_NETFILTER_XT_MATCH_HASHLIMIT=3Dm
CONFIG_NETFILTER_XT_MATCH_HELPER=3Dm
CONFIG_NETFILTER_XT_MATCH_HL=3Dm
CONFIG_NETFILTER_XT_MATCH_IPCOMP=3Dm
CONFIG_NETFILTER_XT_MATCH_IPRANGE=3Dm
CONFIG_NETFILTER_XT_MATCH_L2TP=3Dm
CONFIG_NETFILTER_XT_MATCH_LENGTH=3Dm
CONFIG_NETFILTER_XT_MATCH_LIMIT=3Dm
CONFIG_NETFILTER_XT_MATCH_MAC=3Dm
CONFIG_NETFILTER_XT_MATCH_MARK=3Dm
CONFIG_NETFILTER_XT_MATCH_MULTIPORT=3Dm
CONFIG_NETFILTER_XT_MATCH_NFACCT=3Dm
CONFIG_NETFILTER_XT_MATCH_OSF=3Dm
CONFIG_NETFILTER_XT_MATCH_OWNER=3Dm
CONFIG_NETFILTER_XT_MATCH_POLICY=3Dm
# CONFIG_NETFILTER_XT_MATCH_PHYSDEV is not set
CONFIG_NETFILTER_XT_MATCH_PKTTYPE=3Dm
CONFIG_NETFILTER_XT_MATCH_QUOTA=3Dm
CONFIG_NETFILTER_XT_MATCH_RATEEST=3Dm
CONFIG_NETFILTER_XT_MATCH_REALM=3Dm
CONFIG_NETFILTER_XT_MATCH_RECENT=3Dm
CONFIG_NETFILTER_XT_MATCH_SCTP=3Dm
CONFIG_NETFILTER_XT_MATCH_SOCKET=3Dm
CONFIG_NETFILTER_XT_MATCH_STATE=3Dm
CONFIG_NETFILTER_XT_MATCH_STATISTIC=3Dm
CONFIG_NETFILTER_XT_MATCH_STRING=3Dm
CONFIG_NETFILTER_XT_MATCH_TCPMSS=3Dm
CONFIG_NETFILTER_XT_MATCH_TIME=3Dm
CONFIG_NETFILTER_XT_MATCH_U32=3Dm
CONFIG_IP_SET=3Dm
CONFIG_IP_SET_MAX%6
CONFIG_IP_SET_BITMAP_IP=3Dm
CONFIG_IP_SET_BITMAP_IPMAC=3Dm
CONFIG_IP_SET_BITMAP_PORT=3Dm
CONFIG_IP_SET_HASH_IP=3Dm
CONFIG_IP_SET_HASH_IPMARK=3Dm
CONFIG_IP_SET_HASH_IPPORT=3Dm
CONFIG_IP_SET_HASH_IPPORTIP=3Dm
CONFIG_IP_SET_HASH_IPPORTNET=3Dm
CONFIG_IP_SET_HASH_MAC=3Dm
CONFIG_IP_SET_HASH_NETPORTNET=3Dm
CONFIG_IP_SET_HASH_NET=3Dm
CONFIG_IP_SET_HASH_NETNET=3Dm
CONFIG_IP_SET_HASH_NETPORT=3Dm
CONFIG_IP_SET_HASH_NETIFACE=3Dm
CONFIG_IP_SET_LIST_SET=3Dm
# CONFIG_IP_VS is not set

#
# IP: Netfilter Configuration
#
CONFIG_NF_DEFRAG_IPV4=3Dm
CONFIG_NF_CONNTRACK_IPV4=3Dm
CONFIG_NF_CONNTRACK_PROC_COMPAT=3Dy
CONFIG_NF_LOG_ARP=3Dm
CONFIG_NF_LOG_IPV4=3Dm
CONFIG_NF_TABLES_IPV4=3Dm
CONFIG_NFT_CHAIN_ROUTE_IPV4=3Dm
CONFIG_NF_REJECT_IPV4=3Dm
CONFIG_NFT_REJECT_IPV4=3Dm
CONFIG_NF_TABLES_ARP=3Dm
CONFIG_NF_NAT_IPV4=3Dm
CONFIG_NFT_CHAIN_NAT_IPV4=3Dm
CONFIG_NF_NAT_MASQUERADE_IPV4=3Dm
CONFIG_NFT_MASQ_IPV4=3Dm
CONFIG_NFT_REDIR_IPV4=3Dm
CONFIG_NF_NAT_SNMP_BASIC=3Dm
CONFIG_NF_NAT_PROTO_GRE=3Dm
CONFIG_NF_NAT_PPTP=3Dm
CONFIG_NF_NAT_H323=3Dm
CONFIG_IP_NF_IPTABLES=3Dm
CONFIG_IP_NF_MATCH_AH=3Dm
CONFIG_IP_NF_MATCH_ECN=3Dm
CONFIG_IP_NF_MATCH_RPFILTER=3Dm
CONFIG_IP_NF_MATCH_TTL=3Dm
CONFIG_IP_NF_FILTER=3Dm
CONFIG_IP_NF_TARGET_REJECT=3Dm
CONFIG_IP_NF_TARGET_SYNPROXY=3Dm
CONFIG_IP_NF_NAT=3Dm
CONFIG_IP_NF_TARGET_MASQUERADE=3Dm
CONFIG_IP_NF_TARGET_NETMAP=3Dm
CONFIG_IP_NF_TARGET_REDIRECT=3Dm
CONFIG_IP_NF_MANGLE=3Dm
CONFIG_IP_NF_TARGET_CLUSTERIP=3Dm
CONFIG_IP_NF_TARGET_ECN=3Dm
CONFIG_IP_NF_TARGET_TTL=3Dm
CONFIG_IP_NF_RAW=3Dm
# CONFIG_IP_NF_SECURITY is not set
CONFIG_IP_NF_ARPTABLES=3Dm
CONFIG_IP_NF_ARPFILTER=3Dm
CONFIG_IP_NF_ARP_MANGLE=3Dm

#
# IPv6: Netfilter Configuration
#
CONFIG_NF_DEFRAG_IPV6=3Dm
CONFIG_NF_CONNTRACK_IPV6=3Dm
CONFIG_NF_TABLES_IPV6=3Dm
CONFIG_NFT_CHAIN_ROUTE_IPV6=3Dm
CONFIG_NF_REJECT_IPV6=3Dm
CONFIG_NFT_REJECT_IPV6=3Dm
CONFIG_NF_LOG_IPV6=3Dm
CONFIG_NF_NAT_IPV6=3Dm
CONFIG_NFT_CHAIN_NAT_IPV6=3Dm
CONFIG_NF_NAT_MASQUERADE_IPV6=3Dm
CONFIG_NFT_MASQ_IPV6=3Dm
CONFIG_NFT_REDIR_IPV6=3Dm
CONFIG_IP6_NF_IPTABLES=3Dm
CONFIG_IP6_NF_MATCH_AH=3Dm
CONFIG_IP6_NF_MATCH_EUI64=3Dm
CONFIG_IP6_NF_MATCH_FRAG=3Dm
CONFIG_IP6_NF_MATCH_OPTS=3Dm
CONFIG_IP6_NF_MATCH_HL=3Dm
CONFIG_IP6_NF_MATCH_IPV6HEADER=3Dm
CONFIG_IP6_NF_MATCH_MH=3Dm
CONFIG_IP6_NF_MATCH_RPFILTER=3Dm
CONFIG_IP6_NF_MATCH_RT=3Dm
CONFIG_IP6_NF_TARGET_HL=3Dm
CONFIG_IP6_NF_FILTER=3Dm
CONFIG_IP6_NF_TARGET_REJECT=3Dm
CONFIG_IP6_NF_TARGET_SYNPROXY=3Dm
CONFIG_IP6_NF_MANGLE=3Dm
CONFIG_IP6_NF_RAW=3Dm
# CONFIG_IP6_NF_SECURITY is not set
CONFIG_IP6_NF_NAT=3Dm
CONFIG_IP6_NF_TARGET_MASQUERADE=3Dm
CONFIG_IP6_NF_TARGET_NPT=3Dm
CONFIG_NF_TABLES_BRIDGE=3Dm
CONFIG_NFT_BRIDGE_META=3Dm
CONFIG_NFT_BRIDGE_REJECT=3Dm
CONFIG_NF_LOG_BRIDGE=3Dm
# CONFIG_BRIDGE_NF_EBTABLES is not set
CONFIG_IP_DCCP=3Dm
CONFIG_INET_DCCP_DIAG=3Dm

#
# DCCP CCIDs Configuration
#
# CONFIG_IP_DCCP_CCID2_DEBUG is not set
CONFIG_IP_DCCP_CCID3=3Dy
# CONFIG_IP_DCCP_CCID3_DEBUG is not set
CONFIG_IP_DCCP_TFRC_LIB=3Dy

#
# DCCP Kernel Hacking
#
# CONFIG_IP_DCCP_DEBUG is not set
CONFIG_IP_SCTP=3Dm
# CONFIG_SCTP_DBG_OBJCNT is not set
# CONFIG_SCTP_DEFAULT_COOKIE_HMAC_MD5 is not set
CONFIG_SCTP_DEFAULT_COOKIE_HMAC_SHA1=3Dy
# CONFIG_SCTP_DEFAULT_COOKIE_HMAC_NONE is not set
# CONFIG_SCTP_COOKIE_HMAC_MD5 is not set
CONFIG_SCTP_COOKIE_HMAC_SHA1=3Dy
CONFIG_RDS=3Dm
CONFIG_RDS_TCP=3Dm
# CONFIG_RDS_DEBUG is not set
# CONFIG_TIPC is not set
CONFIG_ATM=3Dm
CONFIG_ATM_CLIP=3Dm
CONFIG_ATM_CLIP_NO_ICMP=3Dy
CONFIG_ATM_LANE=3Dm
CONFIG_ATM_MPOA=3Dm
CONFIG_ATM_BR2684=3Dm
CONFIG_ATM_BR2684_IPFILTER=3Dy
CONFIG_L2TP=3Dm
# CONFIG_L2TP_DEBUGFS is not set
# CONFIG_L2TP_V3 is not set
CONFIG_STP=3Dm
CONFIG_GARP=3Dm
CONFIG_MRP=3Dm
CONFIG_BRIDGE=3Dm
CONFIG_BRIDGE_IGMP_SNOOPING=3Dy
CONFIG_BRIDGE_VLAN_FILTERING=3Dy
CONFIG_HAVE_NET_DSA=3Dy
CONFIG_VLAN_8021Q=3Dm
CONFIG_VLAN_8021Q_GVRP=3Dy
CONFIG_VLAN_8021Q_MVRP=3Dy
# CONFIG_DECNET is not set
CONFIG_LLC=3Dm
CONFIG_LLC2=3Dm
# CONFIG_IPX is not set
# CONFIG_ATALK is not set
# CONFIG_X25 is not set
# CONFIG_LAPB is not set
# CONFIG_PHONET is not set
CONFIG_6LOWPAN=3Dm
# CONFIG_IEEE802154 is not set
CONFIG_NET_SCHED=3Dy

#
# Queueing/Scheduling
#
CONFIG_NET_SCH_CBQ=3Dm
CONFIG_NET_SCH_HTB=3Dm
CONFIG_NET_SCH_HFSC=3Dm
CONFIG_NET_SCH_ATM=3Dm
CONFIG_NET_SCH_PRIO=3Dm
CONFIG_NET_SCH_MULTIQ=3Dm
CONFIG_NET_SCH_RED=3Dm
CONFIG_NET_SCH_SFB=3Dm
CONFIG_NET_SCH_SFQ=3Dm
CONFIG_NET_SCH_TEQL=3Dm
CONFIG_NET_SCH_TBF=3Dm
CONFIG_NET_SCH_GRED=3Dm
CONFIG_NET_SCH_DSMARK=3Dm
CONFIG_NET_SCH_NETEM=3Dm
CONFIG_NET_SCH_DRR=3Dm
CONFIG_NET_SCH_MQPRIO=3Dm
CONFIG_NET_SCH_CHOKE=3Dm
CONFIG_NET_SCH_QFQ=3Dm
CONFIG_NET_SCH_CODEL=3Dm
CONFIG_NET_SCH_FQ_CODEL=3Dm
CONFIG_NET_SCH_FQ=3Dm
CONFIG_NET_SCH_HHF=3Dm
CONFIG_NET_SCH_PIE=3Dm
CONFIG_NET_SCH_INGRESS=3Dm
CONFIG_NET_SCH_PLUG=3Dm

#
# Classification
#
CONFIG_NET_CLS=3Dy
CONFIG_NET_CLS_BASIC=3Dm
CONFIG_NET_CLS_TCINDEX=3Dm
CONFIG_NET_CLS_ROUTE4=3Dm
CONFIG_NET_CLS_FW=3Dm
CONFIG_NET_CLS_U32=3Dm
CONFIG_CLS_U32_PERF=3Dy
CONFIG_CLS_U32_MARK=3Dy
CONFIG_NET_CLS_RSVP=3Dm
CONFIG_NET_CLS_RSVP6=3Dm
CONFIG_NET_CLS_FLOW=3Dm
CONFIG_NET_CLS_CGROUP=3Dm
CONFIG_NET_CLS_BPF=3Dm
CONFIG_NET_EMATCH=3Dy
CONFIG_NET_EMATCH_STACK2
CONFIG_NET_EMATCH_CMP=3Dm
CONFIG_NET_EMATCH_NBYTE=3Dm
CONFIG_NET_EMATCH_U32=3Dm
CONFIG_NET_EMATCH_META=3Dm
CONFIG_NET_EMATCH_TEXT=3Dm
CONFIG_NET_EMATCH_IPSET=3Dm
CONFIG_NET_CLS_ACT=3Dy
CONFIG_NET_ACT_POLICE=3Dm
CONFIG_NET_ACT_GACT=3Dm
CONFIG_GACT_PROB=3Dy
CONFIG_NET_ACT_MIRRED=3Dm
CONFIG_NET_ACT_IPT=3Dm
CONFIG_NET_ACT_NAT=3Dm
CONFIG_NET_ACT_PEDIT=3Dm
CONFIG_NET_ACT_SIMP=3Dm
CONFIG_NET_ACT_SKBEDIT=3Dm
CONFIG_NET_ACT_CSUM=3Dm
CONFIG_NET_ACT_VLAN=3Dm
CONFIG_NET_ACT_BPF=3Dm
CONFIG_NET_ACT_CONNMARK=3Dm
CONFIG_NET_CLS_IND=3Dy
CONFIG_NET_SCH_FIFO=3Dy
# CONFIG_DCB is not set
CONFIG_DNS_RESOLVER=3Dy
# CONFIG_BATMAN_ADV is not set
# CONFIG_OPENVSWITCH is not set
# CONFIG_VSOCKETS is not set
CONFIG_NETLINK_MMAP=3Dy
# CONFIG_NETLINK_DIAG is not set
# CONFIG_NET_MPLS_GSO is not set
# CONFIG_HSR is not set
# CONFIG_NET_SWITCHDEV is not set
CONFIG_RPS=3Dy
CONFIG_RFS_ACCEL=3Dy
CONFIG_XPS=3Dy
# CONFIG_CGROUP_NET_PRIO is not set
CONFIG_CGROUP_NET_CLASSID=3Dy
CONFIG_NET_RX_BUSY_POLL=3Dy
CONFIG_BQL=3Dy
CONFIG_BPF_JIT=3Dy
CONFIG_NET_FLOW_LIMIT=3Dy

#
# Network testing
#
CONFIG_NET_PKTGEN=3Dm
# CONFIG_HAMRADIO is not set
# CONFIG_CAN is not set
# CONFIG_IRDA is not set
# CONFIG_BT is not set
# CONFIG_AF_RXRPC is not set
CONFIG_FIB_RULES=3Dy
# CONFIG_WIRELESS is not set
# CONFIG_WIMAX is not set
# CONFIG_RFKILL is not set
# CONFIG_NET_9P is not set
# CONFIG_CAIF is not set
# CONFIG_CEPH_LIB is not set
# CONFIG_NFC is not set
CONFIG_HAVE_BPF_JIT=3Dy

#
# Device Drivers
#

#
# Generic Driver Options
#
CONFIG_UEVENT_HELPER=3Dy
CONFIG_UEVENT_HELPER_PATH=3D""
CONFIG_DEVTMPFS=3Dy
CONFIG_DEVTMPFS_MOUNT=3Dy
CONFIG_STANDALONE=3Dy
CONFIG_PREVENT_FIRMWARE_BUILD=3Dy
CONFIG_FW_LOADER=3Dy
CONFIG_FIRMWARE_IN_KERNEL=3Dy
CONFIG_EXTRA_FIRMWARE=3D""
# CONFIG_FW_LOADER_USER_HELPER_FALLBACK is not set
CONFIG_ALLOW_DEV_COREDUMP=3Dy
# CONFIG_DEBUG_DRIVER is not set
# CONFIG_DEBUG_DEVRES is not set
# CONFIG_SYS_HYPERVISOR is not set
# CONFIG_GENERIC_CPU_DEVICES is not set
# CONFIG_DMA_SHARED_BUFFER is not set

#
# Bus devices
#
CONFIG_CONNECTOR=3Dm
# CONFIG_MTD is not set
CONFIG_OF=3Dy

#
# Device Tree and Open Firmware support
#
CONFIG_OF_PROMTREE=3Dy
CONFIG_OF_NET=3Dy
CONFIG_OF_MDIO=3Dy
CONFIG_OF_PCI=3Dy
# CONFIG_OF_OVERLAY is not set
CONFIG_ARCH_MIGHT_HAVE_PC_PARPORT=3Dy
# CONFIG_PARPORT is not set
CONFIG_BLK_DEV=3Dy
# CONFIG_BLK_DEV_NULL_BLK is not set
# CONFIG_BLK_DEV_FD is not set
# CONFIG_BLK_DEV_PCIESSD_MTIP32XX is not set
# CONFIG_BLK_CPQ_CISS_DA is not set
CONFIG_BLK_DEV_DAC960=3Dm
# CONFIG_BLK_DEV_UMEM is not set
# CONFIG_BLK_DEV_COW_COMMON is not set
CONFIG_BLK_DEV_LOOP=3Dm
CONFIG_BLK_DEV_LOOP_MIN_COUNT=3D8
# CONFIG_BLK_DEV_CRYPTOLOOP is not set
# CONFIG_BLK_DEV_DRBD is not set
# CONFIG_BLK_DEV_NBD is not set
# CONFIG_BLK_DEV_NVME is not set
# CONFIG_BLK_DEV_SKD is not set
# CONFIG_BLK_DEV_SX8 is not set
# CONFIG_BLK_DEV_RAM is not set
# CONFIG_CDROM_PKTCDVD is not set
# CONFIG_ATA_OVER_ETH is not set
# CONFIG_BLK_DEV_HD is not set
# CONFIG_BLK_DEV_RBD is not set
# CONFIG_BLK_DEV_RSXX is not set

#
# Misc devices
#
# CONFIG_SENSORS_LIS3LV02D is not set
# CONFIG_AD525X_DPOT is not set
# CONFIG_DUMMY_IRQ is not set
# CONFIG_PHANTOM is not set
# CONFIG_SGI_IOC4 is not set
# CONFIG_TIFM_CORE is not set
# CONFIG_ICS932S401 is not set
CONFIG_ENCLOSURE_SERVICES=3Dm
# CONFIG_HP_ILO is not set
# CONFIG_APDS9802ALS is not set
# CONFIG_ISL29003 is not set
# CONFIG_ISL29020 is not set
# CONFIG_SENSORS_TSL2550 is not set
# CONFIG_SENSORS_BH1780 is not set
# CONFIG_SENSORS_BH1770 is not set
# CONFIG_SENSORS_APDS990X is not set
# CONFIG_HMC6352 is not set
# CONFIG_DS1682 is not set
# CONFIG_BMP085_I2C is not set
# CONFIG_USB_SWITCH_FSA9480 is not set
# CONFIG_SRAM is not set
# CONFIG_C2PORT is not set

#
# EEPROM support
#
# CONFIG_EEPROM_AT24 is not set
# CONFIG_EEPROM_LEGACY is not set
# CONFIG_EEPROM_MAX6875 is not set
# CONFIG_EEPROM_93CX6 is not set
# CONFIG_CB710_CORE is not set

#
# Texas Instruments shared transport line discipline
#
# CONFIG_SENSORS_LIS3_I2C is not set

#
# Altera FPGA firmware download module
#
# CONFIG_ALTERA_STAPL is not set

#
# Intel MIC Bus Driver
#

#
# Intel MIC Host Driver
#

#
# Intel MIC Card Driver
#
# CONFIG_GENWQE is not set
# CONFIG_ECHO is not set
# CONFIG_CXL_BASE is not set
CONFIG_HAVE_IDE=3Dy
# CONFIG_IDE is not set

#
# SCSI device support
#
CONFIG_SCSI_MOD=3Dy
# CONFIG_RAID_ATTRS is not set
CONFIG_SCSI=3Dy
CONFIG_SCSI_DMA=3Dy
CONFIG_SCSI_NETLINK=3Dy
CONFIG_SCSI_MQ_DEFAULT=3Dy
# CONFIG_SCSI_PROC_FS is not set

#
# SCSI support type (disk, tape, CD-ROM)
#
CONFIG_BLK_DEV_SD=3Dy
CONFIG_CHR_DEV_ST=3Dm
# CONFIG_CHR_DEV_OSST is not set
CONFIG_BLK_DEV_SR=3Dm
CONFIG_BLK_DEV_SR_VENDOR=3Dy
CONFIG_CHR_DEV_SG=3Dm
CONFIG_CHR_DEV_SCH=3Dm
CONFIG_SCSI_ENCLOSURE=3Dm
CONFIG_SCSI_CONSTANTS=3Dy
# CONFIG_SCSI_LOGGING is not set
CONFIG_SCSI_SCAN_ASYNC=3Dy

#
# SCSI Transports
#
CONFIG_SCSI_SPI_ATTRS=3Dy
CONFIG_SCSI_FC_ATTRS=3Dm
CONFIG_SCSI_ISCSI_ATTRS=3Dm
# CONFIG_SCSI_SAS_ATTRS is not set
# CONFIG_SCSI_SAS_LIBSAS is not set
# CONFIG_SCSI_SRP_ATTRS is not set
CONFIG_SCSI_LOWLEVEL=3Dy
CONFIG_ISCSI_TCP=3Dm
# CONFIG_ISCSI_BOOT_SYSFS is not set
# CONFIG_SCSI_CXGB3_ISCSI is not set
# CONFIG_SCSI_CXGB4_ISCSI is not set
# CONFIG_SCSI_BNX2_ISCSI is not set
# CONFIG_BE2ISCSI is not set
# CONFIG_BLK_DEV_3W_XXXX_RAID is not set
# CONFIG_SCSI_HPSA is not set
# CONFIG_SCSI_3W_9XXX is not set
# CONFIG_SCSI_3W_SAS is not set
# CONFIG_SCSI_ACARD is not set
# CONFIG_SCSI_AACRAID is not set
CONFIG_SCSI_AIC7XXX=3Dm
CONFIG_AIC7XXX_CMDS_PER_DEVICE2
CONFIG_AIC7XXX_RESET_DELAY_MSP00
CONFIG_AIC7XXX_DEBUG_ENABLE=3Dy
CONFIG_AIC7XXX_DEBUG_MASK=3D0
CONFIG_AIC7XXX_REG_PRETTY_PRINT=3Dy
CONFIG_SCSI_AIC79XX=3Dm
CONFIG_AIC79XX_CMDS_PER_DEVICE2
CONFIG_AIC79XX_RESET_DELAY_MSP00
CONFIG_AIC79XX_DEBUG_ENABLE=3Dy
CONFIG_AIC79XX_DEBUG_MASK=3D0
CONFIG_AIC79XX_REG_PRETTY_PRINT=3Dy
# CONFIG_SCSI_AIC94XX is not set
# CONFIG_SCSI_MVSAS is not set
# CONFIG_SCSI_MVUMI is not set
# CONFIG_SCSI_ARCMSR is not set
# CONFIG_SCSI_ESAS2R is not set
# CONFIG_MEGARAID_NEWGEN is not set
# CONFIG_MEGARAID_LEGACY is not set
# CONFIG_MEGARAID_SAS is not set
# CONFIG_SCSI_MPT2SAS is not set
# CONFIG_SCSI_MPT3SAS is not set
# CONFIG_SCSI_UFSHCD is not set
# CONFIG_SCSI_HPTIOP is not set
CONFIG_LIBFC=3Dm
# CONFIG_LIBFCOE is not set
# CONFIG_SCSI_DMX3191D is not set
# CONFIG_SCSI_FUTURE_DOMAIN is not set
# CONFIG_SCSI_IPS is not set
# CONFIG_SCSI_INITIO is not set
# CONFIG_SCSI_INIA100 is not set
# CONFIG_SCSI_STEX is not set
CONFIG_SCSI_SYM53C8XX_2=3Dy
CONFIG_SCSI_SYM53C8XX_DMA_ADDRESSING_MODE=3D1
CONFIG_SCSI_SYM53C8XX_DEFAULT_TAGS=16
CONFIG_SCSI_SYM53C8XX_MAX_TAGSd
CONFIG_SCSI_SYM53C8XX_MMIO=3Dy
CONFIG_SCSI_QLOGIC_1280=3Dm
# CONFIG_SCSI_QLOGICPTI is not set
CONFIG_SCSI_QLA_FC=3Dm
CONFIG_TCM_QLA2XXX=3Dm
# CONFIG_SCSI_QLA_ISCSI is not set
CONFIG_SCSI_LPFC=3Dm
# CONFIG_SCSI_LPFC_DEBUG_FS is not set
# CONFIG_SCSI_DC395x is not set
# CONFIG_SCSI_AM53C974 is not set
# CONFIG_SCSI_WD719X is not set
# CONFIG_SCSI_DEBUG is not set
# CONFIG_SCSI_SUNESP is not set
# CONFIG_SCSI_PMCRAID is not set
# CONFIG_SCSI_PM8001 is not set
# CONFIG_SCSI_BFA_FC is not set
# CONFIG_SCSI_CHELSIO_FCOE is not set
CONFIG_SCSI_DH=3Dm
CONFIG_SCSI_DH_RDAC=3Dm
CONFIG_SCSI_DH_HP_SW=3Dm
CONFIG_SCSI_DH_EMC=3Dm
CONFIG_SCSI_DH_ALUA=3Dm
# CONFIG_SCSI_OSD_INITIATOR is not set
# CONFIG_ATA is not set
CONFIG_MD=3Dy
CONFIG_BLK_DEV_MD=3Dm
CONFIG_MD_LINEAR=3Dm
CONFIG_MD_RAID0=3Dm
CONFIG_MD_RAID1=3Dm
CONFIG_MD_RAID10=3Dm
CONFIG_MD_RAID456=3Dm
CONFIG_MD_MULTIPATH=3Dm
CONFIG_MD_FAULTY=3Dm
# CONFIG_BCACHE is not set
CONFIG_BLK_DEV_DM_BUILTIN=3Dy
CONFIG_BLK_DEV_DM=3Dm
# CONFIG_DM_DEBUG is not set
CONFIG_DM_BUFIO=3Dm
CONFIG_DM_BIO_PRISON=3Dm
CONFIG_DM_PERSISTENT_DATA=3Dm
# CONFIG_DM_DEBUG_BLOCK_STACK_TRACING is not set
CONFIG_DM_CRYPT=3Dm
CONFIG_DM_SNAPSHOT=3Dm
CONFIG_DM_THIN_PROVISIONING=3Dm
# CONFIG_DM_CACHE is not set
CONFIG_DM_ERA=3Dm
CONFIG_DM_MIRROR=3Dm
CONFIG_DM_LOG_USERSPACE=3Dm
CONFIG_DM_RAID=3Dm
CONFIG_DM_ZERO=3Dm
CONFIG_DM_MULTIPATH=3Dm
CONFIG_DM_MULTIPATH_QL=3Dm
CONFIG_DM_MULTIPATH_ST=3Dm
CONFIG_DM_DELAY=3Dm
CONFIG_DM_UEVENT=3Dy
CONFIG_DM_FLAKEY=3Dm
CONFIG_DM_VERITY=3Dm
# CONFIG_DM_SWITCH is not set
CONFIG_TARGET_CORE=3Dm
CONFIG_TCM_IBLOCK=3Dm
CONFIG_TCM_FILEIO=3Dm
CONFIG_TCM_PSCSI=3Dm
CONFIG_LOOPBACK_TARGET=3Dm
# CONFIG_TCM_FC is not set
CONFIG_ISCSI_TARGET=3Dm
# CONFIG_SBP_TARGET is not set
# CONFIG_FUSION is not set

#
# IEEE 1394 (FireWire) support
#
CONFIG_FIREWIRE=3Dm
CONFIG_FIREWIRE_OHCI=3Dm
CONFIG_FIREWIRE_SBP2=3Dm
CONFIG_FIREWIRE_NET=3Dm
CONFIG_FIREWIRE_NOSY=3Dm
CONFIG_NETDEVICES=3Dy
CONFIG_NET_CORE=3Dy
# CONFIG_BONDING is not set
# CONFIG_DUMMY is not set
# CONFIG_EQUALIZER is not set
# CONFIG_NET_FC is not set
# CONFIG_IFB is not set
# CONFIG_NET_TEAM is not set
# CONFIG_MACVLAN is not set
# CONFIG_IPVLAN is not set
# CONFIG_VXLAN is not set
# CONFIG_NETCONSOLE is not set
# CONFIG_NETPOLL is not set
# CONFIG_NET_POLL_CONTROLLER is not set
# CONFIG_TUN is not set
# CONFIG_VETH is not set
CONFIG_NLMON=3Dm
CONFIG_SUNGEM_PHY=3Dm
# CONFIG_ARCNET is not set
CONFIG_ATM_DRIVERS=3Dy
# CONFIG_ATM_DUMMY is not set
# CONFIG_ATM_TCP is not set
# CONFIG_ATM_LANAI is not set
# CONFIG_ATM_ENI is not set
# CONFIG_ATM_NICSTAR is not set
# CONFIG_ATM_IDT77252 is not set
# CONFIG_ATM_IA is not set
# CONFIG_ATM_FORE200E is not set
# CONFIG_ATM_HE is not set
# CONFIG_ATM_SOLOS is not set

#
# CAIF transport drivers
#

#
# Distributed Switch Architecture drivers
#
# CONFIG_NET_DSA_MV88E6XXX is not set
# CONFIG_NET_DSA_MV88E6060 is not set
# CONFIG_NET_DSA_MV88E6XXX_NEED_PPU is not set
# CONFIG_NET_DSA_MV88E6131 is not set
# CONFIG_NET_DSA_MV88E6123_61_65 is not set
# CONFIG_NET_DSA_MV88E6171 is not set
# CONFIG_NET_DSA_MV88E6352 is not set
# CONFIG_NET_DSA_BCM_SF2 is not set
CONFIG_ETHERNET=3Dy
# CONFIG_NET_VENDOR_3COM is not set
# CONFIG_NET_VENDOR_ADAPTEC is not set
# CONFIG_GRETH is not set
# CONFIG_NET_VENDOR_AGERE is not set
# CONFIG_NET_VENDOR_ALTEON is not set
# CONFIG_ALTERA_TSE is not set
# CONFIG_NET_VENDOR_AMD is not set
# CONFIG_NET_XGENE is not set
# CONFIG_NET_VENDOR_ARC is not set
# CONFIG_NET_VENDOR_ATHEROS is not set
CONFIG_NET_VENDOR_BROADCOM=3Dy
# CONFIG_B44 is not set
# CONFIG_BCMGENET is not set
# CONFIG_BNX2 is not set
# CONFIG_CNIC is not set
CONFIG_TIGON3=3Dm
# CONFIG_BNX2X is not set
# CONFIG_SYSTEMPORT is not set
# CONFIG_NET_VENDOR_BROCADE is not set
# CONFIG_NET_VENDOR_CHELSIO is not set
# CONFIG_NET_VENDOR_CISCO is not set
# CONFIG_DNET is not set
# CONFIG_NET_VENDOR_DEC is not set
# CONFIG_NET_VENDOR_DLINK is not set
# CONFIG_NET_VENDOR_EMULEX is not set
# CONFIG_NET_VENDOR_EXAR is not set
# CONFIG_NET_VENDOR_HP is not set
# CONFIG_NET_VENDOR_INTEL is not set
# CONFIG_IP1000 is not set
# CONFIG_JME is not set
CONFIG_NET_VENDOR_MARVELL=3Dy
# CONFIG_MVMDIO is not set
CONFIG_SKGE=3Dm
# CONFIG_SKGE_DEBUG is not set
CONFIG_SKGE_GENESIS=3Dy
CONFIG_SKY2=3Dm
# CONFIG_SKY2_DEBUG is not set
# CONFIG_NET_VENDOR_MELLANOX is not set
# CONFIG_NET_VENDOR_MICREL is not set
# CONFIG_NET_VENDOR_MYRI is not set
# CONFIG_FEALNX is not set
# CONFIG_NET_VENDOR_NATSEMI is not set
# CONFIG_NET_VENDOR_NVIDIA is not set
# CONFIG_NET_VENDOR_OKI is not set
# CONFIG_ETHOC is not set
# CONFIG_NET_PACKET_ENGINE is not set
# CONFIG_NET_VENDOR_QLOGIC is not set
# CONFIG_NET_VENDOR_QUALCOMM is not set
# CONFIG_NET_VENDOR_REALTEK is not set
# CONFIG_NET_VENDOR_RDC is not set
# CONFIG_NET_VENDOR_ROCKER is not set
# CONFIG_NET_VENDOR_SAMSUNG is not set
# CONFIG_NET_VENDOR_SEEQ is not set
# CONFIG_NET_VENDOR_SILAN is not set
# CONFIG_NET_VENDOR_SIS is not set
# CONFIG_SFC is not set
# CONFIG_NET_VENDOR_SMSC is not set
# CONFIG_NET_VENDOR_STMICRO is not set
CONFIG_NET_VENDOR_SUN=3Dy
CONFIG_HAPPYMEAL=3Dm
CONFIG_SUNBMAC=3Dm
# CONFIG_SUNQE is not set
CONFIG_SUNGEM=3Dm
CONFIG_CASSINI=3Dm
# CONFIG_NIU is not set
# CONFIG_NET_VENDOR_TEHUTI is not set
# CONFIG_NET_VENDOR_TI is not set
# CONFIG_NET_VENDOR_VIA is not set
# CONFIG_NET_VENDOR_WIZNET is not set
# CONFIG_FDDI is not set
# CONFIG_HIPPI is not set
CONFIG_PHYLIB=3Dy

#
# MII PHY device drivers
#
# CONFIG_AT803X_PHY is not set
# CONFIG_AMD_PHY is not set
# CONFIG_AMD_XGBE_PHY is not set
# CONFIG_MARVELL_PHY is not set
# CONFIG_DAVICOM_PHY is not set
# CONFIG_QSEMI_PHY is not set
# CONFIG_LXT_PHY is not set
# CONFIG_CICADA_PHY is not set
# CONFIG_VITESSE_PHY is not set
# CONFIG_SMSC_PHY is not set
# CONFIG_BROADCOM_PHY is not set
# CONFIG_BCM7XXX_PHY is not set
# CONFIG_BCM87XX_PHY is not set
# CONFIG_ICPLUS_PHY is not set
# CONFIG_REALTEK_PHY is not set
# CONFIG_NATIONAL_PHY is not set
# CONFIG_STE10XP is not set
# CONFIG_LSI_ET1011C_PHY is not set
# CONFIG_MICREL_PHY is not set
# CONFIG_FIXED_PHY is not set
# CONFIG_MDIO_BITBANG is not set
# CONFIG_MDIO_BUS_MUX_MMIOREG is not set
# CONFIG_MDIO_BCM_UNIMAC is not set
# CONFIG_PPP is not set
# CONFIG_SLIP is not set

#
# Host-side USB support is needed for USB Network Adapter support
#
# CONFIG_USB_NET_DRIVERS is not set
# CONFIG_WLAN is not set

#
# Enable WiMAX (Networking options) to see the WiMAX drivers
#
# CONFIG_WAN is not set
# CONFIG_VMXNET3 is not set
# CONFIG_ISDN is not set

#
# Input device support
#
CONFIG_INPUT=3Dy
# CONFIG_INPUT_FF_MEMLESS is not set
# CONFIG_INPUT_POLLDEV is not set
# CONFIG_INPUT_SPARSEKMAP is not set
# CONFIG_INPUT_MATRIXKMAP is not set

#
# Userland interfaces
#
CONFIG_INPUT_MOUSEDEV=3Dy
# CONFIG_INPUT_MOUSEDEV_PSAUX is not set
CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
CONFIG_INPUT_MOUSEDEV_SCREEN_Yv8
# CONFIG_INPUT_JOYDEV is not set
# CONFIG_INPUT_EVDEV is not set
# CONFIG_INPUT_EVBUG is not set

#
# Input Device Drivers
#
# CONFIG_INPUT_KEYBOARD is not set
# CONFIG_INPUT_MOUSE is not set
# CONFIG_INPUT_JOYSTICK is not set
# CONFIG_INPUT_TABLET is not set
# CONFIG_INPUT_TOUCHSCREEN is not set
CONFIG_INPUT_MISC=3Dy
# CONFIG_INPUT_AD714X is not set
# CONFIG_INPUT_BMA150 is not set
# CONFIG_INPUT_E3X0_BUTTON is not set
CONFIG_INPUT_SPARCSPKR=3Dy
# CONFIG_INPUT_MMA8450 is not set
# CONFIG_INPUT_MPU3050 is not set
# CONFIG_INPUT_ATI_REMOTE2 is not set
# CONFIG_INPUT_KEYSPAN_REMOTE is not set
# CONFIG_INPUT_KXTJ9 is not set
# CONFIG_INPUT_POWERMATE is not set
# CONFIG_INPUT_YEALINK is not set
# CONFIG_INPUT_CM109 is not set
# CONFIG_INPUT_UINPUT is not set
# CONFIG_INPUT_PCF8574 is not set
# CONFIG_INPUT_ADXL34X is not set
# CONFIG_INPUT_CMA3000 is not set
# CONFIG_INPUT_DRV2667_HAPTICS is not set

#
# Hardware I/O ports
#
# CONFIG_SERIO is not set
CONFIG_ARCH_MIGHT_HAVE_PC_SERIO=3Dy
# CONFIG_GAMEPORT is not set

#
# Character devices
#
CONFIG_TTY=3Dy
CONFIG_VT=3Dy
CONFIG_CONSOLE_TRANSLATIONS=3Dy
CONFIG_VT_CONSOLE=3Dy
CONFIG_VT_CONSOLE_SLEEP=3Dy
CONFIG_HW_CONSOLE=3Dy
# CONFIG_VT_HW_CONSOLE_BINDING is not set
CONFIG_UNIX98_PTYS=3Dy
CONFIG_DEVPTS_MULTIPLE_INSTANCES=3Dy
# CONFIG_LEGACY_PTYS is not set
# CONFIG_SERIAL_NONSTANDARD is not set
# CONFIG_NOZOMI is not set
# CONFIG_N_GSM is not set
# CONFIG_TRACE_SINK is not set
# CONFIG_DEVMEM is not set
# CONFIG_DEVKMEM is not set

#
# Serial drivers
#
# CONFIG_SERIAL_8250 is not set

#
# Non-8250 serial port support
#
# CONFIG_SERIAL_MFD_HSU is not set
CONFIG_SERIAL_SUNCORE=3Dy
CONFIG_SERIAL_SUNZILOG=3Dy
CONFIG_SERIAL_SUNZILOG_CONSOLE=3Dy
CONFIG_SERIAL_SUNSU=3Dy
CONFIG_SERIAL_SUNSU_CONSOLE=3Dy
CONFIG_SERIAL_SUNSAB=3Dy
CONFIG_SERIAL_SUNSAB_CONSOLE=3Dy
# CONFIG_SERIAL_SUNHV is not set
CONFIG_SERIAL_CORE=3Dy
CONFIG_SERIAL_CORE_CONSOLE=3Dy
# CONFIG_SERIAL_JSM is not set
# CONFIG_SERIAL_SCCNXP is not set
# CONFIG_SERIAL_SC16IS7XX is not set
# CONFIG_SERIAL_GRLIB_GAISLER_APBUART is not set
# CONFIG_SERIAL_ALTERA_JTAGUART is not set
# CONFIG_SERIAL_ALTERA_UART is not set
# CONFIG_SERIAL_XILINX_PS_UART is not set
# CONFIG_SERIAL_ARC is not set
# CONFIG_SERIAL_RP2 is not set
# CONFIG_SERIAL_FSL_LPUART is not set
# CONFIG_SERIAL_CONEXANT_DIGICOLOR is not set
# CONFIG_IPMI_HANDLER is not set
# CONFIG_HW_RANDOM is not set
# CONFIG_R3964 is not set
# CONFIG_APPLICOM is not set
# CONFIG_RAW_DRIVER is not set
# CONFIG_TCG_TPM is not set
CONFIG_DEVPORT=3Dy
# CONFIG_XILLYBUS is not set

#
# I2C support
#
CONFIG_I2C=3Dm
CONFIG_I2C_BOARDINFO=3Dy
CONFIG_I2C_COMPAT=3Dy
CONFIG_I2C_CHARDEV=3Dm
CONFIG_I2C_MUX=3Dm

#
# Multiplexer I2C Chip support
#
CONFIG_I2C_MUX_PCA9541=3Dm
CONFIG_I2C_HELPER_AUTO=3Dy

#
# I2C Hardware Bus support
#

#
# PC SMBus host controller drivers
#
CONFIG_I2C_ALI1535=3Dm
CONFIG_I2C_ALI1563=3Dm
CONFIG_I2C_ALI15X3=3Dm
CONFIG_I2C_AMD756=3Dm
CONFIG_I2C_AMD8111=3Dm
# CONFIG_I2C_I801 is not set
# CONFIG_I2C_ISCH is not set
# CONFIG_I2C_PIIX4 is not set
# CONFIG_I2C_NFORCE2 is not set
# CONFIG_I2C_SIS5595 is not set
# CONFIG_I2C_SIS630 is not set
# CONFIG_I2C_SIS96X is not set
# CONFIG_I2C_VIA is not set
# CONFIG_I2C_VIAPRO is not set

#
# I2C system bus drivers (mostly embedded / system-on-chip)
#
# CONFIG_I2C_DESIGNWARE_PLATFORM is not set
# CONFIG_I2C_DESIGNWARE_PCI is not set
# CONFIG_I2C_OCORES is not set
# CONFIG_I2C_PCA_PLATFORM is not set
# CONFIG_I2C_PXA_PCI is not set
# CONFIG_I2C_SIMTEC is not set
# CONFIG_I2C_XILINX is not set

#
# External I2C/SMBus adapter drivers
#
# CONFIG_I2C_DIOLAN_U2C is not set
# CONFIG_I2C_PARPORT_LIGHT is not set
# CONFIG_I2C_ROBOTFUZZ_OSIF is not set
# CONFIG_I2C_TAOS_EVM is not set
# CONFIG_I2C_TINY_USB is not set

#
# Other I2C/SMBus bus drivers
#
# CONFIG_I2C_STUB is not set
# CONFIG_I2C_SLAVE is not set
# CONFIG_I2C_DEBUG_CORE is not set
# CONFIG_I2C_DEBUG_ALGO is not set
# CONFIG_I2C_DEBUG_BUS is not set
# CONFIG_SPI is not set
# CONFIG_SPMI is not set
# CONFIG_HSI is not set

#
# PPS support
#
CONFIG_PPS=3Dm
# CONFIG_PPS_DEBUG is not set

#
# PPS clients support
#
# CONFIG_PPS_CLIENT_KTIMER is not set
# CONFIG_PPS_CLIENT_LDISC is not set
# CONFIG_PPS_CLIENT_GPIO is not set

#
# PPS generators support
#

#
# PTP clock support
#
CONFIG_PTP_1588_CLOCK=3Dm

#
# Enable PHYLIB and NETWORK_PHY_TIMESTAMPING to see the additional clocks.
#
CONFIG_ARCH_WANT_OPTIONAL_GPIOLIB=3Dy
# CONFIG_GPIOLIB is not set
# CONFIG_W1 is not set
CONFIG_POWER_SUPPLY=3Dy
# CONFIG_POWER_SUPPLY_DEBUG is not set
# CONFIG_PDA_POWER is not set
# CONFIG_TEST_POWER is not set
# CONFIG_BATTERY_DS2780 is not set
# CONFIG_BATTERY_DS2781 is not set
# CONFIG_BATTERY_DS2782 is not set
# CONFIG_BATTERY_SBS is not set
# CONFIG_BATTERY_BQ27x00 is not set
# CONFIG_BATTERY_MAX17040 is not set
# CONFIG_BATTERY_MAX17042 is not set
# CONFIG_CHARGER_MAX8903 is not set
# CONFIG_CHARGER_LP8727 is not set
# CONFIG_CHARGER_BQ2415X is not set
# CONFIG_CHARGER_SMB347 is not set
# CONFIG_BATTERY_GAUGE_LTC2941 is not set
# CONFIG_POWER_RESET is not set
# CONFIG_POWER_AVS is not set
CONFIG_HWMON=3Dm
# CONFIG_HWMON_VID is not set
# CONFIG_HWMON_DEBUG_CHIP is not set

#
# Native drivers
#
# CONFIG_SENSORS_AD7414 is not set
# CONFIG_SENSORS_AD7418 is not set
# CONFIG_SENSORS_ADM1021 is not set
# CONFIG_SENSORS_ADM1025 is not set
# CONFIG_SENSORS_ADM1026 is not set
# CONFIG_SENSORS_ADM1029 is not set
# CONFIG_SENSORS_ADM1031 is not set
# CONFIG_SENSORS_ADM9240 is not set
# CONFIG_SENSORS_ADT7410 is not set
# CONFIG_SENSORS_ADT7411 is not set
# CONFIG_SENSORS_ADT7462 is not set
# CONFIG_SENSORS_ADT7470 is not set
# CONFIG_SENSORS_ADT7475 is not set
# CONFIG_SENSORS_ASC7621 is not set
# CONFIG_SENSORS_ATXP1 is not set
# CONFIG_SENSORS_DS620 is not set
# CONFIG_SENSORS_DS1621 is not set
# CONFIG_SENSORS_I5K_AMB is not set
# CONFIG_SENSORS_F71805F is not set
# CONFIG_SENSORS_F71882FG is not set
# CONFIG_SENSORS_F75375S is not set
# CONFIG_SENSORS_GL518SM is not set
# CONFIG_SENSORS_GL520SM is not set
# CONFIG_SENSORS_G760A is not set
# CONFIG_SENSORS_G762 is not set
# CONFIG_SENSORS_HIH6130 is not set
# CONFIG_SENSORS_IT87 is not set
# CONFIG_SENSORS_JC42 is not set
# CONFIG_SENSORS_POWR1220 is not set
# CONFIG_SENSORS_LINEAGE is not set
# CONFIG_SENSORS_LTC2945 is not set
# CONFIG_SENSORS_LTC4151 is not set
# CONFIG_SENSORS_LTC4215 is not set
# CONFIG_SENSORS_LTC4222 is not set
# CONFIG_SENSORS_LTC4245 is not set
# CONFIG_SENSORS_LTC4260 is not set
# CONFIG_SENSORS_LTC4261 is not set
# CONFIG_SENSORS_MAX16065 is not set
# CONFIG_SENSORS_MAX1619 is not set
# CONFIG_SENSORS_MAX1668 is not set
# CONFIG_SENSORS_MAX197 is not set
# CONFIG_SENSORS_MAX6639 is not set
# CONFIG_SENSORS_MAX6642 is not set
# CONFIG_SENSORS_MAX6650 is not set
# CONFIG_SENSORS_MAX6697 is not set
# CONFIG_SENSORS_HTU21 is not set
# CONFIG_SENSORS_MCP3021 is not set
# CONFIG_SENSORS_LM63 is not set
# CONFIG_SENSORS_LM73 is not set
# CONFIG_SENSORS_LM75 is not set
# CONFIG_SENSORS_LM77 is not set
# CONFIG_SENSORS_LM78 is not set
# CONFIG_SENSORS_LM80 is not set
# CONFIG_SENSORS_LM83 is not set
# CONFIG_SENSORS_LM85 is not set
# CONFIG_SENSORS_LM87 is not set
# CONFIG_SENSORS_LM90 is not set
# CONFIG_SENSORS_LM92 is not set
# CONFIG_SENSORS_LM93 is not set
# CONFIG_SENSORS_LM95234 is not set
# CONFIG_SENSORS_LM95241 is not set
# CONFIG_SENSORS_LM95245 is not set
# CONFIG_SENSORS_PC87360 is not set
# CONFIG_SENSORS_PC87427 is not set
# CONFIG_SENSORS_NTC_THERMISTOR is not set
# CONFIG_SENSORS_NCT6683 is not set
# CONFIG_SENSORS_NCT6775 is not set
# CONFIG_SENSORS_NCT7802 is not set
# CONFIG_SENSORS_PCF8591 is not set
# CONFIG_PMBUS is not set
# CONFIG_SENSORS_SHT21 is not set
# CONFIG_SENSORS_SHTC1 is not set
# CONFIG_SENSORS_SIS5595 is not set
# CONFIG_SENSORS_DME1737 is not set
# CONFIG_SENSORS_EMC1403 is not set
# CONFIG_SENSORS_EMC2103 is not set
# CONFIG_SENSORS_EMC6W201 is not set
# CONFIG_SENSORS_SMSC47M1 is not set
# CONFIG_SENSORS_SMSC47M192 is not set
# CONFIG_SENSORS_SMSC47B397 is not set
# CONFIG_SENSORS_SCH56XX_COMMON is not set
# CONFIG_SENSORS_SCH5627 is not set
# CONFIG_SENSORS_SCH5636 is not set
# CONFIG_SENSORS_SMM665 is not set
# CONFIG_SENSORS_ADC128D818 is not set
# CONFIG_SENSORS_ADS1015 is not set
# CONFIG_SENSORS_ADS7828 is not set
# CONFIG_SENSORS_AMC6821 is not set
# CONFIG_SENSORS_INA209 is not set
# CONFIG_SENSORS_INA2XX is not set
# CONFIG_SENSORS_THMC50 is not set
# CONFIG_SENSORS_TMP102 is not set
# CONFIG_SENSORS_TMP103 is not set
# CONFIG_SENSORS_TMP401 is not set
# CONFIG_SENSORS_TMP421 is not set
# CONFIG_SENSORS_VIA686A is not set
# CONFIG_SENSORS_VT1211 is not set
# CONFIG_SENSORS_VT8231 is not set
# CONFIG_SENSORS_W83781D is not set
# CONFIG_SENSORS_W83791D is not set
# CONFIG_SENSORS_W83792D is not set
# CONFIG_SENSORS_W83793 is not set
# CONFIG_SENSORS_W83795 is not set
# CONFIG_SENSORS_W83L785TS is not set
# CONFIG_SENSORS_W83L786NG is not set
# CONFIG_SENSORS_W83627HF is not set
# CONFIG_SENSORS_W83627EHF is not set
# CONFIG_SENSORS_ULTRA45 is not set
# CONFIG_THERMAL is not set
CONFIG_WATCHDOG=3Dy
CONFIG_WATCHDOG_CORE=3Dy
# CONFIG_WATCHDOG_NOWAYOUT is not set

#
# Watchdog Device Drivers
#
CONFIG_SOFT_WATCHDOG=3Dm
# CONFIG_XILINX_WATCHDOG is not set
# CONFIG_DW_WATCHDOG is not set
CONFIG_ALIM7101_WDT=3Dm
# CONFIG_I6300ESB_WDT is not set
# CONFIG_WATCHDOG_CP1XXX is not set
# CONFIG_WATCHDOG_RIO is not set

#
# PCI-based Watchdog Cards
#
# CONFIG_PCIPCWATCHDOG is not set
# CONFIG_WDTPCI is not set

#
# USB-based Watchdog Cards
#
# CONFIG_USBPCWATCHDOG is not set
CONFIG_SSB_POSSIBLE=3Dy

#
# Sonics Silicon Backplane
#
# CONFIG_SSB is not set
CONFIG_BCMA_POSSIBLE=3Dy

#
# Broadcom specific AMBA
#
# CONFIG_BCMA is not set

#
# Multifunction device drivers
#
# CONFIG_MFD_CORE is not set
# CONFIG_MFD_ATMEL_HLCDC is not set
# CONFIG_MFD_BCM590XX is not set
# CONFIG_MFD_CROS_EC is not set
# CONFIG_MFD_DLN2 is not set
# CONFIG_MFD_MC13XXX_I2C is not set
# CONFIG_MFD_HI6421_PMIC is not set
# CONFIG_HTC_PASIC3 is not set
# CONFIG_LPC_ICH is not set
# CONFIG_LPC_SCH is not set
# CONFIG_MFD_JANZ_CMODIO is not set
# CONFIG_MFD_KEMPLD is not set
# CONFIG_MFD_MENF21BMC is not set
# CONFIG_MFD_VIPERBOARD is not set
# CONFIG_MFD_RETU is not set
# CONFIG_MFD_PCF50633 is not set
# CONFIG_MFD_RDC321X is not set
# CONFIG_MFD_RTSX_PCI is not set
# CONFIG_MFD_RTSX_USB is not set
# CONFIG_MFD_RK808 is not set
# CONFIG_MFD_RN5T618 is not set
# CONFIG_MFD_SI476X_CORE is not set
# CONFIG_MFD_SM501 is not set
# CONFIG_ABX500_CORE is not set
# CONFIG_MFD_SYSCON is not set
# CONFIG_MFD_TI_AM335X_TSCADC is not set
# CONFIG_MFD_LP3943 is not set
# CONFIG_TPS6105X is not set
# CONFIG_TPS6507X is not set
# CONFIG_MFD_TPS65217 is not set
# CONFIG_MFD_TPS65218 is not set
# CONFIG_MFD_WL1273_CORE is not set
# CONFIG_MFD_LM3533 is not set
# CONFIG_MFD_TMIO is not set
# CONFIG_MFD_VX855 is not set
# CONFIG_MFD_ARIZONA_I2C is not set
# CONFIG_MFD_WM8994 is not set
# CONFIG_REGULATOR is not set
# CONFIG_MEDIA_SUPPORT is not set

#
# Graphics support
#
CONFIG_VGA_ARB=3Dy
CONFIG_VGA_ARB_MAX_GPUS=16

#
# Direct Rendering Manager
#
# CONFIG_DRM is not set

#
# Frame buffer Devices
#
# CONFIG_FB is not set
# CONFIG_BACKLIGHT_LCD_SUPPORT is not set
# CONFIG_VGASTATE is not set

#
# Console display driver support
#
CONFIG_DUMMY_CONSOLE=3Dy
CONFIG_DUMMY_CONSOLE_COLUMNS=80
CONFIG_DUMMY_CONSOLE_ROWS%
# CONFIG_SOUND is not set

#
# HID support
#
CONFIG_HID=3Dm
CONFIG_HID_BATTERY_STRENGTH=3Dy
CONFIG_HIDRAW=3Dy
CONFIG_UHID=3Dm
CONFIG_HID_GENERIC=3Dm

#
# Special HID drivers
#
CONFIG_HID_A4TECH=3Dm
# CONFIG_HID_ACRUX is not set
CONFIG_HID_APPLE=3Dm
# CONFIG_HID_APPLEIR is not set
# CONFIG_HID_AUREAL is not set
CONFIG_HID_BELKIN=3Dm
# CONFIG_HID_BETOP_FF is not set
CONFIG_HID_CHERRY=3Dm
CONFIG_HID_CHICONY=3Dm
CONFIG_HID_CYPRESS=3Dm
# CONFIG_HID_DRAGONRISE is not set
# CONFIG_HID_EMS_FF is not set
# CONFIG_HID_ELECOM is not set
# CONFIG_HID_ELO is not set
CONFIG_HID_EZKEY=3Dm
# CONFIG_HID_HOLTEK is not set
# CONFIG_HID_HUION is not set
# CONFIG_HID_KEYTOUCH is not set
# CONFIG_HID_KYE is not set
# CONFIG_HID_UCLOGIC is not set
# CONFIG_HID_WALTOP is not set
# CONFIG_HID_GYRATION is not set
# CONFIG_HID_ICADE is not set
# CONFIG_HID_TWINHAN is not set
CONFIG_HID_KENSINGTON=3Dm
# CONFIG_HID_LCPOWER is not set
# CONFIG_HID_LENOVO is not set
CONFIG_HID_LOGITECH=3Dm
# CONFIG_HID_LOGITECH_DJ is not set
# CONFIG_HID_LOGITECH_HIDPP is not set
# CONFIG_LOGITECH_FF is not set
# CONFIG_LOGIRUMBLEPAD2_FF is not set
# CONFIG_LOGIG940_FF is not set
# CONFIG_LOGIWHEELS_FF is not set
# CONFIG_HID_MAGICMOUSE is not set
CONFIG_HID_MICROSOFT=3Dm
CONFIG_HID_MONTEREY=3Dm
# CONFIG_HID_MULTITOUCH is not set
# CONFIG_HID_NTRIG is not set
# CONFIG_HID_ORTEK is not set
# CONFIG_HID_PANTHERLORD is not set
# CONFIG_HID_PENMOUNT is not set
# CONFIG_HID_PETALYNX is not set
# CONFIG_HID_PICOLCD is not set
# CONFIG_HID_PLANTRONICS is not set
# CONFIG_HID_PRIMAX is not set
# CONFIG_HID_ROCCAT is not set
# CONFIG_HID_SAITEK is not set
# CONFIG_HID_SAMSUNG is not set
# CONFIG_HID_SPEEDLINK is not set
# CONFIG_HID_STEELSERIES is not set
# CONFIG_HID_SUNPLUS is not set
# CONFIG_HID_RMI is not set
# CONFIG_HID_GREENASIA is not set
# CONFIG_HID_SMARTJOYPLUS is not set
# CONFIG_HID_TIVO is not set
# CONFIG_HID_TOPSEED is not set
# CONFIG_HID_THRUSTMASTER is not set
# CONFIG_HID_WACOM is not set
# CONFIG_HID_XINMO is not set
# CONFIG_HID_ZEROPLUS is not set
# CONFIG_HID_ZYDACRON is not set
# CONFIG_HID_SENSOR_HUB is not set

#
# USB HID support
#
CONFIG_USB_HID=3Dm
# CONFIG_HID_PID is not set
CONFIG_USB_HIDDEV=3Dy

#
# I2C HID support
#
# CONFIG_I2C_HID is not set
CONFIG_USB_OHCI_LITTLE_ENDIAN=3Dy
CONFIG_USB_SUPPORT=3Dy
CONFIG_USB_COMMON=3Dm
CONFIG_USB_ARCH_HAS_HCD=3Dy
CONFIG_USB=3Dm
CONFIG_USB_ANNOUNCE_NEW_DEVICES=3Dy

#
# Miscellaneous USB options
#
CONFIG_USB_DEFAULT_PERSIST=3Dy
CONFIG_USB_DYNAMIC_MINORS=3Dy
# CONFIG_USB_OTG is not set
# CONFIG_USB_OTG_WHITELIST is not set
# CONFIG_USB_OTG_FSM is not set
CONFIG_USB_MON=3Dm
# CONFIG_USB_WUSB_CBAF is not set

#
# USB Host Controller Drivers
#
# CONFIG_USB_C67X00_HCD is not set
CONFIG_USB_XHCI_HCD=3Dm
CONFIG_USB_XHCI_PCI=3Dm
CONFIG_USB_EHCI_HCD=3Dm
CONFIG_USB_EHCI_ROOT_HUB_TT=3Dy
CONFIG_USB_EHCI_TT_NEWSCHED=3Dy
CONFIG_USB_EHCI_PCI=3Dm
# CONFIG_USB_EHCI_HCD_PLATFORM is not set
# CONFIG_USB_OXU210HP_HCD is not set
# CONFIG_USB_ISP116X_HCD is not set
# CONFIG_USB_ISP1362_HCD is not set
# CONFIG_USB_FUSBH200_HCD is not set
# CONFIG_USB_FOTG210_HCD is not set
CONFIG_USB_OHCI_HCD=3Dm
# CONFIG_USB_OHCI_HCD_PCI is not set
# CONFIG_USB_OHCI_HCD_PLATFORM is not set
CONFIG_USB_UHCI_HCD=3Dm
# CONFIG_USB_SL811_HCD is not set
# CONFIG_USB_R8A66597_HCD is not set
# CONFIG_USB_HCD_TEST_MODE is not set

#
# USB Device Class drivers
#
CONFIG_USB_ACM=3Dm
CONFIG_USB_PRINTER=3Dm
CONFIG_USB_WDM=3Dm
CONFIG_USB_TMC=3Dm

#
# NOTE: USB_STORAGE depends on SCSI but BLK_DEV_SD may
#

#
# also be needed; see USB_STORAGE Help for more info
#
CONFIG_USB_STORAGE=3Dm
# CONFIG_USB_STORAGE_DEBUG is not set
CONFIG_USB_STORAGE_REALTEK=3Dm
CONFIG_REALTEK_AUTOPM=3Dy
CONFIG_USB_STORAGE_DATAFAB=3Dm
CONFIG_USB_STORAGE_FREECOM=3Dm
CONFIG_USB_STORAGE_ISD200=3Dm
CONFIG_USB_STORAGE_USBAT=3Dm
CONFIG_USB_STORAGE_SDDR09=3Dm
CONFIG_USB_STORAGE_SDDR55=3Dm
CONFIG_USB_STORAGE_JUMPSHOT=3Dm
CONFIG_USB_STORAGE_ALAUDA=3Dm
CONFIG_USB_STORAGE_ONETOUCH=3Dm
CONFIG_USB_STORAGE_KARMA=3Dm
CONFIG_USB_STORAGE_CYPRESS_ATACB=3Dm
CONFIG_USB_STORAGE_ENE_UB6250=3Dm
# CONFIG_USB_UAS is not set

#
# USB Imaging devices
#
# CONFIG_USB_MDC800 is not set
# CONFIG_USB_MICROTEK is not set
# CONFIG_USBIP_CORE is not set
# CONFIG_USB_MUSB_HDRC is not set
# CONFIG_USB_DWC3 is not set
# CONFIG_USB_DWC2 is not set
# CONFIG_USB_CHIPIDEA is not set
# CONFIG_USB_ISP1760 is not set

#
# USB port drivers
#
CONFIG_USB_SERIAL=3Dm
CONFIG_USB_SERIAL_GENERIC=3Dy
CONFIG_USB_SERIAL_SIMPLE=3Dm
CONFIG_USB_SERIAL_AIRCABLE=3Dm
CONFIG_USB_SERIAL_ARK3116=3Dm
CONFIG_USB_SERIAL_BELKIN=3Dm
CONFIG_USB_SERIAL_CH341=3Dm
CONFIG_USB_SERIAL_WHITEHEAT=3Dm
CONFIG_USB_SERIAL_DIGI_ACCELEPORT=3Dm
CONFIG_USB_SERIAL_CP210X=3Dm
CONFIG_USB_SERIAL_CYPRESS_M8=3Dm
CONFIG_USB_SERIAL_EMPEG=3Dm
CONFIG_USB_SERIAL_FTDI_SIO=3Dm
CONFIG_USB_SERIAL_VISOR=3Dm
CONFIG_USB_SERIAL_IPAQ=3Dm
CONFIG_USB_SERIAL_IR=3Dm
CONFIG_USB_SERIAL_EDGEPORT=3Dm
CONFIG_USB_SERIAL_EDGEPORT_TI=3Dm
CONFIG_USB_SERIAL_F81232=3Dm
CONFIG_USB_SERIAL_GARMIN=3Dm
CONFIG_USB_SERIAL_IPW=3Dm
CONFIG_USB_SERIAL_IUU=3Dm
CONFIG_USB_SERIAL_KEYSPAN_PDA=3Dm
CONFIG_USB_SERIAL_KEYSPAN=3Dm
CONFIG_USB_SERIAL_KEYSPAN_MPR=3Dy
CONFIG_USB_SERIAL_KEYSPAN_USA28=3Dy
CONFIG_USB_SERIAL_KEYSPAN_USA28X=3Dy
CONFIG_USB_SERIAL_KEYSPAN_USA28XA=3Dy
CONFIG_USB_SERIAL_KEYSPAN_USA28XB=3Dy
CONFIG_USB_SERIAL_KEYSPAN_USA19=3Dy
CONFIG_USB_SERIAL_KEYSPAN_USA18X=3Dy
CONFIG_USB_SERIAL_KEYSPAN_USA19W=3Dy
CONFIG_USB_SERIAL_KEYSPAN_USA19QW=3Dy
CONFIG_USB_SERIAL_KEYSPAN_USA19QI=3Dy
CONFIG_USB_SERIAL_KEYSPAN_USA49W=3Dy
CONFIG_USB_SERIAL_KEYSPAN_USA49WLC=3Dy
CONFIG_USB_SERIAL_KLSI=3Dm
CONFIG_USB_SERIAL_KOBIL_SCT=3Dm
CONFIG_USB_SERIAL_MCT_U232=3Dm
CONFIG_USB_SERIAL_METRO=3Dm
CONFIG_USB_SERIAL_MOS7720=3Dm
CONFIG_USB_SERIAL_MOS7840=3Dm
CONFIG_USB_SERIAL_MXUPORT=3Dm
CONFIG_USB_SERIAL_NAVMAN=3Dm
CONFIG_USB_SERIAL_PL2303=3Dm
CONFIG_USB_SERIAL_OTI6858=3Dm
CONFIG_USB_SERIAL_QCAUX=3Dm
CONFIG_USB_SERIAL_QUALCOMM=3Dm
CONFIG_USB_SERIAL_SPCP8X5=3Dm
CONFIG_USB_SERIAL_SAFE=3Dm
CONFIG_USB_SERIAL_SAFE_PADDED=3Dy
CONFIG_USB_SERIAL_SIERRAWIRELESS=3Dm
CONFIG_USB_SERIAL_SYMBOL=3Dm
CONFIG_USB_SERIAL_TI=3Dm
CONFIG_USB_SERIAL_CYBERJACK=3Dm
CONFIG_USB_SERIAL_XIRCOM=3Dm
CONFIG_USB_SERIAL_WWAN=3Dm
CONFIG_USB_SERIAL_OPTION=3Dm
CONFIG_USB_SERIAL_OMNINET=3Dm
CONFIG_USB_SERIAL_OPTICON=3Dm
# CONFIG_USB_SERIAL_XSENS_MT is not set
# CONFIG_USB_SERIAL_WISHBONE is not set
CONFIG_USB_SERIAL_SSU100=3Dm
CONFIG_USB_SERIAL_QT2=3Dm
CONFIG_USB_SERIAL_DEBUG=3Dm

#
# USB Miscellaneous drivers
#
# CONFIG_USB_EMI62 is not set
# CONFIG_USB_EMI26 is not set
# CONFIG_USB_ADUTUX is not set
# CONFIG_USB_SEVSEG is not set
# CONFIG_USB_RIO500 is not set
# CONFIG_USB_LEGOTOWER is not set
# CONFIG_USB_LCD is not set
# CONFIG_USB_LED is not set
# CONFIG_USB_CYPRESS_CY7C63 is not set
# CONFIG_USB_CYTHERM is not set
# CONFIG_USB_IDMOUSE is not set
# CONFIG_USB_FTDI_ELAN is not set
# CONFIG_USB_APPLEDISPLAY is not set
# CONFIG_USB_SISUSBVGA is not set
# CONFIG_USB_LD is not set
# CONFIG_USB_TRANCEVIBRATOR is not set
# CONFIG_USB_IOWARRIOR is not set
# CONFIG_USB_TEST is not set
# CONFIG_USB_EHSET_TEST_FIXTURE is not set
# CONFIG_USB_ISIGHTFW is not set
# CONFIG_USB_YUREX is not set
CONFIG_USB_EZUSB_FX2=3Dm
# CONFIG_USB_HSIC_USB3503 is not set
# CONFIG_USB_LINK_LAYER_TEST is not set
# CONFIG_USB_ATM is not set

#
# USB Physical Layer drivers
#
# CONFIG_USB_PHY is not set
# CONFIG_NOP_USB_XCEIV is not set
# CONFIG_USB_ISP1301 is not set
# CONFIG_USB_GADGET is not set
# CONFIG_UWB is not set
# CONFIG_MMC is not set
# CONFIG_MEMSTICK is not set
# CONFIG_NEW_LEDS is not set
# CONFIG_ACCESSIBILITY is not set
# CONFIG_INFINIBAND is not set
CONFIG_RTC_LIB=3Dy
CONFIG_RTC_CLASS=3Dy
CONFIG_RTC_HCTOSYS=3Dy
CONFIG_RTC_SYSTOHC=3Dy
CONFIG_RTC_HCTOSYS_DEVICE=3D"rtc0"
# CONFIG_RTC_DEBUG is not set

#
# RTC interfaces
#
CONFIG_RTC_INTF_SYSFS=3Dy
CONFIG_RTC_INTF_PROC=3Dy
CONFIG_RTC_INTF_DEV=3Dy
CONFIG_RTC_INTF_DEV_UIE_EMUL=3Dy
# CONFIG_RTC_DRV_TEST is not set

#
# I2C RTC drivers
#
# CONFIG_RTC_DRV_ABB5ZES3 is not set
# CONFIG_RTC_DRV_DS1307 is not set
# CONFIG_RTC_DRV_DS1374 is not set
# CONFIG_RTC_DRV_DS1672 is not set
# CONFIG_RTC_DRV_DS3232 is not set
# CONFIG_RTC_DRV_HYM8563 is not set
# CONFIG_RTC_DRV_MAX6900 is not set
# CONFIG_RTC_DRV_RS5C372 is not set
# CONFIG_RTC_DRV_ISL1208 is not set
# CONFIG_RTC_DRV_ISL12022 is not set
# CONFIG_RTC_DRV_ISL12057 is not set
# CONFIG_RTC_DRV_X1205 is not set
# CONFIG_RTC_DRV_PCF2127 is not set
# CONFIG_RTC_DRV_PCF8523 is not set
# CONFIG_RTC_DRV_PCF8563 is not set
# CONFIG_RTC_DRV_PCF85063 is not set
# CONFIG_RTC_DRV_PCF8583 is not set
# CONFIG_RTC_DRV_M41T80 is not set
# CONFIG_RTC_DRV_BQ32K is not set
# CONFIG_RTC_DRV_S35390A is not set
# CONFIG_RTC_DRV_FM3130 is not set
# CONFIG_RTC_DRV_RX8581 is not set
# CONFIG_RTC_DRV_RX8025 is not set
# CONFIG_RTC_DRV_EM3027 is not set
# CONFIG_RTC_DRV_RV3029C2 is not set

#
# SPI RTC drivers
#

#
# Platform RTC drivers
#
CONFIG_RTC_DRV_CMOS=3Dy
# CONFIG_RTC_DRV_DS1286 is not set
# CONFIG_RTC_DRV_DS1511 is not set
# CONFIG_RTC_DRV_DS1553 is not set
# CONFIG_RTC_DRV_DS1685_FAMILY is not set
# CONFIG_RTC_DRV_DS1742 is not set
# CONFIG_RTC_DRV_DS2404 is not set
# CONFIG_RTC_DRV_STK17TA8 is not set
# CONFIG_RTC_DRV_M48T86 is not set
# CONFIG_RTC_DRV_M48T35 is not set
CONFIG_RTC_DRV_M48T59=3Dy
# CONFIG_RTC_DRV_MSM6242 is not set
CONFIG_RTC_DRV_BQ4802=3Dy
# CONFIG_RTC_DRV_RP5C01 is not set
# CONFIG_RTC_DRV_V3020 is not set

#
# on-CPU RTC drivers
#
CONFIG_RTC_DRV_SUN4V=3Dy
CONFIG_RTC_DRV_STARFIRE=3Dy
# CONFIG_RTC_DRV_SNVS is not set
# CONFIG_RTC_DRV_XGENE is not set

#
# HID Sensor RTC drivers
#
# CONFIG_RTC_DRV_HID_SENSOR_TIME is not set
# CONFIG_DMADEVICES is not set
# CONFIG_AUXDISPLAY is not set
# CONFIG_UIO is not set
# CONFIG_VIRT_DRIVERS is not set

#
# Virtio drivers
#
# CONFIG_VIRTIO_PCI is not set
# CONFIG_VIRTIO_MMIO is not set

#
# Microsoft Hyper-V guest support
#
# CONFIG_STAGING is not set

#
# Hardware Spinlock drivers
#

#
# Clock Source drivers
#
# CONFIG_ATMEL_PIT is not set
# CONFIG_SH_TIMER_CMT is not set
# CONFIG_SH_TIMER_MTU2 is not set
# CONFIG_SH_TIMER_TMU is not set
# CONFIG_EM_TIMER_STI is not set
# CONFIG_MAILBOX is not set
# CONFIG_IOMMU_SUPPORT is not set

#
# Remoteproc drivers
#
# CONFIG_STE_MODEM_RPROC is not set

#
# Rpmsg drivers
#

#
# SOC (System On Chip) specific Drivers
#
# CONFIG_SOC_TI is not set
# CONFIG_PM_DEVFREQ is not set
# CONFIG_EXTCON is not set
# CONFIG_MEMORY is not set
# CONFIG_IIO is not set
# CONFIG_VME_BUS is not set
# CONFIG_PWM is not set
# CONFIG_IPACK_BUS is not set
# CONFIG_RESET_CONTROLLER is not set
# CONFIG_FMC is not set

#
# PHY Subsystem
#
# CONFIG_GENERIC_PHY is not set
# CONFIG_BCM_KONA_USB2_PHY is not set
# CONFIG_POWERCAP is not set
# CONFIG_MCB is not set
# CONFIG_THUNDERBOLT is not set

#
# Android
#
# CONFIG_ANDROID is not set

#
# Misc Linux/SPARC drivers
#
CONFIG_SUN_OPENPROMIO=3Dm
CONFIG_OBP_FLASH=3Dm
# CONFIG_TADPOLE_TS102_UCTRL is not set
CONFIG_BBC_I2C=3Dy
# CONFIG_ENVCTRL is not set
# CONFIG_DISPLAY7SEG is not set

#
# File systems
#
# CONFIG_EXT2_FS is not set
# CONFIG_EXT3_FS is not set
CONFIG_EXT4_FS=3Dy
CONFIG_EXT4_USE_FOR_EXT23=3Dy
CONFIG_EXT4_FS_POSIX_ACL=3Dy
CONFIG_EXT4_FS_SECURITY=3Dy
# CONFIG_EXT4_DEBUG is not set
CONFIG_JBD2=3Dy
# CONFIG_JBD2_DEBUG is not set
CONFIG_FS_MBCACHE=3Dy
# CONFIG_REISERFS_FS is not set
# CONFIG_JFS_FS is not set
# CONFIG_XFS_FS is not set
# CONFIG_GFS2_FS is not set
# CONFIG_OCFS2_FS is not set
# CONFIG_BTRFS_FS is not set
# CONFIG_NILFS2_FS is not set
CONFIG_FS_POSIX_ACL=3Dy
CONFIG_EXPORTFS=3Dy
CONFIG_FILE_LOCKING=3Dy
CONFIG_FSNOTIFY=3Dy
CONFIG_DNOTIFY=3Dy
CONFIG_INOTIFY_USER=3Dy
# CONFIG_FANOTIFY is not set
# CONFIG_QUOTA is not set
# CONFIG_QUOTACTL is not set
CONFIG_AUTOFS4_FS=3Dm
CONFIG_FUSE_FS=3Dm
CONFIG_CUSE=3Dm
# CONFIG_OVERLAY_FS is not set

#
# Caches
#
CONFIG_FSCACHE=3Dm
# CONFIG_FSCACHE_STATS is not set
# CONFIG_FSCACHE_HISTOGRAM is not set
# CONFIG_FSCACHE_DEBUG is not set
# CONFIG_FSCACHE_OBJECT_LIST is not set
# CONFIG_CACHEFILES is not set

#
# CD-ROM/DVD Filesystems
#
CONFIG_ISO9660_FS=3Dm
CONFIG_JOLIET=3Dy
CONFIG_ZISOFS=3Dy
CONFIG_UDF_FS=3Dm
CONFIG_UDF_NLS=3Dy

#
# DOS/FAT/NT Filesystems
#
CONFIG_FAT_FS=3Dm
CONFIG_MSDOS_FS=3Dm
CONFIG_VFAT_FS=3Dm
CONFIG_FAT_DEFAULT_CODEPAGEC7
CONFIG_FAT_DEFAULT_IOCHARSET=3D"utf-8"
CONFIG_NTFS_FS=3Dm
# CONFIG_NTFS_DEBUG is not set
# CONFIG_NTFS_RW is not set

#
# Pseudo filesystems
#
CONFIG_PROC_FS=3Dy
CONFIG_PROC_KCORE=3Dy
CONFIG_PROC_SYSCTL=3Dy
CONFIG_PROC_PAGE_MONITOR=3Dy
CONFIG_KERNFS=3Dy
CONFIG_SYSFS=3Dy
CONFIG_TMPFS=3Dy
CONFIG_TMPFS_POSIX_ACL=3Dy
CONFIG_TMPFS_XATTR=3Dy
CONFIG_HUGETLBFS=3Dy
CONFIG_HUGETLB_PAGE=3Dy
CONFIG_CONFIGFS_FS=3Dm
CONFIG_MISC_FILESYSTEMS=3Dy
# CONFIG_ADFS_FS is not set
# CONFIG_AFFS_FS is not set
# CONFIG_ECRYPT_FS is not set
# CONFIG_HFS_FS is not set
# CONFIG_HFSPLUS_FS is not set
# CONFIG_BEFS_FS is not set
# CONFIG_BFS_FS is not set
# CONFIG_EFS_FS is not set
# CONFIG_LOGFS is not set
# CONFIG_CRAMFS is not set
# CONFIG_SQUASHFS is not set
# CONFIG_VXFS_FS is not set
# CONFIG_MINIX_FS is not set
# CONFIG_MINIX_FS_NATIVE_ENDIAN is not set
# CONFIG_OMFS_FS is not set
# CONFIG_HPFS_FS is not set
# CONFIG_QNX4FS_FS is not set
# CONFIG_QNX6FS_FS is not set
# CONFIG_ROMFS_FS is not set
# CONFIG_PSTORE is not set
# CONFIG_SYSV_FS is not set
CONFIG_UFS_FS=3Dm
# CONFIG_UFS_FS_WRITE is not set
# CONFIG_UFS_DEBUG is not set
# CONFIG_F2FS_FS is not set
CONFIG_NETWORK_FILESYSTEMS=3Dy
CONFIG_NFS_FS=3Dm
CONFIG_NFS_V2=3Dm
CONFIG_NFS_V3=3Dm
CONFIG_NFS_V3_ACL=3Dy
CONFIG_NFS_V4=3Dm
# CONFIG_NFS_SWAP is not set
CONFIG_NFS_V4_1=3Dy
CONFIG_NFS_V4_2=3Dy
CONFIG_PNFS_FILE_LAYOUT=3Dm
CONFIG_PNFS_BLOCK=3Dm
CONFIG_PNFS_FLEXFILE_LAYOUT=3Dm
CONFIG_NFS_V4_1_IMPLEMENTATION_ID_DOMAIN=3D"kernel.org"
CONFIG_NFS_V4_1_MIGRATION=3Dy
CONFIG_NFS_V4_SECURITY_LABEL=3Dy
# CONFIG_NFS_FSCACHE is not set
# CONFIG_NFS_USE_LEGACY_DNS is not set
CONFIG_NFS_USE_KERNEL_DNS=3Dy
CONFIG_NFSD=3Dm
CONFIG_NFSD_V2_ACL=3Dy
CONFIG_NFSD_V3=3Dy
CONFIG_NFSD_V3_ACL=3Dy
CONFIG_NFSD_V4=3Dy
CONFIG_NFSD_PNFS=3Dy
# CONFIG_NFSD_V4_SECURITY_LABEL is not set
# CONFIG_NFSD_FAULT_INJECTION is not set
CONFIG_GRACE_PERIOD=3Dm
CONFIG_LOCKD=3Dm
CONFIG_LOCKD_V4=3Dy
CONFIG_NFS_ACL_SUPPORT=3Dm
CONFIG_NFS_COMMON=3Dy
CONFIG_SUNRPC=3Dm
CONFIG_SUNRPC_GSS=3Dm
CONFIG_SUNRPC_BACKCHANNEL=3Dy
# CONFIG_SUNRPC_DEBUG is not set
# CONFIG_CEPH_FS is not set
CONFIG_CIFS=3Dm
# CONFIG_CIFS_STATS is not set
CONFIG_CIFS_WEAK_PW_HASH=3Dy
CONFIG_CIFS_UPCALL=3Dy
CONFIG_CIFS_XATTR=3Dy
CONFIG_CIFS_POSIX=3Dy
CONFIG_CIFS_ACL=3Dy
# CONFIG_CIFS_DEBUG is not set
CONFIG_CIFS_DFS_UPCALL=3Dy
CONFIG_CIFS_SMB2=3Dy
# CONFIG_CIFS_FSCACHE is not set
# CONFIG_NCP_FS is not set
# CONFIG_CODA_FS is not set
# CONFIG_AFS_FS is not set
CONFIG_NLS=3Dm
CONFIG_NLS_DEFAULT=3D"utf-8"
CONFIG_NLS_CODEPAGE_437=3Dm
# CONFIG_NLS_CODEPAGE_737 is not set
CONFIG_NLS_CODEPAGE_775=3Dm
CONFIG_NLS_CODEPAGE_850=3Dm
# CONFIG_NLS_CODEPAGE_852 is not set
# CONFIG_NLS_CODEPAGE_855 is not set
# CONFIG_NLS_CODEPAGE_857 is not set
# CONFIG_NLS_CODEPAGE_860 is not set
# CONFIG_NLS_CODEPAGE_861 is not set
# CONFIG_NLS_CODEPAGE_862 is not set
# CONFIG_NLS_CODEPAGE_863 is not set
# CONFIG_NLS_CODEPAGE_864 is not set
# CONFIG_NLS_CODEPAGE_865 is not set
# CONFIG_NLS_CODEPAGE_866 is not set
# CONFIG_NLS_CODEPAGE_869 is not set
# CONFIG_NLS_CODEPAGE_936 is not set
# CONFIG_NLS_CODEPAGE_950 is not set
# CONFIG_NLS_CODEPAGE_932 is not set
# CONFIG_NLS_CODEPAGE_949 is not set
# CONFIG_NLS_CODEPAGE_874 is not set
# CONFIG_NLS_ISO8859_8 is not set
# CONFIG_NLS_CODEPAGE_1250 is not set
# CONFIG_NLS_CODEPAGE_1251 is not set
# CONFIG_NLS_ASCII is not set
CONFIG_NLS_ISO8859_1=3Dm
# CONFIG_NLS_ISO8859_2 is not set
# CONFIG_NLS_ISO8859_3 is not set
# CONFIG_NLS_ISO8859_4 is not set
# CONFIG_NLS_ISO8859_5 is not set
# CONFIG_NLS_ISO8859_6 is not set
# CONFIG_NLS_ISO8859_7 is not set
# CONFIG_NLS_ISO8859_9 is not set
# CONFIG_NLS_ISO8859_13 is not set
# CONFIG_NLS_ISO8859_14 is not set
CONFIG_NLS_ISO8859_15=3Dm
# CONFIG_NLS_KOI8_R is not set
# CONFIG_NLS_KOI8_U is not set
# CONFIG_NLS_MAC_ROMAN is not set
# CONFIG_NLS_MAC_CELTIC is not set
# CONFIG_NLS_MAC_CENTEURO is not set
# CONFIG_NLS_MAC_CROATIAN is not set
# CONFIG_NLS_MAC_CYRILLIC is not set
# CONFIG_NLS_MAC_GAELIC is not set
# CONFIG_NLS_MAC_GREEK is not set
# CONFIG_NLS_MAC_ICELAND is not set
# CONFIG_NLS_MAC_INUIT is not set
# CONFIG_NLS_MAC_ROMANIAN is not set
# CONFIG_NLS_MAC_TURKISH is not set
CONFIG_NLS_UTF8=3Dm
# CONFIG_DLM is not set

#
# Kernel hacking
#
CONFIG_TRACE_IRQFLAGS_SUPPORT=3Dy

#
# printk and dmesg options
#
CONFIG_PRINTK_TIME=3Dy
CONFIG_MESSAGE_LOGLEVEL_DEFAULT=3D4
# CONFIG_BOOT_PRINTK_DELAY is not set
# CONFIG_DYNAMIC_DEBUG is not set

#
# Compile-time checks and compiler options
#
# CONFIG_DEBUG_INFO is not set
# CONFIG_ENABLE_WARN_DEPRECATED is not set
# CONFIG_ENABLE_MUST_CHECK is not set
CONFIG_FRAME_WARN 48
CONFIG_STRIP_ASM_SYMS=3Dy
CONFIG_READABLE_ASM=3Dy
# CONFIG_UNUSED_SYMBOLS is not set
# CONFIG_PAGE_OWNER is not set
CONFIG_DEBUG_FS=3Dy
# CONFIG_HEADERS_CHECK is not set
CONFIG_DEBUG_SECTION_MISMATCH=3Dy
CONFIG_FRAME_POINTER=3Dy
CONFIG_DEBUG_FORCE_WEAK_PER_CPU=3Dy
CONFIG_MAGIC_SYSRQ=3Dy
CONFIG_MAGIC_SYSRQ_DEFAULT_ENABLE=3D0x1
CONFIG_DEBUG_KERNEL=3Dy

#
# Memory Debugging
#
# CONFIG_PAGE_EXTENSION is not set
# CONFIG_DEBUG_OBJECTS is not set
# CONFIG_DEBUG_SLAB is not set
CONFIG_HAVE_DEBUG_KMEMLEAK=3Dy
CONFIG_DEBUG_KMEMLEAK=3Dy
CONFIG_DEBUG_KMEMLEAK_EARLY_LOG_SIZE@0
# CONFIG_DEBUG_KMEMLEAK_TEST is not set
# CONFIG_DEBUG_KMEMLEAK_DEFAULT_OFF is not set
CONFIG_DEBUG_STACK_USAGE=3Dy
# CONFIG_DEBUG_VM is not set
CONFIG_DEBUG_MEMORY_INIT=3Dy
CONFIG_DEBUG_PER_CPU_MAPS=3Dy
CONFIG_DEBUG_SHIRQ=3Dy

#
# Debug Lockups and Hangs
#
CONFIG_LOCKUP_DETECTOR=3Dy
# CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC is not set
CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC_VALUE=3D0
CONFIG_DETECT_HUNG_TASK=3Dy
CONFIG_DEFAULT_HUNG_TASK_TIMEOUT=120
# CONFIG_BOOTPARAM_HUNG_TASK_PANIC is not set
CONFIG_BOOTPARAM_HUNG_TASK_PANIC_VALUE=3D0
# CONFIG_PANIC_ON_OOPS is not set
CONFIG_PANIC_ON_OOPS_VALUE=3D0
CONFIG_PANIC_TIMEOUT=3D0
# CONFIG_SCHED_DEBUG is not set
CONFIG_SCHEDSTATS=3Dy
CONFIG_SCHED_STACK_END_CHECK=3Dy
CONFIG_TIMER_STATS=3Dy

#
# Lock Debugging (spinlocks, mutexes, etc...)
#
CONFIG_DEBUG_RT_MUTEXES=3Dy
CONFIG_DEBUG_SPINLOCK=3Dy
CONFIG_DEBUG_MUTEXES=3Dy
# CONFIG_DEBUG_WW_MUTEX_SLOWPATH is not set
CONFIG_DEBUG_LOCK_ALLOC=3Dy
CONFIG_PROVE_LOCKING=3Dy
CONFIG_LOCKDEP=3Dy
# CONFIG_LOCK_STAT is not set
# CONFIG_DEBUG_LOCKDEP is not set
CONFIG_DEBUG_ATOMIC_SLEEP=3Dy
# CONFIG_DEBUG_LOCKING_API_SELFTESTS is not set
# CONFIG_LOCK_TORTURE_TEST is not set
CONFIG_TRACE_IRQFLAGS=3Dy
CONFIG_STACKTRACE=3Dy
# CONFIG_DEBUG_KOBJECT is not set
CONFIG_HAVE_DEBUG_BUGVERBOSE=3Dy
CONFIG_DEBUG_BUGVERBOSE=3Dy
CONFIG_DEBUG_LIST=3Dy
CONFIG_DEBUG_PI_LIST=3Dy
# CONFIG_DEBUG_SG is not set
# CONFIG_DEBUG_NOTIFIERS is not set
# CONFIG_DEBUG_CREDENTIALS is not set

#
# RCU Debugging
#
CONFIG_PROVE_RCU=3Dy
# CONFIG_PROVE_RCU_REPEATEDLY is not set
# CONFIG_SPARSE_RCU_POINTER is not set
# CONFIG_TORTURE_TEST is not set
# CONFIG_RCU_TORTURE_TEST is not set
CONFIG_RCU_CPU_STALL_TIMEOUT`
CONFIG_RCU_CPU_STALL_INFO=3Dy
# CONFIG_RCU_TRACE is not set
# CONFIG_DEBUG_BLOCK_EXT_DEVT is not set
# CONFIG_NOTIFIER_ERROR_INJECTION is not set
# CONFIG_FAULT_INJECTION is not set
# CONFIG_LATENCYTOP is not set
CONFIG_HAVE_FUNCTION_TRACER=3Dy
CONFIG_HAVE_FUNCTION_GRAPH_TRACER=3Dy
CONFIG_HAVE_FUNCTION_GRAPH_FP_TEST=3Dy
CONFIG_HAVE_DYNAMIC_FTRACE=3Dy
CONFIG_HAVE_FTRACE_MCOUNT_RECORD=3Dy
CONFIG_HAVE_SYSCALL_TRACEPOINTS=3Dy
CONFIG_HAVE_C_RECORDMCOUNT=3Dy
CONFIG_TRACING_SUPPORT=3Dy
# CONFIG_FTRACE is not set

#
# Runtime Testing
#
# CONFIG_LKDTM is not set
# CONFIG_TEST_LIST_SORT is not set
# CONFIG_BACKTRACE_SELF_TEST is not set
# CONFIG_RBTREE_TEST is not set
# CONFIG_INTERVAL_TREE_TEST is not set
# CONFIG_PERCPU_TEST is not set
# CONFIG_ATOMIC64_SELFTEST is not set
# CONFIG_ASYNC_RAID6_TEST is not set
# CONFIG_TEST_HEXDUMP is not set
# CONFIG_TEST_STRING_HELPERS is not set
# CONFIG_TEST_KSTRTOX is not set
# CONFIG_TEST_RHASHTABLE is not set
# CONFIG_DMA_API_DEBUG is not set
# CONFIG_TEST_LKM is not set
# CONFIG_TEST_USER_COPY is not set
# CONFIG_TEST_BPF is not set
# CONFIG_TEST_FIRMWARE is not set
# CONFIG_TEST_UDELAY is not set
# CONFIG_SAMPLES is not set
CONFIG_HAVE_ARCH_KGDB=3Dy
# CONFIG_KGDB is not set
# CONFIG_DEBUG_DCFLUSH is not set

#
# Security options
#
CONFIG_KEYS=3Dy
# CONFIG_PERSISTENT_KEYRINGS is not set
# CONFIG_BIG_KEYS is not set
# CONFIG_ENCRYPTED_KEYS is not set
# CONFIG_SECURITY_DMESG_RESTRICT is not set
CONFIG_SECURITY=3Dy
CONFIG_SECURITYFS=3Dy
CONFIG_SECURITY_NETWORK=3Dy
CONFIG_SECURITY_NETWORK_XFRM=3Dy
# CONFIG_SECURITY_PATH is not set
# CONFIG_SECURITY_SMACK is not set
# CONFIG_SECURITY_TOMOYO is not set
# CONFIG_SECURITY_APPARMOR is not set
# CONFIG_SECURITY_YAMA is not set
# CONFIG_INTEGRITY is not set
CONFIG_DEFAULT_SECURITY_DAC=3Dy
CONFIG_DEFAULT_SECURITY=3D""
CONFIG_XOR_BLOCKS=3Dm
CONFIG_ASYNC_CORE=3Dm
CONFIG_ASYNC_MEMCPY=3Dm
CONFIG_ASYNC_XOR=3Dm
CONFIG_ASYNC_PQ=3Dm
CONFIG_ASYNC_RAID6_RECOV=3Dm
CONFIG_CRYPTO=3Dy

#
# Crypto core or helper
#
CONFIG_CRYPTO_ALGAPI=3Dy
CONFIG_CRYPTO_ALGAPI2=3Dy
CONFIG_CRYPTO_AEAD=3Dm
CONFIG_CRYPTO_AEAD2=3Dy
CONFIG_CRYPTO_BLKCIPHER=3Dm
CONFIG_CRYPTO_BLKCIPHER2=3Dy
CONFIG_CRYPTO_HASH=3Dy
CONFIG_CRYPTO_HASH2=3Dy
CONFIG_CRYPTO_RNG2=3Dy
CONFIG_CRYPTO_PCOMP2=3Dy
CONFIG_CRYPTO_MANAGER=3Dy
CONFIG_CRYPTO_MANAGER2=3Dy
# CONFIG_CRYPTO_USER is not set
CONFIG_CRYPTO_MANAGER_DISABLE_TESTS=3Dy
# CONFIG_CRYPTO_GF128MUL is not set
# CONFIG_CRYPTO_NULL is not set
# CONFIG_CRYPTO_PCRYPT is not set
CONFIG_CRYPTO_WORKQUEUE=3Dy
# CONFIG_CRYPTO_CRYPTD is not set
# CONFIG_CRYPTO_MCRYPTD is not set
CONFIG_CRYPTO_AUTHENC=3Dm
# CONFIG_CRYPTO_TEST is not set

#
# Authenticated Encryption with Associated Data
#
# CONFIG_CRYPTO_CCM is not set
# CONFIG_CRYPTO_GCM is not set
# CONFIG_CRYPTO_SEQIV is not set

#
# Block modes
#
CONFIG_CRYPTO_CBC=3Dm
# CONFIG_CRYPTO_CTR is not set
# CONFIG_CRYPTO_CTS is not set
CONFIG_CRYPTO_ECB=3Dm
# CONFIG_CRYPTO_LRW is not set
# CONFIG_CRYPTO_PCBC is not set
# CONFIG_CRYPTO_XTS is not set

#
# Hash modes
#
CONFIG_CRYPTO_CMAC=3Dm
CONFIG_CRYPTO_HMAC=3Dm
# CONFIG_CRYPTO_XCBC is not set
# CONFIG_CRYPTO_VMAC is not set

#
# Digest
#
CONFIG_CRYPTO_CRC32C=3Dy
# CONFIG_CRYPTO_CRC32C_SPARC64 is not set
# CONFIG_CRYPTO_CRC32 is not set
CONFIG_CRYPTO_CRCT10DIF=3Dy
# CONFIG_CRYPTO_GHASH is not set
CONFIG_CRYPTO_MD4=3Dm
CONFIG_CRYPTO_MD5=3Dy
# CONFIG_CRYPTO_MD5_SPARC64 is not set
# CONFIG_CRYPTO_MICHAEL_MIC is not set
# CONFIG_CRYPTO_RMD128 is not set
# CONFIG_CRYPTO_RMD160 is not set
# CONFIG_CRYPTO_RMD256 is not set
# CONFIG_CRYPTO_RMD320 is not set
CONFIG_CRYPTO_SHA1=3Dm
# CONFIG_CRYPTO_SHA1_SPARC64 is not set
CONFIG_CRYPTO_SHA256=3Dm
# CONFIG_CRYPTO_SHA256_SPARC64 is not set
# CONFIG_CRYPTO_SHA512 is not set
# CONFIG_CRYPTO_SHA512_SPARC64 is not set
# CONFIG_CRYPTO_TGR192 is not set
# CONFIG_CRYPTO_WP512 is not set

#
# Ciphers
#
CONFIG_CRYPTO_AES=3Dy
# CONFIG_CRYPTO_AES_SPARC64 is not set
# CONFIG_CRYPTO_ANUBIS is not set
CONFIG_CRYPTO_ARC4=3Dm
# CONFIG_CRYPTO_BLOWFISH is not set
# CONFIG_CRYPTO_CAMELLIA is not set
# CONFIG_CRYPTO_CAMELLIA_SPARC64 is not set
# CONFIG_CRYPTO_CAST5 is not set
# CONFIG_CRYPTO_CAST6 is not set
CONFIG_CRYPTO_DES=3Dm
# CONFIG_CRYPTO_DES_SPARC64 is not set
# CONFIG_CRYPTO_FCRYPT is not set
# CONFIG_CRYPTO_KHAZAD is not set
# CONFIG_CRYPTO_SALSA20 is not set
# CONFIG_CRYPTO_SEED is not set
# CONFIG_CRYPTO_SERPENT is not set
# CONFIG_CRYPTO_TEA is not set
# CONFIG_CRYPTO_TWOFISH is not set

#
# Compression
#
CONFIG_CRYPTO_DEFLATE=3Dm
# CONFIG_CRYPTO_ZLIB is not set
# CONFIG_CRYPTO_LZO is not set
# CONFIG_CRYPTO_LZ4 is not set
# CONFIG_CRYPTO_LZ4HC is not set

#
# Random Number Generation
#
# CONFIG_CRYPTO_ANSI_CPRNG is not set
# CONFIG_CRYPTO_DRBG_MENU is not set
# CONFIG_CRYPTO_USER_API_HASH is not set
# CONFIG_CRYPTO_USER_API_SKCIPHER is not set
# CONFIG_CRYPTO_USER_API_RNG is not set
# CONFIG_CRYPTO_HW is not set
# CONFIG_ASYMMETRIC_KEY_TYPE is not set
# CONFIG_BINARY_PRINTF is not set

#
# Library routines
#
CONFIG_RAID6_PQ=3Dm
CONFIG_BITREVERSE=3Dy
# CONFIG_HAVE_ARCH_BITREVERSE is not set
CONFIG_GENERIC_STRNCPY_FROM_USER=3Dy
CONFIG_GENERIC_STRNLEN_USER=3Dy
CONFIG_GENERIC_NET_UTILS=3Dy
CONFIG_GENERIC_PCI_IOMAP=3Dy
CONFIG_GENERIC_IO=3Dy
# CONFIG_CRC_CCITT is not set
CONFIG_CRC16=3Dy
CONFIG_CRC_T10DIF=3Dy
CONFIG_CRC_ITU_T=3Dm
CONFIG_CRC32=3Dy
# CONFIG_CRC32_SELFTEST is not set
CONFIG_CRC32_SLICEBY8=3Dy
# CONFIG_CRC32_SLICEBY4 is not set
# CONFIG_CRC32_SARWATE is not set
# CONFIG_CRC32_BIT is not set
# CONFIG_CRC7 is not set
CONFIG_LIBCRC32C=3Dm
# CONFIG_CRC8 is not set
# CONFIG_AUDIT_ARCH_COMPAT_GENERIC is not set
CONFIG_RANDOM32_SELFTEST=3Dy
CONFIG_ZLIB_INFLATE=3Dm
CONFIG_ZLIB_DEFLATE=3Dm
CONFIG_LZO_COMPRESS=3Dy
CONFIG_LZO_DECOMPRESS=3Dy
# CONFIG_XZ_DEC is not set
# CONFIG_XZ_DEC_BCJ is not set
CONFIG_TEXTSEARCH=3Dy
CONFIG_TEXTSEARCH_KMP=3Dm
CONFIG_TEXTSEARCH_BM=3Dm
CONFIG_TEXTSEARCH_FSM=3Dm
CONFIG_BTREE=3Dy
CONFIG_ASSOCIATIVE_ARRAY=3Dy
CONFIG_HAS_IOMEM=3Dy
CONFIG_HAS_IOPORT_MAP=3Dy
CONFIG_HAS_DMA=3Dy
# CONFIG_CPUMASK_OFFSTACK is not set
CONFIG_CPU_RMAP=3Dy
CONFIG_DQL=3Dy
CONFIG_NLATTR=3Dy
CONFIG_ARCH_HAS_ATOMIC64_DEC_IF_POSITIVE=3Dy
# CONFIG_AVERAGE is not set
# CONFIG_CORDIC is not set
# CONFIG_DDR is not set
CONFIG_OID_REGISTRY=3Dm
CONFIG_ARCH_HAS_SG_CHAIN=3Dy

--=20
Meelis Roos (mroos@linux.ee)
