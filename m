From: Meelis Roos <mroos@linux.ee>
Date: Fri, 16 Jan 2009 10:58:32 +0000
Subject: Unknown CPU in 2.6.29-rc1
Message-Id: <Pine.SOC.4.64.0901161249030.2120@math.ut.ee>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

After Sam's insw/... fix, todays 2.6.29-rc1+git boots up and seems fo 
work on E3500 with 2 USII-400's. However, the CPU has suddenly became 
unknown (it was known in 2.6.27):

[  136.434591] CPU: Unknown chip, impl[0x17] vers[0x11]
[  136.434649] FPU: Unknown chip, impl[0x17] vers[0x11]
[  136.436067] fhc: Board #1, Version[1] PartID[fa0] Manuf[3e] (Central)
[  136.436823] fhc: Board #3, Version[1] PartID[fa0] Manuf[3e] (JTAG Master)

Btw, these fhc messages appear later in boot process than before. 
Before the boards were detected just after 'Booting Linux':
Booting Linux...
CENTRAL: Detected 5 slot Enterprise system. cfreg[68] cver[78]
FHC(board 1): Version[1] PartID[fa0] Manuf[3e] (CENTRAL)
FHC(board 3): Version[1] PartID[fa0] Manuf[3e] (JTAG Master)
FHC(board 1): Version[1] PartID[fa0] Manuf[3e]
FHC(board 7): Version[1] PartID[fa0] Manuf[3e]

Now they are after 'Brought up 2 CPUs' together with unknown CPU 
messages.

/proc/cpuinfo tells

cpu             : Unknown CPU
fpu             : Unknown FPU
prom            : OBP 3.2.30 2002/10/25 14:03
type            : sun4u
ncpus probed    : 2
ncpus active    : 2
D$ parity tl1   : 0
I$ parity tl1   : 0
Cpu6ClkTck      : 0000000017d78400
Cpu7ClkTck      : 0000000017d78400
MMU Type        : Spitfire
State:
CPU6:           online
CPU7:           online

Full dmesg if it is interesting (ignore LED warnings, I will make sa 
separate post about them):

[    0.000000] PROMLIB: Sun IEEE Boot Prom 'OBP 3.2.30 2002/10/25 14:03'
[    0.000000] PROMLIB: Root node compatible: 
[    0.000000] Linux version 2.6.29-rc1 (mroos@korvits) (gcc version 4.3.3 20090110 (prerelease) (Debian 4.3.2-2) ) #2 SMP Fri Jan 16 09:27:48 EET 2009
[    0.000000] console [earlyprom0] enabled
[    0.000000] ARCH: SUN4U
[    0.000000] Ethernet address: 08:00:20:b6:ee:e2
[    0.000000] Kernel: Using 3 locked TLB entries for main kernel image.
[    0.000000] Remapping the kernel... done.
[    0.000000] OF stdout device is: /central@1f,0/fhc@0,f8800000/zs@0,902000:a
[    0.000000] PROM: Built device tree with 76108 bytes of memory.
[    0.000000] Top of RAM: 0x4fd00000, Total RAM: 0x4f8dc000
[    0.000000] Memory hole size: 4MB
[    0.000000] [0000000200000000-fffff80001000000] page_structs1072 node=0 entry=0/0
[    0.000000] [0000000200000000-fffff80001400000] page_structs1072 node=0 entry=1/0
[    0.000000] [0000000200000000-fffff80001800000] page_structs1072 node=0 entry=2/0
[    0.000000] [0000000200c00000-fffff80001c00000] page_structs1072 node=0 entry=3/0
[    0.000000] [0000000200c00000-fffff80002000000] page_structs1072 node=0 entry=4/0
[    0.000000] [0000000200c00000-fffff80002400000] page_structs1072 node=0 entry=5/0
[    0.000000] Zone PFN ranges:
[    0.000000]   Normal   0x00000000 -> 0x00027e80
[    0.000000] Movable zone start PFN for each node
[    0.000000] early_node_map[3] active PFN ranges
[    0.000000]     0: 0x00000000 -> 0x00027bef
[    0.000000]     0: 0x00027e00 -> 0x00027e75
[    0.000000]     0: 0x00027e76 -> 0x00027e80
[    0.000000] On node 0 totalpages: 162926
[    0.000000]   Normal zone: 1916 pages used for memmap
[    0.000000]   Normal zone: 0 pages reserved
[    0.000000]   Normal zone: 161010 pages, LIFO batch:15
[    0.000000] Booting Linux...
[    0.000000] Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 161010
[    0.000000] Kernel command line: root=/dev/sda2 ro
[    0.000000] RCU-based detection of stalled CPUs is enabled.
[    0.000000] PID hash table entries: 4096 (order: 12, 32768 bytes)
[    0.000000] clocksource: mult[28000] shift[16]
[    0.000000] clockevent: mult[66666666] shift[32]
[  135.989521] Console: colour dummy device 80x25
[  136.042600] console handover: boot [earlyprom0] -> real [tty0]
[  136.112343] Lock dependency validator: Copyright (c) 2006 Red Hat, Inc., Ingo Molnar
[  136.112405] ... MAX_LOCKDEP_SUBCLASSES:  8
[  136.112437] ... MAX_LOCK_DEPTH:          48
[  136.112472] ... MAX_LOCKDEP_KEYS:        8191
[  136.112507] ... CLASSHASH_SIZE:          4096
[  136.112542] ... MAX_LOCKDEP_ENTRIES:     8192
[  136.112576] ... MAX_LOCKDEP_CHAINS:      16384
[  136.112611] ... CHAINHASH_SIZE:          8192
[  136.112645]  memory used by lock dependency info: 3839 kB
[  136.112684]  per task-struct memory footprint: 1920 bytes
[  136.124055] Dentry cache hash table entries: 262144 (order: 8, 2097152 bytes)
[  136.133073] Inode-cache hash table entries: 131072 (order: 7, 1048576 bytes)
[  136.216613] Memory: 1263584k available (2904k kernel code, 1216k data, 152k init) [fffff80000000000,000000004fd00000]
[  136.217034] SLUB: Genslabs, HWalign2, Order=0-3, MinObjects=0, CPUs=8, Nodes=1
[  136.362782] Calibrating delay using timer specific routine.. 803.15 BogoMIPS (lpj@15786)
[  136.363332] Mount-cache hash table entries: 512
[  136.375515] CPU 7: synchronized TICK with master CPU (last diff -3 cycles, maxerr 679 cycles)
[  136.375570] Brought up 2 CPUs
[  136.379393] net_namespace: 2040 bytes
[  136.380537] NET: Registered protocol family 16
[  136.434591] CPU: Unknown chip, impl[0x17] vers[0x11]
[  136.434649] FPU: Unknown chip, impl[0x17] vers[0x11]
[  136.436067] fhc: Board #1, Version[1] PartID[fa0] Manuf[3e] (Central)
[  136.436823] fhc: Board #3, Version[1] PartID[fa0] Manuf[3e] (JTAG Master)
[  136.437107] ------------[ cut here ]------------
[  136.437166] WARNING: at fs/sysfs/dir.c:462 sysfs_add_one+0x44/0x60()
[  136.437226] sysfs: duplicate filename 'sunfire-fhc-leds.0' can not be created
[  136.437288] Modules linked in:
[  136.437343] Call Trace:
[  136.437407]  [000000000045c8cc] warn_slowpath+0x6c/0xc0
[  136.437467]  [0000000000541a04] sysfs_add_one+0x44/0x60
[  136.437530]  [0000000000542d4c] sysfs_do_create_link+0x12c/0x1a0
[  136.437595]  [0000000000542e1c] sysfs_create_link+0x1c/0x40
[  136.437660]  [00000000005ed544] bus_add_device+0xe4/0x180
[  136.437735]  [00000000005eb8e0] device_add+0x300/0x540
[  136.437800]  [00000000005efb30] platform_device_add+0xd0/0x1e0
[  136.437865]  [00000000005efc58] platform_device_register+0x18/0x40
[  136.437941]  [00000000006c5744] fhc_probe+0xf8/0x264
[  136.438016]  [0000000000627170] of_platform_device_probe+0x50/0xe0
[  136.438082]  [00000000005ee23c] driver_probe_device+0x9c/0x1c0
[  136.438145]  [00000000005ee3e4] __driver_attach+0x84/0xa0
[  136.438205]  [00000000005ed998] bus_for_each_dev+0x58/0xa0
[  136.438267]  [00000000005ee080] driver_attach+0x20/0x40
[  136.438326]  [00000000005ed16c] bus_add_driver+0xac/0x240
[  136.438387]  [00000000005ee648] driver_register+0x68/0x160
[  136.438604] ---[ end trace 139ce121c98e96c9 ]---
[  136.439011] fhc: Could not register LEDS platform device
[  136.439104] fhc: probe of f0071c1c failed with error -17
[  136.439296] ------------[ cut here ]------------
[  136.439351] WARNING: at fs/sysfs/dir.c:462 sysfs_add_one+0x44/0x60()
[  136.439413] sysfs: duplicate filename 'sunfire-fhc-leds.0' can not be created
[  136.439474] Modules linked in:
[  136.439525] Call Trace:
[  136.439576]  [000000000045c8cc] warn_slowpath+0x6c/0xc0
[  136.439636]  [0000000000541a04] sysfs_add_one+0x44/0x60
[  136.439696]  [0000000000542d4c] sysfs_do_create_link+0x12c/0x1a0
[  136.439761]  [0000000000542e1c] sysfs_create_link+0x1c/0x40
[  136.439822]  [00000000005ed544] bus_add_device+0xe4/0x180
[  136.439888]  [00000000005eb8e0] device_add+0x300/0x540
[  136.439949]  [00000000005efb30] platform_device_add+0xd0/0x1e0
[  136.440015]  [00000000005efc58] platform_device_register+0x18/0x40
[  136.440082]  [00000000006c5744] fhc_probe+0xf8/0x264
[  136.440147]  [0000000000627170] of_platform_device_probe+0x50/0xe0
[  136.440212]  [00000000005ee23c] driver_probe_device+0x9c/0x1c0
[  136.440276]  [00000000005ee3e4] __driver_attach+0x84/0xa0
[  136.440337]  [00000000005ed998] bus_for_each_dev+0x58/0xa0
[  136.440398]  [00000000005ee080] driver_attach+0x20/0x40
[  136.440458]  [00000000005ed16c] bus_add_driver+0xac/0x240
[  136.440520]  [00000000005ee648] driver_register+0x68/0x160
[  136.440576] ---[ end trace 139ce121c98e96ca ]---
[  136.440982] fhc: Could not register LEDS platform device
[  136.441070] fhc: probe of f01c923c failed with error -17
[  136.441926] clock_board: Detected 5 slot Enterprise system.
[  136.442455] SYSIO: UPA portID ffffffff, at 000001c400000000
[  136.450298] SYSIO: UPA portID ffffffff, at 000001c600000000
[  136.466018] /pci@e,4000: PCI IO[1dc02010000] MEM[1dd80000000]
[  136.466101] /pci@e,4000: PSYCHO PCI Bus Module ver[4:0]
[  136.466163] PCI: Scanning PBM /pci@e,4000
[  136.468465] /pci@e,2000: PCI IO[1dc02000000] MEM[1dd00000000]
[  136.468538] /pci@e,2000: PSYCHO PCI Bus Module ver[4:0]
[  136.468597] PCI: Scanning PBM /pci@e,2000
[  136.477142] /pci@f,4000: PCI IO[1de02010000] MEM[1df80000000]
[  136.477216] /pci@f,4000: PSYCHO PCI Bus Module ver[4:0]
[  136.477274] PCI: Scanning PBM /pci@f,4000
[  136.478834] /pci@f,2000: PCI IO[1de02000000] MEM[1df00000000]
[  136.478908] /pci@f,2000: PSYCHO PCI Bus Module ver[4:0]
[  136.478969] PCI: Scanning PBM /pci@f,2000
[  136.498282] bio: create slab <bio-0> at 0
[  136.501834] SCSI subsystem initialized
[  136.545185] /central/fhc@0,f8800000/eeprom@0,908000: Mostek regs at 0x1fff8908000
[  136.552566] NET: Registered protocol family 2
[  136.553265] Switched to high resolution mode on CPU 6
[  136.555019] Switched to high resolution mode on CPU 7
[  136.668472] IP route cache hash table entries: 65536 (order: 6, 524288 bytes)
[  136.671107] TCP established hash table entries: 262144 (order: 9, 4194304 bytes)
[  136.691633] TCP bind hash table entries: 65536 (order: 8, 3670016 bytes)
[  136.709236] TCP: Hash tables configured (established 262144 bind 65536)
[  136.709310] TCP reno registered
[  136.738880] NET: Registered protocol family 1
[  136.756206] HugeTLB registered 4 MB page size, pre-allocated 0 pages
[  136.803744] msgmni has been set to 2469
[  136.805496] alg: No test for stdrng (krng)
[  136.806754] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 253)
[  136.806852] io scheduler noop registered
[  136.806906] io scheduler anticipatory registered
[  136.806962] io scheduler deadline registered
[  136.807753] io scheduler cfq registered (default)
[  137.047594] f005de3c: ttyS0 at MMIO 0x1fff8902000 (irq = 2) is a zs (ESCC)
[  137.047667] Console: ttyS0 (SunZilog zs0)
[  137.048016] console [ttyS0] enabled
[  146.208877] f005de3c: ttyS1 at MMIO 0x1fff8902004 (irq = 2) is a zs (ESCC)
[  146.499332] f005df14: Keyboard at MMIO 0x1fff8904000 (irq = 2) is a zs
[  146.575458] f005df14: Mouse at MMIO 0x1fff8904004 (irq = 2) is a zs
[  146.653376] sunhme.c:v3.10 August 26, 2008 David S. Miller (davem@davemloft.net)
[  146.741786] eth0: HAPPY MEAL (SBUS) 10/100baseT Ethernet 08:00:20:b6:ee:e2
[  146.822251] happymeal: Cannot map MAC TX registers.
[  146.881086] PCI: Enabling device: (0000:00:01.1), cmd 2
[  146.882967] eth1: HAPPY MEAL (PCI/CheerIO) 10/100BaseT Ethernet 08:00:20:b6:ee:e2
[  146.971774] qla1280: QLA1040 found on PCI bus 0, dev 3
[  147.032027] PCI: Enabling device: (0002:00:03.0), cmd 7
[  147.889586] scsi(0:0): Resetting SCSI BUS
[  150.943346] scsi0 : QLogic QLA1040 PCI to SCSI Host Adapter
[  150.943358]        Firmware version:  7.65.06, Driver version 3.26
[  151.419618] scsi 0:0:2:0: Direct-Access     IBM      DDYS-T18350M     S96H PQ: 0 ANSI: 3
[  151.515211] scsi(0:0:2:0): Sync: period 10, offset 12, Wide, Tagged queuing: depth 31
[  151.612692] scsi 0:0:3:0: Direct-Access     IBM      DDYS-T18350M     S93E PQ: 0 ANSI: 3
[  151.708438] scsi(0:0:3:0): Sync: period 10, offset 12, Wide, Tagged queuing: depth 31
[  151.812335] scsi 0:0:4:0: Direct-Access     HP       9.10GB A 80-6331      PQ: 0 ANSI: 2
[  151.907947] scsi(0:0:4:0): Sync: period 10, offset 12, Wide, Tagged queuing: depth 31
[  152.010300] scsi 0:0:5:0: Direct-Access     IBM      DDRS-34560D      DC1B PQ: 0 ANSI: 2
[  152.105953] scsi(0:0:5:0): Sync: period 10, offset 12, Wide, Tagged queuing: depth 31
[  152.384508] scsi 0:0:8:0: Direct-Access     HP       4.26GB A 80-0430 0430 PQ: 0 ANSI: 2
[  152.480049] scsi(0:0:8:0): Sync: period 10, offset 12, Wide, Tagged queuing: depth 31
[  152.594909] scsi 0:0:9:0: Direct-Access     HP       2.13GB A 80-0430 0430 PQ: 0 ANSI: 2
[  152.690550] scsi(0:0:9:0): Sync: period 10, offset 12, Wide, Tagged queuing: depth 31
[  153.797760] esp: esp0, regs[1c738810000:1c738800000] irq[20]
[  153.863482] esp: esp0 is a FASHME, 40 MHz (ccf=0), SCSI ID 7
[  156.933335] scsi1 : esp
[  158.371558] scsi 1:0:6:0: CD-ROM            TOSHIBA  XM6201TASUN32XCD 1103 PQ: 0 ANSI: 2
[  158.466558] scsi target1:0:6: Beginning Domain Validation
[  158.532783] scsi target1:0:6: FAST-10 SCSI 10.0 MB/s ST (100 ns, offset 15)
[  158.615434] scsi target1:0:6: Domain Validation skipping write tests
[  158.690464] scsi target1:0:6: Ending Domain Validation
[  160.628856] Driver 'sd' needs updating - please use bus_type methods
[  160.706231] sd 0:0:2:0: [sda] 35843670 512-byte hardware sectors: (18.3 GB/17.0 GiB)
[  160.798164] sd 0:0:2:0: [sda] Write Protect is off
[  160.854219] sd 0:0:2:0: [sda] Mode Sense: cb 00 00 08
[  160.855958] sd 0:0:2:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[  160.964277] sd 0:0:2:0: [sda] 35843670 512-byte hardware sectors: (18.3 GB/17.0 GiB)
[  161.056543] sd 0:0:2:0: [sda] Write Protect is off
[  161.112601] sd 0:0:2:0: [sda] Mode Sense: cb 00 00 08
[  161.114342] sd 0:0:2:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[  161.221004]  sda: sda1 sda2 sda3 sda4
[  161.280643] sd 0:0:2:0: [sda] Attached SCSI disk
[  161.337076] sd 0:0:3:0: [sdb] 35843670 512-byte hardware sectors: (18.3 GB/17.0 GiB)
[  161.428944] sd 0:0:3:0: [sdb] Write Protect is off
[  161.485076] sd 0:0:3:0: [sdb] Mode Sense: cb 00 00 08
[  161.486703] sd 0:0:3:0: [sdb] Write cache: disabled, read cache: enabled, doesn't support DPO or FUA
[  161.596179] sd 0:0:3:0: [sdb] 35843670 512-byte hardware sectors: (18.3 GB/17.0 GiB)
[  161.688379] sd 0:0:3:0: [sdb] Write Protect is off
[  161.744505] sd 0:0:3:0: [sdb] Mode Sense: cb 00 00 08
[  161.746152] sd 0:0:3:0: [sdb] Write cache: disabled, read cache: enabled, doesn't support DPO or FUA
[  161.853948]  sdb: unknown partition table
[  161.914751] sd 0:0:3:0: [sdb] Attached SCSI disk
[  161.972402] sd 0:0:4:0: [sdc] 17773524 512-byte hardware sectors: (9.10 GB/8.47 GiB)
[  162.065256] sd 0:0:4:0: [sdc] Write Protect is off
[  162.120515] sd 0:0:4:0: [sdc] Mode Sense: 9f 00 10 08
[  162.122885] sd 0:0:4:0: [sdc] Write cache: disabled, read cache: enabled, supports DPO and FUA
[  162.225885] sd 0:0:4:0: [sdc] 17773524 512-byte hardware sectors: (9.10 GB/8.47 GiB)
[  162.318959] sd 0:0:4:0: [sdc] Write Protect is off
[  162.374204] sd 0:0:4:0: [sdc] Mode Sense: 9f 00 10 08
[  162.376573] sd 0:0:4:0: [sdc] Write cache: disabled, read cache: enabled, supports DPO and FUA
[  162.477692]  sdc: unknown partition table
[  162.534946] sd 0:0:4:0: [sdc] Attached SCSI disk
[  162.631147] sd 0:0:5:0: [sdd] 8925000 512-byte hardware sectors: (4.56 GB/4.25 GiB)
[  162.772978] sd 0:0:5:0: [sdd] Write Protect is off
[  162.828261] sd 0:0:5:0: [sdd] Mode Sense: b9 00 00 08
[  162.863558] sd 0:0:5:0: [sdd] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[  163.004671] sd 0:0:5:0: [sdd] 8925000 512-byte hardware sectors: (4.56 GB/4.25 GiB)
[  163.146517] sd 0:0:5:0: [sdd] Write Protect is off
[  163.201766] sd 0:0:5:0: [sdd] Mode Sense: b9 00 00 08
[  163.237083] sd 0:0:5:0: [sdd] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[  163.343503]  sdd: unknown partition table
[  163.400947] sd 0:0:5:0: [sdd] Attached SCSI disk
[  163.461182] sd 0:0:8:0: [sde] 8330543 512-byte hardware sectors: (4.26 GB/3.97 GiB)
[  163.554879] sd 0:0:8:0: [sde] Write Protect is off
[  163.610183] sd 0:0:8:0: [sde] Mode Sense: 9f 00 10 08
[  163.614416] sd 0:0:8:0: [sde] Write cache: disabled, read cache: enabled, supports DPO and FUA
[  163.718438] sd 0:0:8:0: [sde] 8330543 512-byte hardware sectors: (4.26 GB/3.97 GiB)
[  163.812121] sd 0:0:8:0: [sde] Write Protect is off
[  163.867417] sd 0:0:8:0: [sde] Mode Sense: 9f 00 10 08
[  163.871654] sd 0:0:8:0: [sde] Write cache: disabled, read cache: enabled, supports DPO and FUA
[  163.972775]  sde: unknown partition table
[  164.036491] sd 0:0:8:0: [sde] Attached SCSI disk
[  164.096933] sd 0:0:9:0: [sdf] 4165272 512-byte hardware sectors: (2.13 GB/1.98 GiB)
[  164.190793] sd 0:0:9:0: [sdf] Write Protect is off
[  164.246035] sd 0:0:9:0: [sdf] Mode Sense: 9f 00 10 08
[  164.250497] sd 0:0:9:0: [sdf] Write cache: disabled, read cache: enabled, supports DPO and FUA
[  164.354697] sd 0:0:9:0: [sdf] 4165272 512-byte hardware sectors: (2.13 GB/1.98 GiB)
[  164.448555] sd 0:0:9:0: [sdf] Write Protect is off
[  164.503788] sd 0:0:9:0: [sdf] Mode Sense: 9f 00 10 08
[  164.508184] sd 0:0:9:0: [sdf] Write cache: disabled, read cache: enabled, supports DPO and FUA
[  164.609359]  sdf: unknown partition table
[  164.672245] sd 0:0:9:0: [sdf] Attached SCSI disk
[  164.727264] mice: PS/2 mouse device common for all mice
[  164.792326] rtc-m48t59 rtc-m48t59.0: rtc core: registered m48t59 as rtc0
[  164.873468] TCP cubic registered
[  164.910019] NET: Registered protocol family 17
[  164.964530] registered taskstats version 1
[  165.012680] rtc-m48t59 rtc-m48t59.0: setting system clock to 2009-01-16 07:47:22 UTC (1232092042)
[  165.899477] kjournald starting.  Commit interval 5 seconds
[  165.963133] EXT3-fs: mounted filesystem with ordered data mode.
[  166.034035] VFS: Mounted root (ext3 filesystem) readonly on device 8:2.
[  169.104462] Driver 'sr' needs updating - please use bus_type methods
[  169.348265] sungem.c:v0.98 8/24/03 David S. Miller (davem@redhat.com)
[  169.423394] PCI: Enabling device: (0001:80:02.0), cmd 2
[  169.426648] eth0: Sun GEM (PCI) 10/100/1000BaseT Ethernet 00:03:ba:04:81:54
[  169.609702] sr0: scsi-1 drive
[  169.643112] Uniform CD-ROM driver Revision: 3.20
[  169.699095] sr 1:0:6:0: Attached scsi CD-ROM sr0
[  170.690366] PCI: Enabling device: (0003:80:02.0), cmd 3
[  170.806126] sd 0:0:2:0: Attached scsi generic sg0 type 0
[  170.868183] sd 0:0:3:0: Attached scsi generic sg1 type 0
[  170.931506] sd 0:0:4:0: Attached scsi generic sg2 type 0
[  170.995054] sd 0:0:5:0: Attached scsi generic sg3 type 0
[  171.058621] sd 0:0:8:0: Attached scsi generic sg4 type 0
[  171.201870] udev: renamed network interface eth0 to eth2
[  171.263649] sd 0:0:9:0: Attached scsi generic sg5 type 0
[  171.327408] sr 1:0:6:0: Attached scsi generic sg6 type 5
[  176.133310] scsi2 : Adaptec AIC79XX PCI-X SCSI HBA DRIVER, Rev 3.0
[  176.133323]         <Adaptec 29320ALP PCIx Ultra320 SCSI adapter>
[  176.133335]         aic7901: Ultra320 Wide Channel A, SCSI Id=7, PCI 33 or 66MHz, 512 SCBs
[  200.342783] Adding 787168k swap on /dev/sda4.  Priority:-1 extents:1 across:787168k 
[  200.772866] EXT3 FS on sda2, internal journal
[  201.866781] device-mapper: uevent: version 1.0.3
[  201.921351] device-mapper: ioctl: 4.14.0-ioctl (2008-04-23) initialised: dm-devel@redhat.com
[  202.886007] kjournald starting.  Commit interval 5 seconds
[  202.950133] EXT3 FS on sda1, internal journal
[  203.001766] EXT3-fs: mounted filesystem with ordered data mode.
[  208.153305] eth1: Link is up using internal transceiver at 100Mb/s, Full Duplex.
[  217.360211] NET: Registered protocol family 10
[  217.412607] lo: Disabled Privacy Extensions


-- 
Meelis Roos (mroos@linux.ee)
