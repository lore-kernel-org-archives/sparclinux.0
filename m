From: Marcel van Nies <morcles@gmail.com>
Date: Thu, 24 May 2012 19:27:31 +0000
Subject: sparc32: some testing
Message-Id: <CACEWtaB=RkibxRvH7HVmVks5B73Yr-79qPutsARgvCV5JfjkwQ@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hi,

I gave today's sparc.git a try on a SS20 with SuperSparc-II and
another one with HyperSparc CPUs.
Starting with an UP kernel, I got some bugs on the SuperSparc and a
segfault on the HyperSparc, see below for bootlogs.
I can test patches etc. If more info is required, please let me know.

Thanks,
M

== HyperSparc =
SPARCstation 20 MP (4 X RT625), No Keyboard
ROM Rev. 2.25R hyperSPARC, 448 MB memory installed, Serial #8491359.
Ethernet address 8:0:20:81:91:5f, Host ID: 7281915f.

Timeout waiting for ARP/RARP packet
349c00
PROMLIB: obio_ranges 5
PROMLIB: Sun Boot Prom Version 3 Revision 2
Linux version 3.4.0-02583-g4efcac3 (builder@jalapeno) (gcc version
4.5.3 (Gentoo 4.5.3-r1 p1.0, pie-0.4.5) ) #2 Thu May 24 18:44:32 CEST
2012
bootconsole [earlyprom0] enabled
ARCH: SUN4M
TYPE: Sun4m SparcStation10/20
Ethernet address: 08:00:20:81:91:5f
SRMMU: Using VAC size of 262144 bytes, line size 64 bytes.
255MB HIGHMEM available.
OF stdout device is: /obio/zs@0,100000:a
PROM: Built device tree with 30178 bytes of memory.
Booting Linux...
Power off control detected.
Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 112691
Kernel command line: root=/dev/sdb4
PID hash table entries: 1024 (order: 0, 4096 bytes)
Dentry cache hash table entries: 32768 (order: 5, 131072 bytes)
Inode-cache hash table entries: 16384 (order: 4, 65536 bytes)
Memory: 445292k/458224k available (2592k kernel code, 12932k reserved,
624k data, 124k init, 261616k highmem)
SLUB: Genslabs, HWalign2, Order=0-3, MinObjects=0, CPUs=1, Nodes=1
NR_IRQS:64
Console: colour dummy device 80x25
console [tty0] enabled, bootconsole disabled
PROMLIB: Sun Boot Prom Version 3 Revision 2
Linux version 3.4.0-02583-g4efcac3 (builder@jalapeno) (gcc version
4.5.3 (Gentoo 4.5.3-r1 p1.0, pie-0.4.5) ) #2 Thu May 24 18:44:32 CEST
2012
bootconsole [earlyprom0] enabled
ARCH: SUN4M
TYPE: Sun4m SparcStation10/20
Ethernet address: 08:00:20:81:91:5f
SRMMU: Using VAC size of 262144 bytes, line size 64 bytes.
255MB HIGHMEM available.
OF stdout device is: /obio/zs@0,100000:a
PROM: Built device tree with 30178 bytes of memory.
Booting Linux...
Power off control detected.
Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 112691
Kernel command line: root=/dev/sdb4
PID hash table entries: 1024 (order: 0, 4096 bytes)
Dentry cache hash table entries: 32768 (order: 5, 131072 bytes)
Inode-cache hash table entries: 16384 (order: 4, 65536 bytes)
Memory: 445292k/458224k available (2592k kernel code, 12932k reserved,
624k data, 124k init, 261616k highmem)
SLUB: Genslabs, HWalign2, Order=0-3, MinObjects=0, CPUs=1, Nodes=1
NR_IRQS:64
Console: colour dummy device 80x25
console [tty0] enabled, bootconsole disabled
Calibrating delay loop... 123.90 BogoMIPS (lpj$7808)
pid_max: default: 32768 minimum: 301
Mount-cache hash table entries: 512
NET: Registered protocol family 16
IOMMU: impl 1 vers 3 table 0xfbc80000[262144 B] map [65536 b]
bio: create slab <bio-0> at 0
SCSI subsystem initialized
Switching to clocksource timer_cs
NET: Registered protocol family 2
IP route cache hash table entries: 2048 (order: 1, 8192 bytes)
TCP established hash table entries: 8192 (order: 4, 65536 bytes)
TCP bind hash table entries: 8192 (order: 3, 32768 bytes)
TCP: Hash tables configured (established 8192 bind 8192)
TCP: reno registered
UDP hash table entries: 256 (order: 0, 4096 bytes)
UDP-Lite hash table entries: 256 (order: 0, 4096 bytes)
NET: Registered protocol family 1
RPC: Registered named UNIX socket transport module.
RPC: Registered udp transport module.
RPC: Registered tcp transport module.
RPC: Registered tcp NFSv4.1 backchannel transport module.
led: version 0.1, Lars Kotthoff <metalhead@metalhead.ws>
highmem bounce pool size: 64 pages
msgmni has been set to 358
io scheduler noop registered
io scheduler deadline registered
io scheduler cfq registered (default)
ffd60050: ttyS0 at MMIO 0xf1100000 (irq = 8) is a zs (ESCC)
Console: ttyS0 (SunZilog zs0)
console [ttyS0] enabled
ffd60050: ttyS1 at MMIO 0xf1100004 (irq = 8) is a zs (ESCC)
ffd60130: Keyboard at MMIO 0xf1000000 (irq = 8) is a zs
ffd60130: Mouse at MMIO 0xf1000004 (irq = 8) is a zs
brd: module loaded
esp: esp0, regs[fd00a000:fd009000] irq[2]
esp: esp0 is a FAS100A, 40 MHz (ccf=0), SCSI ID 7
scsi0 : esp
scsi 0:0:1:0: Direct-Access     FUJITSU  MAP3735N SUN72G  0401 PQ: 0 ANSI: 4
scsi target0:0:1: Beginning Domain Validation
scsi target0:0:1: FAST-10 SCSI 10.0 MB/s ST (100 ns, offset 15)
scsi target0:0:1: Domain Validation skipping write tests
scsi target0:0:1: Ending Domain Validation
scsi 0:0:3:0: Direct-Access     FUJITSU  MAP3735N SUN72G  0401 PQ: 0 ANSI: 4
scsi target0:0:3: Beginning Domain Validation
scsi target0:0:3: FAST-10 SCSI 10.0 MB/s ST (100 ns, offset 15)
scsi target0:0:3: Domain Validation skipping write tests
scsi target0:0:3: Ending Domain Validation
esp: esp1, regs[fd00c000:fd00b000] irq[7]
esp: esp1 is a FASHME, 40 MHz (ccf=0), SCSI ID 7
scsi1 : esp
sd 0:0:1:0: [sda] 143374738 512-byte logical blocks: (73.4 GB/68.3 GiB)
sd 0:0:3:0: [sdb] 143374738 512-byte logical blocks: (73.4 GB/68.3 GiB)
sd 0:0:1:0: [sda] Write Protect is off
sd 0:0:3:0: [sdb] Write Protect is off
tun: Universal TUN/TAP device driver, 1.6
tun: (C) 1999-2004 Max Krasnyansky <maxk@qualcomm.com>
sunlance.c:v2.02 8/24/03 Miguel de Icaza (miguel@nuclecu.unam.mx)
ioremap: done with statics, switching to malloc
sd 0:0:1:0: [sda] Write cache: disabled, read cache: enabled, doesn't
support DPO or FUA
sd 0:0:3:0: [sdb] Write cache: disabled, read cache: enabled, doesn't
support DPO or FUA
eth0: LANCE 08:00:20:81:91:5f
sunhme.c:v3.10 August 26, 2008 David S. Miller (davem@davemloft.net)
eth1: HAPPY MEAL (SBUS) 10/100baseT Ethernet 08:00:20:81:91:5f
mousedev: PS/2 mouse device common for all mice
 sdb: sdb1 sdb2 sdb3 sdb4 sdb5 sdb6 sdb7
 sda: sda1 sda2 sda3
rtc-m48t59 rtc-m48t59.0: rtc core: registered m48t08 as rtc0
TCP: cubic registered
NET: Registered protocol family 17
sd 0:0:3:0: [sdb] Attached SCSI disk
rtc-m48t59 rtc-m48t59.0: setting system clock to 2012-05-24 17:57:10
UTC (1337882230)
sd 0:0:1:0: [sda] Attached SCSI disk
kjournald starting.  Commit interval 5 seconds
EXT3-fs (sdb4): mounted filesystem with ordered data mode
VFS: Mounted root (ext3 filesystem) readonly on device 8:20.
Freeing unused kernel memory: 124k freed
init[1]: segfault at 0 ip 5000dac8 (rpc f0008c6c) sp efb7b8a0 error
30001 in ld-2.3.5.so[50000000+1a000]
Kernel panic - not syncing: Attempted to kill init! exitcode=0x0000000b
[f00244f4 : do_group_exit+0x28/0xb0 ]
[f002e850 : get_signal_to_deliver+0x198/0x4dc ]
[f000ba58 : do_signal+0x44/0x768 ]
[f000c4f4 : do_notify_resume+0x2c/0x3c ]
[f00099bc : signal_p+0x14/0x24 ]
[f0008c6c : srmmu_fault+0x58/0x68 ]

Press Stop-A (L1-A) to return to the boot prom



== SuperSparc =
SPARCstation 20 MP (2 X SuperSPARC-II), No Keyboard
ROM Rev. 2.25, 448 MB memory installed, Serial #8021487.
Ethernet address 8:0:20:7a:65:ef, Host ID: 727a65ef.

Timeout waiting for ARP/RARP packet
349c00
Server IP address: 192.168.178.250
Client IP address: 192.168.178.75
PROMLIB: obio_ranges 5
PROMLIB: Sun Boot Prom Version 3 Revision 2
Linux version 3.4.0-02583-g4efcac3 (builder@jalapeno) (gcc version
4.5.3 (Gentoo 4.5.3-r1 p1.0, pie-0.4.5) ) #2 Thu May 24 18:44:32 CEST
2012
bootconsole [earlyprom0] enabled
ARCH: SUN4M
TYPE: Sun4m SparcStation10/20
Ethernet address: 08:00:20:7a:65:ef
255MB HIGHMEM available.
OF stdout device is: /obio/zs@0,100000:a
PROM: Built device tree with 26926 bytes of memory.
Booting Linux...
Power off control detected.
Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 112714
Kernel command line: root=/dev/sda4
PID hash table entries: 1024 (order: 0, 4096 bytes)
Dentry cache hash table entries: 32768 (order: 5, 131072 bytes)
Inode-cache hash table entries: 16384 (order: 4, 65536 bytes)
Memory: 444432k/457932k available (2592k kernel code, 13500k reserved,
624k data, 124k init, 261324k highmem)
SLUB: Genslabs, HWalign2, Order=0-3, MinObjects=0, CPUs=1, Nodes=1
NR_IRQS:64
Console: colour dummy device 80x25
console [tty0] enabled, bootconsole disabled
PROMLIB: Sun Boot Prom Version 3 Revision 2
Linux version 3.4.0-02583-g4efcac3 (builder@jalapeno) (gcc version
4.5.3 (Gentoo 4.5.3-r1 p1.0, pie-0.4.5) ) #2 Thu May 24 18:44:32 CEST
2012
bootconsole [earlyprom0] enabled
ARCH: SUN4M
TYPE: Sun4m SparcStation10/20
Ethernet address: 08:00:20:7a:65:ef
255MB HIGHMEM available.
OF stdout device is: /obio/zs@0,100000:a
PROM: Built device tree with 26926 bytes of memory.
Booting Linux...
Power off control detected.
Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 112714
Kernel command line: root=/dev/sda4
PID hash table entries: 1024 (order: 0, 4096 bytes)
Dentry cache hash table entries: 32768 (order: 5, 131072 bytes)
Inode-cache hash table entries: 16384 (order: 4, 65536 bytes)
Memory: 444432k/457932k available (2592k kernel code, 13500k reserved,
624k data, 124k init, 261324k highmem)
SLUB: Genslabs, HWalign2, Order=0-3, MinObjects=0, CPUs=1, Nodes=1
NR_IRQS:64
Console: colour dummy device 80x25
console [tty0] enabled, bootconsole disabled
Calibrating delay loop... 74.24 BogoMIPS (lpj8480)
pid_max: default: 32768 minimum: 301
Mount-cache hash table entries: 512
NET: Registered protocol family 16
IOMMU: impl 1 vers 3 table 0xfbc80000[262144 B] map [65536 b]
bio: create slab <bio-0> at 0
SCSI subsystem initialized
Switching to clocksource timer_cs
NET: Registered protocol family 2
IP route cache hash table entries: 2048 (order: 1, 8192 bytes)
TCP established hash table entries: 8192 (order: 4, 65536 bytes)
TCP bind hash table entries: 8192 (order: 3, 32768 bytes)
TCP: Hash tables configured (established 8192 bind 8192)
TCP: reno registered
UDP hash table entries: 256 (order: 0, 4096 bytes)
UDP-Lite hash table entries: 256 (order: 0, 4096 bytes)
NET: Registered protocol family 1
RPC: Registered named UNIX socket transport module.
RPC: Registered udp transport module.
RPC: Registered tcp transport module.
RPC: Registered tcp NFSv4.1 backchannel transport module.
led: version 0.1, Lars Kotthoff <metalhead@metalhead.ws>
highmem bounce pool size: 64 pages
msgmni has been set to 357
io scheduler noop registered
io scheduler deadline registered
io scheduler cfq registered (default)
ffd5c3c0: ttyS0 at MMIO 0xf1100000 (irq = 8) is a zs (ESCC)
Console: ttyS0 (SunZilog zs0)
console [ttyS0] enabled
ffd5c3c0: ttyS1 at MMIO 0xf1100004 (irq = 8) is a zs (ESCC)
ffd5c4a0: Keyboard at MMIO 0xf1000000 (irq = 8) is a zs
ffd5c4a0: Mouse at MMIO 0xf1000004 (irq = 8) is a zs
brd: module loaded
esp: esp0, regs[fd00a000:fd009000] irq[2]
esp: esp0 is a FAS100A, 40 MHz (ccf=0), SCSI ID 7
scsi0 : esp
scsi 0:0:3:0: Direct-Access     FUJITSU  MAP3735N SUN72G  0401 PQ: 0 ANSI: 4
scsi target0:0:3: Beginning Domain Validation
scsi target0:0:3: FAST-10 SCSI 10.0 MB/s ST (100 ns, offset 15)
scsi target0:0:3: Domain Validation skipping write tests
scsi target0:0:3: Ending Domain Validation
esp: esp1, regs[fd00c000:fd00b000] irq[7]
esp: esp1 is a FASHME, 40 MHz (ccf=0), SCSI ID 7
scsi1 : esp
sd 0:0:3:0: [sda] 143374738 512-byte logical blocks: (73.4 GB/68.3 GiB)
sd 0:0:3:0: [sda] Write Protect is off
tun: Universal TUN/TAP device driver, 1.6
tun: (C) 1999-2004 Max Krasnyansky <maxk@qualcomm.com>
sunlance.c:v2.02 8/24/03 Miguel de Icaza (miguel@nuclecu.unam.mx)
ioremap: done with statics, switching to malloc
sd 0:0:3:0: [sda] Write cache: disabled, read cache: enabled, doesn't
support DPO or FUA
eth0: LANCE 08:00:20:7a:65:ef
sunhme.c:v3.10 August 26, 2008 David S. Miller (davem@davemloft.net)
eth1: HAPPY MEAL (SBUS) 10/100baseT Ethernet 08:00:20:7a:65:ef
mousedev: PS/2 mouse device common for all mice
 sda: sda1 sda2 sda3 sda4 sda5 sda6 sda7
rtc-m48t59 rtc-m48t59.0: rtc core: registered m48t08 as rtc0
TCP: cubic registered
NET: Registered protocol family 17
rtc-m48t59 rtc-m48t59.0: setting system clock to 2007-05-09 14:27:28
UTC (1178720848)
sd 0:0:3:0: [sda] Attached SCSI disk
kjournald starting.  Commit interval 5 seconds
EXT3-fs (sda4): mounted filesystem with ordered data mode
VFS: Mounted root (ext3 filesystem) readonly on device 8:4.
Freeing unused kernel memory: 124k freed
INIT: version 2.86 booting
...

cat /proc/cpuinfo
cpu             : Texas Instruments, Inc. - SuperSparc-(II)
fpu             : SuperSparc on-chip FPU
promlib         : Version 3 Revision 2
prom            : 2.25
type            : sun4m
ncpus probed    : 2
ncpus active    : 1
CPU0Bogo        : 74.24
CPU0ClkTck      : 75000000
MMU type        : TI Viking/MXCC
contexts        : 65536
nocache total   : 5242880
nocache used    : 464128

dmesg
PROMLIB: Sun Boot Prom Version 3 Revision 2
Linux version 3.4.0-02583-g4efcac3 (builder@jalapeno) (gcc version
4.5.3 (Gentoo 4.5.3-r1 p1.0, pie-0.4.5) ) #2 Thu May 24 18:44:32 CEST
2012
bootconsole [earlyprom0] enabled
ARCH: SUN4M
TYPE: Sun4m SparcStation10/20
Ethernet address: 08:00:20:7a:65:ef
255MB HIGHMEM available.
On node 0 totalpages: 113609
free_area_init_node: node 0, pgdat f0326a54, node_mem_map f0980a00
  DMA zone: 384 pages used for memmap
  DMA zone: 0 pages reserved
  DMA zone: 47894 pages, LIFO batch:15
  HighMem zone: 511 pages used for memmap
  HighMem zone: 64820 pages, LIFO batch:15
OF stdout device is: /obio/zs@0,100000:a
PROM: Built device tree with 26926 bytes of memory.
Booting Linux...
Power off control detected.
pcpu-alloc: s0 r0 d32768 u32768 alloc=1*32768
pcpu-alloc: [0] 0
Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 112714
Kernel command line: root=/dev/sda4
PID hash table entries: 1024 (order: 0, 4096 bytes)
Dentry cache hash table entries: 32768 (order: 5, 131072 bytes)
Inode-cache hash table entries: 16384 (order: 4, 65536 bytes)
Memory: 444432k/457932k available (2592k kernel code, 13500k reserved,
624k data, 124k init, 261324k highmem)
SLUB: Genslabs, HWalign2, Order=0-3, MinObjects=0, CPUs=1, Nodes=1
NR_IRQS:64
Console: colour dummy device 80x25
console [tty0] enabled, bootconsole disabled
Calibrating delay loop... 74.24 BogoMIPS (lpj8480)
pid_max: default: 32768 minimum: 301
Mount-cache hash table entries: 512
NET: Registered protocol family 16
IOMMU: impl 1 vers 3 table 0xfbc80000[262144 B] map [65536 b]
bio: create slab <bio-0> at 0
SCSI subsystem initialized
Switching to clocksource timer_cs
NET: Registered protocol family 2
IP route cache hash table entries: 2048 (order: 1, 8192 bytes)
TCP established hash table entries: 8192 (order: 4, 65536 bytes)
TCP bind hash table entries: 8192 (order: 3, 32768 bytes)
TCP: Hash tables configured (established 8192 bind 8192)
TCP: reno registered
UDP hash table entries: 256 (order: 0, 4096 bytes)
UDP-Lite hash table entries: 256 (order: 0, 4096 bytes)
NET: Registered protocol family 1
RPC: Registered named UNIX socket transport module.
RPC: Registered udp transport module.
RPC: Registered tcp transport module.
RPC: Registered tcp NFSv4.1 backchannel transport module.
led: version 0.1, Lars Kotthoff <metalhead@metalhead.ws>
highmem bounce pool size: 64 pages
msgmni has been set to 357
io scheduler noop registered
io scheduler deadline registered
io scheduler cfq registered (default)
ffd5c3c0: ttyS0 at MMIO 0xf1100000 (irq = 8) is a zs (ESCC)
Console: ttyS0 (SunZilog zs0)
console [ttyS0] enabled
ffd5c3c0: ttyS1 at MMIO 0xf1100004 (irq = 8) is a zs (ESCC)
ffd5c4a0: Keyboard at MMIO 0xf1000000 (irq = 8) is a zs
ffd5c4a0: Mouse at MMIO 0xf1000004 (irq = 8) is a zs
brd: module loaded
esp: esp0, regs[fd00a000:fd009000] irq[2]
esp: esp0 is a FAS100A, 40 MHz (ccf=0), SCSI ID 7
scsi0 : esp
scsi 0:0:3:0: Direct-Access     FUJITSU  MAP3735N SUN72G  0401 PQ: 0 ANSI: 4
scsi target0:0:3: Beginning Domain Validation
scsi target0:0:3: FAST-10 SCSI 10.0 MB/s ST (100 ns, offset 15)
scsi target0:0:3: Domain Validation skipping write tests
scsi target0:0:3: Ending Domain Validation
esp: esp1, regs[fd00c000:fd00b000] irq[7]
esp: esp1 is a FASHME, 40 MHz (ccf=0), SCSI ID 7
scsi1 : esp
tun: Universal TUN/TAP device driver, 1.6
tun: (C) 1999-2004 Max Krasnyansky <maxk@qualcomm.com>
sd 0:0:3:0: [sda] 143374738 512-byte logical blocks: (73.4 GB/68.3 GiB)
sunlance.c:v2.02 8/24/03 Miguel de Icaza (miguel@nuclecu.unam.mx)
ioremap: done with statics, switching to malloc
sd 0:0:3:0: [sda] Write Protect is off
sd 0:0:3:0: [sda] Mode Sense: b3 00 00 08
eth0: LANCE 08:00:20:7a:65:ef
sd 0:0:3:0: [sda] Write cache: disabled, read cache: enabled, doesn't
support DPO or FUA
sunhme.c:v3.10 August 26, 2008 David S. Miller (davem@davemloft.net)
eth1: HAPPY MEAL (SBUS) 10/100baseT Ethernet 08:00:20:7a:65:ef
mousedev: PS/2 mouse device common for all mice
 sda: sda1 sda2 sda3 sda4 sda5 sda6 sda7
rtc-m48t59 rtc-m48t59.0: rtc core: registered m48t08 as rtc0
TCP: cubic registered
NET: Registered protocol family 17
rtc-m48t59 rtc-m48t59.0: setting system clock to 2007-05-09 14:27:28
UTC (1178720848)
sd 0:0:3:0: [sda] Attached SCSI disk
kjournald starting.  Commit interval 5 seconds
EXT3-fs (sda4): mounted filesystem with ordered data mode
VFS: Mounted root (ext3 filesystem) readonly on device 8:4.
Freeing unused kernel memory: 124k freed
udevd (988): /proc/988/oom_adj is deprecated, please use
/proc/988/oom_score_adj instead.
EXT3-fs (sda4): using internal journal
kjournald starting.  Commit interval 5 seconds
EXT3-fs (sda5): using internal journal
EXT3-fs (sda5): mounted filesystem with ordered data mode
kjournald starting.  Commit interval 5 seconds
EXT3-fs (sda6): using internal journal
EXT3-fs (sda6): mounted filesystem with ordered data mode
kjournald starting.  Commit interval 5 seconds
EXT3-fs (sda7): using internal journal
EXT3-fs (sda7): mounted filesystem with ordered data mode
Adding 310364k swap on /dev/sda2.  Priority:-1 extents:1 across:310364k
swap_free: Bad swap file entry d0000dec
BUG: Bad page map in process ntpd  pte:01bd9abc pmd:0003ac01
addr:5039b000 vm_flags:08000070 anon_vma:  (null) mapping:fb816c00 index:9
vma->vm_ops->fault: filemap_fault+0x8/0x3d8
vma->vm_file->f_op->mmap: generic_file_mmap+0x8/0x6c
[f007962c : unmap_vmas+0x3c/0x5c ]
[f007ee30 : exit_mmap+0xac/0x15c ]
[f001e8d8 : mmput+0x2c/0xd4 ]
[f0022558 : exit_mm+0xd4/0x118 ]
[f002401c : do_exit+0x500/0x790 ]
[f00244f4 : do_group_exit+0x28/0xb0 ]
[f002e850 : get_signal_to_deliver+0x198/0x4dc ]
[f000ba58 : do_signal+0x44/0x768 ]
[f000c4f4 : do_notify_resume+0x2c/0x3c ]
[f00099bc : signal_p+0x14/0x24 ]
[50282ab8 : 0x50282ab8 ]
Disabling lock debugging due to kernel taint
swap_free: Bad swap file entry e8000dec
BUG: Bad page map in process ntpd  pte:01bd9dbc pmd:0003ac01
addr:5039c000 vm_flags:08000070 anon_vma:  (null) mapping:fb816c00 index:a
vma->vm_ops->fault: filemap_fault+0x8/0x3d8
vma->vm_file->f_op->mmap: generic_file_mmap+0x8/0x6c
[f007962c : unmap_vmas+0x3c/0x5c ]
[f007ee30 : exit_mmap+0xac/0x15c ]
[f001e8d8 : mmput+0x2c/0xd4 ]
[f0022558 : exit_mm+0xd4/0x118 ]
[f002401c : do_exit+0x500/0x790 ]
[f00244f4 : do_group_exit+0x28/0xb0 ]
[f002e850 : get_signal_to_deliver+0x198/0x4dc ]
[f000ba58 : do_signal+0x44/0x768 ]
[f000c4f4 : do_notify_resume+0x2c/0x3c ]
[f00099bc : signal_p+0x14/0x24 ]
[50282ab8 : 0x50282ab8 ]
BUG: Bad rss-counter state mm:fbfba480 idx:0 val:2
BUG: Bad rss-counter state mm:fbfba480 idx:2 val:-2
