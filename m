From: Meelis Roos <mroos@linux.ee>
Date: Fri, 02 Apr 2004 11:12:26 +0000
Subject: serial console confusion
Message-Id: <Pine.GSO.4.44.0404021400470.23192-100000@math.ut.ee>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

I am seriously confused about the serial console on Ultra 5.

Short story: null modem cable, PROM is OK via serial console but there
is no serial console for Linux kernel (2.6.5-rc3 but I tried 2.4.26-rc1
too).

I use console=ttyS0,9600 boot parameter but it seems to have no effect.

When I compile PROM conole in, I get pages of spaces instead of kernel
messages (like it would clear screen) and userspace messages appear on
serial console (beginning with INIT 2.85 booting etc).

With no PROM console, sun su & sun su console, I get the dmesg that is
below. Where should I dig? Is serial console on su serial ports working
for others?

I have recently upgraded the PROM on my U5 in hopes of slightly wider
ATI Mach 64 PCI card support (but it didn't help), this might be
related.

PROMLIB: Sun IEEE Boot Prom 3.31.0 2001/07/25 20:36
Linux version 2.6.5-rc3 (mroos@mandariin) (gcc version 3.3.3 (Debian 20040321)) #53 Fri Apr 2 13:25:47 EEST 2004
ARCH: SUN4U
Ethernet address: 08:00:20:f8:c7:72
On node 0 totalpages: 40446
  DMA zone: 40446 pages, LIFO batch:8
  Normal zone: 0 pages, LIFO batch:1
  HighMem zone: 0 pages, LIFO batch:1
Built 1 zonelists
Kernel command line: root=/dev/hda1 ro console=ttyS0,9600
PID hash table entries: 2048 (order 11: 32768 bytes)
Console: colour dummy device 80x25
Memory: 317440k available (2000k kernel code, 808k data, 136k init) [fffff80000000000,000000001ff3e000]
Calibrating delay loop... 719.25 BogoMIPS
Security Scaffold v1.0.0 initialized
Capability LSM initialized
Dentry cache hash table entries: 65536 (order: 6, 524288 bytes)
Inode-cache hash table entries: 32768 (order: 5, 262144 bytes)
Mount-cache hash table entries: 512 (order: 0, 8192 bytes)
POSIX conformance testing by UNIFIX
NET: Registered protocol family 16
PCI: Probing for controllers.
PCI: Found SABRE, main regs at 000001fe00000000, wsync at 000001fe00001c20
SABRE: Shared PCI config space at 000001fe01000000
SABRE: DVMA at c0000000 [20000000]
PCI-IRQ: Routing bus[ 2] slot[ 1] map[0] to INO[10]
PCI-IRQ: Routing bus[ 2] slot[ 2] map[0] to INO[14]
PCI-IRQ: Routing bus[ 2] slot[ 3] map[0] to INO[18]
PCI0(PBMA): Bus running at 33MHz
PCI-IRQ: Routing bus[ 1] slot[ 1] map[0] to INO[21]
PCI-IRQ: Routing bus[ 1] slot[ 2] map[0] to INO[0f]
PCI-IRQ: Routing bus[ 1] slot[ 3] map[0] to INO[20]
PCI0(PBMB): Bus running at 33MHz
ebus0: [auxio] [power] [SUNW,pll] [se] [su] [su] [ecpp] [fdthree] [eeprom] [flashprom] [SUNW,CS4231]
power: Control reg at 000001fff1724000 ... powerd running.
ikconfig 0.7 with /proc/config*
Initializing Cryptographic API
rtc_init: no PC rtc found
su0 at 0x000001fff13062f8 (irq = 4,7ea) is a 16550A
su1 at 0x000001fff13083f8 (irq = 9,7e9) is a 16550A
Using anticipatory io scheduler
Floppy drive(s): fd0 is 1.44M
FDC 0 is a National Semiconductor PC87306
sunhme.c:v2.02 24/Aug/2003 David S. Miller (davem@redhat.com)
divert: allocating divert_blk for eth0
eth0: HAPPY MEAL (PCI/CheerIO) 10/100BaseT Ethernet 08:00:20:f8:c7:72
divert: not allocating divert_blk for non-ethernet device lo
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
CMD646: IDE controller at PCI slot 0000:01:03.0
CMD646: chipset revision 3
CMD646: chipset revision 0x03, MultiWord DMA Force Limited
CMD646: 100% native mode on irq 4,7e0
    ide0: BM-DMA at 0x1fe02c00020-0x1fe02c00027, BIOS settings: hda:pio, hdb:pio
    ide1: BM-DMA at 0x1fe02c00028-0x1fe02c0002f, BIOS settings: hdc:pio, hdd:pio
hda: ST38410A, ATA DISK drive
ide0 at 0x1fe02c00000-0x1fe02c00007,0x1fe02c0000a on irq 4,7e0
hdc: CRD-8322B, ATAPI CD/DVD-ROM drive
ide1 at 0x1fe02c00010-0x1fe02c00017,0x1fe02c0001a on irq 4,7e0 (shared with ide0)
hda: max request size: 128KiB
hda: 16841664 sectors (8622 MB) w/512KiB Cache, CHS708/16/63, (U)DMA
 hda: hda1 hda2 hda3
mice: PS/2 mouse device common for all mice
input: Sun Mouse on su/serio0
NET: Registered protocol family 2
IP: routing cache hash table of 4096 buckets, 32Kbytes
TCP: Hash tables configured (established 65536 bind 65536)
NET: Registered protocol family 1
NET: Registered protocol family 17
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Warning: unable to open an initial console.
Adding 944984k swap on /dev/hda2.  Priority:-1 extents:1
EXT3 FS on hda1, internal journal
md: md driver 0.90.0 MAX_MD_DEVS%6, MD_SB_DISKS'
SCSI subsystem initialized
sym0: <875> rev 0x3 at pci 0000:02:01.0 irq 4,7d0
sym0: No NVRAM, ID 7, Fast-20, SE, parity checking
sym0: SCSI BUS has been reset.
scsi0 : sym-2.1.18i
scsi1 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.36
        <Adaptec 2940 Ultra SCSI adapter>
        aic7880: Ultra Wide Channel A, SCSI Id=7, 16/253 SCBs

drivers/usb/core/usb.c: registered new driver usbfs
drivers/usb/core/usb.c: registered new driver hub
ohci_hcd: 2004 Feb 02 USB 1.1 'Open' Host Controller (OHCI) Driver (PCI)
ohci_hcd: block sizes: ed 80 td 96
ohci_hcd 0000:02:02.0: OPTi Inc. 82C861
ohci_hcd 0000:02:02.0: irq 10,7d4, pci mem 000001ff00006000
ohci_hcd 0000:02:02.0: new USB bus registered, assigned bus number 1
ohci_hcd 0000:02:02.0: WARNING: OPTi workarounds unavailable
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 2 ports detected
eth0: Link is up using internal transceiver at 100Mb/s, Full Duplex.
NET: Registered protocol family 15
NET: Registered protocol family 10
Disabled Privacy Extensions on device 000000000068d400(lo)
IPv6 over IPv4 tunneling driver
divert: not allocating divert_blk for non-ethernet device sit0
eth0: no IPv6 routers present
nfs warning: mount version older than kernel

-- 
Meelis Roos (mroos@linux.ee)

