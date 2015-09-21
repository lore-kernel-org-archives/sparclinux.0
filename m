From: Ming Lei <tom.leiming@gmail.com>
Date: Mon, 21 Sep 2015 07:08:08 +0000
Subject: Re: blk_mq_register_disk: kobject (00000000009f2dd8): tried to init an initialized object, something
Message-Id: <CACVXFVN2fgG_rLTMby=bY+1sWzoGryKq_aCU2S0=chAX9MUvog@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <alpine.LRH.2.20.1509141548050.31198@math.ut.ee>
In-Reply-To: <alpine.LRH.2.20.1509141548050.31198@math.ut.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Meelis Roos <mroos@linux.ee>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>, sparclinux@vger.kernel.org, Akinobu Mita <akinobu.mita@gmail.com>

On Tue, Sep 15, 2015 at 3:06 AM, Meelis Roos <mroos@linux.ee> wrote:
> This is 4.3.0-rc1 on Sun E220R (dual-CPU sparc64). Sometimes it boots,
> sometimes it fails to boot with looping errors and finally a watchdog
> timeout. This console log from a failure. Config is below.
>
> [    0.000000] PROMLIB: Sun IEEE Boot Prom 'OBP 3.31.0 2001/07/25 20:31'
> [    0.000000] PROMLIB: Root node compatible:
> [    0.000000] Linux version 4.3.0-rc1 (mroos@e220r) (gcc version 4.9.2 (Debian 4.9.2-20) ) #65 SMP Sun Sep 13 19:53:46 EEST 2015
> [    0.000000] debug: ignoring loglevel setting.
> [    0.000000] bootconsole [earlyprom0] enabled
> [    0.000000] ARCH: SUN4U
> [    0.000000] Ethernet address: 08:00:20:c7:a3:81
> [    0.000000] MM: PAGE_OFFSET is 0xfffff80000000000 (max_phys_bits = 40)
> [    0.000000] MM: VMALLOC [0x0000000100000000 --> 0x0000060000000000]
> [    0.000000] MM: VMEMMAP [0x0000060000000000 --> 0x00000c0000000000]
> [    0.000000] Kernel: Using 2 locked TLB entries for main kernel image.
> [    0.000000] Remapping the kernel... done.
> [    0.000000] kmemleak: Kernel memory leak detector disabled
> [    0.000000] OF stdout device is: /pci@1f,4000/ebus@1/se@14,400000:a
> [    0.000000] PROM: Built device tree with 91663 bytes of memory.
> [    0.000000] Top of RAM: 0xaff18000, Total RAM: 0x3ff06000
> [    0.000000] Memory hole size: 1792MB
> [    0.000000] Allocated 16384 bytes for kernel page tables.
> [    0.000000] Zone ranges:
> [    0.000000]   Normal   [mem 0x0000000000000000-0x00000000aff17fff]
> [    0.000000] Movable zone start for each node
> [    0.000000] Early memory node ranges
> [    0.000000]   node   0: [mem 0x0000000000000000-0x000000000fffffff]
> [    0.000000]   node   0: [mem 0x0000000020000000-0x000000002fffffff]
> [    0.000000]   node   0: [mem 0x0000000080000000-0x000000008fffffff]
> [    0.000000]   node   0: [mem 0x00000000a0000000-0x00000000afeedfff]
> [    0.000000]   node   0: [mem 0x00000000aff00000-0x00000000aff17fff]
> [    0.000000] Initmem setup node 0 [mem 0x0000000000000000-0x00000000aff17fff]
> [    0.000000] On node 0 totalpages: 130947
> [    0.000000]   Normal zone: 1024 pages used for memmap
> [    0.000000]   Normal zone: 0 pages reserved
> [    0.000000]   Normal zone: 130947 pages, LIFO batch:15
> [    0.000000] Booting Linux...
> [    0.000000] CPU CAPS: [flush,stbar,swap,muldiv,v9,mul32,div32,v8plus]
> [    0.000000] CPU CAPS: [vis]
> [    0.000000] PERCPU: Embedded 8 pages/cpu @fffff800af800000 s22976 r8192 d34368 u2097152
> [    0.000000] pcpu-alloc: s22976 r8192 d34368 u2097152 alloc=1*4194304
> [    0.000000] pcpu-alloc: [0] 0 2
> [    0.000000] Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 129923
> [    0.000000] Kernel command line: root=/dev/sda2 ro ignore_loglevel
> [    0.000000] PID hash table entries: 4096 (order: 2, 32768 bytes)
> [    0.000000] Dentry cache hash table entries: 131072 (order: 7, 1048576 bytes)
> [    0.000000] Inode-cache hash table entries: 65536 (order: 6, 524288 bytes)
> [    0.000000] Sorting __ex_table...
> [    0.000000] Memory: 1022624K/1047576K available (4205K kernel code, 251K rwdata, 1288K rodata, 264K init, 418K bss, 24952K reserved, 0K cma-reserved)
> [    0.000000] SLUB: HWalign2, Order=0-3, MinObjects=0, CPUs=3, Nodes=1
> [    0.000000] Hierarchical RCU implementation.
> [    0.000000]  Build-time adjustment of leaf fanout to 64.
> [    0.000000]  RCU restricting CPUs from NR_CPUS=4 to nr_cpu_ids=3.
> [    0.000000] RCU: Adjusting geometry for rcu_fanout_leafd, nr_cpu_ids=3
> [    0.000000] NR_IRQS:2048 nr_irqs:2048 1
> [   79.762547] clocksource: tick: mask: 0xffffffffffffffff max_cycles: 0x530919c4ff, max_idle_ns: 440795210743 ns
> [   79.882019] clocksource: mult[2c709c3] shift[24]
> [   79.937217] clockevent: mult[5c2b61ba] shift[32]
> [   79.992661] Console: colour dummy device 80x25
> [   80.045592] console [tty0] enabled
> [   80.086169] bootconsole [earlyprom0] disabled
> [    0.000000] PROMLIB: Sun IEEE Boot Prom 'OBP 3.31.0 2001/07/25 20:31'
> [    0.000000] PROMLIB: Root node compatible:
> [    0.000000] Linux version 4.3.0-rc1 (mroos@e220r) (gcc version 4.9.2 (Debian 4.9.2-20) ) #65 SMP Sun Sep 13 19:53:46 EEST 2015
> [    0.000000] debug: ignoring loglevel setting.
> [    0.000000] bootconsole [earlyprom0] enabled
> [    0.000000] ARCH: SUN4U
> [    0.000000] Ethernet address: 08:00:20:c7:a3:81
> [    0.000000] MM: PAGE_OFFSET is 0xfffff80000000000 (max_phys_bits = 40)
> [    0.000000] MM: VMALLOC [0x0000000100000000 --> 0x0000060000000000]
> [    0.000000] MM: VMEMMAP [0x0000060000000000 --> 0x00000c0000000000]
> [    0.000000] Kernel: Using 2 locked TLB entries for main kernel image.
> [    0.000000] Remapping the kernel... done.
> [    0.000000] kmemleak: Kernel memory leak detector disabled
> [    0.000000] OF stdout device is: /pci@1f,4000/ebus@1/se@14,400000:a
> [    0.000000] PROM: Built device tree with 91663 bytes of memory.
> [    0.000000] Top of RAM: 0xaff18000, Total RAM: 0x3ff06000
> [    0.000000] Memory hole size: 1792MB
> [    0.000000] Allocated 16384 bytes for kernel page tables.
> [    0.000000] Zone ranges:
> [    0.000000]   Normal   [mem 0x0000000000000000-0x00000000aff17fff]
> [    0.000000] Movable zone start for each node
> [    0.000000] Early memory node ranges
> [    0.000000]   node   0: [mem 0x0000000000000000-0x000000000fffffff]
> [    0.000000]   node   0: [mem 0x0000000020000000-0x000000002fffffff]
> [    0.000000]   node   0: [mem 0x0000000080000000-0x000000008fffffff]
> [    0.000000]   node   0: [mem 0x00000000a0000000-0x00000000afeedfff]
> [    0.000000]   node   0: [mem 0x00000000aff00000-0x00000000aff17fff]
> [    0.000000] Initmem setup node 0 [mem 0x0000000000000000-0x00000000aff17fff]
> [    0.000000] On node 0 totalpages: 130947
> [    0.000000]   Normal zone: 1024 pages used for memmap
> [    0.000000]   Normal zone: 0 pages reserved
> [    0.000000]   Normal zone: 130947 pages, LIFO batch:15
> [    0.000000] Booting Linux...
> [    0.000000] CPU CAPS: [flush,stbar,swap,muldiv,v9,mul32,div32,v8plus]
> [    0.000000] CPU CAPS: [vis]
> [    0.000000] PERCPU: Embedded 8 pages/cpu @fffff800af800000 s22976 r8192 d34368 u2097152
> [    0.000000] pcpu-alloc: s22976 r8192 d34368 u2097152 alloc=1*4194304
> [    0.000000] pcpu-alloc: [0] 0 2
> [    0.000000] Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 129923
> [    0.000000] Kernel command line: root=/dev/sda2 ro ignore_loglevel
> [    0.000000] PID hash table entries: 4096 (order: 2, 32768 bytes)
> [    0.000000] Dentry cache hash table entries: 131072 (order: 7, 1048576 bytes)
> [    0.000000] Inode-cache hash table entries: 65536 (order: 6, 524288 bytes)
> [    0.000000] Sorting __ex_table...
> [    0.000000] Memory: 1022624K/1047576K available (4205K kernel code, 251K rwdata, 1288K rodata, 264K init, 418K bss, 24952K reserved, 0K cma-reserved)
> [    0.000000] SLUB: HWalign2, Order=0-3, MinObjects=0, CPUs=3, Nodes=1
> [    0.000000] Hierarchical RCU implementation.
> [    0.000000]  Build-time adjustment of leaf fanout to 64.
> [    0.000000]  RCU restricting CPUs from NR_CPUS=4 to nr_cpu_ids=3.
> [    0.000000] RCU: Adjusting geometry for rcu_fanout_leafd, nr_cpu_ids=3
> [    0.000000] NR_IRQS:2048 nr_irqs:2048 1
> [   79.762547] clocksource: tick: mask: 0xffffffffffffffff max_cycles: 0x530919c4ff, max_idle_ns: 440795210743 ns
> [   79.882019] clocksource: mult[2c709c3] shift[24]
> [   79.937217] clockevent: mult[5c2b61ba] shift[32]
> [   79.992661] Console: colour dummy device 80x25
> [   80.045592] console [tty0] enabled
> [   80.086169] bootconsole [earlyprom0] disabled
> [   80.138273] kmemleak: Early log buffer exceeded (1388), please increase DEBUG_KMEMLEAK_EARLY_LOG_SIZE
> [   80.288367] Calibrating delay using timer specific routine.. 721.49 BogoMIPS (lpj607494)
> [   80.288417] pid_max: default: 32768 minimum: 301
> [   80.288715] Mount-cache hash table entries: 2048 (order: 1, 16384 bytes)
> [   80.288757] Mountpoint-cache hash table entries: 2048 (order: 1, 16384 bytes)
> [   80.321521] CPU 2: synchronized TICK with master CPU (last diff 1 cycles, maxerr 436 cycles)
> [   80.321626] Brought up 2 CPUs
> [   80.322828] devtmpfs: initialized
> [   80.330830] Performance events: No support for PMU type 'ultra12'
> [   80.389162] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 19112604462750000 ns
> [   80.389882] kworker/u4:0 (19) used greatest stack depth: 11240 bytes left
> [   80.390755] NET: Registered protocol family 16
> [   80.393783] kworker/u4:1 (29) used greatest stack depth: 11152 bytes left
> [   80.394492] kworker/u4:1 (31) used greatest stack depth: 10560 bytes left
> [   80.397912] kworker/u4:1 (25) used greatest stack depth: 10024 bytes left
> [   80.402205] kworker/u4:0 (61) used greatest stack depth: 9496 bytes left
> [   80.413455] /pci@1f,4000: PCI IO[1fe02010000] MEM[1ff80000000]
> [   80.413523] /pci@1f,4000: PSYCHO PCI Bus Module ver[4:0]
> [   80.413554] PCI: Scanning PBM /pci@1f,4000
> [   80.414043] psycho f005fd74: PCI host bridge to bus 0000:00
> [   80.414121] pci_bus 0000:00: root bus resource [io  0x1fe02010000-0x1fe0201ffff] (bus address [0x0000-0xffff])
> [   80.414215] pci_bus 0000:00: root bus resource [mem 0x1ff80000000-0x1ffffffffff] (bus address [0x00000000-0x7fffffff])
> [   80.414302] pci_bus 0000:00: root bus resource [bus 00]
> [   80.419316] /pci@1f,2000: PCI IO[1fe02000000] MEM[1ff00000000]
> [   80.419381] /pci@1f,2000: PSYCHO PCI Bus Module ver[4:0]
> [   80.419428] PCI: Scanning PBM /pci@1f,2000
> [   80.419830] psycho f00605f0: PCI host bridge to bus 0001:80
> [   80.419897] pci_bus 0001:80: root bus resource [io  0x1fe02000000-0x1fe0200ffff] (bus address [0x0000-0xffff])
> [   80.419987] pci_bus 0001:80: root bus resource [mem 0x1ff00000000-0x1ff7fffffff] (bus address [0x00000000-0x7fffffff])
> [   80.420074] pci_bus 0001:80: root bus resource [bus 80]
> [   80.472184] vgaarb: loaded
> [   80.472936] SCSI subsystem initialized
> [   80.475262] /pci@1f,4000/ebus@1/eeprom@14,0: Mostek regs at 0x1fff1000000
> [   80.476265] AUXIO: Found device at /pci@1f,4000/ebus@1/auxio@14,726000
> [   80.476710] clocksource: Switched to clocksource tick
> [   80.497990] NET: Registered protocol family 2
> [   80.499341] TCP established hash table entries: 8192 (order: 3, 65536 bytes)
> [   80.499751] TCP bind hash table entries: 8192 (order: 4, 131072 bytes)
> [   80.500314] TCP: Hash tables configured (established 8192 bind 8192)
> [   80.500582] UDP hash table entries: 512 (order: 1, 16384 bytes)
> [   80.500718] UDP-Lite hash table entries: 512 (order: 1, 16384 bytes)
> [   80.501213] NET: Registered protocol family 1
> [   80.501475] PCI: CLS 0 bytes, default 64
> [   80.501770] power: Control reg at 1fff1724000
> [   80.504616] futex hash table entries: 512 (order: 2, 32768 bytes)
> [   80.506048] HugeTLB registered 8 MB page size, pre-allocated 0 pages
> [   80.547180] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 252)
> [   80.547278] io scheduler noop registered
> [   80.547742] io scheduler cfq registered (default)
> [   80.548661] f0061cc8: ttyS0 at MMIO 0x1fff1400000 (irq = 7, base_baud = 115200) is a SAB82532 V3.2
> [   80.548744] Console: ttyS0 (SAB82532)
> [   88.093713] console [ttyS0] enabled
> [   88.136211] f0061cc8: ttyS1 at MMIO 0x1fff1400040 (irq = 7, base_baud = 115200) is a SAB82532 V3.2
> [   88.244224] PCI: Enabling device: (0000:00:03.0), cmd 147
> [   88.309290] sym0: <875> rev 0x14 at pci 0000:00:03.0 irq 13
> [   88.462196] sym0: No NVRAM, ID 7, Fast-20, SE, parity checking
> [   88.538525] sym0: SCSI BUS has been reset.
> [   88.586601] scsi host0: sym-2.2.3
> [   88.631377] PCI: Enabling device: (0000:00:03.1), cmd 3
> [   88.694261] sym1: <875> rev 0x14 at pci 0000:00:03.1 irq 14
> [   88.847050] sym1: No NVRAM, ID 7, Fast-20, SE, parity checking
> [   88.923332] sym1: SCSI BUS has been reset.
> [   88.971439] scsi host1: sym-2.2.3
> [   89.015677] PCI: Enabling device: (0000:00:02.0), cmd 3
> [   89.078557] sym2: <875> rev 0x14 at pci 0000:00:02.0 irq 15
> [   89.231432] sym2: No NVRAM, ID 7, Fast-20, SE, parity checking
> [   89.307660] sym2: SCSI BUS has been reset.
> [   89.355758] scsi host2: sym-2.2.3
> [   89.400043] PCI: Enabling device: (0000:00:02.1), cmd 3
> [   89.462970] sym3: <875> rev 0x14 at pci 0000:00:02.1 irq 16
> [   89.615754] sym3: No NVRAM, ID 7, Fast-20, SE, parity checking
> [   89.692048] sym3: SCSI BUS has been reset.
> [   89.740055] scsi host3: sym-2.2.3
> [   89.784488] PCI: Enabling device: (0000:00:04.0), cmd 3
> [   89.847401] sym4: <875> rev 0x14 at pci 0000:00:04.0 irq 17
> [   90.000181] sym4: No NVRAM, ID 7, Fast-20, SE, parity checking
> [   90.076457] sym4: SCSI BUS has been reset.
> [   90.124493] scsi host4: sym-2.2.3
> [   90.168974] PCI: Enabling device: (0000:00:04.1), cmd 3
> [   90.231923] sym5: <875> rev 0x14 at pci 0000:00:04.1 irq 18
> [   90.384712] sym5: No NVRAM, ID 7, Fast-20, SE, parity checking
> [   90.460995] sym5: SCSI BUS has been reset.
> [   90.509005] scsi host5: sym-2.2.3
> [   90.554226] mousedev: PS/2 mouse device common for all mice
> [   90.621711] rtc-m48t59 rtc-m48t59.0: rtc core: registered m48t59 as rtc0
> [   90.703866] NET: Registered protocol family 10
> [   90.758423] NET: Registered protocol family 17
> [   90.810727] Key type dns_resolver registered
> [   90.866003] Key type encrypted registered
> [   90.914069] console [netcon0] enabled
> [   90.956986] netconsole: network logging started
> [   91.011243] rtc-m48t59 rtc-m48t59.0: setting system clock to 2015-09-14 12:31:56 UTC (1442233916)?   91.636785] scsi 0:0:0:0: Direct-Access     QUANTUM  ATLAS10K3_36_SCA 020W PQ: 0 ANSI: 3
> [   91.732863] scsi target0:0:0: tagged command queuing enabled, command queue depth 16.
> [   91.826592] scsi target0:0:0: Beginning Domain Validation
> [   91.894554] scsi target0:0:0: FAST-20 WIDE SCSI 40.0 MB/s ST (50 ns, offset 16)
> [   91.983049] scsi target0:0:0: Domain Validation skipping write tests
> [   92.058187] scsi target0:0:0: Ending Domain Validation
> [   93.590588] scsi 0:0:6:0: CD-ROM            TOSHIBA  XM6201TASUN32XCD 1103 PQ: 0 ANSI: 2
> [   93.686649] scsi target0:0:6: Beginning Domain Validation
> [   93.753328] scsi target0:0:6: FAST-10 SCSI 10.0 MB/s ST (100 ns, offset 16)
> [   93.836962] scsi target0:0:6: Domain Validation skipping write tests
> [   93.912162] scsi target0:0:6: Ending Domain Validation
> [   96.317514] sd 0:0:0:0: [sda] 71833096 512-byte logical blocks: (36.7 GB/34.2 GiB)
> [   96.408799] sd 0:0:0:0: [sda] Write Protect is off
> [   96.465258] sd 0:0:0:0: [sda] Mode Sense: e5 00 10 08
> [   96.527504] sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, supports DPO and FUA
> [   96.641946]  sda: sda1 sda2 sda3 sda4
> [   96.688204] kworker/u4:0 (570) used greatest stack depth: 9104 bytes left
> [   96.709472] sd 0:0:0:0: [sda] Attached SCSI disk
> [   98.020598] EXT4-fs (sda2): couldn't mount as ext3 due to feature incompatibilities
> [   98.112011] EXT4-fs (sda2): couldn't mount as ext2 due to feature incompatibilities
> [   98.227702] EXT4-fs (sda2): mounted filesystem with ordered data mode. Opts: (null)
> [   98.318525] VFS: Mounted root (ext4 filesystem) readonly on device 259:262144.
> [   98.436651] devtmpfs: mounted
> Mount failed for selinuxfs on /sys/fs/selinux:  No such file or directory
> g??????ɹ?????ѥ???H?   99.248602] stty (586) used greatest stack depth: 8216 bytes left
> [   99.484619] tput (590) used greatest stack depth: 8088 bytes left
> [info] Using makefile-style concurrent boot in runlevel S.
> [  100.116965] ps (660) used greatest stack depth: 7728 bytes left
> unparseable line (c! /dev/autofs 0600 - - - 10:235)
> unparseable line (c! /dev/fuse 0600 - - - 10:229)
> unparseable line (c! /dev/cuse 0600 - - - 10:203)
> unparse[  100.356492] random: udevd urandom read with 18 bits of entropy available
> able line (c! /dev/loop-control 0600 - - - 10:237)
> unparseable line (c! /dev/net/tun 0600 - - - 10:200)
> unparseable line (c! /dev/uhid 0600 - - - 10:239)
> [....] Starting the hotplug events dispatcher: udevdstarting version 218
> [ ok .
> [....] Synthesizing the initial hotplug events...[ ok done.
> [  101.056708] hwclock (716) used greatest stack depth: 7608 bytes left
> [....] Waiting f[  101.148930] sd 0:0:0:0: Attached scsi generic sg0 type 0
> [  101.212727] scsi 0:0:6:0: Attached scsi generic sg1 type 5
> or [  101.281691] PCI: Enabling device: (0000:00:01.1), cmd 2
> [  101.289700] sr 0:0:6:0: [sr0] scsi-1 drive
> [  101.289710] cdrom: Uniform CD-ROM driver Revision: 3.20
> [  101.348345] sr 0:0:6:0: Attached scsi CD-ROM sr0
> [  101.393029] cdrom_id (726) used greatest stack depth: 7456 bytes left
> [  101.587083] sunhme.c:v3.10 August 26, 2008 David S. Miller (davem@davemloft.net)
> /d[  101.678086] eth0: HAPPY MEAL (PCI/CheerIO) 10/100BaseT Ethernet 08:00:20:c7:a3:81
> ev to be fully populated...[ ok done.
> [....] Setting preliminary keymap...[ ok done.
> [....] Activating swap...[  104.354886] Adding 1582392k swap on /dev/sda4.  Priority:-1 extents:1 across:1582392k
> [ ok done.
> [  104.582832] EXT4-fs (sda2): re-mounted. Opts: (null)
> [....] Checking root file system...fsck from util-linux 2.26.2
> /dev/sda2: clean, 134168/2142112 files, 1452575/8558628 blocks
> [ ok   104.917474] EXT4-fs (sda2): re-mounted. Opts: errors=remount-ro
> 25hdone.
> [....] Activating lvm and md swap...[ ok done.
> [....] Checking file systems...fsck from util-linux 2.26.2
> /dev/sda1: clean, 40/48192 files, 43342/96390 blocks
> [ ok done.
> [....] Cleaning up temporary files... /tmp[ ok .
> [  106.370834] kobject (00000000009f2dd8): tried to init an initialized object, something is seriously wrong.

Akinobu found there is one race between CPU hotplug and add_disk, maybe
you can try the patch in the following link to see if it can fix your issue.

                 https://lkml.org/lkml/2015/7/18/99

-- 
Ming Lei
