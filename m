From: Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>
Date: Tue, 06 Feb 2007 15:32:25 +0000
Subject: Linux Kernel Markers : sparc build issue
Message-Id: <20070206153225.GA13251@Krystal>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org

Hi,

I am currently testing the Linux Kernel Markers against multiple
architectures and sparc seems to be problematic.

I get the following linker error when building the kernel.
gcc 4.1.1, binutils 2.16.1. With the same config, but markers
desactivated, it links fine.

It is using the asm-generic/marker.h "generic" flavor of markers :

/*
 * marker.h
 *
 * Code markup for dynamic and static tracing. Generic header.
 *=20
 * This file is released under the GPLv2.
 * See the file COPYING for more details.
 *
 * Note : the empty asm volatile with read constraint is used here instead =
of a
 * "used" attribute to fix a gcc 4.1.x bug.
 */

#ifdef CONFIG_MARKERS

#define GEN_MARK(name, format, args...) \
	do { \
		static marker_probe_func *__mark_call_##name =3D \
					__mark_empty_function; \
		static char __marker_enable_##name =3D 0; \
		static const struct __mark_marker_c __mark_c_##name \
			__attribute__((section(".markers.c"))) =3D \
			{ #name, &__mark_call_##name, format, \
			MARKER_GENERIC } ; \
		static const struct __mark_marker __mark_##name \
			__attribute__((section(".markers"))) =3D \
			{ &__mark_c_##name, &__marker_enable_##name } ; \
		asm volatile ( "" : : "i" (&__mark_##name)); \
		__mark_check_format(format, ## args); \
		if (unlikely(__marker_enable_##name)) { \
			preempt_disable(); \
			(*__mark_call_##name)(format, ## args); \
			preempt_enable(); \
		} \
	} while (0)


#define GEN_MARK_ENABLE_IMMEDIATE_OFFSET 0
#define GEN_MARK_ENABLE_TYPE char

#endif

Any insight ?

Thanks,

Mathieu



Here is the link error :

.....
make -f /home/compudj/git/linux-2.6-lttng/scripts/Makefile.build obj=3Darch=
/sparc/boot arch/sparc/boot/image
  gcc -Wp,-MD,arch/sparc/boot/.btfixupprep.d -Iarch/sparc/boot -Wall -Wstri=
ct-prototypes -O2 -fomit-frame-pointer -o arch/sparc/boot/btfixupprep /home=
/compudj/git/linux-2.6-lttng/arch/sparc/boot/btfixupprep.c =20
  /opt/crosstool/gcc-4.1.1-glibc-2.3.6/sparc-unknown-linux-gnu/bin/sparc-un=
known-linux-gnu-objdump -x vmlinux | arch/sparc/boot/btfixupprep > arch/spa=
rc/boot/btfix.S
  /opt/crosstool/gcc-4.1.1-glibc-2.3.6/sparc-unknown-linux-gnu/bin/sparc-un=
known-linux-gnu-gcc -Wp,-MD,arch/sparc/boot/.btfix.o.d  -nostdinc -isystem =
/opt/crosstool/gcc-4.1.1-glibc-2.3.6/sparc-unknown-linux-gnu/lib/gcc/sparc-=
unknown-linux-gnu/4.1.1/include -D__KERNEL__ -Iinclude -Iinclude2 -I/home/c=
ompudj/git/linux-2.6-lttng/include -include include/linux/autoconf.h -inclu=
de linux/marker.h -D__ASSEMBLY__ -m32  -c -o arch/sparc/boot/btfix.o arch/s=
parc/boot/btfix.S
  /opt/crosstool/gcc-4.1.1-glibc-2.3.6/sparc-unknown-linux-gnu/bin/sparc-un=
known-linux-gnu-ld -m elf32_sparc  -T arch/sparc/kernel/vmlinux.lds arch/sp=
arc/kernel/head.o arch/sparc/kernel/init_task.o  init/built-in.o --start-gr=
oup  usr/built-in.o  arch/sparc/kernel/built-in.o  arch/sparc/mm/built-in.o=
  arch/sparc/math-emu/built-in.o  kernel/built-in.o  mm/built-in.o  fs/buil=
t-in.o  ipc/built-in.o  security/built-in.o  crypto/built-in.o  block/built=
-in.o  lib/lib.a  arch/sparc/prom/lib.a  arch/sparc/lib/lib.a  lib/built-in=
.o  arch/sparc/prom/built-in.o  arch/sparc/lib/built-in.o  drivers/built-in=
.o  sound/built-in.o  net/built-in.o --end-group .tmp_kallsyms3.o arch/spar=
c/boot/btfix.o -o arch/sparc/boot/image
.tmp_kallsyms3.o: In function `kallsyms_addresses':
.tmp_kallsyms3.S:(.rodata+0x0): relocation truncated to fit: R_SPARC_32 aga=
inst symbol `_text' defined in .text section in arch/sparc/boot/image
.tmp_kallsyms3.S:(.rodata+0x8): relocation truncated to fit: R_SPARC_32 aga=
inst symbol `_text' defined in .text section in arch/sparc/boot/image
.tmp_kallsyms3.S:(.rodata+0xc): relocation truncated to fit: R_SPARC_32 aga=
inst symbol `_text' defined in .text section in arch/sparc/boot/image
.tmp_kallsyms3.S:(.rodata+0x10): relocation truncated to fit: R_SPARC_32 ag=
ainst symbol `_text' defined in .text section in arch/sparc/boot/image
.tmp_kallsyms3.S:(.rodata+0x14): relocation truncated to fit: R_SPARC_32 ag=
ainst symbol `_text' defined in .text section in arch/sparc/boot/image
.tmp_kallsyms3.S:(.rodata+0x18): relocation truncated to fit: R_SPARC_32 ag=
ainst symbol `_text' defined in .text section in arch/sparc/boot/image
.tmp_kallsyms3.S:(.rodata+0x1c): relocation truncated to fit: R_SPARC_32 ag=
ainst symbol `_text' defined in .text section in arch/sparc/boot/image
.tmp_kallsyms3.S:(.rodata+0x20): relocation truncated to fit: R_SPARC_32 ag=
ainst symbol `_text' defined in .text section in arch/sparc/boot/image
.tmp_kallsyms3.S:(.rodata+0x24): relocation truncated to fit: R_SPARC_32 ag=
ainst symbol `_text' defined in .text section in arch/sparc/boot/image
.tmp_kallsyms3.S:(.rodata+0x28): relocation truncated to fit: R_SPARC_32 ag=
ainst symbol `_text' defined in .text section in arch/sparc/boot/image
.tmp_kallsyms3.S:(.rodata+0x2c): additional relocation overflows omitted fr=
om the output
make[2]: *** [arch/sparc/boot/image] Error 1
make[1]: *** [image] Error 2
make: *** [_all] Error 2



config used :


#
# Automatically generated make config: don't edit
# Linux kernel version: 2.6.20
# Tue Feb  6 06:15:29 2007
#
CONFIG_MMU=3Dy
CONFIG_HIGHMEM=3Dy
CONFIG_GENERIC_ISA_DMA=3Dy
CONFIG_DEFCONFIG_LIST=3D"/lib/modules/$UNAME_RELEASE/.config"

#
# Code maturity level options
#
CONFIG_EXPERIMENTAL=3Dy
CONFIG_BROKEN_ON_SMP=3Dy
CONFIG_INIT_ENV_ARG_LIMIT2

#
# General setup
#
CONFIG_LOCALVERSION=3D""
CONFIG_LOCALVERSION_AUTO=3Dy
CONFIG_SWAP=3Dy
CONFIG_SYSVIPC=3Dy
# CONFIG_IPC_NS is not set
# CONFIG_POSIX_MQUEUE is not set
# CONFIG_BSD_PROCESS_ACCT is not set
# CONFIG_TASKSTATS is not set
# CONFIG_UTS_NS is not set
# CONFIG_AUDIT is not set
# CONFIG_IKCONFIG is not set
CONFIG_SYSFS_DEPRECATED=3Dy
# CONFIG_RELAY is not set
CONFIG_INITRAMFS_SOURCE=3D""
CONFIG_CC_OPTIMIZE_FOR_SIZE=3Dy
CONFIG_SYSCTL=3Dy
# CONFIG_EMBEDDED is not set
CONFIG_UID16=3Dy
CONFIG_SYSCTL_SYSCALL=3Dy
CONFIG_KALLSYMS=3Dy
CONFIG_KALLSYMS_EXTRA_PASS=3Dy
CONFIG_HOTPLUG=3Dy
CONFIG_PRINTK=3Dy
CONFIG_BUG=3Dy
CONFIG_ELF_CORE=3Dy
CONFIG_BASE_FULL=3Dy
CONFIG_FUTEX=3Dy
CONFIG_EPOLL=3Dy
CONFIG_SHMEM=3Dy
CONFIG_SLAB=3Dy
CONFIG_VM_EVENT_COUNTERS=3Dy
CONFIG_RT_MUTEXES=3Dy
# CONFIG_TINY_SHMEM is not set
CONFIG_BASE_SMALL=3D0
# CONFIG_SLOB is not set

#
# Loadable module support
#
CONFIG_MODULES=3Dy
# CONFIG_MODULE_UNLOAD is not set
CONFIG_MODVERSIONS=3Dy
# CONFIG_MODULE_SRCVERSION_ALL is not set
CONFIG_KMOD=3Dy

#
# Block layer
#
CONFIG_BLOCK=3Dy
# CONFIG_LBD is not set
# CONFIG_BLK_DEV_IO_TRACE is not set
# CONFIG_LSF is not set

#
# IO Schedulers
#
CONFIG_IOSCHED_NOOP=3Dy
CONFIG_IOSCHED_AS=3Dy
CONFIG_IOSCHED_DEADLINE=3Dy
CONFIG_IOSCHED_CFQ=3Dy
# CONFIG_DEFAULT_AS is not set
# CONFIG_DEFAULT_DEADLINE is not set
CONFIG_DEFAULT_CFQ=3Dy
# CONFIG_DEFAULT_NOOP is not set
CONFIG_DEFAULT_IOSCHED=3D"cfq"

#
# General machine setup
#
# CONFIG_SMP is not set
CONFIG_SPARC=3Dy
CONFIG_SPARC32=3Dy
CONFIG_SBUS=3Dy
CONFIG_SBUSCHAR=3Dy
CONFIG_SERIAL_CONSOLE=3Dy
CONFIG_SUN_AUXIO=3Dy
CONFIG_SUN_IO=3Dy
CONFIG_RWSEM_GENERIC_SPINLOCK=3Dy
CONFIG_GENERIC_FIND_NEXT_BIT=3Dy
CONFIG_GENERIC_HWEIGHT=3Dy
CONFIG_GENERIC_CALIBRATE_DELAY=3Dy
CONFIG_ARCH_MAY_HAVE_PC_FDC=3Dy
# CONFIG_ARCH_HAS_ILOG2_U32 is not set
# CONFIG_ARCH_HAS_ILOG2_U64 is not set
CONFIG_SUN_PM=3Dy
# CONFIG_SUN4 is not set
# CONFIG_PCI is not set
CONFIG_SUN_OPENPROMFS=3Dm
# CONFIG_SPARC_LED is not set
CONFIG_BINFMT_ELF=3Dy
CONFIG_BINFMT_AOUT=3Dy
CONFIG_BINFMT_MISC=3Dm
CONFIG_SUNOS_EMUL=3Dy
CONFIG_SELECT_MEMORY_MODEL=3Dy
CONFIG_FLATMEM_MANUAL=3Dy
# CONFIG_DISCONTIGMEM_MANUAL is not set
# CONFIG_SPARSEMEM_MANUAL is not set
CONFIG_FLATMEM=3Dy
CONFIG_FLAT_NODE_MEM_MAP=3Dy
# CONFIG_SPARSEMEM_STATIC is not set
CONFIG_SPLIT_PTLOCK_CPUS=3D4
# CONFIG_RESOURCES_64BIT is not set

#
# Networking
#
CONFIG_NET=3Dy

#
# Networking options
#
# CONFIG_NETDEBUG is not set
CONFIG_PACKET=3Dy
# CONFIG_PACKET_MMAP is not set
CONFIG_UNIX=3Dy
CONFIG_XFRM=3Dy
# CONFIG_XFRM_USER is not set
# CONFIG_XFRM_SUB_POLICY is not set
# CONFIG_NET_KEY is not set
CONFIG_INET=3Dy
# CONFIG_IP_MULTICAST is not set
# CONFIG_IP_ADVANCED_ROUTER is not set
CONFIG_IP_FIB_HASH=3Dy
# CONFIG_IP_PNP is not set
# CONFIG_NET_IPIP is not set
# CONFIG_NET_IPGRE is not set
# CONFIG_ARPD is not set
# CONFIG_SYN_COOKIES is not set
# CONFIG_INET_AH is not set
# CONFIG_INET_ESP is not set
# CONFIG_INET_IPCOMP is not set
# CONFIG_INET_XFRM_TUNNEL is not set
# CONFIG_INET_TUNNEL is not set
CONFIG_INET_XFRM_MODE_TRANSPORT=3Dy
CONFIG_INET_XFRM_MODE_TUNNEL=3Dy
CONFIG_INET_XFRM_MODE_BEET=3Dy
CONFIG_INET_DIAG=3Dy
CONFIG_INET_TCP_DIAG=3Dy
# CONFIG_TCP_CONG_ADVANCED is not set
CONFIG_TCP_CONG_CUBIC=3Dy
CONFIG_DEFAULT_TCP_CONG=3D"cubic"
# CONFIG_TCP_MD5SIG is not set
CONFIG_IPV6=3Dm
# CONFIG_IPV6_PRIVACY is not set
# CONFIG_IPV6_ROUTER_PREF is not set
# CONFIG_INET6_AH is not set
# CONFIG_INET6_ESP is not set
# CONFIG_INET6_IPCOMP is not set
# CONFIG_IPV6_MIP6 is not set
# CONFIG_INET6_XFRM_TUNNEL is not set
# CONFIG_INET6_TUNNEL is not set
CONFIG_INET6_XFRM_MODE_TRANSPORT=3Dm
CONFIG_INET6_XFRM_MODE_TUNNEL=3Dm
CONFIG_INET6_XFRM_MODE_BEET=3Dm
# CONFIG_INET6_XFRM_MODE_ROUTEOPTIMIZATION is not set
CONFIG_IPV6_SIT=3Dm
# CONFIG_IPV6_TUNNEL is not set
# CONFIG_IPV6_MULTIPLE_TABLES is not set
# CONFIG_NETWORK_SECMARK is not set
# CONFIG_NETFILTER is not set

#
# DCCP Configuration (EXPERIMENTAL)
#
# CONFIG_IP_DCCP is not set

#
# SCTP Configuration (EXPERIMENTAL)
#
# CONFIG_IP_SCTP is not set

#
# TIPC Configuration (EXPERIMENTAL)
#
# CONFIG_TIPC is not set
# CONFIG_ATM is not set
# CONFIG_BRIDGE is not set
# CONFIG_VLAN_8021Q is not set
CONFIG_DECNET=3Dm
# CONFIG_DECNET_ROUTER is not set
CONFIG_LLC=3Dm
# CONFIG_LLC2 is not set
CONFIG_IPX=3Dm
# CONFIG_IPX_INTERN is not set
CONFIG_ATALK=3Dm
# CONFIG_DEV_APPLETALK is not set
# CONFIG_X25 is not set
# CONFIG_LAPB is not set
# CONFIG_ECONET is not set
# CONFIG_WAN_ROUTER is not set

#
# QoS and/or fair queueing
#
# CONFIG_NET_SCHED is not set

#
# Network testing
#
CONFIG_NET_PKTGEN=3Dm
# CONFIG_HAMRADIO is not set
# CONFIG_IRDA is not set
# CONFIG_BT is not set
# CONFIG_IEEE80211 is not set

#
# Device Drivers
#

#
# Generic Driver Options
#
CONFIG_STANDALONE=3Dy
CONFIG_PREVENT_FIRMWARE_BUILD=3Dy
# CONFIG_FW_LOADER is not set
# CONFIG_SYS_HYPERVISOR is not set

#
# Connector - unified userspace <-> kernelspace linker
#
# CONFIG_CONNECTOR is not set

#
# Memory Technology Devices (MTD)
#
# CONFIG_MTD is not set

#
# Parallel port support
#
# CONFIG_PARPORT is not set

#
# Plug and Play support
#

#
# Block devices
#
CONFIG_BLK_DEV_FD=3Dy
# CONFIG_BLK_DEV_COW_COMMON is not set
CONFIG_BLK_DEV_LOOP=3Dm
# CONFIG_BLK_DEV_CRYPTOLOOP is not set
CONFIG_BLK_DEV_NBD=3Dm
CONFIG_BLK_DEV_RAM=3Dy
CONFIG_BLK_DEV_RAM_COUNT=16
CONFIG_BLK_DEV_RAM_SIZE@96
CONFIG_BLK_DEV_RAM_BLOCKSIZE=1024
CONFIG_BLK_DEV_INITRD=3Dy
# CONFIG_CDROM_PKTCDVD is not set
# CONFIG_ATA_OVER_ETH is not set

#
# Misc devices
#
# CONFIG_TIFM_CORE is not set

#
# ATA/ATAPI/MFM/RLL support
#
# CONFIG_IDE is not set

#
# SCSI device support
#
# CONFIG_RAID_ATTRS is not set
CONFIG_SCSI=3Dy
# CONFIG_SCSI_TGT is not set
# CONFIG_SCSI_NETLINK is not set
CONFIG_SCSI_PROC_FS=3Dy

#
# SCSI support type (disk, tape, CD-ROM)
#
CONFIG_BLK_DEV_SD=3Dy
CONFIG_CHR_DEV_ST=3Dy
# CONFIG_CHR_DEV_OSST is not set
CONFIG_BLK_DEV_SR=3Dy
CONFIG_BLK_DEV_SR_VENDOR=3Dy
CONFIG_CHR_DEV_SG=3Dm
# CONFIG_CHR_DEV_SCH is not set

#
# Some SCSI devices (e.g. CD jukebox) support multiple LUNs
#
CONFIG_SCSI_MULTI_LUN=3Dy
CONFIG_SCSI_CONSTANTS=3Dy
# CONFIG_SCSI_LOGGING is not set
# CONFIG_SCSI_SCAN_ASYNC is not set

#
# SCSI Transports
#
# CONFIG_SCSI_SPI_ATTRS is not set
# CONFIG_SCSI_FC_ATTRS is not set
# CONFIG_SCSI_ISCSI_ATTRS is not set
# CONFIG_SCSI_SAS_ATTRS is not set
# CONFIG_SCSI_SAS_LIBSAS is not set

#
# SCSI low-level drivers
#
# CONFIG_ISCSI_TCP is not set
CONFIG_SCSI_QLOGICPTI=3Dm
# CONFIG_SCSI_DEBUG is not set
CONFIG_SCSI_SUNESP=3Dy

#
# Serial ATA (prod) and Parallel ATA (experimental) drivers
#
# CONFIG_ATA is not set

#
# Multi-device support (RAID and LVM)
#
# CONFIG_MD is not set

#
# Fusion MPT device support
#
# CONFIG_FUSION is not set

#
# IEEE 1394 (FireWire) support
#

#
# I2O device support
#

#
# Network device support
#
CONFIG_NETDEVICES=3Dy
CONFIG_DUMMY=3Dm
CONFIG_BONDING=3Dm
# CONFIG_EQUALIZER is not set
# CONFIG_TUN is not set

#
# PHY device support
#

#
# Ethernet (10 or 100Mbit)
#
# CONFIG_NET_ETHERNET is not set

#
# Ethernet (1000 Mbit)
#
CONFIG_MYRI_SBUS=3Dm

#
# Ethernet (10000 Mbit)
#

#
# Token Ring devices
#

#
# Wireless LAN (non-hamradio)
#
# CONFIG_NET_RADIO is not set

#
# Wan interfaces
#
# CONFIG_WAN is not set
CONFIG_PPP=3Dm
# CONFIG_PPP_MULTILINK is not set
# CONFIG_PPP_FILTER is not set
CONFIG_PPP_ASYNC=3Dm
CONFIG_PPP_SYNC_TTY=3Dm
CONFIG_PPP_DEFLATE=3Dm
CONFIG_PPP_BSDCOMP=3Dm
# CONFIG_PPP_MPPE is not set
CONFIG_PPPOE=3Dm
CONFIG_SLIP=3Dm
CONFIG_SLIP_COMPRESSED=3Dy
CONFIG_SLHC=3Dm
CONFIG_SLIP_SMART=3Dy
# CONFIG_SLIP_MODE_SLIP6 is not set
# CONFIG_SHAPER is not set
# CONFIG_NETCONSOLE is not set
# CONFIG_NETPOLL is not set
# CONFIG_NET_POLL_CONTROLLER is not set

#
# ISDN subsystem
#
# CONFIG_ISDN is not set

#
# Telephony Support
#
# CONFIG_PHONE is not set

#
# Input device support
#
CONFIG_INPUT=3Dy
# CONFIG_INPUT_FF_MEMLESS is not set

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
# Input Device Drivers
#
CONFIG_INPUT_KEYBOARD=3Dy
CONFIG_KEYBOARD_ATKBD=3Dy
# CONFIG_KEYBOARD_SUNKBD is not set
# CONFIG_KEYBOARD_LKKBD is not set
# CONFIG_KEYBOARD_XTKBD is not set
# CONFIG_KEYBOARD_NEWTON is not set
# CONFIG_KEYBOARD_STOWAWAY is not set
CONFIG_INPUT_MOUSE=3Dy
CONFIG_MOUSE_PS2=3Dy
# CONFIG_MOUSE_SERIAL is not set
# CONFIG_MOUSE_VSXXXAA is not set
# CONFIG_INPUT_JOYSTICK is not set
# CONFIG_INPUT_TOUCHSCREEN is not set
# CONFIG_INPUT_MISC is not set

#
# Hardware I/O ports
#
CONFIG_SERIO=3Dy
CONFIG_SERIO_I8042=3Dy
CONFIG_SERIO_SERPORT=3Dy
CONFIG_SERIO_LIBPS2=3Dy
# CONFIG_SERIO_RAW is not set
# CONFIG_GAMEPORT is not set

#
# Character devices
#
CONFIG_VT=3Dy
CONFIG_VT_CONSOLE=3Dy
CONFIG_HW_CONSOLE=3Dy
# CONFIG_VT_HW_CONSOLE_BINDING is not set
# CONFIG_SERIAL_NONSTANDARD is not set

#
# Serial drivers
#

#
# Non-8250 serial port support
#
CONFIG_SERIAL_SUNCORE=3Dy
# CONFIG_SERIAL_SUNZILOG is not set
CONFIG_SERIAL_CORE=3Dy
CONFIG_SERIAL_CORE_CONSOLE=3Dy
CONFIG_UNIX98_PTYS=3Dy
CONFIG_LEGACY_PTYS=3Dy
CONFIG_LEGACY_PTY_COUNT%6

#
# IPMI
#
# CONFIG_IPMI_HANDLER is not set

#
# Watchdog Cards
#
# CONFIG_WATCHDOG is not set
CONFIG_HW_RANDOM=3Dm
# CONFIG_DTLK is not set
# CONFIG_R3964 is not set
# CONFIG_RAW_DRIVER is not set

#
# TPM devices
#
# CONFIG_TCG_TPM is not set

#
# I2C support
#
# CONFIG_I2C is not set

#
# SPI support
#
# CONFIG_SPI is not set
# CONFIG_SPI_MASTER is not set

#
# Dallas's 1-wire bus
#
# CONFIG_W1 is not set

#
# Hardware Monitoring support
#
CONFIG_HWMON=3Dy
# CONFIG_HWMON_VID is not set
# CONFIG_SENSORS_ABITUGURU is not set
# CONFIG_SENSORS_F71805F is not set
# CONFIG_SENSORS_PC87427 is not set
# CONFIG_SENSORS_VT1211 is not set
# CONFIG_HWMON_DEBUG_CHIP is not set

#
# Multimedia devices
#
# CONFIG_VIDEO_DEV is not set

#
# Digital Video Broadcasting Devices
#
# CONFIG_DVB is not set

#
# Graphics support
#
CONFIG_FIRMWARE_EDID=3Dy
CONFIG_FB=3Dy
CONFIG_FB_CFB_FILLRECT=3Dy
CONFIG_FB_CFB_COPYAREA=3Dy
CONFIG_FB_CFB_IMAGEBLIT=3Dy
# CONFIG_FB_MACMODES is not set
# CONFIG_FB_BACKLIGHT is not set
# CONFIG_FB_MODE_HELPERS is not set
# CONFIG_FB_TILEBLITTING is not set
CONFIG_FB_SBUS=3Dy
# CONFIG_FB_BW2 is not set
# CONFIG_FB_CG3 is not set
# CONFIG_FB_CG6 is not set
# CONFIG_FB_S1D13XXX is not set
CONFIG_FB_TCX=3Dy
# CONFIG_FB_CG14 is not set
# CONFIG_FB_P9100 is not set
CONFIG_FB_LEO=3Dy
# CONFIG_FB_VIRTUAL is not set

#
# Console display driver support
#
CONFIG_PROM_CONSOLE=3Dy
CONFIG_DUMMY_CONSOLE=3Dy
# CONFIG_FRAMEBUFFER_CONSOLE is not set

#
# Logo configuration
#
# CONFIG_LOGO is not set
# CONFIG_BACKLIGHT_LCD_SUPPORT is not set

#
# Sound
#
# CONFIG_SOUND is not set

#
# HID Devices
#
CONFIG_HID=3Dy

#
# USB support
#
# CONFIG_USB_ARCH_HAS_HCD is not set
# CONFIG_USB_ARCH_HAS_OHCI is not set
# CONFIG_USB_ARCH_HAS_EHCI is not set

#
# NOTE: USB_STORAGE enables SCSI, and 'SCSI disk support'
#

#
# USB Gadget Support
#
# CONFIG_USB_GADGET is not set

#
# MMC/SD Card support
#
# CONFIG_MMC is not set

#
# LED devices
#
# CONFIG_NEW_LEDS is not set

#
# LED drivers
#

#
# LED Triggers
#

#
# InfiniBand support
#

#
# EDAC - error detection and reporting (RAS) (EXPERIMENTAL)
#

#
# Real Time Clock
#
# CONFIG_RTC_CLASS is not set

#
# DMA Engine support
#
# CONFIG_DMA_ENGINE is not set

#
# DMA Clients
#

#
# DMA Devices
#

#
# Virtualization
#

#
# Misc Linux/SPARC drivers
#
CONFIG_SUN_OPENPROMIO=3Dm
CONFIG_SUN_MOSTEK_RTC=3Dy
# CONFIG_SUN_BPP is not set
# CONFIG_SUN_VIDEOPIX is not set
# CONFIG_TADPOLE_TS102_UCTRL is not set
# CONFIG_SUN_JSFLASH is not set

#
# Unix98 PTY support
#
CONFIG_UNIX98_PTY_COUNT%6

#
# File systems
#
CONFIG_EXT2_FS=3Dy
# CONFIG_EXT2_FS_XATTR is not set
# CONFIG_EXT2_FS_XIP is not set
CONFIG_EXT3_FS=3Dm
CONFIG_EXT3_FS_XATTR=3Dy
# CONFIG_EXT3_FS_POSIX_ACL is not set
# CONFIG_EXT3_FS_SECURITY is not set
# CONFIG_EXT4DEV_FS is not set
CONFIG_JBD=3Dm
# CONFIG_JBD_DEBUG is not set
CONFIG_FS_MBCACHE=3Dy
# CONFIG_REISERFS_FS is not set
# CONFIG_JFS_FS is not set
# CONFIG_FS_POSIX_ACL is not set
# CONFIG_XFS_FS is not set
# CONFIG_GFS2_FS is not set
# CONFIG_OCFS2_FS is not set
CONFIG_MINIX_FS=3Dm
CONFIG_ROMFS_FS=3Dm
CONFIG_INOTIFY=3Dy
CONFIG_INOTIFY_USER=3Dy
# CONFIG_QUOTA is not set
CONFIG_DNOTIFY=3Dy
CONFIG_AUTOFS_FS=3Dm
CONFIG_AUTOFS4_FS=3Dm
# CONFIG_FUSE_FS is not set

#
# CD-ROM/DVD Filesystems
#
CONFIG_ISO9660_FS=3Dm
# CONFIG_JOLIET is not set
# CONFIG_ZISOFS is not set
# CONFIG_UDF_FS is not set

#
# DOS/FAT/NT Filesystems
#
CONFIG_FAT_FS=3Dm
CONFIG_MSDOS_FS=3Dm
CONFIG_VFAT_FS=3Dm
CONFIG_FAT_DEFAULT_CODEPAGEC7
CONFIG_FAT_DEFAULT_IOCHARSET=3D"iso8859-1"
# CONFIG_NTFS_FS is not set

#
# Pseudo filesystems
#
CONFIG_PROC_FS=3Dy
# CONFIG_PROC_KCORE is not set
CONFIG_PROC_SYSCTL=3Dy
CONFIG_SYSFS=3Dy
# CONFIG_TMPFS is not set
# CONFIG_HUGETLB_PAGE is not set
CONFIG_RAMFS=3Dy
# CONFIG_CONFIGFS_FS is not set

#
# Miscellaneous filesystems
#
# CONFIG_ADFS_FS is not set
CONFIG_AFFS_FS=3Dm
# CONFIG_HFS_FS is not set
# CONFIG_HFSPLUS_FS is not set
# CONFIG_BEFS_FS is not set
# CONFIG_BFS_FS is not set
CONFIG_EFS_FS=3Dm
# CONFIG_CRAMFS is not set
# CONFIG_VXFS_FS is not set
CONFIG_HPFS_FS=3Dm
# CONFIG_QNX4FS_FS is not set
CONFIG_SYSV_FS=3Dm
CONFIG_UFS_FS=3Dm
# CONFIG_UFS_FS_WRITE is not set
# CONFIG_UFS_DEBUG is not set

#
# Network File Systems
#
CONFIG_NFS_FS=3Dy
# CONFIG_NFS_V3 is not set
# CONFIG_NFS_V4 is not set
# CONFIG_NFS_DIRECTIO is not set
CONFIG_NFSD=3Dm
# CONFIG_NFSD_V3 is not set
CONFIG_NFSD_TCP=3Dy
CONFIG_LOCKD=3Dy
CONFIG_EXPORTFS=3Dm
CONFIG_NFS_COMMON=3Dy
CONFIG_SUNRPC=3Dy
# CONFIG_RPCSEC_GSS_KRB5 is not set
# CONFIG_RPCSEC_GSS_SPKM3 is not set
CONFIG_SMB_FS=3Dm
# CONFIG_SMB_NLS_DEFAULT is not set
# CONFIG_CIFS is not set
# CONFIG_NCP_FS is not set
CONFIG_CODA_FS=3Dm
# CONFIG_CODA_FS_OLD_API is not set
# CONFIG_AFS_FS is not set
# CONFIG_9P_FS is not set

#
# Partition Types
#
# CONFIG_PARTITION_ADVANCED is not set
CONFIG_MSDOS_PARTITION=3Dy
CONFIG_SUN_PARTITION=3Dy

#
# Native Language Support
#
CONFIG_NLS=3Dy
CONFIG_NLS_DEFAULT=3D"iso8859-1"
# CONFIG_NLS_CODEPAGE_437 is not set
# CONFIG_NLS_CODEPAGE_737 is not set
# CONFIG_NLS_CODEPAGE_775 is not set
# CONFIG_NLS_CODEPAGE_850 is not set
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
# CONFIG_NLS_ASCII is not set
# CONFIG_NLS_ISO8859_1 is not set
# CONFIG_NLS_ISO8859_2 is not set
# CONFIG_NLS_ISO8859_3 is not set
# CONFIG_NLS_ISO8859_4 is not set
# CONFIG_NLS_ISO8859_5 is not set
# CONFIG_NLS_ISO8859_6 is not set
# CONFIG_NLS_ISO8859_7 is not set
# CONFIG_NLS_ISO8859_9 is not set
# CONFIG_NLS_ISO8859_13 is not set
# CONFIG_NLS_ISO8859_14 is not set
# CONFIG_NLS_ISO8859_15 is not set
# CONFIG_NLS_KOI8_R is not set
# CONFIG_NLS_KOI8_U is not set
# CONFIG_NLS_UTF8 is not set

#
# Distributed Lock Manager
#
# CONFIG_DLM is not set

#
# Instrumentation Support
#
# CONFIG_PROFILING is not set
CONFIG_MARKERS=3Dy
CONFIG_MARKERS_ENABLE_OPTIMIZATION=3Dy
# CONFIG_LTT is not set

#
# Kernel hacking
#
# CONFIG_PRINTK_TIME is not set
CONFIG_ENABLE_MUST_CHECK=3Dy
# CONFIG_MAGIC_SYSRQ is not set
# CONFIG_UNUSED_SYMBOLS is not set
# CONFIG_DEBUG_FS is not set
# CONFIG_HEADERS_CHECK is not set
# CONFIG_DEBUG_KERNEL is not set
CONFIG_LOG_BUF_SHIFT=14
CONFIG_DEBUG_BUGVERBOSE=3Dy

#
# Security options
#
# CONFIG_KEYS is not set
# CONFIG_SECURITY is not set

#
# Cryptographic options
#
# CONFIG_CRYPTO is not set

#
# Library routines
#
CONFIG_BITREVERSE=3Dy
CONFIG_CRC_CCITT=3Dm
# CONFIG_CRC16 is not set
CONFIG_CRC32=3Dy
# CONFIG_LIBCRC32C is not set
CONFIG_ZLIB_INFLATE=3Dm
CONFIG_ZLIB_DEFLATE=3Dm
CONFIG_PLIST=3Dy
CONFIG_IOMAP_COPY=3Dy
--=20
Mathieu Desnoyers
Computer Engineering Graduate Student, =C9cole Polytechnique de Montr=E9al
OpenPGP key fingerprint: 8CD5 52C3 8E3C 4140 715F  BA06 3F25 A8FE 3BAE 9A68
