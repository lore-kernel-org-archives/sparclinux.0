From: Josip Rodin <joy@entuzijast.net>
Date: Mon, 23 Nov 2009 22:27:34 +0000
Subject: Re: Sparc release requalification
Message-Id: <20091123222734.GA27660@orion.carnet.hr>
List-Id: <sparclinux.vger.kernel.org>
References: <4AA427E6.5000801@nerim.net>
In-Reply-To: <4AA427E6.5000801@nerim.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Mon, Nov 23, 2009 at 12:24:46PM -0800, David Miller wrote:
> From: Josip Rodin <joy@entuzijast.net>
> Date: Sat, 31 Oct 2009 17:48:06 +0100
> 
> > No idea, I got stuck there and reverted to .28. Then the machine started
> > exhibiting some other issues so it was reverted to .26. :/
> 
> Sorry for dropping the ball on this one.
> 
> As promised long ago, here is a 2.6.31.6 kernel built with you
> 2.6.31 config file.  Let me know if it exhibits the bootup problem
> so we can diagnose further:
> 
> 	http://vger.kernel.org/~davem/josip_test_2631_6.img
> 
> Thanks!

It works! Compiler issue?

Here's the early portion of dmesg for the record:

boot: LinuxDaveM 
Allocated 8 Megs of memory at 0x40000000 for kernel
Loaded kernel version 2.6.31

PROMLIB: Sun IEEE Boot Prom 'OBP 4.11.4 2003/07/23 08:04'
PROMLIB: Root node compatible: 
Linux version 2.6.31.6 (davem@huronp11) (gcc version 4.2.4 (Ubuntu 4.2.4-1ubuntu3)) #2 SMP Mon Nov 23 12:18:05 PST 2009
console [earlyprom0] enabled
ARCH: SUN4U
Ethernet address: 00:03:ba:5a:53:a5
Kernel: Using 1 locked TLB entries for main kernel image.
Remapping the kernel... done.
OF stdout device is: /pci@1e,600000/isa@7/serial@0,3f8
PROM: Built device tree with 85818 bytes of memory.
Top of RAM: 0x123fedc000, Total RAM: 0xffed4000
Memory hole size: 70656MB
[0000000200000000-fffff80000400000] page_structs1072 node=0 entry=0/0
[0000000200000000-fffff80000800000] page_structs1072 node=0 entry=1/0
[0000000204000000-fffff80000c00000] page_structs1072 node=0 entry/0
[0000000204000000-fffff80001000000] page_structs1072 node=0 entry/0
[0000000220000000-fffff80001400000] page_structs1072 node=0 entry8/0
[0000000220000000-fffff80001800000] page_structs1072 node=0 entry9/0
[0000000224000000-fffff80001c00000] page_structs1072 node=0 entry4/0
[0000000224000000-fffff80002000000] page_structs1072 node=0 entry5/0
Zone PFN ranges:
  Normal   0x00000000 -> 0x0091ff6e
Movable zone start PFN for each node
early_node_map[7] active PFN ranges
    0: 0x00000000 -> 0x00020000
    0: 0x00100000 -> 0x00120000
    0: 0x00800000 -> 0x00820000
    0: 0x00900000 -> 0x0091f7ff
    0: 0x0091f800 -> 0x0091fef3
    0: 0x0091fef5 -> 0x0091ff60
    0: 0x0091ff61 -> 0x0091ff6e
Booting Linux...
Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 449387
Kernel command line: root=/dev/md1 ro md=0,/dev/sda1,/dev/sdb1 md=1,/dev/sda2,/dev/sdb2 md=2,/dev/sda4,/dev/sdb4
md: Will configure md0 (super-block) from /dev/sda1,/dev/sdb1, below.
md: Will configure md1 (super-block) from /dev/sda2,/dev/sdb2, below.
md: Will configure md2 (super-block) from /dev/sda4,/dev/sdb4, below.
PID hash table entries: 4096 (order: 12, 32768 bytes)
Dentry cache hash table entries: 524288 (order: 9, 4194304 bytes)
Inode-cache hash table entries: 262144 (order: 8, 2097152 bytes)
Memory: 4148904k available (2488k kernel code, 936k data, 192k init) [fffff80000000000,000000123fedc000]
NR_IRQS:255
clocksource: mult[535555] shift[16]
clockevent: mult[3126e97] shift[32]
Console: colour dummy device 80x25
console handover: boot [earlyprom0] -> real [tty0]
PROMLIB: Sun IEEE Boot Prom 'OBP 4.11.4 2003/07/23 08:04'
PROMLIB: Root node compatible: 
Linux version 2.6.31.6 (davem@huronp11) (gcc version 4.2.4 (Ubuntu 4.2.4-1ubuntu3)) #2 SMP Mon Nov 23 12:18:05 PST 2009
console [earlyprom0] enabled
ARCH: SUN4U
Ethernet address: 00:03:ba:5a:53:a5
Kernel: Using 1 locked TLB entries for main kernel image.
Remapping the kernel... done.
OF stdout device is: /pci@1e,600000/isa@7/serial@0,3f8
PROM: Built device tree with 85818 bytes of memory.
Top of RAM: 0x123fedc000, Total RAM: 0xffed4000
Memory hole size: 70656MB
[0000000200000000-fffff80000400000] page_structs1072 node=0 entry=0/0
[0000000200000000-fffff80000800000] page_structs1072 node=0 entry=1/0
[0000000204000000-fffff80000c00000] page_structs1072 node=0 entry/0
[0000000204000000-fffff80001000000] page_structs1072 node=0 entry/0
[0000000220000000-fffff80001400000] page_structs1072 node=0 entry8/0
[0000000220000000-fffff80001800000] page_structs1072 node=0 entry9/0
[0000000224000000-fffff80001c00000] page_structs1072 node=0 entry4/0
[0000000224000000-fffff80002000000] page_structs1072 node=0 entry5/0
Zone PFN ranges:
  Normal   0x00000000 -> 0x0091ff6e
Movable zone start PFN for each node
early_node_map[7] active PFN ranges
    0: 0x00000000 -> 0x00020000
    0: 0x00100000 -> 0x00120000
    0: 0x00800000 -> 0x00820000
    0: 0x00900000 -> 0x0091f7ff
    0: 0x0091f800 -> 0x0091fef3
    0: 0x0091fef5 -> 0x0091ff60
    0: 0x0091ff61 -> 0x0091ff6e
Booting Linux...
Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 449387
Kernel command line: root=/dev/md1 ro md=0,/dev/sda1,/dev/sdb1 md=1,/dev/sda2,/dev/sdb2 md=2,/dev/sda4,/dev/sdb4
md: Will configure md0 (super-block) from /dev/sda1,/dev/sdb1, below.
md: Will configure md1 (super-block) from /dev/sda2,/dev/sdb2, below.
md: Will configure md2 (super-block) from /dev/sda4,/dev/sdb4, below.
PID hash table entries: 4096 (order: 12, 32768 bytes)
Dentry cache hash table entries: 524288 (order: 9, 4194304 bytes)
Inode-cache hash table entries: 262144 (order: 8, 2097152 bytes)
Memory: 4148904k available (2488k kernel code, 936k data, 192k init) [fffff80000000000,000000123fedc000]
NR_IRQS:255
clocksource: mult[535555] shift[16]
clockevent: mult[3126e97] shift[32]
Console: colour dummy device 80x25
console handover: boot [earlyprom0] -> real [tty0]
Calibrating delay using timer specific routine.. 24.01 BogoMIPS (lpjH029)
Mount-cache hash table entries: 512
CPU 0: synchronized TICK with master CPU (last diff 0 cycles, maxerr 6 cycles)
Brought up 2 CPUs
NET: Registered protocol family 16
Testing NMI watchdog ... OK.
/pci@1f,700000: TOMATILLO PCI Bus Module ver[4:0]
/pci@1f,700000: PCI IO[7f601000000] MEM[7f700000000]
PCI: Scanning PBM /pci@1f,700000
pci 0000:00:02.0: PME# supported from D3hot
pci 0000:00:02.0: PME# disabled
pci 0000:00:02.1: PME# supported from D3hot
pci 0000:00:02.1: PME# disabled
/pci@1e,600000: TOMATILLO PCI Bus Module ver[4:0]
/pci@1e,600000: PCI IO[7fe01000000] MEM[7ff00000000]
PCI: Scanning PBM /pci@1e,600000
pci 0001:00:06.0: quirk: region 0800-083f claimed by ali7101 ACPI
pci 0001:00:06.0: quirk: region 0600-061f claimed by ali7101 SMB
pci 0001:00:0a.0: PME# supported from D3cold
pci 0001:00:0a.0: PME# disabled
pci 0001:00:02.0: PME# supported from D0 D2 D3hot
pci 0001:00:02.0: PME# disabled
pci 0001:00:02.1: PME# supported from D0 D2 D3hot
pci 0001:00:02.1: PME# disabled
/pci@1c,600000: TOMATILLO PCI Bus Module ver[4:0]
/pci@1c,600000: PCI IO[7ce01000000] MEM[7cf00000000]
PCI: Scanning PBM /pci@1c,600000
/pci@1d,700000: TOMATILLO PCI Bus Module ver[4:0]
/pci@1d,700000: PCI IO[7c601000000] MEM[7c700000000]
PCI: Scanning PBM /pci@1d,700000
pci 0003:00:02.0: PME# supported from D3hot
pci 0003:00:02.0: PME# disabled
pci 0003:00:02.1: PME# supported from D3hot
pci 0003:00:02.1: PME# disabled
bio: create slab <bio-0> at 0
SCSI subsystem initialized
/pci@1e,600000/isa@7/rtc@0,70: RTC regs at 0x7fe01000070
NET: Registered protocol family 2
IP route cache hash table entries: 131072 (order: 7, 1048576 bytes)
TCP established hash table entries: 524288 (order: 10, 8388608 bytes)
TCP bind hash table entries: 65536 (order: 7, 1048576 bytes)
TCP: Hash tables configured (established 524288 bind 65536)
TCP reno registered
NET: Registered protocol family 1
power: Control reg at 7fe01000800
chmc: UltraSPARC-IIIi memory controller at /memory-controller@0,0
chmc: UltraSPARC-IIIi memory controller at /memory-controller@1,0
msgmni has been set to 8104
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered (default)
pci 0001:00:07.0: Activating ISA DMA hang workarounds
f00990ec: ttyS0 at MMIO 0x7fe010003f8 (irq = 15) is a 16550A
Console: ttyS0 (SU)
console [ttyS0] enabled
f009ab54: ttyS1 at MMIO 0x7fe010002e8 (irq = 15) is a 16550A
brd: module loaded
loop: module loaded
sym0: <1010-66> rev 0x1 at pci 0002:00:02.0 irq 25
sym0: No NVRAM, ID 7, Fast-80, LVD, parity checking
sym0: SCSI BUS has been reset.
scsi0 : sym-2.2.3
scsi 0:0:0:0: Direct-Access     SEAGATE  ST336607LSUN36G  0507 PQ: 0 ANSI: 3
 target0:0:0: tagged command queuing enabled, command queue depth 16.
 target0:0:0: Beginning Domain Validation
 target0:0:0: FAST-80 WIDE SCSI 160.0 MB/s DT (12.5 ns, offset 31)
 target0:0:0: Ending Domain Validation
scsi 0:0:1:0: Direct-Access     SEAGATE  ST336607LSUN36G  0507 PQ: 0 ANSI: 3
 target0:0:1: tagged command queuing enabled, command queue depth 16.
 target0:0:1: Beginning Domain Validation
 target0:0:1: FAST-80 WIDE SCSI 160.0 MB/s DT (12.5 ns, offset 31)
 target0:0:1: Ending Domain Validation
scsi 0:0:2:0: Direct-Access     SEAGATE  ST373307LC       0003 PQ: 0 ANSI: 3
 target0:0:2: tagged command queuing enabled, command queue depth 16.
 target0:0:2: Beginning Domain Validation
 target0:0:2: FAST-80 WIDE SCSI 160.0 MB/s DT (12.5 ns, offset 31)
 target0:0:2: Ending Domain Validation
scsi 0:0:3:0: Direct-Access     SEAGATE  ST373307LC       0003 PQ: 0 ANSI: 3
 target0:0:3: tagged command queuing enabled, command queue depth 16.
 target0:0:3: Beginning Domain Validation
 target0:0:3: FAST-80 WIDE SCSI 160.0 MB/s DT (12.5 ns, offset 31)
 target0:0:3: Ending Domain Validation
sym1: <1010-66> rev 0x1 at pci 0002:00:02.1 irq 26
sym1: No NVRAM, ID 7, Fast-80, LVD, parity checking
sym1: SCSI BUS has been reset.
scsi1 : sym-2.2.3
sd 0:0:0:0: [sda] 71132959 512-byte logical blocks: (36.4 GB/33.9 GiB)
mice: PS/2 mouse device common for all mice
sd 0:0:1:0: [sdb] 71132959 512-byte logical blocks: (36.4 GB/33.9 GiB)
sd 0:0:0:0: [sda] Write Protect is off
sd 0:0:2:0: [sdc] 143374744 512-byte logical blocks: (73.4 GB/68.3 GiB)
sd 0:0:3:0: [sdd] 143374744 512-byte logical blocks: (73.4 GB/68.3 GiB)
sd 0:0:1:0: [sdb] Write Protect is off
sd 0:0:2:0: [sdc] Write Protect is off
sd 0:0:0:0: [sda] Write cache: disabled, read cache: enabled, supports DPO and FUA
sd 0:0:1:0: [sdb] Write cache: disabled, read cache: enabled, supports DPO and FUA
sd 0:0:2:0: [sdc] Write cache: enabled, read cache: enabled, supports DPO and FUA
 sdc:
 sda:
 sdb: sdb1 sdb2 sdb3 sdb4 sdb5
 sda1 sda2 sda3 sda4 sda5
 sdc1 sdc3
rtc_cmos rtc_cmos: rtc core: registered rtc_cmos as rtc0
sd 0:0:2:0: [sdc] Attached SCSI disk
sd 0:0:0:0: [sda] Attached SCSI disk
sd 0:0:1:0: [sdb] Attached SCSI disk
sd 0:0:3:0: [sdd] Write Protect is off
sd 0:0:3:0: [sdd] Write cache: enabled, read cache: enabled, supports DPO and FUA
rtc0: no alarms, 114 bytes nvram
md: raid1 personality registered for level 1
TCP cubic registered
NET: Registered protocol family 17
rtc_cmos rtc_cmos: setting system clock to 2009-11-23 22:27:15 UTC (1259015235)
 sdd: sdd1 sdd3
sd 0:0:3:0: [sdd] Attached SCSI disk
md: Waiting for all devices to be available before autodetect
md: If you don't use raid, use raid=noautodetect
md: Autodetecting RAID arrays.
md: Scanned 8 and added 8 devices.
md: autorun ...
md: considering sdd1 ...
[...]

-- 
     2. That which causes joy or happiness.
