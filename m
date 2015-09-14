From: Meelis Roos <mroos@linux.ee>
Date: Mon, 14 Sep 2015 19:06:21 +0000
Subject: blk_mq_register_disk: kobject (00000000009f2dd8): tried to init an initialized object, something is 
Message-Id: <alpine.LRH.2.20.1509141548050.31198@math.ut.ee>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: Linux Kernel list <linux-kernel@vger.kernel.org>, sparclinux@vger.kernel.org

This is 4.3.0-rc1 on Sun E220R (dual-CPU sparc64). Sometimes it boots,=20
sometimes it fails to boot with looping errors and finally a watchdog=20
timeout. This console log from a failure. Config is below.

[    0.000000] PROMLIB: Sun IEEE Boot Prom 'OBP 3.31.0 2001/07/25 20:31'
[    0.000000] PROMLIB: Root node compatible:=20
[    0.000000] Linux version 4.3.0-rc1 (mroos@e220r) (gcc version 4.9.2 (De=
bian 4.9.2-20) ) #65 SMP Sun Sep 13 19:53:46 EEST 2015
[    0.000000] debug: ignoring loglevel setting.
[    0.000000] bootconsole [earlyprom0] enabled
[    0.000000] ARCH: SUN4U
[    0.000000] Ethernet address: 08:00:20:c7:a3:81
[    0.000000] MM: PAGE_OFFSET is 0xfffff80000000000 (max_phys_bits =3D 40)
[    0.000000] MM: VMALLOC [0x0000000100000000 --> 0x0000060000000000]
[    0.000000] MM: VMEMMAP [0x0000060000000000 --> 0x00000c0000000000]
[    0.000000] Kernel: Using 2 locked TLB entries for main kernel image.
[    0.000000] Remapping the kernel... done.
[    0.000000] kmemleak: Kernel memory leak detector disabled
[    0.000000] OF stdout device is: /pci@1f,4000/ebus@1/se@14,400000:a
[    0.000000] PROM: Built device tree with 91663 bytes of memory.
[    0.000000] Top of RAM: 0xaff18000, Total RAM: 0x3ff06000
[    0.000000] Memory hole size: 1792MB
[    0.000000] Allocated 16384 bytes for kernel page tables.
[    0.000000] Zone ranges:
[    0.000000]   Normal   [mem 0x0000000000000000-0x00000000aff17fff]
[    0.000000] Movable zone start for each node
[    0.000000] Early memory node ranges
[    0.000000]   node   0: [mem 0x0000000000000000-0x000000000fffffff]
[    0.000000]   node   0: [mem 0x0000000020000000-0x000000002fffffff]
[    0.000000]   node   0: [mem 0x0000000080000000-0x000000008fffffff]
[    0.000000]   node   0: [mem 0x00000000a0000000-0x00000000afeedfff]
[    0.000000]   node   0: [mem 0x00000000aff00000-0x00000000aff17fff]
[    0.000000] Initmem setup node 0 [mem 0x0000000000000000-0x00000000aff17=
fff]
[    0.000000] On node 0 totalpages: 130947
[    0.000000]   Normal zone: 1024 pages used for memmap
[    0.000000]   Normal zone: 0 pages reserved
[    0.000000]   Normal zone: 130947 pages, LIFO batch:15
[    0.000000] Booting Linux...
[    0.000000] CPU CAPS: [flush,stbar,swap,muldiv,v9,mul32,div32,v8plus]
[    0.000000] CPU CAPS: [vis]
[    0.000000] PERCPU: Embedded 8 pages/cpu @fffff800af800000 s22976 r8192 =
d34368 u2097152
[    0.000000] pcpu-alloc: s22976 r8192 d34368 u2097152 alloc=3D1*4194304
[    0.000000] pcpu-alloc: [0] 0 2=20
[    0.000000] Built 1 zonelists in Zone order, mobility grouping on.  Tota=
l pages: 129923
[    0.000000] Kernel command line: root=3D/dev/sda2 ro ignore_loglevel
[    0.000000] PID hash table entries: 4096 (order: 2, 32768 bytes)
[    0.000000] Dentry cache hash table entries: 131072 (order: 7, 1048576 b=
ytes)
[    0.000000] Inode-cache hash table entries: 65536 (order: 6, 524288 byte=
s)
[    0.000000] Sorting __ex_table...
[    0.000000] Memory: 1022624K/1047576K available (4205K kernel code, 251K=
 rwdata, 1288K rodata, 264K init, 418K bss, 24952K reserved, 0K cma-reserve=
d)
[    0.000000] SLUB: HWalign2, Order=3D0-3, MinObjects=3D0, CPUs=3D3, Nodes=
=3D1
[    0.000000] Hierarchical RCU implementation.
[    0.000000] 	Build-time adjustment of leaf fanout to 64.
[    0.000000] 	RCU restricting CPUs from NR_CPUS=3D4 to nr_cpu_ids=3D3.
[    0.000000] RCU: Adjusting geometry for rcu_fanout_leafd, nr_cpu_ids=3D3
[    0.000000] NR_IRQS:2048 nr_irqs:2048 1
[   79.762547] clocksource: tick: mask: 0xffffffffffffffff max_cycles: 0x53=
0919c4ff, max_idle_ns: 440795210743 ns
[   79.882019] clocksource: mult[2c709c3] shift[24]
[   79.937217] clockevent: mult[5c2b61ba] shift[32]
[   79.992661] Console: colour dummy device 80x25
[   80.045592] console [tty0] enabled
[   80.086169] bootconsole [earlyprom0] disabled
[    0.000000] PROMLIB: Sun IEEE Boot Prom 'OBP 3.31.0 2001/07/25 20:31'
[    0.000000] PROMLIB: Root node compatible:=20
[    0.000000] Linux version 4.3.0-rc1 (mroos@e220r) (gcc version 4.9.2 (De=
bian 4.9.2-20) ) #65 SMP Sun Sep 13 19:53:46 EEST 2015
[    0.000000] debug: ignoring loglevel setting.
[    0.000000] bootconsole [earlyprom0] enabled
[    0.000000] ARCH: SUN4U
[    0.000000] Ethernet address: 08:00:20:c7:a3:81
[    0.000000] MM: PAGE_OFFSET is 0xfffff80000000000 (max_phys_bits =3D 40)
[    0.000000] MM: VMALLOC [0x0000000100000000 --> 0x0000060000000000]
[    0.000000] MM: VMEMMAP [0x0000060000000000 --> 0x00000c0000000000]
[    0.000000] Kernel: Using 2 locked TLB entries for main kernel image.
[    0.000000] Remapping the kernel... done.
[    0.000000] kmemleak: Kernel memory leak detector disabled
[    0.000000] OF stdout device is: /pci@1f,4000/ebus@1/se@14,400000:a
[    0.000000] PROM: Built device tree with 91663 bytes of memory.
[    0.000000] Top of RAM: 0xaff18000, Total RAM: 0x3ff06000
[    0.000000] Memory hole size: 1792MB
[    0.000000] Allocated 16384 bytes for kernel page tables.
[    0.000000] Zone ranges:
[    0.000000]   Normal   [mem 0x0000000000000000-0x00000000aff17fff]
[    0.000000] Movable zone start for each node
[    0.000000] Early memory node ranges
[    0.000000]   node   0: [mem 0x0000000000000000-0x000000000fffffff]
[    0.000000]   node   0: [mem 0x0000000020000000-0x000000002fffffff]
[    0.000000]   node   0: [mem 0x0000000080000000-0x000000008fffffff]
[    0.000000]   node   0: [mem 0x00000000a0000000-0x00000000afeedfff]
[    0.000000]   node   0: [mem 0x00000000aff00000-0x00000000aff17fff]
[    0.000000] Initmem setup node 0 [mem 0x0000000000000000-0x00000000aff17=
fff]
[    0.000000] On node 0 totalpages: 130947
[    0.000000]   Normal zone: 1024 pages used for memmap
[    0.000000]   Normal zone: 0 pages reserved
[    0.000000]   Normal zone: 130947 pages, LIFO batch:15
[    0.000000] Booting Linux...
[    0.000000] CPU CAPS: [flush,stbar,swap,muldiv,v9,mul32,div32,v8plus]
[    0.000000] CPU CAPS: [vis]
[    0.000000] PERCPU: Embedded 8 pages/cpu @fffff800af800000 s22976 r8192 =
d34368 u2097152
[    0.000000] pcpu-alloc: s22976 r8192 d34368 u2097152 alloc=3D1*4194304
[    0.000000] pcpu-alloc: [0] 0 2=20
[    0.000000] Built 1 zonelists in Zone order, mobility grouping on.  Tota=
l pages: 129923
[    0.000000] Kernel command line: root=3D/dev/sda2 ro ignore_loglevel
[    0.000000] PID hash table entries: 4096 (order: 2, 32768 bytes)
[    0.000000] Dentry cache hash table entries: 131072 (order: 7, 1048576 b=
ytes)
[    0.000000] Inode-cache hash table entries: 65536 (order: 6, 524288 byte=
s)
[    0.000000] Sorting __ex_table...
[    0.000000] Memory: 1022624K/1047576K available (4205K kernel code, 251K=
 rwdata, 1288K rodata, 264K init, 418K bss, 24952K reserved, 0K cma-reserve=
d)
[    0.000000] SLUB: HWalign2, Order=3D0-3, MinObjects=3D0, CPUs=3D3, Nodes=
=3D1
[    0.000000] Hierarchical RCU implementation.
[    0.000000] 	Build-time adjustment of leaf fanout to 64.
[    0.000000] 	RCU restricting CPUs from NR_CPUS=3D4 to nr_cpu_ids=3D3.
[    0.000000] RCU: Adjusting geometry for rcu_fanout_leafd, nr_cpu_ids=3D3
[    0.000000] NR_IRQS:2048 nr_irqs:2048 1
[   79.762547] clocksource: tick: mask: 0xffffffffffffffff max_cycles: 0x53=
0919c4ff, max_idle_ns: 440795210743 ns
[   79.882019] clocksource: mult[2c709c3] shift[24]
[   79.937217] clockevent: mult[5c2b61ba] shift[32]
[   79.992661] Console: colour dummy device 80x25
[   80.045592] console [tty0] enabled
[   80.086169] bootconsole [earlyprom0] disabled
[   80.138273] kmemleak: Early log buffer exceeded (1388), please increase =
DEBUG_KMEMLEAK_EARLY_LOG_SIZE
[   80.288367] Calibrating delay using timer specific routine.. 721.49 Bogo=
MIPS (lpj607494)
[   80.288417] pid_max: default: 32768 minimum: 301
[   80.288715] Mount-cache hash table entries: 2048 (order: 1, 16384 bytes)
[   80.288757] Mountpoint-cache hash table entries: 2048 (order: 1, 16384 b=
ytes)
[   80.321521] CPU 2: synchronized TICK with master CPU (last diff 1 cycles=
, maxerr 436 cycles)
[   80.321626] Brought up 2 CPUs
[   80.322828] devtmpfs: initialized
[   80.330830] Performance events: No support for PMU type 'ultra12'
[   80.389162] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xfffffff=
f, max_idle_ns: 19112604462750000 ns
[   80.389882] kworker/u4:0 (19) used greatest stack depth: 11240 bytes left
[   80.390755] NET: Registered protocol family 16
[   80.393783] kworker/u4:1 (29) used greatest stack depth: 11152 bytes left
[   80.394492] kworker/u4:1 (31) used greatest stack depth: 10560 bytes left
[   80.397912] kworker/u4:1 (25) used greatest stack depth: 10024 bytes left
[   80.402205] kworker/u4:0 (61) used greatest stack depth: 9496 bytes left
[   80.413455] /pci@1f,4000: PCI IO[1fe02010000] MEM[1ff80000000]
[   80.413523] /pci@1f,4000: PSYCHO PCI Bus Module ver[4:0]
[   80.413554] PCI: Scanning PBM /pci@1f,4000
[   80.414043] psycho f005fd74: PCI host bridge to bus 0000:00
[   80.414121] pci_bus 0000:00: root bus resource [io  0x1fe02010000-0x1fe0=
201ffff] (bus address [0x0000-0xffff])
[   80.414215] pci_bus 0000:00: root bus resource [mem 0x1ff80000000-0x1fff=
fffffff] (bus address [0x00000000-0x7fffffff])
[   80.414302] pci_bus 0000:00: root bus resource [bus 00]
[   80.419316] /pci@1f,2000: PCI IO[1fe02000000] MEM[1ff00000000]
[   80.419381] /pci@1f,2000: PSYCHO PCI Bus Module ver[4:0]
[   80.419428] PCI: Scanning PBM /pci@1f,2000
[   80.419830] psycho f00605f0: PCI host bridge to bus 0001:80
[   80.419897] pci_bus 0001:80: root bus resource [io  0x1fe02000000-0x1fe0=
200ffff] (bus address [0x0000-0xffff])
[   80.419987] pci_bus 0001:80: root bus resource [mem 0x1ff00000000-0x1ff7=
fffffff] (bus address [0x00000000-0x7fffffff])
[   80.420074] pci_bus 0001:80: root bus resource [bus 80]
[   80.472184] vgaarb: loaded
[   80.472936] SCSI subsystem initialized
[   80.475262] /pci@1f,4000/ebus@1/eeprom@14,0: Mostek regs at 0x1fff1000000
[   80.476265] AUXIO: Found device at /pci@1f,4000/ebus@1/auxio@14,726000
[   80.476710] clocksource: Switched to clocksource tick
[   80.497990] NET: Registered protocol family 2
[   80.499341] TCP established hash table entries: 8192 (order: 3, 65536 by=
tes)
[   80.499751] TCP bind hash table entries: 8192 (order: 4, 131072 bytes)
[   80.500314] TCP: Hash tables configured (established 8192 bind 8192)
[   80.500582] UDP hash table entries: 512 (order: 1, 16384 bytes)
[   80.500718] UDP-Lite hash table entries: 512 (order: 1, 16384 bytes)
[   80.501213] NET: Registered protocol family 1
[   80.501475] PCI: CLS 0 bytes, default 64
[   80.501770] power: Control reg at 1fff1724000
[   80.504616] futex hash table entries: 512 (order: 2, 32768 bytes)
[   80.506048] HugeTLB registered 8 MB page size, pre-allocated 0 pages
[   80.547180] Block layer SCSI generic (bsg) driver version 0.4 loaded (ma=
jor 252)
[   80.547278] io scheduler noop registered
[   80.547742] io scheduler cfq registered (default)
[   80.548661] f0061cc8: ttyS0 at MMIO 0x1fff1400000 (irq =3D 7, base_baud =
=3D 115200) is a SAB82532 V3.2
[   80.548744] Console: ttyS0 (SAB82532)
[   88.093713] console [ttyS0] enabled
[   88.136211] f0061cc8: ttyS1 at MMIO 0x1fff1400040 (irq =3D 7, base_baud =
=3D 115200) is a SAB82532 V3.2
[   88.244224] PCI: Enabling device: (0000:00:03.0), cmd 147
[   88.309290] sym0: <875> rev 0x14 at pci 0000:00:03.0 irq 13
[   88.462196] sym0: No NVRAM, ID 7, Fast-20, SE, parity checking
[   88.538525] sym0: SCSI BUS has been reset.
[   88.586601] scsi host0: sym-2.2.3
[   88.631377] PCI: Enabling device: (0000:00:03.1), cmd 3
[   88.694261] sym1: <875> rev 0x14 at pci 0000:00:03.1 irq 14
[   88.847050] sym1: No NVRAM, ID 7, Fast-20, SE, parity checking
[   88.923332] sym1: SCSI BUS has been reset.
[   88.971439] scsi host1: sym-2.2.3
[   89.015677] PCI: Enabling device: (0000:00:02.0), cmd 3
[   89.078557] sym2: <875> rev 0x14 at pci 0000:00:02.0 irq 15
[   89.231432] sym2: No NVRAM, ID 7, Fast-20, SE, parity checking
[   89.307660] sym2: SCSI BUS has been reset.
[   89.355758] scsi host2: sym-2.2.3
[   89.400043] PCI: Enabling device: (0000:00:02.1), cmd 3
[   89.462970] sym3: <875> rev 0x14 at pci 0000:00:02.1 irq 16
[   89.615754] sym3: No NVRAM, ID 7, Fast-20, SE, parity checking
[   89.692048] sym3: SCSI BUS has been reset.
[   89.740055] scsi host3: sym-2.2.3
[   89.784488] PCI: Enabling device: (0000:00:04.0), cmd 3
[   89.847401] sym4: <875> rev 0x14 at pci 0000:00:04.0 irq 17
[   90.000181] sym4: No NVRAM, ID 7, Fast-20, SE, parity checking
[   90.076457] sym4: SCSI BUS has been reset.
[   90.124493] scsi host4: sym-2.2.3
[   90.168974] PCI: Enabling device: (0000:00:04.1), cmd 3
[   90.231923] sym5: <875> rev 0x14 at pci 0000:00:04.1 irq 18
[   90.384712] sym5: No NVRAM, ID 7, Fast-20, SE, parity checking
[   90.460995] sym5: SCSI BUS has been reset.
[   90.509005] scsi host5: sym-2.2.3
[   90.554226] mousedev: PS/2 mouse device common for all mice
[   90.621711] rtc-m48t59 rtc-m48t59.0: rtc core: registered m48t59 as rtc0
[   90.703866] NET: Registered protocol family 10
[   90.758423] NET: Registered protocol family 17
[   90.810727] Key type dns_resolver registered
[   90.866003] Key type encrypted registered
[   90.914069] console [netcon0] enabled
[   90.956986] netconsole: network logging started
[   91.011243] rtc-m48t59 rtc-m48t59.0: setting system clock to 2015-09-14 =
12:31:56 UTC (1442233916)?   91.636785] scsi 0:0:0:0: Direct-Access     QUA=
NTUM  ATLAS10K3_36_SCA 020W PQ: 0 ANSI: 3
[   91.732863] scsi target0:0:0: tagged command queuing enabled, command qu=
eue depth 16.
[   91.826592] scsi target0:0:0: Beginning Domain Validation
[   91.894554] scsi target0:0:0: FAST-20 WIDE SCSI 40.0 MB/s ST (50 ns, off=
set 16)
[   91.983049] scsi target0:0:0: Domain Validation skipping write tests
[   92.058187] scsi target0:0:0: Ending Domain Validation
[   93.590588] scsi 0:0:6:0: CD-ROM            TOSHIBA  XM6201TASUN32XCD 11=
03 PQ: 0 ANSI: 2
[   93.686649] scsi target0:0:6: Beginning Domain Validation
[   93.753328] scsi target0:0:6: FAST-10 SCSI 10.0 MB/s ST (100 ns, offset =
16)
[   93.836962] scsi target0:0:6: Domain Validation skipping write tests
[   93.912162] scsi target0:0:6: Ending Domain Validation
[   96.317514] sd 0:0:0:0: [sda] 71833096 512-byte logical blocks: (36.7 GB=
/34.2 GiB)
[   96.408799] sd 0:0:0:0: [sda] Write Protect is off
[   96.465258] sd 0:0:0:0: [sda] Mode Sense: e5 00 10 08
[   96.527504] sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled,=
 supports DPO and FUA
[   96.641946]  sda: sda1 sda2 sda3 sda4
[   96.688204] kworker/u4:0 (570) used greatest stack depth: 9104 bytes left
[   96.709472] sd 0:0:0:0: [sda] Attached SCSI disk
[   98.020598] EXT4-fs (sda2): couldn't mount as ext3 due to feature incomp=
atibilities
[   98.112011] EXT4-fs (sda2): couldn't mount as ext2 due to feature incomp=
atibilities
[   98.227702] EXT4-fs (sda2): mounted filesystem with ordered data mode. O=
pts: (null)
[   98.318525] VFS: Mounted root (ext4 filesystem) readonly on device 259:2=
62144.
[   98.436651] devtmpfs: mounted
Mount failed for selinuxfs on /sys/fs/selinux:  No such file or directory
g??????=C9=B9?????=D1=A5???H?   99.248602] stty (586) used greatest stack d=
epth: 8216 bytes left
[   99.484619] tput (590) used greatest stack depth: 8088 bytes left
[info] Using makefile-style concurrent boot in runlevel S.
[  100.116965] ps (660) used greatest stack depth: 7728 bytes left
unparseable line (c! /dev/autofs 0600 - - - 10:235)
unparseable line (c! /dev/fuse 0600 - - - 10:229)
unparseable line (c! /dev/cuse 0600 - - - 10:203)
unparse[  100.356492] random: udevd urandom read with 18 bits of entropy av=
ailable
able line (c! /dev/loop-control 0600 - - - 10:237)
unparseable line (c! /dev/net/tun 0600 - - - 10:200)
unparseable line (c! /dev/uhid 0600 - - - 10:239)
[....] Starting the hotplug events dispatcher: udevdstarting version 218
[ ok .
[....] Synthesizing the initial hotplug events...[ ok done.
[  101.056708] hwclock (716) used greatest stack depth: 7608 bytes left
[....] Waiting f[  101.148930] sd 0:0:0:0: Attached scsi generic sg0 type 0
[  101.212727] scsi 0:0:6:0: Attached scsi generic sg1 type 5
or [  101.281691] PCI: Enabling device: (0000:00:01.1), cmd 2
[  101.289700] sr 0:0:6:0: [sr0] scsi-1 drive
[  101.289710] cdrom: Uniform CD-ROM driver Revision: 3.20
[  101.348345] sr 0:0:6:0: Attached scsi CD-ROM sr0
[  101.393029] cdrom_id (726) used greatest stack depth: 7456 bytes left
[  101.587083] sunhme.c:v3.10 August 26, 2008 David S. Miller (davem@daveml=
oft.net)
/d[  101.678086] eth0: HAPPY MEAL (PCI/CheerIO) 10/100BaseT Ethernet 08:00:=
20:c7:a3:81
ev to be fully populated...[ ok done.
[....] Setting preliminary keymap...[ ok done.
[....] Activating swap...[  104.354886] Adding 1582392k swap on /dev/sda4. =
 Priority:-1 extents:1 across:1582392k=20
[ ok done.
[  104.582832] EXT4-fs (sda2): re-mounted. Opts: (null)
[....] Checking root file system...fsck from util-linux 2.26.2
/dev/sda2: clean, 134168/2142112 files, 1452575/8558628 blocks
[ ok   104.917474] EXT4-fs (sda2): re-mounted. Opts: errors=3Dremount-ro
25hdone.
[....] Activating lvm and md swap...[ ok done.
[....] Checking file systems...fsck from util-linux 2.26.2
/dev/sda1: clean, 40/48192 files, 43342/96390 blocks
[ ok done.
[....] Cleaning up temporary files... /tmp[ ok .
[  106.370834] kobject (00000000009f2dd8): tried to init an initialized obj=
ect, something is seriously wrong.
[  106.485668] CPU: 2 PID: 1155 Comm: modprobe Not tainted 4.3.0-rc1 #65
[  106.562646] Call Trace:
[  106.591812]  [0000000000654560] kobject_init+0x80/0xa0
[  106.653285]  [0000000000640cc0] blk_mq_register_disk+0xa0/0x180
[  106.724089]  [0000000000636550] blk_register_queue+0x70/0x120
[  106.792840]  [0000000000643b5c] add_disk+0x19c/0x460
[  106.852197]  [0000000010033800] loop_add+0x1a0/0x240 [loop]
[  106.918853]  [000000001003a168] loop_init+0x168/0x1b0 [loop]
[  106.986531]  [0000000000426c00] do_one_initcall+0x80/0x1c0
[  107.052155]  [00000000004de3c4] do_init_module+0x48/0x1e4
[  107.116740]  [00000000004c7654] load_module+0xf14/0x11e0
[  107.180265]  [00000000004c7ab4] SyS_finit_module+0x74/0xa0
[  107.245874]  [00000000004061d4] linux_sparc_syscall32+0x34/0x60
[  107.317210] Unable to handle kernel paging request at virtual address 00=
0000018f090000
[  107.411482] tsk->{mm,active_mm}->context =3D 00000000000003c4
[  107.478123] tsk->{mm,active_mm}->pgd =3D fffff800ada70000
[  107.540600]               \|/ ____ \|/
[  107.540600]               "@'/ .. \`@"
[  107.540600]               /_| \__/ |_\
[  107.540600]                  \__U_/
[  107.716705] modprobe(1155): Oops [#1]
[  107.760362] CPU: 2 PID: 1155 Comm: modprobe Not tainted 4.3.0-rc1 #65
[  107.837442] task: fffff800af25ba80 ti: fffff800adcec000 task.ti: fffff80=
0adcec000
[  107.927040] TSTATE: 0000004411001607 TPC: 0000000000481384 TNPC: 0000000=
000481388 Y: 00000000    Not tainted
[  108.044741] TPC: <wake_up_process+0x4/0x40>
[  108.094698] g0: 0000000000908ad2 g1: 0000000000000000 g2: 00000000000000=
00 g3: 00000000009f2c00
[  108.198866] g4: fffff800af25ba80 g5: fffff800af01a000 g6: fffff800adcec0=
00 g7: fffff800ad373f68
[  108.303025] o0: 0000000000919000 o1: 0000000000000040 o2: 00000000009190=
00 o3: 00000000000000d0
[  108.407184] o4: 000000000097ea00 o5: 0000000000000040 sp: fffff800adceec=
d1 ret_pc: 00000000005288a8
[  108.515510] RPC: <kmem_cache_alloc+0xe8/0x180>
[  108.568576] l0: fffff800af3a6db8 l1: 000000000000343c l2: fffff800af3a6d=
b8 l3: 0000000000000001
[  108.672759] l4: 000000000000016e l5: 0000000000000001 l6: 00000000000030=
00 l7: 0000000000000002
[  108.776902] i0: 000000018f090680 i1: 000000000097ea00 i2: 000000000097ea=
00 i3: 0000000000479530
[  108.881062] i4: 000000000096d800 i5: fffff800af005bc0 i6: fffff800adceed=
81 i7: 000000000047958c
[  108.985223] I7: <kthread_create_on_node+0x8c/0x140>
[  109.043505] Call Trace:
[  109.072666]  [000000000047958c] kthread_create_on_node+0x8c/0x140
[  109.145580]  [0000000000476874] __alloc_workqueue_key+0x274/0x460
[  109.218497]  [000000000062d68c] __bioset_create+0x20c/0x2a0
[  109.285154]  [0000000000631830] blk_alloc_queue_node+0x50/0x1e0
[  109.355987]  [000000000063e54c] blk_mq_init_queue+0xc/0x60
[  109.421594]  [0000000010033710] loop_add+0xb0/0x240 [loop]
[  109.487212]  [000000001003a168] loop_init+0x168/0x1b0 [loop]
[  109.554889]  [0000000000426c00] do_one_initcall+0x80/0x1c0
[  109.620516]  [00000000004de3c4] do_init_module+0x48/0x1e4
[  109.685081]  [00000000004c7654] load_module+0xf14/0x11e0
[  109.748623]  [00000000004c7ab4] SyS_finit_module+0x74/0xa0
[  109.814238]  [00000000004061d4] linux_sparc_syscall32+0x34/0x60
[  109.885052] Disabling lock debugging due to kernel taint
[  109.948585] Caller[000000000047958c]: kthread_create_on_node+0x8c/0x140
[  110.027749] Caller[0000000000476874]: __alloc_workqueue_key+0x274/0x460
[  110.106902] Caller[000000000062d68c]: __bioset_create+0x20c/0x2a0
[  110.179816] Caller[0000000000631830]: blk_alloc_queue_node+0x50/0x1e0
[  110.256877] Caller[000000000063e54c]: blk_mq_init_queue+0xc/0x60
[  110.328760] Caller[0000000010033710]: loop_add+0xb0/0x240 [loop]
[  110.400607] Caller[000000001003a168]: loop_init+0x168/0x1b0 [loop]
[  110.474553] Caller[0000000000426c00]: do_one_initcall+0x80/0x1c0
[  110.546406] Caller[00000000004de3c4]: do_init_module+0x48/0x1e4
[  110.617242] Caller[00000000004c7654]: load_module+0xf14/0x11e0
[  110.687015] Caller[00000000004c7ab4]: SyS_finit_module+0x74/0xa0
[  110.758889] Caller[00000000004061d4]: linux_sparc_syscall32+0x34/0x60
[  110.835949] Caller[0000000070015738]: 0x70015738
[  110.891141] Instruction DUMP: 01000000  01000000  9de3bf50 <c25e0000> 82=
08600c  0ac04005  11002409  b2102003  106fff12=20
[  111.020960] modprobe (1155) used greatest stack depth: 7352 bytes left
[[  111.105555] Kernel unaligned access at TPC[477618] alloc_pid+0x418/0x480
[  111.184838] Unable to handle kernel paging request in mna handler
[  111.255618]  at virtual address 663830306166323d
[  111.312915] current->{active_,}mm->context =3D 00000000000003b7
[  111.381658] current->{active_,}mm->pgd =3D fffff800adca4000
[  111.446230]               \|/ ____ \|/
[  111.446230]               "@'/ .. \`@"
[  111.446230]               /_| \__/ |_\
[  111.446230]                  \__U_/
[  111.622322] kmod(1149): Oops [#2]
[  111.661830] CPU: 0 PID: 1149 Comm: kmod Tainted: G      D         4.3.0-=
rc1 #65
[  111.749336] task: fffff800af25c780 ti: fffff800adbe0000 task.ti: fffff80=
0adbe0000
[  111.838908] TSTATE: 0000004411e01607 TPC: 0000000000477618 TNPC: 0000000=
00047761c Y: 00000000    Tainted: G      D       =20
[  111.971189] TPC: <alloc_pid+0x418/0x480>
[  112.018020] g0: 0000000000000100 g1: 0000000000007790 g2: 66383030616632=
35 g3: fffff800af3e4820
[  112.122199] g4: fffff800af25c780 g5: fffff800aee1a000 g6: fffff800adbe00=
00 g7: 00000000009fa570
[  112.226347] o0: 000000000096a100 o1: 000000000097e470 o2: 00000000000000=
01 o3: 0000000000000001
[  112.330502] o4: 000000000096d800 o5: 4798000000000000 sp: fffff800adbe33=
51 ret_pc: 0000000000000040
[  112.438815] RPC: <0x40>
[  112.467949] l0: 0000000000000001 l1: ffffffffffffffff l2: 00000000000000=
00 l3: 0000000000000000
[  112.572131] l4: 000000000097e470 l5: fffff800af3e47e0 l6: 000000000097e4=
68 l7: 000000000000048b
[  112.676281] i0: 00000000009f2de0 i1: 000000000097e970 i2: fffff800af3e48=
00 i3: 000000000096a000
[  112.780434] i4: 00000000009f2de0 i5: 0000000000000034 i6: fffff800adbe34=
11 i7: 000000000045cb5c
[  112.884595] I7: <copy_process.isra.61.part.62+0xb7c/0x10e0>
[  112.951211] Call Trace:
[  112.980375]  [000000000045cb5c] copy_process.isra.61.part.62+0xb7c/0x10e0
[  113.061622]  [000000000045d1f4] _do_fork+0x94/0x340
[  113.119953]  [000000000042cc14] sparc_do_fork+0x34/0x60
[  113.182446]  [00000000004061d4] linux_sparc_syscall32+0x34/0x60
[  113.253262] Caller[000000000045cb5c]: copy_process.isra.61.part.62+0xb7c=
/0x10e0
[  113.340766] Caller[000000000045d1f4]: _do_fork+0x94/0x340
[  113.405318] Caller[000000000042cc14]: sparc_do_fork+0x34/0x60
[  113.474059] Caller[00000000004061d4]: linux_sparc_syscall32+0x34/0x60
[  113.551124] Caller[00000000f7a1a714]: 0xf7a1a714
[  113.606316] Instruction DUMP: c470c000  c6770001  2ac88002 <c670a008> c4=
58fff8  8600ffe0  80a0c01a  c200a41c  82006001=20
[  113.735458] BUG: sleeping function called from invalid context at includ=
e/linux/sched.h:2756
[  113.836521] in_atomic(): 1, irqs_disabled(): 1, pid: 1149, name: kmod
[  113.913574] CPU: 0 PID: 1149 Comm: kmod Tainted: G      D         4.3.0-=
rc1 #65
[  114.001071] Call Trace:
[  114.030223]  [000000000046b590] exit_signals+0x10/0x160
[  114.092717]  [000000000045f8a4] do_exit+0x84/0xae0
[  114.149995]  [0000000000428758] die_if_kernel+0x198/0x320
[  114.214570]  [0000000000432e98] kernel_mna_trap_fault+0xd8/0x120
[  114.286437]  [000000000042aa04] mem_address_unaligned+0x84/0xa0
[  114.357259]  [0000000000405f40] do_mna+0x3c/0x4c
[  114.412456]  [0000000000477618] alloc_pid+0x418/0x480
[  114.472862]  [000000000045cb5c] copy_process.isra.61.part.62+0xb7c/0x10e0
[  114.554103]  [000000000045d1f4] _do_fork+0x94/0x340
[  114.612426]  [000000000042cc14] sparc_do_fork+0x34/0x60
[  114.674916]  [00000000004061d4] linux_sparc_syscall32+0x34/0x60
[  114.745734] note: kmod[1149] exited with preempt_count 1
[  114.809265] BUG: sleeping function called from invalid context at kernel=
/locking/rwsem.c:21
[  114.909274] in_atomic(): 1, irqs_disabled(): 1, pid: 1149, name: kmod
[  114.986328] CPU: 0 PID: 1149 Comm: kmod Tainted: G      D         4.3.0-=
rc1 #65
[  115.073825] Call Trace:
[  115.102974]  [000000000081d7f0] down_read+0x10/0x40
[  115.161300]  [000000000045f930] do_exit+0x110/0xae0
[  115.219623]  [0000000000428758] die_if_kernel+0x198/0x320
[  115.284197]  [0000000000432e98] kernel_mna_trap_fault+0xd8/0x120
[  115.356065]  [000000000042aa04] mem_address_unaligned+0x84/0xa0
[  115.426888]  [0000000000405f40] do_mna+0x3c/0x4c
[  115.482084]  [0000000000477618] alloc_pid+0x418/0x480
[  115.542492]  [000000000045cb5c] copy_process.isra.61.part.62+0xb7c/0x10e0
[  115.623733]  [000000000045d1f4] _do_fork+0x94/0x340
[  115.682056]  [000000000042cc14] sparc_do_fork+0x34/0x60
[  115.744545]  [00000000004061d4] linux_sparc_syscall32+0x34/0x60
[  115.815365] BUG: sleeping function called from invalid context at kernel=
/fork.c:694
[  115.907037] in_atomic(): 1, irqs_disabled(): 1, pid: 1149, name: kmod
[  115.984093] CPU: 0 PID: 1149 Comm: kmod Tainted: G      D         4.3.0-=
rc1 #65
[  116.071590] Call Trace:
[  116.100734]  [000000000045bd10] mmput+0x10/0x100
[  116.155941]  [000000000045faa4] do_exit+0x284/0xae0
[  116.214263]  [0000000000428758] die_if_kernel+0x198/0x320
[  116.278839]  [0000000000432e98] kernel_mna_trap_fault+0xd8/0x120
[  116.350706]  [000000000042aa04] mem_address_unaligned+0x84/0xa0
[  116.421529]  [0000000000405f40] do_mna+0x3c/0x4c
[  116.476725]  [0000000000477618] alloc_pid+0x418/0x480
[  116.537134]  [000000000045cb5c] copy_process.isra.61.part.62+0xb7c/0x10e0
[  116.618374]  [000000000045d1f4] _do_fork+0x94/0x340
[  116.676697]  [000000000042cc14] sparc_do_fork+0x34/0x60
[  116.739186]  [00000000004061d4] linux_sparc_syscall32+0x34/0x60
[  116.810027] ------------[ cut here ]------------
[  116.865227] WARNING: CPU: 0 PID: 1149 at kernel/smp.c:417 smp_call_funct=
ion_many+0x1ec/0x280()
[  116.968333] Modules linked in: loop(+) sunhme sr_mod cdrom sg
[  117.037046] CPU: 0 PID: 1149 Comm: kmod Tainted: G      D         4.3.0-=
rc1 #65
[  117.124556] Call Trace:
[  117.153701]  [000000000045dd60] warn_slowpath_common+0x60/0xa0
[  117.223490]  [00000000004c290c] smp_call_function_many+0x1ec/0x280
[  117.297452]  [000000000043ec0c] smp_flush_tlb_pending+0x4c/0xc0
[  117.368275]  [000000000044d120] flush_tlb_pending+0x80/0xc0
[  117.434921]  [000000000044d29c] arch_leave_lazy_mmu_mode+0x1c/0x40
[  117.508873]  [0000000000504388] unmap_single_vma+0x548/0x820
[  117.576561]  [000000000050501c] unmap_vmas+0x3c/0x60
[  117.635930]  [000000000050d440] exit_mmap+0x80/0x140
[  117.695288]  [000000000045bd58] mmput+0x58/0x100
[  117.750489]  [000000000045faa4] do_exit+0x284/0xae0
[  117.808813]  [0000000000428758] die_if_kernel+0x198/0x320
[  117.873389]  [0000000000432e98] kernel_mna_trap_fault+0xd8/0x120
[  117.945255]  [000000000042aa04] mem_address_unaligned+0x84/0xa0
[  118.016078]  [0000000000405f40] do_mna+0x3c/0x4c
[  118.071277]  [0000000000477618] alloc_pid+0x418/0x480
[  118.131683]  [000000000045cb5c] copy_process.isra.61.part.62+0xb7c/0x10e0
[  118.212918] ---[ end trace c6fd37dd6e0d50a8 ]---
[  118.268118] BUG: sleeping function called from invalid context at mm/mem=
ory.c:1223
[  118.358749] in_atomic(): 1, irqs_disabled(): 1, pid: 1149, name: kmod
[  118.435807] CPU: 0 PID: 1149 Comm: kmod Tainted: G      D W       4.3.0-=
rc1 #65
[  118.523302] Call Trace:
[  118.552448]  [00000000005044c0] unmap_single_vma+0x680/0x820
[  118.620152]  [000000000050501c] unmap_vmas+0x3c/0x60
[  118.679518]  [000000000050d440] exit_mmap+0x80/0x140
[  118.738880]  [000000000045bd58] mmput+0x58/0x100
[  118.794083]  [000000000045faa4] do_exit+0x284/0xae0
[  118.852406]  [0000000000428758] die_if_kernel+0x198/0x320
[  118.916980]  [0000000000432e98] kernel_mna_trap_fault+0xd8/0x120
[  118.988848]  [000000000042aa04] mem_address_unaligned+0x84/0xa0
[  119.059670]  [0000000000405f40] do_mna+0x3c/0x4c
[  119.114867]  [0000000000477618] alloc_pid+0x418/0x480
[  119.175275]  [000000000045cb5c] copy_process.isra.61.part.62+0xb7c/0x10e0
[  119.256514]  [000000000045d1f4] _do_fork+0x94/0x340
[  119.314839]  [000000000042cc14] sparc_do_fork+0x34/0x60
[  119.377329]  [00000000004061d4] linux_sparc_syscall32+0x34/0x60
[  119.448154] BUG: sleeping function called from invalid context at mm/mem=
ory.c:1223
[  119.538778] in_atomic(): 1, irqs_disabled(): 1, pid: 1149, name: kmod
[  119.615834] CPU: 0 PID: 1149 Comm: kmod Tainted: G      D W       4.3.0-=
rc1 #65
[  119.703333] Call Trace:
[  119.732479]  [00000000005044c0] unmap_single_vma+0x680/0x820
[  119.800182]  [000000000050501c] unmap_vmas+0x3c/0x60
[  119.859549]  [000000000050d440] exit_mmap+0x80/0x140
[  119.918912]  [000000000045bd58] mmput+0x58/0x100
[  119.974112]  [000000000045faa4] do_exit+0x284/0xae0
[  120.032437]  [0000000000428758] die_if_kernel+0x198/0x320
[  120.097011]  [0000000000432e98] kernel_mna_trap_fault+0xd8/0x120
[  120.168877]  [000000000042aa04] mem_address_unaligned+0x84/0xa0
[  120.239699]  [0000000000405f40] do_mna+0x3c/0x4c
[  120.294899]  [0000000000477618] alloc_pid+0x418/0x480
[  120.355304]  [000000000045cb5c] copy_process.isra.61.part.62+0xb7c/0x10e0
[  120.436547]  [000000000045d1f4] _do_fork+0x94/0x340
[  120.494868]  [000000000042cc14] sparc_do_fork+0x34/0x60
[  120.557359]  [00000000004061d4] linux_sparc_syscall32+0x34/0x60
[  120.628181] BUG: sleeping function called from invalid context at mm/mem=
ory.c:1223
[  120.718809] in_atomic(): 1, irqs_disabled(): 1, pid: 1149, name: kmod
[  120.795864] CPU: 0 PID: 1149 Comm: kmod Tainted: G      D W       4.3.0-=
rc1 #65
[  120.883360] Call Trace:
[  120.912508]  [00000000005044c0] unmap_single_vma+0x680/0x820
[  120.980210]  [000000000050501c] unmap_vmas+0x3c/0x60
[  121.039578]  [000000000050d440] exit_mmap+0x80/0x140
[  121.098939]  [000000000045bd58] mmput+0x58/0x100
[  121.154142]  [000000000045faa4] do_exit+0x284/0xae0
[  121.212464]  [0000000000428758] die_if_kernel+0x198/0x320
[  121.277038]  [0000000000432e98] kernel_mna_trap_fault+0xd8/0x120
[  121.348907]  [000000000042aa04] mem_address_unaligned+0x84/0xa0
[  121.419727]  [0000000000405f40] do_mna+0x3c/0x4c
[  121.474927]  [0000000000477618] alloc_pid+0x418/0x480
[  121.535334]  [000000000045cb5c] copy_process.isra.61.part.62+0xb7c/0x10e0
[  121.616574]  [000000000045d1f4] _do_fork+0x94/0x340
[  121.674896]  [000000000042cc14] sparc_do_fork+0x34/0x60
[  121.737389]  [00000000004061d4] linux_sparc_syscall32+0x34/0x60
[  121.808216] BUG: sleeping function called from invalid context at mm/mem=
ory.c:1223
[  121.898839] in_atomic(): 1, irqs_disabled(): 1, pid: 1149, name: kmod
[  121.975894] CPU: 0 PID: 1149 Comm: kmod Tainted: G      D W       4.3.0-=
rc1 #65
[  122.063390] Call Trace:
[  122.092538]  [00000000005044c0] unmap_single_vma+0x680/0x820
[  122.160242]  [000000000050501c] unmap_vmas+0x3c/0x60
[  122.219608]  [000000000050d440] exit_mmap+0x80/0x140
[  122.278971]  [000000000045bd58] mmput+0x58/0x100
[  122.334171]  [000000000045faa4] do_exit+0x284/0xae0
[  122.392495]  [0000000000428758] die_if_kernel+0x198/0x320
[  122.457069]  [0000000000432e98] kernel_mna_trap_fault+0xd8/0x120
[  122.528938]  [000000000042aa04] mem_address_unaligned+0x84/0xa0
[  122.599759]  [0000000000405f40] do_mna+0x3c/0x4c
[  122.654958]  [0000000000477618] alloc_pid+0x418/0x480
[  122.715364]  [000000000045cb5c] copy_process.isra.61.part.62+0xb7c/0x10e0
[  122.796606]  [000000000045d1f4] _do_fork+0x94/0x340
[  122.854927]  [000000000042cc14] sparc_do_fork+0x34/0x60
[  122.917419]  [00000000004061d4] linux_sparc_syscall32+0x34/0x60
[  122.988368] BUG: sleeping function called from invalid context at mm/mem=
ory.c:1223
[  123.078872] in_atomic(): 1, irqs_disabled(): 1, pid: 1149, name: kmod
[  123.155924] CPU: 0 PID: 1149 Comm: kmod Tainted: G      D W       4.3.0-=
rc1 #65
[  123.243418] Call Trace:
[  123.272567]  [00000000005044c0] unmap_single_vma+0x680/0x820
[  123.340269]  [000000000050501c] unmap_vmas+0x3c/0x60
[  123.399636]  [000000000050d440] exit_mmap+0x80/0x140
[  123.458998]  [000000000045bd58] mmput+0x58/0x100
[  123.514201]  [000000000045faa4] do_exit+0x284/0xae0
[  123.572525]  [0000000000428758] die_if_kernel+0x198/0x320
[  123.637097]  [0000000000432e98] kernel_mna_trap_fault+0xd8/0x120
[  123.708965]  [000000000042aa04] mem_address_unaligned+0x84/0xa0
[  123.779787]  [0000000000405f40] do_mna+0x3c/0x4c
[  123.834986]  [0000000000477618] alloc_pid+0x418/0x480
[  123.895391]  [000000000045cb5c] copy_process.isra.61.part.62+0xb7c/0x10e0
[  123.976632]  [000000000045d1f4] _do_fork+0x94/0x340
[  124.034955]  [000000000042cc14] sparc_do_fork+0x34/0x60
[  124.097447]  [00000000004061d4] linux_sparc_syscall32+0x34/0x60
[  124.168265] BUG: sleeping function called from invalid context at mm/mem=
ory.c:1223
[  124.258898] in_atomic(): 1, irqs_disabled(): 1, pid: 1149, name: kmod
[  124.335953] CPU: 0 PID: 1149 Comm: kmod Tainted: G      D W       4.3.0-=
rc1 #65
[  124.423449] Call Trace:
[  124.452597]  [00000000005044c0] unmap_single_vma+0x680/0x820
[  124.520299]  [000000000050501c] unmap_vmas+0x3c/0x60
[  124.579666]  [000000000050d440] exit_mmap+0x80/0x140
[  124.639027]  [000000000045bd58] mmput+0x58/0x100
[  124.694228]  [000000000045faa4] do_exit+0x284/0xae0
[  124.752552]  [0000000000428758] die_if_kernel+0x198/0x320
[  124.817128]  [0000000000432e98] kernel_mna_trap_fault+0xd8/0x120
[  124.888995]  [000000000042aa04] mem_address_unaligned+0x84/0xa0
[  124.959817]  [0000000000405f40] do_mna+0x3c/0x4c
[  125.015015]  [0000000000477618] alloc_pid+0x418/0x480
[  125.075421]  [000000000045cb5c] copy_process.isra.61.part.62+0xb7c/0x10e0
[  125.156661]  [000000000045d1f4] _do_fork+0x94/0x340
[  125.214985]  [000000000042cc14] sparc_do_fork+0x34/0x60
[  125.277476]  [00000000004061d4] linux_sparc_syscall32+0x34/0x60
[  125.348300] BUG: sleeping function called from invalid context at mm/mem=
ory.c:1223
[  125.438926] in_atomic(): 1, irqs_disabled(): 1, pid: 1149, name: kmod
[  125.515982] CPU: 0 PID: 1149 Comm: kmod Tainted: G      D W       4.3.0-=
rc1 #65
[  125.603479] Call Trace:
[  125.632626]  [00000000005044c0] unmap_single_vma+0x680/0x820
[  125.700330]  [000000000050501c] unmap_vmas+0x3c/0x60
[  125.759695]  [000000000050d440] exit_mmap+0x80/0x140
[  125.819058]  [000000000045bd58] mmput+0x58/0x100
[  125.874258]  [000000000045faa4] do_exit+0x284/0xae0
[  125.932583]  [0000000000428758] die_if_kernel+0x198/0x320
[  125.997155]  [0000000000432e98] kernel_mna_trap_fault+0xd8/0x120
[  126.069026]  [000000000042aa04] mem_address_unaligned+0x84/0xa0
[  126.139845]  [0000000000405f40] do_mna+0x3c/0x4c
[  126.195047]  [0000000000477618] alloc_pid+0x418/0x480
[  126.255450]  [000000000045cb5c] copy_process.isra.61.part.62+0xb7c/0x10e0
[  126.336694]  [000000000045d1f4] _do_fork+0x94/0x340
[  126.395015]  [000000000042cc14] sparc_do_fork+0x34/0x60
[  126.457508]  [00000000004061d4] linux_sparc_syscall32+0x34/0x60
[  126.528329] BUG: sleeping function called from invalid context at mm/mem=
ory.c:1223
[  126.618957] in_atomic(): 1, irqs_disabled(): 1, pid: 1149, name: kmod
[  126.696012] CPU: 0 PID: 1149 Comm: kmod Tainted: G      D W       4.3.0-=
rc1 #65
[  126.783506] Call Trace:
[  126.812655]  [00000000005044c0] unmap_single_vma+0x680/0x820
[  126.880358]  [000000000050501c] unmap_vmas+0x3c/0x60
[  126.939725]  [000000000050d440] exit_mmap+0x80/0x140
[  126.999087]  [000000000045bd58] mmput+0x58/0x100
[  127.054288]  [000000000045faa4] do_exit+0x284/0xae0
[  127.112610]  [0000000000428758] die_if_kernel+0x198/0x320
[  127.177187]  [0000000000432e98] kernel_mna_trap_fault+0xd8/0x120
[  127.249054]  [000000000042aa04] mem_address_unaligned+0x84/0xa0
[  127.319876]  [0000000000405f40] do_mna+0x3c/0x4c
[  127.375074]  [0000000000477618] alloc_pid+0x418/0x480
[  127.435481]  [000000000045cb5c] copy_process.isra.61.part.62+0xb7c/0x10e0
[  127.516721]  [000000000045d1f4] _do_fork+0x94/0x340
[  127.575044]  [000000000042cc14] sparc_do_fork+0x34/0x60
[  127.637535]  [00000000004061d4] linux_sparc_syscall32+0x34/0x60
[  127.708357] BUG: sleeping function called from invalid context at mm/mem=
ory.c:1223
[  127.798985] in_atomic(): 1, irqs_disabled(): 1, pid: 1149, name: kmod
[  127.876040] CPU: 0 PID: 1149 Comm: kmod Tainted: G      D W       4.3.0-=
rc1 #65
[  127.963538] Call Trace:
[  127.992684]  [00000000005044c0] unmap_single_vma+0x680/0x820
[  128.060388]  [000000000050501c] unmap_vmas+0x3c/0x60
[  128.119754]  [000000000050d440] exit_mmap+0x80/0x140
[  128.179118]  [000000000045bd58] mmput+0x58/0x100
[  128.234316]  [000000000045faa4] do_exit+0x284/0xae0
[  128.292643]  [0000000000428758] die_if_kernel+0x198/0x320
[  128.357215]  [0000000000432e98] kernel_mna_trap_fault+0xd8/0x120
[  128.429085]  [000000000042aa04] mem_address_unaligned+0x84/0xa0
[  128.499904]  [0000000000405f40] do_mna+0x3c/0x4c
[  128.555104]  [0000000000477618] alloc_pid+0x418/0x480
[  128.615510]  [000000000045cb5c] copy_process.isra.61.part.62+0xb7c/0x10e0
[  128.696752]  [000000000045d1f4] _do_fork+0x94/0x340
[  128.755073]  [000000000042cc14] sparc_do_fork+0x34/0x60
[  128.817565]  [00000000004061d4] linux_sparc_syscall32+0x34/0x60
[  128.888384] BUG: sleeping function called from invalid context at mm/mem=
ory.c:1223
[  128.979015] in_atomic(): 1, irqs_disabled(): 1, pid: 1149, name: kmod
[  129.056070] CPU: 0 PID: 1149 Comm: kmod Tainted: G      D W       4.3.0-=
rc1 #65
[  129.143566] Call Trace:
[  129.172713]  [00000000005044c0] unmap_single_vma+0x680/0x820
[  129.240416]  [000000000050501c] unmap_vmas+0x3c/0x60
[  129.299784]  [000000000050d440] exit_mmap+0x80/0x140
[  129.359144]  [000000000045bd58] mmput+0x58/0x100
[  129.414347]  [000000000045faa4] do_exit+0x284/0xae0
[  129.472670]  [0000000000428758] die_if_kernel+0x198/0x320
[  129.537246]  [0000000000432e98] kernel_mna_trap_fault+0xd8/0x120
[  129.609113]  [000000000042aa04] mem_address_unaligned+0x84/0xa0
[  129.679935]  [0000000000405f40] do_mna+0x3c/0x4c
[  129.735133]  [0000000000477618] alloc_pid+0x418/0x480
[  129.795541]  [000000000045cb5c] copy_process.isra.61.part.62+0xb7c/0x10e0
[  129.876779]  [000000000045d1f4] _do_fork+0x94/0x340
[  129.935104]  [000000000042cc14] sparc_do_fork+0x34/0x60
[  129.997594]  [00000000004061d4] linux_sparc_syscall32+0x34/0x60
[  130.068417] BUG: sleeping function called from invalid context at mm/mem=
ory.c:1223
[  130.159043] in_atomic(): 1, irqs_disabled(): 1, pid: 1149, name: kmod
[  130.236098] CPU: 0 PID: 1149 Comm: kmod Tainted: G      D W       4.3.0-=
rc1 #65
[  130.323596] Call Trace:
[  130.352744]  [00000000005044c0] unmap_single_vma+0x680/0x820
[  130.420444]  [000000000050501c] unmap_vmas+0x3c/0x60
[  130.479815]  [000000000050d440] exit_mmap+0x80/0x140
[  130.539175]  [000000000045bd58] mmput+0x58/0x100
[  130.594377]  [000000000045faa4] do_exit+0x284/0xae0
[  130.652699]  [0000000000428758] die_if_kernel+0x198/0x320
[  130.717275]  [0000000000432e98] kernel_mna_trap_fault+0xd8/0x120
[  130.789141]  [000000000042aa04] mem_address_unaligned+0x84/0xa0
[  130.859965]  [0000000000405f40] do_mna+0x3c/0x4c
[  130.915161]  [0000000000477618] alloc_pid+0x418/0x480
[  130.975571]  [000000000045cb5c] copy_process.isra.61.part.62+0xb7c/0x10e0
[  131.056807]  [000000000045d1f4] _do_fork+0x94/0x340
[  131.115132]  [000000000042cc14] sparc_do_fork+0x34/0x60
[  131.177624]  [00000000004061d4] linux_sparc_syscall32+0x34/0x60
[  131.248446] BUG: sleeping function called from invalid context at mm/mem=
ory.c:1223
[  131.339074] in_atomic(): 1, irqs_disabled(): 1, pid: 1149, name: kmod
[  131.416130] CPU: 0 PID: 1149 Comm: kmod Tainted: G      D W       4.3.0-=
rc1 #65
[  131.503624] Call Trace:
[  131.532773]  [00000000005044c0] unmap_single_vma+0x680/0x820
[  131.600475]  [000000000050501c] unmap_vmas+0x3c/0x60
[  131.659843]  [000000000050d440] exit_mmap+0x80/0x140
[  131.719204]  [000000000045bd58] mmput+0x58/0x100
[  131.774406]  [000000000045faa4] do_exit+0x284/0xae0
[  131.832730]  [0000000000428758] die_if_kernel+0x198/0x320
[  131.897303]  [0000000000432e98] kernel_mna_trap_fault+0xd8/0x120
[  131.969172]  [000000000042aa04] mem_address_unaligned+0x84/0xa0
[  132.039994]  [0000000000405f40] do_mna+0x3c/0x4c
[  132.095191]  [0000000000477618] alloc_pid+0x418/0x480
[  132.155599]  [000000000045cb5c] copy_process.isra.61.part.62+0xb7c/0x10e0
[  132.236839]  [000000000045d1f4] _do_fork+0x94/0x340
[  132.295161]  [000000000042cc14] sparc_do_fork+0x34/0x60
[  132.357652]  [00000000004061d4] linux_sparc_syscall32+0x34/0x60
[  132.428476] BUG: sleeping function called from invalid context at mm/mem=
ory.c:1223
[  132.519102] in_atomic(): 1, irqs_disabled(): 1, pid: 1149, name: kmod
[  132.596158] CPU: 0 PID: 1149 Comm: kmod Tainted: G      D W       4.3.0-=
rc1 #65
[  132.683655] Call Trace:
[  132.712801]  [00000000005044c0] unmap_single_vma+0x680/0x820
[  132.780507]  [000000000050501c] unmap_vmas+0x3c/0x60
[  132.839871]  [000000000050d440] exit_mmap+0x80/0x140
[  132.899236]  [000000000045bd58] mmput+0x58/0x100
[  132.954435]  [000000000045faa4] do_exit+0x284/0xae0
[  133.012759]  [0000000000428758] die_if_kernel+0x198/0x320
[  133.077332]  [0000000000432e98] kernel_mna_trap_fault+0xd8/0x120
[  133.149203]  [000000000042aa04] mem_address_unaligned+0x84/0xa0
[  133.220022]  [0000000000405f40] do_mna+0x3c/0x4c
[  133.275223]  [0000000000477618] alloc_pid+0x418/0x480
[  133.335627]  [000000000045cb5c] copy_process.isra.61.part.62+0xb7c/0x10e0
[  133.416871]  [000000000045d1f4] _do_fork+0x94/0x340
[  133.475191]  [000000000042cc14] sparc_do_fork+0x34/0x60
[  133.537684]  [00000000004061d4] linux_sparc_syscall32+0x34/0x60
[  133.608505] BUG: sleeping function called from invalid context at mm/mem=
ory.c:1223
[  133.699134] in_atomic(): 1, irqs_disabled(): 1, pid: 1149, name: kmod
[  133.776188] CPU: 0 PID: 1149 Comm: kmod Tainted: G      D W       4.3.0-=
rc1 #65
[  133.863683] Call Trace:
[  133.892831]  [00000000005044c0] unmap_single_vma+0x680/0x820
[  133.960535]  [000000000050501c] unmap_vmas+0x3c/0x60
[  134.019901]  [000000000050d440] exit_mmap+0x80/0x140
[  134.079262]  [000000000045bd58] mmput+0x58/0x100
[  134.134464]  [000000000045faa4] do_exit+0x284/0xae0
[  134.192788]  [0000000000428758] die_if_kernel+0x198/0x320
[  134.257362]  [0000000000432e98] kernel_mna_trap_fault+0xd8/0x120
[  134.329230]  [000000000042aa04] mem_address_unaligned+0x84/0xa0
[  134.400051]  [0000000000405f40] do_mna+0x3c/0x4c
[  134.455250]  [0000000000477618] alloc_pid+0x418/0x480
[  134.515658]  [000000000045cb5c] copy_process.isra.61.part.62+0xb7c/0x10e0
[  134.596898]  [000000000045d1f4] _do_fork+0x94/0x340
[  134.655221]  [000000000042cc14] sparc_do_fork+0x34/0x60
[  134.717710]  [00000000004061d4] linux_sparc_syscall32+0x34/0x60
[  134.788529] BUG: sleeping function called from invalid context at kernel=
/locking/rwsem.c:48
[  134.888537] in_atomic(): 1, irqs_disabled(): 1, pid: 1149, name: kmod
[  134.965591] CPU: 0 PID: 1149 Comm: kmod Tainted: G      D W       4.3.0-=
rc1 #65
[  135.053088] Call Trace:
[  135.082231]  [000000000081d830] down_write+0x10/0x60
[  135.141608]  [000000000050a798] unlink_file_vma+0x18/0x40
[  135.206180]  [0000000000503ae0] free_pgtables+0x20/0x120
[  135.269711]  [000000000050d454] exit_mmap+0x94/0x140
[  135.329073]  [000000000045bd58] mmput+0x58/0x100
[  135.384273]  [000000000045faa4] do_exit+0x284/0xae0
[  135.442598]  [0000000000428758] die_if_kernel+0x198/0x320
[  135.507171]  [0000000000432e98] kernel_mna_trap_fault+0xd8/0x120
[  135.579040]  [000000000042aa04] mem_address_unaligned+0x84/0xa0
[  135.649861]  [0000000000405f40] do_mna+0x3c/0x4c
[  135.705061]  [0000000000477618] alloc_pid+0x418/0x480
[  135.765468]  [000000000045cb5c] copy_process.isra.61.part.62+0xb7c/0x10e0
[  135.846707]  [000000000045d1f4] _do_fork+0x94/0x340
[  135.905029]  [000000000042cc14] sparc_do_fork+0x34/0x60
[  135.967522]  [00000000004061d4] linux_sparc_syscall32+0x34/0x60
[  136.038342] BUG: sleeping function called from invalid context at kernel=
/locking/rwsem.c:48
[  136.138347] in_atomic(): 1, irqs_disabled(): 1, pid: 1149, name: kmod
[  136.215403] CPU: 0 PID: 1149 Comm: kmod Tainted: G      D W       4.3.0-=
rc1 #65
[  136.302897] Call Trace:
[  136.332040]  [000000000081d830] down_write+0x10/0x60
[  136.391413]  [0000000000510a68] unlink_anon_vmas+0x88/0x220
[  136.458073]  [0000000000503b54] free_pgtables+0x94/0x120
[  136.521605]  [000000000050d454] exit_mmap+0x94/0x140
[  136.580967]  [000000000045bd58] mmput+0x58/0x100
[  136.636167]  [000000000045faa4] do_exit+0x284/0xae0
[  136.694491]  [0000000000428758] die_if_kernel+0x198/0x320
[  136.759065]  [0000000000432e98] kernel_mna_trap_fault+0xd8/0x120
[  136.830934]  [000000000042aa04] mem_address_unaligned+0x84/0xa0
[  136.901754]  [0000000000405f40] do_mna+0x3c/0x4c
[  136.956954]  [0000000000477618] alloc_pid+0x418/0x480
[  137.017360]  [000000000045cb5c] copy_process.isra.61.part.62+0xb7c/0x10e0
[  137.098602]  [000000000045d1f4] _do_fork+0x94/0x340
[  137.156923]  [000000000042cc14] sparc_do_fork+0x34/0x60
[  137.219414]  [00000000004061d4] linux_sparc_syscall32+0x34/0x60
[  137.290236] BUG: sleeping function called from invalid context at kernel=
/locking/rwsem.c:48
[  137.390238] in_atomic(): 1, irqs_disabled(): 1, pid: 1149, name: kmod
[  137.467294] CPU: 0 PID: 1149 Comm: kmod Tainted: G      D W       4.3.0-=
rc1 #65
[  137.554791] Call Trace:
[  137.583934]  [000000000081d830] down_write+0x10/0x60
[  137.643310]  [000000000050a798] unlink_file_vma+0x18/0x40
[  137.707883]  [0000000000503b5c] free_pgtables+0x9c/0x120
[  137.771418]  [000000000050d454] exit_mmap+0x94/0x140
[  137.830777]  [000000000045bd58] mmput+0x58/0x100
[  137.885979]  [000000000045faa4] do_exit+0x284/0xae0
[  137.944302]  [0000000000428758] die_if_kernel+0x198/0x320
[  138.008877]  [0000000000432e98] kernel_mna_trap_fault+0xd8/0x120
[  138.080743]  [000000000042aa04] mem_address_unaligned+0x84/0xa0
[  138.151566]  [0000000000405f40] do_mna+0x3c/0x4c
[  138.206764]  [0000000000477618] alloc_pid+0x418/0x480
[  138.267173]  [000000000045cb5c] copy_process.isra.61.part.62+0xb7c/0x10e0
[  138.348412]  [000000000045d1f4] _do_fork+0x94/0x340
[  138.406736]  [000000000042cc14] sparc_do_fork+0x34/0x60
[  138.469225]  [00000000004061d4] linux_sparc_syscall32+0x34/0x60
[  138.540046] BUG: sleeping function called from invalid context at kernel=
/locking/rwsem.c:48
[  138.640051] in_atomic(): 1, irqs_disabled(): 1, pid: 1149, name: kmod
[  138.717105] CPU: 0 PID: 1149 Comm: kmod Tainted: G      D W       4.3.0-=
rc1 #65
[  138.804601] Call Trace:
[  138.833745]  [000000000081d830] down_write+0x10/0x60
[  138.893115]  [0000000000510a68] unlink_anon_vmas+0x88/0x220
[  138.959779]  [0000000000503b54] free_pgtables+0x94/0x120
[  139.023310]  [000000000050d454] exit_mmap+0x94/0x140
[  139.082669]  [000000000045bd58] mmput+0x58/0x100
[  139.137873]  [000000000045faa4] do_exit+0x284/0xae0
[  139.196195]  [0000000000428758] die_if_kernel+0x198/0x320
[  139.260770]  [0000000000432e98] kernel_mna_trap_fault+0xd8/0x120
[  139.332636]  [000000000042aa04] mem_address_unaligned+0x84/0xa0
[  139.403461]  [0000000000405f40] do_mna+0x3c/0x4c
[  139.458658]  [0000000000477618] alloc_pid+0x418/0x480
[  139.519065]  [000000000045cb5c] c


#
# Automatically generated file; DO NOT EDIT.
# Linux/sparc64 4.3.0-rc1 Kernel Configuration
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
CONFIG_PGTABLE_LEVELS=3D4
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
CONFIG_CROSS_MEMORY_ATTACH=3Dy
# CONFIG_FHANDLE is not set
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
# CONFIG_TASKSTATS is not set

#
# RCU Subsystem
#
CONFIG_TREE_RCU=3Dy
# CONFIG_RCU_EXPERT is not set
CONFIG_SRCU=3Dy
# CONFIG_TASKS_RCU is not set
CONFIG_RCU_STALL_COMMON=3Dy
# CONFIG_TREE_RCU_TRACE is not set
# CONFIG_RCU_EXPEDITE_BOOT is not set
# CONFIG_BUILD_BIN2C is not set
# CONFIG_IKCONFIG is not set
CONFIG_LOG_BUF_SHIFT=17
CONFIG_LOG_CPU_MAX_BUF_SHIFT=12
# CONFIG_CGROUPS is not set
# CONFIG_CHECKPOINT_RESTORE is not set
CONFIG_NAMESPACES=3Dy
# CONFIG_UTS_NS is not set
# CONFIG_IPC_NS is not set
# CONFIG_USER_NS is not set
# CONFIG_PID_NS is not set
# CONFIG_NET_NS is not set
# CONFIG_SCHED_AUTOGROUP is not set
# CONFIG_SYSFS_DEPRECATED is not set
CONFIG_RELAY=3Dy
# CONFIG_BLK_DEV_INITRD is not set
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
CONFIG_USERFAULTFD=3Dy
CONFIG_PCI_QUIRKS=3Dy
CONFIG_MEMBARRIER=3Dy
# CONFIG_EMBEDDED is not set
CONFIG_HAVE_PERF_EVENTS=3Dy
CONFIG_PERF_USE_VMALLOC=3Dy

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
CONFIG_SLUB_CPU_PARTIAL=3Dy
# CONFIG_SYSTEM_DATA_VERIFICATION is not set
# CONFIG_PROFILING is not set
CONFIG_HAVE_OPROFILE=3Dy
# CONFIG_KPROBES is not set
# CONFIG_JUMP_LABEL is not set
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
# CONFIG_GCOV_KERNEL is not set
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
CONFIG_MODULES_TREE_LOOKUP=3Dy
CONFIG_STOP_MACHINE=3Dy
CONFIG_BLOCK=3Dy
CONFIG_BLK_DEV_BSG=3Dy
CONFIG_BLK_DEV_BSGLIB=3Dy
# CONFIG_BLK_DEV_INTEGRITY is not set
# CONFIG_BLK_CMDLINE_PARSER is not set

#
# Partition Types
#
# CONFIG_PARTITION_ADVANCED is not set
CONFIG_MSDOS_PARTITION=3Dy
CONFIG_SUN_PARTITION=3Dy
CONFIG_EFI_PARTITION=3Dy
CONFIG_BLOCK_COMPAT=3Dy

#
# IO Schedulers
#
CONFIG_IOSCHED_NOOP=3Dy
# CONFIG_IOSCHED_DEADLINE is not set
CONFIG_IOSCHED_CFQ=3Dy
CONFIG_DEFAULT_CFQ=3Dy
# CONFIG_DEFAULT_NOOP is not set
CONFIG_DEFAULT_IOSCHED=3D"cfq"
CONFIG_INLINE_SPIN_UNLOCK_IRQ=3Dy
CONFIG_INLINE_READ_UNLOCK=3Dy
CONFIG_INLINE_READ_UNLOCK_IRQ=3Dy
CONFIG_INLINE_WRITE_UNLOCK=3Dy
CONFIG_INLINE_WRITE_UNLOCK_IRQ=3Dy
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
CONFIG_HZ_100=3Dy
# CONFIG_HZ_250 is not set
# CONFIG_HZ_300 is not set
# CONFIG_HZ_1000 is not set
CONFIG_HZ=100
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
CONFIG_PCI_BUS_ADDR_T_64BIT=3Dy
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
# CONFIG_CORE_DUMP_DEFAULT_ELF_HEADERS is not set
CONFIG_BINFMT_SCRIPT=3Dy
# CONFIG_HAVE_AOUT is not set
CONFIG_BINFMT_MISC=3Dm
CONFIG_COREDUMP=3Dy
CONFIG_COMPAT=3Dy
CONFIG_SYSVIPC_COMPAT=3Dy
CONFIG_KEYS_COMPAT=3Dy
CONFIG_NET=3Dy
CONFIG_NET_INGRESS=3Dy

#
# Networking options
#
CONFIG_PACKET=3Dy
# CONFIG_PACKET_DIAG is not set
CONFIG_UNIX=3Dy
CONFIG_UNIX_DIAG=3Dy
CONFIG_XFRM=3Dy
CONFIG_XFRM_ALGO=3Dm
# CONFIG_XFRM_USER is not set
# CONFIG_XFRM_SUB_POLICY is not set
# CONFIG_XFRM_MIGRATE is not set
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
CONFIG_INET_LRO=3Dm
CONFIG_INET_DIAG=3Dm
CONFIG_INET_TCP_DIAG=3Dm
CONFIG_INET_UDP_DIAG=3Dm
# CONFIG_TCP_CONG_ADVANCED is not set
CONFIG_TCP_CONG_CUBIC=3Dy
CONFIG_DEFAULT_TCP_CONG=3D"cubic"
CONFIG_TCP_MD5SIG=3Dy
CONFIG_IPV6=3Dy
CONFIG_IPV6_ROUTER_PREF=3Dy
CONFIG_IPV6_ROUTE_INFO=3Dy
CONFIG_IPV6_OPTIMISTIC_DAD=3Dy
CONFIG_INET6_AH=3Dm
CONFIG_INET6_ESP=3Dm
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
CONFIG_IPV6_MULTIPLE_TABLES=3Dy
CONFIG_IPV6_SUBTREES=3Dy
CONFIG_IPV6_MROUTE=3Dy
CONFIG_IPV6_MROUTE_MULTIPLE_TABLES=3Dy
CONFIG_IPV6_PIMSM_V2=3Dy
# CONFIG_NETWORK_SECMARK is not set
# CONFIG_NET_PTP_CLASSIFY is not set
# CONFIG_NETWORK_PHY_TIMESTAMPING is not set
CONFIG_NETFILTER=3Dy
# CONFIG_NETFILTER_DEBUG is not set
CONFIG_NETFILTER_ADVANCED=3Dy

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
CONFIG_NF_CONNTRACK_MARK=3Dy
# CONFIG_NF_CONNTRACK_PROCFS is not set
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
CONFIG_NF_TABLES_NETDEV=3Dm
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
# CONFIG_NETFILTER_XT_TARGET_CT is not set
# CONFIG_NETFILTER_XT_TARGET_DSCP is not set
CONFIG_NETFILTER_XT_TARGET_HL=3Dm
CONFIG_NETFILTER_XT_TARGET_HMARK=3Dm
CONFIG_NETFILTER_XT_TARGET_IDLETIMER=3Dm
# CONFIG_NETFILTER_XT_TARGET_LED is not set
CONFIG_NETFILTER_XT_TARGET_LOG=3Dm
CONFIG_NETFILTER_XT_TARGET_MARK=3Dm
CONFIG_NETFILTER_XT_NAT=3Dm
CONFIG_NETFILTER_XT_TARGET_NETMAP=3Dm
CONFIG_NETFILTER_XT_TARGET_NFLOG=3Dm
CONFIG_NETFILTER_XT_TARGET_NFQUEUE=3Dm
# CONFIG_NETFILTER_XT_TARGET_NOTRACK is not set
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
CONFIG_NF_TABLES_IPV4=3Dm
CONFIG_NFT_CHAIN_ROUTE_IPV4=3Dm
CONFIG_NFT_REJECT_IPV4=3Dm
CONFIG_NFT_DUP_IPV4=3Dm
CONFIG_NF_TABLES_ARP=3Dm
CONFIG_NF_DUP_IPV4=3Dm
# CONFIG_NF_LOG_ARP is not set
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
CONFIG_NF_TABLES_IPV6=3Dm
CONFIG_NFT_CHAIN_ROUTE_IPV6=3Dm
CONFIG_NFT_REJECT_IPV6=3Dm
CONFIG_NFT_DUP_IPV6=3Dm
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
# CONFIG_IP_DCCP is not set
# CONFIG_IP_SCTP is not set
# CONFIG_RDS is not set
# CONFIG_TIPC is not set
# CONFIG_ATM is not set
# CONFIG_L2TP is not set
CONFIG_STP=3Dm
CONFIG_GARP=3Dm
CONFIG_MRP=3Dm
# CONFIG_BRIDGE is not set
CONFIG_HAVE_NET_DSA=3Dy
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
# CONFIG_NET_SCHED is not set
# CONFIG_DCB is not set
CONFIG_DNS_RESOLVER=3Dy
# CONFIG_BATMAN_ADV is not set
# CONFIG_OPENVSWITCH is not set
# CONFIG_VSOCKETS is not set
CONFIG_NETLINK_MMAP=3Dy
# CONFIG_NETLINK_DIAG is not set
# CONFIG_MPLS is not set
# CONFIG_HSR is not set
# CONFIG_NET_SWITCHDEV is not set
CONFIG_RPS=3Dy
CONFIG_RFS_ACCEL=3Dy
CONFIG_XPS=3Dy
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
CONFIG_LWTUNNEL=3Dy
CONFIG_HAVE_BPF_JIT=3Dy

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
# CONFIG_SYS_HYPERVISOR is not set
# CONFIG_GENERIC_CPU_DEVICES is not set
# CONFIG_DMA_SHARED_BUFFER is not set

#
# Bus devices
#
# CONFIG_CONNECTOR is not set
# CONFIG_MTD is not set
CONFIG_OF=3Dy
CONFIG_OF_PROMTREE=3Dy
CONFIG_OF_NET=3Dy
CONFIG_OF_PCI=3Dy
# CONFIG_OF_OVERLAY is not set
CONFIG_ARCH_MIGHT_HAVE_PC_PARPORT=3Dy
CONFIG_PARPORT=3Dm
CONFIG_PARPORT_PC=3Dm
CONFIG_PARPORT_PC_FIFO=3Dy
CONFIG_PARPORT_PC_SUPERIO=3Dy
# CONFIG_PARPORT_GSC is not set
CONFIG_PARPORT_SUNBPP=3Dm
# CONFIG_PARPORT_AX88796 is not set
CONFIG_PARPORT_1284=3Dy
CONFIG_PARPORT_NOT_PC=3Dy
CONFIG_BLK_DEV=3Dy
# CONFIG_BLK_DEV_NULL_BLK is not set
# CONFIG_BLK_DEV_FD is not set
# CONFIG_PARIDE is not set
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
# CONFIG_DUMMY_IRQ is not set
# CONFIG_PHANTOM is not set
# CONFIG_SGI_IOC4 is not set
# CONFIG_TIFM_CORE is not set
CONFIG_ENCLOSURE_SERVICES=3Dm
# CONFIG_HP_ILO is not set
# CONFIG_SRAM is not set
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
# Intel MIC Host Driver
#

#
# Intel MIC Card Driver
#

#
# SCIF Driver
#
# CONFIG_GENWQE is not set
# CONFIG_ECHO is not set
# CONFIG_CXL_BASE is not set
# CONFIG_CXL_KERNEL_API is not set
# CONFIG_CXL_EEH is not set
CONFIG_HAVE_IDE=3Dy
# CONFIG_IDE is not set

#
# SCSI device support
#
CONFIG_SCSI_MOD=3Dy
# CONFIG_RAID_ATTRS is not set
CONFIG_SCSI=3Dy
CONFIG_SCSI_DMA=3Dy
# CONFIG_SCSI_NETLINK is not set
CONFIG_SCSI_MQ_DEFAULT=3Dy
# CONFIG_SCSI_PROC_FS is not set

#
# SCSI support type (disk, tape, CD-ROM)
#
CONFIG_BLK_DEV_SD=3Dy
# CONFIG_CHR_DEV_ST is not set
# CONFIG_CHR_DEV_OSST is not set
CONFIG_BLK_DEV_SR=3Dm
CONFIG_BLK_DEV_SR_VENDOR=3Dy
CONFIG_CHR_DEV_SG=3Dm
CONFIG_CHR_DEV_SCH=3Dm
CONFIG_SCSI_ENCLOSURE=3Dm
CONFIG_SCSI_CONSTANTS=3Dy
CONFIG_SCSI_LOGGING=3Dy
CONFIG_SCSI_SCAN_ASYNC=3Dy

#
# SCSI Transports
#
CONFIG_SCSI_SPI_ATTRS=3Dy
# CONFIG_SCSI_FC_ATTRS is not set
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
# CONFIG_SCSI_AIC7XXX is not set
# CONFIG_SCSI_AIC79XX is not set
# CONFIG_SCSI_AIC94XX is not set
# CONFIG_SCSI_MVSAS is not set
# CONFIG_SCSI_MVUMI is not set
CONFIG_SCSI_ADVANSYS=3Dm
# CONFIG_SCSI_ARCMSR is not set
# CONFIG_SCSI_ESAS2R is not set
# CONFIG_MEGARAID_NEWGEN is not set
# CONFIG_MEGARAID_LEGACY is not set
# CONFIG_MEGARAID_SAS is not set
# CONFIG_SCSI_MPT2SAS is not set
# CONFIG_SCSI_MPT3SAS is not set
# CONFIG_SCSI_UFSHCD is not set
# CONFIG_SCSI_HPTIOP is not set
# CONFIG_SCSI_SNIC is not set
# CONFIG_SCSI_DMX3191D is not set
# CONFIG_SCSI_FUTURE_DOMAIN is not set
# CONFIG_SCSI_IPS is not set
# CONFIG_SCSI_INITIO is not set
# CONFIG_SCSI_INIA100 is not set
# CONFIG_SCSI_PPA is not set
# CONFIG_SCSI_IMM is not set
# CONFIG_SCSI_STEX is not set
CONFIG_SCSI_SYM53C8XX_2=3Dy
CONFIG_SCSI_SYM53C8XX_DMA_ADDRESSING_MODE=3D1
CONFIG_SCSI_SYM53C8XX_DEFAULT_TAGS=16
CONFIG_SCSI_SYM53C8XX_MAX_TAGSd
CONFIG_SCSI_SYM53C8XX_MMIO=3Dy
# CONFIG_SCSI_IPR is not set
# CONFIG_SCSI_QLOGIC_1280 is not set
# CONFIG_SCSI_QLOGICPTI is not set
# CONFIG_SCSI_QLA_ISCSI is not set
# CONFIG_SCSI_DC395x is not set
# CONFIG_SCSI_AM53C974 is not set
# CONFIG_SCSI_WD719X is not set
# CONFIG_SCSI_DEBUG is not set
# CONFIG_SCSI_SUNESP is not set
# CONFIG_SCSI_PMCRAID is not set
# CONFIG_SCSI_PM8001 is not set
# CONFIG_SCSI_DH is not set
# CONFIG_SCSI_OSD_INITIATOR is not set
CONFIG_ATA=3Dm
# CONFIG_ATA_NONSTANDARD is not set
CONFIG_ATA_VERBOSE_ERROR=3Dy
CONFIG_SATA_PMP=3Dy

#
# Controllers with non-SFF native interface
#
# CONFIG_SATA_AHCI is not set
# CONFIG_SATA_AHCI_PLATFORM is not set
# CONFIG_AHCI_CEVA is not set
# CONFIG_SATA_INIC162X is not set
# CONFIG_SATA_ACARD_AHCI is not set
# CONFIG_SATA_SIL24 is not set
CONFIG_ATA_SFF=3Dy

#
# SFF controllers with custom DMA interface
#
# CONFIG_PDC_ADMA is not set
# CONFIG_SATA_QSTOR is not set
# CONFIG_SATA_SX4 is not set
CONFIG_ATA_BMDMA=3Dy

#
# SATA SFF controllers with BMDMA
#
# CONFIG_ATA_PIIX is not set
# CONFIG_SATA_MV is not set
# CONFIG_SATA_NV is not set
CONFIG_SATA_PROMISE=3Dm
CONFIG_SATA_SIL=3Dm
# CONFIG_SATA_SIS is not set
# CONFIG_SATA_SVW is not set
# CONFIG_SATA_ULI is not set
CONFIG_SATA_VIA=3Dm
# CONFIG_SATA_VITESSE is not set

#
# PATA SFF controllers with BMDMA
#
CONFIG_PATA_ALI=3Dm
# CONFIG_PATA_AMD is not set
# CONFIG_PATA_ARTOP is not set
# CONFIG_PATA_ATIIXP is not set
# CONFIG_PATA_ATP867X is not set
CONFIG_PATA_CMD64X=3Dm
# CONFIG_PATA_CYPRESS is not set
# CONFIG_PATA_EFAR is not set
CONFIG_PATA_HPT366=3Dm
CONFIG_PATA_HPT37X=3Dm
CONFIG_PATA_HPT3X2N=3Dm
CONFIG_PATA_HPT3X3=3Dm
CONFIG_PATA_HPT3X3_DMA=3Dy
# CONFIG_PATA_IT8213 is not set
# CONFIG_PATA_IT821X is not set
# CONFIG_PATA_JMICRON is not set
# CONFIG_PATA_MARVELL is not set
# CONFIG_PATA_NETCELL is not set
# CONFIG_PATA_NINJA32 is not set
# CONFIG_PATA_NS87415 is not set
# CONFIG_PATA_OLDPIIX is not set
# CONFIG_PATA_OPTIDMA is not set
CONFIG_PATA_PDC2027X=3Dm
CONFIG_PATA_PDC_OLD=3Dm
# CONFIG_PATA_RADISYS is not set
# CONFIG_PATA_RDC is not set
# CONFIG_PATA_SCH is not set
# CONFIG_PATA_SERVERWORKS is not set
CONFIG_PATA_SIL680=3Dm
# CONFIG_PATA_SIS is not set
# CONFIG_PATA_TOSHIBA is not set
# CONFIG_PATA_TRIFLEX is not set
CONFIG_PATA_VIA=3Dm
# CONFIG_PATA_WINBOND is not set

#
# PIO-only SFF controllers
#
# CONFIG_PATA_CMD640_PCI is not set
# CONFIG_PATA_MPIIX is not set
# CONFIG_PATA_NS87410 is not set
# CONFIG_PATA_OPTI is not set
# CONFIG_PATA_RZ1000 is not set

#
# Generic fallback / legacy drivers
#
# CONFIG_ATA_GENERIC is not set
# CONFIG_PATA_LEGACY is not set
# CONFIG_MD is not set
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
# CONFIG_NET_TEAM is not set
# CONFIG_MACVLAN is not set
# CONFIG_IPVLAN is not set
# CONFIG_VXLAN is not set
CONFIG_NETCONSOLE=3Dy
CONFIG_NETPOLL=3Dy
CONFIG_NET_POLL_CONTROLLER=3Dy
CONFIG_TUN=3Dm
# CONFIG_TUN_VNET_CROSS_LE is not set
# CONFIG_VETH is not set
# CONFIG_NLMON is not set
# CONFIG_NET_VRF is not set
# CONFIG_ARCNET is not set

#
# CAIF transport drivers
#

#
# Distributed Switch Architecture drivers
#
# CONFIG_NET_DSA_MV88E6XXX is not set
# CONFIG_NET_DSA_MV88E6XXX_NEED_PPU is not set
CONFIG_ETHERNET=3Dy
# CONFIG_NET_VENDOR_3COM is not set
# CONFIG_NET_VENDOR_ADAPTEC is not set
# CONFIG_GRETH is not set
# CONFIG_NET_VENDOR_AGERE is not set
# CONFIG_NET_VENDOR_ALTEON is not set
# CONFIG_ALTERA_TSE is not set
# CONFIG_NET_VENDOR_AMD is not set
# CONFIG_NET_VENDOR_ARC is not set
# CONFIG_NET_VENDOR_ATHEROS is not set
# CONFIG_NET_CADENCE is not set
# CONFIG_NET_VENDOR_BROADCOM is not set
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
# CONFIG_IP1000 is not set
# CONFIG_JME is not set
# CONFIG_NET_VENDOR_MARVELL is not set
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
# CONFIG_NET_VENDOR_RENESAS is not set
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
# CONFIG_SUNBMAC is not set
# CONFIG_SUNQE is not set
# CONFIG_SUNGEM is not set
# CONFIG_CASSINI is not set
# CONFIG_NIU is not set
# CONFIG_NET_VENDOR_SYNOPSYS is not set
# CONFIG_NET_VENDOR_TEHUTI is not set
# CONFIG_NET_VENDOR_TI is not set
# CONFIG_NET_VENDOR_VIA is not set
# CONFIG_NET_VENDOR_WIZNET is not set
# CONFIG_FDDI is not set
# CONFIG_HIPPI is not set
# CONFIG_PHYLIB is not set
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

#
# Input device support
#
CONFIG_INPUT=3Dy
CONFIG_INPUT_LEDS=3Dm
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
# CONFIG_SERIAL_UARTLITE is not set
CONFIG_SERIAL_SUNCORE=3Dy
# CONFIG_SERIAL_SUNZILOG is not set
# CONFIG_SERIAL_SUNSU is not set
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
CONFIG_PRINTER=3Dm
# CONFIG_LP_CONSOLE is not set
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
# CONFIG_PPS is not set

#
# PPS generators support
#

#
# PTP clock support
#
# CONFIG_PTP_1588_CLOCK is not set

#
# Enable PHYLIB and NETWORK_PHY_TIMESTAMPING to see the additional clocks.
#
CONFIG_ARCH_WANT_OPTIONAL_GPIOLIB=3Dy
# CONFIG_GPIOLIB is not set
# CONFIG_W1 is not set
# CONFIG_POWER_SUPPLY is not set
# CONFIG_POWER_AVS is not set
# CONFIG_HWMON is not set
# CONFIG_THERMAL is not set
CONFIG_WATCHDOG=3Dy
CONFIG_WATCHDOG_CORE=3Dy
# CONFIG_WATCHDOG_NOWAYOUT is not set

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

#
# PCI-based Watchdog Cards
#
# CONFIG_PCIPCWATCHDOG is not set
# CONFIG_WDTPCI is not set
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
# CONFIG_HID_BATTERY_STRENGTH is not set
CONFIG_HIDRAW=3Dy
CONFIG_UHID=3Dm
CONFIG_HID_GENERIC=3Dm

#
# Special HID drivers
#
CONFIG_HID_A4TECH=3Dm
# CONFIG_HID_ACRUX is not set
CONFIG_HID_APPLE=3Dm
# CONFIG_HID_AUREAL is not set
CONFIG_HID_BELKIN=3Dm
CONFIG_HID_CHERRY=3Dm
CONFIG_HID_CHICONY=3Dm
CONFIG_HID_CYPRESS=3Dm
# CONFIG_HID_DRAGONRISE is not set
# CONFIG_HID_EMS_FF is not set
# CONFIG_HID_ELECOM is not set
CONFIG_HID_EZKEY=3Dm
# CONFIG_HID_GEMBIRD is not set
# CONFIG_HID_KEYTOUCH is not set
# CONFIG_HID_KYE is not set
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
# CONFIG_HID_ORTEK is not set
# CONFIG_HID_PANTHERLORD is not set
# CONFIG_HID_PETALYNX is not set
# CONFIG_HID_PICOLCD is not set
# CONFIG_HID_PLANTRONICS is not set
# CONFIG_HID_PRIMAX is not set
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
# CONFIG_HID_THINGM is not set
# CONFIG_HID_THRUSTMASTER is not set
# CONFIG_HID_WACOM is not set
# CONFIG_HID_WIIMOTE is not set
# CONFIG_HID_XINMO is not set
# CONFIG_HID_ZEROPLUS is not set
# CONFIG_HID_ZYDACRON is not set
# CONFIG_HID_SENSOR_HUB is not set
CONFIG_USB_OHCI_LITTLE_ENDIAN=3Dy
# CONFIG_USB_SUPPORT is not set
# CONFIG_UWB is not set
# CONFIG_MMC is not set
# CONFIG_MEMSTICK is not set
CONFIG_NEW_LEDS=3Dy
CONFIG_LEDS_CLASS=3Dm
# CONFIG_LEDS_CLASS_FLASH is not set

#
# LED drivers
#
# CONFIG_LEDS_BCM6328 is not set
# CONFIG_LEDS_BCM6358 is not set
CONFIG_LEDS_SUNFIRE=3Dm

#
# LED driver for blink(1) USB RGB LED is under Special HID drivers (HID_THI=
NGM)
#

#
# LED Triggers
#
CONFIG_LEDS_TRIGGERS=3Dy
CONFIG_LEDS_TRIGGER_TIMER=3Dm
# CONFIG_LEDS_TRIGGER_ONESHOT is not set
CONFIG_LEDS_TRIGGER_HEARTBEAT=3Dm
# CONFIG_LEDS_TRIGGER_BACKLIGHT is not set
# CONFIG_LEDS_TRIGGER_CPU is not set
CONFIG_LEDS_TRIGGER_DEFAULT_ON=3Dm

#
# iptables trigger is under Netfilter config (LED target)
#
# CONFIG_LEDS_TRIGGER_TRANSIENT is not set
# CONFIG_LEDS_TRIGGER_CAMERA is not set
# CONFIG_ACCESSIBILITY is not set
# CONFIG_INFINIBAND is not set
CONFIG_RTC_LIB=3Dy
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
# CONFIG_RTC_DRV_ZYNQMP is not set

#
# on-CPU RTC drivers
#
CONFIG_RTC_DRV_SUN4V=3Dy
CONFIG_RTC_DRV_STARFIRE=3Dy
# CONFIG_RTC_DRV_SNVS is not set

#
# HID Sensor RTC drivers
#
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
# CONFIG_CHROME_PLATFORMS is not set

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
# CONFIG_SUNXI_SRAM is not set
# CONFIG_SOC_TI is not set
# CONFIG_PM_DEVFREQ is not set
# CONFIG_EXTCON is not set
# CONFIG_MEMORY is not set
# CONFIG_IIO is not set
# CONFIG_NTB is not set
# CONFIG_VME_BUS is not set
# CONFIG_PWM is not set
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
# CONFIG_THUNDERBOLT is not set

#
# Android
#
# CONFIG_ANDROID is not set
# CONFIG_LIBNVDIMM is not set
# CONFIG_NVMEM is not set

#
# Misc Linux/SPARC drivers
#
CONFIG_SUN_OPENPROMIO=3Dm
CONFIG_OBP_FLASH=3Dm
# CONFIG_TADPOLE_TS102_UCTRL is not set
# CONFIG_BBC_I2C is not set
CONFIG_ENVCTRL=3Dm
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
# CONFIG_OCFS2_FS is not set
# CONFIG_BTRFS_FS is not set
# CONFIG_NILFS2_FS is not set
# CONFIG_F2FS_FS is not set
CONFIG_FS_POSIX_ACL=3Dy
CONFIG_EXPORTFS=3Dm
CONFIG_FILE_LOCKING=3Dy
CONFIG_FSNOTIFY=3Dy
CONFIG_DNOTIFY=3Dy
CONFIG_INOTIFY_USER=3Dy
CONFIG_FANOTIFY=3Dy
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
CONFIG_NTFS_RW=3Dy

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
CONFIG_CONFIGFS_FS=3Dm
# CONFIG_MISC_FILESYSTEMS is not set
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
# CONFIG_NFSD_PNFS is not set
# CONFIG_NFSD_FAULT_INJECTION is not set
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
# CONFIG_CIFS_UPCALL is not set
CONFIG_CIFS_XATTR=3Dy
CONFIG_CIFS_POSIX=3Dy
# CONFIG_CIFS_ACL is not set
# CONFIG_CIFS_DEBUG is not set
# CONFIG_CIFS_DFS_UPCALL is not set
CONFIG_CIFS_SMB2=3Dy
CONFIG_CIFS_SMB311=3Dy
# CONFIG_CIFS_FSCACHE is not set
# CONFIG_NCP_FS is not set
# CONFIG_CODA_FS is not set
# CONFIG_AFS_FS is not set
CONFIG_NLS=3Dm
CONFIG_NLS_DEFAULT=3D"utf-8"
# CONFIG_NLS_CODEPAGE_437 is not set
# CONFIG_NLS_CODEPAGE_737 is not set
# CONFIG_NLS_CODEPAGE_775 is not set
# CONFIG_NLS_CODEPAGE_850 is not set
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
# CONFIG_NLS_ISO8859_1 is not set
# CONFIG_NLS_ISO8859_2 is not set
# CONFIG_NLS_ISO8859_3 is not set
# CONFIG_NLS_ISO8859_4 is not set
# CONFIG_NLS_ISO8859_5 is not set
# CONFIG_NLS_ISO8859_6 is not set
# CONFIG_NLS_ISO8859_7 is not set
# CONFIG_NLS_ISO8859_9 is not set
# CONFIG_NLS_ISO8859_13 is not set
# CONFIG_NLS_ISO8859_14 is not set
# CONFIG_NLS_ISO8859_15 is not set
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
# CONFIG_READABLE_ASM is not set
# CONFIG_UNUSED_SYMBOLS is not set
# CONFIG_PAGE_OWNER is not set
CONFIG_DEBUG_FS=3Dy
# CONFIG_HEADERS_CHECK is not set
CONFIG_DEBUG_SECTION_MISMATCH=3Dy
CONFIG_DEBUG_FORCE_WEAK_PER_CPU=3Dy
CONFIG_MAGIC_SYSRQ=3Dy
CONFIG_MAGIC_SYSRQ_DEFAULT_ENABLE=3D0x1
CONFIG_DEBUG_KERNEL=3Dy

#
# Memory Debugging
#
# CONFIG_PAGE_EXTENSION is not set
# CONFIG_DEBUG_OBJECTS is not set
# CONFIG_SLUB_DEBUG_ON is not set
# CONFIG_SLUB_STATS is not set
CONFIG_HAVE_DEBUG_KMEMLEAK=3Dy
CONFIG_DEBUG_KMEMLEAK=3Dy
CONFIG_DEBUG_KMEMLEAK_EARLY_LOG_SIZE@0
# CONFIG_DEBUG_KMEMLEAK_TEST is not set
# CONFIG_DEBUG_KMEMLEAK_DEFAULT_OFF is not set
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
# CONFIG_PANIC_ON_OOPS is not set
CONFIG_PANIC_ON_OOPS_VALUE=3D0
CONFIG_PANIC_TIMEOUT=3D0
# CONFIG_SCHED_DEBUG is not set
# CONFIG_SCHED_INFO is not set
# CONFIG_SCHEDSTATS is not set
CONFIG_SCHED_STACK_END_CHECK=3Dy
# CONFIG_DEBUG_TIMEKEEPING is not set
# CONFIG_TIMER_STATS is not set

#
# Lock Debugging (spinlocks, mutexes, etc...)
#
# CONFIG_DEBUG_RT_MUTEXES is not set
# CONFIG_DEBUG_SPINLOCK is not set
# CONFIG_DEBUG_MUTEXES is not set
# CONFIG_DEBUG_WW_MUTEX_SLOWPATH is not set
# CONFIG_DEBUG_LOCK_ALLOC is not set
# CONFIG_PROVE_LOCKING is not set
# CONFIG_LOCK_STAT is not set
CONFIG_DEBUG_ATOMIC_SLEEP=3Dy
# CONFIG_DEBUG_LOCKING_API_SELFTESTS is not set
# CONFIG_LOCK_TORTURE_TEST is not set
CONFIG_STACKTRACE=3Dy
# CONFIG_DEBUG_KOBJECT is not set
CONFIG_HAVE_DEBUG_BUGVERBOSE=3Dy
CONFIG_DEBUG_BUGVERBOSE=3Dy
CONFIG_DEBUG_LIST=3Dy
# CONFIG_DEBUG_PI_LIST is not set
# CONFIG_DEBUG_SG is not set
# CONFIG_DEBUG_NOTIFIERS is not set
# CONFIG_DEBUG_CREDENTIALS is not set

#
# RCU Debugging
#
# CONFIG_PROVE_RCU is not set
# CONFIG_SPARSE_RCU_POINTER is not set
# CONFIG_TORTURE_TEST is not set
# CONFIG_RCU_TORTURE_TEST is not set
CONFIG_RCU_CPU_STALL_TIMEOUT`
# CONFIG_RCU_TRACE is not set
# CONFIG_RCU_EQS_DEBUG is not set
CONFIG_DEBUG_BLOCK_EXT_DEVT=3Dy
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
# CONFIG_MEMTEST is not set
# CONFIG_TEST_STATIC_KEYS is not set
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
CONFIG_ENCRYPTED_KEYS=3Dy
# CONFIG_SECURITY_DMESG_RESTRICT is not set
# CONFIG_SECURITY is not set
# CONFIG_SECURITYFS is not set
CONFIG_DEFAULT_SECURITY_DAC=3Dy
CONFIG_DEFAULT_SECURITY=3D""
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
CONFIG_CRYPTO_PCOMP2=3Dy
CONFIG_CRYPTO_AKCIPHER2=3Dy
# CONFIG_CRYPTO_RSA is not set
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
# CONFIG_CRYPTO_CCM is not set
# CONFIG_CRYPTO_GCM is not set
# CONFIG_CRYPTO_CHACHA20POLY1305 is not set
CONFIG_CRYPTO_SEQIV=3Dy
# CONFIG_CRYPTO_ECHAINIV is not set

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
# CONFIG_CRYPTO_CRCT10DIF is not set
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
# CONFIG_CRYPTO_CHACHA20 is not set
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
# CONFIG_SYSTEM_TRUSTED_KEYRING is not set
# CONFIG_BINARY_PRINTF is not set

#
# Library routines
#
CONFIG_BITREVERSE=3Dy
# CONFIG_HAVE_ARCH_BITREVERSE is not set
CONFIG_GENERIC_STRNCPY_FROM_USER=3Dy
CONFIG_GENERIC_STRNLEN_USER=3Dy
CONFIG_GENERIC_NET_UTILS=3Dy
CONFIG_GENERIC_PCI_IOMAP=3Dy
CONFIG_GENERIC_IO=3Dy
# CONFIG_CRC_CCITT is not set
CONFIG_CRC16=3Dy
# CONFIG_CRC_T10DIF is not set
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
# CONFIG_RANDOM32_SELFTEST is not set
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
CONFIG_ASSOCIATIVE_ARRAY=3Dy
CONFIG_HAS_IOMEM=3Dy
CONFIG_HAS_IOPORT_MAP=3Dy
CONFIG_HAS_DMA=3Dy
CONFIG_CPU_RMAP=3Dy
CONFIG_DQL=3Dy
CONFIG_GLOB=3Dy
# CONFIG_GLOB_SELFTEST is not set
CONFIG_NLATTR=3Dy
CONFIG_ARCH_HAS_ATOMIC64_DEC_IF_POSITIVE=3Dy
# CONFIG_CORDIC is not set
# CONFIG_DDR is not set
CONFIG_OID_REGISTRY=3Dm
# CONFIG_SG_SPLIT is not set
CONFIG_ARCH_HAS_SG_CHAIN=3Dy

--=20
Meelis Roos (mroos@linux.ee)
