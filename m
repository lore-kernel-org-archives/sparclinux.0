From: Meelis Roos <mroos@linux.ee>
Date: Thu, 03 Mar 2016 11:57:58 +0000
Subject: sparc64 hugetlb: possible irq lock inversion dependency detected
Message-Id: <alpine.LRH.2.20.1603031352580.7760@math.ut.ee>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

I tested the rsync on my V240 as suggested in another thread, and it ran 
successfully.

However, later I looked at dmesg and found a warning about possible irq 
lock inversion dependency in hugetlb_setup. Hugetleb is enabled, 
'always'. Below is the full dmesg including bootup messages for 
reference.

Probably not related to the rsync problm in the other thread, but maybe 
related to my spontaneous reboot problem (this is one of the servers 
where the problem ocassionally happens).


[    0.000000] PROMLIB: Sun IEEE Boot Prom 'OBP 4.30.4.a 2010/01/06 14:48'
[    0.000000] PROMLIB: Root node compatible: 
[    0.000000] Linux version 4.5.0-rc4-00037-g65c23c6 (mroos@v240) (gcc version 4.9.3 (Debian 4.9.3-2) ) #129 SMP Wed Feb 17 16:01:07 EET 2016
[    0.000000] debug: ignoring loglevel setting.
[    0.000000] bootconsole [earlyprom0] enabled
[    0.000000] ARCH: SUN4U
[    0.000000] Ethernet address: 00:03:ba:5a:99:2d
[    0.000000] MM: PAGE_OFFSET is 0xfff0000000000000 (max_phys_bits = 42)
[    0.000000] MM: VMALLOC [0x0000000100000000 --> 0x000c000000000000]
[    0.000000] MM: VMEMMAP [0x000c000000000000 --> 0x0018000000000000]
[    0.000000] Kernel: Using 5 locked TLB entries for main kernel image.
[    0.000000] Remapping the kernel... done.
[    0.000000] kmemleak: Kernel memory leak detector disabled
[    0.000000] OF stdout device is: /pci@1e,600000/isa@7/serial@0,3f8
[    0.000000] PROM: Built device tree with 138973 bytes of memory.
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
[    0.000000] Initmem setup node 0 [mem 0x0000000000000000-0x000000133feb9fff]
[    0.000000] On node 0 totalpages: 786250
[    0.000000]   Normal zone: 6911 pages used for memmap
[    0.000000]   Normal zone: 0 pages reserved
[    0.000000]   Normal zone: 786250 pages, LIFO batch:15
[    0.000000] Booting Linux...
[    0.000000] CPU CAPS: [flush,stbar,swap,muldiv,v9,ultra3,mul32,div32]
[    0.000000] CPU CAPS: [v8plus,vis,vis2]
[    0.000000] PERCPU: Embedded 8 pages/cpu @fff000133f800000 s26240 r8192 d31104 u2097152
[    0.000000] pcpu-alloc: s26240 r8192 d31104 u2097152 alloc=1*4194304
[    0.000000] pcpu-alloc: [0] 0 1 
[    0.000000] Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 779339
[    0.000000] Kernel command line: root=/dev/sda2 ro ignore_loglevel
[    0.000000] PID hash table entries: 4096 (order: 2, 32768 bytes)
[    0.000000] Dentry cache hash table entries: 1048576 (order: 10, 8388608 bytes)
[    0.000000] Inode-cache hash table entries: 524288 (order: 9, 4194304 bytes)
[    0.000000] Sorting __ex_table...
[    0.000000] Memory: 6158312K/6290000K available (4789K kernel code, 358K rwdata, 1520K rodata, 288K init, 13213K bss, 131688K reserved, 0K cma-reserved)
[    0.000000] Running RCU self tests
[    0.000000] Hierarchical RCU implementation.
[    0.000000] 	RCU lockdep checking is enabled.
[    0.000000] 	Build-time adjustment of leaf fanout to 64.
[    0.000000] NR_IRQS:2048 nr_irqs:2048 1
[   40.834597] clocksource: stick: mask: 0xffffffffffffffff max_cycles: 0x2c47f4ee7, max_idle_ns: 440795202497 ns
[   40.954318] clocksource: mult[53555555] shift[24]
[   41.010562] clockevent: mult[3126e98] shift[32]
[   41.065478] Console: colour dummy device 80x25
[   41.118805] console [tty0] enabled
[   41.159472] bootconsole [earlyprom0] disabled
[   41.211570] Lock dependency validator: Copyright (c) 2006 Red Hat, Inc., Ingo Molnar
[   41.211594] ... MAX_LOCKDEP_SUBCLASSES:  8
[   41.211610] ... MAX_LOCK_DEPTH:          48
[   41.211625] ... MAX_LOCKDEP_KEYS:        8191
[   41.211640] ... CLASSHASH_SIZE:          4096
[   41.211656] ... MAX_LOCKDEP_ENTRIES:     32768
[   41.211671] ... MAX_LOCKDEP_CHAINS:      65536
[   41.211686] ... CHAINHASH_SIZE:          32768
[   41.211702]  memory used by lock dependency info: 8159 kB
[   41.211720]  per task-struct memory footprint: 1920 bytes
[   41.211823] kmemleak: Early log buffer exceeded (2155), please increase DEBUG_KMEMLEAK_EARLY_LOG_SIZE
[   41.291775] Calibrating delay using timer specific routine.. 24.09 BogoMIPS (lpjH196)
[   41.291807] pid_max: default: 32768 minimum: 301
[   41.292235] Security Framework initialized
[   41.292390] Mount-cache hash table entries: 16384 (order: 4, 131072 bytes)
[   41.292420] Mountpoint-cache hash table entries: 16384 (order: 4, 131072 bytes)
[   41.302839] CPU 0: synchronized TICK with master CPU (last diff -1 cycles, maxerr 7 cycles)
[   41.303086] Brought up 2 CPUs
[   41.305162] devtmpfs: initialized
[   41.321145] Performance events: 
[   41.321185] Testing NMI watchdog ... 
[   41.401219] OK.
[   41.401239] Supported PMU type is 'ultra3i'
[   41.425162] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 7645041785100000 ns
[   41.425517] prandom: seed boundary self test passed
[   41.428690] prandom: 100 self tests passed
[   41.430211] NET: Registered protocol family 16
[   41.436374] IRQ pre handler NOT supported.
[   41.436431] IRQ pre handler NOT supported.
[   41.436472] IRQ pre handler NOT supported.
[   41.436552] IRQ pre handler NOT supported.
[   41.436595] IRQ pre handler NOT supported.
[   41.436951] IRQ pre handler NOT supported.
[   41.437280] IRQ pre handler NOT supported.
[   41.437615] IRQ pre handler NOT supported.
[   41.437658] IRQ pre handler NOT supported.
[   41.437699] IRQ pre handler NOT supported.
[   41.437738] IRQ pre handler NOT supported.
[   41.437779] IRQ pre handler NOT supported.
[   41.438924] IRQ pre handler NOT supported.
[   41.445071] IRQ pre handler NOT supported.
[   41.445412] IRQ pre handler NOT supported.
[   41.445723] IRQ pre handler NOT supported.
[   41.446020] IRQ pre handler NOT supported.
[   41.446628] IRQ pre handler NOT supported.
[   41.447208] IRQ pre handler NOT supported.
[   41.447577] IRQ pre handler NOT supported.
[   41.448422] IRQ pre handler NOT supported.
[   41.448787] IRQ pre handler NOT supported.
[   41.448831] IRQ pre handler NOT supported.
[   41.448872] IRQ pre handler NOT supported.
[   41.448912] IRQ pre handler NOT supported.
[   41.448951] IRQ pre handler NOT supported.
[   41.449314] IRQ pre handler NOT supported.
[   41.450169] IRQ pre handler NOT supported.
[   41.450993] IRQ pre handler NOT supported.
[   41.451036] IRQ pre handler NOT supported.
[   41.451076] IRQ pre handler NOT supported.
[   41.451126] IRQ pre handler NOT supported.
[   41.451167] IRQ pre handler NOT supported.
[   41.451503] IRQ pre handler NOT supported.
[   41.451846] IRQ pre handler NOT supported.
[   41.455183] /pci@1f,700000: TOMATILLO PCI Bus Module ver[4:0]
[   41.455228] /pci@1f,700000: PCI IO[7f601000000] MEM[7f700000000] MEM64[7f700000000]
[   41.457380] PCI: Scanning PBM /pci@1f,700000
[   41.458035] schizo f0069c00: PCI host bridge to bus 0000:00
[   41.458080] pci_bus 0000:00: root bus resource [io  0x7f601000000-0x7f601ffffff] (bus address [0x0000-0xffffff])
[   41.458132] pci_bus 0000:00: root bus resource [mem 0x7f700000000-0x7f7ffffffff] (bus address [0x00000000-0xffffffff])
[   41.458184] pci_bus 0000:00: root bus resource [mem 0x7f700000000-0x7f7ffffffff] (bus address [0x00000000-0xffffffff])
[   41.458238] pci_bus 0000:00: root bus resource [bus 00]
[   41.458584] pci 0000:00:02.0: PME# supported from D3hot
[   41.459500] pci 0000:00:02.1: PME# supported from D3hot
[   41.460914] /pci@1e,600000: TOMATILLO PCI Bus Module ver[4:0]
[   41.460953] /pci@1e,600000: PCI IO[7fe01000000] MEM[7ff00000000] MEM64[7ff00000000]
[   41.463004] PCI: Scanning PBM /pci@1e,600000
[   41.463566] schizo f00732d0: PCI host bridge to bus 0001:00
[   41.463611] pci_bus 0001:00: root bus resource [io  0x7fe01000000-0x7fe01ffffff] (bus address [0x0000-0xffffff])
[   41.463662] pci_bus 0001:00: root bus resource [mem 0x7ff00000000-0x7ffffffffff] (bus address [0x00000000-0xffffffff])
[   41.463714] pci_bus 0001:00: root bus resource [mem 0x7ff00000000-0x7ffffffffff] (bus address [0x00000000-0xffffffff])
[   41.463766] pci_bus 0001:00: root bus resource [bus 00]
[   41.464608] pci 0001:00:06.0: quirk: [io  0x7fe01000800-0x7fe0100083f] claimed by ali7101 ACPI
[   41.464664] pci 0001:00:06.0: quirk: [io  0x7fe01000600-0x7fe0100061f] claimed by ali7101 SMB
[   41.465479] pci 0001:00:0a.0: PME# supported from D3cold
[   41.467611] pci 0001:00:07.0: can't claim BAR 0 [io  0x7fe01000000-0x7fe0100ffff]: address conflict with 0001:00:06.0 [io  0x7fe01000600-0x7fe0100061f]
[   41.467680] pci 0001:00:07.0: can't claim BAR 1 [mem 0x7ff00000000-0x7ff000fffff]: address conflict with Video RAM area [??? 0x7ff000a0000-0x7ff000bffff flags 0x80000000]
[   41.467751] pci 0001:00:07.0: can't claim BAR 2 [mem 0x7ff00000000-0x7ff000fffff]: address conflict with Video RAM area [??? 0x7ff000a0000-0x7ff000bffff flags 0x80000000]
[   41.468350] /pci@1c,600000: TOMATILLO PCI Bus Module ver[4:0]
[   41.468389] /pci@1c,600000: PCI IO[7ce01000000] MEM[7cf00000000] MEM64[7cf00000000]
[   41.470490] PCI: Scanning PBM /pci@1c,600000
[   41.471066] schizo f007c6ac: PCI host bridge to bus 0002:00
[   41.471107] pci_bus 0002:00: root bus resource [io  0x7ce01000000-0x7ce01ffffff] (bus address [0x0000-0xffffff])
[   41.471159] pci_bus 0002:00: root bus resource [mem 0x7cf00000000-0x7cfffffffff] (bus address [0x00000000-0xffffffff])
[   41.471210] pci_bus 0002:00: root bus resource [mem 0x7cf00000000-0x7cfffffffff] (bus address [0x00000000-0xffffffff])
[   41.471264] pci_bus 0002:00: root bus resource [bus 00]
[   41.471518] pci 0002:00:02.0: supports D1 D2
[   41.472265] pci 0002:00:02.1: supports D1 D2
[   41.473501] /pci@1d,700000: TOMATILLO PCI Bus Module ver[4:0]
[   41.473541] /pci@1d,700000: PCI IO[7c601000000] MEM[7c700000000] MEM64[7c700000000]
[   41.475603] PCI: Scanning PBM /pci@1d,700000
[   41.476182] schizo f00859d4: PCI host bridge to bus 0003:00
[   41.476226] pci_bus 0003:00: root bus resource [io  0x7c601000000-0x7c601ffffff] (bus address [0x0000-0xffffff])
[   41.476277] pci_bus 0003:00: root bus resource [mem 0x7c700000000-0x7c7ffffffff] (bus address [0x00000000-0xffffffff])
[   41.476329] pci_bus 0003:00: root bus resource [mem 0x7c700000000-0x7c7ffffffff] (bus address [0x00000000-0xffffffff])
[   41.476383] pci_bus 0003:00: root bus resource [bus 00]
[   41.476703] pci 0003:00:02.0: PME# supported from D3hot
[   41.477719] pci 0003:00:02.1: PME# supported from D3hot
[   41.498253] HugeTLB registered 8 MB page size, pre-allocated 0 pages
[   41.502250] vgaarb: loaded
[   41.503086] SCSI subsystem initialized
[   41.505986] /pci@1e,600000/isa@7/rtc@0,70: RTC regs at 0x7fe01000070
[   41.508327] clocksource: Switched to clocksource stick
[   41.537346] NET: Registered protocol family 2
[   41.539035] TCP established hash table entries: 65536 (order: 6, 524288 bytes)
[   41.541053] TCP bind hash table entries: 65536 (order: 9, 4194304 bytes)
[   41.560200] TCP: Hash tables configured (established 65536 bind 65536)
[   41.561036] UDP hash table entries: 4096 (order: 6, 655360 bytes)
[   41.564082] UDP-Lite hash table entries: 4096 (order: 6, 655360 bytes)
[   41.568178] NET: Registered protocol family 1
[   41.568490] pci 0001:00:07.0: Activating ISA DMA hang workarounds
[   41.568573] PCI: Enabling device: (0001:00:0a.0), cmd 2
[   41.624472] PCI: CLS 64 bytes, default 64
[   41.625262] power: Control reg at 7fe01000800
[   41.626575] chmc: UltraSPARC-IIIi memory controller at /memory-controller@0,0
[   41.626698] chmc: UltraSPARC-IIIi memory controller at /memory-controller@1,0
[   41.629403] futex hash table entries: 512 (order: 3, 65536 bytes)
[   41.634830] cryptomgr_test (28) used greatest stack depth: 10328 bytes left
[   41.634916] cryptomgr_test (29) used greatest stack depth: 10040 bytes left
[   41.641698] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 252)
[   41.642151] io scheduler noop registered
[   41.642326] io scheduler cfq registered (default)
[   41.642362] start plist test
[   41.653079] end plist test
[   41.654975] f00ac5a0: ttyS0 at MMIO 0x7fe010003f8 (irq = 15, base_baud = 115387) is a 16550A
[   41.655053] Console: ttyS0 (SU)
[   56.265462] console [ttyS0] enabled
[   56.312839] f00ae120: ttyS1 at MMIO 0x7fe010002e8 (irq = 15, base_baud = 115387) is a 16550A
[   56.426538] PCI: Enabling device: (0002:00:02.0), cmd 147
[   56.498476] sym0: <1010-66> rev 0x1 at pci 0002:00:02.0 irq 25
[   56.577960] sym0: No NVRAM, ID 7, Fast-80, LVD, parity checking
[   56.696702] sym0: SCSI BUS has been reset.
[   56.750548] scsi host0: sym-2.2.3
[   56.797618] PCI: Enabling device: (0002:00:02.1), cmd 147
[   56.869558] sym1: <1010-66> rev 0x1 at pci 0002:00:02.1 irq 26
[   56.948748] sym1: No NVRAM, ID 7, Fast-80, LVD, parity checking
[   57.067426] sym1: SCSI BUS has been reset.
[   57.121223] scsi host1: sym-2.2.3
[   57.169668] mousedev: PS/2 mouse device common for all mice
[   57.245153] rtc_cmos rtc_cmos: rtc core: registered rtc_cmos as rtc0
[   57.328827] rtc_cmos rtc_cmos: no alarms, 114 bytes nvram
[   57.401085] NET: Registered protocol family 17
[   57.459711] Key type dns_resolver registered
[   57.517904] registered taskstats version 1
[   57.573361] kworker/u4:2 (59) used greatest stack depth: 9528 bytes left
[   57.662752] cryptomgr_probe (61) used greatest stack depth: 8296 bytes left
[   57.754427] Key type encrypted registered
[   57.809231] rtc_cmos rtc_cmos: setting system clock to 2016-02-22 09:57:56 UTC (1456135076)
[   59.761657] scsi 0:0:0:0: Direct-Access     SEAGATE  ST373307LSUN72G  0507 PQ: 0 ANSI: 3
[   59.868190] scsi target0:0:0: tagged command queuing enabled, command queue depth 16.
[   59.971373] scsi target0:0:0: Beginning Domain Validation
[   60.047669] scsi target0:0:0: FAST-80 WIDE SCSI 160.0 MB/s DT (12.5 ns, offset 31)
[   60.153553] scsi target0:0:0: Ending Domain Validation
[   60.234441] scsi 0:0:1:0: Direct-Access     SEAGATE  ST336607LSUN36G  0307 PQ: 0 ANSI: 3
[   60.340956] scsi target0:0:1: tagged command queuing enabled, command queue depth 16.
[   60.444004] scsi target0:0:1: Beginning Domain Validation
[   60.520929] scsi target0:0:1: FAST-80 WIDE SCSI 160.0 MB/s DT (12.5 ns, offset 31)
[   60.626812] scsi target0:0:1: Ending Domain Validation
[   60.710251] scsi 0:0:2:0: Direct-Access     SEAGATE  ST336607LSUN36G  0507 PQ: 0 ANSI: 3
[   60.816787] scsi target0:0:2: tagged command queuing enabled, command queue depth 16.
[   60.919822] scsi target0:0:2: Beginning Domain Validation
[   60.996040] scsi target0:0:2: FAST-80 WIDE SCSI 160.0 MB/s DT (12.5 ns, offset 31)
[   61.101940] scsi target0:0:2: Ending Domain Validation
[   61.186305] scsi 0:0:3:0: Direct-Access     SEAGATE  ST336607LSUN36G  0507 PQ: 0 ANSI: 3
[   61.292788] scsi target0:0:3: tagged command queuing enabled, command queue depth 16.
[   61.395856] scsi target0:0:3: Beginning Domain Validation
[   61.472109] scsi target0:0:3: FAST-80 WIDE SCSI 160.0 MB/s DT (12.5 ns, offset 31)
[   61.578183] scsi target0:0:3: Ending Domain Validation
[   64.920414] sd 0:0:0:0: [sda] 143374738 512-byte logical blocks: (73.4 GB/68.4 GiB)
[   64.928142] sd 0:0:1:0: [sdb] 71132959 512-byte logical blocks: (36.4 GB/33.9 GiB)
[   64.928337] sd 0:0:2:0: [sdc] 71132959 512-byte logical blocks: (36.4 GB/33.9 GiB)
[   64.929811] sd 0:0:1:0: [sdb] Write Protect is off
[   64.929821] sd 0:0:1:0: [sdb] Mode Sense: db 00 10 08
[   64.929959] sd 0:0:2:0: [sdc] Write Protect is off
[   64.929968] sd 0:0:2:0: [sdc] Mode Sense: db 00 10 08
[   64.931968] sd 0:0:1:0: [sdb] Write cache: disabled, read cache: enabled, supports DPO and FUA
[   64.932611] sd 0:0:2:0: [sdc] Write cache: disabled, read cache: enabled, supports DPO and FUA
[   64.949829]  sdb: sdb1 sdb2 sdb3 sdb4
[   64.954400]  sdc: sdc1 sdc3
[   64.962190] sd 0:0:1:0: [sdb] Attached SCSI disk
[   64.962478] sd 0:0:2:0: [sdc] Attached SCSI disk
[   64.962924] sd 0:0:3:0: [sdd] 71132959 512-byte logical blocks: (36.4 GB/33.9 GiB)
[   64.964541] sd 0:0:3:0: [sdd] Write Protect is off
[   64.964550] sd 0:0:3:0: [sdd] Mode Sense: db 00 10 08
[   64.966788] sd 0:0:3:0: [sdd] Write cache: disabled, read cache: enabled, supports DPO and FUA
[   64.982807]  sdd: sdd1 sdd3
[   64.990558] sd 0:0:3:0: [sdd] Attached SCSI disk
[   66.352839] sd 0:0:0:0: [sda] Write Protect is off
[   66.415842] sd 0:0:0:0: [sda] Mode Sense: db 00 10 08
[   66.484565] sd 0:0:0:0: [sda] Write cache: disabled, read cache: enabled, supports DPO and FUA
[   66.615015]  sda: sda1 sda2 sda3 sda4
[   66.672262] sd 0:0:0:0: [sda] Attached SCSI disk
[   66.739198] EXT4-fs (sda2): couldn't mount as ext3 due to feature incompatibilities
[   66.847082] EXT4-fs (sda2): couldn't mount as ext2 due to feature incompatibilities
[   66.993711] EXT4-fs (sda2): mounted filesystem with ordered data mode. Opts: (null)
[   67.094562] VFS: Mounted root (ext4 filesystem) readonly on device 8:2.
[   67.201222] devtmpfs: mounted
[   67.857819] stty (101) used greatest stack depth: 7032 bytes left
[   68.071332] tput (105) used greatest stack depth: 4600 bytes left
[   69.122935] random: udevd urandom read with 23 bits of entropy available
[   69.847054] PCI: Enabling device: (0001:00:03.0), cmd 3
[   69.915974] skge: 1.14 addr 0x7ff00100000 irq 19 chip Genesis rev 0
[   70.001702] alim7101_wdt: Steve Hill <steve@navaho.co.uk>
[   70.081042] alim7101_wdt: Detected old alim7101 revision 'a1d'.  If this is a cobalt board, set the 'use_gpio' module parameter.
[   70.257070] skge 0001:00:03.0 eth0: addr 00:00:5a:9a:43:58
[   70.329889] pps_core: LinuxPPS API ver. 1 registered
[   70.395225] pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rodolfo Giometti <giometti@linux.it>
[   70.398946] sd 0:0:0:0: Attached scsi generic sg0 type 0
[   70.399506] sd 0:0:1:0: Attached scsi generic sg1 type 0
[   70.400031] sd 0:0:2:0: Attached scsi generic sg2 type 0
[   70.408363] sd 0:0:3:0: Attached scsi generic sg3 type 0
[   70.728521] PCI: Enabling device: (0001:00:06.0), cmd 1
[   70.888026] alim7101_wdt: Steve Hill <steve@navaho.co.uk>
[   70.890403] PTP clock support registered
[   71.010598] alim7101_wdt: Detected old alim7101 revision 'a1d'.  If this is a cobalt board, set the 'use_gpio' module parameter.
[   71.207909] tg3.c:v3.137 (May 11, 2014)
[   71.264890] PCI: Enabling device: (0000:00:02.0), cmd 2
[   71.393378] skge 0001:00:03.0 eth4: renamed from eth0
[   71.515461] tg3 0000:00:02.0 (unnamed net_device) (uninitialized): Cannot get nvram lock, tg3_nvram_init failed
[   71.992580] tg3 0000:00:02.0 eth0: Tigon3 [partno(none) rev 2003] (PCI:66MHz:64-bit) MAC address 00:03:ba:5a:99:2d
[   72.128798] tg3 0000:00:02.0 eth0: attached PHY is 5704 (10/100/1000Base-T Ethernet) (WireSpeed[1], EEE[0])
[   72.256983] tg3 0000:00:02.0 eth0: RXcsums[1] LinkChgREG[0] MIirq[0] ASF[0] TSOcap[1]
[   72.360011] tg3 0000:00:02.0 eth0: dma_rwctrl[763f0000] dma_mask[32-bit]
[   72.448383] PCI: Enabling device: (0000:00:02.1), cmd 2
[   72.690158] tg3 0000:00:02.1 (unnamed net_device) (uninitialized): Cannot get nvram lock, tg3_nvram_init failed
[   73.164808] tg3 0000:00:02.1 eth1: Tigon3 [partno(none) rev 2003] (PCI:66MHz:64-bit) MAC address 00:03:ba:5a:99:2e
[   73.301046] tg3 0000:00:02.1 eth1: attached PHY is 5704 (10/100/1000Base-T Ethernet) (WireSpeed[1], EEE[0])
[   73.429260] tg3 0000:00:02.1 eth1: RXcsums[1] LinkChgREG[0] MIirq[0] ASF[0] TSOcap[1]
[   73.532274] tg3 0000:00:02.1 eth1: dma_rwctrl[763f0000] dma_mask[32-bit]
[   73.620642] PCI: Enabling device: (0003:00:02.0), cmd 2
[   73.862147] tg3 0003:00:02.0 (unnamed net_device) (uninitialized): Cannot get nvram lock, tg3_nvram_init failed
[   74.336544] tg3 0003:00:02.0 eth2: Tigon3 [partno(none) rev 2003] (PCI:66MHz:64-bit) MAC address 00:03:ba:5a:99:2f
[   74.472786] tg3 0003:00:02.0 eth2: attached PHY is 5704 (10/100/1000Base-T Ethernet) (WireSpeed[1], EEE[0])
[   74.600985] tg3 0003:00:02.0 eth2: RXcsums[1] LinkChgREG[0] MIirq[0] ASF[0] TSOcap[1]
[   74.704011] tg3 0003:00:02.0 eth2: dma_rwctrl[763f0000] dma_mask[32-bit]
[   74.792338] PCI: Enabling device: (0003:00:02.1), cmd 2
[   75.034138] tg3 0003:00:02.1 (unnamed net_device) (uninitialized): Cannot get nvram lock, tg3_nvram_init failed
[   75.508597] tg3 0003:00:02.1 eth3: Tigon3 [partno(none) rev 2003] (PCI:66MHz:64-bit) MAC address 00:03:ba:5a:99:30
[   75.644842] tg3 0003:00:02.1 eth3: attached PHY is 5704 (10/100/1000Base-T Ethernet) (WireSpeed[1], EEE[0])
[   75.773046] tg3 0003:00:02.1 eth3: RXcsums[1] LinkChgREG[0] MIirq[0] ASF[0] TSOcap[1]
[   75.876072] tg3 0003:00:02.1 eth3: dma_rwctrl[763f0000] dma_mask[32-bit]
[   76.706464] Adding 3084472k swap on /dev/sda4.  Priority:-1 extents:1 across:3084472k 
[   76.943383] EXT4-fs (sda2): re-mounted. Opts: (null)
[   77.253401] EXT4-fs (sda2): re-mounted. Opts: errors=remount-ro
[   78.675874] loop: module loaded
[   78.956858] EXT4-fs (sda1): mounting ext2 file system using the ext4 subsystem
[   79.059850] EXT4-fs (sda1): mounted filesystem without journal. Opts: (null)
[   80.620500] NET: Registered protocol family 10
[   82.226772] tg3 0000:00:02.0 eth0: No firmware running
[   82.699941] IPv6: ADDRCONF(NETDEV_UP): eth0: link is not ready
[   82.777850] ip (895) used greatest stack depth: 2440 bytes left
[   84.247937] tg3 0000:00:02.0 eth0: Link is up at 100 Mbps, full duplex
[   84.333779] tg3 0000:00:02.0 eth0: Flow control is off for TX and off for RX
[   84.426942] IPv6: ADDRCONF(NETDEV_CHANGE): eth0: link becomes ready
[  412.162952] random: nonblocking pool is initialized

[867151.117978] ============================[867151.203753] [ INFO: possible irq lock inversion dependency detected ]
[867151.289539] 4.5.0-rc4-00037-g65c23c6 #129 Not tainted
[867151.357015] ---------------------------------------------------------
[867151.442804] rsync/8978 just changed the state of lock:
[867151.511427]  (ctx_alloc_lock){+.....}, at: [<00000000004519c4>] hugetlb_setup+0xe4/0x160
[867151.618947] but this lock was taken by another, HARDIRQ-safe lock in the past:
[867151.715027]  (&rq->lock){-.-.-.}
                
                and interrupts could create inverse lock ordering between them.

[867151.837424] 
                other info that might help us debug this:
[867151.925586] Chain exists of:
                  &rq->lock --> &(&mm->context.lock)->rlock --> ctx_alloc_lock

[867152.039949]  Possible interrupt unsafe locking scenario:

[867152.131467]        CPU0                    CPU1
[867152.192074]        ----                    ----
[867152.252693]   lock(ctx_alloc_lock);
[867152.299580]                                local_irq_disable();
[867152.378513]                                lock(&rq->lock);
[867152.452846]                                lock(&(&mm->context.lock)->rlock);
[867152.547786]   <Interrupt>
[867152.583243]     lock(&rq->lock);
[867152.626700] 
                 *** DEADLOCK ***

[867152.707934] no locks held by rsync/8978.
[867152.760532] 
                the shortest dependencies between 2nd lock and 1st lock:
[867152.865774]   -> (&rq->lock){-.-.-.} ops: 123162804302643200 {
[867152.943526]      IN-HARDIRQ-W at:
[867152.988135]                         [<00000000004b03b0>] lock_acquire+0x50/0x80
[867153.085369]                         [<00000000008b0ae8>] _raw_spin_lock+0x28/0x40
[867153.184879]                         [<000000000048c010>] scheduler_tick+0x30/0xe0
[867153.284386]                         [<00000000004d0528>] update_process_times+0x48/0x60
[867153.390759]                         [<00000000004dd93c>] tick_periodic+0xbc/0xe0
[867153.489121]                         [<00000000004dd96c>] tick_handle_periodic+0xc/0xa0
[867153.594350]                         [<000000000042fff4>] timer_interrupt+0x94/0xc0
[867153.695003]                         [<0000000000426bdc>] sys_call_table+0x648/0x7ec
[867153.796799]                         [<00000000004bf8fc>] console_unlock+0x41c/0x560
[867153.898596]                         [<0000000000aaa234>] con_init+0x260/0x280
[867153.993528]                         [<0000000000aa98d0>] console_init+0x1c/0x38
[867154.090749]                         [<0000000000a92a90>] start_kernel+0x480/0x588
[867154.190256]                         [<0000000000a941c8>] start_early_boot+0x25c/0x26c
[867154.294342]                         [<00000000008a9e38>] tlb_fixup_done+0x54/0x5c
[867154.393851]                         [<          (null)>]           (null)
[867154.484200]      IN-SOFTIRQ-W at:
[867154.528802]                         [<00000000004b03b0>] lock_acquire+0x50/0x80
[867154.626036]                         [<00000000008b0c40>] _raw_spin_lock_irqsave+0x40/0x60
[867154.734695]                         [<0000000000493e88>] update_blocked_averages+0x28/0x560
[867154.845642]                         [<000000000049ddc4>] rebalance_domains+0x24/0x400
[867154.949724]                         [<000000000049e3d4>] run_rebalance_domains+0x234/0x260
[867155.059530]                         [<0000000000464648>] __do_softirq+0xe8/0x240
[867155.157892]                         [<000000000042be0c>] do_softirq_own_stack+0x2c/0x40
[867155.264266]                         [<0000000000464a88>] irq_exit+0x48/0xc0
[867155.356900]                         [<000000000042fffc>] timer_interrupt+0x9c/0xc0
[867155.457562]                         [<0000000000426bdc>] sys_call_table+0x648/0x7ec
[867155.559357]                         [<00000000004ad7ec>] debug_check_no_locks_freed+0x14c/0x180
[867155.674883]                         [<00000000004b39c8>] __raw_spin_lock_init+0x8/0x60
[867155.780107]                         [<00000000005343b8>] shmem_get_inode+0x98/0x1c0
[867155.881903]                         [<000000000053466c>] shmem_fill_super+0x18c/0x1e0
[867155.985987]                         [<000000000058b394>] mount_nodev+0x34/0xa0
[867156.082062]                         [<0000000000534dd4>] shmem_mount+0x14/0x40
[867156.178140]                         [<000000000058c2e0>] mount_fs+0x60/0x160
[867156.271922]                         [<00000000005aa7a8>] vfs_kern_mount+0x48/0x120
[867156.372583]                         [<00000000005aa890>] kern_mount_data+0x10/0x40
[867156.473236]                         [<0000000000aa012c>] shmem_init+0x70/0xb4
[867156.568167]                         [<0000000000a92ce8>] kernel_init_freeable+0x150/0x2d4
[867156.673281] ------------[ cut here ]------------
[867156.673316] WARNING: CPU: 0 PID: 0 at net/sched/sch_generic.c:303 dev_watchdog+0x190/0x2a0()
[867156.673320] NETDEV WATCHDOG: eth0 (tg3): transmit queue 0 timed out
[867156.673358] Modules linked in: ipv6 loop tg3 hwmon ptp i2c_ali15x3 sg i2c_ali1535 i2c_core pps_core skge
[867156.673368] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 4.5.0-rc4-00037-g65c23c6 #129
[867156.673371] Call Trace:
[867156.673390]  [000000000045fe2c] warn_slowpath_common+0x6c/0xa0
[867156.673396]  [000000000045fe8c] warn_slowpath_fmt+0x2c/0x40
[867156.673401]  [00000000007f81b0] dev_watchdog+0x190/0x2a0
[867156.673409]  [00000000004cf268] call_timer_fn+0x48/0xc0
[867156.673415]  [00000000004cf4cc] run_timer_softirq+0x1ec/0x240
[867156.673424]  [0000000000464648] __do_softirq+0xe8/0x240
[867156.673437]  [000000000042be0c] do_softirq_own_stack+0x2c/0x40
[867156.673444]  [0000000000464a88] irq_exit+0x48/0xc0
[867156.673454]  [000000000042fffc] timer_interrupt+0x9c/0xc0
[867156.673460]  [0000000000426bdc] sys_call_table+0x648/0x7ec
[867156.673475]  [00000000004c9c50] rcu_idle_exit+0x90/0xa0
[867156.673486]  [00000000004a6a58] cpu_startup_entry+0x198/0x260
[867156.673503]  [000000000043e6dc] smp_callin+0x19c/0x200
[867156.673519]  [0000000000a48f04] after_lock_tlb+0x1a8/0x1bc
[867156.673524]  [0000000040000000] 0x40000000
[867156.673528] ---[ end trace 379fc2f0c1c69621 ]---
[867156.673543] tg3 0000:00:02.0 eth0: transmit timed out, resetting
[867156.677215] tg3 0000:00:02.0 eth0: 0x00000000: 0x164814e4, 0x02b00006, 0x02000000, 0x00804010
[867156.677224] tg3 0000:00:02.0 eth0: 0x00000010: 0x00200004, 0x00000000, 0x00110004, 0x00000000
[867156.677232] tg3 0000:00:02.0 eth0: 0x00000020: 0x00000000, 0x00000000, 0x00000000, 0x164814e4
[867156.677239] tg3 0000:00:02.0 eth0: 0x00000030: 0xdffe0000, 0x00000040, 0x00000000, 0x004001ff
[867156.677247] tg3 0000:00:02.0 eth0: 0x00000040: 0x00024807, 0x0443fff8, 0x40025001, 0x00002000
[867156.677255] tg3 0000:00:02.0 eth0: 0x00000050: 0x00f85803, 0xfff6fbdf, 0x00860005, 0x7ffafefc
[867156.677262] tg3 0000:00:02.0 eth0: 0x00000060: 0xce7effeb, 0x0000de7f, 0x20030298, 0x763f0000
[867156.677270] tg3 0000:00:02.0 eth0: 0x00000070: 0x000000ec, 0x800000c4, 0x00035b4c, 0x00000000
[867156.677278] tg3 0000:00:02.0 eth0: 0x00000080: 0x00000000, 0xfbdd0901, 0x04130036, 0x02209082
[867156.677285] tg3 0000:00:02.0 eth0: 0x00000090: 0x01009708, 0x00000001, 0x00000000, 0x00000194
[867156.677293] tg3 0000:00:02.0 eth0: 0x000000a0: 0x00000000, 0x000002cc, 0x00000000, 0x00000004
[867156.677301] tg3 0000:00:02.0 eth0: 0x00000200: 0x00000000, 0xbd000000, 0x00000000, 0x00000000
[867156.677308] tg3 0000:00:02.0 eth0: 0x00000260: 0x00000000, 0x00000000, 0x00000000, 0x00000194
[867156.677316] tg3 0000:00:02.0 eth0: 0x00000280: 0x00000000, 0x000002cc, 0x00000000, 0x00000000
[867156.677323] tg3 0000:00:02.0 eth0: 0x00000300: 0x00000000, 0x00000004, 0x00000000, 0x00000000
[867156.677331] tg3 0000:00:02.0 eth0: 0x00000380: 0x00000000, 0x00000004, 0x00000000, 0x00000000
[867156.677338] tg3 0000:00:02.0 eth0: 0x00000400: 0x00e04c04, 0x00400003, 0x00001000, 0x00000900
[867156.677346] tg3 0000:00:02.0 eth0: 0x00000410: 0x00000003, 0xba5a992d, 0x00000003, 0xba5a992d
[867156.677354] tg3 0000:00:02.0 eth0: 0x00000420: 0x00000003, 0xba5a992d, 0x00000003, 0xba5a992d
[867156.677361] tg3 0000:00:02.0 eth0: 0x00000430: 0x00000000, 0x00000000, 0x000003c8, 0x000005f2
[867156.677369] tg3 0000:00:02.0 eth0: 0x00000440: 0x00000000, 0x00000000, 0x00000000, 0x08310301
[867156.677376] tg3 0000:00:02.0 eth0: 0x00000450: 0x00000001, 0x000c0000, 0x00000000, 0x00000002
[867156.677383] tg3 0000:00:02.0 eth0: 0x00000460: 0x00000008, 0x00002620, 0x00000002, 0x00000000
[867156.677391] tg3 0000:00:02.0 eth0: 0x00000470: 0x80000000, 0x01000000, 0x00000000, 0x40000000
[867156.677399] tg3 0000:00:02.0 eth0: 0x00000480: 0x42000000, 0x7fffffff, 0x06000004, 0x7fffffff
[867156.677406] tg3 0000:00:02.0 eth0: 0x00000500: 0x00000008, 0x00000002, 0x00000000, 0x00000000
[867156.677414] tg3 0000:00:02.0 eth0: 0x00000530: 0x00000003, 0xba5a992d, 0x00000003, 0xba5a992d
[867156.677421] tg3 0000:00:02.0 eth0: 0x00000540: 0x00000003, 0xba5a992d, 0x00000003, 0xba5a992d
[867156.677429] tg3 0000:00:02.0 eth0: 0x00000550: 0x00000003, 0xba5a992d, 0x00000003, 0xba5a992d
[867156.677436] tg3 0000:00:02.0 eth0: 0x00000560: 0x00000003, 0xba5a992d, 0x00000003, 0xba5a992d
[867156.677444] tg3 0000:00:02.0 eth0: 0x00000570: 0x00000003, 0xba5a992d, 0x00000003, 0xba5a992d
[867156.677452] tg3 0000:00:02.0 eth0: 0x00000580: 0x00000003, 0xba5a992d, 0x00000003, 0xba5a992d
[867156.677459] tg3 0000:00:02.0 eth0: 0x00000590: 0x0c810330, 0x00000400, 0x00003fff, 0x00000000
[867156.677466] tg3 0000:00:02.0 eth0: 0x000005a0: 0x00010000, 0x00000000, 0x00000000, 0x00000000
[867156.677474] tg3 0000:00:02.0 eth0: 0x000005b0: 0x01388400, 0x400000f4, 0x00000000, 0x00000000
[867156.677482] tg3 0000:00:02.0 eth0: 0x00000600: 0xffffffff, 0x00f80051, 0x00000000, 0x00001f04
[867156.677489] tg3 0000:00:02.0 eth0: 0x00000610: 0xffffffff, 0x00000000, 0x07c00304, 0xeec7e000
[867156.677497] tg3 0000:00:02.0 eth0: 0x00000620: 0x00000436, 0x00000000, 0x00000000, 0x00000000
[867156.677506] tg3 0000:00:02.0 eth0: 0x00000c00: 0x00000002, 0x00000000, 0x00000003, 0x00ffffff
[867156.677513] tg3 0000:00:02.0 eth0: 0x00000c10: 0x00000000, 0x0002fd30, 0x00000000, 0x00000000
[867156.677522] tg3 0000:00:02.0 eth0: 0x00001000: 0x00000002, 0x00000000, 0x00000000, 0x00000000
[867156.677531] tg3 0000:00:02.0 eth0: 0x00001400: 0x00000006, 0x00000000, 0x00000000, 0x00000000
[867156.677538] tg3 0000:00:02.0 eth0: 0x00001440: 0x00000004, 0x00000000, 0x00000000, 0x00000000
[867156.677546] tg3 0000:00:02.0 eth0: 0x00001800: 0x00000006, 0x00000000, 0x00000004, 0x00000000
[867156.677555] tg3 0000:00:02.0 eth0: 0x00001c00: 0x00000002, 0x00000000, 0x00000000, 0x00000000
[867156.677564] tg3 0000:00:02.0 eth0: 0x00002000: 0x00000002, 0x00000000, 0x00000000, 0x00000000
[867156.677571] tg3 0000:00:02.0 eth0: 0x00002010: 0x00000181, 0x00000001, 0x007fffff, 0x00000000
[867156.677579] tg3 0000:00:02.0 eth0: 0x00002100: 0x00000000, 0x01cb0129, 0x00000000, 0x00000000
[867156.677587] tg3 0000:00:02.0 eth0: 0x00002400: 0x00000012, 0x00000000, 0x00000000, 0x00000000
[867156.677595] tg3 0000:00:02.0 eth0: 0x00002440: 0x00000000, 0x00000000, 0x00000002, 0x00000000
[867156.677602] tg3 0000:00:02.0 eth0: 0x00002450: 0x00000000, 0xc000a000, 0x06000000, 0x00006000
[867156.677610] tg3 0000:00:02.0 eth0: 0x00002460: 0x00000000, 0x00000000, 0x00000002, 0x00000000
[867156.677617] tg3 0000:00:02.0 eth0: 0x00002470: 0x00000000, 0x000000e1, 0x00000000, 0x00000000
[867156.677625] tg3 0000:00:02.0 eth0: 0x00002480: 0x000002e1, 0x00000000, 0x00000000, 0x00000000
[867156.677633] tg3 0000:00:02.0 eth0: 0x00002800: 0x00000006, 0x00000000, 0x00000000, 0x00000000
[867156.677642] tg3 0000:00:02.0 eth0: 0x00002c00: 0x00000006, 0x00000000, 0x00000000, 0x0000014b
[867156.677649] tg3 0000:00:02.0 eth0: 0x00002c10: 0x00000000, 0x00000000, 0x00000019, 0x0000000c
[867156.677658] tg3 0000:00:02.0 eth0: 0x00003000: 0x00000006, 0x00000000, 0x00000000, 0x0000014b
[867156.677667] tg3 0000:00:02.0 eth0: 0x00003400: 0x00000006, 0x00000000, 0x00000000, 0x00000000
[867156.677675] tg3 0000:00:02.0 eth0: 0x00003800: 0x00000002, 0x00000000, 0x00000000, 0x00000000
[867156.677684] tg3 0000:00:02.0 eth0: 0x00003c00: 0x00000702, 0x00000000, 0x00000014, 0x00000048
[867156.677692] tg3 0000:00:02.0 eth0: 0x00003c10: 0x00000005, 0x00000035, 0x00000014, 0x00000014
[867156.677699] tg3 0000:00:02.0 eth0: 0x00003c20: 0x00000005, 0x00000005, 0x000f4240, 0x00000000
[867156.677707] tg3 0000:00:02.0 eth0: 0x00003c30: 0x00000000, 0xc0004000, 0x00000000, 0xc0006000
[867156.677714] tg3 0000:00:02.0 eth0: 0x00003c40: 0x00000300, 0x00000b00, 0x00000000, 0x00000000
[867156.677722] tg3 0000:00:02.0 eth0: 0x00003c50: 0x00000000, 0x000000e1, 0x00000000, 0x00000000
[867156.677729] tg3 0000:00:02.0 eth0: 0x00003c80: 0x000002e1, 0x00000000, 0x00000000, 0x00000000
[867156.677737] tg3 0000:00:02.0 eth0: 0x00003cc0: 0x00000004, 0x00000000, 0x00000000, 0x00000000
[867156.677744] tg3 0000:00:02.0 eth0: 0x00003cd0: 0x00000004, 0x00000000, 0x00000000, 0x00000000
[867156.677751] tg3 0000:00:02.0 eth0: 0x00003ce0: 0x00000004, 0x00000000, 0x00000000, 0x00000000
[867156.677758] tg3 0000:00:02.0 eth0: 0x00003cf0: 0x00000004, 0x00000000, 0x00000000, 0x00000000
[867156.677767] tg3 0000:00:02.0 eth0: 0x00004000: 0x00000002, 0x00000000, 0x00145da7, 0x000764fb
[867156.677776] tg3 0000:00:02.0 eth0: 0x00004400: 0x00000006, 0x00000000, 0x00008000, 0x00010000
[867156.677784] tg3 0000:00:02.0 eth0: 0x00004410: 0x00000050, 0x00000020, 0x00000060, 0x00000000
[867156.677791] tg3 0000:00:02.0 eth0: 0x00004420: 0x00000000, 0x00000000, 0x00000000, 0x00002000
[867156.677798] tg3 0000:00:02.0 eth0: 0x00004430: 0x00002000, 0x00000005, 0x0000000a, 0x00000000
[867156.677806] tg3 0000:00:02.0 eth0: 0x00004440: 0x00002000, 0x00000000, 0x00002000, 0x00000000
[867156.677813] tg3 0000:00:02.0 eth0: 0x00004450: 0x00fc01fe, 0x01c7024c, 0x00000000, 0x00000000
[867156.677822] tg3 0000:00:02.0 eth0: 0x00004800: 0x000003fe, 0x00000000, 0x00000000, 0x00000000
[867156.677831] tg3 0000:00:02.0 eth0: 0x00004c00: 0x000003fe, 0x00000000, 0x00000000, 0x00000000
[867156.677840] tg3 0000:00:02.0 eth0: 0x00005000: 0x00001840, 0x00440000, 0x00000000, 0x00000000
[867156.677847] tg3 0000:00:02.0 eth0: 0x00005010: 0x00000000, 0x00000000, 0x00000000, 0x4000007c
[867156.677855] tg3 0000:00:02.0 eth0: 0x00005030: 0x00000000, 0x00000001, 0x00000000, 0x00000000
[867156.677863] tg3 0000:00:02.0 eth0: 0x00005400: 0x00000000, 0x00444000, 0x00000000, 0x00000000
[867156.677871] tg3 0000:00:02.0 eth0: 0x00005410: 0x00000000, 0x00000000, 0x00000000, 0x0800010c
[867156.677879] tg3 0000:00:02.0 eth0: 0x00005800: 0x00000000, 0xbd000000, 0x00000000, 0x00000000
[867156.677887] tg3 0000:00:02.0 eth0: 0x00005860: 0x00000000, 0x00000000, 0x00000000, 0x00000194
[867156.677895] tg3 0000:00:02.0 eth0: 0x00005880: 0x00000000, 0x000002cc, 0x00000000, 0x00000000
[867156.677902] tg3 0000:00:02.0 eth0: 0x00005900: 0x00000000, 0x00000004, 0x00000000, 0x00000000
[867156.677911] tg3 0000:00:02.0 eth0: 0x00005c10: 0x00000000, 0x00000000, 0x600024c0, 0x600024c0
[867156.677918] tg3 0000:00:02.0 eth0: 0x00005c20: 0x00000000, 0x00000000, 0x60003a00, 0x60003a00
[867156.677926] tg3 0000:00:02.0 eth0: 0x00005c30: 0x00000000, 0x00000000, 0x60003520, 0x60003520
[867156.677933] tg3 0000:00:02.0 eth0: 0x00005c40: 0x00000000, 0x00000000, 0x60003a00, 0x60003a00
[867156.677941] tg3 0000:00:02.0 eth0: 0x00005c50: 0x00000001, 0x00000000, 0x60004030, 0x60004030
[867156.677948] tg3 0000:00:02.0 eth0: 0x00005c60: 0x00000000, 0x00000000, 0x60003260, 0x60003260
[867156.677956] tg3 0000:00:02.0 eth0: 0x00005c70: 0x00000000, 0x00000000, 0x60003520, 0x60003520
[867156.677963] tg3 0000:00:02.0 eth0: 0x00005c80: 0x00000000, 0x00000000, 0x20000000, 0x20000000
[867156.677971] tg3 0000:00:02.0 eth0: 0x00005c90: 0x00000001, 0x00000000, 0x600024c0, 0x600024c0
[867156.677978] tg3 0000:00:02.0 eth0: 0x00005ca0: 0x00000000, 0x00000000, 0x00002000, 0x00010e11
[867156.677986] tg3 0000:00:02.0 eth0: 0x00005cb0: 0x00000000, 0x00000000, 0x00006000, 0x01e7026e
[867156.677993] tg3 0000:00:02.0 eth0: 0x00005cc0: 0x00000000, 0x00000000, 0x00006000, 0x024c024c
[867156.678001] tg3 0000:00:02.0 eth0: 0x00005cd0: 0x00000000, 0x00000000, 0x60003880, 0x60003880
[867156.678008] tg3 0000:00:02.0 eth0: 0x00005ce0: 0x00000000, 0x00000000, 0x00006000, 0x01cb0129
[867156.678016] tg3 0000:00:02.0 eth0: 0x00005cf0: 0x00000000, 0x00000000, 0x00006000, 0x01cb0129
[867156.678023] tg3 0000:00:02.0 eth0: 0x00005d00: 0x00000000, 0x00000000, 0x60003260, 0x60003260
[867156.678031] tg3 0000:00:02.0 eth0: 0x00005d10: 0x00000000, 0x00000000, 0x00002000, 0x00000000
[867156.678039] tg3 0000:00:02.0 eth0: 0x00006000: 0x00000000, 0x00000000, 0x00000007, 0x00000000
[867156.678048] tg3 0000:00:02.0 eth0: 0x00006400: 0x00000002, 0x00000000, 0x00000000, 0x00000000
[867156.678057] tg3 0000:00:02.0 eth0: 0x00006800: 0x04130036, 0x02209082, 0x01009708, 0xed230e0e
[867156.678064] tg3 0000:00:02.0 eth0: 0x00006810: 0x20800000, 0xffffffff, 0x00000000, 0x00000000
[867156.678072] tg3 0000:00:02.0 eth0: 0x00006820: 0x20000000, 0xffffffff, 0x00000000, 0x00000000
[867156.678079] tg3 0000:00:02.0 eth0: 0x00006830: 0xc00c300f, 0xff000f03, 0x00000000, 0x00000000
[867156.678087] tg3 0000:00:02.0 eth0: 0x00006840: 0x00000024, 0x00000000, 0x00000000, 0x00000000
[867156.678097] tg3 0000:00:02.0 eth0: 0x00007010: 0x00000000, 0x00016200, 0x009f0020, 0xa184a053
[867156.678112] tg3 0000:00:02.0 eth0: 0: Host status block [00000001:000000d3:(0000:00e1:0000):(02e1:0004)]
[867156.678123] tg3 0000:00:02.0 eth0: 0: NAPI info [000000bd:000000bd:(0004:01fc:01ff):02cc:(0194:0000:0000:0000)]
[867156.848407] tg3 0000:00:02.0 eth0: Link is down
[867171.635129]                         [<00000000008a9fe4>] kernel_init+0x4/0x100
[867171.731211]                         [<0000000000406124>] ret_from_fork+0x1c/0x2c
[867171.829575]                         [<          (null)>]           (null)
[867171.919926]      IN-RECLAIM_FS-W at:
[867171.967959]                            [<00000000004b03b0>] lock_acquire+0x50/0x80
[867172.068624]                            [<00000000008b0ae8>] _raw_spin_lock+0x28/0x40
[867172.171565]                            [<0000000000489abc>] __set_cpus_allowed_ptr+0x3c/0x280
[867172.284800]                            [<0000000000489d0c>] set_cpus_allowed_ptr+0xc/0x20
[867172.393459]                            [<00000000005316f4>] kswapd+0x34/0xa00
[867172.488389]                            [<0000000000480ee4>] kthread+0xc4/0xe0
[867172.583324]                            [<0000000000406124>] ret_from_fork+0x1c/0x2c
[867172.685121]                            [<          (null)>]           (null)
[867172.778902]      INITIAL USE at:
[867172.822360]                        [<00000000004b03b0>] lock_acquire+0x50/0x80
[867172.918451]                        [<00000000008b0c40>] _raw_spin_lock_irqsave+0x40/0x60
[867173.025966]                        [<0000000000487144>] rq_attach_root+0x4/0x240
[867173.124331]                        [<0000000000a9b1c8>] sched_init+0x2fc/0x460
[867173.220406]                        [<0000000000a929b4>] start_kernel+0x3a4/0x588
[867173.318773]                        [<0000000000a941c8>] start_early_boot+0x25c/0x26c
[867173.421714]                        [<00000000008a9e38>] tlb_fixup_done+0x54/0x5c
[867173.520078]                        [<          (null)>]           (null)
[867173.609282]    }
[867173.634445]    ... key      at: [<0000000000ae0cc8>] __key.47161+0x0/0x38
[867173.724806]    ... acquired at:
[867173.767124]    [<00000000008b0c40>] _raw_spin_lock_irqsave+0x40/0x60
[867173.851767]    [<00000000008abde0>] __schedule+0x660/0x8c8
[867173.924968]    [<00000000008ac234>] schedule+0x74/0xa0
[867173.993592]    [<00000000008ac5cc>] schedule_preempt_disabled+0xc/0x40
[867174.080523]    [<00000000004a694c>] cpu_startup_entry+0x8c/0x260
[867174.160586]    [<00000000008a9fbc>] rest_init+0x17c/0x1a0
[867174.232641]    [<0000000000a92b88>] start_kernel+0x578/0x588
[867174.308132]    [<0000000000a941c8>] start_early_boot+0x25c/0x26c
[867174.388197]    [<00000000008a9e38>] tlb_fixup_done+0x54/0x5c
[867174.463686]    [<          (null)>]           (null)

[867174.550607]  -> (&(&mm->context.lock)->rlock){......} ops: 31775503790637056 {
[867174.646691]     INITIAL USE at:
[867174.689003]                      [<00000000004b03b0>] lock_acquire+0x50/0x80
[867174.782799]                      [<00000000008b0c40>] _raw_spin_lock_irqsave+0x40/0x60
[867174.888036]                      [<000000000044f180>] tsb_grow+0xe0/0x480
[867174.978385]                      [<000000000044f568>] init_new_context+0x48/0x80
[867175.076756]                      [<000000000045d014>] mm_init+0x134/0x160
[867175.167108]                      [<000000000045d6b4>] mm_alloc+0x34/0x60
[867175.256321]                      [<000000000058f528>] do_execveat_common.isra.33+0x368/0x7a0
[867175.368423]                      [<000000000058f97c>] do_execve+0x1c/0x40
[867175.458771]                      [<0000000000426da0>] run_init_process+0x20/0x40
[867175.557142]                      [<0000000000426dc4>] try_to_run_init_process+0x4/0x40
[867175.662371]                      [<00000000008aa078>] kernel_init+0x98/0x100
[867175.756152]                      [<0000000000406124>] ret_from_fork+0x1c/0x2c
[867175.851094]                      [<          (null)>]           (null)
[867175.938011]   }
[867175.962028]   ... key      at: [<0000000000adb960>] __key.28662+0x0/0x8
[867176.050102]   ... acquired at:
[867176.091278]    [<00000000008b0ae8>] _raw_spin_lock+0x28/0x40
[867176.166767]    [<00000000004511d0>] get_new_mmu_context+0x10/0x140
[867176.249122]    [<000000000058e928>] flush_old_exec+0x428/0x6a0
[867176.326899]    [<00000000005e4b74>] load_elf_binary+0x294/0x11e0
[867176.406961]    [<000000000058e1c0>] search_binary_handler+0x60/0x2a0
[867176.491603]    [<000000000058f7d4>] do_execveat_common.isra.33+0x614/0x7a0
[867176.583105]    [<000000000058f97c>] do_execve+0x1c/0x40
[867176.652872]    [<0000000000426da0>] run_init_process+0x20/0x40
[867176.730650]    [<0000000000426dc4>] try_to_run_init_process+0x4/0x40
[867176.815292]    [<00000000008aa078>] kernel_init+0x98/0x100
[867176.888490]    [<0000000000406124>] ret_from_fork+0x1c/0x2c
[867176.962836]    [<          (null)>]           (null)

[867177.049758] -> (ctx_alloc_lock){+.....} ops: 128398047313920 {
[867177.127532]    HARDIRQ-ON-W at:
[867177.169853]                     [<00000000004b03b0>] lock_acquire+0x50/0x80
[867177.262505]                     [<00000000008b0ae8>] _raw_spin_lock+0x28/0x40
[867177.357446]                     [<00000000004519c4>] hugetlb_setup+0xe4/0x160
[867177.452380]                     [<00000000004504c8>] do_sparc64_fault+0x508/0x7a0
[867177.551890]                     [<0000000000407c90>] sparc64_realfault_common+0x10/0x20
[867177.658261]    INITIAL USE at:
[867177.699423]                    [<00000000004b03b0>] lock_acquire+0x50/0x80
[867177.790931]                    [<00000000008b0ae8>] _raw_spin_lock+0x28/0x40
[867177.884721]                    [<00000000004511d0>] get_new_mmu_context+0x10/0x140
[867177.985381]                    [<000000000058e928>] flush_old_exec+0x428/0x6a0
[867178.081458]                    [<00000000005e4b74>] load_elf_binary+0x294/0x11e0
[867178.179823]                    [<000000000058e1c0>] search_binary_handler+0x60/0x2a0
[867178.282764]                    [<000000000058f7d4>] do_execveat_common.isra.33+0x614/0x7a0
[867178.392568]                    [<000000000058f97c>] do_execve+0x1c/0x40
[867178.480628]                    [<0000000000426da0>] run_init_process+0x20/0x40
[867178.576713]                    [<0000000000426dc4>] try_to_run_init_process+0x4/0x40
[867178.679654]                    [<00000000008aa078>] kernel_init+0x98/0x100
[867178.771148]                    [<0000000000406124>] ret_from_fork+0x1c/0x2c
[867178.863793]                    [<          (null)>]           (null)
[867178.948431]  }
[867178.971303]  ... key      at: [<0000000000a4ab10>] ctx_alloc_lock+0x18/0x48
[867179.063954]  ... acquired at:
[867179.103984]    [<00000000004acee8>] mark_lock+0x4c8/0x860
[867179.176042]    [<00000000004adff0>] __lock_acquire+0x7d0/0x22a0
[867179.254965]    [<00000000004b03b0>] lock_acquire+0x50/0x80
[867179.328166]    [<00000000008b0ae8>] _raw_spin_lock+0x28/0x40
[867179.403657]    [<00000000004519c4>] hugetlb_setup+0xe4/0x160
[867179.479146]    [<00000000004504c8>] do_sparc64_fault+0x508/0x7a0
[867179.559210]    [<0000000000407c90>] sparc64_realfault_common+0x10/0x20

[867179.666720] 
                stack backtrace:
[867179.726216] CPU: 1 PID: 8978 Comm: rsync Tainted: G        W       4.5.0-rc4-00037-g65c23c6 #129
[867179.842884] Call Trace:
[867179.876038]  [00000000004abc2c] print_irq_inversion_bug+0x1ec/0x200
[867179.959541]  [00000000004abe5c] check_usage_backwards+0xfc/0x120
[867180.039604]  [00000000004acee8] mark_lock+0x4c8/0x860
[867180.107086]  [00000000004adff0] __lock_acquire+0x7d0/0x22a0
[867180.181432]  [00000000004b03b0] lock_acquire+0x50/0x80
[867180.250058]  [00000000008b0ae8] _raw_spin_lock+0x28/0x40
[867180.320971]  [00000000004519c4] hugetlb_setup+0xe4/0x160
[867180.391885]  [00000000004504c8] do_sparc64_fault+0x508/0x7a0
[867180.467377]  [0000000000407c90] sparc64_realfault_common+0x10/0x20
[867180.551254] tg3 0000:00:02.0 eth0: Link is up at 100 Mbps, full duplex
[867180.638261] tg3 0000:00:02.0 eth0: Flow control is off for TX and off for RX


-- 
Meelis Roos (mroos@linux.ee)
