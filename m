From: Mariusz Kozlowski <m.kozlowski@tuxland.pl>
Date: Wed, 21 Jan 2009 10:44:12 +0000
Subject: Re: [sparc] ext3 corruption on latest mainline
Message-Id: <200901211144.12891.m.kozlowski@tuxland.pl>
List-Id: <sparclinux.vger.kernel.org>
References: <200901201917.12141.m.kozlowski@tuxland.pl>
In-Reply-To: <200901201917.12141.m.kozlowski@tuxland.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

> I ended up with corrupted ext3 (see sparc.jpg) and working now to restore it.

Up and running again. I managed to get some more info from yesterday crash from syslog:

Jan 20 17:44:07 kernel: EXT3-fs error (device sda3): ext3_valid_block_bitmap: Invalid block bitmap - block_group = 41, block = 2113283
Jan 20 17:44:07 kernel: EXT3-fs error (device sda3): ext3_free_blocks_sb: bit already cleared for block 1361983
Jan 20 17:44:07 kernel: attempt to access beyond end of device
Jan 20 17:44:07 kernel: sda3: rw=0, want4217736, limit4122060
Jan 20 17:44:07 kernel: EXT3-fs error (device sda3): read_inode_bitmap: Cannot read inode bitmap - block_group = 41, inode_bitmap = 16777216
Jan 20 17:44:07 kernel: EXT3-fs error (device sda3): ext3_free_blocks_sb: bit already cleared for block 1361978
Jan 20 17:44:07 kernel: EXT3-fs error (device sda3): ext3_free_blocks_sb: bit already cleared for block 1361979
Jan 20 17:44:07 kernel: attempt to access beyond end of device
Jan 20 17:44:07 kernel: sda3: rw=0, want4217736, limit4122060
Jan 20 17:44:07 kernel: EXT3-fs error (device sda3): read_inode_bitmap: Cannot read inode bitmap - block_group = 41, inode_bitmap = 16777216
Jan 20 17:44:07 kernel: attempt to access beyond end of device
Jan 20 17:44:07 kernel: sda3: rw=0, want4217736, limit4122060
Jan 20 17:44:07 kernel: EXT3-fs error (device sda3): read_inode_bitmap: Cannot read inode bitmap - block_group = 41, inode_bitmap = 16777216
Jan 20 17:44:07 kernel: EXT3-fs error (device sda3): ext3_free_blocks_sb: bit already cleared for block 1361975
Jan 20 17:44:07 kernel: EXT3-fs error (device sda3): ext3_free_blocks_sb: bit already cleared for block 1361977
Jan 20 17:44:07 kernel: attempt to access beyond end of device
Jan 20 17:44:07 kernel: sda3: rw=0, want4217736, limit4122060
Jan 20 17:44:07 kernel: EXT3-fs error (device sda3): read_inode_bitmap: Cannot read inode bitmap - block_group = 41, inode_bitmap = 16777216
Jan 20 17:44:07 kernel: EXT3-fs error (device sda3): ext3_free_blocks_sb: bit already cleared for block 1361980
Jan 20 17:44:07 kernel: EXT3-fs error (device sda3): ext3_free_blocks_sb: bit already cleared for block 1361981
Jan 20 17:44:07 kernel: attempt to access beyond end of device
Jan 20 17:44:07 kernel: sda3: rw=0, want4217736, limit4122060
Jan 20 17:44:07 kernel: EXT3-fs error (device sda3): read_inode_bitmap: Cannot read inode bitmap - block_group = 41, inode_bitmap = 16777216
Jan 20 17:44:07 kernel: attempt to access beyond end of device
Jan 20 17:44:07 kernel: sda3: rw=0, want4217736, limit4122060
Jan 20 17:44:07 kernel: EXT3-fs error (device sda3): read_inode_bitmap: Cannot read inode bitmap - block_group = 41, inode_bitmap = 16777216
Jan 20 17:44:07 kernel: EXT3-fs error (device sda3): ext3_free_blocks_sb: bit already cleared for block 1362002
Jan 20 17:44:07 kernel: EXT3-fs error (device sda3): ext3_free_blocks_sb: bit already cleared for block 1362003
Jan 20 17:44:07 kernel: attempt to access beyond end of device
Jan 20 17:44:07 kernel: sda3: rw=0, want4217736, limit4122060
Jan 20 17:44:07 kernel: EXT3-fs error (device sda3): read_inode_bitmap: Cannot read inode bitmap - block_group = 41, inode_bitmap = 16777216
Jan 20 17:44:07 kernel: EXT3-fs error (device sda3): ext3_free_blocks_sb: bit already cleared for block 1372274
Jan 20 17:44:07 kernel: EXT3-fs error (device sda3): ext3_free_blocks_sb: bit already cleared for block 1372275
Jan 20 17:44:07 kernel: attempt to access beyond end of device
Jan 20 17:44:07 kernel: sda3: rw=0, want4217736, limit4122060
Jan 20 17:44:07 kernel: EXT3-fs error (device sda3): read_inode_bitmap: Cannot read inode bitmap - block_group = 41, inode_bitmap = 16777216
Jan 20 17:44:07 kernel: EXT3-fs error (device sda3): ext3_free_blocks_sb: bit already cleared for block 1353732
Jan 20 17:44:07 kernel: attempt to access beyond end of device
Jan 20 17:44:07 kernel: sda3: rw=0, want4217736, limit4122060
Jan 20 17:44:07 kernel: EXT3-fs error (device sda3): read_inode_bitmap: Cannot read inode bitmap - block_group = 41, inode_bitmap = 16777216
Jan 20 17:44:07 kernel: EXT3-fs error (device sda3): ext3_free_blocks_sb: bit already cleared for block 1365489
Jan 20 17:44:07 kernel: EXT3-fs error (device sda3): ext3_free_blocks_sb: bit already cleared for block 1365490
Jan 20 17:44:07 kernel: EXT3-fs error (device sda3): ext3_free_blocks_sb: bit already cleared for block 1365491
Jan 20 17:44:07 kernel: EXT3-fs error (device sda3): ext3_free_blocks_sb: bit already cleared for block 1365492
Jan 20 17:44:07 kernel: attempt to access beyond end of device
Jan 20 17:44:07 kernel: sda3: rw=0, want4217736, limit4122060
Jan 20 17:44:07 kernel: EXT3-fs error (device sda3): read_inode_bitmap: Cannot read inode bitmap - block_group = 41, inode_bitmap = 16777216
Jan 20 17:44:07 kernel: EXT3-fs error (device sda3): ext3_free_blocks_sb: bit already cleared for block 1361996
Jan 20 17:44:07 kernel: EXT3-fs error (device sda3): ext3_free_blocks_sb: bit already cleared for block 1361997
Jan 20 17:44:07 kernel: EXT3-fs error (device sda3): ext3_free_blocks_sb: bit already cleared for block 1361999
Jan 20 17:44:07 kernel: attempt to access beyond end of device
Jan 20 17:44:07 kernel: sda3: rw=0, want4217736, limit4122060
Jan 20 17:44:07 kernel: EXT3-fs error (device sda3): read_inode_bitmap: Cannot read inode bitmap - block_group = 41, inode_bitmap = 16777216
Jan 20 17:44:07 kernel: EXT3-fs error (device sda3): ext3_free_blocks_sb: bit already cleared for block 1365475
Jan 20 17:44:07 kernel: EXT3-fs error (device sda3): ext3_free_blocks_sb: bit already cleared for block 1365481
Jan 20 17:44:07 kernel: EXT3-fs error (device sda3): ext3_free_blocks_sb: bit already cleared for block 1365482
Jan 20 17:44:07 kernel: EXT3-fs error (device sda3): ext3_free_blocks_sb: bit already cleared for block 1365484
Jan 20 17:44:07 kernel: attempt to access beyond end of device
Jan 20 17:44:07 kernel: sda3: rw=0, want4217736, limit4122060
Jan 20 17:44:07 kernel: EXT3-fs error (device sda3): read_inode_bitmap: Cannot read inode bitmap - block_group = 41, inode_bitmap = 16777216
Jan 20 17:44:07 kernel: EXT3-fs error (device sda3): ext3_free_blocks_sb: bit already cleared for block 1365495
Jan 20 17:44:07 kernel: attempt to access beyond end of device
Jan 20 17:44:07 kernel: sda3: rw=0, want4217736, limit4122060
Jan 20 17:44:07 kernel: EXT3-fs error (device sda3): read_inode_bitmap: Cannot read inode bitmap - block_group = 41, inode_bitmap = 16777216
Jan 20 17:44:07 kernel: EXT3-fs error (device sda3): ext3_free_blocks_sb: bit already cleared for block 1362001
Jan 20 17:44:07 kernel: attempt to access beyond end of device
Jan 20 17:44:07 kernel: sda3: rw=0, want4217736, limit4122060
Jan 20 17:44:07 kernel: EXT3-fs error (device sda3): read_inode_bitmap: Cannot read inode bitmap - block_group = 41, inode_bitmap = 16777216
Jan 20 17:44:07 kernel: EXT3-fs error (device sda3): ext3_free_blocks_sb: bit already cleared for block 1365493
Jan 20 17:44:07 kernel: attempt to access beyond end of device
Jan 20 17:44:07 kernel: sda3: rw=0, want4217736, limit4122060
Jan 20 17:44:07 kernel: EXT3-fs error (device sda3): read_inode_bitmap: Cannot read inode bitmap - block_group = 41, inode_bitmap = 16777216
Jan 20 17:44:07 kernel: EXT3-fs error (device sda3): ext3_free_blocks_sb: bit already cleared for block 1362108
Jan 20 17:44:07 kernel: EXT3-fs error (device sda3): ext3_free_blocks_sb: bit already cleared for block 1362109
Jan 20 17:44:07 kernel: EXT3-fs error (device sda3): ext3_free_blocks_sb: bit already cleared for block 1362181
Jan 20 17:44:07 kernel: attempt to access beyond end of device
Jan 20 17:44:07 kernel: sda3: rw=0, want4217736, limit4122060
Jan 20 17:44:07 kernel: EXT3-fs error (device sda3): read_inode_bitmap: Cannot read inode bitmap - block_group = 41, inode_bitmap = 16777216
Jan 20 17:44:07 kernel: EXT3-fs error (device sda3): ext3_free_blocks_sb: bit already cleared for block 1365498
Jan 20 17:44:07 kernel: EXT3-fs error (device sda3): ext3_free_blocks_sb: bit already cleared for block 1365503
Jan 20 17:44:07 kernel: attempt to access beyond end of device
Jan 20 17:44:07 kernel: sda3: rw=0, want4217736, limit4122060
Jan 20 17:44:07 kernel: EXT3-fs error (device sda3): read_inode_bitmap: Cannot read inode bitmap - block_group = 41, inode_bitmap = 16777216
Jan 20 17:44:07 kernel: EXT3-fs error (device sda3): ext3_free_blocks_sb: bit already cleared for block 1369268
Jan 20 17:44:07 kernel: EXT3-fs error (device sda3): ext3_free_blocks_sb: bit already cleared for block 1369269
Jan 20 17:44:07 kernel: EXT3-fs error (device sda3): ext3_free_blocks_sb: bit already cleared for block 1369281
Jan 20 17:44:07 kernel: EXT3-fs error (device sda3): ext3_free_blocks_sb: bit already cleared for block 1369282
Jan 20 17:44:07 kernel: EXT3-fs error (device sda3): ext3_free_blocks_sb: bit already cleared for block 1369283
Jan 20 17:44:07 kernel: EXT3-fs error (device sda3): ext3_free_blocks_sb: bit already cleared for block 1369284
[...]

Don't know how to reproduce that and how to find the culprit while not damaging fs so that's it for now.

	Mariusz


machine:
Sun Ultra 60 (2 cpus)

kernel:
Linux sparc64 2.6.29-rc2-00013-gf3b8436 #1 SMP PREEMPT Tue Jan 20 11:53:33 CET 2009 sparc64 sun4u Unknown CPU GNU/Linux

scsi:
00:03.0 SCSI storage controller: LSI Logic / Symbios Logic 53c875 (rev 14)
00:03.1 SCSI storage controller: LSI Logic / Symbios Logic 53c875 (rev 14)

dmesg:
PROMLIB: Sun IEEE Boot Prom 'OBP 3.17.0 1998/10/23 11:26'
PROMLIB: Root node compatible: 
Linux version 2.6.29-rc2-00013-gf3b8436 (mako@flyhigh) (gcc version 4.2.3 (Gentoo 4.2.3 p1.0)) #1 SMP PREEMPT Tue Jan 20 11:53:33 CET 2009
console [earlyprom0] enabled
ARCH: SUN4U
Ethernet address: 08:00:20:a1:fa:cb
Kernel: Using 3 locked TLB entries for main kernel image.
Remapping the kernel... done.
OF stdout device is: /SUNW,ffb@1e,0
PROM: Built device tree with 47600 bytes of memory.
Top of RAM: 0xbff34000, Total RAM: 0x3ff30000
Memory hole size: 2048MB
[0000000201800000-fffff80081000000] page_structs1072 node=0 entry=6/0
[0000000201800000-fffff80081400000] page_structs1072 node=0 entry=7/0
[0000000201800000-fffff80081800000] page_structs1072 node=0 entry=8/0
Allocated 1056768 bytes for kernel page tables.
Zone PFN ranges:
  Normal   0x00040000 -> 0x0005ff9a
Movable zone start PFN for each node
early_node_map[3] active PFN ranges
    0: 0x00040000 -> 0x0005ff7f
    0: 0x0005ff80 -> 0x0005ff8d
    0: 0x0005ff8e -> 0x0005ff9a
On node 0 totalpages: 130968
  Normal zone: 1535 pages used for memmap
  Normal zone: 0 pages reserved
  Normal zone: 129433 pages, LIFO batch:15
Booting Linux...
Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 129433
Kernel command line: root=/dev/sda3
Preemptible RCU implementation.
PID hash table entries: 4096 (order: 12, 32768 bytes)
clocksource: mult[238e9] shift[16]
clockevent: mult[7332178c] shift[32]
Console: colour dummy device 80x25
console handover: boot [earlyprom0] -> real [tty0]
Lock dependency validator: Copyright (c) 2006 Red Hat, Inc., Ingo Molnar
... MAX_LOCKDEP_SUBCLASSES:  8
... MAX_LOCK_DEPTH:          48
... MAX_LOCKDEP_KEYS:        8191
... CLASSHASH_SIZE:          4096
... MAX_LOCKDEP_ENTRIES:     8192
... MAX_LOCKDEP_CHAINS:      16384
... CHAINHASH_SIZE:          8192
 memory used by lock dependency info: 3839 kB
 per task-struct memory footprint: 1920 bytes
Dentry cache hash table entries: 131072 (order: 7, 1048576 bytes)
Inode-cache hash table entries: 65536 (order: 6, 524288 bytes)
Memory: 1020928k available (2848k kernel code, 1024k data, 176k init) [fffff80000000000,00000000bff34000]
SLUB: Genslabs, HWalign2, Order=0-3, MinObjects=0, CPUs=3, Nodes=1
Calibrating delay using timer specific routine.. 925.71 BogoMIPS (lpjF2857)
Mount-cache hash table entries: 512
CPU 2: synchronized TICK with master CPU (last diff -2 cycles, maxerr 537 cycles)
Brought up 2 CPUs
net_namespace: 1184 bytes
NET: Registered protocol family 16
CPU: Unknown chip, impl[0x17] vers[0x11]
FPU: Unknown chip, impl[0x17] vers[0x11]
/pci@1f,4000: PCI IO[1fe02010000] MEM[1ff80000000]
/pci@1f,4000: PSYCHO PCI Bus Module ver[4:0]
PCI: Scanning PBM /pci@1f,4000
/pci@1f,2000: PCI IO[1fe02000000] MEM[1ff00000000]
/pci@1f,2000: PSYCHO PCI Bus Module ver[4:0]
PCI: Scanning PBM /pci@1f,2000
/pci@1f,2000: PCI bus error, PCI_STATUS[22a0]
bio: create slab <bio-0> at 0
SCSI subsystem initialized
/pci@1f,4000/ebus@1/eeprom@14,0: Mostek regs at 0x1fff1000000
AUXIO: Found device at /pci@1f,4000/ebus@1/auxio@14,726000
Switched to high resolution mode on CPU 0
Switched to high resolution mode on CPU 2
NET: Registered protocol family 2
IP route cache hash table entries: 8192 (order: 3, 65536 bytes)
TCP established hash table entries: 32768 (order: 6, 524288 bytes)
TCP bind hash table entries: 32768 (order: 7, 1835008 bytes)
TCP: Hash tables configured (established 32768 bind 32768)
TCP reno registered
NET: Registered protocol family 1
power: Control reg at 1fff1724000
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
msgmni has been set to 1995
io scheduler noop registered
io scheduler cfq registered (default)
Console: switching to colour frame buffer device 160x64
/SUNW,ffb@1e,0: FFB at 000001fc00000000, type 51, DAC pnum[236e] rev[10] manuf_rev[1]
/pci@1f,4000/ebus@1/su@14,3083f8: Keyboard port at 1fff13083f8, irq 8
/pci@1f,4000/ebus@1/su@14,3062f8: Mouse port at 1fff13062f8, irq 9
PCI: Enabling device: (0000:00:01.1), cmd 2
sunhme.c:v3.10 August 26, 2008 David S. Miller (davem@davemloft.net)
eth0: HAPPY MEAL (PCI/CheerIO) 10/100BaseT Ethernet 08:00:20:a1:fa:cb
Loading iSCSI transport class v2.0-870.
PCI: Enabling device: (0000:00:03.0), cmd 147
sym0: <875> rev 0x14 at pci 0000:00:03.0 irq 15
sym0: No NVRAM, ID 7, Fast-20, SE, parity checking
sym0: SCSI BUS has been reset.
scsi0 : sym-2.2.3
scsi 0:0:1:0: Direct-Access     SEAGATE  ST318203LSUN18G  034A PQ: 0 ANSI: 2
 target0:0:1: tagged command queuing enabled, command queue depth 16.
 target0:0:1: Beginning Domain Validation
 target0:0:1: asynchronous
 target0:0:1: wide asynchronous
 target0:0:1: FAST-20 WIDE SCSI 40.0 MB/s ST (50 ns, offset 15)
 target0:0:1: Domain Validation skipping write tests
 target0:0:1: Ending Domain Validation
scsi 0:0:6:0: CD-ROM            TEAC     CD-R56S4         1.0P PQ: 0 ANSI: 2
 target0:0:6: Beginning Domain Validation
 target0:0:6: asynchronous
 target0:0:6: FAST-10 SCSI 10.0 MB/s ST (100 ns, offset 15)
 target0:0:6: Domain Validation skipping write tests
 target0:0:6: Ending Domain Validation
PCI: Enabling device: (0000:00:03.1), cmd 3
sym1: <875> rev 0x14 at pci 0000:00:03.1 irq 16
sym1: No NVRAM, ID 7, Fast-20, SE, parity checking
sym1: SCSI BUS has been reset.
scsi1 : sym-2.2.3
Driver 'sd' needs updating - please use bus_type methods
sd 0:0:1:0: [sda] 35378533 512-byte hardware sectors: (18.1 GB/16.8 GiB)
sd 0:0:1:0: [sda] Write Protect is off
sd 0:0:1:0: [sda] Mode Sense: cf 00 10 08
sd 0:0:1:0: [sda] Write cache: disabled, read cache: enabled, supports DPO and FUA
sd 0:0:1:0: [sda] 35378533 512-byte hardware sectors: (18.1 GB/16.8 GiB)
sd 0:0:1:0: [sda] Write Protect is off
sd 0:0:1:0: [sda] Mode Sense: cf 00 10 08
sd 0:0:1:0: [sda] Write cache: disabled, read cache: enabled, supports DPO and FUA
 sda: sda1 sda2 sda3
sd 0:0:1:0: [sda] Attached SCSI disk
mice: PS/2 mouse device common for all mice
rtc-m48t59 rtc-m48t59.0: rtc core: registered m48t59 as rtc0
TCP cubic registered
NET: Registered protocol family 17
RPC: Registered udp transport module.
RPC: Registered tcp transport module.
rtc-m48t59 rtc-m48t59.0: setting system clock to 2009-01-21 11:37:16 UTC (1232537836)
input: Sun Type 5 keyboard as /class/input/input0
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly on device 8:3.
Driver 'sr' needs updating - please use bus_type methods
sr0: scsi3-mmc drive: 24x/24x writer cd/rw xa/form2 cdda tray
Uniform CD-ROM driver Revision: 3.20
sr 0:0:6:0: Attached scsi CD-ROM sr0
sd 0:0:1:0: Attached scsi generic sg0 type 0
sr 0:0:6:0: Attached scsi generic sg1 type 5
EXT3 FS on sda3, internal journal
Adding 497992k swap on /dev/sda2.  Priority:-1 extents:1 across:497992k 
eth0: Link is up using internal transceiver at 100Mb/s, Full Duplex.
Kernel unaligned access at TPC[5704f0] nsm_get_handle+0x150/0x420
Kernel unaligned access at TPC[5704f4] nsm_get_handle+0x154/0x420

