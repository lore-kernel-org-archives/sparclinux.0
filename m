From: "Art Haas" <ahaas@airmail.net>
Date: Mon, 29 Mar 2004 20:11:35 +0000
Subject: Need help getting 2.6.5-BK to boot
Message-Id: <20040329201135.GC30251@artsapartment.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org

Hi.

I'm trying to get my 2.6.5-BK kernel to boot, and am having a few
problems, most likely self-induced. I've been able to compile the
kernel (using the latest Debian GCC-3.3 package), and it boots
up, but things don't work correctly. First, I never see anything
on my display past the first few lines that get printed out after
I select the kernel at the silo prompt. The kernel _does_ boot, but
eventually crashes, and I have to 'Stop-A' and 'reset' to get
going again.

I'm currently running with a 2.4.26-pre3-smp kernel that I picked up
from the 'osinvestor' site. That kernel boots and runs. As that kernel
performs nicely, I'm sure that I've made some sort of configuration
goof, but I can't see just what I've omitted or unnecessarily added, so
I'm turning to the list for a little help.

I apologize now for the size of this e-mail, as I'm going to include
my '.config' and some output from both the 2.4 and 2.6 kernel bootups.

My .config:
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
#
# Automatically generated make config: don't edit
#
CONFIG_MMU=3Dy
CONFIG_UID16=3Dy
CONFIG_HIGHMEM=3Dy
CONFIG_GENERIC_ISA_DMA=3Dy

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
CONFIG_BSD_PROCESS_ACCT=3Dy
CONFIG_SYSCTL=3Dy
CONFIG_LOG_BUF_SHIFT=14
# CONFIG_HOTPLUG is not set
# CONFIG_IKCONFIG is not set
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
# CONFIG_MODULE_FORCE_UNLOAD is not set
CONFIG_OBSOLETE_MODPARM=3Dy
# CONFIG_MODVERSIONS is not set
CONFIG_KMOD=3Dy

#
# General setup
#
CONFIG_VT=3Dy
CONFIG_VT_CONSOLE=3Dy
CONFIG_HW_CONSOLE=3Dy
# CONFIG_SMP is not set
CONFIG_SPARC32=3Dy
CONFIG_SBUS=3Dy
CONFIG_SBUSCHAR=3Dy
CONFIG_SERIAL_CONSOLE=3Dy
CONFIG_SUN_AUXIO=3Dy
CONFIG_SUN_IO=3Dy
CONFIG_RWSEM_GENERIC_SPINLOCK=3Dy
CONFIG_SUN_PM=3Dy
# CONFIG_SUN4 is not set
# CONFIG_PCI is not set
CONFIG_SUN_OPENPROMFS=3Dm
CONFIG_BINFMT_ELF=3Dy
CONFIG_BINFMT_AOUT=3Dm
CONFIG_BINFMT_MISC=3Dm
CONFIG_SUNOS_EMUL=3Dy

#
# Parallel port support
#
# CONFIG_PARPORT is not set

#
# Generic Driver Options
#
# CONFIG_DEBUG_DRIVER is not set

#
# Graphics support
#
CONFIG_FB=3Dy
# CONFIG_FB_BW2 is not set
# CONFIG_FB_CG3 is not set
CONFIG_FB_CG6=3Dy
CONFIG_FB_SBUS=3Dy
# CONFIG_FB_TCX is not set
# CONFIG_FB_CG14 is not set
# CONFIG_FB_P9100 is not set
# CONFIG_FB_LEO is not set
# CONFIG_FB_VIRTUAL is not set

#
# Console display driver support
#
# CONFIG_MDA_CONSOLE is not set
CONFIG_PROM_CONSOLE=3Dy
CONFIG_DUMMY_CONSOLE=3Dy
CONFIG_FRAMEBUFFER_CONSOLE=3Dm
CONFIG_PCI_CONSOLE=3Dy
# CONFIG_FONTS is not set
CONFIG_FONT_SUN8x16=3Dy
# CONFIG_FONT_SUN12x22 is not set

#
# Logo configuration
#
CONFIG_LOGO=3Dy
CONFIG_LOGO_LINUX_MONO=3Dy
CONFIG_LOGO_LINUX_VGA16=3Dy
CONFIG_LOGO_LINUX_CLUT224=3Dy

#
# Memory Technology Devices (MTD)
#
# CONFIG_MTD is not set

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
CONFIG_SUN_OPENPROMIO=3Dm
CONFIG_SUN_MOSTEK_RTC=3Dm
# CONFIG_SUN_BPP is not set
# CONFIG_SUN_VIDEOPIX is not set
# CONFIG_SUN_AURORA is not set
# CONFIG_TADPOLE_TS102_UCTRL is not set
# CONFIG_SUN_JSFLASH is not set

#
# Block devices
#
CONFIG_BLK_DEV_FD=3Dm
CONFIG_BLK_DEV_LOOP=3Dm
CONFIG_BLK_DEV_CRYPTOLOOP=3Dm
# CONFIG_BLK_DEV_NBD is not set
CONFIG_BLK_DEV_RAM=3Dm
CONFIG_BLK_DEV_RAM_SIZE@96

#
# ISDN subsystem
#
# CONFIG_ISDN is not set

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
CONFIG_BLK_DEV_SR=3Dm
# CONFIG_BLK_DEV_SR_VENDOR is not set
CONFIG_CHR_DEV_SG=3Dm

#
# Some SCSI devices (e.g. CD jukebox) support multiple LUNs
#
# CONFIG_SCSI_MULTI_LUN is not set
CONFIG_SCSI_REPORT_LUNS=3Dy
# CONFIG_SCSI_CONSTANTS is not set
# CONFIG_SCSI_LOGGING is not set

#
# SCSI Transport Attributes
#
# CONFIG_SCSI_SPI_ATTRS is not set
# CONFIG_SCSI_FC_ATTRS is not set

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
# Multi-device support (RAID and LVM)
#
# CONFIG_MD is not set

#
# Networking support
#
CONFIG_NET=3Dy

#
# Networking options
#
CONFIG_PACKET=3Dm
# CONFIG_PACKET_MMAP is not set
# CONFIG_NETLINK_DEV is not set
CONFIG_UNIX=3Dm
CONFIG_NET_KEY=3Dm
CONFIG_INET=3Dy
# CONFIG_IP_MULTICAST is not set
# CONFIG_IP_ADVANCED_ROUTER is not set
CONFIG_IP_PNP=3Dy
CONFIG_IP_PNP_DHCP=3Dy
# CONFIG_IP_PNP_BOOTP is not set
# CONFIG_IP_PNP_RARP is not set
CONFIG_NET_IPIP=3Dm
CONFIG_NET_IPGRE=3Dm
# CONFIG_ARPD is not set
# CONFIG_SYN_COOKIES is not set
CONFIG_INET_AH=3Dm
CONFIG_INET_ESP=3Dm
CONFIG_INET_IPCOMP=3Dm
CONFIG_IPV6=3Dm
# CONFIG_IPV6_PRIVACY is not set
CONFIG_INET6_AH=3Dm
CONFIG_INET6_ESP=3Dm
CONFIG_INET6_IPCOMP=3Dm
CONFIG_IPV6_TUNNEL=3Dm
# CONFIG_DECNET is not set
# CONFIG_BRIDGE is not set
# CONFIG_NETFILTER is not set
CONFIG_XFRM=3Dy
CONFIG_XFRM_USER=3Dm

#
# SCTP Configuration (EXPERIMENTAL)
#
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
CONFIG_NET_PKTGEN=3Dm
CONFIG_NETDEVICES=3Dy
CONFIG_DUMMY=3Dm
# CONFIG_BONDING is not set
# CONFIG_EQUALIZER is not set
CONFIG_TUN=3Dm

#
# Ethernet (10 or 100Mbit)
#
CONFIG_NET_ETHERNET=3Dy
# CONFIG_MII is not set
CONFIG_SUNLANCE=3Dm
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
# CONFIG_NETCONSOLE is not set

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
# CONFIG_NETPOLL is not set
# CONFIG_NET_POLL_CONTROLLER is not set

#
# Unix98 PTY support
#
CONFIG_UNIX98_PTYS=3Dy
CONFIG_UNIX98_PTY_COUNT%6

#
# Input device support
#
CONFIG_INPUT=3Dy

#
# Userland interfaces
#
CONFIG_INPUT_MOUSEDEV=3Dy
CONFIG_INPUT_MOUSEDEV_PSAUX=3Dy
CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
CONFIG_INPUT_MOUSEDEV_SCREEN_Yv8
# CONFIG_INPUT_JOYDEV is not set
# CONFIG_INPUT_TSDEV is not set
# CONFIG_INPUT_EVDEV is not set
# CONFIG_INPUT_EVBUG is not set

#
# Input I/O drivers
#
# CONFIG_GAMEPORT is not set
CONFIG_SOUND_GAMEPORT=3Dy
CONFIG_SERIO=3Dy
# CONFIG_SERIO_I8042 is not set
# CONFIG_SERIO_SERPORT is not set
# CONFIG_SERIO_CT82C710 is not set

#
# Input Device Drivers
#
CONFIG_INPUT_KEYBOARD=3Dy
# CONFIG_KEYBOARD_ATKBD is not set
CONFIG_KEYBOARD_SUNKBD=3Dy
# CONFIG_KEYBOARD_LKKBD is not set
# CONFIG_KEYBOARD_XTKBD is not set
# CONFIG_KEYBOARD_NEWTON is not set
CONFIG_INPUT_MOUSE=3Dy
# CONFIG_MOUSE_PS2 is not set
CONFIG_MOUSE_SERIAL=3Dy
# CONFIG_MOUSE_VSXXXAA is not set
# CONFIG_INPUT_JOYSTICK is not set
# CONFIG_INPUT_TOUCHSCREEN is not set
# CONFIG_INPUT_MISC is not set

#
# File systems
#
CONFIG_EXT2_FS=3Dy
CONFIG_EXT2_FS_XATTR=3Dy
CONFIG_EXT2_FS_POSIX_ACL=3Dy
# CONFIG_EXT2_FS_SECURITY is not set
CONFIG_EXT3_FS=3Dm
CONFIG_EXT3_FS_XATTR=3Dy
CONFIG_EXT3_FS_POSIX_ACL=3Dy
# CONFIG_EXT3_FS_SECURITY is not set
CONFIG_JBD=3Dm
# CONFIG_JBD_DEBUG is not set
CONFIG_FS_MBCACHE=3Dy
# CONFIG_REISERFS_FS is not set
# CONFIG_JFS_FS is not set
CONFIG_FS_POSIX_ACL=3Dy
# CONFIG_XFS_FS is not set
# CONFIG_MINIX_FS is not set
CONFIG_ROMFS_FS=3Dm
# CONFIG_QUOTA is not set
CONFIG_AUTOFS_FS=3Dm
CONFIG_AUTOFS4_FS=3Dm

#
# CD-ROM/DVD Filesystems
#
CONFIG_ISO9660_FS=3Dm
CONFIG_JOLIET=3Dy
CONFIG_ZISOFS=3Dy
CONFIG_ZISOFS_FS=3Dm
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
# CONFIG_DEVPTS_FS_XATTR is not set
CONFIG_TMPFS=3Dy
# CONFIG_HUGETLB_PAGE is not set
CONFIG_RAMFS=3Dy

#
# Miscellaneous filesystems
#
# CONFIG_ADFS_FS is not set
# CONFIG_AFFS_FS is not set
# CONFIG_HFS_FS is not set
# CONFIG_HFSPLUS_FS is not set
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
CONFIG_NFS_V4=3Dy
# CONFIG_NFS_DIRECTIO is not set
CONFIG_NFSD=3Dm
CONFIG_NFSD_V3=3Dy
CONFIG_NFSD_V4=3Dy
# CONFIG_NFSD_TCP is not set
CONFIG_LOCKD=3Dm
CONFIG_LOCKD_V4=3Dy
CONFIG_EXPORTFS=3Dm
CONFIG_SUNRPC=3Dm
CONFIG_SUNRPC_GSS=3Dm
CONFIG_RPCSEC_GSS_KRB5=3Dm
# CONFIG_SMB_FS is not set
# CONFIG_CIFS is not set
# CONFIG_NCP_FS is not set
# CONFIG_CODA_FS is not set
# CONFIG_INTERMEZZO_FS is not set
# CONFIG_AFS_FS is not set

#
# Partition Types
#
CONFIG_PARTITION_ADVANCED=3Dy
# CONFIG_ACORN_PARTITION is not set
# CONFIG_OSF_PARTITION is not set
# CONFIG_AMIGA_PARTITION is not set
# CONFIG_ATARI_PARTITION is not set
# CONFIG_MAC_PARTITION is not set
# CONFIG_MSDOS_PARTITION is not set
# CONFIG_LDM_PARTITION is not set
# CONFIG_NEC98_PARTITION is not set
# CONFIG_SGI_PARTITION is not set
# CONFIG_ULTRIX_PARTITION is not set
CONFIG_SUN_PARTITION=3Dy
# CONFIG_EFI_PARTITION is not set

#
# Native Language Support
#
CONFIG_NLS=3Dm
CONFIG_NLS_DEFAULT=3D"iso8859-1"
CONFIG_NLS_CODEPAGE_437=3Dm
# CONFIG_NLS_CODEPAGE_737 is not set
# CONFIG_NLS_CODEPAGE_775 is not set
CONFIG_NLS_CODEPAGE_850=3Dm
# CONFIG_NLS_CODEPAGE_852 is not set
# CONFIG_NLS_CODEPAGE_855 is not set
# CONFIG_NLS_CODEPAGE_857 is not set
# CONFIG_NLS_CODEPAGE_860 is not set
# CONFIG_NLS_CODEPAGE_861 is not set
# CONFIG_NLS_CODEPAGE_862 is not set
# CONFIG_NLS_CODEPAGE_863 is not set
# CONFIG_NLS_CODEPAGE_864 is not set
# CONFIG_NLS_CODEPAGE_865 is not set
# CONFIG_NLS_CODEPAGE_866 is not set
# CONFIG_NLS_CODEPAGE_869 is not set
# CONFIG_NLS_CODEPAGE_936 is not set
# CONFIG_NLS_CODEPAGE_950 is not set
# CONFIG_NLS_CODEPAGE_932 is not set
# CONFIG_NLS_CODEPAGE_949 is not set
# CONFIG_NLS_CODEPAGE_874 is not set
# CONFIG_NLS_ISO8859_8 is not set
# CONFIG_NLS_CODEPAGE_1250 is not set
# CONFIG_NLS_CODEPAGE_1251 is not set
CONFIG_NLS_ISO8859_1=3Dm
# CONFIG_NLS_ISO8859_2 is not set
# CONFIG_NLS_ISO8859_3 is not set
# CONFIG_NLS_ISO8859_4 is not set
# CONFIG_NLS_ISO8859_5 is not set
# CONFIG_NLS_ISO8859_6 is not set
# CONFIG_NLS_ISO8859_7 is not set
# CONFIG_NLS_ISO8859_9 is not set
# CONFIG_NLS_ISO8859_13 is not set
# CONFIG_NLS_ISO8859_14 is not set
CONFIG_NLS_ISO8859_15=3Dm
# CONFIG_NLS_KOI8_R is not set
# CONFIG_NLS_KOI8_U is not set
CONFIG_NLS_UTF8=3Dm

#
# Sound
#
# CONFIG_SOUND is not set

#
# USB support
#

#
# USB Gadget Support
#
# CONFIG_USB_GADGET is not set

#
# Watchdog Cards
#
# CONFIG_WATCHDOG is not set

#
# Kernel hacking
#
CONFIG_DEBUG_KERNEL=3Dy
# CONFIG_DEBUG_STACK_USAGE is not set
CONFIG_DEBUG_SLAB=3Dy
CONFIG_MAGIC_SYSRQ=3Dy
# CONFIG_DEBUG_SPINLOCK is not set
# CONFIG_DEBUG_HIGHMEM is not set
# CONFIG_DEBUG_SPINLOCK_SLEEP is not set
# CONFIG_DEBUG_BUGVERBOSE is not set

#
# Security options
#
# CONFIG_SECURITY is not set

#
# Cryptographic options
#
CONFIG_CRYPTO=3Dy
CONFIG_CRYPTO_HMAC=3Dy
CONFIG_CRYPTO_NULL=3Dm
CONFIG_CRYPTO_MD4=3Dm
CONFIG_CRYPTO_MD5=3Dm
CONFIG_CRYPTO_SHA1=3Dm
CONFIG_CRYPTO_SHA256=3Dm
CONFIG_CRYPTO_SHA512=3Dm
CONFIG_CRYPTO_DES=3Dm
CONFIG_CRYPTO_BLOWFISH=3Dm
CONFIG_CRYPTO_TWOFISH=3Dm
CONFIG_CRYPTO_SERPENT=3Dm
CONFIG_CRYPTO_AES=3Dm
CONFIG_CRYPTO_CAST5=3Dm
CONFIG_CRYPTO_CAST6=3Dm
CONFIG_CRYPTO_ARC4=3Dm
CONFIG_CRYPTO_DEFLATE=3Dm
CONFIG_CRYPTO_MICHAEL_MIC=3Dm
CONFIG_CRYPTO_TEST=3Dm

#
# Library routines
#
CONFIG_CRC32=3Dm
CONFIG_ZLIB_INFLATE=3Dm
CONFIG_ZLIB_DEFLATE=3Dm
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

Here's the trimmed boot log from the BK kernel:
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

kernel: klogd 1.4.1#13, log source =3D /proc/kmsg started.
kernel: Inspecting /boot/System.map-2.6.5-rc2
xfs: ignoring font path element /usr/lib/X11/fonts/cyrillic/ (unreadable)=20
xfs: ignoring font path element /usr/lib/X11/fonts/CID (unreadable)=20
kernel: Loaded 12110 symbols from /boot/System.map-2.6.5-rc2.
kernel: Symbols match kernel version 2.6.5.
kernel: No module symbols loaded - kernel modules not enabled.=20
kernel: PROMLIB: Sun Boot Prom Version 3 Revision 2
kernel: Linux version 2.6.5-rc2 (arth@sundebian) (gcc version 3.3.3 (Debian=
 20040321)) #4 Sun Mar 28 10:58:21 CST 2004
kernel: ARCH: SUN4M
kernel: TYPE: Sun4m SparcStation10/20
kernel: Ethernet address: 8:0:20:78:eb:9e
kernel: Boot time fixup v1.6. 4/Mar/98 Jakub Jelinek (jj@ultra.linux.cz). P=
atching kernel for srmmu[TI Viking/MXCC]/iommu
kernel: 319MB HIGHMEM available.
kernel: On node 0 totalpages: 130417
kernel:   DMA zone: 48674 pages, LIFO batch:11
kernel:   Normal zone: 0 pages, LIFO batch:1
kernel:   HighMem zone: 81743 pages, LIFO batch:16
kernel: Power off control detected.
kernel: Built 1 zonelists
kernel: Kernel command line: root=3D/dev/sda1 ro
kernel: PID hash table entries: 2048 (order 11: 16384 bytes)
kernel: Console: colour dummy device 80x25
kernel: Memory: 509676k available (1324k kernel code, 312k data, 116k init,=
 326972k highmem) [f0000000,1ff4f000]
kernel: Calibrating delay loop... 59.80 BogoMIPS
kernel: Dentry cache hash table entries: 32768 (order: 5, 131072 bytes)
kernel: Inode-cache hash table entries: 16384 (order: 4, 65536 bytes)
kernel: Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
kernel: POSIX conformance testing by UNIFIX
kernel: NET: Registered protocol family 16
kernel: SCSI subsystem initialized
kernel: IOMMU: impl 1 vers 3 table 0xf0d40000[262144 B] map [65536 b]
kernel: sbus0: Clock 25.0 MHz
kernel: dma0: Revision 2=20
kernel: dma1: Revision 2=20
kernel: ioremap: done with statics, switching to malloc
kernel: cg6: CGsix [TGX+ sparc] at e:20000000
kernel: highmem bounce pool size: 64 pages
kernel: Initializing Cryptographic API
kernel: Console: switching to mono PROM 80x34
kernel: zs2 at 0xfd019004 (irq =3D 44) is a SunZilog
kernel: zs3 at 0xfd019000 (irq =3D 44) is a SunZilog
kernel: ttyS0 at MMIO 0x0 (irq =3D 44) is a SunZilog
kernel: ttyS1 at MMIO 0x0 (irq =3D 44) is a SunZilog
kernel: esp0: IRQ 36 SCSI ID 7 Clk 40MHz CCYC%000 CCF=3D8 TOut 167 NCR53C9X=
F(espfast)
kernel: ESP: Total of 1 ESP hosts found, 1 actually in use.
kernel: scsi0 : Sparc ESP100A-FAST
kernel: Using anticipatory io scheduler
kernel:   Vendor: SEAGATE   Model: ST31200W SUN1.05  Rev: 8724
kernel:   Type:   Direct-Access                      ANSI SCSI revision: 02
kernel:   Vendor: FUJITSU   Model: MAB3045S SUN4.2G  Rev: 1806
kernel:   Type:   Direct-Access                      ANSI SCSI revision: 02
kernel:   Vendor: TOSHIBA   Model: XM-4101TASUNSLCD  Rev: 3424
kernel:   Type:   CD-ROM                             ANSI SCSI revision: 02
kernel: esp0: target 1 [period 100ns offset 15 10.00MHz FAST SCSI-II]
kernel: SCSI device sda: 2061108 512-byte hdwr sectors (1055 MB)
kernel: SCSI device sda: drive cache: write through
kernel:  sda: sda1 sda2 sda3
kernel: Attached scsi disk sda at scsi0, channel 0, id 1, lun 0
kernel: esp0: target 3 [period 100ns offset 15 10.00MHz FAST SCSI-II]
kernel: SCSI device sdb: 8385121 512-byte hdwr sectors (4293 MB)
kernel: SCSI device sdb: drive cache: write through
kernel:  sdb: sdb1
kernel: Attached scsi disk sdb at scsi0, channel 0, id 3, lun 0
kernel: mice: PS/2 mouse device common for all mice
kernel: input: Sun Type 5 keyboard on zs/serio0
kernel: input: Sun Mouse on zs/serio1
kernel: NET: Registered protocol family 2
kernel: IP: routing cache hash table of 1024 buckets, 8Kbytes
kernel: TCP: Hash tables configured (established 16384 bind 32768)
kernel: VFS: Mounted root (ext2 filesystem) readonly.
kernel: Freeing unused kernel memory: 116k freed
kernel: NET: Registered protocol family 1
kernel: Adding 50896k swap on /dev/sda2.  Priority:-1 extents:1
kernel: NET: Registered protocol family 10
kernel: IPv6 over IPv4 tunneling driver
kernel:               \|/ ____ \|/
kernel:               "@'/ ,. \`@"
kernel:               /_| \__/ |_\
kernel:                  \__U_/
kernel: XFree86(293): Kernel bad trap [#1]
kernel: PSR: 40401084 PC: 501a20c8 NPC: 501a20cc Y: 00000000    Not tainted
kernel: PC: <0x501a20c8>
kernel: %%G: 00000000 00000002  00000000 00000fb8  50019000 00000000  ff000=
000 50015638
kernel: %%O: 501a2094 00023584  000aeb04 000fc5a4  efe80330 00000000  efff9=
690 501a20a0
kernel: RPC: <0x501a20a0>
kernel: %%L: 40001085 501c5d60  501c5d64 00000040  00000080 f0010a04  00000=
000 50238c2c
kernel: %%I: 00000000 00000006  efff9758 000fc5a4  efe80330 00000000  efff9=
6f8 000aeb04
kernel: Instruction DUMP: 80a0a000  1280000a  82102002 <91d02010> 0a80000b =
 01000000  80a23fff  02800006  92027fff=20
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Here's the dmesg output from a 2.4.26-pre boot
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
PROMLIB: Sun Boot Prom Version 3 Revision 2
Linux version 2.4.26-pre3smp (rradez@notporn) (gcc version 3.3.3 20040125 (=
prerelease) (Debian)) #1 SMP Sat Mar 13 18:37:52 EST 2004
ARCH: SUN4M
TYPE: Sun4m SparcStation10/20
Ethernet address: 8:0:20:78:eb:9e
Boot time fixup v1.6. 4/Mar/98 Jakub Jelinek (jj@ultra.linux.cz). Patching =
kernel for srmmu[TI Viking/MXCC]/iommu
81743MB HIGHMEM available.
On node 0 totalpages: 130324
zone(0): 49152 pages.
zone(1): 0 pages.
zone(2): 81743 pages.
Found CPU 0 <node=FFd6f150,mid=3D8>
Found CPU 1 <node=FFd6f510,mid=10>
Found 2 CPU prom device tree node(s).
a
Power off control detected.
Kernel command line: root=3D/dev/sda1
Console: colour dummy device 80x25
Calibrating delay loop... 59.80 BogoMIPS
Memory: 508956k available (1608k kernel code, 216k data, 148k init, 326972k=
 highmem) [f0000000,1ff4f000]
Dentry cache hash table entries: 32768 (order: 6, 262144 bytes)
Inode cache hash table entries: 16384 (order: 5, 131072 bytes)
Mount cache hash table entries: 512 (order: 0, 4096 bytes)
Buffer cache hash table entries: 8192 (order: 3, 32768 bytes)
Page-cache hash table entries: 65536 (order: 6, 262144 bytes)
POSIX conformance testing by UNIFIX
Entering SMP Mode...
Starting CPU 1 at f01d5b08
Calibrating delay loop... 59.80 BogoMIPS
Total of 2 Processors activated (119.60 BogoMIPS).
Waiting on wait_init_idle (map =3D 0x2)
All processors have done init_idle
IOMMU: impl 1 vers 3 page table at f0f80000 of size 262144 bytes
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
Journalled Block Device driver loaded
ioremap: done with statics, switching to malloc
Console: switching to colour frame buffer device 128x54
fb0: cgsix at e.20000000 TEC Rev 4 CPU sparc Rev b [TGX+]
pty: 256 Unix98 ptys configured
Floppy drive(s): fd0 is 1.44M
FDC 0 is a National Semiconductor PC87306
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
sunlance.c:v2.01 08/Nov/01 Miguel de Icaza (miguel@nuclecu.unam.mx)
eth0: LANCE 08:00:20:78:eb:9e=20
eth0: using auto-carrier-detection.
SCSI subsystem driver Revision: 1.00
esp0: IRQ 36 SCSI ID 7 Clk 40MHz CCYC%000 CCF=3D8 TOut 167 NCR53C9XF(espfas=
t)
ESP: Total of 1 ESP hosts found, 1 actually in use.
scsi0 : Sparc ESP100A-FAST
  Vendor: SEAGATE   Model: ST31200W SUN1.05  Rev: 8724
  Type:   Direct-Access                      ANSI SCSI revision: 02
  Vendor: FUJITSU   Model: MAB3045S SUN4.2G  Rev: 1806
  Type:   Direct-Access                      ANSI SCSI revision: 02
  Vendor: TOSHIBA   Model: XM-4101TASUNSLCD  Rev: 3424
  Type:   CD-ROM                             ANSI SCSI revision: 02
Attached scsi disk sda at scsi0, channel 0, id 1, lun 0
Attached scsi disk sdb at scsi0, channel 0, id 3, lun 0
esp0: target 1 [period 100ns offset 15 10.00MHz FAST SCSI-II]
SCSI device sda: 2061108 512-byte hdwr sectors (1055 MB)
Partition check:
 sda: sda1 sda2 sda3
esp0: target 3 [period 100ns offset 15 10.00MHz FAST SCSI-II]
SCSI device sdb: 8385121 512-byte hdwr sectors (4293 MB)
 sdb: sdb1
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP
IP: routing cache hash table of 128 buckets, 6Kbytes
TCP: Hash tables configured (established 2048 bind 10922)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
VFS: Mounted root (ext2 filesystem) readonly.
Freeing unused kernel memory: 148k freed
readlink[12]: Unimplemented SPARC system call 188
S02mountvirtfs[11]: Unimplemented SPARC system call 188
touch[13]: Unimplemented SPARC system call 188
mountpoint[14]: Unimplemented SPARC system call 188
mount[15]: Unimplemented SPARC system call 188
grep[16]: Unimplemented SPARC system call 188
Adding Swap: 50896k swap-space (priority -1)
eth0: Carrier Lost, trying TPE
Warning: Remapping obsolete /dev/fb* minor 32 to 1
Warning: Remapping obsolete /dev/fb* minor 64 to 2
Warning: Remapping obsolete /dev/fb* minor 96 to 3
Warning: Remapping obsolete /dev/fb* minor 128 to 4
Warning: Remapping obsolete /dev/fb* minor 160 to 5
Warning: Remapping obsolete /dev/fb* minor 192 to 6
Warning: Remapping obsolete /dev/fb* minor 224 to 7
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.19, 19 August 2002 on sd(8,17), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
I've since remade my '/dev/fd?' files so that the warning above
should go away. One thing I notice is the different output that
show up for the ttyS? devices - in the 2.6 kernel the first
two are 'zs2' and 'zs3' and then 'ttyS0' and 'ttyS1' appear.
In 2.4 there are four 'ttyS?' devices.

Any advice or configuration tips would be greatly welcomed. Thanks
in advance.

Art Haas
--=20
Man once surrendering his reason, has no remaining guard against absurdities
the most monstrous, and like a ship without rudder, is the sport of every w=
ind.

-Thomas Jefferson to James Smith, 1822
