From: "Tom 'spot' Callaway" <tcallawa@redhat.com>
Date: Tue, 23 Mar 2004 23:18:53 +0000
Subject: Re: Slab corruption in 2.6.4-rc1 on sparc64 (sunblade 100)
Message-Id: <1080083933.533.5.camel@zorak>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="=-SnwyNlHrN1pZdZkJpy2u"
List-Id: <sparclinux.vger.kernel.org>
References: <1078237230.4360.19.camel@zorak>
In-Reply-To: <1078237230.4360.19.camel@zorak>
To: sparclinux@vger.kernel.org


--=-SnwyNlHrN1pZdZkJpy2u
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Tue, 2004-03-02 at 09:32 -0500, Ben Collins wrote:

> We should take this to private since it's nothing to do with sparc.

I think this is sparc related now, since I've reproduced it on an Ultra
10 without the ieee1394 driver loaded.

Kernel 2.6.5rc2. Best I can tell, its triggered by compiling code. Can't
really reproduce it at will, but its all over dmesg.

Dmesg attached from U10.

~spot
---
Tom "spot" Callaway <tcallawa(a)redhat*com> LCA, RHCE 
Red Hat Sales Engineer || Aurora SPARC Linux Project Leader

"The author's mathematical treatment of the conception of purpose is
novel and highly ingenious, but heretical and, so far as the present
social order is concerned, dangerous and potentially subversive. Not 
to be published." -- Aldous Huxley's "Brave New World"

--=-SnwyNlHrN1pZdZkJpy2u
Content-Disposition: attachment; filename=U10.dmesg
Content-Type: text/plain; name=U10.dmesg; charset=UTF-8
Content-Transfer-Encoding: 7bit

PROMLIB: Sun IEEE Boot Prom 3.15.2 1998/11/10 10:35
Linux version 2.6.4-1.278sparc2 (root@sunblade) (gcc version 3.3.3 20040216 (Red Hat Linux 3.3.3-2)) #1 Sun Mar 21 17:44:58 EST 2004
ARCH: SUN4U
Ethernet address: 08:00:20:a6:a7:84
On node 0 totalpages: 130491
  DMA zone: 130491 pages, LIFO batch:8
  Normal zone: 0 pages, LIFO batch:1
  HighMem zone: 0 pages, LIFO batch:1
Built 1 zonelists
Kernel command line: ro root=LABEL=/
PID hash table entries: 4096 (order 12: 65536 bytes)
Console: colour dummy device 80x25
Memory: 1032000k available (1960k kernel code, 8k reserved, 640k data, 160k init) [fffff80000000000,000000003ff4c000]
Calibrating delay loop... 665.19 BogoMIPS
Security Scaffold v1.0.0 initialized
SELinux:  Initializing.
SELinux:  Starting in permissive mode
There is already a security framework initialized, register_security failed.
Failure registering capabilities with the kernel
selinux_register_security:  Registering secondary module capability
Capability LSM initialized
Dentry cache hash table entries: 32768 (order: 5, 262144 bytes)
Inode-cache hash table entries: 32768 (order: 5, 262144 bytes)
Mount-cache hash table entries: 512 (order: 0, 8192 bytes)
checking if image is initramfs...it isn't (no cpio magic); looks like an initrd
Freeing initrd memory: 660k freed
POSIX conformance testing by UNIFIX
NET: Registered protocol family 16
PCI: Probing for controllers.
PCI: Found SABRE, main regs at 000001fe00000000, wsync at 000001fe00001c20
SABRE: Shared PCI config space at 000001fe01000000
SABRE: DVMA at c0000000 [20000000]
PCI0(PBMA): Bus running at 33MHz
PCI-IRQ: Routing bus[ 1] slot[ 1] map[0] to INO[21]
PCI-IRQ: Routing bus[ 1] slot[ 2] map[0] to INO[0f]
PCI-IRQ: Routing bus[ 1] slot[ 3] map[0] to INO[20]
PCI0(PBMB): Bus running at 33MHz
ebus0: [auxio] [power] [SUNW,pll] [se] [su] [su] [ecpp] [fdthree] [eeprom] [flashprom] [SUNW,CS4231]
power: Control reg at 000001fff1724000 ... powerd running.
atyfb: 3D RAGE PRO (PQFP, PCI) [0x4750 rev 0x7c] 4M SGRAM, 14.31818 MHz XTAL, 230 MHz PLL, 100 Mhz MCLK
fb0: ATY Mach64 frame buffer device on PCI
Total HugeTLB memory allocated, 0
audit: initializing netlink socket (disabled)
audit(1079923836.570:0): initialized
VFS: Disk quotas dquot_6.5.1
SELinux:  Registering netfilter hooks
Initializing Cryptographic API
Console: switching to mono PROM 80x34
Console: switching to colour frame buffer device 160x64
rtc_init: no PC rtc found
su0 at 0x000001fff13062f8 (irq = 4,7ea) is a 16550A
su1 at 0x000001fff13083f8 (irq = 9,7e9) is a 16550A
ttyS0 at MMIO 0x1fff1400000 (irq = 7142432) is a SAB82532 V3.2
ttyS1 at MMIO 0x1fff1400040 (irq = 7142432) is a SAB82532 V3.2
Using deadline io scheduler
Floppy drive(s): fd0 is 1.44M
FDC 0 is a National Semiconductor PC87306
RAMDISK driver initialized: 16 RAM disks of 8192K size 1024 blocksize
divert: not allocating divert_blk for non-ethernet device lo
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
CMD646: IDE controller at PCI slot 0000:01:03.0
CMD646: chipset revision 3
CMD646: chipset revision 0x03, MultiWord DMA Force Limited
CMD646: 100% native mode on irq 4,7e0
    ide0: BM-DMA at 0x1fe02c00020-0x1fe02c00027, BIOS settings: hda:pio, hdb:pio
    ide1: BM-DMA at 0x1fe02c00028-0x1fe02c0002f, BIOS settings: hdc:pio, hdd:pio
hda: ST39140A, ATA DISK drive
hdb: ST39140A, ATA DISK drive
ide0 at 0x1fe02c00000-0x1fe02c00007,0x1fe02c0000a on irq 4,7e0
hdc: CRD-8322B, ATAPI CD/DVD-ROM drive
ide1 at 0x1fe02c00010-0x1fe02c00017,0x1fe02c0001a on irq 4,7e0 (shared with ide0)
hda: max request size: 128KiB
hda: 17803440 sectors (9115 MB) w/448KiB Cache, CHS=17662/16/63, (U)DMA
 hda: hda1 hda2 hda3
hdb: max request size: 128KiB
hdb: 17803440 sectors (9115 MB) w/448KiB Cache, CHS=17662/16/63, (U)DMA
 hdb: hdb1 hdb2 hdb3
hdc: ATAPI 32X CD-ROM drive, 128kB Cache, DMA
Uniform CD-ROM driver Revision: 3.20
ide-floppy driver 0.99.newide
mice: PS/2 mouse device common for all mice
input: Sun Type 5 keyboard on su/serio1
md: md driver 0.90.0 MAX_MD_DEVS=256, MD_SB_DISKS=27
NET: Registered protocol family 2
IP: routing cache hash table of 16384 buckets, 128Kbytes
TCP: Hash tables configured (established 131072 bind 65536)
Initializing IPsec netlink socket
NET: Registered protocol family 1
NET: Registered protocol family 17
md: Autodetecting RAID arrays.
md: autorun ...
md: ... autorun DONE.
RAMDISK: Compressed image found at block 0
VFS: Mounted root (ext2 filesystem).
kjournald starting.  Commit interval 5 seconds
EXT3-fs: hda1: orphan cleanup on readonly fs
ext3_orphan_cleanup: deleting unreferenced inode 66076
EXT3-fs: hda1: 1 orphan inode deleted
EXT3-fs: recovery complete.
EXT3-fs: mounted filesystem with ordered data mode.
EXT3 FS on hda1, internal journal
Adding 2047736k swap on /dev/hdb1.  Priority:-1 extents:1
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hda2, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hdb2, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
parport0: PC-style at 0x1fff13043bc (0x1fff13047bc), irq 7142144 [PCSPP,TRISTATE]
parport0: cpp_daisy: aa5500ff(38)
parport0: assign_addrs: aa5500ff(38)
parport0: cpp_daisy: aa5500ff(38)
parport0: assign_addrs: aa5500ff(38)
SCSI subsystem initialized
end_request: I/O error, dev fd0, sector 0
sunhme.c:v2.02 24/Aug/2003 David S. Miller (davem@redhat.com)
divert: allocating divert_blk for eth0
eth0: HAPPY MEAL (PCI/CheerIO) 10/100BaseT Ethernet 08:00:20:a6:a7:84 
ip_tables: (C) 2000-2002 Netfilter core team
ip_tables: (C) 2000-2002 Netfilter core team
eth0: Link is up using internal transceiver at 100Mb/s, Full Duplex.
NET: Registered protocol family 10
Disabled Privacy Extensions on device 000000000064c1d0(lo)
IPv6 over IPv4 tunneling driver
divert: not allocating divert_blk for non-ethernet device sit0
eth0: no IPv6 routers present
input: Sun Mouse on su/serio0
end_request: I/O error, dev fd0, sector 0
Slab corruption: start=fffff80011730bc0, len=160
Redzone: 0x5a2cf071/0x5a2cf071.
Last user: [<0000000000000000>](0x0)
000: 6b 6b 6b 6b 6b 6b 6b 6b 70 6c 2e 6f 00 2d 4d 44
Prev obj: start=fffff80011730b08, len=160
Redzone: 0x5a2cf071/0x5a2cf071.
Last user: [<0000000000000000>](0x0)
000: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b
010: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b
Next obj: start=fffff80011730c78, len=160
Redzone: 0x5a2cf071/0x5a2cf071.
Last user: [<0000000000000000>](0x0)
000: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b
010: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b
Slab corruption: start=fffff8003887cbc0, len=160
Redzone: 0x5a2cf071/0x5a2cf071.
Last user: [<0000000000000000>](0x0)
000: 6b 6b 6b 6b 6b 6b 6b 6b 78 44 69 61 6c 6f 67 5f
Prev obj: start=fffff8003887cb08, len=160
Redzone: 0x5a2cf071/0x5a2cf071.
Last user: [<0000000000000000>](0x0)
000: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b
010: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b
Next obj: start=fffff8003887cc78, len=160
Redzone: 0x5a2cf071/0x5a2cf071.
Last user: [<0000000000000000>](0x0)
000: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b
010: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b
ip_tables: (C) 2000-2002 Netfilter core team
eth0: Link is up using internal transceiver at 100Mb/s, Full Duplex.
eth0: no IPv6 routers present
sunkbd.c: Unknown key (scancode 0x0) pressed.

--=-SnwyNlHrN1pZdZkJpy2u--

