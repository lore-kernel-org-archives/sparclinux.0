From: Heinz Mauelshagen <heinzm@redhat.com>
Date: Fri, 18 Nov 2011 11:20:02 +0000
Subject: bug report: 3.1.0-rc4 doesn't discover my FC drives
Message-Id: <1321615202.27056.10.camel@o>
List-Id: <sparclinux.vger.kernel.org>
References: <1315419505.1068.43.camel@o.ww.redhat.com>
In-Reply-To: <1315419505.1068.43.camel@o.ww.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org


I'm not able to discover any FC-drives on my E6500
(same drives get discovered on an Intel box) with 3.1.0-rc4.

Is this a known issue?
Wrong driver?
Any hints to analyze further?

Thanks,
Heinz

# lssbus=20
0: SCSI Controller: Sun Swift (ESP)
1: Network Controller: Sun Happy Meal Ethernet
2: SCSI Controller: QLogic ISP
3: SCSI Controller: Sun Enterprise Network Array

# dmesg|grep qlogicpti
qlogicpti0: IRQ 11 SCSI ID 7 (Firmware v1.31.32)(FCode 1.25 96/10/15)
qlogicpti0: [Ultra Wide, using differential interface]

# dmesg|grep -i sbus
eth0: HAPPY MEAL (SBUS) 10/100baseT Ethernet 08:00:20:c9:c2:51
eth1: Quattro HME slot 0 (SBUS) 10/100baseT Ethernet 08:00:20:cc:da:ac
eth2: Quattro HME slot 1 (SBUS) 10/100baseT Ethernet 08:00:20:cc:da:ad
eth3: Quattro HME slot 2 (SBUS) 10/100baseT Ethernet 08:00:20:cc:da:ae
eth4: Quattro HME slot 3 (SBUS) 10/100baseT Ethernet 08:00:20:cc:da:af
scsi1 : PTI Qlogic,ISP SBUS SCSI irq 11 regs at 000001c520010000

# dmesg
PROMLIB: Sun IEEE Boot Prom 'OBP 3.2.30 2002/10/25 14:03'
PROMLIB: Root node compatible:=20
Initializing cgroup subsys cpuset
Initializing cgroup subsys cpu
Linux version 3.1.0-rc4+ (mauelsha@s6500.ww.redhat.com) (gcc version
4.4.4 20100726 (Red Hat 4.4.4-14) (GCC) ) #15 SMP Tue Sep 6 15:54:43
CEST 2011
bootconsole [earlyprom0] enabled
ARCH: SUN4U
Ethernet address: 08:00:20:c9:c2:51
Kernel: Using 2 locked TLB entries for main kernel image.
Remapping the kernel... done.
OF stdout device is: /central@1f,0/fhc@0,f8800000/zs@0,902000:a
PROM: Built device tree with 114950 bytes of memory.
Top of RAM: 0x47fd14000, Total RAM: 0x47f412000
Memory hole size: 9MB
[0000010000000000-fffff80000c00000] page_structs=131072 node=3D0
entry=3D0/8192
[0000010000000000-fffff80001000000] page_structs=131072 node=3D0
entry=3D1/8192
[0000010000800000-fffff80001400000] page_structs=131072 node=3D0
entry=3D2/8192
[0000010000800000-fffff80001800000] page_structs=131072 node=3D0
entry=3D3/8192
[0000010001000000-fffff80001c00000] page_structs=131072 node=3D0
entry=3D4/8192
[0000010001000000-fffff80002000000] page_structs=131072 node=3D0
entry=3D5/8192
[0000010001800000-fffff80002400000] page_structs=131072 node=3D0
entry=3D6/8192
[0000010001800000-fffff80002800000] page_structs=131072 node=3D0
entry=3D7/8192
[0000010002000000-fffff80002c00000] page_structs=131072 node=3D0
entry=3D8/8192
[0000010002000000-fffff80003000000] page_structs=131072 node=3D0
entry=3D9/8192
[0000010002800000-fffff80003400000] page_structs=131072 node=3D0
entry=10/8192
[0000010002800000-fffff80003800000] page_structs=131072 node=3D0
entry=11/8192
[0000010003000000-fffff80003c00000] page_structs=131072 node=3D0
entry=12/8192
[0000010003000000-fffff80004000000] page_structs=131072 node=3D0
entry=13/8192
[0000010003800000-fffff80005c00000] page_structs=131072 node=3D0
entry=14/8192
[0000010003800000-fffff80006000000] page_structs=131072 node=3D0
entry=15/8192
[0000010004000000-fffff80006400000] page_structs=131072 node=3D0
entry=16/8192
[0000010004000000-fffff80006800000] page_structs=131072 node=3D0
entry=17/8192
[0000010004800000-fffff80006c00000] page_structs=131072 node=3D0
entry=18/8192
[0000010004800000-fffff80007000000] page_structs=131072 node=3D0
entry=19/8192
[0000010005000000-fffff80007400000] page_structs=131072 node=3D0
entry /8192
[0000010005000000-fffff80007800000] page_structs=131072 node=3D0
entry!/8192
[0000010005800000-fffff80007c00000] page_structs=131072 node=3D0
entry"/8192
[0000010005800000-fffff80008000000] page_structs=131072 node=3D0
entry#/8192
[0000010006000000-fffff80008400000] page_structs=131072 node=3D0
entry$/8192
[0000010006000000-fffff80008800000] page_structs=131072 node=3D0
entry%/8192
[0000010006800000-fffff80008c00000] page_structs=131072 node=3D0
entry&/8192
[0000010006800000-fffff80009000000] page_structs=131072 node=3D0
entry'/8192
[0000010007000000-fffff80009400000] page_structs=131072 node=3D0
entry(/8192
[0000010007000000-fffff80009800000] page_structs=131072 node=3D0
entry)/8192
[0000010007800000-fffff80009c00000] page_structs=131072 node=3D0
entry0/8192
[0000010007800000-fffff8000a000000] page_structs=131072 node=3D0
entry1/8192
[0000010008000000-fffff8000a400000] page_structs=131072 node=3D0
entry2/8192
[0000010008000000-fffff8000a800000] page_structs=131072 node=3D0
entry3/8192
[0000010008800000-fffff8000ac00000] page_structs=131072 node=3D0
entry4/8192
[0000010008800000-fffff8000b000000] page_structs=131072 node=3D0
entry5/8192
Zone PFN ranges:
  Normal   0x00000000 -> 0x0023fe8a
Movable zone start PFN for each node
early_node_map[3] active PFN ranges
    0: 0x00000000 -> 0x0023f987
    0: 0x0023fe00 -> 0x0023fe77
    0: 0x0023fe7f -> 0x0023fe8a
On node 0 totalpages: 2357769
  Normal zone: 18430 pages used for memmap
  Normal zone: 0 pages reserved
  Normal zone: 2339339 pages, LIFO batch:15
Booting Linux...
CPU CAPS: [flush,stbar,swap,muldiv,v9,mul32,div32,v8plus]
CPU CAPS: [vis]
PERCPU: Embedded 6 pages/cpu @fffff8000b400000 s20480 r8192 d20480
u262144
pcpu-alloc: s20480 r8192 d20480 u262144 alloc=3D1*4194304
pcpu-alloc: [0] 00 01 04 05 08 09 12 13 16 17 20 21 24 25 28 29=20
Built 1 zonelists in Node order, mobility grouping on.  Total pages:
2339339
Policy zone: Normal
Kernel command line: ro LANG=3Den_US.UTF-8 SYSFONT=3Dlatarcyrheb-sun16
KEYTABLE=3Dus root=3DUUID=C7452451-51e8-4775-93d2-baa3079ed926
console=3DttyS0,9600 rdinfo rdshell
PID hash table entries: 4096 (order: 2, 32768 bytes)
Memory: 18681392k available (4424k kernel code, 2144k data, 392k init)
[fffff80000000000,000000047fd14000]
SLUB: Genslabs=16, HWalign2, Order=3D0-3, MinObjects=3D0, CPUs0,
Nodes=16
Hierarchical RCU implementation.
NR_IRQS:255
clocksource: mult[2800000] shift[24]
clockevent: mult[66666666] shift[32]
Console: colour dummy device 80x25
allocated 75497472 bytes of page_cgroup
please try 'cgroup_disable=3Dmemory' option if you don't want memory
cgroups
Calibrating delay using timer specific routine.. 801.61 BogoMIPS
(lpj@08098)
pid_max: default: 32768 minimum: 301
Security Framework initialized
SELinux:  Initializing.
SELinux:  Starting in permissive mode
Dentry cache hash table entries: 4194304 (order: 12, 33554432 bytes)
Inode-cache hash table entries: 2097152 (order: 11, 16777216 bytes)
Mount-cache hash table entries: 512
Initializing cgroup subsys cpuacct
Initializing cgroup subsys memory
Initializing cgroup subsys devices
Initializing cgroup subsys freezer
Initializing cgroup subsys net_cls
ftrace: allocating 15974 entries in 32 pages
Performance events: No support for PMU type 'ultra12'
CPU 1: synchronized TICK with master CPU (last diff -17 cycles, maxerr
847 cycles)
CPU 4: synchronized TICK with master CPU (last diff -17 cycles, maxerr
844 cycles)
CPU 5: synchronized TICK with master CPU (last diff -27 cycles, maxerr
824 cycles)
CPU 8: synchronized TICK with master CPU (last diff -2 cycles, maxerr
811 cycles)
CPU 9: synchronized TICK with master CPU (last diff -17 cycles, maxerr
847 cycles)
CPU 12: synchronized TICK with master CPU (last diff -2 cycles, maxerr
811 cycles)
CPU 13: synchronized TICK with master CPU (last diff -38 cycles,
maxerrI'm not able to discover any FC-drives on my E6500
(same drives get discovered on an Intel box) with 3.1.0-rc4.

Is this a known issue?
Any hints to analyze further?

Thanks,
Heinz

# lssbus=20
0: SCSI Controller: Sun Swift (ESP)
1: Network Controller: Sun Happy Meal Ethernet
2: SCSI Controller: QLogic ISP
3: SCSI Controller: Sun Enterprise Network Array

# dmesg|grep qlogicpti
qlogicpti0: IRQ 11 SCSI ID 7 (Firmware v1.31.32)(FCode 1.25 96/10/15)
qlogicpti0: [Ultra Wide, using differential interface]

# dmesg|grep -i sbus
eth0: HAPPY MEAL (SBUS) 10/100baseT Ethernet 08:00:20:c9:c2:51
eth1: Quattro HME slot 0 (SBUS) 10/100baseT Ethernet 08:00:20:cc:da:ac
eth2: Quattro HME slot 1 (SBUS) 10/100baseT Ethernet 08:00:20:cc:da:ad
eth3: Quattro HME slot 2 (SBUS) 10/100baseT Ethernet 08:00:20:cc:da:ae
eth4: Quattro HME slot 3 (SBUS) 10/100baseT Ethernet 08:00:20:cc:da:af
scsi1 : PTI Qlogic,ISP SBUS SCSI irq 11 regs at 000001c520010000 842
cycles)
CPU 16: synchronized TICK with master CPU (last diff -2 cycles, maxerr
811 cycles)
CPU 17: synchronized TICK with master CPU (last diff -20 cycles, maxerr
845 cycles)
CPU 20: synchronized TICK with master CPU (last diff -2 cycles, maxerr
811 cycles)
CPU 21: synchronized TICK with master CPU (last diff -18 cycles, maxerr
845 cycles)
CPU 24: synchronized TICK with master CPU (last diff -2 cycles, maxerr
811 cycles)
CPU 25: synchronized TICK with master CPU (last diff -20 cycles, maxerr
845 cycles)
CPU 28: synchronized TICK with master CPU (last diff -2 cycles, maxerr
811 cycles)
CPU 29: synchronized TICK with master CPU (last diff -17 cycles, maxerr
844 cycles)
Brought up 16 CPUs
devtmpfs: initialized
print_constraints: dummy:=20
NET: Registered protocol family 16
fhc: Board #1, Version[1] PartID[fa0] Manuf[3e] (Central)
fhc: Board #0, Version[1] PartID[fa0] Manuf[3e] (JTAG Master)
fhc: Board #2, Version[1] PartID[fa0] Manuf[3e]=20
fhc: Board #4, Version[1] PartID[fa0] Manuf[3e]=20
fhc: Board #6, Version[1] PartID[fa0] Manuf[3e]=20
fhc: Board #8, Version[1] PartID[fa0] Manuf[3e]=20
fhc: Board #10, Version[1] PartID[fa0] Manuf[3e]=20
fhc: Board #12, Version[1] PartID[fa0] Manuf[3e]=20
fhc: Board #14, Version[1] PartID[fa0] Manuf[3e]=20
fhc: Board #1, Version[1] PartID[fa0] Manuf[3e]=20
clock_board: Detected 16 slot Enterprise system.
SYSIO: UPA portID ffffffff, at 000001c400000000
SYSIO: UPA portID ffffffff, at 000001c600000000
bio: create slab <bio-0> at 0
vgaarb: loaded
SCSI subsystem initialized
NetLabel: Initializing
NetLabel:  domain hash size =3D 128
NetLabel:  protocols =3D UNLABELED CIPSOv4
NetLabel:  unlabeled traffic allowed by default
/central/fhc@0,f8800000/eeprom@0,908000: Mostek regs at 0x1fff8908000
Switching to clocksource tick
Switched to NOHz mode on CPU #5
Switched to NOHz mode on CPU #4
Switched to NOHz mode on CPU #1
Switched to NOHz mode on CPU #0
Switched to NOHz mode on CPU #28
Switched to NOHz mode on CPU #24
Switched to NOHz mode on CPU #20
Switched to NOHz mode on CPU #16
Switched to NOHz mode on CPU #25
Switched to NOHz mode on CPU #21
Switched to NOHz mode on CPU #12
Switched to NOHz mode on CPU #17
Switched to NOHz mode on CPU #13
Switched to NOHz mode on CPU #9
Switched to NOHz mode on CPU #8
Switched to NOHz mode on CPU #29
NET: Registered protocol family 2
IP route cache hash table entries: 524288 (order: 9, 4194304 bytes)
TCP established hash table entries: 524288 (order: 10, 8388608 bytes)
TCP bind hash table entries: 65536 (order: 7, 1048576 bytes)
TCP: Hash tables configured (established 524288 bind 65536)
TCP reno registered
UDP hash table entries: 16384 (order: 6, 524288 bytes)
UDP-Lite hash table entries: 16384 (order: 6, 524288 bytes)
NET: Registered protocol family 1
PCI: CLS 0 bytes, default 64
Trying to unpack rootfs image as initramfs...
Freeing initrd memory: 23781k freed
audit: initializing netlink socket (disabled)
type 00 audit(7.100:1): initialized
HugeTLB registered 4 MB page size, pre-allocated 0 pages
VFS: Disk quotas dquot_6.5.2
Dquot-cache hash table entries: 1024 (order 0, 8192 bytes)
msgmni has been set to 32768
SELinux:  Registering netfilter hooks
Block layer SCSI generic (bsg) driver version 0.4 loaded (major 253)
io scheduler noop registered
io scheduler deadline registered
io scheduler cfq registered (default)
f005de3c: ttyS0 at MMIO 0x1fff8902000 (irq =3D 2) is a zs (ESCC)
Console: ttyS0 (SunZilog zs0)
console [ttyS0] enabled, bootconsole disabled
f005de3c: ttyS1 at MMIO 0x1fff8902004 (irq =3D 2) is a zs (ESCC)
f005df14: Keyboard at MMIO 0x1fff8904000 (irq =3D 2) is a zs
f005df14: Mouse at MMIO 0x1fff8904004 (irq =3D 2) is a zs
brd: module loaded
loop: module loaded
esp: esp0, regs[1c738810000:1c738800000] irq[19]
esp: esp0 is a FASHME, 40 MHz (ccf=3D0), SCSI ID 7
scsi0 : esp
Fixed MDIO Bus: probed
sunhme.c:v3.10 August 26, 2008 David S. Miller (davem@davemloft.net)
eth0: HAPPY MEAL (SBUS) 10/100baseT Ethernet 08:00:20:c9:c2:51
eth1: Quattro HME slot 0 (SBUS) 10/100baseT Ethernet 08:00:20:cc:da:ac
eth2: Quattro HME slot 1 (SBUS) 10/100baseT Ethernet 08:00:20:cc:da:ad
eth3: Quattro HME slot 2 (SBUS) 10/100baseT Ethernet 08:00:20:cc:da:ae
eth4: Quattro HME slot 3 (SBUS) 10/100baseT Ethernet 08:00:20:cc:da:af
mousedev: PS/2 mouse device common for all mice
rtc-m48t59 rtc-m48t59.0: rtc core: registered m48t59 as rtc0
device-mapper: uevent: version 1.0.3
device-mapper: ioctl: 4.21.0-ioctl (2011-07-06) initialised:
dm-devel@redhat.com
nf_conntrack version 0.5.0 (16384 buckets, 65536 max)
ip_tables: (C) 2000-2006 Netfilter Core Team
TCP cubic registered
NET: Registered protocol family 17
Registering the dns_resolver key type
registered taskstats version 1
scsi: waiting for bus probes to complete ...
scsi 0:0:5:0: Sequential-Access HP       C1537A           L706 PQ: 0
ANSI: 2
scsi target0:0:5: Beginning Domain Validation
scsi target0:0:5: FAST-10 SCSI 10.0 MB/s ST (100 ns, offset 15)
scsi target0:0:5: Domain Validation skipping write tests
scsi target0:0:5: Ending Domain Validation
scsi 0:0:6:0: CD-ROM            TOSHIBA  DVD-ROM SD-M1401 1007 PQ: 0
ANSI: 2
scsi target0:0:6: Beginning Domain Validation
scsi target0:0:6: FAST-10 SCSI 10.0 MB/s ST (100 ns, offset 15)
scsi target0:0:6: Domain Validation skipping write tests
scsi target0:0:6: Ending Domain Validation
scsi 0:0:10:0: Direct-Access     SEAGATE  SX318203LC       B90C PQ: 0
ANSI: 2
scsi target0:0:10: Beginning Domain Validation
scsi target0:0:10: FAST-10 WIDE SCSI 20.0 MB/s ST (100 ns, offset 15)
scsi target0:0:10: Domain Validation skipping write tests
scsi target0:0:10: Ending Domain Validation
scsi 0:0:11:0: Direct-Access     IBM      DNES30917SUN9.0G SAD0 PQ: 0
ANSI: 3
scsi target0:0:11: Beginning Domain Validation
scsi target0:0:11: FAST-10 WIDE SCSI 20.0 MB/s ST (100 ns, offset 5)
scsi target0:0:11: Domain Validation skipping write tests
scsi target0:0:11: Ending Domain Validation
scsi 0:0:5:0: Attached scsi generic sg0 type 1
sr0: scsi3-mmc drive: 40x/40x cd/rw xa/form2 cdda tray
cdrom: Uniform CD-ROM driver Revision: 3.20
sr 0:0:6:0: Attached scsi CD-ROM sr0
sr 0:0:6:0: Attached scsi generic sg1 type 5
sd 0:0:10:0: Attached scsi generic sg2 type 0
sd 0:0:10:0: [sda] 35566480 512-byte logical blocks: (18.2 GB/16.9 GiB)
sd 0:0:11:0: Attached scsi generic sg3 type 0
sd 0:0:10:0: [sda] Write Protect is off
sd 0:0:10:0: [sda] Mode Sense: cb 00 10 08
rtc-m48t59 rtc-m48t59.0: setting system clock to 2011-09-07 09:08:35 UTC
(1315386515)
sd 0:0:11:0: [sdb] 17689267 512-byte logical blocks: (9.05 GB/8.43 GiB)
sd 0:0:11:0: [sdb] Write Protect is off
sd 0:0:11:0: [sdb] Mode Sense: f3 00 00 08
sd 0:0:10:0: [sda] Write cache: disabled, read cache: enabled, supports
DPO and FUA
sd 0:0:11:0: [sdb] Write cache: disabled, read cache: enabled, doesn't
support DPO or FUA
Initializing network drop monitor service
 sda: sda1 sda2 sda3 sda4
sd 0:0:10:0: [sda] Attached SCSI disk
 sdb: sdb1 sdb2 sdb3 sdb8
sd 0:0:11:0: [sdb] Attached SCSI disk
dracut: dracut-005-2.fc12
udev: starting version 145
udevd (120): /proc/120/oom_adj is deprecated, please
use /proc/120/oom_score_adj instead.
dracut: Starting plymouth daemon
ioctl32(plymouthd:149): Unknown cmd fd(11) cmd(00004b70){t:'K';sz:0}
arg(00030e38) on /dev/ttyS0
qpti_sbus_probe 1
qpti_sbus_probe 2
qpti_sbus_probe 2a
qpti_sbus_probe 3qlogicpti0: IRQ 11=20
qpti_sbus_probe 4SCSI ID 7=20
qpti_sbus_probe 5
qpti_sbus_probe 6
qpti_sbus_probe 7
qpti_sbus_probe 8
(Firmware v1.31.32)
(FCode 1.25 96/10/15)

qlogicpti0: [Ultra Wide, using differential interface]
scsi1 : PTI Qlogic,ISP SBUS SCSI irq 11 regs at 000001c520010000
qpti_sbus_probe 9
kjournald starting.  Commit interval 5 seconds
EXT3-fs (sda4): mounted filesystem with ordered data mode
dracut: Mounted root filesystem /dev/sda4
dracut: Loading SELinux policy
type=1404 audit(1315386519.390:2): enforcing=3D1 old_enforcing=3D0
auidB94967295 sesB94967295
SELinux: 2048 avtab hash slots, 165056 rules.
SELinux: 2048 avtab hash slots, 165056 rules.
SELinux:  8 users, 12 roles, 3133 types, 158 bools, 1 sens, 1024 cats
SELinux:  77 classes, 165056 rules44
SELinux:  Permission read_policy in class security not defined in
policy.
SELinux:  Permission audit_access in class file not defined in policy.
SELinux:  Permission audit_access in class dir not defined in policy.
SELinux:  Permission execmod in class dir not defined in policy.
SELinux:  Permission audit_access in class lnk_file not defined in
policy.
SELinux:  Permission open in class lnk_file not defined in policy.
SELinux:  Permission execmod in class lnk_file not defined in policy.
SELinux:  Permission audit_access in class chr_file not defined in
policy.
SELinux:  Permission audit_access in class blk_file not defined in
policy.
SELinux:  Permission execmod in class blk_file not defined in policy.
SELinux:  Permission audit_access in class sock_file not defined in
policy.
SELinux:  Permission execmod in class sock_file not defined in policy.
SELinux:  Permission audit_access in class fifo_file not defined in
policy.
SELinux:  Permission execmod in class fifo_file not defined in policy.
SELinux:  Permission syslog in class capability2 not defined in policy.
SELinux: the above unknown classes and permissions will be allowed
SELinux:  Completing initialization.
SELinux:  Setting up existing superblocks.
SELinux: initialized (dev sysfs, type sysfs), uses genfs_contexts
SELinux: initialized (dev rootfs, type rootfs), uses genfs_contexts
SELinux: initialized (dev bdev, type bdev), uses genfs_contexts
SELinux: initialized (dev proc, type proc), uses genfs_contexts
SELinux: initialized (dev tmpfs, type tmpfs), uses transition SIDs
SELinux: initialized (dev devtmpfs, type devtmpfs), uses transition SIDs
SELinux: initialized (dev debugfs, type debugfs), uses genfs_contexts
SELinux: initialized (dev sockfs, type sockfs), uses task SIDs
SELinux: initialized (dev pipefs, type pipefs), uses task SIDs
SELinux: initialized (dev anon_inodefs, type anon_inodefs), uses
genfs_contexts
SELinux: initialized (dev devpts, type devpts), uses transition SIDs
SELinux: initialized (dev hugetlbfs, type hugetlbfs), uses transition
SIDs
SELinux: initialized (dev mqueue, type mqueue), uses transition SIDs
SELinux: initialized (dev selinuxfs, type selinuxfs), uses
genfs_contexts
SELinux: initialized (dev sysfs, type sysfs), uses genfs_contexts
SELinux: initialized (dev tmpfs, type tmpfs), uses transition SIDs
SELinux: initialized (dev sda4, type ext3), uses xattr
type=1403 audit(1315386523.160:3): policy loaded auidB94967295
sesB94967295
dracut: Switching root
udev: starting version 145
input: Sun Mouse
as /devices/root/f005da70/f005db8c/f005df14/serio1/input/input0
st: Version 20101219, fixed bufsize 32768, s/g segs 256
st 0:0:5:0: Attached scsi tape st0
st 0:0:5:0: st0: try direct i/o: yes (alignment 4 B)
osst :I: Tape driver with OnStream support version 0.99.4
osst :I: $Id: osst.c,v 1.73 2005/01/01 21:13:34 wriede Exp $
device-mapper: multipath: version 1.3.0 loaded
EXT3-fs (sda4): using internal journal
kjournald starting.  Commit interval 5 seconds
EXT3-fs (sda1): using internal journal
EXT3-fs (sda1): mounted filesystem with ordered data mode
SELinux: initialized (dev sda1, type ext3), uses xattr
Adding 151544k swap on /dev/sda2.  Priority:-1 extents:1 across:151544k=20
SELinux: initialized (dev binfmt_misc, type binfmt_misc), uses
genfs_contexts
NET: Registered protocol family 10
eth0: Link is up using internal transceiver at 100Mb/s, Full Duplex.
eth0: no IPv6 routers present
RPC: Registered named UNIX socket transport module.
RPC: Registered udp transport module.
RPC: Registered tcp transport module.
RPC: Registered tcp NFSv4.1 backchannel transport module.
SELinux: initialized (dev rpc_pipefs, type rpc_pipefs), uses
genfs_contexts
sr 0:0:6:0: [sr0]  Result: hostbyte=3DDID_OK driverbyte=3DDRIVER_SENSE
sr 0:0:6:0: [sr0]  Sense Key : Illegal Request [current]=20
sr 0:0:6:0: [sr0]  Add. Sense: Illegal mode for this track
sr 0:0:6:0: [sr0] CDB: Read(10): 28 00 00 15 ad d0 00 00 10 00
end_request: I/O error, dev sr0, sector 1420752
Buffer I/O error on device sr0, logical block 88797


