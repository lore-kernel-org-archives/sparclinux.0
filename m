From: Meelis Roos <mroos@linux.ee>
Date: Mon, 23 May 2016 19:07:12 +0000
Subject: newest 4.6.0-08907-g7639dad on sparc64 - possible irq lock inversion dependency detected
Message-Id: <alpine.LRH.2.20.1605231407020.15124@math.ut.ee>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

I tested todays 4.6.0-08907-g7639dad on most of my sparc64 computers, 
from Ultra 1 to T5120, doing local git clone + rm -rf to the cloned 
tree. All computers were fine except my V240 whete I have turned on some 
additional debugging options to catch a spontaneous reboot. On the V240, 
I get a "possible irq lock inversion dependency detected" warning 
(below, in the full dmesg).

This may or may not be related to the current changes - I rememeber 
having seen and reported another lockdep issue in the past but can't 
find the sent mail right now.


[    0.000000] PROMLIB: Sun IEEE Boot Prom 'OBP 4.30.4.a 2010/01/06 14:48'
[    0.000000] PROMLIB: Root node compatible: 
[    0.000000] Linux version 4.6.0-08907-g7639dad (mroos@v240) (gcc version 4.9.3 (Debian 4.9.3-2) ) #6 SMP Mon May 23 11:30:51 EEST 2016
[    0.000000] debug: ignoring loglevel setting.
[    0.000000] bootconsole [earlyprom0] enabled
[    0.000000] ARCH: SUN4U
[    0.000000] Ethernet address: 00:03:ba:5a:99:2d
[    0.000000] MM: PAGE_OFFSET is 0xfff0000000000000 (max_phys_bits = 42)
[    0.000000] MM: VMALLOC [0x0000000100000000 --> 0x000c000000000000]
[    0.000000] MM: VMEMMAP [0x000c000000000000 --> 0x0018000000000000]
[    0.000000] Kernel: Using 6 locked TLB entries for main kernel image.
[    0.000000] Remapping the kernel... done.
[    0.000000] kmemleak: Kernel memory leak detector disabled
[    0.000000] OF stdout device is: /pci@1e,600000/isa@7/serial@0,3f8
[    0.000000] PROM: Built device tree with 138973 bytes of memory.
[    0.000000] Top of RAM: 0x133feb8000, Total RAM: 0x17fe92000
[    0.000000] Memory hole size: 72704MB
[    0.000000] Allocated 40960 bytes for kernel page tables.
[    0.000000] Zone ranges:
[    0.000000]   Normal   [mem 0x0000000000000000-0x000000133feb7fff]
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
[    0.000000]   node   0: [mem 0x000000133feb2000-0x000000133feb7fff]
[    0.000000] Initmem setup node 0 [mem 0x0000000000000000-0x000000133feb7fff]
[    0.000000] On node 0 totalpages: 786249
[    0.000000]   Normal zone: 6911 pages used for memmap
[    0.000000]   Normal zone: 0 pages reserved
[    0.000000]   Normal zone: 786249 pages, LIFO batch:15
[    0.000000] Booting Linux...
[    0.000000] CPU CAPS: [flush,stbar,swap,muldiv,v9,ultra3,mul32,div32]
[    0.000000] CPU CAPS: [v8plus,vis,vis2]
[    0.000000] percpu: Embedded 9 pages/cpu @fff000133f800000 s35584 r8192 d29952 u2097152
[    0.000000] pcpu-alloc: s35584 r8192 d29952 u2097152 alloc=1*4194304
[    0.000000] pcpu-alloc: [0] 0 1 
[    0.000000] Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 779338
[    0.000000] Kernel command line: root=/dev/sda2 ro ignore_loglevel
[    0.000000] PID hash table entries: 4096 (order: 2, 32768 bytes)
[    0.000000] Dentry cache hash table entries: 1048576 (order: 10, 8388608 bytes)
[    0.000000] Inode-cache hash table entries: 524288 (order: 9, 4194304 bytes)
[    0.000000] Sorting __ex_table...
[    0.000000] Memory: 6157720K/6289992K available (5202K kernel code, 379K rwdata, 1440K rodata, 304K init, 13408K bss, 132272K reserved, 0K cma-reserved)
[    0.000000] Running RCU self tests
[    0.000000] Hierarchical RCU implementation.
[    0.000000] 	RCU lockdep checking is enabled.
[    0.000000] 	Build-time adjustment of leaf fanout to 64.
[    0.000000] NR_IRQS:2048 nr_irqs:2048 1
[   38.864048] clocksource: stick: mask: 0xffffffffffffffff max_cycles: 0x2c47f4ee7, max_idle_ns: 440795202497 ns
[   38.983748] clocksource: mult[53555555] shift[24]
[   39.039993] clockevent: mult[3126e98] shift[32]
[   39.094922] Console: colour dummy device 80x25
[   39.148239] console [tty0] enabled
[   39.188902] bootconsole [earlyprom0] disabled
[   39.241104] Lock dependency validator: Copyright (c) 2006 Red Hat, Inc., Ingo Molnar
[   39.241129] ... MAX_LOCKDEP_SUBCLASSES:  8
[   39.241145] ... MAX_LOCK_DEPTH:          48
[   39.241161] ... MAX_LOCKDEP_KEYS:        8191
[   39.241177] ... CLASSHASH_SIZE:          4096
[   39.241192] ... MAX_LOCKDEP_ENTRIES:     32768
[   39.241208] ... MAX_LOCKDEP_CHAINS:      65536
[   39.241224] ... CHAINHASH_SIZE:          32768
[   39.241241]  memory used by lock dependency info: 8159 kB
[   39.241259]  per task-struct memory footprint: 1920 bytes
[   39.241365] kmemleak: Early log buffer exceeded (2146), please increase DEBUG_KMEMLEAK_EARLY_LOG_SIZE
[   39.321300] Calibrating delay using timer specific routine.. 24.09 BogoMIPS (lpjH190)
[   39.321334] pid_max: default: 32768 minimum: 301
[   39.321748] Security Framework initialized
[   39.321904] Mount-cache hash table entries: 16384 (order: 4, 131072 bytes)
[   39.321937] Mountpoint-cache hash table entries: 16384 (order: 4, 131072 bytes)
[   39.332878] CPU 0: synchronized TICK with master CPU (last diff -1 cycles, maxerr 6 cycles)
[   39.333485] Brought up 2 CPUs
[   39.347020] devtmpfs: initialized
[   39.363576] Performance events: 
[   39.363618] Testing NMI watchdog ... 
[   39.443654] OK.
[   39.443674] Supported PMU type is 'ultra3i'
[   39.478753] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 7645041785100000 ns
[   39.490284] prandom: seed boundary self test passed
[   39.493421] prandom: 100 self tests passed
[   39.515546] NET: Registered protocol family 16
[   39.521684] IRQ pre handler NOT supported.
[   39.521744] IRQ pre handler NOT supported.
[   39.521790] IRQ pre handler NOT supported.
[   39.521839] IRQ pre handler NOT supported.
[   39.521882] IRQ pre handler NOT supported.
[   39.522226] IRQ pre handler NOT supported.
[   39.522611] IRQ pre handler NOT supported.
[   39.522984] IRQ pre handler NOT supported.
[   39.523030] IRQ pre handler NOT supported.
[   39.523074] IRQ pre handler NOT supported.
[   39.523117] IRQ pre handler NOT supported.
[   39.523160] IRQ pre handler NOT supported.
[   39.524297] IRQ pre handler NOT supported.
[   39.530400] IRQ pre handler NOT supported.
[   39.530744] IRQ pre handler NOT supported.
[   39.531055] IRQ pre handler NOT supported.
[   39.531358] IRQ pre handler NOT supported.
[   39.531980] IRQ pre handler NOT supported.
[   39.532561] IRQ pre handler NOT supported.
[   39.532925] IRQ pre handler NOT supported.
[   39.533763] IRQ pre handler NOT supported.
[   39.534083] IRQ pre handler NOT supported.
[   39.534129] IRQ pre handler NOT supported.
[   39.534173] IRQ pre handler NOT supported.
[   39.534215] IRQ pre handler NOT supported.
[   39.534258] IRQ pre handler NOT supported.
[   39.534643] IRQ pre handler NOT supported.
[   39.535504] IRQ pre handler NOT supported.
[   39.536333] IRQ pre handler NOT supported.
[   39.536379] IRQ pre handler NOT supported.
[   39.536422] IRQ pre handler NOT supported.
[   39.536471] IRQ pre handler NOT supported.
[   39.536514] IRQ pre handler NOT supported.
[   39.536848] IRQ pre handler NOT supported.
[   39.537190] IRQ pre handler NOT supported.
[   39.540451] /pci@1f,700000: TOMATILLO PCI Bus Module ver[4:0]
[   39.540498] /pci@1f,700000: PCI IO[7f601000000] MEM[7f700000000] MEM64[7f700000000]
[   39.542654] PCI: Scanning PBM /pci@1f,700000
[   39.543314] schizo f0069c00: PCI host bridge to bus 0000:00
[   39.543361] pci_bus 0000:00: root bus resource [io  0x7f601000000-0x7f601ffffff] (bus address [0x0000-0xffffff])
[   39.543417] pci_bus 0000:00: root bus resource [mem 0x7f700000000-0x7f7ffffffff] (bus address [0x00000000-0xffffffff])
[   39.543473] pci_bus 0000:00: root bus resource [mem 0x7f700000000-0x7f7ffffffff] (bus address [0x00000000-0xffffffff])
[   39.543532] pci_bus 0000:00: root bus resource [bus 00]
[   39.543872] pci 0000:00:02.0: PME# supported from D3hot
[   39.544819] pci 0000:00:02.1: PME# supported from D3hot
[   39.546244] /pci@1e,600000: TOMATILLO PCI Bus Module ver[4:0]
[   39.546286] /pci@1e,600000: PCI IO[7fe01000000] MEM[7ff00000000] MEM64[7ff00000000]
[   39.548374] PCI: Scanning PBM /pci@1e,600000
[   39.548963] schizo f00732d0: PCI host bridge to bus 0001:00
[   39.549007] pci_bus 0001:00: root bus resource [io  0x7fe01000000-0x7fe01ffffff] (bus address [0x0000-0xffffff])
[   39.549063] pci_bus 0001:00: root bus resource [mem 0x7ff00000000-0x7ffffffffff] (bus address [0x00000000-0xffffffff])
[   39.549118] pci_bus 0001:00: root bus resource [mem 0x7ff00000000-0x7ffffffffff] (bus address [0x00000000-0xffffffff])
[   39.549175] pci_bus 0001:00: root bus resource [bus 00]
[   39.550039] pci 0001:00:06.0: quirk: [io  0x7fe01000800-0x7fe0100083f] claimed by ali7101 ACPI
[   39.550097] pci 0001:00:06.0: quirk: [io  0x7fe01000600-0x7fe0100061f] claimed by ali7101 SMB
[   39.550939] pci 0001:00:0a.0: PME# supported from D3cold
[   39.553141] pci 0001:00:07.0: can't claim BAR 0 [io  0x7fe01000000-0x7fe0100ffff]: address conflict with 0001:00:06.0 [io  0x7fe01000600-0x7fe0100061f]
[   39.553210] pci 0001:00:07.0: can't claim BAR 1 [mem 0x7ff00000000-0x7ff000fffff]: address conflict with Video RAM area [??? 0x7ff000a0000-0x7ff000bffff flags 0x80000000]
[   39.553286] pci 0001:00:07.0: can't claim BAR 2 [mem 0x7ff00000000-0x7ff000fffff]: address conflict with Video RAM area [??? 0x7ff000a0000-0x7ff000bffff flags 0x80000000]
[   39.553898] /pci@1c,600000: TOMATILLO PCI Bus Module ver[4:0]
[   39.553938] /pci@1c,600000: PCI IO[7ce01000000] MEM[7cf00000000] MEM64[7cf00000000]
[   39.556048] PCI: Scanning PBM /pci@1c,600000
[   39.556631] schizo f007c6ac: PCI host bridge to bus 0002:00
[   39.556675] pci_bus 0002:00: root bus resource [io  0x7ce01000000-0x7ce01ffffff] (bus address [0x0000-0xffffff])
[   39.556731] pci_bus 0002:00: root bus resource [mem 0x7cf00000000-0x7cfffffffff] (bus address [0x00000000-0xffffffff])
[   39.556787] pci_bus 0002:00: root bus resource [mem 0x7cf00000000-0x7cfffffffff] (bus address [0x00000000-0xffffffff])
[   39.556844] pci_bus 0002:00: root bus resource [bus 00]
[   39.557109] pci 0002:00:02.0: supports D1 D2
[   39.557869] pci 0002:00:02.1: supports D1 D2
[   39.559162] /pci@1d,700000: TOMATILLO PCI Bus Module ver[4:0]
[   39.559205] /pci@1d,700000: PCI IO[7c601000000] MEM[7c700000000] MEM64[7c700000000]
[   39.561271] PCI: Scanning PBM /pci@1d,700000
[   39.561873] schizo f00859d4: PCI host bridge to bus 0003:00
[   39.561920] pci_bus 0003:00: root bus resource [io  0x7c601000000-0x7c601ffffff] (bus address [0x0000-0xffffff])
[   39.561976] pci_bus 0003:00: root bus resource [mem 0x7c700000000-0x7c7ffffffff] (bus address [0x00000000-0xffffffff])
[   39.562031] pci_bus 0003:00: root bus resource [mem 0x7c700000000-0x7c7ffffffff] (bus address [0x00000000-0xffffffff])
[   39.562090] pci_bus 0003:00: root bus resource [bus 00]
[   39.562416] pci 0003:00:02.0: PME# supported from D3hot
[   39.563464] pci 0003:00:02.1: PME# supported from D3hot
[   39.588318] HugeTLB registered 8 MB page size, pre-allocated 0 pages
[   39.648073] vgaarb: loaded
[   39.655835] SCSI subsystem initialized
[   39.658962] /pci@1e,600000/isa@7/rtc@0,70: RTC regs at 0x7fe01000070
[   39.661284] clocksource: Switched to clocksource stick
[   39.793296] NET: Registered protocol family 2
[   39.837547] TCP established hash table entries: 65536 (order: 6, 524288 bytes)
[   39.839483] TCP bind hash table entries: 65536 (order: 9, 4194304 bytes)
[   39.858791] TCP: Hash tables configured (established 65536 bind 65536)
[   39.859549] UDP hash table entries: 4096 (order: 6, 655360 bytes)
[   39.862640] UDP-Lite hash table entries: 4096 (order: 6, 655360 bytes)
[   39.905289] NET: Registered protocol family 1
[   39.905489] pci 0001:00:07.0: Activating ISA DMA hang workarounds
[   39.905569] PCI: Enabling device: (0001:00:0a.0), cmd 2
[   39.961386] PCI: CLS 64 bytes, default 64
[   39.962199] power: Control reg at 7fe01000800
[   39.963465] chmc: UltraSPARC-IIIi memory controller at /memory-controller@0,0
[   39.963590] chmc: UltraSPARC-IIIi memory controller at /memory-controller@1,0
[   39.966180] futex hash table entries: 512 (order: 3, 65536 bytes)
[   39.978992] workingset: timestamp_bitsE max_order  bucket_order=0
[   40.170233] cryptomgr_test (33) used greatest stack depth: 10344 bytes left
[   40.170314] cryptomgr_test (34) used greatest stack depth: 10016 bytes left
[   40.173341] cryptomgr_test (45) used greatest stack depth: 8544 bytes left
[   40.189375] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 252)
[   40.189846] io scheduler noop registered
[   40.213274] io scheduler cfq registered (default)
[   40.213304] start plist test
[   40.221334] end plist test
[   40.274991] f00ac5a0: ttyS0 at MMIO 0x7fe010003f8 (irq = 15, base_baud = 115387) is a 16550A
[   40.275069] Console: ttyS0 (SU)
[   55.051785] console [ttyS0] enabled
[   55.099119] f00ae120: ttyS1 at MMIO 0x7fe010002e8 (irq = 15, base_baud = 115387) is a 16550A
[   55.212840] PCI: Enabling device: (0002:00:02.0), cmd 147
[   55.284800] sym0: <1010-66> rev 0x1 at pci 0002:00:02.0 irq 25
[   55.364396] sym0: No NVRAM, ID 7, Fast-80, LVD, parity checking
[   55.483162] sym0: SCSI BUS has been reset.
[   55.536978] scsi host0: sym-2.2.3
[   55.584239] PCI: Enabling device: (0002:00:02.1), cmd 147
[   55.656197] sym1: <1010-66> rev 0x1 at pci 0002:00:02.1 irq 26
[   55.735531] sym1: No NVRAM, ID 7, Fast-80, LVD, parity checking
[   55.854292] sym1: SCSI BUS has been reset.
[   55.908153] scsi host1: sym-2.2.3
[   55.957861] rtc_cmos rtc_cmos: rtc core: registered rtc_cmos as rtc0
[   56.041540] rtc_cmos rtc_cmos: no alarms, 114 bytes nvram
[   56.209327] NET: Registered protocol family 10
[   56.270196] NET: Registered protocol family 17
[   56.328996] Key type dns_resolver registered
[   56.386988] registered taskstats version 1
[   56.445132] Key type encrypted registered
[   56.499619] rtc_cmos rtc_cmos: setting system clock to 2016-05-23 14:13:37 UTC (1464012817)
[   58.610604] scsi 0:0:0:0: Direct-Access     SEAGATE  ST373307LSUN72G  0507 PQ: 0 ANSI: 3
[   58.717118] scsi target0:0:0: tagged command queuing enabled, command queue depth 16.
[   58.820230] scsi target0:0:0: Beginning Domain Validation
[   58.896497] scsi target0:0:0: FAST-80 WIDE SCSI 160.0 MB/s DT (12.5 ns, offset 31)
[   59.002404] scsi target0:0:0: Ending Domain Validation
[   59.072400] scsi 0:0:1:0: Direct-Access     SEAGATE  ST336607LSUN36G  0307 PQ: 0 ANSI: 3
[   59.178871] scsi target0:0:1: tagged command queuing enabled, command queue depth 16.
[   59.281933] scsi target0:0:1: Beginning Domain Validation
[   59.358170] scsi target0:0:1: FAST-80 WIDE SCSI 160.0 MB/s DT (12.5 ns, offset 31)
[   59.464056] scsi target0:0:1: Ending Domain Validation
[   59.533655] scsi 0:0:2:0: Direct-Access     SEAGATE  ST336607LSUN36G  0507 PQ: 0 ANSI: 3
[   59.640125] scsi target0:0:2: tagged command queuing enabled, command queue depth 16.
[   59.744439] scsi target0:0:2: Beginning Domain Validation
[   59.820936] scsi target0:0:2: FAST-80 WIDE SCSI 160.0 MB/s DT (12.5 ns, offset 31)
[   59.927039] scsi target0:0:2: Ending Domain Validation
[   59.996959] scsi 0:0:3:0: Direct-Access     SEAGATE  ST336607LSUN36G  0507 PQ: 0 ANSI: 3
[   60.103501] scsi target0:0:3: tagged command queuing enabled, command queue depth 16.
[   60.206620] scsi target0:0:3: Beginning Domain Validation
[   60.282887] scsi target0:0:3: FAST-80 WIDE SCSI 160.0 MB/s DT (12.5 ns, offset 31)
[   60.388991] scsi target0:0:3: Ending Domain Validation
[   63.704279] sd 0:0:0:0: [sda] 143374738 512-byte logical blocks: (73.4 GB/68.4 GiB)
[   63.805560] sd 0:0:1:0: [sdb] 71132959 512-byte logical blocks: (36.4 GB/33.9 GiB)
[   63.806278] sd 0:0:2:0: [sdc] 71132959 512-byte logical blocks: (36.4 GB/33.9 GiB)
[   63.806746] sd 0:0:0:0: [sda] Write Protect is off
[   63.806756] sd 0:0:0:0: [sda] Mode Sense: db 00 10 08
[   63.807549] sd 0:0:3:0: [sdd] 71132959 512-byte logical blocks: (36.4 GB/33.9 GiB)
[   63.807969] sd 0:0:2:0: [sdc] Write Protect is off
[   63.807978] sd 0:0:2:0: [sdc] Mode Sense: db 00 10 08
[   63.809033] sd 0:0:0:0: [sda] Write cache: disabled, read cache: enabled, supports DPO and FUA
[   63.809250] sd 0:0:3:0: [sdd] Write Protect is off
[   63.809259] sd 0:0:3:0: [sdd] Mode Sense: db 00 10 08
[   63.811419] sd 0:0:2:0: [sdc] Write cache: disabled, read cache: enabled, supports DPO and FUA
[   63.813329] sd 0:0:3:0: [sdd] Write cache: disabled, read cache: enabled, supports DPO and FUA
[   64.022595]  sdc: sdc1 sdc3
[   64.024321]  sdd: sdd1 sdd3
[   64.025054]  sda: sda1 sda2 sda3 sda4
[   64.036649] sd 0:0:3:0: [sdd] Attached SCSI disk
[   64.036881] sd 0:0:2:0: [sdc] Attached SCSI disk
[   64.038892] sd 0:0:0:0: [sda] Attached SCSI disk
[   65.137614] sd 0:0:1:0: [sdb] Write Protect is off
[   65.200610] sd 0:0:1:0: [sdb] Mode Sense: db 00 10 08
[   65.269201] sd 0:0:1:0: [sdb] Write cache: disabled, read cache: enabled, supports DPO and FUA
[   65.401560]  sdb: sdb1 sdb2 sdb3 sdb4
[   65.458640] sd 0:0:1:0: [sdb] Attached SCSI disk
[   65.527994] EXT4-fs (sda2): couldn't mount as ext3 due to feature incompatibilities
[   65.629886] EXT4-fs (sda2): couldn't mount as ext2 due to feature incompatibilities
[   65.789504] EXT4-fs (sda2): mounted filesystem with ordered data mode. Opts: (null)
[   65.890358] VFS: Mounted root (ext4 filesystem) readonly on device 8:2.
[   66.002080] devtmpfs: mounted
[   66.041760] This architecture does not have kernel memory protection.
[   66.706648] stty (109) used greatest stack depth: 7024 bytes left
[   66.926071] tput (113) used greatest stack depth: 3632 bytes left
[   67.947726] random: udevd urandom read with 21 bits of entropy available
[   68.606267] pps_core: LinuxPPS API ver. 1 registered
[   68.675416] pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rodolfo Giometti <giometti@linux.it>
[   68.808653] PTP clock support registered
[   68.888078] tg3.c:v3.137 (May 11, 2014)
[   68.942989] PCI: Enabling device: (0000:00:02.0), cmd 2
[   69.120040] alim7101_wdt: Steve Hill <steve@navaho.co.uk>
[   69.187707] tg3 0000:00:02.0 (unnamed net_device) (uninitialized): Cannot get nvram lock, tg3_nvram_init failed
[   69.195137] PCI: Enabling device: (0001:00:03.0), cmd 3
[   69.195227] skge: 1.14 addr 0x7ff00100000 irq 19 chip Genesis rev 0
[   69.198206] skge 0001:00:03.0 eth0: addr 00:00:5a:9a:43:58
[   69.202047] sd 0:0:0:0: Attached scsi generic sg0 type 0
[   69.202906] sd 0:0:1:0: Attached scsi generic sg1 type 0
[   69.203420] sd 0:0:2:0: Attached scsi generic sg2 type 0
[   69.203902] sd 0:0:3:0: Attached scsi generic sg3 type 0
[   69.216647] PCI: Enabling device: (0001:00:06.0), cmd 1
[   69.529502] tg3 0000:00:02.0 eth1: Tigon3 [partno(none) rev 2003] (PCI:66MHz:64-bit) MAC address 00:03:ba:5a:99:2d
[   69.529511] tg3 0000:00:02.0 eth1: attached PHY is 5704 (10/100/1000Base-T Ethernet) (WireSpeed[1], EEE[0])
[   69.529519] tg3 0000:00:02.0 eth1: RXcsums[1] LinkChgREG[0] MIirq[0] ASF[0] TSOcap[1]
[   69.529526] tg3 0000:00:02.0 eth1: dma_rwctrl[763f0000] dma_mask[32-bit]
[   69.529689] PCI: Enabling device: (0000:00:02.1), cmd 2
[   69.893431] tg3 0000:00:02.1 (unnamed net_device) (uninitialized): Cannot get nvram lock, tg3_nvram_init failed
[   70.235095] tg3 0000:00:02.1 eth2: Tigon3 [partno(none) rev 2003] (PCI:66MHz:64-bit) MAC address 00:03:ba:5a:99:2e
[   70.235104] tg3 0000:00:02.1 eth2: attached PHY is 5704 (10/100/1000Base-T Ethernet) (WireSpeed[1], EEE[0])
[   70.235112] tg3 0000:00:02.1 eth2: RXcsums[1] LinkChgREG[0] MIirq[0] ASF[0] TSOcap[1]
[   70.235120] tg3 0000:00:02.1 eth2: dma_rwctrl[763f0000] dma_mask[32-bit]
[   70.235440] PCI: Enabling device: (0003:00:02.0), cmd 2
[   70.313717] skge 0001:00:03.0 eth4: renamed from eth0
[   70.480158] tg3 0003:00:02.0 (unnamed net_device) (uninitialized): Cannot get nvram lock, tg3_nvram_init failed
[   70.863548] tg3 0003:00:02.0 eth0: Tigon3 [partno(none) rev 2003] (PCI:66MHz:64-bit) MAC address 00:03:ba:5a:99:2f
[   70.863558] tg3 0003:00:02.0 eth0: attached PHY is 5704 (10/100/1000Base-T Ethernet) (WireSpeed[1], EEE[0])
[   70.863566] tg3 0003:00:02.0 eth0: RXcsums[1] LinkChgREG[0] MIirq[0] ASF[0] TSOcap[1]
[   70.863573] tg3 0003:00:02.0 eth0: dma_rwctrl[763f0000] dma_mask[32-bit]
[   70.863767] PCI: Enabling device: (0003:00:02.1), cmd 2
[   71.134735] tg3 0003:00:02.1 (unnamed net_device) (uninitialized): Cannot get nvram lock, tg3_nvram_init failed
[   71.476179] tg3 0003:00:02.1 eth3: Tigon3 [partno(none) rev 2003] (PCI:66MHz:64-bit) MAC address 00:03:ba:5a:99:30
[   71.476189] tg3 0003:00:02.1 eth3: attached PHY is 5704 (10/100/1000Base-T Ethernet) (WireSpeed[1], EEE[0])
[   71.476196] tg3 0003:00:02.1 eth3: RXcsums[1] LinkChgREG[0] MIirq[0] ASF[0] TSOcap[1]
[   71.476203] tg3 0003:00:02.1 eth3: dma_rwctrl[763f0000] dma_mask[32-bit]
[   71.522396] tg3 0000:00:02.1 rename4: renamed from eth2
[   71.934047] tg3 0000:00:02.0 rename3: renamed from eth1
[   72.370583] tg3 0003:00:02.0 eth2: renamed from eth0
[   72.703663] tg3 0000:00:02.1 eth1: renamed from rename4
[   72.829805] alim7101_wdt: Detected old alim7101 revision 'a1d'.  If this is a cobalt board, set the 'use_gpio' module parameter.
[   72.994825] tg3 0000:00:02.0 eth0: renamed from rename3
[   73.108835] alim7101_wdt: Steve Hill <steve@navaho.co.uk>
[   73.180307] alim7101_wdt: Detected old alim7101 revision 'a1d'.  If this is a cobalt board, set the 'use_gpio' module parameter.
[   74.038584] Adding 3084472k swap on /dev/sda4.  Priority:-1 extents:1 across:3084472k 
[   74.276174] EXT4-fs (sda2): re-mounted. Opts: (null)
[   74.579559] EXT4-fs (sda2): re-mounted. Opts: errors=remount-ro
[   76.059004] loop: module loaded
[   76.331013] EXT4-fs (sda1): mounting ext2 file system using the ext4 subsystem
[   76.453893] EXT4-fs (sda1): mounted filesystem without journal. Opts: (null)
[   79.510933] tg3 0000:00:02.0 eth0: No firmware running
[   79.983753] IPv6: ADDRCONF(NETDEV_UP): eth0: link is not ready
[   80.061802] ip (910) used greatest stack depth: 2344 bytes left
[   81.532169] tg3 0000:00:02.0 eth0: Link is up at 100 Mbps, full duplex
[   81.618034] tg3 0000:00:02.0 eth0: Flow control is off for TX and off for RX
[   81.711123] IPv6: ADDRCONF(NETDEV_CHANGE): eth0: link becomes ready
[  147.350670] random: nonblocking pool is initialized

[  176.659456] ============================[  176.744087] [ INFO: possible irq lock inversion dependency detected ]
[  176.828729] 4.6.0-08907-g7639dad #6 Not tainted
[  176.888198] ---------------------------------------------------------
[  176.972842] git/1562 just changed the state of lock:
[  177.038035]  (ctx_alloc_lock){+.....}, at: [<0000000000451a44>] hugetlb_setup+0xe4/0x160
[  177.144412] but this lock was taken by another, HARDIRQ-safe lock in the past:
[  177.239348]  (&rq->lock){-.-.-.}
               
               and interrupts could create inverse lock ordering between them.

[  177.360601] 
               other info that might help us debug this:
[  177.446475] Chain exists of:
                 &rq->lock --> &(&mm->context.lock)->rlock --> ctx_alloc_lock

[  177.559695]  Possible interrupt unsafe locking scenario:

[  177.648925]        CPU0                    CPU1
[  177.708389]        ----                    ----
[  177.767865]   lock(ctx_alloc_lock);
[  177.813607]                                local_irq_disable();
[  177.891397]                                lock(&rq->lock);
[  177.964586]                                lock(&(&mm->context.lock)->rlock);
[  178.058376]   <Interrupt>
[  178.092693]     lock(&rq->lock);
[  178.135008] 
                *** DEADLOCK ***

[  178.212813] no locks held by git/1562.
[  178.261977] 
               the shortest dependencies between 2nd lock and 1st lock:
[  178.364933]   -> (&rq->lock){-.-.-.} ops: 729036338757632 {
[  178.438110]      IN-HARDIRQ-W at:
[  178.481575]                         [<00000000004b2330>] lock_acquire+0x50/0x80
[  178.577666]                         [<0000000000917f88>] _raw_spin_lock+0x28/0x40
[  178.676032]                         [<000000000048ce90>] scheduler_tick+0x30/0xe0
[  178.774396]                         [<00000000004d2e48>] update_process_times+0x48/0x60
[  178.879625]                         [<00000000004e0a9c>] tick_periodic+0xbc/0xe0
[  178.976844]                         [<00000000004e0acc>] tick_handle_periodic+0xc/0xa0
[  179.080929]                         [<0000000000430034>] timer_interrupt+0x94/0xc0
[  179.180437]                         [<0000000000426bf4>] sys_call_table+0x654/0x7e0
[  179.281090]                         [<00000000004c1b9c>] console_unlock+0x4bc/0x620
[  179.381741]                         [<0000000000b02c2c>] con_init+0x260/0x280
[  179.475523]                         [<0000000000b022ac>] console_init+0x1c/0x38
[  179.571609]                         [<0000000000aea91c>] start_kernel+0x30c/0x414
[  179.669974]                         [<0000000000aec084>] start_early_boot+0x274/0x284
[  179.772914]                         [<0000000000910e08>] tlb_fixup_done+0x4c/0x64
[  179.871279]                         [<          (null)>]           (null)
[  179.960486]      IN-SOFTIRQ-W at:
[  180.003943]                         [<00000000004b2330>] lock_acquire+0x50/0x80
[  180.100034]                         [<00000000009180e0>] _raw_spin_lock_irqsave+0x40/0x60
[  180.207550]                         [<00000000004950c8>] update_blocked_averages+0x28/0x660
[  180.317352]                         [<000000000049fba4>] rebalance_domains+0x24/0x400
[  180.420291]                         [<00000000004a01a8>] run_rebalance_domains+0x228/0x240
[  180.528952]                         [<00000000004659e8>] __do_softirq+0xe8/0x240
[  180.626173]                         [<000000000042be4c>] do_softirq_own_stack+0x2c/0x40
[  180.731399]                         [<0000000000465e28>] irq_exit+0x48/0xc0
[  180.822894]                         [<000000000043003c>] timer_interrupt+0x9c/0xc0
[  180.922409]                         [<0000000000426bf4>] sys_call_table+0x654/0x7e0
[  181.023063]                         [<000000000042c5ac>] arch_cpu_idle+0x2c/0x100
[  181.121426]                         [<00000000004a8d94>] default_idle_call+0x34/0x60
[  181.223224]                         [<00000000004a8f74>] cpu_startup_entry+0x1b4/0x240
[  181.327308]                         [<000000000043e6e0>] smp_callin+0x180/0x1a0
[  181.423383]                         [<0000000000a9d544>] after_lock_tlb+0x1a8/0x1bc
[  181.524036]                         [<0000000040000000>] 0x40000000
[  181.606380]      IN-RECLAIM_FS-W at:
[  181.653269]                            [<00000000004b2330>] lock_acquire+0x50/0x80
[  181.752792]                            [<0000000000917f88>] _raw_spin_lock+0x28/0x40
[  181.854587]                            [<00000000004890bc>] task_rq_lock+0x3c/0xe0
[  181.954096]                            [<000000000048ade8>] __set_cpus_allowed_ptr+0x8/0x260
[  182.065045]                            [<000000000048b04c>] set_cpus_allowed_ptr+0xc/0x20
[  182.172560]                            [<00000000005397d0>] kswapd+0x30/0x880
[  182.266339]                            [<00000000004823a4>] kthread+0xc4/0xe0
[  182.360130]                            [<00000000004060e4>] ret_from_fork+0x1c/0x2c
[  182.460789]                            [<          (null)>]           (null)
[  182.553428]      INITIAL USE at:
[  182.595740]                        [<00000000004b2330>] lock_acquire+0x50/0x80
[  182.690688]                        [<00000000009180e0>] _raw_spin_lock_irqsave+0x40/0x60
[  182.797062]                        [<0000000000488464>] rq_attach_root+0x4/0x240
[  182.894280]                        [<0000000000af33c4>] sched_init+0x2f8/0x494
[  182.989214]                        [<0000000000aea838>] start_kernel+0x228/0x414
[  183.086435]                        [<0000000000aec084>] start_early_boot+0x274/0x284
[  183.188234]                        [<0000000000910e08>] tlb_fixup_done+0x4c/0x64
[  183.285454]                        [<          (null)>]           (null)
[  183.373516]    }
[  183.397533]    ... key      at: [<0000000000b3cd08>] __key.48021+0x0/0x38
[  183.486750]    ... acquired at:
[  183.527924]    [<00000000009180e0>] _raw_spin_lock_irqsave+0x40/0x60
[  183.611423]    [<00000000009130ac>] __schedule+0x64c/0x894
[  183.683480]    [<0000000000913574>] schedule+0x74/0xa0
[  183.750961]    [<000000000091390c>] schedule_preempt_disabled+0xc/0x40
[  183.836748]    [<00000000004a8e4c>] cpu_startup_entry+0x8c/0x240
[  183.915668]    [<0000000000910f94>] rest_init+0x174/0x1a0
[  183.986581]    [<0000000000aeaa14>] start_kernel+0x404/0x414
[  184.060926]    [<0000000000aec084>] start_early_boot+0x274/0x284
[  184.139849]    [<0000000000910e08>] tlb_fixup_done+0x4c/0x64
[  184.214193]    [<          (null)>]           (null)

[  184.298828]  -> (&(&mm->context.lock)->rlock){......} ops: 1510999559503872 {
[  184.392615]     INITIAL USE at:
[  184.433791]                      [<00000000004b2330>] lock_acquire+0x50/0x80
[  184.526445]                      [<00000000009180e0>] _raw_spin_lock_irqsave+0x40/0x60
[  184.630536]                      [<000000000044f240>] tsb_grow+0xe0/0x480
[  184.719741]                      [<000000000044f628>] init_new_context+0x48/0x80
[  184.816970]                      [<000000000045d154>] mm_init+0x134/0x160
[  184.906178]                      [<000000000045d854>] mm_alloc+0x34/0x60
[  184.994248]                      [<0000000000597fe8>] do_execveat_common.isra.34+0x368/0x7a0
[  185.105204]                      [<000000000059843c>] do_execve+0x1c/0x40
[  185.194410]                      [<0000000000426da0>] run_init_process+0x20/0x40
[  185.291639]                      [<0000000000426dc4>] try_to_run_init_process+0x4/0x40
[  185.395725]                      [<0000000000911064>] kernel_init+0xa4/0x120
[  185.488361]                      [<00000000004060e4>] ret_from_fork+0x1c/0x2c
[  185.582152]                      [<          (null)>]           (null)
[  185.667934]   }
[  185.690805]   ... key      at: [<0000000000b37960>] __key.29389+0x0/0x8
[  185.777737]   ... acquired at:
[  185.817767]    [<0000000000917f88>] _raw_spin_lock+0x28/0x40
[  185.892115]    [<0000000000451250>] get_new_mmu_context+0x10/0x140
[  185.973324]    [<0000000000597388>] flush_old_exec+0x428/0x700
[  186.049956]    [<00000000005eee54>] load_elf_binary+0x294/0x11e0
[  186.128878]    [<0000000000596c20>] search_binary_handler+0x60/0x2a0
[  186.212373]    [<0000000000598298>] do_execveat_common.isra.34+0x618/0x7a0
[  186.302734]    [<000000000059843c>] do_execve+0x1c/0x40
[  186.371356]    [<0000000000426da0>] run_init_process+0x20/0x40
[  186.447991]    [<0000000000426dc4>] try_to_run_init_process+0x4/0x40
[  186.531488]    [<0000000000911064>] kernel_init+0xa4/0x120
[  186.603543]    [<00000000004060e4>] ret_from_fork+0x1c/0x2c
[  186.676745]    [<          (null)>]           (null)

[  186.761381] -> (ctx_alloc_lock){+.....} ops: 21045339750400 {
[  186.836867]    HARDIRQ-ON-W at:
[  186.878044]                     [<00000000004b2330>] lock_acquire+0x50/0x80
[  186.969553]                     [<0000000000917f88>] _raw_spin_lock+0x28/0x40
[  187.063342]                     [<0000000000451a44>] hugetlb_setup+0xe4/0x160
[  187.157133]                     [<0000000000450568>] do_sparc64_fault+0x508/0x7a0
[  187.255504]                     [<0000000000407cb0>] sparc64_realfault_common+0x10/0x20
[  187.360735]    INITIAL USE at:
[  187.400750]                    [<00000000004b2330>] lock_acquire+0x50/0x80
[  187.491116]                    [<0000000000917f88>] _raw_spin_lock+0x28/0x40
[  187.583760]                    [<0000000000451250>] get_new_mmu_context+0x10/0x140
[  187.683278]                    [<0000000000597388>] flush_old_exec+0x428/0x700
[  187.778210]                    [<00000000005eee54>] load_elf_binary+0x294/0x11e0
[  187.875432]                    [<0000000000596c20>] search_binary_handler+0x60/0x2a0
[  187.977228]                    [<0000000000598298>] do_execveat_common.isra.34+0x618/0x7a0
[  188.085889]                    [<000000000059843c>] do_execve+0x1c/0x40
[  188.172805]                    [<0000000000426da0>] run_init_process+0x20/0x40
[  188.267749]                    [<0000000000426dc4>] try_to_run_init_process+0x4/0x40
[  188.369544]                    [<0000000000911064>] kernel_init+0xa4/0x120
[  188.459896]                    [<00000000004060e4>] ret_from_fork+0x1c/0x2c
[  188.551396]                    [<          (null)>]           (null)
[  188.634892]  }
[  188.656619]  ... key      at: [<0000000000a9f1a8>] ctx_alloc_lock+0x18/0x70
[  188.748128]  ... acquired at:
[  188.787012]    [<00000000004af708>] mark_lock+0x4c8/0x860
[  188.857929]    [<00000000004b0390>] __lock_acquire+0x350/0x1f00
[  188.935706]    [<00000000004b2330>] lock_acquire+0x50/0x80
[  189.007762]    [<0000000000917f88>] _raw_spin_lock+0x28/0x40
[  189.082109]    [<0000000000451a44>] hugetlb_setup+0xe4/0x160
[  189.156456]    [<0000000000450568>] do_sparc64_fault+0x508/0x7a0
[  189.235377]    [<0000000000407cb0>] sparc64_realfault_common+0x10/0x20

[  189.340597] 
               stack backtrace:
[  189.397804] CPU: 1 PID: 1562 Comm: git Not tainted 4.6.0-08907-g7639dad #6
[  189.488157] Call Trace:
[  189.520179]  [00000000004ae44c] print_irq_inversion_bug+0x1ec/0x200
[  189.602540]  [00000000004ae67c] check_usage_backwards+0xfc/0x120
[  189.681459]  [00000000004af708] mark_lock+0x4c8/0x860
[  189.747796]  [00000000004b0390] __lock_acquire+0x350/0x1f00
[  189.820997]  [00000000004b2330] lock_acquire+0x50/0x80
[  189.888479]  [0000000000917f88] _raw_spin_lock+0x28/0x40
[  189.958249]  [0000000000451a44] hugetlb_setup+0xe4/0x160
[  190.028021]  [0000000000450568] do_sparc64_fault+0x508/0x7a0
[  190.102367]  [0000000000407cb0] sparc64_realfault_common+0x10/0x20


-- 
Meelis Roos (mroos@linux.ee)
