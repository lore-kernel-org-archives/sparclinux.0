From: David Dillow <dave@thedillows.org>
Date: Sun, 04 Jan 2004 03:07:30 +0000
Subject: Oops on 2.6.1-rc1 serial access
Message-Id: <1073185649.3960.31.camel@ori.thedillows.org>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="=-yKJzlAxZImGEMlx6QygI"
List-Id: <sparclinux.vger.kernel.org>
To: sparclinux@vger.kernel.org


--=-yKJzlAxZImGEMlx6QygI
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

When running /usr/lib/cups/backend/serial on a 143Mhz Ultra1 running
gentoo 1.4rc4, I can reliably generate the attached oops on 2.6.1-rc1.
The program is part of CUPS (1.1.19).

The oops occurs when running the command without arguments, which causes
it to scan for available ports. According to the attached strace output,
it dies opening ttyS2 -- both ttyS0 & ttyS1 are ok.

If I get a chance, I'll start tracking down the root cause. Until then,
I thought I'd send it out, in case someone knows the problem.

Dave

(Also attached dmesg and the .config)

--=-yKJzlAxZImGEMlx6QygI
Content-Disposition: attachment; filename=oops
Content-Type: text/plain; name=oops; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Unable to handle kernel NULL pointer dereference
tsk->{mm,active_mm}->context =3D 0000000000000512
tsk->{mm,active_mm}->pgd =3D fffff80032e97000
              \|/ ____ \|/
              "@'/ .. \`@"
              /_| \__/ |_\
                 \__U_/
serial(3159): Oops [#1]
TSTATE: 0000004411009603 TPC: 00000000004fef6c TNPC: 00000000004fef70 Y: 00=
000000    Not tainted
TPC: <uart_close+0xc/0x200>
g0: 0000000000000000 g1: 00000000004e9200 g2: fffff80033ce0d60 g3: fffff800=
32e18958
g4: fffff800331fa0e0 g5: 0000000000000000 g6: fffff80032ddc000 g7: 00000000=
00000000
o0: 0000000000000000 o1: fffff80032e18c28 o2: 0000000000000000 o3: fffff800=
330d2110
o4: 000000000058d8b0 o5: 0000000000000000 sp: fffff80032ddf0d1 ret_pc: 0000=
0000004e9df4
RPC: <tty_fasync+0x74/0x140>
l0: fffff800330d2000 l1: 0000000000000000 l2: 0000000000000000 l3: 00000000=
00000020
l4: fffff800330d2d30 l5: 0000000000200200 l6: 0000000000000000 l7: 00000000=
00022288
i0: fffff800330d2000 i1: fffff80032e18c28 i2: 00000000004fef60 i3: 00000000=
00000010
i4: fffff80033c6eb00 i5: 0000000000000000 i6: fffff80032ddf191 i7: 00000000=
004e9910
I7: <release_dev+0x5b0/0x5e0>
Instruction DUMP: 9de3bf40  e25e2a50  a6046020 <e45c6018> 7ffc88f4  9010001=
3  7fffa5da  90100019  80a22000=20

--=-yKJzlAxZImGEMlx6QygI
Content-Disposition: attachment; filename=strace.out
Content-Type: text/plain; name=strace.out; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

execve("./serial", ["./serial"], [/* 27 vars */]) =3D 0
uname({sys=3D"Linux", node=3D"sun", ...})   =3D 0
brk(0)                                  =3D 0x24000
mmap(NULL, 8192, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) =
=3D 0x7001a000
open("/etc/ld.so.preload", O_RDONLY)    =3D -1 ENOENT (No such file or dire=
ctory)
open("/usr/lib/v9/libcups.so.2", O_RDONLY) =3D -1 ENOENT (No such file or d=
irectory)
stat64("/usr/lib/v9", 0xefffee70)       =3D -1 ENOENT (No such file or dire=
ctory)
open("/usr/lib/libcups.so.2", O_RDONLY) =3D 3
read(3, "\177ELF\1\2\1\0\0\0\0\0\0\0\0\0\0\3\0\22\0\0\0\1\0\0S`"..., 1024) =
=3D 1024
fstat64(3, {st_mode=3DS_IFREG|0755, st_size=3D133944, ...}) =3D 0
mmap(NULL, 187832, PROT_READ|PROT_EXEC, MAP_PRIVATE, 3, 0) =3D 0x7002c000
mprotect(0x70048000, 73144, PROT_NONE)  =3D 0
mmap(0x7004c000, 57344, PROT_READ|PROT_WRITE|PROT_EXEC, MAP_PRIVATE|MAP_FIX=
ED, 3, 0x10000) =3D 0x7004c000
close(3)                                =3D 0
open("/usr/lib/libnsl.so.1", O_RDONLY)  =3D -1 ENOENT (No such file or dire=
ctory)
open("/etc/ld.so.cache", O_RDONLY)      =3D 3
fstat64(3, {st_mode=3DS_IFREG|0644, st_size=3D10680, ...}) =3D 0
mmap(NULL, 10680, PROT_READ, MAP_PRIVATE, 3, 0) =3D 0x7005c000
close(3)                                =3D 0
open("/lib/libnsl.so.1", O_RDONLY)      =3D 3
read(3, "\177ELF\1\2\1\0\0\0\0\0\0\0\0\0\0\3\0\22\0\0\0\1\0\0?\240"..., 102=
4) =3D 1024
fstat64(3, {st_mode=3DS_IFREG|0755, st_size=3D93672, ...}) =3D 0
mmap(NULL, 151984, PROT_READ|PROT_EXEC, MAP_PRIVATE, 3, 0) =3D 0x70060000
mprotect(0x70072000, 78256, PROT_NONE)  =3D 0
mmap(0x70080000, 16384, PROT_READ|PROT_WRITE|PROT_EXEC, MAP_PRIVATE|MAP_FIX=
ED, 3, 0x10000) =3D 0x70080000
mmap(0x70084000, 4528, PROT_READ|PROT_WRITE|PROT_EXEC, MAP_PRIVATE|MAP_FIXE=
D|MAP_ANONYMOUS, -1, 0) =3D 0x70084000
close(3)                                =3D 0
open("/usr/lib/libcrypt.so.1", O_RDONLY) =3D -1 ENOENT (No such file or dir=
ectory)
open("/lib/libcrypt.so.1", O_RDONLY)    =3D 3
read(3, "\177ELF\1\2\1\0\0\0\0\0\0\0\0\0\0\3\0\22\0\0\0\1\0\0\n"..., 1024) =
=3D 1024
fstat64(3, {st_mode=3DS_IFREG|0755, st_size=3D30583, ...}) =3D 0
mmap(NULL, 250668, PROT_READ|PROT_EXEC, MAP_PRIVATE, 3, 0) =3D 0x70088000
mprotect(0x7008e000, 226092, PROT_NONE) =3D 0
mmap(0x70098000, 32768, PROT_READ|PROT_WRITE|PROT_EXEC, MAP_PRIVATE|MAP_FIX=
ED, 3, 0) =3D 0x70098000
mmap(0x700a0000, 152364, PROT_READ|PROT_WRITE|PROT_EXEC, MAP_PRIVATE|MAP_FI=
XED|MAP_ANONYMOUS, -1, 0) =3D 0x700a0000
close(3)                                =3D 0
open("/usr/lib/libc.so.6", O_RDONLY)    =3D -1 ENOENT (No such file or dire=
ctory)
open("/lib/libc.so.6", O_RDONLY)        =3D 3
read(3, "\177ELF\1\2\1\0\0\0\0\0\0\0\0\0\0\3\0\22\0\0\0\1\0\1\313"..., 1024=
) =3D 1024
fstat64(3, {st_mode=3DS_IFREG|0755, st_size=3D1583537, ...}) =3D 0
mmap(NULL, 1414744, PROT_READ|PROT_EXEC, MAP_PRIVATE, 3, 0) =3D 0x700c8000
mprotect(0x7020c000, 87640, PROT_NONE)  =3D 0
mmap(0x70218000, 32768, PROT_READ|PROT_WRITE|PROT_EXEC, MAP_PRIVATE|MAP_FIX=
ED, 3, 0x140000) =3D 0x70218000
mmap(0x70220000, 5720, PROT_READ|PROT_WRITE|PROT_EXEC, MAP_PRIVATE|MAP_FIXE=
D|MAP_ANONYMOUS, -1, 0) =3D 0x70220000
close(3)                                =3D 0
open("/usr/lib/libssl.so.0.9.6", O_RDONLY) =3D 3
read(3, "\177ELF\1\2\1\0\0\0\0\0\0\0\0\0\0\3\0\22\0\0\0\1\0\0\230"..., 1024=
) =3D 1024
fstat64(3, {st_mode=3DS_IFREG|0555, st_size=3D222010, ...}) =3D 0
mmap(NULL, 261552, PROT_READ|PROT_EXEC, MAP_PRIVATE, 3, 0) =3D 0x70224000
mprotect(0x70252000, 73136, PROT_NONE)  =3D 0
mmap(0x70254000, 65536, PROT_READ|PROT_WRITE|PROT_EXEC, MAP_PRIVATE|MAP_FIX=
ED, 3, 0x20000) =3D 0x70254000
close(3)                                =3D 0
open("/usr/lib/libcrypto.so.0.9.6", O_RDONLY) =3D 3
read(3, "\177ELF\1\2\1\0\0\0\0\0\0\0\0\0\0\3\0\22\0\0\0\1\0\2> "..., 1024) =
=3D 1024
fstat64(3, {st_mode=3DS_IFREG|0555, st_size=3D991980, ...}) =3D 0
mmap(NULL, 956504, PROT_READ|PROT_EXEC, MAP_PRIVATE, 3, 0) =3D 0x70264000
mprotect(0x70330000, 120920, PROT_NONE) =3D 0
mmap(0x70334000, 98304, PROT_READ|PROT_WRITE|PROT_EXEC, MAP_PRIVATE|MAP_FIX=
ED, 3, 0xc0000) =3D 0x70334000
mmap(0x7034c000, 6232, PROT_READ|PROT_WRITE|PROT_EXEC, MAP_PRIVATE|MAP_FIXE=
D|MAP_ANONYMOUS, -1, 0) =3D 0x7034c000
close(3)                                =3D 0
open("/usr/lib/libdl.so.2", O_RDONLY)   =3D -1 ENOENT (No such file or dire=
ctory)
open("/usr/lib/libdl.so.2", O_RDONLY)   =3D -1 ENOENT (No such file or dire=
ctory)
open("/usr/lib/libdl.so.2", O_RDONLY)   =3D -1 ENOENT (No such file or dire=
ctory)
open("/lib/libdl.so.2", O_RDONLY)       =3D 3
read(3, "\177ELF\1\2\1\0\0\0\0\0\0\0\0\0\0\3\0\22\0\0\0\1\0\0\34"..., 1024)=
 =3D 1024
fstat64(3, {st_mode=3DS_IFREG|0755, st_size=3D14286, ...}) =3D 0
mmap(NULL, 74512, PROT_READ|PROT_EXEC, MAP_PRIVATE, 3, 0) =3D 0x70350000
mprotect(0x70352000, 66320, PROT_NONE)  =3D 0
mmap(0x70360000, 16384, PROT_READ|PROT_WRITE|PROT_EXEC, MAP_PRIVATE|MAP_FIX=
ED, 3, 0) =3D 0x70360000
close(3)                                =3D 0
munmap(0x7005c000, 10680)               =3D 0
open("/dev/urandom", O_RDONLY)          =3D 3
read(3, "\211:\36|%5\256\345q\360\2179m9\340\314\03420\301\'\337"..., 32) =
=3D 32
close(3)                                =3D 0
rt_sigaction(SIGPIPE, {SIG_IGN}, NULL, 0x700fc458, 8) =3D 0
open("/dev/ttyS0", O_WRONLY|O_NONBLOCK|O_NOCTTY|0x4) =3D 3
close(3)                                =3D 0
fstat64(1, {st_mode=3DS_IFREG|0644, st_size=3D5151, ...}) =3D 0
mmap(NULL, 8192, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) =
=3D 0x7005c000
open("/dev/ttyS1", O_WRONLY|O_NONBLOCK|O_NOCTTY|0x4) =3D 3
close(3)                                =3D 0
open("/dev/ttyS2", O_WRONLY|O_NONBLOCK|O_NOCTTY|0x4 <unfinished ...>
+++ killed by SIGKILL +++

--=-yKJzlAxZImGEMlx6QygI
Content-Disposition: attachment; filename=dmesg
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; name=dmesg; charset=UTF-8

PROMLIB: Sun IEEE Boot Prom 3.25.0 1999/12/03 11:36
Linux version 2.6.1-rc1 (root@sun) (gcc version 3.2.3 20030422 (Gentoo Linu=
x 1.4 @PV@)) #1 Sat Jan 3 17:04:45 EST 2004
ARCH: SUN4U
Ethernet address: 08:00:20:80:d1:64
On node 0 totalpages: 32387
  DMA zone: 32387 pages, LIFO batch:7
  Normal zone: 0 pages, LIFO batch:1
  HighMem zone: 0 pages, LIFO batch:1
Building zonelist for node : 0
Kernel command line: root=3D/dev/sda4 ro
PID hash table entries: 4096 (order 12: 65536 bytes)
Console: colour dummy device 80x25
Memory: 249312k available (1504k kernel code, 480k data, 88k init) [fffff80=
000000000,0000000033f4c000]
Calibrating delay loop... 285.08 BogoMIPS
Dentry cache hash table entries: 32768 (order: 5, 262144 bytes)
Inode-cache hash table entries: 16384 (order: 4, 131072 bytes)
Mount-cache hash table entries: 512 (order: 0, 8192 bytes)
POSIX conformance testing by UNIFIX
NET: Registered protocol family 16
SCSI subsystem initialized
SYSIO: UPA portID 1f, at 000001fe00000000
sbus0: Clock 25.0 MHz
dma0: Revision 2=20
dma1: Revision 2=20
ikconfig 0.7 with /proc/config*
pty: 256 Unix98 ptys configured
SunZilog: 2 chips.
zs2 at 0x000001fff1000004 (irq =3D 12,7e8) is a SunZilog
zs3 at 0x000001fff1000000 (irq =3D 12,7e8) is a SunZilog
ttyS0 at MMIO 0x0 (irq =3D 6424896) is a SunZilog
ttyS1 at MMIO 0x0 (irq =3D 6424896) is a SunZilog
Console: ttyS0 (SunZilog zs0)
sunlance.c:v2.02 24/Aug/03 Miguel de Icaza (miguel@nuclecu.unam.mx)
SunLance: using auto-carrier-detection.
eth0: LANCE 08:00:20:80:d1:64=20
esp0: IRQ 4,7e0 SCSI ID 7 Clk 40MHz CCYC=3D25000 CCF=3D8 TOut 167 NCR53C9XF=
(espfast)
ESP: Total of 1 ESP hosts found, 1 actually in use.
scsi0 : Sparc ESP100A-FAST
Using anticipatory io scheduler
  Vendor: IBM       Model: DDRS34560SUN4.2G  Rev: S98E
  Type:   Direct-Access                      ANSI SCSI revision: 02
  Vendor: IBM       Model: DDRS34560SUN4.2G  Rev: S98E
  Type:   Direct-Access                      ANSI SCSI revision: 02
  Vendor: IBM       Model: CDRM00203     !K  Rev: BZ26
  Type:   CD-ROM                             ANSI SCSI revision: 02
esp0: target 0 [period 100ns offset 15 10.00MHz FAST SCSI-II]
SCSI device sda: 8385121 512-byte hdwr sectors (4293 MB)
SCSI device sda: drive cache: write through
 sda: sda1 sda2 sda3 sda4
Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
esp0: target 1 [period 100ns offset 15 10.00MHz FAST SCSI-II]
SCSI device sdb: 8385121 512-byte hdwr sectors (4293 MB)
SCSI device sdb: drive cache: write through
 sdb: sdb1 sdb2 sdb3 sdb4
Attached scsi disk sdb at scsi0, channel 0, id 1, lun 0
mice: PS/2 mouse device common for all mice
NET: Registered protocol family 2
IP: routing cache hash table of 4096 buckets, 32Kbytes
TCP: Hash tables configured (established 32768 bind 32768)
NET: Registered protocol family 1
NET: Registered protocol family 17
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Adding 523784k swap on /dev/sda2.  Priority:-1 extents:1
EXT3 FS on sda4, internal journal
eth0: Carrier Lost, trying TPE
nfs warning: mount version older than kernel

--=-yKJzlAxZImGEMlx6QygI
Content-Disposition: attachment; filename=config
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; name=config; charset=UTF-8

#
# Automatically generated make config: don't edit
#
CONFIG_64BIT=3Dy
CONFIG_MMU=3Dy

#
# Code maturity level options
#
CONFIG_EXPERIMENTAL=3Dy
CONFIG_CLEAN_COMPILE=3Dy
CONFIG_STANDALONE=3Dy
CONFIG_BROKEN_ON_SMP=3Dy

#
# General setup
#
CONFIG_SWAP=3Dy
CONFIG_SYSVIPC=3Dy
# CONFIG_BSD_PROCESS_ACCT is not set
CONFIG_SYSCTL=3Dy
CONFIG_LOG_BUF_SHIFT=3D15
CONFIG_IKCONFIG=3Dy
CONFIG_IKCONFIG_PROC=3Dy
# CONFIG_EMBEDDED is not set
CONFIG_KALLSYMS=3Dy
CONFIG_FUTEX=3Dy
CONFIG_EPOLL=3Dy
CONFIG_IOSCHED_NOOP=3Dy
CONFIG_IOSCHED_AS=3Dy
CONFIG_IOSCHED_DEADLINE=3Dy
# CONFIG_CC_OPTIMIZE_FOR_SIZE is not set

#
# Loadable module support
#
CONFIG_MODULES=3Dy
CONFIG_MODULE_UNLOAD=3Dy
CONFIG_MODULE_FORCE_UNLOAD=3Dy
CONFIG_OBSOLETE_MODPARM=3Dy
CONFIG_MODVERSIONS=3Dy
CONFIG_KMOD=3Dy

#
# General setup
#
CONFIG_VT=3Dy
CONFIG_VT_CONSOLE=3Dy
CONFIG_HW_CONSOLE=3Dy
# CONFIG_SMP is not set
# CONFIG_PREEMPT is not set
# CONFIG_CPU_FREQ is not set
CONFIG_SPARC64=3Dy
# CONFIG_HOTPLUG is not set
CONFIG_RWSEM_XCHGADD_ALGORITHM=3Dy
CONFIG_GENERIC_ISA_DMA=3Dy
CONFIG_SBUS=3Dy
CONFIG_SBUSCHAR=3Dy
CONFIG_SUN_AUXIO=3Dy
CONFIG_SUN_IO=3Dy
# CONFIG_PCI is not set
# CONFIG_PCI_DOMAINS is not set
CONFIG_SUN_OPENPROMFS=3Dy
CONFIG_SPARC32_COMPAT=3Dy
CONFIG_COMPAT=3Dy
CONFIG_UID16=3Dy
CONFIG_BINFMT_ELF32=3Dy
# CONFIG_BINFMT_AOUT32 is not set
CONFIG_BINFMT_ELF=3Dy
# CONFIG_BINFMT_MISC is not set
# CONFIG_SUNOS_EMUL is not set
# CONFIG_SOLARIS_EMUL is not set

#
# Parallel port support
#
# CONFIG_PARPORT is not set

#
# Generic Driver Options
#

#
# Graphics support
#
# CONFIG_FB is not set

#
# Console display driver support
#
# CONFIG_MDA_CONSOLE is not set
# CONFIG_PROM_CONSOLE is not set
CONFIG_DUMMY_CONSOLE=3Dy

#
# Serial drivers
#
# CONFIG_SERIAL_8250 is not set

#
# Non-8250 serial port support
#
CONFIG_SERIAL_SUNCORE=3Dy
CONFIG_SERIAL_SUNZILOG=3Dy
CONFIG_SERIAL_SUNZILOG_CONSOLE=3Dy
CONFIG_SERIAL_CORE=3Dy
CONFIG_SERIAL_CORE_CONSOLE=3Dy

#
# Misc Linux/SPARC drivers
#
# CONFIG_SUN_OPENPROMIO is not set
CONFIG_SUN_MOSTEK_RTC=3Dy
# CONFIG_OBP_FLASH is not set
# CONFIG_SUN_BPP is not set
# CONFIG_SUN_VIDEOPIX is not set
# CONFIG_SUN_AURORA is not set

#
# Memory Technology Devices (MTD)
#
# CONFIG_MTD is not set

#
# Block devices
#
# CONFIG_BLK_DEV_FD is not set
CONFIG_BLK_DEV_LOOP=3Dm
# CONFIG_BLK_DEV_NBD is not set

#
# Multi-device support (RAID and LVM)
#
# CONFIG_MD is not set
# CONFIG_BLK_DEV_RAM is not set

#
# ATA/ATAPI/MFM/RLL support
#
# CONFIG_IDE is not set

#
# SCSI device support
#
CONFIG_SCSI=3Dy
CONFIG_SCSI_PROC_FS=3Dy

#
# SCSI support type (disk, tape, CD-ROM)
#
CONFIG_BLK_DEV_SD=3Dy
# CONFIG_CHR_DEV_ST is not set
# CONFIG_CHR_DEV_OSST is not set
# CONFIG_BLK_DEV_SR is not set
# CONFIG_CHR_DEV_SG is not set

#
# Some SCSI devices (e.g. CD jukebox) support multiple LUNs
#
# CONFIG_SCSI_MULTI_LUN is not set
# CONFIG_SCSI_REPORT_LUNS is not set
CONFIG_SCSI_CONSTANTS=3Dy
# CONFIG_SCSI_LOGGING is not set

#
# SCSI low-level drivers
#
# CONFIG_SCSI_AIC7XXX_OLD is not set
# CONFIG_SCSI_SATA is not set
# CONFIG_SCSI_EATA_PIO is not set
# CONFIG_SCSI_QLOGICPTI is not set
# CONFIG_SCSI_DEBUG is not set
CONFIG_SCSI_SUNESP=3Dy

#
# Fibre Channel support
#
# CONFIG_FC4 is not set

#
# IEEE 1394 (FireWire) support (EXPERIMENTAL)
#
# CONFIG_IEEE1394 is not set

#
# Networking support
#
CONFIG_NET=3Dy

#
# Networking options
#
CONFIG_PACKET=3Dy
CONFIG_PACKET_MMAP=3Dy
# CONFIG_NETLINK_DEV is not set
CONFIG_UNIX=3Dy
# CONFIG_NET_KEY is not set
CONFIG_INET=3Dy
CONFIG_IP_MULTICAST=3Dy
# CONFIG_IP_ADVANCED_ROUTER is not set
# CONFIG_IP_PNP is not set
# CONFIG_NET_IPIP is not set
# CONFIG_NET_IPGRE is not set
# CONFIG_IP_MROUTE is not set
# CONFIG_ARPD is not set
CONFIG_INET_ECN=3Dy
# CONFIG_SYN_COOKIES is not set
# CONFIG_INET_AH is not set
# CONFIG_INET_ESP is not set
# CONFIG_INET_IPCOMP is not set
# CONFIG_IPV6 is not set
# CONFIG_DECNET is not set
# CONFIG_BRIDGE is not set
# CONFIG_NETFILTER is not set

#
# SCTP Configuration (EXPERIMENTAL)
#
CONFIG_IPV6_SCTP__=3Dy
# CONFIG_IP_SCTP is not set
# CONFIG_ATM is not set
# CONFIG_VLAN_8021Q is not set
# CONFIG_LLC2 is not set
# CONFIG_IPX is not set
# CONFIG_ATALK is not set
# CONFIG_X25 is not set
# CONFIG_LAPB is not set
# CONFIG_NET_DIVERT is not set
# CONFIG_ECONET is not set
# CONFIG_WAN_ROUTER is not set
# CONFIG_NET_FASTROUTE is not set
# CONFIG_NET_HW_FLOWCONTROL is not set

#
# QoS and/or fair queueing
#
# CONFIG_NET_SCHED is not set

#
# Network testing
#
# CONFIG_NET_PKTGEN is not set
CONFIG_NETDEVICES=3Dy
# CONFIG_DUMMY is not set
# CONFIG_BONDING is not set
# CONFIG_EQUALIZER is not set
# CONFIG_TUN is not set

#
# Ethernet (10 or 100Mbit)
#
CONFIG_NET_ETHERNET=3Dy
# CONFIG_MII is not set
CONFIG_SUNLANCE=3Dy
# CONFIG_HAPPYMEAL is not set
# CONFIG_SUNBMAC is not set
# CONFIG_SUNQE is not set

#
# Ethernet (1000 Mbit)
#
# CONFIG_MYRI_SBUS is not set

#
# Ethernet (10000 Mbit)
#
# CONFIG_PPP is not set
# CONFIG_SLIP is not set

#
# Wireless LAN (non-hamradio)
#
# CONFIG_NET_RADIO is not set

#
# Token Ring devices
#
# CONFIG_SHAPER is not set

#
# Wan interfaces
#
# CONFIG_WAN is not set

#
# Amateur Radio support
#
# CONFIG_HAMRADIO is not set

#
# IrDA (infrared) support
#
# CONFIG_IRDA is not set

#
# Bluetooth support
#
# CONFIG_BT is not set

#
# ISDN subsystem
#
# CONFIG_ISDN_BOOL is not set

#
# Telephony Support
#
# CONFIG_PHONE is not set

#
# Unix 98 PTY support
#
CONFIG_UNIX98_PTYS=3Dy
CONFIG_UNIX98_PTY_COUNT=3D256

#
# XFree86 DRI support
#
# CONFIG_DRM is not set

#
# Input device support
#
CONFIG_INPUT=3Dy

#
# Userland interfaces
#
CONFIG_INPUT_MOUSEDEV=3Dy
CONFIG_INPUT_MOUSEDEV_PSAUX=3Dy
CONFIG_INPUT_MOUSEDEV_SCREEN_X=3D1024
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=3D768
# CONFIG_INPUT_JOYDEV is not set
# CONFIG_INPUT_TSDEV is not set
# CONFIG_INPUT_EVDEV is not set
# CONFIG_INPUT_EVBUG is not set

#
# Input I/O drivers
#
# CONFIG_GAMEPORT is not set
CONFIG_SOUND_GAMEPORT=3Dy
# CONFIG_SERIO is not set
# CONFIG_SERIO_I8042 is not set

#
# Input Device Drivers
#
# CONFIG_INPUT_KEYBOARD is not set
# CONFIG_INPUT_MOUSE is not set
# CONFIG_INPUT_JOYSTICK is not set
# CONFIG_INPUT_TOUCHSCREEN is not set
# CONFIG_INPUT_MISC is not set

#
# I2C support
#
# CONFIG_I2C is not set

#
# I2C Algorithms
#

#
# I2C Hardware Bus support
#

#
# I2C Hardware Sensors Chip support
#
# CONFIG_I2C_SENSOR is not set

#
# File systems
#
# CONFIG_EXT2_FS is not set
CONFIG_EXT3_FS=3Dy
# CONFIG_EXT3_FS_XATTR is not set
CONFIG_JBD=3Dy
# CONFIG_JBD_DEBUG is not set
# CONFIG_REISERFS_FS is not set
# CONFIG_JFS_FS is not set
# CONFIG_XFS_FS is not set
# CONFIG_MINIX_FS is not set
# CONFIG_ROMFS_FS is not set
# CONFIG_QUOTA is not set
# CONFIG_AUTOFS_FS is not set
# CONFIG_AUTOFS4_FS is not set

#
# CD-ROM/DVD Filesystems
#
# CONFIG_ISO9660_FS is not set
# CONFIG_UDF_FS is not set

#
# DOS/FAT/NT Filesystems
#
# CONFIG_FAT_FS is not set
# CONFIG_NTFS_FS is not set

#
# Pseudo filesystems
#
CONFIG_PROC_FS=3Dy
CONFIG_PROC_KCORE=3Dy
# CONFIG_DEVFS_FS is not set
CONFIG_DEVPTS_FS=3Dy
CONFIG_DEVPTS_FS_XATTR=3Dy
# CONFIG_DEVPTS_FS_SECURITY is not set
CONFIG_TMPFS=3Dy
# CONFIG_HUGETLBFS is not set
# CONFIG_HUGETLB_PAGE is not set
CONFIG_RAMFS=3Dy

#
# Miscellaneous filesystems
#
# CONFIG_ADFS_FS is not set
# CONFIG_AFFS_FS is not set
# CONFIG_HFS_FS is not set
# CONFIG_BEFS_FS is not set
# CONFIG_BFS_FS is not set
# CONFIG_EFS_FS is not set
# CONFIG_CRAMFS is not set
# CONFIG_VXFS_FS is not set
# CONFIG_HPFS_FS is not set
# CONFIG_QNX4FS_FS is not set
# CONFIG_SYSV_FS is not set
# CONFIG_UFS_FS is not set

#
# Network File Systems
#
CONFIG_NFS_FS=3Dm
CONFIG_NFS_V3=3Dy
# CONFIG_NFS_V4 is not set
CONFIG_NFS_DIRECTIO=3Dy
CONFIG_NFSD=3Dm
CONFIG_NFSD_V3=3Dy
# CONFIG_NFSD_V4 is not set
CONFIG_NFSD_TCP=3Dy
CONFIG_LOCKD=3Dm
CONFIG_LOCKD_V4=3Dy
CONFIG_EXPORTFS=3Dm
CONFIG_SUNRPC=3Dm
# CONFIG_SUNRPC_GSS is not set
# CONFIG_SMB_FS is not set
# CONFIG_CIFS is not set
# CONFIG_NCP_FS is not set
# CONFIG_CODA_FS is not set
# CONFIG_INTERMEZZO_FS is not set
# CONFIG_AFS_FS is not set

#
# Partition Types
#
# CONFIG_PARTITION_ADVANCED is not set
CONFIG_MSDOS_PARTITION=3Dy
CONFIG_SUN_PARTITION=3Dy

#
# Native Language Support
#
# CONFIG_NLS is not set

#
# Multimedia devices
#
# CONFIG_VIDEO_DEV is not set

#
# Digital Video Broadcasting Devices
#
# CONFIG_DVB is not set

#
# Sound
#
# CONFIG_SOUND is not set

#
# USB support
#
# CONFIG_USB_GADGET is not set

#
# Watchdog
#
# CONFIG_SOFT_WATCHDOG is not set

#
# Profiling support
#
# CONFIG_PROFILING is not set

#
# Kernel hacking
#
CONFIG_DEBUG_KERNEL=3Dy
CONFIG_DEBUG_SLAB=3Dy
CONFIG_MAGIC_SYSRQ=3Dy
# CONFIG_DEBUG_SPINLOCK is not set
# CONFIG_DEBUG_SPINLOCK_SLEEP is not set
CONFIG_DEBUG_BUGVERBOSE=3Dy
# CONFIG_DEBUG_DCFLUSH is not set
# CONFIG_DEBUG_INFO is not set
# CONFIG_STACK_DEBUG is not set

#
# Security options
#
# CONFIG_SECURITY is not set

#
# Cryptographic options
#
# CONFIG_CRYPTO is not set

#
# Library routines
#
CONFIG_CRC32=3Dy

--=-yKJzlAxZImGEMlx6QygI--
