From: christian@j-son.org
Date: Tue, 13 Jan 2004 19:42:06 +0000
Subject: Status of Ross hyperSPARC on linux-2.4.x and linux-2.6.x?
Message-Id: <20040113204206.A988@sparky.j-son.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org

Just a little ping for me (and anyone else).. what's the status of the
linux kernels 2.4 and 2.6 for running Ross' hyperSPARC processors?

This is what I have (running up to date Aurora SPARC Linux 1.0)

cpu		: ROSS HyperSparc RT625 or RT626
fpu		: ROSS HyperSparc combined IU/FPU
promlib		: Version 3 Revision 2
prom		: 2.25
type		: sun4m
ncpus probed	: 4
ncpus active	: 4
Cpu0Bogo	: 124.92
Cpu1Bogo	: 125.33
Cpu2Bogo	: 125.33
Cpu3Bogo	: 125.33
MMU type	: ROSS HyperSparc
contexts	: 4096
nocache total	: 5242880
nocache used	: 159232
CPU0		: online
CPU1		: online
CPU2		: online
CPU3		: online

and dmesg reports=20

PROMLIB: Sun Boot Prom Version 3 Revision 2
Linux version 2.4.23-0.1sparcsmp (root@fw.j-son.org) (gcc version egcs-2.91=
.66 19990314/Linux (egcs-1.1.2 release)) #1 SMP Mon Jan 12 16:20:26 CET 2004
ARCH: SUN4M
TYPE: Sun4m SparcStation10/20
Ethernet address: 8:0:20:74:b0:90
SRMMU: Using VAC size of 1048576 bytes, line size 64 bytes.
Boot time fixup v1.6. 4/Mar/98 Jakub Jelinek (jj@ultra.linux.cz). Patching =
kernel for srmmu[ROSS HyperSparc]/iommu
65413MB HIGHMEM available.
On node 0 totalpages: 113727
zone(0): 49152 pages.
zone(1): 0 pages.
zone(2): 65413 pages.
Found CPU 0 <node=FFd74150,mid=3D8>
Found CPU 1 <node=FFd743a0,mid=3D9>
Found CPU 2 <node=FFd745f0,mid=10>
Found CPU 3 <node=FFd74840,mid=11>
Found 4 CPU prom device tree node(s).
Power off control detected.
Kernel command line: root=3D/dev/sda2 ro
Console: colour dummy device 80x25
Calibrating delay loop... 124.92 BogoMIPS
Memory: 444300k available (1732k kernel code, 352k data, 344k init, 261652k=
 highmem) [f0000000,1bf85000]
Dentry cache hash table entries: 32768 (order: 6, 262144 bytes)
Inode cache hash table entries: 16384 (order: 5, 131072 bytes)
Mount cache hash table entries: 512 (order: 0, 4096 bytes)
Buffer cache hash table entries: 8192 (order: 3, 32768 bytes)
Page-cache hash table entries: 65536 (order: 6, 262144 bytes)
POSIX conformance testing by UNIFIX
Entering SMP Mode...
Starting CPU 1 at f021890c
Calibrating delay loop... 125.33 BogoMIPS
Starting CPU 2 at f0218918
Calibrating delay loop... 125.33 BogoMIPS
Starting CPU 3 at f0218924
Calibrating delay loop... 125.33 BogoMIPS
Total of 4 Processors activated (500.94 BogoMIPS).
Waiting on wait_init_idle (map =3D 0xe)
All processors have done init_idle
IOMMU: impl 1 vers 3 page table at f0dc0000 of size 262144 bytes
sbus0: Clock 25.0 MHz
dma0: Revision 2=20
dma1: Revision 2=20
Sparc Zilog8530 serial driver version 1.68.2.2
Sun Mouse-Systems mouse driver version 1.00
tty00 at 0xffede004 (irq =3D 44) is a Zilog8530
tty01 at 0xffede000 (irq =3D 44) is a Zilog8530
tty02 at 0xffedb004 (irq =3D 44) is a Zilog8530
tty03 at 0xffedb000 (irq =3D 44) is a Zilog8530
Sun TYPE 5 keyboard detected without keyclick
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
Starting kswapd
allocated 32 pages and 32 bhs reserved for the highmem bounces
VFS: Disk quotas vdquot_6.5.1
ioremap: done with statics, switching to malloc
Console: switching to colour frame buffer device 128x54
fb0: cgsix at e.20000000 TEC Rev 4 CPU sparc Rev b [TGX+]
pty: 1024 Unix98 ptys configured
Floppy drive(s): fd0 is 1.44M
FDC 0 is a National Semiconductor PC87306
RAMDISK driver initialized: 16 RAM disks of 8192K size 1024 blocksize
SCSI subsystem driver Revision: 1.00
kmod: failed to exec /sbin/modprobe -s -k scsi_hostadapter, errno =3D 2
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 128 buckets, 6Kbytes
TCP: Hash tables configured (established 2048 bind 10922)
Linux IP multicast router 0.06 plus PIM-SM
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
RAMDISK: Compressed image found at block 0
Freeing initrd memory: 553k freed
VFS: Mounted root (ext2 filesystem).
esp0: IRQ 36 SCSI ID 7 Clk 40MHz CCYC%000 CCF=3D8 TOut 167 NCR53C9XF(espfas=
t)
ESP: Total of 1 ESP hosts found, 1 actually in use.
scsi0 : Sparc ESP100A-FAST
  Vendor: IBM       Model: DDRS-34560D       Rev: DC1B
  Type:   Direct-Access                      ANSI SCSI revision: 02
  Vendor: TOSHIBA   Model: XM-4101TASUNSLCD  Rev: 3424
  Type:   CD-ROM                             ANSI SCSI revision: 02
Attached scsi disk sda at scsi0, channel 0, id 3, lun 0
esp0: target 3 [period 100ns offset 15 10.00MHz FAST SCSI-II]
SCSI device sda: 8925000 512-byte hdwr sectors (4570 MB)
Partition check:
 sda: sda1 sda2 sda3 sda4
Journalled Block Device driver loaded
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
Freeing unused kernel memory: 344k freed
Adding Swap: 917224k swap-space (priority -1)
EXT3 FS 2.4-0.9.19, 19 August 2002 on sd(8,2), internal journal
md: md driver 0.90.0 MAX_MD_DEVS%6, MD_SB_DISKS'
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.19, 19 August 2002 on sd(8,1), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
sunlance.c:v2.01 08/Nov/01 Miguel de Icaza (miguel@nuclecu.unam.mx)
eth0: LANCE 08:00:20:74:b0:90=20
eth0: using auto-carrier-detection.
eth0: Carrier Lost, trying TPE
LANCE unopened after 100 ticks, csr0=0033.
dcsr=A0461010
sunmouse: Successfully adjusted to 1200 baud.

TIA,

/ChJ
