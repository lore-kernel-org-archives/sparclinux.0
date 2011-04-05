From: Hermann Lauer <Hermann.Lauer@iwr.uni-heidelberg.de>
Date: Tue, 05 Apr 2011 15:20:21 +0000
Subject: Re: linux-image-2.6.26-1-sparc64-smp: [sparc] SunFire480R cassini network driver kernel panic
Message-Id: <20110405152021.GD10479@lemon.iwr.uni-heidelberg.de>
List-Id: <sparclinux.vger.kernel.org>
References: <20100113082925.GA15798@lemon.iwr.uni-heidelberg.de>
In-Reply-To: <20100113082925.GA15798@lemon.iwr.uni-heidelberg.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org

On Mon, Apr 04, 2011 at 07:07:02PM +0200, Frans van Berckel wrote:
> On Mon, 2011-04-04 at 17:17 +0200, Hermann Lauer wrote:
> > Unfortunately squeeze provided kernels are not booting on V880/V480
> > systems (hangs at boot, log files are available on request).=20
> >=20
> > Will try install boots from testing when time permits.
> > Or are there other tftpbootable images I could/should try ?
> >=20
> > Thats the major issue here at the moment, cassini has to wait...
>=20
> Have you seen the 'Daily Builds' are back in business again?
>=20
> http://d-i.debian.org/daily-images/sparc/daily/

Tried that now (thanks for the hint), boot hangs after output below.
Any ideas for debugging ?

Thanks,
  Hermann

Sun Fire 480R, No Keyboard
Copyright 2007 Sun Microsystems, Inc.  All rights reserved.
OpenBoot 4.22.34, 16384 MB memory installed, Serial #...
Ethernet address ..., Host ID: ...

{2} ok boot gem:dhcp -p=20
Boot device: /pci@8,600000/network@2:dhcp  File and args: -p
Timed out waiting for BOOTP/DHCP reply
Timed out waiting for BOOTP/DHCP reply
Timed out waiting for BOOTP/DHCP reply
|
[    0.000000] PROMLIB: Sun IEEE Boot Prom 'OBP 4.22.34 2007/07/23 13:01'
[    0.000000] PROMLIB: Root node compatible:=20
[    0.000000] Initializing cgroup subsys cpuset
[    0.000000] Initializing cgroup subsys cpu
[    0.000000] Linux version 2.6.37-2-sparc64 (Debian 2.6.37-2) (ben@decade=
nt.org.uk) (gcc version 4.4.5 (Debian 4.4.5-12) ) #1 Sun Feb 27 11:28:28 UT=
C 2011
[    0.000000] bootconsole [earlyprom0] enabled
[    0.000000] ARCH: SUN4U
[    0.000000] Ethernet address: 00:03:ba:29:7c:9f
[    0.000000] Kernel: Using 2 locked TLB entries for main kernel image.
[    0.000000] Remapping the kernel... done.
[    0.000000] OF stdout device is: /pci@9,700000/ebus@1/serial@1,400000:a
[    0.000000] PROM: Built device tree with 104323 bytes of memory.
[    0.000000] Top of RAM: 0xa3ffb22000, Total RAM: 0x3ffad6000
[    0.000000] Memory hole size: 655360MB
[    0.000000] [0000010140000000-fffff8a000c00000] page_structs=131072 node=
=3D0 entry=1280/8192
[    0.000000] [0000010140000000-fffff8a001000000] page_structs=131072 node=
=3D0 entry=1281/8192
[    0.000000] [0000010140800000-fffff8a001400000] page_structs=131072 node=
=3D0 entry=1282/8192
[    0.000000] [0000010140800000-fffff8a001800000] page_structs=131072 node=
=3D0 entry=1283/8192
[    0.000000] [0000010141000000-fffff8a001c00000] page_structs=131072 node=
=3D0 entry=1284/8192
[    0.000000] [0000010141000000-fffff8a002000000] page_structs=131072 node=
=3D0 entry=1285/8192
[    0.000000] [0000010141800000-fffff8a002400000] page_structs=131072 node=
=3D0 entry=1286/8192
[    0.000000] [0000010141800000-fffff8a002800000] page_structs=131072 node=
=3D0 entry=1287/8192
[    0.000000] [0000010142000000-fffff8a002c00000] page_structs=131072 node=
=3D0 entry=1288/8192
[    0.000000] [0000010142000000-fffff8a003000000] page_structs=131072 node=
=3D0 entry=1289/8192
[    0.000000] [0000010142800000-fffff8a003400000] page_structs=131072 node=
=3D0 entry=1290/8192
[    0.000000] [0000010142800000-fffff8a003800000] page_structs=131072 node=
=3D0 entry=1291/8192
[    0.000000] [0000010143000000-fffff8a003c00000] page_structs=131072 node=
=3D0 entry=1292/8192
[    0.000000] [0000010143000000-fffff8a004000000] page_structs=131072 node=
=3D0 entry=1293/8192
[    0.000000] [0000010143800000-fffff8a004400000] page_structs=131072 node=
=3D0 entry=1294/8192
[    0.000000] [0000010143800000-fffff8a004800000] page_structs=131072 node=
=3D0 entry=1295/8192
[    0.000000] [0000010144000000-fffff8a004c00000] page_structs=131072 node=
=3D0 entry=1296/8192
[    0.000000] [0000010144000000-fffff8a005000000] page_structs=131072 node=
=3D0 entry=1297/8192
[    0.000000] [0000010144800000-fffff8a005400000] page_structs=131072 node=
=3D0 entry=1298/8192
[    0.000000] [0000010144800000-fffff8a005800000] page_structs=131072 node=
=3D0 entry=1299/8192
[    0.000000] [0000010145000000-fffff8a005c00000] page_structs=131072 node=
=3D0 entry=1300/8192
[    0.000000] [0000010145000000-fffff8a006000000] page_structs=131072 node=
=3D0 entry=1301/8192
[    0.000000] [0000010145800000-fffff8a006400000] page_structs=131072 node=
=3D0 entry=1302/8192
[    0.000000] [0000010145800000-fffff8a006800000] page_structs=131072 node=
=3D0 entry=1303/8192
[    0.000000] [0000010146000000-fffff8a006c00000] page_structs=131072 node=
=3D0 entry=1304/8192
[    0.000000] [0000010146000000-fffff8a007000000] page_structs=131072 node=
=3D0 entry=1305/8192
[    0.000000] [0000010146800000-fffff8a007400000] page_structs=131072 node=
=3D0 entry=1306/8192
[    0.000000] [0000010146800000-fffff8a007800000] page_structs=131072 node=
=3D0 entry=1307/8192
[    0.000000] [0000010147000000-fffff8a007c00000] page_structs=131072 node=
=3D0 entry=1308/8192
[    0.000000] [0000010147000000-fffff8a008000000] page_structs=131072 node=
=3D0 entry=1309/8192
[    0.000000] [0000010147800000-fffff8a008400000] page_structs=131072 node=
=3D0 entry=1310/8192
[    0.000000] [0000010147800000-fffff8a008800000] page_structs=131072 node=
=3D0 entry=1311/8192
[    0.000000] Zone PFN ranges:
[    0.000000]   Normal   0x05000000 -> 0x051ffd91
[    0.000000] Movable zone start PFN for each node
[    0.000000] early_node_map[4] active PFN ranges
[    0.000000]     0: 0x05000000 -> 0x051ff7ff
[    0.000000]     0: 0x051ff800 -> 0x051ffd5c
[    0.000000]     0: 0x051ffd80 -> 0x051ffd8f
[    0.000000]     0: 0x051ffd90 -> 0x051ffd91
[    0.000000] Booting Linux...
[    0.000000] Built 1 zonelists in Zone order, mobility grouping on.  Tota=
l pages: 2080111
[    0.000000] Kernel command line: -p
[    0.000000] PID hash table entries: 4096 (order: 2, 32768 bytes)
[    0.000000] Dentry cache hash table entries: 2097152 (order: 11, 1677721=
6 bytes)
[    0.000000] Inode-cache hash table entries: 1048576 (order: 10, 8388608 =
bytes)
[    0.000000] Memory: 16605976k available (3424k kernel code, 1416k data, =
200k init) [fffff80000000000,000000a3ffb22000]
[    0.000000] SLUB: Genslabs=16, HWalign2, Order=3D0-3, MinObjects=3D0, CP=
Us=3D1, Nodes=3D1
[    0.000000] NR_IRQS:255
[    0.000000] clocksource: mult[c8000000] shift[25]
[    0.000000] clockevent: mult[28f5c28] shift[32]
[    0.000000] Console: colour dummy device 80x25
[    0.000000] console [tty0] enabled, bootconsole disabled
[    0.000000] PROMLIB: Sun IEEE Boot Prom 'OBP 4.22.34 2007/07/23 13:01'
[    0.000000] PROMLIB: Root node compatible:=20
[    0.000000] Initializing cgroup subsys cpuset
[    0.000000] Initializing cgroup subsys cpu
[    0.000000] Linux version 2.6.37-2-sparc64 (Debian 2.6.37-2) (ben@decade=
nt.org.uk) (gcc version 4.4.5 (Debian 4.4.5-12) ) #1 Sun Feb 27 11:28:28 UT=
C 2011
[    0.000000] bootconsole [earlyprom0] enabled
[    0.000000] ARCH: SUN4U
[    0.000000] Ethernet address: 00:03:ba:29:7c:9f
[    0.000000] Kernel: Using 2 locked TLB entries for main kernel image.
[    0.000000] Remapping the kernel... done.
[    0.000000] OF stdout device is: /pci@9,700000/ebus@1/serial@1,400000:a
[    0.000000] PROM: Built device tree with 104323 bytes of memory.
[    0.000000] Top of RAM: 0xa3ffb22000, Total RAM: 0x3ffad6000
[    0.000000] Memory hole size: 655360MB
[    0.000000] [0000010140000000-fffff8a000c00000] page_structs=131072 node=
=3D0 entry=1280/8192
[    0.000000] [0000010140000000-fffff8a001000000] page_structs=131072 node=
=3D0 entry=1281/8192
[    0.000000] [0000010140800000-fffff8a001400000] page_structs=131072 node=
=3D0 entry=1282/8192
[    0.000000] [0000010140800000-fffff8a001800000] page_structs=131072 node=
=3D0 entry=1283/8192
[    0.000000] [0000010141000000-fffff8a001c00000] page_structs=131072 node=
=3D0 entry=1284/8192
[    0.000000] [0000010141000000-fffff8a002000000] page_structs=131072 node=
=3D0 entry=1285/8192
[    0.000000] [0000010141800000-fffff8a002400000] page_structs=131072 node=
=3D0 entry=1286/8192
[    0.000000] [0000010141800000-fffff8a002800000] page_structs=131072 node=
=3D0 entry=1287/8192
[    0.000000] [0000010142000000-fffff8a002c00000] page_structs=131072 node=
=3D0 entry=1288/8192
[    0.000000] [0000010142000000-fffff8a003000000] page_structs=131072 node=
=3D0 entry=1289/8192
[    0.000000] [0000010142800000-fffff8a003400000] page_structs=131072 node=
=3D0 entry=1290/8192
[    0.000000] [0000010142800000-fffff8a003800000] page_structs=131072 node=
=3D0 entry=1291/8192
[    0.000000] [0000010143000000-fffff8a003c00000] page_structs=131072 node=
=3D0 entry=1292/8192
[    0.000000] [0000010143000000-fffff8a004000000] page_structs=131072 node=
=3D0 entry=1293/8192
[    0.000000] [0000010143800000-fffff8a004400000] page_structs=131072 node=
=3D0 entry=1294/8192
[    0.000000] [0000010143800000-fffff8a004800000] page_structs=131072 node=
=3D0 entry=1295/8192
[    0.000000] [0000010144000000-fffff8a004c00000] page_structs=131072 node=
=3D0 entry=1296/8192
[    0.000000] [0000010144000000-fffff8a005000000] page_structs=131072 node=
=3D0 entry=1297/8192
[    0.000000] [0000010144800000-fffff8a005400000] page_structs=131072 node=
=3D0 entry=1298/8192
[    0.000000] [0000010144800000-fffff8a005800000] page_structs=131072 node=
=3D0 entry=1299/8192
[    0.000000] [0000010145000000-fffff8a005c00000] page_structs=131072 node=
=3D0 entry=1300/8192
[    0.000000] [0000010145000000-fffff8a006000000] page_structs=131072 node=
=3D0 entry=1301/8192
[    0.000000] [0000010145800000-fffff8a006400000] page_structs=131072 node=
=3D0 entry=1302/8192
[    0.000000] [0000010145800000-fffff8a006800000] page_structs=131072 node=
=3D0 entry=1303/8192
[    0.000000] [0000010146000000-fffff8a006c00000] page_structs=131072 node=
=3D0 entry=1304/8192
[    0.000000] [0000010146000000-fffff8a007000000] page_structs=131072 node=
=3D0 entry=1305/8192
[    0.000000] [0000010146800000-fffff8a007400000] page_structs=131072 node=
=3D0 entry=1306/8192
[    0.000000] [0000010146800000-fffff8a007800000] page_structs=131072 node=
=3D0 entry=1307/8192
[    0.000000] [0000010147000000-fffff8a007c00000] page_structs=131072 node=
=3D0 entry=1308/8192
[    0.000000] [0000010147000000-fffff8a008000000] page_structs=131072 node=
=3D0 entry=1309/8192
[    0.000000] [0000010147800000-fffff8a008400000] page_structs=131072 node=
=3D0 entry=1310/8192
[    0.000000] [0000010147800000-fffff8a008800000] page_structs=131072 node=
=3D0 entry=1311/8192
[    0.000000] Zone PFN ranges:
[    0.000000]   Normal   0x05000000 -> 0x051ffd91
[    0.000000] Movable zone start PFN for each node
[    0.000000] early_node_map[4] active PFN ranges
[    0.000000]     0: 0x05000000 -> 0x051ff7ff
[    0.000000]     0: 0x051ff800 -> 0x051ffd5c
[    0.000000]     0: 0x051ffd80 -> 0x051ffd8f
[    0.000000]     0: 0x051ffd90 -> 0x051ffd91
[    0.000000] Booting Linux...
[    0.000000] Built 1 zonelists in Zone order, mobility grouping on.  Tota=
l pages: 2080111
[    0.000000] Kernel command line: -p
[    0.000000] PID hash table entries: 4096 (order: 2, 32768 bytes)
[    0.000000] Dentry cache hash table entries: 2097152 (order: 11, 1677721=
6 bytes)
[    0.000000] Inode-cache hash table entries: 1048576 (order: 10, 8388608 =
bytes)
[    0.000000] Memory: 16605976k available (3424k kernel code, 1416k data, =
200k init) [fffff80000000000,000000a3ffb22000]
[    0.000000] SLUB: Genslabs=16, HWalign2, Order=3D0-3, MinObjects=3D0, CP=
Us=3D1, Nodes=3D1
[    0.000000] NR_IRQS:255
[    0.000000] clocksource: mult[c8000000] shift[25]
[    0.000000] clockevent: mult[28f5c28] shift[32]
[    0.000000] Console: colour dummy device 80x25
[    0.000000] console [tty0] enabled, bootconsole disabled
[  195.039183] Calibrating delay using timer specific routine.. 20.01 BogoM=
IPS (lpj@029)
[  195.039207] pid_max: default: 32768 minimum: 301
[  195.039283] Security Framework initialized
[  195.039315] SELinux:  Disabled at boot.
[  195.039351] Mount-cache hash table entries: 512
[  195.039786] Initializing cgroup subsys ns
[  195.039804] ns_cgroup deprecated: consider using the 'clone_children' fl=
ag without the ns_cgroup.
[  195.039824] Initializing cgroup subsys cpuacct
[  195.039839] Initializing cgroup subsys devices
[  195.039852] Initializing cgroup subsys freezer
[  195.039864] Initializing cgroup subsys net_cls
[  195.039877] Initializing cgroup subsys blkio
[  195.040748] devtmpfs: initialized
[  195.041237] regulator: core version 0.5
[  195.041342] regulator: dummy:=20
[  195.041463] NET: Registered protocol family 16
[  195.046284] Testing NMI watchdog ... OK.
[  195.126302] Performance events: Supported PMU type is 'ultra3+'
[  195.127005] /pci@8,700000: SCHIZO PCI Bus Module ver[4:0]
[  195.127025] /pci@8,700000: PCI IO[7ffef000000] MEM[7fe00000000]
[  195.131665] PCI: Scanning PBM /pci@8,700000
[  195.132135] /pci@8,600000: SCHIZO PCI Bus Module ver[4:0]
[  195.132160] /pci@8,600000: PCI IO[7ffed000000] MEM[7fd00000000]
[  195.136785] PCI: Scanning PBM /pci@8,600000
[  195.137503] /pci@9,700000: SCHIZO PCI Bus Module ver[4:0]
[  195.137526] /pci@9,700000: PCI IO[7ffeb000000] MEM[7fc00000000]
[  195.142160] PCI: Scanning PBM /pci@9,700000
[  195.143658] /pci@9,600000: SCHIZO PCI Bus Module ver[4:0]
[  195.143682] /pci@9,600000: PCI IO[7ffe9000000] MEM[7fb00000000]
[  195.148313] PCI: Scanning PBM /pci@9,600000
[  195.150497] bio: create slab <bio-0> at 0
[  195.150869] vgaarb: loaded
[  195.151718] /pci@9,700000/ebus@1/rtc@1,300070: RTC regs at 0x7fc7e300070
[  195.152174] Switching to clocksource stick
[  195.159946] NET: Registered protocol family 2
[  195.160222] IP route cache hash table entries: 524288 (order: 9, 4194304=
 bytes)
[  195.164996] TCP established hash table entries: 524288 (order: 10, 83886=
08 bytes)
[  195.196280] TCP bind hash table entries: 65536 (order: 6, 524288 bytes)
[  195.198257] TCP: Hash tables configured (established 524288 bind 65536)
[  195.198278] TCP reno registered
[  195.198310] UDP hash table entries: 8192 (order: 5, 262144 bytes)
[  195.199314] UDP-Lite hash table entries: 8192 (order: 5, 262144 bytes)
[  195.200611] NET: Registered protocol family 1
[  195.200931] Unpacking initramfs...
[  195.547232] Freeing initrd memory: 4130k freed
[  195.547807] power: Control reg at 7fc7e30002e
[  195.548268] chmc: UltraSPARC-III memory controller at /memory-controller=
@0,400000 [ACTIVE]
[  195.548316] chmc: UltraSPARC-III memory controller at /memory-controller=
@2,400000 [ACTIVE]
[  195.548623] audit: initializing netlink socket (disabled)
[  195.548673] type 00 audit(0.596:1): initialized
[  195.581548] HugeTLB registered 4 MB page size, pre-allocated 0 pages
[  195.587107] VFS: Disk quotas dquot_6.5.2
[  195.587323] Dquot-cache hash table entries: 1024 (order 0, 8192 bytes)
[  195.587570] msgmni has been set to 32441
[  195.588184] alg: No test for stdrng (krng)
[  195.588382] Block layer SCSI generic (bsg) driver version 0.4 loaded (ma=
jor 253)
[  195.588413] io scheduler noop registered
[  195.588429] io scheduler deadline registered
[  195.588591] io scheduler cfq registered (default)
[  195.589533] [drm] Initialized drm 1.1.0 20060810
[  195.590091] f00bc708: ttyS0 at MMIO 0x7fc7e3062f8 (irq =3D 20) is a 1655=
0A
[  195.590238] f00be030: ttyS1 at MMIO 0x7fc7e3083f8 (irq =3D 21) is a 1655=
0A
[  195.590599] f00bf958: ttyS2 at MMIO 0x7fc7e400000 (irq =3D 22) is a SAB8=
2532 V3.2
[  195.590627] Console: ttyS2 (SAB82532)
[  204.908057] console [ttyS0] enabled
[  204.949701] f00bf958: ttyS3 at MMIO 0x7fc7e400040 (irq =3D 22) is a SAB8=
2532 V3.2
[  205.037537] Uniform Multi-Platform E-IDE driver
[  205.091328] ide-gd driver 1.18
[  205.128011] mice: PS/2 mouse device common for all mice
[  205.190649] rtc_cmos rtc_cmos: rtc core: registered rtc_cmos as rtc0
[  205.266272] rtc0: no alarms, 114 bytes nvram
[  205.318177] TCP cubic registered
[  205.356282] NET: Registered protocol family 10
[  205.410064] lo: Disabled Privacy Extensions
[  205.459789] Mobile IPv6
[  205.488339] NET: Registered protocol family 17
[  205.541473] Registering the dns_resolver key type
[  205.597947] registered taskstats version 1
[  205.647074] rtc_cmos rtc_cmos: setting system clock to 2011-04-05 16:03:=
08 UTC (1302019388)
=1B%G=C3=AF=C2=BF=C2=BD=1B%@[  206.490842] sungem.c:v0.98 8/24/03 David S. =
Miller (davem@redhat.com)
[  206.766804] cassini: cassini.c:v1.6 (21 May 2008)
[  206.966483] usbcore: registered new interface driver usbfs
[  207.034808] cassini: MAC address not found in ROM VPD
[  207.097961] gem 0001:00:02.0: eth0: Sun GEM (PCI) 10/100/1000BaseT Ether=
net 00:03:ba:0c:95:3e
[  207.200066] usbcore: registered new interface driver hub
[  207.264810] cassini 0002:00:02.0: eth1: Sun Cassini+ (64bit/33MHz PCI/Cu=
) Ethernet[24] 08:00:20:ab:41:53
[  207.378938] usbcore: registered new device driver usb
[  207.448424] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
[  207.574164] cassini: MAC address not found in ROM VPD
[  207.643272] ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
[  207.720031] cassini 0003:00:01.0: eth2: Sun Cassini+ (64bit/66MHz PCI/Cu=
) Ethernet[30] 08:00:20:54:3d:84
[  207.861558] ohci_hcd 0002:00:01.3: OHCI Host Controller
[  207.923683] ohci_hcd 0002:00:01.3: new USB bus registered, assigned bus =
number 1
[  208.044538] ohci_hcd 0002:00:01.3: irq 23, io mem 0x7fc01000000
[  208.172300] usb usb1: New USB device found, idVendor=1D6b, idProduct=0001
[  208.252559] usb usb1: New USB device strings: Mfr=3D3, Product=3D2, Seri=
alNumber=3D1
[  208.339038] gem 0001:00:02.0: eth0: Link is up at 1000 Mbps, full-duplex
[  208.419228] usb usb1: Product: OHCI Host Controller
[  208.477557] usb usb1: Manufacturer: Linux 2.6.37-2-sparc64 ohci_hcd
[  208.552560] usb usb1: SerialNumber: 0002:00:01.3
[  208.608805] hub 1-0:1.0: USB hub found
[  208.652795] hub 1-0:1.0: 4 ports detected
