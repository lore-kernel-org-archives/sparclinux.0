From: Meelis Roos <mroos@linux.ee>
Date: Tue, 04 Jul 2017 13:22:34 +0000
Subject: 4.12: sparc64 NULL pointer dereference from filemap_fault()->__radix_tree_lookup()
Message-Id: <alpine.LRH.2.20.1707041537090.22656@math.ut.ee>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org, Linux Kernel list <linux-kernel@vger.kernel.org>

This is 4.12 release on Sun E420R (sparc64 SMP). Have not seen this=20
before and it has not been repeatable, so there is some suspicion of=20
hardware failure too.

[    0.000000] PROMLIB: Sun IEEE Boot Prom 'OBP 3.31.0 2001/07/25 20:35'
[    0.000000] PROMLIB: Root node compatible:=20
[    0.000000] Linux version 4.12.0 (mroos@e420r) (gcc version 4.9.2 (Debia=
n 4.9.2-20) ) #151 SMP Mon Jul 3 11:37:28 EEST 2017
[    0.000000] debug: ignoring loglevel setting.
[    0.000000] bootconsole [earlyprom0] enabled
[    0.000000] ARCH: SUN4U
[    0.000000] Ethernet address: 08:00:20:e9:04:ab
[    0.000000] MM: PAGE_OFFSET is 0xfffff80000000000 (max_phys_bits =3D 40)
[    0.000000] MM: VMALLOC [0x0000000100000000 --> 0x0000060000000000]
[    0.000000] MM: VMEMMAP [0x0000060000000000 --> 0x00000c0000000000]
[    0.000000] Kernel: Using 4 locked TLB entries for main kernel image.
[    0.000000] Remapping the kernel...=20
[    0.000000] done.
[    0.000000] OF stdout device is: /pci@1f,4000/ebus@1/se@14,400000:a
[    0.000000] PROM: Built device tree with 99830 bytes of memory.
[    0.000000] Top of RAM: 0xfff02000, Total RAM: 0xffef0000
[    0.000000] Memory hole size: 0MB
[    0.000000] Allocated 16384 bytes for kernel page tables.
[    0.000000] Zone ranges:
[    0.000000]   Normal   [mem 0x0000000000000000-0x00000000fff01fff]
[    0.000000] Movable zone start for each node
[    0.000000] Early memory node ranges
[    0.000000]   node   0: [mem 0x0000000000000000-0x00000000ffed9fff]
[    0.000000]   node   0: [mem 0x00000000ffeea000-0x00000000ffefdfff]
[    0.000000]   node   0: [mem 0x00000000fff00000-0x00000000fff01fff]
[    0.000000] Initmem setup node 0 [mem 0x0000000000000000-0x00000000fff01=
fff]
[    0.000000] On node 0 totalpages: 524152
[    0.000000]   Normal zone: 4096 pages used for memmap
[    0.000000]   Normal zone: 0 pages reserved
[    0.000000]   Normal zone: 524152 pages, LIFO batch:15
[    0.000000] Booting Linux...
[    0.000000] CPU CAPS: [flush,stbar,swap,muldiv,v9,mul32,div32,v8plus]
[    0.000000] CPU CAPS: [vis]
[    0.000000] percpu: Embedded 11 pages/cpu @fffff800ff800000 s49152 r8192=
 d32768 u1048576
[    0.000000] pcpu-alloc: s49152 r8192 d32768 u1048576 alloc=3D1*4194304
[    0.000000] pcpu-alloc: [0] 0 1 2 3=20
[    0.000000] Built 1 zonelists in Zone order, mobility grouping on.  Tota=
l pages: 520056
[    0.000000] Kernel command line: root=3D/dev/sda2 ro ignore_loglevel
[    0.000000] PID hash table entries: 4096 (order: 2, 32768 bytes)
[    0.000000] Dentry cache hash table entries: 524288 (order: 9, 4194304 b=
ytes)
[    0.000000] Inode-cache hash table entries: 262144 (order: 8, 2097152 by=
tes)
[    0.000000] Sorting __ex_table...
[    0.000000] Memory: 4138160K/4193216K available (4934K kernel code, 346K=
 rwdata, 1096K rodata, 248K init, 8678K bss, 55056K reserved, 0K cma-reserv=
ed)
[    0.000000] SLUB: HWalign2, Order=3D0-3, MinObjects=3D0, CPUs=3D4, Nodes=
=3D1
[    0.000000] Running RCU self tests
[    0.000000] Hierarchical RCU implementation.
[    0.000000] 	RCU lockdep checking is enabled.
[    0.000000] NR_IRQS:2048 nr_irqs:2048 1
[    0.000000] 	Offload RCU callbacks from all CPUs
[    0.000000] 	Offload RCU callbacks from CPUs: 0-3.
[  147.588252] clocksource: tick: mask: 0xffffffffffffffff max_cycles: 0x67=
ce0a7cd0, max_idle_ns: 440795203801 ns
[  147.707966] clocksource: mult[238c601] shift[24]
[  147.763147] clockevent: mult[73392f6e] shift[32]
[  147.818805] Console: colour dummy device 80x25
[  147.871689] console [tty0] enabled
[  147.912108] bootconsole [earlyprom0] disabled
[  147.964186] Lock dependency validator: Copyright (c) 2006 Red Hat, Inc.,=
 Ingo Molnar
[  147.964332] ... MAX_LOCKDEP_SUBCLASSES:  8
[  147.964420] ... MAX_LOCK_DEPTH:          48
[  147.964507] ... MAX_LOCKDEP_KEYS:        8191
[  147.964599] ... CLASSHASH_SIZE:          4096
[  147.964691] ... MAX_LOCKDEP_ENTRIES:     16384
[  147.964786] ... MAX_LOCKDEP_CHAINS:      32768
[  147.964878] ... CHAINHASH_SIZE:          16384
[  147.964973]  memory used by lock dependency info: 5855 kB
[  147.965076]  per task-struct memory footprint: 1920 bytes
[  147.965183] ------------------------
[  147.965260] | Locking API testsuite:
[  147.965340] ------------------------------------------------------------=
----------------
[  147.965491]                                  | spin |wlock |rlock |mutex=
 | wsem | rsem |
[  147.965637]   ----------------------------------------------------------=
----------------
[  147.965813]                      A-A deadlock:  ok  |  ok  |  ok  |  ok =
 |  ok  |  ok  |
[  147.989287]                  A-B-B-A deadlock:  ok  |  ok  |  ok  |  ok =
 |  ok  |  ok  |
[  148.012398]              A-B-B-C-C-A deadlock:  ok  |  ok  |  ok  |  ok =
 |  ok  |  ok  |
[  148.035717]              A-B-C-A-B-C deadlock:  ok  |  ok  |  ok  |  ok =
 |  ok  |  ok  |
[  148.058971]          A-B-B-C-C-D-D-A deadlock:  ok  |  ok  |  ok  |  ok =
 |  ok  |  ok  |
[  148.082451]          A-B-C-D-B-D-D-A deadlock:  ok  |  ok  |  ok  |  ok =
 |  ok  |  ok  |
[  148.105886]          A-B-C-D-B-C-D-A deadlock:  ok  |  ok  |  ok  |  ok =
 |  ok  |  ok  |
[  148.129371]                     double unlock:  ok  |  ok  |  ok  |  ok =
 |  ok  |  ok  |
[  148.152331]                   initialize held:  ok  |  ok  |  ok  |  ok =
 |  ok  |  ok  |
[  148.175252]                  bad unlock order:  ok  |  ok  |  ok  |  ok =
 |  ok  |  ok  |
[  148.198476]   ----------------------------------------------------------=
----------------
[  148.198659]               recursive read-lock:             |  ok  |     =
        |  ok  |
[  148.206513]            recursive read-lock #2:             |  ok  |     =
        |  ok  |
[  148.214405]             mixed read-write-lock:             |  ok  |     =
        |  ok  |
[  148.222252]             mixed write-read-lock:             |  ok  |     =
        |  ok  |
[  148.230150]   ----------------------------------------------------------=
----------------
[  148.230329]      hard-irqs-on + irq-safe-A/12:  ok  |  ok  |  ok  |
[  148.241900]      soft-irqs-on + irq-safe-A/12:  ok  |  ok  |  ok  |
[  148.253444]      hard-irqs-on + irq-safe-A/21:  ok  |  ok  |  ok  |
[  148.265017]      soft-irqs-on + irq-safe-A/21:  ok  |  ok  |  ok  |
[  148.276559]        sirq-safe-A =3D> hirqs-on/12:  ok  |  ok  |  ok  |
[  148.288134]        sirq-safe-A =3D> hirqs-on/21:  ok  |  ok  |  ok  |
[  148.299679]          hard-safe-A + irqs-on/12:  ok  |  ok  |  ok  |
[  148.311260]          soft-safe-A + irqs-on/12:  ok  |  ok  |  ok  |
[  148.322791]          hard-safe-A + irqs-on/21:  ok  |  ok  |  ok  |
[  148.334382]          soft-safe-A + irqs-on/21:  ok  |  ok  |  ok  |
[  148.345930]     hard-safe-A + unsafe-B #1/123:  ok  |  ok  |  ok  |
[  148.357602]     soft-safe-A + unsafe-B #1/123:  ok  |  ok  |  ok  |
[  148.369281]     hard-safe-A + unsafe-B #1/132:  ok  |  ok  |  ok  |
[  148.380931]     soft-safe-A + unsafe-B #1/132:  ok  |  ok  |  ok  |
[  148.392586]     hard-safe-A + unsafe-B #1/213:  ok  |  ok  |  ok  |
[  148.404238]     soft-safe-A + unsafe-B #1/213:  ok  |  ok  |  ok  |
[  148.415904]     hard-safe-A + unsafe-B #1/231:  ok  |  ok  |  ok  |
[  148.427559]     soft-safe-A + unsafe-B #1/231:  ok  |  ok  |  ok  |
[  148.439220]     hard-safe-A + unsafe-B #1/312:  ok  |  ok  |  ok  |
[  148.450812]     soft-safe-A + unsafe-B #1/312:  ok  |  ok  |  ok  |
[  148.462407]     hard-safe-A + unsafe-B #1/321:  ok  |  ok  |  ok  |
[  148.474049]     soft-safe-A + unsafe-B #1/321:  ok  |  ok  |  ok  |
[  148.485720]     hard-safe-A + unsafe-B #2/123:  ok  |  ok  |  ok  |
[  148.497383]     soft-safe-A + unsafe-B #2/123:  ok  |  ok  |  ok  |
[  148.509070]     hard-safe-A + unsafe-B #2/132:  ok  |  ok  |  ok  |
[  148.520717]     soft-safe-A + unsafe-B #2/132:  ok  |  ok  |  ok  |
[  148.532381]     hard-safe-A + unsafe-B #2/213:  ok  |  ok  |  ok  |
[  148.544029]     soft-safe-A + unsafe-B #2/213:  ok  |  ok  |  ok  |
[  148.555689]     hard-safe-A + unsafe-B #2/231:  ok  |  ok  |  ok  |
[  148.567347]     soft-safe-A + unsafe-B #2/231:  ok  |  ok  |  ok  |
[  148.579008]     hard-safe-A + unsafe-B #2/312:  ok  |  ok  |  ok  |
[  148.590660]     soft-safe-A + unsafe-B #2/312:  ok  |  ok  |  ok  |
[  148.602325]     hard-safe-A + unsafe-B #2/321:  ok  |  ok  |  ok  |
[  148.613989]     soft-safe-A + unsafe-B #2/321:  ok  |  ok  |  ok  |
[  148.625644]       hard-irq lock-inversion/123:  ok  |  ok  |  ok  |
[  148.637305]       soft-irq lock-inversion/123:  ok  |  ok  |  ok  |
[  148.648976]       hard-irq lock-inversion/132:  ok  |  ok  |  ok  |
[  148.660622]       soft-irq lock-inversion/132:  ok  |  ok  |  ok  |
[  148.672298]       hard-irq lock-inversion/213:  ok  |  ok  |  ok  |
[  148.683953]       soft-irq lock-inversion/213:  ok  |  ok  |  ok  |
[  148.695622]       hard-irq lock-inversion/231:  ok  |  ok  |  ok  |
[  148.707283]       soft-irq lock-inversion/231:  ok  |  ok  |  ok  |
[  148.718946]       hard-irq lock-inversion/312:  ok  |  ok  |  ok  |
[  148.730604]       soft-irq lock-inversion/312:  ok  |  ok  |  ok  |
[  148.742279]       hard-irq lock-inversion/321:  ok  |  ok  |  ok  |
[  148.753949]       soft-irq lock-inversion/321:  ok  |  ok  |  ok  |
[  148.765606]       hard-irq read-recursion/123:  ok  |
[  148.769610]       soft-irq read-recursion/123:  ok  |
[  148.773614]       hard-irq read-recursion/132:  ok  |
[  148.777615]       soft-irq read-recursion/132:  ok  |
[  148.781574]       hard-irq read-recursion/213:  ok  |
[  148.785580]       soft-irq read-recursion/213:  ok  |
[  148.789586]       hard-irq read-recursion/231:  ok  |
[  148.793586]       soft-irq read-recursion/231:  ok  |
[  148.797546]       hard-irq read-recursion/312:  ok  |
[  148.801543]       soft-irq read-recursion/312:  ok  |
[  148.805541]       hard-irq read-recursion/321:  ok  |
[  148.809550]       soft-irq read-recursion/321:  ok  |
[  148.813503]   ----------------------------------------------------------=
----------------
[  148.813737]   | Wound/wait tests |
[  148.813833]   ---------------------
[  148.813927]                   ww api failures:  ok  |  ok  |  ok  |
[  148.825682]                ww contexts mixing:  ok  |  ok  |
[  148.833442]              finishing ww context:  ok  |  ok  |  ok  |  ok =
 |
[  148.848859]                locking mismatches:  ok  |  ok  |  ok  |
[  148.860430]                  EDEADLK handling:  ok  |  ok  |  ok  |  ok =
 |  ok  |  ok  |  ok  |  ok  |  ok  |  ok  |
[  148.899294]            spinlock nest unlocked:  ok  |
[  148.903261]   -----------------------------------------------------
[  148.903399]                                  |block | try  |context|
[  148.903535]   -----------------------------------------------------
[  148.903672]                           context:  ok  |  ok  |  ok  |
[  148.915413]                               try:  ok  |  ok  |  ok  |
[  148.926979]                             block:  ok  |  ok  |  ok  |
[  148.938616]                          spinlock:  ok  |  ok  |  ok  |
[  148.950409] -------------------------------------------------------
[  148.950547] Good, all 253 testcases passed! |
[  148.950653] ---------------------------------
[  149.030881] Calibrating delay using timer specific routine.. 908.89 Bogo=
MIPS (lpj=1817793)
[  149.031091] pid_max: default: 32768 minimum: 301
[  149.031858] Mount-cache hash table entries: 8192 (order: 3, 65536 bytes)
[  149.032015] Mountpoint-cache hash table entries: 8192 (order: 3, 65536 b=
ytes)
[  149.042455] smp: Bringing up secondary CPUs ...
[  149.089794] CPU 1: synchronized TICK with master CPU (last diff 0 cycles=
, maxerr 522 cycles)
[  149.137172] CPU 2: synchronized TICK with master CPU (last diff -1 cycle=
s, maxerr 533 cycles)
[  149.184405] CPU 3: synchronized TICK with master CPU (last diff -5 cycle=
s, maxerr 539 cycles)
[  149.185030] smp: Brought up 1 node, 4 CPUs
[  149.188779] devtmpfs: initialized
[  149.204152] Performance events: No support for PMU type 'ultra12'
[  149.208062] kworker/u8:0 (41) used greatest stack depth: 8424 bytes left
[  149.210187] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xfffffff=
f, max_idle_ns: 7645041785100000 ns
[  149.210461] futex hash table entries: 1024 (order: 4, 131072 bytes)
[  149.211732] prandom: seed boundary self test passed
[  149.217135] prandom: 100 self tests passed
[  149.219621] NET: Registered protocol family 16
[  149.222243] kworker/u8:1 (45) used greatest stack depth: 7784 bytes left
[  149.252976] /pci@1f,4000: PCI IO[1fe02010000] MEM[1ff80000000]
[  149.253002]  MEM64[1ff80000000]

[  149.253434] /pci@1f,4000: PSYCHO PCI Bus Module ver[4:0]
[  149.253644] PCI: Scanning PBM /pci@1f,4000
[  149.254566] psycho f0060108: PCI host bridge to bus 0000:00
[  149.254735] pci_bus 0000:00: root bus resource [io  0x1fe02010000-0x1fe0=
201ffff] (bus address [0x0000-0xffff])
[  149.254992] pci_bus 0000:00: root bus resource [mem 0x1ff80000000-0x1fff=
fffffff] (bus address [0x00000000-0x7fffffff])
[  149.255253] pci_bus 0000:00: root bus resource [mem 0x1ff80000000-0x1fff=
fffffff] (bus address [0x00000000-0x7fffffff])
[  149.255512] pci_bus 0000:00: root bus resource [bus 00]
[  149.260275] pci 0000:00:02.0: supports D1 D2
[  149.262194] /pci@1f,2000: PCI IO[1fe02000000] MEM[1ff00000000]
[  149.262212]  MEM64[1ff00000000]

[  149.262533] /pci@1f,2000: PSYCHO PCI Bus Module ver[4:0]
[  149.262670] PCI: Scanning PBM /pci@1f,2000
[  149.263372] psycho f0060984: PCI host bridge to bus 0001:80
[  149.263531] pci_bus 0001:80: root bus resource [io  0x1fe02000000-0x1fe0=
200ffff] (bus address [0x0000-0xffff])
[  149.263784] pci_bus 0001:80: root bus resource [mem 0x1ff00000000-0x1ff7=
fffffff] (bus address [0x00000000-0x7fffffff])
[  149.264044] pci_bus 0001:80: root bus resource [mem 0x1ff00000000-0x1ff7=
fffffff] (bus address [0x00000000-0x7fffffff])
[  149.264300] pci_bus 0001:80: root bus resource [bus 80-81]
[  149.265934] pci 0001:80:01.0: PCI bridge to [bus 81]
[  149.266103] pci 0001:80:01.0:   bridge window [io  0x1fe02001000-0x1fe02=
001fff]
[  149.266313] pci 0001:80:01.0:   bridge window [mem 0x1ff00100000-0x1ff04=
0fffff]
[  149.290143] HugeTLB registered 8 MB page size, pre-allocated 0 pages
[  149.294369] pci 0000:00:02.0: vgaarb: VGA device added: decodes=3Dio+mem=
,owns=3Dnone,locks=3Dnone
[  149.294626] pci 0000:00:02.0: vgaarb: bridge control possible
[  149.294770] vgaarb: loaded
[  149.295848] SCSI subsystem initialized
[  149.301398] /pci@1f,4000/ebus@1/eeprom@14,0: Mostek regs at 0x1fff1000000
[  149.303608] AUXIO: Found device at /pci@1f,4000/ebus@1/auxio@14,726000
[  149.304524] clocksource: Switched to clocksource tick
[  149.348761] NET: Registered protocol family 2
[  149.351214] TCP established hash table entries: 32768 (order: 5, 262144 =
bytes)
[  149.352920] TCP bind hash table entries: 32768 (order: 8, 2097152 bytes)
[  149.370702] TCP: Hash tables configured (established 32768 bind 32768)
[  149.371900] UDP hash table entries: 2048 (order: 5, 327680 bytes)
[  149.374605] UDP-Lite hash table entries: 2048 (order: 5, 327680 bytes)
[  149.378577] NET: Registered protocol family 1
[  149.379008] PCI: CLS 0 bytes, default 64
[  149.380139] power: Control reg at 1fff1724000
[  149.387196] workingset: timestamp_bitsb max_order=19 bucket_order=3D0
[  149.451646] Block layer SCSI generic (bsg) driver version 0.4 loaded (ma=
jor 252)
[  149.451922] io scheduler noop registered
[  149.453426] io scheduler cfq registered (default)
[  149.453556] start plist test
[  149.467835] end plist test
[  149.470488] /pci@1f,4000/ebus@1/su@14,3083f8: Keyboard port at 1fff13083=
f8, irq 8
[  149.470991] /pci@1f,4000/ebus@1/su@14,3062f8: Mouse port at 1fff13062f8,=
 irq 9
[  149.472197] f006209c: ttyS0 at MMIO 0x1fff1400000 (irq =3D 7, base_baud =
=3D 115200) is a SAB82532 V3.2
[  149.472562] Console: ttyS0 (SAB82532)
[  166.043615] console [ttyS0] enabled
[  166.086695] f006209c: ttyS1 at MMIO 0x1fff1400040 (irq =3D 7, base_baud =
=3D 115200) is a SAB82532 V3.2
[  166.195718] PCI: Enabling device: (0000:00:03.0), cmd 147
[  166.261520] sym0: <875> rev 0x14 at pci 0000:00:03.0 irq 13
[  166.415198] sym0: No NVRAM, ID 7, Fast-20, SE, parity checking
[  166.491945] sym0: SCSI BUS has been reset.
[  166.540145] scsi host0: sym-2.2.3
[  166.588077] PCI: Enabling device: (0000:00:03.1), cmd 3
[  166.651859] sym1: <875> rev 0x14 at pci 0000:00:03.1 irq 14
[  166.805030] sym1: No NVRAM, ID 7, Fast-20, SE, parity checking
[  166.881668] sym1: SCSI BUS has been reset.
[  166.929866] scsi host1: sym-2.2.3
[  166.978536] libphy: Fixed MDIO Bus: probed
[  167.028062] mousedev: PS/2 mouse device common for all mice
[  167.097285] rtc-m48t59 rtc-m48t59.0: rtc core: registered m48t59 as rtc0
[  167.178228] NET: Registered protocol family 17
[  167.230948] Key type dns_resolver registered
[  167.287388] Key type encrypted registered
[  167.335978] rtc-m48t59 rtc-m48t59.0: setting system clock to 2017-07-03 =
11:01:59 UTC (1499079719)
[  169.681027] scsi target0:0:0: FAST-20 WIDE SCSI 40.0 MB/s ST (50 ns, off=
set 16)
[  169.769618] scsi 0:0:0:0: Direct-Access     IBM-ESXS ST336753LC    F  B8=
5A PQ: 0 ANSI: 3
[  169.865915] scsi target0:0:0: tagged command queuing enabled, command qu=
eue depth 16.
[  169.959822] scsi target0:0:0: Beginning Domain Validation
[  170.035704] scsi target0:0:0: Domain Validation skipping write tests
[  170.110952] scsi target0:0:0: Ending Domain Validation
[  171.615006] scsi 0:0:6:0: CD-ROM            TOSHIBA  DVD-ROM SD-M1401 10=
09 PQ: 0 ANSI: 2
[  171.711196] scsi target0:0:6: Beginning Domain Validation
[  171.777942] scsi target0:0:6: FAST-20 SCSI 20.0 MB/s ST (50 ns, offset 1=
6)
[  171.861623] scsi target0:0:6: Domain Validation skipping write tests
[  171.936949] scsi target0:0:6: Ending Domain Validation
[  174.347627] sd 0:0:0:0: [sda] 71096640 512-byte logical blocks: (36.4 GB=
/33.9 GiB)
[  174.439211] sd 0:0:0:0: [sda] Write Protect is off
[  174.495682] sd 0:0:0:0: [sda] Mode Sense: b3 00 10 08
[  174.558009] sd 0:0:0:0: [sda] Write cache: disabled, read cache: enabled=
, supports DPO and FUA
[  174.677470]  sda: sda1 sda2 sda3 sda4
[  174.731266] sd 0:0:0:0: [sda] Attached SCSI disk
[  174.791804] EXT4-fs (sda2): couldn't mount as ext3 due to feature incomp=
atibilities
[  174.887533] EXT4-fs (sda2): couldn't mount as ext2 due to feature incomp=
atibilities
[  175.017568] EXT4-fs (sda2): mounted filesystem with ordered data mode. O=
pts: (null)
[  175.108678] VFS: Mounted root (ext4 filesystem) readonly on device 259:2=
62144.
[  175.216329] devtmpfs: mounted
[  175.252091] This architecture does not have kernel memory protection.
[  175.910612] stty (534) used greatest stack depth: 6392 bytes left
[  176.349572] random: fast init done
[  176.936722] ps (608) used greatest stack depth: 6280 bytes left
[  177.660334] Unable to handle kernel paging request at virtual address 00=
00000000008000
[  177.754650] tsk->{mm,active_mm}->context =3D 00000000000000b3
[  177.821233] tsk->{mm,active_mm}->pgd =3D fffff800fd0dc000
[  177.883742]               \|/ ____ \|/
                             "@'/ .. \`@"
                             /_| \__/ |_\
                                \__U_/
[  178.059977] udevd(640): Oops [#1]
[  178.099382] CPU: 1 PID: 640 Comm: udevd Not tainted 4.12.0 #151
[  178.170154] task: fffff800fc847700 task.stack: fffff800fcffc000
[  178.172893] /pci@1f,4000/ebus@1/flashprom@10,0: OBP Flash, RD 1fff000000=
0[100000] WR 1fff0000000[100000]
[  178.246708] PCI: Enabling device: (0000:00:01.1), cmd 2
[  178.246808] sunhme.c:v3.10 August 26, 2008 David S. Miller (davem@daveml=
oft.net)
[  178.267947] eth0: HAPPY MEAL (PCI/CheerIO) 10/100BaseT Ethernet=20
[  178.267962] 08:00:20:e9:04:ab
[  178.268188] PCI: Enabling device: (0001:81:00.1), cmd 2
[  178.271522] eth1: HAPPY MEAL (PCI/CheerIO) 10/100BaseT Ethernet=20
[  178.271533] 08:00:20:e9:04:ab
[  178.508986] qla1280: QLA1040 found on PCI bus 129, dev 4
[  178.509011] PCI: Enabling device: (0001:81:04.0), cmd 3
[  178.588342] sd 0:0:0:0: Attached scsi generic sg0 type 0
[  178.589103] sr 0:0:6:0: Attached scsi generic sg1 type 5
[  178.852333] hme 0001:81:00.1 rename3: renamed from eth1
[  179.098007] TSTATE: 0000000011001603 TPC: 00000000006cf598 TNPC: 0000000=
0006cf59c Y: 000000e7    Not tainted
[  179.098164] sr 0:0:6:0: [sr0] scsi3-mmc drive: 40x/40x cd/rw xa/form2 cd=
da tray
[  179.098180] cdrom: Uniform CD-ROM driver Revision: 3.20
[  179.104290] sr 0:0:6:0: Attached scsi CD-ROM sr0
[  179.420835] TPC: <__radix_tree_lookup+0x58/0x100>
[  179.477056] g0: 0000000000000000 g1: 00000000000096d1 g2: 00000000000096=
d1 g3: 0000000000000001
[  179.581290] g4: fffff800fc847700 g5: fffff800fee88000 g6: fffff800fcffc0=
00 g7: 0000000000000000
[  179.685422] o0: 0000000000000001 o1: fffff800fc847f08 o2: 00000000000000=
0c o3: 0000000000000000
[  179.789578] o4: fffff800fc847f00 o5: fffff800f6108508 sp: fffff800fcffef=
81 ret_pc: 0000000000000000
[  179.897905] RPC: <          (null)>
[  179.939430] l0: fffff800fc847700 l1: 0000000000a21c00 l2: 00000000000000=
40 l3: 0000000000000050
[  180.043678] l4: 0000000001292800 l5: e8ab7d90838cc09a l6: 0000000000b080=
00 l7: 0000000000000000
[  180.147813] i0: 0000000000000040 i1: 000000000000029a i2: 00000000000000=
00 i3: 0000000000000000
[  180.251976] i4: fffff800f60ffae0 i5: 00000000000096d0 i6: fffff800fcfff0=
31 i7: 00000000006cf690
[  180.356135] I7: <radix_tree_lookup+0x10/0x20>
[  180.408065] Call Trace:
[  180.437222]  [00000000006cf690] radix_tree_lookup+0x10/0x20
[  180.503918]  [00000000005310a0] __do_page_cache_readahead+0xe0/0x3e0
[  180.579999]  [0000000000523588] filemap_fault+0x3a8/0x580
[  180.644524]  [000000000062729c] ext4_filemap_fault+0x1c/0x40
[  180.712243]  [000000000054b834] __do_fault+0x14/0x80
[  180.771631]  [00000000005501a0] __handle_mm_fault+0x760/0xa20
[  180.840347]  [00000000005504cc] handle_mm_fault+0x6c/0x100
[  180.905939]  [00000000004513e8] do_sparc64_fault+0x428/0x860
[  180.973654]  [0000000000407c5c] sparc64_realfault_common+0x10/0x20
[  181.047627] Disabling lock debugging due to kernel taint
[  181.111052] Caller[00000000006cf690]: radix_tree_lookup+0x10/0x20
[  181.183937] Caller[00000000005310a0]: __do_page_cache_readahead+0xe0/0x3=
e0
[  181.266203] Caller[0000000000523588]: filemap_fault+0x3a8/0x580
[  181.337011] Caller[000000000062729c]: ext4_filemap_fault+0x1c/0x40
[  181.410940] Caller[000000000054b834]: __do_fault+0x14/0x80
[  181.476559] Caller[00000000005501a0]: __handle_mm_fault+0x760/0xa20
[  181.551542] Caller[00000000005504cc]: handle_mm_fault+0x6c/0x100
[  181.623393] Caller[00000000004513e8]: do_sparc64_fault+0x428/0x860
[  181.697336] Caller[0000000000407c5c]: sparc64_realfault_common+0x10/0x20
[  181.777528] Caller[0000000070038494]: 0x70038494
[  181.832704] Instruction DUMP:
[  181.832715]  0267fff0=20
[  181.868118]  01000000=20
[  181.896229]  ba08bffe=20
[  181.924353] <c20f4000>
[  181.952464]  83365001=20
[  181.980589]  8208603f=20
[  182.008697]  82006004=20
[  182.036826]  83287003=20
[  182.064942]  82074001=20

[  182.138879] BUG: sleeping function called from invalid context at ./incl=
ude/linux/percpu-rwsem.h:33
[  182.247239] in_atomic(): 1, irqs_disabled(): 0, pid: 640, name: udevd
[  182.324286] INFO: lockdep is turned off.
[  182.371153] CPU: 1 PID: 640 Comm: udevd Tainted: G      D         4.12.0=
 #151
[  182.456455] Call Trace:
[  182.485616]  [000000000048d8b8] ___might_sleep+0x158/0x280
[  182.551226]  [000000000048da1c] __might_sleep+0x3c/0x80
[  182.613719]  [0000000000475270] exit_signals+0x10/0x260
[  182.676204]  [0000000000467bac] do_exit+0x8c/0xc40
[  182.733475]  [000000000042a1b8] die_if_kernel+0x198/0x320
[  182.798043]  [000000000045fed4] unhandled_fault+0x84/0x90
[  182.862611]  [00000000004514d8] do_sparc64_fault+0x518/0x860
[  182.930306]  [0000000000407c5c] sparc64_realfault_common+0x10/0x20
[  183.004251]  [00000000006cf598] __radix_tree_lookup+0x58/0x100
[  183.074026]  [00000000006cf690] radix_tree_lookup+0x10/0x20
[  183.140678]  [00000000005310a0] __do_page_cache_readahead+0xe0/0x3e0
[  183.216706]  [0000000000523588] filemap_fault+0x3a8/0x580
[  183.281269]  [000000000062729c] ext4_filemap_fault+0x1c/0x40
[  183.348960]  [000000000054b834] __do_fault+0x14/0x80
[  183.408320]  [00000000005501a0] __handle_mm_fault+0x760/0xa20
[  183.477061]  [00000000005504cc] handle_mm_fault+0x6c/0x100
[  183.542761] note: udevd[640] exited with preempt_count 1
[  184.345205] sr 0:0:6:0: [sr0] CDROM not ready.  Make sure there is a dis=
c in the drive.
[  184.404281] random: crng init done
[  184.699366] scsi(2:0): Resetting SCSI BUS
[  187.950922] scsi host2: QLogic QLA1040 PCI to SCSI Host Adapter
                      Firmware version:  7.65.06, Driver version 3.27.1
[  188.020202] sr 0:0:6:0: [sr0] CDROM not ready.  Make sure there is a dis=
c in the drive.
[  188.021069] cdrom_id (686) used greatest stack depth: 5928 bytes left
[  191.552074] sr 0:0:6:0: [sr0] CDROM not ready.  Make sure there is a dis=
c in the drive.
[  195.179383] sr 0:0:6:0: [sr0] CDROM not ready.  Make sure there is a dis=
c in the drive.
[  198.806736] sr 0:0:6:0: [sr0] CDROM not ready.  Make sure there is a dis=
c in the drive.
[  202.434033] sr 0:0:6:0: [sr0] CDROM not ready.  Make sure there is a dis=
c in the drive.
[  206.061344] sr 0:0:6:0: [sr0] CDROM not ready.  Make sure there is a dis=
c in the drive.
[  209.688665] sr 0:0:6:0: [sr0] CDROM not ready.  Make sure there is a dis=
c in the drive.
[  275.999281] Adding 1566328k swap on /dev/sda4.  Priority:-1 extents:1 ac=
ross:1566328k=20
[  276.233258] EXT4-fs (sda2): re-mounted. Opts: (null)
[  276.523870] EXT4-fs (sda2): re-mounted. Opts: errors=3Dremount-ro
[  277.571449] logsave (1076) used greatest stack depth: 5384 bytes left
[  278.039199] loop: module loaded
[  278.279059] EXT4-fs (sda1): mounting ext2 file system using the ext4 sub=
system
[  278.371922] EXT4-fs (sda1): mounted filesystem without journal. Opts: (n=
ull)
[  279.881265] NET: Registered protocol family 10
[  279.984634] Segment Routing with IPv6
[  282.973722] udevd (644) used greatest stack depth: 4280 bytes left
[  283.046813] udevd (650) used greatest stack depth: 3016 bytes left
[  283.818953] eth0: Link is up using=20
[  283.818964] internal=20
[  283.859670] transceiver at=20
[  283.886764] 100Mb/s, Full Duplex.

#
# Automatically generated file; DO NOT EDIT.
# Linux/sparc64 4.12.0 Kernel Configuration
#
CONFIG_64BIT=3Dy
CONFIG_SPARC=3Dy
# CONFIG_SPARC32 is not set
CONFIG_SPARC64=3Dy
CONFIG_ARCH_DEFCONFIG=3D"arch/sparc/configs/sparc64_defconfig"
CONFIG_ARCH_PROC_KCORE_TEXT=3Dy
CONFIG_ARCH_ATU=3Dy
CONFIG_ARCH_DMA_ADDR_T_64BIT=3Dy
CONFIG_IOMMU_HELPER=3Dy
CONFIG_STACKTRACE_SUPPORT=3Dy
CONFIG_LOCKDEP_SUPPORT=3Dy
CONFIG_ARCH_HIBERNATION_POSSIBLE=3Dy
CONFIG_AUDIT_ARCH=3Dy
CONFIG_HAVE_SETUP_PER_CPU_AREA=3Dy
CONFIG_NEED_PER_CPU_EMBED_FIRST_CHUNK=3Dy
CONFIG_NEED_PER_CPU_PAGE_FIRST_CHUNK=3Dy
CONFIG_MMU=3Dy
CONFIG_NEED_DMA_MAP_STATE=3Dy
CONFIG_NEED_SG_DMA_LENGTH=3Dy
CONFIG_ARCH_SUPPORTS_DEBUG_PAGEALLOC=3Dy
CONFIG_PGTABLE_LEVELS=3D4
CONFIG_ARCH_SUPPORTS_UPROBES=3Dy
CONFIG_DEFCONFIG_LIST=3D"/lib/modules/$UNAME_RELEASE/.config"
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
# CONFIG_CROSS_MEMORY_ATTACH is not set
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

#
# Timers subsystem
#
CONFIG_TICK_ONESHOT=3Dy
CONFIG_NO_HZ_COMMON=3Dy
# CONFIG_HZ_PERIODIC is not set
# CONFIG_NO_HZ_IDLE is not set
CONFIG_NO_HZ_FULL=3Dy
# CONFIG_NO_HZ_FULL_ALL is not set
# CONFIG_NO_HZ_FULL_SYSIDLE is not set
CONFIG_NO_HZ=3Dy
CONFIG_HIGH_RES_TIMERS=3Dy

#
# CPU/Task time and stats accounting
#
CONFIG_VIRT_CPU_ACCOUNTING=3Dy
CONFIG_VIRT_CPU_ACCOUNTING_GEN=3Dy
# CONFIG_BSD_PROCESS_ACCT is not set
# CONFIG_TASKSTATS is not set

#
# RCU Subsystem
#
CONFIG_TREE_RCU=3Dy
# CONFIG_RCU_EXPERT is not set
CONFIG_SRCU=3Dy
CONFIG_TREE_SRCU=3Dy
# CONFIG_TASKS_RCU is not set
CONFIG_RCU_STALL_COMMON=3Dy
CONFIG_RCU_NEED_SEGCBLIST=3Dy
CONFIG_CONTEXT_TRACKING=3Dy
# CONFIG_CONTEXT_TRACKING_FORCE is not set
# CONFIG_TREE_RCU_TRACE is not set
CONFIG_RCU_NOCB_CPU=3Dy
# CONFIG_RCU_NOCB_CPU_NONE is not set
# CONFIG_RCU_NOCB_CPU_ZERO is not set
CONFIG_RCU_NOCB_CPU_ALL=3Dy
# CONFIG_BUILD_BIN2C is not set
# CONFIG_IKCONFIG is not set
CONFIG_LOG_BUF_SHIFT=17
CONFIG_LOG_CPU_MAX_BUF_SHIFT=12
CONFIG_PRINTK_SAFE_LOG_BUF_SHIFT=13
CONFIG_CGROUPS=3Dy
# CONFIG_MEMCG is not set
# CONFIG_BLK_CGROUP is not set
# CONFIG_CGROUP_SCHED is not set
# CONFIG_CGROUP_PIDS is not set
# CONFIG_CGROUP_RDMA is not set
# CONFIG_CGROUP_FREEZER is not set
# CONFIG_CGROUP_HUGETLB is not set
# CONFIG_CPUSETS is not set
# CONFIG_CGROUP_DEVICE is not set
# CONFIG_CGROUP_CPUACCT is not set
# CONFIG_CGROUP_PERF is not set
# CONFIG_CGROUP_DEBUG is not set
# CONFIG_SOCK_CGROUP_DATA is not set
# CONFIG_CHECKPOINT_RESTORE is not set
CONFIG_NAMESPACES=3Dy
# CONFIG_UTS_NS is not set
# CONFIG_IPC_NS is not set
# CONFIG_USER_NS is not set
# CONFIG_PID_NS is not set
# CONFIG_NET_NS is not set
# CONFIG_SCHED_AUTOGROUP is not set
# CONFIG_SYSFS_DEPRECATED is not set
# CONFIG_RELAY is not set
# CONFIG_BLK_DEV_INITRD is not set
CONFIG_CC_OPTIMIZE_FOR_PERFORMANCE=3Dy
# CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
CONFIG_SYSCTL=3Dy
CONFIG_ANON_INODES=3Dy
CONFIG_HAVE_UID16=3Dy
CONFIG_SYSCTL_EXCEPTION_TRACE=3Dy
CONFIG_BPF=3Dy
# CONFIG_EXPERT is not set
CONFIG_UID16=3Dy
CONFIG_MULTIUSER=3Dy
CONFIG_SGETMASK_SYSCALL=3Dy
CONFIG_SYSFS_SYSCALL=3Dy
# CONFIG_SYSCTL_SYSCALL is not set
CONFIG_POSIX_TIMERS=3Dy
CONFIG_KALLSYMS=3Dy
CONFIG_KALLSYMS_ALL=3Dy
# CONFIG_KALLSYMS_ABSOLUTE_PERCPU is not set
CONFIG_KALLSYMS_BASE_RELATIVE=3Dy
CONFIG_PRINTK=3Dy
CONFIG_PRINTK_NMI=3Dy
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
CONFIG_USERFAULTFD=3Dy
CONFIG_PCI_QUIRKS=3Dy
CONFIG_MEMBARRIER=3Dy
# CONFIG_EMBEDDED is not set
CONFIG_HAVE_PERF_EVENTS=3Dy
CONFIG_PERF_USE_VMALLOC=3Dy
# CONFIG_PC104 is not set

#
# Kernel Performance Events And Counters
#
CONFIG_PERF_EVENTS=3Dy
# CONFIG_DEBUG_PERF_USE_VMALLOC is not set
CONFIG_VM_EVENT_COUNTERS=3Dy
CONFIG_SLUB_DEBUG=3Dy
# CONFIG_COMPAT_BRK is not set
# CONFIG_SLAB is not set
CONFIG_SLUB=3Dy
# CONFIG_SLAB_FREELIST_RANDOM is not set
CONFIG_SLUB_CPU_PARTIAL=3Dy
# CONFIG_SYSTEM_DATA_VERIFICATION is not set
CONFIG_PROFILING=3Dy
CONFIG_OPROFILE=3Dm
CONFIG_HAVE_OPROFILE=3Dy
# CONFIG_KPROBES is not set
CONFIG_JUMP_LABEL=3Dy
CONFIG_STATIC_KEYS_SELFTEST=3Dy
# CONFIG_UPROBES is not set
CONFIG_HAVE_64BIT_ALIGNED_ACCESS=3Dy
CONFIG_HAVE_KPROBES=3Dy
CONFIG_HAVE_KRETPROBES=3Dy
CONFIG_HAVE_NMI=3Dy
CONFIG_HAVE_NMI_WATCHDOG=3Dy
CONFIG_HAVE_ARCH_TRACEHOOK=3Dy
CONFIG_GENERIC_SMP_IDLE_THREAD=3Dy
CONFIG_HAVE_REGS_AND_STACK_ACCESS_API=3Dy
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
CONFIG_HAVE_EXIT_THREAD=3Dy
# CONFIG_HAVE_ARCH_HASH is not set
# CONFIG_ISA_BUS_API is not set
CONFIG_ODD_RT_SIGACTION=3Dy
CONFIG_OLD_SIGSUSPEND=3Dy
CONFIG_COMPAT_OLD_SIGACTION=3Dy
CONFIG_CPU_NO_EFFICIENT_FFS=3Dy
# CONFIG_HAVE_ARCH_VMAP_STACK is not set
# CONFIG_ARCH_OPTIONAL_KERNEL_RWX is not set
# CONFIG_ARCH_OPTIONAL_KERNEL_RWX_DEFAULT is not set
# CONFIG_ARCH_HAS_STRICT_KERNEL_RWX is not set
# CONFIG_ARCH_HAS_STRICT_MODULE_RWX is not set
CONFIG_ARCH_WANT_RELAX_ORDER=3Dy

#
# GCOV-based kernel profiling
#
# CONFIG_ARCH_HAS_GCOV_PROFILE_ALL is not set
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
CONFIG_TRIM_UNUSED_KSYMS=3Dy
CONFIG_MODULES_TREE_LOOKUP=3Dy
CONFIG_BLOCK=3Dy
CONFIG_BLK_SCSI_REQUEST=3Dy
CONFIG_BLK_DEV_BSG=3Dy
CONFIG_BLK_DEV_BSGLIB=3Dy
CONFIG_BLK_DEV_INTEGRITY=3Dy
# CONFIG_BLK_DEV_ZONED is not set
# CONFIG_BLK_CMDLINE_PARSER is not set
# CONFIG_BLK_WBT is not set
# CONFIG_BLK_SED_OPAL is not set

#
# Partition Types
#
CONFIG_PARTITION_ADVANCED=3Dy
# CONFIG_ACORN_PARTITION is not set
CONFIG_AIX_PARTITION=3Dy
CONFIG_OSF_PARTITION=3Dy
CONFIG_AMIGA_PARTITION=3Dy
CONFIG_ATARI_PARTITION=3Dy
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
CONFIG_BLK_MQ_PCI=3Dy

#
# IO Schedulers
#
CONFIG_IOSCHED_NOOP=3Dy
# CONFIG_IOSCHED_DEADLINE is not set
CONFIG_IOSCHED_CFQ=3Dy
CONFIG_DEFAULT_CFQ=3Dy
# CONFIG_DEFAULT_NOOP is not set
CONFIG_DEFAULT_IOSCHED=3D"cfq"
# CONFIG_MQ_IOSCHED_DEADLINE is not set
# CONFIG_MQ_IOSCHED_KYBER is not set
# CONFIG_IOSCHED_BFQ is not set
CONFIG_UNINLINE_SPIN_UNLOCK=3Dy
CONFIG_ARCH_SUPPORTS_ATOMIC_RMW=3Dy
CONFIG_MUTEX_SPIN_ON_OWNER=3Dy
CONFIG_RWSEM_SPIN_ON_OWNER=3Dy
CONFIG_LOCK_SPIN_ON_OWNER=3Dy
CONFIG_FREEZER=3Dy

#
# Processor type and features
#
CONFIG_SMP=3Dy
CONFIG_NR_CPUS=3D4
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
# CONFIG_SECCOMP is not set
CONFIG_HOTPLUG_CPU=3Dy

#
# CPU Frequency scaling
#
# CONFIG_CPU_FREQ is not set
# CONFIG_US3_MC is not set
# CONFIG_NUMA is not set
CONFIG_ARCH_SELECT_MEMORY_MODEL=3Dy
CONFIG_ARCH_SPARSEMEM_ENABLE=3Dy
CONFIG_ARCH_SPARSEMEM_DEFAULT=3Dy
CONFIG_FORCE_MAX_ZONEORDER=13
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
CONFIG_SPLIT_PTLOCK_CPUS=3D4
# CONFIG_COMPACTION is not set
CONFIG_PHYS_ADDR_T_64BIT=3Dy
# CONFIG_KSM is not set
CONFIG_DEFAULT_MMAP_MIN_ADDR@96
# CONFIG_TRANSPARENT_HUGEPAGE is not set
# CONFIG_CLEANCACHE is not set
# CONFIG_FRONTSWAP is not set
# CONFIG_CMA is not set
# CONFIG_ZPOOL is not set
# CONFIG_ZBUD is not set
# CONFIG_ZSMALLOC is not set
# CONFIG_IDLE_PAGE_TRACKING is not set
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
# CONFIG_PCIEPORTBUS is not set
CONFIG_PCI_BUS_ADDR_T_64BIT=3Dy
CONFIG_PCI_MSI=3Dy
# CONFIG_PCI_MSI_IRQ_DOMAIN is not set
# CONFIG_PCI_DEBUG is not set
# CONFIG_PCI_REALLOC_ENABLE_AUTO is not set
# CONFIG_PCI_STUB is not set
# CONFIG_PCI_IOV is not set
# CONFIG_PCI_PRI is not set
# CONFIG_PCI_PASID is not set
# CONFIG_HOTPLUG_PCI is not set

#
# DesignWare PCI Core Support
#

#
# PCI host controller drivers
#

#
# PCI Endpoint
#
# CONFIG_PCI_ENDPOINT is not set

#
# PCI switch controller drivers
#
# CONFIG_PCI_SW_SWITCHTEC is not set
# CONFIG_PCCARD is not set
CONFIG_SUN_OPENPROMFS=3Dm
CONFIG_SPARC64_PCI=3Dy
CONFIG_SPARC64_PCI_MSI=3Dy

#
# Executable file formats
#
CONFIG_BINFMT_ELF=3Dy
CONFIG_COMPAT_BINFMT_ELF=3Dy
CONFIG_ELFCORE=3Dy
CONFIG_CORE_DUMP_DEFAULT_ELF_HEADERS=3Dy
CONFIG_BINFMT_SCRIPT=3Dy
# CONFIG_HAVE_AOUT is not set
CONFIG_BINFMT_MISC=3Dm
CONFIG_COREDUMP=3Dy
CONFIG_COMPAT=3Dy
CONFIG_SYSVIPC_COMPAT=3Dy
CONFIG_NET=3Dy
CONFIG_NET_INGRESS=3Dy
CONFIG_NET_EGRESS=3Dy

#
# Networking options
#
CONFIG_PACKET=3Dy
CONFIG_PACKET_DIAG=3Dm
CONFIG_UNIX=3Dy
CONFIG_UNIX_DIAG=3Dy
CONFIG_XFRM=3Dy
CONFIG_XFRM_ALGO=3Dm
# CONFIG_XFRM_USER is not set
# CONFIG_XFRM_SUB_POLICY is not set
CONFIG_XFRM_MIGRATE=3Dy
# CONFIG_XFRM_STATISTICS is not set
CONFIG_XFRM_IPCOMP=3Dm
# CONFIG_NET_KEY is not set
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
# CONFIG_NET_UDP_TUNNEL is not set
# CONFIG_NET_FOU is not set
# CONFIG_NET_FOU_IP_TUNNELS is not set
# CONFIG_INET_AH is not set
# CONFIG_INET_ESP is not set
# CONFIG_INET_IPCOMP is not set
# CONFIG_INET_XFRM_TUNNEL is not set
CONFIG_INET_TUNNEL=3Dm
# CONFIG_INET_XFRM_MODE_TRANSPORT is not set
# CONFIG_INET_XFRM_MODE_TUNNEL is not set
# CONFIG_INET_XFRM_MODE_BEET is not set
CONFIG_INET_DIAG=3Dm
CONFIG_INET_TCP_DIAG=3Dm
CONFIG_INET_UDP_DIAG=3Dm
CONFIG_INET_RAW_DIAG=3Dm
# CONFIG_INET_DIAG_DESTROY is not set
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
# CONFIG_INET6_ESP_OFFLOAD is not set
CONFIG_INET6_IPCOMP=3Dm
CONFIG_IPV6_MIP6=3Dm
CONFIG_IPV6_ILA=3Dm
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
# CONFIG_IPV6_FOU is not set
# CONFIG_IPV6_FOU_TUNNEL is not set
CONFIG_IPV6_MULTIPLE_TABLES=3Dy
CONFIG_IPV6_SUBTREES=3Dy
CONFIG_IPV6_MROUTE=3Dy
CONFIG_IPV6_MROUTE_MULTIPLE_TABLES=3Dy
CONFIG_IPV6_PIMSM_V2=3Dy
CONFIG_IPV6_SEG6_LWTUNNEL=3Dy
CONFIG_IPV6_SEG6_INLINE=3Dy
CONFIG_IPV6_SEG6_HMAC=3Dy
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
CONFIG_NETFILTER_INGRESS=3Dy
CONFIG_NETFILTER_NETLINK=3Dm
CONFIG_NETFILTER_NETLINK_ACCT=3Dm
CONFIG_NETFILTER_NETLINK_QUEUE=3Dm
CONFIG_NETFILTER_NETLINK_LOG=3Dm
CONFIG_NF_CONNTRACK=3Dm
CONFIG_NF_LOG_COMMON=3Dm
CONFIG_NF_LOG_NETDEV=3Dm
CONFIG_NF_CONNTRACK_MARK=3Dy
CONFIG_NF_CONNTRACK_ZONES=3Dy
CONFIG_NF_CONNTRACK_PROCFS=3Dy
CONFIG_NF_CONNTRACK_EVENTS=3Dy
CONFIG_NF_CONNTRACK_TIMEOUT=3Dy
CONFIG_NF_CONNTRACK_TIMESTAMP=3Dy
CONFIG_NF_CONNTRACK_LABELS=3Dy
CONFIG_NF_CT_PROTO_DCCP=3Dy
CONFIG_NF_CT_PROTO_GRE=3Dm
CONFIG_NF_CT_PROTO_SCTP=3Dy
CONFIG_NF_CT_PROTO_UDPLITE=3Dy
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
# CONFIG_NETFILTER_NETLINK_GLUE_CT is not set
CONFIG_NF_NAT=3Dm
CONFIG_NF_NAT_NEEDED=3Dy
CONFIG_NF_NAT_PROTO_DCCP=3Dy
CONFIG_NF_NAT_PROTO_UDPLITE=3Dy
CONFIG_NF_NAT_PROTO_SCTP=3Dy
CONFIG_NF_NAT_AMANDA=3Dm
CONFIG_NF_NAT_FTP=3Dm
CONFIG_NF_NAT_IRC=3Dm
CONFIG_NF_NAT_SIP=3Dm
CONFIG_NF_NAT_TFTP=3Dm
CONFIG_NF_NAT_REDIRECT=3Dm
CONFIG_NETFILTER_SYNPROXY=3Dm
CONFIG_NF_TABLES=3Dm
CONFIG_NF_TABLES_INET=3Dm
CONFIG_NF_TABLES_NETDEV=3Dm
CONFIG_NFT_EXTHDR=3Dm
CONFIG_NFT_META=3Dm
CONFIG_NFT_RT=3Dm
CONFIG_NFT_NUMGEN=3Dm
CONFIG_NFT_CT=3Dm
CONFIG_NFT_SET_RBTREE=3Dm
CONFIG_NFT_SET_HASH=3Dm
CONFIG_NFT_SET_BITMAP=3Dm
CONFIG_NFT_COUNTER=3Dm
CONFIG_NFT_LOG=3Dm
CONFIG_NFT_LIMIT=3Dm
CONFIG_NFT_MASQ=3Dm
CONFIG_NFT_REDIR=3Dm
CONFIG_NFT_NAT=3Dm
CONFIG_NFT_OBJREF=3Dm
CONFIG_NFT_QUEUE=3Dm
CONFIG_NFT_QUOTA=3Dm
CONFIG_NFT_REJECT=3Dm
CONFIG_NFT_REJECT_INET=3Dm
CONFIG_NFT_COMPAT=3Dm
CONFIG_NFT_HASH=3Dm
CONFIG_NFT_FIB=3Dm
CONFIG_NFT_FIB_INET=3Dm
CONFIG_NF_DUP_NETDEV=3Dm
CONFIG_NFT_DUP_NETDEV=3Dm
CONFIG_NFT_FWD_NETDEV=3Dm
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
# CONFIG_NETFILTER_XT_MATCH_CGROUP is not set
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
CONFIG_IP_SET_HASH_IPMAC=3Dm
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
CONFIG_NF_SOCKET_IPV4=3Dm
CONFIG_NF_TABLES_IPV4=3Dm
CONFIG_NFT_CHAIN_ROUTE_IPV4=3Dm
CONFIG_NFT_REJECT_IPV4=3Dm
CONFIG_NFT_DUP_IPV4=3Dm
CONFIG_NFT_FIB_IPV4=3Dm
CONFIG_NF_TABLES_ARP=3Dm
CONFIG_NF_DUP_IPV4=3Dm
CONFIG_NF_LOG_ARP=3Dm
CONFIG_NF_LOG_IPV4=3Dm
CONFIG_NF_REJECT_IPV4=3Dm
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
CONFIG_IP_NF_ARPTABLES=3Dm
CONFIG_IP_NF_ARPFILTER=3Dm
CONFIG_IP_NF_ARP_MANGLE=3Dm

#
# IPv6: Netfilter Configuration
#
CONFIG_NF_DEFRAG_IPV6=3Dm
CONFIG_NF_CONNTRACK_IPV6=3Dm
CONFIG_NF_SOCKET_IPV6=3Dm
CONFIG_NF_TABLES_IPV6=3Dm
CONFIG_NFT_CHAIN_ROUTE_IPV6=3Dm
CONFIG_NFT_REJECT_IPV6=3Dm
CONFIG_NFT_DUP_IPV6=3Dm
CONFIG_NFT_FIB_IPV6=3Dm
CONFIG_NF_DUP_IPV6=3Dm
CONFIG_NF_REJECT_IPV6=3Dm
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
CONFIG_IP6_NF_NAT=3Dm
CONFIG_IP6_NF_TARGET_MASQUERADE=3Dm
CONFIG_IP6_NF_TARGET_NPT=3Dm
CONFIG_NF_TABLES_BRIDGE=3Dm
CONFIG_NFT_BRIDGE_META=3Dm
CONFIG_NFT_BRIDGE_REJECT=3Dm
CONFIG_NF_LOG_BRIDGE=3Dm
# CONFIG_BRIDGE_NF_EBTABLES is not set
# CONFIG_IP_DCCP is not set
# CONFIG_IP_SCTP is not set
# CONFIG_RDS is not set
# CONFIG_TIPC is not set
# CONFIG_ATM is not set
# CONFIG_L2TP is not set
CONFIG_STP=3Dm
CONFIG_GARP=3Dm
CONFIG_MRP=3Dm
CONFIG_BRIDGE=3Dm
CONFIG_BRIDGE_IGMP_SNOOPING=3Dy
CONFIG_BRIDGE_VLAN_FILTERING=3Dy
CONFIG_HAVE_NET_DSA=3Dy
# CONFIG_NET_DSA is not set
CONFIG_VLAN_8021Q=3Dm
CONFIG_VLAN_8021Q_GVRP=3Dy
CONFIG_VLAN_8021Q_MVRP=3Dy
# CONFIG_DECNET is not set
CONFIG_LLC=3Dm
# CONFIG_LLC2 is not set
# CONFIG_IPX is not set
# CONFIG_ATALK is not set
# CONFIG_X25 is not set
# CONFIG_LAPB is not set
# CONFIG_PHONET is not set
# CONFIG_6LOWPAN is not set
# CONFIG_IEEE802154 is not set
CONFIG_NET_SCHED=3Dy

#
# Queueing/Scheduling
#
CONFIG_NET_SCH_CBQ=3Dm
CONFIG_NET_SCH_HTB=3Dm
CONFIG_NET_SCH_HFSC=3Dm
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
# CONFIG_NET_SCH_DEFAULT is not set

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
# CONFIG_NET_CLS_CGROUP is not set
CONFIG_NET_CLS_BPF=3Dm
CONFIG_NET_CLS_FLOWER=3Dm
CONFIG_NET_CLS_MATCHALL=3Dm
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
# CONFIG_NET_ACT_SAMPLE is not set
CONFIG_NET_ACT_IPT=3Dm
CONFIG_NET_ACT_NAT=3Dm
CONFIG_NET_ACT_PEDIT=3Dm
CONFIG_NET_ACT_SIMP=3Dm
CONFIG_NET_ACT_SKBEDIT=3Dm
CONFIG_NET_ACT_CSUM=3Dm
CONFIG_NET_ACT_VLAN=3Dm
CONFIG_NET_ACT_BPF=3Dm
CONFIG_NET_ACT_CONNMARK=3Dm
CONFIG_NET_ACT_SKBMOD=3Dm
# CONFIG_NET_ACT_IFE is not set
CONFIG_NET_ACT_TUNNEL_KEY=3Dm
CONFIG_NET_CLS_IND=3Dy
CONFIG_NET_SCH_FIFO=3Dy
# CONFIG_DCB is not set
CONFIG_DNS_RESOLVER=3Dy
# CONFIG_BATMAN_ADV is not set
# CONFIG_OPENVSWITCH is not set
# CONFIG_VSOCKETS is not set
# CONFIG_NETLINK_DIAG is not set
# CONFIG_MPLS is not set
# CONFIG_HSR is not set
# CONFIG_NET_SWITCHDEV is not set
# CONFIG_NET_L3_MASTER_DEV is not set
# CONFIG_NET_NCSI is not set
CONFIG_RPS=3Dy
CONFIG_RFS_ACCEL=3Dy
CONFIG_XPS=3Dy
# CONFIG_CGROUP_NET_PRIO is not set
# CONFIG_CGROUP_NET_CLASSID is not set
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
# CONFIG_AF_KCM is not set
# CONFIG_STREAM_PARSER is not set
CONFIG_FIB_RULES=3Dy
# CONFIG_WIRELESS is not set
# CONFIG_WIMAX is not set
# CONFIG_RFKILL is not set
# CONFIG_NET_9P is not set
# CONFIG_CAIF is not set
# CONFIG_CEPH_LIB is not set
# CONFIG_NFC is not set
# CONFIG_PSAMPLE is not set
# CONFIG_NET_IFE is not set
CONFIG_LWTUNNEL=3Dy
# CONFIG_LWTUNNEL_BPF is not set
CONFIG_DST_CACHE=3Dy
CONFIG_GRO_CELLS=3Dy
# CONFIG_NET_DEVLINK is not set
CONFIG_MAY_USE_DEVLINK=3Dy
CONFIG_HAVE_EBPF_JIT=3Dy

#
# Device Drivers
#

#
# Generic Driver Options
#
CONFIG_UEVENT_HELPER=3Dy
CONFIG_UEVENT_HELPER_PATH=3D"/sbin/hotplug"
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
# CONFIG_DEBUG_TEST_DRIVER_REMOVE is not set
# CONFIG_TEST_ASYNC_DRIVER_PROBE is not set
# CONFIG_SYS_HYPERVISOR is not set
# CONFIG_GENERIC_CPU_DEVICES is not set
# CONFIG_DMA_SHARED_BUFFER is not set

#
# Bus devices
#
CONFIG_CONNECTOR=3Dm
# CONFIG_MTD is not set
CONFIG_OF=3Dy
CONFIG_OF_PROMTREE=3Dy
CONFIG_OF_NET=3Dy
CONFIG_OF_MDIO=3Dy
CONFIG_OF_PCI=3Dy
# CONFIG_OF_OVERLAY is not set
CONFIG_ARCH_MIGHT_HAVE_PC_PARPORT=3Dy
CONFIG_PARPORT=3Dm
# CONFIG_PARPORT_PC is not set
# CONFIG_PARPORT_GSC is not set
CONFIG_PARPORT_SUNBPP=3Dm
# CONFIG_PARPORT_AX88796 is not set
# CONFIG_PARPORT_1284 is not set
CONFIG_PARPORT_NOT_PC=3Dy
CONFIG_BLK_DEV=3Dy
# CONFIG_BLK_DEV_NULL_BLK is not set
# CONFIG_BLK_DEV_FD is not set
# CONFIG_BLK_DEV_PCIESSD_MTIP32XX is not set
# CONFIG_BLK_CPQ_CISS_DA is not set
# CONFIG_BLK_DEV_DAC960 is not set
# CONFIG_BLK_DEV_UMEM is not set
# CONFIG_BLK_DEV_COW_COMMON is not set
CONFIG_BLK_DEV_LOOP=3Dm
CONFIG_BLK_DEV_LOOP_MIN_COUNT=3D8
# CONFIG_BLK_DEV_CRYPTOLOOP is not set
# CONFIG_BLK_DEV_DRBD is not set
# CONFIG_BLK_DEV_NBD is not set
# CONFIG_BLK_DEV_SKD is not set
# CONFIG_BLK_DEV_SX8 is not set
# CONFIG_BLK_DEV_RAM is not set
# CONFIG_CDROM_PKTCDVD is not set
# CONFIG_ATA_OVER_ETH is not set
# CONFIG_BLK_DEV_RBD is not set
# CONFIG_BLK_DEV_RSXX is not set
# CONFIG_BLK_DEV_NVME is not set
# CONFIG_NVME_FC is not set

#
# Misc devices
#
# CONFIG_SENSORS_LIS3LV02D is not set
# CONFIG_DUMMY_IRQ is not set
# CONFIG_PHANTOM is not set
# CONFIG_SGI_IOC4 is not set
# CONFIG_TIFM_CORE is not set
# CONFIG_ENCLOSURE_SERVICES is not set
# CONFIG_HP_ILO is not set
# CONFIG_SRAM is not set
# CONFIG_PCI_ENDPOINT_TEST is not set
# CONFIG_C2PORT is not set

#
# EEPROM support
#
# CONFIG_EEPROM_93CX6 is not set
# CONFIG_CB710_CORE is not set

#
# Texas Instruments shared transport line discipline
#

#
# Altera FPGA firmware download module
#

#
# Intel MIC Bus Driver
#

#
# SCIF Bus Driver
#

#
# VOP Bus Driver
#

#
# Intel MIC Host Driver
#

#
# Intel MIC Card Driver
#

#
# SCIF Driver
#

#
# Intel MIC Coprocessor State Management (COSM) Drivers
#

#
# VOP Driver
#
# CONFIG_GENWQE is not set
# CONFIG_ECHO is not set
# CONFIG_CXL_BASE is not set
# CONFIG_CXL_AFU_DRIVER_OPS is not set
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
CONFIG_SCSI_CONSTANTS=3Dy
CONFIG_SCSI_LOGGING=3Dy
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
# CONFIG_SCSI_ADVANSYS is not set
# CONFIG_SCSI_ARCMSR is not set
# CONFIG_SCSI_ESAS2R is not set
# CONFIG_MEGARAID_NEWGEN is not set
# CONFIG_MEGARAID_LEGACY is not set
# CONFIG_MEGARAID_SAS is not set
# CONFIG_SCSI_MPT3SAS is not set
# CONFIG_SCSI_MPT2SAS is not set
# CONFIG_SCSI_SMARTPQI is not set
# CONFIG_SCSI_UFSHCD is not set
# CONFIG_SCSI_HPTIOP is not set
# CONFIG_LIBFC is not set
# CONFIG_SCSI_SNIC is not set
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
# CONFIG_SCSI_QLA_ISCSI is not set
CONFIG_SCSI_LPFC=3Dm
# CONFIG_SCSI_DC395x is not set
# CONFIG_SCSI_AM53C974 is not set
# CONFIG_SCSI_WD719X is not set
# CONFIG_SCSI_DEBUG is not set
# CONFIG_SCSI_SUNESP is not set
# CONFIG_SCSI_PMCRAID is not set
# CONFIG_SCSI_PM8001 is not set
# CONFIG_SCSI_BFA_FC is not set
# CONFIG_SCSI_CHELSIO_FCOE is not set
# CONFIG_SCSI_DH is not set
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
CONFIG_DM_MQ_DEFAULT=3Dy
# CONFIG_DM_DEBUG is not set
CONFIG_DM_BUFIO=3Dm
# CONFIG_DM_DEBUG_BLOCK_MANAGER_LOCKING is not set
CONFIG_DM_BIO_PRISON=3Dm
CONFIG_DM_PERSISTENT_DATA=3Dm
CONFIG_DM_CRYPT=3Dm
CONFIG_DM_SNAPSHOT=3Dm
CONFIG_DM_THIN_PROVISIONING=3Dm
# CONFIG_DM_CACHE is not set
# CONFIG_DM_ERA is not set
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
CONFIG_DM_VERITY_FEC=3Dy
# CONFIG_DM_SWITCH is not set
CONFIG_DM_LOG_WRITES=3Dm
CONFIG_DM_INTEGRITY=3Dm
# CONFIG_TARGET_CORE is not set
# CONFIG_FUSION is not set

#
# IEEE 1394 (FireWire) support
#
# CONFIG_FIREWIRE is not set
# CONFIG_FIREWIRE_NOSY is not set
CONFIG_NETDEVICES=3Dy
CONFIG_NET_CORE=3Dy
# CONFIG_BONDING is not set
# CONFIG_DUMMY is not set
# CONFIG_EQUALIZER is not set
# CONFIG_NET_FC is not set
# CONFIG_IFB is not set
# CONFIG_NET_TEAM is not set
# CONFIG_MACVLAN is not set
# CONFIG_VXLAN is not set
# CONFIG_MACSEC is not set
# CONFIG_NETCONSOLE is not set
# CONFIG_NETPOLL is not set
# CONFIG_NET_POLL_CONTROLLER is not set
# CONFIG_TUN is not set
# CONFIG_TUN_VNET_CROSS_LE is not set
# CONFIG_VETH is not set
# CONFIG_NLMON is not set
CONFIG_SUNGEM_PHY=3Dm
# CONFIG_ARCNET is not set

#
# CAIF transport drivers
#

#
# Distributed Switch Architecture drivers
#
CONFIG_ETHERNET=3Dy
# CONFIG_NET_VENDOR_3COM is not set
# CONFIG_NET_VENDOR_ADAPTEC is not set
# CONFIG_GRETH is not set
# CONFIG_NET_VENDOR_AGERE is not set
# CONFIG_NET_VENDOR_ALACRITECH is not set
# CONFIG_NET_VENDOR_ALTEON is not set
# CONFIG_ALTERA_TSE is not set
# CONFIG_NET_VENDOR_AMAZON is not set
# CONFIG_NET_VENDOR_AMD is not set
# CONFIG_NET_VENDOR_AQUANTIA is not set
# CONFIG_NET_VENDOR_ARC is not set
# CONFIG_NET_VENDOR_ATHEROS is not set
# CONFIG_NET_VENDOR_AURORA is not set
# CONFIG_NET_CADENCE is not set
CONFIG_NET_VENDOR_BROADCOM=3Dy
# CONFIG_B44 is not set
# CONFIG_BCMGENET is not set
# CONFIG_BNX2 is not set
# CONFIG_CNIC is not set
CONFIG_TIGON3=3Dm
CONFIG_TIGON3_HWMON=3Dy
# CONFIG_BNX2X is not set
# CONFIG_SYSTEMPORT is not set
# CONFIG_BNXT is not set
# CONFIG_NET_VENDOR_BROCADE is not set
# CONFIG_NET_VENDOR_CAVIUM is not set
# CONFIG_NET_VENDOR_CHELSIO is not set
# CONFIG_NET_VENDOR_CISCO is not set
# CONFIG_DNET is not set
# CONFIG_NET_VENDOR_DEC is not set
# CONFIG_NET_VENDOR_DLINK is not set
# CONFIG_NET_VENDOR_EMULEX is not set
# CONFIG_NET_VENDOR_EZCHIP is not set
# CONFIG_NET_VENDOR_EXAR is not set
# CONFIG_NET_VENDOR_HP is not set
# CONFIG_NET_VENDOR_INTEL is not set
# CONFIG_JME is not set
CONFIG_NET_VENDOR_MARVELL=3Dy
# CONFIG_MVMDIO is not set
CONFIG_SKGE=3Dm
CONFIG_SKGE_GENESIS=3Dy
CONFIG_SKY2=3Dm
# CONFIG_NET_VENDOR_MELLANOX is not set
# CONFIG_NET_VENDOR_MICREL is not set
# CONFIG_NET_VENDOR_MYRI is not set
# CONFIG_FEALNX is not set
# CONFIG_NET_VENDOR_NATSEMI is not set
# CONFIG_NET_VENDOR_NETRONOME is not set
# CONFIG_NET_VENDOR_NVIDIA is not set
# CONFIG_NET_VENDOR_OKI is not set
# CONFIG_ETHOC is not set
# CONFIG_NET_PACKET_ENGINE is not set
# CONFIG_NET_VENDOR_QLOGIC is not set
# CONFIG_NET_VENDOR_QUALCOMM is not set
# CONFIG_NET_VENDOR_REALTEK is not set
# CONFIG_NET_VENDOR_RENESAS is not set
# CONFIG_NET_VENDOR_RDC is not set
# CONFIG_NET_VENDOR_ROCKER is not set
# CONFIG_NET_VENDOR_SAMSUNG is not set
# CONFIG_NET_VENDOR_SEEQ is not set
# CONFIG_NET_VENDOR_SILAN is not set
# CONFIG_NET_VENDOR_SIS is not set
# CONFIG_NET_VENDOR_SOLARFLARE is not set
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
# CONFIG_NET_VENDOR_SYNOPSYS is not set
# CONFIG_FDDI is not set
# CONFIG_HIPPI is not set
CONFIG_MDIO_DEVICE=3Dy
# CONFIG_MDIO_BCM_UNIMAC is not set
# CONFIG_MDIO_BITBANG is not set
# CONFIG_MDIO_BUS_MUX_MMIOREG is not set
# CONFIG_MDIO_HISI_FEMAC is not set
# CONFIG_MDIO_OCTEON is not set
# CONFIG_MDIO_THUNDER is not set
CONFIG_PHYLIB=3Dy
CONFIG_SWPHY=3Dy

#
# MII PHY device drivers
#
# CONFIG_AMD_PHY is not set
# CONFIG_AQUANTIA_PHY is not set
# CONFIG_AT803X_PHY is not set
# CONFIG_BCM7XXX_PHY is not set
# CONFIG_BCM87XX_PHY is not set
# CONFIG_BROADCOM_PHY is not set
# CONFIG_CICADA_PHY is not set
# CONFIG_DAVICOM_PHY is not set
# CONFIG_DP83848_PHY is not set
# CONFIG_DP83867_PHY is not set
CONFIG_FIXED_PHY=3Dy
# CONFIG_ICPLUS_PHY is not set
# CONFIG_INTEL_XWAY_PHY is not set
# CONFIG_LSI_ET1011C_PHY is not set
# CONFIG_LXT_PHY is not set
# CONFIG_MARVELL_PHY is not set
# CONFIG_MICREL_PHY is not set
# CONFIG_MICROCHIP_PHY is not set
# CONFIG_MICROSEMI_PHY is not set
# CONFIG_NATIONAL_PHY is not set
# CONFIG_QSEMI_PHY is not set
# CONFIG_REALTEK_PHY is not set
# CONFIG_SMSC_PHY is not set
# CONFIG_STE10XP is not set
# CONFIG_TERANETICS_PHY is not set
# CONFIG_VITESSE_PHY is not set
# CONFIG_XILINX_GMII2RGMII is not set
# CONFIG_PLIP is not set
# CONFIG_PPP is not set
# CONFIG_SLIP is not set

#
# Host-side USB support is needed for USB Network Adapter support
#
# CONFIG_WLAN is not set

#
# Enable WiMAX (Networking options) to see the WiMAX drivers
#
# CONFIG_WAN is not set
# CONFIG_VMXNET3 is not set
# CONFIG_ISDN is not set
# CONFIG_NVM is not set

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
# CONFIG_INPUT_E3X0_BUTTON is not set
CONFIG_INPUT_SPARCSPKR=3Dy
# CONFIG_INPUT_UINPUT is not set
# CONFIG_INPUT_ADXL34X is not set
# CONFIG_INPUT_CMA3000 is not set
# CONFIG_RMI4_CORE is not set

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
# CONFIG_SERIAL_UARTLITE is not set
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
# CONFIG_SERIAL_GRLIB_GAISLER_APBUART is not set
# CONFIG_SERIAL_ALTERA_JTAGUART is not set
# CONFIG_SERIAL_ALTERA_UART is not set
# CONFIG_SERIAL_XILINX_PS_UART is not set
# CONFIG_SERIAL_ARC is not set
# CONFIG_SERIAL_RP2 is not set
# CONFIG_SERIAL_FSL_LPUART is not set
# CONFIG_SERIAL_CONEXANT_DIGICOLOR is not set
# CONFIG_SERIAL_DEV_BUS is not set
# CONFIG_PRINTER is not set
# CONFIG_PPDEV is not set
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
# CONFIG_I2C is not set
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
# CONFIG_PPS_CLIENT_PARPORT is not set
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
# CONFIG_GPIOLIB is not set
# CONFIG_W1 is not set
# CONFIG_POWER_AVS is not set
# CONFIG_POWER_RESET is not set
# CONFIG_POWER_SUPPLY is not set
CONFIG_HWMON=3Dm
# CONFIG_HWMON_VID is not set
# CONFIG_HWMON_DEBUG_CHIP is not set

#
# Native drivers
#
# CONFIG_SENSORS_ASPEED is not set
# CONFIG_SENSORS_I5K_AMB is not set
# CONFIG_SENSORS_F71805F is not set
# CONFIG_SENSORS_F71882FG is not set
# CONFIG_SENSORS_IT87 is not set
# CONFIG_SENSORS_MAX197 is not set
# CONFIG_SENSORS_PC87360 is not set
# CONFIG_SENSORS_PC87427 is not set
# CONFIG_SENSORS_NTC_THERMISTOR is not set
# CONFIG_SENSORS_NCT6683 is not set
# CONFIG_SENSORS_NCT6775 is not set
# CONFIG_SENSORS_SIS5595 is not set
# CONFIG_SENSORS_SMSC47M1 is not set
# CONFIG_SENSORS_SMSC47B397 is not set
# CONFIG_SENSORS_SCH56XX_COMMON is not set
# CONFIG_SENSORS_SCH5627 is not set
# CONFIG_SENSORS_SCH5636 is not set
# CONFIG_SENSORS_VIA686A is not set
# CONFIG_SENSORS_VT1211 is not set
# CONFIG_SENSORS_VT8231 is not set
# CONFIG_SENSORS_W83627HF is not set
# CONFIG_SENSORS_W83627EHF is not set
# CONFIG_SENSORS_ULTRA45 is not set
# CONFIG_THERMAL is not set
CONFIG_WATCHDOG=3Dy
CONFIG_WATCHDOG_CORE=3Dy
# CONFIG_WATCHDOG_NOWAYOUT is not set
# CONFIG_WATCHDOG_SYSFS is not set

#
# Watchdog Device Drivers
#
CONFIG_SOFT_WATCHDOG=3Dm
# CONFIG_XILINX_WATCHDOG is not set
# CONFIG_CADENCE_WATCHDOG is not set
# CONFIG_DW_WATCHDOG is not set
# CONFIG_MAX63XX_WATCHDOG is not set
# CONFIG_ALIM7101_WDT is not set
# CONFIG_I6300ESB_WDT is not set
# CONFIG_WATCHDOG_CP1XXX is not set
# CONFIG_WATCHDOG_RIO is not set
# CONFIG_WATCHDOG_SUN4V is not set

#
# PCI-based Watchdog Cards
#
# CONFIG_PCIPCWATCHDOG is not set
# CONFIG_WDTPCI is not set

#
# Watchdog Pretimeout Governors
#
# CONFIG_WATCHDOG_PRETIMEOUT_GOV is not set
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
# CONFIG_MFD_ATMEL_FLEXCOM is not set
# CONFIG_MFD_ATMEL_HLCDC is not set
# CONFIG_MFD_HI6421_PMIC is not set
# CONFIG_HTC_PASIC3 is not set
# CONFIG_LPC_ICH is not set
# CONFIG_LPC_SCH is not set
# CONFIG_MFD_JANZ_CMODIO is not set
# CONFIG_MFD_KEMPLD is not set
# CONFIG_MFD_MT6397 is not set
# CONFIG_MFD_RDC321X is not set
# CONFIG_MFD_RTSX_PCI is not set
# CONFIG_MFD_SM501 is not set
# CONFIG_ABX500_CORE is not set
# CONFIG_MFD_SYSCON is not set
# CONFIG_MFD_TI_AM335X_TSCADC is not set
# CONFIG_MFD_TMIO is not set
# CONFIG_MFD_VX855 is not set
# CONFIG_REGULATOR is not set
# CONFIG_MEDIA_SUPPORT is not set

#
# Graphics support
#
CONFIG_VGA_ARB=3Dy
CONFIG_VGA_ARB_MAX_GPUS=16
# CONFIG_DRM is not set

#
# ACP (Audio CoProcessor) Configuration
#
# CONFIG_DRM_LIB_RANDOM is not set

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
# CONFIG_HID is not set
CONFIG_USB_OHCI_LITTLE_ENDIAN=3Dy
# CONFIG_USB_SUPPORT is not set
# CONFIG_UWB is not set
# CONFIG_MMC is not set
# CONFIG_MEMSTICK is not set
# CONFIG_NEW_LEDS is not set
# CONFIG_ACCESSIBILITY is not set
# CONFIG_INFINIBAND is not set
CONFIG_RTC_LIB=3Dy
CONFIG_RTC_MC146818_LIB=3Dy
CONFIG_RTC_CLASS=3Dy
CONFIG_RTC_HCTOSYS=3Dy
CONFIG_RTC_HCTOSYS_DEVICE=3D"rtc0"
CONFIG_RTC_SYSTOHC=3Dy
CONFIG_RTC_SYSTOHC_DEVICE=3D"rtc0"
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

#
# SPI RTC drivers
#

#
# SPI and I2C RTC drivers
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
# CONFIG_RTC_DRV_ZYNQMP is not set

#
# on-CPU RTC drivers
#
CONFIG_RTC_DRV_SUN4V=3Dy
CONFIG_RTC_DRV_STARFIRE=3Dy
# CONFIG_RTC_DRV_SNVS is not set
# CONFIG_RTC_DRV_R7301 is not set

#
# HID Sensor RTC drivers
#
# CONFIG_DMADEVICES is not set

#
# DMABUF options
#
# CONFIG_SYNC_FILE is not set
# CONFIG_AUXDISPLAY is not set
# CONFIG_PANEL is not set
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
# CONFIG_HYPERV_TSCPAGE is not set
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
# CONFIG_REMOTEPROC is not set

#
# Rpmsg drivers
#

#
# SOC (System On Chip) specific Drivers
#

#
# Broadcom SoC drivers
#

#
# i.MX SoC drivers
#
# CONFIG_SUNXI_SRAM is not set
# CONFIG_SOC_TI is not set
# CONFIG_SOC_ZTE is not set
# CONFIG_PM_DEVFREQ is not set
# CONFIG_EXTCON is not set
# CONFIG_MEMORY is not set
# CONFIG_IIO is not set
# CONFIG_NTB is not set
# CONFIG_VME_BUS is not set
# CONFIG_PWM is not set
CONFIG_ARM_GIC_MAX_NR=3D1
# CONFIG_IPACK_BUS is not set
# CONFIG_RESET_CONTROLLER is not set
# CONFIG_FMC is not set

#
# PHY Subsystem
#
# CONFIG_GENERIC_PHY is not set
# CONFIG_PHY_PXA_28NM_HSIC is not set
# CONFIG_PHY_PXA_28NM_USB2 is not set
# CONFIG_BCM_KONA_USB2_PHY is not set
# CONFIG_POWERCAP is not set
# CONFIG_MCB is not set

#
# Performance monitor support
#
# CONFIG_RAS is not set

#
# Android
#
# CONFIG_ANDROID is not set
# CONFIG_LIBNVDIMM is not set
CONFIG_DAX=3Dm
# CONFIG_NVMEM is not set
# CONFIG_STM is not set
# CONFIG_INTEL_TH is not set

#
# FPGA Configuration Support
#
# CONFIG_FPGA is not set

#
# FSI support
#
# CONFIG_FSI is not set

#
# Misc Linux/SPARC drivers
#
CONFIG_SUN_OPENPROMIO=3Dm
CONFIG_OBP_FLASH=3Dm
# CONFIG_TADPOLE_TS102_UCTRL is not set
# CONFIG_BBC_I2C is not set
# CONFIG_ENVCTRL is not set
# CONFIG_DISPLAY7SEG is not set

#
# File systems
#
# CONFIG_EXT2_FS is not set
# CONFIG_EXT3_FS is not set
CONFIG_EXT4_FS=3Dy
CONFIG_EXT4_USE_FOR_EXT2=3Dy
CONFIG_EXT4_FS_POSIX_ACL=3Dy
CONFIG_EXT4_FS_SECURITY=3Dy
CONFIG_EXT4_ENCRYPTION=3Dy
CONFIG_EXT4_FS_ENCRYPTION=3Dy
# CONFIG_EXT4_DEBUG is not set
CONFIG_JBD2=3Dy
# CONFIG_JBD2_DEBUG is not set
CONFIG_FS_MBCACHE=3Dy
# CONFIG_REISERFS_FS is not set
# CONFIG_JFS_FS is not set
# CONFIG_XFS_FS is not set
# CONFIG_GFS2_FS is not set
# CONFIG_BTRFS_FS is not set
# CONFIG_NILFS2_FS is not set
# CONFIG_F2FS_FS is not set
CONFIG_FS_POSIX_ACL=3Dy
CONFIG_EXPORTFS=3Dy
CONFIG_EXPORTFS_BLOCK_OPS=3Dy
CONFIG_FILE_LOCKING=3Dy
CONFIG_MANDATORY_FILE_LOCKING=3Dy
CONFIG_FS_ENCRYPTION=3Dy
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
CONFIG_FAT_DEFAULT_UTF8=3Dy
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
# CONFIG_PROC_CHILDREN is not set
CONFIG_KERNFS=3Dy
CONFIG_SYSFS=3Dy
CONFIG_TMPFS=3Dy
CONFIG_TMPFS_POSIX_ACL=3Dy
CONFIG_TMPFS_XATTR=3Dy
CONFIG_HUGETLBFS=3Dy
CONFIG_HUGETLB_PAGE=3Dy
# CONFIG_CONFIGFS_FS is not set
CONFIG_MISC_FILESYSTEMS=3Dy
# CONFIG_ORANGEFS_FS is not set
# CONFIG_ADFS_FS is not set
# CONFIG_AFFS_FS is not set
# CONFIG_ECRYPT_FS is not set
# CONFIG_HFS_FS is not set
# CONFIG_HFSPLUS_FS is not set
# CONFIG_BEFS_FS is not set
# CONFIG_BFS_FS is not set
# CONFIG_EFS_FS is not set
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
# CONFIG_NFS_FSCACHE is not set
# CONFIG_NFS_USE_LEGACY_DNS is not set
CONFIG_NFS_USE_KERNEL_DNS=3Dy
CONFIG_NFSD=3Dm
CONFIG_NFSD_V2_ACL=3Dy
CONFIG_NFSD_V3=3Dy
CONFIG_NFSD_V3_ACL=3Dy
CONFIG_NFSD_V4=3Dy
CONFIG_NFSD_PNFS=3Dy
CONFIG_NFSD_BLOCKLAYOUT=3Dy
CONFIG_NFSD_SCSILAYOUT=3Dy
CONFIG_NFSD_FLEXFILELAYOUT=3Dy
CONFIG_GRACE_PERIOD=3Dm
CONFIG_LOCKD=3Dm
CONFIG_LOCKD_V4=3Dy
CONFIG_NFS_ACL_SUPPORT=3Dm
CONFIG_NFS_COMMON=3Dy
CONFIG_SUNRPC=3Dm
CONFIG_SUNRPC_GSS=3Dm
CONFIG_SUNRPC_BACKCHANNEL=3Dy
CONFIG_RPCSEC_GSS_KRB5=3Dm
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
CONFIG_CIFS_SMB311=3Dy
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

#
# Kernel hacking
#
CONFIG_TRACE_IRQFLAGS_SUPPORT=3Dy

#
# printk and dmesg options
#
CONFIG_PRINTK_TIME=3Dy
CONFIG_CONSOLE_LOGLEVEL_DEFAULT=3D7
CONFIG_MESSAGE_LOGLEVEL_DEFAULT=3D4
# CONFIG_BOOT_PRINTK_DELAY is not set

#
# Compile-time checks and compiler options
#
# CONFIG_DEBUG_INFO is not set
# CONFIG_ENABLE_WARN_DEPRECATED is not set
# CONFIG_ENABLE_MUST_CHECK is not set
CONFIG_FRAME_WARN 48
CONFIG_STRIP_ASM_SYMS=3Dy
# CONFIG_READABLE_ASM is not set
# CONFIG_UNUSED_SYMBOLS is not set
# CONFIG_PAGE_OWNER is not set
# CONFIG_DEBUG_FS is not set
# CONFIG_HEADERS_CHECK is not set
# CONFIG_DEBUG_SECTION_MISMATCH is not set
CONFIG_SECTION_MISMATCH_WARN_ONLY=3Dy
CONFIG_FRAME_POINTER=3Dy
CONFIG_DEBUG_FORCE_WEAK_PER_CPU=3Dy
CONFIG_MAGIC_SYSRQ=3Dy
CONFIG_MAGIC_SYSRQ_DEFAULT_ENABLE=3D0x1
CONFIG_MAGIC_SYSRQ_SERIAL=3Dy
CONFIG_DEBUG_KERNEL=3Dy

#
# Memory Debugging
#
CONFIG_PAGE_EXTENSION=3Dy
CONFIG_PAGE_POISONING=3Dy
CONFIG_PAGE_POISONING_NO_SANITY=3Dy
# CONFIG_PAGE_POISONING_ZERO is not set
# CONFIG_DEBUG_OBJECTS is not set
# CONFIG_SLUB_DEBUG_ON is not set
# CONFIG_SLUB_STATS is not set
CONFIG_HAVE_DEBUG_KMEMLEAK=3Dy
# CONFIG_DEBUG_KMEMLEAK is not set
CONFIG_DEBUG_STACK_USAGE=3Dy
# CONFIG_DEBUG_VM is not set
CONFIG_DEBUG_MEMORY_INIT=3Dy
# CONFIG_DEBUG_PER_CPU_MAPS is not set
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
CONFIG_WQ_WATCHDOG=3Dy
# CONFIG_PANIC_ON_OOPS is not set
CONFIG_PANIC_ON_OOPS_VALUE=3D0
CONFIG_PANIC_TIMEOUT=3D0
# CONFIG_SCHED_DEBUG is not set
CONFIG_SCHED_INFO=3Dy
CONFIG_SCHEDSTATS=3Dy
CONFIG_SCHED_STACK_END_CHECK=3Dy
# CONFIG_DEBUG_TIMEKEEPING is not set

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
CONFIG_LOCKDEP_SMALL=3Dy
# CONFIG_LOCK_STAT is not set
# CONFIG_DEBUG_LOCKDEP is not set
CONFIG_DEBUG_ATOMIC_SLEEP=3Dy
CONFIG_DEBUG_LOCKING_API_SELFTESTS=3Dy
# CONFIG_LOCK_TORTURE_TEST is not set
# CONFIG_WW_MUTEX_SELFTEST is not set
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
# CONFIG_RCU_PERF_TEST is not set
# CONFIG_RCU_TORTURE_TEST is not set
CONFIG_RCU_CPU_STALL_TIMEOUT`
# CONFIG_RCU_TRACE is not set
# CONFIG_RCU_EQS_DEBUG is not set
# CONFIG_DEBUG_WQ_FORCE_RR_CPU is not set
CONFIG_DEBUG_BLOCK_EXT_DEVT=3Dy
# CONFIG_CPU_HOTPLUG_STATE_CONTROL is not set
# CONFIG_NOTIFIER_ERROR_INJECTION is not set
# CONFIG_FAULT_INJECTION is not set
# CONFIG_LATENCYTOP is not set
CONFIG_HAVE_FUNCTION_TRACER=3Dy
CONFIG_HAVE_FUNCTION_GRAPH_TRACER=3Dy
CONFIG_HAVE_DYNAMIC_FTRACE=3Dy
CONFIG_HAVE_FTRACE_MCOUNT_RECORD=3Dy
CONFIG_HAVE_SYSCALL_TRACEPOINTS=3Dy
CONFIG_HAVE_C_RECORDMCOUNT=3Dy
CONFIG_TRACE_CLOCK=3Dy
CONFIG_RING_BUFFER=3Dy
CONFIG_RING_BUFFER_ALLOW_SWAP=3Dy
CONFIG_TRACING_SUPPORT=3Dy
# CONFIG_FTRACE is not set

#
# Runtime Testing
#
# CONFIG_TEST_LIST_SORT is not set
# CONFIG_TEST_SORT is not set
# CONFIG_BACKTRACE_SELF_TEST is not set
# CONFIG_RBTREE_TEST is not set
# CONFIG_INTERVAL_TREE_TEST is not set
# CONFIG_PERCPU_TEST is not set
# CONFIG_ATOMIC64_SELFTEST is not set
# CONFIG_ASYNC_RAID6_TEST is not set
# CONFIG_TEST_HEXDUMP is not set
# CONFIG_TEST_STRING_HELPERS is not set
# CONFIG_TEST_KSTRTOX is not set
# CONFIG_TEST_PRINTF is not set
# CONFIG_TEST_BITMAP is not set
# CONFIG_TEST_UUID is not set
# CONFIG_TEST_RHASHTABLE is not set
# CONFIG_TEST_HASH is not set
# CONFIG_DMA_API_DEBUG is not set
# CONFIG_TEST_LKM is not set
# CONFIG_TEST_USER_COPY is not set
# CONFIG_TEST_BPF is not set
# CONFIG_TEST_FIRMWARE is not set
# CONFIG_TEST_UDELAY is not set
# CONFIG_MEMTEST is not set
# CONFIG_TEST_STATIC_KEYS is not set
# CONFIG_BUG_ON_DATA_CORRUPTION is not set
# CONFIG_SAMPLES is not set
CONFIG_HAVE_ARCH_KGDB=3Dy
# CONFIG_KGDB is not set
# CONFIG_ARCH_WANTS_UBSAN_NO_NULL is not set
CONFIG_UBSAN=3Dy
CONFIG_UBSAN_ALIGNMENT=3Dy
CONFIG_UBSAN_NULL=3Dy
# CONFIG_DEBUG_DCFLUSH is not set

#
# Security options
#
CONFIG_KEYS=3Dy
CONFIG_KEYS_COMPAT=3Dy
# CONFIG_PERSISTENT_KEYRINGS is not set
# CONFIG_BIG_KEYS is not set
CONFIG_ENCRYPTED_KEYS=3Dy
# CONFIG_KEY_DH_OPERATIONS is not set
# CONFIG_SECURITY_DMESG_RESTRICT is not set
# CONFIG_SECURITY is not set
# CONFIG_SECURITYFS is not set
CONFIG_HAVE_HARDENED_USERCOPY_ALLOCATOR=3Dy
CONFIG_HARDENED_USERCOPY=3Dy
# CONFIG_STATIC_USERMODEHELPER is not set
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
CONFIG_CRYPTO_AEAD=3Dy
CONFIG_CRYPTO_AEAD2=3Dy
CONFIG_CRYPTO_BLKCIPHER=3Dy
CONFIG_CRYPTO_BLKCIPHER2=3Dy
CONFIG_CRYPTO_HASH=3Dy
CONFIG_CRYPTO_HASH2=3Dy
CONFIG_CRYPTO_RNG=3Dy
CONFIG_CRYPTO_RNG2=3Dy
CONFIG_CRYPTO_RNG_DEFAULT=3Dy
CONFIG_CRYPTO_AKCIPHER2=3Dy
CONFIG_CRYPTO_KPP2=3Dy
CONFIG_CRYPTO_ACOMP2=3Dy
# CONFIG_CRYPTO_RSA is not set
# CONFIG_CRYPTO_DH is not set
# CONFIG_CRYPTO_ECDH is not set
CONFIG_CRYPTO_MANAGER=3Dy
CONFIG_CRYPTO_MANAGER2=3Dy
# CONFIG_CRYPTO_USER is not set
CONFIG_CRYPTO_MANAGER_DISABLE_TESTS=3Dy
CONFIG_CRYPTO_GF128MUL=3Dy
CONFIG_CRYPTO_NULL=3Dy
CONFIG_CRYPTO_NULL2=3Dy
# CONFIG_CRYPTO_PCRYPT is not set
CONFIG_CRYPTO_WORKQUEUE=3Dy
# CONFIG_CRYPTO_CRYPTD is not set
# CONFIG_CRYPTO_MCRYPTD is not set
CONFIG_CRYPTO_AUTHENC=3Dm
# CONFIG_CRYPTO_TEST is not set

#
# Authenticated Encryption with Associated Data
#
CONFIG_CRYPTO_CCM=3Dm
# CONFIG_CRYPTO_GCM is not set
# CONFIG_CRYPTO_CHACHA20POLY1305 is not set
CONFIG_CRYPTO_SEQIV=3Dy
CONFIG_CRYPTO_ECHAINIV=3Dm

#
# Block modes
#
CONFIG_CRYPTO_CBC=3Dy
CONFIG_CRYPTO_CTR=3Dy
CONFIG_CRYPTO_CTS=3Dy
CONFIG_CRYPTO_ECB=3Dy
# CONFIG_CRYPTO_LRW is not set
# CONFIG_CRYPTO_PCBC is not set
CONFIG_CRYPTO_XTS=3Dy
# CONFIG_CRYPTO_KEYWRAP is not set

#
# Hash modes
#
CONFIG_CRYPTO_CMAC=3Dm
CONFIG_CRYPTO_HMAC=3Dy
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
# CONFIG_CRYPTO_POLY1305 is not set
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
CONFIG_CRYPTO_SHA256=3Dy
# CONFIG_CRYPTO_SHA256_SPARC64 is not set
# CONFIG_CRYPTO_SHA512 is not set
# CONFIG_CRYPTO_SHA512_SPARC64 is not set
# CONFIG_CRYPTO_SHA3 is not set
# CONFIG_CRYPTO_TGR192 is not set
# CONFIG_CRYPTO_WP512 is not set

#
# Ciphers
#
CONFIG_CRYPTO_AES=3Dy
# CONFIG_CRYPTO_AES_TI is not set
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
# CONFIG_CRYPTO_CHACHA20 is not set
# CONFIG_CRYPTO_SEED is not set
# CONFIG_CRYPTO_SERPENT is not set
# CONFIG_CRYPTO_TEA is not set
# CONFIG_CRYPTO_TWOFISH is not set

#
# Compression
#
CONFIG_CRYPTO_DEFLATE=3Dm
# CONFIG_CRYPTO_LZO is not set
# CONFIG_CRYPTO_842 is not set
# CONFIG_CRYPTO_LZ4 is not set
# CONFIG_CRYPTO_LZ4HC is not set

#
# Random Number Generation
#
# CONFIG_CRYPTO_ANSI_CPRNG is not set
CONFIG_CRYPTO_DRBG_MENU=3Dy
CONFIG_CRYPTO_DRBG_HMAC=3Dy
# CONFIG_CRYPTO_DRBG_HASH is not set
# CONFIG_CRYPTO_DRBG_CTR is not set
CONFIG_CRYPTO_DRBG=3Dy
CONFIG_CRYPTO_JITTERENTROPY=3Dy
# CONFIG_CRYPTO_USER_API_HASH is not set
# CONFIG_CRYPTO_USER_API_SKCIPHER is not set
# CONFIG_CRYPTO_USER_API_RNG is not set
# CONFIG_CRYPTO_USER_API_AEAD is not set
# CONFIG_CRYPTO_HW is not set
# CONFIG_ASYMMETRIC_KEY_TYPE is not set

#
# Certificates for signature checking
#
# CONFIG_SYSTEM_BLACKLIST_KEYRING is not set
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
CONFIG_REED_SOLOMON=3Dm
CONFIG_REED_SOLOMON_DEC8=3Dy
CONFIG_TEXTSEARCH=3Dy
CONFIG_TEXTSEARCH_KMP=3Dm
CONFIG_TEXTSEARCH_BM=3Dm
CONFIG_TEXTSEARCH_FSM=3Dm
CONFIG_BTREE=3Dy
CONFIG_ASSOCIATIVE_ARRAY=3Dy
CONFIG_HAS_IOMEM=3Dy
CONFIG_HAS_IOPORT_MAP=3Dy
CONFIG_HAS_DMA=3Dy
# CONFIG_DMA_NOOP_OPS is not set
# CONFIG_DMA_VIRT_OPS is not set
CONFIG_CPU_RMAP=3Dy
CONFIG_DQL=3Dy
CONFIG_NLATTR=3Dy
# CONFIG_CORDIC is not set
# CONFIG_DDR is not set
# CONFIG_IRQ_POLL is not set
CONFIG_OID_REGISTRY=3Dm
# CONFIG_SG_SPLIT is not set
CONFIG_SG_POOL=3Dy
CONFIG_ARCH_HAS_SG_CHAIN=3Dy
CONFIG_SBITMAP=3Dy

--=20
Meelis Roos (mroos@linux.ee)
