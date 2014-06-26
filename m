From: Meelis Roos <mroos@linux.ee>
Date: Thu, 26 Jun 2014 11:42:52 +0000
Subject: TLB-related lockdep warning on sparc64
Message-Id: <alpine.SOC.1.00.1406261434330.16879@math.ut.ee>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

My V480 seems to run mostly fine (if it does not hit schizo PCI error on 
boot and if I use e1000 instead of cassini and if I silence qla2xxx 
debug log) but now 3.16.0-rc2-00211-gd7933ab gave me this lockdep splat 
during aptitude run. Not reproducible as far as I can tell.

[    0.000000] PROMLIB: Sun IEEE Boot Prom 'OBP 4.30.4.c 2010/09/29 09:42'
[    0.000000] PROMLIB: Root node compatible: 
[    0.000000] Linux version 3.16.0-rc2-00211-gd7933ab-dirty (mroos@v480) (gcc version 4.6.4 (Debian 4.6.4-7) ) #16 SMP Thu Jun 26 11:45:14 EEST 2014
[    0.000000] bootconsole [earlyprom0] enabled
[    0.000000] ARCH: SUN4U
[    0.000000] Ethernet address: 00:03:ba:29:66:f1
[    0.000000] PAGE_OFFSET is 0xfffffc0000000000 (max_phys_bits = 42)
[    0.000000] Kernel: Using 7 locked TLB entries for main kernel image.
[    0.000000] Remapping the kernel... done.
[    0.000000] OF stdout device is: /pci@9,700000/ebus@1/rsc-console@1,3083f8
[    0.000000] PROM: Built device tree with 235547 bytes of memory.
[    0.000000] Top of RAM: 0xb0ffaf4000, Total RAM: 0x1ffae2000
[    0.000000] Memory hole size: 716800MB
[    0.000000]  [140000000-141ffffff] on node 0
[    0.000000]  [160000000-161ffffff] on node 0
[    0.000000] Zone ranges:
[    0.000000]   Normal   [mem 0xa000000000-0xb0ffaf3fff]
[    0.000000] Movable zone start for each node
[    0.000000] Early memory node ranges
[    0.000000]   node   0: [mem 0xa000000000-0xa0ffffffff]
[    0.000000]   node   0: [mem 0xb000000000-0xb0feffdfff]
[    0.000000]   node   0: [mem 0xb0ff000000-0xb0ffac9fff]
[    0.000000]   node   0: [mem 0xb0ffada000-0xb0ffaf3fff]
[    0.000000] On node 0 totalpages: 1047921
[    0.000000]   Normal zone: 8187 pages used for memmap
[    0.000000]   Normal zone: 0 pages reserved
[    0.000000]   Normal zone: 1047921 pages, LIFO batch:15
[    0.000000] Booting Linux...
[    0.000000] CPU CAPS: [flush,stbar,swap,muldiv,v9,ultra3,mul32,div32]
[    0.000000] CPU CAPS: [v8plus,vis,vis2]
[    0.000000] PERCPU: Embedded 6 pages/cpu @fffffcb0fb000000 s15680 r8192 d25280 u1048576
[    0.000000] pcpu-alloc: s15680 r8192 d25280 u1048576 alloc=1*4194304
[    0.000000] pcpu-alloc: [0] 0 1 2 3 
[    0.000000] Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 1039734
[    0.000000] Kernel command line: root=/dev/sda1 ro console=ttyS1
[    0.000000] PID hash table entries: 4096 (order: 2, 32768 bytes)
[    0.000000] Dentry cache hash table entries: 1048576 (order: 10, 8388608 bytes)
[    0.000000] Inode-cache hash table entries: 524288 (order: 9, 4194304 bytes)
[    0.000000] Sorting __ex_table...
[    0.000000] Memory: 8277992K/8383368K available (4377K kernel code, 440K rwdata, 1688K rodata, 200K init, 19621K bss, 105376K reserved)
[    0.000000] SLUB: HWalign2, Order=0-3, MinObjects=0, CPUs=4, Nodes=1
[    0.000000] Hierarchical RCU implementation.
[    0.000000] 	RCU lockdep checking is enabled.
[    0.000000] NR_IRQS:255
[   68.633398] clocksource: mult[64000000] shift[24]
[   68.638040] clockevent: mult[28f5c29] shift[32]
[   68.642718] Console: colour dummy device 80x25
[   68.647104] Lock dependency validator: Copyright (c) 2006 Red Hat, Inc., Ingo Molnar
[   68.654886] ... MAX_LOCKDEP_SUBCLASSES:  8
[   68.658911] ... MAX_LOCK_DEPTH:          48
[   68.663072] ... MAX_LOCKDEP_KEYS:        8191
[   68.667415] ... CLASSHASH_SIZE:          4096
[   68.671736] ... MAX_LOCKDEP_ENTRIES:     32768
[   68.676155] ... MAX_LOCKDEP_CHAINS:      65536
[   68.680585] ... CHAINHASH_SIZE:          32768
[   68.684995]  memory used by lock dependency info: 8159 kB
[   68.690368]  per task-struct memory footprint: 1920 bytes
[   68.845837] Calibrating delay using timer specific routine.. 20.02 BogoMIPS (lpj0138)
[   68.853849] pid_max: default: 32768 minimum: 301
[   68.858615] Mount-cache hash table entries: 16384 (order: 4, 131072 bytes)
[   68.865421] Mountpoint-cache hash table entries: 16384 (order: 4, 131072 bytes)
[   68.879894] CPU 0: synchronized TICK with master CPU (last diff 1 cycles, maxerr 10 cycles)
[   68.889744] CPU 1: synchronized TICK with master CPU (last diff 0 cycles, maxerr 10 cycles)
[   68.899551] CPU 2: synchronized TICK with master CPU (last diff 0 cycles, maxerr 10 cycles)
[   68.899692] Brought up 4 CPUs
[   68.910848] Testing NMI watchdog ... OK.
[   69.116532] devtmpfs: initialized
[   69.185871] kworker/u8:0 (29) used greatest stack depth: 9872 bytes left
[   69.196165] NET: Registered protocol family 16
[   69.218340] /pci@8,700000: SCHIZO PCI Bus Module ver[4:0]
[   69.223745] /pci@8,700000: PCI IO[7ffef000000] MEM[7fe00000000]
[   69.233596] PCI: Scanning PBM /pci@8,700000
[   69.237988] schizo f007fed0: PCI host bridge to bus 0000:00
[   69.243503] pci_bus 0000:00: root bus resource [io  0x7ffef000000-0x7ffefffffff] (bus address [0x0000-0xffffff])
[   69.253655] pci_bus 0000:00: root bus resource [mem 0x7fe00000000-0x7feffffffff] (bus address [0x00000000-0xffffffff])
[   69.264311] pci_bus 0000:00: root bus resource [bus 00-01]
[   69.273937] pci 0000:00:06.0: supports D1 D2
[   69.274654] /pci@8,600000: SCHIZO PCI Bus Module ver[4:0]
[   69.279997] /pci@8,600000: PCI IO[7ffed000000] MEM[7fd00000000]
[   69.289887] PCI: Scanning PBM /pci@8,600000
[   69.294203] schizo f0089b5c: PCI host bridge to bus 0001:00
[   69.299735] pci_bus 0001:00: root bus resource [io  0x7ffed000000-0x7ffedffffff] (bus address [0x0000-0xffffff])
[   69.309865] pci_bus 0001:00: root bus resource [mem 0x7fd00000000-0x7fdffffffff] (bus address [0x00000000-0xffffffff])
[   69.320522] pci_bus 0001:00: root bus resource [bus 00]
[   69.327019] /pci@9,700000: SCHIZO PCI Bus Module ver[4:0]
[   69.332384] /pci@9,700000: PCI IO[7ffeb000000] MEM[7fc00000000]
[   69.342203] PCI: Scanning PBM /pci@9,700000
[   69.346545] schizo f0091930: PCI host bridge to bus 0002:00
[   69.352060] pci_bus 0002:00: root bus resource [io  0x7ffeb000000-0x7ffebffffff] (bus address [0x0000-0xffffff])
[   69.362214] pci_bus 0002:00: root bus resource [mem 0x7fc00000000-0x7fcffffffff] (bus address [0x00000000-0xffffffff])
[   69.372871] pci_bus 0002:00: root bus resource [bus 00]
[   69.383875] /pci@9,600000: SCHIZO PCI Bus Module ver[4:0]
[   69.389215] /pci@9,600000: PCI IO[7ffe9000000] MEM[7fb00000000]
[   69.399074] PCI: Scanning PBM /pci@9,600000
[   69.403381] schizo f009b070: PCI host bridge to bus 0003:00
[   69.408909] pci_bus 0003:00: root bus resource [io  0x7ffe9000000-0x7ffe9ffffff] (bus address [0x0000-0xffffff])
[   69.419040] pci_bus 0003:00: root bus resource [mem 0x7fb00000000-0x7fbffffffff] (bus address [0x00000000-0xffffffff])
[   69.429697] pci_bus 0003:00: root bus resource [bus 00]
[   69.473087] vgaarb: loaded
[   69.476690] SCSI subsystem initialized
[   69.483034] /pci@9,700000/ebus@1/rtc@1,300070: RTC regs at 0x7fc7e300070
[   69.492063] Switched to clocksource stick
[   69.517350] NET: Registered protocol family 2
[   69.522473] TCP established hash table entries: 65536 (order: 6, 524288 bytes)
[   69.531604] TCP bind hash table entries: 65536 (order: 9, 4194304 bytes)
[   69.559013] TCP: Hash tables configured (established 65536 bind 65536)
[   69.565751] TCP: reno registered
[   69.569004] UDP hash table entries: 4096 (order: 6, 655360 bytes)
[   69.578162] UDP-Lite hash table entries: 4096 (order: 6, 655360 bytes)
[   69.588372] NET: Registered protocol family 1
[   69.592928] PCI: Enabling device: (0002:00:01.3), cmd 2
[   69.652032] PCI: CLS 64 bytes, default 64
[   69.652859] power: Control reg at 7fc7e30002e
[   69.658279] chmc: UltraSPARC-III memory controller at /memory-controller@0,400000 [ACTIVE]
[   69.666574] chmc: UltraSPARC-III memory controller at /memory-controller@1,400000 [ACTIVE]
[   69.674832] chmc: UltraSPARC-III memory controller at /memory-controller@2,400000 [ACTIVE]
[   69.683081] chmc: UltraSPARC-III memory controller at /memory-controller@3,400000 [ACTIVE]
[   69.693999] Initializing RT-Tester: OK
[   69.698953] futex hash table entries: 1024 (order: 4, 131072 bytes)
[   69.706322] HugeTLB registered 8 MB page size, pre-allocated 0 pages
[   69.739362] msgmni has been set to 16167
[   69.745082] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 252)
[   69.752479] io scheduler noop registered
[   69.757007] io scheduler cfq registered (default)
[   69.761651] start plist test
[   69.765488] end plist test
[   69.766943] f00c4b10: ttyS0 at MMIO 0x7fc7e3062f8 (irq = 24, base_baud = 115387) is a 16550A
[   69.775383] Console: ttyS1 (SU)
[   69.779087] f00c6438: ttyS1 at MMIO 0x7fc7e3083f8 (irq = 25, base_baud = 115387) is a 16550A
[   69.787493] Console: ttyS1 (SU)
[   69.790669] console [ttyS1] enabled
[   69.798285] bootconsole [earlyprom0] disabled
[   69.808754] f00c7d60: ttyS2 at MMIO 0x7fc7e400000 (irq = 26, base_baud = 115200) is a SAB82532 V3.2
[   69.819631] Console: ttyS3 (SAB82532)
[   78.843457] console [ttyS1] enabled
[   78.889880] f00c7d60: ttyS3 at MMIO 0x7fc7e400040 (irq = 26, base_baud = 115200) is a SAB82532 V3.2
[   79.008575] Serial: 8250/16550 driver, 4 ports, IRQ sharing disabled
[   79.094396] qla2xxx [0000:00:00.0]-0005: : QLogic Fibre Channel HBA Driver: 8.07.00.08-k.
[   79.201289] PCI: Enabling device: (0001:00:01.0), cmd 3
[   79.201375] qla2xxx [0001:00:01.0]-001d: : Found an ISP2312 irq 15 iobase 0x000007fd00100000.
[   79.409845] qla2xxx: NOT ACTIVATING Extended logging
[   79.772131] scsi0 : qla2xxx
[   79.811171] qla2xxx [0001:00:01.0]-00fb:0: QLogic QLA2340 - 133MHz PCI-X to 2Gb FC, Single Channel.
[   79.929456] qla2xxx [0001:00:01.0]-00fc:0: ISP2312: PCI (66 MHz) @ 0001:00:01.0 hdma- host#=0 fw=3.03.28 IPX.
[   80.059188] PCI: Enabling device: (0001:00:02.0), cmd 3
[   80.059288] qla2xxx [0001:00:02.0]-001d: : Found an ISP2312 irq 16 iobase 0x000007fd00102000.
[   80.562115] scsi1 : qla2xxx
[   80.599941] qla2xxx [0001:00:02.0]-00fb:1: QLogic QLA2340 - 133MHz PCI-X to 2Gb FC, Single Channel.
[   80.718206] qla2xxx [0001:00:02.0]-00fc:1: ISP2312: PCI (66 MHz) @ 0001:00:02.0 hdma- host#=1 fw=3.03.28 IPX.
[   80.847960] PCI: Enabling device: (0003:00:02.0), cmd 3
[   80.848006] qla2xxx [0003:00:02.0]-001d: : Found an ISP2200 irq 38 iobase 0x000007fb00400000.
[   80.960312] qla2xxx [0003:00:02.0]-0050:2: No matching ROM signature.
[   81.139323] qla2xxx [0003:00:02.0]-0064:2: Inconsistent NVRAM detected: checksum=0x0 id=\xffffffff version=0xff.
[   81.262061] qla2xxx [0003:00:02.0]-0065:2: Falling back to functioning (yet invalid -- WWPN) defaults.
[   81.383752] qla2xxx [0003:00:02.0]-0069:2: NVRAM configuration failed.
[   94.942165] scsi2 : qla2xxx
[   94.980186] qla2xxx [0003:00:02.0]-00fb:2: QLogic QLA22xx - .
[   95.055070] qla2xxx [0003:00:02.0]-00fc:2: ISP2200: PCI (66 MHz) @ 0003:00:02.0 hdma- host#=2 fw=2.02.08 TP.
[   95.185126] sunhme.c:v3.10 August 26, 2008 David S. Miller (davem@davemloft.net)
[   95.283949] eth0-3: Quattro HME (PCI/CheerIO) 10/100baseT Ethernet DEC 21153 PCI Bridge
[   95.387735] eth0: Quattro HME slot 0 (PCI/CheerIO) 10/100baseT Ethernet 08:00:20:f1:78:58
[   95.493652] scsi 2:0:0:0: Direct-Access     HITACHI  DK32EJ72FSUN72G  2Q0J PQ: 0 ANSI: 3
[   95.495610] eth1: Quattro HME slot 1 (PCI/CheerIO) 10/100baseT Ethernet 08:00:20:f1:78:59
[   95.497578] eth2: Quattro HME slot 2 (PCI/CheerIO) 10/100baseT Ethernet 08:00:20:f1:78:5a
[   95.499547] eth3: Quattro HME slot 3 (PCI/CheerIO) 10/100baseT Ethernet 08:00:20:f1:78:5b
[   95.499766] cassini: cassini.c:v1.6 (21 May 2008)
[   95.499777] PCI: Enabling device: (0002:00:02.0), cmd 146
[   95.504619] cassini 0002:00:02.0 eth4: Sun Cassini+ (64bit/33MHz PCI/Cu) Ethernet[28] 00:03:ba:29:66:f2
[   95.505735] PCI: Enabling device: (0003:00:01.0), cmd 146
[   95.510387] cassini 0003:00:01.0 eth5: Sun Cassini+ (64bit/66MHz PCI/Cu) Ethernet[34] 00:03:ba:29:66:f1
[   95.512365] i2c-0: Regs at 000007fc7e00002e, 8 devices, own a0, clock 10.
[   95.512614] bbc_i2c: probe of f00bf2b8 failed with error -22
[   95.513969] rtc_cmos rtc_cmos: rtc core: registered rtc_cmos as rtc0
[   95.514000] rtc_cmos rtc_cmos: no alarms, 114 bytes nvram
[   96.542236] hidraw: raw HID events driver (C) Jiri Kosina
[   96.613662] TCP: cubic registered
[   96.656251] NET: Registered protocol family 17
[   96.713941] Key type dns_resolver registered
[   96.770415] registered taskstats version 1
[   96.825198] console [netcon0] enabled
[   96.872378] netconsole: network logging started
[   96.931112] rtc_cmos rtc_cmos: setting system clock to 2014-06-26 08:50:15 UTC (1403772615)
[   99.993775] sd 2:0:0:0: [sda] 143374738 512-byte logical blocks: (73.4 GB/68.3 GiB)
[  100.110693] sd 2:0:0:0: [sda] Write Protect is off
[  100.172781] sd 2:0:0:0: [sda] Mode Sense: fb 00 10 08
[  100.181356] sd 2:0:0:0: [sda] Write cache: disabled, read cache: enabled, supports DPO and FUA
[  100.337455]  sda: sda1 sda3
[  100.408200] sd 2:0:0:0: [sda] Attached SCSI disk
[  100.474866] EXT4-fs (sda1): couldn't mount as ext3 due to feature incompatibilities
[  100.579853] EXT4-fs (sda1): couldn't mount as ext2 due to feature incompatibilities
[  100.729383] EXT4-fs (sda1): mounted filesystem with ordered data mode. Opts: (null)
[  100.829393] VFS: Mounted root (ext4 filesystem) readonly on device 8:1.
[  100.951968] devtmpfs: mounted
[  101.202036] qla2xxx [0001:00:01.0]-8038:0: Cable is unplugged...
[  101.562044] qla2xxx [0001:00:02.0]-8038:1: Cable is unplugged...
[  119.027561] stty (639) used greatest stack depth: 9656 bytes left
[  119.121255] run-parts (641) used greatest stack depth: 9128 bytes left
[  119.412289] tput (644) used greatest stack depth: 8536 bytes left
[  127.272278] random: nonblocking pool is initialized
[  128.005958] ls (675) used greatest stack depth: 8216 bytes left
[  128.426733] ps (732) used greatest stack depth: 32 bytes left
[  136.836442] systemd-udevd[739]: starting version 204
[  137.622402] systemd-udevd[776]: renamed network interface eth3 to rename5
[  137.682440] usbcore: registered new interface driver usbfs
[  137.682805] usbcore: registered new interface driver hub
[  137.712246] usbcore: registered new device driver usb
[  137.740131] libata version 3.00 loaded.
[  137.748379] PCI: Enabling device: (0000:00:06.0), cmd 5
[  137.748409] pata_cmd64x 0000:00:06.0: Secondary port is disabled
[  137.750865] scsi3 : pata_cmd64x
[  137.751624] scsi4 : pata_cmd64x
[  137.751997] ata1: PATA max UDMA/33 cmd 0x7ffef000500 ctl 0x7ffef000518 bmdma 0x7ffef000520 irq 12
[  137.752001] ata2: DUMMY
[  137.752689] pata_cmd64x: active 10 recovery 10 setup 3.
[  137.752732] pata_cmd64x: active 10 recovery 10 setup 3.
[  137.865952] ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
[  137.887894] ohci-pci: OHCI PCI platform driver
[  137.888346] ohci-pci 0002:00:01.3: OHCI PCI host controller
[  137.888525] ohci-pci 0002:00:01.3: new USB bus registered, assigned bus number 1
[  137.888866] ohci-pci 0002:00:01.3: irq 27, io mem 0x7fc01000000
[  137.927646] ata1.00: ATAPI: PHILIPS DVD-ROM SDR089, TD36, max UDMA/33
[  137.927673] pata_cmd64x: active 3 recovery 1 setup 1.
[  137.928227] usb usb1: New USB device found, idVendor6b, idProduct 01
[  137.928241] usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[  137.928247] usb usb1: Product: OHCI PCI host controller
[  137.928253] usb usb1: Manufacturer: Linux 3.16.0-rc2-00211-gd7933ab-dirty ohci_hcd
[  137.928259] usb usb1: SerialNumber: 0002:00:01.3
[  137.930196] hub 1-0:1.0: USB hub found
[  137.930393] hub 1-0:1.0: 4 ports detected
[  138.042773] ata1.00: configured for UDMA/33
[  138.046932] scsi 3:0:0:0: CD-ROM            PHILIPS  DVD-ROM SDR089   TD36 PQ: 0 ANSI: 5
[  138.231529] sr0: scsi3-mmc drive: 24x/24x cd/rw xa/form2 cdda tray
[  138.231540] cdrom: Uniform CD-ROM driver Revision: 3.20
[  138.233993] sr 3:0:0:0: Attached scsi CD-ROM sr0
[  138.927658] Emulex LightPulse Fibre Channel SCSI driver 10.2.8001.0.
[  138.927663] Copyright(c) 2004-2014 Emulex.  All rights reserved.
[  138.928648] PCI: Enabling device: (0000:00:02.0), cmd 2
[  138.937339] scsi5 : Emulex LP9000 PCI Obsolete, Unsupported Fibre Channel Adapter  on PCI bus 00 device 10 irq 6
[  139.822470] systemd-udevd[783]: renamed network interface eth5 to rename7
[  139.932426] systemd-udevd[776]: renamed network interface rename5 to eth5
[  140.032271] systemd-udevd[780]: renamed network interface eth0 to rename2
[  140.152370] systemd-udevd[777]: renamed network interface eth1 to eth3
[  140.262226] systemd-udevd[789]: renamed network interface eth4 to eth0
[  140.412444] systemd-udevd[778]: renamed network interface eth2 to rename4
[  140.522146] systemd-udevd[780]: renamed network interface rename2 to eth1
[  140.632280] systemd-udevd[783]: renamed network interface rename7 to eth2
[  140.722264] systemd-udevd[778]: renamed network interface rename4 to eth4
[  145.742337] PCI: Enabling device: (0000:00:03.0), cmd 2
[  145.748693] scsi6 : Emulex LP9000 PCI Obsolete, Unsupported Fibre Channel Adapter  on PCI bus 00 device 18 irq 7
[  153.233744] findmnt (1293) used greatest stack depth: 8 bytes left
[  153.241391] EXT4-fs (sda1): re-mounted. Opts: (null)
[  153.588074] EXT4-fs (sda1): re-mounted. Opts: errors=remount-ro
[  154.629127] loop: module loaded
[  160.021975] eth1: Link is up using internal transceiver at 100Mb/s, Full Duplex.
[  471.759435] 
[  471.795701] ============================[  471.956448] [ INFO: possible irq lock inversion dependency detected ]
[  472.117308] 3.16.0-rc2-00211-gd7933ab-dirty #16 Not tainted
[  472.256219] ---------------------------------------------------------
[  472.416978] aptitude/2665 just changed the state of lock:
[  472.551529]  (ctx_alloc_lock){+.....}, at: [<000000000044d8d8>] hugetlb_setup+0xb8/0x140
[  472.750024] but this lock was taken by another, HARDIRQ-safe lock in the past:
[  472.930533]  (&rq->lock){-.-.-.}
[  472.930533] 
[  472.930533] and interrupts could create inverse lock ordering between them.
[  472.930533] 
[  473.158356] 
[  473.158356] other info that might help us debug this:
[  473.321291] Chain exists of:
[  473.321291]   &rq->lock --> &(&mm->context.lock)->rlock --> ctx_alloc_lock
[  473.321291] 
[  473.531122]  Possible interrupt unsafe locking scenario:
[  473.531122] 
[  473.700613]        CPU0                    CPU1
[  473.813329]        ----                    ----
[  473.926045]   lock(ctx_alloc_lock);
[  474.010585]                                local_irq_disable();
[  474.158346]                                lock(&rq->lock);
[  474.295392]                                lock(&(&mm->context.lock)->rlock);
[  474.471854]   <Interrupt>
[  474.536530]     lock(&rq->lock);
[  474.614517] 
[  474.614517]  *** DEADLOCK ***
[  474.614517] 
[  474.762174] no locks held by aptitude/2665.
[  474.866055] 
[  474.866055] the shortest dependencies between 2nd lock and 1st lock:
[  475.061857]   -> (&rq->lock){-.-.-.} ops: 803979223105536 {
[  475.195992]      IN-HARDIRQ-W at:
[  475.277098]                         [<00000000004a4dac>] lock_acquire+0x4c/0x80
[  475.458859]                         [<00000000008497dc>] _raw_spin_lock+0x1c/0x40
[  475.644886]                         [<0000000000488acc>] scheduler_tick+0x2c/0xe0
[  475.830913]                         [<0000000000467748>] update_process_times+0x48/0x60
[  476.030157]                         [<00000000004bfd00>] tick_periodic+0xe0/0x100
[  476.216193]                         [<00000000004bfd2c>] tick_handle_periodic+0xc/0x80
[  476.413253]                         [<000000000042fd40>] timer_interrupt+0x80/0xc0
[  476.601477]                         [<0000000000426b84>] valid_addr_bitmap_patch+0xbc/0x238
[  476.809348]                         [<00000000004abef4>] console_unlock+0x314/0x480
[  476.999844]                         [<00000000004ac57c>] vprintk_emit+0x27c/0x5a0
[  477.185885]                         [<00000000008411e0>] printk+0x34/0x48
[  477.354455]                         [<0000000000a73bb8>] lockdep_info+0x8/0xb0
[  477.533943]                         [<0000000000a6a90c>] start_kernel+0x320/0x424
[  477.719983]                         [<000000000083eb8c>] tlb_fixup_done+0xa0/0xb4
[  477.906024]                         [<          (null)>]           (null)
[  478.074592]      IN-SOFTIRQ-W at:
[  478.155707]                         [<00000000004a4dac>] lock_acquire+0x4c/0x80
[  478.337378]                         [<00000000008497dc>] _raw_spin_lock+0x1c/0x40
[  478.523421]                         [<000000000048bbf8>] try_to_wake_up+0x218/0x380
[  478.713831]                         [<000000000048bd6c>] default_wake_function+0xc/0x20
[  478.913077]                         [<000000000049a8b0>] autoremove_wake_function+0x10/0x60
[  479.121054]                         [<000000000049a1d4>] __wake_up_common+0x34/0x80
[  479.311458]                         [<000000000049a4e0>] __wake_up+0x20/0x40
[  479.486684]                         [<00000000004b5538>] rcu_gp_kthread_wake+0x38/0x60
[  479.683746]                         [<00000000004b74cc>] rcu_process_callbacks+0x48c/0x640
[  479.889442]                         [<000000000045fcb0>] __do_softirq+0x110/0x280
[  480.075482]                         [<000000000042bd8c>] do_softirq_own_stack+0x2c/0x40
[  480.274623]                         [<00000000004601c4>] irq_exit+0xc4/0xe0
[  480.447667]                         [<000000000042fd48>] timer_interrupt+0x88/0xc0
[  480.635891]                         [<0000000000426b84>] valid_addr_bitmap_patch+0xbc/0x238
[  480.843874]                         [<000000000042c3cc>] arch_cpu_idle+0x2c/0xa0
[  481.027834]                         [<000000000049ae7c>] cpu_startup_entry+0x15c/0x200
[  481.224798]                         [<000000000083ed00>] rest_init+0x160/0x180
[  481.404290]                         [<0000000000a6aa00>] start_kernel+0x414/0x424
[  481.590329]                         [<000000000083eb8c>] tlb_fixup_done+0xa0/0xb4
[  481.776367]                         [<          (null)>]           (null)
[  481.944935]      IN-RECLAIM_FS-W at:
[  482.032600]                            [<00000000004a4dac>] lock_acquire+0x4c/0x80
[  482.220826]                            [<00000000008497dc>] _raw_spin_lock+0x1c/0x40
[  482.413417]                            [<0000000000485060>] task_rq_lock+0x40/0xa0
[  482.601741]                            [<000000000048b188>] set_cpus_allowed_ptr+0x8/0x100
[  482.807438]                            [<00000000004e6a64>] kswapd+0x204/0x320
[  482.987032]                            [<000000000047d4e8>] kthread+0xa8/0xe0
[  483.164443]                            [<00000000004060c4>] ret_from_fork+0x1c/0x2c
[  483.354851]                            [<          (null)>]           (null)
[  483.529974]      INITIAL USE at:
[  483.608903]                        [<00000000004a4dac>] lock_acquire+0x4c/0x80
[  483.788392]                        [<00000000008498b4>] _raw_spin_lock_irqsave+0x34/0x60
[  483.989718]                        [<0000000000486244>] rq_attach_root+0x4/0x160
[  484.173577]                        [<0000000000a7396c>] sched_init+0x1bc/0x2fc
[  484.353065]                        [<0000000000a6a814>] start_kernel+0x228/0x424
[  484.536923]                        [<000000000083eb8c>] tlb_fixup_done+0xa0/0xb4
[  484.720778]                        [<          (null)>]           (null)
[  484.887165]    }
[  484.932192]    ... key      at: [<00000000010c5b04>] __key.42420+0x0/0xc
[  485.098684]    ... acquired at:
[  485.176366]    [<00000000008498b4>] _raw_spin_lock_irqsave+0x34/0x60
[  485.334017]    [<0000000000845038>] __schedule+0x278/0x414
[  485.469833]    [<00000000008457bc>] schedule+0x1c/0x80
[  485.596808]    [<00000000004846ec>] smpboot_thread_fn+0x16c/0x1e0
[  485.747803]    [<000000000047d4e8>] kthread+0xa8/0xe0
[  485.872698]    [<00000000004060c4>] ret_from_fork+0x1c/0x2c
[  486.010695]    [<          (null)>]           (null)
[  486.133301] 
[  486.169491]  -> (&(&mm->context.lock)->rlock){......} ops: 2906709311881216 {
[  486.343053]     INITIAL USE at:
[  486.419905]                      [<00000000004a4dac>] lock_acquire+0x4c/0x80
[  486.595028]                      [<00000000008498b4>] _raw_spin_lock_irqsave+0x34/0x60
[  486.791989]                      [<000000000044b3fc>] tsb_grow+0x9c/0x460
[  486.960559]                      [<000000000044b808>] init_new_context+0x48/0x80
[  487.144414]                      [<000000000052a9a8>] do_execve_common.isra.31+0x308/0x760
[  487.350111]                      [<000000000052ae14>] do_execve+0x14/0x40
[  487.518786]                      [<0000000000426d20>] run_init_process+0x20/0x40
[  487.702637]                      [<0000000000426d44>] try_to_run_init_process+0x4/0x60
[  487.899589]                      [<000000000083edbc>] kernel_init+0x9c/0x100
[  488.074713]                      [<00000000004060c4>] ret_from_fork+0x1c/0x2c
[  488.252124]                      [<          (null)>]           (null)
[  488.414249]   }
[  488.456989]   ... key      at: [<0000000000a9e7e0>] __key.24311+0x0/0x8
[  488.621192]   ... acquired at:
[  488.696792]    [<00000000008497dc>] _raw_spin_lock+0x1c/0x40
[  488.837079]    [<000000000044d030>] get_new_mmu_context+0x10/0x140
[  488.990364]    [<000000000052a38c>] flush_old_exec+0x4cc/0x5e0
[  489.134911]    [<0000000000578228>] load_elf_binary+0x248/0x1240
[  489.283826]    [<0000000000529410>] search_binary_handler+0x90/0x220
[  489.441477]    [<000000000052ac80>] do_execve_common.isra.31+0x5e0/0x760
[  489.607865]    [<000000000052ae14>] do_execve+0x14/0x40
[  489.737229]    [<0000000000426d20>] run_init_process+0x20/0x40
[  489.881779]    [<0000000000426d44>] try_to_run_init_process+0x4/0x60
[  490.039325]    [<000000000083edbc>] kernel_init+0x9c/0x100
[  490.175139]    [<00000000004060c4>] ret_from_fork+0x1c/0x2c
[  490.313135]    [<          (null)>]           (null)
[  490.435734] 
[  490.471921] -> (ctx_alloc_lock){+.....} ops: 29416231010304 {
[  490.610436]    HARDIRQ-ON-W at:
[  490.687286]                     [<00000000004a4dac>] lock_acquire+0x4c/0x80
[  490.860221]                     [<00000000008497dc>] _raw_spin_lock+0x1c/0x40
[  491.037522]                     [<000000000044d8d8>] hugetlb_setup+0xb8/0x140
[  491.214827]                     [<0000000000407a0c>] tsb_miss_page_table_walk_sun4v_fastpath+0xdc/0xec
[  491.446938]    INITIAL USE at:
[  491.521498]                    [<00000000004a4dac>] lock_acquire+0x4c/0x80
[  491.692360]                    [<00000000008497dc>] _raw_spin_lock+0x1c/0x40
[  491.867581]                    [<000000000044d030>] get_new_mmu_context+0x10/0x140
[  492.055808]                    [<000000000052a38c>] flush_old_exec+0x4cc/0x5e0
[  492.235403]                    [<0000000000578228>] load_elf_binary+0x248/0x1240
[  492.419364]                    [<0000000000529410>] search_binary_handler+0x90/0x220
[  492.612064]                    [<000000000052ac80>] do_execve_common.isra.31+0x5e0/0x760
[  492.813387]                    [<000000000052ae14>] do_execve+0x14/0x40
[  492.977483]                    [<0000000000426d20>] run_init_process+0x20/0x40
[  493.156973]                    [<0000000000426d44>] try_to_run_init_process+0x4/0x60
[  493.349556]                    [<000000000083edbc>] kernel_init+0x9c/0x100
[  493.520201]                    [<00000000004060c4>] ret_from_fork+0x1c/0x2c
[  493.693035]                    [<          (null)>]           (null)
[  493.850684]  }
[  493.891241]  ... key      at: [<0000000000a263c0>] ctx_alloc_lock+0x18/0x38
[  494.064076]  ... acquired at:
[  494.137494]    [<00000000004a225c>] mark_lock+0x23c/0x880
[  494.271121]    [<00000000004a2f2c>] __lock_acquire+0x68c/0x1fa0
[  494.417750]    [<00000000004a4dac>] lock_acquire+0x4c/0x80
[  494.553670]    [<00000000008497dc>] _raw_spin_lock+0x1c/0x40
[  494.693849]    [<000000000044d8d8>] hugetlb_setup+0xb8/0x140
[  494.833925]    [<0000000000407a0c>] tsb_miss_page_table_walk_sun4v_fastpath+0xdc/0xec
[  495.028702] 
[  495.064996] 
[  495.064996] stack backtrace:
[  495.173363] CPU: 2 PID: 2665 Comm: aptitude Not tainted 3.16.0-rc2-00211-gd7933ab-dirty #16
[  495.382172] Call Trace:
[  495.442491]  [00000000004a1498] print_irq_inversion_bug.part.24+0x1b8/0x1e0
[  495.616469]  [00000000004a174c] check_usage_backwards+0x12c/0x160
[  495.768503]  [00000000004a225c] mark_lock+0x23c/0x880
[  495.894230]  [00000000004a2f2c] __lock_acquire+0x68c/0x1fa0
[  496.033162]  [00000000004a4dac] lock_acquire+0x4c/0x80
[  496.161174]  [00000000008497dc] _raw_spin_lock+0x1c/0x40
[  496.293552]  [000000000044d8d8] hugetlb_setup+0xb8/0x140
[  496.425932]  [0000000000407a0c] tsb_miss_page_table_walk_sun4v_fastpath+0xdc/0xec
[  858.444867] systemd-udevd[11532]: starting version 204

-- 
Meelis Roos (mroos@linux.ee)
